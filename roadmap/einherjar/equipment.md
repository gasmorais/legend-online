# Pet equipment ("Equip Einheirjar"): equip, strengthen (mould), upgrade, refinery, sacred spirit inlay

Path aliases:

| Alias | File |
|---|---|
| SSO | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| PEM | `decompiled/core_module/scripts/managers/PetEquipManager.as` |
| EQB | `decompiled/m14/scripts/pet/advanced/equipbag/` |
| ES | `decompiled/m14/scripts/pet/equipstore/` |

## 1. Overview

Pets of display quality blue or better wear up to 6 equipment pieces (item `MasterType` 5). The pieces live in bag type 26 with `objectId` = pet id (`GM:910-920,1496-1540`). The "Equip" tab of the pet frame (`ES/EquipStoreView.as`) has four sub views that reuse the smith routes on the hidden work bag 0:

| Sub view | pt-BR | Route | Response |
|---|---|---|---|
| `ES/PetEquipStrengView.as` | Fortalecimento ("Fortalecimento bem sucedido, Nv.de Fortalecimento+1") | 8644 `C_MOULD_ITEM` | 4558 `U_C_MOULD_ITEM` |
| `ES/PetEquipUpgradeView.as` | Aumento / avanço ("Aumento bem sucedido, obtém {0}×1") | 5153 `U_C_ITEM_COMPOSE` | 89 `U_C_ITEM_COMPOSE` |
| `ES/PetEquipRefineryView.as` | Refinação ("Refinação bem sucedida") | 8336 `C_ITEM_REFRESHFORRANDOM`, 8339 `C_ITEM_REFRESHFORREPLACE`, 8464 `C_ITEM_REFRESHPROPERTY` | 4258 `U_C_REFRESHFORRANDOM`, 4368 `U_C_ITEM_REFRESHPROPERTY` |
| `ES/PetEquipGodHeadView.as` | Espírito Sagrado (inlay) | 5152 `U_C_ITEM_INLAYJOIN` (punch), 5151 `U_C_ITEM_INLAY` (inlay) | 115 bag updates |

Help texts `PetFrame.help07_1..4`: strengthening consumes "Luz de Magia" and "Magia Guia" (items "Luz Mágica" 3250101 and "Liderança Mágica" 3260101); refinery consumes "Água Dourada"; sacred spirit inlay is 100 percent and can be removed for gold; elite equipment can be upgraded with "Bênção Sagrada".

The smith feature owns the generic handlers of these opcodes ([../smith/README.md](../smith/README.md)); this module lists the pet specific inputs and rules.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `decompiled/m14/scripts/pet/advanced/PetEquipBagView.as`, `EQB/PetBagCell.as`, `EQB/PetEquipCell.as` | "Equip Einheirjar" | Bag of pet equipment and the 6 slots of the selected pet | advanced tab and property tab | bag 1 items `MasterType` 5, bag 26 for the pet |
| `ES/EquipStoreView.as` | equip store tab | Four sub tabs, moves work bag items back to bag 1 when switching (`:72,123`) | pet frame equip tab (`decompiled/m14/scripts/pet/PetFrame.as:525-536`) | |
| `ES/PetEquipStrengView.as` | | Work item, bless bar "Barra de Benção:", materials 3x3250101 + 3x3260101, auto buy, note "Obs.: Se fortalecer sem sucesso irá aumentar os pontos de bênção, se os pontos de bênção estiverem cheios, irá aumentar um nível automaticamente." | sub tab | `mouldGrade`, bless |
| `ES/PetEquipUpgradeView.as` | | Upgrade a fully strengthened piece to the next quality ("Aumento de espaço para Jóias", "Propriedades de Refinação aumentadas", "Limite de fortalecimento aumentado") | sub tab | `ComposeTempInfos.xml` row |
| `ES/PetEquipRefineryView.as`, `ES/refinery/PetEquipRefinerySkillItem.as` | | Re-roll up to 5 random properties with locks, then replace | sub tab | `randomSkill1..5` |
| `ES/PetEquipGodHeadView.as`, `ES/godhead/GodHeadItemView.as` | | 4 inlay holes (`join1..4`), punch, inlay sacred spirits (SonType 329, 343, 344), remove for gold | sub tab | `join1..4` |

## 3. Routes (client to server)

