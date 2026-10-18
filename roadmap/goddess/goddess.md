# Goddess core: activation, level, advance, offering, battle slot

Module `goddess`. The player owns up to five goddesses ("Deusa"), each defined by `GoddessTemplateInfos.xml`. A goddess is invoked once with fragments, then raised on three independent tracks (level, advance, offering) by feeding items. One goddess at a time is marked "in battle" and joins the hero's fights as a non targetable unit that casts a guard skill and a dance skill driven by "belief" (fé). Accessories are in `equipment.md`; the five slot formation is in `formation.md`.

Path aliases:

| Alias | File |
|---|---|
| GM | `decompiled/core_module/scripts/managers/GodDessManager.as` |
| GMOD | `decompiled/core_module/scripts/mvc/module/goddess/GodDessModel.as` |
| GI | `decompiled/core_module/scripts/mvc/module/goddess/GoddessInfo.as` |
| GC | `decompiled/core_module/scripts/mvc/controler/GodDessController.as` |
| V | `decompiled/m5/scripts/goddess/` |
| TM | `decompiled/core_module/scripts/yishi/manager/TempleteManager.as` |
| MTB | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as` |

Conventions: opcode names from `protocol/opcodes.csv`, fields from `protocol/proto.json` (package `goddess`). *(assumption)* marks anything the client does not prove.

## 1. Overview

| pt-BR | Code | Meaning |
|---|---|---|
| Deusa | `GoddessInfo` | one per template 1..5: "Deusa da Magia Hécate", "Deusa da Criação Illia", "Deusa da Esperança Aster", "Deusa do Destino Cassandra", "Deusa da Guerra Lenneth" (`raw/xml/tempinfos/GoddessTemplateInfos.xml`) |
| Invocar (ativar) | op 1 | spends `NeedItemCount` (50) of the goddess fragment `NeedItemId` (212029..212033) |
| Nível | `grade`, `gradeGp`, op 2 | 1..`MaxGrade` (240), fed with "Larimar" 212027 (10 exp each) |
| Avanço | `step`, `stepGp`, op 3 | 0..`MaxStep` (40), fed with the goddess fragment (500 exp each); gives `AddPer` % on base stats, stars, quality color, dance skill, belief |
| Oferenda (dedicação) | `devote`, `devoteGp`, op 4 | 1..`MaxDevote` (5), fed with "Amuleto de Oração" 212028 (10 exp each); gives the guard skill ("Habilidade de Proteção") |
| Batalha | `isFight`, op 5 | exactly one goddess can be the fighting goddess |

Client gate: `GM.isOpen` = `VersionSwitch.GODDESS_OPEN` and `thane.vocationGrades > 0` (job advanced) (`GM:54-59`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/GodDessFrame.as` | frame 1006x624, tabs (bitmaps) Nível, Avanço, Oferenda, Acessórios, Formação | container; tab index 0 level, 1 advance, 2 offering, 3 accessories (`VersionSwitch.GODDESS_EQUIP`), 4 formation (`VersionSwitch.GODDESS_FORMATION`) (`:63-92`) | main toolbar, `SwitchPageHelp` | tabs 1..4 disabled until the selected goddess is active (`:233-261`) |
| `V/view/GoddessChooseView.as` + `V/item/GoddessSelectItem.as` | | left list of the 5 goddesses sorted active first, then `advanceTempInfo.Quality` desc, `grade` desc, `templateId` desc (`GMOD:57-101`) | frame | name, "Nv. {0}", offering "+N", quality frame, "in battle" flag, grey when not active (`GoddessSelectItem.as:58-93`) |
| `V/view/GoddessAvaterView.as` | | big avatar, name, level, stars, battle toggle `_fightBtn` | frame | inactive goddess shows the max level and max step preview (`:172-214`) |
| `V/page/GoddessLevelPage.as` | | switches between activation and level view (`:48-62`) | tab 0 | |
| `V/view/GoddessActiveView.as` | "Condições de invocação: {0}" (`goddess.active.needItem`) | invoke button; preview of max stats (level `MaxGrade` with `AddPer` of `MaxStep`), guard skill of `MaxDevote`, dance skill of `MaxStep` (`:76-112`) | tab 0, inactive goddess | button enabled when bag count of `NeedItemId` >= `NeedItemCount` (`:101`) |
| `V/view/GoddessLevelView.as` + `V/item/GoddessLevelItem.as` | "Quantidade a gastar:", "Nº de {0} que possui: {1}" | level up | tab 0, active goddess | current/next level stats with step bonus and accessory bonus (`:157-204`), exp bar `gradeGp / next.NeedGp` (`:206-238`), guard and dance skill icons |
| `V/page/GoddessAdvancePage.as` + `V/item/GoddessAdvanceItem.as` | "Para avançar a Deusa tem de atingir o nível {0}." | advance | tab 1 | current/next step, exp bar `stepGp / next.NeedGp`, stat preview on hover (`:137-153`, `:301-330`) |
| `V/page/GoddessDedicationPage.as` + `V/item/GoddessDedicationSkillItem.as` | "Quantidade a sacrificar:", "{1} Oferenda Nv. {0}" | offering | tab 2 | offering level (digits), 5 skill rows from `BufferIds` of the current guard skill (`:239-270`), exp bar `devoteGp / next.NeedGp` |
| `V/GodDessInfoCheckFrame.as`, `V/GodDessInfoCheckView.as` | "Ver Deusa" / "Minha Deusa", "Atributos da Deusa" | read only view of another player's fighting goddess beside your own | player info frame (`decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:1614`) via `GC` openType `LOOK_UP_GODDESS` (`GC:31-42`) | `thane.goddessInfo` filled from `DetailRspMsg.goddessInfo` |

