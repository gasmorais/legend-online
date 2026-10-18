# Game mechanics: Legend Online BR (OAS1264)

Entry point for `docs/mechanics/`. This page maps **every** game mechanic found in the client: what it does, its rules and
numbers, where the code lives, and which tables of the **super DB** (`db/`, PostgreSQL) model it. Each entry is a summary;
the per-area documents below hold the field-by-field detail (enums, formulas, examples). Battle flow, rendering and screens
are covered by sibling docs (see [Related docs](#related-docs)).

## Documents

| Document | Content |
|---|---|
| [README.md](README.md) | This index: one summary entry per mechanic, DB layout, known data issues. |
| [units_combat.md](units_combat.md) | Heroes, classes, stats, soldiers, army, monsters, AI, combat systems (Awaken, Vingador, War Soul, QTE, damage), stars, talents, runes, cards, stelae, slates, Teseu. |
| [skills_buffs.md](skills_buffs.md) | Skills, actions and frames, buffs, talents, passive stat profiles, effect codes, campaign and vehicle buffs, skill resources and opcodes. |
| [items_avatar.md](items_avatar.md) | Items, equipment, avatar layers, fashion, mounts, Einherjar (pets), Guardians (children), goddesses, vehicles, artifacts, titles, VIP. |
| [world_progression.md](world_progression.md) | Castle, economy, maps, campaigns, exploration modes, quests, shops, guild, PvP, bosses, events, drops, systems summary and formulas. |
| [catalog.md](catalog.md) | All 171 DB mechanics and subsystems, generated from `meta.mechanics`. |

The four detail documents are generated copies of `data/research/*.md` (`tools/db/build_docs.py`); edit the sources, not the copies.

## Contents

1. [Units](#units): [heroes](#hero) · [classes](#job) · [stats](#stats) · [soldiers](#pawn) · [army and formation](#army-formation) · [monsters](#monster) · [AI](#monster-ai)
2. [Combat](#combat): [battle](#battle) · [skills](#skill) · [buffs](#buff) · [talents](#talent) · [QTE](#qte) · [Awaken](#awaken) · [Vingador](#avenger) · [War Soul](#war-soul)
3. [Avatar, fashion and mounts](#avatar-fashion-mounts): [avatar](#avatar) · [fashion](#fashion) · [mounts](#mount) · [dragon mount](#dragon-talker)
4. [Items](#items): [items](#item) · [equipment](#equipment) · [suites](#item-suite) · [crafting](#crafting) · [artifacts](#artifact) · [collection](#collection) · [titles](#appellation) · [VIP](#vip)
5. [Companions](#companions): [Einherjar (pets)](#pet) · [Guardians (children)](#child) · [goddesses](#goddess) · [vehicles](#vehicle)
6. [Side progression](#progression): [runes](#rune) · [stars](#star) · [magic cards](#magic-card) · [stelae](#stela) · [slates](#slate) · [proficiency](#proficiency) · [Teseu](#theseus) · [levels](#leveling)
7. [World and economy](#world): [castle](#castle) · [maps](#map) · [campaigns](#campaign) · [exploration](#exploration) · [bosses](#boss) · [quests](#quest) · [drops](#drop) · [shops](#shop) · [guild](#guild) · [PvP](#pvp) · [social](#social) · [events](#event) · [configuration](#config)
8. [System](#system): [protocol](#protocol) · [UI](#ui)
9. [Known data issues](#data-issues)

Reference sections: [Sources](#sources) · [Related docs](#related-docs) · [DB layout](#db-layout)

## Sources

- **Real data:** `{TPL}tempinfos.xml`, downloaded from the server on 2026-10-17
  (`http://s1264oas.creaction-network.com/xml/tempinfos.xml`, version `619099013`; 3.1 MB zlib → 60 MB XML;
  **292 lists, 190,019 records**; names already in pt-BR). `tools/db/tempinfos.py` decodes it into `data/tpl/tempinfos/<List>.xml`.
- **Code:** decompiled AS3 (`decompiled/…`). Path prefixes: **CM** = `decompiled/core_module/scripts`, **Mn** = `decompiled/mn/scripts`.
- **Machine-readable research:** `data/research/*.json`, loaded into the DB (`meta.enum_types`/`enum_values`, `meta.formulas`, `raw.template_fields.description`).
- **Convention:** *(assumption)* marks claims not confirmed in code.

## Related docs

- [`docs/battle/README.md`](../battle/README.md): battle flow.
- [`docs/client/graphics.md`](../client/graphics.md): avatars, `.bswf`, effects, maps.
- [`docs/client/animations.md`](../client/animations.md): animation orders.
- [`docs/client/asset-catalog.md`](../client/asset-catalog.md): full manifest catalog.
- [`docs/world/maps.md`](../world/maps.md): spawns, portals, nodes, bounds, map formats.
- [`docs/ui/screens.md`](../ui/screens.md): screens.
- [`protocol/socket.md`](../../protocol/socket.md): socket protocol.

## DB layout

| Schema | Role |
|---|---|
| `raw` | Every template list (`template_sets`), attribute (`template_fields`: type, example, description, enum, logical FK, semantic column) and record (`template_records`, lossless JSONB). |
| `game` | English semantic model: 49 template tables (`heroes`, `pawns`, `skills`, `buffs`, `items`, `mounts`, `pets`…), code-derived reference tables (`jobs`, `avatar_layers`, `animation_labels`, `battle_grid_positions`…), derived tables (`skill_buff_links`, `fashion_items`, `avatar_resource_dirs`, `mount_animations`, `visual_effects`, `drop_entries`…) and `v_*` views. |
| `client` | CDN resources (`assets`), `opcodes`, `proto_messages`/`proto_fields`, `opcode_messages`, `localized_texts`, `screens`, `ui_styles`, routes. |
| `meta` | `mechanics` (the catalog behind this page, with `mechanic_links` to lists, tables, opcodes, messages and resource prefixes), `enum_types`/`enum_values`, `formulas`, `data_sources`, `load_issues`. |

Useful queries:

- `SELECT * FROM raw.v_template_coverage;` (coverage per list)
- `SELECT * FROM meta.mechanic_links WHERE mechanic_code = 'mount';`
- `meta.enum_label('skill_use_way', 2)`

---

<a id="units"></a>
## 1. Units

<a id="hero"></a>
### Heroes (`hero`)
- **What:** the player character (class × sex × level) plus every NPC hero and boss that fights in campaigns.
- **Data:** `GameHeroTemp` (7,370). `HeroType`: 1 player hero (base class, 9), 2 NPC with a class look (120), 3 monster/boss NPC (6,865), 7 and 8 special NPCs (196/180).
  `Job = 10` marks the 7,241 NPC heroes (no constant in `JobType.as`).
- **Rules:**
  - Base stats per level (`Grades`); `AI` points to the script (`HeroAis`, run **server-side**); `DefaultSkill` = basic attack;
    `SkillScript` = fixed NPC skills; `ResPath` = MovieClip `swf/<res>/<res>.swf` (class `slg.resource.movie.MovieAsset<res>`).
  - On bosses, `Captain` is the **number of HP bar segments** (not Liderança).
  - `RejectType` seems to list the buff `AttackType`s the unit is immune to *(assumption; the client never reads it)*.
  - Player heroes are drawn in layers (see [avatar](#avatar)).
- **Levels:** base level 1-80 (`UpGradeTempInfos` Types 3); each job-transfer stage has its own EXP table (Types 105, 110, 152, 158).
  Total level = `grades + vocationGrades` (stage 0), `160 + vocationGrades` (stages 1-2), `240 + …` (stage 3), `270 + …` (stage ≥4); cap ≈ 310 (`ThaneInfo.totalGrade`).
- **Power:** the server computes final stats and power; the client only displays them (`army_combat_power = totalAttribute + totalLive/5 + totalConatArmy`).
- **Code:** `CM/yishi/datas/templates/GameHeroTemplate*` + `TempleteManager.as:1144`; battle: `CM/battle/view/roles/HeroRoleView.as`, `HeroLoadDataFactory.as`.
- **DB:** `game.heroes`, `game.jobs`, `game.sexes`, `game.v_unit_movies`, `game.avatar_resource_dirs` (`owner_kind='hero_npc'`).
- **Detail:** [`units_combat.md`](units_combat.md) §1.

<a id="job"></a>
### Classes (`job`)
- **Values:** 1 warrior, 2 hunter (archer), 3 wizard (sorcerer), 4 draconian (Domador de Dragões, module m5);
  0 = no restriction; 100 = newcomer ("Misterioso", body `swf/avatar/mystery_default_body/2.bswf`) before choosing a class (`selectjobregister`);
  99 = Domador de Dragões equipment/fashion (on items).
- **Rules:**
  - The class determines skills (`SkillTempInfos.MasterType` = class or class+30; post-transfer trees class·10+1..3),
    default avatar parts (`/warrior_default_*`, `/hunter_default_*`, `/wizard_default_*`, `/dragonic/dragonman_default_*`)
    and the fashion resource suffix `<job>_<sex>`.
  - Job transfers (`NeedChangeJob`, `NeedTransfer`, `NeedThirdTransfer`) unlock equipment and content;
    2nd-transfer branches depend on tattoo stats (`ConfigInfos Job*_Branch*`).
- **Code:** `CM/yishi/datas/consant/JobType.as:8-18`, `SexType.as:16-20` (0 female, 1 male, 2 any).
- **DB:** `game.jobs` (with default resource prefixes), `game.sexes`.

<a id="stats"></a>
### Stats (`stats`)
- **What:** one stat set shared by heroes, soldiers, items, mounts, collections and skill profiles.
- **Primary stats and conversion** (`base_attribute_conversion`):

  | Stat (XML field) | Effect |
  |---|---|
  | Força (`Power`) | +4 attack, +1 defense |
  | Proteção (`Agility`; the XML name is misleading) | +4 defense, +4 magic resistance |
  | Inteligência (`Intellect`) | +4 magic attack, +1 resistance |
  | Físico (`Physique`) | +20 HP |
  | Liderança (`Captain`) | +1 soldier |
  | Infantaria (`Conat`) | troop capacity |
  | Vigor/Intensidade (`Strength`), Tenacidade | converted to % by `x·100/(x+8000)` |

- **Combat stats:** physical and magic Attack/Defense, HP (`Live`), Crit (`ForceHit`), Block (`Parry`), Determination/"Força Consistente" (`StunAttr`),
  Penetration; Fire/Water/Electricity/Wind/Dark/Light resistances (reduction `min(floor(resi·0.12), 90)` %), `ReduceResi` (anti-RES), `ReduceResiAgainst`, `ResiPenetrate`.
- **Client formulas** (tooltips and power):
  - Equipment power: `Atk + MAtk·1.05 + Def + MDef + Parry + Crit + Conat + Live/5 + Agility·8` (`CM/bag/helper/GoodsCheck.as:473`).
  - Pet power: `int(700 + MAtk + MDef + Atk + Def + HP/5)` (`CM/mvc/module/pet/PetData.as:204`).
  - All formulas are in `meta.formulas` (227).
- **DB:** `game.stat_types` (XML attribute → column), `game.stat_bonus_profiles` (`SkillPropertyTempInfos`, 11,924 profiles used by passive skills, monsters and fashion).

<a id="pawn"></a>
### Soldiers (`pawn`)
- **What:** soldiers recruited in castle buildings and led by heroes; the same template set also holds the monster units.
- **Data:** `PawnTempInfos` (6,464). `MasterType` 1-12 = playable lines (Lanceiro, Arqueiro, Espadachim, Grifo, Sacerdote, Cavaleiro, Anjo, Demônio, Presbítera, Cavaleiro Mágico, Anjo Mágico, Arqueiro Demônio; 80 levels each); 101 = monsters (5,499).
- **Rules:**
  - Each level is one template; `NextLevelTemplateId` chains the evolution; cost in gold/crystal/population; `NeedBuilding` = required building;
    `DefaultSkill`/`HighSkill` = skills; `AttackType` physical/magic; `Swf` = battle MovieClip.
  - Player soldier id = `10000 + MasterType·100 + Level`. Soldiers per hero = `floor(total Infantaria / NeedPopulation)` (Liderança 1:1).
  - Evolution costs spirits (`UpGradeTempInfos` Types 1: Lanceiro/Arqueiro `2·L³`, Espadachim/Sacerdote `5·L³`, Grifo `6·L³`) and requires Quartel (SonType 402) ≥ the target level.
  - Recruiting costs gold, discounted by the Quartel.
  - `SpecialTempInfos` (561): soldier specialties (stat conversions per `PawnMasterType`).
- **DB:** `game.pawns`, `game.v_unit_movies`, `game.avatar_resource_dirs` (`owner_kind='pawn'`, 704 with art in the manifest).

<a id="army-formation"></a>
### Army and formation (`army_formation`)
- **What:** each side has a 3-column × 4-row grid (positions 1-12) that holds heroes, soldiers, Einherjar (pets), Guardians (children) and the goddess.
- **Rules (verified):**
  - `BattleUtils.get9GridPos(295,570)` (left side) and `(905,570)` (right side): columns are 150 px apart; each row goes 60 px down and 40 px back.
  - `rolePointByPos` puts positions 1/4/7/10 in the front column (closest to the center).
  - NPC troops come from `HeroAis.Soldiers` (`"pawnId,pos|…"`).
- **Code:** `CM/battle/utils/BattleUtils.as:108-200`.
- **DB:** `game.battle_grid_positions` (24 rows with computed x/y), `game.hero_ai_soldiers` (446).

<a id="monster"></a>
### Collectible monsters (`monster`)
- **What:** the m14 monster system (capture, exploration, cooking): `MonsterTemplates` (73) with type, stars, max level, stat profile (`PropertyId` → `SkillPropertyTempInfos`) and skills per `SonType`.
- **Graphics:** `ResPath` → `swf/<res>/<res>.swf`; `Scale` (%) and `Offset` (px) adjust the MovieClip; `DefaultAttack` = attack label.
- **Related:** `MonsterExploreTemplates`, `RecipeTemplates`, `MonsterExploreDrop`, `MonsterCookDrop`.
- **DB:** `game.monsters`.

<a id="monster-ai"></a>
### NPC and boss AI (`monster_ai`)
- **What:** `HeroAis` (8,080) gives each NPC hero:
  - a cyclic skill sequence (`Skills`);
  - trigger skills: `CrazySkill` (rage), `LessHpSkill` (low HP), `DeadSkill` (on death), `AngrySkill`, `AwakenSkill`;
  - background skills (`BottomSkill(s)`);
  - a transformation (`ChangeSkills` + `ChangeIcon`) and escort troops.
- The server decides; the client only preloads resources.
- **DB:** `game.hero_ais`, `game.hero_ai_soldiers`.

---

<a id="combat"></a>
## 2. Combat

<a id="battle"></a>
### Battle (`battle`)
- **What:** real-time combat driven by server frames (25 fps). There are no turns; only buffs count turns.
  Flow: 157 prepare → 10007 loaded → 156 start → 153 attacks → 154 end → 4103 report. Full detail: [`docs/battle/README.md`](../battle/README.md).
- **Unit animation:** `Stand`/`Walk`/`Ready` loop; `Danny` (hit) and `Die`; `Victory`/`Failed` stop on the last frame;
  attack labels come from `ActionInfos.Para[0]` (`CM/yishi/view/tools/ActionMovie.as:163-266`).
- **DB:** `game.animation_labels`, `game.battle_movie_parts`, `game.blood_types` (6 HP, 7 troops, 9 rage, 10 revive, 11 skill disable, 21 max HP, 24 hit point, 26 faith), `game.battle_grid_positions`.

<a id="skill"></a>
### Skills and actions (`skill`)
- **What:** every ability of every system (22,716 rows). Each row is one skill **level**; `SonType` = skill family, `NextTemplateId` = next level.
- **Chain:** `SkillTempInfos.ActionId` → `ActionTempInfos` (593 actions: strikes, frame count) → `ActionInfos` (2,740 frame events) → effects `skillEffect/<link>.swf`; `BufferIds` → buffs.
- **Use (`UseWay`):** 1 active (5,448), 2 passive (17,124), 3 normal attack (76), 4 slate trigger (37), 5 passive trigger *(assumption)*.
- **Target (`AcceptObject`):** 1 random single, 3 all, 4 self, 6 front, 8 front row, 11 cross, 15 splash, 18 dead…
- **Priority 3** = super skill (the caster scales 1.5x, the background flashes, the screen shakes; `CommonActionSkill.as:39-48`).
- **Costs:**
  - Negative `Cost` = rage consumed; `CoolDown` in ms (common: 15,000/30,000/60,000); `HitPointCost` (Domador de Dragões).
  - `Parameter1` = damage %, `Parameter2` = flat damage; talents modify both (`SkillTempInfo.as:182-449`).
- **Owner (`MasterType`):** ~130 values: 0 generic (soldiers, monsters, runes, titles, cards…), 1/2/3 classes, 4 Domador de Dragões (3,030),
  10-60 talents, 41-57 Guardians (children), 81 goddess, 83 monsters, 500/501 Vingador… (enum `skill_master_type`).
- **Frame types (`ActionType`):** 0 advance, 1 attack label, 2 cast effect, 3 damage, 4 zoom, 5 "gas", 6 background color, 7 shake,
  11/12 projectile/beam, 23/24 displacement, 25 hide, 99 end, 100 return (`CM/battle/skillsys/constants/SkillFrameType.as`); the `Para` layout per type is in `game.action_frame_types.param_names`.
- **DB:** `game.skills`, `game.actions`, `game.action_frames`, `game.action_frame_types`, `game.skill_buff_links` (10,244), `game.visual_effects` (351 effects), `game.action_frame_effects`, view `game.v_skills`.
- **Detail:** [`skills_buffs.md`](skills_buffs.md) §1-3, §11.

<a id="buff"></a>
### Buffs and states (`buff`)
- **What:** temporary effects applied by skills (`SkillBufferTempInfos`, 12,559).
- **Fields:**

  | Field | Meaning |
  |---|---|
  | `AttackData` | 1 beneficial, 2 harmful |
  | `AttackType` | effect: 15 damage taken ±%, 20 damage dealt ±%, 305 DoT, 16 crit rate, 34 shield, 19 stun…; ~3,590 rows use a template id as the type (server-scripted buffs) |
  | `ValidCount` | turns (-1 = permanent) |
  | `CountWay` | number of triggers |
  | `PressCount` | max stacks |
  | `Dispel` | 1 = undispellable |

- **Rules:** a target never holds two instances of the same template (the existing one is updated).
  Immunity is implemented as buffs (69/70 physical/magic immunity, 309 no new debuffs, 400 no new buffs).
- **Protocol:** `AttackOrderMsg.buffers[]` (`BufferMsg`: `see_type` 0 add / 1 update / 2 remove, `cur_turn`, `pressed_num`…). The class exists only in `CM/com/road/yishi/proto/battle/BufferMsg.as` and is missing from `protocol/proto.json`.
- **Visual:**
  - `AddEffect` (on apply), `ActionEffect` (each trigger), `LastEffect` (loop); format `"link,pos[,interval]"`, pos 1 head / 2 body / 3 feet; file `skillEffect/<link with . → _>.swf`.
  - `slg.resource.BufferEffect{id}` exists but is **never called** (this corrects [`docs/client/graphics.md`](../client/graphics.md) §3).
- **Other buff lists:** `CampaignBufferTemps` (campaign battlefield), `RandomBossBuffInfos` (Calabouço Aleatório buff shop, paid in Cristal de Sangue), `GloryRoadBufferInfos`, `VehicleBuffTempInfos`.
- **DB:** `game.buffs`, `game.campaign_buffs`, `game.vehicle_buffs`, `game.visual_effects` (`kind='buff_effect'`).

<a id="talent"></a>
### Talents (`talent`)
- `TalentEffectTempInfos` (6,932) modifies the skills of one `SonType` (or all, -1): cost (`EffSp*`), damage (`EffDam*`), cooldown (`EffCd*`), crit, extra buffs, randomness.
- Hero talents are skills with MasterType 10-80 whose buffs carry `TalentEffIds`; `SkillTempInfo.getTalentEffectIds` collects them (`:270-319`).
- **DB:** `game.talent_effects`, `game.buffs.talent_effect_ids`.

<a id="qte"></a>
### QTE (`qte`)
- A skill with `QTETime > 0` opens `QteView` (keys = `time/1500`, time limit `time - 400` ms); success sends 10015.
- **In BR `QTETime` is always 0**, so the QTE never opens.

<a id="awaken"></a>
### Awaken (`awaken`)
- 4600 `U_C_UPDATE_AWAKE` (`AwakeMsg`) updates the Awaken bar; when full, it unlocks `HeroAis.AwakenSkill` and the pet EX skills (`AppearCD` 10,000 ms).

<a id="avenger"></a>
### Vingador (`avenger`)
- Body by type and grade (`AvengerBodyTemplates`, 221: attack/defense/HP per grade), skills per class (`AvengerSkillTemplates`, 180, up to 6 materials), holes (`AvengerHoleTemplates`).
- In battle: its own SP (4589) and skill swap (4591); cost in "vengeance slots" = |Cost/10| for MasterType 500/501.
- **DB:** `game.avenger_bodies`, `game.avenger_skills`.

<a id="war-soul"></a>
### War Soul (`war_soul`)
- Equippable spirits (`WarSoulTmpls`, 54) with stars (`WarSoulStarTmpls`), strengthening (`WarSoulStrengthenTmpls`, 10,179) and reform.
- Battle SP (4311); spirit tower (`WarSoulTowerLevelTemplates`, 500 floors).
- **DB:** `game.war_souls` (+ raw lists in `raw`).

---

<a id="avatar-fashion-mounts"></a>
## 3. Avatar, fashion and mounts

<a id="avatar"></a>
### Avatar and animations (`avatar`)
The hero is drawn in **layers**, in three contexts:

| Context | Resource | Animations | Composition |
|---|---|---|---|
| **Map/city** | `.bswf` (TLV + SWF with BitmapData) in `swf/avatar<res>/…` | `S_<frame>_<dir>` idle (3 directions × 5 frames), `W_<frame>_<dir>` walking (5 directions × 6 frames); left = mirror | layers `body`, `army`, `hairUp`, `hairDown`, `cloak`/`wing`, `mount`, `mountWing`, `pet`, sorted by per-direction weight (higher = behind) |
| **Battle** | MovieClips `equip<res>/<file>.swf` (`ClassExport`, `ClassExport1..4`) | `Stand`, `Walk`, `Ready`, `Danny`, `Die`, `Victory`, `Failed` + attack labels | fixed back-to-front stack: `cloak2, mount, arms2, hair4, hair3, body, hair2, arms, hair1, cloak1`, all in sync |
| **UI ("show")** | `equip_show<res>/…` with `/front/` and `/back/` | static/loop | backHair, wing, backCloak, arms, body, frontCloak, frontHair, pet |

- **File per part type:** equipment `<sex>.bswf|swf`; fashion and wing `<job>_<sex>` (draconian `4_<sex>`, under `…/dragonic/…`); mount, pet and child `2.bswf|swf`.
- **Defaults:** each class has default parts used when nothing is equipped. Riding a mount **without** `IsStand` uses the `<part>_mount` variants.
- **Mount offset:** a mount shifts the rider by `offsetY` and sets flight (`flight`) in the `.bswf` header (`CM/com/pickgliss/loader/DomainResourceLoad.as:84-150`).
- **DB:** `game.avatar_layers`, `game.avatar_layer_z_orders` (weights read from `CM/avatar/data/AvatarStaticData.as`), `game.avatar_part_draw_orders`,
  `game.battle_movie_parts`, `game.animation_labels`, `game.avatar_resource_dirs` (7,423 folders linked to items, mounts, pets, children, soldiers and NPCs).
- **Detail:** [`docs/client/graphics.md`](../client/graphics.md) §1-2 and [`items_avatar.md`](items_avatar.md).

<a id="fashion"></a>
### Fashion (`fashion`)
- **What:** items with `MasterType 1` and `SonType` **109 wing (411)**, **110 hat/hair (436)**, **111 fashion weapon (413)**, **112 outfit (437)**.
  Each replaces one avatar layer in every context:

  | Part | Layer replaced |
  |---|---|
  | wing | `wing` (in place of the cloak; `cloak1/cloak2` in battle) |
  | hat | `hairUp` + `hairDown` (folders `<Avata>up` and `<Avata>down`; in battle, one SWF with `hair1..hair4`) |
  | weapon | `arms` |
  | outfit | `body` (removes the default cloak) |

- **Real example:** "Roupa de Balé" `Avata=/fashion_cloth_ballet` →
  map `swf/avatar/fashion_cloth_ballet/{1..3}_{0,1}.bswf` (+ `…_ballet_mount/` when mounted), battle `equip/fashion_cloth_ballet/{job}_{sex}.swf`,
  UI `equip_show/fashion_cloth_ballet/{job}_{sex}.swf`.
- **Stats:** granted by **skills** (`ItemTempInfos.DefaultSkill`, e.g. wing "5101,5001") and by **polishing** (`FashionPolishs`, levels 0..100 per part):
  - `LevelAdd` = % of the base profile (wing → 5 stats, hat → HP, outfit → Def+MDef, weapon → Atk+MAtk).
  - `SpAdd` = rage at each level that is a multiple of 10, using the lowest-level part.
  - `AppraisalAdd` is unlocked by the number of fashion items collected in the book (`NeedCount`).
  - Formulas: `CM/mvc/module/fashion/FashionModel.as:1178-1277`.
  - Grade (S/A/B/C/D) = `ItemTempInfos.TransformId` 1..5 on fashion items.
- **Sources:** shops (`ShopTempInfos`), events, drops; fashion book (collection).
- **DB:** `game.fashion_items` (1,697, with layer and art-present flags), `game.fashion_polish_levels`, view `game.v_fashion` (map/battle/UI folders), `game.item_categories`.

<a id="mount"></a>
### Mounts (`mount`)
- **What:** `MountTempInfos` (733). Mounts give stats (Força, Inteligência, Físico, "Proteção" = `Agility`), map speed and appearance.
- **Types (`MountType`):** 0 base form per mount level (8), 1 collectible/"beast" (713, adds `Speed`), 2 special/hidden, 3 VIP, 4 king contract (level 70), 5 special.
  Collection tabs (`Area`): 0 normal, 1 magic, 2 domestic, 3 beasts, 4 technology.
- **Rules:**
  - Activated by card (`NeedItemId`, items SonType 218) or diamonds (`Property1`).
  - Stars = number of `StarAddition` values (% per star); cost/blessing per star in `UpGradeTempInfos` Types 37 (`GradeType`).
  - Speed = `20 + ceil(grade/2)·10 (+Speed if type 1)` (`CM/mvc/module/mounts/MountInfo.as:44`).
  - Grade by EXP (`UpGradeTempInfos` Types 19); soul refining (Types 144/145); `SoulScore` adds to the soul ranking.
  - Operations via 8529 `C_MOUNT_OP` (enum `mount_op`).
- **Animations:**
  - Map: body `swf/avatar<AvatarPath>/2.bswf` with frames `S_*` (idle) and `W_*` (walking); `AvatarPath = "body|wing"` adds the `mountWing` layer.
  - `IsFly` = flies (ignores obstacles on the space map; 361 mounts). `IsStand` = rider stands (76); otherwise the hero parts switch to `_mount`.
  - Battle: not shown, except the [dragon mount](#dragon-talker). UI: `equip_show<AvatarPath>/2.swf`.
- **DB:** `game.mounts` (`avatar_path` and `wing_avatar_path` pre-split), `game.mount_animations` (1,466 rows; 1,150 with a manifest resource and URL), view `game.v_mounts`.

<a id="dragon-talker"></a>
### Dragon mount, Domador de Dragões (`dragon_talker`)
- Class 4 rides a dragon **in battle**: `DragonTalkerFightMountTemplates` (8 grades: Grendel, Fafnir…) with stats and a starting `HitPoint` (consumed by skills with `HitPointCost`; bar `bloodType 24`).
- Graphic `equip/dragonic<AvatarPath>/2.swf` is the `mount` part of the battle stack (behind the hero); preview `equip_show/dragonic…`.
- **DB:** `game.dragon_battle_mounts`, `game.mount_animations` (`context='battle'`).

---

<a id="items"></a>
## 4. Items

<a id="item"></a>
### Items (`item`)
- `ItemTempInfos` (12,201). Category = `MasterType × SonType` (178 combinations, enum `item_son_type`): 1 equipment/fashion; 2 consumables/materials (largest group); 3-15 systems (gems, runes, pets, children, Teseu…).
- Negative ids are **virtual currencies** (-100 gold, -200 amethyst/mineral, -300 spirit, -400 diamond, -500 bound diamond, -600 crystal…; enum `virtual_currency_item`).
- `Profile` = quality/color (1 white … 7); the meaning of `Property1..7` varies by category (`game.item_categories.property_semantics`).
- **DB:** `game.items`, `game.item_categories`, view `game.v_items`.

<a id="equipment"></a>
### Equipment (`equipment`)
- **Slots:** 101 weapon, 103 helmet, 104 armor, 106 necklace, 107 ring, 108 ornament, 117 crest, 118 relic.
- **Strengthening:** `add = base·grade·0.1 + grade·5`; the gold cost grows with item level and quality (`CM/yishi/utils/GoodsHelp.as:129`, `CM/bag/helper/GoodsCheck.as:326`).
- **Other upgrades:** **casting** up to 80/160/240 by quality; **gems** (`Property1` = socket count); **transformation** (`TransformInfos`, up to 8 materials); **decomposition** (`ItemResolveTemplates`).
- **DB:** `game.items`, `game.item_transforms`, `game.item_resolves`, `game.recipe_materials`.

<a id="item-suite"></a>
### Suites (`item_suite`)
- `SuiteTempInfos` (244): pieces `Template1..8` (+ variants `Template1s..8s`); bonuses per piece count in `Property1..8` (skill/profile ids).
- **DB:** `game.item_suites`, `game.item_suite_pieces`.

<a id="crafting"></a>
### Crafting and composition (`crafting`)
- `ComposeTempInfos` (3,340 recipes: up to 4 materials + gold → item); alchemy (`AlchemyFormulaTemplates`, `AlchemyMineTemplates`).
- **DB:** `game.item_compose_recipes`, `game.recipe_materials`.

<a id="artifact"></a>
### Artifacts (`artifact`)
- `ArtifactTemplateInfos` (12 legendary artifacts): aptitudes `"base,max"`, per-stat conversions, activation item. Emblem armory: `ArftiArmoryTemplateInfos` (value = base + add·grade).
- Power: `AttackMin + DefenceMin + int(MagicAttackMin·1.05) + MagicDefenceMin + LiveMin/5 + ParryMin + PenetrateMin` (`M11/ancientartifact/AncientEquipFrame.as:129`).
- **DB:** `game.artifacts`.

<a id="collection"></a>
### Collection (`collection`)
- `CollectionTemplates` (330): collectibles with stars 0..10 that give stats (`round(Max·(k+1)/11)`) and a special effect; sets and rewards.
- **DB:** `game.collections`.

<a id="appellation"></a>
### Titles (`appellation`)
- `AppellInfos` (951): titles earned by condition (`CondtionType`: ranking, achievement, event…) and shown next to the name (`Perfix "text|style"`), with quality, duration and a granted **skill**.
- **DB:** `game.appellations`.

<a id="vip"></a>
### VIP (`vip`)
- Levels 0-9 with privileges (`VipPrerogativeTempInfos`, 201: shop discount `type 208`, transformation cost `type 202`, appearance…), rewards (`VipDrop`) and first top-up (`FirstChargeItems`).
- Shops use only `VIP0Count` (daily limit; -1 = unlimited).
- **DB:** `game.vip_privileges`.

---

<a id="companions"></a>
## 5. Companions

<a id="pet"></a>
### Einherjar, pets (`pet`)
- `PetTempInfos` (108; 9 types × qualities): aptitudes `"min,max"` for Força/Int/Físico/Armadura, growth, resistances; follow skills (`FollowSkills`), transformation skills (`ChangeSkills`) and default skills.
- Stats: `attr = base + floor((level-1)·growth/80)`; attack/defense are derived with coefficients (`CM/mvc/module/pet/PetData.as:806-935`).
- Fusion (`PetComponseInfos`), contracts, relics (`PetHallowsTempInfos`), pet challenge, remote pets.
- **Graphics:** map `swf/avatar<PetAvatar>/2.bswf` (layer `pet`, weight -10); battle `equip<PetAvatar>/2.swf`, follower `…_follow/2.swf`.
- **DB:** `game.pets`, `game.pet_skill_links`, `game.pet_fusions`.

<a id="child"></a>
### Guardians, children (`child`)
- `ChildTempInfos` (15 classes × 12 grades): the child inherits `stat = hero_stat · X/100`; summoned by item; own weapon (`ArtifactPath`); skills `SkillMasterType` 41-57.
- Assist, camp, patrol (`ChildPatrolMissionTempInfos`), child PvP. Graphic: `equip/hychild<ResPath>/2.swf`.
- **DB:** `game.children`.

<a id="goddess"></a>
### Goddesses (`goddess`)
- 5 goddesses (`GoddessTemplateInfos`) with 240 levels (`GoddessUpgradeTemplates`), 40 steps/stars (`GoddessStepTemplates`: extra % + skill + faith), devotion, equipment and formation.
- `stat = int(Upgrade.X · (100 + Step.AddPer)/100) + equipAdd` (`CM/managers/GodDessManager.as:44`).
- In battle they appear via 4102 (`U_B_GODDESS_STAGE`) and use faith (`bloodType 26`).
- **DB:** `game.goddesses`, `game.goddess_levels`, `game.goddess_steps`.

<a id="vehicle"></a>
### Vehicles (`vehicle`)
- Vehicle minigames (tanks, Unreal Shooting): `VehicleObjectTempInfos` (39), skills (`VehicleSkillTempInfos`: cast, cooldown, range, area), buffs.
- **DB:** `game.vehicles`, `game.vehicle_skills`, `game.vehicle_buffs`.

---

<a id="progression"></a>
## 6. Side progression

<a id="rune"></a>
### Runes (`rune`)
- `RuneTempInfos` (132): each rune is a skill (`SkillTemplateId`) with level, GP cost and a `NextRuneId` chain; gems (`RuneGemInfos`), holes (`RuneHoleInfos`), gains (`RuneFsgainInfos`).
- **DB:** `game.runes`.

<a id="star"></a>
### Stars (`star`)
- `starTempInfos` (82): stars collected in the star bag; they give stats and a skill and sell for GP/gold.
- **DB:** `game.stars`.

<a id="magic-card"></a>
### Magic cards (`magic_card`)
- `MagicCardTempInfos` (20 cards × grades): activated by item, evolved with magic dust; each grade grants a skill.
- **DB:** `game.magic_cards`.

<a id="stela"></a>
### Stelae (`stela`)
- `StelaTemplates`/`StelaStepTemplates`/`StelaPropertyTemplates`/`StelaResistTemplates`: stages with passives (skills MasterType 13400-13600). Detail in [`units_combat.md`](units_combat.md) §5.

<a id="slate"></a>
### Slates (`slate`)
- `SlateTmpls`/`SlateUpgradeTmpls`/`SlateTaskTmpls`; slate trigger skills (`UseWay` 4, opcode 10523).

<a id="proficiency"></a>
### Proficiency (`proficiency`)
- `ProficiencyTemplates` (700): bonus per proficiency level.

<a id="theseus"></a>
### Teseu (`theseus`)
- System family: Teseu equipment (quality, strengthening, suites), rage (`TheseusRage*`), treasure (`TheseusTreasure*`), 1v1 and multiplayer arenas (`TheseusPvp*`, `TheseusMultiPvp*`), tower, dungeon and "Desafio de Teseu" (`StoreHouse*`).

<a id="leveling"></a>
### Levels (`leveling`)
- `UpGradeTempInfos` (13,335): level × value tables for dozens of systems, keyed by `Types` (19 mount grade, 37 mount stars, 113 fashion, 127 relics, 140 dragon mount, 144/145 soul…; enum `upgrade_type`).
- **DB:** `game.level_thresholds`.

---

<a id="world"></a>
## 7. World and economy

<a id="castle"></a>
### Castle and buildings (`castle`)
- `BuildingTempInfos` (2,189: 32 types × up to 80 levels): gold/crystal cost, time, player level, production (`Property1..6`), city position; art `mapmaterial/build/<SonType>.swf`.
- Only Prefeitura (901), Quartel (402) and Santuário (501) have 80 levels. Prefeitura gold/hour = `390 + 525·(g-1)` up to level 60, then `31365 + 285·(g-60)`.
- Technologies (MasterType 13/14) cost Cristal de Luz; Santuário levels 1-12 unlock the 12 basic ones and level 55 the 12 advanced ones; bonus = `EffectTempInfos.Property1 × level`.
- Build queue: 1 slot (the 2nd costs 100 diamonds); speed-up = `ceil(remaining/600)` diamonds (free with VIP). Gold, crystal and population arrive via 109 `CastleYieldMsg`.
- **DB:** `game.buildings`, `game.city_effects`.

<a id="map"></a>
### Maps (`map`)
- `MapInfos` (1,112): world, campaigns, instances; `MapFileId` → `maps/<id>/<id>.maps` and tiles `mapmaterial/land/<id>/`; `BattleGround` → `sceneIma/<id>/map<id>.swf`.
- **DB:** `game.maps`.

<a id="campaign"></a>
### Campaigns (`campaign`)
- `Campaigns` (285, 25 types): dungeons, instances, map events; level range, prerequisites, required job transfer, schedule (`OpenTime`/`StopTime`), required power.
- Energy: 200 per day, 20 per campaign; sweep runs = `floor(energy/20)`. Real drops arrive as cards (`U_C_CAMPAIGN_CARDS`).
- **DB:** `game.campaigns`, `game.campaign_buffs`.

<a id="exploration"></a>
### Exploration modes (`exploration`)
- Minos (m6), Eremitério (`Secret*`, m3), Desafio de Teseu (`StoreHouse*`), Ruínas (`RemainsExplore*`), Terra das Sombras, Expedição (m14), Estrada dos Heróis, Terra Demoníaca (`EvilLand*`), Estrada da Vingança, Quintal (`HugeHead*`/`StackHead*`),
  Jardim Aéreo, Área Estelar, Labirinto Sombrio, Estrada Final, Teste Celestial, Crise, Planos (`Planes*`).
- Each mode has daily limits and costs in `ConfigInfos`, and drops linked to a `*Drop` list.
- Opcode table and rules: [`world_progression.md`](world_progression.md).

<a id="boss"></a>
### Bosses (`boss`)
- Guild boss (new, `ConsortiaNewBoss*`), forbidden boss (`ForbiddenBoss*`), royalty boss (`RoyaltyBoss*`), world boss (no template; code + config), PvE guard (`GuardPVETemp`, nested).

<a id="quest"></a>
### Quests (`quest`)
- `QuestTemps` (835; types 0 main 781, 1 daily 35…) with conditions (`QuestCondictionInfos`, 169 `task_condition_type` codes) and reward items per class.
- Completion is stored as a bitset; `IsAuto` auto-accepts (5012); turn-in via 5014. Daily XP = `RewardPlayGP + (level - NeedMinLevel)·500`.
- Also: reward board, ring tasks, marriage quests.
- **DB:** `game.quests`, `game.quest_conditions`, `game.quest_reward_items`.

<a id="drop"></a>
### Drops (`drop`)
- ~60 `*Drop`/`*Reward` lists share one package schema: `dropId`, `site` (position/condition), `para2` (range `"min,max"`), `itemId`, `count`, `isBind`, `appearType` (1 fixed, 3 rare…), `validDate`, `isShow`.
- **DB:** `game.drop_entries` (16,199), view `game.v_drops`.

<a id="shop"></a>
### Shops (`shop`)
- `ShopTempInfos` (1,183, 43 types): price = the first currency column > 0 in priority order (diamond, bound diamond, gold, contribution, honor, points…; `ShopGoodsInfo.setPrice:469`).
- Tabs by `Area`; `Labels` badges: 1 new / 2 recommended / 3 hot; `ValidDate` in minutes.
- Shop kinds: guild, alliance, game box, Poseidon, exploits, commerce, furniture. The auction has no template (fees: 250 gold/h, 20%).
- **DB:** `game.shop_items`.

<a id="guild"></a>
### Guild, consortia (`guild`)
- `ConsortiaLevelInfos` (26 types × 10 levels): members = level·20 + 10; weekly upkeep = level·500; donating 1000 gold or 1 diamond = +1 contribution; ranks 1 president … 5 member.
- Treasury, quests, shop, PvE, guild war, tactical chess.
- "Aliança" (`Alliance*`) is the **returning-player** event, not a guild alliance.
- **DB:** `game.guild_levels`.

<a id="pvp"></a>
### PvP (`pvp`)
- Arena dos Sonhos, colosseum, Ápice, Teseu arenas (score by `Mode` 0 defense / 1 attack), child PvP, pet challenge, royalty rankings.

<a id="social"></a>
### Social (`social`)
- Marriage (`MarrySpecTempInfos`), friends, rooms (`room_type`), mail (`email_type`), king contracts.

<a id="event"></a>
### Events (`event`)
- Easter, Christmas, Carnival, 7th anniversary, New Year, daily/weekly activities, quizzes, first top-up, player return, gashapon.
- Time windows arrive via 4590 `U_C_TOP_TOOL_BTN`; dates live in `ConfigInfos`.

<a id="config"></a>
### Configuration (`config`)
- `ConfigInfos` (990 keys; 7 duplicated): daily limits, costs, energy, event dates. `TopToolBtnInfos` (96): top bar buttons.
- **DB:** `game.config_entries`.

---

<a id="system"></a>
## 8. System

<a id="protocol"></a>
### Protocol (`protocol`)
- TCP socket :5004, 1,876 opcodes (729 send + 1,147 receive), 1,645 protobuf messages (1,423 from `protocol/proto.json` + 222 only in AS3 classes, read by `tools/db/parse_as3_protos.py`, which also recovers the type of 831 submessage fields).
- `tools/db/infer_opcode_messages.py` linked **1,494 opcodes** to their message by reading AS3:
  send = `new PackageOut(N)` + `new XxxMsg()`; receive = `"SLGSocketEvent" + N` or transaction `getCode()` + `readBody(...) as XxxMsg`.
- **DB:** `client.opcodes`, `client.proto_messages`, `client.proto_fields`, `client.opcode_messages`, view `client.v_opcode_messages`.

<a id="ui"></a>
### UI (`ui`)
- 1,097 composed screens, 32,894 PickGliss styles, 12,716 pt-BR texts.
- **DB:** `client.screens`, `client.ui_styles`, `client.localized_texts`.

---

<a id="data-issues"></a>
## 9. Known data issues

Logged in `meta.load_issues` (the original value is kept in `raw.template_records`):
- `PawnTempInfos.DefaultSkill` 1/2 (352 soldiers) and `ArtifactTemplateInfos.Skills` 12501.. do not exist in `SkillTempInfos`.
- `ComposeTempInfos.NewMaterial` points to non-items in 179 recipes.
- `SkillTempInfos.OwnRequirements` sometimes holds guild-requirement text.
- `TheseusPvpIntegralTmpls` has the range "-299,200" (should be "-299,-200").
- `ConsortiaWarQuestTemplates`: the client reads `Param1/2`, the XML has `Para1/2`.
- The client loads `"TheseusMultiPvpIntegralTmpl"` without the "s" (`TempleteManager.as:1400`).
- The CDN manifest is partial: only 66 of ~350 effects and ~80% of mounts/fashion items have a listed file.
