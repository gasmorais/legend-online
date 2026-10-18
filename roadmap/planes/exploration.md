# Planes exploration scene

Feature [planes](README.md), module `exploration`. Aliases in [README.md](README.md).

## 1. Overview

- Op 15 teleports the player into a plane: the client switches to scene `PLANES_WAR_SCENE` (`planeswar.PlanesWarSceneView`), loads the layer background `planeswar/map/{LandType}/{Size}.jpg` (`decompiled/core_module/scripts/yishi/manager/PathManager.as:297-304`) and draws a grid of 100x100 px cells (`COLUMN_NUM x ROW_NUM` from `PlanesLayers.Size`, `PWI:47-60`).
- Cells are sent by 4943 (`PlanesWarGridMsg`): `opened` false cells are fog; `event_id` places an icon (`PlanesEvents.Icon`). Walls (`EventType -1`) block pathing (`PMOD:283-314`).
- The player clicks a cell: the client computes a 4-neighbour A* path over opened, non wall cells (`PMOD:369-377`, `:437-450`) and walks it; at each step it sends op 2 with `[fromX, fromY, toX, toY]` (`M3P/view/PlanesArmyView.as:433-449`). Clicking an unopened cell adjacent to the hero is allowed (direct step, `PMOD:316-335`, `:441-444`); unopened cells further away give "Por favor, primeiramente vá ao local mais próximo, em seguida comece a explorar esta área desconhecida." (`PCTL:103-108`).
- Clicking the hero's own cell, or arriving at the clicked end cell, sends op 2 with `[x, y]` to trigger the cell event (`PCTL:74-95`, `PWM:352-363`). The resulting event is described in [events.md](events.md).
- Step cost: `int((1500 + R) / (300 + R))` energy per newly opened cell, R = hero resistance of the layer `ResistType` (`PMOD:379-393`); 5 at R = 0, tending to 1.
- Layers: the layer map ("Informação do Plano") lists the layers of the current plane; activated layers can be entered with op 36. Portals inside the grid (EventType 61/62, 71/72, 8, 91/92) are events ([events.md](events.md)).
- Layer skills ("Habilidades", `PlanesFuncTempInfos`): 101 removes every obstacle of the layer, 201 summons the official guardian; each costs 100 energy or 100 diamonds and only applies to the current layer (op 3).
- Leaving: HUD exit button -> confirm -> op 19 -> back to `CASTLE_SCENE` (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1619-1621`, `:1858-1864`, `PWM:396-400`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `M3P/PlanesWarSceneView.as` | scene `PLANES_WAR_SCENE` | Full screen scene, refuses room and team invites while inside (`:207-231`) | op 15 or op 36 reply, battle 3843 exit (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:214-223`) | map, UI layer |
| `M3P/view/PlanesWarMapView.as`, `PlanesGridIconView.as`, `PlanesWarFogView.as`, `PlanesWalkLayer.as`, `PlanesArmyView.as` | - | Grid, fog, event icons with `PlanesEventTips` ("Nível necessário: {0}", "Energia necessária: {0}"), hero avatar, dead state | scene | `gridArr`, `posX/posY`, `dead` |
| `M3P/view/PlanesTopView.as` | energy bar, tip "Energia:Explorar área desconhecida irá Consumir energia, quanto maior for a Resistência correspondente, menor será o consumo de energia" | Energy and buy energy (op 8) | UI layer | `energyLeft/planes_max_recover_energy` (`:90-106`) |
| `M3P/view/PlanesLeftView.as` | "Nº de ressucitações: {0}" | Revives left, gold and silver keys, buttons mines, layer map, help, skills (disabled on hidden layers) | UI layer | `reviveLeft`, `goldKeyCount`, `silverKeyCount` (`:129-135`) |
| `M3P/view/PlanesRightView.as` | "Plano atual já foi ocupado" / other text, "Após completar este piso pode no máximo produzir adicionalmente:" | Current layer info: occupation, enemy skill description, resistance bonuses, daily rewards | UI layer, hidden on hidden layers (`:91-176`) | `PlanesLayers.EnemySkill`, `*ResiBonus`, `DailyRewards` |
| `M3P/view/PlanesSmallMapView.as` | - | Minimap | UI layer | opened cells |
| `M3P/view/PlanesWarLayerMapFrame.as`, `PlanesWarLayerItem.as` | title = `PlanesName` | Layer map with key icons and occupation state | left view map button (`PlanesLeftView.as:112-116`) | `planesLayerList` (frame 1 normal, 2 occupied by me, 3 not activated) |
| `M3P/view/PlanesUseSkillFrame.as`, `PlanesSkillShowView.as`, `PlanesFuncItem.as` | "Habilidades" (`planes.PlanesUseSkillFrame.titleText`) | Buy layer skills | left view skill button | bought (`buyList`) and not bought functions (`PMOD:498-521`) |
| `M3P/view/PlanesWarIconHelpView.as` | "Chave de Ouro: Abrir o transmissor de ouro", ... | Icon legend | left view help button | static |

