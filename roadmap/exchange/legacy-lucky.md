# Legacy protobuf package `lucky` ("招财" and "炼魂")

## 1. Overview

The protobuf package `lucky` (`decompiled/core_module/scripts/com/road/yishi/proto/lucky/`) and its opcodes belong to two removed minigames of the original Chinese game: "招财" (fortune: spend diamonds to receive gold, with a daily count) and "炼魂" (soul refining: spend diamonds to receive soul points). The package also holds copies of the lords ranking messages. No class outside the package references any of these messages, and no sender or listener exists for the opcodes (verified with a full text search of `decompiled/`). Nothing must be implemented; this file records the mapping so nobody rebuilds it by mistake.

## 2. Screens

None in this client.

## 3. Routes (client to server)

Defined in `decompiled/core_module/scripts/yishi/datas/consant/ProtocolType.as:442-448` and described in `ProtocolTypeTable.as:1135-1138`; never sent.

| Opcode | Hex | Name | Description (`ProtocolTypeTable`) | Probable request |
|---|---|---|---|---|
| 8320 | 0x2080 | `C_LUCKY_FRFRESH` | "招财刷新" (fortune refresh) | empty |
| 8321 | 0x2081 | `C_LUCKY_SWAP` | "兑换" (exchange) | empty |
| 8466 | 0x2112 | `C_REFININGSOUL_FRFRESH` | "炼魂刷新" (soul refining refresh) | empty |
| 8467 | 0x2113 | `C_REFININGSOUL_SWAP` | "炼魂兑换" (soul refining exchange) | empty |

## 4. Server messages (server to client)

Defined in `AcceptProtocolType.as:592-594`; no listener.

| Opcode | Hex | Name | Probable message |
|---|---|---|---|
| 4224 | 0x1080 | `U_C_LUCKY_REFRESH` | `PlayerLuckyMsg` |
| 4372 | 0x1114 | `U_C_REFININGSOUL_FRFRESH` | `PlayerRefiningSoulMsg` |

Messages of the package (`protocol/proto.json`):

| Message | Fields |
|---|---|
| `PlayerLuckyMsg` | `luckyCount` (#1, INT32) uses today, `remainCount` (#2, INT32) uses left, `lastReceive` (#3, BYTES) last time, `point` (#4, INT32) diamond price, `gold` (#5, INT32) gold reward, `state` (#6, INT32), `p` (#7, INT32) |
| `PlayerRefiningSoulMsg` | `count` (#1, INT32), `remainCount` (#2, INT32), `point` (#3, INT32) diamond price, `soul` (#4, INT32) reward, `state` (#5, INT32), `p` (#6, INT32) |
| `LordsBaseInfoMsg`, `LordsOrderListMsg`, `MultiLordsInfoMsg`, `MultiLordsMsg` | lords ranking structures (player id, server, nickname, avatar strings, scores, orders, rewards, battle results); unused here. The lords features use their own packages (`areslords`, `matelords`), see [../ares-battle/README.md](../ares-battle/README.md) and [../venus-battle/README.md](../venus-battle/README.md) |

Field meanings above are inferred from the names (assumption).

## 5. Rules and formulas

None.

## 6. Templates

None.

## 7. Persistent state

None.

## 8. Backend implementation notes

- Do not register handlers for 8320, 8321, 8466, 8467. The packet dispatcher should log and drop them like any unknown opcode.
- Keep the message definitions in the generated protobuf code only because the schema ships them.

## 9. Open questions and assumptions

- Assumption: field meanings of `PlayerLuckyMsg` and `PlayerRefiningSoulMsg`.

## 10. Implementation checklist

- [ ] Confirm the dispatcher drops 8320, 8321, 8466, 8467 without error
- [ ] No tables, no handlers
