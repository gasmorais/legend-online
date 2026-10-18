# Hermitage war battlefield

Module `hermitage_war::battlefield`. Citation prefixes: see [README.md](README.md).

## 1. Overview

Scene `SECRET_WAR_SCENE` (`M3/war2023/view/SecretWarSecen.as`). A fixed graph of 17 forts. Node 7 is the Blue birth node, node 11 the Red birth node; the others start neutral. Players walk along edges (5 s per edge), occupy forts (5 s), defend own forts, and fight enemies they meet (battle type 3908). Every occupied fort produces points for its camp and for the occupying players at a fixed interval. The server is authoritative; the client shows interpolated movement from `moveStep`.

## 2. Screens

| Class | pt-BR title | Purpose | Data shown |
|---|---|---|---|
| `war2023.view.SecretWarSecen` | | Scene root; on enter hides TopToolsBar, shows MainToolBar/Chat; resumes a pending move (`SecretWarSecen.as:60-80`) | 544 |
| `view.SecretWarMapView` + layers `SecretwarNodeLayer`, `SecretwarWalkLayer`, `SecretwarFightLayer`, `SecretwarMaskLayer` | | Map 17 forts (`SecretWarNodeItem`), walking heads, fight markers, preparation dim and countdown (`SecretwarStartCDView`), death dim | node and player lists |
| `item.SecretWarNodeItem` | | Fort icon; click opens a menu: Mover / Ocupação / Defesa (Desistir) / Detalhes; counts "blue - red" or "?" when not visible (`M3/war2023/item/SecretWarNodeItem.as:270-300,505-640`) | node type, players |
| `view.SecretwarTopView` | | Blue score, red score (fly-up deltas), fort counts, player counts, round countdown (`M3/war2023/view/SecretwarTopView.as:99-133`) | 545 info |
| `view.SecretwarRightBottomView` | | Own camp "Azul"/"Vermelho", own score, rank button (openType 3), "locate me" | 546 |
| `war2023.SecretwarNodeFrame` (473x475; openType 1) | Informações da Base / Informações do Cristal (birth nodes) | Fort details: camp ("Formação neutra/Azul/Vermelha"), state "Pacífico"/"Disputando"/"Invencível", production "{0} pontos/{1} segundos", member list by camp with states | node + players |

## 3. Routes (client to server)

