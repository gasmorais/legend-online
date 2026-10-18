# Mines: production, harvest, speed-up, unlock and upgrade

Module `mines` of feature `alchemy`. Covers the "Exploração" tab: six mines that produce ores over time, harvesting them into the alchemy storage (op 1), the diamond speed-up (op 5) and the score driven unlock and upgrade of each mine (push op 6).

Path aliases:

| Alias | File |
|---|---|
| AM | `decompiled/core_module/scripts/yishi/manager/AlchemicalManager.as` |
| AMOD | `decompiled/core_module/scripts/mvc/module/alchemical/AlchemicalModel.as` |
| AMI | `decompiled/core_module/scripts/mvc/module/alchemical/AlchemicalMineInfo.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| V | `decompiled/m14/scripts/alchemical/` |

## 1. Overview

| Pos | Name | Grades (Id: NeedScore, Speed s/ore, MaxCount) | Ores |
|---|---|---|---|
| 1 | Minas de Einherjar | 101: 0, 90, 240; 102: 980, 90, 240; 103: 6260, 70, 410; 104: 61290, 70, 410 | 702101..702104 "Pedra Original Roxa ..." |
| 2 | Minas de Romã | 201: 0; 202: 980; 203: 6260; 204: 61290 (same speeds/caps) | 702201..702204 "Minério de Romã ..." |
| 3 | Benitoíta | 301: 25740; 302: 32370; 303: 105470; 304: 153390 | 702301..702304 "Minério Azul ..." |
| 4 | Corindon | 401: 25740; 402: 32370; 403: 105470; 404: 153390 | 702401..702404 "Jade Vermelho ..." |
| 5 | Mina de Metal | 501: 114810; 502: 127670; 503: 216490; 504: 230300 | 702501..702504 "Minério de Ferro ..." |
| 6 | Mina de Ouro | 601: 114810; 602: 127670; 603: 216490; 604: 230300 | 702601..702604 "Minério de Ouro ..." |

Every grade 1 and 2 has `Speed` 90 and `MaxCount` 240; grades 3 and 4 have `Speed` 70 and `MaxCount` 410 (`raw/xml/tempinfos/AlchemyMineTemplates.xml`). The ore of each mine position follows the id pattern `702 p qq` (p = `Pos`, qq = 01 cracked/common Profile 1, 02 common Profile 2, 03 bright Profile 3, 04 isomer Profile 4). The Types 139 texts say grade 2 gives blue quality materials, grade 3 more speed and storage, grade 4 purple quality materials.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/AlchemicalExploitView.as` | "Nº de adição de velocidade diário:{0}/{1}" | 6 mine items in a 3x2 grid; speed-ups left | Frame tab 0 | `max(0, speedMaxCount - hasSpeedCount)` / `speedMaxCount` (`:81-94`); each item uses the unlocked mine of `Pos` i+1, else the grade 1 template (grey) (`:45-62,88-93`) |
| `V/AlchemicalMineItem.as` | tip: "{Name}\nPontos necessários:{0}" (locked) or "{Name}\nVelocidade de abertura:{0} por seg\nArmazenamento:{1}/{2}" (unlocked) | mine animation `{RES}icon/alchemical/{Icon}`, harvest button, speed-up button on roll over | ExploitView | `curCount`, `MaxCount`, `Speed`, `NeedScore` (`:146-168,192-204`) |

Buttons:
- Harvest ("colher", `getRewardBtn`): visible when the mine is unlocked and `curCount > 0`, refreshed every second (`V/AlchemicalMineItem.as:192-204`).
- Speed-up (`speedBtn`): visible on roll over when the mine is unlocked, speed-ups left > 0 and `curCount < MaxCount` (`:130-134`).

## 3. Routes (client to server)

