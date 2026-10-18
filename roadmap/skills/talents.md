# Talents (Dom Natural)

Path aliases:

| Alias | File |
|---|---|
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| TIH | `decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as` |
| TD | `decompiled/core_module/scripts/yishi/datas/playerinfo/TalentData.as` |
| SI | `decompiled/core_module/scripts/mvc/module/armyII/SkillInfo.as` |
| SF | `decompiled/m5/scripts/armyII/SkillFrame.as` |
| TV | `decompiled/m5/scripts/armyII/viewII/talent/TalentView.as` |
| TIV | `decompiled/m5/scripts/armyII/viewII/talent/TalentItemView.as` |
| TTV | `decompiled/m5/scripts/armyII/viewII/talent/TransferTalentView.as` |
| TTB | `decompiled/m5/scripts/armyII/viewII/talent/TalentTabBtnView.as` |

## 1. Overview

Talents ("Dom Natural") are passive skill trees stored as `SkillTempInfos` rows:

| Tree | MasterType | Cells | Points | Level track |
|---|---|---|---|---|
| Basic talents | `job * 10` (10/20/30); DragonTalker job 4 uses 70 | 9 (Index 0..8) | `talent_point` | `talent_grade`, raised with gold + hero EXP (`UpGradeTempInfos` type 21) |
| Advanced talents | `job * 10 + 30` (40/50/60); job 4 uses 80 | 5 (Index 10..14) | `advanced_talent_point` | `advanced_talent_grade`, raised with gold + hero EXP (type 38), only after a vocation upgrade and talent level 80 |
| Job transfer talents | 70 (when `vocationIndex > 0`) | 7 | `talent_point` | `talent_grade`, raised with diamonds or "Pedra do Dom Natural" (type 112) |

