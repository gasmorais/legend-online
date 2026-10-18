# Dragon Talker talismans: equip, strengthen, batch strengthen, quality, absorb, sell

Module `talisman`. Talismans ("Talismã") are the Dragon Talker's equipment. They live in a dedicated talisman bag (not the hero bag), are equipped in six typed slots, gain exp by consuming other talismans ("fortalecer"), raise quality when the exp cap of their quality is reached, and gain random secondary attributes by absorbing a talisman of the same type ("absorver"). Same set talismans give 2 and 4 piece bonuses.

Path aliases:

| Alias | File |
|---|---|
| DTM | `decompiled/core_module/scripts/managers/DragonTalkerManager.as` |
| DMOD | `decompiled/core_module/scripts/mvc/module/dragontalker/DragonTalkerModel.as` |
| DTI | `decompiled/core_module/scripts/mvc/module/dragontalker/DragonTalkerTalismanInfo.as` |
| MIH | `decompiled/core_module/scripts/dragontalker/DragonTalkerMutipleIntensifyHelper.as` |
| V | `decompiled/m5/scripts/dragontalker/` |

`DragonTalkerOpMsg` field table and op enum: `talker.md` section 3.

## 1. Overview

| Slot (`equipslot` = item `SonType`) | pt-BR (`DragonTalkerBattleEquipInfoView.equipType.contentN`) |
|---|---|
| 401 | Chapéu |
| 402 | Anel |
| 403 | Arma |
| 404 | Colar |
| 405 | Acessório |
| 406 | Vestuário |
| 407 | "Talismã de Experiência" (8407001, stackable 9999, exp only, cannot be equipped) |

