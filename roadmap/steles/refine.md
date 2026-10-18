# Steles: Purificação (refine)

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/SteleSysManager.as` |
| RV | `decompiled/m14/scripts/stelesys/view/SteleSysRefineView.as` |
| V | `decompiled/m14/scripts/stelesys/` |

## 1. Overview

Tab 3 of the stele frame. Each stele has up to 5 refine lines (`skill1..skill5`), each one a random attribute skill. Purificação spends "Pedra de Purificação da Estela" (7110001) to roll new values for every unlocked line; lines can be locked with "Pedra de Bloqueio da Estela" (7110002) so they are kept. The roll is stored as a pending result; the player accepts it (replace) or ignores it. Help text: "A Estela pode ser purificada consumindo uma certa quantidade de pedra de purificação. Quanto maior o grau, maior o limite de dos atributos de purificação" and "A trava da purificação pode travar um determinado atributo de ser purificado".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RV` (`SteleSysRefineView`) | tab "Purificação" | Target slot, colored name `TemplateName +step`, current lines with lock toggles, new (pending) lines, stone counters, buttons refine (`_refineBtn`) and replace (`_newBtn`) | `SteleSysFrame` tab 3 | current lines `skill1..5` > 0 (`RV:222-252`); pending lines from 4281 (`RV:254-281`); owned 7110002 count (`RV:129-133`); owned 7110001 / `BaptizeCostNum` (`RV:135-147`) |
| `V/item/StelaReineBoxItem.as` | | Target slot with switch button -> selection frame type 4 (`:56-59`) | `RV` | icon, tooltip |
| `V/item/StelesysRefineItem.as` | | Current line name (`SkillTempInfos.TemplateName`, e.g. "Ataque +50 (1 estrela)") + lock toggle (`stela.RefreshAttributeBtn`) (`:17-44`) | `RV` | |
| `V/item/StelesysNewRefineItem.as` | | Pending line name, plays an effect when changed (`:47-64`) | `RV` | |

## 3. Routes (client to server)

