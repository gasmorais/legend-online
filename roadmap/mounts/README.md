# Mounts ("Montarias")

Feature slug `mounts`, domain `companions`. Registry (`roadmap/features.json`): client packages `mounts` (`decompiled/m14/scripts/mounts`, 11 classes) and `spacetime` (`decompiled/m9/scripts/spacetime`, 4 classes), no proto package of its own (messages live in proto package `campaign`). Following the code adds the shared model `core_module/scripts/mvc/module/mounts/*` (12 classes), `MountsManager`, `MountsController`, the m15 shop frames and the player info viewer.

For the player: every lord has one mount ("Montaria"). Training ("Adestrar") with "Pedra Bestial" or diamonds raises four attributes (Força, Inteligência, Físico, Proteção) that are added to the lord, and the mount grade, which unlocks faster horses. Mount appearances ("Feras") are collected from cards, unlock items, diamonds, VIP and king items; each adds attributes and "Ponto Bestial". Appearances can be ridden on the maps, refined to 5 stars ("Refinar"), made able to fly ("Pedra de Voo"), and strengthened by the refining soul ("Refino Espiritual de Fera"). A mount card shop ("Loja de montaria") sells cards for "Essência da Fera". King mounts ("Treino do Deus da Fera") have their own level. The `spacetime` package is the result screen of the "Piso do Tempo" PvE campaign and is documented separately because the registry places it here.

| Module | pt-BR name | What it covers | Transport |
|---|---|---|---|
| [mount-core.md](mount-core.md) | "Montaria", "Adestramento" | mount record (`MountInfoMsg`), grade, attribute GP and cap, training (op 1), ride/dismount (op 3), view another player's mount (op 5), training discount | 8529 ops 1, 3, 5 / 4426, 4459, 150 |
| [avatars-and-wild-souls.md](avatars-and-wild-souls.md) | "Feras", "Transformar", "Pode voar" | owned appearances list, activation (op 4), change appearance (op 2), buy flight (op 13), mount cards and decomposition, VIP mount, expiry, soul score | 8530 / 4427, 4679, 4610; 8529 ops 2, 4, 13; item use 5006 |
| [star-promotion.md](star-promotion.md) | "Refinar" | stars 0..5 with "Armação da Fera", blessing, free first refine | 8529 op 6 / 4679 |
| [refining-soul.md](refining-soul.md) | "Refino Espiritual de Fera", "Vontade da Alma da Fera" | refining grades and percentage bonus | 8529 op 12 / 4426 #16..#20 |
| [mount-shop.md](mount-shop.md) | "Loja de montaria", "Previsão de Qualidade", "Essência da Fera" | card shop, refresh, pool preview, mount coin | 8529 ops 8..11 / 4975, 305, 4725 |
| [mount-king.md](mount-king.md) | "Treino do Deus da Fera" | king mounts 9001..9004, king level training | 8529 op 7 / 4973, 4974 |
| [spacetime-fault.md](spacetime-fault.md) | "Piso do Tempo" | weekly result, claim and share of campaigns 9998/9999 | 9653 / 446, 447 |

Conventions used in every module file:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `build/`, `server/` or `docs/`. Readable TypeScript: `build/as3/gen/<package>/<Class>.ts`.
- Opcode names come from `protocol/opcodes.csv`; proto fields from `protocol/proto.json` (`num`, `type`, `repeated`). Missing there and taken from the AS3 constants or message classes: 8843/4723 (`C_NEW_MOUNT_ACTIVE`/`U_C_NEW_MOUNT_ACTIVE`), 4725 (`U_C_PLAYER_TOKENINFO`) and `simple.PropertyMsg` (name collision with `army.PropertyMsg`).
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is used by this feature.

## 8529 op table