Talisman items: `ItemTempInfos.xml` MasterType 8, SonType 401..407. Fields: `Profile` quality 2 green, 3 blue, 4 purple, 5 orange; stat attribute(s) (`Attack`, `Live`, ...); `Property1` exp given when consumed (10; exp talisman 100); `Property2` template of the next quality (0 at orange); `Property3` exp cap of this quality (36000, 216000, 594000, 1404000 = `UpGradeTempInfos` Types 141 `Data` at grades 9, 18, 27, 36); `SuiteId` set id.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/view/DragonTalkerEquipView.as` + `V/cell/DragonTalkerTalismanEquipCell.as` | | 6 equipped slots, hero avatar, attribute button, form switch | main tab | `DMOD.getEquipTalismanInfoBySontype(401..406)` (`:1052`) |
| `V/view/DragonTalkerBagView.as` + `V/cell/DragonTalkerTalismanBagCell.as` | "Talismã" | talisman bag filtered by type buttons (attribute talismans, exp talismans, type 1..6) | main, talisman tabs | `DMOD.getTalismanListBySontype`, sort: equipped first, quality desc, level desc, template desc (`DMOD:468-523`) |
| `V/view/DragonTalkerTalismanView.as` | | sub tabs strengthen / absorb (`:41-91`) | tab talismans | |
| `V/view/DragonTalkerIntensifyView.as` | | strengthen left talisman with right material; quality upgrade button; batch button | talisman tab | exp bar `leftExp / (next.Data - cur.Data)`, "+N" exp, stat gain per level `floor(stat * 0.02)` (`:263-347`) |
| `V/DragonTalkerMutipleIntensifyFrame.as` + `V/item/DragonTalkerMutipleIntensifyItem.as` | "Fortalecimento em Lote", "Nome do Talismã" | batch strengthen list with total exp | batch button (`MIH` cursor mode) | `_totalExp += count * Property1` (`:150-168`) |
| `V/view/DragonTalkerSwallowView.as` | | absorb right into left, animation on success | talisman tab | secondary attributes of both |
| `decompiled/m16/scripts/yishi/view/tips/DragonTalkerTalismanTips.as` | "Atributos do Talismã", "Efeitos do Conjunto", "Equipado" | tooltip | any cell | main stat, secondary skills, set effects; sends op 4 when `isNew` (`:141-147`) |
| `V/DragonTalkerSellHelp.as`, `decompiled/core_module/scripts/bag/view/ItemSellView.as` | | sell talismans for gold | bag sell cursor | `GoodsCheck.getSellGold * count` |

## 3. Routes (client to server)

All: send 9667 (0x25c3) `C_DRAGONTALKER_OP`, `DragonTalkerOpMsg`.

### A1. Equip / unequip (op 3 EQUIP_TALISMAN)
- UI: double click a bag cell in main view (`V/mediator/DragonTalkerBagCellClickMediator.as:59-81`), drag to an equip cell (`V/mediator/DragonTalkerBagCellDropMediator.as:118`), double click or drag out an equipped cell (`V/mediator/DragonTalkerEquipCellClickMediator.as:59-71`, `V/mediator/DragonTalkerEquipCellDropMediator.as:112`), handle cell (`V/mediator/DragonTalkerHandleCellClickMediator.as:78`).
- Client checks: exp talisman -> "Não é possível equipar o Talismã de Experiência"; wrong slot on drop -> "Este talismã apenas pode ser equipado na posição correspondente."; unequip when the bag already holds 91 talismans of that type -> "Todos os slots deste tipo de equipamento na mochila já estão sendo utilizados" (`DMOD.getIsFullBySontype`, `DMOD:525-529`).
- Request: `op`=3, `talismanId` (#2). Toggle: equipped -> unequip, else equip into slot = its SonType (replacing the current one).
- Response: 4844 with the changed talismans (`equipslot` 0 or 401..406), then 4845 is not needed; hero attribute push *(assumption)*.

### A2. Mark seen (op 4 SET_NOT_NEW)
- UI: hovering a talisman with `isNew` (tooltip).
- Request: `op`=4, `talismanId`.
- Response: 4844 with `isNew` false.

### A3. Strengthen (op 5 STRENGTHEN_TALISMAN)
- UI: "Fortalecer" (`V/view/DragonTalkerIntensifyView.as:177-208`). Left cell = target (double click, `hideCellDic["2_1"]`), right cell = material (`"2_2"`; exp talismans always go right).
- Client checks: both set; material equipped -> "Talismãs já equipados não podem ser utilizados para fortalecimento."; attribute material asks "Confirma que deseja utilizar o talismã {0} para fortalecer? (Após confirmar este talismã desaparecerá.)"; count input clamped to the material stack (`:142-175`); disabled at max level or at quality cap.
- Request: `op`=5, `talismanId` = target, `materialId` (#7) = material id, `count` (#3) = number consumed (stack count for exp talismans, 1 otherwise).
- Response: 4844: target with new `gp`/`grade`, material with `isExist` false or reduced `count`.

### A4. Batch strengthen (op 17 BATCH_STRENGTHEN)
- UI: batch button enters a cursor mode (`MIH:36-123`); each clicked bag cell (not equipped) is added to `DragonTalkerMutipleIntensifyFrame`; "Fortalecer" sends (`V/DragonTalkerMutipleIntensifyFrame.as:170-205`). Confirmation "Confirma que deseja utilizar os talismãs selecionados ({0}, etc.) para fortalecer? (Após confirmar os talismãs desaparecerão.)" when any non exp talisman is in the list.
- Request: `op`=17, `talismanId` = target (`model.intensifyTalismanInfo`), `materialList` (#13, repeated `MaterialListMsg`: `materialId` #1 talisman id, `count` #2).
- Response: 4844 with the target and all consumed materials.

### A5. Raise quality (op 16 UPGRADE_QUALITY)
- UI: "awake" button appears when `curUpgradeTemp.ActiveObject != 0` and `Property3 == curUpgradeTemp.Data` (exp cap of the current quality reached) (`V/view/DragonTalkerIntensifyView.as:210-222`, `:307-320`).
- Client check: gold >= `ActiveObject` of the Types 141 row at the current grade (100000 at grade 9, 1000000 at 18, 5000000 at 27) else "public.gold".
- Request: `op`=16, `talismanId`.
- Response: 4844 with `templateId` = `Property2` (next quality), possibly a new secondary slot ("(Ativ. qualidade verde/azul/laranja)"); gold push.

### A6. Absorb (op 6 REFRESH_TALISMAN)
- UI: absorb tab (`V/view/DragonTalkerSwallowView.as:109-139`). Left and right must share `SonType` (`V/mediator/DragonTalkerBagCellClickMediator.as:99-129`, drop: "Apenas pode absorver talismãs do mesmo tipo."); exp talismans are ignored; equipped material -> "Talismãs já equipados não podem ser utilizados para absorção."; confirmation "Confirma que deseja utilizar o talismã de atributos {0} para fortalecer? (Após confirmar este talismã desaparecerá.)".
- Request: `op`=6, `talismanId` = left, `materialId` = right.
- Response, in order: 4846 `DragonTalkerOpMsg` with `op` 6, `result` (#11, 0 = success), `newSkillIndex` (#12, index of the rolled secondary in the right talisman's list, used for the animation end frame) (`DTM:231-247`, `V/view/DragonTalkerSwallowView.as:148-168`); then 4844 with the target holding `newSkillId` (#9) and `oldSkillIndex` (#10) (the slot it would replace, -1 when there is a free slot) and the material removed.
- Pending choice: while any talisman has `oldSkillIndex >= 0` the strengthen view pops "{0} obteve um novo atributo de talismã:{1}" or "Após completar as seguintes escolhas de absorção poderá executar a próxima operação.\nO atributo secundário de {1} de {0} será substituído por {2}." (`V/view/DragonTalkerIntensifyView.as:348-375`).

### A7. Accept or discard the absorbed attribute (op 14 RANDOMSKILL_REPLACE, op 15 RANDOMSKILL_DISCARD)
- UI: confirm/cancel of the alert above (`V/view/DragonTalkerIntensifyView.as:377-387`, `V/view/DragonTalkerSwallowView.as:271-281`).
- Request: `op`=14 or 15, `talismanId`.
- Response: 4846 with `op` 14/15 and `result` (0 = ok -> refresh, `DTM:243-246`); 4844 with `randomSkillList` updated (replace) and `newSkillId` 0, `oldSkillIndex` -1.

### A8. Sell (op 20 SELL_TALISMAN)
- UI: bag sell cursor (`V/DragonTalkerSellHelp.as:47-145`) then `ItemSellView.__dragonTalkerAlertResponse` (`decompiled/core_module/scripts/bag/view/ItemSellView.as:272-295`).
- Request: `op`=20, `sellTaliInfos` (#15, repeated `SellTalismanInfo`: `Id` #1 talisman id, `count` #2).
- Response: 4844 (sold ones `isExist` false), gold push. Price = item `SellGold * count` *(assumption: same as the client estimate)*.

### A9. Grant talisman (op 1 GET_TALISMAN)
No client caller. Talismans are granted by drops and rewards; the server inserts rows and pushes 4844 with `isNew` true.

## 4. Server messages (server to client)

### S1. 4844 (0x12ec) `U_C_DRAGONTALKER_TALISMAN`, `TalismanInfoListMsg`
Receiver `DTM.__dragonTalkerTalismanMsgHandler` (`DTM:171-229`). Paged: when `pkgCount` (#2) >= 1 the client buffers pages until it received `pkgCount` packets, then applies all; send `pkgCount` = number of pages for the login dump (all talismans), 1 (or 0) for deltas. Ends with `DRAGON_TALKER_TALISMAN_UPDATE`.

`TalismanMsg` (`talismanInfoList` #1, repeated):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `id` | #1 | INT32 | talisman instance id |
| `templateId` | #2 | INT32 | item template |
| `pos` | #3 | INT32 | bag position |
| `equipslot` | #4 | INT32 | 0 = in bag, 401..406 = equipped slot |
| `isExist` | #5 | BOOL | false removes it (`DMOD.removeNoExistTalismanInfo`) |
| `grade` | #6 | INT32 | level 0..36 (Types 141) |
| `gp` | #7 | INT32 | total exp |
| `randomSkillList` | #8 | INT32 repeated | secondary attribute skill ids (0 = empty slot); last may be a special SonType 435 skill (`DTI:99-121`) |
| `newSkillId` | #9 | INT32 | pending absorbed attribute |
| `oldSkillIndex` | #10 | INT32 | slot to replace, -1 none |
| `isNew` | #11 | BOOL | new marker |
| `count` | #12 | INT32 | stack count (exp talismans) |

### S2. 4846 (0x12ee) `U_C_DRAGONTALKER_OP`, `DragonTalkerOpMsg`
Receiver `DTM.__dragonTalkerOpBackHandler` (`DTM:231-247`): `op` 6 -> `TALISMAN_SWALLOW_BACK {result, index=newSkillIndex}`; `op` 14/15 -> `TALISMAN_SWALLOW_SKILL_BACK result`. `result` 0 = success, non zero = failure (animation skipped, view refreshed).

`TalismanCount` (`talismanId` #1, `count` #2) exists in the package but no client code reads it.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Level curve | `UpGradeTempInfos` Types 141: level = highest `Grades` with `Data <= gp` (0..36; 4000 exp per level until 9, then 20000, 42000, 90000) | `DMOD:148-150`, `TempleteManager.getUpgradeGradeBy` |
| Quality cap | level stops at `Property3` of the template (grade 9 green, 18 blue, 27 purple, 36 orange); exp beyond the cap is lost *(assumption)* | `V/view/DragonTalkerIntensifyView.as:307` |
| Quality upgrade | gold = Types 141 `ActiveObject` at the cap grade (100000 / 1000000 / 5000000); template -> `Property2` | `:210-222` |
| Exp gain | material `Property1 * count` | `:168` |
| Stat per level | +2% of the base stat per level (`STRENGTH_PERCENT` 0.02) | `DMOD:31`, `:333-344` |
| Absorb | same `SonType` only; rolls one secondary from the material's list *(assumption: random among its non zero entries)* | help text item 5 |
| Secondary slots | grow with quality ("Ativ. qualidade verde/azul/laranja") | `DragonTalkerIntensifyView.randomText.typeText0..2` |
| Sets | `SuiteTempInfos.xml` ids 801..824: `Property2` = 2 piece skill, `Property4` = 4 piece skill; pieces must be same set and same quality (help text item 3) | `DTI:52-59` |
| Bag capacity | 91 talismans per SonType | `DMOD:29`, `:525-529` |
| Equipped talismans | cannot be consumed or absorbed | views |

## 6. Templates

| File | Use |
|---|---|
| `ItemTempInfos.xml` MasterType 8, SonType 401..407 (113 rows) | talisman templates |
| `UpGradeTempInfos.xml` Types 141 | exp curve and quality upgrade gold |
| `SuiteTempInfos.xml` 801..824 | set effects |
| `SkillTempInfos.xml` SonType 435 and secondary skills | special and secondary attributes |

## 7. Persistent state

```sql
CREATE TABLE dragon.talismans (
  talisman_id     BIGSERIAL PRIMARY KEY,
  player_id       BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id     INTEGER  NOT NULL,
  bag_pos         INTEGER  NOT NULL DEFAULT 0,
  equip_slot      SMALLINT NOT NULL DEFAULT 0 CHECK (equip_slot = 0 OR equip_slot BETWEEN 401 AND 406),
  grade           SMALLINT NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 36),
  gp              INTEGER  NOT NULL DEFAULT 0 CHECK (gp >= 0),
  stack_count     INTEGER  NOT NULL DEFAULT 1 CHECK (stack_count > 0),
  random_skill_ids INTEGER[] NOT NULL DEFAULT '{}',
  pending_skill_id INTEGER NOT NULL DEFAULT 0,
  pending_replace_index SMALLINT NOT NULL DEFAULT -1,
  is_new          BOOLEAN  NOT NULL DEFAULT TRUE,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX talismans_player ON dragon.talismans (player_id);
