# Activity points ("Pontos de Atividade")

Area: daily-activity, module `activity-points`. Covers the live daily and weekly activity system: `managers.NewActiveLeedManager`, `mvc.module.newactiveleed.NewActiveLeedModel`, the frame `newactiveleed.*` (m11), the templates `ActivityDailyTemplates`, `ActivityDailyDrop`, `ActivityWeekDrop`, and the proto package `activitydaily`.

Conventions: see [README.md](README.md).

## 1. Overview

Every day the player earns activity points ("pontos de atividade") by doing listed actions (login, bounty quests, maze, world boss, arena, guild actions and so on). Each action gives `Num` points once its counter reaches `PassCount`. The activity list depends on the hero stage ("MasterType": 1 novice, 2 first job transfer, 3 second transfer, 4 advanced, unused by the UI). Points feed two chest bars:

- Daily bar: 5 chests at point thresholds (for example 20/40/60/80/100 for stage 1), reset every day at 00:00 ("Reseta às 0:00 diariamente").
- Weekly bar: 3 chests at weekly point thresholds, reset on Monday 00:00 ("Reseta nas segundas-feiras às 0:00").

A paid "Obter ganhos dobrados" option (165 diamonds, 1 week) doubles chest rewards ("os prêmios são enviados por e-mail"). VIP players get a "Login VIP" item worth extra points.

This replaces the older leed based daily guide ([legacy-day-guide.md](legacy-day-guide.md)); the HUD "Guia Diário" button opens this frame.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `newactiveleed.NewActiveLeedFrame` (`decompiled/m11/scripts/newactiveleed/NewActiveLeedFrame.as:62`), 773 x 533 | "Pontos de Atividade" (`dayGuide.view.DayGuideFrame.title`, `:262`) | Three stage tabs (novice, first transfer, second transfer), double reward button, double countdown "Ganhos dobrados até: {0}" | `FrameControllerManager` key `newactiveleed` (`decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:2015`); see entry points below | `NewActiveLeedModel.buffTime`, selected `masterType` |
| `newactiveleed.NewActiveLeedView` (`decompiled/m11/scripts/newactiveleed/NewActiveLeedView.as:66`) | sub tabs "Diário", "Solo", "Multiplayer", "Multi PvP", "Guilda", "Einherjar/Guardião" (style names `NewActiveLeedView.dailyBtn` ... `petAndChildBtn`); "(Reseta às 0:00 diariamente)", "(Reseta nas segundas-feiras às 0:00)" | Daily points, weekly points, progress bar, 5 daily chests, 3 weekly chests, scrolling activity list | frame | `model.dailyNum`, `weekNum`, `dailyProcessArr`, `weekProcessArr`, templates of (`masterType`, `sonType`) |
| `newactiveleed.NewActiveLeedItem` (`decompiled/m11/scripts/newactiveleed/NewActiveLeedItem.as:42`) | `Title`, `Description`, "Hora do Evento:" `TaskTime`, "+`Num`", "`curCount`/`PassCount`" or "Completado" | One activity with a go button | view | `NewActiveLeedInfo` (template plus `curCount`, `isComplete`) |
| `newactiveleed.NewActiveBoxItem` (`decompiled/m11/scripts/newactiveleed/NewActiveBoxItem.as:47`) | threshold number, tip "Ao abrir obterá:" plus item list | Chest: state 1 locked, 2 claimable (glow), 3 claimed (dark) | view | drop rows of the stage |

Entry points:

| Entry | Condition | Source |
|---|---|---|
| Mini map "Guia Diário" button (`smallMap.DayGuideBtn`, tip `mainBar.TopToolsBar.dailyRoutineBtnTipData`) | enabled at level >= 11 (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:552`); click blocked under level 6 with "Nível menor que 6, não é possível abrir o Guia Diário" | `SmallMapBar.__dayGuideBtnClickHandler` `decompiled/core_module/scripts/mainBar/SmallMapBar.as:877` |
| Queue bar item type 5 | level >= 6 (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:905`) | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:249`, `decompiled/core_module/scripts/ui/queuebar/view/QueueItem.as:570` |
| Login auto open | after the login load, hero level >= 25, no pending mail check, marriage heart question or version broadcast, today already signed in, scene not `PLANE_CRISRIS` or `GAME_HALL_SCENE` (when today is not signed the sign in frame opens instead) | `decompiled/core_module/scripts/yishi/lunch/Yishi.as:587-:618`, `:641` |
| `SwitchPageHelp.gotoDayGuideFrame` (quest condition types 55 and 63 "Ir") | level >= 6, not in mop up | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1312` |
| King return page | none | `decompiled/m11/scripts/kingback/page/KingbackOtherPage.as:247` |

