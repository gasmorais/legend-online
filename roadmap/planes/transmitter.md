# Planes list in the Transmitter

Feature [planes](README.md), module `transmitter`. Aliases in [README.md](README.md).

## 1. Overview

- The "Transmissor" castle building frame (`TransferBuildFrame`, 820x555) shows, from hero level 55, the list of owned planes (max 5 rows, `PLV:292-304`), the owned/max count, the energy, the total daily income of occupied layers, and buttons "Adicionar Energia", "Informação de Planos de mina", "Sacrifício" and "Bolsa dos Planos".
- A plane is obtained by using a coordinates item (SonType 606, "Coordenações do Plano de fogo atual" .. "Coordenações do Plano de luz grande", `Property1` = `PlanesTempId`). The count is capped by `maxPlanesOwn` from the server (VIP dependent).
- Each row ("Plano", progress %, life %) has "Desistir do plano" (op 18), "Aumentar Vida" (op 17) and "Transmitir" (op 15, see [exploration.md](exploration.md)).
- Energy regenerates server side (`planes_recover_energy` = `30,50`: +50 every 30 minutes, up to `planes_max_recover_energy` = 1500) and can be bought (op 20 here, op 8 in the scene).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `TBF` (`TransferBuildFrame`) | "Transmissor" (building) | Building frame with power ("energia do transmissor") and the planes list | castle building SonType 1511, controller `transferbuilding` | building power `property1`, "not open" image when level < 55 or switch off (`TBF:101-119`) |
| `PLV` (`PlanesListView`) | tip "Ativar VIP e aumentar o Nv.VIP pode aumentar o número limite de Planos" | 5 plane rows, totals | inside `TBF` (`TBF:101-105`) | `planesInfoList.length + "/" + maxPlanesCount`, `energyLeft`, add energy tip "Clique para adicionar energia, pode comprar hoje: {0}" with `planes_buy_energy_limit - hasBuyEnergyCount` (`PLV:306-320`); total resistance bonuses and daily items of occupied layers (`PLV:321-395`); red badge on "Sacrifício" with remaining sacrifices (`PLV:140-166`) |
| `PIV` (`PlanesItemView`) | "Desistir do plano", "Aumentar Vida", transfer tip "Para transmitir é preciso consumir {0} energia" | One plane row | `PLV` | `PlanesName`, `planesProcess + "%"`, life `lifePoint / LifePoint * 100` with 2 decimals, decay tip "Todos os dias reduz {0}%, quando a quantidade de recurso atingir 0%, os planos irão desaparecer." with `lifeReduce / LifePoint` (`PIV:241-277`); income icon with `PlanesRewardTip` when the plane has occupied layers |
| `PBAG/PlanesBagFrame.as` | "Bolsa dos Planos" | Lists bag items of SonType 606 only, 6 per row, 30 slots minimum | "Bolsa dos Planos" button (`PLV:203-207`) | items from `GoodsManager.getGeneralBagGoodsBySonType(606)` sorted by template id desc (`PlanesBagFrame.as:89-119`) |
| `PBAG/PlanesGoodsItemMenu.as` | "Usar" | Use menu on click, double click uses directly | bag cell (`PlanesBagCellClickMediator.as:20-40`) | - |
| `decompiled/m16/scripts/yishi/view/tips/PlanesRewardTip.as` | "Ganhos da conquista de planos" | Tooltip with income per plane | income icons | output of `PMOD.getSinglePlanesRewardsById` |

## 3. Routes (client to server)

