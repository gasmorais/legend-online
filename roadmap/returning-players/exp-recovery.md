# EXP recovery ("Recuperação de EXP")

Module `exp-recovery` of feature `returning-players`. Protobuf package `recover`.

Path aliases:

| Alias | File |
|---|---|
| EBM | `decompiled/core_module/scripts/yishi/manager/ExpBackManager.as` |
| EBF | `decompiled/m11/scripts/expback/ExpBackNewFrame.as` |
| QB | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as` |

## 1. Overview

"(EXP recuperável = número total de EXP surgida pelo sistema após estar offline)". The server accumulates experience the player missed while offline. The player can recover `RecoverRate[0]` = 50 % for free or `RecoverRate[1]` = 100 % for diamonds (`RecoverCost` = 50,10: upper and lower bound of the paid price).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ExpBackNewFrame` (EBF) | "Recuperação de EXP" | "Recuperar EXP:", free and paid options, "Consumir:" | queue bar button (QB:640-660, 728) when `VersionSwitch.RECOVER_BAK`, level >= 40, `backExp > 0`; daily activity frame (`decompiled/m11/scripts/dailyactivity/DailyActivityFrame.as:100`) | free `ceil(backExp * 50 / 100)`, paid `ceil(backExp * 100 / 100)`, cost `payPoint` (EBF:205-222); closes when nothing left |

## 3. Routes (client to server)

C>S 9503 (0x251f) `C_RECOVER`, `RecoverReqMsg { type (#1, INT32), count (#2, INT32), way (#3, INT32) }`, sender `EBM.sendExpBackRequest(type, way)` (EBM:50-57); `count` unused.

| Action | type | way | Call site | Client checks |
|---|---|---|---|---|
| Free | 0 | 1 | EBF:163-167 | none |
| Paid | 1 (bound diamonds allowed) or 2 (diamonds only) | 2 | EBF:169-199 | confirm "Deseja consumir {0} diamantes para recuperar {1} EXP?"; `allPoint >= payPoint` else recharge |

Server: grant experience share, zero the pool, push 4912 with `recoverGP = 0`.

## 4. Server messages (server to client)

### S1. 4912 (0x1330) `U_C_RECOVER`, `RecoverRspMsg`
Receiver EBM:40-48. `payPoint (#1, INT32)` diamond price of the paid option, `recoverGP (#2, INT32)` recoverable experience pool. Send at login and after 9503.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Free share | 50 % | `RecoverRate` |
| Paid share | 100 % | `RecoverRate` |
| Paid price bounds | 10..50 diamonds (assumption: scaled by pool) | `RecoverCost` |
| Level | 40 | QB:648 |

## 6. Templates

`ConfigInfos.xml`: `RecoverRate`, `RecoverCost`, `RECOVER_POINT` (10, "修行文章价格", unused by this frame).

## 7. Persistent state

```sql
CREATE TABLE returning_players.exp_recovery (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  pool_exp        BIGINT NOT NULL DEFAULT 0 CHECK (pool_exp >= 0),
  computed_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

`returning_players::exp_recovery::handle_recover`. On login compute the pool from offline time (assumption: per offline hour experience by level, capped), push 4912.

## 9. Open questions and assumptions

- Offline experience formula and price curve are unknown.

## 10. Implementation checklist

- [ ] Screen `ExpBackNewFrame` and queue bar button
- [ ] Route 9503 free and paid
- [ ] Server message 4912 at login
- [ ] Table `returning_players.exp_recovery`
- [ ] Tests: share math, bound diamond flag
