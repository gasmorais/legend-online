# Mount core: info, ride, training ("Montaria", "Adestramento")

Scope: the player's single mount record (`MountInfoMsg`): current appearance, mount grade and growth EXP, the four trainable attributes with their GP and grade cap, the training discount event, riding and dismounting on the map, and viewing another player's mount. Appearances (wild souls), stars, refining, shop and king mounts are separate modules (see [README.md](README.md)).

Path aliases (all under `decompiled/`):

| Alias | File |
|---|---|
| MM | `core_module/scripts/managers/MountsManager.as` |
| MC | `core_module/scripts/mvc/controler/MountsController.as` |
| MI | `core_module/scripts/mvc/module/mounts/MountInfo.as` |
| PI | `core_module/scripts/mvc/module/mounts/PropertyInfo.as` |
| MTD | `core_module/scripts/mvc/module/mounts/MountTrainData.as` |
| MF | `m14/scripts/mounts/MountsFrame.as` |
| PIT | `m14/scripts/mounts/PropertyItem.as` |
| PTIP | `m16/scripts/yishi/view/tips/PropertyTip.as` |
| MIV | `m5/scripts/playerinfo/view/MountInfoView.as` |
| PIF | `m5/scripts/playerinfo/PlayerInfoFrameII.as` |
| SMI | `core_module/scripts/yishi/datas/playerinfo/SimpleMountInfo.as` |
| AM | `core_module/scripts/yishi/manager/ArmyManager.as` |
| BA | `core_module/scripts/mvc/module/armyII/BaseArmy.as` |
| MTB | `core_module/scripts/ui/maintoolbar/MainToolBar.as` |

Readable TypeScript of every class is in `build/as3/gen/<package>/<Class>.ts` (for example `build/as3/gen/managers/MountsManager.ts`).

## 1. Overview

Every player has exactly one mount record. It holds:
- `mount_tempId`: the appearance currently selected (a `MountTempInfos` TemplateId, default 1000 "Cavalo Branco").
- `mount_totalGp`: growth EXP. The mount grade ("Nv. {0}") is derived from it with `UpGradeTempInfos` Types 19 (8 grades). Each grade unlocks one normal appearance (MountType 0) and raises speed.
- Four attributes: Força (`power`, Strength), Inteligência (`intellect`, Intellect), Físico (`physique`, Stamina), Proteção (`agility`, Armor). Each has a GP counter (`*_gp`) whose grade comes from `UpGradeTempInfos` Types 18, capped by `level_max`.
- Training ("Adestrar"): spend 1 "Pedra Bestial" (208017) or `Mount_Point` diamonds per train on one attribute; this raises that attribute GP and the mount growth EXP.
- Riding: a toggle that puts the selected appearance under the army on the world/space maps (`ArmyMsg.mount_tempId`), giving move speed.

