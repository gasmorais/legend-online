# Reward chests (count chests and floor event)

Module `reward-chests` of feature `golden-tree`. Personal count chests unlocked by the number of opens ("Consumos") and the server wide 5 floor event ("derrubar a árvore").

Path aliases:

| Alias | File |
|---|---|
| BM | `decompiled/core_module/scripts/managers/BottleManager.as` |
| BMO | `decompiled/core_module/scripts/mvc/module/bottle/BottleModel.as` |
| BBV | `decompiled/m11/scripts/bottle/BottleBoxView.as` |
| BIBV | `decompiled/m11/scripts/bottle/BottleIntergalBoxView.as` |
| BBOV | `decompiled/m11/scripts/bottle/BottleBottomView.as` |
| BBIBV | `decompiled/m11/scripts/bottle/BottleBottomIntergalBoxView.as` |
| BBVT | `decompiled/m11/scripts/bottle/BottleBoxViewTips.as` |

## 1. Overview

Count chests (bottom bar): 5 thresholds from 295 `score`; when the player's `count` reaches a threshold the chest glows and can be claimed once ("Este prêmio já foi coletado" afterwards, "Condições de coleta insuficiente" before).

Floor event (vertical bar): 5 floors with global thresholds from 295 `storey`. Every open by any player adds to a server total. The player whose open makes the total reach floor i becomes that floor's winner; his name appears in the floor tip ("Parabéns ... Obteve Prêmios") and only he can claim the floor chest. Help text: the event has 5 floors, higher floors give better rewards, it runs with the tree event and "pode concluir 1 vez por dia".

## 2. Screens

| Class | Purpose | Data shown |
|---|---|---|
| `BottleBottomView` (`BBOV`) | count bar, 5 chests, "+N" float on new opens | progress from `count` vs `getCountArray` (`BBOV:225-287`); tip "Consumos: {0}" |
| `BottleBottomIntergalBoxView` (`BBIBV`) | one count chest | glow when `count >= param` and mark 0; gray when mark 1 (`BBIBV:83-115`); tip = chest contents |
| `BottleBoxView` (`BBV`) | floor tower, 5 floor chests, current total, floor thresholds, "Pisos +N" float | `nowLayer` and `getHeightArray` (`BBV:171-224`), progress mapping (`BBV:371-420`) |
| `BottleIntergalBoxView` (`BIBV`) | one floor chest | glow when the floor winner is the current player and `state == 0`; claimed when `state == 1` (`BIBV:98-161`) |
| `BottleBoxViewTips` (`BBVT`) | tip | "Prêmio do Piso atual", contents "name*count", winner with VIP icon, "Parabéns" / "Obteve Prêmios" or "O prêmio do piso atual ainda não foi configurado" (`BBVT:77-140`) |

## 3. Routes (client to server)

Route C>S 8604 (0x219c) `C_BOTTLE_OP`, `BottleOpMsg { alter_type (#1, INT32), op_type (#2, INT32), stick_first (#3, INT32) }`, sender `BM.sendOpenInfo` (`BM:143-158`, `stick_first` is always 0 here).

### R1. Claim a count chest (op 5)
- UI: click a count chest (`BBIBV:53-70`).
- Client checks: already claimed -> "Este prêmio já foi coletado"; `count < param` -> "Condições de coleta insuficiente"; sends only when `count >= param` and mark 0.
- Fields: `op_type = 5`, `alter_type` = chest threshold (`score[i].param`).
- Response: 115 (items into bag 1, assumption: bag 1 rather than storage since the icon flies to the bag at (495, 316)), 4526 with the updated `tree_status`. Client then sends op 3 (`BBV:361-369`, `BBOV:215-223`).

### R2. Claim a floor chest (op 6)
- UI: click a floor chest (`BIBV:63-74`).
- Client checks: already claimed -> "Este prêmio já foi coletado"; the click handler sends whenever the floor has package data and is not flagged claimed; the glow only shows for the winner.
- Fields: `op_type = 6`, `alter_type` = floor threshold (`storey[i].param`).
- Server must verify the caller is the floor winner and has not claimed.
- Response: 115 (items), 4825 with `state = 1` for that floor (pushed to all online players).

## 4. Server messages (server to client)

