# Hero line-up and soldier formation (Equipe, Formação)

Path aliases:

| Alias | File |
|---|---|
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| LUV | `decompiled/m5/scripts/armyII/viewII/lineUp/LineUpView.as` |
| AV | `decompiled/m5/scripts/armyII/viewII/allocate/AllocateView.as` |
| SPF | `decompiled/m5/scripts/armyII/viewII/allocate/SortPawnFrame.as` |

Full grid reference: `docs/battle/formation.md` §1-4 (positions 1..12, rendering and derivation tables).

## 1. Overview

In the main game mode the player does not place units freely. The server stores two numbers: the hero `fight_pos` and the troop `fight_pos`, each 1 (front) or 3 (back). The client derives the grid cells of the hero, troops, Guardian (child), slave child and battle monster from the chosen hero cell (4, 7, 6 or 9). Three screens send the same request.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.lineUp.LineUpView` (LUV) | "Equipe" (`armyII.SkillFrame.lineUpTitle`); buttons "Número 1".."Número 4" | Choose hero cell; shows hero, child, slave child or monster, troops twice | `SkillFrame` tab 3, hero level >= 11 (`decompiled/m5/scripts/armyII/SkillFrame.as:638-653`) | `thane.fightPos`, `armyPawns[0].fightPos`, child/monster in war |
| `armyII.viewII.allocate.AllocateView` (AV) | front/back buttons, tips "Troque formação dos soldados para parte Frontal" / "...Traseira" | Toggle soldiers front/back | troop panel | same fields |
| `armyII.viewII.allocate.SortPawnFrame` (SPF) | "Formação"; help "Clique no avatar para ajustar a formação de equipe" | Shows hero and troop cells by `fightPos` (`SPF:61-68`) | `SORT_PAWN` (needs barracks and soldiers) | same fields |

## 3. Routes (client to server)

### R1. Edit fight positions
- UI:
  - LineUpView tab change (`LUV:188-205`): `heroPosArr = [4, 7, 6, 9]`; `checkPos` maps 4/7 → hero `fight_pos 1`, troop `3`; 6/9 → hero `3`, troop `1` (`LUV:256-300`); sent only when the derived position string changes;
  - AllocateView front/back buttons (AV:223-241), enabled only when the troop has soldiers (AV:243-262).
- Client path: `ASOM.sendEditArmyPos(userId, heroPos, pawnPos)` (ASOM:85-93); the client also sets `ArmyManager.isSorted = true`.
- Route: send 8276 (0x2054) `C_ARMYPOS_EDIT`. Request `ArmyFightPosEditMsg` (army): `user_id` (#1, INT32) player id; `hero_pos` (#2, INT32) 1 or 3; `pawn_pos` (#3, INT32) 3 or 1; `serverName` (#4, STRING) unset.
- Client checks: none (no level check on AV; LineUpView needs level 11 to open).
- Expected response: 113 `U_C_HERO_INFO` with `fight_pos` (#43) and 93 `U_C_ARMY_EDIT` with the troop `fight_pos` (#8) *(assumption: the client already applied the values locally)*.

## 4. Server messages (server to client)

- 113 `SimpleHeroInfoMsg.fight_pos` (#43, INT32): read unconditionally by `ThaneInfoHelper.readHeroInfo` (`decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as:443`).
- 93 / 150 `ArmyPawnInfoMsg.fight_pos` (#8, INT32) of site 0 (`decompiled/core_module/scripts/map/internals/utils/SocketGameReader.as:113`).

## 5. Rules and formulas

- Persisted pair: (hero 1, troop 3) or (hero 3, troop 1). Reload maps (1,3) → cell 4 and (3,1) → cell 6 (`LUV:240-254`), so cells 7 and 9 are not persisted.
- Derivation table (LUV:256-300, `docs/battle/formation.md` §4.1): hero 4 → troops 3 and 12, child 6; hero 7 → troops 3 and 12, child 9; hero 6 → troops 1 and 10, child 4; hero 9 → troops 1 and 10, child 7. A slave child or monster in war replaces the troops.
- No formation bonuses exist for the main army (`docs/battle/formation.md` §4.4).

## 6. Templates

None.

## 7. Persistent state

Columns: `army.troops.fight_pos` ([troops.md](troops.md)) and the hero fight position:

```sql
ALTER TABLE army.troops ADD COLUMN IF NOT EXISTS hero_fight_pos SMALLINT NOT NULL DEFAULT 1 CHECK (hero_fight_pos IN (1, 3));
-- stored on the site 0 row; invariant: hero_fight_pos <> fight_pos
```

## 8. Backend implementation notes

- `army::formation::handle_edit_fight_pos` (8276): `user_id` must be the sender; accept only (1,3) or (3,1); update site 0 row; push 113 and 93.
- Battle configuration: hero and troop rows from these values (`docs/battle/server-engine.md` §9.3, units `pos`).

## 9. Open questions and assumptions

- Assumption: the response is 113 + 93; the client does not wait for it.
- Open: whether the server stores the 4 cells; the protocol only carries 1/3.

## 10. Implementation checklist

- [ ] Screens: LineUpView, AllocateView row buttons, SortPawnFrame
- [ ] Route 8276
- [ ] Server message 113 `fight_pos`
- [ ] Server message 93 troop `fight_pos`
- [ ] Column `army.troops.hero_fight_pos` and `fight_pos`
- [ ] Rule: only (1,3)/(3,1)
- [ ] Test: battle places hero and troops per stored pair
