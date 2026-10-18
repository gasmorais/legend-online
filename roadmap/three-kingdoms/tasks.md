# Battlefield tasks

Aliases: see [README.md](README.md). Extra alias: RT = `raw/xml/tempinfos/RewardTemps.xml`.

## 1. Overview

The right HUD of map 8501 shows two task lists (`GRV:59-63`):

- **Server tasks** (`GodsEveningTaskView(1)`, title frame 1): against each enemy team, "Capturar o Líder" (kill its leader), "Força de Proteção" (kill its protector), "Devastador" (kidnap its god). Completing a server task gives points to every player of the server (help item 3).
- **Personal tasks** (`GodsEveningTaskView(2)`, title frame 2): 5101 "Despojos de Guerra" (collect enemy resources 5 times), 5102 "Invencível" (kill enemy players 5 times), 5103 "Emissário Protetor" (intercept a god kidnap once). They repeat; the title gets a roman numeral I to V from the completion count.

Claimed rewards are points (`RewardPlayGP`). Clicking an unfinished task walks to its target.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `GodsEveningTaskView` (GTV) | collapsible panel (`GTV:99-131`) | Task list sorted: completed and unclaimed first, claimed last, then by id (`GTV:168-194`) | right HUD | ids from `getTaskIds` (`GTV:196-237`) |
| `GodsEveningTaskItem` (GTI) | `Title`, "{0} (Concluído)", "{0} (Coletado)", "{0} Ⅰ" to "{0} Ⅴ" for personal tasks (`GTI:303-353`) | Claim or navigate | GTV | `Detail` + " (" progress "/" `RewardGold` ")" |

Server task ids per enemy team (`GTV:199-232`): team 1 enemy: 5001, 5011, 5021; team 2: 5002, 5012, 5022; team 3: 5003, 5013, 5023; the caller's own team is skipped. Personal ids: 5101, 5102, 5103.

Navigation on click when unfinished (`GTI:99-171`, `GTI:173-291`): 5001..5003 move to the leader node (850107..850109) of that team if not dead (`state != 9`); 5011..5013 to the protector (850104..850106); 5021..5023 to the god (850110..850112); 5101 to the nearest enemy resource node (type 91); 5102 locks the nearest enemy player (`LOCK_PVP_WARFIGHT`); 5103 locks an enemy carrying a god of the caller's team (state 12 or 10).

## 3. Routes (client to server)

### R1. Claim a task

- UI: click on a completed, unclaimed item (`GTI:109-118`). Already claimed: tip "Prêmio coletado".
- Client checks: `taskProgressDic[id] >= RewardGold` and not `taskGotRewardDic[id]`.
- Sender: `GodsEveningManager.sendGetTaskReward(templateId, userId, serverName)` (`GEM:421-430`).
- Route: C>S 25041 (0x61d1) `CR_GODS_PLAYER_OP`, `gods.CrossGodsMsg`: `op_type (#1, INT32)` = 1, `param1 (#5, INT64)` = template id, `user_id (#11, INT32)` = caller id, `server_name (#10, STRING)` = caller server name.
- Response: 247 with the updated `taskInfo` row and `my_info` scores.

## 4. Server messages (server to client)

247 `U_C_GODS_CAMPAIGN` ([battlefield.md](battlefield.md)), field `taskInfo (#9, GodsTaskInfoMsg, repeated)`, stored by `GEM:229-235`:

| Field | Tag, type | Meaning |
|---|---|---|
| `template_id` | #1 INT32 | `RewardTemps.TemplateId` |
| `cur_count` | #2 INT32 | progress (`taskProgressDic`) |
| `has_reward` | #3 BOOL | already claimed (`taskGotRewardDic`) |
| `repeat_count` | #4 INT32 | completions of a repeatable personal task (`taskCompleteCountsDic`, 1..5 used by the title) |

## 5. Rules and formulas

`RewardTemps.xml` rows used (Type 5):

