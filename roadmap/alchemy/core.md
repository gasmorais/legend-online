# Workshop core: open, 461 snapshot, storage, Alchemy Points

Module `core` of feature `alchemy`. Covers opening the workshop (op 0), the single server message 461 that every other module reuses, the private alchemy storage (ores and catalysts), Alchemy Points ("Pontos de Alquimia"), score levels (UpGrade Types 139), the daily cycle score and the daily speed-up counter.

Path aliases:

| Alias | File |
|---|---|
| AM | `decompiled/core_module/scripts/yishi/manager/AlchemicalManager.as` |
| AMOD | `decompiled/core_module/scripts/mvc/module/alchemical/AlchemicalModel.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| TM | `decompiled/core_module/scripts/yishi/manager/TempleteManager.as` |
| V | `decompiled/m14/scripts/alchemical/` |

## 1. Overview

- The workshop state is per player: Alchemy Points (`score`, 0..285000), daily cycle points (`cycleScore`), daily speed-up count (`speedTimes`), the six mines (see [mines.md](mines.md)), the alchemy storage and the visible shared formulas (see [cooperation.md](cooperation.md)).
- Alchemy storage is not the bag: ores (SonType 702, ids 702p01..702p04 for mine position p) and the catalyst (701000, SonType 701) live only in the workshop and are listed in `AlchemyWorkshopMsg.alchemyItem`. The bottom grid of the Fabricar tab shows every template of SonType 701 and 702 (2 rows x 13 columns), grey when the count is 0 (`V/makeview/AlchemicalMakeBagView.as:49-71`, `V/makeview/AlchemicalMakeBagCell.as:36-61`, `AMOD:120-122`).
- Alchemy Points are item 700000 in formula rewards ("Pontos de Alquimia", description: obtained by mining or alchemy). They never enter the bag.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/AlchemicalFrame.as` | "Fábrica de Alquimia" | 945x620 frame with two vertical tabs: Exploração (index 0) and Fabricar (index 1) | controller `alchemical` (`decompiled/core_module/scripts/mvc/controler/AlchemicalController.as:21`), see README entry points | `show(frameData)` selects `frameData.index` and `frameData.formulaInfo` (op 8 path), else tab 0 (`V/AlchemicalFrame.as:106-119`) |
| `V/makeview/AlchemicalMakeNoteBookView.as` (header) | "Pontos atingidos {0}/{1}" or "Dominou todas as fórmulas, atingiu os pontos máximos\nPontos diários atingiu {0}/{1}"; description = next level `TemplateName` or "Obteve {0} catalisadores"; link "Ver Prêmios" | score progress | Fabricar tab, notebook | `curScore`, next Types 139 `Data`, `cycleScore`/`cycleMaxScore`/`cycleRewardCount` (`:179-192`) |
| `V/makeview/AlchemicalScoreRewardView.as` | "Atingiu {0}pts" + level text; last row "Após atingir {0}pts, já dominoi todas as fórmulas, abrindo os pontos diários.\nOs pontos diários ao atingir a cada {1} pontos, irá obter {2} Catalisador, os pontos serão zerados após o segundo dia." | list of all 32 score levels | "Ver Prêmios" link (`V/makeview/AlchemicalMakeNoteBookView.as:147-166`) | `scoreUpgradeTempArr` (`:46-84`) |
| `V/makeview/AlchemicalMakeBagView.as` + `AlchemicalMakeBagCell.as` | (storage grid) | alchemy storage counts | Fabricar tab | `alchemicalItemList` |
| chat line (channel 3 "Info") | "Pontos atingiram {0}, {1}" | score level reached | `AMOD.scoreGrade` setter, only after the first value of the session (`AMOD:250-273`) | level `Data`, `TemplateName` |

## 3. Routes (client to server)

### C1. Open the workshop (op 0)
- UI: frame construction (`V/AlchemicalFrame.as:38`).
- Sender: `AM.sendAlchemicalOpenRequest` (`AM:176-182`).
- Client checks: entry checks only (`vocationGrades > 0`, see README).
- Route: C>S 9661 (0x25bd) `C_ALCHEMY_WORKSHOP_OP`, `AlchemyWorkshopMsg` with `op (#1, ENUM)` = 0; no other field.
- Response: one 461 with `op` 0, `opResult` 0 and the full snapshot: `speedTimes`, `score`, `cycleScore`, every unlocked mine in `mine`, every non zero storage entry in `alchemyItem`, every visible shared formula in `sharedFormula`.

