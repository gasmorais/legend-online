# Items, equipment, fashion, mounts, Einherjar, Guardians, goddesses, vehicles, artifacts, titles and VIP (Legend Online BR)

This document covers the item template (`ItemTempInfos`), equipment progression (enhancement, moulding, gems, sets, forge, conversion, decomposition), the mapping from items to avatar layers, and the systems built on items: fashion, mounts, Einherjar (pets), Guardians (children) and Protection Spirits, goddesses, the Ancient Divine Weapon and crests, vehicles, titles, VIP, the Theseus Collection and several smaller systems. It does not repeat the avatar `.bswf` format, z-order or animation labels. The machine-readable companion is [data/research/items_avatar.json](../../data/research/items_avatar.json) (68 enums, 657 fields, 178 item categories, 10 avatar layers, 39 formulas).

**Conventions**
- Paths are relative to the project root. `CM/` = `decompiled/core_module/scripts/`; `mN/` = `decompiled/mN/scripts/`.
- **Data:** `data/tpl/tempinfos/<Set>.xml`. **Strings:** `index/language.json`. **Resources:** `index/manifest_res.json` (partial).
- *(assumption)* = not confirmed in code.
- **Avatar `.bswf` format, z-order and animation labels:** [docs/client/graphics.md](../../docs/client/graphics.md) §1-2 (not repeated here).
- **Loader rule:** `CM/yishi/datas/templates/cate/TemplateCate.as:21` (createNode) calls `CM/yishi/utils/ClassFactory.as:79` (hasOwnProperty).
  - The client ignores an XML attribute that has no matching AS3 class field; only the server uses it.
  - Examples: `ArtifactTemplateInfos.*Conv`, `GoddessTemplateInfos.BattlePic`, `KingContracts.CanAdd`, `VipDrop.ValidDate`, `ComposeTempInfos.IsLearn`.
- **Related docs:** [units_combat.md](../../docs/mechanics/units_combat.md), [skills_buffs.md](../../docs/mechanics/skills_buffs.md), [world_progression.md](../../docs/mechanics/world_progression.md), [README.md](../../docs/mechanics/README.md).

## Contents

