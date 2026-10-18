# Sky realm: mounted and unmounted state

Area: sky-realm, module `mount-state`. Covers how riding a mount is shown in the hub for the own hero and for the other players, the flying mounts, the landing restriction and the hub side broadcast the mounts feature must trigger. The ride and dismount operations themselves (8529 `C_MOUNT_OP` op 3) are owned by [../mounts/mount-core.md](../mounts/mount-core.md).

Conventions: see [scene.md](scene.md).

## 1. Overview

A player rides when its army has `mountTemplateId > 0`. The own value comes from 150 `U_C_SERIAL_ARMY` (`ArmyMsg.mount_tempId`) answered by the mounts feature; the value of other players comes from `RoomPlayerMsg.mount_tempId` in the hub player records. Riding changes three things in the hub: the avatar (mount sprite, "mount" body pose), the walk speed, and, for flying mounts (`IsFly = 1` or bought flight), the pathing mode. A flying player standing over an obstacle cannot dismount.

## 2. Screens

| Class | pt-BR | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SpaceArmyView.showAvatar` (`M3/map/space/view/physics/SpaceArmyView.as:920-1070`) | none | Draws hero plus mount; uses the "map mount" equipment variants unless the mount template has `IsStand` (`useStandPose`) | Any avatar refresh | `MountTemplate.AvatarPath`, default mount avatar if empty |
| `mounts.MountsFrame` ride / dismount buttons (`decompiled/m14/scripts/mounts/MountsFrame.as:820-877`) | "Montaria" | Owned by mounts; shown here because of the hub landing check | Key P, toolbar | ride button when `army.mountTemplateId == 0`, dismount otherwise |
| `mounts.WildSoulFrame` change button (`decompiled/m14/scripts/mounts/WildSoulFrame.as:415-440`) | "Feras" | Owned by mounts; hub landing check | MountsFrame | none |

## 3. Routes (client to server)

No hub opcode. The client side hub checks wrap the mounts routes:

| # | UI control | Client sender | Hub checks | Route | Notes |
|---|---|---|---|---|---|
| MS1 | "Montar" | `MountsFrame` → `MountsManager.mountOperateSend(3, 0, 0, 1, 0)` (`CM/managers/MountsManager.as:388-398`) | 900 ms click throttle; refused while transformed (`changeShapeId > 0`, "Em transformação, não é possível montar na fera") | C>S 8529 0x2151 `C_MOUNT_OP` op 3, `param1` 1 | owned by mounts |
| MS2 | "Desmontar" | `MountsFrame.__onDismountBtnClick` (`MountsFrame.as:842-861`) → `mountOperateSend(3, 0, 0, 0, 0)` | In the hub: `SpaceModel.canLand()` must be true, else "Não é possível remover estado de montaria voadora" and nothing is sent. In a campaign on an obstacle it sends 8700 first ([movement.md](movement.md) M2) | C>S 8529 op 3, `param1` 0 | owned by mounts |
| MS3 | WildSoulFrame "Trocar" (change appearance) | `WildSoulFrame.__onChangeBtnClick` → `mountOperateSend(2, 0, 0, templateId)` | refused while transformed; in the hub `canLand(newTemplateId)` must be true | C>S 8529 op 2 | owned by mounts |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 150 0x0096 `U_C_SERIAL_ARMY` | `ArmyMsg` (army): `mount_tempId (#25, INT32)` 0 = on foot, `mount_grade (#26, INT32)` | `ArmyManager` → `SocketGameReader.readArmyInfo` (`CM/map/internals/utils/SocketGameReader.as:44-61`) → `BaseArmy.mountTemplateId` setter (`CM/mvc/module/armyII/BaseArmy.as:281-313`) | Reply to MS1/MS2/MS3 (mounts feature) | Sets `baseHero.mountAvata` and commits; the own `SpaceArmyView` hears `PLAYER_AVATA_CHANGE` and copies `army.mountTemplateId` into the hub record (`SpaceArmyView.as:1485-1510`), then redraws and recomputes speed |
| S>C 4592 0x11f0 `U_C_PLAYER_SPACE_ENTER` | `RoomEnterMsg` with the rider's `RoomPlayerMsg`: `mount_tempId (#29, INT32)`, `mount_grade (#30, INT32)` | `SpaceManager.readMember` (`CM/map/space/SpaceManager.as:272-279`) | Push to the other hub players after any ride, dismount or appearance change of a present player ([players.md](players.md)) | `SpaceArmy.mountTemplateId` setter → avatar refresh. The field is applied only when present (`hasMountTempId`): the server must send `mount_tempId = 0` explicitly on dismount, otherwise viewers keep the mount |

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| MO1 | Riding flag: `mountTemplate != null` (template found in `MountTempInfos` by `mountTemplateId`). Unknown ids render on foot. | `BaseArmy.as:315-318`, `SpaceArmyView.as:938-956` |
| MO2 | Speed: on foot 7, riding `7 × (100 + maxSpeed) / 100` with `maxSpeed` = max `Speed` among the player's owned avatars. | `CM/map/internals/utils/ArmySpeedUtils.as:14-29` |
| MO3 | Flying: `IsFly == 1` (364 of 733 templates in `MountTempInfos.xml`) or `isBuyFly` (flight bought for that avatar, `AvatarInfoMsg.isBuyFly`, `CM/managers/MountsManager.as:193-224`). Flying armies walk in straight lines over obstacles ([movement.md](movement.md) MV5). | `CM/map/space/SpaceModel.as:162-174` |
| MO4 | Landing: in the hub, dismount or change to a non-flying mount is blocked while the own cell is an obstacle with no walkable cell within 2 rings. | `SpaceModel.as:176-202, 287-311` |
| MO5 | Client bug: `isBuyFly` is written into the shared `MountTemplate`, so a viewer who bought flight for an avatar sees every player riding it as flying (cosmetic only). | `MountsManager.as:214-218` |
| MO6 | Transformation (`change_shapeId > 0`) replaces the whole avatar; the mount id is kept but only the transformed body is drawn. | `SpaceArmyView.as:959-1000` |

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/MountTempInfos.xml` | `TemplateId`, `AvatarPath`, `Speed`, `IsFly`, `IsStand` |

## 7. Persistent state

None in `sky_realm`. Riding state belongs to the mounts schema ([../mounts/mount-core.md](../mounts/mount-core.md), `is_riding`, `current_template_id`).

## 8. Backend implementation notes

- After `mounts::core::handle_mount_op` changes riding or the current appearance, call `sky_realm::players::broadcast_refresh(player_id)` when the player is present in the hub. It builds the full `RoomPlayerMsg` with `mount_tempId = is_riding ? current_template_id : 0` and `mount_grade`, and pushes 4592 to every other present player.
- Server side movement validation must read the flying flag (`IsFly` of the ridden template or the bought flight of that avatar) when deciding whether obstacle cells are allowed.
- If a dismount is accepted while the stored cell is an obstacle (for example a client that skipped MO4), snap the player with 4126 to the nearest walkable cell.

## 9. Open questions and assumptions

- Assumption: the hub refresh uses 4592 (the only message whose handler applies `mount_tempId` to other players).
- `mount_grade` is stored on the hub record but not displayed.

## 10. Implementation checklist

- [ ] Hook `broadcast_refresh` from the mount op handler (ride, dismount, change)
- [ ] Always send `mount_tempId` (0 when on foot) in `RoomPlayerMsg`
- [ ] Flying flag available to movement validation
- [ ] Snap to walkable on accepted dismount over obstacles
- [ ] Test: A rides, B sees the mount; A dismounts, B sees A on foot
- [ ] Test: flying mount over an obstacle cannot dismount (client) and server snaps if forced
