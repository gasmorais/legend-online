# Quest trace bar and quest popups

Area: quests, module `task-trace`. Covers the on screen quest tracker `ui.tasktracebar.TaskTraceBar` with `view.TaskTraceView`, `TaskTraceItem`, `TraceTaskTargetItem`, `NewbieTaskTraceView` ("Caminho do Avanço"), the quest popups `yishi.actions.task.NewTaskAction`, `CompleteTaskAction`, `yishi.view.community.CompleteTaskTip`, `TaskGainMovie`, and the generic tip pop manager `managers.TaskTraceTipManager` with the m16 `tasktracetip` views.

Conventions: see [README.md](README.md).

## 1. Overview

The right side tracker lists every accepted quest (main, daily, event, VIP, return), the accepted bounty, the cycle quest and marriage quests, with their targets and progress. Clicking an incomplete entry runs the "Ir" navigation of its first condition; clicking a completed entry claims the reward directly. Before novice process 19000 a simplified tracker "Caminho do Avanço" shows only the first main quest with "Continuar missão" / "Concluir missão". Popups announce new quests and completed quests. The tip pop manager (`TaskTraceTipManager`) is a separate notification stack used by many features (better equipment, VIP, farm, mount, ...); it has no quest server traffic.

This module has no route or message of its own; it reuses the claim routes of the other quest modules.

## 2. Screens

| Class | pt-BR title | Purpose | Shown when | Data shown |
|---|---|---|---|---|
| `ui.tasktracebar.TaskTraceBar` (`decompiled/core_module/scripts/ui/tasktracebar/TaskTraceBar.as:54`) | | container plus the daily sign in shortcut (`dailyActivityBtnClickHandle` `:112`) | novice process >= 15000; hidden in PvP/PvE rooms, multi lords, unreal shooting, cross guild, auto chess scenes and some campaigns (`show` `:234`) | |
| `view.NewbieTaskTraceView` (`decompiled/core_module/scripts/ui/tasktracebar/view/NewbieTaskTraceView.as:50`) | "Caminho do Avanço", "Continuar missão", "Concluir missão" | first main quest; continue = navigation, finish = claim (`__onContinueClick` `:186`) | novice process < 19000 (`TaskTraceBar.as:74`) | `TaskCategory.mainTaskList[0]` |
| `view.TaskTraceView` (`decompiled/core_module/scripts/ui/tasktracebar/view/TaskTraceView.as`) | "Missão (Atalho: L)" title opens the quest frame (`:269`), hide button | list sorted completed first, then most recently changed, `TemplateType`, `Sort` (`:477`) | otherwise | accepted quests, marriage (`:439`), cycle (`:446`), bounty (`:465`) |
| `view.TaskTraceItem` (`decompiled/core_module/scripts/ui/tasktracebar/view/TaskTraceItem.as:76`) | type labels "Principal", "Diário", "Recompensa", "Ciclo"; ring count "({n} / 200ciclos)"; quick "Concluir"; hand in text | one entry with targets (`refreshCondition` `:169`) | | |
| `yishi.view.community.CompleteTaskTip` (`decompiled/core_module/scripts/yishi/view/community/CompleteTaskTip.as:45`) | `yishi.view.CompleteTaskTip.title0..6` with the quest title | completion popup; click claims (`__onClickHandler` `:110`) | queued by `MainToolBar` on completion events (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:995-:1012`) through `CompleteTaskAction` | |
| `yishi.actions.task.NewTaskAction` | new quest popup | new main quest (`TaskManage.newTaskHandler` `decompiled/core_module/scripts/yishi/manager/TaskManage.as:665`), new bounty (`OfferRewardManager.as:144`) | | |
| `managers.TaskTraceTipManager` (`decompiled/core_module/scripts/managers/TaskTraceTipManager.as:67`) and 54 `tasktracetip.view.*TipView` (m16) | for example "Equipar Agora", "Você tem equipamento melhor para substituir", "Alma do Dragão" | stacked tips with an action button (`showView` `:343`); dragon soul unlock tip after quest 754 | client events (goods added, level up, energy, VIP) | |

## 3. Routes (client to server)

Reused, see the owning modules:

| Entry action | Route |
|---|---|
| click a completed main or daily quest (`TaskTraceItem.checkTaskComplete` `:597`, `:611`) | 5014 ([quest-log.md](quest-log.md) Q2) |
| click a completed bounty, or any accepted bounty while the King contract is active | 8291 ([offer-reward.md](offer-reward.md) B5) |
| click a completed cycle quest (`:619`) | 8729 ([ring-task.md](ring-task.md) R2) |
| quick "Concluir" on the cycle quest (`ringTaskQuickHandler` `:373`) | 8730 ([ring-task.md](ring-task.md) R3) |
| click a completed marriage quest | `MarrySender.opMarryTask(2002)` ([marriage](../marriage/README.md)) |
| novice "Concluir missão" (`NewbieTaskTraceView.as:204`) | 5014 |
| completion tip click (`CompleteTaskTip.as:119`, `:127`) | 5014 or 8729 |

Clicks are blocked during mop up ("mopup.MopupManager.mopupTipData01", `TaskTraceItem.__clickHandler` `:577`). Incomplete entries call `SwitchPageHelp.skipPageByTaskCondictionType(data, openTaskFrame)` (`:594`).

## 4. Server messages (server to client)

None of its own. Refreshes on 112, 52 ([quest-log.md](quest-log.md)), 4198 ([offer-reward.md](offer-reward.md)), 4614 and 4616 ([ring-task.md](ring-task.md)).

## 5. Rules and formulas

- Tracker choice: `NewbieTaskTraceView` while novice process < 19000, switched to `TaskTraceView` on scene switch afterwards (`TaskTraceBar.as:187-:193`).
- Sort: `sortOn(["sortFlag","changeDate","TemplateType","Sort"], [DESCENDING, DESCENDING | NUMERIC, NUMERIC, NUMERIC])` with `sortFlag = isCompleted` (`TaskTraceView.as:474-:477`).
- Novice auto navigation: new main quests 1825 to 1831 auto run their "Ir" when no newbie mask is active (`TaskManage.doNewbieTask` `:674`).

## 6. Templates

None beyond the quest templates.

## 7. Persistent state

None.

## 8. Backend implementation notes

No handler. The server only has to keep `changeDate` meaningful by pushing progress when it changes (the client stamps `changeDate` on every update).

## 9. Open questions and assumptions

- None for the server.

## 10. Implementation checklist

- [ ] Verify claims from the tracker for each quest kind
- [ ] Verify novice tracker with quest 1834 and the tutorial ([../tutorial/guided-steps.md](../tutorial/guided-steps.md))