Stage tab availability (`NewActiveLeedFrame.initBtnState` `decompiled/m11/scripts/newactiveleed/NewActiveLeedFrame.as:116`): if the hero is not holy, not avenger and has no second transfer (`isChangeJob`), tab 3 is disabled; if also `vocationGrades == 0`, tab 2 is disabled. The highest enabled tab is selected; `model.masterType = selectIndex + 1` (`:208`). MasterType 4 is never shown.

## 3. Routes (client to server)

### A1. Claim a chest

- UI: click a chest in state 2 (`NewActiveBoxItem.__clickHandler` `decompiled/m11/scripts/newactiveleed/NewActiveBoxItem.as:81`).
- Client checks: daily chest, none. Weekly chest: if the double buff is inactive (`buffTime <= now`), a confirm popup offers to buy the buff first (`dayguide.newleed.doubleActiveText`); "Confirmar" with enough diamonds sends A2 instead, otherwise the recharge popup; "Cancelar" still sends A1 (`:115-:131`).
- Sender: `NewActiveLeedManager.sendGetReward(masterType, index, isWeek)` `decompiled/core_module/scripts/managers/NewActiveLeedManager.as:89`.
- Route: C>S 9707 (0x25eb) `C_ACTIVITY_DAILY_FINISH`, `activitydaily.ActivityDailyFinishedReqMsg`: `masterType (#1, INT32)` stage tab; `index (#2, INT32)` 0 based chest index after sorting the drop rows of the stage by threshold; `isWeek (#3, BOOL)` weekly bar.
- Expected response: item grant (bag update push, owner [inventory](../inventory/README.md)), then S>C 529 with the updated `activityDaily` entry of that stage (process string with a 1 at `index`).

### A2. Buy double rewards

- UI: "Obter ganhos dobrados" (`NewActiveLeedFrame.__doubleBtnClickHandler` `decompiled/m11/scripts/newactiveleed/NewActiveLeedFrame.as:155`) or the weekly chest popup.
- Client checks: confirm popup "Deseja gastar {0} diamantes para ter os prêmios do Baú dos Pontos de Atividade dobrados por 1 semana? (os prêmios são enviados por e-mail)"; `playerInfo.point >= leed_buy_buff_point` else recharge popup (`:165`). The button is hidden while the buff is active (`refreshView` `:212`).
- Sender: `NewActiveLeedManager.sendBuyBuff` `decompiled/core_module/scripts/managers/NewActiveLeedManager.as:99`.
- Route: C>S 9708 (0x25ec) `C_ACTIVITY_BUY_BUFF`, no body.
- Expected response: diamond update (S>C 3 `PlayerMsg.point`, owner [currency](../currency/README.md)), then S>C 529 with `buff_stop_date`.

### A3. Go to an activity

- UI: go button of an item (`NewActiveLeedItem.__gotoBtnClickHandler` `decompiled/m11/scripts/newactiveleed/NewActiveLeedItem.as:90`) calls `DayGuideManager.switchScene(TaskType)` (`decompiled/core_module/scripts/managers/DayGuideManager.as:443`). Client navigation only; see section 5 for the per TaskType gates.

## 4. Server messages (server to client)

### S1. 529 (0x0211) `U_C_ACTIVITY_UPDATE`

