# Recharge payment flow and crediting

Path aliases:

| Alias | File |
|---|---|
| RAM | `decompiled/core_module/scripts/yishi/manager/RechargeAlertMannager.as` |
| LU | `decompiled/core_module/scripts/utils/LogicUtils.as` |
| CP | `decompiled/core_module/scripts/yishi/lunch/ConfigParaser.as` |
| MTB | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as` |
| PI | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |

## 1. Overview

Recharging happens outside the game client. Every recharge button calls `RechargeAlertMannager.navigateToRechargePage` which opens the `PAY` URL of `config.xml` in a new browser window. The payment provider later notifies the game server over HTTP; the server credits diamonds to the character, flips the `first_charge` flag and pushes `PlayerMsg` (3). Every recharge activity listens to the credited event. The original BR URLs (`lobr.creaction-network.com`) are external; this project must serve its own page and notification route.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RechargeAlertMannager.show` alert (RAM:20-47) | "Diamante insuficiente, recarregar?" | Offer recharge | `LogicUtils.judgePointEnoughToShowPay` (LU:80-90) and direct calls | confirm (response 2 or 3) opens the page (RAM:36-39) |
| Browser window | external | Payment page | `navigateToRechargePage` (RAM:49-70) | |
| Main toolbar pay button | (art) | Opens the page | MTB:344, 536, 1391-1395 | |

Other callers of `navigateToRechargePage`: `RightMenuUtils.recharge` (context menu), `SwitchPageHelp` case 43, feedback frame, funny frames, first pay frames, continuous recharge, general compensation, charge lottery, Christmas and carnival frames, fund frames, regress and king back frames, sale and time buy, shop frames and the shop cart.

## 3. Routes (client to server)

### H1. Open the recharge page (HTTP, browser)
- UI: any recharge button.
- Client checks: `ExternalInterface.available` (the page opens only inside a browser host, RAM:55).
- Path: `PathManager.info.PAY`, parsed from `<SITES><NODE><PAY value=...>` by `ConfigParaser` (CP:45). When `ComponentSetting.SITE` starts with "7road" the client appends `?key=sq&site=<userInfo.site>&uid=<userInfo.user>` (RAM:57-63); otherwise it opens `PAY` as is (RAM:64-68). The BR value is `http://lobr.creaction-network.com/fbapp/pay.php?s=game&username={username}&server_id=21264` (`raw/config.xml:26`); the `{username}` placeholder is never substituted by the client.
- `READVIP` (`raw/config.xml:25`, VIP subscription page) is parsed but never opened by any class.
- Expected response: none on the socket until the payment completes.

### H2. Payment notification (HTTP, server to server, proposed)
Not part of the client. Proposed axum routes next to the existing ones in `server/src/main.rs`:

| Method and path | Caller | Body | Result |
|---|---|---|---|
| `GET /pay?username=&server_id=` | browser (value of `PAY` served in `/config.xml`) | query | HTML page listing the packages and starting the provider checkout; identifies the account by the web session cookie because `{username}` arrives literally |
| `POST /pay/notify` | payment provider | provider payload: `order_id`, `account` or `player_id`, `server_id`, `amount_cents`, `currency`, `package_id`, `signature` | verifies the signature, credits once per `order_id`, replies the provider specific ack |
| `POST /pay/dev-credit` | developer, localhost only | `player_id`, `diamonds` | same credit path, `provider = 'dev'` |

### Socket
No opcode requests a recharge. 5016 `U_C_PLAYER_INFO` (send) exists but is unused.

## 4. Server messages (server to client)

