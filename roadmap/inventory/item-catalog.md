# Item catalog (`ItemTempInfos`)

Module of [README.md](README.md). Static definition of every item: categories, quality, requirements, stack limits, prices, binding and expiry semantics, every template field and the exact enum values the client uses.

Path aliases:

| Alias | File |
|---|---|
| GTI | `decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as` |
| GST | `decompiled/core_module/scripts/bag/datas/GoodsSonType.as` |
| GC | `decompiled/core_module/scripts/bag/helper/GoodsCheck.as` |
| GT | `decompiled/core_module/scripts/yishi/datas/consant/GoodsType.as` |
| GP | `decompiled/core_module/scripts/yishi/datas/goods/GoodsProfile.as` |
| GH | `decompiled/core_module/scripts/yishi/utils/GoodsHelp.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| BH | `decompiled/core_module/scripts/bag/helper/BagHelper.as` |
| BIV | `decompiled/core_module/scripts/yishi/view/community/BaseItemView.as` |
| PT | `decompiled/core_module/scripts/yishi/view/tips/goods/PropTips.as` |
| ETC | `decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as` |
| TM | `decompiled/core_module/scripts/yishi/manager/TempleteManager.as` |

## 1. Overview

- `raw/xml/tempinfos/ItemTempInfos.xml` holds 12 201 `ItemTempInfo` records. The client loads it into `TempleteManager.goodsTemplateCate` (`TM:1146`) and reads it through `GoodsInfo.templateInfo` (`decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as:216-219`). The class `GoodsTemplateInfo` declares one public field per XML attribute (`GTI:14-124`); attributes without a matching field are ignored by the client loader.
- Every item instance (see [item-instance.md](item-instance.md)) references one template by `template_id`. The server must load the same XML (it is the source of truth for prices, stack limits, requirements and use effects).
- Negative template ids are virtual currencies and points (77 records). They never exist as bag rows; they appear in rewards, drops, costs and box contents.
- Template data is read only: no route or table changes it.

## 2. Screens

The catalog has no frame of its own. It drives the item tooltip chosen by `BaseItemView.setTipStyle` (`BIV:795-871`):

| Condition (first match wins) | Tooltip class | Content |
|---|---|---|
| Fashion (`GC.isFashion`, MasterType 1 and SonType 109..112) | `yishi.view.tips.goods.FashionCardTip` | fashion grade, star skill (`DefaultSkill`), refresh data |
| SonType 670 | `yishi.view.tips.AvengerJewelryTips` | Avenger demonic armor |
| SonType 401..406 (`TALISMAN_SONTYPE_LIST`, `GST:336`) | `yishi.view.tips.DragonTalkerTalismanTips` | Dragon Tamer talisman |
| SonType 407 | `yishi.view.tips.DragonTalkerTalismanExpTips` | talisman experience |
| SonType 232 | `yishi.view.tips.goods.MonsterAccessoriesTips` | monster accessory |
| MasterType 1, 3, 5, 6 | `yishi.view.tips.goods.EquipContrastTips` (wraps `EquipTip` / `EquipTipsContent`) | name by quality color, bind state, level and class requirement (`ETC:429-510`), stats, enhancement `StrengthenMax`, mould, sockets (`Property1`), random skills, set (`SuiteId`), validity, sell price |
| MasterType 10, SonType 720 | `TreaBaseEquipTip` | Theseus equipment |
| MasterType 10, other SonType | `PropTips` | |
| MasterType 11 | `TreasureTip` | treasure |
| MasterType 2, 4, 9 and SonType 211 | `ComposeTip` | recipe scroll |
| SonType 216, 1500 | `SeedTip` | farm seed or animal |
| SonType 218 | `MountCardTip` | mount card |
| SonType 302 | `RuneTip` | passive skill rune |
| SonType 306 | `PropTips`, none when the item carries `property1` (pet data) | Einherjar orb |
| SonType 608 | `TaskItemTips` | task scroll |
| SonType 1011..1015 | `yishi.view.tips.RuneStoneTip` | rune stone |
| other MasterType 2, 4, 9 | `PropTips` | |

`PropTips` (`PT:160-262`) shows: name, "Vinculado" / "Não vinculado" (`yishi.view.tips.goods.EquipTipsContent.bind1/bind2`) when the instance has an id, `Description`, "Preço de venda {0} ouro" with `SellGold * (1 + strengthenGrade * 2)` (hidden when `SellGold` is 0, `PT:179-180`), "Nível necessário: {0}" when `NeedGrades > 1` (`PT:181-184`), SonType 609 daily use counter (`PT:203-213`), "Validade:" with "Permanente" / "Expirado" / remaining time (`PT:215-232`) and the hint "shift+clique esquerdo: Enviar ao chat" (`PT:234`).

## 3. Routes (client to server)

None. Templates are static client data; no request reads or writes them.

## 4. Server messages (server to client)

None specific. Template ids travel inside the item messages of [item-instance.md](item-instance.md).

## 5. Rules and formulas

### 5.1 Template fields

| Field | Type | Meaning | Code |
|---|---|---|---|
| `TemplateId` | int | Primary key. Negative = currency or point (5.6) | |
| `MasterType` | int | Category (5.2) | `GT:6-24` |
| `SonType` | int | Subtype (5.3); drives use, equip slot, tooltip, bag | `GST:12-336` |
| `Sexs` | int | 0 female, 1 male, 2 any. Check `Sexs == 2 or hero.Sexs == Sexs` | `GC:190-201`, `decompiled/core_module/scripts/yishi/datas/consant/SexType.as:13-25` |
| `NeedGrades` | int | Minimum hero level (0..80 in data); 0 means none | `GC:203-222` |
| `MaxCount` | int | Stack limit per slot: 1, 99, 999, 9999, 99999, 10 000 000, 100 000 000 | `GM:769-781` |
| `TemplateName` | string | pt-BR name; also the chat link text | |
| `Job` | CSV string | Allowed classes; 0 = any (5.5) | `GC:169-188` |
| `Power`, `Agility`, `Intellect`, `Physique`, `Captain`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `StunAttr`, `Parry`, `Penetrate`, `Live`, `Conat`, `Strength`, `Tenacity` | int | Base stats (equipment, gems) | `GTI:30-104`, `GTI:266-330` |
| `ReduceResi`, `FireResi`, `WaterResi`, `ElectResi`, `WindResi`, `DarkResi`, `LightResi`, `ReduceResiAgainst`, `ResiPenetrate` | int | Resistances | `GTI:106-124`, `GTI:332-364` |
| `Property1`..`Property7` | int | Generic parameters, meaning per SonType (5.4) | |
| `Icon` | string | Path suffix, URL `resourcePath + "icon" + Icon` | `GTI:135-138` |
| `Description` | string (HTML) | Tooltip text; often lists box contents | `PT:173` |
| `Profile` | int | Quality 1..7 (5.7) | `GP:13-66` |
| `SellGold` | int | Unit sell price to the system in gold; 0 = cannot be sold ("Item não pode ser vendido") | `GC:369-372`, `BH:433-444` |
| `DefaultSkill` | CSV int | Fixed skill ids (SkillTempInfos) | `decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as:405-435` |
| `Avata` | string | Avatar resource name (equipment and fashion) | |
| `StrengthenMax` | int | Maximum enhancement (+N); 0 = cannot be enhanced | `ETC:429` |
| `RandomSkillCount` | int | Number of random skill rolls (instance `random_skill_1..5`) | |
| `SuiteId` | int | Equipment set id (`SuiteTempInfos`) | |
| `Refresh` | int | Purification stone template that rerolls random skills; 0 = no reroll, -1 = locked (cannot decompose) | [../smith/README.md](../smith/README.md) |
| `Feed` | int | > 0 feeds the marriage tree | |
| `StartingPrice` | int | Minimum unit price on the market stall and auction | `decompiled/core_module/scripts/cell/mediator/marketbag/MarketSellAlertFrame.as:143-146` |
| `TransformId` | int | Gem conversion group / fashion grade | |
| `IsCanBatch` | bool | Shows the "Usar em massa" button in the use menu | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:122` |
| `NeedChangeJob` | int | 0 none; 1 first class change (`EquipTipsContent.needChangeJob`); 2 Avenger ("Precisa se tornar uma Divindade"); 5 and 127 only on fashion | `ETC:436-471`, `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:691-708` |

