# Espírito de Proteção (nursing spirit): growth, emblem and resistances, skills, talent, awakening, second advancement

Module `nursing-spirit`. An "Espírito de Proteção" is a guardian of job 101..105 (`ChildTempInfos.MasterType` 1) obtained by composing two guardians (`handbook.md`). It keeps the guardian row (`guardians.children`) and adds spirit state pushed in 424 `U_C_SPIRITINFO`: emblem/resistance tracks, two skill schools (A main, B secondary), a talent tree, an awakening level, the life wheel and the artifact (`nursing-spirit-artifact.md`), and the second advancement training ("2ª Elevação").

Path aliases:

| Alias | File |
|---|---|
| CM | `decompiled/core_module/scripts/managers/ChildManager.as` |
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| NSM | `decompiled/core_module/scripts/mvc/module/children/ChildNursingSpiritModel.as` |
| NSI | `decompiled/core_module/scripts/mvc/module/children/NursingSpiritInfo.as` |
| NSC | `decompiled/core_module/scripts/mvc/controler/ChildNursingSpiritControler.as` |
| V | `decompiled/m14/scripts/child/nursingspirit/` |

`ChildrenOpMsg` table: `roster.md` section 1.

## 1. Overview

| op | Constant (`CS:68-118`) | Action |
|---|---|---|
| 29 | SPIRIT_UPGRADE | spirit growth level (Types 128) |
| 30 | EMBLEM_UPGRADE | spirit emblem (attack/defence/... bonuses, Types 129) |
| 31 | RESI_UPGRADE | spirit resistance (Types 130) |
| 32 | REDUCE_RESI_UPGRADE | spirit anti resistance (Types 131) |
| 33 | NS_SKILL_LEARN | learn a school skill |
| 34 | NS_SKILL_UPGRADE | upgrade a school skill |
| 36 | SPIRIT_TALENT_UPGRADE | talent level (Types 132) |
| 37 | SPIRIT_TALENT_UPGRADE_SKILL | spend a talent point on talent `index` |
| 38 | SPIRIT_TALENT_RESET_POINT | reset talent points (no caller) |
| 39 | AWAKE_SKILL_UPGRADE | awakening level (Types 135) |
| 44 | SPIRIT_OPEN_TRAIN | open the second advancement (level 12) |
| 45 | SPIRIT_TRAIN | second advancement grade up (Types 156) |
| 46 | SPIRIT_TRAIN_UPGRADE | stage up ("Ascensão", Types 157) |
| 47 | SPIRIT_TRAIN_ADD_POINT | add a train point to an attribute |
| 48 | SPIRIT_TRAIN_SKILL_UPGRADE | skill slot enchant up |
| 49 | SPIRIT_TRAIN_SKILL_REFRESH | skill slot enchant refresh |

Entry: `CM.openChildNsFram(type)` (`CM:840-855`): needs `isChangeJob` ("Ativado ao obter Profissão de Cavaleiro") and, for type != 0, at least one spirit ("Você ainda não contém proteção de alma"); army toolbar child button `nursingSpiritBtn` (hotkey U), bag items SonType 624 (spirit books); controller `NSC` openTypes `MAIN`, `OTHER_GROWTH`, `SKILL_LEARN`, `PREVIEW_FRAME`, `AWAKE_UPGRADE_FRAME`, `ENCHANT`, `CALL`, `NS`, `NS_BUFF`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from |
|---|---|---|---|
| `decompiled/m14/scripts/child/ChildNursingSpiritFrame.as`, `V/ChildNursingSpiritListView.as`, `V/ChildNursingSpiritItem.as` | "Espirito de Proteção", "Poder de Combate: {0}" | spirit frame and list | `NSC` `MAIN` |
| `V/ChildNSAttributeView.as`, `V/ChildNsAttValueView.as` | | attributes, awakening state | frame |
| `V/ChildNsEmblemResiUpFrame.as` | "Emblema da Proteção da Alma", "Anti-res da proteção de alma", "Habilidades de despertamento", "Quantidade atual:    {0}" | emblem/resistance/anti resistance tracks (ops 30..32) | `NSC` `OTHER_GROWTH` |
| `V/ChildNSSkillView.as`, `V/ChildNSActiveSkillView.as`, `V/ChildNSPassiveSkillView.as`, `V/ChildNSCommonSkillView.as`, `V/ChildNSProfoundSkillView.as`, `V/ChildNSSkillItemView.as` ("Habilidades do principal" / "Habilidades do secundário") | skill tabs |
| `V/ChildNSLearnSkillFrame.as` | "Aprender habilidades" | learn/upgrade a skill with spirit books | `NSC` `SKILL_LEARN` |
| `V/ChildNsBattleSkillView.as`, `V/ChildNsFMSkillIconView.as`, `V/ChildNsSkillTwoStepView.as` | "Desbloqueado no Grau {0}", "É necessário elevar o grau da 2ª elevação primeiro." | battle bar (op 16, `skills.md`) and advancement skill slots | frame |
| `V/ChildNSTalentView.as`, `V/ChildNSTalentItemView.as` | "Necessário {0} {1}", "Dom natural desta proteção de alma atingiu o nível máximo." | talent | frame |
| `V/ChildNSAwakeView.as`, `V/ChildNSAwakeSkillUpgradeFrame.as` | "Despertamento", "(Efeito automático de despertamento)" | awakening | `NSC` `AWAKE_UPGRADE_FRAME` |
| `V/ChildNSFrame.as` | "2ª Elevação" | second advancement grade, stage, points | `NSC` `NS` |
| `V/ChildNsUpBuffFrame.as` | "Encantamento de Slot de Habilidades", "Máximo nível de Encantamento atingido para seu nível atual" | skill slot enchant | `NSC` `NS_BUFF` |
| `V/ChildNSPreviewFrame.as` | "Ver Espírito Protetor" | preview | `NSC` `PREVIEW_FRAME` |