- Message `activitydaily.ActivityDailyUpdatedRspMsg`: `activityDailyData (#1, ActivityDailyData, repeated)` counters; `activityDaily (#2, ActivityDailyRspMsg, repeated)` one per stage; `buff_stop_date (#3, STRING)` "YYYY-MM-DD hh:mm:ss" end of the double buff (past or empty when inactive); `vipNum (#4, INT32)` points shown for the "Login VIP" item.
- `ActivityDailyData`: `masterType (#1, INT32)`, `sonType (#2, INT32)`, `taskType (#3, INT32)` identify the template row; `current_count (#4, INT32)` progress; `is_complete (#5, BOOL)` reached `PassCount`.
- `ActivityDailyRspMsg`: `masterType (#1, INT32)`; `activityDailyProcess (#2, STRING)` daily chest flags joined by "|" in threshold order, "0" unclaimed, "1" claimed; `totalNum (#3, INT32)` daily points; `weekActivityDailyProcess (#4, STRING)` weekly chest flags; `weekTotalNum (#5, INT32)` weekly points.
- Receiver: `NewActiveLeedManager.__activityUpdateHandler` `decompiled/core_module/scripts/managers/NewActiveLeedManager.as:59`: `buffTime` and `vipNum` only when present (`has*`), each data row patched into the template found by (`masterType`, `sonType`, `taskType`) (`NewActiveLeedCate.getInfoByTaskType` `decompiled/core_module/scripts/yishi/datas/templates/cate/NewActiveLeedCate.as:48`), each stage entry replaces `model.dailyArr[masterType]`, then `NEW_ACTIVELEED_UPDATE` refreshes the frame and the queue item (`decompiled/core_module/scripts/ui/queuebar/view/QueueItem.as:505`).
- When: login (part of the 8224 load with `leed = true`, assumption), every counter change, after A1 and A2, at the daily and weekly resets. Partial pushes are valid: only rows that changed need to be sent, but a stage entry must always carry both process strings and totals.
- Errors: the client has no error path; on a refused claim simply resend the unchanged stage entry.

## 5. Rules and formulas

- Points per activity: `Num` once `current_count >= PassCount`; activity 10107/20105/30103 "Login VIP" (`TaskType` 98, `Num` 0) shows "+`vipNum`" and is hidden when `vipNum == 0` (`NewActiveLeedView.refreshActiveItem` `decompiled/m11/scripts/newactiveleed/NewActiveLeedView.as:192`, `NewActiveLeedItem.as:102`). `vipNum` = VIP privilege type 2 `para1` of the current VIP level (0, 0, 10, 10, 20, 20, 30, 30, 40 for VIP 1 to 9, see [../vip/privileges.md](../vip/privileges.md)); assumption: added to the daily points once per day at login.
- Daily cap: `ConfigInfos.MaxDailyActivity = "100,200,150,100"` (max daily points per stage 1..4); equals the last daily threshold of each stage. The client never reads it; the server must clamp `totalNum`.
- Chest thresholds and items: `ActivityDailyDrop` / `ActivityWeekDrop` rows with `para2 == masterType`, grouped by `site` (the threshold), sorted ascending (`NewActiveLeedDailyCate.getDropGoods` `decompiled/core_module/scripts/yishi/datas/templates/cate/NewActiveLeedDailyCate.as:35`, `NewActiveBoxItem.refreshView` `decompiled/m11/scripts/newactiveleed/NewActiveBoxItem.as:134`). Index `i` of A1 is the i-th threshold.
- Chest state (`NewActiveBoxItem.as:151-:167`): flag "1" claimed; flag "0" and `threshold <= points` claimable; otherwise locked.
- Progress bar frame = `dailyNum / lastDailyThreshold * 100` (`NewActiveLeedView.as:238-:244`).
- Double buff: 165 diamonds (`ConfigInfos.leed_buy_buff_point`, default 1000 in `ConfigInfoManager.getLeedBuyBuffPoint` `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1306`), lasts 7 days from purchase (text "por 1 semana"); effect: each chest claimed while active is granted twice, the second copy by mail (assumption from the popup text). Buying while active is impossible from the UI; the server must refuse it.
- Resets: daily counters, `totalNum` and daily flags at 00:00 server time; weekly points and flags on Monday 00:00 (view texts `NewActiveLeedView.dayDescTxt.text`, `weekDescTxt.text`). Weekly points = sum of daily points earned in the week (assumption).
- Stage used for accrual: the stage of the hero (1 if `vocationGrades == 0`, 2 after the first transfer, 3 after the second transfer or as avenger or holy). Assumption: counters only accrue on the current stage; lower stages stay visible with their stored values.
- Activity catalog (78 rows). TaskType meanings follow `DayGuideCatecory` constants (`decompiled/core_module/scripts/mvc/module/dayGuide/DayGuideCatecory.as:34-:228`); the server increments a counter each time the player completes one action of that kind:

