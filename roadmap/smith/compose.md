# Smith: compose (forge, upgrade, mould)

Scope: the "Fabricar" compose tab of the smith frame (recipe synthesis of equipment, materials, gems, Avenger and Theseus items, equipment upgrade [Ω]), the recipe list push, and the "Molde divino" (cast / mould) panel. Frame shell, smith bags, item placement into the hidden smith bag (bag 0) and the generic `StoreReqMsg`/`StoreRspMsg` path are in [store-frame.md](./store-frame.md). Gem specific rules (insert, gem levels, one key gem compose 9741) are in [gems.md](./gems.md); gem synthesis itself goes through the generic compose route described here (recipe Types 3, 6, 8, 12).

Path aliases:

| Alias | File |
|---|---|
| SSOM | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StoreControler.as` |
| SM | `decompiled/core_module/scripts/mvc/module/store/StoreModel.as` |
| CGI | `decompiled/core_module/scripts/mvc/module/store/ComposeGoodsInfo.as` |
| CGT | `decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| PI | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as` |
| GI | `decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| MF | `decompiled/m14/scripts/store/MakeFrame.as` |
| SV1 | `decompiled/m14/scripts/store/StoreView1.as` |
| CV1 | `decompiled/m14/scripts/store/ComposeView1.as` |
| CMV | `decompiled/m14/scripts/store/compose/ComposeMatetialView.as` |
| CLV | `decompiled/m14/scripts/store/compose/ComposeListView.as` |
| CSLV | `decompiled/m14/scripts/store/compose/ComposeSubListView.as` |
| CCB | `decompiled/m14/scripts/store/compose/ComposeCellButton.as` |
| NMI | `decompiled/m14/scripts/store/compose/NeededMaterialItem.as` |
| CAST | `decompiled/m14/scripts/store/cast/CastView.as` |
| SB2 | `decompiled/m14/scripts/store/StoreBagII.as` |

## 1. Overview

- The player picks a recipe ("fórmula") from `ComposeTempInfos` that is present in his known recipe list, sees the 1..4 materials with owned / needed counts and the gold cost, chooses how many to make (batch) and presses the compose button. The server consumes materials and gold and creates `Counts` x the product (`NewMaterial`) per batch unit.
- Recipe tabs (`CV1:310-327`): 1 equipment, 2 property (materials), 3 gems ("Gemas"), 4 Avenger (deified players only), 5 Theseus (royalty level > 0).
- Equipment upgrade (recipe Types 5, "evolução") consumes one specific equipment instance (Material1) and keeps its refine / mould / strengthen attributes; normal equipment compose (Types 1) keeps them as well (`CMV:908-922`).
- Gem recipes (Types 3 and 6) support "buy and compose": missing lower level gems are bought with diamonds in the same request (`auto_buy`).
- "Molde divino" (cast): raises the mould grade of an equipment placed in the smith hidden slot 0, consuming Vulcan materials and gold, with a success rate and a blessing counter.
- Recipes are granted by the server push 4184 `U_C_ITEM_SMITH` (full list at login, increments later).

