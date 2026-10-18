# Lâmina do Espírito de Proteção (avenger child sword, disabled)

Module `child-sword` of the feature [Vingador](README.md). Path conventions are in the README.

## 1. Overview

**Status: disabled in this build.** The tab is added to `AvengerFrame` only when `VersionSwitch.CHILD_NS` is true (`M5/avenger/AvengerFrame.as:88-91, 100-103`), and `CHILD_NS = false` (`CM/yishi/datas/VersionSwitch.as:202`). All senders below are reachable only from that tab. The receiver of 4276 is always registered (`CM/yishi/manager/AvengerManager.as:66`). The guardians feature has a parallel UI with the same data shape (`NursingSpiritInfo.trainInfo:AvengerChildNsInfo`, `CM/mvc/module/children/NursingSpiritInfo.as:47, 54`; `M14/child/nursingspirit/ChildNSFrame.as:318`; `ChildNsUpBuffFrame.as:316`) that does not use these opcodes; see [../guardians/README.md](../guardians/README.md).

For each nursing-spirit guardian child ("Espírito de Proteção", one per child job, 5 in the list), the avenger owns a sword ("Lâmina do Espírito de Proteção") with:

- a **sword level** (`grade`, 0..630) trained with "Lâmina de Pedra" 208526;
- **points** to spend on 3 attributes: life (+1500 per level), defense (+200), attack (+200), capped by the stage;
- a **stage** (`stageGrade` 0..20) in 6 color tiers (white, green, blue, purple, orange, red; `profileGrade` 0..5) raised by "Ascensão" with 208527, which also raises the attribute cap and the "Pacto de Sangue" level;
- 3 **sword skills**: index 30 "Pacto de Sangue" (automatic, level = color tier), index 31 passive (learned/raised with book 208528), index 32 active "Vingança·..." (book 208529).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `avenger.view.AvengerChildNsView` (`M5/avenger/view/AvengerChildNsView.as`) | tab (icon) | Host | Tab 4 (hidden) | List + sword view (:27-36) |
| `avenger.view.AvengerChildNsListView` (`M5/avenger/view/AvengerChildNsListView.as`) | none | Pick a nursing spirit child | Tab 4 | 5 `AvengerChildNsItem` from `ChildManager.nsModel.nsTempList` (guardians feature); first selected by default (:20-60) |
| `avenger.view.AvengerChildNsSwordView` (`M5/avenger/view/AvengerChildNsSwordView.as`) | none | Train the sword, open sub-frames | Tab 4 | Stage text = color name + "Nv.{n}" (:347-348); sword level; life/defense/attack bonuses (:355-357); points (:358); exp bar `exp / UpGrade(156, grade+1).Data` (:359-370); owned 208526 "(Quantidade atual: {0})" (:343-344); 3 prop items with "+" button when points > 0 (:191-206); 3 skill icons (index 30, 31, 32) with "Aprende no Nível{0}" for locked ones (:467-514); grey and disabled when the child has no sword data (:372-388); learnable-skill flicker (:393-402, 535-592); help tip `AvengerChildNsSwordView.tipsImage.tipData` |
| `avenger.AvengerChildNsSwordUpgradeFrame` (`M5/avenger/AvengerChildNsSwordUpgradeFrame.as`), key `CHILDNS_PROP_FRAME` (`CM/mvc/controler/AvengerControler.as:42-45`) | "Ascensão da Lâmina do Espírito de Proteção" (`AvengerChildNsSwordUpgradeFrame.title.text`) | Stage ascension | upgrade button of the sword view (`AvengerChildNsSwordView.as:297-305`) | Current stage and "Próximo estágio: {0}" / "O estágio máx. foi atingido"; blood-pact skill icon "{grade}/{max}"; "Necessita {0}" 208527 = `UpGrade(157, stage+1).Data`, "Possui {0}"; "Requer 3 atributos da Lâmina do Espírito de Proteção com Nv.{0}"; 3 prop items (read-only); help "Descrição da Habilidade" (:201-249) |
| `avenger.AvengerChildNsSkillFrame` (`M5/avenger/AvengerChildNsSkillFrame.as`), key `CHILDNS_SKILL_FRAME` (`AvengerControler.as:46-49`) | "Aprender habilidades" (`docs/ui/screens.md`) | Learn/upgrade sword skills 31 and 32 | sword button (`AvengerChildNsSwordView.as:307-315`) | 2 `AvengerChildNsSkillItem` (:68-89) |
| `avenger.item.AvengerChildNsSkillItem` (`M5/avenger/item/AvengerChildNsSkillItem.as`) | none | One learnable skill | Skill frame | Name, "{grade}/{max}", requirement "Requer Lâmina do Espírito de Proteção Nv.{0}" or "Requer {0} {1}" (book name, count), exp bar `skillExp / learnCount` (:182-255) |
| `avenger.AvengerChildNsSkillInputFrame` (`M5/avenger/AvengerChildNsSkillInputFrame.as`) | "Usar em massa" (`bag.view.MulItemUseFrame.command01`) | Amount of books | Upgrade button of a skill item (:153-170) | Owned books; input defaults to all owned, clamped 1..owned (:40-110) |

