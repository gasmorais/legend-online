# Guild quests and activity rewards (economy module)

Scope: the "Escola de missões" (personal daily quests and collective monthly quests claimed by each member), the guild activity reward track shown on the info tab (daily and weekly guild goals), the personal merit currency they grant, and the counters behind them.

Path aliases:

| Alias | File |
|---|---|
| CSOM | `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as` |
| CM | `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as` |
| CVH | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaViewHelper.as` |
| V | `decompiled/m6/scripts/consortia/view/myConsortia/` |

## Overview

Each quest template (`ConsortiaQuestTempInfos.xml`) has exactly one condition (`ConsortiaQuestConditionTempInfos.xml`) with `ConditionId == TemplateId` (the client looks the condition up by the quest `TemplateId`, `CMOD:979`). Three groups by `QuestType`:
- 2: personal daily tasks (activity, diamond spending, guild campaign, treasures, purchases). Claimed by the member; reward personal merit ("Mérito individual").
- 3: collective monthly tasks (members reaching level 80 or first transfer). Claimed by each member; reward guild activity points and items 208104 "Emblema da Guilda".
- 1: guild activity track, daily (`ResetType` 1) and weekly (`ResetType` 2). No claim button; shown lit when the guild already got it. Rewards guild activity points and guild production ("Produção da guilda").

Claim state is a bit array indexed by `TemplateId`: personal bits arrive in 180, guild bits in 179 (`CMOD:969-990`).

Entry points:
- Building map hunter camp -> `CC.showTaskSchoolFrame(6)` -> openType 10 `consortia.ConsortiaTaskSchoolFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaBuildingView.as:260-264`, `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:253-256`,`:413-417`).
- Info tab embeds `ConsortiaActiveRewardView` (`V/newui/ConsortiaInfoView.as:100`,`:119`).
- Red counters: `taskCanRewardCount` (`CMOD:953-967`) feeds the guild button tip (`CM.giftCount` `CM:1538-1552`, `InfoTipsManager` slot 4) and the building tab badge (`V/ConsortiaFrame.as:239`).

## Screens

| Class | pt-BR title | Purpose | Data |
|---|---|---|---|
| `V/ConsortiaTaskSchoolFrame.as` | "Escola de missões" (`:189`) | Tab 0 = `QuestType` 2, tab 1 = `QuestType` 3 (`:192-197`), sorted by state desc then `Sort` (`:199-212`) | guild daily activity `consortia_active_point` and weekly `consortia_weekly_active_point` (`:125-129`,`:161-162`) |
| `V/item/ConsortiaTaskItem.as` | "Missão {0}"; "Descrição da missão: {0} {1}"; "Prêmios da missão: {0}" | One quest row: progress `(process/Target)`, reward text, claim button ("getBtn") when state 2, "já recebido" image when state 0, disabled button when state 1 (`:96-143`) | condition progress from `questInfoList` |
| `V/newui/ConsortiaActiveRewardView.as` | "Nível de atividade da semana atual:{0}" | Two rows of reward boxes: `QuestType` 1 with `ResetType` 1 (day) and 2 (week) sorted by `Sort` (`:129-142`); weekly progress text uses the last weekly quest condition process (`:114-127`) | guild bits (179) |
| `V/item/ConsortiaActiveRewardItem.as` | "{0} pontos de atividade x{1} pessoas" (daily) or `Target` (weekly) | Box lit and "obtido" when guild bit set, grey otherwise; tooltip = rewards (`:63-104`) | |

Reward text (`CVH.getRewardTipString`, `CVH:502-529`): items from `RewardItems` + "Pontos de atividade da guilda x{0}" + "Produção da guilda x{0}" + "Mérito individual x{0}".

## Actions

### Q1. Claim a personal or collective quest reward
- UI: claim button `_getBtnClickHandler` (`V/item/ConsortiaTaskItem.as:85-89`), only visible when `getRewardState(temp, true) == 2`.
- Client path: `CSOM.sendGetQuestReward(templateId)` (`CSOM:364-370`).
- Route: send 5437 (0x153d) `C_CONSORTIA_QUEST_GET_REWARD`.
- Message `com.road.yishi.proto.player.CommonMsg`: `param1` (#1, INT32) = quest `TemplateId`; other fields unset.
- Expected replies in order: 180 (0x00b4) `U_C_CONSORTIA_USER_JOIN_INFO` with the claimed bit set in `quest_site` and the new `reputation` (S2); 164 (0x00a4) to all online members when guild activity points or production changed (`ConsortiaActivePoint` > 0); 115 (0x0073) `U_C_BAG_MOVE_UPDATE` for `RewardItems`. No error reply is handled; on failure send nothing.

There is no client request for the activity track (`QuestType` 1) or for quest progress; both are server pushes.

## Server messages

| Opcode | Name | Message | Handler | Fields read | When |
|---|---|---|---|---|---|
| 179 (0x00b3) | `U_C_CONSORTIA_QUEST_INFO` | `ConsortiaQuestMsg`: `quest_site` (#1, BYTES), `conditionList` (#2, repeated `ConsortiaConditionMsg`: `condition_id` (#1, INT32), `process` (#2, INT32)) | `CM.__consortiaQuestInfoUpdateHandler` (`CM:1209-1241`, listener `CM:183`) | `quest_site` copied byte by byte into `questStateByteAry` (guild claim bits, bit n = byte `n>>3`, mask `1 << (n&7)`, `decompiled/core_module/scripts/yishi/utils/BitArray.as`); conditions merged into `questInfoList` by id; notifies `UPDATE_QUEST_INFO` and recounts | On login for guild members, and pushed to all online members when a guild level condition (types 4..7) changes or a `QuestType` 1 reward is granted |
| 180 (0x00b4) | `U_C_CONSORTIA_USER_JOIN_INFO` | `ConsortiaUserJoinMsg`: `quest_site` (#1, BYTES) personal claim bits, `conditionList` (#2, repeated `ConsortiaConditionMsg`), `reputation` (#3, INT32) personal merit, `active_point` (#4, INT32) personal guild activity today, `weekly_active_point` (#5, INT32) personal guild activity this week | `CM.__userJoinInfoUpdateHandler` (`CM:1163-1207`, listener `CM:182`) | only fields with `has*` set update the model (`CM:1171-1182`); bits into `consortiaQuestStateAry` | On login/join, after Q1, after merit changes (altar, master skill learn, commerce), after personal condition progress (types 1..3, 8..10) |
| 164 (0x00a4) / 4138 (0x102a) | `U_CH_CONSORTIA_FRESHINFO` / `U_C_CONSORTIA_INFO` | `ConsortiaInfoMsg`: `consortia_active_point` (#70, INT32), `consortia_weekly_active_point` (#77, INT32), `consortia_asset` (#71, INT32) | `CM:457` (`CM:563-565`) | guild activity today, this week, production | After rewards that add guild points or production |

Both 179 and 180 write the same `questInfoList`; condition ids never collide because each quest has its own id.

Reward state function (`CMOD:969-990`): bit `TemplateId` set -> 0 (claimed); no condition template -> 1; `process >= Target` -> 2 (claimable); else 1.

## Rules and formulas

Quest data (`raw/xml/tempinfos/ConsortiaQuestTempInfos.xml` + conditions):

| Id | QuestType | ResetType | Condition (`ConditionType`, `Target`, `Param1`) | Rewards |
|---|---|---|---|---|
| 11, 12, 13 | 2 | 1 daily | 1 personal daily activity >= 120 / 180 / 240 | merit 10 / 15 / 20 |
| 21, 22, 23 | 2 | 1 | 2 personal diamonds spent today >= 30 / 50 / 100 | merit 10 / 15 / 20 |
| 31 | 2 | 1 | 3 challenge the guild campaign once | merit 50 |
| 41 | 3 | 3 monthly | 4 members reaching level `Param1` 80 this month >= 10 | guild activity 100, items 208104 x5 |
| 51 | 3 | 3 | 5 members completing the first class transfer this month >= 5 | guild activity 100, items 208104 x5 |
| 61..66 | 1 | 1 daily | 6 number of members whose daily activity >= `Param1` (120, 150, 180, 210, 240, 270) reaches 5, 10, 15, 20, 25, 30 | guild activity 100 + production 1000 / 1500 / 2000 / 2500 / 3000 / 4000 |
| 71..76 | 1 | 2 weekly | 7 guild daily activity accumulated this week >= 500 / 1000 / 1500 / 2000 / 2500 / 3000 | production 10000 + items 208104 x10 |
| 81, 82, 83 | 2 | 1 | 8 treasures collected today >= 1 / 2 / 3 | merit 10 / 15 / 20 |
| 91 | 2 | 1 | 9 purchases in the Câmara de Comércio today >= 1 | merit 20 |
| 101 | 2 | 1 | 10 purchases in the Loja de Prata (copy shop, ShopType 1014) today >= 1 | merit 20 |

Notes:
- Condition 66 text says 250 while `Param1` is 270; use `Param1`.
- `ResetType`: 1 daily (00:00), 2 weekly (Monday 00:00, matches "Pontuação atualizada todas as segundas" used elsewhere; assumption), 3 monthly (first day 00:00).
- Condition sources (cross modules): type 1 activity points (daily activity system), type 2 diamond spending (currency module), type 3 guild campaign challenge (PvE module), types 4/5 member level and transfer (membership/player modules), type 8 treasure claim (`treasure.md`), type 9 commerce purchase (`shop.md`), type 10 copy shop purchase (shop module, ShopType 1014).
- Guild daily activity (`consortia_active_point`) increases by `ConsortiaActivePoint` rewards; type 7 progress = sum of the guild daily activity over the week (assumption: equals `consortia_weekly_active_point`).
- `QuestType` 1 rewards are granted automatically to the guild when reached (assumption: production added to the guild and items 208104 mailed to every member for 71..76); the guild bit is set in 179.
- `QuestType` 3 reward: each member claims once per month; `ConsortiaActivePoint` goes to the guild counters.

## Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConsortiaQuestTempInfos.xml` | `ConsortiaQuestTempInfo` (`decompiled/core_module/scripts/yishi/datas/templates/ConsortiaQuestTempInfo.as`), grouped by `QuestType` in `CMOD.taskTempDic` (`CMOD:400-409`) | `TemplateId`, `QuestType`, `Title`, `ResetType`, `Sort`, `ConsortiaActivePoint`, `ConsortiaAsset`, `PersonReputation`, `RewardItems` (`itemId,count|...`) |
| `raw/xml/tempinfos/ConsortiaQuestConditionTempInfos.xml` | `ConsortiaQuestConditionTempInfo`, looked up by `ConditionId` (`decompiled/core_module/scripts/yishi/datas/templates/cate/ConsortiaQuestConditionTempCate.as:19-35`) | `ConditionId`, `QuestTemplateId`, `ConditionType`, `ConditionDetail` (pt-BR), `Target`, `Param1`, `Param2` |

