# MVP shop (MVP geral)

Path aliases:

| Alias | File |
|---|---|
| MVM | `decompiled/core_module/scripts/managers/MvpShopManager.as` |
| MVMOD | `decompiled/core_module/scripts/mvc/module/mvpshop/MvpShopModel.as` |
| MVF | `decompiled/m11/scripts/mvpshop/MvpShopFrame.as` |
| MVGI | `decompiled/m11/scripts/mvpshop/MvpShopGoodsItem.as` |
| TOP | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TOPC | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

Timed event shop where "moedas MVP" (MVP coins, `mymvppoint`) buy 6 random personal offers; 8 showcase items preview the pool. The list refreshes automatically every `mvp_shop_random_time` seconds or manually for diamonds. At the end of the event the remaining MVP coins are returned as bound diamonds at `mvp_shop_reward_scale`:1 ("Ao fim do evento, as moedas MVP e os diamantes vinculados serão devolvidos ao jogador na proporção de {0}:1.", `MvpShopFrame.descTxt.txt`).

Entry: top bar button `mvpshop` (`docs/ui/navigation.md:299`), visible when `VersionSwitch.MVP_SHOP && MvpShopModel.isOpen` (`TOPC:379-380`), tooltip with start and end (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnItemView.as:594-597`), glows when the shop opens or the coin balance grows (`TOP:981-997`). Click opens controller `mvpshop` (`TOP:1447-1448`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mvpshop.MvpShopFrame` 790x615 | "MVP geral" (`MVF:91`) | 6 buy slots (`MVF:128-163`), 8 showcase cells, coin balance, event dates `begin - end`, refresh price, "Tempo até a atualização" countdown `nexttime - now` (`MVF:263-271`), quick refresh button | top bar | 4888 |
| `mvpshop.MvpShopGoodsItem` | | Slot: icon, count, price in MVP coins, rare stamp, buy button disabled when bought (`MVGI:132-165`) | frame | `myitems[]` |

The frame closes itself when a 4888 arrives with `isopen = false` (`MVF:252-261`).

## 3. Routes (client to server)

All routes: send 9678 (0x25ce) `C_MVP_SHOP_OP`, message `com.road.yishi.proto.simple.PropertyMsg` (`param1` (#1, INT32) .. `param3` (#3, INT32), `param4..6` (#4..#6, STRING), `param7..9` (#7..#9, BOOL), `param10..11` (#10..#11, INT32), `param12` (#12, STRING); note `protocol/proto.json` lists the army `PropertyMsg` under the same name). Sender `MvpShopManager.sendRequest(op, param2 = 0)` (`MVM:126-133`), constants `BUY = 1`, `REFRESH = 2` (`MVM:21-23`).

| # | `param1` | UI | `param2` | Client checks | Response |
|---|---|---|---|---|---|
| R1 | 1 buy | slot buy (`MVGI:99-130`) | offer `id` | coins >= price else "Moedas MVP insuficientes"; confirm "Deseja trocar {0} moedas MVP por {1}*{2}?" | 4888 |
| R2 | 2 refresh | quick refresh (`MVF:180-245`) | 0 | unbought rare slot -> confirm "Ainda há itens especiais que não foram trocados deseja atualizar?"; daily "do not ask" confirm "Deseja gastar {0} diamantes para resetar os itens agora?"; `point >= mvp_shop_random_consume` (diamonds only) else recharge | 4888 |

## 4. Server messages (server to client)

### S1. 4888 (0x1318) `U_C_MVP_SHOP_INFO`

- `com.road.yishi.proto.active.MvpShopMsg`: `id` (#1, STRING) event id; `begin` (#2, STRING); `end` (#3, STRING); `isopen` (#4, BOOL); `showitems` (#5, repeated `MvpShopItemInfoMsg`) showcase (first 8 shown); `myitems` (#6, repeated `MvpShopItemInfoMsg`) the 6 personal slots; `mymvppoint` (#7, INT32) coin balance; `nexttime` (#8, INT64) next automatic refresh in milliseconds since epoch.
- `MvpShopItemInfoMsg`: `id` (#1, INT32) offer id; `itemId` (#2, INT32) template; `itemCount` (#3, INT32); `price` (#4, INT32) coins; `isBuy` (#5, BOOL); `isRare` (#6, BOOL).
- Receiver: `MvpShopManager.__updateMvpShopInfoMsg` (`MVM:60-124`): optional fields only applied when present (`hasIsopen`, `hasBegin`, `hasEnd`, `hasMymvppoint`); `openChange` when it goes from closed to open; coin increase notifies `MVPSHOP_POINT_CHANGE`; lists rebuilt; notifies `MVPSHOP_INFO_CHANGE`.
- When: login push, event start and end, reply to R1 and R2, at each automatic refresh, and when MVP coins are earned.

## 5. Rules and formulas

Config (`raw/xml/tempinfos/ConfigInfos.xml`):

| Key | Value | Meaning |
|---|---|---|
| `mvp_shop_random_consume` | 20 | diamonds per manual refresh (client default 100 when missing, `MVF:323-332`) |
| `mvp_shop_random_time` | 14400 | automatic refresh interval in seconds |
| `mvp_shop_reward_scale` | 5 | MVP coins per bound diamond returned at event end, rounded up (client default 2, `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1126-1133`) |

- Each slot can be bought once per list; price in MVP coins.
- Manual refresh: diamonds only, no daily cap in client data.
- Event end conversion: bound diamonds = `ceil(coins / 5)` ("向上取整" in the config description), coins set to 0.
- MVP coin source: not in this module's client code (assumption: rewards of an MVP ranking or event owned by [../seasonal-events/README.md](../seasonal-events/README.md)).

## 6. Templates

Only the config keys above. Offer pool, prices and rarity are server configuration.

## 7. Persistent state

```sql
CREATE TABLE shops.mvp_shop_event (
  event_id   TEXT        PRIMARY KEY,
  begin_at   TIMESTAMPTZ NOT NULL,
  end_at     TIMESTAMPTZ NOT NULL,
  settled    BOOLEAN     NOT NULL DEFAULT false
);

CREATE TABLE shops.mvp_shop_pool_item (
  event_id         TEXT    NOT NULL REFERENCES shops.mvp_shop_event(event_id) ON DELETE CASCADE,
  pool_item_id     INTEGER NOT NULL,
  item_template_id INTEGER NOT NULL,
  item_count       INTEGER NOT NULL,
  price            INTEGER NOT NULL CHECK (price > 0),
  is_rare          BOOLEAN NOT NULL DEFAULT false,
  weight           INTEGER NOT NULL CHECK (weight > 0),
  is_showcase      BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (event_id, pool_item_id)
);

CREATE TABLE shops.mvp_shop_player (
  event_id        TEXT        NOT NULL REFERENCES shops.mvp_shop_event(event_id) ON DELETE CASCADE,
  player_id       INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  coins           INTEGER     NOT NULL DEFAULT 0 CHECK (coins >= 0),
  next_refresh_at TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE shops.mvp_shop_slot (
  event_id      TEXT     NOT NULL,
  player_id     INTEGER  NOT NULL,
  slot_index    SMALLINT NOT NULL CHECK (slot_index BETWEEN 0 AND 5),
  pool_item_id  INTEGER  NOT NULL,
  is_bought     BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (event_id, player_id, slot_index),
  FOREIGN KEY (event_id, player_id) REFERENCES shops.mvp_shop_player(event_id, player_id) ON DELETE CASCADE
);
```

## 8. Backend implementation notes

- `shops::mvp_shop::handle_op` (9678) dispatching on `param1`:
  - `handle_buy` (1): event open; slot with `pool_item_id == param2` (the client sends the offer `id`) not bought; coins >= price; debit coins, grant item, mark bought; reply 4888.
  - `handle_refresh` (2): debit 20 diamonds (unbound); reroll 6 slots by weight (rare flag carried); reset `next_refresh_at = now + 14400 s`; reply 4888.
- Lazy automatic refresh on any access when `now >= next_refresh_at`.
- `shops::mvp_shop::grant_coins(player, n)`: called by the coin source; push 4888 with `mymvppoint`.
- Settlement job at `end_at`: convert coins to bound diamonds (`ceil(coins / scale)`, by mail or direct), push 4888 `isopen = false`.

## 9. Open questions and assumptions

- Open: MVP coin source and amounts.
- Assumption: offer `id` in `myitems` is unique per slot (pool item id).

## 10. Implementation checklist

- [ ] Tables `shops.mvp_shop_event`, `shops.mvp_shop_pool_item`, `shops.mvp_shop_player`, `shops.mvp_shop_slot`
- [ ] Route 9678 ops 1, 2 and encoder 4888
- [ ] Automatic refresh every 14400 s
- [ ] Event end settlement 5:1 to bound diamonds
- [ ] Tests: buy without coins, refresh with rare left, settlement rounding