## 3. Routes (client to server)

All routes use **8657 (0x21d1) C_AVENGER_CLIENT_OP** with `player.PlayerOpMsg` (full field list in [core.md](core.md) §3). Expected response for all: bag update of the consumed item (inventory feature) and **4276** with the changed sword.

| # | Action | UI control and client sender | Client checks | Request fields |
|---|---|---|---|---|
| N1 | Train sword (op 9, OP_SPIRIT_UPGRADE) | train button: `AvengerChildNsSwordView.__trainClickHandler` (`M5/avenger/view/AvengerChildNsSwordView.as:317-330`) -> `AvengerManager.sendChildNsUpgrade(childId, count)` (`CM/yishi/manager/AvengerManager.as:258-266`) | sword data exists; `count <= owned 208526`, else "Materiais necessários insuficentes, ..."; input clamped (:283-295); button disabled at max level (:359-370) | `op (#1) = 9`; `id (#5, INT32)` = child id; `count (#4, INT32)` = stones to consume |
| N2 | Ascend stage (op 10, OP_SPIRIT_UPGRADE_STAGE) | ascension button: `AvengerChildNsSwordUpgradeFrame.__upgradeClickHandler` (`M5/avenger/AvengerChildNsSwordUpgradeFrame.as:176-194`) -> `sendChildNsStage(childId)` (`AvengerManager.as:268-275`) | owned 208527 >= `UpGrade(157, stage+1).Data`, else "Materiais necessários insuficentes, ..."; life, defense and attack levels all >= `UpGrade(157, stage+1).TemplateName[1]`, else "A Ascensão requer que três atributos atinjam o nível {0}" (:251-270); disabled at max stage | `op (#1) = 10`; `id (#5, INT32)` = child id |
| N3 | Add an attribute point (op 11, OP_SPIRIT_UPGRADE_ATTR) | "+" of a prop item: `AvengerChildNsPropItem.__addPropHandler` (`M5/avenger/item/AvengerChildNsPropItem.as:73-86`) -> `sendChildNsPropUpgrade(childId, index)` (`AvengerManager.as:277-285`) | button visible only when `point > 0` (:99); attribute level < cap `UpGrade(157, stage).TemplateName[0]`, else "Atingiu o nível mais alto do grau atual" (:79-83, 145-153) | `op (#1) = 11`; `id (#5, INT32)` = child id; `index (#6, INT32)` = 1 life, 2 defense, 3 attack (:118-143) |
| N4 | Learn a sword skill (op 12, OP_SPIRIT_LEARN_SKILL) | learn button: `AvengerChildNsSkillItem.__learnBtnClickHandler` (`M5/avenger/item/AvengerChildNsSkillItem.as:137-151`) -> `sendChildNsLearnSkill(childId, templateId)` (`AvengerManager.as:287-295`) | sword level >= open level, else "Requer Lâmina do Espírito de Proteção Nv.{0}"; owned books >= learn count, else "Requer {0} {1}" | `op (#1) = 12`; `id (#5, INT32)` = child id; `templateId (#8, INT32)` = grade 1 skill template (index 31 or 32) |
| N5 | Upgrade a sword skill (op 13, OP_SPIRIT_UPGRADE_SKILL) | upgrade button -> `AvengerChildNsSkillInputFrame` -> `AvengerChildNsSkillItem.inputHandler` (:153-175) -> `sendChildNsUpgradeSkill(childId, templateId, count)` (`AvengerManager.as:297-306`) | sword level >= open level; owned books > 0, else "Não há o {0}necessário"; disabled at max skill grade | `op (#1) = 13`; `id (#5, INT32)` = child id; `templateId (#8, INT32)` = current skill template; `count (#4, INT32)` = books to feed |

