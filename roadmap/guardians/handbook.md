# Guardian handbook: collection, summon by job, soul awakening, spirit compose, assist awakening

Module `handbook`. The handbook ("Ver Guardião" collection) lists all guardian jobs. It shows per job the best level and the soul awakening level, the account "total growth", and lets the player summon a specific job with blood items (op 26), awaken a job's soul so its guardians can be fielded as assist (secondary) guardian (op 25), compose an "Espírito de Proteção" from two guardians (op 28), and awaken a spirit as assist (op 50).

Path aliases:

| Alias | File |
|---|---|
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| CM | `decompiled/core_module/scripts/managers/ChildManager.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/children/ChildModel.as` |
| HB | `decompiled/m14/scripts/child/handbook/` |
| NS | `decompiled/m14/scripts/child/nursingspirit/` |

`ChildrenOpMsg` table: `roster.md` section 1; 4747 (`info`, `totalGrowth`, `childAssistAwakeLevel`): `roster.md` S1.

## 1. Overview

- Collection per job `ChildCollectInfoMsg`: `childType` #1, `soulWakes` #2 (0..5), `growth` #3 (best level of that job) (`CM:667-679`). `totalGrowth` = sum of best levels of all jobs ("Total dos pontos de crescimento = soma do nível mais alto de todos os tipos de guardião").
- Total growth level (`CMOD.curGrowthGrade`, `CMOD:409-432`): `UpGradeTempInfos` Types 120 (18 rows, 1000 each): level = number of full 1000 point steps (0..18).
- Soul awakening (`ChildTypeTempInfos.xml`, 5 levels per job 1..10): `Percentage` 45..85 = share of the main guardian's attributes inherited by an assist guardian of that job; `NeedItemCount` "Pedra da Alma do Guardião" (SonType 620, e.g. 6200001); `NeedArmyPawnTempIds` = soldier template that must be reached in the barracks; `NeedSpecialsTempId` = minimum soldier special level.
- Spirit assist awakening (`ChildAssistUpgradeTemplates.xml`, 10 levels): `SoulStoneCost` of 208525 "Pedra da Alma do Espírito Protetor" (5, 15, 40, 80, 135, 205, ... 635), `AdvanceLevel` = spirit level required (3..12), `Percentage` 40..85.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `HB/ChildHandBookView.as`, `HB/ChildHandBookItem.as` | "Invocar", "Nível comum: {0}", "2ª Elevação Nv.: {0}", "Pontos de Crescimento: {0}", "Já contém: {0}", "Ainda não contém", "Aumento dos pontos totais de crescimento do próx. nível: {0}" | job grid, summon and awaken buttons | `ChildFrame` tab 5 | collection, total growth, inherit stars "Atributos de herança: {0}%" |
| `HB/ChildHandBookRightFrame.as` | "Ver Guardião" | job details per level "{0}% (Nv.{1})" | item click | template rows |
| `HB/ChildCallAlertFrame.as` | "Para convocar {0} é necessário:", "Pontos de crescimento precisa atingir: Nv.{0}" | summon by job | handbook item | `CallNeedItems`, `CallTotalGrowth` |
| `HB/ChildAwakeUpgradeAlertFrame.as` | "Ao configurar como guardião secundário, é herdado atributos do guardião principal em percentagem", "Condições de despertamento:" / "Condições de Elevamento:", "Herança de atributos: {0}%" | soul awakening | handbook item | stones owned (SonType 620 in all bags), soldier conditions |
| `NS/ChildNSComposeView.as`, `NS/ChildComposeSelectView.as`, `NS/ChildComposeSelectItem.as` | "Guardião principal", "Guardião secundário", "Necessário um {0} e um {1} (nível não inferior a {2})" | compose a spirit | spirit frame | `ChildComposeTempInfos` |
| `NS/ChildNSCallFrame.as` | "Herança de Atributos", "Condição do Despertar: Espírito de Proteção atingir Nv. {0}", "Condição da Elevação: Espírito de Proteção atingir Nv. {0}" | spirit assist awakening | spirit frame, `ChildNursingSpiritControler` openType `CALL` | `childAssistAwakeLevel`, stones 208525 |

## 3. Routes (client to server)

All: send 8868 (0x22a4) `C_CHILDREN_OP`.

### A1. Summon a job (op 26 OP_CALL)
- UI: "Invocar" (`HB/ChildHandBookItem.as:155-170`) -> `HB/ChildCallAlertFrame.as:73-88`.
- Client checks: at most 8 guardians of the job ("Já atingiu o limite deste guardião, não é possível convovar"); materials of `CallNeedItems` owned and `curGrowthGrade >= CallTotalGrowth`, else "Condição não completada, não pode convocar".
- Request: `op_type`=26, `property1` = job type.
- Response: 115, 4747 with the new guardian (level 1) and updated `info`/`totalGrowth`.

### A2. Soul awakening (op 25 OP_SOUL_FEED)
- UI: `HB/ChildAwakeUpgradeAlertFrame.as:126-140` (awaken and upgrade buttons).
- Client checks: next `ChildTypeTempInfos` row exists else "O despertamento de alma deste guardião já atingiu o limite máximo"; stones (SonType 620, all bags) >= `NeedItemCount` else "Pedras de alma do guardião insuficiente..."; barracks soldier of the `NeedArmyPawnTempIds` line at least that template level and special level >= `NeedSpecialsTempId` else "Condições do soldado não completadas..." (`:160-205`).
- Request: `op_type`=25, `property1` = job type.
- Response: 115, 4747 `info` with `soulWakes` + 1.

