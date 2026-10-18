# Skill, buff and effect execution

Module `skills-effects` of the feature [Motor de batalha](README.md). Path prefixes as in [lifecycle.md](lifecycle.md); **SILC** = `CM/battle/view/ui/SkillItemListController.as`. Client detail: `docs/battle/rules.md` §2-§6, §12, §13 and `docs/battle/hud.md` §5-§6. Numbers and damage values are in [damage.md](damage.md); automatic skill choice in [ai-auto.md](ai-auto.md); avenger and war soul skills in [special-skills.md](special-skills.md).

## 1. Overview

The server decides everything: who acts, with which skill, on which targets, how much damage, which buffs. Each unit action becomes one `AttackOrderMsg` (153), or a list of them (4102, goddess stage). The client only animates: it looks up the skill template (`SkillTempInfos`), its action frames (`ActionInfos`) and plays them, applying the damage values in the order the server gives.

A player influences the fight only by **requests**: use a skill (10008 and variants), use a battle item (10499), a trial prop (10507), a marriage skill (10509), a stone trigger skill (10523), transform (pet awaken 700001/700002 via 10008), answer a QTE (10015). The server answers 75 (`HeroOrderMsg`) or 158 (`ItemUseResultMsg`) at once and later emits the matching 153 when the unit is free.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.view.ui.SkillItemListView` + `SkillItemListController` (CM) | "Moldura de uso de habilidade" (`battle.view.ui.SkillItemListController.str`) | Hero skill bar: slots 1..5 (keys 1..5), talent, seal (Q, Lv 50), marriage (E), guardian R/F (Lv 70), runes Z/X (Lv 35/40), trial props | `BottomBar` | icons, cooldown masks, cost state, ban icon (`asset.battle.BanAsset`) when a buff blocks the skill |
| `PetSkillItemListView`, `ChildPveSkillItemListView`, `ChildCommonSkillItemListView`, `MonsterCommonSkillItemListView`, `PetSacristyItemListView` (CM) | none | Bars for pet, child, monster and sacristy battles | `docs/battle/hud.md` §6 | per mode skills |
| `battle.qte.QteView` (M10) | none | QTE key sequence | 75 success with template `QTETime > 0` (never in BR: all 22 716 templates have 0) | keys A/S/D/W |
| `SkillNameView`, `DamageNumView`, buff icons (`BufferContainer`, `SelfBufferView`, `BossBufferContainer`) | buff tooltip: "N turnos", "N vezes", "Não pode despersar/purificar", "Pode no máximo acumular camadas: N camadas" | feedback | 153 | skill names, numbers, buffs |

## 3. Routes (client to server)

All skill requests share the client gate in `BattleSkillItemII.__iconClick` (`CM/battle/view/ui/BattleSkillItemII.as:369-410`): slot not locked, visible, `battleType != 16`, button enabled, has data, **not cooling down**; any click first cancels auto fight (`setAutoFight(2)`, :392). The list is enabled only when `sp + Cost >= 0` and `hitPoint + HitPointCost >= 0` (`CM/battle/view/ui/SkillItemListView.as:626-680`), no stun (`AttackType 19` buff), no boss control (4999), not dead, battle not over, no pending request (`currentReadySkillId`). After sending, the bar is disabled until 153 of that skill completes or 75 reports an error (re-enabled after 1000 ms).

`SILC.__skillUse` (`SILC:631-732`) returns early (sends nothing) when `isWaitingChangeBody`, battleType in {3844, 3845, 3847, 16, 3868} or a child battle.

### S1. Use a hero skill

| Item | Value |
|---|---|
| UI control | skill slots 1..5, talent, seal, guardian profound R/F, avenger main skills (B/N), pet awaken figure or Space |
| Client sender | `SILC.__skillUse` -> `SocketSendManager.gameCommand` (`CM/yishi/service/managers/SocketSendManager.as:208-216`); tutorial (`newbieProcess < 19000`) first sends 10022 then 10008 after 400 ms (`SILC:700-708`) |
| Route | C>S **10008 (0x2718) U_B_HERO_ORDER** |
| Request | `battle.UseSkillMsg`: `battle_id (#1, STRING)`; `hero_id (#2, INT32)` = acting unit `living_id`; `skill_id (#3, INT32)` = `SkillTempInfos.TemplateId` |
| Special skill ids | 700001 "Transformação" (pet form, needs awaken 3000), 700002 "Cancelar Transformação"; 700003 / 700004 guardian transformation (sent with 10516) (`M10/battle/view/bottom/SelfAwakenView.as:245-356`) |
| Expected response | 75 at once; on acceptance a later 153 with `order_id = skill_id` and `living_id = hero_id` |

### S2. Other skill request variants (same `UseSkillMsg`, same 75 reply)

| Opcode | Name | When (sender) | `hero_id` | Owner |
|---|---|---|---|---|
| 10516 (0x2914) | B_CHILD_ORDER | guardian profound skill R/F (`SILC:685-694`) or child battle bar (`ChildCommonSkillItemListController.as:187-215`) | child `living_id` | [../guardians/README.md](../guardians/README.md) |
| 10519 (0x2917) | B_PET_ORDER | pet sacristy bar, 3866/3864 (`PetSacristyItemListController.as:147-166`) | pet `living_id` | [../einherjar/README.md](../einherjar/README.md) |
| 10520 (0x2918) | B_MONSTER_ORDER | monster bar, 3884 (`MonsterCommonSkillItemListController.as:131-149`) | monster `living_id` | [../monsters/README.md](../monsters/README.md) |
| 10521 (0x2919) | B_AVENGER_SWITCH_SKILL | avenger skill swap | hero `living_id` | [special-skills.md](special-skills.md) |
| 10522 (0x291a) | B_USE_WARSOUL_SKILL | war soul skill | hero `living_id` | [special-skills.md](special-skills.md) |
| 10523 (0x291b) | B_USE_STONETRRIGERSKILL | `UseWay 4` "Finalização" stone trigger skills (`SILC:345-351, 696-699`; `SocketSendManager.as:583-591`) | hero `living_id` | [../skills/rune-stones.md](../skills/rune-stones.md) |
| 14001 (0x36b1) | B_REMOTE_PET_ORDER | remote pet 3844 / child PvE 3845 bars (`PetSkillItemListController.as:139-151`; `ChildPveSkillItemListController.as:144-157`) | not set | einherjar / guardians |
| 25240 (0x6298) | CR_CHILD_PVP_AID | guardian arena aid icons, 3911 (`ChildCommonSkillItemListController.as:217-227`) | child `living_id`; `skill_id` = aid index | [../guardians/nswar.md](../guardians/nswar.md) |

### S3. Use a battle item (rune Z / X)

| Item | Value |
|---|---|
| Client sender | `SILC.__skillUse` (`SILC:717-723`) -> `SocketSendManager.sendUseItemInBattle` (`SocketSendManager.as:373-381`) |
| Client checks | slot level (Lv 35 for Z, 40 for X), `useCount > 0`, shared rune cooldown `RuneCommonCD` = 20000 ms (`SkillItemListView.as:395-412`) |
| Route | C>S **10499 (0x2903) B_USE_ITEM** |
| Request | `battle.BattleItemMsg`: `userId (#1, INT32)` = hero `living_id`; `battleId (#2, STRING)`; `skillTempId (#8, INT32)` = item skill template; other fields unset |
| Expected response | 158 to the user (and to all participants for the visual, see §4.5); then 153 of the item skill |

### S4. Use a trial prop

| Item | Value |
|---|---|
| Client sender | `SILC:724-730` -> `SocketSendManager.sendUseBattleTrialProp(battleId, prop.id, livingId)` (`SocketSendManager.as:258-266`) |
| Client checks | battleTypes 25, 3842, 293, 315, 3859, 3860, 296 show trial props (`SkillItemListView.as:96-131`); `useCount > 0` and prop cooldown (`TrialInfoMsg.param4`) |
| Route | C>S **10507 (0x290b) B_USE_TRIAL** |
| Request | `battle.BattleItemMsg`: `userId (#1, INT32)` = hero `living_id`; `battleId (#2, STRING)`; `skillTempId (#8, INT32)` = trial prop id (`TrialInfoMsg.skillId`) |
| Expected response | 158 with `type = 2`, `uItemId` = prop index, `count` = remaining uses; then 153 |

### S5. Use the marriage skill (slot E)

| Item | Value |
|---|---|
| Client sender | `SILC:679-682` -> `SocketSendManager.sendUseMarrSkill` (`SocketSendManager.as:573-581`) |
| Route | C>S **10509 (0x290d) B_USE_MARRSKILL** |
| Request | `battle.BattleItemMsg`: `userId (#1, INT32)` = hero `living_id`; `battleId (#2, STRING)`; `skillTempId (#8, INT32)` = marriage skill template |
| Expected response | 158 with `type = 3`, `temp_id` = skill, `count` = remaining uses; then 153. Uses come from `HeroMsg.marSkills` ([../marriage/README.md](../marriage/README.md)) |

### S6. QTE answer

`QteView` success -> after 400 ms `BattleSocketOuterManager.sendQTE` (`M10/battle/qte/QteView.as:144`; `M10/battle/net/BattleSocketOuterManager.as:19-26`) -> C>S **10015 (0x271f) U_B_QTE**, `battle.QteMsg {battle_id (#1, STRING), server_name (#2, STRING)}`. Never triggered with BR templates (`QTETime = 0`). Server: accept and ignore, or apply a bonus to the pending skill *(assumption)*.

### S7. Fight mode (dead)

C>S **10016 (0x2720) U_B_FIGHT_MODE** `AttackModeMsg {battle_id, server_name, mode}` from `AttackModeView`, which is never instantiated: never sent. Ignore.

## 4. Server messages (server to client)

### 4.1 153 (0x0099) U_B_ATTACKING: one unit action

`battle.AttackOrderMsg`; receiver `BattleAttackTransaction.configure` (`CM/battle/transaction/BattleAttackTransaction.as:75-172`) through the queue; parser `BattleFunctionHelper.readSkill` (`CM/battle/utils/BattleFunctionHelper.as:151-249`).

| Field | Meaning |
|---|---|
| `battle_id (#1, STRING)` | must match, else ignored |
| `frame (#2, INT32)` | server frame now (clock sync, [lifecycle.md](lifecycle.md) §5) |
| `order_id (#3, INT32)` | skill template id; 0 = empty action (buffs only) |
| `is_passive (#4, BOOL)` | passive trigger flag |
| `living_id (#5, INT32)` | acting unit; unknown unit = packet dropped |
| `sp (#6, INT32)` / `sp_added (#7, INT32)` | own hero SP after the action / delta (client applies delta then corrects to `sp` after 300 ms) |
| `damages (#8, DamageMsg, repeated)` | per hit per target, **grouped by target** (all hits of target 0, then target 1); `hits = len / unique targets` ([damage.md](damage.md) §4.1) |
| `exec_frame (#9, INT32)` | frame at which the skill may start (`liftTime`); equal to `frame` in the mock |
| `frame_num (#10, INT32)` | unused |
| `attack_millis (#11, STRING)` | "YYYY-MM-DD hh:mm:ss", world boss HP sync |
| `buffers (#12, BufferMsg, repeated)` | buffs added, triggered or removed by this action (§4.3) |
| `awakenSoldiers (#13, SoldierMsg, repeated)` | units summoned by this action (appear with `awaken.AwakenAppearEffect`) |
| `attackOrderSeq (#14, INT32)` | sequence number (mock: from 1) |
| `cdTime (#15, INT32)`, `awake (#16, INT32)`, `awake_add (#17, INT32)` | unused by the client (gauges use 4600) |
| `waitRevives (#18, WaitReviveMsg, repeated)` | scheduled revive ([formation.md](formation.md) §4.6) |
| `hitPoint (#19, INT32)` | own hero attack points after the action |
| `curturn (#20, INT32)` | unused |
| `coexist (#21, INT32)` | 1 = titan skill (marks `titanSkillUsed`) |

Header `extend2` = `frame`. Rendering: skill class from template (`SkillFactory`, `CM/battle/skillsys/skills/SkillFactory.as:16-94`): `TemplateId 105` charge, `ActionId 3` Victory, `ActionId 4` defeat, frames with projectiles (`ActionType 11/12`) = ranged, else melee. Hits beyond the number of DAMAGE frames are never displayed (the server HP is still right because the client pre-applies all damages in `BloodHelper`).

### 4.2 4102 (0x1006) U_B_GODDESS_STAGE

`battle.AttackOrderListMsg {list (#1, AttackOrderMsg, repeated)}`: several orders played as one goddess stage; each is processed like 153 and at the end the goddess movie `asset.goddess.skill<Type>` plays (`CM/battle/transaction/BattleGoddessMovieTransaction.as:26-68`). A single 153 whose skill has `MasterType 80/81` also plays the movie. Owner of goddess skills: [../goddess/README.md](../goddess/README.md).

### 4.3 `battle.BufferMsg` (inside 153 `buffers` and `HeroMsg.buffers`)

Reader `SocketGameReader.readBufferII` (`CM/map/internals/utils/SocketGameReader.as:122-169`).

| Field | Meaning |
|---|---|
| `buffer_id (#1, INT32)` | instance id |
| `template_id (#2, INT32)` | `SkillBufferTempInfos.Id` (icon, effects, kind) |
| `source_id (#3, INT32)` / `target_id (#4, INT32)` | caster / holder `living_id` |
| `cur_turn (#5, INT32)` | remaining turns ("N turnos"); 0 = remove |
| `exec_frame (#7, INT32)` | stored only |
| `see_type (#8, INT32)` | 0 ADD, 1 EFFECTIVE (trigger, refresh), 2 REMOVE |
| `exe_way (#9, INT32)` | when it applies in the animation: 1 at action start, 2 on taking damage, 3 on dealing damage, 4 on parry (first hit) (`CM/battle/data/BufferEffectiveType.as:6-12`); on ADD the client uses the template `AddWay` instead |
| `pressed_num (#10, INT32)` | stack count (layers) |
| `damage (#11, DamageMsg, repeated)` | values the buff applies now; `order` = hit index at which it shows; bloodType 9 SP, 24 attack points, 26 belief, others = HP |
| `max_turn (#12, INT32)` | read on ADD, unused |
| `unSkillIds (#13, INT32, repeated)` | skills blocked while the buff is on (ban icon) |
| `isPermanent (#14, BOOL)` | permanent (survives `cleanBuffers(false)` in 311-313) |
| `cur_round (#15, INT32)` | remaining trigger count ("N vezes"); 0 = remove; overrides template `CountWay` |
| `max_round (#16, INT32)` | unused |
| `target_skill_id (#17, INT32)` | skill the buff modifies; part of the buff identity (`templateId + targetSkillId`) |

Client buff rules: the client never decrements turns; it removes a buff when `cur_turn == 0` or `cur_round == 0` arrives, or when `see_type == 2` (`docs/battle/rules.md` §13.2). `AttackType 19` = stun (skills disabled, `restricted`).

### 4.4 75 (0x004b) U_B_HERO_ORDER: skill request reply

`battle.HeroOrderMsg`: `battle_id (#1, STRING)`; `hero_index_id (#2, INT32)` = requesting unit `living_id`; `skill_id (#3, INT32)`; `result (#4, INT32)` 0 = accepted, non zero = refused; `cast_time (#5, INT32)`; `qte_time (#6, INT32)` ignored (the client uses the template); `targetIndexs (#7, INT32, repeated)` predicted target `living_id`s (aim markers when not on auto). Receivers: `SILC` (:863-1011), `AvengerSkillItemListController` (:169-229), `SkillWarsoulView` (:192-252), pet, child, monster and sacristy controllers; battleTypes 3844, 3845, 3847, 3867, 3868, 3866, 3864, 3889 ignore it in the hero bar. On `result != 0` the bar re-enables after 1000 ms. Send to the requester; sending to other players shows the skill icon over that hero (`SILC:939-953`).

### 4.5 158 (0x009e) U_B_USE_ITEM_RESULT

`battle.ItemUseResultMsg`: `uItemId (#1, INT32)` trial prop index (type 2); `bagPos (#2, INT32)`; `count (#3, INT32)` remaining uses; `result (#4, INT32)` 0 ok; `living_id (#5, INT32)` user unit; `temp_id (#6, INT32)` item/skill template; `type (#7, INT32)` 2 = trial prop, 3 = marriage skill, other = battle item. Receiver `SILC.__useBattleItemServerBack` (`SILC:761-830`, listener :244). Other players' clients show the item icon over the user.

### 4.6 77 (0x004d) U_B_FIGHT_MODE

`battle.AttackModeMsg`: `userId (#1, INT32)` unit `living_id`; `mode (#5, INT32)` 0 normal, 1 defense (blue), 2 assault (red); `fm_turn (#6, INT32)` turns left; `hero_sp (#7, INT32)` SP to add. Receiver `AttackModeTransaction` (`CM/battle/transaction/AttackModeTransaction.as:17-36`) tints the unit and its troops. Only needed if the server implements fight modes; the sending UI is dead.

### 4.7 Not to send

173 `U_C_SPECIAL_BUFFER` (`ShowPermanentBuffMsg {living_id (#1, INT32), buffer_id (#2, STRING)}`): listener never registered (`BattleAttackTransaction.as:35-68`). 4849 `U_B_RESTORE_HP`: no handler.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Request validation (mock) | battle running; `hero_id` is the requester's unit and alive; no pending request; template exists; skill on the unit's bar with `UseWay 1`; `sp + Cost >= 0`; cooldown expired | `docs/battle/server-engine.md` §7 |
| Extra validation | `hitPoint + HitPointCost >= 0`; not stunned (`AttackType 19`) nor controlled; skill not in any active buff's `unSkillIds`; battleType allows manual skills (not 16, 3844 hero bar, 3845, 3847, 3868, child battles for the hero bar); pet skills need pet form and `awaken + Cost >= 0`; 700001 needs awaken 3000 | `SkillItemListView.as:504-726`; `docs/battle/rules.md` §12.1.2 |
| Pending request | one per unit; runs on the first frame the unit is not busy, before its next automatic action | `docs/battle/server-engine.md` §3.3 |
| SP cost | `Cost` is added to SP on use (negative spends, positive gains), clamped 0..`spMax` | `docs/battle/server-engine.md` §6 |
| Cooldown | `CoolDown` ms from the action frame; initial cooldowns in 157 `coolDown`; form change applies `AppearCD` | same; `M10/battle/view/bottom/BottomBar.as:294-302` |
| Default attack | `UseWay 3` "Ataque Normal" (`DefaultSkill` of the template) has no cost or cooldown check | `docs/battle/server-engine.md` §3.4 |
| UseWay | 1 active (5448), 2 passive (17124), 3 default attack (76), 4 stone trigger "Finalização" (37), 5 "Dano ampliado" (31, unused by client) | `SkillTempInfos.xml` |
| Priority | 3 = super skill (profound effect, 618 skills), 4 = pet super skill (none in data) | `CM/yishi/datas/consant/SkillPriorityType.as:6-18` |
| Action duration (mock) | `max(Frame of ActionType 99, 10)` + 16 if the action has an ActionType 0 row (melee walk) + 4 frames; unknown ActionId = 34 frames | `docs/battle/server-engine.md` §3.3 |
| Hits per skill | number of `ActionType 3` rows (`Sex != 1`), else projectile rows (`ActionType 11/12`, `Sex != 0`), minimum 1 | same §5 |
| Targets (`AcceptObject`, mock mapping) | 4, 18, 24, 26, 27 self; 3 all enemies; 5 lowest HP ratio; 6 (and unknown) one enemy, front most column, nearest row; 7 back most column; 8 / 9 whole front / back column; 10 / 14 row / column of a random enemy; 15 random plus orthogonal neighbors; 1, 17, 25 one random; 2, 12 two random; 16, 21 two to four random; 19 one to two; 20 two to three | `docs/battle/server-engine.md` §4 (assumption beyond 4/3/6) |
| AcceptObject distribution | 4 (17893), 3 (1408), 1 (945), 6 (862), 5 (339), 12 (237), 16 (207), 7 (182), 8 (150), 17, 9, 10, 19, 2, 35, 14, 15, 20, 24, 21, 30, 28, 25, 18, 26, 0, 27 | `SkillTempInfos.xml` |
| Buffs per skill | `SkillTempInfos.BufferIds` CSV of `SkillBufferTempInfos.Id` | template |
| Buff duration | `ValidCount` turns (`-1` = permanent / until removed); `CountWay` triggers (`-1` = unlimited); stacks up to `PressCount` | template; tooltip `CM/battle/view/buffer/BufferListItemTip.as:95-157` |
| Turn | one action of the buff holder: the client refreshes buffs of a unit when that unit starts a skill (`BaseSkill.prepare -> refreshBufferTurn`) *(assumption: the server decrements `cur_turn` when the holder acts)* | `CM/battle/skillsys/skills/BaseSkill.as:128` |
| Buff identity | `template_id + target_skill_id` | `CM/yishi/datas/objects/RoleInfo.as:796-836` |
| Dispel | `Dispel != 0` = cannot be dispelled | template |
| Pet form | 700001 at the DAMAGE frame sets pet form, swaps the skill bar to `changeSkillId`, applies `AppearCD`; awaken drains with pet skill costs; at 0 the server sends 700002 | `docs/battle/rules.md` §12.3 |
| AI form change | skill 650493 switches the boss body to `HeroAis.ChangeIcon` (`boss032a`) | `BaseSkill.as:487-512`; `HeroAis.xml` |
| QTE | inert (`QTETime = 0` in all templates) | `docs/battle/rules.md` §12.2 |

Buff kinds the server must implement (`SkillBufferTempInfos.AttackType`, meaning derived from the pt-BR `BufferName` of each group, assumption where marked by "~"):

| AttackType | Count | Typical `AttackWay` | Meaning (from names) |
|---|---:|---|---|
| 15 | 1283 | 2 | damage taken +/- % |
| 20 | 970 | 3 | damage dealt +/- % |
| 305 | 527 | 1 | damage over time per turn (% of a value) / skill damage + % |
| 16 | 482 | 3 | crit rate +/- |
| 34 | 466 | 2 | shield (absorb), shield from max HP |
| 17 | 451 | 3 | crit damage + % |
| 33 | 440 | 4 | heal % of HP (per action) |
| 14 | 403 | 5 | healing received +/- |
| 5 | 398 | 1 | heal over time |
| 43 | 283 | 2 | block (parry) rate +/- |
| 24 | 279 | 2 | reflect damage % |
| 21 | 262 | 4 | life steal |
| 23 | 261 | 4 | initial fury (SP) + N |
| 18 | 208 | 4 | dispel positive effects |
| 40 | 202 | 3 | damage dealt + % (conditional) |
| 31 | 125 | 2 | crit received reduction |
| 38 | 116 | 1 | confusion (attacks allies) |
| 51 | 113 | 4 | awaken points +/- |
| 30 | 104 | 2 | chance to ignore damage / damage immunity N turns |
| 6 | 96 | 4 | fury per attack +/- |
| 4 | 94 | 3 | resistance +/- % |
| 101 | 92 | 1 | stun ("Atordoamento") |
| 2 / 1 / 3 | 88 / 72 / 51 | 2-3 | defense / attack / magic attack +/- |
| 28 / 29 | 68 / 60 | 3 | ignore defense / ignore resistance % |
| 63..68 | 57 each | 2 | floor rule: elemental resistance threshold damage (trial floors) |
| 19 | 57 | 1 | stun / silence; client sets `restricted` |
| 50 | 55 | 1 | HP and max HP + % |
| 39 | 51 | 1 | forget N skills (oblivion) |
| 70 | 37 | 2 | magic damage taken - % |
| 13 | 35 | 1 | speed - % (~ action interval) |
| 81 | 26 | 8 | armor break / penetration |
| 316 | n/a | | fire (client shows `asset.battle.fireImg`) |
| 322 | n/a | 4 | resistance proc (client plays `battle.bufferResistMc`) |

`AttackWay` values: 1 (5246), 2 (2960), 3 (2543), 4 (1356), 5 (408), 8, 9, 7. Working meaning: 1 on own action, 2 when hit, 3 when dealing damage, 4 immediate or passive at start, 5 on heal received *(assumption from names)*. `AddWay` (used as `exe_way` on ADD): 1 (10026), 3 (1653), 7 (426), 2, 4, 5, 6, 13, 8, 11, 12.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/SkillTempInfos.xml` (22 716) | skill | `TemplateId`, `TemplateName`, `MasterType`, `SonType`, `Grades`, `UseWay`, `AcceptObject`, `ActionId`, `Cost`, `HitPointCost`, `QTETime`, `Parameter1` (damage %), `Parameter2`, `Parameter3` (linked skill id), `Priority`, `BufferIds`, `ProperType`, `CountWay`, `CoolDown` (ms), `AppearCD`, `IsUseOnDead`, `OwnRequirements`, `Description` |
| `raw/xml/tempinfos/ActionInfos.xml` (2740) | action frames | `ActionId`, `ActionType` (0 advance, 1 animation, 2/5 effect, 3 DAMAGE, 4 zoom, 6 color, 7 shake, 11/12 projectile, 21/22 jump, 23/24 displacement, 25 hide, 99 end, 100 return), `Frame`, `Para`, `Sex` |
| `raw/xml/tempinfos/SkillBufferTempInfos.xml` (12 559) | buff | `Id`, `BufferName`, `AttackData` (1 good, 2 bad), `AddWay`, `AttackType`, `AttackObject`, `ValidCount`, `AttackWay`, `AttackValue`, `ValuePercent`, `CountWay`, `PressCount`, `Dispel`, `Icon`, `AddEffect`, `ActionEffect`, `LastEffect`, `TalentEffIds`, `Parm3` |
| `raw/xml/tempinfos/SkillPropertyTempInfos.xml`, `TalentEffectTempInfos.xml` | skill and talent modifiers | owned by [../skills/README.md](../skills/README.md) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `RuneCommonCD` = 20000, `TimeSpaceFaultSkill` = 617007,617002,617003,617004,617005 (3870 bar) | `ConfigValue` |

## 7. Persistent state

None in this module. Remaining uses of trial props, marriage skills and battle items are owned by their features (inventory, marriage, trials); the battle calls them to consume a use and reads the remaining count for 158.

## 8. Backend implementation notes

- **`battle::skills::handle_hero_order` (10008)**, also mounted for 10516, 10519, 10520, 10523, 14001, 25240 with a per opcode `UnitSelector`: validate (§5) in this order: battle active, requester is a participant, unit belongs to requester (14001: resolve the requester's pet/child), unit alive and not controlled/stunned, no pending request, template exists, skill allowed for this unit and mode, costs, cooldown. Reply 75 immediately (`result 0` + predicted `targetIndexs`, else `result 1`). Store as `pending_request`.
- **`battle::skills::handle_use_item` (10499)**, **`handle_use_trial` (10507)**, **`handle_use_marriage_skill` (10509)**: validate the item/prop/skill and remaining uses via the owner feature (transaction: consume one use), reply 158 (to all participants, `living_id` = user), then queue the item skill as a pending request.
- **`battle::skills::handle_qte` (10015)**: no-op (log).
- **Action execution** (actor, per frame): pick the skill ([ai-auto.md](ai-auto.md)), select targets by `AcceptObject`, compute damages ([damage.md](damage.md)), apply buffs from `BufferIds` (roll, stack up to `PressCount`, set `cur_turn = ValidCount`, `cur_round = CountWay`), trigger existing buffs of attacker and targets (on act, on hit, on damage dealt), build one `AttackOrderMsg` with all damages grouped by target and all buff changes, emit with `extend2 = frame`, set the unit busy for the action duration, start the cooldown, update SP and gauges (push 4600/4311/4589 when they change).
- **Turn processing:** when a unit acts, decrement `cur_turn` of its buffs; emit `see_type 1` with damages for damage/heal over time, `see_type 2` (or `cur_turn 0`) when expiring, in the same 153.
- **Summons and forms:** `HeroAis.Soldiers` units are added through `awakenSoldiers`; 650493 style skills change the boss skill cycle to `HeroAis.ChangeSkills`.
- **Goddess stage:** goddess skills of several goddesses in the same frame may be grouped in one 4102.
- Validation failures never close the battle; they only answer `result 1`.

## 9. Open questions and assumptions

1. Exact semantics of each `AttackType`, `AttackWay`, `AddWay` and `ProperType` value: derived from names only.
2. *(assumption)* turn = one action of the buff holder.
3. `Parameter2`, `CountWay` of skills (not buffs) and `OwnRequirements` semantics.
4. The original target rules for each `AcceptObject` (the mock mapping is a reconstruction).
5. Whether the original server rejected skills by battleType or relied on the client.
6. 14001 has no `hero_id`: the server must infer the unit from the requester and battleType.

## 10. Implementation checklist

- [ ] Route 10008 -> `battle::skills::handle_hero_order` with full validation and 75 reply
- [ ] Routes 10516, 10519, 10520, 10523, 14001, 25240 mounted on the same handler with unit selectors
- [ ] Routes 10499, 10507, 10509 -> item/trial/marriage handlers with 158
- [ ] Route 10015 (no-op), 10016 (ignored)
- [ ] Server message 153 encoder (damages grouped by target, buffs, awakenSoldiers, waitRevives, `extend2`)
- [ ] Server message 4102 for goddess stages
- [ ] Server messages 75, 158; optional 77
- [ ] Buff engine: add, stack, trigger by `AttackWay`, turns, rounds, remove, dispel, `unSkillIds`, stun
- [ ] Skill engine: `AcceptObject` targeting, hits from `ActionInfos`, durations, cooldowns, SP and hit point costs
- [ ] Pet form 700001/700002 and guardian form 700003/700004
- [ ] Test: request during cooldown -> 75 result 1, bar re-enables after 1 s
- [ ] Test: buff with 2 turns disappears after the holder's second action
- [ ] Test: stun buff blocks requests; `unSkillIds` blocks only listed skills
