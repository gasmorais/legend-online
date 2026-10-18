# Fazenda e residência (`farm`)

Domain: home. Client packages `farm` (core_module `farm/*`: `FarmManager`, `FarmModel`, data, cells, land and animal views; m3 `farm/*`: frames, home hub, scene layers, workshops, marriage tree view), `home` (core_module `home/HomeSender.as`; residence model `mvc/module/home/*`, `managers/HomeManager.as`; residence map views `m3/scripts/map/campaign/view/house/*`, `mediator/house/*`, `mediator/farm/FarmMediator.as`) and `water` (m3 `water/view/*`, core_module `water/*`, `yishi/manager/WaterManager.as`, `yishi/datas/playerinfo/TreeInfo.as`). Protobuf package `farm` (16 messages) plus `children.HomeMsg`, `children.ChildrenOpMsg`, `children.FurnitureMsg`, `children.FurnitureDecMsg`, `children.FurnitureShopBuyMsg`, `children.ShowMountMsg`, `children.BonfireEventMsg` (package owned by [guardians](../guardians/README.md), messages used here), `building.BuildingReqMsg` (tree water and pick).

## Overview

"Residência" groups the home systems of a player:

- **Fazenda** (farm): 18 plots on a grid (3 open by default, one more every 5 farm levels). Seeds from the "Armazém" are dragged onto plots; crops grow for the seed's time, may catch worms or weeds, become ripe, and die if not harvested in time. Friends can kill worms, weed, revive dead crops and steal ("coletar") part of a ripe crop. Farm experience (80 farm levels, capped at the hero level) comes from every action. From farm level 30 the soil ("Nível do Solo") can be upgraded with diamonds to grow faster and yield more.
- **Área de Pastagem** (pasture): animals bought as items (SonType 1500) grow to produce "Leite de Cordeiro"; they get hungry, gloomy or ill and must be fed, comforted or cured; friends may help and steal. Capacity 3 at farm level 5, +1 every 5 levels, max 18.
- **Yggdrasil** (water tree): the farm's tree is "energized" once per day by the owner and once per day by each friend; a full tree gives fruits ("Cristais de Luz" and "Espíritos") that the owner collects.
- **Oficina de magia** (workshop): recipes that turn farm products into boxes and teas (generic compose route).
- **Residência** house and garden maps (5601.., 5501..): a decorated house interior and a garden (yard) where the owner places furniture bought in the furniture shop, receives visitors, hosts a daily "Festa da fogueira" (bonfire party) with invitations, dice, sitting and transformations, and shows mounts.
- **Árvore do casal** (marriage tree) on the pasture, and **Prática do Einherjar** (pet practice plots, guard pet), owned by [marriage](../marriage/README.md) and [einherjar](../einherjar/README.md) but stored in the farm messages.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Castle building 1509 ("Residência") | hero level >= 12 else "Fazenda não ativado!" | controller `farm` openType `CastleBuildingView.FarmEnterNewFrame` -> `FarmEnterNewFrame` "Residência" | `decompiled/m4/scripts/castle/view/CastleBuildingView.as:343-350`, `decompiled/core_module/scripts/mvc/controler/FarmController.as:36-60` |
| `SwitchPageHelp.gotoFarmFrame` (day guide, game guide) | not botting (`mopup.MopupManager.mopupTipData01`), level >= 12 (`dayGuide.DayGuideManager.command02`), scene check | same | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1754-1775`, `decompiled/core_module/scripts/managers/DayGuideManager.as:1063`, `decompiled/m11/scripts/dayguide/gameguide/GameGuideItem.as:125` |
| `FarmEnterNewFrame` farm button / pasture button | | `HomeFrame` type 1 "Fazenda" / type 2 "Área de Pastagem" | `decompiled/m3/scripts/farm/FarmEnterNewFrame.as:137-145` |
| `FarmEnterNewFrame` residence button | | 8873 op 1003 enter own house | `FarmEnterNewFrame.as:167-170` |
| `FarmEnterNewFrame` ship button | `VersionSwitch.NAVIGATION`, level >= 80 | [navigation](../navigation/README.md) | `FarmEnterNewFrame.as:152-165` |
| Tutorial node 10 | | `showHomeFarmValue = 1`: `HomeFrame` type 1 opens when the house map loads | `decompiled/m8/scripts/nodes/NoviceNode_10.as:138`, `decompiled/m3/scripts/map/campaign/mediator/house/HouseUIMediator.as:56-63` |
| Castle bubble `castle.pick` (1130, 190) | a ripe plot (1) or animal (2) | visual | `decompiled/m4/scripts/castle/view/layer/CastleWalkLayer.as:504,528,671-674`, `decompiled/core_module/scripts/farm/FarmManager.as:665-687` |
| Secretary chore 8 "Fazenda e Pastagem" | level >= 12 | 15044 op 25 and 26 | [../secretary/chore-actions.md](../secretary/chore-actions.md) |
| Friend list in residence / farm frames | friend level >= 12 and farm state known | friend farm or friend house | `decompiled/m3/scripts/water/view/FarmFriendListView.as:210-232,446-460` |
| Chat invite "Convite da festa da fogueira" (room invite type 100) | | accept or refuse the party invite | `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2348-2356,2467-2471,2489-2520` |

## Modules

| Module | File | Scope |
|---|---|---|
| Farm core | [farm-core.md](farm-core.md) | `HomeFrame`, farm info load and refresh, farm level and experience, friends and their farm states, logs, soil upgrade, plot opening, login data, integrity probe |
| Farmland | [farmland.md](farmland.md) | crops: plant, worms, weeds, harvest, revive, accelerate, remove, steal, one key harvest, crop templates |
| Pasture | [pasture.md](pasture.md) | animals: add, feed, comfort, cure, harvest, steal, sell, accelerate, one key harvest |
| Yggdrasil | [yggdrasil.md](yggdrasil.md) | water tree: tree info, energize (water), collect fruits, logs |
| Workshops and storage | [workshops.md](workshops.md) | "Armazém" seed and animal bag, farm shop, "Oficina de magia" compose, "Oficina da alimentação" |
| Residence | [residence.md](residence.md) | house and garden maps, enter, `HomeMsg`, furniture layout, furniture shop, random event furniture, dormant house ops |
| Bonfire party | [bonfire-party.md](bonfire-party.md) | garden party: start, countdown, invitations, dice, sit, transformation, mount showcase |
| Pet practice | [pet-practice.md](pet-practice.md) | farm side of the einherjar practice plots and guard pet (ops 13, 15, 16, 17, 18) |
| Marriage tree | [marriage-tree.md](marriage-tree.md) | pasture view of the couple tree (8773, 4678, `MarriageTreeMsg`) |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 15044 | 0x3ac4 | `CH_FARM_OPER_CHECK` (`FarmOperReqMsg`, op_type 0..26) | farm-core, farmland, pasture, pet-practice |
| C>S | 8231 | 0x2027 | `C_REQ_FRIEND_FARM_STATE` (`FriendUserIdsMsg`) | farm-core |
| C>S | 8219 | 0x201b | `C_TREE_FRIEND` (`FriendTreeReq`) | yggdrasil |
| C>S | 15017 | 0x3aa9 | `CH_TREE_WATER` (`BuildingReqMsg`) | yggdrasil |
| C>S | 5178 | 0x143a | `U_C_TREE_PICK` (`BuildingReqMsg`) | yggdrasil |
| C>S | 8873 | 0x22a9 | `C_HOME_OP` (`ChildrenOpMsg`, op_type 1..13, 1001..1007) | residence, bonfire-party |
| C>S | 9519 | 0x252f | `C_FURNITURE_SHOP_BUY` (`FurnitureShopBuyMsg`) | residence |
| C>S | 5125 | 0x1405 | `U_C_CAMPAIGN_ARRIVE` (bonfire node 1001) | bonfire-party |
| C>S | 5153 | 0x1421 | `U_C_ITEM_COMPOSE` (`StoreReqMsg`, recipe Types 101..103) | workshops |
| C>S | 8773 | 0x2245 | `C_MARRIAGE_TREE_REQUEST` | marriage-tree |
| C>S | 8598 | 0x2196 | `C_CC` integrity probe answer (not in `protocol/opcodes.csv`) | farm-core |
| S>C | 4157 | 0x103d | `U_C_LOAD_WATER` (`LoadFarmRsp`, login) | farm-core, yggdrasil |
| S>C | 4386 | 0x1122 | `U_C_FARM_INFO` (`FarmInfoRspMsg`) | farm-core |
| S>C | 4387 | 0x1123 | `U_C_FARMLAND_INFO` (`FarmInfoRspMsg`, operation result) | farm-core, farmland, pasture, pet-practice |
| S>C | 4190 | 0x105e | `U_C_CANWATER_USERS` (`LoadFarmRsp`, friend states) | farm-core |
| S>C | 4146 | 0x1032 | `U_C_TREE_FRIEND` (`FriendTreeRsp`) | yggdrasil |
| S>C | 147 | 0x0093 | `U_C_TREEINFO_UPDATE` (`TreeUpdateRsp`) | yggdrasil |
| S>C | 146 | 0x0092 | `U_C_HARVEST_MSG` (`TreeUpdateRsp`, water result) | yggdrasil |
| S>C | 106 | 0x006a | `U_C_TREE_PICK` (`TreeUpdateRsp`, pick result) | yggdrasil |
| S>C | 4189 | 0x105d | `U_C_PICK_HARVEST_MSG` (`TreeUpdateRsp`) | yggdrasil |
| S>C | 4158 | 0x103e | `U_C_SEND_WATER_RESULT` (`FarmLogRsp`) | yggdrasil |
| S>C | 145 | 0x0091 | `U_C_WATERLOG_SEND` (`FarmLogRsp`) | yggdrasil, farm-core |
| S>C | 4753 | 0x1291 | `U_C_HOME_INFO` (`HomeMsg`) | residence, bonfire-party |
| S>C | 4757 | 0x1295 | `U_C_SELECT_HOME` (`HomeMsg`) | residence |
| S>C | 4969 | 0x1369 | `U_C_COURTYARD_EVENT` (`BonfireEventMsg`) | bonfire-party |
| S>C | 4982 | 0x1376 | `U_C_COURTYARD_FIRE_COUNTDOWN` (`HomeMsg`) | bonfire-party |
| S>C | 16 | 0x0010 | `U_C_CAMPAIGN_ROOM_INVITE` (`RoomInviteMsg`, room_type 100) | bonfire-party |
| S>C | 4678 | 0x1246 | `U_C_MARRIAGE_TREE` (`MarriageTreeMsg`) | marriage-tree |

`FarmOperReqMsg.op_type` (`decompiled/core_module/scripts/farm/data/FarmOperateType.as`): 0 `QUERY`, 1 `ADD_ITEM`, 2 `CLEARWORM`, 3 `CLEARGRASS`, 4 `PACIFY`, 5 `CURE`, 6 `REAP`, 7 `FEED_LIVESTOCK`, 8 `REVIVE`, 9 `ACCELERATE`, 10 `CLEARCROP`, 11 `FARM_LAND_UPGRADE`, 12 `FARM_UPGRADE_OPEN_NEWLAND`, 13 `FARM_FEED`, 14 `STOLEN`, 15 `PRACTICE_PET`, 16 `CANCEL_PRACTICE_PET`, 17 `COMPLETE_PRACTICE_PET`, 18 `GUARD_PET`, 19 `GET_CURRENT_FARMINFO`, 21 `NO_OPER`, 22 `SHOW_MENU`, 23 `GIVE_POWER`, 24 `TREE_PICK`, 25 `ONE_KEY_PLANT`, 26 `ONE_KEY_ANIMAL`. Values 12, 17, 19, 21, 22, 23, 24 are never sent as requests by this client (21, 22 are UI states; 23, 24 are experience keys).

`ChildrenOpMsg.op_type` for 8873 (`decompiled/core_module/scripts/home/HomeSender.as:13-41`, `FarmManager.as:59-71`): 1 upgrade house, 2 buy furniture, 3 save house furniture, 4 confirm garden user, 5 upgrade garden, 6 save garden furniture, 7 get garden reward, 8 employ maid, 9 request garden reward, 10 renew maid, 11 sit down, 12 dice, 13 show mount, 1001 buy house, 1002 enter garden, 1003 enter house, 1004 click event furniture, 1005 select home, 1006 invite friends, 1007 answer invite.

## Dependencies

- [castle](../castle/README.md): building 1509, castle bubbles, gold storage limit.
- [friends](../friends/README.md): friend list for visits, help and steal; friend farm states.
- [inventory](../inventory/README.md): seeds (SonType 216), animals (1500), products, bag pushes 115.
- [currency](../currency/README.md): diamonds and bound diamonds (accelerate, soil upgrade), gold, "Cristais de Vênus" (-1600) for furniture.
- [shops](../shops/README.md): farm shop (shop openType 6), furniture shop (ShopType 20).
- [smith](../smith/compose.md): compose route 5153 used by the workshop.
- [campaign](../campaign/README.md): residence maps are campaign rooms (enter, walk, nodes, 5125 arrive).
- [mounts](../mounts/README.md): mounts shown in the garden.
- [einherjar](../einherjar/pet-land.md), [marriage](../marriage/README.md), [guardians](../guardians/README.md) (`children` proto, child house events).
- [fantasy-bar](../fantasy-bar/README.md): Magic Spring buff 2 "Colheita da fazenda +{0}%" / "Colheita da área de pastagem +{0}%".
- [vip](../vip/README.md): King Contract buff 8 required for garden auto pick.
- [secretary](../secretary/README.md): one key harvest chore.
- [account](../account/security-code.md): integrity probe 8598 carried by farm land updates.

## Suggested implementation order

1. Schema `farm` and template loaders (seeds, animals, UpGrade Types 7, 17, 45, 46, configs).
2. Login push 4157 and 15044 op 0 -> 4386 for own and friend farms; 8231 -> 4190.
3. Farmland ops (1, 2, 3, 6, 8, 9, 10, 14, 25) with 4387 results, growth and pest scheduler, experience rules.
4. Pasture ops (1 on pos >= 1000, 4, 5, 6, 7, 9, 10, 14, 26).
5. Soil upgrade (op 11) and plot opening on level up.
6. Yggdrasil (8219, 15017, 5178 and pushes).
7. Workshop recipes (compose Types 101..103) and farm shop.
8. Residence maps, `HomeMsg`, furniture layout and furniture shop.
9. Bonfire party and invites; mount showcase.
10. Pet practice and marriage tree integration with their owners.
