# Steles: equip, collection, sync and selection

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/SteleSysManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/stele/StelesysModel.as` |
| INFO | `decompiled/core_module/scripts/mvc/module/stele/StelesysInfo.as` |
| ATT | `decompiled/core_module/scripts/mvc/module/stele/StelaAttInfo.as` |
| V | `decompiled/m14/scripts/stelesys/` |

## 1. Overview

This module owns the stele collection of a player: the full list pushed on login (4279), incremental updates (4280) shared by every other module, the main page with 10 slots, equip and unequip (8664 op 1), the selection frame used by every tab to pick a target stele, the tooltip, and the aggregation of attributes and the core passive skill into the hero.

Client data model (MGR `__dataInfosHandler`, `MGR:76-131`):
- Normal steles (`step >= 0`) are kept in `infoDic` keyed by `id`. `isExist = false` removes the entry (`MGR:123-126`).
- Strengthening materials (`step == -1`, templates with `MasterType = 2`, e.g. 2101 "Estela de fortalecimento - Verde") are kept in `metralDic` keyed by `id`; for them `exp` is the owned quantity and they are never removed client side (an entry with `exp = 0` is hidden, `MOD:145-164`).
- A stele is equipped when `1 <= pos <= 10` (`INFO:123-131`); pos 1 is the core slot, 2..10 aux slots.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/SteleSysFrame.as` | "Estela" (`stela.mainFrame.title`, `:67`) | 985x675 frame with 5 tabs (bitmap labels; help text names them Estela, Fortalecimento, Ascensão, Purificação, Recuo) and a help button | toolbar child button, `openControllerByInfo("stelesys", ..., tabIndex)` | tab selected by `frameData` (`:135-142`); help frame `stela.helpFrame.content` (`:161-166`) |
| `V/view/SteleSysmainView.as` | tab 0 | Core slot (`StelesysHexinItem`, pos 1) + 9 aux slots (`StelesysFuzhuBox`, pos 2..10), name of the core stele, its attributes, its passive skill and the sum of all equipped attributes | tab 0 | `model.equipList` (`:142-174`); left column: total of `stelaAttInfo + skillAttInfo` over equipped steles for all 10 attributes (`:204-247`); middle column: core stele attributes (`:176-202`) |
| `V/item/StelesysHexinItem.as` | | Slot with "up" (equip) and "down" (unequip) buttons | main view | level, stars (`Rarity`), color frame (`stepColor`), tooltip |
| `V/item/StelesysFuzhuBox.as` | | Aux slot, shows a lock when `vocationGrades < (pos - 2) * 5` (`:42-55`) | main view | name `nameStep` |
| `V/item/StelaSkillItem.as` | | Core passive skill: `TemplateName + " " + "Nv. {0}, Equipes 4V4"` (key `dayGuide.data.DailyList.level01` with `Grades`) and `Description`; greyed unless `pos == 1` (`:45-72`) | main view, tooltip | `stepTempInfo.PassiveSkills` |
| `V/SteleSwitchFrame.as` | "Seleção de Estela" (`stela.switchFrame.title`) or "Visualização da Estela" (`stela.preview.title`) when type 0 (`:170-184`) | Paged list (40 per page) of owned steles, filter menu by stars and color, click to choose | any tab via `openControllerByInfo("stelesys","switch.page",type)` | `model.allStelaList` filtered and sorted (`:77-102`); for type 2 only steles with `level != StrengthLimit` (`:81-90`); counter of results |
| `V/item/StelesysSwitchBox.as` | | One stele in the selection list; "Equipado" (`stela.equip`) when on a slot; click sets `model.currChoose` (`:78-82`) | selection frame | name, level, stars, color |
| `V/view/SteleSysChooseMenu.as`, `V/view/StelesysSwitchView.as` | toggles "1★".."5★" (`stela.check.star0..4`) and "branco", "verde", "azul", "roxo", "laranja" (`stela.check.step0..4`) | Client-only filter. Filter string `"s1|..|s6,c1|..|c6"` (`MOD:23-27`) | selection frame, Fortalecimento, Recuo | `getSwitchMenuName` builds `[["star",n]]` and `[["stepColor",n]]` filters (`V/view/SteleSysChooseMenu.as:74-132`) |
| `V/view/StelesysSortView.as` | "Decrescente", "Crescente", "Nv. de estrelas", "Grau", "Nível", ... (`stela.sort.a*`, `stela.sort.b*`) | Sort popup; its confirm handler does nothing (`:101-110`), dead UI | not instantiated by any view | none |
| `V/view/StelesysBagView.as` | empty text "Nenhuma Estela que cumpra as condições" (`stela.noGoods`) | Generic grid used by every tab | tabs and selection frame | list of `StelesysInfo` |
| `V/view/StelesysboxTip.as` | | Tooltip: icon, `nameStep` (`TemplateName +step` colored by `Profile`), attributes, passive skill, refine lines | every stele box (`tipData`) | `stelaAttInfo`, skill1..5 names (`:79-147`) |

