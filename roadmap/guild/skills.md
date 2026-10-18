# Guild technologies and skills (economy module)

Scope: guild level research of skills in the Torre de Habilidades (Instituto de Habilidades building, types 6..21), personal learning of those skills (common and advanced), and the master skills (types 22..25) researched and learned in the Torre de Habilidade de Mestre. Buildings themselves are in `buildings.md`; currencies in `funds.md`.

Path aliases:

| Alias | File |
|---|---|
| CSOM | `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as` |
| CM | `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as` |
| CC | `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as` |
| CMOD | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as` |
| CINFO | `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaInfo.as` |
| CSH | `decompiled/core_module/scripts/yishi/utils/ConsortiaSkillHelper.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| PI | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as` |
| V | `decompiled/m6/scripts/consortia/view/myConsortia/` |

## Overview

Two level tracks exist for every skill type:
- Guild level (research): bought once for the whole guild with guild wealth (types 6..21) or guild production (master types 22..25). It is a cap.
- Personal level (learning): each member raises his own level up to the guild level, paying personal contribution (common skills), the item "Poção Invisível" 208040 (advanced skills) or personal merit (master skills). Personal levels are player attributes that give stat bonuses via effect templates 3001..3019.

Entry points:
- Building map "Torre de Habilidades" -> `consortia.ConsortiaResearchSkillFrame` (`V/newui/ConsortiaBuildingView.as:290-295`).
- Research frame "Aprender" -> `CC.showSkillFrame(2)` -> openType 5 `consortia.ConsortiaStudySkillFrame` (`V/skill/ConsortiaResearchSkillFrame.as:158-163`, `CC:395-399`, `CC:233-236`).
- Task trace tip type 48 when lord level >= 13 and `CM.checkConsortiaSkillByGrade()` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:2865-2868`, `CM:1313-1361`); the tip opens openType 5 (`decompiled/m16/scripts/tasktracetip/view/ConsortiaSkillTipView.as:43`).
- Building map master church -> `CC.showMasterSkillFrame(4)` -> openType 8 `consortia.ConsortiaSkillSchoolFrame` (`V/newui/ConsortiaBuildingView.as:248-252`, `CC:401-405`, `CC:245-248`).

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/skill/ConsortiaResearchSkillFrame.as` | "Torre de Habilidades Nv. {0}" (`:61`) | Guild research list, tip "Obs: Habilidades da Guilda precisam ser pesquisados aqui antes de serem aprendidos." | Building map | `baseSkillList` built by `CC.getShowSkills` (`CC:926-958`): every skill unlocked by Instituto levels 1..10 plus the skills of `schoolLevel+1` flagged `isNext` |
| `V/skill/ConsortiaResearchSkillItem.as` | button "Pesquisar" | One research row | research frame | next level name and "Consumo de fortuna" + `NeedOffer` (`:151-164`); grey with "Necessita Torre Nv. {0}" when `schoolLevel < PreTemplate.Levels` (`:166-190`) |
| `V/skill/ConsortiaStudySkillFrame.as` | "Habilidade da Guilda" (`:108`) | Personal learning, tab 0 common skills, tab 1 advanced skills; right panel lists owned skills | research frame, tip 48 | own contribution (tab 0) or count of item 208040 in bag 1 (tab 1) (`:286-308`) |
| `V/skill/ConsortiaSkillItem.as` | button "Aprender" | One learnable skill | study frame | name + level, cost "Consumo de pontos de contribuição:  {0}" (common, `NeedOffer`) or "Consumo de poção invisível:  {0}" (advanced, `Property2`) (`:219-244`); greyed with "É preciso ser pesquisado na Torre de Habilidades para poder aprender" when guild level < next level (`:110-129`) |
| `V/skill/ConsortiaOwnSkillItem.as` | | Owned skill row | study frame | level per type (`:81-86`) |
| `V/ConsortiaSkillSchoolFrame.as` | "Torre de habilidade de mestre" (`:121`) | Master skills, tab 1 research (guild), tab 2 learn (personal) (`:101-104`) | master church | |
| `V/newui/ConsortiaSkillSchoolView.as` | | Master skill detail with 4 icons per page from `masterSkillTempAry` (types 22..25, `CMOD:190`, `CMOD:391-399`) | school frame | tab 1: guild level, `NeedOffer` in production, cooldown; tab 2: personal level, `Property2` merit (`:255-303`) |
| `V/item/ConsortiaSkillNewItem.as` | | Master skill icon | school view | level by tab (`:81-91`) |

## Actions

### A1. Research a guild skill (types 6..21)
- UI: "Pesquisar" (`V/skill/ConsortiaResearchSkillItem.as:103-112`).
- Client checks: button enabled only with right 2 `UPDATESKILL` and guild level < 10 (`:192-203`); hidden when Instituto level < prerequisite (`:166-190`); `nextTemplateInfo.NeedOffer > offer` -> confirm "Fortuna da Guilda insuficiente, acrescentar fortuna?" which opens donation (`CSH.addWealth`, `CSH:91-99`).
- Client path: `CC.consortiaUpgrade(ConsortiaTemplete)` uses `Types` (`CC:744-754`) -> `CSOM.consortiaUpgrade` (`CSOM:95-101`).
- Route: send 5133 (0x140d) `U_C_CONSORTIA_LEVEL`; `ConsortiaMsg.upgrade_type` (#5, INT32) = skill type.
- Response: no handler for 43. Server pushes 164 (0x00a4) `U_CH_CONSORTIA_FRESHINFO` to all online members with the raised guild level field (S1); `CM.__refreshConsortiaInfo` calls `model.updataResearchSkill()` (`CM:574`, `CMOD:864-870`) which refreshes the rows.

### A2. Learn a common or advanced skill (personal)
- UI: "Aprender" (`V/skill/ConsortiaSkillItem.as:180-184`) visible only when guild level >= next personal level (`:110-129`), enabled when personal level != 10 (`:207-217`).
- Client path: `CC.consortiaStudy(nextTemplateInfo)` (`CC:1001-1008`) -> `CC.ifCanUpdata` (`CC:1010-1040`):
  1. personal level >= 10 -> "Valor máximo atingido".
  2. common (`isCommonSkill`: types 6,8,9,10,11,12, `CC:1042-1059`): template of personal level+1 `NeedOffer > consortiaOffer` -> confirm "Contribuição da Guilda insuficiente, acrescentar contribuição?" (`CSH.addOffer`, `CSH:81-89`).
  3. advanced (13..21): `Property2 >` count of item 208040 in bag 1 (`CMOD:24`) -> "Os Items na Mochila necessários não são suficientes".
- Then `CSOM.consortiaStudy(type, skillType)` (`CSOM:141-148`) with `skillType = 0` common, `1` advanced (`CC:1003`).
- Route: send 5147 (0x141b) `U_C_CONSORTIA_LEARN`.
- Message `ConsortiaMsg`: `study_skill` (#6, INT32) = skill type; `skill_type` (#20, INT32) = 0 common, 1 advanced, 2 master.
- Response: no handler for 48 `U_C_CONSORTIA_LEARN`. Server pushes 3 (0x0003) `U_C_PLAYER_INFO` with the changed personal level field and `consortia_offer` (S2); for advanced skills also 115 (0x0073) `U_C_BAG_MOVE_UPDATE` for the consumed 208040. The `PlayerInfo` setter dispatches `CONSORTIA_STUDY` when the new level is 1 and `CONSORTIA_STUDY_UPGRADE` otherwise (`PI:883-893`), which refreshes the study frame (`V/skill/ConsortiaStudySkillFrame.as:405-454`) and the top bar.

### A3. Research a master skill (types 22..25)
- UI: tab 1 "research" `_researchBtn` (`V/newui/ConsortiaSkillSchoolView.as:235-253`), visible with right 3 `UPDATEBUILDING` (not 44), enabled when guild master level < 10 (`:268-279`).
- Client checks: `masterSkillResearchCd - now > 0` -> "Está em resfriamento de pesquisa, aguarde"; `consortiaAsset < NeedOffer` -> "Produção da guilda insuficiente".
- Client path: `CSOM.consortiaUpgrade(nextTemp.Types)` (`CSOM:95-101`).
- Route: send 5133 (0x140d), `upgrade_type` = 22..25.
- Response: push 164 with `master_*_lv` and `master_skill_research_cd_end` (#76, INT64 milliseconds since epoch, client divides by 1000, `CM:562`). The alert "Pesquisa de habilidade mestre completada, vá à Escola de Habilidade e estude-a para que seja ativada" is a static label (`:270`).

### A4. Learn a master skill
- UI: tab 2 `_studyBtn` (`V/newui/ConsortiaSkillSchoolView.as:221-233`), enabled when personal level < guild level (`:291`).
- Client check: `model.reputation < nextTemp.Property2` -> "Mérito individual insuficiente".
- Client path: `CSOM.consortiaStudy(type, 2)` directly.
- Route: send 5147 (0x141b), `study_skill` = 22..25, `skill_type` = 2.
- Response: push 3 with `master_*_lv` (#147..#150) and push 180 (0x00b4) `U_C_CONSORTIA_USER_JOIN_INFO` with the new `reputation` (`CM:1163-1178`, see `quests.md`).

### A5. Skill hint (client only)
`CM.checkConsortiaSkillByGrade` (`CM:1313-1361`): over common types, counts `min(personal, guild)` levels (1 point for level 1, 2 points for level >= 2). Returns false when the sum >= 2; true when sum = 0, resources >= 200 and the guild researched any common skill; true when sum = 1 and resources >= 500. "Resources" = `max(consortiaOffer, gold/1000)`.

## Server messages

| Opcode | Name | Message | Client handler | Fields and meaning | When |
|---|---|---|---|---|---|
| 164 (0x00a4) / 4138 (0x102a) | `U_CH_CONSORTIA_FRESHINFO` / `U_C_CONSORTIA_INFO` | `ConsortiaInfoMsg` | `CM.__refreshConsortiaInfo` (`CM:457-577`) | guild skill levels: `attack_level` (#12) type 6, `defence_level` (#13) type 7 (no template), `agility_level` (#14) type 8, `ability_level` (#15) type 9, `captain_level` (#16) type 10, `gold_level` (#17) type 11, `physique_level` (#45) type 12, `new_power_lv` (#57) 13, `new_agility_lv` (#58) 14, `new_intellect_lv` (#59) 15, `new_physique_lv` (#60) 16, `fam_gp_lv` (#61) 17, `medal_lv` (#62) 18, `honor_lv` (#63) 19, `score_lv` (#64) 21, `master_power_lv` (#72) 22, `master_agility_lv` (#73) 23, `master_intellect_lv` (#74) 24, `master_physique_lv` (#75) 25, `master_skill_research_cd_end` (#76, INT64 ms), `school_level` (#11), `master_school_lv` (#78), `offer` (#20), `consortia_asset` (#71) | Push to all online members after A1 or A3 |
| 3 (0x0003) | `U_C_PLAYER_INFO` | `PlayerMsg` | `PM.__uPlayerInfoHandler` (`PM:496`) | personal levels: `consortia_attack` (#24) type 6 (`PM:895`), `consortia_defence` (#25) 7, `consortia_agility` (#26) 8, `consortia_ability` (#27) 9, `consortia_captain` (#28) 10, `consortia_gold` (#38) 11 (`PM:1043`), `consortia_physique` (#39) 12 (`PM:1048`), `new_power_lv` (#99) .. `new_physique_lv` (#102) 13..16, `fam_gp_lv` (#103) 17, `medal_lv` (#104) 18, `honor_lv` (#105) 19, `property_lv` (#106) 21 (`PM:943`), `master_power_lv` (#147) .. `master_physique_lv` (#150) 22..25; `consortia_offer` (#19) | After A2/A4 to the learner; also on login |
| 180 (0x00b4) | `U_C_CONSORTIA_USER_JOIN_INFO` | `ConsortiaUserJoinMsg` | `CM.__userJoinInfoUpdateHandler` (`CM:1163-1207`) | `reputation` (#3) personal merit | After A4 |
| 115 (0x0073) | `U_C_BAG_MOVE_UPDATE` | `ItemMovedListMsg` | `GoodsManager.__bagUpdateHandler` (`decompiled/core_module/scripts/yishi/manager/GoodsManager.as:101`) | removed/updated 208040 stack | After advanced A2 |

Personal level mapping in the client: `CSH.getLevelByType` (`CSH:15-79`); guild level mapping: `CINFO.getLevelByUpgradeType` (`CINFO:265-319`).

## Rules and formulas

Data from `raw/xml/tempinfos/ConsortiaLevelInfos.xml` (`BuildingType` 3 for 6..21, 5 for 22..25):

| Type | `LevelName` | Category | Unlocked by | Research cost Lv1..Lv10 (`NeedOffer`) | Learning cost Lv1..Lv10 | Effect (`Property1` effect id, `raw/xml/tempinfos/EffectTempInfos.xml`) |
|---|---|---|---|---|---|---|
| 6 | Ganho de Força | common | Instituto Lv1 (pre 401..410) | wealth 200, 500, 1000, 2000, 3000, 4000, 5000, 6000, 8000, 10000 | same values in personal contribution | 3001 Força +40 per level |
| 8 | Ganho de Proteção | common | same | same | same | 3002 Proteção +40 |
| 9 | Ganho de Inteligência | common | same | same | same | 3003 Inteligência +40 |
| 10 | Ganho de Liderança | common | same | same | same | 3004 Liderança +20 |
| 11 | Ganho de Ouro | common | same | wealth 20, 50, 100, 200, 300, 400, 500, 600, 800, 1000 | same in contribution | 3005 gold production +1% |
| 12 | Ganho de Físico | common | same | as type 6 | as type 6 | 3006 Físico +40 |
| 13 | Força do Herói | advanced | Instituto Lv6..10 (pre 406,407,408,409,410,410...) | wealth 2000, 5000, 10000, 20000, 30000, 40000, 50000, 60000, 80000, 100000 | item 208040 "Poção Invisível": 200, 400, 800, 1600, 3200, 6400, 12800, 25600, 51200, 102400 (`Property2`) | 3007 Força +40 |
| 14 | Proteção Avançada | advanced | same | same | same | 3008 |
| 15 | Inteligência Avançada | advanced | same | same | same | 3009 |
| 16 | Físico Avançado | advanced | same | same | same | 3010 |
| 17 | Ganho do Eremitério | advanced | same | same | same | 3011 Eremitério EXP +2% |
| 18 | Ganhos de Medalha | advanced | same | same | same | 3012 Defesa de Guilda medals +46 |
| 19 | Ganhos de Fama | advanced | same | same | same | 3013 Defesa de Guilda honor +46 |
| 21 | Domínio do Diabo | advanced | same | same | same | 3015 guild boss combat attributes +1% |
| 22 | Força de Mestre | master | Lv1 no prerequisite, then previous level | production 1000, 2000, 3000, 4000, 5000, 7500, 10000, 15000, 20000, 25000 | merit 200, 500, 1000, 2000, 3000, 4000, 5000, 6000, 8000, 10000 | 3016 Força +100 |
| 23 | Proteção de Mestre | master | same | same | same | 3017 |
| 24 | Inteligência de Mestre | master | same | same | same | 3018 |
| 25 | Físico de Mestre | master | same | same | same | 3019 |

- Type 7 and type 20 have no template rows (effect 3014 exists but is unused); keep the columns, never allow research.
- Research prerequisite for 6..21: Instituto level >= `Levels` of the row `PreTemplateId` (`V/skill/ConsortiaResearchSkillItem.as:166-190`); for advanced skills Lv5..Lv10 the prerequisite stays Instituto 10.
- Research permission: right 2 for 6..21 (`ConsortiaResearchSkillItem.as:194`), right 3 for 22..25 (`ConsortiaSkillSchoolView.as:276`).
- Research cost currency: wealth `offer` for 6..21, production `consortiaAsset` for 22..25.
- Master research cooldown: `master_skill_research_cd_end` must be in the past; after a research the server sets a new end time (assumption: duration = Torre de Habilidade de Mestre `Property1` at its current level, 2520 at Lv0 down to 720 at Lv10; unit unknown).
- Personal cap: personal level < guild level for the same type (`ConsortiaSkillItem.as:93-129`, `ConsortiaSkillSchoolView.as:291`); hard cap 10.
- Learning cost template = row for (type, personal level + 1).
- Display effect per level: the effect value is multiplied by the level (descriptions show the per level increment); stat application belongs to the combat/attribute module (cross dependency).

## Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/ConsortiaLevelInfos.xml` | rows types 6..25 as above; `Icon` loaded by `IconFactory.getTecIconByIcon` |
| `raw/xml/tempinfos/EffectTempInfos.xml` | `TemplateId` 3001..3019, `PropertyType1`, `Property1` per level |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208040 "Poção Invisível" (`MaxCount` 99999), sold in the advanced guild shop (ShopType 17, `shop.md`) |

