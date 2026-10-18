# Treasure mines: recharge tiers and daily A/B packages

Module `treasure-mines` of feature `mines`. Covers "Minas do Tesouro": the event message 4612, the query (8703 op 0), joining a tier (op 1), claiming a daily package (op 2), the participation and collection windows, and mailing uncollected rewards.

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/managers/FundManager.as` |
| FI | `decompiled/core_module/scripts/mvc/module/fund/FundInfo.as` |
| API | `decompiled/core_module/scripts/mvc/module/fund/ActiveParmaInfo.as` |
| V | `decompiled/m11/scripts/fund/` |

## 1. Overview

- One event at a time (`activeId`). Two windows: participation (`setStartDate`..`setEndDate`, "Tempo de abertura do evento: {0}-{1}") and collection (`getStartDate`..`getEndDate`, "Tempo da coleta:").
- 5 tiers (`ActiveParamMsg.level` 1..5). Tier L requires an accumulated recharge `costDiamond` during the participation window ("Aviso: Durante o evento, ao efetuar recarga acumulada de um certo valor poderá abrir as minas de diamantes correspondentes."). The highest reached tier is highlighted (`FI:267-309`, `V/FundNewBuyItem.as:497-536`).
- `depositLevel` is the tier the player participates in (0 = none). With `depositLevel > 0` the frame shows the reward view: one row per day (`GetItemInfosMsg.times`), each with package A (`itemInfo`) and B (`itemInfo2`); a day unlocks at `getStartDate + interval minutes` ("Tempo de Coleta: {0} (Selecionar 1)").
- First claim fixes A or B ("Apenas poderá coletar os prêmios do set correspondente A B fixos").
- Help (`fund.FundFrame.helpFrame.helpContent`): non participants cannot join later; rewards not collected before the collection end are lost, except that after the event "os prêmios não coletados serão enviados no email"; missed days can be collected while the event lasts.
- `activeType`: 1 = participation open (buy view, or reward view once `depositLevel > 0`), 2 = collection only (needs `depositLevel > 0`), 3 = ended ("Evento encerrado").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/FundFrame.as` | "Minas do Tesouro"; help "Instruções da Minas do Tesouro" | container; picks buy or reward view (`:149-191`) | controller `fund` after a 4612 with `isUseOpen` (`FM:139-170`) | `activeType`, `depositLevel` |
| `V/FundNewBuyView.as` | "Tempo de abertura do evento:  {0}-{1}", "Recarga atual acumulada:" + `chargePoint`, "Recarregar" button | list of 5 tiers | FundFrame when `depositLevel == 0` and `activeType == 1` | `setStartDate`, `setEndDate`, `chargePoint` (`:54-118,184-204`) |
| `V/FundNewBuyItem.as` | tier icon (frame = level), required recharge (diamond icon), optional contract cost, "Pacote A" (3 per page) and "Pacote B" (4 per page) total item lists | one tier; animated highlight on the reached tier | BuyView | `costDiamond`, `costContract`, `allGetA` (`itemInfos`), `allGetB` (`itemInfos2`) sorted with id -400 (diamonds) first then Profile desc (`:375-495`) |
| `V/FundNewRewardView.as` | "Tempo da coleta:" + start + separator `fund.FundRewardView.getTime.line` + end, "Aviso: Pode coletar um tipo de pacote fixo" | 5 day rows of the player's tier | FundFrame when `depositLevel > 0` | `newActiveArr[5 - depositLevel]` (list sorted by level descending), rows sorted by claimed then `times` (`:106-192`) |
| `V/FundNewRewardItem.as` | "Tempo de Coleta: {date} (Selecionar 1)" | one day: A and B item rows | RewardView | `itemInfos`, `itemInfos2`, glow for Profile >= 5 (`:113-207`) |
| `V/FundNewDoubleGiftItem.as` | "Pacote A"/"Pacote B", collect button, "collected" mark; disabled tip "Ainda não está no tempo da coleta." | claim one package | RewardItem | state from logs (`:113-178`) |

Legacy classes `FundBuyView`, `FundBuyItem`, `FundRewardView`, `FundRewardItem`, `FundNewbieFrame` are not instantiated by `FundFrame` (no references), but document the older protocol use: op 1 with diamond payment and "Contrato das Minas" item 2125044 (`V/FundBuyItem.as:196-223`), op 2 without package (`V/FundRewardItem.as:111-119`).

## 3. Routes (client to server)

`DepositActiveMsg` is used for requests and responses. Request fields set by the client: `opType (#15, INT32)`, `opParam (#16, INT32)`, `sort (#21, INT32)`.

