# World map: hero army movement, return and teleport

Area: world-map, module `army-movement`. Covers the own hero army on the outer city map: walking (8254 per segment, 4167 broadcast), position resync (8328 → 4241), return to the castle (5161 → 98), the "Transferir Herói para qualquer lugar" teleport (8326 → 4237 / 4263), army records (`ArmyMsg`), army states and the menu on armies.

Conventions: see [scene.md](scene.md). Walk routes are **pixels**; army positions are **cells**.

## 1. Overview

Each player has one hero army on the world map, standing next to its castle by default. Clicking the ground, a castle, a wild land or a monster makes the army walk there: the client computes the path (`PathRoboSearcher` over the obstacle grid) and, every time the army starts a new segment, sends that segment to the server (8254). The server stores the position and broadcasts the segment (4167) to everyone watching the chunk. Arriving at an entity opens its interaction (castle info, field info, monster attack confirmation). The army can be sent back to the castle for free (5161) and teleported anywhere on the world with Transmissor energy or diamonds (8326).

## 2. Screens

| Class | pt-BR | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `map.outercity.view.mapphysics.ArmyView` (`M3/map/outercity/view/mapphysics/ArmyView.as`) | none | Hero avatar on the world map with name, level, guild, mount, pet, guardian, chat bubble | `WorldWalkLayer` (`M3/map/outercity/view/layer/WorldWalkLayer.as`) | `ArmyMsg` fields (§4) |
| Walk target marker / "Atacando alvo" movie | none | target marker for ground clicks, attack movie over target entities | `OuterCityController.__startMoveHandler` (`M3/map/outercity/OuterCityController.as:681-739`) | |
| `TransmitHandler` cursor (`M3/map/outercity/mediator/mapview/TransmitHandler.as`) | "Transferir Herói para qualquer lugar" (minimap) | Teleport cursor; confirm "Essa ação consumirá 100 pontos de energia, continuar?" | minimap transmit button (level ≥ 15) | |
| `PlayerMenu` on another army | player menu | friend, chat, etc. | `ArmyView.mouseClickHandler` (`ArmyView.as:1277-1308`) | target player |
| Minimap tools | "Localizar coordenadas do Herói", "Transferir de volta à cidade", "Localizar entrada de coordenadas" | camera jumps and return home | `OuterCitySmallMapMediator` (`M3/map/outercity/mediator/mapview/OuterCitySmallMapMediator.as:30-144`) | coordinates (input × 50 px) |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| A1 | Army reaches a path waypoint and starts the next segment (automatic after any walk order) | `ArmyView.nextWalk` (`ArmyView.as:452-464`) → `OuterCityController.sendWalkPathII` (`OuterCityController.as:1360-1387`) → `OuterCitySocketOutManager.sendMovePaths` (`M3/map/outercity/manager/OuterCitySocketOutManager.as:99-103`) | own army only; walk orders come from ground clicks (`START_MOVE` with a point), entity clicks (target = entity px + (0, 40)) and PK chase; the path is computed by `SceneScene.searchPath` (`M3/map/outercity/path/SceneScene.as:69-72`) | C>S 8254 0x203e `C_MOVE_POS` | `PosMoveMsg` (worldmap): `map_id (#1, INT32)` shown world, `army_id (#2, INT32)` own army, `routes (#3, RouteMsg, repeated)` = [current view position, next waypoint] in px (`x (#1)`, `y (#2)`; `param1 (#3)` unset), `grid_str (#4, STRING)` chunk of the current position `"cx_cy"` | No reply to the sender. Push 4167 to the watchers of the chunk(s) |
| A2 | Army map mismatch ("Sincronizando tropa..."): locate army, return home or walk while `army.mapId != shown map` | `OuterCityController.__syscArmyHandler` (`:571-574`) → `OuterCitySocketOutManager.sendArmyPosRequest` (`OuterCitySocketOutManager.as:48-52`) | none | C>S 8328 0x2088 `C_ARMYPOS_REQUEST` | no body | 4241 |
| A3 | Minimap "Transferir de volta à cidade" | `OuterCitySmallMapMediator.returnCastle` (`OuterCitySmallMapMediator.as:116-119`) → `OuterCityController.sendReturnHomeArmy` (`OuterCityController.as:1240-1271`) → `OuterCitySocketOutManager.sendArmyBack(1)` (`OuterCitySocketOutManager.as:91-97`) | army on the shown world (else A2); army at least 12 cells from the castle ("Tropa está perto do castelo") | C>S 5161 0x1429 `U_C_ARMY_RETURNHOME` | `PayTypeMsg` (player): `pay_type (#1, INT32)` = 1; `property1/2`, `type` unset | 98 |
| A4 | Teleport cursor click on a free cell, then confirm | `TransmitHandler.__mouseUpHandler` → `__transferHandler` → `transferBack` → `senPosation` (`TransmitHandler.as:161-280`) | button at level ≥ 15; the target cell must not be an obstacle ("Não é possível transferir para essa zona"); click (not drag, < 3 px); with energy ≥ 100 the packet is sent at once; below 100 a paid confirm "Energia insuficiente, para energizar transmissor consumirá {0} diamantes!" ({0} = `transport_charge_cost` = 10) with the bound diamond checkbox | C>S 8326 0x2086 `C_ARMY_POSATION` | `ArmyPositionMsg` (army): `pos_x (#1, INT32)`, `pos_y (#2, INT32)` target cell (px / 20), `pay_type (#4, INT32)` = 2 when energy ≥ 100 or bound diamonds allowed, 1 when paying with real diamonds only; `map_id (#3)`, `left_energy (#5)` unset | 4237 on success, 4263 on failure; the client masks the screen until one arrives (50 s timeout) |

