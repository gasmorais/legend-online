# Poço dos Desejos (wish pool, "许愿池")

Path aliases:

| Alias | File |
|---|---|
| WPM | `decompiled/core_module/scripts/managers/WishPoolManager.as` |
| WPMOD | `decompiled/core_module/scripts/mvc/module/wishpool/WishPoolModel.as` |
| WPF | `decompiled/m11/scripts/wishpool/WishPoolFrame.as` |
| WPI | `decompiled/m11/scripts/wishpool/WishPoolItemView.as` |
| WPSF | `decompiled/m15/scripts/view/subshop/WishPoolShopFrame.as` |
| WPSB | `decompiled/core_module/scripts/yishi/view/frame/WishPoolShopBuyFrame.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed event. The pool shows a set of wishes (items, some rare). The player selects up to 3 wishes and pays `wishOnePrice` diamonds per wish (or one "Moeda mágica" 208524 per wish when "Uso prioritário de {0}" is checked). A wish succeeds with a chance that depends on how many wishes were selected (`wish_pool_chances` 20, 25, 30 percent); success grants the selected items and rerolls the pool. The pool can be rerolled for `refreshPrice` diamonds or for free when the countdown ends. Wishing also gives points for the "Loja do Poço dos Desejos".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `wishpool.WishPoolFrame` (WPF), 980x675 | "Poço dos Desejos" (WPF:847) | Pool of `WishPoolItemView` (keys from `keys`); selection up to 3 ("Pode selecionar até 3 desejos", "(No máximo 3)"); wish cost; refresh cost; free refresh countdown; coin count and priority checkbox; reward list (rare first); success log; success and failure movies; shop button | Top toolbar `wishpool` (TopToolBtnInfos 2058 "许愿池") -> `openControllerByInfo("wishpool")` (TTB:1473-1475) | countdown to `endDate` or "Evento encerrado" (WPF:430-456); buttons disabled outside `startDate..endDate` (WPF:418-429, WPMOD:103-113) |
| `view.subshop.WishPoolShopFrame` (WPSF) | "Loja do Poço dos Desejos" | Points shop; "Os pontos do Poço dos Desejos serão zerados às {0}" | WPF shop button `openControllerByInfo("shop", 1019)` (WPF:612-615) | `leftScore`, goods with limits |
| `yishi.view.frame.WishPoolShopBuyFrame` (WPSB) | buy | Quantity `min(leftScore / price, limit - bought)` (WPSB:205-224) | WPSF | |

Toolbar visibility: `model.wishPoolIsOpen` (TBH:391-392).

## 3. Routes (client to server)

All routes: C>S 9645 (0x25ad), header `extend1 = 36`, body `active.WishPoolReqMsg`: `optype` (#1, INT32); `goodKey` (#2, INT32); `buyCount` (#3, INT32); `keys` (#4, INT32, repeated); `isUseProp` (#5, BOOL). Senders `WishPoolManager.frameOperation(optype, keys, isUseProp = false)` (WPM:239-247) and `wishPoolShopBuy(goodKey, buyCount)` (WPM:249-257). Optypes `OPENFRAME 1`, `REFRESH 2`, `WISH 3`, `OPEN_SHOP_FRAME 4`, `SHOP_BUY 5` (WPM:26-34).

| # | Action | UI | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| R1 | Open | WPF constructor (WPF:128) | none | `optype 1`, `keys []` | 196 type 1 (S2), 197 optype 1 (S3) |
| R2 | Refresh (paid) | refresh button (WPF:540-563) | 400 ms anti double click ("activity.view.ActivityItem.command01"); confirm "Deseja gastar {0} diamantes para renovar?" (mutable); `refreshPrice <= point` else recharge | `optype 2` | 197 optype 2, 3 |
| R3 | Refresh (free) | free refresh button, shown when the countdown reached 0 (WPF:565-574, 617-636) | none | `optype 2` | 197 optype 2 |
| R4 | Wish | wish button (WPF:576-610) | 1..3 keys selected (WPI:92-128); cost `wishNeed = (selected - coinsUsed) * wishOnePrice` where `coinsUsed = min(selected, bag count of 208524)` when the checkbox is on (WPF:638-669); if `wishNeed > 0` confirm "Deseja gastar {0} diamantes para realizar desejo?" and `wishNeed <= point` | `optype 3`, `keys` selected, `isUseProp` checkbox | 197 optype 3, 115, 3 |
| R5 | Open shop | WPSF build (WPSF:69) | none | `optype 4` | 196 type 2 (goods), 197 optype 4 (`leftScore`) |
| R6 | Buy in shop | WPSB buy (WPSB:174) | `price * n <= leftScore`, `n <= limit - bought` | `optype 5`, `goodKey`, `buyCount` | 197 optype 5, 115 |

## 4. Server messages (server to client)

### S1. 4590 (0x11ee) `U_C_TOP_TOOL_BTN`
- `PropertyMsg` (package `simple`): `param1` (#1, INT32) TopToolBtnInfo id, 2058 for the wish pool; `param4` (#4, STRING) start; `param5` (#5, STRING) end "YYYY-MM-DD hh:mm:ss"; `param7` (#7, BOOL) open.
- Receiver: `WishPoolManager.__wishPoolBtnHandler` (WPM:195-207) when `param1 == 2058` -> `REFRESH_TOPTOOLS`. 4590 is a shared message read by 12 managers, each filtering its own id.
- When: login and event start or end.

### S2. 196 (0x00c4) `U_C_WISH_POOL_WINDOW_INFO`
- `active.WishPoolWindowMsg`: `type` (#1, INT32) 1 pool, 2 shop; `refreshPrice` (#2, INT32); `wishOnePrice` (#3, INT32); `sysCountDown` (#4, INT32) seconds until the free refresh; `keys` (#5, INT32, repeated) wishes in the pool now; `allWishes` (#6, `WishPoolItemInfo`, repeated) every possible wish; `goods` (#7, `WishPoolShopGoodInfo`, repeated) shop goods.
- `WishPoolItemInfo`: `key` (#1, INT32); `itemId` (#2, INT32); `count` (#3, INT32); `isRare` (#4, BOOL).
- `WishPoolShopGoodInfo`: `key` (#1, INT32); `itemId` (#2, INT32); `count` (#3, INT32); `price` (#4, INT32) points; `limitBuyCount` (#5, INT32); `curBuyCount` (#6, INT32).
- Receiver: `WishPoolManager.__wishPoolWindowInfoHandler` (WPM:70-108): type 1 fills prices, countdown, wish dictionary (rare first), pool keys sorted -> `WISH_POOL_WINDOW_INFO_UPDATE`; type 2 fills the shop -> `WISH_POOL_SHOP_SCORE_UPDATE`.
- When: type 1 reply to R1; type 2 reply to R5.

### S3. 197 (0x00c5) `U_C_WISH_POOL_RESP`
- `active.WishPoolRespMsg`: `optype` (#1, INT32) echo; `countDown` (#2, INT32); `wishResult` (#3, BOOL); `keys` (#4, INT32, repeated) new pool; `wishRewardTip` (#5, STRING) log line appended to the success panel (channel 111); `leftScore` (#6, INT32); `goodKey` (#7, INT32); `curBuyCount` (#8, INT32).
- Receiver: `WishPoolManager.__wishpoolRespHandler` (WPM:123-193): optype 1 countdown; optype 2 countdown (if present) and pool; optype 3 result, on success new pool and log line, `WISH_POOL_SUCCESS`, then `WISH_POOL_WISH` (success or failure movie, WPF:735-763); optype 4 and 5 score and bought count of `goodKey`.
- When: reply to every route.

## 5. Rules and formulas

- B1. Active window `startDate..endDate` from 4590; no level check.
- B2. Success chance by number of selected wishes: `wish_pool_chances = 20,25,30` percent for 1, 2, 3 wishes (`raw/xml/tempinfos/ConfigInfos.xml`). Assumption: on success the player receives every selected wish.
- B3. Cost per wish: `wishOnePrice` diamonds or 1 "Moeda mágica" (208524) when `isUseProp` (coins first). Diamonds only, no bound diamonds.
- B4. On success the pool is rerolled (`keys`), the selection cleared. On failure the pool stays and the cost is spent.
- B5. Refresh: `refreshPrice` diamonds anytime, free when `countDown` reached 0; refresh restarts the countdown.
- B6. Points: wishing adds shop points (assumption: per diamond or per wish); reset at the time shown by WPSF.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `wish_pool_chances` | 20,25,30 |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208524 "Moeda mágica" | wish coin |

Pool items, pool size, prices, countdown and shop goods are server data.

## 7. Persistent state

```sql
CREATE TABLE lotteries.wish_event (
  event_id        SERIAL      PRIMARY KEY,
  starts_at       TIMESTAMPTZ NOT NULL,
  ends_at         TIMESTAMPTZ NOT NULL,
  wish_price      INTEGER     NOT NULL,
  refresh_price   INTEGER     NOT NULL,
  free_refresh_s  INTEGER     NOT NULL,
  pool_size       SMALLINT    NOT NULL
);

