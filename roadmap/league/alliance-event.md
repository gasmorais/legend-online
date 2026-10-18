# Alliance event shell ("Regresso dos Jogadores Antigos")

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| OPRF | `decompiled/m11/scripts/oldplayerreturn/OldPlayerReturnFrame.as` |
| OPRC | `decompiled/core_module/scripts/mvc/controler/OldPlayerReturnController.as` |
| TBC | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |
| TBI | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnItemView.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

A server-wide limited time event. When it starts, every eligible player is classified once:

- **PlayerType 1, "Ressurgido"** (returnee, top bar key `oldplayerreturn`, template "回归者"): did not log in during the `alliance_returnplayer` = 14 days before the event start and has level >= `alliance_returnplayer_grade` = 80 (`ConfigInfos.xml`).
- **PlayerType 2, "Eternalista"** (active player, key `oldplayerreturn2`, template "永恒者").

Minimum job transfer stage for both: `alliance_playerjob` = 1 (no transfer needed). Returnees and eternalists form alliances (contracts), complete tasks for 14 days, earn tokens ("Prova do Retorno" 208701 for returnees, "Prova de Eternidade" 208702 for eternalists) and spend them in the event shop, which stays open `alliance_delaydays` = 7 days after the task phase.

All requests use one opcode, 9717 `C_ALLIANCE_REGRESSION_OP`, with `allianceregression.CommonReq.op` (`OPRM:30-46`):

| op | Constant | Module |
|---|---|---|
| 0 | `OP_RECEIVE_TASK_AWARD` | [alliance-tasks.md](alliance-tasks.md) |
| 1 | `OP_RECEIVE_BOX` | [alliance-tasks.md](alliance-tasks.md) |
| 2 | `OP_SEARCH_ALLY` | [alliance-contracts.md](alliance-contracts.md) |
| 3 | `OP_APPLY` | [alliance-contracts.md](alliance-contracts.md) |
| 4 | `OP_REVOKE` | [alliance-contracts.md](alliance-contracts.md) |
| 5 | `OP_APPROVE` | [alliance-contracts.md](alliance-contracts.md) |
| 6 | `OP_RECEIVE_CONTRACT` | [alliance-contracts.md](alliance-contracts.md) |
| 7 | `OP_SHOP_EXCHANGE` | [alliance-shop.md](alliance-shop.md) |
| 8 | `OP_TERMINATE_CONTRACT` | [alliance-contracts.md](alliance-contracts.md) |

`CommonReq` fields: `op (#1, INT32)`, `intParam1 (#2, INT32)`, `intParam2 (#3, INT32)`, `intParam3 (#4, INT32)`, `stringParam1 (#5, STRING)`, `stringParam2 (#6, STRING)`, `boolParam1 (#7, BOOL)`, `boolParam2 (#8, BOOL)`. Generic sender `OldPlayerReturnManager.send(op, intParam1, intParam2 = 0)` (`OPRM:156-164`).

The UI belongs to the `oldplayerreturn` client package (see [../returning-players/README.md](../returning-players/README.md)); the protocol is mapped here.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `oldplayerreturn.OldPlayerReturnFrame` (OPRF), `openType` 1 / default (`OPRC:51-66`) | "Regresso dos Jogadores Antigos" | Tab host: "Missão de Regresso" and "Marco" only for returnees while `isOpen`; "Contrato da Aliança" while `isOpen`; "Loja do Evento" always (`OPRF:100-131`); help "Ajuda do Evento de Regresso" | top bar keys `oldplayerreturn` / `oldplayerreturn2` (`TopToolsBar.as:1515-1519`) | refreshes every tab on `USER_DATA_EVENT` (535) |
| Top bar button tooltip | "Hora de início: {0}", "Encerramento: {0}", "Encerramento da Loja: {0}" (`TBI:634-637`) | Dates | top bar | `startDate`, `stopDate`, `stopDate + alliance_delaydays` days (`OPRMOD:354-361`) |

Child frames and tabs are listed in [alliance-contracts.md](alliance-contracts.md), [alliance-tasks.md](alliance-tasks.md), [alliance-shop.md](alliance-shop.md).

Top bar visibility (`TBC:421-424`): `status == 1 && (isOpen || isShopOpen)` and `PlayerType == 1` (key `oldplayerreturn`) or `!= 1` (key `oldplayerreturn2`).

