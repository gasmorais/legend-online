# Titan Temple ("Santuário de Titã", titanland)

Module `titanland`. A daily PvE ladder (06:00 to 23:00) inside the "Terrálem" (outyard) hub for job changed players. Five levels, each with four opponents that are copies of top players of the cross server fight ranking. Opponent HP persists between fights; when all four of a level are defeated the next level opens; after all levels new opponents are rolled. The player has limited challenges per day (buyable), can buy three Titan blessing skills, and gets a "Domínio" bonus by number of owned Titans. Rewards per level come from `TitanlandDrop.xml`. Fights are battleType 3860 `TITAN_LAND_BATTLE`.

Path aliases:

| Alias | File |
|---|---|
| OM | `decompiled/core_module/scripts/yishi/manager/OutyardManager.as` |
| OTM | `decompiled/core_module/scripts/mvc/module/outyard/OutyardTitanModel.as` |
| V | `decompiled/m11/scripts/outyard/titan/` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |
| OPS | `decompiled/core_module/scripts/com/road/yishi/proto/titanland/TitanlandOpState.as` |

The rest of `OutyardManager` (stack head, shuttle, events) belongs to [outyard](../outyard/README.md).

## 1. Overview

- Send 9617 (0x2591) `C_TITAN_LAND_OP`, receive 375 (0x0177) `U_C_TITAN_LAND`, both `TitanlandOpMsg`. `op` = `TitanlandOpState` (`OPS`): 0 OPEN, 1 BUY_SKILL, 2 BUY_FIGHT_COUNT, 3 FIGHT, 4 UPDATE, 5 CLOSE, 6 STATUS. The client sends 0, 1, 2, 3.
- Entry: `SPH.openTitanTemple` (`SPH:2331-2348`): `isChangeJob` else "Necessário atingir profissão cavaleiro para entrar"; server clock hour in [6, 23) else "O Santuário de Titã é ativado das 6:00-23:00."; scene check; opens outyard controller openType 9 -> `V/OutyardTitanFrame.as` (`decompiled/core_module/scripts/mvc/controler/OutyardControler.as:83-86`). Callers: space NPC dialog option 118 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:776-778`), day guide 72 (`decompiled/core_module/scripts/managers/DayGuideManager.as:890-892`), `SPH:408`. Unused string "Para entrar precisa completar o desafio do Abismo Sem Fim" suggests an older abyss requirement.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/OutyardTitanFrame.as` | title bitmap, help "Explicação do Santuário de Titã" | main frame: 5 level rows, remaining challenges, buy challenge button, level progress, right panel; Magic Spring buff 17 badge (`:81-132`) | `SPH.openTitanTemple` | `fightLeftCount` digits, `curLevel` progress (`:172-184`) |
| `V/OutyardTitanView.as` | | embedded variant of the same layout | outyard hub | same |
| `V/OutyardTitanPlayerView.as` | | one level row: 4 opponents and a reward box tooltip from `TitanlandDrop` for that level; grey above `curLevel` (`:62-107`) | frame | |
| `V/OutyardTitanPlayerItem.as` | | one opponent: nickname link, HP bar frame `bossHp` (1..100) (`:60-88`); click opens the player menu from `cross/fight.xml` ranking by `orderId` (`:90-138`) | row | |
| `V/OutyardTitanRightView.as` | "Contém {0} titãs" / "Contém {0}+ titãs" | 3 blessing skills (`titanland_skill`) with owned counts, "Domínio" buff list by owned Titans (`titanland_buff`), challenge button | frame | `skillCount1..3`, `DragonTitanManager.model.devourTitan.length` |

## 3. Routes (client to server)

