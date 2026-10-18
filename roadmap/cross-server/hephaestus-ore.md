# Hephaestus ore ("Minério de Hefesto")

Aliases:

| Alias | File |
|---|---|
| SOM | `decompiled/core_module/scripts/managers/StokesOreManager.as` |
| SOMOD | `decompiled/core_module/scripts/mvc/module/stokesore/StokesOreModel.as` |
| SOF | `decompiled/m11/scripts/stokesore/StokesOreFrame.as` |
| SOT | `decompiled/m11/scripts/stokesore/StokesOreTopItem.as` |
| SOD | `decompiled/m11/scripts/stokesore/StokesOreDropItem.as` |

## 1. Overview

A diamond lottery with cross-server shared progress (code name "stokes ore", 斯托斯矿石; TopToolBtnInfos 2057 "赫菲斯托斯的矿石"). Players pay diamonds (or the item 208523) to mine once or ten times. Every mine grants a random item from the pool and advances a shared mining sequence (`curSeq`); when the sequence reaches one of the 5 floor thresholds the miner gets that floor's extra treasure by mail, limited per day. When all floors are passed the round ends, a countdown starts and a new round begins. The number of rounds per day is limited.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `stokesore.StokesOreFrame` (SOF) | help "Intruções de ajuda de Minério de Hefesto"; "Contagem para a próxima rodada: {0}"; check box "Uso prioritário de {0}" (item 208523 name, `SOF:217-219`) | Mine once / ten, progress bar with 5 floors, today's remaining rounds and remaining special prizes, own results list, global lucky list, pool items | top bar `stokesore` | 188, 189, 187 data; event dates "toptoolbar.topBtn.tipData" + start, "MonthCardGiftItem.overActive.text" + end (`SOF:538-539`) |
| `StokesOreTopItem` (SOT) | "{0}ª extração inter-servidor" | Floor marker; tooltip `StokesOreGoodsShowTip` with the floor rewards (`SOT:45-49`) | SOF | `goodsDic[layer]` |
| `StokesOreDropItem` (SOD) | | Pool item cell, 5 per row sorted by quality, son type, id (`SOF:541-620`) | SOF | `goodsDic[0].rewards` |

Progress bar mapping (`SOMOD:170-233`): x = `40 * seq / floor1` before floor 1, then 135 px per floor segment (`floor2 - floor1` etc.), 580 at the last floor.

## 3. Routes (client to server)

