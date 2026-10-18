# Transmissor (castle teleporter)

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| TBF | `decompiled/m4/scripts/buildings/transferbuilding/view/TransferBuildFrame.as` |
| PLV | `decompiled/m4/scripts/buildings/transferbuilding/view/PlanesListView.as` |
| PIV | `decompiled/m4/scripts/buildings/transferbuilding/view/PlanesItemView.as` |
| PBF | `decompiled/m4/scripts/buildings/transferbuilding/view/planesbag/PlanesBagFrame.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| WMC | `decompiled/core_module/scripts/mvc/controler/WorldMapControler.as` |
| MPC | `decompiled/m3/scripts/map/outercity/view/mapphysics/MapPhysicsCastle.as` |
| PEI | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerEffectInfo.as` |
| BAM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |

## 1. Overview

The Transmissor ("Transmissor", SonType 1511, MasterType 8) is a client pseudo building with id -11 and template 151101, created from 4153 (`LIDA:840-844`). Its `property1` is the current energy ("Energia"), `property2` the remaining relocation cooldown. Energy (max 500) is spent to relocate the castle on the world map and to warp into planes; it resets daily at 0h and can be fully recharged with diamonds. The frame also hosts the planes list when the planes war is enabled ([../planes/README.md](../planes/README.md)).

