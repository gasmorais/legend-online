# Dusk area ("Terra do crepúsculo")

Module `dusk-area` of [campaign](README.md). A timed two team war field on map 4901: players capture resource towers, kill enemies and guardians, carry resources and capture flags; the first team to 5000 points (or the leader after 30 minutes) wins. Client package `duskarea` (CM models) plus the M3 views. The war field list that leads here belongs to the [world-boss](../world-boss/README.md) feature; the same war field machinery also serves maps 4101 "Templo das Chamas" and 4701 "Fogo e Gelo" (`PvpWarFightModel` is shared).

## 1. Overview

- **Template.** `Campaigns.xml` 4901 "Terra do crepúsculo": `Types 50` (map PvP, stored in `pvpWarFightDic`, `CM/yishi/manager/TempleteManager.as:2580-2600`), `Capacity 10000`, `MinLevel 80`, `MaxLevel 100`, `OpenTime 00:01`, `StopTime 23:59`, `StandardDamage 10000`, `StandardHurt 10000`, description "Participe da Terra do Crepúsculo para receber muitas Medalhas e Reputação". `WorldBossHelper.checkDuskArea(mapId)` is `mapId == 4901` (`CM/yishi/utils/WorldBossHelper.as:250-253`). ConfigInfos `config_type2_war_map` = "4101,4901" and `cross_war_match_room` place it in the level 81..280 bracket of the cross war field matcher.
- **Entry.** The war field item checks the daily count: with `warFieldCount <= 0` it sends **8599** and the server answers **4493** (`CampaignReqMsg`); without gains left the client asks "Ganhos diários esgotados, você não poderá ganhar os prêmios do campo de batalha, deseja entrar?" and then sends **8332** `WorldBossMsg{param1 = 4901}` (`M13/worldboss/pvp/WarFightItem.as:105-117`; `CM/yishi/manager/BaseManager.as:320, 1404-1440`). The server places the player in a war instance with **125**.
- **On the map.** The HUD shows team scores (blue and red bars, 5000 max), team head counts, flag counts and the flag delivery countdown; the self panel shows own points and resources; "Ranking de pontos" requests **8337**; "M" opens the small map. Attacking an enemy player sends **8334**; resource towers, guardians, mines and delivery points are campaign nodes reached with **5125** (also in state 4).
- **End.** The server sends **4254** `WarReportListMsg`; the client stores it and opens the "Avaliação da Batalha" frame (medals, honor, soul stones per player).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `DuskAreaUIMediator` (`M3/map/campaign/mediator/duskarea/DuskAreaUIMediator.as`) | none | Places the HUD views | map 4901 | |
| `DuskAreaInfoView` (`M3/map/campaign/view/ui/duskarea/DuskAreaInfoView.as`) | "Contagem Regressiva para Entrega da Bandeira Capturada:" | Team score HUD | map | `oneScore`/`twoScore` with bars scaled by /5000 (:285-306), `oneCount`/`twoCount`, flag counts (:309-310), flag delivery countdown from 4220 (:231-245), floating score movies |
| `DuskAreaSelfInfoView` (`M3/map/campaign/view/ui/duskarea/DuskAreaSelfInfoView.as`) | map button tip "Tecla rápida do Mapa “M”" | Own points | map | `geste` (points), `score` (resources) (:192-196); rank button (:187-190), map button and key M (:161-178, 272), hide button |
| `DuskAreaPointRankFrame` + `DuskAreaPointRankList` + `DuskAreaPointRankItem` (`M3/map/campaign/view/frame/duskarea/`) | "Ranking de pontos" | Live ranking per team | 4255 (`PVP_WAR_FIGHT_ORDER_REPORT`) | columns "Ranking", "Nome", "Servidor", "Ataque", "Capturar a Bandeira", "Pontos pessoais"; team tabs (:185-210) |
| `DuskAreaAccountFrame` (`.../DuskAreaAccountFrame.as`) | "Avaliação da Batalha" | Final report | 4254 (`openControllerByInfo("duskarea", null, {mapId})`, `M3/map/campaign/CampaignSocketManger.as:1217`) | win or loss image, ranking, own rewards: medals (`item_count`), honor (`win_geste_count`), soul stones (`soulsStoreCount`) (:100-116); leave button only closes the frame (:95-98) |
| `DuskAreaSmallMapFrame` (`.../DuskAreaSmallMapFrame.as`) | none | Small map with click to walk | M key | nodes, own path (walks with 5124) |
| `IceFireWarSmallMapFrame` (`.../IceFireWarSmallMapFrame.as`) | none | Same for map 4701 | map 4701 | other war field |
| Help (`map.campaign.view.ui.duskarea.helpTxt`) | rules text | 4 rules (see §5) | help button | |

