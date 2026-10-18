# HTML5 renderer: architecture

This document describes how the HTML5 rebuild renders the Legend Online BR Flash client: the AS3 client transpiled to TypeScript and its boot path, the offline data pipeline, the Flash runtime on PixiJS, the PickGliss-H5 UI port, the game layer and the screen viewer. The goal is every screen of the original client in TypeScript + PixiJS 8 (WebGL) with maximum fidelity (same styles, positions, fonts, filters and animations). The strategy is to reproduce **the path the game itself takes** instead of hand-building each screen. Asset formats are in [graphics.md](graphics.md); battle flow and scene in [../battle/README.md](../battle/README.md); screens in [../ui/screens.md](../ui/screens.md).

## 0. Current state

The main path is now the **transpiled client** running against the Rust server. The layout/viewer pipeline (§1 to §5) still works and is used to inspect screens in isolation.

```
decompiled AS3 ──(tools/as3)──► web/src/gen-bundles/*.ts ──(build_bundles.mjs)──► web/public/as3/bundles/*.js
                                                                                        │
                       Flash runtime (web/src/as3 + web/src/flash) on PixiJS ◄──────────┘
                                                                                        │
          web/src/boot (?boot=1) ◄──── Vite :5173 ────► Rust server (server/, :8787)
```

### Transpiler (`tools/as3`)

1. `lexer.py` tokenizes the decompiled AS3 (`decompiled/<module>/scripts`).
2. `parse.py` builds classes and members.
3. `index.py` indexes every class per module (`build/as3/index.json` + `build/as3/parsed.pkl`; currently 10 610 classes).
4. `gen.py` drives `emit.py` to write one TypeScript file per class into `build/as3/gen` (currently 10 593 generated, 0 failures, see `build/as3/report.json`), then joins them into one bundle per module in `web/src/gen-bundles` (`Loading.ts`, `core.ts`, `core2.ts`, `common.ts`, `core_module.ts`, `m3.ts` … `m18.ts`) and writes the class → module map `web/public/as3/classmap.json`.
5. `build_bundles.mjs` (run by `gen.py`) minifies each bundle with esbuild into `web/public/as3/bundles/<module>.<md5-8>.js` plus `manifest.json`. The runtime loads bundles on demand through that manifest (`web/src/as3/runtime.ts`).

### Runtime and boot

| part | location | role |
|---|---|---|
| AS3 runtime | `web/src/as3/runtime.ts`, `xml.ts`, `builtins.ts` | class registry, lazy bundle loading (`$.loadBundle`), casts, AS3 globals; `XML`/`XMLList` over `DOMParser`; AS3 extensions of JS built-ins (`Date`, `Array`) |
| Flash API | `web/src/as3/flash/*` | `display`, `events`, `text`, `net`, `geom`, `filters`, `system`, `utils`, `mouse`, `errors`, `amf`, `bytearray`, `dictionary` |
| Flash display core | `web/src/flash/*` | rendering primitives shared with the viewer (§2) |
| Boot | `web/src/boot/Boot.ts` | flashvars (`site` `broas_1264`), maps module SWFs (`2` = `core_module`, `3..18` = `m3..m18`) to bundles, runs the original boot sequence |
| Stage fit | `web/src/boot/Fit.ts` | fits the 1000×600 stage to the window |
| Server | `server/` (Rust, port 8787, `LG_PORT` overrides) | proxied by Vite (`web/vite.config.ts`: `config.xml`, `xml/`, `code_md5.dat`, `res_md5.dat`, `debug/`, `cdn/`, `messagebroker`, login routes and the `/socket` WebSocket) |
| Server rules | `server/flows.json`, `server/flows/battle.json`, `server/flows/navigation.json` | request → response rules per opcode, plus `push:*` triggers |
| Battle engine | `server/src/battle.rs` | real-time battle simulation ([../battle/server-engine.md](../battle/server-engine.md)) |
| Assets | `tools/fetch_assets.py` | the server serves `raw/` and logs misses to `logs/cdn_missing.txt`; `fetch_assets.py missing` downloads them on demand (groups `space`, `mapname`, `castle`, `icons`, `skillname`; `--limit-mb`, `--dry-run`) |

### Entry points (`web/src/main.ts`)

| URL | mode |
|---|---|
| http://localhost:5173/ | screen viewer (§5) |
| http://localhost:5173/?boot=1 | real boot of the transpiled client against the Rust server; `&drive` keeps the ticker running while the tab is hidden |
| `?play` | shell (`web/src/shell`): loads the startup UI libraries/styles and opens frames through `FrameOpener` |
| `#battle:<preset>` | battle renderer preview in the viewer (`web/src/battle`, see [../battle/hud.md](../battle/hud.md)) |

### Reached in `?boot=1`

