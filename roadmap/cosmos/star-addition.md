# Star slot refinement ("Refinação do Cosmo")

Module `star-addition` of feature `cosmos`. Each of the 10 equip slots ("star trough") has its own level 0..10. Refining a normal slot (0..7) raises it; the slot level adds +level% to the attributes of the star equipped in it and raises star power. Slots 8 and 9 (advanced) exist in the data but cannot be refined from the client.

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/yishi/manager/StarManager.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/star/StarModel.as` |
| STI | `decompiled/core_module/scripts/mvc/module/star/StarTroughInfo.as` |
| SBC | `decompiled/core_module/scripts/cell/view/starbag/StarBagCell.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StarController.as` |
| V | `decompiled/m5/scripts/star/` |
| SPI | `decompiled/core_module/scripts/yishi/datas/playerinfo/SimplePlayerInfo.as` |

## 1. Overview

| Item | Value |
|---|---|
| Trough record | `StarTroughInfo`: `userId`, `type` (0 normal for pos 0..7, 1 advanced for pos 8..9), `pos` 0..9, `grade` 0..10, `gp` progress, `isFirstOpen` (client only glow flag) (`STI:10-85`, defaults `SMOD:40-61`) |
| Refinable slots | pos 0..7 with `pos < vocationLevel` (`vocationLevel = floor((vocationGrades - 1) / 10) + 1`, 0 without job advance, `SPI:1279-1299`) |
| Effect | "Efeito do Cosmo +{0}%" with `{0}` = trough grade (`SBC:858-862`) |
| Currency | gold; the frame shows a fixed cost label "1000000" (`V/EnhancedAttributeFrame.as:123`) |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/EnhancedAttributeFrame.as` | "Refinação do Cosmo" (`:83`) | refine one slot once or ten times | "+" button of an equip slot (`SBC.__addBtnHandler`, `SBC:343-347`) -> controller `star` openType 2 (`SC:36-39`) with `StarController._info = troughInfo` | current "Nv.{n}", next level, effect frames, progress `gp / Data` of `UpGradeTempInfos` type 103 row `grade + 1`; at grade 10 shows max and disables buttons (`:155-183`); button tips "Consumir ouro para refinar 1 vez", "Consumir 10x do ouro para refinar 10 vezes" (`:134-135`) |
| `SBC` slot buttons | tip "Nv.{n}:Efeito do Cosmo +{n}%" | "+" (`_addBtn`) when refinable and grade < 10; "max" (`_maxBtn`, `_tipBtn`) at grade 10 | `EquipStarListView` | visibility rules `SBC:731-763,894-961`; `btnState = pos < vocationLevel` set by `V/view/EquipStarListView.as:87-97,159-169` |

## 3. Routes (client to server)

### A1. Refine once / ten times
- UI: `_addAttributeBtn` (x1) and `_addManyAttributeBtn` (x10) (`V/EnhancedAttributeFrame.as:193-203`). Both buttons are disabled on click until the next 4677 refresh re-enables them (`:176-177`).
- Client checks: only that the frame is open on a slot with grade < 10. No gold check on the client.
- Sender: `SM.sendStarAddition(pos, times)` (`SM:514-521`).
- Route: C>S 8772 (0x2244) `C_STAR_ADDITION`, `AdditionInfoMsg`: `userId (#1, INT32)` not set; `type (#2, INT32)` number of refinements, 1 or 10; `pos (#3, INT32)` trough position 0..7; `grade (#4, INT32)` not set; `curGp (#5, INT32)` not set.
- Response: 4677 with the updated trough, gold update 109. When gold is insufficient the server must still answer 4677 with the unchanged trough so the buttons re-enable (assumption).

## 4. Server messages (server to client)

