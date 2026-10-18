# Archaeology handbook ("Imagem de Arqueologia")

Feature [archaeology](README.md), module `handbook`. Aliases in [README.md](README.md).

## 1. Overview

- 59 pictures (`ArchaeologyBookTemps.xml` rows with `Type = 1`). Each picture lists up to 3 archaeology items (`Collection1..3`, item template ids). When every listed item has `itemCount >= 1` (exchanged at least once, [collection.md](collection.md)) the player can claim the picture reward once.
- Rewards: up to 4 items or currencies (`RewardId1..4`, `RewardCount1..4`), one residence furniture (`RewardFurnitureId`, `RewardFurnitureCount`) and optionally a title (`RewardAppell`, only used by Type 2 rows).
- States per picture (`AMOD.checkHandBookStateById`, `AMOD:46-69`): 1 claimable, 2 incomplete, 3 already claimed (0 unknown template). The list is sorted by state then id (`AMOD:239-271`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `M14A/ArchaeologyBookFrame.as` (style `archaeology.ArchaeologyBookFrame`) | "Imagem de Arqueologia" | Paged list of pictures (`_pageCount` per page), previous/next page (`:42-174`) | "Imagem de Arqueologia" button in `ArchaeologyMakeView` (`M14A/ArchaeologyMakeView.as:78-94`; loads `3.png` module for `FurnitureBagCell` first) | `getBookArr()` |
| `M14A/ArchaeologyBookItem.as` | "Condições de obtenção:", "Prêmios:", tip "Origem: {0}~{1}" | One picture: name, required item names colored by collected state with origin map and type tip, reward cells, furniture cell, claim button or "already claimed" image (`:90-174`) | book frame | template + item states + handbook state |

## 3. Routes (client to server)

Common: send 9575 (0x2567) `C_ARCHAEOLOGY_REQ`, `ArchaeologyReqMsg` `op` (#1, INT32), `tempId` (#2, INT32); sender `AM.sendArchaeologyRequest` (`AM:98-105`).

### R1. Load handbook states (op 2)

- UI: opening "Arqueologia" (`M14A/ArchaeologyFrame.as:34-41`).
- Client checks: none.
- Request: `op = 2`, `tempId = 0`.
- Expected: 296 `U_C_ARCHAEOLOGY_DATA` with the claim state of every picture already claimed (at minimum).

### R2. Claim picture reward (op 4)

- UI: claim button `getBtn` (`M14A/ArchaeologyBookItem.as:85-88`).
- Client checks: button enabled only when state is 1 (all items collected and not claimed, `:159-173`).
- Request: `op = 4`, `tempId = ArchaeologyBookTemp.Id`.
- Expected: 296 with the row `{tempId, getAlready = true}`; reward pushes: bag 115, player info 3, furniture bag update ([farm](../farm/README.md)), title ([medals](../medals/README.md)) when `RewardAppell != 0`.

## 4. Server messages (server to client)

### 296 (0x0128) `U_C_ARCHAEOLOGY_DATA`

- Message `ArchaeologyRspMsg`: `op` (#1, INT32) echo of the request op (not read by the client); `bookRewardState` (#2, MESSAGE `ArchaeologyRewardStateMsg`, repeated): `tempId` (#1, INT32) book id; `getAlready` (#2, BOOL) reward claimed.
- Receiver: `ArchaeologyManager.__getArchaeologyBookData` (`AM:54-73`, listener `AM:50`). Upsert by `tempId` into `handBookStateArr`; notifies `ARCHAEOLOGY_BOOK_DATA` (book frame refresh, picture badge) and HUD counter 30.
- When: reply to op 2 (all claimed rows), reply to op 4 (the claimed row), optionally at login (assumption, needed for the HUD counter before the frame is opened).

## 5. Rules and formulas

- Claimable iff every non zero `CollectionN` item has `exchange_count >= 1` and the book is not claimed (`AMOD:46-83`). Server must re-check.
- One claim per book per player, forever.
- Fragments are not consumed by claiming.
- Book Type 2 rows (level rewards) are not shown here; see [collection.md](collection.md).

## 6. Templates

`raw/xml/tempinfos/ArchaeologyBookTemps.xml` (`ArchaeologyBookTemplateCate`, class `decompiled/core_module/scripts/yishi/datas/templates/ArchaeologyBookTemplate.as`), 63 rows:

| Field | Meaning |
|---|---|
| `Id` | book id (2..) |
| `Name` | picture name, e.g. "Muro de Impressão", "Tapete de Lã" |
| `Type` | 1 picture (59 rows), 2 level reward (4 rows) |
| `Collection1..3` | required archaeology item ids (0 = none); for Type 2 `Collection1` = level |
| `RewardId1..4`, `RewardCount1..4` | rewards; negative ids are currencies (-100 gold, -300 Espírito, -500 bound diamonds, -600 Cristal de Luz, -1400, -3000, -4000 other currencies, see [currency](../currency/README.md)); slot 4 unused |
| `RewardAppell` | title id (Type 2 only: 300..303) |
| `RewardFurnitureId`, `RewardFurnitureCount` | residence furniture (`furnitureTemplateCate`) |

## 7. Persistent state

```sql
CREATE TABLE archaeology.book_claim (
  player_id   BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  book_id     INTEGER     NOT NULL,
  claimed_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, book_id)
);
```

## 8. Backend implementation notes

- `archaeology::handbook::handle_list` (op 2): reply 296 with one `{tempId, getAlready: true}` per `book_claim` row.
- `archaeology::handbook::handle_claim` (op 4). Validation: book exists and `Type = 1` -> not in `book_claim` -> every required item has `exchange_count >= 1` in `archaeology.item_progress`. Transaction: insert `book_claim`, grant rewards and furniture. After commit push 296 (one row), 115, 3, furniture push.
- No timers, no battles.

## 9. Open questions and assumptions

- Whether 296 is also pushed at login (assumed, to feed the HUD badge).
- Furniture push opcode belongs to the residence feature.

## 10. Implementation checklist

- [ ] Screen: `ArchaeologyBookFrame` paging and states
- [ ] Screen: `ArchaeologyBookItem` requirements, rewards, furniture cell
- [ ] Route R1 op 2 -> 296
- [ ] Route R2 op 4 claim
- [ ] Server message 296 upsert semantics
- [ ] Table `archaeology.book_claim`
- [ ] Rule: completion check against `item_progress.exchange_count`
- [ ] Test: double claim refused
- [ ] Test: furniture and currency rewards delivered