### C1. Harvest a mine (op 1 REAP)
- UI: harvest button on `AlchemicalMineItem` (`V/AlchemicalMineItem.as:121-128`).
- Client checks: mine unlocked (`_data` present); button only visible with `curCount > 0`.
- Sender: `AM.sendAlchemicalMineRequest(1, mineId)` (`AM:184-191`).
- Route: C>S 9661 (0x25bd) `C_ALCHEMY_WORKSHOP_OP`, `AlchemyWorkshopMsg`: `op (#1, ENUM)` = 1; `mineId (#3, INT32)` mine template id.
- Response: 461 `op` 1, `opResult` 0, `mine` = [the mine with the new `startTime`], `alchemyItem` = changed ore entries (absolute counts), plus `score` when harvesting grants points (assumption, see section 9).

### C2. Speed up a mine (op 5 SPEED_UP)
- UI: speed-up button (`V/AlchemicalMineItem.as:86-98`).
- Client checks: confirmation "Consumindo {0} diamantes irá completar abertura, obtendo muitos materiais destes" with `speedUpCost`; on confirm `playerInfo.point >= cost` (real diamonds only) else recharge alert (`:100-114`).
- Cost formula (`V/AlchemicalMineItem.as:206-215`): `remaining = startTime + MaxCount * Speed - now` (seconds); `cost = ceil(remaining / (60 * X)) * N` with `alchemyworkshop_speed_up_cost` = "N,X" = "5,2" (5 diamonds per started 2 minutes).
- Sender: `AM.sendAlchemicalMineRequest(5, mineId)` (`AM:184-191`).
- Route: 9661, `op` = 5, `mineId (#3)`; `payType (#8)` not set (0).
- Response: 461 `op` 5, `opResult` 0 (4 LACK_POINT when diamonds are short), `speedTimes` (incremented), `mine` = [mine with `startTime = now - MaxCount * Speed`]; diamond balance push (currency).

## 4. Server messages (server to client)

### S1. 461 `U_C_ALCHEMY_WORKSHOP_OP` (see [core.md](core.md) S1)
Fields used by this module: `speedTimes (#9)`, `mine (#12)` (`MineMsg.mineId #1`, `MineMsg.startTime #2`), `alchemyItem (#14)`, `score (#10)`.

Receiver `AM:82-102`: for each `MineMsg` the client looks up the template, places it by `Pos`, parses `startTime` (`YYYY-MM-DD hh:mm:ss`) and notifies `ALCHEMICAL_MINE_UPDATE`, which re-renders the six items (`V/AlchemicalExploitView.as:64-94`).

### S2. 461 push `op` 6 UPDATE_MINE
When: a score change unlocks a new position or reaches the next grade `NeedScore` of an unlocked mine (normally inside the formula responses, so the push is only needed if the change happens elsewhere). Content: `op` 6, `mine` with the new template id per changed position and its `startTime`. Optionally `score`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Stored ores | `curCount = min(MaxCount, floor((now - startTime) / Speed))`, 0 when `now <= startTime` | `AMI:27-39` |
| Harvest | grant `curCount` ores of the mine position, then `startTime = now` (assumption: keep the remainder, `startTime += curCount * Speed` when not full, to avoid losing partial progress; the client only needs a consistent value) | `AMI:27-39` |
| Ore distribution | not in client data; per grade quality hint from Types 139 texts (grade 1: Profile 1 mostly, grade 2: adds Profile 2 "azul", grade 4: adds Profile 3 "roxa"; Profile 4 isomers rare). Needs a server table | assumption |
| Speed-up cost | `ceil((startTime + MaxCount*Speed - now) / 120) * 5` diamonds (real diamonds) | `V/AlchemicalMineItem.as:206-215`, `alchemyworkshop_speed_up_cost` |
| Speed-up effect | mine becomes full: `startTime = now - MaxCount * Speed` ("irá completar abertura") | `AlchemicalMineItem.speedItem.alert` |
| Speed-up limit | 5 per day; not allowed when the mine is full | `alchemyworkshop_max_speedup_times`, `V/AlchemicalMineItem.as:130-134` |
| Unlock | position p is unlocked when `score >= NeedScore` of its grade 1 row (positions 1, 2 at 0) | `AlchemyMineTemplates.xml`, `AlchemicalMineItem.open.needScore` |
| Upgrade | the active grade of position p is the highest grade with `score >= NeedScore`; upgrading keeps `startTime` (assumption) so the stored count grows with the new `MaxCount` | `AlchemyMineTemplates.xml` |
| Storage cap | 999 per ore template (`MaxCount` in ItemTempInfos) | assumption: excess is lost |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `AlchemyMineTemplates.xml` | `AlchemyMineTemplate` (24 rows) | `Id` (= `mineId`), `Pos` 1..6, `Grade` 1..4, `Speed` seconds per ore, `MaxCount` storage cap, `Icon` animation swf (frames `cold` and `harvest` position the buttons), `Name`, `NeedScore` |
| `ConfigInfos.xml` | `alchemyworkshop_speed_up_cost` "5,2", `alchemyworkshop_max_speedup_times` 5 | |
| `ItemTempInfos.xml` | ores 702101..702604 | names in tips |