### R1. Load the pending result when a target is chosen
- UI: choosing a stele in the selection frame type 4 -> `RV.changeHandler` (`RV:283-295`): enables refine, shows lines, resets locks, then sends.
- Sender: `SteleSysManager.sendGetRefine(id)` (`MGR:174-181`).
- Route: client to server, 8664 (0x21d8) `C_STELA_CLIETN_OP`, `player.PlayerOpMsg`: `op` (#1, INT32) = 5 (`OP_VIEW_REFRESH`), `id` (#5, INT32) = stele id. Other fields unused.
- Expected response: 4281 `U_C_STELA_REFRESH` with `opType = 5`, `stelaId`, `skills` = pending lines. Assumption: send it only when a pending result exists (the client enables the replace button on any opType 5, `RV:207-214`).

### R2. Refine (roll)
- UI: refine button `_refineBtn` (`RV:297-333`).
- Client checks: the lock flags array has 5 entries, entry `i` = 1 when the i-th displayed current line is locked (displayed lines are the non-zero skills in order, `RV:229-243`, `RV:302-325`); if the number of locks equals `BaptizeLimit` -> "Sem atributos purificáveis, desbloqueie primeiro" (`stela.refine.allLock`, `RV:326-330`). No client check of stone counts.
- Sender: `SteleSysManager.sendRefine(id, flags.join(","))` (`MGR:164-172`).
- Route: 8664 (0x21d8), `PlayerOpMsg`:
  - `op` (#1, INT32) = 4 (`OP_REFRESH`).
  - `id` (#5, INT32) = stele id.
  - `param1` (#15, STRING) = `"l1,l2,l3,l4,l5"`, each 0 (reroll) or 1 (locked).
  - Unused: every other field.
- Expected response: 115 (0x0073) `U_C_BAG_MOVE_UPDATE` for consumed 7110001 / 7110002 (inventory feature), then 4281 with `opType = 4`, `stelaId`, `skills` (5 entries, locked ones equal to the current values). Client shows them as new lines and enables replace (`RV:207-214`, `RV:254-281`).

### R3. Accept (replace) the pending result
- UI: replace button `_newBtn` (`RV:335-340`), enabled only after a 4281 opType 4 or 5.
- Sender: `SteleSysManager.sendReplaceRefine(id)` (`MGR:183-190`).
- Route: 8664 (0x21d8), `PlayerOpMsg`: `op` (#1, INT32) = 6 (`OP_REPLACE`), `id` (#5, INT32) = stele id.
- Expected response, in this order: 4280 `U_C_STELA_UPDATE` with the stele and its new `skill1..5` (the client reads them from the shared object), then 4281 with `opType = 6` which hides the pending box and redraws current lines (`RV:215-218`). Hero attribute push when equipped.

## 4. Server messages (server to client)

### S1. 4281 (0x10b9) `U_C_STELA_REFRESH`
- Message `stela.StelaRefreshMsg`:
  - `opType` (#1, INT32): 4 rolled result, 5 pending result on view, 6 replaced.
  - `stelaId` (#2, INT32): stele id; the client ignores results for another stele (`RV:259-262`).
  - `skills` (#3, INT32, repeated): up to 5 refine skill ids, 0 = empty line; empty for opType 6.
- Receiver: `SteleSysManager.__refineInfosHandler` (`MGR:61`, `MGR:64-74`) -> notification `STELE_SYS_REFINE` -> `RV.upDataHandler` (`RV:198-220`).
- Client reaction: 4 or 5 show pending lines and enable replace; 6 hides pending lines and redraws current lines.

### S2. 4280 (0x10b8) `U_C_STELA_UPDATE`
Fields in `equip.md` S1. Sent after R3 with the updated stele (`opType = 6` assumption).

Error codes: none. Assumption: failures (not enough stones, no pending result) are silent or use 126 `U_C_MSG`.

## 5. Rules and formulas

- Number of lines = `BaptizeLimit` of the current step: 2 (steps 0..6), 3 (7..10), 4 (11..15), 5 (16..25).
- Cost per roll: `BaptizeCostNum` x item `BaptizeCostItem` (always 7110001 "Pedra de Purificação da Estela"). `BaptizeCostNum` = 5 x rarity x tier, tier = 1 (steps 0..2), 2 (3..6), 3 (7..10), 4 (11..15), 5 (16..20), 6 (21..25); e.g. 1101: 5; 1301 step 7: 45; 1601 step 25: 180.
- Lock cost: item 7110002 "Pedra de Bloqueio da Estela" (`RV:35`, `RV:129-133`). Assumption: 1 stone per locked line per roll (the client only displays the owned count).
- Pool: `SkillTempInfos` rows with `MasterType == StelaStepTemplates.SkillMasterType` of the current step (13100 .. 13600). Each pool has 8 attribute kinds (`SonType` 1 Ataque/Attack, 2 Defesa/Defence, 3 Magia/MagicAttack, 4 Resistência/MagicDefence, 5 Vida/Live, 6 Crítico/ForceHit, 7 Bloqueio/Parry, 8 Penetração/Penetrate) x `Grades` 1..N stars, N = 10, 15, 20, 25, 30, 35 for 13100..13600. Value = base x grade from `SkillPropertyTempInfos` (Ataque base 50, 60, 70, 80, 90, 100; Vida base 300, 360, 420, 480, 540, 600).
- Roll: assumption, each unlocked line independently draws a uniform `SonType` and a grade (weights unknown, not in client data); locked lines keep their skill id; lines beyond `BaptizeLimit` stay 0.
- A new roll overwrites the previous pending result. Assumption: the pending result survives logout and step changes; it is discarded when the stele is consumed.
- Lines contribute attributes through `SkillPropertyTempInfos` (`decompiled/core_module/scripts/mvc/module/stele/StelesysInfo.as:306-326`).

## 6. Templates

| File | Fields used |
|---|---|
| `raw/xml/tempinfos/StelaStepTemplates.xml` | `BaptizeCostItem`, `BaptizeCostNum`, `BaptizeLimit`, `SkillMasterType` |
| `raw/xml/tempinfos/SkillTempInfos.xml` | refine skills: `TemplateId` (`13` + tier digit + 2 digit `SonType` + 2 digit grade, e.g. 1310101), `TemplateName` (pt-BR line text), `MasterType`, `SonType`, `Grades` |
| `raw/xml/tempinfos/SkillPropertyTempInfos.xml` | attribute values per skill id |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 7110001 "Pedra de Purificação da Estela" (SonType 711, `Property1` 1), 7110002 "Pedra de Bloqueio da Estela" (SonType 711, `Property1` 2) |

## 7. Persistent state

```sql
CREATE TABLE steles.pending_refines (
    stele_id      INTEGER PRIMARY KEY REFERENCES steles.player_steles(stele_id) ON DELETE CASCADE,
    player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    skill_ids     INTEGER[] NOT NULL CHECK (cardinality(skill_ids) = 5),
    locked_mask   SMALLINT NOT NULL DEFAULT 0 CHECK (locked_mask BETWEEN 0 AND 31),
    rolled_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX pending_refines_player_idx ON steles.pending_refines (player_id);
```

Current lines are `steles.player_steles.refine_skill_ids` (`equip.md`). Stones are inventory items (`inventory.items`, assumption from the shared inventory model).

## 8. Backend implementation notes

- `steles::refine::handle_view_pending` (op 5): stele owned; if a row exists in `pending_refines`, push 4281 opType 5.
- `steles::refine::handle_roll` (op 4):
  1. Parse `param1` into 5 flags (reject malformed).
  2. Stele owned, not material; current step template loaded.
  3. Map flags to line indexes: flag `i` refers to the i-th non-zero current line (client compaction); count locks; reject when locks `>= BaptizeLimit`.
  4. Check and consume `BaptizeCostNum` x 7110001 and `locks` x 7110002 (assumption) in one transaction.
  5. Roll unlocked lines from the pool; upsert `pending_refines`.
  6. Push 115 (bag) and 4281 opType 4.
- `steles::refine::handle_replace` (op 6): pending row exists for the stele; copy to `refine_skill_ids`; delete pending; push 4280 then 4281 opType 6; hero attributes if equipped.
- RNG must be server side and auditable (log rolls in `steles.stele_operation_log`).

## 9. Open questions and assumptions

- Assumption: lock stone cost 1 per locked line per roll.
- Assumption: uniform probabilities for attribute kind and grade (real weights unknown).
- Assumption: rerolled lines can repeat kinds already present.
- Open: whether opType 5 should be sent with empty `skills` when nothing is pending (client would enable a useless replace button).
- Open: whether refine is allowed on steles with `BaptizeLimit` lines all empty (first roll); assumed yes.

## 10. Implementation checklist

- [ ] Table `steles.pending_refines`.
- [ ] Pool index by `SkillMasterType` from `SkillTempInfos`.
- [ ] Op 5 handler and 4281 opType 5.
- [ ] Op 4 handler: flag mapping, lock limit, stone consumption, roll, 4281 opType 4, bag push.
- [ ] Op 6 handler: apply, 4280 before 4281 opType 6, hero refresh.
- [ ] Screen checks: stone counters, all-locked message, replace button state.
- [ ] Tests: roll without stones rejected; all lines locked rejected; locked lines preserved; replace without pending rejected; pending overwritten by new roll; lines count follows `BaptizeLimit` after Ascensão.