### S1. 4677 (0x1245) `U_C_STAR_ADDITION`, `StarAdditionMsg`
Receiver `SM._starTroughInfoHandler` (`SM:300-332`, listener `SM:89`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `additions` | #1 | `AdditionInfoMsg` | yes | trough rows |

`AdditionInfoMsg` (server form): `userId (#1, INT32)` owner; `type (#2, INT32)` trough type 0 normal / 1 advanced; `pos (#3, INT32)` 0..9; `grade (#4, INT32)` 0..10; `curGp (#5, INT32)` progress toward `grade + 1`.

Client reaction: replaces the trough with the same `pos` or appends it, then fires `REFRESH_STARTROUGHINFO`, which refreshes the equip slots (`V/view/EquipStarListView.as:146-215`), star power (`V/HoroscopeFrame.as:153-156`) and the refinement frame (`V/EnhancedAttributeFrame.as:155-183`). Note: replacement creates a new object, so the client side `isFirstOpen` glow flag of slot 8 set by task 1802 (`decompiled/core_module/scripts/yishi/manager/TaskManage.as:270-280`) is lost on the next push; harmless.

When: login (all 10 troughs), after A1.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Max grade | 10 | `V/EnhancedAttributeFrame.as:161` |
| Progress per level | `UpGradeTempInfos` type 103, row `Grades = grade + 1`, `Data` = progress needed: 10, 16, 54, 128, 250, 432, 686, 1024, 1458, 2000 for grades 1..10 | `V/EnhancedAttributeFrame.as:158-181` |
| Progress per refinement | not in client data; assumption: +1 `gp` per refinement (so x10 = 10 refinements), carry over into the next level, stop at grade 10 without charging the rest |
| Cost per refinement | assumption: 1,000,000 gold, matching the static label (`V/EnhancedAttributeFrame.as:123`) and tip "Consumir 10x do ouro para refinar 10 vezes"; make it server config |
| Eligibility | `pos <= 7`, `pos < vocationLevel`, slot unlocked by hero level (`pos < floor(level / 10)`) | `SBC:736`, `V/view/EquipStarListView.as:85-98` |
| Effect | equipped star stat X: `X * grade + int(X * grade * troughGrade * 0.01)` | `decompiled/core_module/scripts/yishi/view/tips/goods/StarTip.as:96-124` |
| Star power | `* (1 + avg(grade of troughs 0..7) / 100)` | `SMOD:83-108` |

## 6. Templates

| File | Fields used |
|---|---|
| `UpGradeTempInfos.xml` | `Types = 103`, `Grades` 1..10, `Data` |

## 7. Persistent state

```sql
CREATE TABLE cosmos.star_troughs (
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pos          SMALLINT NOT NULL CHECK (pos BETWEEN 0 AND 9),
  trough_type  SMALLINT NOT NULL CHECK (trough_type IN (0, 1)),   -- 0 for pos 0..7, 1 for 8..9
  grade        SMALLINT NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 10),
  gp           INTEGER  NOT NULL DEFAULT 0 CHECK (gp >= 0),
  PRIMARY KEY (player_id, pos)
);
```

Rows can be created lazily; the login push must still contain all 10 positions.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8772 | `cosmos::star_addition::handle_refine` |

- Validation order: `pos` in 0..7 -> slot unlocked by level -> `pos < vocationLevel` -> grade < 10 -> `type` in {1, 10} -> compute how many refinements are needed (stop at max) -> gold >= cost * n -> one transaction (deduct gold, update `gp`/`grade`) -> push 4677 then 109 -> recompute hero stats if a star is equipped in that slot.
- No timers, no battle.

## 9. Open questions and assumptions

- Assumption: gold cost per refinement (1,000,000) and progress gain per refinement (+1); no template or language string gives them.
- Assumption: refinement may be random (critical gains) in the original server; implement deterministic +1 unless evidence appears.
- Advanced troughs 8 and 9 have `type = 1` and grade 0 forever from the client point of view.

## 10. Implementation checklist

- [ ] Screen (client ready): `EnhancedAttributeFrame`, slot "+"/max buttons.
- [ ] Table `cosmos.star_troughs`.
- [ ] Login push 4677 with 10 troughs.
- [ ] Route 8772 x1 and x10, eligibility (`vocationLevel`), max grade, gold.
- [ ] Always answer 4677 so buttons re-enable.
- [ ] Effect in hero stats and star power.
- [ ] Tests: refine slot >= vocationLevel rejected; x10 near max charges only needed refinements; grade 10 rejects; level up at Data thresholds.
