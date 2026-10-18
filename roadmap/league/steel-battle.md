# Steel battle (iron city map 5701)

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| CMG | `decompiled/core_module/scripts/map/campaign/CampaignManager.as` |
| CAVH | `decompiled/m3/scripts/map/campaign/helper/hero/CampaignArmyViewHelper.as` |
| CNV | `decompiled/m3/scripts/map/campaign/view/physics/physicsview/CampaignNpcView.as` |
| MSOM | `decompiled/m3/scripts/map/net/MapSocketOuterManager.as` |
| CA | `decompiled/core_module/scripts/map/campaign/data/CampaignArmy.as` |
| WBH | `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as` |
| PT | `decompiled/core_module/scripts/map/internals/constant/PosType.as` |

## 1. Overview

Two teams (red side 1 and blue side 2) fight on the campaign map 5701 (`WBH:166-172`). Every player drives an artillery vehicle ("modo de Artilharia") whose attributes merge with the hero. The map has a neutral iron city in the center surrounded by a gate; the gate blocks movement until destroyed. Sides own a formation totem (respawn point) and towers; monsters drop buffs; a boss grants a strong skill. Points come from kills, totems, monsters and holding the city. The client side is the generic campaign map plus the vehicle combat layer shared with "Artilharia TM", with a few steel specific branches listed below.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `CampaignMapView` on map 5701 | none | Battle map; on enter hides main bar, resources bar and chat (`CMC:507-512`) | server enters the player in the map (125 / 21 / 127, [../campaign/README.md](../campaign/README.md)) after op 6 | nodes, armies, vehicle HP and buffs |
| Vehicle skill bar and target cursor (`asset.vehiclemap.SteelBossSkillCursor`, `CMC:1978`) | none | Cast vehicle skills; auto target picks the nearest enemy tower, gate or player within 800 px (`CMC:1895-1970`) | battle map | skill counts (`CA:677-698`) |

Node rendering: steel nodes get a name color by side (`param1` 1 = color 1, 2 = color 5, else 2, `CNV:296-312`).

## 3. Routes (client to server)

### R1. Enter the battle (op 6)

- UI: lobby `_joinBtn` (`SV:162-165`).
- Sender: `SteelController.sendSteelEnter` (`SC:540-546`).
- Client checks: none.
- Route: C>S 8962 (0x2302) `C_STEEL_PLAYER_OP`, `steel.SteelTeamInfoMsg` with `param1 (#19, INT32)` = 6.
- Response: on success the campaign instance sequence 125 then 21 then 127 for map 5701, then the vehicle join 4513 and HP list 4517 ([../artillery/README.md](../artillery/README.md)); member list 4767 with `isEnter = 1`. On failure generic alert.

### R2. Movement, attacks and skills

Generic campaign and vehicle routes: movement 5121 / 5124 (campaign), vehicle attack and skill routes of the artillery feature. Both are documented in [../artillery/README.md](../artillery/README.md) and [../campaign/README.md](../campaign/README.md).

### R3. Dead steel specific senders

`MapSocketOuterManager` defines two steel senders that no code calls in this build:

| Sender | Route | Request |
|---|---|---|
| `sendCastSkillSteel(armyId, serverName, skillId, suffererIds, suffererServers, npcIds, x, y)` (`MSOM:199-211`) | C>S 25133 (0x622d) `CR_ATTACK_CROSSSTEEL` | `vehicle.VehicleAttackReqMsg`: `skill_id (#1, INT32)`, `attack_type (#2, INT32)` unset, `sufferer_npc_id (#3, INT32)` unset, `suffererId (#4, INT32, repeated)`, `effectX (#5, INT32)`, `effectY (#6, INT32)`, `suffererServerName (#7, STRING, repeated)`, `suffererNpcIdArray (#8, INT32, repeated)`, `attack_server_name (#9, STRING)` |
| `sendPickupSteel(armyId, serverName, propNodeId)` (`MSOM:213-220`) | C>S 25131 (0x622b) `CR_PICK_BOX_CROSSSTEEL` | `vehicle.VehiclePickPropMsg`: `propNodeId (#1, INT32)`, `playerId (#2, INT32)` unset, `serverName (#3, STRING)` |