CREATE UNIQUE INDEX talismans_equipped ON dragon.talismans (player_id, equip_slot) WHERE equip_slot <> 0;
```

`talisman_id` must fit INT32 on the wire.

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 1 | `dragon::talisman::grant` (internal) |
| 3 | `dragon::talisman::handle_toggle_equip` |
| 4 | `dragon::talisman::handle_set_not_new` |
| 5 | `dragon::talisman::handle_strengthen` |
| 6 | `dragon::talisman::handle_absorb` |
| 14 | `dragon::talisman::handle_accept_absorbed` |
| 15 | `dragon::talisman::handle_discard_absorbed` |
| 16 | `dragon::talisman::handle_upgrade_quality` |
| 17 | `dragon::talisman::handle_batch_strengthen` |
| 20 | `dragon::talisman::handle_sell` |

- Common validation: feature open -> talisman ids belong to the player and exist -> materials not equipped -> no pending absorb choice on the target (ops 5, 6, 16, 17) *(assumption, matches the client alert)*.
- Strengthen and batch: sum exp, clamp at `Property3`, recompute grade, delete or decrement materials, one transaction, push 4844 delta.
- Absorb: same SonType, roll, store `pending_*`, delete material, push 4846 then 4844.
- Equip changes and grade changes alter Dragon Talker stats: push hero attributes / fight power (hero feature).
- Login: send all talismans in pages (`pkgCount` = pages).

## 9. Open questions and assumptions

- *(assumption)* Absorb roll and replacement index selection rules.
- *(assumption)* Exp overflow at the quality cap is lost.
- *(assumption)* Sell price equals `SellGold`.
- Source of talisman drops (campaigns, Time Vortex) belongs to the owning features.

## 10. Implementation checklist

- [ ] 4844 paged dump at login and deltas.
- [ ] Ops 3, 4, 5, 6, 14, 15, 16, 17, 20.
- [ ] 4846 responses for 6, 14, 15.
- [ ] Table `dragon.talismans` with one equipped per slot.
- [ ] Set bonus evaluation (2 and 4 pieces, same set and quality).
- [ ] Tests: exp talisman cannot be equipped; strengthen stops at quality cap; quality upgrade costs 100000 gold at grade 9; absorb rejects different SonType; batch consumes all listed materials; unequip rejected at 91 talismans of the type.
