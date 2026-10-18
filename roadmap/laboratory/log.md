# Diary: raid and defense log

Module `log` of feature `laboratory`. Covers the "Diário do Laboratório" frame: the request (op 8) and the log list message 275, filled by raid results ([raid.md](raid.md)).

Path aliases:

| Alias | File |
|---|---|
| PLM | `decompiled/core_module/scripts/managers/PerkinLabManager.as` |
| V | `decompiled/m11/scripts/perkinlab/` |

## 1. Overview

Every raid writes one entry for the attacker (type 1 "Saqueamento") and one for the defender (type 2 "Defesa"). The diary shows the last 20 entries, newest first.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/PerkinLabEventFrame.as` | "Diário do Laboratório"; columns "Informações diárias", time | log list (at least 11 rows, `EVENT_PAGE_NUM`) | diary button of `PerkinLabFrame` (`V/PerkinLabFrame.as:131-135`); constructor sends op 8 (`:66-69`) | `model.logList` (`:93-108`) |
| `V/PerkinLabEventItem.as` | type label "Saqueamento" / "Defesa"; text by type and result | one entry | EventFrame | (`:63-109`) |

Entry texts (`PerkinLabEventItem.eventText.text{type}{win ? 1 : 0}`, `{0}` = rival name, `{1}` = "Laboratório", `{2}` = "Item xN, Item xN"):

| type, win | Text |
|---|---|
| 1, false | "Você saqueou {1} {0}, falha ao saquear" |
| 1, true | "Você saqueou {1} {0}, obteve {2}" |
| 2, false | "{0} saqueou o seu {1}, você perdeu {2}" |
| 2, true | "{0} saqueou o seu {1}, você conseguiu defender-se" |

`win` is from the log owner's point of view (defender `win = true` means the defense held).

## 3. Routes (client to server)

### C1. Open the diary (op 8)
- UI: diary button (`V/PerkinLabFrame.as:131-135`), frame constructor (`V/PerkinLabEventFrame.as:66-69`).
- Sender: `PLM.sendLabOperate(8)` (`PLM:762-769`).
- Route: C>S 9566 (0x255e) `C_PERKIN_LAB_CLIENT`, `PerkinLabClientMsg`: `op (#1, INT32)` = 8, `index (#2, SINT32)` = -1.
- Response: 275.

## 4. Server messages (server to client)

### S1. 275 (0x0113) `U_C_PERKIN_LAB_LOG`, `PerkinLabLogListMsg`
Receiver `PLM.__updateRobLogList` (`PLM:737-760`, listener `PLM:106`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `logList` | #1 | `PerkinLabLogMsg` | yes | entries |

`PerkinLabLogMsg`:

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `time` | #1 | STRING | no | `YYYY-MM-DD hh:mm:ss` (sort key) |
| `type` | #2 | INT32 | no | 1 raid made, 2 raid suffered |
| `keng_size` | #3 | INT32 | no | not read (legacy lab size) |
| `win` | #4 | BOOL | no | result for the log owner |
| `rival_name` | #5 | STRING | no | other player's nickname |
| `rob_reward` | #6 | STRING | no | items gained or lost, "templateId,count|..." (names from the item templates) |

Client: replaces the list, sorts by time descending, keeps 20, dispatches `UPDATE_LOG_LIST`.

When: response to op 8 only.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Entries kept by the client | 20 newest | `PLM:754-758` |
| Server retention | assumption: keep the 20 newest per player (or 7 days) | |

## 6. Templates

`ItemTempInfos.xml` for item names in `rob_reward`.

## 7. Persistent state

```sql
CREATE TABLE laboratory.raid_logs (
  log_id         BIGSERIAL PRIMARY KEY,
  player_id      BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  log_type       SMALLINT NOT NULL CHECK (log_type IN (1, 2)),   -- 1 raid made, 2 raid suffered
  is_win         BOOLEAN NOT NULL,
  rival_name     TEXT NOT NULL,
  reward         TEXT NOT NULL DEFAULT '',                       -- "templateId,count|..."
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX raid_logs_player_idx ON laboratory.raid_logs (player_id, created_at DESC);
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9566 `op` 8 | `laboratory::log::handle_open` |
| (internal) | `laboratory::log::write_pair(attacker, defender, win, loot)` called by `laboratory::raid::on_battle_end` |

- `handle_open`: select the 20 newest rows of the player, format `time` in server local time, reply 275.
- `write_pair`: insert attacker row (type 1, `is_win = win`, reward = loot gained) and defender row (type 2, `is_win = !win`, reward = loot lost) in the raid result transaction; prune rows beyond retention.

## 9. Open questions and assumptions

- Assumption: retention of 20 entries per player.
- Assumption: the defender reward string lists only stolen items (the streak bonus is not shown to the defender).

## 10. Implementation checklist

- [ ] Screens (client ready): `PerkinLabEventFrame`, `PerkinLabEventItem`.
- [ ] Table `laboratory.raid_logs`.
- [ ] Route 9566 op 8 and server message 275.
- [ ] Log writes from the raid result.
- [ ] Tests: a won raid creates (1, true) for the attacker and (2, false) for the defender with the same items; op 8 returns at most 20 entries newest first.
