# Habilidades de Julgamento (avenger skills)

Module `skills` of the feature [Vingador](README.md). Path conventions are in the README.

## 1. Overview

Every avenger owns 6 skills of its job (tab index 0 of `AvengerFrame`):

- 3 **major** skills ("Principal", `MasterType 500`, avenger SP cost 50) and 3 **minor** skills ("Secundário", `MasterType 501`, cost 20). Names (all jobs): "Ataque de meteoro", "Raio explosivo", "Esmagamento total" (major) and "Canhão psíquico", "Rito sagrado", "Corte sônico" (minor).
- One major and one minor are in the battle formation ("Formação"); they are the 2 active slots of the battle bar ([battle.md](battle.md)). The others are the standby skills.
- Each skill has a grade 1..10. To evolve a skill the player first feeds the 6 "Pedra de Julgamento" stones required by the current grade (each stone permanently adds stats to the skill), then evolves when all 6 are full and the body grade is high enough.

Skill SonTypes per job: job 1 = 511..516, job 2 = 521..526, job 3 = 531..536 (`raw/xml/tempinfos/AvengerSkillTemplates.xml` JobType). The skill template id is `SonType * 10000 + grade` (e.g. 5110001..5110010, `raw/xml/tempinfos/SkillTempInfos.xml`).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `avenger.view.AvengerSkillView` (`M5/avenger/view/AvengerSkillView.as`) | tab of "Vingador" (icon) | Select a skill, put it in the formation, open evolution | Tab 0 of `AvengerFrame`; task links 247, 255-259 | 6 `AvengerSkillItem` (left column 3 type 1, right column 3 type 2) filled from `model.showSkillList`, sorted by `MasterType` then `Index` (:94-113, 163-175; `CM/mvc/module/avenger/AvengerModel.as:62-84`); selected skill: name, description, "Nv. {0}" (`public.level4_space2`), cost "{0} slots" with `Cost / 10` (`AvengerSkillView.costText.text`, :181-185), icon; "up" (formation) button enabled only when the selected skill is not in the formation (:187) |
| `avenger.item.AvengerSkillItem` (`M5/avenger/item/AvengerSkillItem.as`) | none | One skill slot | `AvengerSkillView`, `AvengerOtherFrame` (read-only) | Name, icon, "Formação" label and image when `isFight` (`AvengerSkillItem.onText.text`, :116-139); click selects (:101-109) |
| `avenger.AvengerSkillEvolveFrame` (`M5/avenger/AvengerSkillEvolveFrame.as`), key `UPGARDE_FRAME` (`CM/mvc/controler/AvengerControler.as:30-33`) | "Evolução de habilidade" (`AvengerSkillEvolveFrame.title.text`, :253) | Feed stones and evolve | "upgrade" button of `AvengerSkillView` (`AvengerSkillView.as:146-150`) | Current skill (icon, name, tooltip) and next grade skill (:162-182); requirement text "Atenção:É necessário que o nv. do Corpo do Julgamento atinja {0} e tenha nv. máximo de consumo dos itens" with {0} = `BodyType` of `NeedBodyGrade` (:180-181); 6 stat lines (attack, defense, HP, critical, block, penetration) and 6 resistance lines (fire, water, wind, electricity, light, darkness) of the skill (:197-198); one `AvengerSkillEvolveCostItem` per required stone (:202-220); "max" image when no next grade (:183-196) |
| `avenger.item.AvengerSkillEvolveCostItem` (`M5/avenger/item/AvengerSkillEvolveCostItem.as`) | none | One stone requirement | Evolve frame | Stone icon with owned count (bag + stone bag); progress "Consumo:{0}/{1}" (fed/needed) white or green; "Nível máximo" and hidden "Elevar" button when full (:93-128) |
| `avenger.item.AvengerSkillEvolvePropItem` (`M5/avenger/item/AvengerSkillEvolvePropItem.as`) | none | 6 labelled values | Evolve frame | Type 1 keys `AvengerSkillEvolvePropItem.propText11..16` ("Ataque", "Defesa", "Vida", "Crítico", "Bloqueio", "Penetração"); type 2 keys `propText21..26` ("Anti-fogo", "Anti-água", "Anti-vento", "Anti-eletricidade", "Anti-luz", "Anti-escuridão") (:48-57) |

