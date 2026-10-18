# Heroes, units and combat attributes (Legend Online BR)

This document describes how heroes, soldiers, monsters and their combat attributes work in Legend Online BR: hero templates (`GameHeroTemp`), classes, attributes, levels and job transfers; soldiers, army, formation, monsters and AI; in-battle combat systems and resources (awakening, Avenger, War Spirit, QTE, damage, Fury, HitPoint); and the hero progression systems (stars, talents, runes, magic cards, potential, stelae, slates, Auto Chess and Theseus). It does not describe the battle flow, combat opcodes or the position grid in detail; those live in the battle docs listed below. Sources: decompiled AS3 and real data in `data/tpl/tempinfos/*.xml`. The machine-readable companion is [data/research/heroes_combat.json](../../data/research/heroes_combat.json) (95 enums with 689 values, 559 fields from 39 template sets, 72 formulas).

**Conventions**

- **Path prefixes:** **CM** = `decompiled/core_module/scripts`; **Mn** = `decompiled/mN/scripts` (e.g. M5 = `decompiled/m5/scripts`).
- **Uncertainty:** *(assumption)* marks anything not confirmed in code.
- **Related docs:** battle flow, combat opcodes and the 1-12 position grid in [docs/battle/README.md](../../docs/battle/README.md) §1-4; assets in [docs/client/graphics.md](../../docs/client/graphics.md); managers in [docs/client/managers.md](../../docs/client/managers.md).

## Contents

