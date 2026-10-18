# Battle formation: grid, placement, reinforcement, swap and revive

Module `formation` of the feature [Motor de batalha](README.md). Path prefixes as in [lifecycle.md](lifecycle.md). Full client detail: `docs/battle/formation.md` (grid table, 20 mode specific formation screens) and `docs/battle/rules.md` §9. The pre-battle formation screens belong to their features: main army [../army/formation.md](../army/formation.md), guardians [../guardians/formation.md](../guardians/formation.md), goddesses [../goddess/formation.md](../goddess/formation.md), pets [../einherjar/README.md](../einherjar/README.md), monsters [../monsters/README.md](../monsters/README.md). This module owns how units are **placed on the battle grid** and how they **enter, leave and come back** during a fight.

## 1. Overview

- Each side has a 3 x 4 grid, positions 1..12. On both sides pos 1/4/7/10 is the **front** column (nearest the enemy), 2/5/8/11 the middle, 3/6/9/12 the back. Row = `ceil(pos/3) - 1` (0 top, 3 bottom).
- The receiving player's side is always drawn on the left (face 1); the server only sends `side` and `pos` per unit.
- There are no formation types and no position bonuses for the main army (`docs/battle/formation.md` §4.4).
- During a battle the server can add units (reinforcement 72), replace units (swap 4793), revive units (4795 or `waitRevives` inside 153) and preload resources for a coming wave (4149).

## 2. Screens

