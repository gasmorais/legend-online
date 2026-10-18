# Fashion refining (Refinação de moda)

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/managers/FashionManager.as` |
| FRV | `decompiled/m14/scripts/fashion/FashionRefreshView.as` |
| FRI | `decompiled/m14/scripts/fashion/FashionRefreshItem.as` |
| FRA | `decompiled/m14/scripts/fashion/FashionRefreshAttributeView.as` |
| FSF | `decompiled/m14/scripts/fashion/FashionStoreFrame.as` |

## 1. Overview

Each fashion slot (SonType 109 wing, 110 hat, 111 weapon, 112 cloth) has a refining level and EXP. Feeding "Pedra de Refinação de Moda" (2131521) raises it. Per the UI note (`fashion.refreshView.tips24`): every refining level adds 10% to the slot's fashion attributes, and every 10 levels can add up to 10% to the appraisal attributes of the pieces, provided the book owns enough pieces of that slot (`NeedCount`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `fashion.FashionRefreshView` (FRV) | "Atributos da Moda" (`fashion.FashionStoreFrame.showRefreshView.text`) | 4 slot items, material amount input, refine button | `FashionStoreFrame` tab 2, enabled when fashion level > 0 (FSF:321) | `FashionModel.polishList`, material count |
| `fashion.FashionRefreshItem` (FRI) | "Nv.{0}" | One slot with level | FRV | `PolishInfoMsg` |
| `fashion.FashionRefreshAttributeView` (FRA) | "Refinação:", "Nº de modas necessários:", "Poder: {0}{1}", "Armadura: {0}{1}", "Inteligência: {0}{1}", "Físico: {0}{1}", "↑{0}%" | Attribute preview, milestone requirement | FRV | template rows, book counts per slot |

## 3. Routes (client to server)

All routes: send 9635 (0x25a3) `C_FASHION_POLISH_OP`, `FashionPolishRequestMsg` (fashion): `op` (#1, INT32), `sontype` (#2, INT32), `count` (#3, INT32) (FM:58-66).

### R1. Query (`op 1`)
- When: `FM.setup()` sends `op 1, sontype 1, count 0` (FM:44-50).
- Response: 408 (S1).

### R2. Refine (`op 2`)
- UI: refine button (FRV:189-206). Checks: a slot selected; the book has a piece of that slot, else "Ainda não obteve a moda deste local, não é possível refinar!" (`fashion.refreshView.tips23`); amount clamped to 1..min(owned, 9999) (FRV:208-235).
- Request: `op 2`, `sontype` = slot SonType, `count` = material units.
- Response: 408 with the updated slot; bag update for 2131521; 113 for stats.

## 4. Server messages (server to client)

### S1. 408 (0x0198) `U_C_FASHION_POLISH_LIST`
- `FashionPolishMsg` (fashion): `polishs` (#1, `PolishInfoMsg`, repeated): `sontype` (#1, INT32), `level` (#2, INT32), `exp` (#3, INT32).
- Receiver: `FM.__receivedPolishHandler` (FM:120-142) → `polishList`, event `FASHION_REFRESH_RECEIVE`.
- When: response to both ops; send all four slots each time.

## 5. Rules and formulas

- `FashionPolishs.xml` rows per (`SonType`, `Level` 0..100): `Exp` to reach the level (wing: level 1 = 25, 2 = 50, 10 = 250, 11 = 375, 100 = 25000), `LevelAdd` (cumulative attribute %, 10 per level), `SpAdd`, `AppraisalAdd` (appraisal attribute % at milestones, 10 at level 10 ... 100 at level 100), `NeedCount` (book pieces of that slot required to activate the milestone: 5 at level 10, 50 at level 100), `OtherLevel` (requirement on other slots, e.g. 10 at level 11) *(assumption on `OtherLevel` and `SpAdd` meaning)*.
- Milestone shown = highest `10 * k` (or 1) whose `NeedCount` <= owned pieces of that slot (FRA:100-140); appraisal bonus = `floor(AppraisalAdd / 100 * appraised attribute)` (FRA:208-246).
- 1 material = 1 EXP *(assumption)*.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `FashionPolishs.xml` | 404 rows (4 slots x 101 levels) | `SonType`, `Level`, `Exp`, `OtherLevel`, `LevelAdd`, `SpAdd`, `AppraisalAdd`, `NeedCount` |
| `ItemTempInfos.xml` | 2131521 "Pedra de Refinação de Moda" (SonType 210) | material (`FashionRefreshData.refreshTemplateId`, `decompiled/core_module/scripts/mvc/module/fashion/FashionRefreshData.as:6`) |

## 7. Persistent state

```sql
CREATE TABLE fashion.polish_levels (
    player_id   BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    son_type    SMALLINT NOT NULL CHECK (son_type IN (109, 110, 111, 112)),
    level       SMALLINT NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 100),
    exp         INTEGER  NOT NULL DEFAULT 0 CHECK (exp >= 0),
    PRIMARY KEY (player_id, son_type)
);
```

## 8. Backend implementation notes

- `fashion::polish::handle_op` (9635): op 1 → reply 408 with 4 rows; op 2 → validate SonType, owned piece in the book, fashion level > 0, `count` <= owned 2131521 (bound first); add EXP, level up through the table respecting `OtherLevel`; consume; reply 408; push 113.

## 9. Open questions and assumptions

- Assumption: 1 material gives 1 EXP; `OtherLevel` gates the next level on the other slots' levels.
- Open: role of `SpAdd`.

## 10. Implementation checklist

- [ ] Screens: FashionRefreshView, FashionRefreshItem, FashionRefreshAttributeView
- [ ] Route 9635 op 1
- [ ] Route 9635 op 2
- [ ] Server message 408
- [ ] Table `fashion.polish_levels`
- [ ] Rule: EXP table, milestones with `NeedCount`, attribute bonuses
- [ ] Test: refine wing to level 10 with 5 wings owned shows "↑10%"
