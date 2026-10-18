# Star sublimation ("Elevação de Cosmos")

Module `star-sublime` of feature `cosmos`. A job advanced hero can place a red (Profile 7) level 10 star in the sublimation slot (bag type 3, position 0), activate it into its "Sagrado" (Profile 8) version, and then level the Sagrado star 1..10 by feeding "Pó da Ilusão" (currency `newMagicDust`, masterType 27).

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/yishi/manager/StarManager.as` |
| SH | `decompiled/core_module/scripts/yishi/utils/StarHelper.as` |
| SBC | `decompiled/core_module/scripts/cell/view/starbag/StarBagCell.as` |
| V | `decompiled/m5/scripts/star/` |
| PCM | `decompiled/core_module/scripts/managers/PlayerCurrencyManager.as` |

## 1. Overview

| Step | Input | Output |
|---|---|---|
| Place | star of bag 1 or 2 with Profile 7 grade 10 (not template 107) or Profile >= 8 | star moves to bag 3 pos 0, `object_id` = origin bag type |
| Activate | Profile 7 grade 10 star in the slot | template replaced by `ComposeTempInfos` (Types 14) `NewMaterial`, e.g. 207 "Divino · Áries" -> 208 "Sagrado · Áries" (Attack 288 -> 2880 per grade); grade 1 assumed |
| Feed | Profile 8 star in the slot + N dust | `gp += N` (assumption), levels by `UpGradeTempInfos` type 60 up to 10 |
| Return | closing the frame or dragging back | star goes back to its origin bag |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/SubStarFrame.as` | "Elevação de Cosmos" (`:138`) | sublimation slot, candidate list, activate button, dust input and feed button | horoscope button visible when `thane.vocationGrades > 0` (`V/HoroscopeFrame.as:121,289-293`), item exchange link (`decompiled/m5/scripts/armyII/viewII/information/GoodsExchangeItem.as:476-481`); controller `star` openType 5 | candidates `SM.canShowSubList` (`SM:476-490`, `:111-134`); "Efeito Atual: {0}", "Efeito do próx. nível: {0}" (`:527-535`); "Pó da Ilusão atual: {0}" (`:536,551`); item icon 208061 "Pó da Ilusão" (`:82,202-204`); progress `gp / Data(type 60, grade + 1)` (`:495-516`) |

## 3. Routes (client to server)

### U1. Place a star in the sublimation slot
- UI: drag a candidate onto the center cell, or double click a candidate (`SBC:468-498,687-695`, `SM.moveToSub` `SM:692-717`).
- Client checks: template 107 -> "Este cosmo não contém cosmos avançados correspondentes"; Profile 7 with grade < 10, or Profile < 7 -> "Apenas poderá ativar cosmos vermelhos de Nv. máximo".
- Route: C>S 8267 (0x204b) `C_STAR_MOVE`, `StarMoveReqMsg`: `begin_star_type (#1)` 1 or 2; `begin_pos (#2)`; `end_star_type (#3)` 3; `end_pos (#4)` 0; `count (#5)` 1; `eat (#6)` false.
- Server: if bag 3 already holds a star, return it to its origin first (assumption); move the star, set `origin_bag_type`/`origin_pos`. Response: 4178 (delete origin cell, set bag 3 cell with `object_id` = origin bag type). Hero stats change when the origin was bag 2.

### U2. Take the star back
- UI: drag the center cell onto the list or double click it (`SBC:499-515,696-708`); automatically on frame close (`V/SubStarFrame.as:592-597` -> `SM.hideToBag` `SM:574-588`).
- Client logic: `oldBagType == 1` -> `SM.moveToBag` (first empty bag position, "Mochila de cosmos cheia, não é possível mover" when full); `oldBagType == 2` -> `starMove(0, 3, 0, 2)` (always end position 0 of bag 2).
- Route: 8267 begin (3, 0), end (1, free pos) or (2, 0).
- Server: for an end in bag 2 restore the star to `origin_pos` (assumption, the client always sends 0); re-validate equip rules (same family check). Response: 4178.

### U3. Activate (Profile 7 -> Profile 8)
- UI: activate button `_actBtn`, enabled when the slot star is Profile 7 grade 10 (`V/SubStarFrame.as:394-401`); disabled after click until a refresh.
- Sender: `SM.sendStarSublime(0)` (`SM:523-530`).
- Route: C>S 5182 (0x143e) `C_STAR_SUB_OP`, `StarGrowOpMsg`: `starType (#1, INT32)` not set; `starPos (#2, INT32)` not set; `itemCount (#3, INT32)` 0; `opType (#4, INT32)` 0 = activate.
- Server: slot star must be Profile 7 grade 10 with a Types 14 recipe (`Material1 = template`), hero level >= recipe `NeedMinLevel` (80) (assumption); replace `template_id` by `NewMaterial`, set grade 1, gp 0 (assumption). Response: 4178 with bag 3 pos 0.

