# Customized VIP pack ("Pacote personalizado VIP")

Path aliases:

| Alias | File |
|---|---|
| CVM | `decompiled/core_module/scripts/managers/CustomizedVipManager.as` |
| CVMOD | `decompiled/core_module/scripts/mvc/module/customizedvip/CustomizedVipModel.as` |
| CVB | `decompiled/core_module/scripts/mvc/module/customizedvip/CustomizedVipBoxInfo.as` |
| CVC | `decompiled/core_module/scripts/mvc/controler/CustomizedVipControl.as` |
| MAIN | `decompiled/m11/scripts/customizedvip/CustomizedVipMainFrame.as` |
| CUST | `decompiled/m11/scripts/customizedvip/CustomizedVipFrame.as` |
| BUY | `decompiled/m11/scripts/customizedvip/CustomizedVipBuyFrame.as` |
| RIGHT | `decompiled/m11/scripts/customizedvip/CustomizedVipRightItem.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed activity (top toolbar template 2064 "VIP定制礼包"). VIPs (not temporary) get one free VIP box per day ("Coleta VIP diária gratuita") and may buy diamond boxes with a daily limit. Each box has several "areas"; the player customizes the box by choosing one item per area before buying. A `boxVersion` invalidates cached selections when the server changes the boxes.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `customizedvip.CustomizedVipMainFrame` (MAIN) | "Pacote personalizado VIP" (MAIN:326) | Free VIP box (left), list of buyable boxes (right), countdown "Contagem regressiva do evento: {0}", "Coleta VIP diária gratuita" | top toolbar "customizedvip" (`TopToolsBar.as:1488-1489`), visible when hero level > 1 and `model.isOpen` (TBH:405-406) | free box state: -1 not eligible (grey), 1 available (animated, clickable), 0 taken (open chest) (MAIN:183-268); tip lists the free box items (MAIN:199, 270-288); closes itself when the activity closes (MAIN:222-227) |
| `CustomizedVipRightItem` (RIGHT) | box card: price, "Limite de compra diário: {0}/{1} vezes", buttons customize and buy | One buyable box | MAIN list | sold out image when `leftCount <= 0` (RIGHT:147-160) |
| `customizedvip.CustomizedVipFrame` (CUST) | same title | Choose one item per area; confirm enabled when every area has a choice (CUST:221-232) | RIGHT customize button (`openControllerByInfo("customizedvip", "CUSTOMIZED_FRAME", box)`, RIGHT:117-120) | areas of `customizedItemDic` |
| `customizedvip.CustomizedVipBuyFrame` (BUY) | "campaign.TrailShop.BuyBtnTxt" | Quantity (1..leftCount) and total price | RIGHT buy button (RIGHT:122-130) | `price * count` (BUY:156-163) |

## 3. Routes (client to server)

All routes are send 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP` with header `extend1` = 41 (`new PackageOut(9645, 0, 41)`, CVM:144) and body `player.PlayerOpMsg`: `op` (#1, INT32) operation; `type` (#2, INT32) box type; `count` (#4, INT32) quantity; `id` (#5, INT32) `boxVersion` known by the client; `param1` (#15, STRING) selection. Sender `CustomizedVipManager.sendCustomizedVipReq(op, type = 0, count = 1, param1 = "")` (CVM:142-152).

### C1. Load (op 0)
- UI: MAIN constructor (MAIN:73).
- Route: 9645 / extend1 41, `op` 0.
- Expected response: 4277 with `op` 0 and all boxes.

### C2. Take the free VIP box (op 1)
- UI: click on the free box when its state is 1 (MAIN:164-171). State 1 requires VIP, `vipType != 2` and `freeCount > 0` (MAIN:186-195).
- Route: 9645 / 41, `op` 1.
- Expected response: items to the bag, 4277 with `op` 1 and `freeCount` 0 (MAIN plays the open animation, MAIN:201-215).

### C3. Customize a box (client only)
- UI: CUST confirm (CUST:131-136) copies the selection into `model.clientBoxDic` (no request).

### C4. Buy boxes (op 2)
- UI: RIGHT buy (VIP and `vipType != 2` else "Só pode comprar após ativar o VIP", RIGHT:122-130) -> BUY confirm "Usar {0} diamantes para comprar {1} vezes?" (BUY:165-174).
- Client checks: `count <= leftCount` (BUY:109-163); `judgePointEnoughToShowPay(price * count, false)`: diamonds only (BUY:182-185).
- Route: 9645 / 41, `op` 2, `type` box type, `count` quantity, `id` boxVersion, `param1` = "area,templateId|area,templateId..." from `clientBoxDic` (BUY:190-203), empty when not customized.
- Expected response: 3 (`point`), items to the bag, 4277 with `op` 2 and updated `buyCounts` (MAIN refreshes the list, MAIN:216-219).

## 4. Server messages (server to client)

### S1. 4277 (0x10b5) `U_C_CUSTOMIZED_VIP_DATA`
- Message `CustomizedVipMsg` (cccactive): `op` (#1, INT32) echo of the request op; `freeCount` (#2, INT32) free VIP boxes left today; `buyCounts` (#3, STRING) "type,bought|type,bought" today; `boxs` (#4, `CustomizedVipBoxMsg`, repeated); `boxVersion` (#5, INT32).
- `CustomizedVipBoxMsg`: `type` (#1, INT32) 0 = free VIP box, > 0 buyable box; `price` (#2, INT32) diamonds per box; `maxCount` (#3, INT32) daily limit; `items` (#4, `CustomizedVipItemMsg`, repeated).
- `CustomizedVipItemMsg`: `templateId` (#1, INT32); `count` (#2, INT32); `area` (#3, INT32) choice group; `isBind` (#4, BOOL).
- Receiver: `CustomizedVipManager.__customizedVipInfoBack` (CVM:57, 61-125): sets `vipFreeCount` (resets the toolbar flicker), parses `buyCounts` (CVMOD:54-67), clears cached selections when `boxVersion` changed, rebuilds boxes (type 0 into `vipBoxRewardInfo`), groups items by area, notifies `CUSTOMIZED_INFO_CHANGE` with `op`.
- When: reply to every 9645 / 41 request; push at the daily reset to online players (assumption).

### S2. 4590 (0x11ee) `U_C_TOP_TOOL_BTN` with `param1` = 2064
- Message `simple.PropertyMsg`: `param1` (#1, INT32) 2064; `param4` (#4, STRING) start "YYYY-MM-DD hh:mm:ss"; `param5` (#5, STRING) end; `param7` (#7, BOOL) open; `param8` (#8, BOOL) flicker.
- Receiver: `CustomizedVipManager.__customizedVipTopBtnHandler` (CVM:58, 127-140) then `REFRESH_TOPTOOLS`.
- When: login and at activity start and end.

Errors (not VIP, limit reached, stale `boxVersion`, bad selection) are answered with 126 `U_C_MSG` plus a fresh 4277 (assumption).

## 5. Rules and formulas

- Free box: once per day while VIP and `vip_type != 2` (CVMOD:41-52, 85-95); content = all items of box type 0 (every area, MAIN:270-288).
- Buy: diamonds only, `price * count`; `count <= maxCount - bought_today` (CVB:23-30). Daily counters reset at 00:00 (assumption, "Limite de compra diário").
- Selection: exactly one item per area for every area of the box; when `param1` is empty the server uses the first item of each area (assumption). Reject a selection whose item is not in that area.
- Version: if `id != boxVersion` reply 4277 with the current version and refuse the purchase.
- Visibility: hero level > 1 and activity open (TBH:405-406). Toolbar flicker: `isFlicker` from 4590 or (VIP non temporary with `freeCount > 0`).

## 6. Templates

None in `raw/xml/tempinfos`: boxes, prices, limits and items are server data sent in 4277.

## 7. Persistent state

```sql
CREATE TABLE vip.customized_events (
  id            SERIAL      PRIMARY KEY,
  starts_at     TIMESTAMPTZ NOT NULL,
  ends_at       TIMESTAMPTZ NOT NULL,
  box_version   INTEGER     NOT NULL DEFAULT 1,
  CHECK (ends_at > starts_at)
);

CREATE TABLE vip.customized_boxes (
  event_id      INTEGER  NOT NULL REFERENCES vip.customized_events(id) ON DELETE CASCADE,
  box_type      INTEGER  NOT NULL CHECK (box_type >= 0),
  price         INTEGER  NOT NULL DEFAULT 0 CHECK (price >= 0),
  max_count     INTEGER  NOT NULL DEFAULT 1 CHECK (max_count >= 0),
  PRIMARY KEY (event_id, box_type)
);

CREATE TABLE vip.customized_box_items (
  event_id      INTEGER  NOT NULL,
  box_type      INTEGER  NOT NULL,
  area          INTEGER  NOT NULL,
  item_id       INTEGER  NOT NULL,
  count         INTEGER  NOT NULL CHECK (count > 0),
  is_bound      BOOLEAN  NOT NULL DEFAULT true,
  PRIMARY KEY (event_id, box_type, area, item_id),
  FOREIGN KEY (event_id, box_type) REFERENCES vip.customized_boxes(event_id, box_type) ON DELETE CASCADE
);

CREATE TABLE vip.customized_daily (
  player_id     BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_id      INTEGER  NOT NULL REFERENCES vip.customized_events(id) ON DELETE CASCADE,
  day           DATE     NOT NULL,
  free_taken    BOOLEAN  NOT NULL DEFAULT false,
  bought        JSONB    NOT NULL DEFAULT '{}',    -- {"<box_type>": count}
  PRIMARY KEY (player_id, event_id, day)
);
```

## 8. Backend implementation notes

- Dispatcher: `cccactive::dispatch` routes 9645 by header `extend1`; 41 -> `vip::customized::handle(op)`.
- `vip::customized::handle_load` (op 0): current event or refuse; build 4277 (`freeCount` = 1 when VIP non temporary and not taken today, else 0).
- `vip::customized::handle_take_free` (op 1): lock daily row; require VIP non temporary and not taken; grant all type 0 items; set taken; reply 4277 op 1.
- `vip::customized::handle_buy` (op 2): validate version, box, count, selection; lock daily row; check limit; `currency::spending::spend(Diamonds{price * count, pay_type 1, allow_bound false}, "vip.customized")`; grant `count` times the chosen items; update `bought`; reply 3, bag pushes, 4277 op 2.
- Activity scheduler: at `starts_at` and `ends_at` push 4590 `param1` 2064 to online players; at 00:00 push 4277 op 0 to online players with the frame state (assumption).

## 9. Open questions and assumptions

- Assumption: daily reset at 00:00 for both the free box and the buy counters.
- Assumption: default selection when `param1` is empty.
- Open: `isBind` handling: items from the free box bound, bought items unbound (assumption, client only displays).

## 10. Implementation checklist

- [ ] Screen: main frame free box states -1 / 0 / 1
- [ ] Screen: box list with daily limit and sold out
- [ ] Screen: customization requires one item per area
- [ ] Route C1 op 0
- [ ] Route C2 op 1
- [ ] Route C4 op 2 with selection string
- [ ] Server message S1 4277 with op echo and version
- [ ] Server message S2 4590 id 2064
- [ ] Table `vip.customized_events`
- [ ] Table `vip.customized_boxes`
- [ ] Table `vip.customized_box_items`
- [ ] Table `vip.customized_daily`
- [ ] Rule: VIP non temporary for free box and purchases
- [ ] Rule: diamonds only, daily limit
- [ ] Test: stale `boxVersion` refuses and resends 4277
- [ ] Test: buying 3 boxes with limit 2 is refused
