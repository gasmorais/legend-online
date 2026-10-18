# Steles: Fortalecimento (strengthen)

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/SteleSysManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/stele/StelesysModel.as` |
| INFO | `decompiled/core_module/scripts/mvc/module/stele/StelesysInfo.as` |
| PCATE | `decompiled/core_module/scripts/yishi/datas/templates/cate/StelaPropertyTemplateCate.as` |
| IV | `decompiled/m14/scripts/stelesys/view/SteleIntensifyView.as` |
| V | `decompiled/m14/scripts/stelesys/` |

## 1. Overview

Tab 1 of the stele frame. The player picks a target stele (not at its level cap), then selects strengthening materials: quantities of material rows (template 2101 "Estela de fortalecimento - Verde", 1 EXP each) and/or whole steles that are not equipped. The server adds EXP, raises the level up to the current step's `StrengthLimit`, deletes the consumed steles and decreases the material quantities. Help text: "Os jogadores podem consumir outras Estelas como materiais para fortalecer a Estela principal" and "O Grau da Estela determina o limite máximo do nível de fortalecimento".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `IV` (`SteleIntensifyView`) | tab "Fortalecimento" | Target slot, level, EXP progress bar with preview, current and next attributes (Attack, Defence, MagicAttack, MagicDefence, Live), material grid (paged by 40), filter menu, buttons strengthen (`_intensifyBtn`, style `ui.stelesys.intensifyDoBtn`, bitmap label) and one-click choose (`_oneKeyBtn`, style `stela.intensify.oneKeyBtn`) | `SteleSysFrame` tab 1 | target `currIntensifyInfo`; grid = material rows then `noUpStelaList` minus target, filtered and sorted ascending (`IV:159-183`); counter "chosen/total" |
| `V/item/StelesysIntensifyBox.as` | | Target slot with switch button -> selection frame type 2 (`:76-79`) | `IV` | `nameStep` |
| `V/item/StelesysBackBoxItem.as` | "Possui: {0}" (`stela.has`), "Usar: {0}" (`stala.use`) | Material row cell; click opens `StelaUseFrame` (`:88-102`) | grid | owned quantity (`exp`), chosen quantity (`tempUse`) |
| `V/StelaUseFrame.as` | "Divisão de itens" (`bag.view.SpliteItemFrame.title`) | Quantity input clamped to the remaining EXP need and to the owned quantity (`:88-122`) | material cell | number, "Confirmar" |
| `V/item/StelesysMetrialBox.as` | "Equipado" never shown here (equipped steles are excluded) | Stele cell toggled on click (`:92-123`) | grid | level, stars, color |
| Flags `asset.stelesys.canTensifyFlg` / `fullIntensifyFlg` | | Shown instead of the buttons when `level == StrengthLimit`: "needs Ascensão" when a next step exists, "full" otherwise (`IV:572-589`) | `IV` | |

## 3. Routes (client to server)

### R1. Strengthen a stele
- UI: strengthen button `_intensifyBtn` (`IV:352-393`).
- Client checks, in order:
  1. Selecting any material requires a target: "Selecione a Estela para o avanço" (`stela.intensify.needChoose`, `V/item/StelesysMetrialBox.as:99-103`, `V/item/StelesysBackBoxItem.as:91-95`).
  2. Target at cap: "Atingiu o limite máximo do nível de fortalecimento atual!" (`stela.intensifyMax`, `V/item/StelesysMetrialBox.as:104-108`); the buttons are hidden at cap (`IV:572-589`).
  3. Further selection blocked once the accumulated EXP reaches the need: "A experiência fornecida pelo material atingiu o limite do nível de fortalecimento atual." (`stela.intensify.full`, `MOD:415-456`, `V/item/StelesysMetrialBox.as:109-117`). The last selected item may overshoot.
  4. Any chosen stele with `Rarity >= 4` -> confirm "Os materiais de fortalecimento incluem Estelas de quatro ou mais estrelas, quer confirmar?" (`stela.intensify.starTip`, `IV:361-380`).
  5. Nothing chosen: "Selecione o material de fortalecimento" (`stela.intensify.needMetrail`, `IV:384-391`).
- Sender: `SteleSysManager.sendIntensify(targetId, useMetrial, ids)` (`MGR:143-152`).
- Route: client to server, 8664 (0x21d8) `C_STELA_CLIETN_OP`, `player.PlayerOpMsg`:
  - `op` (#1, INT32) = 2 (`OP_STRENGTH`).
  - `id` (#5, INT32) = target stele id.
  - `param1` (#15, STRING) = material usage `"<materialRowId>,<count>|<materialRowId>,<count>"`, empty when none (`V/view/StelesysIntensifyBagView.as:56-80`).
  - `ids` (#20, INT32, repeated) = ids of whole steles consumed.
  - Unused: every other `PlayerOpMsg` field (see `equip.md` R1).
- Expected response: 4280 `U_C_STELA_UPDATE` with (a) the target (new `level`, `exp`, `totalExp`), (b) each consumed stele with `isExist = false`, (c) each touched material row (`step = -1`, `exp` = new quantity). No dedicated result message; the client refreshes via `STELE_SYS_UPDATA` (`IV:513-524`). Then the hero attribute push if the target is equipped.

### R2. One-click choose (client only)
`_oneKeyBtn` -> `MOD.autoIntensifyChoose` (`MOD:458-520`): keeps already chosen steles, then uses material rows unit by unit (sorted by template id), then the not yet chosen steles of the current page in order, until the accumulated EXP reaches the need. No route; the player then presses the strengthen button.

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When |
|---|---|---|---|---|
| 4280 (0x10b8) | `U_C_STELA_UPDATE` | `stela.StelaMsg` (`opType` #1, `datas` #2 repeated `StelaDataMsg`; full field list in `equip.md` S1) | `SteleSysManager.__dataInfosHandler` (`MGR:76-131`) -> `IV.updateHandler` (`IV:513-524`) refreshes progress, attributes and the grid (removes non-existing entries, `MOD:128-143`) | Response to R1 |

Error codes: none. Assumption: on failure the server sends nothing (or a 126 `U_C_MSG` notice); the client simply keeps its selection.

## 5. Rules and formulas

- Target eligibility: owned, `step >= 0`, `level < StrengthLimit(step)` (selection frame type 2 filters `isCurrMaxLv`, `V/SteleSwitchFrame.as:81-90`). Equipped targets are allowed.
- Material steles: owned, not the target, not equipped (`noUpStelaList`, `MOD:77-90`).
- Material rows: quantity `count <= owned quantity` (`V/StelaUseFrame.as:114-121`).
- EXP gained (`MOD:415-456`):
  - per material unit: `StelaTemplates.Exp` of the material template (2101: 1);
  - per stele: `totalExp + StelaTemplates.Exp` of its template (base 10, 20, 30, 40, 50, 60 by rarity 1..6).
- Need to reach the cap: `needExp = StelaPropertyTemplates.Exp(templateId, StrengthLimit(step)) - totalExp` (`MOD:393-408`).
- New level: `PCATE.getCeilLvByExp(templateId, level, totalExp + gained)` (`PCATE:40-69`) = highest level `L` with `Exp(L) <= totalExp`, capped at `StrengthLimit(step)` (assumption: cap enforced by the server; the client preview does not cap).
- `exp` sent back = `totalExp - Exp(level)`.
- Overflow: Assumption: `totalExp` is capped at `Exp(StrengthLimit)`; overflow EXP is lost (the client warns with `stela.intensify.full`). Open question below.
- Consumed steles lose their refine lines and steps (deleted).
- No gold or item cost besides materials (no cost shown client side).
- Example: 1101 step 0 (`StrengthLimit` 5, `Exp(5)` = 200) from level 0 needs 200 EXP, e.g. 200 green materials or 20 one-star steles at level 0 (10 EXP each) minus overshoot.

## 6. Templates

| File | Fields used |
|---|---|
| `raw/xml/tempinfos/StelaTemplates.xml` | `Exp` (EXP value when consumed), `Rarity` (four-star warning), `MasterType` 2 for material rows (`decompiled/core_module/scripts/yishi/datas/templates/cate/StelaTemplateCate.as:39-51`) |
| `raw/xml/tempinfos/StelaStepTemplates.xml` | `StrengthLimit` |
| `raw/xml/tempinfos/StelaPropertyTemplates.xml` | `Exp` (cumulative per level), stats for preview |
| `raw/xml/tempinfos/StelaResistTemplates.xml` | resist bonuses unlocked at levels 10, 20, ... (preview only) |

Max level per rarity: 15 (R1), 35 (R2), 75 (R3), 150 (R4), 225 (R5), 300 (R6); total EXP to max for templates 1101, 1201, 1301, 1401, 1501, 1601: 672, 1745, 4289, 10740, 21409, 54424.

## 7. Persistent state

Uses `steles.player_steles` and `steles.player_stele_materials` (`equip.md` section 7). Optional audit table:

```sql
CREATE TABLE steles.stele_operation_log (
    log_id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    op            SMALLINT NOT NULL CHECK (op BETWEEN 1 AND 8),  -- 8664 op, 8 = box open
    stele_id      INTEGER,
    consumed_stele_ids INTEGER[] NOT NULL DEFAULT '{}',
    consumed_materials JSONB NOT NULL DEFAULT '[]',              -- [{material_id, count}]
    before_state  JSONB,
    after_state   JSONB,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX stele_operation_log_player_idx ON steles.stele_operation_log (player_id, created_at DESC);
```

## 8. Backend implementation notes

- Handler `steles::intensify::handle_strengthen` (8664 op 2).
- Validation order: parse `param1` (reject malformed pairs, duplicate ids, `count <= 0`); load target `FOR UPDATE`; target owned, not material, `level < StrengthLimit`; each `ids` entry distinct, owned, `!= target`, `slot_pos = 0`; each material row owned with enough quantity; at least one material.
- Transaction: compute gained EXP; update target `total_exp`, `level`; delete consumed steles; decrement material quantities; write log row.
- Pushes: 4280 (`opType = 2`) with target, deleted steles (`isExist = false`), material rows; then hero attributes when the target is equipped.
- No timers, no battle.

## 9. Open questions and assumptions

- Assumption: overflow EXP above the step cap is discarded (not banked for the next step).
- Assumption: equipped steles cannot be consumed (client never offers them).
- Open: whether consuming steles with refine lines or steps refunds anything (nothing visible client side).
- Note: the pt-BR string for `stela.intensify.needChoose` says "para o avanço" although it is used in Fortalecimento; keep verbatim.

## 10. Implementation checklist

- [ ] `param1` parser `id,count|id,count`.
- [ ] `steles::intensify::handle_strengthen` with validation order above.
- [ ] EXP formula (material units and steles `totalExp + Exp`).
- [ ] Level recomputation via cumulative `Exp`, capped at `StrengthLimit`.
- [ ] 4280 push with target, deletions and materials.
- [ ] Hero attribute refresh when target equipped.
- [ ] Screen: progress bar `exp / (Exp(level+1) - Exp(level))`, cap flags, material quantity dialog.
- [ ] Tests: material only; steles only; mixed; target at cap rejected; consuming equipped stele rejected; consuming the target itself rejected; insufficient material quantity rejected; overshoot capped; multi-level jump (e.g. 0 to 5).
