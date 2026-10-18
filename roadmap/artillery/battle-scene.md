# Vehicle battle scene ("Julgamento TM", map "Ruínas Arcaicas")

Module `artillery::battle_scene`. Citation prefixes: see [README.md](README.md).

## 1. Overview

Real-time team PvP on a tile map (campaign/map id 3001, `new VehicleModel(3001)`, `M17/com/map/vehicle/net/VehicleSocketManager.as:782`). Each player drives one vehicle (template from [garage.md](garage.md)). Two teams (red and blue) fight; the map also holds a boss (node type 0, template 2191 "Armadura Dresches"), traps (type 1) and prop boxes (type 2) that grant a third skill or buffs. Players die and revive on a global cycle. Scores accumulate per player and per team; the match ends at a score gap or when one side has no players, and the server sends the final ranking and rewards.

The client sends paths, skill casts and pickups; the server is authoritative for positions, hits, damage, buffs, deaths, revives and scores. All coordinates on the wire are tiles; the client multiplies by 20 px.

## 2. Screens

| Class | pt-BR title | Purpose | Data shown |
|---|---|---|---|
| `com.map.vehicle.VehicleSceneController` (scene `VEHICLE`) | | Map, tanks (`TankAvatarView`), NPC/boss (`VehicleNpcAvatarView`), boxes (`VehicleBoxView`), traps (`VehicleTrapView`) | 4517, 4513, 4474 |
| `view.VehicleBottomView` | | HP bar, 3 skill slots (keys 1, 2, Q = keyCodes 49, 50, 81, `M17/com/map/vehicle/data/VehicleSkillbag.as:28-30`), buff bar, chat, settings, exit | own `PlayerVehicleInfo`, skill bag |
| `view.VehicleTopView` | | Red vs blue score, remaining time | 4518 |
| `view.VehicleRightView` | | "Pontuação:" own score, "Ranking" toggle, "Voltar" with confirm "Certeza ao sair do Julgamento TM?" | 4518 |
| `view.VehicleTeamView` | | Team members HP | 4517/4513 |
| `view.VehicleBossDownTimeView` | | "Atualização do Chefão / Atualização de Habilidade / Ressuscitação" countdowns | local timers |
| `view.VehicleReviveView` | | Revive countdown while dead | `rebornTime` |
| `view.VehicleAccountFrame` (462x485) | Resultado das Ruínas Arcaicas (`vehicle.sortTitle`) | Final ranking and rewards | 4514 |

On enter the client hides MainToolBar, TopToolsBar, TaskTraceBar, sets `KeyBoardRegister.vehicleFlag` and forces chat channel 6 (`M17/com/map/vehicle/VehicleSceneController.as:52-75`).

## 3. Routes (client to server)

All in-scene packets go through `socket.sendProtobuffer(pkg, msg, BaseManager.sendVehicleByteCount++)`, a per-session sequence number (`M17/com/map/vehicle/net/VehicleSocketOutManager.as:47-48`).

### B1. Move

