# Sky Trial ("Caminho do Céu")

Area: trials, module `sky-trial`. Client package `skyboxroad` (`decompiled/m11/scripts/skyboxroad`), manager `managers.SkyboxRoadManager`, model `mvc.module.skyboxroad.SkyboxRoadModel`, controller key `skyboxroad`, scene `SKYBOX_ROAD_SCENE`, proto package `skytrial` (plus `battle.SkyTrialPointMsg` for the stay points). Internal Chinese name 天穹之径; it replaced the legacy "Caminho do Paraíso" ([single-pass.md](single-pass.md)) and reuses its opcodes 8636 and 4552.

Path aliases:

| Alias | File |
|---|---|
| SBM | `decompiled/core_module/scripts/managers/SkyboxRoadManager.as` |
| SBMOD | `decompiled/core_module/scripts/mvc/module/skyboxroad/` |
| SB | `decompiled/m11/scripts/skyboxroad/` |

## 1. Overview

A layered exploration scene. Each layer (`SkyTrialLayerTempInfos`, 20 layers) has 5 or 6 portals ("Reino do Fogo", "Reino de Água", ...; 90 portals). Inside a portal the player explores ("pesquisar") spending action points ("movimento", 20 per search); each search triggers a random event (reward, buff skill, action points, monster, big bonus) and gives search points. At 100% exploration (`TotalSearchCount` searches, 10) the portal boss can be challenged (battle type 293 `SINGLE_PASS`); clearing the boss gives the portal clear reward; clearing all portals of a layer opens the next layer and gives the layer reward. Search points buy battle skills (up to 5) and pay for a helper hero (75% of the player attributes) in boss fights. Action points reset daily at 0:00 (max 500) and can be bought 3 times per day.

A stay point ("Ponto de estação", "Eremitério do Céu") sub-system with occupation timers and weekly time ranking exists in the client but is hidden by `VersionSwitch.SKYBOX_ROAD_POINT = false` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:176`); it is documented in section 3.2 for completeness.

Help (`skyboxroad.helpTxt`): one search per stage gives rewards; at 100% the boss can be challenged; searching consumes movement points reset daily at 0h, purchasable with diamonds or bound diamonds; searching yields search points used to buy skills and summon helpers against the boss.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `skyboxroad.SkyBoxRoadFrame` (`SB/SkyBoxRoadFrame.as`), scene `SKYBOX_ROAD_SCENE` | note "Obs.:Poder de movimentação é redefinido às 0h diariamente..." | Layer view with portals, layer up/down (client paging, `:509-525`), buy action points, rank button (hidden) | `SBM.getData` (`SBM:198-213`) from space NPC dialog option 14 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:374-375`); after a 293 battle (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:127-131`) | 4552 |
| `SB/view/SkyBoxRoadView` + `SkyBoxRoadCheckPointView` | "Ao pesquisar até 100%, poderá desafiar o chefão" | Portals of a layer with progress, clear mark | frame | layer and portal info |
| `SB/view/SkyboxRoadExploreView` | progress tip "O progresso de pesquisa ao atingir 100% poderá desafiar Chefão" | Search x1, search x10 ("explore all"), challenge boss, return, stay point button (hidden) | portal click (`SkyBoxRoadCheckPointView.onFindBtnClick` `:163-172` then op 3) | portal info, events |
| `SB/view/SkyBoxRoadRightView` + `SkyboxRoadSkillItem` | "Obteve o aumento do efeito:", "O efeito do Buff diário é resetado diariamente", "Convocar auxílio para desafiar Chefão" | Energy, search points, buffs, skill shop (3 skills), helper toggle, help | scene | `SkyTrialInfoMsg` |
| `SB/view/SkyBoxRoadCleanPortaFrame` | "Prêmio de conclusão": "Prêmios recebidos" | Portal clear rewards | 4996 (`SBM:340-353`) | portal clear reward |
| `SB/staypoint/SkyBoxRoadStayPointFrame` (hidden) | "Ponto de estação" | Occupy / give up / plunder stay points | explore view stay button | 459 |
| `SB/SkyBoxRoadRankFrame` (hidden) | "Rank do Tempo de estacionamento do Eremitério do Céu" | Daily and weekly occupation time ranking, rewards | rank button | 460 |

## 3. Routes (client to server)

All routes: send 8636 (0x21bc) `C_SKY_TRIAL` with `skytrial.SkyTrialRequestMsg`: `op` (#1, INT32), `need_help` (#2, BOOL), `pay_type` (#3, INT32), `buy_skill_id` (#4, INT32), `portal_id` (#5, INT32), `layNumId` (#6, INT32), `posIndex` (#7, INT32).

### 3.1 Exploration (live)

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| K1 | Enter (first time per session) | `SBM.getData` (`SBM:198-213`) | NPC option; later calls skip the request and only switch scene (`_isFirst` false) | `op = 1` | 4552 `op 1` -> scene switch (`SBM:296-301`) |
| K2 | Search x1 / x10 | `SBM.explore(2, portalId, count)` (`SBM:215-224`) from `SB/view/SkyboxRoadExploreView.as:278-379` | x1: energy >= `EnergyCost` ("Movimentos insuficientes, não é possível pesquisar"); x10: `count = min(10, TotalSearchCount - searchCount)`, reduced to `floor(energy / 20)` if short; when purchases remain the buy dialog is offered | `op = 2`, `need_help` = helper flag, `portal_id`, `layNumId` = number of searches | 4551 (event and rewards), 4552 `op 2` (energy, progress) |
| K3 | Open a portal | `SBM.explore(3, portalId)` (`SB/view/SkyBoxRoadCheckPointView.as:196-204`) | none | `op = 3`, `portal_id`, `layNumId = 1` | 4551 (current portal rewards view; `event_id 0`) |
| K4 | Challenge boss | `SBM.dekaronBoss(portalId)` (`SBM:234-242`) from `SB/view/SkyBoxRoadCheckPointView.as:139-142`, `SkyboxRoadExploreView.as:249-252` | button enabled at 100% (assumption from the progress tip) | `op = 4`, `need_help`, `portal_id` | battle 293; on victory 4996 (clear rewards) then 4552 `op 2` |
| K5 | Buy action points | `SBM.buyEnergy(payType)` (`SBM:253-260`) from `SB/SkyBoxRoadFrame.as:320-344` | purchases left = `skytrial_max_buy_energy - buyEnergyCount` (> 0 else "Compras diárias atingiu o limite"); confirm "Deseja consumir {0} diamantes para aumentar {1}pts de movimento? (Hoje você ainda pode comprar {2} vez(es))" (25 diamonds for 100 points); checkbox -> `pay_type 2`, else 1 | `op = 5`, `pay_type` (1 diamonds, 2 bound diamonds; assumption) | 4552 `op 2` |
| K6 | Buy skill | `SBM.buySkill(skillId)` (`SBM:244-251`) from `SB/view/SkyboxRoadSkillItem.as:60-74` | confirm "Deseja consumir {0} pontos de pesquisa para comprar esta habilidade?" | `op = 6`, `buy_skill_id` (one of `skytrial_skill`) | 4552 `op 2` with `skillCountList` |
| K7 | Return from portal; scene exit | `SBM.exitPortal` (`SBM:226-232`) from `SkyboxRoadExploreView.as:268-274`, main toolbar return (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1650-1654`, also resets `_isFirst`) | none | `op = 7` | none required (assumption) |
| K8 | Helper toggle | client only (`SB/view/SkyBoxRoadRightView.as:199-225`) | search points >= `skytrial_helper_cost` (200) ("Pontos de pesquisa insuficiente {0}, não é possível convocar ajudante") | sets `need_help` on K2 and K4 | |

