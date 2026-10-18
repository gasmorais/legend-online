# Bounty board ("Recompensa", Caçador de Recompensas)

Area: quests, module `offer-reward`. Covers `managers.OfferRewardManager`, `mvc.module.buildings.OfferRewardModel`, `mvc.module.offerreward.BaseOfferReward`, `yishi.datas.templates.OfferRewardTemplate`, `mvc.controler.OfferRewardController`, the frame `offerreward.OfferRewardFrame` and its views (m15), the bounty part of `task.TaskFrameII`, and the templates `RewardTemps` (Type 0), `RewardCondictionInfos`, `RewardGoods`.

Conventions: see [README.md](README.md). The messages live in the proto package `reward` (registry owner [recharge](../recharge/README.md)); this module defines their use.

## 1. Overview

A board of 4 server rolled bounty quests with a quality from 1 (white) to 5 (orange). The player accepts one at a time, completes its single condition (tribute troops, strengthen, collect items, kill monsters, mini games, arrests, ...), and turns it in for EXP and gold scaled by quality and level. The board refreshes automatically every 30 minutes, twice per day for free, or for 2 diamonds; up to 20 bounties per day (plus server bonus). A one key option completes every remaining bounty of the day for 68 diamonds (level >= 40). The "Contrato dos Elfos" (King contract id 2) makes every accepted bounty instantly completable.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `offerreward.OfferRewardFrame` (`decompiled/m15/scripts/offerreward/OfferRewardFrame.as`), 614 x 461 | "Recompensa" (`buildings.offerreward.OfferRewardFrame.title`, `:145`), help "Ajuda" | board, timer, counters, Magic Spring EXP buff text | key `offerreward` (`decompiled/core_module/scripts/mvc/controler/OfferRewardController.as:28`), from the Space NPC of building master type 14 (`decompiled/core_module/scripts/mvc/controler/BuildingControler.as:40`) reached by `SwitchPageHelp.gotoOfferRewardFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1369`: level >= 17, not in mop up, not in the outer city, `goSpaceAndFind(1)`) | model |
| `offerreward.view.OfferTaskView` / `OfferTaskItem` (`decompiled/m15/scripts/offerreward/view/OfferTaskItem.as`) | title (text before "("), "`CondictionTitle` (0/`Para2`)", EXP and gold values, quality color frame 1..5, "Desistir" | 4 rows `rewardPos` 0..3 (`OfferTaskView.as:61-:64`); state 1 accept button; 2 accepted (give up, warning, quick button when the contract is inactive); 3 completed (`setData` `:298-:369`) | frame | `offerRewardTaskDic`, `...StateDic`, `...ProfileDic` |
| `offerreward.view.OfferTimeView` (`decompiled/m15/scripts/offerreward/view/OfferTimeView.as`) | countdown, free refresh "(n)", quick refresh tip "Sempre que atualizar consome {0} diamantes", all finish tip "Obterá o prêmio mais alto ao completar as missões restantes (pode concluir no máx. 20 vezes)" | refresh and one key | frame | `refreshRemainTime`, `freeRefreshCount` |
| `offerreward.view.OfferCountView` | "Missões de recompensa restante de hoje: {remain} / {max}" | daily counter | frame | `remainRewardCount`, `maxRewardCount` |
| `task.TaskFrameII` bounty menu (type 100) | "Recompensa" | accepted bounty details, claim, "Concluir agora", give up, start mini game, arrest | quest frame ([quest-log.md](quest-log.md)) | `BaseOfferReward` |

`OfferRewardController.start` refuses below level 14 ("Missão de recompensa não aberta!") and when no bounty is left today ("Missões de recompensa de hoje já finalizadas, volte amanhã") (`OfferRewardController.as:52`).

## 3. Routes (client to server)