Derived properties used by the client:

- `isCanbeUpgrade`: `MasterType 1 and SuiteId > 0 and NeedGrades >= 40 and Profile == 4 and NeedGrades % 10 == 0`, or MasterType 1 SonType 117/118 with `Profile <= 5` (`GTI:185-196`).
- `isUnrestrictedEquip`: basic equipment (101, 103, 104, 106, 107, 108) with `Job == "0"` (`GTI:208-221`).
- `isThreeEquip`: MasterType 1 non fashion with `Profile == 7`; `isSeniorEquip`: `Profile == 6` (`GTI:223-245`).
- `isViceEquip`: MasterType 1 with `Job == "99"` (Dragon Tamer secondary class gear) (`GTI:247-264`).
- Precious goods (`GST.isPreciousGoods`, `GST:501-552`): fashion, SonType 205 or 228 (gems), `MasterType 4/2/3/6 and Profile >= 4`, MasterType 1 with a `SuiteId`, SonType 312, MasterType 5, SonType 329, SonType 117/118 with `Profile >= 4`.

### 5.2 `MasterType` (`GT:6-24`)

| Value | Constant | Meaning | Items |
|---:|---|---|---:|
| 1 | `EQUIP` | Hero equipment and fashion | 2 521 |
| 2 | `PROP` | Props, consumables, materials, currencies | 7 651 |
| 3 | `HONER` | Medals (bag 3) | 37 |
| 4 | `PET_CARD` | Einherjar orbs, titan seals, energy spheres | 124 |
| 5 | `PET_EQUIP` | Einherjar equipment (bag 26) | 24 |
| 6 | `CHILD_EQUIP` | Guardian equipment (bag 30) | 600 |
| 7 | (none) | Album gifts, virtual (negative ids -1700..-1709 and 10 props) | 10 |
| 8 | (none) | Dragon Tamer talismans (SonType 401..407) | 113 |
| 9 | `AIRGARDEN_BED` | Bases (Moda, Guardião, Montaria, Einherjar) | 4 |
| 10 | `THESEUS` | Theseus equipment and materials | 941 |
| 11 | `TREASURE` | Treasures (outer 750, inner 751) | 17 |
| 15 | (none) | Theseus divine slates "Placa de corte" ([slate.md](slate.md)) | 144 |
| 256 | `MONSTER_ACCESSORIE` | Monster accessories | 15 |

### 5.3 `SonType` per `MasterType`

Generated from `ItemTempInfos.xml`. "Behaviour" combines the client rules: equip slot (`GST.getSonTypePos`, `GST:404-447`), usable by double click / "Usar" (`BH.checkCanUseGoods`, `BH:76-139`), move only (`BH.checkisOnlyMove`, `BH:160-230`, single click starts a drag), treasure bag eligible (`GM.isStoreBagGoods`, `GM:2059-2082`). Items of MasterType 2 or 4 that are neither usable nor move only also start a drag on single click. Constants not present in the data (for example `SONTYPE_BLOOD` 209, `NEW_YEAR_CARD` 222, `SONTYPE_PET_EXP_BOOK` 308, `SONTYPE_SINGLE_PASS_PROP` 314, `SONTYPE_SINGLE_PASS_BUGLE` 315, `SONTYPE_HAPPY_ADD` 322, `SONTYPE_DUNGEON_ADD_STEP` 601, `PLANES_LIGHT_GOODS` 603, `PLANES_REVIVE_GOODS` 604, `PLANES_CREAM_GOODS` 605, `SONTYPE_LIFESKILL_ENCHANT` 236, `SONTYPE_LIFESKILL_GONGSHI` 237, `SONTYPE_LIFESKILL_ZHONGJIAN` 238) still have client handlers and must be supported if a template is added.

