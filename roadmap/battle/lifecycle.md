# Battle lifecycle: create, load, start, fight loop, end, results, rewards, spectator

Module `lifecycle` of the feature [Motor de batalha](README.md). Path prefixes: **CM** = `decompiled/core_module/scripts`, **M10** = `decompiled/m10/scripts`, **M3** = `decompiled/m3/scripts`. Deep client detail lives in `docs/battle/README.md`, `docs/battle/rules.md` §1, §7, §8 and `docs/battle/hud.md` §10; the current mock engine is described in `docs/battle/server-engine.md`.

## 1. Overview

Every battle in the game, whatever feature starts it, runs through the same server driven sequence:

```text
owning feature request (campaign node, arena challenge, boss, ...)
  S>C 157 U_B_PREPARE          BattlePrepareMsg (paged when total_page > 1)
  client loads resources, plays the transition
  C>S 10007 U_B_USER_LOADOVER  (or 10018 B_REINFORCE_LOADOVER when use_way != 0)
  S>C 156 U_B_START            BattleStartMsg {frame 0, mainType, count_down}
  fight loop (real time, 25 frames per second)
     S>C 153 U_B_ATTACKING / 4102 U_B_GODDESS_STAGE  one order per unit action
     S>C gauges, reinforcement, notices (see the other modules)
     C>S skill requests, auto, finish now (see skills-effects.md, ai-auto.md, hud-actions.md)
  S>C 154 U_B_PREPARE_OVER     PrepareOverMsg: Victory / defeat pose per unit
  S>C 4103 U_BATTLE_REPORT     BattleReportMsg: result and rewards summary
  client shows the result screen, then exits to the scene chosen by battleType
```

There are **no rounds on the wire**: time is a frame clock (`BattleManager._liftTime`, +1 per frame at 25 fps). Turns exist only inside buffs (`BufferMsg.cur_turn`) and are counted by the server (`docs/battle/rules.md` §13.2).

