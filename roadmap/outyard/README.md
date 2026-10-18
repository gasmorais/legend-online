# Terrálem ("Terrálem", "Luta da Terrálem")

Domain: world. Client package `outyard` (M11 frames and scene views, M3 explore views, `mvc.module.outyard` models, `yishi.manager.OutyardManager`). It has no protobuf package of its own: it drives the `hugehead` and `stackhead` packages (registered under [auto-chess](../auto-chess/README.md) in `roadmap/features.json`), `titanland` (registered under [dragon](../dragon/README.md)) and `shuttle` ([exploration](../exploration/README.md)). This folder maps every route the outyard UI uses; the registry owners should link here instead of duplicating.

Terrálem is a cross server guild territory war. Guilds sign up with guild fortune; the server groups 8 to 20 guilds into one battlefield split into 4 forces ("Poder Azul", "Poder Vermelho", "Poder Roxo", and force 4). The battlefield has 5 maps (4 home maps with a castle and 12 land nodes, and a central map with the crystal, explore entrances and the PvE buildings). Modes:
- "Luta de cristais" / central crystal war (stack head): timed sessions where forces bless themselves and attack each other's defence armies for score.
- Land map war (huge head): force chairmen declare war on land nodes; members join timed node battlefields of 11 positions; winners occupy the node; occupied nodes pay "Cristais da Terrálem" daily.
- "Pesquisa da Terralém" (explore): dice board PvE on explore nodes.
- "Santuário de Titã" (titan temple): PvE tower against player titans.
- Buildings opened from the central map: "Portal do Tempo" ([../exploration/shuttle.md](../exploration/shuttle.md)), "Abismo sem fim" ([abyss](../abyss/README.md)), child abysm ([guardians](../guardians/README.md)), time vortex.
- "Loja da Terrálem" spends "Cristais da Terrálem" (currency -3400, `outyardCoin`), shop controller openType 1004 ([shops](../shops/README.md)).

PostgreSQL schema: `outyard`. Rust handlers: `outyard::<module>::handle_<action>`.

Path aliases used in every module:

| Alias | Path |
|---|---|
| `OM` | `decompiled/core_module/scripts/yishi/manager/OutyardManager.as` |
| `OMOD` | `decompiled/core_module/scripts/mvc/module/outyard/` |
| `OC` | `decompiled/core_module/scripts/mvc/controler/OutyardControler.as` |
| `OY` | `decompiled/m11/scripts/outyard/` |
| `OY3` | `decompiled/m3/scripts/outyard/` |
| `TTB` | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| `CFG` | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |

`OutyardManager` (`OM:76-98`) registers every push: 306, 349, 350, 308, 309, 310, 311, 351, 352, 361, 375, 4460, 4451, 423, 427, 428. Senders: `OperateMapOutyard` 9594 (`OM:268-279`), `OperateRoute` 9595 (`OM:281-288`), `OperateArea` 9608 (`OM:290-302`), `OperateOutyard` 9599 (`OM:304-312`), `OperateTitan` 9617 (`OM:314-322`), `OperateShuttle` 8475, `OperateArcane` 8476, `OperateArcaneShare` 15058, abysm 9644.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Top bar button "Terrálem" (`TopBtnType.OUTYARD`) | hero level >= 13, `VersionSwitch.OUTYARD` (true), state received, in the space scene (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:295-296`) | `TTB.enterOutyardScene` (`TTB:1603-1675`) -> sign up alert or map frame (openType 3) |
| Space scene nodes 35, 36 (Terralém entrances) | same checks (`decompiled/m3/scripts/map/space/SpaceSceneController.as:682`) | same |
| Queue bar and daily guide | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:262`, `:329`; `decompiled/core_module/scripts/managers/DayGuideManager.as:869` | same |
| Top bar button "Prêmio da Luta" (`outyardreward`) | level 13 and extra field 14 not empty (`TopBtnCheckShowHelper.as:297-298`) | 9594 op 7 (`TTB:1299-1304`) |
| NPC node 40 "Salizette, Santuário de Titã" option 118, daily guide 72 | class changed, 06:00..23:00 (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2331-2349`) | titan temple (openType 9) |
| NPC node 41 "Walpoth, Portal do Tempo" option 119 | class changed | Time Portal (openType 10), see exploration |

Controller `outyard` (`OC:49-96`): 0 default `OutyardFrame` "Luta da Terrálem", 1 `OutyardMemberFrame`, 2 `OutyardBlessFrame`, 3 `outyard.scene.OutyardMapFrame`, 4 `OutyardEventFrame` "Casos da Terralém", 5 `OutyardArcaneFrame`, 6 `OutyardShuttleFightPetFrame`, 7 `abysm.AbysmFrame`, 8 `childabysm.ChildAbysmFormationFrame`, 9 `OutyardTitanFrame`, 10 `OutyardShuttleFrame`, 11 `abysm.HellAbysmFrame`.

## Modules

| Module | Content |
|---|---|
| [season.md](season.md) | Schedule and state (306), sign up and membership state (350), heartbeat, daily reward (op 7), events calendar "Casos da Terralém", extra fields 14 and 15 |
| [crystal-war.md](crystal-war.md) | "Luta da Terrálem" central crystal war: forces, blessings, attacks (battleType 3855), defence armies, senior generals, action points (9599 -> 308..311) |
| [land-map.md](land-map.md) | 5 map battlefield, nodes, declaring war, joining node battles, notice, crystal collection, occupation rewards (9594 -> 349) |
| [node-battle.md](node-battle.md) | Node battlefield of 11 positions: move, attack, guard, heartbeat, leave (9595 -> 351, 352) |
| [land-explore.md](land-explore.md) | "Pesquisa da Terralém" dice board (9608 -> 361) |
| [titan-temple.md](titan-temple.md) | "Santuário de Titã" (9617 -> 375, battleType 3860) |
| [../exploration/shuttle.md](../exploration/shuttle.md) | "Portal do Tempo" and "Chefão da Área Restrita" (opened from this map) |

## Dependencies

- Guild membership, chairman and right 46 (sign up), guild fortune: [guild](../guild/README.md).
- Battles: `docs/battle/server-engine.md` (3855, 3857, 3858, 3860, 3864, 3865).
- Titans owned by the player: [dragon](../dragon/README.md). Einherjars: [einherjar](../einherjar/README.md).
- Abyss buildings: [abyss](../abyss/README.md), [guardians](../guardians/README.md).
- Diamonds and items: [currency](../currency/README.md), [inventory](../inventory/README.md). Shop: [shops](../shops/README.md).
- Chat channel "Terralém" (`chatII.datas.getChatChannelName.OutyardChannel`): [chat](../chat/README.md).
- Cross server infrastructure (battlefield shared by guilds of several servers, `site`, `serverName` fields).

## Suggested implementation order

1. [season.md](season.md): schedule engine, sign up, grouping into battlefields and forces, 306/350 pushes.
2. [land-map.md](land-map.md): node state machine and 349 pushes.
3. [node-battle.md](node-battle.md): node battlefield simulation.
4. [crystal-war.md](crystal-war.md).
5. [land-explore.md](land-explore.md).
6. [titan-temple.md](titan-temple.md) (needs titans from the dragon feature).