| MasterType | SonType | Items | Client constant | pt-BR label / examples | MaxCount | Behaviour |
|---:|---:|---:|---|---|---|---|
| 1 | 101 | 163 | `SONTYPE_WEAPON` | Armamento; Arco Huno da Natureza, Arco Huno de Luz, Arco Huno do Santuário | 1 | equip slot 0 |
| 1 | 103 | 91 | `SONTYPE_HEADDRESS` | Capacete; Capacete Inscrustado, Capacete da Banshee, Capacete da Força Infinita | 1 | equip slot 1 |
| 1 | 104 | 160 | `SONTYPE_CLOTHES` | Vestimento; Armadura Arcana, Armadura Caótica, Armadura Mágica | 1 | equip slot 2 |
| 1 | 106 | 92 | `SONTYPE_NECKLACE` | Colar; Alma da Elite [Ω], Alma do Cavaleiro [Ω], Alma do Deus Sagrado [Ω] | 1 | equip slot 3 |
| 1 | 107 | 131 | `SONTYPE_RING` | Anel; Anel Brilhante, Anel Congelante, Anel Demônio | 1 | equip slot 4,5 |
| 1 | 108 | 171 | `SONTYPE_TRINKET` | Ornamento; Brasão da Maldição, Brasão das Sombras, Brasão de Estigma | 1 | equip slot 6,7 |
| 1 | 109 | 411 | `SONTYPE_WING` | Asas; Asa do Deus Ares, Asas Assassinas, Asas Azuís  | 1 | equip slot 8; fashion |
| 1 | 110 | 436 | `FASHION_HEADDRESS` | Chapéu de Moda; Acessório de Cabelo da Deusa, Amor Eterno, Aroma Exótico  | 1 | equip slot 9; fashion |
| 1 | 111 | 413 | `FASHION_WEAPON` | Armamento de Moda; Arma Divina Arcaica  , Arma Silvestre, Arma da Capuchinho Vermelho e Lobo Mau | 1 | equip slot 11; fashion |
| 1 | 112 | 437 | `FASHION_CLOTHES` | Roupa de Moda; Ar de Nobreza, Arma do Toureiro, Aroma do Havaí | 1 | equip slot 10; fashion |
| 1 | 117 | 8 | `SONTYPE_HERALDRY` | Brasão; Espírito da Alma Negra Super Divino, Espírito da Alma Negra [Lendário], Espírito da Alma Negra [Superior] | 1 | equip slot 12 |
| 1 | 118 | 8 | `SONTYPE_RELIC` | Monstros; Barreira da Alma [Lendário], Barreira da Alma [Sofisticado], Barreira da Alma [Super Divino] | 1 | equip slot 13 |
| 2 | 200 | 12 | - | Ametistas, Cristal da Glória, Cristal da masmorra | 100000000/9999 | - |
| 2 | 201 | 153 | `SONTYPE_BUFFER` `SONTYPE_LIFESKILL_ALCHEMY` | C. do Caçador Demônio, C. do Lagarto de Garras, Carta da Morte | 9999/999 | usable (5006) |
| 2 | 203 | 74 | `SONTYPE_USEABLE` `SONTYPE_KINGCONTRACT_CARD` | Baú de Contribuição Avançado, Baú de Contribuição Básico, Baú de Contribuição Médio | 9999/999/99 | usable (5006) |
| 2 | 204 | 18 | `SONTYPE_INTENSIFY` | Gema da Sorte Nv. 1, Gema da Sorte Nv. 2, Gema da Sorte Nv. 3 | 9999 | move only |
| 2 | 205 | 96 | `SONTYPE_MOUNT` | Gema de Ataque Nv. 1, Gema de Ataque Nv. 10, Gema de Ataque Nv. 11 | 9999 | move only; treasure bag 34 |
| 2 | 206 | 975 | `SONTYPE_OPENBOX` | Baú Antigo Nv. 1, Baú Antigo Nv. 2, Baú Antigo Nv. 3 | 9999/999 | usable (5006) |
| 2 | 208 | 878 | `SONTYPE_MEDAL` | Alma do labirinto, Bilhete para expedição, Chaves do Julgamento | 9999/1/100000000 | move only |
| 2 | 210 | 1602 | `SONTYPE_TASK` | Alma de Cosmos, Bola de Gude, Bolo da Lua | 999/9999 | move only |
| 2 | 212 | 73 | `SONTYPE_COMPOSE_MATERIAL` | Alicate de Vulcan, Alma Misteriosa, Alma do Deus das Feras | 9999/100000000 | move only |
| 2 | 213 | 5 | `SONTYPE_REWARD_CARD` | Doc. de Recompensa, Doc. de Recompensa Avançado, Doc. de Recompensa Nv. 1 | 9999 | usable (5006) |
| 2 | 215 | 5 | `SONTYPE_REFRESH` | Pedra da Essência da Purificação, Pedra da Purificação Divina, Pedra da Purificação nv. 4 | 9999 | move only |
| 2 | 216 | 82 | `SONTYPE_SEED` | Dente de Ares, Fruto Espiritual Baixo, Fruto Espiritual Médio | 9999/999 | move only |
| 2 | 217 | 5 | `SONTYPE_ROSE` | 1 Rosa(s), 11 Rosa(s), 99 Rosa(s) | 9999 | usable (5006) |
| 2 | 218 | 721 | `SONTYPE_MOUNT_CARD` | Carta da Alpaca Demônio, Carta da Besta do Abismo, Carta da Cavalaria Noturna | 1 | usable (5006) |
| 2 | 219 | 1 | `SONTYPE_PUMPING_COUPON` | Cupom de Gashapon | 1 | usable (5006) |
| 2 | 221 | 92 | `SONTYPE_APPELL` | Amor da Deusa, Andarilho, Carta de Papai Noel | 1 | usable (5006) |
| 2 | 224 | 96 | `CHILD_JEWEL` | Ágata da Defesa Física Nv.1, Ágata da Defesa Física Nv.10, Ágata da Defesa Física Nv.11 | 9999 | move only; treasure bag 34 |
| 2 | 225 | 1 | `SONTYPE_CHILD_GROWTH_ITEM` | Sangue de Zeus | 9999 | move only |
| 2 | 226 | 4 | `CHILD_SKILL_BOOK` | Livro da Sabedoria, Pergaminho de Habilidades Ativas do Guardião, Pergaminho de Habilidades Comuns do Guardião | 9999 | usable (5006) |
| 2 | 227 | 14 | `CHILD_PROP` | Areia Dourada, Bronze Roxo, Chama Mágica Azul | 9999 | move only |
| 2 | 228 | 36 | `SONTYPE_MOUNT2` | Gema de Ataque e Crítico Nv.10, Gema de Ataque e Crítico Nv.11, Gema de Ataque e Crítico Nv.12 | 9999 | move only; treasure bag 34 |
| 2 | 230 | 3 | `MONSTER_TRAIN_MATERIAL` | Espeto de carne, Espeto de carne e cogumelo, Espeto de cogumelo | 9999 | - |
| 2 | 231 | 10 | `MONSTER_CALL_MATERIAL` | Cristal de monstro da Dimensão do Abismo, Cristal de monstro da Floresta Nublada, Cristal de monstro do Deserto da Morte | 9999 | - |
| 2 | 233 | 1 | `MONSTER_STRENGETHEN` | Gema do dragão | 9999 | - |
| 2 | 234 | 12 | `SONTYPE_LIFESKILL_LONGZHU` `MONSTER_BREAKTHOUGH` | Buquê cheio, Escova de polimento, Ferramenta de escultura | 9999 | move only |
| 2 | 276 | 1 | `SONTYPE_SOUL_CONCISE` | Pedra Requintada | 9999 | move only |
| 2 | 277 | 1 | `SONTYPE_EXCHANGE_CHILD_CARD` | Fragmentos da Marca do Deus Escolhido | 9999 | usable (5006) |
| 2 | 278 | 2 | `SONTYPE_FASHION_STONE` | Alma da Moda, Amuleto da Sorte | 9999 | usable (5006) |
| 2 | 279 | 1 | `SONTYPE_TALENT_STONE` | Pedra do Dom Natural | 9999 | move only |
| 2 | 280 | 1 | `SONTYPE_CROSS_BUGLE` | Megafone Inter-Servidor | 9999 | usable (5006) |
| 2 | 281 | 1 | `SONTYPE_TITAN_STONE` | Pedra da Alma de Titã | 9999 | move only |
| 2 | 283 | 1 | `SONTYPE_TATTOO_PRINT` | Pedras de Selo de Tatuagem | 9999 | move only |
| 2 | 288 | 1 | `TRIAL_HAERT` | Julgamento do Coração | 9999 | - |
| 2 | 289 | 1 | `SONTYPE_RENAME_CARD` | Carta de Renomeamento | 1 | usable (5006) |
| 2 | 290 | 1 | `SONTYPE_MOUNT_FOOD` | Pedra Bestial | 9999 | move only |
| 2 | 292 | 1 | `SONTYPE_VIP_BOX` | Moeda VIP | 9999 | usable (5006) |
| 2 | 293 | 1 | `SONTYPE_SOUL_CRYSTAL` | Cristal de Almas | 9999 | move only |
| 2 | 294 | 1 | `SONTYPE_CONSORTIATIME_CARD` | Cartão de Aliança | 9999 | usable (5006) |
| 2 | 296 | 1 | `SONTYPE_MAZE_GOLD` | Moeda do Labirinto | 9999 | usable (5006); move only |
| 2 | 297 | 1 | `SONTYPE_MAZE` | Chave do Labirinto | 9999 | move only |
| 2 | 298 | 16 | `SONTYPE_NOVICE_BOX` | Pacote Iniciante Nv. 35, Pacote Iniciante Nv. 40, Pacote Iniciante Nv. 45 | 1 | usable (5006) |
| 2 | 299 | 1 | `SONTYPE_MOUNT_PORP` | Perfurador | 9999 | move only |
| 2 | 302 | 13 | `SONTYPE_PASSIVE_SKILL` | Benção da Deusa da Lua, Pedras rúnicas, Runa da Confusão | 9999 | usable (5006) |
| 2 | 303 | 155 | `SONTYPE_PET_SKILL_BOOK` | Habilidade - Alma da Água, Habilidade - Ataque de Chamas, Habilidade - Benção de Hefesto | 9999 | move only |
| 2 | 305 | 1 | - | Poção Anti do Einherjar | 9999 | - |
| 2 | 307 | 1 | `SONTYPE_FATE_STONE` | Pedra do Destino | 9999 | move only |
| 2 | 310 | 9 | `SONTYPE_PET_ESSENCE` | Essência da Escuridão, Essência de Choque, Essência de Einherjar | 9999 | move only |
| 2 | 311 | 30 | `SONTYPE_BOX` | Baú Opulento, Baú da Esfera de Enerigia, Baú da Grande Arcana | 9999/999 | usable (5006) |
| 2 | 312 | 84 | `RESIST_GEM` | Cristal Anti-Resist.Nv.1, Cristal Anti-Resist.Nv.10, Cristal Anti-Resist.Nv.11 | 9999 | move only; treasure bag 34 |
| 2 | 313 | 4 | `SONTYPE_PET_LAND_TRANSFER` | Ilha de Einherjar Transmissor 1, Ilha de Einherjar Transmissor 2, Ilha de Einherjar Transmissor 3 | 9999 | usable (5006) |
| 2 | 316 | 4 | `SONTYPE_FIREWORK` | Buquê de Casamento, Cartão de Aniversário, Fogo de Artifício | 9999 | usable (5006) |
| 2 | 317 | 6 | `QUAN_DISCOUNT` | Cupom da Gema, Cupom da Moda, Cupom de Itens | 9999 | move only |
| 2 | 318 | 1 | `SONTYPE_HIGH_LEVEL_SOUL` | Selo da Alma | 9999 | move only |
| 2 | 319 | 1 | `SONTYPE_DRAGON_SOUL` | Alma do Dragão | 9999 | move only |
| 2 | 320 | 2 | `SONTYPE_MARRY_TASK` | Flecha do Cúpido, Fogo de Artifício Brilhante | 9999 | usable (5006) |
| 2 | 321 | 3 | `SONTYPE_NEW_MEDAL` | Medalha da Chama, Medalha do Crepúsculo, Medalhas | 100000000 | move only |
| 2 | 323 | 1 | `SONTYPE_PET_COMPOSITE` | Fragmento do equipamento de einherjar | 9999 | move only |
| 2 | 324 | 3 | `SONTYPE_PET_UPGRADEITEM` | Bênção de Deus, Dom de Deus, Honra de Deus | 9999 | move only |
| 2 | 325 | 1 | `SONTYPE_PET_STRENGITEMA` | Luz Mágica | 9999 | move only |
| 2 | 326 | 1 | `SONTYPE_PET_STRENGITEMB` | Liderança Mágica | 9999 | move only |
| 2 | 327 | 1 | `SONTYPE_PET_REFINERYITEM` | Água Dourada | 9999 | move only |
| 2 | 328 | 1 | `SONTYPE_PET_MOUNT` | Diamantes dos espíritos | 9999 | move only |
| 2 | 329 | 60 | `SONTYPE_PET_GEM` | Alma Divina ataque nv.1, Alma Divina ataque nv.10, Alma Divina ataque nv.11 | 9999 | move only; treasure bag 34 |
| 2 | 330 | 1 | - | Troca do Código de Atividade | 9999 | - |
| 2 | 331 | 1 | `SONTYPE_GEMMAZE_TREASURE_MAP` | Tesouros Perdidos | 9999 | usable (5006) |
| 2 | 332 | 1 | - | Bilhete da Arena Ilusória | 999 | - |
| 2 | 340 | 1 | `SONTYPE_SEX_CHANGE_CARD` | Cartão de alteração do Sexo | 9999 | usable (5006) |
| 2 | 343 | 27 | `SONTYPE_PET_GEM2` | Alma Divina de Ataque e Defesa Nv.10, Alma Divina de Ataque e Defesa Nv.11, Alma Divina de Ataque e Defesa Nv.12 | 9999 | move only |
| 2 | 344 | 3 | `SONTYPE_PET_GEM3` | Alma Divina de Ataque e Magia Nv.10, Alma Divina de Ataque e Magia Nv.11, Alma Divina de Ataque e Magia Nv.12 | 9999 | move only |
| 2 | 350 | 5 | - | Baú de Bronze, Baú de Ouro, Baú de Platina | 99999 | - |
| 2 | 398 | 6 | `SONTYPE_MAGICSPRING` | Chifre da Resistência, Coração da Sabedoria, Fonte da Vida | 9999 | move only |
| 2 | 399 | 1 | `SONTYPE_SNOWROSE` | Carta de Natal | 9999 | usable (5006) |
| 2 | 500 | 36 | - | Pedra de Julgamento - Anti-choque, Pedra de Julgamento - Anti-escuridão, Pedra de Julgamento - Anti-fogo | 9999 | - |
| 2 | 501 | 1 | - | Cristal da Vingança | 9999 | - |
| 2 | 510 | 5 | `Legion_command` | Cruzada do Exército (Caverna do Ouro Negro (Avançado)), Cruzada do Exército (Floresta Elemental (Divindade)), Cruzada do Exército (Formação Mágica) | 9999 | usable (5006) |
| 2 | 600 | 21 | `SONTYPE_MAGIC_CARD` | Anjo da Escuridão · Abilis, Anjo da Luz · Selas, Arma Arcaica · Deus Ares | 9999 | usable (5006) |
| 2 | 602 | 1 | `OUTER_CITY_MAP_GOODS` | Pedra da Energia | 9999 | usable (5006) |
| 2 | 606 | 24 | `PLANES_POINT_GOODS` | Coordenações do Plano das trevas atual, Coordenações do Plano das trevas baixo, Coordenações do Plano das trevas grande | 9999 | usable (5006) |
| 2 | 607 | 10 | `SONTYPE_GET_CHILD_CARD` | Carta do Anão de Gelo, Carta do Cavaleiro Sagrado, Carta do Caçador Sagrado | 1 | usable (5006) |
| 2 | 608 | 2 | `MAGIC_TASK_ITEM` | Pergaminho de Missão teste 1, Pergaminho de Missão teste 2 | 1 | usable (5006) |
| 2 | 609 | 1 | `TIMES_PROP` | Test Cartão Mensal | 1 | usable (5006) |
| 2 | 619 | 12 | `SONTYPE_CHILD_CALL` | Essência de Guardião Nv. 1, Essência de Guardião Nv. 2, Essência do Guardião nível 3 | 9999 | move only |
| 2 | 620 | 1 | `SONTYPE_CHILD_AWAKESTONE` | Pedra da Alma do Guardião | 9999 | move only |
| 2 | 621 | 1 | `SONTYPE_RAVE_SCOREITEM` | Moeda da Alegria | 9999 | usable (5006) |
| 2 | 622 | 1 | `SONTYPE_BOSS_STONE` | Carta da convocação do chefão do Verão | 9999 | usable (5006) |
| 2 | 623 | 1 | `TALENT_STONE` | Pedra do Dom Natural Básico | 9999 | move only |
| 2 | 624 | 4 | `CHILD_NS_SKILL_BOOK` | Livro de Habilidades Ativas do Espírito de Proteção, Livro de Habilidades Ex. do Espírito de Proteção, Livro de Habilidades Passivas do Espírito de Proteção | 9999 | usable (5006) |
| 2 | 625 | 12 | `ANCIENT_ARTIFACT_STONE` | Akatram, Bergeratak, Brunoak | 1 | usable (5006) |
| 2 | 626 | 30 | `ANCIENT_ARMORY_STONE` | Brasão Mágico - Alma de Cervo(Azul), Brasão Mágico - Alma de Cervo(Laranja), Brasão Mágico - Alma de Cervo(Roxo) | 9999 | usable (5006) |
| 2 | 627 | 3 | `PROFICIENCY_PILL` | Potencial Avançado, Potencial Básico, Potencial Intermediário | 9999 | - |
| 2 | 666 | 8 | `SEVEN_YEAR_TREASUREBOX` | Aquarius Comemorativo I, Aquarius Comemorativo II, Aquarius Comemorativo III | 9999 | - |
| 2 | 667 | 8 | `SEVEN_YEAR_TREASUREBOX_NOTBUY` | Tesouro Comemorativo I, Tesouro Comemorativo II, Tesouro Comemorativo III | 9999 | - |
| 2 | 668 | 3 | - | Báu Comemorativo I, Báu Comemorativo II, Báu Comemorativo III | 9999 | - |
| 2 | 670 | 1680 | `DEVIL_ARMOR_SONTYPE` | Nv.10·Ataque de meteoro·Defesa, Nv.10·Ataque de meteoro·Rugido, Nv.11·Ataque de meteoro·Defesa | 9999 | - |
| 2 | 680 | 18 | `DEVIL_ARMOR_PIECE_SONTYPE` | Ataque de meteoro·Defesa·Fragmento de Luz Roxa, Ataque de meteoro·Rugido·Fragmento de Luz Roxa, Ataque de meteoro·Violência·Fragmento de Luz Roxa | 9999 | - |
| 2 | 691 | 1 | - | Pedra de polir | 9999 | - |
| 2 | 692 | 1 | - | Pedra de esculpir | 9999 | - |
| 2 | 693 | 1 | `DEMOROAD_SHOP_RESOLVE_SONTYPE` | Pedra fundida de ouro | 9999 | move only |
| 2 | 694 | 1 | - | Pedra fundida de sangue | 9999 | - |
| 2 | 700 | 1 | - | Pontos de Alquimia | 999 | - |
| 2 | 701 | 1 | - | Catalisador Misterioso | 999 | - |
| 2 | 702 | 24 | - | Isômero do Jade Vermelho, Isômeros de Minério Azul, Isômeros de Minério de Ferro | 999 | - |
| 2 | 710 | 21 | `STELA_SONTYPE` | Baú de Estela 1 estrela, Baú de Estela 1~2 estrelas, Baú de Estela 1~3 estrelas | 100000000 | usable (5006); use via 8665 |
| 2 | 711 | 3 | - | Pedra de Bloqueio da Estela, Pedra de Purificação da Estela, Pedra de Recuo | 9999 | - |
| 2 | 752 | 4 | - | Pedra de Fort. de Tesouro Externo, Pedra de Fort. de Tesouro Interno, Pedra de Fort. do Núcleo | 9999 | - |
| 2 | 753 | 2 | - | Pedra de Dissolução do Tesouro Externo, Pedra de Dissolução do Tesouro Interno | 9999 | - |
| 2 | 760 | 54 | `WARSOUL_SONTYPE` `THESEUS_WAR_PROP_0` | Alma da Guerra Marinha·Azul, Alma da Guerra Marinha·Branco, Alma da Guerra Marinha·Roxo | 100000000 | move only |
| 2 | 761 | 54 | `THESEUS_WAR_PROP_1` | Fragmento da Alma da Guerra Marinha·Azul, Fragmento da Alma da Guerra Marinha·Branco, Fragmento da Alma da Guerra Marinha·Roxo | 100000000 | move only |
| 2 | 762 | 11 | `THESEUS_WAR_PROP_2` | Alma da Reforma Comum, Alma da Reforma Fragmentada, Alma da Reforma Impecável | 100000000 | move only |
| 2 | 763 | 37 | `THESEUS_WAR_PROP_3` | Golpe do Arco-íris - Inferior·Laranja, Golpe do Arco-íris - Inferior·Roxo, Golpe do Arco-íris - Inferior·Vermelho | 9999 | move only |
| 2 | 764 | 4 | - | Bilhete de Desafio Interservidores, Glória da Arena, Mérito de Teseu | 100000000 | - |
| 2 | 765 | 4 | - | Emblema da Glória, Mérito da Arena do Espírito de Proteção, Mérito de Teseu Multijogador | 100000000 | - |
| 2 | 800 | 5 | `STAR_GAZING_ITEM_SONTYPE` | Atração do Fogo das Estrelas, Carta Celeste Geral, Fogo das Estrelas | 999 | usable (5006) |
| 2 | 801 | 12 | `STAR_GAZING_CHART_SONTYPE` | Carta Celeste da Constelação Aquarius, Carta Celeste da Constelação Aries, Carta Celeste da Constelação Cancer | 999 | usable (5006) |
| 2 | 802 | 1 | - | Fragmento de Céu Estrelado | 999 | - |
| 2 | 1000 | 1 | `RUNE_STONE_1` | Fragmento de Runa | 9999 | move only |
| 2 | 1001 | 1 | `RUNE_STONE_2` | Broca de slot de runa | 999 | move only |
| 2 | 1002 | 1 | - | Energia de Runa | 9999 | - |
| 2 | 1011 | 5 | - | Runa de Força Branca, Runa de Físico Branca, Runa de Inteligência Branca | 1 | - |
| 2 | 1012 | 5 | - | Runa de Força Verde, Runa de Físico Verde, Runa de Inteligência Verde | 1 | - |
| 2 | 1013 | 5 | - | Runa de Força Azul, Runa de Físico Azul, Runa de Inteligência Azul | 1 | - |
| 2 | 1014 | 5 | - | Runa de Força Roxa, Runa de Físico Roxa, Runa de Inteligência Roxa | 1 | - |
| 2 | 1015 | 5 | - | Runa de Força Laranja, Runa de Físico Laranja, Runa de Inteligência Laranja | 1 | - |
| 2 | 1100 | 2 | - | Chave de Teseus, Poeira de placa | 9999 | - |
| 2 | 1500 | 4 | `SONTYPE_FARMANIMAL` | Cabra, Cavalo Branco, Cervo | 9999 | - |
| 2 | 1501 | 1 | - | Ervas Frescas | 9999 | - |
| 2 | 2000 | 1 | - | Metal Divino | 9999 | - |
| 2 | 2001 | 30 | - | Fragmento da Ampulheta da Terra, Fragmento da Lanterna Mágica, Fragmento da Tocha do Poder | 9999 | - |
| 2 | 2002 | 30 | - | Ampulheta da Terra, Arca de Noé, Armadura de Fenrir | 9999 | - |
| 3 | 301 | 37 | `SONTYPE_HONER` | Medalha de Fama; Guardião Estrelar, Medalha Barrão, Medalha Exemplar | 1 | equip slot 0 (bag 3) |
| 4 | 103 | 1 | `SONTYPE_HEADDRESS` | Elmo de Sawenhond | 1 | - |
| 4 | 282 | 12 | `SONTYPE_GET_TITAN_CARD` | Carta de Selo das Trevas de Titã, Carta de selo da Justiça de Titã, Carta de selo da Vingança de Titã | 9999 | usable (5006) |
| 4 | 304 | 2 | `SONTYPE_PET_APT` | Esfera de Energia Avançada, Esfera de Energia de Einherjar | 9999 | move only |
| 4 | 306 | 108 | `SONTYPE_PET_CARD` | Esfera da Amazona Azul - Fogo, Esfera da Amazona Branca - Fogo, Esfera da Amazona Laranja - Fogo | 9999 | usable (5006) |
| 4 | 309 | 1 | - | Carta de Selo do Einherjar vazio | 1 | - |
| 5 | 113 | 8 | `SONTYPE_PET_EARRING` | Brinco; Anel da Ordem, Beijo do Anjo, Fúria de Pan | 1 | equip slot 0,1 (bag 26) |
| 5 | 114 | 4 | `SONTYPE_PET_BELT` | Cinto; Cinta do Espírito Nulo, Inteligência de Athena, Luz de Apolo | 1 | equip slot 2 (bag 26) |
| 5 | 115 | 8 | `SONTYPE_PET_ACCESSORIES` | Acessório; Amor de Íris, Colar do Poder Elemental, Dente da Fera do Mar | 1 | equip slot 3,4 (bag 26) |
| 5 | 116 | 4 | `SONTYPE_PET_ARTIFACT` | Artefacto; Bastão do Espírito, Escuridão de Hades, Fúria do Trovão | 1 | equip slot 5 (bag 26) |
| 6 | 611 | 75 | `SONTYPE_CHILD_WEAPON` | Armamento; Aprendiz do Bastão Mágico, Arco Comprido do Guarda, Arco Curto do Aprendiz | 1 | Guardian equipment (bag 30) |
| 6 | 613 | 75 | `SONTYPE_CHILD_HEADDRESS` | Capacete; Capacete da Fúria, Capacete da Selva, Capacete de Ares | 1 | Guardian equipment (bag 30) |
| 6 | 614 | 75 | `SONTYPE_CHILD_CLOTHES` | Vestimento; Armadura de Ares, Armadura de Couro do Guerreiro, Armadura de Couro do Heroi | 1 | Guardian equipment (bag 30) |
| 6 | 616 | 75 | `SONTYPE_CHILD_NECKLACE` | Colar; Alma de Apollo, Alma de Ares, Alma de Atena | 1 | Guardian equipment (bag 30) |
| 6 | 617 | 150 | `SONTYPE_CHILD_RING` | Anel; Anel da Condenação, Anel da Destruição, Anel da Punição | 1 | Guardian equipment (bag 30) |
| 6 | 618 | 150 | `SONTYPE_CHILD_TRINKET` | Ornamento; Acessório da Condenação, Acessório da Destruição, Acessório da Punição | 1 | Guardian equipment (bag 30) |
| 7 | 208 | 10 | `SONTYPE_MEDAL` | Balde Sorvete, Cerejas Enlatadas, Chocolate | 999 | - |
| 8 | 401 | 32 | - | Talismã de Ataque Físico Devorador de Ossos, Talismã de Ataque Físico Disco Solar, Talismã de Ataque Físico Livro dos Mortos | 1 | - |
| 8 | 402 | 16 | - | Talismã de Defesa Física Escaravelho-sagrado, Talismã de Defesa Física Livro dos Mortos, Talismã de Defesa Física Lua Cheia | 1 | - |
| 8 | 403 | 16 | - | Talismã de Ataque Crítico Devorador de Ossos, Talismã de Ataque Crítico Disco Solar, Talismã de Ataque Crítico Escaravelho-sagrado | 1 | - |
| 8 | 404 | 16 | - | Talismã de Vida Devorador de Ossos, Talismã de Vida Disco Solar, Talismã de Vida Escaravelho-sagrado | 1 | - |
| 8 | 405 | 16 | - | Talismã de Defesa Mágica Escaravelho-sagrado, Talismã de Defesa Mágica Livro dos Mortos, Talismã de Defesa Mágica Lua Cheia | 1 | - |
| 8 | 406 | 16 | - | Talismã de Bloqueio Devorador de Ossos, Talismã de Bloqueio Disco Solar, Talismã de Bloqueio Livro dos Mortos | 1 | - |
| 8 | 407 | 1 | `TALISMAN_EXP_SONTYPE` | Talismã de Experiência | 9999 | - |
| 9 | 901 | 1 | - | Base de Moda | 100000000 | - |
| 9 | 902 | 1 | - | Base do Guardião | 100000000 | - |
| 9 | 903 | 1 | - | Base da Montaria | 100000000 | - |
| 9 | 904 | 1 | - | Base da Einherjar | 100000000 | - |
| 10 | 720 | 908 | `THESEUS_EQUIP` | Anel da Água Nv. 1, Anel da Água Nv. 2, Anel da Água Nv. 3 | 9999 | - |
| 10 | 730 | 28 | - | Aço Celeste, Aço Marinho, Aço da Escuridão | 9999 | - |
| 10 | 740 | 3 | - | Alma da Intenção de Guerra, Aço da Intenção de Guerra, Ferro da Intenção de Guerra | 9999 | - |
| 10 | 750 | 1 | `TREASURE_OUTER` | Pedra de Temperamento Divino | 100000000 | - |
| 10 | 751 | 1 | `TREASURE_INNER` | Pedra Divina Impecável | 100000000 | - |
| 11 | 750 | 8 | `TREASURE_OUTER` | Damastus Ardiloso, Perifortes Sanguinário, Sinnis Cruel | 1 | - |
| 11 | 751 | 9 | `TREASURE_INNER` | Coração Ambicioso, Maldição do Ciúme, Vontade Preguiçosa | 1 | - |
| 15 | 800 | 144 | (`STAR_GAZING_ITEM_SONTYPE` has the same value but names MasterType 2 stargazing items) | Placa de combo, Placa de corte, Placa de guarda | 1 | divine slate, managed by [slate.md](slate.md) |
| 256 | 232 | 15 | `MONSTER_ACCESSORIES` | Folha de menta, Girlanda de menta, Laço de couro | 1 | - |

