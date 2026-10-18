# Novice process

Area: tutorial, module `novice-process`. Covers the per player `novice_process` value (Chinese "新手进度"): who writes it, how the server stores it, how the login routes a novice into the training campaign or the castle, the "jump to level 40" opcode (8871), the in game "Pular tutorial?" button, and every client gate that reads the value.

Conventions: see [README.md](README.md). Related: [guided-steps.md](guided-steps.md) (the script that advances the value), [../account/register.md](../account/register.md) and [../account/login-session.md](../account/login-session.md) (HTTP servlet `updateplayernovice`, character creation).

## 1. Overview

`novice_process` is an integer checkpoint. Values are multiples of 100 (the castle side sender rejects other values, `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:2118`). The tutorial script (`NewbieManager`) maps checkpoint values to scripted nodes and writes the next checkpoint when a node finishes. Dozens of UI elements (task trace bar, hotkeys, toolbar buttons, chat bar, campaign button, skip buttons) are gated by thresholds on the same value. 99900 means "tutorial over" (`PlayerManager.isNewbie` is `newbieProcess < 99900`, `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1640`).

Lifecycle:

1. Account not active: the Loading module sets 0 and runs registration (`decompiled/Loading/scripts/Loading.as:433`). Owned by [account](../account/register.md).
2. Active account: Loading reads the value with HTTP `updateplayernovice` `op=0` (`decompiled/Loading/scripts/Loading.as:449`, `:466`). Owned by [account](../account/login-session.md).
3. After the name is chosen the register flow writes 10000 with HTTP `op=1` (`NewbieSPHelper.NEWBIE_NAMEEND`, `decompiled/Loading/scripts/newbie/NewbieSPHelper.as:11`, called from `decompiled/Loading/scripts/register/MainFigureView.as:436`).
4. In game the value arrives in `PlayerMsg.novice_process (#23)` (push 3) and is the source of truth after login (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:889`).
5. When the core finishes loading with value 10000 it saves 11000 through socket 5017 (`decompiled/core_module/scripts/yishi/lunch/StartupResourcesLoader.as:287`).
6. Each finished tutorial node saves its next checkpoint through 5017 ([guided-steps.md](guided-steps.md)), up to 25000 for the forced part and 26000 to 50000 for level guides.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SimpleAlertHelper` alert from `SmallMapBar.__skipNewbieHandler` (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:898`) | "Aviso", text "Pular tutorial?", buttons "Confirmar" / "Cancelar" (`mainBar.SmallMapBar.content`, `public.prompt`, `public.confirm`, `public.cancel`) | Skip the training campaign | Mini map button `smallMap.NoviceCloseBtn`, visible only when the current map is 10001 or 10002 (`SmallMapBar.as:562`, `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as:193`) | none |

No other screen belongs to this module; the value only changes what other screens show (section 5).

## 3. Routes (client to server)

| # | UI control / trigger | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| N1 | Tutorial node finished, level guide finished, explicit saves at 19000 and 25000 | `NewbieSocketOutManager.sendSaveProcess` `decompiled/core_module/scripts/dialog/utils/NewbieSocketOutManager.as:19` (from `NewbieTutorialBase.complete` `decompiled/core_module/scripts/dialog/utils/NewbieTutorialBase.as:176`, `NewbieNodeBase.complete` `decompiled/core_module/scripts/dialog/utils/NewbieNodeBase.as:169`, `NoviceTutorial_60` `decompiled/m8/scripts/nodes/NoviceTutorial_60.as:60`, `NoviceTutorial_200` `decompiled/m8/scripts/nodes/NoviceTutorial_200.as:68`, action `sendSaveNode` `decompiled/m8/scripts/mediators/NewbieBaseActionMediator.as:737`) | value > 0. The local value is updated before sending (optimistic) | C>S 5017 0x1399 `U_C_PLAYER_NOVICE` | `NoviceReqMsgMsg` (package `novice`): `novice_process (#1, INT32)` new checkpoint. Not set by the client: `army_id (#2, INT32)`, `type (#3, INT32)`, `arms_id (#4, INT32)`, `goods_id (#5, INT32)`, `grade_process (#6, STRING)` | None required. Client has no listener for accept 1. Re-evaluate quest conditions of type 23 and push quest updates ([quests](../quests/README.md)) |
| N2 | Core loaded with value 10000; login fix up when hero level > 16 and value < 36000 | `PlayerManager.sendSaveProcess` `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:2114` (callers `decompiled/core_module/scripts/yishi/lunch/StartupResourcesLoader.as:290`, `decompiled/core_module/scripts/yishi/manager/BaseManager.as:1952`) | value > 0 and `value % 100 == 0` | C>S 5017 0x1399 | as N1 with 11000 or 36000 | as N1 |
| N3 | Login state push 6 with a castle state (not 4..8) and value < 19000 | `BaseManager.__loginStateHandler` `decompiled/core_module/scripts/yishi/manager/BaseManager.as:1941` | none | C>S 5127 0x1407 `U_C_CAMPAIGN_TRAINING` ("进入新手训练战役") | `NoviceReqMsgMsg`: `type (#3, INT32)` = 1 | Server creates the training campaign 10002 instance and enters it: 125 `U_C_CAMPAIGN_CREATE` then the campaign scene data (Assumption, see [campaign](../campaign/README.md)) |
| N4 | (dead code) jump novice | `StartupResourcesLoader.sendJumpNovice` `decompiled/core_module/scripts/yishi/lunch/StartupResourcesLoader.as:298` -> `SocketSendManager.sendJumpNovice` `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:636` | `PlayerInfo.jumpNovice` true; sets local value 99900 first. The private method has no caller in this build | C>S 8871 0x22a7 `C_JUMP_NOVICE` ("选择直接到40级", choose to go directly to level 40) | no body | Assumption: server raises the hero to level 40, sets 99900, clears `jump_novice`, and pushes 3 |
| N5 | "Pular tutorial?" confirm | `SmallMapBar.skipNewbieCall` `decompiled/core_module/scripts/mainBar/SmallMapBar.as:905` | user confirmation | HTTP `{REQ}selectjobregister` (loader type 7, `routes/routes.md`) | URL variables `userid`, `key` (session key), `jump=true`, `ran` (random) | XML root with attributes `type` and `value`; on `type == 12` and `value == "true"` the client calls `NewbieModule.updateCurNode(19000)` (`SmallMapBar.as:923`). Class `NewbieModule` does not exist in this build, so the call would throw (legacy). Assumption: server sets the value to 19000, marks the training campaign nodes passed and moves the player to the castle |
| N6 | Account login | `Loading.reqNoviceProcess` `decompiled/Loading/scripts/Loading.as:449` | owned by [account](../account/login-session.md) | HTTP `{REQ}updateplayernovice` `op=0` | `userid`, `noviceprocess=0`, `key`, `rnd` | plain text integer, the stored value |
| N7 | Name chosen | `NewbieSPHelper.saveNoviceProcess` `decompiled/Loading/scripts/newbie/NewbieSPHelper.as:22` | owned by [account](../account/register.md) | HTTP `{REQ}updateplayernovice` `op=1` (POST) | `userid`, `noviceprocess=10000`, `key`, `rnd` | any body; the callback continues the register flow |

Notes:

- `NewbieManager.skipNoviceHandle` (`decompiled/core_module/scripts/dialog/utils/NewbieManager.as:224`) marks every campaign node destroyed (state 8) and calls `sendSaveProcess(-1)`, which sends nothing because of the `> 0` check. It has no caller in this build.
- Both senders write the local value before sending; the client never waits for a confirmation.

## 4. Server messages (server to client)

| Route | Message and fields read | When | Client handler and effect |
|---|---|---|---|
| S>C 3 0x0003 `U_C_PLAYER_INFO` | `PlayerMsg` (package `player`, see [hero](../hero/README.md)): `novice_process (#23, INT32)`, `qte_guide (#56, INT32)`, `jump_novice (#110, BOOL)` | Login and whenever the value changes server side (for example after N4 or N5) | `PlayerManager.__uPlayerInfoHandler`: `noviceProcess` at `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:889`, `qteGuide` at `:1063`, `jumpNovice` at `:1135`. The setter fires notification `NEWBIE_PROCESS_UPDATE` (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as:1237`), which refreshes quests with condition type 23 (`decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:239`) |
| S>C 6 0x0006 `U_C_PLAYER_LOGINSTATEE` | `LoginStateMsg`: `player_id (#1, INT32)`, `state (#2, INT32)`: 0 castle, 4 campaign, 5 battle, 6 sandbox, 7 game hall, 8 secret war (`decompiled/core_module/scripts/map/internals/constant/LoginState.as:6`) | Once per login, after `PlayerMsg` | `BaseManager.__loginStateHandler` `decompiled/core_module/scripts/yishi/manager/BaseManager.as:1904`. For states other than 4 to 8: value < 19000 sends 5127 (N3); hero level > 16 and value < 36000 sets 36000 locally, sends 5017 and enters the castle; hero level <= 16 enters the castle. Then `NewbieManager.instance.start()` (`:1961`) |
| S>C 1 0x0001 `U_C_PLAYER_NOVICE` | `NoviceReqMsgMsg` | Not needed | No listener in the client. Sending it has no effect |

## 5. Rules and formulas

### 5.1 Checkpoint values

| Value | Meaning | Written by |
|---|---|---|
| 0 | Not registered | Loading (`Loading.as:438`) |
| 10000 | Name chosen (`NEWBIE_NAMEEND`) | HTTP op 1 (account) |
| 11000 | Start of training campaign (`NEWBIE_START_CAMPAIGN`, `NewbieSPHelper.as:13`) | N2 at load (`StartupResourcesLoader.as:287`) |
| 11300 to 14000 | Training campaign steps (intro, NPC walks, two guided battles) | tutorial nodes 10 to 50 |
| 19000 | Left the training campaign, go to castle (`NEWBIE_GOTOCASTLE`, `NewbieSPHelper.as:15`) | node 60 |
| 19500, 20000, 21000, 23000, 25000 | Castle tutorial steps | nodes 160 to 200 |
| >= 25000 | Forced tutorial over; level guides active (`NewbieManager.isMaxNovice`, `decompiled/core_module/scripts/dialog/utils/NewbieManager.as:214`) | node 200 |
| 26000, 27200, 35000, 36000, 38000, 45000, 50000 | Level and quest guides done | `NewbieNodeBase.complete` (see [guided-steps.md](guided-steps.md)) |
| 99900 | Tutorial disabled; novice resources not loaded | jump novice; prototype default in `server/flows.json` |

The full node table is in [guided-steps.md](guided-steps.md) section 5.

### 5.2 Login routing (server must reproduce the inputs)

- `LoginStateMsg.state` not in 4..8 and value < 19000: client asks 5127 type 1; the server must put the player in campaign 10002.
- value >= 19000 and hero level <= 16: client enters the castle.
- hero level > 16 and value < 36000: client forces 36000 (saved with 5017) and enters the castle. This covers characters leveled outside the tutorial.
- Otherwise the scene comes from the normal login flow ([account](../account/login-session.md)).

### 5.3 Resource selection at load

`decompiled/core_module/scripts/yishi/lunch/StartupResourcesLoader.as`: value < 19000 loads campaign UI and battle map 14 (`:145`); < 99900 loads `novice` UI and `newbie.dat` (`:153`); < 11300 loads `newguidestart` (`:159`); < 15000 preloads campaign map 10002 with a 6 x 11 grid (`:209`); >= 10000 sets template parse step 500 instead of 30 (`:256`). When `jump_novice` is true the loader treats the value as 99900 (`:388`).

### 5.4 Client gates on the value

| Gate | Effect | Source |
|---|---|---|
| < 19000 | `NewbieTaskTraceView` replaces the normal task trace | `decompiled/core_module/scripts/ui/tasktracebar/TaskTraceBar.as:74` |
| < 15000 | task trace bar, top tools bar entry and chat bar hidden | `TaskTraceBar.as:237`, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:2458`, `decompiled/core_module/scripts/mainBar/ChatBar.as:161` |
| <= 11000, <= 15500, <= 19000, <= 22000, <= 23000 | hotkeys disabled | `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:462`, `:313`, `:343`, `:406`, `:373`, `:656` |
| >= 23000 | main toolbar campaign button visible | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1243` |
| < 19200 | toolbar return button disabled | `MainToolBar.as:1262` |
| <= 19000 | toolbar ignores quest complete events; store intensify shortcut refused ("Nível baixo, função habilitada no Nv. {0}") | `MainToolBar.as:988`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1340` |
| < 19000 | battle: reinforcement pane hidden, skill use sends 10022 then 10008 after 400 ms, battle end returns to the stored scene | `decompiled/m10/scripts/battle/view/ui/RoleShowViewII.as:90`, `decompiled/core_module/scripts/battle/view/ui/SkillItemListController.as:700`, `decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:348` |
| == 12500 | battle hotkeys for skill templates 10711, 20711, 30711 blocked | `decompiled/core_module/scripts/battle/view/ui/BattleSkillItemII.as:515` |
| == 11500 / 12500 | keys 1 / 2 trigger the highlighted skill during the guide | `decompiled/m8/scripts/mediators/NewbieBaseActionMediator.as:1037` |
| <= 11300 .. 14000 | army start position on map 10002 | `decompiled/m3/scripts/map/campaign/view/layer/CampaignWalkView.as:516` |
| >= 19000 | new quest handling (`newTaskHandler`) | `decompiled/core_module/scripts/yishi/manager/TaskManage.as:194` |
| == 19000 | castle scene preloads the `flytocastle` movie | `decompiled/core_module/scripts/yishi/scene/SceneCreate.as:304` |
| >= 21000 | new building focus animation | `decompiled/m4/scripts/castle/view/CastleMapViewII.as:281` |
| <= 25000 | castle map drag disabled; day guide shortcuts refused ("Função não habilitada, não é possível pular") | `CastleMapViewII.as:383`, `decompiled/core_module/scripts/managers/DayGuideManager.as:455` |
| > 19000 | bag item drop on the stage sells the item | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellDropMediator.as:179` |
| <= 15500 | task trace tips suppressed | `decompiled/core_module/scripts/managers/TaskTraceTipManager.as:455` |
| quest condition type 23 | condition satisfied when value >= `Para1` | `decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:1088` |

### 5.5 Quest conditions driven by the value

`raw/xml/tempinfos/QuestCondictionInfos.xml`, `CondictionType="23"`: template 10 "Exterminar os Furbolgs" `Para1=11600`; 20 "Limpar o Caminho" 13000; 30 "Resgatar a Donzela" 13000; 40 "Exterminar os Monstros" 17000; 45 "Quebrar o Inimigo" 18000; 50 "Recapturar Cidade" 19000; 187 "Ir ao Reino do Céu" 35200; 1832 "Retornar à cidade" 19000; 1856 "Elevar para o nível Alma do Dragão Filhote" 29500. The server must mark these conditions complete when a 5017 raises the value to or above `Para1`.

## 6. Templates

| File | Record | Fields used here |
|---|---|---|
| `raw/xml/tempinfos/QuestCondictionInfos.xml` | `QuestConditionInfo` with `CondictionType="23"` | `TemplateId` quest, `Para1` novice process threshold, `Para2` required count (1) |
| `raw/xml/tempinfos/Campaigns.xml`, `MapInfos.xml` | campaign 10002 "Monte do Dragão Divino", map 10002 (`BattleGround="14"`) | training campaign target of 5127 |
| `index/language.json` | pt-BR strings | `mainBar.SmallMapBar.content`, `dayGuide.DayGuideManager.command01`, `command02` |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS tutorial;

CREATE TABLE tutorial.player_progress (
    player_id        BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    novice_process   integer     NOT NULL DEFAULT 0 CHECK (novice_process >= 0 AND novice_process % 100 = 0),
    jump_novice      boolean     NOT NULL DEFAULT false,   -- PlayerMsg.jump_novice (#110): offer of 8871
    qte_guide_done   boolean     NOT NULL DEFAULT false,   -- PlayerMsg.qte_guide (#56), see guided-steps.md
    training_entered_at timestamptz,                       -- first 5127
    updated_at       timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE tutorial.progress_log (
    id              bigserial   PRIMARY KEY,
    player_id       BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    old_value       integer     NOT NULL,
    new_value       integer     NOT NULL,
    source          text        NOT NULL CHECK (source IN ('socket_5017','http_update','jump_8871','skip_http','login_fixup','admin')),
    created_at      timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX progress_log_player_idx ON tutorial.progress_log (player_id, created_at DESC);
```

The HTTP servlet `updateplayernovice` (account) reads and writes `tutorial.player_progress.novice_process`. If the account schema keeps its own copy, one of the two must be the single source of truth (Open question).

## 8. Backend implementation notes

- `tutorial::novice_process::handle_save_progress` (5017): decode `NoviceReqMsgMsg`; validate `novice_process > 0` and `% 100 == 0`; Assumption: store `max(current, new)` (see section 9); insert a log row; in the same transaction call the quest engine to re-evaluate condition type 23 for accepted quests and push quest progress. No reply packet. Do not push 3 back for this change (the client already set the value); pushing it is harmless.
- `tutorial::novice_process::handle_enter_training_campaign` (5127): accept only when `novice_process < 19000` (Assumption); `type` must be 1; create or resume the single player campaign 10002 and send the campaign creation sequence of [campaign](../campaign/README.md). Node states of 1000206 and 1000208 must reflect progress (state 8 destroyed once beaten) because the script skips steps on them.
- `tutorial::novice_process::handle_jump_novice` (8871): no body. Only when `jump_novice` is true. Assumption: grant hero level 40 (upgrade templates), set 99900, clear `jump_novice`, push 3. The client build never sends it; implement last.
- HTTP `selectjobregister` with `jump=true` (account HTTP router): Assumption: set 19000, mark campaign 10002 nodes destroyed, complete quests whose type 23 threshold <= 19000, return `<result type="12" value="true"/>`, and on the next 6 the player lands in the castle. The client side continuation is broken (missing `NewbieModule`), so the player should be told to relog (Open question).
- Login: always send `PlayerMsg.novice_process` before `LoginStateMsg` (6). For a novice (< 19000) send state 0; the client then asks 5127.
- Character creation (account) should create the `tutorial.player_progress` row.

## 9. Open questions and assumptions

- Assumption: the value is monotonic. Level guide nodes can complete out of order (quest 1912 guide writes 50000, the level 50 guide later writes 45000), so a strict "greater than" check would reject valid saves; using `max` keeps the highest checkpoint and no client gate depends on values above 36000.
- Accept 1 `U_C_PLAYER_NOVICE` has no client listener; it is unclear whether the original server answered 5017. Not needed.
- The Chinese description of 5017 also says "新手引导进入内城初始化建筑及队列" (initialize buildings and queues when entering the inner city); in this client that is a separate opcode 8281 ([guided-steps.md](guided-steps.md)). Assumption: 5017 has no side effect besides storage and quest conditions.
- `jump_novice` delivery: the loader reads `PlayerInfo.jumpNovice` before the core receives `PlayerMsg` in some flows; whether the original login pushed it early is unknown.
- `NewbieModule.updateCurNode` is missing; the skip button flow cannot complete client side in this build.
- Unknown which store (account HTTP or game socket) the original server considered authoritative.

## 10. Implementation checklist

- [ ] Table `tutorial.player_progress` and `tutorial.progress_log`
- [ ] Row created at character creation (account)
- [ ] `PlayerMsg` fields #23, #56, #110 filled at login and on change
- [ ] Login state 6 sent after `PlayerMsg`; novice gets state 0
- [ ] Route N1/N2 5017 save with validation and quest type 23 re-evaluation
- [ ] Route N3 5127 enter training campaign 10002
- [ ] Route N4 8871 jump novice (optional)
- [ ] Route N5 HTTP `selectjobregister` jump (optional)
- [ ] HTTP `updateplayernovice` op 0 and op 1 share the same storage (account)
- [ ] Rule: values multiple of 100, monotonic max
- [ ] Rule: hero level > 16 forced 36000 accepted
- [ ] Test: new character goes 10000 -> 11000 at first load and enters campaign 10002
- [ ] Test: relog at 14000 re-enters campaign 10002; relog at 19000 lands in castle
- [ ] Test: saving 19000 completes quest 1832 "Voltar para a Cidade" condition
- [ ] Test: 99900 disables every tutorial UI element
