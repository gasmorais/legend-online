# Planes ("Planos", "Guerra dos Planos")

Domain: pve. Client packages `planeswar` (M3 scene `planeswar.PlanesWarSceneView`, core model `mvc.module.planeswar`, core frames `yishi.view.frame.planeswar`) plus the planes list inside the "Transmissor" building (M4 `buildings.transferbuilding.view`). Protobuf package `planes` (12 messages). Battle type 3843 `PLANES_WAR_BATTLE`.

The player uses a coordinates item ("Coordenações do Plano ...", SonType 606) to obtain a plane. Each plane (24 templates: 6 elements x 4 sizes, "Plano de Fogo Secundário" .. "Plano da Luz Grande") has 5, 11 or 17 layers ("áreas"/"pisos"). From the "Transmissor" the player teleports into the plane and explores a fog grid (8x8, 10x10, 12x12; hidden layers 3x3) spending energy ("Energia"). Grid events are walls, monsters, bosses (gold key), patrols (silver key), treasure chests, a black market ("Mercado Negro"), diamond mines ("Mina Comum", "Mina Elite"), portals between layers and the layer guardian ("Protetor"). Beating the guardian occupies the layer, which gives daily item rewards by mail and permanent resistance bonuses ("Adição dos efeitos de cristal"). Each plane has a life ("recurso") that decays daily; at 0% the plane disappears. Elemental resistance of the hero reduces energy costs.

All socket traffic uses one request opcode 9527 (0x2537) `C_PLANES_WAR_REQ` with an `op` code and six push opcodes. No HTTP. PostgreSQL schema: `planes`. Rust handlers: `planes::<module>::handle_<action>`.

Path aliases used in every module:

| Alias | Path |
|---|---|
| `PWM` | `decompiled/core_module/scripts/yishi/manager/PlanesWarManager.as` |
| `PMOD` | `decompiled/core_module/scripts/mvc/module/planeswar/PlanesWarModel.as` |
| `PCC` | `decompiled/core_module/scripts/mvc/module/planeswar/PlanesConstClass.as` |
| `PWI` | `decompiled/core_module/scripts/mvc/module/planeswar/info/PlanesWarInfo.as` |
| `PCTL` | `decompiled/core_module/scripts/mvc/controler/PlanesWarControler.as` |
| `TBF` | `decompiled/m4/scripts/buildings/transferbuilding/view/TransferBuildFrame.as` |
| `PLV` | `decompiled/m4/scripts/buildings/transferbuilding/view/PlanesListView.as` |
| `PIV` | `decompiled/m4/scripts/buildings/transferbuilding/view/PlanesItemView.as` |
| `PBAG` | `decompiled/m4/scripts/buildings/transferbuilding/view/planesbag/` |
| `PRF` | `decompiled/core_module/scripts/yishi/view/frame/planeswar/PlanesResourceFrame.as` |
| `PRIV` | `decompiled/core_module/scripts/yishi/view/frame/planeswar/PlanesResourceItemView.as` |
| `M3P` | `decompiled/m3/scripts/planeswar/` |

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Castle building "Transmissor" (building SonType 1511, controller key `transferbuilding`) | `VersionSwitch.PLANES_WAR && thane.grades >= 55` (`TBF:101-105`, `decompiled/core_module/scripts/yishi/OpenGradesII.as:234`); otherwise a "not open" image | `TransferBuildFrame` with `PlanesListView` and sends op 1 ([transmitter.md](transmitter.md)) |
| "Bolsa dos Planos" button in the list | none | `PlanesBagFrame`: bag items of SonType 606, "Usar" sends item use 5006 ([transmitter.md](transmitter.md)) |
| Item use of a coordinates item (SonType 606) from the main bag | owned item | creates a plane (server side of item use, [transmitter.md](transmitter.md)) |
| "Transmitir" button of a plane row | building power `property1 >= planes_warp_energy` (10) (`PIV:156-164`) | op 15 -> scene `PLANES_WAR_SCENE` ([exploration.md](exploration.md)) |
| Chat link type 112 ("pedir auxílio") | another player is dead in a plane | op 34 help revive ([events.md](events.md)) |
| Daily guide category 42 `PLANES_WAR` | `decompiled/core_module/scripts/mvc/module/dayGuide/DayGuideCatecory.as:108` | transfer building |
| Queue bar item type 11 "energia de planos" | always when the queue shows it (`decompiled/core_module/scripts/ui/queuebar/view/QueueItem.as:419-432`) | shows `energyLeft/planes_max_recover_energy` |

## Modules

| Module | Content |
|---|---|
| [transmitter.md](transmitter.md) | Planes list in the "Transmissor": op 1 list (4941), plane creation by item, give up op 18, add life op 17, buy energy op 20, energy regen poll op 32 (4944), planes bag, total income tip |
| [exploration.md](exploration.md) | `PLANES_WAR_SCENE`: teleport op 15, grid map 4943, state 4942, layer list 4981, move/trigger op 2, layer map and in-plane teleport op 36, layer skills op 3, buy energy op 8, leave op 19, restore position op 24, energy formulas |
| [events.md](events.md) | Grid events: monster and boss battles (battle 3843), card pick op 35, black market op 4, chests and keys, guardian occupation, death, revive op 6, help request op 33, help revive op 34 |
| [resources.md](resources.md) | "Informação de Planos de mina": occupied mines list op 30 (4978), collect op 31, layer daily rewards and resistance bonuses, plane life decay |

