# Roadmap: Legend Online BR (OAS1264) → HTML5

This document tracks the HTML5 rebuild of the Legend Online BR Flash client: what is done, what is in progress and what comes next. The original Flash/ActionScript 3 client (Adobe AIR) talked to the official **OAS1264** server; the rebuild transpiles that client to TypeScript, runs it on a Flash runtime over PixiJS and serves it from a local Rust server. The reverse engineering plan that produced the current knowledge base is kept at the end for reference. Architecture details: [architecture.md](architecture.md) and [../client/renderer.md](../client/renderer.md).

## Target

| role | address |
|---|---|
| site / login | `https://lobr.creaction-network.com` |
| app / API | `https://s1264oas.creaction-network.com` |
| resource CDN | `https://res1264oas.creaction-network.com` |
| game socket | `s1264oas.creaction-network.com:5004` |
| AMF (Flash Remoting) | `http://s1264oas.creaction-network.com/messagebroker/amf` |
| site id | `broas_1264` |
| client version | `1.3.0` |

## Done

| area | result | where |
|---|---|---|
| Inventory | manifest, routes, protocol, decompiled modules, templates | `index/`, `routes/`, `protocol/`, `decompiled/`, `db/` |
| AS3 → TypeScript | transpiler (`lexer.py`, `parse.py`, `index.py`, `emit.py`, `gen.py`): 10 610 classes indexed, 10 593 emitted, one bundle per module | `tools/as3`, `web/src/gen-bundles` |
| Bundles | `build_bundles.mjs` emits minified, hashed bundles + `manifest.json`, loaded on demand by the runtime | `web/public/as3/bundles` |
| Flash runtime | AS3 runtime (`runtime.ts`, `xml.ts`, `builtins.ts`), Flash API (`flash/*`), display core shared with the viewer | `web/src/as3`, `web/src/flash` |
| Boot | original boot sequence at http://localhost:5173/?boot=1 (`Boot.ts`, `Fit.ts`) | `web/src/boot` |
| Server | Rust server on port 8787, proxied by Vite; rule files per opcode; real-time battle engine | `server/`, `server/flows.json`, `server/flows/*.json`, `server/src/battle.rs` |
| Playable scope | login, castle with the original HUD layout, Reino do Céu space lobby (map 10000, 2D map engine, tiles in `raw/mapmaterial/land/10000`), inventory, guild, mounts (ride/dismount via 8529), battles | `?boot=1` |
| Assets on demand | the server logs CDN misses to `logs/cdn_missing.txt`; `tools/fetch_assets.py` downloads them (or named groups) into `raw/` | `tools/fetch_assets.py` |
| Screen viewer | layout pipeline, PickGliss-H5 port, 1 097 screens, inspector, battle preview | `web/src/viewer`, `web/src/pickgliss`, `web/src/battle` |
| Documentation | client, battle, world, mechanics, UI | `docs/` |
| Docker | `docker compose up --build` runs server and client on any OS | `compose.yaml`, `docker/` |

## In progress

- Validation of campaign, room and arena flows against the server rules (`server/flows.json` already answers the classic room opcodes 5026, 5023, 5024, 5034, 5036, 5039 and 5025).
- Missing assets: there is no full CDN mirror; files arrive through `tools/fetch_assets.py` as the client requests them.

## Next

- Outer city (worlds 1-5, 512 px tiles and Stage3D path) and the world map; the server already answers 8328 and 9525 on world map entry. See [../world/README.md](../world/README.md) §2.1.
- Campaign maps and instances end to end (125 → 21 → 127, portals via 5125), see [../world/README.md](../world/README.md) §3.
- Multiplayer rooms beyond the classic PvE room (PvP, Teseu, Grupo FB), see [../world/README.md](../world/README.md) §4.
- Rendering gaps: bevel, gradient and convolution filters; Flash font rasterization ([../client/renderer.md](../client/renderer.md) §6).

## Reference: reverse engineering plan

### Observed architecture

```
game.jsp (flashvars: user,key,site)
  └─ Loading.swf              (bootstrapper, calls init())
       └─ config.xml          (routes, RSA, sounds, paths)
       └─ code_md5.dat        (348 SWF/DAT modules)
       └─ res_md5.dat         (52,275 resources)
       └─ mainloadingii.swf   (loading screen)
            └─ core.swf / core2.swf / common.swf   (framework + network)
                 └─ feature modules (shop, pet, battle, ...)
```

| channel | use |
|---|---|
| HTTP/REST | login, lists, config/template XML |
| AMF (AMF3/Remoting) | `CastleServicePath` / `OuterCityServicePath` |
| binary TCP socket :5004 | `yishi.comm::ByteSocket` (real-time game) |

UI stack: `com.pickgliss.ui` (PickGliss), `managers::*`, `yishi.*`.

### Two-layer strategy

| layer | scope |
|---|---|
| low level (bytes/transport) | manifest = **double** zlib + XML (`name`, `md5` truncated to 8 hex, `size`); resource URL = `RES / <slashed path>_<md5>.<ext>` (no hash → 403); SWF `FWS` (raw), `CWS` (zlib), `ZWS` (LZMA), ABC tags (72/82); socket: binary packet, raw capture to infer header/opcode; capture with `pcap` on :5004 + `mitmproxy` for HTTP/AMF |
| high level (semantics/AS3) | AS3 decompilation (FFDec) → classes, methods, strings, opcode tables; map of packet opcodes, AMF services and data schemas; UI/layout: display list, PickGliss components, position XML |

### Tooling

| tool | use |
|---|---|
| **FFDec** (+ `openjdk@21`) | decompile AS3 from SWFs |
| **AIR SDK** (`swfdump`, `swfcompress`, `swfencrypt`, `amxmlc`) | inspect/generate SWF, instrument |
| **lobr.py** (`tools/lobr.py`) | manifest, download, routes |
| **mitmproxy** | intercept HTTP/AMF |
| **tcpdump/Wireshark** | capture socket :5004 |
| `Engine/lobr/shim` (outside this repo) | runtime network/loader hook |

### Phases

| phase | scope | output |
|---|---|---|
| F0 Tooling | Java, FFDec, swfdump, capture | `tools/` |
| F1 Inventory | manifest → JSON/CSV/summary | `index/` |
| F2 Routes | logs + probe | `routes/` |
| F3 HTTP/AMF | endpoints, payloads, AMF services | `protocol/amf.md` |
| F4 Socket | capture and dissect `ByteSocket`: header, opcodes, types | `protocol/socket.md`, `protocol/opcodes.json` |
| F5 UI/layout | components, positions, atlas/atf, screens | `docs/ui/` |
| F6 Logic | feature modules, managers, flows | `docs/mechanics/`, `docs/client/managers.md` |
| F7 HTML5 synthesis | contracts (assets, API, protocol, screens) | `web/`, `server/` |

### Deliverables (repository root)

| folder | content |
|---|---|
| `index/` | `manifest_*.json`, `manifest_all.csv`, `summary.md` |
| `routes/` | `routes.json`, `routes.md` |
| `protocol/` | `socket.md`, `amf.md`, `opcodes.json` |
| `docs/` | `docs/overview/roadmap.md`, `docs/overview/architecture.md`, `docs/ui/README.md` |
| `raw/` | asset tree (original logical path) |
| `tools/` | `lobr.py` and utilities |
| `logs/` | copies of client logs |

### Verification rules

- Every resource is checked against the manifest `md5`/`size`.
- Every route is confirmed by live capture (not only by log).
- Every opcode is correlated bytes ↔ AS3 handler.