### S1. 4825 (0x12d9) `U_C_BOTTLE_ACTIVE`, `BottleMsg`
Receiver `BM.__updateBottleUserInfomation` (`BM:160-189`), dispatches `UPDATE_REWARD_USERINFO` (`BBV:205-224`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `playerBottle` | #1 | `PlayerBottleMsg`, repeated (max 5, index = floor) | `userId (#1, INT32)` winner (0 none), `nickName (#2, STRING)`, `isVip (#3, BOOL)`, `state (#4, INT32)` 0 not claimed, 1 claimed |
| `total` | #2 | INT32 | global opens; client clamps to the last floor threshold (`nowLayer`) |

Sent on op 4, op 3, when the total changes (broadcast, assumption: throttled to once per second), when a floor is won or claimed.

### S2. 4526 `U_C_BOTTLE_RESULT`
`tree_status` "a,b,c,d,e" carries the count chest marks; `count` the personal opens. See [tree-open.md](tree-open.md).

### S3. 295 `U_C_BOTTLE_DROP_DATA`
`score` (count chests) and `storey` (floors): `BottlePackage { param (#1, INT32), item (#2, BottleItemInfoMsg, repeated) }`. See [tree-open.md](tree-open.md).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Count chest unlock | `count >= score[i].param` | `BBIBV:60-69` |
| Count chest claim | once per event (mark 1 in `tree_status`) | `BBIBV:100-113` |
| Floor won | when the global total reaches `storey[i].param`, the opener at that moment wins floor i | help text item 3 |
| Floor claim | only the winner, once (`state 1`) | `BIBV:118-145` |
| Floors | 5, ascending thresholds; bar heights 25, 90, 90, 90, 90 | `BBV:28-32,371-420` |
| Daily cycle | floor event resets daily (help text item 6, "1 vez por dia") | assumption: reset total and winners at 00:00; count chests reset only with the event |
| Contents | server configuration (`BottlePackage.item`) | |

## 6. Templates

None in the client. Chest and floor contents are event configuration.

## 7. Persistent state

```sql
CREATE TABLE golden_tree.count_chests (
  event_id     INTEGER  NOT NULL REFERENCES golden_tree.events(event_id) ON DELETE CASCADE,
  chest_index  SMALLINT NOT NULL CHECK (chest_index BETWEEN 0 AND 4),
  threshold    INTEGER  NOT NULL CHECK (threshold > 0),
  items        JSONB    NOT NULL,
  PRIMARY KEY (event_id, chest_index),
  UNIQUE (event_id, threshold)
);

CREATE TABLE golden_tree.floors (
  event_id     INTEGER  NOT NULL REFERENCES golden_tree.events(event_id) ON DELETE CASCADE,
  floor_index  SMALLINT NOT NULL CHECK (floor_index BETWEEN 0 AND 4),
  threshold    INTEGER  NOT NULL CHECK (threshold > 0),
  items        JSONB    NOT NULL,
  PRIMARY KEY (event_id, floor_index),
  UNIQUE (event_id, threshold)
);

CREATE TABLE golden_tree.floor_cycles (
  event_id     INTEGER NOT NULL REFERENCES golden_tree.events(event_id) ON DELETE CASCADE,
  cycle_date   DATE    NOT NULL,
  total_opens  INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, cycle_date)
);

CREATE TABLE golden_tree.floor_winners (
  event_id     INTEGER  NOT NULL,
  cycle_date   DATE     NOT NULL,
  floor_index  SMALLINT NOT NULL CHECK (floor_index BETWEEN 0 AND 4),
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  claimed      BOOLEAN  NOT NULL DEFAULT false,
  won_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (event_id, cycle_date, floor_index),
  FOREIGN KEY (event_id, cycle_date) REFERENCES golden_tree.floor_cycles(event_id, cycle_date) ON DELETE CASCADE
);
```

Count chest marks: `golden_tree.player_state.chest_marks` ([tree-open.md](tree-open.md)).

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 8604 op 5 | `golden_tree::reward_chests::handle_claim_count_chest` |
| 8604 op 6 | `golden_tree::reward_chests::handle_claim_floor_chest` |

- Floor crossing (inside `handle_open`): lock the cycle row (`SELECT ... FOR UPDATE`), `old = total`, `total += N`; for every floor with `old < threshold <= total` insert the winner (the opener). Commit, then broadcast 4825 and a system chat or 4497 type 2 line.
- Count chest: event active (assumption: also allowed after the end while the button is visible) -> threshold matches a chest -> `open_count >= threshold` -> mark 0 -> bag space -> one transaction: set mark 1, grant items -> 115, 4526.
- Floor chest: winner row for today and this floor with `player_id = caller` and `claimed = false` -> bag space -> transaction: set claimed, grant items -> 115, 4825 broadcast.
- Daily job at 00:00: open a new `floor_cycles` row, broadcast 4825 with empty winners.

## 9. Open questions and assumptions

- Assumption: floor event resets daily; count chests are per event.
- Assumption: rewards go to bag 1.
- Assumption: a single open crossing several floors wins all of them.

## 10. Implementation checklist

- [ ] Screens (client ready): `BottleBottomView`, `BottleBottomIntergalBoxView`, `BottleBoxView`, `BottleIntergalBoxView`, `BottleBoxViewTips`, `BottleBottomViewTips`.
- [ ] Route 8604 op 5.
- [ ] Route 8604 op 6.
- [ ] Message 4825 (broadcast), 4526 marks.
- [ ] Tables `golden_tree.count_chests`, `golden_tree.floors`, `golden_tree.floor_cycles`, `golden_tree.floor_winners`.
- [ ] Daily floor reset job.
- [ ] Tests: claim below threshold refused; double claim refused; concurrent opens crossing the same floor produce exactly one winner; non winner floor claim refused.
