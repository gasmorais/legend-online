# Gold Road ("Caminho de Ouro")

Area: roads, module `gold-road`. Client package `goldroad` (`decompiled/m11/scripts/goldroad`, bag cell `decompiled/core_module/scripts/cell/view/goldroad/GoldRoadBagCell.as`), manager `managers.GoldRoadManager`, model `mvc.module.goldroad.GoldRoadModel`, controller key `goldroad`, proto package `goldenroad`.

Path aliases:

| Alias | File |
|---|---|
| GDM | `decompiled/core_module/scripts/managers/GoldRoadManager.as` |
| GDMOD | `decompiled/core_module/scripts/mvc/module/goldroad/GoldRoadModel.as` |
| GD | `decompiled/m11/scripts/goldroad/` |

## 1. Overview

A time limited dice board event (activity switch 3031). The board has 36 cells around a track (`GDMOD.xyArray`, corners at 0, 9, 18, 27, rare cells at 8, 17, 26, 35). Each cell shows an item reward or a "?" random event. Throwing dice (10 diamonds or one dice item 208051 per die, multiplied by the x1/x2/x5 mode) moves the pawn; the items of the cells passed or landed on drop into a temporary bag (bag type 25, 56 slots) that the player empties into the main bag. Score accumulates across the event ("Durante o evento os pontos não serão zerados"); every 100 points give a "dado aleatório" (choose-your-number die, up to 10 stored, double rewards). The board items can be refreshed for 10 diamonds. Players cannot be in a team; opening the frame turns on refuse invitations.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `goldroad.GoldRoadFrame` (`GD/GoldRoadFrame.as`), 950 x 620 | `gold.GoldRoadFrame.titleText` ("Caminho de Ouro"); buttons "Dado normal 10 diamantes", "Dado duplo 20 diamantes", "Dados 5x 50 diamantes", "Lançar dado", "Usar {0} dados" (batch 50), refresh "Sempre que atualizar itens consumirá {0} diamantes", "Mochila", help "Ajuda no Caminho de Ouro" | Board, pawn, score, dice, drop animation, refresh | top toolbar activity icon `goldroad` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1209-1231`): not in a team ("Você está numa equipe, não é possível participar do evento do Caminho do Ouro."); sends refuse room invite and refuse team invite first | 4933, 4934 |
| `GD/GoldRoadView`, `GoldRoadCell`, `ScoreMovieSprite` | "Após atingir 100 pontos, poderá usar dado aleatório +1"; random cell tip `GoldRoadCell.randomEvent`; events "Avançar {0}", "Recuar {0}", "Você pisou no quadrado aleatório, {0} quadrados", "Você pisou na armadilha, não conseguiu obter nada." | Board cells, super die selector | frame | model |
| `goldroad.GoldRoadBagFrame` (`GD/GoldRoadBagFrame.as`), 422 x 350 | "Mochila temporária"; "Pegar", "Organizar" | Temporary bag (bag type 25), take all, tidy | "Mochila" button | items with `bagType 25` (`decompiled/core_module/scripts/yishi/manager/GoodsManager.as:2024-2044`) |

## 3. Routes (client to server)

All bodies are `goldenroad.GoldenRoadClientRequestMsg`: `consumeType` (#1, INT32), `diceType` (#2, INT32), `refreshType` (#3, INT32), `requestBroadcast` (#4, BOOL), `bagOPType` (#5, INT32), `isBatch` (#6, BOOL).

| # | UI control | Client sender | Client checks | Route and fields | Response |
|---|---|---|---|---|---|
| D1 | Frame open | `GDM.getOrRefreshGoldInfo(1)` (`GDM:102-108`) from `GD/GoldRoadFrame.as:112` | entry checks above | 9520 (0x2530) `C_GOLDENROAD_FRESH`, `refreshType = 1` | 4933 |
| D2 | Refresh board | `GDM.getOrRefreshGoldInfo(2)` (`GD/GoldRoadFrame.as:414-459`) | event not ended ("activity.ActivityManager.command02"); diamonds >= 10; daily "do not ask again" confirm "Deseja consumir {0} diamantes para atualizar novos itens?" | 9520, `refreshType = 2` | 4933 |
| D3 | Throw dice (single or batch) | `GDM.throwDice(mutiCount, 0, isBatch)` (`GDM:110-118`) from `GD/GoldRoadFrame.as:365-412` | temporary bag not full (56, "Mochila temporária cheia, favor pegar primeiro"); event not ended; dice items 208051 >= `mutiCount x n` else diamonds >= `mutiCount x 10 x n` (n = 1 or `Golden_Road_Batch_Times` 50) else recharge; daily confirm "Deseja consumir {0} diamantes para usar {1} dado(s)? (Prioridade de uso {2})" | 9521 (0x2531) `C_GOLDENROAD_CASTDICE`, `diceType` = 1, 2 or 5 (multiplier), `consumeType = 0`, `isBatch` | 4934 |
| D4 | Super die ("dado aleatório") with a chosen face | `GDM.throwDice(2, face)` (`GD/ScoreMovieSprite.as:213-262`) | bag not full; event not ended; diamonds >= `mutiCount x 10` | 9521, `diceType = 2`, `consumeType` = chosen face 1..6 | 4934 |
| D5 | Random event cell reached (drop list contains -1) | `GDM.throwDice(-1, 0)` (`GD/GoldRoadFrame.as:262-268`) | automatic | 9521, `diceType = -1` | 4934 (event move) |
| D6 | Broadcast after the drop animation | `GDM.sendBroadCast(true, 0)` (`GD/GoldRoadFrame.as:244-259`) | when the last dropped item is not -1 | 9522 (0x2532) `C_GOLDENROAD_BROADCAST`, `requestBroadcast = true`, `bagOPType = 0` | world chat broadcast of rare items (assumption) |
| D7 | Bag "Pegar" | `GDM.sendBroadCast(false, 1)` (`GD/GoldRoadBagFrame.as:103-107`) | none | 9522, `requestBroadcast = false`, `bagOPType = 1` | 115 bag moves (inventory) |
| D8 | Bag "Organizar" | `BagHelper.onTidyHandler(bag, 2)` (`GD/GoldRoadBagFrame.as:109-113`) | none | 8220 `C_BAG_ARRANGE` with `bagType 25` ([inventory](../inventory/README.md)) | 115 |
| D9 | Frame open / close | `SocketSendManager.sendRefuseInvite` / `sendRefuseTeamInvite` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:426-437`), restored on close (`GD/GoldRoadFrame.as:600-614`) | only when the player did not refuse already | 8286 (0x205e) `C_ROOM_REFUSE`, 8746 (0x222a) `C_TEAM_REFUSE`, no body | toggles the refuse flags ([team](../team/README.md)) |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 4933 (0x1345) `U_C_GOLDENROAD_FRESH` | `goldenroad.GoldenRoadMsg`: `playerStatue` (#1, INT32) pawn cell 0..35; `score` (#2, INT32); `cellInfo` (#3, repeated `CellInfoMsg`: `itemID` (#1) item template or -1 random event, `count` (#2)), index = cell | `GDM.__goldRoadInfoHandler` (`GDM:59-80`) | D1, D2 |
| 4934 (0x1346) `U_C_GOLDENROAD_CASTDICE` | `goldenroad.CastDiceMsg`: `curPos` (#1) new cell; `diceNumber` (#2) rolled value; `score` (#3); `tempIds` (#4, STRING CSV) item templates dropped in order, -1 = random event cell reached | `GDM.__diceInfoHandler` (`GDM:82-92`); the frame pops at most 5 icons (`GD/GoldRoadFrame.as:207-260`) | D3, D4, D5 |
| 300 (0x012c) `U_C_GOLDENROAD_CLOSE` | no body read | `GDM.__closeGoldRoadFrameHanlder` (`GDM:94-100`): reopens (refreshes) the frame when open | Server side board reset (assumption) |
| 4935 (0x1347) `U_C_GOLDENROAD_SELECT` | not listened | none | unused |
| 4422 (0x1146) `U_C_SWITCH` | `SwitchInfoListMsg.switches`, entry 3031: `isOpen`, `beginDate`, `endDate` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:1505-1575`) | `ConfigManager.info.GOLDROAD*` | Login and on change; the frame closes when the event ends (`GD/GoldRoadFrame.as:615-621`) |
| 115 `U_C_BAG_MOVE_UPDATE` | bag type 25 items | `GoodsManager` | After dice drops and D7 |

## 5. Rules and formulas

- Board: 36 cells (`xyArray` length), corners 0, 9, 18, 27, rare cells 8, 17, 26, 35 (`GDMOD:30-34`).
- Dice price: 10 diamonds per die (`GDMOD.dicePrice`); modes x1/x2/x5 (`GD/GoldRoadFrame.as:326-337`); batch of 50 throws (`Golden_Road_Batch_Times`); dice item 208051 used first.
- Refresh: 10 diamonds.
- Super die: 1 per 100 score, max 10 stored, fixed double rewards (`goldroad.goldRoadFrame.superDiceBtnTipdata`), player chooses the face.
- Random cell events: move forward or back N cells, trap (nothing), or "random square" (strings above).
- Temporary bag: bag type 25, capacity 56 (8 x 7).
- Event window from switch 3031.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Golden_Road_Batch_Times = 50` | batch size |
| Board item pools | not in the client | server configuration (open question) |

## 7. Persistent state

```sql
CREATE TABLE roads.gold_road_state (
    player_id      BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    event_id       integer     NOT NULL,
    position       smallint    NOT NULL DEFAULT 0 CHECK (position BETWEEN 0 AND 35),
    score          integer     NOT NULL DEFAULT 0,
    super_dice     smallint    NOT NULL DEFAULT 0 CHECK (super_dice BETWEEN 0 AND 10),
    board          jsonb       NOT NULL,
    updated_at     timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE roads.gold_road_throw_log (
    id             bigserial   PRIMARY KEY,
    player_id      BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    dice_type      smallint    NOT NULL,
    dice_value     smallint    NOT NULL,
    cost_diamonds  integer     NOT NULL DEFAULT 0,
    items          jsonb       NOT NULL,
    thrown_at      timestamptz NOT NULL DEFAULT now()
);
```

`board` holds the 36 `{itemId, count}` cells. Temporary bag items are inventory rows with `bag_type = 25`.

## 8. Backend implementation notes

- Handlers: `roads::gold_road::handle_fresh` (9520), `handle_cast_dice` (9521), `handle_broadcast` (9522).
- Fresh: `refreshType 1` returns the stored board (generate on first use); `refreshType 2` charges 10 diamonds and regenerates the board.
- Cast: check event window and bag space; consume dice items or diamonds (`multiplier x 10` per throw, x50 for batch); roll 1..6 (or use the chosen face for `diceType 2` and consume a super die), move, collect the cells passed (assumption: landed cell only; the client animates up to 5 icons), multiply counts by the mode, put items in bag 25 (115 pushes), add score, grant a super die per 100 score; `diceType -1` resolves the random event at the current cell.
- Broadcast: `requestBroadcast` true sends a world message for rare items; `bagOPType 1` moves all bag 25 items to the main bag.
- 300 when the board must be reloaded (event reset).

## 9. Open questions and assumptions

- Board item pools and random event probabilities are not in the client.
- Whether items are collected on every passed cell or only on the landing cell.
- Meaning of `consumeType` for normal dice (always 0 in the client).

## 10. Implementation checklist

- [ ] Event switch 3031 in 4422
- [ ] Tables `roads.gold_road_state`, `roads.gold_road_throw_log`
- [ ] D1, D2 board fetch and refresh (4933)
- [ ] D3, D4, D5 dice (4934) with bag 25 drops
- [ ] D6, D7 broadcast and take all
- [ ] D9 refuse invite toggles
- [ ] Tests: costs per mode, super die accrual and cap, bag full rejection, event end
