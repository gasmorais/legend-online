# Login event ("Evento de Login")

Area: daily-activity, module `login-activity`. Covers `loginactivity.LoginActiveFrame`, `loginactivity.view.LoginCountView`, `LoginActiveItem`, `LoginContinueView`, `LoginContinueItem` (m11), `mvc.controler.LoginActiveControler`, and the two "funny" activity types it reads: 131 (`FunnyType.LOGIN_ACTIVE`, cumulative login days) and 231 (`FunnyType.LOING_CONTINUE_DAYS`, consecutive login days).

Conventions: see [README.md](README.md). The generic activity engine ("funny": activity templates 4475, user data 4476, package claim 8586) belongs to [seasonal-events](../seasonal-events/README.md); this module only defines how the login event uses it.

## 1. Overview

A time limited event with a top toolbar button "Evento de Login" (template 2006 "登录活动奖励按钮"). The left panel lists up to 7 packages "Login {n} dias" for cumulative login days; while a consecutive login event (type 231) is also running, a right panel shows packages for consecutive days, the event period and the current streak. Each package is claimed once when its day condition is met.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `loginactivity.LoginActiveFrame` (`decompiled/m11/scripts/loginactivity/LoginActiveFrame.as:22`), width 455 or 840 | "Evento de Login" (`loginactivity.LoginActiveFrame.titleText`, `:91`) | Requests fresh data on open (`sendGetBag(1)`, `:25`); shows `LoginContinueView` only when type 231 is active (`:54-:78`) | top toolbar key `loginactive` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1233`), controller `decompiled/core_module/scripts/mvc/controler/LoginActiveControler.as:14` | `FunnyModel.loginActiveData`, `continueLoginData` |
| `loginactivity.view.LoginCountView` (`decompiled/m11/scripts/loginactivity/view/LoginCountView.as:31`) | "Dias de login", "Obter Prêmio" | rows for each package of type 131 (`refreshView` `:53`) | frame | `FunnyData.bagList` |
| `loginactivity.view.LoginActiveItem` (`decompiled/m11/scripts/loginactivity/view/LoginActiveItem.as:35`) | "Login {value} dias" | items; status 1 button enabled, 2 claimed stamp, 3 button disabled (`:99-:115`) | view | `FunnyBagData` |
| `loginactivity.view.LoginContinueView` (`decompiled/m11/scripts/loginactivity/view/LoginContinueView.as:35`) | period "start--end", streak digits | packages of type 231 | frame | `startTime`, `endTime`, `finishNum` |
| `loginactivity.view.LoginContinueItem` (`decompiled/m11/scripts/loginactivity/view/LoginContinueItem.as:32`) | day count, get button | same status rules (`:96-:113`) | view | `FunnyBagData` |

Top button visibility: `FunnyModel.loginActiveData != null` and the scene allows top buttons (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:337`). `loginActiveData` is the first funny activity of type 131 with `showStart < now < showEnd` (`decompiled/core_module/scripts/mvc/module/funny/FunnyModel.as:543`); `continueLoginData` the same for type 231 (`:558`).

## 3. Routes (client to server)

### LA1. Refresh event data

- UI: frame construction (`LoginActiveFrame.as:25`).
- Sender: `FunnyManager.sendGetBag(1)` `decompiled/core_module/scripts/managers/FunnyManager.as:969`.
- Route: C>S 8586 (0x218a) `C_SUMACTIVE_GATE`, `active.SumActiveGetPackageMsg`: `activeId (#1, STRING)` empty; `packageId (#2, STRING)` empty; `type (#3, INT32)` = 1 refresh; `count (#4, INT32)` = 1.
- Expected response: S>C 4476 `U_C_SUMACTIVE_DATA` with the player's package states.

### LA2. Claim a package

- UI: row button (`LoginActiveItem.__clickHandler` `decompiled/m11/scripts/loginactivity/view/LoginActiveItem.as:70`, `LoginContinueItem.__getBtnClickHandler` `decompiled/m11/scripts/loginactivity/view/LoginContinueItem.as:66`), enabled only with status 1.
- Route: C>S 8586 `SumActiveGetPackageMsg`: `type = 2` claim; `activeId` = the activity id; `packageId` = the package id; `count = 1`.
- Expected response: item grants, then 4476 with the package status 2; the funny manager fires `LOGIN_ACTIVE_CHANGE` (`decompiled/core_module/scripts/managers/FunnyManager.as:777`) which refreshes the frame.

