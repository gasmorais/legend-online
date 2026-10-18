# Christmas ("Carnaval de Natal")

Feature `seasonal-events`, module `christmas`. Client package `christmas` (`M11/christmas/*`), shared code `CM/yishi/manager/ChristmasManager.as`, `CM/mvc/module/christmas/ChristmasModel.as`, `CM/mvc/module/christmas/ChristmasTaskInfo.as`, `CM/mvc/controler/ChristmasController.as`. Proto package `christmas`.

Conventions: see [README.md](README.md). `CM` = `decompiled/core_module/scripts`, `M11` = `decompiled/m11/scripts`, `CHM` = `CM/yishi/manager/ChristmasManager.as`, `CHMo` = `CM/mvc/module/christmas/ChristmasModel.as`.

---

## 1. Overview

A yearly event (window `christmas_time` in `ConfigInfos.xml`, for example `2025-12-23 00:00:00|2026-01-05 24:00:00`) with a hub frame and eight sub-activities. Pt-BR names (`ChristmasItem.txt.text1..8`):

| # | Sub-activity | Mechanic |
|---|---|---|
| 1 | "Acender Pedido aos Deuses" | Tab "light": spend `christmas_light` items once to light the tree (title reward). Tab "wish": spend "Meia de Natal" for 1 or 10 weighted draws |
| 2 | "Pacotes Especiais" | Daily packs: free, diamond priced, or gated by today's recharge |
| 3 | "Respostas Diárias" | Timed A/B quiz, 15 questions per round, two daily windows, rewards by correct answers |
| 4 | "Virada da Sorte" | Up to 4 diamond draws unlocked by accumulated recharge; each draw reveals one more digit |
| 5 | "Grande Prêmio de Natal" | Jackpot draw with no repeated prizes, costs `christmas_jackpot` items |
| 6 | "Mistério do Nevoado" | Team (2 to 4) exploration of a 64 node map with movement points, mini games, monsters and a boss |
| 7 | "Crítico de Gasto" | Spending milestones; claim normally or pay diamonds for a x2..x6 multiplier |
| 8 | "Sucesso" | 27 achievement tasks give Christmas points; point milestones give rewards |

All requests go through one opcode (9217) with an `op` selector; the server answers with up to four state pushes.

A legacy `CM/managers/ChristmasTreeManager.as` ("Pote Mágico de Natal", listeners 4957..4963, sender 9542) is set up at login (`CM/yishi/lunch/Yishi.as:405`) but has no UI and no caller of its sender. It is not part of this module; see Open questions.

---

## 2. Screens

All frames are 1043x651, opened through controller `christmas` (`CM/mvc/controler/ChristmasController.as`, `frameClassName` by `openType`).

| Class | openType | pt-BR title / label | Purpose | Opened from | Data shown |
|---|---|---|---|---|---|
| `christmas.ChristmasFrame` | 0 | event hub, time "Hora do Evento: {0}-{1}" (`ChristmasFrame.timeTxt.text`) | 8 entry tiles with red dots | Top tool bar button `christmas` (TopToolBtnInfo 4030, `CM/ui/toptoolbar/TopToolsBar.as:1531-1532`) | `openTime`, `stopTime`; per tile red dot (`M11/christmas/ChristmasItem.as:86-140`) |
| `christmas.ChristmasPrayFrame` | 1 | "Acender Pedido aos Deuses" | Light tree and wish draws | Tile 1 | Light item count `{1}/{2}` (`ChristmasPrayFrame.txt.text`), tree animation if `isLight == 1`, wish item count, draw result |
| `christmas.ChristmasPrayPreviewFrame` | 12 | preview | Pool preview of wish (lottery MasterType 2) and light reward (activities MasterType 1) | Preview button of frame 1 | Templates |
| `christmas.ChristmasGiftFrame` | 2 | "Pacotes Especiais" | Daily packs | Tile 2 | `dayCharge` ("carnival.today"), each pack price, rewards, remaining `Limit - bought` (`ChristmasGiftItem.as:177-243`) |
| `christmas.ChristmasAnswerFrame` | 3 | "Respostas Diárias" | Quiz | Tile 3 | Windows "Abre diariamente às {0}, {1}", question, A/B with vote counts, countdown, remaining count, my correct count, 3 reward boxes |
| `christmas.ChristmasAnswerPreviewFrame` | 11 | preview | Reward preview of the 3 answer tiers | Preview button of frame 3 | MasterType 3 templates |
| `christmas.ChristmasLuckyFrame` | 4 | "Virada da Sorte" | Digit draw | Tile 4 | 4 digit wheels, `luckCount` remaining draws, next threshold minus `totalCharge`, sum of won diamonds |
| `christmas.ChristmasRewardFrame` | 5 | "Grande Prêmio de Natal" | Jackpot | Tile 5 | 8 tiers "Prêmio Especial", "1º Prêmio".."7º Prêmio", already won ids greyed (`jackpotRewardInfo`), item count |
| `christmas.ChristmasSnowymistFrame` | 6 | "Mistério do Nevoado" | Team lobby (opType 0/1) or map (opType 2) | Tile 6 | Team list, own team members with leader mark and kick button; map of 64 nodes, "Movimento", "Pontuação individual", "Pontos do Grupo", 4 avatars |
| `christmas.ChristmasSnowRewardFrame` | 13 | preview | Node rewards preview (activities MasterType 4) | Map frame | Templates |
| `christmas.ChristmasHirtFrame` | 7 | "Crítico de Gasto" | Spending milestones | Tile 7 | `totalConsume` ("Gastos Acumulados:"), 5 rows with claim and crit buttons, multiplier text `x{0}`, wheel animation |
| `christmas.ChristmasChengjiuFrame` | 8 | "Sucesso" | Tasks and point milestones | Tile 8 | Task progress "{Describe} {data}/{Para}", score, 15 milestone boxes, claim all |