| # | UI control and sender | Route | Body | Client checks | Expected response |
|---|---|---|---|---|---|
| B1 | frame open when the timer is 0 or a reset is pending (`OfferRewardFrame.initData` `decompiled/m15/scripts/offerreward/OfferRewardFrame.as:80`), timer end (`OfferTimeView.__timeCompleteHandler` `:259`) -> `OfferRewardManager.sendRefreshRewardList(false, true)` `decompiled/core_module/scripts/managers/OfferRewardManager.as:246` | C>S 8290 (0x2062) `C_REWARD_FRESH` | `reward.RewardFreshReqMsg`: `isButton (#1, BOOL)` false = automatic; `pay_type (#2, INT32)` 0 | none | 4197 |
| B2 | free refresh (`OfferTimeView.__onFreeRefreshClick` `decompiled/m15/scripts/offerreward/view/OfferTimeView.as:198`) / quick refresh (`__onQuickRefreshClick` `:97`) | 8290 | `isButton` true; `pay_type` 0 when bound diamonds may be used ("use bind" choice), 1 unbound only | confirm when an orange quest is not accepted ("Você tem uma missão laranja ainda não aceita, certeza em atualizar?"); quick: daily popup with the cost, `point (+ giftToken)` >= `Fresh_Rward` | 3 (diamonds) when paid, 4197 |
| B3 | accept (`OfferTaskItem.__onAcceptClick` `decompiled/m15/scripts/offerreward/view/OfferTaskItem.as:211`) -> `OfferRewardManager.sendAddRewardTask(rewardPos)` `decompiled/core_module/scripts/managers/OfferRewardManager.as:221` | C>S 8288 (0x2060) `C_REWARD_ADD` | `reward.RewardAddedMsg`: `reward_id (#1, INT32)` board position 0..3 | no bounty already accepted ("Já tem missão de recompensa em andamento..."), remaining > 0, template not expired ("Missão de recompensa expirada") and started ("Tempo de aceitação ainda não atingido") (`checkCanAccept` `:258`) | 4198 with the new `RewardInfo` (`is_select` true), 4197 with that row state 2 |
| B4 | give up (board row or quest frame, confirm "Desistir") -> `OfferRewardManager.sendRemoveRewardTask(templateId)` `OfferRewardManager.as:229` | C>S 8289 (0x2061) `C_REWARD_REMOVE` | `reward.RewardRemovedMsg`: `template_id (#1, INT32)` | confirm | 4198 removal (assumption: `is_complete` true without reward, or row omitted), 4197 |
| B5 | claim (quest frame `__getRewardHandler` `decompiled/m15/scripts/task/TaskFrameII.as:701`, trace bar) -> `OfferRewardManager.sendFinishRewardTask(templateId)` `OfferRewardManager.as:237` | C>S 8291 (0x2063) `C_REWARD_FINISH` | `reward.RewardFinishedReqMsg`: `template_id (#1, INT32)`; `reward_item_id (#2, INT32)` 0; `is_pass (#3, BOOL)` false | `isCompleted` or King contract active | rewards (3), 4198 with `is_complete` true, 4360 or 3 with the new daily count |
| B6 | "Concluir agora" (`TaskFrameII.__completeNowHandler` `:756`) | 8291 | `is_pass` true | King contract active (else opens `kingcontract`) | same as B5 |
| B7 | one key finish (`OfferTimeView.__allFinishClick` `decompiled/m15/scripts/offerreward/view/OfferTimeView.as:221`) -> `OfferRewardManager.sendAllFinishRequest(useBind)` `OfferRewardManager.as:259` | C>S 9583 (0x256f) `C_REWARD_ONEKEY` | `player.PayTypeMsg`: `pay_type (#1, INT32)` 0 allow bound, 1 unbound only; other fields unset | level >= 40 ("Nível baixo, função habilitada no Nv. 40"), confirm "Necessário {0} diamantes para completar imediatamente", `point (+ giftToken)` >= `Reward_OneKey` | 3, rewards for every remaining bounty, 4198, daily count |
| B8 | arrest go button (condition 13, 14) (`TaskFrameII.__onGoArrestClick` `decompiled/m15/scripts/task/TaskFrameII.as:908`) -> `OfferRewardManager.sendRewardArrest(type, Para1)` `OfferRewardManager.as:271` | C>S 8298 (0x206a) `C_REWARD_ARREST` | `reward.RewardArrestMsg`: `param1 (#1, INT32)` target (`Para1`, for example 20000); `condiction_type (#2, INT32)` | scene must be space or castle ("Não é possível apreender do cenário atual") | battle start ([battle](../battle/README.md)); on win the counter reaches the goal and 4198 |

