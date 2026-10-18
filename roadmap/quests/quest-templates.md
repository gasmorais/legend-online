# Quest templates and rewards (`QuestTemps`, `QuestGoods`)

Area: quests, module `quest-templates`. Covers the static quest data loaded by `TempleteManager` (`QuestTemps`, `QuestGoods`; conditions in [quest-conditions.md](quest-conditions.md)), the record classes `mvc.module.task.TaskTemplate` and `TaskGoodsTemplate`, every reward type and how the server grants it, plus an overview of the other quest like template sets and their owners.

Conventions: see [README.md](README.md).

## 1. Overview

835 quest templates in 5 types, each with 1 to 4 conditions and up to 7 resource rewards plus items filtered by hero job. The client links templates to conditions and items at load time (`TaskTemplate.initTask` `decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:135`, scanning `taskGoodTemplateList` and `taskCondictionInfoList`). Loading: `TaskCondictionTemplateResolve`, `TaskGoodsTemplateResolve`, `TaskTemplateResolve` (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1434-:1436`).

## 2. Screens

Rewards render in `task.view.TaskRewardViewII` (`decompiled/m15/scripts/task/view/TaskRewardViewII.as`): resource rows in the order of `_rewardList` (`:53`) with icon tips "Experiência", "Ouro", "Espírito", "Cristal de Luz", "Fortuna da Guilda", "Contribuição da Guilda", "Grau de Perfeição" (`task.view.TaskRewardItem.iconTips01..07`), then item cells (`TaskGoodItemView`) for `QuestGoods` rows of the quest that fit the hero job (`getTaskGoodList` `:325`).

## 3. Routes (client to server)

None. Templates are client data; the server needs the same files.

## 4. Server messages (server to client)

None specific; rewards are granted on 5014 ([quest-log.md](quest-log.md) Q2).

## 5. Rules and formulas

### Quest types (`TemplateType`, `decompiled/core_module/scripts/yishi/datas/consant/TaskType.as`)

| Type | Constant | Rows | Notes |
|---:|---|---:|---|
| 0 | `TASK_MAIN` | 781 | main story; 766 auto, 12 manual ("Caminho do Desafio (1..6)" 1811 to 1816, "Coletar Recursos (1..6)" 1817 to 1822); test quests 1900, 1901 ("测试任务1/2", `RepeatMax` 100) |
| 1 | `TASK_COMMON` | 35 | dailies, all `IsRepeat`, `RepeatMax` 1, `RepeatInterval` 24; active ones include "Cristal das Trevas I..XI (Guilda)" 846 to 856 in level bands 25 to 100 (`IsLeague`) |
| 2 | `TASK_ACT` | 14 | dated events (most expired) |
| 3 | `VIP_TASK` | 3 | VIP menu (all expired by `EndDate`) |
| 4 | `BACK_PLAYER` | 2 | return player ("Regresso do Herói" 1798, 1799) |
| -2 | `RING_TASK` | | cycle quest pseudo type ([ring-task.md](ring-task.md)) |
| -3 | `MARRY_TASK` | | marriage quests ([marriage](../marriage/README.md)) |
| 100 | (menu only) | | bounty board ([offer-reward.md](offer-reward.md)) |

### Reward types

| Field | pt-BR label | Rows > 0 | Grant (server) |
|---|---|---:|---|
| `RewardPlayGP` | "Experiência" | 451 | hero EXP; daily quests (type 1): `RewardPlayGP + (level - NeedMinLevel) * 500` (`TaskRewardViewII.as:225`) |
| `RewardGold` | "Ouro" | 703 | gold |
| `RewardStrategy` | "Espírito" | 70 | spirit (strategy) |
| `RewardCrystal` | "Cristal de Luz" | 18 | light crystal |
| `RewardConsortiaOffer` | "Fortuna da Guilda" | 15 | guild fortune (guild funds) when the player has a guild |
| `RewardPlayerOffer` | "Contribuição da Guilda" | 16 | personal guild contribution |
| `RewardHappy` | "Grau de Perfeição" | (marriage templates) | couple perfection points ([marriage](../marriage/README.md)) |
| `RewardMoney` | (not displayed) | 1 (quest 1 "Evento Diário", 50, expired) | assumption: diamonds; ignore |
| `RewardHeroGP`, `RewardDower` | (not displayed) | 0 | unused |
| `QuestGoods` rows | item cells | 191 rows | item `RewardItemID` x `RewardItemCount`, only rows with `ToJob` 0 or equal to the hero job (`TaskGoodsTemplate.fitJob` `decompiled/core_module/scripts/mvc/module/task/TaskGoodsTemplate.as:23`); `IsSelect` is false on every row so every fitting item is granted; `ValidDate` 0 = permanent |

Job specific rows: quests 1823, 1826, 1840 give one item per job (`ToJob` 1, 2, 3).

### Other template facts

- `IsAuto`: 823 true (requested automatically), 12 false (manual).
- `IsRepeat` 40 true; `RepeatInterval` always 24; `RepeatMax` 1 except the two test quests.
- `IsLeague` 19 true (15 dailies, 4 main): require a guild.
- `NeedFightId` 6001 on 13 quests: the "go" button enters the collection scene (`worldBossTemplateDict[6001]`, `TaskFrameII.__enterCampainHandler` `decompiled/m15/scripts/task/TaskFrameII.as:827`).
- `NeedItemTemp` only on the test quests; never checked.
- Constant or unused: `Objective`, `NeedBuildingTemp`, `NeedPos`, `IsLost`, `WeekSpace`, `HourSpace`, `ShowType` (all 0 or empty; `ShowType` would select the type icon frame, `TaskFrameII.refreshIcon` `decompiled/m15/scripts/task/TaskFrameII.as:290-:316`).
- Dates: `StartDate` 791 rows "2000-01-01", 32 rows "2050-01-01" (never available); `EndDate` 542 rows "2050-01-01", 282 rows "2000-01-01" (disabled).
- Chains: `PreQuestId` comma separated ids, all must be finished; 652 quests with one prerequisite, 47 with two.

### Other quest like template sets (owners)

| Set | Used for | Owner |
|---|---|---|
| `RewardTemps` Type 0, `RewardCondictionInfos`, `RewardGoods` | bounty board | [offer-reward.md](offer-reward.md) |
| `RewardTemps` Type 1, 2, 3, `RewardGoods` TemplateId 1000 | cycle quest | [ring-task.md](ring-task.md) |
| `RewardTemps` Type 4 | marriage quests 4001 to 4005 | [marriage](../marriage/README.md) |
| `RewardTemps` Type 5, 6 | Crepúsculo dos Deuses team and personal quests | [seasonal-events](../seasonal-events/README.md) (assumption on owner) |
| `ConsortiaQuestTempInfos`, `ConsortiaQuestConditionTempInfos` | guild quests | [../guild/quests.md](../guild/quests.md) |
| `SimpleTask` (missing), `ServenLeadRewards` (empty) | seven day objectives | [../tutorial/guide-tasks.md](../tutorial/guide-tasks.md) |
| server sent simple tasks (265, 266) | newbie privilege tasks | [simple-tasks.md](simple-tasks.md), [../vip/regist-welfare.md](../vip/regist-welfare.md) |
| `AchievementTaskTemplates` | achievements | [medals](../medals/README.md) |
| `SlateTaskTmpls`, `TheseusDungeonTaskTemplates` | Theseus tasks | [theseus](../theseus/README.md) |
| `NavigationTaskTempInfos` | port tasks | [navigation](../navigation/README.md) |

## 6. Templates

| File | Record | Fields and meaning |
|---|---|---|
| `raw/xml/tempinfos/QuestTemps.xml` (835) | `TaskTemplate` (`decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:46-:112`) | `TemplateId`; `TemplateType`; `Title`; `Detail` description; `Objective`; `NeedFightId` collection scene; `NeedBuildingTemp`; `NeedItemTemp`; `NeedPos`; `NeedMinLevel`, `NeedMaxLevel` level band; `PreQuestId`; `IsLeague`; `IsAuto`; `IsRepeat`; `IsLost`; `RepeatInterval` hours; `RepeatMax`; `RewardPlayGP`, `RewardHeroGP`, `RewardGold`, `RewardCrystal`, `RewardDower`, `RewardMoney`, `RewardConsortiaOffer`, `RewardPlayerOffer`, `RewardStrategy`; `StartDate`, `EndDate`; `WeekSpace`, `HourSpace`; `Sort` list order; `ShowType` |
| `raw/xml/tempinfos/QuestGoods.xml` (191) | `TaskGoodsTemplate` | `TemplateId` quest; `RewardItemID`; `IsSelect`; `RewardItemCount`; `ToJob` 0 all, 1..3 job; `ValidDate` |
| `raw/xml/tempinfos/QuestCondictionInfos.xml` (851) | `TaskCondictionTemplate` | see [quest-conditions.md](quest-conditions.md) |

## 7. Persistent state

Templates stay in files loaded at boot. Optional mirror for SQL joins:

```sql
CREATE TABLE quests.quest_template (
    quest_id          integer   PRIMARY KEY,
    template_type     smallint  NOT NULL,
    title             text      NOT NULL,
    min_level         smallint  NOT NULL,
    max_level         smallint  NOT NULL,
    pre_quest_ids     integer[] NOT NULL DEFAULT '{}',
    requires_guild    boolean   NOT NULL DEFAULT false,
    is_auto           boolean   NOT NULL,
    is_repeat         boolean   NOT NULL,
    repeat_max        smallint  NOT NULL DEFAULT 1,
    repeat_hours      smallint  NOT NULL DEFAULT 24,
    starts_at         timestamp NOT NULL,
    ends_at           timestamp NOT NULL,
    reward_exp        integer   NOT NULL DEFAULT 0,
    reward_gold       integer   NOT NULL DEFAULT 0,
    reward_strategy   integer   NOT NULL DEFAULT 0,
    reward_crystal    integer   NOT NULL DEFAULT 0,
    reward_guild_fund integer   NOT NULL DEFAULT 0,
    reward_contribution integer NOT NULL DEFAULT 0,
    need_fight_id     integer   NOT NULL DEFAULT 0,
    sort_order        numeric   NOT NULL DEFAULT 0
);

CREATE TABLE quests.quest_reward_item (
    quest_id      integer  NOT NULL REFERENCES quests.quest_template(quest_id),
    item_template integer  NOT NULL,
    item_count    integer  NOT NULL CHECK (item_count > 0),
    to_job        smallint NOT NULL DEFAULT 0,
    is_select     boolean  NOT NULL DEFAULT false,
    valid_minutes integer  NOT NULL DEFAULT 0
);
```

## 8. Backend implementation notes

- `quests::templates::load()`: parse the three XML files at boot, build `quest_id -> template`, `quest_id -> [conditions]`, `quest_id -> [items]`, and the condition dispatch index ([quest-conditions.md](quest-conditions.md) section 7).
- `quests::templates::grant_rewards(player, quest)`: EXP (with the daily formula for type 1), gold, spirit, light crystal through [currency](../currency/README.md); guild fortune and contribution through [guild](../guild/README.md) (skip when no guild); items through [inventory](../inventory/README.md) (bag full: assumption, send by mail like other rewards); one transaction with the quest state change.

## 9. Open questions and assumptions

- `RewardMoney` meaning (diamonds assumed) and bag full behavior for quest items.
- Owner of `RewardTemps` Type 5 and 6 (Crepúsculo dos Deuses).

## 10. Implementation checklist

- [ ] Loader for `QuestTemps`, `QuestGoods`, `QuestCondictionInfos`
- [ ] Reward grant for every reward field, daily EXP formula, job filtered items
- [ ] Skip guild rewards without a guild
- [ ] Test: reward values equal the client display for dailies at several levels