## 3. Routes (client to server)

All routes use **8657 (0x21d1) C_AVENGER_CLIENT_OP** with `player.PlayerOpMsg` (full field list in [core.md](core.md) §3).

### K1. Put a skill in the formation (op 1, SKILL_SET_FIGHT)

| Item | Value |
|---|---|
| UI control | "up" button of `AvengerSkillView` |
| Client sender | `AvengerSkillView._upBtnClickHandler` (`M5/avenger/view/AvengerSkillView.as:137-144`) -> `AvengerManager.sendAvengerSkillRequest(1, skillSontype)` (`CM/yishi/manager/AvengerManager.as:193-200`) |
| Client checks | a skill is selected; the button is disabled when the skill is already in the formation (`AvengerSkillView.as:187`) |
| Request | `op (#1, INT32) = 1`; `type (#2, INT32)` = skill SonType (511..536) |
| Expected response | **4588** `AvengerMsg{opType=1, skillDatas=[the new formation skill, the skill it replaced]}` (the client upserts by SonType) |

### K2. Feed one stone type (op 2, PROMOTE_SKILL)

| Item | Value |
|---|---|
| UI control | "Elevar" button of one `AvengerSkillEvolveCostItem` |
| Client sender | `AvengerSkillEvolveCostItem._promotBtnClickHandler` (`M5/avenger/item/AvengerSkillEvolveCostItem.as:74-86`) -> `AvengerManager.sendAvengerSkillPromote(sonType, itemTemplateId)` (`AvengerManager.as:202-210`) |
| Client checks, in order | 1. requirement not yet full (`fed < need`) and a skill is set, else silent; 2. owned count > 0 (bag + stone bag), else "Materiais necessários insuficentes, não é possível efetuar operação." |
| Request | `op (#1, INT32) = 2`; `type (#2, INT32)` = skill SonType; `templateId (#8, INT32)` = stone item template id (one of `NeedItem1..6` of the current grade row) |
| Expected response | bag update of the stone (inventory feature); **4588** `AvengerMsg{opType=2, skillDatas=[updated skill with new stats and itemInfo]}` |

### K3. Evolve the skill (op 3, EVOLVE_SKILL)

| Item | Value |
|---|---|
| UI control | evolve button of `AvengerSkillEvolveFrame` |
| Client sender | `AvengerSkillEvolveFrame._evolveBtnClickHandler` (`M5/avenger/AvengerSkillEvolveFrame.as:140-153`) -> `sendAvengerSkillRequest(3, skillSontype)` (`AvengerManager.as:193-200`) |
| Client checks, in order | 1. every cost item full (`allReached`, :222-238), else "Materiais necessários para Elevar não são suficientes"; 2. `bodyInfo.grade >= NeedBodyGrade` of the current grade row, else "Nível do Espírito da Vingança insuficiente."; the button is disabled at max grade (:183-186) |
| Request | `op (#1, INT32) = 3`; `type (#2, INT32)` = skill SonType |
| Expected response | **4588** `AvengerMsg{opType=3, skillDatas=[skill with skillId of grade+1, itemInfo reset]}` |

## 4. Server messages (server to client)

| Opcode | Message | Fields used here | Client receiver | When | Client effect |
|---|---|---|---|---|---|
| 4588 (0x11ec) U_C_AVENGER_DATA | `avenger.AvengerMsg` (spec in [core.md](core.md) §4) | `opType (#1)` 1, 2 or 3; `skillDatas (#4, AvengerSkillMsg, repeated)` | `AvengerManager.__avengerMsgUpdateHandler` (`CM/yishi/manager/AvengerManager.as:106-132, 143-146`) | Response to ops 1, 2, 3 (and the full sync, opType 0) | Upsert by `skillSonType` into `model.skillDic`; `SKILL_INFO_UPDATE` refreshes `AvengerSkillView` and `AvengerSkillEvolveFrame` (`AvengerSkillView.as:119, 158-161`; `AvengerSkillEvolveFrame.as:122, 135-138`) |

`AvengerSkillMsg` fields and their client mapping (`AvengerManager.as:114-131`; class `CM/mvc/module/avenger/AvengerSkillInfo.as:9-63`; tags verified at `CM/com/road/yishi/proto/avenger/AvengerSkillMsg.as:480-570`):

