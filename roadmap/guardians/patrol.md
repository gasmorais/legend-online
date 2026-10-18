# Guardian patrol ("Patrulha do Guardião")

Module `patrol`. An idle progression map: the "Base Grande" (headquarters, tower id 100) and up to several "Torre de Vigia" (watch towers). Guardians are garrisoned in a building to give it exp (level up), sent on tower patrol missions of three difficulties (normal, difícil, pesadelo) whose conditions check the guardians, may cause riots ("Casos de distúrbio") that friends can resolve, can explore a tower, and towers host the "Guardiões Procurados" bosses (`pve.md`). Friends' patrols can be visited.

Path aliases:

| Alias | File |
|---|---|
| PM | `decompiled/core_module/scripts/managers/ChildPatrolManager.as` |
| PMOD | `decompiled/core_module/scripts/mvc/module/childpatrol/ChildPatrolModel.as` |
| PTI | `decompiled/core_module/scripts/mvc/module/childpatrol/ChildPatrolTowerInfo.as` |
| PCC | `decompiled/core_module/scripts/mvc/module/childpatrol/ChildPatrolConstClass.as` |
| PCH | `decompiled/core_module/scripts/mvc/module/childpatrol/ChildPatrolCheckCondictionHelper.as` |
| PC | `decompiled/core_module/scripts/mvc/controler/ChildPatrolControler.as` |
| V | `decompiled/m14/scripts/childpatrol/` |

## 1. Overview

