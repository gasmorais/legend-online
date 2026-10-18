# World map and outer city ("Mapa mundi e cidade exterior")

Client packages `map.outercity` (`decompiled/core_module/scripts/map/outercity`, `decompiled/m3/scripts/map/outercity`), `worldmap` (`decompiled/m11/scripts/worldmap`), shared map code in `map.internals`. Scene `OUTER_CITY_SCENE` ("Arredores"). The outer city is the strategic layer: every player's castle stands on one of five 10000 × 10000 px worlds; the hero army walks on it to raid other castles, hunt monsters and other heroes, occupy natural mines and pick boss chests; the castle can be moved inside a world or to another world with Transmissor energy.

All traffic is socket based. PostgreSQL schema: `world_map`. Rust handlers: `world_map::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Main tool bar "Arredores" button | level > 12, not in a campaign ("Saia da tela atual") | `OUTER_CITY_SCENE` on the castle world (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1244, 1372-1383`) |
| Key Q from castle or hub | confirm "Entrar no cenário dos Arredores" | same (`decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:674-750`) |
| Guide and task jumps `SwitchPageHelp.gotoOuterCity` | level ≥ 13, not bot mode, not in a campaign | same (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:721-744`) |
| Battle exit for battleType 1 to 5 and 3841 | | outer city at the army position (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:172-177, 211-213`) |
| Minimap world button "Mapa do Mundo (Atalho: M)" | level ≥ 15 | `WorldMapFrame` (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:555, 864-868`) |
| 105 after a castle relocation | | outer city on the new world |
| Exits | own castle "Entrar no Castelo", key Q ("Entrar no cenário da Cidade"), minimap Castle / Reino do Céu buttons | castle (8747) or hub (8688) |

## Modules

| Module | Content |
|---|---|
| [scene.md](scene.md) | Worlds 1 to 5 and 100, scene entry (5035 state 3) and exit, map files, chunk subscription 5004 / 5181 → 169 / 8201 → 4129, map updates 140, army removal 4168, castle record 4153, visibility (660 px), fog, castle sites table |
| [army-movement.md](army-movement.md) | Hero army walk 8254 → 4167, resync 8328 → 4241, return home 5161 → 98, teleport 8326 → 4237 / 4263, `ArmyMsg`, army states |
| [world-transfer.md](world-transfer.md) | World map frame, castle relocation to another world or an empty site (5176 → 105, handler owned by castle), relocation fan-out |
| [castle-pvp.md](castle-pvp.md) | Castle raids (5160), army PvP (8488), daily attacks (5/day), protection (4452, 118, 8562, item 208006), gains 4382 |
| [wild-lands.md](wild-lands.md) | Fields, monsters, treasures: `WildLandMsg`, attack (5160), occupation and release (5179 → 108), spawner and refresh |
| [map-boss.md](map-boss.md) | Event panel 9525 → 4938, daily kill caps 5/3/1, boss list and radar, fog 4939, boss chests 4940 / 9526 |

## Opcode summary

| Dir | Opcode | Name | Module |
|---|---:|---|---|
| C>S | 5035 | `U_PLAYER_CLIENT_STATE` (state 3) | scene |
| C>S | 5004 | `U_C_USER_DISPLAY` | scene |
| C>S | 5181 | `U_C_ARMY_UPDATE_GRID` | scene |
| C>S | 8201 | `C_PHYSICLIST_BYGRID` | scene |
| C>S | 8747 | `C_ENTER_CASTLE` (exit to castle) | scene |
| C>S | 8254 | `C_MOVE_POS` | army-movement |
| C>S | 8328 | `C_ARMYPOS_REQUEST` | army-movement |
| C>S | 5161 | `U_C_ARMY_RETURNHOME` | army-movement |
| C>S | 8326 | `C_ARMY_POSATION` | army-movement |
| C>S | 5176 | `U_C_BUILDING_TRANSCASTLE` | world-transfer (handler in castle) |
| C>S | 5160 | `U_C_ARMY_ATTACK` | castle-pvp, wild-lands |
| C>S | 8488 | `C_WORLDMAP_PVPFIGHT` | castle-pvp |
| C>S | 8562 | `C_CASTLE_TIME_CANCEL` | castle-pvp |
| C>S | 5179 | `U_C_UNOCCPWILDLAND` | wild-lands (handler in castle) |
| C>S | 9525 | `C_MAPBOSS_DATAS` | map-boss |
| C>S | 9526 | `C_MAPBOX_PICK` | map-boss |
| C>S | 9506 | `C_CASTLE_ATTACK` (no caller) | castle-pvp |
| S>C | 4153 | `U_C_LOAD_CASTLE` | scene |
| S>C | 169 | `U_C_ARMY_UPDATE_GRID` | scene |
| S>C | 4129 | `U_C_PHYSIC_LIST_UPDATE` | scene |
| S>C | 140 | `U_C_MAPDATA_SYNC` (types 1, 2, 3) | scene |
| S>C | 4168 | `U_C_ARMY_REMOVE` | scene |
| S>C | 4167 | `U_C_BROAD_POS` | army-movement |
| S>C | 4241 | `U_C_ARMYPOS_SEND` | army-movement |
| S>C | 98 | `U_C_ARMY_RETURNHOME` | army-movement |
| S>C | 4237 | `U_C_ARMY_POSATION` | army-movement |
| S>C | 4263 | `U_C_ARMYPOS_FAIL` | army-movement |
| S>C | 105 | `U_C_BUILDING_TRANSCASTLE` | world-transfer (sent by castle) |
| S>C | 118 | `U_C_CASTLE_DEFENSE` | castle-pvp |
| S>C | 4452 | `U_C_CASTLE_TIME` | castle-pvp |
| S>C | 4382 | `U_C_PLAY_GETMOIVE` | castle-pvp |
| S>C | 108 | `U_C_UNOCCPWILDLAND` | wild-lands (sent by castle) |
| S>C | 4938 | `U_C_MAPBOSS_DATAS` | map-boss |
| S>C | 4939 | `U_C_MAPBOSS_FOG` | map-boss |
| S>C | 4940 | `U_C_MAPBOSS_BOX` | map-boss |

## Cross-cutting rules

- Units: entity positions are 20 px cells; walk routes are pixels; chunks are 1000 px blocks `"cx_cy"`; UI coordinates are cell × 2 / 5.
- `.titles` cells of worlds 1 to 5 are obstacles (inverted compared with campaigns and the hub).
- Fan-out is per chunk: only players whose current view (5004) contains the chunk receive 140, 4167, 4168, 118 for it.
- `pay_type` of 5176 and 8326 does not separate energy from payment: the server spends energy when available, else charges `transport_charge_cost` (bound diamonds allowed when `pay_type = 2`).
- `ArmyMsg.mount_tempId` / `RoomPlayerMsg.mount_tempId` must always be present (0 when on foot); the readers apply them only when present.

## Dependencies

| Feature | Why |
|---|---|
| [../castle/README.md](../castle/README.md) | 4153 login record, Transmissor energy and the 5176 handler ([../castle/transmitter.md](../castle/transmitter.md)), field yields and the 5179 handler ([../castle/resources.md](../castle/resources.md)), minimap tools ([../castle/hud.md](../castle/hud.md)) |
| [../army/README.md](../army/README.md), [../hero/README.md](../hero/README.md) | army id, troops, hero for battles, `ArmyMsg` |
| [../battle/README.md](../battle/README.md) | raids, army PvP and wild land battles (battleType 1 to 5, 3841) |
| [../mounts/README.md](../mounts/README.md), [../fashion/README.md](../fashion/README.md), [../einherjar/README.md](../einherjar/README.md), [../guardians/README.md](../guardians/README.md) | army avatar fields and speed |
| [../guild/README.md](../guild/README.md) | same guild attack restrictions |
| [../inventory/README.md](../inventory/README.md) | protection item 208006 |
| [../friends/README.md](../friends/README.md), [../mail/README.md](../mail/README.md) | castle menu actions, battle reports |
| [../archaeology/README.md](../archaeology/README.md) | archaeology panel and counters inside 4938, node list 297 |
| [../returning-players/README.md](../returning-players/README.md) | king contract buff 10 for the boss radar |
| [../shops/README.md](../shops/README.md) | outer city shop (opened from the hub NPC Rona) |
| [../team/README.md](../team/README.md) | free team members always visible |
| [../sky-realm/README.md](../sky-realm/README.md) | key Q and minimap transitions; 140 type 3 also updates hub army states |
| [../currency/README.md](../currency/README.md), [../daily-activity/README.md](../daily-activity/README.md) | diamond payments, daily reset 4202 |

## Suggested implementation order

1. [scene.md](scene.md): worlds, castle sites, 4153, 5035 viewer registry, 5004 / 5181 / 8201 with 169 / 4129.
2. [army-movement.md](army-movement.md): 8254 / 4167, 8328, 5161, 8326.
3. [world-transfer.md](world-transfer.md): `world_map::castles` API used by the castle 5176 handler.
4. [wild-lands.md](wild-lands.md): monster spawner and 5160 against monsters.
5. [map-boss.md](map-boss.md): 9525 panel, kill caps, chests.
6. [castle-pvp.md](castle-pvp.md): raids, army PvP, protection.

## Current Rust server coverage

`server/flows/navigation.json`: 8328 → 4241 fixed (100,100) on map 1 with 500 energy; 9525 → 4938 with zeros (causes the polling loop described in [map-boss.md](map-boss.md)). Nothing else of the outer city is implemented.