## 3. Routes (client to server)

No route belongs to this shell. 534 and 535 are pushed by the server; every action is listed in the other modules.

## 4. Server messages (server to client)

### S1. 534 (0x0216) `U_C_ALLIANCE_ACTIVITY_INFO`

Message `allianceregression.ActivityInfo`. Receiver `OldPlayerReturnManager.__activityInfoHandler` (`OPRM:86-96`): stores the flags and dates, notifies `ACTIVITY_INFO_EVENT` (top bar refresh).

| Field | Tag, type | Meaning |
|---|---|---|
| `isOpen` | #1 BOOL | task phase running (tasks, contracts, milestones) |
| `isShopOpen` | #2 BOOL | shop phase running (task phase plus 7 days) |
| `startDate` | #3 STRING | `YYYY-MM-DD hh:mm:ss` event start |
| `stopDate` | #4 STRING | `YYYY-MM-DD hh:mm:ss` task phase end |

When: at login, and pushed to online players at each phase change.

### S2. 535 (0x0217) `U_C_ALLIANCE_USER_DATA`

Message `allianceregression.ActivityDataMsg`. Receiver `__userDataHandler` (`OPRM:98-137`): copies `userInfo` into the model, splits `tasks` by template `TaskList` (`OPRMOD:105-132`), replaces `allyList`, `applyList`, `inviteList`, replaces `shopLimitList` only when `shopLimit` is not empty, notifies `USER_DATA_EVENT`.

| Field | Tag, type | Meaning |
|---|---|---|
| `userInfo` | #1 AllianceUserData | player state (below) |
| `tasks` | #2 TaskData repeated | every task row of the player ([alliance-tasks.md](alliance-tasks.md)); the client keeps the old list when empty |
| `allys` | #3 AllyData repeated | current allies ([alliance-contracts.md](alliance-contracts.md)) |
| `applys` | #4 RelationData repeated | players who applied to me |
| `invites` | #5 RelationData repeated | players I applied to |
| `shopLimit` | #6 ShopLimitData repeated | bought count per shop row ([alliance-shop.md](alliance-shop.md)) |

`AllianceUserData` fields:

| Field | Tag, type | Meaning |
|---|---|---|
| `PlayerType` | #1 INT32 | 1 returnee, 2 eternalist (`OPRMOD:100-103`) |
| `PlayerStatus` | #2 INT32 | 1 = participates (top bar condition) |
| `RevokeDate` | #3 STRING | end of the 48 h ban after terminating a contract; "Pode formar nova aliança após {0}" while in the future (`OPR/alliance/OldPlayerReturnLeftView.as:143-152`) |
| `OracleExp` | #4 INT32 | "Minha EXP de Oráculo: {0}" |
| `DailyNum` | #5 INT32 | daily task points (daily box bar) |
| `DailyProcess` | #6 STRING | `\|` separated claim flags of the daily boxes, index = `RewardNum - 1`, 0 not claimed, 1 claimed |
| `WeekNum` | #7 INT32 | weekly points |
| `WeekProcess` | #8 STRING | weekly box flags, same format |
| `MilestoneScore` | #9 INT32 | milestone points (returnee) |
| `MilestoneProcess` | #10 STRING | milestone flags, same format |

When: at login (after 534), as the response to every 9717 operation that changes state, and pushed when an ally action changes my data (task progress, contract EXP, new application).

### S3. 538 (0x021a) `U_C_ALLIANCE_OP_RESP`

Message `allianceregression.OperationResp`: `userId (#1, INT32)` target player, `result (#2, INT32)` 0 failure, other success. Receiver `__allianceOpRespHandler` (`OPRM:148-154`) forwards it as `INVITES_DATA_EVENT`; only the find list item listens (switches "Aplicar" to "Desfazer" on success, [alliance-contracts.md](alliance-contracts.md)). When: response to op 3 (and assumption: ops 4, 5, 8).

### S4. 537 (assumption) `PrivilegeChangeMsg`

`allianceregression.PrivilegeChangeMsg` (`TimeVortexCount #1`, `EvilLandBossCount #2`, `ForbiddenBossCount #3`, `DemonRoadBuyCount #4`, all INT32) has no client receiver and opcode 537 is absent from `protocol/opcodes.csv`. The client derives the same counts locally from `AlliancePrivileges` ([alliance-contracts.md](alliance-contracts.md)). Do not send it.