All mount actions use 8529 (0x2151) `C_MOUNT_OP` with `MountEditMsg` (package `campaign`): `property_type` (#1, INT32), `pay_type` (#2, INT32), `param1` (#3, INT32), `param2` (#4, INT32), `op` (#5, INT32). Sender `MountsManager.mountOperateSend` (`core_module/scripts/managers/MountsManager.as:388-398`); op names from `core_module/scripts/mvc/module/mounts/MountsOpType.as:6-30`.

| op | Constant | Sender | `property_type` | `pay_type` | `param1` | `param2` | Response | Module |
|---|---|---|---|---|---|---|---|---|
| 1 | `MOUNT_EDIT` | train (`m14/scripts/mounts/MountsFrame.as:816`) | attribute 0 Força, 1 Proteção, 2 Inteligência, 5 Físico | 0 bound diamonds allowed, 1 real only | train count 1..9999 | 0 | 4426 (+115, 3) | [mount-core.md](mount-core.md) |
| 2 | `MOUNT_CHANGE` | "Transformar" (`m14/scripts/mounts/WildSoulFrame.as:437`) | 0 | 0 | template id | 0 | 4426 (+150 if riding) | [avatars-and-wild-souls.md](avatars-and-wild-souls.md) |
| 3 | `ARMYMOUNT_AVATARCHANGE` | ride/dismount (`MountsFrame.as:838, 860`) | 0 | 0 | 1 ride, 0 dismount | 0 | 150 `ArmyMsg` | [mount-core.md](mount-core.md) |
| 4 | `MOUNTAVATAR_ACTIVE` | activate locked avatar (`WildSoulFrame.as:626`) | 0 | 0 bound allowed, 1 real only | template id | 0 | 4679 or 4427, 4426 (+115, 3; 4973 for kings) | [avatars-and-wild-souls.md](avatars-and-wild-souls.md) |
| 5 | `MOUNT_INFO_SEND` | view a player's mount (`m5/scripts/playerinfo/PlayerInfoFrameII.as:1633`, `m5/scripts/playerinfo/view/MountInfoView.as:229`) | 0 | 0 | target user id | 0 | 4459 | [mount-core.md](mount-core.md) |
| 6 | `MOUNT_START` | refine stars (`m14/scripts/mounts/MountsPromotionView.as:297, 337, 377, 396, 439`) | template id | 0 items only, 1 buy missing with real, 2 buy missing with bound allowed | 0 single, 1 x10 | 0 | 4679 (+4426, 115, 3) | [star-promotion.md](star-promotion.md) |
| 7 | `MOUNTKING_EDIT` | king train (`m14/scripts/mounts/MountKingTrainView.as:262`) | 0 | 0 bound allowed, 1 real only | king template id | train count | 4974 (+4426, 115, 3) | [mount-king.md](mount-king.md) |
| 8 | `MOUNTSHOP_REQUEST` | shop open (`m15/scripts/view/subshop/MountShopFrame.as:83`) | 0 | 0 | 0 | 0 | 4975 | [mount-shop.md](mount-shop.md) |
| 9 | `MOUNTSHOP_BUY` | buy (`m15/scripts/view/subshop/MountShopGoodsItem.as:135`) | 0 | 0 | item template id | slot index | 4975 (+115, 4725) | [mount-shop.md](mount-shop.md) |
| 10 | `MOUNTSHOP_REFRESH` | refresh (`MountShopFrame.as:182`) | 0 | 0 | 0 | 0 | 4975 (+3) | [mount-shop.md](mount-shop.md) |
| 11 | `OP_SHOP_PREVIEW` | preview (`m15/scripts/view/subshop/MountPreviewFrame.as:61`) | 0 | 0 | 0 | 0 | 305 | [mount-shop.md](mount-shop.md) |
| 12 | `REFINING_SOULE_SEND` | refining soul (`m14/scripts/mounts/MountRefiningSoulFrame.as:208`) | 0 | 0 | item count 1..999 | 0 | 4426 (+115) | [refining-soul.md](refining-soul.md) |
| 13 | `OP_BUY_FLY` | buy flight (`MountsFrame.as:908`) | 0 | 0 | template id | 0 | 4679 (+115 or 3) | [avatars-and-wild-souls.md](avatars-and-wild-souls.md) |

Other opcodes of the feature: 8530 (0x2152) `C_MOUNT_AVATARLIST` -> 4427 (0x114b); pushes 4426 (0x114a) `U_C_MOUNT_UPDATE`, 4679 (0x1247) `U_C_MOUNT_UPGRADESTAR`, 4973 (0x136d) `U_C_MOUNT_KING_LIST`, 4974 (0x136e) `U_C_MOUNT_KING`, 4975 (0x136f) `U_C_MOUNT_SHOP`, 305 (0x0131) `U_C_MOUNT_SHOP_PREVIEW`, 4459 (0x116b) `U_C_MOUNT_INFO_SEND`, 4610 (0x1202) `U_C_VIPMOUNT_STATE`; spacetime 9653 (0x25b5) `C_TIMESPACE_INFO`, 446 (0x01be), 447 (0x01bf). Declared but unused by the client: 8567 (0x2177) `C_MOUNT_INFO_SEND` (the client uses op 5), 8466/8467/4372 refining-soul refresh/swap and `PlayerRefiningSoulMsg` (an unrelated removed system, see [refining-soul.md](refining-soul.md)), `SimpleViceMountMsg` (package `simple`, `cur_grade` #1 INT32, no reader).

## Entry points

| Entry | Where | Unlock condition | Opens |
|---|---|---|---|
| Main tool bar button `mountBtn` (tip "Montaria", hot key "Atalho P") | `core_module/scripts/ui/maintoolbar/MainToolBar.as:329, 540, 1417-1437` | lord grade >= 16 (`MainToolBar.as:1419`, `core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:32-33`; locked tip "Função habilitada no Nv. 16"); disabled in battle states (`MainToolBar.as:2390-2420`); shines after a card use (`MountsManager.as:385`) and while the free first refine is available (`MainToolBar.as:1036-1039`). Its child button opens "monster" ([../monsters/README.md](../monsters/README.md)) | controller `mounts` openType 1 -> `mounts.MountsFrame` (openType 2 when a Feras tab shines, `core_module/scripts/mvc/controler/MountsController.as:33-52`) |
| Key P | `core_module/scripts/yishi/keyboard/KeyBoardRegister.as:142-144, 776-805` | lord grade >= 40, not in battle or vehicle, no text input focused | `mounts.MountsFrame` |
| Task jumps | `core_module/scripts/yishi/SwitchPageHelp.as:338, 375, 2082, 2108` (task types 71, `GET_MOUNT`, `MOUNT_LEVEL` -> `gotoMounts`; types 74, 96, 203..205 -> `gotoMountsFrame`) | `gotoMounts` grade >= 16 ("Nível baixo, função habilitada no Nv. 16"); `gotoMountsFrame` grade >= 70 | `mounts.MountsFrame` |
| Trace tips | tip 49 "Adestrar montaria" (`core_module/scripts/yishi/manager/BaseManager.as:2885-2888`), tip 28 "Montaria Habilitada", tips 34/35 VIP mount (`BaseManager.as:1318-1343`) | grade >= 16 | MountsFrame or WildSoulFrame |
| Player info "Ver Montaria" | `m5/scripts/playerinfo/PlayerInfoFrameII.as:1617-1634, 1380-1381` | any player | `playerinfo.view.MountInfoView` |
| Bag use of a mount card (SonType 218) | `core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:456-485`, `core_module/scripts/cell/view/GoodsItemMenu.as:477-506` | card `Property3` mount grade (unused today) | activation or decomposition |
| Mount box "Caixa de Montaria" Feras button | `m11/scripts/exchangebox/ExchangeBoxFrame.as:403-407` | box unlock (grade 16, `VersionSwitch.MOUNT_BOX`) | WildSoulFrame |
| Room panel "Piso do Tempo" reward button | `m9/scripts/room/view/pve/RoomRightView.as:189-190, 499-503` | campaigns 9998/9999 (lord 50..80) | `spacetime.SpaceTimeFaultRewardFrame` |

Feature gates inside: stars and refine button need lord grade 70 (`MountsFrame.as:607`, `WildSoulItem.as:333`); king mounts are listed only at grade 70 (`core_module/scripts/mvc/module/mounts/WildSoulCollection.as:493`); refining soul needs `VersionSwitch.MOUNT_REFINING_SOUL` (true). No VIP level gate except the VIP exclusive mount (1131).

## Dependencies

| Feature | Why |
|---|---|
| [../hero/README.md](../hero/README.md) | mount attributes (with refining bonus) feed lord stats and fighting capacity; lord grade gates; transformation state (`changeShapeId`); player info frame hosts the mount viewer; `PlayerMsg` #161/#162 for spacetime |
| [../army/README.md](../army/README.md) | `ArmyMsg` 150 `mount_tempId` (#25) / `mount_grade` (#26) carry the riding state; army avatar rendering |
| [../inventory/README.md](../inventory/README.md) | item use 5006 for mount cards (SonType 218), bag pushes 115, items 208017, 208035, 208070, 208131, 2131500, unlock items 2180xxx |
| [../currency/README.md](../currency/README.md) | diamonds (`point`) and bound diamonds (`giftToken`) spending; mount coin token masterType 14 and push 4725 |
| [../vip/README.md](../vip/README.md) | VIP exclusive mount 1131 granted/removed with VIP, push 4610, VIP frame link |
| [../world-map/README.md](../world-map/README.md), [../sky-realm/README.md](../sky-realm/README.md) | riding avatar broadcast to the scene, move speed, flying mounts over obstacles (`SpaceModel.isFlying`, `canLand`) |
| [../shops/README.md](../shops/README.md) | shop controller hosts `MountShopFrame` (openType 1002) and the separate "Troca de Montaria" exchange shop (type 6) |
| [../lotteries/README.md](../lotteries/README.md), [../fashion/README.md](../fashion/README.md) | "Caixa de Montaria" / "Caixa de Moda" lottery 9613 -> 367/368/369 (client package `exchangebox`, proto `active`): not part of this feature |
| [../seasonal-events/README.md](../seasonal-events/README.md) | mount training activity (funny type 62, 8843 -> 4723 `NewMountFeedMsg`) consumes the training diamond log; discount events |
| [../rankings/README.md](../rankings/README.md) | soul score ranking (sort type 7) uses "Ponto Bestial" and `SimpleMountInfo.createFromXml` |
| [../quests/README.md](../quests/README.md) | task conditions on mount grade / getting a mount (`TaskTemplate.as:1452`), task jumps |
| [../marriage/README.md](../marriage/README.md) | 4672 (0x1240) `U_C_MARRIAGE_RIDE` (`MarriageProMsg`, `core_module/scripts/managers/MarryManager.as:104, 402-418`) is the wedding car parade, not a mount op |
| [../farm/README.md](../farm/README.md) | home display of owned mounts (`children.ShowMountMsg`: `pos` #1, `templateId` #2, `starlevel` #3, `is_valid` #4; `HomeMsg.showMount` #21) reads this feature's avatars |
| [../campaign/README.md](../campaign/README.md), [../battle/README.md](../battle/README.md), [../chat/README.md](../chat/README.md) | "Piso do Tempo" rooms, battle type 3870, share links (spacetime module) |
| [../dragon/README.md](../dragon/README.md) | "Fera de Combate" battle mounts (`DragonTalkerFightMountTemplates`, `battleMount`) are a different system |
| [../smith/README.md](../smith/README.md) | false friend: `store.mount.MountView`, `STORE_PANEL_MOUNT`, trace tip 5 `MountTipView` are gem inlay ("Inserir Gema"), not mounts |

## Current server behavior (summary)

- Login (`server/flows.json:95`, 4426 at `:411-433`): constant `MountInfoMsg` (template 1000, everything 0, `level_max` 10) and `ArmyMsg` with `mount_tempId` = `$var.mount`.
- 8529 op 3 (`server/flows.json:1150` and `:1433`): ride always sets 1003, dismount 0, reply 150.
- 8530 (`server/flows/navigation.json:1052-1100`): fixed three avatars with empty expiry dates (shown as temporary, stars hidden).
- Everything else (ops 1, 2, 4..13, 4973/4974/4975/305/4679/4459/4610, 9653) is unanswered.

## Suggested implementation order

1. Template loaders: `MountTempInfos`, `UpGradeTempInfos` Types 18, 19, 37, 109, 144, 145, 146, the mount `ConfigInfos` keys, SonType 218 cards.
2. Tables `mounts.mount_state` and `mounts.avatar`; default avatar 1000 at character creation.
3. [mount-core.md](mount-core.md): 4426 builder, login push, 8529 dispatcher, op 3 ride (replace the flows rules), op 5 viewer, op 1 training and grade unlocks.
4. [avatars-and-wild-souls.md](avatars-and-wild-souls.md): 8530/4427 with paging and date sentinel, 4679, op 2, op 4, card use hook, op 13, expiry job, VIP hook 4610.
5. Attribute aggregation (training share + avatars + stars + kings + refining) and the hero stat hook.
6. [star-promotion.md](star-promotion.md): op 6.
7. [refining-soul.md](refining-soul.md): op 12.
8. [mount-king.md](mount-king.md): 4973 at login, activation hook, op 7.
9. [mount-shop.md](mount-shop.md): pool config, ops 8..11, mount coin token.
10. [spacetime-fault.md](spacetime-fault.md): after the campaign rooms and battle type 3870 exist.
