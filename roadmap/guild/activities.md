# Guild activities: hub and consortiaplay index

Module: `guild::activities`. Client: `CM/mvc/module/consortia/ConsortiaViewHelper.as` (VH), `M6/consortia/view/myConsortia/newui/ConsortiaActivityView.as`, `M6/consortia/view/myConsortia/item/ConsortiaActivityItem.as`.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M6/` = `decompiled/m6/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`. "(A)" marks an assumption.

## Overview

The guild activities hub is tab index 5 of the guild frame `ConsortiaFrame` (`M6/consortia/view/myConsortia/ConsortiaFrame.as:155,194-196`), opened by `ConsortiaControler.showActivityView` -> `openControllerByInfo("consortia",1,5)` (`CM/mvc/controler/ConsortiaControler.as:366-369`); it requires `consortiaID > 0`. It lists one `ConsortiaActivityItem` per activity built by `VH.initActivityData` (VH:68-96), sorted by numeric id. **The hub sends no request of its own**: each entry renders state pushed by the module that owns the activity, and its button opens that module.

The protobuf package `com.road.yishi.proto.consortiaplay` contains two activities:

| Messages | Activity | Spec |
|---|---|---|
| `Minos*` (opcodes C to S 9729, S to C 552..557) | Reino de Minos, weekly guild labyrinth, battleType 3909 | **[minos.md](minos.md)** (authoritative; summary below) |
| `ChessPvp*` (opcodes C to S 9730, 25232, S to C 561..566) | Duelo Tático, guild chess, battleType 3910 | **[chess.md](chess.md)** |

With the current `VersionSwitch` flags (`CM/yishi/datas/VersionSwitch.as`, compile-time constants never reassigned) the visible entries are ids -1, 1, 2, 3, 4, 5, 6.

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `consortia.view.myConsortia.newui.ConsortiaActivityView` | frame title = guild name + "Guilda" (`public.consortia`) | 3-column scroll list of activities | guild frame tab 5 | `VH.activeList` (`ConsortiaActivityView.as:29-100`) |
| `consortia.view.myConsortia.item.ConsortiaActivityItem` | name is a bitmap (frame `id + 3`, `ConsortiaActivityItem.as:175-180`); no language key | icon, `promptTxt`, red badge `redTipNum` (> 0), join button glow `isNeedJoinMc`, animated "open" overlay (`model.getNeedByEffectKey(id)`), hover tip `consortia.view.ConsortiaActivityItem.tipData{id}` (ids 0..6) | hub | `ConsortiaActivityInfo` (`ConsortiaActivityItem.as:146-268`) |

The list is rebuilt on (`ConsortiaActivityView.as:48-100`): secret land `TREE_STATE_UPDATE`, guild model `UPDA_CONSORTIA_INFO` (from 4138), `CampaignEvent.CONSORTIA_BOSS_SWITCH` (4728), `CROSS_GUILD_MAIN_CHANGE` (4573 / 4566).

Hover tips (LANG, verbatim): tipData0 "Modo de jogo ativado pelo presidente ou membros autorizados, oferecendo muitos prêmios."; tipData1 "Modo de jogo ativado pelo presidente da guilda ou membros autorizados, oferecendo muita experiência."; tipData2 "As fases que os jogadores desafiam dão Prata de Moréia que pode ser trocada por prêmios"; tipData3 "Modo de jogo ativado pelo presidente da guilda, necessário consumir fortuna da guilda. Os dentes do terror obtidos poderão ser trocados por itens raros na loja avançada da guilda."; tipData4 "Pode escavar tesouros, retirar prêmios e receber a ajuda de amigos para cavar mais rápido"; tipData5 "Cada temporada dura 2 semanas, os membros criam formações de defesa, ataque e interferência, gerando Medalhas de Fama, Medalhas e Pedra de Coragem"; tipData6 "Pode desafiar outros jogadores com membros da guilda para ganhar mais prêmios".

## Actions

| # | Entry id | Activity | Switch / unlock | Prompt (`promptTxt`) and badges | Click (`gotoFunction`) | Request sent by the click | Owning module |
|---|---|---|---|---|---|---|---|
| H1 | -2 | Duelo Tático | `CHESS_PVP = false` (`VersionSwitch.as:246`): hidden | `beginTime` if signed up, else "Não se inscreveu" (VH:110-126) | `gotoChessPvp` (VH:128-136): `checkScene`, open `chesspvp` | 9730 op 1 (from the lobby) | [chess.md](chess.md) |
| H2 | -1 | Reino de Minos | `MINOS = true` (`:244`) | "Número de desafios restantes: {0}/{1}", {1} = `Minos_ChallengeCount` + buy max = 15, {0} = max(0, {1} - challengeCount); glow if {0} > 0 (VH:352-378) | `gotoMinos` (VH:380-383) -> `SwitchPageHelp.openMinosFrame` (`CM/yishi/SwitchPageHelp.as:1909-1915`): in a guild, `checkScene` | 9729 op 1 (from `MinosEnterFrame`) | [minos.md](minos.md) |
| H3 | 0 | Chefão da Guilda (new boss) | `CONSORTIA_NEW_BOSS = false` (`:216`): hidden | "Em andamento" when active (VH:446-475) | `consortianewboss` | | PvE boss module |
| H4 | 1 | Yggdrasil da Guilda (secret land) | always | "Yggdrasil da Guilda aberta" / "Yggdrasil da Guilda ainda não aberta" (VH:138-153); overlay when `treeState == 1` | `gotoSecret` (VH:155-167): mopup check ("Modo Bot em andamento"), `checkScene` | C to S 8537 `C_ENTER_CONSORTIA_FAM`, empty, client throttle 5 s ("Clique excessivo, tente novamente") (`CM/managers/ConsortiaSocketOutManager.as:263-273`) | secret land module |
| H5 | 2 | Guild dungeon (guildfb) | always | "Número de desafios restantes: {0}/{1}" with `consortia_pve_count`; badge = claimable rewards (VH:385-410) | `openGuildFbFrame` (`SwitchPageHelp.as:1901-1907`) | 8554 (from that controller) | PvE dungeon module |
| H6 | 3 | Terra dos Sonhos (boss) | always; guild level >= 5 (VH:249) | below level 5 "Ativada quando a guilda atinge o nível {0}"; else `emeDreamPromptTxt{state}`; link "Invocar BOSS" (right index 1) or "Ver drops" (VH:245-270) | VH:282-326: mopup, state 1/2, `checkScene`, daily-cap confirm "Já obteve todos os ganhos de hoje. Confirma que deseja continuar?" | C to S 8847 `C_CONSORTIA_BOSS_CALL` `ConsortiaMsg {upgrade_type: 2}` | PvE boss module |
| H7 | 4 | Tesouro da Guilda | always | "Excavações restantes: {0}"; badge = treasures to claim (VH:328-345) | `showTreasureFrame(7)` -> consortia openType 11 | 9629 (from that frame) | treasure module |
| H8 | 5 | Defesa de Guilda | `CROSS_GUILD = true` (`:132`) | war.md rule R3; overlay at state 6 | `openCrossGuildHandler` (VH:206-243) | none or 8650 opType 6 | [war.md](war.md), [cross-server-war.md](cross-server-war.md) |
| H9 | 6 | Caçada da Guilda | `GUILD_WANTED = true` (`:186`); guild level >= 10 (VH:423) | below level 10 "Ativada quando a guilda atinge o nível {0}"; else "Número de desafios restantes: {0}/{1}" of 10 (VH:417-444) | `openGuildWantedFrame` (`SwitchPageHelp.as:1917-1923`) | 8365 (from that controller) | guild wanted module |

Common precondition `SwitchPageHelp.checkScene()` (`SwitchPageHelp.as:1883-1899`): fails inside PVE/PVP/ARESLORDS/UNREAL_SHOOTING/APEX rooms or the GLORY scene with "Você está dentro de uma sala, não é possível realizar essa ação".

Item controls (`ConsortiaActivityItem.as`): join button -> `gotoFunction` (null = locked, nothing happens; the first click clears the "open" glow for that id, :146-158); `operateText` link -> `operatingFun` (:160-166); `shopBtn` only for id 0 while a new boss is active (:119-144,195-201). `ConsortiaActivityInfo.isEnabled` is set but never read.

## Server messages

The hub consumes, without its own handlers, the state pushed for each entry:

| Entry | Opcode(s) that feed it | Reference |
|---|---|---|
| -1 Minos | 556 `U_C_MINOS_PLAYER_DATA` (`MinosPlayerMsg.challengeCount`, `CM/managers/MinosManager.as:114-126`) | minos.md |
| 1 Yggdrasil | 4453 `U_C_FAM_INFO`, 4432 `U_C_FAM_TREE` (`CM/yishi/manager/ConsortiaManager.as:1089-1141`) | secret land |
| 2 guildfb | 260 `U_C_PLAYER_EXTRA_FIELD_MSG` field 21 (`CM/yishi/manager/BaseManager.as:956-959`) | dungeon |
| 3 Terra dos Sonhos | 4138 `ConsortiaInfoMsg.boss_info` (#65), 4728 `U_C_CONSORTIA_BOSS_START` (`ConsortiaManager.as:228-255,457-475`) | boss |
| 4 Treasure | 390 `U_C_CONSORTIA_TREASURE` (`ConsortiaManager.as:579-586`) | treasure |
| 5 Defesa de Guilda | 4573, 4566 | war.md |
| 6 Caçada | 199 `U_C_CONSORTIA_WANT_RESP` (`CM/yishi/manager/GuildWantedManager.as:68-85`) | guild wanted |

## Rules and formulas

| # | Rule | Source |
|---|---|---|
| Q1 | Entries are sorted by id; hidden entries depend only on compile-time `VersionSwitch` flags | VH:68-96 |
| Q2 | Unlock by guild level: Terra dos Sonhos >= 5, Caçada >= 10 | VH:249,423 |
| Q3 | Minos hub counter cap = 10 base + 5 buyable = 15 (differs from the in-map count, which uses actual buys) | VH:352-378; minos.md |
| Q4 | Client bug: 4728 sets `openEffectDic[5]` instead of `[3]` (overlay on Defesa de Guilda instead of Terra dos Sonhos) | `ConsortiaManager.as:247-249` |
| Q5 | The server must push each owning module's state at login / guild join so the hub is correct without opening each activity (A) | |

## consortiaplay summary: Reino de Minos

Authoritative spec: **[minos.md](minos.md)** (screens, rules, templates, tables `guild.minos_*`, handlers `guild::minos::*`). Protocol summary for cross-checking:

- C to S **9729 (0x2601) `C_MINOS_CLIENT_OP`**, `player.PlayerOpMsg` {`op` (#1, INT32), `type` (#2, INT32, difficulty 1..4), `id` (#5, INT32, node x or reward id), `index` (#6, INT32, level id or reward template id), `pos` (#19, INT32, node y)}; unset fields are sent as -1. Sender `MinosManager.doSomething` (`CM/managers/MinosManager.as:216-226`). Ops (`CM/mvc/module/minos/MinosConst.as:6-20`): 1 OPEN, 2 CLOSE, 3 ENTER level, 4 LEAVE level, 5 FIGHT, 6 NODE_REWARD, 7 FEAT_REWARD, 8 BUY_COUNT.
- S to C (receivers `MinosManager.as:53-214`): **552** (0x0228) `MinosDataMsg` {`seasonId` #1, `state` #2, `beginTime` #3, `endTime` #4, `levels` #5}; **553** (0x0229) `MinosLevelMsg` {`id` #1, `progress` #2, `progressMax` #3, `killNpc` #4, `npcMax` #5, `killBoss` #6, `bossMax` #7, `killInfo` #8 STRING}; **554** (0x022A) and **555** (0x022B) `MinosMapMsg` {`id` #1, `nodes` #2 `MinosNodeMsg` {`x` #1, `y` #2, `id` #3, `isOpen` #4, `progress` #5}} (555 is decoded as `MinosMapMsg`, not `MinosNodeUpdateMsg`); **556** (0x022C) `MinosPlayerMsg` {`challengeCount` #1, `buyCount` #2, `levelRewardInfo` #3 STRING, `featRewardInfo` #4 STRING, `feat` #5}; **557** (0x022D) `MinosRankListMsg` {`ranks` #1 `MinosRankMsg` {`userId` #1, `nickName` #2, `fightPower` #3, `vipGrade` #4, `feat` #5}}.
- Battle: op 5 starts battleType **3909** `MINOS_BATTLE` with enemies from `MinosNodeTmpls` (Heroes/Pawns of the chosen grade); exit flag `isMinosMap` (`CM/battle/handler/BattleResultHandler.as:506-509`) reopens the map frame.
- Config: `Minos_ChallengeCount` 10, `Minos_ChallengePrice` "5,100", `Minos_CloseTime` 390, `Minos_Opendays` 7. Templates `MinosLevelTmpls`, `MinosNodeTmpls`, `MinosRewardTmpls` (`CM/yishi/manager/TempleteManager.as:1412-1414`). Currency "Pontos Minos" (item -21000, currency 65), shop 1029.

## Templates

The hub reads none directly. Configs used by prompts: `Minos_ChallengeCount`, `Minos_ChallengePrice`, `consortia_pve_count`, `consortia_treasure_Count` (`TPL/ConfigInfos.xml`). Activity templates belong to their modules.

## Persistent state

None owned by the hub. Each prompt is derived from the owning module's state (minos.md `guild.minos_player`, war.md `guild.war_registration` and `guild.war_season`, chess.md `guild.chess_entry`, and the boss, dungeon, treasure, secret land and wanted modules).

## Backend implementation notes

- No request opcode belongs to the hub, so there is no `guild::activities::handle_*` handler. Provide `guild::activities::push_login_state(user_id)` that calls each owning module's login push in one place: 556 (minos), 4573 (war), 4453/4432 (secret land), 390 (treasure), 199 (wanted), 260 field 21 (dungeon), 4138 boss info (core).
- Call it on login and after a membership change (117) so the hub badges and counters are correct (A).
- Feature flags on the server must mirror the client `VersionSwitch` values (CHESS_PVP off, CONSORTIA_NEW_BOSS off, MINOS, CROSS_GUILD, GUILD_WANTED on), so hidden activities are never scheduled.
- No battles, schedules or tables in this module.

## Open questions

1. pt-BR names of entries -1 and 2 exist only as bitmaps; names used here come from module help texts.
2. `ConsortiaViewHelper.crossGuildInfo.openConsortiaNewBossTips` (id 0 prompt) is missing from `index/language.json` (entry hidden anyway).
3. Whether the server should push all activity states at login (proposed yes) or lazily on guild frame open.

### Activity reward explanation

`ConsortiaActExplanationFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaActExplanationFrame.as`, pt-BR title "Descrição da recompensa") is the popup opened from an activity entry to explain its reward table. It is a plain `Frame` fed the activity id and shows the drop description of the corresponding module.

## Implementation checklist

Client (present, verify):
- [ ] ConsortiaActivityView rebuild on the four events
- [ ] ConsortiaActExplanationFrame reward popup per activity id
- [ ] ConsortiaActivityItem prompt, badge, glow, overlay, hover tip per entry H1..H9
- [ ] Entry clicks route to the owning modules

Backend:
- [ ] `guild::activities::push_login_state` aggregating owning-module pushes
- [ ] Server feature flags mirroring `VersionSwitch`
- [ ] Owning modules implemented: minos.md, war.md, cross-server-war.md, chess.md (and the non-PvP modules for ids 1, 2, 3, 4, 6)