The menu entry "Invocar" (`BTN_CALL`) only shows "Invocação não suportada" (`ArmyView.as:1343-1347`); the army menu (`PhysicsMenu.showArmyMenu`) has no caller.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4167 0x1047 `U_C_BROAD_POS` | `PosMoveMsg` (worldmap): `army_id (#2)`, `routes (#3, RouteMsg, repeated)` px; other fields (`map_id`, `grid_str`, `userId (#5, repeated)`, `server_name (#6)`, `userStates (#7, RouteStateMsg, repeated)`, `army_state (#8)`) unused | `OuterCityController.__broadPosHandler` (`:871-896`) | Push to watchers for each accepted 8254 of another army (not to the mover) | Path = [current view position] + routes |
| S>C 4241 0x1091 `U_C_ARMYPOS_SEND` | `ArmyPositionMsg`: `pos_x (#1)`, `pos_y (#2)` cells, `map_id (#3)`; `pay_type`, `left_energy` unused | `OuterCityController.__syncArmyPosHandler` (`:852-861`) | Reply to A2 | Sets the own army map and cell |
| S>C 98 0x0062 `U_C_ARMY_RETURNHOME` | `OutercityRspMsg` (outercity): `result (#1, INT32)` = own army id, `cur_pos_x (#4)`, `cur_pos_y (#5)` cells (castle position); `start_pos_*`, `end_pos_*` unused | `OuterCityController.__returnHomeHandler` (`:1144-1175`) | Reply to A3 | If `result` is the own army id: places the army at the cell, centers the camera, `returnHome`. Any other `result` is ignored (use it as the failure signal) |
| S>C 4237 0x108d `U_C_ARMY_POSATION` | `ArmyPositionMsg`: `pos_x`, `pos_y` cells, `left_energy (#5)` Transmissor energy after the jump | `OuterCityController.__transferPosationHandler` (`:1177-1224`), `TransmitHandler.__transferPosationHandler` (`TransmitHandler.as:282-288`) | Reply to A4 on success | Moves the army, plays the transmit movie, updates building -11 `property1` |
| S>C 4263 0x10a7 `U_C_ARMYPOS_FAIL` | no body read | `TransmitHandler.__transferPosationHandler` | Reply to A4 on failure | Removes the mask only |
| S>C 169, 140 type 3, 4168 | see [scene.md](scene.md) | | army lists, army updates, removal | |

### `ArmyMsg` fields read on the world map (`ThaneInfoHelper.readOuterCityArmyInfo`, `CM/com/road/pb/helper/army/ThaneInfoHelper.as`)

