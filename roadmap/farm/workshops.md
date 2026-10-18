# Workshops and storage

Module `workshops` of feature `farm`. The farm storage ("Armazém"), the farm shop link and the two workshops: "Oficina de magia" (compose recipes for farm products) and "Oficina da alimentação" (UI shell).

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| FBF | `decompiled/m3/scripts/farm/FarmBagFrame.as` |
| FBCC | `decompiled/core_module/scripts/farm/cell/FarmBagCellClickMediator.as` |
| FBCD | `decompiled/core_module/scripts/farm/cell/FarmBagCellDropMediator.as` |
| FMF | `decompiled/m3/scripts/farm/view/make/FarmMakeFrame.as` |
| FMBV | `decompiled/m3/scripts/farm/view/make/FarmMakeBagView.as` |
| FPF | `decompiled/m3/scripts/farm/view/make/FarmProcessingFrame.as` |
| HF | `decompiled/m3/scripts/farm/newview/HomeFrame.as` |
| SSO | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| FSF | `decompiled/m15/scripts/view/subshop/FarmShopFrame.as` |

## 1. Overview

- "Armazém" is a filtered view of the main bag (bag 1) showing seeds (SonType 216) and animals (SonType 1500) (`FBF:107-160`); items are dragged from it onto plots or the pasture ([farmland.md](farmland.md) L1, [pasture.md](pasture.md) P1). No route of its own.
- The farm shop "Loja da Fazenda" (`FSF`, shop controller openType 6) sells seeds and animals; buying is the generic shop route ([shops catalog](../shops/catalog.md), ShopType 23).
- "Oficina de magia" (`FMF`) lists compose recipes of Types 101, 102, 103 and crafts them with the generic compose route 5153 ([smith compose](../smith/compose.md)).
- "Oficina da alimentação" (`FPF`) has inputs and page buttons but no send code; it is only reachable from the legacy `FarmBuildLayer` (`decompiled/m3/scripts/farm/view/FarmBuildLayer.as:216`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FarmBagFrame` (`FBF`) | "Armazém" | seeds and animals, shop button | `HF` store button (`HF:231-235`), empty plot click (`decompiled/core_module/scripts/farm/view/FarmLandItem.as:169-171`), pasture area click (`decompiled/core_module/scripts/farm/view/FarmAnimalArea.as:204-238`); single instance (`FM:1035-1061`) | `GoodsManager.getGeneralBagGoodsBySonType(216 / 1500)` |
| `FarmShopFrame` (`FSF`) | "Loja da Fazenda" | seed and animal shop with filters by output (all, gold, spirit, crystal, experience, medal, other) and sort by maturity time | `HF` shop button (`HF:219-223`), `FBF` shop button (`FBF:101-105`), `FM.openShopFrame` -> shop openType 6 (`FM:1063-1066`, `decompiled/core_module/scripts/mvc/controler/ShopControler.as:79-82`) | shop rows; "Disponível quando fazenda atingir Nv. {0}" |
| `FarmMakeFrame` (`FMF`) | "Oficina de magia" | tabs all / 103 / 102, recipe list, materials with owned/needed, quantity, gold cost, make button, help "Instruções da Oficina de Magia" | `HF` workshop button (`HF:225-229`) -> controller `farm` openType `FARM_MAKE_FRAME` | recipes from `TempleteManager.getComposeTempleteList()` filtered by Types (`FMF:211-230,270-286`) |
| `FarmProcessingFrame` (`FPF`) | "Oficina da alimentação" | UI shell, no route | legacy only | |

## 3. Routes (client to server)

### W1. Make a recipe
- UI: make button (`FMF:268-272`).
- Client checks: materials and gold shown red when short; quantity input clamped to what materials and gold allow (`FMF:313-392`).
- Sender `SSO.sendCompose(composeId, count, false, false)` (`SSO:85-99`): C>S 5153 (0x1421) `U_C_ITEM_COMPOSE`, `store.StoreReqMsg`: `compose_id (#6, INT32)` = recipe `Id`, `compose_num (#7, INT32)` = quantity, `auto_buy (#8, BOOL)` = false, `pay_type (#12, INT32)` = 1, `operate (#2, BOOL)` = false; other fields unset.
- Response and server logic: generic compose ([smith compose](../smith/compose.md)): validate `NeedMinLevel` (hero level), materials, `NeedGold`, then consume and create `NewMaterial` x count; push 115 and gold.

### W2. Buy seeds and animals
- Generic shop buy route of [shops](../shops/catalog.md) (ShopType 23). Server must check the farm level against the row's level requirement (`farm.view.FarmShopItem.needGradeTip`).

## 4. Server messages (server to client)

Only generic pushes: 115 bag updates (the "Armazém" and the workshop refresh on `UPDATE_BAG` / `DELETE_BAG`, `FBF:107-140`, `FMF:234-238`), gold resource updates.

## 5. Rules and formulas

Recipes (`ComposeTempInfos.xml`):

| Types | Id | Product (`NewMaterial`) | Materials | Gold | Min hero level |
|---|---|---|---|---|---|
| 102 | 10010 | 2131256 "Caixa Dourada" | "Casco de Cavalo" x10, "Essência da Magia Vermelha" x10, "Leite de Cordeiro" x300 | 10000 | 15 |
| 102 | 10011 | 2131257 "Caixa Brilhante" | "Chifre de Cordeiro" x10, "Essência da Magia Verde" x10, "Leite de Cordeiro" x300 | 10000 | 40 |
| 102 | 10012 | 2131258 "Caixa Preta" | "Galhada" x10, "Essência da Magia Azul" x10, "Leite de Cordeiro" x300 | 10000 | 45 |
| 103 | 10018 | 2131279 "Chá Verde Escuro" (life +10 % 1 h) | "Chifre de Touro" x10, "Essência da Magia Vermelha" x10, "Leite de Cordeiro" x100 | 10000 | 45 |
| 103 | 10019 | 2131280 "Chá Vermelho" (defense +10 %) | "Chifre de Touro" x10, "Essência da Magia Verde" x10, "Leite de Cordeiro" x100 | 10000 | 45 |
| 103 | 10020 | 2131281 "Chá de Limpeza" (attack +10 %) | "Chifre de Touro" x10, "Essência da Magia Azul" x10, "Leite de Cordeiro" x100 | 10000 | 45 |
| 103 | 10021 | 2131282 "Chá Aromático" (magic +10 %) | "Chifre de Touro" x10, "Essência da Magia Azul" x10, "Leite de Cordeiro" x100 | 10000 | 45 |

Types 101 has no rows in the shipped templates (the "all" tab asks for 101, 103, 102).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ComposeTempInfos.xml` Types 101..103 | farm recipe | `Id`, `Types`, `Material1..4`, `Count1..4`, `NewMaterial`, `Counts`, `NeedGold`, `NeedMinLevel` |
| `ShopTempInfos.xml` ShopType 23 | farm shop row | see [shops](../shops/catalog.md) |
| `ItemTempInfos.xml` | seeds 216, animals 1500, products | display |

## 7. Persistent state

None: items are in the generic inventory; recipes are templates.

## 8. Backend implementation notes

| Route | Handler |
|---|---|
| 5153 with recipe Types 101..103 | `smith::compose::handle_compose` (owner), no farm specific code |
| shop buy ShopType 23 | `shops` owner, plus farm level check `farm::farm_core::farm_level(player)` |

## 9. Open questions and assumptions

- Gap: "Oficina da alimentação" has no server interaction in this client.
- Assumption: the farm shop level requirement uses the farm level, not the hero level.

## 10. Implementation checklist

- [ ] Screens (client ready): `FarmBagFrame`, `FarmBagCell`, `FarmShopFrame`, `FarmMakeFrame`, `FarmMakeBagView`.
- [ ] Ensure compose 5153 accepts Types 102 and 103 recipes.
- [ ] Ensure the farm shop rows exist (ShopType 23) with farm level gating.
- [ ] Tests: make "Caixa Dourada" at hero level 14 refused; materials and 10000 gold consumed on success.
