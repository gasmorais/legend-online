# Guild boss ("Terra dos Sonhos") and new guild boss ("Chefão da Guilda")

Area: guild PvE, module `boss`. Two independent features share this file:

- **A. Guild boss, "Terra dos Sonhos"** (code name `EmeDream`, Emerald Dream). The chairman spends guild wealth to summon a boss on the shared campaign map 7701. Members walk the map, collect fruits, kill monsters to weaken the boss, and fight it in battleType **309**. Templates: `ConsortiaBossTempInfos.xml` and `UpGradeTempInfos.xml` Types 42.
- **B. New guild boss, "Chefão da Guilda"** (code name `ConsortiaNewBoss`). A frame-only boss with up to 1000 difficulty levels and a shared HP pool. Each member has a limited number of attempts per round, fights in battleType **3901**, and earns a damage ranking and damage rewards. Templates: `ConsortiaNewBossTemplates.xml`, `ConsortiaNewBossReward.xml`, `ConsortiaNewBossDamageReward.xml`.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/` or `docs/`.
- `CM` = `core_module/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto fields come from `protocol/proto.json`; tags were checked against the AS3 `writeTo` where noted.
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet is involved; everything goes over the binary socket.

Related docs:
- `docs/battle/README.md`: battle opcodes 157/156/153/154/4103.
- `docs/battle/server-engine.md` §9: the `battle` rule object.
- `docs/battle/rules.md`: battleType table, rows 309 and 3901.
- `docs/battle/formation.md` §7.3: the dead EmeDream pet formation.
- `docs/world/README.md` §3.1: campaign map entry and node interaction.

---

## 1. Overview

### A. Terra dos Sonhos (old guild boss)

- **Unlock.** The activity row (id 3) in the guild activity list is enabled when guild level is 5 or more (`CM/mvc/module/consortia/ConsortiaViewHelper.as:249`). Below that it shows "Ativada quando a guilda atinge o nível {0}" with {0}=5 (`:267`). The constant `ConsortiaEmeDreamInfo.NEED_CONSORTIA_LEVEL = 5` exists (`CM/mvc/module/consortia/ConsortiaEmeDreamInfo.as:9`).
- **Manage (right holders).** Players holding guild right index 1 see the link "Invocar BOSS" (`:253-256`). It opens `ConsortiaEmeDreamFrame` through `openControllerByInfo("consortia",12)` (`:277-280`; `CM/mvc/controler/ConsortiaControler.as:261-264`). In that frame they:
  - pick a boss level from 1 up to the current boss grade (max 10);
  - **upgrade** the boss grade, spending guild "Pontos de combate" (spirit);
  - **summon** the boss once per day, spending guild wealth (offer).
- **View drops (everyone else).** Other members see "Ver drops", which opens `ConsortiaEmeDreamRewardFrame` (`:258-262, 272-275`).
- **Join.** The row's join button calls `gotoEmeDreamCampaign` (`:282-318`). It sends 8847 with upgradeType 2, and the server moves the player into campaign map **7701** "Terra dos Sonhos" (`raw/xml/tempinfos/Campaigns.xml` CampaignId 7701 Types 19 Capacity 10000; `MapInfos.xml` Id 7701 BattleGround 10).
- **On the map** (`WorldBossHelper.checkConsortiaEmeDream(mapId) == (mapId == 7701)`, `CM/yishi/utils/WorldBossHelper.as:285-288`):
  - players collect "Frutos do Sonho" (mission A), kill Taus (mission B) and Goblins (mission C), and fight the boss node in battle 309;
  - mission A removes the "Pesadelo" status, which otherwise drops HP to 1 at battle start;
  - missions B and C reduce the boss's physical and magical immunity (language keys `ConsortiaEmeDream.ConsortiaEmeDreamTaskItem.rewardTips0..2`).
- **Rewards.** Each player can be rewarded once per day: win reward if the boss dies, participation (lost) reward otherwise (help text `consortia.view.myConsortia.boss.ConsortiaEmeDreamFrame.helpTxt`).
- **Other entry points:**
  - task-trace tip type 60 `EmeDreamTipView` (button sends 8847/2, `m16/scripts/tasktracetip/view/EmeDreamTipView.as:47-52`), shown on push 516;
  - `ConsortiaEmeDreamTipView` exists but is not mapped by `TaskTraceTipManager`, so it is dead code.

### B. Chefão da Guilda (new guild boss)

- **Feature switch.** `VersionSwitch.CONSORTIA_NEW_BOSS = false` (`CM/yishi/datas/VersionSwitch.as:216`), so the activity row (id 0) is **not** added to the guild activity list in this build (`ConsortiaViewHelper.as:87-90`). The frame is still reachable from:
  - the daily guide entry 97, which needs player level 13 (`CM/managers/DayGuideManager.as:976-984`);
  - the chat link type 121 (`CM/chat/datas/ChatCellData.as:256-258` → `CM/chat/view/ChatOutputViewII.as:717-770`);
  - task-trace tip 61 (`m16/scripts/tasktracetip/view/ConsortiaNewBossTipView.as:54-108`; see the fall-through bug in §4);
  - the return from a 3901 battle (`m3/scripts/map/space/SpaceSceneController.as:438-441`, `m4/scripts/castle/CastleSceneView.as:323-326`).
- **Round lifecycle:**
  - the chairman or an authorized member calls a round at a chosen difficulty level (up to 3 rounds per week);
  - during the round (48 h) each member has a few challenge attempts, which refill at a daily time;
  - all members damage one shared HP pool;
  - finishing quickly unlocks higher levels ("skip");
  - the leader can buy one guild-wide BUFF with guild wealth.