Out of scope, same opcodes reused elsewhere:
- Fashion compose 8594 `C_FASHION_COMPOSE` / 4487 and fashion switch 8595 / 4488 (`SSOM:101-114`): see [../fashion/README.md](../fashion/README.md).
- Einherjar equipment upgrade (`decompiled/m14/scripts/pet/equipstore/PetEquipUpgradeView.as:568,592`) reuses 5153 + 89; Einherjar equipment mould (`PetEquipStrengView.as:489,527`) reuses 8644 + 4558: see [../einherjar/README.md](../einherjar/README.md).
- Life skill compose 8971 op 2 (`SSOM:219-227`, frame `store.makeFrame.lifeskill`, `SC:99-107`): not part of this module.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `MF` (`store.MakeFrame`) | "Fabricar" (`MF:155`) | Smith frame; tab 1 is compose | Main toolbar, `SC.startFrameByType("STORE_PANEL_COMPOSE")` from `PlayerEquipCell.as:255` and `SwitchPageHelp.gotoStoreFrame` (see [store-frame.md](./store-frame.md)) | tabs "store", compose, switch, resolve; compose tab disabled below level 15 with tip "Função habilitada no Nv. {0}" (`MF:184-187`) |
| `CV1` | (tab) | Compose tab container: 5 category buttons, "can make" checkbox (`_checkBtn`), recipe tree, material panel | `MF.showComposeView` (`MF:349-357`) | category buttons; Avenger button disabled if not deified, tip "Liberado após a deificação" (`CV1:130-133`, `CV1:189-197`); Theseus button enabled only when `royaltyLevel > 0` (`CV1:134`) |
| `CSLV` | | Grouped tree (equipment, gems, Avenger, Theseus) | `CV1.getTreeComponentByModelType` (`CV1:293-308`) | groups (suit level, gem type, Avenger pearl type, Theseus element) with summed can make counts (`CSLV:251-267`) |
| `CLV` | | Flat list (property tab) | same | recipes with "(n)" can make count (`CCB:495-512`) |
| `CCB` | group titles: "Equipa. de Cavaleiro (avanço de profissão)", "Armadura e Criaturas", "Equip Einheirjar", "Equipamentos da Arma divina", "Equipar monstro", "Acessório da Deusa", "Equipamento de Divindade", "Brasão e Objeto Divino (Divindade)", "Conjunto Nv. {0}", "Gemas", "Cristal de Anti-RES", "Alma Divina de Einherjar", "Agáta de Guardião", "Pedra do Julgamento", "Pedra fundida de ouro" (`CCB:377-459`) | Tree cell | list views | product name or "Item não encontrad" + id when the product template is missing (`CCB:179,205`) |
| `CMV` | | Material panel | `CV1` | product icon and name, 4 `NMI` slots "owned / needed" (`NMI:54-102`), count box with min / - / + / max, gold "NeedGold x count", compose button, gem "buy and compose" button (`_promptlyBtn`), note "Equip. de síntese terão os mesmos atributos de refinação/molde divino/fortal. anterior" (Types 1) or "Equip. de evolução terão os mesmos atributos de refinação/molde divino/fortal. anterior" (Types 5) (`CMV:908-922`) |
| `CAST` (`store.CastView`) | tab "Molde divino" in `SV1` | Mould panel | `SV1.__onTabBtnHandler` case `_castBtn` (`SV1:228-230`) | equipment in hidden slot 0, preview at max grade, 2 materials with owned / needed, gold, success rate %, "Pontos de Bênção" bar `bless / 100`, alert text "Equipamentos de nível intermédio e superior, assim como Relíquias Divinas e Brasões [Ω] podem ser melhorados através de Molde Divino." (`CAST:124-126`, `CAST:380-452`) |
| `decompiled/m14/scripts/store/compose/ComposeView.as` | | Legacy compose tab of the old `StoreFrame` (category buttons gated at levels 50/55/70) | legacy `StoreFrame` (`decompiled/m14/scripts/store/StoreFrame.as:283`) | same material panel; not used by `MakeFrame` |

## 3. Routes (client to server)

### R1. Compose a recipe (normal button)

- UI: compose button of `CMV` (`CMV:236`, handler `CMV:292-390`).
- Client checks, in order:
  1. `gold < currentComposeCount * NeedGold` -> "Ouro Insuficiente" (`CMV:310-316`).
  2. Gem recipes (Types 3 or 6) with missing materials and the normal button -> "Materiais desbloqueados insuficientes" (`CMV:320-329`).
  3. For each material i: `Count_i * N` must be <= owned unlocked count (Material1 counted with `GM.getGoodsNumByIdAndNotLockInEquipBag`, others with `GM.getGoodsNumByTempIdAndNotLock`, `CMV:345-353`, `GM:1213-1235`, `GM:1278-1296`). On shortage -> "Materiais desbloqueados insuficientes", unless the product SonType is 205, 228, 312, 670, 693 or 720 (`CMV:353-361`).
  4. Product SonType 218 (mount card): if the wild soul is already active permanently (`validity < 0`, product `Property2 < 0`, `Refresh == -1`) -> "Fera ativada, não poderá ativar." (`CMV:362-371`).
  5. Inherit mould option (`_extendsMould`) is always hidden (`CMV:177-184`), so the inherit branch (`CMV:372-388`, 200 points, confirm "Você ainda não selecionou o nível do molde divino que deseja herdar, continuar?") never runs in this build.
  6. Button enable rules: disabled when no recipe or `canMakeCount == 0`, or product `NeedChangeJob == 1` and `vocationIndex == 0`, or `NeedChangeJob == 2` and `vocationIndex < 3` (`CMV:807-832`).
