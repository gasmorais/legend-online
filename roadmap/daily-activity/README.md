# Atividade diária e check-in

Domain: events. Slug `daily-activity`. PostgreSQL schema `daily_activity`. Rust handlers `daily_activity::<module>::handle_<action>`.

Conventions: paths are relative to the repository root; AS3 citations use `decompiled/<module>/scripts/<path>.as:<line>`; "C>S" is a `send` opcode and "S>C" an `accept` opcode from `protocol/opcodes.csv`; protobuf fields are `name (#tag, TYPE)` from `protocol/proto.json` (or read from the AS3 class when `proto.json` has a name collision, for example `simple.PropertyMsg`); "Assumption" marks behavior that could not be verified in the client.

Registry: client packages `dayguide`, `dayGuide`, `newactiveleed`, `countlogin`, `loginactivity`, `supersignincard` (plus the unassigned `dailyactivity` and `sandbox` packages used by this feature); proto packages `activity`, `activitydaily`, `leed`, `daylight`.

## What it does for the player

- "Pontos de Atividade" ("Guia Diário" button): a list of daily actions per hero stage; each completed action gives activity points; points open 5 daily chests and 3 weekly chests; a paid buff doubles chest rewards for a week.
- "Check-in diário": a 10 day sign in card with rewards at 2, 5, 8 and 10 signed days; opens automatically at login while today is not signed.
- "Evento de Login": an operator event with rewards for cumulative and consecutive login days.
- "Super cartão de check-in": a paid 8 day card with a daily pack and paid retro sign in.
- "Sorteio da Sorte": a 9 slot wheel; in this build only the group buy wheel is reachable.
- "Matança de Madrugada": a daily guild versus guild sandbox event (15:00 to 15:30) with lanes, towers, monster waves and ranking chests.
- Protocol of the anniversary hub ("Exploração de Aniversário") whose screens belong to seasonal events.
- Dormant in this build: the older leed based activity frame and daily list, the 7 day "Prêmio de Login" frame, the daily lucky draw.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Mini map "Guia Diário" | level >= 11 enabled, >= 6 to open | activity points | `decompiled/core_module/scripts/mainBar/SmallMapBar.as:552`, `:877` |
| Queue bar item 5 | level >= 6 | activity points | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:905`, `:249` |
| Queue bar item 10 "Check-in diário" | level >= 6 | sign in | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:919`, `:341` |
| Task trace bar daily button | none | sign in | `decompiled/core_module/scripts/ui/tasktracebar/TaskTraceBar.as:112` |
| Login auto open | level >= 25, nothing else pending | sign in if today unsigned, else activity points | `decompiled/core_module/scripts/yishi/lunch/Yishi.as:587-:618` |
| Top toolbar `loginactive` (template 2006) | a funny activity of type 131 in its show window | login event | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1233` |
| Top toolbar `supersignincard` (template 2059) | 4590 open | super sign in card | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1476` |
| Top toolbar `sevenyear` (template 2061) | 4590 open | anniversary hub | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1482` |
| Top toolbar time button `daylight` | 4860 state 1, level >= 13 | dawn slaughter | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1350` |
| Group buy lucky draw | group buy draws | lucky wheel | `decompiled/core_module/scripts/funny/groupbuy/GroupBuyView.as:471` |
| Quest "Ir" for condition types 55, 63 (activity) and 79, 80 (timed event) | | activity points, dawn slaughter | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:317`, `:335`, `:348` |

## Modules

| Module | File | Routes | Server messages | Tables |
|---|---|---|---|---|
| Activity points | [activity-points.md](activity-points.md) | 9707, 9708 | 529 | `activity_counter`, `activity_points`, `double_buff` |
| Daily sign in | [daily-sign-in.md](daily-sign-in.md) | 8266 (and 8518 on open) | 4177, `PlayerMsg` sign fields | `sign_cycle`, `sign_log` |
| Legacy day guide | [legacy-day-guide.md](legacy-day-guide.md) | 8322, 8518 live; 8234, 8235, 8236 dormant | 4152, 4150, 4393, 4412 | `leed_record` (only if revived) |
| Lucky draw | [lucky-draw.md](lucky-draw.md) | 9523 (op 1, 2, 3) | 4936 (and 338 owned by group buy) | `lucky_draw_balance`, `lucky_draw_pending` |
| Login count rewards | [count-login.md](count-login.md) | 8496 (dormant) | `PlayerMsg` relogin fields | `login_milestone` |
| Login event | [login-activity.md](login-activity.md) | 8586 (type 1, 2) | 4475, 4476 | `login_event_progress` |
| Super sign in card | [super-sign-in-card.md](super-sign-in-card.md) | 9645 / `extend1` 38 (ops 1 to 4) | 513, 514, 4590 | `super_sign_card_event`, `super_sign_card_reward`, `super_sign_card`, `super_sign_card_day` |
| Anniversary activity data | [year-activity.md](year-activity.md) | 9728 (ops 2 to 10) | 551, 4590 | `year_activity_state` |
| Dawn slaughter | [daylight.md](daylight.md) | 9670 (ops 0 to 11) | 4851, 4852, 4853, 4854, 4855, 4856, 4857, 4859, 4860 | `daylight_signup`, `daylight_match`, `daylight_participant` |

## Dependencies

- [hero](../hero/README.md): `PlayerMsg` (S>C 3) carries `signDate`, `signTimes`, `signSite`, `leed_process`, `relogin_process`, `relogin_count`, `leadExtractTimes`, `weary`, trial tower and copy counters read by these screens.
- [account](../account/README.md): login load request 8224 `PlayerDataMsg` (`leed`, `reward`, `active`, `sum_active` flags) that triggers the login pushes of this feature.
- [vip](../vip/README.md): privilege 2 (activity points per VIP level, `vipNum`) and privilege 3 (auto sign in); VIP gift button in the sign in frame.
- [currency](../currency/README.md) and [inventory](../inventory/README.md): diamond debits and item grants for every reward.
- [mail](../mail/README.md): doubled chest rewards are delivered by mail.
- [quests](../quests/README.md): bounty and ring quest counts feed activity TaskTypes 24 and 56; quest condition 63 (activity points), 79 and 80 (timed event) navigate here.
- [guild](../guild/README.md): guild fortune paid for the dawn slaughter sign up, guild TaskTypes 8, 12, 59, 60, 71, 89.
- [seasonal-events](../seasonal-events/README.md): owns the funny activity engine (4475, 4476, 8586) used by the login event, the `active` proto package (4393), and the anniversary screens (`year2023`).
- [shops](../shops/README.md): group buy grants lucky draws ([../shops/group-buy.md](../shops/group-buy.md)).
- [tutorial](../tutorial/README.md): `leed.ServenDayLeadMsg` and `GetRewardMsg` are used by the dormant seven day objectives ([../tutorial/guide-tasks.md](../tutorial/guide-tasks.md)); `novice_process` gates `DayGuideManager.switchScene`.
- Every feature listed in [activity-points.md](activity-points.md) section 5 must call `activity_points::record` when the player completes the matching action.

## Suggested implementation order

1. Sign in state push 4177 at login (the login flow of heroes of level >= 25 depends on it) and route 8266 with `SignDrop` rewards.
2. Legacy answers: accept 8322, answer 8518 with 4412, push 4152 with `leadExtractTimes` at login.
3. Activity points: tables, 529 at login, `record` hook with the first owners (login, bounty, maze, world boss, guild contribution), chest claim 9707, double buff 9708, daily and weekly reset jobs.
4. Top toolbar push 4590 framework (shared by super sign in card, anniversary and other features), then the super sign in card.
5. Login event on top of the seasonal funny engine.
6. Lucky draw together with the group buy.
7. Dawn slaughter (largest piece: match actor, guild sign up, rewards).
8. Anniversary protocol when the seasonal screens are implemented; count login rewards only if `ReloginDrops` data is recovered.