`TitanlandOpMsg` request fields used: `op` (#1, ENUM), `payType` (#2, INT32: 0 = bound diamonds, 1 = diamonds; note this is the opposite convention of the dragon ops), `skillIndex` (#3, INT32).

### A1. Open (op 0 OPEN)
- Sent by the frame constructor (`V/OutyardTitanFrame.as:73`).
- Response: 375 with `op` 0 and the full state; the client fires `CLICK_TITAN_VIEW` which assigns level indexes 1..5 to the rows (`OTM:66-73`, `V/OutyardTitanFrame.as:162-170`).

### A2. Buy a challenge (op 2 BUY_FIGHT_COUNT)
- UI: `_addBtn` (`V/OutyardTitanFrame.as:186-235`, same in `V/OutyardTitanView.as:145-194`).
- Config `titanland_fightcount_buy` = "100,8,10" (price, default daily count, max buys). Client checks `max - fightAddCount > 0` else "auction.view.mysteryshop.BuyGoodsItem.buyTipData"; confirm "Deseja consumir {0} diamantes para comprar 1 chance de desafiar?\n（Hoje ainda pode comprar {1}x）"; balance check (bound or normal).
- Request: `op`=2, `payType`.
- Response: 375 `op` 4 *(assumption: UPDATE)* with `fightLeftCount` +1 and `fightAddCount` +1; currency push.

### A3. Buy a blessing skill (op 1 BUY_SKILL)
- UI: skill buttons 1..3 (`V/OutyardTitanRightView.as:172-245`).
- Config `titanland_skillcount_buy` = "100,3,5|100,3,5|100,3,5" (per skill: price, default count, max). Client checks `skillCountN < max` else "Compra de habilidades já atingiu o limite máximo"; confirm "Deseja consumir {0} diamantes para comprar esta habilidade?".
- Request: `op`=1, `payType`, `skillIndex` = 1..3.
- Response: 375 with `skillCountN` +1.

### A4. Challenge (op 3 FIGHT)
- UI: challenge button (`V/OutyardTitanRightView.as:185-197`): `fightLeftCount <= 0` -> "Chances de desafio insuficiente, não é possível desafiar"; sets `outyardControler._isEnterTitanBattle`.
- Request: `op`=3 (no target: the server picks the next alive opponent of `curLevel` *(assumption)*).
- Response: battle start for battleType 3860 (battle opcodes, `docs/battle/README.md`); after the battle 375 with updated HP, `fightLeftCount`, `curLevel`; rewards by mail or bag *(assumption)*. In battle, the blessing skill 41101001 resets used Titan round flags (`docs/battle/rules.md` row 153); battle result marks `isTitanTempleBattle` (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:394-397`).

## 4. Server messages (server to client)

### S1. 375 (0x0177) `U_C_TITAN_LAND`, `TitanlandOpMsg`
Receiver `OM.__titanLandHandler` (`OM:181-187`) -> `OTM.titanHandler` (`OTM:20-74`): copies every field; `op` 0 -> `CLICK_TITAN_VIEW`, else `UPDATE_TITAN_VIEW`.

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `op` | #1 | ENUM | | echo of the action (0 open, 4 update, 5 close, 6 status) |
| `payType` | #2 | INT32 | | echo |
| `skillIndex` | #3 | INT32 | | echo |
| `fightLeftCount` | #4 | INT32 | | remaining challenges today |
| `fightAddCount` | #5 | INT32 | | challenges bought today |
| `skillCount1..3` | #6..#8 | INT32 | | owned blessing skill charges |
| `bossHp1..4` | #9..#12 | INT32 | | HP percent (1..100 frame index) of the 4 opponents of `curLevel`, in `bossInfo` order |
| `curLevel` | #13 | INT32 | | current level 1..5 |
| `bossInfo` | #14 | TitanlandBoosMsg | yes | all 20 opponents |
| `status` | #15 | INT32 | | activity status (open/closed) *(assumption)* |

`TitanlandBoosMsg`: `userId` (#1), `orderId` (#2, rank in `cross/fight.xml`), `nickName` (#3), `job` (#4), `level` (#5, temple level 1..5). For opponents below `curLevel` the client shows HP 100 (frame "dead"), above shows 1 (`OTM:44-64`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Open hours | 06:00 to 23:00 (`huge_titan_open_time`) | `SPH:2338-2343` |
| Challenges | 8 per day, buy up to 10 more at 100 diamonds | `titanland_fightcount_buy` |
| Blessing skills | ids `titanland_skill` 41101001, 41101002, 41101003; 3 free charges each, buy up to 5 at 100 | `titanland_skillcount_buy` |
| Domínio bonus | `titanland_buff` "1,41102001|2,41102002|3,41102003|5,41102004|7,41102005|9,41102006": owning N Titans grants the listed skill | `V/OutyardTitanRightView.as:105-150` |
| HP persistence | opponent HP kept between fights; new opponents after clearing all (help text items 5 and 6) | `OutyardTitanFrame.helperFrame.helpTxt.text` |
| Rewards | `TitanlandDrop.xml` per level: 208059 and 208060 (level 1: 15 + 60, levels 2..3: 10 + 30, levels 4..5: 5 + 15) *(assumption: granted per defeated opponent)* | `V/OutyardTitanPlayerView.as:76-96` |
| Daily reset | counts reset at the daily reset *(assumption)* | |
| Battle | battleType 3860; opponent units built from the ranked player's snapshot (hero, soldiers, Titan) | `docs/battle/rules.md` row 3860 |

## 6. Templates

| File | Use |
|---|---|
| `TitanlandDrop.xml` | `level`, `itemId`, `count`, `ValidDate` (cate `outyardTitanTemplateCate`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1232`) |
| `ConfigInfos.xml` | `titanland_skill`, `titanland_buff`, `titanland_fightcount_buy`, `titanland_skillcount_buy`, `huge_titan_open_time` |
| `cross/fight.xml` (order path) | ranking used to pick opponents |

## 7. Persistent state

```sql
CREATE TABLE dragon.titanland_progress (
  player_id         BIGINT   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  cur_level         SMALLINT NOT NULL DEFAULT 1 CHECK (cur_level BETWEEN 1 AND 5),
  fight_left_count  SMALLINT NOT NULL DEFAULT 8 CHECK (fight_left_count >= 0),
  fight_add_count   SMALLINT NOT NULL DEFAULT 0 CHECK (fight_add_count BETWEEN 0 AND 10),
  skill_count_1     SMALLINT NOT NULL DEFAULT 3,
  skill_count_2     SMALLINT NOT NULL DEFAULT 3,
  skill_count_3     SMALLINT NOT NULL DEFAULT 3,
  reset_on          DATE     NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE dragon.titanland_opponents (
  player_id        BIGINT   NOT NULL REFERENCES dragon.titanland_progress(player_id) ON DELETE CASCADE,
  temple_level     SMALLINT NOT NULL CHECK (temple_level BETWEEN 1 AND 5),
  slot             SMALLINT NOT NULL CHECK (slot BETWEEN 1 AND 4),
  opponent_user_id INTEGER  NOT NULL,
  order_id         INTEGER  NOT NULL,
  nick_name        TEXT     NOT NULL,
  job              SMALLINT NOT NULL,
  hp_percent       SMALLINT NOT NULL DEFAULT 100 CHECK (hp_percent BETWEEN 0 AND 100),
  snapshot         JSONB    NOT NULL,
  PRIMARY KEY (player_id, temple_level, slot)
);
```

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 0 | `dragon::titanland::handle_open` |
| 1 | `dragon::titanland::handle_buy_skill` |
| 2 | `dragon::titanland::handle_buy_fight_count` |
| 3 | `dragon::titanland::handle_fight` |

- Validation: `isChangeJob` -> open hours -> lazily reset daily counters -> op checks.
- Open: if no opponents, roll 20 from the cross server fight ranking (4 per level, harder levels from higher ranks *(assumption)*), store snapshots.
- Fight: pick the first alive opponent of `cur_level`; decrement `fight_left_count` at start; build battle 3860 with the player's team (hero, Titan round order, blessing skills with charges) vs the snapshot with its stored HP; on result store HP, grant drops for kills, advance level when all four die, reroll after level 5; push 375 `op` 4.
- Scheduler: push 375 `op` 5 CLOSE at 23:00 to players with the frame open *(assumption)*.

## 9. Open questions and assumptions

- *(assumption)* Opponent selection, reward timing and daily reset.
- *(assumption)* Server `op` values 4, 5, 6 semantics beyond names.
- The client never sends a target opponent for op 3.

## 10. Implementation checklist

- [ ] Ops 0, 1, 2, 3 and push 375.
- [ ] Tables `dragon.titanland_progress`, `dragon.titanland_opponents`.
- [ ] Battle 3860 setup and result handling.
- [ ] Domínio buff by owned Titans; blessing skill charges.
- [ ] Tests: entry blocked at 23:00; buying the 11th challenge rejected; skill 1 purchase capped at 5; HP persists between fights; level advances after 4 kills.
