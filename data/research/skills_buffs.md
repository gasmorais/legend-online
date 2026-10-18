# Skills, actions, frames, buffs and effects (Legend Online BR)

This document describes how skills, their animation actions and frames, battle buffs, talents, passive skill attributes and out-of-battle effects are defined in the pt-BR templates and consumed by the decompiled AS3 client. It does not cover the battle pipeline itself (see Conventions). Its machine-readable pair is [data/research/skills_buffs.json](../../data/research/skills_buffs.json): 35 enums, 207 fields, 18 `Para` layouts and 17 formulas.

**Conventions**
- **Path prefixes:**
  - `CM` = `decompiled/core_module/scripts`
  - `M3`/`M14`/`M16`/`M17` = `decompiled/mNN/scripts`
  - `TPL` = `data/tpl/tempinfos`
- **Uncertainty:** *(assumption)* marks anything not confirmed in code.
- **Not repeated here:** battle pipeline, queue, sync, floating numbers and scene. See [docs/battle/README.md](../../docs/battle/README.md) §1-§5 and [docs/client/graphics.md](../../docs/client/graphics.md) §3.

## Contents

- [0. Data chain](#0-data-chain)
- [1. Skills: `SkillTempInfos`](#1-skills-skilltempinfos)
  - [1.1 Identity and levels](#11-identity-and-levels)
  - [1.2 Use way, target and priority tier](#12-use-way-target-and-priority-tier)
  - [1.3 Cost, cooldown and talents (formulas in `SkillTempInfo.as:182-449`)](#13-cost-cooldown-and-talents-formulas-in-skilltempinfoas182-449)
  - [1.4 Other fields](#14-other-fields)
- [2. Skill categories: `MasterType` → system](#2-skill-categories-mastertype--system)
- [3. Actions and frames: `ActionTempInfos`, `ActionInfos`](#3-actions-and-frames-actiontempinfos-actioninfos)
  - [3.1 Assembly and action fields](#31-assembly-and-action-fields)
  - [3.2 Timing, sex and presentation type](#32-timing-sex-and-presentation-type)
  - [3.3 Frame types and `Para` layout](#33-frame-types-and-para-layout)
- [4. Buffs: `SkillBufferTempInfos`](#4-buffs-skillbuffertempinfos)
  - [4.1 Key fields](#41-key-fields)
  - [4.2 Lifecycle (protocol)](#42-lifecycle-protocol)
  - [4.3 Buff visuals](#43-buff-visuals)
- [5. Talents: `TalentEffectTempInfos`](#5-talents-talenteffecttempinfos)
- [6. Passive skill attributes: `SkillPropertyTempInfos`](#6-passive-skill-attributes-skillpropertytempinfos)
- [7. Out-of-battle effects and property codes: `EffectTempInfos` (`stat_property_code`)](#7-out-of-battle-effects-and-property-codes-effecttempinfos-stat_property_code)
  - [7.1 Template table selection](#71-template-table-selection)
  - [7.2 Property codes](#72-property-codes)
  - [7.3 Named attributes](#73-named-attributes)
- [8. Campaign and mode buffs](#8-campaign-and-mode-buffs)
  - [8.1 Campaign buffs (`CampaignBufferTemps`, 165 rows)](#81-campaign-buffs-campaignbuffertemps-165-rows)
  - [8.2 Random boss buffs (`RandomBossBuffInfos`, 72 rows)](#82-random-boss-buffs-randombossbuffinfos-72-rows)
  - [8.3 Glory Road buffs (`GloryRoadBufferInfos`, 40 rows)](#83-glory-road-buffs-gloryroadbufferinfos-40-rows)
- [9. Vehicles (Unreal Shooting, Snow War, tanks)](#9-vehicles-unreal-shooting-snow-war-tanks)
  - [9.1 Vehicle skills (`VehicleSkillTempInfos`, 77 rows)](#91-vehicle-skills-vehicleskilltempinfos-77-rows)
  - [9.2 Vehicle buffs (`VehicleBuffTempInfos`, 44 rows)](#92-vehicle-buffs-vehiclebufftempinfos-44-rows)
- [10. United goddess, Avenger and auto-chess (skill links only)](#10-united-goddess-avenger-and-auto-chess-skill-links-only)
- [11. Graphic resources](#11-graphic-resources)
- [12. Domain opcodes and protos](#12-domain-opcodes-and-protos)
- [13. Gaps and warnings](#13-gaps-and-warnings)

---

## 0. Data chain

```
SkillTempInfos (22716)
 ├─ ActionId ──► ActionTempInfos (593) ──► ActionInfos (2740 frames) ──► skillEffect/{link}.swf
 ├─ BufferIds (CSV) ──► SkillBufferTempInfos (12559)
 │                       ├─ AddEffect/ActionEffect/LastEffect ──► skillEffect/{link}.swf
 │                       └─ TalentEffIds (CSV) ──► TalentEffectTempInfos (6932)
 │                                                 ├─ EffSkillType ──► SkillTempInfos.SonType
 │                                                 ├─ EffBufferIds ──► SkillBufferTempInfos.Id
 │                                                 └─ EffBufferType ──► SkillBufferTempInfos.Id (scaling)
 └─ TemplateId ══ SkillPropertyTempInfos.TemplateId (11924; passive attribute skills)
```

The server decides all outcomes. The client only:
- animates skills;
- applies visual buffs from `AttackOrderMsg.buffers` (a list of `BufferMsg`);
- computes tooltip text with talents applied.

---

## 1. Skills: `SkillTempInfos`

**Code**
- **Class:** `CM/yishi/datas/templates/SkillTempInfo.as`.
- **Resolver:** `CM/yishi/resolve/SkillTempInfoResolve.as` (`ClassFactory.createInstanceIII`: XML attribute → property).
- **Lookup:** `TempleteManager.getSkillTemplateInfoById` (`CM/yishi/manager/TempleteManager.as:1819`).

### 1.1 Identity and levels
- Each row is **one level** of a skill.
- `SonType` is the skill family; `Grades` is the level within it.
- `NextTemplateId` → next level; 0 = max level.
- `PreTemplateId` is a CSV of prerequisites, read by `preTempList` (`:148`).
- **Upgrade requirements:**
  - `NeedPlayerGrade` (0 in 21863 rows);
  - `UpgradeNeedItem` + `UpgradeNeedCount`: item 2131200 in 90 expedition-pet skills, item 2131201 in 50 PVE Guardian (child) skills (`CM/mvc/module/armyII/SkillInfo.as:152`, `M14/remotepet/views/RemoteSkillItemView.as:125`).
- **Special ids** (`CM/battle/data/SkillData.as:18-44`):
  - 1-4 (3 = Vitória, 4 = Derrota) and 101-104;
  - 105 → `SpecialActionSkill105`;
  - 700001/700002: Einherjar (pet) morph/unmorph;
  - 700003/700004: Guardian (child) morph. `SkillFrameExecuter.addDanny` handles the morphs (`:215-229`).
- `SonType` 1001/2001/3001 are talents (`SKILL_SONTYPE_TALENT_ARR`).

### 1.2 Use way, target and priority tier
- **`UseWay`** (`SkillUseWayType.as`):

  | value | meaning | skills |
  |---:|---|---:|
  | 1 | Active | 5448 |
  | 2 | Passive | 17124 |
  | 3 | Normal attack | 76 |
  | 4 | Stone (lousa) trigger | 37 |
  | 5 | Passive stone trigger *(assumption)* | 31 |

  - **3 = normal attack:** `isDefaultSkill` (`BaseSkill.as:545`) and `BattleUtils.as:236`.
  - **4 = stone trigger skill:** `isStoneTriggerSkill` (`SkillItemListController.as:347`), used by opcode 10523. Example: 55001 "Finalização" (enemy <20% HP, 300% damage).
  - **5 =** "Dano ampliado" at <30% HP *(assumption: passive stone trigger)*.
- **`AcceptObject`:** 21 labels from `yishi.view.tips.goods.SkillTips.TypeNN` (`M16/yishi/view/tips/goods/SkillTips.as:806-845`).
  - Examples: 1 random single, 3 all, 4 self, 6 front, 8 front row, 11 cross, 15 splash, 18 dead.
  - 4 (self) appears in 17893 skills, almost all passive.
  - Values 24, 25, 26, 27, 28, 30 and 35 occur in the data without a label (see the enum).
  - The getter returns the talent's `EffAttackObject` when it is non-zero (`SkillTempInfo.as:250`).
- **`Priority`** (`SkillPriorityType.as`):
  - **3 = super skill:** `addProfoundEffect` (`CommonActionSkill.as:39-48`, `BaseSkill.as:640`). The caster scales 1.5×, the background flashes white, the screen shakes (1, 7) and `profound.RoleBodyEffect{sex}_{job}` plays; `job` is forced to 4 for DragonTalker (`ProfoundEffect.as:41-66`). 618 skills.
  - **4 = Einherjar (pet) super skill** (`ProfoundEffectII`, with `profound.DisperseAsset`). Absent from BR data.
  - **1** (1415 skills) and **2** (4834 skills): not handled by the client *(assumption: basic / common skill)*.

### 1.3 Cost, cooldown and talents (formulas in `SkillTempInfo.as:182-449`)

| field | unit | rule |
|---|---|---|
| `CoolDown` | ms | `int((CD + CD·ΣEffCdPercent/100 + ΣEffCdValue)/1000)·1000`. The tooltip shows `CD·0.001` s. Common values: 30000 (680 skills), 15000 (624), 60000 (349). |
| `Cost` | Fury (SP) | Negative = consumption; the tooltip shows "Consumo de fúria: \|Cost\|" only when Cost<0. `Cost' = Cost + Cost·ΣEffSpPercent/100 + ΣEffSpValue`. With MasterType 500/501 and Cost>0, the cost is \|Cost/10\| vengeance slots (`SkillTips.as:228`). |
| `HitPointCost` | hit point (DragonTalker, bloodType 24) | Negative = consumption, shown as "Consumo de HP". 73 skills, −1 to −5. |
| `Parameter1` | damage % | `{Parameter1}` = \|P1·(1+ΣEffDamPercent/100)\| |
| `Parameter2` | flat damage | `{Parameter2}` = \|P2·(1+ΣEffDam%/100)+ΣEffDamValue\| |
| `Parameter3` | id | Alternate skill id for auto-combat and preload (`SkillResourceLoader.as:297`, `SkillItemListController.as:1034`). In BR it only holds values 2..18 on "Laceração" talents, so it does not work as an id. |
| `AppearCD` | ms | Initial in-battle cooldown (`BattleSkillItemII.startAppearCD:677`). 10000 on the 16 Einherjar (pet) EX skills with Despertar. |
| `QTETime` | ms | Always 0 in BR, so the QTE never opens. Flow: [docs/battle/README.md](../../docs/battle/README.md) §4. |

**Talent collection** (`getTalentEffectIds`, `:270-319`):
1. For each skill in `thane.talentData.talentScript` and `advTalentScript`, walk its `BufferIds`.
2. From each buff, take its `TalentEffIds`.
3. Keep those with `EffSkillType == -1` or `== SonType`.
4. In battle, `getBattleTalentEffect` (`:321-381`) adds the caster hero's own active buffs. It also counts `EffSkillType` 1 and 850001 when `buffer.targetSkillId == TemplateId`.

### 1.4 Other fields
- **`Description`:** placeholders `{Parameter1}`, `{Parameter2}`, `{Cost}`, `{HitPointCost}` (`getDealDescript`, `:442`).
- **`Icons`:** `"/skill_x.png"` → `{RES}icon/skill_x.png` (`IconFactory.getTecIconByIcon`, `CM/yishi/utils/IconFactory.as:30`).
- **`OwnRequirements`:** `"type,count"` → phantom trail `ShadowEffectMaker.startPhantom(body, count, 0, ShadowTypeEnum[type])` (`BaseSkill.as:354-383`).
  - Types: 0 normal, 1 black_all … 8 white_high.
  - Data: "1,5" ×7, "1,3" ×4, "1,7" ×3.
  - Two rows hold guild requirement text (`GuildFbOneBuffTip`).
- **`IsUseOnDead`:** 1 only in 103 ("Nirvana Sagrado") and 40201009. Allows using the trial item while the hero is dead (`SkillItemListView.as:480`).
- **`ProperType`:** quality frame on treasure/Theseus items (`TreasureSkillItem.as:30`). 0 in 21450 skills.
- **Fields the client does not read:**
  - `AppearTime` (1/2): 2 appears on unit auto-attacks *(assumption)*;
  - `CountWay` (15 values, server formula *(assumption)*);
  - `Profile` (always empty).
- The class has a `Random` field that is absent from the BR XML.

---

## 2. Skill categories: `MasterType` → system

Sources: `TempleteManager` filters (`:1939-2160`) and cross-referencing 40 skill-referencing fields in other templates. Full table (≈130 values): enum `skill_master_type`.

| MasterType | system | evidence |
|---|---|---|
| 0 | generic (6994): soldiers, monsters, NPC heroes, runes, titles, magic cards, Einherjar (pet) relics, royalty, Theseus | owner = the referencing table: `PawnTempInfos.DefaultSkill/HighSkill`, `GameHeroTemp.DefaultSkill`, `HeroAis.*`, `RuneTempInfos.SkillTemplateId`, `AppellInfos.Skills`, `MagicCardTempInfos.SkillTempIds`, `PetHallowsTempInfos.SkillTempId`, `RoyaltyTemplates.SkillId` |
| 1 / 2 / 3 | class skills: warrior / hunter / mage | `getAllSkillTemplateInfoByJob(job)`: MasterType == job or job+30; `GameHeroTemp.SkillScript` |
| 4 | DragonTalker (job 4 DRAGONIC), 3030 skills 9150000-9181007 | `DragonTalkerModel.as:140` |
| 10/20/30 and 40/50/60 | basic / advanced talents per class | `TalentData.as:42,130`; `isAdvTalent` = 40..60 or 80 |
| 11-13, 21-23, 31-33 | "new" trees after job transfer (job·10+1..3) | `TempleteManager.as:1965` |
| 421-423 | "brandnew" skills (420+job) | `TempleteManager.as:1953` |
| 41-43, 45-49, 51-57 | Guardians (children), 15 classes | `ChildTempInfos.SkillMasterType` |
| 44 | common Guardian (child) passives | `TempleteManager.as:2035` |
| 70 | common superior talents | `TalentData.as:124` |
| 80 / 81 | goddess: devotion/protection / dance | `SkillMaterType.as`; `GoddessDevoteTemplates` / `GoddessStepTemplates`; `isGoddessSkill` |
| 82 | united goddess formation | `GoddessUnitedSkillTemplates` |
| 83 | monsters and bosses | `MonsterTemplates.DefaultSkill` |
| 101-106, 117-119 | Einherjar (pets) by element: Fogo, Água, Choque, Vento, Escuridão, Luz, Luz/Esc., Vento/Água, Fogo/Choque | `SkillTips.as:124` + lang `pet.petTypeList`; `PetTempInfos.FollowSkills/ChangeSkills` |
| 107 | common Einherjar (pet) skill (Graça Divina) | same |
| 108-112 | item-embedded skills | `ItemTempInfos.DefaultSkill` |
| 200 | expedition pet | `getRemotePetSkill`; `RemotePetTempInfos.Skill` |
| 300 | Titan | `TitanTempInfos.SkillIds` |
| 301 | Ares Lords | `AresLordsSkillFrame.as:79` |
| 308 / 309 | guild / member in guild war | `CrossGuildModel.as:118` |
| 500 / 501 | Avenger: main / secondary | `AvengerModel.as:16` |
| 610 / 611 / 612 | auto-chess: race buff / skill / normal attack | `AutoChess*` |
| 760 | War Soul (Espírito da Guerra) | `WarSoulStrengthenTmpls.Open*Skill` |
| 843 | enchantment | `EnchantView.as:210` |
| 13100-13600 / 14100-14600 | Stela: stage / anti-resistance | `StelaStepTemplates`, `StelaResistTemplates` |
| 760000-760003 | Theseus | `StoreHouseMapTmpls.SkillGroup` |

Attribute pools with no confirmed owner *(assumption)*: 1090-1120, 11100-11108, 21100-21108, 22701-22705, 750200-751500, 4031001-4061001.

---

## 3. Actions and frames: `ActionTempInfos`, `ActionInfos`

### 3.1 Assembly and action fields
**Assembly**
- `ActionTemplateInfoResolveII.as` groups `ActionInfos` rows by `ActionId` into `ActionTemplateData.frames`.
- `SkillFrameDataTransform.createFrameData<ActionType>` builds each frame from the `Para` CSV.
- Frames with ActionType ≤ −1 are skipped (`:24`).

**`ActionTempInfos` fields**
- **`AttackTimes`:** hit count; matches the number of type 3/11/12 frames in 479 of 593 actions.
- **`FrameNum`:** total frames; equals the Frame of frame 99 in 260 actions. Not read by the client.
- **`AttackType`:** 1 in 589 actions, 0 in 4. Not read by the client.
- **`ActionName`:** Chinese text.
- 17089 skills have `ActionId=0` → `BaseSkill` with no animation.

### 3.2 Timing, sex and presentation type
**Timing**
- `Frame` is the frame index (25 fps, 40 ms) inside `SimpleScriptAction`.
  - Frame 0 runs in `onPrepare`.
  - Frame −1 is outside the timeline (advance/return).
- Frame 99 closes the action.
- Frames 3/11/12 get a sequential `effectData.count` and consume `skillData.data[count]` (server hit N).
- Hit buffs apply in the same frame (`CommonActionSkill.as:108-130`).

**Sex** (`BaseSkill.isFrameSexFit:734`)
- 0 female, 1 male, 2 both.
- In BR all 2740 rows are 2.

**`presentType`** (`ActionTemplateData.as:26`)
- 2 if a frame 11/12 exists → `ShootActionSkill`. 34 actions.
- Otherwise 1 (`CommonActionSkill`).
- Factory: `SkillFactory.as:45-93`.

### 3.3 Frame types and `Para` layout
Source: `SkillFrameDataTransform.as:30-178`; executors `SkillFrameExecuter.as:54-91`, `ShootFrameExecuter`, `BundleShootFrameExecuter`, `move/*Context`.

| type | BR count | name | `Para` (positions) |
|---:|---:|---|---|
| −1 | 1 | empty (action 3 "Vitória") | none |
| 0 | 143 | run forward (RunMF) | target_pos (0 = 1st hit target), distance_px, type (1), speed (75), dust_res?, dust_gap? |
| 1 | 608 | attack animation | label (Attack01 271, Attack02 181, Victory 105, Attack03 26, Walk 14) |
| 2 | 420 | cast effect | anchor (0 map / 1 caster / 2 targets), grid_pos (0 → 5), x, y, effect_res, arrange (1 front) |
| 3 | 734 | **damage** | anchor, x, y, hit_res, back_distance (target knockback), delay_bleed |
| 4 | 0 | zoom | zoom, zoomType (1 = center on caster), zoomTime s, stopTime s, backTime s, x, y |
| 5 | 0 | "gas" effect | = type 2, on the gas layer |
| 6 | 2 | background color | 0xRRGGBB, tween s, stop s, atOnce, isReduce (0 → true) |
| 7 | 10 | shake | time, range (e.g. `2,10`, `35,11`) |
| 11 | 17 | projectile | arrow_res, flyType (1 bezier / 2 curve), speed, danny_res, ripple_res, ripple_gap, curve |
| 12 | 17 | beam/laser | arrow_res, startX, startY, arrowWidth, danny_res, danny_frame |
| 21 / 22 | 0 | jump forward / back | target, distance, dust / dust |
| 23 | 23 | teleport forward (StraightMF) | target, offX, offY, disappear_fx, persistent_frames, appear_fx |
| 24 | 23 | teleport back | disappear_fx, persistent_frames, appear_fx |
| 25 | 4 | hide | target (0 = targets), disappear_fx, persistent_frame, appear_fx |
| 99 | 593 | end | none |
| 100 | 145 | run back (RunMB) | type (1), speed (150), dust_res, dust_gap |

**Example: action 1001 (soldier)**
`0:"0,125,1,75"` → `1@0:"Attack01"` → `2@4:"1,0,0,0,soldier001.skill01,1"` → `3@4:"1,0,-70,hit.physical001,10"` → `99@19` → `100:"1,150"`.

**Notes**
- **Data anomaly:** in 3 type-3 frames, `Para[4]` holds `pet.ice.skill009.hit` instead of a number.
- **Projectile flight:** `t = dist/(speed·25)` s. Curve height is `dist/1000·curve` (`ShootFrameExecuter.as:85-104`).
- **Passive effect:** before any non-default skill, the client plays `battle.resource.PassiveEffectAsset` (`BaseSkill.as:161-226`). It does the same when a buff 28/29 with `Random<100` is applied on self.

---

## 4. Buffs: `SkillBufferTempInfos`

- **Class:** `CM/yishi/datas/templates/BufferTemplateInfo.as`.
- **Runtime:** `CM/battle/data/BufferDamageData.as`, `CM/battle/handler/BufferHandler.as`, `CM/yishi/datas/objects/RoleInfo.as:796-980`, `CM/battle/view/roles/RoleViewBase.as:507-720`.

### 4.1 Key fields
- **`AttackType`:** effect type. 105 codes are below 2000. The other ≈3590 rows use a **template id** as `AttackType`: 3430 point to the buff itself, 160 to another buff/skill. These are server-scripted buffs, e.g. 100201 "Tirânico". This explains the 3683 distinct values.
  - Most frequent codes:

    | code | effect | buffs |
    |---:|---|---:|
    | 15 | damage taken ±% | 1283 |
    | 20 | damage dealt ±% | 970 |
    | 305 | DoT % of skill | 527 |
    | 16 | crit rate | 482 |
    | 34 | shield | 466 |
    | 17 | crit damage | 451 |
    | 33 | instant heal % | 440 |
    | 14 | healing received | 403 |
    | 5 | HP regen | 398 |
    | 43 | block | 283 |
    | 24 | reflect | 279 |

  - Codes the client tests:
    - 19 (stun → `restricted`, `RoleInfo.as:816`);
    - 28/29 (ignore defense/resistance → passive flash);
    - 310 (seals Titan skills from `AttackValue` to `ValuePercent`, `BattleFunctionHelper.as:113-135`);
    - 316 (spark → `AttackData.fire`);
    - 322 with `AttackWay` 4 (animates `battle.bufferResistMc`).
  - Full table: enum `buff_attack_type`.
- **`AttackData`:** 1 beneficial (9623), 2 harmful (2931), −1 special (5).
  - The green/red counters on the role (`RoleViewBase.setBufferStateCount:566`) count only buffs that have an `Icon`, are non-permanent (`CountWay` and `ValidCount` ≠ −1) and have `Dispel==0`.
- **`AddWay`:** becomes `effectiveType` when `processType==0` (`BaseSkill.as:572`):
  - 1 = applied at skill start (10026 buffs);
  - 4 = block, applied before the 1st hit (`addParryBuffer`);
  - other values = applied on damage frames (`addBuffer`).
- **`AttackWay`** (`BufferEffectiveType.as`): 1 on act/per turn, 2 on taking damage, 3 on dealing damage, 4 block/trigger. Values 5, 7, 8, 9 *(assumption)*.
- **`ValidCount`:** duration in turns. −1 in 5211 buffs; 2 in 4075; 1 in 1927; 99/999 = permanent.
- **`CountWay`:** trigger limit ("vezes"). −1 in 12254 buffs; other values 1, 2, 3, 5, 10.
- **`PressCount`:** stack limit; 0 in 11766 buffs. Common: 3 (437), 5 (116), 10 (90).
- **`Dispel`:** 1 = undispellable (4786 buffs).
- **`AttackValue` / `ValuePercent`:** flat and percent value. E.g. Id 13 has ValuePercent −90.
- **`Parm3`:** text with `{AttackValue}`, `{ValuePercent}`, `{Random}`, `{ValidCount}` (monster accessory traits, `MonsterModel.as:778`) or id lists; '0' = empty.
- The BR XML lacks the class columns `Random` and `MultiLordsInspireLevel`, so they are 0.

### 4.2 Lifecycle (protocol)
`AttackOrderMsg.buffers[]` (153) holds `BufferMsg`.
- **Class:** `CM/com/road/yishi/proto/battle/BufferMsg.as`. **Missing from [protocol/proto.json](../../protocol/proto.json).**
- **Fields:** `buffer_id, template_id, source_id, target_id, cur_turn, exec_frame, see_type, exe_way, pressed_num, damage[], max_turn, unSkillIds[], isPermanent, cur_round, max_round, target_skill_id`.
- **Parser:** `SocketGameReader.readBufferII` (`CM/map/internals/utils/SocketGameReader.as:122-169`). Mapping:
  - `see_type` → `processType` (0 add, 1 update, 2 remove);
  - `exe_way` → `effectiveType`;
  - `cur_turn` → `currentTurn`;
  - `cur_round` → `countWay` (remaining triggers);
  - `pressed_num` → `layerCount`;
  - `max_turn` → `curMaxTurn` (only when `processType==0`).

`BufferHandler.processBuffer` (`:146-179`):
1. If `processType==2` or `currentTurn==0`: remove the icon and apply the final damage.
2. Otherwise, with `processType==0`, call `RoleInfo.addBuffer`. If a buff with the same `templateId` and `targetSkillId` exists, copy `processType`, `currentTurn`, `countWay`, `layerCount` and `damages` into it. **There are never two instances of the same template.**
3. With `processType` 1 (or after step 2): call `refreshBuffer` and `bufferAffectActionII`, which emit damage numbers and play `ActionEffect`.

**Buff damage** (`DamageMsg`, `order` = hit index)
- `bloodType` 9 adds Fury, 24 adds hit point, 26 adds faith (goddess).
- Other types emit a floating number (`BufferHandler.as:56-115`).

**Cleanup:** `cleanOutTurnBuffer` (`RoleInfo.as:959`) removes buffs with `currentTurn==0` or `countWay==0` on each `refreshBufferTurn`, which `BaseSkill.prepare` calls.

**Tooltip** (`BufferListItemTip.as:90-200`)
- Shows the icon and name; `{X}` is replaced by |value|·layers.
- Shows "N turnos", "N vezes", "Não pode despersar/purificar" and "Pode no máximo acumular camadas: N camadas".

**Immunity:** there is no dedicated client state; immunity is implemented through buffs:
- 0 (markers);
- 69/70 (physical/magic immunity);
- 72/73 (chaos/forget resistance);
- 309 (no new debuffs);
- 400 (no new buffs).

`Parm3` texts confirm that "ao ser atordoado não pode ser atordoado de novo por {ValidCount} rodadas" (after a stun, cannot be stunned again for N rounds) works as a temporary immunity buff.

### 4.3 Buff visuals
- **`AddEffect`:** `"link,pos"`. Plays once on add (`__showBuffer:507`). E.g. `buff.action.attack,2` in 173 buffs.
- **`ActionEffect`:** `"link,pos"`. Plays on each trigger (`addBufferActionEffect:693`). E.g. `buff.action.cure,3` in 141 buffs.
- **`LastEffect`:** `"link,pos,interval"`. Loops while the buff exists (`BufferLastEffect.as`), pausing `interval·40` ms. Examples:
  - `buff.add.PATup,1,5` (574)
  - `buff.last.shield,3,0` (441)
  - `buff.add.MDFup,1,5` (231)
  - `buff.last.coma,1,0` (149)
  - `pet.hallows0N,2,5`
- **`pos`** (`RoleInfo.getSpecialPos:724`): 1 head (0,−120), 2 body (0,−60, default), 3 feet (0,0).
- **`link`:** class name, loaded from `skillEffect/{link with . → _}.swf` (`SkillResourceLoader.addLoader`, `PathManager.as:140`). Preload follows skill → `BufferIds` → `TalentEffIds` → `EffBufferIds`.
- `BufferIconFactory.getBufferEffect(int)` → `slg.resource.BufferEffect{1..11}` exists but **is never called**. Buffs use `getBufferEffectII(link)`; this corrects [docs/client/graphics.md](../../docs/client/graphics.md) §3.

---

## 5. Talents: `TalentEffectTempInfos`

- **Class:** `CM/yishi/datas/templates/TalentEffectInfo.as`.
- **Target skills:** `EffSkillType` = −1 (all, 863 rows) or a `SonType`. Among SonTypes, 511..536 are Avenger, 5040 rows.

**What a talent modifies**
- **Skill:**
  - `EffSp*` → cost;
  - `EffDam*` → Parameter1/2;
  - `EffCd*` → cooldown. E.g. `EffCdValue −5000`, `EffCdPercent −100`;
  - `EffAttackObject` → target;
  - `EffCriValue` → crit (server-side).
- **Buff:** `EffBufferType` points to the **buff Id** to scale. Modifiers: `EffBuffPercent/Value` (on AttackValue and ValuePercent), `EffRandPercent/Value` (on Random), `EffCountPercent/Value` (on ValidCount) (`MonsterModel.as:762-790`).
- **Theseus examples:**
  - EBT 15: Theseus Shield (Escudo de Teseus) damage reduction −5.
  - EBT 20: Sword (Espada) damage +20.
  - EBT 33: Light (Luz) healing +5.
- `EffBufferIds` lists extra buffs, used for preload.
- Always 0 in the data: `EffCt*`, `EffBuffer`, `EffCountPercent`.
- `EffIsActive` = 1 in 94 rows *(assumption)*.

---

## 6. Passive skill attributes: `SkillPropertyTempInfos`

- `TemplateId` **is** `SkillTempInfos.TemplateId`: 11541 of 11924 rows match.
- Read via `skillPropertyTemplateCate.getTemplateByID(skillId)` by runes/stones, stelas (`StelaResistTemplateInfo.as:35`), titles (`AppellModel.as:250`), fashion, marriage, monsters, Theseus, ThessBox and Guardian (child) emblems.
- **`AddType`:**
  - 0 = % (697 rows): `stat += int(stat·X/100)`;
  - 1 = flat (11219 rows);
  - 2 = ignored by the client (8 "Inspiração" rows, 45021-45028).
  - Source: `M14/child/emblem/ChildEmblemUpGradeFrame.as:218-275`.
- **Primary-attribute conversion with AddType 1:**
  - Attack += Power·4
  - MagicAttack += Intellect·4
  - Defence += Agility·4 + Power
  - MagicDefence += Agility·4 + Intellect
  - Live += Physique·20
- **Score:** `GoodsInfo.getById` (`:496`).
- The columns Conat, Strength and Tenacity exist in the class but not in the BR XML.
- **Examples:**
  - 1042: Físico +50 (flat);
  - 5000: ATQ/MAG/DEF/RES/Vida +1% (percent);
  - 2001 "Determinação": ATQ/DEF/RES +200, Vida +2000.

---

## 7. Out-of-battle effects and property codes: `EffectTempInfos` (`stat_property_code`)

### 7.1 Template table selection
**Purpose:** out-of-battle effects (castle, items, guild). `PlayerBufferInfo.template` chooses the template table (`CM/yishi/datas/playerinfo/PlayerBufferInfo.as:257-276`):

| `bufferType` | template table |
|---:|---|
| 2 (OTHER) or 4 (CAKE) | EffectTempInfos |
| 7 | SkillTempInfos |
| 40007 | MagicSpring |
| others | CampaignBufferTemps |

Enum `player_buffer_type` in `PlayerBufferType.as`.

### 7.2 Property codes
- **Convention:** `TemplateId = OwnTypes·1000 + PropertyType1`.
- `PropertyType2/3` = 1 and `Property2/3` = 0 in all 78 rows.
- **No client switch.** The mapping is inferred from the pt-BR texts:

  | codes | meaning |
  |---|---|
  | 4 | gold |
  | 5 | population % |
  | 8 | storage % |
  | 30 | map EXP % |
  | 37 | Proteção % |
  | 41-47 | hero ATQ/MAG/DEF/RES/Vida/Infantaria/Crítico % |
  | 48 | honor % |
  | 104/204 | gold production |
  | 120-124 / 220-224 | soldier Vida/ATQ/DEF/MAG/RES |
  | 135/137/138/139/140 | Força/Proteção/Inteligência/Liderança/Físico (points) |
  | 141-146 / 241-246 | hero ATQ/MAG/DEF/RES/Vida/Infantaria addition |
  | 149-152 | "do Poder" attributes |
  | 153 | battle Fury |
  | 154-157 | ATQ/MAG/DEF/RES (points) |
  | 158-163 | anti-fire/water/shock/wind/light/dark |
  | 164 | anti-resistance |
  | 200 | disguise |
  | 201 | attack protection |
  | 202 | all primaries |
  | 247 | items ×3 |
  | 248-251 | Master attributes |

- **Value example:** 1104 has `Property1` 240 gold. When `Property1` = 1, the real value comes from the buff level (`{Grades}` in `Description`).
- **`OwnTypes`:**
  - 1 building *(assumption)*;
  - 2 item buff;
  - 3 guild/master *(assumption)*;
  - 4 cake/wine (2145/2146).
- **Warning:** this code space is **different** from `SkillBufferTempInfos.AttackType`. E.g. 4 here is gold; in buffs it is magic defense.

### 7.3 Named attributes
- Enum `stat_attribute_name` (lang `army.stone.property1..13,99` and `PropertyName.*`): 1 Força, 2 Proteção (=Agility), 3 Inteligência, 4 Físico, 5 Liderança (Captain), 6 Ataque Físico, 7 Defesa Física, 8 Ataque Mágico, 9 Defesa Mágica, 10 Vida, 11 Infantaria, 12 Crítico (ForceHit), 13 Bloqueio (Parry), 99 all.
- Resistances (`planesRewardTip.resistance.typeText1..7`): Redução, Fogo, Água, Choque, Vento, Escuridão, Luz.

---

## 8. Campaign and mode buffs

### 8.1 Campaign buffs (`CampaignBufferTemps`, 165 rows)
- `Types` has 14 families. Main ones:

  | `Types` | family | rows |
  |---:|---|---:|
  | 3 | Espírito da Coragem | 100 levels |
  | 7 | World boss inspiration (ATQ/MAG +500..) | 20 |
  | 19 | Amizade (EXP) | 9 |
  | 30 | Alma Gêmea (marriage) | 9 |
  | 39 | Inspiração dos Três Reinos | 10 |
  | 29 | Tower damage reduction (−100) | 5 |

- Type 30 is confirmed by `getTemplateByTypeAndGrades(30, level)` (`IconFactory.as:243`, `MarryTip`).
- Attributes are in % (points in Type 7).
- `Crit`/`Block` are absent from the AS3 class.
- Received via `ArmyBufferMsg` / `4165 U_C_BUFFER_LIST`.

### 8.2 Random boss buffs (`RandomBossBuffInfos`, 72 rows)
- Random boss buff shop (`M3/map/campaign/view/frame/CampaignBuffFrame.as:50-73`).
- `SkillId` → `TrailPropInfo.id` → `getSkillTemplateInfoById`.
- **Purchase:** up to `CanBuyCount` = 3 times; price `NeedCount` (4 values) of item 2130058.
- **Protos:** `RandomBossBuffefMsg{turn, buffs}`, `RandomBuffMsg`.
- **Ids 801080.. do not exist in BR SkillTempInfos** (dangling reference).

### 8.3 Glory Road buffs (`GloryRoadBufferInfos`, 40 rows)
- 9 types: HP %, ATQ+MAG %, DEF+RES %, all resistances %, Fury +20/+40, awakening +500/700/900, heal %, enemy Guardian blocked, enemy leader HP −%.
- `Pos` = slot 1 to 4; `Price` 5 to 40.

---

## 9. Vehicles (Unreal Shooting, Snow War, tanks)

### 9.1 Vehicle skills (`VehicleSkillTempInfos`, 77 rows)
- **`CastTime`/`CoolDown`:** in ms.
- **`Power`:** damage %.
- **`InjuryEffect`** (`VehicleMapGlobal.as:9-17`): 0 self, 1 single target, 2 area (radius `DamageCoverage`), 3 passive, 4 trap.
- **`IFF`:** 1 enemy / 2 own *(assumption)*.
- **`AttackRange`:** in px (`UnrealShootingCastAction.as:88`).
- **`Buffs`:** `"buffId,chance%"`. E.g. `5,50` = 50% Tontura (stun).
- **Resources:** `{RES}vehicle/skill/{ActionId}.swf`, classes `asset.vehicle.start{id}`, `end{id}`, `fly{id}` (`M17/com/map/vehicle/SkillEffectFactory.as:60-138`).

### 9.2 Vehicle buffs (`VehicleBuffTempInfos`, 44 rows)
- **`EffectType`** (`VehicleSkillEffectType.as`):

  | value | effect |
  |---:|---|
  | 1 | attack |
  | 2 | debuff immune |
  | 4 | stun |
  | 5 | stun immune |
  | 6 | speed |
  | 7 | slow immune |
  | 8 | HP per tick |
  | 9 | lifesteal |
  | 10 | extra damage |
  | 12 | damage immune |
  | 19 | transformation (`CampaignArmy.as:747`) |

  Values 3, 11 and 13-18 are *(assumption)*.
- **`Duration`:** in ms; −1 = permanent, 0 = instant.
- **`Interval`:** tick period in ms. E.g. id 10 bleeds −50 every 3000 ms for 12000 ms.
- **`TogglePercent`:** trigger chance.
- **`LastEffect`:** → `asset.vehicle.{name}`; the suffix `_a`/`_b` picks the slot (`EffectsLayer.as:139-165`).
- **Opcodes:** `8616 C_VEHICLE_ATTACK`, 4520-4522 (rsp / sync skill / sync buff). **Protos:** `VehicleBuffStateMsg`, `VehicleSkillListMsg`.

---

## 10. United goddess, Avenger and auto-chess (skill links only)

- **`GoddessUnitedSkillTemplates`** (4 rows): skill 8000001..4 (MasterType 82) activates when **all** formation goddesses reach `MinLevel` 5/15/30/50. Each skill has `BufferIds` 800000N0..N4. Goddess skills 80/81 trigger movie 4102 (`BattleAttackTransaction.as:165`).
- **`AvengerSkillTemplates`** (180 rows):
  - `Id` = `SkillSonType·100 + SkillGrade`.
  - `SkillSonType` + `SkillGrade` match `SkillTempInfos.SonType` + `Grades` in 180/180.
  - `JobType` 1/2/3 → SonType 51x/52x/53x; xx1-xx3 main (500), xx4-xx6 secondary (501).
  - Upgrade cost: `NeedBodyGrade` + 6 pairs `NeedItemN`/`NumN`.
  - In battle: 4589 (SP), 4591 (`AvengerBattleSkillMsg`); skill switch via 10521.
- **`AutoChessBuffInfos`** (24 rows): `SkillId` with MasterType 610, activated by `Amount` units of the same `Job`. E.g. Guerreiro ×2 = +5% damage.

---

## 11. Graphic resources

**skillEffect**
- **File:** `{RES}skillEffect/{link with "." → "_"}.swf`. The class is named after the link (`SkillResourceLoader.as:182-200`).
- Frames and buffs reference 352 distinct links; only 66 are in `index/manifest_res.json`, which has 81 `skilleffect/*` entries. **The manifest is partial.**
- **Always loaded:** `skill_public.swf` (`BattleResPreloadManager.as:46`, `ResourceModel.as:491`) and `resist_sheld.swf` (`ResourceModel.as:457`).

**Battle assets used by skills**
- `battle.resource.PassiveEffectAsset`
- `profound.RoleBodyEffect{sex}_{job}`
- `profound.DisperseAsset`
- `battle.bufferResistMc`
- `dust.*` (movement dust)
- `hit.physical00N` / `hit.magical00N` (impacts)

**Damage numbers and bloodType:** see [docs/battle/README.md](../../docs/battle/README.md) §3. Enum `blood_type` adds value 11 (UNENABLE_SKILL).

**Icons**
- **Skill:** `{RES}icon{Icons}`.
- **Buff:** `{RES}icon/{Icon}` (`IconFactory.as:30,40`).

---

## 12. Domain opcodes and protos

| dir | opcode | name | proto |
|---|---:|---|---|
| ↑ | 10008 | U_B_HERO_ORDER | UseSkillMsg{battle_id, hero_id, skill_id} (`SocketSendManager.as:210`) |
| ↑ | 10522 / 10516 / 10520 / 25240 | warsoul / child / monster / child NS (skill commands) | UseSkillMsg |
| ↑ | 10521 / 10523 | B_AVENGER_SWITCH_SKILL / B_USE_STONETRRIGERSKILL | none |
| ↑ | 10015 | U_B_QTE | QteMsg |
| ↓ | 75 | U_B_HERO_ORDER | HeroOrderMsg{hero_index_id, skill_id, result, cast_time, qte_time, targetIndexs} |
| ↓ | 153 | U_B_ATTACKING | AttackOrderMsg{…, damages[DamageMsg], buffers[BufferMsg], cdTime, curturn, coexist} |
| ↓ | 173 | U_C_SPECIAL_BUFFER | ShowPermanentBuffMsg (listener never enabled, see [docs/battle/README.md](../../docs/battle/README.md)) |
| ↓ | 60 / 61 | U_C_HERO_SKILL_UPGRADE / U_C_HERO_SKILLPOINT_RESET | HeroSkillInfoMsg{skill_point, skill_script, skillSet} |
| ↑↓ | 5187 / 4430 / 4431 | talents | none |
| ↓ | 4165 / 4171 / 4188 / 4262 / 4374 | buff list / gods / item / broadcast / world boss | ArmyBufferMsg, BufferDataMsg{template_id, validity_date, grade, type, type_templateid}, BufferInfoMsg{buffer_tempId, left_time, add_count} |
| ↓ | 392 / 541 / 4591 | Einherjar (pet) skill / trigger skill / Avenger skill | PetSkillMsg, TriggerSkillMsg{templated_id, cool_down, appear_cool_down}, AvengerBattleSkillMsg |

---

## 13. Gaps and warnings

- `BufferMsg` is not in [protocol/proto.json](../../protocol/proto.json). It is defined only in `CM/com/road/yishi/proto/battle/BufferMsg.as`.
- Server-interpreted fields have no client switch; their labels are inferred from names:
  - `SkillTempInfos.CountWay` and `AppearTime`;
  - `SkillBufferTempInfos.AttackObject` and `AddWay` beyond 1/4;
  - `AttackType` codes beyond those the client tests;
  - `EffectTempInfos.OwnTypes`.
- `QTETime` is always 0 and `ActionInfos.Sex` is always 2: QTE and per-sex animations are inert in BR.
- **Dangling references:** `RandomBossBuffInfos.SkillId` (801080..) and `ArtifactTemplateInfos.Skills` (12501..) do not exist in `SkillTempInfos`.
- `VehicleObjectTempInfos.GeniusSkill`/`NormalSkill` point to `VehicleSkillTempInfos`: 1003/1004 are the "Paralisação" skills.