CREATE TABLE lotteries.wish_item (
  event_id   INTEGER NOT NULL REFERENCES lotteries.wish_event(event_id) ON DELETE CASCADE,
  wish_key   INTEGER NOT NULL,
  item_id    INTEGER NOT NULL,
  item_count INTEGER NOT NULL,
  is_rare    BOOLEAN NOT NULL DEFAULT FALSE,
  weight     INTEGER NOT NULL DEFAULT 1,
  PRIMARY KEY (event_id, wish_key)
);

CREATE TABLE lotteries.wish_player (
  event_id         INTEGER     NOT NULL REFERENCES lotteries.wish_event(event_id) ON DELETE CASCADE,
  player_id        INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pool_keys        INTEGER[]   NOT NULL,
  free_refresh_at  TIMESTAMPTZ NOT NULL,
  score            INTEGER     NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE lotteries.wish_shop_good (
  event_id   INTEGER NOT NULL REFERENCES lotteries.wish_event(event_id) ON DELETE CASCADE,
  good_key   INTEGER NOT NULL,
  item_id    INTEGER NOT NULL,
  item_count INTEGER NOT NULL,
  price      INTEGER NOT NULL,
  buy_limit  INTEGER NOT NULL,
  PRIMARY KEY (event_id, good_key)
);

CREATE TABLE lotteries.wish_shop_purchase (
  event_id   INTEGER NOT NULL,
  player_id  INTEGER NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  good_key   INTEGER NOT NULL,
  bought     INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, player_id, good_key),
  FOREIGN KEY (event_id, good_key) REFERENCES lotteries.wish_shop_good(event_id, good_key) ON DELETE CASCADE
);