| Field | Tag, type | Meaning |
|---|---|---|
| `army_id` | #1, INT32 | army key |
| `player_id` | #2, INT32 | owner |
| `nick_name` | #3, STRING | name |
| `map_id` | #4, INT32 | world |
| `cur_pos_x`, `cur_pos_y` | #5, #6, INT32 | cell |
| `state` | #7, INT32 | `ArmyState`: 0 waiting, 1 moving, 2 fight, 3 battle pending, 4 recalling, 6 campaign |
| `type` | #8, INT32 | army type; 2, 4, 5 are forwarded to the scene by 140 |
| `consortia_id`, `consortia_name` | #11, #12 | guild |
| `fightingCapacity`, `gpOrder`, `grades` | #13, #14, #15 | power, level rank, level |
| `arm`, `cloth`, `job`, `change_sharp`, `hero_tempId` | #16 to #20 | avatar |
| `geste`, `is_vip`, `vip_type` | #22 to #24 | honor, VIP |
| `mount_tempId`, `mount_grade` | #25, #26 | riding (send 0 explicitly when on foot; read only when present) |
| `wing`, `hat`, `fashion_arm`, `fashion_cloth`, `hide`, `appellid`, `fate_skills` | #27, #29 to #34 | appearance |
| `pet_tempId`, `pet_quqlity`, `pet_name` | #35 to #37 | following pet |
| `child_job`, `child_name`, `child_sex`, `growth_grade` | #38 to #41 | following guardian |
| `avenger_grade` | #43 | avenger effect |

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| AM1 | Path search: `PathRoboSearcher(step 20, maxDistance 100000, 8 turns)` over the obstacle grid (truthy `.titles` cell = blocked). Start point snapped to a free cell (`GetWalkStartPointHelper`). | `M3/map/outercity/path/SceneScene.as:17-21`, `PathRoboSearcher.as:21-63`, `M3/map/outercity/helper/mapview/GetWalkStartPointHelper.as` |
| AM2 | Speed: 7 on foot, `7 × (100 + maxSpeed) / 100` when riding (same formula as the hub). | `CM/map/internals/utils/ArmySpeedUtils.as:14-29`, `WorldWalkLayer.as:171`, `ArmyView.as:963` |
| AM3 | Segment reporting: one 8254 per waypoint, route = [position at segment start, waypoint]; `grid_str` = chunk of the start. | `ArmyView.as:452-464`, `OuterCityController.as:1360-1387` |
| AM4 | Arrival: when the walk ends within 100 px of the target entity the client opens castle info (castle), field info (wild land type 20) or the monster or treasure confirm (types 21, 22). | `OuterCityController.as:586-655` |
| AM5 | Return home allowed only at ≥ 12 cells from the castle and on the castle world; free in this build (`pay_type 1`; the paid return dialog `portal()` has no caller). | `OuterCityController.as:1240-1332` |
| AM6 | Teleport cost: 100 Transmissor energy; below 100 a full recharge price of `transport_charge_cost` (10 diamonds) is charged instead, bound diamonds allowed when the checkbox is set. `pay_type` does not tell energy from payment (energy path sends 2); the server decides by the current energy. | `TransmitHandler.as:189-240`, `raw/xml/tempinfos/ConfigInfos.xml` (`transport_charge_cost`) |
| AM7 | Teleport target must be a non obstacle cell of the shown world. | `TransmitHandler.as:173-185, 242-245` |
| AM8 | Army can act (attack, walk) when `state` is 0, 1 or 4 (`ArmyState.moveState`) and it is on the target's world (the newbie coast 100 accepts armies whose map id > 100000). Messages "Não há Herói na tropa", "Herói não está em estado inativo", "Herói não está nessa cidade". | `CM/map/outercity/OuterCityModel.as:517-560`, `CM/map/internals/constant/ArmyState.as` |
| AM9 | Coordinates input of the minimap: UI units × 50 px. | `OuterCitySmallMapMediator.as:103-114` |

Server validation (assumptions): `army_id` must be the session army; `map_id` must equal the army world; `routes[0]` within 60 px of the stored position; the segment must not cross obstacle cells (Bresenham over 20 px cells); minimum elapsed time between segments ≥ `distance / (speed × 25 px/s)` × 0.8. On violation push 4241 with the stored position to the mover.