### 5.4 `Property1..7` by SonType (usable and special items)

Values verified on the XML. "P" = Property.

| SonType | Meaning of the properties | Example |
|---|---|---|
| 101..108, 117, 118 (equipment) | P1 = gem socket count (1..3); P7 = refine group (assumption) | |
| 109..112 (fashion) | P1 = identification book cost, P2 = refresh quantity, P4 = grade text style, P5 = 1 allows exchange | see [../fashion/README.md](../fashion/README.md) |
| 113..116, 611..618 | P1 = socket count, P7 = equipment skill id | |
| 201 buffer | P1 = buffer template id (`BufferDataMsg.template_id`, key of `PlayerBufferManager.getItemBufferInfo`), P2 = duration in minutes, P3 = buffer grade (strength, a weaker grade cannot replace a stronger active one), P4 = shape id for transformation cards (assumption) | 2013001 "Pergaminho de Experiência": P1 2030, P2 60, P3 50; 208006 "Placa de Isenção de Batalhas": P1 2001, P2 480 |
| 203 utility | P1 = subtype, P2 = amount, P3 = extra | see 5.4.1 |
| 205 gem | P1 = stat (1 Attack, 2 Defense, 3 Magic, 4 Resistance, 5 Crit, 6 HP, 7 Leadership, 8 Block), P6 = level | |
| 206 open box | P1 = drop id (859 distinct; equals the TemplateId for most boxes). Drop tables are server only (6.3) | 208069 "Baú de Perfume" P1 208069 |
| 213 reward card | P1 = quality of the offered bounty task (1..5) | 2130001 "Doc. de Recompensa Nv. 1" |
| 217 rose | P1 = charm points per rose | 2170001 "1 Rosa(s)" P1 1 |
| 218 mount card | P1 = MountTempInfos id, P2 = days (-1 permanent), P3 = required mount class | 2180001 P1 1001 P2 -1 |
| 219 gashapon coupon | P1 = activity id | |
| 221 title card | P1 = AppellInfos id | 2125064 P1 55 |
| 282 titan seal | P1 = seal type | |
| 292 VIP coin | none; used through 8521 | 208015 "Moeda VIP" |
| 298 novice pack | P1 = drop id (series 90100 + level, 90200 + level, 90305 + level; for example 90140 for the level 40 pack of the first series); `NeedGrades` = level shown in the frame | 2060109 "Pacote Iniciante Nv. 40" |
| 302 passive rune | P2 = rune level (assumption) | |
| 306 Einherjar orb | P1 = PetTempInfos id | 3061001 P1 101101 |
| 311 paid chest | P2 = currency template id paid per opening (-100 gold, -200 amethyst, -300 spirit, -400 diamonds, -500 bound diamonds, -600 light crystal, -700 strategy, -800 glory, or an item template id), P3 = amount per opening | 3110003 P2 -400 P3 1199 |
| 313 pet island transmitter | P1 = map id 20001..20004 (floor 1..4) | 3130001 P1 20001 |
| 316 firework | P1 = type | |
| 320 Cupid arrow / treasure map | P1 = type; instance `random_skill_5 == 1` marks it expired | |
| 350 collection chest | P1 = TemplateId, P2 = tier (1, 10, 20, 30, 50) | 3501 "Baú de Bronze" |
| 399 Christmas card | P1 charm, P2 friendship, P3 broadcast type | |
| 510 campaign gain card | P2 = campaign id that must be open | 5100301 P2 301 |
| 600 magic card | P1 = magic card id, P2 = count | |
| 602 energy stone | P1 = energy points | |
| 606 plane coordinates | P1 = plane id | |
| 607 guardian card | P1 = Guardian job type | |
| 608 task scroll | P1 = quest id | |
| 609 times prop | P2 = maximum uses; instance `usedTimes`, `isTodayUsed` (one use per day) | 3300102 "Test Cartão Mensal" P2 5 |
| 621 carnival coin | P1 = points | |
| 625 divine weapon | P1 = ArtifactTemplateInfos id | 241001 "Fradlak" |
| 626 crest | P1 = ArftiArmoryTemplateInfos id, P2 = count | |
| 710 stele exchange item | P1 = target template, P2 = amount (use route 8665) | 7101401 |
| 800, 801 stargazing | P1 = constellation index (801) | |
| 1011..1015 rune stone | P1 = rune attribute type | |

