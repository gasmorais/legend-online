# Battle units: model, attributes and gauges

Module `units` of the feature [Motor de batalha](README.md). Path prefixes as in [lifecycle.md](lifecycle.md). Client detail: `docs/battle/README.md` §2, `docs/battle/formation.md` §3, `docs/battle/rules.md` §12.0. The attributes themselves (how a hero gets its attack, HP, resistances) are computed by the character features ([../hero/README.md](../hero/README.md), [../army/README.md](../army/README.md), equipment, cosmos, steles, theseus, avenger...); this module defines the **battle snapshot** of a unit and its runtime state.

## 1. Overview

A battle unit ("living") has a `living_id` unique in the battle, a `side` (1 or 2) and a `pos` (1..12). Unit kinds on the wire:

| Kind | Wire list in 157 / 72 | Client class | Notes |
|---|---|---|---|
| Troop (soldier, pawn squad) | `soldiers` (`SoldierMsg`) | `PawnRoleInfo` / `PawnRoleView` | HP = `init_hp`/`hp`; one SWF per squad (`PawnTempInfos.Swf`) |
| Player hero ("Lorde") | `heros` (`HeroMsg`, `type 1`) | `HeroRoleInfo` / `HeroRoleView` | equipment avatar; SP, awaken, avenger, war soul gauges |
| NPC hero / boss | `heros` (`type 3`; 7 and 8 also seen) | `HeroRoleInfo` / `HeroRoleView` with `res` SWF | `type 3` = boss: boss bar, world boss rules |
| Pet (Einherjar) | `pets`, linked by `living_id2` | `PetRoleInfo` / `PetRoleView` | follows its hero; unlinked pet = `isPetFake` hero, or fighter (`isPetState`) in 3844/3866/3864; battleType 35 = pets only |
| Goddess | `goddesses`, linked by `living_id2` | `GoddessRoleInfo` / `GoddessRoleView` (invisible) | appears only in the goddess skill movie (4102); unlinked = `isGoddess` hero |
| Guardian (child) | `children` | `HeroRoleInfo` (`isChildFake`) | follower (`isFollowChild`) except in child battles 3845/3847/3867/3868/3889 |
| Battle beast (monster) | `monsters` | `MonsterRoleInfo` / `MonsterRoleView` | follows its hero except 3884 (captain via `isCaptain`) |
| Chess piece | `chessList` | `SelfChessRoleInfo` | battleType 349 only |
| Awakened soldier | `AttackOrderMsg.awakenSoldiers` (`SoldierMsg`) | `PawnRoleInfo` | summoned during a skill (`HeroAis.Soldiers`) |