Red dots (`CHMo:155-290`), summed into the tool bar badge (`TopToolsBar.as:2825-2827`):

| Tile | Condition |
|---|---|
| 1 | bag count of `christmas_light` >= MasterType 1 `Para1` and `isLight == 0` |
| 2 | MasterType 2 first pack id not contained in `giftBuyInfo` (free pack not taken today) |
| 3 | a MasterType 3 tier not in `rewardInfo` with `answerCorrectNum >= Para1` |
| 4 | `luckCount > 0` |
| 7 | a MasterType 5 row with `totalConsume >= Para1` and `isGetReward == 0` |
| 8 | a task with `data >= Para` and not rewarded, or a MasterType 6 milestone not in `scoreRewardInfo` with `score >= Para1` |

---

## 3. Routes (client to server)

Single route: **9217 (0x2401) `C_CHRISTMS_OP`**, body `player.PlayerOpMsg`, sender `ChristmasManager.opRequest(op, id = 0, type = 0)` (`CHM:208-215`). The sender assigns only `op`, `id`, `type`; the other fields are absent.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | Operation (table below) |
| `type` | #2 | INT32 | Sub-mode (op 7 only) |
| `id` | #5 | INT32 | Template id, option, count, team id or node id depending on `op` |

Other `PlayerOpMsg` fields (unused here): `payType (#3)`, `count (#4)`, `index (#6)`, `userId (#7)`, `templateId (#8)`, `campaignId (#9)`, `nodeId (#10)`, `chapterId (#11)`, `uuid (#12, STRING)`, `value1 (#13)`, `value2 (#14)`, `param1 (#15, STRING)`, `param2 (#16, STRING)`, `flag1 (#17, BOOL)`, `flag2 (#18, BOOL)`, `pos (#19)`, `ids (#20, INT32, repeated)`.