## 3. Routes (client to server)

| # | Action | Sender (file:line) | Client checks | Route | Request fields | Server response |
|---|---|---|---|---|---|---|
| D1 | Check daily war field gains | `WarFightItem.__enterWarFightHandler` (`M13/worldboss/pvp/WarFightItem.as:105-117`) -> `SingWarSocketSendManager.sendRequestPvpRemainNumber(campaignId)` (`M13/net/SingWarSocketSendManager.as:38-49`) | `warFieldCount <= 0`; 5 s anti flood (silent) | C>S **8599 (0x2197) C_CHECK_WARFIELD_COUNT** | `CampaignReqMsg{para_int1 (#1) = 4901}` | **4493** |
| D2 | Enter | `SingWarSocketSendManager.enterWarfield(campaignId)` (:24-36) when `warFieldCount > 0`; or the 4493 confirm (`BaseManager.as:1404-1440`) | 5 s anti flood ("Clique excessivo, tente novamente") | C>S **8332 (0x208c) C_ENTER_WARFIELD** | `worldmap.WorldBossMsg{param1 (#3, INT32) = 4901}`; `army_id (#1)`, `map_id (#2)`, `param2 (#4)`, `param3 (#5)`, `param4 (#6)` unset | **125** (instance of map 4901), 21, 127, then **4252**, **4220**; refusal (closed, level) **126** |
| D3 | Attack an enemy player | `PvpWarFightMediator.sendAttack` (`M3/map/campaign/mediator/pvp/PvpWarFightMediator.as:166-175`) when the hero reaches the target (distance check :146) -> `MapSocketOuterManager.sendAttackInPvpMap(userId, serverName)` (`M3/map/net/MapSocketOuterManager.as:147-154`) | target online | C>S **8334 (0x208e) C_WARFIELD_ATTACK** | `WarFieldAttackMsg`: `user_id (#1, INT32)` target, `defence_server_name (#3, STRING)` target server; `server_name (#2)` unset | PvP battle (157 ... 4103) between the two players *(battleType assumption: 32 `CROSS_WAR_FIELD_BATTLE` or 19)*; then **4269** score movies, **4252** |
| D4 | Interact with towers, guardians, mines, delivery | node arrival `CampaignArmyViewHelper.sendMessage` (`M3/map/campaign/helper/hero/CampaignArmyViewHelper.as:121-186`): on 4901 a node in state 4 still sends 5125 | as [node-combat.md](node-combat.md) | C>S **5125** | `para_int1` = camp data id | battle vs guardians/monsters, capture (128 state, `param1` team), pick or deliver resources; **4252**, **4269** |
| D5 | Open the ranking | `DuskAreaSelfInfoView.onRankClick` (:187-190) -> `CampaignSocketOutManager.requestWarFightOrderList()` (`CM/map/campaign/CampaignSocketOutManager.as:126-130`) | none | C>S **8337 (0x2091) C_WARORDER_REQUEST** | no body | **4255** |
| D6 | Max HP request (PvP map HUD, shared) | `PvpMapRightView.as:117` -> `CampaignSocketOutManager.warMaxhp()` (:132-136) | none | C>S **8338 (0x2092) C_WAR_MAXHP** | no body | army HP sync *(assumption: 4183)*; not used by the dusk HUD |
| D7 | Walk, leave | 5124 / 5025 | see [map-session.md](map-session.md) | | | 4185 / 22 |

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **4493 (0x118d) U_CHECK_WARFIELD_COUNT_RS** | `CampaignReqMsg{para_int1 (#1) campaign id, para_bool1 (#7) has gains}` | `BaseManager.__warFightRemainNumber` (`CM/yishi/manager/BaseManager.as:320, 1404-1440`) | reply to 8599 | `para_bool1` false: confirm "A quantidade de lucro de hoje já atingiu o limite..." (or "Ganhos diários esgotados..." after job transfer) then 8332; true: 8332 directly |
| **4248 (0x1098) U_C_WARFIELD_STATE** | `WorldBossStateMsg{worldBossInfo (#1, WorldBossInfoStateMsg, repeated)}`; open when `state == 0` | `WorldBossManager.__updateWarFightStateHandler` (`CM/managers/WorldBossManager.as:65, 127-137`) | open state changes | war field list button state (world-boss feature) |
| **4252 (0x109c) U_C_WARFIELD_INFO** | `WarFightInfoMsg{team_id (#1), score (#2) own resources, order (#3) own rank, geste (#4) own points, hit_count (#5) own kills, left_time (#6) s, one_count (#7), two_count (#8) team sizes, one_score (#9), two_score (#10) team scores, one_FlagCount (#11), two_FlagCount (#12)}` | `CampaignSocketManger.__warfieldInfoHandler` (`M3/map/campaign/CampaignSocketManger.as:354, 1255-1273`) | on entry and on every score change, to every player of the instance | HUD refresh (`PVP_WAR_FIGHT_INFO_CHAGE`) |
| **4220 (0x107c) U_C_WARFIELD_FLAG_END_TIME** | `WarFightFlagEndTimeMsg{endTime (#1, STRING "YYYY-MM-DD hh:mm:ss")}` | `FreedomTeamManager.__timeendtimeCreateHandler` (`CM/managers/FreedomTeamManager.as:71, 74-81`) | a player of the team carries a captured flag | `pvpWarFightModel.time`; countdown in `DuskAreaInfoView` |
| **4255 (0x109f) U_C_ORDERREQUEST** | `WarReportListMsg` with `info (#10, WarReportMsg, repeated)` (reads `player_uuid`, `hitCount`, `nick_name`, `order`, `score`, `user_id`, `team_id`, `geste`, `param2`, `server_name`) | `__orderrequestHandler` (:356, 1220-1253) | reply to 8337 | ranking frame |
| **4254 (0x109e) U_C_WARREPORT** | `WarReportListMsg{one_teamId (#1), two_teamId (#2), thd_temaId (#3), temp_id (#4), own_count (#5), team_count (#6), one_score (#7), two_score (#8), thd_score (#9), info (#10, WarReportMsg, repeated)}`; `WarReportMsg{order (#1), nick_name (#2), user_id (#3), score (#4), hitCount (#5), team_id (#6), geste (#7), server_name (#8), item_count (#9) medals, win_geste_count (#10) honor, seniorStoreCount (#11), param1 (#12), param2 (#13), soulsStoreCount (#14), player_uuid (#15)}` | `__warreportHandler` (:355, 1163-1218), buffered for the return scene | war end, to every participant | stores the report, opens `DuskAreaAccountFrame` with `mapId` |
| **4269 (0x10ad) U_C_WARMOVIE** | `WarMovieMsg{score (#1), geste (#2), is_add (#3, BOOL), user_id (#4), type (#5), server_name (#6)}` | `CampaignMapController.__warMovieHandler` (`M3/map/campaign/CampaignMapController.as:611, 979-990`) | points gained or lost | floating score/points movie (`ScoreOrGesteAction`) |
| **4262 (0x10a6) U_C_BROADBUFFER** | `army.ArmyBufferListMsg{armyBuffer (#1, ArmyBufferMsg, repeated)}`; `ArmyBufferMsg{user_id (#1), buffer_tempId (#2)}` | `__broadBufferHandler` (:358, 1126-1137) | buff gained (guardian kill, mine carry, rare monster, death streak) | buff icon on the army (`CampaignBufferTemps`) |
| 125, 21, 127, 128, 22 | campaign map messages | [map-session.md](map-session.md) | | |