The client identifies "its" unit (`selfHero`) as the hero whose `user_id` equals the logged player, excluding pet fakes, goddesses and follower children; in child battles it is the manual child, in 3884 the captain monster, in 349 the own chess piece, in 307 the hero is taken without user check (`CM/yishi/datas/BattleModel.as:407-470, 1266-1288`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.view.roles.HeroRoleView` / `PawnRoleView` / `PetRoleView` / `GoddessRoleView` / `MonsterRoleView` / `SelfChessRoleView` (CM) | name `battle.HeroNameTxt` | unit sprite, HP bar at the feet (`asset.battle.PawnBottomAsset`, `BottomHpStripAsset`; boss `BossBottomStrip`) | 157 | name, HP, buffs, `[server]` tag in 10/32/308/296/3848 |
| `battle.view.bottom.SelfBloodView` (M10) | "Vida:Quando vida atingir 0, você morrerá" | own HP | bottom bar | `bloodA / totalBloodA` |
| `battle.view.bottom.SelfSpView` (M10) | "Fúria:" "Utilização de habilidades consome fúria" | own SP (rage) | bottom bar | `sp / spMax` |
| `battle.view.bottom.SelfHitPointView` (M10) | "Pontos de ATQ:" | attack points, Encantador de Dragões only | bottom bar | `hitPoint` of `hitPointMax` |
| `battle.view.bottom.SelfAwakenView` (M10) | "Despertamento: N / 3000" | pet awaken | bottom bar, hero with a pet | `awake` |
| `battle.view.bottom.ChildAwakenView` / `ChildSelfChangeView` (M10) | "Capacidade do Guardião," | guardian power / transformation | bottom bar | `awake` 0..100, `childAwake` 0..3000 |
| `battle.view.bottom.BattleBeliefProgressView` (M10) | none | goddess belief | bottom bar | `belief` 0..120 |
| `battle.view.ui.TeamStrip`, `DragonTitanTeamView`, `BattleGoddessTopView` (M10) | none | ally/enemy bars, titan panel, goddesses | HUD | per row hero (`heroList`) |

Full HUD reference: `docs/battle/hud.md` §4-§8.

## 3. Routes (client to server)

None. Units are server data.

## 4. Server messages (server to client)

### 4.1 `battle.HeroMsg` (inside 157, 72, 4793)

Readers: `SocketGameReader.readHeroRoleInfo` (`CM/map/internals/utils/SocketGameReader.as:233-395`), `readPetRoleInfo` (:448-480), `readGoddessRoleInfo` (:482-504), `readMonsterRoleInfo` (:506-553), `readSelfChessRoleInfo` (:397-446), initial buffs `readReinforceBuffer` (:555-609). "server" = not read by the client; fill it for the engine or leave unset.

| Field | Meaning |
|---|---|
| `hero_id (#1, INT32)` | owner object id (hero id, pet id, monster id, chess id) |
| `living_id (#2, INT32)` | battle unit id |
| `user_id (#3, INT32)` | owning player id (0 for NPC); decides `selfHero` |
| `user_pics (#4, INT32)` | player portrait; for children = child sex |
| `temp_id (#5, INT32)` | template: `GameHeroTemp` (hero/boss), `PetTempInfos`, `ChildTempInfos`, `MonsterTemplates`, goddess, chess |
| `type (#6, INT32)` | 1 player hero; 3 boss/NPC (boss bar, boss rules); 2, 7, 8 other NPC kinds *(assumption)* |
| `nick_name (#7, STRING)` | display name |
| `grade (#8, INT32)` | level |
| `side (#9, INT32)` | 1 or 2 |
| `pos (#10, INT32)` | 1..12 ([formation.md](formation.md)) |
| `max_hp (#11, INT64)` | HP cap (`totalBloodA`) |
| `init_hp (#12, INT64)` | server |
| `hp (#13, INT64)` | current HP; `<= 0` = dead at start |
| `init_hp2 (#14, INT64)` | server |
| `hp2 (#15, INT64)` | troop HP carried by the hero (`bloodB`, bloodType 7) |
| `sp (#16, INT32)` | rage (Fúria) |
| `slot_avata (#17, STRING)`, `cloth_avate (#18, STRING)`, `cloak_path (#19, STRING)`, `hair_path (#20, STRING)`, `wing_avata (#46, STRING)`, `hat_avata (#49, STRING)`, `fashion_arm_avata (#50, STRING)`, `fashion_cloth_avata (#51, STRING)` | avatar layers (weapon, armor, cloak, hair, wing, hat, fashion) |
| `captain (#21, INT32)` | server |
| `res (#22, STRING)` | SWF resource for NPC/boss bodies (`GameHeroTemp.ResPath`) |
| `qte_time (#23, INT32)`, `cast_time (#24, INT32)` | summed into `coldDownTime` (unused gameplay) |
| `pics (#25, INT32)` | portrait (friend readers) |
| `job (#26, INT32)` | job; for children = child job |
| `phy_attack (#27)`, `phy_defence (#28)`, `mag_attack (#29)`, `mag_defence (#30)`, `force_hit (#31)` (INT32) | combat stats, server ([damage.md](damage.md)) |
| `parry (#32, INT32)` | parry stat, server |
| `sites (#33, INT32)` | server |
| `skill_script (#34, STRING)` | server (skill list CSV) |
| `pawn_temp_id (#35, INT32)` | troop template carried by the hero |
| `skillId (#36, INT32, repeated)` | skills to preload (default, active, AI, passives) |
| `attack_wound (#37, INT64)`, `hit_wound (#38, INT64)` | server (damage dealt / taken counters) |
| `attack_model (#39, INT32)` | server; the auto flag comes from 157 `attack_model` |
| `starBuffer (#40, StarBufferMsg, repeated)` | `skill_id (#1)`, `level (#2)`, `addition (#3)`: star (cosmos) skill bonuses; server |
| `item (#41, BattleItemMsg, repeated)` | battle consumables (runes, slots Z/X): `uItemId (#4)`, `count (#5)`, `tempId (#6)`, `bagPos (#7)`, `skillTempId (#8)`, `sonType (#9)` |
| `head_id (#42, INT32)` | head icon |
| `buffers (#43, BufferMsg, repeated)` | buffs present at start ([skills-effects.md](skills-effects.md) §4.3) |
| `is_show (#44, BOOL)` | true = hidden unit (not drawn) |
| `server_name (#45, STRING)` | cross server tag |
| `trials (#47, TrialInfoMsg, repeated)` | trial props: `index (#1)`, `skillId (#2)`, `count (#3)` uses, `param4 (#7)` cooldown |
| `battleDrop (#48, BaseItemMsg, repeated)` | server |
| `hide (#52, BOOL)` | hide fashion |
| `appell_id (#53, INT32)` | title |
| `fireResi (#54)` .. `lightResi (#59)` (INT32) | elemental resistances, server |
| `followSkills (#60)`, `changeSkills (#61)`, `defaultSkills (#62)` (STRING) | server |
| `awake (#63, INT32)` | pet awaken 0..3000, or child power 0..100 for children |
| `living_id2 (#64, INT32)` | link: for a pet/goddess/monster/chess = owner hero `living_id`; for a hero = its pet `living_id` |
| `changeSkillId (#65, INT32, repeated)` | pet form skills (`petSkillIds`) |
| `fate_skillTempIds (#66, STRING)` | fate skills (display) |
| `is_change (#67, BOOL)` | starts in pet form (`isPetState`) |
| `pet_quality (#68, INT32)` | pet quality (name color) |
| `fight_capacity (#69, INT32)` | server (combat power) |
| `reduce_resi (#70)`, `strength (#71)`, `tenacity (#72)`, `penetrate (#74)`, `stunAttr (#80)`, `reduceResiAgainst (#112)`, `resiPenetrate (#113)` (INT32) | secondary stats, server |
| `has_shadow (#73, BOOL)` | shadow skill ghosts |
| `transfer_grade (#75, INT32)`, `changeBranch (#91, INT32)` | job change grade and branch |
| `marriageSkills (#76, INT32, repeated)` | server |
| `mate_id (#77, INT32)`, `marSkills (#78, TrialInfoMsg, repeated)`, `mate_server_name (#79, STRING)` | marriage skill slot E ([../marriage/README.md](../marriage/README.md)) |
| `isFollow (#81, BOOL)` | server |
| `multiLordsInspireLevel (#82, INT32)` | Titans inspiration icon (308/315) |
| `spMax (#83, INT32)` | SP cap (default 100) |
| `hitPoint (#84, INT32)`, `hitPointMax (#85, INT32)` | attack points (default cap 5) |
| `spLimit (#86, INT32)` | server |
| `growth_grade (#87, INT32)` | child growth grade |
| `curturn (#88, INT32)` | read, unused |
| `scuffleSequence (#89, INT32)`, `isFight (#90, BOOL)` | server |
| `titanInfo (#92, TitanInfoMsg)` | `titanId (#1)`, `titanSkill (#2, SkillStateMsg, repeated)` with `skillId (#1)`, `state (#2)` used flag, `index (#3)` ([../dragon/README.md](../dragon/README.md)) |
| `isSlaveChild (#93, BOOL)` | slave guardian |
| `followChild (#94, INT32)`, `relicSkillId (#95, INT32)`, `awakeBuffers (#96, STRING)`, `awakeSkillId (#97, INT32)` | server |
| `childAwake (#98, INT32)` | guardian transformation value 0..3000 |
| `isManualChild (#99, BOOL)` | the controllable child in child battles |
| `isDragonTalker (#100, BOOL)`, `fightMount (#101, INT32)` | Encantador de Dragões form and battle mount |
| `belief (#102, INT32)` | goddess belief 0..120 |
| `action_belief (#103, INT32)` | server |
| `replaceSkill (#104, ReplaceSkillMsg)` | per battle skill bar override: `fastKey (#1)`, `petFastKey (#2)`, `childFastKey (#3)` (STRING), `childSkills (#4, INT32, repeated)`, `talnetSkill (#5, STRING)` |
| `isCaptain (#105, BOOL)` | captain monster (3884) |
| `avengerSp (#106)` .. `avengerGrade (#111)` | avenger fields, see [special-skills.md](special-skills.md) |
| `warSoulSkills (#114, INT32, repeated)`, `warSoulSp (#115, INT32)`, `warSoulType (#116, INT32)` | war soul fields, see [special-skills.md](special-skills.md) |
| `addSkills (#117, INT32, repeated)` | extra skill bar for 3914 (`thessBoxSkills`) |

### 4.2 `battle.SoldierMsg` (inside 157, 72, 4793, 153 `awakenSoldiers`)

Reader `SocketGameReader.readPawnRoleInfo` (:211-231): `living_id (#1, INT32)`; `temp_id (#2, INT32)` `PawnTempInfos.TemplateId`; `type (#3, INT32)` army type; `side (#4, INT32)`; `pos (#5, INT32)`; `init_hp (#6, INT32)` max HP; `hp (#7, INT32)` current HP; `qte_time (#8, INT32)`, `cast_time (#9, INT32)`; `army_pawn_id (#10, INT32)` server; `grade (#11, INT32)` server; `phy_attack (#12)`, `phy_defence (#13)`, `mag_attack (#14)`, `mag_defence (#15)`, `force_hit (#16)`, `parry (#17)` (INT32) server; `sites (#18, INT32)` server; `skillId (#19, INT32, repeated)` skills to preload; `attack_wound (#20)`, `hit_wound (#21)` server; `penetrate (#22)`, `stunAttr (#23)` server.

### 4.3 Gauge pushes (all `battle.AwakeMsg {awake (#1, AwakeInfoMsg, repeated)}`, `AwakeInfoMsg {living_id (#1, INT32), awake (#2, INT32), childAwake (#3, INT32)}`)

| Opcode | Gauge | Receiver | Range |
|---|---|---|---|
| 4600 (0x11f8) U_C_UPDATE_AWAKE | pet awaken | `BattleAwakenTransaction` (`CM/battle/transaction/BattleAwakenTransaction.as:22-61`) | 0..3000; ignored in child battles and 3845 |
| 4589 (0x11ed) U_C_UPDATE_AVENGER_SP | avenger SP | `BattleAvengerSpTransaction` | 0..70 ([special-skills.md](special-skills.md)) |
| 4311 (0x10d7) U_C_WARSOUL_SP | war soul fury | `BattleWarsoulSpTransaction` | 0..100 ([special-skills.md](special-skills.md)) |
| 4752 (0x1290) U_C_UPDATE_CHILD_POWER | guardian power `awake` 0..100, transformation `childAwake` 0..3000 | `BattleChildChangeTransaction` (`CM/battle/transaction/BattleChildChangeTransaction.as:19-55`) | owned with [../guardians/README.md](../guardians/README.md) |
| 391 (0x0187) U_C_UPDATE_PET_POWER | pet sacristy relic power (`awake[0].awake`) | `PetSacristyManager` (outside the queue) | relic enabled at >= 100 ([../einherjar/README.md](../einherjar/README.md)) |

SP and attack points are not pushed separately: they ride on each 153 (`sp`, `sp_added`, `hitPoint`) and on buff damages (bloodType 9 and 24).

### 4.4 Boss control 4999 (0x1387) U_BATTLE_CONTROL_BUFF_STATE

`battle.ControlBuffStateMsg`: `controled (#1, BOOL)`, `living_id (#2, INT32)`, `side (#3, INT32)`, `pos (#4, INT32)`, `controller_living_id (#5, INT32)`. Receiver `TailaFbManager.__bossControlHandle` (`CM/managers/TailaFbManager.as:52-63`): when the own hero is controlled by the boss, the skill bar is disabled. Push when a mind control effect starts and ends.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| SP cap | `spMax` default 100 | `CM/yishi/datas/objects/HeroRoleInfo.as:27, 179-190` |
| Attack points cap | `hitPointMax` default 5 | `HeroRoleInfo.as:31, 204-222` |
| Pet awaken | 0..3000; transform at 3000 (`canMorph`) | `HeroRoleInfo.as:262-287, 459-467` |
| Avenger SP | 0..70 | `HeroRoleInfo.as:93, 229-241` |
| War soul fury | 0..100 | `HeroRoleInfo.as:103, 248-260` |
| Child power / transformation | 0..100 / 0..3000 | `HeroRoleInfo.as:289-323` |
| Goddess belief | 0..`goddess_belief_max` = 120 | `CM/yishi/datas/objects/RoleInfo.as:773-794`; `ConfigInfos.xml` |
| HP display | `max_hp` / `hp`; troops HP `hp2` (bloodType 7) | `SocketGameReader.as:284-286` |
| Pet and goddess HP | `PetRoleInfo` and `GoddessRoleInfo` ignore HP updates | `docs/battle/rules.md` §6.4 |
| Unit stats source | server snapshot at battle creation: owner features compute final stats (equipment, cosmos, steles, theseus, avenger body...). Template base: `GameHeroTemp` (Attack, Defence, MagicAttack, MagicDefence, Live, ForceHit, Parry, resistances), `PawnTempInfos` (same plus `AttackType` 2 = magic) | `docs/battle/server-engine.md` §3.1, §9.3 |
| Mock defaults | hero 300/100/300/100, 1000 HP; soldier 60/10/60/10, 800 HP | `docs/battle/server-engine.md` §9.3 |
| Magic attacker | hero `Job` 3, soldier `AttackType` 2 | same |
| `living_id` ranges (mock) | heroes 1.., soldiers 100.. | same |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/GameHeroTemp.xml` | hero / NPC / boss | `TemplateId`, `TemplateName`, `HeroType`, `Job`, `Sexs`, `DefaultSkill`, `AI`, `SkillScript`, `Live`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Parry`, `FireResi`..`LightResi`, `ReduceResi`, `ReduceResiAgainst`, `ResiPenetrate`, `ResPath` |
| `raw/xml/tempinfos/PawnTempInfos.xml` | troop | `TemplateId`, `PawnName`, `Live`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Parry`, `AttackType`, `DefaultSkill`, `AI`, `Swf`, resistances, `Penetrate`, `StunAttr` |
| `raw/xml/tempinfos/PetTempInfos.xml`, `ChildTempInfos.xml`, `MonsterTemplates.xml`, `GoddessTemplateInfos.xml`, `AutoChessHeroInfos.xml` | companions | owned by their features |
| `raw/xml/tempinfos/ConfigInfos.xml` | `goddess_belief_max` = 120 | `ConfigValue` |

## 7. Persistent state

None. Unit snapshots are built at battle creation from the owners' tables and live only in memory (optionally copied into `battle.battles.config`, [lifecycle.md](lifecycle.md) §7). HP is not carried over between battles unless the owning feature stores it (for example world boss shared HP, guild boss HP).

## 8. Backend implementation notes

- Rust types: `Unit { living_id, kind (Troop|Hero|Boss|Pet|Goddess|Child|Monster|Chess), owner_player_id, owner_living_id, template_id, side, pos, level, max_hp, hp, troop_hp, sp, sp_max, hit_point, hit_point_max, awaken, child_awake, avenger_sp, war_soul_sp, belief, stats: Stats, skills: SkillSet, ai_id, buffs: Vec<Buff>, flags }`. `Stats { phy_attack, phy_defence, mag_attack, mag_defence, force_hit, parry, resist[6], reduce_resi, reduce_resi_against, resi_penetrate, penetrate, strength, tenacity, stun_attr }`.
- Builders: `battle::units::from_player(player_id, BattleContext)` asks each character feature for its contribution (trait `BattleContributor` returning stat deltas, extra skills, passive buffs, gauges) and sums them. NPC builders read templates.
- Encoding: `to_hero_msg(&Unit)` and `to_soldier_msg(&Unit)` fill only the fields in §4.1/§4.2 that the client reads plus `skillId` for preload; keep server-only stats out of the wire for PvP privacy *(the client never reads them)*.
- Pets, goddesses and monsters must carry `living_id2` = owner hero `living_id`, and the owner hero `living_id2` = its pet `living_id`.
- Gauge changes: emit 4600/4589/4311/4752 to all participants when the value changes (one `AwakeInfoMsg` per changed unit).
- Boss control: emit 4999 when a control buff is applied/removed on a player hero.

## 9. Open questions and assumptions

1. Meaning of `HeroMsg.type` values 2, 7 and 8 *(assumption: NPC variants)*.
2. Whether the original server sent combat stats to the client (they are in the schema but never read).
3. Initial values of SP, awaken and the other gauges per mode (mock: SP from config, others 0).
4. `captain`, `sites`, `spLimit`, `followChild`, `awakeBuffers`, `awakeSkillId`, `action_belief` semantics.

## 10. Implementation checklist

- [ ] `Unit` and `Stats` model; `BattleContributor` trait for character features
- [ ] Builders: player hero, troops, pet, goddess, child, monster, NPC/boss, chess piece
- [ ] `HeroMsg` / `SoldierMsg` encoders with `living_id2` links and preload `skillId`
- [ ] Gauge pushes 4600, 4589, 4311, 4752 (and 391 via einherjar)
- [ ] Server message 4999 (boss control)
- [ ] Rule: caps (SP 100, hit points 5, awaken 3000, avenger 70, fury 100, belief 120)
- [ ] Test: own hero detection (`user_id`), pet linked to hero, unlinked pet becomes a fake hero
- [ ] Test: unit with `hp <= 0` at start is dead; `is_show = true` is hidden
