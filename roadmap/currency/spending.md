# Spending and granting: diamonds, bound diamonds, virtual reward ids, ledger

Path aliases:

| Alias | File |
|---|---|
| LU | `decompiled/core_module/scripts/utils/LogicUtils.as` |
| RAM | `decompiled/core_module/scripts/yishi/manager/RechargeAlertMannager.as` |
| SAH | `decompiled/core_module/scripts/yishi/utils/SimpleAlertHelper.as` |
| BF | `decompiled/core_module/scripts/yishi/view/frame/BuyFrameI.as` |
| GIM | `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as` |
| PBC | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as` |
| NH | `decompiled/core_module/scripts/mvc/module/navigation/NavigationHelper.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |

## 1. Overview

This module is the server side contract that every priced feature uses: how a cost in diamonds, bound diamonds, gold or a token is checked and taken, how a reward expressed as a virtual item id becomes a wallet delta, and how every movement is logged. On the client it is a set of shared helpers (diamond check, recharge prompt, bound first checkbox). It also defines the consumption hooks used by VIP growth and recharge activities.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RechargeAlertMannager.show` simple alert (RAM:20-47) | "Diamante insuficiente, recarregar?" | Offer the recharge page when diamonds are short | any diamond check that fails (`LogicUtils.judgePointEnoughToShowPay`, LU:80-90, and about 245 call sites) | prompt; confirm (response 2 or 3) calls `navigateToRechargePage` (RAM:36-39) |
| Bound diamond alert `USEBINDPOINT_ALERT` style `UseBindPointAlertStyle` (SAH:78-89, 206-223) | feature specific text plus a checkbox "Diamante vinculado prioritário" / "(Diamante vinculado prioritário)" | Confirm a diamond price and choose bound first | priced actions (queues, rescues, refreshes, guild donation) | the callback receives `(confirmed, useBind)` (SAH:133-157) |
| `BuyFrameI` | shop buy frame with checkbox `yishi.view.frame.BuyFrameI.priorityUse` "Diamante vinculado prioritário" (BF:194) | Shop purchase | shops | price; `buy(_isuseBindPointBtn.selected)` (BF:888) |

## 3. Routes (client to server)

This module has no opcode of its own. Every priced request of other features carries one of these payment selectors, all with the same meaning:

| Field | Message | Values |
|---|---|---|
| `payType` (#3, INT32) | `shop.CarItemInfoMsg` (8970 `C_SHOPCAR_BUY`) | 1 = diamonds only, 2 = bound diamonds first (BF:941-948) |
| `payType` (#3, INT32) | `player.PlayerOpMsg` (many ops, e.g. 8672) | same convention (assumption where the sender does not show a checkbox) |
| `pay_type` (#3, INT32) | `consortia.ConsortiaUserOfferReqMsg` | not written by this client; bound first is the default for guild donations ([../guild/funds.md](../guild/funds.md)) |
| `pay_type` (#2, INT32) | `reward.RewardFreshReqMsg` | bounty refresh ([../quests/README.md](../quests/README.md)) |

Client side checks before any priced request:
- `LogicUtils.judgePointEnoughToShowPay(cost, allowBind)` (LU:80-90): balance = `point + giftToken` when `allowBind`, else `point`; if short shows the recharge alert and returns false (no request is sent).
- Bound diamond forbidden cases, refused client side with these strings: "Não pode usar diamantes vinculados para presentear amigos." (`view.shopFrame.giving.bind`), "Não pode usar diamantes vinculados nos itens da promoção limitada." (`view.shopFrame.buyFrameI.shopCartItem.change`), "Não pode usar diamantes vinculados neste item." (`view.shopFrame.buyFrameI.shopCartItem.fault`).
- Using an item of SonType 311 that costs a currency: `Property2` is the virtual id of the currency, `Property3` the amount; the client checks the balance and shows "cell.mediator.playerbag.PlayerBagCellClickMediator.command08" when short (GIM:166-230, PBC:131-143, 344-388). Ids checked: -800 glory crystal, -700 (client checks Espírito), -600 light crystal, -500 bound diamonds, -400 diamonds, -300 Espírito, -200 Ametistas, -100 gold.

## 4. Server messages (server to client)

No message of its own. After a spend or grant the server sends, in this order and after commit:
1. 3 (0x0003) `U_C_PLAYER_INFO` with the changed `PlayerMsg` currency fields ([wallet.md](wallet.md) S2).
2. 109 (0x006d) `U_C_CASTLE_UPDATE` when gold or light crystal changed ([wallet.md](wallet.md) S1).
3. 4725 (0x1275) `U_C_PLAYER_TOKENINFO` when a token changed ([tokens.md](tokens.md) S1).
4. The feature's own result message.

Failures (balance short, forbidden bound use) are answered with the feature's result code when it has one; otherwise with 126 (0x007e) `U_C_MSG` (`campaign.CampaignNotifyMsg`: `id` (#1, INT32), `scene` (#2, STRING, empty = current scene), `map_id` (#3, INT32), `body` (#4, STRING) text, `delay` (#5, INT32)), handled by `BaseManager.__msgHandler` (BM:299, 2070-2085) (assumption, same convention as [../smith/store-frame.md](../smith/store-frame.md)).

## 5. Rules and formulas

### Diamond split (`payType` 2, bound first)
```
bound_used   = min(max(bound_diamonds, 0), cost)
diamond_used = cost - bound_used
require diamonds >= diamond_used
```
`payType` 1 or a forbidden context: `bound_used = 0`, `diamond_used = cost`. Items bought with any bound diamonds are delivered bound ("Esta compra contém diamantes vinculados, por isso os itens são vinculados", `view.subshop.ShopCartFrame.buyText1`).

### Consumption accounting
- Only `diamond_used` counts for "consumption" activities: "Diamantes vinculados não pertencem ao evento de consumo" (`yishi.view.frame.TodayNotAlertFrame.notJoinActPromptTxt`), "Diariamente ao consumir valor desejado de diamantes não vinculados" (`shop.dayCost.alertData`). Exception: activities that say so explicitly ("inclui diamantes vinculados", `funny.datas.FunnyBagData.title89`) count both; the activity owns that flag.
- VIP growth: `Vip_ConsumeGp = 0.01` growth point per consumed diamond (1 point per 100 diamonds), auction purchases excluded ([../vip/membership.md](../vip/membership.md)).
- Daily activity task "Consumir diamantes vinculados ou não {0}x" counts both kinds ([../daily-activity/README.md](../daily-activity/README.md)).
- Encouragement gold "Ouro da Incentivação" reacts to the first consumption of the day ([../recharge/enco-gold.md](../recharge/enco-gold.md)).

### Virtual item ids (rewards and prices)

A drop or price with a negative `TemplateId` (`raw/xml/tempinfos/ItemTempInfos.xml`, MasterType 2) is a currency, not an item. Mapping to wallet columns or tokens (sources: GIM, NH:17-40, [tokens.md](tokens.md)):

| Id | pt-BR | Target |
|---:|---|---|
| -100 | Ouro | `wallets.gold` |
| -200 | Ametistas | `wallets.amethysts` |
| -300 | Espírito | `wallets.spirit` |
| -350 | Pontuação de Baú | owner feature (assumption: treasure score) |
| -400 | Diamante | `wallets.diamonds` |
| -500 | Diamante Vinculado | `wallets.bound_diamonds` |
| -600 | Cristal de Luz | `wallets.light_crystal` |
| -700 | Experiência | hero experience ([../hero/README.md](../hero/README.md)) |
| -800 | Cristal da Glória | `wallets.glory_crystals` |
| -900 | Carta de Selo do Einherjar vazio | item (MasterType 4), not a currency |
| -1000 | Emblema do Rei | owner feature (king seal, "Selo do Rei", assumption) |
| -1100 | Emblema do Campeonato | `wallets.league_medals` |
| -1200 | Experiência de Einherjar | [../einherjar/README.md](../einherjar/README.md) |
| -1300 | Cristal de Titã | token 2 family (assumption) |
| -1400 | Dente do Terror | token 6 (NH:25) |
| -1500 | Pedra do Caos | token 10 |
| -1600 | Cristais de Vênus | token 12 |
| -1700..-1709 | magic pub ingredients | tokens 101..110 |
| -1801, -1802, -1803 | Chave de Baú, Cupom de sorteio do Gashapon, Moeda de Aniversário | tokens 62, 63, 64 |
| -1900 | Pontos de Inspiração | owner feature |
| -2000..-2600 | cat toys | tokens 1001..1007 |
| -2700 | Moeda Estelar | token 41 |
| -2900 | Pedra da Coragem | token 31 |
| -3000 | Essência da Fera | token 14 (NH:23) |
| -3100 to -3300 | Essência do Plano, Nº de ressuscitações, Morte | owner features |
| -3400 | Cristais da Terralém | token 17 |
| -3500 | Coração do Deus Ares | token 18 |
| -3600 | Ouro de Yalamen | token 19 |
| -3700 | Lágrimas de Athena | token 20 |
| -3800 | Cristais Vermelhos | token 21 |
| -3900 | Pontos da Glória | token 22 |
| -4000 | Moeda do Jogo | token 15 (NH:21) |
| -4100 | Cristais amarelos | token 23 |
| -4200 | Medalhas do Eremitério | token 24 |
| -4300 | Chaves do Julgamento | owner feature |
| -4400 | Medalhas da Força | token 28 |
| -4500, -4600 | Movimento, Cristais Energéticos | owner features |
| -4700 | Prata de Moréia | token 29 |
| -4800 | Coração de Gelo | token 30 |
| -4900 | Cristal de localização | token 32 |
| -5000, -5100 | Cristal da diversão, Cristal da loucura | tokens 33, 34 |
| -5200, -5300, -5400 | Ovo colorido, Bilhete para expedição, Lágrima de Desejo | owner features (Easter tokens 35/36 assumption for -5200) |
| -5500 | Mérito | token 61 |
| -5600 | Cristal da masmorra | owner feature |
| -11000 | Marca dos Deuses | token 46 |
| -15000 | Pontos de guerreiro | owner feature |
| -16000 | Pó Mítico | token 56 |
| -17000 | Alma do labirinto | token 39 |
| -18000 | Pontos de Chefão | token 57 |
| -19000 | Gema Poseidon | token 58 |
| -20000 | Pontos de Folia | owner feature (carnival) |
| -21000 | Pontos Minos | token 65 |
| -22005 | Pontuação do Mistério do Nevoado | owner feature |
| -23000 | Pontos Táticos | token 66 (assumption) |

Item id 208001 is the real arena medal item; `NavigationHelper` reads token 8 for it (NH:39-40).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | `ItemTempInfo` with negative `TemplateId` | `TemplateName`, `MasterType` (2), `SonType` (200 core, 208 token) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | SonType 311 items | `Property2` currency id, `Property3` amount needed to use |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Vip_ConsumeGp` (0.01) | VIP growth per consumed diamond |

