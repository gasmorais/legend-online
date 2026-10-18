# Special skill bars: avenger skill switch (10521) and war soul skills (10522)

Module `special-skills` of the feature [Motor de batalha](README.md). Path prefixes as in [lifecycle.md](lifecycle.md); **ASILC** = `CM/battle/view/ui/AvengerSkillItemListController.as`, **SWV** = `CM/battle/view/ui/SkillWarsoulView.as`. Feature side specifications: avenger in [../avenger/battle.md](../avenger/battle.md) (skills, swap cooldown, persistence in [../avenger/skills.md](../avenger/skills.md)); war soul in [../theseus/war-soul.md](../theseus/war-soul.md). Client detail: `docs/battle/rules.md` §12.5-§12.6, `docs/battle/hud.md` §6 (`AvengerBattleSkillView`, `SkillWarsoulView`).

This file specifies what the **battle engine** must do to host both gauges and bars; the owning features supply the skill lists and parameters.

## 1. Overview

| System | Gauge | Bar | Use | Swap | Gauge push |
|---|---|---|---|---|---|
| Avenger ("Vingador") | avenger SP 0..70 (`HeroMsg.avengerSp`) | 2 main skills (keys B/N), 4 standby (U/H/I/J, panel M) | 10008 with the main skill id; usable when `avengerSp >= Cost` (50 major, 20 minor) | 10521 swaps a standby skill in; cooldown `avengerLeftCd` s | 4589 |
| War soul ("Espírito da Guerra", Teseu) | fury 0..100 (`HeroMsg.warSoulSp`) | up to 3 skills (`HeroMsg.warSoulSkills`) | 10522; usable when `warSoulSp >= Cost` (100 for the active skills) | none | 4311 |

Both are shown only for the player's own hero and are ignored in child battles, monster battles (3884) and 3845 (`CM/battle/transaction/BattleAvengerSpTransaction.as:36-47`, `BattleWarsoulSpTransaction.as:36-47`). Skill use is blocked by the client in battleTypes 3844, 3845, 3847, 16, 3868 and child battles (`ASILC:129-160`, `SWV:320-343`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.view.ui.AvengerBattleSkillView` (CM) | "Principal" / "Secundário" (`SelfAvengerView.majorText.text` / `minorText.text`) | avenger SP bar and skills | `BottomBar` when `heroInfo.isAvenger` and `avengerFightSkills` not empty (`M10/battle/view/bottom/BottomBar.as:102-110`) | SP bar 182 px x `sp/70`, number `sp/10` (`asset.SelfAvengerView.numBmd`); 2 main items; standby panel; swap cooldown (`asset.SelfAvengerView.closeImage`) |
| `battle.view.ui.SkillWarsoulView` + `BattleWarsoulSkillItem` (CM) | none | war soul fury and skills | `BottomBar` when `VersionSwitch.WARSOUL` (true) (`BottomBar.as:113-119`) | `asset.battle.warsoul.spBar` masked by `sp/100`, number; 3 items 34 x 34 (`SWV:85-123`) |

## 3. Routes (client to server)

### X1. Avenger skill switch

| Item | Value |
|---|---|
| UI control | key M or the open button, then click a standby ("Secundário"/"Principal") skill |
| Client sender | `AvengerBattleSkillView.__waitSkillClick` (`CM/battle/view/ui/AvengerBattleSkillView.as:308-325`) -> notification `AVENGER_SKILL_REPLACE` -> `ASILC.__avengerskillReplace` (`ASILC:231-271`) -> `SocketSendManager.sendBattleAvengerChange(battleId, skillId, livingId)` (`CM/yishi/service/managers/SocketSendManager.as:268-276`) |
| Client checks | `avengerWaitSec == 0` (panel closed during the cooldown, `AvengerBattleSkillView.as:272-291`); skill among the standby ids (`CM/yishi/datas/objects/HeroRoleInfo.as:502-513`); not `isWaitingChangeBody`; battleType not 3844, 3845, 3847, 16, 3868 and not a child battle |
| Route | C>S **10521 (0x2919) B_AVENGER_SWITCH_SKILL** |
| Request | `battle.UseSkillMsg`: `battle_id (#1, STRING)`; `hero_id (#2, INT32)` = hero `living_id`; `skill_id (#3, INT32)` = standby skill template id |
| Expected response | **4591** to the requester with the new main list and the swap cooldown; on rejection nothing |
| Owner handler | `avenger::battle::handle_switch_skill` ([../avenger/battle.md](../avenger/battle.md) §8), executed inside the battle actor |

