# Battle guard (Proteção de combate)

Path aliases:

| Alias | File |
|---|---|
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| BGV | `decompiled/m5/scripts/armyII/viewII/battleGuard/BattleGuardView.as` |
| BGI | `decompiled/m5/scripts/armyII/viewII/battleGuard/BattleGuardItemView.as` |
| BGB | `decompiled/m5/scripts/armyII/viewII/battleGuard/BattleGuardBagView.as` |
| INFO | `decompiled/core_module/scripts/yishi/datas/playerinfo/BattleGuardInfo.as` |
| AF | `decompiled/m5/scripts/armyII/ArmyFrameII.as` |

The protocol package is `watch` (`HeroWatchMsg`, `HeroWatchOpMsg`); features.json maps `watch` to the hero feature, but the screen lives in `armyII`, so the system is documented here.

## 1. Overview

The hero has 7 guard grids, each with 3 gem slots:
- 1 "Anti-resistência" grid (grid type 1, `battleWillPower`), accepting crystals with `Property1 == 100`; their `ReduceResi` sum is the hero's anti-resistance ("Pontos totais da Gema Anti-Resistência").
- 6 shield grids (grid type 2, positions 0..5: "escudo de madeira", "escudo de ferro", "escudo de cobre", "escudo de prata", "escudo de ouro", "escudo de diamante"), accepting crystals with `Property1` 101..106; their elemental resistances (`FireResi`, `WaterResi`, `WindResi`, `ElectResi`, `LightResi`, `DarkResi`) protect against the opponent Einherjar (pet) anti-resistance (`BattleGuardView.HelpContent`).

