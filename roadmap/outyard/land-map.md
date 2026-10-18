# Terrálem land map (huge head)

Feature [outyard](README.md), module `land-map`. Aliases in [README.md](README.md).

## 1. Overview

- Each battlefield has 69 map nodes (`HugeHeadMapNodeTempInfos.xml`): per force a home map (maps 1..4) with a castle (node x00, type 1, cannot be occupied), 11 land nodes and an explore entrance (601..604, type 4); the central map 5 holds 4 land nodes of each force (x12..x15) and the central crystal (500, type 3). 60 land nodes (type 2) can change owner; `InitForce` is the starting owner, `NodeLink` the adjacency.
- During land sessions ([season.md](season.md), 14:00-15:00 and 19:00-20:00) the chairman of a guild declares war on a node ("Declarar batalha"): `huge_head_attack_count = 2` declarations per force per day (+ event "Dia da Fortaleza"). A declared node goes to preparation (state 2, until `battleStartTime`) then battle (state 3, until `battleEndTime`, `huge_head_node_battle_field_time = 15` minutes). Members of the attacker and defender forces join the node battlefield ([node-battle.md](node-battle.md)); other forces can join a side with too few players (help text `desTxt5`). The winner occupies the node.
- Occupied node count gives daily crystals ([season.md](season.md)) and extra crystal collections at the central crystal ("A equipe vencedora pode ocupar este ponto de recurso, pode diariamente coletar adicionalemnte cristal da terralém 1x"); each collection gives `huge_head_dig_reward_count = 200` "Cristais da Terrálem".
- The force notice is edited from the crystal frame.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OY/scene/OutyardMapFrame.as` (full screen, layer 6) | map buttons 1..5; tips "Tempo de Abertura" with session times; "O número de conquistas pode ser usado para coletar cristais da Terralém..." | World map of the battlefield; hides the HUD; sends 9594 op 1 on open and op 2 every 30 s; restores the node battle or explore view when re-entering (`:124-499`); asks before leaving a battle or an explore board (`:621-672`) | `TTB.enterOutyardScene` (openType 3), after outyard battles | 349, 306, 350 |
| `OY/scene/OutyardLandView.as`, `OY/scene/LandNodeView.as`, `OY/scene/OutyardSwordView.as` | | Nodes per map with frames by type and owner; battle swords (`LandNodeView.as:69-118`) | map frame | `nodeDic` |
| `OY/scene/OutyardInfoView.as` | "Poder Azul", "Poder Vermelho", "Poder Roxo"; "Equipe de Ataque {0} ({1} pessoas)", "Equipe de Defesa {0} ({1} pessoas)"; "Resta {0} vez(s) para declarar batalha"; "A equipe vencedora pode ocupar este ponto de recurso..." | Node panel: declare, join attack/defence, collect crystal, enter crystal war (`:89-473`) | node click (`OY/scene/OutyardMapFrame.as:327-365`) | `LandPoint`, 350 |
| `OY/scene/OutyardInfoTopView.as` | "Pontos de Movimento", "Pesquisa"; "Pesquisa da Terralém: Energia necessária..." | Force name, occupied count, action points and explore points with "+" buttons, shop (`:72-306`) | map frame | 311, extra field 15 |
| `OY/OutyardNoticeView.as` | | Force notice text input (120 chars) (`:40-93`) | crystal frame | force `notice` |

## 3. Routes (client to server)

Send 9594 (0x257a) `C_HUGE_HEAD_REQUEST`, `HugeHeadRequestMsg` (fields in [season.md](season.md)), sender `OM:268-279`.

| # | op | UI and sender | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| L1 | 4 DECLARE | "Declarar" (`OY/scene/OutyardInfoView.as:250-287`) | sender is the guild chairman else "Apenas o presidente pode fazer a inscrição"; `myForce.remainAttackCount > 0` else "Hoje você já usou todas as chances de declarar batalha!"; confirm "Deseja atacar esta base? (Resta {0} vez(s) para declarar batalha)"; the panel shows "can attack" only for a type 2 node in state 0 owned by another force and adjacent to an own node (`:356-383`) | `nodeId` | 349 `op = 12` with the node in state 2 and `remainAttackCount - 1`, broadcast to the battlefield |
| L2 | 5 ADD_BATTLE | "Participar" attack / defence (`OY/scene/OutyardInfoView.as:205-222`) | 1 s debounce; node in state 2 or 3 | `nodeId`, `side` 1 attack / 2 defence | 351 `op = 1` and 352 `op = 1` (opens the node battlefield, [node-battle.md](node-battle.md)); error tip when the side is full (60 total, `huge_head_node_battle_field_join_max`) |
| L3 | 6 CHANGE_NOTICE | notice confirm (`OY/OutyardNoticeView.as:85-93`) | max 120 characters | `notice` | 349 `op = 12` with the force `notice` |
| L4 | 8 COLLECT_CRYSTAL | "Coletar" on the crystal node (`OY/scene/OutyardInfoView.as:224-228`) | none client side | | 350 with collections decremented; crystals (-3400) currency push |

## 4. Server messages (server to client)

### 349 (0x015d) `U_C_HUGE_HEAD_BATTLE_FIELD`

`HugeHeadBattleFieldMsg`: `op` (#1, INT32) 1 full or 12 delta; `battleFieldUid` (#2, STRING); `nodeList` (#3, `HugeHeadMapNodeMsg`, repeated: `nodeId` #1, `forceIndex` #2 owner, `nodeState` #3 (0 peace, 2 preparation, 3 battle; 1 unused by the client, assumption "declared"), `battleStartTime` #4 INT64 ms, `battleEndTime` #5 INT64 ms, `attackForce` #6, `defenceForce` #7, `attackCount` #8 players on the attack side, `defenceCount` #9); `forceList` (#4, `HugeHeadForceMsg`, repeated: `forceIndex` #1, `guildList` #2 `HugeHeadGuildMsg` repeated (see [crystal-war.md](crystal-war.md) 309), `notice` #3 STRING, `remainAttackCount` #4 declarations left today). Handler `OutyardModel.fullInfoHandler` (`OMOD/OutyardModel.as:103-217`): op 1 replaces `forceDic` and `nodeDic` (`GET_LAND_NODE`), op 12 patches only fields present (`UPDATE_LAND_NODE`). When: reply to 9594 op 1, heartbeat deltas, broadcasts on declaration, battle start/end, ownership change.

## 5. Rules and formulas

- Declarable node: type 2, `CanOccupy`, state 0, owned by another force, linked (`NodeLink`) to a node of the declaring force (client display rule `OutyardInfoView.as:368-382`; enforce server side).
- `huge_head_attack_count = 2` per force per day; event type 2 adds `effect` extra declarations.
- Node battle length 15 minutes after a preparation window (assumption: until the next minute boundary or 5 minutes).
- Occupation count (`OutyardModel.occupyNum`, nodes owned except type 3) drives the daily reward and `digExtraCount` (assumption).
- Crystal collection: `digTodayRemainCount + digExtraCount` per day, 200 crystals each.
- Ownership persists for the season month (`huge_head_reset_month`); reset to `InitForce` at the monthly reset.

## 6. Templates

`raw/xml/tempinfos/HugeHeadMapNodeTempInfos.xml` (`outyardTemplateCate`, class `OutyardTemplateInfo`): `NodeTempId`, `MapId` 1..5, `PosX`, `PosY`, `InitForce` 0..4, `NodeType` 1 castle / 2 land / 3 crystal / 4 explore entrance (client also knows 5 titan, 6 shuttle, 7 abysm, 8 time vortex buildings, `OMOD/LandPoint.as:12-26`), `CanOccupy`, `NodeLink` comma list.

## 7. Persistent state

```sql
CREATE TABLE outyard.land_node (
  battlefield_uid   TEXT        NOT NULL REFERENCES outyard.battlefield(battlefield_uid) ON DELETE CASCADE,
  node_id           SMALLINT    NOT NULL,
  force_index       SMALLINT    NOT NULL CHECK (force_index BETWEEN 0 AND 4),
  node_state        SMALLINT    NOT NULL DEFAULT 0 CHECK (node_state BETWEEN 0 AND 3),
  attack_force      SMALLINT,
  defence_force     SMALLINT,
  battle_start_at   TIMESTAMPTZ,
  battle_end_at     TIMESTAMPTZ,
  PRIMARY KEY (battlefield_uid, node_id)
);

