# Archaeology ("Arqueologia")

Domain: world. Client packages `archaeology` (M14 frames), `map.outercity.view.archaeology` (M3 outer city overlay) and `mvc.module.archeology` (model). Protobuf package `archaeology`.

The player walks around his outer city world ("arredores") following a colored radar to hidden dig points. Each dig ("Escavar") gives random fragments ("fragmentos") of archaeology items and archaeology experience. Fragments are exchanged for the real reward ("Arqueologia" frame), and sets of three collected items unlock picture rewards ("Imagem de Arqueologia": furniture, items, titles). Archaeology has 5 levels ("Básico", "Intermédio", "Avançado", "Mestre", "Divino"); level ups pay a mount and a title. From level 3 ("Avançado") the same dig points can be used for "Astrolábio" (star gazing, feature [cosmos](../cosmos/README.md)), sharing the daily dig counter.

All traffic is socket based through one request opcode, 9575 (0x2567) `C_ARCHAEOLOGY_REQ`, with an `op` code. No HTTP routes. PostgreSQL schema: `archaeology`. Rust handlers: `archaeology::<module>::handle_<action>`.

Path aliases used in every module:

| Alias | Path |
|---|---|
| `AM` | `decompiled/core_module/scripts/yishi/manager/ArchaeologyManager.as` |
| `AMOD` | `decompiled/core_module/scripts/mvc/module/archeology/ArchaeologyModel.as` |
| `OCAV` | `decompiled/m3/scripts/map/outercity/view/archaeology/OuterCityArchaeologyView.as` |
| `AUTO` | `decompiled/m3/scripts/map/outercity/view/archaeology/AutoArchaeologyOpera.as` |
| `OCM` | `decompiled/core_module/scripts/map/outercity/manager/OuterCityManager.as` |
| `COLL` | `decompiled/core_module/scripts/yishi/actions/map/collection/CollectionAction.as` |
| `M14A` | `decompiled/m14/scripts/archaeology/` |
| `BM` | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| HUD main tool button `archaeologyBtn` (shortcut R) | `MainToolCheckBtnOpen.getBtnKeyIsOpen("archaeologyBtn")`, hero level 15 (`docs/ui/navigation.md`); blocked with "Favor sair primeiro do grupo atual!" while in a "Batalha de Athena" team (`BraveLegManager.hasTeam()`) (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2335-2356`) | `FrameControllerManager.openControllerByInfo("archaeology")` -> `archaeology.ArchaeologyFrame` "Arqueologia" ([collection.md](collection.md)) |
| Same button, child button | "ProficiencyBtn" open | `theseussoul` (not archaeology, see [theseus](../theseus/README.md)) |
| Outer city scene overlay | outer world `mapId < 100` and hero level >= 15 (`decompiled/m3/scripts/map/outercity/OuterCityController.as:458-462`) | `OuterCityArchaeologyView` radar and "Escavar" ([dig.md](dig.md)) |
| "Imagem de Arqueologia" button inside the frame | none | `ArchaeologyBookFrame` ([handbook.md](handbook.md)) |
| "Astrolábio" button in the frame and bag items of SonType 800/801 | archaeology level >= 3 (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2488-2496`, `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:524-555`) | `stargazing` controller, feature [cosmos](../cosmos/README.md) |

## Modules

| Module | Content |
|---|---|
| [dig.md](dig.md) | Outer city dig points (297), radar, dig (op 1), star gazing dig (op 6), auto search (op 5 poll), buy digs (op 7), daily counters (260 fields 9, 23) |
| [collection.md](collection.md) | "Arqueologia" frame: fragments per item (298), exchange fragments (op 3), archaeology level and exp (260 field 8), level up rewards (book Type 2) |
| [handbook.md](handbook.md) | "Imagem de Arqueologia": picture sets of 3 items, claim (op 4), state list (296, op 2) |

Op map of 9575 (all modules):

| op | Meaning | Module |
|---|---|---|
| 1 | Dig a node in archaeology mode | [dig.md](dig.md) |
| 2 | Open frame, ask handbook states | [handbook.md](handbook.md) |
| 3 | Exchange fragments for the item | [collection.md](collection.md) |
| 4 | Claim a picture (handbook) reward | [handbook.md](handbook.md) |
| 5 | Ask the dig node list | [dig.md](dig.md) |
| 6 | Dig a node in star gazing mode | [dig.md](dig.md) |
| 7 | Buy dig counts | [dig.md](dig.md) |

## Dependencies

- Outer city scene, army position and the collect animation `CollectionAction` (world feature, `docs/world/README.md`).
- Player extra field push 260 `U_C_PLAYER_EXTRA_FIELD_MSG` (fields 8, 9, 23), shared with other features (owner: hero/account).
- Bag and currency pushes for rewards: [inventory](../inventory/README.md), [currency](../currency/README.md).
- Furniture rewards: [farm](../farm/README.md) (residence furniture bag). Titles ("RewardAppell"): [medals](../medals/README.md). Mount items: [mounts](../mounts/README.md).
- Star gazing dig result (4687): [cosmos](../cosmos/README.md).
- Diamonds for buying digs: [currency](../currency/README.md).

## Suggested implementation order

1. Tables and template loaders (`ArchaeologyItemTemps.xml`, `ArchaeologyBookTemps.xml`, `UpGradeTempInfos.xml` Types 111, config keys).
2. Login push of 298 (all fragments), 296 (handbook states) and 260 fields 8, 9, 23.
3. [dig.md](dig.md): node generation per player and map, op 5 -> 297, op 1 dig with drops and exp, op 7 buy.
4. [collection.md](collection.md): op 3 exchange, level computation, level up rewards.
5. [handbook.md](handbook.md): op 2 and op 4.
6. Op 6 star gazing dig once [cosmos](../cosmos/README.md) exists.
7. Daily reset job.