| TemplateId | Title | Detail | Goal `RewardGold` | Points `RewardPlayGP` |
|---|---|---|---|---|
| 5001 / 5002 / 5003 | "Capturar o Líder" | "Eliminar o líder de Muspel / Nifl / Jötun 1 vez" | 1 | 200 |
| 5011 / 5012 / 5013 | "Força de Proteção" | "Eliminar um protetor de Muspel / Nifl / Jötun 1 vez" | 1 | 200 |
| 5021 / 5022 / 5023 | "Devastador" | "Saquear um deus da formação Muspel / Nifl / Jötun 1 vez" | 1 | 200 |
| 5101 | "Despojos de Guerra" | "Coletar os recursos do inimigo 5 vezes" | 5 | 200 |
| 5102 | "Invencível" | "Eliminar jogadores inimigos 5 vezes" | 5 | 200 |
| 5103 | "Emissário Protetor" | "Interceptar o saque de um deus 1 vez" | 1 | 200 |

Type 6 rows 6001 to 6003 ("Coletar recursos 5 vezes", "Derrotar outros jogadores 5 vezes", "Visitar 5 deuses no campo de batalha.", 50 points) are not referenced by the client (unused).

- In `RewardTemps` the field `RewardGold` is the goal, not gold (`GTI:109`, [docs/mechanics/world_progression.md](../../docs/mechanics/world_progression.md)).
- Server tasks: progress is shared by the whole team (any member's kill counts) and the claim gives points to every member (help item 3); points from server tasks do not count toward the server score (help item 4). Assumption: each member claims individually, and the claim adds `RewardPlayGP` to the claimer only, while completion adds the points to all members (choose one; the client only shows per player claim state).
- Personal tasks repeat up to 5 times (title numerals I to V); after a claim `cur_count` resets and `repeat_count` increments (assumption).
- Points go to `ready_score` in round 1 and `final_score` in round 2.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| RT | Type 5 rows 5001..5103 | `TemplateId`, `Title`, `Detail`, `RewardGold` (goal), `RewardPlayGP` (points) |

## 7. Persistent state

```sql
CREATE TABLE three_kingdoms.task_progress (
    event_id     bigint   NOT NULL REFERENCES three_kingdoms.events(event_id) ON DELETE CASCADE,
    game_state   smallint NOT NULL CHECK (game_state IN (1, 2)),
    player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id  integer  NOT NULL,
    cur_count    integer  NOT NULL DEFAULT 0,
    claimed      boolean  NOT NULL DEFAULT false,
    repeat_count smallint NOT NULL DEFAULT 0 CHECK (repeat_count BETWEEN 0 AND 5),
    PRIMARY KEY (event_id, game_state, player_id, template_id)
);

CREATE TABLE three_kingdoms.team_task_progress (
    event_id     bigint   NOT NULL REFERENCES three_kingdoms.events(event_id) ON DELETE CASCADE,
    game_state   smallint NOT NULL,
    server_id    integer  NOT NULL,
    template_id  integer  NOT NULL,
    cur_count    integer  NOT NULL DEFAULT 0,
    PRIMARY KEY (event_id, game_state, server_id, template_id)
);
```

## 8. Backend implementation notes

- Counters: battlefield events call `three_kingdoms::tasks::record(player, kind, target_team)`; server tasks update `team_task_progress` and push 247 `taskInfo` to the team; personal tasks update `task_progress`.
- `three_kingdoms::tasks::handle_claim` (25041 op 1): `param1` is a known id, `user_id`/`server_name` match the session, progress >= goal, not claimed. Transaction: mark claimed (personal: reset count and increment `repeat_count` while < 5), add points; push 247.

## 9. Open questions and assumptions

- Assumption: server task point distribution.
- Assumption: personal task repetition limit 5 from the title keys.
- Open: whether tasks reset between the preliminary and the final round (keyed by `game_state` here).

## 10. Implementation checklist

- [ ] Task lists in 247.
- [ ] Route 25041 op 1.
- [ ] Tables `three_kingdoms.task_progress`, `three_kingdoms.team_task_progress`.
- [ ] Counter hooks for kills, leader / protector kills, kidnaps, resource collection, interceptions.
- [ ] Tests: claim before goal refused; second claim of a server task refused; sixth repetition of 5101 refused.