## 4. Server messages (server to client)

### S1. 4475 (0x117b) `U_C_SUM_ACTIVE_TEMP`

- `active.SumActivesMsg`: `actives (#1, SumActiveinfoMsg, repeated)`, `dataStamp (#2, INT32)` version (a higher stamp clears the cached list), `curPage (#3, INT32)`, `maxPage (#4, INT32)`.
- `SumActiveinfoMsg` fields used here: `active_id (#1, STRING)`; `begin_date (#2, STRING)` and `end_date (#3, STRING)` period; `title (#4, STRING)`; `detail (#5, STRING)`; `active_type (#9, INT32)` = 131 or 231; `start_time (#10, STRING)` and `stop_time (#11, STRING)` display window (`showStart`, `showEnd`); `packages (#8, SumActivePackageMsg, repeated)`.
- `SumActivePackageMsg`: `packageId (#1, STRING)`; `order (#2, INT32)`; `items (#3, SumActiveItemInfoMsg, repeated)` (`template_id (#1)`, `template_type (#2)`, `count (#3)`, `isbind (#4)`, `length (#5)`, `job (#6)`); `conditions (#4, PackageConditionMsg, repeated)`, first condition `condition_value (#2)` = required login days.
- Receiver: `FunnyManager.__funnyTemHandler` `decompiled/core_module/scripts/managers/FunnyManager.as:409`. When: login (`PlayerDataMsg.sum_active = true`) and when events change.

### S2. 4476 (0x117c) `U_C_SUMACTIVE_DATA`

- `active.SumActiveDataMsg`: `datas (#1, ActiveData, repeated)`; `ActiveData`: `packdata (#1, PackageData, repeated)`, `value (#2, INT32)` progress (login days or streak, shown as `finishNum`), `activeId (#3, STRING)`, `is_show (#4, BOOL)`, `type (#5, INT32)`, `activeCharge (#6, INT32)`; `PackageData`: `packId (#1, STRING)`, `status (#2, INT32)` 1 claimable, 2 claimed, 3 not reached, `countDown (#3)`, `is_show (#4)`, `param1 (#5)`, `finish_value (#6)`, `get_count (#7)`.
- Receiver: `FunnyManager.__funnyUserHandler` `decompiled/core_module/scripts/managers/FunnyManager.as:643`. When: login, after LA1 and LA2, after a new login day.

## 5. Rules and formulas

- Type 131: `value` = number of distinct days logged in during the event; package status 1 when `value >= condition_value` and not claimed.
- Type 231: `value` = current consecutive login streak; assumption: a missed day resets the streak but already claimed packages stay claimed.
- The frame widens to 840 only while type 231 is active.

## 6. Templates

None in `raw/xml/tempinfos/`. Events are server data sent through 4475 (configured per server by the operator).

## 7. Persistent state

Uses the generic funny activity tables of [seasonal-events](../seasonal-events/README.md) for the event definitions and claims. Login specific counter:

```sql
CREATE TABLE daily_activity.login_event_progress (
    player_id      integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    active_id      text     NOT NULL,
    login_days     smallint NOT NULL DEFAULT 0,
    streak_days    smallint NOT NULL DEFAULT 0,
    last_login_on  date,
    PRIMARY KEY (player_id, active_id)
);
```

## 8. Backend implementation notes

- On the first login of each day, for every active event of type 131 or 231, update `login_days` or `streak_days`, recompute package statuses and push 4476 for that event.
- Claims (8586 type 2) are handled by the generic funny handler `seasonal_events::funny::handle_gate`; for types 131 and 231 it validates `status == 1` and grants items in one transaction.

## 9. Open questions and assumptions

- Streak reset rule for type 231 (assumption above).
- Whether login days count before the event start is unknown (assumption: no).

## 10. Implementation checklist

- [ ] Top button 2006 visible when a type 131 event is in its show window
- [ ] Login day and streak tracking per event
- [ ] 4475 / 4476 payloads for types 131 and 231
- [ ] Claim through 8586 type 2
- [ ] Test: status transitions 3 -> 1 -> 2, frame width with and without type 231