### U4. Feed "Pó da Ilusão"
- UI: feed button `_subBtn` with numeric input (`V/SubStarFrame.as:367-392,403-420`).
- Client checks: slot star must be Profile 8; amount clamped to owned dust; owned <= 0 -> "Não contém Pó da Ilusão dentro da mochila"; amount <= 0 -> "Favor inserir número".
- Sender: `SM.sendStarSublime(1, count)`.
- Route: 5182 `StarGrowOpMsg`: `opType (#4)` 1 = feed; `itemCount (#3)` dust amount.
- Server: consume dust (currency masterType 27) without exceeding what is needed to reach grade 10, `gp += count` (assumption 1 exp per dust), level up with type 60. Response: 4178 with bag 3 pos 0, currency refresh 4725.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When |
|---|---|---|---|
| 4178 (0x1052) `U_C_START_MOVE_UPDATE` | `StarMoveRspMsg` (see [star-equip.md](star-equip.md)) | `SM.__starMoveUpdateHandler`; `SubStarFrame.__starUpdateHandler` refreshes the slot when `bag_type == 3` and adds/removes candidates (`V/SubStarFrame.as:422-486`) | after U1..U4; login when bag 3 holds a star |
| 4725 (0x1275) currency refresh (name not in `opcodes.csv`) | currency list, entry `masterType = 27` -> `newMagicDust` | `PCM` listener `PCM:71`, case 27 `PCM:304-310` | after U4 (owner [currency](../currency/README.md)) |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Access | `thane.vocationGrades > 0` | `V/HoroscopeFrame.as:121` |
| Candidates | bag 1 or 2; Profile >= 8, or Profile 7 with grade 10 and template != 107 | `SM:476-490`, `V/SubStarFrame.as:462-469` |
| Recipes | `ComposeTempInfos.xml` `Types = 14`: 207->208, 307->308, 407->408, 507->508, 607->608, 707->708, 1507->1508, 1707->1708, 1807->1808, 1907->1908; `NeedMinLevel` 80, `NeedGold` 0 | `SM:590-661` |
| Feeding levels | `UpGradeTempInfos` `Types = 60`, `Data` for grade 2..10: 5000, 10000, 15000, 20000, 27800, 36900, 47300, 59000, 72000; max grade 10 | `V/SubStarFrame.as:503-516` |
| Sagrado stats | `starTempInfos` Profile 8 rows, stat x grade (e.g. Sagrado · Aquário Live 7500 per grade) | `starTempInfos.xml` |
| Exp value | Profile 8 counts as Profile 7 grade 10 plus 91 in `getStarTotalExp` (star power) | `SH:120-125` |
| No devour | Profile 8 stars cannot devour or be devoured | `decompiled/core_module/scripts/cell/view/starbag/StarBagCell.as:427-432` |

## 6. Templates

| File | Fields used |
|---|---|
| `ComposeTempInfos.xml` | `Types` 14, `Material1`, `NewMaterial`, `NeedMinLevel` |
| `UpGradeTempInfos.xml` | `Types` 60, `Grades`, `Data` |
| `starTempInfos.xml` | Profile 7 and 8 rows |
| `ItemTempInfos.xml` | 208061 "Pó da Ilusão" (`Property1` 10; display only) |

## 7. Persistent state

No new table. Uses `cosmos.stars` (`bag_type = 3`, `pos = 0`, `origin_bag_type`, `origin_pos`) from [star-divination.md](star-divination.md). Dust lives in the currency feature (masterType 27).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8267 with bag 3 as source or target | `cosmos::star_sublime::handle_move` (called from the 8267 dispatcher) |
| 5182 `opType = 0` | `cosmos::star_sublime::handle_activate` |
| 5182 `opType = 1` | `cosmos::star_sublime::handle_feed` |

- Validation for 5182: `vocationGrades > 0` -> star in bag 3 pos 0 -> op specific rules -> one transaction (template change or dust consumption through the currency service) -> push 4178 and 4725.
- On logout or disconnect with a star in bag 3, leave it there (the client shows it on next open) or return it (assumption: return it to keep slot rules simple).

## 9. Open questions and assumptions

- Assumption: activation resets grade to 1 and gp to 0.
- Assumption: 1 dust = 1 exp; `Property1 = 10` of item 208061 might mean 10 exp per dust item when dust comes from the item.
- Assumption: `NeedMinLevel` 80 applies.
- The client sends end position 0 when returning to bag 2; the server must use the stored origin.

## 10. Implementation checklist

- [ ] Screen (client ready): `SubStarFrame`.
- [ ] 8267 into and out of bag 3 with origin tracking.
- [ ] Route 5182 op 0 activate via Types 14 recipes.
- [ ] Route 5182 op 1 feed dust with type 60 levels.
- [ ] Pushes 4178 and 4725.
- [ ] Tests: template 107 rejected; grade 9 red rejected; activation changes 207 to 208; feeding stops at grade 10; closing the frame returns the star to its origin slot.