| TaskType | Constant | Rows (Id: Title, PassCount, Num) | Go target and gate (`DayGuideManager.switchScene`) |
|---:|---|---|---|
| 1 | DAILY_LOGIN | 10101 "Login Diário" 1, 5 | none |
| 5 | PASS_MUL_CAMPAIGN | 10302 "Multiplayer" 1/15, 20302 1/20 | level >= 20, multiplayer hall (`goSpaceAndFind(2)`) |
| 8 | CONTRIBUTE | 10501 "Contribuir à Guilda" 1/5 | guild frame |
| 12 | BLESS | 10502 "Benção da Guilda" 2/5 | guild frame tab 4 |
| 13 | PVP | 20306, 30305, 40302 "Arena Multiplayer" 5/10..20 | PvP frame |
| 15 | CONSUME_GIFT_POINT | 30101 "Consumir diamantes" 1/5 | shop |
| 18 | WORLDBOSS | 10303, 20305, 30304 "Chefão Global" | world boss frame |
| 19 | COLOSSEUM | 10202, 20201, 30201 "Caminho da Glória" | colosseum frame |
| 23 | MAZEROOM | 10201 "Labirinto Subterrâneo" | maze frame |
| 24 | OFFERREWARD | 10104 "Missão Recompensada" 5/5 | bounty board |
| 25 | FARM_HARVEST | 10102 "Pastagem e Fazenda" 1/10 | farm (novice process > 25000, level >= 12) |
| 27 | WAR_FIGHT | 10301, 20301, 30301, 40301 "Campo de Batalha" | battlefield frame |
| 30 | PET_CHALLENGE | 20601, 30601 "Arena dos Einherjar" 5 | level >= 50, `goSpaceAndFind(3)` |
| 39 | REMOTE_PET | 20602, 30602 "Expedição de Einherjar" | level >= 50, `goSpaceAndFind(31)` |
| 40 | SINGLE_PASS | 20603 "Caminho do Céu" | level >= 60, `goSpaceAndFind(20)` |
| 42 | PLANES_WAR | 10203, 20202 "Batalha dos Planos" | transfer frame |
| 43 | GUARDS_WANTED | 20606 "Guardiões Procurados" | `childpve` |
| 46 | TREASURE_HUNT | 10103 "Bar da Fantasia" 5/5 | level >= 32, `magicpub` |
| 47 | CHILD_ARENA | 20607, 30605 "Arena do Guardião" | guardian arena |
| 51 | CHILD_PATROL | 20605 "Patrulha do Guardião" | level >= 55, needs a guardian, `childpatrol` |
| 56 | RING_TASK | 10105 "Ciclos" 5/5 | level >= 35, `goSpaceAndFind(17)` |
| 59 | CONSORTIA_SECRET | 10504 "Eremitério" | level >= 13, guild frame (1, 5) |
| 60 | CONSORTIA_BOSS | 20502 "Terra dos Sonhos" | level >= 13, guild frame (1, 5) |
| 61 | PET_LAND | 20604 "Guarda da Ilha do Einherjar Elite" | event open and level >= 50, walk to the pet boss node |
| 64 | ARCHAEOLOGY | 20102 "Arqueologia/Astronomia" 5/10 | outer archaeology |
| 66 | NAVIGATION | 30102 "Navegação" | level >= 80, `navigation` |
| 69 | PERKIN_LAB | 20104 "Laboratório de Platina" | Perkin lab |
| 71 | CONSORTIA_TREASURE | 10503, 20501 "Tesouro da Guilda" | level >= 13, guild frame 11 |
| 72 | TITAN_TEMPLES | 30206, 40203 "Santuário de Titã" | titan temple |
| 73 | TIME_GATE | 30603, 40601 "Portal do Tempo" | shuttle frame |
| 74 | ABYSS_MAW | 30606, 40602 "Abismo Sem Fim" | abyss frame |
| 80 | GAME_HALL | 20103 "Salão do Jogo" | walk to node 10000,44 |
| 81 | REVENGE_ROAD | 40204 "Caminho da Vingança" | revenge road |
| 85 | DEMON_LAND | 20205, 30203 "Continente dos Demônios" | demon land |
| 86 | TIME_VORTEX | 20204, 30202 "Vórtice do Tempo" | time vortex |
| 87 | LORD_TRIAL | 30204, 40201 "Julgamento Principal" | lord trial |
| 88 | ECLIPTIC_PALACE | 30205, 40202 "Templo Eclíptico" | ecliptic palace |
| 89 | CONSORTIA_FUBEN | 30501 "Campanha da guilda" | guild dungeon |
| 90 | REDEMPTION_ROAD | 40205 "Caminho da Salvação" | redemption road |
| 95 | CHILDESAL | 30604 "Selo do Guardião" | guardian seal |
| 96 | FORBIDDEN_BOSS | 30306, 40303 "Boss da Zona Proibida" | `goSpaceAndFind(49)` |
| 98 | VIP_LOGIN | 10107, 20105, 30103 "Login VIP" | none |
| 99 | ACTIVITY_CAMPAIGN | 20303, 30302 "Evento" | level >= 20, `goSpaceAndFind(2)` |
| 100 | WEEK_CAMPAIGN | 20304, 30303 "Campanha semanal" | level >= 20, `goSpaceAndFind(2)` |
| 101 | OUTYARD_FIGHT | 20504, 30503, 40502 "Luta de Terralém" 100 | outyard scene |
| 102 | OUTYARD_FIGHT2 | 30504, 40503 "Luta do Forte" | outyard scene |
| 103 | GAME_BOX | 10106 "Caixa do jogo" 1/10 | level >= 28, `goSpaceAndFind(44)` |
| 104 | OUTYARD_EXPLORE | 20206 "Exploração em Terralém" 200/10 | outyard scene |