## 3. Routes (client to server)

All: send 8868 (0x22a4) `C_CHILDREN_OP`, `ChildrenOpMsg`.

| op | Sender (caller) | Fields | Client checks |
|---|---|---|---|
| 29 | `CS.nsUpGrowthValue(29, child, count)` (`decompiled/m14/scripts/child/attribute/ChildUpgradeGrowthView.as:441-444`) | `property1` child, `property2` count of 2250001 | same as `attributes.md` A1; spirit curve Types 128 (Data 30000.. 35000 per level, max 12) |
| 30, 31, 32 | `CS.nsUpGrowthValue(30 + tab, child, count)` (`V/ChildNsEmblemResiUpFrame.as:310-323`) | `property1` child, `property2` item count | item = `TemplateId` of the Types 129/130/131 row (208046/208047/208048 at low levels, 212002/212004/212003 later), quick buy when missing |
| 33 | `CS.nsUpgradeSkill(33, child, learnType, skillId)` (`V/ChildNSLearnSkillFrame.as:121-136`) | `property1` child, `property2` school (A/B) *(assumption on values)*, `property6` skill template | book owned (SonType 624: 212005 active, 212006 Ex, 212007 passive) |
| 34 | `CS.nsUpgradeSkill(34, child, learnType, skillId, count)` | as 33 plus `property7` = book count | same |
| 36 | `CS.nsUpgradeTalent(36, child)` (`V/ChildNSTalentView.as:110-124`) | `property1` child | next Types 132 row else max alert; 212011 "Pedra do Dom Natural da Roleta da Vida" >= `Data` |
| 37 | `CS.nsUpgradeTalent(37, child, index)` (`V/ChildNSTalentItemView.as:82-86`) | `property1` child, `property2` talent index | free talent point *(assumption)* |
| 39 | `CS.nsUpgradeAwakeSkill(child, count)` (`V/ChildNSAwakeSkillUpgradeFrame.as:166-191`) | `property1` child, `property2` count of 212014 "Essência de Zeus" | count clamped to owned |
| 44 | `CS.nsTrainOp(44, child)` (`ChildUpgradeGrowthView.as:409-413`) | `property1` child | spirit at level 12 (button shown only then) |
| 45 | `CS.nsTrainOp(45, child)` (`V/ChildNSFrame.as:288-291`) | `property1` child | materials 208526 "Lâmina de Pedra" (bag + storehouse) |
| 46 | `CS.nsTrainOp(46, child)` (`V/ChildNSFrame.as:293-311`) | `property1` child | 208527 "Pedra da Ascensão" owned >= need, four train attributes >= required grade ("A Ascensão requer que quatro atributos atinjam o Nv. {0}") |
| 47 | `CS.nsTrainOp(47, child, index)` (`decompiled/m14/scripts/child/attribute/ChildNsProItem.as:131`) | `property1` child, `property2` attribute index (1 HP, 2 physical defence, 3 attack, 4 magic defence) | free `trainPoint` |
| 48 | `CS.nsTrainOp(48, child, slot)` (`V/ChildNsUpBuffFrame.as:180-188`) | `property1` child, `property2` slot | 208528 x `child_skill_upgrade` (100, 200, 300, 400, 500 by enchant level) |
| 49 | `CS.nsTrainOp(49, child, slot)` (`V/ChildNsUpBuffFrame.as:189-193`) | same | 208529 x `child_skill_refresh` (100) |