| Field | Tag | Type | Client field | Meaning |
|---|---|---|---|---|
| skillId | 1 | INT32 | `skillTempId` | SkillTempInfos TemplateId of the current grade |
| skillSonType | 2 | INT32 | `skillSontype` (dictionary key) | 511..536 |
| attack | 3 | INT32 | `attack` | Fed stats total, shown as "Ataque" |
| magicAttack | 4 | INT32 | not read | Fed magic attack total (stones carry `MagicAttack = Attack`) *(assumption: applied server side)* |
| defence | 5 | INT32 | `defence` | "Defesa" |
| magicDefence | 6 | INT32 | `magicDefence` | not displayed |
| live | 7 | INT32 | `live` | "Vida" |
| forcehit | 8 | INT32 | `forceHit` | "Crítico" |
| parry | 9 | INT32 | `parry` | "Bloqueio" |
| penetrate | 10 | INT32 | `penetrate` | "Penetração" |
| reduceResi | 11 | INT32 | `reduceResi` | not displayed (label `propText29` "Acréscimo de redução de dano: {0}%" exists but is unused) |
| fireResi | 12 | INT32 | `fireResi` | "Anti-fogo" |
| waterResi | 13 | INT32 | `waterResi` | "Anti-água" |
| electResi | 14 | INT32 | `electResi` | "Anti-eletricidade" |
| windResi | 15 | INT32 | `windResi` | "Anti-vento" |
| darkResi | 16 | INT32 | `darkResi` | "Anti-escuridão" |
| lightResi | 17 | INT32 | `lightResi` | "Anti-luz" |
| isUse | 18 | BOOL | `isFight` | In the formation |
| itemInfo | 19 | STRING | `needItems` | Fed stones of the current grade: `"tid,count\|tid,count"`; parsed by `AvengerSkillEvolveCostItem.hasCostCount` (:135-151). Must list every fed stone template of the current grade row |