- **Rewards.** At the end, participants get the win or fail reward of the level plus a damage-bracket reward, paid in item -18000 "Pontos de Chefão".

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `consortia.view.myConsortia.emedream.ConsortiaEmeDreamFrame` (`m6/scripts/consortia/view/myConsortia/emedream/ConsortiaEmeDreamFrame.as`) | "Terra dos Sonhos" (`consortia.view.myConsortia.activity.ConsortiaEmeDreamFrame.titleText`, :85) | Upgrade grade, summon boss at a level | Activity row id 3, link "Invocar BOSS", only with right index 1 (`ConsortiaViewHelper.as:253-256, 277-280`) | Level combo 1..min(grade,10) (:113-137); win/lost reward items of the selected level from `ConsortiaBossTempInfos` WinReward/LostReward (:277-332); tips with spirit cost to upgrade and wealth cost to call (:261-272, 334-358); description `...ConsortiaEmeDreamFrame.describeTxt`; help frame `consortia.ConsortiaEmeDreamHelperFrame` (:465-470, text key `consortia.view.myConsortia.boss.ConsortiaEmeDreamFrame.helpTxt`) |
| `yishi.view.frame.ConsortiaEmeDreamRewardFrame` (`CM/yishi/view/frame/ConsortiaEmeDreamRewardFrame.as`) | "Prêmios da Terra dos Sonhos" (`...consortiaEmeDreamReward.title`, :178) | Read-only drop preview | "Ver drops" link (`ConsortiaViewHelper.as:272-275` → `m6/.../newui/ConsortiaActivityView.as:53,104`); reward button on the map HUD (`m3/scripts/map/campaign/view/ui/emedream/EmeDreamTaskView.as:278-285`) | WinReward/LostReward of `callGrade` when a boss is active (state 1/2), else of `grade` (:107-157) |
| `map.campaign.view.ui.emedream.EmeDreamTaskView` (`m3/.../emedream/EmeDreamTaskView.as`), created by `EmeDreamUIMediator` (`m3/scripts/map/campaign/mediator/emedream/EmeDreamUIMediator.as:33`) | none (HUD) | In-map HUD on map 7701 | Automatic on map 7701 | Countdown: state 1 "Contagem regressiva para a abertura:" to endTime-1800; state 2 "Tempo de desafios restante" to endTime (:287-326); three `EmeDreamTaskItem` mission rows with progress {cur}/{max} (`EmeDreamTaskItem.as:54-79`); nightmare icon (nightmareState) and dream-buff icon (sleepState 1..3) (:247-276); hide-others toggle; reward button |
| `EmeDreamBufferView` (`m3/.../emedream/EmeDreamBufferView.as:43-71`) | none | Buff icons on the map | Map 7701 | `emeDreamInfo.BufferIds` CSV of buffer template ids |
| `WorldBossHeadInfoMediator` / `WorldBossInfoView` (`m3/scripts/map/campaign/mediator/mapview/WorldBossHeadInfoMediator.as:68-119`) | none | Boss head bar and damage list on the map | Map 7701: node with types 41/42 and `param1 == 3` (BOSS_TYPE) | Boss HP (4727), wound ranking (4174), boss buffs from BufferIds[0..1] (`CM/battle/view/buffer/BufferIconOnConsortiaEmeDreamBoss.as:30-54`) |
| `consortia.view.newboss.ConsortiaNewBossFrame` (`m6/scripts/consortia/view/newboss/ConsortiaNewBossFrame.as`) | image `asset.consortianewboss.titleImage` | Main new boss screen | `openControllerByInfo("consortianewboss",1)` (`CM/mvc/controler/ConsortiaNewBossControler.as:21-24`) | Boss name/icon/level/HP bar, remaining challenges, refresh time, countdown to stopTime, damage ranking list, my rank/damage, win/fail rewards of the level, damage reward tip, buff tip, "skip" hint (:358-598, 707-774) |
| `consortia.view.newboss.ConsortiaNewBossCallFrame` (`.../ConsortiaNewBossCallFrame.as`) | "Chefão da Guilda" (`consortia.view.myConsortia.activity.ConsortiaNewBossCallFrame.titleText`, :89) | Choose level and call a round | Open button of the main frame (:820-828); activity link (`ConsortiaViewHelper.as:477-480`) | Level combo 1..min(passLevel+1, maxLevel) (:263-290), boss name/icon of the level, win/fail rewards (:314-349), "Invocações restantes: {0}/{1}" (:348) |
| `consortia.view.newboss.NewBossDessFrame` (registered as `newboss.ConsortiaNewBossHelpFrame`, openType 3, `ConsortiaNewBossControler.as:29-32`) | "Sobre o besbloqueio de dificuldade" (`consorienewboss.skip.helpTitle`) | Explains the skip-unlock table | `_skipHelp` button (`ConsortiaNewBossFrame.as:904-907`) | Rows from config `consortia_newboss_time` and formula `7 + a*(n-1)` with `a = consortia_newboss_param` (`NewBossDessFrame.as:78-130`) |
| `view.subshop.ConsortiaNewBossBufferShopFrame` (`m15/scripts/view/subshop/ConsortiaNewBossBufferShopFrame.as`) | background `shop.ConsortiaNewBossBufferShopFrame.bg` | Buy the guild BUFF | Buff shop button (`ConsortiaNewBossFrame.as:854-862`, `openControllerByInfo("shop",99999)`) | 9 `GoodsItem13` from config `consortia_newboss_buff_shop` (`CM/mvc/controler/ShopControler.as:1657-1666`); guild wealth; "Compras disponíveis hoje: {0}/{1}" (:136-137); active buff with countdown (:178-201) |
| `consortianewboss.HelpFrame` (SimpleHelpFrame) | "Sobre o Chefão da Guilda" | Rules text | Help button (`ConsortiaNewBossFrame.as:897-902`) | `consortianewboss.HelpFrame.helpContent` |
| `tasktracetip.view.EmeDreamTipView` (`m16/...`) | "Mensagem" | Popup tip "A Terra dos Sonhos já foi ativada..." | Push 516 (`CM/yishi/manager/BaseManager.as:485-495`) | Button "skipNow" sends 8847/2 |
| `tasktracetip.view.ConsortiaNewBossTipView` (`m16/...`) | "Mensagem" | Popup "O Chefão da guilda atual foi aberto" | Push 4287 (but see bug in §4) | Button opens the main frame after the checks at :54-108 |

Dead UI: `ConsortiaEmeDreamPetFormationFrame`, `EmeDreamTeamView` / `EmeDreamSkillView` / `EmeDreamSkillSelectView`, and `ConsortiaEmeDreamTipView` are never instantiated (grep: no creator). They are not needed for the backend except for 8725 (§3, A6).

---

## 3. Actions

### A. Terra dos Sonhos

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response |
|---|---|---|---|---|---|
| A1 | Activity "join" button (row id 3) or tip button | `ConsortiaViewHelper.gotoEmeDreamCampaign` (`CM/mvc/module/consortia/ConsortiaViewHelper.as:282-318`) → `ConsortiaSocketOutManager.enterConsortiaBoss` (`CM/managers/ConsortiaSocketOutManager.as:322-328`) | 1. not in bot mode (`MopupManager.model.isMopup`): "Modo Bot em andamento"; 2. `emeDreamInfo.state` is 1 or 2, else "emeDreamPromptTxt{state}" ("A Terra dos Sonhos ainda não foi ativada." / "...já terminou."); 3. `SwitchPageHelp.checkScene()`; 4. if `playerInfo.consortiaBossCount >= 1`, confirm dialog "Já obteve todos os ganhos de hoje. Confirma que deseja continuar?" (`emeDreamPromptTxt4`, :305-313) | send **8847 (0x228f) C_CONSORTIA_BOSS_CALL**, `ConsortiaMsg{upgradeType(#5,INT32)=2}` | Campaign entry on map 7701 *(assumption, generic campaign flow `docs/world/README.md` §3.1)*: **125 (0x007d) U_C_CAMPAIGN_CREATE** (RoomCreatedMsg, map 7701), then **21 (0x0015) U_C_CAMPAIGN_ENTER**, **127 (0x007f) U_C_CAMPAIGN_NODE**, then 4728, 4729, 4861, 4726, 4727, 4174 snapshots |
| A2 | Tip button (type 60) | `EmeDreamTipView.__btnHandler` (`m16/scripts/tasktracetip/view/EmeDreamTipView.as:47-52`) | none | same 8847 `{upgradeType=2}` | same as A1 |
| A3 | "Invocar" button in `ConsortiaEmeDreamFrame` | `ConsortiaEmeDreamFrame.__callClickHandler` (`m6/.../emedream/ConsortiaEmeDreamFrame.as:403-452`) → `ConsortiaSocketOutManager.callConsortiaBoss(level)` (`CM/managers/ConsortiaSocketOutManager.as:330-337`) | 1. local time 23:20-23:59 (`checkTime`, :388-396): "Os dados estão sendo resetados."; 2. bot mode; 3. `state != 0`: "emeDreamPromptTxt{state}"; 4. `consortiaInfo.offer < UpGrade(Types 42, Grades=level).TemplateId` → `ConsortiaSkillHelper.addWealth()` (wealth shortage flow, economy area) (:442-446); 5. `WorldBossHelper.getCampaignTips()` must be empty (:454-463) | send **8847 (0x228f)**, `ConsortiaMsg{upgradeType(#5)=1, otherId(#3)=level}`. Level is 1..min(grade,10) | Push **4728 (0x1278)** `ConsortiaInfoMsg.bossInfo` with state 1 to all online members; **516 (0x0204)** tip to all online members *(assumption)*; guild wealth refresh via the core guild info push 164/4138 *(assumption, core area)* |
| A4 | "Elevar" (upgrade) button | `ConsortiaEmeDreamFrame.__upClickHandler` (:360-386) → `ConsortiaSocketOutManager.upgradeConsortiaBoss` (`CM/managers/ConsortiaSocketOutManager.as:339-343`) | 1. `grade >= 10`: "O chefão da guilda já atingiu o nível máximo."; 2. `spirit < UpGrade(Types 42, Grades=grade+1).Data`: "Pontos de Combate da Guilda insuficientes." The button is enabled only when the selected combo level == grade (:253-260) | send **8846 (0x228e) C_CONSORTIA_BOSS_UPGRADE**, empty body (`sendProtoBuffer(pkg,null)`) | Push **4728** with new grade and spirit to all online members *(assumption)*; the frame refreshes on `UPDA_CONSORTIA_INFO` (:209, 334-358) |
| A5 | Collect a fruit node on map 7701 | `CollectionAction.sendCollection` (`CM/yishi/actions/map/collection/CollectionAction.as:434-467`) → `SocketSendManager.sendSessionOverToBattle(mapId,nodeId,2)` (`CM/yishi/service/managers/SocketSendManager.as:363-371`) | generic collection (campaign area) | send **5032 (0x13a8) U_C_CAMPAIGN_CALLBACK**, `CallBackReqMsg{mapId(#1)=7701, nodeId(#2), cmd(#3)=2}` | **4729** mission progress push to map players; **4861** sleep buff to the collector, rolled at random (help text item 4); mission A item drops with chance `consortia_boss_mission_a_drop_rate`=50 % *(assumption: per collection)* |
| A6 | Attack boss/elite/normal node on map | `MapSocketOuterManager.sendCampaignArrive(campDataId, ...)` (`m3/scripts/map/net/MapSocketOuterManager.as:55-62`), from `CampaignArmyViewHelper` (`docs/world/README.md` §3.1, "Terra dos Sonhos → 5125") | generic node interaction | send **5125 (0x1405) U_C_CAMPAIGN_ARRIVE**, `CampaignReqMsg{paraInt1(#1)=campDataId, paraBool1(#7)}` | Battle: **157** U_B_PREPARE with battle_type **309**, map_temp_id 7701, then the normal battle sequence (156, 153..., 154, 4103) |
| A7 | (dead UI) EmeDream pet formation | `ConsortiaSocketOutManager.sendPetFormation` (`CM/managers/ConsortiaSocketOutManager.as:345-352`) | none | send **8725 (0x2215) C_PET_CHALLENGE_FORMATION**, `PlayerPetMsg{consortiaPos(#13,STRING), operateType(#8)=3}` | **4540 (0x11bc) U_C_PLAYER_PETINFO** stores `petConsortiaBossFormation` (`CM/yishi/manager/PlayerManager.as:1504`). Owned by the pets area. Implement only if a creator is added |
| A8 | Help, combo, "Ver drops" | client only | none | none | none |