- Send 9578 (0x256a) `C_CHILD_PATROL_REQUEST`, `ChildPatrolRequestMsg`: `op` (#1, INT32), `userid` (#2, INT32, owner of the patrol being viewed/helped), `pay_type` (#3, INT32; default 2 in `PM.sendChildPatrolOperate`, views pass 0), `tower_id` (#4, INT32), `childIdList` (#5, INT32 repeated).
- Ops (`PCC`): 1 ATLAS (open/view a patrol), 2 REFRESH_STATE, 3 DISPATCH (garrison guardians to level a building), 4 CANCEL_DISPATCH, 5 PATROL (start missions), 6 REFRESH_TASK, 7 GET_REWARD, 8 HELP (resolve a riot on a friend's tower), 9 REFRESH_QUEUE, 10 EXPLORE, 11 CANCEL_EXPLORE, 12 BOSS_STATE (wanted boss positions).
- Send 9579 (0x256b) `C_CHILD_PATROL_FRIEND_STATE`, `ChildPatrolFriendStateRequestMsg.friendUseridList` (#1, INT32 repeated) -> 302.
- Receive 303 (0x012f) `U_C_CHILD_PATROL_TOWER_LIST` (`ChildPatrolMsg`), 302 (0x012e) `U_C_CHILD_PATROL_FRIEND_STATE`, 304 (0x0130) `U_C_CHILD_PATROL_QUICK`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from |
|---|---|---|---|
| `V/ChildPatrolHallFrame.as` (+ `V/ChildPatrolHallTowerView.as`, `V/ChildPatrolLeftListView.as`, `V/ChildPatrolLeftItemView.as`, `V/ChildPatrolFriendsListView.as`, `V/ChildPatrolFriendItem.as`) | "Patrulha do Guardião", help "Instruções da Patrulha do Guardião" | map of HQ and towers, guardian list ("Torre de Vigia {0}" / "Inativo"), friends | `PC` openType 1: queue bar item "Patrulha do Guardião {0}/{1}" (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:322`), NPC (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:696`), day guide, task tip |
| `V/ChildPatrolHeadQuartersFrame.as` | "Base Grande" | garrison guardians in the HQ | openType 2 |
| `V/ChildPatrolTowerFrame.as` (+ `V/ChildPatrolTaskView.as`, `V/ChildPatrolTowerExpView.as`, `V/ChildPatrolTowerAffectView.as`, `V/ChildPatrolExploreView.as`, `V/ChildPatrolBottomView.as`) | "Torre de Vigia", "Patrulha Normal" / "Patrulha Difícil" / "Patrulha Pesadelo" | tower: missions, garrison, exploration | openType 3 |
| `V/ChildPatrolRiotFrame.as` | "Casos de distúrbio", "Perto da Torre de Vigia iniciou um distúrbio...", "Nº restante:  {0}/{1}" | help a riot | openType 4 |
| `V/ChildPatrolPointFrame.as`, `V/ChildPointBossItem.as` | "Posição de Guardião Procurado" | wanted boss positions | `pve.md` |

## 3. Routes (client to server)

All via `PM.sendChildPatrolOperate(op, userid, payType, towerId, childIdList)` (`PM:278-291`).

| op | UI / sender | Fields | Client checks | Response |
|---|---|---|---|---|
| 1 | hall open `V/ChildPatrolHallFrame.as:79`, `:307`; friend visit `V/ChildPatrolFriendsListView.as:360` | `userid` = owner | | 303 `op` 1 (full state, resets the model) |
| 2 | refresh building state `V/ChildPatrolHallFrame.as:205`, `:220` | `tower_id` | | 303 |
| 3 | garrison (level up) `V/ChildPatrolBottomView.as:168-195` | `tower_id`, `childIdList` | not max level ("A base grande atual já atingiu o nível máximo" / "A torre de vigia atual..."), tower 9 -> 10 needs HQ 10 ("A Base Grande tem de atingir o nv. 10"), guardians selected ("Favor selecionar guardião para patrulhar") | 303 (`on_garrison`, times, exp) |
| 4 | cancel garrison `V/ChildPatrolBottomView.as:226-243` | `tower_id` | confirm "Deseja cancelar patrulha do guardião atual?\nEXP acumulada obtida: {0}" with `garrisonExpPerMinute * elapsedMinutes` | 303 |
| 5 | start patrol missions `V/ChildPatrolBottomView.as:196-205` | `tower_id`, `childIdList` | guardians satisfy at least the normal mission (`PMOD.checkIsReached(1, ...)`, `PCH`) else "Guardião colocado não satisfaz as condições básicas (Patrulha Normal), não poderá iniciar" | 303 (patrol times, mission ids) |
| 6 | refresh missions `V/ChildPatrolTaskView.as:170-225` | `tower_id`, `pay_type` | not during a patrol ("No estado atual não é possível atualizar..."), free refreshes `freeCount` or confirm "Deseja consumir {0} diamantes para atualizar missão?" (`child_patrol_mission_refresh_point` 10) | 303 |
| 7 | collect reward `V/ChildPatrolBottomView.as:245-251`, `V/ChildPatrolHallTowerView.as:158` | `tower_id` | tower `state == 3`; not on a friend's tower ("Não é possível coletar o prêmio da torre de vigia do amigo") | 303 `op` 7 (refresh `isAlertReward`), bag 115 |
| 8 | help a riot `V/ChildPatrolRiotFrame.as:120-133` | `userid` = friend, `tower_id`, `childIdList` = [one guardian] | daily help count ("Hoje você já atingiu o limite máximo de auxílio do distúrbio") | 303 for the friend's patrol, reward `child_patrol_rebellion_reward` |
| 9 | refresh queue `PMOD:340-350` | | | 304 |
| 10 | explore `V/ChildPatrolBottomView.as:149-160` | `tower_id`, `childIdList` | guardians selected ("Você não colocou guardiões ou espíritos de proteção."), tower level 10 ("Ativado quando a Torre de Vigia atinge o nível 10") | 303 (`explore_child_id`, `explore_count_down`) |
| 11 | cancel/finish explore `V/ChildPatrolBottomView.as:162-167` | `tower_id` | | 303, rewards (`ExploreRewardInfo` in `GuardPVETemp.xml` by guardian grade and `isSpirit`) |
| 12 | boss state | | | 303 `op` 12 (tower `boss_id`, `boss_stats` only, `PM:122-126`) |

### Friend states (9579)
- UI: friend list refresh (`V/ChildPatrolFriendsListView.as:210-220`) sends the visible friend ids. Response: 302.

## 4. Server messages (server to client)

### S1. 303 (0x012f) `U_C_CHILD_PATROL_TOWER_LIST`, read as `ChildPatrolMsg`
Receiver `PM.__updateChildPatrolHandler` (`PM:71-190`). `op` 1 resets the model and sets `curUserId`; other ops are ignored when `userid` differs from the viewed patrol.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | echo of the request op |
| `userid` | #2 | INT32 | patrol owner |
| `headquarters` | #3 | ChildPatrolTowerMsg | HQ (tower 100) |
| `towerList` | #4 | ChildPatrolTowerMsg repeated | towers |
| `freeCount` | #5 | INT32 | free mission refreshes left |

`ChildPatrolTowerMsg`: `tower_id` #1, `state` #2 (3 = reward ready), `level` #3, `exp` #4, `garrisonChildIdList` #5 (repeated), `garrison_start_time` #6 INT64 ms, `garrison_end_time` #7 INT64 ms, `patrolChildIdList` #8 (repeated), `patrol_start_time` #9, `patrol_end_time` #10, `normal_mission_id` #11, `normal_mission_reached` #12 BOOL, `hard_mission_id` #13, `hard_mission_reached` #14, `nightmare_mission_id` #15, `nightmare_mission_reached` #16, `garrison_exp_per_minute` #17, `on_garrison` #18 BOOL, `garrison_count_down` #19 INT64 ms, `patrol_count_down` #20 INT64 ms, `explore_child_id` #21, `explore_count_down` #22 INT64 ms, `boss_id` #23, `boss_stats` #24 (1 = beaten). Times are divided by 1000 client side.

Note: `protocol/proto.json` also has `ChildPatrolTowerListMsg` (no `freeCount`); the client reads `ChildPatrolMsg` for 303.

### S2. 304 (0x0130) `U_C_CHILD_PATROL_QUICK`, `ChildPatrolQuickMsg`
Receiver `PM.__updateChildPatrolQueue` (`PM:212-242`): `idle_count` #1, `total_count` #2 (queue bar "Patrulha do Guardião {0}/{1}"), `reward` #3 BOOL (reward ready -> task tip "Missão de patrulha do Guardião na Torre de Vigia concluída, favor coletar os prêmios." in castle or space). The client refreshes every 1800 s. Send at login and when counts change.

### S3. 302 (0x012e) `U_C_CHILD_PATROL_FRIEND_STATE`, `ChildPatrolFriendStateListMsg`
Receiver `PM.__updateChildPatrolFriendStateList` (`PM:192-210`): `friendState` repeated {`userid` #1, `state` #2 (riot or reward marker *(assumption)*)}.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| HQ levels | `UpGradeTempInfos` Types 114 (1..10): `TemplateName` = "openTowers,normalMinus,hardMinus,nightmareMinus" (towers open 1..4, minutes cut), `Data` = exp to level | `PMOD:64-67`, `:440-462` |
| Tower levels | Types 115 (1..10): "patrolCount,normalMinus,hardMinus,nightmareMinus" | `PMOD:182` |
| Garrison | `child_patrol_garrison_time` 360 min, exp per minute by guardian level ("Quanto mais alto for o nível do guardião mais exp. obterá") | config, strings |
| Mission time | `child_patrol_mission_time` 240,240,240 minutes minus HQ and tower cuts | `PMOD.getTaskNeedTimeByChildList` (`:500-530`) |
| Missions | `ChildPatrolMissionTempInfos.xml` (78): `Diffculty` 1..3, `MissionType` (1 skill level, 2 guardian level, 3 emblem level, 4..10 resistances, 11 equipment quality), `TargetValue`, `CalcType`, `NeedJob`, up to 3 rewards; higher difficulty requires the lower one; difficulty unlock by tower level ("Torre de Vigia ao atingir nv.{0} poderá ativar missões de esta dificuldade") | `PCH` |
| Patrol size | guardians per patrol from the HQ row (`getCanPatrolChildCount`, `PMOD:440-462`; special types 2..5 fixed 1 or 4) | |
| Riots | chance `child_patrol_rebellion_rate` 20%, lasts `child_patrol_rebellion_time` 60 min, max 3 at once, unresolved adds `child_patrol_punish_time` 120 min, solver reward 2250001 x3, helper limit `child_patrol_max_help_count` 10 per day | config |
| Refresh | 10 diamonds or free count (`map.campaign.view.ui.childpatrol.freeTip`: Elf contract gives 10 free) | config |
| Spirits | at tower level 10 spirits can be placed in missions to complete any difficulty instantly ("Colocar Espíritos de Proteção em Torres de Vigia permite completar de imediato...") | strings |
| Busy guardians | a guardian on patrol/exploration cannot be used elsewhere ("No momento está em patrulha...", "Está explorando...") | strings |

## 6. Templates

`ChildPatrolMissionTempInfos.xml`, `UpGradeTempInfos.xml` Types 114/115, `GuardPVETemp.xml` (`ExploreRewardInfo`: `isSpirit`, `grade`, `itemId`, `count`), `ConfigInfos.xml` (`child_patrol_*`).

## 7. Persistent state

```sql
CREATE TABLE guardians.patrol_buildings (
  player_id          BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  tower_id           SMALLINT NOT NULL,
  level              SMALLINT NOT NULL DEFAULT 1 CHECK (level BETWEEN 1 AND 10),
  exp                INTEGER  NOT NULL DEFAULT 0,
  state              SMALLINT NOT NULL DEFAULT 0,
  garrison_child_ids INTEGER[] NOT NULL DEFAULT '{}',
  garrison_start_at  TIMESTAMPTZ,
  garrison_end_at    TIMESTAMPTZ,
  patrol_child_ids   INTEGER[] NOT NULL DEFAULT '{}',
  patrol_start_at    TIMESTAMPTZ,
  patrol_end_at      TIMESTAMPTZ,
  normal_mission_id  INTEGER  NOT NULL DEFAULT 0,
  normal_reached     BOOLEAN  NOT NULL DEFAULT FALSE,
  hard_mission_id    INTEGER  NOT NULL DEFAULT 0,
  hard_reached       BOOLEAN  NOT NULL DEFAULT FALSE,
  nightmare_mission_id INTEGER NOT NULL DEFAULT 0,
  nightmare_reached  BOOLEAN  NOT NULL DEFAULT FALSE,
  explore_child_id   INTEGER  NOT NULL DEFAULT 0,
  explore_end_at     TIMESTAMPTZ,
  boss_id            INTEGER  NOT NULL DEFAULT 0,
  boss_state         SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, tower_id)
);

CREATE TABLE guardians.patrol_riots (
  riot_id      BIGSERIAL PRIMARY KEY,
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  tower_id     SMALLINT NOT NULL,
  started_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at   TIMESTAMPTZ NOT NULL,
  resolved_by  BIGINT   REFERENCES player.players(player_id)
);

CREATE TABLE guardians.patrol_daily (
  player_id        BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  free_refresh_left SMALLINT NOT NULL DEFAULT 0,
  help_count       SMALLINT NOT NULL DEFAULT 0,
  reset_on         DATE    NOT NULL DEFAULT CURRENT_DATE
);
```

## 8. Backend implementation notes

Handlers `guardians::patrol::handle_<action>` for ops 1..12 (`view`, `refresh_state`, `garrison`, `cancel_garrison`, `start_patrol`, `refresh_missions`, `collect_reward`, `help_riot`, `refresh_queue`, `explore`, `cancel_explore`, `boss_state`) and `guardians::patrol::handle_friend_states` (9579).

- Timers: garrison end (grant building exp = per minute rate x minutes, level up by Types 114/115), patrol end (evaluate missions with `PCH` rules, set `state` 3), riot spawn on patrol ticks (20%), riot expiry (punish 120 min), exploration end. Use a scheduler keyed by `*_end_at`; on completion push 303 and 304 to the owner if online.
- Guardian lock: a guardian in any `garrison_child_ids`, `patrol_child_ids` or `explore_child_id` is busy for other modes.
- Friends: op 1 with another `userid` must check friendship ([friends](../friends/README.md)).

## 9. Open questions and assumptions

- *(assumption)* Exact garrison exp per minute formula and `pay_type` meaning in op 6 (0/1 diamonds vs bound).
- *(assumption)* 302 `state` values.
- *(assumption)* Tower ids other than 100 (1..n).

## 10. Implementation checklist

- [ ] 9578 ops 1..12, 9579.
- [ ] Pushes 303, 304, 302.
- [ ] Tables `guardians.patrol_buildings`, `guardians.patrol_riots`, `guardians.patrol_daily`.
- [ ] Scheduler for garrison, patrol, riot, exploration.
- [ ] Mission condition evaluator (11 mission types).
- [ ] Tests: tower 9 -> 10 rejected with HQ 9; patrol start rejected when normal mission unmet; reward only in state 3; help limit 10 per day.
