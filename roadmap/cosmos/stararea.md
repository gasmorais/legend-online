# Star area ("Expedição no espaço-tempo")

Module `stararea` of feature `cosmos`. A seasonal exploration map (seven-year anniversary activity, config prefix `star_area_*`, Chinese name "时空探险") rendered as its own scene `STARAREA_SCENE`. The map has 92 nodes and 152 roads (`StarAreaRoadInfos.xml`). Starting at node 43, the player clears roads adjacent to already claimed nodes (forbidden roads cannot be crossed, locked roads need a key, battle roads start a battle, mini game roads start a mini game) and claims the nodes they lead to. Nodes give "Luz do Caminho" (reveals fogged nodes), "Chave da Área Perdida", warrior points, expedition fashion and, rarely, a mount. Every action costs "Movimento" (10 per step, 70 per day, refilled at 00:00).

Path aliases:

| Alias | File |
|---|---|
| SAM | `decompiled/core_module/scripts/mvc/module/stararea/StarareaManager.as` |
| SAMOD | `decompiled/core_module/scripts/mvc/module/stararea/StarareaModel.as` |
| V | `decompiled/m3/scripts/stararea/` |
| SY | `decompiled/m11/scripts/sevenyear/view/SevenYearStarAreaView.as` |
| RT | `decompiled/core_module/scripts/yishi/datas/templates/cate/StarareaRoadsTempCate.as` |

## 1. Overview

Node values (`SAMOD.nodes`, 92 entries, index = node id - 1):

| Value | Meaning | Source |
|---|---|---|
| -1 | claimed ("used") | `SAM:47` |
| `v % 50` = 0, 1, 2, 4, 5 | normal, light, small box, key, big box | `SAM:49-57`, `SAMOD:167-201` |
| `v > 50` | needs "Luz do Caminho" before it can be claimed (`NODE_TYPE_FOG2 = 50`) | `SAM:333-341`, `V/StarareaPointItem.as:127-134` |
| `v >= 100` | fogged (type hidden, `FROG_ADD = 100`) | `V/StarareaBackView.as:274-283` |

Road values (`SAMOD.roads`, 152 entries, index = road id - 1): 0 normal / cleared, 1 forbidden ("Área Proibida"), 2 locked ("Área Perdida", needs a key), 3 battle ("Combate"), 4 mini game (`SAM:59-67`). An event marker is drawn only on roads with at least one claimed endpoint and a non zero value (`V/StarareaBackView.as:204-263`).

Special nodes 8, 9, 85, 86 (`SAMOD.BIG_BOX_ARRAY`) are the four end points that give expedition fashion (`StarAreaDrop` site 3, `para2` = node id).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SY` | seven-year tab, help `stararea.help`, button play | preview map with claimed nodes and cleared roads, fashion previews, rare mount preview; sends op 1 on creation (`SY:162-163`) | seven-year event frame (owner [hermitage-war](../hermitage-war/README.md) / [seasonal-events](../seasonal-events/README.md)) | `SAMOD` after 4899 (`SY:248-308`) |
| `V/StarareaController.as` | scene `STARAREA_SCENE` | scene lifecycle: hides top tools, shows main toolbar, chat, resources (`:47-82`) | `SY.onClickPlay` when `SevenYearManager.model.checkFlag()` (`SY:339-343`); battle 3892 end (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:277-286`) | |
| `V/StarareaSceneView.as` | | draggable 2659 x 2320 map centered on the current node (`:60-148`) | scene | |
| `V/StarareaBackView.as` + `V/StarareaPointItem.as` + `V/StarareaEventItem.as` | | node and road rendering, clicks | scene | node state, fog, road event markers |
| `V/StarareaRightView.as` | "Movimento", buttons "Luz do Caminho" and key | counters and the light/key modes | scene | `actionPower`, `lightCount`, `keyCount`, box counters (`:98-140`) |
| `V/StarareaLeftView.as` | legend: "Área Proibida", "Área Perdida", "Combate", "Prêmios preciosos", "Mini game", "Luz do Caminho", "Chave da Área Perdida", "Moda", "Montaria" | legend panel | scene | static texts `stararea.left.*` |
| `V/StarareaSmallMapView.as` | | minimap | scene | |
| `V/StarareaWalkLayer.as` + `V/StarareaArmyView.as` | | hero avatar on the current node | scene | on creation `setPoint(myPointId)` claims the current node if unclaimed (`V/StarareaWalkLayer.as:59-77`, `V/StarareaArmyView.as:78-84`) |
| Link game (`AirGardenGameLlkFrame`, title "Jogo de ligação") / Hamster game | | mini games | game road | owner [seasonal-events](../seasonal-events/README.md) |