- [1. Heroes, classes and attributes (`GameHeroTemp`)](#1-heroes-classes-and-attributes-gameherotemp)
  - [1.1 Classes and sex (`JobType`, `SexType`)](#11-classes-and-sex-jobtype-sextype)
  - [1.2 Hero types (`HeroType`)](#12-hero-types-herotype)
  - [1.3 Primary attributes → combat attributes](#13-primary-attributes--combat-attributes)
  - [1.4 Other `GameHeroTemp` fields](#14-other-gameherotemp-fields)
  - [1.5 Levels, EXP and job transfers (vocation)](#15-levels-exp-and-job-transfers-vocation)
  - [1.6 Generic progression table (`UpGradeTempInfos`)](#16-generic-progression-table-upgradetempinfos)
- [2. Soldiers, army, monsters and AI](#2-soldiers-army-monsters-and-ai)
  - [2.1 Soldiers and troops (`PawnTempInfos`)](#21-soldiers-and-troops-pawntempinfos)
  - [2.2 Army and formation](#22-army-and-formation)
  - [2.3 Monsters (Monstro): `MonsterTemplates`](#23-monsters-monstro-monstertemplates)
  - [2.4 Hero and boss AI (`HeroAis`)](#24-hero-and-boss-ai-heroais)
- [3. Combat systems (awakening, Avenger, WarSoul, QTE, damage, resources)](#3-combat-systems-awakening-avenger-warsoul-qte-damage-resources)
  - [3.1 Awakening (Despertamento / Awaken)](#31-awakening-despertamento--awaken)
  - [3.2 Avenger (Vingador)](#32-avenger-vingador)
  - [3.3 War Spirit (Theseus): `WarSoul`](#33-war-spirit-theseus-warsoul)
  - [3.4 War Tower (Torre da Guerra): `WarSoulTower`](#34-war-tower-torre-da-guerra-warsoultower)
  - [3.5 QTE](#35-qte)
  - [3.6 Damage: `bloodType`, critical, parry, resistance and stun](#36-damage-bloodtype-critical-parry-resistance-and-stun)
  - [3.7 Fury (SP)](#37-fury-sp)
  - [3.8 HitPoint (Pontos de ATQ)](#38-hitpoint-pontos-de-atq)
- [4. Stars, talents, runes, magic cards and potential](#4-stars-talents-runes-magic-cards-and-potential)
  - [4.1 Stars and cosmos (Astrologia, Astrology): `starTempInfos`](#41-stars-and-cosmos-astrologia-astrology-startempinfos)
  - [4.2 Talents: `TalentEffectTempInfos` (6932 rows)](#42-talents-talenteffecttempinfos-6932-rows)
  - [4.3 Runes (rune skills): `RuneTempInfos` (132)](#43-runes-rune-skills-runetempinfos-132)
  - [4.4 Rune gems, holes and set effects: `RuneGemInfos` (375), `RuneHoleInfos` (133), `RuneFsgainInfos` (179)](#44-rune-gems-holes-and-set-effects-runegeminfos-375-runeholeinfos-133-runefsgaininfos-179)
  - [4.5 Magic cards (Carta Mágica): `MagicCardTempInfos` (180 = 20 cards × 9 levels)](#45-magic-cards-carta-mágica-magiccardtempinfos-180--20-cards--9-levels)
  - [4.6 Potential (Potencialidades, Proficiency): `ProficiencyTemplates` (700)](#46-potential-potencialidades-proficiency-proficiencytemplates-700)
- [5. Stelae, slates, Auto Chess and Theseus](#5-stelae-slates-auto-chess-and-theseus)
  - [5.1 Stelae (Estela; Stela / 石碑): `StelaTemplates`, `StelaStepTemplates`, `StelaPropertyTemplates`, `StelaResistTemplates`](#51-stelae-estela-stela--石碑-stelatemplates-stelasteptemplates-stelapropertytemplates-stelaresisttemplates)
  - [5.2 Divine slates (Placa divina; Slate / 石板 / Theseus "Divino"): `SlateTmpls`, `SlateUpgradeTmpls`, `SlateTaskTmpls`](#52-divine-slates-placa-divina-slate--石板--theseus-divino-slatetmpls-slateupgradetmpls-slatetasktmpls)
  - [5.3 Auto Chess (Supremacia do Legend / SelfChess): `AutoChessHeroInfos`, `AutoChessBuffInfos`](#53-auto-chess-supremacia-do-legend--selfchess-autochessheroinfos-autochessbuffinfos)
  - [5.4 Theseus overview (Alma de Teseu / Theseussoul)](#54-theseus-overview-alma-de-teseu--theseussoul)
  - [5.5 Theseus equipment (strengthening, quality and sets): `TheseusEquipStrengthenTmpls`, `TheseusEquipQualityTmpls`, `TheseusEquipSuiteTemplates`](#55-theseus-equipment-strengthening-quality-and-sets-theseusequipstrengthentmpls-theseusequipqualitytmpls-theseusequipsuitetemplates)
  - [5.6 Theseus Fury and War Intent (Intenção de Guerra): `TheseusRageTemplates`, `TheseusRageSuiteTemplates`](#56-theseus-fury-and-war-intent-intenção-de-guerra-theseusragetemplates-theseusragesuitetemplates)
  - [5.7 Theseus Treasure (Regenerating Seal): `TheseusTreasureCoreTemplates`, `TheseusTreasureGrowupTemplates`, `TheseusTreasureHokeTemplates`](#57-theseus-treasure-regenerating-seal-theseustreasurecoretemplates-theseustreasuregrowuptemplates-theseustreasurehoketemplates)

## 1. Heroes, classes and attributes (`GameHeroTemp`)

### 1.1 Classes and sex (`JobType`, `SexType`)

- **Role:** the class sets the starting skills, the skill/rune/talent trees and the default avatar. When the player hero loads, `ThaneInfo.checkFirst` calls `skillCate.initAllSkill(Job)`, `runeCate.initAllRune(Job)` and `talentData.initAllSkill(Job)` (`decompiled/core_module/scripts/yishi/datas/playerinfo/ThaneInfo.as:397-399`).
- **Values** (`decompiled/core_module/scripts/yishi/datas/consant/JobType.as:8-18`):

  | Value | Meaning |
  |---:|---|
  | 0 | no restriction |
  | 1 | Guerreiro (Warrior) |
  | 2 | Arqueiro (Archer) |
  | 3 | Feiticeiro (Sorcerer) |
  | 4 | Encantador de Dragões (Dragon Talker form; no `GameHeroTemp` uses it) |
  | 100 | "Misterioso", novice |

- **Data-only value:** NPCs use Job=10, which has no code constant (7,241 of 7,370 templates).
- **Short names:** `getJobName` (`JobType.as:25-46`) returns "Gue."/"Arq."/"Fei.". Codes 5 and 6 alias Archer and Sorcerer.
- **Long names:** language keys `yishi.datas.consant.JobType.JobName1..4`.
- **Default avatar:** `equip_show/<warrior|hunter|wizard>_default<part><Sexs>.swf`, or `equip_show/dragonic/dragonman_default…` (`decompiled/core_module/scripts/avatar/view/ShowAvatar.as:94-117`).
- **Sitting avatar:** `/warrior_sitdown_body`, `/sword_sitdown_body` or `/wizard_sitdown_body` (`JobType.as:66-84`).
- **Sex** (`SexType.as:13-26`): 0 = Feminino, 1 = Masculino, 2 = "S/ Restrição".
- **Uses of sex:**
  - selects the avatar SWF variant;
  - selects the skill resource package (`SkillResLoaderVO(skill, Sexs)`, `BattleResPreloadManager.as:117`);
  - bosses (type 3) use index 2 (`CreateGameTransaction.as:464`).

### 1.2 Hero types (`HeroType`)

Real distribution: 3 = 6,865, 7 = 196, 8 = 180, 2 = 120, 1 = 9.

| HeroType | Meaning | Rendering | Examples |
|---:|---|---|---|
| 1 | player hero (base class) | part-based avatar | 1 Guerreiro, 2 Arqueiro, 3 Feiticeiro, 4 Guerreira, 5 Arqueira, 6 Feiticeira; 7-9 are male copies with Live=4000 |
| 2 | NPC with a class appearance *(assumption)* | part-based avatar | ids 11001..306010, Grades 1..60, no AI |
| 3 | NPC monster/boss | `swf/<ResPath>/<ResPath>.swf` (`PathManager.as:135`) | 1008 "Cavaleiro das Chamas Débora" (boss032); 8100001.. are the WarSoul Tower units; 5000001.. are bosses with resistances of 100000 |
| 7 / 8 | special NPCs *(assumption)* | same as type 3 (`HeroRoleView.as:114` excludes 3/7/8 from the avatar) | 401001 "Filth" (Live 2.4 M); 411012 "Balrog" (Live 11.8 M) |

- In battle the type arrives in `HeroMsg.type` and is stored in `HeroRoleInfo.type` (`SocketGameReader.as:252`).
- Units with type 3 and face 2 get the boss bar `BossBottomStrip` (`RoleViewBase.as:304`) and are preloaded by ResPath (`BattleResPreloadManager.as:68-70`).

### 1.3 Primary attributes → combat attributes

Tooltip texts (`armyII.ThaneAttributeView.*`) are shown in `decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:590`.

| Field | In-game name | Effect per point |
|---|---|---|
| Power | Força | +4 Attack, +1 Defense |
| Agility | **Proteção** (护甲 = armor; not agility) | +4 Defense, +4 Resistance |
| Intellect | Inteligência | +4 Magic, +1 Resistance |
| Physique | Físico | +20 HP |
| Captain | Liderança | +1 "Infantaria" (soldier) |

- **Player values:** players start with Power/Agility/Intellect/Physique = 5 and Captain = 100. NPCs have 0; their final stats are stored directly in Attack/Defence/MagicAttack/MagicDefence/Live.
- **Free points:** allocated with `5171 U_C_HERO_ADDPOINT` (`HeroAddPointReqMsg`: power/agility/intellect/captain/physique_point) and reset with `5170 U_C_HERO_RESETPOINT` (`ArmySocketOutManager.sendWashPoint`, `managers/ArmySocketOutManager.as:291`).
- **Computation:** the server sends the totals ready-made via `113 U_C_HERO_INFO` (`SimpleHeroInfoMsg` → `ThaneInfoHelper.readHeroInfo`, `ArmyManager.as:372`). The client never computes final attributes.
- **Combat attribute tooltips** (`ThaneAttributeFrame.as:709-735`):
  - Ataque: "Causa danos ao alvo";
  - Defesa: "Reduz danos de ataque";
  - Magia: "Causa danos de magia";
  - Resistência: "Reduz danos de magia";
  - Crítico (ForceHit): "Aumenta a probabilidade de crítico";
  - Bloqueio (Parry): "Aumento da probabilidade do bloqueio";
  - Penetração: "Reduz a probabilidade de bloqueio do alvo";
  - Vida: "Adição ao limite de vida";
  - Infantaria (ConatArmy): "Aumento do número de soldados";
  - "Força Consistente"/Determinação (StunAttr, internal `Dingli`): "Aumentar a probabilidade de Tontura da outra parte / Diminuir a sua probabilidade de Tontura".
- **Intensity/Tenacity** (`HeroMsg.strength/tenacity`): converted to % via `x·100/(x+8000)` (`AttackProrertyInfo.as:109-117`): "Aumento dos danos do jogador" (damage dealt up) and "Redução de danos recebidos" (damage taken down).
- **Internal name mapping** (`SortController.as:164-190`, `PerkinLabManager.as:248-279`):
  - `ReduceResi` = `totalBattleWill` ("Anti-Resistência");
  - `ReduceResiAgainst` = `totalResistResi` ("Anti_Res.");
  - `ResiPenetrate` = `totalStrikeResi` ("Res. de Penetração");
  - `StunAttr` = `totalDingli`.
- **Elemental resistances:** Fire/Water/Elect/Wind/Dark/Light.
  - `GameHeroTemplateCate.getHeroResistance` (`:20-48`) shows the first value >0 as the "boss element".
  - The panel computes a `min(floor(resi·0.12), 90)`% reduction (`ThaneAttributeFrame.as:759`) but discards the result.
  - Tooltip rule: when the opponent's anti-resistance reaches 0, attribute-X hits reduce damage by Y%.
  - Real values: 0 (3,911), 100000 (1,002, effectively immune), 200, 2000, 3600…
- **Item score** (`GoodsInfo.as:410`): `ATK+DEF+MAG+RES+Crit+int(Vida/5)+Conat+(Força+Proteção+Int)·4+(Liderança+Físico)·2`. This is the game's own relative weight per attribute.
- **Combat power:** `fightingCapacity`/`HeroMsg.fight_capacity` comes ready-made from the server (`SortController.as:164`).

### 1.4 Other `GameHeroTemp` fields

- **AI:** key into `HeroAis.ID`. All 7,234 nonzero values exist there.
- **DefaultSkill:** basic attack. Player: 10000/20000/30000 "Ataque Normal"; NPC: 60073 "Lagarto B" in 1,059 templates.
- **SkillScript:** skill CSV. Warrior example: `10711,10811` = "Ataque Supressivo" + "Ataque Fulminante". Only 16 distinct combinations exist.
- **Captain:** on NPCs, the number of boss HP bar strips (`BattleModel.getBossHpStripNum`, `BattleModel.as:139`). Values 3..8.
- **Conat:** 0 or 1. *(assumption)* 1 = NPC accompanied by troops; 146 cases, ids 82053.. "Kerolash"….
- **RejectType** *(assumption)*: list of `SkillBufferTempInfos.AttackType` values the unit is immune to.
  - 19 = immobilize, 13 = slow, 5 = DoT, 38 = confusion, 39 = oblivion, 100 = ?.
  - The pattern "19,13,5,100,38,39" appears on 2,714 bosses.
- **ArmPath/ClothPath:** always empty (legacy fields).
- **Grades:** 0..99. 5,793 NPCs are level 80. Shown in the boss header (`BossInfoView.as:230`, asset `asset.battle.BossGradeNumAsset`).
- **Icon:** `{res}icon<Icon>` (`IconFactory.as:81`), e.g. `/head_monster011A.jpg` (292 uses).

### 1.5 Levels, EXP and job transfers (vocation)

- **Base level:** 1..80. Table `UpGradeTempInfos` Types=3; Data = EXP from the current level to the next.
  - Examples: lv2 = 3,000; lv20 = 65,000; lv40 = 4,051,440; lv60 = 21,872,849; lv80 = 110,946,655.
  - Sum 1..80 = 1.41 billion.
- **Stages** (`SimplePlayerInfo.vocationIndex`; ConfigInfos `alliance_playerjob`: 1 = not transferred, 2 = 1st, 3 = 2nd, 4 = 3rd):

  | Stage | Condition | EXP table | Levels | Names |
  |---|---|---|---|---|
  | 1st transfer ("vocação") | vocationGrades>0, index 0 | Types=105 | 80 (99,000..273,761,441) | `VocationJob<job>Level1..8`: "Dragão Espadachim Aprendiz"… "Alma do Dragão · Espada Divina" |
  | 2nd transfer | index 1/2 | Types=110 | 80 | `TemplateName.split('|')[job-1]`, e.g. "Espadachim Básico" |
  | Avenger (Vingador) | index ≥3 | Types=152 | 30 | "Deus espadachim vingador…" |
  | Holy (Sagrado) | index ≥4 | Types=158 | 40 | "Espadachim vingador caótico…" |

- **Branch choice:** `9576 C_CHANGEJOB` (`ChangePlayerInfoMsg.branch`); a branch swap uses `9577 C_EXCHANGEJOB_BRANCH` (`ChangeJobControler.as:33-47`).
- **Branch requirement:** tattoo attributes in ConfigInfos `Job<j>_Branch<b>` (order: Força, Proteção, Inteligência, Físico, Liderança).
  - Warrior: 6000/1500/0/1500/0;
  - Archer: 7000/1000/0/1000/0;
  - Sorcerer: 0/1500/6000/1500/0.
  - Check: `ChangeJobFrame.checkBranchCondition` (`decompiled/m5/scripts/changeJob/ChangeJobFrame.as:197`).
- **Branch names:** `changeJob.branchName11..32` (branch 1: Dom Violento / Dom de Tiro / Dom de Arcana; branch 2: Dom de Defesa / Dom de Sobrevivência / Dom de Recuperação).
- **Total level** (`ThaneInfo.totalGrade`, `ThaneInfo.as:511-531`):
  - no transfer: `grades+vocationGrades`;
  - 2nd transfer: `160+voc`;
  - Avenger: `240+voc`;
  - Holy: `270+voc`.
  - Cap ≈ 310. Battle rooms use the brackets 1-50, 51-80, 81-160, 161-240 and 241-280 (ConfigInfos `cross_war_match_room`).
- **Stage and level within the stage:** `level=floor((voc-1)/10)+1`, `step=voc%10` (`SimplePlayerInfo.as:1279-1296`).
- **EXP bar:** `PlayerExperenceView.refreshView` (`ui/maintoolbar/view/PlayerExperenceView.as:147-195`).
- **Related ConfigInfos:**
  - `AddSkill_Grade=6`: 1st skill point;
  - `Talent_OpenGrade=40`;
  - `Talent_MaxPlayerGrade=70`;
  - `OpenRuneGrade=35`;
  - `HeroSkillSet=1,10811|2,20811|3,30811`: tutorial skill.
- **Protos and opcodes:** `113 U_C_HERO_INFO`; `60 U_C_HERO_SKILL_UPGRADE`; `61 U_C_HERO_SKILLPOINT_RESET`; `66/67 RESET/ADDPOINT`; `4557 U_C_TRANS_GRADE`; `4796 U_C_SEX_CHANGE`.
  - The battle `HeroMsg` (battle package, 117 fields) carries stats and combat state: phy_attack, mag_defence, force_hit, parry, fireResi..lightResi, reduce_resi, strength, tenacity, penetrate, stunAttr, sp/spMax/spLimit, hitPoint/hitPointMax, awake, avengerSp, warSoulSp, transfer_grade, changeBranch, etc.

### 1.6 Generic progression table (`UpGradeTempInfos`)

- 13,335 rows, 110 Types values.
- Read via `getTemplateByLevelAndType(grade, type)` / `getTemplatesByType(type)` (`TempleteManager.as:2291-2330`).
- Type constants: `decompiled/core_module/scripts/yishi/datas/consant/UpgradeType.as`.
- **Types=1:** troop EXP. 879 rows; `TemplateId` = `PawnTempInfos.TemplateId`, levels 1..80; troop 110 lv80 costs 20,966,400.
- **Data:** EXP from the previous level to `Grades`, not cumulative.
- **ActiveObject:** extra per-type parameter, e.g. Dragon Soul 7101..7105.
- **TemplateName:** in class-related types, holds per-class names separated by "|".

## 2. Soldiers, army, monsters and AI

### 2.1 Soldiers and troops (`PawnTempInfos`)

Each `PawnTempInfos` row (6,464) is one soldier at one level. A hero leads a single soldier stack (troop), and combat treats the stack as one unit. Stack stats (Live, Attack…) are **per soldier**; HP and damage scale with the count (computed server-side *(assumption)*).

#### Player soldier classes (MasterType 1-11, 80 levels each)

| Class | TemplateId | Barracks | Type | Gold/soldier |
|---|---|---|---|---|
| Lanceiro (Lancer) | 101xx | Lv1 | physical | 2 |
| Arqueiro (Archer) | 102xx | Lv4 | physical | 2 |
| Espadachim (Swordsman) | 103xx | Lv20 | physical | 3 |
| Sacerdote (Priest) | 105xx | Lv20 | magic | 3 |
| Griffin | 104xx | Lv30 | physical | 3 |
| Cavaleiro (Knight) | 106xx | Lv40 | physical | 4 |
| Anjo (Angel) | 107xx | Lv40 | magic | 4 |
| Demônio (Demon) | 108xx | Lv50 | physical | 4 |
| Presbítera (Priestess) | 109xx | Lv50 | magic | 4 |
| Cavaleiro Mágico (Magic Knight) | 110xx | Lv70 | physical | 4 |
| Anjo Mágico (Magic Angel) | 111xx | Lv70 | magic | 4 |

- **Id formulas:** `TemplateId = 10000 + MT·100 + Lv` and `SonType = 100 + MT` (`ArmyManager.initPawnList`, `decompiled/core_module/scripts/yishi/manager/ArmyManager.as:130`).
- **Level chain:** NextLevelTemplateId links Lv1→Lv80 (869 valid links); 0 at Lv80.
- **Stats:** ForceHit rises 64 → 1,170 in every class. E.g. Lancer: Life 323 / Attack 64 at Lv1, 1,034 / 1,644 at Lv80. Player soldiers have 0 resistances.
- **Skills:** each class has 1 HighSkill (icon `skill_pawn_0NN.png`). The AI (HeroAis 100·MT) alternates the normal attack with it; e.g. Lancer `10,11,10,11…`.

#### NPC soldiers

- MasterType 101 = PawnType.PAWN1: 5,499 rows, Lv1 to Lv99. E.g. 'Lanceiro Sangrento', 'Alma Errante'.
  - They have resistances: 1,392 rows, from -200 to 40,000.
  - NeedBuilding = 0; the icon is almost always `/head_unknown.jpg`.
- MasterType 12: 85 rows with DefaultSkill 1/2 = animation `Attack0N`; probably Monster Exploration enemies *(assumption)*.
- PawnType PAWN2..PAWN7 (102-107) appear nowhere.

#### Recruitment

Recruitment happens in the Barracks (`CasernRecruitFrame`).

- **Cost:** `ceil(n·GoldConsume·(1−Property4/100)·bonus)`.
- **Maximum:** limited by free population (Residence; NeedPopulation = 1) and gold.
- **Time:** NeedTime = 0, so recruiting is instant. The required Barracks level comes from NeedBuilding (FK BuildingTempInfos, SonType 402).
- **Lists:** for the 'castle' group, `castlePawnList` holds castle soldiers and `casernPawnList` the 11 unlocked classes, both keyed by SonType (`ArmyManager.as:130`).

#### Soldier upgrade

Source: `decompiled/m5/scripts/armyII/viewII/pawnupgrade/PawnLevelUpFrame.as:429`.

- **Currency:** Spirit (Espírito, `playerInfo.strategy`), earned when soldiers die in combat.
- **Cost:** `UpGradeTempInfos` Types=1 (879 rows; TemplateId = next-level id, Data = spirits). Lancer/Archer cost exactly 2·L³ (Lv80 = 1,024,000); Magic Angel Lv80 = 20,966,400.
- **Requirement:** Barracks level ≥ next soldier level.
- **Hint:** the upgrade hint shows when Level < hero Lv − 3 (`ArmyManager.as:793`).
- **Effect:** upgrading swaps the templateId of every stack with the same SonType (opcode `116 U_C_PAWN_INFO` → `synchronizationAllArmyPawns`).
- **Traits** (Apercepção, PawnSpecialTempInfo): unlocked at soldier Lv10; using and converting them needs hero Lv40 (`8580 C_PAWN_CHANGE` / PawnChangeMsg).

#### Soldier graphics

- **Combat:** `{RES}swf/<Swf>/<Swf>.swf`. Player: 001…011; NPC: monsterNNNx (`PathManager.solveRolePath`, `decompiled/core_module/scripts/yishi/manager/PathManager.as:135`).
- **Portrait:** `{RES}icon/head_pawnN.jpg`.

#### Soldier code notes

- `PawnTemplate.as` does not declare resistances, Penetrate or StunAttr: these reach combat via `SoldierMsg` (penetrate, stunAttr).
- Soldier rating: `int((live·(atk+def+mdef·1.5)·(1+matk/500))^0.45)` (`ArmyPawn.as:178`).

### 2.2 Army and formation

- **Structure:** `BaseArmy` has `armyPawns[0..1]`, but the game uses almost only slot 0, plus the hero (`baseHero`) and vice. Pet, child and monster are separate (`decompiled/core_module/scripts/mvc/module/armyII/BaseArmy.as:65`).
- **ArmyType:** 0 not recruited, 1 castle, 2 serial (the player's army; opcode `150 U_C_SERIAL_ARMY`), 4 invite, 5 system.
- **Soldiers per hero:** set by Leadership: `maxPawns = totalConatArmy / NeedPopulation`, i.e. 1 Leadership = 1 soldier (texts `armyII.ThaneAttributeView.captain` and `consortia…explain4`).
  - totalConatArmy = baseConatArmy + bonuses (Leadership gems, mount, titles, etc.), sent ready-made by the server in SimpleHeroInfoMsg.
  - The 'auto-allocate' button fills up to that limit (`ArmyModel.as:114`).
  - Army power: `totalAttribute + totalLive/5 + totalConatArmy`.
- **Formation:** the 1-12 grid is described in [docs/battle/README.md](../../docs/battle/README.md) §4. Hero and troop sit in opposite rows: `fightPos` 1 = front (positions 1,4,7,10), 3 = back (3,6,9,12) (`decompiled/m5/scripts/armyII/viewII/allocate/AllocateView.as:94`).
  - The LineUp screen (`decompiled/m5/scripts/armyII/viewII/lineUp/LineUpView.as:256`) puts the hero in one of the cells [4,7,6,9].
  - Hero at 4/7 (front): soldiers at cells 3 and 12 (the stack shows in 2 cells); child at 6/9; slave child at 12; monster at 3.
  - Hero at 6/9: soldiers at 1 and 10.
  - If a monster or slave child enters combat, it takes the slot and the soldiers are not shown.
- **Panels** (ArmyPanelEnum): EQUIP/SKILL/ATTRIBUTE/INFORMATION/PAWN_PANEL, RECRUIT_PAWN, SORT_PAWN, PAWNUPGRADE, BATTLEGUARD, DRAGON_SOUL, TATTOO, HOLY_DRAGON_SOUL and the rune/stone tabs (FUWEN_*/FUSHI_*).
- **Outgoing opcodes:**
  - `5155 U_C_ARMY_RECRUITED` (recruit), `5156 U_C_ARMY_EDIT` (put soldiers in the troop), `5157 U_C_ARMY_DEMOBPAWN` (disband), `5158 U_C_ARMY_UPGRADEPAWN` (upgrade). All carry `ArmyPawnInfoMsg{tempate_id, own_pawns, sites}`.
  - `8276 C_ARMYPOS_EDIT` (`ArmyFightPosEditMsg{user_id, hero_pos, pawn_pos}`) and `8580 C_PAWN_CHANGE` (`PawnChangeMsg`).
- **Incoming opcodes:** `150 U_C_SERIAL_ARMY` (`ArmyMsg`: armyPawn[], simple_hero_info, monster_id…), 92/100 (`ArmyPawnUpdatedMsg`), `93 U_C_ARMY_EDIT` (`ArmyEditRspMsg`), `116 U_C_PAWN_INFO` (soldier upgraded), 113 (SimpleHeroInfoMsg).
  - `ArmyPawnInfoMsg` fields: id, army_id, sites, son_type, tempate_id, own_pawns, pawnLive[], fight_pos, special_tempIds, comprehedn_tempIds, bless_num.
- **In combat:** `SoldierMsg` (temp_id, pos, hp, stats, penetrate, stunAttr). Manager: `ArmyManager` (`decompiled/core_module/scripts/yishi/manager/ArmyManager.as`).

### 2.3 Monsters (Monstro): `MonsterTemplates`

- **'Monstro' system** (module m14/monster plus `decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as`): pet monsters.
  - The player summons monsters at the Summoning Circle with materials, cooks food in the Kitchen, feeds them (they gain EXP), trains skills, equips accessories and evolves them.
  - A monster can fight in place of the troop (`MonsterManager.model.enterWarMonster`) and, if VersionSwitch.MONSTER_FOLLOW is on, follow the army on the map.
  - Monsters also fight in Monster Exploration (m14/monsterexplore).
- **Data:** 73 rows = 23 species (Type 1-19 with 3★; 96-99 with 4★) × Star; TemplateId = Type·100 + Star.
  - MaxLevel per star: 40/80/120/160.
  - SkillSonTypes gains 1 active SonType per star (e.g. Lobo Demoníaco 830101 'Mordida Voraz', 830102 'Laceração de garras', 830103…).
  - Passives shared by all: 830001 'Transmissão de Resistência' and 830002 'Transmissão de Anti-resistência'.
  - PropertyId → SkillPropertyTempInfos (e.g. 84010101 Attack 8000 / Live 48000).
  - Final attribute: `int(base/10/star)·(Lv−1)+base`, multiplied by the phase bonus (+0/20/50/100/150%; UpGradeTempInfos Types=148).
  - EXP per level: Types=147. Skill training: 149. Accessory: 151.
- **Evolution:** requires star < max, phase ≥ star, Lv = MaxLevel and N materials of N★ (`MonsterModel.as:890`).
- **Graphics:**
  - ResPath = combat SWF `{RES}swf/<ResPath>/<ResPath>.swf` (class `slg.resource.movie.MovieAsset<ResPath>`).
  - ResType = map walking sprite `{RES}swf/npc/<ResType>.bswf`.
  - Icon = `{RES}icon/head_monster…jpg`.
  - Scale = % (setBodyScale(Scale/100)): 50, 70, 80, 90 or 100.
  - Offset = px added to the avatar y (-25…45).
  - DefaultAttack = animation label (Attack01 in 61 rows, Attack02 in 12).
  - DefaultSkill (e.g. 83010001 'Ataque normal do Lobo') is not declared in `MonsterTempInfo.as`; it is server-only.
- **Protocol:** `4574 U_C_MONSTER_DATA_LIST` (`MonsterListMsg` → `MonsterMsg{monsterId, type, star, level, exp, stageLevel, skills, isFight, isFollow…}`), `4575 U_C_MONSTER_USER_DATA` (`MonsterUserMsg`), send `8652 C_MONSTER_CLIENT_OP` (`MonsterClientOpMsg{opType, monsterId, skillId…}`), 5440/5441 (accessory: hammer/surpass), 4576-4580 (Exploration).

### 2.4 Hero and boss AI (`HeroAis`)

- **Role:** 8,080 AI scripts for NPC heroes/bosses (GameHeroTemp.AI) and soldiers (PawnTempInfos.AI).
  - Coverage: every nonzero AI exists in HeroAis (4,362 from heroes, 3,445 from soldiers); 306 IDs are unused; 136 heroes and 104 soldiers have AI = 0.
- **Execution:** the server runs the AI. The client (`HeroAisTemplate.getSkills`, `decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:33`) only collects all skill ids, deduplicated, to preload effects:
  - `BattleResPreloadManager.getPaths` (`decompiled/core_module/scripts/battle/BattleResPreloadManager.as:30`);
  - `CreateGameTransaction.initPawnSkill/getAwakenSkillByAi`, which also reads Soldiers and preloads the AI of summoned troops (`decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:690`).
- **Format:**
  - `Skills` = CSV (with a trailing comma) of SkillTempInfos.TemplateId, in use order, probably cyclic. E.g. boss 'Ibeliz' (AI 1041) = `60141,60141,60144,60141,60145,…`. Most common lengths: 3 (3,416), 4 (1,213), 5 (1,038).
  - `CrazySkill` (2,420 rows): fury/enrage, e.g. 60997 'Fúria'.
  - `BottomSkill` (336) and `BottomSkills` (437): skill and rotation for the 'bottom'/low-HP state *(assumption)*.
  - `AwakenSkill` and `Soldiers` always go together (144 rows): the summon skill spawns `Soldiers = 'pawnId,pos|pawnId,pos'`, with pos on the 1-12 grid (used: 1,2,3,4,5,7,8,9). E.g. Visconde de Shadi = `2071,1|2071,7`.
  - `DeadSkill` and `AngrySkill` are always 0. `LessHpSkill` = 40 in 3 rows.
  - `ChangeSkills` and `ChangeIcon` (transformation; only boss 'Cavaleiro das Chamas Débora', AI 1008: 650493 'Transformação de Monstro' → skills 40212/40213, portrait `boss032a`) are not read by the client; the server sends `HeroMsg.changeSkills` and `is_change`.
- **Resources:** bosses with HeroType = 3 load `{RES}swf/<ResPath>/<ResPath>.swf` and the boss icon; effects are in `{RES}skillEffect/*.swf` (`solveSkillResPath`).

## 3. Combat systems (awakening, Avenger, WarSoul, QTE, damage, resources)

### 3.1 Awakening (Despertamento / Awaken)

- **Role:** the hero transforms into its battle pet. Requires `petRoleInfo`; without a pet, `awaken` is always 0 (`CM/yishi/datas/objects/HeroRoleInfo.as:262-268`). Tooltip `battle.awaken` = "Despertamento".
- **Scale:** 0-3000 (`HeroRoleInfo.as:274`). The bar shows `floor(awaken*100/3000)` % (`M10/battle/view/bottom/SelfAwakenView.as:478`); tooltip "Despertamento: X / 3000" (`:610`).
- **Transform:** `canMorph()` = not in pet form and `awaken == 3000`; `canCancelMorph()` = in pet form and `awaken > 0` (`HeroRoleInfo.as:459-467`).
  - Uses skill **700001 "Transformação"** (SonType 699, CoolDown 2000); undo with **700002 "Cancelar Transformação"** (SonType 700).
  - Space hotkey (`SelfAwakenView.spaceKey`), with a 3000 ms lock between clicks (`SelfAwakenView.as:272-293`). Clicking turns off auto-battle.
- **End of form:** in pet form the bar drains; at 0, `isWaitingChangeBody=true` (the body reverts) and skills are disabled (`BattleAwakenTransaction.as:54-57`).
- **Network:** `4600 U_C_UPDATE_AWAKE` (`AwakeMsg{repeated AwakeInfoMsg awake}`; `AwakeInfoMsg{living_id, awake, childAwake}`), ignored in child battles and battleType 3845 (`CM/battle/transaction/BattleAwakenTransaction.as:37-57`).
  - `AttackOrderMsg` also carries `awake`/`awake_add` (fields 16/17), but the client does not read them.
  - The same `AwakeMsg` is reused in 4589, 4311 and 4752 (Guardian/child: `updateChildAwaken`, max 100; `changeValue` max 3000).
- **Assets:** `asset.battle.AwakenProgress{job}` / `AwakenProgress50{job}`, `AwakenMask{job}`, `battle.PetAwakenEffect`, `battle.awakenImage`, `asset.battle.VesselPoolLineMC`.

### 3.2 Avenger (Vingador)

- **Role:** the Avenger is the 3rd job transfer stage. `isAvenger = vocationIndex >= 3` (`CM/yishi/datas/playerinfo/SimplePlayerInfo.as:1264-1267`); 4 or more is "Santo" (`isHoly`).
  - The "Vingador" window (`AvengerFrame.title.text`) lives in module m5 (`M5/avenger/*`) and has 4 parts: Corpo do Julgamento (Body of Judgment), Habilidades (Skills), Armadura Mítica (Mythic Armor), Espírito de Proteção (Guardian Spirit).
  - Network: `8657 C_AVENGER_CLIENT_OP` (`PlayerOpMsg.op`, see enum `avenger_client_op`); reply `4588 U_C_AVENGER_DATA` (`AvengerMsg{opType, grade, exp, skillDatas, armorGrade, armorExp, holeDatas}`) and `4276 U_C_AVENGER_SPIRIT_DATA`. See `CM/yishi/manager/AvengerManager.as:63-150`.
- **Corpo do Julgamento** (template set `AvengerBodyTemplates`, 221 rows):
  - `BodyGrade` 0 to 220; `BodyType = floor(BodyGrade/11)` gives stages 0-20, each with 11 grades (0-10 stars).
  - Stats per grade: 800×grade in PhyAttack/PhyDefence/MagAttack/MagDefence, 4800×grade in Health. Max: 176,000 each and 1,056,000 HP.
  - The UI shows Attack, Defense, "Resistência" (MagDefence) and HP; MagAttack is not shown (`AvengerBodyTempInfo.as:31-34`).
  - Material: **5010001 "Cristal da Vingança"**, 5 per grade up to a cap of 250. Total from 0 to 220 = 48,875 crystals.
  - The client sends `op 4` with `count` = crystal count (`AvengerBodyView.as:175-188`).
  - Visual effect: `core.avengerEffectzs{min(10,ceil(BodyType/2))}` (`AvengerBodyView.as:243`).
- **Avenger skills** (template set `AvengerSkillTemplates`, 180 rows = 3 classes × 6 skills × 10 levels):
  - `SkillSonType = 500 + JobType×10 + idx`. Indices 1-3 are Main (MasterType 500, Cost 50 = 5 slots): "Ataque de meteoro", "Raio explosivo", "Esmagamento total". Indices 4-6 are Secondary (MasterType 501, Cost 20 = 2 slots): "Canhão psíquico", "Rito sagrado", "Corte sônico".
  - E.g. Ataque de meteoro lv1 = 340% damage to 2-4 enemies + 2-turn Stun; lv10 damage 475%.
  - **Evolution N→N+1:**
    1. Hand in the 6 "Pedra de Julgamento" materials, one at a time (`op 2`, button "Elevar"). Quantities are 10, 15 or 20; the stone quality rises basic → intermediate → advanced → special.
    2. Have `BodyGrade >= NeedBodyGrade` (33, 55, ..., 209).
    3. Send `op 3` (`M5/avenger/AvengerSkillEvolveFrame.as:140-152`).
  - `AvengerSkillTemplates.JobType` (1 Warrior, 2 Archer, 3 Sorcerer) exists only in the XML.
- **Armadura Mítica** (template set `AvengerHoleTemplates`, type 1, levels 1-20):
  - Mythic Holes are carved with **6920001 "Pedra de esculpir"**: 50 stones for level 1, 4850 for 19→20; total 37,050.
  - Stats: 1800×level in attacks and defenses, 10,800×level in HP.
  - A Mythic Orb fits only if its level ≤ the hole's level. Limits: at most 2 orbs with the same `Property2` and 1 with the same `Property3` (`CM/mvc/module/avenger/AvengerModel.as:95-180`).
  - Assets: `common/asset/baseItem/avengerPearlGradeImage1..20`.
- **Avenger SP in battle:**
  - 0 to **70** (`HeroRoleInfo.as:93`), updated by `4589 U_C_UPDATE_AVENGER_SP` (`AwakeMsg`, same layout; `BattleAvengerSpTransaction.as:36-56`). Ignored in monster battles, child battles and battleType 3845.
  - Display: `floor(sp/10)` bitmap "slots" (`asset.SelfAvengerView.numBmd`) and a 182 px bar (`CM/battle/view/ui/AvengerBattleSkillView.as:334-337`). The tooltip uses `SkillTips.avengerCost` ("Gasto de slot de Vingança").
  - A skill is enabled only if `avengerSp >= Cost`.
  - The panel shows if `heroInfo.isAvenger` and there are skills in the formation (`M10/battle/view/bottom/BottomBar.as:102-110`).
- **Skill swap in battle:** `4591 U_C_UPDATE_AVENGER_SKILL` (`AvengerBattleSkillMsg{avengerLeftCd, avengerSkills, avengerAllSkills}`).
  - The packet sets the formation skills, all skills and the remaining CD in seconds (`BattleAvengerSkillChangeTransaction.as:23-26`).
  - Reserve skills (`getWaitSkillIds`) open with key **M** or the button. Swapping fires `AVENGER_SKILL_REPLACE`, blocked while `avengerWaitSec > 0` (`AvengerBattleSkillView.as:254-320`).
  - "Olhos da Verdade" (Eyes of Truth) alter this CD (`AvengerEyeView.curDescText.text`).

### 3.3 War Spirit (Theseus): `WarSoul`

- **Role:** Theseus-system equipment. 54 templates: 9 elements (SonType) × 6 qualities (Profile).
  - **Elements and types** (MainType): Natural = Água/Choque/Marinha; Polar = Fogo/Luz/Terra; Espectral = Vento/Escuridão/Celeste. Advantage: Natural>Polar>Espectral>Natural (`theseus.war.helpTip`).
  - **Rank:** 1 Superior, 2 Intermediário, 3 Inferior.
  - **Slots:** 9 equipment slots (`theseus.war.equipCell1..9`), unlocked by Royalty level via `RoyaltyTemplates.OpenWarSoul`: level 10 → 3 slots, 15 → 6, 20 → 9 (`M5/theseus/war/mediator/TheseusInsfBagCellClickMediator.as:69-73`).
  - **Primary/Secondary:** one MainType is chosen as Primary (`op 19`). The Primary gives attributes + an active skill + 2 passives; Secondaries give attributes only (`theseus.war.fightTip`).
  - **Network:** `8680 C_THESEUS_CLIENT_OP` (`doWarsoulParam`); replies 4306/4307 `WarSoulListMsg{op, warSouls, fightIdx}` and 4310 `WarSoulRefreshMsg` (`CM/managers/TheseussoulManager.as:223-227,746-781`).
  - **WarSoulMsg:** id, warSoulId, star, strengthen, reform, learnSkill, ramdomSkills, reformBuff, isEquip, isExist, count, newLearnSkill, isLock.
- **Attributes:** `shown = Base×Star%/100 + Fort×Star%/100 + Reform` (`M16/yishi/view/tips/TheseusWarsoulEquipTip.as:225-252`).
  - Base per Profile: Atk/Def/MAtk/MDef = 5×P; Life = 40×P.
  - Star percentages rise only for Attack, Magic Attack and HP. At ★20: 403% and 526%.
- **Stars** (template set `WarSoulStarTmpls`):
  - Max star per Profile: 5/10/11/13/16/20.
  - Cost: **7620150 "Antique de Espírito da Guerra"**. Red: 650 to 169,000 per star; several stars can be raised at once (`op 11`).
  - Each star also sets the Strengthen cap (`MaxGrade` = 15×★), the Reform cap (`MaxReform`, up to 6) and the number of Polish attributes (`MaxClear`, up to 5).
- **Strengthen** (template set `WarSoulStrengthenTmpls`, 10,179 rows):
  - Each +1 costs **7620100 "Pedra de Fort. da Guerra"** (`op 12`). On decompose, `DecompositionReturn` returns the total spent.
  - Active and passive skills level up at +76, +151, +166, +196 and +241.
  - The active skill costs 100 Fury (e.g. 76001101).
- **Reform** (template set `WarSoulReformTmpls`; the same data for every spirit):
  - Levels 0-6: Não reformado, Normal, Avançado, Requintado, Magnífico, Perfeito, Celestial.
  - Each attempt results in success (+1), unchanged, or failure (−1).
  - Probabilities (success/unchanged/failure): 0→1 100/0/0; 1 5/95/0; 2 4/66/30; 3 3/47/50; 4 2/28/70; 5 1/9/90; 6 0/5/95.
  - Each Reform Stone (7620301-3, `Property2` = 5) converts 5 p.p. of failure into "unchanged".
  - Reform gives no fixed stats (all 0). It generates `reformBuff`, the "Termos da Intenção de Guerra" (War Intent terms):
    - format `"part,value|..."`; `part` maps via `[1,3,4,5,2,6,9,10,11,12,7,8]` to `theseus.equip.part0..9` (Weapon, Clothes, Shield, ...);
    - max term count = `MaxWarpath` (2-12); each term level ranges from `MinRageGrades` to `MaxRageGrades` (1-5).
- **Polish:**
  - Cost `ClearItem`: 7620200 "Pedra de Purificação da Guerra" ×10×Profile (`op 15`, with per-attribute locks; accept = `op 17`).
  - Roll pool: `SkillTempInfos.MasterType == ClearSkill` (76401-76406). E.g. 76411001 "Aumento do Ataque".
- **Other systems:** Hatching (Eclosão; ops 7/8/9, msgs 4308/4309) and Trigger Skill (Habilidade Gatilho; book with `Item.Property2 == Rank`; ops 14/20).
- **Spirit Fury in battle:**
  - `4311 U_C_WARSOUL_SP` (`AwakeMsg`) → `updateWarsoulSp`, 0-100 (`HeroRoleInfo.as:248-259`; `BattleWarsoulSpTransaction.as:48-57`). Ignored in monster battles, child battles and 3845.
  - Fury accumulates per turn; at 100 the player can use the Primary's active skill (`theseus.war.skUpTip` item 5).
  - UI `SkillWarsoulView` (`VersionSwitch.WARSOUL`): bar `asset.battle.warsoul.spBar` with width `sp/100` (`CM/battle/view/ui/SkillWarsoulView.as:129`); the skill is enabled if `warsoulSp >= Cost`.

### 3.4 War Tower (Torre da Guerra): `WarSoulTower`

- **Role:** a 500-floor tower (`warSoulTowerFrame.titleText` "Torre da Guerra"), opened at Royalty lv10 (`RoyaltyTemplates.OpenWarSoulTower`).
  - Rules (`warSoulTowerFrame.helperFrame.helpTxt.text`): 1 challenge per day, reset at 0:00. After the reset, the challenge restarts from the first 5 stages of the record.
  - New floors give the "Prêmio de 1ª passagem" (first clear); cleared floors give the "Prêmio de Repetição" (repeat). Every 10 floors there is a "Prêmio de Estágio" (`WarSoulTowerStageRewardTemplates`, 50 rows).
  - Quitting a battle blocks re-entry for the same day (`battleUIView.warsoulTower.content.txt`).
- **Composition** (verified in Python):
  - `Heroes` = `"8100NNN,5"`: a boss from `GameHeroTemp` (all level 80; e.g. Shatar, Kurdish, Nefer, Krands) at position 5.
  - `Pawns` = 4 `"id,pos"` entries from `PawnTempInfos` (2000 ids; e.g. "Cavaleiro do Julgamento", "Lanceiro Sangrento") at positions 1, 3, 7 and 9.
- **NeedArmourValue:** the Theseus "Armor Value" (`TheseusPropertys.armour`).
  - Every boss has `BossSkill` **84101001**: "Não alcançou o valor da armadura: redução de 90% no dano" ("Diminui dano recebido em 90%, não pode ser dispersado"), i.e. below the armor value, the damage dealt is cut by 90%.
  - Values: 432 at floor 1, 3,024 at 10, 6,840 at 100, 23,544 at 500.
  - The frame shows the value and the BossSkills descriptions (`M11/warsoultower/WarSoulTowerFrame.as:318-333`).
- **Rewards:**
  - First clear: 7620100 ×10→255 + 7620401 ×10→48.
  - Repeat: 7620100 ×5→104 + 7620401 (odd floors) or 7620301 (even).
  - Stage: 7620301 ×10→110 + 7620100 ×100→500.
- **Network:** `9709 C_WAR_SOUL_TOWER_CLIENT_OP` (`PropertyMsg.param1`: 0 = open, 1 = fight); `530 U_C_WAR_SOUL_TOWER` (`WarSoulTowerRspMsg{currentLevel, highestLevel, challengeTimes}`); `531 U_C_WAR_SOUL_TOWER_RESULT` (`ResultRspMsg{isNewRecord, highestUnLockLevel, startLevel, endLevel, rewards[RewardRspMsg{level, state}]}`). See `CM/yishi/manager/WarSoulTowerManager.as:54-95`.
- **UI:** 15 floors visible in a zigzag (`WarSoulTowerFrame.as:245-252`); background `asset.warSoulTowerFrame.bg`.

### 3.5 QTE

1. The client sends 10008 (`UseSkillMsg`).
2. The server replies `75 U_B_HERO_ORDER` (`HeroOrderMsg{battle_id, hero_index_id, skill_id, result, cast_time, qte_time, targetIndexs}`).
3. With `result == 0` and no auto-battle, `qteTime = SkillTempInfo.QTETime` (`CM/battle/view/ui/SkillItemListController.as:918-936`).
4. If `qteTime > 0` and the hero is not boss-controlled, `QteView` opens (`M10/battle/view/ui/BattleUIView.as:1886-1895`):
   - `floor(QTETime/1500)` random keys from "ASDW"; arrows count as A/W/D/S (`CM/simplegame/qte/QTEComponent.as:25,85,112-131`);
   - a mistake restarts the sequence;
   - the deadline is `QTETime − 400` ms;
   - on success, the client sends `10015 U_B_QTE` (`QteMsg{battle_id, server_name}`) after 400 ms and plays `asset.qte.QTESuccess`.

- **QTE never occurs in BR data:** `QTETime = 0` in all 22,716 `SkillTempInfos` rows. `QteSkillGuide` guides exist but stay inactive.

### 3.6 Damage: `bloodType`, critical, parry, resistance and stun

- **Value source:** `DamageMsg` = living_id, damage_type (→bloodType), has_icon, is_harmful, damage_value (int64), left_value, extra_data, parry, dropInfos, order, hp_limit, resi_type, resi_value, resi_percent, buffer_type. Read in `CM/battle/utils/BattleFunctionHelper.as:188-206`.
- **bloodType** (`CM/battle/data/BloodType.as:6-22`): 6 HP, 7 troop, 8 third, 9 SP, 10 revive, **11 UNENABLE_SKILL** (declared, unused; missing from [docs/battle/README.md](../../docs/battle/README.md)), 21 max HP, 24 HitPoint, 26 belief.
  - 6 and 21 change bloodA; 7 changes bloodB (≥0); 10 revives (`RoleInfo.as:346-378`).
  - 9, 24 and 26 from a buffer add to sp, hitPoint and belief (`CM/battle/handler/BufferHandler.as:74-104`).
  - Only 6 and 7 count toward the combo (`batterCount`) (`DannyAction.as:165`).
- **Critical:** `extraData & 1` (`DannyAction.as:140`). Uses the animation `asset.battle.BloodUpdateRage` (`CriticalDamage`); the number rises +50 px, the screen shake is stronger (4×24) and a red tint applies if you are the victim (`RoleViewBase.as:1066-1131`). No other bits are tested.
- **Parry:** `DamageMsg.parry` → `asset.battle.ParryAsset` + style `SelfCause`/`Red` (`DamageNumView.as:62-79`).
- **Fire:** buffer AttackType 316 → `asset.battle.fireImg`.
- **Number colors:** heal green (`GreenNumberAssetSp`); damage you deal `DamageNumberAssetSp`; damage taken `RedNumberAssetSp`.
- **Resistance:** `resiPercent` feeds `ResistUIView` (`asset.battle.DamageUIAsset`; green if >0, red if <0), only when your own hero is the attacker or the target (`BaseSkill.as:775-791`; `ResistModel.as`). `resi_type` and `resi_value` are read but not shown.
- **Stun:** a buffer with `SkillBufferTempInfos.AttackType == 19` ("Atordoamento", "Congelamento", "Vertigens"; 57 buffers) puts RoleInfo in `restricted` and fires `restrictChanged`; the state clears when the last type-19 buffer ends (`RoleInfo.as:402-425, 816-824`). There is also `AttackType 101` "Atordoamento" (91 buffers), with no special client handling.

### 3.7 Fury (SP)

- **Role:** the main hero skill resource (`SelfSpView`). Tooltip "Fúria: Utilização de habilidades consome fúria".
- **Scale:** `spMax` defaults to 100 and may come from `HeroMsg.spMax` (`SocketGameReader.as:287-291`).
- **Updates:**
  - `AttackOrderMsg.sp` / `sp_added`, stored in `SkillData.sp` / `spAdded` (`BattleFunctionHelper.as:172-173`);
  - bloodType 9 in buffer damage;
  - buffers with AttackType 6 ("Ganho de 10 pontos de fúria por ação").
- **Cost:** a skill is unavailable if `sp + Cost < 0`; `Cost` is negative in the template and is added (`SkillItemListView.as:660`).
- **Display:** `asset.battle.AngerPoolBallMC` (`VesselBallComp`) + `asset.battle.VesselPoolLineMC`.
- **Separate Fury bars:** Avenger (0-70) and War Spirit (0-100), described above.

### 3.8 HitPoint (Pontos de ATQ)

- **Role:** an extra resource only for the **Mestre do Dragão** (Dragon Talker; `heroInfo.dragonTalkerInfo.isDragonTalker`). `SelfHitPointView` is added only in that case (`M10/battle/view/bottom/BottomBar.as:93-97`).
  - Tooltip: "Pontos de ATQ: Parte da Habilidade do Dragão necessita consumir pontos de luta."
- **Scale:** 0..`hitPointMax` (default 5, or `HeroMsg.hitPointMax`); `updateHitPoint` clamps the value (`HeroRoleInfo.as:204-214`).
- **Display:** `asset.battle.HitPointMC`, at frame `hitPoint + 1` (`SelfHitPointView.as:61`).
- **Updates:** `AttackOrderMsg.hitPoint` (field 19) and bloodType 24.
- **Cost:** a skill requires `hitPoint + HitPointCost >= 0` (`SkillTempInfos.HitPointCost`; `SkillItemListView.as:660`, `HeroRoleView.as:568`).

## 4. Stars, talents, runes, magic cards and potential

### 4.1 Stars and cosmos (Astrologia, Astrology): `starTempInfos`

- **Role:** the "Astrologia" system (`star.StarFrame.titleText`). 82 templates.
  - The player spends gold on 5 crystals ("Estrela Angelical/Mística/Espiritual/Divina/de Deus", `star.view.MakeStarView.*`) to roll **cosmos** (stars) into the temporary bag (StarBagType 0).
  - The player then **harvests** them (bag 1, 12+starBagCount slots) or **sells** them (SellGold).
  - Cosmos equipped on the hero (bag 2) give attributes; absorbing a cosmo into another gives EXP (gp).
- **MasterType** (20 values):
  - 1 Leadership, 2 Attack, 3 Defense, 4 Magic Attack, 5 Magic Defense, 6 Critical, 7 Life, 15 Block (attribute ×level);
  - 8-14, 16: **buffer** cosmos (DefaultSkill → SkillBufferTempInfos, e.g. 80901 "10% probabilidade causando {ValuePercent}% de reflexão");
  - 17-19: **advanced** (Attack/Magic/Critical + Penetration, level 60, slots 8-9 only);
  - 100: junk/energy.
  - Rule: two cosmos of the same MasterType cannot be equipped (`StarManager.as:755`, "Não é possível equipar cosmos de mesmo atributo").
- **Profile** = color: 1 white (junk), 2 green, 3 blue, 4 purple, 5 orange, 6 energy (not equippable), 7 red "Divino", 8 "Sagrado". Colors: `StarHelper.as:334`.
  - EXP table per Profile → `UpGradeTempInfos.Types` 9/10/11/12/13/22 (`StarHelper.as:50`), 10 levels; e.g. green 0,50,200,600,…,38400; red up to 737280.
- **Real values per level:** green 72 (Life 200), blue 108, purple 144, orange 216, red 288 (Life 750), Sagrado 2880 (Life 7500); Leadership 18/24/36/48. Advanced: 144/216 Attack+Penetration, Sagrado 2160+2160.
- **Shown attribute** = base×grade + int(base×grade×troughGrade%) (`StarTip.as:98`). The slot is refinable with gold ("Refinação do Cosmo", `8772 C_STAR_ADDITION` ×1/×10).
- **Slots:** min(level/10, 8) + slot 8 (quest 1802 "Mestre de Cosmos" and Lv60) + slot 9 (quest 1802 + job transfer) (`StarManager.as:732`).
- **Cosmos Elevation (Sagrado):** a red cosmo (Profile 7) at Lv10 (except 107 Divino·Leão) or one with Profile≥8 goes to the SUBLIME bag 3 and consumes "Pó da Ilusão" (`5182 C_STAR_SUB_OP` / StarGrowOpMsg) (`StarManager.as:692`).
- **Cosmos composition:** ComposeTempInfos Types=14 (Material1→NewMaterial).
- **StarPoint:** price in the "Resgatar Pontos" shop, paid with Astrology Points (`8341 C_STARSHOP_BUY`).
- **SellGp:** base EXP given when the cosmo is absorbed.
- **Opcodes (send):** `8269 C_STAR_RAND` (StarRandReqMsg.site), `8268 C_STAR_PICK`, `8267 C_STAR_MOVE` (StarMoveReqMsg begin/end type+pos, eat=absorb), `8270 C_STAR_BUY`, `8331 C_STAR_COMPOSE`, `8330 C_STAR_LOCK`, `8325 C_STAR_DATA_RESET`, `8876 C_STAR_SPECIAL` (StarVipEventMsg: VIP auto-astrology), `8772 C_STAR_ADDITION`, `5182 C_STAR_SUB_OP`.
- **Opcodes (reply):** `4178 U_C_START_MOVE_UPDATE`, `4179 U_C_STAR_PICK`, `4180 U_C_STAR_RAND`, `4479 U_C_STAR_COMPOSE`, `4677 U_C_STAR_ADDITION`, `4261 U_C_STARSHOP_BUY`. Protos: StarInfoMsg, StarRandMsg/StarRandRspMsg, StarMoveReqMsg, StarGrowOpMsg, StarAdditionMsg.
- **Code:** `yishi/manager/StarManager.as`, `yishi/utils/StarHelper.as`, `mvc/module/star/*`, `cell/view/starbag/StarBagCell.as`, module m5 `star/*` (HoroscopeFrame, SubStarFrame, EnhancedAttributeFrame), shop m15 `view/subshop/StarShopFrame.as`. Resources: `/star/<TemplateId>.swf`.
- Not to be confused with **Astronomia** (StarGazingManager, StargazingDrop, `5188 C_STARGAZING_OP`; 12 signs) or **StarArea** (StarAreaRoadInfos).

### 4.2 Talents: `TalentEffectTempInfos` (6932 rows)

- **Role:** skill modifiers granted by the **hero talent tree** (`TalentData`: talentPoint/talentGrade, advanced talents advTalentPoint; skills MasterType job×10, 70 after job transfer, 40-60/80 advanced; `TalentData.as:42,113`).
  - Learning: HeroAddPointReqMsg via 5185; talent level-up: `5187 C_TALENT_GRADE_UP` (TalentUpGradeMsg); replies `4430 U_C_TALENT_GRADE_UP` / `4431 U_C_TALENT_INFO`.
  - Also used by Theseus buffers, monsters/accessories (9154xxx), War Spirit (760xxx) and mounts.
- **Chain:** talent skill → `SkillTempInfos.BufferIds` → `SkillBufferTempInfos.TalentEffIds` (3586 buffers) → effect (`SkillTempInfo.as:270`). Active buffers are also read in battle (`:321`).
- **Filter:** a row applies if EffSkillType == -1 (863 rows) or == the skill's SonType (e.g. 511-536 = 280 rows each); 1/850001 = buffer target skill.
- **Effects:**
  - Cost (Fury, negative = consumption) += Cost×ΣEffSpPercent% + ΣEffSpValue;
  - CoolDown (ms) += CD×ΣEffCdPercent% + ΣEffCdValue, truncated to seconds (`:213`);
  - Parameter1/2 (damage %) ×(1+ΣEffDamPercent%);
  - EffAttackObject changes the target;
  - EffBuffPercent/Value, EffRand*, EffCount* change AttackValue/ValuePercent, Random and ValidCount of the buffer EffBufferType (`MonsterModel.as:777`);
  - EffCriValue (critical), EffCt* (cast time), EffIsActive: unused on the client (server-side).
- **Real examples:** 1 (SonType 303 Maldição) EffSpValue +20 → cost −25 becomes −5; 200301 (215 Penetração) CD −5000 ms and critical +5; 310501-310510 Relâmpagos: consumption +2..+20 and damage +3..+30%; 2000: CD −100%.

### 4.3 Runes (rune skills): `RuneTempInfos` (132)

- **Role:** 10 extra hero combat skills ("Runa", tab in SkillFrame, opens at Lv35/40).
  - Each rune is tied to a skill `SkillTemplateId` (SonType 9001-9010, CD 75 s; advanced 45 s) with `UseCount` uses per battle.
  - Learned by consuming the type's "Pedra Rúnica" (items SonType 302, 3020001-3020013; RUNE_STUDY).
  - Leveled by absorbing rune stones (EXP = NeedGp; daily cap of 100 stones per rune).
- **RuneType:** 1 Raiva (Fury +30..+80), 2 Fúria/Crítico, 3 Proteção, 4 Dispersão, 5 Purificação, 6 Confusão, 7 Oblívio, 8 Sangramento, 9 Restauração, 10 Desaceleração (`army.stone.otN`).
- **Level 0** = basic: 10 grades, NeedGrade 35→80 (hero level).
- **Level 1** = advanced (only 2,3,8,9): 8 grades, NeedGrade 1→71 (job level); activated with "Pedras rúnicas" 3021001 via RUNE_PROMOT.
- **Total EXP to max:** Raiva/Confusão/Oblívio 1,000,000; Proteção/Dispersão/Purificação 600,000; Sangramento/Restauração/Desaceleração 300,000; Fúria 50,000.
- **RuneOperationCode** (HeroRuneOpMsg.opType, `8605 U_C_HERO_RUNE_OP`): 1 study, 2 upgrade, 3 remove, 4 promote, 5 activate holes, 6 carve holes, 7 replace set. `4527 U_C_RUNE_RESET` zeroes the daily swallowCount.
- **Code:** `managers/ArmySocketOutManager.as:120-237`, `mvc/module/armyII/RuneInfo.as`, `yishi/manager/ArmyManager.as:590`, m5 `armyII/viewII/rune/*`, tip m16 `RuneTips.as`. Icons `/rune_<type>[ex].png`.

### 4.4 Rune gems, holes and set effects: `RuneGemInfos` (375), `RuneHoleInfos` (133), `RuneFsgainInfos` (179)

- **Gems** (items "Runa de Força Branca"…, MasterType 2, SonType 1011-1015):
  - rolled at the "Templo de Runas" (`9724 C_LOTTERY_RUNE`, rune energy up to 100);
  - decomposed into fragments (`9720 C_RUNE_RESOLVE`);
  - strengthened (`9721 C_RUNE_UP`, RuneStoneUpReqMsg);
  - socketed (`9719 C_EQUIP_RUNE_STOME`, RuneMosReqMsg);
  - removed (`9722 C_RUNE_UNLOAD`).
  - RuneGemInfos key = Types_RuneGemTypes_Grades (`RuneGemTempInfoCate`): Types = quality (1011 white Lv1-5 … 1015 orange Lv1-25), RuneGemTypes = shape (1 Força, 2 Proteção, 3 Inteligência, 4 Físico, 5 Liderança). E.g. white Força 16→48, orange 40→520; orange Liderança 20→260.
- **Holes:** a Lv10 rune unlocks "Escultura de slot de runa" (opType 5/6/7), which rolls sets from `RuneHoleInfos` (Length 1-4, Hole1-4 = required shape; 0 = no hole). String `runeHole = 'ids|shapes'`. A gem fits only a hole of the same shape.
- **Set effects** (GainEffectID1/2 → `RuneFsgainInfos`):
  - Activate when gems of shape `Condition` (1-4; 99 = all) have level ≥ ConditionParam (7…50).
  - Give AttributeType (6 Phys Atk, 7 Phys Def, 8 Mag Atk, 9 Mag Def, 10 Life, 11 Infantaria) as a fixed value (ValueType 0: 360…16200) or as a % of a base attribute (ValueType 1 '2,35' = Proteção×35%), optionally only for the listed RuneTypes ('1,2', '3,4'…).
  - Texts `army.stone.*` (`RuneStoneGroupContent.as:166-230`). Icons `/runegem_<quality><shape>.png`.

### 4.5 Magic cards (Carta Mágica): `MagicCardTempInfos` (180 = 20 cards × 9 levels)

- **Role:** the "Carta Mágica" panel (m5 `magicCard/*`, `MagicCardManager`).
- **Series (Types):** 1 Tau, 2 Imortal, 3 Luz, 4 Trevas, 5 Arma Antiga. Each series applies in one mode (ActiveScene = Types): 1 Campanha Multiplayer, 2 Labirinto, 3 Arena, 4 Campo de Batalha, 5 Torre do Julgamento (`magicCard.view.cardDscTxtN`).
- **Cards:** 4 per series (Pos 1-4 = Profile 1-4); each level gives the passive skill `SkillTempIds` (e.g. 40301101 "Diminui 6% do dano recebido" → Lv9 30%; 40305409 "Cada ataque recupera 10% de vida máxima").
- **Activation:** item `ActiveNeedTempId` (6000001-6000026, SonType 600, "Ao usar, obterá Carta …").
- **Level:** magic dust `NeedMagicDust` = Profile×[0,50,100,150,200,250,300,400,500] (total 1950/3900/5850/7800). Decomposing cards yields dust.
- **Opcodes:** `9505 C_POWCARD_REQ` (PowCardReqMsg op 1 upgrade, 2 activate, 3 decompose), `4905 U_C_POWCARD_ALL` (MagicCardInfoListMsg), `4903 U_C_POWCARD_BUF_ON` (PowCardBufListMsg), `4902 U_C_POWCARD_Fight_ADD` (PowcardFightAddMsg campType 800-807).
- **Code notes:** `MagicCardSuiteTemplateInfo` exists but is never loaded (dead code). Icons `/card_tauren0N`, `/card_skeleton0N`, `/card_light0N`, `/card_dark0N`, `/card_old0N`.

### 4.6 Potential (Potencialidades, Proficiency): `ProficiencyTemplates` (700)

- **Role:** "Potencialidades" (toolbar button, hotkey E).
- **Access:** requires royaltyLevel>0, job transfer and the switch THESESOUL (`MainToolCheckBtnOpen.as:70`); access via SwitchPageHelp.openPotential requires Avenger.
- **Points:** the player accumulates **Potential points** with pills (items SonType 627: Potencial Básico 100 / Intermediário 500 / Avançado 1000; `ProficiencyExchangeFrame.as:92`) and "practices" to level up (Grade 0-699) if points ≥ the next level's Exp.
- **Hero attributes** *(assumption: applied to the hero/thane)*: Attack/Phys. Def./Mag. Def. 100×Grade, Life 600×Grade (max 69900/419400).
- **Layer** = 7-star stage (floor(Grade/7)+1, 1-100; `ProficiencyGradeMcView.as:36`). Total cost 3,500,990 points.
- **Opcodes:** `8660 C_PROFICIENCY_CLIENT_OP` (PlayerOpMsg op 0 info, 1 exchange pills, 2 practice), `210 U_C_PROFICIENCY_DATA` (PropertyMsg param1=grade, param2=points).
- **Code:** `yishi/manager/ProficiencyManager.as`, `mvc/module/proficiency/ProficiencyModel.as`, m5 `proficiency/*`. Not to be confused with DragonTalkerProficiency or VehicleProficiencyTempInfo.

## 5. Stelae, slates, Auto Chess and Theseus

### 5.1 Stelae (Estela; Stela / 石碑): `StelaTemplates`, `StelaStepTemplates`, `StelaPropertyTemplates`, `StelaResistTemplates`

- **Role:** equippable character "cards" (window "Estela", module `decompiled/m14/scripts/stelesys/*`, model `decompiled/core_module/scripts/mvc/module/stele/StelesysInfo.as` / `StelesysModel.as`, network `decompiled/core_module/scripts/managers/SteleSysManager.as`).
- **Positions:** 1..10 = equipped (`StelesysInfo.as:123`). The **Central Stela(e)** activate the passive skill `PassiveSkills` (the exact central position is not verified); the rest are auxiliaries unlocked by level after job consecration. Two Stelae with the same name cannot be equipped (`stela.equip.same`).
- **Real data:** 28 templates: 27 equippable (1101..1603; 3×1★, 3×2★, 6×3★, 6×4★, 6×5★, 3×6★; e.g. "Armadura Leve Nobre" 1★, "Anel Glorioso" 6★) + 2101 "Estela de fortalecimento - Verde" (MasterType 2, Exp 1, material only). 396 grade rows, 3750 level rows, 366 resistance rows.
- **Strengthen (level):**
  - Consumes other Stelae as material; each gives `StelaTemplates.Exp` (10/20/…/60 by rarity) + the EXP already invested in it (`StelesysModel.as:429-508`).
  - `StelaPropertyTemplates.Exp` is **cumulative** and identical for all Stelae (Lv1 35, Lv2 74, … Lv150 ≈10.7k, Lv300 54424).
  - Level attributes are linear: Atk=Def=MAtk=MDef = base×level (base 72/84/96/108/120/120 per ★), Life = 6×.
  - Level cap = `StrengthLimit` of the current grade (5,10,15,20,25,30,35,45,55,…,300).
- **Ascension (grade / Step):**
  - `StepLimit` 2/6/10/15/20/25.
  - Going to grade N consumes `CostNum` copies **of the same Stela** (`CostItem` = StelaId) that are exactly at grade `CostItemStep` (0, 3, 7 or 11) (`StelesysModel.getSomeStepAndId`, `StelesysModel.as:106`; UI `SteleSysAdvanceView.as:357`).
  - Each grade adds fixed attributes (e.g. 1601 grade 25: Atk 12120, Life 72720) and changes the color (`Profile` 1 white…6 red, `stela.check.step0..5`).
- **Resistance:** every 10 strengthen levels, one `StelaResistTemplates` row (skill 14{★}00NN) adds +100 Resistance Penetration and +100 Anti-Resistance (`StelesysInfo.as:99-118`). E.g. 6★ Lv300 = +3000/+3000.
- **Purification (Baptize):**
  - Consumes `BaptizeCostNum` × 7110001 "Pedra de Purificação da Estela" (5…180) and rolls up to `BaptizeLimit` lines (2,2,3,4,5,5 per Profile) from the pool `SkillMasterType` (13100…13600 in SkillTempInfos, "Ataque +50 (1 estrela)" … "+3500 (35 estrelas)").
  - Lines can be locked with 7110002 (`SteleSysRefineView.as:131,326`).
  - The result arrives in `StelaRefreshMsg` (skills) and becomes skill1..skill5 (`StelaDataMsg`).
- **Rollback:** a rollback stone returns the Stela to Lv0 and refunds the strengthening Stelae (text `stela.helpFrame.content`).
- **Total formula:** `StelesysInfo.updateStelaAttInfo()` (`StelesysInfo.as:266`) = PropertyTemplate(level) + StepTemplate(grade) + resistances + purification skills.
- **Network:** send `8664 C_STELA_CLIETN_OP` (equip, strengthen, ascend, purify, replace, recycle; `SteleSysManager.as:133-192`) and `8665 C_STELA_BOX`; receive `4279 U_C_STELA_DATA` / `4280 U_C_STELA_UPDATE` (`StelaMsg{opType,datas[StelaDataMsg{id,templateId,pos,step,level,exp,totalExp,skill1..5,isExist}]}`) and `4281 U_C_STELA_REFRESH` (`StelaRefreshMsg`). Icons `stela_{id}.png`.

### 5.2 Divine slates (Placa divina; Slate / 石板 / Theseus "Divino"): `SlateTmpls`, `SlateUpgradeTmpls`, `SlateTaskTmpls`

- **Role:** a Theseus subsystem ("Placa divina", `TheseusGodheadFrame.title1 = Divino`; UI `decompiled/m5/scripts/theseusgodhead/*`, model `TheseusGodheadModel.as` / `TheseusGodheadStoneInfo.as`, manager `TheseussoulManager.as:311-438`).
  - A 25-cell board (equipPos 0..24; sealed positions are opened with 30000001 "Chave de Teseus") holds Tetris-like pieces; the backpack holds 25.
- **Real data:** 144 templates = 24 names × 6 stars (0..5, `TemplateId%10`). Type = cell count:
  - 4 slots (T/S/L shapes, e.g. "Placa de corte", skill "Finalização" 432%→620% damage to targets <20% life);
  - 3 slots ("Placa de combo", "Placa de dano ampliado"…);
  - 2 slots ("Placa de ferimento grave", "Placa de regeneração");
  - 1 slot (8 attribute-only slates: attack, defense, magic, resistance, critical, penetration, block, life).
  - Quality 3 blue (48), 4 purple (72), 5 orange (24).
- **Attributes:** `SlateAttr` (base by star) + level × `SlateLvAttr`; codes 1 Attack, 2 Defense, 3 Magic, 4 Resistance, 5 Critical, 6 Penetration, 7 Block, 8 Life (`TheseusGodheadModel.parseSlateAttributes`, `TheseusGodheadModel.as:485`). Data bug: "Placa de resistência" raises Magic (LvAttr 3) instead of Resistance.
- **Upgrade:** max level = star×10+10 (`TheseusGodheadStoneInfo.as:194`). Cost `SlateUpgradeTmpls[quality, level+1, type]`: dust 30000000 ("Poeira de placa") 50…3900 + gold `Consume` = 1000×dust (`TheseusGodheadUpgradeView.as:261-278`). 6 tables (q3t1, q4t2, q4t3, q5t3, q4t4, q5t4) × 60 levels.
- **Promotion (star):** ComposeTempInfos `Types=370`: slate + 1 identical copy + dust (4500, 7500, 10500…), requiring max level (NeedMinLevel 10,20,30…) (`TheseusGodheadStoneInfo.as:197-230`).
- **Decomposition:** dust = `SlateDecomposition` + 90% of the dust spent on upgrades (`GodItemSellView.as:245-275`). Locked slates do not decompose.
- **Quests:** 16 `SlateTaskTmpls` ("Fortalecer 2 placas de 3 slots até o Nv.40"); condition: count of slates with level ≥ Part1 and SlateType ≥ Part3 ≥ Part2; reward 1 Chave de Teseus; state 0/1/2 (`TheseusSlateTaskInfo.as:29`).
- **Network:**
  - Send 9762 (not listed in opcodes.csv) with `PlayerOpMsg.op`: 1 query, 2 unlock position, 3 upgrade, 4 promote, 5 decompose (ids), 6 rotate, 7 lock, 8 claim quest, 9/10/11 move (board/grid/backpack) (`TheseussoulManager.as:1034-1131`).
  - Receive `1024 U_C_SLATE_USER_DATA` → `UserSlateMsg{opType,posMark,tasks[SlateTaskMsg],property[SlatePropertyMsg],slates[SlateMsg{id,templateId,pos,grade,star,rotate,equipPos,isLock,isExist,count}]}`.
  - Resources: `/slate1..7.png`, `/slatefragment.png`, shape icons `石板_*.png`.

### 5.3 Auto Chess (Supremacia do Legend / SelfChess): `AutoChessHeroInfos`, `AutoChessBuffInfos`

- **Role:** a room-based PvP auto-battler (`SelfChessPlayerMsg{hp,gold,grade,exp,winCount,lock,battleAry,alternateAry,cardPool,rank}`), UI `decompiled/m3/scripts/chess/*`, model `decompiled/core_module/scripts/mvc/module/chess/SelfChessModel.as`, battle `SelfChessRoleView.as`.
  - Players buy heroes with match gold and place them on the battle line; the winner loses no life and the loser loses life according to the winner's remaining pieces (`sevenyear.selfchess.helpContent`). At the end, warrior points are awarded by placement.
- **Heroes:** 112 rows = 31 heroes × 3 stars + 19 PvE monsters ("Apolo (monstro)", MasterType 91-97, Grade 0, Job 0).
  - Grade 1..5 = cost and color (green, blue, purple, orange, red); e.g. Grade 1 "Rainha Amazona" (Guerreiro+Elfo), "Lanceiro"; Grade 5 "Odin", "Thore", "Frigg", "Lokey", "Thrier".
  - `NextTemplateId` chains ★1→★2→★3; stats ★2 ≈ ×1.2 Atk / ×1.5 Life, ★3 ≈ ×1.5 / ×2.
  - `Hit` 1..8 *(assumption: damage to the player)*.
  - Buy price = Grade; sell price = Grade+(Star−1)×2 (`SelfChessTipView.as:79`).
- **Synergies:** `Job` CSV "class,race": classes 101 Guerreiro, 102 Cavaleiro, 103 Sacerdote, 104 Feiticeiro, 105 Arqueiro; races 201 Humano, 202 Demônio, 203 Anjo, 204 Elfo, 205 Dragão.
  - Count by distinct MasterType in battle (`SelfChessModel.as:129-160`); buff = highest `Amount` ≤ count (`SelfChessBuffTampCate.as:44-60`).
  - Tiers 2/4/6 (Guerreiro, Cavaleiro, Humano, Demônio) or 3/6 (others).
  - E.g. Guerreiro 6 = all units' damage +15%; Cavaleiro 6 = damage taken −24%; Arqueiro 6 = everyone's critical +20%.
  - AcceptObject 2 = all units, 3 = only that class/race (inferred from Desc).
- **Economy:** base income +5, interest min(5, gold/10), win/loss streak +1/+2/+3 (`selfchess.point.addTip`, `SelfChessBottomLeftView.as:148`); player level and shop color odds come from UpgradeTemplates Type 81 (`SelfChessBottomLeftView.as:122`).
- **Resources:** ResType 1 = soldier `swf/{ResPath}/{ResPath}.swf`, 2 = pet `equip{ResPath}/2.swf` (e.g. /pet_zeus), 3 = direct swf (/equip/autochess/wizard01/2.swf); `Scale` 40/50/70%; synergy icons `icon/autochess/{small|big}/{Job}.png` (`PathManager.as:932`).
- **Network:** `9701 C_SELF_CHESS_OP` (matchmaking), `25031 CR_SELF_PROPELLED_CHESS` with `PropertyMsg.param1` = op (3 buy, 4 sell, 5 move, 6 refresh shop, 7 buy EXP, 8, 10 lock shop) (`SelfChessManager.as:198`); receive `4216 U_C_SELF_PROPELLED_CHESS_DATA`, 4217 `_OVER`, 4218 `_STATE`, 4219 `_TIPS`; room `ChessRoomMsg`.
- **Not this system:** the guild "Duelo Tático" (`ChessPvp*`, 9730/561-566) is a different system.

### 5.4 Theseus overview (Alma de Teseu / Theseussoul)

- **Role:** "Alma de Teseu" (`theseus.equip.mainFrame`) is a secondary hero/avatar with its own power, used in Theseus modes (Theseus PvP 1v1/2v2, Tower, Dungeon). Manager `decompiled/core_module/scripts/managers/TheseussoulManager.as`, model `TheseussoulModel.as`, UI `decompiled/m5/scripts/theseus/*`.
- **Subsystems:** **Theseus Armor** ("Warframe" equipment with strengthening, quality increase and sets), **War Intent** (Intenção de Guerra; 12 "Rage" slots), **Treasure / Regenerating Seal** (Tesouro / Selo Regenerador; Core + outer/inner treasures), **War Spirit** (warsoul), **Divine Slates**, collection.
- **Data messages:** aggregate attributes arrive in `TheseusPropertyMsg` (4300); user data in `TheseusUserMsg{suite1..9, armour, level, hokeInfo, coreLevel, theseusEquipList}` (4298).

### 5.5 Theseus equipment (strengthening, quality and sets): `TheseusEquipStrengthenTmpls`, `TheseusEquipQualityTmpls`, `TheseusEquipSuiteTemplates`

- **Items:** 908 equipment items 72xxxxx (ItemTempInfos MasterType 10, SonType 720). 12 slots (2 rings, 2 bracelets).
  - Property1 = element/set 1..9 (Água, Fogo, Choque, Vento, Luz, Escuridão, Marinha, Terra, Celeste);
  - Property2 = group (1 Weapon/Clothes, 2 Shield/Cloak, 3 accessories);
  - Property3 = part 0..9 (Arma, Roupa, Escudo, Manto, Colar, Elmo, Cinto, Sapato, Anel, Bracelete);
  - Property4 = item Lv (1..20; Água up to 5, Celeste up to 20);
  - Property5 = Armor Value (22 per level on the Weapon).
- **Strengthen:** `TheseusEquipStrengthenTmpls[Type=Property3, Strengthen 0..400]` (`WarFrameItemInfo.as:102`).
  - `Attr` = total bonus at that level (indices 1 ATK, 2 DEF, 3 MAG, 4 Resistance, 5 Max Life; `AttributeUtils.as:48`); Weapon +400: Atk/MAtk 8720, Def/MDef 872, Life 20347.
  - Fixed per-level cost by part: 7450001 "Pedra de Temperamento Divino" + Gema Poseidon (-19000): Weapon/Clothes 349+3490, Shield/Cloak 410+4100, Necklace/Helmet/Belt/Shoes 174+1740, Ring/Bracelet 192+1920.
  - `Recovery` returns 100% of the stones on decompose (Blacksmith, `TheseusRosolveView.as:362`).
  - Cap = the quality's `StrengthenLimit` (`WarframeEnhancementView.as:200`).
- **Quality increase (Reforma/"reform"):** `TheseusEquipQualityTmpls[item, Quality 3..6]` (`WarFrameItemInfo.as:80`): 3 Requintado (cap 100, no bonus), 4 Magnífico (200), 5 Perfeito (300), 6 Celestial (400, no next cost).
  - Cost: 7460003 "Pedra Divina Impecável" (43…115) + Gema Poseidon 0 (`WarframeTransformationView.as:361-369`).
  - `-19000` = ItemTempInfo "Gema Poseidon" (currency poseidonCoin, PlayerCurrency type 58).
- **Armor Value / comparison:** `Property5 + Fraction(q) + Fraction(f)` (Fraction=0 in data); score `Property5 + CountFraction` (`TheseussoulModel.as:421,456`).
- **Sets:** 106 rows, 27 sets (9 elements × Weapon/Shield/Accessory).
  - A set is active when every piece of the group in the same element is equipped and the lowest Lv (Property4) ≥ `NeedMinLevel` (`TheseusSuitInfo.as:57-109`, `TheseusInfoItem.as:99`).
  - Bonus = only Anti-Resistance + Resistance Penetration (Weapon 360/set level up to 2880; Shield 120…960; Accessory 120…960).
- **Network:** `8684 C_THESEUS_WARFRAMECLIENT_OP` (`doWarFrameParam`: 1 list, 2/7 equip, 4 decompose, 5 strengthen, 6 increase quality, 8 unequip), `8680 C_THESEUS_CLIENT_OP`; receive `4323 U_C_THESEUS_EQUIP_DATA` (`TheseusEquipListMsg`). Texts `theseus.equip.*`, `theseus.war.gz0..6`, `theseus.warFrame.*`.

### 5.6 Theseus Fury and War Intent (Intenção de Guerra): `TheseusRageTemplates`, `TheseusRageSuiteTemplates`

- **Slots:** 12 (Type = pos 1..12 → Weapon, Clothes, Shield, Cloak, Necklace, Helmet, Belt, Shoes, Ring1, Ring2, Bracelet1, Bracelet2 via POSLIST/SONTYPES, `TheseussoulyiPageView.as:63`, `TheseussoulModel.as:35`).
- **Leveling (MasterType 1):** each slot levels Lv0..100, consuming 7400001 "Aço da Intenção de Guerra" (Weapon/Clothes), 7400002 "Alma…" (Shield/Cloak) or 7400003 "Ferro…" (others); Weapon Lv1 = 10 items, Lv100 = 505.
- **Attributes (linear):** Weapon/Clothes/Shield/Cloak Atk=MAtk 100/level (cost 10 at Lv1), Def=MDef 20/level, Life 700/level; accessories get ¼ of that (cost 3 at Lv1).
- **MasterType 2** (Lv1..45, no cost) = bonus levels granted by War Spirit Reform (`reformBuffList "pos,level"`, `TheseussoulyiPageView.as:220-231`, `TheseussouYiCell.as:66`).
- **Total bonus:** `TheseusRageSuiteTemplates`: lowest level across the 12 slots ≥ MinLevel (5,10,…,100) → "Atributos de Intenção de Guerra Nv.N" = +400×N Anti-Resistance and Resistance Penetration (`TheseusYiInfoItem.as:108`).
- **Network:** receive `4299 U_C_THESEUS_RAGE_DATA` (`TheseusRageListMsg`), send via 8680. Texts `theseus.yi.*`.

### 5.7 Theseus Treasure (Regenerating Seal): `TheseusTreasureCoreTemplates`, `TheseusTreasureGrowupTemplates`, `TheseusTreasureHokeTemplates`

- **Core** "Misericórdia de Aegeus": Lv1..150 in 6 bands (`Profile`, icon `/item_treasurecore_{1..6}.png`).
  - Each level costs `StrengthenItemNum` × 2127023 "Pedra de Fort. do Núcleo" (36→1033); Lv25/50/75/100/125 require a Breakthrough with 2127024 (100/300/500/800/1000).
  - Capped by Royalty Level (`Royalty.OpenCoreTreasureHoke`) and `SecretLevel` (Hermitage Expedition) (`TreasureCoreFrame.as:145-160`).
  - Lv150 attributes: Atk/MAtk 11880, Life 83160, Crit/Block/Pen 5940, anti-RES/Res.Pen 1440.
  - Core skills (3 slots): 1 from Lv26, 2 from 76, 3 from 126 (`TheseusTreasureCoreCate.getSkillGrade`).
- **Sockets (Hoke):** Type 1 = 9 Outer Treasure slots (items SonType 750), Type 2 = 3 Inner Treasure slots (SonType 751).
  - Opened by Royalty Level (`getOuterTreasureLv`/`getInnerTreasureLv`) and, for inner ones, by Expedition map (`Property1`, `TreasureInnerItem.as:66`).
  - State in `TheseusUserMsg.hokeInfo` (CSV).
- **Treasures (Growup):** 17 items (outer "Perifortes Sanguinário", "Sinnis Cruel", "Damastus Ardiloso"; inner "Maldição do Ciúme", "Vontade Preguiçosa", "Coração Ambicioso") with Lv0..30/40/50/60.
  - Each level costs 2127022 (outer) or 2127026 (inner); the suffix 01/02/03 sets the secondary Critical/Block/Penetration.
  - Strengthened at the Blacksmith (`decompiled/m14/scripts/store/treasure/TreasureIntensifyView.as:469-477`) and decomposed into stones (`TreasureResolveView.as:235`).
- **Network:** `4302 U_C_THESEUS_TREASURE_PROPERTY`; operations via 8680. Texts `TreasurePageView.*`, `TreasureCoreFrame.*`, `TheseusTreasureGrowupInfo.typeText01..17`.
