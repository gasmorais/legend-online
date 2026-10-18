# Cycle quest ("Missão de Ciclo (Semanal)")

Area: quests, module `ring-task`. Covers `managers.RingTaskManager`, `mvc.module.ringtask.RingTaskModel` and `RingTask`, the cycle quest menu of `task.TaskFrameII` (menu type -2), the trace bar ring entry, the NPC accept dialog, routes 8729 to 8732 and pushes 4614 to 4617, and the templates `RewardTemps` Types 1, 2, 3 with `RewardGoods` TemplateId 1000.

Conventions: see [README.md](README.md).

## 1. Overview

From level 35 the player takes chained quests from Asuna in the Reino dos Céus ("Ir ao Reino dos Céus receber missão da Asuna"). Each quest is one random task of the player's level band (tribute troops, collect items, deliver a message, kill monsters, mini games, deliver a shop item, sacrifice an Einherjar). Completing it gives fixed gold and spirit by level band and immediately offers the next quest; every 10 completions also grants a milestone chest. The chain allows 200 completions per week ("Concluídos {0} / 200", "Missão de Ciclo (Semanal)"). Any quest can be finished instantly for 10 diamonds or one "Passaporte do Império" (item 2131021, used first).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `task.TaskFrameII` menu "Ciclo" (type -2) | "Missão de Ciclo", "(Concluídos {0} / 200)" (`task.view.TaskTargetViewII.ringTaskNum`) | current cycle quest or, when none is accepted, the resident template "Receber" (`RingTaskManager.getOfferTemplete` `decompiled/core_module/scripts/managers/RingTaskManager.as:85`); claim, "Concluir agora", start mini game | menu visible at level >= 35 (`decompiled/m15/scripts/task/view/TaskMenuII.as:158`); list `decompiled/m15/scripts/task/view/TaskListView.as:258-:270` | `RingTaskModel.hasAccessList`, `rewardNum` |
| `task.view.TaskDescribeViewII` (`decompiled/m15/scripts/task/view/TaskDescribeViewII.as:67-:94`) | `Detail` with `{0}` = campaign name (type 18, `condition_2`) or item name (type 19, `condition_3`) and `{1}` = shop name ("Guilda", "PvP", "Labirinto" for `condition_2` 2, 3, 4) | description | frame | `currTask` |
| `task.view.TaskRewardViewII` | gold, spirit; milestone items | fixed band rewards (`decompiled/m15/scripts/task/view/TaskRewardViewII.as:140-:167`), items of the current milestone or, for the resident template, the 10/50/200 previews (`RingTaskManager.getAllRingTaskGoodsReward` `:342`) | frame | `RewardGoods` |
| Trace bar ring item (`decompiled/core_module/scripts/ui/tasktracebar/view/TaskTraceItem.as:328-:349`) | "Ciclo", "({n} / 200ciclos)", "Concluir" | quick finish and submit | trace bar | |
| Space NPC dialog option (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:389-:399`) | "Missão de Ciclo", "Começar", "Missão completada" | accept | NPC Asuna, node 10000,17 | |

## 3. Routes (client to server)

| # | UI control and sender | Route | Body | Client checks | Expected response |
|---|---|---|---|---|---|
| R1 | NPC option type 11 with param 17 (`DialogOptionItem.as:395`) -> `RingTaskManager.accessRingTask` `decompiled/core_module/scripts/managers/RingTaskManager.as:245` | C>S 8732 (0x221c) `C_TAKE_REPEAT_REWARD` | none | level >= 35 | 4614 with the new quest (`RewardInfo`, `is_select` true; for type 18/19 the rolled values in `condition_2`, `condition_3`, `condition_4`) |
| R2 | claim (`TaskFrameII.__getRewardHandler` `decompiled/m15/scripts/task/TaskFrameII.as:701`, trace item `TaskTraceItem.as:619`, completion tip `decompiled/core_module/scripts/yishi/view/community/CompleteTaskTip.as:127`) -> `submitRingTask` `:251` | C>S 8729 (0x2219) `C_REPEAT_REWARD_FINISH` | none | `RingTask.isCompleted` | gold and spirit (3), milestone items (bag), 4614 with the finished quest `is_complete` true and the next quest, 4616 with the new count |
| R3 | "Concluir agora" (`TaskFrameII.__completeNowHandler` `:756`, `quickSubmit` `:735`; trace `TaskTraceItem.ringTaskQuickHandler` `:373`) -> `CompletedImmediately(useBind)` `:257` | C>S 8730 (0x221a) `C_REPEAT_REWARD_FINISH_IMMEDIATELY` | `simple.PropertyMsg`: `param1 (#1, INT32)` 0 = bound diamonds allowed, 1 = unbound only | confirm "Use {0} diamantes para completar esta missão (Uso prioritário do Passaporte do Império )" (remember choice); `point` (or `allPoint`) >= 10 or owns item 2131021, else recharge popup | same as R2 |
| R4 | automatic when a client checked condition becomes true: QTE or Mata-Rato success, NPC talk finished, troop count or item count reached (`decompiled/core_module/scripts/mvc/module/ringtask/RingTask.as:261`, `:324`, `:350`, `:382`, `:487`; NPC dialog "Concluir" `decompiled/m3/scripts/map/campaign/view/frame/PetLandDialogFrame.as:143`) -> `updataState` `:265` | C>S 8731 (0x221b) `C_REPEAT_REWARD_UPDATE_FINISH` | none | | 4614 with the quest counters updated (for type 16, `condition_1 >= 1`) |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When |
|---|---|---|---|
| 4614 (0x1206) `U_C_REPEAT_REWARD_UPDATE` | `reward.RewardUpdatedRspMsg` (`reward (#1, RewardInfo, repeated)`; fields in [offer-reward.md](offer-reward.md) S2) | `RingTaskManager.__refreshTaskHandler` `RingTaskManager.as:120`: known id with `is_complete` -> removed (`COMPLETETASK`); known id -> counters updated; new id -> new `RingTask` (milestone items attached when `rewardNum % 10 == 0`) | login (assumption: in the 8224 load), after R1 to R4, on progress |
| 4616 (0x1208) `U_C_REPEAT_REWARD_FNISHED_SUM_UPDATE` | `simple.PropertyMsg`: `param1 (#1, INT32)` cycle quests completed this week | `__refreshRingNumHandler` `:177`; the model shows `param1 + 1` as the current quest number (`RingTaskModel.rewardNum` `decompiled/core_module/scripts/mvc/module/ringtask/RingTaskModel.as:20`) and refreshes the resident template | login, after R2 and R3, weekly reset |
| 4615 (0x1207) `U_C_REPEAT_REWARD_END` | (body ignored) | `__finishAllTaskHandler` `:173` (empty) | optional: chain finished (200 reached) |
| 4617 (0x1209) `U_C_REPEAT_REWARD_FINISH` | (body ignored) | `__finishTaskHandler` `:116` (empty) | optional: quest finished |

## 5. Rules and formulas

- Unlock: level 35 (menu, NPC, `updateRingTaskMsg` `RingTaskManager.as:200`).
- Weekly cap 200 (`rewardNum > 200` hides the resident template, `:192`); reset weekly (title "Semanal"; assumption: Monday 00:00 like activity points).
- Resident template (Type 3, ids 2438 to 2441 "Receber", condition 21) chosen by `NeedMinLevel <= level < NeedMaxLevel`; never completable (`RingTask.isCompleted` returns false for Type 3, `decompiled/core_module/scripts/mvc/module/ringtask/RingTask.as:288`); its "Ir" walks to node 10000,17.
- Fixed rewards per quest by level band (overrides the template values, `RingTaskManager.updateRingTaskMsg` `:211-:229`, `decompiled/m15/scripts/task/view/TaskRewardViewII.as:140-:167`): 35..44 gold 400000 spirit 2000000; 45..54 480000 / 2400000; 55..64 600000 / 3000000; 65..99 800000 / 4000000.
- Milestones: when the completed count reaches a multiple of 10, grant `RewardGoods` rows with `TemplateId 1000`, `RepeatStep` = count and `RepeatMinLevel <= level < RepeatMaxLevel` (`getRewardGoods` `:276`): 35..45: "Cristal de Almas" 208014 x40 (x80, x120, x200 in the higher bands), every 50: "Baú na Nobreza Baixo" 2060409 (bands: 2060411 "Baú da Nobreza Médio", 2060413 "Baú da Nobreza Alto", 2060710 "Baú da Nobreza Especial"), at 200: "Baú da Realeza Baixo" 2060410 (2060412, 2060414, 2060711).
- Quest roll: Type 1 and 2 templates of the band (35..45, 45..55, 55..65, 65..100); `Rands` weight (assumption).
- Instant finish: 10 diamonds, or one item 2131021 first.
- Conditions (`RingTask.getProgress` `:120`; navigation `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:561-:634`):

| Type | Meaning | Progress | "Ir" |
|---:|---|---|---|
| 1 | castle troops of `SonType` Para1 >= Para2 (tribute) | client pawn count; 8731 when reached | barracks |
| 2, 3, 5 to 11, 13, 14, 17, 20 | server counters (`condition_N >= Para2`); 17 = Einherjar island floor Para1 monsters, 20 = sacrifice an Einherjar | server | per type; 17 walks Para4; 20 opens the pet frame |
| 4 | item Para1 x Para2 in bag plus guild warehouse (`getCount` `:518`) | client; 8731 when reached | walk Para4 |
| 12 | QTE training success | client flag; 8731 | start button |
| 15 | Mata-Rato success | client flag; 8731 | start button |
| 16 | deliver a message to NPC node Para1 (walk Para4) | NPC dialog "Concluir" -> 8731; server sets `condition_1 = 1` | walk Para4 |
| 18 | kill monsters in a rolled campaign: `condition_1` progress, `condition_4` goal, `condition_2` campaign id | server | campaign `condition_2` |
| 19 | deliver item `condition_3` bought in shop `condition_2` (2 guild, 3 PvP, 4 maze) | client: bag holds >= 1 | open shop `condition_2` |
| 21 | resident "Receber" | never | walk 10000,17 |

## 6. Templates

| File | Rows used | Fields |
|---|---|---|
| `raw/xml/tempinfos/RewardTemps.xml` | Type 1 (131 rows, ids 21xx..), Type 2 (7, "Tributar Recursos", "Sacrifício de Einherjar"), Type 3 (4 resident) | see [offer-reward.md](offer-reward.md) section 6; `RewardGold` 2000 / `RewardStrategy` 10000 are overridden by the band table |
| `raw/xml/tempinfos/RewardCondictionInfos.xml` | conditions of those templates | `Para5` holds the NPC story text |
| `raw/xml/tempinfos/RewardGoods.xml` | `TemplateId 1000` (80 rows: 20 steps x 4 bands) | `RewardItemID`, `RewardItemCount`, `RepeatMinLevel`, `RepeatMaxLevel`, `RepeatStep` |

## 7. Persistent state

```sql
CREATE TABLE quests.cycle_progress (
    player_id       integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    week_start      date        NOT NULL,
    completed       smallint    NOT NULL DEFAULT 0 CHECK (completed BETWEEN 0 AND 200),
    template_id     integer,
    condition_1     integer     NOT NULL DEFAULT 0,
    condition_2     integer     NOT NULL DEFAULT 0,
    condition_3     integer     NOT NULL DEFAULT 0,
    condition_4     integer     NOT NULL DEFAULT 0,
    accepted_at     timestamptz
);
```

`template_id` null = no active cycle quest. Rows with an old `week_start` reset `completed` lazily.

## 8. Backend implementation notes

- `quests::ring_task::handle_take` (8732): level >= 35, no active quest, `completed < 200`; roll a Type 1 or 2 template of the band; for type 18 roll a campaign (`condition_2`) and kill goal (`condition_4`); for type 19 roll a shop (`condition_2`) and an item of that shop (`condition_3`); persist; push 4614.
- `quests::ring_task::handle_update` (8731): re evaluate client checked conditions server side (pawn count, bag plus guild warehouse items, NPC talk for type 16; trust QTE and Mata-Rato); update counters; push 4614.
- `quests::ring_task::handle_finish` (8729) and `handle_finish_now` (8730): validate completion (or, for 8730, consume item 2131021 first, else 10 diamonds, bound first when `param1 == 0`); in one transaction: consume the delivered item for type 19 (assumption), grant band gold and spirit, increment `completed`, grant milestone items when `completed % 10 == 0`, roll the next quest (when `completed < 200`); push 3, bag, 4614 (finished with `is_complete` true plus the new quest), 4616 (`param1 = completed`); record activity TaskType 56, quest condition and achievement 111 counters.
- Weekly reset job (Monday 00:00, assumption): `completed = 0`, push 4616.

## 9. Open questions and assumptions

- Weekly reset day and whether an active quest survives the reset.
- Whether the type 19 item is consumed on delivery.
- 4615 and 4617 bodies (ignored by the client).

## 10. Implementation checklist

- [ ] Routes 8732, 8731, 8729, 8730
- [ ] Pushes 4614, 4616 (and optional 4615, 4617)
- [ ] Band rewards and milestone chests
- [ ] Rolled values for types 18 and 19
- [ ] Table `quests.cycle_progress`, weekly reset
- [ ] Test: 200 cap, milestone at 10/50/200, instant finish with passport item first