## 5. Rules and formulas

- Classification and thresholds: config keys `alliance_returnplayer` (14 days absent), `alliance_returnplayer_grade` (80), `alliance_playerjob` (1), `alliance_coolingtime` (48 hours ban after terminating), `alliance_delaydays` (7 shop days) in `raw/xml/tempinfos/ConfigInfos.xml`; `allianceDelaydays` read by `CIM:1929`.
- Help text (`oldPlayerReturnFrame.helperFrame.helpTxt.text`): tasks last 14 days; return and alliance tasks refresh daily, oracle tasks once per event; shop stays 7 days after the tasks end; terminating loses all alliance EXP with that ally and the terminating side cannot ally again for 48 hours.
- Classification is fixed for the whole event (assumption).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `alliance_*` keys above |
| `raw/xml/tempinfos/TopToolBtnInfos.xml` | 4027 `oldplayerreturn`, 4028 `oldplayerreturn2` |
| `AllianceActivityTasks.xml`, `AllianceRewardInfos.xml`, `AlliancePrivileges.xml`, `AllianceShopInfos.xml` | see the other modules |

## 7. Persistent state

```sql
CREATE TABLE league.alliance_events (
    event_id      bigserial   PRIMARY KEY,
    starts_at     timestamptz NOT NULL,
    tasks_end_at  timestamptz NOT NULL,
    shop_end_at   timestamptz NOT NULL,
    CHECK (tasks_end_at > starts_at AND shop_end_at >= tasks_end_at)
);

CREATE TABLE league.alliance_participants (
    event_id         bigint      NOT NULL REFERENCES league.alliance_events(event_id) ON DELETE CASCADE,
    player_id        bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    player_type      smallint    NOT NULL CHECK (player_type IN (1, 2)),
    status           smallint    NOT NULL DEFAULT 1,
    revoke_until     timestamptz,
    oracle_exp       integer     NOT NULL DEFAULT 0,
    daily_points     integer     NOT NULL DEFAULT 0,
    daily_claimed    smallint[]  NOT NULL DEFAULT '{}',
    weekly_points    integer     NOT NULL DEFAULT 0,
    weekly_claimed   smallint[]  NOT NULL DEFAULT '{}',
    milestone_points integer     NOT NULL DEFAULT 0,
    milestone_claimed smallint[] NOT NULL DEFAULT '{}',
    daily_reset_on   date        NOT NULL DEFAULT current_date,
    weekly_reset_on  date        NOT NULL DEFAULT current_date,
    PRIMARY KEY (event_id, player_id)
);
CREATE INDEX alliance_participants_type_idx ON league.alliance_participants (event_id, player_type);
```

`*_claimed` hold the claimed `RewardNum` values; the `*Process` strings are built from them (`1` for claimed positions, `0` otherwise, joined with `|`, length = row count of the reward type).

## 8. Backend implementation notes

- Dispatcher `league::alliance::handle_op` (9717) switches on `op`.
- Event start job: create `alliance_events`, classify every player (returnee rule uses last logout time and level), push 534 to online players. Late classification for players who log in later uses the same rule against `starts_at` (assumption).
- Login: if an event exists push 534, then 535 for participants.
- Daily reset 00:00: reset daily points and claims, regenerate daily tasks ([alliance-tasks.md](alliance-tasks.md)); weekly reset Monday 00:00 (assumption) for weekly points; push 535 to online participants.
- Phase change jobs: tasks end (isOpen false), shop end (isShopOpen false), push 534.

## 9. Open questions and assumptions

- Assumption: opcode 537 for `PrivilegeChangeMsg`, never sent.
- Assumption: weekly reset day and late classification.
- Open: exact `PlayerStatus` values besides 1.

## 10. Implementation checklist

- [ ] Tables `league.alliance_events`, `league.alliance_participants`.
- [ ] Classification job with the `alliance_*` config keys.
- [ ] Server messages 534, 535, 538.
- [ ] Dispatcher 9717.
- [ ] Daily and weekly resets with 535 push.
- [ ] Test: level 79 absent player is not a returnee; level 80 absent 15 days is a returnee and sees key `oldplayerreturn`; active player sees `oldplayerreturn2`.
