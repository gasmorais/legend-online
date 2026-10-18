# Alliance event tasks, boxes and milestones

Aliases: see [README.md](README.md) and [alliance-event.md](alliance-event.md). Extra aliases:

| Alias | File |
|---|---|
| TV | `decompiled/m11/scripts/oldplayerreturn/task/OldPlayerReturnTaskView.as` |
| TI | `decompiled/m11/scripts/oldplayerreturn/task/OldPlayerReturnTaskItem.as` |
| TB | `decompiled/m11/scripts/oldplayerreturn/task/OldPlayerReturnTaskBoxItem.as` |
| OTI | `decompiled/m11/scripts/oldplayerreturn/alliance/OldPlayerReturnOracleTaskItem.as` |
| ATV | `decompiled/m11/scripts/oldplayerreturn/alliance/OldPlayerReturnAlliTaskView.as` |
| MV | `decompiled/m11/scripts/oldplayerreturn/milestone/OldPlayerReturnMilestoneView.as` |
| MI | `decompiled/m11/scripts/oldplayerreturn/milestone/OldPlayerReturnMilestoneItem.as` |

## 1. Overview

Three task lists, split by the template `TaskList` (`OPRMOD:105-132`):

| TaskList | pt-BR | Who | Refresh | Reward on claim |
|---|---|---|---|---|
| 1 | "Missão de Regresso" | returnee | daily (5 tasks per day, day index in the id) | points `TaskCount` ("Prêmio de pontos:") feeding the daily box bar, the weekly box bar and the milestone score |
| 2 | Oracle tasks ("Oráculos") | both, needs an ally | once per event | items (tokens) plus "EXP do Oráculo" `TaskCount` |
| 3 | Alliance tasks "Missão A/B/C" | both, per ally | daily (3 per ally per day) | items plus "EXP da Aliança" `TaskCount` (raises the contract) |