`WarEnergyListMsg{energy (#1, WarEnergyMsg, repeated)}` and `WarEnergyMsg{node_tempId (#1), blueCount (#2), redsCount (#3), ownerTeamId (#4), currentIndex (#5)}` are read by the shared `__updateFlameTempleEnergyListHandler` (opcode 4649, `M3/map/campaign/CampaignSocketManger.as:374, 2202-2229`) for the Templo das Chamas energy gaps, not by the dusk HUD.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Victory | first team to 5000 points; otherwise the leading team after 30 minutes | `map.campaign.view.ui.duskarea.helpTxt`; HUD bar scale /5000 (`DuskAreaInfoView.as:305-306`) |
| Points | capturing resource towers, killing enemies and guardians, carrying resources | help text rule 1 |
| Buffs | killing guardians, carrying mines, killing rare monsters, and being killed grant buffs | help text rule 4; 4262 |
| Teams | two teams (`one_teamId`, `two_teamId`); `thd_*` fields exist for 3 team maps | 4254 |
| Opening | `OpenTime 00:01`, `StopTime 23:59`; cross war windows `cross_war_open_time` "13:00,13:30\|15:00,15:30\|17:00,17:30\|19:00,19:30" *(assumption: applies to 4901 when matched cross server)* | `Campaigns.xml`; ConfigInfos |
| Level | 80..100 (`MinLevel`/`MaxLevel`); cross bracket by `cross_war_match_room` | templates |
| Daily gains | `WarField_MaxCount` (absent from the BR ConfigInfos; client default 2) entries with rewards; entering without gains is allowed | `WarFightItem.as:107-116`; `BaseManager.as:1404-1440` |
| Attack range | the client attacks when the squared distance < 10000 (100 px) and the target is online | `PvpWarFightMediator.as:146-150` |
| Rewards | medals (`item_count`), honor (`win_geste_count`), soul stones (`soulsStoreCount`), senior stones (`seniorStoreCount`) per player at the end | `DuskAreaAccountFrame.as:100-116` |

