# Dark maze ("Labirinto Negro")

Feature `mazes`, module `dark-maze`. Client: `M11/darkmaze/*` (14 classes), `CM/managers/DarkMazeManager.as`, `CM/mvc/module/darkmaze/*`, `CM/mvc/controler/DarkMazeController.as`, `CM/yishi/datas/templates/DarkMaze*TemplateInfo.as` and cates, `M15/view/subshop/DarkMazeShopFrame.as`. Proto: `avenger.DarkMazeMsg`, `avenger.DarkMazeChildMsg` (package `avenger`), `player.PlayerOpMsg`, `simple.PropertyMsg`. Conventions: see [README.md](README.md).

---

## 1. Overview

- Time-limited event configured by `dark_maze_config_time` = "icon shown \| event start \| event end \| icon hidden" and refreshed at the dates of `dark_maze_reset_time`. The local config holds 2022 dates (`raw/xml/tempinfos/ConfigInfos.xml`): the server must provide current ones.
- The event is its own scene (`DARK_MAZE_SCENE`, full screen `darkmaze.DarkMazeMainFrame`). Each layer ("andar", 1..20) is a graph of 22 nodes laid out in 11 columns (`DarkMazeModel.posIndexArray`, `CM/mvc/module/darkmaze/DarkMazeModel.as:97-163`): node 1 is the start, node 22 the exit to the next layer. From the current node the player may move to a node of the next column in an adjacent row (y ± 1); when the server fixes a `targetId`, only that node is available. Nodes passed are kept in `pathInfo`; other nodes of passed columns are locked.
- Every node carries an event (`DarkMazeEventTemplates.EventType`): 0 none, 1 common battle, 2 elite battle, 3 boss battle, 4 fountain ("todas as unidades sobreviventes recuperam 50% de vida"), 5 demon pact ("ressuscita 1 unidade ... 50% de vida, e caso não haja mortos, recupera para 50% a vida da qual tem menos"), 6 bounty hunter (hire one mercenary out of five), 7 discount shop (3 goods).
- Units are the player's guardians (snapshot taken at the first move: "o número de Espíritos de Proteção e Guardiões, atributos, etc. do labirinto será registrado e mantido até que o evento seja atualizado") plus hired mercenaries (negative ids = `-DarkMazeChildTemplates.Id`). Their HP persists across battles. At most 3 units fight; the formation uses the 8 cells 1, 3, 4, 6, 7, 9, 10, 12.
- Battles (type 3898) give "Alma do labirinto" (-17000), spent in "Loja do Labirinto Negro" (shop 1023), open until 7 days after the event end.
- "Comprar recuperação": `dark_maze_revive_point` (500) diamonds revive all units at 100%.
- After the last layer (`passDarkMaze`) the player cannot enter until the next reset. A reset returns everybody to layer 1, node 1 and removes the mercenaries; the maze closes 30 minutes before a reset.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `darkmaze.DarkMazeMainFrame` (`M11/darkmaze/DarkMazeMainFrame.as`), scene `DARK_MAZE_SCENE` | "Labirinto negro" (layer image) | Layer graph | `DarkMazeManager.enterScene` (`CM/managers/DarkMazeManager.as:57-100`) | Layer number (`:295`); 22 `DarkMazeNodeItemView` (`:271-288`) lit, locked or hidden by `refreshNodeStatus` (`:290-366`); exit animation on node 22 (`:187-198`); buttons "Ajuste de formação" (`:226-229`), "Comprar recuperação" (`:231-239, 253-269`), help ("Descrição do labirinto negro"); back button sends op 7 (`CM/ui/maintoolbar/MainToolBar.as:1681-1684`) |
| `darkmaze.DarkMazeNodeItemView` (`M11/darkmaze/DarkMazeNodeItemView.as`) | none | One node | Main frame | Event type image; click handling (`:176-262`): moving backwards refused ("Operação ilegal, não pode voltar"); first move of layer 1 confirms "Começar a explorar o labirinto? ..."; type 0 confirms "Não há nenhum evento na área atual, mover-se?"; type 7 confirms "Deseja entrar na loja?"; other types open the event frame (`darkmaze` controller openType = event type) |
| `darkmaze.darkMazeCommonFrame` (`M11/darkmaze/DarkMazeCommonFrame.as`), openTypes 1, 2, 3 | battle node | Enemy preview, own units ("Mercenário"), reward ("Prêmio"); buttons adjust formation and fight | Node of type 1..3 | Units via `getChildDataById`; reward of the event |
| `darkmaze.darkMazeSpringFrame` (openType 4) | fountain | Confirm the heal ("Quer mesmo ir adiante?") | Node type 4 | `darkmaze.darkMazeSpringFrame.descTxt1/2` |
| `darkmaze.darkMazeDemonFrame` (openType 5) | demon | Confirm the pact ("Quer negociar?") | Node type 5 | `descTxt1/2` |
| `darkmaze.darkMazeLierenFrame` (openType 6) | "Contrate um caçador de recompensas para ajudá-lo a concluir esta exploração:" | Pick one mercenary | Node type 6 | 5 candidates from `Param1` template ids (`:130-151`), stats computed by `DarkMazeModel.getBattleValue` (`CM/mvc/module/darkmaze/DarkMazeModel.as:366-376`) |
| `darkmaze.DarkMazeBuyFrame` (openType 7), `DarkMazeBuyItemView` | "Comprar" | Discount shop of the node | Node type 7 | Up to 3 goods from `Param1..3` "itemId,count,price,discount%" (`DarkMazeBuyItemView.as:111-125`); bought flags from `buyInfo` (`:137-145`); closing with goods left confirms "Ainda existem itens com desconto a serem comprados na loja. Você vai desistir?" (`DarkMazeBuyFrame.as:152-177`) |
| `darkmaze.darkMazeShapeAdjustmentFrame` (openType 8), head and item views | "Ajustar Formação" (`ChildPveFrame.title`) | Battle formation of up to 3 units | Main frame, common frame | Unit list with HP ("Já morreu" when 0), 8 cells (`:85-106`), "Lugar Cheio" when 3 units are placed (`DarkMazeShapAdjustmentHeadView.as:195-210`) |
| `view.subshop.DarkMazeShopFrame` (`M15/view/subshop/DarkMazeShopFrame.as`) | "Loja do Labirinto Negro" | Shop 1023 | NPC option 153 | Soul balance `darkmazeSoulCoin`; "Nota: A alma do labirinto será zerada em {end + 7 days}" (`:145-151`) |

