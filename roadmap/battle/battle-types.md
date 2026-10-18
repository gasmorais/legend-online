# battleType values and owning features

Reference of the feature [Motor de batalha](README.md). It lists **every battleType value used anywhere in the client** and the roadmap feature that owns (creates) battles of that type. Path prefixes: **CM** = `decompiled/core_module/scripts`, **M10** = `decompiled/m10/scripts`. Per value client effects in full: `docs/battle/rules.md` §11.4 and `docs/battle/hud.md` §11.

## 1. Sources and method

- Constants: `CM/yishi/datas/battle/BattleType.as` declares 128 constants with **123 distinct values** (aliases: 295, 296, 305, 307, 3842). No value 24.
- Uses: a scan of every `decompiled/**/*.as` file (protobuf classes excluded) for `battleType ==/!= N` and `switch(battleType [- k])` cases found no value outside these 123 (the compiled code uses numeric literals, never `BattleType.X`). Values only declared, never compared: 14, 15, 21, 328, 3840, 3882.
- Owner: the feature whose screens or managers start that battle (client package mapping in `roadmap/features.json`), cross-checked against the battleTypes other roadmap folders already cite (§4). Values marked *(assumption)* are inferred from the constant name or the exit scene.
- The value travels in 157 `BattlePrepareMsg.battle_type` and 156 `BattleStartMsg.mainType` (must be equal). `ReqBattleOrderMsg.battleType` exists in the proto but no client code sends it.

## 2. Predicates that change engine behavior

The server must reproduce these per value rules when it configures a battle (definitions: `docs/battle/rules.md` §11.3).

| Group | Values | Server consequence |
|---|---|---|
| Child battle (`isChildBattle`) | 3867, 3868, 3847, 3889, 3895, 3896, 3898, 3911 | player controls a child (10516); 4600/4589/4311 ignored |
| Monster battle | 3884 | player controls the captain monster (10520) |
| No hero skill use | 3844, 3845, 3847, 16, 3868 + child battles | reject hero 10008, 10521, 10522 |
| Watch only | 35, 307 | hero bar always disabled |
| Pets as fighters | 35 (pets only), 3844, 3866, 3864 | pets in pet form, `sexs 2` |
| PvP for HurtUp | true: 35, 349, 3907; false: 291, 39, 3844, 3847, 3867, 3868, 3870, 3872, 3873, 3875, 3845, 3889; others: true when an enemy non boss hero exists | 4361 escalation shown only for PvP |
| World boss HP | 17, 297, 305, 3865, 313, 3881, 3903 | shared, server synced boss HP |
| Auto hidden | 35, 307, 16, 3895, 3896, 3898, 349, 3844, 3866, 3864, 3845, child battles, 3884, 295, 3846 | auto flag irrelevant |
| Finish now | 16 (no VIP), 35 and 307 (VIP 3) | accept 8727 |
| Trial props bar | 25, 3842, 293, 315, 3859, 3860, 296 | accept 10507 |
| Seal skill locked | 3902, 3904, 3907, 3905, 3906 | reject the seal (Q) skill |
| Dead units cleared (4680) | 295, 3854, 3911 | send 4680; own death ends 295/3854 locally |
| Detailed result view | 16, 10 (Outyard view: 3855) | `gp_bonus` shown |

## 3. Value table