All requests: send 9527 (0x2537) `C_PLANES_WAR_REQ`, protobuf `PlanesWarReqMsg`: `op` (#1, INT32) action; `param` (#2, INT32, repeated) arguments; `paramStr` (#3, STRING, repeated) unused by every client sender. Sender `PWM.sendPlanesOpMsg(op, param, paramStr)` (`PWM:325-339`).

### R1. Planes list (op 1)

- UI: opening `TransferBuildFrame` when `VersionSwitch.PLANES_WAR && thane.grades >= 55` (`TBF:101-105`).
- Request: `op = 1`, no params.
- Response: 4941 `U_C_PLANES_WAR_LIST_MSG` with the full list.

### R2. Use a coordinates item (5006, shared route)

- UI: "Usar" in `PlanesGoodsItemMenu` (`PlanesGoodsItemMenu.as:48-56`) or double click (`PlanesBagCellClickMediator.as:33-40`); also any bag use of a SonType 606 item.
- Client check: `templateInfo.SonType == 606`.
- Request: 5006 `ItemUseMsg` `pos` (#1) bag position, `count` = 1, `bagType` = 1 (`SocketSendManager.as:157-167`).
- Server (owner of item use, [inventory](../inventory/README.md)) for SonType 606: check `owned_planes < max_planes_own`; create a plane of template `Property1`, full life `LifePoint`, all layers generated, layer with `LayerNum` 10 active (assumption: first layer active, others locked); remove 1 item. Push bag update and 4941 (assumption, the client never asks again while the frame is open).
- Error (assumption): plane cap reached -> generic tip, item kept.

### R3. Give up a plane (op 18)

- UI: `giveupBtn` "Desistir do plano" (`PIV:135-154`).
- Client checks: if the account has a secondary password and it is not confirmed this session, opens `vicepassword` (type 3) instead (`PIV:141-144`); confirm "Coordenadas Raras do plano, tem a certeza que deseja abandonar este plano?".
- Request: `op = 18`, `param = [planesId]` (`PIV:166-172`).
- Response: 4941 with the list without the plane (assumption). 4942 `op = 18` is not handled specially (`PWM:59-73`).

### R4. Add plane life (op 17)

- UI: `addLifeBtn` "Aumentar Vida" (`PIV:174-193`). Uses `PlanesTemplates.AddLifeItem` (2131060..2131063 "Essência do Plano ...", `Property1 = 20`).
- Client check: daily confirmation "Deseja consumir 1 {0} para aumentar este plano para recurso de {1}%?" (once per day, `SharedManager.planesBuyLifeAlertDate`, `PIV:195-218`). The client does not check the item count; the string "A sua mochila não tem Defesa Sagrada, não é possível aumentar o plano de vida" exists for the server error (assumption).
- Request: `op = 17`, `param = [planesId, addLifeItemTempId]`.
- Response: bag update (item -1) and 4941 with the new `life_point`. Life gain: `planes_item_add_life_percent` = 5 percent of `LifePoint` per item (config) while the item text says 20 percent; use the config value (assumption).

### R5. Buy energy from the list (op 20)

- UI: `addEnergyBtn` (`PLV:209-236`).
- Client checks: `hasBuyEnergyCount > planes_buy_energy_limit` -> "O limite de compra de Energia de hoje já atingiu o limite" (note: strictly greater, so the client lets the 6th try through; the server must cap at 5); `allPoint < 30` -> recharge dialog; daily confirm "Deseja consumir {0} diamantes para comprar {1} pontos de energia？" with a "use bound diamonds" checkbox (`PLV:238-269`).
- Request: `op = 20`, `param = [payType]`, payType 1 = diamonds, 2 = bound diamonds first.
- Response: 4942 with `energy_left` and `buy_energy_count` (fields #2, #3) and then a 4941 refresh (assumption, the list text only refreshes on 4941 `PLANES_INFO_UPDATE`); player info push with the new balance.

### R6. Energy regeneration poll (op 32)

- Trigger: `PMOD.remainTime` countdown reaches 0 (`PMOD:464-496`), set by the last 4944.
- Request: `op = 32`.
- Response: 4944 with the current energy and the seconds until the next regen tick.

## 4. Server messages (server to client)

### 4941 (0x134d) `U_C_PLANES_WAR_LIST_MSG`

- Message `PlanesWarListMsg`: `op` (#1, INT32) unused by client; `max_planes_own` (#2, INT32) plane cap; `energy_left` (#3, INT32); `buy_energy_count` (#4, INT32) energy purchases today; `planesList` (#5, MESSAGE `PlanesInfoMsg`, repeated).
- `PlanesInfoMsg`: `planes_id` (#1, INT32) instance id; `planes_temp_id` (#2, INT32) `PlanesTempId`; `planes_process` (#3, INT32) exploration progress percent; `life_point` (#4, INT32) current life; `layerList` (#5, MESSAGE `PlanesLayerInfoMsg`, repeated); `life_reduce` (#6, INT32) daily life loss.
- `PlanesLayerInfoMsg`: `layer_id` (#1, INT32) instance id; `layer_temp_id` (#2, INT32) `LayerTempId`; `occupy_userid` (#3, INT32) occupier user id (0 none); `isActivated` (#4, BOOL) reachable; `icon_state` (#5, INT32) key icon shown when <= 0; `buyList` (#6, INT32, repeated) layer skills already bought (`PlanesFuncTempInfo.TemplateId`).
- Receiver: `PWM.__getPlanesListHandler` (`PWM:85-122`): rebuilds `planesInfoList` sorted by id, layers sorted by `LayerNum`; dispatches `PLANES_INFO_UPDATE` and `UPDATE_QUEUE_ENERGY`.
- When: reply to op 1; after ops 17, 18, 20 and after plane creation (assumption).

### 4944 (0x1350) `U_C_PLANES_WAR_ENERGY`

- Message `PlanesEnergyMsg`: `energy` (#1, INT32) current energy; `countDown` (#2, INT64) milliseconds to the next regen tick.
- Receiver: `PWM.__updateQueueEnergyHandler` (`PWM:267-275`): sets `energyLeft`, `remainTime = countDown / 1000`, starts the 1 s timer, refreshes the queue bar.
- When: reply to op 32; at login (assumption, the queue bar needs it); after every regen tick for online players (assumption). Send `countDown = 0` when energy is at the regen cap so the client stops polling.

### 4942 for op 20

See [exploration.md](exploration.md) for the full `PlanesWarRspMsg`. For op 20 the fields read are `energy_left` (#2) and `buy_energy_count` (#3) (`PWM:193-202`).

## 5. Rules and formulas

- Unlock: hero level 55 and `VersionSwitch.PLANES_WAR` (`TBF:101`).
- Plane templates (`PlanesTemplates.xml`, 24 rows): ids `S*10 + E`, size S = 1 "Secundário" (5 layers, life 1600), 2 "Baixo" (11, 3600), 3 "Médio" (11, 11250), 4 "Grande" (17, 17500); element E = 1 fire, 2 water, 3 shock, 4 wind, 5 dark, 6 light.
- Energy: max regen 1500, +50 per 30 min (`planes_recover_energy`), `planes_energy_item_limit` = 10 (energy recovery item uses per day, assumption); purchase `planes_buy_energy` = `30,100` (30 diamonds for 100 energy), `planes_buy_energy_limit` = 5 per day. Bought energy may exceed 1500 (assumption: only regen is capped).
- Life: decays `life_reduce` per day; occupied planes vs unoccupied: `planes_unoccupy_life_reduce` = 50 (extra life loss per day for a plane without occupation, assumption on meaning). At 0 the plane is deleted.
- Teleport needs building power >= `planes_warp_energy` = 10 (`PIV:158`) and the server deducts it (assumption).
- `planes_pvp_life_percent` = 80 ("可发生PVP的位面寿命下限"): PvP invasion of other players' planes, not present in this client (no invade UI besides an unused `invadeImage` asset).
- Income per plane (`PMOD.getSinglePlanesRewardsById`, `PMOD:186-259`): for each layer occupied by the player, sum the 7 `*ResiBonus` columns (keys 1..7) and the `DailyRewards` items (`itemId,count|...`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/PlanesTemplates.xml` | 24 planes | `PlanesTempId`, `PlanesName`, `TotalLayer` (5, 11, 17), `LifePoint`, `AddLifeItem` |
| `raw/xml/tempinfos/PlanesLayers.xml` | 264 layers | `LayerTempId` (= PlanesTempId*1000 + LayerNum), `PlanesTempId`, `LayerNum`, `DailyRewards`, `*ResiBonus` (see [resources.md](resources.md)) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | SonType 606 items 2131073..2131096 | `Property1` = plane template; SonType 208 essences 2131060..2131063 (`Property1` 20, `Property2` size) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `planes_buy_energy`, `planes_buy_energy_limit`, `planes_recover_energy`, `planes_max_recover_energy`, `planes_energy_item_limit`, `planes_warp_energy`, `planes_item_add_life_percent`, `planes_unoccupy_life_reduce`, `planes_pvp_life_percent`, `transport_charge_cost` (10, building power purchase) | see section 5 |

## 7. Persistent state

Schema `planes`.

```sql
CREATE TABLE planes.player_state (
  player_id            INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  energy               INTEGER     NOT NULL DEFAULT 1500 CHECK (energy >= 0),
  energy_updated_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  energy_buy_count     SMALLINT    NOT NULL DEFAULT 0 CHECK (energy_buy_count BETWEEN 0 AND 5),
  revive_left          SMALLINT    NOT NULL DEFAULT 1 CHECK (revive_left BETWEEN 0 AND 10),
  gold_keys            INTEGER     NOT NULL DEFAULT 0 CHECK (gold_keys >= 0),
  silver_keys          INTEGER     NOT NULL DEFAULT 0 CHECK (silver_keys >= 0),
  day                  DATE        NOT NULL
);

CREATE TABLE planes.plane (
  plane_id             BIGSERIAL   PRIMARY KEY,
  player_id            INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  plane_template_id    INTEGER     NOT NULL,
  life_point           INTEGER     NOT NULL CHECK (life_point >= 0),
  progress_percent     SMALLINT    NOT NULL DEFAULT 0 CHECK (progress_percent BETWEEN 0 AND 100),
  created_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX plane_player_idx ON planes.plane (player_id);
```

`plane.plane_id` is sent as `planes_id`. Layers, cells and mines are in [exploration.md](exploration.md) and [resources.md](resources.md).

## 8. Backend implementation notes

- `planes::transmitter::handle_request` is the single 9527 entry and dispatches by `op` to the handlers of all modules.
- `planes::transmitter::handle_list` (op 1): lazily roll the daily row (reset `energy_buy_count`), apply energy regen (`floor(elapsed / 30 min) * 50` up to 1500), reply 4941.
- `planes::transmitter::handle_use_coordinates` (called by the item use service for SonType 606): validate cap, insert `plane` and its `layer` rows from `PlanesLayers` (all with `is_activated = false` except the lowest `LayerNum`), in one transaction with the item removal.
- `planes::transmitter::handle_give_up` (op 18): verify ownership; delete plane cascade (layers, cells, mines); if the player is inside it, also send op 19 behavior (scene exit). Push 4941.
- `planes::transmitter::handle_add_life` (op 17): validate item template equals the plane `AddLifeItem` and the player owns one; `life_point = min(LifePoint, life_point + LifePoint * 5 / 100)`; remove item; push bag and 4941.
- `planes::transmitter::handle_buy_energy` (op 20 and op 8): `energy_buy_count < 5`; spend 30 (bound first when payType 2) through the currency service; `energy += 100`; reply 4942 (`op` echo, `energy_left`, `buy_energy_count`) and 4941 when the request came from the list.
- `planes::transmitter::handle_energy_poll` (op 32): regen and reply 4944.
- Jobs: daily 00:00 reset of `energy_buy_count`; daily life decay `life_point -= life_reduce` (plus 50 when not occupied, assumption), delete planes at 0 and mail the player (assumption).

## 9. Open questions and assumptions

- How `max_planes_own` grows with VIP (no VIP prerogative row identified on the client).
- Exact life gain per essence (config 5 percent vs item text 20 percent).
- Meaning of `life_reduce` and `planes_unoccupy_life_reduce`; whether decay happens daily at 00:00.
- Whether op 1 should also be pushed after creation by item use.
- `planes_energy_item_limit` usage (no energy item flow in the client).
- `PlanesWarListMsg.op` is never read.

## 10. Implementation checklist

- [ ] Screen: `TransferBuildFrame` planes list (level 55 gate)
- [ ] Screen: `PlanesItemView` rows, life and progress
- [ ] Screen: `PlanesBagFrame` and use menu
- [ ] Route R1 op 1 -> 4941
- [ ] Route R2 item use SonType 606 creates a plane
- [ ] Route R3 op 18 give up
- [ ] Route R4 op 17 add life
- [ ] Route R5 op 20 buy energy (cap 5, 30 diamonds, payType)
- [ ] Route R6 op 32 -> 4944
- [ ] Server message 4941 `PlanesWarListMsg`
- [ ] Server message 4944 `PlanesEnergyMsg`
- [ ] Table `planes.player_state`
- [ ] Table `planes.plane`
- [ ] Rule: energy regen +50 / 30 min up to 1500
- [ ] Job: daily reset and life decay
- [ ] Test: buying energy a 6th time is refused
- [ ] Test: plane cap blocks item use