Box rewards: 4 daily boxes and 5 weekly boxes on the task tab (returnee), 11 milestones on the "Marco" tab (returnee).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OldPlayerReturnTaskView` (TV) tab "Missão de Regresso" | "Progresso do Baú Diário:", "Progresso do Baú Semanal:", "({0}/{1})" | Return tasks in a horizontal roll (3 visible), daily and weekly box bars | `OldPlayerReturnFrame` (returnee) | `returnList`, `DailyNum`, `WeekNum`, `DailyProcess`, `WeekProcess` |
| `OldPlayerReturnTaskItem` (TI) | title, description with `{1}` = `Para1`, "Progresso da Missão: {0}/{1}", "Prêmio de pontos:" `TaskCount` | Claim button: disabled (status 0), enabled (1), received mark (2) (`TI:112-131`) | TV | `TaskData` |
| `OldPlayerReturnTaskBoxItem` (TB) | tooltip "rewards:" list | Box state 1 locked, 2 claimable (clickable), 3 claimed (`TB:74-127`) | TV | `AllianceRewardInfos` type 1 / 2 |
| `OldPlayerReturnOracleTaskView` / `OldPlayerReturnOracleTaskItem` (OTI) | "Prêmio da Missão:", "EXP do Oráculo:" | Oracle task list | AV sub tab (needs an ally) | `oracleList` |
| `OldPlayerReturnAlliTaskView` (ATV) | "Missão A", "Missão B", "Missão C", "EXP da Aliança:" | Tasks with the selected ally by `TaskNum` 1..3 (`ATV:215-232`) | AV sub tab | `allianceList` filtered by `allyId == selectedAllyId` |
| `OldPlayerReturnMilestoneView` (MV) tab "Marco" | "Meu progresso do Marco:", "Objetivo:" | 11 milestone nodes (`MV:56-71`) | `OldPlayerReturnFrame` (returnee) | `MilestoneScore`, `MilestoneProcess` |

Bar fill: daily bar splits 100% into 4 segments of 25 between consecutive `NeedCount` values; weekly bar 5 segments of 20 (`TV:127-198`).

## 3. Routes (client to server)

C>S 9717 (0x25f5) `C_ALLIANCE_REGRESSION_OP`, `allianceregression.CommonReq`.

### R1. Claim a task reward (op 0)

- UI: claim button in TI (`TI:83-94`), OTI (`OTI:114-125`), ATV (`ATV:147-158`).
- Client checks: button enabled only when `status == 1`.
- Sender: `send(0, TaskId)` for return and oracle tasks; `send(0, TaskId, allyId)` for alliance tasks (`OPRM:156-164`).
- Fields: `op (#1)` = 0, `intParam1 (#2, INT32)` = template `TaskId`, `intParam2 (#3, INT32)` = ally id (alliance tasks) or 0.
- Response: 535 with the task `status = 2`, updated points or EXP; item grants; 535 push to the ally when contract EXP changes.

### R2. Claim a box or milestone (op 1)

- UI: click on a claimable TB (`TB:65-72`) or MI (`MI:71-78`).
- Client checks: clickable only in state 2 (`NeedCount <= points` and flag 0).
- Sender: `send(1, RewardNum - 1, RewardType)`.
- Fields: `op` = 1, `intParam1` = zero based index (`RewardNum - 1`), `intParam2` = `RewardType` (1 daily box, 2 weekly box, 3 milestone).
- Response: 535 with the flag set to 1 in the matching `*Process`; item grants.

## 4. Server messages (server to client)

535 `U_C_ALLIANCE_USER_DATA` ([alliance-event.md](alliance-event.md)). `TaskData` rows:

| Field | Tag, type | Meaning |
|---|---|---|
| `templateId` | #1 INT32 | `AllianceActivityTasks.TaskId` |
| `allyId` | #2 INT32 | ally user id for TaskList 3, else 0 |
| `currentCount` | #3 INT32 | progress toward `Para1` |
| `status` | #4 INT32 | 0 in progress, 1 completed not claimed, 2 claimed |

Sort in the client: claimable first, then in progress, then claimed, each by `TaskId` (`OPRMOD:134-175`). The client drops rows whose template is unknown.

## 5. Rules and formulas

Template `AllianceActivityTasks.xml` (280 rows). Observed id groups:

| Id prefix | TaskList | Rows | Pattern | Reward items |
|---|---|---|---|---|
| 111DD0NN | 1 | 70 | day DD = 01..14, task NN = 1..5; `TaskCount` 20 points each | none |
| 212TT0LL | 2 | 42 | 14 themes TT x 3 levels; returnee oracle | 208701 x 50 / 100 / 200, `TaskCount` 10 / 15 / 25 |
| 213TT0LL | 2 | 42 | eternalist oracle | 208702 x 10 / 50 / 100, `TaskCount` 20 / 30 / 50 |
| 222DD0NN | 3 | 42 | day DD = 01..14, Missão A/B/C (`TaskNum` 1..3); returnee side | 208701 x 20, `TaskCount` 10 / 15 / 25 |
| 223DD0NN | 3 | 42 | eternalist side | 208702 x 10, `TaskCount` 20 / 30 / 50 |
| 22215 to 22228 | 2 | 42 | untranslated Chinese oracle rows (2101 goddess tears, 2201, 2301, 2401, 2601, 2702, 2801, 2901, 3002, 3101, 3202, 3401, 3501) | 2030102 x 10 / 20 / 30 |

Choice of the 222/223 split by player type and the meaning of the second id digit are inferred from the reward token (208701 returnee, 208702 eternalist, `OPR/shop/OldPlayerReturnShopBuyFrame.as:146`); the Chinese oracle rows are probably unused in this build (assumption).

`TaskType` codes (counter source; the server must hook each feature):

| Code | Event | Code | Event |
|---|---|---|---|
| 101 | logins today | 1102 | ally daily activity points |
| 102 | consecutive login days | 1201 | world boss participation |
| 103 | allies logged in today | 1301 | arena participation |
| 201 | number of allies | 1401 | battlefield participation |
| 301 | farm or pasture operations | 1402 | allies' battlefield participations |
| 302 | operations on an ally's farm or pasture | 1501 | game hall participation |
| 401 | underground maze challenges | 1502 | game hall with allies |
| 501 | Einherjar elite island guard | 1601 | bounty missions completed |
| 502 | Einherjar guard with allies | 1701 | Heroes Portal campaign clears |
| 601 | Glory Road participation | 1702 | Heroes Portal clears with allies |
| 701 | research points spent | 1801 | total friends |
| 801 | wanted guardians completed | 1901 | helped guild members open treasures |
| 901 | contribution donations | 1902 | guild treasures dug |
| 1001 | guild blessing requests | 1101 | daily activity points |

Completion: `currentCount >= Para1` sets `status = 1`.

Points and EXP (assumptions from the UI labels and the help):

- Return task claim: `DailyNum += TaskCount`, `WeekNum += TaskCount`, `MilestoneScore += TaskCount`.
- Oracle task claim: `OracleExp += TaskCount`, items granted.
- Alliance task claim: `myAllianceExp += TaskCount` and contract EXP of that alliance `+= TaskCount` ([alliance-contracts.md](alliance-contracts.md)), items granted.

Boxes (`AllianceRewardInfos.xml`):

| RewardType | Rows | NeedCount | Example rewards |
|---|---|---|---|
| 1 daily | 4 | 10, 20, 40, 80 | -500 x 100 (pseudo template -500, assumption: currency), 2030102, 208055, 208062, 212018, 2330001 |
| 2 weekly | 5 | 100, 200, 300, 400, 600 | 208510, 208500, 212034 |
| 3 milestone | 11 | 100 .. 1200 | 208053, 6260003, 6260002 up to 2061011, 7300001, 208521 |
| 4 contract level | 9 | 0 | see [alliance-contracts.md](alliance-contracts.md) |

Daily task generation: day index = whole days since `starts_at` + 1 (1..14); returnees get the 5 `111DD` rows of that day; every alliance gets the 3 `222DD` rows for the returnee and the 3 `223DD` rows for the eternalist (assumption). Oracle tasks are created once when the first alliance forms (assumption).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `AllianceActivityTasks.xml` | task | `TaskId`, `TaskList`, `TaskNum`, `TaskType`, `TaskTitle`, `TaskDes` (`{1}` = `Para1`), `Para1`, `TaskCount`, `RewardItem1..3`, `RewardItemNum1..3` |
| `AllianceRewardInfos.xml` | box or milestone | `Id`, `RewardType`, `RewardNum`, `NeedCount`, `RewardItem1..6`, `RewardItemNum1..6` |

## 7. Persistent state

```sql
CREATE TABLE league.alliance_tasks (
    event_id     bigint   NOT NULL REFERENCES league.alliance_events(event_id) ON DELETE CASCADE,
    player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id  integer  NOT NULL,
    ally_id      bigint   NOT NULL DEFAULT 0,
    day_index    smallint NOT NULL DEFAULT 0,
    current_count integer NOT NULL DEFAULT 0 CHECK (current_count >= 0),
    status       smallint NOT NULL DEFAULT 0 CHECK (status IN (0, 1, 2)),
    updated_at   timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (event_id, player_id, template_id, ally_id)
);
CREATE INDEX alliance_tasks_open_idx ON league.alliance_tasks (event_id, player_id) WHERE status < 2;
```

Box and milestone points and claims live in `league.alliance_participants` ([alliance-event.md](alliance-event.md)).

## 8. Backend implementation notes

- `league::alliance::handle_claim_task` (op 0): row exists for (caller, template, ally) with `status = 1`, event open. Transaction: set status 2, apply points / EXP, grant items (mail on full bag), contract level up; reply 535; push 535 to the ally on contract changes.
- `league::alliance::handle_claim_box` (op 1): `intParam2` in {1, 2, 3}, row `RewardNum = intParam1 + 1` exists, returnee only for types 1 and 3 (assumption: weekly too), points >= `NeedCount`, flag not set. Transaction: set flag, grant items; reply 535.
- Progress hooks: expose `league::alliance::record(player_id, task_type, amount, with_ally: Option<player_id>)` called by the other features; update matching open rows; set status 1 when `current_count >= Para1`; push 535 when online (debounced).
- Daily job at 00:00: delete unclaimed rows of yesterday for lists 1 and 3, insert the new day rows, reset daily points and flags.

## 9. Open questions and assumptions

- Assumption: point and EXP destinations of `TaskCount`.
- Assumption: id prefix interpretation and daily generation.
- Open: pseudo template -500 in daily boxes.
- Open: whether expired claimable tasks are auto claimed.

## 10. Implementation checklist

- [ ] Screens TV, TI, TB, OTI, ATV, MV, MI.
- [ ] Routes 9717 ops 0 and 1.
- [ ] 535 task rows and process strings.
- [ ] Table `league.alliance_tasks`.
- [ ] Progress API and hooks for the 28 task types.
- [ ] Daily and weekly jobs.
- [ ] Tests: claiming a status 0 task is rejected; daily box 1 claimable at 10 points; milestone flags string has 11 positions.
