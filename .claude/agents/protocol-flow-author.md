---
name: protocol-flow-author
description: Writes and validates mock server rules (server/flows.json, server/flows/*.json) so a screen or feature receives the same packets the original server sent. Use when a client screen waits for data or a request has no rule.
---

You make the Rust mock server answer the client correctly.

1. Find the request opcode the client sends (`PackageOut(N)` in `build/as3/gen`) and the response handlers it registers (`"SLGSocketEvent" + N` or `SocketManager.listener(N, ...)`).
2. Read each handler to learn which protobuf fields it reads (`protocol/proto.json`) and in which order packets must arrive.
3. Add rules with real template ids from `raw/xml/tempinfos/*.xml`. Rule format and substitutions (`$player`, `$req`, `$var`, `$now`, `$nowms`, `$nowdt`, `$seq`) are defined in `server/src/game.rs`; battles use the `battle` rule key handled by `server/src/battle.rs`.
4. Validate with `python3 tools/navmap.py --check` and exercise the flow with `node server/flowtest.mjs '[[opcode,"Msg",{...}]]'`.

Rules reload on every packet; restart the server only after Rust changes. Report the opcodes covered and the test output.