Grids are opened by hero level, some with an item ("Selo Imperial" 2100032) or diamonds.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.battleGuard.BattleGuardView` (BGV) | hero frame tab (`army.BattleGuardButton`); help text `BattleGuardView.HelpContent` | 7 grids, open grid, add/remove crystal, totals | `ArmyFrameII` tab, visible at hero level >= 50 (AF:238-241); click requires the Einherjar system open, else "Necessário abrir o Sistema de Einherjar" (`ArmyFrameII.needOpenPetSystem`, AF:871-882) | `thane.battleGuardInfo` (`playerInfo.battleGuardInfo`) |
| `BattleGuardItemView` (BGI) | | One grid; locked grey until hero level >= template `Grades` (BGI:129-174) | BGV | `UpGradeTempInfos` type 28 |
| `BattleGuardBagView` (BGB) | | Bag filtered to crystals (SonType 312) | BGV right side | bag items |

The attribute side panel (`_attributeView.switchPanel(2)`, AF:1070-1074) shows totals from `INFO.getAllPoint()`.

## 3. Routes (client to server)

All routes send 8742 (0x2226) `C_BATTLEGUARD_OP` with `HeroWatchOpMsg` (watch): `op_type` (#1, INT32), `grid_type` (#2, INT32) 1 anti-resistance / 2 shield, `grid_pos` (#3, INT32) grid index + 1, `jion_pos` (#4, INT32) slot index + 1, `item_pos` (#5, INT32) bag position, `bag_type` (#6, INT32), `pay_type` (#7, INT32).

### R1. Open a grid (`op_type 1`)
- UI: click a locked grid (`BGV.activeItem`, BGV:246-311).
- Client checks: template row of `UpGradeTempInfos` `Types 28` with `ActiveObject` = grid id (type 1 → 7; type 2 → pos + 1); hero level >= `Grades` else "Nível necessário {0}" (`BattleGuardView.needGrade`). Grid 7 and grids with no cost send immediately. Grid 6 ("escudo de diamante", `Data` 1000 diamonds): confirm "Deseja consumir <font color='#00ff00'>{0}</font> para abrir {1}?" with "Diamantes x{0}" and bound checkbox; requires >= 1000 (`allPoint` with bound, else `point`) else recharge (BGV:313-338). Grids 3..5 (`TemplateId` 2100032 "Selo Imperial") send without an item check (the item argument is null, BGV:307-309, BGV:340-365).
- Client path: `PM.sendOpenBattleItem(type, pos, payType)` (PM:1959-1968): `op_type 1`, `grid_type`, `grid_pos = pos + 1`, `pay_type` default 1; grid 6 sends 2 when bound diamonds are allowed, else 1.
- Response: 4631 (S1); the client switches the grid to state 1 and fires `OPEN_BATTLEGUARD_ITEM` (PM:1893-1897).

### R2. Insert a crystal (`op_type 2`)
- UI: double click a crystal (SonType 312) in the guard bag → first empty slot (BGV:506-549), or drag.
- Client checks (PM:1903-1946): grid type 1 needs `Property1 == 100`, grid type 2 needs `Property1` in 101..106, else "Tipo de acessório incorrespondente"; no duplicate template in the same grid else "Não pode inserir mais de um Cristal do mesmo tipo"; no free slot → "Não há buraco disponível".
- Request: `op_type 2`, `grid_type`, `grid_pos`, `item_pos` = bag position, `jion_pos` = slot + 1, `bag_type` = item bag.
- Response: 4631 with the grid's `jion1..3`; bag update for the removed item ([../inventory/README.md](../inventory/README.md)); hero stats push 113.

### R3. Remove a crystal (`op_type 3`)
- UI: remove button on a slot, confirm "Deseja retirar?" (`wanttoremove`, BGV:175-213).
- Client path: `PM.sendRemoveBattleGem(type, pos, slot)` (PM:1948-1957): `op_type 3`, `grid_type`, `grid_pos`, `jion_pos`.
- Response: 4631 and bag add.

## 4. Server messages (server to client)

### S1. 4631 (0x1217) `U_C_BATTLEGUARD_INFO`
- Message `HeroWatchMsg` (watch): `user_id` (#1, INT32); `watchInfo` (#2, `WatchInfoMsg`, repeated): `grid_type` (#1, INT32), `grid_pos` (#2, INT32, 1-based), `jion1` (#3, INT32), `jion2` (#4, INT32), `jion3` (#5, INT32) item template ids (0 = empty), `jion4` (#6, INT32) unused.
- Receiver: `PM.__battleguardInfoHandler` (PM:1874-1901): every listed grid is opened (state 1) and its 3 slots set; stored in `playerInfo.battleGuardInfo`.
- When: at login (all opened grids) and after each 8742.

## 5. Rules and formulas

- `UpGradeTempInfos` `Types 28` (grid unlock): `ActiveObject` 1 (wood, level 55), 2 (iron, 60), 3 (copper, 65, "Selo Imperial"), 4 (silver, 70, "Selo Imperial"), 5 (gold, 75, "Selo Imperial"), 6 (diamond, 80, 1000 diamonds), 7 (anti-resistance, 55, `Data` 300). `INFO.OPEN_GRADE` = 55.
- Anti-resistance points = sum of `ReduceResi` of crystals in the type 1 grid (INFO:51-64). Shield totals per element = sums over the 6 grids (INFO:66-100).
- One crystal template per grid. Crystals are items SonType 312.
- Battle effect (help text): protection reduces damage from the opponent's anti-resistance; if anti-resistance is below protection, damage is weaker; above it, full damage plus extra. Implement in the battle engine ([../battle/README.md](../battle/README.md)).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `UpGradeTempInfos.xml` | `Types 28` | `ActiveObject` (grid id), `Grades` (hero level), `TemplateId` (item cost), `Data` (diamonds) |
| `ItemTempInfos.xml` | crystals (SonType 312), "Selo Imperial" 2100032 | `Property1` (100 / 101..106), `ReduceResi`, `FireResi`, `WaterResi`, `WindResi`, `ElectResi`, `LightResi`, `DarkResi` |

## 7. Persistent state

```sql
CREATE TABLE army.battle_guard_grids (
    player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    grid_type    SMALLINT NOT NULL CHECK (grid_type IN (1, 2)),
    grid_pos     SMALLINT NOT NULL CHECK (grid_pos BETWEEN 1 AND 6),
    slot1_template_id INTEGER NOT NULL DEFAULT 0,
    slot2_template_id INTEGER NOT NULL DEFAULT 0,
    slot3_template_id INTEGER NOT NULL DEFAULT 0,
    opened_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, grid_type, grid_pos),
    CHECK (grid_type = 2 OR grid_pos = 1)
);
```

Crystals in slots are consumed from the bag and stored as template ids *(assumption: the client only receives template ids, so the item loses its instance identity while socketed)*.

## 8. Backend implementation notes

- `army::battle_guard::handle_op` (8742) dispatch:
  - `handle_open_grid` (1): grid not opened; hero level >= `Grades`; Einherjar system open *(assumption: server mirrors the client gate)*; charge `Data` diamonds (pay type 2 = bound first) or 1 x `TemplateId` item; insert row; push 4631.
  - `handle_insert_crystal` (2): grid opened; item at `bag_type`/`item_pos` is SonType 312 with matching `Property1`; slot empty; no same template in grid; remove 1 from bag; set slot; push 4631, bag update, 113.
  - `handle_remove_crystal` (3): slot filled; bag has space; add item back; clear slot; push 4631, bag, 113.
- Battle configuration: hero `reduce_resi` (anti-resistance) and elemental resistances include these totals (`SimpleHeroInfoMsg` #61..#67).

## 9. Open questions and assumptions

- Assumption: "Selo Imperial" is consumed for grids 3..5 although the client skips the check (the item description says it was used to open the slot).
- Assumption: removed crystals return as new bag items with the same template.
- Open: `jion4` and grid 7 `Data` 300 meaning (not used by the client).

## 10. Implementation checklist

- [ ] Screen: BattleGuardView, BattleGuardBagView
- [ ] Route 8742 op 1 open grid
- [ ] Route 8742 op 2 insert crystal
- [ ] Route 8742 op 3 remove crystal
- [ ] Server message 4631 at login and after ops
- [ ] Table `army.battle_guard_grids`
- [ ] Rule: `Types 28` unlocks and costs
- [ ] Rule: crystal type per grid, no duplicates
- [ ] Test: totals in 113 resistances and battle damage reduction