## 3. Routes (client to server)

All routes: C>S 9691 (0x25db) `C_STARAREA_OP`, message `simple.PropertyMsg`: `param1 (#1, INT32)` op; `param2 (#2, INT32)`; `param3 (#3, INT32)`; `param4 (#4, STRING)`; `param5 (#5, STRING)`, `param6 (#6, STRING)`, `param7..param9 (#7..#9, BOOL)`, `param10 (#10, INT32)`, `param11 (#11, INT32)`, `param12 (#12, STRING)` unused.

| # | op (`param1`) | Action | UI and client checks | Other params | Server effect | Response |
|---|---|---|---|---|---|---|
| T1 | 1 `OP_OPEN` | load state | `SY` creation (`SAM.sendOpenView`, `SAM:155-161`) | none | create the run on first call (assumption: random layout from the config counts); refill action power if a new day | 4899 |
| T2 | 2 `OP_MOVE` | cross an event road | click road marker (`V/StarareaEventItem.as:82-138`): forbidden (1) ignored; clicks closer than 1 s -> "activity.view.ActivityItem.command01"; both endpoints claimed -> `stararea.road.click`; locked (2) only clickable in key mode (`V/StarareaBackView.as:142-166`, `V/StarareaRightView.as:123-140`, no key -> `stararea.nokey`); `actionPower < 10` -> "Movimento insuficiente"; mini game (4) sets `gameRoadId` and starts a random mini game before sending (`SAM.startMiniGame`, `SAM:269-289`). Sender `SAM.moveRoad` (`SAM:232-239`) | `param2` road id | locked: consume a key, clear the road; battle: start battle 3892 (clear the road on victory); mini game: remember the pending road; all: consume 10 action power (assumption: per step) | 4899; for battle the battle start sequence |
| T3 | 3 `OP_USE_LIGHT` | reveal a node | light mode on (`stararea.nolight` when none) and click a node with value > 50 (`V/StarareaPointItem.as:127-134` -> `SAM.sendGetAward` -> `SAM.sendUseLight`, `SAM:313-347`) | `param2` node id | consume one light, remove the fog flag (value -= 100 or -50) | 4899 |
| T4 | 5 `OP_AWARD` | claim a node | click a node with value <= 50 (`SAM.sendGetAward`, `SAM:327-347`); also automatic for the current node when the walk layer is created | `param2` node id | node must be adjacent (road value 0) to a claimed node; grant reward by type (light +1, key +1, small box 200 warrior points, big box 2000, fashion node items, 1/100 chance of mount 2183094); node becomes -1; consume action power (`star_area_action_power[0]` "踩节点消耗") | 4899 and reward pushes |
| T5 | 4 `OP_GAME` | mini game step | link game in star area mode: open `sendPlayGame(1, 2)`, match `sendPlayGame(2, 2, "r1,c1,r2,c2")` (`decompiled/m3/scripts/map/campaign/view/ui/airgarden/game/llk/AirGardenGameLlkFrame.as:248-256,452-454`, same in `decompiled/m11/scripts/monopoly/llk/MonopolyLlkFrame.as:185-191,339-341`); gem maze move `sendPlayGame(2, 1, "begin,end")` (`decompiled/m11/scripts/monopoly/gemmaze/view/MonopolyGemMazeView.as:473-475`). `SAM.sendPlayGame` first sends 8961 (0x2301) `C_MONOPOLY_GEMMAZE_INFOGET` without body (`SAM:301-311`) | `param2` game op 1 open / 2 move; `param3` game type 1 gem / 2 link; `param4` move string | drive the mini game board server side | link game: 4736 (0x1280) `U_C_LINK_GAME_INFO`; gem maze: 4760 / 4922 / 4761 (owner [casino](../casino/README.md) / [seasonal-events](../seasonal-events/README.md)) |
| T6 | 6 `OP_OVERGAME` | mini game won | the game dispatches `GAME_PASS` (link/gem frames on success, hamster game callback, `SAM:291-299`); `StarareaArmyView.miniGamePass` -> `SAM.gameFinsh(gameRoadId)` (`V/StarareaArmyView.as:61-64`, `SAM:241-252`); skipped when `gameRoadId == -1` (other events reuse the mini games) | `param2` road id | mark the road cleared (value 0) if it was the pending game road | 4899 |
| T7 | (none) | enter / exit | enter: `SceneManager.setScene("STARAREA_SCENE")` (`SY:343`); exit: main toolbar exit confirm "No momento você está em uma expedição no espaço-tempo, deseja sair?" -> `SAM.exit` -> `SwitchPageHelp.returnToSpace({isOpenStararea: true})` (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1720-1723,1798-1804`, `SAM:349-352`) | | none | |

Dead client code (do not rely on it): `SAM.sendMove`/`realSendMove`/`checkRoadArrive` (no caller, `SAM:163-267`), `SAM.__gemMazeInfoBuffHandler` (never registered, `SAM:108-114`), `StarareaArmyView.toMove` (never registered).

## 4. Server messages (server to client)

### S1. 4899 (0x1323) `U_C_STARAREA`, `active.StarAreaMessage`
Receiver `SAM.receiveStarareaInfo` (`SAM:116-148`, listener `SAM:105`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `roads` | #1 | STRING | 152 comma separated road values |
| `nodes` | #2 | STRING | 92 comma separated node values |
| `nowNode` | #3 | INT32 | current node (start 43); copied only while the client value is -1 |
| `actionPower` | #4 | INT32 | remaining "Movimento" |
| `key` | #5 | INT32 | keys owned |
| `light` | #6 | INT32 | lights owned |

Client reaction: updates counters; replaces nodes/roads when the strings differ (roads change fires `UPDATE_ROADS`); when `nowNode` equals the known node it also fires `UPDATE_NODES`, `UPDATE_ROADS`, `UPDATE_DATA`; always `UPDATE_TAB_VIEW` (seven-year tab). Keep `nowNode` constant (the client never moves the avatar after the first value).

When: after every op 1..6, and after a star area battle.

### S2. Battle 3892 `STAR_AREA_BATTLE`
Started by T2 on a battle road. Units from config `star_area_sys_army` = 82026, 82029, 20010 (monster ids). After the result the client returns to `STARAREA_SCENE` unless `StarareaManager.isExit` (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:277-286`; `docs/battle/rules.md`, battle type 3892). See `docs/battle/server-engine.md` for the start sequence.