`AlchemyWorkshopMsg` request fields (all requests use the same message; fields not listed for an op are unset):

| Field | Tag | Type | Rep | Meaning in requests |
|---|---|---|---|---|
| `op` | #1 | ENUM `AlchemyWorkshopOp` | no | 0 OPEN, 1 REAP, 2 PRODUCE, 3 SHARE_PRODUCE, 4 INVITE, 5 SPEED_UP, 8 OPEN_BY_INVITE (6 UPDATE_MINE, 7 UPDATE_ITEM are server only) |
| `mineId` | #3 | INT32 | no | ops 1, 5: mine template id (`AlchemyMineTemplate.Id`) |
| `formulaId` | #4 | INT32 | no | op 2: formula template id |
| `shareUid` | #5 | INT32 | no | ops 3, 4, 8: shared formula id |
| `isAddCatalyst` | #6 | BOOL | no | ops 2, 3: add one catalyst 701000 |
| `childIndex` | #7 | INT32 | no | ops 2 (group formulas only), 3: step number 1..4 |
| `payType` | #8 | INT32 | no | never set by the client (op 5 could use it; default 0) |

## 4. Server messages (server to client)

### S1. 461 (0x01cd) `U_C_ALCHEMY_WORKSHOP_OP`, `AlchemyWorkshopMsg`
Receiver `AM.__alchemicalMsgBackHandler` (`AM:58-161`, listener `AM:55`, registered at login by `decompiled/core_module/scripts/yishi/lunch/Yishi.as:481`).

| Field | Tag | Type | Rep | Meaning | Client handling |
|---|---|---|---|---|---|
| `op` | #1 | ENUM | no | echo of the request op, or 6/7 for pushes | gates `sharedFormula` handling (0, 2, 3, 8) and the op 8 frame opening |
| `opResult` | #2 | ENUM `OpResult` | no | 0 NO_ERROR, 1 FAILED, 2 SHARE_COMPLETE, 3 LACK_ITEM, 4 LACK_POINT, 5 HAS_COMPLETE, 6 LACK_SCORE | only read for op 8 (`AM:153`); no message is shown for any error code |
| `mineId` | #3 | INT32 | no | echo | ignored |
| `formulaId` | #4 | INT32 | no | echo | ignored |
| `shareUid` | #5 | INT32 | no | op 8: the formula to select | `AM:157` |
| `isAddCatalyst` | #6 | BOOL | no | echo | ignored |
| `childIndex` | #7 | INT32 | no | echo | ignored |
| `payType` | #8 | INT32 | no | echo | ignored |
| `speedTimes` | #9 | INT32 | no | speed-ups used today | `model.hasSpeedCount` when present (`AM:69-72`) |
| `score` | #10 | INT32 | no | Alchemy Points | `curScore`, `scoreGrade = TM.getUpgradeGradeBy(139, score)` (`AM:73-77`) |
| `cycleScore` | #11 | INT32 | no | daily cycle points (after the cap) | `AM:78-81` |
| `mine` | #12 | `MineMsg` | yes | unlocked mines | merged by template `Pos`; processed only when non empty (`AM:82-102`) |
| `sharedFormula` | #13 | `SharedFormulaMsg` | yes | visible shared formulas | replaces the whole cooperation list when `op` is 0, 2, 3 or 8 (`AM:119-152`) |
| `alchemyItem` | #14 | `AlchemyItem` | yes | storage entries with absolute counts | merged by `itemId`; processed only when non empty (`AM:103-118`) |

`MineMsg`: `mineId (#1, INT32)` mine template id (its `Pos` places it); `startTime (#2, STRING)` production start, format `YYYY-MM-DD hh:mm:ss` (server local time, parsed by `DateFormatter.parse`).

`AlchemyItem`: `itemId (#1, INT32)` template id (701000 or 702xxx); `count (#2, INT32)` absolute count (send 0 to empty a cell; the entry stays with count 0).

