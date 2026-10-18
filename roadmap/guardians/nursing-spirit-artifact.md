# Espírito de Proteção: life wheel ("Roleta da Vida") and protective artifact ("Tesouro")

Module `nursing-spirit-artifact`. Two progression mini systems of the Espírito de Proteção: the life wheel, a roulette that grants exp to one of seven resistance gauges (with locks and an instant max key), and the spirit artifact ("护灵宝具"), equipped on a spirit, charged with "Bola de Luz Elemental", refreshed with "Luz do Caos" to reroll resistance bonuses, and enchanted with "Poder Elemental".

Path aliases:

| Alias | File |
|---|---|
| CM | `decompiled/core_module/scripts/managers/ChildManager.as` |
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| NSM | `decompiled/core_module/scripts/mvc/module/children/ChildNursingSpiritModel.as` |
| LWI | `decompiled/core_module/scripts/mvc/module/children/NsLifeWheelInfo.as` |
| SAI | `decompiled/core_module/scripts/mvc/module/children/NsSpiritArtifactInfo.as` |
| V | `decompiled/m14/scripts/child/nursingspirit/` |

Push 424 and `SpiritInfoMsg` are documented in `nursing-spirit.md` S1.

## 1. Overview

- Life wheel state `LifeWheelInfoMsg` (`SpiritInfoMsg.lifeWheel` #12): `grade` #1 (wheel level, Types 133 0..100), `reduceResiGrade/Gp` #2/#3, `fireResiGrade/Gp` #4/#5, `waterResiGrade/Gp` #6/#7, `elcResiGrade/Gp` #8/#9, `windResiGrade/Gp` #10/#11, `darkResiGrade/Gp` #12/#13, `lightResiGrade/Gp` #14/#15, `skillId` #16 (active wheel skill) (`CM:458-473`).
- Artifact state `SpiritArtifactInfoMsg` (`SpiritInfoMsg.artifact` #19): `progress` #1 (charge %), `isEquip` #2, `resis` #3 STRING (values), `resiTypes` #4 STRING (types), `enchants` #5 STRING (enchant levels) (`CM:474-478`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/ChildNSLifeWheelView.as`, `V/ChildNsLifeWheelExpItem.as`, `V/ChildNsLifeWheelResiItem.as` | "Consumir {0}", "Contém {0} {1}", "Consumir {0}, atualmente contém {1}, obtenha diretamente a EXP máxima", "Diamantes necessários {0}", "EXP da Roleta da Vida", "{0} Roleta da Vida {1}" | spin the wheel with count, lock exp bars, use key | spirit frame | 212009 "Roleta da Vida do Espírito de Proteção" owned, 212010 "Chave da Roleta da Vida" owned, lock cost |
| `V/ChildNSTreasureMostView.as`, `V/ChildNSMostConversionInfoView.as`, `V/ChildNSTreasureMostEquipItem.as` | "Pode atualizar", "Pode atualizar ao atingir {0}%", "Atualização bem sucedida", "Atingiu o limite do especial" | equip/unequip, charge, refresh | spirit frame tab | 208201, 208202 counts and needs, progress |
| `V/ChildNSTreasureMostEnchantFrame.as`, `V/ChildNSTreasureMostEnchantItem.as` | | enchant an artifact resistance | `NSC` openType `ENCHANT` | 208203 "Poder Elemental" |

## 3. Routes (client to server)

All: send 8868 (0x22a4) `C_CHILDREN_OP`.

### A1. Spin the life wheel (op 35 SPIRIT_LIFE_WHEEL_ROLL)
- UI: `V/ChildNSLifeWheelView.as:301-343`.
- Client checks: 212009 owned >= spin count ("Materiais insuficientes, não é possível girar a roleta da vida"); when bars are locked the diamond cost `allPoint` is confirmed ("Deseja consumir {0} diamantes para fechar {1} barras de EXP e girar a roleta da vida?") and checked against diamonds or bound diamonds; at most N locks ("Já atingiu o número máximo").
- Request: `op_type`=35, `property1` = child id, `pay_type` (0 no locks, 1 diamonds, 2 bound diamonds), `property2` = spin count, `property3` = lock string (locked bar indexes), `property5` = use key 212010 (instant max exp).
- Response: 115; 424 with `op` 35, `isSuccess`, `gpIndex`, `resiIndex`, `results` (`CM:495-515`) and the updated `lifeWheel`.

### A2. Equip / unequip the artifact (op 40 SPIRIT_ARTIFACT_EQUIP)
- UI: equip and uninstall buttons (`V/ChildNSMostConversionInfoView.as:312-323`) both send the same toggle.
- Request: `op_type`=40, `property1` = child id. Response: 424 `artifact.isEquip`.

### A3. Charge (op 41 SPIRIT_ARTIFACT_INJECT)
- UI: `V/ChildNSMostConversionInfoView.as:325-338`: next level exists else "Atingiu o limite do especial"; 208201 owned >= need else "armyII.viewII.holydragonsoul.HolyDragonSoulView.Tips01".
- Request: `op_type`=41, `property1` = child id. Response: 115, 424 `artifact.progress`.

### A4. Refresh (op 42 SPIRIT_ARTIFACT_REFRESH)
- UI: `:340-350`: 208202 owned >= need. Refresh is allowed when `progress` reaches the threshold ("Pode atualizar ao atingir {0}%"), thresholds config `spirit_refresh_config` = "60,70,80,90,100,100" by open socket count (0..4 holes, resistance) *(assumption on mapping)*.
- Request: `op_type`=42, `property1` = child id. Response: 115, 424 (`resis`, `resiTypes`).

### A5. Enchant (op 43 SPIRIT_ARTIFACT_ENCHANT)
- UI: `V/ChildNSTreasureMostEnchantFrame.as:300-316`, material 208203.
- Request: `op_type`=43, `property1` = child id, `property2` = enchant index.
- Response: 115; 424 with `op` 43, `isSuccess` -> `nsModel.enchantRefreshSuccess`, `resiIndex` -> `enchantIndex` (`CM:516-526`), `artifact.enchants`.

## 4. Server messages (server to client)

424 `U_C_SPIRITINFO` (`nursing-spirit.md` S1) with `op` 35 or 43 result fields and the updated `lifeWheel` / `artifact`; 115 bag updates; currency push for locked spins.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Wheel levels | `UpGradeTempInfos` Types 133 (0..100; `Data` exp, `ActiveObject` value, last row item 1200010) | `V/ChildNSLifeWheelView.as` |
| Spin material | 212009 x count; key 212010 grants max exp | strings, `:455-458` |
| Lock cost | diamonds per locked bar *(assumption: config driven, computed client side as `allPoint`)* | `:309-314` |
| Artifact items | 208201 charge, 208202 refresh, 208203 enchant | views |
| Refresh threshold | `spirit_refresh_config` | `ConfigInfos.xml` |

## 6. Templates

`UpGradeTempInfos.xml` Types 133 (wheel) and the artifact curves read by `ChildNSMostConversionInfoView` *(assumption: Types near 133..135)*, `ConfigInfos.xml` `spirit_refresh_config`, `ItemTempInfos.xml` 212009, 212010, 208201..208203.

## 7. Persistent state

```sql
CREATE TABLE guardians.spirit_life_wheels (
  child_id        INTEGER  PRIMARY KEY REFERENCES guardians.spirits(child_id) ON DELETE CASCADE,
  grade           SMALLINT NOT NULL DEFAULT 0,
  resi_grades     SMALLINT[] NOT NULL DEFAULT '{0,0,0,0,0,0,0}',
  resi_gps        INTEGER[]  NOT NULL DEFAULT '{0,0,0,0,0,0,0}',
  skill_id        INTEGER  NOT NULL DEFAULT 0
);

CREATE TABLE guardians.spirit_artifacts (
  child_id     INTEGER  PRIMARY KEY REFERENCES guardians.spirits(child_id) ON DELETE CASCADE,
  is_equipped  BOOLEAN  NOT NULL DEFAULT FALSE,
  progress     SMALLINT NOT NULL DEFAULT 0 CHECK (progress BETWEEN 0 AND 100),
  resi_values  INTEGER[]  NOT NULL DEFAULT '{}',
  resi_types   SMALLINT[] NOT NULL DEFAULT '{}',
  enchants     SMALLINT[] NOT NULL DEFAULT '{}'
);
```

Resistance order in arrays: anti resistance, fire, water, shock, wind, darkness, light.

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 35 | `guardians::nursing_spirit_artifact::handle_life_wheel_spin` |
| 40 | `guardians::nursing_spirit_artifact::handle_toggle_equip` |
| 41 | `guardians::nursing_spirit_artifact::handle_charge` |
| 42 | `guardians::nursing_spirit_artifact::handle_refresh` |
| 43 | `guardians::nursing_spirit_artifact::handle_enchant` |

- Spin: for each spin roll the exp slot and resistance, skip locked bars, accumulate; key fills the selected bar to max; return per spin results in `results` (comma list) *(assumption on format)*.
- Push 424 with `op` so the client plays the right animation.

## 9. Open questions and assumptions

- *(assumption)* Wheel roll probabilities, lock pricing and the `results` string format.
- *(assumption)* Artifact charge amount per item and refresh/enchant success rates.

## 10. Implementation checklist

- [ ] Ops 35, 40, 41, 42, 43.
- [ ] Tables `guardians.spirit_life_wheels`, `guardians.spirit_artifacts`.
- [ ] 424 result fields for ops 35 and 43.
- [ ] Tests: spin without wheel items rejected; refresh below the threshold rejected; equip toggles `isEquip`.
