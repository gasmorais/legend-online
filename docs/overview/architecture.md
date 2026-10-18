# Architecture overview

This project rebuilds the Flash client of Legend Online BR (server OAS1264) as an HTML5 application.
The original ActionScript 3 is decompiled, transpiled to TypeScript and run on an emulation of the Flash
runtime drawn with PixiJS; a Rust server replaces the game server, and a PostgreSQL database holds the
extracted game knowledge. This page describes each layer, where it lives and how the layers connect.

## How to read this

- Paths are relative to the repository root.
- A **module** is one decompiled SWF under `decompiled/<module>/scripts`: `core_module` is the core client
  (`2.png`), `mN` is the feature module loaded from `N.png`, `Loading` is the preloader (`Loading.swf`), and
  `core`, `core2` and `common` are shared UI asset SWFs.
- Class counts are computed by `tools/map.py` each time this page is generated.

## System at a glance

```
decompiled/*/scripts (AS3)
  -> tools/as3 (transpiler)        -> web/src/gen-bundles, web/public/as3/bundles
raw/ui/zh_cn/swf (UI SWFs)
  -> tools/h5build.py              -> web/public/lib/<swf>/library.json + img/ shp/ txt/
raw/ui/zh_cn/xml (PickGliss styles)
  -> tools/layout.py               -> web/public/layout

browser: web/src (Vite, port 5173)
  as3 runtime + flash display list + pickgliss port, drawn by PixiJS 8 (WebGL)
  HTTP servlets and /socket (WebSocket) proxied to
server/ (Rust, axum, port 8787)
  flows.json rules, protobuf codec, battle engine

db/ (PostgreSQL 17) <- tools/db loaders <- index/, protocol/, routes/, data/
```

## Layers

| Layer | Location | Built or run by | Role |
|---|---|---|---|
| Original files | `raw/`, `index/` | `tools/lobr.py`, `tools/decode.py` | Config, CDN manifests, module containers, UI SWFs, style XML, language texts |
| Decompiled AS3 | `decompiled/<module>/scripts` | FFDec (`tools/ffdec`) | Source of truth for client behavior |
| Static analysis | `index/`, `docs/ui/`, `protocol/`, `routes/`, `data/navigation.json` | `tools/map.py`, `tools/ui.py`, `tools/navmap.py`, `tools/paths.py` | Screen, style, route and navigation maps (these generated pages) |
| Transpiler | `tools/as3/` | `gen.py`, `build_bundles.mjs` | AS3 to TypeScript, bundled per module |
| AS3 runtime | `web/src/as3/` | Vite | Class loading, AS3 built-ins, `flash.*` APIs |
| Flash display runtime | `web/src/flash/` | Vite | Display list, symbols, text, filters, frame clock on PixiJS |
| PickGliss port | `web/src/pickgliss/` | Vite | `ComponentFactory` and controls driven by the original style XML |
| Renderer | `web/src/main.ts` | PixiJS 8 | WebGL stage of 1000×600, ticked by `FlashClock` |
| Asset libraries | `web/public/lib/`, `web/public/layout/`, `web/public/maps/`, `web/public/battle/` | `tools/h5build.py`, `tools/layout.py`, `tools/controllers.py`, `tools/maps.py`, `tools/battle_assets.py` | Pre-extracted SWF symbols, layouts, maps and battle assets |
| Game server | `server/` | `cargo run` | HTTP endpoints, game socket over WebSocket, data-driven replies, battle engine |
| Knowledge base | `db/` | Docker Compose, `tools/db/load_all.py` | PostgreSQL model of templates, protocol, assets and mechanics |

## Decompiled AS3

The original client boots in this order:

```
game.jsp -> Loading.swf (config, RSA, login, md5 manifests)
  -> 2.png (core module, 5155 classes) -> feature modules 3.png .. 18.png
```

Module containers (`raw/<N>.png`) are unpacked to `modules_src/mN.swf` and decompiled to
`decompiled/mN/scripts`; the core module (`raw/2.png`, `modules_src/m2.swf`) is decompiled to
`decompiled/core_module/scripts`.
Main packages of the core module:

