# Gashapon (pumping joy, "幸运扭蛋")

Path aliases:

| Alias | File |
|---|---|
| PJM | `decompiled/core_module/scripts/managers/PumpingJoyManager.as` |
| PJMOD | `decompiled/core_module/scripts/mvc/module/pumpingegg/PumpingJoyModel.as` |
| PJF | `decompiled/m11/scripts/pumpingjoy/PumpingJoyFrame.as` |
| PJRF | `decompiled/m11/scripts/pumpingjoy/PumpingJoyRewardFrame.as` |
| PJDF | `decompiled/m11/scripts/pumpingjoy/PumpingJoyDropFrame.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed capsule machine. One draw costs `oneNeedPoint` diamonds or one "Cupom de Gashapon" (208068); ten draws cost `tenNeedPoint` diamonds or ten coupons. Each capsule gives an item and gashapon points (`rewardScore`) spent in the "Loja do Gashapon" (shop 1012). Grand prizes create "Sorte partilhada" (shared luck) for every player of the server: a timed bonus each player collects. A floor reward ("Após atingir as condições requeridas obtém os prêmios abaixo:") is guaranteed every `floorNeedPumps` draws. The points shop stays open one day after the event ends.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `pumpingjoy.PumpingJoyFrame` (PJF) | "Gashapon" (`ui.toptoolbar.TopToolsBar.tipData_pumpingjoy`, PJF:462) | Machine animation; 9 showcase rewards (`types 1`, `isShow`, sorted by `profile` desc, PJF:350-361); shared luck icon with tip and collect button; floor icon with tip and `floorNeedPumps`; score; coupon count; event and shop countdowns; buttons x1, x10, shop, "Prêmio possíveis dos ovos" link | Top toolbar `pumpingjoy` (TopToolBtnInfos 2048 "幸运扭蛋") -> `SwitchPageHelp.openPumpingJoyFrame()` (TTB:1426-1428); using a SonType 219 item (the coupon) from the bag (`PlayerBagCellClickMediator.as:274-277`, `GoodsItemMenu.as:289`) | level < 16: "dayGuide.DayGuideManager.command02"; closed: "Este evento ainda não começou ou já terminou." (SPH:2459-2473) |
| `pumpingjoy.PumpingJoyRewardFrame` (PJRF) | "map.campaign.view.ui.gvgcross.reward.showReward" | Capsules won by the last draw, opened one by one or "open all"; closing announces unopened ones (PJRF:156-199) | after the machine animation (PJF:311-325) | `resultEggIds` |
| `pumpingjoy.PumpingJoyDropFrame` (PJDF) | possible prizes | All rewards by type | PJF link (PJF:333-338) | `eggTempList` |
| Shop 1012 "Loja do Gashapon" | `view.subshop.PumpingJoyShopFrame.str01` | Points shop (owned by [../shops/README.md](../shops/README.md)) | PJF shop button (PJF:229-233) | score; closing notice "A Loja de Pontos encerra em {0}..." |

Toolbar visibility: `thane.grades >= 16 && model.isOpen && VersionSwitch.PUMPING_JOY` (TBH:363-364).

## 3. Routes (client to server)

All routes: C>S 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`, header `extend1 = 27`, body `cccactive.PumpingMsg` with `op` (#1, INT32) and `lotteryType` (#4, INT32). Sender `PumpingJoyManager.sendPumpRequest(op, lotteryType = 1)` (PJM:144-151); ops `OPEN_FRAME_OP 1`, `LOTTERY_TYPE_OP 2`, `GET_LUCKY_REWARD_OP 3` (PJM:22-26).

### R1. Open (op 1)
- UI: frame constructor (PJF:102).
- Expected response: 4850 (S2).

### R2. Draw x1 / x10 (op 2)
- UI: x1 or x10 button (PJF:241-281).
- Client checks: coupons (bag and stone house count of 208068, PJF:344) >= n or `point >= cost` (n = 1, cost `oneNeedPoint`; n = 10, cost `tenNeedPoint`), else recharge alert. Confirmation (can be muted by `SharedManagerHelper.needAlert`): with enough coupons "Confirma que deseja gastar {0} para sortear {1} vezes no gashapon?\n(Primeiro são gastos os cupons de gashapon.)\nNº de cupons de gashapon atual: {2}", otherwise "Deseja gastar {0} diamantes para sortear no gashapon {1} vezes?".
- Fields: `op 2`, `lotteryType` 1 (x1) or 2 (x10).
- Expected response: 4848 (S3) with `resultEggIds`; 4850 (S2) with the new score and luck; bag 115; currency 3.

### R3. Collect shared luck (op 3)
- UI: collect button, enabled when a non expired luck exists (PJF:235-239, 372-385).
- Expected response: 4850 (S2) with the luck entry removed or `takeState` changed; rewards to the bag.

## 4. Server messages (server to client)

### S1. 4847 (0x12ef) `U_C_CCACTIVE_OPENSTATE`
- `PropertyMsg` (package `simple`): `param1` (#1, INT32) activity id, 27 = gashapon; `param7` (#7, BOOL) open.
- Receiver: `BaseManager.__CCActiveOpenStateHandler` (BM:344, 703-717): only id 27 handled -> `model.isOpen`, `REFRESH_TOPTOOLS`.
- When: login and event start or end.

### S2. 4850 (0x12f2) `U_C_PUMPINGJOY_INFO`
- `cccactive.PumpingMsg`: `op` (#1, INT32); `openTime` (#2, STRING) and `stopTime` (#3, STRING) "YYYY-MM-DD hh:mm:ss"; `lotteryType` (#4, INT32); `eggTempList` (#5, `EggTempMsg`, repeated); `resultEggIds` (#6, INT32, repeated); `luckyRewards` (#7, `LuckyRewardMsg`, repeated); `totalScore` (#8, INT32) gashapon points; `oneNeedPoint` (#9, INT32); `tenNeedPoint` (#10, INT32); `floorNeedPumps` (#11, INT32) draws until the floor reward; `luckyLeftCount` (#12, INT32) shared luck activations left today.
- `EggTempMsg`: `id` (#1, INT32) reward id; `tempId` (#2, INT32) item; `count` (#3, INT32); `profile` (#4, INT32) rarity, 3 = grand prize (chat "Parabéns por ter obtido o grande prêmio:"); `isShow` (#5, BOOL) showcase; `types` (#6, INT32) 1 capsule pool, 2 shared luck rewards, 3 floor rewards; `rewardScore` (#7, INT32) points added.
- `LuckyRewardMsg`: `uuid` (#1, STRING); `eggId` (#2, INT32) source reward; `timeOutDate` (#3, STRING) expiry; `takeState` (#4, INT32).
- Receiver: `PumpingJoyManager.__pumpingJoyInfoBack` (PJM:64-131): optional fields only overwrite when present (`has*`); shop end = `stopTime + 86400 s`; lists replaced; luck list sorted by expiry; `PUMPING_JOY_MSG_BACK` -> `refreshView` (PJF:340-418). Current luck = first entry with `timeOutDate > now` (PJMOD:74-97).
- When: reply to R1, R2, R3; push to all online players when a grand prize creates shared luck (assumption).

### S3. 4848 (0x12f0) `U_C_PUMPINGJOY_RESULT`
- `cccactive.PumpingMsg`, only `resultEggIds` (#6) read: reward ids won, in order.
- Receiver: `PumpingJoyManager.__pumpingJoyResultBack` (PJM:133-142) -> `PUMPING_JOY_DRAW_BACK` -> machine animation 1.8 s, then `PumpingJoyRewardFrame` (PJF:293-325). Opening a capsule writes "Parabéns por ter obtido:" or the grand prize text plus "name x count, Pontos +{0}" to the system chat (PJF:420-447).
- When: reply to R2, only when the draw succeeded.

## 5. Rules and formulas

- B1. Unlock: level 16 (SPH:2461-2465) and event open.
- B2. Payment: coupons first; x10 uses coupons only when the player has at least 10 (coupon tip "Para gastar cupons de gashapon quando realiza 10 sorteios sucessivos, o número de cupons tem de ser igual ou superior a 10."), otherwise diamonds (`tenNeedPoint`, usually a discount). Bound diamonds not accepted (client checks `point`).
- B3. Each capsule: weighted roll among `types 1`; adds `rewardScore` to `totalScore`.
- B4. Floor: after `floorNeedPumps` more draws the player gets the `types 3` rewards; the counter restarts (assumption).
- B5. Shared luck: when any player hits a `profile 3` capsule, every player of the server gains one luck entry (rewards `types 2`) with an expiry, at most `luckyLeftCount` per day ("Hoje a sorte partilhada pode ser ativada {0} vezes. Este valor é resetado todos os dias de madrugada."); collecting consumes the current entry.
- B6. Points shop open until `stopTime + 1 day`; points then removed ("Os pontos desta edição serão eliminados").

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208068 "Cupom de Gashapon" (SonType 219) | use from bag opens the frame |
| `raw/xml/tempinfos/ConfigInfos.xml` | `year_gacha_buy` 100, `year_gacha_extract` 20 | anniversary variant ("Deseja gastar {0} Moeda(s) de Aniversário..."), owned by [../seasonal-events/README.md](../seasonal-events/README.md) |

Reward pools are server data.

## 7. Persistent state

```sql
CREATE TABLE lotteries.gashapon_event (
  event_id        SERIAL      PRIMARY KEY,
  starts_at       TIMESTAMPTZ NOT NULL,
  ends_at         TIMESTAMPTZ NOT NULL,
  price_one       INTEGER     NOT NULL,
  price_ten       INTEGER     NOT NULL,
  floor_draws     INTEGER     NOT NULL CHECK (floor_draws > 0),
  luck_daily_cap  INTEGER     NOT NULL,
  luck_lifetime   INTERVAL    NOT NULL DEFAULT INTERVAL '1 hour'
);

CREATE TABLE lotteries.gashapon_reward (
  event_id     INTEGER  NOT NULL REFERENCES lotteries.gashapon_event(event_id) ON DELETE CASCADE,
  reward_id    INTEGER  NOT NULL,
  pool         SMALLINT NOT NULL CHECK (pool IN (1, 2, 3)),
  item_id      INTEGER  NOT NULL,
  item_count   INTEGER  NOT NULL,
  rarity       SMALLINT NOT NULL,
  showcase     BOOLEAN  NOT NULL DEFAULT FALSE,
  score        INTEGER  NOT NULL DEFAULT 0,
  weight       INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, reward_id)
);

CREATE TABLE lotteries.gashapon_player (
  event_id          INTEGER NOT NULL REFERENCES lotteries.gashapon_event(event_id) ON DELETE CASCADE,
  player_id         BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  score             INTEGER NOT NULL DEFAULT 0,
  draws_to_floor    INTEGER NOT NULL,
  luck_used_day     INTEGER NOT NULL DEFAULT 0,
  luck_day          DATE    NOT NULL DEFAULT CURRENT_DATE,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE lotteries.gashapon_luck (
  luck_id     UUID        PRIMARY KEY,
  event_id    INTEGER     NOT NULL REFERENCES lotteries.gashapon_event(event_id) ON DELETE CASCADE,
  source_reward INTEGER   NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at  TIMESTAMPTZ NOT NULL
);

CREATE TABLE lotteries.gashapon_luck_claim (
  luck_id    UUID    NOT NULL REFERENCES lotteries.gashapon_luck(luck_id) ON DELETE CASCADE,
  player_id  BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  claimed_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (luck_id, player_id)
);
```

## 8. Backend implementation notes

- `extend1 = 27` -> `lotteries::gashapon::handle_op`:
  - 1 `handle_open`: reply 4850 with everything (the client overwrites only fields present).
  - 2 `handle_draw`: open -> level 16 -> `lotteryType` 1 or 2 -> payment per B2 -> bag space. Transaction: debit, roll, floor, score, grant; for each `profile 3` hit insert `gashapon_luck`. Reply 4848, 4850, 115, 3. Push 4850 (luck list) to online players for new luck entries.
  - 3 `handle_collect_luck`: current luck exists, not claimed, `luck_used_day < luck_daily_cap`. Grant `pool 2` rewards, insert claim. Reply 4850, 115.
- Push 4847 (`param1 27`) at login and on start or end.
- Shop 1012 sells against `gashapon_player.score` until `ends_at + 1 day`.

## 9. Open questions and assumptions

- Assumption: shared luck lifetime and `takeState` semantics (0 not claimed, 1 claimed).
- Assumption: floor reward granted automatically on the Nth draw.
- Open: coupon priority for x10 with fewer than 10 coupons (client text says coupons first; the coupon tip says 10 needed).

## 10. Implementation checklist

- [ ] Screens `PumpingJoyFrame`, `PumpingJoyRewardFrame`, `PumpingJoyDropFrame`
- [ ] Route 9645/27 op 1, op 2 (x1, x10), op 3
- [ ] Messages 4847 (id 27), 4850, 4848
- [ ] Tables `gashapon_event`, `gashapon_reward`, `gashapon_player`, `gashapon_luck`, `gashapon_luck_claim`
- [ ] Rules B2..B6, shop 1012 balance
- [ ] Test: coupon priority, x10 with 9 coupons pays diamonds
- [ ] Test: grand prize creates luck for other online players