### S3. Mini game messages
4736, 4760, 4922, 4761: owned by the mini game features; the star area only needs to route op 4 into them.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Availability | seven-year event active (`SevenYearManager.model.checkFlag()`), `seven_year_start_date` 2020-05-11 | `SY:339-343`, `ConfigInfos.xml` |
| Map | 92 nodes, 152 roads (`Id`, `Node1`, `Node2`, `Group`), start node 43 | `SAMOD:42-46`, `RT:26-97` |
| Special node counts | `star_area_node` = 28 lights, 34 small boxes, 4 fashion, 19 keys, 7 big boxes | `SAMOD:122-140`, `ConfigInfos.xml` |
| Special road counts | `star_area_road` = 19 forbidden, 19 locked, 76 battle, 38 mini game (sum 152) | `ConfigInfos.xml` |
| Action power | `star_area_action_power` = 10 per step, 70 per day, refilled at 00:00 ("O Movimento é redefinido para o limite máximo diariamente às 0h") | `SAMOD:142-150`, `stararea.help` |
| Box score | `star_area_box` = 200 (small box), 2000 (big box) warrior points (`StarAreaDrop` site 2 and 5, item -15000) | `SAMOD:152-160`, `StarAreaDrop.xml` |
| Rare mount | `star_area_mounts_id` = 2183094 with chance 1000 / 100000 when a node is lit ("Sempre que acender um ponto, há uma certa chance de que o prêmio do ponto possa ser substituído por uma Montaria rara.") | `SAMOD:162-165`, `StarAreaDrop` site 6 |
| Fashion | nodes 8, 9, 85, 86 drop the `StarAreaDrop` site 3 rows with `para2` = node | `SAMOD:18,203-217` |
| Battle monsters | `star_area_sys_army` = 82026, 82029, 20010 | `ConfigInfos.xml` |
| Mini game choice | random hamster (local, 60 s, 1500 points) or link game | `SAM:269-299` |