Every navigation that leaves the current scene first runs `checkScene` (`decompiled/core_module/scripts/managers/DayGuideManager.as:1030`): blocked during world boss campaigns and inside PvE or PvP rooms ("Você está dentro de uma sala, não é possível realizar essa ação"). Gate messages: "Função não habilitada, não é possível pular" (`dayGuide.DayGuideManager.command01`) and "Nível baixo, função habilitada no Nv. {0}" (`command02`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ActivityDailyTemplates.xml` (78 rows, loaded as `newActiveLeedCate`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1384`) | `NewActiveLeedInfo` (`decompiled/core_module/scripts/yishi/datas/templates/NewActiveLeedInfo.as:3`) | `Id` (MasterType*10000 + SonType*100 + n), `MasterType` 1..4, `SonType` 1 daily, 2 solo, 3 multiplayer, 4 multiplayer PvP (no rows), 5 guild, 6 Einherjar and Guardian, `TaskType` (section 5), `Para1`, `Para2` (always 0), `TaskTime` display text, `Title`, `Description`, `RewardDes` tooltip, `PassCount` goal, `Num` points, `Sort` |
| `raw/xml/tempinfos/ActivityDailyDrop.xml` (40 rows, `newActiveLeedDailyCate` `:1385`) | `CommonDropTempInfo` | `id`, `dropId` (20800000 + stage*1000 + chest), `site` threshold, `para2` stage, `itemId`, `count`, `isBind` (1), `appearType`, `validDate`, `isShow` |
| `raw/xml/tempinfos/ActivityWeekDrop.xml` (48 rows, `newActiveLeedWeekCate` `:1386`) | `CommonDropTempInfo` | same; thresholds stage 1: 200/400/600, stage 2: 400/800/1200, stage 3: 300/600/900, stage 4: 200/400/600; items include `-500` bound diamonds and `-3000` currency |
| `raw/xml/tempinfos/ConfigInfos.xml` | config | `leed_buy_buff_point` 165, `MaxDailyActivity` "100,200,150,100" |

Daily thresholds: stage 1 20/40/60/80/100, stage 2 40/80/120/160/200, stage 3 30/60/90/120/150, stage 4 20/40/60/80/100.

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS daily_activity;

