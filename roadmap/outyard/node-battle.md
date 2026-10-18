# Terrálem node battlefield

Feature [outyard](README.md), module `node-battle`. Aliases in [README.md](README.md).

## 1. Overview

- A declared land node ([land-map.md](land-map.md)) opens a 15 minute battlefield of 11 positions ("áreas") for up to 60 players (`huge_head_node_battle_field_join_max`, both sides). Position 10 is the attacker spawn, 11 the defender spawn; positions 1..9 form a 3 x 3 grid linked as in `OY/scene/OutyardRouteView.as:546-594`.
- Players move one link at a time ("Apenas pode caminhar até o ponto mais perto!") through transmitters with a cooldown, attack the position they stand on (fight a player of the other side there, a PvP battle), or guard a position owned by their side.
- Score: each owned position yields `huge_head_node_battle_area_score = 4` points (assumption: per scoring tick), each won fight `huge_head_node_battle_kill_score = 10`; the first side to `huge_head_node_battle_max_score = 2000`, or the higher score when time ends, wins the node ("A equipe que obter os pontos máximos primeiro ou após do tempo de batalha, a equipe com maior número de pontos irá vencer.").
- Moving is not allowed during preparation ("Não é possível usar o transmissor durante a preparação de batalha!") nor from a spawn into the other spawn.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OY/scene/OutyardRouteView.as` | "Resfriamento do transmissor", "Em ataque", "Pessoas:{0} Pontos:{1}" | Battlefield map with paths, own avatar walking between positions, score bars, tower counts, time left; 1 s timer with 9595 op 2 every 10 s (`:111-600`) | push 351/352 with `op = 1` (`OY/scene/OutyardMapFrame.as:306-325`), or re-entering the map while `curPos != 0` (`:456-470`) | 351, 352 |
| `OY/scene/RouteNodeView.as` | "Pessoas:{0}"; buttons attack / guard | Position: owner, players per side, attack/guard buttons for the own position (`:52-217`) | route view | `HugeHeadNodeBattleAreaMsg` |

## 3. Routes (client to server)

Send 9595 (0x257b) `C_HUGE_HEAD_NODE_BATTLE_REQ`, `HugeHeadNodeBattleReqMsg` (package `hugehead`): `op` (#1, INT32), `pos` (#2, INT32). Sender `OutyardManager.OperateRoute(op, pos)` (`OM:281-288`). Op constants `OMOD/OutyardModel.as:41-57`: 1 open, 2 heartbeat, 3 close, 4 warp, 5 attack, 6 defence, 7 update, 8 battle start, 9 battle end (7..9 are push ops).

Joining is done with 9594 op 5 ([land-map.md](land-map.md)).

| # | op | UI and sender | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| N1 | 2 heartbeat | route view every 10 s (`OY/scene/OutyardRouteView.as:246-252`), map reopen (`OY/scene/OutyardMapFrame.as:462-470`) | | | 351 delta, 352 delta (or `op = 1` full on reopen) |
| N2 | 3 leave | close confirm "Deseja sair da batalha?" (`OY/scene/OutyardMapFrame.as:641-672`) | | | 352 `op = 3` (client clears `curPos`) |
| N3 | 4 warp | click a linked position (`OY/scene/OutyardRouteView.as:325-353`) | not the current position; linked; not 10/11 ("Não é possível usar o transmissor no local inicial!"); node not in preparation; transmitter and attack cooldowns ("Transmissor em resfriamento", "Ataque em resfriamento") | `pos` | 352 with the new `pos` and `coolDown` (ms); 351 area counts for everyone |
| N4 | 5 attack | attack button (`OY/scene/RouteNodeView.as:135-139` -> `OY/scene/OutyardRouteView.as:427-438`) | client attack cooldown 10 s | | battle start (battleType 3857 or 3858, assumption) or immediate capture of a neutral position; 351 with `belongForce`, scores |
| N5 | 6 defence | guard button (`OY/scene/RouteNodeView.as:141-145`) | position owned by own side and not already guarding | | 352 `inGuard = true` |

## 4. Server messages (server to client)

Receivers in `OMOD/OutyardModel.as` via `OM:157-171`.

### 351 (0x015f) `U_C_HUGE_HEAD_NODE_BATTLE_FIELD`

`HugeHeadNodeBattleFieldMsg`: `op` (#1, INT32) 1 full or delta; `battleFieldUid` (#2, STRING); `nodeId` (#3, INT32) land node; `attackForce` (#4), `attackScore` (#5), `attackCount` (#6) players; `defenceForce` (#7), `defenceScore` (#8), `defenceCount` (#9); `battleStartTime` (#10, INT64), `battleEndTime` (#11, INT64); `areaList` (#12, `HugeHeadNodeBattleAreaMsg`, repeated: `pos` #1 1..11, `belongForce` #2 owner force (0 neutral), `attackCount` #3, `defenceCount` #4 players standing there); `nodeState` (#13, INT32) 2 preparation, 3 battle. Handler `battleFieldHandler` (`OMOD/OutyardModel.as:225-313`): op 1 stores the message and opens the view (`OUTYARD_ROUTE_VIEW`), other ops patch present fields and area entries by `pos` (`ROUTE_BATTLE_FIELD`). Towers shown = owned positions minus one (`OMOD/OutyardModel.as:426-450`).

### 352 (0x0160) `U_C_HUGE_HEAD_NODE_BATTLE_USER_RSP`

`HugeHeadNodeBattleUserMsg`: `op` (#1, INT32) 1 full, 3 left, else delta; `userUid` (#2, STRING); `pos` (#3, INT32) current position; `coolDown` (#4, INT32) transmitter cooldown ms; `side` (#5, INT32) 1 attack, 2 defence; `inGuard` (#6, BOOL); `nodeBattleFieldUid` (#7, STRING). Handler `battleUserHandler` (`OMOD/OutyardModel.as:315-368`).

## 5. Rules and formulas

- Links (`OY/scene/OutyardRouteView.as:546-594`): 1:{10,2,4}, 2:{1,3,5}, 3:{2,6,11}, 4:{10,1,7,5}, 5:{2,4,6,8}, 6:{11,3,9,5}, 7:{10,4,8}, 8:{5,7,9}, 9:{11,6,8}, 10:{1,4,7}, 11:{3,6,9}.
- Config: `huge_head_node_battle_field_join_max = 60`, `huge_head_node_battle_field_time = 15`, `huge_head_node_battle_area_score = 4`, `huge_head_node_battle_max_score = 2000`, `huge_head_node_battle_kill_score = 10`.
- Transmitter cooldown value is server provided (`coolDown`); client attack cooldown 10 s.
- Battle types 3857 and 3858 return to the map (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:386-393`); which one is used here is an assumption (3858).