`SharedFormulaMsg` and `ChildFormulaMsg`: see [cooperation.md](cooperation.md) S1.

After every 461 the client notifies `ALCHEMICAL_SELFINFO_UPGATE` (`AM:160`), which refreshes the speed-up counter, mines and the notebook header.

When: response to every 9661 request (same `op`); push with `op` 6 when mines unlock or upgrade ([mines.md](mines.md)); push with `op` 7 when the storage changes outside a request (assumption: catalysts granted by score levels or the cycle score).

Rules for the server:
- Always send absolute values (`score`, `cycleScore`, `speedTimes`, item counts), never deltas.
- `mine` and `alchemyItem` are ignored when empty, so a full refresh cannot clear them; only send entries that exist or changed.
- `sharedFormula` with `op` 0/2/3/8 replaces the list; an empty repeated field clears it. With `op` 1/4/5/6/7 it is ignored.
- `AM:97` pushes the mine object into `mineList` even when it already exists (duplicate references of the same object); harmless, but the server should not send two different mine ids with the same `Pos` in one session (the first object for a `Pos` is reused and overwritten in place).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Score cap | 285000 (`alchemyworkshop_max_score`, not read by the client; last Types 139 level `Data` is also 285000) | `ConfigInfos.xml` |
| Score level | `grade = (Grades - 1)` of the first Types 139 row with `score < Data`, else 32 | `TM:2352-2371` |
| Next level display | first row with `curScore < Data` | `AMOD:197-213` |
| Level rewards (Types 139) | `TemplateId` 0: text only (unlock is implicit through `NeedScore`); 1: grant `ActiveObject` catalysts (3) at levels 2, 4, 11, 29; 2: `ActiveObject` 308 (level 17) and 309 (level 32, text "obterá título Mestre da Alquimia") | `UpGradeTempInfos.xml` Types 139 |
| Cycle score | after the cap, points go to `cycleScore`; every 20000 cycle points grant 3 catalysts; cycle points reset daily ("os pontos serão zerados após o segundo dia") | `alchemyworkshop_cycle_score` = "20000,3", `CIM:708-715`, `AMOD:98-99`, `AlchemicalScoreRewardView.rewardText.titleFull` |
| Daily speed-ups | max 5 (`alchemyworkshop_max_speedup_times`), `speedTimes` resets daily | `CIM:681-688`, `AMOD:97` |
| Formula unlock | `curScore >= NeedScore` (client `isOpen`) | [formulas.md](formulas.md) |
| Mine unlock and upgrade | `score >= NeedScore` of the mine grade | [mines.md](mines.md) |
| Storage cap | `MaxCount` 999 per item template (ItemTempInfos), assumption: excess is lost | `ItemTempInfos.xml` |
| Daily reset time | assumption: server day change (00:00 server time), same as other daily counters | |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `UpGradeTempInfos.xml` | `Types="139"` (32 rows) | `Grades` level, `Data` points needed, `TemplateName` text (mojibake in this dump, display only), `TemplateId` reward kind, `ActiveObject` reward value |
| `ConfigInfos.xml` | `alchemyworkshop_max_score` 285000, `alchemyworkshop_cycle_score` "20000,3", `alchemyworkshop_max_speedup_times` 5, `alchemyworkshop_speed_up_cost` "5,2", `alchemyworkshop_share_outtime` 12, `alchemyworkshop_double_percent` "80,50,80,100,100" | see modules |
| `ItemTempInfos.xml` | 701000 "Catalisador Misterioso" (SonType 701), 702101..702604 ores (SonType 702, Profile 1..4), 700000 "Pontos de Alquimia" (SonType 700) | storage grid, names, icons |

## 7. Persistent state

Schema `alchemy`.

```sql
CREATE TABLE alchemy.workshop_state (
  player_id        BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  score            INTEGER NOT NULL DEFAULT 0 CHECK (score BETWEEN 0 AND 285000),
  score_grade      SMALLINT NOT NULL DEFAULT 0,          -- last Types 139 level whose reward was granted
  cycle_score      INTEGER NOT NULL DEFAULT 0 CHECK (cycle_score >= 0),
  speedup_count    SMALLINT NOT NULL DEFAULT 0 CHECK (speedup_count >= 0),
  daily_reset_on   DATE NOT NULL DEFAULT CURRENT_DATE,   -- day of the last cycle/speed-up reset
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE alchemy.storage_items (
  player_id          BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  item_template_id   INTEGER NOT NULL,                  -- 701000 or 702101..702604
  count              INTEGER NOT NULL DEFAULT 0 CHECK (count BETWEEN 0 AND 999),
  PRIMARY KEY (player_id, item_template_id)
);
```

