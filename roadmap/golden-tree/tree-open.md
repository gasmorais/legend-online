# Tree opening ("Árvore de Ouro")

Module `tree-open` of feature `golden-tree`. Event state, opening the tree with diamonds or sticks, drops, feeds and the storage.

Path aliases:

| Alias | File |
|---|---|
| BM | `decompiled/core_module/scripts/managers/BottleManager.as` |
| BMO | `decompiled/core_module/scripts/mvc/module/bottle/BottleModel.as` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| BF | `decompiled/m11/scripts/bottle/BottleFrame.as` |
| BSF | `decompiled/m11/scripts/bottle/BottleStorageFrame.as` |
| BBV | `decompiled/m11/scripts/bottle/BottleBagView.as` |
| BDF | `decompiled/m11/scripts/bottle/BottleDropFrame.as` |
| BBCM | `decompiled/core_module/scripts/cell/mediator/bottlebag/BottleBagCellClickMediator.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

The event is announced by 295 (`open`, `end_time`). The toolbar button sends op 4; the server answers with 295, 4825, 4497 and 4526 `open_view = true`, which opens `BottleFrame`. Opening plays a 1 s shake animation and waits for 4526 `alter_bottle = true` (10 s timeout closes the frame, `BF:511-518`); drops arrive as bag 22 updates (115).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `BottleFrame` (`BF`) | "Árvore de Ouro" | tree, 3 open buttons, stick counter and check box, timer, feeds, showcase, chests | controller `bottle` | prices from `Bottle_Price` (`BF:181-215`); "Bastão de Ouro atual:" count of 208022 in bag 1 (`BF:315-326`); "Uso prioritário do Bastão de Ouro" check box default on (`BF:244-245`); "Evento encerrado em:" countdown to `end_time` (`BF:246-247,328-332`); up to 6 showcase items (`is_show`, "new" marker `is_new_items`) (`BF:248-271`, `BMO:137-151`); own drop feed and global luck feed (`BF:627-679`); chests ([reward-chests.md](reward-chests.md)) |
| `BottleDropFrame` (`BDF`) | "Lista de Itens" | all possible drops | "poderá obter" link (`BF:334-339`) | `drop_item` list sorted by Profile desc, SonType, id (`BDF:52-125`) |
| `BottleStorageFrame` (`BSF`) | "Armazém da árvore de ouro" | storage grid, "Coletar Tudo", "Vender Tudo", "Organizar" | storage button (`BF:356-361`) | `BBV`: bag 22, 8 x 5 (8 x 7 when more than 40 items) (`BBV:26-43`); "Clique no item para colocar na mochila" |
| `SimpleHelpFrame` style `bottle.BottleHelpFrame` | "Introdução da Árvore de Ouro" | rules `bottle.BottleFrame.helpFrame.helpContent` | help button | static |

## 3. Routes (client to server)

Route C>S 8604 (0x219c) `C_BOTTLE_OP`, `BottleOpMsg`: `alter_type (#1, INT32)`, `op_type (#2, INT32)`, `stick_first (#3, INT32)`. Sender `BM.sendOpenInfo(opType, alterType, useStick = true)` (`BM:143-158`): `stick_first = 0` when `useStick`, else 1.

### T1. Open the view (op 4)
- UI: toolbar button (`TTB:1140-1142`). Visible when level >= 11 and `openBottle` (`TBH:253-254`).
- Fields: `op_type = 4`, `alter_type = 0`, `stick_first = 0`.
- Response order: 295 (drop list, chests, event dates), 4825 (floor event), 4497 `pass_type 1` (own history) and `pass_type 2` (luck feed), 4526 with `open_view = true` (opens the frame, `BMO:212-220`).

### T2. Open the tree (op 0)
- UI: the 3 open buttons (`BF:373-417`).
- Client checks: storage has more than 40 items -> "Armazém da árvore de ouro cheia"; event ended -> `activity.ActivityManager.command02`; for 10 and 50 opens a daily skippable confirm "Deseja consumir {0} diamantes para abrir {1} vez(es) a árvore de ouro?" (`BF:419-448`); funds: with sticks `point + sticks * 20 >= cost`, without `point >= cost`, else recharge alert (`BF:450-468`).
- Fields: `op_type = 0`, `alter_type` = 1 (1 open, 20 diamonds), 2 (10 opens, 200), 3 (50 opens, 1000); `stick_first` = 0 when the check box is on.
- Response order: 115 bag 22 adds (one per new item cell), 3 (diamonds), 115 bag 1 (sticks consumed), 4497 `pass_type 1` with the new drop lines, 4526 with the new `count`, `tree_status` and `alter_bottle = true`, 4825 when the global total changed (pushed to every online player, see [reward-chests.md](reward-chests.md)), 4497 `pass_type 2` to everyone for rare drops.
- After the animation the client sends op 3 (`BF:499-509`).

### T3. Refresh (op 3)
- Sent on close (`BF:363-371`), after an open result (`BF:505`), after the drop animation (`BF:609`) and after chest icon animations.
- Response: 4526 with `open_view = false`, `alter_bottle = false` (assumption) and 4825.

### T4. Collect all (op 2)
- UI: "Coletar Tudo" (`BSF:133-137`), enabled when bag 22 is not empty.
- Response: 115 removing bag 22 cells and adding bag 1 cells. Assumption: stop at the first full main bag slot and keep the rest.

### T5. Sell all (op 1)
- UI: "Vender Tudo" with confirm "Deseja vender todos os itens dentro do armazém da árvore de ouro?" (`BSF:114-131`).
- Response: 115 removing all bag 22 cells, gold resource push (sum of `SellGold * count`, assumption).

### T6. Move one item to the bag
- UI: click an item in storage (`BBCM:41-56`). Client check: a free bag 1 slot (`GM.findEmputyPos`) else `cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01`.
- Route C>S 5005 (0x138d) `U_C_BAG_MOVE`, `ItemReqMsg`: `begin_bag_type (#1)` = 22, `begin_obj_id (#2)` = 0, `begin_pos (#3)` = cell, `end_bag_type (#4)` = 1, `end_obj_id (#5)` = 0, `end_pos (#6)` = free slot, `count (#7)` = stack count, `object_id (#8)` unset. Generic move, see [inventory](../inventory/README.md).
- "Organizar" uses the generic tidy (`BagHelper.onTidyHandler`, bag 22).

## 4. Server messages (server to client)

### S1. 295 (0x0127) `U_C_BOTTLE_DROP_DATA`, `BottleDropListMsg`
Receiver `BM.__updateBottleData` (`BM:108-141`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `dropItem` | #1 | `BottleItemInfoMsg`, repeated | every possible drop: `temp_id (#1, INT32)`, `count (#2, INT32)`, `is_show (#3, BOOL)` showcase (first 6), `is_new_items (#4, BOOL)` "new" marker |
| `score` | #2 | `BottlePackage`, repeated | count chests: `param (#1, INT32)` opens needed, `item (#2, BottleItemInfoMsg, repeated)` contents; sorted by `param` |
| `storey` | #3 | `BottlePackage`, repeated | floor chests: `param` global total for the floor, `item` contents; sorted by `param` |
| `open` | #4 | BOOL | event active |
| `end_time` | #5 | STRING | "YYYY-MM-DD hh:mm:ss" event end |

Client: `openBottle = open && now < end_time`, refreshes the toolbar. Sent at login when an event exists, on op 4, and when the event starts or ends.

### S2. 4526 (0x11ae) `U_C_BOTTLE_RESULT`, `BottleScoreMsg`
Receiver `BM.__updateBottleResult` (`BM:93-106`): computes `addCount = count - openCount`, dispatches `CT__UPDATE_BOX_STATUS { addCount, alert }`.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `tree_status` | #1 | STRING | count chest marks "a,b,c,d,e" (0 not claimed, 1 claimed) |
| `count` | #2 | INT32 | personal opens ("Consumos") |
| `open_view` | #3 | BOOL | true: open the frame |
| `alter_bottle` | #4 | BOOL | true: the open finished (ends the frame wait, `BF:487-497`) |

### S3. 4497 (0x1191) `U_C_BOTTLE_PASS`, `BottlePassMsg`
Receiver `BM.__updateBottleInfo` (`BM:71-91`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `pass_type` | #1 | INT32 | 1: own drop lines (appended), 2: global luck feed (replaced) |
| `infos` | #2 | STRING, repeated | chat formatted lines, parsed with `ChatFormat.getContentCellData` on channel 21 (`BF:640-645`) |
| `count` | #3 | INT32 | unused |
| `dropId` | #4 | INT32 | unused |

### S4. 115 (0x0073) `U_C_BAG_MOVE_UPDATE`
Bag 22 changes dispatch `UPDATE_BOTTLE_BAG` / `DELETE_BOTTLE_BAG` (`GM:158-161,204-207`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Visibility | level >= 11, `open` and `now < end_time` | `TBH:253-254`, `BM:131-139` |
| Prices | `Bottle_Price` = "20\|200\|1000" for 1, 10, 50 opens | `ConfigInfos.xml`, `BF:181-215,390-415` |
| Stick | 208022 "Bastão de Ouro" = 1 open (worth 20 diamonds); used first when `stick_first = 0` | `BF:456-461`, item description |
| Storage | bag type 22; opening blocked above 40 items | `BF:377-382`, `BBV:28-38` |
| Animation | icons for `alter_type * 2 - 1` drops (display only) | `BF:588-591` |
| Drop table | server side; the client only knows the displayed list (295 `dropItem`) | assumption: weighted table per event |
| Daily | help text item 6: the floor event can be completed once per day | `bottle.BottleFrame.helpFrame.helpContent` |

## 6. Templates

| File | Fields used |
|---|---|
| `ConfigInfos.xml` | `Bottle_Price` |
| `ItemTempInfos.xml` | 208022 and drop item display (`TemplateName`, `Profile`, `SonType`, `SellGold`) |
| `TopToolBtnInfos.xml` | 2039 `BtnKey = bottle` |

No drop template ships with the client: event data (drops, chests, floors, dates) is server configuration.

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS golden_tree;

CREATE TABLE golden_tree.events (
  event_id     INTEGER PRIMARY KEY,
  starts_at    TIMESTAMPTZ NOT NULL,
  ends_at      TIMESTAMPTZ NOT NULL CHECK (ends_at > starts_at),
  price_1      INTEGER NOT NULL DEFAULT 20,
  price_10     INTEGER NOT NULL DEFAULT 200,
  price_50     INTEGER NOT NULL DEFAULT 1000
);

CREATE TABLE golden_tree.drops (
  event_id     INTEGER NOT NULL REFERENCES golden_tree.events(event_id) ON DELETE CASCADE,
  template_id  INTEGER NOT NULL,
  count        INTEGER NOT NULL CHECK (count > 0),
  weight       INTEGER NOT NULL CHECK (weight > 0),
  is_show      BOOLEAN NOT NULL DEFAULT false,
  is_new       BOOLEAN NOT NULL DEFAULT false,
  is_rare      BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (event_id, template_id, count)
);

CREATE TABLE golden_tree.player_state (
  event_id     INTEGER NOT NULL REFERENCES golden_tree.events(event_id) ON DELETE CASCADE,
  player_id    BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  open_count   INTEGER NOT NULL DEFAULT 0 CHECK (open_count >= 0),
  chest_marks  SMALLINT[] NOT NULL DEFAULT '{0,0,0,0,0}',
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE golden_tree.drop_log (
  log_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  event_id     INTEGER NOT NULL REFERENCES golden_tree.events(event_id) ON DELETE CASCADE,
  player_id    BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id  INTEGER NOT NULL,
  count        INTEGER NOT NULL,
  is_rare      BOOLEAN NOT NULL,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX drop_log_player ON golden_tree.drop_log (event_id, player_id, created_at DESC);
CREATE INDEX drop_log_rare ON golden_tree.drop_log (event_id, created_at DESC) WHERE is_rare;
```

Storage items: generic items table with `bag_type = 22`.

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 8604 op 4 | `golden_tree::tree_open::handle_open_view` |
| 8604 op 0 | `golden_tree::tree_open::handle_open` |
| 8604 op 3 | `golden_tree::tree_open::handle_refresh` |
| 8604 op 2 | `golden_tree::tree_open::handle_collect_all` |
| 8604 op 1 | `golden_tree::tree_open::handle_sell_all` |
| 5005 (bag 22 -> 1) | generic `inventory::bag::handle_move` |

- Open validation order: active event and `now < ends_at` -> `alter_type` in 1..3 -> storage has <= 40 items (and room for the new drops, assumption: allow overflow up to the 8 x 7 view, 56) -> funds: sticks first if `stick_first = 0` (one per open), remainder `* 20` in diamonds; for 10 and 50 opens charge the package price when no sticks are used (assumption: mixed payments use 20 per remaining open) -> one transaction: debit, roll N drops, insert into bag 22, `open_count += N`, global total += N (floor crossing, see [reward-chests.md](reward-chests.md)), log -> push 115, 3, 4497 type 1, 4526 `alter_bottle = true`; broadcast 4825 and rare 4497 type 2.
- Feed strings: build chat content lines (player link plus item link) as for system chat; keep the last 20 per player and the last 20 rare drops (assumption).
- End of event: set `open = false` (push 295), keep bag 22 items (the player can still collect) until a configurable purge (assumption).

## 9. Open questions and assumptions

- Assumption: op 3 is a pure refresh.
- Assumption: package prices apply only when no stick is used; the client check uses 20 per stick.
- Assumption: drop tables, feeds size and purge policy.
- Unknown: whether `stick_first = 1` must refuse to use sticks entirely (the client wording "Uso prioritário" suggests priority only).

## 10. Implementation checklist

- [ ] Screens (client ready): `BottleFrame`, `BottleDropFrame`, `BottleStorageFrame`, `BottleBagView`, `BottleNotic`, help frame.
- [ ] Route 8604 op 4 -> 295, 4825, 4497, 4526.
- [ ] Route 8604 op 0 with sticks and diamonds.
- [ ] Route 8604 op 3.
- [ ] Route 8604 op 2, op 1.
- [ ] Route 5005 for bag 22.
- [ ] Messages 295, 4526, 4497, 115, 3.
- [ ] Tables `golden_tree.events`, `golden_tree.drops`, `golden_tree.player_state`, `golden_tree.drop_log`.
- [ ] Tests: level 10 player gets no button (295 still sent); open after `end_time` refused; 50 opens with 10 sticks charges 800 diamonds; 41 items in storage blocks opening; sell all credits gold and empties bag 22.