| Package | Classes | Role |
|---|---:|---|
| `yishi.comm` | 7 | socket protocol: `ByteSocket`, `PackageIn`/`PackageOut`, packet check and cipher |
| `yishi.service` | 7 | AMF remoting (`ServicesAmf`, `CastleServiceManager`) and `SocketManager` |
| `yishi.manager` | 119 | state and rule managers, including `PathManager` and `BaseManager` |
| `managers` | 138 | feature managers and `*SocketOutManager` request senders |
| `yishi.scene` | 12 | `SceneManager`, `SceneCreate` and the scene base classes |
| `yishi.view` | 194 | views, including frames in `yishi.view.frame` |
| `mvc` | 1056 | controllers and mediators that open and drive frames |
| `com.pickgliss.ui` | 83 | UI framework (controls, `ComponentFactory`) |
| `com.road.yishi.proto` | 1653 | protobuf message classes |
| `battle` | 227 | battle scene, units and playback |

Original network channels:

- **HTTP/XML**: login, server lists, servlets under `{REQ}` and templates (`xml/*.xml`). See [HTTP routes](../../routes/routes.md).
- **AMF**: Flash Remoting at `/messagebroker/amf` (`CastleServicePath`). See [AMF remoting](../../protocol/amf.md).
- **TCP socket, port 5004**: real-time game traffic with protobuf payloads. See [socket protocol](../../protocol/socket.md)
  and [protobuf messages](../../protocol/proto.md).

## Transpiler: `tools/as3`

- `index.py` parses every class of `decompiled/*/scripts` and writes the class index to `build/as3`.
- `lexer.py` and `parse.py` read AS3; `emit.py` writes TypeScript; `gen.py` drives the run, writes one file
  per class to `build/as3/gen`, then concatenates them per module into `web/src/gen-bundles/<module>.ts` and
  writes the class-to-module map `web/public/as3/classmap.json`.
- `build_bundles.mjs` minifies each module bundle with esbuild into `web/public/as3/bundles/<module>.<hash>.js`
  and writes `manifest.json`; `v8check.mjs` checks that every bundle parses with `node --check`.

## Flash runtime: `web/src/as3` and `web/src/flash`

- `web/src/as3/runtime.ts` loads classes on demand: it looks up the module in `classmap.json`, fetches the
  bundle listed in `/as3/bundles/manifest.json` and defines the class with its dependencies.
- `web/src/as3/builtins.ts` and `xml.ts` provide the AS3 top level; `web/src/as3/flash/` implements the
  `flash.*` packages (`display`, `events`, `geom`, `net`, `text`, `utils`, `system`, `filters`) plus
  `ByteArray`, `Dictionary` and AMF encoding.
- `web/src/flash/` maps the Flash display list to PixiJS: `display.ts` and `sprite.ts` (display objects and
  MovieClip timelines), `bitmapdata.ts`, `text.ts`, `filters.ts`, `library.ts` (symbol libraries loaded
  through `Domain`) and `clock.ts` (frame clock).
- `web/src/pickgliss/` ports PickGliss (`ComponentFactory`, `ComponentModel`, controls) so screens are built
  from the same style XML as the original.
- `web/src/main.ts` creates the PixiJS `Application`, sets up the 1000×600 stage and initializes `Domain`,
  `LanguageMgr`, `GameClasses` and `ComponentFactory`. With `?boot` in the URL it calls `bootGame` from
  `web/src/boot/Boot.ts`, which runs the original boot sequence against the local server.

Details: [renderer](../client/renderer.md), [graphics](../client/graphics.md),
[animations](../client/animations.md).

## Asset libraries: `web/public/lib`

`tools/h5build.py` converts each UI SWF of `raw/ui/zh_cn/swf` (with `tools/swflib.py` and FFDec) into
`web/public/lib/<swf>/library.json` (stage, frame rate, linkage, characters and main timeline) plus `img/` (PNG
bitmaps), `shp/` (SVG shapes) and `txt/` (SVG static text); `web/public/lib/index.json` indexes all libraries.
`tools/layout.py` extracts the construction steps of every view (create, add, set and call operations) into
`web/public/layout/<module>.json` and writes the style index `web/public/lib/style-index.json`.
Catalog of CDN resources: [asset catalog](../client/asset-catalog.md).

## Game server: `server/`

A Rust server (axum and tokio) listens on `127.0.0.1:8787` (`LG_PORT`). The Vite dev server (port 5173)
proxies the HTTP routes and the `/socket` WebSocket to it.

