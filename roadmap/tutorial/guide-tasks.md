# Guide tasks ("Objetivo dos 7 dias")

Area: tutorial, module `guide-tasks`. Covers the seven day objective frame (`m11/scripts/guidetask`), its manager and model (`managers.GuideTaskManager`, `mvc.module.guidetask`: `GuideTaskInfo`, `SingleDayInfo`, `SimpleTaskInfo`, `GuideTaskUpgradeInfo`), the "what can I do now" level view, and the templates `SimpleTask` and `ServenLeadRewards`.

Conventions: see [README.md](README.md). The proto package used (`leed`) belongs to [daily-activity](../daily-activity/README.md).

## 1. Overview

Intended design: during the first 7 days after a start date, each day has up to 7 small objectives (reach army level, use the star system, pass the tower, and so on). Completing all objectives of a day enables a reward of up to 4 items; day N + 1 can be previewed only after all objectives of day N are done. A second view lists "things you can still do today" (remaining multiplayer runs, tower runs, maze runs, bounty quests, energy).

State of this client build: the feature is dormant.

- `GuideTaskManager.initEvent` is empty, so the handler `_initGuideTask` that reads `leed.ServenDayLeadMsg` is never registered on any opcode (`decompiled/core_module/scripts/managers/GuideTaskManager.as:57`, `:61`).
- `GuideTaskManager.getReward` is empty (`:85`), so the claim button and the midnight call `getReward(-1001)` (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerModel.as:402`) send nothing.
- `model.statu` stays 0, so the mini map button is hidden (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:241`) and the frame cannot be opened by the player.
- `raw/xml/tempinfos/ServenLeadRewards.xml` is empty and there is no `SimpleTask.xml` in `raw/xml/tempinfos/`.

No server work is required to match the original client behavior. This file documents the full data model so the team can decide whether to revive it (which needs a client patch to register a listener and to send a claim request).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `guidetask.GuideTaskFrame` (`decompiled/m11/scripts/guidetask/GuideTaskFrame.as:68`), 665 x 528 | "Objetivo dos 7 dias" (`guidetask.GuideTaskFrame.titleTxt`); tabs "Primeiro dia" to "Sétimo dia" (`dayBtnTxt01..07`); help "Instruções de Ajuda" | 7 day tabs, 7 objective rows, reward box, help | `FrameControllerManager` key `guidetask` (`decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1575`) via mini map button (`SmallMapBar.__guideTaskBtnHandler` `decompiled/core_module/scripts/mainBar/SmallMapBar.as:523`, openType 1) | `GuideTaskManager.model` |
| `guidetask.GuideTaskButton` (`decompiled/m11/scripts/guidetask/GuideTaskButton.as:26`) | day name | Day tab with a "reward available" state | frame | `getRewardFlagByDay(day)` |
| `guidetask.GuideTaskItem` (`decompiled/m11/scripts/guidetask/GuideTaskItem.as:85`) | "Nível {0} abrirá", "Completado", "Ainda não completou" | One objective: icon frame = template `Type`, text = template `Detail` with `{0}`..`{3}` replaced by `IParam1..4`; clicking "Ainda não completou" navigates (`:235`) | frame | `SimpleTaskInfo`, `SimpleTaskTempInfo` |
| `guidetask.GuideTaskRewardView` (`decompiled/m11/scripts/guidetask/GuideTaskRewardView.as:58`) | reward button, claimed stamp | 4 reward items of the selected day, claim button | frame | `ServenLeadRewards` rows of the day |
| `guidetask.GuideLevelView` + `GuideLevelItem` (`decompiled/m11/scripts/guidetask/GuideLevelView.as:60`, `GuideLevelItem.as:81`) | "[Recomendar]" on the first 2 rows; rows "Mapa de Multiplayer restante {0} vez", "Torre de Julgamento {0}vez", "Labirinto {0} vez", "Missão de Recompensa restante {0} vezes", "Energia atual restante {0}" | Things left to do today, with a go button | objective of type 4 (hero level) or level locked objective (`changePage(2)`) | local player counters |
| `SimpleHelpFrame` style `guidetask.HelpFrame` | text `guidetask.GuideTaskFrame.helpFrame.helpHtmlTxt` ("1.Completando todas as missões do dia poderá ganhar prêmios ...") | Help | help button (`GuideTaskFrame.as:145`) | none |

## 3. Routes (client to server)

None in this build.