CREATE TABLE outyard.force_day (
  battlefield_uid   TEXT     NOT NULL REFERENCES outyard.battlefield(battlefield_uid) ON DELETE CASCADE,
  force_index       SMALLINT NOT NULL CHECK (force_index BETWEEN 1 AND 4),
  day               DATE     NOT NULL,
  declarations_left SMALLINT NOT NULL DEFAULT 2,
  notice            TEXT     NOT NULL DEFAULT '',
  PRIMARY KEY (battlefield_uid, force_index, day)
);

CREATE TABLE outyard.crystal_collect_log (
  id           BIGSERIAL   PRIMARY KEY,
  player_id    INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  amount       INTEGER     NOT NULL,
  collected_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- Handlers on 9594: `outyard::land_map::handle_declare`, `handle_join_battle` (creates or joins the node battlefield of [node-battle.md](node-battle.md)), `handle_change_notice`, `handle_collect_crystal`.
- Declare: huge head state 3, sender is chairman of a guild of the force, `declarations_left > 0`, node declarable -> set state 2, attack/defence forces, start/end times; schedule battle start and end; broadcast 349 `op = 12`.
- Node battle end (from [node-battle.md](node-battle.md)): winner by score; set `force_index`, state 0; broadcast 349.
- Collect crystal: collections left -> grant 200 crystals -> decrement -> push 350.
- Heartbeat deltas: keep a per battlefield version and send changed nodes since the last heartbeat of each client.

## 9. Open questions and assumptions

- Preparation window length and node state 1.
- Error feedback when joining a full side or a closed node (client shows nothing specific).
- Whether non chairmen with right 46 may declare.

## 10. Implementation checklist

- [ ] Screens: map frame, land view and nodes, info panel, top info, notice view
- [ ] Routes L1..L4 on 9594
- [ ] Server message 349 full and delta
- [ ] Tables `outyard.land_node`, `outyard.force_day`, `outyard.crystal_collect_log`
- [ ] Template loader `HugeHeadMapNodeTempInfos.xml`
- [ ] Node state timers (preparation, battle, end)
- [ ] Monthly ownership reset
- [ ] Test: adjacency rule and declaration limit