Responses: 115 for consumed items, 424 for spirit state, 4747 when guardian fields change (level, `join_info`, `fight_capacity`).

## 4. Server messages (server to client)

### S1. 424 (0x01a8) `U_C_SPIRITINFO`, `PlayerSpiritInfoMsg`
Receiver `CM.__NursingSpiritInfoHandler` (`CM:427-529`). Spirits must already exist in the guardian list (4747 first). Send at login (all spirits) and after each spirit op.

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `op` | #1 | INT32 | | op that produced the push (35 and 43 carry results) |
| `isSuccess` | #2 | BOOL | | op 35: life wheel success; op 43: enchant refresh success |
| `gpIndex` | #3 | INT32 | | op 35: exp slot hit |
| `resiIndex` | #4 | INT32 | | op 35: resistance hit; op 43: enchant index |
| `results` | #5 | STRING | | op 35: multi turn results |
| `spirits` | #6 | SpiritInfoMsg | yes | state per spirit |

After applying, the client fires `ChildEvent.CHILD_NSINFO_UPDATE` and, when `op` is set, `ChildEvent.CHILD_NS_OP_BACK(op)`.

`SpiritInfoMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `childId` | #1 | INT32 | guardian id |
| `resiGrade`, `resiGp` | #2, #3 | INT32 | resistance track (op 31) |
| `reduceResiGrade`, `reduceResiGp` | #4, #5 | INT32 | anti resistance track (op 32) |
| `jobTypeA`, `skillA`, `skillBookA` | #6, #7, #8 | INT32, STRING, STRING | school A |
| `jobTypeB`, `skillB`, `skillBookB` | #9, #10, #11 | INT32, STRING, STRING | school B |
| `lifeWheel` | #12 | LifeWheelInfoMsg | `nursing-spirit-artifact.md` |
| `talentPoint`, `talentGrade`, `talentGp`, `talentSkill` | #13..#16 | INT32 x3, STRING | talent |
| `awakeGrade`, `awakeGp` | #17, #18 | INT32 | awakening |
| `artifact` | #19 | SpiritArtifactInfoMsg | `nursing-spirit-artifact.md` |
| `trainInfo` | #20 | SpiritTrainInfoMsg | `trainGrade` #1, `stageGrade` #2, `liveGrade` #3, `attackGrade` #4, `phyDefenceGrade` #5, `magDefenceGrade` #6, `trainPoint` #7, `skillEnchants` #8 STRING |

The spirit emblem track (op 30) is reported through the guardian `emblem`/`emblemGp` fields of 4747 *(assumption: `emblemLv` reused for spirits)*.

## 5. Rules and formulas

| Track | Curve (`UpGradeTempInfos` Types) | Material | Notes |
|---|---|---|---|
| Spirit level | 128 (12 levels, 30000..35000 exp) | 2250001 (10 exp each) | then op 44 opens the second advancement (`ChildUpgradeGrowthView.as:280-290`) |
| Spirit emblem | 129 (80 levels, `ActiveObject` 8311..8390 effect ids) | row `TemplateId` (208046, later 212002) | `Data` = exp per level |
| Resistance | 130 (80 levels, value 100..7900) | 208047, later 212004 | |
| Anti resistance | 131 (80 levels, value 100..7900) | 208048, later 212003 | |
| Talent | 132 (560 rows) | 212011 x `Data` | grants talent points *(assumption)* |
| Awakening | 135 (12 levels, `TemplateName` = "HP,ATQ,DEF,MAG,RES" percentages e.g. 50,65,40,65,40) | 212014 Essência de Zeus | |
| Train grade | 156 (630 rows) | 208526 | grants `trainPoint` |
| Train stage | 157 (0..20, `TemplateName` "a,b") | 208527 | requires four attributes at the stage minimum |
| Attribute points | 154 (100 levels) | train points | HP, physical defence, attack, magic defence |
| Skill slot enchant | config `child_skill_upgrade` 100..500, `child_skill_refresh` 100 | 208528, 208529 | |
| Damage reduction | config `child_deamage_reduction` = 84309001..84309005 | | spirit damage reduction skills *(assumption)* |

## 6. Templates

`ChildTempInfos.xml` (jobs 101..105), `UpGradeTempInfos.xml` Types 128..135, 154, 156, 157, `SkillTempInfos.xml` (MasterType 53..57 spirit skills), `ItemTempInfos.xml` (items above), `ConfigInfos.xml` (`child_skill_upgrade`, `child_skill_refresh`, `child_deamage_reduction`).

## 7. Persistent state

```sql
CREATE TABLE guardians.spirits (
  child_id           INTEGER  PRIMARY KEY REFERENCES guardians.children(child_id) ON DELETE CASCADE,
  emblem_grade       SMALLINT NOT NULL DEFAULT 1,
  emblem_gp          INTEGER  NOT NULL DEFAULT 0,
  resi_grade         SMALLINT NOT NULL DEFAULT 1,
  resi_gp            INTEGER  NOT NULL DEFAULT 0,
  reduce_resi_grade  SMALLINT NOT NULL DEFAULT 1,
  reduce_resi_gp     INTEGER  NOT NULL DEFAULT 0,
  job_type_a         SMALLINT NOT NULL,
  skills_a           TEXT     NOT NULL DEFAULT '',
  skill_books_a      TEXT     NOT NULL DEFAULT '',
  job_type_b         SMALLINT NOT NULL,
  skills_b           TEXT     NOT NULL DEFAULT '',
  skill_books_b      TEXT     NOT NULL DEFAULT '',
  talent_point       INTEGER  NOT NULL DEFAULT 0,
  talent_grade       INTEGER  NOT NULL DEFAULT 0,
  talent_gp          INTEGER  NOT NULL DEFAULT 0,
  talent_skills      TEXT     NOT NULL DEFAULT '',
  awake_grade        SMALLINT NOT NULL DEFAULT 1,
  awake_gp           INTEGER  NOT NULL DEFAULT 0
);