---

## 3. Routes (client to server)

Opcode **8662 (0x21d6) C_DARK_MAZE_OP**, body `player.PlayerOpMsg`, built by `DarkMazeManager.darkMazeOperation(op, nodeId, id, param1)` (`CM/managers/DarkMazeManager.as:319-337`). Zero or empty arguments are not written.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | 1 enter (`OP_ENTER`), 2 walk / trigger (`OP_WALK`), 3 next layer (`OP_PORTAL`), 4 formation (`OP_EDIT_POS`), 5 revive all (`OP_REVIVE`), 6 buy (`OP_BUY`), 7 leave (`OP_LEAVE`) (`CM/mvc/module/darkmaze/DarkMazeModel.as:43-55`) |
| `id` | #5 | INT32 | op 2 on a hunter node: chosen mercenary template id; op 2 on a shop node: 1 = leave the shop; op 6: good index 1..3 |
| `nodeId` | #10 | INT32 | target node 2..22 (ops 2 and 6) |
| `param1` | #15 | STRING | op 4: formation "cell,unitId\|cell,unitId..." (unit 0 = empty cell) |

Other `PlayerOpMsg` fields are unused (list in [../forbidden-boss/boss-hall.md](../forbidden-boss/boss-hall.md) §3).

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| D1 | Entering the scene (and returning from a battle) | `DarkMazeMainFrame.enter` (`M11/darkmaze/DarkMazeMainFrame.as:65-74`) | `enterScene`: event not closed (`openStatus != 2`, "Evento encerrado"); not within 30 min of a reset ("O Labirinto negro está atualizando, reabrirá em {0}"); not passed ("Já passou do labirinto..." or "A próxima atualização ... é em: {0}"); not in a free team; not in a campaign; top button: `checkDarkMaze` window; switch and job change | `{op=1}` | **4278** opType 1 (full state) |
| D2 | Move to an event-free node, fountain, demon | `DarkMazeNodeItemView.confirmWalk` (`:249-262`), `DarkMazeSpringFrame.__confirmBtnHandler` (`M11/darkmaze/DarkMazeSpringFrame.as:80-91`), `DarkMazeDemonFrame` (`:80-91`); node 2 directly, others after the lock animation `__playLockCompleteHander` (`DarkMazeNodeItemView.as:156-174`) | node ahead of the current one | `{op=2, nodeId}` | **4278** opType 2 (new position, path, unit HP) |
| D3 | "Lutar" on a battle node | `DarkMazeCommonFrame.__enterBattleBtnHandler` (`M11/darkmaze/DarkMazeCommonFrame.as:129-145`) | at least one unit in the formation for types 1 and 2 ("Não há unidades em batalha"); boss, node 2 and `targetId` nodes skip the animation | `{op=2, nodeId}` | Battle **3898** (64, 157 ... 4103); after it the client returns to the scene (D1) unless passed or closed (`CM/battle/handler/BattleResultHandler.as:140-167`) |
| D4 | Hire a mercenary | `DarkMazeLierenFrame.__confirmBtnHandler` (`M11/darkmaze/DarkMazeLierenFrame.as:92-107`) | a candidate selected ("Selecione o caçador de recompensas que deseja contratar") | `{op=2, nodeId, id=templateId}` | **4278** opType 2 with the new unit in `childs` |
| D5 | Open a shop node | `DarkMazeBuyFrame.show` (`M11/darkmaze/DarkMazeBuyFrame.as:125-141`) | confirmation "Deseja entrar na loja?" | `{op=2, nodeId}` (no `id`) | **4278** with `buyInfo` *(assumption: opType 6 or 2)* |
| D6 | Buy a good | `DarkMazeBuyItemView.buyGoodsResuletHandler` (`M11/darkmaze/DarkMazeBuyItemView.as:85-109`) | `point >= price` (diamonds only), confirmation "Deseja consumir {0} diamantes para comprar?" (can be muted) | `{op=6, nodeId, id=index}` | **4278** opType 6 `buyInfo`; bag and currency pushes |
| D7 | Leave the shop | `DarkMazeBuyFrame.__frameResponse` / `closeBuyFrame` (`:152-194`) | confirmation when fewer than 3 goods were bought | `{op=2, nodeId, id=1}` (after the animation for nodes other than 2) | **4278** opType 2 |
| D8 | Formation drop | `DarkMazeShapeAdjustmentFrame.updateToPlayerInfo` (`M11/darkmaze/DarkMazeShapeAdjustmentFrame.as:186-199`) | at most 3 units; only sent when changed | `{op=4, param1="cell,unitId\|..."}` for the 8 cells | **4278** opType 4 `posInfo` |
| D9 | "Comprar recuperação" | `DarkMazeMainFrame.confirmBuyBack` (`:253-269`) | confirmation "Quer consumir {0} diamantes para reviver todas as unidades, restaurando 100% de vida?"; not all at max HP ("Todos estão com a vida cheia..."); `point >= dark_maze_revive_point` ("sacrifice.sacrificeFrame.pointNotEnough") | `{op=5}` | **4278** opType 5 `childs`; currency push |
| D10 | Exit at node 22 | `DarkMazeMainFrame.__enterNextLayerHandler` (`:241-245`) | `enterScene` checks | `{op=3}` | **4278** opType 3 (new layer, full state) |
| D11 | Back button | `MainToolBar` scene switch (`CM/ui/maintoolbar/MainToolBar.as:1681-1684`) | none | `{op=7}` then the client goes to space | **4278** opType 7 (client calls `enterToSpace` again) |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When | Client reaction |
|---|---|---|---|---|---|
| **4278 (0x10b6)** | U_C_DARK_MAZE_DATA | `avenger.DarkMazeMsg`: `opType (#1, INT32)` which op it answers; `layer (#2, INT32)` 1..20; `nodeId (#3, INT32)` current node 1..22; `targetId (#4, INT32)` forced next node, 0 = free choice; `nodeInfo (#5, STRING)` "nodeId,eventTemplateId\|..." for the 22 nodes (event 0 when the template id is unknown); `pathInfo (#6, STRING)` "1,3,5" walked nodes; `posInfo (#7, STRING)` "cell,unitId\|..." formation; `childs (#8, DarkMazeChildMsg, repeated)` units; `buyInfo (#9, STRING)` "0,1,0" bought flags of the current shop. `DarkMazeChildMsg`: `childId (#1, INT32)` guardian id, or negative mercenary template id; `hp (#2, INT32)`; `maxHp (#3, INT32)`; `fightPower (#4, INT32)` | `DarkMazeManager.__onInfoHandler` (`CM/managers/DarkMazeManager.as:104, 123-196`) | Responses to every op | opType 1 or 3: node positions, path, `nodeInfo`, `posInfo`, units, `buyInfo`, `DARK_MAZE_DATA_INIT` (full redraw). opType 2: position, path, units, `DARK_MAZE_MOVE`. opType 4: formation (`DARK_MAZE_BATTLE_INFO_UPDATA`). opType 5: units. opType 6: `buyInfo` (`DARK_MAZE_SHOP_BUY_UPDATE`). opType 7: `enterToSpace` |
| **4590 (0x11ee)** | U_C_TOP_TOOL_BTN | `simple.PropertyMsg` with `param1 (#1, INT32)` = 2065 (dark maze button): `param2 (#2, INT32)` open status 0 not opened, 1 opened, 2 closed ("toptoolbar.topBtn.darkmaze.stateNewText0..2"); `param7 (#7, BOOL)` icon visible (`darkMazeIsOpen`); `param8 (#8, BOOL)` player passed the maze. Other button ids belong to their features | `DarkMazeManager.__darkmazeBtnHandler` (`:105, 108-121`) | At login and at each event phase change and after passing | Updates the model and the top bar button |
| 157, 156, 153, 154, 4103 | battle | battleType 3898 | battle module | D3 | P-CHILD, P-NOHERO, no bottom bar, dead roles not added (`docs/battle/rules.md` row 3898) |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Windows | `dark_maze_config_time` "2022-04-04 00:00:00\|2022-04-04 06:00:00\|2022-05-01 18:00:00\|2022-05-01 18:00:00" (show, start, end, hide); defaults in `ConfigInfoManager.getDarkMazeConfigTime` (`CM/yishi/datas/ConfigInfoManager.as:1645-1652`) | `ConfigInfos.xml` |
| Resets | `dark_maze_reset_time` list; closed 30 min before each (`DarkMazeManager.as:71-78`; `BattleResultHandler.as:150-155`) | `ConfigInfos.xml` |
| Revive all | `dark_maze_revive_point` = 500 diamonds (default 100), 100% HP to every unit | `:1654-1661` |
| Unlock | `VersionSwitch.DARK_MAZE`, knight job change, at least one guardian ("Entrar no labirinto requer pelo menos um guardião") *(assumption: server check)* | `SwitchPageHelp.as:2774-2787` |
| Layers | 20 (`DarkMazeEventTemplates.Layer` 1..20); passing layer 20 sets `passDarkMaze` | templates |
| Graph | 22 nodes, start 1, exit 22; move only forward to the next column, adjacent row; boss at the exit area | `DarkMazeModel.posIndexArray`, `DarkMazeMainFrame.as:290-366` |
| Event placement | Per layer and area, `DarkMazeLayerTemplates.EventCount` events of each `EventType` are placed on the nodes of that area *(assumption: area = group of node columns; 4 areas; boss in area 4)*; the event template is drawn from `DarkMazeEventTemplates` with the same layer, area and type | templates |
| Battle rewards | `Reward` of the event (-17000 soul: 100..290 common, 150..340 elite, 200..390 boss) | `DarkMazeEventTemplates.xml` |
| Enemies | `Param2` "pawnTemplateId,cell\|..." soldiers (393LLxxyy), `Param1` "heroTemplateId,cell" for elite and boss (3930101,5) | templates |
| Fountain | All alive units +50% max HP | `darkmaze.darkMazeSpringFrame.descTxt1` |
| Demon | Revive one dead unit at 50% HP; if none dead, the unit with the least HP goes to 50% | `darkmaze.darkMazeDemonFrame.descTxt1` |
| Hunter | `Param1` = 5 mercenary template ids of `DarkMazeChildTemplates` (`10101..10105` style: layer, area, job); the hired one joins with full HP; fight power shown = `Attack + Defence + int(MagicAttack x 1.05) + MagicDefence + ForceHit + Live + Parry + (Penetrate + StunAttr) x 20 + (ReduceResi + 6 elemental resists) x 10` | `DarkMazeModel.as:366-376` |
| Shop | `Param1..3` "itemId,count,price,discount" (price in diamonds, discount % shown); each good once | `DarkMazeBuyItemView.as:111-125` |
| Units in battle | max 3 | `DarkMazeShapAdjustmentHeadView.as:195-210` |
| Dead units | HP 0 units cannot fight; when every unit is dead no battle can start (help item 2) | help |
| Soul currency | -17000 "Alma do labirinto" (`darkmazeSoulCoin`), reset 7 days after the event end | `DarkMazeShopFrame.as:145-151` |