Login, castle, the **Reino do Céu** space lobby (map 10000, 2D map engine, tiles in `raw/mapmaterial/land/10000`), inventory, guild, mounts (ride/dismount via **8529** `MountEditMsg`) and battles.

**Open items**: validation of campaign, room and arena flows; missing assets (no full CDN mirror, files are fetched on demand).

## 1. Data pipeline (`tools/`, Python)

```
screen AS3 ──(tools/layout.py)──► ops (create/add/set/call)
                                        │
style XML (PickGliss) ─────────────────►│  ComponentFactory (faithful port)
                                        │      │
UI SWF ─(swflib + FFDec)─► library.json + PNG/SVG
                                        ▼      ▼
                     Flash runtime on Pixi (MovieClip/Bitmap/TextField/filters)
                                        ▼
                         viewer (index + stage + inspector)
```

| step | tool | output |
|---|---|---|
| asset export of the 326 UI SWFs | FFDec (`image:png`, `shape:svg`, `text:svg`) | `build/ffdec_ui/<swf>/` |
| frame scripts of UI SWFs | FFDec (`script`) | `build/ffdec_ui_scripts/` |
| timeline/symbols per SWF | `tools/swflib.py` (own parser) | `web/public/lib/<swf>/library.json` |
| library assembly (+ frame scripts) | `tools/h5build.py` | `web/public/lib/` (+ `linkage.json`, `index.json`) |
| morph shapes | `tools/morph.py` (called by `swflib.py`) | inside `library.json` |
| styles, screens, classes | `tools/ui.py` | `index/styles.json`, `index/screens.json`, `index/classes.json` |
| view build operations | `tools/layout.py` | `web/public/layout/<module>.json`, `screens.json`, `class-styles.json`, `web/public/lib/style-index.json` |

Regenerate everything:

```bash
cd tools && python3 map.py && python3 layout.py && python3 h5build.py
```

### `library.json` (per SWF)

| key | content |
|---|---|
| `linkage` | AS3 class name → characterId (`SymbolClass`/`ExportAssets` tags) |
| `chars[id]` | `bitmap {w,h,src}`; `shape`/`text {x,y,w,h,src}` (the SVG origin is at the bounds, so the runtime places it at `(x,y)`); `edit` (DefineEditText: font, size, color, align, margins, text/HTML); `button {records}`; `sprite {frames, labels, timeline, scripts}` |
| `timeline` | list of frames, each with `place`/`remove` ops. A `place` may carry: depth, char, matrix `[a,b,c,d,tx,ty]`, color transform `[mult×4, add×4]`, ratio, name, `clip` (clipDepth), filters (glow, dropShadow, blur, colorMatrix, bevel, gradient*, convolution), blend, cacheAsBitmap, visible |
| `scripts` | the SWF's AS3 frame actions (`stop`, `play`, `gotoAndPlay:N`, `gotoAndStop:N`) |

### Layout operations (`layout/<module>.json`)

For each view class the extractor follows the **constructor** and the own methods it calls (e.g. `initView()`) and turns statements into operations:

```json
{"op":"create","v":"_setBtn","how":"style","name":"abysm.childSetBtn"}
{"op":"add","p":"this","v":"_setBtn","how":"addToContent"}
{"op":"set","v":"_tipsTxt","k":"htmlText","e":["tr","abysm.abysmViewTips01",[]]}
```

Operations inside `if` blocks and loops get `"c":1`: they depend on server data and run only with "conditionals: on" in the viewer. Current numbers: 4 082 views, 66 073 operations, 89% unconditional.

## 2. Flash display core (`web/src/flash/`)

| file | role |
|---|---|
| `library.ts` | `SwfLibrary` (loads `library.json`; textures **on demand**, queue of 16), `BitmapData` (sync dimensions, async texture) and `Domain` (≈ ApplicationDomain: `createInstance`, `registerClass`, global linkage) |
| `bitmapdata.ts` | AS3 `BitmapData` on a canvas texture |
| `display.ts` | `Bitmap`, `Shape`, `MovieClip`, `SimpleButton`, `MorphShape`, `setFlashFilters`, `setColorTransform`, blend |
| `clock.ts` | Flash frame clock (24 fps in UI SWFs), independent of rendering |
| `filters.ts` | filters with Flash semantics: glow/dropShadow (blurred alpha × strength, inner, knockout, hideObject), color transform, color matrix (offsets ÷255), blur |
| `text.ts` | `TextField`/`TextFormat`: 2 px gutter, autoSize, wordWrap, line = ascent + descent + leading, letterSpacing, `htmlText`, 2× canvas |
| `sprite.ts` | `Sprite` with Flash `graphics` (records commands, redraws when the texture arrives) |
| `builtins.ts` | native classes for `<set type=…>` and `ClassUtils`: GlowFilter, DropShadowFilter, BlurFilter, ColorMatrixFilter, TextFormat, Point, Sprite… |
| `events.ts` | Flash `Event`, `TimerEvent`, `MouseEvent`/`KeyboardEvent`/`FocusEvent`/`TextEvent` constants and the Flash → Pixi event type mapping |
| `mode.ts` | `FlashMode` (interactive flag, current renderer) |