Selection frame types (`frameData`): 0 preview (clicks disabled, `V/SteleSwitchFrame.as:173-177`; the only opener `SteleSysmainView.previewHandle` `:254-262` is never bound, dead code), 1 equip (`V/item/StelesysHexinItem.as:101`), 2 Fortalecimento target (`V/item/StelesysIntensifyBox.as:78`), 3 Ascensão target (`V/item/StelaStepChooseBoxItem.as:70`), 4 Purificação target (`V/item/StelaReineBoxItem.as:58`). The choice is broadcast as `STELE_SYS_CHOOSE` (`MOD:171-182`) and consumed by the single live tab (`TabPageUtil` disposes inactive tabs, `decompiled/core_module/scripts/yishi/view/base/TabPageUtil.as`).

Client sort used everywhere: `MOD.doSort` (`MOD:315-346`) sorts on `star`, `step`, `level` descending (ascending in Fortalecimento) and moves equipped steles first.

## 3. Routes (client to server)

### R1. Equip a stele into a slot
- UI: "up" button on an empty slot (core or unlocked aux) -> `StelesysHexinItem.doUpHandler` (`V/item/StelesysHexinItem.as:93-102`): if `model.allStelaList.length == 0` shows "Sem Estelas, obtenha Estelas primeiro!" (`stela.switch.noTip`); else stores `model.operPos = pos` and opens the selection frame type 1. Clicking a stele sets `currChoose` -> `SteleSysmainView.chooseHandler` (`V/view/SteleSysmainView.as:123-140`).
- Client checks: if any equipped stele has the same `templateId` -> "Já equipou Estela com o mesmo nome, remova antes a Estela de mesmo nome" (`stela.equip.same`, `:130-136`) and nothing is sent. The aux slot lock is UI-only (button hidden when locked, `V/item/StelesysFuzhuBox.as:46-54`).
- Sender: `SteleSysManager.sendEquip(id, operPos)` (`MGR:133-141`).
- Route: client to server, 8664 (0x21d8) `C_STELA_CLIETN_OP`, `player.PlayerOpMsg`:
  - `op` (#1, INT32) = 1 (`OP_EDIT`).
  - `id` (#5, INT32) = stele id to equip.
  - `pos` (#19, INT32) = target slot 1..10.
  - Other fields unused: `type` (#2), `payType` (#3), `count` (#4), `index` (#6), `userId` (#7), `templateId` (#8), `campaignId` (#9), `nodeId` (#10), `chapterId` (#11), `uuid` (#12, STRING), `value1` (#13), `value2` (#14), `param1` (#15, STRING), `param2` (#16, STRING), `flag1` (#17, BOOL), `flag2` (#18, BOOL), `ids` (#20, INT32, repeated).
- Expected response: 4280 `U_C_STELA_UPDATE` with the equipped stele (new `pos`) and, if the slot was occupied, the previous stele with `pos = 0`. Then the hero attribute push (hero feature).

### R2. Unequip a slot
- UI: "down" button on an occupied slot -> `StelesysHexinItem.doDownHandler` (`V/item/StelesysHexinItem.as:104-110`).
- Sender: `sendEquip(0, pos)` (`MGR:133-141`).
- Route: 8664 (0x21d8), `PlayerOpMsg` `op` (#1) = 1, `id` (#5) = 0, `pos` (#19) = slot to clear.
- Expected response: 4280 with the removed stele and `pos = 0`; hero attribute push.

### R3. Open frame, filters, preview (no route)
Opening the frame, switching tabs, filters, paging and tooltips are client-only. The client never requests the list; it relies on 4279 at login.

## 4. Server messages (server to client)

### S1. 4279 (0x10b7) `U_C_STELA_DATA` and S2. 4280 (0x10b8) `U_C_STELA_UPDATE`
- Message `stela.StelaMsg`:
  - `opType` (#1, INT32): read but unused by the client (`MGR:83`). Assumption: 0 for the login sync, otherwise the 8664 `op` that caused the update (1, 2, 3, 6, 7) or 8 for box opening.
  - `datas` (#2, MESSAGE `StelaDataMsg`, repeated).
- `stela.StelaDataMsg`:
  - `id` (#1, INT32): stele row id (material rows also have an id).
  - `templateId` (#2, INT32): `StelaTemplates.TemplateId`.
  - `pos` (#3, INT32): 0 not equipped, 1 core slot, 2..10 aux slot. Ignored for materials.
  - `step` (#4, INT32): 0..`StepLimit`; -1 marks a strengthening material row.
  - `level` (#5, INT32): strength level 0..`StrengthLimit` of the current step.
  - `exp` (#6, INT32): normal stele: EXP inside the current level (`totalExp - Exp(level)`), shown against `currStrengthLvExp` (`INFO:210-222`); material row: owned quantity.
  - `totalExp` (#7, INT32): cumulative strength EXP (compared with `StelaPropertyTemplates.Exp`, which is cumulative).
  - `skill1` .. `skill5` (#8..#12, INT32): refine attribute skill ids (0 = empty line).
  - `isExist` (#13, BOOL): false deletes the stele client side.
- Receiver: both opcodes go to `SteleSysManager.__dataInfosHandler` (`MGR:59-60`, `MGR:76-131`), which upserts by id, recomputes attributes (`INFO.updateStelaAttInfo`, `INFO:266-304`) and fires `STELE_SYS_UPDATA` (`MGR:130`) to refresh the active tab.
- When: 4279 once after login with every stele and every material row (the client keeps entries across pushes, so a full list is safe to resend). 4280 after every change (equip, strengthen, step, refine accept, rollback, box opening) with only the changed rows; consumed steles are sent with `isExist = false`; materials are sent with their new quantity.
- Error codes: none in the message. Assumption: failures are reported through the generic notice 126 (0x007e) `U_C_MSG` (`campaign.CampaignNotifyMsg` `body` #4 STRING) handled by `BaseManager.__msgHandler` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:299`, `:2070-2085`), or ignored silently.

## 5. Rules and formulas

- Slots: 1 core + 9 aux (`V/view/SteleSysmainView.as:98-108`). Aux slot `p` (2..10) unlocked when `vocationGrades >= (p - 2) * 5`, i.e. slot 2 always, slot 3 at 5, ..., slot 10 at 40 (`V/item/StelesysFuzhuBox.as:42-55`). The server must enforce it.
- Unique template among equipped steles (`V/view/SteleSysmainView.as:129-137`). Because the selection list includes equipped steles, choosing an already equipped stele is blocked by the same check, so moving between slots requires unequip then equip.
- Equipping into an occupied slot replaces it (assumption: the previous stele goes to `pos = 0`).
- Attributes of one stele (`INFO:266-304`): `Property(templateId, level)` (0 when level 0) + `Step(templateId, step)` + resist bonus (for every `StelaResistTemplates` row of the template with `StrengthLevel <= level`, add the `SkillPropertyTempInfos` `ResiPenetrate` and `ReduceResiAgainst` of `SkillId`, `INFO:99-121`) + refine lines (`SkillPropertyTempInfos` of skill1..5, `INFO:306-326`).
- Hero bonus = sum over equipped steles (pos 1..10) of the above (`V/view/SteleSysmainView.as:204-247`).
- Core passive skill: `StelaStepTemplates.PassiveSkills` of the stele in pos 1 only (`V/item/StelaSkillItem.as:56-70`); `SkillTempInfos` row (e.g. 7110100 "Armadura Leve Nobre", `BufferIds` 71101000, "Ao lançar a habilidade, há 3% de chance de que o dano causado aumente em 3% por 2 rodadas"). Passive skill ids follow `7` + `StelaId` + 2 digit step (7110100 = 1101 step 0, 7150120 = 1501 step 20).
- Display name `nameStep` = `TemplateName + " +" + step`, colored by `Profile` of the step (1 white .. 6 red) (`INFO:328-338`).
- Client filter quirk: the filter popup has only 5 star and 5 color toggles (`V/view/StelesysSwitchView.as:57-85`) while 6 exist; after confirming, the 6th entry parses as 0 and 6★ / vermelho steles are filtered out. Client-only, no server impact.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/StelaTemplates.xml` (cate `StelaTemplateCate`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1336-1339`) | 28 rows. 27 steles (`MasterType = 1`): 1101..1103 (Rarity 1, StepLimit 2, Exp 10), 1201..1203 (R2, 6, 20), 1301..1306 (R3, 10, 30), 1401..1406 (R4, 15, 40), 1501..1506 (R5, 20, 50), 1601..1603 (R6, 25, 60). 1 material: 2101 "Estela de fortalecimento - Verde" (`MasterType = 2`, Exp 1) | `TemplateId`, `TemplateName` (pt-BR, e.g. "Armadura Leve Nobre"), `Description`, `Icon` (`icon/stela/<Icon>`, `decompiled/core_module/scripts/yishi/utils/IconFactory.as:20-23`), `Rarity` (stars), `StepLimit` (max step), `Exp` (EXP given when consumed), `MasterType` (1 stele, 2 material) |
| `raw/xml/tempinfos/StelaStepTemplates.xml` (key `StelaId_Step`) | 396 rows, one per stele and step 0..StepLimit | `StrengthLimit` (level cap), `Profile` (color 1..6), stats `Attack`..`ResiPenetrate`, `PassiveSkills`, plus fields of other modules (`CostItem`, `CostItemStep`, `CostNum`, `SkillMasterType`, `BaptizeCostItem`, `BaptizeCostNum`, `BaptizeLimit`) |
| `raw/xml/tempinfos/StelaPropertyTemplates.xml` (key `StelaId_StrengthLevel`) | One row per stele and level 1..max (15, 35, 75, 150, 225, 300 by rarity) | stats per level, `Exp` = cumulative EXP needed to reach the level (1101: 35, 74, 115, ...) |
| `raw/xml/tempinfos/StelaResistTemplates.xml` (key `StelaId_StrengthLevel`) | Every 10 levels a resist bonus | `StrengthLevel`, `SkillId` (MasterType 141xx..146xx, e.g. 1410001 "Anti-Resistência +100/Resistência de Penetração +100") |
| `raw/xml/tempinfos/SkillTempInfos.xml`, `SkillPropertyTempInfos.xml` | passive, resist and refine skills | `TemplateName`, `Grades`, `Description`, `BufferIds`; property columns |

## 7. Persistent state

Schema `steles`. Assumption: stele ids are server generated INT (protocol is INT32) unique per server.

```sql
CREATE SCHEMA IF NOT EXISTS steles;

CREATE TABLE steles.player_steles (
    stele_id      INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id   INTEGER NOT NULL,              -- StelaTemplates.TemplateId, MasterType = 1
    step          SMALLINT NOT NULL DEFAULT 0 CHECK (step >= 0),
    level         SMALLINT NOT NULL DEFAULT 0 CHECK (level >= 0),
    total_exp     INTEGER  NOT NULL DEFAULT 0 CHECK (total_exp >= 0),
    slot_pos      SMALLINT NOT NULL DEFAULT 0 CHECK (slot_pos BETWEEN 0 AND 10),
    refine_skill_ids INTEGER[] NOT NULL DEFAULT '{0,0,0,0,0}' CHECK (cardinality(refine_skill_ids) = 5),
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX player_steles_player_idx ON steles.player_steles (player_id);
CREATE UNIQUE INDEX player_steles_slot_uq ON steles.player_steles (player_id, slot_pos) WHERE slot_pos > 0;
CREATE UNIQUE INDEX player_steles_equipped_template_uq ON steles.player_steles (player_id, template_id) WHERE slot_pos > 0;

CREATE TABLE steles.player_stele_materials (
    material_id   INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- sent as StelaDataMsg.id with step = -1
    player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id   INTEGER NOT NULL,              -- StelaTemplates MasterType = 2 (2101)
    quantity      INTEGER NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    UNIQUE (player_id, template_id)
);
```

`exp` sent to the client is derived: `total_exp - PropertyExp(template_id, level)` (0 for level 0). Deleted steles are hard deleted (or soft deleted with an audit row, see `intensify.md`). Refine pending results live in `refine.md`.

Assumption: stele and material ids must not collide in the client because they are stored in two different dictionaries (`infoDic`, `metralDic`), so separate sequences are fine.

## 8. Backend implementation notes

- `steles::equip::handle_client_op` (dispatcher for 8664): decode `PlayerOpMsg`, switch on `op` 1..7 to the module handlers; unknown op -> ignore and log.
- `steles::equip::handle_equip` (op 1):
  1. Feature gate (assumption: `vocationIndex > 0`).
  2. `pos` in 1..10; for `pos >= 2` check `vocationGrades >= (pos - 2) * 5`.
  3. `id == 0`: unequip the stele at `pos` if any.
  4. `id > 0`: stele owned and not material; not already equipped in another slot (reject); no other equipped stele with the same `template_id` except the one being replaced in `pos` (assumption: allow same-template replacement in the same slot).
  5. Transaction: clear previous occupant (`slot_pos = 0`), set new `slot_pos`.
  6. Push 4280 with changed rows (`opType = 1`), then recompute hero attributes and push the hero update (hero feature).
- `steles::equip::push_full_sync` on login: 4279 with all steles and all material rows (`step = -1`, `exp = quantity`, `isExist = true`).
- `steles::equip::build_update` helper used by every module to emit 4280.
- Hero attribute provider `steles::equip::attribute_bonus(player_id)` returning the 10 attributes (section 5), cached and invalidated on any 4280.
- Battle: when building the hero unit (see `docs/battle/server-engine.md`), add `PassiveSkills` of the pos 1 stele's step to the hero's passive skills; no battle is started by this feature.

## 9. Open questions and assumptions

- Assumption: `StelaMsg.opType` echoes the triggering op, 0 at login; the client ignores it.
- Assumption: unequipped steles have `pos = 0`.
- Assumption: errors are silent or use 126 `U_C_MSG`; the client has no error code handling for 8664.
- Assumption: feature gate `isChangeJob`; the BR client hides the toolbar entry (`isChildOpen = false`), confirm whether the feature was disabled server side on the original server.
- Open: maximum number of steles a player may own (no limit visible client side; selection lists are paged by 40).
- Open: whether hero attributes are pushed through 3 `U_C_PLAYER_INFO` or a dedicated hero attribute message (owned by hero).

## 10. Implementation checklist

- [ ] Template loaders for the 4 stele XML files and skill pools.
- [ ] Tables `steles.player_steles`, `steles.player_stele_materials` with indexes.
- [ ] 4279 login sync (steles + materials).
- [ ] 4280 builder with `isExist = false` for deletions and `step = -1` rows for materials.
- [ ] 8664 dispatcher on `PlayerOpMsg.op`.
- [ ] R1 equip with slot unlock, unique template, replacement.
- [ ] R2 unequip.
- [ ] Hero attribute aggregation (level, step, resist, refine) and push.
- [ ] Core passive skill injected into battle.
- [ ] Screens verified: main tab totals, core attributes, passive skill grey when not core, aux locks, selection frame types 1..4, tooltip.
- [ ] Tests: equip into locked slot rejected; duplicate template rejected; replace occupied slot; unequip empty slot no-op; attribute sum matches client formula for a stele at level 10 (resist bonus included).
