# Steles: Recuo (rollback)

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/SteleSysManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/stele/StelesysModel.as` |
| RBV | `decompiled/m14/scripts/stelesys/view/SteleSysRecycleView.as` |
| V | `decompiled/m14/scripts/stelesys/` |

## 1. Overview

Tab 4 of the stele frame (client class name "Recycle", pt-BR "Recuo"). A strengthened stele is reset to level 0 and the player receives green strengthening material ("Estela de fortalecimento - Verde", template 2101) equal to the EXP it had absorbed. Cost: 1 "Pedra de Recuo" (7110003) per stele, or `stela_roll_back_point` diamonds (100) when the player has no stone. Help text: "O jogador consome 1 Pedra de recuo de cada vez para fazer a Estela fortalecida retornar ao nível 0, assim como ter de volta uma certa quantidade de Estelas de fortalecimento", "Estelas não fortalecidas não podem ser retornadas".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RBV` (`SteleSysRecycleView`) | tab "Recuo" | Grid of steles with `totalExp > 0` (`MOD:92-104`), filter menu, counter, preview of returned material, stone counter `owned/1`, button `_backBtn` | `SteleSysFrame` tab 4 | `backStelaList` filtered and sorted (`RBV:116-128`); returned material cell (first `MasterType = 2` template, `RBV:103-108`) with count `floor(totalExp / Exp)` (`RBV:219-227`); 7110003 owned (`RBV:130-134`) |
| `V/item/StelaBackBoxItem.as` | "Equipado" when equipped | Toggle selection; selecting one deselects the others (`:35-48`, `RBV:207-218`) | grid | level, stars, color |
| `V/item/StelesysRecyleBoxItem.as` | | Returned material icon and number (`:35-48`) | `RBV` | `Description` tooltip |

## 3. Routes (client to server)

### R1. Roll back a stele
- UI: `_backBtn` (`RBV:231-257`), enabled when one stele is selected (`RBV:193-229`).
- Client checks:
  1. If owned 7110003 `<= 0`: confirm "Itens insuficientes, quer usar {0} diamantes para comprar?" (`stela.back.needButTip`) with `{0}` = `ConfigInfos` `stela_roll_back_point` (`RBV:239-252`); cancel aborts.
  2. Only steles with `totalExp > 0` are listed. The client does not check diamonds.
- Sender: `RBV.sendBack` collects the chosen ids (`RBV:267-282`) -> `SteleSysManager.sendRecycle(ids)` (`MGR:192-199`).
- Route: client to server, 8664 (0x21d8) `C_STELA_CLIETN_OP`, `player.PlayerOpMsg`:
  - `op` (#1, INT32) = 7 (`OP_ROLLBACK`).
  - `ids` (#20, INT32, repeated) = stele ids (the UI sends exactly one).
  - `id` (#5) not set (0). Other fields unused.
  - There is no flag telling the server whether the player accepted the diamond payment: the server decides from the stone count.
- Expected response: 115 (0x0073) `U_C_BAG_MOVE_UPDATE` (stone consumed) or the currency push (diamonds), then 4280 `U_C_STELA_UPDATE` with the stele (`level = 0`, `exp = 0`, `totalExp = 0`) and the material row (`step = -1`, `exp` = new quantity). The client refreshes and plays the effect (`RBV:284-291`). Hero attribute push when equipped.

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When |
|---|---|---|---|---|
| 4280 (0x10b8) | `U_C_STELA_UPDATE` | `stela.StelaMsg` / `StelaDataMsg` (fields in `equip.md` S1) | `SteleSysManager.__dataInfosHandler` (`MGR:76-131`) -> `RBV.updateHandler` (`RBV:284-291`) | Response to R1 |
| 115 (0x0073) | `U_C_BAG_MOVE_UPDATE` | inventory message | `GoodsManager.__bagUpdateHandler` (`decompiled/core_module/scripts/yishi/manager/GoodsManager.as:98-101`) | stone consumed |

Error codes: none. Assumption: not enough diamonds or invalid stele -> silent or 126 `U_C_MSG`. The client disables the button after sending (`RBV:281`).

## 5. Rules and formulas

- Eligible: owned stele, `totalExp > 0` (`MOD:92-104`); equipped steles are allowed (they stay equipped).
- Cost per stele: 1 x 7110003 "Pedra de Recuo" if owned, else `stela_roll_back_point` = 100 diamonds (`raw/xml/tempinfos/ConfigInfos.xml`, description "【碑文系统】回退碑文消耗钻石").
- Return: material template = first `StelaTemplates` row with `MasterType = 2` sorted by id (2101, `decompiled/core_module/scripts/yishi/datas/templates/cate/StelaTemplateCate.as:39-51`); quantity `floor(totalExp / material.Exp)` = `totalExp` (Exp 1) (`RBV:219-226`).
- Result: `level = 0`, `totalExp = 0`, `exp = 0`. Assumption: `step` and refine lines are kept (help text only mentions the level).
- Note: `totalExp` includes the base `Exp` of consumed steles, so rolling back converts consumed steles into green material 1:1 per EXP.

## 6. Templates

| File | Fields used |
|---|---|
| `raw/xml/tempinfos/StelaTemplates.xml` | `MasterType = 2` row 2101, `Exp` = 1 |
| `raw/xml/tempinfos/ConfigInfos.xml` | `stela_roll_back_point` = 100 |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 7110003 "Pedra de Recuo" (SonType 711, `Property1` 3): "Pedra de Recuo, pode ser usado para reverter Estelas, a cada reversão se consome uma Pedra de Recuo." |

## 7. Persistent state

Uses `steles.player_steles`, `steles.player_stele_materials` (`equip.md`) and the optional `steles.stele_operation_log` (`intensify.md`). Diamonds belong to the currency feature.

## 8. Backend implementation notes

- Handler `steles::rollback::handle_rollback` (8664 op 7).
- Validation: `ids` non-empty, distinct; each owned, not material, `total_exp > 0`.
- Per stele, in one transaction: consume 1 x 7110003 if available else debit 100 diamonds (reject the stele when neither is possible); add `total_exp` to the material row 2101 (create the row if missing); reset `level`, `total_exp`.
- Pushes: 115 and/or currency update, 4280 (`opType = 7`) with steles and the material row, hero attributes if any equipped stele changed.

## 9. Open questions and assumptions

- Assumption: step and refine lines are preserved.
- Assumption: with several ids, cost is charged per stele and stones are used first.
- Open: whether diamonds means bound or unbound diamonds (currency feature).

## 10. Implementation checklist

- [ ] `steles::rollback::handle_rollback`.
- [ ] Stone first, diamonds fallback using `stela_roll_back_point`.
- [ ] Material row upsert (template 2101).
- [ ] 4280 + bag/currency pushes + hero refresh.
- [ ] Screen: only strengthened steles listed, preview count equals `totalExp`.
- [ ] Tests: rollback with stone; without stone and enough diamonds; without either rejected; stele with `totalExp = 0` rejected; equipped stele rolled back keeps slot and stats drop.
