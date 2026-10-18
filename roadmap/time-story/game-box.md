# Game box ("Caixa do jogo")

Module `game-box` of feature `time-story`. Protobuf package `gamebox`.

Path aliases:

| Alias | File |
|---|---|
| GBM | `decompiled/core_module/scripts/managers/GameBoxManager.as` |
| GBF | `decompiled/m11/scripts/gamebox/GameBoxEnterFrame.as` |
| GBI | `decompiled/m11/scripts/gamebox/view/GameBoxItemView.as` |
| GBE | `decompiled/m11/scripts/gamebox/view/GameBoxExchangeView.as` |
| GBX | `decompiled/m11/scripts/gamebox/view/GameBoxExchangeItem.as` |

## 1. Overview

A hub frame with one card per mini game (scrolled left and right) and an exchange panel. Each game card shows the reward preview and the weekdays it opens ("Abertura do jogo:", "Tempo de abertura do jogo:"); the start button is visible only when the game is open today. The exchange panel shows the player's "Moeda do Jogo" (`GameBoxMedal`, currency -4000, earned in the mini games) and 4 items, one per shop area, rotated daily ("Itens de troca atualizados diariamente").

Game ids (`Game_List` description "1-捕鱼，2-夺宝奇兵，3-云端历险" and `GBM.enterGameN`):

| Game | Name | Client launch on 257 (GBM:116-183) |
|---|---|---|
| 1 | fishing ("Pescar") | no free team ("fish.FishFrame.teamNotice"), level >= 28: sends 9507 op 4 and op 1 `[10,20]`, opens `fish`; forces refuse flags (see [fishing](../fishing/README.md)) |
| 2 | gem maze (夺宝奇兵) | `gemMazeController.startFrameByType(1)` ([mazes](../mazes/README.md)) |
| 3 | cloud adventure (云端历险) | no `enterGame3` in this client (the try/catch swallows it) |
| 4 | final defense | `SceneManager.setScene("FINAL_DEFENSE_SCENE")` ([final-defense](../final-defense/README.md)) |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `GameBoxEnterFrame` (GBF) | "Caixa do jogo" | game cards and exchange panel | NPC option 111, level 28 | cards built from `Game_List` (GBF:108-150; default list hard coded when the config is missing) |
| `GameBoxItemView` (GBI) | | one game card | GBF | open weekdays, 3 reward previews, start button (GBI:80-125) |
| `GameBoxExchangeView` (GBE) / `GameBoxExchangeItem` (GBX) | "Itens de troca atualizados diariamente" | 4 shop slots (areas 1..4) and medal count | GBF | item `tempIdN` of area N from `GameBoxShopTempInfos.xml`, cost `NeedPay`, count `Count` (GBX:53-58) |

## 3. Routes (client to server)

All use C>S 9559 (0x2557) `C_GAMEBOX_OP`, `GameBoxInfoMsg`: request fields `op (#7, INT32)`, `starGameId (#5, INT32)`, `ExchangeIndex (#8, INT32)`, `ExchangeCount (#9, INT32)`.

| op | UI | Sender | Client checks | Response |
|---|---|---|---|---|
| 1 info | frame open (GBF:55) | `GBM.getData` (GBM:58-64) | | 256 op 1 |
| 2 start game, `starGameId` | card start button (GBI:172-180) | `GBM.starGame` (GBM:76-83) | not in `CAMPAIGN_MAP_SCENE` ("worldboss.helper.WorldBossHelper.tip06"); button only visible on open days | 257 op 2 with `starGameId` |
| 3 exchange, `ExchangeIndex = area 1..4`, `ExchangeCount = 1` | exchange button + "Deseja usar {0} Moeda do jogo para trocar {2} x{1}?" (GBX:100-113) | `GBM.exchangeItem` (GBM:66-74) | none (no medal check) | 256 with new `GameBoxMedal` (op other than 1), bag update |

Server checks for op 2: game open today per `Game_List`, level (28 for fishing), player state; for op 3: the area's template of today, medals >= `NeedPay`, daily exchange limit (assumption: once per area per day).

## 4. Server messages (server to client)

### S1. 256 (0x0100) `U_C_GAMEBOX_INFO`, `GameBoxInfoMsg`
Receiver `GBM.onInfo` (GBM:85-114).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `tempId1..tempId4` | #1..#4 | INT32 | today's `GameBoxShopTempInfo.TemplateId` for areas 1..4 |
| `starGameId` | #5 | INT32 | unused here |
| `GameBoxMedal` | #6 | INT32 | game coin balance |
| `op` | #7 | INT32 | 1 refreshes the frame (`GAME_BOX_INFO`) |
| `ExchangeIndex`, `ExchangeCount` | #8, #9 | INT32 | unused |

### S2. 257 (0x0101) `U_C_GAMEBOX_GAMESTART`, `GameBoxInfoMsg`
Receiver `GBM.onOpenGame` (GBM:116-131): when `op == 2` calls `enterGame{starGameId}`. Send only when the server accepts the start.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Level | 28 | `DialogOptionItem.as:753-758`, GBM:150 |
| Schedule | `Game_List` = `1,1,...|1,4,...|2,3,...|2,6,...|3,2,...|3,5,...|3,7,...`: fishing Mon and Thu, gem maze Wed and Sat, cloud adventure Tue, Fri, Sun (weekday 1 = Monday assumption; 0 in the list means every day) | `ConfigInfos.xml`, GBF:108-150, GBI:84-96 |
| Reward preview | items after the weekday in `Game_List` (-4000, 2130005, 208012 for fishing) | `ConfigInfos.xml` |
| Shop | `GameBoxShopTempInfos.xml`: area 1 has 6 rows, area 2: 3, area 3: 3, area 4: 2; one row per area per day | template |

## 6. Templates

| File | Fields |
|---|---|
| `GameBoxShopTempInfos.xml` | `TemplateId`, `ItemTempId`, `Area`, `Count`, `NeedPay` |
| `ConfigInfos.xml` | `Game_List`, fishing keys (see fishing) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS time_story;

CREATE TABLE time_story.game_box_shop_days (
  shop_day        DATE PRIMARY KEY,
  area1_template  INTEGER NOT NULL,
  area2_template  INTEGER NOT NULL,
  area3_template  INTEGER NOT NULL,
  area4_template  INTEGER NOT NULL
);

CREATE TABLE time_story.game_box_exchanges (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  shop_day        DATE NOT NULL,
  area            SMALLINT NOT NULL CHECK (area BETWEEN 1 AND 4),
  template_id     INTEGER NOT NULL,
  exchanged_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, shop_day, area)
);
```

The medal balance is the currency -4000 in [currency](../currency/README.md). The daily rotation may be global (as above) or per player (open question).

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 1 | `time_story::game_box::handle_info` |
| 2 | `time_story::game_box::handle_start` (dispatch to fishing, maze, final defense) |
| 3 | `time_story::game_box::handle_exchange` |

Exchange in one transaction (currency debit, item grant, exchange row). Daily job at 00:00 rolls the 4 areas.

## 9. Open questions and assumptions

- Whether the rotation is global or per player, and the exchange limit.
- Game 3 has no client entry.

## 10. Implementation checklist

- [ ] Screen `GameBoxEnterFrame` with cards and exchange
- [ ] Route 9559 ops 1, 2, 3
- [ ] Server messages 256, 257
- [ ] Tables `time_story.game_box_*`
- [ ] Daily rotation job
- [ ] Tests: weekday gating, exchange cost and limit
