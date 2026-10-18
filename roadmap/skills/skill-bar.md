# Skill bar (fast keys 1..5)

Path aliases:

| Alias | File |
|---|---|
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| SC | `decompiled/core_module/scripts/yishi/datas/playerinfo/SkillCategory.as` |
| SV | `decompiled/m5/scripts/armyII/viewII/skill/SkillView.as` |
| SIV | `decompiled/m5/scripts/armyII/viewII/skill/SkillitemView.as` |
| FSI | `decompiled/m5/scripts/armyII/viewII/skill/FastSkillItem.as` |

## 1. Overview

The bottom of the skill tab holds 5 skill slots (keys 1..5) and 2 rune slots (Z, X; see [runes.md](runes.md)). The player drags learned active skills into the slots, swaps them, or drags them out. The client serializes the 5 slots as a CSV of skill `SonType` values (`-1` for empty) and sends it; the server stores it and echoes it. In battle the bar is rebuilt from `skillCate.fastKey` (see `docs/battle/hud.md`, `SkillItemListController.getFastkey`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.skill.SkillView` bottom bar (SV:462-487) | slots numbered 1..5 | Fast key editing | `SkillFrame` tab 0 | `skillCate.fastKey` split by `,`, each entry resolved with `ThaneInfo.getSkillBySontype` |
| `armyII.viewII.skill.FastSkillItem` (FSI) | | One slot: icon, index, super skill mark | SkillView | `SkillInfo` |

## 3. Routes (client to server)

### R1. Set the skill bar
- UI triggers (all send the whole bar):
  - drop a learned skill from the tree on a slot (`SkillitemView.onDragStop`, SIV:202-219); passive skills (`UseWay == 2`) and level 0 skills cannot be dragged (SIV:165-187);
  - swap two slots or drag a slot out of the bar to clear it (FSI:147-177);
  - auto placement: when a skill reaches level 1, is active, is not in the bar and fewer than 5 slots are used, the client animates it into the first free slot and sends (SIV:268-296, SV:706-738);
  - tutorial: `NewbieBaseActionMediator.sendSetSkillFastKey` turns `"a_b_c"` into `"a,b,c,"` (`decompiled/m8/scripts/mediators/NewbieBaseActionMediator.as:886-895`).
- Serialization: `SkillView.fastKey` (SV:788-809): for each of the 5 slots, `SonType + ","` or `"-1,"`. Example: `"107,108,-1,-1,-1,"`.
- Client path: notification `SET_FAST_KEY` → `SkillView.__setFastKeyHandler` (SV:701-704) → `AC.sendSetFastKey` (AC:421-424) → `ASOM.sendSetFastKey` (ASOM:283-289).
- Route: send 5167 (0x142f) `U_C_HERO_SETFASTKEY` (name from `ProtocolType.as:318`, absent in opcodes.csv).
- Request `HeroFastKeyMsg` (army): `fast_key` (#1, STRING) the CSV above; `set_result` (#2, BOOL) not set.
- Client checks: none besides drag rules; the server must validate.
- Expected response: 64 (S1).

## 4. Server messages (server to client)

### S1. 64 (0x0040) `U_C_HERO_SETFASTKEY`
- Message `HeroFastKeyMsg`: `fast_key` (#1, STRING) stored CSV; `set_result` (#2, BOOL) true on success.
- Receiver: `AM.__fastKeySetHandler` (AM:499-515): sets `skillCate.fastKey`, sends `SKILL_UPGRADE` after 900 ms (view refresh); when hero level <= 10 calls `skillCate.refreshAllSkill()`. `set_result` is not read.
- When: response to 5167; also pushed before battle creation so the battle HUD uses the right bar (`docs/battle/server-engine.md` §1 and §9.4).

The fast key is also carried by 113 `SimpleHeroInfoMsg.fast_key` (#8) (`ThaneInfoHelper.as:402-405`).

## 5. Rules and formulas

- 5 slots (SV:469-486). Entries are skill `SonType` values, not template ids, so raising a skill keeps its slot.
- Battle reads the CSV with `SkillCategory.getFastkey` (SC:238-261): it loops `1 .. length - 1` over `[i - 1]`, so the trailing empty entry after the last comma is ignored; `-1` entries are skipped. DragonTalker uses template ids instead (`docs/battle/hud.md`).
- A slot may only hold a learned (grade >= 1), active (`UseWay != 2`) skill of the active skill set *(server rule, mirrored from SIV:167-174)*.
- Skill reset clears all slots on the client (`FastSkillItem.__resetHandler`, FSI:114-119); the server must clear `fast_key` too.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/SkillTempInfos.xml` | skill level row | `SonType` (slot key), `UseWay` (2 = passive, not slottable), `Priority` (super skill frame), `Icons` |

## 7. Persistent state

No own table. The value lives in `skills.skill_sets.fast_key` (one per skill set), defined in [hero-skills.md](hero-skills.md):

```sql
-- skills.skill_sets.fast_key TEXT NOT NULL DEFAULT ''  (CSV of 5 SonType values or -1, trailing comma)
```

## 8. Backend implementation notes

- `skills::skill_bar::handle_set_fast_key` (5167):
  1. Split `fast_key` by `,`, drop the trailing empty token, keep at most 5 tokens.
  2. Each token must be `-1` or the `SonType` of a learned active skill of the active set; no duplicates. Replace invalid tokens with `-1` *(assumption: the original server sanitized instead of rejecting)*.
  3. Normalize to exactly 5 entries plus trailing comma; update `skills.skill_sets.fast_key`.
  4. Reply 64 `{fast_key, set_result = true}`.
- Battle start (battle feature): push 64 with the stored bar before 157 `BattlePrepareMsg`; the hero unit receives the skills referenced by the bar plus passives.

## 9. Open questions and assumptions

- Assumption: invalid entries are sanitized rather than rejected; the client has no error path (`set_result` unused).
- Open: whether the server auto-fills the bar on skill learning; the client already does it and sends 5167.

## 10. Implementation checklist

- [ ] Screen: bar renders from 113 `fast_key` and 64
- [ ] Route 5167 set fast key with validation
- [ ] Server message 64 response
- [ ] Server message 64 pre-battle push
- [ ] Column `skills.skill_sets.fast_key`
- [ ] Rule: only learned active skills of the active set
- [ ] Rule: reset clears the bar
- [ ] Test: drag, swap, remove, auto-placement round trips
- [ ] Test: battle HUD shows the stored bar
