# Formulas: notebook, solo formulas, starting a group formula, catalysts

Module `formulas` of feature `alchemy`. Covers the "Fabricar" tab notebook ("Combinação Singular" and "Combinação em grupo" lists in six categories), the material panel, producing a solo formula and doing one step of an own group formula (both op 2), the catalyst and the doubling chance, and the rewards (bag items plus Alchemy Points).

Path aliases:

| Alias | File |
|---|---|
| AM | `decompiled/core_module/scripts/yishi/manager/AlchemicalManager.as` |
| AMOD | `decompiled/core_module/scripts/mvc/module/alchemical/AlchemicalModel.as` |
| AFI | `decompiled/core_module/scripts/mvc/module/alchemical/AlchemicalMakeFormulaInfo.as` |
| V | `decompiled/m14/scripts/alchemical/` |
| MV | `decompiled/m14/scripts/alchemical/makeview/` |

## 1. Overview

- 50 formulas (`AlchemyFormulaTemplates.xml`). `Type` 2 = solo ("Combinação Singular", one step, `NeedItem` = "id:count,id:count,..."). `Type` 1 = group ("Combinação em grupo", `NeedItem` = 3 or 4 steps separated by "|", each step done by a different player, see [cooperation.md](cooperation.md)).
- `RewardType` 1..6 is the category: "Equipamento", "Brasão Sagrado", "Arma Divina", "Titã", "Arma Sagrada", "Proteção da Alma" (`Alchemical.chatInvite.text1..6`).
- `Reward` = "id:count,..."; the entry `700000:N` is N Alchemy Points (hidden from the reward icons, `AFI:96-115`); other entries are bag items (for example 2129838 "Coração do Santo", 212018 "Pedra dos Deuses", 208063 "Esfera do Poder de Espírito").
- A formula is usable when `score >= NeedScore` (`AFI:163-170`).
- Catalyst "Catalisador Misterioso" (701000, in the alchemy storage) can be added to a step: chance to double the produced items (item description: "adicionado 3 delas poderá dobrar").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/AlchemicalMakeView.as` | (Fabricar tab) | material panel (left), storage grid (bottom), right panel tabs "notebook" and "cooperation" | Frame tab 1 | selects the cooperation tab when `selectFormulaInfo` is set (op 8 path) (`:42`) |
| `MV/AlchemicalMakeNoteBookView.as` | buttons "Combinação em grupo" (index 0, `modelType` 1) and "Combinação Singular" (index 1, `modelType` 2); header score (see [core.md](core.md)) | category accordion | right panel tab 0 | 6 `AlchemicalMakeFormulaBtnItem` (`typeCount` 6, `:52,95-111`) |
| `MV/AlchemicalMakeFormulaBtnItem.as` | category title button `AlchemicalMakeFormulaBtnItem.titleBtn{1..6}` | expands the formulas of `RewardType = btnType` and `Type = modelType` | notebook | list sorted unlocked first then by `Id` (`AMOD:161-179`, `:98-138`) |
| `MV/AlchemicalMakeNoteFormulaItem.as` | formula name; locked tip "Pontos necessários:{0}" | select a formula | category list | name frame 1 (unlocked, not enough materials), 2 (unlocked, materials for at least one step), 3 (locked) (`:64-87,104-154`) |
| `MV/AlchemicalMakeMaterialView.as` | step buttons "Passos {0}" (or "Completado"); make button tip "Criar" (solo) or "Entregar/Enviar Convite" (group) | up to 4 needed materials "have/need", catalyst slot with toggle, up to 3 reward icons, step selector, make button | Fabricar tab | `getNeedItemArrByIndex(step)`, `rewardItemArr`, storage counts (`:195-318`) |
| `MV/AlchemicalNeedMaterialItem.as` | "{have}/{need}" green or red | one material | MaterialView | (`:31-47`) |

## 3. Routes (client to server)

### C1. Produce a solo formula (op 2, `Type` 2)
- UI: make button (`MV/AlchemicalMakeMaterialView.as:154-188`) with a notebook formula selected (`shareUid == -1`, `Type` 2).
- Client checks:
  - a formula is selected;
  - 2 s anti double click, else "Clique excessivo, tente novamente";
  - button enabled only when every material of the formula is available in the storage and `isOpen` (`score >= NeedScore`) (`:281-297`);
  - catalyst toggle forced off when the storage has no 701000 (`:320-356`).
- Sender: `AM.sendAlchemicalSelfFormula(formulaId, isAddCatalyst)` (`AM:193-205`), `childIndex` not set.
- Route: C>S 9661 (0x25bd) `C_ALCHEMY_WORKSHOP_OP`, `AlchemyWorkshopMsg`: `op (#1)` = 2; `formulaId (#4, INT32)`; `isAddCatalyst (#6, BOOL)`.
- Response: 461 `op` 2 with `opResult` (0 ok, 3 LACK_ITEM, 6 LACK_SCORE, 1 other), `alchemyItem` (consumed materials and catalyst with new absolute counts), `score`/`cycleScore` (points), `mine` when the score unlocks or upgrades mines, `sharedFormula` (full visible list, required because op 2 replaces the list). Bag item pushes for the rewards (inventory feature).

### C2. Do a step of an own group formula (op 2, `Type` 1)
- UI: make button with a notebook group formula selected and a step button chosen (`MV/AlchemicalMakeMaterialView.as:180-183`).
- Client checks: as C1, using only the materials of the selected step (`getNeedItemArrByIndex(step - 1)`); `isOpen` required.
- Sender: `AM.sendAlchemicalSelfFormula(formulaId, isAddCatalyst, step)` where `step = stepGroup.selectIndex + 1` (1..4) (`AM:193-205`).
- Route: 9661, `op` = 2, `formulaId (#4)`, `isAddCatalyst (#6)`, `childIndex (#7, INT32)` = step number.
- Server: consume that step's materials (and one catalyst), create a new shared formula (`shareUid`, `startTime = now`) owned by the player with this step done, see [cooperation.md](cooperation.md).
- Response: 461 `op` 2 with `alchemyItem` and `sharedFormula` (now containing the new formula). No reward yet (rewards are paid on completion).

The client keeps the notebook selection after the response (`AM:140-150` only reselects cooperation formulas), so the player goes to the "cooperation" tab to see and invite.

## 4. Server messages (server to client)

### S1. 461 `U_C_ALCHEMY_WORKSHOP_OP` (definition in [core.md](core.md) S1)
Fields used: `opResult (#2)`, `score (#10)`, `cycleScore (#11)`, `mine (#12)`, `sharedFormula (#13)`, `alchemyItem (#14)`.

Client reaction: `ALCHEMICAL_ITEM_UPDATE` refreshes the storage grid; `ALCHEMICAL_FORMULA_UPDATE` and `ALCHEMICAL_SELFINFO_UPGATE` refresh the material panel, the notebook header and the formula name colors. No error text is shown for non zero `opResult`.

Bag rewards are delivered with the inventory item update pushes ([inventory](../inventory/README.md)); a chat/system "item obtained" message is optional.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | `score >= NeedScore` | `AFI:163-170` |
| Materials | solo: all pairs of `NeedItem`; group step k: the k-th "|" segment | `AFI:68-94` |
| Catalyst use | consumes 1 catalyst 701000 from the storage per request with `isAddCatalyst` | `MV/AlchemicalMakeMaterialView.as:320-356` |
| Doubling chance (solo) | `alchemyworkshop_double_percent` index 0 = 80% when a catalyst was added | `ConfigInfos.xml` "80,50,80,100,100" = solo, 1, 2, 3, 4 catalysts |
| Doubling chance (group) | by number of catalysts added in all steps: 1 = 50%, 2 = 80%, 3 = 100%, 4 = 100%; none = 0% | same; item description "adicionado 3 delas poderá dobrar" |
| Doubled output | item counts x2 (assumption: points are not doubled) | assumption |
| Points | `700000:N` from `Reward`: solo 100 (normal) or 150 (efficient), group 300 or 400 | `AlchemyFormulaTemplates.xml` |
| Reward items | every other `Reward` pair goes to the bag | `AFI:96-115` |
| Category list | `formulaTempDic[RewardType + "_" + Type]` | `AMOD:111-119` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `AlchemyFormulaTemplates.xml` | `AlchemyFormulaTemplate` (50 rows) | `Id`, `Name`, `Type` (1 group, 2 solo), `RewardType` 1..6, `NeedItem`, `Reward`, `NeedScore` |
| `ConfigInfos.xml` | `alchemyworkshop_double_percent` "80,50,80,100,100" | doubling |
| `ItemTempInfos.xml` | materials 702xxx, catalyst 701000, reward items | icons and names |

## 7. Persistent state

No new table for solo formulas: storage (`alchemy.storage_items`) and score (`alchemy.workshop_state`) from [core.md](core.md); group starts insert into `alchemy.shared_formulas` and `alchemy.shared_formula_steps` ([cooperation.md](cooperation.md)).

Optional audit table:

```sql
CREATE TABLE alchemy.production_logs (
  log_id          BIGSERIAL PRIMARY KEY,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  formula_id      INTEGER NOT NULL,
  share_uid       INTEGER,                              -- NULL for solo formulas
  step_index      SMALLINT,                             -- NULL for solo formulas
  catalyst_added  BOOLEAN NOT NULL,
  doubled         BOOLEAN NOT NULL DEFAULT false,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX production_logs_player_idx ON alchemy.production_logs (player_id, created_at DESC);
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9661 `op` 2, template `Type` 2 | `alchemy::formulas::handle_produce_solo` |
| 9661 `op` 2, template `Type` 1 | `alchemy::formulas::handle_start_group` (delegates to `alchemy::cooperation::create`) |

- Validation order (solo): `vocation_grades > 0` -> formula exists -> `score >= NeedScore` (`opResult` 6) -> materials in storage (`opResult` 3) -> catalyst present when requested (`opResult` 3) -> bag space for the reward items (assumption: `opResult` 1 when full, or send by mail).
- Transaction: consume materials and catalyst, roll doubling, add bag items, `alchemy::core::add_score(N)`, write the log, count quest condition 64 and Funny condition 21; commit; then send 461 `op` 2 and the bag pushes.
- Group start: same validation using step `childIndex` (1..`stepCount`, else `opResult` 1); create the shared formula with this step; no reward and no points until completion.
- The response must carry `sharedFormula` (full visible list) because `op` 2 replaces the cooperation list.

## 9. Open questions and assumptions

- Assumption: doubling applies to item counts only, not to Alchemy Points.
- Assumption: a group formula started by the player counts its catalysts toward the group doubling chance.
- Open: whether a step done with op 2 also gives partial points to the starter (default: rewards only at completion, see [cooperation.md](cooperation.md)).
- Open: behavior when the bag is full (default: refuse with `opResult` 1 before consuming materials).
- Open: whether a player may start several group formulas at once (default: allowed, each gets its own `shareUid`).

## 10. Implementation checklist

- [ ] Screens (client ready): `AlchemicalMakeView`, `AlchemicalMakeNoteBookView`, `AlchemicalMakeFormulaBtnItem`, `AlchemicalMakeNoteFormulaItem`, `AlchemicalMakeMaterialView`, `AlchemicalNeedMaterialItem`.
- [ ] Route 9661 op 2 solo: unlock, materials, catalyst, doubling, bag rewards, points.
- [ ] Route 9661 op 2 group start: step materials, shared formula creation, list in response.
- [ ] Doubling table from `alchemyworkshop_double_percent`.
- [ ] Hooks: quest condition 64, Funny condition 21.
- [ ] Tests: formula 102008 at score 0 consumes 75x 702101 + 30x 702202 and gives 16x 2129819 + 100 points; locked formula returns `opResult` 6; missing materials return 3 and change nothing; catalyst consumed even when not doubled; op 2 on a Type 1 formula with `childIndex` 2 creates a shared formula with step 2 done.
