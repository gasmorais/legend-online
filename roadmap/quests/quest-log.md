# Quest log ("Missão": main, daily, event, VIP and return quests)

Area: quests, module `quest-log`. Covers the quest lifecycle of `QuestTemps` quests: `yishi.manager.TaskManage`, `mvc.module.task.TaskCategory`, `TaskTemplate`, `TaskInfo`, `managers.TaskSocketManager`, `task.net.TaskSocketSendManager`, the controller `mvc.controler.TaskControler` and the frame `task.TaskFrameII` with its views (m15), the proto package `quest`, and the phone binding quest.

Conventions: see [README.md](README.md).

## 1. Overview

The "Missão" frame lists accepted quests by menu: "Principal" (main story, `TemplateType` 0), daily ("Diário", 1), event (2) and return player (4) under one button, VIP (3), plus the bounty board quests ("Recompensa", pseudo type 100, [offer-reward.md](offer-reward.md)), the cycle quest ("Ciclo", -2, [ring-task.md](ring-task.md)) and marriage quests (-3, owned by [marriage](../marriage/README.md)).

The client decides which quests are available (level band, prerequisites, dates, repeat rules) and asks the server to add them; the server stores per quest progress and the finished bitset; the player claims the reward when every condition is met. Main quests chain through `PreQuestId` from level 1 to 80+, dailies repeat once per calendar day, 12 quests are "manual" (`IsAuto = false`) and are accepted at the end of an NPC story dialog.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `task.TaskFrameII` (`decompiled/m15/scripts/task/TaskFrameII.as`) | "Missão" (`task.TaskFrameII.title`, `:171`) | menu, quest list, description, targets, rewards, buttons: claim ("rewardBtn"), go/start (QTE, Mata-Rato, arrest, enter collection scene `NeedFightId`), "Concluir agora" (`_completeNowBtn`, only with `VersionSwitch.KING_CONTRACT`), give up (bounty and marriage), client download, debug "立即完成" (only `StageReferance.isDebug`, `:209-:215`) | key `task` (`decompiled/core_module/scripts/mvc/controler/TaskControler.as:45`): main toolbar quest button (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2164`), keyboard shortcut (`decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:444`, novice process > 11000), trace bar title "Missão (Atalho: L)" (`decompiled/core_module/scripts/ui/tasktracebar/view/TaskTraceView.as:269`), trace item click, day guide id 20, bounty board | `TaskManage.cate`, bounty, ring, marriage models |
| `task.view.TaskMenuII` (`decompiled/m15/scripts/task/view/TaskMenuII.as:62`) | menu buttons | menu entries from accepted quest types (`refreshTaskType` `:103`); "Ciclo" when level >= 35 (`:158`); marriage when marriage quests exist; VIP button opens the VIP frame when VIP expired (`checkShowVip` `:171`) | frame | |
| `task.view.TaskListView` (`decompiled/m15/scripts/task/view/TaskListView.as`) | | list per menu type (`:233-:281`): 0 main, 1 daily, 2 and 4 event plus return, 3 VIP, 100 bounty, -2 ring (accepted or the resident template), -3 marriage, default manual list; sorted incomplete first then `Sort` (`:147`); phone quest forced to the top | frame | |
| `task.view.TaskDescribeViewII` | `Detail` (ring quests fill `{0}`/`{1}`) | description | frame | |
| `task.view.TaskTargetViewII` | condition titles plus progress | targets | frame | `getProgress()` |
| `task.view.TaskRewardViewII` (`decompiled/m15/scripts/task/view/TaskRewardViewII.as`) | "Experiência", "Ouro", "Espírito", "Cristal de Luz", "Fortuna da Guilda", "Contribuição da Guilda", "Grau de Perfeição" | reward values in that order (`_rewardList` `:53`) and items fitting the hero job | frame | [quest-templates.md](quest-templates.md) |
| `task.view.TaskMobilePhoneView` (`decompiled/m15/scripts/task/view/TaskMobilePhoneView.as`) | "Insira número de celular", "Insira número de autenticação", "Número de autenticação tem validade de 60 minutos" | phone binding quest (condition type 48) | frame, when the selected quest has type 48 | |
| `yishi.view.community.CompleteTaskTip` (`decompiled/core_module/scripts/yishi/view/community/CompleteTaskTip.as:45`) | completion tip with a claim click | claim from the tip (`:110`) | `CompleteTaskAction` | |
| `yishi.actions.task.NewTaskAction` (`decompiled/core_module/scripts/yishi/actions/task/NewTaskAction.as`) | new quest popup | shown for new main quests after novice process 19000 | `TaskManage.newTaskHandler` | |

`TaskControler.start` refuses to open with "Não há missão" when there is no accepted quest and no bounty quest (`decompiled/core_module/scripts/mvc/controler/TaskControler.as:22`).

## 3. Routes (client to server)

### Q1. Add available quests

- Trigger: automatic. After the first 112 of the session (`TaskManage.__questUpdateHandler` `decompiled/core_module/scripts/yishi/manager/TaskManage.as:182-:186`) and after every 52 (`:256`), `requestCanAcceptTask` (`:352`) collects every `IsAuto` template that passes `isAvailableTask` (`:384`, section 5) and sends them in one message. Manual quests: `requestAcceptTask(template)` (`:369`) at the last step of an NPC story dialog (`decompiled/m3/scripts/map/space/view/frame/SpaceDialogFrame.as:568`, `decompiled/m3/scripts/map/campaign/view/frame/NewbieVillageDialogFrame.as:488`).
- Sender: `TaskSocketManager.sendRequestTask(ids)` `decompiled/core_module/scripts/managers/TaskSocketManager.as:33`.
- Route: C>S 5012 (0x1394) `U_C_QUEST_ADD`, `quest.QuestAddedMsg`: `questId (#1, INT32, repeated)` template ids.
- Expected response: S>C 112 with one `QuestInfo` per added quest (`is_accept = true`, counters 0, `add_date` now). Ids that fail server validation are simply omitted.

### Q2. Claim the reward (turn in)

- UI: claim button of the frame (`TaskFrameII.__getRewardHandler` `decompiled/m15/scripts/task/TaskFrameII.as:701`, only when `isCompleted`), trace bar click on a completed quest (`decompiled/core_module/scripts/ui/tasktracebar/view/TaskTraceItem.as:611`), novice trace "Concluir missão" (`decompiled/core_module/scripts/ui/tasktracebar/view/NewbieTaskTraceView.as:204`), completion tip (`CompleteTaskTip.as:119`), village dialog (`NewbieVillageDialogFrame.as:501`).
- Pass variant: `is_pass = true` from the tutorial node 200 for quest 1834 (`decompiled/m8/scripts/nodes/NoviceTutorial_200.as:85`) and from the debug button (`TaskFrameII.onCompleteBtnClick` `:257`).
- Sender: `TaskControler.sendGetTaskReward` (`TaskControler.as:50`) -> `TaskSocketManager.sendGetTaskReward(templateId, rewardItemId, isPass)` (`TaskSocketManager.as:23`).
- Route: C>S 5014 (0x1396) `U_C_QUEST_FINISH`, `quest.QuestFinishedReqMsg`: `template_id (#1, INT32)`; `reward_item_id (#2, INT32)` chosen item for selectable rewards (always 0 in this build; no `QuestGoods` row has `IsSelect = true`); `is_pass (#3, BOOL)` skip the completion check.
- Expected response: reward pushes (S>C 3 player resources and EXP, bag updates, guild pushes), then S>C 52; then the client sends Q1 for newly available quests.

### Q3. Phone binding quest (condition type 48)

- Only when the client config `MOBILE_TASK` is on (`TaskCategory.addAccepted` `decompiled/core_module/scripts/mvc/module/task/TaskCategory.as:86`).
- Check phone state: C>S 8524 (0x214c) `C_CHECK_SEND`, `player.CheckSend` (empty) (`TaskSocketManager.sendCheckMobileNumber` `TaskSocketManager.as:47`); reply S>C 4420 (0x1144) `U_C_CHECK_SEND` `player.CheckSend`: `can_send (#1, INT32)` 1 code already sent, -1 not sent (`TaskMobilePhoneView.__setFirstView` `:259`).
- Send the phone number: HTTP POST `REQUEST_PATH + "getphone?userId=&phone=&key="` (`TaskMobilePhoneView.sendPhone` `:405`); integer reply: 1 ok, -6 user error ("Erro na identidade do usuário"), -5 invalid number, -4 busy, -3 daily limit of 3 ("Hoje já atingiu limite de 3 tentativas"), -2 account already bound, -1 number already bound (`:413-:443`).
- Verify the code: C>S 8352 (0x20a0) `C_USER_PIN_CHECK`, `player.UserPin` (m15 proto): `pin (#1, INT32)` (`TaskSocketSendManager.sendPhoneTaskCode` `decompiled/m15/scripts/task/net/TaskSocketSendManager.as:16`). Expected: quest condition 48 counter 1 and 112.

## 4. Server messages (server to client)

### S1. 112 (0x0070) `U_C_QUEST_UPDAT`

- `quest.QuestUpdatedRspMsg`: `quest (#1, QuestInfo, repeated)`; `states_length (#2, INT32)`; `states (#3, BYTES)` finished bitset.
- `quest.QuestInfo`: `template_id (#1, INT32)`; `is_complete (#2, BOOL)`; `condition_1..4 (#3..#6, INT32)` counters per condition; `completed_date (#7, STRING)` "YYYY-MM-DD hh:mm:ss"; `repeat_finish (#8, INT32)` completions of a repeatable quest; `is_accept (#9, BOOL)`; `is_select (#10, BOOL)`; `add_date (#11, STRING)` accept time.
- Receiver: `TaskManage.__questUpdateHandler` `decompiled/core_module/scripts/yishi/manager/TaskManage.as:127`: for each quest known in `QuestTemps`, creates or updates its `TaskInfo` (`readTaskInfo` `:327`), adds it to the accepted lists if still available, attaches condition listeners; then copies `states_length - 1` bytes of `states` into the finished bitset (`:180-:181`); the first push of the session triggers Q1; new main quests raise the "new quest" popup (novice process >= 19000) or the auto navigation for quests 1825 to 1831 (`doNewbieTask` `:674`).
- Critical field: `TaskInfo.isAchieved` is false only when `completed_date` parses to a year < 2050 (`decompiled/core_module/scripts/mvc/module/task/TaskInfo.as:164`), and a quest with `isAchieved` true never shows as completed (`TaskTemplate.isCompleted` `decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:401`). Send a past date (for example `add_date` or "2000-01-01 00:00:00") for active quests; a missing or 2050+ date blocks the claim button.
- Login: `PlayerMsg.quest_site (#11, BYTES)` with `quest_site_len (#10)` seeds the bitset (`TaskManage.loadTaskLog` `:108`); the first 112 arrives from the 8224 load with `quest = true` (`LoginInitDataAccept.loginOverRequest` `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:86`).
- When: login, reply to Q1, every counter change, after a claim when follow up quests become accepted.

### S2. 52 (0x0034) `U_C_QUEST_FINISH`

- `quest.QuestFinishedRspMsg`: `template_id (#1, INT32)`; `isJump (#2, INT32)` 1 = several quests closed at once; `finishedTemps (#3, FinishedTempId, repeated)` (`template_id (#1, INT32)`) used when `isJump == 1`.
- Receiver: `TaskManage.__questFinishHandler` `:202`: plays the gain animation (single case), resets the conditions, removes the quest from the lists (manual quests may reappear), runs the hooks (section 5), sends Q1, notifies `TASK_COMMIT` with the template id (tutorial and other features listen to it).
- When: reply to Q2; the server must also set bit `template_id - 1` of the bitset and send it in the next 112.

### S3. 4420 (0x1144) `U_C_CHECK_SEND` (phone quest), see Q3.

Unused: S>C 5 `U_C_QUEST_ADD` and `quest.QuestRemovedMsg` have no listener in this build.

## 5. Rules and formulas

Availability (`TaskManage.isAvailableTask` `:384`), a template is offered when all hold:

- now < `EndDate` (`checkIsAchieved` `:442`) and now >= `StartDate` (`:453`); 282 templates have `EndDate` "2000-01-01" and are disabled, 32 have `StartDate` "2050-01-01".
- `NeedMinLevel <= level <= NeedMaxLevel` (`:464`, `:473`).
- not already accepted; not finished (bitset) unless `IsRepeat` (`:418`).
- repeat cap: refused when `repeat_finish >= RepeatMax` and it was completed today (`checkRepeatMax` `:482`, `checkInRepeatTime` `:491`, compares "YY-MM-DD").
- every id in `PreQuestId` (comma separated) finished (`checkPreTask` `:508`).
- `NeedBuildingTemp` check (`:527`, all data 0); `IsLeague` requires a guild (`:560`); `WeekSpace`/`HourSpace` checks are stubs returning false (`:569`, `:574`); `NeedItemTemp` is never checked (`checkNeedGoods` `:546`, unused).
- Manual quests (`IsAuto = false`) are listed in the manual list when available, not selected (`is_select` false), and either `repeat_finish < RepeatMax`, never completed, completed on another day, or in another `RepeatInterval` hour window (`isManualAvaliable` `:612`).

Finished bitset: quest `id` finished when bit `(id - 1) % 8` of byte `(id - 1) / 8` is set (`IsTaskFinish` `:579`). Max template id is 1972, so 247 bytes.

Daily quests (`TemplateType` 1, 35 rows, `IsRepeat` true, `RepeatMax` 1, `RepeatInterval` 24): reaccepted every calendar day; displayed EXP = `RewardPlayGP + (level - NeedMinLevel) * 500` (`TaskRewardViewII.refreshReward` `decompiled/m15/scripts/task/view/TaskRewardViewII.as:225`); the server must grant the same value.

Completion hooks after 52 (`TaskManage.as:260-:308`): 757 sends the dragon soul transfer request (`PlayerManager.sendDragonSoulTransfer`), 920 shows the pet button, 754 opens the dragon soul tip, 755/756/1800/1801 play the job transfer animation (`TASK_SHOWTRANSFER` 2, 1, 3, 4), 1802 opens cosmos slot 8. Gate constants: 52 army formation, 921 pets, 936 titles, 1911 royal throne, 1943 avenger talent, 1936 monster explore, 1100 royalty boss, 1389 war soul, 1390 war soul tower, 1391 final road (`:39-:67`).

Rewards: [quest-templates.md](quest-templates.md) section 5. Conditions: [quest-conditions.md](quest-conditions.md).

## 6. Templates

`QuestTemps`, `QuestCondictionInfos`, `QuestGoods`: see [quest-templates.md](quest-templates.md) and [quest-conditions.md](quest-conditions.md).

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS quests;

CREATE TABLE quests.quest_progress (
    player_id      integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    quest_id       integer     NOT NULL,
    condition_1    integer     NOT NULL DEFAULT 0,
    condition_2    integer     NOT NULL DEFAULT 0,
    condition_3    integer     NOT NULL DEFAULT 0,
    condition_4    integer     NOT NULL DEFAULT 0,
    is_complete    boolean     NOT NULL DEFAULT false,
    is_select      boolean     NOT NULL DEFAULT false,
    accepted_at    timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, quest_id)
);

CREATE TABLE quests.quest_history (
    player_id      integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    quest_id       integer     NOT NULL,
    repeat_finish  integer     NOT NULL DEFAULT 0 CHECK (repeat_finish >= 0),
    completed_at   timestamptz NOT NULL,
    PRIMARY KEY (player_id, quest_id)
);

CREATE TABLE quests.finished_bits (
    player_id   integer PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    bits        bytea   NOT NULL DEFAULT '\x'::bytea
);

CREATE TABLE quests.phone_binding (
    player_id     integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    phone         text        NOT NULL UNIQUE,
    pin           integer,
    pin_sent_at   timestamptz,
    attempts_day  date,
    attempts      smallint    NOT NULL DEFAULT 0,
    verified_at   timestamptz
);
```

`quest_progress` holds accepted quests only; it is deleted on turn in. `quest_history` keeps the last completion per quest for `repeat_finish` and `completed_date`. `finished_bits` is the `quest_site` bitset.

## 8. Backend implementation notes

- `quests::quest_log::push_all(player)`: 112 with every accepted quest (and, for repeatables, the history row), `states` = bitset, `states_length = len + 1` (the client reads `states_length - 1` bytes). Sent in the 8224 load (`quest = true`).
- `quests::quest_log::handle_add` (5012): for each id, re run the availability rules server side (same order as section 5, plus manual quests only from the NPC dialog flow); insert `quest_progress`; for client state conditions nothing else; reply 112 with the added quests.
- `quests::quest_log::handle_finish` (5014): load the accepted quest; unless `is_pass` is allowed (only quest 1834 during the tutorial, or a debug account), evaluate every condition (server counters from the row, client state via `quests::conditions::evaluate`); in one transaction delete the progress row, upsert history (`repeat_finish + 1`, `completed_at`), set the bit, grant rewards ([quest-templates.md](quest-templates.md) section 8); push resources and bag, then 52 `{template_id, isJump: 0}`, then 112 with the new bitset. Hook 757 is client driven; others are server effects owned by the unlocked features (pets, dragon soul, cosmos slot 8).
- Daily reset: none stored; availability uses `completed_at` date versus today.
- Phone binding (8524, HTTP `getphone`, 8352): send SMS via an external provider (out of scope; keep disabled unless `MOBILE_TASK` is enabled in the client config).
- Pushes to other players: none.

## 9. Open questions and assumptions

- The `isJump` multi completion case (which action closes several quests at once) is not visible in this client.
- Whether the original server re validated client state conditions is unknown (recommended: yes).
- `is_select` meaning for normal quests (manual quests use it as "already taken").

## 10. Implementation checklist

- [ ] `PlayerMsg.quest_site` and 112 at login, bitset length rule
- [ ] Route 5012 with server side availability
- [ ] Route 5014 with condition evaluation, rewards, history, bitset, 52, 112
- [ ] `completed_date` year < 2050 for active quests
- [ ] Daily repeat window
- [ ] Manual quests through NPC dialogs
- [ ] Tutorial pass for quest 1834
- [ ] Phone binding (optional, config gated)
- [ ] Tables `quest_progress`, `quest_history`, `finished_bits`, `phone_binding`
- [ ] Test: prerequisite chain 10 -> 20, daily reaccept next day, disabled templates by date, multi condition quest
