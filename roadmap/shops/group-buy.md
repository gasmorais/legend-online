# Group buy (Compra em grupo)

Cross server group purchase event shown inside the "funny" event frame ([../seasonal-events/README.md](../seasonal-events/README.md)). The offers are `MainDiscountInfo` type 3 pushed on 4238 ([timebuy.md](timebuy.md)); the protobuf `GrouponShopMsg` belongs to the `shop` package, so the purchase logic is documented here.

Path aliases:

| Alias | File |
|---|---|
| GBV | `decompiled/core_module/scripts/funny/groupbuy/GroupBuyView.as` |
| GBLI | `decompiled/core_module/scripts/funny/groupbuy/GroupBuyListItem.as` |
| GBPB | `decompiled/core_module/scripts/funny/groupbuy/GroupBuyProgressBar.as` |
| CV | `decompiled/core_module/scripts/funny/groupbuy/CheckView.as` |
| FF | `decompiled/core_module/scripts/funny/view/FunnyFrame.as` |
| SM | `decompiled/core_module/scripts/managers/ShopManager.as` |

## 1. Overview

Rules from the help text (`funny.groupbuy..helpGroupbuyContent`):
1. Inter server event split into a subscription period (until `endDate`) and a purchase (payment) period (until `sendDate`).
2. During subscription, each subscription pays a deposit (`frontMoney` diamonds). When the server wide subscription count reaches `level1`, `level2`, `level3`, the price drops to `price1`, `price2`, `price3`.
3. In the payment period the player settles: if the final price x subscribed units is below the deposits paid, the difference is refunded; if above, the player pays the difference.
4. Subscribers who do not settle get their deposits back as bound diamonds after the event.
5. Subscribing and settling grants one lucky draw ("Ao subscrever e comprar com sucesso, tem 1 chance de sortear.").