## 3. Routes (client to server)

All actions use one opcode: send 5191 (0x1447) `C_GODDESS_OP`, message `GoddessRequestMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | action, table below |
| `templateId` | #2 | INT32 | goddess template id (1..5); for ops 8 and 10 the owner goddess (`GoddessEquipInfo.ownerId`) |
| `count` | #3 | INT32 | number of items to feed (ops 2, 3, 4, 7); accessory slot `equipType` 1..4 for ops 8 and 10 |
| `isFight` | #4 | BOOL | op 5 only: requested battle state |
| `formationId` | #5 | INT32 | ops 6, 7: formation slot 1..5 |

Sender: `GM.requestOp(op, templateId, count, isFight)` (`GM:163-172`), `GM.requestFormationSet` (`GM:174-182`), `GM.requestFormationUpgrade` (`GM:184-192`). No op is a pure query: the client never asks for data, the server pushes 177 at login *(assumption: same login burst as other player data)*.

| op | Action | Module |
|---|---|---|
| 1 | invoke (activate) | this file |
| 2 | feed level items | this file |
| 3 | feed advance items | this file |
| 4 | feed offering items | this file |
| 5 | set battle goddess | this file |
| 6 | set formation slot goddess | `formation.md` |
| 7 | feed formation slot | `formation.md` |
| 8 | strengthen accessory | `equipment.md` |
| 10 | advance accessory | `equipment.md` |

Op 9 has no caller in the client.

### A1. Invoke a goddess (op 1)
- UI: invoke button `_activeBtn` in `GoddessActiveView` (`V/view/GoddessActiveView.as:62-69`).
- Client checks: button enabled only when `GoodsManager.getGoodsNumByTempId(NeedItemId) >= NeedItemCount` (`:101`). No level check besides `GM.isOpen`.
- Sender: `GM.requestOp(1, tempInfo.TemplateId)`.
- Request: `op`=1, `templateId`.
- Response: push 177 with the new goddess (`grade` 1, `step` 0, `devote` 1, stats); the client sets `isActive = true` for every goddess present in the push (`GM:99`), which fires `GodDessEvent.isActive`, swaps the activation view for the level view and flashes the battle button (`V/GodDessFrame.as:171-178`). Bag push 115 `U_C_BAG_MOVE_UPDATE` for the consumed fragments (inventory feature).

### A2. Feed level items (op 2)
- UI: level button `_upLvBtn` (`V/view/GoddessLevelView.as:121-135`), quantity input defaults to `min(owned, 1)` and is clamped to the owned count (`V/page/GoddessBaseView.as:82-89`).
- Client checks: quantity <= 0 -> "Por favor insira a quantidade de materiais." (`goddess.input.zeroTip`); button disabled at max level (no next template, `:221-233`).
- Request: `op`=2, `templateId`, `count` = items.
- Response: push 177 with `grade`, `gradeGp`, stats. The client shows "{0} pontos de experiência adicionados." with `Property1 * consumed` computed from the bag delta (`V/page/GoddessBaseView.as:68-80`), so the bag update must arrive too.

### A3. Feed advance items (op 3)
- UI: `_advanceBtn` (`V/page/GoddessAdvancePage.as:98-117`).
- Client checks: when a next step exists and `grade < next.NeedGrade` and `stepGp >= next.NeedGp` -> "Nível da Deusa insuficiente." (`goddess.advance.gradeNoArm`); quantity <= 0 -> zero tip. Button disabled at max step.
- Request: `op`=3, `templateId`, `count`.
- Response: push 177 with `step`, `stepGp`, stats, `activeSkill`; bag update.

### A4. Feed offering items (op 4)
- UI: `_dedicationBtn` (`V/page/GoddessDedicationPage.as:105-119`).
- Client checks: quantity <= 0; button disabled at offering 5.
- Request: `op`=4, `templateId`, `count`.
- Response: push 177 with `devote`, `devoteGp`, `defanceSkill`; bag update.

### A5. Toggle battle goddess (op 5)
- UI: `_fightBtn` on the avatar (`V/view/GoddessAvaterView.as:97-105`), visible only for an active goddess (`:189`).
- Request: `op`=5, `templateId`, `isFight` = `!current.isFight`.
- Response: push 177 containing the toggled goddess and every goddess whose `isFight` changed. The client sets `model.fightGoddess` only when a pushed goddess has `isFight = true` (`GM:112-115`) and never clears it, so the server must always push the previous fighting goddess with `isFight = false` when switching *(assumption: only one fighting goddess)*.

## 4. Server messages (server to client)

### S1. 177 (0x00b1) `U_C_GODDESSINFO`, message `GoddessMsg`
Receiver `GM.__godInfosHandler` (`GM:67-137`). Sent at login (all active goddesses and formation slots) and after every op 1..10 (only the changed goddess and/or slots are needed, the client merges by `templateId` and `formationId`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `infos` | #1 | GoddessInfoMsg | yes | goddess rows |
| `formations` | #2 | GoddessFormationIdInfoMsg | yes | formation slots, see `formation.md` |

`GoddessInfoMsg`:

| Field | Tag | Type | Meaning | Client use |
|---|---|---|---|---|
| `userId` | #1 | INT32 | owner player id | stored |
| `templateId` | #2 | INT32 | goddess 1..5 | key into `model.infoDic`; unknown ids are ignored (`GM:78-79`) |
| `grade` | #3 | INT32 | level | loads `GoddessUpgradeTemplates` current and next (`GI:156-166`) |
| `gradeGp` | #4 | INT32 | exp inside the current level | progress bar |
| `step` | #5 | INT32 | advance level | loads `GoddessStepTemplates` (`GI:188-198`) |
| `stepGp` | #6 | INT32 | exp inside the current step | |
| `devote` | #8 | INT32 | offering level | loads `GoddessDevoteTemplates` (`GI:265-275`) |
| `devoteGp` | #9 | INT32 | exp inside the current offering level | |
| `attack` | #10 | INT32 | final physical attack | shown in look up, formation share |
| `defance` | #11 | INT32 | final physical defence | |
| `magicAttack` | #12 | INT32 | final magic attack | |
| `magicDefance` | #13 | INT32 | final magic defence | |
| `live` | #14 | INT32 | final HP | |
| `initBelief` | #15 | INT32 | belief at battle start (step template `InitBelief`) | stored |
| `actionBelief` | #16 | INT32 | belief gained per action (step template `ActionBelief`) | stored |
| `activeSkill` | #17 | INT32 | dance skill id (step template `SkillId`) | event `GodDessEvent.activeSkill` |
| `defanceSkill` | #18 | INT32 | guard skill id (offering template `SkillId`) | event `GodDessEvent.defanceSkill` |
| `isFight` | #19 | BOOL | battle goddess | `model.fightGoddess` |
| `equiSuitOpenMax` | #20 | INT32 | highest unlocked accessory set grade *(assumption)* | not read by the client |
| `equipInfos` | #21 | GoddessEquipInfoMsg | repeated | accessories, see `equipment.md` |

Note: there is no tag #7 in the schema.

### S2. Bag updates
115 (0x0073) `U_C_BAG_MOVE_UPDATE` for consumed items (owner: `../inventory/README.md`). Needed for the exp toast (A2..A4) and for button states.

### S3. Look up of another player
4125 (0x101d) `U_C_BAG_EQUIPLOOK`, `DetailRspMsg.goddessInfo` (#22, `GoddessInfoMsg`) holds the fighting goddess of the looked up player; parsed in `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:856-886`. The look up request belongs to `../hero/README.md`.

### S4. Battle
Goddesses arrive in battle creation (`goddesses` list, `decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:895-907`) and reinforcements; their skill casts use 4102 (0x1006) `U_B_GODDESS_STAGE` with `AttackOrderListMsg` (`decompiled/core_module/scripts/battle/transaction/BattleGoddessMovieTransaction.as:26-68`, documented in `docs/battle/rules.md` row 4102). Skill MasterType 80 = guard skill, 81 = other goddess skill (`decompiled/core_module/scripts/battle/skillsys/constants/SkillMaterType.as:6-8`). Battle effect 26 adds belief to a `GoddessRoleInfo` (`docs/battle/rules.md`). Which battle types show the goddess bar: `BattleFunctionHelper.showGoddessTopAry` (`decompiled/core_module/scripts/battle/utils/BattleFunctionHelper.as:281-300`).

No error opcode exists: invalid requests are silently ignored by the client; the server should reply with a system message *(assumption: chat/system tip opcode used by other features)*.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | job advanced (`vocationGrades > 0`) and `GODDESS_OPEN` | `GM:54-59` |
| Invoke cost | `NeedItemCount` x `NeedItemId` of `GoddessTemplateInfos` (50 fragments 212029..212033) | `V/view/GoddessActiveView.as:101` |
| Initial state | `grade` 1, `step` 0, `devote` 1 | `GI:75-93` |
| Item exp | `ItemTempInfo.Property1` per item: 212027 Larimar 10, 212028 Amuleto de Oração 10, fragments 500 (item descriptions) | `V/page/GoddessBaseView.as:76` |
| Level track | next template (`Type` = goddess type, `Level` = grade+1) gives `NeedGp` and `NeedItemId` 212027; NeedGp grows from 50 (Lv2) to 88300 (Lv240) | `GoddessUpgradeTemplates.xml`, `GI:163-164` |
| Advance track | next step template `NeedGp` (5000 at step 1 up to 1600000 at step 40), `NeedItemId` = own fragment, `NeedGrade` (level gate: 4 at step 1 ... 237 at step 40) | `GoddessStepTemplates.xml` |
| Offering track | next devote template `NeedGp` (Lv2 5000, Lv3 10000, Lv4 30000, Lv5 50000), item 212028 | `GoddessDevoteTemplates.xml` |
| Exp carry | progress fields are per level: bar = `gp / next.NeedGp`. Server: `gp += count * Property1`; while a next row exists and `gp >= next.NeedGp`: `gp -= next.NeedGp`, level++ *(assumption on overflow carry)*; at max level stop and do not consume more than needed *(assumption)* | `V/view/GoddessLevelView.as:206-238` |
| Advance gate | step cannot rise while `grade < next.NeedGrade`; exp may still accumulate up to `next.NeedGp` *(assumption: excess blocked)* | `V/page/GoddessAdvancePage.as:104` |
| Stats | per stat X in (Attack, Defance, MagicAttack, MagicDefance, Live): `floor(level.X * (100 + step.AddPer) / 100) + accessoryAdd(X)` | `GM:44-47`, `V/item/GoddessLevelItem.as:148-151`, `V/view/GoddessLevelView.as:164-204` |
| Accessory add | head -> Live, ear -> Defance, flower -> Attack, necklace -> MagicDefance (see `equipment.md`) | `V/view/GoddessLevelView.as:168-178` |
| Skills | dance skill = `step.SkillId` (`activeSkill`), guard skill = `devote.SkillId` (`defanceSkill`, 8010001..8050005) | `V/view/GoddessLevelView.as:240-248` |
| Belief | `InitBelief` and `ActionBelief` from the current step row | `GoddessStepTemplates.xml` |
| Quality and stars | from the current step row (`Quality` 2..5, `Star`) | `V/view/GoddessAvaterView.as:190-195` |
| Battle goddess | one per player; only active goddesses | `V/view/GoddessAvaterView.as:189` |
| Related events | "Forja Dupla da Deusa" (accessories, `equipment.md`); `FunnyType.GODDESS_GRADE` 239 activity ranks goddess level (`decompiled/core_module/scripts/funny/datas/FunnyType.as:388`, owner [seasonal-events](../seasonal-events/README.md)) | |

## 6. Templates

| File | Cate (`TM:1270-1276`) | Fields used |
|---|---|---|
| `GoddessTemplateInfos.xml` | `goddessTempCate` | `TemplateId`, `TemplateName` (contains a newline, removed for display), `Type`, `NeedItemId`, `NeedItemCount`, `Pic` (head icon), `Resource` (avatar swf), `MaxGrade` 240, `MaxStep` 40, `MaxDevote` 5 |
| `GoddessUpgradeTemplates.xml` | `goddessLevelTempCate.getTemplete(type, level)` | `Type`, `Level`, `NeedItemId`, `NeedGp`, `Attack`, `Defance`, `MagicAttack`, `MagicDefance`, `Live` (1200 rows, 240 per type) |
| `GoddessStepTemplates.xml` | `goddessAdvanceTempCate.getTemplete(type, step)` | `Level`, `Star`, `NeedItemId`, `NeedGp`, `AddPer` (% bonus), `SkillId`, `InitBelief`, `ActionBelief`, `NeedGrade`, `Quality` (205 rows, 41 per type) |
| `GoddessDevoteTemplates.xml` | `goddessDedicationTempCate.getTemplete(type, devote)` | `Level`, `NeedItemId`, `NeedGp`, `SkillId` (25 rows) |
| `ItemTempInfos.xml` | goods | 212027..212033 `Property1` exp per item |
| skill templates | `TM.getSkillTemplateInfoById` | `Icons`, `BufferIds` (offering page rows) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS goddess;

CREATE TABLE goddess.goddesses (
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id  SMALLINT NOT NULL CHECK (template_id BETWEEN 1 AND 5),
  grade        SMALLINT NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 240),
  grade_gp     INTEGER  NOT NULL DEFAULT 0 CHECK (grade_gp >= 0),
  step         SMALLINT NOT NULL DEFAULT 0 CHECK (step BETWEEN 0 AND 40),
  step_gp      INTEGER  NOT NULL DEFAULT 0 CHECK (step_gp >= 0),
  devote       SMALLINT NOT NULL DEFAULT 1 CHECK (devote BETWEEN 1 AND 5),
  devote_gp    INTEGER  NOT NULL DEFAULT 0 CHECK (devote_gp >= 0),
  is_fighting  BOOLEAN  NOT NULL DEFAULT FALSE,
  activated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, template_id)
);
CREATE UNIQUE INDEX goddesses_one_fighting ON goddess.goddesses (player_id) WHERE is_fighting;
```