Login sequence the client expects: 4426 `MountInfoMsg` push (the client never requests it) and the 8530 request for the avatar list sent by `MM.setup` (`MM:91-106`, called from `core_module/scripts/yishi/lunch/Yishi.as:374`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mounts.MountsFrame` (`MF`) | "Montaria" (`mounts.command07`, `MF:289`) | Main mount screen: train attributes, ride/dismount, links to Feras, Loja, Refino, Refinar (stars), fly purchase | Main tool bar `mountBtn` (`MTB:1417-1433`), hot key P (`core_module/scripts/yishi/keyboard/KeyBoardRegister.as:776-805`), task jumps `SwitchPageHelp.gotoMounts` / `gotoMountsFrame` (`core_module/scripts/yishi/SwitchPageHelp.as:1270-1284, 1867-1881`), trace tips 49 and 28 (`m16/scripts/tasktracetip/view/MountPropertyTipView.as:43`, `MountOpenTipView.as:25`). Controller `mounts`, openType 1 (`MC:16-31`) | Name of `mount_tempId` template, star bar of that avatar, "Nv. {0}" grade with level-up animation (`MF:504-514`), growth bar `currentGrowExp / growExpMax` (`MF:516-562`), speed "{maxSpeed}%" (`MF:515`), "Pedra Bestial atual:" count of 208017 (`MF:266, 500`), train count input 1..9999 (`MF:631-642`), discount badge when 0 < discount < 10 (`MF:567-578`), ride or dismount button by `army.mountTemplateId > 0` (`MF:864-877`), fly or not-fly button (`MF:584-592`) |
| `mounts.PropertyItem` (`PIT`) | button per attribute | One row per attribute (Strength, Intellect, Stamina, Armor; `MF:228`) | MountsFrame | "+{total}" where total = `addition` + refining bonus (`PIT:124-132`), GP bar `currentPropGp / currentPropMaxGp` (`PIT:157-158`); tooltip `PTIP` |
| `PropertyTip` (`PTIP`) | tooltip | Decomposes the attribute | hover on a PropertyItem | "{name}: {5*grade} + {addition - 5*grade} + {refining}" (`PTIP:58-86`), "Nv. {grade}", "Nível máximo atual: {level_max}" |
| `mounts.MountHelperFrame` | "Explicação" (`mounts.HelpTitle`) | Help text `mounts.helpTxt` | help button (`MF:879-884`) | static |
| `playerinfo.view.MountInfoView` (`MIV`) | "Montaria" | Read-only view of another player's mount next to "Montaria" (own, `MountInfoView.myMount`) for comparison | Player info frame mount button "Ver Montaria" (`PIF:1617-1634`) | Other: name, star bar (hidden when star = -1), 4 attributes with refining bonus, `power_gp` value in slot 06 (`MIV:238-262`). Own: 4 attributes recomputed with own refining (`MIV:192-224`) |
| `MountPropertyTipView` (trace tip type 49) | "Adestrar montaria" / "Você tem pedras bestiais para usar, favor adestrar a sua montaria para elevar o poder da sua montaria!" | Nudge to train | `BaseManager.as:2885-2888` when lord grade >= 16 and `MM.checkMountProperty()` | |
| `MountOpenTipView` (trace tip type 28) | "Montaria" / "Montaria Habilitada" | Unlock notice, cleared when the tool bar button is clicked (`MTB:1432`) | No client trigger found (server driven, assumption) | |

## 3. Routes (client to server)

All mount operations share 8529 (0x2151) `C_MOUNT_OP` with `MountEditMsg` (package `campaign`), built by `MM.mountOperateSend(op, propertyType, payType, param1, param2)` (`MM:388-398`):
`property_type` (#1, INT32), `pay_type` (#2, INT32), `param1` (#3, INT32), `param2` (#4, INT32), `op` (#5, INT32). Values of `op` are the constants of `core_module/scripts/mvc/module/mounts/MountsOpType.as:6-30`. The full op table is in [README.md](README.md#8529-op-table). This module owns ops 1, 3 and 5.

### R1. Train an attribute (op 1, `MOUNT_EDIT`)
- UI: "Adestrar" button `_trainBtn` (`MF:655-743`), count field `_trainCountText`.
- Client checks, in order:
  1. Throttle: clicks closer than 400 ms -> "Clique excessivo, tente novamente" (`MF:663-669`).
  2. No attribute row selected -> "Escolha atributo à adestrar" (`MF:671-676`).
  3. Class warning: lord Job 1 or 2 training Intellect, or Job 3 training Strength -> confirm `mounts.mountframe.trainTip01` "Quer gastar {0} diamantes em {1} atributos para treinar {2} ? (Prioridade de uso da Pedra Bestial)" (`MF:705-734`). Otherwise confirm `mounts.normaltip` "Deseja consumir {0} diamantes para adestrar {1} vez(es)?\n (Uso prioritário de pedras bestiais)" (`MF:735-741`). Both alerts are type `USEBINDPOINT_ALERT` (checkbox "use bound diamonds"). The "do not alert today" dates are read but both flags start at `true`, so the alert is always shown (`MF:677-695`).
  4. `doTrain` (`MF:771-822`): selected attribute `isLimit` (grade == level_max) -> "Adestramento máximo"; affordability: at least one 208017 in the bag, or `point` (or `point + giftToken` when the bound checkbox is on) >= cost; else recharge alert.
  - Cost shown = `count * Mount_Point`; with 0 < `discount` < 10, `ceil(cost * discount / 10)` (`MF:697-704, 794-798`).
- Request: `op` = 1; `property_type` = attribute id from `PI.getPropertyValue` (`PI:42-57`): 0 Strength (Força), 1 Armor (Proteção), 2 Intellect (Inteligência), 5 Stamina (Físico) (labels `mounts.command02` "Força,Proteção,Inteligência,,,Físico" are indexed by this id); `pay_type` = 0 when bound diamonds may be used, 1 when only real diamonds (`MF:805-816`); `param1` = number of trains (1..9999); `param2` = 0.
- Response: 4426 `MountInfoMsg` with new `*_gp`, attribute totals, `mount_totalGp` and `addPointCount`. Side pushes: 115 `U_C_BAG_MOVE_UPDATE` when Pedra Bestial is consumed, 3 `U_C_PLAYER_INFO` when diamonds change (see [../inventory/README.md](../inventory/README.md), [../currency/README.md](../currency/README.md)). No error opcode exists; on failure send nothing (assumption) or a generic tip.

### R2. Ride (op 3, `ARMYMOUNT_AVATARCHANGE`, param1 = 1)
- UI: `mount.mountBtn` "Montar" (`MF:824-840`), visible when `army.mountTemplateId <= 0` (`MF:864-877`).
- Client checks: 900 ms throttle; lord transformed (`thane.changeShapeId > 0`) -> "Em transformação, não é possível montar na fera".
- Request: `op` = 3, `property_type` 0, `pay_type` 0, `param1` = 1, `param2` 0.
- Response: 150 (0x0096) `U_C_SERIAL_ARMY` `ArmyMsg` with `mount_tempId` (#25) = current `mount_tempId` and `mount_grade` (#26) = mount grade. `AM.__getArmyListHandler` -> `SocketGameReader.readArmyInfo` sets `army.mountTemplateId` (`core_module/scripts/map/internals/utils/SocketGameReader.as:44-61`), `BA.mountTemplateId` swaps the hero avatar (`BA:281-313`), `army.commit()` dispatches `ARMY_PAWN_CHANGE` (`BA:198-213`) and MountsFrame toggles the buttons. Other players in the same scene must receive the army update through the map broadcast of their feature ([../world-map/README.md](../world-map/README.md), [../sky-realm/README.md](../sky-realm/README.md)).

### R3. Dismount (op 3, param1 = 0)
- UI: `mount.dismountBtn` "Descansar" (`MF:842-862`).
- Client checks: 900 ms throttle; in the space map, flying over an obstacle -> "Não é possível remover estado de montaria voadora" (`SpaceModel.canLand`, `core_module/scripts/map/space/SpaceModel.as:176-196`); in a campaign standing on an obstacle the client first calls `SpaceSocketOutManager.resetSpacePosition()` (`MF:856-859`).
- Request: `op` = 3, `param1` = 0 (proto2 default, so the field may be absent on the wire).
- Response: 150 `ArmyMsg` with `mount_tempId` = 0.

### R4. View another player's mount (op 5, `MOUNT_INFO_SEND`)
- UI: player info frame, mount item ("Ver Montaria", `PlayerInfoFrameII.mountBtnTip`) -> `PIF.sendRequestMountInfo` (`PIF:1617-1634`). For ranking rows (`SortData`) and Perkin snapshots the client uses data it already has and sends nothing.
- Request 1: `op` = 5, `param1` = target `userId`. The frame registers a one-shot listener on 4459 (`PIF:1632`).
- On the first 4459 `PIF.__showMountInfoFrame` builds `SMI.createFromMountInfoMsg` and opens `MountInfoView` (`PIF:1232-1246`); star is forced to -1 when the target has no job change (`vocationGrades <= 0`).
- Request 2 (automatic): the `MountInfoView` constructor sends `op` = 5, `param1` = own `userId` (`MIV:100-104, 226-230`) and listens to the next 4459 to fill the own column (`MIV:183, 192-224`).
- Response: 4459 (0x116b) `U_C_MOUNT_INFO_SEND` `MountInfoMsg` of the requested player, once per request, in request order.

### R5. Unused opcode 8567 (0x2177) `C_MOUNT_INFO_SEND`
Declared in `core_module/scripts/yishi/datas/consant/ProtocolType.as:576` ("查看玩家坐骑信息") but never sent by the client: the view uses op 5 of 8529. The server may map 8567 to the same handler for safety.

### R6. Mount training activity (cross feature)
When the mount grade changes after a 4426, the client sends 8843 (0x228b) `C_NEW_MOUNT_ACTIVE` with no body (`MM:140-147`, `core_module/scripts/managers/MountActSocketOutManager.as:15-19`); the reply 4723 (0x1273) `U_C_NEW_MOUNT_ACTIVE` `NewMountFeedMsg` feeds the "funny" activity type 62 (`core_module/scripts/managers/FunnyManager.as:156, 365-407`). Both opcodes are missing from `protocol/opcodes.csv` (constants typed `int` in `ProtocolType.as:900` and `AcceptProtocolType.as:1106`). Owned by [../seasonal-events/README.md](../seasonal-events/README.md); `NewMountFeedMsg` fields: `begin_tm` (#1, STRING), `end_tm` (#2, STRING), `mount_level` (#3, INT32), `rebate` (#4, INT32, percent, "Feedback {0}%"), `toal_cost` (#5, INT32, diamonds spent on training during the event), `rebate_point` (#6, INT32), `complete` (#7, BOOL). The mount module must expose "diamonds spent on training per event" for it.

## 4. Server messages (server to client)

### S1. 4426 (0x114a) `U_C_MOUNT_UPDATE`, `MountInfoMsg` (package `campaign`)
Receiver `MM.__onMountInfoUpdate` (`MM:108-155`). Push at login and after every change of the record (train, appearance change, avatar activation or expiry that changes totals, star change, refining).

| Field | Tag, type | Meaning | Client use |
|---|---|---|---|
| `mount_tempId` | #1, INT32 | selected appearance | `MI.templateId` (`MM:120`) |
| `power` | #2, INT32 | Strength total (training + avatars, see 5) | `getProperty("Strength").addition` |
| `intellect` | #3, INT32 | Intellect total | `Intellect.addition` |
| `physique` | #4, INT32 | Stamina total | `Stamina.addition` |
| `agility` | #5, INT32 | Armor total | `Armor.addition` |
| `speed` | #6, INT32 | move speed bonus | not read by `MM`; send the max `Speed` of owned avatars (assumption) |
| `power_gp` | #7, INT32 | Strength GP | `propGp` -> grade via Types 18 (`PI:84-121`) |
| `intellect_gp` | #8, INT32 | Intellect GP | |
| `physique_gp` | #9, INT32 | Stamina GP | |
| `agility_gp` | #10, INT32 | Armor GP | |
| `mount_totalGp` | #11, INT32 | growth EXP | `MI.growExp` -> grade via Types 19 (`MI:74-112`) |
| `level_max` | #12, INT32 | attribute grade cap | `MI.propertyGradeMax`; grade shown = min(grade, cap) (`PI:133-147`) |
| `discount` | #13, INT32 | training discount in tenths (1..9 active, 0 or 10 none) | badge and cost (`MF:567-578`) |
| `mount_starLv` | #14, INT32 | star of the selected avatar | only read by `SMI` (viewer) |
| `addPointCount` | #15, INT32 | trains paid with real diamonds during the discount event | tip `mounts.tips06` (`MF:571`); read only when present (`MM:124-127`) |
| `refining_soul_power_grade` .. `refining_soul_agility_grade` | #16..#19, INT32 | refining grades | see [refining-soul.md](refining-soul.md) |
| `refining_soul_exp` | #20, INT32 | refining EXP | see [refining-soul.md](refining-soul.md) |

Client reactions: `MI.dispatchChangeEvent` refreshes MountsFrame (`MF:465-469`); a GP increase on an attribute plays the attribute level-up effect (`PI:88-91`); a grade increase dispatches `mountLevelup` (`MI:87-90`), MountsFrame plays the effect and re-requests 8530 so the newly unlocked normal appearance appears (`MF:912-921`); a grade change sends 8843 (R6).

### S2. 4459 (0x116b) `U_C_MOUNT_INFO_SEND`, `MountInfoMsg`
Receivers `PIF.__showMountInfoFrame` (`PIF:1232-1246`) and `MIV.__updateSelfMountInfoHandler` (`MIV:192-224`). Response to op 5. Same fields as S1, for the requested player. Used: `mount_tempId`, `power`, `intellect`, `physique`, `agility`, `power_gp` (displayed in slot 06; `SMI.createFromXml` fills the same slot with `SoulScore`, so the server should put the soul score there, assumption), `mount_starLv`, refining grades (`SMI:30-61`). Unknown target: send nothing (assumption; the client keeps waiting silently).

### S3. 150 (0x0096) `U_C_SERIAL_ARMY`, `ArmyMsg` (package `army`) mount fields
Owned by [../army/README.md](../army/README.md). Mount fields: `mount_tempId` (#25, INT32, 0 = not riding), `mount_grade` (#26, INT32). Read only when present (`SocketGameReader.as:54-61`). Also carried by `ArmyPlayerInfoMsg` #10/#11, `PlayerInfoNoticeMsg` #8/#9, `RoomPlayerMsg` #29/#30, `TeamPlayerInfoMsg` #29/#30, `GameTeamPlayerAvataMsg` #13 for other contexts (battle, rooms, teams); those features must read the riding state from this module.

### Current server behavior (`server/flows.json`)
- Login rule `on 8224` with `castle: true` (`server/flows.json:95`) pushes 4426 with constants (`server/flows.json:411-433`): `mount_tempId` 1000, all attributes and GP 0, `speed` 30, `level_max` 10, `discount` 0, `addPointCount` 1, refining 0. It also pushes 150 with `mount_tempId` = `$var.mount`.
- 8529 with `op` 3 and `param1` 1 (`server/flows.json:1150-1160`) sets `$var.mount = 1003` and replies 150 `ArmyMsg` with `mount_tempId` 1003, regardless of the selected appearance.
- 8529 with `op` 3 and `param1` null (`server/flows.json:1433-1443`) sets `$var.mount = 0` and replies 150.
- Every other op of 8529 is unanswered.

The real implementation must: persist the record; build 4426 from it; ride with the selected `mount_tempId` (not 1003) and `mount_grade` = real grade; keep 4426 and 150 consistent (today 4426 says 1000 while riding shows 1003); implement ops 1 and 5; treat absent `param1` as 0.

## 5. Rules and formulas

Unlock:
- Tool bar button opens only at lord grade >= 16 (`MTB:1419-1422`; tip "Função habilitada no Nv. 16", `core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:32-33, 151-152`). Hot key P additionally needs grade >= 40 (`KeyBoardRegister.as:798-801`). `gotoMounts` needs 16, `gotoMountsFrame` needs 70 (`SwitchPageHelp.as:1270-1284, 1867-1881`).
- Server rule: reject every 8529 op from players below grade 16 (assumption, the client never sends it).

Mount grade (`raw/xml/tempinfos/UpGradeTempInfos.xml` Types 19, sorted by `Data`, `MI:74-112`): grade = highest row with `mount_totalGp >= Data`. `ActiveObject` is the normal appearance unlocked at that grade, matching `MountTempInfos` MountType 0 rows whose `Property2` is the grade:

| Grade | Total EXP (`Data`) | Unlocks (TemplateId, name, Speed) |
|---|---|---|
| 1 | 0 | 1000 Cavalo Branco, 30 |
| 2 | 13000 | 1006 Cavalo Imperial, 35 |
| 3 | 64000 | 2001 Cavalo Infernal, 40 |
| 4 | 165000 | 3001 Pegasus Sagrado, 45 |
| 5 | 290000 | 4001 Leopardo Trovão, 50 |
| 6 | 415000 | 5001 Tiamat Fantasma, 60 |
| 7 | 565000 | 6001 Leão Infernal, 70 |
| 8 (max) | 740000 | 7001 Dragão do Céu, 80, `IsFly` 1 |

At max grade the bar is shown full (`MI:97-102`). When the grade rises the server must insert the unlocked normal avatar (see [avatars-and-wild-souls.md](avatars-and-wild-souls.md)).

Attribute grade (`UpGradeTempInfos` Types 18, 2500 rows, `PI:84-121`): grade = highest row with `gp >= Data`. GP needed from grade g to g+1: `25 * g` for g = 1..20, `500 + 50 * (g - 20)` for g = 21..60, then 2500 flat up to grade 2500 (total 6163750). Displayed grade = `min(grade, level_max)`; training is blocked client side when grade == `level_max` (`MF:782-786`). Server: reject op 1 when the selected attribute grade >= `level_max`; clamp GP so the grade never exceeds the cap (assumption, the client also clamps the bar at the cap).

Attribute total (`addition`): the tooltip splits it into `5 * grade` (training share) and `addition - 5 * grade` (other sources) (`PTIP:65-86`). Server formula (assumption derived from that split and from `mounts.WildsoulItem.tips01`, `raw/xml/tempinfos/MountTempInfos.xml`): `total = 5 * grade(attr) + sum over active owned avatars of (template base attr + starAddList[star-1]) + king mount bonus`, where base attr is `Power` for Strength, `Intellect`, `Physique` for Stamina, `Agility` for Armor. The final value shown to the player adds the refining bonus computed client side ([refining-soul.md](refining-soul.md)). These totals are added to the lord stats and fighting capacity by the hero attribute calculator ([../hero/README.md](../hero/README.md)).

`level_max`: help text "A montaria ao elevar de nível irá elevar o limite do nível de atributos" and tip `mounts.PropertyItem.tips05` "Ativar feras especiais podem elevar nível máximo"; each template has `ExpandLevel` ("Nível máximo de atributos +{0}"). Formula (assumption): `level_max = base(grade) + sum ExpandLevel of active owned avatars`; `base(grade)` is not in any template (current server uses 10).

Training cost and effect:
- Cost per train: 1 "Pedra Bestial" (208017) if present (priority), else `Mount_Point` diamonds (`ConfigInfos` `Mount_Point` = 5, `MTD:22-25`). Strings `mounts.tips02` "Adestramento consome {0} diamantes ou 1 Pedra Bestial ... Probabilidade de receber benção do Deus das Feras (Exp adquirida x5)".
- Mixed payment for a batch: stones first, remaining trains in diamonds (assumption; matches "Prioridade uso de Pedra Bestial"). `pay_type` 0 allows bound diamonds (`giftToken`) first then real `point`, `pay_type` 1 real `point` only (assumption on order, `PlayerInfo.allPoint = point + giftToken`, `core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as:608-611`).
- Discount event: when 0 < `discount` < 10 the diamond cost is `ceil(count * Mount_Point * discount / 10)` (`MF:794-798`) and `addPointCount` counts trains paid with real diamonds during the event (`mounts.tips06`). Stones are not discounted (assumption).
- EXP per train: unknown. The unused string `mounts.command05` mentions "obtendo {0} experiência". Each train adds X GP to the selected attribute and X to `mount_totalGp`, with a "benção do Deus das Feras" chance of x5 (assumption: X and the chance are server config; propose `train_gp = 10`, `crit_chance = 5%`, `crit_multiplier = 5`).
- Client caps: count 1..9999 (`MF:631-642`); server must enforce the same and stop the batch when the attribute reaches the cap (refund the rest, assumption).

Riding:
- Ride uses the current `mount_tempId`. Riding shows the avatar on the maps; move speed with a mount = `7 * (100 + maxSpeed) / 100` where `maxSpeed` is the max `Speed` over all owned avatars, not the ridden one (`core_module/scripts/map/internals/utils/ArmySpeedUtils.as:14-29`, `WildSoulCollection.getSpeedMaxMount`). The MountsFrame speed label shows the same `maxSpeed` (`MF:515`, tip `mountsFrmae.speedStrip.tipData`).
- Transformed lords cannot ride (`MF:833-837`). Flying mounts cannot dismount over obstacles in space (`MF:851-855`).
- Riding state is persistent across logins (assumption, the login 150 carries it).

Other client rules:
- `MM.checkMountProperty` (`MM:426-458`): tip 49 shows when fewer than 2 "points" of attributes at grade >= 2 (grade 2 = 1 point, grade >= 3 = 2 points) and the bag has >= 5 Pedra Bestial.
- The mount screen records fighting capacity before/after (`MF:186, 997-998`).

## 6. Templates

| File | Records and fields used |
|---|---|
| `raw/xml/tempinfos/MountTempInfos.xml` (733 `MountTempInfo`) | `TemplateId`, `TemplateName`, `MountType` (0 normal, 1 special, 2 hidden, 3 VIP, 4 king, 5 card only), `Power`, `Intellect`, `Physique`, `Agility`, `ExpandLevel`, `Speed`, `AvatarPath` (`path|wing`), `NeedItemId`, `Property1` (diamond unlock price), `Property2` (unlock grade for MountType 0), `NeedMountGrade`, `SoulScore`, `StarAddition`, `GradeType`, `Area`, `IsFly`, `IsStand`. Parsed by `core_module/scripts/yishi/datas/templates/MountTemplate.as` |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 19 | mount grade: `Grades`, `Data` (cumulative EXP), `ActiveObject` (unlocked TemplateId) |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 18 | attribute grade: `Grades`, `Data` (cumulative GP) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Mount_Point` = 5 ("【坐骑】培养1次消耗钻石") |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208017 "Pedra Bestial" (SonType 290, MaxCount 9999) |

## 7. Persistent state

Schema `mounts`.

```sql
CREATE SCHEMA IF NOT EXISTS mounts;

CREATE TABLE mounts.mount_state (
  player_id            BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  current_template_id  INTEGER     NOT NULL DEFAULT 1000,
  is_riding            BOOLEAN     NOT NULL DEFAULT false,
  total_gp             BIGINT      NOT NULL DEFAULT 0 CHECK (total_gp >= 0),
  strength_gp          BIGINT      NOT NULL DEFAULT 0 CHECK (strength_gp >= 0),
  intellect_gp         BIGINT      NOT NULL DEFAULT 0 CHECK (intellect_gp >= 0),
  stamina_gp           BIGINT      NOT NULL DEFAULT 0 CHECK (stamina_gp >= 0),
  armor_gp             BIGINT      NOT NULL DEFAULT 0 CHECK (armor_gp >= 0),
  discount_event_id    INTEGER,
  event_paid_trains    INTEGER     NOT NULL DEFAULT 0,
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE mounts.train_discount_event (
  event_id   SERIAL      PRIMARY KEY,
  starts_at  TIMESTAMPTZ NOT NULL,
  ends_at    TIMESTAMPTZ NOT NULL,
  discount   SMALLINT    NOT NULL CHECK (discount BETWEEN 1 AND 9),
  CHECK (ends_at > starts_at)
);
CREATE INDEX train_discount_event_window ON mounts.train_discount_event (starts_at, ends_at);

CREATE TABLE mounts.train_log (
  log_id            BIGSERIAL   PRIMARY KEY,
  player_id         BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  property_type     SMALLINT    NOT NULL CHECK (property_type IN (0, 1, 2, 5)),
  train_count       INTEGER     NOT NULL CHECK (train_count BETWEEN 1 AND 9999),
  stones_used       INTEGER     NOT NULL DEFAULT 0,
  point_spent       INTEGER     NOT NULL DEFAULT 0,
  gift_token_spent  INTEGER     NOT NULL DEFAULT 0,
  gp_gained         BIGINT      NOT NULL DEFAULT 0,
  crit_count        INTEGER     NOT NULL DEFAULT 0,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX train_log_player_time ON mounts.train_log (player_id, created_at);
```

Derived, not stored: mount grade (from `total_gp`), attribute grades (from `*_gp`), `level_max`, attribute totals, speed. `train_log.point_spent` feeds the mount training activity (`toal_cost`) of [../seasonal-events/README.md](../seasonal-events/README.md). The row is created at character creation or on first access (with avatar 1000, see the avatars module).

## 8. Backend implementation notes

Handlers:
- `mounts::core::handle_mount_op` (8529): decode `MountEditMsg`, check lord grade >= 16, dispatch by `op` to the module handlers listed in [README.md](README.md#8529-op-table); unknown op -> ignore and log.
- `mounts::core::handle_train` (op 1).
- `mounts::core::handle_ride` (op 3).
- `mounts::core::handle_view_mount_info` (op 5; also bound to 8567).
- `mounts::core::push_mount_info` (builder for 4426, also used for 4459 with another player's id).
- `mounts::core::on_login` (push 4426; the avatars module answers 8530; the king module pushes 4973).

Validation order for op 1: grade >= 16 -> `property_type` in {0,1,2,5} -> `1 <= param1 <= 9999` -> `pay_type` in {0,1} -> attribute grade < `level_max` -> resources (stones, then diamonds by `pay_type`, discounted) cover at least one train. Transaction: lock `mount_state`, consume stones (inventory service), debit diamonds (currency service), loop trains (stop at cap, refund unused), update GP, insert `train_log`, update `event_paid_trains` when an event is active, commit. Pushes after commit: 115, 3, 4426. If the mount grade increased: insert the unlocked MountType 0 avatar (avatars module), recompute `level_max`; the client re-requests 8530 by itself. Recompute fighting capacity (hero module).

op 3: `param1` absent or 0 -> dismount, 1 -> ride; reject ride when the player is transformed (hero state) or the selected avatar is not active (expired); reject dismount in space over an obstacle when the mount flies (map service). Update `is_riding`, push 150 to the player and the army update to the scene (map broadcast).

op 5: `param1` = target id; load (or default) the target's record; push 4459 to the requester only. No privacy rule exists in the client.

Login: build 4426 from `mount_state`, the active avatar set and refining state; build 150 with `mount_tempId = is_riding ? current_template_id : 0`.

Schedules: discount events are configured rows (`train_discount_event`); a job at `starts_at`/`ends_at` pushes 4426 with the new `discount` to online players and resets `event_paid_trains` per event (assumption).

No battle is started by this module.

## 9. Open questions and assumptions

- GP per train, the "x5" chance and whether stones and diamonds give the same GP (assumption: same).
- `level_max` base per mount grade (assumption: config table; current server sends 10).
- Whether training also raises `mount_totalGp` 1:1 (assumption: yes, the help says training raises "os pontos do crescimento da montaria").
- Exact composition of `power`..`agility` (assumption above from the tooltip split).
- Whether riding persists across logins and across scenes (assumption: yes).
- `speed` (#6) of 4426 is unused by the client; value assumed = max owned `Speed`.
- Who triggers trace tip 28 "Montaria Habilitada" (no client caller; assumption: server sends a tip push when the lord reaches grade 16).
- 4459 slot 06 shows `power_gp`; it is probably meant to carry the soul score (assumption).
- 8843/4723 are absent from `protocol/opcodes.csv`; add them when the activity is implemented.

## 10. Implementation checklist

- [ ] Screen `mounts.MountsFrame` renders from 4426 (name, grade, growth bar, speed, discount, ride buttons)
- [ ] Screen `mounts.PropertyItem` and `PropertyTip` show totals, grade and cap
- [ ] Screen `playerinfo.view.MountInfoView` comparison (two 4459 in order)
- [ ] Route 8529 dispatcher `mounts::core::handle_mount_op`
- [ ] Route op 1 train (cost, stones first, discount, cap, batch)
- [ ] Route op 3 ride and dismount (absent `param1` = 0)
- [ ] Route op 5 view other player's mount; 8567 alias
- [ ] Server message 4426 builder (all 20 fields)
- [ ] Server message 4459
- [ ] Server message 150 `mount_tempId` / `mount_grade` from real state
- [ ] Login push 4426 and riding state in 150
- [ ] Table `mounts.mount_state`
- [ ] Table `mounts.train_discount_event`
- [ ] Table `mounts.train_log`
- [ ] Rule: mount grade from Types 19 and normal avatar unlock on level up
- [ ] Rule: attribute grade from Types 18, cap `level_max`
- [ ] Rule: attribute totals (training share `5 * grade` + avatars + king)
- [ ] Rule: grade >= 16 gate
- [ ] Hook: fighting capacity recompute after every change
- [ ] Replace the `server/flows.json` rules for 8529 op 3 and the login 4426 constants
- [ ] Test: train 1 with stones, with diamonds, with discount 8 (cost `ceil(5*n*0.8)`), at cap (rejected)
- [ ] Test: ride shows selected template in 150; dismount with absent `param1`
- [ ] Test: view other player's mount then own (two 4459 in order)