## Persistent state

```sql
CREATE TABLE guild.member_quest_progress (
  player_id    BIGINT   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  condition_id SMALLINT NOT NULL,
  period_key   DATE     NOT NULL,
  progress     INTEGER  NOT NULL DEFAULT 0 CHECK (progress >= 0),
  PRIMARY KEY (player_id, condition_id, period_key)
);

CREATE TABLE guild.member_quest_claim (
  player_id   BIGINT   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  template_id SMALLINT NOT NULL,
  period_key  DATE     NOT NULL,
  guild_id    INTEGER   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  claimed_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, template_id, period_key)
);

CREATE TABLE guild.guild_quest_progress (
  guild_id     INTEGER   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  condition_id SMALLINT NOT NULL,
  period_key   DATE     NOT NULL,
  progress     INTEGER  NOT NULL DEFAULT 0 CHECK (progress >= 0),
  PRIMARY KEY (guild_id, condition_id, period_key)
);

CREATE TABLE guild.guild_quest_claim (
  guild_id    INTEGER   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  template_id SMALLINT NOT NULL,
  period_key  DATE     NOT NULL,
  granted_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (guild_id, template_id, period_key)
);

CREATE TABLE guild.member_activity (
  player_id   BIGINT  NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  guild_id    INTEGER  NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  day         DATE    NOT NULL,
  active_point INTEGER NOT NULL DEFAULT 0 CHECK (active_point >= 0),
  PRIMARY KEY (player_id, day)
);
CREATE INDEX member_activity_guild_day_idx ON guild.member_activity (guild_id, day);
```