Final stats, skills and belief are derived from templates plus accessories and are not stored (compute on load, cache in memory).

## 8. Backend implementation notes

Handlers (dispatch on `GoddessRequestMsg.op`):

| op | Handler |
|---|---|
| 1 | `goddess::goddess::handle_activate` |
| 2 | `goddess::goddess::handle_feed_level` |
| 3 | `goddess::goddess::handle_feed_advance` |
| 4 | `goddess::goddess::handle_feed_offering` |
| 5 | `goddess::goddess::handle_set_fighting` |

Validation order for every op: feature open (job advanced) -> template exists -> goddess row exists and active (except op 1: must not exist) -> op specific checks -> item count in bag >= cost -> apply in one transaction (consume items through the inventory service, update `goddess.goddesses`) -> commit -> push 115 then 177 -> recompute the hero combat power (`../hero/README.md`), because the fighting goddess, formation share and accessories feed player stats.

- Feed ops: clamp `count` to `[1, owned]`; consume only what is needed to reach the max level *(assumption)*; apply the exp loop from section 5.
- Op 5: in one transaction set `is_fighting = false` for all rows of the player, then set the requested row to `isFight`; push 177 with both rows.
- Battle configuration: when building any PvE/PvP battle where the hero fights, add the fighting goddess to `goddesses` with its final stats, `initBelief`, `actionBelief`, `activeSkill`, `defanceSkill` (see `docs/battle/server-engine.md` and `docs/battle/rules.md`). Which battle types include goddesses is decided per battleType (`showGoddessTopAry`).
- No timers or resets.