### R1. Equip / unequip / move
- Equip: double click or drag a piece onto the pet (`EQB/PetBagCellClickMediator.as:90-138`, `EQB/PetBagCellDropMediator.as`): target slot from `GoodsSonType.getSonTypePos(SonType)`: 113 -> slots 0,1; 114 -> 2; 115 -> 3,4; 116 -> 5 (`decompiled/core_module/scripts/bag/datas/GoodsSonType.as:432-439`). Unbound pieces show a bind confirm ("O equipamento dado ao Einherjar será Vinculado,  deseja continuar?", `EQB/PetBagCellDropMediator.as:117`). The string "Somente Einherjar Azuis ou superiores é que podem usar equipamento" exists but no view checks it in this client (enforce server side, assumption).
- Route: send 5005 (0x138d) `U_C_BAG_MOVE`, `ItemReqMsg`: `begin_bag_type` (#1) 1, `begin_obj_id` (#2) 0, `begin_pos` (#3), `end_bag_type` (#4) 26, `end_obj_id` (#5) 0, `end_pos` (#6) slot, `count` (#7) 1, `object_id` (#8) pet id.
- Unequip: `EQB/PetEquipBagCellClickMediator.as:34` sends 5005 from bag 26 to bag 1 with `object_id` = pet id.
- Work bag: pieces and materials go to bag 0 (`EQB/PetBagCellClickMediator.as:225-298`); upgrade refuses pieces not at full strengthen ("Somente com o equipamento fortificado é que é possivel avançar").
- Response: 115 `U_C_BAG_MOVE_UPDATE`; the pet's `bag_attack`..`bag_living` totals (#46..#50) arrive in 4540 ([pets.md](pets.md)).

### R2. Strengthen (mould)
- UI: strengthen button (`ES/PetEquipStrengView.as:456-466`), 500 ms throttle.
- Client: if bag 1 has >= 3 of 3250101 and >= 3 of 3260101 send directly; else confirm "Materiais insuficientes, deseja consumir {0} diamantes para fortalecer?" with shop `GiftToken` prices, then diamonds check (`:467-507`).
- Route: send 8644 (0x21c4) `C_MOULD_ITEM`, `PayTypeMsg` (package player): `pay_type` (#1, INT32) = 0 (default, or bound diamonds allowed) / 1 (diamonds only); `property1` (#2), `property2` (#3), `type` (#4) unused.
- Response: 4558 (0x11ce) `U_C_MOULD_ITEM` `StoreRspMsg`: `streng_result` (#3, BOOL) success -> "Fortalecimento bem sucedido, Nv.de Fortalecimento+1"; failure -> "O fortalecimento falhou, Barra de Benção de Fortalecimento +{0}" with 5 when `mouldGrade < 10` else 3 (`:422-445`). Plus 115 for the piece (`mouldGrade`) and materials.

### R3. Upgrade
- UI: upgrade button (`ES/PetEquipUpgradeView.as:540-600`).
- Route: send 5153 (0x1421) `U_C_ITEM_COMPOSE`, `StoreReqMsg`: `compose_id` (#6) = `ComposeTempInfos` row id, `compose_num` (#7) = 1, `pay_type` (#12) 0/1, `operate` (#2) false (`SSO:116-129`).
- Response: 89 (0x0059) `U_C_ITEM_COMPOSE` `StoreRspMsg`: `compose_result` (#1, BOOL), `compose_templateId` (#2) new template -> "Aumento bem sucedido, obtém {0}×1"; the client then moves work bag items back (`:391-411`).

### R4. Refinery
- UI: refine `_washBtn` (`ES/PetEquipRefineryView.as:555-624`): needs a piece ("Favor equipar"); not all properties locked ("As propriedades foram todas bloqueadas, não pode treinar"); cost = locked count * `Lock_Point` (10 diamonds) + missing "Água Dourada" 3270101 (needed by piece `Profile`: 2 -> 1, 3 -> 4, 4..5 -> 18, 6 -> 24, `:785-800`) at shop price.
- Route: send 8336 (0x2090) `C_ITEM_REFRESHFORRANDOM`, `SmithFreshReqMsg`: `lock` (#1, BOOL, repeated 5), `bind_type` (#2) 0, `pay_type` (#3) unset, `material_pay_type` (#4) 0/1 (`SSO:145-157`).
- Response: 4258 (0x10a2) `U_C_REFRESHFORRANDOM` `SmithFreshRspMsg`: `randomSkill` (#1, INT32, repeated) candidate values (`:409-422`); replace button enabled.
- Replace: send 8339 (0x2093) `C_ITEM_REFRESHFORREPLACE`, empty body (`:550-553`); response 115 with the new `randomSkill1..5`.
- Pending candidates on load: send 8464 (0x2110) `C_ITEM_REFRESHPROPERTY`, `RefreshPropertyReqMsg.item_id` (#1) when a piece enters the work bag (`:733-745`); response 4368 (0x1110) `U_C_ITEM_REFRESHPROPERTY` `RefreshPropertyRepMsg`: `randomSkill` (#1, repeated), `lockPos` (#2, BOOL, repeated), `result` (#3, 1 = has pending) (`:428-460`).

### R5. Sacred spirit holes and inlay
- Punch a hole: `GodHeadItemView` confirm "Para ativar a célula necessita de um Diamante Dourado de Espirito, deseja ativar?" -> `SSM.sendPunch(pos, operate)` (`ES/godhead/GodHeadItemView.as:131,167`, `SSM:318-343`): send 5152 (0x1420) `U_C_ITEM_INLAYJOIN`, `StoreReqMsg`: `hole_pos` (#1), `operate` (#2, BOOL), `pay_type` (#12).
- Inlay a spirit: `StoreControler.sendItemMount(holePos, bagPos, bagType)` (`EQB/PetBagCellClickMediator.as:225-262`, `SSO:50-58`): send 5151 (0x141f) `U_C_ITEM_INLAY`, `StoreReqMsg`: `mount_pos` (#5) hole 1..4, `bag_pos` (#4), `bag_type` (#3). Client refuses two spirits of the same category ("Não pode introduzir vários Espiritos Sagrados do mesmo tipo"). Removing or replacing costs the spirit template `Property3` in gold ("Deseja consumir {0} de Ouro para remover o Espirito Sagrado?", `ES/godhead/GodHeadItemView.as:112`).
- Response: 115 with `join1..4`.

## 4. Server messages (server to client)

| Opcode | Message | Fields | Receiver | When |
|---|---|---|---|---|
| 4558 (0x11ce) `U_C_MOULD_ITEM` | `StoreRspMsg` | `streng_result` (#3) | `ES/PetEquipStrengView.as:422-445` | After R2 |
| 89 (0x0059) `U_C_ITEM_COMPOSE` | `StoreRspMsg` | `compose_result` (#1), `compose_templateId` (#2) | `ES/PetEquipUpgradeView.as:391-411` | After R3 |
| 4258 (0x10a2) `U_C_REFRESHFORRANDOM` | `SmithFreshRspMsg` | `randomSkill` (#1, repeated) | `ES/PetEquipRefineryView.as:409-422` | After 8336 |
| 4368 (0x1110) `U_C_ITEM_REFRESHPROPERTY` | `RefreshPropertyRepMsg` | `randomSkill` (#1), `lockPos` (#2), `result` (#3) | `ES/PetEquipRefineryView.as:428-460` | After 8464 |
| 115 (0x0073) `U_C_BAG_MOVE_UPDATE` | inventory | item rows with `mouldGrade`, `join1..4`, `randomSkill1..5`, bag 26 slots | GoodsManager | After every route |
| 4540 (0x11bc) `U_C_PLAYER_PETINFO` | `PlayerPetMsg` | `bag_attack` .. `bag_living` | PlayerManager | When pet stats change |

## 5. Rules and formulas

- Pet equipment `MasterType` 5, SonTypes 113 (2 slots), 114 (1), 115 (2), 116 (1); examples 1130301 "Proteção da Rainha", 1140301 "Luz de Apolo", 1150301 "Lágrimas de Eve", 1160301 "Escuridão de Hades" (`Profile` 3, `StrengthenMax` 10).
- Constants (`decompiled/core_module/scripts/mvc/module/pet/PetData.as:39-47`): refinery quality range 3..6, upgrade quality range 3..5, strengthen material cost 3 of each.
- Strengthen failure bless: +5 below `mouldGrade` 10, +3 from 10 (client messages); full bless gives a level.
- Refinery lock price `Lock_Point` = 10 diamonds per locked line; water by `Profile` as listed.
- Equipping binds the piece and the pet.
- Equipped pets cannot be sacrificed, absorbed, refined or fused ([pets.md](pets.md), [growth.md](growth.md)).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | `MasterType` 5 pieces, 3250101, 3260101, 3270101, spirits SonType 329/343/344 |
| `raw/xml/tempinfos/ComposeTempInfos.xml` | upgrade recipes (`Id` sent as `compose_id`) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Lock_Point` |

## 7. Persistent state

Inventory owned: items in bag 26 with `owner_object_id` = pet id and columns `mould_grade`, `mould_bless`, `join_1..4`, `random_skill_1..5`, pending refinery candidates. Proposed pet specific helper if the inventory table lacks them:

```sql
CREATE TABLE einherjar.pet_equipment_refinery (
  item_id        BIGINT     PRIMARY KEY REFERENCES inventory.items(item_id) ON DELETE CASCADE,
  pending_skills INTEGER[]  NOT NULL,
  locks          BOOLEAN[]  NOT NULL,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- 5005 to/from bag 26: `inventory::bag::handle_move` calls `einherjar::equipment::validate_equip` (pet ownership, quality >= blue, slot from SonType, bind piece and pet) and pushes 4540 with new equipment totals.
- 8644: `einherjar::equipment::handle_mould` when the work item is a pet piece (smith dispatcher by `MasterType`), consume 3+3 materials or diamonds, roll success, bless.
- 5153, 8336/8339/8464, 5151/5152: smith handlers with pet piece templates.
- Recompute pet `bag_*` totals and `fight_capacity` after each change.

## 9. Open questions and assumptions

- Strengthen success rates per level (server only).
- Display quality threshold for "Azuis" (assumed display quality >= 3).

## 10. Implementation checklist

- [ ] Screen: equipment bag and pet slots
- [ ] Screen: equip store four sub tabs
- [ ] Route 5005 bag 26 equip/unequip
- [ ] Route 8644 -> 4558
- [ ] Route 5153 -> 89
- [ ] Route 8336 -> 4258, 8339, 8464 -> 4368
- [ ] Route 5152, 5151
- [ ] Rule: slot positions by SonType
- [ ] Rule: refinery costs, strengthen bless
- [ ] Table support in inventory, `einherjar.pet_equipment_refinery` (optional)
- [ ] Tests: equip on low quality pet rejected, equipped pet blocks sacrifice