---

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/DarkMazeEventTemplates.xml` (340 rows), `DarkMazeEventTemplateInfo` (`CM/yishi/datas/templates/DarkMazeEventTemplateInfo.as`), `darkMazeEventTempCate` | Node event | `Id` (LLAAT#), `Layer`, `Area` 1..4, `EventType` 1..7, `Reward` "tid,count", `Param1` (boss hero / hunter candidates / shop good 1), `Param2` (enemy soldiers / shop good 2), `Param3` (shop good 3) |
| `raw/xml/tempinfos/DarkMazeLayerTemplates.xml` (560 rows) | Event counts | `Id`, `Layer`, `Area`, `EventType`, `EventCount` (server only; no client cate) |
| `raw/xml/tempinfos/DarkMazeChildTemplates.xml` (600 rows), `DarkMazeChildTemplateInfo`, `darkMazeChildTempCate` | Mercenary | `Id`, `Layer`, `Area` 1..3, `JobType` 1..10, combat stats (`Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Parry`, `Live`, `StunAttr`, `Penetrate`, `ReduceResi`, six resistances, `ReduceResiAgainst`, `ResiPenetrate`); display uses the guardian template of the same job at growth 12 (`DarkMazeModel.getChildById`, `:310-331`) |
| `raw/xml/tempinfos/PawnTempInfos.xml`, `GameHeroTemp.xml` | Enemies | battle stats |
| `raw/xml/tempinfos/ConfigInfos.xml` | Config | `dark_maze_config_time`, `dark_maze_revive_point`, `dark_maze_reset_time` |

---

## 7. Persistent state (PostgreSQL, schema `mazes`)

```sql
CREATE TABLE mazes.dark_maze_runs (
  player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  season_start  timestamptz NOT NULL,                 -- reset period the run belongs to
  layer         smallint    NOT NULL DEFAULT 1 CHECK (layer BETWEEN 1 AND 20),
  node_id       smallint    NOT NULL DEFAULT 1 CHECK (node_id BETWEEN 1 AND 22),
  target_node   smallint    NOT NULL DEFAULT 0,
  path          smallint[]  NOT NULL DEFAULT '{1}',
  node_events   integer[]   NOT NULL,                 -- 22 event template ids (0 = none), index = node - 1
  shop_bought   boolean[]   NOT NULL DEFAULT '{false,false,false}',
  passed        boolean     NOT NULL DEFAULT false,
  started       boolean     NOT NULL DEFAULT false,   -- first move done, units snapshotted
  updated_at    timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id)
);