#### 5.4.1 SonType 203 subtypes (`Property1`)

| P1 | Effect when used (P2 = amount) | Example | Client check |
|---:|---|---|---|
| 1 | + gold | 2030101 "Caixa de Ouro" (1000) | |
| 3 | + diamonds | 2030301 "Cupom de Troca de Diamante" | |
| 4 | + bound diamonds | 2030401 "Carta de 10 Diamantes Vinculados" | |
| 5 | + energy (weary) | 2030500 "Poção de Energia Pequeno" (5) | weary cap 200 and daily recovery cap 600 (`PlayerBagCellClickMediator.as:900-938`) |
| 6 | + prestige | 2030601 "Certificado de Prestígio Básico" | |
| 7 | + hero experience | 2030701 "Livro de EXP Nv. 1" (500) | |
| 8 | + guild contribution | 2030801 "Baú de Contribuição Básico" | guild member only (`ShopGoodsInfo.CONSORTIA_USE_ITEM = [8,22]`, `decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:365`) |
| 9 | Demon Hunter levels (P3 = 9001) | 2030901 | |
| 10 | + spirit (strategy) | 2031001 "Esfera de Espírito" | |
| 11 | + light crystal | 2030201 "Caixa de Cristal de Luz" | |
| 12 | VIP trial, P3 = hours | 2031201 "Cartão de Teste VIP" (`GC.isVipExperienceCard`, `GC:403-406`) | |
| 13 | King contract (elf contract) trial, P2 = hours | 2031301 (`GC.isKingCard`, `GC:408-411`) | |
| 15 | +1 multiplayer map gain count | 2032101 "Ordem de Punição Imperial" (popup tip type 38 when `property1 == "1"`, `GM:174-182`) | |
| 16 | + fame | 2032201 | |
| 19 | instant level up, P3 = level cap 70 | 2030707 "Pílula de Experiência Super" | |
| 20 | + Terralém research power | 2032301 | |
| 21 | + Goddess tears | 208103 | |
| 22 | + guild merit | 208104 "Emblema da Guilda" | guild member only |
| 23 | + vengeance heart | 208133 | |
| 24 | + warrior points (event) | 2032401 | |
| 25 | + sparks (ruins) | 2032501 | |
| 26 | + dungeon crystal | 30040076 | |
| 27 | + dungeon pick movement | 30000014 | |