`period_key` = start date of the period (day, Monday of the week or first day of the month) given by `ResetType`. Personal merit is stored in `guild.member.merit` (`funds.md`). Guild activity counters live on `guild.guild` (`active_point_today`, `active_point_week`, see `funds.md`).

## Backend implementation notes

- `guild::quests::handle_claim` (5437): in guild -> template exists and `QuestType` in (2, 3) -> condition progress for the current period >= `Target` -> not claimed in the period. Transaction: insert claim, `guild::funds::add_merit`, `guild::funds::add_activity_points`, `guild::funds::add_asset`, add items; commit; reply 180 (bits + merit), push 115, push 164 to all members if guild counters changed.
- `guild::quests::bump_condition(player, condition_type, amount)` public API called by other modules (activity, currency spend, guild campaign, level up, class transfer, treasure claim, commerce buy, copy shop buy). For guild wide types (4, 5, 6, 7) update `guild_quest_progress`, check `QuestType` 1 thresholds, grant guild rewards automatically, then push 179 to all online members; for personal types push 180 to the player.
- Encoding `quest_site`: build a byte array with bit `TemplateId` set for each claimed template in the current period (max id 101 -> 13 bytes).
- Login: after 4138 send 180 (personal) and 179 (guild).
- Reset: lazy by `period_key`; no stored reset job needed except to push fresh 179/180 to online players at 00:00 (assumption).

## Open questions

- Who receives the `RewardItems` of `QuestType` 1 weekly rewards (all members, president, or a claim elsewhere).
- Whether conditions 61..66 use the member's daily activity from the global activity system or from guild activity (`active_point` in 180).
- Monthly reset moment for types 4 and 5 ("este mês").

## Implementation checklist

- [ ] Client screen: ConsortiaTaskSchoolFrame two tabs with progress and claim
- [ ] Client screen: ConsortiaActiveRewardView day and week boxes
- [ ] Tables `guild.member_quest_progress`, `guild.member_quest_claim`, `guild.guild_quest_progress`, `guild.guild_quest_claim`, `guild.member_activity`
- [ ] Template loaders for the two quest XML files
- [ ] Handler `guild::quests::handle_claim` (5437 -> 180, 164, 115)
- [ ] API `guild::quests::bump_condition` and hooks in activity, currency, PvE, player level, treasure, commerce, shop modules
- [ ] Encoders 179 `ConsortiaQuestMsg` and 180 `ConsortiaUserJoinMsg` with bit arrays
- [ ] Login push of 179/180
- [ ] Automatic grant of `QuestType` 1 rewards