### X2. Avenger main skill use

Click on a main item -> `ACTION_SKILL_BattleNotic` -> `SkillItemListController` resolves the avenger template (`CM/battle/view/ui/SkillItemListController.as:1048-1054`) -> **10008** `UseSkillMsg {battle_id, hero_id, skill_id}` ([skills-effects.md](skills-effects.md) S1). Reply 75 (avenger controller `ASILC:169-229` re-enables after 1000 ms on error).

### X3. War soul skill use

| Item | Value |
|---|---|
| UI control | click a war soul item |
| Client sender | `BattleWarsoulSkillItem` click -> `Warsoul.skillUse` (`CM/battle/view/ui/BattleWarsoulSkillItem.as:64-71, 111-148`) -> `SWV.__skillUse` (`SWV:308-366`) -> `SocketSendManager.gameCommand2` (`SocketSendManager.as:218-226`); tutorial path sends 10022 first and the request 400 ms later |
| Client checks | not `isWaitingChangeBody`; battleType not 3844, 3845, 3847, 16, 3868, not a child battle; item enabled when `warsoulSp >= Cost` and the own hero has HP (`SWV:137-164`); the view disables itself on send |
| Route | C>S **10522 (0x291a) B_USE_WARSOUL_SKILL** |
| Request | `battle.UseSkillMsg`: `battle_id (#1, STRING)`; `hero_id (#2, INT32)` = hero `living_id`; `skill_id (#3, INT32)` = war soul skill template id (for example 76001101 "Hab. do Espírito da Guerra - Água", MasterType 760, Cost 100, CoolDown 1000, AcceptObject 14) |
| Expected response | 75 at once (`SWV:192-252` listens; `result != 0` re-enables after 1 s); then 153 with `order_id = skill_id`; then 4311 with the reduced fury |

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When |
|---|---|---|---|
| 157 (inside `HeroMsg`) | avenger: `avengerSp (#106, INT32)`, `avengerCd (#107, INT32)` (unread), `avengerLeftCd (#108, INT32)` s, `avengerSkills (#109, INT32, repeated)` main ids, `avengerAllSkills (#110, INT32, repeated)` 6 ids, `avengerGrade (#111, INT32)` aura tier; war soul: `warSoulSkills (#114, INT32, repeated)` up to 3 ids, `warSoulSp (#115, INT32)`, `warSoulType (#116, INT32)` element type | `SocketGameReader.readHeroRoleInfo` (`CM/map/internals/utils/SocketGameReader.as:256-258, 298-301, 329`) | battle creation |
| 4589 (0x11ed) U_C_UPDATE_AVENGER_SP | `battle.AwakeMsg {awake (#1, AwakeInfoMsg, repeated)}`, `AwakeInfoMsg {living_id (#1, INT32), awake (#2, INT32) = avenger SP, childAwake (#3, INT32) unused}` | `BattleAvengerSpTransaction` (`CM/battle/transaction/BattleAvengerSpTransaction.as:21-60`), queued | avenger SP changed (gain or cost) |
| 4591 (0x11ef) U_C_UPDATE_AVENGER_SKILL | `avenger.AvengerBattleSkillMsg`: `avengerLeftCd (#1, INT32)` swap cooldown s; `avengerSkills (#2, INT32, repeated)` main ids; `avengerAllSkills (#3, INT32, repeated)` all ids | `BattleAvengerSkillChangeTransaction` (`CM/battle/transaction/BattleAvengerSkillChangeTransaction.as:16-28`), queued | reply to 10521, requester only |
| 4311 (0x10d7) U_C_WARSOUL_SP | `battle.AwakeMsg`, `awake` = fury | `BattleWarsoulSpTransaction` (`CM/battle/transaction/BattleWarsoulSpTransaction.as:21-60`), queued | fury changed |
| 75 (0x004b) U_B_HERO_ORDER | `HeroOrderMsg` ([skills-effects.md](skills-effects.md) §4.4) | `ASILC:169-229`, `SWV:192-252` | reply to 10008 (avenger) and 10522 |