All routes: C>S 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`, header `extend1 = 35` (`new PackageOut(9645, 0, 35)`, `SOM:150`; header layout in [protocol/socket.md](../../protocol/socket.md)), body `active.OreActiveClientOpMsg`: `opType (#1, INT32)`, `isUseProp (#2, BOOL)`. Sender `StokesOreManager.sendClientOperation(op, useProp)` (`SOM:148-163`).

### R1. Open window (op 3)

- UI: SOF constructor (`SOF:144`).
- Fields: `opType` = 3.
- Response: S1 188 (if not yet sent), S2 189.

### R2. Mine once (op 1) / ten times (op 2)

- UI: open buttons (`SOF:760-846`).
- Client checks, in order: event ended ("Evento expirado"); server time 00:00 to 00:05 ("Os dados estão sendo resetados, tente novamente mais tarde"); `todayRemainTurns <= 0` ("Os minérios e hoje já acabaram, aguarde o próximo evento"); `spRewardRemainTimes == 0` asks "O número de tesouros recebido atingiu o limite de hoje, mesmo que atinja o andar não poderá obter tesouro, deseja seguir extraindo?"; cost = `mineOncePrice` (op 1) or `mineTimesPrice` (op 2); with the check box, cost = `mineOncePrice * max(0, n - count(208523))` where n = 1 or 10; diamonds (`point`) < cost opens the recharge alert.
- Fields: `opType` = 1 or 2, `isUseProp` = check box.
- Client then disables the buttons and waits; no answer in 15 s shows "Dados do evento em excesso, tente abrir a página e carregar novamente" and closes the frame (`SOF:845-859`).
- Response: S3 187 (`passType` 1) to the miner, S2 189 to the miner, S3 187 (`passType` 2) broadcast for floor prizes; diamond update (player info 3), bag updates; mail for treasures.

## 4. Server messages (server to client)

### S1. 188 (0x00bc) `U_C_ORE_MINE_BASE_INFO`

`active.OreActiveBaseInfoMsg`. Receiver `__updateStokesOreInfo` (`SOM:65-88`).

| Field | Tag, type | Meaning |
|---|---|---|
| `openTime` | #1 STRING | event start (not read here, see 190) |
| `closeTime` | #2 STRING | event end |
| `mineOncePrice` | #3 INT32 | diamonds per single mine |
| `mineTimesPrice` | #4 INT32 | diamonds for ten mines |
| `rewards` | #5 OreRewardTempMsg repeated | `rewardType (#1, INT32)`: 0 = pool, otherwise the floor threshold (sequence number); `specialFloorNum (#2, INT32)`; `rewards (#3, OreItemInfoMsg, repeated)`: `templateId (#1, INT32)`, `count (#2, INT32)`, `name (#3, STRING)` |

Exactly 5 non zero `rewardType` values are required (`SOMOD:200-206`). When: at login while the event is visible, and on op 3.

### S2. 189 (0x00bd) `U_C_ORE_WINDOW_INFO`

`active.OreWindowMsg`. Receiver `__updateStokesOreCrossInfo` (`SOM:95-112`).

| Field | Tag, type | Meaning |
|---|---|---|
| `todayRemainTurns` | #1 INT32 | rounds the server can still mine today |
| `curSeq` | #2 INT32 | shared sequence of the current round |
| `spRewardRemainTimes` | #3 INT32 | floor treasures the caller can still receive today |
| `countDown` | #4 INT32 | seconds until the next round (> 0 disables mining), 0 = mining, -1 = a new round just started (client resets the bar) |
| `mineCount` | #5 INT32 | not read |

When: response to ops 1, 2, 3; push to open windows when the shared sequence changes (assumption, throttled).

### S3. 187 (0x00bb) `U_C_ORE_MINE_RESP`

`active.OreMineRespMsg`: `passType (#1, INT32)`, `count (#2, INT32)`, `floors (#3, INT32, repeated)`, `infos (#4, STRING, repeated)`. Receiver `__updateOpenResultInfo` (`SOM:114-135`): `passType` 1 appends `infos` to the caller's result list; `passType` 2 replaces the lucky list. Each info string is a chat markup line rendered as channel 110 `STOKES_ORE` (`SOF:657-690`, [../chat/channels.md](../chat/channels.md)).

### S4. 190 (0x00be) `U_C_ORE_ACTIVE_OPEN_STATE`

`simple.PropertyMsg`. Receiver `__updateOpenStatusInfo` (`SOM:137-146`): `startDate = param4 (#4, STRING)`, `endDate = param5 (#5, STRING)` (`YYYY-MM-DD hh:mm:ss`), `openStokesOre = param7 (#7, BOOL)`; refreshes the top bar. When: login and event start / end.

## 5. Rules and formulas

- Prices from 188. Item 208523 replaces one single mine price per unit when the check box is on.
- Help (`stokesore.StokesOreFrame.helpFrame.content`): each mine gives an item; mining on a floor gives that floor's extra prize; extra prizes per floor are limited; when every round is used the round resets; mined items go to the bag, treasures by mail.
- Daily reset at 00:00 server time; mining blocked 00:00 to 00:05 client side.
- The shared sequence is cross-server (all servers of the group advance the same `curSeq`, "extração inter-servidor").
- Floor prize: the miner whose mine reaches or crosses a floor threshold receives that floor's `rewards` if `spRewardRemainTimes > 0` (assumption), broadcast with `passType` 2.
- Draw probabilities of the pool are not in the client (server configuration, open).

## 6. Templates

None in `raw/xml/tempinfos`; pool and floors come from server configuration (sent in 188). Config names `OreCastle2CrossActiveInfoMsg` (`openTime #1`, `closeTime #2`, `dailyMaxTurns #3`, `dailyMaxSpecialRewardTimes #4`, `countDown #5`, `type #6`, `rewards #7`), `OreCross2CastleActiveInfoMsg` (`openTime #1`, `closeTime #2`) and `OreMineReqMsg` (`mineCount #1`, `serverName #2`, `userId #3`, `nickName #4`, `spRewardRemainTimes #5`) are server to cross service messages: use them as the internal contract between the game server and the cross service.

## 7. Persistent state

```sql
CREATE TABLE cross_server.ore_events (
    event_id          bigserial   PRIMARY KEY,
    opens_at          timestamptz NOT NULL,
    closes_at         timestamptz NOT NULL,
    mine_once_price   integer     NOT NULL CHECK (mine_once_price > 0),
    mine_ten_price    integer     NOT NULL CHECK (mine_ten_price > 0),
    daily_max_rounds  integer     NOT NULL,
    daily_max_special integer     NOT NULL,
    round_cooldown_s  integer     NOT NULL DEFAULT 300
);

CREATE TABLE cross_server.ore_rewards (
    event_id     bigint   NOT NULL REFERENCES cross_server.ore_events(event_id) ON DELETE CASCADE,
    floor_seq    integer  NOT NULL,
    template_id  integer  NOT NULL,
    count        integer  NOT NULL CHECK (count > 0),
    weight       integer  NOT NULL DEFAULT 1,
    PRIMARY KEY (event_id, floor_seq, template_id)
);

CREATE TABLE cross_server.ore_rounds (
    event_id     bigint      NOT NULL REFERENCES cross_server.ore_events(event_id) ON DELETE CASCADE,
    round_date   date        NOT NULL,
    round_no     integer     NOT NULL,
    cur_seq      integer     NOT NULL DEFAULT 0,
    finished_at  timestamptz,
    PRIMARY KEY (event_id, round_date, round_no)
);

CREATE TABLE cross_server.ore_player_days (
    event_id     bigint   NOT NULL REFERENCES cross_server.ore_events(event_id) ON DELETE CASCADE,
    player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    day          date     NOT NULL,
    mines        integer  NOT NULL DEFAULT 0,
    special_received integer NOT NULL DEFAULT 0,
    PRIMARY KEY (event_id, player_id, day)
);
```

`floor_seq` 0 = pool.

## 8. Backend implementation notes

- `cross_server::ore::handle_client_op` (9645, check `extend1 == 35`): op 3 replies 188 and 189; ops 1 / 2 call `handle_mine`.
- `handle_mine`: validation order: event open, not 00:00 to 00:05, rounds left today, round not in cooldown, cost (after 208523 substitution) <= diamonds. Transaction: consume 208523 then diamonds, draw n pool items (weighted), grant items, advance the shared `cur_seq` atomically (row lock or cross service call), for each floor crossed give the floor prize by mail if `special_received < daily_max_special`; when the last floor is passed finish the round and start the cooldown. Reply 187 `passType` 1 with one info line per item, 189; broadcast 187 `passType` 2 and 189 to open windows.
- Round timer: when cooldown ends start a new round and push 189 with `countDown = -1`.

## 9. Open questions and assumptions

- Open: pool weights, floor thresholds, daily limits, cooldown length (server config).
- Assumption: shared sequence semantics and floor prize attribution.
- Assumption: info line markup format (chat cell markup).

## 10. Implementation checklist

- [ ] Screen SOF, SOT, SOD.
- [ ] Route 9645 ops 1, 2, 3 with header `extend1 = 35`.
- [ ] Server messages 188, 189, 187, 190.
- [ ] Tables `cross_server.ore_events`, `ore_rewards`, `ore_rounds`, `ore_player_days`.
- [ ] Cross service shared sequence.
- [ ] Tests: ten mine with 4 items 208523 costs 6 single prices; mining during cooldown refused; no reply within 15 s never happens under load.
