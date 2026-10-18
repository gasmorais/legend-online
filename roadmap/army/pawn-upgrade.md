# Soldier upgrade, characteristics and conversion (Elevar soldado, Características do Soldado)

Path aliases:

| Alias | File |
|---|---|
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| PU | `decompiled/m5/scripts/armyII/viewII/pawnupgrade/` |

## 1. Overview

- Level up: each soldier family has 80 levels (`PawnTempInfos`, `NextLevelTemplateId`). Raising a family costs soul points ("Espírito", `playerInfo.strategy`, gained from soldiers killed in battle) and requires the barracks level >= the new soldier level. All soldiers of the family (reserve and troop) change template at once.
- Characteristics ("Características do Soldado", `SpecialTempInfos`): from soldier level 10 a family has one characteristic that converts part of the soldier stats into hero stats. The player "comprehends" (rolls) a new characteristic for 1,000,000 souls and may replace the current one; a bless bar raises the characteristic level.
- Conversion ("Características do Soldado" convert tab): moves characteristics between two families for 200 diamonds or 2,000,000 souls (hero level 40).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.pawnupgrade.PawnLevelUpFrame` (`PU/PawnLevelUpFrame.as`) | "Elevar soldado" (`buildings.casern.view.PawnLevelUpFrame.command01`) | Family list (11 icons), stats now/next, skills by level, soul cost, characteristic panel | "Elevar" in barracks or Equipe (`PAWNUPGRADE`, `AC.startFrameByType`, AC:81-93, AC:119-121) | soul owned/needed, "Nível máximo atingido", tip "Soldados que morrem durante batalhas são convertidos automaticamente em espíritos, quantidade de espíritos obtidos correspondem ao número de soldados mortos" |
| `PU/PawnSpecialAbilityFrame.as` | "Características do Soldado" | Current vs comprehended characteristic, bless bar, "Substituir" | comprehend button in PawnLevelUpFrame (`PU/PawnLevelUpFrame.as:413-427`) | cost "1000000", owned souls (`:210-237`) |
| `PU/PawnAbilityConvertFrame.as` | "Características do Soldado" | Pick source and target family ("Soldados" combo, "Característica Nv. {0}"), pay with diamonds or souls | convert button (`PU/PawnLevelUpFrame.as:335-363`) | both characteristics and their level difference |
| `PU/PawnSkill.as` | "{n}Habilitado no nível" | Skill unlocked at a level | PawnLevelUpFrame | `DefaultSkill`/`HighSkill` |

## 3. Routes (client to server)

### R1. Level up a soldier family
- UI: `_upGrade` (`PU/PawnLevelUpFrame.as:429-448`).
- Client checks: `strategy >= needSoul` else "Espírito insuficiente" (`buildings.casern.view.PawnLevelUpFrame.command05`); barracks (building SonType 402) level >= next template `Level` else "Necessita de Quartel {0}" (`command06`); button disabled at max level.
- Cost: `UpGradeTempInfos` row `Types = 1`, `TemplateId = next template id`, `Data` = souls (`getTemplateByTypeAndLevelAndID(level, 1, id)`, `PU/PawnLevelUpFrame.as:575-596`). Examples: Lanceiro level 2 = 16, level 10 = 2000, level 50 = 250000, level 80 = 1024000.
- Client path: `AC.sendUpgradePawn(templateId)` (AC:376-379) → `ASOM.sendUpgradePawn` (ASOM:95-101).
- Route: send 5158 (0x1426) `U_C_ARMY_UPGRADEPAWN`. Request `ArmyPawnInfoMsg`: `tempate_id` (#5, INT32) current template of the family; other fields unset.
- Expected response: 116 `U_C_PAWN_INFO` (S1) with the next template; soul push (3 `U_C_PLAYER_INFO` field `strategy`); 93/100 for troop and reserve entries *(assumption)*. The client shows "Elevado ao Nv. {0}" (`command07`) and at level 10 "Parabéns ao seu {0} por adquirir características do soldado" (`command09`) when `VersionSwitch.PAWNSPECIAL` (true) (`PU/PawnLevelUpFrame.as:450-469`). Opcode 95 `U_C_ARMY_UPGRADEPAWN` (accept) has no client listener.

### R2. Comprehend a characteristic
- UI: comprehend button in `PawnSpecialAbilityFrame` (`PU/PawnSpecialAbilityFrame.as:155-170`); hero level >= 40 else "Função habilitado com Líder Nv. 40" (`PU/PawnLevelUpFrame.as:413-427`).
- Client check: if the pending one is already better than the current (`tempSpecial.Grades > specialAbility.Grades`) → "Característica mais elevada já existente" (`buildings.casern.view.PawnSpecialAbilityFrame.BetterAlert`).
- Route: send 8455 (0x2107) `C_COMPREHEND`, `ComprehendMsg` (army): `template_id` (#1, INT32) soldier template.
- Expected response: 116 with `comprehedn_tempIds` (pending) and `bless_num`; soul push (1,000,000 *(assumption: the displayed cost is charged)*).

### R3. Replace the characteristic ("Substituir")
- UI: `_insteadBtn`, enabled when a pending characteristic exists; confirm "Certeza ao substituir pela nova característica?" (`PU/PawnSpecialAbilityFrame.as:132-153`).
- Route: send 8456 (0x2108) `C_SAVESPECIAL`, `ComprehendMsg`: `template_id` (#1, INT32).
- Expected response: 116 with `special_tempIds` = old pending, `comprehedn_tempIds` empty.

### R4. Convert characteristics between families
- UI: convert button (`PU/PawnAbilityConvertFrame.as:274-375`). Pre-checks in PawnLevelUpFrame: hero level >= 40; another family at level >= 10 exists else "Não há outra característica convertível" (`PU/PawnLevelUpFrame.as:335-363`). Same family → "Soldado similar, não é possível converter". Once per day an alert "Conversão removerá característica não substituída do soldado, continuar?" with "Não alertar mais".
- Pay tab 0 (diamonds): `POINT_VALUE` = 200; affordability uses `point` or `point + giftToken` when bound diamonds are allowed; else recharge prompt. Pay tab 1 (souls): `SOUL_VALUE` = 2,000,000 else "Espírito insuficiente".
- Client path: `AC.sendPawnChange(cur, tar, payType, useBind)` (AC:381-384) → `ASOM.sendPawnChange` (ASOM:103-118).
- Route: send 8580 (0x2184) `C_PAWN_CHANGE`, `PawnChangeMsg` (army): `cur_pawnTempId` (#1, INT32) source template; `tar_pawnTempId` (#2, INT32) target template; `pay_type` (#3, INT32) 1 = diamonds, 3 = diamonds with bound diamonds allowed (`SharedManager.pownConveruseBind`), 2 = souls.
- Expected response: 116 (or 100) for both families with updated `special_tempIds`; currency push.

## 4. Server messages (server to client)

### S1. 116 (0x0074) `U_C_PAWN_INFO`
- Message `ArmyPawnInfoMsg` (fields in [troops.md](troops.md)); read: `tempate_id` (#5), `comprehedn_tempIds` (#10), `special_tempIds` (#9), `bless_num` (#11), `son_type` (#4).
- Receiver: `AM.__pawnLeveupHandler` (AM:320-333): builds an `ArmyPawn` and `synchronizationAllArmyPawns` (AM:826-835) updates the reserve entry of that family and every troop entry; dispatches `upgrade_pawn_success` with `son_type`, which refreshes `RecruitPawnCell` (`decompiled/core_module/scripts/yishi/view/community/RecruitPawnCell.as:145-152`).
- When: after 5158, 8455, 8456, 8580, and when bless progress changes.

### S2. 3 `U_C_PLAYER_INFO`
Soul points `strategy`, diamonds; owned by [../currency/README.md](../currency/README.md).

## 5. Rules and formulas

- Upgrade cost: `UpGradeTempInfos` `Types 1` keyed by target template id (`Data` souls).
- Upgrade gate: barracks building level >= target soldier `Level`. Upgrade hint shown while family level < hero level - 3 (AM:783-811).
- Characteristic unlock: soldier level 10 (`PU/PawnLevelUpFrame.as:461`, `:618`).
- Comprehend cost: 1,000,000 souls (hard-coded label, `PU/PawnSpecialAbilityFrame.as:218`).
- Bless: `bless_num` progress toward `UpGradeTempInfos` `Types 16` row `Grades = current characteristic Grades` (`Data`: 5, 10, 20, ...); hidden at characteristic level 10 (`:190-237`).
- Characteristic effect (`SpecialTempInfos`): `CurProperty` soldier stat converted into `TarProperty` hero stat by `ChangeNumber` percent (e.g. "Conversão de Vida": +5% of soldier HP to the hero); `PawnMasterType` = family; `TakeRandom` = roll weight; `Grades` = level.
- Conversion cost: 200 diamonds or 2,000,000 souls.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `PawnTempInfos.xml` | soldier levels | `Level`, `NextLevelTemplateId`, `DefaultSkill`, `HighSkill`, stats |
| `UpGradeTempInfos.xml` | `Types 1` (soldier upgrade souls), `Types 16` (characteristic bless) | `TemplateId`, `Grades`, `Data` |
| `SpecialTempInfos.xml` | characteristic (561 rows) | `TemplateId`, `TemplateName`, `Description`, `MasterType`, `Grades`, `CurProperty`, `TarProperty`, `ChangeRandom`, `ChangeNumber`, `PawnMasterType`, `ResPath`, `TakeRandom` |
| `BuildingTempInfos.xml` | barracks level | `BuildingGrade` |

## 7. Persistent state

Levels and characteristics are columns of `army.castle_reserve` ([troops.md](troops.md)): `template_id`, `special_template_id`, `pending_special_template_id`, `bless_value`. Audit table for upgrades:

```sql
CREATE TABLE army.soldier_upgrade_log (
    log_id        BIGSERIAL PRIMARY KEY,
    player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    son_type      INTEGER NOT NULL,
    action        TEXT    NOT NULL CHECK (action IN ('level_up', 'comprehend', 'replace', 'convert')),
    from_value    INTEGER,
    to_value      INTEGER,
    cost_souls    BIGINT  NOT NULL DEFAULT 0,
    cost_diamonds INTEGER NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX soldier_upgrade_log_player_idx ON army.soldier_upgrade_log (player_id, created_at DESC);
```

## 8. Backend implementation notes

- `army::pawn_upgrade::handle_level_up` (5158): template must be the family's current template; next template exists; barracks level >= next `Level`; souls >= `Types 1` `Data`; transaction: deduct souls, update reserve and troop template; at level 10 assign an initial characteristic by `TakeRandom` among `PawnMasterType = family` grade 1 *(assumption)*; push 116, 3, 93/100.
- `army::pawn_upgrade::handle_comprehend` (8455): hero level >= 40, soldier level >= 10, souls >= 1,000,000; roll `SpecialTempInfos` for the family weighted by `TakeRandom`; store pending; push 116, 3.
- `army::pawn_upgrade::handle_replace_special` (8456): pending exists; swap into active; reset bless *(assumption)*; push 116.
- `army::pawn_upgrade::handle_convert` (8580): both templates owned, different families, both level >= 10, hero level >= 40; charge 200 diamonds (bound first for pay type 3) or 2,000,000 souls; swap characteristics *(assumption)*; clear pending ones; push 116 for both, 3.
- Characteristics feed hero stats: recompute and push 113.

## 9. Open questions and assumptions

- Assumption: conversion swaps the two families' characteristics; the alert says conversion removes the non-replaced (pending) characteristic.
- Assumption: comprehend charges the displayed 1,000,000 souls; how bless is gained is server-side (likely per comprehend).
- Open: whether 5158 also needs gold (no client display).

## 10. Implementation checklist

- [ ] Screen: PawnLevelUpFrame, PawnSpecialAbilityFrame, PawnAbilityConvertFrame
- [ ] Route 5158 level up
- [ ] Route 8455 comprehend
- [ ] Route 8456 replace
- [ ] Route 8580 convert
- [ ] Server message 116 after each route
- [ ] Server message 3 souls/diamonds
- [ ] Table `army.soldier_upgrade_log`; columns in `army.castle_reserve`
- [ ] Rule: `Types 1` soul costs, barracks gate
- [ ] Rule: characteristic unlock at level 10, roll weights, bless thresholds
- [ ] Test: level a family from 1 to 11 and verify troop template sync and characteristic grant