Entry: funny frame group buy button, shown when `ShopManager.getGroupBuyInfo()` returns offers whose `beginDate < now < sendDate` (`SM:1102-1130`, `FF:121-140`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `funny.groupbuy.GroupBuyListBar` / `GroupBuyListItem` | | List of group buy offers; selecting one requests its state (`GBLI:47-58,92-101`) | funny frame | offer names |
| `funny.groupbuy.GroupBuyView` | "Evento da compra de diamantes em grupo" (`funny.groupbuy.btngroupbuy`) | Item, old price struck, current price and discount, server wide subscriptions with tier progress bar (`GBPB:68-...`), "Compra: {0}" my subscriptions, total paid, countdown "Tempo restante de compra: {0}" / "Tempo restante de Pagamento: {0}" / "Pagamento encerrado", buttons subscribe ("rengou"), settle ("jiesuan"), lucky draw | list | `GrouponShopMsg` |
| `funny.groupbuy.ZuanshiView` | "Deseja consumir {0} diamantes para comprar este item?" | Deposit confirm | subscribe | `frontMoney` |
| `funny.groupbuy.CheckView` | | Settlement result: units, total paid, refund or extra (`CV:51-56`) | 4560 | |

## 3. Routes (client to server)

All routes: send 8645 (0x21c5) `C_GROUPON`, message `ShopMsg`: `pay_type` (#4, INT32) operation; `buyInfo` (#1): `good_id` (#2) offer id, `count` (#3).

| # | `pay_type` | UI | Fields | Client checks | Response |
|---|---|---|---|---|---|
| R1 | 3 info | select an offer (`GBLI:92-101`) | `good_id` | none | 4559 |
| R2 | 1 subscribe | subscribe button (`GBV:258-293`) | `good_id`, `count = 1` | server wide `curCount < maxCount` else "Quantidade de itens insuficientes"; my subscriptions `< oneDayCount` else "Compra limitada do item {0} vezes por dia"; `frontMoney <= point` (diamonds) else recharge; confirm deposit | 4559 |
| R3 | 2 settle | settle button (`GBV:384-450`) | `good_id` | `buyCount > 0` else "Você não subscreveu durante o período de subscrição, não pode efetuar compra."; not settled else "Você já sorteou"; difference `buyCount x curPrice - totalPoint`: >= 0 needs diamonds ("Durante o período de subscrição, você pagou {0} diamantes.\n Deseja consumir {1} para comprar item?"), < 0 refund ("Você pagou {0} diamantes durante o período de subscrição.\n Clicando em comprar poderá receber reembolso de {1} diamantes") | 4560 |
| R4 | lucky draw | draw button (`GBV:451-473`) | send 9523 `C_LEAD_EXTRACT` `LeadRewardMsg.op = 3` through `FunnyControler.sendLuckDraw` | none | 338 |

## 4. Server messages (server to client)

### S1. 4559 (0x11cf), name missing from `protocol/opcodes.csv`

- `com.road.yishi.proto.shop.GrouponShopMsg`: `buy_count` (#1, INT32) my subscribed units; `total_point` (#2, INT32) diamonds I paid so far (deposits); `cur_price` (#3, INT32) current tier price; `cur_count` (#4, INT32) server wide subscriptions; `good_id` (#5, INT32) offer id; `param1` (#6, INT32); `param2` (#7, STRING); `count` (#8, INT32) my subscriptions today; `is_reward` (#9, BOOL) settled; `frontMoney` (#10, INT32) deposit per subscription.
- Receiver: `GroupBuyView.updateDataHandler` (`GBV:141-173`), combined with the offer from `ShopManager.getMainShopInfoById` (`SM:1132-1152`).
- When: reply to R1 and R2; push to viewers when `cur_count` changes (assumption).

### S2. 4560 (0x11d0), name missing from `protocol/opcodes.csv`

- `GrouponShopMsg`: `buy_count` units bought, `total_point` final total paid, `param1` diamonds refunded (CheckView third argument "getZuanshi").
- Receiver: `GroupBuyView.checkResultHandler` (`GBV:126-139`): shows `CheckView`, marks settled.
- When: reply to R3.

### S3. 338 (0x0152) `U_C_GROUPON_DROPITEM`

- `com.road.yishi.proto.vip.VipRouletteMsg`: `left_count` (#1) draws left, `leftItem` (#4, repeated `VipItemInfoMsg {temp_id, count}`) prizes; other fields unused here.
- Receiver: `GroupBuyView.zhuanpanResultHandler` (`GBV:475-482`): opens the funny lucky wheel view.
- When: reply to R4.

## 5. Rules and formulas

- Tiers (`MainDiscountInfo`): base `price`; at `cur_count >= level1` price `price1`, `>= level2` `price2`, `>= level3` `price3` (progress bar uses `price - price_n` as the saving per tier, `GBPB:68-75`).
- Discount displayed: `cur_price / price x 10` (tenths, one decimal).
- Settlement: due = `buy_count x cur_price - total_point`; positive -> debit diamonds; negative -> refund diamonds.
- Limits: server wide `maxCount` subscriptions; per player `oneDayCount` per day.
- After `sendDate` unsettled deposits return as bound diamonds.
- Delivery: offer items x `buy_count` at settlement.

## 6. Templates

None. Offers are `shops.discount_offer` rows with `offer_type = 3`, tiers in `shops.discount_offer_tier` ([timebuy.md](timebuy.md)).

## 7. Persistent state

```sql
CREATE TABLE shops.group_buy_entry (
  offer_id        INTEGER     NOT NULL REFERENCES shops.discount_offer(offer_id) ON DELETE CASCADE,
  player_id       INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  units           INTEGER     NOT NULL DEFAULT 0 CHECK (units >= 0),
  deposits_paid   BIGINT      NOT NULL DEFAULT 0 CHECK (deposits_paid >= 0),
  settled         BOOLEAN     NOT NULL DEFAULT false,
  settled_price   INTEGER,
  draw_granted    BOOLEAN     NOT NULL DEFAULT false,
  PRIMARY KEY (offer_id, player_id)
);

CREATE TABLE shops.group_buy_daily (
  offer_id   INTEGER NOT NULL REFERENCES shops.discount_offer(offer_id) ON DELETE CASCADE,
  player_id  INTEGER NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day        DATE    NOT NULL,
  units      INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (offer_id, player_id, day)
);
```

The server wide count is `sum(units)` (cache it per offer; for a cross server event it must be aggregated across servers, see [../cross-server/README.md](../cross-server/README.md)).

## 8. Backend implementation notes

- `shops::group_buy::handle_op` (8645) dispatching on `pay_type`:
  - 3 `handle_info`: reply 4559 with my entry and the server wide count.
  - 1 `handle_subscribe`: subscription window open; server wide count < `max_count`; today < `one_day_count`; debit `front_money` diamonds; `units += 1`, `deposits_paid += front_money`; reply 4559; broadcast count change (assumption).
  - 2 `handle_settle`: payment window open (`end_at <= now < payment_end_at`); `units > 0`; not settled; compute price tier from the final count; debit or refund; grant items; mark settled; grant one lucky draw; reply 4560.
- Job at `payment_end_at`: refund deposits of unsettled entries as bound diamonds (mail).
- Lucky draw route 9523 belongs to [../daily-activity/README.md](../daily-activity/README.md) or [../seasonal-events/README.md](../seasonal-events/README.md).

## 9. Open questions and assumptions

- Gap: opcodes 4559 and 4560 have no name in `protocol/opcodes.csv`.
- Open: meaning of `GrouponShopMsg.param2`.
- Assumption: cross server aggregation of the subscription count.

## 10. Implementation checklist

- [ ] Tables `shops.group_buy_entry`, `shops.group_buy_daily`
- [ ] Route 8645 pay types 1, 2, 3
- [ ] Encoders 4559, 4560
- [ ] Price tier computation and settlement refund or extra charge
- [ ] Unsettled refund job
- [ ] Tests: subscribe over daily limit, settle with refund, settle twice