Also: bounty card items (SonType 213) used from the bag go through 5006 with the same checks as B3 (`decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:1013`); see [../inventory/item-usage.md](../inventory/item-usage.md). The secretary "Concluir Todas as Missões de Recompensa" calls the same one key logic ([../secretary/chore-actions.md](../secretary/chore-actions.md)).

## 4. Server messages (server to client)

### S1. 4197 (0x1065) `U_C_REWARD_FRESH`

- `reward.RewardFreshRspMsg`: `templateId (#1, INT32, repeated)` the 4 board templates in position order; `reward_lastdate (#2, STRING)` last refresh time (drives the 30 minute timer); `isIsValid (#3, INT32, repeated)` row state 1 can accept, 2 accepted, 3 completed; `qualitys (#4, INT32, repeated)` 1..5; `reward_times (#5, INT32)` bounties done today (`thane.rewardCount`); `free_times (#6, INT32)` free refreshes used today (2 max); `is_button (#7, BOOL)`.
- Receiver: `OfferRewardManager.__refreshRewardListHandler` `decompiled/core_module/scripts/managers/OfferRewardManager.as:153`.
- When: reply to B1, B2, after B3, B4, B5, at login (`PlayerDataMsg.reward = true`, assumption).

### S2. 4198 (0x1066) `U_C_REWARD_UPDATE`

- `reward.RewardUpdatedRspMsg`: `reward (#1, RewardInfo, repeated)`, `states_length (#2)`, `states (#3, BYTES)` (unused by the bounty code). `reward.RewardInfo`: `template_id (#1)`, `is_complete (#2, BOOL)` turned in, `condition_1..4 (#3..#6)` counters, `completed_date (#7)`, `repeat_finish (#8)`, `is_accept (#9)`, `is_select (#10, BOOL)` currently accepted, `quality (#11, INT32)`.
- Receiver: `OfferRewardManager.__updateRewardHandler` `:92`: only rows with `is_select`; new row -> creates `BaseOfferReward` (new quest popup except at login); `is_complete` -> removes it, plays the gain movie (not during one key), fires `REWARD_TASK_FINISH` (daily guide and activity counters); otherwise updates the counters.
- When: after B3, progress changes, B5, B6, B7.

### S3. 4360 (0x1108) `U_C_REWARD_COUNT`

- `player.RewardCountUpdateRspMsg`: `reward_count (#1, INT32)` extra daily bounties; `maxRewardCount = 20 + reward_count` (`OfferRewardManager.__updateRewardCountHandler` `:83`).
- When: login and when the bonus changes (VIP or items, assumption).

