# Equipment slots (wear and unwear)

Module of [README.md](README.md). Moving items between the bag and the hero slots: hero equipment and fashion (bag 4), the medal slot (bag 3) and the three battle rune slots (bag 2). All wear and unwear actions use the generic move 5005; this module defines the slot layout and the validation the server must add. Hero stats, power and avatar are owned by [../hero/README.md](../hero/README.md) and [../army/README.md](../army/README.md); enhancement, forging and gems by [../smith/README.md](../smith/README.md); fashion panels by [../fashion/README.md](../fashion/README.md); Einherjar equipment (bag 26) by [../einherjar/README.md](../einherjar/README.md); Guardian equipment (bag 30) by [../guardians/README.md](../guardians/README.md).

Path aliases:

| Alias | File |
|---|---|
| PBC | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as` |
| PBD | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellDropMediator.as` |
| PEBC | `decompiled/core_module/scripts/cell/mediator/playerequip/PlayerEquipBagCellClickMediator.as` |
| PEBD | `decompiled/core_module/scripts/cell/mediator/playerequip/PlayerEquipBagCellDropMediator.as` |
| GST | `decompiled/core_module/scripts/bag/datas/GoodsSonType.as` |
| GC | `decompiled/core_module/scripts/bag/helper/GoodsCheck.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| SSMG | `decompiled/core_module/scripts/map/space/manager/SpaceSocketManager.as` |

## 1. Overview

- Hero slots are item rows with `bag_type` 4 (equipment and fashion), 3 (medal) or 2 (battle runes) and `object_id` = hero id (`thane.id`); see the battle rune note in 9.
- Wear: the client chooses the slot from the item SonType (`GST.getSonTypePos`, `GST:404-447`) and sends 5005 from the bag slot to the hero slot; if the slot is occupied the server swaps (the old item goes to the source bag slot).
- Unwear: 5005 from the hero slot to the first free slot of bag 1 (or bag 34 when the treasure tab is shown).
- Every change of bag 4 makes the client recompute power (`REFRESH_FIGHT`, `GM:186-189`, `GM:233-236`); the server must push the new hero attributes and broadcast the new look (149) to other players in the same space or room.

## 2. Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `armyII.ArmyFrameII` equipment panel (`ArmyPanelEnum.EQUIP_PANEL`) with `PlayerEquipCell` per slot, `HonorCell` (medal), `RunesCell` (runes) | "Equipamentos" | hero slots next to the bag | `GM.getHeroEquipListById`, `GM.getHeroHonerEquip`, `GM.getBattleRunes` (`GM:896-1074`) |
| Fashion panel (`FASHION_PANEL`) | | fashion slots 8..11 ([../fashion/README.md](../fashion/README.md)) | |
| Tooltips | `EquipContrastTips` | compare with the equipped item | [item-catalog.md](item-catalog.md) section 2 |

Slot layout of bag 4 (`GST:404-447`):

| Pos | SonType | pt-BR |
|---:|---|---|
| 0 | 101 | Armamento |
| 1 | 103 | Capacete |
| 2 | 104 | Vestimento |
| 3 | 106 | Colar |
| 4, 5 | 107 | Anel |
| 6, 7 | 108 | Ornamento |
| 8 | 109 | Asas (fashion) |
| 9 | 110 | Chapéu de Moda |
| 10 | 112 | Roupa de Moda |
| 11 | 111 | Armamento de Moda |
| 12 | 117 | Brasão |
| 13 | 118 | Monstros (relic) |

Other hero slots: bag 3 pos 0 for MasterType 3 medals (`GM:1076-1091`); bag 2 pos 0..2 for SonType 214 runes, slots unlocked at hero level 20, 30, 40 (`GM:1025-1061`). SonType 102 (assistant) and 105 (manteau) have no slot.

## 3. Routes (client to server)

### E1. Wear by double click

- `PBC.__mouseDoubleClick` (`PBC:601-711`) for items that are not usable:
  - checks: `GC.checkGoodsByHero` (job, sex, vocation, `GC:55-74`), `GC.checkGoodsCanEquip` (MasterType 1, MasterType 3 or SonType 214, `GC:76-99`), `GC.isGradeFix` with messages (`GC:203-222`);
  - SonType 214: if a rune of the same template is in bag 2 and not full, move `min(count, MaxCount - existing)` onto it; else the first free unlocked rune slot (`PBC:614-635`);
  - MasterType 3: bag 3 pos 0 (`PBC:636-648`);
  - otherwise bag 4: for multi slot SonTypes the first slot whose current item is not of the same SonType in order, or the first slot when all are taken (`PBC:649-678`); fashion opens the fashion panel instead (`PBC:682-688`); SonType 117/118 need `NeedChangeJob == 2` -> Avenger ("Precisa se tornar uma Divindade para usar este equipamento") or else a class change ("O equipamento terá de ser elevado para poder equipar.") (`PBC:691-708`).
- Route: 5005 `U_C_BAG_MOVE` (`SSM:139-155`), `item.ItemReqMsg`: `begin_bag_type` 1, `begin_obj_id` 0, `begin_pos` bag slot, `end_bag_type` 4 / 3 / 2, `end_obj_id` hero id, `end_pos` slot, `count` 1 (runes: the stack or the part that fits).

### E2. Wear by drag

- Onto a `PlayerEquipCell` (`PBD:277-320`): fashion items are ignored here; a different SonType redirects to E1 slot choice unless it mixes fashion and non fashion ("Tipo de acessório incorrespondente"); same checks as E1; 5005 to that cell.
- Onto a `RunesCell` (`PBD:255-276`): SonType 214 only, unlocked cell.
- Onto any `IDragTarget` (for example the hero picture): E1 slot choice (`PBD:335-412`).

### E3. Unwear

- Double click on a hero cell (`PEBC:24-46`): Dragon Tamer secondary gear (`isViceEquip`) in pos < 8 of bag 4 refused ("Este equipamento é inconsistente com a profissão ativada, não pode efetuar esta operação."); target first free slot of bag 1 ("Mochila cheia" when none); 5005 with `count 1`.
- Drag (`PEBD:114-239`): onto another hero cell of the same SonType (swap rings or ornaments); onto a bag cell: swap when the bag item is equipable in that slot, else move to the first free slot; onto the bag area: first free slot (bag 34 when the treasure tab is active, `PEBD:175-195`).
- Shift click: chat link ([bag.md](bag.md) B8).

### E4. Not used by this client

- 5008 `U_C_HERO_UPDATE_EQUIPMENT` (send and accept 59): declared, no sender or listener.
- `item.EquipLookMsg` (`otherId` #1) / `item.EquipLookDataMsg` (`otherId` #1, `item` #2 repeated `ItemInfoMsg`): no user. Viewing another player's equipment uses 8199 `C_BAG_EQUIPLOOK` with `simple.DetailReqMsg` (`userId` #1, `serverName` #2, `otherId` #3, `otherName` #4, `itemInfo` #5, `armyInfo` #6, `heroInfo` #7, `pawnInfo` #8) and 4125 `DetailRspMsg`, owned by [../hero/README.md](../hero/README.md) (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1663-1674`).

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When |
|---|---|---|---|
| 115 (0x0073) `U_C_BAG_MOVE_UPDATE` | both slots | `GM.__bagUpdateHandler`; bag 4 changes emit `UPDATE_EQUIP` / `DELETE_EQUIP` and `REFRESH_FIGHT` | every wear / unwear |
| 149 (0x0095) `U_C_HERO_BROAD_EQUIPMENT` | `army.HeroEquUpdatedMsg`: `playerId` (#1, INT32), `armStr` (#2, STRING) weapon avatar, `clothStr` (#3, STRING) armor avatar, `wing` (#4, STRING), `hat` (#5, STRING) fashion hat, `fashionArm` (#6, STRING), `fashionCloth` (#7, STRING), `hide` (#8, BOOL) fashion hidden, `appellId` (#9, INT32) title, `transGrade` (#10, INT32) vocation grade, `changeBranch` (#11, INT32) vocation index | `SpaceSocketManager.__otherHeroInfoChange` (`SSMG:186-208`), `RoomManager.__otherHeroInfoChange` (`decompiled/core_module/scripts/managers/RoomManager.as:116`) | to other players in the same space map or room after a look change |
| hero attribute pushes | owned by [../army/README.md](../army/README.md) / [../hero/README.md](../hero/README.md) | | after bag 4 / 3 / 2 changes |

## 5. Rules and formulas

- Requirements (server must re-check): MasterType 1 (or 3 for bag 3, SonType 214 for bag 2); `Job` contains 0 or the hero job (fashion exempt); `Sexs == 2` or equal to the hero sex; level >= `NeedGrades`; SonType 117/118: vocation done, and `NeedChangeJob == 2` requires Avenger; target slot listed for the SonType; Einherjar equipment (MasterType 5) never in bag 4.
- Multi slot types: rings 4/5, ornaments 6/7; the client may target an occupied slot (replace) only when both are taken.
- Battle runes: slots by level (20 -> 1, 30 -> 2, 40 -> 3); same template stacks up to `MaxCount`.
- Medal: one slot.
- Unwear needs a free bag slot.
- Locked items can be worn and unworn (assumption).
- Bind: equipping does not bind in the client texts; assumption: no bind on equip.

## 6. Templates

`ItemTempInfos.xml`: `MasterType`, `SonType`, `Job`, `Sexs`, `NeedGrades`, `NeedChangeJob`, `Avata` (look strings for 149).

## 7. Persistent state

No extra table: equipped items are `inventory.items` rows with `bag_type IN (2, 3, 4)` and `object_id` = hero id (0 for bag 2, see 9). Unique slot constraint of `inventory.items` prevents double occupation.

## 8. Backend implementation notes

- `hero::equipment::validate_equip(player, hero, item, bag, pos)` hook called by `inventory::bag::handle_move` when the destination is bag 2, 3 or 4; `validate_unequip` when the source is one of them (target free slot, vice gear rule for pos < 8).
- After commit: push 115; recompute hero stats (`army::hero::recompute`) and push them; if the look changed (slots 0, 2, 8..11 or title), broadcast 149 to players in the same space / room.
- Swap rules: wearing onto an occupied slot moves the old item to the source bag slot in the same transaction.

## 9. Open questions and assumptions

- Battle rune rows: the client reads `pos_0_2` but sends `end_obj_id = hero id`; assumption: store `object_id = 0` for bag 2.
- Whether the original server sends a hero update message besides 115 after equipment changes (assumption: yes, army feature).
- 5008 / 59 purpose (probably legacy).

## 10. Implementation checklist

- [ ] Slot table of bag 4 (0..13), bag 3 (0), bag 2 (0..2 by level)
- [ ] `validate_equip` / `validate_unequip` hooks in 5005
- [ ] Swap on occupied slot
- [ ] Hero recompute push and 149 broadcast
- [ ] Tests: wrong job, wrong sex, low level, 117/118 without vocation, ring double slot, unequip with full bag
