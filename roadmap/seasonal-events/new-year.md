# New Year ("Log in de Ano Novo", "Baú da Sorte", "Guia de Consumo do Ano Novo")

Feature `seasonal-events`, module `new-year`. Client code: `M11/newyearactivity/*` (login and lottery frames), `CM/newyearact/*` (models), `CM/funny/newyearact/NewYearPayActView.as` (rebate tab inside the "Destaques" frame), `CM/yishi/manager/NewYearActManager.as` (`NYM`), `CM/managers/NewYearSocketOutManager.as` (`NYS`), controller `newyearact` (`NewYearActController`). Proto `active.LoginActiveMsg`, `LoginRewardInfoMsg`, `RewardItemMsg`, `ItemMsg`, `RebateAllInfosMsg`, `PayInfoMsg`, `ChargeLotteryMsg`, `ActiveOptionMsg`.

Conventions: see [README.md](README.md).

---

## 1. Overview

Three New Year sub-activities:

| Sub-activity | pt-BR | Mechanic |
|---|---|---|
| New Year login | "Log in de Ano Novo" | 7 day login calendar; day N reward is claimable once the player has logged in on N days of the event |
| Recharge lottery | "Baú da Sorte" | Every `onceNeedPoint` diamonds recharged during the event gives one chest; opening a chest draws one item of a shown pool (sent by mail when the bag is full) |
| Consumption rebate | "Guia de Consumo do Ano Novo" | Sum-active activity of type 49 shown inside the "Destaques" frame: 6 columns ("Coluna"), each day of recharge raises the column; the player collects a bound diamond rebate of `discount`% of today's spend capped by `maxDiamond` |

---

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `newyearactivity.ContinuousLoginFrame` (`M11/newyearactivity/ContinuousLoginFrame.as`) | "Log in de Ano Novo" | 7 days | Tool bar `newyear` (TopToolBtnInfo 2043, `TopToolsBar.as:1176-1177`, `NewYearActController.CONTINOUSLOGIN`); visible when `grades >= 11`, `isOpenNewYearAct` and not `isGetOver` (`TopBtnCheckShowHelper.as:273-274`) | Per day "Login {0} dia(s)" with items (`loginRewardList[index-1]`); locked when `index > loginNum`, stamp when `status == 1`, else claim button (`ContinuousLoginItem.as:94-127`) |
| `newyearactivity.NewYearLotteryFrame` + `NewYearLotteryItem` + `NewYearLotteryTurnControl` | "Baú da Sorte" | Chest lottery | Tool bar `newyearlottery` (2018, `TopToolsBar.as:1179-1180`, `NewYearActController.LOTTERY`); visible when `grades >= 11` and `isOpenNewYearLottery` (`:275-276`) | Pool (`lotteryGoodsList`), "Oferta de presente ao recarregar ... superior a {0} Diamantes poderá obter o Baú da Sorte", "Você possui {0} Baú da Sorte", "Tempo restante: {0}"; result tip and chat line; mail note if `isMail` |
| `funny.newyearact.NewYearPayActView` | "Hora do Evento: {0} -- {1}", "Coluna atual {0} feedback de {1}%", "{0} Diamantes Vinculados", "Coluna{0}", "DevoNv.er: {0}%" | Rebate | "Destaques" frame when the selected activity has `type == 49` (`CM/funny/view/FunnyFrame.as:530-555, 715-722`) | Today's spend (`cur_PayPoint`), current column, rebate amount, two progress bars (`payCount`, `getCount`) |

---

## 3. Routes (client to server)