### C1. Query / open (op 0)
- UI: top bar button `fund` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1153-1157`): `FM.fundOperate()` then `isUseOpen = true`.
- Sender: `FM.fundOperate(0, 0)` (`FM:67-74`).
- Route: C>S 8703 (0x21ff) `C_U_ACTIVE_DEPOSIT`, `DepositActiveMsg`: `opType (#15)` = 0, `opParam (#16)` = 0.
- Response: 4612 full state. Client: `activeType` 1 or (2 with `depositLevel >= 1`) opens `FundFrame`; 3 shows "Evento encerrado".

### C2. Join a tier (op 1)
- UI: none in the shipped views. `V/FundNewBuyItem.as:568-592` has an unwired handler: confirmation "Deseja recarregar {0} diamantes para abrir a minas do tesouro?\n Você já recarregou acumuladamente: {1} diamantes", then `chargePoint < costDiamond` -> "Recarga insuficiente, deseja recarregar?" (recharge page), else `FM.fundNewOperate(1, level)`.
- Sender: `FM.fundNewOperate(1, level)` (`FM:76-87`).
- Route: 8703, `opType` = 1, `opParam (#16)` = tier level 1..5.
- Response: 4612 with the new `depositLevel` and `depositTime`.
- Server behavior: because no button sends it, the server must also assign the tier automatically from `chargePoint` (section 5). Keep op 1 accepted for compatibility: valid when `activeType == 1`, `now` in the participation window and `chargePoint >= costDiamond` of that tier; no diamonds are deducted (recharge based).

### C3. Claim a daily package (op 2)
- UI: collect button of package A or B on a day row (`V/FundNewDoubleGiftItem.as:77-80`).
- Client checks: button enabled only when `now >= getStartDate + interval * 60` and the day is not collected; after the first claim only the chosen package stays claimable (`setState`, `:113-173`).
- Sender: `FM.fundNewOperate(2, times, index + 1)` (`FM:76-87`).
- Route: 8703, `opType` = 2, `opParam (#16)` = day `times`, `sort (#21)` = 1 package A, 2 package B.
- Response: 4612 with the new log entry (`logs`), updated `harvestedInfos`; bag/currency pushes for the items.

## 4. Server messages (server to client)

### S1. 4612 (0x1204) `U_C_ACTIVE_DEPOSIT`, `DepositActiveMsg`
Receiver `FM.__getFundInfo` (`FM:89-172`, listener `FM:64`, registered by `FM.setup`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `activeId` | #1 | STRING | no | event id (client converts to int) |
| `title` | #2 | STRING | no | event title (stored, not displayed by the new views) |
| `contents` | #3 | STRING | no | event text (stored) |
| `activeType` | #4 | INT32 | no | 1 participation, 2 collection only, 3 ended |
| `description` | #5 | STRING | no | stored |
| `actionTimeContent` | #6 | INT64 | no | epoch ms (stored) |
| `consortia` | #7 | INT32 | no | stored (assumption: guild requirement flag, unused) |
| `grades` | #8 | INT32 | no | stored (assumption: minimum level; button uses 11) |
| `setStartDate` | #9 | INT64 | no | participation start, epoch ms |
| `setEndDate` | #10 | INT64 | no | participation end, epoch ms |
| `getStartDate` | #11 | INT64 | no | collection start, epoch ms; day k opens at `getStartDate + interval_k` minutes |
| `getEndDate` | #12 | INT64 | no | collection end, epoch ms |
| `depositLevel` | #13 | INT32 | no | joined tier 0..5 |
| `depositTime` | #14 | INT64 | no | join time, epoch ms |
| `opType` | #15 | INT32 | no | echo |
| `opParam` | #16 | INT32 | no | echo |
| `harvestedInfos` | #17 | `GItemInfoMsg` | yes | total collected items (`hasGetInfo`, used by legacy views) |
| `activeParams` | #18 | `ActiveParamMsg` | yes | the 5 tiers |
| `logs` | #19 | `GetLogMsg` | yes | claimed days |
| `chargePoint` | #20 | INT32 | no | accumulated recharge in the participation window (diamonds); must be set before `activeParams` is processed (the client computes the reached tier with it, `FI:294-304`) |
| `sort` | #21 | INT32 | no | echo |

`ActiveParamMsg`: `level (#1, INT32)` 1..5; `costDiamond (#2, INT32)` recharge required; `costContract (#3, INT32)` "Contrato das Minas" shown when > 0 (legacy); `getBindingDia (#4, INT32)` unused; `harvestCount (#5, INT32)` number of days; `itemInfos (#6, GItemInfoMsg, repeated)` package A total; `itemInfos2 (#7, GItemInfoMsg, repeated)` package B total; `getInfos (#8, GetItemInfosMsg, repeated)` days.

`GetItemInfosMsg`: `interval (#1, INT32)` minutes after `getStartDate`; `times (#2, INT32)` day number (1..5, matches `GetLogMsg.type`); `itemInfo (#3, GItemInfoMsg, repeated)` package A of the day; `itemInfo2 (#4, GItemInfoMsg, repeated)` package B.

`GItemInfoMsg`: `templateId (#1, INT32)` item id, -400 diamonds, -500 bound diamonds; `count (#2, INT32)`.

`GetLogMsg`: `type (#1, INT32)` claimed day `times`; `time (#2, INT64)` claim time epoch ms; `sort (#3, INT32)` 1 package A, 2 package B.

Client reaction: fills the model, dispatches `FUND_REFRESH` (reward view re-sort), `SHOWTOPBTN` (top bar refresh) when not opening, `OPEN` (frame view switch), recalculates InfoTips 22 (`FM:133-171`). With `isUseOpen`: opens or "Evento encerrado".

When: response to 8703 ops 0, 1, 2; push at login when an event exists (needed for the top bar button); push when `chargePoint` or `depositLevel` changes after a recharge (assumption); push at window changes.

Error reporting: none in the client. Invalid requests: reply 4612 unchanged.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Reached tier | highest level with `chargePoint >= costDiamond` | `FI:294-304` |
| Tier assignment | assumption: automatic, `depositLevel = reached tier`, updated on each recharge during the participation window, frozen at the first claim | help text; no client button |
| Day available | `now >= getStartDate + interval * 60 s` and `now <= getEndDate` | `V/FundNewDoubleGiftItem.as:175-178` |
| Package lock | first claimed `sort` fixes A or B for all days | `V/FundNewRewardView.as:145-192`, help text item 4 |
| One claim per day | log `type == times` exists -> claimed | `V/FundNewRewardView.as:168-185` |
| Reward view tier | `newActiveArr[5 - depositLevel]` (assumes exactly 5 tiers sorted descending) | `V/FundNewRewardView.as:116-119` |
| Button visibility | level >= 11, `activeType == 1`, or `activeType == 2` with `depositLevel > 0` | `FM:218-233` |
| Claimable badge (legacy) | `getCanGetGift` | `FM:174-216` |
| End of event | uncollected days of participants are mailed | help text item 3 |
| Diamond pseudo items | -400 diamonds (`point`), -500 bound diamonds (`giftToken`) | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:136-140` |

## 6. Templates

No client template: tiers, days and items are server configuration sent in 4612. Item templates from `ItemTempInfos.xml` for display; legacy contract item 2125044.

## 7. Persistent state

Schema `mines`.

```sql
CREATE TABLE mines.treasure_events (
  event_id        SERIAL PRIMARY KEY,                        -- activeId
  title           TEXT NOT NULL DEFAULT '',
  contents        TEXT NOT NULL DEFAULT '',
  description     TEXT NOT NULL DEFAULT '',
  min_grade       SMALLINT NOT NULL DEFAULT 11,
  join_starts_at  TIMESTAMPTZ NOT NULL,
  join_ends_at    TIMESTAMPTZ NOT NULL,
  claim_starts_at TIMESTAMPTZ NOT NULL,
  claim_ends_at   TIMESTAMPTZ NOT NULL,
  mailed_at       TIMESTAMPTZ,                               -- end of event mail job done
  CHECK (join_ends_at > join_starts_at AND claim_ends_at > claim_starts_at)
);

CREATE TABLE mines.treasure_tiers (
  event_id        INTEGER NOT NULL REFERENCES mines.treasure_events(event_id) ON DELETE CASCADE,
  level           SMALLINT NOT NULL CHECK (level BETWEEN 1 AND 5),
  cost_diamond    INTEGER NOT NULL CHECK (cost_diamond > 0),  -- recharge threshold
  cost_contract   INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, level)
);

CREATE TABLE mines.treasure_days (
  event_id          INTEGER NOT NULL,
  level             SMALLINT NOT NULL,
  day_number        SMALLINT NOT NULL CHECK (day_number >= 1),  -- GetItemInfosMsg.times
  interval_minutes  INTEGER NOT NULL CHECK (interval_minutes >= 0),
  PRIMARY KEY (event_id, level, day_number),
  FOREIGN KEY (event_id, level) REFERENCES mines.treasure_tiers(event_id, level) ON DELETE CASCADE
);

CREATE TABLE mines.treasure_day_items (
  event_id          INTEGER NOT NULL,
  level             SMALLINT NOT NULL,
  day_number        SMALLINT NOT NULL,
  package           SMALLINT NOT NULL CHECK (package IN (1, 2)),  -- 1 A, 2 B
  item_template_id  INTEGER NOT NULL,                             -- -400 diamonds, -500 bound diamonds
  count             INTEGER NOT NULL CHECK (count > 0),
  PRIMARY KEY (event_id, level, day_number, package, item_template_id),
  FOREIGN KEY (event_id, level, day_number) REFERENCES mines.treasure_days(event_id, level, day_number) ON DELETE CASCADE
);

CREATE TABLE mines.treasure_participants (
  event_id        INTEGER NOT NULL REFERENCES mines.treasure_events(event_id) ON DELETE CASCADE,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  charge_point    INTEGER NOT NULL DEFAULT 0 CHECK (charge_point >= 0),
  deposit_level   SMALLINT NOT NULL DEFAULT 0 CHECK (deposit_level BETWEEN 0 AND 5),
  deposited_at    TIMESTAMPTZ,
  package         SMALLINT CHECK (package IN (1, 2)),             -- fixed at the first claim
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE mines.treasure_claims (
  event_id     INTEGER NOT NULL,
  player_id    BIGINT NOT NULL,
  day_number   SMALLINT NOT NULL,
  package      SMALLINT NOT NULL CHECK (package IN (1, 2)),
  claimed_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  via_mail     BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (event_id, player_id, day_number),
  FOREIGN KEY (event_id, player_id) REFERENCES mines.treasure_participants(event_id, player_id) ON DELETE CASCADE
);
```

Totals per tier (`itemInfos`, `itemInfos2`) are computed by summing `treasure_day_items` per package; `harvestedInfos` by summing the claimed rows.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8703 `opType` 0 | `mines::treasure_mines::handle_query` |
| 8703 `opType` 1 | `mines::treasure_mines::handle_join` |
| 8703 `opType` 2 | `mines::treasure_mines::handle_claim` |
| recharge hook | `mines::treasure_mines::on_recharge(player, diamonds)` |
| scheduler | `mines::treasure_mines::close_event_job` |

- `activeType` computed from the clock: participation window -> 1; after it and before `claim_ends_at` -> 2; else 3. (If windows overlap, 1 wins.)
- `handle_query`: build 4612 (set `chargePoint` from the participant row, all tiers with days and items, logs, totals); no state change.
- `on_recharge` (called by the recharge feature inside its transaction): if an event is in the participation window, `charge_point += diamonds`; recompute `deposit_level` (unless `package` is set); push 4612 to the online player.
- `handle_join`: participation window -> level 1..5 -> `charge_point >= cost_diamond` -> `deposit_level = level`, `deposited_at = now` -> 4612.
- `handle_claim` validation order: `deposit_level > 0` -> `opParam` is a day of the tier -> `now >= claim_starts_at + interval` and `now <= claim_ends_at` -> day not claimed -> `sort` in {1, 2} and equals `package` when set -> one transaction: insert claim, set `package` on first claim, grant items (bag), diamonds (-400) and bound diamonds (-500) through the currency service -> 4612 + pushes.
- `close_event_job` after `claim_ends_at`: for each participant and each unclaimed available day, mail the fixed package (or A when no package was chosen, assumption) through the mail service and insert claims with `via_mail = true`; set `mailed_at`.
- Login: push 4612 when an event is active and the player could see the button.

## 9. Open questions and assumptions

- Assumption: tier assignment is automatic from recharge; op 1 is accepted but optional.
- Assumption: `depositLevel` can still rise with more recharge until the first claim.
- Open: whether days missed before `claim_ends_at` remain claimable (help text says missed days can be collected while the event lasts, and mailed after).
- Open: semantics of `consortia`, `grades`, `actionTimeContent`, `getBindingDia`, `costContract` in the current version (sent but unused by the new views).
- Assumption: exactly 5 tiers (the reward view indexes `5 - depositLevel`).

## 10. Implementation checklist

- [ ] Screens (client ready): `FundFrame`, `FundNewBuyView`, `FundNewBuyItem`, `FundNewRewardView`, `FundNewRewardItem`, `FundNewDoubleGiftItem`.
- [ ] Tables `mines.treasure_events`, `treasure_tiers`, `treasure_days`, `treasure_day_items`, `treasure_participants`, `treasure_claims`.
- [ ] Route 8703 op 0 query and 4612 builder (ms timestamps, 5 tiers, logs).
- [ ] Route 8703 op 1 join (compat).
- [ ] Route 8703 op 2 claim with package lock and day time check.
- [ ] Recharge hook updating `charge_point` and `deposit_level`, push 4612.
- [ ] Login push 4612; end of event mail job.
- [ ] Tests: recharge of 1000 reaches the tier with cost 1000 and the buy view highlights it; claim before `interval` refused; first claim with B makes A unclaimable; second claim of the same day refused; after the event unclaimed days are mailed once; `activeType` 3 opens nothing and shows "Evento encerrado".

## Screens

- `MineFieldFrame` (`decompiled/m11/scripts/mineField/MineFieldFrame.as`, "Mina de Ametistas", "Número de vagões avançados:") is the amethyst mine field frame, opened on the mine map.
