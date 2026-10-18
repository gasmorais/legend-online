# Maçã Alegre (bingo, "开心宾果")

Path aliases:

| Alias | File |
|---|---|
| BGM | `decompiled/core_module/scripts/yishi/manager/BingoManager.as` |
| BGF | `decompiled/m11/scripts/bingo/BingoFrame.as` |
| BGB | `decompiled/core_module/scripts/yishi/view/frame/BingoBuyFrame.as` |
| BGR | `decompiled/m11/scripts/bingo/BingoResultFrame.as` |
| BGBALL | `decompiled/m11/scripts/bingo/BingoBallFrame.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| ENUM | `decompiled/core_module/scripts/com/road/yishi/proto/bingo/BingOpState.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A daily cross server bingo with diamonds. From 00:00 to 19:10 the player buys bets on numbered card groups ("grupos de cartas") in the shop "Loja da Maçã" (up to 4 groups, up to `bingo_buy[1]` = 100 bets each) and picks 2 lucky numbers. At 19:40 the server calls balls; the first three groups to complete a line, column or diagonal take 1st, 2nd and 3rd prize, paid in red crystals ("Cristais vermelhos", currency of the bingo shop). Help (`bingo.BingoHelpFrame.helpContent`) states the payout multipliers: 1st up to 20x the stake, 2nd up to 15x, 3rd up to 10x, minimum 1.5x; one lucky number hit x2, two lucky numbers x5, caps 100x, 75x, 50x; non winners get `bets * opened balls * 10` red crystals, x2 or x5 with lucky numbers. A second and third prize can only be drawn before the 24th ball. Pool grows with total purchases (`bingo_pond_addition`).

`BingOpState` (ENUM): SYNC_DATA 0, REQUEST_BUY 1, RESPONSE_BUY 2, CONFIRM_BUY 3, LOTTERY_NOTITY 4, REWARD 5, UPDATE_DATA 6, MESSAGE_FORWARD 7.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `bingo.BingoFrame` (BGF) | "Maçã Alegre" | Ball machine, called numbers, my bets per card group, current pool with tip "{0}.Ao acumular compra de todos os membros atingindo {1} diamantes, irá aumentar mais cristais vermelhos x{2}" (`bingo_pond_addition`), ranking tips "Prêmio de Conjuntos de cartas: {0}" for 1st..3rd | Top toolbar `bingo` (TopToolBtnInfos 2032 "开心宾果") -> `openControllerByInfo("bingo")` (`TopToolsBar.as:1290-1292`) | 386 op 0 |
| `shop.BingoShopFrame` | "Loja da Maçã" | Card groups for sale and red crystal goods (owner [../shops/README.md](../shops/README.md), `ShopControler.as:133`) | BGF | |
| `yishi.view.frame.BingoBuyFrame` (BGB) | buy | Quantity (`1 .. bingo_buy[1]`), price `bingo_buy[0] * n` diamonds, 2 lucky numbers | shop card item | |
| `bingo.BingoResultFrame` (BGR) | "Detalhes dos prêmios" | History snaps per day: total pool, prize category ("Categoria do Prêmio"), red crystals per bet, bets of the prize | BGF | `snapDataArr` |
| `bingo.BingoBallFrame` | "Número já saiu" | Called numbers | BGF | |

Toolbar visibility: `ConfigManager.info.BINGO && grades >= 11 && BINGO_BEGIN_DATE <= now < BINGO_END_DATE` (TBH:293-294); from push 4422 entry `switchType 3068` (BM:1590-1595), owner [../account/switches.md](../account/switches.md).

## 3. Routes (client to server)