CREATE TABLE guardians.spirit_training (
  child_id           INTEGER  PRIMARY KEY REFERENCES guardians.spirits(child_id) ON DELETE CASCADE,
  is_open            BOOLEAN  NOT NULL DEFAULT FALSE,
  train_grade        INTEGER  NOT NULL DEFAULT 0,
  stage_grade        SMALLINT NOT NULL DEFAULT 0,
  live_grade         SMALLINT NOT NULL DEFAULT 0,
  attack_grade       SMALLINT NOT NULL DEFAULT 0,
  phy_defence_grade  SMALLINT NOT NULL DEFAULT 0,
  mag_defence_grade  SMALLINT NOT NULL DEFAULT 0,
  train_point        INTEGER  NOT NULL DEFAULT 0,
  skill_enchants     TEXT     NOT NULL DEFAULT ''
);
```

## 8. Backend implementation notes

Handlers `guardians::nursing_spirit::handle_<action>`: `growth_upgrade` (29), `emblem_upgrade` (30), `resi_upgrade` (31), `reduce_resi_upgrade` (32), `learn_skill` (33), `upgrade_skill` (34), `talent_upgrade` (36), `talent_add_point` (37), `talent_reset` (38), `awake_upgrade` (39), `open_train` (44), `train` (45), `train_stage_up` (46), `train_add_point` (47), `enchant_up` (48), `enchant_refresh` (49).

- Common validation: guardian is a spirit (`MasterType` 1) owned by the household, not fielded by the spouse; items owned; curve has a next row.
- After every op push 115, 424 (with `op`) and, when stats change, 4747.
- Compose (`handbook.md`) must create the `guardians.spirits` row with `job_type_a/b` = the two consumed jobs *(assumption)*.

## 9. Open questions and assumptions

- *(assumption)* `learnType` values for schools A/B.
- *(assumption)* Talent points per talent level and the effect of each talent index.
- *(assumption)* Exp per item for Types 129..131 (row `Data` is the exp to next level; the item `Property1` gives exp).
- Op 38 has no caller.

## 10. Implementation checklist

- [ ] Ops 29..34, 36..39, 44..49.
- [ ] Push 424 with full `SpiritInfoMsg`.
- [ ] Tables `guardians.spirits`, `guardians.spirit_training`.
- [ ] Curves Types 128..135, 154, 156, 157 loaded from templates.
- [ ] Tests: op 29 on a normal guardian rejected; op 44 before level 12 rejected; op 46 with an attribute below the stage minimum rejected; op 47 without points rejected.