C to S 9725 (0x25fd) `C_SECRET_WAR_CLIENT_OP`, `player.PlayerOpMsg` {`op` (#1, INT32), `nodeId` (#10, INT32), `type` (#2, INT32)}, sender `SecretWarManager.gameOp` (`SWM:354-362`).

Menu availability (`SecretWarNodeItem.refreshMenu`, `M3/war2023/item/SecretWarNodeItem.as:505-640`), with `adjacent = node.connects contains selfPlay.curNodeId`, `moving = selfPlay.state == 3`:
- birth node (type 3/4): "Mover" only if it is the own camp's birth node and adjacent;
- other node, not the current one, adjacent: "Mover" shown if the current node or the target node belongs to the own camp (disabled with "Movendo" while moving);
- target node of the own camp: "Defesa" (on the current node toggles "Defesa"/"Desistir"; on an adjacent node moves there and defends);
- neutral or enemy target: "Ocupação" on the current node (disabled "Ocupando" while occupying) or on an adjacent node when the current node is own camp;
- always "Detalhes" (node frame).

Common client refusals: game not started "Aguarde o início do combate" (`secretwar.noStartGame`, move only); dead "Aguardando a ressuscitação..." (state 2); moving "Movendo-se..." (state 3); occupying "Ocupando..." (state 6).

| # | Action | Sender | Extra client checks | Request | Responses |
|---|---|---|---|---|---|
| B1 | Move to adjacent fort | `moveHandler` / `forceMove` (`SecretWarNodeItem.as:645-691`) | while defending (state 5) confirm "Você está defendendo o Forte. Deseja se mover?" | `op = 3` OP_MOVE, `nodeId` target, `type = -1` | 545 with own `SecretWarPlayerMsg` (state 3, `toNodeId`, `moveStep`), 549 to others; on arrival 545 (state 0, `curNodeId`) |
| B2 | Resume pending move | `SecretWarSecen.enterOver` when `selfInfo.waitMove` (`SecretWarSecen.as:72-76`) | none | `op = 3`, `nodeId = -1` | as B1 (server continues the stored move, A) |
| B3 | Occupy | `occHandler` / `moveToOcc` (`SecretWarNodeItem.as:693-733`) | while defending confirm "Deseja interromper a defesa e ir para a ocupação?" | `op = 4` OP_OCCUPY, `nodeId` | 545: state 6 with `cdTime` (ms left) for the occupier; after `secret_war_cd_time[1]` s node `type` changes to the camp, `isPop = true` |
| B4 | Defend / stop defending / change defended fort | `defHandler` / `changeDefNode` (`SecretWarNodeItem.as:735-785`) | defending another fort: confirm "Deseja trocar a defesa do Forte?" | `op = 5` OP_DEFEND, `nodeId`; `type = 1` when cancelling on the current node, else `-1` | 545 state 5 or 0 |
| B5 | Node details | `infosHandler` (`SecretWarNodeItem.as:787`) | none | local only (`secretwar` openType 1) | none |
| B6 | Leave | MainToolBar exit in `SECRET_WAR_SCENE`: confirm "Caso saia na metade você entrará em status de exílio, não podendo combater novamente por 5 minutos. Deseja mesmo sair da Batalha do Eremitério?" (`CM/ui/maintoolbar/MainToolBar.as:1700-1704,1906-1915`) | confirm | `op = 2` OP_LEAVE | 545 to others with state 1 (removed); client returns to space immediately and clears the model |

## 4. Server messages (server to client)

Receivers in `SWM`.

| Opcode | Message | Receiver | When | Effect |
|---|---|---|---|---|
| 544 (0x0220) `U_C_SECRET_WAR_CREATE` | `SecretWarCreateMsg` {`info` (#1, SecretWarInfoMsg), `self` (#2, SecretWarSelfMsg), `nodes` (#3, SecretWarNodeMsg, repeated), `players` (#4, SecretWarPlayerMsg, repeated)} | `__creatMapHandler` (`SWM:128-150`) | enter, reconnect | resets the model, sets scene |
| 545 (0x0221) `U_C_SECRET_WAR_UPDATE` | `SecretWarUpdateMsg` {`info` (#1), `nodes` (#2, repeated), `players` (#3, repeated)}, deltas | `__updateWarHandler` (`SWM:230-244`) | any change: scores, node owner, player state | merges by `nodeId` and by `userId_serverName` |
| 546 (0x0222) `U_C_SECRET_WAR_SELF` | `SecretWarSelfMsg` {`camp` (#1, INT32: 1 blue, 2 red), `score` (#2, INT32) personal score, `honor` (#3, INT32) Mérito earned, `waitMove` (#4, BOOL) a move is queued} | `__selfUpdateHandler` (`SWM:246-252`) | own score change | right bottom view |
| 549 (0x0225) `U_C_SECRET_WAR_MOVE` | `SecretWarMoveListMsg` {`list` (#1, SecretWarMoveMsg, repeated)}; move: `userId` (#1), `serverName` (#2), `nickName` (#3), `curNodeId` (#4), `toNodeId` (#5), `moveStep` (#6), `headId` (#7) | `__moveHandler` (`SWM:327-352`) | movement batches | Client bug: looks up `"" + userId + serverName` while the list is keyed `userId + "_" + serverName` (`SWM:169` vs `:337`), so 549 updates nothing. Movement must also be carried by 545 player entries |

`SecretWarInfoMsg`: `blueScore` (#1, INT32), `bluePlayerCount` (#2), `blueNodeCount` (#3), `redScore` (#4), `redPlayerCount` (#5), `redNodeCount` (#6), `curTime` (#7, STRING), `preTime` (#8, STRING, end of preparation), `stopTime` (#9, STRING, round end). Dates "YYYY-MM-DD hh:mm:ss" (A, same format as 4590).

`SecretWarNodeMsg`: `nodeId` (#1, INT32 1..17), `type` (#2, INT32: 0 neutral, 1 blue, 2 red, 3 blue birth, 4 red birth), `cdTime` (#3, INT32 ms, protection/occupation timer), `isPop` (#4, BOOL, plays the "+points" production effect once).

`SecretWarPlayerMsg`: `userId` (#1), `serverName` (#2), `nickName` (#3), `camp` (#4), `state` (#5: 0 idle, 1 left, 2 dead, 3 moving, 4 fighting, 5 defending, 6 occupying), `curNodeId` (#6), `toNodeId` (#7, 0 when idle), `headId` (#8), `job` (#9), `cdTime` (#10, ms: occupy countdown or revive), `fightUserId` (#11), `fightNickName` (#12), `fightServerName` (#13), `moveStep` (#14, progress in 40 ms frames, max `moveTime/40`).

Battle 3908 uses the generic battle pipeline (157 prepare ... 4103 result; `docs/battle/README.md`). On end the client returns to the scene with the node frame open (`CM/battle/handler/BattleResultHandler.as:312-321,501-504`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Graph | `1@2,3,4 | 2@1,5 | 3@1,6 | 4@1,9 | 5@2,7,8 | 6@3,10,11 | 7@5,8,12 | 8@5,7,9,12 | 9@4,8,10,13 | 10@6,9,11,14 | 11@6,10,14 | 12@7,8,15 | 13@9,17 | 14@10,11,16 | 15@12,17 | 16@14,17 | 17@13,15,16` | `CM/mvc/module/war2023/SecretWarModel.as:19,113-144` |
| Node pixel positions | `NODE_XY` 17 points (1100,168) ... (1101,1284) | `SecretWarModel.as:17` |
| Birth nodes | 7 Blue (type 3), 11 Red (type 4); never capturable ("Invencível") | `SecretWarModel.as:130-141`, `CM/mvc/module/war2023/SecretwarConst.as:24-30` |
| Node camp | type 1 or 3 -> camp 1; type 2 or 4 -> camp 2 | `CM/mvc/module/war2023/info/SecretWarNodeInfo.as:160-174` |
| Move time | `secret_war_cd_time[0]` = 5 s per edge; `moveMaxStep = moveTime / 40` = 125 | `SecretWarModel.as:47-54` |
| Occupy time | `secret_war_cd_time[1]` = 5 s | same |
| Visibility | enemy fort counts are visible only if the fort or a neighbour belongs to the own camp, else "?" ("Não é possível conferir este Forte") | `SecretWarNodeItem.as:283-300` |
| Production | `secret_war_node_score` = `25,25,10`: each owned fort gives 25 camp points and 25 personal points (split, A) every 10 s | ConfigInfos; `SecretwarNodeView.as:36` shows "{0} pontos/{2} segundos" |
| Kill score | `secret_war_win_score` = consecutive wins: 1st 50/50, 2nd 60/60, 3rd 70/70, 4th 100/100, 5th 120/120, 6th 140/140, 7th 170/170, 8th+ 200/200 (personal, camp) | ConfigInfos |
| Victory | first camp to `secret_war_max_score` = 7500; else higher score at `stopTime` | help item 5 |
| Preparation | before `preTime` moves are refused client-side and the map is dimmed | `M3/war2023/layer/SecretwarMaskLayer.as:50-90` |
| Death | state 2; revive timer in `cdTime` (A: respawn at birth node) | `SecretwarMaskLayer.as:91-100` |
| Leave penalty | 5 min exile | [lobby.md](lobby.md) |

Fights (A): when two enemy players are on the same node, or meet on the same edge, the server sets both to state 4 with `fightUserId`, runs battle 3908 between their armies (PvP, both heroes with their real formations), the loser dies (state 2), the winner gets the streak score and resumes its action. Defenders (state 5) are attacked first by occupiers of an enemy fort; an occupation is interrupted while an alive defender of the fort's camp is present.

## 6. Templates

No dedicated template file; rules come from `TPL/ConfigInfos.xml` `secret_war_*` keys and the constants above.

## 7. Persistent state

War instances are in memory. Persist per war participation for auditing and results ([results.md](results.md)):

```sql
CREATE TABLE hermitage_war.wars (
  war_id        BIGSERIAL PRIMARY KEY,
  band          SMALLINT NOT NULL,
  started_at    TIMESTAMPTZ NOT NULL,
  prep_ends_at  TIMESTAMPTZ NOT NULL,
  ends_at       TIMESTAMPTZ NOT NULL,
  blue_score    INTEGER NOT NULL DEFAULT 0,
  red_score     INTEGER NOT NULL DEFAULT 0,
  win_camp      SMALLINT CHECK (win_camp IN (0, 1, 2))
);

CREATE TABLE hermitage_war.war_players (
  war_id        BIGINT NOT NULL REFERENCES hermitage_war.wars(war_id) ON DELETE CASCADE,
  player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  server_name   TEXT NOT NULL,
  camp          SMALLINT NOT NULL CHECK (camp IN (1, 2)),
  score         INTEGER NOT NULL DEFAULT 0,
  kills         INTEGER NOT NULL DEFAULT 0,
  occupies      INTEGER NOT NULL DEFAULT 0,
  merit         INTEGER NOT NULL DEFAULT 0,
  left_early    BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (war_id, player_id)
);
CREATE INDEX war_players_player_idx ON hermitage_war.war_players (player_id);
```

## 8. Backend implementation notes

- One `SecretWar` actor per instance, tick 1 s (production every 10 s, timers in ms).
- `hermitage_war::battlefield::handle_move` (op 3): validate started (`now >= preTime`), alive, not moving, not occupying, adjacency, camp rule (from or to an own fort; birth node only own); store `toNodeId`, start a 5 s edge timer; push 545 (self + others) and 549.
- `handle_occupy` (op 4): validate node not own camp, not birth node, player on it (or adjacent from an own fort: move then occupy); set state 6, `cdTime = 5000`; on completion set node `type` to the camp, `isPop = true`, update node counts; push 545 and 546.
- `handle_defend` (op 5): `type = 1` cancels; else set state 5 on an own fort (moving first if adjacent).
- `handle_leave` (op 2): state 1 broadcast, mark exile 5 min, `left_early = true`.
- Encounter detection after each state change; start battle 3908 through the battle service with both players; while in battle, both are state 4; the battle result updates states, scores (`secret_war_win_score` by streak), and pushes 545/546.
- End detection: camp score >= 7500 or `now >= stopTime` -> [results.md](results.md).
- Pushes go to every player of the instance (cross-server routing by `serverName`).

## 9. Open questions and assumptions

- (A) Encounter and battle rules (who fights whom, edge encounters, defenders priority).
- (A) Revive delay and position.
- (A) Exact personal share of production (`25,25,10` read as camp 25, personal 25, every 10 s).
- 549 is ignored by the client because of the key bug; the server must still keep 545 complete.

## 10. Implementation checklist

- [ ] Graph, birth nodes, camp derivation.
- [ ] 544 bootstrap; 545 delta encoder; 546 self push; 549 move list.
- [ ] Op 3 move with edge timer and `moveStep`; op 3 with `nodeId = -1` resume.
- [ ] Op 4 occupy timer and ownership change with `isPop`.
- [ ] Op 5 defend / cancel / change.
- [ ] Op 2 leave with exile.
- [ ] Production tick and camp/personal scores.
- [ ] Encounters and battle 3908 integration, streak scoring, death and revive.
- [ ] End detection hand-off to results.
- [ ] Tables `wars`, `war_players`.
- [ ] Tests: move into enemy fort without own neighbour (refused), occupy birth node (refused), simultaneous occupiers, leave during fight.