Tooltip: "Consumindo energia, o transmissor pode transferir o castelo para qualquer zona e vilarejo; também pode transferir o Líder para qualquer ponto da zona." Clickable from Leader level 15 ([scene.md](scene.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `buildings.transferbuilding.view.TransferBuildFrame` (TBF) | "Transmissor" (`TBF:246-250`) | Energy bar, recharge button, world map button, description "Para usar o transmissor é necessário consumir energia, a energia é redefinida automaticamente todos os dias às 0h.", planes list (`TBF:85-134`) | Transmissor click; activity queue item 12 "Essência de planos" (`QB:324-327`) | `property1` / effective max (`TBF:233-239`) |
| `buildings.transferbuilding.view.PlanesListView` (PLV) | planes list | Planes, buy planes energy, sacrifice, planes bag, rewards | TBF when Leader >= 55 and `VersionSwitch.PLANES_WAR`, else a "not open" background (`TBF:101-119`) | owned by [../planes/README.md](../planes/README.md) |
| `buildings.transferbuilding.view.PlanesItemView` (PIV) | one plane | Warp ("transfer"), give up, add life | PLV | owned by planes |
| `buildings.transferbuilding.view.planesbag.PlanesBagFrame` (PBF) | "Bolsa dos Planos" | Bag items of SonType 606, use by double click (`sendUseItem`) | PLV | owned by planes and [../inventory/README.md](../inventory/README.md) |

## 3. Routes (client to server)

### R1. Recharge energy

- UI: `TBF._powerButton` (`TBF:139`, handler `TBF:152-170`), enabled only while energy != effective max (`TBF:238`).
- Client checks: `transport_charge_cost` (10) > 0; confirm "Essa ação irá energizar totalmente o transmissor e consumirá {0} diamantes!" with the bound diamond checkbox; without bound diamonds `cost > point` opens the recharge alert, with bound diamonds `cost > allPoint` opens it (`TBF:172-192`).
- Sender: `BSOM.sendAddTransferPower(payType)` (`BSOM:76-82`).
- Route: C>S 5174 (0x1436) `U_C_BUILDING_UPENERGY`.
- Request `player.PayTypeMsg`: `pay_type (#1, INT32)`: 1 = real diamonds only, 2 = bound diamonds first (default when the checkbox is set). `property1 (#2)`, `property2 (#3)`, `type (#4)` unset.
- Response: 103 (S1), then 3 `U_C_PLAYER_INFO` with `point` / `gift_token` ([../currency/README.md](../currency/README.md)).

### R2. Relocate the castle

UI owned by [../world-map/README.md](../world-map/README.md); the route and energy belong here.

- UI A: world map frame "Transferir" to another map (`WMC.sendMap`, `WMC:44-68`). Energy >= 200: sends directly with `pay_type 1`, position 0,0. Otherwise confirm "Energia insuficiente, para energizar transmissor consumirá {0} diamantes!" (cost `transport_charge_cost`) and send with `pay_type` 1 (real) or 2 (bound first) (`WMC:70-80`).
- UI B: world map node menu "Transferir" to a free position (`MPC:105-160`): energy >= 100 sends with `pay_type 1` and the node position; otherwise the same paid confirm.
- Sender: `PlayerManager.sendMoveCastle` (`PM:1703-1706`) > `SocketSendManager.sendMoveCastle` (`SSM:128-137`).
- Route: C>S 5176 (0x1438) `U_C_BUILDING_TRANSCASTLE`.
- Request `castle.CastleReqMsg`: `mag_id (#1, INT32)` = target map id (sic, map id); `pos_x (#2, INT32)`, `pos_y (#3, INT32)` = target position (0, 0 means "server picks a free spot", assumption); `pay_type (#6, INT32)`; `left_time (#4)`, `left_energy (#5)` unset.
- Response: 105 (S2); diamond payment also pushes 3. Failure: generic alert (assumed 111).

### R3. Clear relocation cooldown (legacy)

- Sender `BSOM.sendCoolTransferTime(payType)` (`BSOM:68-74`) has no caller.
- Route: C>S 5173 (0x1435) `U_C_BUIDLING_TRANS_COOL`, `player.PayTypeMsg.pay_type (#1)`.
- Response: 101 (0x0065) `U_C_BUIDLING_TRANS_COOL`, no client listener. Implement as no-op.

### R4. Planes operations (delegated)

From PLV / PIV the client sends 9527 (0x2537) `C_PLANES_WAR_REQ` with `planes.PlanesWarReqMsg { op (#1, INT32), param (#2, INT32, repeated), paramStr (#3, STRING, repeated) }`: op 1 on open (`TBF:104`), op 15 warp into a plane (requires Transmissor energy >= `planes_warp_energy` = 10, tip `planesItemView.transfer.alertTip`, `PIV:156-164`), op 17 add life with the plane item (`PIV:172-218`), op 18 give up (`PIV:166-171`), op 20 buy planes energy (`PLV:209-269`, limits `planes_buy_energy_limit = 5`, cost `planes_buy_energy = 30,100`). Rules, responses and tables: [../planes/README.md](../planes/README.md). The sacrifice button opens `"sacrifice"` ([../sacrifice/README.md](../sacrifice/README.md)). Assumption: warp (op 15) spends Transmissor energy and the planes server must push 103 or 4202 style energy updates through this module API.

## 4. Server messages (server to client)

### S1. 103 (0x0067) `U_C_BUILDING_UPENERGY`

Message `building.TransInfoMsg`. Receiver `BM.__transerAddPowerHandler` (`BM:244-253`): sets building -11 `property1 = current_energy`, dispatches `TRANSFER_POWER_SUCCESS` (TBF refresh, `TBF:200-203`).

| Field | Tag, type | Meaning |
|---|---|---|
| `current_energy` | #1 INT32 | energy after the operation |
| `remain_time` | #2 INT32 | relocation cooldown seconds (not read) |

When: response to 5174; push whenever energy changes outside a relocation (planes warp, daily reset if the player is online, assumption).

### S2. 105 (0x0069) `U_C_BUILDING_TRANSCASTLE`

Message `castle.CastleReqMsg`. Receiver `PM.__transferCastleHandler` (`PM:1850-1872`): updates the castle node `mapId`, `posX`, `posY`; building -11 `property1 = left_energy`, `property2 = left_time`; Leader >= 13 queues `TransferOuterCityAction`, else switches to `OUTER_CITY_SCENE`; dispatches `TRANSEFER_CASTLE_SUCCESS` (quest trackers `decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:263`, world map mediator).

| Field | Tag, type | Meaning |
|---|---|---|
| `mag_id` | #1 INT32 | new map id |
| `pos_x`, `pos_y` | #2, #3 INT32 | new position |
| `left_time` | #4 INT32 | relocation cooldown seconds |
| `left_energy` | #5 INT32 | energy left |
| `pay_type` | #6 INT32 | echo, not read |

### S3. 4159 (0x103f) `U_C_TRASNBUILDING_RESULT`

Same message. Receiver `PM.__transferResultHandler` (`PM:1250-1260`): updates `property1 = left_energy`, `property2 = left_time`, dispatches `TRANSEFER_ARMY_SUCCESS` (no listener). When: after a hero (army) teleport on the world map that spends Transmissor energy; the request is owned by [../world-map/README.md](../world-map/README.md) (assumption, sender not found in the castle code).

### S4. Login and daily reset

- 4153 `BaseCastleMsg.left_energy (#13)` initializes energy ([buildings.md](buildings.md) S1).
- 4202 (0x106a) `U_C_DATARESET`, `player.DataResetMsg.trans_energy (#3, INT32)` sets building -11 `property1` (`BAM:1874-1887`). 4202 is owned by the daily reset owner ([../hero/README.md](../hero/README.md)); this module supplies the value.

## 5. Rules and formulas

- Base max energy: template 151101 `Property2 = 500` ("Energia Máxima 500").
- Effective max: `Property2 * (1 + transferPowerLimitAdditionRace / 100) + transferPowerLimitAddition` (`PEI:124-127`), additions from player effects ([../hero/README.md](../hero/README.md)).
- Recharge: costs `transport_charge_cost` = 10 diamonds and sets energy to the effective max ("energizar totalmente").
- Relocation to another map needs 200 energy; to a position on the current map 100 energy (client thresholds `WMC:55`, `MPC:127`). Assumption: those amounts are consumed. With less energy the player can pay `transport_charge_cost` diamonds instead (energy unchanged, assumption).
- Daily reset at 0h: energy = effective max (description text; assumption that reset fills, not adds).
- Relocation cooldown: `left_time`; cool time additions exist in `PEI:129-132`. Open: base cooldown value.
- Planes warp needs energy >= `planes_warp_energy` = 10.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/BuildingTempInfos.xml` | 151101 | `Property2` = 500, `PosX 590`, `PosY 327`, `PicPath images/chuansong.swf`, `Activity "Energia Máxima 500"` |
| `raw/xml/tempinfos/ConfigInfos.xml` | | `transport_charge_cost = 10`, `planes_warp_energy = 10`, `planes_buy_energy = 30,100`, `planes_buy_energy_limit = 5` |

## 7. Persistent state

```sql
CREATE TABLE castle.transmitters (
    player_id          bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    energy             integer     NOT NULL DEFAULT 500 CHECK (energy >= 0),
    cooldown_until     timestamptz,
    reset_on           date        NOT NULL DEFAULT current_date
);
```

The castle position (`map_id`, `pos_x`, `pos_y`) is owned by world-map (castle node). Relocation updates it through the world-map API in the same transaction.

## 8. Backend implementation notes

- `castle::transmitter::handle_recharge` (5174): lazy daily reset; energy < effective max; `pay_type` 1 or 2; spend diamonds through the currency API (bound first when 2); set energy to max. After commit 103 then 3.
- `castle::transmitter::handle_move_castle` (5176): validate the target map exists and is allowed (world-map rules, "Não é possível transferir para essa zona"); pick a free position when 0,0; energy cost 200 (other map) or 100 (same map) else diamond payment; cooldown not active; update world-map node; set `cooldown_until`. After commit 105 (and 3 when paid); world-map broadcasts the node move to viewers of both maps.
- `castle::transmitter::handle_clear_cooldown` (5173): legacy no-op or clear cooldown for diamonds; reply 101 with an empty `PayTypeMsg` (assumption).
- API for other features: `spend_energy(tx, player, amount)`, `energy(player)`; planes uses it for op 15 and must push 103.
- Daily reset job at 0h: online players receive the value in 4202; offline players reset lazily.

## 9. Open questions and assumptions

- Assumption: 100 / 200 energy is consumed per relocation; diamonds replace energy when short.
- Assumption: daily reset fills energy to the effective max.
- Open: relocation cooldown length and whether it applies at all in this build.
- Open: which request produces 4159.

## 10. Implementation checklist

- [ ] Table `castle.transmitters`; energy in 4153 and 4202.
- [ ] `handle_recharge` (5174) with both pay types, 103 + 3.
- [ ] `handle_move_castle` (5176) with world-map integration, 105.
- [ ] `handle_clear_cooldown` (5173) stub, 101.
- [ ] Energy API used by planes (op 15) with 103 push.
- [ ] Test: 500 energy, move to another map leaves 300; move with 50 energy and `pay_type 2` spends 10 bound diamonds.
