# Underground palace exploration ("地宫探险", dungeon protocol)

Module `dungeon` of [campaign](README.md). The protobuf package `dungeon` describes a grid exploration mode ("地宫探险", underground palace exploration): a hidden map of cells revealed step by step, events on cells, treasure, revives, paralysis, a weekly score with score boxes and a score order. **This BR client has no sender, no listener and no screen for it.** The opcodes exist only in the tables. This module records the protocol so the backend can stay compatible, and recommends not implementing it until a client consumer exists.

Not to be confused with:
- the Theseus dungeon (`theseusdungeon` package, opcodes 9763/779/780, `M11/dungenexploration`), owned by [../theseus/README.md](../theseus/README.md);
- the "Roleta da Masmorra" board ([dungeon-turn.md](dungeon-turn.md)).

## 1. Overview

| Opcode | Name | Chinese description (`CM/yishi/datas/consant/ProtocolTypeTable.as:554-555`) | Client listener |
|---|---|---|---|
| 4931 (0x1343) | U_C_DUNGEON_MSG | 地宫操作返回 (palace operation reply) | none (`AcceptProtocolType.as:1062` constant only) |
| 4932 (0x1344) | U_C_DUNGEON_MAP | 刷新地宫探险地图 (refresh the exploration map) | none (`AcceptProtocolType.as:1064`) |

- No request opcode for `DungeonReqMsg` exists in `protocol/opcodes.csv` or `ProtocolType.as`.
- Battle type 3840 `DUNGEON_MONSTER_BATTLE` (`CM/yishi/datas/battle/BattleType.as:78`) has no reference in the client (`docs/battle/rules.md` row 3840) and probably belonged to this mode.

## 2. Screens

None in this client.

## 3. Routes (client to server)

None. If a future client sends `DungeonReqMsg`, it carries `op (#1, INT32)` (required) and `param (#2, INT32, repeated)` (`CM/com/road/yishi/proto/dungeon/DungeonReqMsg.as`). The opcode is unknown.

## 4. Server messages (server to client)

Field tags verified in `CM/com/road/yishi/proto/dungeon/*.as`.

| Opcode | Message and fields |
|---|---|
| 4931 U_C_DUNGEON_MSG | `DungeonMsg`: `op (#1, INT32, required)` echo of the request op; `score (#2, INT32)`; `week_score (#3, INT32)`; `scoreBoxState (#4, BOOL, repeated)` claimed state per score box; `treasure_count (#5, INT32)`; `event_left (#6, INT32)`; `step_left (#7, INT32)`; `revive_left (#8, INT32)`; `dungeon_type (#9, INT32)`; `dungeon_process (#10, INT32)`; `dead (#11, BOOL)`; `has_next (#12, BOOL)` next floor available; `paralysis_time (#13, INT64)` end of a stun; `event_info (#14, DungeonEventMsg)`; `itemFly (#15, INT32, repeated)` item ids for the fly-to-bag animation; `pos_x (#16, INT32)`, `pos_y (#17, INT32)` player cell; `order_score (#18, INT32)`; `current_order (#19, INT32)` ranking position; `next_event_count (#20, INT32)` |
| 4932 U_C_DUNGEON_MAP | `DungeonMapMsg`: `stamp (#1, INT32, required)` map version; `grid (#2, DungeonGridMsg, repeated)` |

Nested: `DungeonGridMsg{x (#1, INT32), y (#2, INT32), opened (#3, BOOL), event_id (#4, INT32)}`; `DungeonEventMsg{event_id (#1, INT32), respond_type (#2, INT32), paramInt (#3, INT32, repeated)}`.

## 5. Rules and formulas

Unknown: no template and no client logic. Field names suggest steps per day (`step_left`), limited events (`event_left`), revives, weekly score boxes and a ranking.

## 6. Templates

None in `raw/xml/tempinfos` (no `Dungeon*` set).

## 7. Persistent state

None proposed. If the mode is ever implemented, follow the shape of the messages: one row per player and week (score, steps, revives, position, floor), one row per opened cell, one row per score box claim, in schema `campaign`.

## 8. Backend implementation notes

- Do not register handlers for 4931/4932 in the first implementation.
- Keep the message definitions in the protobuf crate so a future client can be supported without schema changes.

## 9. Open questions and assumptions

1. Request opcode and op values.
2. Whether this mode shipped in any Legend Online version (the BR build has only the protocol).

## 10. Implementation checklist

- [ ] Keep `dungeon` package messages compiled (`DungeonMsg`, `DungeonMapMsg`, `DungeonGridMsg`, `DungeonEventMsg`, `DungeonReqMsg`)
- [ ] No handler, no table until a consumer exists