`PlayerMsg.reward_times (#75)` also carries the daily count (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:783`).

## 5. Rules and formulas

- Unlock level 14 (`OfferRewardModel.OPEN_REWARD_GRADE` `decompiled/core_module/scripts/mvc/module/buildings/OfferRewardModel.as:17`); the Space shortcut requires 17.
- Daily limit `20 + reward_count`; remaining = max(0, max - `reward_times`) (`:70`).
- One accepted bounty at a time (client check), board of 4 rows (`MAX_OFFER_TASK_NUM` 4).
- Auto refresh every 1800 s from `reward_lastdate` (`refreshRemainTime` `:157`); free refreshes 2 per day (`OfferTimeView.refreshView` `decompiled/m15/scripts/offerreward/view/OfferTimeView.as:272`); paid refresh `Fresh_Rward` = 2 diamonds; one key `Reward_OneKey` = 68 diamonds.
- Reward per bounty (`OfferTaskItem.setData` `decompiled/m15/scripts/offerreward/view/OfferTaskItem.as:298-:326`, `TaskRewardViewII.as:233-:244`): `m = quality == 5 ? 6 : quality`; `vg = isChangeJob ? 80 : vocationGrades`; `EXP = RewardPlayGP * m * (level + vg)`; `gold = RewardGold * m * (level + vg)`; Magic Spring buff 6 adds `floor(AddValue * EXP / 100)` EXP.
- Roll: templates of Type 0 whose level band contains the hero level and dates are valid; `Rands` is the weight (assumption); quality roll is server side (weights unknown).
- King contract id 2 active (`leftTime > 0` and `VersionSwitch.KING_CONTRACT`): every accepted bounty reports complete (`BaseOfferReward.getProgress` `decompiled/core_module/scripts/mvc/module/offerreward/BaseOfferReward.as:183`) and B6 is allowed; the server must check the contract ([vip](../vip/README.md) or the contract owner).

Bounty condition types (`RewardCondictionInfos.CondictionType`, progress in `BaseOfferReward.getProgress`; navigation `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:508-:560`):

| Type | Meaning | Progress | Example (Type 0 data) |
|---:|---|---|---|
| 1 | tribute troops: castle pawn count of `SonType` Para1 >= Para2 | client (pawn count) | "Tributar Anjo" (107, 200) |
| 2 | strengthen equipment Para2 times | server counter | "Fortaleça Qualquer Equipamento" |
| 3 | inlay gems | server | "Inserir Gema" |
| 4 | bag holds item Para1 x Para2 (Para4 walk target) | client (bag) | "Coletar Madeira" (2100022, 10) |
| 5 | energize a friend's Yggdrasil | server | "Energizar Yggdrasil de Amigo" |
| 6 | acquire cosmos | server | "Adquira Cosmo" |
| 7 | kill monsters of matching level | server | "Elimine Monstros de Nível Correspondente" (10, 8) |
| 8 | explore wild treasure Para1 | server | "Explorar Tesouro Selvagem" (2201, 1) |
| 9 | gain guild contribution | server | "Adquirir 10 Contribuições da Guilda" |
| 10 | synthesize any item | server | "Sintetizar Qualquer Item ou Equipamento" |
| 11 | spend diamonds or gift tokens | server | "Consuma Diamante ou Vale-Presente 1 Vez" |
| 12 | QTE training: `QTETraining(Para2 keys, Para1 * 1000 ms)` success | client flag | "Treinamento QTE com Sucesso" (8, 7) |
| 13, 14 | arrest Para1 (battle via B8) | server | "Apreender Espadachim Soenke" (20000, 1) |
| 15 | Mata-Rato mini game `HamsterGameFrame(Para1 s, Para2 points)` success | client flag | "Mata-Rato" (30, 500) |
| 16 to 23 | cycle and marriage types | not handled by `BaseOfferReward` (default "(Não concluído)") | see [ring-task.md](ring-task.md) |

Client flag types (12, 15) have no server signal from the board path; assumption: the server trusts B5 for them (the cycle quest path sends 8731 instead).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/RewardTemps.xml` (414 rows; Type 0: 252) | `OfferRewardTemplate` (`decompiled/core_module/scripts/yishi/datas/templates/OfferRewardTemplate.as:10-:46`) | `TemplateId`, `Title` ("name(...)"), `Type` 0 bounty, 1/2/3 cycle, 4 marriage, 5/6 Crepúsculo dos Deuses, `Detail`, `NeedFightId`, `NeedMinLevel`, `NeedMaxLevel` (Type 0 bands 1..31, 31..41, 41..51, 51..61, 61..71, 71..100), `IsLeague`, `RewardPlayGP` (base, 1000), `RewardGold` (base, 40), `RewardStrategy`, `Rands` weight, `ShowType`, `StartDate`, `EndDate`, `RewardHappy` |
| `raw/xml/tempinfos/RewardCondictionInfos.xml` (399) | `OfferRewardConditionTemplate` | `TemplateId`, `CondictionType`, `CondictionTitle`, `Para1`..`Para4`, `Para5` (story text) |
| `raw/xml/tempinfos/RewardGoods.xml` (107) | `OfferRewardGoodsTemplate` | `TemplateId` (1000 = cycle milestones, others per template), `RewardItemID`, `RewardItemCount`, `RepeatMinLevel`, `RepeatMaxLevel`, `RepeatStep` |
| `ConfigInfos.xml` | config | `Fresh_Rward` 2, `Reward_OneKey` 68 |

## 7. Persistent state

```sql
CREATE TABLE quests.bounty_board (
    player_id         integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    last_refresh_at   timestamptz NOT NULL,
    free_refreshes    smallint    NOT NULL DEFAULT 0 CHECK (free_refreshes BETWEEN 0 AND 2),
    done_today        smallint    NOT NULL DEFAULT 0,
    extra_daily       smallint    NOT NULL DEFAULT 0,
    counters_date     date        NOT NULL
);

CREATE TABLE quests.bounty_slot (
    player_id    integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    position     smallint NOT NULL CHECK (position BETWEEN 0 AND 3),
    template_id  integer  NOT NULL,
    quality      smallint NOT NULL CHECK (quality BETWEEN 1 AND 5),
    state        smallint NOT NULL CHECK (state BETWEEN 1 AND 3),
    PRIMARY KEY (player_id, position)
);

CREATE TABLE quests.bounty_active (
    player_id    integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id  integer     NOT NULL,
    position     smallint    NOT NULL,
    quality      smallint    NOT NULL,
    condition_1  integer     NOT NULL DEFAULT 0,
    condition_2  integer     NOT NULL DEFAULT 0,
    condition_3  integer     NOT NULL DEFAULT 0,
    condition_4  integer     NOT NULL DEFAULT 0,
    accepted_at  timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- `quests::offer_reward::handle_refresh` (8290): if `isButton` false, re roll only when 1800 s passed; if true, use a free refresh when `free_refreshes < 2`, else debit `Fresh_Rward` (bound first when `pay_type` 0); roll 4 templates and qualities, keep the row of an accepted bounty; set `last_refresh_at`; reply 4197.
- `quests::offer_reward::handle_accept` (8288): position valid, state 1, no active bounty, `done_today < 20 + extra_daily`, dates valid; insert `bounty_active`, set slot state 2; push 4198 and 4197.
- `quests::offer_reward::handle_remove` (8289): delete `bounty_active`, slot back to 1 (assumption) or removed; push 4198 and 4197.
- `quests::offer_reward::handle_finish` (8291): condition met (server counters, client checks for types 1 and 4, trust for 12 and 15) or `is_pass` with an active King contract; in one transaction grant EXP and gold by the formula (+ Magic Spring buff), increment `done_today`, delete active, slot state 3; push 3, 4198 (`is_complete` true), 4197; record activity TaskType 24 and quest condition 54 ([../daily-activity/activity-points.md](../daily-activity/activity-points.md)).
- `quests::offer_reward::handle_one_key` (9583): level >= 40, remaining > 0, debit `Reward_OneKey`; grant the highest reward for each remaining bounty (tip text "Obterá o prêmio mais alto": quality 5 multiplier 6, assumption); set `done_today` to the max; pushes.
- `quests::offer_reward::handle_arrest` (8298): start the arrest battle with the target `param1` ([battle](../battle/README.md), battle configuration from the arrest NPC); on victory set the counter and push 4198.
- Daily reset at 00:00: `done_today`, `free_refreshes`.

## 9. Open questions and assumptions

- Quality roll weights and `Rands` meaning.
- Give up result: whether the row returns to state 1 or disappears.
- Whether a give up consumes a daily count.
- One key reward quality.

## 10. Implementation checklist

- [ ] Routes 8290, 8288, 8289, 8291, 9583, 8298
- [ ] Pushes 4197, 4198, 4360 and `PlayerMsg.reward_times`
- [ ] Reward formula with quality, level, job stage and Magic Spring buff
- [ ] King contract instant completion
- [ ] Tables `bounty_board`, `bounty_slot`, `bounty_active`
- [ ] Daily reset and 30 minute auto refresh
- [ ] Counters for types 2, 3, 5 to 11, 13, 14 recorded by their owners
- [ ] Test: accept twice refused, daily limit, free refresh count, orange warning