- Senders: `AvatarPathWalkAi.nodePaths` sends the next up to 3 path tiles every second step, `walkOver` sends the final tile (`M17/com/road/mapengine/ai/astar/AvatarPathWalkAi.as:80-122`); before casting or picking up, the current tile is sent to stop (`M17/com/map/vehicle/action/CastAction.as:145`, `action/PickupAction.as:72`).
- Sender method: `VehicleSocketOutManager.sendCampaignArmyMove(playerId, points)` (`VehicleSocketOutManager.as:51-83`).
- Client checks: model exists, `playerId` is self.
- Route: C to S 8615 (0x21a7) `C_VEHICLE_MOVE`, `vehicle.VehicleMoveMsg`:
  - `playerId` (#1, INT32): self id.
  - `timestamp` (#2, INT32): not set.
  - `path` (#3, Position, repeated): tiles `{x (#1, INT32), y (#2, INT32)}`.
  - `serverName` (#4, STRING): not set.
- Server: validate walkability and speed, update position, broadcast 4519 to the other players (the client ignores 4519 for itself, `VehicleSocketManager.as:401-404`). Moving cancels the 10 s spawn protection (help text).

### B2. Cast skill

- UI: key 1/2/Q or skill icon, then click a target or ground (`M17/com/map/vehicle/VehicleCharacterController.as:80-200`), cast bar of `CastTime`, then `CastAction.sendUseSkill` (`M17/com/map/vehicle/action/CastAction.as:254-313`).
- Client checks: not stunned; cooldown `CoolDown` elapsed; match time left > 0; uses left when `Maximum > 0`; own HP > 0 ("Aguardando ressuscitação, não é possível atacar"); not already casting; target rules by `InjuryEffect`/`IFF` (IFF 1 enemy only, not dead "Alvo está morto, não é possível atacar", target without buff 4 "Invencível"; IFF 2 ally only); range `AttackRange`; the shot stops at the first barrier tile on the line for `InjuryEffect == 1`.
- Route: C to S 8616 (0x21a8) `C_VEHICLE_ATTACK`, `vehicle.VehicleAttackReqMsg`:
  - `skill_id` (#1, INT32): skill template id.
  - `attack_type` (#2, INT32): not set.
  - `sufferer_npc_id` (#3, INT32): first NPC target id (boss/node) if any.
  - `suffererId` (#4, INT32, repeated): player targets (single target, or all players within `DamageCoverage` of the point for area skills).
  - `effectX` (#5, INT32), `effectY` (#6, INT32): impact tile.
  - `suffererServerName` (#7), `suffererNpcIdArray` (#8), `attack_server_name` (#9): unused here (snow battle only).
- After sending, the client starts the cooldown and decrements the use count locally (`CastAction.as:315-319`).
- Server: re-validate everything, compute damage and buffs, broadcast 4520 (and 4522 for buffs, 4521 for skill count changes).

### B3. Pick up prop

- UI: walk onto a box and click; 1.5 s collect animation; the request is sent after 800 ms (`M17/com/map/vehicle/action/PickupAction.as:65-115`).
- Client checks: own HP > 0 ("Aguardando ressuscitação, não é possível abrir o baú"); box still present ("Coleta fracassada, báu já desapareceu"); moving breaks the pickup ("Coleta interrompida").
- Route: C to S 8617 (0x21a9) `C_VEHICLE_PICK_PROP`, `vehicle.VehiclePickPropMsg` {`propNodeId` (#1, INT32); `playerId` (#2), `serverName` (#3) unused}.
- Server: if the node exists and is in range, mark it disposed (4474 with `state = 1`), apply its effect: a skill into slot 3 (4521) or a buff (4522).

### B4. Leave match

- UI: "Voltar" confirm (`M17/com/map/vehicle/view/VehicleRightView.as:134-166`) or bottom exit (`view/VehicleBottomView.as:441-445`).
- Route: C to S 8610 (0x21a2) `C_VEHICLE_LEAVE_CAMPAIGN`, empty body (`VehicleSocketOutManager.as:94-98`).
- Client returns to space after 500 ms if no answer.
- Server: remove the player, broadcast 4523 `VehicleExitMsg`; the leaver gets no result reward (A, matching the snow battle rule).

### Unused routes

8587 `C_VEHICLE_SYNC_POSITION`, 8588 `C_VEHICLE_SWITCH_MONITOR` (`VehicleSwitchMonitorMsg` {`node_id` #1, `playerId` #2}) and their replies 4477/4478 have no client code. Do not implement.

## 4. Server messages (server to client)

Listeners: `VehicleSocketManager.addSocketEvent` (`M17/com/map/vehicle/net/VehicleSocketManager.as:112-126`). Packets that arrive while the scene loads are buffered by `VehicleSocketDataProxy` (`CM/proxy/scene/VehicleSocketDataProxy.as:16-30`) and replayed.

| Opcode | Message | Receiver (file:line) | When | Client effect |
|---|---|---|---|---|
| 125 `U_C_CAMPAIGN_CREATE` | `room.RoomCreatedMsg` (see [trial-lobby.md](trial-lobby.md)) | `__createVehicleHandler` :154-158, `createMapModel` :774-787 | first packet | creates `VehicleModel(3001)`, `createType` |
| 4517 (0x11a5) `U_C_VEHICLE_CAMPAIGN_LIST_RSP` | `vehicle.PlayerVehicleListMsg` {`vehicles` #1 repeated `PlayerVehicleMsg`} | `__initPlayerListHandler` :160-259 | right after 125, full roster | entries without `playerId` = boss HP update; others create/update players: `templateId`, `team`, `grade` (control level), `trans_grade`, `changeBranch`, `head`, `hp`, `id`, `name`, `consortia`, `buffState` (buff template ids), `x`, `y`, `appellId`, `vip`, `vipType`, `rebornTime` |
| 4513 (0x11a1) `U_C_VEHICLE_JOIN` | `PlayerVehicleListMsg` | `__playerJoinHandler` :261-342 | player joins or full state refresh of a player (HP change, revive) | same merge (only players) |
| 4523 (0x11ab) `U_C_VEHICLE_EXIT` | `vehicle.VehicleExitMsg` {`playerId` (#1, INT32)} | `__playerExitHandler` :344-358 | player left; also the kick-out of self | self: `returnToSpace`; others removed |
| 4519 (0x11a7) `U_C_VEHICLE_MOVE` | `VehicleMoveMsg` {`playerId` #1, `timestamp` #2, `path` #3 repeated Position, `serverName` #4} | `__playerMoveHandler` :365-429 | broadcast of B1 | other tanks walk (A* from current tile to `path[0]`, then the path); own id ignored |
| 4520 (0x11a8) `U_C_VEHICLE_ATTACK_RSP` | `vehicle.VehicleAttackRspMsg` {`skill_id` (#1, INT32), `npcHurtDataList` (#2, HurtDataMsg, repeated), `playerHurtDataList` (#3, HurtDataMsg, repeated), `effectX` (#4), `effectY` (#5), `attackerId` (#6, INT32), `serverName` (#7), `attackTyep` (#8, INT32: 1 player attacker, other = NPC/boss attacker)} | `__playerAttackHandler` :484-568 | every resolved cast, by players and by boss/towers | without `skill_id`: plain hit on `playerHurtDataList[0]`; else plays the cast from attacker with hurt lists |
| 4522 (0x11aa) `U_C_VEHICLE_SYNC_BUFF` | `room.VehicleBuffListMsg` {`playerBuffStates` (#1, VehicleBuffStateMsg, repeated), `npcBuffStates` (#2, repeated)}; `VehicleBuffStateMsg` {`id` (#1, INT32) instance id, `buffId` (#2, INT32) template, `state` (#3, INT32: 0 add, 1 remove, 2 tick), `playerId` (#4, INT32) owner (node id for NPCs), `effectValue` (#5, INT32) tick HP delta, `serverName` (#6)} | `__playerBuffHandler` :431-470 | buff add/remove/tick | buff icons, stun, speed, HP numbers (`data/VehicleNode.as:94-128`) |
| 4521 (0x11a9) `U_C_VEHICLE_SYNC_SKILL` | `room.VehicleSkillListMsg` {`skillId` (#1, INT32), `state` (#2, INT32: 1 remove), `curSum` (#3, INT32) uses left} | `__playerSkillHandler` :472-482 -> `VehicleSkillbag.updateSkill` (`data/VehicleSkillbag.as:59-80`) | prop picked (new skill into slot 3), count changes, skill expired | slot update |
| 4474 (0x117a) `U_C_VEHICLE_NPC_NODE` | `vehicle.VehicleNpcNodeListMsg` {`vehicleNpcNode` #1 repeated `VehicleNpcNodeMsg`}; node: `node_id` (#1), `type` (#2: 0 boss, 1 trap, 2 prop), `cur_x` (#3), `cur_y` (#4), `state` (#5: 0 exists, 1 disposed), `hp` (#6), `name` (#7), `sonType` (#8, resource id), `heroTempId` (#9), `resource` (#10: 1 = animated NPC avatar, else static box), `nameColor` (#11), `rest_x` (#12), `rest_y` (#13), `team` (#14, trap owner), `path` (#15, repeated), `skillBuffList` (#16, SkillBuffMsg {`templateId` #1, `type` #2}, repeated) | `__nodeListHandler` :570-648 | initial nodes, spawn, despawn, boss refresh | add or update nodes; `type 0` sets `bossRefreshed` |
| 4518 (0x11a6) `U_C_VEHICLE_DETAILE` | `vehicle.VehicleCampaignDetailMsg` {`campaignId` (#1), `campaignName` (#2), `redTeamScroe` (#3), `blueTeamScroe` (#4), `myScroe` (#5), `remainsTiem` (#6, seconds left), `winner` (#7), `scroeList` (#8, VehicleScroeListMsg, repeated), `my_order` (#9), `my_userid` (#10), `has_reward` (#11), `my_kill_count` (#12), `campaignStartTime` (#13)} | `__campaignInfoHandler` :650-682 | on enter and on every score change | team and own scores, per player score (`playerId`, `playerScroe`), time |
| 4524 (0x11ac) `U_C_VEHICLE_BOSS_ATTACK_TIP` | `VehicleAttackRspMsg` (only `effectX`, `effectY`) | `__bossAttackNoticeHandler` :741-750 | before a boss area attack | warning marker at the tile |
| 4514 (0x11a2) `U_C_VEHICLE_END` | `VehicleCampaignDetailMsg` with `winner` (team id, 3 = both win) and `scroeList`: `playerId` (#1), `playerScroe` (#2), `playerExp` (#3) control EXP gained, `awardPropId` (#4), `awardSum` (#5), `ladderPropId` (#6), `ladderSum` (#7), `awardPropId_new` (#8), `awardSum_new` (#9), `server_name` (#10), `kill_count` (#11), `order` (#12), `nick_name` (#13), `score_change_time` (#14), `pickSkillCount` (#15), `enterSeq` (#16) | `__campaignEndHandler` :684-739 | match end | stops listening; `AccountAction` opens `VehicleAccountFrame` after returning to space (`action/AccountAction.as`); reward 1 = `awardSum`, EXP = `playerExp`, reward 2 = `ladderSum` |

`HurtDataMsg`: `affecteId` (#1, INT32) target id, `value` (#2, INT32) HP delta, `serverName` (#3), `damageType` (#4), `leftTime` (#5).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Tile size | 20 px; all wire coordinates are tiles | `VehicleSocketManager.as:407-408,517-518`, `CastAction.as:275-278` |
| Skill slots | slot 1 `NormalSkill`, slot 2 `GeniusSkill` (uses = `Maximum`), slot 3 granted by props via 4521 | `VehicleSkillbag.as:30-38,59-80` |
| Match time | from `MatchOfVehicleTime` window end; `remainsTiem` seconds | `M17/com/map/vehicle/VehicleModel.as:356-413` |
| Boss spawn | 300 s after match start (UI countdown hidden once a type 0 node arrives) | `M17/com/map/vehicle/view/VehicleBossDownTimeView.as:98-121` |
| Skill box refresh | every 180 s | `VehicleBossDownTimeView.as:107,118-121` |
| Revive cycle | global, every `revivalTime` = 30 s (all dead players revive together) | `VehicleModel.as:415-425`, `TPL/ConfigInfos.xml`; help "Sistema em certos períodos de tempo ressuscitará todos os jogadores mortos" |
| Spawn protection | 10 s, cancelled by moving or attacking | `vehicle.helpTxt01` item 3 |
| Dead players | can move, cannot attack or collect | `vehicle.helpTxt01` item 5 |
| End | team score gap reaches 10000, or one side has 0 players | `vehicle.helpTxt01` item 6 |
| Rewards | one result reward per round | `vehicle.helpTxt01` item 7 |
| Result box tier | own rank by score desc: 1 Diamante, 2 Ouro, 3 Prata, 4 Bronze, 5 Ferro, 6..8 "Pedra Rúnica Básica"; score < 200 forces tier 8 | `M17/com/map/vehicle/view/VehicleAccountBottomView.as:146-197` |
| Result icons | win chest "Baú da Vitória" / lose "Baú da Derrota"; EXP "EXP. de Controle da Artilharia TM" | `VehicleAccountBottomView.as:134-142` |
| Battle stats | vehicle template `Attack`, `Defence`, `Hp`, `Dodge`, `Speed` plus control bonus HP `+100*(lvl-1)`, attack `+2*(lvl-1)`, defence `+1*(lvl-1)` | `CM/mvc/module/vehicle/DaimonModel.as:53-81` (A: same formula server-side) |
| Damage | `Power`% of attacker attack (`Power2` = flat part), reduced by defence; area skills hit everything within `DamageCoverage` px of the point; `Dodge` % miss | skill descriptions in `TPL/VehicleSkillTempInfos.xml` (A: exact defence formula unknown) |
| Buff effect types | 1 add attack, 2 debuff immunity, 4 stun, 5 stun immunity, 6 speed change, 7 slow immunity, 8 HP over time, 9 lifesteal, 10 extra damage, 11 heal, 12 damage immunity, 13 shield, 14 on-hit stun chance, 15..17 trap DOT/slow/burn, 18 dodge, 19 transform | `M17/com/map/vehicle/data/VehicleSkillEffectType.as`, `TPL/VehicleBuffTempInfos.xml` |
| Buff proc | `TogglePercent` chance; `Duration` ms (-1 permanent); `Interval` ms ticks | `TPL/VehicleBuffTempInfos.xml` |

Scoring (A, from help texts of the related "vehiclemap" mode: "a cada jogador que derrotar, receberá 5 pontos. A cada dano causada ganhará 1 ponto"): per player score = damage points + kill points; team score = sum of member scores.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `TPL/VehicleSkillTempInfos.xml` (77) | skill | `TemplateId`, `ActionId` (animation), `TemplateName`, `Icons`, `CastTime` ms, `CoolDown` ms, `InjuryEffect` (0 self buff, 1 single target, 2 area, 3 passive on-hit, 4 trap, 5 transform), `IFF` (1 enemy, 2 ally/self), `Power` %, `Power2` flat, `Buffs` "buffId,chance", `Maximum` uses (-1 infinite), `AttackRange` px, `DamageCoverage` px radius, `Description` |
| `TPL/VehicleBuffTempInfos.xml` (44) | buff | `TemplateId`, `Name`, `Icon`, `EffectType`, `EffectValue`, `EffectPercent`, `TogglePercent`, `PrepareTime`, `Duration`, `Interval`, `LastEffect`, `Description` |
| `TPL/VehicleObjectTempInfos.xml` | vehicles (Type 1), boss 2191 (Type 2), towers/props of other modes | stats |
| `TPL/ConfigInfos.xml` | `MatchOfVehicleTime`, `revivalTime`, `VehicleMaxWaveNum`, `VehicleWaveNpcConfig1..10` (NPC waves "载具防守波数", not used by the 3001 client) | |

Skills used by 3001 player vehicles: 1 "Munição Normal" (100%, CD 3 s, range 500), geniuses 1001-1004 (passive, InjuryEffect 3: 10% +50% damage, 10% lifesteal 50%, 10%/15% stun 3 s). Prop skills 2-13 (Ataque Laser 180%, Destruição Central 150% + 50% stun, Spray de Corrosão, Surto de Fúria area 200%, Ataque Congelante area + slow, Armadilha Destrutiva trap 300, Asas do Vento speed, Proteção Sagrada shield 1500, Posse de Ares immunity, Benção da Deusa heal 1500, Bombardeio Estrondoso). Boss 2191 normal skill 8 "Ataque Chefão" (area 150%).

## 7. Persistent state

The match is in memory. Persist results:

```sql
CREATE TABLE artillery.matches (
  match_id      BIGSERIAL PRIMARY KEY,
  campaign_id   INTEGER NOT NULL DEFAULT 3001,
  started_at    TIMESTAMPTZ NOT NULL,
  ended_at      TIMESTAMPTZ,
  red_score     INTEGER NOT NULL DEFAULT 0,
  blue_score    INTEGER NOT NULL DEFAULT 0,
  winner_team   SMALLINT CHECK (winner_team IN (1, 2, 3))
);

CREATE TABLE artillery.match_players (
  match_id        BIGINT NOT NULL REFERENCES artillery.matches(match_id) ON DELETE CASCADE,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  team            SMALLINT NOT NULL CHECK (team IN (1, 2)),
  vehicle_id      INTEGER NOT NULL,
  score           INTEGER NOT NULL DEFAULT 0,
  kill_count      INTEGER NOT NULL DEFAULT 0,
  final_rank      SMALLINT,
  control_exp     INTEGER NOT NULL DEFAULT 0,
  award_item_id   INTEGER,
  award_count     INTEGER NOT NULL DEFAULT 0,
  ladder_item_id  INTEGER,
  ladder_count    INTEGER NOT NULL DEFAULT 0,
  left_early      BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (match_id, player_id)
);
CREATE INDEX match_players_player_idx ON artillery.match_players (player_id);
```

## 8. Backend implementation notes

- One `VehicleMatch` actor per match: tick 100 ms (A); holds walk grid of map 3001 (from the client map data), players, nodes, buffs, timers.
- Bootstrap order per player: 125, 4517 (all players), 4474 (all nodes), 4518 (scores, `remainsTiem`), then 4513 to others for each joiner.
- `artillery::battle_scene::handle_move` (8615): ignore if dead-stunned (stun buff), validate each step adjacency and walkability, rate-limit by `Speed`; broadcast 4519; remove spawn protection.
- `artillery::battle_scene::handle_attack` (8616): validate alive, skill in slot, cooldown, uses, range, line of sight; resolve targets server-side (do not trust `suffererId` blindly; intersect with server-computed area); apply damage, proc genius passive and `Buffs`; broadcast 4520, 4522; update uses (4521 to caster); on death set `rebornTime` and push 4513; add score and broadcast 4518.
- `artillery::battle_scene::handle_pick_prop` (8617): validate distance and node state; dispose node (4474 `state = 1` to all); grant skill (4521) or buff (4522).
- `artillery::battle_scene::handle_leave` (8610): broadcast 4523, mark `left_early`.
- Timers: boss spawn at 300 s (4474 type 0); boss AI casts with 4524 warning then 4520 `attackTyep != 1`; prop refresh every 180 s; global revive every 30 s (4513 with HP restored, protection buff 4 "Invencível" 10 s, A).
- End check after each score change and each death: gap >= 10000 or a team empty, or time over. Send 4514 to every player with `scroeList` (rank, rewards, EXP), persist in one transaction: `matches`, `match_players`, control EXP via [garage.md](garage.md) (may trigger auto unlock 4516), items via inventory, 4515 profile.

## 9. Open questions and assumptions

- (A) Damage, defence and dodge formulas; scoring points per damage and per kill for campaign 3001.
- (A) Reward items and counts per rank tier (no template in the client; names "Caixa de Runas de Diamante..Ferro", "Pedra Rúnica Básica", "Pedra Rúnica Universal").
- (A) Map walk grid for map 3001 must be extracted from the client map resources.
- (A) `winner = 3` means draw where both sides count as winners.
- `VehicleWaveNpcConfig*` describe a defence mode not reachable in this client.

## 10. Implementation checklist

- [ ] Match actor with tick loop, walk grid, team assignment.
- [ ] Bootstrap 125, 4517, 4474, 4518, 4513.
- [ ] 8615 move validation and 4519 broadcast.
- [ ] 8616 skill resolution (single, area, passive, trap, self buff), 4520, 4522, 4521.
- [ ] 8617 pickup, node dispose, slot 3 skill.
- [ ] 8610 leave and 4523.
- [ ] Boss spawn, boss attack with 4524 warning.
- [ ] Prop refresh 180 s, global revive 30 s, spawn protection.
- [ ] End conditions and 4514 with ranking and rewards.
- [ ] Tables `matches`, `match_players`; control EXP update and 4515.
- [ ] Tests: cast on cooldown, attack while dead, pickup race between two players, score gap end, disconnect mid-match.