## 6. Templates

| File | Use |
|---|---|
| `Campaigns.xml` 4901 | rules above |
| `MapInfos.xml` 4901 | map, `BattleGround` |
| `ConfigInfos.xml` | `WarField_MaxCount`, `config_type2_war_map`, `cross_war_match_room`, `cross_war_open_time`, `CrossWar_Time` |
| `CampaignBufferTemps.xml` | war buffs (e.g. family 3 "Espírito da Coragem", +5..+50 ATK/HP on battlefields, `docs/mechanics/world_progression.md` §2.7) |
| node data (towers 141, guardians, mines `CNWarPickResourceAi`, delivery `CNWarTransStopAi`, toll `CNWarTollgateAi`, 2 sides via `Param1`) | editor nodes of map 4901 in `game.campaign_nodes` (`docs/world/README.md` §3.4) |

## 7. Persistent state (schema `campaign`)

```sql
CREATE TABLE campaign.war_field_match (
  instance_id  bigint   PRIMARY KEY REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  map_id       integer  NOT NULL,
  team_one_id  integer  NOT NULL,
  team_two_id  integer  NOT NULL,
  team_one_score integer NOT NULL DEFAULT 0 CHECK (team_one_score BETWEEN 0 AND 5000),
  team_two_score integer NOT NULL DEFAULT 0 CHECK (team_two_score BETWEEN 0 AND 5000),
  team_one_flags smallint NOT NULL DEFAULT 0,
  team_two_flags smallint NOT NULL DEFAULT 0,
  started_at   timestamptz NOT NULL DEFAULT now(),
  ends_at      timestamptz NOT NULL,
  winner_team_id integer,
  finished_at  timestamptz
);

CREATE TABLE campaign.war_field_player (
  instance_id  bigint  NOT NULL REFERENCES campaign.war_field_match(instance_id) ON DELETE CASCADE,
  player_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  team_id      integer NOT NULL,
  points       integer NOT NULL DEFAULT 0,
  resources    integer NOT NULL DEFAULT 0,
  kills        integer NOT NULL DEFAULT 0,
  flags        integer NOT NULL DEFAULT 0,
  has_gains    boolean NOT NULL,
  medals       integer NOT NULL DEFAULT 0,
  honor        integer NOT NULL DEFAULT 0,
  soul_stones  integer NOT NULL DEFAULT 0,
  PRIMARY KEY (instance_id, player_id)
);
CREATE INDEX war_field_player_rank ON campaign.war_field_player (instance_id, team_id, points DESC);
```