- [1. Item template (`ItemTempInfos`)](#1-item-template-itemtempinfos)
  - [1.1 Item categories (`MasterType` and `SonType`)](#11-item-categories-mastertype-and-sontype)
  - [1.2 Generic fields `Property1..7` by category](#12-generic-fields-property17-by-category)
  - [1.3 Item opcodes (`SimpleItemInfoMsg`)](#13-item-opcodes-simpleiteminfomsg)
- [2. Equipment: enhancement, moulding, gems and sets](#2-equipment-enhancement-moulding-gems-and-sets)
  - [2.1 Enhancement (+N)](#21-enhancement-n)
  - [2.2 Moulding (mould)](#22-moulding-mould)
  - [2.3 Gems and score](#23-gems-and-score)
  - [2.4 Equipment sets (`SuiteTempInfos`, 244 sets)](#24-equipment-sets-suitetempinfos-244-sets)
  - [2.5 Forge recipes (`ComposeTempInfos`, 3340 recipes)](#25-forge-recipes-composetempinfos-3340-recipes)
  - [2.6 Gem conversion (`TransformInfos`, 60 groups)](#26-gem-conversion-transforminfos-60-groups)
  - [2.7 Decomposition (`ItemResolveTemplates`, 2600; `ItemResolveSortTemplates`, 14)](#27-decomposition-itemresolvetemplates-2600-itemresolvesorttemplates-14)
  - [2.8 Boxes (`BoxItems`)](#28-boxes-boxitems)
- [3. Avatar layers and item → resource mapping](#3-avatar-layers-and-item--resource-mapping)
- [4. Fashion](#4-fashion)
- [5. Mounts (`MountTempInfos`, 733)](#5-mounts-mounttempinfos-733)
  - [5.1 Dragon Tamer battle mount (`DragonTalkerFightMountTemplates`, 8)](#51-dragon-tamer-battle-mount-dragontalkerfightmounttemplates-8)
- [6. Einherjar (pets)](#6-einherjar-pets)
- [7. Guardians (children) and Protection Spirits](#7-guardians-children-and-protection-spirits)
- [8. Goddesses (`m5/goddess`)](#8-goddesses-m5goddess)
- [9. Ancient Divine Weapon and crests (`m11/ancientartifact`)](#9-ancient-divine-weapon-and-crests-m11ancientartifact)
- [10. Vehicles and Daimon (`m9/vehicle`, `m17`)](#10-vehicles-and-daimon-m9vehicle-m17)
- [11. Titles (`AppellInfos`, 951)](#11-titles-appellinfos-951)
- [12. VIP and first recharge](#12-vip-and-first-recharge)
- [13. Theseus Collection (`Collection*`)](#13-theseus-collection-collection)
- [14. Titan, Cat House, residence, marriage and King Contract](#14-titan-cat-house-residence-marriage-and-king-contract)
- [15. Main gaps and assumptions](#15-main-gaps-and-assumptions)

---

## 1. Item template (`ItemTempInfos`)

12 201 items. Class `CM/yishi/datas/templates/GoodsTemplateInfo.as` declares one `public var` per field (lines 14-124). Loaded at `CM/yishi/manager/TempleteManager.as:1146` (`goodsTemplateCate`).

**Key fields**

| Field | Meaning | Code |
|---|---|---|
| `TemplateId` | Id. **Negative ids are virtual currencies** (77 ids, SonType 200/208, list below) | - |
| `MasterType` / `SonType` | Category and subtype (§1.1) | - |
| `Sexs` | 0 = female, 1 = male, 2 = any. Resource paths use the same `{sex}` index (`0.bswf` = female) | `CM/yishi/datas/consant/SexType.as:17-21`, `CM/bag/datas/GoodsSonType.as:462` |
| `Job` | CSV of classes. 0 = all; 1 Guerreiro (Warrior); 2 Arqueiro (Archer); 3 Feiticeiro (Sorcerer); 4 Encantador de Dragões (Dragon Tamer); **99 = Dragon Tamer-only fashion/equipment** (`isDragonFashion`); 5..10 and 101..105 = Guardian JobType; 16, 17, 19... = monster type (accessory 232) | `CM/mvc/module/fashion/FashionModel.as:923`; `GoodsSonType.as:449` (isJobFix) |
| `NeedGrades` | Minimum level. 117/118 require a job transfer | `GoodsSonType.as:471`, `CM/bag/helper/GoodsCheck.as:203` |
| `NeedChangeJob` | 0 = none; 1 = 1st transfer; 2 = Avenger (vocationIndex ≥ 3); 5/127 only on fashion *(assumption: class mask)* | `CM/mvc/controler/StoreControler.as:703-738` |
| `Profile` | Quality (table below) | `CM/yishi/datas/goods/GoodsProfile.as` |
| `MaxCount` | Stack size: 1 / 99 / 999 / 9999 / 99999 / 1e7 / 1e8 | - |
| `Icon` | Path `icon{Icon}`, e.g. `icon/wing_abyssforger.png` | `GoodsTemplateInfo.as:135` |
| `SellGold` | NPC sell price | `GoodsCheck.as:369` |
| `StartingPrice` | Minimum unit price on the market/auction | `CM/cell/mediator/marketbag/MarketSellAlertFrame.as:143`, `m7/auction/view/sell/AuctionSellSubmitPane.as:168` |
| `IsCanBatch` | `"true"` = batch use (1550 items) | `CM/cell/mediator/playerbag/PlayerBagCellClickMediator.as:122` |
| `Feed` | > 0 = feeds the Marriage Tree | `m9/marry/income/MarryTreeFosterFrame.as:779` |
| `DefaultSkill` | CSV of fixed SkillTempInfos (below) | - |
| `Avata` | Graphic resource (§3) | - |
| `StrengthenMax` | Maximum +N enhancement. Values: 9, 12, 15, 18, 21, 24, 27, 30, 36, 45, 50, 60 | `CM/yishi/utils/StoreHelper.as:58` |
| `RandomSkillCount` | Number of random skills (instance `randomSkill1..5`, SkillPropertyTempInfos) | `CM/yishi/view/tips/goods/EquipTipsContent.as:828` |
| `SuiteId` | Set (§2.4) | - |
| `Refresh` | See below | - |
| `TransformId` | Gem/pearl: conversion group in TransformInfos. Fashion: grade S..D | `m14/store/SwitchView1.as:351`; `CM/yishi/view/tips/goods/FashionCardTip.as:241` |
| Stats | Power (Força), Agility (Proteção/Armadura), Intellect, Physique, Captain (Liderança), Attack, Defence, MagicAttack, MagicDefence, ForceHit (Crítico), StunAttr, Parry (Bloqueio), Penetrate, Live (Vida), Conat (soldier count), Strength, Tenacity, ReduceResi (anti-RES), Fire/Water/Elect/Wind/Dark/LightResi | pt-BR names: `PropertyName.*`, `TheseusCollenedBigItemUI.*` |

**`DefaultSkill`**
- **Fashion:** 6001 hat, 7001 weapon, 8001 clothes ("Fúria inicial mínima +5"); `5101,5001` wing ("Ataque +120 … Vida +1200" and "+2 %").
- The skill's `Grades` = the fashion's star count (`CM/cell/mediator/fashionbag/FashionBagCellDropMediator.as:192`).

**`Refresh`**
- On equipment: the TemplateId of the **Pedra da Purificação** (Purification Stone) that rerolls random skills:
  - 2127001..2127025;
  - 2272001..5 on Guardian equipment;
  - 6260001 on demonic armor.
- Also a decomposition flag: 0 = not decomposable, −1 = locked (fashion and mount).
- **Code:** `CM/yishi/manager/GoodsManager.as:1741`, `StoreControler.as:1185`.

**`Profile` (quality)**

| Profile | Letter | Name | Color |
|---|---|---|---|
| 1 | D | White ("Bruto") | #FFFFFF |
| 2 | C | Green | #59CD41 |
| 3 | B | Blue | #32A2F8 |
| 4 | A | Purple | #A838F7 |
| 5 | S | Orange | #FF8000 |
| 6 | - | Red #CE0F0F; "senior" (`isSeniorEquip`) | |
| 7 | - | Red; 3rd transfer (`isThreeEquip`) | |

**Sources:** `GoodsProfile.as:13-66`, `CM/yishi/utils/GoodsHelp.as:30-82`, `GoodsTemplateInfo.as:223-245`. **Data distribution:** 4 → 4897, 3 → 3581, 5 → 1443, 2 → 963, 6 → 851, 1 → 440, 7 → 26.

**Currencies (negative id)**
- −100 Ouro, −200 Ametistas, −300 Espírito, −400 Diamante, −500 Diamante vinculado, −600 Cristal de Luz, −700 Experiência, −800 Cristal da Glória, −1000 Emblema do Rei.
- −1600 Cristais de Vênus, −1700..−1709 album gifts (MasterType 7), −2000..−2600 Casa de Gato (Cat House) materials.
- −16000 Pó Mítico, −19000 Gema Poseidon...

### 1.1 Item categories (`MasterType` and `SonType`)

**`MasterType`**

| Value | Constant | Meaning |
|---|---|---|
| 1 | EQUIP | Equipment |
| 2 | PROP | Consumable/material |
| 3 | HONER | Medal |
| 4 | PET_CARD | Einherjar orbs and titan cards |
| 5 | PET_EQUIP | Einherjar equipment |
| 6 | CHILD_EQUIP | Guardian equipment |
| 7 | - | Virtual gifts *(assumption)* |
| 8 | - | Dragon Tamer talisman *(assumption)*; SonType 401-407 = `TALISMAN_SONTYPE_LIST`, `GoodsSonType.as:336` |
| 9 | AIRGARDEN_BED | Hanging Garden base |
| 10 | THESEUS | Theseus |
| 11 | TREASURE | Treasure |
| 15 | - | Theseus plate/Slate *(assumption)* |
| 256 | MONSTER_ACCESSORIE | Monster accessory |

**Source:** `CM/yishi/datas/consant/GoodsType.as`.

**`SonType`:** constants in `CM/bag/datas/GoodsSonType.as:10-336`, pt-BR name in `getSonTypeName` (:343), slot in `getSonTypePos` (:404). Main values:

- **Hero equipment (MasterType 1)**
  - **Types:** 101 weapon, 103 helmet, 104 armor, 106 necklace, 107 ring, 108 ornament, 117 crest (brasão), 118 relic.
  - **Slots (bagType 4):** 101 → 0, 103 → 1, 104 → 2, 106 → 3, 107 → 4/5, 108 → 6/7, 117 → 12, 118 → 13.
  - 102 assistant and 105 cloak exist only as constants.
- **Fashion (`isFashion`, `GoodsCheck.as:418`)**
  - 109 Wings → slot 8 (411 items); 110 Hat → 9 (436); 112 Clothes → 10 (437); 111 Weapon → 11 (413).
  - `EQUIP_SONTYPE_LIST = [101..109]`.
- **Einherjar and Guardian**
  - **Einherjar equipment (MasterType 5):** 113 Earring (pos 0, 1), 114 Belt (2), 115 Accessory (3, 4), 116 Artifact (5).
  - **Guardian equipment (MasterType 6):** 611, 613, 614, 616, 617, 618.
- **Gems**
  - **205 = single gem.** The constant is named `SONTYPE_MOUNT`, but the code treats it as a gem: `CM/cell/mediator/storebag/StoreBagCellClickMediator.as:350`. 96 items.
  - 228 = double gem (`SONTYPE_MOUNT2`); 204 = Gema da Sorte (Luck Gem); 312 = anti-resistance crystal.
  - **Einherjar:** 329, 343, 344 (Alma Divina). **Guardian:** 224 (Ágata).
- **Mount:** 218 mount card (721 items), 290 Pedra Bestial (food/training), 299 Perfurador, 2180 multi-card.
- The full labeled list is in `item_categories` and `enums.item_son_type` (≈ 180 codes) in the JSON.

### 1.2 Generic fields `Property1..7` by category

The 7 generic fields change meaning per SonType.

**Equipment 101-108, 117, 118**
- `P1` = gem socket count (1-3). The tip creates `_inlayItem1..N` (`EquipTipsContent.as:619`).
- `P7` = 11102..11306 *(assumption: refine/skill group)*.

**Einherjar equipment (113-116) and Guardian equipment (611-618)**
- `P1` = socket count.
- `P7` = SkillTempInfos.TemplateId of the equipment skill (4031001..., 22701...).

**Fashion (109-112)**
- `P1` = identification book cost (`getCountForIdentityBook`): 1 000 000 / 800 000 / 600 000.
- `P2` = refresh quantity: 1..5.
- `P4` = grade text style: 0 → frame 3, 2 → frame 2, other → frame 1 (`FashionModel.as:775`).
- `P5` = 1 allows exchange (`CM/cell/view/fashionbag/FashionBag.as:156`).
- `P6` = 100; `P7` = −1 *(assumption)*.

**Gems**
- **205:** `P1` = stat type (1 Attack, 2 Defense, 3 Magic, 4 Resistance, 5 Crit, 6 HP, 7 Leadership, 8 Block), `P3` = 200..10000 *(assumption: cost)*, `P6` = level 1..12.
  - E.g. 2050101 "Gema de Ataque Nv. 1" (Attack 32) ... Nv. 12 (Attack 780).
- **228:** `P1` and `P2` = the two types; `P5` and `P6` = component gems.
  - E.g. 2281507 = 2050107 + 2050507 (Attack 168, ForceHit 108).
- **Socket rule:** at most 2 gems of the same type per piece (`StoreBagCellClickMediator.as:362-430`).

**Items that point to other templates**

| SonType | P1 points to | Other fields |
|---|---|---|
| 218 (mount card) | MountTempInfos.TemplateId | P2 = days (≤ 0 = permanent); P3 = required mount level (`CM/managers/MountsManager.as:370-380`, `CM/yishi/view/tips/goods/MountCardTip.as:390-422`) |
| 306 | PetTempInfos.TemplateId | - |
| 221 | AppellInfos.TemplateId | - |
| 607 | ChildTempInfos.JobType | - |
| 625 | ArtifactTemplateInfos.TemplateId | - |
| 626 | ArftiArmoryTemplateInfos.TemplateId | - |
| 303 | SkillTempInfos (Einherjar skill) | - |
| 2002 | Fragment id (TemplateId×1000) | - |

**Chests and utilities**
- **311 (paid chest):** `P2` = currency (−400 Diamante, −800 Glória), `P3` = cost per opening (`PlayerBagCellClickMediator.as:123-135`).
- **203 (utility):** `P1` = subtype. 13 = king contract card (`GoodsCheck.as:410`).

### 1.3 Item opcodes (`SimpleItemInfoMsg`)

Instance message: `SimpleItemInfoMsg` (`proto.json`), with fields id, template_id, pos, bag_type, bind, valid_date, count, strengthen_grade, join_1..4 (gems), random_skill_1..5, property1, mould_grade, appraisal_skill, is_locked, desc_templateId.

| Opcode | Name |
|---|---|
| 5005 | U_C_BAG_MOVE |
| 5006 | USEITEM |
| 5007 | SELL |
| 5008 | U_C_HERO_UPDATE_EQUIPMENT |
| 5150 | U_C_ITEM_STRENGTHEN |
| 5151 | U_C_ITEM_INLAY |
| 5152 | INLAYJOIN |
| 5153 | U_C_ITEM_COMPOSE |
| 8336 / 8339 / 8464 | Random skill refresh |
| 8340 | C_ITEM_RESOLVE |
| 8538 | C_ITEM_TRANSFORM |
| 8644 | C_MOULD_ITEM |
| 9592 | C_EQUIPMENT_REFINING |
| 9741 | C_GEM_ONE_KEY_COMPOSE |
| 8199 | C_BAG_EQUIPLOOK |

**Responses:** 56-59, 86-89, 149 (U_C_HERO_BROAD_EQUIPMENT), 339.

---

## 2. Equipment: enhancement, moulding, gems and sets

### 2.1 Enhancement (+N)
- **Per-stat bonus:** `int(base*N*0.1) + N*5` (`GoodsHelp.as:129`). Cap: StrengthenMax.
- **Gold from N to N+1** (`GoodsCheck.as:326`), with NG = NeedGrades and P = Profile:
  - NG ≥ 80: `(floor(NG/10)+1)² × (P ≥ 6 ? P+2 : P) × (N+1)^2.1 × 10`;
  - otherwise: `1.5^(int(NG/10)+1) × (P+1) × (N+1)^2.2 × 5 + 500`.
- **Guardian:** gold `2000×P×(N+3)^2.2`, bonus `int(base×N×0.05)` (`GoodsHelp.as:164`).
- **Einherjar:** bonus `1.08^N×base − base` (`GoodsHelp.as:155`).
- Gema da Sorte (204) adds P1 % success.

### 2.2 Moulding (mould)
- Applies to equipment with Profile ≥ 5, NeedGrades ≥ 50 and StrengthenMax > 0.
- `mouldGrade` → rank `(g−1)/10+1`, star `g%10` (0 → 10) (`CM/yishi/datas/goods/GoodsInfo.as:125`).
- **Maximum grade:** 80 normal, 160 senior, 160/240 on 3rd transfer (`GoodsInfo.as:286`).
- **Per-stat bonus:**
  - g ≤ 80: `int(b×g×0.3)`;
  - up to 160: `+int(b×(g−80)×0.4)`;
  - above: `+int(b×(g−160)×0.25)` (`GoodsHelp.as:138`).
- **Gold per step:** `k×(8+star')³`, k = 500 / 1000 / 2000 per grade band (`GoodsCheck.as:339`).
- **Materials:** 2120100 "Martelo do Vulcan" and 2120101 "Forno do Vulcan" (< 80) → 2120102/3 (80-159) → 2120106/7 (`GoodsInfo.as:182`).
- **Quantity per step:** 5/15 → 15 → 25 → 40 → 60 (`GoodsInfo.as:303`).

### 2.3 Gems and score
- The hero's jewelry level multiplies each socketed gem's bonus (own player only):
  - eff% = 2g (g ≤ 50); `(g−50)×3+100` (≤ 70); `(g−70)×4+160` (≤ 80); senior adds +200 (`GoodsHelp.as:85-117`).
- **Equipment power** (`GoodsCheck.as:473`): `Atk + MAtk×1.05 + Def + MDef + Parry + Crit + Conat + Live/5 + Agility×8`.
  - Each term already includes enhancement, moulding, gems (join1..4) and randomSkill1..5.
- **Base score** (`GoodsInfo.as:405`): `Atk+Def+MAtk+MDef+Crit+int(Live/5)+Conat+(Power+Agility+Intellect)×4+(Captain+Physique)×2` + skill score.

### 2.4 Equipment sets (`SuiteTempInfos`, 244 sets)
- Class `CM/yishi/datas/templates/SuiteTempInfo.as`; tip in `EquipTipsContent.as:940-1000`.
- `Template1..8` = pieces (ItemTempInfos). `Template1s..8s` = alternate variant of the same piece (e.g. the [Ω] version), which also counts.
- `PropertyN` = SkillTempInfos.TemplateId activated with ≥ N pieces (0 = no bonus).
- Examples:
  - suite 100 "Julgamento Divino" = 1080215 + 1080225, Property2 = 1222 ("Diminui probabilidade de sofrer ataque crítico em 5%");
  - suite 316: Template1 = 1996217, Template1s = 1896217;
  - suites 606-611 = Arsenal crests (Property = 6261011...).

### 2.5 Forge recipes (`ComposeTempInfos`, 3340 recipes)
- Class `CM/yishi/datas/templates/ComposeGoodsTemplete.as`. Material1..4 + Count1..4 → NewMaterial × Counts; cost NeedGold; level NeedMinLevel.
- **Types** (`StoreControler.as:167-190`, `CM/mvc/module/store/StoreModel.as:282-410`):

| Types | Meaning |
|---|---|
| 1 | Equipment |
| 2 | Material |
| 3, 6, 8, 12 | Gems (jewelGrade) |
| 5 | [Ω] upgrade |
| 9 | Einherjar equipment |
| 11 | Guardian equipment (480 recipes) |
| 13, 17, 18, 19, 20 | Equipment by band/3rd transfer/divine weapon |
| 16, 104, 111-146 | Avenger (demonic armor) |
| 201-209 | Theseus, 9 elements |
| 301-309, 351-369 | Alma da Guerra (War Soul) |

- Examples:
  - id 25: 2 × "Gema da Sorte Nv.1" + 200 gold → Nv.2;
  - id 195: "Determinação Eterna" + 150 × "Pedra Legendária nv.70" + 1.5 M → [Ω].

### 2.6 Gem conversion (`TransformInfos`, 60 groups)
- `TransformId` groups the 8 gems of the same level (group 1 = Attack/Defense/Magic/Resistance/Crit/HP/Leadership/Block Nv.1, 10 000 gold) and the dragon pearls (groups 301-312, 2.56 M gold).
- **Cost:** `CostGold × qty × VIP discount` (type 202: 90 % → 50 %), in `m14/store/SwitchView1.as:351,485`.
- **Opcode:** `8538 C_ITEM_TRANSFORM`.

### 2.7 Decomposition (`ItemResolveTemplates`, 2600; `ItemResolveSortTemplates`, 14)
- Key `Type_ResolvedItem` (`CM/yishi/datas/templates/cate/ResolveTemplateCate.as:19`). Items obtained = `count × Count_i`.
- **Type:**

| Type | Decomposes | Result | Opcode |
|---|---|---|---|
| 1 | Avenger (670) | 6920001 "Pedra de esculpir" + 6930001/6940001/fragment | 8657 op 8 |
| 2 | Estrada Demoníaca | 6930001 → −16000 × 5 | - |
| 3 | Theseus (720) | 7300001, −19000 | 8684 op 4 |
| 4 | Treasure (750/751) | 2127022 | 8683 C_NEW_ITEM_RESOLVE |
| 5 | Collection fragment | → 20000000 Metal Divino × 2 | 8681 |

- Generic equipment and fashion decomposition uses `8340 C_ITEM_RESOLVE`. It requires `Refresh ≠ 0` and `≠ −1`, and the hero must not be wearing the item (`StoreControler.as:1171-1200`).
- **`ItemResolveSortTemplates`** = "batch decompose" filters:
  - `Sontype` 670: `Propety1` = Profile;
  - `Sontype` 720: `Propety1` = element 1 Água ... 9 Celeste;
  - `Propety2` = maximum level; `Color` = 0xRRGGBB (`m14/store/resolve/AllResolvePopFrame.as:157-256`).

### 2.8 Boxes (`BoxItems`)
- The XML is empty in this version.
- Class `CM/yishi/datas/templates/BoxItemTemplate.as`: TemplateId, Count, Param1, Param2. The cate groups by attribute `@Times` (`cate/BoxItemTemplateCate.as:19-53`).
- No caller outside TempleteManager.

---

## 3. Avatar layers and item → resource mapping

Format, z-order and labels: [docs/client/graphics.md](../../docs/client/graphics.md). This section covers **which item feeds which layer**.

**`ThaneInfo` state** (`CM/yishi/datas/playerinfo/ThaneInfo.as:222-835`)
- **Fields:** `bodyEquipAvata`, `bodyFashionAvata`, `armsEquipAvata`, `armsFashionAvata`, `hairEquipAvata`, `hairFashionAvata`, `cloakAvata`, `wingAvata`, `mountAvata`, `hideFashion`.
- The getters `bodyAvata`, `armsAvata` and `hairAvata` return the fashion value if `!hideFashion && fashion != ""`, otherwise the equipment value.
- `wingAvata` returns "" if `hideFashion`.
- **Network:** `AvaterMsg` {arm_tempId, cloth_tempId, fashion_armTempId, fashion_clothTempId, fashion_wingTempId, fashion_headTempId} → template `.Avata` (`CM/managers/ChallengeManager.as:160-197`).
- **Hide fashion:** `HeroHideFashionReqMsg`.

**Map assembly** (`m3/map/outercity/view/mapphysics/ArmyView.as:985-1140`; the same logic exists in Campaign, Space, GameHall, SecretAd, HeroHunter)
1. Body = `bodyEquipAvata`, or the default `/{warrior|hunter|wizard}_default_body` (`JobType.as:60-130`).
2. Weapon = `armsEquipAvata`, or `..._default_arms`. Hair, cloak and lower hair = class defaults (dragonic if the body contains `/dragonic`).
3. If fashion is not hidden:
   - fashion clothes replace the body and **remove the cloak**; the resource type becomes 2;
   - the fashion weapon replaces `army`;
   - the fashion hat becomes `hairUp = Avata+"up"` and `hairDown = Avata+"down"`.
4. Mounted with `IsStand == 0`: every part gets the suffix `_mount` (`JobType.getMapMountEquipment`, `JobType.as:123`).
5. Wings (`wingAvata`) replace the cloak.
6. The mount is the `mount` layer.
7. `changeShapeId > 0` (transformation): body only, from `swf/npc/{id}.bswf`.

**URL** (`CM/yishi/manager/PathManager.as:377-430`)
- type 1 (equipment): `swf/avatar{res}/{sex}.bswf`;
- type 2 (fashion) and wing: `swf/avatar{res}/{job}_{sex}.bswf` (dragonic → `4_{sex}`);
- mount and Einherjar: `swf/avatar{res}/2.bswf`.

| Layer | Source item | Map | Battle (`HeroLoadDataFactory.as:46-254`) | UI (`ShowAvatar.as:180-300`) |
|---|---|---|---|---|
| body | 104 / 112 | `swf/avatar/warrior_body081/0.bswf`; `swf/avatar/fashion_cloth_abyssforger/2_1.bswf`; mounted `..._abyssforger_mount/1_0.bswf` | `equip{A}/{sex}.swf` or `equip/fashion_cloth_abyssforger/{job}_{sex}.swf` | `equip_show/warrior_body081/0.swf`; `equip_show/fashion_cloth_abyssforger/1_0.swf` |
| arms | 101 / 111 | `swf/avatar/warrior_arms081/1.bswf`; `swf/avatar/fashion_weapon_abyssforger/3_0.bswf` | `equip/fashion_weapon_abyssforger/1_0.swf` (arms = ClassExport, arms2 = ClassExport2) | `equip_show/fashion_weapon_abyssforger/2_1.swf` |
| hairUp / hairDown | 110 | `swf/avatar/fashion_hat_abyssforgerup/1_0.bswf` (+ `...down`) | **one** SWF `equip/fashion_hat_abyssforger/{job}_{sex}.swf` with hair1..hair4 = ClassExport1..4 | `equip_show/fashion_hat_abyssforger/front/1_0.swf` and `/back/` |
| cloak | Body's default cloak | Default `..._default_body_cloak` | `equip{bodyAvata}_cloak/{sex}.swf` (e.g. `equip/fashion_cloth_span_cloak/1.swf`) | `equip_show{bodyAvata}_cloak/front\|back/{sex}.swf` |
| wing | 109 | `swf/avatar/wing_abyssforger/1_0.bswf` | `equip/wing_abyssforger/1_0.swf` (cloak1/cloak2) | `equip_show/wing_abyssforger/1_0.swf` |
| mount | MountTempInfos.AvatarPath | `swf/avatar/mount_abyssicedragon/2.bswf` | Dragon Tamer only: `equip/dragonic/mount_dragon_lv1/2.swf` | `equip_show/mount_abyssicedragon/2.swf` |
| pet | PetTempInfos.PetAvatar | `swf/avatar/pet_thor/2.bswf` | `equip/pet_scarlet_odin/2.swf`; follower `equip/pet_scarlet_odin_follow/2.swf` | `equip_show{PetAvatar}/2.swf` |
| child | ChildTempInfos.ResPath | - | `equip/hychild/bloodwarrior01/2.swf` | `equip_show/hychild/bloodwarrior01/2.swf` |

**Table notes**
- In the UI, Archer and Dragon Tamer swap the body/arms order. With wings, frontCloak and backCloak are empty.
- **Manifest counts:**
  - `swf/avatar/fashion_cloth*` 3580, `fashion_hat*` 4189, `wing*` 3564, `mount*` 609;
  - `equip/fashion_*` ≈ 1770 each, `equip_show/mount*` 574.
- **Dragonic:** `swf/avatar/dragonic/fashion_cloth_dragon_amberdream_mount/4_0.bswf` and `equip_show/dragonic/fashion_cloth_dragon_*/4_{sex}.swf`.
- Job 99 fashion (Dragon Tamer) goes to `DragonFashionMsg` {dragonWingAvata, dragonHatAvata, dragonArmAvata, dragonClothAvata}.

---

## 4. Fashion

Cosmetic appearance with stat bonuses. 4 parts (109 wing, 110 hat, 111 weapon, 112 clothes), all MasterType 1. Fashion items (`FashionModel.as:617-646`): Profile 4 (almost all), Sexs 2, Job 0 or 99.

**Sources**
- **Fashion shop:** `8592 C_FASHION_SHOP_BUY` (`FashionShopMsg`) and `m14/fashion/FashionStoreFrame.as`.
- **Compose:** `8594 C_FASHION_COMPOSE`.
- **Exchange:** `8595 C_FASHION_SWITCH` / `9582 C_FASHION_EXCHANGE`, using Alma da Moda 208020 (SonType 278) and Amuleto da Sorte 208021.
- **Fashion/mount lottery:** 9613.
- **Events:** the source is shown in `Description`.

**Stats**
- **Fashion level** (`FashionInfoMsg.gp/grades`) → UpGradeTempInfos Types = 113 (200 levels).
  - `TemplateName` = "skillProp1,skillProp2"; the 2nd is the base SkillPropertyTempInfos (`FashionModel.as:1188-1197`).
  - E.g. level 1 = "40801001,40802001", Data 300 (EXP).
- **Object skill:** each fashion has a `DefaultSkill`; `Grades` = stars.
- **Identification (appraisal):** `8781 C_FASHION_APPLRAISAL`, `INDENTITY_OPEN_GRADE = 27`:
  - rolls `appraisal_skill` (SkillPropertyTempInfos; Power/Agility/Intellect/Physique summed in `getIdentityedProperties`);
  - "full" when the skill has Grades = 5;
  - cost `Property1` (`FashionModel.as:988-1045`); rate per grade `[100,100,100,100,100,100][TransformId]`.
- **Grade** S/A/B/C/D = TransformId 1..5. **Data:** 1 → 1436, 2 → 128, 3 → 104, 4 → 23, 5 → 7.
- **Fashion book:** `FashionBook` {temp_id, is_switch, appraisal_skill} = the collection of obtained fashions per part (`getBookNum`).

**Polish (`FashionPolishs`, 404 = 4 parts × levels 0..100)**
- `9635 C_FASHION_POLISH_OP`, `FashionPolishRequestMsg` {op, sontype, count}. Response `408 U_C_FASHION_POLISH_LIST` (`PolishInfoMsg` {sontype, level, exp}).
- **EXP per level:** wing 25 × level, higher from level 11 on (level 10 = 250, 20 = 1750, 50 = 25 000); other parts 5 × (level 10 = 50, 50 = 5000).
- **LevelAdd = level × 10 %** of the fashion's base stat, per part (`FashionModel.as:1178-1245`):
  - wing → Atk, MAtk, Def, MDef, HP;
  - hat → HP;
  - clothes → Def + MDef;
  - weapon → Atk + MAtk.
- **SpAdd** (2, 4 ... 20, every 10 levels) = Fury, by the lowest level among the 4 parts (template 109).
- **AppraisalAdd** (10 ... 100 %) unlocks when the part's book has ≥ NeedCount fashions (5 ... 50) (`FashionModel.as:1263`).
- **OtherLevel** = 10 at levels 11, 21... *(assumption: gate for the other parts; not read by the client)*.

**Opcodes:** `8625 C_FASHION_INFO` / `301 U_C_FASHION_INFO`, `4542 U_C_FASHION_BOOK`, `8631 C_FASHION_SPECIAL`.

---

## 5. Mounts (`MountTempInfos`, 733)

Collectible mount appearances ("almas selvagens", wild souls).
- Each activated appearance grants stats and "Ponto Bestial". One appearance is the active mount: it sets map speed and the visual.
- Class `CM/yishi/datas/templates/MountTemplate.as`; resolved at `TempleteManager.as:1442`; UI `m14/mounts/*`; models `CM/mvc/module/mounts/*`.

**Fields**

| Field | Meaning | Code |
|---|---|---|
| `MountType` | See the table below | `CM/mvc/module/mounts/MountType.as` |
| `Area` | Collection tab (0 Normal 8, 1 Mágica 350, 2 Doméstica 194, 3 Feras 110, 4 Tecnologia 71); icon frame Area+1 | `MountAreaType.as`, `WildSoulCollection.as:77` |
| `Power` / `Intellect` / `Physique` / `Agility` | Força / Inteligência / Físico / Proteção gained on activation (10..300) | `MountCardTip.as:394` (`mounts.WildsoulItem.tips01`) |
| `ExpandLevel` | "Nível máximo de atributos +N" (5 / 10 / 20 / 60) for training | `MountCardTip.as:394` |
| `Speed` | Only MountType 1 adds to speed. Formula: `speedAdd = 20 + ceil(grade/2)×10 (+Speed)` | `MountInfo.as:44` |
| `NeedItemId` | Activating 218 card (2180001 "Carta do Olho Escarlate" → 1001) | - |
| `Property1` | Diamonds to unlock without a card (1198/1398; ≤ 0 = impossible) | `m14/mounts/WildSoulFrame.as:554-575` |
| `Property2` | MountType 0: required level "Nv. {0}" | `m14/mounts/WildSoulItem.as:291` |
| `SoulScore` | "Ponto Bestial +N" (50..500), added to the ranking | `MountCardTip.as:411` |
| `StarAddition` / `GradeType` | See "Stars" below | - |
| `IsFly` | 1 = flies: pathfinding ignores obstacles on the space map; also available via flight purchase op 13 (364 mounts) | `CM/map/space/SpaceModel.as:169`, `CM/map/internals/findPath/FindPath8.as:192` |
| `IsStand` | 1 = rider in standing pose, **no** `_mount` suffix (76 mounts) | `MountTemplate.as:136` |
| `AvatarPath` | `"/x"` or `"/x\|wing"` (the 2nd term is also the `mountWing` layer) | `MountTemplate.as:84` |
| `Sort` | Order | - |
| `NeedMountGrade`, `NeedTimeItemId` | Always 0 | - |

**`MountType`**

| Value | Meaning |
|---|---|
| 0 | Base form by level (8 forms: Cavalo Branco 1000 ... `/mount_SKhorse_green` 2001) |
| 1 | Collectible (713) |
| 2 | Hidden/special (`_spMountTemplateList`) |
| 3 | VIP (requires VIP; no stars) |
| 4 | Contract/king mount (level ≥ 70; no stars) |
| 5 | 1 record *(assumption)* |

**Mount level**
- UpGradeTempInfos Types = 19: Data = cumulative EXP, ActiveObject = unlocked base form.
- Grade 2 at 13 000 EXP unlocks 1006; grade 3 at 64 000 unlocks 2001 ... grade 8 at 740 000 (`MountInfo.as:74`).

**Stat training (taming)**
- Força, Inteligência, Vigor, Armadura. UpGrade table Types = 18 (2500 grades, up to 6 163 750 gp).
- **Cost:** 10 diamonds or 1 Pedra Bestial 208017 (`DomesticatePayType`; `mounts.command05`). Chance of "bênção do Deus das Feras" (EXP × 5).
- **Grade cap** = server `levelMax` + ExpandLevel.

**Stars**
- StarAddition = CSV of % per star (643 mounts have "10,20,30,40,50"). The entry count = maximum stars.
- GradeType = UpGrade Types = 37 group (blessing/cost per star) (`m14/mounts/MountsPromotionView.as:489-547`; `CM/mvc/module/mounts/WildSoulInfo.as:41-73`).

**Soul refine:** UpGrade Types 144 (% per property, ActiveObject) and 145 (skill by the sum of the 4 grades) (`MountRefiningSoulInfo.as`).

**Map animation**
- `swf/avatar{AvatarPath}/2.bswf`. The `.bswf` header has `offsetY`, which shifts the rider (`m3/avatar/view/HeroAvatar.as:784-841`).
- The header also has `flight`, the flight height applied to `contentBitmap.y` (`HeroAvatar.as:298-302,879-890`).
- When mounted without IsStand, the hero uses `*_mount` parts (7873 `_mount/` resources in the manifest).
- **Feet with effect:** TemplateId 3008 (`hasEffectFoot`).

**Opcodes**
- `8529 C_MOUNT_OP` (`MountEditMsg` {op, property_type, pay_type, param1, param2}). Ops 1-13 in `MountsOpType.as`: train, swap, appearance, activate, ride, king, shop, refine, buy flight.
- `8530 C_MOUNT_AVATARLIST`, `8567 C_MOUNT_INFO_SEND`.
- **Responses:** `4426 U_C_MOUNT_UPDATE`, 4427 AVATARLIST (`MountAvatarMsg`), `4679 U_C_MOUNT_UPGRADESTAR`, 4973/4974 king, 4975 shop, `4610 U_C_VIPMOUNT_STATE`.

**Example:** 8450 "Dragão de Gelo Abissal": 300 in each stat, ExpandLevel 5, Area 3, StarAddition 10..50, resources `swf/avatar/mount_abyssicedragon/2.bswf`, `equip_show/mount_abyssicedragon/2.swf`, `icon/mount_abyssicedragon.png`.

### 5.1 Dragon Tamer battle mount (`DragonTalkerFightMountTemplates`, 8)
- Grade 1..8 (upgrade: UpGrade type 140). Power/Agility/Intellect/Physique (lv8 = 10670/15010/10670/10530). HitPoint 1..5 = starting attack points.
- **Selection:** 9667 op 9 (`CM/managers/DragonTalkerManager.as:317`).
- **Resources:**
  - battle `equip/dragonic{AvatarPath}/2.swf`, e.g. `equip/dragonic/mount_dragon_lv1/2.swf`;
  - preview `equip_show/dragonic/mount_dragon_lv8/2.swf` (`CM/yishi/utils/MountAvatarPathHelper.as:18-25`, `HeroLoadDataFactory.as:232-237`);
  - lv3-7 are missing from the manifest.

---

## 6. Einherjar (pets)

**`PetTempInfos` (108)**
- **Id:** `TemplateId = PetType×1000 + (SonType%100)×100 + Quality` (101101 = Amazona Q1).
- **PetType (element):** 101 Fire, 102 Water, 103 Shock, 104 Wind, 105 Dark, 106 Light; dual forms 117 Light/Dark, 118 Wind/Water, 119 Fire/Shock (`CM/mvc/module/pet/PetData.as:1673`).
- **Quality** 1..6 = white...red. Internally temQuality is 1..31; q1-q4 have 5 stars, q5 has 10, 31 = q6.
- **NeedGrade** 1/2/3 = low/mid/advanced class; selects upgrade table 27/29/107.
- **Aptitudes** `*Apt` = `"min,max"` (e.g. Amazona PowerApt "1179,2625").
- **GrowthRate:** 615..3223. MaxHp and resistances are fixed.
- **Skills** (→ SkillTempInfos): DefaultSkills = basic attack. FollowSkills/ChangeSkills = follower/transformation (the client uses those from PetInfoMsg).
- **Property1** = 1: large model, centered (`CM/avatar/view/ShowPetAvatar.as:127`).
- **Property2** = 1: special Escarlate/Crepúsculo (Scarlet/Twilight) form.

**Formulas** (`PetData.as`)
- **Aptitude cap per star:** `A.X + int((B.X−A.X)/steps)×(star−1)`, where A = the quality's template, B = the next one, steps = 5 (10 in q5).
  - E.g. Amazona temQ 3: 2625 + int(524/5)×2 = 2833.
- **Base stat:** `Base + floor((level−1)×growthRate/80)`; +5 free points per level; maximum level 80.
- **Combat:**
  - Atk = `floor(Força×1.8×coe/1000)`;
  - Def = `floor((Prot×0.9×coeP + Força×0.9×coeF)/1000)`;
  - HP = `floor(6×Físico×coe/1000) + MaxHp`;
  - power = `int(700 + MA + MD + A + D + HP/5)`.

**Divine refine and fusion (`PetComponseInfos`, 34)**
- `Pet2Types = 0` → single-Einherjar compose. ≠ 0 → fusion (requires quality ≥ 5).
- E.g. id 1 = Fire, class 1, Q4 + 10 × 2125051 "Lágrima Estrelar - Fogo" + 1000 × 2125057 "Areia Estrelar" + 5 M gold → class 2, Q4.
- NeedPoint = diamonds (60 000 default; zeroed with 211002 "Alma da Fusão").

**Divine weapon contract (`PetContracTempInfos`, 168)**
- Levels 0..6 per SonType. **Cost:** 208062 × 15..225.
- **PropertyType:** 0 Attack (becomes Magic for the sorcerer), 7 Defense, 9 Resistance, 10 HP.
- PrePetSonTypes = prerequisite contracts at max; LineIndex 1..8 = position in the diagram.

**Divine Weapon, Arma Divina (`PetHallowsTempInfos`, 297)**
- HallowType 1 Light/Dark, 2 Wind/Water, 3 Fire/Shock. Levels 1..99.
- **Feeding:** 208063 × NeedItemCount1. **Breakthrough** every 10 levels: 208064 × NeedItemCount2.
- PropertyDatas = "Atk, Def, MDef, HP, resistanceA, resistanceB". E.g. level 10 = "5200,5200,5200,31200,1040,1040".
- **Inscription:** `+floor(v × UpGrade127.ActiveObject/100)`.

**Einherjar arena (`PetChallengeRewards`, 60)**
- Ranking `"group|pos"` or `"group|min,max"`. **Groups:** 2 Diamantes, 3 Ouro Branco, 4 Ouro, 5 Prata, 6 Bronze.
- RewardType 1 item (2 buff and 3 title are synthesized by the client).

**Expedition (`RemotePetTempInfos`, 120)**
- 100 checkpoints (Type 1) + 20 special (Type 2).
- Property = element 1..6. Skill = expedition skill.
- Drops use the inverted format `"id|qty,id|qty"`.

**Resources:** `equip/pet_thor/2.swf`, `equip/pet_tyr_follow/2.swf`, `equip_show/activity/pet_amazon/2.swf`, `swf/avatar/pet_scarlet_odin/2.bswf`.

**Opcodes**
- **Einherjar:** `8621 C_PLAYER_PET_OP`, `4540 U_C_PLAYER_PETINFO` (`PetInfoMsg`).
- **Divine weapon and contract:** `9627 C_PETHALLOW_OP` (op 1 contract, 2 level weapon, 4 query, 5 inscription) / 388.
- **Arena:** 8724-8728. **Expedition:** 9544 / 4964-4967.

---

## 7. Guardians (children) and Protection Spirits

**`ChildTempInfos` (180 = 15 JobType × 12 grades)**
- **Regular (MasterType 0):** 1 Cavaleiro Sagrado, 2 Caçador do Santuário, 3 Sacerdote do Combate, 4 Feiticeiro da Condenação, 5 Guerreiro do Vento, 6 Combate Sangrento, 7 Leopardo das Neves, 8 Coelho Voador, 9 Anão de Gelo, 10 Diabo Charmoso.
- **Spirits (MasterType 1):** 101 Mensageiro da Alma ... 105 Gladiador da Águia.
- **Stats** Attack/MagicAttack/Defence/MagicDefence/Live = **% inherited** from the hero's total.
  - E.g. Cavaleiro grade 1 Attack 65 %, Live 30 %; grade 12: 87 % and 88 % (`m14/child/attribute/ChildUpgradeGrowthView.as:223`).
- Resistances are absolute.
- SkillMasterType 41..57 = class skills.
- **Summon:** CallNeedItems `"6190002,5"` + CallTotalGrowth (op 26).
- **Resources:**
  - `equip/hychild{ResPath}/2.swf` (200 in the manifest, e.g. `equip/hychild/hobbit05/2.swf`);
  - icon `icon/hychild/xlsz.png`;
  - Spirit artifact `swf/avatar/hychild/weapon/child_weapon_1.swf`.

**Other templates**
- **Soul awakening 1..5 (`ChildTypeTempInfos`, 50).**
  - **Inheritance:** 45 → 85 %.
  - **Cost:** 6200001 × 5..100, a required soldier (`NeedArmyPawnTempIds`) and trait level (`NeedSpecialsTempId`, a level, not an id).
- **Spirit composition (`ChildComposeTempInfos`, 5).**
  - 101 ← Guardians 1 + 3; 102 ← 2 + 4; 103 ← 5 + 6; 104 ← 7 + 8; 105 ← 9 + 10.
  - Requires 212000 × 3000 + 212001 × 1000 and grade 10.
- **Assistant awakening (`ChildAssistUpgradeTemplates`, 10).**
  - **Cost:** 208525 × 5..635. **Inheritance:** 40 → 85 %. Op 50.
- **Expedition camp (`ChildCampTemps`, 10).**
  - StationedTime 14 h → 12 h.
  - Difficulty 1/2/3 → raids: SneakCount2 = 5, SneakCount3 = 8.
  - Rewards format `"id,qty|..."`.
- **Patrol (`ChildPatrolMissionTempInfos`, 78).**
  - **Diffculty:** 1 Normal, 2 Difícil, 3 Pesadelo.
  - **MissionType:** 1 skill level, 2 growth, 3 emblem, 4..10 resistances, 11 equipment quality.
  - **CalcType:** 1 = best Guardian, 2 = sum.
- **Spirit arena (`ChildPvpTmpls`, 26; `ChildPvpRewardTmpls`, 24).**
  - **Tiers:** 1 Prata ... 5 Lenda, 6 Hall. Sub-tier I..V; Id = MainType × 10 + SonType.
  - **Task Area:** 1 daily, 2 graduation, 3 season.

**Opcodes:** `8868 C_CHILDREN_OP` (ops 10, 25, 26, 27, 28, 29, 50), 8869 equipment, 9018 camp, 9578 patrol, 9732 arena.

---

## 8. Goddesses (`m5/goddess`)

**`GoddessTemplateInfos` (5)**
- **Type:** 1 Hécate (Magic), 2 Illia, 3 Aster, 4 Cassandra, 5 Lenneth.
- **Activation:** 50 × fragment (212029..212033). **Caps:** MaxGrade 240, MaxStep 40, MaxDevote 5.
- **Resources:** `goddess/view/icon/1.png`, `goddess/view/swf/1.swf`, `goddess/battle/swf/{Type}.swf`.

**Progression**
- **`GoddessUpgradeTemplates` (1200):** stats per level. E.g. Hécate L1 Atk 22 220 / HP 115 140; L240 Atk 74 800 / HP 1 162 800. EXP comes from item 212027.
- **`GoddessStepTemplates` (205):** steps 0..40.
  - AddPer +15 %/step, up to 600 %.
  - The star resets every 10.
  - Quality 2-5 per band.
  - SkillId = active skill (8110001...). InitBelief/ActionBelief = faith.
- **`GoddessDevoteTemplates` (25):** devotion 1..5 (item 212028); protection skill 8010001....

**Accessories (`GoddessEquipmentTempInfos`, 992)**
- **AdvanceType:** 1 = enhancement 0..240 (flat values); 2 = step 0..5 (% values); 3 = set (Crit/Penetration 100k..500k with all 4 slots ≥ 40/80/160/240).
- **EquipType:** 1 Coroa (Crown) → HP, 2 Vontade de Ferro (Iron Will) → Def, 3 Flor (Flower) → Attack, 4 Colar (Necklace) → Magic Def.
- AdvanceCost format `"id,qty#id,qty"`.
- **Enhancement gold:** `Grade×10000 + 1 000 000`.
- **Blessing** `"a,b,c,d"`: the client reads only [1], the bar max.

**Formation**
- **GoddessUnitedResiTemplates (50):** anti-resistance 400 × level per position. Permillage 0..100 ‰ = fraction of the goddess's stats inherited.
- **GoddessUnitedSkillTemplates (4):** skills unlocked when the minimum of the 5 positions is ≥ 5/15/30/50.

**Formula:** `stat = int(base × (100 + AddPer)/100) + S + S × P/100` (`CM/managers/GodDessManager.as:44`). E.g. L1, step 40: 22 220 × 7 = 155 540.

**Opcodes:** `5191 C_GODDESS_OP` (ops 1-10) / `177 U_C_GODDESSINFO`.

---

## 9. Ancient Divine Weapon and crests (`m11/ancientartifact`)

**`ArtifactTemplateInfos` (12)**
- `*Apt = "initial,cap"`, cap = initial × 1000 (Fradlak Attack "129,129000", Live "765,765000").
- `*Conv` is not read *(assumption: points per Pedra dos Deuses 212018)*.
- Skills = skill SonType (12501 → 1250101...).
- **Resources:** `swf/avatar/legend/{SonType}.swf`, `icon/legend_100.png`.
- **Power when not owned:** `Atk + Def + int(MAtk×1.05) + MDef + HP/5 + Parry + Pen` (Fradlak = 845).

**`ArftiArmoryTemplateInfos` (30 = 6 crests × 5 qualities)**
- Crests 101 Tigre (Tiger) ... 106 Falcão (Falcon). Profile 1 Green ... 5 Red.
- `value = Base + Add × seal grade` (seal: UpGrade type 138).
- SuiteId 606-611 = 2-piece bonus.
- **Decomposition:** `ResolvedCount + grade × ResolvedRate`. Icon `icon/armory_101_1.png`.

**Opcodes:** `9649 C_ARTIFACT_OP` (ops 1-12) / 438, 455-458.

---

## 10. Vehicles and Daimon (`m9/vehicle`, `m17`)

**`VehicleObjectTempInfos` (39)**
- **Type:** 1 = player vehicles (Devorador...); 12 = Caça Fantástica heroes; others = towers, boss, monsters *(assumption from names)*.
- **Stats:** Attack/Defence/Hp + tech bonus `hp += 100(g−1)`, `atk += 2(g−1)`, `def += g−1`.
- GeniusSkill and NormalSkill → VehicleSkillTempInfos.
- **Resource:** `vehicle/avatar{Avatar}/2.swf`. Missing: `/vehicle_1..4` and `/tower`.

**`VehicleSkillTempInfos` (77)**
- **InjuryEffect:** 0 self, 1 single target, 2 area, 3 passive, 4 trap. **IFF:** 1 enemies, 2 allies.
- Maximum = ammo (−1 unlimited). Animation `vehicle/skill/{ActionId}.swf`.
- `Buffs = "buffId,chance%"`.

**`VehicleBuffTempInfos` (44)**
- **EffectType:** 1 +attack, 4 stun, 6 speed, 8 DoT/HoT, 9 life steal, 12 damage immune, 19 transformation...
- Duration in ms (−1 = permanent). LastEffect = `asset.vehicle.{x}` (`_a` head, `_b` body).

---

## 11. Titles (`AppellInfos`, 951)

A title is shown above the name and provides a chat prefix and passive stats.
- Class `CM/yishi/datas/templates/AppellInfoTemplate.as`; model `CM/mvc/module/appell/AppellModel.as`.

**Fields**
- **Type:** 1 Personal (30), 2 PvP (35), 3 PvE (5), 4 Other (881).
- **Quality:** 3/4/5, style `map.campaign.HonerText{Q}`.
- **Perfix** `"text|n"`: n = gradient index in `AppellModel.COLORS` (13 pairs). E.g. "Líder mais forte|1".
- **ShowParam** `"ImgId,Width,Height,txtY,font,color"` (`CM/avatar/view/AppellView.as:35-114`):
  - image `icon/appell/{ImgId}.png` (1008 in the manifest);
  - gradient text; color 14 = no text;
  - e.g. id 140 `"1008,213,84,42,23,11"`;
  - tooltip: `images/appell/{TemplateId}.png` (150 files in the manifest; 140 is absent).
- **Skills** = passives (8957 "Vida +3000", 391 titles).
- **CondtionType** (52 values, evaluated server-side; full table in the JSON), e.g.:
  - 202 = own a mount (486 titles, Para = MountTempInfos.TemplateId);
  - 203 = activate fashion or equipment (275, Para = item CSV);
  - 39 = use title card 221 (78);
  - 7 = fame; 3 = Battlefield kills.
- **Para** `"a,b,...,target"`. Progress is shown as `"(atual∕alvo)"` (current/target).
- **IsLong / Time:** temporary titles (ids 140-142, 431). The real expiry = `AppellInfoMsg.validDate`.
- **IsHide** 1 = hidden until obtained.

**Opcodes:** `8597 C_APPELL_EXCHANGE`, `4484 U_APPELL_DATA`, `4491 U_APPELL_GET`.

---

## 12. VIP and first recharge

**`VipPrerogativeTempInfos` (201 = 9 grades × ~23 types)**
- `para1` = value; 0 = unavailable at that grade. `para2` = order. `para3` = highlight.
- `name` uses `{para1}`/`{para2}`.
- **Types** (`CM/mvc/module/vip/VipPrerogativeType.as`):

| Type | Privilege |
|---|---|
| 1 | Castle appearance |
| 2 | Activity +N |
| 3 | Auto check-in |
| 4 | Friends 50 |
| 6 | Campaign EXP 100 → 300 % |
| 10 | VIP currency |
| 11 | Batch cosmos |
| 15 | Battlefield fame |
| 16 | Free cooldown |
| 19 | VIP mount |
| 200 | Max plans 3 → 5 |
| 202 | Conversion discount 90 → 50 % |
| 204 | Free megaphones |
| 205 | −min on Einherjar skill learning |
| 208 | VIP Shop discount 95/90/85 |
| 209 | Extra multimap gains |

- 13, 18, 20, 21, 207 have no constant.

**Other**
- **`VipDrop` (50):** pack per VIP level. VIP1 = 2030102 × 2, 208017 × 20, 208015 × 10, 2061015 × 10. Opcode `8505 C_VIP_BOX_DROP`.
- **`FirstChargeItems` (18):** per class: −300 × 1 000 000, −100 × 1 000 000, 2040109 × 30, −600 × 100 000, class weapon (1011205/1012205/1013205), 2030503 × 2. Opcodes 8672/4290.

---

## 13. Theseus Collection (`Collection*`)

**`CollectionTemplates` (330 = 30 collectibles × stars 0..10)**
- **Key:** `Id = TemplateId×1000 + Star + 1`. TemplateId is a SonType 2002 item (21001 "Manto Mágico"...).
- `stat(k) = round(Max×(k+1)/11)`. E.g. 21001 Defence max 1680 → 153, 305, 458...
- **UpGold:** 10 000 / 20 000 / 30 000 per quality, ×1.5 per star.
- **UpNeed** = fragments (TemplateId × 1000) and/or 20000000 Metal Divino.
- **Icon:** `icon/collection/21001.png`.

**Sets and rewards**
- **CollectionSuitTemplates (6):** 4 collectibles; % bonus with all ≥ 0/3/6/10 stars (Star0..Star10 → SkillTempInfos 2010101...).
- **CollectionRewardTemplates (75):** collector level by chests opened (NeedNum 5..3000). The reward is always `"3505,1|20000000,50"`.

**Opcodes:** `9740 C_COLLECTION_CLIENT` (ops 1-5), 584 / 585 / 594.

---

## 14. Titan, Cat House, residence, marriage and King Contract

- **`TitanTempInfos` (12):**
  - Base Atk/Def/MAtk/MDef/HP; injected bonus `stat × UpGrade122/123[i]/100`.
  - QualiLimit 10/15/20 = cap on the summed dragon level.
  - Icon `icon/titan/1.png`. Opcode `9581 C_TITAN`.
- **`CattoysTemplateInfos` (49):**
  - **Toys** 1001-1025: Types 101 Baloiço, 102 Tapete, 103 Vara, 104 Bola, 105 Caixa; Profile = Simples...Luxuoso.
  - **Cats** 2011-2064.
  - **Production:** OutGold + OutTempId (−2000 Madeira ... −2600 Nepenta) per GrowingMinute.
  - Cost NeedItem1..3. Resources `images/cat/cattoy1011.swf`, `icon/cattoy1001.png`. Opcode 9585.
- **`FurnitureTempInfos` (73) / `FurnitureShopTempInfos` (12):**
  - Type = layer (1 wall, 2 floor, 3 carpet, 4 wall object, 5 window, 7 furniture).
  - FurnitureType = tab 1..11.
  - `Icon1..3 = "swfId,width,height"` per rotation → `images/furniture/{swfId}.swf`.
  - **Shop:** ShopType 20, price −1600 × 100 (Cristais de Vênus). Opcodes 8873 / 9519.
- **`MarrySpecTempInfos` (3):**
  - 1 "Amor de mil anos" (11 999 diamonds, with carriage: Path `"x,y|..."`), 2 Nobre (3188), 3 Normal (1199).
  - 80 % discount within 72 h. Rewards format `"id,qty|..."`.
- **`HeartTempInfos` (123):** couple heart-test questions. `{0}` = Você / Ele(a); Option1..4. Opcode `8802 C_MARRIAGE_HEART`.
- **`KingContracts` (10):**
  - **Ids:** 2 Recompensador, 4 time, 6 special, 9 skill master, 10 radar, 11 auto boss, 12, 15, 16 patrol.
  - Duration in minutes (44 640 = 31 days). NeedPoint = 50/80/90 diamonds.
  - Item 203 with P1 = 13. Opcode 8540.

---

## 15. Main gaps and assumptions

**Meanings not confirmed in the client**
- MasterType 7, 8 and 15.
- Hero equipment `Property7`.
- `NeedChangeJob` 5/127 on fashion.
- Fashion `Property6/7`.
- `Refresh = 5` on wings.
- `ComposeTempInfos.Property1`.
- `MountType 5`.
- The actual meaning of `FashionPolishs.OtherLevel`.

**Evaluated only server-side:** `AppellInfos.CondtionType` (52 values, inferred from Descript/Para), `Time` and `VipDrop.ValidDate`.

**Resources missing from the manifest:** vehicles 1-4, dragon mounts lv3-7, wedding carriage and many `pet_*`. The manifest is partial.