TemplateId 2032102 (group campaign income, P3 = energy cost) asks "Após usar reduzirá {0}pts de energia..." and requires a class change and `weary >= P3` (`PlayerBagCellClickMediator.as:722-751`).

### 5.5 `Job`

| Value | Meaning |
|---|---|
| 0 | any class (`JobType.Name01` "S/ Restrição") |
| 1, 2, 3, 4 | Guerreiro, Arqueiro, Feiticeiro, Encantador de Dragões (`yishi.datas.consant.JobType.JobName1..4`) |
| CSV ("1,2,3", "1,2") | any listed class |
| 99 | Dragon Tamer secondary gear (`isViceEquip`) |
| 5..10, 101..105 | Guardian job types (MasterType 6) |
| other CSV (16, 17, 19...) | monster types (accessory 232) |

Fashion items skip the job check (`GC:171-174`). Job check: any listed value equals `hero.templateInfo.Job` or is 0 (`GC:169-188`).

### 5.6 Currencies and points (negative `TemplateId`)

-100 Ouro, -200 Ametistas, -300 Espírito, -350 Pontuação de Baú, -400 Diamante, -500 Diamante Vinculado, -600 Cristal de Luz, -700 Experiência, -800 Cristal da Glória, -900 Carta de Selo do Einherjar vazio (MasterType 4), -1000 Emblema do Rei, -1100 Emblema do Campeonato, -1200 Experiência de Einherjar, -1300 Cristal de Titã, -1400 Dente do Terror, -1500 Pedra do Caos, -1600 Cristais de Vênus, -1700..-1709 album gifts (MasterType 7), -1801 Chave de Baú, -1802 Cupom de sorteio do Gashapon, -1803 Moeda de Aniversário, -1900 Pontos de Inspiração, -2000..-2600 Cat House materials, -2700 Moeda Estelar, -2900 Pedra da Coragem, -3000 Essência da Fera, -3100 Essência do Plano, -3200 Nº de ressuscitações, -3300 Morte, -3400 Cristais da Terralém, -3500 Coração do Deus Ares, -3600 Ouro de Yalamen, -3700 Lágrimas de Athena, -3800 Cristais Vermelhos, -3900 Pontos da Glória, -4000 Moeda do Jogo, -4100 Cristais amarelos, -4200 Medalhas do Eremitério, -4300 Chaves do Julgamento, -4400 Medalhas da Força, -4500 Movimento, -4600 Cristais Energéticos, -4700 Prata de Moréia, -4800 Coração de Gelo, -4900 Cristal de localização, -5000 Cristal da diversão, -5100 Cristal da loucura, -5200 Ovo colorido, -5300 Bilhete para expedição, -5400 Lágrima de Desejo, -5500 Mérito, -5600 Cristal da masmorra, -11000 Marca dos Deuses, -15000 Pontos de guerreiro, -16000 Pó Mítico, -17000 Alma do labirinto, -18000 Pontos de Chefão, -19000 Gema Poseidon, -20000 Pontos de Folia, -21000 Pontos Minos, -22005 Pontuação do Mistério do Nevoado, -23000 Pontos Táticos. Owner: [../currency/README.md](../currency/README.md). A reward that contains a negative id credits the matching player counter instead of creating an item row.

