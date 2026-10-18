# Artillery ("Artilharia TM")

Client packages `vehicle` (`decompiled/m9/scripts/vehicle/**`), `com.map.vehicle` (`decompiled/m17/scripts/com/map/vehicle/**`, the `VEHICLE` scene), `mvc.module.vehicle` (`decompiled/core_module/scripts/mvc/module/vehicle/**`) and the "active vehicle" code of the campaign map (`decompiled/m3/scripts/map/campaign/**`). Protobuf package `com.road.yishi.proto.vehicle` plus `room.VehicleBuffListMsg`, `room.VehicleSkillListMsg`, `room.MatchStateMsg`, `room.RoomCreatedMsg`.

The player owns tank-like vehicles ("Artilharias"), levels a "Controle" (control) EXP bar by playing, and uses the vehicles in a real-time team PvP map, "Julgamento TM" (campaign 3001, map "Ruínas Arcaicas"): two teams of up to 4 move on a tile grid, shoot skills, collect props, kill a boss and score points. A second mode reuses the same protocol inside the campaign map: the 7th anniversary "Batalha da Neve" (snowball fight, campaign 3002).

All traffic is socket based; no HTTP routes. PostgreSQL schema: `artillery`. Rust handlers: `artillery::<module>::handle_<action>`.

Citation prefixes used in the module files: `CM/` = `decompiled/core_module/scripts/`, `M9/` = `decompiled/m9/scripts/`, `M17/` = `decompiled/m17/scripts/`, `M3/` = `decompiled/m3/scripts/`, `M11/` = `decompiled/m11/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Castle building 1505 "Artilharia TM" | hero level >= 35, else "Artilharia TM não aberta!" (`M4` = `decompiled/m4/scripts/castle/view/CastleBuildingView.as:335-342`) | Garage `vehicle.DaimonFrame` ([garage.md](garage.md)) |
| Return from a vehicle match to castle | `_preSceneData.isOpenVehicle` (`decompiled/m4/scripts/castle/CastleSceneView.as:127-129`, `M3/map/space/SpaceSceneController.as:252-254`) | Garage |
| Top toolbar timed button key `vehicel` | level >= `TopBtnType.TIME_ACTIVE_GRADES[3]` = 35 (`CM/ui/toptoolbar/TopBtnType.as:214`), window open (`CM/ui/toptoolbar/TopToolsBar.as:1376-1385,1581-1601`); visible while `playerInfo.isVehicleStart` (`CM/yishi/datas/templates/TopToolBtnTempInfo.as:103-106`). The BR `TopToolBtnInfos.xml` has no `vehicel` row, so the button is not shown in this build | Trial lobby `vehicle.DaimonTrialFrame` ([trial-lobby.md](trial-lobby.md)) |
| Daily guide item 3 (`M11/dayguide/DailyItem.as:154-158`), world army helper (`M3/map/space/helper/hero/SpaceArmyViewHelper.as:196`) | `SwitchPageHelp.checkScene()` | Trial lobby |
| Space NPC dialog option 106 | New Year module dates (`M3/map/space/view/frame/DialogOptionItem.as:698-708`); the 7th anniversary snow card `SevenYearSnowView` exists but is never instantiated | Snow battle ([snow-battle.md](snow-battle.md)) |

UI module keys: `vehicledaimon` (garage, `CM/yishi/datas/UIModuleTypes.as:228`), `vehicleroomlist` (trial lobby openType 0, team room openType 2, `CM/yishi/datas/UIModuleTypes.as:226`, `CM/mvc/controler/VehicleDaimonTrialController.as:115-122`).

## Modules

| Module | Content |
|---|---|
| [garage.md](garage.md) | Owned vehicles, control EXP and level, tech level, early activation with diamonds, default vehicle selection (8611, 8619; 4501, 4515, 4516) |
| [trial-lobby.md](trial-lobby.md) | "Julgamento TM" window state (4512), quick match (8608/8609, 4525), team rooms of roomType 2 (generic room protocol), start (5039 -> 125) |
| [battle-scene.md](battle-scene.md) | `VEHICLE` scene (campaign 3001): roster, movement, skills, buffs, props, traps, boss, scores, revive, exit and result (8610, 8615-8617; 4474, 4513-4524) |
| [snow-battle.md](snow-battle.md) | 7th anniversary "Batalha da Neve" (campaign 3002): matchmaking (9587, 200), cross-server moves/attacks/picks (25216-25218), HP list (183), end report (201) |

## Dependencies

- [castle](../castle/README.md): building 1505 opens the garage.
- [currency](../currency/README.md): diamonds (bound or unbound) for early activation.
- [hero](../hero/README.md): hero level gates (35), titles (`appellId`), VIP flags shown on tanks.
- [chat](../chat/README.md): scene chat bubbles on channels 6 and 8 (`M17/com/map/vehicle/net/VehicleSocketManager.as:752-772`).
- [inventory](../inventory/README.md): end rewards (rune stones, rune boxes, "Pontos de Guerreiro" item -15000).
- [hermitage-war](../hermitage-war/README.md): the 7th anniversary hub (`sevenyear`) that hosts the snow battle entry and the "Pontos de Guerreiro" daily cap.
- [auto-chess](../auto-chess/README.md): shares the "Pontos de Guerreiro" counter (`snow_vehicle_daily_reward_max`).
- Generic room protocol (opcodes 12, 15, 17, 24, 25, 32, 120, 121, 5023-5039, 8344, 8465, 4370) is shared with PvE rooms; this feature only documents its use with `roomType = 2`.
- Not in scope: `U_C_STEEL_VEHICLE_DETAILE` 4771 (steel arena, `CM/mvc/controler/SteelController.as:102`), `U_C_VEHICLE_UNREAL_SYNC_SKILL` 4833 and campaign 5703 ("Caça Fantástica"), `C_EXIT_VEHICLE_NODE` 25111 (war field, `M3/map/net/MapSocketOuterManager.as:190-197`). They reuse `vehicle` messages but belong to other campaign features.

## Suggested implementation order

1. Templates loader (`VehicleObjectTempInfos`, `VehicleSkillTempInfos`, `VehicleBuffTempInfos`, `UpGradeTempInfos` Types=24) and the `artillery` tables.
2. [garage.md](garage.md): login pushes 4516/4515/4501, choose vehicle 8611, activate 8619.
3. [trial-lobby.md](trial-lobby.md): event scheduler (4512), quick match queue, room type 2 on top of the generic room service.
4. [battle-scene.md](battle-scene.md): real-time map server (tick loop, path validation, skill resolution, buffs, props, boss, revive, scoring, end).
5. [snow-battle.md](snow-battle.md): only if the 7th anniversary event is enabled.
