# Archaeology dig (outer city)

Feature [archaeology](README.md), module `dig`. Aliases in [README.md](README.md).

## 1. Overview

- In his outer city world (map ids 1..5, "Pasto Livre", "Floresta Nublada", "Pântano Sem Fim", "Deserto da Morte", "Terra do Julgamento") the player has up to `archaeology_max_dig_pos = 5` hidden dig points (`raw/xml/tempinfos/ConfigInfos.xml`).
- The overlay `OuterCityArchaeologyView` shows a radar: red when the nearest point is farther than 25 cells, yellow at 5..25 cells, green under 5 cells (`decompiled/m3/scripts/map/outercity/helper/mapview/OutercityArchaeologyHelper.as:60-72`). The needle points to the nearest node (`:14-26`).
- When green, the player clicks "Escavar" (or it starts automatically); a collect animation plays (`CollectionAction`) and then the client sends op 1 (archaeology) or op 6 (star gazing) with the node id.
- Daily limit: `archaeology_max_count = 30` digs per day plus bought digs. Archaeology and star gazing share the counter ("Arqueologia e Astronomia partilham o mesmo número de escavações", help `outercityArchaeology.helpFrame.helpContent`).
- Buying: `archaeology_purchases = 50,5,15`: 50 diamonds buy 5 digs, at most 15 bought digs per day.
- "Auto pesquisa de Arqueologia": a 2 s loop that asks the node list, walks to the nearest node and digs it until the counter is empty.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OCAV` (`OuterCityArchaeologyView`, style `outercity.archaeologyView`) | dig button "Escavar"; tips "Auto pesquisa de Arqueologia", "Trocar para Astrolábio", "Trocar para Arqueologia", help "Introdução à Arqueologia" | Radar overlay at the bottom of the outer city | Created by `OuterCityController` when `mapId < 100 && thane.grades >= 15` (`decompiled/m3/scripts/map/outercity/OuterCityController.as:458-462`) | Remaining digs `left/total` and energy bar from `hasExplorationCount`, `hasBuyExplorCount`, `archaeology_max_count` (`OCAV:394-407`); radar color and direction from the node list (`OCAV:417-470`); buy button visible only when no digs remain (`OCAV:406`); archaeology/star gazing toggle when `VersionSwitch.STAR_GAZING` and level >= 3 (`OCAV:472-489`, `:506-509`) |
| `core.outercityArchaeology.helpFrame` / `helpFrame1` | "Introdução à Arqueologia" | Help text, `helpFrame` when star gazing is enabled (`OCAV:342-354`) | help button | static text |
| Queue bar item type 9 | "Arqueologia {0}/{1}" | HUD queue line with current/total counts (`decompiled/core_module/scripts/ui/queuebar/view/QueueItem.as:401-405`) | queue bar | `currentCount`, `totalCount` of a queue order (assumption: dig counts) |

## 3. Routes (client to server)

All requests: send 9575 (0x2567) `C_ARCHAEOLOGY_REQ`, protobuf `ArchaeologyReqMsg`: `op` (#1, INT32) action code; `tempId` (#2, INT32) node id or template id depending on the op. Sender `ArchaeologyManager.sendArchaeologyRequest(op, tempId = 0)` (`AM:98-105`).

### R1. Ask dig nodes (op 5)

- UI: "Escavar" big button `digBtn` (`OCAV:225-231`): starts the auto loop, hides `digBtn`, sends op 5. Also every 2 s from the auto loop `AutoArchaeologyOpera.onTimer` while digs remain and the scene is `OUTER_CITY_SCENE` (`AUTO:58-110`, op 5 at `:73`).
- Client checks: none for the first send; the loop stops when `max_count + bought - used <= 0` (`AUTO:63-70`), when the scene changes, on a map click (`CLICK_MAP`, `AUTO:132-135`) or when star gazing radar starts (`OCAV:409-415`).
- Request: `op = 5`, `tempId = 0`.
- Expected reply: 297 `U_C_ARCHAEOLOGY_NODELIST` with the player's current nodes on the current outer world.

### R2. Dig a node, archaeology mode (op 1)

- UI: green radar "Escavar" (`greenMc.digBtn`, `OCAV:202-223`) or automatic when the radar becomes green (`OCAV:448-453`) or the auto loop reaches a node (`AUTO:78-90`). These push a `CollectionAction(null, nodeId)` (`COLL:86-152`). At the end of the collect animation (duration `CollectionAsset.totalFrames * 33` ms, `COLL:212-218`) `sendCollection` sends the request (`COLL:468-483`).
- Client checks: `archaeology_max_count` config present; not already collecting (`isArchaeologyCollection`); `hasExplorationCount < archaeology_max_count + hasBuyExplorCount` else "Você já usou todas as chances de arqueologia/astronomia de hoje. Por favor volte amanhã." (`OCAV:202-217`); the node must still be in the local list, else "Coleção foi obtida por outro jogador" and nothing is sent (`COLL:475-480`). The collect is cancelled if the player clicks the stage or a PvP lock happens (`COLL:283-285`).
- Request: `op = 1` when `ArchaeologyModel.outerBtnState == 0`, `tempId = nodeId` (`COLL:481-482`).
- Expected server sequence (assumption, the client has no direct reply handler): 298 with the changed fragment rows; 260 with field 9 (used digs) and field 8 (exp); 297 with the node list without the dug node (plus a new node if regenerated). Bag/currency pushes only if the dig itself gives items (not shown by the client).

### R3. Dig a node, star gazing mode (op 6)

- UI and checks: same as R2 when `outerBtnState != 0` (the player switched with the "Trocar para Astrolábio" button, `OCAV:280-297`). Switching is refused while collecting: "Apenas pode trocar depois de completar a coleta." (`OCAV:283-287`). The toggle is only visible when `VersionSwitch.STAR_GAZING && level >= 3` (`OCAV:506-509`).
- Request: `op = 6`, `tempId = nodeId` (`COLL:481-482`).
- Expected: 260 field 9 (shared counter), 297 node list, and the star gazing info push 4687 owned by [cosmos](../cosmos/README.md) (`decompiled/core_module/scripts/yishi/manager/StarGazingManager.as:49-52`) with the new star debris count (assumption).

### R4. Buy digs (op 7)

- UI: `buyBtn` (style `ui.Archaeology.BuyBtn`), visible only when remaining digs <= 0 (`OCAV:241-278`).
- Client checks: `archaeology_purchases = cost,count,cap` (`50,5,15`); `hasBuyExplorCount >= cap` -> "Limite de compras atingido!"; `playerInfo.point < cost` -> recharge dialog; confirm "Consumir {0} diamantes para comprar {1} escavações? Ainda pode comprar {2} escavações." with `{2} = max(0, cap - bought - count)` (`OCAV:247-269`).
- Request: `op = 7`, `tempId = 0` (`OCAV:272-278`).
- Expected: 260 field 23 (`hasBuyExplorCount += 5`), player info 3 with the new diamond balance.

### R5. Star gazing toggle (no request)

`OCAV._outerStateChangeHandler` only flips `ArchaeologyModel.outerBtnState` (0 archaeology, 1 star gazing) client side (`OCAV:280-297`). The server learns the mode from the op (1 or 6).

## 4. Server messages (server to client)

### 297 (0x0129) `U_C_ARCHAEOLOGY_NODELIST`

- Message `ArchaeologyOuterMsg`: `restExplorationCount` (#1, INT32) remaining digs (not read by the client); `node` (#2, MESSAGE `ArchaeologyNodeMsg`, repeated) with `id` (#1, INT32) node id, `x` (#2, INT32) and `y` (#3, INT32) in 20 px outer city cells.
- Receiver: `OuterCityManager.__archaeologyNodeListHandler` (`OCM:244-260`, listener `OCM:77`, only while the outer city scene is set up). It replaces `OuterCityModel.archaeologyNodeList` and notifies `ARCHAEOLOGY_NODE_LIST`; the overlay refreshes radar color and needle (`OCAV:364-370`).
- When: reply to op 5; after every dig (op 1, op 6) so the dug node disappears (assumption); on entering the outer city (assumption, the overlay works only after a list arrives).
- An empty list makes the auto loop stop (`AUTO:91-104`).

### 260 (0x0104) `U_C_PLAYER_EXTRA_FIELD_MSG` (shared)

- Message `PlayerExtraFieldMsg`: `extraField` (#1, MESSAGE `ExtraFieldInfoMsg`, repeated) with `fieldId` (#1, INT32), `field_Type` (#2, INT32), `userId` (#3, INT32), `value` (#4, STRING).
- Receiver: `BaseManager.__updateInfoHandler` (`BM:876-972`, listener `BM:335`), then event `PLAYER_EXTRA_FIELD` refreshes `OCAV.__updateEnergyHandler` and the frame exp bar.
- Fields for this module: 9 = digs used today, `hasExplorationCount` (`BM:917-920`); 23 = digs bought today, `hasBuyExplorCount` (`BM:965-968`). Field 8 (exp) is in [collection.md](collection.md).
- When: at login, after each dig, after each purchase, at the daily reset.

### Related

- 4938 (0x134a) `U_C_MAPBOSS_DATAS`, `MapBossMsg` fields `archaeologyKillCount` (#7, INT32) and `atchaeologyMonsterCount` (#8, INT32) are stored (`OCM:85-98`) but never displayed by this build. Config `world_map_archaeology_monster_max_count = 10`, `world_map_archaeology_monster_escape_time = 120` (minutes), `world_map_archaeology_monster_max_kill = 10` describe archaeology monsters on the outer map (outer city boss feature, not mapped here).
- 4687 star gazing info: [cosmos](../cosmos/README.md).

## 5. Rules and formulas

- Visible only on outer worlds `mapId < 100` and hero level >= 15 (`OuterCityController.as:458-462`).
- Daily cap = `archaeology_max_count (30) + digs_bought_today`; remaining = cap - used (`OCAV:400-406`).
- Purchase: 50 diamonds for 5 digs, cap 15 bought digs per day (3 purchases) (`ConfigInfos.xml` `archaeology_purchases`, `OCAV:247-263`). Client checks `playerInfo.point` (real diamonds) against the cost.
- Radar distance is Euclidean on 20 px cells: `floor(pos/20)` vs node `(x, y)` (`OutercityArchaeologyHelper.as:28-42`). Green `< 5`, yellow `5..25`, red `> 25`.
- Server validation (assumption): the army must stand within 5 cells of the node when op 1/6 arrives.
- Max 5 nodes per player and world (`archaeology_max_dig_pos`). A dug node is replaced by a new random node (assumption).
- Drop pool per dig (assumption, not in client): fragments of `ArchaeologyItemTemps` rows whose `MapId` is 0 (common, `ArchaeologyModel.COMMON_MAPID = 0`, `AMOD:13`) or equals the current outer world id, and whose `MinLevel` (server only column, not parsed by the client class `decompiled/core_module/scripts/yishi/datas/templates/ArchaeologyItemTemplate.as`) is <= the archaeology level. Fragment amount per dig and exp per dig are not in client data.
- Star gazing (op 6) requires archaeology level >= 3 (same check as the client toggle).
- Daily reset of fields 9 and 23 at 00:00 server time (assumption).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `archaeology_max_count` = 30 | daily free digs |
| | `archaeology_max_dig_pos` = 5 | nodes per player |
| | `archaeology_purchases` = `50,5,15` | diamonds per purchase, digs per purchase, daily bought cap |
| | `world_map_archaeology_monster_*` | archaeology monsters (unused by client UI) |
| `raw/xml/tempinfos/ArchaeologyItemTemps.xml` | 200 items | `MapId` 0..5 (34/34/34/34/32/32 rows), `MinLevel` 1..3, used to build the drop pool (see [collection.md](collection.md)) |

## 7. Persistent state

Schema `archaeology`.

```sql
CREATE TABLE archaeology.player_state (
  player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  exp                  INTEGER     NOT NULL DEFAULT 0 CHECK (exp >= 0),
  day                  DATE        NOT NULL,
  digs_used            SMALLINT    NOT NULL DEFAULT 0 CHECK (digs_used >= 0),
  digs_bought          SMALLINT    NOT NULL DEFAULT 0 CHECK (digs_bought BETWEEN 0 AND 15),
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE archaeology.dig_node (
  player_id   BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  node_id     INTEGER     NOT NULL,
  map_id      SMALLINT    NOT NULL CHECK (map_id BETWEEN 1 AND 99),
  cell_x      INTEGER     NOT NULL,
  cell_y      INTEGER     NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, node_id)
);
CREATE INDEX dig_node_map_idx ON archaeology.dig_node (player_id, map_id);

