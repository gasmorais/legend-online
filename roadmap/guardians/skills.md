# Guardian skills: learn, upgrade with books, battle skill bar

Module `skills`. Each guardian job has a skill pool (skill templates with `MasterType` = the job's `SkillMasterType` 41..57, common skills `MasterType` 44). Skills are learned with a scroll, raised level by level by feeding skill books (progress kept per skill in `skill_books`), and up to five learned skills are carried on the battle bar (`fight_skill`).

Path aliases:

| Alias | File |
|---|---|
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| SI | `decompiled/m14/scripts/child/skill/ChildSkillItem.as` |
| SL | `decompiled/m14/scripts/child/skill/ChildSkillListView.as` |
| MUF | `decompiled/core_module/scripts/bag/view/MulItemUseFrame.as` |

`ChildrenOpMsg` table: `roster.md` section 1; 4747 fields: `roster.md` S1. Espírito de Proteção skills (ops 33, 34) are in `nursing-spirit.md`.

## 1. Overview

- Skill templates: `SkillTempInfos.xml`, `MasterType` 41..57 (per job, `ChildTempInfos.SkillMasterType`), `MasterType` 44 = common guardian skills (32 rows), `UseWay` 1 active (Ex) / 2 passive or common, `SonType` = skill line, `Grades` = level, `Index` = position.
- Strings in `ChildrenMsg`: `skill` (#7) learned skill template ids, `fight_skill` (#9) five `SonType` values separated by commas (-1 or 0 = empty), `skill_books` (#15) `templateId,booksUsed|...` progress per skill.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/skill/ChildSkillTabView.as` | warnings "Ao configurar guardião como guardião secundário não será possível usar a habilidade Ex!" / "...habilidade comum!" | tab with active/passive groups (`:60-76`) | `ChildFrame` tab 3; blocked during growth period ("Durante o período de crescimento não pode verificar habilidades") | |
| `SL`, `V/skill/ChildBattleSkillItemView.as` | | skill list and the 5 slot battle bar | tab | `fight_skill` |
| `SI`, `V/skill/ChildSkillItemView.as` | "Para apreder habilidades é necessário {0} livros de habilidade x1", "Para elevar habilidade é necessário Livro de Habilidade do {0} x{1}", "Habilidade {0} atingiu o nível máximo" | one skill: learn or upgrade, progress `used / cost` (`SI:405-435`) | list | |

## 3. Routes (client to server)

All: send 8868 (0x22a4) `C_CHILDREN_OP`, `ChildrenOpMsg`. Common check: the guardian is not fielded by the spouse ("O seu companheiro configurou o guardião, não pode fazer esta operação.", `SI:166-170`, `:284-288`).

### A1. Learn a skill (op 8 OP_LEARN_SKILL), then carry it (op 16)
- UI: learn button (`SI:155-268`).
- Scroll: `UseWay` 1 -> 2269000 "Pergaminho de Habilidades Ativas do Guardião"; `UseWay` 2 and `MasterType` 44 -> 2269002 "...Comuns..."; other `UseWay` 2 -> 2269001 "...Passivas...". Missing scroll opens the quick buy frame; confirm "Deseja usar 1 livro {0} para aprender {1}?".
- Request 1: `op_type`=8, `property1` = child id, `property2` = bag position of the scroll, `property6` = skill template id.
- Request 2 (sent right after by the client): `op_type`=16 with the new `SonType` placed in the first empty bar slot (A3).
- Response: 115 (scroll consumed), 4747 with `skill` and `fight_skill`.

### A2. Upgrade a skill (op 9 OP_UPGRADE_SKILL)
- UI: upgrade button (`SI:272-330`) opens `MUF` with the book; `MUF` sends (`MUF:326-334`).
- Book: level < 5 uses the same scroll as learning; level >= 5 uses 2260001 "Livro da Sabedoria". Books fed per level: `getUpgradeCostByGrade` (`SI:541-561`): level L < 5 -> `4^(L-1) * 10` (10, 40, 160, 640); L = 5, 6, 7 -> 1000, 2000, 4000 (`ADVANCED_COST_LIST`, `SI:41`); above -> 0 (max).
- Request: `op_type`=9, `property1` = child id, `property2` = skill template id (`goods.randomSkill1`), `property6` = number of books.
- Response: 115, 4747 with `skill_books` progress and, when the cost is reached, `skill` with the next level template.

### A3. Set the battle bar (op 16 CARRY_SKILL)
- UI: drag in the battle bar (`SL:166-200`), after learning (A1), and from the spirit view (`decompiled/m14/scripts/child/nursingspirit/ChildNsBattleSkillView.as:72`).
- Request: `op_type`=16, `property1` = child id, `property3` = "s1,s2,s3,s4,s5" (`SonType` or -1).
- Response: 4747 with `fight_skill`.

## 4. Server messages (server to client)

4747 `U_C_CHILDREN` fields `skill` (#7), `fight_skill` (#9), `skill_books` (#15) (`roster.md` S1); 115 bag updates.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Learnable pool | skills of `MasterType` = job `SkillMasterType` plus common `MasterType` 44 | `ChildTempInfos.xml` |
| Learn cost | 1 scroll by `UseWay` | `SI:171-186` |
| Upgrade cost per level | 10, 40, 160, 640 (levels 1..4, scrolls), 1000, 2000, 4000 (levels 5..7, Livro da Sabedoria) | `SI:41`, `SI:541-561` |
| Progress | books accumulate in `skill_books` until the cost is reached *(assumption: overflow carries)* | `SI:417-432` |
| Bar | 5 slots, one skill per line | `SL` |
| Assist guardian | as assist (secondary) guardian Ex/common skills are not used in battle | `ChildSkillTabView` warnings |

## 6. Templates

| File | Use |
|---|---|
| `SkillTempInfos.xml` MasterType 41..57 | guardian skills |
| `ItemTempInfos.xml` SonType 226 | 2269000, 2269001, 2269002 scrolls; 2260001 Livro da Sabedoria (`Property` = skill line for `getGoodsArrBySonTypeAndPropertyAndNotLock(226, SonType)`) |

## 7. Persistent state

```sql
CREATE TABLE guardians.child_skills (
  child_id     INTEGER  NOT NULL REFERENCES guardians.children(child_id) ON DELETE CASCADE,
  skill_line   INTEGER  NOT NULL,
  template_id  INTEGER  NOT NULL,
  books_used   INTEGER  NOT NULL DEFAULT 0 CHECK (books_used >= 0),
  PRIMARY KEY (child_id, skill_line)
);

CREATE TABLE guardians.child_skill_bars (
  child_id   INTEGER  PRIMARY KEY REFERENCES guardians.children(child_id) ON DELETE CASCADE,
  slots      INTEGER[] NOT NULL DEFAULT '{-1,-1,-1,-1,-1}' CHECK (array_length(slots, 1) = 5)
);
```

`skill`, `fight_skill` and `skill_books` strings are serialized from these tables.

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 8 | `guardians::skills::handle_learn` |
| 9 | `guardians::skills::handle_upgrade` |
| 16 | `guardians::skills::handle_carry` |

- Learn: guardian editable by this player -> skill in pool, line not yet learned -> scroll at `property2` matches the `UseWay` rule -> consume, insert level 1 -> push 115, 4747.
- Upgrade: line learned -> book type by level -> consume `property6` books -> add to `books_used`, level up while `books_used >= cost(level)` -> push.
- Carry: every value -1 or a learned line, no duplicates.
- Battle: guardian units use `fight_skill` lines at their learned levels (`formation.md`).

## 9. Open questions and assumptions

- *(assumption)* Overflow of books after a level up.
- *(assumption)* Max level is 8 (cost list ends at level 7).

## 10. Implementation checklist

- [ ] Ops 8, 9, 16.
- [ ] Tables `guardians.child_skills`, `guardians.child_skill_bars`.
- [ ] Serialization of `skill`, `fight_skill`, `skill_books`.
- [ ] Tests: learn without scroll rejected; level 4 -> 5 needs 640 scrolls; level 5 -> 6 needs 1000 Livro da Sabedoria; carry with an unlearned line rejected.
