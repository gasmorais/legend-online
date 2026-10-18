# Time Vortex ("Vórtice do Tempo")

Area: trials, module `time-vortex`. Client package `timevortex` (`decompiled/m11/scripts/timevortex`), manager `managers.TimeVortexManager`, model `mvc.module.timevortex.TimeVortexModel`, controller key `timevortex`, proto packages `timevortex` (team) and `battle` (`TimeVortexListMsg`, `TimeVortexInfoMsg`), plus `dragontalker.DragonTalkerNodeMsg` for the dragon nodes. Sweeps use the generic [mopup](../mopup/README.md) route with `sweep_type = 3`.

Path aliases:

| Alias | File |
|---|---|
| TVM | `decompiled/core_module/scripts/managers/TimeVortexManager.as` |
| TVMOD | `decompiled/core_module/scripts/mvc/module/timevortex/TimeVortexModel.as` |
| TVC | `decompiled/core_module/scripts/mvc/controler/TimeVortexController.as` |
| TVF | `decompiled/m11/scripts/timevortex/TimeVortexFrame.as` |
| CHF | `decompiled/m11/scripts/timevortex/TimeVortexChallengeFrame.as` |
| CRF | `decompiled/m11/scripts/timevortex/TimeVortexCrackFrame.as` |
| V | `decompiled/m11/scripts/timevortex/view/` |

## 1. Overview

Three parts in one frame:

1. Dragon nodes (tab 0): five "Encantador de Dragões" opponents with 20%, 40%, 60%, 80% and 100% of their strength (`V/TimeVortexDragonItemView.as:23`). Beating all five opens the vortex map and unlocks the Dragon Talker form ([dragon](../dragon/README.md)). Battle type 3875 `DRAGONTALKER_NODE`.
2. Vortex map (tab 1): 45 positions (campaign templates `Types = 26`, ids 50001..50062, 7 chapters `DungeonId` 101..107). Each position has a boss (battle 3873 `TIMEVORTEX_BATTLE`, first clear unlocks the next position by `PreCampaignId`) and can be conquered as "líder" (laird) by beating the current laird (PvP mirror battle 3874 `TIMEVORTEX_BATTLE_PLAYER`, 8 minutes limit). Lairds earn hourly and final rewards while they hold the position. A dethroned laird can take revenge within 1 hour. Daily challenges: 10 plus the returning player bonus (`TVMOD.challengeMax`, `TVMOD:85-89`). Cleared bosses can be swept.
3. Cracks ("Cisão no Vórtice do Tempo"): every hour at minute 5 a crack appears on a position that has a laird; players who passed that position see it and fight the crack leader (the laird with bonus attributes) alone or as a team (battle 3872 `TIMEVORTEX_CRACK_BATTLE`). 2 rewarded wins per day per player (`time_crack_get_count`), the laird gets up to 10 defense rewards (`time_crack_defens_count`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `timevortex.TimeVortexFrame` (`TVF`), 945 x 550 | tabs dragon / vortex | Container; tab 1 disabled until `openDragon` ("O Encantador de Dragões não foi ativado, esta função não foi ativada.", `TVF:140-174`) | controller `timevortex` openType 0 or 1 (`TVC:61-70`); `SwitchPageHelp.openTimeVortexFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2414-2433`): changed job required; openType 1 when `openDragon`; reopened after 3872..3875 battles (`decompiled/m3/scripts/map/space/SpaceSceneController.as:318-320`) | 4842 |
| `V/TimeVortexDragonView` + `TimeVortexDragonItemView` x 6 | tips "Desafiar um Encantador de Dragões com {0}% da sua força", "Se vencer todos os Encantadores de Dragões este sistema será ativado." | Pick the next uncleared dragon node, challenge button | tab 0 | `dragonOpenInfo` |
| `V/TimeVortexAreaView` + `TimeVortexMapView` + `TimeVortexPointView` + `TimeVortexCrackView` | "{0}/{1}" challenges left | Chapter map with positions, laird avatars, crack markers, prev/next chapter | tab 1; sends op 1 and op 7 on open (`V/TimeVortexAreaView.as:52-59`), polls op 2 and op 7 every 20 s (`V/TimeVortexMapView.as:179-203`) | 4837, 4838, 4839 |
| `timevortex.TimeVortexChallengeFrame` (`CHF`), 586 x 553 | boss name, laird name, occupation timer "{0}:{1}:{2}", revenge timer | Boss fight, boss sweep, laird fight, laird revenge, reward previews (first, repeat, hourly, final) | position click (`V/TimeVortexPointView.as:240-242` -> `TVC.openChallengeFrame` `TVC:97-102`); polls op 2 every 2 s while a laird or revenge exists (`CHF:747-772`) | 4837 |
| `timevortex.TimeVortexCrackFrame` (`CRF`), 776 x 493 | "Cisão no Vórtice do Tempo" | Crack leader, team list with rewards left, fight, rewards (crack and defend), help | crack marker click (`V/TimeVortexCrackView.as:130-136`) or 4840 (`TVM:146-181`) | 4840 |
| `timeOutInviteFrame` style `timevortex.TimeOutInviteFrame` | "Aviso": "Ocorreu uma cisão no Vórtice do Tempo. Deseja desafiar o líder da cisão juntamente com o líder da equipe?" (10 s) | Team member confirmation | 4841 when not captain (`TVM:114-144`) | none |
| `mopup.view.TimeVortexMopupPrepareFrame` / `TimeVortexMopupIngFrame` | | Boss sweep | boss "Modo Bot" (`CHF:480-491`) -> controller `mopup` openType 11, 12 | 4425 |