Op map of 9527 (`PCC:44-82`):

| op | Constant | Meaning | Module |
|---|---|---|---|
| 1 | `OPEN_FRAME_OP` | Ask planes list | [transmitter.md](transmitter.md) |
| 2 | `MOVE_OP` | Step move or trigger the event of the current cell | [exploration.md](exploration.md) |
| 3 | `OP_BUY_FUNC` | Buy a layer skill (101 clear obstacles, 201 summon guardian) | [exploration.md](exploration.md) |
| 4 | `MARKET_BUY_OP` | Black market buy | [events.md](events.md) |
| 6 | `LIFE_REVIVE_OP` | Self revive with diamonds | [events.md](events.md) |
| 8 | `BUY_ENERGY_OP` | Buy energy inside the scene | [exploration.md](exploration.md) |
| 15 | `TRANESFER_OP` | Teleport into a plane | [exploration.md](exploration.md) |
| 17 | `ADDLIVE_OP` | Add plane life with an essence item | [transmitter.md](transmitter.md) |
| 18 | `GIVEUP_OP` | Give up a plane | [transmitter.md](transmitter.md) |
| 19 | `LEAVING_OP` | Leave the scene | [exploration.md](exploration.md) |
| 20 | `ADD_ENERGY_OP` | Buy energy from the list | [transmitter.md](transmitter.md) |
| 24 | `RESET_POSXY_OP` | Restore position (reply handled, no client sender) | [exploration.md](exploration.md) |
| 30 | `REQUESTR_RESOURCE_OP` | Ask mine list | [resources.md](resources.md) |
| 31 | `GET_RESOURCE_OP` | Collect a mine | [resources.md](resources.md) |
| 32 | `GET_QUEUE_ENERGY_OP` | Energy regen poll | [transmitter.md](transmitter.md) |
| 33 | `REQUEST_REVIVE_OP` | Ask world help | [events.md](events.md) |
| 34 | `RESPONE_REVIVE_OP` | Help a dead player | [events.md](events.md) |
| 35 | `CARD_SELECT_OP` | Pick a card | [events.md](events.md) |
| 36 | `INPLANES_TRANESFER_OP` | Teleport to another layer of the same plane | [exploration.md](exploration.md) |
| 37 | `UPDATE_ENERGY_OP` | Constant only, no sender | - |

Push opcodes: 4941 `U_C_PLANES_WAR_LIST_MSG`, 4942 `U_C_PLANES_WAR_RSP_MSG`, 4943 `U_C_PLANES_WAR_MAP`, 4944 `U_C_PLANES_WAR_ENERGY`, 4978 `U_C_PLANES_WAR_RESOURCE_LIST`, 4981 `U_C_PLANES_WAR_LAYER_LIST`; listeners in `PWM:75-83`.

## Dependencies

- Castle building "Transmissor" (SonType 1511) and its power charge 5174 `PayTypeMsg` (`decompiled/core_module/scripts/managers/BuildingSocketOutManager.as:76-82`): [castle](../castle/README.md).
- Item use 5006 `ItemUseMsg` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:157-167`), bag pushes: [inventory](../inventory/README.md).
- Diamonds and bound diamonds (`point`, `allPoint`): [currency](../currency/README.md). Mail for daily layer rewards: [mail](../mail/README.md).
- Hero resistances (`thane.baseProperty.total*Resi`): [hero](../hero/README.md).
- Battle engine for battle type 3843: `docs/battle/server-engine.md`, `docs/battle/rules.md` row 3843.
- World chat link type 112 and bugle 208003: [chat](../chat/README.md).
- VIP raises `maxPlanesOwn` (tip "Ativar VIP e aumentar o Nv.VIP pode aumentar o número limite de Planos"): [vip](../vip/README.md).
- [sacrifice](../sacrifice/README.md) is opened from the planes list ("Sacrifício" button, `PLV:198-201`).

## Suggested implementation order

1. Template loaders (`PlanesTemplates`, `PlanesLayers`, `PlanesEvents`, `PlanesFuncTempInfos`, ConfigInfos `planes_*`).
2. Tables and plane creation on item use (SonType 606).
3. [transmitter.md](transmitter.md): op 1 -> 4941, energy regen and op 32 -> 4944, ops 17, 18, 20.
4. [exploration.md](exploration.md): layer generation, op 15 teleport (4981, 4943, 4942), op 2 movement and fog, op 36, op 19, op 3, op 8.
5. [events.md](events.md): non battle events (chests, keys, portals, market op 4), then battle events with battle type 3843, cards op 35, death and revive ops 6, 33, 34.
6. [resources.md](resources.md): mines, daily rewards mail job and life decay job.