Daily entries: `campaign.daily_entry` mode `war_field` ([rooms.md](rooms.md)).

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::dusk_area::handle_check_count` | 8599 | none | reply 4493 `{para_int1, para_bool1 = remaining gains > 0}` |
| `campaign::dusk_area::handle_enter` | 8332 | (1) map 4901 open (time window); (2) level 80..100; (3) not in another instance or room | join or create a war instance (balance teams by count and power *(assumption)*); `has_gains` from the daily count; 125, 21, 127, 4252 to the joiner; 4252 to all (team counts) |
| `campaign::dusk_area::handle_attack` | 8334 | both in the same instance, enemy teams, target alive and online | start a PvP battle; on result: points to the winner (4269 to both), kills, buffs (4262), 4252 to all |
| `campaign::dusk_area::on_arrive` (hook of 5125) | 5125 on 4901 | node by kind | towers: capture (team), periodic resource points; guardians/monsters: battle then points and buffs; mines: carry state; delivery: points; flags: 4220 countdown to the team |
| `campaign::dusk_area::handle_ranking` | 8337 | member | reply 4255 sorted by points |
| `campaign::dusk_area::tick` | timer | running matches | tower income; end at 5000 or `ends_at` (30 min); on end: rewards for players with gains, 4254 to everyone, `daily_entry + 1`, close the instance (players return on leave) |

- Battle config for 8334: `battle_type` 32 *(assumption)*, `map` = `MapInfos[4901].BattleGround`, both player armies.
- 4254 must be sent while the player is still in the map or after the return (the client buffers it for `SwitchPageHelp.returnScene`).

## 9. Open questions and assumptions

1. Exact point values per action (towers, kills, guardians, delivery, flags).
2. Battle type for war field fights (32 or 19).
3. Team balancing and late join rules.
4. Reward formulas (medals, honor, soul stones) and the `WarField_MaxCount` default (2 in the client).
5. Whether 4901 was cross server in this build.

## 10. Implementation checklist

- [ ] Screens check: `DuskAreaInfoView`, `DuskAreaSelfInfoView`, `DuskAreaPointRankFrame`, `DuskAreaAccountFrame`, `DuskAreaSmallMapFrame`
- [ ] 8599 -> 4493; 8332 -> instance on 4901
- [ ] 4252 / 4220 / 4269 / 4262 pushes
- [ ] 8334 PvP fights
- [ ] 5125 hook for towers, guardians, mines, delivery, flags
- [ ] 8337 -> 4255
- [ ] End: 4254 report and rewards
- [ ] Tables `war_field_match`, `war_field_player`; daily mode `war_field`
- [ ] Test: two players on opposite teams, one attack, score and ranking update; match end at 5000