## 4. Server messages (server to client)

### 4276 (0x10b4) U_C_AVENGER_SPIRIT_DATA

Message `avenger.AvengerSpiritMsg{spiritDatas (#1, AvengerSpiritDataMsg, repeated)}` (tag verified at `CM/com/road/yishi/proto/avenger/AvengerSpiritMsg.as:25`).

`AvengerSpiritDataMsg` (tags verified at `.../avenger/AvengerSpiritDataMsg.as:240-280`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| childId | 1 | INT32 | Guardian child id (key) |
| grade | 2 | INT32 | Sword level 0..630 |
| exp | 3 | INT32 | Exp inside the level |
| stageGrade | 4 | INT32 | Stage 0..20 |
| liveGrade | 5 | INT32 | Life attribute level |
| attackGrade | 6 | INT32 | Attack attribute level |
| defenseGrade | 7 | INT32 | Defense attribute level |
| point | 8 | INT32 | Unspent attribute points |
| skills | 9 | STRING | `"skillTemplateId,exp\|skillTemplateId,exp"` for skills index 30, 31, 32 |

Client receiver `AvengerManager.__avengerChildNsHandler` (`CM/yishi/manager/AvengerManager.as:66, 153-183`): returns if `spiritDatas` is absent; upserts `model.nsInfoDic` by `childId`, copies every field, parses `skills` (`CM/mvc/module/avenger/AvengerChildNsInfo.as:48-73`, keyed by the skill `Index`), then fires `AVENGER_CHILDNS_UPDATE` (sword view, ascension frame, skill frame). Send it as the response to ops 9..13 (only the changed sword) and at login with all swords *(assumption)*. No result code.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Sword per child | keyed by `childId`; the view maps the selected nursing spirit job to the sword of the child with that job (`AvengerModel.getNsInfoByJob`, `CM/mvc/module/avenger/AvengerModel.as:246-256`) | |
| Sword level exp | to go from g to g+1: `UpGrade(Types 156, Grades = g+1).Data` (10 at low levels, 20 from 21, ..., 300 from 581); levels 1..630 | `AvengerChildNsSwordView.as:352-370`; `UpGradeTempInfos.xml` Types 156 |
| Train material | 208526 "Lâmina de Pedra" (produced in "Expedição do Espírito" and guardian battles), 1 stone = 1 exp *(assumption)* | `AvengerChildNsSwordView.as:343` |
| Points | granted when the sword levels up *(assumption: the help text says "A Ascensão da Lâmina do Espírito de Proteção fornece pontos"; the amount per level is unknown)* | `AvengerChildNsSwordView.tipsImage.tipData` |
| Attribute bonuses | life `liveGrade x 1500`, defense `defenseGrade x 200`, attack `attackGrade x 200` (`magicDefenseGrade x 200` exists client side but has no proto field) | `AvengerChildNsInfo.as:75-93` |
| Attribute cap at stage s | `UpGrade(Types 157, Grades = s).TemplateName[0]`: 10 at stage 0, +10 per stage, 210 at stage 20 (help text says max 200) | `AvengerChildNsPropItem.as:145-153` |
| Ascension s -> s+1 | 208527 "Pedra da Ascensão do Espíritos de Proteção" x `UpGrade(157, s+1).Data` (100, 150, 200, ..., 550, then 600); all 3 attributes >= `UpGrade(157, s+1).TemplateName[1]` (0, 10, 20, ..., 200) | `AvengerChildNsSwordUpgradeFrame.as:176-194, 222-249, 251-270` |
| Color tier | `profileGrade = UpGrade(157, stageGrade).ActiveObject` 0..5 (stages 0-2 white, 3-5 green, 6-8 blue, 9-12 purple, 13-16 orange, 17-20 red); level inside the tier = `stage - first stage of the tier + 1` (`AvengerModel.upgradeDic`, :332-350) | `AvengerChildNsInfo.as:109-113`; template |
| Pacto de Sangue (index 30) | skill grade = `profileGrade`; casts the active sword skill every time the guardian loses 65% (Nv.0), 60%, 55%, 50%, 45%, 40% (Nv.5) of HP | `AvengerModel.getStageSkill` (:275-289); `AvengerChildNsSwordUpgradeFrame.skillhelpFrame.content`; SkillTempInfos 42533000.. |
| Sword skills | SkillTempInfos with `MasterType = childTemp.SkillMasterType` (53..57) and `Index` 30, 31 (passive, grades 1..5), 32 (active "Vingança·...", grades 1..8) | `AvengerModel.getNsSkillList` (:258-273); template |
| Skill open level | to learn or raise a skill from grade G: first sword level whose `UpGrade(156).TemplateName[i] > G` (i = 0 for index 31, 1 for index 32). `TemplateName` = max learnable grades "passive,active" per sword level ("1,1" at level 1 ... "5,8" from level 360) | `AvengerModel.getOpenMinLevelAry` (:291-320), `getCanLearnMaxGrade` (:322-330) |
| Books per grade n | index 31 (book 208528): `100n^2 - 100n + 100` (100, 300, 700, 1300, 2100); index 32 (book 208529): `75n^2 - 75n + 150` (150, 300, 600, 1050, 1650, 2400, 3300, 4350) | `AvengerModel.getLearnCount` (:352-363) |
| Learn (op 12) | consumes `learnCount(index, 1)` books *(assumption)* and creates the skill at grade 1 with exp 0 | `AvengerChildNsSkillItem.as:137-151` |
| Upgrade (op 13) | adds `count` books to the skill exp; levels up while `exp >= learnCount(index, grade+1)` and the sword level allows it *(assumption)* | `AvengerChildNsSkillItem.as:153-175, 230-243` |
| Tasks 248-251 | sword level, stage, passive and active skill counters (`checkCount`, server counted) | `CM/mvc/module/task/TaskTemplate.as:842-848` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 156 (630 rows) | sword level | `Grades`, `Data` (exp to reach), `TemplateName` "maxPassiveGrade,maxActiveGrade" |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 157 (21 rows, Grades 0..20) | stage | `Grades`, `Data` (208527 needed to reach), `TemplateName` "attributeCap,requiredAttributeLevel", `ActiveObject` (color tier) |
| `raw/xml/tempinfos/SkillTempInfos.xml` MasterType 53..57, Index 30/31/32 | sword skills | `TemplateId`, `TemplateName`, `Icons`, `Grades`, `Index`, `Description` |
| `raw/xml/tempinfos/ChildTempInfos.xml` | guardian child templates (guardians feature) | `JobType`, `SkillMasterType` |
| `raw/xml/tempinfos/ItemTempInfos.xml` 208526..208529 | materials | "Lâmina de Pedra", "Pedra da Ascensão do Espíritos de Proteção", "Livro de Habilidades Passivas da Lâmina do Espírito de Proteção", "Livro de Habilidades Ativas da Lâmina do Espírito de Proteção" |

## 7. Persistent state

```sql
-- One sword per (avenger, guardian child).
CREATE TABLE avenger.child_swords (
  player_id       bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  child_id        integer  NOT NULL,             -- FK to the guardians feature child table (name unknown)
  grade           smallint NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 630),
  exp             integer  NOT NULL DEFAULT 0 CHECK (exp >= 0),
  stage_grade     smallint NOT NULL DEFAULT 0 CHECK (stage_grade BETWEEN 0 AND 20),
  live_grade      smallint NOT NULL DEFAULT 0 CHECK (live_grade >= 0),
  attack_grade    smallint NOT NULL DEFAULT 0 CHECK (attack_grade >= 0),
  defense_grade   smallint NOT NULL DEFAULT 0 CHECK (defense_grade >= 0),
  points          integer  NOT NULL DEFAULT 0 CHECK (points >= 0),
  updated_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, child_id)
);

-- Sword skills (index 30 blood pact, 31 passive, 32 active).
CREATE TABLE avenger.child_sword_skills (
  player_id          bigint   NOT NULL,
  child_id           integer  NOT NULL,
  skill_index        smallint NOT NULL CHECK (skill_index IN (30, 31, 32)),
  skill_template_id  integer  NOT NULL,
  exp                integer  NOT NULL DEFAULT 0 CHECK (exp >= 0),
  PRIMARY KEY (player_id, child_id, skill_index),
  FOREIGN KEY (player_id, child_id) REFERENCES avenger.child_swords (player_id, child_id) ON DELETE CASCADE
);
```

If the guardians feature already stores the nursing spirit "train info" with the same fields, these tables must be shared with it rather than duplicated *(open question)*.

## 8. Backend implementation notes

Gate every handler behind a server switch `child_ns_enabled` (default false, mirroring `VersionSwitch.CHILD_NS`). With the switch off, drop ops 9..13 and do not send 4276.

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `avenger::child_sword::handle_train` | op 9 | switch on -> avenger -> child `id` belongs to the player and is a nursing spirit -> sword row exists *(assumption: created on first train)* -> next level row exists -> `count >= 1` and owned 208526 >= count | Consume, add exp, level up with Types 156 `Data`, grant points per level *(assumption)*. Push bag update + 4276 |
| `avenger::child_sword::handle_ascend` | op 10 | switch -> avenger -> child -> next stage row -> owned 208527 >= `Data` -> 3 attributes >= requirement | Consume, `stage_grade + 1`, update the blood-pact skill (index 30) template to the new color tier. Push bag + 4276 |
| `avenger::child_sword::handle_add_point` | op 11 | switch -> avenger -> child -> `index` in 1..3 -> points > 0 -> attribute level < cap | `points - 1`, attribute + 1. Push 4276 |
| `avenger::child_sword::handle_learn_skill` | op 12 | switch -> avenger -> child -> `templateId` is grade 1 of index 31 or 32 for the child's `SkillMasterType` -> skill not learned -> sword level >= open level -> books >= learn count | Consume books, insert the skill. Push bag + 4276 |
| `avenger::child_sword::handle_upgrade_skill` | op 13 | switch -> avenger -> child -> `templateId` matches the learned skill -> not max -> sword level >= open level for the next grade -> `count >= 1` and owned books >= count | Consume, add exp, level while allowed. Push bag + 4276 |

Guardian battles: the sword bonuses and skills apply to the guardian child (battle and guardians features) *(assumption)*.

## 9. Open questions and assumptions

1. The whole module is disabled client side (`CHILD_NS = false`); implement only if the switch is turned on.
2. *(assumption)* Points per sword level, exp per stone, and whether learning consumes the first-grade book count.
3. *(assumption)* When the sword row is created (first train, deification, or child acquisition).
4. Ownership overlap with the guardians feature (`NursingSpiritInfo.trainInfo`); which opcode the guardians UI uses for the same data is outside this feature.
5. The attribute cap of 210 at stage 20 vs the help text "no máximo até o nível 200".

## 10. Implementation checklist

- [ ] Server switch `child_ns_enabled` (default false)
- [ ] Screens `AvengerChildNsView`, `AvengerChildNsListView`, `AvengerChildNsSwordView`, `AvengerChildNsSwordUpgradeFrame`, `AvengerChildNsSkillFrame`, `AvengerChildNsSkillItem`, `AvengerChildNsSkillInputFrame` (only if enabled)
- [ ] Route 8657 op 9 -> `avenger::child_sword::handle_train`
- [ ] Route 8657 op 10 -> `avenger::child_sword::handle_ascend`
- [ ] Route 8657 op 11 -> `avenger::child_sword::handle_add_point`
- [ ] Route 8657 op 12 -> `avenger::child_sword::handle_learn_skill`
- [ ] Route 8657 op 13 -> `avenger::child_sword::handle_upgrade_skill`
- [ ] Server message 4276 `AvengerSpiritMsg`
- [ ] Tables `avenger.child_swords`, `avenger.child_sword_skills`
- [ ] Rules: Types 156 levels, Types 157 stages and caps, learn count formulas, blood pact tier
- [ ] Template loaders: Types 156, Types 157, SkillTempInfos MasterType 53..57
- [ ] Test: all ops rejected while the switch is off
- [ ] Test: ascension rejected when one attribute is below the requirement
