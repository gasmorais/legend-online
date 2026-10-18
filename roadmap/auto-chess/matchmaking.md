# Auto chess matchmaking

Module `auto_chess::matchmaking`. Citation prefixes: see [README.md](README.md).

## 1. Overview

From the anniversary card the player joins a queue of 6. The server pushes the queue size to everyone waiting; when it reaches 6 the client switches to `SELF_CHESS_SCENE` by itself after 1 s and the server must create the room and push the first full snapshot (4216 op 9). While waiting the hub shows the anniversary quiz ([../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)).

## 2. Screens

| Class | pt-BR | Purpose | Data |
|---|---|---|---|
| `sevenyear.view.battleflag.SevenYearSelfChessView` (card in the battle flag tab, style `SevenYearBattleFlagView.selfchessView`) | "Começar emparelhamento" / "Parar emparelhamento", "n/6", "Hoje ainda pode recebe" x/600, "Convidar", help | Start/stop queue, counter, invite, time to event end (`seven_year_stop_date`) | 4218, 4987 `snowScore` |
| `selfchess.helpFrame` | help `sevenyear.selfchess.helpContent` | Rules | static |

## 3. Routes (client to server)

| # | Action | UI / sender | Client checks | Route and request | Response |
|---|---|---|---|---|---|
| M1 | Start matchmaking | "Começar emparelhamento" -> `SevenYearSelfChessView.__startSnowBallHandler` (`M11/sevenyear/view/battleflag/SevenYearSelfChessView.as:176-183`) -> `SelfChessManager.sendMatch(1)` (`SCM:215-221`) | `SwitchInfo.SELF_CHESS` | C to S 9701 (0x25e5) `C_SELF_CHESS_OP`, `simple.PropertyMsg` {`param1` (#1, INT32) = 1 start} | 4218 to all queued players; 4219 `param1 = 2` "Fila de espera lotada." when the queue cannot accept (A: event closed or player already in a room) |
| M2 | Cancel | "Parar emparelhamento" (`SevenYearSelfChessView.as:185-188`); card dispose while queued (`:262-268`); daily game card launch (`M11/sevenyear/view/battleflag/SevenYearGameView.as:309-316`) | Parar disabled once the count is 6 (`:218-220`) | 9701 `PropertyMsg` {`param1` = 2 cancel} | 4218 with `param1 = 0` to the leaver (A) and the new count to the others |
| M3 | Invite | "Convidar" (`SevenYearSelfChessView.as:160-172`) | once per 30 s ("chat.view.ChatInputView.command02") | chat message "Comecei um emparelhamento para a Supremacia do Legend, bora lá!" on channel 8 (`ChatManager.chatNormal`) | chat feature |

`simple.PropertyMsg` layout (missing from `protocol/proto.json` because of a name clash with `stargazing.PropertyMsg`, see `docs/battle/chess-modes.md` B.8): `param1` (#1, INT32), `param2` (#2, INT32), `param3` (#3, INT32), `param4` (#4, STRING), `param5` (#5, STRING), `param6` (#6, STRING), `param7..param9` (#7..#9, BOOL), `param10` (#10, INT32), `param11` (#11, INT32), `param12` (#12, STRING) (`CM/com/road/yishi/proto/simple/PropertyMsg.as`).

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 4218 (0x107a) `U_C_SELF_PROPELLED_CHESS_STATE` | `PropertyMsg` {`param1` (#1) players in the queue} | `SCM.receiveStateInfos` (`SCM:79,166-174`) | after M1/M2 and on every queue change, to each queued player | `model.playerNum` and `SevenYearModel.snowTeamNum` (which also toggles the quiz card); at `ROOM_MAX` (6) the client calls `setScene("SELF_CHESS_SCENE")` after 1 s |
| 4219 (0x107b) `U_C_SELF_PROPELLED_CHESS_TIPS` | `PropertyMsg` {`param1` tip id} | `SCM.tipInfosHandler` (`SCM:80,83-90`) | refusal or info | shows `selfchess.serverTip{param1}`: 1 "Oponente sem herói em batalha. Obteve Vitória!", 2 "Fila de espera lotada." |
| 4216 `U_C_SELF_PROPELLED_CHESS_DATA` op 9 | see [preparation.md](preparation.md) | `SCM.receivePlayerInfos` | right after the room is created | full room state |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Room size | `chess_room_num` = 6 | `TPL/ConfigInfos.xml`; `SCM:58-61` |
| Open hours | `chess_game_time` = `00:00,22:30` | ConfigInfos |
| Event window | the anniversary dates (`seven_year_start_date`..`seven_year_stop_date`) | ConfigInfos |
| Daily points cap | 600 (`snow_vehicle_daily_reward_max`), shown "x/600" | `SevenYearSelfChessView.as:107,191` |
| Scene entry | client side when the count equals 6 | `SevenYearSelfChessView.as:212-226` |

## 6. Templates

`TPL/ConfigInfos.xml`: `chess_room_num`, `chess_game_time`, `chess_game_over_award`, `snow_vehicle_daily_reward_max`.

## 7. Persistent state

Queue in memory. No table.

## 8. Backend implementation notes

- `auto_chess::matchmaking::handle_op` (9701): `param1 = 1` join (check switch, time window `chess_game_time`, event active, not in a room, not in another scene), `param1 = 2` leave.
- After each change send 4218 with the queue size to every queued player.
- When 6 players are queued: send 4218 = 6 to all, create a room (`roomUuid`), wait about 1 s for the clients to load the scene (A), then 4216 op 9 to each player. A player who disconnects before the first snapshot is kept as an idle seat (A).
- The queue may be cross-server (`serverName` is in every player entry).

## 9. Open questions and assumptions

- (A) What 4218 value the leaver receives after cancel (0 hides the counter and shows Start).
- (A) Whether quits during the 1 s gap abort the room.
- (A) Cross-server pooling.

## 10. Implementation checklist

- [ ] 9701 join and cancel with validations.
- [ ] 4218 broadcast to the queue.
- [ ] 4219 tips 1 and 2.
- [ ] Room creation at 6 and first 4216 op 9.
- [ ] Tests: join twice, cancel at 6, disconnect while queued.
