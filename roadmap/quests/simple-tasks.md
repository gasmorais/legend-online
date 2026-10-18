# Simple tasks engine (proto package `simpletask`)

Area: quests, module `simple-tasks`. Covers the server side task engine behind the proto package `simpletask` (pushes 265 and 266, claim route 9564). Its only screen in this client is the newbie privilege window documented in [../vip/regist-welfare.md](../vip/regist-welfare.md); this file defines the engine contract so that screen and any future user agree.

Conventions: see [README.md](README.md).

## 1. Overview

Server defined one condition tasks (`type` + integer parameters + a free text `detail`), each with a free "normal" reward and an optional extra reward bought with diamonds. The client receives the task definitions (265) and the per player states (266) and claims with 9564. Task progress itself never reaches the client: only the state changes.

## 2. Screens

| Class | Purpose | Owner |
|---|---|---|
| `registwelfare.RegistWelfareFrame`, `RegistWelfareItem` (`decompiled/m11/scripts/registwelfare/`) | lists the tasks with states, claim and extra reward buttons | [../vip/regist-welfare.md](../vip/regist-welfare.md) |

## 3. Routes (client to server)

### ST1. Claim

- Sender: `RegistWelfareManager.receiveHandler(taskId, 1)` (normal) and `increaseHandler(taskId, 2)` (extra) (`decompiled/core_module/scripts/yishi/manager/RegistWelfareManager.as`).
- Route: C>S 9564 (0x255c) `C_SIMPLE_TASK_REWARD`, `simpletask.SimpleTaskReqMsg`: `task_id (#1, INT32)`; `reward_type (#2, INT32)` 1 normal, 2 extra.
- Expected response: item grants, diamonds (extra), then 266 with the new state.

## 4. Server messages (server to client)

### S1. 265 (0x0109) `U_C_SIMPLE_TASK_MSG`

- `simpletask.SimpleTaskListMsg`: `simpleTask (#1, simpletask.SimpleTaskMsg, repeated)`. `proto.json` keys `SimpleTaskMsg` to the colliding `leed.SimpleTaskMsg`; the real fields (`decompiled/core_module/scripts/com/road/yishi/proto/simpletask/SimpleTaskMsg.as`): `taskId (#1, INT32)`, `type (#2, INT32)` condition type, `detail (#3, STRING)` text, `iParam1..iParam5 (#4..#8, INT32)`, `sParam1 (#9, STRING)`, `extraRewardCost (#10, INT32)` diamonds, `generalReward (#11, SimpleTaskRewardMsg, repeated)`, `extraReward (#12, SimpleTaskRewardMsg, repeated)`. `SimpleTaskRewardMsg`: `rewardItemID (#1, INT32)`, `rewardItemCount (#2, INT32)`, `toJob (#3, INT32)` 0 any job.
- Receiver: `RegistWelfareManager.__taskMsgHandler` (`RegistWelfareManager.as:79`). When: login.

### S2. 266 (0x010a) `U_C_SIMPLE_TASK_RECORD_MSG`

- `simpletask.SimpleTaskRecordListMsg`: `simpleTaskRecord (#1, SimpleTaskRecordMsg, repeated)`; `SimpleTaskRecordMsg`: `task_id (#1, INT32)`, `task_state (#2, INT32)` -1 hidden, 0 in progress, 1 normal reward claimable, 2 normal claimed and extra purchasable.
- Receiver: `__taskRecordHandler` (`:80`). When: login, on every state change, after ST1.

## 5. Rules and formulas

- State machine: 0 -> 1 when the condition is met; 1 -> 2 on ST1 type 1; 2 -> -1 on ST1 type 2 (assumption, see the VIP module).
- Condition types: not defined by this client. Assumption: the same 27 goal types as the seven day objectives (`GuideTaskType`, [../tutorial/guide-tasks.md](../tutorial/guide-tasks.md) section 5) with `iParam1..4` as goal values, because both come from the same "SimpleTask" template family (`TempleteManager` category `SimpleTask`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1187`). The engine can also reuse the quest condition hooks ([quest-conditions.md](quest-conditions.md)) by mapping each type to a condition type.

## 6. Templates

None in `raw/xml/tempinfos/`; tasks are server configuration.

## 7. Persistent state

```sql
CREATE TABLE quests.simple_task (
    task_id            integer  PRIMARY KEY,
    task_group         text     NOT NULL,
    goal_type          smallint NOT NULL,
    detail             text     NOT NULL,
    iparam1            integer  NOT NULL DEFAULT 0,
    iparam2            integer  NOT NULL DEFAULT 0,
    iparam3            integer  NOT NULL DEFAULT 0,
    iparam4            integer  NOT NULL DEFAULT 0,
    iparam5            integer  NOT NULL DEFAULT 0,
    sparam1            text     NOT NULL DEFAULT '',
    extra_reward_cost  integer  NOT NULL DEFAULT 0,
    general_reward     jsonb    NOT NULL DEFAULT '[]'::jsonb,
    extra_reward       jsonb    NOT NULL DEFAULT '[]'::jsonb
);

CREATE TABLE quests.simple_task_state (
    player_id   integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    task_id     integer  NOT NULL REFERENCES quests.simple_task(task_id),
    progress    integer  NOT NULL DEFAULT 0,
    state       smallint NOT NULL DEFAULT 0 CHECK (state BETWEEN -1 AND 2),
    PRIMARY KEY (player_id, task_id)
);
```

## 8. Backend implementation notes

- `quests::simple_tasks::push_definitions` (265) and `push_states` (266) at login while the owning window (newbie privilege) is active.
- `quests::simple_tasks::record(player, goal_type, amount)` advances matching tasks and moves them to state 1; push 266.
- `quests::simple_tasks::handle_reward` (9564): type 1 requires state 1, grants `general_reward` filtered by `toJob`, sets 2; type 2 requires state 2, debits `extra_reward_cost` diamonds, grants `extra_reward`, sets -1; one transaction each; push 266.

## 9. Open questions and assumptions

- Goal type list (assumption above).
- Window end behavior is owned by [../vip/regist-welfare.md](../vip/regist-welfare.md).

## 10. Implementation checklist

- [ ] Tables `simple_task`, `simple_task_state`
- [ ] Pushes 265, 266
- [ ] Route 9564 types 1 and 2
- [ ] `record` hooks per goal type
