# Fashion level by absorption (Síntese / absorção de moda)

Path aliases:

| Alias | File |
|---|---|
| FCV | `decompiled/m14/scripts/fashion/FashionComposeView.as` |
| FCM | `decompiled/core_module/scripts/cell/mediator/fashionbag/FashionBagCellClickMediator.as` |
| FDM | `decompiled/core_module/scripts/cell/mediator/fashionbag/FashionBagCellDropMediator.as` |
| SSO | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |

## 1. Overview

The compose tab of "Modas" absorbs fashion items (bag pieces), "Alma da Moda" (208020) or "Amuleto da Sorte" (208021) into a global fashion level (`FashionInfoMsg.grades`, `gp`), 200 levels in `UpGradeTempInfos` `Types 113`. Each level grants two passive skills (template name CSV) and some levels reward a fashion (`ActiveObject`) *(assumption)*. The refine tab is enabled once the fashion level is > 0 (`FashionStoreFrame.as:321`, `:680`).

The help text (`fashion.view.compose.helpFrameContent`) still describes an older "two pieces make a new fashion" synthesis; the BR client sends a single absorb request.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `fashion.FashionComposeView` (FCV) | compose tab; help "Ajuda de Síntese" | One input cell, quantity controls for 208020/208021 stacks, level and EXP bars (current and preview), absorb animation | `FashionStoreFrame` tab 0 | `fashionInfoMsg.grades`, `gp`, next `Types 113` `Data` (FCV:487-567) |
| `cell.view.fashionbag.FashionBag` | | Fashion bag filtered to fashions and materials | FCV | bag 1 items, hidden bag 0 |

## 3. Routes (client to server)

### R1. Put an item into the input cell
- UI: click or drag a bag item (FCM:90-127, FDM:42-175). Checks: player look rejects DragonTalker fashions and vice versa ("Não é possível realizar a absorção de moda de jogador. Por favor, primeiro mude para a aparência de jogador." / "...de Encantador de Dragões..."; DragonTalker not open: "Poderá utilizar esta moda depois de Avançar Profissão e ativar o Encantador de Dragões."; switch off: "A função Moda do Encantador de Dragões ainda não foi ativada."); only one kind in the cell ("Itens diferentes não podem ser sintetizados", "Necessário pelo menos um equipamento para sintetizar").
- Route: 5005 `U_C_BAG_MOVE` (`ItemReqMsg`) from bag 1 to hidden bag 0 at `fashionModel.to_pos`; removal moves it back to bag 1 ([../inventory/README.md](../inventory/README.md)).

### R2. Absorb
- UI: compose button (FCV:303-369); the request is sent at frame 30 of the animation.
- Client path: `SSO.sendFashionCompose(true, count)` (SSO:101-107).
- Route: send 8594 (0x2192) `C_FASHION_COMPOSE`, `StoreReqMsg` (store) with only `count` (#11, INT32): quantity for 208020/208021 stacks (1 for a fashion piece). Other `StoreReqMsg` fields (`hole_pos` #1, `operate` #2, `bag_type` #3, `bag_pos` #4, `mount_pos` #5, `compose_id` #6, `compose_num` #7, `auto_buy` #8, `src_itemid` #9, `des_itemid` #10, `pay_type` #12, `opType` #13) are unset.
- Response: 4487 (S1), then 301 with the new `gp`/`grades`, bag removal pushes, 113 for stats.

## 4. Server messages (server to client)

### S1. 4487 (0x1187) `U_C_FASHION_COMPOSE`
- Listeners exist in FCV:203 and `FashionBag.as:362`, both empty; the body is not read. Send it as an acknowledgement (any message, e.g. an empty `StoreReqMsg`) *(assumption)*.

### S2. 301 `U_C_FASHION_INFO`
`gp` (#1) and `grades` (#2) updated ([wardrobe.md](wardrobe.md)).

## 5. Rules and formulas

EXP per absorb (`FCV.calcGp`, FCV:608-660):
- Fashion piece: `base * 2^(g - 1)` where `g` = `Grades` of the first valid `randomSkill1..5` of the item (1 if none), clamped to 1..12; `base` = `Fashion_Wing` (1600) for SonType 109, else `Fashion_Other` (300).
- 208021 "Amuleto da Sorte": `Fashion_Lucky` (200) x count; 208020 "Alma da Moda": `Fashion_Soul` (200) x count.
- Level up while `gp >= Types 113 Data` of the next level (level 1 = 300, 2 = 400, 10 = 1400, 50 = 9400, 100 = 24100); max level 200.
- Each level's `TemplateName` holds two skill ids (e.g. "40801001,40802001") applied to the hero.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `UpGradeTempInfos.xml` | `Types 113` (200 rows) | `Grades`, `Data` (EXP), `TemplateName` (skill CSV), `ActiveObject` (reward id, *(assumption)*) |
| `ConfigInfos.xml` | | `Fashion_Wing` 1600, `Fashion_Other` 300, `Fashion_Lucky` 200, `Fashion_Soul` 200 |
| `ItemTempInfos.xml` | 208020, 208021 (SonType 278), fashion pieces | random skill slots |

## 7. Persistent state

Columns `fashion.wardrobe.fashion_level` and `fashion_exp` ([wardrobe.md](wardrobe.md)). Items are in `inventory.items` *(assumption: inventory schema)*.

## 8. Backend implementation notes

- `fashion::compose::handle_compose` (8594): read the item(s) in hidden bag 0; validate kind and look; `count` <= stack; compute EXP with the formula; transaction: consume items, add EXP, level up through `Types 113`, grant level skills/rewards; reply 4487, push 301, bag updates, 113.

## 9. Open questions and assumptions

- Assumption: `ActiveObject` of `Types 113` is a reward item granted at that level.
- Open: bound vs unbound soul consumption order ("Alma da Moda vinculada insuficiente, consumir Alma da Moda não vinculada para proseeguir com a síntese?").

## 10. Implementation checklist

- [ ] Screen: FashionComposeView
- [ ] Route 5005 to/from hidden bag (inventory)
- [ ] Route 8594 absorb
- [ ] Server message 4487 ack
- [ ] Server message 301 level/EXP
- [ ] Rule: EXP formula and `Types 113` table
- [ ] Test: absorb a wing of grade 3 adds 6400 EXP