### 3.2 Stay points and ranking (hidden by `SKYBOX_ROAD_POINT = false`)

| # | UI control | Client sender | Fields | Response |
|---|---|---|---|---|
| K9 | Stay point frame open | `SBM.sendPointOccupyRequest(8, portalId)` (`SB/staypoint/SkyBoxRoadStayPointFrame.as:39`) | `op = 8`, `layNumId` = portal | 459 |
| K10 | Occupy / plunder a point (confirm "Saqueando outros pontos ... deseja saquear?"; Monday midnight warning) | `sendPointOccupyRequest(9, portalId, posIndex)` (`SB/staypoint/SkyBoxRoadStayPointItem.as:216-277`) | `op = 9`, `layNumId`, `posIndex` | battle against the occupant (assumption), 459 |
| K11 | Give up a point (confirm "Deseja desistir do ponto de estação atual?") | `sendPointOccupyRequest(11, portalId, posIndex)` (`:187-203`) | `op = 11` | 459 |
| K12 | Rank frame open | `SBM.sendRankListRequest` (`SBM:355-361`) | `op = 10` | 460 |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 4552 (0x11c8) `U_C_RES_SINGLEPASS_INFO` | `skytrial.SkyTrialInfoMsg`: `op` (#1, INT32) 1 = initial (enter scene), 2 = update; `layerList` (#2, repeated `SkyTrialLayerMsg`: `layerNum` (#1), `portalList` (#2, repeated `SkyTrialPortalMsg`: `portalId` (#1), `search_count` (#2), `clear` (#3, BOOL))); `skillCountList` (#3, INT32, repeated) flat pairs `skillId, count`; `buffList` (#4, INT32, repeated) active buff ids; `search_point` (#5); `energy` (#6); `buy_energy_count` (#7) | `SBM.onInfo` (`SBM:262-306`): top layer = max `layerNum` | K1 (op 1), after K2..K6 and battles (op 2) |
| 4551 (0x11c7) `U_C_UPDATE_AREA` | `skytrial.SkyTrialSearchMsg`: `portal_id` (#1); `event_id` (#2) `SkyTrialEventTempInfos.EventId`, -1 = boss found (100%), 0 = none; `rewardList` (#3, INT32, repeated) triples `type, templateId, count` | `SBM.__updateAreaHandler` (`SBM:313-338`); event display in `SB/SkyBoxRoadFrame.as:346-395` | After K2, K3 |
| 4996 (0x1384) `U_C_SKY_TRIAL_BOSS_REWARD` (missing in `protocol/opcodes.csv`, defined in `decompiled/core_module/scripts/yishi/datas/consant/AcceptProtocolType.as:1324`) | `SkyTrialSearchMsg.portal_id` cleared portal | `SBM.onCleanPortalReward` buffered until the scene is back (`SBM:340-353`), opens the clear reward frame | After a won 293 battle |
| 459 (0x01cb) `U_C_SKY_POINT_REQ` (hidden) | `battle.SkyTrialPointMsg`: `isOccpPoint` (#17, BOOL) player holds a point; `pointInfo` (#10, repeated `SkyTrialPointInfoMsg`: `layNumId` (#1), `posIndex` (#2), `occpUuid` (#3), `occpUserId` (#4), `nickName` (#5), `svrsName` (#6), `occpDateStr` (#7), `occpMinute` (#8) minutes held, `isSendTimeReward1..3` (#9..#11, BOOL), `fashionArm` (#12), `fashionWing` (#13), `fashionCloth` (#14), `fashionHair` (#15), `fashionHat` (#16), `arm` (#17), `job` (#18), `sexJob` (#19)); other fields (`army` #4 `battle.ArmyMsg`, `uuid` #5, `svrName` #6, `lordInfo` #7, `petsInfo` #8, `childInfo` #9) unused | `SBM.__updateSkyBoxRoadPointInfo` (`SBM:117-190`) | K9..K11 |
| 460 (0x01cc) `U_C_SKY_RANK` (hidden) | `SkyTrialPointMsg`: `myDayOrder` (#13), `myDayTimer` (#14) minutes, `myWeekOrder` (#15), `myWeekTimer` (#16); `orderInfo` (#11, repeated `SkyTrialOrderInfoMsg`: `uuid` (#1), `nickName` (#2), `svrsName` (#3), `daysMinute` (#4), `weekMinute` (#5), `daysOrder` (#6), `weekOrder` (#7), `isReward` (#8), `orderType` (#9) 1 day, 2 week) | `SBM.__updateSkyBoxRankInfo` (`SBM:73-115`) | K12 |

## 5. Rules and formulas

Config (`raw/xml/tempinfos/ConfigInfos.xml`):

| Key | Value | Meaning |
|---|---|---|
| `skytrial_max_energy` | 500 | max action points |
| `skytrial_buy_energy` | 25,100 | 25 diamonds for 100 action points |
| `skytrial_max_buy_energy` | 3 | purchases per day |
| `skytrial_skill` | 40401000,40401001,40401002 | buyable skills |
| `skytrial_buy_skill_cost` | 100,100,100 | search point price per skill |
| `skytrial_max_skill_count` | 5 | max skill charges |
| `skytrial_max_search_point` | 1000 | search point cap |
| `skytrial_helper_cost` | 200 | search points per helped boss fight |
| `skytrial_helper_property_percent` | 75 | helper inherits 75% of player attributes |
| `skytrial_helper_tempid` | 103000 | helper hero template |
| `SkyTrial_Timer` | 60,180,300 | stay point reward periods in minutes (hidden feature) |

- Search cost: portal `EnergyCost` (20). Progress = `search_count / TotalSearchCount`.
- Event (`SkyTrialEventTempInfos.xml`, 132 rows): `NeedMinLayer`, `BigBonus`, `Reward` = `type,id,count|...` (type 1 item, 4 action points, other = skill or buff; client `SB/SkyBoxRoadFrame.as:360-395`), `Monster` (hero template for a fight event), `SearchPoint` gained.
- Clear rewards: portal `ClearReward` and layer `ClearReward` (`type,templateId,count|...`, `-100` = gold).
- Layer unlock: next layer after all portals of the current one are cleared (`SkyTrialLayerInfo.isAllClear`).
- Daily reset 0:00: action points to max, purchases, daily buffs ("O efeito do Buff diário é resetado diariamente").
- Stay points (hidden): occupation pays `SkyRewards.xml` items per portal (`CampaignId` = portal, `Param2` = period 1..3 for 60/180/300 min), sent by mail after 5 h; weekly ranking reward `SkyOrderRewards.xml` every Monday 0:00.
- Battle: boss fight type 293; after the battle the client calls `getData` and returns to `SKYBOX_ROAD_SCENE` without `setScene` (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:127-131`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/SkyTrialLayerTempInfos.xml` (20) | layer | `LayerNum`, `PortalCount`, `ClearReward` |
| `raw/xml/tempinfos/SkyTrialPortalTempInfos.xml` (90) | portal | `PortalId`, `PortalName`, `LayerNum`, `NatureType`, `ResourcePath`, `ScenePath`, `EnergyCost`, `TotalSearchCount`, `ClearReward` |
| `raw/xml/tempinfos/SkyTrialEventTempInfos.xml` (132) | search event | `EventId`, `BigBonus`, `NeedMinLayer`, `Monster`, `Reward`, `SearchPoint` |
| `raw/xml/tempinfos/SkyRewards.xml` (1620) | stay point time reward (hidden) | `Index`, `CampaignId`, `TemplateId`, `Count`, `Param2` |
| `raw/xml/tempinfos/SkyOrderRewards.xml` (36) | stay time rank reward (hidden) | `Index`, `Min`, `Max`, `TemplateId`, `Count` |

## 7. Persistent state

```sql
CREATE TABLE trials.sky_trial_state (
    player_id          BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    energy             smallint    NOT NULL DEFAULT 500 CHECK (energy >= 0),
    energy_bought      smallint    NOT NULL DEFAULT 0,
    search_points      smallint    NOT NULL DEFAULT 0 CHECK (search_points BETWEEN 0 AND 1000),
    daily_buffs        integer[]   NOT NULL DEFAULT '{}',
    current_portal_id  integer     NOT NULL DEFAULT 0,
    daily_date         date        NOT NULL DEFAULT current_date
);

CREATE TABLE trials.sky_trial_portal (
    player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    portal_id     integer  NOT NULL,
    layer_num     smallint NOT NULL,
    search_count  smallint NOT NULL DEFAULT 0,
    cleared       boolean  NOT NULL DEFAULT false,
    PRIMARY KEY (player_id, portal_id)
);

CREATE TABLE trials.sky_trial_skill (
    player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    skill_id    integer  NOT NULL,
    charges     smallint NOT NULL CHECK (charges BETWEEN 0 AND 5),
    PRIMARY KEY (player_id, skill_id)
);
```

Hidden stay points (only if enabled): `trials.sky_trial_stay_point (portal_id, pos_index, occupant_id, occupied_at, rewards_sent smallint)` and `trials.sky_trial_stay_time (player_id, week_start, day_minutes, week_minutes)`.

## 8. Backend implementation notes

- Handlers: `trials::sky_trial::handle_enter` (op 1), `handle_search` (2), `handle_open_portal` (3), `handle_boss` (4), `handle_buy_energy` (5), `handle_buy_skill` (6), `handle_exit_portal` (7); hidden: `handle_point_list` (8), `handle_point_occupy` (9), `handle_rank` (10), `handle_point_leave` (11).
- Search: validate portal unlocked (layer open), not cleared, searches left; per search deduct `EnergyCost`, increment `search_count`, roll an event allowed for the layer (`NeedMinLayer`), apply rewards (items, energy, buffs, skills, search points capped at 1000), monster events start a battle (assumption, battle type 293). Send 4551 with the last event (`event_id = -1` when progress reaches 100%) and 4552 op 2.
- Boss: require 100%; if `need_help` deduct 200 search points and add helper hero 103000 with 75% attributes; start battle 293 with portal boss; on victory mark cleared, grant portal reward (and layer reward when the layer is complete), send 4996 then 4552 op 2.
- Skills: deduct 100 search points, add one charge (max 5); charges are consumed in battle through `B_USE_TRIAL` (10507, battle module) (assumption).
- Daily reset at 0:00: energy 500, purchases 0, buffs cleared.

## 9. Open questions and assumptions

- `pay_type` values for energy purchase (1 diamonds, 2 bound diamonds) inferred from the dialog checkbox.
- Monster events: whether they start a battle or only award points.
- Stay point plunder battle type and ranking reward delivery (hidden feature).
- Whether 4552 op 2 is pushed after a 293 battle (the client does not request it because `_isFirst` is false).

## 10. Implementation checklist

- [ ] Template loaders (layers, portals, events, config keys)
- [ ] Tables `trials.sky_trial_state`, `sky_trial_portal`, `sky_trial_skill`
- [ ] K1 enter (4552 op 1)
- [ ] K2, K3 search and portal open (4551, 4552)
- [ ] K4 boss battle 293, 4996 clear reward
- [ ] K5 energy purchase, K6 skill purchase, K7 exit
- [ ] Daily reset
- [ ] (optional) Stay points and ranking K9..K12 if `SKYBOX_ROAD_POINT` is enabled
- [ ] Tests: energy cost, x10 search clamp, layer unlock, helper cost