| Value | Constant | Mode (pt-BR when known) | Owner | Client effects (summary) | First client references |
|---:|---|---|---|---|---|
| 1 | `RES_WILDLAND_BATTLE` | world map resource fight (assumption) | [world-map](../world-map/README.md) | exit `OUTER_CITY_SCENE` at the army position | `CM/battle/utils/BattleFunctionHelper.as:308`; `CM/battle/handler/BattleResultHandler.as:172` |
| 2 | `NPC_WILDLAND_BATTLE` | world map NPC (assumption) | [world-map](../world-map/README.md) | exit `OUTER_CITY_SCENE` | `CM/battle/utils/BattleFunctionHelper.as:309`; `CM/battle/handler/BattleResultHandler.as:173` |
| 3 | `TRE_WILDLAND_BATTLE` | world map treasure (assumption) | [world-map](../world-map/README.md) | exit `OUTER_CITY_SCENE` | `CM/battle/utils/BattleFunctionHelper.as:310`; `CM/battle/handler/BattleResultHandler.as:174` |
| 4 | `CASTLE_BATTLE` | castle attack on the world map (assumption) | [world-map](../world-map/README.md) | exit `OUTER_CITY_SCENE` | `CM/battle/utils/BattleFunctionHelper.as:311`; `M10/battle/view/ui/RoleShowViewII.as:202` |
| 5 | `WILD_QUEUE_BATTLE` | world map queue battle (assumption) | [world-map](../world-map/README.md) | exit `OUTER_CITY_SCENE` | `CM/battle/utils/BattleFunctionHelper.as:312`; `M10/battle/view/ui/RoleShowViewII.as:202` |
| 6 | `CAMPAIGN_BATTLE` | campaign instance | [campaign](../campaign/README.md) | 8282 combo count at the end; chests `sendCampaignFinish` | `CM/battle/utils/BattleFunctionHelper.as:313`; `CM/map/internals/transaction/OpenChestTransaction.as:75` |
| 7 | `BATTLE_DEBUG_BOSS` | debug boss | [battle](../battle/README.md) | debug only | `CM/battle/utils/BattleFunctionHelper.as:314`; `M10/battle/view/ui/RoleShowViewII.as:202` |
| 8 | `BATTLE_DEBUG_MODE` | debug mode | [battle](../battle/README.md) | debug only | `M10/battle/view/ui/RoleShowViewII.as:202`; `M10/battle/view/ui/RoleShowViewIII.as:94` |
| 9 | `BATTLE_GUIDEBOOK` | guide battle (assumption) | [tutorial](../tutorial/README.md) | goddess top off | `CM/battle/utils/BattleFunctionHelper.as:315` |
| 10 | `BATTLE_MATCHING` | matchmaking cross PvP (assumption) | [arena](../arena/README.md) | detailed result view; server name tag; chat channel 8 | `CM/battle/utils/BattleFunctionHelper.as:291`; `CM/chat/ChatSocketOutManager.as:255` |
| 11 | `BATTLE_MULTIPLAYER` | multiplayer room battle | [campaign](../campaign/README.md) | goddess top on both sides | `CM/battle/utils/BattleFunctionHelper.as:290` |
| 12 | `BOSS_BATTLE` | boss battle (assumption) | [campaign](../campaign/README.md) |  | `CM/battle/utils/BattleFunctionHelper.as:316` |
| 13 | `MULTIPLAYER_BOSS_BATTLE` | group boss (assumption) | [team](../team/README.md) | goddess top own side | `CM/battle/utils/BattleFunctionHelper.as:295`; `M10/battle/view/ui/DragonTitanTeamView.as:190` |
| 14 | `USER_DEFINE_BATTLE` | `USER_DEFINE_BATTLE` | none | no client reference | declared only (`CM/yishi/datas/battle/BattleType.as`) |
| 15 | `SPECIAL_BOSS_BATTLE` | `SPECIAL_BOSS_BATTLE` | none | no client reference | declared only (`CM/yishi/datas/battle/BattleType.as`) |
| 16 | `BATTLE_CHALLENGE` | "Desfio individual" (Colosseum) | [arena](../arena/README.md) | no manual skills; finish now without VIP; detailed result; exit challenge room or Space | `CM/battle/utils/BattleFunctionHelper.as:317`; `CM/battle/view/ui/AddOtherSkillView.as:288` |
| 17 | `WORLD_BOSS_BATTLE` | world boss | [world-boss](../world-boss/README.md) | shared HP; invincible state; exit `CAMPAIGN_MAP_SCENE` | `CM/battle/actions/DannyAction.as:146`; `CM/battle/actions/DannyAction.as:450` |
| 18 | `NPC_FOLLOW_BATTLE` | NPC follower battle (assumption) | [campaign](../campaign/README.md) |  | `CM/battle/utils/BattleFunctionHelper.as:319`; `M10/battle/view/ui/DragonTitanTeamView.as:187` |
| 19 | `HANGUP_PVP` | campaign map duel ("hang up" PvP, 8525) | [campaign](../campaign/README.md) | exit `CAMPAIGN_MAP_SCENE` | `CM/battle/utils/BattleFunctionHelper.as:351`; `M10/battle/view/BattleView.as:297` |
| 20 | `GUILD_TOTEM_BATTLE` | guild totem (assumption) | [guild](../guild/README.md) | exit `CAMPAIGN_MAP_SCENE` | `CM/battle/handler/BattleResultHandler.as:206` |
| 21 | `ALTAR_BATTLE` | guild altar (`ALTAR_BATTLE`) | [guild](../guild/README.md) | no client reference | declared only (`CM/yishi/datas/battle/BattleType.as`) |
| 22 | `SECRECT_LAND` | secret land map (assumption) | [campaign](../campaign/README.md) | exit `CAMPAIGN_MAP_SCENE` | `CM/battle/handler/BattleResultHandler.as:204` |
| 23 | `FAM_NPC_BATTLE` | family NPC (assumption) | [guild](../guild/README.md) | exit `CAMPAIGN_MAP_SCENE` | `CM/battle/utils/BattleFunctionHelper.as:320`; `CM/battle/handler/BattleResultHandler.as:205` |
| 25 | `TRIAL_TOWER_BATTLE` | trial tower | [trials](../trials/README.md) | trial props bar; floor counter | `CM/battle/utils/BattleFunctionHelper.as:296`; `CM/battle/view/ui/AvengerSkillItemListController.as:312` |
| 32 | `CROSS_WAR_FIELD_BATTLE` | cross battlefield (assumption) | [cross-server](../cross-server/README.md) | server name tag; no TeamStrip | `CM/battle/utils/BattleFunctionHelper.as:321`; `M10/battle/view/BattleView.as:298` |
| 35 | `PET_PK` | pet arena (Einherjar challenge) | [einherjar](../einherjar/README.md) | pets only; watch only; finish now with VIP 3 | `CM/battle/skillsys/skills/BaseSkill.as:179`; `CM/battle/skillsys/skills/BaseSkill.as:268` |
| 36 | `PET__HUMAN_PK` | pet versus human (assumption) | [einherjar](../einherjar/README.md) | no TeamStrip | `M10/battle/view/BattleView.as:300` |
| 38 | `MINERAL_PK` | mine car PvP (MineralPVP map, assumption) | [campaign](../campaign/README.md) | no TeamStrip | `M10/battle/view/BattleView.as:301` |
| 39 | `CONSORTIA_FAM_LORDS_BATTLE` | guild family lords | [guild](../guild/README.md) | not PvP for HurtUp | `CM/yishi/datas/BattleModel.as:953` |
| 290 | `KING_TOWER_BATTLE` | king tower room instance (assumption) | [campaign](../campaign/README.md) | enemies tinted | `CM/battle/transaction/CreateGameTransaction.as:755`; `CM/yishi/datas/BattleModel.as:1067` |
| 291 | `TREASUREMAP_BATTLE` | "Tesouro Perdido" treasure map | [treasures](../treasures/README.md) | exit always `CAMPAIGN_MAP_SCENE` (case fall through) | `CM/yishi/datas/BattleModel.as:949`; `M10/battle/view/ui/DragonTitanTeamView.as:195` |
| 293 | `SINGLE_PASS` | Skybox Road / single pass | [trials](../trials/README.md) | exit via `SkyboxRoadManager` | `CM/battle/utils/BattleFunctionHelper.as:322`; `CM/yishi/datas/BattleModel.as:1042` |
| 295 | `MOLONG_BATTLE` / `DROAGON_BATTLE` | Molong (demon dragon) room instance | [campaign](../campaign/README.md) | 4680 clears dead units; own death cancels; floor counter | `CM/battle/handler/ReinforceHandler.as:152`; `CM/battle/transaction/CreateGameTransaction.as:143` |
| 296 | `CROSS_CONSORTIA` / `CROSS_GUILD_BATTLE` | cross guild war | [guild](../guild/README.md) | trial props bar; exit `CROSS_GUILD_SCENE` | `CM/yishi/datas/BattleModel.as:1062`; `CM/battle/handler/BattleResultHandler.as:261` |
| 297 | `CROSS_CONSORTIA_BOSS` | cross guild boss | [guild](../guild/README.md) | world boss HP rules | `CM/yishi/datas/BattleModel.as:864` |
| 305 | `PETISLAND_BOSS_BATTLE` / `PETISLAND_RAGE_BATTLE` | pet island boss | [einherjar](../einherjar/README.md) | world boss HP rules | `CM/yishi/datas/BattleModel.as:864`; `M10/battle/view/ui/DragonTitanTeamView.as:199` |
| 306 | `MONOPOLY_BATTLE_NORMAL` | Monopoly normal battle | [casino](../casino/README.md) | single player; exit `CAMPAIGN_MAP_SCENE` | `CM/yishi/datas/BattleModel.as:216`; `M10/battle/view/BattleView.as:302` |
| 307 | `MONOPOLY_BATTLE_HELP` / `MONOPOLY_BATTLE_FIREND` | Monopoly friend help | [casino](../casino/README.md) | watch only; finish now with VIP 3; exit `CAMPAIGN_MAP_SCENE` | `CM/battle/transaction/CreateGameTransaction.as:130`; `CM/battle/view/ui/ChildPveSkillItemListController.as:116` |
| 308 | `MULTILORDS` | "Batalha de Titãns" (multilords) | [venus-battle](../venus-battle/README.md) | server name tag; chat channel 8 | `CM/chat/ChatSocketOutManager.as:256` |
| 309 | `CONSORTIA_EME_DREAM_BOSS_BATTLE` | "Terra dos Sonhos" guild boss | [guild](../guild/README.md) | special buff bar | `CM/battle/view/ui/top/BossInfoView.as:259`; `M10/battle/view/ui/SelfBufferView.as:45` |
| 310 | `DOUBLE_BOSS_BATTLE` | double boss (assumption) | [campaign](../campaign/README.md) | two boss bars; boss may revive | `CM/battle/view/roles/RoleViewBase.as:1099`; `CM/yishi/datas/objects/RoleInfo.as:899` |
| 311 | `DARK_DUST_MOUNTAINS_BOSS_BATTLE` | Dark Dust Mountains boss (assumption) | [campaign](../campaign/README.md) | multi boss panel; HP sync 4794; plot dialogs | `CM/battle/handler/BattlePlotHandler.as:76`; `CM/battle/handler/BattlePlotHandler.as:98` |
| 312 | `REMAIN_TUNNEL_BOSS_BATTLE` | Ruins Tunnel boss (assumption) | [campaign](../campaign/README.md) | multi boss panel; HP sync 4794 | `CM/battle/handler/BattlePlotHandler.as:76`; `CM/battle/handler/BattlePlotHandler.as:98` |
| 313 | `REMAIN_HILL_BOSS_BATTLE` | Ruins Hill boss (assumption) | [campaign](../campaign/README.md) | three boss bars; world boss HP rules | `CM/battle/handler/BattlePlotHandler.as:76`; `CM/battle/handler/BattlePlotHandler.as:98` |
| 314 | `TEAM_AREAMAP4_MONSTER` | team area map 4 monster (assumption) | [team](../team/README.md) |  | `M10/battle/view/ui/DragonTitanTeamView.as:198` |
| 315 | `CROSS_MATELORDS_BATTLE` | "Batalha de Vênus" (matelords) | [venus-battle](../venus-battle/README.md) | trial props bar; inspiration icon | `CM/battle/view/roles/RoleViewBase.as:359`; `CM/yishi/datas/BattleModel.as:1047` |
| 328 | `TIMEARREST_BATTLE` | `TIMEARREST_BATTLE` | none | no client reference | declared only (`CM/yishi/datas/battle/BattleType.as`) |
| 330 | `GODS_BATTLE` | gods battle (`GodsEvening`, assumption) | [three-kingdoms](../three-kingdoms/README.md) | goddess top off | `CM/battle/utils/BattleFunctionHelper.as:349` |
| 349 | `SELF_PROPELLED_CHESS_BATTLE` | "Supremacia do Legend" auto chess | [auto-chess](../auto-chess/README.md) | chess pieces; exit `SELF_CHESS_SCENE` | `CM/battle/transaction/CreateGameTransaction.as:135`; `CM/battle/view/roles/RoleViewBase.as:477` |
| 3840 | `DUNGEON_MONSTER_BATTLE` | `DUNGEON_MONSTER_BATTLE` | none | no client reference | declared only (`CM/yishi/datas/battle/BattleType.as`) |
| 3841 | `WORLD_MAP_NPC` | world map NPC | [world-map](../world-map/README.md) | exit `OUTER_CITY_SCENE` | `M10/battle/view/ui/DragonTitanTeamView.as:196`; `CM/battle/handler/BattleResultHandler.as:211` |
| 3842 | `RANDOM_BOSS` / `RANDOM_BOSS_NPC` | random boss (assumption) | [campaign](../campaign/README.md) | trial props bar | `CM/yishi/datas/BattleModel.as:1037`; `M10/battle/view/ui/DragonTitanTeamView.as:177` |
| 3843 | `PLANES_WAR_BATTLE` | planes war | [planes](../planes/README.md) | exit `PLANES_WAR_SCENE` or castle | `CM/battle/utils/BattleFunctionHelper.as:323`; `CM/battle/handler/BattleResultHandler.as:214` |
| 3844 | `REMOTE_PET_BATLE` | "Expedição de Einherjar" (remote pet) | [einherjar](../einherjar/README.md) | pet bar, 14001; no hero skills | `CM/battle/actions/DieAction.as:48`; `CM/battle/skillsys/skills/BaseSkill.as:268` |
| 3845 | `CHILD_PVE_BATLE` | "Guardiões Procurados" (child PvE) | [guardians](../guardians/README.md) | child PvE bar, 14001 | `CM/battle/skillsys/skills/BaseSkill.as:435`; `CM/battle/transaction/BattleAvengerSpTransaction.as:36` |
| 3846 | `ROOM_BOSS_BATTLE` | room boss (Taila) | [campaign](../campaign/README.md) | HP sync 4985; auto hidden | `M10/battle/view/ui/BattleUIView.as:1743`; `M10/battle/view/ui/RoleShowViewII.as:244` |
| 3847 | `CHILD_ARENA_BATLE` | "Arena do Guardião" (child arena) | [guardians](../guardians/README.md) | child battle; HurtUp variant | `CM/battle/transaction/CreateGameTransaction.as:914`; `CM/battle/utils/BattleFunctionHelper.as:341` |
| 3848 | `CROSS_MULTI_CAMPAIGN` | cross multi campaign | [campaign](../campaign/README.md) | server name tag | `CM/battle/utils/BattleFunctionHelper.as:303` |
| 3850 | `MONOPOLY_MIRROR_BATTLE` | Monopoly mirror | [casino](../casino/README.md) | single player | `CM/battle/utils/BattleFunctionHelper.as:350`; `CM/yishi/datas/BattleModel.as:216` |
| 3851 | `PERKIN_LAB_BATTLE` | "Laboratório de Plantina" | [laboratory](../laboratory/README.md) | reopens the lab frame | `CM/battle/utils/BattleFunctionHelper.as:324`; `CM/battle/handler/BattleResultHandler.as:378` |
| 3852 | `CHANGE_DOUBLE_BOSS` | variable double boss (assumption) | [campaign](../campaign/README.md) | two boss bars | `CM/battle/utils/BattleFunctionHelper.as:297`; `M10/battle/view/ui/BattleUIView.as:1368` |
| 3853 | `WEEK_FINAL_BOSS` | weekly final boss (WasteCampaign, assumption) | [campaign](../campaign/README.md) | special boss buffs | `CM/battle/utils/BattleFunctionHelper.as:298`; `M10/battle/view/buffer/BossBufferContainer.as:300` |
| 3854 | `BLOODY_REALM_BATTLE` | bloody realm (assumption) | [campaign](../campaign/README.md) | 4680 clears dead units; own death cancels | `CM/battle/utils/BattleFunctionHelper.as:299`; `M10/battle/view/map/BattleMapView.as:215` |
| 3855 | `OUTYARD_BATLE` | "Luta da Terrálem" | [outyard](../outyard/README.md) | Outyard result views | `CM/battle/utils/BattleFunctionHelper.as:325`; `CM/mvc/controler/OutyardControler.as:269` |
| 3857 | `OUTYARD_ROUTE_BATTLE` | Terrálem route (assumption) | [outyard](../outyard/README.md) | reopens exploration | `CM/battle/utils/BattleFunctionHelper.as:326`; `CM/mvc/controler/OutyardControler.as:269` |
| 3858 | `OUTYARD_EXPLORE_BATTLE` | Terrálem exploration (assumption) | [outyard](../outyard/README.md) | reopens exploration | `CM/battle/utils/BattleFunctionHelper.as:327`; `CM/mvc/controler/OutyardControler.as:269` |
| 3859 | `CROSS_ARESLORDS_BATTLE` | "Batalha de Ares" | [ares-battle](../ares-battle/README.md) | trial props bar | `CM/battle/utils/BattleFunctionHelper.as:328`; `CM/yishi/datas/BattleModel.as:1052` |
| 3860 | `TITAN_LAND_BATTLE` | titan temple / titan land | [dragon](../dragon/README.md) | trial props bar | `CM/battle/utils/BattleFunctionHelper.as:348`; `CM/yishi/datas/BattleModel.as:1027` |
| 3861 | `CROSS_BRAVE_BATTLE` | cross brave (assumption) | [athena-battle](../athena-battle/README.md) | reopens cross brave | `CM/battle/handler/BattleResultHandler.as:410` |
| 3862 | `FANTASY_MATRIX_BATTLE` | fantasy matrix (assumption) | [campaign](../campaign/README.md) |  | `CM/battle/utils/BattleFunctionHelper.as:329` |
| 3863 | `GLORY_ROAD_BATTLE` | glory road | [roads](../roads/README.md) | child from `GloryroadManager` | `CM/battle/utils/BattleFunctionHelper.as:330`; `CM/yishi/datas/BattleModel.as:1248` |
| 3864 | `SHUTTLE_PET_BATTLE` | "Einherjars em Combate" (shuttle) | [exploration](../exploration/README.md) | pet sacristy bar | `CM/battle/chat/BattleChatPopView.as:105`; `CM/battle/transaction/CreateGameTransaction.as:882` |
| 3865 | `ARCANE_ZONE_BOSS_BATTLE` | "Chefão da Área Restrita" (arcane zone) | [exploration](../exploration/README.md) | world boss HP rules; HP sync 4462 | `CM/battle/utils/BattleFunctionHelper.as:332`; `CM/yishi/datas/BattleModel.as:864` |
| 3866 | `SACRISTY_PET_BATLE` | pet sacristy | [einherjar](../einherjar/README.md) | pet sacristy bar, 10519 | `CM/battle/chat/BattleChatPopView.as:105`; `CM/battle/handler/ReinforceHandler.as:242` |
| 3867 | `ABYSM_BATTLE` | abyss (child battle) | [guardians](../guardians/README.md) | child battle | `CM/battle/transaction/CreateGameTransaction.as:914`; `CM/battle/utils/BattleFunctionHelper.as:345` |
| 3868 | `CHILD_WAR_BATTLE` | children war | [guardians](../guardians/README.md) | child battle | `CM/battle/transaction/CreateGameTransaction.as:914`; `CM/battle/utils/BattleFunctionHelper.as:346` |
| 3869 | `LORD_TRIAL_BATTLE` | "Julgamento Principal" (lord trial) | [trials](../trials/README.md) | child from `LordTrialManager` | `CM/battle/utils/BattleFunctionHelper.as:333`; `CM/battle/view/roles/RoleViewBase.as:477` |
| 3870 | `SPACE_TIME_BATTLE` | "Piso do Tempo" (space time fault) | [mounts](../mounts/README.md) | fixed skill bar `TimeSpaceFaultSkill` | `CM/battle/handler/ReinforceHandler.as:141`; `CM/battle/utils/BattleFunctionHelper.as:300` |
| 3871 | `LORD_TRIAL_POINT` | lord trial point (assumption) | [trials](../trials/README.md) |  | `CM/battle/utils/BattleFunctionHelper.as:334`; `M10/battle/view/ui/DragonTitanTeamView.as:210` |
| 3872 | `TIMEVORTEX_CRACK_BATTLE` | "Cisão no Vórtice do Tempo" | [trials](../trials/README.md) | reopens time vortex | `CM/battle/utils/BattleFunctionHelper.as:304`; `CM/yishi/datas/BattleModel.as:981` |
| 3873 | `TIMEVORTEX_BATTLE` | time vortex | [trials](../trials/README.md) | reopens time vortex | `CM/battle/utils/BattleFunctionHelper.as:335`; `CM/yishi/datas/BattleModel.as:985` |
| 3874 | `TIMEVORTEX_BATTLE_PLAYER` | time vortex (player) | [trials](../trials/README.md) | reopens time vortex | `CM/battle/utils/BattleFunctionHelper.as:347`; `CM/battle/handler/BattleResultHandler.as:430` |
| 3875 | `DRAGONTALKER_NODE` | "Encantador de Dragões" node (time vortex dragon tab) | [trials](../trials/README.md) | reopens time vortex | `CM/battle/utils/BattleFunctionHelper.as:336`; `CM/yishi/datas/BattleModel.as:989` |
| 3876 | `DAY_LIGHT_BATLE` | sandbox daylight (client package `sandbox`) | unassigned | exit `SANDBOX_SCENE` or Space | `CM/battle/utils/BattleFunctionHelper.as:337`; `CM/battle/handler/BattleResultHandler.as:224` |
| 3877 | `PLANE_CRISIS` | plane crisis | [trials](../trials/README.md) | exit plane crisis, game hall or Space | `CM/battle/utils/BattleFunctionHelper.as:301`; `M10/battle/view/ui/DragonTitanTeamView.as:202` |
| 3878 | `DUNGEON_TURN` | turn dungeon | [campaign](../campaign/README.md) | empty exit block | `CM/battle/utils/BattleFunctionHelper.as:302`; `M10/battle/view/ui/DragonTitanTeamView.as:203` |
| 3879 | `ECLIPTIC_PALACE` | ecliptic palace | [ecliptic-palace](../ecliptic-palace/README.md) | reopens the palace | `CM/battle/utils/BattleFunctionHelper.as:338`; `CM/battle/handler/BattleResultHandler.as:441` |
| 3880 | `DEMON_LAND` | demon land | [trials](../trials/README.md) | child skill items hidden | `CM/battle/utils/BattleFunctionHelper.as:339`; `CM/battle/view/ui/SkillItemListController.as:1175` |
| 3881 | `GUILD_FB_BATTLE` | guild dungeon ("Campanha da Guilda") | [guild](../guild/README.md) | world boss HP rules; deferred guild action | `CM/yishi/datas/BattleModel.as:864`; `CM/battle/handler/BattleResultHandler.as:271` |
| 3882 | `APEX` | `APEX` | [casino](../casino/README.md) | no client reference | declared only (`CM/yishi/datas/battle/BattleType.as`) |
| 3883 | `DEEP_PRISION_BATTLE` | deep prison (assumption) | [campaign](../campaign/README.md) | child skill items hidden | `CM/battle/view/ui/SkillItemListController.as:1175` |
| 3884 | `MONSTER_EXPLORE_BATTLE` | monster exploration | [exploration](../exploration/README.md) | monster bar, 10520 | `CM/battle/handler/ReinforceHandler.as:287`; `CM/battle/transaction/CreateGameTransaction.as:940` |
| 3885 | `DREAM_ARENA_BATTLE` | "Arena Ilusória" (dream arena) | [arena](../arena/README.md) | reopens dream arena | `CM/battle/utils/BattleFunctionHelper.as:352`; `CM/battle/handler/BattleResultHandler.as:453` |
| 3886 | `EASTER_BATTLE` | Easter event (game hall) | [casino](../casino/README.md) | auto allowed in multi; Easter waves | `CM/yishi/datas/BattleModel.as:212`; `M10/battle/view/reinforce/ReinforceWaveBall.as:26` |
| 3887 | `REVENGE_ROAD_BATTLE` | revenge road | [roads](../roads/README.md) | child skill items hidden | `CM/battle/utils/BattleFunctionHelper.as:340`; `CM/battle/view/ui/SkillItemListController.as:1175` |
| 3888 | `REDEMPTION_ROAD_BATTLE` | "Caminho da Salvação" | [roads](../roads/README.md) | reopens the road | `CM/battle/handler/BattleResultHandler.as:461` |
| 3889 | `HELL_ABYSM_BATTLE` | hell abyss (child battle) | [guardians](../guardians/README.md) | child battle | `CM/battle/transaction/CreateGameTransaction.as:914`; `CM/battle/utils/BattleFunctionHelper.as:353` |
| 3890 | `GUILD_WANTED_BATTLE` | "Caçada da Guilda" | [guild](../guild/README.md) | deferred guild action | `CM/battle/utils/BattleFunctionHelper.as:354`; `CM/battle/handler/BattleResultHandler.as:274` |
| 3891 | `GLORY_GAME_BATTLE` | glory games | [glory-supremacy](../glory-supremacy/README.md) | goddess top on both sides | `CM/battle/utils/BattleFunctionHelper.as:292`; `M10/battle/view/ui/DragonTitanTeamView.as:204` |
| 3892 | `STAR_AREA_BATTLE` | star area | [cosmos](../cosmos/README.md) | exit `STARAREA_SCENE` or Space | `CM/battle/handler/BattleResultHandler.as:277` |
| 3893 | `INCREASINGLY_ROAD_BATTLE` | increasingly road | [roads](../roads/README.md) | exit via `IncreasinglyRoadManager` | `M10/battle/view/ui/DragonTitanTeamView.as:211`; `CM/battle/handler/BattleResultHandler.as:132` |
| 3894 | `RUSH_CAMPAIGN_BATTLE` | race against time (rush campaign) | [trials](../trials/README.md) | race view; floor counter | `CM/battle/utils/BattleFunctionHelper.as:305`; `CM/yishi/datas/BattleModel.as:1072` |
| 3895 | `EXPEDITION_BATTLE` | Protection Spirit expedition | [guardians](../guardians/README.md) | child battle, no bar | `CM/yishi/datas/BattleModel.as:532`; `M10/battle/view/ui/BattleUIView.as:1529` |
| 3896 | `CHILD_CAMP_BATTLE` | "Espírito de Proteção à expedição" (ylex) | [guardians](../guardians/README.md) | child battle, no bar | `CM/yishi/datas/BattleModel.as:536`; `M10/battle/view/ui/BattleUIView.as:1930` |
| 3897 | `SHADOW_LAND_BATTLE` | "Terra Sombria" (shadow land) | [trials](../trials/README.md) | reopens shadow land | `CM/battle/utils/BattleFunctionHelper.as:355`; `M10/battle/view/ui/BattleUIView.as:1957` |
| 3898 | `DARK_MAZE_BATTLE` | dark maze | [mazes](../mazes/README.md) | child battle; exit dark maze | `CM/yishi/datas/BattleModel.as:540`; `M10/battle/view/BattleView.as:259` |
| 3899 | `REMAINS_EXPLORE_BATTLE` | "Exploração das Ruínas" | [exploration](../exploration/README.md) | reopens remains explore | `CM/battle/handler/BattleResultHandler.as:481` |
| 3900 | `REMAINS_MIRROR_BATTLE` | ruins mirror | [exploration](../exploration/README.md) | single player | `CM/yishi/datas/BattleModel.as:216`; `CM/battle/handler/BattleResultHandler.as:481` |
| 3901 | `CONSORTIA_NEWBOSS_BATTLE` | new guild boss | [guild](../guild/README.md) | HP sync 4285 | `CM/battle/handler/BattleResultHandler.as:485` |
| 3902 | `ROYALTY_BOSS_BATTLE` | "Caminho da Realeza" | [royalty-boss](../royalty-boss/README.md) | seal skill locked | `CM/battle/view/ui/SkillItemListView.as:197`; `CM/battle/handler/BattleResultHandler.as:489` |
| 3903 | `FORBIDDEN_BOSS_BATTLE` | "Chefão da Zona Proibida" | [forbidden-boss](../forbidden-boss/README.md) | world boss HP rules; HP sync 4297 | `CM/yishi/datas/BattleModel.as:1077`; `CM/yishi/datas/BattleModel.as:864` |
| 3904 | `SECRET_EXPLORE_BATTLE` | secret adventure | [exploration](../exploration/README.md) | exit `SECRET_ADVENTURE_SCENE` | `CM/battle/view/ui/SkillItemListView.as:197`; `CM/battle/handler/BattleResultHandler.as:296` |
| 3905 | `WARSOULTOWER_BATTLE` | "Torre da Guerra" (war soul tower) | [trials](../trials/README.md) | quit button 10497; floor counter | `CM/battle/view/ui/SkillItemListView.as:197`; `CM/yishi/datas/BattleModel.as:1082` |
| 3906 | `FINAL_ROAD_BATTLE` | "Caminho Final" | [roads](../roads/README.md) | seal skill locked | `CM/battle/view/ui/SkillItemListView.as:197`; `CM/yishi/datas/BattleModel.as:1087` |
| 3907 | `THESE_PVP_BATTLE` | Theseus PvP | [theseus-arena](../theseus-arena/README.md) | exit `THESE_PVP_SCENE` | `CM/battle/view/ui/SkillItemListView.as:197`; `CM/yishi/datas/BattleModel.as:1005` |
| 3908 | `SECRET_WAR_BATTLE` | "Batalha do Eremitério" | [hermitage-war](../hermitage-war/README.md) | exit `SECRET_WAR_SCENE` | `CM/battle/handler/BattleResultHandler.as:312`; `CM/battle/handler/BattleResultHandler.as:501` |
| 3909 | `MINOS_BATTLE` | Minos labyrinth | [guild](../guild/README.md) | reopens Minos map | `CM/battle/handler/BattleResultHandler.as:506` |
| 3910 | `CHESS_PVP` | "Duelo Tático" guild chess | [guild](../guild/README.md) | reopens chesspvp | `CM/battle/handler/BattleResultHandler.as:510` |
| 3911 | `CHILD_NS_WAR_BATTLE` | "Arena do Espírito de Proteção" (NS war) | [guardians](../guardians/README.md) | aid icons 25240; 4680; exit Space | `CM/battle/BattleManager.as:164`; `CM/yishi/datas/BattleModel.as:544` |
| 3912 | `THESE_MultiPVP_BATTLE` | Theseus multi PvP | [theseus-arena](../theseus-arena/README.md) | exit `THESE_Double_PVP_SCENE` | `CM/battle/handler/BattleResultHandler.as:309` |
| 3913 | `THESEUS_TOWER` | Theseus tower | [theseus](../theseus/README.md) | exit Space, reopens tower | `CM/battle/handler/BattleResultHandler.as:326`; `CM/battle/handler/BattleResultHandler.as:514` |
| 3914 | `STORE_HOUSE` | "Desafio de Teseus" (store house / thessbox) | [theseus](../theseus/README.md) | extra skill bar `addSkills` | `CM/battle/view/ui/SkillItemListView.as:134`; `CM/battle/handler/BattleResultHandler.as:518` |
| 3915 | `DUNGEONEXPLO` | "Labirinto da Aventura" (dungeon explore) | [theseus](../theseus/README.md) | exit Space, reopens dungeon | `CM/battle/handler/BattleResultHandler.as:325`; `CM/battle/handler/BattleResultHandler.as:522` |