The `CR_` prefix marks routes forwarded to the cross server. The server should accept them with the same semantics as the generic vehicle attack and prop pickup (assumption), even though the client never sends them.

## 4. Server messages (server to client)

Steel specific branches of shared messages:

| Opcode | Name | Message | Steel branch |
|---|---|---|---|
| 4517 (0x11a5) | `U_C_VEHICLE_CAMPAIGN_LIST_RSP` (listener `CMG:213`) | `PlayerVehicleListMsg` | on map 5701 (`CMG:319-345`): rows without `playerId` and with `templateId` are nodes; `node.totalHp = grade`, `node.curHp = hp` (the `grade` field carries max HP); rows with `playerId` update the army: when `templateId` and `appellId` are set, `updateSteelInfo(templateId, appellId)` stores the vehicle template (`VehicleObjectTempInfos`) and the vehicle skill id (`CA:669-675`); then `updateArmyHpInfo(hp, grade)` |
| 4522 (0x11aa) `U_C_VEHICLE_SYNC_BUFF` | | `VehicleBuffListMsg` | on map 5701 (`CSM:2377-2400`): `playerBuffStates` update `steelBuffList` per army (`CA:600-667`); `npcBuffStates` apply hurt effects to nodes |
| 4521 (0x11a9) `U_C_VEHICLE_SYNC_SKILL` | | `VehicleSkillListMsg` | on map 5701 (`CSM:2533-2538`): `updateSteelSkillInfo(skillId, state, curSum)`: boss skill granted (`state` != 0) with `curSum` uses; each own cast of that skill decrements the count (`CA:677-698`) |
| 4474 (0x117a) `U_C_VEHICLE_NPC_NODE` | | `VehicleNpcNodeListMsg` | default branch (`CSM:2562-2675`): prop nodes (type 99999 `STEEL_PROPS`) with `state == 1` are removed; unknown nodes with `state == 0` are created as props at (`curX`, `curY`) with `sonType` and name (`CSM:2740-2770`) |
| 128 / 4264 node updates | | campaign node messages | a gate node (type 192) update sets `steelMapIsChanged` (`CSM:1927-1930`), which rebuilds path blocking |
| 4771 | `U_C_STEEL_VEHICLE_DETAILE` | `SteelRankDetailMsg` | score detail, see [steel-ranking.md](steel-ranking.md) |

End of battle: generic vehicle end 4514 / 201 and campaign exit 22 (artillery and campaign features).

## 5. Rules and formulas

Node types (`PT:80-108`, `CAVH:524-603`):

| Type | Constant | Meaning |
|---|---|---|
| 40 | birth node | side spawn ("totem da formação" respawn, assumption) |
| 191 | `STEEL_VICE` | secondary objective (target selectable, `ActiveVehicleSelectTargetMediator.as:126`) |
| 192 | `STEEL_DOOR` | city gate; while alive it blocks a 11 x 11 tile square around it (radius 5, `CMC:1271-1306`) |
| 193 | `STEEL_TOWER` | tower; its own tile is walkable (`CMC:1310-1317`); preferred auto target |
| 194 | `STEEL_CITY_CENTER` | city center (holding it scores) |
| 195 | `STEEL_ENERGY_CRYSTAL` | formation energy |
| 196 | `STEEL_MONSTER` | monster, drops buffs |
| 197 | `STEEL_DESTNATION` | destination |
| 99999 | `STEEL_PROPS` | dropped prop (pickup) |

Movement rule (`CMC:1326-1345`): while no gate is destroyed (`state == 8` means destroyed), a path step from a tile of value 1 or 4 into a tile of value 3, or from 3 into 1, is refused; tile values come from the map `space` layer ([docs/world/maps.md](../../docs/world/maps.md): 1/3/4 = steel zones). Once any gate is destroyed (`_steelDoorIsOpen`), movement is free.

