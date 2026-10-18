# Missões

Domain: events. Slug `quests`. PostgreSQL schema `quests`. Rust handlers `quests::<module>::handle_<action>`.

Conventions: paths are relative to the repository root; AS3 citations use `decompiled/<module>/scripts/<path>.as:<line>`; "C>S" is a `send` opcode and "S>C" an `accept` opcode from `protocol/opcodes.csv`; protobuf fields are `name (#tag, TYPE)` from `protocol/proto.json`, or read from the AS3 class when the name collides (`simple.PropertyMsg`, `simpletask.SimpleTaskMsg`); "Assumption" marks behavior that could not be verified in the client.

Registry: client packages `task` (m15 frame, core model, actions, oldplayerreturn excluded), `ringtask`, `offerreward`; proto packages `quest`, `simpletask`. The bounty and cycle messages are in the proto package `reward` (registry owner [recharge](../recharge/README.md)); they are documented here because only these modules use them.

## What it does for the player

- "Missão" frame and the right side tracker: main story quests chained from level 1 (781 templates), daily quests reset every day, event, VIP and return player quests, manual quests taken from NPC dialogs; each quest has 1 to 4 conditions from 169 condition types and rewards EXP, gold, spirit, light crystal, guild fortune, guild contribution and job specific items.
- "Recompensa" bounty board (level 14+): 4 rolled bounties of quality 1 to 5, one accepted at a time, 20 per day, refreshes every 30 minutes or for 2 diamonds, one key completion for 68 diamonds.
- "Missão de Ciclo (Semanal)" (level 35+): up to 200 chained random quests per week from Asuna with fixed gold and spirit and milestone chests every 10.
- A small server task engine (simple tasks) used by the newbie privilege window.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Main toolbar quest button | at least one quest or bounty | quest frame | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2164`, `decompiled/core_module/scripts/mvc/controler/TaskControler.as:22` |
| Keyboard shortcut (trace title "Missão (Atalho: L)") | novice process > 11000 | quest frame | `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:444` |
| Trace bar entries | novice process >= 15000 | claim or "Ir" | `decompiled/core_module/scripts/ui/tasktracebar/view/TaskTraceItem.as:577` |
| Space NPC of building master type 14 ("Ir" to bounties: level >= 17) | level >= 14 | bounty board | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1369`, `decompiled/core_module/scripts/mvc/controler/OfferRewardController.as:52` |
| Asuna dialog in the Reino dos Céus (node 10000,17) | level >= 35 | accept a cycle quest | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:389` |
| NPC story dialogs | last dialog step | accept a manual quest | `decompiled/m3/scripts/map/space/view/frame/SpaceDialogFrame.as:568` |
| Bounty card item (SonType 213) | no active bounty, bounties left | accept a bounty | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:1013` |
| Day guide navigation id 20 | | quest frame on the daily list | `decompiled/core_module/scripts/managers/DayGuideManager.as:564` |

## Modules

| Module | File | Routes | Server messages | Tables |
|---|---|---|---|---|
| Quest log | [quest-log.md](quest-log.md) | 5012, 5014, 8524, 8352, HTTP `getphone` | 112, 52, 4420 | `quest_progress`, `quest_history`, `finished_bits`, `phone_binding` |
| Quest templates and rewards | [quest-templates.md](quest-templates.md) | none | none | `quest_template`, `quest_reward_item` (optional mirrors) |
| Quest conditions | [quest-conditions.md](quest-conditions.md) | (8635 for type 92, owned by campaign) | 112 | `condition_template` (optional) |
| Bounty board | [offer-reward.md](offer-reward.md) | 8290, 8288, 8289, 8291, 9583, 8298 | 4197, 4198, 4360 | `bounty_board`, `bounty_slot`, `bounty_active` |
| Cycle quest | [ring-task.md](ring-task.md) | 8732, 8731, 8729, 8730 | 4614, 4616, 4615, 4617 | `cycle_progress` |
| Trace bar and popups | [task-trace.md](task-trace.md) | reuses the routes above | reuses the pushes above | none |
| Simple tasks engine | [simple-tasks.md](simple-tasks.md) | 9564 | 265, 266 | `simple_task`, `simple_task_state` |

## Dependencies

- [hero](../hero/README.md): `PlayerMsg` (S>C 3) carries `quest_site_len` (#10), `quest_site` (#11), `reward_times` (#75), hero level, job stage and resources; EXP grant and level up.
- [account](../account/README.md): login load 8224 `PlayerDataMsg` (`quest`, `reward` flags).
- [currency](../currency/README.md), [inventory](../inventory/README.md), [mail](../mail/README.md): reward grants and diamond debits (refresh, one key, instant finish).
- [guild](../guild/README.md): guild fortune and contribution rewards, `IsLeague` quests, guild warehouse items counted by cycle quests; guild quests themselves are in [../guild/quests.md](../guild/quests.md).
- [battle](../battle/README.md) and [campaign](../campaign/README.md): arrest battles (8298), campaign kill and pass counters, collection scene 6001, shadow challenge 8635.
- [daily-activity](../daily-activity/README.md): bounty and cycle completions feed activity TaskTypes 24 and 56; condition types 55, 63, 79, 80 navigate to its screens.
- [vip](../vip/README.md): King contract id 2 instant bounty completion; newbie privilege uses the simple task engine ([../vip/regist-welfare.md](../vip/regist-welfare.md)).
- [marriage](../marriage/README.md): marriage quests share the frame and `RewardTemps` Type 4.
- [tutorial](../tutorial/README.md): quests 1832, 1834, 1912 drive the script; quest 1834 is turned in with `is_pass`; condition type 23 compares the novice process.
- [medals](../medals/README.md): achievements counting bounties (108) and cycle quests (111).
- [secretary](../secretary/README.md): one key bounty completion.
- Every feature named in [quest-conditions.md](quest-conditions.md) must call `quests::conditions::record` for its condition types (campaign, smith, farm, cosmos, runes, mounts, einherjar, guardians, avenger, theseus, monsters, goddess, outyard and others).

## Suggested implementation order

1. Template loaders (`QuestTemps`, `QuestCondictionInfos`, `QuestGoods`, `RewardTemps`, `RewardCondictionInfos`, `RewardGoods`).
2. Quest log core: `quest_site` in `PlayerMsg`, 112 at login with valid `completed_date`, 5012 with server availability, 5014 with rewards and 52. This unblocks the tutorial (quest 1834) and the main story.
3. Condition engine: client state evaluation, then counters for the main story types first (14, 25, 26, 1, 2, 3, 10, 23, 85), then the rest by owner.
4. Bounty board (refresh, accept, finish, one key, arrest).
5. Cycle quest.
6. Simple task engine together with the newbie privilege window; phone binding only if the client config enables it.