| op | Name (`CHM:47-70`) | UI control | Client sender (file:line) | Client checks | id / type | Expected response |
|---|---|---|---|---|---|---|
| 1 | OP_OPEN | Hub opens | `ChristmasFrame()` (`M11/christmas/ChristmasFrame.as:32`) | none | 0 | 558 (full state), 559 (all tasks), 560 (answer state) *(assumption: all three so every red dot is right)* |
| 2 | OP_LOTTERY_NUM | Lucky "turn" button | `ChristmasLuckyFrame.clickHandler` (`ChristmasLuckyFrame.as:300-307`) | button enabled only when `luckCount > 0` (`:436-449`); UI locked until the answer | 0 | 558 with `opType = 2`, new `luckNum`, `luckCount - 1`; the frame animates the new digit only when `opType == 2` (`:323-434`) |
| 3 | OP_BUY_GIFT | Pack buy button | `ChristmasGiftItem.sendBuy` (`ChristmasGiftItem.as:99-132`) | SonType 1 (free) sends directly; else diamonds `point >= Para2` or recharge alert, confirm "Deseja gastar {0} diamantes para comprar os Pacotes Especiais de Natal {1}?"; button enabled only if `Para1 <= dayCharge` and bought < `Limit` | id = activities template id | 558 with new `giftBuyInfo`; bag and wallet pushes |
| 4 | OP_LIGHT | "light up" button | `ChristmasPrayFrame.sendLight` (`ChristmasPrayFrame.as:382-390`) | confirm "Deseja gastar {0} {1} para acender a Árvore de Natal?"; bag count of `christmas_light` >= MasterType 1 `Para1` else "{0} insuficientes." | 0 | 558 with `isLight = 1`; bag pushes |
| 5 | OP_WISH | wish x1 / x10 icons | `ChristmasPrayFrame.callBack` (`ChristmasPrayFrame.as:320-330`) | confirm "Deseja gastar {0} {1} para Pedir aos Deuses?"; bag count of `christmas_wish[0]` >= `christmas_wish[1]` x times | id = 1 or 10 (draw count) | 558 with `opType = 5`, `result` = comma list of lottery template ids drawn; the frame shows them only when `opType == 5` (`:300-318` `showGoods`) |
| 6 | OP_JACKPOT | jackpot button | `ChristmasRewardFrame.callBack` (`ChristmasRewardFrame.as:182-211`) | confirm; bag count of `christmas_jackpot[0]` >= `christmas_jackpot[1]` | 0 | 558 with `opType = 6`, `result` = one lottery template id, `jackpotRewardInfo` extended |
| 7 | OP_CONSUMPTION | crit row: claim | `ChristmasHirtItem.getbtnHandler` (`item/ChristmasHirtItem.as:128-132`) | button enabled when `totalConsume >= Para1` | id = MasterType 5 id, type = 0 | 558 with `consumptionRewardList[id].isGetReward = 1`; rewards x `max(multiple,1)` |
| 7 | | crit row: crit | `ChristmasHirtItem.hirtbtnHandler` (`:134-151`) | not while a wheel is spinning ("Tentar novamente mais tarde."); `point >= Para2` else recharge alert | id, type = 1 | 558 with `result` = rolled multiplier (2..6) and `consumptionRewardList[id].multiple`; the frame spins the wheel when `int(result) > 0` (`ChristmasHirtFrame.as:60-67`) |
| 7 | | wheel stops | `ChristmasHirtView.playStop` (`view/ChristmasHirtView.as:143-153`) | none | id, type = 2 | 558 *(assumption: acknowledgement, server clears `result` to "0")* |
| 8 | OP_START_ANSWER | "answer" button | `ChristmasAnswerFrame.__answerBtnClickHandler` (`ChristmasAnswerFrame.as:236-263`) | local time inside one window of `christmas_answer_time` else "Bloqueadas Respostas Diárias" | 0 | 560 with the first question |
| 10 | OP_CHOICE_ANSWER | A or B toggle | `ChristmasAnswerFrame.__changeHandler` (`:226-234`) | an option selected | id = 1 (A) or 2 (B) | 560 with `myOption`, votes, `choiceRightNum`; then 560 for the next question when the countdown ends |
| 12 | OP_ANSWER_GET_REWARD | reward box | `ChristmasAnswerItem.__clickHandler` (`ChristmasAnswerItem.as:124-134`), `ChristmasAnswerPreviewItem.__btnClickHandler` (`:76-86`) | `answerCorrectNum >= Para1` | id = MasterType 3 id | 560 with `rewardInfo` extended |
| 13 | OP_TASK_REWARD | task claim | `ChristmasCjItem.clickHandler` (`item/ChristmasCjItem.as:133-139`) | button active when `data >= Para` and not rewarded | id = achievement id | 559 (task `isReward = true`), 558 (new `score`) |
| 14 | OP_SCORE_REWARD | milestone box | `ChristmascjSonItem1/2.clickHandler` (`item/ChristmascjSonItem1.as:177-180`, `item/ChristmascjSonItem2.as:189-192`) | `score >= Para1` and id not in `scoreRewardInfo` | id = MasterType 6 id | 558 with `scoreRewardInfo` extended |
| 14 | | "claim all" | `ChristmasCjView.__allBtnClickHandler` (`view/ChristmasCjView.as:185-188`) | none | id = 0 (all reachable milestones) | 558 |
| 15 | OP_END_ANSWER | answer frame closes | `ChristmasAnswerFrame.dispose` (`:391-393`) | none | 0 | none required *(assumption)* |
| 16 | OP_TEAM_LIST | snowy frame open, refresh button, 2 s timer while not on the map | `ChristmasSnowymistFrame` (`ChristmasSnowymistFrame.as:94, 164, 228-251`) | none | 0 | 567 (opType 0 team list, 1 own lobby, 2 exploring) |
| 17 | OP_TEAM_CREATE | create | `__creatBtnClickHandler` (`:243-246`) | visible when opType 0 | 0 | 567 opType 1 |
| 18 | OP_TEAM_JOIN | click a team row | `ChristmasSnowymistItem.__clickHanlder` (`ChristmasSnowymistItem.as:107-116`) | only when opType 0 | id = teamId | 567 opType 1 to every member |
| 19 | OP_TEAM_LEAVE | quit | `__quitBtnClickHandler` (`:238-241`) | visible when opType 1 | 0 | 567 opType 0 to the leaver, 567 opType 1 to the rest |
| 20 | OP_TEAM_KICK | kick button | `ChristmasSnowymistItem.__kickoutBtnClickHandler` (`:102-105`) | visible only to the leader for other members | id = target userId | 567 to all affected |
| 21 | OP_TEAM_START | start | `__startBtnClickHandler` (`:233-236`) | visible only to the leader in opType 1 | 0 | 567 opType 2 to every member |
| 22 | OP_TEAM_CLICK | map node | `ChristmasSnowymistMapItem.sendClick/send` (`ChristmasSnowymistMapItem.as:71-152`), mini game pass `ChristmasSnowymistFrame.miniGamePass` (`:209-212`) | state 0: "Área bloqueada..." (no send); state 1: confirm "Deseja consumir {0} Movimento para explorar?", `energy >= christmas_actionpower[1]`; state 3 with event SonType 2: starts the star area mini game (`StarareaManager.startMiniGame(Para1)`) and sends on pass; SonType 3: confirm, `myPoint >= Para1`; SonType 4: send; SonType 5: confirm, `teamPoint >= Para1` | id = nodeId | 567 opType 2 to every member; bag pushes |
| 23 | OP_TASK_REFRESH | "Sucesso" frame open, every 60 s | `ChristmasChengjiuFrame.timeHandler` (`ChristmasChengjiuFrame.as:36, 70-73`) | none | 0 | 559 with online time progress |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver | When | Client reaction |
|---|---|---|---|---|---|
| 558 (0x022e) | U_C_CHRISTMAS_DATA | `christmas.ChristmasMsg` | `ChristmasManager.__activeInfoHandler` (`CHM:106, 127-149`) | Response to ops 1..7, 13, 14; push on recharge, spend and daily reset | Copies every field into the model, fires `EVENT_UPDATE`; frames refresh, hub and tool bar red dots recount |
| 559 (0x022f) | U_C_CHRISTMAS_TASK_DATA | `christmas.ChristmasTaskListMsg` | `__taskInfoHandler` (`CHM:107, 151-170`) | Response to ops 1, 13, 23; push when a task counter changes | Merges by `taskId` into `taskDic`, fires `christmas.TASK_UPDATE` |
| 560 (0x0230) | U_C_CHRISTMAS_ANSWER_DATA | `christmas.ChristmasAnswersMsg` | `__answerInfoHandler` (`CHM:108, 172-187`) | Response to ops 1, 8, 10, 12; push on each new question | Fires `ANSWER_UPDATE`; frame shows question by `topicId`, countdown, remaining `christmas_answer_count - choiceNum` (closes the quiz view when <= 0) |
| 567 (0x0237) | U_C_CHRISTMAS_SNOWY_MIST_DATA | `christmas.SnowyMistRefreshMsg` | `__snowymistInfoHandler` (`CHM:109, 189-206`) | Response to ops 16..22; push to every team member on team or map change | Sorts own map by `nodeId`, fires `SNOWYMIST_UPDATE`; `opType 2` shows the map and stops the 2 s list timer |
| 4590 (0x11ee) | U_C_TOP_TOOL_BTN | `simple.PropertyMsg` | `__topBtnHandler` (`CHM:110, 113-125`) | Login and window open/close; `param1 = 4030` | `isOpen = param7`, `openTime = param4`, `stopTime = param5`, fires `REFRESH_TOPTOOLS`; every open Christmas frame disposes itself when `isOpen` becomes false |

