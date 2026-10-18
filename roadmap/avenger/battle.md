# Avenger battle skill bar (SP, active skills, swap)

Module `battle` of the feature [Vingador](README.md). Path conventions are in the README. The battle engine itself is owned by [../battle/README.md](../battle/README.md); the client HUD is mapped in `docs/battle/hud.md` (section "AvengerBattleSkillView") and `docs/battle/rules.md` §12.5. This file lists only what the avenger feature adds.

## 1. Overview

When the player hero is an avenger (`heroInfo.isAvenger`) and has formation skills, the battle bottom bar shows an extra panel:

- an **avenger SP** gauge (0..70, shown as `sp / 10`);
- **2 active slots** (keys B and N): the formation skills (1 major, 1 minor, [skills.md](skills.md)), usable when `avengerSp >= Cost` (50 major, 20 minor);
- a **standby panel** (key M or button): the 4 other avenger skills under "Principal" and "Secundário"; clicking one swaps it into the active slots, then a cooldown (from "Olhos da Verdade", [core.md](core.md)) blocks further swaps.

There is no avenger-specific battle type and no avenger-specific map: the panel appears in any battle whose player hero is an avenger, except where the client disables it (see §5).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.view.ui.AvengerBattleSkillView` (`CM/battle/view/ui/AvengerBattleSkillView.as`) | labels "Principal" / "Secundário" (`SelfAvengerView.majorText.text`, `SelfAvengerView.minorText.text`) | Avenger skill panel | Created by `BottomBar` when `selfInfo.heroInfo.isAvenger && avengerFightSkills.length > 0` (`M10/battle/view/bottom/BottomBar.as:102-110`) | SP bar `182 * sp / avengerSpMax` and number `int(sp/10)` (:327-339); 2 fight items from `avengerFightSkills` sorted by MasterType (:364-375); 4 wait items = `avengerAllSkills` minus fight skills, sorted by MasterType, Index (:377-391); swap cooldown seconds text, decremented locally every second (:254-270) |
| `battle.view.ui.AvengerSkillItemListController` (`CM/battle/view/ui/AvengerSkillItemListController.as`) | none | Enable/disable logic and swap sender | Same | Cooldowns per fight skill (:45-91); SP and buffer driven enabling (:285-326) |
| `battle.view.roles.HeroRoleView` (`CM/battle/view/roles/HeroRoleView.as`) | none | Aura on the hero sprite | Any battle | `core.avengerEffectzd<min(10, ceil(avengerDegree/2))>` when `avengerDegree > 0` (:65-94, 218-233) |

## 3. Routes (client to server)

### A1. Swap a standby skill into the active slots

| Item | Value |
|---|---|
| UI control | click on a standby skill in the panel opened by key M or the open button |
| Client sender | `AvengerBattleSkillView.__waitSkillClick` (`CM/battle/view/ui/AvengerBattleSkillView.as:308-325`) sends notification `AVENGER_SKILL_REPLACE`; `AvengerSkillItemListController.__avengerskillReplace` (`CM/battle/view/ui/AvengerSkillItemListController.as:231-271`) -> `SocketSendManager.sendBattleAvengerChange(battleId, skillId, livingId)` (`CM/yishi/service/managers/SocketSendManager.as:268-276`) |
| Client checks, in order | 1. `avengerWaitSec == 0` (panel cannot open and clicks are ignored during the cooldown, :272-291, 315-318); 2. skill is in `getWaitSkillIds()` (`CM/yishi/datas/objects/HeroRoleInfo.as:502-513`); 3. hero not `isWaitingChangeBody`; 4. battleType not in {3844, 3845, 3847, 16, 3868} and not a child battle (:235-261) |
| Route | client to server, **10521 (0x2919) B_AVENGER_SWITCH_SKILL** |
| Request | `battle.UseSkillMsg`: `battle_id (#1, STRING)` current battle id; `hero_id (#2, INT32)` = the hero `livingId`; `skill_id (#3, INT32)` = SkillTempInfos TemplateId of the standby skill. Tags verified at `CM/com/road/yishi/proto/battle/UseSkillMsg.as:95-106` |
| Expected response | **4591 (0x11ef) U_C_UPDATE_AVENGER_SKILL** to the player with the new fight list and `avengerLeftCd` = swap cooldown |

### A2. Use an active avenger skill (owned by the battle feature)

Clicking a fight item fires `ACTION_SKILL_BattleNotic` (`AvengerBattleSkillView.as:293-306`); the generic `SkillItemListController` resolves avenger fight skills (`CM/battle/view/ui/SkillItemListController.as:1048-1054`) and sends **10008 (0x2718) U_B_HERO_ORDER** `UseSkillMsg{battle_id, hero_id, skill_id}` (`SocketSendManager.as:208-216`). Response 75 U_B_HERO_ORDER then the normal attack flow; plus **4589** with the reduced avenger SP. Listed here only because the engine must accept avenger skills (see §8).

## 4. Server messages (server to client)

| Opcode | Message, fields (tag, type) | Client receiver | When | Client effect |
|---|---|---|---|---|
| 157 (0x009d) U_B_PREPARE (battle feature) | `battle.HeroMsg` avenger fields (tags verified at `CM/com/road/yishi/proto/battle/HeroMsg.as:3063-3093`): `avengerSp (#106, INT32)` initial SP; `avengerCd (#107, INT32)` (not read by the client); `avengerLeftCd (#108, INT32)` remaining swap cooldown in seconds; `avengerSkills (#109, INT32, repeated)` fight skill template ids; `avengerAllSkills (#110, INT32, repeated)` the 6 skill template ids; `avengerGrade (#111, INT32)` body grade | `SocketGameReader.readHeroRoleInfo` (`CM/map/internals/utils/SocketGameReader.as:233, 298-301, 329`) | Battle creation, for every hero | `updateAvengerSp`, fight/all lists, `avengerWaitSec`, `avengerGrade`; all avenger skills are preloaded (`CM/battle/transaction/CreateGameTransaction.as:228, 565-587`) |
| 4589 (0x11ed) U_C_UPDATE_AVENGER_SP | `battle.AwakeMsg{awake (#1, AwakeInfoMsg, repeated)}`; `AwakeInfoMsg{living_id (#1, INT32), awake (#2, INT32) = avenger SP, childAwake (#3, INT32) unused here}` (tags verified at `.../battle/AwakeMsg.as:24-25`, `AwakeInfoMsg.as:97-108`) | `BattleAvengerSpTransaction.configure` (`CM/battle/transaction/BattleAvengerSpTransaction.as:21-60`), registered at `CM/battle/transaction/BattleTransactionManager.as:134`, routed as `GAME_CMD` (`CM/yishi/service/managers/SocketManager.as:168-171`) | Whenever an avenger hero's SP changes (gain, skill cost) | `HeroRoleInfo.updateAvengerSp` clamps to 0..70 and fires `AVENGER_SP` (`HeroRoleInfo.as:224-241`); fight items enable when `sp >= Cost`. Ignored when battleType 3845, child battles and monster battles (:36-47); requires both `hasAwake` and `hasLivingId` (:50) |
| 4591 (0x11ef) U_C_UPDATE_AVENGER_SKILL | `avenger.AvengerBattleSkillMsg`: `avengerLeftCd (#1, INT32)` swap cooldown seconds; `avengerSkills (#2, INT32, repeated)` fight skill ids; `avengerAllSkills (#3, INT32, repeated)` all 6 ids (tags verified at `CM/com/road/yishi/proto/avenger/AvengerBattleSkillMsg.as:55-68`) | `BattleAvengerSkillChangeTransaction.configure` (`CM/battle/transaction/BattleAvengerSkillChangeTransaction.as:16-28`), registered at `BattleTransactionManager.as:144` | Response to 10521, only to the swapping player | Overwrites `selfHero.avengerFightSkills`, `avengerAllSkills`, `avengerWaitSec`; fires `AVENGER_SKILL_CHANGE` -> `updateAvengerSkills` (`AvengerSkillItemListController.as:374-377`) |
| 75 (0x004b) U_B_HERO_ORDER (battle feature) | `HeroOrderMsg` | `AvengerSkillItemListController.__skillUseServerBack` (:169-229) | Response to 10008 with an avenger skill | If `result != 0`, re-enables after 1000 ms (ignored in battleTypes 3844, 3845, 3847, 3867, 3868, 3866, 3864, 3889) |

No error code for 10521: on rejection send nothing (the client keeps its state).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Panel shown | player hero `isAvenger` and `avengerFightSkills` not empty | `BottomBar.as:102-110` |
| SP range | 0..`avengerSpMax` = 70 (client constant) | `HeroRoleInfo.as:93, 229-241` |
| Skill SP cost | SkillTempInfos `Cost`: 50 major (MasterType 500), 20 minor (501). Usable when `avengerSp >= Cost` | `AvengerBattleSkillView.as:219-252`; `AvengerSkillItemListController.as:285-326` |
| SP gain | unknown; the server pushes 4589 *(open question: per turn or per action, like awaken)* | |
| Fight slots | 2 (`numCount` 200/201, keys B and N); standby 4 (202..205, keys U, H, I, J) | `docs/battle/hud.md` (AvengerBattleSkillView table) |
| Swap | standby skill replaces the fight skill of the same MasterType *(assumption: layout "Principal"/"Secundário" and 1 major + 1 minor in the formation)* | `AvengerBattleSkillView.as:139-173` |
| Swap cooldown | `UpGrade(Types 152, Grades = 30 if holy else vocationGrades).ActiveObject` seconds (30 down to 1) *(assumption: the Eye text says it sets the cooldown of the "Braços da Vingança")* | `M5/avenger/view/AvengerEyeView.as:91-100`; `AvengerEyeView.curDescText.text` |
| Client countdown | `avengerWaitSec` is decremented by the client each second; the server is the authority via `avengerLeftCd` | `AvengerBattleSkillView.as:254-270` |
| Battle types without avenger use/swap | 3844, 3845, 3847, 16 (arena), 3868, and child battles | `AvengerSkillItemListController.as:129-160, 231-261` |
| Battle type 25 | fight items are not re-enabled by buffer changes | `AvengerSkillItemListController.as:310-312` |
| Persistence | the swap only affects the current battle *(assumption: the formation in [skills.md](skills.md) changes only through 8657 op 1)* | |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/SkillTempInfos.xml` SonType 511..536 | avenger skills | `TemplateId`, `MasterType`, `Index`, `Cost`, `CoolDown` (1000), `UseWay` (1), `BufferIds`, effects |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 152 | swap cooldown | `Grades`, `ActiveObject` |
| `raw/xml/tempinfos/AvengerBodyTemplates.xml` | aura tier | `BodyType` of `avengerGrade` |

## 7. Persistent state

None. SP, fight list and cooldown are battle runtime state held by the battle engine. The initial fight list comes from `avenger.skills.is_in_formation` ([skills.md](skills.md)).

## 8. Backend implementation notes

- **Battle creation** (battle feature, `docs/battle/server-engine.md` §9.3): for each hero whose player is an avenger, fill `HeroMsg`:
  - `avengerSkills` = `skill_template_id` of the 2 formation skills;
  - `avengerAllSkills` = `skill_template_id` of the 6 skills;
  - `avengerSp` = initial avenger SP *(assumption: 0)*; `avengerLeftCd` = 0; `avengerGrade` = `avenger.profiles.body_grade`;
  - the hero stats include body, skill, hole and pearl bonuses.
  This applies to every battle type; there is no avenger battleType and no map change.
- **Engine state per avenger hero:** `avenger_sp` (0..70), `fight_skills` (2 ids), `all_skills` (6 ids), `swap_cooldown_until`.
- **Skill use (10008), extension of the battle engine `Battle::order`:** accept `skill_id` when it is in `fight_skills` (it is not in the normal `skills` list) and `avenger_sp >= Cost`; on cast subtract `Cost` from `avenger_sp` (not from the normal SP) and push 4589 to all battle viewers. The normal "skill not on the hero bar" rejection must not fire for avenger fight skills.
- **Handler `avenger::battle::handle_switch_skill` (10521):**
  1. battle `battle_id` exists and the sender is a participant;
  2. `hero_id` is the sender's hero and the hero is alive;
  3. battleType not in the client-excluded set (3844, 3845, 3847, 16, 3868) and not a child battle;
  4. `now >= swap_cooldown_until`;
  5. `skill_id` in `all_skills` and not in `fight_skills`;
  6. replace the fight skill with the same MasterType; set `swap_cooldown_until = now + cooldown` (Types 152 by the player's eye level);
  7. push 4591 `{avengerLeftCd = cooldown, avengerSkills, avengerAllSkills}` to the sender.
- **SP gain:** push 4589 `AwakeMsg{awake:[{living_id, awake = avenger_sp}]}` whenever it changes *(open question for the gain rule)*.

## 9. Open questions and assumptions

1. Avenger SP gain rule and initial value are not in the client (only the cap 70).
2. *(assumption)* A swap replaces the fight skill of the same MasterType.
3. *(assumption)* The swap cooldown equals Types 152 `ActiveObject` of the eye level.
4. `HeroMsg.avengerCd (#107)` is never read by the client; its meaning (maybe the full cooldown) is unknown.
5. Whether the server should also reject swaps in battle type 16 (arena, auto mode) as the client does.

## 10. Implementation checklist

- [ ] HUD `AvengerBattleSkillView` + `AvengerSkillItemListController` (client already exists; verify against the backend)
- [ ] `HeroMsg` avenger fields #106-#111 filled at battle creation
- [ ] Engine: avenger SP state, cost check and deduction for avenger fight skills in 10008
- [ ] Route 10521 -> `avenger::battle::handle_switch_skill`
- [ ] Server message 4589 (AwakeMsg with avenger SP)
- [ ] Server message 4591 (AvengerBattleSkillMsg)
- [ ] Rule: swap cooldown from Types 152 and eye level
- [ ] Rule: excluded battle types
- [ ] Test: avenger skill with insufficient SP rejected; with enough SP cast and SP reduced
- [ ] Test: swap during cooldown rejected; swap after cooldown pushes 4591
- [ ] Test: non-avenger hero gets no avenger fields and no panel