### B. Chefão da Guilda

All requests are **8670 (0x21de) C_CONSORTIA_NEWBOSS_CLIENT_OP** with `com.road.yishi.proto.player.PlayerOpMsg`. Only two fields are ever set: `op (#1, INT32)` and `id (#5, INT32)`. The op constants are at `CM/yishi/manager/ConsortiaNewBossManager.as:24-32`: 1 OPEN_FRAME, 2 CLOSE_FRAME, 3 CALL_BOSS, 4 FIGHT_BOSS, 5 BUY_BUFFER.

| # | UI control | Client sender (file:line) | Client checks, in order | Request body | Expected response |
|---|---|---|---|---|---|
| B1 | Main frame opens | `ConsortiaNewBossFrame()` constructor (`m6/.../newboss/ConsortiaNewBossFrame.as:164-171`) → `ConsortiaNewBossManager.openFrame` (`CM/yishi/manager/ConsortiaNewBossManager.as:133-139`) | none | `{op=1}` | **4283** boss info, **4284** rank list, **4286** user info *(assumption on order; the frame redraws on each)* |
| B2 | Main frame closes | `ConsortiaNewBossFrame.dispose` (:914-921) → `closeFrame` (`ConsortiaNewBossManager.as:141-147`) | none | `{op=2}` | none (unsubscribe) |
| B3 | "Invocar" in `ConsortiaNewBossCallFrame` | `ConsortiaNewBossCallFrame.__callClickHandler` (`m6/.../newboss/ConsortiaNewBossCallFrame.as:210-240`) → `callBOSS(level)` (`ConsortiaNewBossManager.as:149-156`) | 1. `checkTime()` always false (:351-354); 2. bot mode; 3. needs right index 1 **or** duty right 41 (`getRightsByNum(41)`, `CM/mvc/controler/ConsortiaControler.as:568-590`), else "Apenas o presidente e membros autorizados podem invocar"; 4. `WorldBossHelper.getCampaignTips()` empty; 5. a template exists for the level. The client does **not** check remaining calls or an active round | `{op=3, id(#5)=level}`, level in 1..min(passLevel+1, maxLevel) | **4283** (new bossId, hp, maxHp, start/stop, callCount+1) to all online members; **4287** tip to all online members *(assumption)*. The client immediately reopens the main frame (:238) |
| B4 | Main frame "Abrir" / not-open button | `__openBtnHandler` (`ConsortiaNewBossFrame.as:820-828`) | `consortiaID != 0`, else "Você não está nesta guilda no momento, ação impossível." | none (opens call frame) | none |
| B5 | "Desafiar" (battle) button | `__battleBtnHandler` (:830-838) → `fightBOSS` (`ConsortiaNewBossManager.as:158-164`) | `consortiaID != 0`. The button is visible only while `bossId>0 && !isOver()` (:418-424). The client does **not** check `fightCount < maxFightCount` | `{op=4}` | Battle **157** with battle_type **3901**, then 156/153.../154/4103. After the battle: **4283** (new hp) to all online members, **4284** to subscribers, **4286** to the fighter. On return the client reopens the main frame (`SpaceSceneController.as:438-441`) |
| B6 | Buy buff item in buff shop | `GoodsItem13.__clickHandler` (`m15/scripts/view/GoodsItem13.as:114-127`) → `buyBuffer(skillId)` (`ConsortiaNewBossManager.as:166-173`) | 1. `consortiaInfo.offer < price` (price from config): "Fortuna da guilda insuficiente para comprar buffers"; 2. `getBufferCount() <= bufferBuyCount` (config `consortia_newboss_buff_count`=6): "Já comprou todas as vezes possíveis." No rank check on the client | `{op=5, id(#5)=skillId}`, skillId in 84001001..84001005 | **4283** with `buff`, `buffStartTime`, `buffStopTime`, `buffBuyCount` to all online members; guild wealth refresh (core push) *(assumption)* |
| B7 | Boss shop button (main frame or activity row shop button) | `__bossShopBtnHandler` (:864-890); `ConsortiaActivityItem._shopBtnClickHandler` (`m6/.../item/ConsortiaActivityItem.as:119-144`) | `consortiaID != 0` | none, opens the guild shop tab (`openControllerByInfo("shop",2,{type:...})`; economy area) | none |
| B8 | Help, skip help, rank list scroll | client only | none | none | none |

---

## 4. Server messages

All server messages are pushes. None carries a request id.

### A. Terra dos Sonhos

