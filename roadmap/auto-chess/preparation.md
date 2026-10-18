# Auto chess preparation phase (room actions)

Module `auto_chess::preparation`. Citation prefixes: see [README.md](README.md).

## 1. Overview

Inside `SELF_CHESS_SCENE` each player manages a shop (5 cards), a bench (8 slots, `pos` 11..18), a battle line (8 slots, `pos` 1..8), gold, level and XP. Every action is one 25031 op; the server answers with a 4216 `ChessRoomMsg` echoing the op, and the client redraws only the parts tied to that op. The client validates almost nothing (gold for buy, refresh, XP), so the server must validate everything, including the phase (`state == 1`).

Field, slot positions, drag and drop and redraw rules: `docs/battle/chess-modes.md` B.3, B.8, B.9.

## 2. Screens

| Class | Purpose | Data |
|---|---|---|
| `chess.SelfChessSceneController` -> `chess.SelfChessSceneView` (1495x895) | Scene; on enter hides QueueBar, TopToolsBar, MainToolBar, TaskTraceBar, TimeBoxView, SmallMapBar and disables the keyboard (`CH/SelfChessSceneController.as:46-79`) | 4216 |
| `SelfChessBottomLeftView` | "Vitórias/Perdas consecutivas", "Ouro possuído" with income tip, XP bar, level, "Elevação" (4 gold -> +4 XP) | self |
| `SelfChessBottomView` | bench, shop, lock, "Atualizar" (2 gold), "Vender" bin, "Sair" | self |
| `SelfChessHeroTeamView` | 8 battle slots | self `battleAry` |
| `SelfChessKindListView` | synergies of the battle line | computed by `SelfChessModel.resetSelfJobNum` (`CM/mvc/module/chess/SelfChessModel.as:116-169`) |
| `SelfChessPlayerListView` | 6 players: name, gold, HP, level, tooltip formation | all players |
| `SelfChessTopView` | "{stage}ª Rodada · Rodada {sub}", countdown or "Aguardando a batalha terminar" | `round`, `state` |
| `SelfChessLimitView` | "on field / level" | self |
| `SelfChessTipView`, `SelfChessBuffTip`, `SelfChessPlayZhenTip` | tooltips | templates |

## 3. Routes (client to server)