## 3. Routes (client to server)

Request envelope: 9527 `PlanesWarReqMsg` (`op` #1, `param` #2 repeated INT32, `paramStr` #3 unused), see [transmitter.md](transmitter.md).

### R1. Teleport into a plane (op 15)

- UI: "Transmitir" in the planes list (`PIV:156-164`).
- Client check: transmitter power `bInfo.property1 >= planes_warp_energy` (10), else "Energia do transmissor insuficiente, favor carregar".
- Request: `op = 15`, `param = [planesId]`.
- Expected server sequence: 4981 (`op = 0`, all layers of the plane), 4943 (cells of the entry layer, new `stamp`), 4942 `op = 15` with `planes_temp_id`, `layer_id`, `layer_temp_id`, `pos_x`, `pos_y`, `dead`, `revive_left`, `gold_key_count`, `silver_key_count`, `energy_left`. On 4942 op 15 the client sets `isInPlanesWar` and switches scene (`PWM:390-394`); the scene builds the grid on `preLoadingStart` from data already received (`M3P/PlanesWarSceneView.as:59-74`), so 4942 must carry `layer_temp_id` (it sets the grid size, `PWI:47-60`) and 4943/4981 must arrive before or with it.
- Entry position: the "Base de Entrada" cell (event 3, EventType 998) of the layer (assumption).

### R2. Step (op 2, 4 params)

- UI: walking along a computed path; sent when the avatar is within 20 px of the next cell center (`PlanesArmyView.as:433-449`).
- Client checks (before walking, `PCTL:54-116`): not dead; 500 ms click throttle ("activity.view.ActivityItem.command01"); destination not a wall; path exists.
- Request: `op = 2`, `param = [curX, curY, nextX, nextY]`.
- Server: validate adjacency (4-neighbour), destination not a wall, not dead, energy >= step cost if the destination is unopened; deduct energy; open the destination and its 8 neighbours (assumption, fog reveal radius 1; the minimap uses `checkIsNineAround`, `PMOD:337-344`); set position.
- Response: 4943 with the newly opened cells (same `stamp`) and 4942 `op = 2` with `pos_x`, `pos_y`, `energy_left`. On 4942 op 2 the client checks arrival at `endPoint` and auto sends R3 (`PWM:352-363`).
- Error: insufficient energy text "Energia insuficiente, não pode explorar regiões desconhecidas" (assumption: server sends 4942 op 2 with the unchanged position plus a tip; then use op 24 restore position, see R8).

### R3. Trigger the cell event (op 2, 2 params)

- UI: click on the hero's own cell, or automatic on arrival (`PCTL:74-95`, `PWM:352-363`).
- Client checks: event `NeedLevel <= grades` ("Nível insuficiente, não é possível dispertar caso"); `energyLeft >= getEventCostEnergyByResistance` ("Essências insuficientes, não é possível dispertar caso."). Own entry base (`frontBase` and `occupyName == nickName`) does nothing.
- Request: `op = 2`, `param = [x, y]`.
- Response: depends on the event ([events.md](events.md)): 4942 with `event_info` to open an event frame, a battle start, or plain state updates.

### R4. Teleport to another layer (op 36)

- UI: click an activated layer that is not the current one in the layer map (`PlanesWarLayerItem.as:63-74`).
- Request: `op = 36`, `param = [layerId]`.
- Response: 4943 (new `stamp`, full cells of the target layer), 4981 `op = 1` (changed layers), 4942 `op = 36` with the new `layer_id`, `layer_temp_id`, `pos_x`, `pos_y`. On op 36 the client reloads the scene (`PWM:365-368`).
- Server checks: layer belongs to the current plane and `is_activated`. Energy cost: none known (assumption).

### R5. Buy a layer skill (op 3)

- UI: `PlanesUseSkillFrame` energy button and diamond button (`PlanesUseSkillFrame.as:107-160`).
- Client checks: a not bought skill selected; energy: `energyLeft <= NeedEnergy` refuses ("planes.PlanesUseSkillFrame.noEnergyAlert"); diamonds: `allPoint` (bind) or `point` >= `NeedPoint`, else recharge; confirmations through `SharedManagerHelper` (daily skip). The energy button is hidden when the layer already has 2 skills bought.
- Request: `op = 3`, `param = [funcTemplateId, payMode]`, payMode 1 diamonds, 2 bound diamonds first, 3 energy.
- Response: 4981 `op = 1` with the layer `buyList` updated, 4943 with changed cells (101: walls removed; 201: guardian event replaced or defeated, assumption), 4942 `op = 3` (energy). Client callback `PLANES_FUNCBUY_BACK` (`PWM:380-383`).

### R6. Buy energy in the scene (op 8)

- UI: `PlanesTopView` add energy (`PlanesTopView.as:108-135`).
- Client checks: same as list op 20 (limit, `allPoint >= 30`), not moving; confirm with bind checkbox.
- Request: `op = 8`, `param = [payType]` (2 when bind checked, else 1).
- Response: 4942 `op = 8` with `energy_left`, `buy_energy_count`. Shared handler with op 20 ([transmitter.md](transmitter.md)).

### R7. Leave (op 19)

- UI: HUD exit while in `PLANES_WAR_SCENE`, confirm "ui.maintoolbar.MainToolBar.exitPlanesWar.alert" (`MainToolBar.as:1619-1621`). The client sets `isInPlanesWar = false` and sends op 19 (`MainToolBar.as:1858-1864`).
- Response: 4942 `op = 19` -> `CASTLE_SCENE` (`PWM:396-400`).

### R8. Restore position (op 24, server initiated)

- No client sender. A 4942 with `op = 24` and `pos_x/pos_y` makes the walk layer snap the hero back (`PWM:402-406`, `PlanesWalkLayer.as` `RESTORE_POSXY`). Use it to reject a step.

## 4. Server messages (server to client)

### 4942 (0x134e) `U_C_PLANES_WAR_RSP_MSG`

- Message `PlanesWarRspMsg`: `op` (#1, INT32) echo of the request op (drives the callback table `PWM:59-73`); `energy_left` (#2, INT32); `buy_energy_count` (#3, INT32); `revive_left` (#4, INT32); `planes_temp_id` (#5, INT32); `layer_temp_id` (#6, INT32); `layer_id` (#7, INT32); `dead` (#8, BOOL); `pos_x` (#9, INT32); `pos_y` (#10, INT32); `gold_key_count` (#11, INT32); `silver_key_count` (#12, INT32); `event_info` (#13, MESSAGE `PlanesWarEventMsg`) see [events.md](events.md).
- Every field is optional; the client only overwrites fields that are present (`PWM:193-241`), then dispatches `PLANES_WARINFO_UPDATE` (top, left, right, minimap refresh).
- Callbacks by `op`: 2 move check, 3 `PLANES_FUNCBUY_BACK`, 4 `PLANES_MARKETOP_BACK`, 6 `PLANES_REVIVE_BACK`, 15 enter scene, 19 leave scene, 24 restore position, 34 `HELP_RERIVE_BACK`, 35 `PLANES_CARDOP_BACK`, 36 reload scene (`PWM:59-73`, `:352-411`).
- When `event_info` is present the packet is buffered until the scene is `PLANES_WAR_SCENE` and then opens the event frame (`PWM:170-181`).

### 4943 (0x134f) `U_C_PLANES_WAR_MAP`

- Message `PlanesWarMapMsg`: `stamp` (#1, INT32) map version; `grid` (#2, MESSAGE `PlanesWarGridMsg`, repeated).
- `PlanesWarGridMsg`: `x` (#1, INT32) column; `y` (#2, INT32) row; `opened` (#3, BOOL) fog removed; `event_id` (#4, INT32) `EventTempId` or 0; `occupied` (#5, BOOL) castle (EventType 12) taken; `occupy_name` (#6, STRING) name shown on castles and on the entry base.
- Receiver: `PWM.__updateGridInfoHandler` (`PWM:124-161`): a higher `stamp` clears the grid (new layer); a lower `stamp` is ignored; the same stamp merges cells by `x*100+y`. Dispatches `PLANES_GRIDINFO_UPDATE`.
- When: full grid on op 15 and op 36 (new stamp, include every cell with `opened` and `event_id`; unopened cells may hide `event_id = 0`, assumption); deltas after steps, events, skills.

### 4981 (0x1375) `U_C_PLANES_WAR_LAYER_LIST`

- Message `PlanesLayerListMsg`: `op` (#1, INT32) 0 = full list (replace), other = merge; `layerList` (#2, MESSAGE `PlanesLayerInfoMsg`, repeated) (fields in [transmitter.md](transmitter.md)).
- Receiver: `PWM.__updatePlanesLayerListHandler` (`PWM:277-304`), dispatches `PLANES_LAYERLIST_UPDATE` (left view, right view, skill frame).
- When: op 15 (`op = 0`), after occupation, activation of a new layer, skill purchase (`op = 1`).

## 5. Rules and formulas

- Grid size from `PlanesLayers.Size` `"cols_rows"`: 8_8 (Secundário), 10_10 (Baixo, Médio), 12_12 (Grande), 3_3 hidden layers (`IconType` 7, `PWI:58`).
- Step energy on an unopened cell: `int((1500 + R) / (300 + R))`, R = `max(0, resistance[ResistType])` with ResistType 1 fire, 2 water, 3 electric, 4 wind, 5 dark, 6 light (`PMOD:379-393`).
- Event energy: `int(EnergyCost * (1500 + 3R) / (1500 + 4R))` (`PMOD:395-410`); `EnergyCost` is 0 or 100 in `PlanesEvents`.
- Layer skills (`PlanesFuncTempInfos.xml`): 101 Type 1 "elimina todos os obstáculos no mapa", 201 Type 2 "invoca o guardião oficial"; `NeedEnergy` 100, `NeedPoint` 100.
- `planes_scan` = `10,1` ("consume X energy to show X random event points") and strings "Pesquisar" exist but no client sender: not implemented in this build.
- Layer numbering `LayerNum`: 10, 11 (sub layers), 12 (hidden 3x3), 20, 30, ... The layer item key icon uses `IconType` (`PlanesWarLayerItem.as:89`).
- Click throttle 500 ms (`PCTL:67-73`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/PlanesLayers.xml` | 264 rows | `LayerTempId`, `PlanesTempId`, `LayerNum`, `LandType` (101..601, map folder), `ResistType` 1..6, `Size`, `EnemySkill` (skill shown and applied to monsters), `IconType` (7 hidden layer), `*ResiBonus`, `DailyRewards`, `ReducePoint` (200/250, meaning unknown) |
| `raw/xml/tempinfos/PlanesEvents.xml` | 107 events | `EventTempId`, `Name`, `Description`, `EnergyCost`, `NeedLevel` (all 0), `Icon`, `EventType`, `Rewards`, `Parameter` (see [events.md](events.md)) |
| `raw/xml/tempinfos/PlanesFuncTempInfos.xml` | 2 skills | `TemplateId`, `Type`, `NeedEnergy`, `NeedPoint`, `Icon`, `Desc` |

## 7. Persistent state

```sql
CREATE TABLE planes.layer (
  layer_id             BIGSERIAL   PRIMARY KEY,
  plane_id             BIGINT      NOT NULL REFERENCES planes.plane(plane_id) ON DELETE CASCADE,
  layer_template_id    INTEGER     NOT NULL,
  is_activated         BOOLEAN     NOT NULL DEFAULT false,
  occupier_player_id   INTEGER     REFERENCES player.players(player_id) ON DELETE SET NULL,
  icon_state           SMALLINT    NOT NULL DEFAULT 0,
  bought_skills        INTEGER[]   NOT NULL DEFAULT '{}',
  map_stamp            INTEGER     NOT NULL DEFAULT 1,
  UNIQUE (plane_id, layer_template_id)
);

CREATE TABLE planes.cell (
  layer_id             BIGINT      NOT NULL REFERENCES planes.layer(layer_id) ON DELETE CASCADE,
  x                    SMALLINT    NOT NULL CHECK (x BETWEEN 0 AND 11),
  y                    SMALLINT    NOT NULL CHECK (y BETWEEN 0 AND 11),
  event_id             INTEGER     NOT NULL DEFAULT 0,
  opened               BOOLEAN     NOT NULL DEFAULT false,
  occupied             BOOLEAN     NOT NULL DEFAULT false,
  occupy_name          TEXT,
  event_state          JSONB       NOT NULL DEFAULT '{}',
  PRIMARY KEY (layer_id, x, y)
);

CREATE TABLE planes.session (
  player_id            INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  plane_id             BIGINT      NOT NULL REFERENCES planes.plane(plane_id) ON DELETE CASCADE,
  layer_id             BIGINT      NOT NULL REFERENCES planes.layer(layer_id) ON DELETE CASCADE,
  pos_x                SMALLINT    NOT NULL,
  pos_y                SMALLINT    NOT NULL,
  is_dead              BOOLEAN     NOT NULL DEFAULT false,
  entered_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

`event_state` holds per cell runtime data (market purchases, card draw, monster defeated). `planes.player_state` (energy, keys, revives) is in [transmitter.md](transmitter.md).

## 8. Backend implementation notes

- Layer generation (on plane creation): for each `PlanesLayers` row of the plane create `layer` and fill `cell` with a generated layout: entry base 3, walls of the layer element (101..106), monsters (EventType 2) of the plane size, boss, patrol, chests, market, mines, portals 61/62 to the next and previous layer, guardian 14001 (EventType 14) and castle (EventType 12). No layout data exists in the client: the generator is an assumption; keep layouts deterministic per layer seed.
- `planes::exploration::handle_teleport` (op 15): plane owned, life > 0, building power >= 10 (deduct); upsert `session` at the entry base of the lowest activated layer (or last position, assumption); reply 4981 op 0, 4943 full, 4942 op 15.
- `planes::exploration::handle_move` (op 2): 4 params -> step; 2 params -> trigger `planes::events::handle_trigger`. Transaction per step: energy update, cell open, session position.
- `planes::exploration::handle_layer_teleport` (op 36), `planes::exploration::handle_buy_skill` (op 3), `planes::exploration::handle_buy_energy` (op 8, shared with op 20), `planes::exploration::handle_leave` (op 19: delete `session`, reply 4942 op 19).
- On disconnect keep `session` so the player re-enters at the same cell (assumption).
- Battle exit: the battle result for 3843 returns the client to `PLANES_WAR_SCENE` when `isInPlanesWar`; after the battle push 4943 (cell cleared) and 4942 (energy, keys, dead).

## 9. Open questions and assumptions

- Cell layouts per layer, fog reveal radius and entry position are not in client data.
- Whether moving costs energy only on unopened cells (assumed from the "explorar área desconhecida" text).
- Server behavior on rejected steps (assumed op 24 restore).
- `ReducePoint` column meaning (200/250).
- `planes_scan` search feature has strings but no sender.

## 10. Implementation checklist

- [ ] Screen: `PlanesWarSceneView`, grid, fog, minimap, top/left/right views
- [ ] Screen: layer map frame and skill frame
- [ ] Route R1 op 15 teleport (4981, 4943, 4942 order)
- [ ] Route R2 op 2 step with energy formula
- [ ] Route R3 op 2 trigger
- [ ] Route R4 op 36 layer teleport
- [ ] Route R5 op 3 layer skills 101/201
- [ ] Route R6 op 8 buy energy
- [ ] Route R7 op 19 leave
- [ ] Route R8 op 24 restore position
- [ ] Server message 4942 partial fields
- [ ] Server message 4943 stamp semantics
- [ ] Server message 4981 op 0 / op 1
- [ ] Tables `planes.layer`, `planes.cell`, `planes.session`
- [ ] Layer layout generator
- [ ] Test: step onto a wall refused; step cost with resistance 0 is 5
- [ ] Test: stale 4943 stamp ignored by client