All gauge pushes go through the battle queue: set header `extend2` to the frame of the action that changed the gauge so the bar updates in step with the animation.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Avenger SP cap | 70 | `HeroRoleInfo.as:93, 229-241` |
| Avenger skill cost | `Cost` 50 (major, MasterType 500) / 20 (minor, 501), paid from avenger SP | [../avenger/battle.md](../avenger/battle.md) §5 |
| Avenger SP gain | unknown *(open question)* | |
| Avenger swap cooldown | seconds from `UpGrade Types 152` by eye level; the client counts down locally | [../avenger/battle.md](../avenger/battle.md) §5 |
| Swap rule | standby skill replaces the main skill of the same MasterType *(assumption)* | same |
| War soul fury cap | 100 | `HeroRoleInfo.as:103, 248-260` |
| War soul fury gain | `warsoul_add_sp` = 20 per round ("每回合恢复怒气") *(assumption: round = one action of the hero)* | `ConfigInfos.xml` |
| War soul skill cost | `Cost` (100 for active skills), paid from fury, not from SP | `SkillTempInfos.xml` MasterType 760 |
| War soul client bug | after the first skill without enough fury `_enable` stays false (`SWV:396-426`): the bar may look disabled; rely on the server state | `docs/battle/rules.md` §12.6 |
| Excluded battleTypes | 3844, 3845, 3847, 16, 3868, child battles; gauges ignored in 3845, child battles, 3884 | §1 |
| Battle type 25 | avenger items not re-enabled by buffer changes | `ASILC:310-312` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/SkillTempInfos.xml` | avenger skills (SonType 511..536), war soul skills (MasterType 760) | `TemplateId`, `MasterType`, `Index`, `Cost`, `CoolDown`, `UseWay`, `AcceptObject`, `BufferIds` |
| `raw/xml/tempinfos/AvengerSkillTemplates.xml`, `AvengerBodyTemplates.xml`, `UpGradeTempInfos.xml` (Types 152) | avenger data | owned by [../avenger/README.md](../avenger/README.md) |
| `raw/xml/tempinfos/WarSoulStrengthenTmpls.xml` | war soul active/passive skills (`OpenActiveSkill`, `OpenPassiveSkill`; 54 active ids) | owned by [../theseus/README.md](../theseus/README.md) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `warsoul_add_sp` = 20 | `ConfigValue` |

## 7. Persistent state

None in the battle. Avenger formation and war soul equipment are persisted by their features; gauges, swaps and cooldowns are battle runtime state.

## 8. Backend implementation notes

- Unit extension (from [units.md](units.md)): `avenger: Option<AvengerState { sp, main: [i32; 2], all: Vec<i32>, swap_ready_at_frame }>`, `war_soul: Option<WarSoulState { sp, skills: Vec<i32>, element: i32 }>`, filled by `BattleContributor` implementations of `avenger` and `theseus`.
- **10008 path** (`battle::skills::handle_hero_order`): when `skill_id` is in `avenger.main`, check `avenger.sp >= Cost` instead of the normal SP and skip the "skill on the bar" check; on cast subtract from `avenger.sp` and push 4589.
- **`battle::special::handle_avenger_switch` (10521)**: actor side wrapper that calls `avenger::battle::handle_switch_skill` rules (participant, own alive hero, battleType allowed, `frame >= swap_ready_at_frame`, skill in `all` and not in `main`), swaps, sets the cooldown, replies 4591 to the requester.
- **`battle::special::handle_war_soul_skill` (10522)**: validate like 10008 but against `war_soul.skills` and `war_soul.sp >= Cost`; reply 75; queue as the hero's pending request; on cast subtract `Cost` from fury and push 4311.
- **Gauge gain:** after each action of a hero with a war soul add `warsoul_add_sp` (cap 100) and push 4311 when it changes; avenger SP gain per the avenger feature's rule (push 4589).
- AI/auto: the auto chooser may use avenger and war soul skills when affordable *(assumption)*.

## 9. Open questions and assumptions

1. Avenger SP gain rule and initial value; `avengerCd` meaning.
2. *(assumption)* war soul "round" = one action of the hero.
3. Whether `warSoulType` (element) changes skill effects in battle (type advantage is server side, values not in the client).
4. Whether auto battle used avenger and war soul skills.

## 10. Implementation checklist

- [ ] `HeroMsg` avenger fields #106-#111 and war soul fields #114-#116 at creation
- [ ] 10008 acceptance of avenger main skills with avenger SP cost; push 4589
- [ ] Route 10521 -> `battle::special::handle_avenger_switch` -> 4591
- [ ] Route 10522 -> `battle::special::handle_war_soul_skill` -> 75, 153, 4311
- [ ] Fury gain +20 per hero action, cap 100
- [ ] Excluded battleTypes for both systems
- [ ] Test: avenger skill with SP 40 and Cost 50 refused; swap during cooldown refused
- [ ] Test: war soul skill at fury 100 accepted and fury drops to 0
