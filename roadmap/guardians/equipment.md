# Guardian equipment: bag, equip, strengthen, upgrade, sockets, refresh, sell

Module `equipment`. Guardian equipment items (`MasterType` 6) live in dedicated bags: bag type 28 = guardian equipment bag, 29 = the work slot ("hide" cell used by upgrade/refresh/socket views), 30 = equipped on a guardian (`objectId` = child id, positions 0..7). All actions use send 8869 (0x22a5) `C_CHILDREN_EQUI_OP` with `CommonItemMsg` (package `item`, owned by [inventory](../inventory/README.md)). Changes come back as ordinary bag updates; the dedicated push 4748 is ignored by the client.

Path aliases:

| Alias | File |
|---|---|
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| CM | `decompiled/core_module/scripts/managers/ChildManager.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/children/ChildModel.as` |
| E | `decompiled/m14/scripts/child/equip/` |

## 1. Overview

`CommonItemMsg` fields used (tags from `protocol/proto.json`): `begin_bag_type` (#1), `begin_pos` (#3), `end_bag_type` (#4), `end_pos` (#6), `count` (#7), `object_id` (#8, child id), `compose_id` (#9), `op_type` (#12), `hole_pos` (#13), `operate` (#14, BOOL), `payType` (#15), `lock` (#16, BOOL repeated), `bind_type` (#17), `sellItem` (#19, repeated `SellItemMsg`: `pos` #1, `count` #2, `id` #3), `material_pay_type` (#20).

| op_type | Constant (`CS:120-134`) | Sender |
|---|---|---|
| 1 | STRENGHT | `CS.intensifyAndUpgradeEquip(1, materialId, payType)` |
| 2 | UPGRADE | `CS.intensifyAndUpgradeEquip(2, composeId, payType)` |
| 3 | OPENING | `CS.openHole(holePos, operate, bindFirst)` |
| 4 | MOSAIC | `CS.insertJewel(endPos, beginPos, beginBagType)` |
| 5 | REFRESH | `CS.refreshEquip(lock, bindType, payType, materialPayType)` |
| 6 | CONFIRM_REFRESH | `CS.confirmRefreshEquip()` |
| 7 | MOVE | `CS.moveBagToBag(beginBag, beginPos, endBag, endPos, objectId, count)` |
| 8 | SELL | `CS.sellEquip(pos, id, count)` |

`payType` convention here: 0 = bound diamonds first, 1 = diamonds (`CS:432-447`, views use `param2 ? 0 : 1`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `E/ChildEquipTabView.as` | | equipment tab with sub views upgrade, refresh, socket (`CM` constants `CHILDEQUIPUPGRADEVIEW`, `CHILDEQUIPREFRESHVIEW`, `CHILDEQUIPINSERTVIEW`) | `ChildFrame` tab 2 (blocked during growth: "Durante o período de crescimento não pode verificar equipamentos.") | |
| `E/ChildEquipBagView.as`, `E/ChildBagCell.as`, `E/ChildBagCellClickMediator.as`, `E/ChildBagCellDropMediator.as`, `E/ChildGoodsItemMenu.as` | | guardian bag and equipped slots, click/drag/sell menu | tab | bag 28 items, bag 30 items of the selected guardian |
| `E/ChildUpgradeEquipView.as`, `E/ChildIntensifyEquipView.as` | "Itens insuficientes, deseja consumir {0} diamantes para fortalecer?", "...para elevar?" | strengthen and quality upgrade of the item in bag 29 | tab | materials owned, diamond fallback |
| `E/ChildInsertEquipView.as`, `E/ChildInsetItemView.as` | "Deseja consumir {0} diamantes para perfurar?" | open sockets, insert or remove gems ("ágata", SonType 224) | tab | 4 sockets `join1..4` |
| `E/ChildRefreshEquipView.as`, `E/ChildRefreshAttItem.as`, `E/ChildEquipAttItem.as` | "Material de purificação insuficiente...", "Itens insuficientes, deseja consumir {0} diamantes para purificar?" | refresh random attributes with locks, confirm | tab | `randomSkill1..5`, lock checkboxes |

## 3. Routes (client to server)

Common client check: when the guardian is fielded by the spouse, attribute and equipped item actions are refused ("O seu companheiro configurou o guardião, não pode fazer esta operação.", `E/ChildBagCellClickMediator.as:106-117`).

### A1. Move items (op 7 MOVE)
- Equip: click an item in bag 28 while on the attribute page -> `end_bag_type` 30, `end_pos` = slot from `getEquipPos`, `object_id` = child id; job check "bag.helper.GoodsCheck.command01" when `templateInfo.Job` does not contain the guardian job (`E/ChildBagCellClickMediator.as:162-176`); growth check "Crescimento do guarda insuficiente {0}，não pode equipar" (strings).
- Unequip / take back: from bag 30 or 29 to 28 at the first empty position (`GoodsManager.findChildEmputyPos`), full bag -> "cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01" (`:119-140`).
- Put in the work slot: to bag 29 pos 0 (`:142-161`); at max quality and strengthen in the upgrade view -> "PetAdvancedView.MaxQuality".
- Drag and drop variants: `E/ChildBagCellDropMediator.as:100-160`; spirit frame drop `decompiled/m14/scripts/child/ChildNursingSpiritFrame.as:397`, `decompiled/m14/scripts/child/ChildFrame.as:245-252`.
- Request: `op_type`=7, `begin_bag_type`, `begin_pos`, `end_bag_type`, `end_pos`, `object_id` (child id when bag 30 is involved), `count` (1).
- Response: 115 `U_C_BAG_MOVE_UPDATE` for both slots; 4747 with new `join_info`/`fight_capacity` when equipped items change.

### A2. Strengthen (op 1 STRENGHT)
- UI: `E/ChildUpgradeEquipView.as:513-548`; 500 ms throttle; item must be in bag 29; `strengthenGrade < StrengthenMax` else "fighting.FightingItem.desction1_4".
- Cost: config `MaterialAndCount` = "2271001,5,1|2271002,10,2|2271003,15,3|2271004,20,4|2271005,25,5" indexed by item `Profile` (quality 1..5): material id and count (the third value is unused by the client); missing materials priced at the shop price as diamonds ("Itens insuficientes, deseja consumir {0} diamantes para fortalecer?") (`:280-290`).
- Request: `op_type`=1, `compose_id` = material template id, `payType`.
- Response: 115 with the item `strengthenGrade` raised (success always *(assumption)*), currency push.

### A3. Quality upgrade (op 2 UPGRADE)
- UI: `E/ChildUpgradeEquipView.as:430-485`. Recipe: `ComposeTempInfos.xml` `Types` 11 where `Material1` = item template (`CMOD:208-240`): `Material2` x `Count2` (e.g. 2129822 x20) -> `NewMaterial`; `NeedMinLevel` 70. Missing materials priced in diamonds; growth check "Pontos de crescimento do Guardião insuficiente, não pode elevar." (strings).
- Request: `op_type`=2, `compose_id` = recipe `Id`, `payType`. After sending the client moves the item back (`CMOD.moveGoodsBack`).
- Response: 115 with the new template in bag 29 or 28.

### A4. Sockets (op 3 OPENING, op 4 MOSAIC)
- Open a socket: `E/ChildInsetItemView.as:166-197`, cost config `equi_item_need` (default 10 diamonds), confirm "Deseja consumir {0} diamantes para perfurar?". Request `op_type`=3, `hole_pos`, `operate`=true, `payType`.
- Remove a gem: same op with `operate`=false; gold cost = gem `Property3` ("bag.helper.BagHelper.content03"); gold check "public.gold" (`:126-160`).
- Insert a gem (SonType 224): `E/ChildBagCellClickMediator.as:178-233` and drop mediator `:185`, `:210`: an item must be in bag 29; all 4 sockets filled -> "pet.advanced.equipbag.PetBagCellClickMediator.bagIsFull"; same gem type (`Property1`) already inserted -> "pet.equipstore.PetEquipGodHeadView.JoinGem2". Request `op_type`=4, `end_pos` = socket 1..4, `begin_pos` = gem position, `begin_bag_type` = gem bag.
- Response: 115 with `join1..4`.

### A5. Refresh attributes (op 5 REFRESH, op 6 CONFIRM_REFRESH)
- UI: `E/ChildRefreshEquipView.as:440-556`. Material = item `Refresh` template (e.g. 2272001) x `getNeedCountProfile(Profile)`: quality 1..2 -> 1, 3 -> 4, 4..5 -> 18 (`:558-575`); each locked attribute costs `Lock_Point` (10) diamonds; missing materials priced at shop price.
- Request 1: `op_type`=5, `lock` (#16, one BOOL per attribute), `bind_type` 0, `payType`, `material_pay_type`.
- Response: 115 or a preview of the new random attributes *(assumption: the new values are stored pending and shown through the item data until confirmed)*.
- Request 2: `op_type`=6 to keep the new attributes (`:553-556`).

### A6. Sell (op 8 SELL)
- UI: `E/ChildGoodsItemMenu.as:120-146`; items with gems cannot be sold ("Este equipamento tem gemas inseridas, não pode vender.").
- Request: `op_type`=8, `sellItem` = [{`pos`, `id`, `count`}].
- Response: 115 removal, gold push.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | Use |
|---|---|---|---|
| 115 (0x0073) `U_C_BAG_MOVE_UPDATE` | `ItemMovedListMsg` | `GoodsManager.__bagUpdateHandler` (inventory feature) | all equipment state (bag types 28, 29, 30) |
| 4748 (0x128c) `U_C_CHILDREN_EQUI` | `ChildEquipmentMsg` *(assumption from the package)* | `CM.__childrenEquipHandler` is empty (`CM:342-344`) | may be skipped |
| 4747 (0x128b) `U_C_CHILDREN` | `PlayerChildMsg` | `roster.md` S1 | stats after equip changes |

`ChildEquipmentMsg` (used inside `ChildrenInfoMsg.equipmets` for look up, `roster.md` S4): `templateId` #1, `pos` #2, `join1..4` #3..#6, `randomSkill1..5` #7..#11, `mouldGrade` #12, `isBind` #13, `strengthenGrade` #14.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Item type | `MasterType` 6 (guardian equipment), `SonType` 6xx slot, `Job` allowed jobs, `Profile` quality, `StrengthenMax`, `RandomSkillCount`, `Refresh` material, `Property7` | `ItemTempInfos.xml` |
| Equipped slots | 8 positions (0..7) in bag 30 per guardian | `decompiled/m14/scripts/child/handin/ChildHandInFrame.as:265-282` |
| Strengthen material | by quality: 2271001 x5, 2271002 x10, 2271003 x15, 2271004 x20, 2271005 x25 | `MaterialAndCount` |
| Upgrade recipes | `ComposeTempInfos` Types 11 (480 rows) | `CMOD:208-240` |
| Socket | 4 sockets; open costs `equi_item_need` diamonds; gem removal costs gem `Property3` gold; one gem per `Property1` type | views |
| Refresh | material count by quality 1/1/4/18/18; `Lock_Point` 10 diamonds per lock | `E/ChildRefreshEquipView.as` |

## 6. Templates

| File | Use |
|---|---|
| `ItemTempInfos.xml` MasterType 6, SonType 224 gems, 2271001..2271005, 2272xxx refresh materials | |
| `ComposeTempInfos.xml` Types 11 | upgrade recipes |
| `ConfigInfos.xml` | `MaterialAndCount`, `Lock_Point`, `equi_item_need` |

## 7. Persistent state

Equipment rows are inventory items (`inventory.items`, see [inventory](../inventory/README.md)) with bag types 28/29/30 and `object_id` = guardian id. Pending refresh results:

```sql
CREATE TABLE guardians.equipment_refresh_pending (
  item_id        BIGINT   PRIMARY KEY,
  player_id      BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  new_random_skills INTEGER[] NOT NULL,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

| op_type | Handler |
|---|---|
| 1 | `guardians::equipment::handle_strengthen` |
| 2 | `guardians::equipment::handle_upgrade` |
| 3 | `guardians::equipment::handle_socket` |
| 4 | `guardians::equipment::handle_insert_gem` |
| 5 | `guardians::equipment::handle_refresh` |
| 6 | `guardians::equipment::handle_confirm_refresh` |
| 7 | `guardians::equipment::handle_move` |
| 8 | `guardians::equipment::handle_sell` |

- Reuse the inventory service for moves, consumption and 115 pushes; validate bag types 28/29/30 and that bag 30 moves name a guardian of the household not fielded by the spouse.
- Strengthen/upgrade/refresh operate on the item in bag 29 pos 0.
- After equip changes recompute guardian stats (`attributes.md`) and push 4747.

## 9. Open questions and assumptions

- *(assumption)* Strengthen and upgrade always succeed.
- *(assumption)* Refresh result storage and how the preview reaches the client (probably through the item update with a pending flag).
- The third value of each `MaterialAndCount` entry (1..5) is unused by the client.

## 10. Implementation checklist

- [ ] 8869 dispatcher, ops 1..8.
- [ ] Bag types 28, 29, 30 in the inventory service.
- [ ] Table `guardians.equipment_refresh_pending`.
- [ ] Stat recompute on equip change.
- [ ] Tests: equipping an item of another job rejected; strengthen at `StrengthenMax` rejected; inserting a second gem of the same type rejected; refresh with 2 locks charges 20 diamonds; selling a socketed item rejected.
