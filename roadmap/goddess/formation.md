# Goddess formation ("Formação da Deusa")

Module `formation`. Five formation positions, one per goddess, each with its own level 0..50 raised with "Marca da Terra" (212034). Every position adds "Anti-resistência das Deusas" and lets the player (hero) inherit a per mille share of that goddess's final stats. When all five positions reach 5, 15, 30 and 50 a formation skill improves the goddess dance skill.

Path aliases:

| Alias | File |
|---|---|
| GM | `decompiled/core_module/scripts/managers/GodDessManager.as` |
| GFP | `decompiled/m5/scripts/goddess/page/GoddessFormationPage.as` |
| GFC | `decompiled/m5/scripts/goddess/item/GoddessFormationCard.as` |
| GFL | `decompiled/m5/scripts/goddess/item/GoddessFormationSelectList.as` |
| GFI | `decompiled/core_module/scripts/mvc/module/goddess/GoddessFormationInfo.as` |

Opcode 5191 and push 177 are documented in `goddess.md`; this file covers ops 6 and 7 and `GoddessMsg.formations`.

## 1. Overview

- Positions `formationId` 1..5. In this client the position index is also the goddess bound to it: the page builds a default `GoddessFormationInfo` with `templateId = position` when no record exists (`GFP:408-424`), and the per position share uses `getGoddessInfoByFormationIndex(position)`, which reads the goddess with `templateId == position` (`GFP:441-444`, `GM:153-161`).
- Op 6 (assign a goddess to a position) exists in the manager and in `GFL`, but `GFL` is never instantiated by any class (the only `_checkListView` field in `GFC` is never assigned), so the assign UI is dead code. Implement op 6 for completeness.
- Max level 50 (`GFP:136`, template rows 1..50).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `GFP` | tab "Formação" (index 4), "Elevação da formação" | 5 cards, selected card detail, upgrade with "Marca da Terra" | `GodDessFrame` tab 4 (needs `VersionSwitch.GODDESS_FORMATION`) | totals: "Anti-resistência das Deusas: {0}" = sum of `ReduceResi` of all positions; "Ataque do jogador:", "Defesa física:", "Defesa mágica:", "Vida do jogador:" = sum of `Permillage/1000 * goddess stat` (`GFP:431-451`); selected card: "Nv.", exp `gradeGp/next.NeedGp`, current/next "Anti-resistência das Deusas +{0}", "Jogador herda {0}% dos atributos da Deusa atual" (`Permillage/10`) (`GFP:452-508`); at 50: "Já está cheio", "Esta posição já está cheia", "MAX"; 4 skill icons grey until `min(level of all positions) >= MinLevel` (`GFP:260-284`); hero avatar (`GFP:340-376`) |
| `GFC` | "Nv.{n}" | one position card: icon of the goddess (grey when not active, `GFC:83-101`) | page | `levelTemplate` = row of `grade`, `nextLevelTemplate` = row of `grade + 1` (`GFC:109-126`) |
| `GFL`, `GoddessFormationSelectListItem` | "Retirar Deusa", "Clique para adicionar Deusa", "Selecione a Deusa" | goddess picker (unused, see overview) | none | |

## 3. Routes (client to server)

Send 5191 (0x1447) `C_GODDESS_OP`, `GoddessRequestMsg` (full table in `goddess.md`).