`none` = declared but never referenced by the client: do not use. `unassigned` = the client package (`sandbox`) has no feature in `roadmap/features.json`; suggested owner [sky-realm](../sky-realm/README.md) *(assumption)*. `battle` = debug values owned by this feature.

## 4. Cross-check with other roadmap folders

| Folder | battleTypes it cites | Agreement |
|---|---|---|
| [guild](../guild/README.md) | 296, 309, 3881, 3890, 3901, 3909, 3910 | same owner |
| [theseus](../theseus/README.md) | 3913, 3914, 3915 | same owner |
| [guardians](../guardians/README.md) | 3845, 3847, 3867, 3868, 3889, 3895, 3898, 3911 | same owner except 3898 (dark maze), owned here by [mazes](../mazes/README.md) because the battle starts from `darkmaze.*`; guardians supplies the units |
| [einherjar](../einherjar/README.md) | 35, 3844 | same owner |
| [exploration](../exploration/README.md) | 3864, 3865, 3884, 3899, 3900, 3904 | same owner |
| [trials](../trials/README.md) | 3869, 3872, 3873, 3874, 3875, 3877, 3897, 3905 | same owner |
| [campaign](../campaign/README.md) | 6, 11, 3846, 3848, 3878 | same owner; 16 is also mentioned by `campaign/node-combat.md` (chest frame rules) but the Colosseum owns it |
| [laboratory](../laboratory/README.md) | 3851 | same owner |
| [cosmos](../cosmos/README.md) | 3892 | same owner |
| [ares-battle](../ares-battle/README.md) | 3859 | same owner |
| [venus-battle](../venus-battle/README.md) | 308, 315 | same owner |
| [dragon](../dragon/README.md) | 3860 | same owner |
| [mounts](../mounts/README.md) | 3870 | same owner |
| [planes](../planes/README.md) | 3843 | same owner |
| [ecliptic-palace](../ecliptic-palace/README.md) | 3879 | same owner |
| [royalty-boss](../royalty-boss/README.md) | 3902 | same owner |
| [forbidden-boss](../forbidden-boss/README.md) | 3903 | same owner |
| [world-boss](../world-boss/README.md) | 17 | same owner |
| [world-map](../world-map/README.md) | 1..5, 3841 | same owner |
| [sky-realm](../sky-realm/README.md) | 11 proposed for the hub duel (no dedicated constant) | open: 11 is the campaign multiplayer type; a new duel needs a type absent from the `exitBattle` switch |
| [avenger](../avenger/README.md) | 16, 25, 3844, 3845, 3847, 3864, 3866, 3867, 3868, 3889 | cited only as exclusions of the avenger bar |

## 5. Open questions

1. About 40 mode names are inferred from constant names (no `language.txt` key); they are marked *(assumption)*.
2. Owners of 10, 12, 13, 18, 20, 22, 23, 32, 36, 38, 290, 310..314, 330, 3842, 3852..3854, 3861, 3862, 3876, 3883 are inferred.
3. Features with folders still pending (arena, casino, team, treasures, three-kingdoms, cross-server, athena-battle, theseus-arena, auto-chess, glory-supremacy, hermitage-war, roads, mazes, outyard) should confirm their values when written.