## 3. Routes (client to server)

Main route: send 9664 (0x25c0) `C_TIMEVORTEX_CLIENT_OP` with `simple.PropertyMsg`: `param1` (#1, INT32) operation, `param2` (#2, INT32) campaign id or index, `param3` (#3, INT32), `param10` (#10, INT32). Operation constants in `TVM:43-61`.

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| T1 | Vortex tab open, map poll | `TVM.lookUp` (`TVM:433-439`) | none | `param1 = 1` | 4838 batches (or 4837) with all positions |
| T2 | Challenge frame open and polls; map poll | `TVM.lookUpSingle(campaignId)` (`TVM:441-448`) | none | `param1 = 2`, `param2` campaign id | 4837 with one position |
| T3 | Boss "Desafiar" | `TVM.challengeBoss` (`TVM:450-457`) from `CHF:493-503`, `:517-521` | when already cleared and `timeVortexCount >= challengeMax`: "Não possui desafios restantes suficientes." | `param1 = 3`, `param2` campaign id | battle 3873; after: player info 3 (`time_vortex_count` #143, `time_vortex_node` #144), 4837 |
| T4 | Laird "Desafiar" | `TVM.challengeLaird` (`TVM:459-466`) from `CHF:399-471`, `:511-515` | boss of the position cleared ("Tem de derrotar o Chefão da posição primeiro."); not own position ("Esta posição já foi conquistada. Não é possível voltar a conquistar."); if a revenge is pending confirm `TipsTxt07` (losing the revenge countdown); if the player already holds another position confirm `TipsTxt02` (losing it) | `param1 = 4`, `param2` campaign id | battle 3874 against the laird mirror; 4837 with the new laird |
| T5 | Laird "Vingança" | `TVM.revengeLaird(id, useDiamonds, useBind)` (`TVM:468-487`) from `CHF:346-397` | boss cleared; position has a laird ("Esta posição ainda não foi conquistada por ninguém..."); not self; a revenge is pending and is for this position (`timeVortexRevenge == campaignId`, else "Esta posição não pode ser vingada." / "A vingança apenas poder ser realizada no tempo de vingança."); confirm "Deseja vingar-se, para recuperar 100% do tempo de duração da conquista desta posição? Por cada tentativa de vingança serão deduzidos 20 minutos da Contagem regressiva da Vingança." with option "Utilizar {0} diamantes para reduzir a contagem regressiva da vingança em 20 minutos" (cost = 100 x (chapter - 100), `decompiled/core_module/scripts/mvc/module/selectcampaign/CampaignChapterInfo.as:171-191`) and bound diamonds checkbox | `param1 = 9`, `param2` campaign id, `param3` 1 = diamond option checked (assumption: pays diamonds instead of deducting 20 minutes from the revenge window), `param10` 1 = use bound diamonds | battle 3874; 4837 |
| T6 | Crack "Desafiar" | `TVM.challengeCrack` (`TVM:489-496`) from `CRF:272-321` | challenger (or a team member) is not the crack leader ("Um membro da equipe e o líder da cisão são a mesma pessoa..."); solo: confirm "O líder é demasiado forte, é aconselhável desafiar em equipe..."; in a team only the captain ("Quando em equipe é preciso a confirmação do líder para começar o combate.") | `param1 = 5`, `param2` campaign id | team: 4841 to members and captain; when all ready battle 3872; solo: battle 3872 |
| T7 | Crack frame open | `TVM.lookUpCrackSingle` (`TVM:498-505`) from `CRF:114`, `CRF:426`, `V/TimeVortexCrackView.as:134` | none | `param1 = 6`, `param2` campaign id | 4840 team list |
| T8 | Map open and poll | `TVM.lookUpCrack` (`TVM:507-513`) | none | `param1 = 7` | 4839 crack list |
| T9 | Member accepts crack invite | `TVM.teamReady` (`TVM:515-521`) from `TVM.teamReadyCallBack` (`TVM:138-144`) | in space scene and not sweeping (`TVM:120`) | `param1 = 8` | 4841 to captain (wait list), then battle 3872 |
| T10 | Dragon "Desafiar" | `TVM.changeDragonIndex(index)` (`TVM:523-530`) from `V/TimeVortexDragonView.as:131-134` | button enabled while some node is uncleared; index = first uncleared node 1..5 (`V/TimeVortexDragonView.as:80-109`) | `param1 = 10`, `param2` node index | battle 3875; then 4842 |
| T11 | Boss sweep | `MopupManager.sendMopupInfo(3, op, campaignId, count, ...)` (`decompiled/m5/scripts/mopup/view/TimeVortexMopupPrepareFrame.as:253`, `TimeVortexMopupIngFrame.as:410`, `:444`, `:465`, `:612`) | gold >= `TimeVortex_Sweep_Gold x count` ("Ouro insuficiente"); count <= challenges left | send 8528 (0x2150) `C_CAMPAIGN_SWEEP`, `campaign.CampaignSweepReq`: `sweep_type` (#1) 3, `op_type` (#2) 1 start / 2 accelerate / 3 cancel / 4 close, `campaign_id` (#3), `count` (#4), `pay_type` (#9) | 4425 `U_C_CAMPAIGN_SWEEP` (see [mopup](../mopup/README.md)) |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 4837 (0x12e5) `U_C_TIMEVORTEX_INFO` | `battle.TimeVortexListMsg`: `vortexList` (#1, repeated `TimeVortexInfoMsg`); `revengeNodeId` (#13, INT32) position the player may revenge (0 none); `revengeTime` (#14, STRING `YYYY-MM-DD hh:mm:ss`) start of the revenge hour. `TimeVortexInfoMsg`: `campaignId` (#1, INT32); `uuid` (#2, STRING) laird uuid; `userId` (#3, INT32) laird id, 0 = no laird; `nickName` (#4, STRING); `serverName` (#5, STRING); `occupyTime` (#6, STRING) conquest time; `param1..3` (#7..#9, STRING), `param4..6` (#10..#12, INT32) opaque; `fashionArm` (#13), `fashionWing` (#14), `fashionCloth` (#15), `fashionHair` (#16), `fashionHat` (#17), `arm` (#18) avatar parts (STRING); `templateId` (#19, INT32); `job` (#20, INT32); `sexJob` (#21, INT32) hero template for the avatar (0 = no avatar) | `TVM.__timeVortexInfoHandler` -> `timeVortexInfoHandler` (`TVM:272-358`): updates area info, clears the previous position of a laird who moved (`_preLairdDic`), tracks `timeVortexCapture` (own position) | Reply to T2 (one entry); push after a conquest |
| 4838 (0x12e6) `U_C_TIMEVORTEX_BATCH_INFO` | same message with `uuid` (#4, STRING) batch id and `param1` (#5, INT32) total entries; client concatenates pages with the same `uuid` until `vortexList.length == param1` (`TVM:237-270`) | `TVM.__timeVortexBatchInfoHandler` | Reply to T1, possibly in several packets |
| 4839 (0x12e7) `U_C_TIMEVORTEX_CRACK_INFO` | same message, `crackList` (#12, repeated `TimeVortexInfoMsg`: crack position and leader) | `TVM.__timeVortexCrackInfoHandler` (`TVM:188-235`): rebuilds crack markers; `timeVortexCrack` = own crack position | Reply to T8; push at each hourly crack refresh (assumption) |
| 4840 (0x12e8) `U_C_TIMEVORTEX_CRACK_TEAM_INFO` | `timevortex.TimeVortexTeamMsg`: `teamList` (#1, repeated `TeammatesInfoMsg`: `userId` (#1), `nickName` (#2), `fightPower` (#3), `leftCount` (#4) crack rewards left today, `param1` (#5, STRING), `param2` (#6, INT32), `param3` (#7, STRING)); `param1..5` (#2..#6) unused | `TVM.__timeVortexCrackTeamInfoHandler` (`TVM:146-181`): fills `teamInfo`, opens the crack frame if closed | Reply to T7 (self or whole team) |
| 4841 (0x12e9) `U_C_TIMEVORTEX_CRACK_TEAM_READY` | `PropertyMsg` (fields not read) | `TVM.__timeVortexCrackTeamReadyHandler` (`TVM:114-136`): captain -> wait view (`RECEIVE_WAIT_INFO`); member in space -> 10 s invite | After T6 by a captain, after each T9 |
| 4842 (0x12ea) `U_C_DRAGONTALKER_NODE` | `dragontalker.DragonTalkerNodeMsg`: `dragontalker1..5` (#1..#5, INT32) 0 = node not cleared; `op` (#6), `param1` (#7) unused | `TVM.__dragonOpenInfoHandler` (`TVM:101-112`); `openDragon` = all five non zero (`TVMOD:237-252`) | Login and after each 3875 battle |
| 3 `U_C_PLAYER_INFO` (owned by [hero](../hero/README.md)) | `player.PlayerMsg`: `time_vortex_count` (#143, INT32) boss challenges used today; `time_vortex_node` (#144, INT32) highest boss cleared (campaign id) | `PlayerManager.__uPlayerInfoHandler` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1185-1192`); node change rebuilds `CampaignRankManager.timeVortexRankDic` (cleared chain) (`decompiled/core_module/scripts/yishi/manager/CampaignRankManager.as:90-112`) | Login and after boss fights, daily reset |

## 5. Rules and formulas

- Positions: `Campaigns.xml` rows with `Types = 26`, `LandId = 1`, `DungeonId` 101..107 (chapters), `AreaId`, `PreCampaignId` chain, `MapIds` = `bossHeroTemplateId,count`, `PosX/PosY` map coordinates (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2578-2599`, `decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:73-90`).
- Position unlock: a position is challengeable when its `PreCampaignId` is cleared (`V/TimeVortexPointView.as:310`); cleared set = chain from `time_vortex_node` back through `PreCampaignId`.
- Boss challenges per day: `10 + OldPlayerReturnManager.model.timeVortexCount` (`TVMOD:85-89`); only repeat fights of cleared bosses are limited by the client check, but the server should count every boss fight (assumption). Reset 0:00.
- Laird: one position per player; conquering a new one drops the old (`TipsTxt02`). Fight time 8 minutes, loss on timeout (`lairdFightBtn.tipdata`).
- Revenge: after losing a position the player gets `revengeNodeId` and `revengeTime`; window 3600 s from `revengeTime` (`CHF:705-740`); each attempt costs 20 minutes of the window, or the diamond cost (100..700 by chapter) to keep the time; success restores 100% of the original occupation time (`TipsTxt08`).
- Rewards (`TimeVortexRewards.xml`, `RewardType`, `TVMOD:20-30`): 1 first boss clear, 2 repeat boss clear, 3 hourly laird reward, 4 final laird reward (`TimeVortex_Hour_Count = 12` is marked obsolete), 5 crack win (by chapter `CampaignId` 101..107), 6 crack defense (by chapter).
- Cracks (help `timevortex.TimeVortexCrackFrame.helpContent`): new crack every hour at :05 on a position with a laird; visible to players who passed it; team members who are not in the Reino dos Céus count as refusing; 2 rewarded wins per day (`time_crack_get_count`), reset 0:00; leader gets attribute bonus; laird rewarded per successful defense up to 10 (`time_crack_defens_count`).
- Sweep: `TimeVortex_Sweep_Time = 60` s per run, `TimeVortex_Sweep_Gold = 500000` per run, accelerate `Sweep_Fast = 1,10` (diamonds per minutes).
- Dragon nodes: 5 nodes, strength 20..100%; `openDragon` gates the vortex tab and the Dragon Talker.
- Unlock: changed job (`vocationGrades > 0`); entry points: daily guide type 86 (`decompiled/core_module/scripts/managers/DayGuideManager.as:939-940`), space NPC dialog option 131 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:788-789`), queue bar item 6 (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:345`, `:434-441`), daily queue text "Vórtice do Tempo {0}/{1}".

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/Campaigns.xml` (`Types = 26`, 45 rows) | position | `CampaignId`, `CampaignName`, `LandId`, `DungeonId`, `AreaId`, `PreCampaignId`, `PosX`, `PosY`, `MapIds`, `NeedTransfer`, `SonTypes` |
| `raw/xml/tempinfos/TimeVortexRewards.xml` (201 rows) | reward | `Index`, `CampaignId` (position or chapter 101..107 for types 5, 6), `RewardType` 1..6, `TemplateId`, `Count` |
| `raw/xml/tempinfos/GameHeroTemp.xml` | boss name | `TemplateName` of `MapIds` first value |
| `raw/xml/tempinfos/ConfigInfos.xml` | `time_crack_get_count = 2`, `time_crack_defens_count = 10`, `TimeVortex_Sweep_Time = 60`, `TimeVortex_Sweep_Gold = 500000`, `TimeVortex_Hour_Count = 12`, `Sweep_Fast = 1,10` | |

## 7. Persistent state

```sql
CREATE TABLE trials.time_vortex_state (
    player_id            integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    highest_node         integer     NOT NULL DEFAULT -1,
    challenges_used      smallint    NOT NULL DEFAULT 0,
    crack_wins_today     smallint    NOT NULL DEFAULT 0,
    daily_date           date        NOT NULL DEFAULT current_date,
    dragon_nodes         smallint[]  NOT NULL DEFAULT '{0,0,0,0,0}',
    revenge_campaign_id  integer     NOT NULL DEFAULT 0,
    revenge_started_at   timestamptz,
    revenge_seconds_left integer     NOT NULL DEFAULT 0
);

CREATE TABLE trials.time_vortex_position (
    campaign_id     integer     PRIMARY KEY,
    laird_id        integer     REFERENCES player.players(player_id) ON DELETE SET NULL,
    laird_uuid      text,
    occupied_at     timestamptz,
    hours_paid      smallint    NOT NULL DEFAULT 0,
    defense_count   smallint    NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX time_vortex_position_laird_uq ON trials.time_vortex_position (laird_id) WHERE laird_id IS NOT NULL;

CREATE TABLE trials.time_vortex_crack (
    crack_id        bigserial   PRIMARY KEY,
    campaign_id     integer     NOT NULL REFERENCES trials.time_vortex_position(campaign_id),
    leader_id       integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    opened_at       timestamptz NOT NULL,
    closed_at       timestamptz,
    defense_wins    smallint    NOT NULL DEFAULT 0
);
CREATE INDEX time_vortex_crack_open_idx ON trials.time_vortex_crack (closed_at) WHERE closed_at IS NULL;

CREATE TABLE trials.time_vortex_battle_log (
    id              bigserial   PRIMARY KEY,
    player_id       integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    campaign_id     integer     NOT NULL,
    kind            smallint    NOT NULL CHECK (kind IN (1, 2, 3, 4, 5)),
    won             boolean     NOT NULL,
    fought_at       timestamptz NOT NULL DEFAULT now()
);
```

`kind`: 1 boss, 2 laird, 3 revenge, 4 crack, 5 dragon node.

## 8. Backend implementation notes

- Handlers: `trials::time_vortex::handle_look_up` (1), `handle_look_up_single` (2), `handle_challenge_boss` (3), `handle_challenge_laird` (4), `handle_challenge_crack` (5), `handle_look_up_crack_single` (6), `handle_look_up_crack` (7), `handle_team_ready` (8), `handle_revenge_laird` (9), `handle_dragon_challenge` (10). Sweep goes through `mopup::handle_campaign_sweep` with sweep type 3.
- Boss fight: validate `PreCampaignId` cleared, challenges left; battle 3873 with `MapIds` boss; on first clear set `highest_node`, grant reward type 1, else type 2; increment `challenges_used`; push 3 (player info fields 143, 144) and 4837.
- Laird fight: battle 3874 against a mirror of the laird (formation snapshot); on win transfer the position (`laird_id`, `occupied_at = now`), release the challenger's old position, give the previous laird a revenge window (`revenge_campaign_id`, `revenge_started_at`), push 4837 to the viewers (the 2 s polling covers the rest).
- Revenge: validate window, then either deduct 20 minutes from the window or charge diamonds (`param3 = 1`, bound if `param10 = 1`); on success restore the position with the original occupation duration.
- Scheduler: every hour pay reward type 3 to each laird (by mail or bag, assumption); at the final settlement time pay type 4 (time unknown, open question); every hour at :05 close the open cracks and open a new crack on a random position with a laird (assumption: one crack per chapter), push 4839 to online players in the vortex.
- Crack fight: team flow uses the [team](../team/README.md) membership: captain T6 -> 4841 to members in space -> T9 from each -> start battle 3872 with all ready members; reward type 5 to members with `crack_wins_today < 2`; on a leader win increment `defense_count` and pay type 6 up to 10.
- Daily reset at 0:00: `challenges_used = 0`, `crack_wins_today = 0`.

## 9. Open questions and assumptions

- Final laird reward schedule (`RewardType 4`) is unknown (daily or weekly).
- Number of simultaneous cracks per hour and position choice are unknown.
- `param1..6` of `TimeVortexInfoMsg` and `TeammatesInfoMsg.param1..3` are opaque to the client.
- Whether the first boss clear consumes a daily challenge.
- Battle maps for 3872..3875 are not in the client templates.

## 10. Implementation checklist

- [ ] Template loaders: vortex campaigns (`Types 26`), `TimeVortexRewards.xml`, config keys
- [ ] Tables `trials.time_vortex_state`, `time_vortex_position`, `time_vortex_crack`, `time_vortex_battle_log`
- [ ] T1, T2, T8 queries with 4838 paging, 4837, 4839
- [ ] T3 boss fight 3873 and player info fields 143, 144
- [ ] T4 laird fight 3874 and position transfer
- [ ] T5 revenge with time or diamond cost
- [ ] T6, T7, T9 crack team flow (4840, 4841) and battle 3872
- [ ] T10 dragon node fights 3875 and 4842
- [ ] T11 sweep type 3 via mopup
- [ ] Hourly laird rewards, crack scheduler, daily reset
- [ ] Tests: unlock chain, one position per laird, revenge window, crack reward limits