## 7. Persistent state

```sql
CREATE TABLE currency.ledger (
  id             BIGSERIAL   PRIMARY KEY,
  player_id      BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  currency       TEXT        NOT NULL,              -- 'gold','diamonds','bound_diamonds','spirit','honor',... or 'token:<master_type>'
  delta          BIGINT      NOT NULL CHECK (delta <> 0),
  balance_after  BIGINT      NOT NULL,
  reason         TEXT        NOT NULL,              -- e.g. 'shop.buy', 'vip.open', 'recharge.credit', 'quest.reward'
  ref_type       TEXT,
  ref_id         TEXT,
  counts_as_consumption BOOLEAN NOT NULL DEFAULT false,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ledger_player_time_idx ON currency.ledger (player_id, created_at DESC);
CREATE INDEX ledger_consumption_idx ON currency.ledger (player_id, created_at) WHERE counts_as_consumption;

CREATE TABLE currency.daily_consumption (
  player_id          BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day                DATE    NOT NULL,
  diamonds_spent     INTEGER NOT NULL DEFAULT 0 CHECK (diamonds_spent >= 0),
  bound_spent        INTEGER NOT NULL DEFAULT 0 CHECK (bound_spent >= 0),
  PRIMARY KEY (player_id, day)
);
```

## 8. Backend implementation notes

