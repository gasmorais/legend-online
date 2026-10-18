# Terrálem exploration ("Pesquisa da Terralém")

Feature [outyard](README.md), module `land-explore` (protobuf package `stackhead`, `StackHeadExplore*`). Aliases in [README.md](README.md).

## 1. Overview

- Each home map has an explore entrance (nodes 601..604, type 4). Entering costs `huge_head_explore_enter_point = 100` exploration points ("Deseja consumir {0} pontos de pesquisa para pesquisar a Terralém?") and generates a board of cells (grid `row x col`, holes allowed) with events.
- The player owns 3 dice (values shown on the dice). Clicking a die costs `huge_head_explore_dice_cost = 20` points and moves the hero exactly that many steps; at forks the player picks the branch with arrows. The full path is sent to the server, which validates it.
- Landing on an untriggered cell triggers its event: 1 box (reward), 2 nest (monster fight), 3 random move (teleport), 4 trap. Event list `StackHeadExploreTempInfos.xml` (e.g. "Caso do Líder", "Encontrou Caçador de Tesouros", "Toca dos Monstros", "Descobriu baú", "Altar do Cristal da Terralém", "Cemitério da Maldade", "Passageiro").
- Exploration points: `huge_head_explore_point = 600` per day, reset at 00:00 ("Todos os pontos de pesquisa serão redefinidos diariamente às 0h"); buy 200 points for 100 diamonds (`huge_head_explore_charge_point = 100,200`) when not full. Event "Dia da Pesquisa" (active type 3) reduces costs.
- Leaving ends the board ("ao sair não conseguirá entrar no mesmo local").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OY3/OutyardAreaView.as` | | Board with cells, hero walker, branch arrows, step counter; sends move after the walk (`:164-405`) | 361 `op = 0/5` (`CLICK_AREA_VIEW`, `OY/scene/OutyardMapFrame.as:290-304`) | `nodeDic`, `curPos` |
| `OY3/OutyardAreaDiceView.as` | "Pontos de Pesquisa {0}/{1}"; "Consumir {0} pontos de pesquisa para pesquisar"; "Em andamento..." | 3 dice, points bar, buy points (`:69-244`) | board | `diceDic`, extra field 15 |
| `OY3/AreaNodeView.as`, `OY3/AreaNodeSmallPoint.as`, `OY3/OutyardAreaArrowView.as`, `OY3/OutyardAreaSmallBar.as`, `OY3/OutyardHunterView.as`, `OY3/RouteHunterView.as`, `OY3/OutyardDragMediator.as`, `OY3/OutyardMapCursorMediator.as` | | Cell art (`Resource` swf), minimap, arrows, dragging | board | |
| `decompiled/m16/scripts/yishi/view/tips/OutyardAreaEventTips.as` | | Event tip | cell hover | template |

## 3. Routes (client to server)

Send 9608 (0x2588) `C_STACK_HEAD_EXPLORE`, `StackHeadExploreReqMsg` (package `stackhead`): `op` (#1, ENUM `StackHeadExploreOpState`: 0 START, 1 MOVE, 2 TRIGGER, 3 EXIT, 4 RECHARGE, 5 CONTEXT); `diceId` (#2, INT32); `linePath` (#3, STRING, repeated) cell names `"row#col"`; `payType` (#4, INT32). Sender `OutyardManager.OperateArea(op, diceId, linePath, payType)` (`OM:290-302`).

| # | op | UI and sender | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| E1 | 0 START | explore node confirm (`OY/scene/OutyardMapFrame.as:327-351`, `:406-414`) | `exploreNum >= 100` else buy prompt | `diceId = entrance node id` (601..604) | 361 `op = 0` with `context` and `explorePlayer`; 260 field 15 |
| E2 | 1 MOVE | end of the walk (`OY3/OutyardAreaView.as:196-205`) | not walking; `exploreNum >= 20` (client deducts locally, `OY3/OutyardAreaDiceView.as:208-242`) | `diceId` 0..2, `linePath` visited cells including the start | 361 `op = 1` with `result`, new dice and position; on failure `errorCode` and the client snaps back unless code 3, 12 or 13 (`OY3/OutyardAreaView.as:234-245`) |
| E3 | 2 TRIGGER | automatic when the new cell is not triggered (`OMOD/OutyardAreaModel.as:136-155`) | | | 361 `op = 2` with `updatedNode`; reward pushes; nest events start a battle (battleType 3857 or 3858, assumption 3857) |
| E4 | 3 EXIT | leave confirm (`OY/scene/OutyardMapFrame.as:621-662`) | | | 361 `op = 3` (client clears `enterLandId`) |
| E5 | 4 RECHARGE | "+" on dice view or top view (`OY3/OutyardAreaDiceView.as:122-169`, `OY/scene/OutyardInfoTopView.as:144-192`) | points not full else "Nº de pesquisas esgotadas, não é possível comprar mais"; confirm "Deseja consumir {0} diamantes para recuperar {1} pontos de pesquisa?" with bound option; diamonds | `payType` 0 bound first / 1 real | 361 `op = 4`, 260 field 15, player info 3 |

## 4. Server messages (server to client)

### 361 (0x0169) `U_C_STACK_HEAD_EXPLORE`

`StackHeadExploreResMsg`: `op` (#1, ENUM) echo; `result` (#2, BOOL); `errorCode` (#3, ENUM `StackHeadExploreErrorCode`: 0 NONE, 1 EXPLORE_NOT_FOUND, 2 STRENGTH_EXCEPTION, 3 STRENGTH_NOT_ENOUGH, 4 DICE_NOT_FOUND, 5 PATHS, 6 PATHS_EXCEPTION, 7 PATHS_ORIGIN, 8 PATHS_INVALID, 9 PLAYER_NOT_FOUND, 10 MOVE_FAILURE, 11 EXPLORE_NODE_NOT_FOUND, 12 PATHS_EMPTY, 13 PATHS_NO_CHANGE); `context` (#4, `StackHeadExploreMsg`: `id` #1 entrance node, `rawNode` #2 `StackHeadExploreRawNodeMsg` {`node` #1 INT32 repeated (non zero = cell exists, row major), `row` #2, `col` #3}, `node` #3 `StackHeadExploreNodeMsg` repeated {`name` #1 STRING "row#col", `type` #2, `eventId` #3, `eventType` #4, `triggered` #5 BOOL}); `explorePlayer` (#5, `ExplorePlayerMsg`: `currentPoint` #1 STRING, `dice` #2 `StackHeadExploreDiceMsg` repeated {`id` #1, `point` #2}); `updatedNode` (#6, `StackHeadExploreNodeMsg`). Handler `OutyardAreaModel.exploreResHandler` (`OMOD/OutyardAreaModel.as:50-178`, via `OM:173-179`): op 0/5 build the board when `result` (op 5 also sets `enterLandId`), op 1 updates dice and position or dispatches `UPDATE_AREA_ADJUST`, op 2 marks the cell triggered (event type 3 teleports the hero), op 3 clears the board.

`StackHeadExploreNodeEventStateMsg` and `StackHeadNodeEventUpdatedMsg` exist in the package but are not read by the client. Op 5 CONTEXT is a server push to restore the board (assumption: after a battle or on re-entering the map with `enterLandId`).

### 260 field 15

Exploration points left (`OutyardAreaModel.exploreNum`, `decompiled/core_module/scripts/yishi/manager/BaseManager.as:933-936`).

## 5. Rules and formulas

- Config: `huge_head_explore_point = 600`, `huge_head_explore_enter_point = 100`, `huge_head_explore_dice_cost = 20`, `huge_head_explore_charge_point = 100,200`, `huge_head_active_explore = 3,4,1,50`.
- Path validation: consecutive cells must be orthogonal neighbours that exist in `rawNode`, path length = die value + 1 (start included), no reversal needed (client prevents going back on 2 way cells).
- Dice are re-rolled after use (new `point` 1..6, assumption).
- Event templates: `MinCount`/`MaxCount` number of such cells per board, `Rate` weight, `Rare`, `Param2` monster or drop ids per level, `Param3` drop ids, `Param4` index, `Param5` flag (meanings partly unknown).

## 6. Templates

`raw/xml/tempinfos/StackHeadExploreTempInfos.xml` (`outyardAreaTemplateCate`): `EventId` 1..8, `EventType` 1 box, 2 nest, 3 random move, 4 trap, `Name`, `Description`, `MinCount`, `MaxCount`, `Rate`, `Rare`, `Resource` (`stackheadexplore/*.swf`), `Param1..Param5`.

## 7. Persistent state

```sql
CREATE TABLE outyard.explore_points (
  player_id      INTEGER  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  day            DATE     NOT NULL,
  points         SMALLINT NOT NULL DEFAULT 600 CHECK (points >= 0)
);

CREATE TABLE outyard.explore_board (
  player_id      INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  entrance_node  SMALLINT    NOT NULL,
  rows           SMALLINT    NOT NULL,
  cols           SMALLINT    NOT NULL,
  cells          SMALLINT[]  NOT NULL,
  current_point  TEXT        NOT NULL,
  dice           SMALLINT[]  NOT NULL,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE outyard.explore_cell (
  player_id   INTEGER  NOT NULL REFERENCES outyard.explore_board(player_id) ON DELETE CASCADE,
  name        TEXT     NOT NULL,
  cell_type   SMALLINT NOT NULL,
  event_id    SMALLINT NOT NULL,
  event_type  SMALLINT NOT NULL,
  triggered   BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, name)
);
```

## 8. Backend implementation notes

- `outyard::land_explore::handle_request` (9608) dispatching START, MOVE, TRIGGER, EXIT, RECHARGE.
- Start: entrance node valid for the player's battlefield, no open board, points >= 100 x rate -> deduct, generate board and events from templates (`MinCount..MaxCount` per event weighted by `Rate`), roll 3 dice.
- Move: validate die and path (error codes above), deduct 20 x rate, move, re-roll the used die.
- Trigger: by event type: box -> drop; nest -> battle, on win mark triggered; random move -> pick a random cell; trap -> penalty (assumption: lose points).
- Exit: delete the board.
- Daily reset of points at 00:00 and push 260 field 15.

## 9. Open questions and assumptions

- Board generation sizes, die values, trap effect, nest monsters and rewards (`Param*` meanings).
- Battle type for nests (3857 assumed).

## 10. Implementation checklist

- [ ] Screens: board, dice view, minimap and arrows
- [ ] Routes E1..E5 on 9608
- [ ] Server message 361 with error codes
- [ ] 260 field 15
- [ ] Tables `outyard.explore_points`, `explore_board`, `explore_cell`
- [ ] Template loader `StackHeadExploreTempInfos.xml`
- [ ] Path validator
- [ ] Test: invalid paths return the right error codes