Assets: `raw/icon/alchemical/<Icon>` exist on disk.

## 7. Persistent state

```sql
CREATE TABLE alchemy.mines (
  player_id         BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pos               SMALLINT NOT NULL CHECK (pos BETWEEN 1 AND 6),
  mine_template_id  INTEGER NOT NULL,                  -- AlchemyMineTemplate.Id of the current grade
  started_at        TIMESTAMPTZ NOT NULL,              -- production start (MineMsg.startTime)
  PRIMARY KEY (player_id, pos)
);
```

`speedup_count` lives in `alchemy.workshop_state` ([core.md](core.md)). Ores go to `alchemy.storage_items`.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9661 `op` 1 | `alchemy::mines::handle_reap` |
| 9661 `op` 5 | `alchemy::mines::handle_speed_up` |
| (internal) | `alchemy::mines::sync_unlocks(player, score)` |

- `handle_reap`: workshop state exists -> mine row for the template's `Pos` exists and `mine_template_id == mineId` -> compute `curCount` with server time -> `curCount > 0` else `opResult` 1 -> roll each ore (distribution table per mine grade) -> clamp storage at 999 -> update `started_at` -> one transaction -> 461 `op` 1.
- `handle_speed_up`: daily reset -> `speedup_count < 5` else `opResult` 1 -> mine unlocked and not full -> `cost` with the formula above (server time) -> deduct real diamonds through the currency service (`opResult` 4 when short) -> `started_at = now - MaxCount*Speed`, `speedup_count += 1` -> one transaction -> 461 `op` 5 with `speedTimes` and `mine` -> diamond balance push.
- `sync_unlocks`: called by `alchemy::core::add_score`; for each position compute the target grade; insert missing rows (`started_at = now`) or update `mine_template_id`; return the changed `MineMsg` list for the response.
- Time strings: format `started_at` in server local time `YYYY-MM-DD HH:MM:SS`, the same clock the client uses for `sysCurTimeBySecond`.
- No timers: production is computed from timestamps.

## 9. Open questions and assumptions

- Open: ore drop distribution per mine grade (Profile 1..4 shares). The client only shows counts.
- Open: whether harvesting grants Alchemy Points (item 700000 description says points come from "abrir minérios" or alchemy). Default: no points on harvest.
- Assumption: harvest keeps the partial production remainder.
- Assumption: speed-up refuses a full mine and does not stack beyond `MaxCount`.
- Assumption: `payType` is ignored; only real diamonds are accepted (client checks `point`).

## 10. Implementation checklist

- [ ] Screens (client ready): `AlchemicalExploitView`, `AlchemicalMineItem`.
- [ ] Table `alchemy.mines`; initial rows for positions 1 and 2.
- [ ] Route 9661 op 1 harvest with ore distribution and storage cap.
- [ ] Route 9661 op 5 speed-up with cost formula, daily limit and diamond deduction.
- [ ] Push 461 op 6 on unlock/upgrade (or include `mine` in the response that changed the score).
- [ ] Ore distribution table per grade (server config).
- [ ] Tests: `curCount` after 90 s is 1 at grade 1; capped at 240; harvest resets the counter; speed-up at 0 stored costs `ceil(21600/120)*5 = 900` diamonds at grade 1; 6th speed-up of the day refused; score 25740 unlocks positions 3 and 4; score 61290 upgrades positions 1 and 2 to grade 4.