`TalentData.isAdvTalent(MasterType)` = 40..60 or 80 (TD:42-49). Talent effects are buffs (`BufferIds` → `TalentEffIds`) collected in battle (`docs/mechanics/skills_buffs.md` §1.3).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.talent.TalentView` (TV) | frame title "Dom Natural" (`armyII.SkillFrame.talentTitle`, SF:692) | Basic and advanced talent trees, talent level, level-up cost, reset | `SkillFrame` tab 2 when hero level >= 50 and not job transferred (SF:672-695) | `talentGrade`, cost gold (`TemplateId`) and EXP (`Data`) of the next level, own gold, hero `gp`, count of item 212012 with label "(Uso prioritário de {0})" (`armyII.viewII.talent.currentHaveTxtNote`), remaining points (TV:248-296) |
| `armyII.viewII.talent.TalentTabBtnView` (TTB) | tabs "ordinary" and "advanced" | Switches `SELECTEDINDEX` 0/1; advanced needs `vocationGrades > 0`, else "Esta habilidade só poderá ser activada depois de ser transferida" | shown when hero level > 50 and not transferred (SF:535-554) | point counters |
| `armyII.viewII.talent.TransferTalentView` (TTV) | same title | 7-cell tree after job transfer, level-up paid with diamonds | `SkillFrame` tab 2 when `thane.isChangeJob` (SF:684-687) | diamond cost (type 112 `Data`), count of item 208053 "Pedra do Dom Natural", remaining points (TTV:201-219) |
| `armyII.viewII.talent.TalentItemView` (TIV) | | One talent cell with "+" button, level, star at max level | both views | `SkillInfo` |

## 3. Routes (client to server)

### R1. Raise the talent level
- UI: `_upGrade` in TalentView (TV:332-359).
- Client checks (basic tab): gold >= next `TemplateId` else "Ouro insuficiente, falha ao elevar!" (`armyII.viewII.talent.TalentGradeUpFailed01`); hero `gp >= Data` or at least one item 212012 in bag 1, else "Experiência insuficiente, falha ao elevar!" (`TalentGradeUpFailed02`). Advanced tab additionally requires `talentGrade >= 80`, else "Depois da Habilidade atingir o Nv.80 é que pode aumentar a Habilidade de Nv.80 Avançada" (`armyII.viewII.talent.TalentView.upGradePrompt`). Button disabled when there is no next level row.
- Client path: `AC.sendUpTalentGrade(advanced, 2)` (AC:488-491) → `ASOM.sendUpTalentGrade` (ASOM:274-281).
- Job transfer variant (TTV:250-301): confirm "Deseja usar {0} Pedras do Dom Natural ou {1} diamantes para evoluir?\n(Prioridade de uso de Pedras do Dom Natural)" (`TransferTalentView.confirmUpgradeTalent`, values `Data / Talent_PointItem` and `Data`) with "Não alertar mais"; affordability `count(208053) * Talent_PointItem + diamonds (+ giftToken if bound allowed) >= Data`, else recharge prompt; then `sendUpTalentGrade(false, useBind ? 2 : 1)`.
- Route: send 5187 (0x1443) `C_TALENT_GRADE_UP`.
- Request `TalentUpGradeMsg` (army): `upresult` (#1, BOOL) false = basic (or job transfer) talent level, true = advanced talent level; `payType` (#2, INT32) 2 = default or bound diamonds allowed, 1 = real diamonds only (transfer tree).
- Expected response: 4430 (S1) with `upresult = true`, then 4431 (S2) with the new grades and points, plus resource pushes (gold/diamonds 3 `U_C_PLAYER_INFO`, hero EXP via 113, consumed items via bag updates).

### R2. Spend a talent point ("+")
- UI: `TIV.__addHandler` (TIV:124-138); "+" visible when `checkCanAdd` (TIV:220-242): next level exists, enough points of the right kind (`advTalentPoint` for advanced, else `talentPoint`), and `SkillInfo.checkTalentUpgradeCondition` is empty (SI:168-196): advanced: `Parameter3 <= advTalentGrade` ("Habilidade Avançada de Nv.{0}"); basic: `NeedPlayerGrade <= hero level` and all `PreTemplateId` learned.
- Client path: `AC.sendAddTalentSkillPoint(nextTemplateId, 1[, 1])` (AC:483-486) → `ASOM.sendAddSkillpoint` (ASOM:240-251).
- Route: send 5185 (0x1441) `C_HERO_SKILL_UPGRADE`.
- Request `HeroAddPointReqMsg`: `skill_temp_id` (#6, INT32) next template id; `type` (#7, INT32) = 1 (talent); `power_point` (#1, INT32) = 1 only for advanced talents (used as the advanced flag); other point fields unused.
- Expected response: 60 `U_C_HERO_SKILL_UPGRADE` with `type = 1` (S3), then 4431 or 113 with the new points and `talent_skill` / `advanced_talent_skill` scripts.

### R3. Reset talents
- UI: `_washBtn` (TV:374-422, TTV:309-343). Enabled when the script is not empty (transfer tree: script differs from `"<Job>00199,"`).
- Client checks: King Contract buff 9 → free alert "Esta operação irá transformar os pontos do dom natural em estado básico" (`armyII.viewII.talent.content02`); otherwise "Consumir {0} diamantes para redefinir pontos do Dom Natural?" (`armyII.viewII.talent.content01`, hard-coded 100) with bound diamond checkbox.
- Client path: `AC.sendWashTalentSkillPoint(0, type, useBind)` (AC:478-481) → `ASOM.sendWashSkillPoint` (ASOM:253-264); the transfer view's free path calls `ASOM.sendWashSkillPoint(0, 1, true)` directly (TTV:333).
- Route: send 5184 (0x1440) `C_HERO_SKILLPOINT_RESET`. Request `PayTypeMsg`: `pay_type` (#1, INT32) 0 bound allowed or free, 1 diamonds only; `type` (#4, INT32) 1 = basic talents (tab 0 and transfer tree), 2 = advanced talents (tab 1).
- Expected response: 61 `U_C_HERO_SKILLPOINT_RESET` (S4) then 4431/113 with refunded points.

### R4. Request talent data (implicit)
No explicit request exists; 4431 and 113 are pushed by the server.

## 4. Server messages (server to client)

### S1. 4430 (0x114e) `U_C_TALENT_GRADE_UP`
- Message `TalentUpGradeMsg`: `upresult` (#1, BOOL) true = success; `payType` (#2, INT32) unused.
- Receiver: `AM.__talentGradeUpHandler` (AM:534-544): on true shows "Elevado com sucesso" (`army.talent.TalentGradeUpSucc`) and dispatches `TALENT_GRADUP_SUCC`, which refreshes the view (TV:361-372). False is silent.

### S2. 4431 (0x114f) `U_C_TALENT_INFO`
- Message `HeroTalentMsg` (army): `user_id` (#1, INT32) must equal the hero `userId`; `talent_point` (#2, INT32); `talent_grade` (#3, INT32); `talent_skill` (#4, STRING) not read here; `advanced_talent_point` (#5, INT32); `advanced_talent_grade` (#6, INT32).
- Receiver: `AM.__changeTalentInfoHandler` (AM:517-532), updates the four counters and `InfoTipsManager.dealData(14)` (red dots).
- When: after 5187, after point gains (hero level up past `Talent_PlayerUpgrade`, item 212012 use), after reset.

### S3. 60 (0x003c) `U_C_HERO_SKILL_UPGRADE` with `type = 1`
- `UpdatedSkillMsg`: `template_id` (#1), `index` (#2) key into `talentData.allTalentList`, `type` (#4) = 1. Receiver AM:413-429: updates the cell, `commit(1)`, notifies `TALENT_UPGRADE`.

### S4. 61 (0x003d) `U_C_HERO_SKILLPOINT_RESET` with `type = 1/2`
- `reset_result` (#3) must be true. Type 1: `talentScript = ""` (or `"<Job>00199,"` after job transfer) and every non-advanced cell reset. Type 2: `advTalentScript = ""` and every advanced cell reset. Notifies `TALENT_RESET` (AM:463-496).

### S5. 113 `U_C_HERO_INFO` talent fields
`talent_point` (#47), `talent_grade` (#48), `talent_skill` (#49, CSV of template ids), `advanced_talent_point` (#74), `advanced_talent_grade` (#75), `advanced_talent_skill` (#76) (TIH:414-438).

## 5. Rules and formulas

- Talent tab unlock: hero level 50 in the client (SF:192, SF:674); `Talent_OpenGrade` = 40 in config (server side). Use 50 for UI parity *(assumption)*.
- Talent points: granted on hero level up after `Talent_PlayerUpgrade` = 40 *(assumption: 1 per level)*; item 212012 "Pedra do Dom Natural Básico" gives 1 basic or advanced point when used (item description); daily potion limit `Talent_LiquidDailyCount` = 20.
- Basic level cost: `UpGradeTempInfos` `Types = 21`, row `Grades = talentGrade + 1`: `TemplateId` = gold, `Data` = hero EXP. Item 212012 is used first instead of EXP (label "Uso prioritário"). Example: level 2 = 20000 gold, 1000000 EXP; level 160 = 1158000 gold, 57900000 EXP.
- Advanced level cost: `Types = 38`, row `advTalentGrade + 1` (level 1 = 2050000 gold, 60000000 EXP). Requires `talentGrade >= 80` and `vocationGrades > 0`.
- Transfer tree level cost: `Types = 112`, `Data` = diamonds (level 1 = 100, 2 = 300, 3 = 500). Each "Pedra do Dom Natural" (208053) replaces `Talent_PointItem` = 20 diamonds and is used first.
- Cell cost: 1 point per level *(assumption)*. Max level per cell = max `Grades` of its `SonType` (10 for most; "Selo Sagrado" 1001 reaches 99).
- Basic prerequisites: Index 1..8 require `100105` (Selo Sagrado level 5) in the warrior tree (`PreTemplateId`).
- Reset: 100 diamonds unless King Contract buff 9.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `SkillTempInfos.xml` | talent levels | `TemplateId`, `TemplateName`, `MasterType` (10..60, 70, 80), `SonType`, `Grades`, `Index`, `PreTemplateId`, `NeedPlayerGrade`, `Parameter3` (required advanced talent level), `BufferIds` (effects), `Icons` |
| `UpGradeTempInfos.xml` | `Types` 21 / 38 / 112 | `Grades` (target level), `TemplateId` (gold), `Data` (EXP or diamonds) |
| `ConfigInfos.xml` | | `Talent_OpenGrade` 40, `Talent_PlayerUpgrade` 40, `Talent_MaxPlayerGrade` 70, `Talent_LiquidDailyCount` 20, `Talent_PointItem` 20 |
| `ItemTempInfos.xml` | 212012, 208053 | consumables |
| `TalentEffectTempInfos.xml` | talent effect rows | battle modifiers referenced by buffs (`docs/mechanics/skills_buffs.md`) |

## 7. Persistent state

```sql
CREATE TABLE skills.talent_profile (
    player_id               BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    talent_grade            INTEGER NOT NULL DEFAULT 1 CHECK (talent_grade >= 1),
    talent_points           INTEGER NOT NULL DEFAULT 0 CHECK (talent_points >= 0),
    advanced_talent_grade   INTEGER NOT NULL DEFAULT 0 CHECK (advanced_talent_grade >= 0),
    advanced_talent_points  INTEGER NOT NULL DEFAULT 0 CHECK (advanced_talent_points >= 0),
    potion_uses_today       SMALLINT NOT NULL DEFAULT 0,
    potion_uses_date        DATE,
    updated_at              TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE skills.learned_talents (
    player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    son_type      INTEGER NOT NULL,
    master_type   INTEGER NOT NULL,
    template_id   INTEGER NOT NULL,
    grade         SMALLINT NOT NULL CHECK (grade >= 1),
    is_advanced   BOOLEAN NOT NULL,
    PRIMARY KEY (player_id, son_type, master_type)
);
CREATE INDEX learned_talents_player_adv_idx ON skills.learned_talents (player_id, is_advanced);
```

## 8. Backend implementation notes

- `skills::talents::handle_grade_up` (5187): pick track by `upresult` and job transfer state; load next `UpGradeTempInfos` row (21, 38 or 112); validate gold and EXP (consume one 212012 instead of EXP when present *(assumption: one stone replaces the full EXP cost)*) or diamonds/208053; transaction: deduct, increment grade; reply 4430 `{upresult true}`, then 4431, currency push and 113 (EXP). On failure reply 4430 `{upresult false}`.
- `skills::talents::handle_add_point` (dispatch from 5185 when `type = 1`): load template; advanced if `power_point = 1` or `isAdvTalent(MasterType)`; check points, prerequisites, `Parameter3 <= advanced_talent_grade`, `NeedPlayerGrade`; upsert `learned_talents`; reply 60 `{type 1}` and 4431, 113 with scripts.
- `skills::talents::handle_reset` (dispatch from 5184 when `type` is 1 or 2): price 100 diamonds unless King Contract buff 9; refund points; delete rows; transfer tree keeps `<Job>00199`; reply 61, 4431, 113.
- Battle: talent buffs are added to the hero unit at battle creation (battle feature).

## 9. Open questions and assumptions

- Assumption: 1 point per cell level and 1 talent point per hero level after 40.
- Assumption: item 212012 replaces the whole EXP cost of one level.
- Open: exact gate (40 in config versus 50 in UI).
- Open: whether the server sends 4431 or relies on 113 after point spending; send both.

## 10. Implementation checklist

- [ ] Screen: TalentView basic and advanced tabs
- [ ] Screen: TransferTalentView
- [ ] Route 5187 talent level up (basic, advanced, transfer)
- [ ] Route 5185 type 1 add talent point (basic and advanced flag)
- [ ] Route 5184 type 1/2 reset
- [ ] Server message 4430
- [ ] Server message 4431
- [ ] Server message 60 type 1
- [ ] Server message 61 type 1/2
- [ ] Server message 113 talent fields
- [ ] Table `skills.talent_profile`
- [ ] Table `skills.learned_talents`
- [ ] Rule: costs from `UpGradeTempInfos` 21/38/112
- [ ] Rule: prerequisites and `Parameter3`
- [ ] Rule: King Contract free reset
- [ ] Test: level up with gold+EXP, with stone, failure paths
- [ ] Test: add points basic/advanced, reset each track