## Persistent state

```sql
CREATE TABLE guild.guild_tech (
  guild_id  INTEGER   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
  tech_type SMALLINT NOT NULL CHECK (tech_type BETWEEN 6 AND 25 AND tech_type NOT IN (7,20)),
  level     SMALLINT NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 10),
  PRIMARY KEY (guild_id, tech_type)
);

CREATE TABLE guild.member_skill (
  player_id  INTEGER   NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
  skill_type SMALLINT NOT NULL CHECK (skill_type BETWEEN 6 AND 25 AND skill_type NOT IN (7,20)),
  level      SMALLINT NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 10),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, skill_type)
);

ALTER TABLE guild.guild ADD COLUMN master_research_cd_end TIMESTAMPTZ;
```

## Backend implementation notes

- `guild::skills::handle_research` (5133 with `upgrade_type` 6..25; routed from `guild::buildings::handle_upgrade`).
- `guild::skills::handle_learn` (5147).

Validation order for research: in guild -> type has templates -> permission (right 2 for 6..21, right 3 for 22..25) -> guild level < 10 -> prerequisite (Instituto level for 6..21, previous level implied for 22..25) -> for 22..25 cooldown elapsed -> balance (wealth or production) >= `NeedOffer`. Transaction: `guild::funds::spend_fortune` (6..21) or `guild::funds::spend_asset` (22..25), increment `guild_tech`, set `master_research_cd_end` for 22..25, insert guild event (core module), commit; push 164 to all online members.

