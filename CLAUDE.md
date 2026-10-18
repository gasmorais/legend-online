# Legend Online

The original Flash/AIR client of Legend Online BR runs in the browser. Its decompiled ActionScript 3 is transpiled to TypeScript and executed on a Flash runtime built on PixiJS. A Rust server speaks the original binary protocol.

## Principles

- Fidelity first: run the original game code. Fix behavior in the transpiler (`tools/as3`) or in the Flash runtime (`web/src/as3`, `web/src/flash`), never by hand-editing generated code.
- Patches to generated code are allowed only for decompiler artifacts, in `PATCHES` inside `tools/as3/gen.py`.
- The server answers the client as the original server did. Read the client handler before writing a response.

## Layout

| Path | Content |
|---|---|
| `decompiled/<module>/scripts` | Decompiled AS3 (read only) |
| `tools/as3` | Transpiler: `lexer.py`, `parse.py`, `index.py`, `emit.py`, `gen.py`, `build_bundles.mjs`, `v8check.mjs` |
| `build/as3/gen` | One readable TypeScript file per class (generated, not versioned) |
| `web/src/gen-bundles`, `web/public/as3/bundles` | Generated bundles (do not edit) |
| `web/src/as3` | Runtime (`runtime.ts`), E4X (`xml.ts`), AS3 builtins, `flash.*` API (`flash/`) |
| `web/src/flash`, `web/src/pickgliss` | SWF symbol renderer and PickGliss UI port |
| `web/src/boot` | Real boot entry (`Boot.ts`) and screen fitting (`Fit.ts`) |
| `web/public/lib` | Converted SWF libraries |
| `server/src` | Rust server: packets, protobuf, rule engine (`game.rs`), battle engine (`battle.rs`) |
| `server/flows.json`, `server/flows/*.json` | Server rules, reloaded on every packet |
| `raw/` | Original client files and assets served under `/cdn` |
| `protocol/` | Opcodes and protobuf schema |
| `docs/` | Documentation, start at `docs/README.md` |

## Commands

| Task | Command |
|---|---|
| Run everything | `docker compose up --build`, then open http://localhost:8080/?boot=1 |
| Server (dev) | `cd server && LG_ROOT=.. cargo run --release` |
| Client (dev) | `npm --prefix web install && npm --prefix web run dev`, then http://localhost:5173/?boot=1 |
| Regenerate code | `python3 tools/as3/index.py && python3 tools/as3/gen.py` (also rebuilds bundles) |
| Check bundles | `node tools/as3/v8check.mjs` |
| Typecheck | `npm --prefix web run typecheck` |
| Validate server rules | `python3 tools/navmap.py --check` |
| Protocol test | `node server/flowtest.mjs '[[8224,"PlayerDataMsg",{"castle":true}]]'` |
| Battle test | `node server/battletest.mjs battle` |
| Regenerate UI docs | `python3 tools/map.py` and `python3 tools/navmap.py` |
| Fetch missing assets | `python3 tools/fetch_assets.py missing --dry-run` |

## Debugging the game

- `?boot=1&trace=pkg.Class.method,...` logs every call with its caller in `window.__trace`.
- `window.__errors` keeps errors raised inside Flash listeners; `window.__swfLog` lists requested SWFs; `window.__as3.$.C('fqn')` returns any class.
- `GET /debug/<name>` on the server runs the rule `push:<name>` (for example `/debug/battle`).
- `logs/cdn_missing.txt` lists assets the client requested and the disk does not have.

## Conventions

- Documentation: concise semantic English, no em dashes or en dashes. Game strings (pt-BR, Chinese) stay verbatim.
- Code: no comments or docstrings. Match the surrounding style.
- Commits: one line, English, conventional prefix (`feat:`, `fix:`, `perf:`, `refactor:`, `docs:`, `chore:`). No body, no co-author trailer.
- Assets: never download from the original CDN without asking first, stating file count and size.
