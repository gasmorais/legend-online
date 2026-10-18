# Grande prêmio da Alegria (lucky lottery, "欢乐中大奖")

Path aliases:

| Alias | File |
|---|---|
| LLM | `decompiled/core_module/scripts/managers/LuckyLotteryManager.as` |
| LLMOD | `decompiled/core_module/scripts/mvc/module/luckylottery/LuckyLotteryModel.as` |
| LLF | `decompiled/m11/scripts/luckylottery/LuckyLotteryFrame.as` |
| LLL | `decompiled/m11/scripts/luckylottery/LuckyLotteryLeftItem.as` |
| LLG | `decompiled/m11/scripts/luckylottery/LuckyLotteryGoodsItem.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed event with a personal finite prize pool ("bolo de prêmio"). The pool has 4 tiers (`label` 1..4), each with several prizes (`index`), each prize with a stock `maxNum`. Each draw consumes `onceCostItemNum` units of an event item and takes prizes out of the pool. The grand prize is `label 1, index 1`. When the grand prize stock is exhausted the player can refill ("Renovar") the pool a limited number of times. Rules text (`LuckyLotteryFrame.ruleDescTxt`): "1. Os jogadores podem gastar os itens indicados para realizar sorteios e obter os itens do bolo à esquerda; 2. Quando os prêmios se esgotarem os jogadores podem clicar no botão Renovar para preencher o bolo novamente; 3. Não é possível sortear novamente sem realizar a renovação caso todos os prêmios tenham sido sorteados;".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `luckylottery.LuckyLotteryFrame` (LLF), 885x645 | "Grande prêmio da Alegria" (`LuckyLotteryFrame.title`, LLF:325) | Left: 4 tier rows (`LuckyLotteryLeftItem` type 1..4, LLF:213-230) each listing prizes sorted by `index` with `currentNum/maxNum` and a highlight on the prizes won by the last draw (LLG:55-80); grand prize icon with `currentNum/maxNum`; refresh button with a glow when enabled; cost item icon and bag count; draw count input (1..50); draw button; countdown; refreshes left | Top toolbar `luckylottery` (TopToolBtnInfos 2056 "欢乐中大奖", tip "Grande prêmio da Alegria"); click refused with "Evento encerrado" when `now > endDate` (TTB:1456-1463, 1558-1568) | "Cada sorteio gasta {0}" with `onceCostItemNum` (LLF:238); countdown "remainTime03" to `endDate` (LLF:242-249, 280-285); "Atualizações do bolo de prêmio restantes:{0}" = `refreshTimes - refreshedTimes` (LLF:250-252) |

Toolbar visibility: `VersionSwitch.LUCKY_LOTTERY` (true) and `openLuckyLottery` from 462 (TBH:383-384).

## 3. Routes (client to server)

All routes: C>S 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP` with header `extend1 = 34` (`new PackageOut(9645, 0, 34)`), body `cccactive.LuckyLotteryOpMsg`: `opType` (#1, INT32) 1 draw, 2 refresh, 3 open frame (`LLMOD:8-12`); `times` (#2, INT32) number of draws (default 1). Sender `LuckyLotteryManager.frameOperation(opType, times = 1)` (LLM:150-157).

### R1. Open (opType 3)
- UI: frame constructor (LLF:83).
- Expected response: 4893 `U_C_LUCKY_LOTTERY_RECORD_RESP` (S2).

### R2. Draw (opType 1)
- UI: draw button `__extractionBtnHandler` (LLF:301-311).
- Client checks: count input clamped to `1 .. min(50, max(1, floor(bagCount / onceCostItemNum)))` (LLF:199-211); bag count of `costItemId` >= `times * onceCostItemNum`, else tip "Os Items na Mochila necessários não são suficientes" (LLF:303-307).
- Fields: `opType 1`, `times` = count.
- Expected response: bag update 115 (cost item consumed, prizes added), then 4892 `U_C_LUCKY_LOTTERY_RESP` (S3).

### R3. Refresh the pool (opType 2)
- UI: refresh button (LLF:295-299), enabled only when the grand prize `currentNum == maxNum` and refreshes left > 0 (LLF:257-262).
- Expected response: 4893 (S2) with the new pool and `refreshedTimes + 1`.

## 4. Server messages (server to client)

### S1. 462 (0x01ce) `U_C_LUCKY_LOTTERY_OPENSTATE`
- `PropertyMsg` (package `simple`): `param4` (#4, STRING) start "YYYY-MM-DD hh:mm:ss"; `param5` (#5, STRING) end; `param7` (#7, BOOL) open.
- Receiver: `LuckyLotteryManager.__openStateHandler` (LLM:139-148) -> `REFRESH_TOPTOOLS`.
- When: login and event start or end.

### S2. 4893 (0x131d) `U_C_LUCKY_LOTTERY_RECORD_RESP`
- `cccactive.LuckyLotteryRecordMsg`: `costItemId` (#1, INT32) item consumed per draw; `onceCostItemNum` (#2, INT32) units per draw; `needTimes` (#3, INT32) stored as `refreshNeedTimes`, not displayed; `begintime` (#4, STRING) unused; `endtime` (#5, STRING) unused; `itemInfos` (#6, `ItemInfoMsg`, repeated); `refreshTimes` (#7, INT32) refreshes allowed; `refreshedTimes` (#8, INT32) refreshes used.
- `ItemInfoMsg`: `label` (#1, INT32) tier 1..4; `index` (#2, INT32) position in the tier (1 = first); `maxNum` (#3, INT32) stock; `currentNum` (#4, INT32) units already drawn; `tempId` (#5, INT32) item template; `gainNum` (#6, INT32) item count per hit.
- Receiver: `LuckyLotteryManager.__lotteryRecordHandler` (LLM:105-137): rebuilds the pool, remembers the grand prize (`label 1, index 1`), notifies `LUCKY_LOTTERY_RECORD` -> `__refreshView` (LLF:232-278).
- When: reply to R1 and R3.

### S3. 4892 (0x131c) `U_C_LUCKY_LOTTERY_RESP`
- `cccactive.LuckyLotteryRespMsg`: `records` (#1, `RecordMsg`, repeated): `label` (#1, INT32), `index` (#2, INT32), `curNum` (#3, INT32) new drawn count of that prize.
- Receiver: `LuckyLotteryManager.__lotteryRespHandler` (LLM:58-89): clears all highlights, sets `currentNum` and `selected` on each listed prize (and on the grand prize when listed), notifies `LUCKY_LOTTERY_RECORD`.
- When: reply to R2, one record per distinct prize hit by the draws.

## 5. Rules and formulas

- B1. Visible while the event is open; no level check in the client.
- B2. Draw cost: `times * onceCostItemNum` of `costItemId`; `times` 1..50 per request.
- B3. Each draw picks one prize with remaining stock (`currentNum < maxNum`) and increments `currentNum` (assumption: weights proportional to the remaining stock, tier 1 rarest).
- B4. When every prize is exhausted a draw is refused until a refresh (rule 3).
- B5. Refresh allowed when the grand prize is exhausted (`currentNum == maxNum`, client condition) and `refreshedTimes < refreshTimes`; it resets every `currentNum` to 0 (assumption: also when other prizes still have stock, which matches the client condition).
- B6. Period: event `begintime`..`endtime`; the toolbar click checks `endDate` from 462.

## 6. Templates

None on the client. Pool definition (tiers, items, stock, cost item, refresh count) is server data.

## 7. Persistent state

```sql
CREATE TABLE lotteries.joy_event (
  event_id        SERIAL      PRIMARY KEY,
  starts_at       TIMESTAMPTZ NOT NULL,
  ends_at         TIMESTAMPTZ NOT NULL,
  cost_item_id    INTEGER     NOT NULL,
  cost_per_draw   INTEGER     NOT NULL CHECK (cost_per_draw > 0),
  refresh_limit   INTEGER     NOT NULL CHECK (refresh_limit >= 0),
  refresh_need    INTEGER     NOT NULL DEFAULT 0
);

CREATE TABLE lotteries.joy_prize (
  event_id    INTEGER  NOT NULL REFERENCES lotteries.joy_event(event_id) ON DELETE CASCADE,
  tier        SMALLINT NOT NULL CHECK (tier BETWEEN 1 AND 4),
  position    SMALLINT NOT NULL CHECK (position >= 1),
  item_id     INTEGER  NOT NULL,
  item_count  INTEGER  NOT NULL CHECK (item_count > 0),
  stock       INTEGER  NOT NULL CHECK (stock > 0),
  weight      INTEGER  NOT NULL CHECK (weight > 0),
  PRIMARY KEY (event_id, tier, position)
);

CREATE TABLE lotteries.joy_player (
  event_id         INTEGER NOT NULL REFERENCES lotteries.joy_event(event_id) ON DELETE CASCADE,
  player_id        INTEGER NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  refreshes_used   INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE lotteries.joy_player_prize (
  event_id   INTEGER  NOT NULL,
  player_id  INTEGER  NOT NULL,
  tier       SMALLINT NOT NULL,
  position   SMALLINT NOT NULL,
  drawn      INTEGER  NOT NULL DEFAULT 0 CHECK (drawn >= 0),
  PRIMARY KEY (event_id, player_id, tier, position),
  FOREIGN KEY (event_id, player_id) REFERENCES lotteries.joy_player(event_id, player_id) ON DELETE CASCADE,
  FOREIGN KEY (event_id, tier, position) REFERENCES lotteries.joy_prize(event_id, tier, position) ON DELETE CASCADE
);
```

## 8. Backend implementation notes

- 9645 dispatcher by header `extend1`; `extend1 = 34` -> `lotteries::joy::handle_op`, which dispatches on `opType`:
  - 3 `lotteries::joy::handle_open`: create `joy_player` lazily; reply 4893.
  - 1 `lotteries::joy::handle_draw`: event open -> `1 <= times <= 50` -> bag count >= `times * cost_per_draw` -> pool not empty -> bag space. Transaction: consume items, roll `times` draws (stop early when the pool empties), update `joy_player_prize.drawn`, grant items. Reply 115 then 4892 with one record per distinct prize.
  - 2 `lotteries::joy::handle_refresh`: grand prize exhausted -> `refreshes_used < refresh_limit`. Transaction: reset `drawn`, increment `refreshes_used`. Reply 4893.
- Push 462 at login and on event start or end.

## 9. Open questions and assumptions

- Assumption: draw weights follow the remaining stock; rarity per tier is server data.
- Assumption: `needTimes` (stored as `refreshNeedTimes`) is a minimum number of draws before a refresh; the client never shows or checks it.
- Open: whether a single request may continue across an exhausted pool (assumption: no, the server stops and grants only the draws done, consuming only their cost).

## 10. Implementation checklist

- [ ] Screen `LuckyLotteryFrame` from the toolbar with the end date check
- [ ] Route 9645/34 opType 3 -> 4893
- [ ] Route 9645/34 opType 1 -> 115, 4892
- [ ] Route 9645/34 opType 2 -> 4893
- [ ] Push 462 at login and on event changes
- [ ] Tables `joy_event`, `joy_prize`, `joy_player`, `joy_player_prize`
- [ ] Rules B2..B5
- [ ] Test: 50 draws cap, insufficient items refused
- [ ] Test: refresh refused while the grand prize has stock