Help rules (`steel.view.SteelFrame.helpContent`):

1. Each round pairs teams by ranking.
2. Players fight as artillery; hero and vehicle attributes are combined.
3. The iron city starts neutral; players destroy the city gate and take the formation energy and traps.
4. If a side's formation totem is destroyed its players cannot respawn until the totem refreshes.
5. The result is decided by possession; a large point gap ends the match early.
6. Points: killing players, destroying enemy totems, killing monsters; holding the city gives many points.
7. Killing monsters gives a combat BUFF; killing the boss gives powerful skills.
8. Rewards are only granted when the final point gap is 30 or more.

Numbers not in the client (assumptions to configure): match length, early end gap, points per action, totem refresh time, respawn delay, buff templates.

Leaving: the string `ui.maintoolbar.MainToolBar.exitSteelCampaign` ("Ao desistir todas as contribuições serão deduzidas e terá estado de desertor, com duração de 5 minutos!") exists but no code shows it; implement the rule server side: leaving zeroes the player's points and blocks re-entry for 5 minutes (assumption).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/VehicleObjectTempInfos.xml` | vehicle template | by `templateId` from 4517 (`CA:673`) |
| `raw/xml/tempinfos/MapInfos.xml` | map 5701 | **missing**: no row with `Id="5701"` exists |
| `raw/xml/tempinfos/MapNodeInfos.xml` | nodes of map 5701 | **missing**: no row with `MapId="5701"` |
| `raw/xml/tempinfos/VehicleSkillTempInfos.xml`, `VehicleBuffTempInfos.xml` | vehicle skills and buffs | skill ids from 4517 `appellId` and 4521; buffs from 4522 |

## 7. Persistent state

Battle state is in memory in the cross battle service. Persisted results: `league.steel_matches` and `league.steel_match_players` ([steel-ranking.md](steel-ranking.md)); entry flag `league.steel_team_members.entered_battle`.

```sql
CREATE TABLE league.steel_deserters (
    player_id   bigint      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    match_id    bigint      NOT NULL REFERENCES league.steel_matches(match_id),
    blocked_until timestamptz NOT NULL
);
```

## 8. Backend implementation notes

- `league::steel_battle::handle_enter` (op 6): validation order: season phase 1, caller in a team, team scheduled in the current round, not blocked by `steel_deserters`. Then create or join the match instance (campaign engine with map 5701), mark `entered_battle`, push 4767 to the team, send the campaign enter sequence and 4517 with each player's vehicle (`templateId` = chosen vehicle, `appellId` = vehicle skill id).
- Battle: run on the artillery engine (real-time vehicle combat, not the turn based battle engine). Score events update side scores and player points; push 4771 to all participants on change; on gate destruction push the node update (type 192, `state = 8`).
- End: when time is up or the gap exceeds the early end threshold; winner by score; write `steel_matches`, update team wins/losses; rewards only if gap >= 30; exit everyone (22).
- Accept 25131 / 25133 as aliases of the generic vehicle pickup / attack handlers: `league::steel_battle::handle_pickup_prop`, `league::steel_battle::handle_attack`.

## 9. Open questions and assumptions

- Open: map 5701 is absent from `MapInfos.xml`; the map data and node layout must be recovered or authored before this module can run.
- Open: all numeric battle parameters.
- Assumption: deserter rule from the unused string.
- Assumption: 25131 / 25133 semantics.

## 10. Implementation checklist

- [ ] Route 8962 op 6 and match placement.
- [ ] Campaign enter sequence for map 5701.
- [ ] Steel branches of 4517, 4521, 4522, 4474, node updates for gates.
- [ ] Gate blocking and movement validation server side.
- [ ] Scoring, early end, rewards gap 30.
- [ ] Optional routes 25131, 25133.
- [ ] Table `league.steel_deserters`.
- [ ] Test: movement across zone 1 to zone 3 refused before the gate falls and accepted after.
