# Hero skills (Habilidade)

Path aliases used below:

| Alias | File |
|---|---|
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| TIH | `decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as` |
| SC | `decompiled/core_module/scripts/yishi/datas/playerinfo/SkillCategory.as` |
| SI | `decompiled/core_module/scripts/mvc/module/armyII/SkillInfo.as` |
| TM | `decompiled/core_module/scripts/yishi/manager/TempleteManager.as` |
| SF | `decompiled/m5/scripts/armyII/SkillFrame.as` |
| SV | `decompiled/m5/scripts/armyII/viewII/skill/SkillView.as` |
| SIV | `decompiled/m5/scripts/armyII/viewII/skill/SkillitemView.as` |

## 1. Overview

The hero learns class skills with skill points. Each skill is a chain of `SkillTempInfos` rows sharing a `SonType`; one row per level (`Grades`), linked by `NextTemplateId`. The learned set is the CSV `skill_script` (template ids of the current level of every learned skill). The hero also has:
- a reset ("Redefinir pontos de habilidade"), free before level 25 or with King Contract buff 9, otherwise `ResetSkill_NeedPay` = 100 diamonds;
- a second skill set ("habilidade dupla", 600 diamonds, level >= 38) and a switch between set 0 and set 1;
- after job transfer (`isChangeJob`), a different tree (MasterType 420+job) with "four choose one" columns, and a branch switch handled by the job change module.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.SkillFrame` (SF) | "Habilidade" (`armyII.SkillFrame.title`, SF:583) | Tab container: skill (0), rune (1), talent (2), "Equipe" (3), rune gems | toolbar, key S, links (see README) | tab counters (SF:216-242) |
| `armyII.viewII.skill.SkillView` (SV) | | Skill tree, remaining points, reset button, double skill button, set switch, 5 fast keys, 2 rune keys | tab 0 | `skillCate.skillPoint` (SV:413), tree from `skillCate.allSkillList` keyed by template `Index` |
| `armyII.viewII.skill.SkillitemView` (SIV) | | One skill: icon, "grade/maxGrade", "+" button, passive and super skill marks | SkillView | `SkillInfo` |
| `armyII.SkillHelpFrame` | "Ajuda" | Static help (`core.SkillHelpFrame`) | help button (SF:492-515) | none |

Layout rules:
- Normal tree: 32 cells, 8 per row (SV:328-338). Cells with `Index % 8 >= 6` (columns 7 and 8) are hidden until the player has done a vocation upgrade (`playerInfo.vocationGrades > 0`, SV:387-401). Description label: "Antes do Nv. 25, jogador pode limpar pontos gratuitamente" (`armyII.viewII.skill.describe`, SV:171).
- Job transfer tree: 22 cells; cells 0..1 are the two base skills (Index 1, 2), the rest are 4-row columns (SV:301-325). Cells outside the active branch are greyed by `setDisabled` (SV:520-538).

## 3. Routes (client to server)

### R1. Learn or raise a skill ("+" button)
- UI: `_addBtn` on `SkillitemView` (SIV:221-248). Visible only when `checkCanAdd()` is true (SIV:376-397):
  1. `nextTemplateInfo` exists (level 0 → the level 1 row; otherwise `templateInfo.nextTemp`, SI:51-58);
  2. `skillCate.skillPoint > 0`;
  3. `SkillInfo.checkUpgradeCondition(next)` returns no missing conditions (SI:117-166): `NeedPlayerGrade` <= hero level ("Líder Nv. {0}"); when `NeedPlayerGrade > 80` it is compared with `80 + vocationGrades` and the missing vocation name is shown; every id in `PreTemplateId` must already be learned at that level or higher ("Nv. {0}"); MasterType 200 needs `UpgradeNeedItem` x `UpgradeNeedCount`;
  4. for MasterType 421/422/423, no other skill of the same column group `(Index - 3) / 4` is learned (`SC.fourChooseOne`, SC:179-205).
- Confirmation: after job transfer, raising a level 0 skill with `Index >= 3` asks "Elevando [{0}], faz com que as outras habilidades da mesma coluna não possam ser elevadas. Tem certeza que deseja elevar esta habilidade?" (`army.skill.change2.addSkill`, SIV:228-243).
- Client path: `AC.sendAddSkillPoint(SkillInfo)` (AC:411-414) → `ASOM.sendAddSkillpoint(next.TemplateId)` (ASOM:240-251).
- Route: send 5185 (0x1441) `C_HERO_SKILL_UPGRADE` (name from `ProtocolType.as:316`, absent in opcodes.csv).
- Request `HeroAddPointReqMsg` (army):
  - `skill_temp_id` (#6, INT32): template id of the target level.
  - `type` (#7, INT32): 0 = class skill (explicitly set). 1 = talent (see [talents.md](talents.md)).
  - `power_point` (#1, INT32): not set for skills.
  - `agility_point` (#2), `intellect_point` (#3), `captain_point` (#4), `physique_point` (#5), all INT32: unused by this route.
- Expected response: 60 `U_C_HERO_SKILL_UPGRADE` (S1) with `type = 0`, then 113 `U_C_HERO_INFO` with the new `skill_point`, `skill_script` (and `fast_key` if the server auto-adds the skill). The client auto-moves a newly learned active skill (grade 1, `UseWay != 2`) into the first empty fast key slot and then sends 5167 (SIV:268-296, SV:706-728).

### R2. Reset skill points ("Redefinir")
- UI: `_washBtn` (SV:644-663). Enabled when `skillScript` is not empty (SV:414); after job transfer, when the script differs from `"<id1>,<id2>,"` of the two base skills or either base skill is above level 1 (SV:440-447).
- Client checks: hero level < 25 or King Contract buff 9 → free alert "Essa ação voltará os pontos de habilidade ao estado inicial" (`armyII.viewII.skill.content02`); otherwise paid alert "Consumir {0} diamantes para redefinir pontos de habilidade" (`armyII.viewII.skill.content01`, `ResetSkill_NeedPay` = 100) with the "use bound diamonds" checkbox (`USEBINDPOINT_ALERT`).
- Client path: `AC.sendWashSkillPoint(0, useBind)` (AC:416-419) → `ASOM.sendWashSkillPoint(0, 0, useBind)` (ASOM:253-264).
- Route: send 5184 (0x1440) `C_HERO_SKILLPOINT_RESET` (`ProtocolType.as:312`).
- Request `PayTypeMsg` (player):
  - `pay_type` (#1, INT32): 0 when the bound diamond checkbox is checked (or free reset), 1 otherwise.
  - `type` (#4, INT32): 0 = class skills (1 = talents, 2 = advanced talents, see [talents.md](talents.md)).
  - `property1` (#2), `property2` (#3), INT32: unused.
- Expected response: 61 `U_C_HERO_SKILLPOINT_RESET` (S2) with `type = 0, reset_result = true`, then 113 with `skill_point` restored and `skill_script` cleared (or set to the two base skills at level 1 after job transfer), and a currency push when paid (3 `U_C_PLAYER_INFO`, see [../currency/README.md](../currency/README.md)).

### R3. Activate the second skill set ("habilidade dupla")
- UI: `_doubleSkillBtn` visible when `VersionSwitch.DOUBLE_SKILL` (true), hero level >= 38 and `!skillCate.activeDouble` (SV:163-174, SV:186-193).
- Confirmation: "Ativação da habilidade dupla é necessário consumo de {0} diamantes, ativar?" (`armyII.viewII.skill.ActiveAlertContent`, `Second_SkillPoint` = 600) with bound diamond checkbox (SV:586-604).
- Client path: `AC.sendActiveSecond(useBind)` (AC:468-471) → `ASOM.sendActiveSecondSkill` (ASOM:301-311).
- Route: send 8479 (0x211f) `C_ACTIVE_SECONDSKILL`. Request `PayTypeMsg`: `pay_type` (#1) 0 = bound diamonds allowed, 1 = diamonds only; other fields unused.
- Expected response: 113 with `is_activeSecond` (#45) = true; `SkillCategory.commit` dispatches `ACTIVE_DOUBLE_SKILL` and the view swaps the button for the switch (SC:80-113, SV:681-692). No dedicated response opcode exists.

### R4. Switch skill set
- UI: `_switchSkillBtn` (normal tree, SV:615-628), visible when `activeDouble`.
- Client path: `AC.sendSkillChange(index)` (AC:473-476) → `ASOM.sendSkillChange` (ASOM:313-319) with `index = 1 - skillCate.skillIndex`.
- Route: send 8480 (0x2120) `C_CHANGE_SKILL`. Request `HeroSkillChangeMsg` (army): `index` (#1, INT32) target set 0 or 1; `pay_type` (#2, INT32) and `result` (#3, BOOL) not set.
- Expected response: 113 with `skill_index` (#44), the new set `skill_script`, `skill_point` and `fast_key`. `SkillCategory.skillIndex` setter rebuilds the skill list and dispatches `SKILL_INDEX` (SC:62-73). On `SKILL_INDEX` the view refreshes and re-sends the carried runes with 8605 op type 3 (SV:740-750, see [runes.md](runes.md)).
- After job transfer the same switch (`_switchSkillBtn2`) calls the branch change 9577 `C_EXCHANGEJOB_BRANCH` with confirm "Dese alterar para {0}?" / "Conjunto de habilidades {0}" (SV:540-568, SV:630-642); documented in [../hero/job-change.md](../hero/job-change.md).

## 4. Server messages (server to client)

### S1. 60 (0x003c) `U_C_HERO_SKILL_UPGRADE`
- Message `UpdatedSkillMsg` (army): `template_id` (#1, INT32) new template id (0 = skill reset to level 0), `index` (#2, INT32) template `Index` (key of `allSkillList`), `reset_result` (#3, BOOL) unused here, `type` (#4, INT32) 0 = skill, 1 = talent.
- Receiver: `AM.__skillUpgradeHandlker` (AM:387-430). For `type 0`: sets `templateId`, `grade = templateInfo.Grades`, commits and notifies `SKILL_UPGRADE`; `template_id 0` calls `reset()`.
- When: response to 5185 with `type 0`. It does not carry skill points or the script, so 113 must follow.

### S2. 61 (0x003d) `U_C_HERO_SKILLPOINT_RESET`
- Message `UpdatedSkillMsg`: `type` (#4) 0 skills, 1 talents, 2 advanced talents; `reset_result` (#3, BOOL) must be true or the client ignores the message.
- Receiver: `AM.__skillResetHandler` (AM:432-497). Type 0: every `SkillInfo.reset()`; with job transfer, skills at `allSkillList[1]` and `[2]` get `grade = 1`. Notifies `SKILL_RESET`, which also clears the fast key slots (`FastSkillItem.__resetHandler`).
- Note: `docs/mechanics/skills_buffs.md` §12 lists `HeroSkillInfoMsg` for 60/61; the client reads `UpdatedSkillMsg`. `HeroSkillInfoMsg` (`skill_point` #1, `skill_script` #2, `skillSet` #3 repeated) has no reader.

### S3. 113 (0x0071) `U_C_HERO_INFO`
- Message `SimpleHeroInfoMsg` (army), skill fields read by `TIH.readHeroInfo` (TIH:393-413): `skill_point` (#6, INT32), `skill_script` (#7, STRING, CSV of template ids, trailing comma), `fast_key` (#8, STRING, see [skill-bar.md](skill-bar.md)), `skill_index` (#44, INT32, 0/1), `is_activeSecond` (#45, BOOL). Full field list in [../hero/attributes.md](../hero/attributes.md).
- Receiver: `AM.__uHeroInfoHandler` (AM:372-385).
- When: after every skill route and at login (also embedded in 150 `ArmyMsg.simple_hero_info`).

## 5. Rules and formulas

- Tree per class: `SkillCategory.initAllSkill(job)` takes the level 1 rows of `MasterType == job` (or after job transfer `MasterType == 420 + job`, TM:1824-1862) and maps learned ones through `skill_script` (SC:135-158). `allSkillTemp` contains `MasterType == job` or `job + 30` (or 420+job and 70 after transfer, TM:1939-1983).
- A skill counts as learned at level N when `skill_script` holds an id with the same `SonType` and `Grades >= N` (`existSkill`, SC:263-279).
- Max level of a skill = max `Grades` among rows of its `SonType` (SI:69-83).
- Cost per level: 1 skill point *(assumption: no field holds a different cost; server rule)*.
- First skill point at hero level 6 (`AddSkill_Grade`); no more points after level 70 (`Talent_MaxPlayerGrade`, description "此等级后不再增加技能点"). Points per level are server-side *(assumption: 1 per level from 6 to 70)*.
- Prerequisites: `NeedPlayerGrade`, `PreTemplateId` (CSV, each must be learned at its level), MasterType 200 item cost (SI:126-166).
- Four choose one (job transfer tree): learning any level of a skill with MasterType 421-423 and `Index >= 3` locks the other skills of the same group `(Index - 3) / 4` (SC:179-205, SIV:390-395). Server must enforce it.
- Reset cost: free if hero level < 25 or King Contract buff 9; otherwise `ResetSkill_NeedPay` = 100 diamonds (SV:644-663).
- Second set: `Second_SkillPoint` = 600 diamonds, hero level >= 38 (SV:172, SV:589).
- Initial skill given by the tutorial: `HeroSkillSet` = `1,10811|2,20811|3,30811` (class → template id, "新手引导领悟技能").

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/SkillTempInfos.xml` | `SkillTempInfo`, one row per skill level | `TemplateId`, `TemplateName`, `Icons`, `MasterType` (1/2/3 class, 421-423 job transfer, 4 DragonTalker), `SonType` (skill chain id), `Grades` (level), `PreTemplateId` (CSV prerequisites), `NextTemplateId`, `NeedPlayerGrade`, `Index` (cell position), `UseWay` (1 active, 2 passive, 3 auto), `Priority` (super skill mark via `SkillPriorityType.isSuperSkill`), `Cost` (Fury), `CoolDown` (ms), `UpgradeNeedItem`, `UpgradeNeedCount`, `Description`. Battle fields in `docs/mechanics/skills_buffs.md` §1 |
| `raw/xml/tempinfos/ConfigInfos.xml` | config rows | `ResetSkill_NeedPay` (100), `Second_SkillPoint` (600), `AddSkill_Grade` (6), `Talent_MaxPlayerGrade` (70), `HeroSkillSet` |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS skills;