Message fields:

| Message | Fields |
|---|---|
| `ChristmasMsg` | `opType` (#1, INT32) op that caused the push (2, 5, 6 trigger animations); `score` (#2, INT32) Christmas points; `scoreRewardInfo` (#3, STRING) claimed MasterType 6 ids "id,id,..."; `totalCharge` (#4, INT32) recharge during the event; `lotteryCount` (#5, INT32) not read by the UI; `dayCharge` (#6, INT32) today's recharge; `giftBuyInfo` (#7, STRING) "id,count\|id,count" today's pack purchases; `dayOnline` (#8, INT32) and `onlineDate` (#9, STRING) not read; `luckCount` (#10, INT32) remaining lucky draws; `luckNum` (#11, INT32) number formed by revealed digits; `result` (#12, STRING) last draw: wish "id,id,...", jackpot "id", crit multiplier; `isLight` (#13, INT32) 1 when the tree is lit; `jackpotRewardInfo` (#14, STRING) won jackpot lottery ids; `consumptionRewardList` (#15, ConsumptionRewardInfoMsg, repeated); `totalConsume` (#16, INT32) diamonds spent during the event |
| `ConsumptionRewardInfoMsg` | `itemId` (#1, INT32) MasterType 5 template id; `multiple` (#2, INT32) rolled multiplier, 0 none; `isGetReward` (#3, INT32) 1 claimed |
| `ChristmasTaskListMsg` | `tasks` (#1, ChristmasTaskMsg, repeated) |
| `ChristmasTaskMsg` | `taskId` (#1, INT32) achievement id; `data` (#2, INT32) progress; `isReward` (#3, BOOL) claimed |
| `ChristmasAnswersMsg` | `opType` (#1, INT32) not read; `topicId` (#2, INT32) `ChristmasAnswersTemplates.Id`; `surplusSeconds` (#3, INT32) countdown; `choiceNum` (#4, INT32) questions done this round; `choiceRightNum` (#5, INT32) right answers this round; `optionANum` (#6), `optionBNum` (#7) votes of all players; `myOption` (#8, INT32) 0/1/2; `rewardInfo` (#9, STRING) claimed MasterType 3 ids; `answerCorrectNum` (#10, INT32) accumulated correct answers (the client caps the display at 12, `ChristmasAnswerFrame.as:355-362`) |
| `SnowyMistRefreshMsg` | `opType` (#1, INT32) 0 team list, 1 in lobby, 2 exploring; `snowyMistList` (#2, SnowyMistMsg, repeated) all open teams when 0, the own team as element 0 when 1 or 2 |
| `SnowyMistMsg` | `teamId` (#1, INT32); `teamLeaderUserId` (#2, INT32); `teamPoint` (#3, INT32); `map` (#4, SnowyMistMapMsg, repeated) 64 nodes; `teamPlayers` (#5, SnowyMistTeamPlayerMsg, repeated) up to 4 |
| `SnowyMistMapMsg` | `nodeId` (#1, INT32) 0..63; `eventId` (#2, INT32) activities template id (MasterType 4); `state` (#3, INT32) 0 locked, 1 explorable, 2 done, 3 revealed event pending (state 2 on a boss node with `isBossReward == false` shows as 3) |
| `SnowyMistTeamPlayerMsg` | `userId` (#1), `nickName` (#2, STRING), `grade` (#3), `headId` (#4), `consortiaName` (#5, STRING), avatar `arm` (#6), `cloth` (#7), `wing` (#8), `hat` (#9) STRING, `sex` (#10), `job` (#11), `templateId` (#12), `fashionArm` (#13), `fashionCloth` (#14) STRING, `hideFashion` (#15, BOOL), `isDragonTalker` (#16, BOOL), `energy` (#17, INT32) movement, `myPoint` (#18, INT32) individual score, `isBossReward` (#19, BOOL) boss reward taken |
| `PropertyMsg` (4590) | `param1` (#1, INT32) tool button id 4030; `param4` (#4, STRING) open time; `param5` (#5, STRING) stop time; `param7` (#7, BOOL) open. Other params unused |

No error code: refused operations return a message tip *(assumption: generic tip push)* and the unchanged state.

---

## 5. Rules and formulas

Config keys (`raw/xml/tempinfos/ConfigInfos.xml`, getters `CM/yishi/datas/ConfigInfoManager.as:2039-2105`):

| Key | Value | Meaning |
|---|---|---|
| `christmas_time` | `2025-12-23 00:00:00\|2026-01-05 24:00:00` | Event window (also sent by 4590) |
| `christmas_light` | 208611 | Light item id; quantity = activities MasterType 1 `Para1` (1) |
| `christmas_wish` | `212600903,1` | Wish item id, count per draw |
| `christmas_jackpot` | `212600901,1` | Jackpot item id, count per draw |
| `christmas_rebate` | `100,500,4000,20000` | Accumulated recharge thresholds that each unlock one lucky draw |
| `christmas_actionpower` | `1000,100,100` | Snowy mist: initial movement, cost per exploration, regain every 30 minutes |
| `christmas_answer_time` | `12:00,14:00\|19:00,21:00` | Quiz windows |
| `christmas_answer_count` | 15 | Questions per round |

Rules:
- **Light**: once per event, consumes `Para1` light items, grants MasterType 1 rewards (212600921 title card). `isLight` becomes 1.
- **Wish**: draws 1 or 10 times from lottery MasterType 2 (22 rows) by `Random` weight; cost `christmas_wish[1]` x draws. Each draw increments achievement type 8.
- **Packs** (activities MasterType 2): SonType 1 free; SonType 2 costs `Para2` diamonds; SonType 3 needs `dayCharge >= Para1` and costs `Para2`. `Limit` per day; counts reset at 00:00 (label "carnival.today.reset"). Each purchase increments achievement type 7 *(assumption: one per pack)*.
- **Quiz**: a round has `christmas_answer_count` questions, 15 s each (`DateFormatter.getCountDate(15,...)`, `ChristmasAnswerFrame.as:173`), drawn from 40 `ChristmasAnswersTemplates`. The right option is server side only *(assumption: server holds an answer key; the XML has no answer column)*. Votes `optionANum/optionBNum` are the counts of all players on the same question *(assumption: global per question)*. `answerCorrectNum` accumulates over the event; MasterType 3 tiers at 4/8/12 correct. Achievement type 3 counts completed rounds, type 4 correct answers.
- **Lucky draw**: `luckCount = number of thresholds reached - draws done`. Draw k (k = 1..4) picks a digit from lottery MasterType 1 SonType k (values `d x 10^(k-1)`, d = 1..9, weighted) and `luckNum` keeps the revealed digits. The UI shows the total won as the sum of the right suffixes of `luckNum` (`ChristmasLuckyFrame.getAllGetNum`, `:309-321`): draw k credits the k-digit suffix. Prize currency is diamonds (-400). Example: digits 4, 3, 2, 1 → 4 + 34 + 234 + 1234.
- **Jackpot**: each draw picks one tier among lottery MasterType 3 SonType 1..8 (one or more rows per tier) excluding rows already in `jackpotRewardInfo` ("cada prêmio sorteado não se repete"). `Score` (10..200) *(assumption: added to Christmas points)*. Achievement type 9 counts draws.
- **Spending crit** (activities MasterType 5): when `totalConsume >= Para1` the row is claimable. Crit costs `Para2` diamonds and rolls a multiplier from lottery MasterType 4 (`ItemId` 2..6, weights 35/30/20/10/5); claim grants rewards x multiplier. A row can be crit once *(assumption)* and claimed once.
- **Achievements** (`ChristmasAchievementsTemplates`, 9 types): 1 daily login, 2 online minutes today (10/30/60), 3 quiz rounds, 4 correct answers, 5 snowy mist participations, 6 snowy areas explored, 7 packs bought, 8 wishes, 9 jackpot draws. Claim gives `Score` Christmas points. Types 1 and 2 are daily *(assumption: reset at 00:00 with their claim flag)*.
- **Point milestones** (activities MasterType 6, 15 rows, 30..4500 points): claim once each.
- **Snowy mist**: teams of 2 to 4 (help text); closed 23:30..00:30. Movement starts at 1000, exploring costs 100, regain 100 per 30 min (cap *(assumption)* 1000). Map 64 nodes (8x8, `ChristmasSnowymistFrame.as:303-317`), events from activities MasterType 4: SonType 1 normal area (reward 10 x -22005 "Pontuação do Mistério do Nevoado", adds to `myPoint` and `teamPoint`), 2 mini game (Para1 = star area game id, [../cosmos/README.md](../cosmos/README.md)), 3 monster group (needs `myPoint >= Para1`: 20..80), 4 chest, 5 boss (needs `teamPoint >= 320`). Only one player gets the reward of a normal event; every member gets the boss reward once (`isBossReward`). Exploring a node unlocks its neighbours *(assumption: 4-neighbourhood)*.
- Every frame closes when the 4590 window closes (`__refreshTopToolsHandler`).

---

## 6. Templates

| File | Records | Fields used |
|---|---|---|
| `ChristmasActivitiesTemplates.xml` | 40 | `Id`; `MasterType` 1 light, 2 packs, 3 quiz tiers, 4 snowy events, 5 spending crit, 6 point milestones; `SonType` (packs: 1 free, 2 priced, 3 recharge gated; snowy: 1..5); `Para1` (threshold or requirement), `Para2` (diamond price), `Limit` (daily buy limit), `Reward1..4`/`Num1..4` (negative ids are currencies) |
| `ChristmasLotteryTemplates.xml` | 99 | `Id`; `MasterType` 1 lucky digits (SonType = digit position 1..4), 2 wish pool, 3 jackpot (SonType = tier 1..8), 4 crit multipliers (`ItemId` = multiplier); `ItemId`, `Num`, `Score`, `Random` (weight) |
| `ChristmasAnswersTemplates.xml` | 40 | `Id`, `Topic`, `OptionA`, `OptionB` (pt-BR) |
| `ChristmasAchievementsTemplates.xml` | 27 | `Id`, `Type` 1..9, `Para` goal, `Describe` (pt-BR), `Score` points |
| `ConfigInfos.xml` | | keys above |
| `TopToolBtnInfos.xml` | | `christmas` TemplateId 4030, Sort 2066 |

Client lookups: `TempleteManager.christmasActivitiesTempCate.getTemplatesByType(MasterType)`, `christmasLotteryTempCate.getTemplatesByType / getTempByTypeSonType`, `christmasAnswersTempCate`, `christmasAchievementsTempCate.getTaskList()`.

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

Event windows come from `seasonal_events.event_windows` ([active-framework.md](active-framework.md)).

```sql
CREATE TABLE seasonal_events.christmas_players (
  window_id           integer     NOT NULL REFERENCES seasonal_events.event_windows(window_id),
  player_id           bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  score               integer     NOT NULL DEFAULT 0,
  total_charge        integer     NOT NULL DEFAULT 0,
  day_charge          integer     NOT NULL DEFAULT 0,
  total_consume       integer     NOT NULL DEFAULT 0,
  lucky_draws_done    smallint    NOT NULL DEFAULT 0 CHECK (lucky_draws_done BETWEEN 0 AND 4),
  lucky_number        integer     NOT NULL DEFAULT 0,
  is_light            boolean     NOT NULL DEFAULT false,
  answer_correct      integer     NOT NULL DEFAULT 0,
  online_minutes_day  integer     NOT NULL DEFAULT 0,
  day_date            date        NOT NULL DEFAULT current_date,
  PRIMARY KEY (window_id, player_id)
);

CREATE TABLE seasonal_events.christmas_claims (
  window_id    integer  NOT NULL,
  player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  kind         text     NOT NULL CHECK (kind IN ('score_milestone','answer_tier','jackpot','crit_claim')),
  template_id  integer  NOT NULL,
  multiple     smallint NOT NULL DEFAULT 0,
  claimed_at   timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (window_id, player_id, kind, template_id)
);

CREATE TABLE seasonal_events.christmas_crit_rolls (
  window_id    integer  NOT NULL,
  player_id    bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id  integer  NOT NULL,
  multiple     smallint NOT NULL CHECK (multiple BETWEEN 2 AND 6),
  PRIMARY KEY (window_id, player_id, template_id)
);

CREATE TABLE seasonal_events.christmas_pack_purchases (
  window_id    integer NOT NULL,
  player_id    bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day_date     date    NOT NULL,
  template_id  integer NOT NULL,
  bought       smallint NOT NULL CHECK (bought > 0),
  PRIMARY KEY (window_id, player_id, day_date, template_id)
);

CREATE TABLE seasonal_events.christmas_tasks (
  window_id    integer NOT NULL,
  player_id    bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  task_id      integer NOT NULL,
  progress     integer NOT NULL DEFAULT 0,
  rewarded     boolean NOT NULL DEFAULT false,
  day_date     date,
  PRIMARY KEY (window_id, player_id, task_id)
);

CREATE TABLE seasonal_events.christmas_answer_rounds (
  round_id       bigserial PRIMARY KEY,
  window_id      integer NOT NULL,
  player_id      bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  started_at     timestamptz NOT NULL DEFAULT now(),
  questions_done smallint NOT NULL DEFAULT 0,
  right_answers  smallint NOT NULL DEFAULT 0,
  finished       boolean NOT NULL DEFAULT false
);
CREATE INDEX christmas_answer_rounds_player ON seasonal_events.christmas_answer_rounds (window_id, player_id);

CREATE TABLE seasonal_events.christmas_answer_keys (
  topic_id      integer PRIMARY KEY,
  right_option  smallint NOT NULL CHECK (right_option IN (1,2))
);

CREATE TABLE seasonal_events.christmas_snowy_teams (
  team_id         serial PRIMARY KEY,
  window_id       integer NOT NULL,
  leader_id       bigint  NOT NULL REFERENCES player.players(player_id),
  team_point      integer NOT NULL DEFAULT 0,
  started         boolean NOT NULL DEFAULT false,
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE seasonal_events.christmas_snowy_members (
  team_id       integer NOT NULL REFERENCES seasonal_events.christmas_snowy_teams(team_id) ON DELETE CASCADE,
  player_id     bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  energy        integer NOT NULL DEFAULT 1000,
  energy_at     timestamptz NOT NULL DEFAULT now(),
  my_point      integer NOT NULL DEFAULT 0,
  boss_rewarded boolean NOT NULL DEFAULT false,
  PRIMARY KEY (team_id, player_id)
);
CREATE UNIQUE INDEX christmas_snowy_members_one_team ON seasonal_events.christmas_snowy_members (player_id);

CREATE TABLE seasonal_events.christmas_snowy_nodes (
  team_id   integer  NOT NULL REFERENCES seasonal_events.christmas_snowy_teams(team_id) ON DELETE CASCADE,
  node_id   smallint NOT NULL CHECK (node_id BETWEEN 0 AND 63),
  event_id  integer  NOT NULL,
  state     smallint NOT NULL CHECK (state BETWEEN 0 AND 3),
  PRIMARY KEY (team_id, node_id)
);
```

---

## 8. Backend implementation notes

| Handler | op | Validation order | Transaction and pushes |
|---|---|---|---|
| `seasonal_events::christmas::handle_open` | 1 | window open | read; 558, 559, 560 |
| `seasonal_events::christmas::handle_lucky_draw` | 2 | window open → draws unlocked by `total_charge` > draws done | tx: roll digit, update `lucky_number`, credit diamonds (suffix value); 558 `opType 2`, wallet push |
| `seasonal_events::christmas::handle_buy_pack` | 3 | template MasterType 2 → today's count < `Limit` → `day_charge >= Para1` → diamonds >= `Para2` → bag space | tx: spend, grant, count, task type 7; 558, 559 |
| `seasonal_events::christmas::handle_light` | 4 | not lit → items >= `Para1` | tx: consume, grant, `is_light`; 558 |
| `seasonal_events::christmas::handle_wish` | 5 | id in {1,10} → items | tx: consume, roll, grant, task type 8; 558 `opType 5` with result ids |
| `seasonal_events::christmas::handle_jackpot` | 6 | items → remaining rows not empty | tx: consume, roll without repeat, grant, score, task type 9; 558 `opType 6` |
| `seasonal_events::christmas::handle_consumption` | 7 | type 0: `total_consume >= Para1`, not claimed; type 1: not claimed, not crit yet, diamonds >= `Para2`; type 2: ack | tx; 558 with `result` (type 1 multiplier, else "0") |
| `seasonal_events::christmas::handle_answer_start` | 8 | inside a quiz window → no unfinished round | create round, choose question; 560; schedule next question after 15 s |
| `seasonal_events::christmas::handle_answer_choice` | 10 | round open → option 1/2 → not answered | store, count votes; 560 |
| `seasonal_events::christmas::handle_answer_reward` | 12 | `answer_correct >= Para1` → not claimed | tx grant; 560 |
| `seasonal_events::christmas::handle_task_reward` | 13 | progress >= `Para` → not rewarded | tx: score += Score; 559, 558 |
| `seasonal_events::christmas::handle_score_reward` | 14 | id = 0 claims all reachable; else `score >= Para1` → not claimed | tx; 558 |
| `seasonal_events::christmas::handle_answer_end` | 15 | round open | close round, task type 3 if all questions answered |
| `seasonal_events::christmas::handle_snowy_list/create/join/leave/kick/start` | 16..21 | not 23:30..00:30 → not in a team (17, 18) → team size < 4 (18) → leader (20, 21) → size >= 2 (21) | tx on team rows; 567 to every member (and to the leaver) |
| `seasonal_events::christmas::handle_snowy_click` | 22 | team started → node state → movement >= cost (state 1) → requirement (`myPoint` or `teamPoint`) | tx: spend movement, reveal or resolve node, grant reward to the actor (boss: each member once), tasks types 5 and 6; 567 to every member |
| `seasonal_events::christmas::handle_task_refresh` | 23 | | update online minutes; 559 |

- Hooks: recharge (`total_charge`, `day_charge`, lucky draws unlocked, push 558), diamond spend (`total_consume`, push 558), login (task 1), online time (task 2).
- Schedules: 00:00 reset of `day_charge`, packs and daily tasks; 4590 broadcast at window start and end; quiz question timer (15 s); movement regain every 30 min; snowy mist closure at 23:30 (disband or freeze teams *(assumption)*).
- Mini game nodes (SonType 2) use the star area mini game client; the server only receives op 22 after a pass, so validate that the node is a SonType 2 node in state 3 *(no proof of pass exists on the wire)*.
- No battle is started by this module.

---

## 9. Open questions and assumptions

- *(assumption)* Op 1 answers with 558, 559 and 560; the client needs all three for the red dots.
- *(assumption)* Quiz answer key, vote scope, and what happens on a timeout (counted as wrong).
- *(assumption)* Op 7 type 2 is only an acknowledgement after the wheel animation.
- *(assumption)* Jackpot `Score` feeds Christmas points.
- *(assumption)* Snowy mist adjacency, movement cap, behaviour at the 23:30 closure, and whether a team can explore again after the boss.
- `ChristmasMsg.lotteryCount`, `dayOnline`, `onlineDate`, `ChristmasAnswersMsg.opType` and `SnowyMistTeamPlayerMsg.isDragonTalker` are never read by the client.
- `ChristmasTreeManager` (4957 U_C_CHRISTMAS_PASS, 4958 _RESULT, 4959 _TIMES, 4960 _TIMES_TRUE, 4961 _ALL_PASS, 4963 _COUNT; send 9542 C_CHRISTMASTREE_OP with `item.BottleOpMsg`) is dead code in this client: no screen, no call to `sendOpenInfo`. Do not implement; the live magic jar is [../golden-tree/README.md](../golden-tree/README.md).

---

## 10. Implementation checklist

**Screens:**
- [ ] Tool bar button 4030 and badge count
- [ ] Hub frame with 8 tiles and red dots
- [ ] Pray, pray preview, gift, answer, answer preview, lucky, jackpot, snowy mist, snow reward preview, crit, success frames

**Routes (9217):**
- [ ] op 1 open
- [ ] op 2 lucky draw
- [ ] op 3 buy pack
- [ ] op 4 light
- [ ] op 5 wish x1/x10
- [ ] op 6 jackpot
- [ ] op 7 type 0/1/2
- [ ] op 8, 10, 12, 15 quiz
- [ ] op 13, 14 (single and all), 23 achievements
- [ ] op 16..22 snowy mist

**Server messages:**
- [ ] 558 `ChristmasMsg` with `opType` echo
- [ ] 559 tasks
- [ ] 560 quiz state and question timer pushes
- [ ] 567 team and map pushes to all members
- [ ] 4590 window (param1 4030)

**Tables:**
- [ ] `christmas_players`, `christmas_claims`, `christmas_crit_rolls`, `christmas_pack_purchases`, `christmas_tasks`
- [ ] `christmas_answer_rounds`, `christmas_answer_keys`
- [ ] `christmas_snowy_teams`, `christmas_snowy_members`, `christmas_snowy_nodes`

**Rules:**
- [ ] Config keys loaded from `ConfigInfos.xml`
- [ ] Weighted rolls from `ChristmasLotteryTemplates`
- [ ] Lucky digit composition and suffix credit
- [ ] Daily reset and window closure

**Tests:**
- [ ] Lucky draw without unlocked thresholds is refused
- [ ] Jackpot never repeats a row; exhausts after all rows
- [ ] Pack limit per day and recharge gate
- [ ] Quiz outside windows refused
- [ ] Snowy mist: join a full team, kick by non leader, start with 1 member, boss with low team points
