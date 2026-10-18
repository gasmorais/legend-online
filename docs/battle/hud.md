# Battle HUD (Legend Online BR)

This document is the technical reference for the battle HUD of Legend Online BR, reconstructed from the decompiled
AS3 client. It specifies the display tree and z-order of the battle scene, the position and anchor of every HUD
element, the state machines behind auto-fight, "finish now" and the QTE, the bottom bar and skill bar variants per
battleType, damage numbers and unit overlays, boss panels and buffs, secondary views, the result screen and the HTML5
renderer preview. Battle flow, combat rules and server behavior are out of scope and are covered by the related
documents below.

Related documents:
- [README.md](README.md): battle overview (opcodes, model, attack pipeline, scene, end).
- [formation.md](formation.md): position grid, formations, camera, reinforcement, swap and revive.
- [rules.md](rules.md): network pipeline, conditionals, sequences and battleType effects.
- [server-engine.md](server-engine.md): mock battle server.
- [chess-modes.md](chess-modes.md): chess modes (Duelo Tático and Supremacia do Legend).
- [../client/renderer.md](../client/renderer.md): HTML5 renderer architecture.
- [../ui/screens.md](../ui/screens.md): non-battle screens.

## Contents

- [0. Reference: battleType and BattleModel predicates](#0-reference-battletype-and-battlemodel-predicates): battleType constants and the predicates the HUD reads.
- [1. Display tree and z-order](#1-display-tree-and-z-order): `BattleSceneView`, `BattleView`, `BattleUIView` creation order.
- [2. BattleUIView: elements, positions and anchors](#2-battleuiview-elements-positions-and-anchors): `layout()` branches, styles, auxiliary buttons, top panel.
- [3. State machines (BattleUIView side)](#3-state-machines-battleuiview-side): auto-fight, finish now, QTE trigger.
- [4. Bottom bar variants, SP and reinforcement animations](#4-bottom-bar-variants-sp-and-reinforcement-animations): `BottomBar` and its variants, vessels, awaken, reinforcement waves.
- [5. Main skill bar](#5-main-skill-bar-skillitemlistview-skillitemlistcontroller-battleskillitemii-cooldown): `SkillItemListView`, `SkillItemListController`, `BattleSkillItemII`, cooldown.
- [6. Skill bar variants](#6-skill-bar-variants-pet-childpve-childcommon-monster-avenger-petsacristy-warsoul): Pet, ChildPve, ChildCommon, Monster, Avenger, PetSacristy, Warsoul.
- [7. Damage numbers, QTE, skill name and unit layers](#7-damage-numbers-qte-skill-name-and-unit-layers): `DamageNumView`, `QteView`, `SkillNameView`, role views.
- [8. Boss and top panels, TeamStrip and buffs](#8-boss-and-top-panels-teamstrip-and-buffs): HP strips, boss panels, `TeamStrip`, buff icons.
- [9. Secondary views and map](#9-secondary-views-and-map): attack mode, combo, goddess, space-time, titan, damage increase, resistance, map layers.
- [10. Result screen (end of battle)](#10-result-screen-end-of-battle): opcode 4103, view selection, `exitBattle`.
- [11. battleType × HUD element matrix](#11-battletype--hud-element-matrix): HUD composition per battleType.
- [12. Consolidated findings and corrections to README.md](#12-consolidated-findings-and-corrections-to-readmemd): corrections, dead code, parity bugs, gaps.
- [13. HTML5 renderer preview](#13-html5-renderer-preview): viewer route, port files, real assets.

## Conventions

**Sources and references**
- All paths are relative to `decompiled/`: `core_module/scripts` is the core module, `m10/scripts` the battle module.
- A reference is written as a code span, `path/File.as:L` or `File.as:L-M`; several lines are separated by commas
  (`File.as:12, 40-52`). A bare `:L` refers to the file of the enclosing subsection (in §1 to §3,
  `BattleUIView.as` unless another file is named).
- §5, §6 and §10 define short path abbreviations at their start; §7 uses paths relative to `core_module/scripts/`
  when they start with `battle/` or `yishi/`.

**Markers**
- *(assumption)*: unconfirmed statement.
- [lib]: data from `web/public/lib/*/library.json` (helper export, not AS3).
- [SWF]: data read from the SWF timelines with `tools/swflib.py`, not from AS3.

**Scene variables**
- **W** = `_sceneWidth` = `limitRange(stage.stageWidth, 1000, 1500)`; **H** = `_sceneHeight` =
  `limitRange(stage.stageHeight, 600, 900)` (`m10/scripts/battle/view/ui/BattleUIView.as:766-767`; `limitRange` is a
  clamp, `core_module/scripts/battle/utils/Helpers.as:234`). Some sections write `sceneW`/`sceneH` or
  `sceneWidth`/`sceneHeight` for the same values.
- **s** = bottom-bar scale factor `0.85 + 0.15·(W-1000)/300` (`BattleUIView.as:786-787`): 0.85 at W=1000, 1.0 at
  W=1300, 1.1 at W=1500. §8 and §9 redefine s locally as `sceneWidth/1500` for the top panels.

**Terminology**
- **HUD element**: any display object shown over the battle map by `BattleUIView`, its bars or the role views.
- **view**: a display class (`*View`, `*Bar`, `*Strip`); **controller**: a non-display class that drives a view
  (`*Controller`, and `SelfSpView`/`ChildAwakenView`, which only place children into a parent).
- **layer**: a `LayerManager` layer (numbered, e.g. layer 3 = `_gameDynamicLayer`) or a container in the battle display tree.
- **battleType**: the `BattleModel.battleType` value; constants in §0.1. Written as a plain number (e.g. 3844) in tables.
- **frame**: a timeline frame or an `enterFrame` tick. `Loading.as` declares 25 fps for the stage; UI SWFs declare 24 fps (see §7 and §12).
- In-game strings (pt-BR, Chinese) are quoted verbatim.

---

## 0. Reference: battleType and BattleModel predicates

### 0.1 Constants (`core_module/scripts/yishi/datas/battle/BattleType.as:6-260`)

| value | constant | value | constant |
|---:|---|---:|---|
| 1 | RES_WILDLAND_BATTLE | 3843 | PLANES_WAR_BATTLE |
| 2 | NPC_WILDLAND_BATTLE | 3844 | REMOTE_PET_BATLE |
| 3 | TRE_WILDLAND_BATTLE | 3845 | CHILD_PVE_BATLE |
| 4 | CASTLE_BATTLE | 3846 | ROOM_BOSS_BATTLE |
| 5 | WILD_QUEUE_BATTLE | 3847 | CHILD_ARENA_BATLE |
| 6 | CAMPAIGN_BATTLE | 3848 | CROSS_MULTI_CAMPAIGN |
| 7 | BATTLE_DEBUG_BOSS | 3850 | MONOPOLY_MIRROR_BATTLE |
| 8 | BATTLE_DEBUG_MODE | 3851 | PERKIN_LAB_BATTLE |
| 9 | BATTLE_GUIDEBOOK | 3852 | CHANGE_DOUBLE_BOSS |
| 10 | BATTLE_MATCHING | 3853 | WEEK_FINAL_BOSS |
| 11 | BATTLE_MULTIPLAYER | 3854 | BLOODY_REALM_BATTLE |
| 12 | BOSS_BATTLE | 3855 | OUTYARD_BATLE |
| 13 | MULTIPLAYER_BOSS_BATTLE | 3857 | OUTYARD_ROUTE_BATTLE |
| 14 | USER_DEFINE_BATTLE | 3858 | OUTYARD_EXPLORE_BATTLE |
| 15 | SPECIAL_BOSS_BATTLE | 3859 | CROSS_ARESLORDS_BATTLE |
| 16 | BATTLE_CHALLENGE | 3860 | TITAN_LAND_BATTLE |
| 17 | WORLD_BOSS_BATTLE | 3861 | CROSS_BRAVE_BATTLE |
| 18 | NPC_FOLLOW_BATTLE | 3862 | FANTASY_MATRIX_BATTLE |
| 19 | HANGUP_PVP | 3863 | GLORY_ROAD_BATTLE |
| 20 | GUILD_TOTEM_BATTLE | 3864 | SHUTTLE_PET_BATTLE |
| 21 | ALTAR_BATTLE | 3865 | ARCANE_ZONE_BOSS_BATTLE |
| 22 | SECRECT_LAND | 3866 | SACRISTY_PET_BATLE |
| 23 | FAM_NPC_BATTLE | 3867 | ABYSM_BATTLE |
| 25 | TRIAL_TOWER_BATTLE | 3868 | CHILD_WAR_BATTLE |
| 32 | CROSS_WAR_FIELD_BATTLE | 3869 | LORD_TRIAL_BATTLE |
| 35 | PET_PK | 3870 | SPACE_TIME_BATTLE |
| 36 | PET__HUMAN_PK | 3871 | LORD_TRIAL_POINT |
| 38 | MINERAL_PK | 3872 | TIMEVORTEX_CRACK_BATTLE |
| 39 | CONSORTIA_FAM_LORDS_BATTLE | 3873 | TIMEVORTEX_BATTLE |
| 290 | KING_TOWER_BATTLE | 3874 | TIMEVORTEX_BATTLE_PLAYER |
| 291 | TREASUREMAP_BATTLE | 3875 | DRAGONTALKER_NODE |
| 293 | SINGLE_PASS | 3876 | DAY_LIGHT_BATLE |
| 295 | MOLONG_BATTLE / DROAGON_BATTLE | 3877 | PLANE_CRISIS |
| 296 | CROSS_CONSORTIA / CROSS_GUILD_BATTLE | 3878 | DUNGEON_TURN |
| 297 | CROSS_CONSORTIA_BOSS | 3879 | ECLIPTIC_PALACE |
| 305 | PETISLAND_BOSS_BATTLE / PETISLAND_RAGE_BATTLE | 3880 | DEMON_LAND |
| 306 | MONOPOLY_BATTLE_NORMAL | 3881 | GUILD_FB_BATTLE |
| 307 | MONOPOLY_BATTLE_HELP / _FIREND | 3882 | APEX |
| 308 | MULTILORDS | 3883 | DEEP_PRISION_BATTLE |
| 309 | CONSORTIA_EME_DREAM_BOSS_BATTLE | 3884 | MONSTER_EXPLORE_BATTLE |
| 310 | DOUBLE_BOSS_BATTLE | 3885 | DREAM_ARENA_BATTLE |
| 311 | DARK_DUST_MOUNTAINS_BOSS_BATTLE | 3886 | EASTER_BATTLE |
| 312 | REMAIN_TUNNEL_BOSS_BATTLE | 3887 | REVENGE_ROAD_BATTLE |
| 313 | REMAIN_HILL_BOSS_BATTLE | 3888 | REDEMPTION_ROAD_BATTLE |
| 314 | TEAM_AREAMAP4_MONSTER | 3889 | HELL_ABYSM_BATTLE |
| 315 | CROSS_MATELORDS_BATTLE | 3890 | GUILD_WANTED_BATTLE |
| 328 | TIMEARREST_BATTLE | 3891 | GLORY_GAME_BATTLE |
| 330 | GODS_BATTLE | 3892 | STAR_AREA_BATTLE |
| 349 | SELF_PROPELLED_CHESS_BATTLE | 3893 | INCREASINGLY_ROAD_BATTLE |
| 3840 | DUNGEON_MONSTER_BATTLE | 3894 | RUSH_CAMPAIGN_BATTLE |
| 3841 | WORLD_MAP_NPC | 3895 | EXPEDITION_BATTLE |
| 3842 | RANDOM_BOSS / RANDOM_BOSS_NPC | 3896 | CHILD_CAMP_BATTLE |
| | | 3897 | SHADOW_LAND_BATTLE |
| | | 3898 | DARK_MAZE_BATTLE |
| | | 3899 | REMAINS_EXPLORE_BATTLE |
| | | 3900 | REMAINS_MIRROR_BATTLE |
| | | 3901 | CONSORTIA_NEWBOSS_BATTLE |
| | | 3902 | ROYALTY_BOSS_BATTLE |
| | | 3903 | FORBIDDEN_BOSS_BATTLE |
| | | 3904 | SECRET_EXPLORE_BATTLE |
| | | 3905 | WARSOULTOWER_BATTLE |
| | | 3906 | FINAL_ROAD_BATTLE |
| | | 3907 | THESE_PVP_BATTLE |
| | | 3908 | SECRET_WAR_BATTLE |
| | | 3909 | MINOS_BATTLE |
| | | 3910 | CHESS_PVP |
| | | 3911 | CHILD_NS_WAR_BATTLE |
| | | 3912 | THESE_MultiPVP_BATTLE |
| | | 3913 | THESEUS_TOWER |
| | | 3914 | STORE_HOUSE |
| | | 3915 | DUNGEONEXPLO |

### 0.2 Predicates used by the HUD

| predicate | true for | source |
|---|---|---|
| `isChildBattle` | 3867, 3868, 3847, 3889, 3895, 3896, 3898, 3911 | `core_module/scripts/yishi/datas/BattleModel.as:514-549` |
| `isMonsterBattle` | 3884 | `BattleModel.as:551-557` |
| `isPvP()` | 35, 349, 3907 → true; 291, 39, 3844, 3847, 3867, 3868, 3870, 3872, 3873, 3875, 3845, 3889 → false; others: true if a hero (type≠3 and ≠2) exists on a different side from `selfHero` | `BattleModel.as:947-1023` |
| `isTrail()` | 25 | `BattleModel.as:1030-1033` |
| `isRaceAgainstTime()` | 3894 | `BattleModel.as:1070-1073` |
| `isForbiddenBoss()` | 3903 | `BattleModel.as:1075-1078` |
| `isWarSoulTower()` | 3905 | `BattleModel.as:1080-1083` |
| `isMultiPlayer()` | always **false** with `VersionSwitch.allAutoFight = true` (default, `core_module/scripts/yishi/datas/VersionSwitch.as:250`); otherwise `_isMultiPlayer` (battleCapity>1, or >1 non-monster/non-fake hero with Job≠10, or 3886; forced false in 306, 3850, 3900) | `BattleModel.as:882-889, 182-219` |
| `allowAutoFight` (static) | default true (`BattleModel.as:44`); becomes `!VersionSwitch.allAutoFight` (= false) on campaign maps "Taila", "WasteCampaign", "TrailTower" etc. | `m3/scripts/map/campaign/view/CampaignMapView.as:191-345`; reset to true in `core_module/scripts/map/campaign/CampaignManager.as:756` |
| `isControledByBoss()` | `bossControlLivingId == selfHero.livingId` | `BattleModel.as:1104-1111` |

**Local** predicates of `BattleUIView` (`m10/scripts/battle/view/ui/BattleUIView.as`):

| getter | battleType | line |
|---|---|---|
| `isBattleSign` | 16 | 1909-1917 |
| `isPetChallenge` | 35 | 1919-1926 |
| `isYLExpedtion` | 3896 | 1928-1935 |
| `isSpiritExpedition` | 3895 | 1937-1944 |
| `isDarkMaze` | 3898 | 1946-1953 |
| `isShadowLand` | 3897 (unused) | 1955-1962 |
| `isPetBatle` | 3844 | 1964-1971 |
| `isSacristyBatle` | 3866, 3864 | 1973-1980 |
| `isSelfChess` | 349 | 1982-1989 |
| `isSpaceTimeBattle` | 3870 | 1991-1998 |
| `isChildpveBatle` | 3845 | 2000-2007 |
| `isChildArenaBattle` | 3847 (unused) | 2009-2016 |
| `isMonopolyHelp` | 307 | 2018-2025 |
| `isNoHeroBattleType()` | 3847, 3845, 3844, 35, 3867, 3889, 3895, 3868, 3898, 3907 | 1527-1530 |

### 0.3 Spectator mode (`battle_from`)

- `BattlePrepareMsg.battleFrom` is stored in `BattleManager._curJoinType` (`core_module/scripts/battle/transaction/CreateGameTransaction.as:152-153`).
  With `battleFrom == 0` and no `selfHero`, `initBattleInfo` aborts (`CreateGameTransaction.as:154-160`).
- The only other use of `_curJoinType` is in chat (`core_module/scripts/chat/ChatSocketOutManager.as:85`). **No HUD view checks
  spectator mode**; the spectator HUD equals the player HUD.
- "Watch only" in the skill bar is per battleType: `isWatchOnly` = 35 or 307 (`core_module/scripts/battle/view/ui/SkillItemListController.as:514-524`).
- Leaving spectator mode (opcode 4803) accesses `battleUIView.finishNowBtn` inside `try/catch`
  (`core_module/scripts/managers/BattleViewManager.as:165-178`), but **BattleUIView has no public `finishNowBtn` getter**: the access throws
  and the exception is swallowed (the field is `private var _finishNowBtn`, `m10/scripts/battle/view/ui/BattleUIView.as:153`).

---

## 1. Display tree and z-order

### 1.1 Scene (`BattleSceneView`, `BATTLE_SCENE`)

Source: `m10/scripts/battle/BattleSceneView.as`.

Children, in `addChild` order:
1. `_backGround` = `ComponentFactory.creatCustomObject("battle.BattleBackGround")` (class `asset.battle.BattleBackGround`, `index/styles.json`) (:77-78).
2. `_view` = `new BattleView(_model)`, then `init()` and `addChild` (:79-81).

Behavior:
- Mouse disabled for the first 1 s after `enter` (:62-69).
- `layout()` (:131-151): `_view.x = 0` if `stageWidth < 1500`, else `stageWidth/2 - 750`; `_view.y = 0` if `stageHeight < 900`, else `stageHeight/2 - 450`.
  Background centered on the area: `_backGround.x = _view.x + sceneWidth>>1`, `y = _view.y + sceneHeight>>1`. The battle area is
  anchored top-left up to 1500×900 and centered above that.
- `enterOver` loads the UI package `battle2` (result) and, if battleType == 293, also `clearance` (:109-118).

### 1.2 `BattleView`

Source: `m10/scripts/battle/view/BattleView.as`.

`addChild` order in `init()` (:76-100):

| z | child | detail | line |
|---:|---|---|---|
| 0 | `_bitmap_background` (Bitmap) | blurred snapshot (`BlurFilter(10,10,1)`) of the main view at (-1,-1), refreshed by event `REFRESH_BACK_BITMAP` | :79-80, :322-335 |
| 1 | `_map` (`BattleMapView`) | map, units, effects | :81-83 |
| 2 | `_profoundLayer` (Sprite, no mouse) | "profound" effects layer | :84-86 |
| 3 | `_battleUI` (`BattleUIView`) | **the whole HUD** | :87-89 |
| 4 | `_redScreenEffect` (`RedScreenEffect`) | red flash; `resize(W,H)` | :93-94, :116-119 |
| 5+ | `_chatPop` (`BattleChatPopView`) | ally chat bubble (dynamic) | :148-177 |
| 5+ | `_goddessMovieView` (`BattleGoddessMovieView`) | goddess movie (event `GODDESS_GUARD_SKILL`, only with `VersionSwitch.GODDESS_OPEN`) | :357-373 |

- `scrollRect = (0,0,W,H)` on every resize (:102-120). `CAMERA_Y = 900 - H/2`, `CAMERA_X = 650` (:46-48, :109).
- During battle, `LayerManager` layer 4 (`GAME_UI_LAYER`, `core_module/scripts/com/pickgliss/ui/LayerManager.as:36`) is hidden (:97) and shown again in `dispose` (:393).
- `BattleChatController.getInstance().start()` (:99) adds **inside BattleUIView** (above all children created in the constructor):
  `_bugleView` (0,5), `_input` (centered, `y = sceneHeight - 230·(sceneWidth/1300)`, invisible until Enter), `_output`
  (x 0, just below the bugle): `core_module/scripts/battle/chat/BattleChatController.as:137-148, :172-189`.

**Chat bubble** (`core_module/scripts/battle/chat/BattleChatPopView.as`): only channel 6 (team) from a hero on the same side as `selfHero`
(`BattleView.as:148-177`), and only if `WorldBossHelper.checkNeedShowChatPop(mapId)` (:179-186). Position (0, H - displayHeight - 130).
Children: `asset.battle.ChatPopAsset` (background), `battle.ChatPopIcon` (circular mask r=23 at 26,25), `asset.battle.ChatPopIconBack`,
`battle.ChatPopName` (`"Nome:"`), text `ExpressionChatNotic` at (54,24), width 125, up to 44 chars + "......"
(`BattleChatPopView.as:47-115`). No head icon in 3866/3864 (:105-108). Closes itself after 5000 ms (:114).

**Units:** `BattleView.addRole` (:252-277) skips dead units (`bloodA <= 0`) in 295 and 3898 (:259-265); calls
`BattleUIView.addTeamStrip` for `HeroRoleInfo` with `type != 3` (non-boss) **except** in 16, 19, 32, 35, 36, 38, 306, 307
(`checkBattleType`, :288-309).

### 1.3 `BattleUIView`: creation order and z-order

Constructor: `init()` → `layout()` → `addEvent()` → "finish now" rules (`m10/scripts/battle/view/ui/BattleUIView.as:201-220`).
`init()` runs before `layout()`, so `W/H` are still NaN in `init`; all final positions are applied in `layout()`.

`addChild` order inside `init()` (:1159-1492). The condition column states when the child is added.

| z | field | class / style | condition | line |
|---:|---|---|---|---|
| 1 | `_selfGoddessTopView` | `BattleGoddessTopView(selfSide)`, y=-20 | `showGoddessTopAry()[0]` | :1212-1219 |
| 2 | `_vsGoddessTopView` | `BattleGoddessTopView(enemySide)`, y=-20 | `showGoddessTopAry()[1]` | :1220-1226 |
| 3 | `container` | `yishi.view.component.TileContainer` (rune/stone trigger skills) | always | :1227-1228 |
| 4 | `_warsoulEndBtn` | `battle.petChallenge.warsoulEndBtn` (IconButton) | battleType 3905 | :1252-1253, :1268-1271 |
| 5a | `_stripView` (+ `_finishNowBtn`, texts) and `_settingBtn` | `battle.petChallenge.finishNowBtnTip`, `battle.petChallenge.settingBtn` | 35, 307, 16 | :1272-1276 |
| 5b | `_petBar` | `PetBattleBar` | 3844 | :1277-1280 |
| 5c | `_sacristyBar` | `PetSacristyBar` | 3866, 3864 | :1281-1284 |
| 5d | `_childpveBar` | `ChildpveBattleBar` | 3845 | :1285-1288 |
| 5e | `_settingBtn` | `battle.petChallenge.settingBtn` | 3895, 3896, 3898 | :1289-1300 |
| 5f | `_childCommomBar` | `ChildCommonBottomBar` | `isChildBattle` (remaining: 3867, 3868, 3847, 3889, 3911) | :1301-1304 |
| 5g | `_monsterCommomBar` | `MonsterCommonBottomBar` | 3884 | :1305-1308 |
| 5h | `_battleSpaceTimeView` + `_bottomBar` | `BattleSpaceTimeView`, `BottomBar` | 3870 | :1309-1313 |
| 5i | `_bottomBar` | `BottomBar` | all others except 349 | :1314-1317 |
| 6 | `_dragonTitanOfTeamMate`, `_dragonTitanOfEnemies` | `DragonTitanTeamView(side)` | see §2.9 | :1318-1328 |
| 7 | `_hurtUpView` | `HurtUpView(battleModel.getHurtMode())` | `isPvP()` | :1329-1333 |
| 8 | `_trailCountView` | `TrailCountView` | `isTrail()` (25) or 3870 | :1334-1338 |
| 9 | `_trailCountView` + `_raceAgainstTimeUpView` | `TrailCountView`, `RaceAgainstTimeUpView` | 3894 | :1339-1345 |
| 10 | `_forbiddenBossUIView` | `ForbiddenBossUIView` | 3903 | :1346-1350 |
| 11 | `_trailCountView` | `TrailCountView` | 3905 | :1351-1355 |
| none | `_batterUIView` | `BatterUIView`, `visible=false`, y=174 | **never added** (see §2.12) | :1356-1358 |
| 12 | top panel (one of) | `RoleShowViewII` / `OutyardShowView` / `RoleShowViewIII` / `MutilBossShowView` | switch in §2.6 | :1365-1418 |
| 13 | `_resistUIView1`, `_resistUIView2` | `ResistUIView(1)`, `ResistUIView(2)`, invisible | always | :1359-1364, :1419-1420 |
| 14 | `_skillNameContainer` | `SkillNameContainer` | always | :1401, :1421 |
| 15 | `_chatMessageBtn` | `battle.chatMessageBtn` (MovieButton) | `thane.grades >= 6` | :1422, :1428-1431 |
| 16 | `_consortiaChatBtn` | `maintoolbar.ConsortiaChatBtn` (MovieButton) | `consortiaID > 0` | :1423, :1432-1435 |
| 17 | `_addSpBallLayer` | Sprite, no mouse (SP/hitPoint balls flying to the bar) | always | :1436-1438 |
| 18 | `_autoFightFlag` | bitmap `asset.battle.AutoFightFlagAsset` | only if auto-fight active (flag 1) | :1439, :1722-1730 |
| 19 | `_autoFightBtn` | `battle.AutoFightBtn2` (SelectedButton) | always (visibility set in layout) | :1440, :1445 |
| 20 | `_autoFightStrip` | `battle.autoFightStrip` (`mainBar.StripView`, tooltip zone) | always | :1441, :1446-1457 |
| 21 | `_hideOthersBg`, `_hideOthersBtn` | `battle.HideOthersBg` (Image), `battle.HideOthersBtn` (SelectedIconTextButton) | `thane.grades > 0` | :1458-1468 |
| 22 | `_teamStripContainer1`, `_teamStripContainer2` | `battle.teamStripContainer1/2` (VBox) | always | :1470-1473 |
| 23 | `_trailCountView` | `TrailCountView` | 295 | :1474-1480 |
| 24 | `_killSelfBtn`, `_immediatelyWinBtn` | `core.UseButton` | only `StageReferance.isDebug` | :1481-1491 |
| 25+ | chat (`_bugleView`, `_input`, `_output`) | ChatBar | always | `BattleChatController.as:175-177` |

Children added **later** (on top at the moment they are added):
- `_autoFightFlag` is moved back to the top on every auto-fight activation (:1727-1730).
- `_qteView` (`QteView`), on every skill with QTE (:1884-1897).
- `DragonTitanTeamView` and `BattleGoddessTopView` recreated on reinforcement (`BATTLE_REINFORCE_HANDLER`, :479-529).
- `BottomBar` (and variants) contains the skill bar (see §5).

### 1.4 Bottom bars: created vs. shown

`init()` creates (`m10/scripts/battle/view/ui/BattleUIView.as:1165-1196`):

| battleType | created | added (`addChild`) |
|---|---|---|
| 3844 | PetBattleBar | PetBattleBar |
| 3866, 3864 | PetSacristyBar | PetSacristyBar |
| 3845 | ChildpveBattleBar | ChildpveBattleBar |
| 3895, 3898 | nothing | only `_settingBtn` |
| 3896 | **ChildCommonBottomBar** (because `isChildBattle`) | only `_settingBtn`; the bar is orphaned |
| 3867, 3868, 3847, 3889, 3911 | ChildCommonBottomBar | ChildCommonBottomBar |
| 3884 | MonsterCommonBottomBar | MonsterCommonBottomBar |
| 3870 | BattleSpaceTimeView + BottomBar | both |
| 35, 349 | nothing | 35: "finish now" strip + setting; 349: nothing |
| 16, 307 | **BottomBar** | only "finish now" strip + setting; the BottomBar stays off-screen (but is used by `getAddSpDestPoint`, :1872-1876) |
| others | BottomBar | BottomBar |

---

## 2. BattleUIView: elements, positions and anchors

All positions below come from `layout()` (`m10/scripts/battle/view/ui/BattleUIView.as:759-1157`), called in the constructor and on every stage
`Event.RESIZE` (:311, :754-757).

### 2.1 Fixed elements (independent of bar type)

| field | x | y | line |
|---|---|---|---|
| `_batterUIView` | W - 280 | 174 | :770, :1358 |
| `_resistUIView1` | 280 | 185 (default); 250 in 295; 265 in `default` and in 310/3852 | :771, :1363, :1370, :1386, :1398 |
| `_resistUIView2` | W - 280 | 185 (default); 250 in 295; 215 in `default` and in 310/3852 | :772, :1364, :1371, :1387, :1399 |
| `_skillNameContainer` | W·0.5 | 270·(W/1500) | :773-774 |
| `_teamStripContainer1` | 1 (style) | 235 (style) | `index/styles.json` `battle.teamStripContainer1` |
| `_teamStripContainer2` | W - 190 | 235 (style) | :775 |
| `_qteView` | (W - qte.width)/2 | H - 280 | :776-780, :1895-1896 |
| `container` (trigger skills) | W/2 | H/2 + 100 | :781-785 |
| `_dragonTitanOfTeamMate` | 0 | H·0.5 - 130 | :1078-1082 |
| `_dragonTitanOfEnemies` | W - 120 | H·0.5 - 130 | :1083-1087 |
| `_selfGoddessTopView` | W/2 - 480 | -20 | :1088-1092 |
| `_vsGoddessTopView` | W/2 + 40 | -20 | :1093-1097 |
| `_hurtUpView` | W·0.5 - 30 | (own) | :1098-1101 |
| `_trailCountView` | W - 123 | 175 | :1102-1106 |
| `_battleSpaceTimeView` | (W - 187)/2 | (own) | :1107-1110 |
| `_raceAgainstTimeUpView` | (W - width)/2 + 45 | 0 | :1111-1115 |
| `_forbiddenBossUIView` | (W - width)/2 | -6 | :1116-1120 |
| `_killSelfBtn` (debug) | with BottomBar: `bottomBar.x + bottomBar.width·0.5 + 30`; without: W - 200 | H - 93 | :1125-1136 |
| `_immediatelyWinBtn` (debug) | = `_killSelfBtn.x` | `_killSelfBtn.y - 30` | :1137-1141 |
| `_autoFightFlag` | (W - width)·0.5 | 137·(W/1500); +30 if a top goddess exists **and** `_hurtUpView` is on screen; +80 in 3886 (only in the no-goddess branch) | :1143-1156 |

### 2.2 Bottom bar and buttons per `layout()` branch

Branches are mutually exclusive and evaluated in this order. Positions are `(x, y)` in `BattleUIView` coordinates.

**Branch A: 35, 307, 16, 3895, 3896, 3898** (:790-823). Anchor: the finish-now `_stripView` (`_finishNowBtn` is 200×57 per its style).
- `_stripView`: x = W·0.5 - 100 (half the button width), y = H - 57 + 5.
- `_hideOthersBg`: x = strip.x + 200 + 25; y = H - 57 - 20 in 3895, else H - 57 + 15.
- `_hideOthersBtn`: x = strip.x + 200 + 30; y = H - 57 - 15 in 3895, else H - 57 + 20.
- `_consortiaChatBtn`: x = strip.x + 100 - chatW/2 - 30; y = H - 57 - 8.
- `_chatMessageBtn`: x = strip.x + 100 - chatW/2; y = H - 57 - 10.
- `_settingBtn`: x = strip.x + 100 - chatW/2 + 30; y = H - 57 - 10.
- `_autoFightBtn` and `_autoFightStrip` invisible.
- In 3895, 3896 and 3898 `_stripView` exists and is positioned but is not in the tree (only 35/307/16 add it, :1272-1276).

**Branch B: 349 (chess)** (:824-849). `cx = W·0.5`; `L = 500·s`.
- `_hideOthersBg` (cx + L + 3, H - 45); `_hideOthersBtn` (cx + L + 8, H - 41).
- `_autoFightBtn`, `_chatMessageBtn`, `_consortiaChatBtn` and `_settingBtn` invisible. `_autoFightStrip` is **not** hidden.

**Branch C: 3844 (remote pet)** (:850-881). `_petBar` at (W·0.5, H), scale s.
- `_hideOthersBg` (petBar.x + 210s + 145, H - 60s - 5); `_hideOthersBtn` (petBar.x + 210s + 150, H - 60s).
- `_chatMessageBtn` (petBar.x + 210s - 67, H - 60s - 35); `_consortiaChatBtn` (petBar.x + 210s - 97, H - 60s - 33).
- `_autoFightBtn` and `_autoFightStrip` invisible.

**Branch D: 3866, 3864 (sacristy)** (:882-921). `_sacristyBar` at (W·0.5, H), scale s.
- `_autoFightBtn` computed at (sacristyBar.x + 210s + 70, H - 81), then made invisible.
- `_hideOthersBg` (… + 145, H - 60s - 5); `_hideOthersBtn` (… + 150, H - 60s).
- `_chatMessageBtn` (sacristyBar.x + 210s - 157, H - 60s - 35).
- `_consortiaChatBtn.visible = false`.

**Branch E: 3845 (child PvE)** (:922-953): same as C, with `_childpveBar`.

**Branch F: `isChildBattle`** (remaining 3867, 3868, 3847, 3889, 3911) (:954-992). `_childCommomBar` at (W·0.5, H), scale s.
- `_hideOthersBg` (bar.x + 210s + 35, H - 60s); `_hideOthersBtn` (bar.x + 210s + 40, H - 60s + 5).
- `_chatMessageBtn` (bar.x + 150s - 67, H - 60s - 35); `_consortiaChatBtn` (bar.x + 150s - 97, H - 60s - 33).
- **3911**: absolute x: `_chatMessageBtn` 948, `_consortiaChatBtn` 918, `_hideOthersBg` 1080, `_hideOthersBtn` 1086 (:983-989).
- `_autoFightBtn` and `_autoFightStrip` invisible.

**Branch G: 3884 (monster)** (:993-1024): same as F, with `_monsterCommomBar`.

**Branch H: `_bottomBar` (default and 3870)** (:1025-1077). `_bottomBar` at (W·0.5, H), scale s.
- `_autoFightBtn`: x = bottomBar.x + 500s + 10; y = H - 63. `_autoFightStrip` at the same position.
- `_hideOthersBg`: x = autoFightBtn.x + autoFightBtn.width; y = **H - 50** (overrides the H - 63 from :1035).
- `_hideOthersBtn`: x = autoFightBtn.x + autoFightBtn.width + 12; y = H - 45.
  (Without `_autoFightBtn`, which in practice always exists: `bottomBar.x + bottomBar.width·0.5 + 17/22`.)
- `_chatMessageBtn` (bottomBar.x + 210s - 67, H - 60s - 35); `_consortiaChatBtn` (bottomBar.x + 210s - 97, H - 60s - 33).
- `_warsoulEndBtn` (bottomBar.x + 500s + 10, H - 120), visible only in 3905 (:216-219).

After the branches:
- **295**: `_autoFightBtn` and `_autoFightStrip` invisible (:1121-1124).
- **3846**: the same are made invisible in `updateAutoFightBtn` (:1743-1746).

### 2.3 Styles of `BattleUIView`'s own elements (`index/styles.json`)

| style | type | relevant attributes |
|---|---|---|
| `battle.petChallenge.finishNowBtn` | IconButton | back `asset.battle.FinishNowBtnBg`, icon `asset.battle.FinishNowBtnTxt`, 200×57, filters Default/Light/Default/Gray |
| `battle.petChallenge.finishNowBtnTip` | Component | tooltip `yishi.view.tips.OneLineTip`, directions 0,4,5; x=75, y=187 (overridden in layout) |
| `battle.petChallenge.countdownTxt` | GradientText | colors 0xffffff/0xfffcd6/0xdba30d, ratios 0/80/250; x=12, y=20; field `battle.petChallenge.countdownTxt.txt` (110×22) |
| `battle.petChallenge.countdownNumTxt` | FilterFrameText | format `Arial,18,0xfff4c2,bold,left`, letterSpacing 1; 40×22 at (90,17) |
| `battle.petChallenge.settingBtn` | BaseButton | back `asset.battle.SettingBtnBmd`, tooltip OneLineTip; x=217, y=-100 (overridden in layout) |
| `battle.petChallenge.warsoulEndBtn` | IconButton | back `asset.battle.warsoulEndBtnBg`, icon `asset.battle.warsoulEndBtnTxt`, 190×46 |
| `battle.chatMessageBtn` | MovieButton | button `battle.chatMessageBtnMC`, tooltip OneLineTip |
| `maintoolbar.ConsortiaChatBtn` | MovieButton | button `maintoolbar.ConsortiaChatBtnAsset` (from the maintoolbar package) |
| `asset.battle.AutoFightFlagAsset` | bitmapData | top auto-fight banner |
| `battle.AutoFightBtn2` | SelectedButton | **unSelected** = `battle.CancelAutoFightBtn` (`asset.battle.CancelAutoFightAsset`); **selected** = `battle.SetAutoFightBtn` (`asset.battle.SetAutoFightAsset`) |
| `battle.autoFightStrip` | custom `mainBar.StripView` | tooltip OneLineTip, directions 0,5,4,6, gapH -5 |
| `battle.HideOthersBg` | Image | `asset.battle.HideOthersBg` |
| `battle.HideOthersBtn` | SelectedIconTextButton | check `asset.core.checkstyle_2.Selected/UnSelected`, text `battle.HideOthersTip` (x=20, y=2) |
| `battle.teamStripContainer1` | VBox | x=1, y=235, spacing 0 |
| `battle.teamStripContainer2` | VBox | y=235, spacing 0 |
| `core.UseButton` | TextButton | 110×28 (debug only) |

Strings (`index/language.json`, BR translation):
- `battle.petChallenge.countdownTxt` = "Contagem"; `task.view.TaskMobilePhoneView.Text1` = "segundos";
- `battle.petChallenge.countdownTxtTip` = "Poderá clicar em Encerrar em {0} segundos";
- `BattleUIView.vip3` = "Poderá usar se tiver VIP nv.3 ou acima"; `BattleUIView.vip3use` = "Clique para pular batalha";
- `battle.view.ui.BattleUIView.finishNowBtnClickTips` = "A calcular a Força de Combate, por favor aguarde";
- `battleUIView.warsoulTower.content.txt` = "Deseja encerrar o desafio atual? Caso encerre, você não poderá entrar novamente na Torre da Guerra hoje.";
- `battle.view.bottom.BottomBar.settingBtn.tipData` = "Configuração";
- `battle.view.ui.BattleUIView.msgBoxTip` = "Caixa de mensagens"; `consortiagroupchat.msgBoxItemNameTxt` = "Chat da Guilda";
- `store.view.StoreFrame.command01` = "Função habilitada no Nv. {0}" (used with 15);
- `battle.view.ui.BattleUIView.hideOthersTip` = "Ocultar unidades";
- `battle.view.ui.BattleUIView.command01` = "Essa batalha não pode entrar em combate automático".

### 2.4 Auxiliary buttons

- **Messages (`_chatMessageBtn`)**: rollOver opens `IMMsgBoxView` centered above the button, on layer 3 (:608-622); rollOut removes it after 300 ms
  (:630-639); click simulates a stage `keyDown` Enter (keyCode 13), opening chat input (:624-628). Blinks while
  `IMManager.friendBtnShining` (:650-662, event `MSGBOX_SHINING_UPDATE`, :323).
- **Guild chat (`_consortiaChatBtn`)**: opens `consortiagroupchat` (:641-648); blinks on `CHAT_FROM_CONSORTIA` (:316, :598-601, :664-676).
- **Settings (`_settingBtn`)**: opens the `"setting"` frame after 10 ms (:588-596).
- **War Tower end (`_warsoulEndBtn`, 3905)**: confirmation alert (`public.prompt` / `battleUIView.warsoulTower.content.txt`);
  on confirm, in 3905, sends **10497** (`SocketSendManager.sendRemoveBattle`, BattleReqMsg.battleId) (:567-586;
  `core_module/scripts/yishi/service/managers/SocketSendManager.as:499-505`).
- **Debug**: "自杀结束战斗" (lose) and "胜利结束战斗" (win) send **14002** `BattleReqMsg{battleId, otherObj}`, `otherObj` = 2 (lose) or 1 (win) (:1481-1491, :1532-1544).

### 2.5 Hide others (`_hideOthersBtn`)

- Initial state: `selected = SharedManager.hideOthersInBattle` (persisted) (:1461-1462). Shown only with `thane.grades > 0` (:1464-1468).
- Click: stores `SharedManager.hideOthersInBattle` and calls `saveHideOthersInBattle()`; `battleModel.otherLivingVisible = !selected` (:1786-1792),
  which fires `BATTLE_OTHER_LIVING_VISIBLE` (`core_module/scripts/yishi/datas/BattleModel.as:150-154`), heard by
  `BattleMapView` (`m10/scripts/battle/view/map/BattleMapView.as:61`) and `BattleGoddessMovieView` (`m10/scripts/battle/view/ui/BattleGoddessMovieView.as:58`).
- What hides: `BattleModel.isHideOtherInBattle` (`BattleModel.as:1113-1175`). With the option on:
  - Heroes, monsters, chess, pets and goddesses: hidden if not the player's, **and also** the player's own unit when `face == 2`.
  - Never hidden: bosses (`type == 3`) and soldiers with `MasterType > 100`.
  - Regular soldiers: hidden when `face != 1`.

### 2.6 Top panel (boss/target): `switch(battleType)` (:1365-1400)

| battleType | view | resistUI y (1 / 2) |
|---|---|---|
| 310, 3852 | `RoleShowViewIII` (two bosses) | 265 / 215 |
| 311, 312 | `MutilBossShowView(["asset.battle.BossShowRightAsset","asset.battle.LiteBossBloodBar_0"], [0,673])` | 185 / 185 |
| 313 | `MutilBossShowView(["asset.battle.BossShowRightAsset","asset.battle.LiteBossBloodBar_1","asset.battle.LiteBossBloodBar_1"], [0,790,790])` | 185 / 185 |
| 295 | `RoleShowViewII` | 250 / 250 |
| 3855 | `OutyardShowView` | 185 / 185 |
| 349, 3867, 3889 | **none** | 185 / 185 |
| any other | `RoleShowViewII` | 265 / 215 |

- `showTopView()` / `hideTopView()` (:1827-1865) toggle the panel; called by `ProfoundEffect`
  (`core_module/scripts/battle/skillsys/effect/ProfoundEffect.as:60, :93`) and `ProfoundEffectII` (:36, :50) during "profound" skills.
- `MutilBossShowView` (311-313): `updateMutilRoleShowView` (:1546-1560) builds the boss list from `battleModel._heroTempId`/`_life`
  (:1562-1612) and listens to opcode **4794** (`WorldBossInfoMsg`: currentMillis, curHp) (:1607-1610, :1614-1651):
  - 313: `battleModel.updateWorldBossBlood(curHp, millis)`;
  - 311/312: if HP rose by more than 60% of total → `resetRoleData`; else `playDamageNumEffect(templateId, loss)`; then fires `bloodChange`.
  - Also called by `SwapHandler` (`core_module/scripts/battle/handler/SwapHandler.as:160, :167`) and `ReviveHandler`
    (`core_module/scripts/battle/handler/ReviveHandler.as:86, :93`, with `true` = reset).
- Boss buffs: `reFreshBuffer` filters by `_roleShowII.livingId` and forwards to `bossBufferContainer` (:2027-2044; called by
  `core_module/scripts/battle/view/roles/RoleViewBase.as:634`). `refreshTurn` updates RoleShowViewII, both RoleShowViewIII
  containers and MutilBossShowView (:2046-2064; called by `RoleViewBase.as:667`).
- Boss reinforcement: `bossReinforce` and `setReinforceWaveInfo` forward to `RoleShowViewII` (:2074-2088; called by
  `core_module/scripts/battle/handler/ReinforceHandler.as:301` and `core_module/scripts/battle/transaction/ReinfoResTransaction.as:76`).

### 2.7 `TeamStrip` (teammate and enemy bars)

`addTeamStrip(HeroRoleInfo)` (:1653-1698), called by `BattleView.addRole` (`m10/scripts/battle/view/BattleView.as:269-272`, see §1.2).
- Skips: `isPetFake`, `isChildFake`, `MonsterRoleInfo`, `SelfChessRoleInfo` and battleType 3907 (:1660-1679).
- Own side: only heroes **of other users** (`heroInfo.userId != thane.userId`) → `new TeamStrip(info, 1)` in `_teamStripContainer1`
  (left VBox), keyed by userId (:1681-1693).
- Enemy side: all → `new TeamStrip(info, 2)` in `_teamStripContainer2` (right VBox, x = W - 190) (:1694-1697).
- `removeDieRole(userId)` removes only ally strips (:1700-1712); called on death by
  `m10/scripts/battle/view/map/BattleMapView.as:287`. Enemy strips are never removed.

### 2.8 Top goddess (`BattleGoddessTopView`)

`BattleFunctionHelper.showGoddessTopAry()` (`core_module/scripts/battle/utils/BattleFunctionHelper.as:281-379`) returns `[own, enemy]`:
- `[false,false]` if `!VersionSwitch.GODDESS_OPEN` (default true, `core_module/scripts/yishi/datas/VersionSwitch.as:120`).
- `[true,true]`: 11, 10, 3891.
- `[true,false]`: 13, 25, 3852, 3853, 3854, 3870, 3877, 3878, 3848, 3872, 3894.
- `[false,false]`: 1, 2, 3, 4, 5, 6, 7, 9, 12, 16, 17, 18, 23, 32, 293, 3843, 3851, 3855, 3857, 3858, 3859, 3862, 3863, 3864, 3865,
  3869, 3871, 3873, 3875, 3876, 3879, 3880, 3887, 3847, 3845, 3844, 35, 3867, 3868, 3874, 3860, 330, 3850, 19, 3885, 3889, 3890, 3897.
- Other types: if `battleCapity > 1` and the battle has a goddess → `[true,true]` when an enemy hero exists, `[true,false]` when only own heroes exist;
  else `[false,false]`.

`hasGoddessUI` = either of the two views exists (:1813-1820). Used to lower the auto-fight banner and by `HurtUpView`
(`m10/scripts/battle/view/ui/HurtUpView.as:218`).

### 2.9 Dragon titan (`DragonTitanTeamView`)

- Created in `init()` only if: `!isNoHeroBattleType()`, a hero with `titanId > 0` exists on either side (`hasTitanInThisBattle`, :1504-1525)
  and `ConfigManager.version_info.TAITAN_LOCK` (default true, `core_module/scripts/yishi/datas/VersionSwitchInfo.as:10`) (:1197-1211).
  - With an enemy hero: views on both sides.
  - Only own hero: own side only.
- On reinforcement (`BATTLE_REINFORCE_HANDLER`) they are created if missing, now **without** checking `TAITAN_LOCK`; the enemy view
  is **not** created in 3870 (:479-513).
- Positions: own (0, H/2 - 130); enemy (W - 120, H/2 - 130).

### 2.10 Rune/stone trigger skills (`container`)

- Opcode **541** (`TriggerSkillListMsg.skills`) → `ArmyManager._stoneTriggerSkill` → event `BATTLE_STONETRIGGER`
  (`core_module/scripts/yishi/manager/ArmyManager.as:178-188`) → `_showStoneTriggerSkill` (:429-472).
  - Empty list: clears and hides the container.
  - Per `TriggerSkillMsg`: `new BattleSkillItemII(5)`, `setState(0)`, `data = SkillTemplate(templatedId)`. If `coolDown` is set, overrides
    `data.CoolDown` and calls `cdStart(appearCoolDown, CoolDown)`. `appendItem(item, {width:44})`.
- Click → `ACTION_SKILL_BattleNotic` with the item (:474-477).
- `FORCE_SKILL_ENABLE` clears and hides the container (:392-399). Sent by RoleShowViewII/III, MutilBossShowView, OutyardShowView,
  MonsterCommonBottomBar, ChildCommonBottomBar and SelfBloodView (grep `"FORCE_SKILL_ENABLE"`).
- Position (W/2, H/2 + 100). `testTriggerskill` (:401-427) is test code, never called.

### 2.11 Resistance (`ResistUIView`)

- `SET_RESIST_VISIBLE` (sent by `core_module/scripts/yishi/datas/battle/ResistModel.as:59`) shows `_resistUIView1` (side 1) or `_resistUIView2`
  (side 2) via `show()` (:705-717).
- Ignored in 311, 312 and 313 (:707-710).

### 2.12 Combo (`BatterUIView`): **never displayed**

`_batterUIView` is created (:1356-1358) and reacts to `SET_BATTERUI_VISIBLE_BattleNotic` (sent by
`core_module/scripts/yishi/datas/battle/BatterModel.as:45, :71`):
- `true`: `lock = false`, `visible = true`, `show()`;
- `false`: `hide()` after 25 frames (`Helpers.delayCall` counts frames, `core_module/scripts/battle/utils/Helpers.as:89-101`).

But **there is no `addChild(_batterUIView)`** in BattleUIView (grep: only :99, :684-699, :770, :1356-1358, :2192-2196), and BatterUIView
does not add itself to any layer either (`m10/scripts/battle/view/ui/BatterUIView.as`: the only `parent` is in dispose, :173-175).
Result: the combo/total damage counter does not appear in this build.

---

## 3. State machines (BattleUIView side)

### 3.1 Auto-fight (`battle.AutoFightBtn2`, opcode 10020)

Model state: `BattleModel._autoFightFlag` (1 = auto, 2 = manual).
- Initial: `initAutoFight(BattlePrepareMsg.attackModel)` (`core_module/scripts/battle/transaction/CreateGameTransaction.as:122`).
  With `allowAutoFight == false`, forces `setAutoFight(2)`; in labyrinth with "hang up", forces 1 (`BattleModel.as:311-323`).
- `setAutoFight(n)`: ignored if unchanged or `isOver`; sends **10020** `AttackModeMsg{serverName, battleId, armyId, mode}`
  (`core_module/scripts/yishi/service/managers/SocketSendManager.as:383-392`) and notifies `autoFightChanged` (`BattleModel.as:296-309`).

View (`m10/scripts/battle/view/ui/BattleUIView.as`):

```
      click (enable && !(isMultiPlayer && battleType != 3886))
 MANUAL (flag 2) ─────────────────────────────────────────▶ AUTO (flag 1)
 btn.selected = true                                      btn.selected = false
 sprite SetAutoFightAsset                                 sprite CancelAutoFightAsset
 no top banner                                            addChild(AutoFightFlagAsset)
 _skillListOffsetX = 320                                  _skillListOffsetX = 0
            ◀──────────────────────────────────────────
                        click
```
- Transitions: `onAutoFightClick` (:1757-1779) calls `setAutoFight(2)` if flag is 1, else `setAutoFight(1)`. UI is updated by the
  `autoFightChanged` event → `updateAutoFightBtn(flag)` (:1714-1755), only if `!isOver`.
- In multiplayer (except 3886) the click shows `battle.view.ui.BattleUIView.command01` and keeps `selected = true` (:1764-1770).
  This never happens in practice: `isMultiPlayer()` is always false with the default `VersionSwitch` (see §0.2).
- `_skillListOffsetX` is computed but only feeds an unused local variable (:769) → *no effect*.
- **Enabling** (`battleAutoFightEnable`, :739-752):
  - leader level < 15 → disabled, and `_autoFightStrip` shows the tooltip "Função habilitada no Nv. 15" (:1448-1457);
  - `SKILL_ENABLE` event (:719-737):
    - `isMultiPlayer() || !allowAutoFight` → disables;
    - `isOver` → disables;
    - else, level ≥ 15 → enables;
  - **3886**: the setter forces `enable = true` whenever `!isOver` and level ≥ 15, even if asked to disable (:745-751);
  - `updateAutoFightBtn` disables when `isMultiPlayer() || !allowAutoFight` (:1742-1753).
- **Visibility**: only in branch H (BottomBar). Hidden in branches A, C, D, E, F and G, in branch B (button only), in 295 (:1121-1124) and in 3846 (:1743-1746).
- Gameplay effect: with auto-fight the QTE still appears, but the aim marker (`addSkillAimFlag`) does not (:1898-1901).

### 3.2 Finish now (`battle.petChallenge.finishNowBtn`, opcode 8727)

Exists only in 35 (pet PK), 307 (Monopoly help) and 16 (challenge). This is the only case where `_stripView` joins the tree (:1272-1276).

1. **Creation** (:1229-1267): `_finishNowBtn` (IconButton 200×57) inside `_stripView` (a Component that only provides the tooltip).
   - Texts: `"Contagem"` + number + `"segundos"`, all invisible. Initial number "10"; each text's x is chained by `textWidth` + 10 (:1238-1251).
   - `enable = false`.
   - Tooltip: `BattleUIView.vip3` if not a valid VIP≥3; else `countdownTxtTip(10)` (:1254-1266).
2. **Countdown start** (`showFinishBtn`, :222-251), called in the constructor if:
   - (35 or 307) and active VIP with `VipGrade >= 3` (:207-211);
   - or 16, always (:212-215).
   - Duration `N = parseInt(config "Imm_over_battle".ConfigValue)/1000`, default 10 s (:224-229).
   - Hides the button's icon (text), shows the 3 texts and starts `Timer(1000, N)`.
3. **Tick** (:253-269): number = `N - currentCount`, 2 digits ("09", "08"…); tooltip `countdownTxtTip(remaining)`.
   First tick fires only after 1 s; until then the number shows a fixed "10", even if N ≠ 10.
4. **End** (:271-307):
   - tooltip `BattleUIView.vip3use`;
   - `enable = true` if valid VIP≥3 **or** battleType 16;
   - shows the icon and discards the texts.
5. **Click** (:531-565): sound "022".
   - 16: `isFinishNow = true` and **8727** `BattleReqMsg{battleId}` (`m10/scripts/battle/net/BattleSocketOuterManager.as:43-49`).
   - Others: only with VIP≥3 → `isFinishNow = true` + 8727. In 307 it also posts to chat (channel 3) the message
     `finishNowBtnClickTips` ("A calcular a Força de Combate…").
   - Then always `enable = false`.
6. Without VIP≥3 in 35/307 the button stays disabled the whole battle, with the "VIP nv.3" tooltip.

```
 [disabled, VIP3 tooltip] --(35/307 with VIP>=3, or 16)--> [counting N s, texts visible]
 [counting] --timerComplete--> [enabled if VIP>=3 or battleType==16; tooltip "Clique para pular batalha"]
 [enabled] --click--> [sends 8727 if (battleType==16 || VIP>=3); disabled]
```

### 3.3 QTE (trigger in `BattleUIView`)

- Event `SHOW_SKILL_USE_SUCCESS_BattleNotic`, data `[skillInfo, qteTime, castTime, aims]`
  (`core_module/scripts/battle/view/ui/SkillItemListController.as:936`; also `MonsterCommonSkillItemListController.as:236` and
  `ChildCommonSkillItemListController.as:314`).
- If `qteTime > 0` and the player is not controlled by the boss: discards the previous QTE, `new QteView(data)`, `addChild` on top, at ((W - width)/2, H - 280) (:1884-1897).
- If not in auto-fight: `battleMap.addSkillAimFlag(aims)` (:1898-1901).
- `QteView`, `QTEComponent` and the full QTE state machine: §7.2.

---

## 4. Bottom bar variants, SP and reinforcement animations

Covers the classes in `m10/scripts/battle/view/bottom/`, `reinforce/` and `animation/`, plus `core_module/scripts/battle/view/animation/AddSpAnimation.as`. Styles were checked in `index/styles.json`, symbol dimensions in `index/ui_symbols.json` and pt-BR strings in `index/language.json`. The extracted layout (`m10.json`) matches the AS3 source in every class compared.

### 4.0 Shared context: who creates the bars and how they are positioned

**Bar selection (`m10/scripts/battle/view/ui/BattleUIView.as:1165-1196`)**, all with argument `SharedManager.instance.allowSceneEffect`, which becomes `_ballRotate`:

| Condition (if/else order) | Bar created | Line |
|---|---|---|
| `isPetBatle` (battleType == 3844, :1964-1971) | `PetBattleBar` | :1167 |
| `isSacristyBatle` (== 3866 or == 3864, :1973-1980) | `PetSacristyBar` | :1171 |
| `isChildpveBatle` (== 3845, :2000-2007) | `ChildpveBattleBar` | :1175 |
| `isSpiritExpedition` (3895, :1937) or `isDarkMaze` (3898, :1946) | no bar | :1177 |
| `battleModel.isChildBattle` | `ChildCommonBottomBar` | :1179-1181 |
| `battleModel.isMonsterBattle` (3884) | `MonsterCommonBottomBar` | :1183-1185 |
| `isSpaceTimeBattle` (3870, :1991) | `BattleSpaceTimeView` + `BottomBar` | :1187-1190 |
| not `isPetChallenge` (35, :1919), `isYLExpedtion` (3896, :1928) or `isSelfChess` (349, :1982) | `BottomBar` | :1192-1194 |

- `isChildBattle` is true for battleType 3867, 3868, 3847, 3889, 3895, 3896, 3898 and 3911 (`core_module/scripts/yishi/datas/BattleModel.as:514-549`).
- `isMonsterBattle` is battleType == 3884 (`BattleModel.as:551-558`).

**Added to display (`BattleUIView.as:1272-1317`):**
- 35, 307 (`isMonopolyHelp`, :2018-2025) and 16 (`isBattleSign`, :1909-1917): only `_stripView` and `_settingBtn`, no bar (:1272-1276).
- 3844 → `_petBar` (:1279); 3866/3864 → `_sacristyBar` (:1283); 3845 → `_childpveBar` (:1287).
- 3895, 3896, 3898: only `_settingBtn` (:1289-1300).
- `isChildBattle` → `_childCommomBar` (:1303); `isMonsterBattle` → `_monsterCommomBar` (:1307).
- 3870 → `_battleSpaceTimeView` and `_bottomBar` (:1311-1312).
- `!isSelfChess` → `_bottomBar` (:1316).

**Positioning (`layout()`, `BattleUIView.as:759-1077`; also called on stage resize, :754-757):**
- `_sceneWidth = limitRange(stageWidth, 1000, 1500)`, `_sceneHeight = limitRange(stageHeight, 600, 900)` (:766-767).
- Scale `s = 0.85 + ((W - 1000) / 300) * 0.15` (:786-787): 0.85 at W = 1000, 1.1 at W = 1500.
- Every bar sits at `x = W * 0.5`, `y = H`, `scaleX = scaleY = s`:
  - PetBattleBar: :854-858
  - PetSacristyBar: :886-890
  - ChildpveBattleBar: :926-930
  - ChildCommonBottomBar: :958-962
  - MonsterCommonBottomBar: :997-1001
  - BottomBar: :1027-1029
- Hence all bars use a bottom-center origin: background at `x = -w/2`, `y = -h`.
- With BottomBar, the auto-fight button is at `x = bar.x + 500 * s + 10`, `y = H - 63` (:1032-1034).
- Chat buttons at `bar.x + 210 * s - 60 - 7`, `y = H - 60 * s - 35` (:1064-1065). Child and Monster bars use base `150 * s` (:975, :1014).
- In 3911 positions are fixed: chat x = 948, consortia x = 918, hideOthersBg x = 1080, hideOthersBtn x = 1086 (:983-989).

**Useful getters:**
- `getBottomBar()` returns `_sacristyBar` for sacristy, else `_bottomBar` (:1804-1811).
- `getAddSpDestPoint()` and `getAddHitPointDestPoint()` use `_bottomBar.getSpGlobalPos()` and `getHitPointGlobalPos()` (:1872-1882).

None of these files references `isSpectator`, `battle_from` or `useWay`; `side` appears only in `ChildCommonBottomBar` (`selfSide`, :141).

### 4.1 Components

#### `BottomBar`

Source: `m10/scripts/battle/view/bottom/BottomBar.as` (extends Sprite). Created at `BattleUIView.as:1190` and :1194.

- Constructor takes `param1 = allowSceneEffect`, stored in `_ballRotate` (:66-75).
- `_selfInfo = battleModel.selfHero`, `_childInfo = battleModel.childHero` (:69-71). `childHero` is a public field, set at `BattleModel.as:436, 460` when the hero is `isFollowChild` and `!isSlavedChild`.

| field | class/style | x, y | z-order (addChild) | visibility/condition | events/opcodes |
|---|---|---|---|---|---|
| `_back` | `ComponentFactory.creat("asset.battle.BottomBack")`, 3-frame MovieClip (ui_symbols battle) (:79) | `x = -width*0.5`, `y = -height` (:81-82) | addChild(:84); ends at index 3 (see the z-order list below) | frame 1; frame 3 if `heroInfo.dragonTalkerInfo.isDragonTalker` (:92-101). `smoothing = true` (:80) | n/a |
| `_childAwakenView` | `new ChildAwakenView(this)` (:85) | MC at (214, -152) | `addChildAt(MC, 0)` + addChild(tip) | always created | updated by `AWAKEN` from `_childInfo` (:172, :284-292) |
| `_selfBloodView` | `new SelfBloodView(this)` (:86), default (-338, -116) | pool at (-338, -116) | `addChildAt(pool, 0)` + addChild(tip) | always | n/a |
| `_selfSpView` | `new SelfSpView(this, _selfInfo.spMax)` (:87); spMax default 100 (`HeroRoleInfo.as:27`) | pool at (246, -115) | `addChildAt(pool, 0)` + addChild(tip) | always | `sp` → `onHeroSpChanged` (:166, :278-282) |
| `_selfHitPointView` | `new SelfHitPointView()` (:88) | `(_back.x + 150, _back.y + 66)` (:89-90) | addChild (:95) | only if `isDragonTalker` (:93-97) | `HIT_POINT` (:168, :198-205) |
| `_avengerView` | `new AvengerBattleSkillView()` (:104) | `(_back.x - 110, _back.y + 100)` (:105-106) | addChild (:109) | `heroInfo.isAvenger && avengerFightSkills.length > 0` (:102) | `updateAvengerSp`, `updateAvengerSkills` (:107-108) |
| `_warsoulSkill` | `new SkillWarsoulView()` (:115) | (-235, -116) (:116-117) | addChild (:118) | `VersionSwitch.WARSOUL`, which is `true` (`core_module/scripts/yishi/datas/VersionSwitch.as:232`) | n/a |
| `_skillList` | `new SkillItemListView()` (:120) | (-235, -65) (:121-122) | addChild (:123) | always | `switchSkills(isPetState)` (:155, :304-307); `startAppearCd()` on `MORPH` (:294-302) |
| `_leftAwakenFigure` | `new SelfAwakenView(job)` in `redrawBack()` (:224-253) | job 1: (-357, -119); job 2: (-367, -119); others: (-362, -118) (:238-252) | addChild (:233) | `direction = 1` (:232) | space key forwarded (:207-217) |
| text bitmap 1 | `creatBitmap("asset.battle.BottomTextBack")`, 93x22 (:125) | `(_back.x + 154, _back.y + 178)` (:126-127) | addChild (:128) | always | n/a |
| text bitmap 2 | `new Bitmap` with same bitmapData (:129) | `(_back.x + 745, _back.y + 178)` (:130-131) | addChild (:132) | always | n/a |
| `heroSpNumContainer` | SelfSpView digits | see `SelfSpView` | addChild (:133) | always | n/a |
| `heroHpNumContainer` | SelfBloodView digits | see `SelfBloodView` | addChild (:134) | always | n/a |
| `_beliefView` | `new BattleBeliefProgressView()` (:137) | `(_back.x + 830, _back.y + 60)` (:138-139) | addChild (:140) | `GodDessManager.instance.isOpen` (:135) | n/a |
| `_bufferContainer` | `new SelfBufferView()` (:142) | (-190, -99); with WARSOUL (-165, -144) (:143-150) | addChild (:145) | always | n/a |
| `_settingBtn` | `creatComponentByStylename("battle.settingBtn")` (:151) | style x = 175, y = -95 | addChild (:152), last | always; tip `battle.view.bottom.BottomBar.settingBtn.tipData` = "Configuração" (:153) | click → `TimerUtils.setTimeout(openFrame, 10)` → `FrameControllerManager.openControllerByInfo("setting")` (:334-342) |

**Styles used:**
- `battle.settingBtn` = BaseButton, backStyle `asset.battle.SettingBtnBmd` (22x22), tip OneLineTip, `tipDirctions = 0`, `tipGapV = 5`, filters `core.DefaultFilter, core.LightFilter, core.DefaultFilter, core.GrayFilter`, x = 175, y = -95.
- `GodDessManager.isOpen` = `VersionSwitch.GODDESS_OPEN` (true, `VersionSwitch.as:120`) and `ArmyManager.thane.vocationGrades > 0` (`core_module/scripts/managers/GodDessManager.as:54-59`).

**Final z-order, bottom to top.** The first three enter via `addChildAt(…, 0)` after `_back`:
1. spPool
2. bloodPool
3. ChildAwakenMC
4. `_back`
5. ChildAwaken tip
6. blood tip
7. SP tip
8. hitPoint (conditional)
9. avenger (conditional)
10. warsoul
11. skillList
12. AwakenFigure
13. TextBack ×2
14. SP number
15. HP number
16. belief (conditional)
17. buffer
18. settingBtn

**`_back` dimensions:** not in the index. From the text offsets (+154/+745 in x, +178 in y, 22 px bitmap height) and the HP/SP numbers (x ≈ -340 and 248, y ≈ -19), the background is about 990 x 200 *(assumption)*.

**Events (`addEvent` :158-176):**
- settingBtn: `click`.
- `_selfInfo`: `sp`, `MORPH`, `HIT_POINT`.
- `_childInfo`: `AWAKEN`.
- `KeyboardManager`: `keyDown`. Only key 32 (space) is handled, forwarded to `_leftAwakenFigure.onKeyDown` (:207-217).
- `NotificationManager`: `sceneEffectClose` → `setBallRotation(false)` (:255-270). Dispatched by `core_module/scripts/battle/control/CancelBattleEffectController.as:151` and `m11/scripts/setting/SettingFrame.as:412/492/510`.

**Init:**
- `onHeroSpChanged(null)` (:111) and `__childAwakenChangeHandler(null)` (:112).
- `showVesselBall()` calls `showBall(_ballRotate)` for HP and SP (:272-276).

**Particle animation target points:**
- `getSpGlobalPos()` = `localToGlobal(280, -73)` (:309-312).
- `getHitPointGlobalPos()` = `localToGlobal(-330, -110)` (:314-317).

**Job used by the awaken figure:** `heroInfo.templateInfo.Job`, or `thane.templateInfo.Job` if no heroInfo; 100 becomes 1 (:226-230).

#### `SelfBloodView`

Source: `m10/scripts/battle/view/bottom/SelfBloodView.as` (extends Component). Created at `BottomBar.as:86` with defaults (-338, -116, 0) and at `PetSacristyBar.as:57` with (-238, -89, 1).

- Digit rect: `param4 == 1` → `Rectangle(-239, -12, 93, 18)`; else `Rectangle(-340, -14, 88, 18)` (:49-56).

| field | class/style | x, y | z-order | visibility | events |
|---|---|---|---|---|---|
| `_heroHpNumBmd` | `creat("asset.battle.SelfHpNumAsset")`, bitmap 150x16 (:63-64) | n/a | n/a | n/a | n/a |
| `_heroHpNumContainer` | `new Sprite()` (:65) | `x = rect.x + (rect.width - w) * 0.5`, `y = rect.y - 5` (:138-142) | added by parent | n/a | n/a |
| vessel line | `creat("asset.battle.VesselPoolLineMC")` (32 frames), `alpha = 0.6`, `ColorTransform(0.7, 0, 0)` (red) (:66-69) | inside VesselBallComp | n/a | n/a | n/a |
| `_bloodPool` | `new VesselBallComp(selfHero.totalBloodA, selfHero.bloodA, line)` (:70) | `(_x, _y)` (:71-72) | `_container.addChildAt(view, 0)` (:73) | n/a | n/a |
| `_tipView` | `creatCustomObject("battle.VesselBallTip")`, a StripView (:74) | at pool position (:79-80) | `_container.addChild` (:82) | transparent circle r = 46.5 centered at (46.5, 46.5) (:75-78) | tip `battle.view.bottomSelfBloodView.tip` = "Vida:Quando vida atingir 0, você morrerá" (:81) |

- Style `battle.VesselBallTip`: StripView, `tipStyle = yishi.view.tips.MultipleLineTip`, `tipWidth = 150`, `tipGapV = 0`, `tipGapH = -10`, `tipDirctions = 0`, w = 80, h = 22.

**States:**
- `enterFrame` (:87): if `battleModel.isChildBattle`, return (:97-100).
- Else, every frame reads `battleModel.getMyHeroLeftHp()` (= `selfHero.bloodA`, `BattleModel.as:832-835`) and calls `updateHeroHp` (:101-102).
- If HP <= 0: `battleModel.isOver = true` and `sendNotification("FORCE_SKILL_ENABLE", false)`, repeated every frame (:103-107).
- `updateHeroHp(v)` (:125-136):
  - exits if value unchanged; initial value 0;
  - `_bloodPool.max = totalBloodA`;
  - draws the number with `NumberViewUtils.getNumberView(v, container, bmd, 15, 16, 10, 15, "0123456789.", 1)`: 15x16 glyphs, 10 px advance per char, glyph source at `idx * 15`, no leading zero since `param9 = 1`;
  - negative values clear the number (`core_module/scripts/yishi/utils/NumberViewUtils.as:192-223`);
  - then centers and calls `_bloodPool.update(v)`.
- `showBall(rot)`: `creat("asset.battle.BloodPoolBallMC")` wrapped in `SimpleBitmapMovieClip`, then `_bloodPool.showBall(ball, rot)` (:118-123).

#### `SelfSpView`

Source: `m10/scripts/battle/view/bottom/SelfSpView.as`. Not a DisplayObject: a controller that places elements into `_container`.

- Created at `BottomBar.as:87` with `(this, spMax)` and at `ChildCommonBottomBar.as:68, 93` with `(this, 100, 145(+54), -90)`.
- Defaults: `spMax = 100`, `x = 246`, `y = -115` (:43). Digit rect: `(248, -14, 88, 18)` (:50).

| field | class/style | x, y | z-order | events/tip |
|---|---|---|---|---|
| `_heroSpNumBmd` | `creat("asset.battle.SelfHpNumAsset")` (:56) | n/a | n/a | n/a |
| `_heroSpNumContainer` | Sprite (:58) | `x = 248 + (88 - w) / 2`, `y = -19` (:104-108) | added by parent | n/a |
| line | `creat("asset.battle.VesselPoolLineMC")`, `alpha = 0.6`, no colorTransform (:59-60) | n/a | n/a | n/a |
| `_spPool` | `new VesselBallComp(_spMax, battleModel.selfHero.awaken, line)` (:61-62) | `(_x, _y)` (:63-64) | `addChildAt(view, 0)` (:65) | n/a |
| `_tipView` | `creatCustomObject("battle.VesselBallTip")` (:66), circle r = 46.5 (:67-70) | at pool position | addChild (:74) | tip = `…SelfSpView.tipView.tipData01` + `…tipData02` = "Fúria:" + "Utilização de habilidades consome fúria" (:73) |

**States:**
- `_heroSpValue` starts at -1.
- `updateHeroSp(v)` draws the number with the same params as HP and calls `_spPool.update(v)` (:92-102). No tween on the number, only on the vessel level.
- `set visible` toggles number, pool and tip (:120-135). No callers in the files examined.
- `showBall`: `creat("asset.battle.AngerPoolBallMC")` in `SimpleBitmapMovieClip` (:85-90).

#### `VesselBallComp`

Source: `m10/scripts/battle/view/bottom/VesselBallComp.as`. The 93 px circular "vessel".

- Created by `SelfBloodView.as:70`, `SelfSpView.as:62`, `MonsterSelfBloodView.as:68` and `ChildSelfBloodView.as:68`.

**Structure (`init`, :45-55):**
- `_view` (Sprite) holds `_container` and `_mask`.
- `_mask` is a black circle r = 46.5 centered at (46.5, 46.5) (:66-74), masking `_container`.
- `_container` holds `_line`.

**Line level (`calculateY`, :106-119):**
- `y = 93 * (max - curr) / max`.
- If `y <= 0`, use -10: line goes above the top, vessel looks full.
- If `y > 93`, use 93.
- `initLinePos`: sets `y`, hides the line if `curr == 0` (:57-64).

**Update (`update(v)`, :76-92):**
- Ignored if value unchanged.
- If `v > 0`, shows the line.
- Tween `TweenLite.to(_line, 0.5, {y: calculateY(), onUpdate: updateBallMask, onComplete: onChangeComplete})`, default TweenLite ease (Quad.easeOut) *(assumption: lib version)*.
- `onChangeComplete` hides the line if `curr == 0` and kills tweens (:94-104).

**Ball (`showBall(ball, rot)`, :121-145):**
- Discards the previous ball.
- New ball at (46.5, 46.5), added via `_container.addChildAt(ball, 0)`, behind the line.
- `_ballMask` = rect `(0, -93, 93, 93)` placed at `y = 93`, so it grows upward from the bottom.
- `ball.mask = _ballMask`.
- `updateBallMask`: `_ballMask.height = 93 - _line.y` (:167-173). The ball shows only below the liquid surface.

**Rotation:**
- If `rot` is true, `enterFrame` does `ball.rotation += 1` (1° per frame) (:140-143, :162-165).
- `setRotation(bool)` toggles that listener (:147-160).

**Other:** `set max` (:180-183); `BALL_WIDTH = 93` (:14).

#### `SelfHitPointView`

Source: `m10/scripts/battle/view/bottom/SelfHitPointView.as` (Component). Created at `BottomBar.as:88`; shown only for Dragon Talker.

| field | class/style | x, y | z-order | details |
|---|---|---|---|---|
| `_hitPointMc` | `creat("asset.battle.HitPointMC")`, 6 frames (:28) | (0, 0) | addChild (:35) | `gotoAndStop(1)` (:30) |
| `_tipView` | `creatCustomObject("battle.HitPointTip")`, StripView (:29) | transparent rect (0, -5, 118, 30) (:31-33) | addChild (:36) | tip `…SelfHitPointView.tipView.tipData01` + `tipData02` = "Pontos de ATQ:" + "Parte da Habilidade do Dragão necessita consumir pontos de luta." (:34) |

- Style `battle.HitPointTip`: MultipleLineTip, `tipWidth = 150`, `tipGapH = -10`, w = 118, h = 30.
- `updateHeroHitPoint(v)`: frame = `v + 1` (:54-62). `hitPointMax = 5` (`core_module/scripts/yishi/datas/objects/HeroRoleInfo.as:31`), so frames 1 to 6. `updateHitPoint` clamps to 0..max (`HeroRoleInfo.as:204-215`).

#### `SelfAwakenView`

Source: `m10/scripts/battle/view/bottom/SelfAwakenView.as` (Component). The awaken / pet-morph figure.

- Created at `BottomBar.as:231`. Also used by the tutorial: `m8/scripts/mediators/NewbieBaseActionMediator.as:1356` via `activeAwakenFigure`.

**Constructor (:78-113):**
- job 100 becomes 1 (:81-84).
- `_hasPet = selfHero.petRoleInfo != null` (:89-92); without pet, `mouseEnabled = false` (:93-96).
- If Dragon Talker, `_job = 4` (:97-100).
- `mouseChildren = false`.
- Tooltip: `tipStyle = "yishi.view.tips.OneLineTip"`, `tipDirctions = "0"`, `tipGapH = 0`, `tipGapV = 5`, `isFollowMouse = false` (:104-109).
- Calls `enable()`, `updateStateTxtView()`, `updateTips()`.

**initView (:115-180):**
- `_figureContainer` (Sprite) added first (:117-118).

*With `ArmyManager.thane.grades >= 50` (:119):*

| field | style | position | parent and order |
|---|---|---|---|
| `_figureMc` | `creat("asset.battle.AwakenProgress50" + job)`, e.g. `AwakenProgress501` (SWF `battlejob50X`, 100 frames) (:121) | `x = -(width >> 1)` (:124) | `_figureContainer`, 1st |
| `_poolLine` | `creat("asset.battle.VesselPoolLineMC")` (:125) | `x = -(w >> 1) + 15`, `alpha = 0.6` (:141-142) | `_figureContainer`, 2nd (:129) |
| `_mask` | `creat("asset.battle.AwakenMask" + job)` (:126) | `x = -(w >> 1)` (:140) | `_figureContainer`, 3rd (:133); `_poolLine.mask = _mask` (:132) |
| `_awakenBgMc` | `creatCustomObject("battle.PetAwakenEffect")`, 25 frames, style x = 0, y = 19 (:127) | y per job (below) | `this`, after the container (:130) |
| `_awakenTxtMc` | `creatComponentByStylename("battle.awakenImage")`, ScaleFrameImage with frame 1 = `asset.battle.PetAwakenTxt`, frame 2 = `asset.battle.PetAwakenCancelTxt`, style x = 99, y = -10 (:128) | `x = -(w >> 1)` (:139) | `this`, last (:131) |

- The last two start invisible (:137-138).
- Mask dimensions: job 1 = 116 x 92.55; job 2 = 105 x 106.95; job 3 = 90.2 x 99.5; job 4 = 109 x 120 (ui_symbols).

Per-job offsets (`switch(_job - 1)`, :143-171):

| job | `_awakenBgMc.y` | `_awakenTxtMc.y` | `_mask` | `_poolLine` |
|---|---|---|---|---|
| 1 | 26 | -2 | y = 24 | y = 117 |
| 2 | 19 | -10 | x = -60, y = 12 | y = 117 |
| 3 | 20 | -8 | y = 19 | y = 117 |
| 4 | 8 | -20 | x = -70, y = 0 | x = -70, y = 117 |

*With `grades < 50`:* only `_figureMc = creat("asset.battle.AwakenProgress" + job)` (:173-179). No line, mask or text.

**Value and frame:**
- Fixed max 3000.
- Frame = `floor(awaken * 100 / 3000)`, 0 to 100 (:542-543).
- `updateTo(v)` applies directly (:476-481).
- `tweenTo(v)` (:483-510): `TweenMax.to(_figureMc, 0.5, {frame, onUpdate: tweenUpdate, onComplete: tweenCompleted})`. If `v == 0`, calls `update()`.
- `tweenUpdate`: `_poolLine.y = _figureMc.y + _figureMc["pos"].y` (:630-640). The line follows a "pos" marker inside the MC.

**refreshMc (:534-594):**
- `full = awaken >= 3000`.
- `_figureMc.bg` visible and playing when full; else stopped on frame 1.
- `body.play()` always; `_poolLine.play()` always.
- `ball1` to `ball4` visible and playing only when full.
- `_poolLine` invisible if `awaken == 0`.

**Player use (`enable()`, :708-742):**
- `buttonMode = false`, `dark()`, `mouseOut()`.
- Returns if `isRestrict` (no hero, `restricted` or `!isLiving`) (:744-755).
- Usable if `!useSkill700001 && !useSkill700002 && (canMorph || canCancelMorph)`.
- `canMorph` = `!isPetState && awaken == 3000`; `canCancelMorph` = `isPetState && awaken > 0` (`HeroRoleInfo.as:459-467`).
- If `isRight` (`direction != -1`) and usable, `buttonMode = true`. If usable, `light()`.
- Dead hero calls `stopMc()`; alive calls `refreshMc()`.
- `dark()` applies `ColorTransform(0.75, 0.75, 0.75)` to `_poolLine` and `_figureMc.body`; `light()` restores (:762-788).

**Mouse:**
- Hover with `buttonMode`: `Mouse.cursor = "button"` and `SimpleBuildingFilter.setBuildingOverFilter(this)` (:358-377, :398-402).
- Out: cursor `"auto"`; dead hero gets `filters = [UIFilter.getBlackFilter()]` (:404-415).
- `rollOver` calls `update()` (:389-396).

**Click (:245-299):**
- Preconditions: `isRight`, `!isOver`, hero present, `!restricted`, `bloodA > 0`, `buttonMode`, `!useSkill700001`, at least 3000 ms since last click.
- If `canMorph`: `sendNotification("ACTION_SKILL_BattleNotic", SkillTemplate 700001)`.
- If `canCancelMorph`: same with 700002.
- If `getAutoFightFlag() == 1`, calls `setAutoFight(2)` (:295-298).
- Server send: `SkillItemListController.__skillUse` → `SocketSendManager.gameCommand` → **opcode 10008** (`core_module/scripts/battle/view/ui/SkillItemListController.as:631-711`; `core_module/scripts/yishi/service/managers/SocketSendManager.as:208-210`). The controller ignores battleType 3844, 3845, 3847, 16, 3868 and `isChildBattle` (:647-670).

**Space (`onKeyDown`, :301-356):**
- Same conditions as click, plus `_skillEnable`. That flag is set by `SKILL_ENABLE` with `data == true` (:217-224), sent at `core_module/scripts/battle/handler/ReinforceHandler.as:306`.
- **Only morphs (700001); never cancels.**

**Listened events (:182-196):**
- `this`: `click`, `mouseMove`, `rollOut`, `rollOver`.
- `_hero`: `AWAKEN` → `tweenTo(awaken)` (:417-420); `isLiving` → clears flags, calls `stopMc` and `update` (:422-431).
- `NotificationManager`: `battleComplete` and `restrictChanged` → `update`.
- `skillCd`: with skillId 700001 or 700002, clears the matching flag (:438-451).
- `USE_SKILL_RESULT`: on false result, clears the flag (:453-469).
- `SKILL_ENABLE`; `ACTION_SKILL_BattleNotic` → sets `useSkill70000x` (:226-243).

**State text (`updateStateTxtView`, :642-706):**
- Hides everything; if `isRestrict`, returns.
- `canMorph && !use1`: glow `_awakenBgMc` visible and playing; text on frame 1 ("Despertar").
- `canCancelMorph && !use2`: text on frame 2 ("cancelar"), no glow.
- `direction == -1` mirrors the container (`scaleX = -1`) and hides glow and text (:835-851).

**Tooltip (`updateTips`, :600-623):**
- Without pet, tooltip is empty.
- With pet: `GetTranslation("public.colon", GetTranslation("battle.awaken"))` = "Despertamento:", then `<font face='Arial'>{cur} / 3000</font>`.
- If `isRight`, appends `"\n"` + `SelfAwakenView.spaceKey2` ("Clique para Libertar") when `canCancelMorph`, else `SelfAwakenView.spaceKey` ("Atalho do Despertamento: Espaço").

**`show()`:** `LayerManager.addToLayer(this, 3, true)` (:825-828). No usage found in the files examined.

#### `ChildAwakenView`

Source: `m10/scripts/battle/view/bottom/ChildAwakenView.as`. Not a DisplayObject. The "Guardião" (child) gauge.

- Created at `BottomBar.as:85`, always, with `awakenMax` default 100 (:35).

| field | style | x, y | z-order | details |
|---|---|---|---|---|
| `_childAwakenNumBmd` | `creat("asset.battle.SelfHpNumAsset")` (:47) | n/a | n/a | n/a |
| `_childAwakenNumContainer` | Sprite (:49) | rect (190, -95, 88, 18), centered with y - 5 (:40, :111-115) | **never added by anyone** | n/a |
| `_awakenMovie` | `creatCustomObject("asset.battle.ChildAwakenMC")`, 100 frames (:50) | (214, -152) (:51-52) | `addChildAt(…, 0)` (:53) | children `content.bg` and `effect` |
| `_tipView` | `creatCustomObject("battle.ChildAwakenTip")`, StripView (:54) | (214, -152), transparent circle r = 75 (:55-60) | addChild (:62) | tip = `…ChildAwakenView.tipView.tipData01` + " " + `tipData02` = "Capacidade do Guardião, Quando o slot de carregamento de energia ficar cheio, poderá liberar habilidades de Guardião Ex., Teclas R, F" (:61) |

- Style `battle.ChildAwakenTip`: MultipleLineTip, `tipWidth = 150`, w = 80, h = 22.

**`updateChildAwaken(v)` (:65-92):**
- Frame = `ceil(v * 100 / max)`, clamped to 0..100.
- `_awakenMovie.gotoAndStop(f)` and `_awakenMovie.content.bg.gotoAndStop(f)` (:94-101).
- `effect.visible = (v >= max)` (:84-91, :103-109).
- Called with 0 in the constructor (:42).

#### `BattleBeliefProgressView`

Source: `m10/scripts/battle/view/bottom/BattleBeliefProgressView.as` (Component). Shows the goddess "belief".

- Created at `BottomBar.as:137` if `GodDessManager.isOpen`.

| field | style | x, y | z-order |
|---|---|---|---|
| `_progressMc` | `creatCustomObject("BattleBeliefProgressView.progressMc")`, class `asset.BattleBeliefProgressView.progressMc` (:37) | style (0, 0) | 1st (:40) |
| `_numberBitmap` | `creatBitmap("asset.BattleBeliefProgressView.numberBitmap")`, 130x18 (:38) | not added | n/a |
| `_beliefContiner` | `creatComponentByStylename("BattleBeliefProgressView.beliefContiner")`, Component (:39) | style (78, 36); then x = 85 if belief < 10, else 78 (:75) | 2nd (:41) |

**Init:**
- `beliefMax = ConfigInfoManager.getBattleGoddessMaxBelief()` (:42).
- `progress` on frame 1; `fullMc1` and `fullMc2` invisible and stopped (:43-48).
- Number "0" drawn with `getNumberView(0, …, 13, 18, 10, 13, "0123456789", 0)`: 13x18 glyph, advance 10 (:49).

**Event:** `MsgMan.addObserver("GODDESS_BELIEF_CHANGE", …)` (:54). Also called manually in the constructor (:32).

**Handler (:62-105):**
- Exits if no `goddessRoleInfo` or `belief == _preBelief` (initial 999).
- `value = belief > beliefMax ? 120 : belief`; `frame = max(1, int(value / 2))`.
- Redraws the number and repositions x.
- If value dropped: `progress.gotoAndStop(frame)`.
- If it rose: `addFrameScript(frame - 1, stop)`, then `_progressMc.play()` and `progress.play()`, animating up to the target frame.
- With `belief >= 100`: `fullMc1` and `fullMc2` visible and playing from frame 1; else invisible and stopped.

#### `ChildCommonBottomBar`

Source: `m10/scripts/battle/view/bottom/ChildCommonBottomBar.as` (Component). Bar for Guardião battles (`isChildBattle`).

- Created at `BattleUIView.as:1181`.
- Hero is `battleModel.selfChildHeroInfo`: the player's own HeroRoleInfo with `isManualChild` (`BattleModel.as:1212-1224`).

**Branches (:58-98).** The nswar branch is `battleType == 3911`, with `_loc2_ = 54`.

| element | style | 3911 | others |
|---|---|---|---|
| `_back` | `creatBitmap` | `"asset.battle.nswarBg"` (622x97) (:66) | `"asset.battle.AbysmBattleBack"` (514x97) (:91) |
| `_selfBloodView` | `new ChildSelfBloodView(this, …)` | (-292, -91) (:67) | (-238, -91) (:92) |
| `_selfSpView` | `new SelfSpView(this, 100, …)` | (199, -90) (:68) | (145, -90) (:93) |
| `_skillList` | `new ChildCommonSkillItemListView()` (:62) | (-189, -65) (:69-70) | (-135, -65) (:94-95) |
| `_leftAwakenFigure` | `new ChildSelfChangeView()` (:63) | (-326, -159) (:71-72) | (-272, -159) (:96-97) |
| `_hpTxt` | `creatComponentByStylename("battle.AbysmHpValueText")` (:60) | style x - 54, i.e. -294 (:73) | style (-240, -17) |
| `_spTxt` | `creatComponentByStylename("battle.AbysmMpValueText")` (:61) | style x + 54, i.e. 207 (:74) | style (153, -17) |
| `_childNswarHbox` | `creatComponentByStylename("battle.childnswar.bottom.HBox")`, HBox at x = 81, y = -64, spacing 0 (:75) | 2 × `new ChildNswarCallIcon(3/4)` (:76-86) | absent |

- Text styles: FilterFrameText, format `battle.AbysmHpValueText_t` = Arial 14, color 0xF4FFCC, bold, centered; `autoSize = none`, w = 95, h = 20, filter `core.normal_f`.
- In 3911, `nswarBattleHandler()` runs at init (:87).

**Z-order.** ChildSelfBloodView and SelfSpView constructors add pools via `addChildAt(…, 0)` and tips via `addChild` before the background. Final order, bottom to top:
1. spPool
2. bloodPool
3. blood tip
4. SP tip
5. `_back` (:99-101; `x = -w/2`, `y = -h`)
6. `_hpTxt`
7. `_spTxt`
8. `_skillList`
9. HBox (3911 only)
10. `_leftAwakenFigure` (:102-109)

The background is a Bitmap and does not intercept mouse, so the tips still work *(assumption based on Flash behavior)*.

**Digits:** the bitmap digit containers (`heroHpNumContainer`, `heroSpNumContainer`) **are not added**. Values show only in the FilterFrameTexts.

**Init:** `_leftAwakenFigure.direction = 1` and `updateTo(selfInfo.changeValue)` (:110-114); `showVesselBall` (:115, :181-185); `onHeroSpChanged(null)` (:116).

**States and events (:119-129):**
- `enterFrame` (:194-208): `bloodA` goes to `_selfBloodView.updateHeroHp`; `_hpTxt.text = String(bloodA)` shows the raw number, no separator or max. With HP <= 0: `isOver = true` and `FORCE_SKILL_ENABLE` false.
- selfInfo `AWAKEN` (:187-192): the displayed "SP" is the child's **awaken**, max 100. Goes to `_selfSpView.updateHeroSp(awaken)` and `_spTxt.text = String(awaken)`.
- `keyDown` with space → `_leftAwakenFigure.onKeyDown` (:152-162).
- `sceneEffectClose` → stops rotation (:164-179).
- `childNswar.Event.Battle` → `nswarBattleHandler` (:131-150). Sent by `core_module/scripts/managers/ChildNswarManager.as:105` on receiving **opcode 574** (:88, :91-106).
- In `nswarBattleHandler`, for `pos` = 3 and 4, the key is `selfSide + "_" + pos` in `ChildNswarManager.model.battleInfo.battleRoleList`, and the icon gets `updateView(msg)`.

#### `ChildNswarCallIcon`

Source: `m10/scripts/battle/view/bottom/ChildNswarCallIcon.as` (Sprite). Created at `ChildCommonBottomBar.as:81` with idx 3 and 4.

| field | style | x, y | z-order | visible |
|---|---|---|---|---|
| `_bg` | `creatBitmap("asset.battle.nswarCicleBg")`, 55x62 (:41) | (0, 0) | 1 (:51) | yes |
| `_icon` | `creatCustomObject("childnswar.battle.childIcon")`, BaseIconView 46x46 (:42) | style (4, 7) | 2 (:52) | yes; mask `_mShape` (:56) |
| `_mShape` | Shape, circle r = 22, fill 0xFF0000 (:45-48) | (27.5, 31) (:49-50) | 3 (:53) | mask |
| `_fightIng` | `creatBitmap("asset.battle.nswarCicle")`, 52x52 (:44) | style (2, 4) | 4 (:54) | false (:58) |
| `_dieImg` | `creatBitmap("asset.battle.nswarDie")`, 35x34 (:43) | style (8, 14) | 5 (:55) | false (:57) |

- `_icon` style: OneLineTip, `tipDirctions = 0`, `tipGapV = 5`, loading `asset.core.IconLoading`.

**`updateView(msg: ChildPvpBattleChildMsg)` (:78-109):**
- With `msg`: template via `childTemplateCate.getTemplateByJobAndGrades(msg.jobType, 1)`; `_icon.icon = PathManager.info.ResourcePath + "icon" + tpl.Icon`; tip `childnswar.click.addRole` = "Invoque um Espírito de Proteção de Suporte para participar da batalha".
- `state` 0: clickable (`buttonMode = true`, `click` listener).
- `state` 1: `_fightIng` visible, no click.
- `state` 2: `_dieImg` visible, no click.
- No `msg`: both overlays hidden, click removed.

**Click (:73-76):**
- `sendNotification("childnswar.battle.UseAdd", idx)`.
- `ChildCommonSkillItemListController._useChildNswarAdd` (`core_module/scripts/battle/view/ui/ChildCommonSkillItemListController.as:71`, :217-227) calls `SocketSendManager.childnswarSkill(battleId, livingId, idx)`.
- Sends **opcode 25240** with `UseSkillMsg{battleId, heroId, skillId = idx (3 or 4)}` (`SocketSendManager.as:238-246`).

#### `ChildSelfBloodView`

Source: `m10/scripts/battle/view/bottom/ChildSelfBloodView.as` (Component). Created at `ChildCommonBottomBar.as:67, 92`.

- Identical to SelfBloodView except:
  - hero is `battleModel.selfChildHeroInfo` (:117-120);
  - **no enterFrame**: the parent bar updates it;
  - different dispose.
- Rects: (-239, -12, 93, 18) if `param4 == 1`, else (-340, -14, 88, 18) (:48-55).
- Styles (:61-80):
  - `asset.battle.SelfHpNumAsset`;
  - `asset.battle.VesselPoolLineMC` with `alpha = 0.6` and `ColorTransform(0.7, 0, 0)`;
  - `VesselBallComp(totalBloodA, bloodA)`;
  - pool via `addChildAt(…, 0)`;
  - `battle.VesselBallTip` with circle r = 46.5 and tip `battle.view.bottomSelfBloodView.tip`.
- `showBall`: `asset.battle.BloodPoolBallMC` (:91-96).
- `updateHeroHp`: same as SelfBloodView (:98-109).

#### `ChildSelfChangeView`

Source: `m10/scripts/battle/view/bottom/ChildSelfChangeView.as` (Component). The Guardião "transformation", skill 700003.

- Created at `ChildCommonBottomBar.as:63`.
- Hero is `selfChildHeroInfo` (:72).
- Tooltip same as SelfAwakenView: OneLineTip, `"0"`, gapH 0, gapV 5, not following mouse (:76-81).

**initView (:87-117).** Creates content only with `thane.grades >= 70` (:91):

| field | style | position | parent and order |
|---|---|---|---|
| `_figureMc` | `creat("asset.battle.ChildAwakenProgress")`, 100 frames (:93) | `x = -(w >> 1)` (:96) | container, 1st |
| `_poolLine` | `creat("asset.battle.ChildVesselPoolLineMC")`, 30 frames (:97) | `x = -(w >> 1) + 78`, `alpha = 0.6` (:114-115) | container, 2nd (:101) |
| `_mask` | `creat("asset.battle.ChildAwakenMask")`, 100.75 x 128.15 (:98) | (-53, 29) (:112-113) | container, 3rd (:105); masks the line (:104) |
| `_awakenBgMc` | `creatCustomObject("battle.PetAwakenEffect")` (:99) | style (0, 19) | `this` (:102) |
| `_awakenTxtMc` | `creatComponentByStylename("battle.awakenImage")` (:100) | `x = -(w >> 1)`; style y (-10) | `this` (:103) |

- With `grades < 70`, only the empty `_figureContainer` is created.

**Value:**
- `changeValue`, max 3000; frame = `floor(v * 100 / 3000)` (:415-416).
- Event `CHILD_CHANGE_VALUE` → `tweenTo` (:125, :302-305), 0.5 s tween as in SelfAwakenView (:358-385).
- `refreshMc`: bg and `eye` play when full (>= 3000), else stop on frame 1; `body` and `poolLine` play; line invisible if value is 0 (:409-451).

**Use:**
- `childCanMorph()` = `changeValue == 3000` (`HeroRoleInfo.as:469-472`).
- Click and space share `useSkillHandler` (:177-241). Requires `_skillEnable`, `isRight`, `!isOver`, `!restricted`, `bloodA > 0`, `buttonMode`, `!useChildChangeSkill`, and 3000 ms since last use.
- Action: `sendNotification("ACTION_SKILL_BattleNotic", template 700003)`, auto-fight 1 → 2.
- Server send: `ChildCommonSkillItemListController.__skillUse` → `gameChildCommand` → **opcode 10516** (`ChildCommonSkillItemListController.as:187-215`; `SocketSendManager.as:228-230`).

**Events and states:** same as SelfAwakenView, with skillId 700003 only (:119-133, :154-175, :307-349).

**Tooltip:** "Despertamento:" + `"<font face='Arial'>v / 3000</font>"`, plus with `isRight` `"\n" + SelfAwakenView.spaceKey` (:457-468).

**State text:** only the "Despertar" state (frame 1) (:487-529).

#### `MonsterCommonBottomBar`

Source: `m10/scripts/battle/view/bottom/MonsterCommonBottomBar.as` (Component). Used in battleType 3884; created at `BattleUIView.as:1185`.

| field | style | x, y | z-order |
|---|---|---|---|
| `_back` | `creatBitmap("asset.battle.AbysmBattleBack")`, 514x97 (:38) | (-w/2, -h) (:43-44) | addChild (:42), above pool and tip |
| `_hpTxt` | `creatComponentByStylename("battle.AbysmHpValueText")` (:39) | style (-240, -17) | (:45) |
| `_selfBloodView` | `new MonsterSelfBloodView(this, -238, -91)` (:40) | pool at (-238, -91) | pool at index 0, tip on top |
| `_skillList` | `new MonsterCommonSkillItemListView()` (:41) | (-135, -65) (:47-48) | (:46) |

- No SP, no settings.
- Hero is `battleModel.selfMonsterRoleInfo`, the MonsterRoleInfo with `isCaptain` (`BattleModel.as:1230-1242`).
- `enterFrame` (:76-90): HP goes to the view and `_hpTxt.text = String(bloodA)`. With HP <= 0: `isOver = true` and `FORCE_SKILL_ENABLE` false.
- `sceneEffectClose` → stops rotation (:55-69).

#### `MonsterSelfBloodView`

Source: `m10/scripts/battle/view/bottom/MonsterSelfBloodView.as`. Copy of ChildSelfBloodView with hero `selfMonsterRoleInfo` (:117-120). Styles, rects and tip identical (:48-80, :91-109).

#### `PetBattleBar`

Source: `m10/scripts/battle/view/bottom/PetBattleBar.as` (Sprite). Used in battleType 3844; created at `BattleUIView.as:1167`.

| field | style | x, y | z |
|---|---|---|---|
| `_back` | `creatBitmap("asset.battle.remotepetBack")`, 712x81 (:32) | (-356, -81) (:33-34) | 1 |
| `_skillList` | `new PetSkillItemListView()` (:36) | (-300, -68) (:37-38) | 2 |
| `_settingBtn` | `creatComponentByStylename("battle.settingBtn")` (:40) | style (175, -95) | 3; tip "Configuração" (:42) |

- Click → `setTimeout(10)` → `openControllerByInfo("setting")` (:59-67).
- `_ballRotate` stored, never used (:31).

#### `ChildpveBattleBar`

Source: `m10/scripts/battle/view/bottom/ChildpveBattleBar.as`. Used in battleType 3845; created at `BattleUIView.as:1175`.

Identical to PetBattleBar, but skill list is `ChildPveSkillItemListView` at (-300, -68) (:36-39). Background `asset.battle.remotepetBack` (:32), `battle.settingBtn` (:40-42).

#### `PetSacristyBar`

Source: `m10/scripts/battle/view/bottom/PetSacristyBar.as` (Sprite). Used in battleType 3866 and 3864; created at `BattleUIView.as:1171`.

| field | style | x, y | z-order |
|---|---|---|---|
| blood pool | via SelfBloodView, `addChildAt(…, 0)` | (-238, -89) | 0, below background |
| `_back` | `creatBitmap("asset.battle.sacristy.skillBg")`, 515x96 (:39) | (-257.5, -96) (:40-41) | 1 (:42) |
| `_petAwakenView` | `new PetSacristyAwakenView()` (:43) | (116, -142) (:44-45) | 2 (:46) |
| `_bufferContainer` | `new SelfBufferView()` (:47) | (-132, -104) (:48-49) | 3 (:50) |
| `_skillList` | `new PetSacristyItemListView()` (:51) | (-168, -68) (:52-53) | 4 (:54) |
| `_textBack` | `creatBitmap("asset.battle.sacristy.BottomTextBack")`, 93x21 (:55) | style x = -239, y = -20 (applied by factory *(assumption)*) | 5 (:56) |
| blood tip | via SelfBloodView | (-238, -89) | 6 |
| HP number | `_selfBloodView.heroHpNumContainer` with rect (-239, -12, 93, 18) (`param4 = 1`) | x centered, y = -17 | 7 (:58) |

- `SelfBloodView` created with `(this, -238, -89, 1)` (:57).
- `showVesselBall` (:59, :86-89) and `sceneEffectClose` (:65).
- **No settings button**, though unused `onSettingBtnClick` and `openFrame` exist (:101-109).
- HP comes from SelfBloodView's enterFrame, via `selfHero.bloodA`.

#### `PetSacristyAwakenView`

Source: `m10/scripts/battle/view/bottom/PetSacristyAwakenView.as` (Sprite). Created at `PetSacristyBar.as:43`.

| field | style | x, y | z |
|---|---|---|---|
| `_awakenMovie` | `creatCustomObject("asset.battle.SacristyAwakenMC")`, 100 frames, style x = 24, y = 44 (:32) | `scale = 0.618` (:33-34) | 1 (:35) |
| `_valueText` | `creatComponentByStylename("battle.SacristyAwakenValueText")` (:36) | style (56, 125), w = 40, h = 20 | 2 (:37) |

- Text format `battle.SacristyAwakenValueText_t`: Arial 14, color 0xcdcccb, bold, centered.
- Event `UPDATE_PET_POWER` (:42), sent at `core_module/scripts/managers/PetSacristyManager.as:60`, plus an immediate call (:43).
- Handler: `v = PetSacristyManager.instance.awake`; `text = String(v)`; frame = `ceil(v * 100 / 100)`, clamped to 0..100 (:51-91).
- `effectVisible` is a no-op (:93-98).

#### `SpStripIncreaseAnimation`

Source: `m10/scripts/battle/view/animation/SpStripIncreaseAnimation.as`.

- Created only at `m10/scripts/battle/view/ui/PowerUIView.as:139`.
- **PowerUIView is never instantiated**: grep found no `new PowerUIView`. Symbols `asset.battle.PowerIncrease1`, `PowerIncrease2` and `PowerUIViewAsset` do not exist in the indexed `battle.swf`. Effectively **dead code**.

**`start(old, add)` (:57-68):**
- `destValue = old + add`.
- `startX1 = strip.x + strip.maskWidth - 16`; `startX2 = strip.x + strip.maskWidth - 58`.
- `count = ceil(add / strip.maxValue * 275 / 10)`; `interval = 300 / count` ms (300 ms total); `spStep = add / count`.
- Starts a `Timer(interval)`.

**Each tick (:82-125):**
- Creates `creat("asset.battle.PowerIncrease2")` at `(startX2 + i * 10, strip.y - 8)`, then `creat("asset.battle.PowerIncrease1")` at `(startX1 + i * 10, strip.y - 11)`, both mouse-disabled.
- `strip.currentValue = min(100, old + spStep * i)`.
- Last tick calls `dispose`.

**`dispose` (:146-156):** `strip.currentValue = selfHero.sp`. The class never removes the MCs it created.

#### `AddSpAnimation`

Source: `core_module/scripts/battle/view/animation/AddSpAnimation.as`. Particles flying from the hero to the HUD.

**Creation:**
- `core_module/scripts/battle/utils/BattleUtils.as:498`, inside `skillUpdateHitPoint`. Runs only if the role is `selfHero` and `skillData.hitPointAdded > 0` (:484-501), with `lineNum = ceil(hitPointAdded / 10)`.
- Origin is `role.view + (100, -70)`, converted to `_addSpBallLayer` coords. That layer is a mouse-disabled Sprite at `BattleUIView.as:1436-1438`.
- Destination is `getAddHitPointDestPoint()`, i.e. `BottomBar (-330, -110)`.
- Called by `BaseSkill.updataSp` (`core_module/scripts/battle/skillsys/skills/BaseSkill.as:350`).
- For SP, `skillUpdateSp` **no longer animates**: it only calls `delayUpdateSp` (`BattleUtils.as:440-451`).

**Params:** `(container, lineNum, ballAsset = "asset.battle.AddSpBallMC", disperseAsset = "asset.battle.AddSpBallMC3", flyTime = 1.2, ballNum = 3)` (:42).

**Trajectories (:64-114):**
- Scale `k = clamp(dist / 400, 0.7, 1)`.
- `lineNum > 1`: lines with offset (-180, 90) and (180, -90); with `lineNum == 2`, uses (-150, 60) and (150, -60).
- `lineNum != 2`: center line (0, 50).
- Per line, with `θ = atan2(dy, dx) - π/2`:
  - `pt1 = start + (ox * cosθ * k, (oy * cosθ + ox * sinθ) * k)`;
  - `pt2 = (end.x, end.y - 20)`.

**Ball waves:**
- `enterFrame` on the container: frame 0 creates wave 1, frame 3 wave 2, frame 6 wave 3. `ballNum` caps the wave count (:121-145).
- One ball per line per wave (:155-204):
  - starts at `start`;
  - wave 1: scale 0.3 → 1 in 0.4 s (Linear.easeInOut) and `needFlag = true`; other waves: scale 0.1;
  - `TweenMax.to(ball, 1.2, {bezier: [pt1, pt2, end], orientToBezier: true, ease: Linear.easeNone, delay: |index - 2| * 0.05})`;
  - alpha → 0.5 in 0.2 s, 1 s delay.

**In flight (`onBallUpdate`, :206-230):**
- Later balls in a line use the first ball's scale × 0.7^index.
- Balls with `needFlag` leave a trail: every 20% progress, `creat(AddSpBallMC3)` becomes a `SimpleBitmapMovieClip` with `blendMode "add"` that removes itself on its last frame (:232-267).
- Within 10 px of the destination: kills tweens and "shakes" 1 or 2 times, every 10 ms, with x = destination ± random 12; then removes the ball (:269-282, :377-396).
- `arrivedFun` is called once, when the first `needFlag` ball arrives (:212-216). In real use it is `delayUpdateHitPoint`, which updates `hitPoint` and thus SelfHitPointView.

#### `ReinforceWavePane`

Source: `m10/scripts/battle/view/reinforce/ReinforceWavePane.as` (Component).

**Creation:** `m10/scripts/battle/view/ui/RoleShowViewII.as:87`, when `battleModel.reinforceWave > 0` (:63-65), with `setTotalWave(reinforceWave)` and `setCurrentWave(currentReinforceWave + 1)` (:123-131). Added to display only if `PlayerManager.newbieProcess >= 19000` (:90-94).

**Position (`RoleShowViewII.as`):** `deployReinforceWavePane` at :100-121 and `reinforceLayout(s = sceneWidth / 1500)` at :349-370.

| case | top/right | x | y |
|---|---|---|---|
| battleType 3886 | 160 / 30 | `bossView.x - (reinforceWave - currentReinforceWave - 1) * 98 * s + 430 * s` | 40 |
| with boss | 75 / 120 | `sceneWidth - right * s - 200` | `top * s + 40` |
| without boss | 30 / 53 | `sceneWidth - right * s` | `top * s + 40` |

**Text field:** `_tf = ComponentFactory.creat("battle.WaveNumTxt")` in the field initializer (:29). FilterFrameText with format `battle.WaveNumTxt_t` = Arial 16, white, h = 22, style x = -316, y = -19. Text `…ReinforceWavePane.tf.text` = "Reforços inimigo" (:33-34).

**Ball creation (`setTotalWave`, :38-49):**
- Normal `createBalls` (:74-94): for i from 1 to total - 1:
  - tip = `…tipInfo` ("Tropa inimiga") + (i + 1);
  - `x = -(total - i - 1) * 90`, last one at x = 0;
  - `_tf.x = balls[0].x - tf.textWidth - 80`.
- `createEastBalls` for battleType 3886 (:51-72):
  - `x = (i - 1) * 80`;
  - `y = tf.y + tf.textHeight + 20`;
  - `new ReinforceWaveBall(cb, tip, i)`;
  - `_tf.x = balls[0].x`.

**`setCurrentWave(cur)` (:102-148):**
- While `balls.length > total - cur`: `shift()`, `exit()`, and `_tf.x += 90` (or `+= 20` in 3886, since `_eastGap - 60 = 20`).
- If `total < cur`, exits all.
- If no ball left or `total < cur`, hides `_tf`.
- Anomaly log via `LoggerSys.info` with keys `…str` and `…str2` (:108-113).

**Other methods:**
- `showNextWave()` = `cur + 1` (:155-159). Fired at `RoleShowViewII.as:400-407` when the right side's total HP reaches 0 after having been > 0.
- `isLastBall` (:161-168) has no callers.

#### `ReinforceWaveBall`

Source: `m10/scripts/battle/view/reinforce/ReinforceWaveBall.as` (Component). Created at `ReinforceWavePane.as:61, 84`.

| case | `_back` | `_mc` | back pos |
|---|---|---|---|
| battleType 3886 | `creatBitmap("asset.battle.EastReinforceFlagBg")`, 75x85 | `creat("asset.battle.EastReinforceMC" + i)`; only 1, 2, 3 exist; 52 frames, label "exit" at 44 | (-19, -15) (:26-32) |
| others | `creatBitmap("asset.battle.ReinforceFlagBg")`, 58x47 | `creat("asset.battle.ReinforceMC")`, 52 frames, "exit" at 42 | (-49, -30) (:33-39) |

- Z-order: `_back` then `_mc` (:40-42).
- `addFrameScript(totalFrames - 1, lastFrameFun)`: on the last frame stops, removes the MC and hides `_back` (:41, :56-67).
- `exit()` = `gotoAndPlay("exit")` (:69-72).
- Tooltip: `"yishi.view.tips.OneLineTip"`, `tipData = "Tropa inimiga N"`, not following mouse, `tipDirctions = "3,6,7"`, `tipGapV = 10` (:44-48).

### 4.2 battleType conditions (consolidated)

| value | effect | file:line |
|---|---|---|
| 16 (`isBattleSign`) | BottomBar **created** but not added; only strip + settingBtn | `m10/scripts/battle/view/ui/BattleUIView.as:1194`, :1272-1276, :1909-1917 |
| 35 (`isPetChallenge`) | no BottomBar; strip + settingBtn | `BattleUIView.as:1192`, :1272, :1919-1926 |
| 307 (`isMonopolyHelp`) | BottomBar created and **not added** | `BattleUIView.as:1194`, :1272, :2018-2025 |
| 349 (`isSelfChess`) | no BottomBar; own layout | `BattleUIView.as:1192`, :1314, :1982-1989, :824 |
| 3844 (`isPetBatle`) | PetBattleBar | `BattleUIView.as:1165-1167`, :1964-1971 |
| 3845 (`isChildpveBatle`) | ChildpveBattleBar | `BattleUIView.as:1173-1175`, :2000-2007 |
| 3864, 3866 (`isSacristyBatle`) | PetSacristyBar; `getBottomBar()` returns the sacristy bar | `BattleUIView.as:1169-1171`, :1973-1980, :1806-1808 |
| 3870 (`isSpaceTimeBattle`) | BattleSpaceTimeView + BottomBar | `BattleUIView.as:1187-1190`, :1309-1312, :1991-1998 |
| 3884 (`isMonsterBattle`) | MonsterCommonBottomBar | `core_module/scripts/yishi/datas/BattleModel.as:551-558`; `BattleUIView.as:1183-1185` |
| 3867, 3868, 3847, 3889, 3911 (`isChildBattle`) | ChildCommonBottomBar; SelfBloodView skips enterFrame in child battle | `BattleModel.as:514-549`; `BattleUIView.as:1179-1181`; `m10/scripts/battle/view/bottom/SelfBloodView.as:97` |
| 3911 | nswar variant: background `asset.battle.nswarBg`, 54 px shift, HBox with 2 ChildNswarCallIcon; chats at fixed positions | `m10/scripts/battle/view/bottom/ChildCommonBottomBar.as:58-88`; `BattleUIView.as:983-989` |
| 3895 (`isSpiritExpedition`), 3898 (`isDarkMaze`) | no bar, only settingBtn (also `isChildBattle`) | `BattleUIView.as:1177`, :1289-1300, :1937-1953 |
| 3896 (`isYLExpedtion`) | is `isChildBattle`, so ChildCommonBottomBar is **created** (:1181) but only settingBtn is added | `BattleUIView.as:1179-1181`, :1293-1296, :1928-1935 |
| 3886 | "East" style reinforcements: EastReinforceMC{i} balls, gap 80, tf above; own layout; autoFightFlag.y + 80 | `m10/scripts/battle/view/reinforce/ReinforceWaveBall.as:26`, `ReinforceWavePane.as:41`, :120; `m10/scripts/battle/view/ui/RoleShowViewII.as:106`, :353; `BattleUIView.as:1152-1155` |
| 3844, 3845, 3847, 16, 3868 and isChildBattle | `SkillItemListController` ignores `ACTION_SKILL_BattleNotic`, i.e. does not send 700001/700002 | `core_module/scripts/battle/view/ui/SkillItemListController.as:647-670` |

**Other conditions:**
- `thane.grades >= 50`: awaken figure with line, mask and text (`SelfAwakenView.as:119`).
- `thane.grades >= 70`: ChildSelfChangeView has content (`ChildSelfChangeView.as:91`).
- `isDragonTalker`: SelfHitPointView shown, `_back` goes to frame 3 (`BottomBar.as:93-97`), job becomes 4 (`SelfAwakenView.as:97-100`).
- `isAvenger`: AvengerBattleSkillView (`BottomBar.as:102`).
- `VersionSwitch.WARSOUL`: SkillWarsoulView and repositioned buffer (`BottomBar.as:113, :146`).
- `GodDessManager.isOpen`: belief (`BottomBar.as:135`).
- `SharedManager.allowSceneEffect`: ball rotation (`BattleUIView.as:1167-1194`; `VesselBallComp.as:140`).
- `newbieProcess >= 19000`: reinforcements visible (`RoleShowViewII.as:90`).
- No VIP or side condition in these files, except `selfSide` in the nswar key.

### 4.3 Findings

1. **ChildAwakenView shows no number.** `_childAwakenNumContainer` is filled but never displayed (`ChildAwakenView.as:117-120`; BottomBar adds only SP and HP numbers at :133-134). MC and tip are always created, **even with no child hero**; the gauge then stays at frame 0 (:42).
2. **Initial SP value comes from awaken.** SelfSpView uses `selfHero.awaken` as the vessel's initial value (`SelfSpView.as:61`); BottomBar fixes it right after via `onHeroSpChanged` (`BottomBar.as:111`). In ChildCommonBottomBar the displayed "SP" really is the Guardião awaken, max 100 (:187-192).
3. **Bars created but never shown.** In 16 and 307 BottomBar is created and not added; in 3896 the same happens with ChildCommonBottomBar. Flash broadcasts `enterFrame` even off the display list *(assumption)*, so the HP loop keeps running and can set `isOver` and send `FORCE_SKILL_ENABLE` (`SelfBloodView.as:103-107`; `ChildCommonBottomBar.as:203-207`).
4. **Repeated `FORCE_SKILL_ENABLE`.** With HP <= 0, the notification is resent **every frame** in SelfBloodView, ChildCommonBottomBar and MonsterCommonBottomBar.
5. **Possible error with `grades < 70`.** ChildSelfChangeView does not create `_figureMc`, but `enable()` calls `refreshMc()`, which does `_figureMc.gotoAndStop` (:409-416, :557-564). Likely a TypeError *(assumption: possible runtime error)*.
6. **Space only morphs.** Space requires `_skillEnable` and only sends 700001. Click on SelfAwakenView does not check `_skillEnable` and does both 700001 and 700002 (:245-356). Both actions are throttled at 3 s.
7. **Target point differs from the icon.** `getHitPointGlobalPos` aims at (-330, -110), while SelfHitPointView sits at `(_back.x + 150, _back.y + 66)` (`BottomBar.as:89-90, :314-317`).
8. **AddSpAnimation now serves only HitPoint (Dragon Talker).** The SP branch in `BattleUtils.skillUpdateSp` no longer animates.
9. **SpStripIncreaseAnimation and PowerUIView are dead**: no instance, and assets PowerIncrease1/2 do not exist in `battle.swf`.
10. **ReinforceWaveBall never leaves the display list.** `_removeFun` (`removeBallCallback`) is never called: after `exit()` the ball hides its background and removes the MC, but the Component stays (`ReinforceWaveBall.as:56-67`; `ReinforceWavePane.as:96-100`). The 3886 variant has only EastReinforceMC1 to 3, limiting it to 4 waves without error.
11. **No-effect leftovers:**
    - `PetSacristyBar` has a settings handler without a button (:101-109).
    - `_ballRotate` unused in PetBattleBar and ChildpveBattleBar.
    - `PetSacristyAwakenView.effectVisible` is a no-op.
    - `_back.smoothing = true` on a MovieClip does nothing (`BottomBar.as:80`).
12. **Number format.** HUD HP and SP numbers use a 10-glyph bitmap font, 15x16 glyphs, 10 px advance, no thousands separator, no "current/max". In Child and Monster bars the value is raw `String(bloodA)` in a FilterFrameText. The only "current / max" is in the awaken tooltip: `"{v} / 3000"`.
13. **Draw order.** Vessels sit **below** the background (`addChildAt(…, 0)`) in every bar. The background must have transparent "windows" for the vessels to show *(assumption)*.

---

## 5. Main skill bar (SkillItemListView, SkillItemListController, BattleSkillItemII, cooldown)

**Path abbreviations** (all relative to `decompiled/`):
- `ui/X.as` = `core_module/scripts/battle/view/ui/X.as`
- `BUV` = `m10/scripts/battle/view/ui/BattleUIView.as`
- `BB` = `m10/scripts/battle/view/bottom/BottomBar.as`
- `SSM` = `core_module/scripts/yishi/service/managers/SocketSendManager.as`
- `BM` = `core_module/scripts/yishi/datas/BattleModel.as`
- `BS` = `core_module/scripts/battle/skillsys/skills/BaseSkill.as`

Styles were checked in `index/styles.json`. A quoted position is the style's x/y, which `ComponentFactory` applies on creation *(assumption: `ComponentFactory` not inspected)*.

### 5.0 Hierarchy and global positioning

| Level | Object | Position | Ref. |
|---|---|---|---|
| Stage | `_sceneWidth` = stageWidth clamped to [1000, 1500]; `_sceneHeight` = stageHeight clamped to [600, 900] | - | `BUV:766-767` |
| BattleUIView | `_bottomBar` (BottomBar) | x = sceneW·0.5; y = sceneH; scale = 0.85 + ((sceneW - 1000)/300)·0.15, from 0.85 to 1.1 | `BUV:786-787`, `BUV:1027-1029` |
| BottomBar | `_back` = `creat("asset.battle.BottomBack")`. Anchor: bottom-center (x = -w/2, y = -h). Frame 1, or 3 for DragonTalker | (-w/2, -h) | `BB:79-99` |
| BottomBar | `_skillList = new SkillItemListView()` | (-235, -65) | `BB:120-123` |

`BottomBar` `addChild` order, bottom to top (`BB:79-152`, `BB:229-252`):
1. `_back`
2. `_selfHitPointView` (DragonTalker only)
3. `_avengerView` (Avenger only)
4. `_warsoulSkill` (only with `VersionSwitch.WARSOUL`, at (-235, -116))
5. **`_skillList`**
6. `_leftAwakenFigure` (`redrawBack`)
7. 2× `asset.battle.BottomTextBack`
8. SP and HP numbers
9. `_beliefView`
10. `_bufferContainer`
11. `_settingBtn`

**Who creates the BottomBar.** `BattleUIView.init()` (`BUV:1165-1197`). It is **not** created in the following cases (predicates at `BUV:1919-2025`):
- battleType = 3844 (PetBattle)
- battleType = 3864 or 3866 (Sacristy)
- battleType = 3845 (ChildPve)
- battleType = 3895 (SpiritExpedition) or 3898 (DarkMaze)
- `isChildBattle` (3867, 3868, 3847, 3889, 3895, 3896, 3898, 3911; `BM:514-549`)
- `isMonsterBattle` (3884; `BM:551-558`)
- battleType = 35 (PetChallenge), 3896 (YLExpedition) or 349 (SelfChess)

With battleType 3870 (SpaceTime) it is created together with `BattleSpaceTimeView` (`BUV:1187-1191`).

**When it is shown.** The `addChild` calls are in `BUV:1272-1317`. With battleType 16 (BattleSign) or 307 (MonopolyHelp), the BottomBar is **created but never added** to the screen, because the `BUV:1272` branch wins.

**Pet/human.** `BottomBar.switchSkills(_selfInfo.isPetState)` runs on init and on the `MORPH` event; then `_skillList.startAppearCd()` (`BB:155`, `BB:296-307`).

**Absolute positions in BottomBar space** (unscaled), adding SkillItemListView's (-235, -65):

| Element | Coordinates |
|---|---|
| Slots 1-5 | x = -206, -152, -98, -44, 10; y = -61 |
| Z / X | (87, -61) and (150, -61) |
| Q | (-249, -105) |
| E | (196, -103) |
| R / F | (349, -63) and (402, -63) |

The derivations are in §5.1.

### 5.1 Components

#### `SkillItemListView`

Source: `ui/SkillItemListView.as`. Extends Sprite. Created at `BB:120`. Creates its own controller in the constructor (`ui/SkillItemListView.as:66`).

**TileContainer layout** (`core_module/scripts/yishi/view/component/TileContainer.as`):
- default width 400 (:46);
- step = `layout.width + paddingH`, paddingH default 10 (:13, :78);
- wraps only when exceeding the width (:82).

So: normal slots at `{"width":44}` step **54 px**; props at `{"width":53}` step **63 px**.

| Field | Class/style | x,y (local) | z-order (addChild) | Visibility/condition | Events/opcodes |
|---|---|---|---|---|---|
| `_trailBack` | ScaleFrameImage `battle.TrailBack` (resourceLink `asset.battle.TrailBack,asset.battle.CrossGuildTrailBack`) | style (163, -47) | 1 | Only if isTrail(25) / isRandomBoss(3842) / isSkyboxRoad(293) / isMateLords(315) / isAresLords(3859) / isOutyardTitan(3860) / isCrossGuild(296) **and** selfHero exists (:96-98). Frame 2 if CrossGuild, else 1. Invisible if there are no trialProps (:116-131) | - |
| `_trailBox` | HBox `battle.TrailPropBox` (spacing -3) | style (173, -46) | 2 | Same condition; children = `BattleTrailPropItem`, one per `selfHero.trialProps`, sorted by numeric `index` (sortOn 16) (:100-113) | listens to `SKILL_CLICK_BattleEvent` (:108) |
| `_addSkBg` | `creatBitmap("asset.battle.comAddSkbg")` (raw class, not in `styles.json`) | (175, -43) explicit | 3 | Only battleType == 3914 (:134-141) | - |
| `_addHbox` | HBox `battle.addSkHBox` (spacing 2) | style (193, -38) | 4 | Only 3914; 3× `BattleSkillItemII(4)` with data = `getSkillById(selfHero.thessBoxSkills[i])` or null, numCount = -1 (:142-157) | SKILL_CLICK |
| `container` | `new TileContainer()` | (29, 4) | 5 | Visible = !petSkill (:314) | - |
| 5 normal slots | `BattleSkillItemII()` (shape 0) | in container: x = 0, 54, 108, 162, 216 | children of container | data = skills[0..4], numCount 1..5 (:169-180) | SKILL_CLICK (:172) |
| `_propContainer` | `new TileContainer()` | (322, 4) | 6 | Items exist only if battleType ≠ 3870 (:243-246) | - |
| `_sealSkillItem` (Q) | `BattleSkillItemII(1)` | (-14, -40) | 7 | data = skills[5], numCount 6. Becomes isLock + disabled + setState(4) if: thane.grades < 50; or mapId in (31000, 40000) exclusive (WorldBossHelper.checkForbiddenBoss, `core_module/scripts/yishi/utils/WorldBossHelper.as:501-507`); or battleType ∈ {3902, 3904, 3905, 3906, 3907} (:192-202, :337-344) | SKILL_CLICK |
| `_marrSkillItem` (E) | `BattleSkillItemII(1)` | (431, -38) | 8 | data = skills[6], numCount 7 (:204-209) | SKILL_CLICK |
| `_childSkillItem` (R) | `BattleSkillItemII(2)` | (584, 2) | 9 | data = skills[7], numCount 8. isLock + setState(4) if thane.grades < 70 (:225-240, :346-353) | SKILL_CLICK |
| `_childSkillItem2` (F) | `BattleSkillItemII(2)` | (637, 2) | 10 | data = skills[8], numCount 9; same lock (:229-240) | SKILL_CLICK |
| 2 props (Z, X) | `PropSkillBattleItem()` | in _propContainer: x = 0, 63 | children of _propContainer | openGrade = 35 + i·5 (35 and 40); data = skills[9], skills[10]; numCount 10, 11 (:247-260) | SKILL_CLICK |
| `petContainer` | `new TileContainer()` with 5× `BattleSkillItemII()` | (27, 4) | 11 (last; from initPetSkills) | Always created (petSkills is a non-null `[]`). Visible = isPetState (:281-306, :308-335) | SKILL_CLICK (:302) |

**Main functions**

- **`initCD()`** (:263-279), used on reconnect. For each `battleModel.cooldownInfo`, computes `max(cooldown, appearCoolDown)` in seconds and calls `cdStart(templateId, 0, s*1000)`. Source is `CreateGameTransaction.as:164-177` (`core_module/scripts/battle/transaction/`), which divides server ms by 1000; `BattleCooldownModel` decrements 1 per second (`core_module/scripts/yishi/datas/battle/BattleCooldownModel.as:24-45`).
- **`cdStart(skillId, delay, dur=-1)`** (:374-393):
  - finds items by TemplateId, by `BattlePropItem.skillTempId`, by `TrailPropInfo.id` **or** by `SkillTempInfo.Parameter3 == skillId` (:426-453);
  - if any is a prop, applies the shared CD to the other props: `RuneCommonCD` (ConfigValue, ms) via `publicCdStart` (:395-412).
- **`__skillClick`** (:414-424): calls `setDownEffect()` (=false) on all except R/F, and sends the `ACTION_SKILL_BattleNotic` notification with the data.
- **`setEnable(b)`** (:504-549):
  - if `isControledByBoss` → `setBeControled()`: all disabled + setState(1) (:491-502);
  - ignored if unchanged, or if b = true and `isWaitingChangeBody`;
  - for each non-isLock item: when disabling, calls `setDownEffect()`;
  - items with `useCount <= 0` stay disabled;
  - E → `controller.updateMarrSkillItem()`; R/F → `updateChildSkillItem()`; others → `parentEnable = buttonSkiner.enable = b`;
  - finally `refreshForSpChanged()` and `refreshForAwakenValueChanged()`.
- **`setEnableForce`** (:474-489): `TrailPropInfo` items with `skillTemp.IsUseOnDead == 1` and `useCount > 0` stay enabled anyway.
- **`refreshForSpChanged()`** (:626-680): returns if `selfHero.totalBloodA <= 0`. For `_heroSkills`, except E/R/F and isLock:
  - `bufferUnEnable` → disabled + GRAY;
  - if enabled: `sp + Cost < 0` **or** `hitPoint + HitPointCost < 0` → disabled + GRAY, else enabled. **Cost is negative.**
- **`refreshForAwakenValueChanged()`** (:682-727): pets. Requires `isPetState` and `awaken + Cost >= 0`.
- **`setChildDark(b)`** (:551-596): R/F go to setState(2) (DARK) + disabled, or setState(0).
- **`setChildEnable`** (:598-624).
- **`removeItemByData`** → `removeIcon()` (:741-752).

#### `SkillItemListController`

Source: `ui/SkillItemListController.as`. Not a display object. Created at `ui/SkillItemListView.as:66`.

**Building the `skills` array** (init, :94-236):

| Index | Slot/key | Source |
|---|---|---|
| 0-4 | 1..5 | `getFastkey()["fastkey_1..5"]` → `TempleteManager.getSkillTemplateInfoById` (:138-141). With battleType == 3870 the first 5 come from `ConfigInfo "TimeSpaceFaultSkill"` (CSV) and fastkeys 1-5 are skipped (:115-130, :136) |
| 5 | Q | fastkey_6; else talent: `getTalentTempId(replaceSkillInfo.talnetSkill \|\| thane.talentData.talentScript)`, first id whose SonType ∈ [1001, 2001, 3001] (:142-152, :1286-1307; `core_module/scripts/battle/data/SkillData.as:44`) |
| 6 | E | `getActiveMarrSkillInfo().skillTemp`; else (no replaceSkillInfo) `MarryManager.model.selfMarryInfo.getActiveMarrSkill()`; else template **9991** (:153-172) |
| 7, 8 | R, F | `getChildFastSkillTemAry(getEnterWarChild())[0]` and `[1]`. Needs child "profound" skills: Priority == 3 and MasterType equal to some ChildTemp's `SkillMasterType`; filtered by `fightSkill` / `childFastKey` (SonType) (:173-186, :299-343, :384-421). The child comes from GloryRoad (3863) / LordTrial (3869) or ChildManager (:281-297) |
| 9 + bagPos | Z / X | `selfHero.props[i]` (BattlePropItem) (:196-206) |
| petSkills[k] | - | `selfHero.petSkillIds[0..4]` placed by SonType index in `petFastKey` (:208-227) |
| awakenSkills | - | 700001 and 700002 (:228-229) |

**`getFastkey()`** (:423-495): `thane.skillCate.fastKey.split(",")`. Each entry is a **SonType**; DragonTalker uses TemplateId. The loop runs `_loc6_ = 1` to `< length` with `[_loc6_-1]` (:449-452), so it **ignores the last CSV entry**. Entries "-1" are skipped.

**Listeners** (:237-268):

| Event | Handler |
|---|---|
| `ACTION_SKILL_BattleNotic` | `__skillUse` |
| `RESET_ACTION_TIME_BattleNotic` | `__cleanSkillSelect` |
| `SKILL_ENABLE` | `__skillEnable` |
| `FORCE_SKILL_ENABLE` | - |
| `restrictChanged` | - |
| `skillCd` | `onSkillCdHandler` |
| socket 75 (HeroOrderMsg) | `__skillUseServerBack` |
| socket 158 (ItemUseResultMsg) | `__useBattleItemServerBack` |
| `BattleModelNotic.ADD_ROLE` / `REMOVE_ROLE` | - |
| `BUFFER_SKILL_ENABLE` | - |
| hero `sp`, `AWAKEN`, `HIT_POINT` | - |
| `KeyboardManager keyUp` | space toggles `emptySelectableOnOff`, unused flag (:361-367) |
| `_heroMarrayInfo` `die` / `isLiving` | - |
| `_heroChildInfo` `die` / `AWAKEN` / `isLiving` | - |

Socket event names are `"SLGSocketEvent"+code` (`core_module/scripts/yishi/service/managers/SocketManager.as:177`).

**`__skillEnable`** (:527-559):
- Boss control → `setEnableForce(false)`.
- Disables and calls `cancelReadyState` if any of: `isOver`; `restricted`; (`isPetState` and `awaken == 0`); `isWatchOnly` (battleType 35 or 307, :514-525).
- Otherwise `setEnable(data)`.

**`__skillUse` (send)** (:631-732):
- Returns without action if: `isWaitingChangeBody`, battleType ∈ {3844, 3845, 3847, 16, 3868} or `isChildBattle`.
- Then: `view.setEnable(false)`.

| data | Condition | Send | Ref. |
|---|---|---|---|
| SkillTempInfo | `isMarrSkill`: id in `marrSkills` **or** SonType == 10000 (:618-629) | `sendUseMarrSkill` → **10509** BattleItemMsg{userId = livingId, skillTempId, battleId} | :679-681; `SSM:573-580` |
| SkillTempInfo | `isChildProfoundSkill` | `gameChildCommand` → **10516** UseSkillMsg with **the child's** livingId; resets defaultSkillCount, `setEnable(true)` and returns (does not set currentReadySkillId) | :685-695; `SSM:228-235` |
| SkillTempInfo | UseWay == 4 (stone trigger) | **10523** UseSkillMsg | :696-698, :345-352; `SSM:583-590` |
| SkillTempInfo | `newbieProcess < 19000` | **10022** (NewbieSocketOutManager.sendBattleContinue) and, after 400 ms, **10008** | :700-707; `core_module/scripts/dialog/utils/NewbieSocketOutManager.as:49-54` |
| SkillTempInfo | others | `gameCommand` → **10008 UseSkillMsg** {1: battleId string, 2: heroId = selfHero.livingId, 3: skillId = TemplateId} | :709-712; `SSM:208-216`; tags in `core_module/scripts/com/road/yishi/proto/battle/UseSkillMsg.as:95-105` |
| BattlePropItem | - | **10499** BattleItemMsg{userId = livingId, skillTempId, battleId} | :717-722; `SSM:373-380` |
| TrailPropInfo | - | **10507** BattleItemMsg{userId = livingId, skillTempId = **prop.id**, battleId} | :724-730; `SSM:258-265` |

After sending (SkillTempInfo, prop or trail):
- `currentReadySkillId` = id;
- `addSkillUsedFlag` → `RoleViewBase.addSkillFlag` → `SkillUseItemCell` above the head (:743-750);
- `defaultSkillCount = 0` (:731).

**Response 75 (HeroOrderMsg)** (:842-1012):
- Ignored for battleType ∈ {3844, 3845, 3847, 3867, 3868, 3866, 3864, 3889}.
- result == 0:
  - qteTime = `skill.QTETime`, except in auto-fight;
  - if it was me (and battleType ≠ 307, :1014-1021): `addCollectionEffect` + `SHOW_SKILL_USE_SUCCESS_BattleNotic` [skill, qte, castTime, aims];
  - if it was my child with a profound skill: `setChildDark(true)`.
- result ≠ 0 (mine):
  - `currentReadySkillId = -1`, removes the flag and the aim markers;
  - **re-enables after 1000 ms** (TimerUtils.setTimeout).
- Always (mine): `USE_SKILL_RESULT` {skillId, result}.

**Response 158 (ItemUseResultMsg)** (:761-830):
- Updates the prop's `useCount`.
- type 2 = trial prop, type 3 = marriage (`marrSkillItem.setUseCount` + disable).
- Failure → `setEnable(true)`.

**E update** (`updateMarrSkillItem`, :1096-1126):
- Not married → disabled + setState(4) + `lock()`.
- Enabled if the active skill has useCount > 0, the spouse is alive and there is no bufferUnEnable; then `enable = view.enable` and setState(0). Else GRAY.
- Always `setUseCount`.

**R/F update** (`updateChildSkillItem`, :1133-1179):
- No replaceSkillInfo and no child at war → lock both.
- Child alive with awaken ≥ 100 and no blocking buff → normal (or DARK if `childSkillDark`). Else GRAY and childSkillDark = false.
- battleType ∈ {3880, 3883, 3887} → R/F with `visible = false`.

**Blocking buff** (`bufferEnabeleItemHandler`, :1189-1238):
- If `existUnenableSkillBuffer(TemplateId)`: disabled + GRAY + `addChild(banImg)`.
- Else removes banImg and re-enables only if: enough SP and HP, `currentReadySkillId == -1`, battleType ≠ 25 and bloodA > 0.

#### `BattleSkillItemII` (generic slot)

Source: `ui/BattleSkillItemII.as`. Extends Sprite, implements Disposeable.

**Created by:**
- `ui/SkillItemListView.as:148, 171, 184, 215, 296`;
- `BUV:454` with shape 5 (stone trigger);
- `ui/AvengerBattleSkillView.as:150, 161`; `ui/ChildPveSkillItemListView.as:48`; `ui/PetSacristyItemListView.as:49, 68` (shape 3); `ui/PetSkillItemListView.as:47`; `ui/ChildCommonSkillItemListView.as:63`; `ui/MonsterCommonSkillItemListView.as:62`.

**Constructor (shape).** createAsset → initView → initEvent. If shape ≠ 5, `buttonSkiner.enable = false` (**default is disabled**) (:95-106).

**Common elements** (:110-118, :236-267):

| Field | Exact style / type | x,y (style) | z (addChild) | Visibility | Notes |
|---|---|---|---|---|---|
| `_iconContain` | `creatCustomObject("asset.battle.SkillItemCDFlashAsset")` (MovieClip with `.container`) | - | 1 | yes | `gotoAndPlay(2)` at CD end = glow (:841) |
| `_icon` | `creatCustomObject("battle.SkillItemView")` = BaseIconView, tipStyle `yishi.view.tips.goods.SkillTips`, isFollowMouse false, tipDirctions 0, 44×44 | (4, 6) | inside `_iconContain.container` | yes | buttonMode; `tipData` = SkillTempInfo; icon = `PathManager.resourcePath+"icon"+Icons` (:629-644; `core_module/scripts/yishi/utils/IconFactory.as:30-33`) |
| `_superSkill` | `creatBitmap("asset.battle.SuperSkill")`, scale 0.9 | (4, 6) | `container`, above the icon | only if Priority == 3 (`SkillPriorityType.isSuperSkill`, `core_module/scripts/yishi/datas/consant/SkillPriorityType.as:15-18`) | copies the icon's filters |
| `_downMc` | `creatCustomObject("asset.battle.DownMc")` | (3, 4) | 2 | **false** (:244) | never visible: `setDownEffect(true)` does not exist in the code |
| `_circleImg` | shapes 1/2/3 only | see below | 3 | - | - |
| `_countBack` | `creatBitmap("asset.battle.SkillCountBack")` | (29, 43) | 4 | - | - |
| `_countTxt` | `creatComponentByStylename("battle.SkillCount")` FilterFrameText 30×20; format `battle.SkillCount_t` = Arial 13, #FFFFFF, bold, right-aligned | (15, 41) | 5 | - | key label |
| `_useCountTxt` | `battle.MarrPropCount` (Arial 12, white, bold, right, letterSpacing 1, glow `core.normal_f` 0x000000,1,5,5,3) | (12, 5) | 6 | shapes 1/2/3 only | - |
| `_overMc` | `creatCustomObject("asset.battle.OverMc")` | (3, 5) | **never added** | - | the hover tween (frame 1↔10, 0.4 s) runs on an off-screen clip |
| `_lockImg` | `creatBitmap("asset.battle.BattlePropLockAsset")` | (0, 0) | added in `lock()` (top) | - | - |
| `_banImg` | `creatBitmap("asset.battle.BanAsset")` | (3, 4) | added on ban (top) | - | - |
| `_cdEffect` | `new SkillItemCDEffect(CoolDown)` | (4, 4) | inside `_iconContain.container` | during CD | :660-664 |
| `_ceNumView` | `SkillItemCDNumView` | see below | addChild in `showCDNum` (top) | during CD | on shapes 1/2/3 only shown if `_useCount > 0` (:858-864) |

**Per-shape variations** (:119-233):

| shape | Use | Differences |
|---|---|---|
| 0 | slots 1-5 and pets | `_ceNumView = SkillItemCDNumView(50, 1)` at (0, 0) |
| 1 | Q (seal/talent) and E (marriage) | `_circleImg` = `battleSkillItemII.circleImg` (CustomBitmap `asset.battle.SkillCricleImg`, 7, 9). Circular mask c(20,20) r16 at (5,8) applied to `_iconContain`. countBack (16,36); countTxt (4,34); lockImg (-4,-1); `_overMc.fg.gotoAndStop(2)`; `_ceNumView(44, 0.6)` at (1,3) |
| 2 | R/F (child) | `_circleImg` = `battleSkillItemII.bigCircleImg` (`asset.battle.SkillBigCricleImg`, 7, 9). countBack recreated at (21,43); countTxt recreated = `battle.SkillBigCount` (50×20, centered). Mask c(20,20) r19 at (9,9); `_icon` (6,6); `_superSkill` (10,10); lockImg (0,0); `fg` frame 3; `_ceNumView(44, 0.6)` at (1,3) |
| 3 | Sacristy | `battleSkillItemII.sacristy.blackCircle` (invisible); `_icon` = `battle.SkillSacristyItemView` 60×60; mask c(26,26) r27; countTxt (10,44); `fg` frame 4 |
| 4 | 3 extra slots of 3914 | count invisible; `_ceNumView(50, 1)`; **scaleX = scaleY = 0.6** |
| 5 | stone trigger (`BUV:454`) | count invisible; blinking `MainToolBtnGlowEffect`; enabled by default; glow stops during CD and resumes at the end (:665-668, :844-850) |

`lock()` mask (:744-791): shape 1 → circle (25,25) r17 at (-1,2); shapes 2/3 → (25,25) r20 at (5,5).

**Label and key** (`set numCount`, :550-622). Comparison uses `KeyboardEvent.charCode`:

| numCount | Label | Key (charCode) | Position tweak | Slot |
|---|---|---|---|---|
| 1..5 | "1".."5" | numCount + 48 (49..53) (:509) | - | normal slots (and pets) |
| 6 | "Q" | 'q' (113) or 'Q' (81) (`isValidKey`, :527-534) | - | Q |
| 7 | "E" | e/E | countTxt (2,33) | E |
| 8 | "R" | r/R; requires `_skillEnable` | countTxt (6,41) | R |
| 9 | "F" | f/F; requires `_skillEnable` | (6,41) | F |
| 18 | "E" | charCode == 101 | - | - |
| 100..199 | String(n-100) | n - 52 | - | other bars |
| 200..205 | B N U H I J | letter (lower or upper case) | - | other bars |
| -1 (3914) | "-1" (hidden) | **charCode 47 ('/')** via the else branch (:509) | - | 3 slots of 3914 |

`_skillEnable` becomes true on the first `SKILL_ENABLE` with data == true (:311-318).

**`onKeyDown` guards** (:412-525), checked before the table:
- isLock or `!enable`;
- (isChildBattle and numCount < 100);
- (battleType 3845 and numCount < 100);
- `!visible`;
- `_lockImg.parent`.

Tutorial: with `newbieProcess == 12500`, keys for templates 20711 / 30711 / 10711 are blocked (:515-521). Events arrive via `org.aswing.KeyboardManager` "keyDown" (:285); there is no text-focus filter in `core_module/scripts/org/aswing/KeyboardManager.as:118-122` *(chat may capture keys elsewhere: assumption)*.

**Click** (`__iconClick`, :369-410). Guard order:
1. isLock, `!visible`, `_iconRemoved`, no battleModel, battleType == 16 → return.
2. **`setAutoFight(2)`**: turns auto-fight off and sends **10020** AttackModeMsg if it changed (`BM:296-309`; `SSM:385`).
3. `!enable`, `data == null`, `isCding` → return.
4. `hideTip`; dispatches `BattleEvent("SKILL_CLICK_BattleEvent", data)`.

**ButtonSkiner** (`core_module/scripts/yishi/utils/ButtonSkiner.as`):
- enable=false → `onDisableView` (DarkFilter) + `onNormalView`, and removes rollOver/Out/mouseDown/Up;
- enable=true → `onEnableView` (filters null, buttonMode) + normal;
- under boss control, enable is always false (:75-97).

**Filters** (`core_module/scripts/yishi/filter/UIFilter.as:45-58`):
- Dark: diagonal matrix 0.3 (RGB × 0.3, alpha 1).
- Gray: luminance 0.3086 / 0.6094 / 0.082.

**`setState`** (:716-742):

| State | Effect |
|---|---|
| 0 | filters null |
| 1 (GRAY) | gray filter |
| 2 (DARK) | dark filter |
| 4 (LOCK) | filters null, tipData null, `lock()` |

With `isControledByBoss`, any state becomes 1. `lock()` adds `_lockImg`, sets mouseEnabled = mouseChildren = false and hides countBack/countTxt (:744-754). `unLock()` reverts (:793-803).

**CD** (:646-714):
- `cdStart(delay=0, dur=-1)`: returns if `_data.CoolDown <= 0`; recreates `SkillItemCDEffect(_data.CoolDown)`, calls `start(delay, dur)` and `showCDNum`.
- `startAppearCD`: uses `AppearCD` (ms) only if greater than the current CD's remaining time.
- `cdCompleteHandler`: hides the overlay, `_iconContain.gotoAndPlay(2)`, `hideCDNum`.
- `updateCDNum` → `_ceNumView.setNum(getLeftTime())` (:827-833).

**`SkillTempInfo.CoolDown` is in ms.** Talents adjust it by % and by value, then truncate to whole seconds × 1000 (`core_module/scripts/yishi/datas/templates/SkillTempInfo.as:103-106, :182-214`).

**CD start after use.** When the animation ends, `BaseSkill` sends `SKILL_ENABLE` true and `skillCd` {skillId, waitTime = actionTemplate.getCompleteFrameIndex() × 40} (`BS:461-472`, `BS:527-543`). The controller calls `view.cdStart(skillId, waitTime)` (`ui/SkillItemListController.as:354-359`). So the delay is **frames × 40 ms** (25 fps) and the duration is the template's CoolDown. Default skills (UseWay == 3 or id -1) do **not** trigger CD; they re-enable only from the 2nd use (`BS:474-484`, `BS:545-548`).

##### Slot state machine (`BattleSkillItemII` in the main bar)

```
              data==null ───────────────► EMPTY (no icon/tip; click ignored)
                    │ set data
                    ▼
 [constructor] → DISABLED (enable=false → DarkFilter, no hover/buttonMode)
     │ SKILL_ENABLE(true) [EnterBattleController/BaseSkill/DannyAction/Reinforce]
     │   → setEnable(true) → refreshForSpChanged
     ├──► NO_SP/HP: sp+Cost<0 or hp+HitPointCost<0 → enable=false + GRAY
     ├──► BANNED: existUnenableSkillBuffer → enable=false + GRAY + banImg
     ├──► CONTROLLED (isControledByBoss) → enable=false, setState forces GRAY
     └──► AVAILABLE: enable=true, no filter, hand cursor, SkillTips tooltip
            │ click / key → SKILL_CLICK → ACTION_SKILL → sends 10008 etc.
            ▼
         WAITING (all setEnable(false) → Dark) ──resp 75 result≠0──► (1 s) AVAILABLE
            │ result==0 → animation → BaseSkill: SKILL_ENABLE(true)+skillCd
            ▼
         CD (isCding=true): sector overlay + number; click/key ignored
            │ TimerCDTween reaches 0 → gotoAndPlay(2) (glow), number removed
            ▼
         AVAILABLE / NO_SP (per refresh)
 Level/marriage/child lock: setState(4) → LOCKED (lockImg, no mouse, no tip)
 Q/R/F: isLock=true → ignored in setEnable/refresh/click/keyboard.
 R/F after use by the child: DARK (setChildDark(true)) until updateChildSkillItem.
 Auto-fight: slot look does not change; any click calls setAutoFight(2) (exits auto).
 Hover: cursor and tooltip only; _overMc is not in the display list.
```

#### `SkillItemCDEffect`

Source: `ui/SkillItemCDEffect.as`. Created at `ui/BattleSkillItemII.as:660, 703`; `ui/PropSkillBattleItem.as:126, 160`; `ui/BattleTrailPropItem.as:68`.

| Element | Style | Geometry | Notes |
|---|---|---|---|
| `_back` | `ComponentFactory.creat("asset.battle.SkillItemCDAsset")` | width = height = param4 (44 default; 30 in trail) (:15, :42-43) | dark overlay *(assumption about the art)* |
| `_mask` | Sprite | rotation -90, center at w/2 (:44-48) | sector of radius 50 |

**Animation:**
- `start(delay, dur)`: `_time = dur` or CoolDown (ms); with delay, uses `setTimeout` (:52-71).
- `startRotate`: angle from 360 → 0 (:73-86).
- `changeSectorAngle(mask, 0, 0, 50, 0, angle)` (`core_module/scripts/yishi/utils/GraphicsUtils.as:85-117`) draws a counterclockwise sector starting at +x. With rotation -90, the sector starts at 12 o'clock and **the revealed area grows clockwise from 12 o'clock**.
- `TimerCDTween` (:132-232): 30 ms Timer; step = (360 - 0)/(time_ms/30); compensation by `quickenControl.getFps()` clamped to frameRate ± 15 (:177-211). `_update` runs only when the integer degree changes.
- `getLeftTime()` = `ceil(angle/360 · time_ms/1000)` seconds (:106-109).

**Quirk:** if `quickenControl` is null, `_loc4_ = _loc2_` reads `_loc2_` before assignment (0), and the clamp turns it into frameRate - 15, making the CD ~1.3× faster at 60 fps *(likely decompiler artifact: assumption)*.

#### `SkillItemCDNumView`

Source: `ui/SkillItemCDNumView.as`. Created at `ui/BattleSkillItemII.as:123, 152, 184, 216, 223, 232` and `ui/BattleTrailPropItem.as:27`.

- Bitmaps `ComponentFactory.creat("asset.battle.SkillCDNumRed")` and `"asset.battle.SkillCDNumYellow"`. The decompiler moved the assignment into field initializers (:14-31).
- With scale ≠ 1, bitmaps are resampled (:32-41).
- `setNum(n)` (:47-57):
  - **red if n < 10, yellow if ≥ 10**;
  - sprite sheet with 22×28 glyph, advance 15, source offset index × 22, charset "0123456789.", all × scale (`NumberViewUtils.getNumberView`, `core_module/scripts/yishi/utils/NumberViewUtils.as:192-223`);
  - centered at `(iconWidth - w)/2`, `(iconWidth - h)/2`.

#### `PropSkillBattleItem` (Z / X: runes and items)

Source: `ui/PropSkillBattleItem.as`. Extends BattleSkillItemII. Created at `ui/SkillItemListView.as:250`. Inherits shape 0.

| Field | Style | x,y | z | Condition | Events |
|---|---|---|---|---|---|
| `_itemText` | `core.BaseItemText` (Arial 12, white, bold, right, glow, 45×18) | (0, 0); y forced to 0 | inside `_iconContain.container` | shows `useCount` (:31-33, :79-97) | listens to `PROP_USECOUNT_CHANGE` on data (:86, :99-105) |

- **data** = BattlePropItem. tip/icon come from `getSkillTemplateInfoById(skillTempId)`. `useCount <= 0` → disabled + GRAY.
- **numCount** (:222-238): 10 → "z", 11 → "x". Label stays **lowercase** (`_countTxt.text = _shortcutChar`). If `thane.grades < openGrade` (35 / 40) → `lock()`, but **without isLock**.
- **Keyboard** (:198-211): checks only data and key; ignores enable, visible and lock. Calls `__iconClick(null)`, which runs `setAutoFight(2)` before checking enable.
- **CD** (:140-171): from the template; with useCount ≤ 0 → GRAY.
- **`publicCdStart(delay, ms)`** (:107-138): restarts the CD only if the remaining time is less than `RuneCommonCD`.
- **`BUFFER_SKILL_ENABLE`** (:37-72): ban or re-enable. Does not re-enable if currentReadySkillId ≠ -1, useCount ≤ 0, battleType == 25 or bloodA ≤ 0.

#### `BattleTrailPropItem` (trial props)

Source: `ui/BattleTrailPropItem.as`. Extends BattleSkillItemII. Created at `ui/SkillItemListView.as:107`, inside `_trailBox`.

`createAsset` is overridden (:20-36) and does **not** create `_superSkill`, `_countBack`, `_lockImg` or `_banImg`.

| Field | Style | x,y | Notes |
|---|---|---|---|
| `_icon` | `battle.TrailPropIcon` (BaseIconView 30×30, tip SkillTips) | (5, 5) | tipData = `TrailPropInfo.skillTemp` |
| `_iconContain` | `asset.battle.SkillItemCDFlashAsset` | (3, 1) | - |
| `_countTxt` | `battle.TrailPropCount` (Arial 12, #FFEFBD, right, 30×20) | (13, 26) | shows useCount |
| `_downMc` | `asset.battle.DownMc` | (4, 5), 34×34 | - |
| `_overMc` | `asset.battle.OverMc` | (9, 7), 35×35 | not added |
| `_ceNumView` | `SkillItemCDNumView(44, 0.6)` | - | - |
| `_cdEffect` | size 30 | (6, 6) | only if `skillTemp.CoolDown > 0` and `TrailPropInfo.coolDown ≠ 0` (:50-79) |
| `_effect` | `SimpleMovie(creat("asset.battle.GetTraiCountMc"))` | (12, 12) | on gaining a use (`TRAIL_USECOUNT_CHANGE` with data) + `_iconContain.gotoAndPlay(2)` (:87-111) |

- Enabled only if `parentEnable` and `useCount > 0`.
- **No keyboard shortcut** (empty `onKeyDown`, :119-121).
- Use sends **10507** (see `SkillItemListController`).

#### `AddOtherSkillView` / `AddOtherSkillItem` (dead code)

Source: `ui/AddOtherSkillView.as`, `ui/AddOtherSkillItem.as`. **No `new AddOtherSkillView` exists** in `decompiled/` (empty grep). The `AddOther.skillUse` notification appears only in these two files. AddOtherSkillItem is instantiated only by AddOtherSkillView (:68). The equivalent feature, 3 `thessBoxSkills` slots with the same background and HBox, was merged into SkillItemListView under battleType 3914 (`ui/SkillItemListView.as:134-158`).

**AddOtherSkillView**

| Field | Style | x,y | z |
|---|---|---|---|
| `_bg` | `creatBitmap("asset.battle.comAddSkbg")` | (0, 0) | 1 |
| `_hbox` | `battle.addSkHBox` (spacing 2) | (193, -38) | 2 |
| 3 items | `AddOtherSkillItem` 34×34, parentEnable = true | in the HBox | - |

Refs: :59-93.

- Availability = `warsoulSp >= Cost` (:247, :344).
- Send: **10008** (`gameCommand`), with the same 400 ms tutorial delay (:264-322).
- Does **not** listen to `SKILL_ENABLE`: only `restrictChanged` → `setEnable(true)` (:96-106, :194-213).
- Response 75 failure → re-enables after 1 s (:132-192).

**AddOtherSkillItem**

| Element | Style | z |
|---|---|---|
| `_iconContain` | `asset.battle.SkillItemCDFlashAsset` | 1 |
| `_icon` | `battle.warsoul.SkillItemView` (47×47, tip SkillTips, 4,6), inside the container | - |
| `_downMc` | `asset.battle.DownMc` | 2 |
| `_overMc` | `asset.battle.OverMc` | 3 (**on screen here**) |
| `_lockImg` | `asset.battle.BattlePropLockAsset` | 4 (visible if data null) |
| `_banImg` | `asset.battle.BanAsset` | - |

Refs: :66-81, :198-213. States 0/1/2/4 match BattleSkillItemII (:220-242).

#### `SkillUseItemCell` ("skill ready" icon above the character / QTE)

Source: `ui/SkillUseItemCell.as`. Created at:
- `core_module/scripts/battle/view/roles/RoleViewBase.as:1391`, in `addSkillFlagByIconPath`: x = -20; y = -175, or `getSpecialPos(1).y - 33`; with `hideBorder()` + `flash()`; goes into `_effectContainer` (:1373-1398);
- `m10/scripts/battle/qte/QteView.as:96`.

| Field | Style | Notes |
|---|---|---|
| `_asset` | `ClassUtils.CreatInstance("asset.battle.SkillGlowAsset")`, `gotoAndStop(1)` | `flash()` = play; `tweenEffect` = `gotoAndPlay("out")` |
| `_icon` | `creatCustomObject("battle.SkillUseItemCell")` (BaseIconView 30×30, 5,5) | inside `_asset.skill` |

- No mouse. `hideBorder` removes `_asset.skill.getChildAt(0)` (:29-69).
- Removed in `removeSkillFlag` (`RoleViewBase.as:1400-1417`).

#### `HeroRoleHeadView` (outside the skill bar)

Source: `ui/HeroRoleHeadView.as`. Boss portrait at the top. Created at `core_module/scripts/battle/view/ui/top/DoubleBossInfoView.as:156, 163`, `.../top/BossInfoView.as:210` and `.../top/BossInfoViewII.as:111`, always with scale -1 (mirrored).

- Does `new BaseIconView(iconLoaded)` and adds itself to the given container (:26-35).
- Icon (:37-48):
  - `playerIconId == 0` → `getHeroIconByPics(heroInfo.templateInfo.Icon)`;
  - else → `getPlayerIcon(templateId, "head")`.
- `iconLoaded` (:55-66): `fullInRect(rect)`; with scale -1, mirrors and adds the width to x.
- `setPlayerIcon` ignores the parameter and uses 1 (:50-53).

#### `StripUIView` / `IHpStrip` (outside the skill bar)

Source: `ui/StripUIView.as`, `ui/IHpStrip.as`. The interface has `maxValue` get/set, `currentValue` get/set, `initCurrentValue`, `getView` and `dispose` (`ui/IHpStrip.as:8-20`).

**Created by:**
- HP bar above the role: `core_module/scripts/battle/view/roles/RoleViewBase.as:313`;
- `ui/BossBottomStrip.as:20, 26, 40`;
- `ui/BossStripUIView.as:72, 82, 262`;
- `m10/.../PowerUIView.as:80`;
- m14 (MonsterExplore and RemotePet).

**Constructor** `(asset MovieClip with child maskmc, max, cur, colorOffset, hasBackGroundFade, twoWayTween, background, fullDefault=true, needLight=false)` (:46-67). `_hasBackGroundFade`, `_twoWayTween` and `_changeFlag` are stored but unused.

- With `needLight`: `creat("asset.battle.BossHpStripLightMc")`, height = asset, y -2.
- After 30 ms, `delayInitFade`: creates the "ghost" background, the asset drawn with a color offset (16275472 = 0xF85810) and alpha 0.5, with scrollRect (:80-106).
- **`refreshView`** (:108-167):
  - `maskmc.width = cur/max · width`;
  - the ghost tweens to the new width in 0.5 s, with 1 s delay;
  - the light moves to w - 5;
  - with `max <= 0` and `!fullDefault`, the bar goes to zero.

### 5.2 battleType conditions (consolidated)

| Value | Effect | Ref. |
|---|---|---|
| 16 (BattleSign) | BottomBar created but not added; `__skillUse` ignores; click ignored before `setAutoFight` | `BUV:1192-1194, 1272, 1909-1917`; `ui/SkillItemListController.as:659-662`; `ui/BattleSkillItemII.as:388-391` |
| 25 (Trail) | shows the trial props strip; buffer does not re-enable skill/prop | `ui/SkillItemListView.as:96`; `BM:1030-1033`; `ui/SkillItemListController.as:1216, 1222`; `ui/PropSkillBattleItem.as:55, 60` |
| 35 (PetChallenge) | no BottomBar; `isWatchOnly` → skills disabled | `BUV:1919-1926, 1192`; `ui/SkillItemListController.as:516` |
| 293 (SkyboxRoad), 296 (CrossGuild; background frame 2), 315 (MateLords), 3842 (RandomBoss), 3859 (AresLords), 3860 (OutyardTitan) | show the trial props strip | `ui/SkillItemListView.as:96, 116-118`; `BM:1025-1063` |
| 307 (MonopolyHelp) | BottomBar not added; `isWatchOnly`; response 75 is never treated as "mine" | `BUV:2018-2025, 1272`; `ui/SkillItemListController.as:520, 1016` |
| 349 (SelfChess) | no BottomBar | `BUV:1982-1989, 1192, 1314` |
| 3844 (PetBattle) | no BottomBar (PetBattleBar instead); use and response ignored | `BUV:1964-1971`; `ui/SkillItemListController.as:647, 863` |
| 3845 (ChildPve) | no BottomBar; use and response ignored; keys < 100 blocked | `BUV:2000-2007`; `ui/SkillItemListController.as:651, 867`; `ui/BattleSkillItemII.as:423` |
| 3847, 3868 | isChildBattle; use and response ignored | `BM:514-549`; `ui/SkillItemListController.as:655, 663, 871, 879` |
| 3864, 3866 (Sacristy), 3867, 3889 | response 75 ignored; no BottomBar | `ui/SkillItemListController.as:875-893`; `BUV:1973-1980` |
| 3870 (SpaceTime) | 5 skills from config `TimeSpaceFaultSkill`; no Z/X prop slots; BottomBar + BattleSpaceTimeView | `ui/SkillItemListController.as:115-136`; `ui/SkillItemListView.as:243-246`; `BUV:1187-1191` |
| 3880, 3883, 3887 | R/F invisible | `ui/SkillItemListController.as:1175-1178` |
| 3884 (Monster) | no BottomBar | `BM:551-558`; `BUV:1183` |
| 3895, 3896, 3898, 3911 | isChildBattle / expeditions: no BottomBar | `BM:530-545`; `BUV:1177, 1192` |
| 3902, 3904, 3905, 3906, 3907 | Q locked | `ui/SkillItemListView.as:197` |
| 3914 | 3 extra slots (shape 4, scale 0.6) with `thessBoxSkills` + `comAddSkbg` background | `ui/SkillItemListView.as:134-158` |
| mapId in (31000, 40000) | Q locked (ForbiddenBoss) | `ui/SkillItemListView.as:197`; `WorldBossHelper.as:501-507` |

**Other conditions:**
- Level (thane.grades): Q ≥ 50; R/F ≥ 70; Z ≥ 35; X ≥ 40 (`ui/SkillItemListView.as:337-353, 252`; `ui/PropSkillBattleItem.as:234-237`).
- Marriage (`MarryManager.isMarry`) for E.
- Child at war with awaken ≥ 100 for R/F.
- `isPetState` toggles the pet/human bar.

None of the 13 files in this section has a condition on `side`, `useWay` (other than UseWay 4), `isSpectator`, `battle_from` or VIP (empty grep).

### 5.3 Findings

1. **`_overMc` is never added** in BattleSkillItemII or BattleTrailPropItem, so the visual hover never shows. Same for `_downMc`, always invisible (`setDownEffect(true)` does not exist). In HTML5, hover is just cursor and tooltip, unless a design decision says otherwise (`ui/BattleSkillItemII.as:244-266`).
2. **Clicking a skill turns auto-fight off** (`setAutoFight(2)` → 10020), even if the slot is disabled or in CD. Keys Z/X do the same, because the prop's `onKeyDown` does not check enable (`ui/BattleSkillItemII.as:392`; `ui/PropSkillBattleItem.as:198-211`).
3. The 3914 slots get numCount -1, and the **'/' (charCode 47)** key triggers all three (`ui/SkillItemListView.as:153`; `ui/BattleSkillItemII.as:509`).
4. `getFastkey` ignores the last entry of the `fastKey` CSV (`ui/SkillItemListController.as:450`).
5. Z/X labels are lowercase; Q/E/R/F are uppercase.
6. `lock()` in PropSkillBattleItem and in E/R/F (`updateMarr/ChildSkillItem`) does not set `isLock`. Only the Q/R/F level lock sets isLock.
7. **AddOtherSkillView/Item is dead code**; the feature moved to the 3914 branch.
8. LanguageMgr strings `battle.view.ui.SkillItemListController.str` ("Moldura de uso de habilidade") and `.str2` ("Falha no retorno de uso de habilidade") are read and never shown (`ui/SkillItemListController.as:671, 915`; `index/language.json:1882-1883`).
9. In 16 and 307 the BottomBar and controller are instantiated and listening to events without being on screen.
10. The trial prop is sent with `skillTempId = TrailPropInfo.id`, not the skill template.
11. The visual CD has 1-degree resolution with a 30 ms timer; the displayed count is `ceil` of the seconds; the initial delay is animation frames × 40 ms.
12. Possible decompilation bug in TimerCDTween (variable read before assignment) that would make the CD faster when `quickenControl` is null *(assumption)*.

---

## 6. Skill bar variants (Pet, ChildPve, ChildCommon, Monster, Avenger, PetSacristy, Warsoul)

**Path abbreviations** (all relative to `decompiled/`):
- `ui/X.as` = `core_module/scripts/battle/view/ui/X.as` (same as §5)
- `BOT/X.as` = `m10/scripts/battle/view/bottom/X.as`
- `BUV` = `m10/scripts/battle/view/ui/BattleUIView.as`
- `SSM` = `core_module/scripts/yishi/service/managers/SocketSendManager.as`
- `BM` = `core_module/scripts/yishi/datas/BattleModel.as`
- `View:L` / `Controller:L` = line L of the view or controller named in the enclosing subsection

Line numbers were verified with `cat -n` and `sed -n`.

### 6.0 Common base: `BattleSkillItemII` and `TileContainer`

Every variant except Warsoul uses the `BattleSkillItemII` item, so variants differ only in container, `numCount` and controller. Item essentials:

| Aspect | Detail | Ref |
|---|---|---|
| Constructor `BattleSkillItemII(shape=0)` | `buttonSkiner.enable=false`, except when shape==5 | `ui/BattleSkillItemII.as:95-106` |
| Assets (shape 0) | `creatCustomObject("asset.battle.SkillItemCDFlashAsset")`, `creatCustomObject("battle.SkillItemView")` (BaseIconView 44×44 at x4,y6, tip `SkillTips`), `creatBitmap("asset.battle.SuperSkill")`, `creatBitmap("asset.battle.SkillCountBack")` (x29,y43, 19×16), `creatComponentByStylename("battle.SkillCount")` (x15,y41, 30×20), `asset.battle.DownMc` (x3,y4), `asset.battle.OverMc`, `asset.battle.BattlePropLockAsset` (56×56), `asset.battle.BanAsset` (x3,y4) | `ui/BattleSkillItemII.as:110-118`; `styles.json` |
| shape 3 (Sacristy relic) | `battleSkillItemII.sacristy.blackCircle` (invisible), `battle.SkillBigCount` at (10,44), `battle.MarrPropCount`, icon `battle.SkillSacristyItemView` (60×60). Mask: circle r27 centered at (26,26), placed at (9,9). Icon at (6,6), countBack at (26,45). `_overMc.fg` goes to frame 4 | `ui/BattleSkillItemII.as:177-211` |
| addChild order | `_iconContain` (holds `_icon` and `_superSkill`), `_downMc`, `_circleImg?`, `_countBack`, `_countTxt`, `_useCountTxt?`. Added later: `_lockImg` (on lock), `_ceNumView` (on CD), `_banImg` (from buffer handlers) | `ui/BattleSkillItemII.as:247-266, 751, 862` |
| **`_overMc` is never added** | Created and tweened, but no `addChild(_overMc)` | `ui/BattleSkillItemII.as:116, 252-266` |
| States (`setState`) | 0: no filter; 1: gray; 2: dark; 4: lock (tipData=null). If `isControledByBoss()`, forces state 1 | `ui/BattleSkillItemII.as:716-742` |
| Click (`__iconClick`) | Ignored if locked, invisible or icon removed. **Returns if battleType==16.** Calls `setAutoFight(2)` **before** the enable check, which sends opcode 10020 if the mode changes. Then requires enable, data and no CD, and dispatches `SKILL_CLICK_BattleEvent` | `ui/BattleSkillItemII.as:369-410`; `BM:296-309`; `SSM:385` |
| Label and key by `numCount` | 6→Q, 7→E, 8→R, 9→F, 18→E, 100..199→text `numCount-100`, 200..205→B,N,U,H,I,J, others→String(n) | `ui/BattleSkillItemII.as:550-622` |
| Keyboard (keyDown) | Ignored if locked or disabled. **If `isChildBattle` and numCount<100, ignored. If battleType==3845 and numCount<100, ignored.** Cases: 18 → only charCode 101 (lowercase 'e'); 200-205 → lowercase or uppercase letter; ≥100 → charCode==numCount-52 (101→'1' … 109→'9', 100→'0'); <100 → numCount+48. 8 and 9 require a prior `SKILL_ENABLE` true | `ui/BattleSkillItemII.as:412-525, 311-318` |
| CD | `cdStart(elapsed,left)`: exits if `CoolDown<=0`; creates `SkillItemCDEffect` at (4,4) inside `iconContain.container` and adds `_ceNumView` | `ui/BattleSkillItemII.as:646-675` |
| Tooltip | `_icon.tipData = SkillTempInfo`; tipStyle `yishi.view.tips.goods.SkillTips` (`styles.json`) | `ui/BattleSkillItemII.as:634` |

`TileContainer`:
- Defaults: `paddingH=10`, `width=400` (`core_module/scripts/yishi/view/component/TileContainer.as:13, 46`).
- Step between items = width passed to `appendItem` + `paddingH`. Wraps when next width + padding + x exceeds `width` (`TileContainer.as:76-88, 144-163`).
- `addChild` throws; `appendItem` is mandatory (`TileContainer.as:114-117`).

### 6.1 Variants

#### `PetSkillItemListView` / `PetSkillItemListController`

- **Creator:** `PetBattleBar` (`BOT/PetBattleBar.as:36`), at (-300,-68) (:37-38).
- `PetBattleBar` is created only if `isPetBatle`, i.e. **battleType==3844** (`BUV:1165-1167, 1964-1971`). Added at `BUV:1277-1279`.
- Bar anchored at (sceneWidth/2, sceneHeight), scale `0.85+0.15*(sceneWidth-1000)/300` (`BUV:854-858`). Auto-fight hidden (`BUV:880`).
- `PetBattleBar` elements:
  - `_back = creatBitmap("asset.battle.remotepetBack")` (712×81, no XML entry), at (-w/2,-h) (`BOT/PetBattleBar.as:32-35`).
  - `_settingBtn`, style `battle.settingBtn` (x175,y-95), tip `battle.view.bottom.BottomBar.settingBtn.tipData` = "Configuração" (:40-42). Click opens "setting" (:59-67).
- View extends `Sprite` (`ui/PetSkillItemListView.as:12`). Controller created in the constructor (:27).

| field | class/style | x,y | z-order | visibility/condition | events/opcodes |
|---|---|---|---|---|---|
| `container` | `TileContainer` (width 600) | 27,4 | 1 | always (if battleModel exists) | - (:37-41) |
| slots 0..9 | `BattleSkillItemII()` shape 0, `appendItem({width:44.5})` | x=i·54.5 (44.5 + paddingH 10), y=0 *(computed by TileContainer)* | order i | if data==null: `buttonSkiner.enable=false`, `setState(4)`, `lock()` | `SKILL_CLICK_BattleEvent` → `__skillClick` (:45-65) |
| numCount | 101..110; 110 becomes 100 | - | - | labels "1".."9","0"; keys 1..9,0 | (:50, 58-61) |

- **Data:** `RemotePetManager.instance.model.remotePetSkill[i]` → `getSkillTemplateInfoById`, 10 positions (`ui/PetSkillItemListController.as:57-68`).
- **CD:**
  - `initCD` reads `battleModel.cooldownInfo`, computes `max(cooldown,appearCoolDown)*1000`, calls `cdStart(id,0,ms)` (`ui/PetSkillItemListView.as:68-84`).
  - Notification `skillCd` {skillId,waitTime} also calls `cdStart` (`Controller:82-87`).
  - Lookup matches `TemplateId` **or** `Parameter3` and returns multiple items (`View:114-131`).
- **Click:** `setDownEffect()` on all items, sends notification `REMOTEPET_SKILL` (`View:143-150`). Controller does `setEnable(false)` and calls `sendUsePetBattleSkill(battleId, TemplateId)` = **opcode 14001**, no heroId (`Controller:139-153`; `SSM:278-285`).
- **Enable:**
  - `SKILL_ENABLE` → `setEnable(data)` (`Controller:118-132`).
  - Items with `useCount<=0` are not re-enabled (`View:152-177`).
  - `restrictChangedHandler` exists (:134) but is **not registered** (listeners at :74-79).
  - An empty bar, or one with initial `_enable=false`, stays disabled until `SKILL_ENABLE` true arrives.
- **Server response (socket event 75, `HeroOrderMsg`):** handled only if **battleType==3844** (`Controller:183-186`).
  - result 0: `addSkillFlag`. If `SonType==20010`, `__clearCD`: clears others' CD, restarts its own, `setEnable(true)` (:205-221, 89-95).
  - Failure: `currentReadySkillId=-1`, removes target marks, re-enables after 1000 ms (:223-247).
- **Controller keyboard:** space toggles `emptySelectableOnOff`, no visible effect (:97-103). `isWatchOnly` (35/307) is **dead code** (:105-116).
- `RESET_ACTION_TIME_BattleNotic` clears skill marks (:271-283).

#### `ChildPveSkillItemListView` / `ChildPveSkillItemListController`

- **Creator:** `ChildpveBattleBar` (`BOT/ChildpveBattleBar.as:36`), at (-300,-68) (:37-38). Created only if `isChildpveBatle`, i.e. **battleType==3845** (`BUV:1173-1175, 2000-2007`). Added at `BUV:1285-1287`.
- `ChildpveBattleBar` is identical to `PetBattleBar`: background `asset.battle.remotepetBack` and `battle.settingBtn` (`BOT/ChildpveBattleBar.as:32-42`).
- View layout same as Pet: Sprite, container (27,4) width 600, 10 slots `{width:44.5}`, numCount 101..110 (110 becomes 100), empty slot locked (`ui/ChildPveSkillItemListView.as:38-66`).

| field | class/style | x,y | z | condition | events |
|---|---|---|---|---|---|
| `container` | TileContainer w600 | 27,4 | 1 | - | :38-42 |
| slots 0..9 | `BattleSkillItemII()`, w44.5 | i·54.5, 0 | i | data null → lock (state 4) | click → `CHILDPVE_SKILL` (:144-151) |

Differences from Pet:
- Data from `FrameControllerManager.instance.childPveController.pveModel.skillInfo` (`Controller:57`).
- **IDs "0" are skipped with `continue` before `push`.** Following skills shift left; trailing slots stay empty (`Controller:59-72`).
- Registers `restrictChanged` → `setEnable(true)` (`Controller:78, 139-142`).
- Send also uses `sendUsePetBattleSkill` = **14001**, same as pet (`Controller:154`).
- Server response handled only if **battleType==3845** (`Controller:188-191`).
- `dispose` uses `ObjectUtils.disposeObject` (`View:185-202`).
- `BattleSkillItemII` blocks keys with numCount<100 in 3845, affecting only other items. This bar's slots (≥100) work (`ui/BattleSkillItemII.as:423-426`).

#### `ChildCommonSkillItemListView` / `ChildCommonSkillItemListController`

- **Creator:** `ChildCommonBottomBar` (`BOT/ChildCommonBottomBar.as:62`).
- `BUV` condition: not 3844, 3866/3864 or 3845; not 3895 or 3898 (`BUV:1177`); and `isChildBattle` true (`BUV:1179-1181`).
  - `isChildBattle` holds for battleType ∈ {3867, 3868, 3847, 3889, 3895, 3896, 3898, 3911} (`BM:514-549`).
  - Effectively the bar appears in **3867, 3868, 3847, 3889, 3896, 3911**.
  - But **3896 (`isYLExpedtion`) gets no `addChild`**: only `settingBtn` is added (`BUV:1293-1296`). See §6.4, finding 3.
- Position in `ChildCommonBottomBar`:
  - Normal: list at (-135,-65); background `asset.battle.AbysmBattleBack` (514×97) (`BOT/ChildCommonBottomBar.as:91-97`).
  - **battleType 3911** (nswar): offset 54, list at (-189,-65), background `asset.battle.nswarBg` (622×97). Adds HBox `battle.childnswar.bottom.HBox` (x81,y-64) with 2 `ChildNswarCallIcon(3/4)` (:58-88).
  - addChild order: back, hpTxt (`battle.AbysmHpValueText` -240,-17), spTxt (`battle.AbysmMpValueText` 153,-17), list, nswar HBox, `ChildSelfChangeView` (:99-109).
  - Anchoring: `BUV:958-962`. In 3911 chat buttons are repositioned (`BUV:983-989`).
- View extends `Component` (`ui/ChildCommonSkillItemListView.as:14`).

| field | class/style | x,y | z | condition | events |
|---|---|---|---|---|---|
| `container` | TileContainer, w600, **paddingH 4** | 0,0 | 1 | recreated on each `initView`; previous removed, items disposed | :40-56 |
| slots 0..4 | `BattleSkillItemII()`, `{width:50}` | i·54, 0 | i | data null → lock (state 4) | click → `ACTION_SKILL_BattleNotic` (:136-143) |
| numCount | 101..105 | - | - | labels "1".."5", keys 1..5 | :66 |

- **Data** (`Controller:80-140`):
  - `ChildManager.model.getChildById(heroInfo.headId)`. `fightSkill` (CSV of SonTypes, "-1" = empty) is matched against `child.skill` (CSV of IDs) by `SonType` (:93-115).
  - **Priority 3 skills get `CoolDown` overwritten to 30000** (`PROFOUND_CD_TIME`), mutating the template (:45, 116-119).
  - Adds `changeSkills` 700003 and 700004 (:128-132).
  - Sequence: `setEnable(false)` → `initView` → `initCD` → `setEnable(true)` (:133-139).
  - `ABYSM_FIGHT_INFO_UPDATA` reinitializes the list (:69).
- **Energy (awaken):** `refreshForSpChanged` acts only on **Priority==3** skills. With `selfChildHeroInfo.awaken<100`: disabled + state 1 (if enabled), otherwise only state 1. With awaken≥100: enable. Exits if `totalBloodA<=0` (`View:180-219`). `CHILD_AWAKE_SKILL` → `refreshItemState` (`Controller:160-171`).
- **CD:** lookup by `TemplateId` only, returns first item (`View:98-124`).
- **Send:** `__skillUse` ignores if `isWaitingChangeBody` or `!isChildBattle`. Calls `gameChildCommand(battleId, child.livingId, TemplateId)` = **opcode 10516** (`Controller:187-215`; `SSM:228-236`).
- **Nswar:** `childnswar.battle.UseAdd` (sent by clicking `ChildNswarCallIcon`, `BOT/ChildNswarCallIcon.as:75`) calls `childnswarSkill(battleId, livingId, idx)` = **25240**, idx 3 or 4 (`Controller:217-227`; `SSM:238-246`).
- **Response 75:** requires `isChildBattle` (:252).
  - Success for own hero: `SHOW_SKILL_USE_SUCCESS_BattleNotic` [info, QTETime (if not auto), castTime, targets] (:296-316).
  - Failure: re-enables after 1000 ms if hero alive (:331-372).
  - Always sends `USE_SKILL_RESULT` {skillId,result} (:287-293).
- **Death:** event `die` → `setEnable(false)` (:142-153). `restrictChanged` → `setEnable(true)` (:155-158).

#### `MonsterCommonSkillItemListView` / `MonsterCommonSkillItemListController`

- **Creator:** `MonsterCommonBottomBar` (`BOT/MonsterCommonBottomBar.as:41`), at (-135,-65) (:46-48).
- Condition: `isMonsterBattle`, i.e. **battleType==3884** (`BM:551-558`; `BUV:1183-1185, 1305-1307`).
- Background `asset.battle.AbysmBattleBack`, hpTxt `battle.AbysmHpValueText`. No sp, no settingBtn (:38-49).
- HP reaches 0: `isOver=true` and notification `FORCE_SKILL_ENABLE` false (:76-90).
- View same as ChildCommon except **paddingH 5** (step 55) and no `refreshForSpChanged` (`ui/MonsterCommonSkillItemListView.as:50-76, 144-171`).

| field | class | x,y | z | condition | events |
|---|---|---|---|---|---|
| `container` | TileContainer w600, paddingH 5 | 0,0 | 1 | recreated in `initView` | :39-55 |
| slots 0..4 | `BattleSkillItemII()`, w50 | i·55, 0 | i | data null → lock | click → `ACTION_SKILL_BattleNotic` (:130-137) |

- **Data:** `MonsterManager.model.monsterDic[selfMonsterRoleInfo.monsterId].activeSkillAry[0..4]`, ready-made objects (`Controller:73-88`). Init: `setEnable(false)` → init → `setEnable(true)` (:89-95).
- **Send:** requires `isMonsterBattle` and `_monsterRoleInfo`. Calls `gameMonsterCommand(battleId, monster.livingId, TemplateId)` = **10520** (`Controller:130-149`; `SSM:248-256`).
- Response and death work as in ChildCommon, filtered by `isMonsterBattle` (:160-216, 98-109).

#### `AvengerBattleSkillView`

- **Creator:** `BottomBar`, if `selfHero.heroInfo.isAvenger && selfHero.avengerFightSkills.length>0` (`BOT/BottomBar.as:102-110`).
  - Position: `(_back.x-110, _back.y+100)`, relative to `asset.battle.BottomBack`. Then calls `updateAvengerSp` and `updateAvengerSkills`.
  - `BottomBar` is the default bar (`BUV:1187-1195`): created when none of the conditions above apply, type is not 3895/3898 and not 35, 3896 or 349. In 3870 it is created together with `BattleSpaceTimeView`.
- View extends `Component` (`ui/AvengerBattleSkillView.as:30`).

| field | class/style (exact) | x,y (`styles.json`) | z-order | initial visibility | events |
|---|---|---|---|---|---|
| `_skillBack` | `creatBitmap("asset.SelfAvengerView.skillBack")` 309×103 | 0,0 | 1 | yes | - (:88,106) |
| `_avengerImage` | `creatComponentByStylename("SelfAvengerView.avengerImage")` (Image 182×24) | 15,18 | 2 | mask width 0 | SP bar (:89,107,127) |
| `_mask` | `new Component()`, `drawRect(15,18,w,24)` | - | 3 | - | :104-105,108,130-137 |
| `_splitLine` | `creatBitmap("asset.SelfAvengerView.splitLine")` 182×24 | 15,18 | 4 | yes | :90,109 |
| `_avengerSpCon` | `"SelfAvengerView.avengerSpCon"` | 30,0 | 5 | digits | :97,110 |
| `_fightSkillHbox` | `"SelfAvengerView.fightSkillHbox"` (HBox, spacing -4) | 23,40 | 6 | yes | :94,111 |
| `_waitView` | `"SelfAvengerView.waitView"` (Component) | 57,-152 | 7 | **false** | :98,112,122 |
| ↳ `_waitBg` | `"SelfAvengerView.waitBg"` (MutipleImage; imageRectString `0|156|0|170|13,7|68|8|156|13,80|68|8|156|13`) | 0,0 | 1 in waitView | - | :91,118 |
| ↳ `_majorText` | `"SelfAvengerView.majorText"` (arial 14 0xe9c68c, center, 75×20) = "Principal" | 3,15 | 2 | - | :92,119,124 |
| ↳ `_minorText` | `"SelfAvengerView.minorText"` = "Secundário" | 80,15 | 3 | - | :93,120,125 |
| ↳ `_waitSkillCon` | `"SelfAvengerView.waitSkillCon"` | 13,12 | 4 | - | :95,121 |
| `_closeImage` | `creatBitmap("asset.SelfAvengerView.closeImage")` 51×50 | 128,44 | 8 | **false** | :100,113,123 |
| `_openBtn` | `"SelfAvengerView.openBtn"` (BaseButton, back `asset.SelfAvengerView.openBtn`) | 128,44 | 9 | yes | click → toggle waitView (:99,114,177,284-291) |
| `_leftTimeText` | `"SelfAvengerView.leftTimeText"` (arial 14 red, 40×20) | 135,60 | 10 | "" | :101,115 |
| `_btnKeyImage` | `"AvengerBattleSkillView.btnKeyImage"` (Image `asset.battle.SkillCountBack`) | 130,40 | 11 | yes | :102,116 |
| `_btnKeyText` | `"AvengerBattleSkillView.btnKeyText"` (parent `battle.SkillBigCount`) = "M" | 143,82 | 12 | yes | :103,117,126 |
| `_numBit` | `creatBitmapData("asset.SelfAvengerView.numBmd")` (130×18) | - | - | - | :96 |
| fight 0..1 | `BattleSkillItemII()`, numCount **200, 201** (keys **B, N**), in `_fightSkillHbox` | HBox | - | enable via `setEnable` | click → `__skillClick` (:148-157) |
| wait 0..3 | `BattleSkillItemII()`, numCount **202..205** (**U, H, I, J**), in `_waitSkillCon` | x = (i<2 ? 0 : 75), y = (i%2)·60+30 | - | `parentEnable=true`, `buttonSkiner.enable=true` fixed | click → `__waitSkillClick` (:159-172) |

- **Data:**
  - fight: `selfHero.avengerFightSkills` → `skillTemplateDic`, `sortOn("MasterType", NUMERIC)` (:364-375).
  - wait: `avengerAllSkills` minus fight skills, `sortOn(["MasterType","Index"])` (:377-391).
  - fight and wait slots are **not locked** when data is null.
- **SP (Avenger energy):** `updateAvengerSp(sp)`:
  - Mask width = `182*sp/avengerSpMax`.
  - Displayed number = `int(sp/10)`. Digits cut as 12×18 with 13 px step in the bitmap, placed with 10 px spacing (:327-339; `core_module/scripts/yishi/utils/NumberViewUtils.as:158-185`).
  - `refreshSkillStateByAvengerSp`: if `avengerSp<Cost`, disabled + state 1. Acts only on fight items; exits if `totalBloodA<=0` (:219-252).
- **Wait time:** `SYSTIME_UPGRADE_SECOND` (per-second tick):
  - If `avengerWaitSec>0`: text shows seconds and the **client decrements `avengerWaitSec`**; `closeImage` visible; `openBtn` and `waitView` hidden.
  - Otherwise: empty text, `closeImage` hidden, `openBtn` visible (:254-270).
- **Keyboard:** keyDown 'M' or 'm' (`VK_M`, +32) toggles `waitView`, blocked during wait (:272-282).
- **Fight click:** requires `TemplateId ∈ avengerFightSkills`, sends `ACTION_SKILL_BattleNotic` (:293-306). Actual sender is the main `SkillItemListController`, via `gameCommand` = **10008** (`ui/SkillItemListController.as:631-716`, send at :711; `SSM:208-216`).
- **Wait click:** exits if waiting or ID not in `getWaitSkillIds()`. Sends `AVENGER_SKILL_REPLACE` (:308-325).

#### `AvengerSkillItemListController`

- **Constructor:** `initSkillCd()` (cooldownInfo, like the other lists) and `view.setEnable(true)` (`ui/AvengerSkillItemListController.as:34-61`). CD lookup only on fight items, by `TemplateId` (:63-91).
- **`ACTION_SKILL_BattleNotic`:** exits if `isWaitingChangeBody`, battleType ∈ {**3844, 3845, 3847, 16, 3868**} or `isChildBattle`. Otherwise only `view.setEnable(false)` (:129-160).
- **`AVENGER_SKILL_REPLACE`:** same filters. Calls `sendBattleAvengerChange(battleId, skillId, livingId)` = **opcode 10521** (:231-271; `SSM:268-276`).
- **Response 75:** ignores battleType ∈ {**3844, 3845, 3847, 3867, 3868, 3866, 3864, 3889**}. If `result!=0`, re-enables after 1000 ms if alive (:169-229).
- **`BUFFER_SKILL_ENABLE`** (per fight item):
  - Blocking buffer present: disabled, state 1, `addChild(banImg)`.
  - Otherwise: removes ban and re-enables (state 0) only if alive, no ready skill (`currentReadySkillId==-1`), `avengerSp>=Cost` and **battleType!=25** (:273-326).
- Hero events (:103-108, 328-377):
  - `die` → `setEnable(false)`.
  - `AVENGER_SP` → `updateAvengerSp` (fired at `HeroRoleInfo.as:240`).
  - `AVENGER_SKILL_CHANGE` → `updateAvengerSkills`.
- `restrictChanged` and `SKILL_ENABLE` → `setEnable` (:340-359).

#### `PetSacristyItemListView` / `PetSacristyItemListController`

- **Creator:** `PetSacristyBar` (`BOT/PetSacristyBar.as:51`), at (-168,-68).
- Condition: `isSacristyBatle`, i.e. **battleType 3866 or 3864** (`BUV:1169-1171, 1973-1980`; addChild at 1281-1283). Layout hides `consortiaChatBtn` and auto-fight (`BUV:884-920`).
- `PetSacristyBar` elements, in order:
  - background `creatBitmap("asset.battle.sacristy.skillBg")` 515×96, at (-w/2,-h);
  - `PetSacristyAwakenView` (116,-142);
  - `SelfBufferView` (-132,-104);
  - the list;
  - `asset.battle.sacristy.BottomTextBack` (style -239,-20);
  - `SelfBloodView(this,-238,-89,1)`.
  - **No settingBtn**; handler `onSettingBtnClick` exists but is not wired (:39-60, 101-109).
- View extends `Sprite` (`ui/PetSacristyItemListView.as:12`).

| field | class/style | x,y | z | condition | events/opcodes |
|---|---|---|---|---|---|
| `container` | TileContainer w600 | **29**,4 | 1 | - | :39-43 |
| slots 0..4 | `BattleSkillItemII()`, `{width:44.5}`, numCount 101..105 (keys 1-5) | i·54.5, 0 | i | data null → lock | click → `SACRISTY_SKILL` (:47-67) |
| `_childSkillItem2` (relic) | `BattleSkillItemII(3)` (circle, icon 60×60) | **322,-15** | 2 | always; enable depends on awaken | numCount **18** = key **'e'** (lowercase only), label "E"; click → `updateChildSkillItem(99)` + `SACRISTY_SKILL` (:68-75, 153-171) |

- **Data:** `PetSacristyManager.instance.petSkillMsg.skillId[0..4]` and `relicSkillId` (`Controller:56-74`).
- **Relic:** `updateChildSkillItem(awaken)` enables (state 0) only if `childSkillDark` (= the list's current `_enable`) **and** `awaken>=100`; otherwise disabled + state 1 (`Controller:304-317`).
  - Source: `PetSacristyManager.awake` on `UPDATE_PET_POWER` and at init (:79, 88, 298-302).
  - View `setEnable`, for the relic: `childSkillDark=_enable` + `updateChildSkillItem(controller.awaken)` (`View:192-196`).
  - After use, `updateChildSkillItem(99)` darkens the relic again (`View:168`).
- **Send:** `sendUsePetSacristySkill(battleId, selfHero.livingId, TemplateId)` = **10519** (`Controller:147-167`; `SSM:287-295`).
- **`SKILL_ENABLE`/`restrictChanged`:** if `battleModel.isOver` or `selfHero.restricted`, calls `cancelReadyState`, `setEnable(false)` (`Controller:114-145`).
- **Response 75: no battleType filter.** Includes `SonType 20010` → `__clearCD` (:178-248).
- **`BUFFER_SKILL_ENABLE`:** re-enables only if `sp+Cost>=0 && hitPoint+HitPointCost>=0`, alive, no ready skill, battleType!=25 and **not the relic** (:319-374).
- **Death:** `setEnable(false)`, relic disabled + state 1 (:283-296).

#### `SkillWarsoulView`

- **Creator:** `BottomBar` if `VersionSwitch.WARSOUL` (default `true`, `core_module/scripts/yishi/datas/VersionSwitch.as:232`), at (-235,-116) (`BOT/BottomBar.as:113-119`).
- With WARSOUL active, `SelfBufferView` moves to (-165,-144) (:146-150).
- Appears in any battle that has `BottomBar`.
- Does not depend on the hero owning a warsoul: slots without a skill show the lock (see `BattleWarsoulSkillItem`).
- View extends `Sprite` (`ui/SkillWarsoulView.as:30`).

| field | class/style | x,y (`styles.json`) | z | visibility | events |
|---|---|---|---|---|---|
| `_bg` | `creatBitmap("asset.battle.warsoul.containBg")` 179×51 | 0,0 | 1 | yes | :72,78 |
| `_spBg` | `creatBitmap("asset.battle.warsoul.spBg")` 129×37 | 22,-15 | 2 | yes | :73,79 |
| `_spBar` | `creatBitmap("asset.battle.warsoul.spBar")` 109×12 | 33,3 | 3 | mask | :74,80,91 |
| `_spLine` | `creatBitmap("asset.battle.warsoul.spLine")` 114×15 | 29,1 | 4 | yes | :75,81 |
| `_hbox` | `creatComponentByStylename("battle.warsoulHBox")` (HBox, spacing 0) | 38,18 | 5 | yes | :76,82 |
| `_spTxt` | `"battle.warsoul.spTxt"` (arial 12 white bold center, glow 0x16928d, 50×20, mouseEnabled false) | 21,-13 | 6 | text = SP | :77,83 |
| `_spMask` | `Shape`, fill 0xFF0000, at `_spBar` position | 33,3 | 7 | - | :84-91 |
| items 0..2 | `BattleWarsoulSkillItem`, `width=height=34`, `parentEnable=true` | in HBox (step 34 *(assumption: HBox uses item width)*) | - | data = `getSkillById(warsoulSkills[i])` if >0, else null | :93-123 |

- **SP:** `updateSp(sp)`: text = sp; mask width = `int(sp/100*spBar.width)`, i.e. max 100 (:126-135). Event `WARSOUL_SP` comes from `HeroRoleInfo.as:259` (:175, 428-431).
- **`refreshSkillStateByWarsoulSp`:** `warsoulSp<Cost` → disabled + state 1; else enabled + state 0. **Does not check `_enable`.** Exits if `totalBloodA<=0` (:137-164).
- **Use** (notification `Warsoul.skillUse`, sent by the item):
  - Ignored if `isWaitingChangeBody`, battleType ∈ {**3844, 3845, 3847, 16, 3868**} or `isChildBattle`.
  - `setEnable(false)`, sends `gameCommand2(battleId, livingId, TemplateId)` = **10522**.
  - If `newbieProcess<19000`, calls `NewbieSocketOutManager.sendBattleContinue()` and delays the send by 400 ms (:308-366; `SSM:218-226`).
- **Does not listen to `SKILL_ENABLE`.** Only `restrictChanged` → `setEnable(true)` and `die` → `setEnable(false)` (:166-177, 303-306, 384-394).
- **Response 75:** same exclusions as Avenger (3844, 3845, 3847, 3867, 3868, 3866, 3864, 3889). Failure → `setEnable(true)` after 1000 ms (:192-252).
- `BUFFER_SKILL_ENABLE`: like Avenger, but with `warsoulSp` and no battleType 25 check (:254-301).
- **No CD, no keyboard.**

#### `BattleWarsoulSkillItem`

| field | class/style | x,y | z | visibility | events |
|---|---|---|---|---|---|
| `_iconContain` | `creatCustomObject("asset.battle.SkillItemCDFlashAsset")` | 0,0 | 1 | yes | :66,74 |
| `_icon` | `creatCustomObject("battle.warsoul.SkillItemView")` (BaseIconView 47×47 at 4,6, tip `SkillTips`), inside `_iconContain.container` | 4,6 | - | - | click → `__iconClick` (:67,78,83) |
| `_downMc` | `asset.battle.DownMc` | 3,4 | 2 | false | :68,72,75 |
| `_overMc` | `asset.battle.OverMc` (**added here**, unlike BattleSkillItemII) | 3,5 | 3 | yes | tween to frame 10 on hover, frame 1 on normal (:69,76,162-184) |
| `_lockImg` | `asset.battle.BattlePropLockAsset` | 0,0 | 4 | visible if data==null | :70,77,196-211 |
| `_banImg` | `asset.battle.BanAsset` | 3,4 | (via buffer) | - | :71 |

- Constructor sets `buttonSkiner.enable=false` (:56-62). Enabled = no filter + buttonMode; disabled = dark filter (:150-160).
- **Click:** requires not locked, visible, data, enabled, icon not removed, and `selfHero`. Sends `Warsoul.skillUse`. **Does not call `setAutoFight`** (:111-148).
- `setState` uses the same codes as BattleSkillItemII, including forced gray under boss control (:218-240).

### 6.2 Differences from the main bar (`SkillItemListView` / `SkillItemListController`)

| Aspect | Main | Variants |
|---|---|---|
| Slots | 5 normal `{width:44}` in `container` (29,4), numCount 1..5 (keys 1-5 via the `+48` path, with newbie block 12500). Seal shape1 (-14,-40) numCount 6=Q; marriage shape1 (431,-38) 7=E; child shape2 (584,2) 8=R and (637,2) 9=F; 2 `PropSkillBattleItem` `{width:53}` in `_propContainer` (322,4), absent in 3870 (`ui/SkillItemListView.as:159-260`) | Pet/ChildPve: 10 slots (101..110). Sacristy: 5 + relic (18=E). ChildCommon/Monster: 5 (101..105). Avenger: 200..205. Warsoul: no key |
| Seal locked | Locked if `!isOpenSealSkill`, forbidden boss map, or battleType ∈ {3902, 3904, 3907, 3905, 3906} (:197-202) | - |
| Send | `ACTION_SKILL` → 10008 (`gameCommand`); marriage, child and stone have their own methods (`ui/SkillItemListController.as:675-713`) | 14001 (Pet/ChildPve), 10516 (Child), 25240 (nswar), 10520 (Monster), 10519 (Sacristy), 10521 (Avenger: swap), 10522 (Warsoul) |
| Enable | Handles boss (`setBeControled`) and `isWaitingChangeBody`, plus SP and awaken (`ui/SkillItemListView.as:504-549`) | Only `useCount` (Pet/ChildPve/Sacristy/Monster); awaken≥100 for Priority 3 (Child); avengerSp; warsoulSp |
| CD lookup | by TemplateId and Parameter3 | Pet/ChildPve/Sacristy same; Child/Monster/Avenger TemplateId only (1st item) |

### 6.3 battleType conditions (consolidated)

| value | effect | file:line |
|---|---|---|
| 16 | click on any BattleSkillItemII ignored (before autoFight) | `ui/BattleSkillItemII.as:388-391` |
| 16, 3844, 3845, 3847, 3868 (+ `isChildBattle`) | skill use ignored: main, Avenger (`__skillUse` and replace) and Warsoul | `ui/SkillItemListController.as:647-670`; `ui/AvengerSkillItemListController.as:135-158, 239-262`; `ui/SkillWarsoulView.as:320-343` |
| 25 | `BUFFER_SKILL_ENABLE` does not re-enable (Avenger, Sacristy, main) | `ui/AvengerSkillItemListController.as:312`; `ui/PetSacristyItemListController.as:359`; `ui/SkillItemListController.as:1216` |
| 35, 307 | `isWatchOnly` exists but unused (Pet/ChildPve) | `ui/PetSkillItemListController.as:105-116`; `ui/ChildPveSkillItemListController.as:110-121` |
| 35 (`isPetChallenge`), 3896, 349 | no `BottomBar` created | `BUV:1192, 1919-1935, 1982-1989` |
| 3844 | creates `PetBattleBar` (Pet list); Pet controller processes response 75 only here | `BUV:1165-1167, 1964-1971`; `ui/PetSkillItemListController.as:183` |
| 3845 | creates `ChildpveBattleBar`; controller processes the response only here; keys with numCount<100 blocked | `BUV:1173-1175, 2000-2007`; `ui/ChildPveSkillItemListController.as:188`; `ui/BattleSkillItemII.as:423-426` |
| 3864, 3866 | creates `PetSacristyBar` | `BUV:1169-1171, 1973-1980` |
| 3867, 3868, 3847, 3889, 3895, 3896, 3898, 3911 | `isChildBattle`; keys with numCount<100 blocked | `BM:514-549`; `ui/BattleSkillItemII.as:419-422` |
| 3867, 3868, 3847, 3889, 3911 (and 3896, but no addChild) | creates `ChildCommonBottomBar` | `BUV:1177-1181, 1301-1303` |
| 3895, 3898 | no skill bar, only settingBtn | `BUV:1177, 1289-1300` |
| 3911 | ChildCommon in nswar mode: offset 54, background `nswarBg`, HBox with 2 call icons | `BOT/ChildCommonBottomBar.as:58-88`; `BUV:983-989` |
| 3884 | `isMonsterBattle` → `MonsterCommonBottomBar` | `BM:551-558`; `BUV:1183-1185` |
| 3870 | `BottomBar` + `BattleSpaceTimeView`; main bar does not create prop items | `BUV:1187-1190`; `ui/SkillItemListView.as:243-246` |
| 3844, 3845, 3847, 3867, 3868, 3866, 3864, 3889 | response 75 ignored by Avenger and Warsoul (and main) | `ui/AvengerSkillItemListController.as:176-207`; `ui/SkillWarsoulView.as:199-230`; `ui/SkillItemListController.as:863-891` |
| 3902, 3904, 3905, 3906, 3907 | main bar seal locked | `ui/SkillItemListView.as:197` |

Other conditions:
- No condition on side, `useWay`, `isSpectator`, `battle_from` or VIP in these classes (verified with grep).
- Newbie level (`newbieProcess<19000`) affects only Warsoul (`ui/SkillWarsoulView.as:353`).
- Main bar prop items unlock at grade 35 and grade 40 (`ui/SkillItemListView.as:252`).

### 6.4 Findings

1. **ChildPve uses the pet opcode (14001)**, `sendUsePetBattleSkill`, which sends no heroId (`ui/ChildPveSkillItemListController.as:154`).
2. **ChildPve shifts skills:** IDs 0 are skipped with `continue` before `push` (`ui/ChildPveSkillItemListController.as:64-71`).
3. **3896 (YL Expedition) creates a `ChildCommonBottomBar` that is never added** to the display list (`BUV:1177-1181` vs 1293-1296). Item keyboard listeners only check the item's own `visible`, so keys 1-5 may trigger send 10516 with no visible bar *(runtime assumption)*.
4. **`_overMc` is never added in BattleSkillItemII**, so the hover tween never shows. In `BattleWarsoulSkillItem` it is added (`ui/BattleSkillItemII.as:252-266` vs `ui/BattleWarsoulSkillItem.as:76`).
5. **Bug in `SkillWarsoulView.setEnable`:** inside the loop, `_enable = (warsoulSp>=Cost)` overwrites the global flag, so the first item lacking SP disables the following ones (`ui/SkillWarsoulView.as:416-420`). Also, `refreshSkillStateByWarsoulSp` re-enables items by SP without checking `_enable` (:137-164).
6. **PetSacristy `dispose` removes `REMOTEPET_SKILL`** instead of `SACRISTY_SKILL`, and does not remove `BUFFER_SKILL_ENABLE`: listeners leak (`ui/PetSacristyItemListController.as:379`).
7. **ChildCommon mutates data:**
   - `getSkillTempInfoById` does `skills.push(changeSkills...)` on every call (:384-385).
   - `changeSkills` grows on every reinit (:130-131).
   - Priority 3 overwrites `CoolDown=30000` in the template (:116-119).
   - `_loc4_` is not reset between slots, so an unmatched slot inherits the previous skill, or throws NPE if first (:101-120).
8. **PetSkillItemListController does not register `restrictChanged`** despite having the handler (:134 vs 74-79).
9. **Clicking any `BattleSkillItemII` calls `setAutoFight(2)` before checking enable and CD**, which can send 10020 even when the click has no effect (`ui/BattleSkillItemII.as:392`).
10. **Avenger:**
    - Client decrements `avengerWaitSec` locally every second (`ui/AvengerBattleSkillView.as:259`).
    - Wait-slot keys U/H/I/J work with the panel closed, because the check is the item's `visible`, not the panel's (`ui/BattleSkillItemII.as:427-430, 487-497`).
    - "M" key text sits at y=82 while the key background sits at y=40 (`styles.json`); may be a real asset misalignment.
11. **Sacristy relic key accepts only lowercase 'e'** (charCode 101), no uppercase variant (`ui/BattleSkillItemII.as:478`).
12. Backgrounds `asset.battle.remotepetBack` (712×81), `asset.battle.sacristy.skillBg` (515×96), `asset.battle.AbysmBattleBack` (514×97) and `asset.battle.nswarBg` (622×97) **have no `styles.json` entry**. They exist only as symbols in `battle.swf` (`index/ui_symbols.json`); x,y come from code *(assumption: `creatBitmap` falls back to direct linkage)*.
13. `PetSacristyBar` has no settings button, though it has the handler (`BOT/PetSacristyBar.as:101-109`).
14. Unconfirmed Warsoul points:
    - Final size of `BattleWarsoulSkillItem` is forced by `width=34` on a Sprite, which becomes scale. Bounds include the 56×56 lock, so scale should be near 0.6 *(assumption)*.
    - Actual HBox spacing depends on this *(assumption)*.

---

## 7. Damage numbers, QTE, skill name and unit layers

All cited lines were checked with `cat -n`, `sed -n` and `grep -n`. Full paths are relative to `decompiled/`; short paths starting with `battle/` or `yishi/` are relative to `core_module/scripts/`.

Timeline data (frames, matrices and MovieClip alpha) was read in memory only, with `tools/swflib.py`, from `raw/ui/zh_cn/swf/battle.swf` and `qte.swf`. Frame scripts come from `build/ffdec_ui_scripts/battle.swf/...`. These paths are relative to the project root and are marked **[SWF]**.

Runtime fps is 25: `Loading/scripts/Loading.as:40` declares `frameRate="25"`. The UI swf declares 24, but Flash uses the main stage fps. Durations in seconds below are therefore marked *(assumption: 25 fps)*.

### 7.1 Damage numbers

#### Call flow up to creation

| step | where | what it does |
|---|---|---|
| 1 | `core_module/scripts/battle/actions/DannyAction.as:140` | `crit = extraData & 1` |
| 2 | `DannyAction.as:142-145` | `isDefault = (no template \|\| UseWay==3)` |
| 3 | `DannyAction.as:146-150` | `updateBlood(-damageValue, -displayBlood, crit, bloodType, selfCause, isDefault, parry, fire)`. Not called on the invincible world boss: battleType **17** + `wordBossInvincibleState` + type 3 + face 2. |
| 4 | `DannyAction.as:132` | Hit flash: `ColorTransform` with offset `0x666666` (6710886, from callers at `BattleUtils.as:302`, `BaseSkill.as:779`, `ShootFrameExecuter.as:215`), only if `damageValue>0`. |
| 5 | `selfCause` | `true` when the attacker is `selfHero`: `ShootFrameExecuter.as:202-205`, `BaseSkill.as:765-768`. |
| 6 | `fire` | Buff `AttackType == 316` (`battle/handler/BufferHandler.as:71`). |
| 7 | `yishi/datas/objects/RoleInfo.as:318-338` | Queue with 2-frame CD: `_bloodUpdateCD = 2` (`RoleInfo.as:336`, `RoleInfo.as:594-605`). |
| 8 | `RoleInfo.as:369-378` | Dispatches `"bloodChange"` with `{bloodType, blood, displayBlood, havoc(=crit), selfCause, isDefault, isParry, isFire}`. |
| 9 | `core_module/scripts/battle/view/roles/RoleViewBase.as:1058-1144` (`__blood`) | Creates `DamageNumView` with `new`, **no pool**. |

Sign: damage arrives as negative `displayBlood` (red number). Healing arrives positive (green number) (`RoleViewBase.as:1079-1086`).

#### `RoleViewBase.__blood`: conditions by bloodType (`RoleViewBase.as:1066-1143`)

| condition | effect | line |
|---|---|---|
| `displayBlood==0 && bloodType!=7` | nothing | 1073-1076 |
| bloodType **6**, value < 0 | `new DamageNumView(abs, type, isAdd=false, selfCause, parry, fire)` | 1077-1082 |
| bloodType **6**, value > 0 (heal) | `new DamageNumView(abs, type, isAdd=true, selfCause, parry)` (fire not passed) | 1083-1086 |
| bloodType 6 on world boss | `BloodHelper.worldBossBloodCached += blood` | 1087-1091 |
| bloodType **7** (troop) and **8** | `new DamageNumView(0, ...)`: shows **"0"** | 1095, 1113 |
| bloodType **10** (revive) | only `updateStrip()`. Boss type 3 in battleType **310** with `BossBottomStrip` calls `resetView()`. | 1097-1105 |
| bloodType **21** (max HP) | only `updateStrip()` | 1106-1110 |
| others (9 SP, 24, 26…) | `return`: **no number** | 1111 |

`type` (2nd param) is **2 on crit** (`havoc`), **1** otherwise (`RoleViewBase.as:1068`).

Side effects:
- `selfCause && !isDefault` → `map.shakeScreen(4, 24)` on crit, `shakeScreen(4, 12)` on normal (`RoleViewBase.as:1115-1125`).
- Crit on target `selfHero` → `battleScene.playRedScreen()` (`RoleViewBase.as:1126-1132`).

Position: the unit's local point `(0,-130)` is converted to `map.effectContainer`. On crit, `y -= 50`. The number is added to the **map's effectContainer**, above all units (`RoleViewBase.as:1133-1142`). Then `updateStrip()` (`RoleViewBase.as:1143`).

#### `DamageNumView`

Source: `core_module/scripts/battle/view/ui/DamageNumView.as`.

Constructor `(n, type=1, isAdd, selfCause, isParry, isFire)` (`DamageNumView.as:62-85`):
- `type==2` → `ComponentFactory.Instance.creat("asset.battle.BloodUpdateRage")`; else `creat("asset.battle.BloodUpdateAsset")` (`DamageNumView.as:71-78`).
- `_parry = creatBitmap("asset.battle.ParryAsset")` (`DamageNumView.as:79`).
- `_pic = getPercent(n)` is added to `_animationMC.container` (`DamageNumView.as:80-83`). The MovieClip starts stopped.
- On `addedToStage` (`DamageNumView.as:147-175`):
  - registers `playEnd` on the last frame (`addFrameScript(totalFrames-1)`);
  - centers `_pic`: `x = -w/2`, `y = -h/2`; on heal `y = -h/2 - 20`;
  - **crit with `BattleManager.criticalNum > 1`**: random offset `x += 120·r`, `y += 60·r`, `r ∈ (-1, 1)` (`getRandomNum`, `DamageNumView.as:283-295`);
  - then `gotoAndPlay(1)`.
- `playEnd` decrements `criticalNum` if crit, removes and disposes (`DamageNumView.as:133-145`).
- Text: `FormularySets.toStringByNum(n, 99999)`. Above 99999 becomes `n/1000 + "K"` **without rounding** (e.g. `"123.456K"`; `core_module/scripts/yishi/utils/FormularySets.as:70-83`; `public.Thousands = "K"` in `index/language.json`).

Style per case (`getPercent`, `DamageNumView.as:177-281`; formats from `index/styles.json`):

| case | style (exact name) | font / color | scale | line |
|---|---|---|---|---|
| heal (`isAdd`) | `creatComponentByStylename("battle.GreenNumberAssetSp.text")` | arial 40, `0x5EEF26` | 1 | 183-191 |
| normal, `selfCause`, no parry | `"battle.DamageNumberAssetSp.text"` | arial 40, `0xF1FA61` (yellow) | 1 | 206-209 |
| normal, **parry** (with or without selfCause) | `"battle.SelfCauseNumberAssetSp.text"` | arial 40, `0x23B3E8` (blue) | **0.6** | 199-205, 211-217, 269-273 |
| normal, others | `"battle.RedNumberAssetSp.text"` | arial 40, **`0xF4FFCC`** (yellowish white, not red) | 1 | 218-221 |
| crit (`type!=1`) | `creatCustomObject("battle.CriticalDamageNumAssetSp")`, field `txt` | [SWF] TextField 76×124, size 50, `0xFFF44B`, center, filters gradientBevel orange/red + dropShadow 3px + black glow | 1 (0.6 if parry) | 243-252 |

- FilterFrameTexts use `filterString core.normal_f` = black GlowFilter (1, 5, 5, 3), height 60, `letterSpacing 1`, **left** align.
- Field width is `textWidth + 50` (`DamageNumView.as:190,223`). With left align, the visual center sits about 25 px left of the point.
- Fire (only `type==1` and `isFire`): `creatBitmap("asset.battle.fireImg")` at `x = txt.x - 45`, `y = -9`, added to `_numSp` (`DamageNumView.as:230-239`).

Animation [SWF], symbol 771 `BloodUpdateAsset`, 33 frames (about 1.32 s):
- Child `container` moves linearly from y=0.6 to y=-149.4 (≈ -4.69 px per frame), x fixed at 0.2.
- Alpha drops linearly from 1 to 0 (step 1/32). No scale.

Animation [SWF], symbol 775 `BloodUpdateRage` (crit), 40 frames (about 1.6 s):

| frames | `container` state |
|---|---|
| f1-f2 | scale 0.5 at (-12.05, 70.5) |
| f3-f7 | scale 1, shaking between (3,-7) and (14,-9) |
| f8-f23 | still at (3,-7) |
| f24 | scale 1.025, at (4,-9.55); rgb/alpha multiplier 0.9375, rgb +16 |
| f25 | scale 1.10, at (7.15,-17.25); multiplier 0.75, rgb +64 |
| f26 | scale 1.225, at (12.35,-30.1); multiplier 0.4375, rgb +143 |
| f27 | scale 1.4, at (19.6,-48); alpha 0, rgb +255 (brightens to white and vanishes) |
| f28-f40 | invisible; `playEnd` at f40 |

`updateData` (`DamageNumView.as:115-131`) and `key` (`DamageNumView.as:87-90`) only serve the unused pool.

#### `CreateDamageNumViewHelper`

Source: `core_module/scripts/battle/view/roles/CreateDamageNumViewHelper.as`.

- Pool keyed by `type + isAdd + selfCause + isParry` (`CreateDamageNumViewHelper.as:28-48`), with `push` (:50-57) and `dispose` (:59-77).
- **Never used to create numbers**. Only use: `CreateDamageNumViewHelper.ins().dispose()` at `m10/scripts/battle/view/BattleView.as:422`.
- Pool bug: when the list is non-empty, `getDamageNumView` does `pop` without `new` (:40-46). `push` does not reset `_isFire`.

### 7.2 QTE

#### Creators and listeners

1. Opcode **75** (`HeroOrderMsg`) is listened to by three controllers:
   - `core_module/scripts/battle/view/ui/SkillItemListController.as:243` → `__skillUseServerBack` (:842);
   - `MonsterCommonSkillItemListController.as:66`;
   - `ChildCommonSkillItemListController.as:73`.
2. Early returns, no QTE: battleType **3844, 3845, 3847, 3867, 3868, 3866, 3864, 3889** (`SkillItemListController.as:863-894`).
3. With `result==0` (`SkillItemListController.as:918-938`):
   - `qteTime = skillInfo.QTETime` **only if `!isAutoFight`** (:922-925); else 0 (:904);
   - if `isSelfUseSkill` (same livingId and battleType **≠ 307**, :1014-1021) and the hero is alive: `heroView.addCollectionEffect()` when not `MonsterRoleInfo` (:932-935), then `sendNotification("SHOW_SKILL_USE_SUCCESS_BattleNotic", [skillInfo, qteTime, castTime, aims])` (:936);
   - other heroes get `addCollectionEffect(false)` + `addSkillFlag(skillInfo)` (:941-952).
4. The Monster controller does the same: `QTETime` if not auto (`MonsterCommonSkillItemListController.as:225-228`), `addSkillFlag` and notification (:229-236). Child likewise (`ChildCommonSkillItemListController.as:303-314`).
5. `m10/scripts/battle/view/ui/BattleUIView.as:314` listens for the notification. `__skillUseSuccess` (`BattleUIView.as:1884-1901`):
   - if `data[1] > 0 && !battleModel.isControledByBoss()`: discards the previous QTE, `new QteView(data)`, `addChild`, positions at `x = (sceneW - qte.width)/2`, `y = sceneH - 280`;
   - if not auto, calls `battleMap.addSkillAimFlag(data[3])` on the targets.
6. Resize repositioning: `BattleUIView.as:776-780`, with `sceneW ∈ [1000,1500]` and `sceneH ∈ [600,900]` (:766-767).
7. Send: `BattleSocketOuterManager.sendQTE(battleId)` → **10015** `QteMsg{serverName, battleId}` (`m10/scripts/battle/net/BattleSocketOuterManager.as:19-26`).

#### `QteView`

Source: `m10/scripts/battle/qte/QteView.as`.

- `time = int(data[1])`, in ms (`QteView.as:51`). The setter calls `start()`: `Timer(time - 300 - 100)`, i.e. **time - 400 ms**, **repeating** (:61-84). Also schedules `showTimeView` in **800 ms** (:70).
- `_qteNum = int(time / 1500)` (:52). Constants `QTE_NUM=3`, `800` and `300` at :21-25.
- `initView` (:86-106), z order (bottom to top):

| order | element | position |
|---|---|---|
| 1 | `_timeView = new QteTimeView()` | `y = -52`, invisible; `x = qteCom.getCenterPosX() - 30` |
| 2 | `_skillUseView = new SkillUseItemCell()` (if `data[0]`) | (0,0), icon `IconFactory.getTecIconByIcon(skill.Icons)`, `flash()` |
| 3 | `_qteCom = new QTEComponent(_qteNum, qteComplete)` | (0,0) |

  `mouseEnabled = false`.
- `showTimeView`: makes visible and sets `time = (time - 800 - 300 - 100)/1000` seconds (:73-77). The ring ends together with the timeout.
- Success, `qteComplete` (:108-112): `setEffect(true)`. Timeout, `__time` (:201-204): `setEffect(false)`.
- `setEffect` (:123-136): `qteCom.setEffect(ok)`, `skillUseView.tweenEffect` (gotoAndPlay `"out"`), and `setTimeout(sent, 400)`.
- `sent` (:138-147): stops the timer; on success calls `setUseSkillState()` and sends **10015**; then disposes. On failure **nothing is sent**.
- `setUseSkillState` (:149-163): start point at QTE center, end point at `(0,-65)` of selfHero's `effectContainer`, then `showQteSuccessEffect`.
- `width` = `_qteCom.width` (:165-172).

#### `QTEComponent` and `QteItem`

Source: `core_module/scripts/simplegame/qte/QTEComponent.as`.

- Assets: `ClassUtils.CreatInstance("asset.qte.QTEShowEf")` and `CreatInstance("asset.qte.QTESuccess")` with `y = 55` (`QTEComponent.as:53-57`).
- `HBox` with `spacing 2` at **(47,-4)** (:75-80). `_qteNum` items; each key is drawn at random from `"ASDW"` (:25, :82-89).
- `_successEff.x = hBox.x + hBox.width/2` (:62).
- After **200 ms**, `showEff.scaleX = n/3` and play (:68, :92-96).
- Width = `47 + (itemW + 2)·n` (:195-202); item is 50 px [SWF].
- Keyboard: `stage keyDown` with priority 200 (:100). Arrows: 37→A, 38→W, 39→D, 40→S; other keys use `String.fromCharCode(keyCode)` (:112-131).
- Validation (:132-155): the key is compared against the **first item not yet hit**.
  - Wrong → `reset()`: **all items revert to "not hit"**, sequence restarts (:139-143, :175-181).
  - Last one hit → callback.
- `setEffect` (:158-173): removes the listener; success `successEff.gotoAndPlay(1)`, failure `UIFilter.setGrayFilter(this)`; all items `tweenEffect` (`"quit"`).
- `QteItem` (`core_module/scripts/simplegame/qte/QteItem.as`):
  - `creatCustomObject("asset.qte.QTEItem")`, `"asset.qte.QTEItemShowEf"` (child `qteIcon`) and `"asset.qte.QTEItemOkEffect"` (`QteItem.as:33-35`);
  - arrow rotation: W 0, D 90, S 180, A -90 (:60-75); `key.gotoAndStop(letra)` (:56);
  - hit: `arrow` and `bg` go to frame 2 and OkEffect plays (:82-96);
  - exit: `gotoAndPlay("quit")` (:98-101).
  - [SWF] item has bg 50×50, arrow 36×36 centered at (25,24), letter at (31,35); `QTEItemShowEf` has 15 frames, label `quit`.

#### `QteTimeView`

Source: `m10/scripts/battle/qte/QteTimeView.as`.

- `creatCustomObject("qte.QTETime")`: style points to `asset.qte.QTETime` at x=8, y=8 (`QteTimeView.as:29`).
- Mask is a Sprite with `rotation -90`, `scaleY -1`, at (29,29), applied as `time_mask.mask` (:30-37).
- `TweenLite.to(this, seg, {currentAngle: 360})` draws each step a sector of radius 20 from 0 to `currentAngle` (:40-51). Exact visual direction *(assumption: counterclockwise from top)*.

#### `QteSuccessAnimation`

Source: `core_module/scripts/battle/view/skill/QteSuccessAnimation.as`.

- Converts start and end points to the container (:30-36), but **animates nothing**: `_flyEffect`, `_icon` and `_iconAppearMc` are never created.
- `play()` schedules, in **800 ms**, `getSelfRoleView().updateQteCollectionEffect()` (:38-53), which switches the aura effect to the "qte" state (see `CollectionEffect` in §7.4).
- Created in `RoleViewBase.showQteSuccessEffect`, in `_effectContainer` (`RoleViewBase.as:1431-1445`), removed in `removeSkillFlag` (:1407-1411).

#### QTE state machine (t = 0 at creation)

| state | input | actions | exit |
|---|---|---|---|
| **INIT** | 75 with `result=0`, self, `qteTime>0`, not auto, not boss-controlled, battleType outside the exclusion list | creates items with random keys; starts Timer of `time-400` ms | immediate → SHOWING |
| **SHOWING** | - | at 200 ms plays `QTEShowEf`; at 800 ms the ring appears and runs for `(time-1200)` ms | any key → INPUT |
| **INPUT** | right key | marks the item; if last → SUCCESS | - |
| | wrong key | `reset()` of all items → INPUT | - |
| | Timer reaches `time-400` | - | FAIL |
| **SUCCESS** | - | `QTESuccess`, items `quit`, icon `out`; after 400 ms: aura in qte mode (+800 ms) and send **10015** | dispose |
| **FAIL** | - | gray filter, items `quit`; after 400 ms | dispose, nothing sent |

### 7.3 Skill name

#### `SkillNameLoader`

Source: `core_module/scripts/battle/view/skillname/SkillNameLoader.as`.

- `getSkillNameIds`: accepts `SonType ∉ {0,1}` and `UseWay == 1`, deduplicated (`SkillNameLoader.as:35-54`).
- Loads serially `PathManager.resourcePath + "skillName/" + SonType + ".png"` (:80-85, :100-111); cache keyed by SonType (:87-98, :128-131).
- Triggered in `CreateGameTransaction.as:482-488`; battleTypes **35/3844** use another skill list (:483-486). Also in `ResourceModel.as:568-581`.

#### `SkillNameContainer`

Source: `m10/scripts/battle/view/skillname/SkillNameContainer.as`.

- Listens to `"SHOW_SKILL_NAME_BattleNotic"` (`SkillNameContainer.as:20`). Removes the current name and creates `new SkillNameView(template.SonType)` at `x = -390/2` (:23-36).
- Lives in `BattleUIView`: created at :1401, `addChild` at :1421 above resistUI. Position `x = sceneW*0.5`, `y = 270 * (sceneW/1500)` (`BattleUIView.as:773-774`).
- Trigger (`core_module/scripts/battle/skillsys/skills/BaseSkill.as:257-271`, in `beforeRun`): attacker is a hero, `skillId ∉ {1,2,3,4}`, skill not default (`skillId==-1` or `UseWay==3`, :545-553) and:
  - battleType **∉ {35, 3844}** and attacker is **selfHero**; or
  - battleType **3844** or **35** and attacker is on selfHero's side.

#### `SkillNameView`

Source: `m10/scripts/battle/view/skillname/SkillNameView.as`.

- `_name` is the PNG from `resourceModel.getSkillName(SonType)`. **No PNG, nothing shown** (`SkillNameView.as:30-31`).
- `name.x = (294 - w)/2` (:33).
- Background: `creat("asset.battle.SkillNameBg")` ([SWF] bitmap 163×33) becomes a `ScaleBitmap` with `scale9Grid (40,10,80,10)`, `width = name.w + 2·49`, `x = (390 - width)/2`, `y = 8` (:34-39).
- Animation: `creat("asset.battle.SkillNameMC")`, `owner = this`, dispose on last frame (:40-43, :50-80). Fixed `width` 390 (:92-95).
- [SWF] `SkillNameMC` has 56 frames (about 2.24 s):
  - Background holder (depth 1) calls `owner.showBG(this)` on its frame 1 (`build/ffdec_ui_scripts/battle.swf/scripts/battle_fla/Timeline_37.as:40-43`). f1-f6: scale (0.7, 0.6) to 1, alpha 0 to 1. f1-f9: blurX 24 to 0.
  - Name holder (depth 7) calls `owner.showName` (`mz____39.as:42`). Enters at f3 (scale 1.25, alpha 0), settles at f8 (scale 1, at (49.1,-12.95)).
  - Two red glow strips (symbol 906, shape 181×23) sweep in opposite directions f1-f10, fading f8-f10.
  - Exit: f48-f53, scale 1.11 to 1.3, alpha to 0.

### 7.4 Units

#### `DepthSprite`

Source: `core_module/scripts/battle/view/utils/DepthSprite.as`.

Only stores `pointZ` and `pointY` (`DepthSprite.as:8-35`). Sorting is done by `BattleUtils.ManagerDepth`, which swaps children when `pointY` is smaller and index larger (`battle/utils/BattleUtils.as:276-300`).

`RoleViewBase.updateDepthInfo` (`RoleViewBase.as:814-834`):
- `pointY = point.y`, **+1** for selfHero, **+2** for Pet, **+2** with `arrangePriority`.
- `y = point.y - pointZ`, `x = point.x` (:777-778, :803-811).

#### `RoleViewBase`

Source: `core_module/scripts/battle/view/roles/RoleViewBase.as`.

Constructor (:154-183):
- Adds `_body` (containing `_movieContainer`), `_middleContainer` and `_effectContainer`, all mouse-disabled.
- `_displayMode = -1`.
- If the UI is loaded, calls `delayInitView`; else listens to `"battleUILoaded"`.

`delayInitView` (:255-384):

| z | element | exact style / asset | position and notes |
|---|---|---|---|
| 0 | `_shade` | `ComponentFactory.Instance.creat("asset.battle.RoleShadeMC")` | alpha 0.7, `addChildAt 0`. [SWF] centered ellipse 89×64. Scale = `shadow / width · 1.5` (:1500-1510). |
| 1 | `_backEffectContainer` | EffectContainer | `addChildAt 1` (:273) |
| 2 | `_body > _movieContainer` | animated body | `scaleX` ±1 by direction (:1250-1260, :502-505) |
| 3 | `_middleContainer` | - | - |
| 4 | `_effectContainer` | - | buff effects and skill flag |
| 5 | `_roleInfoView` | `creatCustomObject("asset.battle.PawnBottomAsset")` | **`y = -20`** (:318) |
| 6 | `_bufferResistMc` | `creatCustomObject("battle.bufferResistMc")` | stopped at frame 1; plays when a buff has `AttackType 322 && AttackWay 4` (:522-529, :620-626) |

Inside `_roleInfoView` ([SWF] `bgMc` 102×17 at (-51,0); `container` at (0,28); `strip_pos` 69×≈5 at (-34,7)):
- **Name**: `creatComponentByStylename("battle.HeroNameTxt")`, `setFrame(1)`, no filters (:278-283).
  - Style: 130×60, x=-65, y=-9, Arial 13 `0xFFE79F` center. Frames 2-7 are pet colors: `0xffffff`, `0x59cd41`, `0x32a2f8`, `0xc300ff`, `0xff9600`, `0xce0f0f`.
- **Server**: `"battle.HeroServiceTxt"` (150×18, x=-75, y=10, Arial 12 `0xFEFD02`). Both go into `container` (:284-291).
  - Text `"[servidor]"` only in battleTypes **10, 32, 308, 296, 3848** (:417-449).
- **HP bar** (:299-316):
  - If `HeroRoleInfo.type == 3 && face == 2`: `new BossBottomStrip(getBossHpStripNum(templateId), 0, 16275472)` with `width = 69`. Layer count is `GameHeroTemplate.Captain`, min 1 (`yishi/datas/BattleModel.as:139-148`). Asset `asset.battle.BossBottomStripAsset` (`battle/view/ui/BossBottomStrip.as:15-29`).
  - Else: `ClassUtils.CreatInstance("asset.battle.BottomHpStripAsset")` ([SWF] 69×5 with `maskmc`) inside `new StripUIView(mc, blood, blood, 16275472)`.
  - Then `Helpers.setChildPos(strip, strip_pos, true)` copies x, y, width and height (:377; `battle/utils/Helpers.as:195-205`).
- **StripUIView behavior** (`battle/view/ui/StripUIView.as`):
  - `maskmc.width = cur/max · width`, applied immediately;
  - ghost bar is a copy with offset `0xF85810` and alpha 0.5, following via a 0.5 s `TweenLite` after a **1 s** delay (:90-106, :108-167).
- **Buff counters** (:319-350):
  - two `"battle.bufferStateHbox"` (HBox at x=-35, y=-20, spacing 2), each with `"battle.bufferGoodImage"` or `"battle.bufferBadImage"` (20×24) and `"battle.bufferGoodText"` (arial 14 bold `0x00ff36`) or `"battle.bufferBadText"` (`0xff0000`);
  - count buffs with `currentTurn>0`, an icon, not `CountWay==-1 && ValidCount==-1`, `Dispel==0`; `AttackData` 1 = good, 2 = bad;
  - bad HBox at `x = 0` if there are good ones, else at `-35` (:566-611).
- **Buff icons on the unit** (:351-374), only if `checkCanshowBuffIcon()`:
  - battleType ∈ {**35, 3844, 3845, 3847, 3864, 3866, 3867, 3868, 3889, 3869, 349**} or the unit **is not selfHero** (:475-482);
  - **`multiLordsInspireLevel > 0`**: `new BufferIconOnRole("/inspire.png", info)` at (-80,-5). Tooltip shows level×5% (×10% and Tips2 text in battleType **315**). Buff container moves to x=-120 (:354-369);
  - `new BufferContainer()` at **(-80,-5)**, or (-120,-5) (:370-373).
- Then: `updateStrip`, `setRoleInfoViewVisible`, `createView` (after 50 ms, `creat("asset.battle.RoleLoadingView")` in `_movieContainer` if not loaded yet, :881-901), position, events and face.

**BufferContainer** (`battle/view/buffer/BufferContainer.as`):
- Shows **one icon at a time**.
- Fade-in 0.2 s; with more than one template, holds 1 s, fades out 0.2 s, then cycles to the next (:77-96, :155-222).
- `BufferIconOnRole` (`battle/view/buffer/BufferIconOnRole.as:135-142`): `creatCustomObject("battle.BufferIconView")` (32×32, with tooltip) + `"tips.BufferLayerNumText"` (Arial 12 bold white, right-aligned, at (3,15)). Shows layers if `layerCount > 1 && PressCount > 0` (:47-79).
- **Right-side boss** (type 3 in `armyInfoRight`): buffs go to `battleUIView.reFreshBuffer`, not the unit (`RoleViewBase.as:632-639`, :643-661, :663-673).

Other RoleViewBase elements and rules:

| topic | behavior | lines |
|---|---|---|
| Buff effects | `getAddEffectArr` → `BufferIconFactory.getBufferEffectII` at `info.getSpecialPos(n)`: 1 head, 2 body, 3 leg; defaults (0,-120), (0,-60), (0,0) (`yishi/datas/objects/RoleInfo.as:724-766`). Continuous effect via `BufferLastEffect`. Suppressed if `isHideOtherInBattle`. | 530-562, 693-717 |
| `addEffect` | requires `SharedManager.allowAttactedEffect` and the unit not hidden; layer 1 = front, other = back | 930-952 |
| Skill flag (prepared skill icon) | `new SkillUseItemCell()` without border, `flash()`, `x = -20`, `y = head.y - 33` (or -175), in `_effectContainer`. The cell uses `"battle.SkillUseItemCell"` 30×30 at (5,5) inside `asset.battle.SkillGlowAsset` (`SkillUseItemCell.as:29-50`). | 1361-1398 |
| Aim | `creat("asset.battle.SkillUsedSelectedAsset1")` for face 1, `"...Asset2"` for face 2 (234×229), in `_backEffectContainer` | 1447-1471 |
| Tint by attack mode | 0 none, 1 blue +55, 2 red +55 on `_movieContainer` (applied at `RoleInfo.as:557`) | 1342-1359 |
| `setRoleInfoViewVisible` | dead non-boss → name only (no bar, bg, buffs); dead boss → panel hidden; alive → panel, buffs, bar and bg visible per flag | 984-1017 |
| `setBloodStripVisible(v, nameOnly)` | `!canTakeDamage` → panel hidden; with `nameOnly` → hides bar, buffs and bg | 1019-1056 |
| Moving attacker | panel hidden while moving (`BaseSkill.as:385-401`) | - |
| `isLockInfoView` | panel counter-moves to stay fixed in world | 1277-1295 |
| Invincible world boss (battleType **17**) | bar always full | 1155-1160 |

#### `HeroRoleView`

Source: `core_module/scripts/battle/view/roles/HeroRoleView.as`.

- **Avenger**: with `avengerDegree > 0` and the unit visible, loads module `avengereffect` and adds on top (`addChild`) `creatComponentByStylename("core.avengerEffectzd" + min(10, ceil(deg/2)))` (`HeroRoleView.as:68-94`). In the style, zd10 points to `asset.core.avengerEffectzs10`.
- **load** (:96-164):
  - type ∉ {3, 7, 8}: `HeroMovieClip`, or, case by case, pet (`HeroLoadDataFactory "pet_body"`) or child (`"children"`). With `isPetFake`, the panel is hidden (:117-121);
  - type 3/7/8: loads by `resPath`;
  - face 2 → `scaleX = -1`.
- **Body change**: `changeBody`, `heroChangeBody` and `childChangeBody` (:625-704); `creatCustomObject("HeroRoleView.childChangeMovie")` (:111).
- **King Tower** (`isKingTower`): enemy with `tintMultiplier 0.5` (:327-335).
- **Dead on load**: `action("Failed","STOP")` (:402-429).
- **delayInitView** (:431-476):
  - with `petLivingId != 0`: `creatCustomObject("battle.BottomAwakenMc")` (y=9) inside the bar; frame is `floor(awaken·100/3000)` (100 for child) (:444-458). 0.5 s frame tween at :547-559; glow plays when full and it is the hero itself (:585-609);
  - name: `nickName` or "Nome não enviado pelo servidor"; the player with default nickname (`userId$`) shows as "Herói" (:459-470);
  - battleType **35**: name color = `petRoleInfo.quality + 1` (:472-475).
- **Cancel preparation**: if SP or hitPoint drop below cost due to a buff (:532-574).

#### `PawnRoleView`

Source: `core_module/scripts/battle/view/roles/PawnRoleView.as`.

Loads by `effectId` (:87-104). Name is `tempInfo.Name + " Nv.{Level}"` (:148-160, `public.level2`). Shadow fixed at (0,0) (:162-180).

#### `MonsterRoleView`

Source: `core_module/scripts/battle/view/roles/MonsterRoleView.as`.

`MonsterRoleInfo extends HeroRoleInfo`. Loads by `tempInfo.ResPath` (:79-96); name is `tempInfo.Name` (:134-145). **HP bar hidden, name only**, except battleType **3884** (:147-155).

#### `PetRoleView`

Source: `core_module/scripts/battle/view/roles/PetRoleView.as`.

- Star HBox is added before `super` (ends below the shadow in final order) (:27-35).
- `"pet_follow"` with `x = point.x - 60` on face 1 (+60 on face 2) and `y = point.y - 80` (:37-65). After load: `y = point.y - 80` if `Property1==0`, else `point.y` (:289-330).
- Name: `creatComponentByStylename("battle.PetNameTxt")` (color frames by `quality`) (:150-173).
- Shadow hidden if battleType **≠ 35** and `Property1 == 0` (:156-159).
- **HP bar hidden except in battleType 35** (:274-282).
- Stars: `creatBitmap("asset.pet.smallStarLevelImg")`, or `"asset.pet.smallMoonLightLevelImg"` if `temQuality > 25`; count `temQuality % 5` (0 counts as 5). Hidden at max (`quality 6 / tq 31` when `NeedGrade==3`, else `5 / 21`) (:235-272).
- Name and stars centered on body bounds; name at `y = bounds.y - 37` (:193-233).

#### `GoddessRoleView`

Source: `core_module/scripts/battle/view/roles/GoddessRoleView.as`.

`delayInitView` **does not call `super`**, only `visible = false` (:88-95): no shadow, panel or bar. `load` creates an empty MovieClip (:23-44).

#### `SelfChessRoleView`

Source: `core_module/scripts/battle/view/roles/SelfChessRoleView.as`.

Extends HeroRoleView. Loads by `ResType`: 1 = role swf, 2 = avatar, 3 = campaign movie clip; boss uses `resPath` (:28-91). Awaken bar **always** shown (:129-157).

#### `HeroLoadDataFactory`

Source: `core_module/scripts/battle/view/roles/HeroLoadDataFactory.as`.

Resolves URLs per part: children, pet_follow (`PetAvatar + "_follow"`), pet_body, body, arms, hair, cloak and mount; dragon variants use job 4 (:47-242). `isSelf` = thane's `userId` (:243-250).

#### `QuickenHeroMovieClip`

Source: `m10/scripts/battle/view/roles/QuickenHeroMovieClip.as`.

Wraps a `HeroMovieClip` in a `QuickenMovieClip` registered in `quickenControl`; `setSpeed` sets the step; `addFrameScript` shifts the index by +1 (:14-28, :80-83). **No users** (empty grep).

#### `CollectionEffect`

Source: `core_module/scripts/battle/view/utils/CollectionEffect.as`.

- Created by `addCollectionEffect(true)` with the hero's job (`RoleViewBase.as:1297-1314`), which always creates a `ReadyAction`.
- `creat("asset.battle.CollectGasAsset")` in the back container (`CollectionEffect.as:30-35`). [SWF] 24 frames, labels `qte` (11) and `loop` (14).
- `updateToQteState` (:37-58):
  - job 3 → `"asset.battle.CollectGasWizardAsset"`, **in the back container**;
  - job 2 → `"asset.battle.CollectGasHunterAsset"`;
  - others → `"asset.battle.CollectGasFrontAsset"`;
  - all play `"qte"`; the back one too.
  - Only if `ModuleLoader.hasDefinition` (modules `battleeffect1/2/3`).

#### Conditions by battleType and side (units)

- Face 2 = enemy side: mirrored body; `BossBottomStrip` only on enemy boss.
- Units hidden by "hide others" (`yishi/datas/BattleModel.as:1113-1177`) get no body, effects or loading. Damage numbers still appear: `__blood` does not check this state.

### 7.5 battleType conditions (consolidated)

| value | effect | file:line |
|---|---|---|
| 10, 32, 296, 308, 3848 | shows `[servidor]` under the name | `core_module/scripts/battle/view/roles/RoleViewBase.as:435-449` |
| 35, 349, 3844, 3845, 3847, 3864, 3866, 3867, 3868, 3869, 3889 | buff icons and counters also on own hero (other types: only on other units) | `RoleViewBase.as:475-482` |
| 315 | inspire tooltip ×10% (Tips2) | `RoleViewBase.as:359-362` |
| 17 | invincible world boss: full bar, damage not applied | `RoleViewBase.as:1155-1160`; `core_module/scripts/battle/actions/DannyAction.as:146` |
| 310 | revive (bloodType 10) resets `BossBottomStrip` | `RoleViewBase.as:1099-1102` |
| 310, 311 | dead boss: plays "Die" and removes the view | `m10/scripts/battle/view/map/BattleMapView.as:40,182-191` |
| 3884 | monsters show HP bar | `core_module/scripts/battle/view/roles/MonsterRoleView.as:151` |
| 35 | pet shows bar and shadow; hero name in pet quality color; skill name for allies; alternate name preload list | `PetRoleView.as:156,278`; `HeroRoleView.as:472-475`; `core_module/scripts/battle/skillsys/skills/BaseSkill.as:268`; `core_module/scripts/battle/transaction/CreateGameTransaction.as:483` |
| 3844 | skill name for allies; alternate preload; 75 ignored (no QTE) | `BaseSkill.as:268`; `CreateGameTransaction.as:483`; `core_module/scripts/battle/view/ui/SkillItemListController.as:863` |
| 3845, 3847, 3864, 3866, 3867, 3868, 3889 | 75 ignored (no QTE, no aura) | `SkillItemListController.as:867-894` |
| 307 | skill use never counts as "self": no QTE, no aura | `SkillItemListController.as:1016` |
| others | `isAutoFight` → `qteTime = 0` → no QTE; `isControledByBoss` → no QTE | `SkillItemListController.as:922-925`; `m10/scripts/battle/view/ui/BattleUIView.as:1886` |

### 7.6 Findings

1. **`ParryAsset` and `CriticalDamageAsset` never appear.** They are created and positioned but never `addChild`ed (`DamageNumView.as:79,225-229,254-265`). In practice parry = blue number (`SelfCauseNumberAssetSp`) at scale 0.6, crit = `CriticalDamageNumAssetSp` style + Rage animation. [README.md](README.md) §3, item 8, now records the same.
2. **Crit number is stretched horizontally.** `_numSp.width = _critical.x + _critical.width` rescales a Sprite holding only the text (`DamageNumView.as:253,260`). With the default 76 px field, the factor is about 2.2× *(numeric assumption, computed from [SWF] bounds)*.
3. **Misleading colors in style names.** `RedNumberAssetSp` is `0xF4FFCC` (near white), used for third-party regular damage. Yellow `DamageNumberAssetSp` is damage dealt by own hero. Blue `SelfCauseNumberAssetSp` is **parry**, not "self cause".
4. **Only bloodType 6 shows a value.** Types 7 and 8 show "0"; 9 (SP), 24 and 26 show no number (`RoleViewBase.as:1073-1113`). [README.md](README.md) §3, item 8, now records this.
5. **Pool `CreateDamageNumViewHelper` is dead code**; only `dispose` is called. Values above 99999 become `n/1000 + "K"` without rounding.
6. **Name/HP panel sits at the unit's feet, not above it.** `PawnBottomAsset` is at y=-20; bar at y≈-13 and name at y≈-1 relative to the feet origin (`RoleViewBase.as:318` + [SWF]). The panel is added **above** `_effectContainer` in z order.
7. **`BossBottomStrip` requires `type==3` and `face==2`.** Allied boss uses the regular bar.
8. **Monsters and pets hide the HP bar by default** (exceptions 3884 and 35). The goddess has no visible layer.
9. **QTE.**
   - Keys: A/S/D/W **or** arrows. A mistake restarts the sequence, no penalty.
   - Duration from `SkillTempInfo.QTETime`; key count = `int(QTETime/1500)`. Below 1500 ms gives 0 keys, and any key counts as success (`QTEComponent.as:132-155`).
   - 10015 is sent 400 ms after success. The Timer repeats.
   - `QteSuccessAnimation` flies nothing: it only changes the aura after 800 ms.
   - All of this matches [README.md](README.md) §4 (timeout = time-400, position `((w-qteW)/2, h-280)`).
10. **`QuickenHeroMovieClip` is unused.**
11. **Skill name is a PNG image** (`skillName/<SonType>.png`), not text. No PNG, nothing shown. Only shown for the player's own skills (or allies in 35/3844), never for skillIds 1 to 4.
12. **Goddess bug at `CoreTransactionManager.as` line 148**: not verified.

---

## 8. Boss and top panels, TeamStrip and buffs

All paths are relative to `decompiled/`.

**Conventions**
- **s** (local to this section) = `sceneWidth / 1500`, the top-panel scale.
- **sceneWidth** = `limitRange(stageWidth, 1000, 1500)` (`m10/scripts/battle/view/BattleView.as:104` and `m10/scripts/battle/view/ui/BattleUIView.as:766`).
- **Boss** is `HeroRoleInfo.type == 3` (`m10/scripts/battle/view/ui/RoleShowViewII.as:185`; `core_module/scripts/yishi/datas/objects/BattleArmyInfo.as:243`).
- **Color 16275472** = `0xF85810`. Used as an RGB offset (+248, +88, +16) to build the "ghost" bar (`core_module/scripts/battle/view/ui/StripUIView.as:100`).
- **Boss bar count** = `GameHeroTempInfo.Captain`, or 1 when ≤ 0 (`core_module/scripts/yishi/datas/BattleModel.as:139-148`).

### 8.1 Who creates what (creation tree)

| Creator | Class created | Condition | Ref |
|---|---|---|---|
| BattleUIView.init | `RoleShowViewIII` (→ DoubleBossInfoView) | `battleType` 310 or 3852 | `m10/scripts/battle/view/ui/BattleUIView.as:1365-1372` |
| BattleUIView.init | `MutilBossShowView(["asset.battle.BossShowRightAsset","asset.battle.LiteBossBloodBar_0"], [0,673])` | `battleType` 311 or 312 | `BattleUIView.as:1373-1378` |
| BattleUIView.init | `MutilBossShowView(["asset.battle.BossShowRightAsset","asset.battle.LiteBossBloodBar_1","asset.battle.LiteBossBloodBar_1"], [0,790,790])` | `battleType` 313 | `BattleUIView.as:1379-1383` |
| BattleUIView.init | `RoleShowViewII` (→ BossInfoView) | `battleType` 295 | `BattleUIView.as:1384-1388` |
| BattleUIView.init | `OutyardShowView` (out of scope) | 3855 | `BattleUIView.as:1389-1391` |
| BattleUIView.init | no top panel | 349, 3867, 3889 | `BattleUIView.as:1392-1395` |
| BattleUIView.init | `RoleShowViewII` | all others (`default`) | `BattleUIView.as:1396-1399` |
| BattleUIView.init | `addChild` order | `_roleShowII`, `_outyardShowView`, `_doubleBossShow`, `_mutilRoleShowView` (followed by `updateMutilRoleShowView()`); then `_resistUIView1/2` and `_skillNameContainer` | `BattleUIView.as:1402-1421` |
| BattleUIView.init | `ForbiddenBossUIView` | `battleModel.isForbiddenBoss()`, i.e. `battleType == 3903` | `BattleUIView.as:1346-1350`; `core_module/scripts/yishi/datas/BattleModel.as:1075-1077` |
| BattleUIView.addTeamStrip | `TeamStrip(info,1)` (ally) / `TeamStrip(info,2)` (enemy) | see `TeamStrip` in §8.2 | `BattleUIView.as:1653-1698` |
| RoleShowViewII.createRightView | `BossInfoView` + `BossBufferContainer(armyInfoRight.boss)` | only if a `type==3` hero exists on the right side (`_rightIsBoss`) | `m10/scripts/battle/view/ui/RoleShowViewII.as:61, 69-83` |
| RoleShowViewII.bossReinforce | creates the view on demand if no boss yet | called by ReinforceHandler | `RoleShowViewII.as:141-178`; `core_module/scripts/battle/handler/ReinforceHandler.as:301` |
| RoleShowViewIII.createRightView | `DoubleBossInfoView` + 2× `BossBufferContainer(boss, 1)` | always (inside III) | `m10/scripts/battle/view/ui/RoleShowViewIII.as:45-71` |
| MutilBossShowView → RoleInfoGroupView | `BossInfoViewII(mc, resourceName)` + `BossBufferContainer(null)` | one group per resource name | `m10/scripts/battle/view/ui/MutilBossShowView.as:56, 333-345` |
| BossInfoView / BossInfoViewII / DoubleBossInfoView | `BossStripUIView` | always | `core_module/scripts/battle/view/ui/top/BossInfoView.as:218`; `BossInfoViewII.as:129, 153`; `DoubleBossInfoView.as:90, 107, 170, 180` |
| RoleViewBase (bar under the character) | `BossBottomStrip` | `info is HeroRoleInfo && type==3 && face==2` | `core_module/scripts/battle/view/roles/RoleViewBase.as:304-309` |
| RoleViewBase | `StripUIView("asset.battle.BottomHpStripAsset")` | otherwise | `RoleViewBase.as:310-315` |
| RoleViewBase | inspiration `BufferIconOnRole` (multiLords) and `BufferContainer` | `checkCanshowBuffIcon()`; inspiration icon only if `multiLordsInspireLevel > 0` | `RoleViewBase.as:352-374, 475-482` |
| RoleViewBase.__showBuffer | `BufferLastEffect` | template has LastEffect and no effect exists yet for that templateId | `RoleViewBase.as:541-561` |
| RoleViewBase | `BufferIconFactory.getInstance().getBufferEffectII(...)` | buff add and action effects | `RoleViewBase.as:535, 711` |
| BottomBar | `SelfBufferView` | whenever the BottomBar exists | `m10/scripts/battle/view/bottom/BottomBar.as:142-150` |
| PetSacristyBar | `SelfBufferView` | always | `m10/scripts/battle/view/bottom/PetSacristyBar.as:47-50` |
| SelfBufferView | `SelfBufferIcon` via `creatCustomObject("battle.SelfBufferIcon")` | one per `BufferDamageData.id` | `m10/scripts/battle/view/ui/SelfBufferView.as:155` |
| BossBufferContainer | `BufferIconOnRole` | one per buff, permanent, special or immunity | `m10/scripts/battle/view/buffer/BossBufferContainer.as:254, 267, 286` |
| BufferContainer | `BufferIconOnRole()` (single reused instance) | - | `core_module/scripts/battle/view/buffer/BufferContainer.as:58` |
| BufferListView | `BufferListItem` | **no reference to `BufferListView` in m10/core_module**: dead code | `m10/scripts/battle/view/buffer/BufferListView.as:187` |
| (map, not battle) WorldBossHeadInfoMediator | `WorldBossInfoView extends BossInfoView` and `BufferIconOnConsortiaEmeDreamBoss` (indices 0 and 1 of `emeDreamInfo.BufferIds`) | map nodes `types` 41/42; icons only on EmeDream maps | `m3/scripts/map/campaign/mediator/mapview/WorldBossHeadInfoMediator.as:68-119`; `m3/scripts/map/campaign/view/ui/WorldBossInfoView.as:5` |
| - | `LiteBossStripUIView` | **no creator found** (dead code) | empty grep |
| ComponentEmbed | only references `BufferListItemTip` to embed the class, used as `tipStyle` | - | `core_module/scripts/yishi/lunch/ComponentEmbed.as:5, 91` |

**Show/hide the whole top:** `hideTopView()` and `showTopView()` toggle `visible` of `_outyardShowView`, `_roleShowII`, `_doubleBossShow` and `_mutilRoleShowView` (`BattleUIView.as:1827-1865`). Callers: ProfoundEffect and ProfoundEffectII, i.e. skill cutscenes (`core_module/scripts/battle/skillsys/effect/ProfoundEffect.as:60, 93`; `ProfoundEffectII.as:36, 50`).

### 8.2 Components

#### `IHpStrip`

Interface with `maxValue` (get/set), `currentValue` (get/set), `initCurrentValue(n)`, `getView():DisplayObject` and `dispose()` (`core_module/scripts/battle/view/ui/IHpStrip.as:8-20`). Implemented by StripUIView (`StripUIView.as:15`), BossStripUIView (`BossStripUIView.as:18`) and LiteBossStripUIView (`LiteBossStripUIView.as:8`).

#### `StripUIView`

Basic single-layer bar. Constructor: `(asset:MovieClip, max=0, current=0, colorOffset=0, hasBackGroundFade=true, twoWayTween=false, background:Bitmap=null, fullDefault=true, needLight=false)` (`core_module/scripts/battle/view/ui/StripUIView.as:46`).

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `_asset` | received MovieClip; must have children `maskmc` and `upStrip` | 0,0 | addChild #1 (:59) | always | - |
| `_backBackGround` (ghost bar) | received `background`, or a `BitmapData.draw(_asset)` copy with `ColorTransform(1,1,1,1,R,G,B)` from the colorOffset bytes and `alpha=0.5` (:93-103) | 0,0 inside `_asset` | `_asset.addChildAt(bg, 0)` (:104), behind the asset content | created 30 ms later by `TimerUtils.setTimeout(delayInitFade,30)` (:66, 80-88); not created if asset width or height is 0 (:82) | - |
| `_lightMc` | `ComponentFactory.Instance.creat("asset.battle.BossHpStripLightMc")` (:62) | `height = asset.height`, `y -= 2` (:63-64); `x = fillWidth - 5` | `addChild` on 1st update (:134-137), above the asset | only if `needLight` (:60); `visible = (maskWidth - fillWidth) > 5` (:132) | - |

**Computation** (`fillWidth` = width of the filled part)
- `fillWidth = int(cur / max * maskWidth)`, clamped to `maskWidth` (`maskWidth = _asset.width` original) (:52, 123-127).
- `_asset.maskmc.width = fillWidth` is applied **immediately** (:129).

**Damage animation**
- With tween, `_backRect.width` (ghost scrollRect) goes to `fillWidth` in **0.5 s after a 1 s delay** (`TweenLite.to(_backRect,0.5,{width, delay:1})`) (:147-154).
- Without tween (`initCurrentValue` or `maxValue` change), the ghost snaps immediately (:156-164).
- The light slides to `x = fillWidth - 5` in 0.5 s after a 1 s delay (:138-143). On complete it does `gotoAndPlay(1)` (:208-215). In `tweenUpdate2`, if `x <= 0`, it restarts from `maskWidth - 5` (:180-206).

**Edge cases**
- With `max <= 0` and `fullDefault=true`, nothing changes and the bar stays full as drawn (:112-119). This is why the BossStripUIView under layer, created with max=0, always looks full.
- `currentValue` setter returns early if the value is unchanged (:246-248).
- `maxValue` setter clamps `cur` to [0, max] and calls `refreshView(false)` (:227-237).
- `_hasBackGroundFade`, `_twoWayTween` and `_changeFlag` are stored but **never used** (:54-55, 75, 250).
- `resetView()` fills the ghost (:169-173).

**Uses**
- HP bar under regular characters (`RoleViewBase.as:312-313`).
- PowerUIView (`m10/scripts/battle/view/ui/PowerUIView.as:80`).

#### `BossStripUIView`

Multi-layer boss bar with the "xN" counter. Constructor: `(stripNum, max=0, colorOffset=0, p4=true, scaleXNum=-1, viewStyle="asset.battle.BossHpStripAsset", bgStyle="asset.battle.BossHpStripBgAsset")` (`core_module/scripts/battle/view/ui/BossStripUIView.as:55`). Initially `_currentStripIndex = stripNum` and `_currentValue = _maxValue = max` (:58-61).

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `_underStripView` (next color) | `StripUIView(creat(viewStyle),0,0,16275472)`; `asset.upStrip.gotoAndStop(stripNum-1)` | 0,0 | addChild #1 (:74) | only if `stripNum > 1` (:69-78); removed when `index < 2` (:252-255, 328-331, 340-347) | - |
| `_upStripView` (current color) | `StripUIView(creat(viewStyle),0,0,16275472,true,false,bmp,true,true)`, with `bmp = ComponentFactory.Instance.creatBitmap(bgStyle)` or `null` if `bgStyle == null` (:79-82); `upStrip.gotoAndStop(stripNum)` (:83) | 0,0 | addChild #2 (:84) | always | - |
| `_currentStripNumView` (the "xN") | Sprite with bitmap digits `ComponentFactory.Instance.creatBitmapData("asset.battle.BossStripNumAsset")` (:76) | `scaleX = _scaleX`; `x = 400` if `_scaleX < 0`, else `350`; `y = -13` (:87-96). `setStrpNumPos(x,y)` overrides (:103-112) | addChild #3 (:99) | `stripNum > 1`; removed when `index < 2`. Hidden when `battleType==17 && BaseManager.wordBossInvincibleState`, or when `campaignTemplate.Types==1 && wordBossInvincibleState` (:204-222) | - |

**Digits**
- `NumberViewUtils.refreshValue(index, sprite, bmd, 50, 50, 48, 50, "23456")` (:209).
- Each glyph is 50×50, 50 px stride in the sheet, 48 px advance (`core_module/scripts/yishi/utils/NumberViewUtils.as:158-185`).
- **The sheet only has "2".."6".** So the counter shows 2 to 6 (at 1 it disappears), and Captain > 6 has no glyph *(assumption: index -1 would draw an invalid crop)*.
- No "x" glyph. If an "x" appears, it is drawn in the bitmap itself *(assumption)*.

**Per-layer HP**
- `perBar = max / stripNum` (HP per bar) (:162, 199-202).
- Value inside the current bar: `v = perBar - (perBar*index - cur) = cur - perBar*(index-1)`; `v = 0` if `cur <= 0` (:225-232).
- If `v <= 0`:
  - with `stripNum > 1` calls `showNextStrip` (:165-170);
  - else sets 0, with or without tween (:171-178).
- If `0 < v <= perBar`, applies `v` to `_upStripView`, with or without tween (:180-190).
- If `v > perBar` (heal crossing bars): `index += floor(v/perBar)` and `showPreStrip(false)` without animation. Instant switch; rebuilds under layer and counter if missing (:191-196, 234-288).

**Bar transition (`showNextStrip`)**
1. Empties the current bar with tween (`currentValue = 0`) (:297).
2. **After 1500 ms** calls `switchStrip`: `index--`; `max = cur = perBar`; `upStrip.gotoAndStop(index)`; recomputes the value (:298, 308-327).
3. Under layer goes to frame `index - 1` and the counter updates (:333-337).
4. Lock `_showNextStriping` prevents reentry (:292-294). If damage spans several bars, each bar takes 1.5 s.
5. Without tween (first init), the switch is instant (:300-304).

**Init and colors**
- The first `currentValue` after creation uses `updateCurrentCurrentValue(false)`, no tween (`_inited`) (:143-147).
- `maxValue = X` sets `up.max = up.cur = perBar` and updates the counter (:118-129).
- **Layer colors:** bar color is frame `index` of the asset's `upStrip` MovieClip (:73, 83, 250, 274, 325, 335). The palette lives in the SWF, not seen in code.

**Other**
- `width`: getter returns `_myWidth` (asset width). The setter resizes only if `_toSetWidth` (:361-373).
- `dispose()` sets `isDie = true` and clears the timeout (:380-386).

#### `BossBottomStrip` (extends `BossStripUIView`)

Boss bar drawn under the boss sprite on the field.
- Created by `new BossBottomStrip(getBossHpStripNum(tid), 0, 16275472)`, with `_toSetWidth = true` and `width = 69` (real scale) (`RoleViewBase.as:306-308`).
- Condition: `HeroRoleInfo.type == 3 && face == 2` (`RoleViewBase.as:304`).

Overridden `initView` (`core_module/scripts/battle/view/ui/BossBottomStrip.as:15-29`):
- With `stripNum > 1`, `viewStyle = "asset.battle.BossBottomStripAsset"`; under layer uses frame `stripNum - 1` (addChild #1).
- `_upStripView = StripUIView(creat(_viewStyleName),0,0,16275472,true,false,null)`: **no light, generated tinted ghost**. addChild #2.
- **Finding:** with `stripNum == 1`, `_viewStyleName` keeps the default `"asset.battle.BossHpStripAsset"` (set in the parent constructor, `BossStripUIView.as:62`), so a single-bar boss's bottom bar uses the top bar asset.
- Empty `setStripNumViewByIndex`: no "xN" (:31-33). `_currentStripNumView` is created but never `addChild`ed in `initView`.
- `resetView()` restores `index = stripNum` and rebuilds under layer and counter (:35-62). Called on blood event type 10 when `battleType == 310` (`RoleViewBase.as:1097-1103`).
- Update: `updateStrip()` sets `max = totalBloodA` and `cur = bloodA`. With `type==3 && face==2 && battleType==17 && wordBossInvincibleState`, forces full (`RoleViewBase.as:1151-1163`).

#### `LiteBossStripUIView`

No creators (dead code).
- Takes a DisplayObject and crops it with a `scrollRect` of width `cur / max * width` (`core_module/scripts/battle/view/ui/LiteBossStripUIView.as:23-34, 36-62`).
- Uses a 0.3 s `TweenLite` tween if `tween = true` (:41-56).
- Empty `initCurrentValue` (:79-81).
- `getView()` returns the resource, not the object itself (:83-86).

#### `BossInfoView` (single-boss top panel: `RoleShowViewII` and the world boss map)

Source: `core_module/scripts/battle/view/ui/top/BossInfoView.as`. Fixed `width` = **986** (:177-180).

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `_assetRight` | `ComponentFactory.Instance.creatCustomObject("asset.battle.BossShowRightAsset")` (:187) | `y = -10` (:191); `scrollRect = null` | Sprite addChild #1 | if `battleModel.transSceneEffectComplete`, `addChild` immediately (:193-196). Else stopped on last frame; `addChild` + `gotoAndPlay(1)` only on `"TransSceneEffectComplete"` (:197-201, 61-69) | NotificationManager `"TransSceneEffectComplete"` |
| `bloodTxt` | `_assetRight.blood.r_hptxt` (SWF TextField) | from SWF | - | **`visible = false`**: no HP text in battle (:202-203) | - |
| `_rightHead` | `new HeroRoleHeadView(_assetRight.head.r_head, Rect(0,0,78,78), -1)` | `y = -78` (:209-212) | inside `head.r_head` | always | - |
| `_rightHp` | `new BossStripUIView(getBossHpStripNum(tid), 0, 16275472)`, i.e. asset `BossHpStripAsset`, ghost `BossHpStripBgAsset`, number `scaleX` = -1 (:218) | `addChild` into `_assetRight.blood.r_hp_pos`; `view.scaleX *= -1`; `width = 397` (only stores `_myWidth`); `x += 397 + 5` (:219-222). Bar is **mirrored**: full part anchored right, next to the head, drains left to right *(assumption from the mirroring)* | - | always | - |
| `numGradeSprite` (level) | `Component` in `head.r_grade`; `BitmapData ClassUtils.CreatInstance("asset.battle.BossGradeNumAsset")`; `printNumber(level, spr, bmd, "1234567890", -3)` (:232-241) | `x = -displayWidth*0.5`, `y = -displayHeight*0.5` (centered) | inside `r_grade` | level = `emeDreamInfo.callGrade` if `isConsortiaEmeDream`, else `template.Grades` (:224-231) | - |
| `nameTxt` | `_assetRight.head.r_name` | `y = bossNameBg.y + 22`; `height = textHeight + 20`; `wordWrap = true`; `text = nickName` (:242-251) | - | always | - |
| `bossNameBg` | `ComponentFactory.Instance.creatComponentByStylename("core.boss.bossNameBg")` (:247). Style: ScaleBitmapImage `asset.battle.BossNameBgImg`, 9-slice 5,5,35,35, 213×56, x=-75, y=108 (`index/styles.json`) | `height = 22 + textHeight + 20` (:252) | `_assetRight.head.addChildAt(bg, 1)` (:249) | always | - |
| number effect (`playWorldBossHpEffect`) | `asset.battle.WorldBossBloodMC`; digits from `asset.battle.AddHpNumAsset` (positive) or `asset.battle.ExtraNumberAsset` (negative); `getNumberView(abs, ..., 55, 55, 35, 55, "0123456789.", 1)` (:146-160) | `blood.x = -blood.width/2`; MC at **x = 750 (heal) or 600 (damage)**, **y = 30** (:161-170); digits in `effect.container` | Sprite addChild (top) | on last frame removed and stored in `tempEffectList` (:132-145, 172) | - |

**Logic**
- `setInfo(info)` is **ignored** if a boss with higher `grades` is already set (:91-96). Then calls `initView()` and disables mouse (:97-99).
- `setTotalHp(n)`: `_rightHp.maxValue = n` (:102-105).
- `setCurrentHp(n)`: with `battleType == 17 && BaseManager.wordBossInvincibleState`, shows full; else applies `n` (:107-115).
- `updateWorldBossHp(delta)`: if `delta != 0`, calls `setCurrentHp(current + delta)` and the effect (:117-125).
- `isConsortiaEmeDream`: true if scene is `"BATTLE_SCENE"` and `battleType == 309`, or if `WorldBossHelper.checkConsortiaEmeDream(mapId)` (:255-268).

#### `RoleShowViewII` (container of `BossInfoView` and the boss buffs)

Source: `m10/scripts/battle/view/ui/RoleShowViewII.as`.

**Boss choice:** among right-side heroes with `type == 3`, the one with highest `grades` (:180-198).

**Children**
- `_bossView` (BossInfoView): addChild #1. Gets `setTotalHp(getBossesTotalHp())` and `setCurrentHp(getBossesLeftHp())`, both sums over all `type == 3` (:73-77; `core_module/scripts/yishi/datas/objects/BattleArmyInfo.as:130-154`).
- `bossBufferContainer` (`BossBufferContainer(armyInfoRight.boss)`, default direction -1): starts at x=1080, y=25, addChild #2 (:78-81).

**Layout (`resizeHeadView`, :303-347)**
- `_bossView`: scale s, `x = sceneWidth - 986*s + 25`.
- Buffs: `x = sceneWidth - 210*s - 40`; `y = 5` if `s < 1`, else `25`.
- `nameTxt` and `nameInfoTxt` get inverse scale `1/s` and are recentered.
- ChatTopBugleView is repositioned. Also runs on stage `resize`.

**Per frame (`__enterFrame`, :382-408)**
- `setCurrentHp(getBossesLeftHp())`: HP polled every frame.
- If `armyInfoRight.getLeftHp() <= 0`, sets `isOver = true` and sends `"FORCE_SKILL_ENABLE", false`.

**Opcodes (`"SLGSocketEvent" + n`, :219-227)**
- 4174, 4462, 4727, 360, 4889, 4285, 4297 → `__syncBossHpHandler` (WorldBossInfoMsg). On `bossState` transition 0 → 1, resets `totalBlood` and total HP. Always calls `battleModel.updateWorldBossBlood(curHp, millis)` (:264-286).
- 4435 → `__addBossHpHandler` (BossHpMsg): if `livingId` matches, calls `updateWorldBossHp(+abs(value))`, i.e. heal effect at x=750 (:252-262).
- 4985 → `tailaHPSyncHandler` (SyncRoomBossHPMsg): only effective with `battleType == 3846`, applies `bloodA` and `setCurrentHp` (:230-250).
- Event `"reduceWorldBossBlood"` → `updateWorldBossHp(data)` (:218, 288-291). `data` is the negative delta from `BattleModel.delayWorldBossBloodSync` (`core_module/scripts/yishi/datas/BattleModel.as:842-858`), i.e. other players' damage, effect at x=600.
- `getWorldBoss()` only exists for `battleType` 17, 297, 305, 3865, 313, 3881 and 3903 (`BattleModel.as:861-867`).

**Reinforcement**
- Wave panel (ReinforceWavePane): `top=160, right=30` for `battleType == 3886`; `top=75, right=120` with a boss; else `top=30, right=53` (:100-121).
- `addChild` only if `newbieProcess >= 19000` (:90-94).
- Special layout for 3886 (:349-371).
- `isNeedShowRightView()` (types 4, 5, 7, 8, 10) exists but is **never called** (:200-207).

#### `BossInfoViewII` (`MutilBossShowView` group)

Source: `core_module/scripts/battle/view/ui/top/BossInfoViewII.as`. Constructor `(mc, resourceName)` (:61-66).

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `_bossInfoViewResouce` | received MovieClip (`creatCustomObject(name)` in the group) | 0,0 | addChild #1 (:75) | `gotoAndStop(1)`; `play()` if `transSceneEffectComplete`, else waits for `"TransSceneEffectComplete"` (:76-89) | NotificationManager |
| `_effectContainerMc` | `ComponentFactory.Instance.creat("asset.battle.WorldBossBloodMC")` (:285) | `x = 0` (Lite) or `x = 600` (default) (:118, 145); y=0 | addChild #2 (:287) | created by `showReduceEffect = true`, always the case (:117, 144, 277-306) | - |
| `_numBmp` | `ComponentFactory.Instance.creat("asset.battle.ExtraNumberAsset")` (:284) | - | - | - | - |
| `_numBmd` | `ClassUtils.CreatInstance("asset.battle.BossGradeNumAsset")` (:73) | - | - | - | - |
| `_nameTxt`, `_bloodTxt`, `_gradeTxt` | `target.head.r_name`, `target.blood.r_hptxt` (`visible = false`), `target.head.r_level` (:91-94) (`target` = children target) | SWF | - | `_bloodTxt` hidden | - |
| `_gradeDisplayobject` | Sprite in `target.head.r_grade` (:95-96) | if no `r_level`: `x = -bmd.width*0.5 + 88`, `y = -bmd.height*0.5` (:181-186) | - | - | - |
| `_headView` | `HeroRoleHeadView(target.head.r_head, Rect(w,h), -1)`, `y = -h` (:105-114) | 78×78 (default), 46.8×46.8 (Lite_0), 39×39 (Lite_1) (:137, 141, 155) | - | - | - |
| `_hpView` | `BossStripUIView(stripNum, 0, 16275472, true, -1, strip, bg)` (:129, 153) | in `target.blood.r_hp_pos`; `scaleX = -1`; `x += width` (:172-176) | - | recreated on each `updateUIByHeroInfo` (:166-171) | - |

**Resource → config (`resourceAdapterHandler`, :133-156)**

| resource | children target | bar asset | ghost | head | "xN" position |
|---|---|---|---|---|---|
| `"asset.battle.LiteBossBloodBar_0"` | `mc.bloodBar_mc` | `"asset.battle.BossHpStripAsset_0"` | `"asset.battle.BossHpStripBgAsset_1"` | 78×0.6 | `setStrpNumPos(width, -25)` (:130) |
| `"asset.battle.LiteBossBloodBar_1"` | `mc.bloodBar_mc` | `"asset.battle.BossHpStripAsset_1"` | `null` (generated tinted ghost) | 78×0.5 | `(width, -25)` |
| default (`"asset.battle.BossShowRightAsset"`) | `mc` | `BossHpStripAsset` | `BossHpStripBgAsset` | 78 | default (x=400, y=-13) |

Arguments `"asset.battle.LiteBossBloodBmd_0/_1"` and `0/10` are passed but **unused** (:115, 136, 140). Styles `BossHpStripAsset_0/_1` and `BossHpStripBgAsset_1` are **not** in `index/styles.json`: likely SWF classes *(assumption)*.

**Logic**
- `updateUIByHeroInfo(info, max, cur)`: sets name and head, recreates `_hpView`, sets `max = total` and `cur = current` (first assignment, no tween), writes level into `r_level` or as bitmap (:160-187).
- `playDamageNumEffect(n)`: only if `n > 0`. Uses `getNumberView(n, ..., 55, 55, 35, 55, "0123456789.", 1)` in `_effectContainerMc.container` and replays frame 1 (:189-209).
- **Finding:** each call overwrites `addFrameScript`, so earlier numbers still on screen are never removed (visual leak) (:198-207).

#### `MutilBossShowView` (+ inner class `RoleInfoGroupView`)

Source: `m10/scripts/battle/view/ui/MutilBossShowView.as`. Constants `VIEW_WIDTH = 966` and `HEIGHT_GAP = 10` (:32-34).

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `RoleInfoGroupView[i]` | `new RoleInfoGroupView(names[i])` | `y = Σ previousHeights + 10*i`; `x += offsetX[i]` (:56-64) | addChild in `i` order (:60) | `visible = (i < infos.length && infos[i] != null)` (:169-182) | - |
| → `_bossInfoView` | `BossInfoViewII(creatCustomObject(name), name)` (:336-339) | 0,0 | group #1 (:341) | - | - |
| → `_bossBuffView` | `BossBufferContainer(null)`, direction -1 (:340) | **(740, 43)** (`BUFF_POS`, :319, 343-344) | group #2 (:342) | `visible = needShowBuff` (:358) | - |

**Layout (`doLayout`, :89-103):** scale s applied **to MutilBossShowView itself**. The loop over groups sets `scaleX` and `scaleY` of `this`, same effect. `x = sceneWidth - 966*s`.

**Data (BattleUIView.nldlyiUpdateMutilRoleShowView, `m10/scripts/battle/view/ui/BattleUIView.as:1562-1612`)**
- Only for `battleType` 311, 312 and 313 (`BattleUIView.as:1546-1559`).
- List = `[armyInfoRight.boss]` plus a **synthetic** HeroRoleInfo per `battleModel._heroTempId` other than the boss: `nickName = TemplateName`, `totalBloodA = Live`, `bloodA = _life[i]` or the total (:1577-1595).
- Only the boss gets `needShowBuff` (`rest`) (:1596; `MutilBossShowView.as:173`).
- 313: the boss is the "world boss" receiving `reduceWorldBossBlood`. Otherwise the last synthetic is synced by **opcode 4794** (`BattleUIView.as:1597-1610`).
- Handler 4794 (`BattleUIView.as:1614-1651`):
  - in 313, calls `updateWorldBossBlood`;
  - else, if HP **rose** by more than 60% of total, `resetRoleData` (re-entry with animation); otherwise `playDamageNumEffect(tid, old - new)`;
  - then dispatches `"bloodChange"` and stores into `_life`.
- `updateMutilRoleShowView(true)` (ReviveHandler) calls `resetRoleData(boss)` (`BattleUIView.as:1571-1574`; `core_module/scripts/battle/handler/ReviveHandler.as:86, 93`). Also called without argument by SwapHandler (`core_module/scripts/battle/handler/SwapHandler.as:160, 167`).

**Events**
- `"bloodChange"` of each info → `setCurBlood(bloodA)` (:176, 218-226).
- `"reduceWorldBossBlood"` → `addCurBlood(delta)` + `playDamageEffect` (:257-288).
- `"BATTLE_RESULT"` with `data == true` → world boss HP = 0 (:290-302).
- `enterFrame`: if `getLeftHp() <= 0`, sets `isOver` and `"FORCE_SKILL_ENABLE"` (:105-113).
- `playEnterEffect()` does `gotoAndPlay(1)` on the resource for changed tids (:205-216, 383-386).
- `refreshTurn()` forwards to each `BossBufferContainer` (:228-234, 378-381).

#### `DoubleBossInfoView` (two bosses: battleType 310 and 3852)

Source: `core_module/scripts/battle/view/ui/top/DoubleBossInfoView.as`. `width` = **1000** (:122-125).

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `_doubleBossAsset` | `ComponentFactory.Instance.creatCustomObject("asset.core.boubleBossHPAsset")` ("bouble" is the real asset name) (:133); children `left_BossBlood` and `right_BossBlood` | 0,0 | addChild (:141 or :68) | stopped on last frame. If the transition is not done, sub-MCs also stop on last frame and wait for `"TransSceneEffectComplete"`, which does `gotoAndPlay(1)` on both and the `addChild` (:137-149, 61-70) | NotificationManager (listener added 2× at :130 and :148) |
| `_rightHead1` / `_rightHead2` | `HeroRoleHeadView(left_BossBlood.head.r_head / right_BossBlood.head.r_head, 78×78, -1)` (:155-164) | SWF | - | - | - |
| `_rightHp1` | `BossStripUIView(n1, 0, 16275472, true, 1)`: **number `scaleX` = +1** (x=350) (:170) | `left_BossBlood.blood.r_hp_pos`; `scaleX *= -1`; `width = 397`; `x += 402` (:171-174) | - | - | - |
| `_rightHp2` | `BossStripUIView(n2, 0, 16275472)` (number `scaleX` -1, x=400) (:180) | `right_BossBlood.blood.r_hp_pos`, same transform (:181-184) | - | - | - |
| `_numGradeSprite1` | Component in `left_BossBlood.head.r_grade`; `printNumber(grade, …, "1234567890", -3)`; **`scaleX = -1`, `x = displayWidth*1.5`, `y = +displayHeight*0.5`** (:187-196) | - | - | - | - |
| `_numGradeSprite2` | same in `right_BossBlood`; `x = -dw*0.5`, `y = -dh*0.5` (:201-208) | - | - | - | - |
| `nameTxt1` / `nameTxt2` | `left/right_BossBlood.head.r_name` (:197-198, 210-211) | - | - | - | - |

The left side is probably a mirrored instance in the SWF, which would explain the level `scaleX` -1 and the number +1 *(assumption)*.

**HP**
- `setCurrentHp(a, b)`: if the boss is alive and its bar was disposed (`isDie`), recreates the bar and sets `maxValue = getBossesTotalHpByInfo`. If the boss is dead, `dispose()`s the bar (:84-120).
- Runs every frame via RoleShowViewIII.

**RoleShowViewIII** (`m10/scripts/battle/view/ui/RoleShowViewIII.as`)
- Choice: 1st `type==3` found becomes `_boss2`, 2nd becomes `_boss1` (:73-90).
- `needExchange = boss1.pos > boss2.pos` swaps the order (:178-181).
- `BossBufferContainer(boss, 1)` grows to the right (:53-62).
- Initial positions (788, 61) and (788, -8) (:65-70), overridden in `resizeHeadView`:
  - `_bossView`: scale s, `x = sceneWidth - 1000*s`;
  - buffs: `x = sceneWidth - 520*s`; `y1 = 75*s - 70`; `y2 = 160*s - 70` (:122-133).
  - Icons sit at `y = 70` inside the container, so effective `y` is `75*s` and `160*s`.
- Names get inverse scale (:134-150).
- `enterFrame` calls `setCurrentHp(leftHpByInfo...)` (:155-176).

#### `ForbiddenBossUIView` (battleType 3903)

Source: `m10/scripts/battle/view/ui/ForbiddenBossUIView.as`.

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `_bg` | `creatComponentByStylename("forbiddenBossUIView.bg")`: MutipleImage `"asset.battle.forbiddenBossUIView.bg,asset.battle.forbiddenBossUIView.txt"`, `imageRectString "0\|173\|0\|134\|13,50\|78\|22\|21\|13"` (`index/styles.json`) | 0,0 | #1 (:34, 37) | always | - |
| `_nickNameTxt` | `"forbiddenBossUIView.nickNameTxt"`: FilterFrameText 170×26 at (0, 50), arial 14 `#FC7D00` centered | (0, 50) | #2 (:35, 38) | - | - |
| `_consortiaNameTxt` | `"forbiddenBossUIView.consortiaNameTxt"`: 130×26 at (21, 70), arial 12 `#E7D5AD` centered | (21, 70) | #3 (:36, 39) | `""` if no guild | - |

- **Content:** rank #1 (`ForbiddenBossManager.model.rankList[0]`). Name = `nickName`; guild = `LanguageMgr("forbiddenBossRankItem.consortiaNameTxt.text", name)` = `"<{0}>"` (`web/public/ui/language.txt:11395`) (:57-74).
- **Event:** `MsgMan "FORBIDDEN_BOSS_RANK_UPDATE"` (:44).
- **Position:** `x = (sceneWidth - width)/2`, `y = -6` (`BattleUIView.as:1116-1120`).

#### `TeamStrip` (name that doubles as HP bar for allies and enemies)

Source: `m10/scripts/battle/view/ui/TeamStrip.as`. Constructor `(info, side)`; null `info` does nothing (:25-36).

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `_backTxt` | side 1: `"battle.teamStripText1"`; side 2: `"battle.teamStripText2"` (GradientText 150×20). Gradient colors `0x45f7f1,0x1cacdc,0x58fdff` (1) and `0xff8053,0xbb0000,0xff58b4` (2); filter `core.normal2_f`; Arial 12 bold white, left-aligned (1) or right-aligned (2) | 0,0 | #1 (:51) | `filters = [UIFilter.getGrayFilter()]`: gray background copy (:50) | - |
| `_iconTxt` | same style | 0,0 | #2 (:52) | masked | - |
| `_mask` | Shape with rect `textWidth × height` | side 1: `x = 2`; side 2: `x = width - textWidth - 3` (:61-72) | #3 (:74) | `width = textWidth * (bloodA / totalBloodA)` (:83) | info `"bloodChange"` (:88) |

**Conditions (BattleUIView.addTeamStrip, :1653-1698)**
- Not created if `isPetFake`, `isChildFake`, `MonsterRoleInfo`, `SelfChessRoleInfo` or `battleType == 3907`.
- `info.side == selfSide`, except the player itself → side 1, in `_teamStripContainer1`, keyed by `userId`.
- Else → side 2, in `_teamStripContainer2`.

**Before that (BattleView.addRole, `m10/scripts/battle/view/BattleView.as:259-272, 288-309`)**
- Only for `HeroRoleInfo` with `type != 3` and `checkBattleType()` true.
- `checkBattleType()` is **false** for 16, 19, 32, 35, 36, 38, 306 and 307.
- In 295 and 3898, roles with `bloodA <= 0` are not added.

**Containers and removal**
- `"battle.teamStripContainer1"`: VBox at x=1, y=235, `spacing` 0.
- `"battle.teamStripContainer2"`: VBox at y=235, `x = sceneWidth - 190` (`BattleUIView.as:1470-1473, 775`).
- Dead allies are removed by `removeDieRole` (`BattleUIView.as:1700-1712`; `m10/scripts/battle/view/map/BattleMapView.as:287`). Enemies are never removed.
- **Finding:** `dispose()` calls `_info.dispose()` on the shared RoleInfo (:128-131).

#### `BufferContainer` (buff icon over non-boss characters: one rotating icon)

Source: `core_module/scripts/battle/view/buffer/BufferContainer.as`.

**Position:** in `_roleInfoView`, `x = -80`, or `-120` if there is an inspiration icon; `y = -5` (`RoleViewBase.as:351, 368-373`).

**Existence condition: `checkCanshowBuffIcon()`** (`RoleViewBase.as:475-482`)
- `battleType` ∈ {35, 3844, 3845, 3847, 3864, 3866, 3867, 3868, 3889, 3869, 349}, **or** the role is not `selfHero`.
- So the player's own hero buffs go to SelfBufferView, except in those types.

**Filter and routing**
- Only buffs with `currentTurn > 0` (`RoleViewBase.as:627-630`) and non-empty `template.Icon` (:30-37).
- If the role is the right-side boss (`type == 3` in `armyInfoRight`), the refresh goes to `BattleUIView.reFreshBuffer`, which filters `target == livingId` and feeds the top `BossBufferContainer`, **not** this container (`RoleViewBase.as:632-639, 643-661`; `BattleUIView.as:2027-2044`).

**Display**
- A single `BufferIconOnRole`, `_currentView` (:56-60).
- With more than one **distinct** templateId (:98-109), it cycles:
  1. `alpha` 0 → 1 in 0.2 s;
  2. waits 1 s;
  3. `alpha` 1 → 0 in 0.2 s;
  4. moves to next index (inner class `BufferIconFlash`, :155-222; :88-96, 119-124).
- With only one, fades in and stays.
- `_currentIndex` persists across refreshes and wraps to 0 on overflow (:41-44).
- Empty list: `visible = false` (:47-50).
- `refreshTurn()` forwards to the current icon (:126-132).

#### `BufferIconOnRole`

Source: `core_module/scripts/battle/view/buffer/BufferIconOnRole.as`.

| field | class/style | x,y | z-order | visibility/condition | events |
|---|---|---|---|---|---|
| `_iconView` | `creatCustomObject("battle.BufferIconView")`: BaseIconView 32×32, `tipStyle "battle.view.buffer.BufferListItemTip"`, `tipDirctions "7,6"`, `isFollowMouse` false (`index/styles.json`) (:137) | 0,0 | #1 (:140) | - | ShowTipManager tooltip |
| `_layerCountTxt` | `creatComponentByStylename("tips.BufferLayerNumText")`: FilterFrameText 30×30 at (3, 15), Arial 12 bold white right-aligned, `letterSpacing` 1, black glow `core.normal_f` (:138) | (3, 15) | #2 (:141) | empty text by default (:139) | - |

**Icon and counters**
- Icon from `IconFactory.getCommonIconPath(Icon)` = `PathManager.resourcePath + "icon/" + Icon` (:43; `core_module/scripts/yishi/utils/IconFactory.as:40-43`).
- `refreshTurn` (:47-79):
  - BufferDamageData: shows `layerCount` if `layerCount > 1 && template.PressCount > 0`;
  - BufferTemplateInfo: shows `MultiLordsInspireLevel` if greater than 1;
  - both: `tipData = buffer`.
- **Turn count is not shown on the icon**, only in the tooltip.

**Inspiration (multiLords):** `Icon "/inspire.png"`, name via LanguageMgr `"...multiLordsBufferInfo.Tips"` (level × 5 %) or `"Tips2"` (× 10 %) in `battleType == 315`. At (-80, -5) (`RoleViewBase.as:354-367`).

#### `BufferIconOnConsortiaEmeDreamBoss` (extends `BufferIconOnRole`)

Map only (WorldBossHeadInfoMediator).
- Constructor `(icon, template, index)` (`core_module/scripts/battle/view/buffer/BufferIconOnConsortiaEmeDreamBoss.as:14-19`).
- Listens to `MsgMan "ConsortiaEvent.CONSORTIA_BOSS_BUFFERIDS"` and rereads `emeDreamInfo.BufferIds.split(",")[index]` (:21-54).
- If the template exists, updates `tipData` and icon; else `dispose()` (:45-53).

#### `BufferLastEffect` (continuous buff effect on the body)

Source: `core_module/scripts/battle/view/buffer/BufferLastEffect.as`.
- `show()` (:42-57):
  - no-op if `battleModel.isHideOtherInBattle(role)`;
  - `res = template.getLastEffectArr()[0]` (passed by the creator); position `role.getSpecialPos(arr[1])`;
  - `interval = arr[2]`;
  - MC from `resourceModel.getOrCreateInstanse(res)`, added to the role's EffectContainer.
- On last frame (:65-76, 78-90):
  - if `interval > 0`: `stop()`, hide, wait **`interval*40` ms**, repeat;
  - if `interval == 0`: MC loops naturally.
- Created once per templateId on `SHOW_BUFFER` (`RoleViewBase.as:541-561`). Removed in `RoleViewBase.removeBuffer(id)` (`RoleViewBase.as:1477-1485, 675-690`).

#### `BufferIconFactory`

Source: `core_module/scripts/battle/view/buffer/BufferIconFactory.as`.
- Singleton (:17-20).
- `getBufferEffectII(name)` = `new SkillEffect(name)` (:22-26).
- `getBufferEffect(n)` = `SkillEffect("slg.resource.BufferEffect" + n)` for n 1 to 11, else 1 (:28-48). **No callers.**

#### `BossBufferContainer` (boss buffs in the top panel)

Source: `m10/scripts/battle/view/buffer/BossBufferContainer.as`; extends Component. Constructor `(boss, direction=-1)` (:36-44).

**Sources, in draw order (`showBuffer`, :122-184)**
1. `_buffers`: buffs with `currentTurn > 0` and an `Icon` (:89-110).
2. `_permanentBufferList`: `boss.pushPermanentBufferDamageDatas`, i.e. buffs with `isPermanent` (:319-322; `core_module/scripts/yishi/datas/objects/RoleInfo.as:1011-1028`).
3. `_specialBuffers`: only with **`battleType == 3853`**. From `BaseManager.wasteBossBufferIdByBoss` (CSV of template ids), replaces the permanent list (:298-318).
4. Immunities: `boss.heroInfo.templateInfo.RejectType.split(",")`, one icon per valid template id (:186-208, 275-290).

**Layout**
- Each icon at **`y = 70`**, `x = i * (icon.width + 10) * direction`.
- Direction -1 grows left (RoleShowViewII and Mutil); direction 1 grows right (RoleShowViewIII).
- `icon.width` ≈ 33 (32 icon + layer text at x=3, width 30), step ≈ 43 px *(assumption)*.
- **No limit** on count.

**Cache and hiding**
- Icons cached in `_buffData`, keyed by `"bufferUser_templateId"`, `template.Id` or the immunity id (:247-290).
- If the boss is null or dead (`isLiving == false`), nothing is shown (:112-115).

**Events**
- From the boss: `"REFRESH_BUFFER"` and `"isLiving"`. On death calls `boss.cleanBuffers(false)` and an empty refresh (:46-82).
- `refreshTurn()` only updates present icons (:326-341).
- `disposeBossInfo(info)` removes icons and events when `livingId` matches (:348-355; `BattleUIView.as:2066-2072`).

**Findings**
- If a permanent buff is also in `_buffers`, the same object is `addChild`ed twice and ends up in the 2nd position, leaving a gap *(assumption)*.
- Immunity icons are recreated on every `initEvent` (:190).

#### `SelfBufferView` (own hero buff bar, above the bottom bar)

Source: `m10/scripts/battle/view/ui/SelfBufferView.as`.

**Position**
- BottomBar: (-190, -99), or (-165, -144) with `VersionSwitch.WARSOUL` (`m10/scripts/battle/view/bottom/BottomBar.as:142-150`).
- PetSacristyBar: (-132, -104) (`m10/scripts/battle/view/bottom/PetSacristyBar.as:47-50`).
- BottomBar is only `addChild`ed in the `else` branch of several conditions (`BattleUIView.as:1272-1317`).

**Events:** `selfHero` `"REFRESH_BUFFER"` and `"REFRESH_BUFFER_TURN"` (:99-103, 224-227).

**Order on each refresh (`__reFreshBuffer`, :126-145)**
1. **`battleType == 3853`**: synthetic buffs from `BaseManager.wasteBossBufferIdByHero` (CSV) (:69-97).
2. **`battleType == 309`**: `emeDreamInfo.BufferIds.split(",")` **from index 2**. Indices 0 and 1 belong to the boss and show on the map (:37-67).
3. Real buffs with `currentTurn > 0` and `Icon` (:133-144).

**Layout (`layerOutBuffer`, :164-173)**
- **4 per row**: `x = (n % 4) * (iconWidth + 4)`.
- **Rows grow upward**: `y = floor(n / 4) * (-iconHeight - 4)`.
- At 25×25 the step is 29 px. No limit.

**Cache:** icons by `BufferDamageData.id` in SimpleDictionary (:152-157).

**Finding:** synthetic buffs use `new BufferDamageData()`, default `id` 0. So they share **one icon**, moved for each: only the last shows and earlier slots stay empty (:58-60, 88-90, 152-159).

`removeBuffer` only removes icons from the display; the dictionary keeps old ones (:175-195). `setScale` has no callers *(not verified across all modules)*.

#### `SelfBufferIcon` (extends `BaseIconView`)

Source: `m10/scripts/battle/view/ui/SelfBufferIcon.as`.
- Custom style `"battle.SelfBufferIcon"`: 25×25, `tipStyle "battle.view.buffer.BufferListItemTip"`, `tipDirctions "7,6,0"` (`index/styles.json`).
- `_layerCount`: `creatComponentByStylename("battle.SelfBufferIcon.LayerCount")`, FilterFrameText 25×16 at (0, 7), Arial 12 `#FFEFBD` right-aligned. Gets **`filters = []`**, removing the style glow (:41-42).
- z-order: `_iconContainer`, `_loading`, `_layerCount` (:45-60).
- `refreshView`: layers as in BufferIconOnRole (`layerCount > 1 && PressCount > 0`); icon `getCommonIconPath(Icon)`; `tipData = buffer` (:62-79). No turns on the icon.

#### `BufferListItemTip` (tooltip for all buff icons)

Source: `core_module/scripts/battle/view/buffer/BufferListItemTip.as`; extends BaseTip.

`init()`, :60-83, creates and positions children:

| element | style | position/notes |
|---|---|---|
| `_bg.width` | - | 330 (:63) |
| `_icon` | `creatCustomObject("tips.BufferItemTip.Icon")` | BaseIconView 45×45 at (10, -10); addChild |
| `_describe` | `"tips.BufferItemTipNameText"` | x=65, w=250, `autoSize` left, `wordWrap`, Arial 12 white, glow |
| `_turnText` | `"tips.BufferItemTipTurnText"` | 180×30, y=4, Arial 12 white right-aligned |
| `_countText` | `"tips.BufferItemTipCountText"` | - |
| `_dispelText` | `"tips.BufferItemTip.dispelText"` | x=90, 120×20, `#07ADFA` right-aligned |
| `_splitLine` | `creatBitmap("asset.tips.splitLine")` | `width = 200` (:82) |
| `_maxLayerText` | `"tips.BufferItemTip.maxLayerText"` | `#818181` left |
| `_maxValueText` | `"tips.BufferItemTip.maxValueText"` | `#818181` right |
| `_layerBox` | `"tips.bufferlistitemtip.layerBox"` | HBox x=5, `spacing` 10 |
| `_turnHBox` | `"tips.bufferlistitemtip.turnBox"` | HBox y=20, `spacing` 10 |
| `_countBox` | `"tips.bufferlistitemtip.countBox"` | HBox y=45, `spacing` 10 |
| `_turnNum`, `_countNum` | `creatBitmap("asset.tips.equipnum")` | - |
| `_con` | `"tips.bufferlistitemtip.countVBox"` | VBox (8, 8), `spacing` 3; addChild |

**`updateTransform` (:85-157)**
1. **Name:** `htmlText`, height `textHeight + 5`.
   - BufferDamageData: placeholder `{field}` replaced by `abs(template[field]) * layerCount` (:175-191).
   - BufferTemplateInfo: `BufferName` directly.
2. **Remaining turns** if `currentTurn > 0`: bitmap digits `getNumberView(n, …, 15, 21, 15, 15, "0123456789", 1)` followed by `"turnos"` (`turnText03`); HBox at `x = 200 - width - 8`.
3. **Count** if `countWay > 0`: same with `"vezes"` (`turnText02`).
4. **Dispel** if `template.Dispel != 0`: `"Não pode despersar/purificar"` (`noDispel`).
5. **Layers** if `PressCount > 0`: split line + `"Pode no máximo acumular camadas"` + `"{0} camadas"`.
6. **Background:** `_bg.height = con.y + con.height + 15`; `_bg.width = max(con.x + con.width + 15, con.x + describe.x + describe.textWidth + 15)`.

Strings in `web/public/ui/language.txt:336-337` and 7449-7452.

#### `BufferListItem` / `BufferListView` (dead code)

- **BufferListItem:**
  - `BaseIconView(loadComplete)` with `tipStyle "battle.view.buffer.BufferListItemTip"`, fixed 30×30 (`m10/scripts/battle/view/buffer/BufferListItem.as:22-33, 68-76`).
  - `_turnTxt`: `"battle.BufferTurnTxt"` (Arial 16 `#FFEFBD` centered, 50×22) at `y = 30 - 20 = 10`, `x = 30 - width`, text = `currentTurn` (:30-32, 51-61).
  - Icon uses `_data.Icon` (:46).
- **BufferListView:**
  - listens to `selfHero "REFRESH_BUFFER"`, keeps only `currentTurn > 0`;
  - dedupes by templateId, uses a pool;
  - `x = 35*i` (`m10/scripts/battle/view/buffer/BufferListView.as:27-45, 114-146, 182-192, 223-235`).
  - Bug in `clear()`: iterates `_pool` while indexing `_items` (:250-258).

### 8.3 battleType conditions (consolidated)

| value | effect | file:line |
|---|---|---|
| 310, 3852 | RoleShowViewIII / DoubleBossInfoView; `resistUIView` y 265/215 | `m10/scripts/battle/view/ui/BattleUIView.as:1367-1372` |
| 310 | `BossBottomStrip.resetView()` on blood event type 10 | `core_module/scripts/battle/view/roles/RoleViewBase.as:1099-1101` |
| 311, 312 | MutilBossShowView, boss + 1 LiteBar_0, offsets [0, 673] | `BattleUIView.as:1373-1378` |
| 313 | MutilBossShowView, boss + 2 LiteBar_1, offsets [0, 790, 790]; boss treated as world boss (`reduceWorldBossBlood`) | `BattleUIView.as:1379-1383, 1597-1601, 1626-1629` |
| 311..313 | `updateMutilRoleShowView` active; opcode 4794 | `BattleUIView.as:1549-1555, 1607-1610` |
| 295 | RoleShowViewII; `resist` y=250; TrailCountView | `BattleUIView.as:1384-1388, 1474-1479` |
| 295, 3898 | dead roles not added (no TeamStrip) | `m10/scripts/battle/view/BattleView.as:259-265` |
| 3855 | OutyardShowView instead of RoleShowViewII | `BattleUIView.as:1389-1391` |
| 349, 3867, 3889 | no boss top panel | `BattleUIView.as:1392-1395` |
| others | RoleShowViewII (BossInfoView only if a `type==3` is on the right) | `BattleUIView.as:1396-1399`; `RoleShowViewII.as:61, 71` |
| 3903 | ForbiddenBossUIView at top, centered; also a world boss | `BattleUIView.as:1346-1350, 1116-1120`; `core_module/scripts/yishi/datas/BattleModel.as:1075-1077, 864` |
| 17 (+ `wordBossInvincibleState`) | top bar full; "xN" hidden; bottom bar full | `core_module/scripts/battle/view/ui/top/BossInfoView.as:109-112`; `BossStripUIView.as:210-213`; `RoleViewBase.as:1155-1159` |
| `campaignTemplate.Types == 1` (+ invincible) | "xN" hidden | `BossStripUIView.as:214-217` |
| 17, 297, 305, 3865, 313, 3881, 3903 | `getWorldBoss()` exists: sync and other players' damage numbers | `BattleModel.as:861-867` |
| 3846 | opcode 4985 applies boss HP | `m10/scripts/battle/view/ui/RoleShowViewII.as:244-248` |
| 3886 | special wave panel position (`top` 160, `right` 30, x relative to boss) | `RoleShowViewII.as:106-110, 353-360` |
| 309 | boss level = `emeDreamInfo.callGrade`; SelfBufferView adds `BufferIds[2..]` | `BossInfoView.as:224-227, 259`; `m10/scripts/battle/view/ui/SelfBufferView.as:45-66` |
| 3853 | special boss buffs (`wasteBossBufferIdByBoss`) and hero buffs (`wasteBossBufferIdByHero`) | `m10/scripts/battle/view/buffer/BossBufferContainer.as:300-318`; `SelfBufferView.as:76-96` |
| 35, 3844, 3845, 3847, 3864, 3866, 3867, 3868, 3889, 3869, 349 | own hero also gets BufferContainer and body icons | `RoleViewBase.as:477` |
| 315 | inspiration text `Tips2` (level × 10 %) | `RoleViewBase.as:359-362` |
| 16, 19, 32, 35, 36, 38, 306, 307 | no TeamStrip | `BattleView.as:294-308` |
| 3907 | no TeamStrip | `BattleUIView.as:1676-1679` |
| 4, 5, 7, 8, 10 | `isNeedShowRightView()`, never called | `RoleShowViewII.as:200-207`; `RoleShowViewIII.as:92-99` |

**Other conditions**
- Boss bar under the character: `type == 3 && face == 2` (`RoleViewBase.as:304`).
- TeamStrip: `side == selfSide` gives side 1, else side 2 (`BattleUIView.as:1680-1697`).
- Reinforcement waves: `newbieProcess >= 19000` (`RoleShowViewII.as:90`).
- No use of `isSpectator`, `battle_from` or `useWay` in any class read.

### 8.4 Findings

1. **No boss HP text or percentage in battle.** `r_hptxt` is forced to `visible = false` in BossInfoView and BossInfoViewII (`BossInfoView.as:203`; `BossInfoViewII.as:93`). Only the world boss map uses `bloodTxt`, with `"∞ / ∞"` when invincible (`m3/scripts/map/campaign/mediator/mapview/WorldBossHeadInfoMediator.as:126-130`).
2. **"xN" only has glyphs 2 to 6** (`"23456"`, `BossStripUIView.as:209`). Disappears when 1 bar is left. Captain > 6 has no digit.
3. **Each lost bar costs 1.5 s of animation**, sequentially. Heals crossing bars are instant (`BossStripUIView.as:191-196, 297-298`).
4. **Ghost bar:** damage cuts the fill immediately; the orange ghost (or the BossHpStripBgAsset bitmap) drops after 1 s, over 0.5 s. A light (`BossHpStripLightMc`) follows the edge (`StripUIView.as:129-155`).
5. **Panel HP is the sum of all `type==3` bosses**, but face and name are those of the highest level one (`RoleShowViewII.as:75-76, 185-194`; `BossInfoView.as:93`).
6. `LiteBossStripUIView`, `BufferListView`/`BufferListItem` and `BufferIconFactory.getBufferEffect(int)` are unused.
7. Single-bar `BossBottomStrip` uses the top asset (`BossHpStripAsset`), not `BossBottomStripAsset` (`BossBottomStrip.as:17-26`; `BossStripUIView.as:62`).
8. SelfBufferView: all synthetic buffs (3853/309) share one icon (`id` 0), so only the last shows (`SelfBufferView.as:58-60, 152-159`).
9. The buff icon over a character is **a single rotating one** (0.2 s fade, 1 s hold, 0.2 s fade). On the top boss panel they are all side by side, no limit. On the own hero they form a 4-wide grid growing upward.
10. No buff icon shows turns; turns and count only appear in the tooltip. The text on the icon is the layer count.
11. MutilBossShowView: secondary boss HP comes from synthetic HeroRoleInfo (template `Live` and `_life`) synced by opcode 4794. A rise above 60% of total triggers `resetRoleData` (`BattleUIView.as:1585-1591, 1632-1638`).
12. `TeamStrip.dispose()` disposes the shared RoleInfo (`TeamStrip.as:128-131`). `DoubleBossInfoView.setCurrentHp` calls `dispose()` on the dead boss's bar every frame (`DoubleBossInfoView.as:99-102, 116-119`).
13. Names `asset.battle.BossHpStripLightMc`, `asset.battle.BossGradeNumAsset`, `asset.battle.BossHpStripAsset_0/_1` and `asset.battle.BossHpStripBgAsset_1` are **not** in `index/styles.json`; likely direct SWF classes *(assumption)*. Internal geometry of `BossShowRightAsset`, `boubleBossHPAsset` and `LiteBossBloodBar_*` (positions of `head`, `blood`, `r_hp_pos`, `r_grade`, `r_name`) and the per-frame `upStrip` colors live in the SWFs, not the AS.
14. `core_module.json` and `m10.json` in web/public/layout/ confirm the cited `create`/`add`/`set`: ForbiddenBossUIView, TeamStrip, BufferIconOnRole, SelfBufferIcon, RoleShowViewII/III and `BossBufferContainer.y=70`. The `top/*` classes, BossStripUIView and MutilBossShowView appear with `ops: []`, since they use `creatCustomObject`/`new` inside non-extracted methods.

---

## 9. Secondary views and map

Covers attack mode, combo (`BatterUIView`), goddess, space-time, dragon titan, damage increase (`HurtUpView`), outer yard, resistance, the right-side boss views (`RoleShowViewII`/`RoleShowViewIII`), trial floor, loading and the map layers. Paths are relative to `decompiled/`. Styles were checked in `index/styles.json`; bitmap and MovieClip sizes come from `index/ui_symbols.json` (`battle.swf` and `core.swf` declare 24 fps); pt-BR strings come from `index/language.json`.

### 9.0 Creation and scene size

**Who instantiates each class:**
- **`BattleUIView.init()`** creates almost everything (`m10/scripts/battle/view/ui/BattleUIView.as:1159-1492`). The constructor calls `init()`, then `layout()`, then `addEvent()` (`BattleUIView.as:201-206`).
- **`BattleView.init()`** creates `BattleMapView` and `RedScreenEffect` (`m10/scripts/battle/view/BattleView.as:76-100`).
- **`BattleView.__goddessSkillHandler`** creates `BattleGoddessMovieView` (`BattleView.as:357-373`).
- **`EnterBattleController.startHandler`** creates `BattleLoadingView` (`core_module/scripts/battle/control/EnterBattleController.as:98-108`).
- **Dead code:** `AttackModeView`, `PowerUIView`, `SpTip` and `AttackModeChangeEffect` have no `new` in m10 or core_module (empty grep). Their assets are also missing from the indexed `battle.swf` (see §9.4).

**Scene sizes used across the HUD:**
- `_sceneWidth = limitRange(stageWidth, 1000, 1500)` and `_sceneHeight = limitRange(stageHeight, 600, 900)` (`BattleUIView.as:765-766`; `BattleView.as:104-105`).
- `limitRange` is in `core_module/scripts/battle/utils/Helpers.as:234-242`.
- `Helpers.delayCall(fn, n)` counts **frames**, not ms (`core_module/scripts/battle/utils/Helpers.as:89-101`).

### 9.1 Components

#### `AttackModeView` *(dead code)*

Source: `m10/scripts/battle/view/ui/AttackModeView.as`. No `new AttackModeView` exists in the project.

| field | class/style | x,y | z | visibility/condition | events/opcodes |
|---|---|---|---|---|---|
| `_attackBtn` | `creatComponentByStylename("battle.AttackBtn")` → AttackModeButton (:46) | style x=5, y=121 | 1 (:58) | starts visible; `enable=false` if `!visible \|\| !selfHero.isLiving` (:64-67) | `click`→`__onAttackModelChange` (:84) |
| `_defenseBtn` | `"battle.DefenseBtn"` (:49); `parentStyle` = battle.AttackBtn | x=86, y=121 (inherited) | 2 (:59) | same | `click` (:85) |
| `_coolDownTxt` | `"battle.CoolDownTimeTxt"` (:52): FilterFrameText, Arial 12 0x00D2FF, glow `core.normal_f` | x=45, y=128, h=22 | 3 (:60) | `false` (:63) | - |
| `_coldDownPic` | `"battle.ColdDownButton"` (:53): BaseButton, back `asset.battle.AttackModeCDAsset` | x=5, y=121 | 4 (:61) | `false` (:62) | - |

**Texts and tooltips:**
- `modeName`: `public.attack1` = "Ataque" (:47); `battle.view.ui.AttackModeView.defenseBtnModeName` = "Defesa" (:50).
- Keys: "Z" for attack, "X" for defense (:54, :56).
- `tipData` = [`…attackBtn.tipData01` + `public.parentheses2`("Z"), `…tipData02`] (:55). Same for defense (:57).
- pt-BR strings: "Ataque surpresa", "({0}):", "Dano +20%, Dano recebido +20%, Duração 2 turnos, Resfriamento 5 turnos". Defense: "Adesão" and "Dano recebido -20%, Dano -20%, Ganho de fúria +20…".

**Listened events:**
- `battleModel` `actionCountChange` (:86).
- `KeyboardManager` `keyDown` (:87): charCode 122 ('z') calls `setMode(2)`, 120 ('x') calls `setMode(1)`. Only if `_attackBtn.enable` (:97-111).
- `selfHero` `die`: disables both buttons (:88, :91-95).

**`setMode(mode)` (:141-170):**
- Returns if invisible, dead or `isAutoFight` (:143-150).
- Runs `setAttackModelById(selfHero.livingId, mode)`, `actionCount=0`, `attackModeStart=true` and `updateCdValue(0)`.
- Sends **opcode 10016** `AttackModeMsg{serverName, battleId, mode}` (`m10/scripts/battle/net/BattleSocketOuterManager.as:33-41`).
- Disables both buttons. The chosen one becomes `selected`, the other `visible=false`.
- Fires notification `battleModeChange` with `mode` (:169). Modes: 2 = attack, 1 = defense, 0 = none (:209).

**States (`updateCdValue`, :177-197; `CD_TIME=7`, :25):**
- `actionCount < 2`: `setTurnValue(7-5-count)`, i.e. 2 or 1 turns left.
- `actionCount` 2 to 6: both buttons hidden. `_coldDownPic` and `_coolDownTxt` show "Em resfriamento" + (7 - count).
- `actionCount == 7`: `coolDownComplete()` (:199-210) re-enables everything, clears selection, hides the CD and calls `setAttackModelById(...,0)`.
- `getLeftPoint()` returns the `_attackBtn` position (:217-220).

#### `AttackModeButton` (m10 and core_module identical: empty `diff`)

Source: `m10/scripts/battle/view/ui/attackmode/AttackModeButton.as`. Subclass of `BaseButton`, instantiated by styles `battle.AttackBtn` and `battle.DefenseBtn` (`classname`).

`battle.AttackBtn` style attributes:
- `backStyle` `asset.battle.AttackBtnAsset`, `selectedStyle` `asset.battle.AttackSelectedBtnAsset`.
- `filterString` = `core.DefaultFilter,core.LightFilter,core.DefaultFilter,core.DefaultFilter`.
- `tipStyle` = `battle.view.ui.attackmode.AttackModeBtnTip`, `tipDirctions` = 7, `isFollowMouse` = false.
- `battle.DefenseBtn` swaps the back to `asset.battle.DefenseBtnAsset`.

| field | style | x,y | z | visibility |
|---|---|---|---|---|
| `_back` (from BaseButton) | backStyle | 0,0 | 0 | child `selectedMC.visible=false` (:67-70) |
| `_nameTf` | `battle.ModeNameTxt` (:16): Arial 12 0xF1E1BC, h22 | 32,6 | 1 (:71) | `!selected` |
| `_keyTf` | `battle.ValidTimeTxt` (:18): Arial 11 white | 3,17 | 2 (:72) | always |
| `_turnTf` | `battle.TurnNumTxt` (:22): Arial 14 white | 28,6 | 3 (:73) | `false`; `true` when selected (:55, :75) |
| `_turnStrTf` | `battle.TurnStrTxt` (:24): Arial 12 0xF1E1BC | 37,6 | 4 (:74) | same; text `battle.view.ui.attackmode.turnStrTf.text` = "turnos" (:76) |

The `selected` setter (:47-57) toggles `selectedMC.visible`, the turn fields and the name.

#### `AttackModeChangeEffect` *(dead code; m10 and core_module identical)*

Source: `m10/scripts/battle/view/ui/attackmode/AttackModeChangeEffect.as`.
- Listens to `battleModeChange` (:21). Each time calls `clear()` and uses the own hero's `RoleView` `middleContainer` as container (:27-28).
- MC by mode: `data==1` uses `"asset.battle.AttackModeDefenseEffect"`, anything else `"asset.battle.AttackModeAttackEffect"` (:29-36).
- Created with `ClassUtils.CreatInstance`, wrapped in `QuickenMovieClip`, placed at y=-80. Removes itself on the last frame (:39-42).
- If the hero is moving, uses `step=3` (3 frames per tick) (:48-54). Re-evaluated once on `selfMoveStart` (:45, :56-63).

#### `AttackModeBtnTip` (core_module)

Source: `core_module/scripts/battle/view/ui/attackmode/AttackModeBtnTip.as`. A `BaseTip`. Forced to compile in `core_module/scripts/yishi/lunch/ComponentEmbed.as:90`.
- `_bg.width=180` (:22).
- `_title`: `tips.SkillNameText` (Arial 14 0x2fb8ff bold, w130) at x=5, y=2, text `tipData[0]` (:23, :29-32).
- `_describe`: `tips.AttackModeBtnDescribeText` (Arial 12 white, wordWrap, style w250). Code forces `width=190`, at x=5, y=25, text `tipData[1]` (:24, :33-37).
- `_bg.height = 25 + textHeight + 10` (:38).

#### `BatterUIView` (combo and total damage panel)

Source: `m10/scripts/battle/view/ui/BatterUIView.as`.

**Creator:** always in `BattleUIView.init` (`BattleUIView.as:1356-1358`). Starts `visible=false`, y=174. `layout` sets x = sceneWidth - 280 (`BattleUIView.as:770`). It is never added to the display list (no `addChild(_batterUIView)` in `BattleUIView`, see §2.12), so the panel below never appears in this build.

| field | source | x,y | z | notes |
|---|---|---|---|---|
| `_damageAsset` | `ClassUtils.CreatInstance("asset.battle.DamageUIAsset")` (:85); sprite with 2 children | asset's own x (`_damageDestX`); y = `_batterAsset.height` + 15 (:91) | 0 (:87) | child `total_num_pos` |
| `_batterAsset` | `"asset.battle.BatterUIAsset"` (:88); 3 children | asset's x (`_batterDestX`) | 1 (:90) | children `batter_num_pos`, `batterMC`, `animate` |
| `batterNum` | Sprite, mouse off | inside `batter_num_pos` (:96) | - | - |
| `damageNum` | Sprite | inside `total_num_pos` (:97) | - | - |
| `_shake` | `ShakeCircle(_batterAsset.batterMC, 3, 5)` (:99) | radius 3px, 5 frames, random angle (`core_module/scripts/yishi/utils/ShakeCircle.as:22-62`) | - | - |

**Events:**
- `SET_BATTER_COUNT_BattleNotic`: creates `creatCustomObject("battle.TotalDamageNumberAssetSp")`, a 74×54 sprite with TextField `txt`. Sets `txt.text = count`, `txt.width = textWidth + 50`. `addChild` to `batterNum`, `scale=1`, `x = -width` (right-aligned), `y=0`. Then `TweenLite.from(scale 2, 0.2 s)` and `_shake.shake()` (:63-81).
- `SET_TOTAL_DAMAGE_BattleNotic`: same on `damageNum`, no tween (:50-61).
- Both ignored while `_exiting` (:52, :65).
- Fired by `BatterModel`: count (`core_module/scripts/yishi/datas/battle/BatterModel.as:67, :108`) and total (`BatterModel.as:90, :109`). Suppressed when `lock`.

**Visibility:** `BatterModel.batterCount > 2` (first time) sends `SET_BATTERUI_VISIBLE_BattleNotic(true)` (`BatterModel.as:69-73`). `isStart=false` sends `false` (`BatterModel.as:43-46`). `BattleUIView.__batterUIVisible` (`BattleUIView.as:678-703`):
- `true`: `lock=false`, `visible=true`, `show()`.
- `false`: after **25 frames** calls `hide()` and `lock=false`. `visible` stays `true`; only alpha goes to 0.

**Animations:**
- `show()` (:102-112): `reset`, restores the matrix, `TweenLite.from(_damageAsset, 0.7 s, {alpha 0, x "-100"})` (slides in from 100px left). Then `_batterAsset.animate.gotoAndPlay(1)`.
- `hide()` (:125-137): `_batterAsset` to alpha 0, x = dest + 96 in 0.4 s. `_damageAsset` to alpha 0, x = dest - 96 in 0.4 s. `_exiting=true` until done (`EXIT_DISTANCE=96`, :17).

#### `BattleGoddessMovieView` (goddess skill movie)

Source: `m10/scripts/battle/view/ui/BattleGoddessMovieView.as`.

**Creator:** `BattleView.__goddessSkillHandler`, only if `VersionSwitch.GODDESS_OPEN` and the array has at least one item (`BattleView.as:357-373`). The instance is reused and re-`addChild`ed on every call, so it moves to the top of `BattleView`.
- Source of `GODDESS_GUARD_SKILL`: opcode **4102** (`core_module/scripts/battle/transaction/BattleGoddessMovieTransaction.as:67, :70-73`) and `BattleFunctionHelper.goddessMoiveViewHandler` (`core_module/scripts/battle/utils/BattleFunctionHelper.as:140-149`).
- Data shape: `[{skillId, livingId}]`.

| field | style | x,y (code overrides style 170,390) | z |
|---|---|---|---|
| `_leftContiner` | `"BattleGoddessMovieView.leftContiner"` (Component) (:43) | x = `rolePointByPos(4,1).x` - 370, y = `stageHeight/2` - 280 (:48-49) | 0 |
| `_rightContiner` | `"BattleGoddessMovieView.rightContiner"` (:44) | x = `rolePointByPos(4,2).x` - 180, same y (:50-51) | 1 |

- Pos 4 points: (555,630) left, (945,630) right. Grid is `get9GridPos(295,570)` / `(905,570)` (`core_module/scripts/battle/utils/BattleUtils.as:108-150, :153-215`). Hence left x=185, right x=765.
- y uses raw `stageHeight`, no clamp.
- Mouse off (:47).

**`setViewData(arr)` (:87-121):**
- Resolves a `GoddessRoleInfo` per `livingId`. Skips those hidden by "hide others" (`isHideOtherInBattle`, `core_module/scripts/yishi/datas/BattleModel.as:1113-1175`).
- `face==1` goes left, `face==2` right. Sorted by numeric `pos` (`sortOn("pos",16)`).
- MC is `resourceModel.getOrCreateInstanse("asset.goddess.skill" + template.Type)`, starting at `gotoAndStop(1)` (:136-138).

**Queue (`enterFrame` via `EnterFrameManager`, :143-167):**
- Per side, one MC is dequeued every **≥800 ms** (`getTimer`).
- MC gets `addChild` + `gotoAndPlay(1)` and is recycled on the last frame.

**Events:** `BATTLE_OTHER_LIVING_VISIBLE` clears everything (:58, :72-85).

#### `BattleGoddessTopItem`

Source: `m10/scripts/battle/view/ui/top/BattleGoddessTopItem.as`. `viewRectangle` = 95×112 (:34-37).

| field | style | x,y | z |
|---|---|---|---|
| `_goddessHeadMc` | `creatCustomObject("BattleGoddessTopItem.goddessHeadMc")` → `asset.BattleGoddessTopItem.goddessHeadMc` (5 children) (:41) | 0,0 | 0 |
| `_goddessHead` | `creatCustomObject("BattleGoddessTopItem.goddessHead")` → BaseIconView (:42) | inside `_goddessHeadMc["icon"]` (:44) | - |

MC children: `progress` (frame-based bar), `fullMc1`, `fullMc2`. Initial state: all at frame 1, full MCs hidden (:45-50).

**`refreshView` (:64-121), `data = HeroRoleInfo`:**
- Returns if `belief` unchanged.
- `frame = max(1, int(min(belief,100)/2))`.
- `belief` dropped: `progress.gotoAndStop(frame)`.
- Rose: sets a frameScript to stop at `frame` and runs `progress.play()` (root MC also gets `play()`).
- `belief ≥ 100`: `fullMc1` and `fullMc2` visible and playing. Below that, hidden and stopped.
- Icon: `PathManager.getBattleGoddessHeadPath(template.Type)` (:105-109).
- No `data` or no `goddessRoleInfo`: clears everything (:111-120).

#### `BattleGoddessTopView`

Source: `m10/scripts/battle/view/ui/top/BattleGoddessTopView.as`. Constructor takes `(side)`.
- `_hbox`: `"BattleGoddessTopView.hbox"` (HBox, spacing 0, position 0,0) (:35).
- Four `BattleGoddessTopItem` in order (:44-52), data `battleModel.heroList[i+"_"+side]` for i 0 to 3 (:77-88).
- Mouse off (:37).
- Refreshes on `MsgMan` `GODDESS_BELIEF_CHANGE` (fired at `core_module/scripts/yishi/datas/objects/RoleInfo.as:793`) and `BATTLE_REINFORCE_HANDLER` (:57-58).

**Creator:** `BattleUIView.init` (`BattleUIView.as:1212-1226`) and `__refreshViewHandler` (`BattleUIView.as:514-528`, see §9.4, finding 3).
- Own: x = sceneWidth/2 - 480, y = -20. Enemy (side `3 - selfSide`): x = sceneWidth/2 + 40, y = -20 (`BattleUIView.as:1088-1097`).
- Condition: `BattleFunctionHelper.showGoddessTopAry()` (`BattleFunctionHelper.as:281-378`); the battleType lists are in §2.8 and §9.3.
- `hasGoddessUI` is true if either view exists (`BattleUIView.as:1813-1820`).

#### `BattleSpaceTimeBox`

Source: `m10/scripts/battle/view/ui/BattleSpaceTimeBox.as`.

**`initConfig(idx, start, end, boxType, count)` (:33-52):**
- `_canUseTime = end - start`.
- If `boxType` changed, recreates `_mc = creatCustomObject("asset.battle.spaceTimeBox"+boxType)` (45 frames, 0,0) at z0.
- Also creates `_boxCountText = "battle.spaceTimeBox.boxCountText"` at z1: FilterFrameText 30×20 at (5,10). Frame 1 = Arial 14 0xF4FFCC bold, frame 2 = Arial 14 0x666666. Text is `count`.

**`refreshTime(t)` (:54-88):**
- `t < end`: `r = (t - start)/canUse`. `r ≤ .25` → star 4, `≤ .5` → 3, `≤ .75` → 2, `≤ 1` → 1.
- `t ≥ end`: star 0.

**`star` setter (:90-119):** 4 → frame 1, 3 → 10, 2 → 20, 1 → 30, 0 → frame 40 (text also goes to frame 2, gray).

#### `BattleSpaceTimeView` ("Falha espaço-tempo")

Source: `m10/scripts/battle/view/ui/BattleSpaceTimeView.as`.

**Creator:** `BattleUIView.init` when `isSpaceTimeBattle`, i.e. battleType **3870** (`BattleUIView.as:1187-1191, :1991-1997`). It sits in an `else if`, so it does not appear for `isPetBatle`, `isSacristyBatle`, `isChildpveBatle`, `isSpiritExpedition`/`isDarkMaze`, `isChildBattle` or `isMonsterBattle`.
- `addChild`ed before `_bottomBar` (`BattleUIView.as:1309-1313`).
- x = (sceneWidth - 187)/2, y = 0 (`BattleUIView.as:1107-1110`).

| field | source | x,y | z |
|---|---|---|---|
| `_back` | `creatBitmap("asset.battle.spaceTimeBoxBK")` (187×41, no indexed style) (:63) | 0,0 | 0 |
| `_listBox` | `"spacetimefalut.battle.RewardHbox"` (HBox, spacing 0, style x=25) (:64) | x = (`_back.width` - `_listBox.width`)/2 (:148) | 1 |
| 5 × `BattleSpaceTimeBox` | `MAX=5` (:34, :71-83) | inside the HBox | - |

**Config:**
- Strings from `TempleteManager.getSpaceTimeBoxConfigValue` (`SpaceTimeNomal` or `SpaceTimeNightmare`) and `getSpaceTimeBoxCountConfigValue` (`SpaceTimeNormalRewards` or `SpaceTimeNightmareRewards`) (`core_module/scripts/yishi/manager/TempleteManager.as:3458-3492`; view :59-62).
- `mapId == 9998` uses the normal config; anything else the advanced one (:176-177).
- Format: layers separated by `|`, index `trialLayer - 1` (min 0) (:180-183). Within a layer, boxes separated by `,`, each `"type:endSeconds"`. Each box's count comes from the rewards string at the same index.
- Each box's `start` is the previous box's end (:127-137).
- Boxes enter the HBox **in reverse order** (:138-147).

**Timing:**
- First time: `_startTime = getTimer() - (serverNow - playerInfo.spaceTimeBoxTimeBegin)`. Server time from `sysCurtime` or `castle_offset` (:184-211).
- On later layer changes: `_startTime = getTimer()`.
- On `enterFrame` (`EnterFrameManager`), whenever the whole second changes, calls `refreshTime(passSeg)` on each child (:85-107).

**Event:** `TRAIL_LAYER_CHANGE` (:153), fired by the `trialLayer` setter (`core_module/scripts/yishi/datas/BattleModel.as:1090-1097`).

#### `ChildNswarBattleRoleIcon` (child icon in the child arena)

Source: `m10/scripts/battle/view/ui/ChildNswarBattleRoleIcon.as`. Constructor `(idx, side)`. Created by `HurtUpView` only for battleType **3911** (`HurtUpView.as:134, :144, :164`).

| z order | field | source | x,y | visibility |
|---|---|---|---|---|
| 0 | `_bg` | `creatBitmap("asset.battle.nswarIconBg")` 55×62 (:47) | 0,0 | yes |
| 1 | `_icon` | `creatCustomObject("childnswar.battle.childIcon")`: BaseIconView 46×46, tip `OneLineTip` (:48) | 4,7 | yes; `mask = _mShape` (:77) |
| 2 | `_mShape` | circle r=20, color 0xFF0000 (:62-67) | 27.5,30 | mask |
| 3 | `_idxBg` | side 1: `"battle.childnswar.IdxLeftImg"` (Image `asset.battle.SkillCountBack` 19×16, -35,-7). Other side: `"…IdxRightImg"` (13,-7) (:50-61) | - | yes |
| 4 | `_idxTxt` | `"battle.childnswar.leftIdx"` (-20,34) or `"…rightIdx"` (28,34). `parentStyle` battle.SkillCount: 30×20, Arial 13 white bold, right-aligned. Text = idx (:78) | - | yes |
| 5 | `_fightIng` | `creatBitmap("asset.battle.nswarLeft")` (-4,4) or `"nswarRight"` (2,4), 58×52 | - | `false` |
| 6 | `_dieImg` | `creatBitmap("asset.battle.nswarDie")` 35×34 | 8,14 | `false` |

**`updateView(ChildPvpBattleChildMsg)` (:81-107):**
- Icon: `PathManager.info.ResourcePath + "icon" + template.Icon`, template by `(jobType, grade 1)`.
- `state`: 0 none, 1 fighting (`_fightIng`), 2 dead (`_dieImg`).
- Null `msg`: clears.

#### `DragonTitanIconItemView`

Source: `m10/scripts/battle/view/ui/DragonTitanIconItemView.as`.
- `_skillBg1`: `"dragontitan.skillBg1"` (Image 68×68 at 0,0), z0 (:36, :38).
- `_icon`: `creatCustomObject("dragontitan.DragonTitanIconItemView.icon")` (BaseIconView 60×60 at 3,3), z1 (:37, :39).
- `width` fixed at 67 (:60-63).

**`set data({livingId, titanId, titanSkill})` (:42-58):**
- `tipData = livingId`, `tipStyle = "yishi.view.tips.DragonTitanFightingTips"`, `isFollowMouse=false`, `tipDirctions="2,1"`.
- Icon: `IconFactory.getCommonIconPath(titanTemplate.AvatarPath)`.
- Null data: returns without clearing.

#### `DragonTitanTeamView` (side titan panel)

Source: `m10/scripts/battle/view/ui/DragonTitanTeamView.as`. Constructor `(side)`.

**Creator:** `BattleUIView.init` (`BattleUIView.as:1197-1211`, added at :1318-1328). Conditions:
- `!isNoHeroBattleType()`. No-hero types: **3847, 3845, 3844, 35, 3867, 3889, 3895, 3868, 3898, 3907** (`BattleUIView.as:1527-1530`).
- Some hero (pos 0..3) on either side with `titanId > 0` (:1504-1525).
- `ConfigManager.version_info.TAITAN_LOCK` true.
- If the enemy has heroes, creates own and enemy. If only the own side does, creates only own.

`BATTLE_REINFORCE_HANDLER` also creates it (`BattleUIView.as:479-513`). No `TAITAN_LOCK` check there, and the enemy panel is only created if battleType != 3870.

Position (`BattleUIView.as:1078-1087`): own at x=0, enemy at x = sceneWidth - 120, both y = sceneHeight·0.5 - 130.

| z | field | style | x,y | notes |
|---|---|---|---|---|
| 0 | `_fightBg` | `"dragontitan.fightBg"` (Image 120×303) (:52) | 0,0. Own side: `scaleX *= -1` and x=120, mirrored (:70-71) | hidden if `isSingleBattle` (:62-66) |
| 1 | `_clickArea` (Sprite) | holds `_hidebtn` (`"dragontitan.hidebtn"`, 10×11, y=122), `_hideImgTxt` (`"dragontitan.hideImgTxt"`, 21×56, y=139) and `_expandImgTxt` (`"dragontitan.expandImgTxt"`, 21×45, y=140) (:53-61) | own side: hidebtn 100, texts 97. Enemy: 11 and 8 (:68-81) | hidden if `isSingleBattle`; `click` (:253) |
| 2..5 | 4 × `DragonTitanIconItemView` | - | x=13 (own) or 40 (enemy); y = 13 + i·70 (:82-98) | with `isSingleBattle`, hides empty slots (:159-170) |

**States (`refreshView`, :112-145):**

| | own side | enemy |
|---|---|---|
| Expanded | `hidebtn.scaleX=-1`, x=110 | `scaleX=1`, x=11 |
| Collapsed | `scaleX=1`, x=100 | `scaleX=-1`, x=21 |

Expanded shows `_hideImgTxt`; collapsed shows `_expandImgTxt`. Data from `heroList["0".."3"+"_"+side]` (:152-158).

**Click (:258-297):**
- `sw = limitRange(stageWidth, 1000, 1500)`.
- Show: own to x=0, enemy to sw - 120. Hide: own to x=-91, enemy to sw - 29.
- `TweenLite` 0.4 s on `x`; `isTweening` blocks new clicks.

**`isSingleBattle` (:173-218):**
- battleType **3842 or 3854** → false (from `battleType - 3842 == 0 or 12`).
- Else `battleCapity == 1` → true.
- Types **18, 25, 3870, 13, 10, 290, 295, 310, 291, 3841, 3842, 314, 305, 3852, 3853, 3877, 3878, 3891, 3894** → false.
- Types **306, 307, 293, 3871, 3893** → true.
- Others: true if `getAttackerNum() == 1`.

Also listens to `BATTLE_REINFORCE_HANDLER` (:255), fired by `core_module/scripts/battle/handler/ReinforceHandler.as:312`.

#### `HurtUpView` (PvP countdown, "damage increase")

Source: `m10/scripts/battle/view/ui/HurtUpView.as`.

**Creator:** `BattleUIView.init` if `battleModel.isPvP()` (`BattleUIView.as:1329-1333`). x = sceneWidth·0.5 - 30, y = 0, never changed (`BattleUIView.as:1098-1101`). `width` fixed at 318 (:236-239).

`isPvP` (`core_module/scripts/yishi/datas/BattleModel.as:947-1023`):
- false for **291, 39, 3844, 3847, 3867, 3868, 3870, 3872, 3873, 3875, 3845, 3889**.
- true for **35, 349, 3907**.
- Else true if some `HeroRoleInfo` with type other than 3 and 2 exists on the side opposite `selfHero`.

`_mode` is `battleModel.getHurtMode()` (`BattleModel.as:938-945`). `hurtUpStart(countDownMs, improve, addition)` (`BattleModel.as:921-936`):
- battleType 3847 uses `resetChildArena`; others use `reset`.
- Called at `core_module/scripts/battle/transaction/CreateGameTransaction.as:116`, `BattleNoticeTransaction.as:22` and `BattleStartTransaction.as:29`.
- `HurtUpMode` has a 10 ms Timer and fires `change` on each whole second decremented (`core_module/scripts/battle/mode/HurtUpMode.as:27-87`).
- `_damageImprove` is cumulative (`HurtUpMode.as:38, :56`).

Common elements:

| z | field | source | x,y | visible |
|---|---|---|---|---|
| 0 | `_tipBack` | `"ui.battle.battle.BattleHurtUpTipBack"`: ScaleBitmapImage 318×54, grid "20,14,278,24" (:126) | x=-131. y=58, or 118 if `hasGoddessUI` (:218-227) | `false` → `true` if `improve > 0` |
| 1 | `_tipTxt` | `"battle.HurtUpTipTxt"`: 318×22, Arial 16 0xff0000 bold, centered (:129) | x=-122. y=72, or 132 with goddess | same |
| last | `_countDownValue` | `NumberBitmap.initParams(null, "asset.core.number_img_09", 15, 19, 15, 15, "0123456789.", 0, 0, 0, 50)`: 15×19 glyph, advance 15, centered in width 50 (:132-133; `core_module/scripts/yishi/view/base/NumberBitmap.as:62-102`) | see variants below | yes; `num = getTimeLeft()` (:230-234) |

**Normal variant** (battleType != 3911, :180-188):
- `_countDownBack`: `creatBitmap("asset.battle.CountDownBack")` 277×44 at (-110,0), z2.
- `_countDownWord`: `"asset.battle.CountDownWords"` 71×19 at (-33,5.85), z3.
- Number at (36,4).

**battleType 3911 variant, "Child Nswar"** (:134-179):

| z | field | source | x,y |
|---|---|---|---|
| 2 | `_countDownBack` | `creatBitmap("asset.battle.nswarCdbg")` 649×67 | -295,-10 |
| 3 | `_leftChidNsIconBox` | `"battle.childnswarLeft.HBox"` (strictWidth 61); icons idx 3,2,1 added in that order | -218,-4 |
| 4 | `_rightChildNsIconBox` | `"battle.childnswar.right.HBox"` (strictWidth 61); icons 1,2,3 | 97,-4 |
| 5 | `_childNswarBuffBack` | `"ui.battle.battle.BattleHurtUpTipBack2"`: 318×54 at (-131,138); height = `txt.height` + 25 | - |
| 6 | `_childNswarBuffTxt` | `"battle.HurtUpTipTxt2"`: Arial 14 0xff0000 bold, leading 5, wordWrap; at (-122,152); height = numLines·20 | - |

- Number at (4,14).
- Buff hidden after **10000 ms** via `setTimeout` (:178, :193-200).
- `nswarBattleHandler` (:76-120): left uses `battleRoleList[selfSide+"_"+i]`, right `[enemySide+"_"+i]`, i 0 to 2. A new `buffId` greater than 0 sets the buff text to `skill.Description`.
- Event `childNswar.Event.Battle`, fired on receiving **opcode 574** `ChildPvpBattleMsg` (`core_module/scripts/managers/ChildNswarManager.as:88, :91-106`).

**Tip text (:204-216):**
- `_mode.battleType` 35 or 307: `battle.hurtUpTip.text2` + " " + N + "%" ("Todos os adversários receberam danos").
- Others: `battle.hurtUpTip.text` ("Aumento de danos a todos em").

#### `OutyardShowView` (outer yard defense)

Source: `m10/scripts/battle/view/ui/OutyardShowView.as`.

**Creator:** `BattleUIView.init` with battleType **3855** (`BattleUIView.as:1389-1391`, add :1406-1409). `showTopView()` and `hideTopView()` toggle `visible` (`BattleUIView.as:1827-1865`).

| z | field | source | x,y |
|---|---|---|---|
| 0-3 | `_generalBmp1..4` | `creatBitmap("asset.battle.generalBmp1..4")` (26×35, 22×41, 33×41, 39×42) | (63,9), (125,2), (178,2), (237,0) |
| 4 | `_defenceBg` | `"asset.battle.defenceBg"` 213×25 | 30,80 |
| 5 | `_progressMc` | `creatCustomObject("battle.generalProgressMc")` (100 frames) | 0,60 |
| 6 | `_leftArmyTxt` | `"outyard.OutyardShowView.leftArmyTxt"`: 100×20, Arial 12 white, centered | 95,52 |
| 7 | `_guildArmyTxt` | `"…guildArmyTxt"`: Arial 12 0xe85b5b | 95,83 |

- General glow: one `MainToolBtnGlowEffect` per bitmap (:78-81).
- Layout: x = `BattleView.sceneWidth` - `this.width` - 300, y = 30 (:149-155). Redone on resize.

**`OUTYARD_BATTLE_DEFENCE`** comes from `OutyardCrystalModel.battleDefenceHandler` (`core_module/scripts/mvc/module/outyard/OutyardCrystalModel.as:218-222`). Handled at :109-142:
- Progress frame = int((total - alive)/total·100).
- Texts: `outyard.OutyardShowView.leftArmyTxt.text` ("Equipe restante {0}", with alive count) and `guildArmyTxt.text` ("Poder de guarnição reduz {0}%", with 100 - `defenceProperty`).
- Per `defenceSeniorGeneral`: normal filter. If `alive && inBattle`, glow `play1()`. If dead, gray filter.

**`enterFrame` (:99-107):** if `armyInfoRight.getLeftHp() ≤ 0`, sets `isOver=true` and sends `FORCE_SKILL_ENABLE(false)`.

#### `PowerUIView` *(dead code)* + inner `AddSpNumAnimation`

Source: `m10/scripts/battle/view/ui/PowerUIView.as`.
- `_asset`: `CreatInstance("asset.battle.PowerUIViewAsset")` at z0 (:76-77).
- `_stripView = new StripUIView(CreatInstance("asset.battle.PowerStripAsset"), 100, sp, 0, true, true)` with `currentValue=0`, z1, placed at `_asset.power_pos` (:78-82, :87).
- `_frontView`: `creatBitmap("asset.battle.PowerUIFrontView")` at (66,10), z2 (:83-86).
- Tooltip: `tipStyle "battle.view.ui.SpTip"`, direction "1", `tipGapV=0` (:33-36), `tipData` = sp (:109).
- Listens to `selfHero` `"sp"`. Increase with `data.increase` uses `SpStripIncreaseAnimation`; without it, applies directly, capped at 100 (:45-141). With `showTip`, adds `AddSpNumAnimation`.
- `AddSpNumAnimation` (:175-239): `creatBitmap("asset.battle.PowerUIAddSp")` followed by the number in `asset.core.number_img_01` (13×17, advance 14). Position (230,-73), alpha 0. 0.5 s tween to y - 43 and alpha 1, removed 1000 ms later.

#### `RaceAgainstTimeUpView` (race against time)

Source: `m10/scripts/battle/view/ui/RaceAgainstTimeUpView.as`.

**Creator:** `isRaceAgainstTime()`, i.e. battleType **3894** (`core_module/scripts/yishi/datas/BattleModel.as:1070-1073`; `BattleUIView.as:1339-1345`). Comes with a `TrailCountView`. Position: x = (sceneWidth - width)/2 + 45, y = 0 (`BattleUIView.as:1111-1115`).

| z | field | source | x,y |
|---|---|---|---|
| 0 | `_back` | `creatBitmap("asset.battle.raceAgainstTime.timeBack")` 247×92 | 0,0 |
| 1 | `_txt` | `"raceAgainstTimeUpView.txt"`: 139×28, arial 16 0xc17d54 bold, centered. Text `RaceAgainstTimeUpView.txt` = "Tempo decorrido" | 51,12 |
| 2 | `_timeTxt` | `"raceAgainstTimeUpView.timeTxt"`: 50×28, arial 16 0xfff9db bold, glow 0xce5700. Text `yishi.utils.DateFormatter.timeStr.min` = "Min" | 140,52 |
| 3 | `_time` (Sprite) | digits from `asset.battle.raceAgainstTime.num` (231×29; "0123456789:"; glyph 21×29, advance 19), zero-padded below 10 | 90,48 |

- `_begin = playerInfo.raceAgainstTimeBegin`.
- `TimerUtils.addSecendTimer("TIME", 1, 99999, refreshView)` increments `_begin` every second and shows `int(_begin/60)` (:51-61).
- Zero padding is the `param9=2` default of `getNumberView` (`core_module/scripts/yishi/utils/NumberViewUtils.as:192-223`).

#### `RedScreenEffect` (red flash on taking a crit)

Source: `m10/scripts/battle/view/ui/RedScreenEffect.as`.

**Creator:** `BattleView.init`, always, `addChild`ed right after `_battleUI`, hence **above the HUD** (`BattleView.as:93-94`). `resize(sceneW, sceneH)` (`BattleView.as:116-119`).
- `_redBm = ComponentFactory.creat("asset.battle.RedScreenBMD")`: 64×62 bitmap stretched to scene size, alpha 0.5 (:21-29).
- `play()`: `addChild`, then a **200 ms** Timer removes it (:31-47).

**Trigger:** `RoleViewBase` calls `playRedScreen()` when damage is `havoc` (crit, `_loc8_=2`) and the target is `selfHero` (`core_module/scripts/battle/view/roles/RoleViewBase.as:1067-1068, :1126-1131`; `BattleView.as:317-320`).

#### `ResistUIView` (resistance/reduction % panel)

Source: `m10/scripts/battle/view/ui/ResistUIView.as`. Constructor `(side)`.

**Creator:** `BattleUIView.init` always creates two instances, side 1 and side 2, both starting `visible=false` (`BattleUIView.as:1359-1364`, add :1419-1420).
- x: side 1 at 280, side 2 at sceneWidth - 280 (`BattleUIView.as:771-772`).
- y by battleType:

| battleType | y side 1 | y side 2 | source |
|---|---|---|---|
| default (none below) | 265 | 215 | `BattleUIView.as:1396-1399` |
| 310, 3852 | 265 | 215 | `BattleUIView.as:1367-1371` |
| 295 | 250 | 250 | `BattleUIView.as:1384-1387` |
| 311, 312, 313, 3855, 349, 3867, 3889 | 185 | 185 | `BattleUIView.as:1363-1364` |

**Elements (:65-82):**
- `_resistMc = CreatInstance("asset.battle.DamageUIAsset")`, same asset as `BatterUIView`. Anchors: `total_num_pos`, `sign_pos`, `percent_pos`, `damage_pos`.
- `_signMc`: `"battle.ResistUIView.sign"` (ScaleFrameImage; frame 1 `asset.battle.addRedLow`, frame 2 `asset.battle.minusRedLow`).
- `_percentMc`: `"battle.ResistUIView.percent"` (frame 1 `percentRedLow`, frame 2 `percentGreenLow`).
- `_damageMc`: `"battle.ResistUIView.damage"` (frame 1 `damageRedLow`, frame 2 `damageGreenLow`, 94×40).
- Digit fonts: `asset.battle.numberRedLow` and `numberGreenLow` (420×42).

**`SET_RESIST_TOTAL_DAMAGE {value, side}`** (:84-118), filtered by `side`:
- `value > 0`: frame 2 ("minus" sign with green digits, % and "damage").
- `value < 0`: frame 1 ("add" in red) with `abs(value)`.
- `value == 0`: `hide()`.
- Digits via `getNumberView(..., 42, 42, 35, 42, "0123456789.", 1)`: glyph 42×42, advance 35, no zero padding.
- `_percentMc.x = _damageNum.width - 18`.

**Visibility:** `SET_RESIST_VISIBLE {value:true, side}` sets `visible` and calls `show()`. Ignored for battleTypes **311, 312, 313** (`BattleUIView.as:705-717`). Sources: `core_module/scripts/yishi/datas/battle/ResistModel.as:48-74` and `core_module/scripts/yishi/actions/map/ResistDelayAction.as:28-43` (15-tick delay).
- `show()` (:120-137): 0.7 s `TweenLite.from` with alpha 0 and x "-100", auto `hide()` after **60 frames**.
- `hide()` (:139-147): 0.4 s to alpha 0 and x = dest - 96.

#### `RoleShowViewII` (right boss bar and reinforcement waves)

Source: `m10/scripts/battle/view/ui/RoleShowViewII.as`.

**Creator** (`BattleUIView.as:1365-1400`, add :1402-1405): battleType **295**, or the switch `default`. The `default` excludes **310, 3852, 311, 312, 313, 3855, 349, 3867, 3889**. `showTopView` and `hideTopView` control visibility.

**`init` (:59-67):**
- `_rightIsBoss = isBoss(armyInfoRight.getHeros)`: some hero with `type == 3`. The chosen boss is the one with highest `grades` (:180-198).
- If boss (:69-83): creates `BossInfoView` with `setInfo`, `setTotalHp(getBossesTotalHp)` and `setCurrentHp`. Also creates `BossBufferContainer(boss)` at (1080,25).
- If `reinforceWave > 0`, calls `setReinforceWaveInfo(total, current+1)`.

**Reinforcement panel (:85-131):**
- `ReinforceWavePane` and `GameHallAutoView` are only `addChild`ed if `PlayerManager.newbieProcess >= 19000` (:90-94).
- Margins:

| case | top | right |
|---|---|---|
| battleType 3886 | 160 | 30 |
| with boss | 75 | 120 |
| without boss | 30 | 53 |

**Layout with `s = sceneWidth/1500`** (:303-371):
- `BossInfoView`: `scale = s`, x = sceneWidth - `bossView.width`·s + 25.
- `bossBufferContainer`: x = sceneWidth - 210·s - 40, y = 5 if s < 1, else 25.
- `nameTxt` and `nameInfoTxt` counter-scaled by 1/s and re-centered.
- Reinforcement in 3886: x = `bossView.x` - (`reinforceWave` - `currentReinforceWave` - 1)·98·s + 430·s, y = 40. `GameHallAuto` centered below it at y=135.
- Reinforcement with boss: x = sceneWidth - right·s - 200, y = top·s + 40.
- Reinforcement without boss: x = sceneWidth - right·s, y = top·s + 40.
- `ChatTopBugleView.setPos((globalX+170)·s, (globalY+90)·s, true)`.

**Listened opcodes (:219-227):**
- **4174, 4462, 4727, 360, 4889, 4285, 4297**: `WorldBossInfoMsg` (world boss HP sync). On `bossState` transition 0 → 1, resets total HP (:264-286).
- **4435**: `BossHpMsg`, applied if `livingId` == boss (:252-262).
- **4985**: `SyncRoomBossHPMsg`, applied only in battleType **3846** (:230-250).
- Also listens to `battleModel` `reduceWorldBossBlood` (:218).

**`enterFrame` (:382-408):**
- Updates boss HP.
- If `leftHp ≤ 0`, sets `isOver=true` and `FORCE_SKILL_ENABLE(false)`, and advances `showNextWave` once per wave.

**`bossReinforce(arr)`** (:141-178): sums `totalBloodA`, picks the highest-`grades` boss and creates the view if missing.

#### `RoleShowViewIII` (two bosses)

Source: `m10/scripts/battle/view/ui/RoleShowViewIII.as`.

**Creator:** battleType **310 and 3852** (`BattleUIView.as:1367-1372`).

**Boss selection (:73-90):** the first `type == 3` hero found becomes `_boss2`, the second `_boss1`. `needExchange` = `boss1.pos > boss2.pos` and swaps the order (:178-181).

**Elements (:45-71):**
- `DoubleBossInfoView` with `setInfo(a,b)`, `setTotalHp` and `setCurrentHp` by `ByInfo`.
- Two `BossBufferContainer(boss, 1)`: first at (788,61), second at (788,-8).

**Layout with `s = sceneWidth/1500`** (:122-153):
- `bossView`: `scale = s`, x = sceneWidth - width·s.
- Buffers: x = sceneWidth - 520·s for both; y1 = 75·s - 70; y2 = 160·s - 70.
- `nameTxt1` and `nameTxt2` counter-scaled.
- `ChatTopBugleView` as in RoleShowViewII.

**`enterFrame`:** updates both HPs and sets `isOver` when `leftHp ≤ 0` (:155-176).

#### `SpTip` *(only used by `PowerUIView`, which is dead)*

Source: `m10/scripts/battle/view/ui/SpTip.as`.
- `_container` at (20,19).
- `_bg`: `"core.commonTipBg"` (ScaleBitmapImage `describeBackground_style07`, alpha 0.8). Computed width, height 25.
- `_titleBm`: `creatBitmap("asset.battle.PowerUISpTipTitle")` at (3,2).
- Current SP with `number_img_01` (13×17, advance 14), then `creatBitmap("asset.battle.PowerUISpTipDivision")`, then "100" (:32-51, :70-96).

#### `TrailCountView` (current floor/layer)

Source: `m10/scripts/battle/view/ui/TrailCountView.as`. `width` fixed at 123 (:66-69).

**Creator:** `BattleUIView.init` when:
- `isTrail()` (**25**) or `isSpaceTimeBattle` (**3870**) (`BattleUIView.as:1334-1338`);
- `isRaceAgainstTime` (**3894**) (`BattleUIView.as:1339-1342`);
- `isWarSoulTower` (**3905**) (`BattleUIView.as:1351-1355`);
- battleType **295**, which first sets `trialLayer = BattleManager.molongLayer` (`BattleUIView.as:1474-1480`).

Position: x = sceneWidth - 123, y = 175 (`BattleUIView.as:1102-1106`).

**Elements:**
- `_back`: `creatBitmap("asset.battle.TrailLayerBack")` (123×40) at y=10 (:30-32).
- `_countDownValue`: y=21; x = 27 + (36 - width)/2 (:33-36, :62).
- Digits from `asset.core.number_img_09` (glyph 15×19, advance 15, no zero padding) show `trialLayer` (:57-64).

**Event:** `TRAIL_LAYER_CHANGE` (:41).

#### `BattleLoadingView` (core_module)

Source: `core_module/scripts/battle/view/ui/BattleLoadingView.as`.

**Creator:** `EnterBattleController.startHandler` (`core_module/scripts/battle/control/EnterBattleController.as:98-108`).
- Called directly in `handler`, or after `LoadingSceneView` `close` or `SWITCH_SCENE` (`EnterBattleController.as:60-96`).
- Goes to `LayerManager.addToLayer(view, 2, true)` (`EnterBattleController.as:151-157`). Third parameter likely centers *(assumption)*.

**Loading MC (:27-48), always 100 frames:**
- `ComponentSetting.isZhanQu`: `creatCustomObject("core.loading.LoadingMapAsset.zhanqu")`, with `bg1` and `bg2` at `gotoAndStop(2)`.
- `is7road`: same zhanqu asset, bg at frame 1.
- Else: `"core.loading.LoadingMapAsset.shenqu"`, bg at frame 1.

**Behavior:**
- `startShowLoad(cb)` registers an `enterFrame` (:50-54). Each frame: `gotoAndStop(resourceModel.progress())`.
- When `BattleModel.battleUILoaded`, goes to frame 99 and calls `cb()` (:56-75).
- `cb` is `preCreateRipple`: sends `BATTLE_READ_GO`, pre-creates ripples (100 ms per item), then shows the switch `asset.core.EnterBattleSwitchMC` and removes the loading view (`EnterBattleController.as:136-207`).
- The `pkg` setter reads an int as `currntBattleId` (:82-85).

### 9.2 Map: `BattleCameraScene`, `BattleMap`, `BattleMapView` and `RepeatBackGroundLayer`

#### `BattleView` hierarchy

Bottom to top (`m10/scripts/battle/view/BattleView.as:76-100`, detailed in §1.2): `_bitmap_background` (blurred snapshot for the "gas" effect), `_map` (`BattleMapView`), `_profoundLayer`, `_battleUI` (`BattleUIView`), `_redScreenEffect`, then `_chatPop` and `_goddessMovieView` (added later).

Init: `scrollRect` = (0, 0, sceneW, sceneH) (`BattleView.as:106`), `CAMERA_Y = 900 - sceneH·0.5` (:109), `cameraX = 650` (:91).

#### `BattleCameraScene`

Source: `m10/scripts/battle/view/map/BattleCameraScene.as`.

- Defaults: `cameraX` 500, `cameraY` 300, `zoom` 1, scene 1000×600 (:13-27).
- Draws lazily on `Event.RENDER` via `DelayRendSprite` (`core_module/scripts/yishi/view/component/DelayRendSprite.as:19-75`).
- `onDraw` (:108-123):
  - `center = (sceneW/2, sceneH)`.
  - `layer.x = -(cameraX - center.x)·moveCoefficient` per layer.
  - `scale = zoom`.
  - `y = -(cameraY·zoom - sceneH·0.5)`.
  - `x = sceneW/2 - 750`.
  - At zoom 1 this gives `y = sceneH - 900`: the world is drawn at 1500×900, anchored bottom-center.
- `addLayer(obj, coef=0)` uses coefficient **0 by default** (:41-44).

#### `BattleMap`

Source: `m10/scripts/battle/view/map/BattleMap.as`.

- Layer order: `_roleBackContainer`, `_profoundContainer`, `_rolesContainer`, `_effectContainer`, all coef 0 (:58-67), so they do not move with `cameraX`.
- `AnimationManager(this, 1000, 600)` (:70).
- `update()` follows the camera target at most **20 px per frame** (:234-255).
- `setCamera` uses `TweenMax`, 0.5 s by default (:276-285).
- `shakeScreen(c, d)` uses `Shaker`: amplitude alternates sign with 0.95 decay over `c·4` frames, moving `cameraX` and `cameraY` (`m10/scripts/yishi/utils/Shaker.as:34-68`).
- `backGroundToColor` tweens a `colorTransform` offset in, hold, out. Affects background layers only, excluding effect, roles and profound (:73-125).
- `backGroundToColor2` applies a brightness matrix for `param2` ms (:177-207).
- `addEffect` is ignored if `!SharedManager.allowAttactedEffect` (:326-340).

#### `BattleMapView`

Source: `m10/scripts/battle/view/map/BattleMapView.as`.

- `changeMap(data)` (:325-386):
  - `bg_back` layers added with `addLayerAt(i, coef)`, below the character containers.
  - `bg_front` layers added with `addLayer(coef)`, above `_effectContainer`.
  - `_gasEffectContainer` added last.
- Data from `BattleMapData`: each child of MC `resourceModel.battleMap` carries `moveCoefficient` (default 1), `repeat` (default true), `moveSpeed` (default 0), `transparent` (default true) and `isFront` (`core_module/scripts/battle/data/BattleMapData.as:25-54`).
- `repeat=false` layers exist only if `SharedManager.allowSceneEffect`, toggled by notification `sceneEffectClose` (:65-75, :388-412).
- `update()` (:126-150) handles IME, depth-sorts by `pointY` (`BattleUtils.ManagerDepth`) and updates shadows and RoleInfos.

#### battleType conditions in `BattleMapView`

- `REVIVE_BATTLE_TYPE = [310, 311]` (:40). In these types, boss death (`type 3`) runs `action("Die")`, hides the bar and removes the parent, but keeps the view in the dictionary (:182-192).
- Hero death outside types 3, 7 and 8: only hides the HP bar. Others (non-pet) are removed (:183-197).
- **Opcode 4680** `LivingCleanMsg`, only in battleTypes **295, 3854, 3911** (:200-290):
  - Own player outside 3911: `selfDie` and `onFightCanceled` after 1500 ms.
  - Otherwise: removes hero, pet and child and calls `battleUIView.removeDieRole`, also after 1500 ms.

#### `RepeatBackGroundLayer`

Source: `m10/scripts/battle/view/map/RepeatBackGroundLayer.as`.

- `x` setter is overridden: stores the value in `_x` and only redraws the texture padding (:76-103). The DisplayObject never moves.
- `moveSpeed != 0` registers `enterFrame` and, **1750 ms** later, swaps the asset for `BitmapData(1500, asset.height)` (:110-138). Fill repeats with `tx = (x + xOffset) % 1500`, `xOffset += moveSpeed` per frame (:150-158).
- `moveSpeed == 0` layers never create the bitmap, so they are **static** and ignore the camera (:91-96).

### 9.3 battleType conditions (consolidated)

| value | effect | file:line |
|---|---|---|
| 10, 11, 3891 | GoddessTop own and enemy | `core_module/scripts/battle/utils/BattleFunctionHelper.as:290-294` |
| 13, 25, 3848, 3852, 3853, 3854, 3870, 3872, 3877, 3878, 3894 | GoddessTop own only | `BattleFunctionHelper.as:295-307` |
| 1-7, 9, 12, 16-19, 23, 32, 35, 293, 330, 3843, 3844, 3845, 3847, 3850, 3851, 3855, 3857-3860, 3862-3865, 3867-3869, 3871, 3873-3876, 3879, 3880, 3885, 3887, 3889, 3890, 3897 | no GoddessTop | `BattleFunctionHelper.as:308-357` |
| 3847, 3845, 3844, 35, 3867, 3889, 3895, 3868, 3898, 3907 | `isNoHeroBattleType`: no titan panel | `m10/scripts/battle/view/ui/BattleUIView.as:1527-1530` |
| 3870 | no enemy titan panel in the reinforcement handler; `isSpaceTimeBattle` creates BattleSpaceTimeView and TrailCountView | `BattleUIView.as:494, :1187-1191, :1334, :1993` |
| 3842, 3854 | Titan `isSingleBattle` = false | `m10/scripts/battle/view/ui/DragonTitanTeamView.as:175-179` |
| 18, 25, 3870, 13, 10, 290, 295, 310, 291, 3841, 3842, 314, 305, 3852, 3853, 3877, 3878, 3891, 3894 | Titan not single (if `battleCapity != 1`) | `DragonTitanTeamView.as:187-206` |
| 306, 307, 293, 3871, 3893 | Titan single | `DragonTitanTeamView.as:207-212` |
| `isPvP`: false for 291, 39, 3844, 3847, 3867, 3868, 3870, 3872, 3873, 3875, 3845, 3889; true for 35, 349, 3907 | creates HurtUpView | `core_module/scripts/yishi/datas/BattleModel.as:947-1023`; `BattleUIView.as:1329-1333` |
| 35, 307 | text `battle.hurtUpTip.text2` | `m10/scripts/battle/view/ui/HurtUpView.as:208` |
| 3911 | HurtUpView in "Child Nswar" mode (icons and buff); dead cleanup via opcode 4680 without leaving | `HurtUpView.as:134`; `m10/scripts/battle/view/map/BattleMapView.as:215, :232` |
| 3847 | `HurtUpMode.resetChildArena` | `core_module/scripts/yishi/datas/BattleModel.as:928` |
| 25 | `isTrail` creates TrailCountView | `BattleModel.as:1030-1033`; `BattleUIView.as:1334` |
| 3894 | TrailCountView and RaceAgainstTimeUpView | `BattleModel.as:1070-1073`; `BattleUIView.as:1339-1345` |
| 3903 | ForbiddenBossUIView (out of scope) | `BattleModel.as:1075-1078`; `BattleUIView.as:1346-1350` |
| 3905 | TrailCountView; `_warsoulEndBtn` | `BattleModel.as:1080-1083`; `BattleUIView.as:1268-1271, :1351-1355` |
| 295 | RoleShowViewII; Resist y=250/250; TrailCountView with `trialLayer = molongLayer`; opcode 4680; hides auto-fight | `BattleUIView.as:1384-1387, :1474-1480, :1121-1124`; `BattleMapView.as:215` |
| 310, 3852 | RoleShowViewIII; Resist y=265/215 | `BattleUIView.as:1367-1371` |
| 310, 311 | boss revive (view not removed) | `BattleMapView.as:40, :187-192` |
| 311, 312, 313 | MutilBossShowView; ResistUIView never shows | `BattleUIView.as:1373-1383, :707-710` |
| 3855 | OutyardShowView (no RoleShowViewII) | `BattleUIView.as:1389-1391` |
| 349, 3867, 3889 | no right top view | `BattleUIView.as:1392-1395` |
| others | RoleShowViewII; Resist y=265/215 | `BattleUIView.as:1396-1399` |
| 3886 | special ReinforceWavePane layout (top 160, right 30, per-wave formula); auto-fight +80 in y | `m10/scripts/battle/view/ui/RoleShowViewII.as:106-110, :353-360`; `BattleUIView.as:1152-1155` |
| 3846 | opcode 4985 updates boss HP | `RoleShowViewII.as:244` |
| 3854, 295, 3911 | opcode 4680 `LivingCleanMsg` | `BattleMapView.as:215` |
| `mapId` 9998 | normal Space-Time config (else Nightmare) | `m10/scripts/battle/view/ui/BattleSpaceTimeView.as:176-177` |

Conditions not tied to battleType:
- Reinforcement visible only with `newbieProcess ≥ 19000` (`RoleShowViewII.as:90`).
- Titans at init require `ConfigManager.version_info.TAITAN_LOCK` (`BattleUIView.as:1199`).
- `GoddessMovie` and `GoddessTop` require `VersionSwitch.GODDESS_OPEN` (`BattleView.as:359`; `BattleFunctionHelper.as:283`).
- `side`: `enemySide = 3 - selfSide` (`BattleUIView.as:1494-1502`).

### 9.4 Findings

1. **Dead code.** `AttackModeView`, `PowerUIView`, `SpTip` and `AttackModeChangeEffect` have no `new` in m10 or core_module. Assets `asset.battle.AttackBtnAsset`, `AttackModeCDAsset`, `AttackModeAttackEffect`, `PowerStripAsset`, `PowerUIFrontView` and `PowerUISpTipTitle` are missing from `index/ui_symbols.json`. Only `AttackModeBtnTip` is forced to compile (`core_module/scripts/yishi/lunch/ComponentEmbed.as:90`). For HTML5, the attack/defense modes (opcode 10016) and this module's SP bar can be skipped.
2. **Default coefficient 0 on character layers.** Characters and effects do not move with `cameraX`; only background layers do (`BattleCameraScene.as:41-44`; `BattleMap.as:64-67`). Background layers with `moveSpeed=0` are also static, because `RepeatBackGroundLayer` only applies `x` after creating the bitmap (`RepeatBackGroundLayer.as:91-96, :110-121`).
3. **Duplicated GoddessTopView.** `__refreshViewHandler` (each `BATTLE_REINFORCE_HANDLER`) recreates `_selfGoddessTopView` and `_vsGoddessTopView` without checking existence, stacking instances and leaking old ones (`BattleUIView.as:514-528`).
4. **Titan inconsistency.** `init` requires `TAITAN_LOCK` and creates the enemy panel even in 3870 (`BattleUIView.as:1199-1205`). The reinforcement handler skips `TAITAN_LOCK` but excludes 3870 (:483-500). `layout()` repositions the panel to x=0 or sw-120 even when "collapsed" (:1078-1087), desyncing `_isHide`.
5. **Stacked numbers.** `BatterUIView` adds a new `TotalDamageNumberAssetSp` on every update and never removes the previous one; old numbers remain underneath (`BatterUIView.as:56-59, :69-72`). `hide()` only zeroes alpha; `visible` stays `true` (:125-137).
6. **HurtUpMode creation order.** If `getHurtMode()` runs before `hurtUpStart`, the mode is born with `battleType=0` (`BattleModel.as:938-945`) and the 35/307 text never appears. Normally `CreateGameTransaction.as:116` calls first *(assumption about the order)*. Also, the damage tip never becomes invisible again once shown (`HurtUpView.as:204-216`).
7. **Goddess icon reloaded needlessly.** `BattleGoddessTopItem` compares `template.Type` with `_preType` but stores `templateId` in `_preType`, so the icon reloads on every belief change (`BattleGoddessTopItem.as:105-109`).
8. **Scale applied twice.** In `RoleShowViewII` and `RoleShowViewIII`, `bossView.width` already includes `scale` and is multiplied by `s` again in the x formula (`RoleShowViewII.as:312-313`; `RoleShowViewIII.as:128-129`). In 3886 without a boss, `reinforceLayout` accesses null `_bossView.x` (`RoleShowViewII.as:356`).
9. **Inverted resistance signs.** `value > 0` shows frame 2 (`minusRedLow` sign with green digits); `value < 0` shows "add" in red (`ResistUIView.as:94-116` and styles `battle.ResistUIView.*`). Asset names are misleading.
10. **Stale Space-Time count.** `BattleSpaceTimeBox.initConfig` returns early if `boxType` is unchanged and does not update the count text on layer change (`BattleSpaceTimeBox.as:39-42`). Boxes enter the HBox in reverse config order (`BattleSpaceTimeView.as:140-146`).
11. **Minor timer bugs.** `RaceAgainstTimeUpView` increments `_begin` on the first render (off-by-one) and uses the global `TimerUtils` key "TIME" (`RaceAgainstTimeUpView.as:52-58`). `PowerUIView.dispose` calls `_spIncreaseAnimation.dispose()` without a null check (`PowerUIView.as:154`).
12. **Unclamped goddess y.** `BattleGoddessMovieView` uses raw `StageReferance.stageHeight`, without the 600..900 clamp (`BattleGoddessMovieView.as:49, :51`). x positions derive from the fixed 9-position grid: x=185 left, x=765 right.
13. **Cooldowns in frames.** `delayCall` counts frames: 25 for combo hide, 60 for resistance auto-hide. Real timing depends on stage fps. UI SWFs declare 24 fps; main stage fps not confirmed *(assumption: 24)*.
14. **Assets without style.** `asset.battle.spaceTimeBoxBK` (187×41) and `asset.battle.nswarIconBg` (55×62) are not in `styles.json` but exist in `battle.swf`. They sit at 0,0 with no style offset.

---

## 10. Result screen (end of battle)

**Path abbreviations** (all relative to `decompiled/`):
- `BattleResultHandler.as` = `core_module/scripts/battle/handler/BattleResultHandler.as`
- "Base" = `core_module/scripts/battle/view/battleresult/BaseBattleResultView.as`
- result views: `core_module/scripts/battle/view/battleresult/`

Timeline data marked [lib] comes from the helper export `web/public/lib/battle2/library.json` (not AS3; visual reference only).

### 10.0 Summary

- The result screen has **no buttons, rewards or LanguageMgr texts**: it is a centered animated MovieClip (victory/defeat); at most it shows a number counting from 0 to the value (EXP) or a percentage.
- Closes by itself 1 s after the animation's last frame, or on **any stage click** (capture phase). On close → `exitBattle`, which picks the destination scene by battleType.
- Default: **Simple** variants (`asset.battle.VictoryAssetII2` / `asset.battle.FailedAssetII2`). Detailed (`VictoryAsset2`/`FailedAsset2`) only in battleType **16 and 10**; Outyard (`VictoryAsset3`/`FailedAsset3`) only in **3855**.
- `SinglePassVicotyResultView` is the only one with items/grid/button, but the handler does not open it and the path that would is dead (§10.8).

### 10.1 Entry: opcode 4103 (`U_BATTLE_REPORT`)

| Listener | File:line | Effect |
|---|---|---|
| `BaseManager.__battleInfoResultHandler` | `core_module/scripts/yishi/manager/BaseManager.as:291` (registration), :2785-2795 | creates a **new** `BattleResultHandler` per packet and calls `handler(pkg)` (:2787-2788); then buffers the packet for scene `BattleManager.preScene` (or `SwitchPageHelp.returnScene`) with callback `showAddBloodFrameBack` (:2789-2794) |
| `BaseManager.showAddBloodFrameBack` | `BaseManager.as:2797-2807` | after the scene switch; if `battleScene` ∈ {2,8,11,19,22} does nothing (:2801-2805); else queues `AlertTipAction(battleResult, showAlertTip)` (:2806) |
| `BaseManager.showAlertTip` | `BaseManager.as:2858-2901` | defeat only (`int(param1) != 2` → return, :2861-2864): progression tip (`showTipViewByType` 48/6/4/5/49/8/9/50) by level/condition (:2865-2900); title `yishi.manager.BaseManager.tip.title` (:2908) |
| `CampaignSocketManger.__battleInfoResultHandler` | `m3/scripts/map/campaign/CampaignSocketManger.as:367, :979-1042` | with non-empty `baseItem` and `mapModel`: creates a temporary chest node on the map (`ChestInfo.types=92`, `sonType=2201`), name `battle.handler.BattleResultHandler.name` = "Baú" (:1022), at `posX/posY` (:1010-1039) |
| `CampaignSocketDataProxy.__onDataHandler` | `core_module/scripts/proxy/scene/CampaignSocketDataProxy.as:53` | generic campaign packet buffer |
| `SocketSceneBufferManager` | `core_module/scripts/yishi/manager/SocketSceneBufferManager.as:103-117` | buffer run on the key scene's `SWITCH_SCENE` (:43-62) or when `leftTime` expires (default 90000 ms, :103, :75-79) |

`BattleReportMsg` (`core_module/scripts/com/road/yishi/proto/battle/BattleReportMsg.as`; tags of `switch((tag>>>3)-1)` at :397-498):

| Tag | Field | Line | Use |
|---|---|---|---|
| 1 | battle_result (1 victory, 2 defeat) | :405 | `combat` (`BattleResultHandler.as:802`) selects victory/defeat |
| 2 | strategy_bonus | :413 | SinglePass only (`curDamge`) |
| 3 | gp_bonus | :421 | `data[0]` = EXP in detailed views |
| 4 | pos_x | :429 | `_pos` (unused); SinglePass `curBeDamge` |
| 5 | pos_y | :437 | `_pos` (unused); SinglePass `scoreB` |
| 6 | sign_id | :445 | `_signId` (unused) |
| 7 | baseItem[] (BaseItemMsg templateId/count; `BaseItemMsg.as:98,106`) | :449 | `goods` built and **never used** by the handler |
| 8 | battle_scene | :458 | `showAddBloodFrameBack` filter; SinglePass rank |
| 9 | fail_count | :466 | too-many-defeats alert (> 4) |
| 10 | gold_bonus | :474 | SinglePass `scoreA` |
| 11 | pet_gp_bonus | :482 | `data[1]` (≥0), **never shown** |
| 12 | param1 | :490 | `data[2]` = Outyard victory EXP |
| 13 | param2 | :498 | `data[3]` = Outyard defeat % |

`readPkg` (`BattleResultHandler.as:796-825`): `_resultViewData = [gpBonus, max(petGpBonus,0), param1, param2]` (:801-807); `goods` (:808-819), `_signId`/`_pos` (:820-824) unused afterwards.

### 10.2 `BattleResultHandler` flow

`handler(pkg)` (:575-620):
1. `BattleManager.selfDie` → return (:578-581). The end then comes via `onFightCanceled` after 1500 ms (`m10/scripts/battle/view/map/BattleMapView.as:234-241`, only 295/3854).
2. Dedupe by `battleId == BaseManager.preBattleId` (:582-589); `isExitingBattle = true` (:590); `loginState < 0` → return (:591-594).
3. `battleType == 6 || battleCapity == 4` and `batterModel.maxBatterCount > 2` → **8282** `BatterLastInfoMsg.count` (:595-608; `core_module/scripts/yishi/service/managers/SocketSendManager.as:110-116`). Only opcode sent at the end.
4. `readPkg()` (:609-612); no `battleModel` → silent return (:613-617); `checkExecuteAbled()` (:619).

Wait (:622-633): if `_waitCount > 100` or `BattleManager.isAllSkillExecuted()` → `execute()`; else `setTimeout(30)` and `_waitCount++` → at most **101 reschedules ≈ 3.03 s**. `isAllSkillExecuted` = SkillSystem queue empty and `battleModel.isAllSkillExecuted()` (`core_module/scripts/battle/BattleManager.as:280-291`).

`execute()` (:635-680):
1. `winSide = selfHero.side`, inverted if `combat != 1` (:641-652).
2. `isAllDead()` → `playVictoryAction(winSide)` (:653-656; `core_module/scripts/yishi/datas/BattleModel.as:725-742`).
3. Animated defeat: 35 → `playDefeatedAction(loseSide)` (:661-664; `BattleModel.as:744-758`, action "Failed", hides bars); 307 or 313 → `monopolyPlayDefeatedAction` (:665-672; `BattleModel.as:687-723`).
4. `showNewVersionPane()` (:674); **then** `isOver = true` and `SKILL_ENABLE false` (:675-679).

### 10.3 View selection: `showNewVersionPane()` (:682-747)

First: `_preScent = BattleManager.preScene` (:685), `clearView()` (:686), `SoundManager.stopMusic()` (:687), `hasScene = BattleManager.battleScene != null` (:688; it is the `BattleView`, `m10/scripts/battle/view/BattleView.as:78`).

| Condition | Event | View | Lines |
|---|---|---|---|
| `combat==1 && hasScene`, battleType **3855** | sound `"033"` + `NotificationEvent("BATTLE_RESULT", true)` | `VicotyOutyardBattleResultView` | :689-698 |
| `combat==1 && hasScene`, `needDetailInfo()` (= 16 or 10, :749-759) | same | `VicotyBattleResultView` | :699-702 |
| `combat==1 && hasScene`, others | same | `VicotyBattleResultViewSimple` | :703-706 |
| `combat==2 && hasScene`, 3855 | `BATTLE_RESULT` false, **no sound** | `FailedOutyardBattleResultView` | :716-727 |
| `combat==2 && hasScene`, 16/10 | same | `FailedBattleResultView` | :728-731 |
| `combat==2 && hasScene`, others | same | `FailedBattleResultViewSimple` | :732-735 |
| no `battleScene` or result ∉ {1,2} | none | **none** → `exitDirect()` | :716-720 |
| exception in constructor (e.g. SWF `battle2` not loaded) | none | `exitDirect()` | :708-712, :737-741 |

With a view, the handler calls `setData(_resultViewData)`, sets `autoCloseFun = resultViewCloseFun` and calls `show()` (:743-746). It **does not check** `battle_from`, `useWay` or side beyond `selfHero.side`.

`BATTLE_RESULT` consumers:
- `m3/scripts/map/campaign/CampaignSocketManger.as:365, :1118-1124`: defeat sets `selfMemberData.angle = -1`.
- `m10/scripts/battle/view/ui/MutilBossShowView.as:73, :290-299`: victory sets the world boss to 0 HP.

Closing:
- `exitDirect()` (:761-765): `resultViewCloseFun()` + `BattleEvent("battleCancel")` (listened by `core_module/scripts/battle/control/EnterBattleController.as:63, :110-126`).
- `resultViewCloseFun()` (:767-782):
  1. scene = `_preScent` or `returnScene` (:769);
  2. `exitBattle(scene, combat, _battleMsg)` (:771);
  3. `clearView()` (:772);
  4. `exitFlag = true`, `loginToBattleFlag = false` (:773-774);
  5. if `!SharedManager.multiFailded && battleResult == 2 && failCount > 4` → `MultiFailedAlertAction` (:775-781). The action runs only outside `BATTLE_SCENE` (`core_module/scripts/yishi/actions/map/MultiFailedAlertAction.as:19-22`) and opens `battle.multiFailedAlertFrame` (TodayNotAlertFrame 320×228) with `Campaign.MultiFailedAlert` and checkbox `yishi.view.base.ThewAlertFrame.text` (:42-55).

### 10.4 `exitBattle(param1="default", param2=1, param3=null)` (:93-551)

1. `BloodHelper.setup()` (:102); `"default"` → `preScene` (:103-107).
2. Maze (`WorldBossHelper.checkInAnyMaze`) and `param3.battleResult == 2` → `MazeModel.isAuto = false` (:110-113). `param3` is null via `onFightCanceled` (`core_module/scripts/battle/BattleManager.as:118`) → possible error *(assumption: only with mapModel in a maze)*.
3. `plotHandler.inactive()` (:114); with `battleScene` listens to `SCENE_SWITCH_CALL` → `sceneSwitchCallHandler` (:553-558: `KeyBoardRegister.battleFlag = false`, `battleComplete`), else `exitBattleComplete()` immediately (:115-122, :560-563). `battleComplete` is consumed by `core_module/scripts/battle/transaction/CreateGameTransaction.as:62, :65-73` (next queued battle).
4. Early exits without a direct `setScene` and without the `lock=false` at :527:
   - 293 → `SkyboxRoadManager.getData()` (:127-131);
   - 3893 → `IncreasinglyRoadManager.getData()` (:132-136);
   - 3878: empty block (:137-139);
   - 3898 → `setScene("SPACE_SCENE")` or `DarkMazeManager.enterScene()`, depending on `passDarkMaze/isOver`, `isCanRefresh` and reset < 1 800 000 ms (:140-167).
5. `switch(battleType)` sets the destination (:168-329; table in §10.9). 16 → `CHANLLENGE_ROOM_SCENE` if `ChallengeManager.isLogin`, else `SPACE_SCENE`, and return (:332-343).
6. Campaign destination without `mapModel` → `returnScene` (:344-347). Destination `SPACE_SCENE` with `SpaceManager.exit` → return without setScene (:352-355).
7. If `currentType == "BATTLE_SCENE"`, builds reopen flags `isXxx` (:356-526), read by the next scene (e.g. `m3/scripts/map/space/SpaceSceneController.as:199, :239-300`).
8. `SceneManager.lock = false` (:527), then `setScene` without a loading screen (`core_module/scripts/yishi/scene/SceneManager.as:165-168`):
   - `OUTER_CITY_SCENE`: `MapInitData` with `targetPoint` = `MapData.movePos` or (`army.curPosX*20`, `curPosY*20`), `showMapName=false`, `isShowLoading=false`, `setScene(dest, data, false, true)` (:528-544);
   - other scenes: `setScene(dest, {isShowLoading:false, …flags}, false, true)` (:330-331, :548);
   - `setScene` sends **8747** enterCastle (`SceneManager.as:169-181`; `SocketSendManager.as:529-535`).
9. `disposeBattle()` is **not** called here: it comes from `BattleSceneView.leaving()` (`m10/scripts/battle/BattleSceneView.as:153, :177`) on scene switch (`SceneManager.as:309-327`). `param2` is unused.

### 10.5 `BaseBattleResultView`

| Item | Detail | Line |
|---|---|---|
| Class | `extends Sprite`; `mc`, `data`, `_autoCloseTimer`, `_disposed`, `autoCloseFun`, `_hasCallback` | :13-26 |
| Constructor | `Helpers.addOneTimeScript(mc, mc.totalFrames-1, updateStart)`; `addChild(mc)` (only child) | :28-37 (Helpers: `core_module/scripts/battle/utils/Helpers.as:207-218`, replaces the last frame's `stop`) |
| `show()` | `LayerManager.getLayerByType(3).addChildAt(this, 0)` → `center()` → `addEvent()` | :44-49 |
| Layer | 3 = `_gameDynamicLayer`, above the scene (layer 6); index 0 = bottom of the layer; **no blocking background, no fade** | `core_module/scripts/com/pickgliss/ui/LayerManager.as:118-124, :174-181` |
| Centering | `x = (stage.stageWidth - width)·0.5`, `y = (stage.stageHeight - height)·0.5` (raw stage) | :68-72 |
| Click | `stage.addEventListener("click", h, true)` (capture): removes listener, `stopPropagation()`, `dispose()` | :51-66 |
| Last frame | `updateStart()` → `gotoAndStop(totalFrames)` + `startTimer()` | :74-81 |
| Auto-close | `Timer(1000,1)` → `tryCallback()` (once) | :83-105 |
| `dispose()` | removes listener, stops timer, leaves parent, clears mc, `tryCallback()` | :112-133 |

Click and timeout both end in `resultViewCloseFun`. Stage at 25 fps (`Loading/scripts/Loading.as:40`); SWF `battle2` declares 24 fps [lib] *(assumption: nothing changes fps during battle)*.

### 10.6 Victory views

| View | Asset (`ComponentFactory.creat`) | Logical height (width=0) | Data | Total time |
|---|---|---|---|---|
| `VicotyBattleResultViewSimple` (default) | `asset.battle.VictoryAssetII2` (`VicotyBattleResultViewSimple.as:11`) | 360 (:15-23) → origin at (stageW/2, (stageH-360)/2) | none | 50 frames [lib] ≈1.96 s + 1 s ≈ **2.96 s** |
| `VicotyBattleResultView` (16, 10) | `asset.battle.VictoryAsset2` (`VicotyBattleResultView.as:20`) | 350 (:86-94) | `data[0]` gp_bonus | 25 frames ≈0.96 + 1 ≈ **1.96 s** |
| `VicotyOutyardBattleResultView` (3855) | `asset.battle.VictoryAsset3` (`VicotyOutyardBattleResultView.as:16`) | 350 (:54-62) | `data[2]` param1 | 24 frames ≈0.92 + 1 ≈ **1.92 s** |

- Names are not styles: `creat` falls into `ClassUtils.CreatInstance` (`core_module/scripts/com/pickgliss/ui/ComponentFactory.as:66-86`); symbols live in SWF `battle2`.
- `VicotyBattleResultView`: `mc.addFrameScript(23, playIcon)` (:22); `playIcon` = `TweenMax.to(mc.icon, 0.4, {alpha:1, x:-128})` (:25-35); `updateStart` forces the tween to its end and runs `TweenMax.to(this, 0.5, {experience: data[0]})` (:55-71, :37-44); `onUpdate` writes `mc.experienceTxt.text = int(experience)` (:73-79). [lib]: `icon` from (-285.95, 87) alpha 0 to (-128, 85); `experienceTxt` at (3.05, 80), 102×28.5, font 22, #FFEFBF; `petExpText` (130.05, 80) **never filled**.
- `VicotyOutyardBattleResultView`: `experience` tween to `data[2]` in 0.5 s (:20-43); [lib] `experienceTxt` at (148.05, 82).
- Simple [lib]: rays c45 (-175.45, -63.85), c50 (-133.35, -27.45), c54 (-19.85, -33.9) scale 0.85→1.5 with fade-in; title c57 (221×76) at f15.

### 10.7 Defeat views

| View | Asset | Height | Data | Time |
|---|---|---|---|---|
| `FailedBattleResultViewSimple` (default) | `asset.battle.FailedAssetII2` (`FailedBattleResultViewSimple.as:11`) | 360 (:15-23) | none | 20 frames ≈ **1.76 s** |
| `FailedBattleResultView` (16, 10) | `asset.battle.FailedAsset2` (`FailedBattleResultView.as:21`) | 350 (:87-95) | `data[0]` | ≈1.96 s |
| `FailedOutyardBattleResultView` (3855) | `asset.battle.FailedAsset3` (`FailedOutyardBattleResultView.as:14`) | 350 (:29-37) | `data[3]` (%) | 25 frames ≈ **1.96 s** |

- `FailedBattleResultView`: `addFrameScript(18, playIcon)` (:23); `TweenMax.to(mc.icon, 0.4, {alpha:1, x:-120})` (:44-54); EXP 0→`data[0]` in 0.5 s (:26-42, :56-80). `_petIcon`, `playerInfo` unused (:15, :82-85).
- `FailedOutyardBattleResultView`: `addFrameScript(14, playIcon)` (:16): `mc.txtMc.experienceTxt.text = data[3] + "%"` and `mc.experienceMc.gotoAndStop(100 - data[3])` (:19-27); no tween. [lib] `experienceMc` is a 120-frame masked bar at (-57.45, 76.05).
- Defeat plays no sound (`BattleResultHandler.as:691` vs :721).

### 10.8 Spectator and `SinglePassVicotyResultView`

**Spectator** (`core_module/scripts/managers/BattleViewManager.as`):
- Opcode **4803** (:96-99) → `onCloseBattleViewHandler` (:135-179): `closeType = param1` (:145), `isNomalExit = param7` (:147); same 30 ms wait as the handler (:150-162).
- `exitBattleScene` (:181-238), always with the Simple views and without `setData`:
  - `closeType` 1 → sound 033 + `VicotyBattleResultViewSimple`;
  - `closeType` 2 → `FailedBattleResultViewSimple`;
  - any other value → exits directly (:215-226).
- `toExitScene` (:187-208) fires `battleCancel`, calls `setScene(_curSceneType, null, false, true)` (with loading) and may resend **8985** (:240-264).

`SinglePassVicotyResultView` (opened only by `m3/scripts/map/space/SpaceSceneController.as:300-305` when `isOpenSinglePassResultView`, which **no code sets**):
- `show()` (:214-223): loads module `clearance`; `LayerManager.addToLayer(view, 2, true, true, 1, 0, true)` (layer 2, black background); `x = (stageW-800)/2`, `y = (stageH-385)/2`; no auto-close.
- Background `asset.singlePass.BattleResultBg` (:70-71); numbers with `asset.campaign.Number1/2/3` via `NumberViewUtils.refreshValue` (:67-83; `core_module/scripts/yishi/utils/NumberViewUtils.as:158-190`): `curDamge`=strategyBonus, `curBeDamge`=posX, `standDamge`=param1, `standBeDamge`=param2, `scoreA.gotoAndStop(goldBonus)`, `scoreB.gotoAndStop(posY)`, `exp`=gpBonus, `petExp`=petGpBonus.
- Rank by `battleScene` 1..7 → D, C, B, A, S, SS, SSS (`asset.campaign.ProfileMC`+suffix; :84-109).
- Items: `HBox` `battle.ResultHBox` (x 268, y 300, spacing 20) (:110); aggregates `baseItem` by templateId (ignores -700), sorts by `Profile` desc and `count` asc (:111-135, :181-200); cell = `battle.ResultItem` + `asset.singlePass.Star` at (65,23) + quantity at (78,19) (:136-157).
- Pet: `battle.PetIcon2` with `IconFactory.getPetHeadSmallIcon` (:158-171).
- Button `core.CloseBtn` at (796, 6), sound "008", closes and reopens frame `singlepass` (:49-53, :174-178, :225-244).

### 10.9 battleType conditions (result and exit)

| battleType | Effect | Line (`BattleResultHandler.as`) |
|---|---|---|
| 6 (or battleCapity 4) | 8282 if maxBatterCount > 2 | :597-606 |
| 35 | `playDefeatedAction`; destination `returnScene`; flag `isOpenPetChallenge` | :661-664, :180-182, :362-365 |
| 307 | `monopolyPlayDefeatedAction`; destination `CAMPAIGN_MAP_SCENE` | :665-668, :207-209 |
| 313 | `monopolyPlayDefeatedAction` | :669-672 |
| 3855 | Outyard views; flag `isOutyardBattle` | :695, :724, :382-385 |
| 16 | detailed view; `CHANLLENGE_ROOM_SCENE`/`SPACE_SCENE` and return (`isOpenColosseum` unreachable) | :753, :332-343, :358-360 |
| 10 | detailed view | :753 |
| 1, 2, 3, 4, 5 | `OUTER_CITY_SCENE` with MapInitData | :172-177, :528-544 |
| 3844 | `returnScene`; flag `isOpenRemotePet` | :181-182, :366-369 |
| 293 / 3893 | manager `getData()` and return (cases :184-189 unreachable) | :127-136 |
| 3878 | empty block | :137-139 |
| 3898 | Dark Maze: SPACE_SCENE or enterScene and return | :140-167 |
| 291 | fall-through → `CAMPAIGN_MAP_SCENE` | :193-210 |
| 17, 19, 20, 22, 23, 306, 307 | `CAMPAIGN_MAP_SCENE` | :202-210 |
| 3841 | `OUTER_CITY_SCENE` | :211-213 |
| 3843 | `CASTLE_SCENE` or `PLANES_WAR_SCENE` | :214-223 |
| 3876 | `SPACE_SCENE` or `SANDBOX_SCENE` | :224-233 |
| 3877 | `GAME_HALL_SCENE`/`SPACE_SCENE` or `PLANE_CRISRIS` | :234-250 |
| 3886 | `GAME_HALL_SCENE` or `SPACE_SCENE` (duplicate case at :287-292) | :251-260 |
| 296 | `CROSS_GUILD_SCENE` or `returnScene`; flag `isCrossGuildBattle` | :261-270, :406-409 |
| 3881 / 3890 | `GuildFBBattleAction` / `GuildWantedBattleAction` | :271-276 |
| 3892 | `SPACE_SCENE` or `STARAREA_SCENE` | :277-286 |
| 349 | `SELF_CHESS_SCENE` | :293-295 |
| 3904 | `SPACE_SCENE` or `SECRET_ADVENTURE_SCENE` | :296-305 |
| 3907 / 3912 | `THESE_PVP_SCENE` / `THESE_Double_PVP_SCENE` | :306-311 |
| 3908 | `SECRET_WAR_SCENE` or `returnScene`; flags `isSecretwarResult`, `isOpenNode` | :312-322, :501-505 |
| 3911 | fall-through → `SPACE_SCENE` (not `CHILD_NS_WAR_SCENE`) | :323-327 |
| 3913 / 3915 | `SPACE_SCENE`; flags `thesetower` / `dungeonexplo` | :325-327, :514-525 |

Reopen flags, set only when `currentType == "BATTLE_SCENE"`:

| battleType | flag | line |
|---|---|---|
| 3845 | `isOpenChildPve` | :370-373 |
| 3847 | `isOpenChildArena` | :374-377 |
| 3851 | `isOpenPerkinLab` | :378-381 |
| 3857, 3858 | `isOutyardExploreBattle` | :386-393 |
| 3860 | `isTitanTempleBattle` | :394-397 |
| 3864, 3865 | `isShuttleBattle` | :398-405 |
| 3861 | `isCrossBraveBattle` | :410-413 |
| 3863 | `isGloryRoadBattle` | :414-417 |
| 3867 | `isAbysmBattle` | :418-421 |
| 3869 | `isLordTrial` | :422-425 |
| 3875 | `isDragonTalker` | :426-429 |
| 3873, 3874 | `isOpenTimeVortex` | :430-433 |
| 3872 | `isOpenTimeVortex`, if the frame is already open | :434-440 |
| 3879 | `isOpenEclipticPalace` | :441-444 |
| 3880 | `isOpenDemonLand` | :445-448 |
| 3884 | `isMonsterExplore` | :449-452 |
| 3885 | `isOpenDreamArena` | :453-456 |
| 3887 | `isOpenRevengeRoad` | :457-460 |
| 3888 | `isOpenRedemptionRoad` | :461-464 |
| 3889 | `isHellAbysmBattle` | :465-468 |
| 3895 | `isExpeditionBattle` | :469-472 |
| 3896 | `isYLExpidtionBattle` | :473-476 |
| 3897 | `isShadowLandBattle` | :477-480 |
| 3899, 3900 | `isRemainsExploreBattle` | :481-484 |
| 3901 | `isConsortiaNewBossBattle` | :485-488 |
| 3902 | `isRoyaltyBossBattle` | :489-492 |
| 3905 | `isWarSoulTowerBattle` | :493-496 |
| 3906 | `isFinalRoadBattle` | :497-500 |
| 3909 | `isMinosMap` | :506-509 |
| 3910 | `chesspvp` | :510-513 |
| 3914 | `thessbox` | :518-521 |

Other:
- 3845 → `preScene = "SPACE_SCENE"` at creation (`core_module/scripts/battle/transaction/CreateGameTransaction.as:147-150`).
- 295, 3854 → `selfDie` + `onFightCanceled` after 1500 ms, no screen (`m10/scripts/battle/view/map/BattleMapView.as:215-241`).

### 10.10 Result state machine

```
IDLE ─4103─► GUARDS (selfDie | repeated battleId | loginState<0 | !battleModel) ─fail─► silent end
              │ ok [8282 if battleType 6 or battleCapity 4 and maxBatter>2]
              ▼
          WAIT_SKILLS (poll 30 ms; exits if isAllSkillExecuted or >100 attempts ≈3 s)
              ▼
          EXECUTE (playVictoryAction if isAllDead; Defeated 35 / monopoly 307,313)
              ▼
          PICK_VIEW ─no battleScene / result∉{1,2} / exception─► EXIT_DIRECT ─► CLOSING + battleCancel
              │ (victory: sound 033 + BATTLE_RESULT true; defeat: BATTLE_RESULT false)
              ▼
          PLAYING (MC timeline; frame scripts)   [isOver=true; SKILL_ENABLE false]
              │ click anywhere ───────────────────────────────┐
              ▼ last frame: gotoAndStop + EXP tween 0.5 s     │
          HOLD (Timer 1000 ms) ── click ──────────────────────┤
              ▼ timerComplete                                 ▼
          CLOSING: resultViewCloseFun → exitBattle → clearView → exitFlag
              ▼ setScene; BattleSceneView.leaving() → disposeBattle
          SCENE_SWITCH_CALL → battleFlag=false → battleComplete → next queued battle
              ▼ outside BATTLE_SCENE: MultiFailedAlert (fail_count>4) + AlertTip (defeat)
```

### 10.11 HTML5 notes

- Battle result views declare `width = 0` → MC origin at `x = stageW/2`; `y = (stageH - 360)/2` (Simple) or `(stageH - 350)/2` (detailed/Outyard); asset content is drawn around the origin (negative coordinates [lib]). Uses raw `stage.stageWidth/Height` (Base :70-71), not the 1000-1500 battle area.
- `MultiFailedAlertAction` compares `month <= month` (same variable), always true (`core_module/scripts/yishi/actions/map/MultiFailedAlertAction.as:36`).

---

## 11. battleType × HUD element matrix

### 11.1 Per battleType

Columns:
- **Bar**: bottom bar added to the screen (§1.4).
- **Auto**: `battle.AutoFightBtn2` visible (§3.1).
- **Top**: top panel (§2.6).
- **Extras**: other conditional elements.

"default" = the `default` path. All `BattleUIView.as` lines refer to `m10/scripts/battle/view/ui/BattleUIView.as`.

| battleType | Bar | Auto | Top | Extras / differences | References |
|---|---|---|---|---|---|
| **default** (any other) | BottomBar (skills §5) | yes (level ≥ 15) | RoleShowViewII (BossInfoView only if a boss `type==3` is on the right) | HurtUpView if heuristic `isPvP()`; TeamStrip; QTE; GoddessTop per `battleCapity` rule; titan if `titanId` exists | `BattleUIView.as:1192-1194, 1314-1317, 1396-1399, 1329-1333` |
| 1, 2, 3, 4, 5 | default | yes | RoleShowViewII | no GoddessTop; result goes to `OUTER_CITY_SCENE` | `BattleFunctionHelper.as:308-357`; `BattleResultHandler.as:172-177` |
| 10 | default | yes | RoleShowViewII | GoddessTop both sides; `[servidor]` under the name; detailed result | `BattleFunctionHelper.as:290-294`; `RoleViewBase.as:435-449`; `BattleResultHandler.as:753` |
| 11 | default | yes | RoleShowViewII | GoddessTop both sides | `BattleFunctionHelper.as:290-294` |
| 13 | default | yes | RoleShowViewII | GoddessTop own side only | `BattleFunctionHelper.as:295-307` |
| **16** | **"finish now" strip** + setting (BottomBar created, not added) | no | RoleShowViewII | finish button enables after N s **without VIP**; 8727; skill click ignored; no TeamStrip; detailed result | `BattleUIView.as:212-215, 293-296, 537-541, 1272-1276`; `BattleSkillItemII.as:388-391`; `BattleView.as:294-308` |
| 17 | default | yes | RoleShowViewII | invincible world boss: full bars and "xN" hidden; no GoddessTop | `BossInfoView.as:109-112`; `RoleViewBase.as:1155-1160` |
| 19, 32, 36, 38, 306 | default | yes | RoleShowViewII | no TeamStrip; 32 shows `[servidor]`; 306 forces `isMultiPlayer=false` | `BattleView.as:294-308`; `BattleModel.as:216-219` |
| 25 | default | yes | RoleShowViewII | TrailCountView; trial props strip (`battle.TrailBack`); `BUFFER_SKILL_ENABLE` does not re-enable; GoddessTop own side only | `BattleUIView.as:1334-1338`; `SkillItemListView.as:96` |
| **35** | **"finish now" strip** (VIP≥3) + setting; no BottomBar | no | RoleShowViewII | `isPvP` → HurtUpView (text `hurtUpTip.text2`); no TeamStrip; no titan; skills watch-only (`isWatchOnly`); pets with bar/shadow; buffs over own hero; ally skill names | `BattleUIView.as:207-211, 1192, 1272`; `HurtUpView.as:208`; `SkillItemListController.as:514-524` |
| 291 | default | yes | RoleShowViewII | `isPvP` false | `BattleModel.as:949` |
| 293 | default | yes | RoleShowViewII | trial props strip; loads UI `clearance`; no GoddessTop | `BattleSceneView.as:113-117`; `SkillItemListView.as:96` |
| **295** | default | **no** | RoleShowViewII, resist y=250/250 | TrailCountView with `trialLayer = molongLayer`; dead units not added; opcode 4680 | `BattleUIView.as:1121-1124, 1384-1388, 1474-1480`; `BattleView.as:259-265` |
| 296 | default | yes | RoleShowViewII | trial strip (frame 2); `[servidor]` | `SkillItemListView.as:116-118`; `RoleViewBase.as:435-449` |
| **307** | **"finish now" strip** (VIP≥3) + chat message; BottomBar created, not added | no | RoleShowViewII | `isWatchOnly`; response 75 is never "mine" (no QTE); no TeamStrip | `BattleUIView.as:552-562, 1272`; `SkillItemListController.as:1014-1021` |
| 308 | default | yes | RoleShowViewII | `[servidor]` | `RoleViewBase.as:435-449` |
| 309 | default | yes | RoleShowViewII | boss level = `callGrade`; extra buffs in SelfBufferView | `BossInfoView.as:259`; `SelfBufferView.as:45-66` |
| **310, 3852** | default | yes | **RoleShowViewIII** (two bosses), resist y=265/215 | 310: revive resets BossBottomStrip; 3852: GoddessTop own side only | `BattleUIView.as:1367-1372`; `RoleViewBase.as:1099-1102` |
| **311, 312** | default | yes | **MutilBossShowView** (LiteBossBloodBar_0) | ResistUI never shows; opcode 4794 syncs HP | `BattleUIView.as:707-710, 1373-1378, 1607-1610` |
| **313** | default | yes | **MutilBossShowView** (2× LiteBossBloodBar_1) | same + world boss (`updateWorldBossBlood`) | `BattleUIView.as:1379-1383, 1626-1629` |
| 315 | default | yes | RoleShowViewII | trial strip; inspiration tooltip ×10% | `SkillItemListView.as:96`; `RoleViewBase.as:359-362` |
| **349** | none | no (the strip remains) | **none** | hideOthers in its own layout; chat and setting hidden; `isPvP` → HurtUp; no TeamStrip | `BattleUIView.as:824-849, 1314, 1392-1395` |
| 3842 | default | yes | RoleShowViewII | trial strip; non-single titan | `SkillItemListView.as:96`; `DragonTitanTeamView.as:175-179` |
| **3844** | **PetBattleBar** | no | RoleShowViewII | no titan; no GoddessTop; remote pet skills (14001); ally skill names; buffs over own hero | `BattleUIView.as:850-881, 1165-1167, 1277-1280` |
| **3845** | **ChildpveBattleBar** | no | RoleShowViewII | no titan; keys <100 blocked; skills 14001 | `BattleUIView.as:922-953, 1173-1175` |
| 3846 | default | **no** | RoleShowViewII | opcode 4985 applies boss HP | `BattleUIView.as:1743-1746`; `RoleShowViewII.as:244-248` |
| **3847** | **ChildCommonBottomBar** | no | RoleShowViewII | no titan; `isPvP` false; skills 10516 | `BattleUIView.as:954-992, 1301-1304` |
| 3848 | default | yes | RoleShowViewII | GoddessTop own side only; `[servidor]` | `BattleFunctionHelper.as:295-307` |
| 3853, 3854 | default | yes | RoleShowViewII | GoddessTop own side only. 3853: special buffs. 3854: opcode 4680 and end via `selfDie` | `BossBufferContainer.as:300-318`; `BattleMapView.as:215-241` |
| **3855** | default | yes | **OutyardShowView** | Outyard result views | `BattleUIView.as:1389-1391`; `BattleResultHandler.as:695, 724` |
| 3859, 3860 | default | yes | RoleShowViewII | trial strip | `SkillItemListView.as:96` |
| **3864, 3866** | **PetSacristyBar** | no | RoleShowViewII | guild chat hidden; chat bubble without icon; skills 10519 + relic (key E) | `BattleUIView.as:882-921, 1169-1171`; `BattleChatPopView.as:105-108` |
| **3867, 3889** | **ChildCommonBottomBar** | no | **none** | no titan | `BattleUIView.as:1392-1395, 1301-1304` |
| **3868** | **ChildCommonBottomBar** | no | RoleShowViewII | no titan | `BattleUIView.as:1301-1304` |
| **3870** | BottomBar + **BattleSpaceTimeView** | yes | RoleShowViewII | TrailCountView; 5 config skills; no Z/X props; no enemy titan on reinforcement; GoddessTop own side only | `BattleUIView.as:494, 1187-1191, 1309-1313, 1334`; `SkillItemListController.as:115-136` |
| 3880, 3883, 3887 | default | yes | RoleShowViewII | R/F slots hidden | `SkillItemListController.as:1175-1178` |
| **3884** | **MonsterCommonBottomBar** | no | RoleShowViewII | monsters show HP bar | `BattleUIView.as:993-1024`; `MonsterRoleView.as:151` |
| **3886** | default | **forced enabled** | RoleShowViewII | auto-fight strip +80 px; "East"-style reinforcement; `isMultiPlayer` true | `BattleUIView.as:745-751, 1152-1155`; `ReinforceWavePane.as:41` |
| 3891 | default | yes | RoleShowViewII | GoddessTop both sides | `BattleFunctionHelper.as:290-294` |
| **3894** | default | yes | RoleShowViewII | TrailCountView + **RaceAgainstTimeUpView**; GoddessTop own side only | `BattleUIView.as:1339-1345` |
| **3895** | none (setting only) | no | RoleShowViewII | hideOthers y -20/-15; no titan | `BattleUIView.as:790-823, 1289-1292` |
| **3896** | none (setting only); orphan ChildCommonBottomBar | no | RoleShowViewII | none | `BattleUIView.as:1179-1181, 1293-1296` |
| **3898** | none (setting only) | no | RoleShowViewII | dead not added; no titan | `BattleUIView.as:1297-1300`; `BattleView.as:259-265` |
| 3902, 3904, 3906 | default | yes | RoleShowViewII | Q slot locked | `SkillItemListView.as:197` |
| **3903** | default | yes | RoleShowViewII | **ForbiddenBossUIView** at top (W-w)/2, y=-6 | `BattleUIView.as:1116-1120, 1346-1350` |
| **3905** | default | yes | RoleShowViewII | **warsoulEndBtn** (10497); TrailCountView; Q locked | `BattleUIView.as:216-219, 1268-1271, 1351-1355` |
| **3907** | default | yes | RoleShowViewII | `isPvP` → HurtUp; no titan; **no TeamStrip**; Q locked | `BattleUIView.as:1676-1679`; `BattleModel.as:1005` |
| **3911** | **ChildCommonBottomBar** (nswar variant) | no | RoleShowViewII | chat/hideOthers at fixed x (948/918/1080/1086); HurtUp in nswar mode; opcode 4680 | `BattleUIView.as:983-989`; `ChildCommonBottomBar.as:58-88`; `HurtUpView.as:134` |
| 3914 | default | yes | RoleShowViewII | 3 extra slots (`thessBoxSkills`, scale 0.6; key '/') | `SkillItemListView.as:134-158` |

### 11.2 Conditions not tied to battleType

| condition | effect | ref. |
|---|---|---|
| `thane.grades >= 6` | messages button | `BattleUIView.as:1428-1431` |
| `consortiaID > 0` | guild chat button | `BattleUIView.as:1432-1435` |
| `thane.grades > 0` | hide-others button | `BattleUIView.as:1464-1468` |
| `thane.grades >= 15` | auto-fight can be enabled; below that, tooltip "Nv. 15" | `BattleUIView.as:1449-1457, 733-736` |
| grades ≥ 50 / ≥ 70 / ≥ 35 / ≥ 40 | slot Q / R and F / Z / X | `SkillItemListView.as:337-353, 252` |
| active VIP with `VipGrade >= 3` | finish now in 35/307 | `BattleUIView.as:207-211, 289-292, 545-549` |
| `isControledByBoss()` | no QTE; skills grayed | `BattleUIView.as:1886`; `BattleSkillItemII.as:716-742` |
| `isAutoFight` | no QTE (`qteTime=0`) and no aiming | `SkillItemListController.as:922-925`; `BattleUIView.as:1898-1901` |
| `StageReferance.isDebug` | debug buttons (14002) | `BattleUIView.as:1481-1491` |
| `newbieProcess >= 19000` | reinforcement waves visible | `RoleShowViewII.as:90` |
| `VersionSwitch.WARSOUL` / `GODDESS_OPEN` / `TAITAN_LOCK` | Warsoul bar / goddess / titan | `BottomBar.as:113`; `BattleFunctionHelper.as:283`; `BattleUIView.as:1199` |
| side | TeamStrip: allies on the left (excluding self), enemies on the right; BossBottomStrip only for a boss with face 2 | `BattleUIView.as:1680-1697`; `RoleViewBase.as:304` |
| spectator (battle_from = 1) | **no HUD difference**; ends via 4803, always with the Simple view | §0.3, §10.8 |
| useWay | no HUD view checks `useWay` (only the 10018 send on load, docs/battle/README.md §1) | grep in m10/scripts/battle/view and core_module/scripts/battle/view |

---

## 12. Consolidated findings and corrections to README.md

### 12.1 Corrections to README.md

The leading section reference of each item (for example §4 "UI") points to [README.md](README.md); references in parentheses point to this document. Most of these items are now reflected in README.md.

1. §4 "UI": the bottom bar is **not** always `BottomBar`. There are eight variants by battleType (§1.4). In 16/307 the BottomBar is created but not shown; in 35/349/3895/3896/3898 there is no bar at all.
2. §4 "UI": "finish now" exists only in 35, 307 and 16.
   - 35 and 307 require VIP ≥ 3.
   - 16 does not require VIP.
   - A configurable countdown (`Imm_over_battle`, default 10 s) runs before it enables (§3.2).
3. §1 "Client sends":
   - Clicking any `BattleSkillItemII` slot calls `setAutoFight(2)`, so **clicking a skill turns auto-fight off** and sends 10020, even when the slot is disabled or on CD (`core_module/scripts/battle/view/ui/BattleSkillItemII.as:392`).
   - Missing skill opcodes: 10499, 10507, 10509, 10516, 10519, 10520, 10521, 10522, 10523, 14001, 25240 and 10022 (tutorial) (§5, §6).
   - Also missing: 10497 (War Tower end), 14002 (debug) and 8282 (combo at end).
4. §3, item 8 (floating numbers):
   - `ParryAsset` and `CriticalDamageAsset` are **never added** to the screen.
   - Style names mislead: `RedNumberAssetSp` is near-white (0xF4FFCC), used for third-party damage; `DamageNumberAssetSp` (yellow) is damage dealt by own hero; `SelfCauseNumberAssetSp` (blue, scale 0.6) is the **parry**.
   - Only bloodType 6 shows a value; 7 and 8 show "0"; 9, 24 and 26 show no number.
   - The `CreateDamageNumViewHelper` pool is dead code (§7).
5. §4 QTE:
   - Key count is `int(QTETime/1500)`, drawn from A/S/D/W (arrows also work).
   - A miss restarts the sequence. With QTETime < 1500 there are no keys and the QTE counts as an immediate hit.
   - 10015 is sent 400 ms after success; nothing is sent on failure.
   - No QTE in auto-fight (`qteTime=0`), under boss control, in 307, and in battleTypes 3844, 3845, 3847, 3864, 3866, 3867, 3868 and 3889 (§7).
6. §4 "HP bar over the unit": the panel (name + bar) sits **at the unit's feet** (`PawnBottomAsset` at y = -20), not above the head.
   - Monsters and pets hide the bar, except in 3884 and 35 respectively.
   - `BossBottomStrip` only appears for a boss (`type==3`) with face 2.
   - Goddesses have no visible layer (§7).
7. §5 End:
   - The default view is **Simple** (`asset.battle.VictoryAssetII2` / `FailedAssetII2`). Detailed only in 16 and 10; Outyard only in 3855.
   - No buttons or items: `battle.ResultItem` only exists in `SinglePassVicotyResultView`, whose open path is dead.
   - The screen closes on a global click or 1 s after the animation ends.
   - `exitBattle` picks the scene via `switch(battleType)`. `disposeBattle` comes from `BattleSceneView.leaving()`.
   - The skill wait is up to 101 × 30 ms (§10).
8. §4 Visible area: correct (1000-1500 × 600-900). Above 1500×900 the area is **centered** on the stage (`m10/scripts/battle/BattleSceneView.as:131-151`). Layer `GAME_UI_LAYER` (4) is hidden during battle (`m10/scripts/battle/view/BattleView.as:97`).

### 12.2 Dead code and elements that never appear

Do not reimplement these, or decide deliberately:
- `BatterUIView` (combo): created but never receives `addChild` (§2.12).
- `AttackModeView`, `PowerUIView`, `SpTip`, `AttackModeChangeEffect`, `SpStripIncreaseAnimation`, `AddOtherSkillView/Item`, `LiteBossStripUIView`, `BufferListView/BufferListItem` and `QuickenHeroMovieClip`: no instances (§4, §5, §8, §9).
- `_overMc` (hover) and `_downMc` of `BattleSkillItemII`: never visible (§5).
- `QteSuccessAnimation`: flies nothing, only swaps the aura after 800 ms (§7).
- `isWatchOnly` of the Pet and ChildPve controllers (§6).
- `BattleViewManager` accesses `battleUIView.finishNowBtn`, which does not exist; the exception is swallowed (§0.3).

### 12.3 Behavior bugs relevant for parity

- `BATTLE_REINFORCE_HANDLER` recreates the `BattleGoddessTopView`s without disposing the previous ones, and creates titans without checking `TAITAN_LOCK` (`BattleUIView.as:479-529`).
- The "finish now" countdown shows a fixed "10" in the 1st second, whatever N is (`BattleUIView.as:1246, 253-269`).
- `_skillListOffsetX` has no effect (`BattleUIView.as:769`).
- In 3896 an off-screen ChildCommonBottomBar can still receive keys (§6) *(runtime assumption)*.
- With HP ≤ 0, `FORCE_SKILL_ENABLE` is resent every frame by SelfBloodView, ChildCommonBottomBar and MonsterCommonBottomBar (§4).
- `getFastkey` ignores the last entry of the `fastKey` CSV (§5).
- Result exit switch bugs: 291 and 3911 fall through to the next case, and 3886 is duplicated (§10.9).

### 12.4 Gaps

- Internal geometry of SWF MovieClips (`BossShowRightAsset`, `LiteBossBloodBar_*`, `asset.battle.BottomBack`, `remotepetBack`, `AbysmBattleBack` etc.) is not in the AS. Sections using `library.json` or `tools/swflib.py` are marked [lib]/[SWF].
- The value of `Imm_over_battle` is not in the repository.
- Effective stage fps: `Loading.as` declares 25, but UI SWFs declare 24.

---

## 13. HTML5 renderer preview

Viewer route: `#battle:<preset>[@WxH][!map]` (W×H = viewport size, map = map number). Example: <http://localhost:5173/#battle:boss@1500x900!5>.
Presets: `pve` (lord vs. NPC hero with troops 1,2,7,8), `boss` (boss `type 3`) and `grid` (12 positions per side).
Sizes: 1000×600, 1300×750 and 1500×900. Maps: 1-17. The status bar has buttons for damage, critical, heal, parry,
auto damage and grid.

Code in `web/src/battle/` (new files only; the only change outside it is the route in `web/src/viewer/viewer.ts`):

| file | content |
|---|---|
| `grid.ts` | literal port of `get9GridPos`, `rolePointByPos`, `getPosition`, `attackPointByPos`, scene size and camera transform ([docs/battle/formation.md](formation.md) §1, §5) |
| `BattlePreview.ts` | hierarchy `BattleSceneView` → `BattleView` (W×H clip) → `BattleMapView` (layers: map, roleBack, profound, grid, roles, effects, gas) → profoundLayer → HUD → RedScreenEffect; z-order by `pointY` |
| `units.ts` | unit as `RoleViewBase`: shadow `asset.battle.RoleShadeMC` (alpha 0.7), body in `_movieContainer` (scaleX -1 on face 2), `asset.battle.PawnBottomAsset` at y -20 with `battle.HeroNameTxt` and `BottomHpStripAsset`/`BossBottomStripAsset` (`maskmc.width` = HP); pet at ±60 px and -80 px (flying) |
| `hud.ts` | H branch of `layout()`: `asset.battle.BottomBack`, HP/SP orbs (port of `VesselBallComp`), `battle.AutoFightBtn2`, `asset.battle.AutoFightFlagAsset`, `battle.HideOthersBg/Btn`, `battle.teamStripContainer1/2`, `battle.settingBtn`; skill bar and `RoleShowViewII` are placeholders |
| `damage.ts` | port of `DamageNumView`: `BloodUpdateAsset`/`BloodUpdateRage` with the per-case number style, at (0, -130), -50 on critical; `ParryAsset`/`CriticalDamageAsset` are **not** shown, as in the original |
| `swfAssets.ts` | loads libraries from `web/public/battle/` and `ActionPlayer` (port of `ActionMovie`: Stand/Walk/Ready loop; Victory/Failed stop; the rest waits 5 frames and returns to Stand) |
| `fixtures.ts` | fake battles |

**Real assets.** The map and units with their own SWF come from the original SWFs already downloaded into `raw/`. The generator below
builds the libraries in `web/public/battle/<swf>/` (same format as `web/public/lib`); it downloads nothing:

```bash
python3 tools/battle_assets.py
```

- **Maps** `raw/sceneima/<n>/map<n>.swf` (17): the `ClassExport` has a single child, a 1500×900 bitmap at y -1. Since
  `RepeatBackGroundLayer.x` does not move the sprite (`m10/scripts/battle/view/map/RepeatBackGroundLayer.as:44-60`) and `moveSpeed`
  is 0, the image stays fixed at world x 0-1500. The generator replaces the "rectangle with bitmap fill" shape with the bitmap's PNG,
  because the `<pattern>` in FFDec's exported SVG is not rasterized.
- **Units** `raw/swf/<res>/<res>.swf` (26): player soldiers `001`-`011` (without `004`), monsters `monster*` and bosses
  `boss*`. Class is `slg.resource.movie.MovieAsset<res>`, but the name may differ from the file (`boss030.swf` exports
  `MovieAssetboss020`). Labels: `Stand, Walk, Attack01, Attack02, Victory, Danny, DannyA, Die` (+ `Ground`).
- **Skill effects** (`raw/skilleffect`, 81): only with `--effects`.
- **Player heroes, children and pets** remain placeholders: equipment parts (`equip/**`) and avatars
  were not downloaded.
