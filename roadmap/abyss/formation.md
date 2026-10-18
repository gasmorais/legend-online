# Abyss guardian formation ("Ajustar Formação")

Feature `abyss`, module `formation`. Client: `M14/childabysm/ChildAbysmFormationFrame.as`, `ChildAbysmFormationHeadView.as`, `ChildAbysmFormationItemView.as` (package registered to the guardians feature), `M11/abysm/view/item/AbysmChildItemHeadView.as`, `CM/mvc/module/outyard/AbysmModel.as:158-222`, `CM/yishi/manager/OutyardManager.as:356-386`. Conventions: see [README.md](README.md).

---

## 1. Overview

- The abyss uses its own guardian line-up, independent of the guardian formations of other modes.
- Each entry has a guardian id, a grid position (`attackPos`, one of the 8 front and back cells 1, 4, 7, 10, 3, 6, 9, 12) and a fighting order (`pos` 1..n; order 1 fights first).
- At most 4 guardians. Slots at the end of the order can be sealed by the floor (`guardSealNum`); sealed guardians do not fight *(assumption: the order positions `> 4 - guardSealNum` are skipped)*.
- The line-up can change only before the first wave of a floor (`index % 7 == 1`); otherwise "Apenas poderá alterar a formação durante a primeira rodada em cada piso.".
- Two editors send the same request: the formation frame (grid editor) and drag and drop between the four heads of the abyss frame (order editor).

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `childabysm.ChildAbysmFormationFrame` (`M14/childabysm/ChildAbysmFormationFrame.as`), controller key `childformation` openType 8 (handled by `OutyardControler`, `CM/yishi/manager/FrameControllerManager.as:1809-1811`, `CM/mvc/controler/OutyardControler.as:79-82`) | "Ajustar Formação" | Place guardians on the grid | "Ajustar Formação" button of both abyss frames (`M11/abysm/AbysmFrame.as:214-217`, `HellAbysmFrame.as:200-203`) | Paged list of the player's guardians (heads disabled when already in the line-up, `:188-199`); 8 grid cells (`_bottoms`); drop of a head on a cell or between cells; on drop end the full line-up is sent (`:219-238, 379-406`) |
| `ChildAbysmFormationHeadView` (`M14/childabysm/ChildAbysmFormationHeadView.as:140-160`) | none | Draggable guardian head | Formation frame | Refuses drag with "Lugar ocupado" (`abysm.abysmView.posFull`) when 4 guardians are already placed, and with `abysm.abysmViewTips03` outside the first wave |
| `ChildAbysmFormationItemView` (`M14/childabysm/ChildAbysmFormationItemView.as:170-195`) | none | Grid cell | Formation frame | Dropping a cell back to the list removes the guardian only if more than one remains; first-wave rule |
| `abysm.view.item.AbysmChildItemHeadView` (`M11/abysm/view/item/AbysmChildItemHeadView.as:153-234`) | none | Fighting order heads (4) | Abyss frames | Dropping one head on another swaps their `pos` (`AbysmModel.changePos(a, b)`, `CM/mvc/module/outyard/AbysmModel.as:158-209`) and sends the line-up. No first-wave check here *(the server must enforce it)* |

---

## 3. Routes (client to server)

Opcode **9644 (0x25ac) C_GUARDENDLESS_OP**, body `guardendless.GuardendlessOpMsg` (all fields in [abyss-tower.md](abyss-tower.md) §3).

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| F1 | Drop on the grid editor | `ChildAbysmFormationFrame.__endDragHandler` → `updateToPlayerInfo` (`M14/childabysm/ChildAbysmFormationFrame.as:219-238, 379-406`) → `OutyardManager.abysmSendInfo(2, list)` (`CM/yishi/manager/OutyardManager.as:356-386`) | Max 4 guardians; first wave of the floor; at least one guardian remains | `{opType=2, guardPos=[{param1=childId, param2=attackPos, param3=pos}...], isHorrible}`. The list holds every placed guardian, read from cells in the order `[1,4,7,10,3,6,9,12]`; existing guardians keep their `pos`, new ones get 9999, then all are renumbered 1..n by `pos` (`getChildPos`, `:473-487`) | **423** with the saved `guardPos` |
| F2 | Drag one order head onto another | `AbysmChildItemHeadView.onDragStop` (`M11/abysm/view/item/AbysmChildItemHeadView.as:207-234`) | Both heads hold a guardian | `{opType=2, guardPos=childList after the swap (all entries with childId, attackPos, pos), isHorrible}` | **423** |