CREATE TABLE lotteries.wish_log (
  log_id     BIGSERIAL   PRIMARY KEY,
  event_id   INTEGER     NOT NULL REFERENCES lotteries.wish_event(event_id) ON DELETE CASCADE,
  player_id  INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  text       TEXT        NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- `extend1 = 36` -> `lotteries::wish::handle_op` on `optype`:
  - 1 `handle_open`: create player row (roll pool); reply 196 type 1, 197 optype 1 (`countDown = max(0, free_refresh_at - now)`).
  - 2 `handle_refresh`: if `now >= free_refresh_at` free, else debit `refresh_price`. Reroll, reset `free_refresh_at`. Reply 197 optype 2 (`keys`, `countDown`), 3.
  - 3 `handle_wish`: event open -> 1..3 distinct keys in the current pool -> payment (coins then diamonds) -> bag space. Transaction: debit, add score, roll success with `wish_pool_chances[n-1]`; on success grant items, reroll the pool, insert log. Reply 197 optype 3, 115, 3.
  - 4 `handle_shop_open`: reply 196 type 2 (goods with `curBuyCount`), 197 optype 4 (`leftScore`).
  - 5 `handle_shop_buy`: `buyCount > 0` -> limit -> score. Reply 197 optype 5 (`leftScore`, `goodKey`, `curBuyCount`), 115.
- Push 4590 (`param1 2058`) at login and on start or end.

## 9. Open questions and assumptions

- Assumption: all selected wishes are granted on success; failure grants nothing.
- Assumption: points earned per wish and the shop reset time.
- Open: whether the free refresh countdown is per player (assumption: yes).

## 10. Implementation checklist

- [ ] Screens `WishPoolFrame`, shop 1019 frames
- [ ] Route 9645/36 optype 1..5
- [ ] Messages 4590 (2058), 196 type 1 and 2, 197
- [ ] Tables `wish_event`, `wish_item`, `wish_player`, `wish_shop_good`, `wish_shop_purchase`, `wish_log`
- [ ] Rules B2 chances, B3 coin priority, B5 free refresh
- [ ] Test: 4 keys refused; key not in pool refused