## 6. Templates

Config keys above; positions are hard coded in the client.

## 7. Persistent state

Live battlefield state is in memory; persist only the result.

```sql
CREATE TABLE outyard.node_battle (
  node_battlefield_uid TEXT        PRIMARY KEY,
  battlefield_uid      TEXT        NOT NULL REFERENCES outyard.battlefield(battlefield_uid) ON DELETE CASCADE,
  node_id              SMALLINT    NOT NULL,
  attack_force         SMALLINT    NOT NULL,
  defence_force        SMALLINT    NOT NULL,
  attack_score         INTEGER     NOT NULL DEFAULT 0,
  defence_score        INTEGER     NOT NULL DEFAULT 0,
  winner_force         SMALLINT,
  started_at           TIMESTAMPTZ NOT NULL,
  ended_at             TIMESTAMPTZ
);

CREATE TABLE outyard.node_battle_player (
  node_battlefield_uid TEXT     NOT NULL REFERENCES outyard.node_battle(node_battlefield_uid) ON DELETE CASCADE,
  player_id            BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  side                 SMALLINT NOT NULL CHECK (side IN (1, 2)),
  kills                INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (node_battlefield_uid, player_id)
);
```

## 8. Backend implementation notes

- `outyard::node_battle::handle_request` (9595) dispatching ops 2..6; joining comes from `outyard::land_map::handle_join_battle`.
- In memory actor per node battlefield: players (side, pos, cooldown, guard), 11 areas, scores; ticks every few seconds to add area score; broadcasts 351 deltas to participants; ends at `battleEndTime` or 2000 points, writes `node_battle`, notifies the land map.
- Warp: validate link, spawn rule, state 3, cooldown; set pos and cooldown.
- Attack: if the area has enemies, start a PvP battle with one of them (guards first, assumption); the winner's side takes the area if no enemy remains; +10 score per win.

## 9. Open questions and assumptions

- Battle type, scoring tick and cooldown durations.
- Behavior when a player disconnects (removed after heartbeat timeout, assumption 30 s).

## 10. Implementation checklist

- [ ] Screens: route view, position nodes
- [ ] Routes N1..N5 on 9595
- [ ] Server messages 351, 352
- [ ] Tables `outyard.node_battle`, `outyard.node_battle_player`
- [ ] Node battlefield actor with scoring and timers
- [ ] Test: link and spawn rules, max 60 players