## 6. Templates

| File | Fields |
|---|---|
| `raw/maps/<1..5>/<id>.titles` | obstacles for validation and teleports |
| `raw/xml/tempinfos/ConfigInfos.xml` | `transport_charge_cost` 10 |
| `raw/xml/tempinfos/BuildingTempInfos.xml` | Transmissor 151101 `Property2` = 500 max energy ([../castle/transmitter.md](../castle/transmitter.md)) |

## 7. Persistent state

```sql
CREATE TABLE world_map.armies (
    army_id          BIGINT PRIMARY KEY,
    player_id        BIGINT NOT NULL UNIQUE REFERENCES player.players(player_id) ON DELETE CASCADE,
    map_id           INTEGER NOT NULL REFERENCES world_map.worlds(map_id),
    cell_x           INTEGER NOT NULL,
    cell_y           INTEGER NOT NULL,
    state            SMALLINT NOT NULL DEFAULT 0 CHECK (state IN (0, 1, 2, 3, 4, 6)),
    target_px_x      INTEGER,
    target_px_y      INTEGER,
    segment_started_at TIMESTAMPTZ,
    updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX armies_map_cell_idx ON world_map.armies (map_id, cell_x, cell_y);

CREATE TABLE world_map.teleport_log (
    log_id           BIGSERIAL PRIMARY KEY,
    player_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    map_id           INTEGER NOT NULL,
    from_cell_x      INTEGER NOT NULL,
    from_cell_y      INTEGER NOT NULL,
    to_cell_x        INTEGER NOT NULL,
    to_cell_y        INTEGER NOT NULL,
    paid_with        TEXT NOT NULL CHECK (paid_with IN ('energy','diamonds','bound_diamonds')),
    created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

`army_id` is the id already used by the army feature ([../army/README.md](../army/README.md)); this table only holds the world map placement.

## 8. Backend implementation notes

- `world_map::army_movement::handle_move` (8254): validate (§5); update `cell_x/y` to the segment end cell (store `segment_started_at` for speed checks), set state 1 while walking (assumption: back to 0 when no new segment arrives within the expected time); push 4167 `{army_id, routes}` to viewers of the chunk of both endpoints; push 140 type 3 only on state changes.
- `world_map::army_movement::handle_pos_request` (8328): reply 4241 with the stored map and cell.
- `world_map::army_movement::handle_return_home` (5161): army on the castle world; move the army to the castle cell; reply 98 `{result: army_id, cur_pos_x, cur_pos_y}`; push 4167 or 140 type 3 to viewers so they see the jump (assumption).
- `world_map::army_movement::handle_teleport` (8326): target in bounds and not an obstacle; Transmissor energy (castle feature API) ≥ 100 → spend 100; else charge `transport_charge_cost` (bound diamonds first when `pay_type == 2`), refuse with 4263 if the balance is short; in one transaction update the army cell and the energy (and the currency ledger); reply 4237 `{pos_x, pos_y, map_id, left_energy}`; push 140 type 3 to viewers of the old and new chunks.
- The army record in 169/140 is built by `world_map::army_movement::build_army_msg(player_id)` (uses hero, mounts, fashion, pets, guardians, guild).

## 9. Open questions and assumptions

- Whether the server recomputed the path or only trusted segments is unknown; the proposal trusts segments with validation.
- State 1 timing and the transition back to 0 are assumptions.
- 4263 has no body in the client; reason codes are not shown.
- `PosMoveMsg.userId`, `userStates`, `army_state` exist for team walks and are not read by the outer city.

## 10. Implementation checklist

- [ ] Route A1 8254 `handle_move` with validation and 4167 fan-out
- [ ] Route A2 8328 → 4241
- [ ] Route A3 5161 → 98
- [ ] Route A4 8326 → 4237 / 4263 with energy or diamonds
- [ ] Builder `build_army_msg`
- [ ] Tables `world_map.armies`, `world_map.teleport_log`
- [ ] Test: A walks, B (watching the chunk) sees the same segments
- [ ] Test: return home from far away and refusal near the castle
- [ ] Test: teleport with 100+ energy, with diamonds, onto an obstacle (refused)