| File | Role |
|---|---|
| `server/src/main.rs` | HTTP routes: `/config.xml`, `/xml/*`, `/code_md5.dat`, `/res_md5.dat`, `/cdn/*` (served from `raw/`), `/debug/*`, servlets, and `/socket` |
| `server/src/packet.rs` | Packet framing (20-byte header, magic 29099) and the byte-evolving cipher |
| `server/src/proto.rs` | Protobuf codec driven by `protocol/proto.json` |
| `server/src/game.rs` | Session state and the rule engine that answers requests from `server/flows.json` and `server/flows/*.json` |
| `server/src/battle.rs` | Battle engine simulated at 25 frames per second (40 ms per frame) |

Flow rules are validated with `python3 tools/navmap.py --check`. Details:
[navigation map](../ui/navigation.md), [battle server](../battle/server-engine.md).

## Knowledge base: `db/`

PostgreSQL 17 runs from `db/docker-compose.yml`; `db/migrations` holds the schema and `tools/db` the
loaders. It stores every server template list, the protocol, the CDN catalog, pt-BR texts, screens and a
semantic model of the mechanics. Details: [database](../../db/README.md), [mechanics](../mechanics/README.md),
[world](../world/README.md).

## Generated reference pages

| Page | Content |
|---|---|
| [UI composition](../ui/README.md) | How screens are built from styles and symbols, with one page per module |
| [Screen index](../ui/screens.md) | Every frame, scene and tip |
| [Navigation map](../ui/navigation.md) | HUD buttons, opened screens and their opcodes |
| [PickGliss components](../client/components.md) | UI framework classes |
| [Managers](../client/managers.md) | Manager classes per module |
| [HTTP routes](../../routes/routes.md) | Base URLs, servlets and `PathManager` templates |
| [Protobuf messages](../../protocol/proto.md) | Message groups of the socket protocol |
| [AMF remoting](../../protocol/amf.md) | Flash Remoting methods |

Other references: [roadmap](roadmap.md), [battle](../battle/README.md), `index/summary.md`,
`index/manifest_all.csv`.

## Decompiled modules

**Classes** counts `.as` files; **Top packages** are the five largest first-level packages.

| Module | Classes | Top packages | UI page |
|---|---:|---|---|
| `core_module` | 5155 | com, yishi, mvc, battle, map | [core_module](../ui/modules/core_module.md) |
| `Loading` | 149 | com, manager, asset, loading, utils | [Loading](../ui/modules/Loading.md) |
| `core` | 549 | asset, core_fla, core | [core](../ui/modules/core.md) |
| `core2` | 503 | asset, core2_fla | [core2](../ui/modules/core2.md) |
| `common` | 55 | asset | [common](../ui/modules/common.md) |
| `m3` | 1309 | map, com, starling, consortiachess, gamehall | [m3](../ui/modules/m3.md) |
| `m4` | 46 | buildings, castle, yishi | [m4](../ui/modules/m4.md) |
| `m5` | 407 | theseus, armyII, dragontalker, goddess, avenger | [m5](../ui/modules/m5.md) |
| `m6` | 170 | consortia, com | [m6](../ui/modules/m6.md) |
| `m7` | 58 | auction, outercityshop | [m7](../ui/modules/m7.md) |
| `m8` | 50 | nodes, views, preload, mediators, datas | [m8](../ui/modules/m8.md) |
| `m9` | 215 | marry, apex, room, areslords, unrealshooting | [m9](../ui/modules/m9.md) |
| `m10` | 73 | battle, com, yishi | [m10](../ui/modules/m10.md) |
| `m11` | 930 | outyard, sevenyear, ancientartifact, skytreasure, christmas | [m11](../ui/modules/m11.md) |
| `m12` | 40 | friends, im, groupchat | [m12](../ui/modules/m12.md) |
| `m13` | 72 | dreamarena, colosseum, worldboss, selectcampaign, redemptionroad | [m13](../ui/modules/m13.md) |
| `m14` | 477 | child, pet, store, monster, stelesys | [m14](../ui/modules/m14.md) |
| `m15` | 123 | view, vip, task, offerreward, com | [m15](../ui/modules/m15.md) |
| `m16` | 179 | yishi, tasktracetip | [m16](../ui/modules/m16.md) |
| `m17` | 101 | com | [m17](../ui/modules/m17.md) |
| `m18` | 83 | com, manager, doctor, notice, flash | [m18](../ui/modules/m18.md) |