## 9. Open questions and assumptions

- *(assumption)* Exp overflow carries into the next level; feeding stops at the cap.
- *(assumption)* Advance exp is capped at `next.NeedGp` while the level gate is not met.
- *(assumption)* 177 at login includes all five template rows only for active goddesses; inactive goddesses must not be sent (the client marks every received goddess as active, `GM:99`).
- `equiSuitOpenMax` (#20) is never read; keep it filled with the highest set grade reached.
- No error codes: the server should send a generic system tip on failure.
- `MagicAttack` equals `Attack` in all templates; keep both.

## 10. Implementation checklist

- [ ] Screens available in client (no work): `GodDessFrame`, choose list, avatar, activation, level, advance, offering, look up.
- [ ] Route 5191 op 1 activate.
- [ ] Route 5191 op 2 feed level.
- [ ] Route 5191 op 3 feed advance with level gate.
- [ ] Route 5191 op 4 feed offering.
- [ ] Route 5191 op 5 battle toggle (single fighting goddess).
- [ ] Push 177 `GoddessMsg` at login and after each op.
- [ ] `DetailRspMsg.goddessInfo` (#22) in 4125 look up.
- [ ] Table `goddess.goddesses` with unique fighting index.
- [ ] Stat formula with step `AddPer` and accessory add.
- [ ] Battle: fighting goddess added to battle creation and reinforcement payloads.
- [ ] Tests: activation consumes 50 fragments; feeding crosses several levels; advance blocked by `NeedGrade`; offering stops at 5; toggling battle goddess clears the previous one; look up returns the fighting goddess.