Validation order for learn: in guild -> `skill_type` matches the category of `study_skill` (0 for 6,8..12; 1 for 13..21; 2 for 22..25) -> personal level < 10 -> personal level < guild level -> cost (`guild.member.contribution` via `guild::funds::spend_contribution`, item 208040 count in bag 1, or `guild.member.merit` via `guild::funds::spend_merit`) -> deduct -> increment `member_skill`. Push 3 (level + contribution), 115 (item), 180 (merit) to the learner only. Recompute fighting capacity in the attribute module.

## Open questions

- Unit and source of the master research cooldown (Torre de Mestre `Property1` 2520..720: seconds or minutes).
- Whether personal skill levels stay active after leaving the guild (client keeps them in `PlayerInfo`; nothing resets them in `CM.__consortiaStageChange`).
- Exact semantics of `skill_type` when the client sends a mismatch (server should reject).
- Type 7 `defence_level` and `consortia_defence` exist in the protocol but no template; keep 0.

## Implementation checklist

- [ ] Client screen: ConsortiaResearchSkillFrame lists research rows from `CC.getShowSkills`
- [ ] Client screen: ConsortiaStudySkillFrame common and advanced tabs
- [ ] Client screen: ConsortiaSkillSchoolFrame research and learn tabs with cooldown
- [ ] Table `guild.guild_tech`
- [ ] Table `guild.member_skill`
- [ ] Column `guild.guild.master_research_cd_end`
- [ ] Handler `guild::skills::handle_research` (5133 types 6..25 -> push 164)
- [ ] Handler `guild::skills::handle_learn` (5147 -> 3, 115, 180)
- [ ] `PlayerMsg` encoder for fields #24..#28, #38, #39, #99..#106, #147..#150
- [ ] `ConsortiaInfoMsg` encoder for skill level fields and #76
- [ ] Attribute module hook: apply effects 3001..3019 by personal level