No battle screen of its own. Units are placed by `BattleView.initRoles` (`M10/battle/view/BattleView.as:216-249`) using `BattleUtils.rolePointByPos(pos, face)` (`CM/battle/utils/BattleUtils.as:153-225`). The reinforcement wave counter is `ReinforceWavePane` inside `RoleShowViewII` (`M10/battle/view/ui/RoleShowViewII.as:63-92`), shown when `reinforceWave > 0`.

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.view.reinforce.ReinforceWavePane` (M10) | none | Wave n of N | 157 `reinforceCount > 0` | `currentReinforceWave + 1` / `reinforceWave`; 3886 uses Easter icons |
| `battle.view.ui.TrailCountView` (M10) | current floor | Trial layer | battleTypes 25, 295, 3870, 3894, 3905 (`M10/battle/view/ui/BattleUIView.as:1334-1354, 1474-1480`) | `trialLayer` from 157 `currentWave` or 72 `reinforceWave` |

## 3. Routes (client to server)

None. Placement is fully server decided. Pre-battle edits use the owning features' routes (for example 8276 `C_ARMYPOS_EDIT` in [../army/formation.md](../army/formation.md)).

## 4. Server messages (server to client)

### 4.1 Unit placement inside 157

Every `SoldierMsg` and `HeroMsg` of 157 carries `side (INT32)` and `pos (INT32)` ([units.md](units.md)). Pets and goddesses linked to a hero (`living_id2 = hero living_id`) take the hero's pos and side (`CM/yishi/datas/objects/PetRoleInfo.as:55-63`, `GoddessRoleInfo.as:51-59`). A `pos` outside 1..12 renders at (0,0).

### 4.2 72 (0x0048) U_B_USER_REINFORCE: add units

`battle.ReinforceMsg`:

| Field | Meaning |
|---|---|
| `side (#1, INT32)` | side of the wave (informative; each unit has its own side) |
| `hero (#2, HeroMsg, repeated)` | heroes and bosses entering; a `type 3` hero triggers the boss panel (`bossReinforce`) |
| `soldiers (#3, SoldierMsg, repeated)` | troops entering |
| `reinforceWave (#4, INT32)` | new trial layer / wave number (ignored in 295) |
| `pets (#5, HeroMsg, repeated)` | pets of entering heroes (or pets as fighters in 3866) |
| `children (#6, HeroMsg, repeated)` | guardians entering (`side != 0` only) |
| `removeLivingIds (#7, INT32, repeated)` | used only by 4793 swap |
| `heroTempId (#8, INT32, repeated)` / `life (#9, INT64, repeated)` | used only by 4793 swap |
| `frame_num (#10, INT32)` | used only by 4793 swap |
| `opType (#11, INT32)` | stored in `childArenaType` (child arena) |
| `goddesses (#12, HeroMsg, repeated)` | goddesses (client bug: adds the wrong object, `CM/battle/handler/ReinforceHandler.as:267-280`; send goddesses inside `hero` links instead) |
| `monsters (#13, HeroMsg, repeated)` | battle beasts |

Receiver: `ReinfoTransaction` (queued) -> `ReinforceHandler.handle` (`CM/battle/handler/ReinforceHandler.as:104-313`). Ignored when the own unit died in 295/3854 or after "finish now". 3870 first kills every living right side unit. Entering units spawn 700 px outside their side and walk in at 25 px/frame (`:37-59`). After the wave `isOver = false` and, if no normal hero entered, `SKILL_ENABLE true`. Header `extend2` = frame at which the wave appears.

### 4.3 4149 (0x1035) U_B_LOAD_RES: preload a coming wave

`battle.ArmyResMsg`: `loadRes (#1, PreLoadResMsg, repeated)` each `army_id (#1, INT32)`, `heroSkill (#2, INT32, repeated)`, `soldierTempId (#3, INT32, repeated)`, `soldierSkill (#4, INT32, repeated)`; `reinforce_count (#2, INT32)`; `reinforce_type (#3, INT32)` 1 = update the wave counter to `reinforce_count`. Receiver `ReinfoResTransaction` (`CM/battle/transaction/ReinfoResTransaction.as:17-102`). Send a few seconds before 72 so the client has the SWFs.

### 4.4 4793 (0x12b9) U_B_MONSTER_EXCHANGE: swap units

`battle.ReinforceMsg` (same fields): `hero`, `soldiers`, `children` enter; `removeLivingIds` leave (die in place, no exit animation); `heroTempId`/`life` update the multi boss life list; `frame_num` = every queued client skill with `liftTime < frame_num` is skipped (damage applied instantly). Receiver `SwapTransaction` -> `SwapHandler.handle` (`CM/battle/handler/SwapHandler.as:32-171`); 311-313 refresh the multi boss panel. Use for boss phase changes and "next enemy" substitutions.

### 4.5 4795 (0x12bb) U_B_RELIVE_LIVE: revive a hero

`battle.ReliveMsg`: `battle_id (#1, STRING)`; `living_id (#2, INT32)` hero to revive; `skill_id (#3, INT32)`, `parm1 (#4, INT32)`, `parm2 (#5, INT32)`, `parm3 (#6, STRING)` unused by the client. Receiver `ReviveTransaction` -> `ReviveHandler.handle` (`CM/battle/handler/ReviveHandler.as:25-115`): the hero comes back at **full HP** (`bloodA = totalBloodA`), effect `buff.action.cure2`, chat line `battle.actions.DannyAction.ChatDataMsg`. The target must exist (no null check).

### 4.6 Scheduled revive inside 153

`AttackOrderMsg.waitRevives (#18, WaitReviveMsg, repeated)`: `battle_id (#1, STRING)`, `living_id (#2, INT32)`, `sp (#3, INT32)`, `hp (#4, INT32)`. When that unit dies from this order it plays a 50 frame revive (f24 restores `hp` and `sp`) (`CM/battle/actions/DannyAction.as:538-610`; `CM/battle/data/ReliveInfo.as`). Use for "revive on death" passives.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Columns | front 1,4,7,10; middle 2,5,8,11; back 3,6,9,12 | `CM/battle/utils/BattleUtils.as:153-225` |
| Row | `ceil(pos/3) - 1` | same |
| Screen point, own side (face 1) | `x = 295 + 150*col - 40*row`, `y = 570 + 60*row`, col = `2 - (pos-1)%3` | `BattleUtils.as:108-151`; table `docs/battle/formation.md` §2 |
| Screen point, enemy (face 2) | `x = 905 + 150*col + 40*row`, col = `(pos-1)%3` | same |
| One hero per row | the HUD keys heroes by `row + "_" + side`; never put two `type 1` heroes in one row of a side | `CM/yishi/datas/BattleModel.as:407-417` |
| Hidden unit | `HeroMsg.is_show = true` -> not drawn; 295/3898 also skip units with HP <= 0 | `M10/battle/view/BattleView.as:253-266` |
| Main army placement (derived from the army feature's `fight_pos`) | hero front (`hero_fight_pos = 1`) -> hero pos 4, troops 3 and 12, child 6, slave child 12, monster 3; hero back (`3`) -> hero 6, troops 1 and 10, child 4, slave child 10, monster 1. A slave child or monster in war replaces the troops | `M5/armyII/viewII/lineUp/LineUpView.as:233-311` (client preview; server must match, assumption) |
| NPC placement | `HeroAis.Soldiers = "pawnTempId,pos|..."` gives NPC troop cells; NPC heroes usually in row 1 | `docs/battle/formation.md` §4.2 |
| Mode specific formations | pets, children, monsters use 8 cells `[3,6,9,12,1,4,7,10]` (no middle column) | `docs/battle/formation.md` §7 |
| Reinforcement entry | spawn 700 px off side, speed 25 px/frame | `ReinforceHandler.as:37-59` |
| Swap | skip client skills older than `frame_num`; leaving units die in place | `SwapHandler.as:85-143` |
| Revive | full HP (4795) or `WaitReviveMsg.hp` (scheduled) | §4.5, §4.6 |
| Targeting by column | see [skills-effects.md](skills-effects.md) §5 (AcceptObject) | `docs/battle/server-engine.md` §4 |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/HeroAis.xml` | NPC AI | `Soldiers` "pawnTempId,pos|..." (144 of 8080 rows) |
| `raw/xml/tempinfos/PawnTempInfos.xml` | troops entering in a wave | `TemplateId`, `Swf`, `DefaultSkill`, `AI` |
| `raw/xml/tempinfos/ConfigInfos.xml` | none specific | |

## 7. Persistent state

None owned by this module. Player formations are persisted by their features (`army.troops.fight_pos`, `hero_fight_pos` in [../army/formation.md](../army/formation.md); guardian and pet formations in their folders). The battle stores the resolved placement only in the optional `battle.battles.config` snapshot ([lifecycle.md](lifecycle.md) §7).

## 8. Backend implementation notes

- `battle::formation::resolve_player_side(player, mode) -> Vec<UnitSpec>`: reads the owner feature's formation (main army: hero and troop `fight_pos`, child in war, slave child, monster in war, pet, goddess) and returns units with `side` and `pos` using the table in §5. Mode specific features pass their own `pos` lists.
- `battle::formation::resolve_npc_side(ai_id | template list)`: boss or NPC hero plus `HeroAis.Soldiers`.
- Validation: positions 1..12 unique per side for main units (pets/goddesses share their hero's pos); one `type 1` hero per row; `living_id` unique in the battle (mock: heroes 1.., soldiers 100..).
- Reinforcement scheduling: the battle config may hold `waves: [{at_frame | on_side_wiped, units}]`; the actor sends 4149 (preload) then 72 at the wave frame, sets `reinforceWave`, and continues. Trial modes use `reinforceWave` as the floor number.
- Swap: send 4793 with `frame_num` = current frame; remove the leaving units from the engine at once.
- Revive: on a revive effect, either attach `WaitReviveMsg` to the lethal 153 (preferred: animation in place) or send 4795 later (full HP only).
- Pushes go to every participant and spectator.

## 9. Open questions and assumptions

1. *(assumption)* the original server used the same main army derivation as the `LineUpView` preview (hero 4/6; rows 7/9 do not survive a reload).
2. `ReliveMsg.skill_id/parm1..3` meaning unknown.
3. `ReinforceMsg.side` and `opType` semantics outside the child arena are unknown.
4. Goddesses in 72 are mishandled by the client; send them only linked to heroes.

## 10. Implementation checklist

- [ ] `resolve_player_side` for the main army (hero, troops, child, slave child, monster, pet, goddess)
- [ ] `resolve_npc_side` from `HeroAis.Soldiers`
- [ ] Validation: pos range, uniqueness, one hero per row, unique living ids
- [ ] Server message 72 (reinforcement) with `extend2` = frame
- [ ] Server message 4149 (preload) before each wave
- [ ] Server message 4793 (swap) with `frame_num`
- [ ] Server message 4795 (revive) and `waitRevives` in 153
- [ ] Rule: wave counter and trial layer (`reinforceCount`, `currentReinforce`, `currentWave`, `reinforceWave`)
- [ ] Test: unit at each pos 1..12 appears at the expected column on both sides
- [ ] Test: wave entry, swap mid skill, revive at full HP