Other exits: 4166 `U_B_FIGHT_CANCELED` (cancel, no result screen) and 4680 `U_C_BATTLE_CLEAR_DEADLVING` (own death in 295/3854 cancels after 1.5 s). The client has **no replay code**; the only "watch" path is spectator mode (8985, `battle_from = 1`, §3.7), whose sender is unreachable in this build.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.view.BattleLoadingView` (CM) | none (loading bar) | Resource preload before the scene | `EnterBattleController.handler` (`CM/battle/control/EnterBattleController.as:64-107`) after 157 | load progress |
| `asset.core.EnterBattleSwitchMC` | none | Transition animation | `EnterBattleController` (:179-194) | none |
| `battle.BattleSceneView` (`BATTLE_SCENE`, M10) | none | The battle scene: map, units, HUD | `setScene("BATTLE_SCENE")` (`EnterBattleController.as:221-246`) | map `MapInfos.BattleGround`, units from 157 |
| `battle.view.battleresult.VicotyBattleResultViewSimple` / `FailedBattleResultViewSimple` (CM) | animation only (`asset.battle.VictoryAssetII2` / `FailedAssetII2`) | Default result screen | `BattleResultHandler.showNewVersionPane` (`CM/battle/handler/BattleResultHandler.as:682-747`) | nothing |
| `VicotyBattleResultView` / `FailedBattleResultView` | `asset.battle.VictoryAsset2` / `FailedAsset2` | Detailed result, battleType 16 and 10 only | same (:699-702, :728-731) | `gp_bonus` counted from 0 (EXP) |
| `VicotyOutyardBattleResultView` / `FailedOutyardBattleResultView` | `asset.battle.VictoryAsset3` / `FailedAsset3` | Terrálem result, battleType 3855 only | same (:689-698, :716-727) | `param1` EXP (victory), `param2` % (defeat) |
| `battle.multiFailedAlertFrame` (`MultiFailedAlertAction`) | "Esse mapa tem dificuldade elevada, aconselhável elevar seu poder de combate antes de desafiá-lo." (`Campaign.MultiFailedAlert`) | Too many defeats warning | `resultViewCloseFun` when `fail_count > 4` and the option is unchecked (`BattleResultHandler.as:775-781`) | text + "do not show today" checkbox |

The result screen has no buttons and no item list: it closes on any click or 1 s after its last frame (`CM/battle/view/battleresult/BaseBattleResultView.as:51-105`). Rewards are shown by the owning feature after exit (chest frame, reward frames).

## 3. Routes (client to server)

### 3.1 L1. Load finished (enter the fight)

| Item | Value |
|---|---|
| UI control | none: fires automatically when the entry transition ends |
| Client sender | `EnterBattleController.effectComplete` (`CM/battle/control/EnterBattleController.as:284-307`) -> `SocketSendManager.sendLoadOver` / `sendReinfoLoadOver` (`CM/yishi/service/managers/SocketSendManager.as:297-316`) |
| Client checks | `useWay == 0` -> 10007, else 10018 (:297-304); `plotHandler.activate()` first (:296); then `SKILL_ENABLE true` (:305) |
| Route | C>S **10007 (0x2717) U_B_USER_LOADOVER**, or **10018 (0x2722) B_REINFORCE_LOADOVER** |
| Request | `battle.LoadOverMsg`: `army_id (#1, INT32)` = `ArmyManager.army.id`; `battle_id (#2, STRING)` = current battle id; `server_name (#3, STRING)` = player server name (`SocketSendManager.as:307-316`) |
| Expected response | 156 `U_B_START` once (every player of a multi player battle must have loaded, or a timeout expired, assumption), then the fight stream. For 10018 (reinforcement/late join, `use_way != 0`) the server resumes the current battle for this player *(assumption: 156 with the current frame)* |

### 3.2 L2. Combo count at the end

| Item | Value |
|---|---|
| UI control | none |
| Client sender | `BattleResultHandler.handler` (`CM/battle/handler/BattleResultHandler.as:595-608`) -> `SocketSendManager.sendBattleCount` (`SocketSendManager.as:110-116`) |
| Client checks | battleType 6 **or** `battleCapity == 4`, and `batterModel.maxBatterCount > 2` |
| Route | C>S **8282 (0x205a) C_BATTER_COUNT** |
| Request | `campaign.BatterLastInfoMsg`: `count (#1, INT32)` = highest combo (consecutive hits) of the battle |
| Expected response | none seen in the client *(assumption: the campaign feature may grant a combo bonus)* |

### 3.3 L3. Plot dialog finished

| Item | Value |
|---|---|
| UI control | closing a battle plot dialog |
| Client sender | `BattleDialogAction` (`CM/battle/actions/BattleDialogAction.as:15-20`) -> `SocketSendManager.sendBattlePlotComplete` (`SocketSendManager.as:89-99`); tutorial `NewbieSocketOutManager.sendBattleContinue` (`CM/dialog/utils/NewbieSocketOutManager.as:49-55`) |
| Client checks | a battle model exists |
| Route | C>S **10022 (0x2726) B_PAUSE_FINISHED** |
| Request | `battle.BattleReqMsg`: `battleId (#2, STRING)`; other fields unset |
| Expected response | none; the server resumes the battle clock if it paused for the dialog. Dialogs are pushed by 171 `U_C_BATTLE_TALK` (owned by [../tutorial/README.md](../tutorial/README.md)). The tutorial also sends 10010 `U_B_USR_STOP_CMD` (pause, same message) |

### 3.4 L4. Leave the War Tower early (battleType 3905)

Owned by [hud-actions.md](hud-actions.md) (route H3, 10497 `B_REMOVE_BATTLE`).

### 3.5 L5. Finish now (battleTypes 16, 35, 307)

Owned by [hud-actions.md](hud-actions.md) (route H2, 8727 `C_PET_CHALLENGE_END_BATTLE`).

### 3.6 L6. Debug create / debug end

| Item | Value |
|---|---|
| Client sender | `DebugBattleCreater` (`CM/battle/logsys/DebugBattleCreater.as:39-40`) and the debug buttons `_killSelfBtn` / `_immediatelyWinBtn` (`M10/battle/view/ui/BattleUIView.as:1532-1544`), only with `StageReferance.isDebug` |
| Route | C>S **10003 (0x2713) DEBUG_BATTLE** (`battle.BattleCreateMsg`); C>S **14002 (0x36b2) B_BATTLE_SUICIDE_OVER** (`battle.BattleReqMsg {battleId (#2, STRING), otherObj (#4, INT32)}`, `otherObj` 1 = win now, 2 = lose now) |
| Server | must ignore both in production; may accept them behind a GM flag |

### 3.7 L7. Spectate a battle

| Item | Value |
|---|---|
| UI control | "Lista de Guerras" (`yishi.viewBattleViewListFrame.title`) and `BattleCDViewFrame` |
| Client sender | `BattleViewManager.sendOperationToServer` (`CM/managers/BattleViewManager.as:240-292`); retry via `CDFinishHanlder` from `M3/map/space/view/frame/BattleCDViewFrame.as:104` |
| Client checks | 300 ms anti double click for type 0 (:250-253); `checkCanViewBattle`: not in a team, not on a campaign map, not in the sandbox (`BattleViewManager.as:305-326`, message "Apenas poderá assistir a batalha no Reino do Céu ou dentro da cidade") |
| Route | C>S **8985 (0x2319) C_BATTLE_VIEW** |
| Request | `battle.BattleViewMsg`: `type (#1, INT32)`: 0 = check state, -1 = quit, 1 = view by player, 2 = view by team, 101/102/103 = final of warlords / multilords / matelords (`BattleViewManager.as:34-46`); `userId (#2, INT32)` target player (type 1); `server_name (#3, STRING)` target server (type 1); `team_uuid (#4, STRING)` target team (type 2); `son_type (#5, INT32)` real view type when `type == 0` |
| Expected response | type 0: 4804 `U_CROSS_VIEW_BATTLE_INFO` (`simple.PropertyMsg`); view: 157 with `battle_from = 1`, then the live stream; quit or end: 4803 `U_CROSS_BATTLE_VIEW` |
| Finding | no code calls `sendOperationToServer` except the CD retry, which replays arguments only `sendOperationToServer` sets: **spectator mode is unreachable in this client**. Implement after everything else |

## 4. Server messages (server to client)

### 4.1 157 (0x009d) U_B_PREPARE: create the battle

`battle.BattlePrepareMsg` (tags from `protocol/proto.json`):

| Field | Meaning and client use |
|---|---|
| `battle_id (#1, STRING)` | battle id, echoed in every battle message; `BattleModel.battleId` (`CM/battle/transaction/CreateGameTransaction.as:104-124`) |
| `battle_type (#2, INT32)` | battleType, see [battle-types.md](battle-types.md); `BattleModel.battleType` |
| `map_temp_id (#3, INT32)` | `MapInfos.Id`; scene art = `MapInfos.BattleGround` (`CGT:117`) |
| `need_animation (#4, BOOL)` | `isSelfCharge` (own units run in) |
| `side (#5, INT32)` | the receiving player's side (1 or 2); own side is always drawn left (`CGT:955-961`) |
| `has_assault (#6, BOOL)` | `isNoCharge = !has_assault`; forced true on reconnect |
| `use_way (#7, INT32)` | 0 = normal entry (client answers 10007); != 0 = reinforcement/late join (answers 10018) |
| `attack_model (#8, INT32)` | initial auto fight flag: 1 = auto, 2 = manual (`BattleModel.initAutoFight`, `CM/yishi/datas/BattleModel.as:311-323`); see [ai-auto.md](ai-auto.md) |
| `reinforceCount (#9, INT32)` | total reinforcement waves (`reinforceWave`) |
| `currentReinforce (#10, INT32)` | current wave index (`currentReinforceWave`) |
| `battle_capity (#11, INT32)` | number of player seats; `> 1` = multi player (blocks auto fight unless 3886), `== 4` enables 8282 at the end |
| `count_down (#12, INT32)` | HurtUp countdown in ms (`hurtUpStart`), see [damage.md](damage.md) |
| `damage_improve (#13, INT32)` | HurtUp damage increase percent, cumulative |
| `soldiers (#14, SoldierMsg, repeated)` | troop units, see [units.md](units.md) |
| `heros (#15, HeroMsg, repeated)` | heroes, NPC heroes and bosses |
| `soldierTemplated (#16, INT32, repeated)` | distinct soldier template ids to preload |
| `coolDown (#17, CoolDownMsg, repeated)` | initial skill cooldowns of the own hero: `templated_id (#1, INT32)`, `cool_down (#2, INT32)` ms, `cool_type (#3, INT32)`, `appear_cool_down (#4, INT32)` ms (`CGT:164-179`) |
| `currentWave (#18, INT32)` | trial layer shown by `TrailCountView` |
| `pets (#19, HeroMsg, repeated)` | pets, linked to owners by `living_id2` |
| `children (#20, HeroMsg, repeated)` | guardians (children) |
| `heroTempId (#21, INT32, repeated)` / `life (#22, INT64, repeated)` | parallel lists kept in `BattleModel._heroTempId/_life` (remaining lives of multi boss modes) |
| `battle_from (#23, INT32)` | 0 = participant, 1 = spectator; with 0 and no own hero the client aborts model setup (`CGT:152-160`) |
| `view_side (#24, INT32)` | no client consumer |
| `goddesses (#25, HeroMsg, repeated)` | goddesses, linked by `living_id2` |
| `page (#26, INT32)` / `total_page (#27, INT32)` | paging: with `total_page > 1` the client merges pages of the same battle id (`CM/yishi/manager/CoreTransactionManager.as:127-177`; bug: page goddesses are merged with soldiers, :148) |
| `monsters (#28, HeroMsg, repeated)` | battle beasts ([../monsters/README.md](../monsters/README.md)) |
| `chessList (#29, HeroMsg, repeated)` | auto chess pieces (battleType 349) |

Receiver: `SocketManager` routes 157 straight to `CoreTransactionManager.handlerPackage` (`CM/yishi/service/managers/SocketManager.as:151-153`) -> `CreateGameTransaction.handlePackage/initBattleInfo/initBattleManager` (`CGT:75-201`). Header `extend2 = 0`. The skill bar layout comes from opcode 64 `army.HeroFastKeyMsg {fast_key (#1, STRING), set_result (#2, BOOL)}` (owned by [../skills/README.md](../skills/README.md)); the mock sends it just before 157.

### 4.2 156 (0x009c) U_B_START

`battle.BattleStartMsg`: `frame (#1, INT32)` start frame, sets the client clock; `mainType (#2, INT32)` **overrides** `battleType`; `count_down (#3, INT32)` restarts HurtUp (ms). Receiver `BattleStartTransaction.configure` (`CM/battle/transaction/BattleStartTransaction.as:19-30`), queued through `BattleTransactionManager`. Send once after every participant has loaded. `mainType` must equal 157 `battle_type` (UI built before 156 uses the 157 value).

### 4.3 153 (0x0099) U_B_ATTACKING and 4102 (0x1006) U_B_GODDESS_STAGE

The fight stream, specified in [skills-effects.md](skills-effects.md) §4.1. Header `extend2` = release frame: the client queue releases **at most one battle packet per frame**, the first in arrival order with `extend2 <= clock` (`CM/battle/transaction/BattleTransactionManager.as:75-114`).

### 4.4 69 (0x0045) U_B_USER_STOP

`battle.UserStopMsg {type (#1, INT32), order (#2, INT32)}`; `BattleStopTransaction` reads and ignores it (`CM/battle/transaction/BattleStopTransaction.as:14-31`). Do not send.

### 4.5 154 (0x009a) U_B_PREPARE_OVER: final poses

`battle.PrepareOverMsg`: `frame (#1, INT32)` frame at which poses start; `prepareOverLivings (#2, PrepareOverLivingMsg, repeated)`, each `calc_type (#1, INT32)` 3 = Victory (skill 3 "Vitória"), 4 = defeat (skill 4, no local template so no animation), `living_id (#2, INT32)`, `sp (#3, INT32)`. Receiver `VictoryFailTransaction.handle` (`CM/battle/transaction/VictoryFailTransaction.as:21-87`), **outside** the queue. The first `calc_type 3` entry decides the winning side; dead heroes of that side also play Victory. Must contain at least one `calc_type 3` entry if any hero sits on side 0 (else the client crashes).

### 4.6 4103 (0x1007) U_BATTLE_REPORT: result

`battle.BattleReportMsg`:

| Field | Meaning and client use |
|---|---|
| `battle_result (#1, INT32)` | 1 = victory, 2 = defeat; other values skip the screen |
| `strategy_bonus (#2, INT32)` | not shown (single pass view only, dead path) |
| `gp_bonus (#3, INT32)` | EXP gained; shown in the detailed views (16, 10) |
| `pos_x (#4, INT32)` / `pos_y (#5, INT32)` | chest position on the campaign map (`M3/map/campaign/CampaignSocketManger.as:979-1042`) |
| `sign_id (#6, STRING)` | unused |
| `baseItem (#7, BaseItemMsg, repeated)` | `template_id (#1, INT32)`, `count (#2, INT32)`: dropped items; the campaign map creates a temporary "Baú" chest node from them |
| `battle_scene (#8, INT32)` | scene class; values 2, 8, 11, 19, 22 suppress the defeat progression tip (`CM/yishi/manager/BaseManager.as:2797-2807`) |
| `fail_count (#9, INT32)` | consecutive defeats; `> 4` opens the multi failure alert |
| `gold_bonus (#10, INT32)` | gold gained (not displayed by the battle) |
| `pet_gp_bonus (#11, INT32)` | pet EXP (never displayed) |
| `param1 (#12, INT32)` / `param2 (#13, INT32)` | Terrálem (3855) victory EXP / defeat percent |

Receiver `BaseManager.__battleInfoResultHandler` (`CM/yishi/manager/BaseManager.as:291, 2785-2795`) -> `BattleResultHandler.handler` (`CM/battle/handler/BattleResultHandler.as:575-620`): ignored if the own unit died in 295/3854 (`selfDie`), if `battle_id` repeats the previous battle, or if logged out. It waits up to about 3 s (101 x 30 ms) for running skills, then plays the screen and calls `exitBattle` (:93-551), whose destination depends on battleType ([battle-types.md](battle-types.md)). Send **after** 154 and after the last 153 has played (the mock waits 50 frames).

### 4.7 4166 (0x1046) U_B_FIGHT_CANCELED

No body read. `BaseManager.onFightCanceled` (`CM/yishi/manager/BaseManager.as:253-257, 303`) -> `BattleManager.onFightCanceled` (`CM/battle/BattleManager.as:106-121`): `exitBattle()` to the previous scene, `battleCancel`, `battleComplete`. Send when a battle is aborted before it ends (owner cancelled it, the opponent left a PvP before start, server shutdown).

### 4.8 4680 (0x1248) U_C_BATTLE_CLEAR_DEADLVING

`battle.LivingCleanMsg {livingInfos (#1, LivingInfoMsg, repeated)}`, `LivingInfoMsg {living (#1, INT32)}`. Processed only in battleTypes 295, 3854, 3911 by `BattleMapView.clearDiedRole` (`M10/battle/view/map/BattleMapView.as:62, 200-290`): removes dead heroes, pets and children after 1.5 s; if the own hero is listed in 295/3854, sets `selfDie` and cancels the battle locally (no 4103). Send in those modes when units die and should disappear (open world style battles).

### 4.9 171 (0x00ab) U_C_BATTLE_TALK

Plot dialog (`gameplot.PlotMsg`), owned by [../tutorial/README.md](../tutorial/README.md). `BattlePlotHandler` (`CM/battle/handler/BattlePlotHandler.as:27-103`) shows it when all skill queues are idle (311-313: immediately).

### 4.10 Spectator replies (no entry in `protocol/opcodes.csv`)

| Opcode | Message | Receiver | Meaning |
|---|---|---|---|
| 4803 U_CROSS_BATTLE_VIEW ("退出观战", `CM/yishi/datas/consant/ProtocolTypeTable.as:673`) | `simple.PropertyMsg`: `param1 (#1, INT32)` close type 1 = victory screen, 2 = defeat screen, other = exit silently; `param7 (#7, BOOL)` normal exit (re-check the list) | `BattleViewManager.onCloseBattleViewHandler` (`CM/managers/BattleViewManager.as:135-179`) | spectated battle ended or spectator kicked |
| 4804 U_CROSS_VIEW_BATTLE_INFO | `simple.PropertyMsg`: `param1 (#1, INT32)` ms before the battle can be watched; `param7 (#7, BOOL)` battle already over ("Competição encerrada") | `onGetBattleInfoHandler` (:116-133) | reply to 8985 type 0; with `param1 <= 0` the client sends the real view request |
| 4806 U_C_MULTI_LORDS_FIANL_ORDER | not parsed (`onGetBattleViewListHandler`, :110-114) | | list of final players (Titans) |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Clock | 25 frames/s, 40 ms per frame; frame 0 = the moment 156 is sent | `docs/battle/rules.md` §8; mock `server/src/battle.rs:8-9` |
| Packet release | at most 1 queued battle packet per client frame, first in arrival order with `extend2 <= clock` | `CM/battle/transaction/BattleTransactionManager.as:75-114` |
| Sync | per 153, `diff = msg.frame - clock`: `< -20` jump; `> 5` jump and skip stale queued skills; else move 20% | `CM/battle/handler/SkillProcessStrategy.as:18-68` |
| Packets queued | 4102, 153, 156, 159, 72, 69, 77, 4149, 4361, 4600, 4752, 4793, 4795, 4849, 4589, 4311, 4591 | `CM/yishi/service/managers/SocketManager.as:154-171` |
| Not queued | 154 (direct), 157 (direct), 171 (plot queue), 4103, 4166, 75, 158, 4680, boss HP syncs | same, :119-178 |
| Unhandled | 159 `U_B_GAME_OVER`, 4849 `U_B_RESTORE_HP`: never send | `docs/battle/rules.md` §1.5 |
| One battle at a time | a second 157 while a battle runs is queued client side but reprocessed with the last message (effectively broken): never send a new 157 before the previous 4103 / 4166 | `CGT:62-97` |
| End condition | one side has no living unit, or the time limit expires (mock: `count_down` seconds, highest HP ratio wins, tie to the defender) | `docs/battle/server-engine.md` §8 |
| End timing | 154 at `last action frame + duration + 25`; 4103 50 frames later | same |
| Result wait | client waits for running skills up to 101 x 30 ms before showing the result | `BattleResultHandler.as:622-633` |
| Result screen | detailed only for 16 and 10; Outyard views for 3855; else Simple; auto close 1 s after the animation | `BattleResultHandler.as:682-747` |
| Consecutive defeats | `fail_count > 4` -> alert after exit | `BattleResultHandler.as:775-781` |
| Exit scene | per battleType switch in `exitBattle` | `BattleResultHandler.as:93-551`; table in [battle-types.md](battle-types.md) |
| Rewards | granted by the owning feature; the battle report only summarizes `gp_bonus`, `gold_bonus`, `pet_gp_bonus`, `baseItem` | §4.6 |
| Disconnect | the mock aborts the battle on socket close | `server/src/game.rs:127-133` |
| Reconnect into a running battle | `loginToBattleFlag` forces `isNoCharge` and skips skills 1/2 (`BaseSkill.prepare`) | `CGT:180-183` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/MapInfos.xml` | battle map per `map_temp_id` | `Id`, `BattleGround` (scene art `sceneIma/<BattleGround>/map<id>.swf`), `MusicPath` |
| `raw/xml/tempinfos/SkillTempInfos.xml` | skill 3 "Vitória" (ActionId 3) used by 154 `calc_type 3` | `TemplateId`, `ActionId` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Imm_over_battle` = 10000 (finish now wait, ms) | `ConfigValue` |

## 7. Persistent state

Battles are runtime objects; persist only what must survive the battle or is needed for audit, rankings and the consecutive defeat counter. Schema `battle`.

```sql
CREATE SCHEMA IF NOT EXISTS battle;

CREATE TABLE battle.battles (
  battle_id        text PRIMARY KEY,
  battle_type      integer NOT NULL,
  owner_feature    text NOT NULL,
  owner_ref        text,
  map_template_id  integer NOT NULL,
  status           text NOT NULL CHECK (status IN ('pending','active','ended','cancelled','aborted')),
  seat_capacity    integer NOT NULL DEFAULT 1 CHECK (seat_capacity >= 1),
  count_down_ms    integer NOT NULL DEFAULT 0 CHECK (count_down_ms >= 0),
  rng_seed         bigint NOT NULL,
  config           jsonb NOT NULL,
  winner_side      smallint CHECK (winner_side IN (1,2)),
  end_frame        integer,
  created_at       timestamptz NOT NULL DEFAULT now(),
  started_at       timestamptz,
  ended_at         timestamptz
);
CREATE INDEX battles_type_created_idx ON battle.battles (battle_type, created_at DESC);
CREATE INDEX battles_active_idx ON battle.battles (status) WHERE status IN ('pending','active');

CREATE TABLE battle.battle_participants (
  battle_id      text NOT NULL REFERENCES battle.battles(battle_id) ON DELETE CASCADE,
  player_id      bigint NOT NULL REFERENCES player.players(player_id),
  side           smallint NOT NULL CHECK (side IN (1,2)),
  hero_living_id integer,
  is_spectator   boolean NOT NULL DEFAULT false,
  loaded_at      timestamptz,
  result         smallint CHECK (result IN (1,2)),
  max_combo      integer NOT NULL DEFAULT 0,
  damage_dealt   bigint NOT NULL DEFAULT 0,
  PRIMARY KEY (battle_id, player_id)
);
CREATE INDEX battle_participants_player_idx ON battle.battle_participants (player_id);

CREATE TABLE battle.battle_reports (
  battle_id       text NOT NULL REFERENCES battle.battles(battle_id) ON DELETE CASCADE,
  player_id       bigint NOT NULL REFERENCES player.players(player_id),
  battle_result   smallint NOT NULL CHECK (battle_result IN (1,2)),
  gp_bonus        integer NOT NULL DEFAULT 0,
  gold_bonus      integer NOT NULL DEFAULT 0,
  strategy_bonus  integer NOT NULL DEFAULT 0,
  pet_gp_bonus    integer NOT NULL DEFAULT 0,
  param1          integer NOT NULL DEFAULT 0,
  param2          integer NOT NULL DEFAULT 0,
  battle_scene    integer NOT NULL DEFAULT 0,
  fail_count      integer NOT NULL DEFAULT 0,
  pos_x           integer NOT NULL DEFAULT 0,
  pos_y           integer NOT NULL DEFAULT 0,
  items           jsonb NOT NULL DEFAULT '[]',
  sent_at         timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (battle_id, player_id)
);

CREATE TABLE battle.player_battle_stats (
  player_id             bigint PRIMARY KEY REFERENCES player.players(player_id),
  consecutive_failures  integer NOT NULL DEFAULT 0 CHECK (consecutive_failures >= 0),
  total_battles         bigint NOT NULL DEFAULT 0,
  total_victories       bigint NOT NULL DEFAULT 0,
  updated_at            timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE battle.battle_events (
  battle_id  text NOT NULL REFERENCES battle.battles(battle_id) ON DELETE CASCADE,
  seq        integer NOT NULL,
  frame      integer NOT NULL,
  opcode     integer NOT NULL,
  payload    bytea NOT NULL,
  PRIMARY KEY (battle_id, seq)
);
```

`battle_events` is optional: it stores the outgoing stream (157 to 4103) for spectators joining late, server side replays and bug reports. Purge with the battle (retention policy, assumption 7 days).

## 8. Backend implementation notes

- **Entry point for other features:** `battle::lifecycle::create(owner, BattleConfig) -> BattleId`. `BattleConfig` = battleType, map, sides with units ([units.md](units.md)), seat list, `count_down`, HurtUp settings, report builder callback, exit hooks. The owning feature validates its own costs before calling it and receives `on_end(BattleOutcome)` to grant rewards and build the 4103 fields.
- **Battle actor:** one task per battle (`tokio`), ticking every 40 ms with catch up (`MissedTickBehavior::Skip` plus simulate every missed frame, as `server/src/battle.rs:945-965`). All state is in memory; only §7 rows are written.
- **`battle::lifecycle::handle_load_over` (10007):** validate `battle_id` exists, sender is a participant, status `pending`; mark `loaded_at`; when all seats loaded (or after a 30 s load timeout, assumption) set `active`, `started_at`, send 156 `{frame 0, mainType = battle_type, count_down}` to every participant and spectator, start the actor.
- **`battle::lifecycle::handle_reinforce_load_over` (10018):** same validation; the battle is already `active`; send 156 with the current frame to that player only *(assumption)*.
- **`battle::lifecycle::handle_combo_count` (8282):** store `max_combo` on the participant row; forward to the owning feature.
- **`battle::lifecycle::handle_plot_finished` (10022):** resume a battle paused for a plot dialog (the actor stops the clock while a pause is pending, assumption).
- **`battle::lifecycle::handle_view` (8985):** spectator join (type 1/2): add a spectator, send 157 with `battle_from = 1` and the current unit state, then mirror the stream; type -1 removes; type 0 answers 4804.
- **`battle::lifecycle::handle_debug` (10003, 14002):** GM only.
- **End:** the actor detects the winner, sends 154 then 4103 per participant, in one transaction writes `battles` (status, winner, ended_at), `battle_participants.result`, `battle_reports`, updates `player_battle_stats.consecutive_failures` (reset on victory, +1 on defeat) and calls the owner's `on_end`. The 4103 `fail_count` is the updated counter.
- **Cancel:** owner or server abort -> 4166 to participants, status `cancelled`, no rewards.
- **Pushes to other players:** every 153/4102/gauge message goes to all participants and spectators of the battle; skill replies (75, 158, 4591) only to the requester.
- **Disconnect:** keep the battle running with the player's units on auto *(assumption; the mock aborts)*; on reconnect resend 157 with `use_way` 0 and the current state.

## 9. Open questions and assumptions

1. *(assumption)* 10018 is used for late joins and reinforcement entries; the original reply sequence is not visible in the client.
2. *(assumption)* load timeout and the behavior when a participant never sends 10007.
3. Whether the original server paused the clock during plot dialogs (10022 suggests yes).
4. 8282 reward semantics are unknown.
5. Spectator mode is unreachable in this client; opcodes 4803/4804/4806 are missing from `protocol/opcodes.csv` (names from `ProtocolTypeTable.as`).
6. Defeat skill 4 has no template locally: the original may have shipped one.
7. `view_side`, `strategy_bonus`, `sign_id` have no client use.

## 10. Implementation checklist

- [ ] `battle::lifecycle::create` API for owning features (config, seats, report callback)
- [ ] Battle actor: 40 ms tick with catch up, abort, disconnect policy
- [ ] Server message 157 with paging when the message is large
- [ ] Route 10007 -> `handle_load_over`; 156 after all seats loaded
- [ ] Route 10018 -> `handle_reinforce_load_over`
- [ ] Header `extend2` = release frame on 153/4102/154; 0 on others
- [ ] Server message 154 with at least one `calc_type 3`
- [ ] Server message 4103 per participant with owner provided bonuses and `fail_count`
- [ ] Server message 4166 on cancel; 4680 in 295/3854/3911
- [ ] Route 8282 -> `handle_combo_count`
- [ ] Route 10022 -> `handle_plot_finished`
- [ ] Route 8985 and replies 4803/4804 (low priority)
- [ ] Debug routes 10003/14002 behind GM flag
- [ ] Tables `battle.battles`, `battle_participants`, `battle_reports`, `player_battle_stats`, optional `battle_events`
- [ ] Rule: never send 159 or 4849; never send a new 157 before the previous end
- [ ] Test: full sequence 157 -> 10007 -> 156 -> 153... -> 154 -> 4103 with `node server/battletest.mjs`
- [ ] Test: time limit end, cancel (4166), consecutive defeats alert at 5