All: C to S 25031 (0x61c7) `CR_SELF_PROPELLED_CHESS`, `simple.PropertyMsg` built by `SelfChessManager.sendOp(op, p1 = -1, p2 = -1)` (`SCM:198-213`), only when `model.selfInfo` exists:
- `param1` (#1, INT32): op;
- `param2` (#2, INT32): own userId;
- `param3` (#3, INT32): p1;
- `param4` (#4, STRING): own serverName;
- `param5` (#5, STRING): roomUuid;
- `param11` (#11, INT32): p2.

Op constants `SCM:28-46`.

| op | Action | UI / sender | Client checks | p1 / p2 | Expected 4216 (op echoed) |
|---|---|---|---|---|---|
| 3 BUY_CHESS | Buy a shop card | card click `CH/item/SelfChessHeroItem.as:192-206` | `gold >= Grade` else "Ouro insuficiente" (`selfchess.buy.noGold`) | p1 = card position 1..5 | op 3: card slot set to 0, unit added to the first free bench slot (A: or merged), gold reduced |
| 4 DEL_CHESS | Sell | drop on "Vender" `CH/item/SelfChessTeamItem.as:280-288` | none (shows "Ouro +N" with N = `Grade + (Star-1)*2`) | p1 = slot pos (1..8 or 11..18) | op 4 |
| 5 CHANGE_CHESS | Move or swap | drop on another slot `CH/item/SelfChessTeamItem.as:262-278` | with a full field shows "Máximo de pessoas em batalha atingido" but still sends | p1 = source pos, p2 = target pos | op 5 (server refuses to exceed `grade` units on the field; reply with the unchanged state) |
| 6 REFRESH | Reroll shop | "Atualizar" `CH/SelfChessBottomView.as:212-226` | `gold >= 2` | - | op 6 |
| 7 ADD_EXP | Buy XP | "Elevação" `CH/SelfChessBottomLeftView.as:96-104` | `gold >= 4` | - | op 7 |
| 8 OUT_ROOM | Leave | "Sair" confirm "No momento você está na sala da Supremacia do Legend. Deseja sair?" (`CH/SelfChessBottomView.as:193-210`), MainToolBar exit (`CM/ui/maintoolbar/MainToolBar.as:1685-1688`), game over close (`CH/SelfChessGameOverFrame.as:120-126`) via `SCM.exitGame` (`SCM:223-227`) | confirm | - | none; the client returns to space at once. Mid-game: the player is eliminated (A) |
| 10 LOCK | Lock / unlock shop | lock button `CH/SelfChessBottomView.as:177-191` | toggles by `lock` | p1 = 1 lock, 0 unlock | op 10 |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 4216 (0x1078) `U_C_SELF_PROPELLED_CHESS_DATA` | `chat.ChessRoomMsg` {`roomUuid` (#1, STRING), `round` (#2, INT32), `state` (#3, INT32: 1 preparation, other = battle running), `op` (#4, INT32: echoed op, 9 = full update), `playerList` (#5, SelfChessPlayerMsg, repeated)} | `SCM.receivePlayerInfos` (`SCM:76,92-164`) | reply to each op (to the actor; others when public data changes), and op 9 at room start, at each phase change and after battles | merges players by `userId_serverName`; arrays overwritten by index; if own `battleAry` changed, synergies recount; dispatches `SELF_CHESS_UPDATA(op)` |

`SelfChessPlayerMsg`: `userId` (#1, INT32), `serverName` (#2, STRING), `name` (#3, STRING), `hp` (#4, INT32, 0..100), `gold` (#5, INT32), `grade` (#6, INT32, level 1..7), `exp` (#7, INT32), `winCount` (#8, INT32, streak; negative = losses), `lock` (#9, INT32, 0/1), `battleAry` (#10, INT32, repeated, 8 template ids, 0 empty), `alternateAry` (#11, INT32, repeated, 8 bench ids), `cardPool` (#12, INT32, repeated, 5 shop ids, 0 bought), `rank` (#13, INT32, placement, used as secondary sort).

Redraw contract (`CH/SelfChessSceneView.as:75-122`): op 3/4 level, shop, bench, field, synergies, population; op 5 field, bench, synergies, population; op 6 shop and lock; op 7 level, population, shop; op 9 everything including player list and round; op 10 lock. The top bar and the player list redraw only on op 9, so every HP, gold or round change of other players must be sent as op 9.

Always send all 8/8/5 array entries (the client merges by index and never shrinks arrays).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Buy cost | `Grade` (1..5) | `CH/item/SelfChessHeroItem.as:108-109` |
| Sell value | `Grade + (Star-1)*2` (client estimate) | `CH/item/SelfChessTeamItem.as:282-288`, `CH/SelfChessTipView.as:79` |
| Refresh | 2 gold | `CH/SelfChessBottomView.as:212-226` |
| Buy XP | 4 gold -> +4 XP | `CH/SelfChessBottomLeftView.as:96-120` |
| Level table | `UpGradeTempInfos` Types=81: XP to next 2, 6, 10, 18, 30, 50; max level 7; `TemplateName` = quality odds by level | `TPL/UpGradeTempInfos.xml` |
| Field size | units on `battleAry` <= `grade` | `CH/SelfChessLimitView.as:58-84` |
| Merge | 3 identical `TemplateId` -> `NextTemplateId` (next star), ★3 has `NextTemplateId = 0` | `TPL/AutoChessHeroInfos.xml` |
| Lock | freezes the shop for the next automatic refresh only | `selfchess.lockBtn.Tip` |
| Phase | ops 3..7 and 10 only during `state == 1` (server-side) | client has no check |

## 6. Templates

| File | Use |
|---|---|
| `TPL/AutoChessHeroInfos.xml` (112) | units: `TemplateId = 10000 + MasterType*100 + Star`, `Grade`, `Star`, `NextTemplateId`, `Job` "class,race", stats, `SkillScript`, `Hit` |
| `TPL/AutoChessBuffInfos.xml` (25) | synergies by `Job` and `Amount` |
| `TPL/UpGradeTempInfos.xml` Types=81 | level XP and shop odds |

## 7. Persistent state

Room state is in memory only (a match lasts minutes). See [game-over.md](game-over.md) for the persisted result.

## 8. Backend implementation notes

- `auto_chess::preparation::handle_op` (25031): find the room by `param5` and the seat by session (ignore `param2`/`param4`, they are client supplied); reject if `state != 1` (except op 8) and reply with an unchanged snapshot of the same op.
- `handle_buy` (3): card exists and is not 0, gold >= Grade, bench has a free slot or the purchase completes a merge; remove card (`cardPool[i] = 0`), add unit, run merge (on bench and field, A: field copies have priority for the merged result position); echo op 3.
- `handle_sell` (4): unit exists; gold += `Grade + (Star-1)*2` (A: confirm against the original "★2 = 3 copies"); return copies to the pool (A); echo op 4.
- `handle_move` (5): source not empty; moving bench -> field only if field count < grade or it is a swap; swap when target occupied; echo op 5.
- `handle_refresh` (6): gold >= 2; reroll 5 cards with odds from Types=81 for the player's level, drawing from the shared pool (A); clear lock; echo op 6.
- `handle_add_exp` (7): gold >= 4, level < 7; add 4 XP, level up while XP >= Data; echo op 7.
- `handle_lock` (10): set `lock = p1`; echo op 10.
- `handle_leave` (8): eliminate the player (HP 0, placement = current last), notify others with op 9, send 4217 to the leaver only if required (A: the client already left).
- Broadcast op 9 to all players whenever public data (HP, gold, level, field for tooltips) changes.

## 9. Open questions and assumptions

- (A) Shared unit pool sizes per Grade.
- (A) Bench full purchase rule when it would merge.
- (A) Exact sell refund for ★2 and ★3.
- (A) Whether the lock persists across manual refreshes.

## 10. Implementation checklist

- [ ] 25031 dispatcher with room lookup and phase check.
- [ ] Ops 3, 4, 5, 6, 7, 10 with validations and merges.
- [ ] Op 8 leave and elimination.
- [ ] 4216 encoder (full arrays) and the redraw contract (op echo, op 9 for public changes).
- [ ] Level/XP from Types=81; quality odds.
- [ ] Tests: buy with full bench, move to full field, merge to ★3, refresh without gold, actions during battle phase.
