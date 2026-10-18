# Smith: Fortalecimento (equipment and treasure strengthen)

Path aliases:

| Alias | File |
|---|---|
| IV | `decompiled/m14/scripts/store/Intensify/IntensifyView.as` |
| TIV | `decompiled/m14/scripts/store/treasure/TreasureIntensifyView.as` |
| TSB | `decompiled/m14/scripts/store/treasure/TreasureStoreBag.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StoreControler.as` |
| SSOM | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| SH | `decompiled/core_module/scripts/yishi/utils/StoreHelper.as` |
| GC | `decompiled/core_module/scripts/bag/helper/GoodsCheck.as` |
| GH | `decompiled/core_module/scripts/yishi/utils/GoodsHelp.as` |
| CLK | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellClickMediator.as` |
| DRP | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellDropMediator.as` |
| GTI | `decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as` |

## 1. Overview

Two sub tabs of the smith "store" view ([store-frame.md](./store-frame.md)):
- Equipment strengthen (`STORE_PANEL_INTENSIFY`): the equipment in workspace slot 0 gains +1 strengthen grade on success, up to the template `StrengthenMax`. Costs gold; an optional luck / strengthen stone (SonType 204) in slot 1 adds success rate and is consumed. Failure keeps the grade (no downgrade). Dragon equipment (template `Job = "99"`) uses a bless value instead of luck stones. Help: "O sistema de fortalecimento pode aumentar os atributos básicos dos equipamentos" (`store.StoreControler.helpContent01`), including "Se o reforço falhar, o nível do equipamento não muda" and "O fortalecimento fará com que o equipamento não vinculado seja vinculado".
- Treasure strengthen (`STORE_PANEL_TREASURE_INTENSIFY`): a treasure (MasterType 11, outer SonType 750 or inner 751) in slot 0 gains +1 level, consuming stones defined per level in `TheseusTreasureGrowupTemplates.xml`. Visible only when the player has a royalty level (> 0).