| Opcode | Name | Message, fields (tag, type) | Client handler (file:line) | When to send | Client effect |
|---|---|---|---|---|---|
| 4728 (0x1278) | U_C_CONSORTIA_BOSS_START | `consortia.ConsortiaInfoMsg`, only `bossInfo (#65, ConsortiaBossMsg)` is read. ConsortiaBossMsg: `grade (#1, INT32)` boss grade 1..10; `spirit (#2, INT64)` guild combat points; `state (#3, INT32)` 0 not active, 1 summoned or waiting, 2 fighting, 3 ended; `end_time (#4, STRING "YYYY-MM-DD hh:mm:ss")` fight end; `total_hp (#5, INT64)` boss max HP; `call_grade (#6, INT32)` summoned level. Tags verified in `CM/com/road/yishi/proto/consortia/ConsortiaBossMsg.as:164-189` | `ConsortiaManager.__emeDreamStateHandler` (`CM/yishi/manager/ConsortiaManager.as:177, 228-255`) | Push to all online guild members on summon, on state change (1→2, 2→3, 3→0 at reset), on upgrade, on spirit change *(assumption)* | Updates `emeDreamInfo`; when on map 7701, sets `worldBossModel.totalHp`; state 1/2 marks the activity effect (`openEffectDic[5]`), else clears BufferIds; fires `CampaignEvent.CONSORTIA_BOSS_SWITCH` (refreshes frame, HUD title) |
| 164 (0x00a4) / 4138 (0x102a) | U_CH_CONSORTIA_FRESHINFO / U_C_CONSORTIA_INFO | `ConsortiaInfoMsg` (core area); its `bossInfo (#65)` fills the same fields | `ConsortiaManager.__refreshConsortiaInfo` (`ConsortiaManager.as:157-158, 457-482`) | Login and guild info refresh (core area) | Same as 4728 without the events. The core module must include `boss_info` |
| 516 (0x0204) | U_CANSORTIA_BOSS_STATE | `simple.PropertyMsg`, body ignored | `BaseManager.__emeDreamInfoTipsHandler` (`CM/yishi/manager/BaseManager.as:349, 485-495`) | Push to online members when the boss is summoned *(assumption)* | Shows tip type 60 `EmeDreamTipView` ("A Terra dos Sonhos já foi ativada. Incentivamos a participação dos membros da guilda!") |
| 4863 (0x12ff) | U_C_CONSORTIA_BOSS_COUNT | `simple.PropertyMsg{param1 (#1, INT32)}` = times the player was rewarded today | `BaseManager.__consortiaBossCountHandler` (`BaseManager.as:346, 610-616`) | Login and after each reward | `playerInfo.consortiaBossCount`; at 1 or more the join confirm dialog appears (`ConsortiaViewHelper.as:305`) |
| 4726 (0x1276) | U_C_CONSORTIA_BOSS_SKILLINFO | `simple.PropertyMsg{param4 (#4, STRING)}` = CSV of `SkillBufferTempInfos` ids. Indices 0 and 1 are the boss buffs shown on the map head bar; indices 2 and up are the player buffs shown in battle 309 (`m10/scripts/battle/view/ui/SelfBufferView.as:45-63`) | `ConsortiaManager.__emeDreamRefreshBuffer` (`ConsortiaManager.as:179, 219-226`) | On map enter and whenever buffs change *(assumption)* | Stores BufferIds; fires `ConsortiaEvent.CONSORTIA_BOSS_BUFFERIDS` (map buff views) |
| 4729 (0x1279) | U_C_CONSORTIA_BOSS_STATE | `consortia.ConsortiaBossStateMsg`: `mission_a_process (#1, INT32)`, `mission_b_process (#2)`, `mission_c_process (#3)` guild progress of missions A/B/C; `playerList (#4, ConsortiaBossPlayerMsg, repeated)` with `userid (#1)`, `collect_count (#2)`, `mission_item_count (#3)` (**not read by the client**); `mission_a_skill_id (#5)`, `mission_b_skill_id (#6)`, `mission_c_skill_id (#7)`. Tags verified at `ConsortiaBossStateMsg.as:170-202` | `CampaignSocketManger.__emeDreamStateUpdateHandler` (`m3/scripts/map/campaign/CampaignSocketManger.as:390, 838-847`) | Push to players on map 7701 on enter and after each mission progress | Fills `taskProcessArr` and `taskSkillIdProcessArr`; HUD rows show `{cur}/{max}`, with max from ATotal/BTotal/CTotal (`ConsortiaEmeDreamInfo.as:71-78`) |
| 4861 (0x12fd) | U_C_CONSORTIA_BOSS_BUFF | `simple.PropertyMsg{param1 (#1) = nightmareState (0 removed, else active), param2 (#2) = sleepState (0 none, 1 attack x2, 2 defense x2, 3 drops x2)}` (texts `ConsortiaEmeDreamTaskView.propImage.tipdata1..3`) | `CampaignSocketManger.__emeDreamBuffUpdateHandler` (:391, 849-858) | Per player, on map enter and on change | HUD icons (`EmeDreamTaskView.as:256-275`) |
| 4862 (0x12fe) | U_C_CONSORTIA_BOSS_TRAP | `simple.PropertyMsg{param4 (#4, STRING) CSV of userIds stunned (state 0), param5 (#5, STRING) CSV of userIds released (state 1)}`. Buff id 5 (`TRAP_STUN_BUFF_ID`), duration 65 s (`TRAP_STUN_TIME`, `ConsortiaEmeDreamInfo.as:17-19`; used at `m3/scripts/map/campaign/action/ConsortiaEmeDreamArmyDannyAction.as:215`) | `CampaignSocketManger.__emeDreamBuffTrapHandler` (:392, 860-915) | Push to map 7701 players when a trap fires *(the trigger is server-side and unknown)* | Applies a stun buff on the listed armies (`CampaignArmy.updateBuffEmeDream`, `CM/map/campaign/data/CampaignArmy.as:1025`) |
| 4727 (0x1277) | U_C_CONSORTIA_BOSS_SYNC_HP | `simple.WorldBossInfoMsg`: map handler reads `cur_hp (#1, INT64)` and `total_hp (#5, INT64)`; battle handler reads `cur_hp`, `total_hp`, `current_millis (#8, INT64)` and `boss_state (#12, INT32)` | Map: `CampaignSocketManger.__consortiaEmeDreamBossHpHandler` (:383, 1384-1396), ignored unless map 7701. Battle: `RoleShowViewII.__syncBossHpHandler` (`m10/scripts/battle/view/ui/RoleShowViewII.as:222, 264-286`) | Push to map 7701 players after each boss damage | Map boss bar. In battle 309 it has **no effect**, because `BattleModel.getWorldBoss()` returns null for 309 (`CM/yishi/datas/BattleModel.as:861-866`) |
| 4174 (0x104e) | U_C_SYNC_BOSS_HP (generic world boss) | `simple.WorldBossInfoMsg`: `cur_hp (#1)`, `total_num (#2)`, `campaign_id (#3)` must be 7701, `woundInfo (#4, repeated WoundInfoMsg{user_id #1, nick_name #2, wound #3 INT64, woundAddation #4, job #5})`, `total_hp (#5)`, `my_wound (#6)`, `grades (#7)`, `buffer_grade (#10)`, `boss_state (#12)` | `CampaignSocketManger.__syncBossHpHandler` (:347, 1398-1444) | Push to map players for the damage ranking *(assumption: the generic world boss sync is reused for 7701)* | Damage ranking list in `WorldBossHeadInfoMediator` |
| 125, 21, 127, 22 | campaign create, enter, nodes, exit | generic campaign messages (`docs/world/README.md` §3.1) | `CampaignManager` / `CampaignSocketManger` | Enter or leave map 7701 | Nodes carry `param1` 1 normal, 2 elite, 3 boss (`ConsortiaEmeDreamInfo.as:11-15`; `WorldBossHeadInfoMediator.as:80`); boss node types 41/42 |
| 157, 156, 153, 154, 4103 | battle | `docs/battle/README.md` | battle module | Battle 309 | Boss level shown = `emeDreamInfo.callGrade` (`CM/battle/view/ui/top/BossInfoView.as:224-227, 255-268`); exit to `CAMPAIGN_MAP_SCENE` (preScene) |

While the player is in battle, packets 4727, 4729, 4861 and 4862 are buffered by `CampaignSocketDataProxy` and replayed on return (`CM/proxy/scene/CampaignSocketDataProxy.as:62-94`, `BaseSceneSocketDataProxy.as:25-28`).

### B. Chefão da Guilda

