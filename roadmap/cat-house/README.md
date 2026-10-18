# Casa de Gato (`cat-house`)

Domain: home. Client package `cathouse` (m11: `cathouse/*.as`, `cathouse/courtyard/*.as`) plus shared code in `core_module`: `managers/CatHouseManager.as`, `mvc/controler/CatHouseController.as`, `yishi/datas/templates/cate/CatHouseTemplateCate.as`, `mvc/module/currency/CurrencyType.as` (cat toy currencies), the reward tip `m16/scripts/yishi/view/tips/CatRewardTips.as` and the castle bubble in `m4/scripts/castle/view/layer/CastleWalkLayer.as`. Protobuf package `cat` (`CattoysInfoMsg`, `CattoysInfoListMsg`).

## Overview

"Casa de Gato" is an idle courtyard with 5 fixed toy spots. The player obtains cat toys ("brinquedos": swing, pad, stick, ball, box, 5 qualities each) by exchanging gold or cat materials, then places one toy per spot. A placed toy attracts 1 to 5 cats whose quality falls in the toy's range. After the toy's growing time (3 to 20 hours) the spot can be harvested: the toy pays gold (`OutGold`) and each cat pays cat materials ("Madeira", "Corda", "Flanela", "Jornal", "Algodão", "Pena", "Nepenta"), which buy better toys. Removing a toy before harvest gives nothing. A Magic Spring buff raises the gold collected.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Day guide item 65 | `newbieProcess > 25000` else `dayGuide.DayGuideManager.command01` | controller `cathouse` (openType 0) -> `CatHouseFrame` | `decompiled/core_module/scripts/managers/DayGuideManager.as:830-837` |
| Home hub cat button handler `FarmEnterNewFrame.__onCatBtnClick` | defined but never wired to a button in this client | controller `cathouse` | `decompiled/m3/scripts/farm/FarmEnterNewFrame.as:147-150` |
| Castle bubble `castle.catHouse` over the farm building (1130, 190) | shown when any placed toy has `state == 2` | visual only | `decompiled/m4/scripts/castle/view/layer/CastleWalkLayer.as:505,529,676-679` |
| Empty spot "lay" button | | controller `cathouse` openType 1 with the spot toy type -> `CatHouseExchangeFame` | `decompiled/m11/scripts/cathouse/CatObjectPutConatiner.as:199-202`, `decompiled/core_module/scripts/mvc/controler/CatHouseController.as:19-39` |

## Modules

| Module | File | Scope |
|---|---|---|
| Toy exchange | [toy-exchange.md](toy-exchange.md) | toy catalogue per type, exchange with gold or materials (diamond top up), toy stock |
| Courtyard | [courtyard.md](courtyard.md) | 5 spots, place, cats roll, growing timer, harvest, remove, info request, castle bubble |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 9585 | 0x2571 | `C_CATTOYS_OP` (`CattoysInfoMsg`, op 1..5) | both |
| S>C | 331 | 0x014b | `U_C_CATTOYS_INFO` (`CattoysInfoListMsg`, full list) | both |
| S>C | 4725 | 0x1275 | `U_C_PLAYER_TOKENINFO` (`PlayerTokenInfoMsg`, cat materials masterType 1001..1007) | both |

`CattoysInfoMsg.op` (`decompiled/core_module/scripts/managers/CatHouseManager.as:19-27`): 1 `OP_EXCHANGE`, 2 `OP_PLACE`, 3 `OP_REWARD`, 4 `OP_DISMANTLE`, 5 `OP_REQUEST`.

## Dependencies

- [currency](../currency/README.md): gold resource (-100), diamonds, cat material tokens 1001..1007 via 4725.
- [fantasy-bar](../fantasy-bar/README.md): Magic Spring buffer type 1 "Ouro coletado na Casa de Gatos +{0}%".
- [castle](../castle/README.md): castle bubble.
- [daily-activity](../daily-activity/README.md): day guide item 65.
- [farm](../farm/README.md): home hub frame (`FarmEnterNewFrame`).

## Suggested implementation order

1. Tables and `CattoysTemplateInfos.xml` loader; material tokens 1001..1007 in the currency service.
2. op 5 request -> 331 (and push 331 at login for the castle bubble).
3. op 1 exchange (gold and material paths, diamond top up).
4. op 2 place with cat roll and timer.
5. op 3 harvest, op 4 remove.
