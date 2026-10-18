# Guardian attributes: growth leveling, fostering items, attribute conversion

Module `attributes`. A guardian's stats are percentages of the hero's own totals, set by its job and growth level (1..12) in `ChildTempInfos.xml`. This module covers the growth upgrade with "Sangue de Zeus" (op 10), the legacy fostering items (ops 3, 11, 14, 4, 15) and the "Conversão de Guardiões" that swaps level, skills and attributes between two guardians (op 27). The Espírito de Proteção growth (op 29) and its second advancement (op 44) are in `nursing-spirit.md`.

Path aliases:

| Alias | File |
|---|---|
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| CD | `decompiled/core_module/scripts/mvc/module/children/ChildData.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/children/ChildModel.as` |
| V | `decompiled/m14/scripts/child/` |

`ChildrenOpMsg` field table and op list: `roster.md` section 1. Push 4747 fields: `roster.md` S1.

## 1. Overview

- Growth level `growth_grade` 1..12; exp `growth_gp` inside the level; curve `UpGradeTempInfos` Types 44 (normal guardians) with `Data` = exp to reach that level: 500 (Lv2), 600, 850, 1350, 2400, 4800, 10500, 25000, 65000, 80000, 100000 (Lv12) (`V/attribute/ChildUpgradeGrowthView.as:213-220`, `:300-330`). Types 128 is the Espírito de Proteção curve.
- Stats at level L: `JobType` row `Grades` = L gives percentages `Live`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence` of the hero totals (HP, max(physical, magic attack), physical defence, max attack, magic defence) plus flat `ForceHit`, `Parry`, `StunAttr`, `Penetrate`, resistances (`V/attribute/ChildUpgradeGrowthView.as:230-300`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/attribute/ChildAttributeTabView.as`, `V/attribute/ChildAttributeViewII.as`, `V/attribute/ChildAttributeItem.as` | | attribute tab | `ChildFrame` tab 1 | `join_info` final stats, resistances (`CD.ResiValueArr`, `CD:336-373`) |
| `V/attribute/ChildFosterViewII.as` | "Valor do estado", "Pontos de crescimento: {0}", "Desenvolver capacidade de combate {0}%" | state, growth points, battle menu, sell, upgrade button (`:551-555` opens growth) | attribute tab | |
| `V/attribute/ChildUpgradeGrowthView.as` | "promotion", "Pontos de Vida \| Ataque \| Defesa \| Magia \| Resistência \|", "Quantidade atual:", "Quantidade consumida:" | growth upgrade | `CM.openGrowthFram` (`CC` openType `growth`) | fight power, exp bar `growth_gp / next.Data`, current and next level percentages with computed values, "MAX" at 12, second advancement button for spirits (`:205-330`) |
| `V/attribute/ChildAttriTwoStepView.as` | | second advancement attributes (spirits) | | see `nursing-spirit.md` |
| `V/switched/ChildSwitchFrame.as`, `V/switched/ChildSwitchSelectView.as`, `V/switched/ChildSwitchSelectItemView.as` | "Conversão de Guardiões" | pick a second guardian and swap | attribute tab | left/right guardians with level and stats, cost text |
| `V/attribute/ChildItemView.as`, `V/attribute/ChildShowView.as`, `V/attribute/ChildShowAvatar.as` | "Crescimento em dias: {0} Dias", "Valor do estado:{0}", "Modificar" | legacy growth/state display and avatar | attribute tab | |
| care frame `child.attribute.ChildCareFrame` | "Cuidar" | legacy mood care ("O espírito atual do guarda está cheio") | `CC` openType `care` | |

## 3. Routes (client to server)

All: send 8868 (0x22a4) `C_CHILDREN_OP`, `ChildrenOpMsg`.

### A1. Growth upgrade (op 10 OP_UP_GROWGH_VALUE)
- UI: confirm in `V/attribute/ChildUpgradeGrowthView.as:427-450`.
- Client checks: bag count of 2250001 "Sangue de Zeus" >= input, else the quick buy frame (`showQutiBuy`, shop area 10) for the missing amount (`:463-480`); spirits (`isNursingSpirit`) send op 29 instead.
- Request: `op_type`=10, `property1` = child id, `property2` = item count.
- Response: 115 (bag), 4747 with `growth_grade`, `growth_gp`, `growth_count`, `join_info`, `fight_capacity`.

### A2. Attribute conversion (op 27 OP_SWITCH)
- UI: `V/switched/ChildSwitchFrame.as:150-182`.
- Client checks: a target exists among guardians of another job with `MasterType` 0 (`CMOD.getSwitchChildListByChildId`, `CMOD:513-540`) else "Não tem guardiões a serem convertidos"; selected else "Você ainda não selecionou guardiões para efetuar conversão"; diamonds (`point`) >= `Trans_Point` (2000) else recharge; confirm "Deseja consumir {0} diamantes para converter?" with "(Ao converter poderá trocar o nível, nível de habilidades, atributos de dois guardiões)".
- Request: `op_type`=27, `property1` = source child id, `property2` = target child id.
- Response: 4747 with both guardians (swapped `growth_grade`, `growth_gp`, skill levels, emblem data *(assumption: everything except job and identity)*), currency push.

