# Cosmos e astrologia (`cosmos`)

Domain: character. Client packages `star` (m5), `stararea` (m3), `stargazing` (m14), plus shared code in `core_module` (`yishi/manager/StarManager.as`, `yishi/manager/StarGazingManager.as`, `mvc/module/star/*`, `mvc/module/stararea/*`, `mvc/module/stargazing/*`, `cell/view/starbag/StarBagCell.as`, `yishi/utils/StarHelper.as`) and the star shop in m15 (`view/subshop/StarShopFrame.as`). Protobuf packages `star`, `stargazing`, plus `active.StarAreaMessage` and `simple.PropertyMsg` used by the star area.

## Overview

Three independent systems share the "star" theme:

1. **Astrologia / Cosmos** (`StarFrame`, title "Astrologia"). The player pays gold (or a daily free use) on one of five crystals ("Estrela Mística", "Estrela Angelical", "Estrela Espiritual", "Estrela Divina", "Estrela de Deus") to roll a star ("cosmo") into a temporary area of 18 cells. Rolled stars are collected ("Colher") into the cosmos bag (12 cells + 6 buyable) or sold ("Vender") for gold. Stars of equal quality are merged ("síntese"): one star absorbs others as experience and levels up to 10. Up to 10 stars are equipped in the "Horóscopo" (8 normal slots unlocked every 10 hero levels, 2 advanced slots for job advanced heroes) and add hero attributes. Each of the 8 normal slots ("trough") can be refined ("Refinação do Cosmo") to add +N% to the equipped star. Red level 10 stars can be sublimated into "Sagrado" stars ("Elevação de Cosmos") and fed with "Pó da Ilusão". Astrology points ("pontos de astrologia") buy specific stars in "Resgatar Pontos".
2. **Astronomia** (`StarGazingFrame`). Unlocked at max archaeology level. Twelve zodiac signs, each with 12 star charts of 9 fragments filled with "Carta Celeste" items; "Força das Estrelas" lights 45 points per sign with "Fogo das Estrelas" to boost the chart attributes; "Desejo" converts "Fragmento de Céu Estrelado" into wish counters that draw daily reward lists.
3. **Expedição no espaço-tempo** (`STARAREA_SCENE`, `stararea` package). A seasonal (seven-year anniversary) node and road map of 92 nodes and 152 roads. Moving costs "Movimento"; roads can be forbidden, locked (need "Chave da Área Perdida"), battles (battleType 3892) or mini games; nodes give "Luz do Caminho", keys, warrior points, fashion and a rare mount.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Main toolbar star button `_starBtn` ("StarBtn") | button shown by toolbar unlock rules; glows when task 1802 completes | `StarFrame` (controller `star`, default openType) | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:330,1523-1541,498-503` |
| Hotkey `H` | hero level >= 18 | `StarFrame` | `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:133-134,575-603` |
| `SwitchPageHelp` (day guide, links) | level >= 18 else "Nível baixo, função habilitada no Nv. {0}" | `StarFrame` or `HoroscopeFrame` (openType 1) | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1165-1175,1705-1713` |
| Day guide item 84 | | `StarFrame` | `decompiled/core_module/scripts/managers/DayGuideManager.as:933-935` |
| Task trace tip type 8 ("star not full") | level 18..40 with low star power and enough gold | `StarFrame` | `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2889-2891`, `decompiled/m16/scripts/tasktracetip/view/StarTipView.as:34-38`, `SM:532-547` |
| Horoscope "Elevação" button | `thane.vocationGrades > 0` | `SubStarFrame` (openType 5) | `decompiled/m5/scripts/star/HoroscopeFrame.as:121,289-293`; also `decompiled/m5/scripts/armyII/viewII/information/GoodsExchangeItem.as:476-481` |
| "Resgatar" button in astrology | | shop controller openType 101 -> `StarShopFrame` | `decompiled/m5/scripts/star/view/MakeStarView.as:202-206`, `decompiled/core_module/scripts/mvc/controler/ShopControler.as:83-86` |
| Archaeology "stargazing" button, star items 8001001..8001017 used from the bag, `SwitchPageHelp.openStarGazingFrame` | archaeology level >= 3 (max) else "Ativado quando a Arqueologia atinge o nível máximo." | `StarGazingFrame` (tab by item) | `decompiled/m14/scripts/archaeology/ArchaeologyMakeRightView.as:109-113`, `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:565-596`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2488-2496` |
| Seven-year event tab "Expedição" play button | `SevenYearManager.model.checkFlag()` | `STARAREA_SCENE` | `decompiled/m11/scripts/sevenyear/view/SevenYearStarAreaView.as:162-163,339-343` |

## Modules

| Module | File | Scope |
|---|---|---|
| Star divination | [star-divination.md](star-divination.md) | crystals, rolling, temporary area, pick/sell, quick and auto astrology, daily reset |
| Star equipment | [star-equip.md](star-equip.md) | cosmos bag, horoscope slots, move/equip, devour and bag synthesis, lock, buy bag cells, star power |
| Star slot refinement | [star-addition.md](star-addition.md) | "Refinação do Cosmo" of the 10 star troughs |
| Star sublimation | [star-sublime.md](star-sublime.md) | "Elevação de Cosmos": red level 10 star to "Sagrado", feeding "Pó da Ilusão" |
| Star shop | [star-shop.md](star-shop.md) | "Resgatar Pontos": buy stars with astrology points |
| Stargazing | [stargazing.md](stargazing.md) | "Astronomia": wish, star charts, star force |
| Star area | [stararea.md](stararea.md) | "Expedição no espaço-tempo" map scene |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 8269 | 0x204d | `C_STAR_RAND` | star-divination |
| C>S | 8268 | 0x204c | `C_STAR_PICK` | star-divination |
| C>S | 8876 | 0x22ac | `C_STAR_SPECIAL` | star-divination |
| C>S | 8325 | 0x2085 | `C_STAR_DATA_RESET` | star-divination |
| C>S | 8331 | 0x208b | `C_STAR_COMPOSE` | star-divination (bag 0), star-equip (bag 1) |
| C>S | 8267 | 0x204b | `C_STAR_MOVE` | star-equip, star-sublime |
| C>S | 8330 | 0x208a | `C_STAR_LOCK` | star-equip |
| C>S | 8270 | 0x204e | `C_STAR_BUY` | star-equip |
| C>S | 8772 | 0x2244 | `C_STAR_ADDITION` | star-addition |
| C>S | 5182 | 0x143e | `C_STAR_SUB_OP` | star-sublime |
| C>S | 8341 | 0x2095 | `C_STARSHOP_BUY` | star-shop |
| C>S | 5188 | 0x1444 | `C_STARGAZING_OP` | stargazing |
| C>S | 9691 | 0x25db | `C_STARAREA_OP` | stararea |
| S>C | 4180 | 0x1054 | `U_C_STAR_RAND` | star-divination |
| S>C | 4179 | 0x1053 | `U_C_STAR_PICK` | star-divination |
| S>C | 4479 | 0x117f | `U_C_STAR_COMPOSE` | star-divination |
| S>C | 4178 | 0x1052 | `U_C_START_MOVE_UPDATE` | star-equip (all star cell changes) |
| S>C | 4677 | 0x1245 | `U_C_STAR_ADDITION` | star-addition |
| S>C | 4261 | 0x10a5 | `U_C_STARSHOP_BUY` | star-shop |
| S>C | 4687 | 0x124f | `U_C_STARGAZING_OP` | stargazing |
| S>C | 4899 | 0x1323 | `U_C_STARAREA` | stararea |
| S>C | 3 | 0x0003 | `U_C_PLAYER_INFO` (`PlayerMsg.star_count` #43, `startFree` #48, `starpoint` #57) | owned by hero, fields owned here |

`U_C_PLAYER_TIMESTAR` 4250 (0x109a) exists in `opcodes.csv` but has no client listener; do not implement.

## Dependencies

| Feature | Why |
|---|---|
| [hero](../hero/README.md) | star attributes (template stat x grade, plus trough %) feed hero stats and combat power; `PlayerMsg` (opcode 3) carries `star_count`, `startFree`, `starpoint`; `vocationGrades`/`vocationLevel` (job advance) gate advanced slots, refinement and sublimation |
| [currency](../currency/README.md) | gold (castle update 109) for astrology, refinement and sales; "Pó da Ilusão" is currency masterType 27 `newMagicDust` (currency refresh push 4725) |
| [inventory](../inventory/README.md) | stargazing consumes bag items 8001001..8001017; item use opens the stargazing frame |
| [shops](../shops/README.md) | star shop is opened through the shop controller (openType 101) and uses `NumBuyFrame` |
| [vip](../vip/README.md) | quick astrology (VIP1) and auto astrology (VIP2) below level 60/80; "Diamante" payment for bag cells (`PayTypeMsg`) |
| [quests](../quests/README.md) | task 1802 ("Mestre de Cosmos") unlocks equip slot 8 |
| [archaeology](../archaeology/README.md) | stargazing opens at max archaeology level |
| [fantasy-bar](../fantasy-bar/README.md) | magic spring buffer type 5 changes astrology cost and sell price display |
| [account](../account/README.md) | item lock password ("senha secundária", `vicepassword`) gates the star lock tool |
| [chat](../chat/README.md) | shift click sends a star link; shop success writes a local chat line |
| [seasonal-events](../seasonal-events/README.md), [hermitage-war](../hermitage-war/README.md) | star area is a seven-year anniversary activity (`sevenyear` package); the link mini game reuses the air garden link game |
| [casino](../casino/README.md) | gem maze mini game (`monopoly` package) is reused by the star area |
| [mounts](../mounts/README.md), [fashion](../fashion/README.md) | star area rewards (rare mount 2183094, expedition fashion) |

## Suggested implementation order

1. `cosmos.stars`, `cosmos.star_state`, `cosmos.star_troughs` tables and the login burst (4178 full list, 4180 crystal state and temporary stars, 4677 troughs, `PlayerMsg` star fields). Without 4180 at login the astrology frame crashes (`MakeStarView` reads `randomPosList.length`).
2. star-divination (8269, 8268, 8331 bag 0, 8325) and the star point/free count rules.
3. star-equip (8267 move/eat, 8331 bag 1, 8330 lock, 8270 bag cells) and the hero stat integration.
4. star-shop (8341).
5. star-addition (8772).
6. star-sublime (5182).
7. Auto astrology (8876).
8. stargazing (5188).
9. stararea (9691) together with the seven-year event and its mini games.