## 6. Templates

| File | Fields used |
|---|---|
| `StarAreaRoadInfos.xml` (152 rows) | `Id`, `Node1`, `Node2`, `Group` |
| `StarAreaDrop.xml` (11 rows) | `dropId`, `site` (2 small box, 3 fashion, 5 big box, 6 mount), `para2` (node id for site 3), `itemId`, `count`, `isBind` |
| `ConfigInfos.xml` | `star_area_node`, `star_area_road`, `star_area_sys_army`, `star_area_box`, `star_area_action_power`, `star_area_mounts_id` |

## 7. Persistent state

```sql
CREATE TABLE cosmos.stararea_runs (
  player_id        BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  season_key       TEXT     NOT NULL,                  -- event edition, e.g. start date of the seven-year event
  nodes            SMALLINT[] NOT NULL CHECK (array_length(nodes, 1) = 92),
  roads            SMALLINT[] NOT NULL CHECK (array_length(roads, 1) = 152),
  now_node         SMALLINT NOT NULL DEFAULT 43,
  action_power     SMALLINT NOT NULL DEFAULT 70 CHECK (action_power >= 0),
  power_refilled_on DATE    NOT NULL DEFAULT CURRENT_DATE,
  key_count        SMALLINT NOT NULL DEFAULT 0 CHECK (key_count >= 0),
  light_count      SMALLINT NOT NULL DEFAULT 0 CHECK (light_count >= 0),
  pending_game_road SMALLINT,                          -- road waiting for op 6
  warrior_points   INTEGER  NOT NULL DEFAULT 0,
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, season_key)
);
```

Rewards themselves go to inventory, fashion, mounts or the warrior point currency (owners linked in the README).

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 1 | `cosmos::stararea::handle_open` |
| 2 | `cosmos::stararea::handle_cross_road` |
| 3 | `cosmos::stararea::handle_use_light` |
| 4 | `cosmos::stararea::handle_play_game` (delegates to the mini game services) |
| 5 | `cosmos::stararea::handle_claim_node` |
| 6 | `cosmos::stararea::handle_finish_game` |

- Common validation: event active -> run exists (op 1 creates it) -> lazy daily refill of action power -> op specific checks (road adjacent to a claimed node, road type, key/light counts, action power >= 10) -> transaction -> 4899.
- Layout generation (assumption): on first open place the special node and road types randomly according to `star_area_node`/`star_area_road`, mark node 43 claimed, keep nodes 8, 9, 85, 86 as fashion end points, fog every other node (+100).
- Battle roads: create a PvE battle with `battle_type = 3892`, monsters from `star_area_sys_army`; on victory set the road value to 0 and push 4899 after the battle result; on defeat keep the road (assumption) and still charge action power.
- Mini game anti cheat: only accept op 6 for `pending_game_road` and only after the mini game service confirms a win (the hamster game is fully client side, so op 6 after a hamster game cannot be verified; accept it).
- Daily refill at 00:00 can be lazy (on next request).

## 9. Open questions and assumptions

- Assumption: how fog values are removed by light (subtract 100 or 50) and which values the server uses for "fog2" (51..99).
- Assumption: action power is charged on op 2 and op 5 only.
- Assumption: layout is random per player; the client has no layout template besides the road graph.
- Language keys `stararea.road.click`, `stararea.nolight`, `stararea.nokey` are missing from `index/language.json`; the client shows the raw key.
- The seven-year event gate (`SevenYearManager`) belongs to the event feature; this module only needs an "event active" check.

## 10. Implementation checklist

- [ ] Screens (client ready): seven-year tab view, `STARAREA_SCENE` with back, right, left, minimap and walk layers.
- [ ] Table `cosmos.stararea_runs`.
- [ ] Route 9691 op 1 open and layout generation.
- [ ] Route 9691 op 2 cross road (locked with key, battle 3892, mini game pending).
- [ ] Route 9691 op 3 use light; op 5 claim node with rewards and mount chance.
- [ ] Route 9691 op 4 bridge to link game / gem maze services; op 6 finish game.
- [ ] Push 4899 after every op and after battles.
- [ ] Daily action power refill.
- [ ] Tests: crossing a forbidden road rejected; locked road without key rejected; claiming a non adjacent node rejected; light reveals fog; action power below 10 rejected; op 6 for a road that is not pending rejected; battle victory clears the road.
