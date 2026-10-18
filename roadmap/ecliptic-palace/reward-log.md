# Ecliptic Palace weekly reward log

Feature [ecliptic-palace](README.md), module `reward-log`. Aliases in [README.md](README.md).

## 1. Overview

The link "Itens obtidos esta semana" in the main frame opens a 60 slot grid with every item the player obtained in the palace during the current week.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `EPRF` (`EclipticPalaceRewardFrame`) | "map.campaign.view.frame.MazeFallItemsFrame.title" (shared drop list title) | 6 x 10 item grid (`DEFAULT_COUNT = 60`) | `_rewardText` link (`EPF:227-231`) -> controller `eclipticpalace` `REWARD_FRAME` | `rewardList` (template id, count) (`EPRF:91-118`) |

## 3. Routes (client to server)

### R1. Ask weekly items (op 5)

- UI: frame construction (`EPRF:34-41`).
- Request: 5190 `CommonMsg` `param1 = 5`.
- Response: 174.

## 4. Server messages (server to client)

### 174 (0x00ae) `U_C_ECLIPTIC_PALACE_REWARD_RECORD`

- Message `EclipticPalaceRewardRecordMsg`: `itemList` (#1, MESSAGE `CommonMsg`, repeated) with `param1` (#1, INT32) item template id and `param2` (#2, INT32) total count; other `CommonMsg` fields unused.
- Receiver: `EPM.__updateRewardBackHandler` (`EPM:129-144`), notifies `REWARD_GOODS_BACK`.
- When: reply to op 5. Only the first 60 entries are displayed.

## 5. Rules and formulas

- Aggregate by item template, sum counts, over the current week (reset day assumed Monday 00:00).

## 6. Templates

None (items from [palace.md](palace.md) rewards).

## 7. Persistent state

```sql
CREATE TABLE ecliptic_palace.weekly_reward (
  player_id            BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  week_start           DATE        NOT NULL,
  item_template_id     INTEGER     NOT NULL,
  count                INTEGER     NOT NULL CHECK (count > 0),
  PRIMARY KEY (player_id, week_start, item_template_id)
);
```

## 8. Backend implementation notes

- `ecliptic_palace::reward_log::handle_list` (op 5): select rows of the current `week_start` ordered by first gain (assumption) and reply 174.
- `ecliptic_palace::reward_log::record` is called by the battle end handler of [palace.md](palace.md) inside the reward transaction (upsert adding counts).
- Weekly cleanup job: delete rows older than 2 weeks.

## 9. Open questions and assumptions

- Week reset day and whether the log is daily or weekly in the original server (text says "esta semana").
- Ordering of the list.

## 10. Implementation checklist

- [ ] Screen: `EclipticPalaceRewardFrame`
- [ ] Route R1 op 5 -> 174
- [ ] Server message 174
- [ ] Table `ecliptic_palace.weekly_reward`
- [ ] Hook: record rewards on palace pass
- [ ] Test: counts aggregate per template
