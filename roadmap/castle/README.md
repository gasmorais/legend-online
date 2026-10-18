# Castle ("Castelo e prédios")

The castle is the home scene of every player (scene `CASTLE_SCENE`, class `castle.CastleSceneView`, module m4). It shows the player buildings on a draggable map, one walking NPC, operation bubbles, and the full HUD. Buildings are leveled with gold ("Ouro") and light crystals ("Cristal de Luz"). The castle produces gold every hour, lets the player collect taxes ("Impostos") in the town hall ("Prefeitura"), research technologies ("Tecnologia") in the sanctuary ("Santuário", code name seminary) and charge the transmitter ("Transmissor") used to relocate the castle on the world map.

Client packages: `castle` (m4), `buildings` (m4), `hook` (m9), plus the shared managers `BuildingManager`, `BuildingModel`, `ResourceManager`, `QueueBarManager`. Protobuf packages: `castle` (`CastleYieldMsg`, `WildYieldMsg`, `CastleReqMsg`), `building` (all `Building*`, `Order*`, `ActiveQueue*`, `TransInfoMsg`, `GiveupWildLandMsg`). All traffic is socket based; there are no HTTP or AMF routes. PostgreSQL schema: `castle`. Rust handlers: `castle::<module>::handle_<action>`.

Path aliases used in every module of this folder:

| Alias | File |
|---|---|
| BM | `decompiled/core_module/scripts/yishi/manager/BuildingManager.as` |
| BMOD | `decompiled/core_module/scripts/mvc/module/buildings/BuildingModel.as` |
| BSOM | `decompiled/core_module/scripts/managers/BuildingSocketOutManager.as` |
| LIDA | `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as` |
| RM | `decompiled/core_module/scripts/yishi/manager/ResourceManager.as` |
| QBM | `decompiled/core_module/scripts/yishi/manager/QueueBarManager.as` |
| QB | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as` |
| CBV | `decompiled/m4/scripts/castle/view/CastleBuildingView.as` |
| CWL | `decompiled/m4/scripts/castle/view/layer/CastleWalkLayer.as` |
| BBF | `decompiled/m4/scripts/buildings/BaseBuildFrame.as` |

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Login | always | Login sequence ends in the castle when the novice process allows it ([../tutorial/README.md](../tutorial/README.md)); 4153 and 4154 are part of the login load ([../account/README.md](../account/README.md)) |
| HUD `MainToolBar._castleBtn` "Cidade / Atalho Q" | none | `SceneManager.setScene("CASTLE_SCENE")`, sends 8747 ([scene.md](scene.md)) |
| HUD `SmallMapBar._castleBtn` "Ir ao Castelo" | Leader level >= 11 | same |
| HUD `MainToolBar._returnBtn` "Voltar" | inside another scene | leaves the scene, back to the castle |
| Castle map click on a building | per building, see [scene.md](scene.md) | Prefeitura, Quartel, Santuário, Transmissor frames, or portals to other features |
| Leader level 18 | server side | the Santuário appears (`UpGradeTempInfos` Types 3, Grades 18, `ActiveObject` 50101) |
| Leader level 14 | client gate | tax collection enabled ([levy.md](levy.md)) |
| Leader level 15 | client gate | Transmissor clickable ([transmitter.md](transmitter.md)) |

## Modules

| Module | Content |
|---|---|
| [scene.md](scene.md) | Castle scene, map layers, building placement (server and client pseudo buildings), click dispatch of every building, NPC dialogs, operation bubbles, post battle reopen table, 8747 |
| [buildings.md](buildings.md) | Building model, login load 4154, tutorial init 8281, create 8202, upgrade 8203, push 4130, Prefeitura / Quartel / Santuário level tables, `BaseBuildFrame`, `CasernFrame` shell, legacy frames |
| [technologies.md](technologies.md) | Santuário technologies (MasterType 13 and 14), unlock order, crystal costs, effects, "Roleta da Benção" (8489 / 4391, unreachable in this build) |
| [resources.md](resources.md) | Gold, light crystals and population: 30 s sync 5015 / 109, `CastleYieldMsg`, hourly production formula, gold cap, wild land yields 152, shared spend / add API for other features |
| [levy.md](levy.md) | "Impostos" in the Prefeitura: 8327 / 4242, daily counter, formula, secretary bulk collect |
| [transmitter.md](transmitter.md) | Transmissor pseudo building, energy, recharge 5174 / 103, castle relocation 5176 / 105, 4159, daily energy reset, planes list shell |
| [activity-queue.md](activity-queue.md) | QueueBar daily counters (`ActiveQueueListMsg`, 366): 16 activity order ids, owners, push rules |
| [build-queue.md](build-queue.md) | Legacy construction queue (8279, 4155, 4187, 5172 / 102, 5175 / 104, 151): unreachable in this build, minimal implementation |
| [hook.md](hook.md) | Legacy Santuário hang up rooms ("Prática", 8295 / 4204, 8258, 4200, 4235, 8292, 8293): unreachable in this build |
| [hud.md](hud.md) | Every HUD button, activity icon, queue item and castle building entry, with the feature folder that owns it |

## Dependencies

- [../account/README.md](../account/README.md): login load (8224 with `castle` and `build` flags) carries 4153 and 4154.
- [../tutorial/README.md](../tutorial/README.md): tutorial node 170 sends 8281; `newbieProcess >= 21000` enables the new building camera animation; novice process decides when the castle opens.
- [../hero/README.md](../hero/README.md): Leader level (`thane.grades`) gates every upgrade; technology effects add hero attributes; 3 `U_C_PLAYER_INFO` for diamonds; daily reset 4202 carries transmitter energy and blessing counters.
- [../army/README.md](../army/README.md): Quartel level caps soldier families (`PawnTempInfos.NeedBuilding`); recruitment spends castle gold and population; soldier technologies.
- [../currency/README.md](../currency/README.md): diamonds and bound diamonds (`point`, `giftToken`) for transmitter recharge; gold and crystal balances are owned here ([resources.md](resources.md)).
- [../world-map/README.md](../world-map/README.md): castle position, relocation UI (`WorldMapControler`, `MapPhysicsCastle`), wild lands that feed 152, castle protection 4452 / 8562.
- [../planes/README.md](../planes/README.md): planes list inside the Transmissor frame (9527).
- [../fantasy-bar/README.md](../fantasy-bar/README.md): "Toque de Midas" buffer (Fonte Mágica buffer 1) raises gold production and taxes.
- [../secretary/README.md](../secretary/README.md): bulk tax collection (8327 op 2).
- [../vip/README.md](../vip/README.md): free cooldowns and VIP castle look (`vip_castleView`).
- Portals from the castle map: [../farm/README.md](../farm/README.md) (Residência), [../mazes/README.md](../mazes/README.md) (Labirinto), [../magic-cards/README.md](../magic-cards/README.md) (Bar da Fantasia building), [../laboratory/README.md](../laboratory/README.md) (Laboratório de Platina), [../cat-house/README.md](../cat-house/README.md) (bubble only).
- Every HUD owner listed in [hud.md](hud.md).

## Cross-cutting rules

- Gold and light crystals live in `castle.resources`; every feature that spends or grants them calls the castle API and the server pushes 109 (see [resources.md](resources.md)).
- Building ids are server generated positive integers. Negative ids are client pseudo buildings and must never be used by the server: -7 Labirinto, -9 Residência, -11 Transmissor, -28 Bar da Fantasia, -29 Laboratório de Platina (`CWL:228-311`, `LIDA:840-844`).
- No castle message carries an error code except `BuildingInfoListMsg.result`. Failures are reported with the generic alert (assumed 111 `U_C_CHANNEL_ALERT`, same convention as [../guild/README.md](../guild/README.md)).
- Server rules must follow `raw/xml/tempinfos/BuildingTempInfos.xml` exactly, including the data quirk at Santuário level 71 ([buildings.md](buildings.md)).

## Implementation order

1. [resources.md](resources.md): `castle.resources`, ledger, 5015 / 109, production accrual. Everything else spends gold or crystals.
2. [buildings.md](buildings.md): `castle.buildings`, castle creation (Prefeitura 90101, Quartel 40201), 4154 at login, 8281, 8203, 4130.
3. [scene.md](scene.md): 8747, verify the castle renders every building and portal.
4. [levy.md](levy.md): taxes and the daily reset.
5. [technologies.md](technologies.md): Santuário creation at level 18, technology rows, effect totals exported to hero and army stats.
6. [transmitter.md](transmitter.md): energy, recharge, relocation (together with world-map).
7. [activity-queue.md](activity-queue.md): 366 assembler fed by the owning features.
8. [hud.md](hud.md): use as the checklist of entry points per feature.
9. [build-queue.md](build-queue.md) and [hook.md](hook.md): legacy stubs.
