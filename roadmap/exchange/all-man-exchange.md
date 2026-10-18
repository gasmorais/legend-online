# Troca geral (all-man exchange)

Path aliases:

| Alias | File |
|---|---|
| AEM | `decompiled/core_module/scripts/yishi/manager/AllManExchangeManager.as` |
| AEO | `decompiled/core_module/scripts/mvc/module/allmanexchange/AllManExchangeModel.as` |
| AEC | `decompiled/core_module/scripts/mvc/controler/AllManExchangeController.as` |
| AEF | `decompiled/m11/scripts/allmanexchange/AllManExchangeFrame.as` |
| BIG | `decompiled/m11/scripts/allmanexchange/item/AllManExchangeBigBox.as` |
| SML | `decompiled/m11/scripts/allmanexchange/item/AllManExchangeSmallBox.as` |

## 1. Overview

A cross server event ("全民兑换"). The player trades an event item (`changeItem`) into one of 3 boxes; each trade adds 1 to 5 random points to that box and to the server wide total ("Pontuação inter-servidor"). A box whose points reach its requirement gives a box reward, a limited number of times per event. When the server wide total reaches each of 5 thresholds, every participating player can claim the matching shared reward. Help (`allmainexchange.str11`): "cada vez que você trocar, você recebe de 1 a 5 pontos aleatoriamente ... após a Pontuação inter-servidor atingir os requisitos correspondentes, todos os jogadores participantes podem receber as recompensas".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `allmanexchange.AllManExchangeFrame` (`AEF`) | "Troca geral" (`allmainexchange.str1`, `AEF:243-247`) | Background image `RESOURCE_PATH + "allmanexchange.jpg"` (`AEF:112-128`); countdown to `end` (`AEF:181-186`); "Nº de trocas restantes: {0}/{1}" hidden when `allChangeCount == 0` (`AEF:198-202`); total score; 3 big boxes and 5 small boxes (`AEF:130-157`); server score bar masked by thresholds (`AEF:211-226`); event item icon with the count in bag plus storehouse (`AEF:227-230`); help "Instruções da Troca geral" | top toolbar `allmanexchange` -> `AllManExchangeController` (`AEC:20-34`); sends op 3 on build (`AEF:107`) | `AllManExchangeModel` |
| `AllManExchangeBigBox` (`BIG`) | box 1..3 | Progress `point/changeNeedPoint`, "(Nº de prêmios a coletar: {0}/{1})" (red when 0), "Nº de trocas:" input, "Trocar" or "Coletar" when full (`BIG:83-110`); tip with "Obtém:" and "Pode obter:" lists (`AEO:128-162`) | frame | `point[i]`, `changeNeedPoint[i]`, `boxChangeCount[i]`, `exchangeCount[i]`, `boxAward` |
| `AllManExchangeSmallBox` (`SML`) | shared reward 1..5 | Threshold `allPointAward[i]`, label "Disponível"; frame 1 not reached, 2 claimable, 3 claimed (`SML:84-103`); tip with the item list (`AEO:164-182`) | frame | `allPoint`, `allPointAward[i]`, `serverAwardState[i]`, `serverAward` |

## 3. Routes (client to server)

