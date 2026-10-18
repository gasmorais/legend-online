# Roleta do Destino and Proteção do Destino (fate rotary, "命运轮盘" / "命运守护")

Path aliases:

| Alias | File |
|---|---|
| FRC | `decompiled/core_module/scripts/mvc/controler/FateRotaryControler.as` |
| FRMOD | `decompiled/core_module/scripts/mvc/module/faterotary/FateRotaryModel.as` |
| FRSI | `decompiled/core_module/scripts/mvc/module/faterotary/FateRotarySkillInfo.as` |
| FRF | `decompiled/m11/scripts/faterotary/FateRotaryFrame.as` |
| FRSK | `decompiled/m11/scripts/faterotary/FateRotarySkillItem.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| TI | `decompiled/core_module/scripts/yishi/datas/playerinfo/ThaneInfo.as` |
| EV | `decompiled/m5/scripts/armyII/viewII/equip/EquipView.as` |
| DGM | `decompiled/core_module/scripts/managers/DayGuideManager.as` |

## 1. Overview

From level 55 the hero owns three fate guardian skills ("Proteção do Destino", skill SonType 2000 "Determinação", 2200, 2100). Each skill levels up (0..30) by consuming its stone; stones come from the fate wheel ("Roleta do Destino"). Each wheel (one per skill) gives `Fate_FreeCount` (1) free spin per day, then spins cost diamonds with a rising price. A spin lands on a stone count 2, 4, 6, 8 or 20. Paying `Fate_LockTurn` (120) extra diamonds per spin disables the two lowest slots ("Ocultar prêmio de categoria 1-2").

Help (`faterotary.FateRotaryFrame.helpContent`): "1. O jogador pode Consumir a pedra da sorte para para aumentar o Nv.da habilidade defesa da sorte, aumentando a eficácia da habilidade. 2. A pedra da sorte é obtida através da ativação da roda da sorte, o jogador pode ativar gratuitamente a roda da sorte 1 vez por dia. 3. O jogador pode Consumir Diamantes para obter recompensas das 2 primeiras colunas da roda da sorte."

| Wheel index (`index`) | Skill `fateTypes` | Stone | Upgrade type |
|---|---|---|---|
| 1 | 2000 | 208024 "Pedra do Destino" ("Obteve Pedra do Destino x{0}") | 26 |
| 2 | 2200 | 211001 "Selo da Tenacidade" ("Obteve Selo da tenacidade x{0}") | 106 |
| 3 | 2100 | 3300101 "Esfera da Determinação" ("Obteve Esfera da determinação x{0}") | 39 |

Mapping: wheel `index` 1..3 (`FateRotaryModel.index`, FRMOD:8); stones `getStoneId` (FRF:124-137); counters `faterotaryCount` (2000), `faterotaryCount1` (2200), `faterotaryCount2` (2100) (AM:667-678, FRF:326-337); upgrade type by `fateTypes` (FRSI:92-106). The skill shown in tab `i` is the `i`-th of `fateRotarySkillList` sorted by `templateId` (FRF:226-255); assumption: the server sends the three skills so that the sort order matches 2000, 2100, 2200 templates and the wheel index matches the counters above.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `faterotary.FateRotaryFrame` (FRF) | "Proteção do Destino" | Three skill tabs (`FateRotarySkillItem`); wheel with slots 2, 4, 6, 8, 20; buttons spin x1, spin x10; checkbox "Ocultar prêmio de categoria 1-2 {0}"; free spins "Ativações Gratuitas: {0}" or next price "Ativar Roleta {0}" (FRF:288-324); total "Destino: {0}" = sum of `totalGp * 10` (FRF:611-642); help | Hero equip view fate button when level >= 55 and the skill list is not empty (EV:1025-1034, 1182-1183); day guide entry 50 (DGM:738-746, "dayGuide.DayGuideManager.command02" below 55) | counters, skills, stone counts |
| `FateRotarySkillItem` (FRSK) | skill name and "Nv" | Level, GP bar (`currentGp / nextUpgradeTemp.Data`), current and next effect (skill `Description`), "Atingiu" at max, "Não ativado" at level 0, stone count, train amount input and train button; hint "Nova habilidade Auréola obtido no nível {0}" every 5 levels until 15 (FRSK:257-332) | tab of FRF | |

Toolbar: none. Task trace tip "Você ativou a Roleta do Destino" when unlocked (`tasktracetip.view.FateGuardOpenview.content`).

## 3. Routes (client to server)

### R1. Load fate skills
- Trigger: hero reaches level 55 (TI:1064-1067), and at login (assumption: server pushes 4544 without a request).
- Sender: `ArmyManager.getFateRotarySkillList()` (AM:837-841).
- Route: C>S 8628 (0x21b4) `C_FATE_REQUEST` ("命运守护信息请求"), empty body (`send(pkg)`).
- Expected response: 4544 (S1).

### R2. Train a skill (consume stones)
- UI: train button of `FateRotarySkillItem` (FRSK:169-173). Input clamped to the stone count; button enabled when count > 0 and a next level exists (FRSK:175-187).
- Sender: `FateRotaryControler.traintFateGuardSkill(skillSonType, useItemCount)` (FRC:40-47).
- Route: C>S 8626 (0x21b2) `U_C_FATE_TRAIN` ("培养命运守护技能"), body `fate.FateEditMsg` with `skill_sonType` (#1, INT32) = `fateTypes` (2000, 2100, 2200) and `use_itemCount` (#2, INT32) stones to consume.
- Expected response: 115 (stones consumed), 4544 (S1) with the new `total_gp` and `grades` (the `totalGp` setter fires `fategpchange`, which repaints, FRSI:34-38, FRSK:163-167); hero attribute pushes when the level changed.

### R3. Spin the wheel
- UI: spin x1 (FRF:403-432) or x10 (FRF:385-401).
- Sender: `FateRotaryControler.runFateRotary(turnNum, isDisable, index, payType = 1)` (FRC:49-58).
- Client checks and cost (see B3): x1 with a free spin left and no lock: sent directly with `payType 1`. Otherwise a confirmation with a "use bound diamonds" option (`USEBINDPOINT_ALERT`, FRF:434-441): "Deseja gastar {0} diamantes para ativar a Roleta do Destino {1} vezes?" or, x10 with free spins left, "Consumir {0} diamantes para ativar 10 vezes a Roleta do Destino (dentre {1} vezes são gratuitas)?". Balance: bound option `allPoint >= cost` -> `payType 2`; otherwise `point >= cost` -> `payType 1`; else recharge (FRF:443-473).
- Route: C>S 8627 (0x21b3) `C_FATE_TURN` ("运行命运轮盘"), body `fate.FateEditMsg`: `turn_num` (#4, INT32) 1 or 10; `is_disable` (#3, BOOL) lock the two lowest slots; `index` (#11, INT32) wheel 1..3; `pay_type` (#10, INT32) 1 diamonds, 2 bound diamonds first.
- Expected response: 4545 (S2), then 115 (stones added) and 3 (diamonds).

## 4. Server messages (server to client)

### S1. 4544 (0x11c0) `U_C_FATE_REQUEST`
- `fate.FateListMsg`: `fateInfo` (#1, `FateInfoMsg`, repeated).
- `FateInfoMsg`: `template_id` (#1, INT32) current skill template (SkillTempInfos, SonType = `fate_types`, Grades = level); `fate_types` (#2, INT32) 2000, 2100, 2200; `total_gp` (#3, INT64) accumulated GP; `grades` (#4, INT32) level; `property1` (#5, STRING) and `property2` (#6, STRING) stored, unused; `turn_count` (#7, INT32) spins done today on the matching wheel; `index` (#8, INT32) unused by the client.
- Receiver: `ArmyManager.__fateGuardListHandler` (AM:173, 647-680): creates or updates `ThaneInfo.fateRotarySkillList` and the three day counters.
- When: reply to R1 and R2; at login; after a spin when counters change (assumption, the frame updates the counter from S2 anyway).
- Note: the same message is read on 4555 by `PlayerManager.__dragonSoulReqHandler` (`PlayerManager.as:177, 1970-1987`) for the dragon soul; owned by [../dragon/README.md](../dragon/README.md).

### S2. 4545 (0x11c1) `U_C_FATE_TURNREQUEST`
- `fate.FateEditMsg`: `is_success` (#7, BOOL); `count` (#9, INT32, repeated) stones won per spin, in order; `curr_count` (#8, INT32) new spin counter of this wheel; `turn_num` (#4, INT32) spins done (>1 shows the multi effect); `param2` (#6, STRING) "> 0" plays the fly effect of stones; other fields unused.
- Receiver: `FateRotaryFrame.__resuleHandler` (FRF:351, 491-527): on success rotates the wheel to the slot of the last value (`raceDic[last] + 2160 + random * (rndDic[last] - 5)` degrees, FRMOD:17-26), updates the counter, flies "+n" per spin to the skill, then writes "Obteve ... x{sum}" in chat (FRF:716-774). On failure re-enables the buttons.
- When: reply to R3.

## 5. Rules and formulas

`raw/xml/tempinfos/ConfigInfos.xml`:

| Config | Value | Meaning |
|---|---|---|
| `Fate_FreeCount` | 1 | free spins per wheel per day |
| `Fate_Sontype` | 2000,2100,2200 | default fate skills |
| `Fate_LockTurn` | 120 | extra diamonds per spin when `is_disable` |
| `Fate_Turn` | 10,20,30,40,50,60,70,80,90,100 | price of the k-th paid spin of the day (last value repeats) |
| `Fate_AllRandom` | 2,400\|4,250\|6,175\|8,125\|20,50 | slot value, weight (per 1000) |
| `Fate_DisableRandom` | 6,500000\|8,357143\|20,142857 | weights (per 1 000 000) with the lock |

- B1. Unlock: hero level 55 (TI:1064, EV:1182, DGM:739-744).
- B2. Counters: `turn_count` per wheel, reset daily at 00:00 (help "1 vez por dia").
- B3. Cost of `n` spins (`FateRotaryControler.getPointByLeftTime(leftFree, n, wheel)`, FRC:65-110): `free = Fate_FreeCount`, `c = turn_count`. If `leftFree = free - c > 0`, paid spins are 1..`n - free`; else paid spins are `c - free + 1 .. c + n - free`. Price = sum of `Fate_Turn[k-1]` over paid spins (k beyond 10 uses 100). Lock adds `120 * n` (x10: +1200, FRF:390-393; x1 with lock: 120 even when free, FRF:410-416).
- B4. Spin result: weighted roll per spin among `Fate_AllRandom`, or `Fate_DisableRandom` when locked. The value is the stone count of the wheel's stone.
- B5. Training: each stone adds GP (assumption: 1 stone = 1 GP; client shows "Destino" = `totalGp * 10`); level from `UpGradeTempInfos` type 26/39/106 cumulative `Data` (FRSI:70-90); max level 30 (31 rows per type, Grades 0..30).
- B6. `payType 2` allows bound diamonds first (`allPoint = point + giftToken`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Fate_*` | above |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types` 26, 39, 106 | `Grades` level, `Data` GP needed for that level, `TemplateId` skill template of that level |
| `raw/xml/tempinfos/SkillTempInfos.xml` | SonType 2000 (2000..2030), 2100, 2200 | `TemplateName`, `Icons`, `Description` (effect text), `BufferIds` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208024, 211001, 3300101 | stones |

## 7. Persistent state

```sql
CREATE TABLE lotteries.fate_skill (
  player_id    INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  fate_type    INTEGER  NOT NULL CHECK (fate_type IN (2000, 2100, 2200)),
  grade        SMALLINT NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 30),
  total_gp     BIGINT   NOT NULL DEFAULT 0,
  spins_today  INTEGER  NOT NULL DEFAULT 0,
  spin_day     DATE     NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (player_id, fate_type)
);
```

Rows created when the hero reaches level 55.

## 8. Backend implementation notes

- `lotteries::fate::handle_request` (8628): create the three rows if level >= 55; lazy daily reset; reply 4544.
- `lotteries::fate::handle_train` (8626): `fate_type` valid -> `use_itemCount > 0` -> stone count in bag -> grade < 30. Transaction: consume stones (cap at the GP needed to reach level 30), add GP, recompute grade and `template_id`. Reply 115, 4544; if the grade changed, recompute hero attributes (fate skills are passive buffs via `BufferIds`, see [../hero/README.md](../hero/README.md)).
- `lotteries::fate::handle_turn` (8627): level 55 -> `index` 1..3 -> `turn_num` 1 or 10 -> cost per B3 -> balance per `pay_type`. Transaction: debit, roll `turn_num` values, add stones, `spins_today += turn_num`. Reply 4545 (`is_success`, `count`, `curr_count`, `turn_num`, `param2 = "1"`), 115, 3. On failure 4545 `is_success false`.
- No timers besides the daily reset (lazy by `spin_day`).

## 9. Open questions and assumptions

- Assumption: wheel index to skill mapping as in the table (client mixes sorted templates with fixed counters).
- Assumption: GP per stone = 1.
- Open: `property1`, `property2`, `index` of `FateInfoMsg` meaning.

## 10. Implementation checklist

- [ ] Screen `FateRotaryFrame` and skill items, reachable from the equip view at level 55
- [ ] Route 8628 -> 4544; push 4544 at login and at level 55
- [ ] Route 8626 -> 115, 4544, attribute refresh
- [ ] Route 8627 -> 4545, 115, 3
- [ ] Table `fate_skill`
- [ ] Rules B3 price curve, B4 weights with and without lock, B5 levels
- [ ] Test: first spin of the day free; 2nd costs 10, 3rd 20
- [ ] Test: x10 with lock costs sum + 1200