| Opcode | Name | Message, fields (tag, type) | Client handler (file:line) | When to send | Client effect |
|---|---|---|---|---|---|
| 4283 (0x10bb) | U_C_CONSORTIA_NEWBOSS_DATA | `consortia.ConsortiaNewBossMsg`, see the field list below | `ConsortiaNewBossManager.__bossInfo` (`CM/yishi/manager/ConsortiaNewBossManager.as:58, 63-87`) | Response to op 1; push to all online members after call, each fight, buff buy, round end and weekly reset | Updates model; fires `CONSORTIA_NEW_BOSS_INFO_UPDATE` (frame `refreshView`, buff shop) |
| 4284 (0x10bc) | U_C_CONSORTIA_NEWBOSS_RANK | `consortia.ConsortiaNewBossRankListMsg{ranks (#1, ConsortiaNewBossRankMsg, repeated)}`; ConsortiaNewBossRankMsg: `rank (#1, INT32)`, `userid (#2, INT32)` (unused), `nick_name (#3, STRING)`, `damage (#4, INT64)` | `__rankInfo` (:59, 89-107) | Response to op 1; push to subscribers after each fight | Replaces `rankArray`, sorted by rank; ranks 1-3 show medals (`m6/.../item/ConsortiaNewBossRankItem.as:46-72`) |
| 4286 (0x10be) | U_C_CONSORTIA_NEWBOSS_USER | `consortia.ConsortiaNewBossUserMsg`: `fight_count (#1, INT32)` attempts used; `fight_max_count (#2, INT32)` attempts allowed; `rank (#3, INT32)` my rank (above 100 shows "Sem rank"); `damage (#4, INT64)` my damage this round | `__userInfo` (:60, 118-131) | Response to op 1; push to the player after each fight and at the daily refresh | "Desafios restantes: {max-used}/{max}", my rank and damage (`ConsortiaNewBossFrame.as:458, 471-479`) |
| 4285 (0x10bd) | U_C_CONSORTIA_NEWBOSS_HP | `simple.WorldBossInfoMsg` (`cur_hp #1`, `total_hp #5`, `current_millis #8`, `boss_state #12`) | `RoleShowViewII.__syncBossHpHandler` (`m10/.../RoleShowViewII.as:226, 264-286`); buffered on campaign maps (`CampaignSocketDataProxy.as:94`) | Optional during battle 3901 | **No effect** in 3901 (`getWorldBoss` is null for 3901, `BattleModel.as:864`). Safe to skip |
| 4287 (0x10bf) | U_C_CONSORTIA_NEWBOSS_STATE | `simple.PropertyMsg`, body ignored | `BaseManager._consortiaNewBossInfoTipsHandler` (`BaseManager.as:353, 502-512`) | Push to online members when a round starts *(assumption)* | Shows tip type 61. **Bug:** `TaskTraceTipManager` case 61 has no `break` and falls through to case 62, so the view loaded is `ConsortiaTreeTipView`, not `ConsortiaNewBossTipView` (`CM/managers/TaskTraceTipManager.as:881-884`). The server only needs to send it |
| 157, 156, 153, 154, 4103 | battle | `docs/battle/README.md` | battle module | Battle 3901 | On exit, `BattleResultHandler` sets `isConsortiaNewBossBattle` (`CM/battle/handler/BattleResultHandler.as:485-488`), and the space or castle scene reopens the main frame |