All three routes carry `active.ActiveOptionMsg`: `opType` (#1, INT32), `opParam` (#2, INT32).

| Opcode | UI control | Sender (file:line) | Client checks | Fields | Expected response |
|---|---|---|---|---|---|
| 8816 (0x2270) `C_NEW_YEAR_LOGIN` | Day claim button | `ContinuousLoginItem.__getRewardBtnHandler` (`ContinuousLoginItem.as:128-131`) → `NYS.sendGetReward(1, index)` (`NYS:16-23`) | enabled when `index <= loginNum` and `status != 1` | `opType = 1`, `opParam = day index 1..7` | 4704 with that day `statu = 1`; bag pushes |
| 8817 (0x2271) `C_NEW_YEAR_REBATE` | Rebate view shown (query) | `FunnyFrame` (`:533, 551, 720`) → `NYS.sendGetProfilt(0)` (`NYS:25-31`) | selected activity type 49 | `opType = 0` | 4707 |
| 8817 | "collect" button | `NewYearPayActView` (`:360-367`) → `sendGetProfilt(1)` | enabled when `payCount > getCount` (`:328`) | `opType = 1` | 4707 with `getCount + 1`; wallet push (bound diamonds) |
| 8818 (0x2272) `C_NEW_YEAR_LOTTERY` | Lottery frame opens | `NewYearLotteryFrame()` (`:69-76`) → `NYS.sendLotteryRequest()` (`NYS:33-40`) | none | `opType = 0`, `opParam = 0` | 4706 (pool) and 4708 (state) |
| 8818 | "open" button | `NewYearLotteryFrame` (`:270-288`) → `sendLotteryRequest(1)` | `lotteryCount > 0` else "lottery.LotteryFrame.noLeftCounts"; pool not empty | `opType = 1` | 4708 with `rewardItem`, `count`, `lotteryCount - 1`, `isMail` |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 4704 (0x1260) | U_C_NEW_YEAR_LOGIN | `active.LoginActiveMsg` | `NYM.__newYearLoginHandler` (`NYM:116, 123-161`) | Login during the event; after 8816 | `loginNum = login_count`; per `rewardInfos` sets day status; `isGetOver` true only when 7 entries are all status 1 (hides the tool bar button); fires `NEWYEARLOGINREFRESH` |
| 4705 (0x1261) | U_C_NEW_YEAR_LOGIN_ITEMS | `active.RewardItemMsg` | `NYM.__loginItemHandler` (`NYM:117, 163-184`) | Login during the event | Rebuilds the 7 day reward lists by `ItemMsg.param` (day) |
| 4706 (0x1262) | U_C_NEW_YEAR_LOTTERY_ITEMS | `active.RewardItemMsg` | `NYM.__lotteryItemHandler` (`NYM:118, 209-230`) | Response to 8818 op 0 (or login) | Builds the pool (`item_temp_id`, `count`), sorted by SonType then Profile |
| 4707 (0x1263) | U_C_NEW_YEAR_REBATE | `active.RebateAllInfosMsg` | `NYM.__newyearRebateHandler` (`NYM:119, 232-243`) | Response to 8817; push on spend | Fires `REFRESH_PAYACT` |
| 4708 (0x1264) | U_C_NEW_YEAR_LOTTERY | `active.ChargeLotteryMsg` | `NYM.__lotteryHandler` (`NYM:120, 245-260`) | Login, recharge, 8818 | Sets window, count, result; `PlayerModel.checkOpenNewYearLottery` (`PlayerModel.as:472-492`) shows the button inside the window unless `statu == 1` |
| 4422 | U_C_SWITCH | `switches.SwitchInfoListMsg` | `BaseManager.__switchesUpdateHandler` (`BaseManager.as:1561-1567`) | Switch id 2005 | `loginModel.isSwitch`, `starTime`, `endTime` gate the login button (`PlayerModel.checkOpenNewYearAct`, `:507-535`); see [../account/switches.md](../account/switches.md) |

Fields:

| Message | Fields |
|---|---|
| `LoginActiveMsg` | `login_count` (#1, INT32) days logged in; `begin_tm` (#2, STRING), `end_tm` (#3, STRING) not read; `rewardInfos` (#4, LoginRewardInfoMsg, repeated) |
| `LoginRewardInfoMsg` | `index` (#1, INT32) day 1..7; `statu` (#2, INT32) 1 claimed |
| `RewardItemMsg` | `itemInfos` (#1, ItemMsg, repeated) |
| `ItemMsg` | `item_temp_id` (#1, INT32); `count` (#2, INT32); `param` (#3, INT32) day index (login items) |
| `RebateAllInfosMsg` | `cur_PayPoint` (#1, INT32) today's spend; `cur_level` (#2, INT32) column 1..6; `pay_count` (#3, INT32) qualifying days; `get_count` (#4, INT32) collected days; `payInfos` (#5, PayInfoMsg, repeated) |
| `PayInfoMsg` | `day_num` (#1, INT32); `pay_point` (#2, INT32) |
| `ChargeLotteryMsg` | `begin_tm` (#1, STRING), `end_tm` (#2, STRING); `lottery_count` (#3, INT32) chests owned; `once_need_point` (#4, INT32) diamonds per chest; `defect_point` (#5, INT32) diamonds missing for the next chest; `rewardItem` (#6, INT32) drawn template (0 none); `count` (#7, INT32) drawn count; `statu` (#8, INT32) 1 closed; `isMail` (#9, BOOL) prize sent by mail |

---

## 5. Rules and formulas

- Login: `login_count` increments once per calendar day with a login inside the window; day N claimable when `N <= login_count`.
- Lottery: chests = `floor(event_recharge / once_need_point) - opened`; `defect_point = once_need_point - (event_recharge mod once_need_point)`; a draw picks one pool entry *(assumption: weighted server table)*; if the bag is full the prize is mailed (`isMail`).
- Rebate (sum-active type 49): config in `SumActiveinfoMsg.appendParam` = `"min@max@discount@maxDiamond$..."` (`NewYearPayActView.as:259-279`) mapping column ranges to discount and cap; rebate today = `min(ceil(cur_PayPoint * discount / 100), maxDiamond)` (`:282-292`); columns above 6 clamp to 6 (`:394-413`). The client throws if a column has no range, so the config must cover 1..6.
- Tool bar visibility requires `grades >= 11`.

---

## 6. Templates

None in XML. Pools and rewards are server data; the rebate table lives in the type 49 sum-active activity ([active-framework.md](active-framework.md)).

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.new_year_logins (
  window_id   integer  NOT NULL REFERENCES seasonal_events.event_windows(window_id),
  player_id   bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  login_days  smallint NOT NULL DEFAULT 0,
  last_login  date,
  claimed_days smallint[] NOT NULL DEFAULT '{}',
  PRIMARY KEY (window_id, player_id)
);

CREATE TABLE seasonal_events.new_year_lottery (
  window_id      integer NOT NULL,
  player_id      bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  recharge_total integer NOT NULL DEFAULT 0,
  opened         integer NOT NULL DEFAULT 0,
  PRIMARY KEY (window_id, player_id)
);

CREATE TABLE seasonal_events.new_year_rebate_days (
  window_id   integer NOT NULL,
  player_id   bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day_date    date    NOT NULL,
  pay_point   integer NOT NULL DEFAULT 0,
  collected   boolean NOT NULL DEFAULT false,
  PRIMARY KEY (window_id, player_id, day_date)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Notes |
|---|---|---|
| `seasonal_events::new_year::handle_login_reward` | 8816 | window (switch 2005) → day <= login days → not claimed → bag; 4704 |
| `seasonal_events::new_year::handle_rebate` | 8817 | op 0 → 4707; op 1 → `pay_count > get_count` → grant bound diamonds; 4707 |
| `seasonal_events::new_year::handle_lottery` | 8818 | op 0 → 4706 + 4708; op 1 → chests > 0 → roll → bag or mail; 4708 |

- Login hook: on first login of the day inside the window increment `login_days`, push 4705 (items) and 4704.
- Recharge hook: update lottery and push 4708; spend hook: update today's `pay_point`, push 4707.

---

## 9. Open questions and assumptions

- *(assumption)* Rebate day qualification ("payCount") and whether the last day can only collect (help text "no último dia só poderá devolver").
- *(assumption)* Lottery weights.
- `LoginActiveMsg.begin_tm/end_tm` unused; the window comes from switch 2005 instead.

---

## 10. Implementation checklist

- [ ] Switch 2005 and tool bar 2043, 2018
- [ ] Login frame, lottery frame, rebate view in "Destaques"
- [ ] 8816, 8817 (op 0, 1), 8818 (op 0, 1)
- [ ] 4704, 4705, 4706, 4707, 4708
- [ ] Tables `new_year_logins`, `new_year_lottery`, `new_year_rebate_days`
- [ ] Tests: claim day 3 with 2 login days, open chest with 0 chests, rebate cap