`isHorrible` is the flag of the frame that opened last; op 2 saves the line-up of that variant.

---

## 4. Server messages (server to client)

| Opcode | Name | Use |
|---|---|---|
| 423 (0x01a7) | U_C_GUARDENDLESS_INFO | Full state; `guardPos (#3, GuardEndlessPosMsg, repeated)` = saved line-up (`param1` child id, `param2` attackPos, `param3` pos); `guardSealNum (#8)` sealed slots. Receiver and reaction in [abyss-tower.md](abyss-tower.md) §4 |

No error code. A refused save is answered by 423 with the unchanged line-up *(assumption)*, which also resets the client view.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Max guardians | 4 | `ChildAbysmFormationHeadView.as:144-149`; 4 heads in `AbysmChildView` |
| Grid cells | 1, 3, 4, 6, 7, 9, 10, 12 (two columns of the 3x4 grid, `docs/battle/formation.md`) | `ChildAbysmFormationFrame.as:382, 236` |
| Edit window | `index % 7 == 1` (first wave of a floor) | `ChildAbysmFormationHeadView.as:150-155`, `ChildAbysmFormationItemView.as:178-183` |
| Minimum | At least 1 guardian | `ChildAbysmFormationItemView.as:184-187` |
| Ownership | Every `param1` must be a guardian owned by the player | |
| Seals | `guardSealNum` 0..3; order slots `> 4 - guardSealNum` greyed (`AbysmChildItemHeadView.as:108-151`) | |

---

## 6. Templates

None specific. Guardian data comes from the guardians feature (`ChildManager.model`, `ChildTempInfo`).

---

## 7. Persistent state (PostgreSQL, schema `abyss`)

```sql
CREATE TABLE abyss.formation_slots (
  player_id    integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  is_hell      boolean  NOT NULL,
  fight_order  smallint NOT NULL CHECK (fight_order BETWEEN 1 AND 4),
  child_id     integer  NOT NULL,                  -- guardians feature id
  grid_pos     smallint NOT NULL CHECK (grid_pos IN (1, 3, 4, 6, 7, 9, 10, 12)),
  PRIMARY KEY (player_id, is_hell, fight_order),
  UNIQUE (player_id, is_hell, child_id),
  UNIQUE (player_id, is_hell, grid_pos)
);
```

Add a foreign key to the guardians table once it exists (`guardians.children(child_id)`).

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `abyss::formation::handle_save` | 9644 op 2 | progress row of `isHorrible` exists → no sweep running → `wave_index % 7 == 1` (first wave) → 1..4 entries → every `param1` owned and distinct → every `param2` in the allowed cell set and distinct → `param3` renumbered 1..n (accept any order, sort by `param3`) | One tx: replace all `formation_slots` of `(player, is_hell)`. After commit send 423 |

---

## 9. Open questions and assumptions

- *(assumption)* Effect of seals on the fighting order.
- *(assumption)* Default line-up when the player opens the abyss for the first time (for example the first guardians of the main guardian formation).
- The order editor (F2) does not check the first-wave rule on the client; the server rule decides.

---

## 10. Implementation checklist

- [ ] Table `abyss.formation_slots`.
- [ ] Route 9644 op 2 with validation; reply 423.
- [ ] Battle builder reads the line-up (order and grid) of the right variant.
- [ ] Test: save outside the first wave is refused and 423 restores the old line-up.
- [ ] Test: a fifth guardian is refused.