- Client path: `CMV.sendCompose(true,false)` (`CMV:594-606`) -> `SC.sendCompose(useBind=false, extendsMould=false)` (`SC:522-539`) -> `SSOM.sendCompose(template.Id, currentComposeCount, autoBuy=false, param4=false, operate=false)` (`SSOM:85-99`).
- Route: send 5153 (0x1421) `U_C_ITEM_COMPOSE`, `StoreReqMsg`:

| Field | Value / meaning |
|---|---|
| hole_pos (#1, INT32) | unused |
| operate (#2, BOOL) | inherit the mould grade of the consumed equipment (feature hidden, always false) |
| bag_type (#3, INT32) | unused |
| bag_pos (#4, INT32) | unused |
| mount_pos (#5, INT32) | unused |
| compose_id (#6, INT32) | `ComposeTempInfos.Id` |
| compose_num (#7, INT32) | batch count N (>= 1) |
| auto_buy (#8, BOOL) | false |
| src_itemid (#9, INT32) | unused |
| des_itemid (#10, INT32) | unused |
| count (#11, INT32) | unused |
| pay_type (#12, INT32) | 0 when "Diamante vinculado prioritário" was checked (bound diamonds first), 1 otherwise (`SSOM:92-96`); this path always sends 1 |
| opType (#13, INT32) | unused |

- Expected response: bag pushes (materials removed, product added, gold) then 89 `U_C_ITEM_COMPOSE` (S1). `SC.startAlertBack` also fires `UPDATE_COMPOSE_MAX_COUNT` (`SC:548-569`) but `showAlert` always returns false (`SC:541-546`).

### R2. Buy and compose (gem recipes, `_promptlyBtn`)

- UI: second button shown for recipe Types 3 and 6 except when the product grade equals the "cannot buy" grade (`jewelGrade` = last two digits of `NewMaterial`; Types 3 -> 2, Types 6 -> 1) (`CMV:683-684`, `CMV:838-885`). It is enabled only when `canMakeCount == 0`.
- Client checks: gold as R1; `needCountGrmMulti(N)` (`CMV:398-430`) computes, for each material, the missing base units and their shop price, walking the recipe chain down (up to 11 levels) until a shop buyable template is found (`CMV:432-544`); price per unit = `ShopTempInfo.price` with time discount `ShopManager.getDiscountIntimeBuy`. If `point > 0`, confirm alert type `USEBINDPOINT_ALERT`: "quantidade de itens insuficientes,  quer gastar {0} diamantes para comprar  {1} itens necessários para sintetização?" plus "<br/><font color=\"#FF00000\">Loja - Liquidação de Gemas, economize {0} diamantes</font>" when discounted (`CMV:320-341`).
- Count limit: with this button the count box allows up to 9 regardless of owned materials (`SC:798-866`).
- Client path: alert callback `CMV.sendCompose(confirm, useBindPoint, discountPoint)` -> `SC.sendCompose(useBindPoint, false)` -> `SSOM.sendCompose(id, N, autoBuy=true, useBindPoint, false)`.
- Route: 5153 `StoreReqMsg` as R1 with `auto_buy = true`, `compose_num` 1..9, `pay_type = useBindPoint ? 0 : 1`.
- Response: as R1. The server must charge diamonds for the missing units before composing.

### R3. Equipment upgrade (recipe Types 5)

- UI: same compose button; the count box is hidden for Types 5 (`CMV:782-789`, `CMV:888-906`).
- Pre-step (client): when Material1 is a vice equipment (fashion with Job 99, `GoodsTemplateInfo.as:247-255`), `CMV.refreshSelectedCompose` moves the highest strengthened copy from bag 1 or 4 to hidden slot 0 with 5005 `U_C_BAG_MOVE` (`CMV:694-735`); see [store-frame.md](./store-frame.md).
- Client checks: as R1, plus `SM.getCurrentUpgradeEquipGoodsInfo()` must find Material1 on the hero (bag 4) or in the bag (`SM:473-494`, `SC:528-534`).
- Client path: `SC.sendCompose` -> `SSOM.sendUpdateEquip(composeId, 1, useBind, extendsMould)` (`SSOM:116-129`).
- Route: 5153 `StoreReqMsg` with `compose_id`, `compose_num = 1`, `pay_type`, `operate`; `auto_buy` not set (false).
- Response: as R1.

### R4. Mould ("Molde divino")

- UI: cast button `_castBtn` (`CAST:174`, `CAST:188-191`, `CAST:249-311`).
- Tab gate: cast tab enabled at level >= 80 (`SV1:115`); click blocked with "Esta função será liberada após o avanço de nv.{0}" (80) when `vocationGrades <= 0` (`SV1:266-270`).
- Placement: only items accepted by `SB2` cast filter: Vulcan materials 2120100..2120107 and equipment with `StrengthenMax > 0`, `Profile >= 5`, `NeedGrades >= 50` (`SB2:816-857`); equipment goes to hidden slot 0 via 5005.
- Client checks:
  1. `gold < GoodsCheck.getMouldGold(item)` -> "Ouro Insuficiente" (`CAST:256-261`).
  2. Profession cap: `vocationLevel < 8` and `mouldRank == vocationLevel` and `mouldStar == 10`, or `vocationLevel == 8` and `mouldRank == MOULD_MAX_RANK` and `mouldStar == 10` -> "Após elevar o nível da profissão pode-se continuar com o Molde divino" (`CAST:262-267`).
  3. Materials: needed counts (R4 rules in section 5). On shortage: if `mouldGrade >= 160` -> "Material insuficiente. Não é possível moldar." (`CAST:296-300`); else compute diamonds `= missing1 * EquipAdv_Points[idx1] + missing2 * EquipAdv_Points[idx2]` and ask "Itens insuficientes, deseja consumir {0} diamantes para realizar o Molde Divino?" (`USEBINDPOINT_ALERT`, `CAST:301-321`). On confirm, `allPoint` (bound first) or `point` must cover it, else recharge alert (`CAST:323-348`).
  4. Max grade reached -> button disabled, max tip shown (`CAST:441-446`).
- Client path: `SC.sendItemMould(payType)` (`SC:517-520`) -> `SSOM.sendItemMould` (`SSOM:197-203`).
- Route: send 8644 (0x21c4) `C_MOULD_ITEM`, `PayTypeMsg`:

| Field | Value / meaning |
|---|---|
| pay_type (#1, INT32) | 0 = materials owned, or auto buy with bound diamonds first; 1 = auto buy with diamonds only (`CAST:344`) |
| property1 (#2, INT32) | unused |
| property2 (#3, INT32) | unused |
| type (#4, INT32) | unused |

- Target item: the item in hidden smith slot 0 (no id in the request). Response: item update push for the equipment, bag pushes for materials and gold, then 4558 `U_C_MOULD_ITEM` (S3).

### R5. Recipe list

- No compose specific request: the full list is requested at login by 8224 `C_LONIG_LOAD_REQ` with `PlayerDataMsg.smith = true` (route R5 of [store-frame.md](./store-frame.md)) and arrives with 4184 (S2). Recipe scroll items (SonType 211, `Property1` = compose id) are blocked client side when already known: "Você já aprendeu essa fórmula" (`decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:1007-1012`); their use goes through the inventory use item route 5006 ([../inventory/README.md](../inventory/README.md)). `ItemTempInfos.xml` contains no SonType 211 items in this build, but it has 99 recipe scrolls with MasterType 2, SonType 208 and the name prefix "Fórmula" (for example 2110001 "Fórmula de Gema - Ataque Nv. 5", `NeedGrades` 30). Using one teaches a recipe; the client's known check on SonType 211 never matches them, so the server must reject a scroll whose recipe is already known.

## 4. Server messages (server to client)

### S1. 89 (0x0059) `U_C_ITEM_COMPOSE`, `StoreRspMsg`

| Field | Meaning |
|---|---|
| compose_result (#1, BOOL) | true on success |
| compose_templateId (#2, INT32) | compose id or product template id (not read by the client; Assumption: compose id) |
| streng_result (#3, BOOL) | unused here |
| strengthenGrade (#4, INT32) | unused here |
| pos (#5, INT32) | unused here |
| objectId (#6, INT32) | unused here |
| bagType (#7, INT32) | unused here |
| strBlessValue (#8, INT32) | unused here |
| gp (#9, INT32) | unused here |

- Receiver: `SC.__onComposeCallback` (`SC:249-255`, registered in `SC.addEvent` `SC:239-242` while the frame is open) sets `model.composeComplete = true` -> `StoreEvent COMPOSE_COMPLETE` (`SM:438-444`) -> `CMV.refreshMaterials` (`CMV:676-692`). Inventory changes arrive through bag pushes (`UPDATE_BAG` / `DELETE_BAG`) which re-run `SC.initComposeGoodsCount` (`CV1:245-253`).
- When: once per 5153 request, after the bag pushes. Failure (`compose_result = false`) has no specific client text; the server should send a generic message tip (Assumption).
- Also consumed by `PetEquipUpgradeView.as:259`.

### S2. 4184 (0x1058) `U_C_ITEM_SMITH`, `ItemSmithyMsg` (package item)

| Field | Meaning |
|---|---|
| composeId (#1, INT32, repeated) | compose ids added to the known recipe list |

- Receiver: `PM.__addComposeTempHandler` (`PM:155`, `PM:450-459`) -> `PI.addComposeTemp` (`PI:1204-1218`): first message initializes the list, later ones append. `SC.checkOwn` filters recipes by this list (`SC:230-237`).
- When: response to the login smith data request (8224 with `smith = true`, see [store-frame.md](./store-frame.md)) with the full known list (required, otherwise the compose tab is empty), and push with new ids whenever a recipe is learned. Shared with [store-frame.md](./store-frame.md), which lists it among the smith result messages.

### S3. 4558 (0x11ce) `U_C_MOULD_ITEM`, `StoreRspMsg`

| Field | Meaning |
|---|---|
| compose_result (#1, BOOL) | unused |
| compose_templateId (#2, INT32) | unused |
| streng_result (#3, BOOL) | true = mould step succeeded |
| strengthenGrade (#4, INT32) | new `mouldGrade` of the item |
| pos (#5, INT32) | hidden bag position of the item (0) |
| objectId (#6, INT32) | item objectId |
| bagType (#7, INT32) | item bagType (0) |
| strBlessValue (#8, INT32) | Assumption: new blessing value (client reads blessing from the item update instead) |
| gp (#9, INT32) | unused |

- Receiver: `CAST.__mouldResult` (`CAST:219-247`). Success: updates the hidden slot item `mouldGrade` and shows "Operação sucediada, Nível do Molde divino +1". Failure: "Molde divino sem sucesso, pontos de bênção +{0}" with constant 5. Both refresh the view.
- Also consumed by `PetEquipStrengView.as:330`.

### S4. Bag and resource pushes

- Item add / update / delete pushes and gold / diamond resource pushes are owned by inventory and player features; see [store-frame.md](./store-frame.md) and [../inventory/README.md](../inventory/README.md). The client recomputes counts on `UPDATE_BAG`, `DELETE_BAG`, `DEVIL_ARMOR_BAG_UPDATE` (virtual bag 212 type 3), `EVENT_THESEUS_BAG_UPDATE` and Theseus `EVENT_SUIT_UPDATE` (`CV1:137-183`).

## 5. Rules and formulas

### Recipe catalog and visibility
- Category of a recipe by `Types` (`SC:159-191`): equipment list = 1, 5, 9, 13, 17, 18 (switch `COMPOSE_TYPE_3TURN`), 19 (switch `COMPOSE_TYPE_3WENZHANG`), 20; property = 2; gems = 3, 6, 8, 12; Avenger = 16, 104, 111..116, 121..126, 131..136, 141..146, 151..156 (`SM:328-369`); Theseus = 201..209, 301..309, 351..356, 361..369 (`SM:282-307`). Types 10, 11, 14, 102, 103, 370 are not shown in this frame.
- A recipe is listed only when its `Id` is in the known recipe list (`SC:230-237`).
- Lists are sorted by `NewMaterial` ascending (`SC:144-157`).
- Job filter: product template `Job` must be `player.job % 3` (0 -> 3), 0 or 4 (`CSLV:107-157`, `CLV:115-121`).
- Level filter (`VersionSwitch.STORE_SHOW = true`): `NeedMinLevel <= grades + 10`, except products whose id starts with "218" (mount cards): `NeedMinLevel <= grades` (`CSLV:120-152`, `CLV:124-145`). Products of SonType 117 / 118 are hidden while `vocationGrades <= 0`.
- "Can make" checkbox (`isCanMake`) hides recipes with `canMakeCount <= 0` (`CV1:218-224`, `CSLV:115`).
- Equipment tab grouping key (`CSLV:158-210`): product `NeedChangeJob == 1` -> 85; Types 9 -> 100; 20 -> 105; 13 -> 110; 17 -> 115; 18 -> 116; 19 -> 117; SonType 117/118 -> 90; else `NeedMinLevel` ("Conjunto Nv. {0}"). Gem, Avenger, Theseus tabs group by `Types`.
- Default tab: equipment, or gems when `StoreModel.defaultChildPanel == 3` (set by `SwitchPageHelp.as:198`) (`CV1:199-216`).

### Owned counts and can make count
- `ownCount_i` (`SC:597-717`):
  - Avenger recipes: player bag + storehouse (bags 1, 34) + Avenger virtual armor bag count.
  - Theseus recipes: bag 1 count + Theseus armor bag + bag 34 for SonType 761 + suit pieces for SonType 720; Types 361..369 use bags 1 + 34; Types 201..209 use `getGoodsNumByTempIdAndNotLock`.
  - Others: sum over bags 1, 34 (objectId 0), 4 (hero equipment) and 0 (`GM:557-568`), `-1` when the material slot is empty.
- `canMake_i = floor(ownCount_i / Count_i)`; `canMakeCount = min over materials with id > 0` (`CGI:56-124`).
- `canMakeCount = 0` when the product needs a job change (`NeedChangeJob == 1`) and the hero has not changed job, or `NeedChangeJob == 2` and the hero is not deified (`SC:700-715`).

### Batch count
- Count starts at 1 when `canMakeCount > 0` or the recipe is a gem type (3, 6, 8, 12) (`SM:393-411`).
- Buttons min = 1, - = minus 1, + = plus 1, max = `canMakeCount`; with the buy and compose button active the cap is 9 (`SC:798-866`, `CMV:742-795`).
- Gold = `NeedGold * N` (`CMV:643`, `CMV:748`).
- Server rules (Assumption, mirror the client): `1 <= compose_num <= canMakeCount` without auto buy, `<= 9` with auto buy; `compose_num` forced to 1 for Types 5.

### Consumption and result
- Consumes `Count_i * N` of each `Material_i` (unlocked units only, `GM:1213-1235`) and `NeedGold * N` gold; creates `Counts * N` of `NewMaterial`. `Counts` is 1 for all 3340 rows.
- Types 1 and 5: the new equipment keeps refine (random skills), mould grade and strengthen grade of the consumed Material1 equipment (`CMV:908-922`).
- Recipes require `NeedMinLevel <= hero level` server side (Assumption; the client shows recipes up to +10 levels but `ComposeListView` previews only).
- `NeedBuildingTemp` and `IsLearn` are 0 for all rows; `Property1` is the gem attribute group for gem recipes.

### Mould (cast)
- `mouldRank = (g - 1) / 10 + 1`, `mouldStar = g % 10` (0 -> 10) (`GI:125-142`).
- Max grade: 80 normal, 160 senior, 240 for third transfer items with `AVENGER_CAST_SUN` (else 160) (`GI:286-301`); max rank 8 / 16 / 24 (`GI:273-284`).
- Materials by grade: g < 80: 2120100 "Martelo do Vulcan" + 2120101 "Forno do Vulcan"; 80..159: 2120102 "Bigorna de Vulcan" + 2120103 "Alicate de Vulcan"; >= 160: 2120106 "Fole de Vulcan" + 2120107 "Amolador de Vulcan" (`GI:182-214`).
- Counts per step (`GI:303-322`): g < 160: 5 and 15; < 180: 15; < 200: 25; < 220: 40; else 60 (same for both). SonType 117 / 118: 10 and 30 below 80, else 3 x the normal counts (`CAST:276-293`).
- Gold: `star' = mouldStar == 10 ? 1 : mouldStar + 1`; `k * (8 + star')^3` with k = 500 (g <= 80), 1000 (80 < g <= 160), 2000 (g > 160) (`decompiled/core_module/scripts/bag/helper/GoodsCheck.as:339-366`).
- Success rate: `star' <= 5 ? 50 - 10 * (star' - 1) : 5`, plus blessing, capped at 100 (`decompiled/core_module/scripts/yishi/utils/StoreHelper.as:67-91`, `CAST:425-437`).
- Blessing: 0..100 (`SM:169`), +5 per failure (`CAST:243`). Assumption: reset to 0 on success.
- Auto buy prices: `EquipAdv_Points = 15,5,45,15,90,30` indexed by [2120100, 2120101, 2120102, 2120103, 2120106, 2120107] (`ConfigInfos.xml`, `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:783-790`, `CAST:268-306`).
- Stat bonus of mould grade g on base b: `int(b*g*0.3)` up to 80, `+int(b*(g-80)*0.4)` up to 160, `+int(b*(g-160)*0.25)` above (`decompiled/core_module/scripts/yishi/utils/GoodsHelp.as:138-153`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ComposeTempInfos.xml` (3340 rows, loaded `TempleteManager.as:1445`, class `CGT`) | one recipe | `Id`, `Types` (category), `Material1..4` + `Count1..4`, `NeedMinLevel`, `NeedBuildingTemp` (0), `NewMaterial` (product template), `Counts` (product units, 1), `NeedGold`, `Property1` (gem group), `IsLearn` (0, not read by the client) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | product and material templates | `TemplateName`, `SonType`, `MasterType`, `Job`, `NeedGrades`, `NeedChangeJob`, `Profile`, `StrengthenMax`, `Refresh`, `Property1..2` |
| `raw/xml/tempinfos/ShopTempInfos.xml` | shop price of buyable gem bases | `ItemId`, `price` (`CMV:453-467`) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `EquipAdv_Points` | mould auto buy point per material |
| warsoul templates (`TempleteManager.warsoulCate`) | product of Types 361..369 (War Soul) | `Name`, `Icon` (`CMV:626-633`) |

## 7. Persistent state

Assumption: items live in `inventory.items(item_id BIGINT PK, player_id, template_id, bag_type, position, count, ...)`; the mould grade is an item attribute. If inventory does not own it, use `smith.item_mould`.

```sql
CREATE SCHEMA IF NOT EXISTS smith;

CREATE TABLE smith.known_recipes (
    player_id   BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    compose_id  INTEGER NOT NULL,              -- ComposeTempInfos.Id
    learned_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
    source      SMALLINT NOT NULL DEFAULT 0,   -- 0 default grant, 1 recipe item, 2 gm/event
    PRIMARY KEY (player_id, compose_id)
);

CREATE TABLE smith.item_mould (
    item_id      BIGINT PRIMARY KEY REFERENCES inventory.items(item_id) ON DELETE CASCADE,
    mould_grade  SMALLINT NOT NULL DEFAULT 0 CHECK (mould_grade BETWEEN 0 AND 240),
    bless_value  SMALLINT NOT NULL DEFAULT 0 CHECK (bless_value BETWEEN 0 AND 100),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE smith.compose_log (
    log_id        BIGSERIAL PRIMARY KEY,
    player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    compose_id    INTEGER NOT NULL,
    compose_num   INTEGER NOT NULL CHECK (compose_num > 0),
    auto_buy      BOOLEAN NOT NULL DEFAULT false,
    gold_spent    BIGINT NOT NULL DEFAULT 0,
    points_spent  INTEGER NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX compose_log_player_idx ON smith.compose_log (player_id, created_at DESC);
```

## 8. Backend implementation notes

Handlers:
- 5153 -> `smith::compose::handle_compose`.
- 8644 -> `smith::compose::handle_mould`.
- Login hook -> `smith::compose::push_known_recipes` (4184 with the full list). Grant hook -> `smith::compose::grant_recipe(player_id, compose_ids)` (insert + 4184 increment).

`handle_compose` validation order:
1. Decode `StoreReqMsg`; load recipe by `compose_id`; reject unknown id.
2. Recipe must be in `smith.known_recipes`; recipe category must be one exposed by the smith (Types list in section 5).
3. Feature gate: hero level >= 15. Category gates: Avenger Types need deified hero; Theseus Types need royalty level > 0.
4. `NeedMinLevel <= hero level`; product `NeedChangeJob` vs hero vocation; product Job filter.
5. Types 5: `compose_num = 1`; locate Material1 instance: hidden slot 0 first (vice equip), else equipped on the hero, else first in bag; it must not be locked.
6. `compose_num >= 1`; `<= 9` when `auto_buy`.
7. Count unlocked material units in bags 1, 34, 4, 0 (and the Avenger / Theseus virtual bags for those categories). Without `auto_buy`, every `Count_i * N` must be covered. With `auto_buy` (Types 3 and 6 only), compute missing base units through the recipe chain and their shop price with current discounts; charge diamonds using `pay_type` (0 bound first, 1 diamonds only); fail with "not enough diamonds" if insufficient.
8. Gold `NeedGold * N`.
9. Bag space for `Counts * N` products.
- Transaction: one DB transaction for material removal, gold / diamond debit, product creation (with attribute inheritance for Types 1 and 5: copy random skills, mould grade and strengthen grade of the consumed Material1), and `compose_log`. After commit: bag pushes, resource pushes, then 89 with `compose_result = true`. On any validation failure send 89 with `compose_result = false` plus a message tip.

`handle_mould` validation order:
1. Item in hidden slot 0 of the player; template must satisfy `StrengthenMax > 0`, `Profile >= 5`, `NeedGrades >= 50`; hero `vocationGrades > 0` and level >= 80.
2. `mould_grade < max grade`; profession cap rule (section 5).
3. Materials by grade band; if short and grade < 160, compute points with `EquipAdv_Points` and debit per `pay_type`; if short and grade >= 160, reject.
4. Gold `k * (8 + star')^3`.
5. Roll success with rate `min(100, base(star') + bless)`. Success: `mould_grade + 1`, bless reset (Assumption). Failure: `bless = min(100, bless + 5)`.
- Single transaction; then item update push, bag / resource pushes, then 4558.

No timers, no battles, no pushes to other players.

## 9. Open questions and assumptions

- Assumption: recipes taught by a SonType 208 "Fórmula" scroll (99 items, the taught recipe id read from the scroll template) start locked; every other recipe is granted at character creation (all 3340 rows have `IsLearn = 0`). 4184 at login carries the known ids and is pushed again after a scroll is used. Confirm the scroll field that holds the recipe id.
- Assumption: `compose_templateId` in 89 is the compose id.
- Assumption: `pay_type` 0 means "bound diamonds first" (checkbox "Diamante vinculado prioritário", `CAST:330-336` uses `allPoint` when checked and `point` otherwise).
- Assumption: blessing resets to 0 on mould success; `strBlessValue` carries the new blessing.
- Open: failure codes of compose and mould; the client has no per error text, so the server must send message tips.
- Open: the inherit mould option (`operate`, 200 points `SM:171`) is hidden in this build; implement as no-op unless enabled.
- Open: the 10 levels look ahead of the list versus server enforcement of `NeedMinLevel`.

## 10. Implementation checklist

- [ ] Screen: `MakeFrame` compose tab gate (level 15) and `ComposeView1` categories with Avenger / Theseus gates.
- [ ] Screen: recipe tree (`ComposeSubListView`, `ComposeListView`, `ComposeCellButton`) with job, level and "can make" filters.
- [ ] Screen: `ComposeMatetialView` counts, gold, buttons, notes.
- [ ] Screen: `CastView` mould panel.
- [ ] Route R1: 5153 normal compose.
- [ ] Route R2: 5153 buy and compose for gems (`auto_buy`, `pay_type`).
- [ ] Route R3: 5153 equipment upgrade (Types 5) with attribute inheritance.
- [ ] Route R4: 8644 mould with `PayTypeMsg`.
- [ ] Server message S1: 89 `StoreRspMsg`.
- [ ] Server message S2: 4184 `ItemSmithyMsg` at login and on grant.
- [ ] Server message S3: 4558 `StoreRspMsg`.
- [ ] Table `smith.known_recipes`, `smith.item_mould`, `smith.compose_log`.
- [ ] Rule: category mapping by `Types`, can make count, batch caps (canMakeCount / 9), gold `NeedGold * N`.
- [ ] Rule: gem auto buy price walk through the recipe chain.
- [ ] Rule: mould materials, counts, gold, success rate, blessing, max grades, profession cap.
- [ ] Test: compose with locked materials excluded.
- [ ] Test: batch N consumes `Count_i * N` and gold `NeedGold * N`.
- [ ] Test: buy and compose with insufficient diamonds fails without side effects.
- [ ] Test: Types 5 keeps random skills, mould and strengthen of the source.
- [ ] Test: mould success / failure blessing progression and max grade stop.