### A3. Compose a spirit (op 28 SPIRIT_COMPOSE)
- UI: `NS/ChildNSComposeView.as:240-258`.
- Recipe `ChildComposeTempInfos.xml`: `JobType` 101..105 from `NeedJobType` pair (1+3, 2+4, 5+6, 7+8, 9+10), both at level >= `NeedGrade` (10), materials `NeedMaterial` "212000,3000|212001,1000" (Cristal da Memória x3000, Sangue do Demônio x1000).
- Client checks: both selected ("Favor selecionar o guardião para sintetizar"), materials ("Materiais insuficientes, não é possível sintetizar"), level ("Nível para elevar o guardião não atingiu Nv.{0}"), not two of the same job ("Não é possível selecionar guardiões do mesmo género para efetuar síntese.").
- Request: `op_type`=28, `property1` = spirit job type, `property6` = main child id, `property7` = secondary child id.
- Response: 115; 4747 with the two inputs removed (`state` -1) *(assumption: both consumed)* and the new spirit; 424 spirit data (`nursing-spirit.md`).

### A4. Spirit assist awakening (op 50 CHILD_ASSIST_AWAKE)
- UI: `NS/ChildNSCallFrame.as:150-170`: stones 208525 >= next `SoulStoneCost` else "Pedras da Alma do Espírito Protetor insuficientes..."; spirit level >= `AdvanceLevel` else "Não tem as condições, não pode despertar ou elevar".
- Request: `op_type`=50, `property1` = child id.
- Response: 115, 4747 `childAssistAwakeLevel` + 1.

## 4. Server messages (server to client)

4747 `U_C_CHILDREN` (`info` #3, `totalGrowth` #4, `childAssistAwakeLevel` #22, new/removed guardians), 115 bag updates, 424 for composed spirits.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Max per job | 8 guardians | `HB/ChildHandBookItem.as:161` |
| Summon cost | `CallNeedItems` (jobs 1..3: 5 blood of one color; 4..6: 5+5; 7..10: 10 of two or three kinds 6190004..6190006) | `ChildTempInfos.xml` |
| Summon gate | `curGrowthGrade >= CallTotalGrowth` (0..7) | `HB/ChildCallAlertFrame.as:80` |
| Total growth level | floor(totalGrowth / 1000), max 18 (Types 120) | `CMOD:409-432` |
| Soul awakening | 5 levels: stones 5, 10, 20, 50, 100; inherit 45..85%; soldier and special requirements | `ChildTypeTempInfos.xml` |
| Assist guardian | can be fielded as assist only when its job has `soulWakes > 0` (normal) or `childAssistAwakeLevel > 0` (spirit) | `decompiled/m14/scripts/child/attribute/ChildFosterViewII.as:487-506`, `CMOD:464-492` |
| Compose | 2 guardians level >= 10 of the paired jobs + 3000 x 212000 + 1000 x 212001 | `ChildComposeTempInfos.xml` |
| Spirit assist | 10 levels, `SoulStoneCost`, `AdvanceLevel`, `Percentage` | `ChildAssistUpgradeTemplates.xml` |

## 6. Templates

| File | Fields |
|---|---|
| `ChildTempInfos.xml` | `CallNeedItems`, `CallTotalGrowth` |
| `ChildTypeTempInfos.xml` (50) | `ChildType`, `SoulWakeGrade`, `Percentage`, `NeedItemCount`, `NeedArmyPawnTempIds`, `NeedSpecialsTempId` |
| `ChildComposeTempInfos.xml` (5) | `JobType`, `NeedJobType`, `NeedMaterial`, `NeedGrade` |
| `ChildAssistUpgradeTemplates.xml` (10) | `Level`, `SoulStoneCost`, `AdvanceLevel`, `TalentLevel`, `Percentage` |
| `UpGradeTempInfos.xml` Types 120 | total growth steps |
| pawn templates (army feature) | soldier requirement |

## 7. Persistent state

```sql
CREATE TABLE guardians.collections (
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  job_type     SMALLINT NOT NULL,
  soul_wakes   SMALLINT NOT NULL DEFAULT 0 CHECK (soul_wakes BETWEEN 0 AND 5),
  best_growth  SMALLINT NOT NULL DEFAULT 0 CHECK (best_growth BETWEEN 0 AND 12),
  PRIMARY KEY (player_id, job_type)
);
```

`totalGrowth` = sum of `best_growth` (computed). `childAssistAwakeLevel` is `guardians.children.assist_awake_level`.

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 25 | `guardians::handbook::handle_soul_awaken` |
| 26 | `guardians::handbook::handle_call` |
| 28 | `guardians::handbook::handle_compose` |
| 50 | `guardians::handbook::handle_assist_awaken` |

- Soul awakening needs the army service to read the barracks soldier line and special level ([army](../army/README.md)).
- Update `best_growth` whenever a guardian of the job levels up (`attributes.md`), and send `info` + `totalGrowth` in the next 4747.

## 9. Open questions and assumptions

- *(assumption)* Compose consumes both guardians and their equipment returns to the bag.
- *(assumption)* `TalentLevel` in assist templates (all 0) is unused.

## 10. Implementation checklist

- [ ] Ops 25, 26, 28, 50.
- [ ] Table `guardians.collections` and `totalGrowth`.
- [ ] Barracks requirement check.
- [ ] Tests: 9th guardian of a job rejected; call with `CallTotalGrowth` 7 rejected at total 6000; compose with level 9 rejected; assist awaken at spirit level 2 rejected.