`ConsortiaNewBossMsg` fields (`protocol/proto.json`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| pass_level | 1 | INT32 | highest level passed or unlocked |
| max_level | 2 | INT32 | level cap, 1000 *(assumption)* |
| call_level | 3 | INT32 | level of the current or last round |
| call_count | 4 | INT32 | rounds called this week |
| call_max_count | 5 | INT32 | weekly round cap, config `consortia_newboss_maxrounds_week`=3 |
| boss_id | 6 | INT32 | GameHeroTemp id of the boss, 0 = no round. The frame shows the name, or "Desconhecido" when `passLevel==0 && callCount==0` |
| buff | 7 | INT32 | active buff skill id, 0 = none |
| buff_start_time | 8 | STRING | "YYYY-MM-DD hh:mm:ss"; parsed by `DateFormatter.parse`, so it must always be a valid date |
| buff_stop_time | 9 | STRING | same format; must always be valid |
| start_time | 10 | STRING | round start; must always be valid, because `isOver()` and the skip timer read it |
| stop_time | 11 | STRING | round end; must always be valid |
| buff_buy_count | 12 | INT32 | buffs bought today |
| best_count | 13 | INT32 | consecutive fastest clears, used by the skip formula |
| hp | 14 | INT64 | current boss HP |
| max_hp | 15 | INT64 | boss max HP |

There are no explicit result or error codes in this module. All failures are blocked client-side, as listed in the action tables. For a server-side rejection no dedicated opcode exists. The server should send nothing, or use the generic **126 (0x007e) U_C_MSG** `CampaignNotifyMsg` (`CM/yishi/manager/BaseManager.as:299, 2070-2085`; core area) *(assumption)*.

---

## 5. Rules and formulas

### A. Terra dos Sonhos

| Rule | Value | Source |
|---|---|---|
| Guild level to unlock | 5 or more | `ConsortiaViewHelper.as:249`; `ConsortiaEmeDreamInfo.as:9` |
| Who can summon or upgrade | right index 1 (`usrRights` bit 0; the same bit gates guild transfer, `m6/.../ConsortiaStaffPage.as:142-147`). The help text says "presidente" | `ConsortiaViewHelper.as:253` |
| Boss grade | 1..10; upgrade cost = `UpGradeTempInfos` Types 42, row Grades = grade+1, field **Data** (spirit): 0, 3 600 000, 9 900 000, 21 600 000, 40 500 000, 68 400 000, 107 100 000, 158 400 000, 224 100 000, 306 000 000 | `ConsortiaEmeDreamFrame.as:360-386`; `raw/xml/tempinfos/UpGradeTempInfos.xml` Id 42001-42010 |
| Summon cost | guild wealth (`consortiaInfo.offer`) = Types 42 row Grades = chosen level, field **TemplateId**: 20 000 × level (20 000..200 000) | `ConsortiaEmeDreamFrame.as:261-272, 428-446` |
| Summon level | 1..min(grade, 10) | `:113-137` |
| Summons per day | 1 (help text item 1). The client only checks `state == 0` | `...helpTxt` |
| Blackout | no summon from 23:20 to 23:59 server clock (`playerModel.sysCurtime`); daily reset at midnight | `:388-396`; help text item 8 |
| States | 0 none, 1 summoned (countdown to `endTime - 1800`), 2 fighting until `endTime`, 3 ended | `EmeDreamTaskView.as:287-326`; prompt texts `emeDreamPromptTxt0..3` |
| Fight phase length | 1800 s (end_time - 1800 = fight start) | `EmeDreamTaskView.as:305-312` |
| Preparation phase length | unknown; the language key `yishi.manager.ConsortiaManager.consortiaEmeDream.open` says "...o combate será iniciado em {1} minutos" (no client user) | open question |
| Rewards per player per day | 1 (any guild) (help item 1). The counter is pushed by 4863 | help text; `BaseManager.as:610-616` |
| Win reward | `ConsortiaBossTempInfos.WinReward` of call_grade, e.g. level 1 `-1400,800\|2060802,1` ("Dente do Terror" x800 + "Baú dos Sonhos" x1) | `ConsortiaEmeDreamRewardFrame.as:109-157` |
| Participation reward | `LostReward` of call_grade (`-1400,200` .. `-1400,650`) when the boss survives the fight phase (help item 7) | same |
| Boss HP and attack scaling | `HpPercent` 200..2000 and `AttackPercent` 100..900 per level, server only *(assumption: percent of the base boss template)* | template |
| Missions | A collect "Frutos do Sonho" (target ATotal=10), B kill Taus (BTotal=10), C kill Goblins (CTotal=10). A removes nightmare; B and C reduce boss physical or magical immunity from 100% | `ConsortiaEmeDreamInfo.as:71-78`; `rewardTips0..2` |
| Nightmare | while active, player HP drops to 1 at battle start (help item 2; `ConsortiaEmeDreamTaskView.collectImage.tipdata`) | server battle setup |
| Dream buffs (sleepState) | 1 attack x2, 2 defense x2 (both add +30 s revive wait and end on re-revive), 3 drops x2 (ends after a won battle) | `ConsortiaEmeDreamTaskView.propImage.tipdata1..3` |
| Mission A drop rate | 50 % (`consortia_boss_mission_a_drop_rate`) | `ConfigInfos.xml` |
| Trap stun | buff id 5 for 65 s | `ConsortiaEmeDreamInfo.as:17-19` |
| Spirit source | guild "Pontos de combate" shown in `ConsortiaInfoView` (`ConsortiaInfoView.warthText.text`) and `ConsortiaContributeFrame` (:175, 478); earned through contribution (economy area) | cross-area |

### B. Chefão da Guilda

| Rule | Value | Source |
|---|---|---|
| Who can call | right index 1 or duty right 41 | `ConsortiaNewBossCallFrame.as:225-232` |
| Rounds per week | `consortia_newboss_maxrounds_week` = 3 (`call_max_count`) | ConfigInfos; frame text "Invocações restantes" |
| Weekly reset | Monday 00:00; unfinished rounds reset (help item 7) | `consortianewboss.HelpFrame.helpContent` |
| Round duration | `consortia_newboss_rounds_times` = 2880 min (48 h): stop_time = start_time + 2880 min *(assumption: the server computes stop_time)* | ConfigInfos |
| Attempts per round | `consortia_newboss_rounds_maxchallenges` = 3 (`fight_max_count`) | ConfigInfos |
| Attempt refill | daily at `consortia_newboss_challenges_refreshtime` = "12:00:00" (the client fallback list is 12:00, 16:00, 20:00) | `CM/yishi/datas/ConfigInfoManager.as:1728-1735`; `ConsortiaNewBossFrame.as:609-705` |
| Selectable level | 1..min(pass_level+1, max_level) | `ConsortiaNewBossCallFrame.as:263-290` |
| Boss of a level | `ConsortiaNewBossTemplates` row Level: `BossId = "<GameHeroTemp id>,<pos>"` (pos always 5), `HpMultiple` 3100..53000 | `ConsortiaNewBossFrame.as:547-558`; template |
| Skip unlock | `consortia_newboss_time` = "45,7\|90,6\|180,5\|360,4\|720,3\|1440,2": killing the boss within T minutes of start_time unlocks up to `call_level + V` levels. In the first window (45 min), if `best_count+1 >= 2`, V = 7 + a·(best_count) with a = `consortia_newboss_param` = 1. Capped at max_level. Hidden when call_level >= 1000 or call_level <= pass_level | `ConsortiaNewBossFrame.as:358-413`; `NewBossDessFrame.as:78-130` |
| Round rewards | win (para2=1) or fail (para2=2) rows of `ConsortiaNewBossReward` where site = call_level; all in item -18000 "Pontos de Chefão". Every 100th level adds a title card 6280001..6280010 | `ConsortiaNewBossFrame.as:731-774`; template |
| Damage rewards | `ConsortiaNewBossDamageReward` rows where site = call_level and damage in [para2 min, para2 max]: 5 brackets 1-2M, 2M-10M, 10M-50M, 50M-100M, 100M+; item -18000 | `CM/yishi/datas/templates/cate/ConsortiaNewBossDamageRewardTempCate.as:8-21` |
| Reward eligibility | participants only; members who left the guild get nothing; at most 3 rounds of rewards per week (help items 4, 6) | help text |
| Guild buff | 5 skills from `consortia_newboss_buff_shop` "84001001,50000\|...\|84001005,50000" (skill id, guild wealth). Lasts `consortia_newboss_buff_times` = 3600 s. At most `consortia_newboss_buff_count` = 6 buys per day. Only one active buff; a new buy replaces it *(assumption)*; applies to all members | `ConfigInfoManager.as:1719-1745`; `GoodsItem13.as:114-201`; `ConsortiaNewBossBufferShopFrame.desc` |
| Round over | `now > stop_time` (`ConsortiaNewBossModel.isOver`, `CM/mvc/module/consortia/ConsortiaNewBossModel.as:67-81`). A killed boss (hp 0) also ends the round *(assumption)* | |
| Rank display | my rank above 100 shows "Sem rank" | `ConsortiaNewBossFrame.as:471-479` |

---

## 6. Templates

| File | Record | Fields used (client) | Fields for the server |
|---|---|---|---|
| `raw/xml/tempinfos/ConsortiaBossTempInfos.xml` (10 rows, `ConsortiaBossTemplateCate.getTemplateByLevel`, `CM/yishi/datas/templates/cate/ConsortiaBossTemplateCate.as:8-15`, loaded at `CM/yishi/manager/TempleteManager.as:1215`) | one boss level | `Level`; `WinReward`/`LostReward` as `itemId,count\|...`; `ATotal`/`BTotal`/`CTotal` mission targets (`ConsortiaEmeDreamInfo.as:71-78`) | `HpPercent`, `AttackPercent` boss scaling; `ASection`/`BSection`/`CSection` (=1, meaning unknown, maybe the progress step) |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 42 (Id 42001-42010) | boss grade economics | `Grades`; `TemplateId` = wealth cost to summon at that level; `Data` = spirit cost to reach that grade | `TemplateName` = "20071,60483\|20072,60484\|...\|20076,60488" (6 pairs, ids 6048x are SkillTempInfos "Estado1"...; meaning unknown, possibly buffs per state) |
| `raw/xml/tempinfos/ConsortiaNewBossTemplates.xml` (1000 rows, Level 1..1000, `TempleteManager.as:1347`) | new boss level | `Level`, `BossId` (GameHeroTemp id, then pos 5), `Id` | `HpMultiple` (3100 at level 1, +100 per 2 levels, 53000 at 1000). Boss max HP formula unknown *(assumption: GameHeroTemp.Live × HpMultiple / 100)* |
| `raw/xml/tempinfos/ConsortiaNewBossReward.xml` (2010 rows, `ConsortiaNewBossRankRewardTempCate.getTemplatesByTypeAndRank(site, para2)` :8-14) | round reward | `site` = level 1..1000, `para2` 1 win / 2 fail, `itemId`, `count`, `id` sort | `dropId`, `isBind`, `appearType`, `validDate`, `isShow` |
| `raw/xml/tempinfos/ConsortiaNewBossDamageReward.xml` (5000 rows) | damage bracket reward | `site` = level, `para2` = "min,max" damage, `itemId` (-18000), `count` | same extra fields |
| `raw/xml/tempinfos/ConfigInfos.xml` | config | `consortia_newboss_time`, `consortia_newboss_param`, `consortia_newboss_challenges_refreshtime`, `consortia_newboss_buff_shop`, `consortia_newboss_buff_times`, `consortia_newboss_buff_count` | plus `consortia_newboss_maxrounds_week`, `consortia_newboss_rounds_times`, `consortia_newboss_rounds_maxchallenges`, `consortia_boss_mission_a_drop_rate`; `consortia_newboss_reward_preview` is marked obsolete |
| `raw/xml/tempinfos/Campaigns.xml` 7701, `MapInfos.xml` 7701 | boss map | `MapInfos.BattleGround`=10 gives the battle background for map_temp_id 7701 (`CM/battle/transaction/CreateGameTransaction.as:110-117`) | node layout is **not** in assets (`raw/maps/7701/7701.XML` is `<campaign/>`) and must be server-defined |
| `GameHeroTemp.xml`, `HeroAis.xml` | boss units | name, icon (`gameHeroTemplateCate`) | stats, AI, ResPath for the battle (e.g. 5000001 "Lobo Maligno", Live 18 000 000, AI 5000001) |
| `ItemTempInfos.xml` | currencies | -1400 "Dente do Terror", -18000 "Pontos de Chefão", 2060802 "Baú dos Sonhos", 6280001.. title cards | |

---

## 7. Persistent state (PostgreSQL, schema `guild`)

```sql
CREATE TABLE guild.dream_boss (
  guild_id            integer PRIMARY KEY REFERENCES guild.guilds(id) ON DELETE CASCADE,
  grade               smallint NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 10),
  state               smallint NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 3),
  call_grade          smallint NOT NULL DEFAULT 0 CHECK (call_grade BETWEEN 0 AND 10),
  called_by           integer REFERENCES game.players(id),
  called_at           timestamptz,
  fight_start_at      timestamptz,
  end_at              timestamptz,
  last_call_day       date,
  total_hp            bigint NOT NULL DEFAULT 0,
  cur_hp              bigint NOT NULL DEFAULT 0,
  mission_a_progress  integer NOT NULL DEFAULT 0,
  mission_b_progress  integer NOT NULL DEFAULT 0,
  mission_c_progress  integer NOT NULL DEFAULT 0,
  mission_a_skill_id  integer NOT NULL DEFAULT 0,
  mission_b_skill_id  integer NOT NULL DEFAULT 0,
  mission_c_skill_id  integer NOT NULL DEFAULT 0,
  nightmare_active    boolean NOT NULL DEFAULT true,
  boss_buffer_ids     text NOT NULL DEFAULT ''
);
-- spirit (guild combat points) lives on guild.guilds.combat_points (economy area); read and debited here.

CREATE TABLE guild.dream_boss_damage (
  guild_id   integer NOT NULL REFERENCES guild.guilds(id) ON DELETE CASCADE,
  run_day    date    NOT NULL,
  player_id  integer NOT NULL REFERENCES game.players(id),
  damage     bigint  NOT NULL DEFAULT 0 CHECK (damage >= 0),
  PRIMARY KEY (guild_id, run_day, player_id)
);
CREATE INDEX dream_boss_damage_rank ON guild.dream_boss_damage (guild_id, run_day, damage DESC);

CREATE TABLE guild.dream_boss_player_day (
  player_id           integer NOT NULL REFERENCES game.players(id),
  day                 date    NOT NULL,
  reward_count        smallint NOT NULL DEFAULT 0 CHECK (reward_count >= 0),
  sleep_state         smallint NOT NULL DEFAULT 0 CHECK (sleep_state BETWEEN 0 AND 3),
  collect_count       integer NOT NULL DEFAULT 0,
  mission_item_count  integer NOT NULL DEFAULT 0,
  stunned_until       timestamptz,
  PRIMARY KEY (player_id, day)
);

CREATE TABLE guild.new_boss (
  guild_id         integer PRIMARY KEY REFERENCES guild.guilds(id) ON DELETE CASCADE,
  week_start       date     NOT NULL,
  pass_level       integer  NOT NULL DEFAULT 0 CHECK (pass_level BETWEEN 0 AND 1000),
  max_level        integer  NOT NULL DEFAULT 1000,
  best_count       integer  NOT NULL DEFAULT 0,
  call_count       smallint NOT NULL DEFAULT 0 CHECK (call_count >= 0),
  current_round_id bigint,
  buff_skill_id    integer  NOT NULL DEFAULT 0,
  buff_start_at    timestamptz NOT NULL DEFAULT 'epoch',
  buff_stop_at     timestamptz NOT NULL DEFAULT 'epoch',
  buff_buy_day     date,
  buff_buy_count   smallint NOT NULL DEFAULT 0 CHECK (buff_buy_count >= 0)
);

CREATE TABLE guild.new_boss_round (
  id             bigserial PRIMARY KEY,
  guild_id       integer NOT NULL REFERENCES guild.guilds(id) ON DELETE CASCADE,
  week_start     date    NOT NULL,
  level          integer NOT NULL CHECK (level BETWEEN 1 AND 1000),
  boss_hero_id   integer NOT NULL,
  max_hp         bigint  NOT NULL CHECK (max_hp > 0),
  hp             bigint  NOT NULL CHECK (hp >= 0),
  called_by      integer NOT NULL REFERENCES game.players(id),
  start_at       timestamptz NOT NULL,
  stop_at        timestamptz NOT NULL,
  killed_at      timestamptz,
  rewards_paid   boolean NOT NULL DEFAULT false
);
CREATE INDEX new_boss_round_guild ON guild.new_boss_round (guild_id, week_start);
CREATE INDEX new_boss_round_unpaid ON guild.new_boss_round (stop_at) WHERE NOT rewards_paid;
ALTER TABLE guild.new_boss ADD FOREIGN KEY (current_round_id) REFERENCES guild.new_boss_round(id);

CREATE TABLE guild.new_boss_damage (
  round_id     bigint  NOT NULL REFERENCES guild.new_boss_round(id) ON DELETE CASCADE,
  player_id    integer NOT NULL REFERENCES game.players(id),
  damage       bigint  NOT NULL DEFAULT 0 CHECK (damage >= 0),
  fight_count  smallint NOT NULL DEFAULT 0,
  refreshed_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (round_id, player_id)
);
CREATE INDEX new_boss_damage_rank ON guild.new_boss_damage (round_id, damage DESC);

CREATE TABLE guild.new_boss_player_week (
  player_id      integer NOT NULL REFERENCES game.players(id),
  week_start     date    NOT NULL,
  rewarded_rounds smallint NOT NULL DEFAULT 0 CHECK (rewarded_rounds BETWEEN 0 AND 3),
  PRIMARY KEY (player_id, week_start)
);
```

`guild.guilds(id)` and `game.players(id)` are owned by the core module and the player tables *(assumed names)*. The EmeDream pet formation string (`consortiaPos`) belongs to the pets area.

---

## 8. Backend implementation notes

### Handlers (one per request opcode or op)

| Handler | Route | Validation order | Transaction |
|---|---|---|---|
| `guild::boss::handle_dream_upgrade` | 8846 | player in a guild → right index 1 → guild level ≥ 5 → grade < 10 → spirit ≥ cost(grade+1) | one tx: debit `combat_points`, grade+1. After commit, push 4728 to online members |
| `guild::boss::handle_dream_call` (8847 upgradeType 1) | 8847 | in guild → right index 1 → guild level ≥ 5 → server time not in 23:20-23:59 → state == 0 and last_call_day != today → 1 ≤ level ≤ min(grade,10) → offer ≥ 20000·level | one tx: debit `offer`, set state 1, call_grade, called_at, fight_start_at, end_at = fight_start_at + 1800 s, total_hp/cur_hp, missions reset, nightmare on. After commit: 4728 + 516 to online members, plus the core guild info refresh (wealth) |
| `guild::boss::handle_dream_enter` (8847 upgradeType 2) | 8847 | in guild → state in (1,2) → not in another campaign | no tx; create or join the per-guild map 7701 instance and send 125, 21, 127, then 4728, 4729, 4861, 4726, 4727, 4174, 4863 |
| `guild::boss::handle_dream_collect` | 5032 cmd 2 on map 7701 (campaign router delegates) | on map 7701, state 2 *(assumption)*, node is a fruit node | tx: progress A, roll the mission item (50 %), roll sleep_state. Push 4729 to map players, 4861 to the player |
| `guild::boss::handle_dream_attack` | 5125 on map 7701 | node exists, state 2 for the boss node *(assumption)*, player not stunned | start a battle (below). On report: damage upsert, mission B/C progress for monster nodes, boss HP. Push 4727 + 4174 to map players; on kill set state 3 and pay rewards |
| `guild::boss::handle_new_boss_open` | 8670 op 1 | in guild | read only; subscribe the session; send 4283, 4284, 4286 |
| `guild::boss::handle_new_boss_close` | 8670 op 2 | none | unsubscribe |
| `guild::boss::handle_new_boss_call` | 8670 op 3 | in guild → right index 1 or duty right 41 → no active round (`now <= stop_at && hp > 0`) → call_count < 3 this week → 1 ≤ id ≤ min(pass_level+1, max_level) → template exists | one tx: insert the round (hp = max_hp), call_count+1, set current_round_id. After commit: 4283 to all online members, 4287 to all online members, 4286 to subscribers |
| `guild::boss::handle_new_boss_fight` | 8670 op 4 | in guild → active round → player fight_count < 3 since the last refresh time → not in team, campaign or battle | start battle 3901. On 4103, one tx: `hp = max(0, hp - damage)`, damage upsert, fight_count+1. On kill: killed_at, pass_level update with the skip formula, best_count. Then push 4283 to online members, 4284 to subscribers, 4286 to the fighter |
| `guild::boss::handle_new_boss_buy_buff` | 8670 op 5 | in guild → right check *(assumption: right index 1, per help item 5)* → active round → id in buff shop config → buy count today < 6 → offer ≥ price | one tx: debit offer, set the buff (stop = now + 3600 s), count+1. Push 4283 to online members + the core wealth refresh |

### Scheduled jobs

- `guild::boss::tick_dream`:
  - state 1 → 2 at fight_start_at; push 4728;
  - state 2 → 3 at end_at; pay LostReward to participants with reward_count < 1; push 4728;
  - at midnight: state 3 → 0, reset per-day rows, push 4728 and 4863.
- `guild::boss::tick_new_boss`:
  - at round stop_at or kill: pay win/fail + damage rewards by mail *(assumption)* to participants still in the guild with rewarded_rounds < 3;
  - at the daily refresh time: reset fight_count and push 4286;
  - Monday 00:00: reset call_count and unfinished rounds, push 4283.

### Battle rule config (server battle engine, `docs/battle/server-engine.md` §9.2)

- **Terra dos Sonhos boss:**

  ```json
  {"battle_id":"<uuid>","battle_type":309,"map":7701,"count_down":180,
   "heroes":[ <player hero, hp 1 if nightmare_active>, <pets from consortiaPos (optional)>,
              {"temp_id":"<boss GameHeroTemp id (unknown, open question)>","type":3,"pos":5,
               "max_hp":"<total_hp>","hp":"<cur_hp>","phy_attack":"<base × AttackPercent/100>"} ],
   "soldiers":[ <player soldiers> ],
   "report":{"battle_result":1, "items":"<WinReward if kill>"}, "report_defeat":{"battle_result":2}}
  ```

  - The boss HP is shared: start from `cur_hp`, and write back `cur_hp - damage` on the report.
  - BufferIds[2..] are the player's battle buffs.
  - Elite and normal node fights *(assumption)* also use 309 on map 7701 with the monster templates of the node.
- **Chefão da Guilda:**

  ```json
  {"battle_type":3901,"map":"<MapInfos id with a BattleGround, unknown, e.g. 7701 (assumption)>","count_down":180,
   "heroes":[ <player hero>, {"temp_id":"<BossId[0]>","type":3,"pos":"<BossId[1]=5>",
              "max_hp":"<round.max_hp>","hp":"<round.hp>"} ], "soldiers":[ <player soldiers> ]}
  ```

  - Apply the guild buff skill (`buff_skill_id`) to the player side while `now < buff_stop_at`.
  - Damage dealt = HP lost by the boss during the battle.

---

## 9. Cross-area dependencies

- **Core:**
  - guild membership and `ConsortiaInfoMsg` 164/4138 (must carry `boss_info #65`);
  - guild level;
  - rights bits (`usrRights` index 1, duty right 41 via `getRightsByIndex(19)` + `consortiaDutyList[2].rightsStr`);
  - online member list for pushes.
- **Economy:**
  - guild wealth `offer` (summon, buff);
  - guild spirit / "Pontos de combate" (upgrade) and how it is earned;
  - guild shop tabs (boss shop button);
  - currencies -1400 and -18000;
  - `ConsortiaSkillHelper.addWealth` flow.
- **Campaign / world:** map 7701 instance, node list 127, movement, collection 5032, attack 5125, generic world boss sync 4174.
- **Battle:** engine for 309 and 3901 (`docs/battle/server-engine.md`).
- **Pets:** 8725 `consortiaPos` (dead UI).
- **Chat:** link type 121 for the new boss.
- **Mail:** reward delivery.

---

## 10. Open questions

1. Boss NPC template for map 7701 and the node layout (types 41/42 with param1 1/2/3, fruit nodes 91, Taus and Goblins monsters): not in client assets.
2. Meaning of `UpGradeTempInfos` Types 42 `TemplateName` pairs and of `ASection/BSection/CSection`.
3. Preparation phase length (state 1) and whether elite/normal node battles also use battleType 309.
4. New boss max HP formula from `HpMultiple`, and which battle map id to use for 3901.
5. Meaning of `max_level` (cap 1000 vs. unlocked max) and the exact skip formula on the server (the client only shows a preview).
6. Whether buff purchase requires a right, and whether a second buy replaces or stacks.
7. Reward delivery channel (mail vs. direct) and the exact payout moment for both bosses.
8. Whether 126 U_C_MSG is the right channel for server-side rejections (no dedicated opcode in this module).
9. Trap (4862) trigger rules on map 7701.

---

## 11. Implementation checklist

**Client screens and actions (already in the original client; verify against the backend):**

- [ ] Activity row id 3 "Terra dos Sonhos": state text, "Invocar BOSS" / "Ver drops", join (8847/2)
- [ ] `ConsortiaEmeDreamFrame`: combo, upgrade (8846), summon (8847/1), reward preview, help
- [ ] `ConsortiaEmeDreamRewardFrame` preview
- [ ] Map 7701 HUD: `EmeDreamTaskView`, `EmeDreamBufferView`, boss head bar and damage list
- [ ] Tip 60 `EmeDreamTipView` (516) and the join from tip
- [ ] Battle 309 HUD: boss level = callGrade, SelfBufferView buffs
- [ ] `ConsortiaNewBossFrame`: open/close (8670 op 1/2), fight (op 4), ranking, skip hint, buff tip, damage tip
- [ ] `ConsortiaNewBossCallFrame`: call (op 3)
- [ ] `ConsortiaNewBossBufferShopFrame` + `GoodsItem13`: buy buff (op 5)
- [ ] `NewBossDessFrame` (skip help), `consortianewboss.HelpFrame`
- [ ] Entry points: daily guide 97, chat link 121, tip 61 (4287), return from 3901 battle

**Backend handlers:**

- [ ] `guild::boss::handle_dream_upgrade` (8846)
- [ ] `guild::boss::handle_dream_call` (8847/1)
- [ ] `guild::boss::handle_dream_enter` (8847/2) + map 7701 instance per guild
- [ ] `guild::boss::handle_dream_collect` (5032 on 7701)
- [ ] `guild::boss::handle_dream_attack` (5125 on 7701) + battle 309 + report handling
- [ ] Pushes 4728, 516, 4863, 4726, 4729, 4861, 4862, 4727, 4174; `boss_info` inside 164/4138
- [ ] `guild::boss::tick_dream` scheduler (phases, rewards, midnight reset)
- [ ] `guild::boss::handle_new_boss_open` / `handle_new_boss_close` (8670 op 1/2) + subscription set
- [ ] `guild::boss::handle_new_boss_call` (8670 op 3)
- [ ] `guild::boss::handle_new_boss_fight` (8670 op 4) + battle 3901 + damage write-back
- [ ] `guild::boss::handle_new_boss_buy_buff` (8670 op 5)
- [ ] Pushes 4283, 4284, 4286, 4287 (4285 optional)
- [ ] `guild::boss::tick_new_boss` scheduler (round end payout, daily attempt refresh, weekly reset)
- [ ] Template loaders: ConsortiaBossTempInfos, UpGradeTempInfos Types 42, ConsortiaNewBossTemplates, ConsortiaNewBossReward, ConsortiaNewBossDamageReward, ConfigInfos keys

**Tables:**

- [ ] `guild.dream_boss`
- [ ] `guild.dream_boss_damage`
- [ ] `guild.dream_boss_player_day`
- [ ] `guild.new_boss`
- [ ] `guild.new_boss_round`
- [ ] `guild.new_boss_damage`
- [ ] `guild.new_boss_player_week`
