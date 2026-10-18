# Steles: Ascensão (step up)

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/SteleSysManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/stele/StelesysModel.as` |
| AV | `decompiled/m14/scripts/stelesys/view/SteleSysAdvanceView.as` |
| V | `decompiled/m14/scripts/stelesys/` |

## 1. Overview

Tab 2 of the stele frame. Raising the step ("Grau") of a stele consumes `CostNum` copies of the same stele template at step `CostItemStep`. The new step raises the strength level cap (`StrengthLimit`), the number of refine lines (`BaptizeLimit`), the refine pool (`SkillMasterType`), the base stats and the passive skill, and changes the color (`Profile`: branco, verde, azul, roxo, laranja, vermelho). Help text: "O Nível de Estrelas da Estela determina o limite máximo do seu Grau" and "A Ascensão requer o consumo de um certo número de Estelas que cumpram os requisitos".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `AV` (`SteleSysAdvanceView`) | tab "Ascensão" | Target slot, preview of the stele at step+1, stat comparison (5 attributes from the step template), "Nível máximo:" (`stela.advance.title1`) and "Purificação máxima:" (`stela.advance.title2`) current -> next, required material text, counter `chosen/CostNum` (green "{0}/{1}" `stela.advance.ok`, red/green `stela.advance.no`), button `_advanceBtn` (style `ui.stelesys.stepDoBtn`, bitmap label), max flag when no next step | `SteleSysFrame` tab 2 | before a target is chosen, the grid shows all steles (`AV:423-430`); afterwards only `MOD.getSomeStepAndId(target)` (`MOD:106-126`) |
| `V/item/StelaStepChooseBoxItem.as` | | Target slot with switch button -> selection frame type 3 (`:68-71`) | `AV` | `nameStep` |
| `V/item/StelaAdvanceChooseItem.as` | | Preview of the stele at step+1 (`AV:368-382`) | `AV` | `nameStep`, tooltip |
| `V/item/StelesysAdvanceBoxItem.as` | "Equipado" (`stela.equip`) on equipped candidates | Candidate material, toggled on click; selecting beyond `CostNum` is rolled back (`:103-131`, `AV:258-295`) | grid | level, stars, color |
| Material hint `stela.advance.metrialTip` | key missing in `index/language.json` | Formatted with (`Rarity`, `CostItemStep`, colored `TemplateName`) (`AV:357-367`) | `AV` | |

## 3. Routes (client to server)

### R1. Step up a stele
- UI: step button `_advanceBtn` (`AV:215-248`).
- Client checks:
  1. Selecting a candidate without target: key `stela.advance.needChoose` (missing translation) (`V/item/StelesysAdvanceBoxItem.as:105-109`).
  2. Button enabled only when exactly `CostNum` candidates are chosen (`AV:277-286`); extra choices are reverted.
  3. Button hidden when `nextStepTempInfo == null` (max step, `AV:335-347`).
  4. If any chosen stele has `totalExp > 0` -> confirm "Os materiais para Ascensão incluem Estela(s) fortalecida(s). Deseja continuar?" (`stela.advance.tip`, `AV:224-243`).
  5. No level check: the client allows Ascensão below the level cap.
- Sender: `SteleSysManager.sendStep(targetId, ids)` (`MGR:154-162`).
- Route: client to server, 8664 (0x21d8) `C_STELA_CLIETN_OP`, `player.PlayerOpMsg`:
  - `op` (#1, INT32) = 3 (`OP_STEP`).
  - `id` (#5, INT32) = target stele id.
  - `ids` (#20, INT32, repeated) = consumed stele ids (length `CostNum`).
  - Unused: every other field (see `equip.md` R1).
- Expected response: 4280 `U_C_STELA_UPDATE` with the target (new `step`, same `level`, `exp`, `totalExp`, skills) and every consumed stele with `isExist = false`. Client `AV.updateHandler` plays the animation and refreshes (`AV:297-309`). Hero attribute push when the target is equipped (stats and, for pos 1, passive skill change).

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When |
|---|---|---|---|---|
| 4280 (0x10b8) | `U_C_STELA_UPDATE` | `stela.StelaMsg` / `StelaDataMsg` (fields in `equip.md` S1) | `SteleSysManager.__dataInfosHandler` (`MGR:76-131`) -> `AV.updateHandler` (`AV:297-309`) | Response to R1 |

Error codes: none. Assumption: failures are silent (or 126 `U_C_MSG`); note the client disables the button on click (`AV:222`) and re-enables it only through a later selection change, so the server should always answer success with 4280.

## 5. Rules and formulas

- Next step row: `StelaStepTemplates(templateId, step + 1)`; none when `step == StepLimit` (`decompiled/core_module/scripts/mvc/module/stele/StelesysInfo.as:153-171`).
- Valid materials (`MOD:106-126`): owned, exists, `id != target`, `templateId == next.CostItem` (always the same template in data), `step == next.CostItemStep`. The client also lists equipped copies.
- Exactly `next.CostNum` materials.
- Result: `step += 1`; `level`, `totalExp` and refine lines unchanged; materials deleted (their EXP and refine lines are lost).
- Step table (same for every template up to its `StepLimit`; `CostNum x step CostItemStep` copies required to reach the step):

| Step reached | Cost | `StrengthLimit` | `Profile` (color) | `BaptizeLimit` | `SkillMasterType` |
|---|---|---|---|---|---|
| 0 (base) | none | 5 | 1 branco | 2 | 13100 |
| 1 / 2 | 1 / 3 x s0 | 10 / 15 | 1 | 2 | 13100 |
| 3 / 4 / 5 / 6 | 5 / 10 / 20 / 20 x s0 | 20 / 25 / 30 / 35 | 2 verde | 2 | 13200 |
| 7 | 20 x s0 | 45 | 3 azul | 3 | 13300 |
| 8 / 9 / 10 | 3 / 3 / 4 x s3 | 55 / 65 / 75 | 3 | 3 | 13300 |
| 11 / 12 / 13 / 14 | 6 / 8 / 10 / 12 x s3 | 90 / 105 / 120 / 135 | 4 roxo | 4 | 13400 |
| 15 | 2 x s7 | 150 | 4 | 4 | 13400 |
| 16 .. 20 | 3, 4, 5, 6, 7 x s7 | 165 .. 225 (+15) | 5 laranja | 5 | 13500 |
| 21 .. 25 | 2, 4, 6, 8, 10 x s11 | 240 .. 300 (+15) | 6 vermelho | 5 | 13600 |

  `StepLimit` by rarity: 2 (1★), 6 (2★), 10 (3★), 15 (4★), 20 (5★), 25 (6★). Verified on templates 1101, 1201, 1301, 1401, 1501, 1601 of `raw/xml/tempinfos/StelaStepTemplates.xml`.
- Color names (`stela.check.step0..5`): branco, verde, azul, roxo, laranja, vermelho.

## 6. Templates

| File | Fields used |
|---|---|
| `raw/xml/tempinfos/StelaStepTemplates.xml` | `CostItem`, `CostItemStep`, `CostNum`, `StrengthLimit`, `BaptizeLimit`, `Profile`, stats, `PassiveSkills` |
| `raw/xml/tempinfos/StelaTemplates.xml` | `StepLimit`, `Rarity`, `TemplateName` |

## 7. Persistent state

Uses `steles.player_steles` (`equip.md` section 7) and the optional `steles.stele_operation_log` (`intensify.md` section 7). No new table.

## 8. Backend implementation notes

- Handler `steles::advance::handle_step_up` (8664 op 3).
- Validation order: target owned, not material, next step exists; `ids` distinct, count `== CostNum`; each owned, `!= target`, `template_id == CostItem`, `step == CostItemStep`; assumption: each `slot_pos = 0` (reject equipped materials).
- Transaction: lock target and materials, delete materials, `step = step + 1`, log.
- Pushes: 4280 (`opType = 3`) target + deleted materials; hero attributes if equipped; passive skill changes for pos 1.
- When `BaptizeLimit` grows (step 7, 11, 16), the new refine line starts empty (skill 0). Assumption, see below.

## 9. Open questions and assumptions

- Assumption: no level requirement (client sends regardless of `level == StrengthLimit`), although the help text implies reaching the cap first. Decide: follow client (no check).
- Assumption: equipped copies cannot be consumed; the client shows them with "Equipado" and would allow it. Alternative: auto-unequip.
- Assumption: new refine lines added by a higher `BaptizeLimit` stay empty until the next Purificação.
- Open: whether consumed steles' EXP is partially refunded (client warning implies it is lost).

## 10. Implementation checklist

- [ ] `steles::advance::handle_step_up` with validation above.
- [ ] Step table driven by `StelaStepTemplates`.
- [ ] 4280 push with target and deletions.
- [ ] Hero attributes and core passive skill refresh.
- [ ] Screen: candidate list = same template at `CostItemStep`, counter, confirm when strengthened materials.
- [ ] Tests: wrong template rejected; wrong step rejected; wrong count rejected; max step rejected; target listed in `ids` rejected; strengthened materials consumed after confirm; equipped material rejected.