### 5.7 Quality (`Profile`)

| Profile | Letter (`GP:32-49`) | Quality name (`GH:30-54`, `yishi.utils.GoodsHelp.getGoodQualityName0N`) | Descriptor (`GP:51-66`) | Color (`GST:480-499`, `GH:56-83`) | Items |
|---:|---|---|---|---|---:|
| 1 | D | Branco | Bruto | #ffffff | 440 |
| 2 | C | Verde | Ordinário | #59cd41 | 963 |
| 3 | B | Azul | Ótimo | #32a2f8 | 3 581 |
| 4 | A | Roxo | Sofisticado | #a838f7 | 4 897 |
| 5 | S | Laranja | Excelente | #ff8000 (#eb9504 in HTML text) | 1 443 |
| 6 | none ("Descuido" fallback) | Vermelho | Descuido (fallback) | #ce0f0f; senior equipment | 851 |
| 7 | none ("Descuido" fallback) | no case (key `getGoodQualityName07` "Vermelho" exists but is not referenced) | Descuido (fallback) | no case in `getColorByProfile` (empty), white in `getGoodsProfileColor`; third transfer equipment (`isThreeEquip`) | 26 |

Profile 0 (gray, #B3B3B3) exists only in `GH.getGoodColorString`.

### 5.8 Stacks

- A slot holds `count <= MaxCount` of one template with one bind flag. Two stacks merge only when `templateId` equal, `MaxCount > 1`, bind flag equal (`GM.findSuperpositionPos`, `GM:769-781`; guild warehouse check `decompiled/core_module/scripts/cell/mediator/consortiabag/ConsortiaBagDoubleClickMediator.as:122-147`). `GC.isAddToChecker` (`GC:394-401`) tests the opposite bind case for UI hints.
- Non stackable items (`MaxCount == 1`) always have `count == 1`.

### 5.9 Binding

The client only knows the boolean `bind` of an instance (`ItemInfoMsg.bind` #7, shown as "Vinculado" / "Não vinculado"). Rules the server must apply (from client checks and pt-BR texts):

| Rule | Evidence |
|---|---|
| Bound items cannot be listed on the auction | `decompiled/m7/scripts/auction/view/sell/AuctionSellBagPane.as:438`; `Auction.ResultAlert7` "Item foi vinculado" |
| Bound items and non bag 1 items cannot be put on a market stall | `decompiled/m3/scripts/map/campaign/view/market/MarketBagListView.as:67`, `:138`, `:163`, `:182` |
| Items bought with bound diamonds are bound | `view.subshop.ShopCartFrame.buyText1` "Esta compra contém diamantes vinculados, por isso os itens são vinculados" |
| Items from the Amethyst shop and the Christmas shop are bound | `view.subshop.MineralShopFrame.describe`, `view.subshop.ChristmasShopFrame.describe` |
| Enhancing, inserting gems, fashion conversion or synthesis, Einherjar equipment and some life skill operations bind the item | `Store.IntensifyView.Tip`, `store.StoreControler.content03`, `fashion.view.switch.bindsFashion`, `fashion.view.compose.bindsFashion`, `pet.advanced.equipbag.PetBagCellDropMediator.prompt02..05`, `store.lifeskill.CommonRightView.noMatetial05` |
| Bound and unbound copies of one template stack separately | 5.8 |
| Selling to the system, using, equipping and moving between own bags are allowed for bound items | no client check |

There is no template level bind flag: "bind on pickup / on equip" is decided by the server when it creates or modifies the instance (assumption, see 9).

### 5.10 Validity (expiry)

- Templates have no validity field; validity is per instance: `valid_date` (#9, minutes, 0 = permanent) and `begin_date` (#10, `YYYY-MM-DD hh:mm:ss`). Remaining seconds = `(valid_date * 60000 - now + begin_date) / 1000` (`decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as:333-340`).
- The bag views delete expired items by sending 8346 when they render them (see [bag.md](bag.md) B9).

### 5.11 Sell price

- Unit price = `SellGold`; the system pays `SellGold * count` (`GC:369-372`, `BH:433`). The batch sell view uses `SellGold * count` for MasterType other than 1 and 5, and `SellGold` for MasterType 1 and 5 (`decompiled/core_module/scripts/bag/view/ItemSellView.as:323-330`). The tooltip shows `SellGold * (1 + strengthenGrade * 2)` (`PT:179`); assumption: the server pays the tooltip value for enhanced equipment. Details in [sell.md](sell.md).

## 6. Templates

### 6.1 `raw/xml/tempinfos/ItemTempInfos.xml`

Record `ItemTempInfo`, 12 201 rows, all fields of 5.1. Attribute presence: 23 always present (`TemplateId`, `MasterType`, `SonType`, `Sexs`, `NeedGrades`, `MaxCount`, `TemplateName`, `Job`, `Refresh`, `Icon`, `Description`, `Profile`, `SellGold`, `DefaultSkill`, `Avata`, `StrengthenMax`, `RandomSkillCount`, `SuiteId`, `StartingPrice`, `TransformId`, `IsCanBatch`, `Feed`, `NeedChangeJob`); optional stats and `Property1..7` default to 0. Distributions: `IsCanBatch` true on 1 550; `StrengthenMax` in {0, 3, 6, 9, 10, 12, 15, 18, 20, 21, 24, 27, 30, 36, 40, 45, 50, 60}; `RandomSkillCount` 0..5; `NeedChangeJob` in {0, 1, 2, 5, 127}; `SellGold > 0` on 8 037; `StartingPrice > 0` on 3 233; `SuiteId > 0` on 559.

### 6.2 Related templates read by item features

| File | Use |
|---|---|
| `ConfigInfos.xml` | bag and storage prices (see [bag.md](bag.md), [storehouse.md](storehouse.md)) |
| `SuiteTempInfos.xml`, `ComposeTempInfos.xml`, `TransformInfos.xml`, `ItemResolveTemplates.xml` | smith ([../smith/README.md](../smith/README.md)) |
| `MountTempInfos.xml`, `PetTempInfos.xml`, `AppellInfos.xml`, `ArtifactTemplateInfos.xml` | targets of SonType 218, 306, 221, 625 |
| `BoxItems.xml` (empty), `GradeDrop.xml` (empty), `TimeDrop.xml`, `PrivilegeDrops.xml` (empty) | [boxes.md](boxes.md), [bag360.md](bag360.md) |
| `SlateTmpls.xml`, `SlateTaskTmpls.xml`, `SlateUpgradeTmpls.xml` | [slate.md](slate.md) |
| `StoreHouseChapterTmpls.xml`, `StoreHouseMapTmpls.xml` | [thess-box.md](thess-box.md) |

### 6.3 Missing data

Open box (206), paid chest (311), novice pack (298) and collection chest (350) contents are not in the client XML (`BoxItems.xml` and `GradeDrop.xml` are empty). They must be rebuilt from `Description` texts or other sources ([boxes.md](boxes.md)).

## 7. Persistent state

None. Templates are loaded from the XML at server start into an immutable registry (`inventory::catalog`). Assumption: no SQL table; if reporting needs SQL joins, a read only `inventory.item_templates` copy can be generated from the XML at deploy time.

## 8. Backend implementation notes

- `inventory::catalog::load(root)` parses `ItemTempInfos.xml` once (12 201 rows, about 6 MB); index by `TemplateId`; expose typed accessors (`master_type`, `son_type`, `max_count`, `sell_gold`, `need_grades`, `jobs: Vec<i32>`, `sexs`, `props: [i32; 7]`, `is_can_batch`, `need_change_job`, `profile`).
- Validation helpers shared by every feature: `can_equip(hero, template)` (MasterType 1/3 or SonType 214; job, sex, level, `NeedChangeJob`, `isVocationFix` for 117/118), `stack_key(template_id, bind)`, `is_precious(item)`.
- Currency ids are handled by `currency::credit(player, template_id, amount)` (see [../currency/README.md](../currency/README.md)) whenever a reward or cost uses a negative id.
- The flows engine in `server/flows.json` can keep using the XML; no migration needed.

## 9. Open questions and assumptions

- Assumption: the server uses the same `ItemTempInfos.xml` as the client (the client file is the only source).
- Box drop tables (206, 298, 311, 350) and `BoxItems.xml` are missing. The server must define them (from descriptions) before boxes can be implemented.
- Binding origin rules (bind on pickup, bind on equip) are not visible in the client; the table in 5.9 lists only rules with textual evidence. Assumption: items obtained from quests, drops and system rewards are created bound unless the reward says otherwise.
- `Sexs = 0` appears on 84 props and on all 144 slates; it is only enforced on the equip path (`GC.checkGoodsByHero`), so props stay usable by both sexes.
- The meaning of `Property7` on hero equipment and `Property4` on transformation cards is not confirmed.

## 10. Implementation checklist

- [ ] `inventory::catalog` loader for `ItemTempInfos.xml` with all fields of 5.1
- [ ] MasterType and SonType enums with the values of 5.2 and 5.3
- [ ] Requirement helpers (level, job CSV, sex, `NeedChangeJob`, vocation for 117/118)
- [ ] Stack key and `MaxCount` enforcement helper
- [ ] Precious goods helper (`GST.isPreciousGoods`)
- [ ] Currency id dispatch for negative ids
- [ ] SonType 203 subtype effect table (5.4.1)
- [ ] Binding rules (5.9) applied by shop, smith, auction, market, Einherjar
- [ ] Test: every SonType present in the XML maps to a behaviour (equip, use, move only, storage)
- [ ] Test: tooltip relevant fields (bind, valid date, sell price) round trip through `ItemInfoMsg`