### A3. Use reset item (op 14 APT_RESET_ITEM)
- UI: click item 208042 "Espelho do Demônio" in the guardian bag (`V/equip/ChildBagCellClickMediator.as:253-258`, sends `property2` = bag position) or the multi use frame (`decompiled/core_module/scripts/bag/view/MulItemUseFrame.as:316-325`, sends `property2` = count).
- Request: `op_type`=14, `property1` = child id, `property2` = position or count (inconsistent callers, see open questions).
- Response: 4747. Item description: resets the 5 qualification points.

### A4. Foster aptitude / mood (op 3 OP_FEED, op 11 OP_MOOD), legacy
- UI: click a SonType 223 item: `Property2 > 0` -> op 3, `Property3 > 0` -> op 11 (`V/equip/ChildBagCellClickMediator.as:239-251`). No SonType 223 item exists in `ItemTempInfos.xml`, so these routes are unreachable.
- Request: `property1` child id, `property2` item position, `property6` count (default 1) (`CS:299-319`).

### A5. Reset points (op 4), refresh feed items (op 15)
`CS.resetPoint` (`property1` child, `property3` string) and `CS.refreshFeedItem` (`property1`, `pay_type` 0/1) have no callers (`CS:282-339`).

## 4. Server messages (server to client)

Only 4747 `U_C_CHILDREN` (`roster.md` S1) and 115 bag updates. Fields used here: `growth_grade` #6, `growth_gp` #12, `growth_count` #13, `fight_capacity` #14, `join_info` #21.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Exp per item | 2250001 `Property1` = 10 growth points | item description |
| Level curve | Types 44 rows 1..12, max level 12 | `UpGradeTempInfos.xml` |
| Exp loop | `gp += 10 * count`; while level < 12 and `gp >= next.Data`: `gp -= next.Data`, level++ *(assumption on carry, the client clamps the bar to `next.Data`)* | `V/attribute/ChildUpgradeGrowthView.as:306-316` |
| Daily cap | "A absorção atingiu o limite por hoje" exists; *(assumption)* `growth_count` counts items absorbed today against a cap (item `Property3` 5 or `Property2` 10 unknown) | strings |
| Stat formula | stat = floor(heroTotal(stat) * row.stat% / 100) + extras (pet inheritance `fight_pet`, emblems, equipment, skills) | `V/attribute/ChildUpgradeGrowthView.as:240-300` |
| Resistances | `ResiValueArr`: template resistances + emblem values + fielded pet resistances | `CD:336-373` |
| Conversion cost | `Trans_Point` = 2000 diamonds | `ConfigInfos.xml` |
| Conversion targets | different job, normal guardians only | `CMOD:513-540` |

## 6. Templates

| File | Use |
|---|---|
| `ChildTempInfos.xml` | per (`JobType`, `Grades`) percentages and flat stats |
| `UpGradeTempInfos.xml` Types 44 / 128 | growth curve normal / spirit |
| `ItemTempInfos.xml` | 2250001 Sangue de Zeus, 208042 Espelho do Demônio |
| `ConfigInfos.xml` | `Trans_Point` |

## 7. Persistent state

Columns `growth_grade`, `growth_gp`, `growth_count_today` of `guardians.children` (`roster.md`). Add a daily reset marker:

```sql
ALTER TABLE guardians.children ADD COLUMN growth_count_on DATE NOT NULL DEFAULT CURRENT_DATE;
```

Cached stats (`fight_capacity`) are recomputed from the hero; no stat table.

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 10 | `guardians::attributes::handle_growth_upgrade` |
| 27 | `guardians::attributes::handle_convert` |
| 14 | `guardians::attributes::handle_use_reset_item` |
| 3, 11, 4, 15 | `guardians::attributes::handle_legacy_noop` |

- Op 10: guardian belongs to the household and is not a spirit -> count 1..owned -> level < 12 -> daily cap -> transaction (consume, add exp, level up) -> push 115 and 4747 (stats recomputed) -> hero power if fielded.
- Op 27: both guardians owned, different jobs, `MasterType` 0, not removed -> 2000 diamonds -> swap growth fields, skill levels and emblem levels in one transaction -> push 4747 with both.
- Stat recompute service `guardians::stats::recompute(child_id)` used by every module: hero totals x template percentages + equipment + emblems + skills + pet inheritance; writes `fight_capacity` and builds `JoinInfoMsg`.

## 9. Open questions and assumptions

- *(assumption)* Exact daily absorption cap.
- Op 14 `property2` is a bag position from one caller and a count from the other; the server should accept a count when the value is small and the item exists in that position otherwise *(assumption)*.
- *(assumption)* Which fields conversion swaps besides level and skills.

## 10. Implementation checklist

- [ ] Op 10 growth upgrade with Types 44.
- [ ] Op 27 conversion with 2000 diamonds.
- [ ] Op 14 reset item.
- [ ] Legacy ops 3, 11, 4, 15 accepted as no-op.
- [ ] Shared stat recompute service.
- [ ] Tests: 50 Sangue de Zeus from level 1 reaches level 2; level 12 rejects upgrade; conversion between same job rejected; conversion without 2000 diamonds rejected.