| # | UI control | Client sender | Client checks | Route | Notes |
|---|---|---|---|---|---|
| T1 | Reward button | `GuideTaskRewardView._rewardButtonHandler` `decompiled/m11/scripts/guidetask/GuideTaskRewardView.as:89` -> `GuideTaskManager.getReward(day)` `decompiled/core_module/scripts/managers/GuideTaskManager.as:85` | button enabled when every objective of the day has `isComplete >= 1` and the day is not claimed | none (empty method) | `leed.GetRewardMsg`: `day (#1, INT32)` exists in `protocol/proto.json` and was probably the request body; its opcode is unknown |
| T2 | Midnight tick while `statu == 1` | `PlayerModel` `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerModel.as:402` -> `getReward(-1001)` | hour == 0 | none | Probably a "refresh" request in the original (Assumption) |
| T3 | Objective "Ainda não completou" | `GuideTaskItem.__hitTxtSpriteHandler` `GuideTaskItem.as:235` -> `SwitchPageHelp.switchGuidePage(Type)` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2039`) | hero level >= `IParam5` and type != 4, else switch to the level view | client navigation only | Targets: 1 barracks, 2 guild skills, 3 seminary, 5 star, 6 store compose, 7 store intensify, 8 maze, 9 star, 10 store mount, 11 runes, 12 mounts, 13 campaign 9004, 14 guild, 15 star, 16 bag |
| T4 | Level view go button | `GuideLevelItem.__gotoBtnHandler` `decompiled/m11/scripts/guidetask/GuideLevelItem.as:81` | none | client navigation only | type 1 and 2 campaign 9004, 3 maze, 4 bounty quests, 5 campaign list |

## 4. Server messages (server to client)

| Route | Message and fields | When | Client handler |
|---|---|---|---|
| none wired | `leed.ServenDayLeadMsg`: `beginTime (#1, STRING "YYYY-MM-DD hh:mm:ss")` start of day 1; `statu (#2, INT32)` 0 hidden or finished, 1 active; `singleDay (#3, SingleDayMsg, repeated)`. `SingleDayMsg`: `day (#1, INT32)` 1..7, `getReward (#2, INT32)` 1 = claimed, `simpleTask (#3, SimpleTaskMsg, repeated)`. `SimpleTaskMsg`: `taskId (#1, INT32)` `SimpleTask` template id, `isComplete (#2, INT32)` > 0 done | Would be login and on every objective change | `GuideTaskManager._initGuideTask` `GuideTaskManager.as:61` (not registered): stores the model, refreshes the open frame, notifies `SHOWBTN` (mini map button visible when `statu == 1`) and `SHOWEFF` (reward badge) |

## 5. Rules and formulas

From `GuideTaskManager`:

- Current day = calendar days since `beginTime` (`DateFormatter.compareDay`), clamped to 1..7 (`getCurrDay` `GuideTaskManager.as:172`).
- Tab access (`getCanSee` `:186`): if every objective of the current day is complete, days up to current + 1 are selectable; otherwise up to the current day. Clicking the next locked day shows "Favor concluir primeiro o Objetivo do dia" (`decompiled/m11/scripts/guidetask/GuideTaskFrame.as:231`).
- Objectives of a future day show no status (`isShow` false when `day > compareDay(beginTime)`, `GuideTaskFrame.as:189`).
- A day's reward is claimable when not yet claimed and every objective has `isComplete >= 1` (`getRewardFlagByDay` `:131`); the mini map badge shows when any day is claimable (`isShowEff` `:89`).
- Rewards of day N = `ServenLeadRewards` rows with `Day == N`, first 4 rows shown (`getRewardByDay` `:287`, `GuideTaskRewardView.as:58`).
- Objective locked text when hero level < `IParam5` (`GuideTaskItem.as:128`).
- Level view (`getSomethingCanToDo` `:241`), each row shown when the counter is positive and the hero level reaches the gate: multiplayer runs left (`multiCopyCount`, level >= 20), trial tower runs (`trialTowerCampaignCount`, level >= 40), maze entries left (`maxEnterCount - enterCount`, level >= 23), bounty quests left (`remainRewardCount`, level >= 17), energy (`weary` > 20, no level gate). First 2 rows are marked recommended.
- Help text rules: all objectives of the day give the prize; prizes can still be claimed after the day passes; items are bound; the button closes for good after all objectives are done.
- Objective types (`decompiled/core_module/scripts/yishi/datas/consant/GuideTaskType.as:6`): 1 army level, 2 guild skill, 3 personal skill, 4 hero level, 5 use star, 6 use equipment, 7 strengthen equipment, 8 pass tower, 9 star level, 10 inlay stone, 11 learn rune, 12 get mount, 13 pass campaign, 14 guild devote, 15 star value, 16 soul import, 17 rune level, 18 talent level, 19 get pet, 20 mount level, 21 honour soldier, 22 fighting capacity, 23 enter campaign, 24 complete bounty task, 25 battlefield kills, 26 link game points, 27 clear trials.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `SimpleTask` (category name in `TempleteManager`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1187`; not present in `raw/xml/tempinfos/`) | `SimpleTaskTempInfo` | `TaskId`, `Type` (objective type above), `Detail` (text with `{0}`..`{3}`), `IParam1..IParam4` (values for the text and the goal), `IParam5` (hero level to unlock) |
| `raw/xml/tempinfos/ServenLeadRewards.xml` (empty) | `ServenLeadRewardInfo` (`decompiled/core_module/scripts/yishi/datas/templates/ServenLeadRewardInfo.as`) | `Day` (1..7), `RewardType`, `TemplateId` item, `Count` |
| `raw/xml/tempinfos/GuideValueTemps.xml` | `GuideValueTemp` `Id`, `Type`, `MinLv`, `MaxLv`, `Parameter1..5` (300 rows) | Not referenced by any client class; possibly server side guide tuning (Open question) |

## 7. Persistent state

Only needed if the feature is revived.

```sql
CREATE TABLE tutorial.seven_day_task_template (
    task_id      integer  PRIMARY KEY,
    day          smallint NOT NULL CHECK (day BETWEEN 1 AND 7),
    sort_order   smallint NOT NULL DEFAULT 0,
    goal_type    smallint NOT NULL CHECK (goal_type BETWEEN 1 AND 27),
    detail       text     NOT NULL,
    param1       integer  NOT NULL DEFAULT 0,
    param2       integer  NOT NULL DEFAULT 0,
    param3       integer  NOT NULL DEFAULT 0,
    param4       integer  NOT NULL DEFAULT 0,
    unlock_level smallint NOT NULL DEFAULT 0
);

CREATE TABLE tutorial.seven_day_reward_template (
    day          smallint NOT NULL CHECK (day BETWEEN 1 AND 7),
    slot         smallint NOT NULL CHECK (slot BETWEEN 1 AND 4),
    reward_type  smallint NOT NULL,
    item_template_id integer NOT NULL,
    item_count   integer  NOT NULL CHECK (item_count > 0),
    PRIMARY KEY (day, slot)
);

CREATE TABLE tutorial.seven_day_state (
    player_id    integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    begin_at     timestamptz NOT NULL,
    status       smallint    NOT NULL DEFAULT 1 CHECK (status IN (0, 1))
);

CREATE TABLE tutorial.seven_day_task_progress (
    player_id    integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    task_id      integer     NOT NULL REFERENCES tutorial.seven_day_task_template(task_id),
    completed_at timestamptz,
    PRIMARY KEY (player_id, task_id)
);

CREATE TABLE tutorial.seven_day_claim (
    player_id    integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    day          smallint    NOT NULL CHECK (day BETWEEN 1 AND 7),
    claimed_at   timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, day)
);
```

## 8. Backend implementation notes

- Nothing to implement for parity with this client.
- If revived (requires a client patch): `tutorial::guide_tasks::push_state` builds `ServenDayLeadMsg` from the tables; `tutorial::guide_tasks::handle_claim_day` (new opcode, body `GetRewardMsg.day`) validates day <= current day, all objectives complete, not claimed; grants items in one transaction with the claim row; pushes the new state. Objective completion listens to the events of the owning features (army level, star, tower, store, mounts, campaign, guild) and sets `completed_at`. Set `status` 0 once every day is claimed (help rule 4).

## 9. Open questions and assumptions

- Opcodes for the state push and the claim request are unknown; the leed opcodes in `protocol/opcodes.csv` (8234, 8235, 8236, 8322, 4150, 4152, 521) belong to the daily guide and remains exploration.
- Start date rule (account creation or feature launch) is unknown.
- `GuideValueTemps.xml` purpose is unknown.
- `SimpleTask` and `ServenLeadRewards` data are missing from the dataset.

## 10. Implementation checklist

- [ ] Decision: keep dormant (default) or revive with a client patch
- [ ] Screens verified unreachable with `statu == 0` (mini map button hidden)
- [ ] (revive) Tables `tutorial.seven_day_*`
- [ ] (revive) State push with `ServenDayLeadMsg`
- [ ] (revive) Claim route T1 with `GetRewardMsg`
- [ ] (revive) Objective tracking per goal type
- [ ] (revive) Test: day unlock rule and claim rules
