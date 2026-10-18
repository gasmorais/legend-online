# Research: own laboratories, harvest, laboratory level

Module `research` of feature `laboratory`. Covers the research view of `PerkinLabFrame`: the player's 3 laboratories ("Laboratório"), the 3 hour research cycle, harvesting (op 4), the laboratory experience and level (UpGrade Types 134), the Fonte Mágica buffer and the self state message 272.

Path aliases:

| Alias | File |
|---|---|
| PLM | `decompiled/core_module/scripts/managers/PerkinLabManager.as` |
| PMOD | `decompiled/core_module/scripts/mvc/module/perkinlab/PerkinLabModel.as` |
| V | `decompiled/m11/scripts/perkinlab/` |
| TIP | `decompiled/m16/scripts/yishi/view/tips/` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| TM | `decompiled/core_module/scripts/yishi/manager/TempleteManager.as` |

## 1. Overview

- Every eligible player (`vocationGrades > 0`) has exactly 3 laboratories, indexes 0, 1, 2, drawn at fixed positions (`PMOD:38`). The client has no build button: `BUILD_LAB_OP` (2) and `GIVEUP_LAB_OP` (3) exist in `PerkinLabOpClass` but are never sent (`giveHandler` at `V/PerkinLabKengView.as:126-139` is unreferenced). Laboratories therefore exist permanently and research continuously.
- A laboratory is ripe when `now >= harvestTime`; the collect button appears and the castle shows a bubble.
- Production per hour depends on the laboratory level (Types 134), shared by the 3 laboratories. Help text: "Cada pessoa contém 3 laboratórios, no laboratório produz tatuagem comum e avançada, após concluir produção, o jogador pode clicar no botão para coletar."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/PerkinLabFrame.as` | "Laboratório de Plantina" | 1045x725 frame; level bar "Nv.{0}" with exp "cur/need" or "Max"; buttons diary, help ("Regras"), raid view / own view | controller `perkinlab` `show(openType)` (0 research, 1 raid) (`:235-242`, `decompiled/core_module/scripts/mvc/controler/PerkinLabControler.as`) | `TM.getGradeByAdd(134, curExp)` (`:214-233`); Fonte Mágica buffer 20 badge "Ganhos da premiação do Laboratório de Platina +100%" (`:104-118`) |
| `V/PerkinLabBuildView.as` | (research view) | 3 own laboratories | Frame index 0; constructor sends op 0 (`:15-22`) | `selfKengList` by index (`:50-61`) |
| `V/PerkinLabKengView.as` (type 0) | collect button | one laboratory; 1 s timer toggles the collect button | BuildView | tip `PerkinLabKengTip`: "Laboratório", "Tempo de pesquisa: {0}" (countdown or "Amadurecido"), "Previsão de Ganhos:" list (`:173-250`) |
| `TIP/PerkinLabExpTips.as` | "{0} produção {1}/h" x2, "Tem {0}% de chance de obter adicionalmente produção \nde {1} {2} por hora." for current and next level | level tooltip | level bar | Types 134 `TemplateName` (`:46-98`) |
| help frame | "Regras", text `PerkinLabFrame.PerkinHelpFrame.helpContent` | rules | help button | |

## 3. Routes (client to server)

`PerkinLabClientMsg` (sender `PLM.sendLabOperate(op, index = -1)`, `PLM:762-769`): `op (#1, INT32)` operation; `index (#2, SINT32)` laboratory or rival index, or pay type for op 10, -1 when unused; `size (#3, SINT32)` never set.

| `op` | Constant | Module |
|---|---|---|
| 0 | OPEN_FRAME_OP | research (this file) |
| 1 | OPEN_ROBVIEW_OP | [raid.md](raid.md) |
| 2 | BUILD_LAB_OP | never sent |
| 3 | GIVEUP_LAB_OP | never sent |
| 4 | GETREWARD_LAB_OP | research (this file) |
| 5 | ROB_LAB_OP | [raid.md](raid.md) |
| 6 | ROB_REFRESH_OP | [raid.md](raid.md) |
| 7 | REFRESH_MC_COMPLETE_OP | [raid.md](raid.md) |
| 8 | OPEN_LOGFRAME_OP | [log.md](log.md) |
| 9 | REFRESH_AUTOREQUEST_OP | [raid.md](raid.md) |
| 10 | ROB_CD_OP | [raid.md](raid.md) |

### C1. Open the research view (op 0)
- UI: `PerkinLabBuildView` construction (frame index 0, also when switching back from the raid view) (`V/PerkinLabBuildView.as:21`).
- Route: C>S 9566 (0x255e) `C_PERKIN_LAB_CLIENT`, `PerkinLabClientMsg`: `op` = 0, `index` = -1.
- Response: 272 with the 3 laboratories and `rob_count`.

### C2. Collect a laboratory (op 4)
- UI: collect button on a ripe laboratory (`V/PerkinLabKengView.as:141-144`).
- Client checks: button visible only when `sysSecond >= harvestTime` (`:173-186`).
- Route: 9566, `op` = 4, `index (#2, SINT32)` = laboratory index 0..2.
- Response: 272 (laboratory restarted with a new `harvest_time`, empty `missing_reward`), bag pushes for the materials. Quest condition 207 progress (assumption, "Entrar no Laboratório de Platina" may instead count op 0).

## 4. Server messages (server to client)

### S1. 272 (0x0110) `U_C_PERKIN_LAB_SELF`, `PerkinLabSelfMsg`
Receiver `PLM.__updateSelfKengList` (`PLM:109-130`, listener `PLM:104`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `op` | #1 | INT32 | no | echo (not read) |
| `kengList` | #2 | `PerkinLabKengMsg` | yes | the 3 own laboratories |
| `rob_count` | #3 | INT32 | no | raids used today (toolbar badge 29 = `5 - rob_count`, `PMOD:139-148`) |

`PerkinLabKengMsg` fields read for own laboratories: `uid (#1, STRING)` laboratory id; `index (#3, INT32)` 0..2; `harvest_time (#7, INT64)` ripe time in epoch milliseconds (client: `ceil(ms / 1000)`); `missing_reward (#8, STRING)` items already stolen from this cycle, "templateId,count|templateId,count". Unused here: `server_name (#2)`, `rival_detail (#4)`, `rival_battle_army (#5)`, `size (#6)`, `rob_reward (#9)`, `rob_state (#10)`.

Client reaction: replaces `selfKengList`, dispatches `UPDATE_SELF_LIST` (research view and level bar refresh). The castle bubble and the secretary read `PLM.checkHasPick` (`PLM:771-781`).

When: response to op 0 and op 4; push at login (assumption, needed for the castle bubble before opening the frame); push to a defender when one of their laboratories is robbed ([raid.md](raid.md)).

### S2. 260 (0x0104) `U_C_PLAYER_EXTRA_FIELD_MSG`, `PlayerExtraFieldMsg` (owned by [hero](../hero/README.md))
`extraField (#1, ExtraFieldInfoMsg, repeated)`: `fieldId (#1, INT32)`, `field_Type (#2, INT32)`, `userId (#3, INT32)`, `value (#4, STRING)`. Field 20 = laboratory experience (`PerkinLabModel.curExp`), field 12 = winning streak ([raid.md](raid.md)) (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:921-924,953-956`). The frame listens to `PLAYER_EXTRA_FIELD` and refreshes the level bar (`V/PerkinLabFrame.as:128,204-207`).

When: login, and after every raid that changes the experience.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Laboratories | 3 per player, indexes 0..2 | `V/PerkinLabBuildView.as:24-38` |
| Research time | 3 hours (`perkin_lab_harvest_hour` first value) | `CIM:604-611`, `ConfigInfos.xml` "3,1" |
| Level from exp | `getGradeByAdd(134, exp)`: walk the Types 134 rows subtracting each `Data`; level = `Grades - 1` of the first row whose `Data` exceeds the remaining exp, else 10 (max) | `TM:2321-2350` |
| Level exp table (`Data` = exp to reach this level from the previous) | 1: 0, 2: 15, 3: 20, 4: 25, 5: 40, 6: 100, 7: 150, 8: 200, 9: 200, 10: 250 (total 1000) | `UpGradeTempInfos.xml` Types 134 |
| Production per hour (`TemplateName` "a,n|b,m|c;p,k") | level 1..9: 208101 x(2 * level)/h, 208102 x0/h; level 10: 208101 x20/h, 208102 x1/h | Types 134 |
| Bonus chance | "c;p,k": p% chance to get k extra of item c (208102) per hour: levels 1-2 0%, 3: 25%, 4: 40%, 5: 50%, 6: 65%, 7: 80%, 8: 90%, 9: 100%, 10: 20% | `TIP/PerkinLabExpTips.as:70-95` |
| Expected cycle reward (tip) | for each base item: `perHour * 3 - stolen`, using `missing_reward` | `PMOD:62-132` |
| Bonus hours | `perkin_lab_harvest_hour` second value 1 ("额外收获小时数"); assumption: the bonus roll is made for 1 hour per cycle | `ConfigInfos.xml` |
| Fonte Mágica buffer 20 "Tatuagem" | +`AddValue` % (100) to lab rewards while active (8 h) | `MagicSpringTempInfos.xml`, `V/PerkinLabFrame.as:104-118` |
| Experience gain | only from raids: +10 win, +5 loss (`perkin_lab_rob_add_gp` "10,5") | [raid.md](raid.md) |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `UpGradeTempInfos.xml` | `Types="134"` (10 rows) | `Grades`, `Data`, `TemplateName` production string |
| `ConfigInfos.xml` | `perkin_lab_harvest_hour` "3,1"; unused legacy keys `perkin_lab_keng_small` "60#208101,5", `perkin_lab_keng_middle` "300#208101,25", `perkin_lab_keng_big` "600#208101,50" (laboratory sizes of the never used build op) | |
| `MagicSpringTempInfos.xml` | `TemplateId="20"` "Tatuagem" `AddValue` 100, `ValidTime` 8 | buffer |
| `ItemTempInfos.xml` | 208101 "Material de tatuagem", 208102 "Material de tatuagem avançada" | rewards |

## 7. Persistent state

Schema `laboratory`.

```sql
CREATE TABLE laboratory.lab_state (
  player_id            BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  experience           INTEGER NOT NULL DEFAULT 0 CHECK (experience >= 0),   -- extra field 20
  win_streak           INTEGER NOT NULL DEFAULT 0 CHECK (win_streak >= 0),   -- extra field 12
  rob_count            SMALLINT NOT NULL DEFAULT 0 CHECK (rob_count >= 0),
  rob_count_day        DATE NOT NULL DEFAULT CURRENT_DATE,
  rob_cooldown_until   TIMESTAMPTZ,
  rivals_refresh_at    TIMESTAMPTZ,                                          -- next automatic rival refresh
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE laboratory.labs (
  lab_id               BIGSERIAL PRIMARY KEY,                                -- PerkinLabKengMsg.uid (as text)
  player_id            BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  lab_index            SMALLINT NOT NULL CHECK (lab_index BETWEEN 0 AND 2),
  research_started_at  TIMESTAMPTZ NOT NULL,
  harvest_at           TIMESTAMPTZ NOT NULL,
  level_at_start       SMALLINT NOT NULL,                                     -- production level frozen for the cycle (assumption)
  UNIQUE (player_id, lab_index)
);

CREATE TABLE laboratory.lab_losses (
  lab_id             BIGINT NOT NULL REFERENCES laboratory.labs(lab_id) ON DELETE CASCADE,
  item_template_id   INTEGER NOT NULL,
  count              INTEGER NOT NULL CHECK (count > 0),
  PRIMARY KEY (lab_id, item_template_id)
);
```

`lab_losses` is cleared when the cycle restarts and is serialized as `missing_reward`.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9566 `op` 0 | `laboratory::research::handle_open` |
| 9566 `op` 4 | `laboratory::research::handle_harvest` |
| 9566 `op` 2, 3 | `laboratory::research::handle_unused` (reply 272 unchanged) |
| login | `laboratory::research::push_login` (272 and 260 fields 12, 20) |

- `handle_open`: require `vocation_grades > 0` (else ignore); lazily create `lab_state` and the 3 labs (`research_started_at = now`, `harvest_at = now + 3 h`); apply the daily `rob_count` reset; reply 272.
- `handle_harvest`: lab exists and belongs to the player -> `now >= harvest_at` (else reply 272 unchanged) -> reward = for each base item `perHour * 3 - lost`, plus the bonus roll(s) of item 208102, multiplied by `(1 + AddValue/100)` if Fonte Mágica buffer 20 is active -> add to the bag (inventory service) -> restart the cycle (`research_started_at = now`, `harvest_at = now + 3 h`, `level_at_start = current level`, delete `lab_losses`) -> one transaction -> 272 and bag pushes. Count quest condition 207 (assumption).
- `push_login`: 272 with the labs and 260 with fields 12 and 20 so the castle bubble, the secretary and the toolbar badge work.
- Optional: a scheduler that pushes the task trace tip 1001 ("Pesquisa do Laboratório concluída") when a lab ripens for an online player (the tip transport is owned by the tips/quests system; open question).
- `harvest_time` on the wire is epoch milliseconds (INT64).

## 9. Open questions and assumptions

- Assumption: laboratories are created automatically on first open; ops 2 and 3 are not supported (never sent).
- Assumption: research does not continue after ripening (the lab waits until collected).
- Assumption: production uses the level at the start of the cycle; alternatively the level at collection time.
- Open: exact bonus roll (per hour for 3 hours, or once for `perkin_lab_harvest_hour[1]` = 1 hour).
- Open: whether the 208102 base production (level 10) can be stolen (help text: advanced tattoo materials cannot be stolen; see [raid.md](raid.md)).
- Open: transport and trigger of task trace tip 1001.

## 10. Implementation checklist

- [ ] Screens (client ready): `PerkinLabFrame`, `PerkinLabBuildView`, `PerkinLabKengView` (type 0), `PerkinLabKengTip`, `PerkinLabExpTips`.
- [ ] Tables `laboratory.lab_state`, `laboratory.labs`, `laboratory.lab_losses`.
- [ ] Route 9566 op 0 with lazy creation of 3 labs.
- [ ] Route 9566 op 4 harvest with level production, stolen amounts, bonus roll, Fonte Mágica buffer.
- [ ] Server message 272 builder (ms timestamps, reward strings).
- [ ] Login pushes 272 and 260 (fields 12, 20).
- [ ] Level table Types 134 and `getGradeByAdd` equivalent.
- [ ] Tests: new player gets 3 labs ripe 3 h later; harvest before ripe changes nothing; level 1 harvest gives 6x 208101; exp 15 is level 2 (4x 208101 per hour x3 = 12); stolen 3 reduces the harvest by 3; buffer 20 doubles the reward; exp 1000 shows "Max".