CREATE TABLE daily_activity.activity_counter (
    player_id      BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    master_type    smallint  NOT NULL CHECK (master_type BETWEEN 1 AND 4),
    son_type       smallint  NOT NULL CHECK (son_type BETWEEN 1 AND 6),
    task_type      smallint  NOT NULL,
    current_count  integer   NOT NULL DEFAULT 0 CHECK (current_count >= 0),
    is_complete    boolean   NOT NULL DEFAULT false,
    activity_date  date      NOT NULL,
    PRIMARY KEY (player_id, master_type, son_type, task_type)
);

CREATE TABLE daily_activity.activity_points (
    player_id        BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    master_type      smallint NOT NULL CHECK (master_type BETWEEN 1 AND 4),
    activity_date    date     NOT NULL,
    daily_points     integer  NOT NULL DEFAULT 0 CHECK (daily_points >= 0),
    daily_claimed    smallint NOT NULL DEFAULT 0,
    week_start       date     NOT NULL,
    weekly_points    integer  NOT NULL DEFAULT 0 CHECK (weekly_points >= 0),
    weekly_claimed   smallint NOT NULL DEFAULT 0,
    PRIMARY KEY (player_id, master_type)
);

CREATE TABLE daily_activity.double_buff (
    player_id    BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    stop_at      timestamptz NOT NULL,
    bought_at    timestamptz NOT NULL DEFAULT now()
);
```

`daily_claimed` and `weekly_claimed` are bit masks (bit i = chest i claimed) serialized as the "0|1|0|0|0" strings. Rows whose `activity_date` or `week_start` is older than the current period are treated as zero and rewritten lazily.

## 8. Backend implementation notes

- `daily_activity::activity_points::push_state(player)`: builds 529 with all counters of the current stage, one `ActivityDailyRspMsg` per stage 1..3 (stage 4 optional), `buff_stop_date` and `vipNum`. Call on login, after resets and after every change.
- `daily_activity::activity_points::record(player, task_type, amount)`: called by every owning feature when an action happens (bounty finished, maze run, world boss attack, guild contribution, diamond spend, and so on). Finds the template row of the current stage with that `TaskType`; increments `current_count` up to `PassCount`; on the transition to complete adds `Num` to `daily_points` (clamped to `MaxDailyActivity[stage]`) and to `weekly_points`; pushes a partial 529. Login (`TaskType` 1) and VIP login (98, `vipNum` points) are recorded on the first login of the day.
- `daily_activity::activity_points::handle_claim_chest` (9707): validate `masterType` <= current stage, `index` within the stage thresholds, threshold <= points, flag not set; in one transaction set the flag and grant the drop rows (`isBind` true, `validDate` minutes); if the double buff is active also send the same items by mail ([mail](../mail/README.md)); push bag updates and 529.
- `daily_activity::activity_points::handle_buy_double` (9708): refuse when active; debit `leed_buy_buff_point` diamonds (unbound only, the client checks `point`); set `stop_at = now + 7 days`; push 3 and 529.
- Schedules: daily reset job at 00:00 and weekly job on Monday 00:00 that push 529 to online players.

## 9. Open questions and assumptions

- Assumption: only the current stage accrues counters; whether lower stages also accrue is unknown.
- Assumption: the double buff duplicates chest rewards by mail; the exact effect (double items or extra mail) is only described by the popup text.
- Assumption: weekly points are the sum of daily points.
- `vipNum` source and timing: assumed equal to VIP privilege 2 `para1`, granted with the daily login.
- MasterType 4 rows and drops exist but no UI tab shows them.

## 10. Implementation checklist

- [ ] Frame reachable from mini map, queue item 5 and login auto open
- [ ] Tables `daily_activity.activity_counter`, `activity_points`, `double_buff`
- [ ] Push 529 on login with all stages
- [ ] `record` hook wired into every TaskType owner (section 5 table)
- [ ] Daily cap `MaxDailyActivity`
- [ ] Route 9707 claim chest (daily and weekly), drop grant, flag string
- [ ] Route 9708 buy double, diamond debit, 7 day stop date
- [ ] Double reward by mail while buff active
- [ ] Daily and weekly reset jobs with push
- [ ] Test: chest index mapping per stage, claim twice refused, weekly claim without buff, cap clamp