**MovieClip behavior:**
- advances incrementally;
- *rewind* replays from frame 1 and **reconciles** instances (same placement = same object, as in Flash Player);
- `clipDepth` becomes a masked container;
- the color transform is applied **after** filters, as in Flash;
- supports labels, `gotoAndStop`/`gotoAndPlay` by number or label, frame scripts and `getChildByName`.

## 3. PickGliss-H5 (`web/src/pickgliss/`)

Faithful port of the game's UI framework.

| part | behavior |
|---|---|
| `ComponentModel` | reads the original XMLs (unpacked `raw/ui/zh_cn/xml/xml.png`) **in attribute order** |
| `ComponentFactory` | `creat`, `creatComponentByStylename`, `creatBitmap`, `creatCustomObject`, `creatFrameFilters`; `parentStyle` resolved with `combineXML` (child wins); `preload()` follows references to load only the needed XMLs and SWFs |
| `ObjectUtils.copyPorpertiesByXML` | converts types explicitly (AS3 does this through typed setters) |
| `core/Component` | `beginChanges`/`commitChanges` → `draw` cycle; logical width/height |
| `image/*` | Image, ScaleBitmapImage (9-slice), MutipleImage (`imageRectString` + `InnerRectangle`), ScaleFrameImage, Scale9CornerImage, ScaleLeftRightImage, ScaleUpDownImage, MovieImage |
| `text/FilterFrameText` | per-frame formats and filters, autoDisplay |
| `controls/*` | buttons, Frame, alerts, HBox/VBox/SimpleTileList, ScrollPanel/Scrollbar, ListPanel, ComboBox, TextInput, TextArea, GradientText… |

## 4. Game layer (`web/src/game/`)

| part | behavior |
|---|---|
| `LanguageMgr` | pt-BR `language.txt`, with `GetTranslation(key, …args)` |
| `GameClasses` | each game view becomes a **dynamic subclass of its real base** (Frame, Component, Sprite or another game view). The constructor runs the operations extracted by the real factory; subviews (`new X()`) resolve recursively |
| `openScreen(cls)` | opens the screen the way the game does, i.e. `creatComponentByStylename(<class style>)`; without a style, instantiates the class |

## 5. Viewer (`web/src/viewer/`)

| area | features |
|---|---|
| Index | 1 097 screens (frames, scenes, tips) with pt-BR title, module, size and search |
| Stage | scales to fit and animates on the Flash clock; buttons: pause, +1 frame, conditionals, bounds |
| Inspector | display tree with the AS3 field (`_setBtn`), class and source style of each node; node properties and style XML attributes; operation log with failures |

| shortcut | effect |
|---|---|
| Alt+click on the stage | selects an element |
| `?view=stage` | shows only the stage |
| `#<class>` | opens a screen directly (e.g. `#abysm.AbysmFrame`) |
| `#sym:<class>` | opens any exported symbol in isolation (animations, bitmaps, buttons) |
| `?triage=1` | opens every screen in sequence and aggregates failures by cause (`window.__triage`) |

```bash
npm --prefix web install
npm --prefix web run dev
```

The viewer opens at http://localhost:5173.

## 6. Known issues

| topic | status |
|---|---|
| Morph shapes | **Solved.** `tools/morph.py` emits start and end outlines per style; the runtime interpolates by `ratio` directly in `Graphics` (solid and linear/radial gradient in Flash's ±819.2 space). Used e.g. as animated masks of the 100-frame progress bars |
| AS3 vs TS construction order | In AS3, field initializers run before the base constructor; in TS, after `super()`. Fields touched in `init`/`addChildren` are therefore declared without an initializer and get their default inside `init()`, before `super.init()` |
| Bevel/gradient/convolution filters | Not rendered yet (rare: 3 bevel, 38 gradient) |
| Fonts | System fonts (Arial…); Flash rasterization differs in some subpixels |
| Server data in the viewer | Lists, item icons and dynamic numbers appear only where the code uses literals; the rest depends on the protocol (`protocol/`) and templates (`{TPL}`). The `?boot=1` path gets them from the Rust server instead |
| Battle and avatars | Formats in [../battle/README.md](../battle/README.md) and [graphics.md](graphics.md). Battles now run in the transpiled client against `server/src/battle.rs`; character/effect SWFs not yet in `raw/` must be fetched from the CDN (`tools/fetch_assets.py`) |
