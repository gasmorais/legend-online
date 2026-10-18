# Construction queue (legacy)

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| SFB | `decompiled/m4/scripts/buildings/seminary/view/SeminaryFrameBottomView.as` |

## 1. Overview

The client still carries the original construction queue ("Fila de estrutura"): orders with `orderType = 1` in `BuildingModel.buildOrderList`, one free slot (`Castle_Order = 1`), a second slot bought for 100 diamonds (`Order_NeedPay`), at most 2 (`buildOrderLimit`, `BMOD:56`), and diamond speed ups at 1 diamond per 10 minutes (`Quick_Cool = 1,10`), free for VIP. In this build none of it is reachable:

- No handler for 4155 `U_C_LOAD_BUILD_ORDER`; the only `setOrderList` callers pass activity orders (`QBM:160`, `QBM:292`), so `buildOrderList` stays empty.
- `BM.checkBuildList` (`BM:312-333`) has no caller; `isUpgradeAvaliable` does not check the queue (`BM:367-386`).
- `QB.buyQueueItem` (`QB:483-492`) and `QB.coolItem` (`QB:576-607`) have no caller; `QB.refreshView` never creates build queue items (`QB:831-1008`).
- `BSOM.upgradeOrderList` (8279) has no caller; `SFB.allCoolBack` (`SFB:132-136`) has no caller.

Consequence: building upgrades are immediate ([buildings.md](buildings.md)). This module documents the protocol for completeness and proposes stubs.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mainBar.view.VipCoolDownFrame` | "Confirmar resfriamento", "Resfriamento precisa consumir {0}" | Speed up confirm | `QB.coolItem` (unreachable) | diamonds |
| SimpleAlert "Comprar fila" | "Consumir {0} diamantes para adicionar um fila de estrutura?" | Buy slot | `QB.buyQueueItem` (unreachable) | 100 diamonds |

Strings kept for the queue: "Fila de estrutura em espera", "Adicionar linha de construção", "Fila de estrutura cheia, clique para resfriar fila de estrutura", "Fila de estrutura cheia, habilite nova fila ou resfrie a fila de estrutura", "Fila inexistente".

## 3. Routes (client to server)

### R1. Load queue (dead)

- Sender `BSOM.upgradeOrderList` (`BSOM:34-38`), no caller.
- Route: C>S 8279 (0x2057) `C_LOAD_BUILD_ORDER`, empty body.
- Response: 4187 (S1). (4155 `U_C_LOAD_BUILD_ORDER` has no client listener.)

### R2. Speed up (dead)

- Sender `BM.allCoolBack(confirm, orderId, index, useBind)` (`BM:335-355`) > `BSOM.sendCoolOrder` (`BSOM:40-58`). Client checks: `orderId != 0` requires that order `remainTime > 0`; `orderId == 0` requires total cost `sum(ceil(remainTime / 600)) > 0` (`BM:357-365`). VIP: no confirm.
- Route: C>S 5172 (0x1434) `U_C_BUILDING_ORDER_QUICK`.
- Request `building.BuildingReqMsg`: `order_id (#1, INT32)` = order to speed up, 0 = all; `index (#3, INT32)` = 0, or when non zero rewritten to 2 (bound diamonds allowed) / 1 (real only); `position (#2)`, `user_id (#4)` unset.
- Response: 102 (S2).

### R3. Buy a queue slot (dead)

- Sender `QB.buyCallBack` (`QB:468-481`): requires `allPoint >= 100`; `pay_type = 1` when the bound checkbox is off, 0 when on.
- Route: C>S 5175 (0x1437) `U_C_BUILDING_ORDERADD`, `player.PayTypeMsg.pay_type (#1, INT32)`: 0 = bound diamonds allowed, 1 = real diamonds only (note: opposite convention to 5174).
- Response: 104 (S3), then 3.

## 4. Server messages (server to client)

`building.OrderInfoMsg`: `order_id (#1, INT32)`, `order_type (#2, INT32)` 1 = construction, 4 = activity; `remain_time (#3, INT32)` seconds; `user_id (#4, INT32)`; `begin_time (#5, STRING)`; `need_time (#6, INT32)`.

| Opcode | Message | Receiver | Effect |
|---|---|---|---|
| 4187 (0x105b) `U_C_BUILDING_ORDER_SEND` | `building.BuildOrderList { buildOrder (#1, OrderInfoMsg, repeated) }` | `BM.__loadBuildOrderHandler` (`BM:182-199`) | updates `remainTime` of known orders, dispatches `UPDATE_ORDER` |
| 102 (0x0066) `U_C_BUILDING_ORDER_QUICK` | `building.OrderQuickRspMsg { orderInfo (#1, OrderInfoMsg, repeated) }` | `BM.__orderCoolHandler` (`BM:201-229`) | unknown order id shows "Fila inexistente"; else updates `remainTime`, dispatches `COLL_ONE_ORDER` (Prefeitura tax view refresh, `decompiled/m4/scripts/buildings/politics/view/LevyView.as:81`) |
| 104 (0x0068) `U_C_BUILDING_ORDERADD` | `building.OrderInfoMsg` | `BM.__addOrderHandler` (`BM:231-242`) | appends a new order (type 1 to the build list, type 4 to the activity list), dispatches `ADD_ONE_ORDER` |
| 4155 (0x103b) `U_C_LOAD_BUILD_ORDER` | unknown | none | not handled |
| 151 (0x0097) `U_C_BUILDING_ORDER_INFO` | unknown | none | not handled |

## 5. Rules and formulas

- Slots: `Castle_Order = 1` initial, `buildOrderLimit = 2`, slot price `Order_NeedPay = 100` diamonds.
- Busy slot: `remainTime > 0`; `buildOrderCount` counts busy slots (`BM:169-180`).
- Speed up price: `ceil(remainTime / 600)` diamonds per order (`Quick_Cool = 1,10`), free with active VIP (`QB:592-605`).
- Duration source if the queue were used: next level `UpgradeTime` ([buildings.md](buildings.md)).

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Castle_Order = 1`, `Order_NeedPay = 100`, `Quick_Cool = 1,10` |

## 7. Persistent state

None required. If a future client revives the queue:

```sql
CREATE TABLE castle.build_orders (
    player_id    bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    order_id     smallint    NOT NULL CHECK (order_id BETWEEN 1 AND 2),
    building_id  integer     REFERENCES castle.buildings(building_id) ON DELETE SET NULL,
    began_at     timestamptz,
    ends_at      timestamptz,
    PRIMARY KEY (player_id, order_id)
);
```

## 8. Backend implementation notes

- `castle::build_queue::handle_load` (8279): reply 4187 with an empty list.
- `castle::build_queue::handle_speed_up` (5172): reply 102 with an empty list (client then does nothing).
- `castle::build_queue::handle_buy_slot` (5175): reject with the generic alert; do not charge.

## 9. Open questions and assumptions

- Assumption: the BR server completed upgrades instantly; nothing in the client can display a running construction.
- Open: payloads of 4155 and 151.

## 10. Implementation checklist

- [ ] Stubs for 8279, 5172, 5175.
- [ ] Confirm no client path sends them during a full play test (log unexpected opcodes).
