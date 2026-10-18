# Guardian war emblem ("Emblema de Guerra")

Module `emblem`. Each guardian has a war emblem with a level 1..10 and six "balls" (slots). Slot 1 holds anti resistance; slots 2..6 each hold up to three resistance attributes chosen among fire, water, shock, wind, darkness, light. The emblem is activated with "Cristal do Guardião", leveled with the same crystal, slot attributes are chosen, converted or swapped, and each attribute is raised with "Essência de Anti-resistência" (slot 1) or "Essência de Resistência" (slots 2..6), capped by the emblem level.

Path aliases:

| Alias | File |
|---|---|
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| EI | `decompiled/core_module/scripts/mvc/module/children/EmblemInfo.as` |
| CD | `decompiled/core_module/scripts/mvc/module/children/ChildData.as` |
| V | `decompiled/m14/scripts/child/emblem/` |

`ChildrenOpMsg` table: `roster.md` section 1.

## 1. Overview

- Emblem level `emblem` (#17) and exp `emblemGp` (#18) in `ChildrenMsg`; curve `UpGradeTempInfos` Types 47 (`Data` 0, 300, 360, 500, 800, 1500, 3000, 6400, 15000, 40000; `ActiveObject` 8301..8310 = emblem skill/effect id per level).
- Slots `emblemPos` (#16, repeated `EmblemMsg`): `pos` #1 (1..6), `resi1` #2, `resi1Grade` #3, `resi1Gp` #4, `resi2` #5, `resi2Grade` #6, `resi2Gp` #7, `resi3` #8, `resi3Grade` #9, `resi3Gp` #10. Resistance type ids: 1 anti resistance, 2 fire, 3 water, 4 shock, 5 wind, 6 darkness, 7 light (`V/ChildEmblemBallView.as` tips `ballTip1..7`; `CD:336-373` adds `resiN` value at index `resiN - 1`). 0 = not chosen, 1 = empty placeholder *(assumption from `resi <= 1` checks)*.
- Attribute value: slot 1 uses Types 49 (`ActiveObject` 0, 165, 240, ... 3910 at level 10); other slots Types 48 (0, 25, 40, ... 650) (`EI:34-54`).
- Slot `pos` unlock: slot 1 at emblem level 1, slot p at level p - 1 ("Nível {0} Ativar Emblema de Guerra", `V/ChildEmblemBallView.as:236-247`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/ChildEmblemTabView.as`, `V/ChildEmblemRightView.as` ("Atributos do Guarda"), `V/ChildEmblemBallView.as`, `V/ChildEmblemItemView.as` | "Nv.{n}", "Clique para ativar anti-res", "Clique para escolher atributo" | emblem tab: level, balls, totals | `ChildFrame` tab 4 | `emblem`, `emblemGp`, `emblemPos` |
| `V/ChildEmblemUpView.as`, `V/ChildEmblemUpGradeFrame.as` | "Elevar" / "Aumentar anti-resistência" / "Aumentar resistência", "Cristal de Guerra atua do Guardião: {0}", "Essência de anti-resistência do Guardião atual: {0}", "Essência da resistência do Guardião: {0}" | feed crystal or essences | ball click, `CC` openType `emblem_up` | exp bars, caps "Para continuar a elevar a resistência do Guardião precisa de elevar o Emblema de Guerra para nível {0}", "O nível atingiu o máximo" |
| `V/ChildEmblemChangeView.as`, `V/ChildEmblemItemChangeView.as` | "Converter atributos" / "Escolher atributos", "Consumir {0} Ouro", names "Atributo de fogo" ... "Atributo da luz" | choose or convert slot attributes | ball click, `CC` `emblem_change` | |

## 3. Routes (client to server)

All: send 8868 (0x22a4) `C_CHILDREN_OP`.

### A1. Activate (op 17 ACTIVE_EMBLEM)
- UI: tab button when `emblemLv == 0` (`V/ChildEmblemTabView.as:379-433`): no 208046 -> quick buy; confirm "Deseja consumir [Cristal da Guerra] x1 para tivar Emblema de Guerra do Guardião?".
- Request: `op_type`=17, `property1` = child id. Response: 115, 4747 with `emblem` = 1.

### A2. Level the emblem (op 18 UPGRADE_EMBLEM)
- UI: ball 0 in `V/ChildEmblemUpView.as:316-331`; count clamped (`:296-314`); missing 208046 -> quick buy.
- Request: `op_type`=18, `property1` = child id, `property2` = crystal count. Response: 115, 4747 (`emblem`, `emblemGp`). Exp per crystal *(assumption: item `Property1`)*.

### A3. Raise a slot attribute (op 21 UP_PROPERTY)
- UI: `V/ChildEmblemUpView.as:332-357`: slot 1 uses 208048 "Essência de Anti-resistência de Guardião", others 208047 "Essência de Resistência de Guardião".
- Client cap: attribute level cannot exceed the emblem level (`:192-210`, "Para elevar resistência precisa de elevar o Emblema de Guerra para nível {0}").
- Request: `op_type`=21, `property1` = child id, `property2` = slot `pos`, `property6` = attribute index 0..2 (0 for slot 1), `property7` = essence count.
- Response: 115, 4747 (`emblemPos`).

### A4. Choose attributes (op 19 SELECT_PROPERTY)
- UI: `V/ChildEmblemItemChangeView.as:80-99` (single) and `V/ChildEmblemChangeView.as:390-412` (multiple); repeated type -> "Se tiver atributos de anti-res repetidos não será possível selecionar"; too many -> "Ultrapassou número de slots de atributos, favor selecionar após cancelar."; none -> "Selecione um atributo".
- Request: `op_type`=19, `property1` = child id, `property2` = slot `pos`, `poses` (#11, repeated `children.PosMsg`: `order` #1 = attribute index 0..2, `property` #2 = resistance type 2..7). Note: `protocol/proto.json` keys `PosMsg` to the campaign message (x, y); the guardian one is `com.road.yishi.proto.children.PosMsg` (`decompiled/core_module/scripts/com/road/yishi/proto/children/PosMsg.as:85-110`).
- Response: 4747.

### A5. Convert an attribute (op 20 CHANGE_PROPERTY)
- UI: `V/ChildEmblemChangeView.as:362-372` and item change view `:106`. Gold cost `10000 * 2^(grade - 1)` of the converted attribute ("Consumir {0} Ouro", `:234-239`).
- Request: `op_type`=20, `property1` child id, `property2` slot, `property6` attribute index, `property7` new resistance type. Response: 4747, gold push.

### A6. Swap two attributes of a slot (op 23 UP_EXCHANGE_PROPERTY)
- UI: `V/ChildEmblemItemChangeView.as:100-103` when the chosen type already exists in the slot.
- Request: `op_type`=23, `property1` child id, `property2` slot, `property6` attribute index, `property7` index of the existing attribute with that type. Response: 4747.

## 4. Server messages (server to client)

4747 `U_C_CHILDREN` fields `emblemPos` (#16), `emblem` (#17), `emblemGp` (#18), `join_info` (#21) (`roster.md` S1); 115 bag updates; gold resource push for op 20.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Activation | 1 x 208046 | `V/ChildEmblemTabView.as` |
| Emblem curve | Types 47, max 10 | `UpGradeTempInfos.xml` |
| Anti resistance curve | Types 49 (slot 1), max 10 | `EI:40-43` |
| Resistance curve | Types 48 (slots 2..6), max 10 | `EI:44-47` |
| Cap | attribute level <= emblem level | `V/ChildEmblemUpView.as:204` |
| Slot unlock | slot p at emblem level max(1, p - 1) | `V/ChildEmblemBallView.as:236-247` |
| Conversion gold | `10000 * 2^(grade-1)` | `V/ChildEmblemChangeView.as:236` |
| Totals | anti resistance = slot 1 value + template `ReduceResi`; each element = sum of slot values of that type + template + fielded pet resistance | `CD:336-373` |

## 6. Templates

| File | Use |
|---|---|
| `UpGradeTempInfos.xml` Types 47, 48, 49 | curves and values |
| `ItemTempInfos.xml` | 208046 Cristal do Guardião, 208047 Essência de Resistência de Guardião, 208048 Essência de Anti-resistência de Guardião |

## 7. Persistent state

```sql
CREATE TABLE guardians.emblems (
  child_id     INTEGER  PRIMARY KEY REFERENCES guardians.children(child_id) ON DELETE CASCADE,
  level        SMALLINT NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 10),
  gp           INTEGER  NOT NULL DEFAULT 0 CHECK (gp >= 0)
);

CREATE TABLE guardians.emblem_slots (
  child_id     INTEGER  NOT NULL REFERENCES guardians.emblems(child_id) ON DELETE CASCADE,
  pos          SMALLINT NOT NULL CHECK (pos BETWEEN 1 AND 6),
  attr_index   SMALLINT NOT NULL CHECK (attr_index BETWEEN 0 AND 2),
  resi_type    SMALLINT NOT NULL DEFAULT 0 CHECK (resi_type BETWEEN 0 AND 7),
  grade        SMALLINT NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 10),
  gp           INTEGER  NOT NULL DEFAULT 0 CHECK (gp >= 0),
  PRIMARY KEY (child_id, pos, attr_index)
);
```

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 17 | `guardians::emblem::handle_activate` |
| 18 | `guardians::emblem::handle_level_up` |
| 19 | `guardians::emblem::handle_select` |
| 20 | `guardians::emblem::handle_convert` |
| 21 | `guardians::emblem::handle_raise_attribute` |
| 23 | `guardians::emblem::handle_swap` |

- Validate household ownership and spouse field lock, slot unlocked by level, no duplicate types in a slot, caps; consume items/gold; recompute guardian stats; push 115 and 4747.

## 9. Open questions and assumptions

- *(assumption)* Exp per crystal and essence (item `Property1`).
- *(assumption)* Meaning of `resi` values 0 and 1 (unchosen vs placeholder).
- *(assumption)* Emblem `ActiveObject` 8301..8310 are passive skills applied in battle.

## 10. Implementation checklist

- [ ] Ops 17, 18, 19, 20, 21, 23.
- [ ] Tables `guardians.emblems`, `guardians.emblem_slots`.
- [ ] `EmblemMsg` serialization in 4747.
- [ ] Resistance totals in the stat service.
- [ ] Tests: activation without crystal rejected; raising an attribute above the emblem level rejected; duplicate type in a slot rejected; conversion of a grade 3 attribute costs 40000 gold.