### A1. Feed a position (op 7)
- UI: `_btnUpgrade1` (`GFP:309-318`); quantity input clamped to owned 212034 (`GFP:300-307`), default `min(owned, 1)` (`GFP:404-405`).
- Client checks: quantity <= 0 -> "Material insuficiente" (`goddess.array.text15`); button disabled at level 50 (`GFP:482-493`).
- Sender: `GM.requestFormationUpgrade(selectedIndex, count)` (`GM:184-192`).
- Request: `op` (#1) = 7, `formationId` (#5) = position 1..5, `count` (#3) = items.
- Response: push 177 with `formations` containing the updated position; bag update 115.

### A2. Assign or clear a position (op 6, no live caller)
- Sender: `GM.requestFormationSet(position, templateId)` (`GM:174-182`), called from `GFL.__onClickHander` (`GFL:88-108`): empty row -> `templateId` 0 (clear); goddess not active -> "A Deusa selecionada não foi ativada"; else the goddess `TemplateId`.
- Request: `op` = 6, `formationId` (#5), `templateId` (#2) (0 = remove).
- Response: push 177 with `formations`.

## 4. Server messages (server to client)

### S1. 177 (0x00b1) `U_C_GODDESSINFO`, `GoddessMsg.formations` (#2, repeated `GoddessFormationIdInfoMsg`)
Receiver `GM.__godInfosHandler` (`GM:122-136`): upserts `model.formationMap[formationId]` and notifies `EVENT_ARRAY_GODDESS_CHANGE`, which refreshes `GFP` (`GFP:288`, `:320-323`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `userId` | #1 | INT32 | owner |
| `formationId` | #2 | INT32 | position 1..5 |
| `templateId` | #3 | INT32 | goddess in the position (0 = empty); in practice equals `formationId` |
| `grade` | #4 | INT32 | position level 0..50 |
| `gradeGp` | #5 | INT32 | exp inside the current level |

Send all five positions at login (records with level 0 are fine) and the changed position after ops 6 and 7.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Item | 212034 "Marca da Terra", `Property1` 10 exp per item (dropped by the weekly "Prisão do Abismo" campaign) | `ItemTempInfos.xml` |
| Level row | `GoddessUnitedResiTemplates.xml` row `Level` = position level; next row gives `NeedGp` (Lv1 50 ... Lv50 5000) | `GFC:109-126` |
| Exp loop | same as goddess level: `gp += count*10`, level up while `gp >= next.NeedGp` *(assumption on carry)* | `GFP:475-476` |
| Level 0 | no row 0 exists: level template missing -> client uses an empty template (`GFP:467-472`) | |
| Anti resistance | sum over positions of `ReduceResi` (400 per level, 20000 at 50) | `GFP:440` |
| Stat inheritance | hero gains `floor(Permillage / 1000 * goddess.stat)` for attack, defence, magic defence, HP of the goddess bound to each position (`Permillage` 0 up to level 4, 10 from 5, ... 100 at 50) | `GFP:441-444` |
| Activity | inactive goddess positions still level; inheritance is 0 because the goddess has no stats *(assumption)* | |
| Formation skills | `GoddessUnitedSkillTemplates.xml`: `MinLevel` 5 -> 8000001, 15 -> 8000002, 30 -> 8000003, 50 -> 8000004; unlocked when the lowest position level >= `MinLevel`. Effect: when the goddess casts the dance skill, 25/50/75/100% chance to reduce 2 "Faíscas" of all allies (skill descriptions, MasterType 82) | `GFP:260-284`, `SkillTempInfos.xml` |
| Titan link | strings `goddess.array.text6..9` mention unlocking Titan skills 6..9 at levels 10/20/30/40 but no class uses them; see `../dragon/titan.md` | `index/language.json` |

## 6. Templates

| File | Cate | Fields |
|---|---|---|
| `GoddessUnitedResiTemplates.xml` (50 rows) | `goddessFormationTempCate.getTemplateByLevel` | `Level`, `ReduceResi`, `NeedGp`, `Permillage` |
| `GoddessUnitedSkillTemplates.xml` (4 rows) | `goddessFormationSkillTempCate` (`LV` = sorted `MinLevel` list) | `MinLevel`, `SkillId` |
| `SkillTempInfos.xml` | skills 8000001..8000004 | `Description`, `BufferIds` |

## 7. Persistent state

```sql
CREATE TABLE goddess.formation_slots (
  player_id     BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  formation_id  SMALLINT NOT NULL CHECK (formation_id BETWEEN 1 AND 5),
  template_id   SMALLINT CHECK (template_id BETWEEN 1 AND 5),
  grade         SMALLINT NOT NULL DEFAULT 0 CHECK (grade BETWEEN 0 AND 50),
  grade_gp      INTEGER  NOT NULL DEFAULT 0 CHECK (grade_gp >= 0),
  PRIMARY KEY (player_id, formation_id)
);
CREATE UNIQUE INDEX formation_slots_goddess ON goddess.formation_slots (player_id, template_id) WHERE template_id IS NOT NULL;
```

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 6 | `goddess::formation::handle_set_slot` |
| 7 | `goddess::formation::handle_feed_slot` |

- Op 7: validate feature open -> `formationId` 1..5 -> level < 50 -> items owned; transaction consume 212034 and apply exp loop (upsert the slot row with `template_id = formation_id` by default); push 115 then 177 (`formations` with the slot); recompute hero stats (anti resistance and inherited stats belong to the hero attribute pipeline, `../hero/README.md`).
- Op 6: validate goddess active (or 0 to clear) and not already in another slot; update; push 177.
- Battle: add `ReduceResi` sum to the player's goddess anti resistance and attach formation skills to the fighting goddess (`docs/battle/server-engine.md`).

## 9. Open questions and assumptions

- *(assumption)* Position = goddess binding (client evidence above); op 6 kept for compatibility.
- *(assumption)* Inheritance uses the goddess final stats sent in `GoddessInfoMsg` (`attack`, `defance`, `magicDefance`, `live`).
- Exact battle meaning of "Anti-resistência" and "Faíscas" belongs to the battle engine.

## 10. Implementation checklist

- [ ] Route 5191 op 7 feed position.
- [ ] Route 5191 op 6 assign/clear position.
- [ ] 177 `formations` at login (5 rows) and after changes.
- [ ] Table `goddess.formation_slots`.
- [ ] Hero stat inheritance and anti resistance totals.
- [ ] Formation skills by minimum level.
- [ ] Tests: feeding 5 items at level 0 gives 50 exp and level 1; level cap 50; skill 8000001 active only when all five positions >= 5.