No error code. On rejection send nothing.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Skills per avenger | 6 of the hero job (JobType 1/2/3) | `AvengerSkillTemplates.xml`; view `skillLen = 6` (`AvengerSkillView.as:52`) |
| Formation | exactly 1 major (MasterType 500) and 1 minor (501) with `isUse = true` *(assumption: matches the 2 active battle slots "Principal"/"Secundário", `CM/battle/view/ui/AvengerBattleSkillView.as:139-173`)*. Op 1 sets the chosen skill and clears the other skill of the same MasterType *(assumption)* | |
| Grades | 1..10; next grade exists when both `AvengerSkillTemplates(SonType, grade+1)` and `SkillTempInfos(SonType, grade+1)` exist (`AvengerSkillEvolveFrame.as:165-168`) | template |
| Stones per grade | 6 stone types per grade row (`NeedItem1..6`, `NeedItemNum1..6`). Counts: grades 1-6: 10 each; 7-8: 15; 9: 20; grade 10 has none (max) | `AvengerSkillTemplates.xml`; `CM/yishi/datas/templates/AvengerSkillTempInfo.as:43-78` |
| Stone tiers | grade 1: basic 5001101-5001106; 2: intermediate x3 + basic x3; 3: intermediate; 4: advanced x3 + intermediate x3; 5: advanced; 6-7: advanced dual 5003301-5003306; 8-9: special dual 5003401-5003406 (same for every SonType) | template |
| Feeding (op 2) | consumes stones of one template into the current grade; `fed <= need`. Amount per click *(assumption: `min(owned, need - fed)`; the client does not send a count)* | `AvengerSkillEvolveCostItem.as:74-86` |
| Stats from feeding | each fed stone adds its `ItemTempInfos` stats to the skill: e.g. 5001101 `Attack 150, MagicAttack 150`; 5001104 `ForceHit 75`; 5003301 `Attack 350, MagicAttack 350, FireResi 20` *(assumption: skill stat = sum of fed stones x item stats; the item descriptions say "Ataque +150")* | `raw/xml/tempinfos/ItemTempInfos.xml` |
| Evolve requirement | all 6 stones full and `body_grade >= NeedBodyGrade` of the current grade row (33, 55, 77, 99, 121, 143, 165, 187, 209 for grades 1..9) | `AvengerSkillEvolveFrame.as:140-153`; template |
| Evolve effect | `skillId` -> template of grade+1; `itemInfo` reset to empty *(assumption)*; fed stats are kept *(assumption: stats are cumulative across grades)* | |
| Skill effect in battle | SkillTempInfos row: Cost 50 (major) or 20 (minor) avenger SP, CoolDown 1000, BufferIds, Description (e.g. 5110001 "Causa 340% de dano de 2 a 4 inimigos e Atordoamento ao alvo por 2 turnos", 5110010 "Causa 475% ...") | `SkillTempInfos.xml` |
| Cost display | "{0} slots" = `Cost / 10` (5 or 2); skill tooltip "Gasto de slot de Vingança: {0}" | `AvengerSkillView.as:184-185`; `m16/scripts/yishi/view/tips/goods/SkillTips.as:230, 625-628` |
| Task 256 (holy prerequisite) | count of skills with grade >= Para2 must be 6 | `CM/mvc/module/task/TaskTemplate.as:1505-1520` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/AvengerSkillTemplates.xml` (180 rows; `AvengerSkillTempCate.getTemplateByTypeAndGrade(SonType, SkillGrade)`, `CM/yishi/datas/templates/cate/AvengerSkillTempCate.as:19-40`; loaded at `CM/yishi/manager/TempleteManager.as:1300`) | evolve cost of one skill grade | `Id`, `SkillSonType`, `JobType` (server only), `SkillGrade`, `NeedBodyGrade`, `NeedItem1..6`, `NeedItemNum1..6` |
| `raw/xml/tempinfos/SkillTempInfos.xml` rows SonType 511..536 (180 rows) | the skill itself | `TemplateId`, `TemplateName`, `Icons`, `MasterType` (500 major, 501 minor), `SonType`, `Grades`, `Index` (sort and pairing), `Cost`, `CoolDown`, `BufferIds`, `Description` |
| `raw/xml/tempinfos/ItemTempInfos.xml` SonType 500 (5001101-5001306, 5002001-5002006, 5003301-5003406) | "Pedra de Julgamento" stones | Per stone: `Attack` + `MagicAttack` (x01), `Defence` + `MagicDefence` (x02), `Live` (x03), `ForceHit` (x04), `Parry` (x05), `Penetrate` (x06); basic 150/150/900/75/75/75, intermediate 225/225/1350/112/112/112, advanced 350/350/2100/175/175/175, special 525/525/3150/262/262/262; dual stones add `FireResi`/`WaterResi`/`ElectResi`/`WindResi`/`DarkResi`/`LightResi` 20 (advanced) or 30 (special); 5002001-5002006 carry only one resistance of 20 and are not used by any requirement row |

## 7. Persistent state

```sql
-- One row per avenger skill (6 per player).
CREATE TABLE avenger.skills (
  player_id         bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  skill_son_type    smallint NOT NULL CHECK (skill_son_type BETWEEN 511 AND 536),
  master_type       smallint NOT NULL CHECK (master_type IN (500, 501)),
  grade             smallint NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 10),
  skill_template_id integer  NOT NULL,                 -- SkillTempInfos.TemplateId of the current grade
  is_in_formation   boolean  NOT NULL DEFAULT false,
  attack            integer  NOT NULL DEFAULT 0,
  magic_attack      integer  NOT NULL DEFAULT 0,
  defence           integer  NOT NULL DEFAULT 0,
  magic_defence     integer  NOT NULL DEFAULT 0,
  live              integer  NOT NULL DEFAULT 0,
  force_hit         integer  NOT NULL DEFAULT 0,
  parry             integer  NOT NULL DEFAULT 0,
  penetrate         integer  NOT NULL DEFAULT 0,
  reduce_resi       integer  NOT NULL DEFAULT 0,
  fire_resi         integer  NOT NULL DEFAULT 0,
  water_resi        integer  NOT NULL DEFAULT 0,
  elect_resi        integer  NOT NULL DEFAULT 0,
  wind_resi         integer  NOT NULL DEFAULT 0,
  dark_resi         integer  NOT NULL DEFAULT 0,
  light_resi        integer  NOT NULL DEFAULT 0,
  updated_at        timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, skill_son_type)
);
-- At most one major and one minor skill in the formation.
CREATE UNIQUE INDEX skills_one_in_formation_per_master
  ON avenger.skills (player_id, master_type) WHERE is_in_formation;