### S1. 3 (0x0003) `U_C_PLAYER_INFO`
- Fields: `point` (#6, INT32) new diamond balance; `first_charge` (#68, BOOL) true after the first credited recharge (`PlayerInfo.isFirstCharge`, PM:655-658, PI:547-556); the change marks `FIRSTCHARGE` and refreshes the toolbar.
- When: right after the credit commit, if the player is online. Offline players get the values in the login `PlayerMsg`.

### S2. Fan out
After S1 the listeners push their own state: 4290 (new first recharge, [first-pay.md](first-pay.md)), 4476 (funny activities: period recharge, continuous recharge), 4866 (general compensation), 4463 (recharge feedback), 4745 (recharge ranking, [../cross-server/README.md](../cross-server/README.md)), 432 (recharge roulette, [../lotteries/README.md](../lotteries/README.md)), 4739 (returner recharge, [../returning-players/README.md](../returning-players/README.md)).

## 5. Rules and formulas

- Diamonds per order: `package.diamonds + package.bonus_diamonds`; packages are server configuration (no client data). Exchange rate is an open question.
- `first_charge` becomes true on the first credited order and never resets.
- Recharged diamonds are plain diamonds (`point`), never bound.
- Recharge totals are kept per player per day (server time) for daily activities and in total for tiered activities ("Recarregue + {0} diamantes para receber", "Hoje já recarregou acumuladamente: {0} diamantes").
- Recharge is not consumption: it does not add VIP growth (growth comes from spending, [../vip/membership.md](../vip/membership.md)).
- Idempotency: `order_id` unique per provider; a repeated notify returns the stored result without crediting again.
- Refunds or chargebacks: debit diamonds, allow negative balance (assumption: block diamond spending until positive); log in the ledger.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/config.xml` | `<PAY>`, `<READVIP>`, `<SITE>` | external URLs; `/config.xml` served by the Rust server must point `PAY` to `/pay` |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS recharge;

CREATE TABLE recharge.packages (
  id              SERIAL   PRIMARY KEY,
  price_cents     INTEGER  NOT NULL CHECK (price_cents > 0),
  currency        CHAR(3)  NOT NULL DEFAULT 'BRL',
  diamonds        INTEGER  NOT NULL CHECK (diamonds > 0),
  bonus_diamonds  INTEGER  NOT NULL DEFAULT 0 CHECK (bonus_diamonds >= 0),
  active          BOOLEAN  NOT NULL DEFAULT true
);

CREATE TABLE recharge.orders (
  id              BIGSERIAL   PRIMARY KEY,
  provider        TEXT        NOT NULL,
  provider_order  TEXT        NOT NULL,
  player_id       BIGINT      NOT NULL REFERENCES player.players(player_id),
  package_id      INTEGER     REFERENCES recharge.packages(id),
  amount_cents    INTEGER     NOT NULL CHECK (amount_cents >= 0),
  currency        CHAR(3)     NOT NULL,
  diamonds        INTEGER     NOT NULL CHECK (diamonds >= 0),
  status          TEXT        NOT NULL CHECK (status IN ('pending','credited','refunded','failed')),
  raw_payload     JSONB,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  credited_at     TIMESTAMPTZ,
  UNIQUE (provider, provider_order)
);
CREATE INDEX orders_player_idx ON recharge.orders (player_id, created_at DESC);

CREATE TABLE recharge.player_totals (
  player_id        BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  first_credit_at  TIMESTAMPTZ,
  total_diamonds   BIGINT      NOT NULL DEFAULT 0 CHECK (total_diamonds >= 0),
  order_count      INTEGER     NOT NULL DEFAULT 0
);

CREATE TABLE recharge.daily_totals (
  player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day         DATE    NOT NULL,
  diamonds    INTEGER NOT NULL DEFAULT 0 CHECK (diamonds >= 0),
  PRIMARY KEY (player_id, day)
);
```

`PlayerMsg.first_charge` = `recharge.player_totals.first_credit_at IS NOT NULL`.

## 8. Backend implementation notes

- `recharge::payment::http_notify` (`POST /pay/notify`): verify signature; `INSERT ... ON CONFLICT (provider, provider_order) DO NOTHING RETURNING id`; when the row already exists and is credited, return the ack. Otherwise call `credit_order`.
- `recharge::payment::credit_order(order_id)`: one transaction: lock the order (`pending`), `currency::spending::grant(Reward::Virtual(-400, diamonds), reason "recharge.credit", ref order)` (no consumption flag), upsert `player_totals` and `daily_totals`, set `credited`; then `recharge::payment::on_credited(tx, player_id, diamonds, order_id)` which calls each listener inside the same transaction (`first_pay::on_recharge`, `feedback::on_recharge`, `whole_rebate::on_recharge`, `funny::on_recharge`, `charge_rank::on_recharge`, `charge_lottery::on_recharge`, `returner::on_recharge`). After commit: push S1 then each listener's push (S2).
- `recharge::payment::http_page` (`GET /pay`): renders packages; requires a logged in web session (account login route of [../account/login-session.md](../account/login-session.md)).
- `/config.xml` served by the server rewrites `PAY` to the local `/pay` URL so `navigateToRechargePage` reaches it.
- Online check for pushes through the session registry; offline players see the new state at login.

## 9. Open questions and assumptions

- Open: real packages, prices and the diamond exchange rate of the BR server.
- Open: payment provider choice and payload; routes above are proposals.
- Assumption: chargebacks create negative diamond balances.
- Assumption: `daily_totals.day` uses server time midnight like the other daily resets.

## 10. Implementation checklist

- [ ] Screen: recharge alert opens `/pay` in a new window
- [ ] Route H1 `PAY` rewritten in `/config.xml`
- [ ] Route H2 `GET /pay`, `POST /pay/notify`, `POST /pay/dev-credit`
- [ ] Server message S1 3 with `point` and `first_charge`
- [ ] Server message S2 fan out pushes
- [ ] Table `recharge.packages`
- [ ] Table `recharge.orders`
- [ ] Table `recharge.player_totals`
- [ ] Table `recharge.daily_totals`
- [ ] Rule: idempotent crediting per order
- [ ] Rule: `first_charge` set once
- [ ] Rule: recharge does not count as consumption
- [ ] Test: duplicate notify credits once
- [ ] Test: online player sees diamonds update without relog

## Screens

- `ChoosePayTypeFrame` (`decompiled/core_module/scripts/mainBar/view/ChoosePayTypeFrame.as`, "Escolha modo de pagamento de aceleração de resfriamento:", "(Diamante vinculado prioritário)") lets the player pick how to pay for a cooldown speed-up.