Mines: `alchemy.mines` in [mines.md](mines.md). Shared formulas: `alchemy.shared_formulas`, `alchemy.shared_formula_steps`, `alchemy.shared_formula_viewers` in [cooperation.md](cooperation.md).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9661 `op` 0 | `alchemy::core::handle_open` |
| 9661 dispatch | `alchemy::core::dispatch` routes by `op` to `alchemy::mines::*`, `alchemy::formulas::*`, `alchemy::cooperation::*` |

- `handle_open`: require `vocation_grades > 0` (else reply 461 `op` 0 `opResult` 1 and nothing else) -> lazily create `workshop_state` and the grade 1 mines whose `NeedScore` is 0 (positions 1 and 2) -> apply the daily reset -> build the snapshot (section 3 C1) in one read transaction.
- Shared helper `alchemy::core::add_score(player, points)` used by formulas and cooperation, inside the caller transaction:
  1. if `score < 285000`: `score = min(285000, score + points)`; overflow above the cap goes to the cycle (assumption);
  2. else `cycle_score += points`; while `cycle_score >= 20000 * (granted_cycles + 1)` grant 3 catalysts (assumption: the counter keeps accumulating during the day and rewards are granted at each multiple);
  3. compute the new level with the Types 139 rule; for each level above `score_grade` grant its reward (`TemplateId` 1: add `ActiveObject` catalysts to storage; 2: grant the title/object `ActiveObject` through the hero feature) and store `score_grade`;
  4. unlock or upgrade mines ([mines.md](mines.md) section 8) and include them in the response (or push 461 `op` 6).
- Daily reset (lazy on every request, or a scheduled job at server day change): `speedup_count = 0`, `cycle_score = 0`, `daily_reset_on = today`. Push 461 (`op` 7 with `speedTimes` and `cycleScore`) to online players with the frame state (optional, the client only shows these while the frame is open).
- Quest and event hooks: each completed formula step counts for quest condition 64 and Funny condition 21 ([quests](../quests/README.md), [seasonal-events](../seasonal-events/README.md)).

## 9. Open questions and assumptions

- Assumption: overflow of points above 285000 in a single reward goes to `cycle_score`.
- Assumption: the cycle reward is granted at each multiple of 20000 reached during the day; the client only displays `cycleScore / 20000`.
- Open: `ActiveObject` 308 and 309 (Types 139 `TemplateId` 2) do not exist in `AppellInfos.xml` of this client; the level 32 text names the title "Mestre da Alquimia". Decide with the hero/title owner.
- Open: whether op 0 with `vocationGrades <= 0` should return an error (the client never sends it).
- Assumption: daily reset at 00:00 server time.
- Errors are silent in the client (no handling of `opResult` except op 8). Optionally send a system tip through the chat/notice feature.

## 10. Implementation checklist

- [ ] Screens (client ready): `AlchemicalFrame`, notebook header, `AlchemicalScoreRewardView`, storage grid.
- [ ] Template loading: Types 139, alchemy config keys, items SonType 700/701/702.
- [ ] Tables `alchemy.workshop_state`, `alchemy.storage_items`.
- [ ] Route 9661 op 0 with full snapshot (speedTimes, score, cycleScore, mines, storage, shared formulas).
- [ ] Server message 461 builder with absolute values and the empty list rules.
- [ ] `add_score` helper: cap, cycle score, catalyst grants, level rewards, mine unlocks.
- [ ] Daily reset of speed-ups and cycle score.
- [ ] Tests: first open creates mines 101 and 201; score 980 reports level 1 and next `Data` 2740; reaching 2740 grants 3 catalysts once; score never exceeds 285000; after the cap 20000 points grant 3 catalysts; next day `speedTimes` and `cycleScore` are 0.