All routes: C>S 9625 (0x2599) `C_BINGO`, body `bingo.BingoOpMsg`: `op` (#1, ENUM BingOpState); `uuid` (#2, STRING); `user_id` (#3, INT32); `nick_name` (#4, STRING); `server_name` (#5, STRING); `param_msg` (#6, BYTES); `param1` (#7, INT32); `param2` (#8, INT32); `param3` (#9, STRING); `param4` (#10, STRING, repeated); `res_data` (#11, `BingoRespMsg`). Sender `BingoManager.OperateBingo(op, param1, param2, param3)` (BGM:287-296).

| # | op | Action | UI | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|---|
| R1 | 0 | Sync | BGF open (BGF:124) | none | none | 386 op 0 |
| R2 | 1 | Buy bets | BGB confirm (BGB:173-206) | price <= diamonds else recharge; the two lucky numbers differ else "Não é possível de selecionar os mesmos números da sorte"; quantity clamped 1..`bingo_buy[1]` (BGB:221-240) | `param1` card group id, `param2` bet count, `param3` `"lucky1,lucky2"` | 386 op 1, 3 |

## 4. Server messages (server to client)

### S1. 386 (0x0182) `U_C_BINGO`
- `bingo.BingoOpMsg` with `op` and `res_data` (#11, `BingoRespMsg`: `result` (#2, BOOL); `data` (#3, BYTES) an embedded message decoded by `op`).
- Receiver: `BingoManager.__bingoHandler` (BGM:79-197):

| op | `data` decoded as | Client effect |
|---|---|---|
| 0 SYNC_DATA | `BingoDataMsg` | full state: buys, global buys, pool, card templates of today, current result, history (BGM:97-134) -> `BALL_TEMP_UPDATE` |
| 1 REQUEST_BUY | `BingoDataMsg` | `buy_info`, `globalBuyInfo`, `current_pond` -> `BALL_BUY` |
| 4 LOTTERY_NOTITY | `BingoLotteryNotifyMsg` | one called ball (`called_num`), `luck_num` flag, partial `BingoResultDataMsg` -> `BALL_START` animation (BGM:169-197) |
| 6 UPDATE_DATA | `BingoDataMsg` | result and history refresh (BGM:135-159) |
| 5 REWARD | `BingoRewardMsg` | no client handler (assumption: mail or chat) |

- `BingoDataMsg`: `data_info` (#1, `BingoInfoDataMsg`: `current_data` (#1, `BingoInfoMsg`), `historyData` (#2, `BingoInfoMsg` repeated)); `buy_info` (#2, `BingoBuyInfoMsg`); `globalBuyInfo` (#3, `BingoGlobalBuyInfoMsg` repeated: `card_id` (#1), `amount` (#2)); `current_pond` (#4, INT32); `state` (#5, INT32); `current_data_result` (#6, `BingoResultDataMsg`).
- `BingoInfoMsg`: `event_data` (#1, STRING) day; `cardTemp` (#2, `BingoCardTempMsg` repeated: `card_id` (#1), `cardNum` (#2, INT32 repeated) numbers of the card); `result_data` (#3, `BingoResultDataMsg`); `result_snap` (#4, `BingoResultSnapMsg`: `event_date` (#1), `tatal_pond` (#2, INT32), `lotteryPlayer` (#3, `BingoRankPlayerMsg` repeated: `rank` (#1), `player` (#2, STRING repeated))).
- `BingoBuyInfoMsg`: `uuid` (#1), `user_id` (#2), `nick_name` (#3), `server_name` (#4), `event_date` (#5), `detail` (#6, `BingoBuyDetailMsg` repeated: `card_id` (#1), `amount` (#2) bets, `luckNum` (#3, INT32 repeated)).
- `BingoResultDataMsg`: `event_date` (#1); `lotteryNum` (#2, INT32 repeated) called balls in order; `luckNum` (#3, INT32 repeated); `rankData` (#4, `BingoRankDataMsg` repeated: `rank` (#1), `card_Id` (#2, INT32 repeated) winning groups).
- `BingoLotteryNotifyMsg`: `called_num` (#1, INT32); `luck_num` (#2, BOOL); `data` (#3, `BingoResultDataMsg`).
- `BingoRewardMsg` (op 5): `result_data` (#1), `detail_data` (#2, `BingoBuyDetailMsg`), `buy_pond` (#3), `addition_pond` (#4), `total_pond` (#5), `rank` (#6), `total_winning` (#7), `radio` (#8), `reward` (#9), `hit_lucky_num` (#10), `hit_num` (#11) (all INT32 except the first two).
- `BingoReward`: `user_id` (#1), `card_id` (#2), `amount` (#3), `reward` (#4), `rank` (#5) (server side record, unused by the client).

## 5. Rules and formulas

`raw/xml/tempinfos/ConfigInfos.xml`:

| Config | Value | Meaning |
|---|---|---|
| `bingo_buy` | 50,100 | diamonds per bet, max bets per card group |
| `bingo_time` | 00:00,19:10,19:40 | buy start, buy end, draw time |
| `bingo_pond_init` | 3000 | initial pool (red crystals) |
| `bingo_pond_addition` | 10000,500\|20000,800\|30000,1000 | when total purchases reach N diamonds, add M red crystals to the pool |
| `bingo_base_luck_reward` | 10 | base consolation per opened ball |
| `bingo_p_limit` | 1000,750,500 | multiplier caps (x10 scale: 100x, 75x, 50x) |

- B1. Level 11 and switch 3068 window.
- B2. At most 4 card groups per player, up to 100 bets per group, 2 distinct lucky numbers per group.
- B3. Draw at 19:40: balls called one by one (push op 4); a card group wins when a row, column or diagonal is complete; ranks 1..3 in completion order; 2nd and 3rd only before the 24th ball; then the game ends.
- B4. Prize share of the pool proportional to the winners' stakes, capped (help line 4); lucky number multipliers x2 / x5; consolation for non winners `bets * openedBalls * 10`, x2 or x5.
- B5. Rewards in red crystals (currency of shop "Loja da Maçã"), delivered after the draw (assumption: direct credit plus mail summary).

## 6. Templates

`ConfigInfos.xml` above. Card group layouts (`cardTemp`) are server data sent in op 0.

## 7. Persistent state

```sql
CREATE TABLE casino.bingo_day (
  event_date   DATE        PRIMARY KEY,
  pool         INTEGER     NOT NULL DEFAULT 3000,
  called       SMALLINT[]  NOT NULL DEFAULT '{}',
  drawn_at     TIMESTAMPTZ
);

CREATE TABLE casino.bingo_card (
  event_date  DATE       NOT NULL REFERENCES casino.bingo_day(event_date) ON DELETE CASCADE,
  card_id     INTEGER    NOT NULL,
  numbers     SMALLINT[] NOT NULL,
  prize_rank  SMALLINT,
  PRIMARY KEY (event_date, card_id)
);

CREATE TABLE casino.bingo_bet (
  event_date  DATE       NOT NULL,
  player_id   BIGINT    NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  card_id     INTEGER    NOT NULL,
  bets        INTEGER    NOT NULL CHECK (bets BETWEEN 1 AND 100),
  lucky       SMALLINT[] NOT NULL CHECK (array_length(lucky, 1) = 2),
  reward      INTEGER,
  PRIMARY KEY (event_date, player_id, card_id),
  FOREIGN KEY (event_date, card_id) REFERENCES casino.bingo_card(event_date, card_id)
);
CREATE INDEX bingo_bet_card_idx ON casino.bingo_bet (event_date, card_id);
```

## 8. Backend implementation notes

- `casino::bingo::handle_op` (9625): op 0 `handle_sync` (reply 386 op 0 with today and history); op 1 `handle_buy` (time in buy window -> card exists -> player groups <= 4 -> bets total <= 100 per group -> lucky numbers distinct and on the card -> diamonds; debit, upsert bet, pool additions; reply 386 op 1, 3; push op 1 global buys to viewers).
- Daily job 19:40: draw balls, push op 4 per ball (interval for animation, assumption 3 s) to all online players with the event, compute ranks, pay rewards, write `bingo_day.drawn_at`, push op 6. Job 00:00: create the next `bingo_day` and its cards.
- Cross server: the original pool is cross server (`server_name` fields); single server deployment uses a local pool.

## 9. Open questions and assumptions

- Assumption: ball interval and number range (1..75 typical; the client only displays numbers).
- Open: exact payout formula combining pool share and caps; implement from the help text.
- Open: op 5 REWARD push has no client handler.

## 10. Implementation checklist

- [ ] Screens `BingoFrame`, shop, buy, result, balls
- [ ] Route 9625 op 0, op 1
- [ ] Message 386 ops 0, 1, 4, 6; switch 3068
- [ ] Tables `bingo_day`, `bingo_card`, `bingo_bet`
- [ ] Draw job and payouts
- [ ] Test: purchase after 19:10 refused; 5th group refused; equal lucky numbers refused