Shared API (crate module `currency::spending`), used inside the caller's transaction:
- `spend(tx, player_id, Cost::{Gold(n), Diamonds{amount, pay_type, allow_bound}, Token(type, n), Spirit(n), ...}, reason, ref) -> Result<Spent, SpendError>`: `SELECT ... FOR UPDATE` on `currency.wallets` (and `currency.tokens` row), compute the diamond split, check, update, insert ledger rows (one per currency touched), update `currency.daily_consumption`; set `counts_as_consumption` for `diamond_used`. Returns the split so the caller can bind items.
- `grant(tx, player_id, Reward::{Virtual(id, n), Token(...)}, reason, ref)`: maps virtual ids with the table above; non currency ids are routed to the owner feature (experience, items).
- `after_commit(player_id, changed: ChangedSet)`: push 3, 109, 4725 as needed.
- Consumption hook: `currency::spending::on_consumption(tx, player_id, diamonds, bound, reason)` calls `vip::membership::add_consume_growth` (skip when `reason` starts with `auction.`), `recharge::enco_gold::on_consume`, and the activity counters of [../seasonal-events/README.md](../seasonal-events/README.md) and [../daily-activity/README.md](../daily-activity/README.md).
- Validation order for every priced handler: request shape, feature rules (level, state, limits), then `spend`, then the effect, all in one transaction.
- Idempotency: priced handlers that may be retried by double clicks should lock the feature row first so two concurrent requests serialize.

## 9. Open questions and assumptions

- Assumption: `payType` 1 = diamonds only, 2 = bound first, for every message that carries it (proven only for `CarItemInfoMsg`, BF:941-948).
- Assumption: negative bound diamonds are allowed as debt and block bound spending until repaid.
- Open: owners and exact semantics of virtual ids -350, -1000, -1300, -1900, -3100..-3300, -4300, -4500, -4600, -5200..-5400, -5600, -15000, -20000, -22005.
- Assumption: errors without a feature result code use 126 `U_C_MSG`.

## 10. Implementation checklist

- [ ] Screen: recharge alert appears when the client check fails (no request sent)
- [ ] Screen: bound first checkbox maps to `payType` 2
- [ ] Rule: diamond split bound first
- [ ] Rule: forbidden bound contexts refused server side too
- [ ] Rule: consumption counts only non bound diamonds unless the activity opts in
- [ ] Rule: VIP growth from consumption, auction excluded
- [ ] Rule: virtual id mapping for every row above
- [ ] Table `currency.ledger`
- [ ] Table `currency.daily_consumption`
- [ ] API `spend`, `grant`, `after_commit`, `on_consumption`
- [ ] Test: payType 2 with 30 bound and cost 100 takes 30 bound + 70 diamonds and logs two ledger rows
- [ ] Test: concurrent spends never make a balance negative
- [ ] Test: a drop of -400 x 50 adds 50 diamonds and pushes 3