-- Stones fed into the current grade of a skill (source of AvengerSkillMsg.itemInfo).
CREATE TABLE avenger.skill_feeds (
  player_id         bigint   NOT NULL,
  skill_son_type    smallint NOT NULL,
  item_template_id  integer  NOT NULL,
  fed_count         integer  NOT NULL CHECK (fed_count > 0),
  PRIMARY KEY (player_id, skill_son_type, item_template_id),
  FOREIGN KEY (player_id, skill_son_type) REFERENCES avenger.skills (player_id, skill_son_type) ON DELETE CASCADE
);
```

The stat columns can also be recomputed from a full feed history; they are stored because fed rows are cleared at each evolution *(assumption)*.

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `avenger::skills::handle_set_formation` | 8657 op 1 | avenger -> `type` is one of the player's 6 SonTypes -> not already in formation | One tx: clear `is_in_formation` on the same `master_type`, set it on `type`. Push 4588 opType 1 with both changed skills. Battle bar uses the new formation from the next battle |
| `avenger::skills::handle_feed_stone` | 8657 op 2 | avenger -> skill exists -> grade row exists and has requirements -> `templateId` is one of `NeedItem1..6` -> fed < need -> owned > 0 | One tx: `n = min(owned, need - fed)` *(assumption)*; consume n stones (inventory API); upsert `skill_feeds`; add `n x item stats` to the skill columns. Push bag update + 4588 opType 2 with the skill. Recompute hero stats |
| `avenger::skills::handle_evolve` | 8657 op 3 | avenger -> skill exists -> next grade rows exist (AvengerSkillTemplates and SkillTempInfos) -> every `NeedItemN` fed to `NeedItemNumN` -> `body_grade >= NeedBodyGrade` | One tx: grade+1, `skill_template_id` of the new grade, delete `skill_feeds` of the skill. Push 4588 opType 3. Recompute hero stats |

- `AvengerMsg.skillDatas` entries must always carry every field (the client overwrites all fields of the upserted skill, `AvengerManager.as:114-131`).
- The avenger skill list for battles (`HeroMsg.avengerSkills` / `avengerAllSkills`) is built from this table: `skill_template_id` of formation skills and of all 6 skills ([battle.md](battle.md)).
- Skill stats contribute to the hero attributes (fighting capacity).

## 9. Open questions and assumptions

1. *(assumption)* Op 1 keeps exactly one major and one minor in the formation by swapping within the same MasterType.
2. *(assumption)* Op 2 consumes `min(owned, need - fed)` stones; it might consume 1 per click.
3. *(assumption)* Skill stats are the sum of fed stone stats and are kept after evolution; `itemInfo` resets at evolution.
4. `reduceResi`: no "Pedra de Julgamento" carries a `ReduceResi` stat, so it stays 0 unless another source exists.
5. Stones 5002001-5002006 (resistance only) appear in no requirement row; their use is unknown (maybe other features).

## 10. Implementation checklist

- [ ] Screen `AvengerSkillView` + `AvengerSkillItem` (formation label, selection, cost)
- [ ] Screen `AvengerSkillEvolveFrame` + `AvengerSkillEvolveCostItem` + `AvengerSkillEvolvePropItem`
- [ ] Route 8657 op 1 -> `avenger::skills::handle_set_formation`
- [ ] Route 8657 op 2 -> `avenger::skills::handle_feed_stone`
- [ ] Route 8657 op 3 -> `avenger::skills::handle_evolve`
- [ ] Server message 4588 opType 1/2/3 with complete `AvengerSkillMsg`
- [ ] Tables `avenger.skills`, `avenger.skill_feeds` (+ unique formation index)
- [ ] Rule: stone requirements per grade, NeedBodyGrade gate, max grade 10
- [ ] Rule: skill stats into hero attributes
- [ ] Template loaders `AvengerSkillTemplates.xml`, SkillTempInfos SonType 511..536, stone stats from ItemTempInfos
- [ ] Test: formation swap keeps one major and one minor
- [ ] Test: feeding beyond the requirement is capped; feeding a stone not in the row is rejected
- [ ] Test: evolve rejected without full stones or with low body grade; accepted otherwise and resets `itemInfo`