CREATE TABLE mazes.dark_maze_units (
  player_id    integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  unit_id      integer  NOT NULL,          -- guardian id (> 0) or -mercenary template id (< 0)
  hp           integer  NOT NULL CHECK (hp >= 0),
  max_hp       integer  NOT NULL CHECK (max_hp > 0),
  fight_power  integer  NOT NULL,
  stats        jsonb    NOT NULL,          -- snapshot of combat attributes
  formation_cell smallint CHECK (formation_cell IN (1, 3, 4, 6, 7, 9, 10, 12)),
  PRIMARY KEY (player_id, unit_id),
  UNIQUE (player_id, formation_cell)
);
```

The `-17000` soul balance belongs to the currency feature.

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `mazes::dark_maze::handle_enter` | 8662 op 1 | event window, not within 30 min of a reset, not passed, job change, at least one guardian | Create or reset the run for the current reset period (generate layer 1 events). Send 4278 opType 1 |
| `mazes::dark_maze::handle_walk` | 8662 op 2 | run exists; node is the forced target or in the next column with row ± 1; event rules: battle needs at least one alive unit in the formation; hunter needs `id` in the candidate list; shop: first op 2 enters (keep position on the node), op 2 with `id=1` completes | First move of the run: snapshot guardians into `dark_maze_units`. Events: 0 move; 1..3 start battle 3898 (formation units with persistent HP vs `Param1/Param2` enemies), on win move and grant `Reward`, on loss keep `target_node = node` and save HP; 4 heal 50%; 5 demon rule; 6 add mercenary at full HP; 7 shop. Send 4278 opType 2 |
| `mazes::dark_maze::handle_next_layer` | 8662 op 3 | current node 22 and its event done | `layer += 1` (or `passed` after 20), regenerate events, node 1, path {1}, shop flags reset. Send 4278 opType 3; push 4590 when passed |
| `mazes::dark_maze::handle_formation` | 8662 op 4 | ≤ 3 units, owned unit ids, allowed cells, dead units allowed but useless | Save cells. Send 4278 opType 4 |
| `mazes::dark_maze::handle_revive_all` | 8662 op 5 | not all at max HP; diamonds >= `dark_maze_revive_point` | Debit, all HP = max. Send 4278 opType 5, currency push |
| `mazes::dark_maze::handle_buy` | 8662 op 6 | player on that shop node; index 1..3 not bought; diamonds >= price | Debit, grant item, set flag. Send 4278 opType 6, bag and currency pushes |
| `mazes::dark_maze::handle_leave` | 8662 op 7 | none | Send 4278 opType 7 |
| `mazes::dark_maze::scheduler` | timers | | At event phases and resets broadcast 4590 (`param1=2065`, `param2`, `param7`, `param8` per player) |

Battle 3898 configuration: player side = up to 3 dark maze units at their cells with current HP (guardians use the snapshot stats; mercenaries use `DarkMazeChildTemplates`); no hero; enemy side from the event template. After the battle save each unit HP.

---

## 9. Open questions and assumptions

- *(assumption)* Mapping of areas to node columns and the event placement algorithm.
- *(assumption)* Answer opType for D5 (shop opening).
- *(assumption)* Pawn ids 393xxxxxx exist in the server pawn data (not checked locally).
- The local config dates are from 2022; an event schedule must be configured.

---

## 10. Implementation checklist

- [ ] Loaders of the three dark maze templates and config keys.
- [ ] Tables `mazes.dark_maze_runs`, `mazes.dark_maze_units`.
- [ ] 4590 push (button 2065) at login and on phase changes.
- [ ] Route 8662 ops 1..7 with validation and 4278 answers per opType.
- [ ] Layer generator from `DarkMazeLayerTemplates`.
- [ ] Battle 3898 with persistent unit HP.
- [ ] Soul rewards and shop 1023 (shops feature).
- [ ] Screen check: node lighting and locks, event frames, formation limit, shop flags.
- [ ] Test: moving two columns ahead is refused.
- [ ] Test: revive all with everybody at full HP is refused.
- [ ] Test: after layer 20 the player cannot enter until the next reset.