CREATE TABLE skills.hero_skill_profile (
    player_id            BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    active_set_index     SMALLINT NOT NULL DEFAULT 0 CHECK (active_set_index IN (0, 1)),
    double_skill_active  BOOLEAN  NOT NULL DEFAULT FALSE,
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE skills.skill_sets (
    player_id     BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    set_index     SMALLINT NOT NULL CHECK (set_index IN (0, 1)),
    skill_points  INTEGER  NOT NULL DEFAULT 0 CHECK (skill_points >= 0),
    fast_key      TEXT     NOT NULL DEFAULT '',
    PRIMARY KEY (player_id, set_index)
);

CREATE TABLE skills.learned_skills (
    player_id    BIGINT   NOT NULL,
    set_index    SMALLINT NOT NULL,
    son_type     INTEGER  NOT NULL,
    template_id  INTEGER  NOT NULL,
    grade        SMALLINT NOT NULL CHECK (grade >= 1),
    learned_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, set_index, son_type),
    FOREIGN KEY (player_id, set_index) REFERENCES skills.skill_sets(player_id, set_index) ON DELETE CASCADE
);
CREATE INDEX learned_skills_template_idx ON skills.learned_skills (template_id);
```

`skill_script` is derived: `string_agg(template_id || ',')` of the active set.

## 8. Backend implementation notes

- `skills::hero_skills::handle_upgrade` (5185, `type = 0`):
  1. Load template `skill_temp_id`; reject if MasterType is not the hero class tree (job, or 420 + job after transfer).
  2. Find the current level of `SonType` in the active set; require `template.Grades == current + 1`.
  3. Check `skill_points >= 1`, `NeedPlayerGrade` (with the `80 + vocationGrades` rule), all `PreTemplateId` learned, four choose one, MasterType 200 item cost.
  4. Transaction: decrement points, upsert `learned_skills`, consume items if any.
  5. Send 60 `{template_id, index = template.Index, type = 0}` then 113 (full message, see README warning).
- `skills::hero_skills::handle_reset` (5184 with `type = 0`): compute cost (free if level < 25 or King Contract buff 9; else 100 diamonds, bound first when `pay_type = 0`), refund all spent points of the active set, delete learned skills (keep base skills Index 1/2 at level 1 after job transfer), clear `fast_key`. Send 61 `{type 0, reset_result true}`, 113, currency push. Route `type 1/2` to `skills::talents::handle_reset`.
- `skills::hero_skills::handle_activate_second_set` (8479): require level >= 38 and not active; charge 600 diamonds; create set 1 with the same total points as set 0 *(assumption)*; send 113.
- `skills::hero_skills::handle_switch_set` (8480): require `double_skill_active`; set `active_set_index`; send 113 with the set's `skill_script`, `skill_point`, `fast_key`, `skill_index`.
- Skill points grant: on hero level up (hero feature) add points to both sets *(assumption)*.
- No battle starts here. Learned skills feed `HeroFastKeyMsg` and the hero unit `skills` list in battle configuration (`docs/battle/server-engine.md` §9.4).

## 9. Open questions and assumptions

- Assumption: each level costs exactly 1 skill point; points per hero level are not in any template.
- Assumption: the two skill sets have independent skill scripts, points and fast keys (the client only stores one of each and reloads on `SKILL_INDEX`).
- Assumption: `pay_type 0` = bound diamonds (`giftToken`) may be used first, `1` = only real diamonds (derived from `UseBindPointAlert` checkbox semantics and `SkillView.hasMoney`, SV:606-613).
- Open: whether 8479/8480 have a failure push other than a generic message (no handler exists).
- Open: 5171 `U_C_HERO_ADDPOINT` / 67 exist in the protocol but have no client sender; attribute points are covered in [../hero/attributes.md](../hero/attributes.md).

## 10. Implementation checklist

- [ ] Screen data: `SkillFrame` tab 0 renders from 113 skill fields
- [ ] Route 5185 type 0 learn/raise with all validations
- [ ] Route 5184 type 0 reset (free and paid paths)
- [ ] Route 8479 activate second set
- [ ] Route 8480 switch set
- [ ] Server message 60 `UpdatedSkillMsg` type 0
- [ ] Server message 61 `UpdatedSkillMsg` type 0
- [ ] Server message 113 with full field set
- [ ] Table `skills.hero_skill_profile`
- [ ] Table `skills.skill_sets`
- [ ] Table `skills.learned_skills`
- [ ] Rule: prerequisites and `NeedPlayerGrade` (with vocation rule)
- [ ] Rule: four choose one for MasterType 421-423
- [ ] Rule: reset pricing (level < 25, King Contract buff 9, 100 diamonds)
- [ ] Rule: skill points grant from level 6 to 70
- [ ] Test: learn level 1, raise to level 2, reject without points, reject missing prerequisite
- [ ] Test: reset returns all points and clears fast keys
- [ ] Test: second set purchase and switch keep independent scripts