All routes use C>S 9007 (0x232f) `C_ALL_CHANGE_OP` with `CommonMsg` (package `player`): `param1` (#1, INT32) operation, `param2` (#2, INT32), `param3` (#3, INT32); `param4..param7` unused (`AEM:57-83`).

| # | Action | UI and sender | Client checks | `param1`, `param2`, `param3` | Expected reply |
|---|---|---|---|---|---|
| R1 | Open | frame build -> `AllManExchangeManager.sendOpenView` (`AEF:107`, `AEM:57-63`) | none | 3, 0, 0 | 4955 full state |
| R2 | Trade into a box | "Trocar" -> `BIG.onClickExchange` (`BIG:136-151`) -> `sendExchangePoint(index, count)` (`AEM:75-83`) | count input clamped to `max(changeNeedPoint[i] - point[i], 1)` (`BIG:126-134`); count <= `allChangeCount - changeItemCount` unless `allChangeCount == 0`, else "Trocas restantes insuficientes" (`allmainexchange.str7`); `boxChangeCount[i] - exchangeCount[i] > 0`, else "O nº de prêmios foi usado, não pode ser mais ser trocado." (`str9`) | 2, box index 0..2, count | 4955 partial, 115 |
| R3 | Claim a box reward | "Coletar" -> `BIG.onClickGetAward` (`BIG:153-161`) -> `sendGetAward(1, index)` (`AEM:65-73`) | claims left > 0 else "Nº de coletas insuficiente" (`str6`) | 1, 1, box index 0..2 | 4955 partial, 115 |
| R4 | Claim a shared reward | small box click -> `SML.onClickGet` (`SML:69-82`) -> `sendGetAward(2, index)` | frame 1 -> "O progresso não foi alcançado" (`str10`); frame 3 -> "Prêmio coletado" (`str8`) | 1, 2, reward index 0..4 | 4955 partial, 115 |

## 4. Server messages (server to client)

### S1 4955 (0x135b) U_C_ALL_CHANGE

- `AllExchangeMsg` (package `active`). Every field is optional and the client only overwrites fields that are present (`AEO:52-126`), so replies may be partial. Lists are comma separated strings.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `id` | 1 | STRING | event id |
| `begin` | 2 | STRING | start `YYYY-MM-DD hh:mm:ss` |
| `end` | 3 | STRING | end, drives the countdown |
| `isopen` | 4 | BOOL | event open; a change toggles the toolbar icon (`AEO:66-73`) |
| `allPoint` | 5 | INT32 | server wide (cross server) point total |
| `boxChangeCount` | 6 | STRING | "a,b,c" max claims per box |
| `allChangeCount` | 7 | INT32 | daily trade limit, 0 = unlimited |
| `changeNeedPoint` | 8 | STRING | "a,b,c" points needed per box claim |
| `point` | 9 | STRING | "a,b,c" current points per box |
| `exchangeCount` | 10 | STRING | "a,b,c" claims used per box |
| `totalExchangeCount` | 11 | STRING | stored, not displayed |
| `serverAwardState` | 12 | STRING | "s0,..,s4", 1 = claimed |
| `changeItemCount` | 13 | INT32 | trades used today |
| `allPointAward` | 14 | STRING | "t0,..,t4" server total thresholds |
| `boxAward` | 15 | AllExchangeItemInfoMsg, repeated | box rewards: `index` (#1, INT32) box 1..3, `itemId` (#2, INT32), `itemCount` (#3, INT32), `randomType` (#4, INT32) 1 = guaranteed ("Obtém:"), other = random ("Pode obter:") |
| `serverAward` | 16 | AllExchangeItemInfoMsg, repeated | shared rewards, `index` 1..5 |
| `changeItem` | 17 | INT32 | event item template consumed by trades |

- Receiver `AllManExchangeManager.receiveInfo` (`AEM:43-50`) -> `model.update` -> `UPDATE_INFO` -> `AEF.updateInfo` (`AEF:193-231`).
- When: push at login (at least `isopen`, so the toolbar icon is right), push on open and close of the event to all online players, full reply to R1, partial replies to R2..R4. Assumption: a periodic push of `allPoint` (every 60 s) to players with the frame open.
- Note: the frame reads `allPointAward[i]`, `point[i]` and the other lists without guards (`AEF:211-226`, `BIG:100-110`); the first message seen by an opened frame must contain every list.

## 5. Rules and formulas

- G1 Open window: `begin <= now < end` and `isopen`. Level gate: none in the client (assumption: none).
- G2 Trade cost: 1 `changeItem` per trade (assumption; no count field exists). The client shows the count held in bag plus storehouse (`getBagCountInPlayerAndStoneByTempId`), so the server may consume from both.
- G3 Points: each trade adds `rand(1..5)` to `point[i]` and to `allPoint` (help).
- G4 Daily trade cap: `changeItemCount < allChangeCount` per day when `allChangeCount > 0`; reset at 00:00 (assumption).
- G5 Box claim: `point[i] >= changeNeedPoint[i]` and `exchangeCount[i] < boxChangeCount[i]`; then `exchangeCount[i] += 1` and `point[i] -= changeNeedPoint[i]` (assumption: the remainder carries over). Rewards: every `randomType 1` item of box `i+1` plus one random item among the others (assumption).
- G6 Shared reward: `allPoint >= allPointAward[i]`, not yet claimed, and the player traded at least once in the event (assumption from "jogadores participantes"); then `serverAwardState[i] = 1`.
- G7 Trades into a box with no claim left are refused (client check `str9`).

## 6. Templates

None in the client; the event is server data. Background resource `allmanexchange.jpg` under the client resource path.

## 7. Persistent state

```sql
CREATE TABLE exchange.all_event (
  event_id             TEXT         PRIMARY KEY,
  begins_at            TIMESTAMPTZ  NOT NULL,
  ends_at              TIMESTAMPTZ  NOT NULL,
  change_item_id       INTEGER      NOT NULL,
  daily_trade_limit    INTEGER      NOT NULL DEFAULT 0 CHECK (daily_trade_limit >= 0),
  box_need_points      INTEGER[]    NOT NULL CHECK (cardinality(box_need_points) = 3),
  box_claim_limit      INTEGER[]    NOT NULL CHECK (cardinality(box_claim_limit) = 3),
  server_award_points  INTEGER[]    NOT NULL CHECK (cardinality(server_award_points) = 5),
  points_min           SMALLINT     NOT NULL DEFAULT 1,
  points_max           SMALLINT     NOT NULL DEFAULT 5,
  CHECK (ends_at > begins_at)
);

CREATE TABLE exchange.all_award (
  event_id      TEXT      NOT NULL REFERENCES exchange.all_event(event_id) ON DELETE CASCADE,
  kind          SMALLINT  NOT NULL CHECK (kind IN (1, 2)),
  award_index   SMALLINT  NOT NULL CHECK (award_index BETWEEN 1 AND 5),
  seq           SMALLINT  NOT NULL,
  item_id       INTEGER   NOT NULL,
  item_count    INTEGER   NOT NULL CHECK (item_count > 0),
  random_type   SMALLINT  NOT NULL DEFAULT 1,
  weight        INTEGER   NOT NULL DEFAULT 1,
  PRIMARY KEY (event_id, kind, award_index, seq)
);

CREATE TABLE exchange.all_player (
  event_id         TEXT       NOT NULL REFERENCES exchange.all_event(event_id) ON DELETE CASCADE,
  player_id        INTEGER    NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  box_points       INTEGER[]  NOT NULL DEFAULT '{0,0,0}',
  box_claims       INTEGER[]  NOT NULL DEFAULT '{0,0,0}',
  server_claimed   BOOLEAN[]  NOT NULL DEFAULT '{f,f,f,f,f}',
  trade_day        DATE       NOT NULL,
  trades_today     INTEGER    NOT NULL DEFAULT 0,
  total_trades     INTEGER    NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE exchange.all_total (
  event_id       TEXT    PRIMARY KEY REFERENCES exchange.all_event(event_id) ON DELETE CASCADE,
  total_points   BIGINT  NOT NULL DEFAULT 0
);
```

`kind`: 1 box reward (`award_index` 1..3), 2 shared reward (1..5).

## 8. Backend implementation notes

- `exchange::all_man::handle_op` (9007) dispatches on `param1`:
  - `exchange::all_man::handle_open` (3): reply 4955 with every field.
  - `exchange::all_man::handle_trade` (2): event open -> box index 0..2 -> count >= 1 -> daily cap -> box claims left -> items in bag/storehouse >= count. Transaction: lock `all_player`, consume, roll points per trade, update `box_points`, `trades_today`, `total_trades`; `UPDATE exchange.all_total SET total_points = total_points + gained`. Reply 4955 with `point`, `changeItemCount`, `allPoint`, then 115.
  - `exchange::all_man::handle_claim` (1): `param2 = 1` box claim (G5) or `2` shared claim (G6). Transaction: grant rewards, update state. Reply 4955 with `point`, `exchangeCount` or `serverAwardState`, then 115.
- Cross server total: the original sums every server ("inter-servidor"). Local implementation: `exchange.all_total` per server; a cross server deployment replaces it with the cross server service ([../cross-server/README.md](../cross-server/README.md)).
- Scheduler: open and close events, push `isopen`; daily reset of `trades_today` (lazy by `trade_day`).
- Login: push 4955 with `isopen` (and the full state when open).

## 9. Open questions and assumptions

- Assumption: 1 item per trade, remainder carry over on claims, random reward pick, participation rule for shared rewards, daily reset at 00:00.
- Open: original reward tables and thresholds (server data).
- Open: whether `allPoint` is a sum over servers or over the local server only in single server deployments.

## 10. Implementation checklist

- [ ] Screen: AllManExchangeFrame, big and small boxes
- [ ] Route 9007 op 3 open
- [ ] Route 9007 op 2 trade
- [ ] Route 9007 op 1 claim (box and shared)
- [ ] Server message 4955 (full and partial)
- [ ] Tables `exchange.all_event`, `exchange.all_award`, `exchange.all_player`, `exchange.all_total`
- [ ] Rules G1..G7
- [ ] Login push of `isopen`
- [ ] Test: daily trade cap, box claim limit, shared reward once per player
- [ ] Test: frame opened with a partial first message does not crash (server always sends full state on op 3)