CREATE TABLE archaeology.dig_log (
  id          BIGSERIAL   PRIMARY KEY,
  player_id   BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  map_id      SMALLINT    NOT NULL,
  mode        SMALLINT    NOT NULL CHECK (mode IN (1, 6)),
  item_template_id INTEGER,
  chips       INTEGER     NOT NULL DEFAULT 0,
  exp_gained  INTEGER     NOT NULL DEFAULT 0,
  dug_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX dig_log_player_idx ON archaeology.dig_log (player_id, dug_at DESC);
```

`player_state` is shared with [collection.md](collection.md) (column `exp`).

## 8. Backend implementation notes

- `archaeology::dig::handle_request` is the single 9575 entry; it dispatches by `op` to the handlers below and to [collection.md](collection.md) / [handbook.md](handbook.md) handlers.
- `archaeology::dig::handle_node_list` (op 5): require scene outer city and `map_id < 100`, hero level >= 15; lazily roll the daily row; top up `dig_node` to 5 rows for the current map (random walkable cells; avoid castles and obstacles from the map physics); reply 297 with `restExplorationCount = cap - used`.
- `archaeology::dig::handle_dig` (op 1) and `archaeology::dig::handle_star_dig` (op 6). Validation order: node belongs to the player and the current map -> digs left -> army distance < 5 cells (assumption) -> for op 6 archaeology level >= 3. Transaction: delete node, increment `digs_used`, roll drop (fragments into `archaeology.item_progress`, see [collection.md](collection.md)) or star debris (cosmos), add exp, insert `dig_log`, create a replacement node. After commit push 298 (changed rows), 260 (fields 8, 9), 297 (node list), and for op 6 the cosmos push 4687.
- `archaeology::dig::handle_buy` (op 7): `digs_bought + 5 <= 15` -> spend 50 diamonds (currency service) -> `digs_bought += 5`. Push 260 field 23 and player info 3. No reply opcode is handled by the client on failure; return silently (assumption) or send a generic error tip.
- Daily reset at 00:00: `digs_used = 0`, `digs_bought = 0`; push 260 fields 9 and 23 to online players.
- No battle in this module.

## 9. Open questions and assumptions

- Exact server reply after op 1/6 is not visible in the client; the push set above is an assumption.
- Fragments per dig, which item, exp per dig and the effect of `MinLevel` are not in client data.
- Whether nodes are personal (assumed) or shared; the text "Coleção foi obtida por outro jogador" is a generic collection string.
- Whether `restExplorationCount` should be cap minus used (assumed).
- Meaning and source of queue bar type 9 counts.
- Whether bound diamonds are accepted for op 7 (client checks only `point`).
- Archaeology monsters (`MapBossMsg` #7, #8) behavior.

## 10. Implementation checklist

- [ ] Screen: `OuterCityArchaeologyView` radar, counter, buy button, toggle
- [ ] Route R1 op 5 -> 297
- [ ] Route R2 op 1 dig with drop, exp, node replacement
- [ ] Route R3 op 6 star gazing dig (needs cosmos)
- [ ] Route R4 op 7 buy digs
- [ ] Server message 297 `ArchaeologyOuterMsg`
- [ ] Server message 260 fields 9 and 23
- [ ] Table `archaeology.player_state`
- [ ] Table `archaeology.dig_node`
- [ ] Table `archaeology.dig_log`
- [ ] Config loader for `archaeology_max_count`, `archaeology_max_dig_pos`, `archaeology_purchases`
- [ ] Rule: level 15 and `mapId < 100`
- [ ] Rule: distance check < 5 cells
- [ ] Daily reset job
- [ ] Test: auto loop (op 5 every 2 s) does not create extra nodes
- [ ] Test: buy cap 15 and diamond deduction
- [ ] Test: digs refused after cap