Enchant (`EnchantView`) is not strengthen-like (it applies a life skill to the equipment); see [enchant.md](./enchant.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `IV` `store.IntensifyView` | sub tab strengthen; button `store.StrengthenBtn` | Main cell `StoreIntensifyCell1` (slot 0, `sonType = -1`), material cell `StoreIntensifyCell2` (slot 1, `sonType = 204`) (`IV:160-186`) | `StoreView1` tab 0 (default) | Equipment name + "+grade" colored by Profile (`IV:718-719,860-863`); needed gold and success rate, or "max" bitmap when `strengthenGrade == StrengthenMax` (`IV:674-749`); preview of the max grade item (`IV:560-568`); on button hover, the next grade attribute gains (`IV:393-396,658-672,790-858`); for dragon equipment the bless bar "Pontos de Bênção" with value "x / 100" and tip "Quanto maiores forem os pontos de benção maior será a probabilidade de suceder no molde divino." (`IV:177-182,695-701,763-773`) |
| `TIV` `store.treasure.TreasureIntensifyView` | sub tab treasure strengthen | Main cell `StoreIntensifyCell.treasure` (slot 0), read only stone cell `StoreIntensifyCell3` (`TIV:126-148`), own `TreasureStoreBag` | `StoreView1` tab 4 | Stone count "owned/needed" red when insufficient (`TIV:447-524`); current and next level item previews and per attribute values from the growup template (`TIV:502-588`) |
| Confirm `store.ComposeTipFrameIsStrengthen` (TodayNotAlertFrame) | "Probabilidade de fortalecimento baixo, deseja fortalecer diretamente?" (`store.Intensify.IntensifyView.isStrengthen`) with "do not show today" check | Low success confirmation | `IV:421-443` | |

## 3. Routes (client to server)

Placing items: [store-frame.md](./store-frame.md) R1/R2 (5005 into bag 0). Strengthen specific placement checks:
- Slot 1 accepts only SonType 204 and slot 0 only MasterType 1 or 11 (`DRP:351-423`, `decompiled/core_module/scripts/cell/mediator/storebag/IntensifyBagCellDropMediator.as:139-155`).
- Stone compatibility with the equipment in slot 0 (`CLK:174-212`, `DRP:354-392`): if the equipment has `NeedChangeJob == 2`: at `strengthenGrade >= 36` the stone needs `Property2 == 1` (Pedra de Fortalecimento 2350001..2350009), below 36 it needs `Property2 == 0` (Gema da Sorte 2040101..2040109); for other equipment the stone needs `Property2 == 0`. Violation: "Tipo de acessório incorrespondente".
- While `model.isViceIntensifing` no stone can be placed (`CLK:176-181`).
- When the slot 0 item changes template, or crosses grade 36 for `NeedChangeJob == 2`, the client automatically returns the stone in slot 1 to bag 1 with 5005 (`IV:528-565`).

### R1. Strengthen equipment
- UI: `store.StrengthenBtn` in `IV` (`IV:406-448`).
- Client checks, in order:
  1. Button enabled only with an item in slot 0 below `StrengthenMax` and not animating (`IV:674-749`).
  2. If the item is not dragon equipment and `StoreHelper.getSuccessRate(item, stone) <= 50`: confirm frame unless the player ticked "do not show today" (`SharedManager` keys `IS_STRENGTHEN`, `STRENGTHEN_CHECK_DATE`, `IV:421-443,479-484`).
  3. Gold `< needed gold` -> "Ouro Insuficiente" (`public.gold`, `IV:450-459`).
  4. Sets `model.isIntensifing = true` (blocks bag interaction until the animation ends, `IV:474`, `IV:291-296`).
- Sender: `StoreControler.sendItemIntensify()` (`SC:512-515`) -> `SSOM.sendItemIntensify(0)` (`SSOM:60-66`).
- Route: client to server, 5150 (0x141e) `U_C_ITEM_STRENGTHEN`, `store.StoreReqMsg`:
  - `src_itemid` (#9, INT32) = 0 (the server uses workspace slot 0).
  - `opType` (#13, INT32) = unset (0, normal strengthen).
  - All other fields unset: `hole_pos` (#1), `operate` (#2), `bag_type` (#3), `bag_pos` (#4), `mount_pos` (#5), `compose_id` (#6), `compose_num` (#7), `auto_buy` (#8), `des_itemid` (#10), `count` (#11), `pay_type` (#12).
- Expected response, in order: 115 `U_C_BAG_MOVE_UPDATE` (slot 0 item with new `strengthen_grade` / `str_bless_value` / `bind`, slot 1 stone consumed), 86 `U_C_ITEM_STRENGTHEN` (S1), 109 gold update, 3 when the hero attributes change.

### R2. One key strengthen (no caller)
- Sender exists: `SSOM.sendOneKeyIntensify(itemId)` (`SSOM:68-75`), never called in this build.
- Route: 5150 with `src_itemid` (#9) = item id and `opType` (#13) = 1.
- Assumption: repeats R1 until success, max grade or gold exhausted, then sends one 86. Optional; implement only if a UI is added.

### R3. Strengthen treasure
- UI: `TIV` strengthen button, enabled when slot 0 holds a treasure below `StrengthenMax` and the owned count of `StrengthenItem` (player bag + stone bag) >= `StrengthenItemNum` of the current level row (`TIV:447-493`).
- Client checks: none beyond the enable rule; no gold check.
- Sender: `TIV.strengthen` (`TIV:336-343`) -> `SSOM.sendTreasureIntensify()` (`SSOM:77-83`).
- Route: 5150 (0x141e) `U_C_ITEM_STRENGTHEN`, `StoreReqMsg` with only `opType` (#13, INT32) = 3; the server uses workspace slot 0.
- Expected response: 115 (treasure level up in slot 0, stones consumed), 86 (S1), 3 when the treasure is worn.

## 4. Server messages (server to client)

### S1. 86 (0x0056) `U_C_ITEM_STRENGTHEN`
- Message `store.StoreRspMsg`:
  - `compose_result` (#1, BOOL): unused here.
  - `compose_templateId` (#2, INT32): unused here.
  - `streng_result` (#3, BOOL): true success, false failure.
  - `strengthenGrade` (#4, INT32): new grade (or level for treasures).
  - `pos` (#5, INT32): workspace slot of the item (0).
  - `objectId` (#6, INT32): object id of the item (0 in the workspace).
  - `bagType` (#7, INT32): bag of the item (0).
  - `strBlessValue` (#8, INT32): dragon equipment bless value after the attempt (not read by the client handler; the item push carries it).
  - `gp` (#9, INT32): unused here.
- Receivers: `IV.__intensifyResult` (`IV:359,627-656`) and `TIV.__intensifyResult` (`TIV:295,399-427`), only while the view is open. Also `decompiled/m14/scripts/monster/view/MonsterAccessoriesView.as:311` listens to 86 for monster accessories ([../monsters/README.md](../monsters/README.md)).
- Client reaction: success -> sound "013", effect, reads the workspace item at `pos` (must already exist from the 115 push), sets `objectId`, `bagType`, `strengthenGrade`, dispatches `INTENSIFY_GOODS` (refreshes other equipment views). Failure -> sound "012" and fail effect. Both end the animation which clears `isIntensifing` and refreshes cost / rate (`IV:286-296`).
- When: always as the response to R1/R2/R3, also on failure. Assumption: on validation errors (not enough gold, max grade, wrong stone) send 126 `U_C_MSG` and 86 with `streng_result = false` and the unchanged grade so the client unlocks.

## 5. Rules and formulas

Equipment eligibility: template `StrengthenMax > 0` (`store-frame` filter, `StoreBagII.as:758-768`). Observed `StrengthenMax` values for equipment: 3, 6, 9, 12, 15, 18, 21, 24, 27, 30, 36, 45 (ItemTempInfos).

Gold per attempt (`GC:294-300,326-337`), with `L = NeedGrades`, `P = Profile`, `g = current strengthenGrade`:
- `L >= 80` and `P >= 6`: `(floor(L/10)+1)^2 * (P+2) * (g+1)^2.1 * 10`
- `L >= 80` and `P < 6`: `(floor(L/10)+1)^2 * P * (g+1)^2.1 * 10`
- `L < 80`: `1.5^(int(L/10)+1) * (P+1) * (g+1)^2.2 * 5 + 500`
- Result truncated to int (AS3 `int` return). `getEndIntensifyGold` sums `4 *` the per grade cost up to max (display helper, `GC:302-317`).

Success rate (`SH:16-45`):
- Normal equipment: `base = clamp(100 - g*10, 10, 100)`; plus the stone `Property1` (10, 20, ..., 90 for levels 1..9); capped at 100.
- Dragon equipment (template `Job = "99"`, `GTI:247-263`): `k = (g % 10) + 1`; `rate = 50 - 10*(k-1)` for `k <= 5`, else 5; the view adds the item bless value `strBlessValue` (0..100) and caps at 100 (`IV:694-705`). Luck stones are not usable on dragon equipment (help text). On failure the bless value increases ("Se o reforço do equipamento de Dragão falhar, terá valor de benção +1, quando o valor de benção estiver cheio irá ter sucesso"): bless +1 per failure, guaranteed success at 100, reset to 0 on success (Assumption for the reset).
- Dragon equipment also "precisa de itens de reforço" (strengthen items) per help text; the client shows `owned / Property3` of the slot 1 template (`IV:512-524`). Assumption: the server consumes `Property3` units of the dragon strengthen item from the bags.

Attribute gain per grade (`GH:129-136`): for each non zero base attribute `A` of the template (Power, Agility, Intellect, Physique, Captain, Attack, MagicAttack, Defence, MagicDefence, Parry, Live, ForceHit, Conat; `IV:790-818`), bonus at grade `g` = `int(A * g * 0.1) + g * 5`. The server must apply this in hero attribute computation ([../hero/README.md](../hero/README.md)).

Binding: strengthening binds the item (help text). The stone is consumed whether the attempt succeeds or fails (Assumption, standard behavior; the client always clears slot 1 count from the push).

Luck / strengthen stones (SonType 204):

| Templates | Name | Property1 (rate +) | Property2 |
|---|---|---|---|
| 2040101..2040109 | "Gema da Sorte Nv. 1..9" | 10..90 | 0 (normal) |
| 2350001..2350009 | "Pedra de Fortalecimento Nv.1..9" | 10..90 | 1 (for `NeedChangeJob == 2` equipment at grade >= 36) |

Treasure strengthen (`TIV:447-524,590-593`): row = `TheseusTreasureGrowupTemplates` with `TreasureId = templateId` and `TreasureLevel = current level`; cost `StrengthenItemNum` x `StrengthenItem` (2127022 "Pedra de Fort. de Tesouro Externo" for outer treasures 750, 2127026 "Pedra de Fort. de Tesouro Interno" for inner 751). Stats at a level are the row of that level (absolute values, not deltas). Max level = template `StrengthenMax` (treasure templates use 30..60; growup rows exist for levels 0..30, 0..40, 0..50, 0..60 depending on the treasure). No gold, no failure shown by the client (Assumption: 100% success). Unlock: `royaltyLevel > 0` ([../royalty-boss/README.md](../royalty-boss/README.md)).

Client side locks: while `isIntensifing`, double click / click on bag cells is ignored (`CLK:71-74,318-321`).

Quest: task condition type 17 progresses on equipment strengthen ([../quests/README.md](../quests/README.md)).

Client defect to keep in mind: the client tests `GoodsInfo.isViceEquip`, a dynamic property never assigned (only `GoodsTemplateInfo.isViceEquip` exists), so the dragon branches in `IV`, `SH.getSuccessRate` and the bless bar never run on the client; the client always shows the normal formula. The server should still implement the dragon rules (they are in the help text); the client will just display the normal rate.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | equipment / treasure | `StrengthenMax` (max grade), `NeedGrades`, `Profile` (cost), `Job` ("99" dragon equipment), `NeedChangeJob` (1 first advance, 2 later advance: stone type switch at grade 36), base attributes for the gain formula |
| same | SonType 204 stones | `Property1` = success rate bonus in percent points, `Property2` = 0 normal / 1 high grade stone, `Property3` = count needed (dragon equipment display) |
| `raw/xml/tempinfos/TheseusTreasureGrowupTemplates.xml` | `TheseusTreasureGrowupTemplate` (797 rows) | `TemplateId`, `TreasureId` (treasure item template), `TreasureLevel`, `StrengthenItem` (2127022 / 2127026, 0 at max), `StrengthenItemNum`, absolute stats `PhyAttack`, `PhyDefence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Live`, `Parry`, `Penetrate`, `ReduceResi`, `FireResi`, `WaterResi`, `ElectResi`, `WindResi`, `DarkResi`, `LightResi`, `ReduceResiAgainst`, `ResiPenetrate`; loaded as `TempleteManager.theseusTreasureGrowupCate` (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1373`) |

## 7. Persistent state

Assumption: `inventory.items` owns the item row; the strengthen grade may already be an inventory column (the item push carries it as `strengthen_grade` #17). If inventory does not own it, use:

```sql
CREATE TABLE smith.item_strengthen (
    item_id           BIGINT   PRIMARY KEY REFERENCES inventory.items(item_id) ON DELETE CASCADE,
    strengthen_grade  SMALLINT NOT NULL DEFAULT 0 CHECK (strengthen_grade BETWEEN 0 AND 100),
    bless_value       SMALLINT NOT NULL DEFAULT 0 CHECK (bless_value BETWEEN 0 AND 100), -- dragon equipment, pushed as str_bless_value
    updated_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Treasure level uses the same `strengthen_grade` column (the client reads `strengthenGrade` for treasures). Attempts are logged in `smith.operation_log` (`operation` = `strengthen` / `strengthen_treasure`, `value_before` / `value_after` = grade) defined in [store-frame.md](./store-frame.md).

## 8. Backend implementation notes

- `smith::strengthen::handle_strengthen` (5150, `opType` 0 / 1):
  1. Lock player; load workspace slot 0 (required) and slot 1 (optional).
  2. Slot 0 template `StrengthenMax > 0` and grade < max; else 126 + 86 false.
  3. If slot 1 present: SonType 204 and Property2 rule vs grade 36 and `NeedChangeJob`; reject on dragon equipment.
  4. Compute gold with the formula above; check and deduct (gold lives in [../currency/README.md](../currency/README.md)). Dragon equipment: check and consume the strengthen item.
  5. Roll `rand(0..99) < rate` (rate with stone / bless); consume the stone (count 1).
  6. Success: grade + 1, bless = 0; failure: dragon bless + 1 (100 forces next success). Bind the item.
  7. Log, commit; push 115 (slot 0 and slot 1), 86, 109; if the item is equipped (came from bag 4) recompute hero attributes and push 3; quest condition 17.
  - `opType = 1`: loop steps 4..6 until success / max / no gold, single response.
- `smith::strengthen::handle_strengthen_treasure` (5150, `opType` 3): slot 0 MasterType 11; growup row for current level; check and consume `StrengthenItemNum` x `StrengthenItem` from bags 1 and 34; level + 1; push 115, 86 (`streng_result` true, `strengthenGrade` new level), attributes refresh.
- Validation order matters for client unlock: always reply 86.

## 9. Open questions and assumptions

- Assumption: stones are consumed on failure; bless resets on success.
- Assumption: treasure strengthen always succeeds (no rate in the client).
- Open: dragon equipment strengthen item template and count (`Property3` of which template); not determinable from client data (`Property3` is empty on the stone templates).
- Open: `strengthenGrade` upper bound beyond observed 45 (check constraint uses 100).
- Open: whether `src_itemid` (always 0) was ever used to strengthen an item outside the workspace.
- `MonsterAccessoriesView` also reacts to 86 for monster accessories; coordinate with [../monsters/README.md](../monsters/README.md) so its own strengthen request does not collide.

## 10. Implementation checklist

- [ ] Screen `IntensifyView`: cost, rate, max state, preview, low rate confirmation (client only).
- [ ] Screen `TreasureIntensifyView` with `TreasureStoreBag` outer / inner.
- [ ] Route R1 5150 opType 0 handler.
- [ ] Route R2 5150 opType 1 (optional).
- [ ] Route R3 5150 opType 3 treasure handler.
- [ ] Server message S1 86 on success, failure and validation errors.
- [ ] Rule: gold formula (3 branches) with integer truncation.
- [ ] Rule: success rate normal / dragon, stone bonus, cap 100.
- [ ] Rule: stone Property2 vs grade 36 and `NeedChangeJob`.
- [ ] Rule: attribute gain `int(A*g*0.1) + 5g` in hero stats.
- [ ] Rule: treasure growup costs and stats.
- [ ] Table `smith.item_strengthen` (or inventory column) and `smith.operation_log` entries.
- [ ] Quest condition 17 progress.
- [ ] Tests: gold edge values per branch, rate clamps (grade 0, 9, 10+), stone mismatch, max grade, bless guarantee, treasure stone shortage, equipped item attribute refresh.
