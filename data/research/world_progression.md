# World, economy, progression, social and activities (Legend Online BR)

This document describes the game systems outside battle: the castle and its economy, maps and campaigns, exploration
modes, quests, shops and the guild, PvP, bosses, rankings, social systems, seasonal events, drop tables, a summary of
every system and the client-side formulas. It is research on the decompiled client (read-only). The structured
counterpart is [data/research/world_progression.json](../../data/research/world_progression.json) (1912 fields,
165 enums, 118 systems, 99 formulas). Battle mechanics, skills and items are covered in
[units_combat.md](../../docs/mechanics/units_combat.md), [skills_buffs.md](../../docs/mechanics/skills_buffs.md) and
[items_avatar.md](../../docs/mechanics/items_avatar.md); the index is [README.md](../../docs/mechanics/README.md).

**Conventions**

- `file.as:line` references are relative to the project root.
- Screens and managers are already covered in [docs/ui/screens.md](../../docs/ui/screens.md) and
  [docs/client/managers.md](../../docs/client/managers.md); graphics in [docs/client/graphics.md](../../docs/client/graphics.md) (§4 maps).
- Values marked *(assumption)* were inferred from data, not code.
- Items with a negative `TemplateId` are virtual currencies (enum `virtual_currency_item`).
- Templates load in `decompiled/core_module/scripts/yishi/manager/TempleteManager.as` via `getXmlListByName("<Set>")`.
- The client only displays; rolls, costs and validation are server-side.

## Contents

- [1. Castle, economy and backyard systems](#1-castle-economy-and-backyard-systems)
  - [1.1 Castle buildings (`BuildingTempInfos`)](#11-castle-buildings-buildingtempinfos)
  - [1.2 Build queue and activity queues](#12-build-queue-and-activity-queues)
  - [1.3 Santuário technologies (castle research)](#13-santuário-technologies-castle-research)
  - [1.4 Player resources and production](#14-player-resources-and-production)
  - [1.5 Tax collection (Prefeitura)](#15-tax-collection-prefeitura)
  - [1.6 Transmissor and castle relocation](#16-transmissor-and-castle-relocation)
  - [1.7 Wild lands and outer-map objects (`MapPhysicsTempInfos`)](#17-wild-lands-and-outer-map-objects-mapphysicstempinfos)
  - [1.8 Progression curves (`UpGradeTempInfos`)](#18-progression-curves-upgradetempinfos)
  - [1.9 Global settings (`ConfigInfos`)](#19-global-settings-configinfos)
  - [1.10 Effects summary (`EffectTempInfos`)](#110-effects-summary-effecttempinfos)
  - [1.11 Soldier special skill (`SpecialTempInfos`)](#111-soldier-special-skill-specialtempinfos)
  - [1.12 Top event bar (`TopToolBtnInfos`)](#112-top-event-bar-toptoolbtninfos)
  - [1.13 Social sharing (`ShareTemplateInfos`)](#113-social-sharing-sharetemplateinfos)
  - [1.14 Returning players (`RegressTemplateInfos`) and Regresso do Rei (`OlderRefluxTempInfos`)](#114-returning-players-regresstemplateinfos-and-regresso-do-rei-olderrefluxtempinfos)
  - [1.15 Pequeno Secretário (`AssistantTemplates`)](#115-pequeno-secretário-assistanttemplates)
  - [1.16 First recharge (`FirstPayTemplates`, `FirstChargeItems`)](#116-first-recharge-firstpaytemplates-firstchargeitems)
  - [1.17 Questionnaire (`QuestionTemplates`)](#117-questionnaire-questiontemplates)
  - [1.18 Guide values (`GuideValueTemps`)](#118-guide-values-guidevaluetemps)
  - [1.19 Fishing (`FishTemplateInfos`)](#119-fishing-fishtemplateinfos)
  - [1.20 Marriage: `MarrySpecTempInfos`, `HeartTempInfos` (m9/marry)](#120-marriage-marryspectempinfos-hearttempinfos-m9marry)
  - [1.21 Residence and furniture (`FurnitureTempInfos`)](#121-residence-and-furniture-furnituretempinfos)
  - [1.22 Archaeology: `ArchaeologyItemTemps`, `ArchaeologyBookTemps` (m14/archaeology)](#122-archaeology-archaeologyitemtemps-archaeologybooktemps-m14archaeology)
  - [1.23 Alchemy Workshop: `AlchemyMineTemplates`, `AlchemyFormulaTemplates` (m14/alchemical)](#123-alchemy-workshop-alchemyminetemplates-alchemyformulatemplates-m14alchemical)
  - [1.24 Fonte Mágica: `MagicSpringTempInfos` (m11/magicspring)](#124-fonte-mágica-magicspringtempinfos-m11magicspring)
  - [1.25 Portal do Tempo: `ShuttleTempInfos`, `ShuttleRewardTempInfos` (m11/outyard/shuttle)](#125-portal-do-tempo-shuttletempinfos-shuttlerewardtempinfos-m11outyardshuttle)
  - [1.26 Bar da Fantasia: `MagicPubNpcInfos`, `MagicPubChatInfos` (m11/magicpub)](#126-bar-da-fantasia-magicpubnpcinfos-magicpubchatinfos-m11magicpub)
  - [1.27 Castle opcodes](#127-castle-opcodes)
- [2. Maps, campaigns and map PvE modes](#2-maps-campaigns-and-map-pve-modes)
  - [2.1 Maps (`MapInfos`): world, instances and Reino do Céu](#21-maps-mapinfos-world-instances-and-reino-do-céu)
  - [2.2 Reino do Céu nodes and NPCs (`MapNodeInfos`)](#22-reino-do-céu-nodes-and-npcs-mapnodeinfos)
  - [2.3 Campaigns and PvE instances (`Campaigns`)](#23-campaigns-and-pve-instances-campaigns)
  - [2.4 Energy (Vigor, "weary") and sweep](#24-energy-vigor-weary-and-sweep)
  - [2.5 Solo trail campaign (`SingleCampaignDatas`)](#25-solo-trail-campaign-singlecampaigndatas)
  - [2.6 Campaign data (`CampaignData`, 0 rows)](#26-campaign-data-campaigndata-0-rows)
  - [2.7 Campaign buffs (`CampaignBufferTemps`)](#27-campaign-buffs-campaignbuffertemps)
  - [2.8 Caminho do Céu (`SkyTrial*`)](#28-caminho-do-céu-skytrial)
  - [2.9 Labirinto Negro (`DarkMaze*`)](#29-labirinto-negro-darkmaze)
  - [2.10 Caminho Final (`FinalRoad*`)](#210-caminho-final-finalroad)
  - [2.11 Guerra dos Planos (`Planes*`)](#211-guerra-dos-planos-planes)
  - [2.12 Crise dos Planos (`CrisisMapInfos`, `CrisisEventInfos`)](#212-crise-dos-planos-crisismapinfos-crisiseventinfos)
- [3. Exploration modes](#3-exploration-modes)
  - [3.1 Labirinto de Minos (guild): `MinosLevelTmpls`, `MinosNodeTmpls`, `MinosRewardTmpls`](#31-labirinto-de-minos-guild-minosleveltmpls-minosnodetmpls-minosrewardtmpls)
  - [3.2 Expedição do Eremitério (秘境探险): `SecretMapLevelTemplates`, `SecretSonLevelTemplates`, `SecretMapDataTemplates`, `SecretEventTemplates`](#32-expedição-do-eremitério-秘境探险-secretmapleveltemplates-secretsonleveltemplates-secretmapdatatemplates-secreteventtemplates)
  - [3.3 Desafio de Teseus (秘宝探险, StoreHouse): `StoreHouseChapterTmpls`, `StoreHouseMapTmpls`](#33-desafio-de-teseus-秘宝探险-storehouse-storehousechaptertmpls-storehousemaptmpls)
  - [3.4 Exploração das Ruínas (遗迹探险): `RemainsExploreChapterTemps`, `RemainsExploreNodeTemps`, `RemainsExploreEventTemps`, `RemainsLeedTemps`](#34-exploração-das-ruínas-遗迹探险-remainsexplorechaptertemps-remainsexplorenodetemps-remainsexploreeventtemps-remainsleedtemps)
  - [3.5 Terra Sombria (暗影之地): `ShadowLandTemplates`](#35-terra-sombria-暗影之地-shadowlandtemplates)
  - [3.6 Expedição dos Espíritos Protetores (护灵远征): `ExpeditionTemplates`](#36-expedição-dos-espíritos-protetores-护灵远征-expeditiontemplates)
  - [3.7 Histórico de Conquistas (HeroRoad): `HeroRoadTempInfos`](#37-histórico-de-conquistas-heroroad-heroroadtempinfos)
  - [3.8 Continente dos Demônios (EvilLand, 恶魔大陆): `EvilLandTemplates`](#38-continente-dos-demônios-evilland-恶魔大陆-evillandtemplates)
  - [3.9 Caminho da Vingança (复仇之路): `RevengeRoadTemplates`](#39-caminho-da-vingança-复仇之路-revengeroadtemplates)
  - [3.10 Luta da Terralém and Casos da Terralém (HugeHead/StackHead, 外域): `HugeHeadMapNodeTempInfos`, `StackHeadExploreTempInfos`](#310-luta-da-terralém-and-casos-da-terralém-hugeheadstackhead-外域-hugeheadmapnodetempinfos-stackheadexploretempinfos)
  - [3.11 Legacy Eremitério with sacred power: `ExploreEventTemplates`](#311-legacy-eremitério-with-sacred-power-exploreeventtemplates)
  - [3.12 Jardim Suspenso (空中花园): `AirGardenNodeTemplates`](#312-jardim-suspenso-空中花园-airgardennodetemplates)
  - [3.13 Exploração Espaço-Tempo (时空探险, StarArea): `StarAreaRoadInfos`](#313-exploração-espaço-tempo-时空探险-stararea-stararearoadinfos)
  - [3.14 Caminho da Glória buffs (`GloryRoadBufferInfos`)](#314-caminho-da-glória-buffs-gloryroadbufferinfos)
  - [3.15 General references](#315-general-references)
- [4. Quests, rewards and activities](#4-quests-rewards-and-activities)
  - [4.1 Quests: "Missão" panel (`QuestTemps`, `QuestCondictionInfos`, `QuestGoods`)](#41-quests-missão-panel-questtemps-questcondictioninfos-questgoods)
  - [4.2 Quest conditions (`task_condition_type`)](#42-quest-conditions-task_condition_type)
  - [4.3 Bounty board: Caçador de Recompensas (`RewardTemps` Type 0, `RewardCondictionInfos`)](#43-bounty-board-caçador-de-recompensas-rewardtemps-type-0-rewardcondictioninfos)
  - [4.4 Missão de Ciclo (`RewardTemps` Type 1/2/3, `RewardGoods`)](#44-missão-de-ciclo-rewardtemps-type-123-rewardgoods)
  - [4.5 Marriage and Crepúsculo dos Deuses quests (`RewardTemps` Type 4/5/6)](#45-marriage-and-crepúsculo-dos-deuses-quests-rewardtemps-type-456)
  - [4.6 Guild quests (`ConsortiaQuestTempInfos`, `ConsortiaQuestConditionTempInfos`)](#46-guild-quests-consortiaquesttempinfos-consortiaquestconditiontempinfos)
  - [4.7 Slate quests: Godhead/Theseus (`SlateTaskTmpls`)](#47-slate-quests-godheadtheseus-slatetasktmpls)
  - [4.8 Navigation port tasks (`NavigationTaskTempInfos`)](#48-navigation-port-tasks-navigationtasktempinfos)
  - [4.9 Achievements: Histórico de Conquistas / Hero's Road (`AchievementTaskTemplates`)](#49-achievements-histórico-de-conquistas--heros-road-achievementtasktemplates)
  - [4.10 Activity points: Pontos de Atividade (`ActivityDailyTemplates`)](#410-activity-points-pontos-de-atividade-activitydailytemplates)
  - [4.11 Guide quests: "Objetivo dos 7 dias" (`guide_task_type`)](#411-guide-quests-objetivo-dos-7-dias-guide_task_type)
- [5. Shops, auction and guild](#5-shops-auction-and-guild)
  - [5.1 Shops: general structure (`ShopTempInfos`)](#51-shops-general-structure-shoptempinfos)
  - [5.2 Guild shops (ShopType 2/17/1009/1014/1024/1029/1030)](#52-guild-shops-shoptype-21710091014102410291030)
  - [5.3 Guild levels, buildings and skills (`ConsortiaLevelInfos`)](#53-guild-levels-buildings-and-skills-consortialevelinfos)
  - [5.4 Guild ranks, permissions and contribution](#54-guild-ranks-permissions-and-contribution)
  - [5.5 Câmara de Comércio (`ConsortiaShopTempInfos`, `CommerceShopTemplates`)](#55-câmara-de-comércio-consortiashoptempinfos-commerceshoptemplates)
  - [5.6 Guild Treasure (`ConsortiaTreasureTempInfos`)](#56-guild-treasure-consortiatreasuretempinfos)
  - [5.7 Guild campaigns (`ConsortiaPveTemplates`)](#57-guild-campaigns-consortiapvetemplates)
  - [5.8 Terra dos Sonhos: old guild boss (`ConsortiaBossTempInfos`)](#58-terra-dos-sonhos-old-guild-boss-consortiabosstempinfos)
  - [5.9 New Guild Boss (`ConsortiaNewBossTemplates`)](#59-new-guild-boss-consortianewbosstemplates)
  - [5.10 Guild Defense / guild war (`ConsortiaWarQuestTemplates`)](#510-guild-defense--guild-war-consortiawarquesttemplates)
  - [5.11 Duelo Tático: guild chess (`m3/consortiachess`)](#511-duelo-tático-guild-chess-m3consortiachess)
  - [5.12 Supremacia do Legend: auto chess (`AutoChessHeroInfos`, `AutoChessBuffInfos`)](#512-supremacia-do-legend-auto-chess-autochessheroinfos-autochessbuffinfos)
  - [5.13 Return / Alliance Contract (`Alliance*`)](#513-return--alliance-contract-alliance)
  - [5.14 Outer-city Loja Misteriosa (`MapShopItemTemplateInfos`, m7 `outercityshop`)](#514-outer-city-loja-misteriosa-mapshopitemtemplateinfos-m7-outercityshop)
  - [5.15 Auction house (m7 `auction`, no template set)](#515-auction-house-m7-auction-no-template-set)
  - [5.16 Standalone shops: Navigation, Game Box, Poseidon, Merit, Furniture](#516-standalone-shops-navigation-game-box-poseidon-merit-furniture)
- [6. PvP, bosses, ranking and social](#6-pvp-bosses-ranking-and-social)
  - [6.1 Theseus Dungeon (Masmorra de Teseu): `TheseusDungeonEventTemplates`, `TheseusDungeonTaskTemplates`](#61-theseus-dungeon-masmorra-de-teseu-theseusdungeoneventtemplates-theseusdungeontasktemplates)
  - [6.2 Theseus Tower (Torre de Teseu): `TheseusTowerTmpls`](#62-theseus-tower-torre-de-teseu-theseustowertmpls)
  - [6.3 Theseus Arena (Arena de Teseu, 1v1) and Theseus Multiplayer Arena (Arena Multiplayer de Teseu): `TheseusPvp*`, `TheseusMultiPvp*`](#63-theseus-arena-arena-de-teseu-1v1-and-theseus-multiplayer-arena-arena-multiplayer-de-teseu-theseuspvp-theseusmultipvp)
  - [6.4 Protection Spirit Arena (Arena do Espírito de Proteção): `ChildPvp` / `ChildNswar`](#64-protection-spirit-arena-arena-do-espírito-de-proteção-childpvp--childnswar)
  - [6.5 Lord Trial (Julgamento Principal): `LordTrialTempInfos`](#65-lord-trial-julgamento-principal-lordtrialtempinfos)
  - [6.6 Ecliptic Palace (Palácio Zodiacal): `EclipticPalaceTempInfos`](#66-ecliptic-palace-palácio-zodiacal-eclipticpalacetempinfos)
  - [6.7 Dream Arena (Arena Ilusória): `DreamArenaTemplates`](#67-dream-arena-arena-ilusória-dreamarenatemplates)
  - [6.8 Monster Explore (Exploração de Monstros): `MonsterExploreDrop`](#68-monster-explore-exploração-de-monstros-monsterexploredrop)
  - [6.9 Forbidden Boss (Chefão da Zona Proibida): `ForbiddenBossTemplates`](#69-forbidden-boss-chefão-da-zona-proibida-forbiddenbosstemplates)
  - [6.10 Royalty Road (Caminho da Realeza / Chefão da Realeza): `RoyaltyBossTemplates`, `RoyaltyTemplates`](#610-royalty-road-caminho-da-realeza--chefão-da-realeza-royaltybosstemplates-royaltytemplates)
  - [6.11 Calabouço Aleatório buff shop: `RandomBossBuffInfos`](#611-calabouço-aleatório-buff-shop-randombossbuffinfos)
  - [6.12 World Boss (no template set in this group)](#612-world-boss-no-template-set-in-this-group)
  - [6.13 Game Hall (Salão de jogo): `GameHallTemplates`](#613-game-hall-salão-de-jogo-gamehalltemplates)
  - [6.14 Colosseum (Coliseu)](#614-colosseum-coliseu)
  - [6.15 Apex League (Liga do Pico)](#615-apex-league-liga-do-pico)
  - [6.16 Rooms, friends, mail, marriage and rankings](#616-rooms-friends-mail-marriage-and-rankings)
- [7. Seasonal events and rewards](#7-seasonal-events-and-rewards)
  - [7.1 Event time windows (calendar)](#71-event-time-windows-calendar)
  - [7.2 Easter Game Hall event: `EasterTemplates`](#72-easter-game-hall-event-eastertemplates)
  - [7.3 Christmas Party: `Christmas*`](#73-christmas-party-christmas)
  - [7.4 Carnival (Folia): `Carnival*`](#74-carnival-folia-carnival)
  - [7.5 7th Anniversary: `SevenYear*`](#75-7th-anniversary-sevenyear)
  - [7.6 War Soul Tower (Torre da Guerra): `WarSoulTower*`](#76-war-soul-tower-torre-da-guerra-warsoultower)
  - [7.7 Theseus Collection rewards: `CollectionRewardTemplates`](#77-theseus-collection-rewards-collectionrewardtemplates)
  - [7.8 Tiered special rewards: `SpecialRewardTmpls`](#78-tiered-special-rewards-specialrewardtmpls)
  - [7.9 Anniversary Celebration / YearEgg (code)](#79-anniversary-celebration--yearegg-code)
  - [7.10 Wanted Guardians (Guardiões Procurados, Guard PVE) and Abyss (Abismo, Guard Endless): `GuardPVETemp`](#710-wanted-guardians-guardiões-procurados-guard-pve-and-abyss-abismo-guard-endless-guardpvetemp)
  - [7.11 Einherjar League weekly prize: `PetChallengeRewards`](#711-einherjar-league-weekly-prize-petchallengerewards)
  - [7.12 Quick Pass (Passagem Rápida): `QuickPassRewards`](#712-quick-pass-passagem-rápida-quickpassrewards)
  - [7.13 Sky Trial (Caminho do Céu): `SkyOrderRewards`, `SkyRewards`](#713-sky-trial-caminho-do-céu-skyorderrewards-skyrewards)
  - [7.14 Time Vortex (Vórtice do Tempo): `TimeVortexRewards`](#714-time-vortex-vórtice-do-tempo-timevortexrewards)
  - [7.15 Unreal Hunt (Caça Fantástica) weekly prize: `UnrealWeekRewards`](#715-unreal-hunt-caça-fantástica-weekly-prize-unrealweekrewards)
  - [7.16 Astronomy / Stargazing (code)](#716-astronomy--stargazing-code)
- [8. Drops and reward packs](#8-drops-and-reward-packs)
  - [8.1 Drops and reward packs: common schema (`CommonDropTempInfo`)](#81-drops-and-reward-packs-common-schema-commondroptempinfo)
  - [8.2 Legacy schemas and empty sets](#82-legacy-schemas-and-empty-sets)
  - [8.3 Virtual currencies (`itemId` < 0)](#83-virtual-currencies-itemid--0)
  - [8.4 Drop and reward sets by activity](#84-drop-and-reward-sets-by-activity)
  - [8.5 Client consumers](#85-client-consumers)
- [9. Systems summary](#9-systems-summary)
- [10. Formulas](#10-formulas)
  - [10.1 Castle, buildings and resources](#101-castle-buildings-and-resources)
  - [10.2 Energy, campaigns and PvE modes](#102-energy-campaigns-and-pve-modes)
  - [10.3 Quests](#103-quests)
  - [10.4 Shops, guild and auction](#104-shops-guild-and-auction)
  - [10.5 Arenas, Theseus and boss modes](#105-arenas-theseus-and-boss-modes)
  - [10.6 Seasonal events](#106-seasonal-events)
  - [10.7 Towers, leagues and reward bands](#107-towers-leagues-and-reward-bands)

## 1. Castle, economy and backyard systems

This section covers the castle buildings and their research, player resources and production, the global configuration (`ConfigInfos`), the top event bar, and the side systems and minigames around the castle (fishing, marriage, residence, archaeology, alchemy, Fonte Mágica, Portal do Tempo, Bar da Fantasia).

### 1.1 Castle buildings (`BuildingTempInfos`)

The castle (scene `castle.CastleSceneView`, module m4; see [docs/ui/screens.md](../../docs/ui/screens.md) §m4) has buildings with 80 levels plus level-less "portals". Each `BuildingTempInfos` row is **one level** of a building, with `TemplateId = SonType*100 + level`. Player instances (`BuildInfo{buildingId, templateId, property1, property2}`) arrive in `U_C_LOAD_BUILD`/`U_C_BUILDINGINFO_LIST` (`BuildingInfoMsg{building_id, template_id, son_type, propterty1, propterty2}`) and are stored in `BuildingModel` (`decompiled/core_module/scripts/mvc/module/buildings/BuildingModel.as`).

| SonType | MasterType | pt-BR name | Levels | Prerequisite | Cost | Effect (`Property1`/activity) | Unlocks at (Leader level) |
|---|---|---|---|---|---|---|---|
| 901 | 9 politics | Prefeitura | 1-80 | Leader level = level (`PlayerGrades`) | gold 200 (lv2) to 324 760 (lv80); total 7 235 500 | gold/h 390 to 37 065 | initial (`Castle_Building=901,402`) |
| 402 | 4 military | Quartel | 1-80 | Prefeitura of the same level (90101...) | gold 130 to 302 180; total 6 259 040 | "Afeta o nível máximo dos soldados": `PawnTempInfos.NeedBuilding` = required Quartel TemplateId | initial |
| 501 | 5 technical | Santuário (Seminário) | 1-80 | Prefeitura of the same level | gold 10 to 308 460; total 6 415 700 | unlocks technologies (`NextTemplateId`) and caps their level | - |
| 1511 | 8 transfer | Transmissor | 1 | - | - | max energy 500 (`Property2`) | 15 |
| 1507 | 15 | Labirinto | 1 | - | - | portal to the Labyrinth (tower) | 12 |
| 1509 | 15 | Residência | 1 | - | - | portal to the farm/house | 12 |
| 1601 | 16 | Bar da Fantasia | 1 | - | - | portal to MagicPub | 32 |
| 1701 | 17 | Laboratório de Platina | 1 | - | - | portal to PerkinLab | 1st job transfer (class advancement) |
| 1801 | 18 | Mina (Ametista) | (no row) | - | - | portal | 25 |
| 13xx/14xx/23xx/24xx | 13/14 | technologies | 0-80 | Santuário | Cristal de Luz | see "Santuário technologies" (§1.3) | - |

- **Portal unlock levels:** `CastleBuildingView.isNotOpen()` (`decompiled/m4/scripts/castle/view/CastleBuildingView.as:469`).
- **Unused SonTypes:** 1501-1506, 1508 and 1510 exist in `BuildingType.as` (shop, hero gate, PvP, hook, vehicle, market, house, reward) but have no BR rows; 1501/1502/1503/1506/1508/1510 are treated as decoration (`isAdornment`, line 65).

**Upgrade rules** (`BuildingManager.isUpgradeAvaliable`, `decompiled/core_module/scripts/yishi/manager/BuildingManager.as:367`). An upgrade is available when:
- the building is not at max level (max = `NextGradeTemplateId=0`);
- the player has the **next** level's `GoldConsume`/`CrystalsConsume` (`ResourceManager.canSubtractResources`; gold and Cristal de Luz);
- the `PreTemplateId` prerequisites are met (`BuildingModel.getPreBuilding`, line 306: a comma-separated list; it compares the `BuildingGrade` of the existing building of the same SonType);
- the Leader level is ≥ the next level's `PlayerGrades` (line 419);
- a queue slot is free (`checkBuildList`, line 312).

**Create and upgrade.** A new building goes through `creatBuilding(sonType)`, which uses the lowest-level template (line 287) and sends `C_BUILDING_CREATE{sonType}`; an upgrade sends `C_BUILDING_UPGRADE{buildingId}` (`decompiled/core_module/scripts/managers/BuildingSocketOutManager.as:20,28`). The reply `U_C_BUILDINGINFO_LIST` fires `CREATE_NEW_BUILDING`/`BUILDING_UPGRADE_RECEIVE` and, for MasterType 13/14, `UPDATE_EXTRABUFFER` (line 161).

- **Upgrade time** (`UpgradeTime`, seconds added to the queue): 5 s up to lv20; lv21-34 rises 10,20,30,60,120...840; 900 s from lv35 on.
- **Quartel gold per level:** +120/level up to lv10, +310 (lv11-20), +1640 (lv21-29), +2640 (lv30-49), +5120 (lv50-59), +7080 (lv60-69), +10800 (lv70-80).

**Graphics.** `PicPath = "swf|classeView|classeEffect"` is loaded from `RESOURCE_PATH` (`decompiled/m4/scripts/castle/loader/CastleBuildingLoader.as:24`). Examples: `images/neizhengting.swf|neizhengting_view` (Prefeitura), `images/binyin.swf` (Quartel), `images/shenxueyuan.swf` (Santuário), `images/chuansong.swf` (Transmissor), `images/mofalvguan.swf`, `images/bojinshiyanshi.swf`, `images/wuxianta.swf`, `images/home.swf`. Icons: `/icon/building/*30.png`. Position: `PosX/PosY`; sign: `TitleX/TitleY` (`BuildingBase.as:129`). See [docs/client/graphics.md](../../docs/client/graphics.md).

**`BuildingResInfos`** (496 rows: per-level sprites 0-30 for 101 furnace, 301 warehouse, 402, 501, 601, 801, 901, 1001, 1101 market and 1201 houses; `PicPath images/mjl/cl-rz-mjl-ko15.png`, `FlashPath images/effect/jh.swf|jh_25`, `Depth`) is a legacy of the old castle: **no client references**.

### 1.2 Build queue and activity queues

`BuildingModel.setOrderList` (`decompiled/core_module/scripts/mvc/module/buildings/BuildingModel.as:102`) splits `OrderInfoMsg{order_id, order_type, remain_time, begin_time, need_time}` by type:
- **Structure queue** (`orderType=1`): starts with `Castle_Order=1` slot; max `buildOrderLimit=2` (line 56). The 2nd slot costs `Order_NeedPay=100` diamonds (`U_C_BUILDING_ORDERADD{payType}`, payType 0=diamond, 1=bound; `QueueBar.buyQueueItem`, `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:485`, requires allPoint ≥ 100). A queue is "busy" while `remainTime>0`.
- **Speed-up:** `U_C_BUILDING_ORDER_QUICK{orderId,index}` costs `ceil(remainTime/600)` diamonds (`Quick_Cool` `1,10`); free with active VIP (`QueueBar.coolItem`, line 598; `BuildingManager.get point`, line 357).
- **Activity queues** (`orderType=4`): the daily "x/y" counters in the QueueBar; enum `active_order_id` (1 Bênção da Guilda ... 16 Expedição do Espírito), sorted by `updateSortId`.

Opcodes: `8279 C_LOAD_BUILD_ORDER`, `4155 U_C_LOAD_BUILD_ORDER`, `4187 U_C_BUILDING_ORDER_SEND` (updates remainTime), `5172/102 U_C_BUILDING_ORDER_QUICK`, `5175/104 U_C_BUILDING_ORDERADD`, `151 U_C_BUILDING_ORDER_INFO`.

### 1.3 Santuário technologies (castle research)

Technologies are `BuildingTempInfos` rows with MasterType 13 (internal: gold) and 14 (military: attributes), from level 0 (not researched) to 80. The window `buildings.seminary.view.SeminaryFrame` (m4) lists the internal (`InternalTechnologyList.as:55`) and military (`MilitaryTechnologyList.as:61`) technologies. Its button fires `TEC_UPGRADE_CLICK` → `SeminaryFrameBottomView.__tecUpgradeHandler` (`decompiled/m4/scripts/buildings/seminary/view/SeminaryFrameBottomView.as:89`) → `C_BUILDING_UPGRADE` (or `C_BUILDING_CREATE` while still at level 0).
- **Cost:** **Cristal de Luz** only (`CrystalsConsume`; basic 50 to 32 100, total 858 850; advanced 250 to 160 500, total 4 294 250).
- **Requirement:** level N requires Santuário lvN (basic) or lv max(50,N) (advanced).
- **Effect:** `Property1` points to `EffectTempInfos`; bonus = `Effect.Property1 × level`, added to the "extra buff" (`ExtraBufferItem.as:234`). See also `BuildingModel.allExistTec` (line 442).

| SonType | Name | Effect (`EffectTempInfos`) | +per level | Unlocks at Santuário lv |
|---|---|---|---|---|
| 1304 | Produção de Ouro | 1104 (PropertyType 104) | 240 | 1 |
| 1420 | Vida do Soldado | 1120 (PropertyType 120) | 20 | 3 |
| 1421 | Ataque do Soldado | 1121 (PropertyType 121) | 24 | 5 |
| 1422 | Defesa do Soldado | 1122 (PropertyType 122) | 16 | 9 |
| 1423 | Magia do Soldado | 1123 (PropertyType 123) | 24 | 7 |
| 1424 | Resistência do Soldado | 1124 (PropertyType 124) | 16 | 11 |
| 1441 | Ataque Adicional | 1141 (PropertyType 141) | 48 | 4 |
| 1442 | Magia Adicional | 1142 (PropertyType 142) | 48 | 6 |
| 1443 | Defesa Adicional | 1143 (PropertyType 143) | 32 | 8 |
| 1444 | Resistência Adicional | 1144 (PropertyType 144) | 32 | 10 |
| 1445 | Vida Adicional | 1145 (PropertyType 145) | 80 | 2 |
| 1446 | Infantaria Adicional | 1146 (PropertyType 146) | 16 | 12 |
| 2304 | Produção de Ouro Avançado | 1204 (PropertyType 204) | 240 | 55 |
| 2420 | Vida do Soldado Avançado | 1220 (PropertyType 220) | 20 | 55 |
| 2421 | Ataque do Soldado Avançado | 1221 (PropertyType 221) | 24 | 55 |
| 2422 | Defesa do Soldado Avançada | 1222 (PropertyType 222) | 16 | 55 |
| 2423 | Magia do Soldado Avançada | 1223 (PropertyType 223) | 24 | 55 |
| 2424 | Resistência do Soldado Avançada | 1224 (PropertyType 224) | 16 | 55 |
| 2441 | Ataque Adicional Avançado | 1241 (PropertyType 241) | 48 | 55 |
| 2442 | Magia Adicional Avançada | 1242 (PropertyType 242) | 48 | 55 |
| 2443 | Defesa Adicional Avançada | 1243 (PropertyType 243) | 32 | 55 |
| 2444 | Resistência Adicional Avançada | 1244 (PropertyType 244) | 32 | 55 |
| 2445 | Vida Adicional Avançada | 1245 (PropertyType 245) | 80 | 55 |
| 2446 | Infantaria Adicional Avançada | 1246 (PropertyType 246) | 16 | 55 |

At lv80: gold +19 200/h (each row), hero HP +6 400, hero attack +3 840, soldier HP +1 600.

### 1.4 Player resources and production

| Resource | Where | Pseudo-item | Use |
|---|---|---|---|
| Ouro (gold) | `ResourceManager.gold: ResourceData(baseYield,count,limit)` | -100 | buildings, various fees |
| Cristal de Luz | `ResourceManager.waterCrystal` (cap 100 000 000) | -600 | technologies, blessing (`Blessing_Cast`) |
| Population | `ResourceManager.population(cur,max)` | - | legacy (soldier `NeedPopulation`) |
| Diamante | `PlayerInfo.point` (`PlayerInfo.as:594`) | -400 | paid currency |
| Diamante Vinculado | `PlayerInfo.giftToken` (`PlayerInfo.as:580`); `allPoint = point+giftToken` (line 608) | -500 | free currency |
| Espírito | `PlayerInfo.strategy` | -300 | soldier level (UpGrade Types=1) |
| Ametista | `PlayerInfo.mineral` | -200 | amethyst mine |
| System currencies | `PlayerCurrencyManager.currencyInfo.*` | -1000...-23000 | event shops |

Pseudo-item → balance mapping: `NavigationHelper.getNumByTempId` (`decompiled/core_module/scripts/mvc/module/navigation/NavigationHelper.as:17`) and `GoodsItemMenu.as:194`.

**Sync.** `ResourceManager` sends `5015 U_C_CASTLE_UPDATE` every 30 s (`decompiled/core_module/scripts/yishi/manager/ResourceManager.as:39,108`). Reply 109 carries `CastleYieldMsg{gold_yield, gold_wild_land_yield, gold_technology, gold_wonder, gold_dower, gold_total_count, gold_max, cur_population, max_population, wildYield[], crystals_count}` (line 64), applied as `gold.sync(gold_yield, gold_total_count, gold_max)`, `waterCrystal.sync(0, crystals_count, 1e8)` and `population.sync(0,cur,max)`.
- **Hourly production** is computed **server-side**: `gold_yield` = Prefeitura (`Property1`) + gold technologies (240×lv each) + wild lands (`gold_wild_land_yield`) + others.
- **Storage cap:** `gold_max` also comes from the server (config `Player_ResourceMax=10000` is the initial default).
- **Tooltip:** internal production = `baseYield − fieldYield` + Toque de Midas (`ResourceView.as:298`).

**Initial values** (`ConfigInfos`): `Player_Gold=0`, `Player_Point=0`, `Player_GiftToken=0`, `Player_WaterCrystal=1000`.

### 1.5 Tax collection (Prefeitura)

The "Impostos" tab of the Prefeitura (`buildings.politics.view.PoliticsFrame`/`LevyView`, m4) unlocks at Leader lv14 (`LevyView.as:74`).
- **Gain per collection** = `Prefeitura.Property1×6 + Furnace(101).Property1×3` (+ `floor(AddValue×gain/100)` while Toque de Midas is active) (`decompiled/m4/scripts/buildings/politics/view/LevyView.as:117-127`).
- **Remaining collections** = `property2 − property1` of BuildInfo 901 (updated by `U_C_GOLD_IMPOSERESULT{left_impose,max_impose}`, `BuildingManager.as:112`).
- **Request:** `C_GOLD_IMPOSE{op}` (`PlayerManager.sendLevy`, `PlayerManager.as:1708`).
- **Example:** Prefeitura lv50 → 26 115×6 = 156 690 gold per collection.

### 1.6 Transmissor and castle relocation

Pseudo-building `buildingId=-11`, `templateId=151101`; `property1` = current energy (from `BaseCastleMsg.left_energy`, `LoginInitDataAccept.as:841`); max 500 (`Property2`).
- **Energy:** `5174 U_C_BUILDING_UPENERGY{payType}` (reply 103 `TransInfoMsg{current_energy,remain_time}`); transport recharge `transport_charge_cost=10` diamonds.
- **Relocation:** cooldown `5173/101 U_C_BUIDLING_TRANS_COOL`; move the castle with `5176/105 U_C_BUILDING_TRANSCASTLE`; result `4159 U_C_TRASNBUILDING_RESULT`; cancel `8535 C_CANCEL_TRANS`.
- **Castle protection:** `Defence_Time=7200` s (`4452 U_C_CASTLE_TIME`; cancel `8562 C_CASTLE_TIME_CANCEL`).
- **Window:** `buildings.transferbuilding.view.TransferBuildFrame` (see [docs/ui/screens.md](../../docs/ui/screens.md)).

### 1.7 Wild lands and outer-map objects (`MapPhysicsTempInfos`)

44 objects with MasterType 21: field monsters 2101xx (lv10-80, normal/[Elite]/boss), Eremitério 4001xx and events 5000xx (lv80-240).
- **Appearance:** `SonType` (`mapmaterial/build/{SonType}.swf` via `PathManager.solveMapPhysicsBySonType`, or an avatar in `OuterCityNpcView.as:112`); `RefreshTime=7200` s.
- **Occupied lands** arrive via `152 U_C_SECURITY_INFO_UPDATE` (`CastleYieldMsg.wildYield[]{wild_pox_name, wild_grade, wild_yield, wild_refresh_time, map_id}`). Abandon one with `5179/108 U_C_UNOCCPWILDLAND{position}` from the Prefeitura fields tab (`PoliticsFieldView`/`FieldItem.as:115`).
- **Wrapper:** `WildLand` (`decompiled/core_module/scripts/map/internals/data/WildLand.as:44`).

### 1.8 Progression curves (`UpGradeTempInfos`)

13 335 rows over 110 `Types` values (`UpgradeType.as`, global enum `upgrade_type`). `UpgradeTemplateResolve` loads them and indexes them in `_upgradeMapDic[Types]` (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2492`).
- **APIs:** `getTemplateByLevelAndType(level,type)` (line 2291), `getTemplatesByType`, `getUpgradeGradeBy(type,exp)` (2352), `getGradeByAdd` (2321).
- **Data is incremental:** walk the levels subtracting `Data` until `exp < Data`.
- **`TemplateId`** is used only when the curve depends on an object (Types 1 soldier; 26/39/106 guardian SonType; 138 arsenal profile via `getTemplateByTypeAndLevelAndID`).
- **`ActiveObject`** = value/object unlocked at the level (emblem ids in 47, attribute values in 144/145, ids in 101/102/129).
- **`TemplateName`** sometimes carries parameters ("id,qty|..." in 121/134; percentages in 81/122/135/153).

| Types | Rows | Meaning (`Data`/`ActiveObject`) |
|---|---|---|
| 124 | 3001 | Titan: charge |
| 18 | 2500 | Mount property (PropertyInfo) |
| 52 | 999 | (no client use found) |
| 1 | 879 | Soldier: TemplateId=PawnTempInfos of the target level; Data=Espírito (-300) to level up (PawnLevelUpFrame.as:580) |
| 156 | 630 | Avenger: spirit |
| 153 | 601 | Dragon Soul 3 (sacred) |
| 132 | 560 | Protection spirit: talent |
| 146 | 321 | Soul refining: material |
| 116 | 201 | Titan-dragon (stars) |
| 113 | 200 | Fashion |
| 147 | 200 | Monster: level |
| 109 | 181 | Wild soul collection |
| 21 | 179 | Talent |
| 117 | 101 | Refining (concise) |
| 133 | 101 | Protection spirit: HP |
| 24 | 100 | Vehicle/daimon |
| 127 | 100 | Einherjar sacred relic |
| 154 | 100 | Treasure |
| 7 | 81 | Tree/tree power (WaterViewContainer) |
| 15 | 81 | Jewels (JewelFrame) |
| 104 | 81 | Senior soul/senior jewel |
| 3 | 80 | Leader: Data=EXP per level (3000 lv2 ... 110 946 655 lv80); ActiveObject 50101 at lv18 |
| 17 | 80 | Farm (FarmModel) |
| 25 | 80 | Einherjar (PetData) |
| 105 | 80 | Vocation |
| 110 | 80 | Class change (TemplateName=names) |
| 129 | 80 | Protection spirit: emblem |
| 130 | 80 | Protection spirit: resistance |
| 131 | 80 | Protection spirit: reduction |
| 144 | 80 | Mount soul refining: attribute |
| 160 | 75 | Rune (StoneIntensify) |
| 112 | 70 | Transfer talent |
| 125 | 64 | Caminho da Glória |
| 38 | 50 | Advanced talent |
| 151 | 50 | Monster: accessories |
| 36 | 46 | Marriage/ring (MarryTip) |
| 41 | 41 | (no client use found) |
| 40 | 40 | Fishing/fish pond (FishPoolInfo) |
| 158 | 40 | Sacred |
| 141 | 37 | Dragon Talker: talisman |
| 139 | 32 | Alchemy (points; TemplateName=what it unlocks) |
| 23 | 31 | (no client use found) |
| 26 | 31 | Destiny guardian |
| 39 | 31 | Destiny guardian 2 |
| 106 | 31 | Destiny guardian 3 |
| 107 | 31 | (no client use found) |
| 35 | 30 | Marriage |
| 138 | 30 | Arsenal |
| 152 | 30 | Avenger |
| 142 | 29 | Dragon Talker: symbiont |
| 27 | 21 | Einherjar (2) |
| 29 | 21 | Einherjar (3) |
| 157 | 21 | Avenger: stage |
| 37 | 20 | Mount wild soul |
| 54 | 20 | (no client use found) |
| 108 | 20 | Sacrifice |
| 145 | 20 | Soul refining: skill |
| 120 | 18 | Guardian growth manual |
| 14 | 17 | Honor rank (TemplateName = titles) |
| 136 | 15 | Ancient artifact |
| 44 | 12 | Growth |
| 128 | 12 | Protection spirit: growth |
| 135 | 12 | Spirit skill awakening |
| 6 | 10 | Friendship degree (FavourTip) |
| 9 | 10 | Star profile 2 |
| 10 | 10 | Star profile 3 |
| 11 | 10 | Star profile 4 |
| 12 | 10 | Star profile 5 |
| 16 | 10 | Soldier special skill blessing |
| 20 | 10 | Guild tree |
| 22 | 10 | Star profile 7 |
| 42 | 10 | Guild Emerald Dream |
| 43 | 10 | Honor (HonorCell) |
| 47 | 10 | Emblem |
| 48 | 10 | Guardian resistance |
| 49 | 10 | Guardian reduction |
| 60 | 10 | Sub-star |
| 103 | 10 | Star |
| 114 | 10 | Guardian Patrol: HQ |
| 115 | 10 | Guardian Patrol: tower |
| 119 | 10 | New tattoo slot |
| 121 | 10 | (no client use found) |
| 122 | 10 | Titan: injection |
| 123 | 10 | Titan: re-injection |
| 134 | 10 | Laboratório de Platina |
| 149 | 10 | Monster: skill |
| 155 | 10 | Avenger demonic armor |
| 4 | 9 | VIP: Data=VIP EXP (VIPView.as:158) |
| 118 | 9 | Navigation ship |
| 159 | 9 | (no client use found) |
| 19 | 8 | Mount (MountInfo) |
| 53 | 8 | (no client use found) |
| 102 | 8 | Dragon Soul 2 (Dragon Heart) |
| 140 | 8 | Dragon Talker: battle beast |
| 28 | 7 | Battle guard |
| 81 | 7 | (no client use found) |
| 101 | 6 | Dragon Soul 1 |
| 137 | 6 | Resonance |
| 161 | 6 | Navigation port |
| 50 | 5 | (no client use found) |
| 51 | 5 | Life skill |
| 111 | 5 | Archaeology (EXP) |
| 126 | 5 | Bar da Fantasia (friendship) |
| 148 | 5 | Monster: stage |
| 143 | 4 | Dragon Talker: proficiency |
| 150 | 3 | (no client use found) |
| 13 | 2 | Star profile 6 |
| 45 | 2 | House (houseLv) |
| 46 | 2 | Residence (homeLv) |
| 8 | 1 | (no client use found) |

### 1.9 Global settings (`ConfigInfos`)

990 key/value rows (983 keys; the duplicated keys are `Inlay_JoinOpen`, `Altar_RewardCount`×6 and `alliance_returnplayer_grade`, and the dictionary keeps the last value). Access: `TempleteManager.getConfigInfoByConfigName(name).ConfigValue` (`TempleteManager.as:1476`). The client reads 344 distinct keys; the rest are server-only. `Description` holds the Chinese comment, almost always tagged 【system】. Heuristic classification by name/tag:

| System | Keys | Examples |
|---|---|---|
| PvE/campaigns/dungeons | 211 | MultiCampaign_MaxCount, WorldBoss_Wound1, WorldBoss_Wound2, WorldBoss_Wound3, WorldBoss_Buffer_Gift_Price, WorldBoss_Buffer_Diamond_Price |
| PvP/arena/cross-server battles | 158 | MatchTime, MatchRoom_MaxCount, MatchOfVehicleTime, CrossWar_Time, Mate_Time, Mate_Join |
| Character systems (rune, tattoo, star, talent, class...) | 116 | Inlay_JoinOpen, Inlay_JoinOpen, Inlay_JoinOut, Star_BagPrice, Star_BagAdd, Compose |
| Events/minigames | 102 | clearDays, Bottle_Price, Fate_FreeCount, FreshSeconds, MineOfActiveTime, Dati_Day |
| Einherjar (pet)/mount/titan | 91 | pet_reset_att, pet_learn_skill, pet_up_quality, Pet_Challenge_Grade, Pet_Challenge_Count, Pet_BattleOver_Grade |
| Guild | 84 | Consortia_Grade, Consortia_Gold, Consortia_Member, Consortia_Change, Consortia_Rename, Consortia_ClearCD_Point |
| Marriage/family | 83 | marriage_gift, marriage_task_count, marriage_fireworks, mar_tree_train_count, divorce_need, mar_time |
| Player/basic (bag, vigor, level) | 38 | Sys_Edition, Player_BagCount, Player_weary, Mail_NeedGold, Player_BagAdd, Hero_EngagePrice |
| Farm/house | 26 | FarmCrop_Mature_Percent, FarmCrop_Gains_Percent, FarmCrop_Operate_GP, Farm_TodayFromFriend_GP, Farm_Accelerate_Point, Farm_TodayStolen_Count |
| Other | 24 | Geste_UpperLimit, All_KingContract, backPlayerGrades, backOfflineDays, backBufferDays, revivalTime |
| Castle/buildings/resources | 21 | Player_Point, Player_GiftToken, Player_Gold, Player_ResourceMax, Castle_Building, Castle_Order |
| VIP/payment/coupons | 17 | Vip_DailyAddGp, Vip_ExpirtDailyMinusGp, Vip_ConsumeGp, Vip_GoldDailyAddGp, One_MonthPoint, Three_MonthPoint |
| Music/visual | 15 | BattleMusic1, BattleMusic2, BattleMusic3, BattleMusic4, BattleMusic5, BattleMusic6 |
| Anti-addiction | 4 | AASOpen, AASGrade1, AASGrade2, AASRefresh |

**Key settings (91)**, with the actual BR XML values:

| Key | Value | Meaning |
|---|---|---|
| `Castle_Building` | `901,402` | Initial castle buildings (SonType) |
| `Castle_Order` | `1` | Initial build queues |
| `BUILD_MAX_GRADE` | `80` | Max building level |
| `Order_NeedPay` | `100` | Diamonds to buy the 2nd queue |
| `Quick_Cool` | `1,10` | Queue speed-up: diamonds,minutes (1 per 10 min) |
| `Challenge_Cool` | `1,1` | Challenge queue speed-up (diamonds,minutes) |
| `Player_ResourceMax` | `10000` | Default player resource cap |
| `Player_WaterCrystal` | `1000` | Initial Cristal de Luz |
| `Player_Gold` | `0` | Initial gold |
| `Player_Point` | `0` | Initial diamonds |
| `Player_GiftToken` | `0` | Initial bound diamonds |
| `Defence_Time` | `7200` | Default castle protection (s) |
| `GiveCastle_Grade` | `11` | Level to leave the newbie island and get a castle |
| `RemoveMap_Day` | `7` | Days without login before the castle returns to the newbie island |
| `RemoveMap_Persent` | `80` | Map occupancy % that triggers small-account cleanup |
| `transport_charge_cost` | `10` | Diamonds to recharge the transporter |
| `Blessing_Grade` | `41` | Default blessing level |
| `Blessing_Buffer` | `10` | Default blessing effect |
| `Blessing_Cast` | `2000` | Blessing cost in Cristal de Luz |
| `Blessing_ItemId` | `208026` | Item consumed by the blessing |
| `Blessing_Max` | `200` | Max blessing effect |
| `Player_BagCount` | `42` | Initial bag cells |
| `Player_BagAdd` | `7` | Cells per purchase |
| `AddBag_Count` | `5,10,15,20,25,30,35,40,45,50` | Diamond price of each bag expansion |
| `Player_weary` | `200` | Max vigor |
| `Weary_Limit` | `600` | Max vigor recoverable via potions/day |
| `SingleCampaign_Weary` | `20` | Vigor per solo campaign |
| `MultiCampaign_Weary` | `20` | Vigor per multiplayer campaign |
| `Player_AttackCount` | `5` | Default attacks (raids) |
| `AddAttck_Point` | `100` | Diamonds per extra attack on the outer map |
| `Mail_NeedGold` | `100` | Mail fee in gold |
| `Item_Resolve` | `1000` | Decomposition cost |
| `Damp_Grade` | `70` | Level from which campaign EXP no longer decays |
| `AddSkill_Grade` | `6` | Level of the 1st skill point |
| `Talent_OpenGrade` | `40` | Talent unlock level |
| `OpenRuneGrade` | `35` | Rune unlock level |
| `One_MonthPoint` | `298` | VIP 1 month (diamonds) |
| `Three_MonthPoint` | `868` | VIP 3 months |
| `Six_MonthPoint` | `1588` | VIP 6 months |
| `Vip_DailyAddGp` | `10` | Daily VIP EXP |
| `Vip_ConsumeGp` | `0.01` | VIP EXP per diamond spent |
| `newFirstPay_eachQuality_diamonds` | `500,2000,10000` | First-recharge pack tiers |
| `RentalBag_Per_Month` | `200` | Portable storage per month (diamonds) |
| `Point_ToOffer` | `1` | Diamonds per 1 guild contribution |
| `Sweep_Fast` | `1,10` | Sweep speed-up (diamonds,minutes) |
| `Consortia_Fast` | `1,10` | Guild speed-up (diamonds,minutes) |
| `Campaign_Sweep_Time` | `60` | Campaign sweep time (s) |
| `Campaign_Sweep_Gold` | `5000` | Gold per campaign sweep |
| `Tower_Sweep_Time` | `6` | Labyrinth sweep time per floor (s) |
| `Tower_Sweep_Gold` | `1000` | Gold per swept floor |
| `Consortia_Grade` | `13` | Level to found a guild |
| `Consortia_Gold` | `200000` | Gold to found a guild |
| `Consortia_Member` | `20` | Members per guild level |
| `marriage_gift` | `200000,500000,1000000` | Wedding gift gold (3 tiers) |
| `divorce_need` | `1200` | Diamonds to divorce |
| `mar_time` | `120` | Ceremony duration (min) |
| `marriage_task_count` | `10` | Couple tasks/day |
| `marriage_tree_gold` | `10000000` | Gold per couple-tree watering |
| `mar_tree_train_count` | `10` | Gold trainings of the couple tree |
| `magic_spring_open_grade` | `50` | Fonte Mágica unlock level |
| `magic_spring_item_tempid` | `250001,250002,250003,250004,250005,250006` | Fonte Mágica potions |
| `magic_spring_slot_open_count` | `100,60,20|200,120,60|400,240,120|800,480,240` | Accumulated potions to open each slot |
| `magic_spring_slot_open_forward_cost` | `100,200,300,400` | Diamonds to open a slot early |
| `archaeology_max_count` | `30` | Digs per day |
| `archaeology_max_dig_pos` | `5` | Simultaneous dig spots on the map |
| `archaeology_purchases` | `50,5,15` | Dig purchase: diamonds,qty,cap |
| `alchemyworkshop_max_score` | `285000` | Alchemy Points cap |
| `alchemyworkshop_speed_up_cost` | `5,2` | Speed-up: N diamonds per X min |
| `alchemyworkshop_max_speedup_times` | `5` | Speed-ups/day |
| `alchemyworkshop_cycle_score` | `20000,3` | Every N points grants X catalysts |
| `alchemyworkshop_share_outtime` | `12` | Group formula validity (h) |
| `shuttle_reset_free` | `2` | Free Portal do Tempo resets/week |
| `shuttle_reset` | `2,2000` | Paid resets: max,price |
| `shuttle_refresh` | `10,100` | Paid refreshes: max,price |
| `arcane_zone_max` | `10` | Max Zona Proibida passes |
| `magic_pub_present_count` | `10` | Gifts/day in the Bar da Fantasia |
| `magic_pub_add_favor` | `2,4,6,8,12` | Friendship per gift (by quality) |
| `magic_pub_add_dust` | `60,70,80,90,120` | Magic dust per gift (by quality) |
| `magic_pub_chat_add_favor` | `5,7,9,12` | Friendship per chat (by level) |
| `Fish_Count` | `20` | Max fishing attempts |
| `Fish_Cd_Point` | `3` | Diamonds to reset fishing CD |
| `older_reflux_conf` | `10,55,30000,50,33` | Regresso do Rei: days absent,level,power,... |
| `backPlayerGrades` | `45` | Min level for the returning-hero buff |
| `backOfflineDays` | `30` | Offline days for the return buff |
| `backBufferDays` | `15` | Return buff duration (days) |
| `courtyard_maid_need` | `200` | Cost to hire a maid (Residência) |
| `perkin_lab_rob_count` | `5` | Raids in the Lab. Platina |
| `ShopFresh_NeedDiamond` | `10` | Diamonds to refresh the mystery shop |
| `Geste_UpperLimit` | `30,7000|40,32000|50,88000|55,176000|60,240000|80,99990000` | Honor cap per level |
| `DayAddGeste` | `6000,50000` | Daily honor cap (normal, via potion) |
| `MaxDailyActivity` | `100,200,150,100` | Daily activity cap per phase |

`mar_heart_count` is read by the client (`MarryModel.as:556`) but missing from the XML (default 1).

### 1.10 Effects summary (`EffectTempInfos`)

78 effects, grouped by `OwnTypes`:
- **1** = technology effect (11xx basic, 12xx advanced; only `PropertyType1`/`Property1` matter).
- **2** = item buffs (20xx disguise, protection, population, warehouse, EXP, hero gains...; 50xx attribute blessings; 7001 triple gifts), read by `PlayerBufferInfo.template` (`PlayerBufferInfo.as:259`).
- **3** = guild talents/bonuses (30xx) via `PlayerTalentInfo` (`PlayerTalentInfo.as:32`).
- **4** = food (2145 wine, 2146 cake).

Descriptions use `{Grades}` as the value placeholder.

### 1.11 Soldier special skill (`SpecialTempInfos`)

561 rows = 5 conversions (attack/magic/defense/resistance/HP) × 10 levels × 11 soldier classes (`PawnMasterType`).
- **`ChangeNumber`** = % of the soldier attribute added to the hero (1,2,3,5,7,9,11,14,17,20 for attack).
- **`TakeRandom`** decreases 1294→0 (roll weight *(assumption)*).
- **UI:** shown in `PawnLevelUpFrame` (`decompiled/m5/scripts/armyII/viewII/pawnupgrade/PawnLevelUpFrame.as:607`); icons `/special_AT.png` etc.

### 1.12 Top event bar (`TopToolBtnInfos`)

96 buttons; `tempSort=int(Sort/1000)` (1 highlight, 2 events/purchases, 3 rewards, 4 timed events).
- **Visibility and min level:** `TopBtnCheckShowHelper` (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:213`; Leader "lv ≥"; "-" = no level check, so the button depends only on the server opening the event).
- **Sign-up events:** `isOpen`/`isSignUpState` (`TopToolBtnTempInfo.as:65`).
- **pt-BR name:** `ui.toptoolbar.TopToolsBar.tipData_<BtnKey>` (★ = our own translation from Chinese because the key is missing).

| TemplateId | BtnKey | pt-BR name | Group | Min level |
|---|---|---|---|---|
| 1001 | funny | Destaques | 1 | 6 |
| 2001 | registwelfare | Privilégio de Novatos | 2 | 6 |
| 2002 | wedding | Cerimónia de Casamento | 2 | 36 |
| 2003 | tiro | Evento da Abertura do Servidor | 2 | 6 |
| 2004 | fundnewbie | Minas de Iniciante | 2 | - |
| 2005 | timing | Pacote Online Fixo | 2 | 11 |
| 2006 | loginactive | Evento de login | 2 | - |
| 2008 | exchargeall | Recarga Total | 2 | 20 |
| 2009 | karneval | Loucura do Povo | 2 | 11 |
| 2010 | recharge | Pacote de primeira recarga | 2 | 11 |
| 2011 | raveparty | Festa do Carnaval | 2 | 11 |
| 2012 | crosscost | Consumo do Povo | 2 | 20 |
| 2013 | continuepayrrbate | Evento de recarga contínua | 2 | - |
| 2014 | fund | Minas do Tesouro | 2 | - |
| 2015 | publicchairs | Recarga de coletivo | 2 | 6 |
| 2016 | feedback | Pacote de Feedback de Recarga | 2 | 6 |
| 2017 | chargelottery | Roleta de Recarga | 2 | 11 |
| 2018 | newyearlottery | Baú da Sorte | 2 | 11 |
| 2019 | discountshop | Loja de Descontos | 2 | - |
| 2020 | encoGold | Ouro da Incentivação | 2 | 6 |
| 2024 | limitbuy | Compra Limitada | 2 | 10 |
| 2025 | luckyexchange | Troca da Sorte | 2 | 6 |
| 2026 | lottery | Roleta da Sorte | 2 | 10 |
| 2027 | publicegg_total | Carnaval do Verão | 2 | 6 |
| 2028 | publicegg_egg | Convidar para o Verão | 2 | 6 |
| 2029 | publicegg_sumgift | Presente do Verão | 2 | 6 |
| 2030 | sumcampaign | Verão 9 dias | 2 | 6 |
| 2031 | goldroad | Caminho de Ouro | 2 | 18 |
| 2032 | bingo | Maça Alegre | 2 | 11 |
| 2033 | slot | Caça-Niquel | 2 | - |
| 2034 | auctionsale | Sistema do Leilão | 2 | 35 |
| 2035 | artifact | Roleta da Arma Divina | 2 | 11 |
| 2038 | hallfame | Evento do corredor da fama | 2 | - |
| 2039 | bottle | Árvore de Ouro | 2 | 11 |
| 2040 | pandora | Caixa de Pandora | 2 | 6 |
| 2042 | question | Pesquisa de Questionário | 2 | 20 |
| 2043 | newyear | Login do Ano Novo | 2 | 11 |
| 2044 | answer | Respostas online | 2 | - |
| 2045 | blackjack | Chegada do BlackJack | 2 | 6 |
| 2046 | cultureactive | Evento de Adestração | 2 | 11 |
| 2047 | goldendionysia | Carnaval de Ouro | 2 | 6 |
| 2048 | pumpingjoy | Gashapon | 2 | 16 |
| 2049 | wholerebate | Reembolso para Todos ★ | 2 | - |
| 2050 | magicspring | Fonte Mágica | 2 | - |
| 2051 | monthcard | Grande Pacote Diário ★ | 2 | - |
| 2052 | foisonhorn | Chifre da Colheita ★ | 2 | - |
| 2053 | goldensheep | Ovelha Dourada da Sorte ★ | 2 | - |
| 2055 | mvpshop | MVP de Todos (loja MVP) ★ | 2 | - |
| 2056 | luckylottery | Grande prêmio da Alegria | 2 | - |
| 2057 | stokesore | Minério de Hefesto ★ | 2 | - |
| 2058 | wishpool | Poço dos Desejos ★ | 2 | - |
| 2059 | supersignincard | Cartão de Super Check-in ★ | 2 | - |
| 2060 | kingback | Regresso do Rei ★ | 2 | - |
| 2061 | sevenyear | Aniversário ★ | 2 | - |
| 2062 | allmanexchange | Troca para Todos ★ | 2 | - |
| 2063 | platinum | Pote Mágico de Platina ★ | 2 | 11 |
| 2064 | customizedvip | Pacote personalizado VIP | 2 | - |
| 2065 | darkmaze | Labirinto Sombrio ★ | 2 | - |
| 3001 | online | Pacote Online | 3 | 11 |
| 3002 | crosspvpreward | Prêmio Inter-Servidores | 3 | 30 |
| 3003 | petweedreward | Prêmio semanal de Arena de Einherjar | 3 | 50 |
| 3004 | regression1 | Pacote do novo rei | 3 | - |
| 3005 | regression2 | Pacote do Regresso | 3 | - |
| 3006 | regress | Privilégios de Velhos jogadores | 3 | 6 |
| 3007 | outyardreward | Prêmio da Luta | 3 | 13 |
| 3008 | mailcheck | Verificação de Email | 3 | - |
| 3009 | renotereward | Prêmio de Expedição | 3 | - |
| 3010 | childarenareward | Prêmios de Guardião Leida | 3 | - |
| 4000 | giftwill | Reunião de Presentes ★ | 4 | 32 |
| 4001 | matelords | Batalha de Vênus | 4 | 36 |
| 4002 | crossgvg | Defesa de Guilda | 4 | 13 |
| 4003 | areslords | Batalha de Ares | 4 | 36 |
| 4006 | poker | Texas Poker | 4 | 6 |
| 4007 | pvp | Arena | 4 | 22 |
| 4008 | worldboss | Chefão Global | 4 | 20 |
| 4010 | petboss | Ilha da Proteção de Einherjar | 4 | 50 |
| 4011 | childArena | Arena de Guardiao | 4 | 70 |
| 4012 | rvr1 | Campo de Batalha | 4 | 30 |
| 4013 | crossmuticampaign | Campanha Multiplayer | 4 | 20 |
| 4014 | assaultwar | Investida ★ | 4 | - |
| 4015 | unrealshooting | Caça Fantástica | 4 | 1 |
| 4017 | godsevening | Hegemonia dos Três Reinos | 4 | - |
| 4018 | apex | Liga do Pico | 4 | 80 |
| 4019 | dreamarena | Arena Ilusória | 4 | - |
| 4020 | gamehall | Evento de Páscoa ★ | 4 | - |
| 4021 | timebox1 | Baú do Tempo 1 ★ | 4 | - |
| 4022 | newfirstpay | Pacote de Primeira Recarga | 4 | 6 |
| 4023 | newquestion | Questionário (novo) ★ | 4 | - |
| 4024 | newmemorycard | Cartas da Memória ★ | 4 | - |
| 4025 | carnival | Festival da Folia | 4 | - |
| 4026 | sqmomery | Retrospectiva de Aniversário ★ | 4 | 80 |
| 4027 | oldplayerreturn | Retornados ★ | 4 | - |
| 4028 | oldplayerreturn2 | Eternos ★ | 4 | - |
| 4029 | secretwar | Campo de Batalha Secreto ★ | 4 | - |
| 4030 | christmas | Carnaval de Natal ★ | 2 | - |
| 4031 | skytreasure1 | Tesouro do Céu ★ | 2 | - |

Other fixed levels: `outyard`/`outyardreward` 13, `daylight` 13, `giftwill` 32, `braveleg` 40, `goldroad` 18, `pumpingjoy` 16, `apex`/`sqmomery` 80, `childArena` 70.

### 1.13 Social sharing (`ShareTemplateInfos`)

14 triggers (`ConditionType` 1-16, enum `share_condition_type`). The server sends `336 U_C_SHARE` (`PropertyMsg.param1` = TemplateId); `FaceBookShareManager` (`decompiled/core_module/scripts/managers/FaceBookShareManager.as:54`) calls `ExternalInterface callFbLike` and, on completion, sends `9590 C_SHARE_TAKEREWARD`. `Param4` holds the target values (qualities "3,4,5", levels "7,8,9,10", Einherjar ids). The reward is defined server-side.

### 1.14 Returning players (`RegressTemplateInfos`) and Regresso do Rei (`OlderRefluxTempInfos`)

- **Regress** ("Privilégios dos Velhos Jogadores", m11/regress): `340 U_C_REGRESS_INFO` carries `RegressRecordListMsg{canTakeTotalCount, loginDateCount, info[]{takeTemplateId,isFinish,isTakeReward}}`. Each goal pays `TakePercent% × canTakeTotalCount` (`RegressItem.as:90`):
  - Types 1 = 30 % base;
  - Types 2 = lv20/30/40/50 → 5/5/10/15 %;
  - Types 3 = 2/3/5 logins → 5/10/20 %.
  - Claim: `9593 C_REGRESS_TAKE`. Return buff: `backPlayerGrades=45`, `backOfflineDays=30`, `backBufferDays=15`.
- **Regresso do Rei** (`kingback`, m11; `KingbackManager`, `515 U_OLDER_REFLUX` / `9690 C_OLDER_REFLUX_OP`): `older_reflux_conf=10,55,30000,50,33` (days absent, level, power, ...). 72 rows in 8 tabs (`older_reflux_type`):
  - 1 daily login (14 days, e.g. day 1 = 200 bound diamonds + items);
  - 2 return-point goals (Topic 500...);
  - 3 shop (Point 69-1399 diamonds, Param1 struck-through price, Param2 limit);
  - 4-8 consumption goals (`CostItems` × `Topic`) that refund the same item (e.g. consume 100× 208063 → +10).
  - Texts: `kingback.*`.

### 1.15 Pequeno Secretário (`AssistantTemplates`)

9 tasks in 5 tabs (Recompensa, Labirinto×3, Fabricar, Cidade: Coleta de Impostos/Lab. Platina/Fazenda, Guilda: Altar). `SecretaryData` builds the tabs by `MaterType` (`decompiled/core_module/scripts/mvc/module/secretary/SecretaryData.as:64`). Helper costs: `Reward_OneKey=68`, `Tower_Sweep_Gold`. Opcode: `8528/592 U_C_ASSISTANT_ITEMS`.

### 1.16 First recharge (`FirstPayTemplates`, `FirstChargeItems`)

- **New:** 54 rows = 3 tiers (`PayQuality` 1/2/3 = 500/2000/10000 diamonds, `newFirstPay_eachQuality_diamonds`) × 3 days (`Time`) × 3 classes × 2 sexes. Selection: `NewFirstPlayCate.getTemplate(sex, job, quality, day)` (`NewFirstPlayCate.as:39`). `AvatarPath` shows the weapon (`equip_show/activity/sword_fb/0.swf`); `ImagePath images/activity/gg1.png`. Opcodes `4290 U_C_FIRST_PAY_DATA` and `8672 C_FIRST_PAY_CLIENT_OP` in `NewFirstPayManager`.
- **Old** (`FirstChargeItems`), per class: 1 000 000 gold, 1 000 000 Espírito, 100 000 Cristais de Luz, 30× 2040109, weapon 101x205, 2× 2030503.

### 1.17 Questionnaire (`QuestionTemplates`)

12 pt-BR questions with "|"-separated `Options` and `MaxChoose`. `QuestionFrame` (m11/question) lists them all; `QuestionManager` uses `4291 U_C_QUESTION_DATA`/`8673 C_QUESTION_CLIENT_OP`. The old questionnaire uses `U_C_QUESTIONNARIE_LIST`/`C_QUESTIONNARIE_ANSWER`.

### 1.18 Guide values (`GuideValueTemps`)

300 rows in 10 `Type`s with `MinLv-MaxLv` ranges and up to 4 parameters (e.g. Type 2: lv1 → 1/6/11, lv80 → 40/50/80; Type 5: up to 1 171 976). **Not referenced by the client**: a server table, probably recommended values for the "strengthening guide" *(assumption)*.

### 1.19 Fishing (`FishTemplateInfos`)

Game Box minigame (`m11/fish`, `FishManager`) with 13 objects.
- **Obstacles:** `IsBlock=1` (fish_001-003); no reward.
- **Fish:** `Speed` 1-4 px/frame (`FishSigModel.as:43`), `Length`, lane `ChannelIds` 1-5, reward `RewardId/RewardCount` (Moeda do Jogo -4000 ×1-10, 2130005, 208012).
- **Rage mode** (`U_C_FISH_CRAZY`) adds `RageId1` (`FishView.as:705`).
- **Limits:** `Fish_Count=20`, `FishTool_Max=5`, `FishTool_Point=10`, `Fish_Cd_Point=3`, `Fish_Help_Point=5`.
- **Opcodes:** `9507 C_FISH_POOL`, `4916 U_C_FISH_POOL`, `4917-4920 U_C_FISH_CHECK/INFOS/HELPOVER/CRAZY`.

### 1.20 Marriage: `MarrySpecTempInfos`, `HeartTempInfos` (m9/marry)

| Quality | Diamonds | Hall (`CampaignId`) | Gold | Rewards |
|---|---|---|---|---|
| 1 Amor de Mil anos | 11 999 | 4303 | 2 000 000 | rings 1122401+1102401, 6888×208034, 388×208036, 888×208057, 388×208058; carriage (`Path`) |
| 2 Casamento Nobre | 3 188 | 4302 | 1 000 000 | rings + 6888×208034, 388×208036 |
| 3 Casamento Normal | 1 199 | 4301 | 500 000 | 1888×208034, 188×208036 |

- **Price:** `MarryModel.getMarryQualityCosts` (`decompiled/core_module/scripts/mvc/module/marry/MarryModel.as:565`). Within 72 h after marrying, the player pays `Discount`=80 %; a returning player pays half on the 1st marriage.
- **Config:** `marriage_gift=200000,500000,1000000`, `divorce_need=1200`, `marriage_deal_divorce_point=1000`, `mar_time=120` min, `marriage_task_count=10`, couple tree (`marriage_tree_*`, `mar_tree_train_count=10`, `fresh_martree_item=100000`).
- **Teste do Coração:** 123 questions with 4 options (`MarryHeartFrame.as:190`); `8802 C_MARRIAGE_HEART` / `4690 U_C_MARRIAGE_HEART_START` / `4691 U_C_MARRIAGE_HEART_QUESTION`.
- **Other opcodes:** `8759 C_marriage_REQUEST`, `15049 CH_MARRIAGE_BUY_SPEC`, `4657 U_C_MARRIAGE_INFO`, `4678 U_C_MARRIAGE_TREE`, `4672 U_C_MARRIAGE_RIDE`. See [docs/ui/screens.md](../../docs/ui/screens.md) §m9.

### 1.21 Residence and furniture (`FurnitureTempInfos`)

73 furniture items.
- **`Type`** = layer (1 wall and 2 floor are "wallpaper" repeated across the house; 3 rug; 4 wall decoration/light; 5 window; 7 floor furniture): `FurnitureLayer.as:187`.
- **`FurnitureType`** 1-11 = exclusive category (`FurnitureBagCell.as:239`).
- **`Icon1/Icon2`** = "resource,width,height" in cells for rotation 1/2 (`FurnitureInfo.width/height/setRotation`, `decompiled/core_module/scripts/mvc/module/home/FurnitureInfo.as:37`).
- **Sources:** furniture comes mainly from the Archaeology book (`RewardFurnitureId`). House/residence level: UpGrade Types 45/46.
- **Opcodes:** `8873 C_HOME_OP`, `4753 U_C_HOME_INFO`, `4757 U_C_SELECT_HOME`, `9519 C_FURNITURE_SHOP_BUY`.

### 1.22 Archaeology: `ArchaeologyItemTemps`, `ArchaeologyBookTemps` (m14/archaeology)

- **Digging:** digging spots on the outer map (`archaeology_max_count=30`/day, `archaeology_max_dig_pos=5`, purchase `archaeology_purchases=50,5,15`) yield fragments; `NeedChip` (250-1500) fragments assemble the relic and grant `RewardId×RewardCount` (`ArchaeologyMakeRightView.as:145`).
- **Relics:** 200 relics (30 Resources, 96 Items, 60 Potions/Scrolls, 14 Visuals); `MapId` 0-5 (Pasto Livre, Floresta Nublada, Pântano Sem Fim, Deserto da Morte, Terra do Julgamento).
- **Book:** 59 collections (3 relics → rewards + 1 furniture) and 4 "Elevação" milestones (archaeology level → title 300-303).
- **Archaeology EXP:** UpGrade Types 111 (`ArchaeologyModel.getGradeByExp`, line 109). Map monsters: `world_map_archaeology_monster_*`.
- **Opcodes:** `9575 C_ARCHAEOLOGY_REQ`, `296 U_C_ARCHAEOLOGY_DATA`, `297 _NODELIST`, `298 _GOODLIST`. Images: `/archaeology/{type}/{n}.jpg`.

### 1.23 Alchemy Workshop: `AlchemyMineTemplates`, `AlchemyFormulaTemplates` (m14/alchemical)

- **Mines:** 6 mines (`Pos`) × 4 levels; each produces 1 ore every `Speed` s (90 → 70) up to `MaxCount` (240 → 410) (`AlchemicalMineInfo.as:37`). Levels unlock with Alchemy Points `NeedScore` (0 → 230 300).
- **Formulas:** 50 formulas; `Type` 1 = group (4 "|"-separated steps, friend invites, validity `alchemyworkshop_share_outtime=12` h), 2 = solo.
- **Rewards:** `Reward` includes `700000:N` = Alchemy Points (cap `alchemyworkshop_max_score=285000`; every 20 000 points grants 3 catalysts; `alchemyworkshop_double_percent`).
- **Point unlocks:** UpGrade Types 139 (`AlchemicalModel.as:100`). Speed-up `5,2` (5 diamonds/2 min, 5×/day).
- **Opcodes:** `9661 C_ALCHEMY_WORKSHOP_OP`, `461 U_C_ALCHEMY_WORKSHOP_OP`.

### 1.24 Fonte Mágica: `MagicSpringTempInfos` (m11/magicspring)

21 recipes. Consuming `PotionCount1..3` of potions 250001-250003 (Força da Coragem, Coração da Sabedoria, Fonte da Vida) or 250004-250006 (Poeira dos sonhos, Chifre da Resistência, Pena Etérea) activates a buff that lasts `ValidTime` h with `AddValue` %.
- **Buff ids:** the recipe id is the buff id checked across the game (`MagicSpringModel.checkIsExistBuffer(id)`): 1 gold +100 % (prefeitura, taxes, Chefão Global, Casa de Gatos, raid), 2 farm, 4 campaigns +50 %, 5 cosmos −25 %, 6 reward EXP, 7 Einherjar Expedition, 8 honor, 10 cycle chests, 11-24 other content (see enum `magic_spring_buff`).
- **Requirements:** total level 50-161 (`NeedGrade`). Config `magic_spring_open_grade=50`; slots open via `magic_spring_slot_open_count=100,60,20|200,120,60|...` (accumulated potions per slot) or early for 100/200/300/400 diamonds.
- **Opcodes:** `5189 C_MAGIC_SPRING_OP`, `172 U_C_MAGIC_SPRING_INFO`.

### 1.25 Portal do Tempo: `ShuttleTempInfos`, `ShuttleRewardTempInfos` (m11/outyard/shuttle)

Part of the Terralém (`OutyardManager`, m11/outyard; title "Luta da Terrálem"). 4 difficulties × 7 areas.
- **Areas:** each area allows `MaxChallenge` wins (5,3,2,2,1,1,1) per reset and grants `ShuttleScore` (10-50) per win against `HeroTempId` (GameHeroTemp 2500xx), using up to 3 Einherjars.
- **Progress chests** per difficulty at thresholds 10,20,30,40,50,70,90,110,140,170,210,250,300,350,400 (`OutyardProgressChest.as:125`); prizes 208062 (Esfera Mágica de Einherjar) + 208063 (10+15 at diff 1 → 25+30 at diff 4).
- **Resets:** weekly (Sunday 0h) with `shuttle_reset_free=2`; paid `shuttle_reset=2,2000`, `shuttle_refresh=10,100`. Zona Proibida bosses: `arcane_zone_*`.
- **Proto:** `ShuttleRequestMsg{op, petList, fight_pet, difficulty, area, reward_index, pay_type}` / `ShuttleInfoMsg{current_difficulty, areaLeftCount, shuttle_score, reset_count, refresh_count, arcane_zone_count...}`; opcodes `8475 C_SHUTTLE_REQUEST` (`OutyardManager.as:326`) and `4460 U_C_SHUTTLE`. Activity queue 15.

### 1.26 Bar da Fantasia: `MagicPubNpcInfos`, `MagicPubChatInfos` (m11/magicpub)

Building 1601 (Leader lv32). 5 NPCs (Miguel, Baiding, Diana, Sandy, Brad; icon `/magicpubnpc_{id}.png`, swf `/{id}.swf`).
- **Dialogue:** lines per NPC × friendship level 1-4 (`GreetWord`/`AskWord`/`ThankWord`, "|"-separated, `MagicPubChatView.as:227-233`).
- **Friendship:** UpGrade Types 126 (0,155,300,...,900) (`MagicPubChatView.as:259`).
- **Gifts:** -1700...-1709 (Sorvete...Álbum Novo), `magic_pub_present_count=10`/day. Each gift gives `2,4,6,8,12` friendship and `60...120` dust by quality; each chat gives `5,7,9,12` friendship and `50,65,80,100` dust.
- **Buff:** "Coração sincero" (Fonte Mágica 15) doubles these gains.
- **Opcodes:** `9632 C_MAGIC_PUB_OP`, `404 U_C_MAGIC_PUB`.

### 1.27 Castle opcodes

| Dir | Code | Name | Handler/sender |
|---|---|---|---|
| send | 8202 | C_BUILDING_CREATE | BuildingSocketOutManager.as:20 `{sonType}` |
| send | 8203 | C_BUILDING_UPGRADE | BuildingSocketOutManager.as:28 `{buildingId}` |
| send | 8279 | C_LOAD_BUILD_ORDER | BuildingSocketOutManager.as:36 |
| send | 8281 | C_BUILDING_INIT | NewbieSocketOutManager.as:59 (tutorial) |
| send | 8327 | C_GOLD_IMPOSE | PlayerManager.as:1710 `PlayerOpMsg{op}` |
| send | 5015 | U_C_CASTLE_UPDATE | ResourceManager.as:108 (30 s sync) |
| send | 5172 | U_C_BUILDING_ORDER_QUICK | BuildingSocketOutManager.as:42 `{orderId,index,...}` |
| send | 5173 | U_C_BUIDLING_TRANS_COOL | BuildingSocketOutManager.as:70 `{payType}` |
| send | 5174 | U_C_BUILDING_UPENERGY | BuildingSocketOutManager.as:78 `{payType}` |
| send | 5175 | U_C_BUILDING_ORDERADD | BuildingSocketOutManager.as:62 `{payType}` |
| send | 5176 | U_C_BUILDING_TRANSCASTLE | SocketSendManager.as:130 |
| send | 5178 | U_C_TREE_PICK | BuildingSocketOutManager.as:94 (tree) |
| send | 5179 | U_C_UNOCCPWILDLAND | BuildingSocketOutManager.as:86 `{position}` |
| send | 15017 | CH_TREE_WATER | BuildingSocketOutManager.as:102 |
| send | 8747 | C_ENTER_CASTLE | SocketSendManager.as:531 |
| send | 8535 | C_CANCEL_TRANS | SocketSendManager.as:485 |
| send | 8562 | C_CASTLE_TIME_CANCEL | PlayerBufferManager.as:374 |
| accept | 4153 | U_C_LOAD_CASTLE | LoginInitDataAccept.as:101 `BaseCastleMsg` |
| accept | 4154 | U_C_LOAD_BUILD | LoginInitDataAccept.as:102 |
| accept | 4155 | U_C_LOAD_BUILD_ORDER | (login) |
| accept | 4130 | U_C_BUILDINGINFO_LIST | BuildingManager.as:68 `BuildingInfoListMsg` |
| accept | 4187 | U_C_BUILDING_ORDER_SEND | BuildingManager `BuildOrderList` |
| accept | 102 | U_C_BUILDING_ORDER_QUICK | BuildingManager `OrderQuickRspMsg` |
| accept | 104 | U_C_BUILDING_ORDERADD | BuildingManager `OrderInfoMsg` |
| accept | 103 | U_C_BUILDING_UPENERGY | BuildingManager `TransInfoMsg` |
| accept | 108 | U_C_UNOCCPWILDLAND | BuildingManager `GiveupWildLandMsg` |
| accept | 4242 | U_C_GOLD_IMPOSERESULT | BuildingManager.as:112 `GoldImposeMsg` |
| accept | 152 | U_C_SECURITY_INFO_UPDATE | BuildingManager `CastleYieldMsg.wildYield` |
| accept | 109 | U_C_CASTLE_UPDATE | ResourceManager.as:61 `CastleYieldMsg` |
| accept | 105/4159 | U_C_BUILDING_TRANSCASTLE / U_C_TRASNBUILDING_RESULT | PlayerManager.as:156-157 |
| accept | 101 | U_C_BUIDLING_TRANS_COOL | - |
| accept | 118 | U_C_CASTLE_DEFENSE | OuterCityController.as:825 (m3) |
| accept | 151 | U_C_BUILDING_ORDER_INFO | - |
| accept | 4452 | U_C_CASTLE_TIME | PlayerBufferManager.as:85 (protection) |
| accept | 147/106/4146 | U_C_TREEINFO_UPDATE / U_C_TREE_PICK / U_C_TREE_FRIEND | castle tree |

## 2. Maps, campaigns and map PvE modes

This section covers the walkable scenes (`MapInfos`), the Reino do Céu hub, the campaign system (`Campaigns`) with its
Energy and sweep rules, and the PvE modes that run on their own maps.

### 2.1 Maps (`MapInfos`): world, instances and Reino do Céu

- **Scope:** every walkable scene. `MaptemplateCate.getTemplateByID` loads each `MapInfos.Id`
  (`decompiled/core_module/scripts/yishi/datas/templates/cate/MaptemplateCate.as:22`; ids > 100000 become 100) into
  class `map/internals/data/template/MapTemplate.as`.
- **Types (`Type`, inferred from data):**
  - `0` = world/outer city: 1 Pasto Livre, 2 Floresta Nublada, 3 Pântano Sem Fim, 4 Deserto da Morte, 5 Terra do
    Julgamento, all 10000×10000, level 1-999; 100 Costa do Crepúsculo, level 8-10.
  - `1` = campaign map (1105 rows).
  - `5` = Reino do Céu (10000), the space hub that holds the `MapNodeInfos` NPCs.
- **Campaign link:** `CampaignId` points to `Campaigns.CampaignId`. One campaign can span several maps, e.g. Labyrinth
  floors 8001-8100 (`WorldBossHelper.checkMaze`, `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as:114`).
- **Graphics** (details in [docs/client/graphics.md](../../docs/client/graphics.md) §4):
  - 300 px tiles in `mapmaterial/land/{MapFileId}/tile_{x}_{y}.jpg`
    (`decompiled/m3/scripts/com/road/yishi/bg/BgLayer.as:55,361`);
  - map data in `maps/{MapFileId}/{MapFileId}.maps|.titles` (`PathManager.as:208-215`);
  - animated map name in `images/mapName/{MapFileId}.png` (`PathManager.as:262`).
- **Battle:** `BattleGround` selects the fight backdrop `sceneIma/{BattleGround}/map{BattleGround}.swf`
  (`decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:117`, `PathManager.as:168`) and the
  battle track, at index BattleGround+1 (`decompiled/core_module/scripts/battle/control/BattleMapSoundControl.as:60`).
- **Music:** `MusicPath` accepts a comma-separated list; the client picks one at random (`SoundManager.dynamicPlayMusic`,
  `decompiled/core_module/scripts/com/pickgliss/utils/SoundManager.as:366`).
- **Unused fields:** `Description` and `Index` are always empty or 0.

### 2.2 Reino do Céu nodes and NPCs (`MapNodeInfos`)

- **Loading:** 58 nodes, all with `MapId=10000`. `SpaceTemplateResolve` (`TempleteManager.as:1449`) loads them, and
  `decompiled/core_module/scripts/map/space/SpaceManager.as:344-395` converts them to `SpaceNode`.
- **Name:** `NodeName` has the format "Name,Function", e.g. "Tina, Portal dos Heróis".
- **Types (`MasterType`, enum `map_node_type`):**
  - 61 = dialog NPC (37 nodes);
  - 40 = spawn point (node 14; `BornPoints` is used only server-side);
  - 171 = portal to another map, e.g. node 5 → `MoveToMapId` 20001 Ilha dos Einherjars, node 2000101;
  - 300 = "Pilha de Presentes" (30001-30020). Nodes 300-315 and 410 are New Year collection nodes
    (`SpaceNodeType.isYearNode`, `decompiled/core_module/scripts/map/space/data/SpaceNodeType.as:87`); collecting
    sends `sendYearBoxCollect`.
  - Constants in `SpaceNodeType.as:6-16`: 0 static, 1 moving, 40, 42 trigger, 62 transfer, 191 treasure map.
- **Rendering (`Resource`):**
  - 1 = NPC avatar, on the NPC layer;
  - 2 = building `mapmaterial/build/{SonType}.swf` (`PathManager.as:233`).
  - Screen position: `FixX/FixY` in pixels if both are ≠ 0; otherwise `PosX*20`, `PosY*20`
    (`decompiled/m3/scripts/map/space/view/layer/SpaceBuildingLayer.as:77-93`).
  - `HandlerRange` = interaction radius in cells (`decompiled/core_module/scripts/map/space/SpaceModel.as:391`).
  - `Toward` = facing, 0 or 180°.
- **Dialog** (`decompiled/m3/scripts/map/space/view/frame/SpaceDialogFrame.as:205-213`):
  - `Param3` lists the options as "type,title,minLevel|...";
  - `Param4` holds each option's parameter, index-aligned with `Param3`; e.g. option 7 gets story quest id `|1926`;
  - `Param5` holds `$`-separated lines;
  - `ItemExchange` defines trades as "costId,qty#gainId,qty|...". E.g. Papai Noel "2126900,5#2060072,2" trades 5× item
    2126900 for 2× 2060072 (option 107, `DialogOptionItem.as:931`).
- **Dialog options:** switch in `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:349-900`; the minimum
  level is checked at :344 (enum `space_npc_option_type`). Examples: 2 Portal dos Heróis (PvE rooms, level 20);
  9 Arena Einherjar; 11 Missão de Ciclo (≥ 35); 14 Caminho do Céu; 100 Loja Misteriosa; 108 Caminho da Glória;
  117 Julgamento Principal; 131 Vórtice; 132 Crise dos Planos; 134 Continente dos Demônios; 147 Caminho da Salvação;
  153 Loja do Labirinto Negro; 156 Caminho da Realeza.
- **Opcodes:** `8688-8692 C_PLAYER_SPACE_ENTER/LEAVE/MOVE/NODE_TRIGGER`, `9547 C_SPACEMAP_ATTACK`,
  `4592-4607 U_C_PLAYER_SPACE_*`. Senders in `decompiled/core_module/scripts/map/space/manager/SpaceSocketOutManager.as:50-101`.

### 2.3 Campaigns and PvE instances (`Campaigns`)

- **Loading:** 285 campaigns, resolved by `CampaignTemplateResolve`
  (`decompiled/core_module/scripts/yishi/resolve/CampaignTemplateResolve.as:18`). `TempleteManager.campaignTemplateBack`
  (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2570-2600`) then splits them by `Types`:

  | Types | Target dictionary |
  |---|---|
  | 0, 13, 51 | `campaignTemplateDic` (PvE) |
  | 5, 50, 12 | `pvpWarFightDic` |
  | 9 | vehicle |
  | 26 | `timeVortexDic` (Vórtice do Tempo) |
  | other ≥ 1 | `worldBossDic` (activities) |

  The full table is in enum `campaign_type`. Examples: 1 Chefão Global (5001 Rei dos Lobos, 13:00-13:25), 4 Labirinto,
  7 guild Eremitério, 13 Roleta da Masmorra, 17 Perguntas, 25 Hegemonia dos Três Reinos, 51 Zona Proibida (31001+).
- **Hierarchy** (`decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:47-127`): `LandId` →
  `DungeonId` (chapter) → `AreaId` (area) → campaigns of difficulty 1-3.
  - `LandId=1`: shown in campaign selection (m13 `selectcampaign.SelectCampaignFrame`).
  - `LandId=0`: multiplayer instances opened from the PvE room (m9 `RoomRightView`).
  - `PosX/PosY` place the area icon. `AreaId` also names the images
    `images/InstanceImg/{AreaId}/{big|small|center|icon|name|open|over}.(jpg|png)` (`PathManager.as:272-359`).
- **Difficulty (`DifficultyGrade`):** 1 Normal, 2 Pesadelo, 3 Inferno
  (`decompiled/m9/scripts/room/view/pve/RoomRightView.as:631`).
- **Capacity (`Capacity`):** 1 solo, 4 team, 10000 open map. Types=0 has 85 solo and 56 team campaigns. `EnterNumb` > 1
  requires at least that many players in the room (`RoomRightView.as:929`).
- **Entry requirements** (`RoomRightView.as:1288-1316`):
  - `MinLevel` (e.g. Toca dos Lobos 11-13);
  - `NeedTransfer` (1st transfer), `NeedChangeJob`, `NeedThirdTransfer` (Avenger), `NeedTransferType=4` (Holy);
  - `NeedFightPower`, shown for cross-server campaigns (3,000 to 7,000,000);
  - Demônio Sanguinário also checks `MaxLevel`.
- **Progression** (`CampaignTemplateManager.checkCanChoose`, :135-160): `PreCampaignId` chains campaigns, e.g.
  1001 → 1002 → 1003. A campaign unlocks once the previous one has a rank; ranks arrive via `4151 U_C_RANK_LIST` in
  `CampaignRankManager.as`.
- **Activity subtypes** (`SonTypes`, getters in `decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:131-296`):
  301 Torre do Julgamento, 303 Molong, 304 Demônio Sanguinário, 305 Formação Mágica, 306 Piso do Tempo, 307 Roleta,
  309 Corrida contra o tempo, 310 Floresta Elemental, 400 special areas. Special areas by `AreaId`: 400 Templo de Tara,
  401 Ruínas de Narendra, 402 Corrente Mágica, 403 Santuário da Arma Divina, 404 Batalha dos Guardiões, 405 Prisão do
  Abismo, 406 Abismo de Gelo e Fogo.
- **Vórtice do Tempo (Types 26):** `SonTypes` = boss avatar (`decompiled/m11/scripts/timevortex/view/TimeVortexShowAvatar.as:77`);
  `MapIds` = boss "heroId,pos" (`TimeVortexChallengeFrame.as:592`).
- **Rewards:**
  - `Item` is only the drop showcase, a list of `ItemTempInfos.TemplateId` (`RoomRightView.as:706`;
    `SingleCampaignUIView.as:89`).
  - The real drop is server-side and arrives as cards: `135 U_C_CAMPAIGN_CARDS`, proto `CampaignCardsMsg`
    {card_count, pay_card_count, price, dropItems}. The player takes a card with `5122 U_C_CAMPAIGN_TAKE_CARD`.
  - `BaseGp` = base EXP (1100 in campaign 1001; grows with level *(assumption)*).
  - `StandSecond` = boss standard time used for the final grade
    (`decompiled/core_module/scripts/map/internals/view/displaye/CampaignResultView.as:105`).
  - `StandardDamage/Hurt=10000` (base 10000 = 100%) appears only on event maps.
- **Map nodes** (`decompiled/core_module/scripts/map/campaign/data/CampaignMapModel.as:722-750`): 40 start, 42 monster,
  41 boss/end. Senders in `decompiled/m3/scripts/map/net/MapSocketOuterManager.as:33-139`: `8196 C_NODE_LOCKSTATE`,
  `5121 U_C_CAMPAIGN_ARMY`, `5124 U_C_CAMPAIGN_SYNCPOS`. Movement arrives via `23 U_CAMPAIGN_MOVE` (accept).
- **Room and entry opcodes:**
  - `5023/5024/5026 U_C_CAMPAIGN_ROOM_CREATE/ENTER/LIST` (`RoomListSocketOutManager.as`);
  - `5039 U_C_CAMPAIGN_ENTER`, `5120 U_C_CAMPAIGN_EXIT`, `5180 U_C_CAMPAIGN_FINISH`, `5038 U_C_CAMPAIGN_SYSTEM_ARMY`, in
    `decompiled/core_module/scripts/map/campaign/CampaignSocketOutManager.as:42-330`.
- **Screens:** see [docs/ui/screens.md](../../docs/ui/screens.md) (map.campaign.*, selectcampaign). Managers are in
  [docs/client/managers.md](../../docs/client/managers.md) (CampaignManager, CampaignTemplateManager, CampaignRankManager).

### 2.4 Energy (Vigor, "weary") and sweep

- **Limits:** `PlayerInfo.WEARY_MAX=200`, `WEARY_GET_MAX=600`
  (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as:90-92`).
- **Refill:** back to 200 daily at 0:00 (tooltip `mainBar.view.ResourceView.componetPower`,
  `decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as:211`).
- **Potions:** recover at most 600 per day; the amount currently recoverable is `200 - weary`
  (`decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:906,926`).
- **Cost per campaign:** 20 Energy (ConfigInfos `SingleCampaign_Weary=20`, `MultiCampaign_Weary=20`, `Player_weary=200`,
  `Weary_Limit=600`). With less than 20 the player can enter but gets no rewards (alert `ThewAlertFrame.disclist04`,
  `decompiled/m13/scripts/selectcampaign/view/CampaignInfoView.as:330-346`).
- **Santuário/statue (hook):** +1 Energy per 2 min of practice.
- **Sweep:** opcode `8528 C_CAMPAIGN_SWEEP`, proto `CampaignSweepReq`
  (`decompiled/core_module/scripts/managers/MopupManager.as:264-278`).

  | Sweep | Max times | Time and gold | Source |
  |---|---|---|---|
  | Campaign | floor(weary/20) | n × 60 s (`Campaign_Sweep_Time`), 5000 gold (`Campaign_Sweep_Gold`) | `decompiled/m5/scripts/mopup/view/CampaignMopupPrepareFrame.as:192-276` |
  | Vórtice do Tempo | floor(weary/10) | 500,000 gold | `TimeVortexMopupPrepareFrame.as:183` |
  | Labirinto (per floor) | - | 6 s and 1000 gold per floor (`Tower_Sweep_Time/Gold`) | - |

  Speeding up a sweep costs `Sweep_Fast` "1,10" (diamonds/minute).
- **Remaining Energy opcode:** `4199 U_C_LEFT_WEARY`.

### 2.5 Solo trail campaign (`SingleCampaignDatas`)

- **Structure:** 301 nodes in 83 solo campaigns (1001-1602). The UI shows 4 nodes per campaign (`Index` 1-4; 4 = boss
  with `MasterType` 41, the others 42). Index 0 nodes are hidden
  (`decompiled/m3/scripts/map/campaign/mediator/singlecampaign/SingleCampaignUIView.as:60-80`).
- **Enemies:**
  - `Heros` = "heroId,pos" in GameHeroTemp, e.g. "1011,5" (Lobo Maligno);
  - `Soldiers` = "pawnId,pos|..." in PawnTempInfos, e.g. "2011,2|2011,8" (Lobo Do Pasto).
- **Avatar:** `swf/{ResPath}/{ResPath}.swf` (e.g. monster002A, boss010B), scaled by `Scale`% and offset by
  `Param1/Param2` px (`SingleCampaignNpcNode.as:119`).
- **Flow:** only the current node has a challenge button. Opcodes `8666 C_NEW_SINGLE_CAMPAIGN_FIGHT`
  (`CampaignSocketOutManager.as:327`), `4282 U_C_NEW_SINGLE_CAMPAIGN`.

### 2.6 Campaign data (`CampaignData`, 0 rows)

- **Loading:** `GodArriveTemplateCate` (`TempleteManager.as:1189`) loads the template set and maps it to `GodArriveData`.
  Class fields: Id, CampaignId, NodeName, MasterType, SonType, Property1-4, HeroGP, Level, BattleType, Formation,
  HeroIds, Param1-6.
- **Users:** Solo Pass/"Chegada dos Deuses":
  - `getGodArriveData(40001, tollgate)` in `decompiled/core_module/scripts/managers/SinglePassManager.as:153`;
  - boss icon `images/level/{GameHeroTemp.ResPath}.png` (`decompiled/core_module/scripts/yishi/utils/IconFactory.as:184-197`).
- The BR dump is empty, so these modes have no boss data in the client.

### 2.7 Campaign buffs (`CampaignBufferTemps`)

- **Loading:** 165 buffs (`TempleteManager.as:1172`). Lookup by `TemplateId` or by `Types+Grades`
  (`CampaignBufferTemplateCate.as:36-80`). The player receives the buff as `PlayerBufferInfo` type 0 (CAMPAIGN_BUFFER),
  resolved in `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerBufferInfo.as:275`.
- **Icon:** `{res}icon{Icon}`, e.g. `icon//buff_addall.png` (`decompiled/core_module/scripts/mainBar/view/PlayerBufferItem.as:142`).
- **Example families:**
  - 3 Espírito da Coragem lv1-10 (+5...+50 ATK/HP, battlefield);
  - 7 Inspiração do Chefão Global (+500 ATK per level);
  - 19 Amizade (map EXP +5%...);
  - 30 Alma Gêmea, marriage buffs (`IconFactory.as:243`, `MarryTip`);
  - 36-39 Hegemonia dos Três Reinos;
  - 40 Luz do Dia (`decompiled/m3/scripts/sandbox/daylight/DayLightRightView.as:140`).
- **Ignored fields:** `Crit` and `Block` do not exist in the client class.

### 2.8 Caminho do Céu (`SkyTrial*`)

- **Structure:** 20 floors (`SkyTrialLayerTempInfos`), each with 3-6 elemental portals (90 in `SkyTrialPortalTempInfos`,
  `PortalId` = floor×100 + index). `NatureType` 1-6 = Fire, Water, Shock, Wind, Darkness, Light
  (`decompiled/m11/scripts/skyboxroad/view/SkyBoxRoadCheckPointView.as:298`).
- **Search:**
  - each search costs `EnergyCost=20` moves;
  - moves: max 500 (`skytrial_max_energy`), reset at 0h, +100 per 25 diamonds up to 3× per day;
  - "search all": n = min(Total − done, 10) (`SkyboxRoadExploreView.as:299-301`);
  - 100% exploration (`TotalSearchCount`: 10 on floor 1, 50 on floor 20) unlocks the boss; beating it grants the portal's
    `ClearReward`, e.g. 101 = Proteção do Fogo Nv.2 + 500,000 gold + 50 Pedras do Crescimento.
- **Floor prize:** clearing all portals grants the floor's `ClearReward`, e.g. floor 20 = 10.5M gold + 675 Esferas
  Avançadas 3040002.
- **Random events** (`SkyTrialEventTempInfos.Reward` "type,id,qty"): type 1 item (-100 = Gold), 2 daily buff +2%
  ATK/DEF/HP (skills 404020xx-404040xx), 4 moves +40/+60. `NeedMinLayer` 11 unlocks the 2xxx events.
- **Exploration points:** max 1000. They buy skills (`skytrial_skill` 40401000-002, 100 each, up to 5) or the helper
  Glorya (103000, 75% of attributes, 200 points).
- **Resources:** `images/skytrail/portal{ResourcePath}`, `images/skytrail/scene{ScenePath}` (`PathManager.as:778-785`).
- **Opcodes:** `8636 C_SKY_TRIAL` (ops 1 info ... 11 leave point), `4552 U_C_RES_SINGLEPASS_INFO`, `460 U_C_SKY_RANK`,
  `459 U_C_SKY_POINT_REQ`. Manager: `decompiled/core_module/scripts/managers/SkyboxRoadManager.as`.

### 2.9 Labirinto Negro (`DarkMaze*`)

- **Format:** temporary event with 20 floors; each floor is a 22-node graph in 4 zones
  (`decompiled/core_module/scripts/mvc/module/darkmaze/DarkMazeModel.as:21`). The team is the player's Guardians
  (children).
- **`DarkMazeLayerTemplates` (not loaded by the client):** count of each event type per zone.
- **`DarkMazeEventTemplates.EventType`** (enum `dark_maze_event_type`, `DarkMazeModel.as:23-41`):
  - 1 common, 2 elite, 3 boss: `Reward` "-17000,N" (Alma do Labirinto) with N = 100/150/200 + 10×(floor−1);
    `Param2` = formation "pawnId,pos|...";
  - 4 fountain: +50% HP;
  - 5 demon: revives 1 unit;
  - 6 hunter: `Param1` = 5 mercenaries (`DarkMazeChildTemplates.Id`);
  - 7 shop: `Param1-3` = "item,qty,price,discount%", e.g. 2× Tomo da Deusa for 1600 diamonds (−40%).
- **Mercenaries (`DarkMazeChildTemplates`):** fixed attributes, e.g. floor 1 Cavaleiro Sagrado with 2.7M ATK and
  16.5M HP. Power = Atk + Def + int(MAtk×1.05) + MDef + ForceHit + Live + Parry + (Penetrate + Stun)×20 + (ReduceResi +
  6 resistances)×10 (`DarkMazeModel.as:371`).
- **Costs and schedule:** reviving all costs 500 diamonds (`dark_maze_revive_point`). The mode resets weekly; the
  labyrinth closes 30 min before each reset.
- **Opcodes:** `8662 C_DARK_MAZE_OP` (ops 1 enter, 2 floor, 3 portal, 4 formation, 5 revive, 6 buy, 7 leave),
  `4278 U_C_DARK_MAZE_DATA`. Shop: `view.subshop.DarkMazeShopFrame` (m15).

### 2.10 Caminho Final (`FinalRoad*`)

- **Structure:** 3 chapters (1 Easy, 2 Normal, 3 Hard; unlocked at Royalty level 10/20/30), each with 6 groups × 5 stages
  = 30 stages. The client does not load `FinalRoadLevelTemplates`; its `EventNum` (1-3) gives the cards per stage.
- **Events (`FinalRoadEventTemplates`):**
  - type 1 = boss `Para1` "heroId,5" (e.g. 81010101 Laerte) + troops `Para2`, image `images/level/{Para4}.png`
    (`decompiled/m11/scripts/finalroad/FinalRoadLevelItem.as:98`);
  - type 2 = pass buff (skill list in `Para1`).
- **Group prize:** `FinalRoadGroupTemplates.Reward`, e.g. 144/108/84 Baús de Fragmentos de Alma da Guerra (2061024-26).
- **Entries:** 1 free per week + 7 purchases (300, 300, 500, 600, 800, 1000, 2000 diamonds, `FinalRoadFrame.as:138`).
  A re-challenge costs 50 diamonds, up to 3×. Reset on Sunday at 23:30.
- **Opcodes:** `9711 C_FINAL_ROAD_CLIENT_OP` (0 buy, 1 enter, 2 challenge, 3 retry, 4 give up),
  `532 U_C_FINAL_ROAD_CHAPTER`, `533 U_C_FINAL_ROAD_GROUP`.

### 2.11 Guerra dos Planos (`Planes*`)

- **Planes:** 24, in 6 elements × 4 sizes.

  | Size | Layers (`TotalLayer`) | HP (`LifePoint`) | Grid (`Size`) |
  |---|---|---|---|
  | Secondary | 5 | 1600 | 8×8 |
  | Low | 11 | 3600 | 10×10 |
  | Medium | 11 | 11250 | 10×10 |
  | Large | 17 | 17500 | 12×12 |

  Hidden layers are 3×3. Entry is through the Transfer Building (m4 `transferbuilding`).
- **Layers (`PlanesLayers`, `LayerTempId` = PlanesTempId×1000 + LayerNum):**
  - map `planeswar/map/{LandType}/{Size}.jpg` (`PathManager.as:302`);
  - `ResistType` = the resistance that reduces the energy cost;
  - `EnemySkill` = floor monster buff;
  - occupying the layer (by beating Protetor 14001) yields `DailyRewards` by mail (208028/208030) and permanent ‰
    bonuses: `*ResiBonus` 5/15/20 and Anti-RES 10/20/30
    (`decompiled/core_module/scripts/mvc/module/planeswar/PlanesWarModel.as:186-258`).
- **Events (`PlanesEvents.EventType`, `PlanesConstClass.as:6-42`):** −1 wall, 1 boss (gold key), 2 Julgamentos,
  3 Mercado Negro (price = base × discount/100), 5 Mine ("1440,60,-500,20" = 20 bound diamonds per hour for 24 h),
  12 castle, 13 patroller (silver key), 14 Protetor, 61-92 entrances and exits.
- **Energy:**
  - effective event cost = int(EnergyCost × (1500 + 3R)/(1500 + 4R)) (`PlanesWarModel.as:395-409`);
  - regeneration: +50 every 30 min, up to 1500;
  - purchase: 100 per 30 diamonds, up to 5× per day;
  - revive: 10 diamonds;
  - plane HP: restored with `AddLifeItem` 2131060-63.
- **Buyable functions (`PlanesFuncTempInfos`):** 101 clear obstacles, 201 summon guardian; each costs 100 energy or
  100 diamonds.
- **Opcodes:** `9527 C_PLANES_WAR_REQ`, `4941-4944 U_C_PLANES_WAR_LIST_MSG/RSP_MSG/MAP/ENERGY`.

### 2.12 Crise dos Planos (`CrisisMapInfos`, `CrisisEventInfos`)

- **Maps:** 3 graphs (`MapId` 1-3, with 104/106/85 nodes). `X/Y` are pixel positions on a 2659×2320 map; adjacency is in
  `LineNode` (`decompiled/core_module/scripts/yishi/datas/templates/PlaneCrisisTempInfo.as:25`). `NodeType`: 1 spawn,
  2 boss spawn, 10-12 green/red/yellow clouds.
- **Events (`EventType`, `PlaneCrisisEventType.as:28-44`):** 1 final boss Medusa (125101), 2 mechanism "Alma perdida"
  (gives the boss Reflection, −20% damage or +20% HP), 3 mid boss (crystals), 5 chest, 6 key, 7 crystal, 8 movement
  stone. `Property3` = "teleportCost|attackCost".
- **Movement:** 20 starting points, 1 per step; a one-time purchase adds +10 for 20 diamonds. 1 reward per day, by score
  tier (`crisis_bonus_show`).
- **Opcodes:** `9675 C_CRISIS_GAME_OP` (ops 1-10), `4867-4876 U_C_CRISIS_*`. Resources in
  `mapmaterial/land/planecrisis/{land,small,line}` (`PathManager.as:840-852`).

## 3. Exploration modes

Exploration modes are map-, graph- or board-based PvE activities with their own currencies, attempt limits and
template sets; most use a single `PackageOut` opcode with an `op` field.

### 3.1 Labirinto de Minos (guild): `MinosLevelTmpls`, `MinosNodeTmpls`, `MinosRewardTmpls`

- **Scope:** weekly guild mode (7-day season, `Minos_Opendays=7`). The map is a grid (91 px cells) of nodes that
  accumulate collective progress. Completing a node (progress ≥ `NodeValueMax`) unlocks its neighbors; defeating the
  **Senhor** (NodeType 5) unlocks the next stage. Challenges close on Sundays 23:30→06:00 (`Minos_CloseTime=390` min
  before the end).
- **Stages (`MinosLevelTmpls`):** 4 stages ("1ª Fase".."4ª Fase") unlocked at guild level 1/3/5/7 (`GuildLevel`); image
  `images/level/{LevelImage}.png` (boss006, boss017, boss001, boss021) via `IconFactory.getIncreasinglyBossIcon`
  (`decompiled/core_module/scripts/yishi/utils/IconFactory.as:297`). `NodeNum` = `type,qty|...` (stage 1: 50 soldiers,
  5 large soldiers, 4 guardians, 1 lord; grows +6/+1 per stage); server-only.
- **Nodes (`MinosNodeTmpls`, 212 rows):** `Id = ForLevel*10000 + NodeType*1000 + NodeId*100 + NodeGrade`.
  - Types: 1 Start, 2 Soldier, 3 Soldier (2x2), 4 Guardian (2x2, boss `Heroes`), 5 Lord (2x2); see
    `MinosNodeTempInfo.size` (`.../templates/MinosNodeTempInfo.as:43`).
  - Each node has 4 difficulty variants (`NodeGrade` 1 Normal, 2 Difícil, 3 Pesadelo, 4 Inferno; `minos.diffN`); each
    win adds `GardenValue` to the progress (stage 1, soldier: 9/11/15/22 of 86; guardian: 34/42/50/63 of 500).
  - Per-win prize: `RewardItem1..3 × RewardNum` (1/2/4/6 by difficulty; e.g. 2250001 Sangue de Zeus, 2260001 Livro da
    Sabedoria, 208017 Pedra Bestial; guardians give 208046-208048 Guardian essences).
- **Attempts:** `remaining = Minos_ChallengeCount(10) + buyCount − challengeCount`; up to 5 purchases per day at
  100 diamonds (`Minos_ChallengePrice=5,100`), see `decompiled/m6/scripts/consortia/view/minos/ui/MinosMapViewUI.as:103-110,372`.
  Unused attempts do not accumulate.
- **Prizes (`MinosRewardTmpls`):**
  - `RewardType 1` = season prize, by Virtue ranking position (`RewardCondition` "1,1", "4,10", "21,300"; 1st place:
    50× 208062 Esfera Mágica de Einherjar, 10× 6260003, 50× 6260001, 50× 212018, 1500× resource −21000), sent by mail;
  - `RewardType 2` = personal Virtue prize (500..15000; 208500 Martelo de Luz, 208055, 208550, 5010001).
  - Players with 0 Virtue get nothing.
- **Code:** `decompiled/core_module/scripts/managers/MinosManager.as:56` (handlers 552-557); sends `PackageOut(9729)` in
  `MinosManager.as:218` with `PlayerOpMsg{op,index=stage,id=x,pos=y,type=difficulty}`; ops in
  `decompiled/core_module/scripts/mvc/module/minos/MinosConst.as:6-20` (1 open ... 5 fight, 6 node_reward,
  7 feat_reward, 8 buy_count). UI in `decompiled/m6/scripts/consortia/view/minos/` (MinosEnterFrame, MinousmapFrame,
  MinosGJRewardFrame "Prêmios de Virtude", MinosSeaonRewardFrame "Prêmios da Temporada").
- **Opcodes:** `9729 C_MINOS_CLIENT_OP`; `552 U_C_MINOS_DATA`, `553 U_C_MINOS_LEVEL_UPDATE`, `554 U_C_MINOS_MAP_DATA`,
  `555 U_C_MINOS_NODE_UPDATE`, `556 U_C_MINOS_PLAYER_DATA` (feat, challengeCount, buyCount, levelRewardInfo,
  featRewardInfo), `557 U_C_MINOS_RANK_DATA`. Protos: `com.road.yishi.proto.consortiaplay.Minos*Msg`.

### 3.2 Expedição do Eremitério (秘境探险): `SecretMapLevelTemplates`, `SecretSonLevelTemplates`, `SecretMapDataTemplates`, `SecretEventTemplates`

- **Scope:** solo exploration on hex maps (scene `SECRET_ADVENTURE_SCENE`). 4 elemental areas
  (`SecretMapLevelTemplates.Type` 1 Fire, 2 Wood, 3 Water, 4 Wind) unlock by "Caminho da Realeza" level (6/8/11/15, text
  in `Description`). Each area has 3 sublevels (`SecretSonLevelTemplates`, LevelId 1-12, linear) with 1-3 submaps
  (`MapNum`).
- **Rules:** HP persists (hp/initHp); revive after 24 h or for 30 diamonds/hour (`secretexplore_revive_*`); the mode
  pauses on Sunday 23:30-23:59 (`secretexplore_close_time`).
- **Submap (`SecretMapDataTemplates.MapDatas`):** rows separated by `|`, cells by `,`; each value is a
  `SecretEventTemplates.Type` (0 = no cell, −1 = empty path). `cellId = row*maxColumns + column`
  (`decompiled/m3/scripts/secretadventure/map/SecretSonMapView.as:91-92`). Goal = `AdoptCondition` (801 kill the Lorde
  Elemental, 802 trigger the event "Salve a Eliza", 803 eliminate all Guardians).
- **Events (`SecretEventTemplates`, 149 rows, `FunType` 0-18):**
  - 2 Cavaleiro Perdido (dialog halfman.swf + fight `Para1` "5201001,5");
  - 3 Loja Misteriosa (`Para1` "itemId,qty,price,discount%|...", e.g. 2127022×10 for 100 at 80%);
  - 4 Chest;
  - 5 Elemental Mechanism (removes obstacle `Para1`=401..404);
  - 6 Elemental obstacle;
  - 8 Switch (toggles pillars `Para2` "701,704");
  - 9 Sun/moon pillar;
  - 10 Info Box (801-803);
  - 11 Castle (delivery, halfwoman.swf);
  - 12 Birth Gate;
  - 13 Final diaphragm;
  - 14 Transmitter (next level);
  - 15 Blessing (heals `Para1`=10%);
  - 16 walls/mountain;
  - 17 monsters (2001-2003);
  - 18 Lorde Elemental (2501).

  Scaling events have one row per `LevelId`. Click handling:
  `decompiled/m3/scripts/secretadventure/item/SecretHexagon.as:539-572`.
- **Drops:** `SecretMapLevelTemplates.Drop` lists the possible items (2127021-2127026 Pedras de Fort. de Tesouro Externo,
  2131526-2131530 Baús do Tesouro Externo).
- **Code:** `decompiled/core_module/scripts/yishi/manager/SecretAdventerManager.as:70-73` (handlers); sends
  `PackageOut(9706)` with `PropertyMsg.param1` = 1 floor, 2 buy, 3 event, 6/7/8 common ops that reset the model
  (`SecretAdventerManager.as:169-210`). UI in `decompiled/m3/scripts/secretadventure/` (SecretAdventureFrame
  "Expedição do Eremitério", SecretShopFrame, SecretDialogFrame, SecretAdEventFrame).
- **Opcodes:** `9706 C_SECRET_EXPLORE_OP`; `524 U_C_SECRET_EXPLORE_PANEL_DATA` (mapId, levelId, remainingTimes, hp...),
  `525 U_C_SECRET_EXPLORE_MAP_DATA` (mapDataIds, nodeId), `526 U_C_SECRET_EXPLORE_EVENT_DATA` (events
  {nodeId,eventId,state,params}), `527 U_C_SECRET_EXPLORE_CLOSE`.
- **Graphics:** `PathManager.getSecretSource(type, file)` → `{ResourcePath}mapmaterial/land/secret/{Type}/{file}` or
  `.../secret/{file}` (`decompiled/core_module/scripts/yishi/manager/PathManager.as:860`); background `map.png` per area;
  icons knight.swf, shop.swf, treasure.swf, switch.swf, suncolumn.swf, boss.swf, hero03.swf, 1-9.swf (`Resource=1` uses
  the element folder, `SecretNode.as:120`).
- Not to be confused with the "Batalha do Eremitério" (秘境战场, `war2023.*`, `SecretWarManager`), configs `secret_war_*`.

### 3.3 Desafio de Teseus (秘宝探险, StoreHouse): `StoreHouseChapterTmpls`, `StoreHouseMapTmpls`

- **Scope:** chapter-based roguelike tower with 20 chapters (`CampaignId` 50101-50120 in `Campaigns`, Types=29) of
  10-37 floors each (530 maps; `MapId` 4CCAA, e.g. 42035 = ch. 20 floor 35).
- **Skills:** on each floor the player picks 1 of 3 skills rolled from `SkillGroup` (`skillId,weight`; skills
  901xxxxx-903xxxxx from `SkillTempInfos`, e.g. 90301001 "Fortalecimento de Ataque Físico I"); screen "Escolha uma das três habilidades". Fixed active skills: `Storehouse_MainSkill=90100000|90200000|90300000`.
- **Prizes:** first clear gives `FirstPassAward` (chests 3501 Bronze ... 3505 Diamond); every 5 floors an extra drop
  `Award` "itemId,qty,weight‰" (e.g. ch.1 "3501,1,900|3502,1,100"; ch.20 up to 10‰ Diamond chest); empty = "Este andar não tem drop".
- **Limits:** 3 attempts per day, reset at 0h (`Storehouse_count`,
  `decompiled/m3/scripts/thessbox/view/ThessboxMainView.as:35`).
- **Code:** `decompiled/core_module/scripts/managers/TheseussoulManager.as:232-234` (handlers); `opThessbox` sends
  `PackageOut(9761)` with `PlayerOpMsg{op,chapterId}` (`TheseussoulManager.as:609`). UI in
  `decompiled/m3/scripts/thessbox/` (ThessBoxMainFrame "Desafio de Teseus", ThessBoxSkillBagFrame, ThessBoxDropFrame).
- **Opcodes:** `9761 C_STORE_HOUSE_CLIENT_OP`; `769 U_C_STOREHOUSE_USER_DATA` (opType, count, passChapter,
  firstReward), `770 U_C_STOREHOUSE_FIGHT_DATA` (curLevel, chapterId, mapId, equipSkills, allSkills, addSkill),
  `771 U_C_STOREHOUSE_ADD_SKILL`.
- **Graphics:** `icon/txschallengeNN.jpg` (`IconFactory.getCommonIconPath`); skill icons from `SkillTempInfos.Icons`
  (e.g. /skill_txs_sword01.png).

### 3.4 Exploração das Ruínas (遗迹探险): `RemainsExploreChapterTemps`, `RemainsExploreNodeTemps`, `RemainsExploreEventTemps`, `RemainsLeedTemps`

- **Scope:** 4 chapters (Deserto da Praga, Floresta Misteriosa, Pântano do Submundo, Penhasco abandonado) × 3 points
  (`CheckPointId` = ch*100+node). Each exploration spends **Faíscas** (`exploreCost`, base 20) and rolls an event from
  `EventGroup`; progress goes 0→100% (`EventCount` 20/25/30/35 explorations, server-side). A boss appears at 50% and a
  big boss at 100% (`decompiled/core_module/scripts/mvc/module/remainsexplore/RemainsExploreNodeInfo.as:27-32`).
- **Events:** `EventType` 1 monsters, 2 treasure, 3 mirror image (a mirror with 60% of attributes,
  `remains_mirror_percent`), 4 boss, 5 big boss (`RemainsExploreManager.as:37-45`). `Param1` = boss "heroId,pos",
  `Param2` = troops "pawnId,pos|...", `Param4` = `RemainsExploreDrop.dropId` (e.g. 19510101). Display:
  `RemainsExploreEventTempCate.getDrop` groups boss drops (4/5) apart from the others
  (`.../cate/RemainsExploreEventTempCate.as:39-58`).
- **Economy (`remainsexplore_config=20,300,6,6,6`):** 20 Faíscas per exploration, max 300, 6 purchases per day,
  boss/big boss spawn CD 6 h; each purchase gives 100 Faíscas for 200,200,300,500,800,1000 diamonds
  (`remainsexplore_tinder_buy`, `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1674-1686`).
- **Activity (`RemainsLeedTemps`):** daily (1xxx, target 3) and weekly (2xxx, target 10) goals per type (1 expeditions,
  2 bosses, 3 big bosses, 4 monsters, 5 mirrors, 6 treasures), each worth +20 activity (`GaintPoint`); chests at
  20/40/60/80/100 (`remains_daybox_values`/`remains_weekbox_values`) with items from `RemainsExploreBox` (site=type,
  para2=index). Row 1006 has the wrong text ("expedições" instead of treasures).
- **Code:** `decompiled/core_module/scripts/yishi/manager/RemainsExploreManager.as:83-85` (handlers); sends
  `PackageOut(9703)` with ops 0 data, 1 explore, 2 buy Faíscas, 3 attack, 4 collect, 5 chest (`:25-35`). UI in
  `decompiled/m11/scripts/remainsexplore/` (RemainsExploreFrame "Exploração das Ruínas", NodeFrame, DropFrame
  "Visualização do Drop", ActivityFrame "Prêmios de atividade"); tip `m16 RemainsExploreTip`.
- **Opcodes:** `9703 C_REMAINS_EXPLORE_OP`; `519 U_C_REMAINS_EXPLORE_INFO` (tinder, canBuyTimes, liveness,
  boss1/2NodeId, boxStates, nodeList), `520 U_C_DO_EXPLORE_UPDATE` (tinder, progress, eventType),
  `521 U_C_REMAINS_LEED_UPDATE`.

### 3.5 Terra Sombria (暗影之地): `ShadowLandTemplates`

- **Scope:** PvE campaign with 5 areas × 6 stages × 2 difficulties (1 Normal, 2 "Demônio")
  (`shadow_land_open_config=5,2`). `CheckpointId = diff*10000 + area*100 + node`. Each fight has 3 waves (`Npc1..Npc3`
  "pawnId,pos|...", positions 1-9) + boss `Bosses` "heroId,5" (e.g. 3920101 Lobo Maligno).
- **Rules:** max energy 200, +10/h, 10 per entry (`shadow_land_config`,
  `decompiled/core_module/scripts/mvc/module/shadowland/ShadowLandModel.as:91`). Sweep (Bot da Terra Sombria,
  m5/mopup): 60 s and 50000 gold per stage (`shadow_land_sweep_config`).
- **Drops:** `ShadowLandFightDrop` filtered by `site=Difficulty` and `para2="AreaId,NodeId"`
  (`.../cate/ShadowLandFightDropTempCate.as`); per-area star chests in `ShadowLandBoxDrop` (`site=difficulty`,
  `para2=area`; e.g. 7106002 Baú de Estela 2 estrelas). dropId = 192+CheckpointId (from data).
- **Code:** `decompiled/core_module/scripts/yishi/manager/ShadowLandManager.as:58` (517); `PackageOut(9702)` with ops
  0 data, 1 fight, 2 collect. UI in `decompiled/m11/scripts/shadowland/` (ShadowLandFrame "Terra Sombria",
  ChapterFrame, FightFrame "Normal {0}-{1}"/"Demônio {0}-{1}").
- **Opcodes:** `9702 C_SHADOW_LAND_OP`, `517 U_C_SHADOW_LAND_INFO`.

### 3.6 Expedição dos Espíritos Protetores (护灵远征): `ExpeditionTemplates`

- **Scope:** PvE with Guardians (children/spirits): 6 regions × 10 stages (`Id = area*100 + node`). `Star` = stage
  stars (1 in regions 1-2, 2 in 3-4, 3 in 5-6; stages 9-10 give 2-6).
- **Drops:** accumulated stars unlock `ExpeditionStarDrop`, whose `site` is the required star count (13, 26, 49, 72, 107,
  142; e.g. 208528 Livro de Habilidades Passivas, 208525 Pedra da Alma do Espírito Protetor). Per-stage drop:
  `ExpeditionFightDrop` (`site=AreaId`, `para2=NodeId`; e.g. 208526 Lâmina de Pedra ×30).
- **Energy (元神值):** max 1000; min 100 per fight, +100 per 100% HP lost; recovery CD 3600 min; speed-up 5 diamonds per
  30 min (`expedition_*`, `ConfigInfoManager.as:1602-1622`).
- **Code:** `decompiled/core_module/scripts/managers/SpiritExpeditionManager.as:53` (4274/4275); `PackageOut(8661)` with
  ops 1 data, 2 fight, 3 formation, 4 skills, 5 chest, 6 reset CD (`SpiritExpeditionOpClass.as:6-16`). UI in
  `decompiled/m14/scripts/childspiritexpedition/` (Formation "Ajustar Formação"); tip `m16 SpiritExpeditionNodeTips`.
- **Opcodes:** `8661 C_EXPEDITION_CLIENT_OP`, `4274 U_C_EXPEDITION_DATA`, `4275 U_C_EXPEDITION_EDIT`.

### 3.7 Histórico de Conquistas (HeroRoad): `HeroRoadTempInfos`

- **Scope:** tabbed achievement list (`MasterType`: 1 Growth 105 tasks, 2 Exploration 44, 3 Einherjar 31, 4 Guardian 13,
  6 Daily packs 32, 7 VIP packs 27, 8 Advanced 41). Each task (`SonType` 101 personal level, 103 mount, 119 clear
  campaign `Param1`, 123 Underground Labyrinth floor...) gives free `TakeItems` + `HeroRoadScore` history points
  (5/10/20) and may offer `BuysItems` for `BuyNeedPoint` diamonds. Tasks chain via `PreTaskTempId`/`Priority` and are
  shown from `OpenGrades`.
- **Packs:** SonType 1000 ("{0}º dia: Pacote", `Param1` = required history points, `Param2` = day) and 1001 ("Pacote de VIP {0}"); `QuestType 2` = cyclic/random pack (Pacote de Retorno Diário, 1→7 days).
- **Code:** `decompiled/core_module/scripts/yishi/manager/HeroRoadManager.as:28-54` (constants), `:110` (407),
  `operateHandler` `PackageOut(9634)` `:377`. UI in `decompiled/m11/scripts/heroroad/` (HeroRoadFrame "Histórico de Conquistas", HeroRoadConfirmFrame, HeroRoadGiftFrame).
- **Opcodes:** `9634 C_HEROROAD_OP`, `8671 C_ACHIEVEMENT_TASK_CLIENT_OP`, `407 U_C_HEROROAD_LIST`,
  `4288 U_C_ACHIEVEMENT_TASK_DATA`, `4289 U_C_ACHIEVEMENT_TASK_UPDATE`.
- **Graphics:** `icon/{TakeItemsIcon}` (e.g. icon//item_VIPcard.png, /box_gem1to5.png, /animal_soul.png).

### 3.8 Continente dos Demônios (EvilLand, 恶魔大陆): `EvilLandTemplates`

- **Scope:** 30 chapters × 10 stages (300 rows; e.g. "Costa dos Murmúrios" ... "Altar do Rei Demônio"). Stages 5 and 10
  have a boss (`Bosses`, e.g. 3840110 Meranus) and cost 25 Lágrimas with 3 attempts per day (`AttackCount`); the other
  stages cost 10 and are unlimited. `DialogId` triggers story dialog (U_C_DIALOG). Quest: "Salve as Deusas".
- **Economy:** Lágrimas da Deusa max 500, +20/h, 5 purchases at 250 diamonds (`evilland_goddess_tear_config`); +1 boss
  attempt per 50 diamonds (`evilland_buy_count_cost`); sweep 60 s/50000 gold.
- **Drops:** `FirstDropId` (384CCNN) and `AttackDropId` (385CCNN) → `EvilLandDrop.DropId` (e.g. 212029 Fragmento da Deusa
  da Magia ×3); star chests in `EvilLandBoxDrop` (site = stars 5/10/15/20/25; e.g. 212027 Larimar).
- **Code:** `decompiled/core_module/scripts/yishi/manager/DemonLandManager.as:48` (4879); `PackageOut(9676)` with ops
  0 data, 1 chapter, 2 node, 3 chest, 4 Lágrimas, 5 attempt (`:208-256`); sweep via `8528 C_CAMPAIGN_SWEEP`. UI in
  `decompiled/m11/scripts/demonland/` (AwardView: `remaining = AttackCount − attackCount + buyCount`,
  `AwardView.as:243-246`); bot in `m5/mopup` "Bot do Continente dos Demônios".
- **Opcodes:** `9676 C_EVIL_LAND_OP`, `8528 C_CAMPAIGN_SWEEP`, `4879 U_C_EVIL_LAND`, `4878 U_C_DIALOG`.

### 3.9 Caminho da Vingança (复仇之路): `RevengeRoadTemplates`

- **Scope:** 50 linear nodes in 5 areas (Pasto Livre, Floresta Nebulosa, Pântano Sem Fim, Deserto da Morte, Terra do
  Julgamento); node 10 of each area is a boss (3 attempts per day). Each attack spends 20 Corações de Vingança (`Cost`).
- **Economy (`revenge_road_config=200,10,3,500,3,80`):** hearts max 200, +10/h, 3 purchases per day at 500 diamonds,
  3 boss-attempt purchases at 80 diamonds; sweep 60 s/50000 gold.
- **Drops:** `FirstDropId` 3880NNN / `AttackDropId` 3890NNN → `RevengeRoadDrop.dropId` (e.g. 5010001 Cristal da Vingança
  ×5); area chests in `RevengeRoadBoxDrop` (`para2` = area 1-5, 50-...× Cristal da Vingança).
- **Code:** `decompiled/core_module/scripts/yishi/manager/RevengeRoadManager.as:29-37` (ops), `:61` (4895),
  `PackageOut(9688)` `:179`. UI in `decompiled/m11/scripts/revenge/` (RevengeFightFrame:
  `remaining = AttackCount + buyCount − attackCount`, `RevengeFightFrame.as:222`).
- **Opcodes:** `9688 C_REVENGE_ROAD_OP`, `4895 U_C_REVENGEROAD_INFO`, `4896 U_C_REVENGEROAD_DIALOG`.

### 3.10 Luta da Terralém and Casos da Terralém (HugeHead/StackHead, 外域): `HugeHeadMapNodeTempInfos`, `StackHeadExploreTempInfos`

- **Map (`HugeHeadMapNodeTempInfos`, 69 nodes):** 5 maps. Maps 1-4 are each faction's region (castle `NodeType 1` +
  11 occupiable territories `2` + exploration entrance `4`); map 5 is the center, with the Crystal (`3`) and
  16 territories. `InitForce` = initial faction (0 neutral), `NodeLink` = edges, `PosX/PosY` in px. Types 5-8 (titan,
  restricted area, abyss, vortex) exist in code (`decompiled/core_module/scripts/mvc/module/outyard/LandPoint.as:12-26`)
  but not in data.
- **Exploration (`StackHeadExploreTempInfos`):** dice-driven board (op 0 start, 1 move, 2 trigger, 3 exit, 4 recharge;
  `StackHeadExploreOpState.as`). 600 total points, 20 per roll, 100 per entry; a recharge converts 100 diamonds→200
  points (`huge_head_explore_*`, `ConfigInfoManager.as:114-129`). Events: Caso do Líder, Caçador de Tesouros (Goblin de
  Ouro, rare), Toca dos Monstros, Aprendiz, Baú, Altar do Cristal (rare), Cemitério da Maldade, Passageiro (EventType 3
  = teleport, `decompiled/m3/scripts/outyard/OutyardAreaView.as:250`). `MinCount/MaxCount/Rate` control generation
  (server-side).
- **Code:** `decompiled/core_module/scripts/yishi/manager/OutyardManager.as:84-92` (handlers); sends
  `PackageOut(9594/9595/9599/9608)`. UI in `decompiled/m11/scripts/outyard/` (OutyardFrame "Luta da Terrálem",
  OutyardEventFrame "Casos da Terralém") and `decompiled/m3/scripts/outyard/` (OutyardAreaView, AreaNodeView).
- **Opcodes:** `9594 C_HUGE_HEAD_REQUEST`, `9595 C_HUGE_HEAD_NODE_BATTLE_REQ`, `9599 C_STACK_HEAD_REQUEST`,
  `9608 C_STACK_HEAD_EXPLORE`; `349 U_C_HUGE_HEAD_BATTLE_FIELD`, `350 U_C_HUGE_HEAD_MY_SIGN_IN_STATE`,
  `351 U_C_HUGE_HEAD_NODE_BATTLE_FIELD`, `352 U_C_HUGE_HEAD_NODE_BATTLE_USER_RSP`,
  `306-311 U_C_STACK_HEAD_STATE/UPDATE/USER_LIST/BATTLE_DEFENCE/SELF`, `361 U_C_STACK_HEAD_EXPLORE`.
- **Graphics:** `{ResourcePath}{Resource}` = `stackheadexplore/{N}.swf` (6, 25, 24, 26, 2, 2007, event_dark04, 2335);
  default `mapmaterial/build/2003.swf` (`decompiled/core_module/scripts/mvc/module/outyard/AreaPoint.as:35`,
  `decompiled/m3/scripts/outyard/AreaNodeView.as:87`).

### 3.11 Legacy Eremitério with sacred power: `ExploreEventTemplates`

- **Status:** not loaded by `TempleteManager` (no client reference). The template set describes a floor-based exploration
  with "sacred power" (base 40, `explore_base_holy`) and hermitage medals:
  - EventType 1 Monsters (cost 1-12), 2 Chests (floor 5/10/15/20, lv1-5), 3 Blood Packs (heal 1-6), 4 Transmitter (next
    floor, no return), 5 Traps (−3..−8);
  - 6 active relics (Lança de Michelangelo, Luz divina 50%, Decisão, Encaração do Caron, Santo Graal);
  - 7 passive relics (Grama de Mandela +2, Oração 25%, Dendrobium +20%, Cornucópia +5, Minas do Rei Salomão 25% double
    prize).
- **Fields:** `RangeMin/RangeMax` = value range; `Icon` = resource ID. Reset items are in `explore_prop`. How the set is
  used today is entirely *(assumption)*.

### 3.12 Jardim Suspenso (空中花园): `AirGardenNodeTemplates`

- **Display bases:** bought in the "Loja do jardim" (`decompiled/m15/scripts/view/subshop/AirGardenShopFrame.as:244`):
  10001 Base de Moda (901, 50000, 1 purchase), 10002 Base do Guardião (902), 10003 Base da Montaria (903), 10004 Base da
  Einherjar (904). Prices progress 3000/5000/10000/18000/25000 in currency `airGardenBedCoin`; the limit equals the
  number of prices (`AirGardenBedTempInfo.limitCount`).
- **Interaction:** clicking a base on the garden map: 902-904 open `BED_CAMPAIGN_SHOW` (type 1-3); 901 asks "Deseja exibir a aparência atual?" (`decompiled/core_module/scripts/mvc/controler/AirGardenControl.as:94-124`).
- **Configs:** parties `air_garden_party_*` (cost 2000, weekdays 4 and 5 at 14:00/9:00), likes (5 per person, 50 per
  week, CD 480 min), minigames 100 per type.
- **Opcodes:** `5442 C_AIR_GARDEN_OP`; `376 U_C_AIR_GARDEN_STATE`, `377 U_C_AIR_GARDEN_LIST`,
  `379 U_C_AIR_GARDEN_CAMPAIGN_DETAIL`, `380 U_C_AIR_GARDEN_SELF`, `381 U_C_AIR_GARDEN_GAME_OPEN`
  (`decompiled/core_module/scripts/managers/AirGardenManager.as:58`).

### 3.13 Exploração Espaço-Tempo (时空探险, StarArea): `StarAreaRoadInfos`

- **Graph:** undirected, 92 nodes (start 43; big chests 8, 9, 85, 86;
  `decompiled/core_module/scripts/mvc/module/stararea/StarareaModel.as:18-46`) and 152 roads (`Node1`-`Node2`).
- **Road types:** the server sends each road's type by index (`Id−1`): 0 normal, 1 forbidden, 2 Zona Misteriosa (needs a
  key), 3 fight (monsters `star_area_sys_army`), 4 minigame (gem/link); see `StarareaManager.as:59-67`.
- **Nodes and actions:** light, chest, key, big chest (`star_area_node=28,34,4,19,7`). Action points: 10 per step,
  70 per day. `Group` is unused in the client *(assumption: roll group)*.
- **Drops:** `StarAreaDrop` by `site` (type 2 chest → −15000 ×200 points; 3 big chests per node in `para2`;
  5 → −15000 ×2000; 6 → 2183094 Carta Interestelar, chance 1000/100000).
- **Code and opcodes:** `9691 C_STARAREA_OP` with ops 1 open, 2 move, 3 use light, 4 game, 5 prize, 6 game end;
  `4899 U_C_STARAREA` (`StarareaManager.as:105`). UI in `decompiled/m3/scripts/stararea/` (StarareaBackView draws the
  lines, `:218-220`), also `m11/sevenyear/view/SevenYearStarAreaView`.

### 3.14 Caminho da Glória buffs (`GloryRoadBufferInfos`)

- **Mode:** daily challenge (reset at 0h) against mirrors; HP does not recover between fights.
- **Buff shop** (GloryRoadBuffFrame "Comprar Buff"): offers buffs sorted by `Pos` (1-4) with `Price` in buff stars
  (5-40). Types: 1 max HP +20..50%, 2 attack/magic +10..40%, 3 defense/resistance, 4 all resistances (summed in
  `GloryRoadModel.getBuffAtts`, `decompiled/core_module/scripts/mvc/module/gloryroad/GloryRoadModel.as:235-237`),
  5 rage +20/+40, 6 awakening +500/700/900, 7 heal 10-50%, 8 remove enemy guardian, 9 enemy leader HP −10..40%. Texts
  use `{Percent}`/`{Value}` (`decompiled/m9/scripts/gloryroad/component/GloryRoadBuffCell.as:84-90`).
- **Configs:** revive all/guardian 200/50 diamonds, chest 10 diamonds (`glory_road_*`). Drop: `GloryRoadDrop` (site =
  odd layers 1..13, −3900 Glory).
- **Opcodes:** `9624 C_GLORY_ROAD_OP`, `384 U_C_GLORY_ROAD_DATA`, `385 U_C_GLORY_ROAD_MIRROR`
  (`decompiled/core_module/scripts/managers/GloryroadManager.as:52`). See
  [docs/ui/screens.md](../../docs/ui/screens.md) (m9 gloryroad).

### 3.15 General references

- **Set loading:** `decompiled/core_module/scripts/yishi/manager/TempleteManager.as` lines 1229-1230 (HugeHead/StackHead
  → Outyard*Cate), 1237 HeroRoad, 1240 GloryRoadBuffer, 1267 EvilLand (DemonLand*Cate), 1297 AirGardenNode, 1305-1307
  RevengeRoad, 1310 StarAreaRoad, 1323-1325 Expedition (SpiritExpedition*Cate), 1328-1330 ShadowLand, 1340-1345 Remains,
  1367-1370 Secret, 1412-1414 Minos, 1425-1426 StoreHouse (ThessBox*Cate). `ExploreEventTemplates` is not loaded.
- **Managers and screens:** managers are listed in [docs/client/managers.md](../../docs/client/managers.md); screens and
  titles in [docs/ui/screens.md](../../docs/ui/screens.md).

## 4. Quests, rewards and activities

This section covers the quest systems (main, daily, event, Cycle, bounty, guild, slate, navigation), achievements and the daily activity-point system: their template sets, client-side logic and opcodes.

### 4.1 Quests: "Missão" panel (`QuestTemps`, `QuestCondictionInfos`, `QuestGoods`)

**What it is:** the quest system behind the "Missão" panel (`m15/task/TaskFrameII`, 930×590, see [docs/ui/screens.md](../../docs/ui/screens.md)) and the tracking bar (`core/ui/tasktracebar`).

- **Managers:** `TaskManage` (`core_module/scripts/yishi/manager/TaskManage.as`) + `TaskCategory` + `TaskTemplate` (`mvc/module/task`).
- **Network:** sent via `managers/TaskSocketManager` (see [docs/client/managers.md](../../docs/client/managers.md)).

**Template sets:**

- `QuestTemps` (835 quests) relates 1:N to `QuestCondictionInfos` (851 rows; up to 4 conditions → `QuestInfo.condition_1..4`; 828 quests have only 1).
- `QuestTemps` relates 1:N to `QuestGoods` (191 items; `ToJob` filters by class via `TaskGoodsTemplate.fitJob`).
- `TaskTemplate.initTask()` links them client-side by scanning the full lists by `TemplateId`.

**Count by `TemplateType` (enum `task_type`, `TaskType.as`):**

| TemplateType | Name | Rows | Repeatable | Active today (Start<now<End) |
|---|---|---|---|---|
| 0 | Main (`TASK_MAIN`) | 781 | 2 | 503 |
| 1 | Daily (`TASK_COMMON`) | 35 | 35 | 11 |
| 2 | Event (`TASK_ACT`) | 14 | 1 | 0 |
| 3 | VIP (`VIP_TASK`) | 3 | 2 | 0 |
| 4 | Return (`BACK_PLAYER`) | 2 | 0 | 1 |
| -2 | Cycle (`RING_TASK`) | - (`RewardTemps`) | | |
| -3 | Marriage (`MARRY_TASK`) | - (`RewardTemps`) | | |
| 100 | Reward (menu pseudo-type) | - (`RewardTemps`) | | |

Types 2 and 4 share one menu button (`TaskMenuII.getButtonByType`); type 3 appears only while VIP is active.

**Lifecycle (`TaskManage.as`):**

1. **Login:** `playerInfo.questSite` (bytes) → `_taskLog` BitArray; a completed quest is bit `(id-1)` (`IsTaskFinish`, :579).
2. **Sync:** the server sends `112 U_C_QUEST_UPDAT` (`QuestUpdatedRspMsg{quest[] QuestInfo, states_length, states}`). `QuestInfo` = `template_id`, `is_complete`, `condition_1..4`, `completed_date`, `repeat_finish`, `is_accept`, `is_select`, `add_date`.
3. **Accept:** `requestCanAcceptTask()` (:352) takes every `IsAuto=true` quest that passes `isAvailableTask` (:384) and sends `5012 U_C_QUEST_ADD` (`QuestAddedMsg{questId[]}`). `IsAuto=false` quests (12 quests, "Caminho do Desafio"/"Coletar Recursos") go to the manual list (`isManualAvaliable`, :612), and the player accepts them (`requestAcceptTask`).
4. **Availability filters** (`isAvailableTask`). A quest is blocked when:
   - now > `EndDate` (expired) or now < `StartDate` (not started);
   - level < `NeedMinLevel` or > `NeedMaxLevel`;
   - it is already in the list;
   - it is completed and `!IsRepeat`;
   - `repeatFinish >= RepeatMax` and it was completed **today** (same YY-MM-DD): blocked until the day turns;
   - `PreQuestId` is not met (comma-separated ids, all must be completed: AND);
   - `NeedBuildingTemp` fails; `IsLeague` requires a guild.
   - `WeekSpace/HourSpace` (`checkInWeek`/`checkInHour`) are stubs that return false; `checkNeedGoods` exists but is never called.
5. **Progress:** "state" conditions (level, building, bag items, friends, guild...) are checked client-side with listeners (`addListenerTo`, `TaskTemplate.as:218`); "counter" conditions use the server's `condition_N` (`checkCount`, :1248). The quest is complete when every condition returns the text "progress" (`isCompleted`).
6. **Turn in:** send `5014 U_C_QUEST_FINISH` (`QuestFinishedReqMsg{template_id, reward_item_id (chosen item if IsSelect), is_pass}`); `is_pass=true` for "Concluir agora" and for the tutorial (`NoviceTutorial_200` → quest 1834). The reply is accept 52 (`QuestFinishedRspMsg{template_id, isJump, finishedTemps[]}`; `isJump=1` means several quests completed at once). The client resets the conditions, removes the quest from its category, reruns `requestCanAcceptTask` and fires `TASK_COMMIT`. Per-id hooks: 757 Dragon transfer, 754 opens Dragon Soul, 921 Einherjar (pets), 1802 Cosmic Master (star slot 8), 755/756/1800/1801 job transfer animation.
7. **Repetition:** dailies (type 1) have `IsRepeat=true`, `RepeatMax=1`, `RepeatInterval=24`, so they run once per calendar day. Manual quests also reopen when `floor(hour/RepeatInterval)` changes.

**Rules and numbers:**

- **`NeedMinLevel`:** 1..80 (184 quests at lv1; 362 at lv80).
- **`NeedMaxLevel`:** 100 (default), 320 (runes 1969-1972), 5-level bands in "Cristal das Trevas I..X (Guilda)" (846-855).
- **`PreQuestId`:** 652 quests with 1 prerequisite, 47 with 2 (e.g. "190,200"), 136 with none. Example: 10 "Trilhas de Llane" (lv1, 3000 EXP) → 20 "Investigação Profunda" (pre 10).
- **Daily EXP:** `RewardPlayGP + (level - NeedMinLevel)*500` (`TaskRewardViewII.as:225`).
- **Reward display order:** `RewardPlayGP` (EXP), `RewardGold`, `RewardStrategy`, `RewardCrystal`, `RewardConsortiaOffer`, `RewardPlayerOffer` (+`RewardHappy`).
- **Dead fields (all constant):** `Objective`, `NeedBuildingTemp`, `NeedPos`, `RewardHeroGP`, `RewardDower`, `IsLost`, `WeekSpace`, `HourSpace`, `ShowType`.

**"Ir" navigation:** `SwitchPageHelp.skipPageByTaskCondictionType` (`SwitchPageHelp.as:90`).

- If `Para4 != "0"`, the player auto-walks (`walkToCrossMapTarget`, :960). Format `mapId,nodeId|mapId,nodeId`; e.g. `10000,25` = Space/city map, `20001,2000149` = Einherjar Island floor 1.
- Otherwise it opens the screen for the `CondictionType` (switch at :124).
- `NeedFightId=6001` opens the gathering scene (`worldBossTemplateDict`) via `sendEnterBattle`.

**Opcodes:** `5012 U_C_QUEST_ADD` (send); `5014 U_C_QUEST_FINISH` (send) / 52 (accept); `112 U_C_QUEST_UPDAT` (accept); `8524 C_CHECK_SEND` (condition 48, phone). Protos: `QuestAddedMsg`, `QuestFinishedReqMsg`, `QuestFinishedRspMsg`, `QuestUpdatedRspMsg`, `QuestInfo`, `QuestRemovedMsg`.

**Graphics:**

- SWFs: `ui/zh_cn/swf/task.swf`, `taskextra.swf` (`asset.taskextra.TaskCompleteEffect`), `tasktracebar.swf`.
- Symbols: `asset.task.*` (`TitleBack`, `TaskgoArrestBtn`, `TaskPhoneBg`, `completeNowTxt2`), `asset.taskTrace.*`.
- Tip pop-ups: `m16/tasktracetip/view/*TipView` (54 views, e.g. `DragonSoulTipView`, `TaskTipView`) with icons `asset.taskTraceTips.*`.

### 4.2 Quest conditions (`task_condition_type`)

The full enum is in the JSON: 169 codes, made of 71 constants from `TaskConditionType.as` plus codes used only in the `switch` of `TaskTemplate.getProgress` (`TaskTemplate.as:443`) or in data.

**Parameter semantics:**

- **`Para1`:** sub-target (building `SonType`, soldier `MasterType`, `CampaignId`, `ItemTemplateId`, node/boss ID, rune type, `newbieProcess`).
- **`Para2`:** target value (quantity/level/floor), compared with player state or with `condition_N`.
- **`Para3`:** `CampaignId` for the "Ir" button (`gotoCampaignById(Para3)` in types 13, 24-28), or an extra target (254 Terra Sombria: number of stages; 265: part of the set).
- **`Para4`:** auto-walk destination `mapId,nodeId`; "0" = none (807 of 851 rows).
- Types 270-273 use `checkCount2` (goal = **`Para1`**).

**Client-side state checks:** 1 lord level; 2 level of building `SonType=Para1`; 10 highest soldier level `MasterType=Para1`; 21 friend count; 22 has guild; 23 `newbieProcess >= Para1`; 27/28/32/49/94 bag items (`Para1`, `Para2`); 29 total contribution; 33 desktop client (only with `CLIENT_DOWNLAND`); 34 formation adjusted; 37 is on map `Para2`; 38 labyrinth floor; 39 login on another day; 48 phone (only with `MOBILE_TASK`); 51 guild/shop/altar/school/warehouse level (`Para1` 1..5); 76/78 runes; 85 NPC dialog (`finishStory` flag); 95 Dragon Soul type 102; 203/205 mount; 211-213, 236-238, 255-260 class progression (Evolution 80, Gift 179/50, Avenger, Consecrated); 215 Titan; 217 married (state 3); 239/246 Caminho da Vingança; 261 Royalty; 264 Theseus equipment (`Para2` = item); 267 Secret Domain; 268 War Tower; 269 Caminho Final. All other codes are server counters.

**Codes present in data** (`CondictionType` → rows):

1 player_grade (33); 2 building_or_tech_grade (45); 3 recruit_pawns (6); 7 occupy_outer_city_node (2); 8 plunder_city (3); 10 pawn_grade (5); 12 speed_up_building_cd (3); 14 pass_campaign (88); 16 join_pvp_arena (2); 17 strengthen_equipment (2); 18 inlay_gem (1); 19 compose_gem (1); 20 farm_energize (4); 21 friend_count (2); 22 join_guild (2); 23 newbie_process (9); 25 kill_campaign_monster (38); 26 kill_campaign_boss (33); 27 collect_item_event (21); 28 collect_campaign_drop (13); 29 guild_contribution_total (4); 30 guild_pray (1); 31 pass_any_campaign (4); 32 collect_resource_item (13); 33 client_download (2); 34 adjust_formation (2); 35 colosseum_challenge (3); 36 astrology_cosmos (3); 37 reach_world_map (5); 38 maze_floor (3); 39 double_login (1); 40 world_boss_battle (2); 41 world_boss_damage (1); 42 collect_tax (1); 44 join_battlefield (3); 45 battlefield_kills (3); 46 decompose_equipment (1); 47 purify_equipment (1); 48 phone_check (1); 49 hold_item (16); 50 battlefield_win (4); 51 guild_building_grade (2); 52 star_bag_action (1); 53 lock_star (1); 56 auction (1); 57 blessing_roulette (1); 58 soul_seal (1); 59 farm_plant (3); 60 farm_harvest (4); 61 farm_kill_worms (2); 63 activity_points (1); 64 alchemy (1); 65 summon (1); 66 world_boss_revive (1); 71 train_mount (1); 74 enter_trial_tower (1); 76 learn_rune (2); 77 absorb_rune (3); 78 rune_grade (6); 79 join_timed_event (3); 80 win_timed_event (3); 85 talk_to_npc (29); 86 amethyst_battle (1); 87 join_einherjar_arena (2); 88 obtain_einherjar (1); 89 dig_treasure (1); 90 insert_guard_crystal (1); 91 treasure_hunt (1); 92 challenge_shadow (6); 93 sky_road_win (1); 95 dragon_soul_grade (5); 96 refine_mount (1); 97 monopoly_complete (1); 98 monopoly_move (1); 99 monopoly_event (1); 201 vip_activity_points (1); 202 misc_event_action (4); 203 mount_soul_grade (4); 207 perkinlab_build (1); 208 perkinlab_rob (1); 209 add_tattoo (1); 210 replace_tattoo_attribute (1); 211 vocation_grade (1); 212 talent_grade (1); 213 complete_change_job (1); 214 child_patrol (1); 215 titan_level (2); 216 navigation_trade (1); 217 marry (1); 218 titan_inject (1); 219 outyard_titan (1); 220 glory_road (1); 221 star_sublime (1); 222 outyard_shuttle (1); 223 magic_pub (1); 224 dragontalker_challenge (1); 225 child_explore (1); 226 star_gazing (1); 227 planes_explore (1); 228 ecliptic_palace (1); 229 goddess_task (1); 230 demonland_task (1); 231 monster_explore_boss (1); 232 monster_call (1); 233 monster_cook (1); 234 monster_train (1); 235 monster_evolve (1); 236 avenger_grade (1); 237 avenger_talent (1); 238 avenger_transfer (1); 239 revenge_road (1); 240 consortia_want (1); 241 redemption_road (1); 242 inject_spirit (1); 243 strengthen_goddess (1); 244 advance_goddess (1); 245 potential_training (1); 246 revenge_soul (1); 247 advance_revenge_skill (1); 248 avenger_childns_grade (1); 249 avenger_childns_stage (1); 250 avenger_passive_skill (1); 251 avenger_active_skill (1); 252 child_camp (1); 253 spirit_expedition (1); 254 shadow_land (3); 255 holy_grade (1); 256 holy_body_skill (1); 257 holy_soul (1); 258 holy_devil_armor_grade (1); 259 holy_devil_armor_hole (1); 260 holy_transfer (1); 261 theseus_level (40); 262 theseus_boss_fight (41); 263 theseus_boss_kill_guild (41); 264 theseus_equip_one (36); 265 theseus_equip_suit (106); 266 theseus_war_intent (10); 267 secret_adventure (4); 268 warsoul_tower_level (22); 269 final_road_chapter (3); 270 rune_stone_slot (1); 271 rune_stone_draw (1); 272 rune_stone_insert (1); 273 secret_war_battle (1).

**Codes with no data rows (code only):** 4, 5, 6, 9, 11, 13, 15, 24, 43, 54, 55, 62, 67, 68, 69, 70, 72, 75, 81, 82, 94, 204, 205, 206.

### 4.3 Bounty board: Caçador de Recompensas (`RewardTemps` Type 0, `RewardCondictionInfos`)

**What it is:** the "Recompensa" board (`m15/offerreward/OfferRewardFrame`, 614×461) with server-rolled quests. Code: `managers/OfferRewardManager.as`, `mvc/module/buildings/OfferRewardModel.as`, `mvc/module/offerreward/BaseOfferReward.as`, `m15/offerreward/view/OfferTaskItem.as`.

**Rules:**

- **Unlock and limits:** opens at level 14 (`OPEN_REWARD_GRADE`, `OfferRewardModel.as:17`); daily limit `20 + reward_count` (`4360 U_C_REWARD_COUNT`, `OfferRewardManager.as:88`); up to 4 accepted at once (`MAX_OFFER_TASK_NUM`).
- **Refresh:** automatic every 1800 s (`AUTO_REFRESH_INTERVAL`); paid manual refresh (`RewardFreshReqMsg{isButton, pay_type}`; `free_times` comes in the reply).
- **Row state:** 1 can accept, 2 accepted, 3 completed. Quality 1..5 (5 = orange; `hasOrangeTaskNotComplete` shows a warning).
- **Reward:** `m = q (q=5 → 6)`, `EXP = RewardPlayGP·m·(level + evolutionLevel)`, `gold = RewardGold·m·(level + evolutionLevel)` (`evolutionLevel` = 80 after a job transfer), plus the Fonte Mágica buff bonus (`OfferTaskItem.as:314`).
- **Contrato do Rei:** while `KingContract` id 2 is active, `getProgress` reports every quest as complete and "Concluir agora" sends `C_REWARD_FINISH{isPass=true}`.
- **Data:** 252 Type 0 rows in 10-level bands (31-41, 41-51, 51-61, 61-71...), `RewardPlayGP` 1000, `RewardGold` 40, `Rands` 5/10 (roll weight *(assumption)*). Example: 1 "Caçador de Recompensas" → condition 14 "Apreender Espadachim Soenke" (`Para1` = 20000).

**Conditions (`reward_condition_type`, `RewardConditionType.as`, 23 codes):**

- 1 tribute troops (`Para1` = `SonType` 103/106/107, `Para2` = 200);
- 2 strengthen; 3 inlay; 4 collect item (`Para1` item, `Para2` qty, `Para4` path);
- 5 energize Yggdrasil; 6 Cosmos; 7 kill monsters; 8 wild treasure (2201); 9 guild contribution; 10 synthesis; 11 spend diamonds;
- 12 QTE (`QTETraining(Para2 keys, Para1·1000 ms)`, e.g. 8 s/7 keys);
- 13/14 arrest (sends `C_REWARD_ARREST{condiction_type, param1}` and enters battle);
- 15 Mata-Rato (`HamsterGameFrame(Para1 s, Para2 pts)`, e.g. 30 s/500);
- 16 deliver a message to an NPC (`Para4` = `mapId,nodeId`);
- 17 Einherjar Island monsters (`Para1` = mapId 20001..20004);
- 18 kill N monsters in a rolled campaign (`condition_2` = `CampaignId`);
- 19 tribute a rolled item (`condition_3` = item, `condition_2` = shop 2 guild/3 PvP/4 labyrinth);
- 20 sacrifice Einherjar; 21 Cycle weekly reward; 22/23 marriage.

Progress: `BaseOfferReward.as:198`; navigation: `SwitchPageHelp.as:510`.

**Opcodes:**

- Client: `8288 C_REWARD_ADD` (accept), `8289 C_REWARD_REMOVE` (abandon), `8290 C_REWARD_FRESH`, `8291 C_REWARD_FINISH`, `8298 C_REWARD_ARREST`, `9583 C_REWARD_ONEKEY` (complete all, `PayTypeMsg`).
- Server: `4197 U_C_REWARD_FRESH` (`RewardFreshRspMsg{templateId[], reward_lastdate, isIsValid[], qualitys[], reward_times, free_times}`), `4198 U_C_REWARD_UPDATE` (`RewardUpdatedRspMsg{reward[] RewardInfo}`), `4360 U_C_REWARD_COUNT`.

**Graphics:** `ui/zh_cn/swf/offerreward.swf`.

### 4.4 Missão de Ciclo (`RewardTemps` Type 1/2/3, `RewardGoods`)

The Cycle quest chain: `managers/RingTaskManager.as`, `mvc/module/ringtask/RingTask` (`TemplateType` -2).

- **Unlock:** from level 35; a chain of up to 200 quests (`model.rewardNum`).
- **Resident quest:** the "resident" Type 3 quest (2438-2441, "Missão de Ciclo Não Coletada") is picked by band `NeedMinLevel <= level < NeedMaxLevel` (`RingTaskManager.as:78`).
- **Fixed gold/strategy per band** (`RingTaskManager.as:214`): 35-44 → 400,000/2,000,000; 45-54 → 480,000/2,400,000; 55-64 → 600,000/3,000,000; 65-99 → 800,000/4,000,000.
- **Milestone rewards:** every 10 quests (`rewardNum % 10 == 0`), the `RewardGoods` items with `TemplateId=1000` whose `RepeatStep` contains the current count (10,20..200) and where `RepeatMinLevel <= level < RepeatMaxLevel` (80 rows = 20 steps × 4 bands).
- **Instant completion:** requires ≥10 diamonds or a completion item (`TaskFrameII`, *(assumption)*).
- **Description:** `{0}/{1}` is filled from the campaign (cond. 18) or the item/shop (cond. 19) (`TaskDescribeViewII.as:74`).
- **Opcodes:** `8732 C_TAKE_REPEAT_REWARD`, `8729 C_REPEAT_REWARD_FINISH`, `8730 C_REPEAT_REWARD_FINISH_IMMEDIATELY` (`PropertyMsg.param1` 0/1 = payment method), `8731 C_REPEAT_REWARD_UPDATE_FINISH`; `4614 U_C_REPEAT_REWARD_UPDATE`, `4615 _END`, `4616 _FNISHED_SUM_UPDATE` (`PropertyMsg.param1` = number completed), `4617 _FINISH`.

### 4.5 Marriage and Crepúsculo dos Deuses quests (`RewardTemps` Type 4/5/6)

- **Marriage** (Type 4, ids 4001-4005, `TemplateType` -3 `MarryTask`, `MarryManager.as:390`): "Bênção da Deusa do Amor" etc.; `RewardGold` 4000, `RewardStrategy` 20000, `RewardHappy` 10/20/30 (happiness). Conditions 16/22/23. Opcode `8774 C_MARRIAGE_TASK_REQUEST`.
- **Crepúsculo dos Deuses** (Type 5 = team/faction, ids 5001-5103, 12 rows; Type 6 = personal, 6001-6003): listed in `m3/.../godsevening/GodsEveningTaskView.as` (teams 1/2/3 → ids 5001/5011/5021...). Here `RewardGold` is the **goal** (`taskProgressDic >= RewardGold`, `GodsEveningTaskItem.as:109`) and `Detail` is the condition text (e.g. "Eliminar o líder de Muspel 1 vez", "Coletar recursos 5 vezes").

### 4.6 Guild quests (`ConsortiaQuestTempInfos`, `ConsortiaQuestConditionTempInfos`)

**Screens:** "Escola de missões" (`m6/consortia/view/myConsortia/ConsortiaTaskSchoolFrame`, tabs = `QuestType` 2 and 3) and the activity rewards (`newui/ConsortiaActiveRewardView`, `QuestType` 1, filtered by `ResetType`). Lookup: `ConsortiaModel.taskTempDic[QuestType]` (`ConsortiaModel.as:404`).

**State** (`getRewardState`, :969): bit `TemplateId` set in `quest_site` = already claimed (0); `process >= Target` = ready (2); otherwise 1.

**Data** (26 quests, 1 condition each, `ConditionId` = `TemplateId`):

- **`QuestType` 2, individual, daily:** activity 120/180/240 (+10/15/20 reputation), diamonds 30/50/100, guild campaign (50), treasures 1/2/3, purchase in the Câmara de Comércio/Loja de Prata (20).
- **`QuestType` 3, collective, monthly:** 10 members at level 80; 5 members with the 1st transfer → 100 activity points + "208104,5".
- **`QuestType` 1, activity:** 5..30 members with activity 120..270 → 100 activity + 1000..4000 funds (daily); weekly activity 500..3000 → 10000 funds + "208104,10".

**Rewards** are shown by `ConsortiaViewHelper` (`ConsortiaActivePoint`, `ConsortiaAsset`, `PersonReputation`).

**Opcodes:** `179 U_C_CONSORTIA_QUEST_INFO` (`ConsortiaQuestMsg{quest_site, conditionList[]}`), `5437 C_CONSORTIA_QUEST_GET_REWARD` (`CommonMsg.param1` = `TemplateId`).

### 4.7 Slate quests: Godhead/Theseus (`SlateTaskTmpls`)

- **Progress:** `TheseusSlateTaskInfo.state` (`TheseusSlateTaskInfo.as:29`) counts equipped slates with `level >= Part1` and `SlateType >= Part3` (`TheseusGodheadModel.as:576`); the quest needs `>= Part2`.
- **States:** 0 incomplete / 1 ready / 2 claimed (`compeltedTasks[TemplateId]`).
- **Data:** 16 quests: 2/3/4-slot slates, levels 5..45, 1 or 2 slates; the reward is always `30000001,1`.
- **Network:** data via `1024 U_C_SLATE_USER_DATA` (`UserSlateMsg.tasks[] SlateTaskMsg{templateId,count,state}`); requests via PackageOut 9762 (`PlayerOpMsg.op` 1 data, 2 unlock position; the code is unnamed in opcodes.csv).

### 4.8 Navigation port tasks (`NavigationTaskTempInfos`)

`m11/navigation/NavigationTaskItem.as`: each port (`NavigationPortMsg` taskId1..6, taskNum1..6, selectedTask1..6) shows "Usar {item} x{qtd·lotes} para trocar {ObtainedCurrency·lotes} moedas de navegação"; lots = combo (1..N).

- **Data:** 155 tasks = 31 groups (`Types`) × 5 qualities; quality q gives 20·q coins in most cases (e.g. `Types` 1: 2,000,000 gold → 20 coins ... 10,000,000 → 100).
- **Currencies:** negative `ConsumedItems` are currencies (`NavigationHelper.getNumByTempId`): -100 gold, -200 mineral, -300 strategy, -600 water crystal, -1400 guild skill points, -3000 mount coin, -4000 Game Box coin; 208001 arena medal, 208009 labyrinth gold.
- **`RefreshPort`:** 1..3 = port where the task can appear (server-side, *(assumption)*).
- **Opcodes:** `9600 C_NAVIGATION` (`NavigationOpMsg`), `341 U_C_NAVIGATION_MSG`, `342 U_C_NAVIGATION_DATA_MSG`.

### 4.9 Achievements: Histórico de Conquistas / Hero's Road (`AchievementTaskTemplates`)

`yishi/manager/HeroRoadManager.as`, `m11/heroroad/*` (`HeroRoadFrame` 950×615, "Histórico de Conquistas").

- **Data:** 436 achievements in 110 chains (`PreAchievementId` = previous, 0 = start; ids in 1000xx blocks). `Classify` tabs: 1 character (359), 2 instances (55), 3 competitive (22).
- **Conditions:** `ConditionType` 101..148 is a server enum (44 values). Examples: 101 labyrinth floor [`Parm1` = labyrinth 1..3], 106 strengthening by equipment slot [`Parm1` 101..108], 107 mount level [`Parm1` = id 9001..], 108 quality rewards [`Parm1` 5 = orange], 111 Cycle quests, 114 Chefão Global damage, 135-138 Goddess, 147 armor, 148 Treasure Core. Progress = `AchievementTaskMsg.data`, shown as "(data/ConditionParm2)".
- **Sort order:** completed unclaimed (1) → in progress (2) → claimed (3).
- **Pop-out offers:** `IsPopout=1` (214 rows) opens, on completion, a `PackageName` pack offer with `AchievementTaskBuyDrop` items and a countdown in the QueueBar.
- **Opcodes:** `4288 U_C_ACHIEVEMENT_TASK_DATA` (`AchievementTaskListMsg{opType, templateId, leftSecond, tasks[]}`), `4289 U_C_ACHIEVEMENT_TASK_UPDATE`, `8671 C_ACHIEVEMENT_TASK_CLIENT_OP` (`PlayerOpMsg.op`: 1 open, 2 claim, 3 purchase pop-up, 4 buy), `9634 C_HEROROAD_OP`.
- **Graphics:** `ui/zh_cn/swf/heroroad.swf`.

### 4.10 Activity points: Pontos de Atividade (`ActivityDailyTemplates`)

`managers/NewActiveLeedManager.as`, `m11/newactiveleed/*` (`NewActiveLeedFrame` 773×533, "Pontos de Atividade").

- **Structure:** 78 activities = `MasterType` tabs (1 Newbie 17, 2 1st transfer 25, 3 2nd transfer 24, 4 advanced 12) × `SonType` sub-tabs (1 daily, 2 solo, 3 multiplayer, 4 multi PvP, 5 guild, 6 Einherjar/Guardian).
- **Points:** each activity gives `Num` points (0..20) on reaching `PassCount` (e.g. 10104 "Missão Recompensada" 5×→5 pts; 20206 "Gastar 200 pts de pesquisa"→10 pts). `TaskTime` is display text only.
- **Sync:** the server sends `529 U_C_ACTIVITY_UPDATE` (`ActivityDailyUpdatedRspMsg{activityDailyData[] {masterType,sonType,taskType,current_count,is_complete}, activityDaily[] (daily/weekly totals), buffStopDate, vipNum}`); entries are matched by (`MasterType`, `SonType`, `TaskType`).
- **Chests:** `9707 C_ACTIVITY_DAILY_FINISH` (`masterType, index, isWeek`) with drops in `ActivityDailyDrop`. Double activity: `9708 C_ACTIVITY_BUY_BUFF`.
- **Graphics:** `ui/zh_cn/swf/newactiveleed.swf`.

### 4.11 Guide quests: "Objetivo dos 7 dias" (`guide_task_type`)

`GuideTaskType.as` (27 types: 1 army level ... 27 complete trials) defines the `Type` of `SimpleTask` (a template set not in this dump). It is used by `m11/guidetask/GuideTaskItem.as` and by `SwitchPageHelp.switchGuidePage` (`SwitchPageHelp.as:2039`) for navigation. Opcodes: `265 U_C_SIMPLE_TASK_MSG`, `266 U_C_SIMPLE_TASK_RECORD_MSG`, `9564 C_SIMPLE_TASK_REWARD`.

## 5. Shops, auction and guild

This section covers the shared shop template set and every shop type, the guild systems (levels, ranks, commerce, treasure, campaigns, bosses, wars, chess), the return-player Alliance event and the auction house.

### 5.1 Shops: general structure (`ShopTempInfos`)

One template set (`ShopTempInfos`, 1183 rows) feeds ~50 shops.

- **Loading:** `ShopGoodsInfoResolve.resolveImp` (`decompiled/core_module/scripts/yishi/resolve/ShopGoodsInfoResolve.as:165`) splits rows by `ShopType` into dictionaries passed to `TempleteManager.ShopGoodsInfoBack` (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2608`).
- **Keys:** types 2,3,4,5,6,7,8,10,11,35,100 are indexed by `ItemId` (an item can appear only once in these shops); all other types by `Id`.
- **Runtime updates:** the server can also send or change rows at runtime via `344 U_C_SHOP_TEMPLATE_MSG` (`ShopManager.__shopTempDataHandler`, `decompiled/core_module/scripts/managers/ShopManager.as:773`).

#### Price and currency

The fields `Price`, `FirstPrice` and `Discount` are always 0. `ShopGoodsInfo.setPrice()` (`decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:469`) derives `price`/`PayType`:

- **Types 8/15/1033/1035:** `Score` (8: currency = item `NeedItem`, essences 3101071/3101081/3101091; `PayType` 1001..1011 by the item's `Property1`).
- **Other types:** the first field >0 in this order: `Point` (diamond, `PayType` 1) → `GiftToken` (bound diamond, 2) → `Gold` (3) → `Honor` (5) → [type 17 → `Score`, 12] → `ConsortiaOffer` (4) → `MazeCoin` (6) → `LordsScore` (7) → [type 16 → 13] → `CrossGuildScore` (10) → `NeedItem==2125048` (Cupom de Retorno dos Heróis, 8) → type 14 `CrossLeagueMedal` (11) → other types → `Score` with its own `PayType` (enum `shop_pay_type`, 52 values).
- **"Virtual" currencies** use negative item IDs: -100 Ouro, -300 Espírito, -400 Diamante, -500 Diamante vinculado, -600 Cristal de Luz, -1400 Dente do Terror, -1600 Cristais de Vênus, -3600 Ouro de Yalamen, -4100 Cristais amarelos, -5000 Cristal da diversão, -5500 Mérito, -16000 Pó Mítico, -17000 Alma do labirinto, -18000 Pontos de Chefão (names from `ItemTempInfos`).

#### Limits

- **Daily limit:** the client uses only `VIP0Count` (`OneDayCount`, `ShopGoodsInfo.as:813`); -1 = unlimited; remaining = `VIP0Count - OneCurrentCount` (the counter comes from the server in opcodes 528 and 4145).
- **`VIP1..6Count`:** present in XML/proto but ignored; they differ from -1 only in 3 rows of shop 1034 (equal to VIP0).
- **`SellMaxCount`:** total limit (shops 1012/1013).
- **Always 0:** `NeedMinVip`, `NeedMaxGrade`, `MazeLayers2`, `Rands`, `PokerScore`.

#### Requirements

Shown in `decompiled/m15/scripts/view/GoodsItem.as:571-634`:

- `NeedConsortiaLevels` (guild shop; visible up to shopLevel+1);
- `NeedGrades` (farm level; items up to +5 levels above appear locked);
- `NeedGeste` (honor/title);
- `MazeLayers` (labyrinth floor; in shop 1024 = Guild Boss difficulty);
- `NeedMinGrade` (81/161/241 = job transfer stage).

Other display fields: `ValidDate` in minutes (10080 = 7 days, 43200 = 30 days); `Labels` 1 New / 2 Recommended / 3 Popular (`GoodsItem3.as:210`); `IsHot` = highlight.

#### Main shop (ShopType 1)

`ShopModel.init` (`decompiled/core_module/scripts/mvc/module/shop/ShopModel.as:240`) splits rows by `Area`: 2 Items (63), 4 Other (16), 12 Guardian (26), 16 Hero (34), 18 Einherjar (21), 52 hidden/not searchable (180, used by quick buy), 6 materials (9), 8 Return Coupon exchange (9), 10 diamond items (9; excluded from search, `ShopControler.as:273`). 346 of 367 rows charge `GiftToken` (bound diamond).

- **Buy:** `ShopManager.sendShoping(goodId,count,receiveId,isDiscount)` → `5154 U_C_SHOP_BUY` (`ShopMsg{buyInfo{goodId,count,receiveId,isDiscount,type},payType,itemTemplateId}`), reply 90.
- **Clothes:** `8592 C_FASHION_SHOP_BUY`; cart: `C_SHOPCAR_BUY`.
- **Promotions/limited time:** `4238 U_C_SHOP_MAIN`, `4375 U_C_SHOP_DISCOUNT`, `4599 U_C_BUY_DISCOUNT`, `4890 U_C_SHOP_DISCOUNT_INFO`.

#### Shop types (enum `shop_type`)

Row counts are the actual XML counts; pt-BR names come from `index/language.json`.

| ShopType | Name | pt-BR | Rows |
|---|---|---|---|
| 1 | main_shop | Loja (Mercado principal) | 367 |
| 2 | consortia_shop | Loja da Guilda | 27 |
| 3 | athletics_shop | Loja da Arena | 36 |
| 4 | maze_shop | Loja do Labirinto | 15 |
| 5 | mystery_shop | Loja Misteriosa | 0 |
| 6 | farm_shop | Loja da Fazenda | 23 |
| 7 | mystery_exchange_shop | Troca da Loja Misteriosa | 0 |
| 8 | pet_exchange_shop | Troca Einherjar | 15 |
| 10 | areslords_shop | Loja de Ares | 27 |
| 11 | mineral_shop | Loja de Ametista | 5 |
| 13 | cross_pvp_shop | Loja do Império | 23 |
| 14 | league_shop | Loja da Liga (pontuação) | 14 |
| 15 | pet_boss_shop | Troca Einherjar (Cristais de Einherjar) | 4 |
| 16 | brave_leg_shop | Loja de Athena / Titã | 30 |
| 17 | adv_consortia_shop | Loja da Guilda (avançada) | 14 |
| 19 | svs_shop | Loja de Caos | 10 |
| 20 | matelords_shop | Loja de Vênus | 5 |
| 35 | gods_evening_shop | Casa do Tesouro dos Três Reinos | 4 |
| 36 | seven_year_shop | Loja do 7º Aniversário | 8 |
| 37 | year_active_shop_1 | Loja do Evento Anual (ouro) | 4 |
| 38 | year_active_shop_2 | Loja do Evento Anual (chave) | 2 |
| 99 | hide_shop | Loja oculta (main) | 0 |
| 100 | blood_shop | Loja de Sangue | 0 |
| 101 | star_shop | Resgatar Pontos (Loja das Estrelas) | 0 |
| 200 | shop_cart | Carrinho | 0 |
| 888 | pet_exchange_shoptype | Troca Einherjar (UI type) | 0 |
| 1002 | mounts_shop | Loja de montaria | 0 |
| 1003 | poker_shop | Loja de Texas Poker | 0 |
| 1004 | outyard_shop | Loja da Terrálem | 5 |
| 1005 | bingo_shop | Loja da Maçã | 0 |
| 1008 | glory_shop | Loja da Glória | 33 |
| 1009 | treasure_consortia_shop | Loja do Tesouro da Guilda | 6 |
| 1010 | explore_shop | Loja do Eremitério | 7 |
| 1011 | assaultwar_shop | Loja Militar | 6 |
| 1012 | pumping_joy_shop | Loja do Gashapon | 25 |
| 1013 | upgrade_present_shop | Apoio de Elevação | 6 |
| 1014 | copy_consortia_shop | Loja de Prata de Moréia | 12 |
| 1015 | apex_shop | Loja da Liga do Pico | 27 |
| 1016 | new_cross_guild_shop | Loja da defesa de guilda | 27 |
| 1017 | antaeus_shop | Loja de Anteus | 22 |
| 1018 | air_garden_prop_shop | Loja do jardim | 8 |
| 1019 | wish_pool_shop | Loja do Poço dos Desejos | 0 |
| 1020 | flame_temple_shop | Loja do Templo das Chamas | 34 |
| 1021 | dusk_area_shop | Loja do Crepúsculo | 36 |
| 1022 | demon_road_shop | Loja da Rua Mítica | 19 |
| 1023 | dark_maze_shop | Loja do Labirinto Negro | 17 |
| 1024 | consortia_new_boss_shop | Loja do Chefão da Guilda | 12 |
| 1027 | theseus_pvp_shop | Loja da Arena (Teseu) | 81 |
| 1029 | consortia_minos_shop | Loja do Minos (guilda) | 35 |
| 1030 | chess_pvp_shop | Loja do Duelo Tático | 12 |
| 1031 | child_ns_war_shop | Loja da Arena do Espírito de Proteção | 84 |
| 1033 | vip_shop | Loja Nobre (VIP) | 27 |
| 1034 | dungeon_explore_shop | Loja de exploração de masmorra | 4 |
| 1035 | theseus_box_shop | Loja do Desafio de Teseus | 5 |
| 9001 | navigation_shop | Loja de Navegação | 0 |
| 99999 | consortia_new_buff_shop | Loja de BUFF do Chefão da Guilda | 0 |

**Windows:** `decompiled/m15/scripts/view/subshop/*ShopFrame.as` (one per shop), initialized by `ShopControler.init*ShopFrame` (`decompiled/core_module/scripts/mvc/controler/ShopControler.as:322-1741`). The screen list is in [docs/ui/screens.md](../../docs/ui/screens.md) (m15).

### 5.2 Guild shops (ShopType 2/17/1009/1014/1024/1029/1030)

- **Currencies:** type 2 charges personal contribution (`ConsortiaOffer` 2..1000); 17 guild currency (`Score`, `PayType` 12); 1009 Cristais amarelos; 1014 Prata de Moréia; 1024 Pontos de Chefão (-18000); 1029 Minos; 1030 Tactical Points (Pontos Táticos).
- **Visibility:** `NeedConsortiaLevels <= shopLevel + 1`, sorted by `NeedConsortiaLevels` desc + `Sort` (`ShopControler.as:406-481`). Title "Loja da Guilda Nv. {0}".
- **Shop 1024:** `MazeLayers` = Guild Boss difficulty already beaten (`ConsortiaNewBossManager.model.passLevel`); `NeedMinGrade` 81/161/241 = 1st/2nd/3rd transfer (`GoodsItem.as:618-634`).

### 5.3 Guild levels, buildings and skills (`ConsortiaLevelInfos`)

- **Structure:** 247 rows; key `TemplateId` and `Types_Levels` (`ConsortiaTempInfoResolve.as:16`). 26 `Types` (enum `consortia_upgrade_type`); `BuildingType` 1 hall, 2 building, 3 skill, 4 new building, 5 master.
- **Hall (`Types` 1):** Lv1→10; cost `NeedOffer` (Fortuna): 0, 400, 6000, 12000, 20000, 30000, 42000, 56000, 72000, 90000; time `CodeTime` 0..172800 s (48h). Members = `levels*20+10` (30..210; `decompiled/m6/scripts/consortia/view/club/ConsortiaItem.as:174`, config `Consortia_Member=20`). Weekly upkeep = `levels*500` = `Property2` (`ConsortiaInfoView.as:231`).
- **Buildings (`Types` 2-5):** Guild Shop (Lv10 = 300000), Altar (`Property1` = 20 contribution per prayer; `Property2` = prayers/day 3..30), Skill Institute (unlocks skills; `NextTemplateId` lists the unlocks), Warehouse (5..56 items). `PreTemplateId` = prerequisite (e.g. Shop Lv2 requires Guild Lv2 = 102), checked in `ConsortiaDevelopView.checkPrevReached` (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaDevelopView.as:250`).
- **Common skills (6,8,9,10,11,12):** learned with personal contribution (`NeedOffer` 200..10000; gold 20..1000): `ConsortiaControler.isCommonSkill` (`decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:1042`). Effects: Strength/Protection/Intelligence/Physique +40/level, Leadership +20/level, Gold +1%/level. `Property1` 3001..3006 = effect id.
- **Advanced skills (13-21):** researched with Fortuna (`NeedOffer` 2000..100000) and learned with Mérito (`Property2` = 200·2^(n-1)); they include Eremitério EXP +2%/level, Guild Defense medals/honor +46/level, boss attributes +1%/level.
- **Master (22-25):** +100 attribute/level, cost 1000..25000. **Master Skill Tower (26)**, **Escola de missões (27)** and **Câmara de Comércio (28)** are paid with Fortuna (`consortiaAsset`, `isNewBuild = tempType == 26`).
- **Build speed-up:** `Consortia_Fast = 1,10` → 1 diamond per 10 min remaining (`ConsortiaDevelopView.as:231`).
- **Guild costs (`ConfigInfos`):** create a guild: Lv13 + 200000 gold; rename 1000; clear the join CD 50 diamonds.
- **Icons:** `<resource>/icon` + `Icon` (e.g. `/consortia_heroAT.png`) via `IconFactory.getTecIconByIcon`.
- **Opcodes:** `U_C_CONSORTIA_LEVEL` (5133/43), `U_C_CONSORTIA_LEARN` (5147/48), `U_C_CONSORTIA_INFO` (8212/4138).

### 5.4 Guild ranks, permissions and contribution

- **Ranks** (`ConsortiaDutyLevel`, `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaDutyLevel.as:8`): 1 President, 2 Vice, 3 Officer, 4 Elite, 5 Member (pt-BR shows "Membro" for both 4 and 5).
- **Permissions** are bits (`ConsortiaDutyInfo.as:8-82`): 1 transfer, 2 research skill, 3 upgrade building, 4 board, 5 kick, 6 log, 7 edit ranks, 8 invite, 9 approve, 10 treasury, ..., 17 raise level, 18 rename, 19 change rank, 20-22 battle, 32 disband, 41 summon boss, 43 restock Câmara de Comércio, 44 master skill, 45 tree, 46 external battle sign-up, 47 boss.
  - Defaults: Vice `[2,5,6,8..16,19,21,22,23,28,31]`, Officer `[5,6,8..16,21..23,28,31]`, Elite `[6,10..16,21..23]`.
  - Edit: `5137 U_C_CONSORTIA_DUTYUPDATE`, `9723 C_CONSORTIA_DUTY_RIGHTS_UPDATE`.
- **Donation** (`ConsortiaContributeFrame`, `decompiled/m6/scripts/consortia/view/myConsortia/contribution/ConsortiaContributeFrame.as:353`):
  - 1000 gold = 1 personal contribution + 1 Fortuna (min 1000);
  - `Point_ToOffer` (=1) diamond = 1 + 1 (bound diamonds are used first);
  - 1000 Espírito = 1 "war" point (raises the Terra dos Sonhos boss).
  - Send `5144 U_C_CONSORTIA_OFF` (`ConsortiaUserOfferReqMsg{offerGold,offerPoint}`); ranking `U_C_CONSORTIA_OFFER_LIST`.

### 5.5 Câmara de Comércio (`ConsortiaShopTempInfos`, `CommerceShopTemplates`)

- **Supply round** (`ConsortiaShopTempInfos`, 6 items: Fogo das Estrelas, Pedra Requintada, Talismã de Experiência...): holders of permission 43 restock, paying `CostConsortiaAsset` (20/50 Fortuna) per unit up to `MaxSupplyCount`=2000; members buy, paying `CostPersonReputation` (individual Mérito) up to `PersonBuyLimit`=25 (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaBusinessBuyFrame.as:157-165`). Resets Sunday 0h. Extra columns unlock with guild Production.
- **Salão de Trocas** (`CommerceShopTemplates`, 9 items rolled by `Weight`): cost `CostPersonReputation` 300/700 + `Point` diamonds (0). Paid refresh in diamonds.
- **Opcodes:** `5438 C_CONSORTIA_SHOP_BUY` (`CommonMsg param1=id, param2=qty, param3=1 restock | 2 buy | 3/4 info/refresh`; `ConsortiaSocketOutManager.as:372`); replies `181 U_C_CONSORTIA_SHOP_LIST`, `182 U_C_CONSORTIA_SHOP_SELF_BUY`.

### 5.6 Guild Treasure (`ConsortiaTreasureTempInfos`)

- **Chests:** 17 chests: Type 1 Gold (-100), 2 Espíritos (-300), 3 Cristais de Luz (-600), 4 Gems; Quality 1..5 with `RewardSeconds` 1h/2h/4h/8h/24h. The main drop scales ×2, ×4, ×10, ×30 over quality 1 (gold 200000 → 6000000). `HelperDrop` ≈ 80% of `Drop`.
- **Config:** 8 digs + 8 helps/day (`consortia_treasure_Count`), refresh 0,0,10,20,50 diamonds, paid dig 20, speed-up 2 diamonds/10 min.
- **Opcodes:** `9629 C_CONSORTIA_TREASURE_OP`, `390 U_C_CONSORTIA_TREASURE`.
- **Icon:** `<resource>/icon/treasure/{Type}_{Quality}.png` (`decompiled/m6/scripts/consortia/view/myConsortia/treasure/TreasureListItem.as:95`).

### 5.7 Guild campaigns (`ConsortiaPveTemplates`)

- **Stages:** 120 stages = 2 difficulties (0 normal, NodeId 1-60; 1 Pesadelo, 1001-1060) × 5 areas × 12 stages ("[1-1] Pasto Livre" ... "[5-12] Deserto da Morte"); `NextNodeId` chains them; `AreaDropId` 3860001-5/3870001-5 and a per-stage `NodeDropId`.
- **Rules:** 1 challenge/day, up to 8 players per stage, cumulative guild damage; 2-month season (config `consortia_pve_*`).
- **Code:** `GuildFbController` (`decompiled/core_module/scripts/mvc/controler/GuildFbController.as:65`): `8554 C_CONSORTIA_PVE_CLIENT_OP`, `4884-4889 U_C_CONSORTIA_PVE_DATA/NODE_UPDATE/CUR_NODE/SEASON_DATA/BOSS_HP`. UI: `decompiled/m6/scripts/consortia/view/fb`.

### 5.8 Terra dos Sonhos: old guild boss (`ConsortiaBossTempInfos`)

- **Levels:** 1-10; HP 200%..2000% and attack 100%..900% of base (server-side only). Win prize = Dente do Terror 600+200·Level + item 2060802; a loss gives 1/4.
- **Quests:** A (Coletar Frutos do Sonho), B (Eliminar Taus), C (Eliminar Goblins), goals `ATotal/BTotal/CTotal`=10 (`ConsortiaEmeDreamInfo.as:76`); completing A removes the leader's nightmare state.
- **Summon:** the President summons 1×/day (`8847 C_CONSORTIA_BOSS_CALL`; level up `8846 C_CONSORTIA_BOSS_UPGRADE`); state `U_C_CONSORTIA_BOSS_*` 4726-4729, 4861-4863.

### 5.9 New Guild Boss (`ConsortiaNewBossTemplates`)

- **Difficulties:** 1000 (`Level`), `BossId` "5000001,5" (first value = monster), `HpMultiple` 3100 → 53000 (server-side only).
- **Schedule:** 3 rounds/week of 48h (2880 min), 3 challenges per round, reset 12:00. Fast wins unlock jumps (≤45 min → 7 levels, 90 → 6, 180 → 5, 360 → 4, 720 → 3, 1440 → 2; formula 7+a·(n−1)).
- **Buffs:** 5 skills at 50000 Fortuna, 1h, 6/day (`consortia_newboss_buff_*`).
- **Code:** `ConsortiaNewBossManager` (`decompiled/core_module/scripts/yishi/manager/ConsortiaNewBossManager.as:58`): `8670 C_CONSORTIA_NEWBOSS_CLIENT_OP`, `4283-4287 U_C_CONSORTIA_NEWBOSS_DATA/RANK/HP/USER/STATE`. Prizes are in `ConsortiaNewBossReward`/`ConsortiaNewBossDamageReward` (other group). Shop 1024.

### 5.10 Guild Defense / guild war (`ConsortiaWarQuestTemplates`)

- **New format** (`CrossGuildManager`, `decompiled/core_module/scripts/yishi/manager/CrossGuildManager.as:74`): 2-week season with 7 12v12 battles; a prep day (strategy + bonus from the 12 highest PC) and a combat day, 05:00-23:00.
  - Actions: attack (1 action point), empowered attack (2), interference (1, up to 3×).
  - Defense points 1-12 with HP 7120..3600 (`consortia_war_defence`); "Estado de Guerrilha" (5× damage, 112 uses).
  - Sign-up 150000 Fortuna; contribution 15/30/15 per action.
- **`ConsortiaWarQuestTemplates`:** the interference condition shown on the tower (`questId`; `CrossGuildAttackItem.as:198`): Type 1 bring an Einherjar of an element (`Para1` 101-106), Type 2/3 bring an advanced class. **Mapping bug:** the class uses `Param1/Param2` but the XML has `Para1/Para2` (only `Description` is used).
- **Opcodes:** `8650 C_CONSORTIA_WAR_CLIENT_OP` (op: sign, buffer, buySpirit, towerAttack{teamId,towerId,attackType}), `4566-4573 U_C_CONSORTIA_WAR_*`.
- **Old format:** 35-base map, Saturdays 20:00-21:00, configs `CrossGuild_*`, `cross_guild_*`; uses `U_C_CROSS_GUILD_*`/`U_CR_CROSS_GUILD_WAR_*`.
- **Shops:** 1016 (Loja da defesa de guilda), 13 (Loja do Império).

### 5.11 Duelo Tático: guild chess (`m3/consortiachess`)

- **Rules:** tactical chess between guilds, 19:00-20:00 (`chess_pvp_times`), sign-up 100000 Fortuna; pawn promotion. No template set; the reward is Tactical Points (Pontos Táticos) for shop 1030.
- **Code:** `ChessPvpManager` (`decompiled/core_module/scripts/managers/ChessPvpManager.as:70`): `9730 C_CHESS_PVP_CLIENT_OP`, `CR_CHESS_PVP_CLIENT_OP`, `561-566 U_C_CHESS_PVP_DATA/RANK/RECORD/BOARD_DATA/BOARD_UPDATE/BOARD_RESULT`. Screens in [docs/ui/screens.md](../../docs/ui/screens.md) (m3 `consortiachess.*`).

### 5.12 Supremacia do Legend: auto chess (`AutoChessHeroInfos`, `AutoChessBuffInfos`)

- **Module:** not a guild mode: module `m3/chess` (`SelfChessManager`, `decompiled/core_module/scripts/mvc/module/chess/SelfChessManager.as:77`). Rooms of 6 (`chess_room_num`), 00:00-22:30; points by placement 600/400/300/200/100/50.
- **Pieces:** 112 rows = 32 units (`MasterType`) × stars 1-3 (`NextTemplateId` chains) + 19 monsters (Grade 0). Buy price = `Grade` in gold; sell price = `Grade + (Star−1)·2` (`decompiled/m3/scripts/chess/item/SelfChessTeamItem.as:288`). `Hit` grows with stars (damage to the defeated player per remaining piece, *(assumption)*). `ResType` 1 soldier / 2 einherjar / 3 guardian; icon `ResourcePath + Icon`, animation `ResPath`.
- **Synergies** (`AutoChessBuffInfos`): Job 101 Warrior, 102 Knight, 103 Priest, 104 Sorcerer, 105 Archer, 201 Human, 202 Demon, 203 Angel, 204 Elf, 205 Dragon; they activate with `Amount` (2/3/4/6) distinct units (counted by `MasterType`, `SelfChessModel.as:144`). Icon `icon/autochess/{big|small}/{Job}.png` (`PathManager.as:932`).
- **Opcodes:** `9701 C_SELF_CHESS_OP` (matchmaking), `25031 CR_SELF_PROPELLED_CHESS` (actions: 4 sell, 8 leave...), `4216-4219 U_C_SELF_PROPELLED_CHESS_DATA/OVER/STATE/TIPS`.

### 5.13 Return / Alliance Contract (`Alliance*`)

- **Concept:** "Alliance" is **not** a guild alliance: it is the 同盟契约 event for returning players. A Ressurgido (`PlayerType`=1: offline ≥14 days before the event, level ≥80) allies with up to 3 Eternalistas (`PlayerType`=2, active). Breaking the contract blocks a new alliance for 48h (`alliance_coolingtime`). The shop stays open 7 days after the end (`alliance_delaydays`).
- **`AllianceActivityTasks` (280):** `TaskList` 1 Return / 2 Oracle / 3 Alliance (A/B/C = `TaskNum`); `TaskType` = system·100+variant (101 login, 301 farm, 901 contribution donation, 1902 dig treasure...); `Para1` = goal; `TaskCount` = EXP granted. Some `TaskList` 2 rows are still in Chinese.
- **`AllianceRewardInfos` (29):** `RewardType` 1 daily chest, 2 weekly, 3 milestone, 4 per contract level; `NeedCount` points; up to 6 items.
- **`AlliancePrivileges` (126):** contract level 1-9 × types 101 attribute buff (id 15910101..), 102 Daily Activity +N, 103 campaign EXP +%, 104 Vórtice do Tempo +N, 105 Lágrimas da Deusa purchases, 106 Forbidden Land Boss, 107 progressive Road (`OldPlayerReturnModel.as:322-351`).
- **`AllianceShopInfos` (73):** currency Provas do Retorno (type 1) / Provas de Eternidade (type 2); `Limited` = CSV of 9 limits indexed by contract level.
- **Code:** `OldPlayerReturnManager` (`decompiled/core_module/scripts/yishi/manager/OldPlayerReturnManager.as:80`): `9717 C_ALLIANCE_REGRESSION_OP`, `534-538 U_C_ALLIANCE_ACTIVITY_INFO/USER_DATA/SEARCH_ALLY/OP_RESP`. UI: `decompiled/m11/scripts/oldplayerreturn`.

### 5.14 Outer-city Loja Misteriosa (`MapShopItemTemplateInfos`, m7 `outercityshop`)

- **Types** (`OuterCityShopTemplateResolve.as:24`): Type 1 = points exchange (75 rows, `Score`); Type 2 = roll (671 rows, `Random`=100, filtered by `MinLevel/MaxLevel`/`NeedTransJob`); Type 3 = plans (0 rows).
- **Combinable costs** (`OuterCityShopItemInfo.as:56-72`): `Point` → Diamante (-400), `Score` → points, `SecretStone` → Pedra Secreta 2131057, `Strategy` → Espírito (-300), `Crystal` → Cristal de Luz (-600).
- **Refresh:** at 9h/12h/18h/21h; manual refresh `ShopFresh_NeedDiamond`=10 diamonds, `ShopFresh_DayCount`=10/day. The luck bar favors `IsDrop`=1 items (highlighted; buying asks for confirmation).
- **Opcodes:** `U_C_MAPSHOPINFO` 9528/4946, `294 U_C_OUTER_CITY_SHOP_PASS` (`OuterCityShopManager.as:53`).

### 5.15 Auction house (m7 `auction`, no template set)

- **Client opcodes** (`AuctionMessageSender`, `decompiled/core_module/scripts/mediator/AuctionMessageSender.as:19`): `8448 C_MALL_SELL_ITEM` (`SellItemReqMsg{itemId,itemPos,count,point,fixPoint,hour,sellType 1 item|2 einherjar,fromBagType}`), `8449 C_MALL_LIST_SELL` (my listings), `8450 C_MALL_PLAYER_ITEMS`, `8451 C_MALL_AUCTION` (bid `{id,point}`), `8452 C_MALL_LIST_AUCTION` (history), `8453 C_MALL_FIX_AUCTION` (buyout), `8454 C_MALL_CANCEL_SELL`, `8457 C_MALL_SEARCH`.
- **Server replies:** 4352-4359 (`AuctionMessageHandler`); the result uses enum `auction_result` (0 ok, -18 max 9 listings...).
- **Rules** (`AuctionSellSubmitPane.as:144-239` + pt-BR help):
  - price in diamonds; min bid ≥ max(2, `StartingPrice`·qty) from `ItemTempInfos`; buyout > bid;
  - duration 8/24/48h with a custody fee of 250 gold/h (2000/6000/12000); 20% fee on the sale;
  - items with a bid cannot be cancelled; purchases and expired items arrive by mail;
  - unlocked at Lv40; daily purchase cap 2000 (Lv40-60), 3500 (61-70), 5000 (71-80) diamonds;
  - players cannot bid on their own items.
- **Flash auction** (`SaleManager`, `decompiled/core_module/scripts/managers/SaleManager.as:78`): 5 lots + 1 special system lot. `9584 C_AUCTION_OP` (op 1 bid `{auctionId,buyPoint}`, 2 info, 3 preview, 4 close), `329 U_C_AUCTION` / `330 U_C_AUCTION_STATE` / `332 U_C_AUCTION_NOTIC`.

### 5.16 Standalone shops: Navigation, Game Box, Poseidon, Merit, Furniture

- **Navigation** (`NavigationShopTempInfos`, 66): price `Currency` (Moedas de Navegação) + `Diamond`; `Random` 100 common / 20 rare (with diamond); 6 purchases/day, refresh 10 diamonds (`navigation_shop_*`); `NavigationManager.sendNavigationOperate(14 buy | 15 refresh)` (`decompiled/m15/scripts/view/subshop/NavigationShopGoodsItem.as:150`).
- **Game Box** (`GameBoxShopTempInfos`, 14): exchange Moeda do jogo (`NeedPay` 50..900) for items; `Area` 1-4 = groups; the server sends 4 daily offers. `9559 C_GAMEBOX_OP` (op 1 info, 2 start minigame, 3 exchange), `256 U_C_GAMEBOX_INFO` (`decompiled/core_module/scripts/managers/GameBoxManager.as:54`).
- **Poseidon** (`PoseidonShopTemplates`, 115): ShopType 1 Normal (Gema Poseidon, 70) / 2 Advanced (diamond, 45); `ShopLevel` = floor 1-9; `OpenCondition` = Royalty level 1,5..40; `LimitNumber` 1..650 (reset 0h). `9704 C_POSDIDON_SHOP_PANEL` / `9705 C_POSDIDON_SHOP_BUY`, replies 522/523 (`PoseidonManager.as:47`).
- **Merit shop** (`ExploitsShopTemplates`, 12; Campo de Batalha Secreto `m3/war2023`): rolled items (`Weight`) for Lv240-320, price `MlitaryExploits` 3000..100000 Mérito (-5500); refresh 350 diamonds, 5×/day. `9727 C_EXPLOITS_SHOP_OP`, `540 U_C_EXPLOITS_SHOP` (`SecretWarManager.as:86`).
- **Furniture** (`FurnitureShopTempInfos`, 12): sold in the Loja de Vênus (ShopType 20) for 100 Cristais de Vênus (-1600); references `FurnitureTempInfos`. `9519 C_FURNITURE_SHOP_BUY` (`ShopManager.as:1250`).

## 6. PvP, bosses, ranking and social

This section covers the competitive and endgame systems (Theseus content, arenas, boss ladders, towers and team
minigames) and the social layer (rooms, friends, mail, marriage and rankings). Each subsection lists the rules, the
template sets, the opcodes and the code locations.

### 6.1 Theseus Dungeon (Masmorra de Teseu): `TheseusDungeonEventTemplates`, `TheseusDungeonTaskTemplates`

- **Overview:** monthly exploration over 28 floors. Each floor is a board of blocks (Grid 15 / 25 / 45 = 9x5) that
  the player breaks with **pickaxes**. A broken block can reveal a chest, a monster or a skill buff.
- **Floor unlocks:** floors 1 and 2 open on day 1 of the month, then one new floor opens per day (`TimeUnlock` = day
  of month). `TheseusDungeonModel.getCurrentUnlockedLevel` computes this
  (`decompiled/core_module/scripts/mvc/module/theseus/dungeon/TheseusDungeonModel.as:48`).
- **Requirement:** Royalty 30 (`RoyaltyTemplates.OpenDungeon`).
- **Rules (`ConfigInfos`):**
  - `t_s_theseusdungeon_free=25`: free pickaxes per day; they do not accumulate.
  - `t_s_theseusdungeon_pay=20,20`: up to 20 purchases per day at 20 diamonds each.
  - `t_s_theseusdungeon_reset=1`: reset on day 1 of each month.
  - `t_s_theseusdungeon_time`: 2026-04-01..2030-03-31.
  - Keys and crystals persist when the dungeon closes (help text `dungenexploration.DungenexploFrame.helpFramecount`).
- **Events** (`TheseusDungeonEventTemplates`, 91 rows):
  - **Items and chests** (`CondictionType=1`):
    - 10001: gold bag, -100 x50000.
    - 10002: crystals, -5600 x100..300 with weights 200/150/100/50/10.
    - 10003: dungeon chest key (30000015).
    - 10004: locked chest; requires 1 key (`Property1=30000015`, `Property2=1`).
    - 10005: "?" chest, slate dust (30000000).
    - 10006: divine slate chest (30040000..).
  - **Fights** (`CondictionType=2`):
    - 201xx: common monster (`Property1=1`).
    - 202xx: elite (`Property1=2`).
    - 203xx: boss (`Property1=3`, hero in `Property3`). A boss gives -5600 x100 (Reward1) and always 1 key (Reward2).
    - The monster disappears whatever the outcome (`TheseusDungeonEventInfo.message4`).
  - **Buff** (`CondictionType=3`): 30001 rolls a skill 81000001.. by weight.
  - **Floor composition:** `EventGroup`. Example for floor 28:
    `10001,5|10005,7|10004,2|10003,1|10002,8|10006,1|20128,6|20228,1|20328,1|30001,3`.
- **Quests** (`TheseusDungeonTaskTemplates`, 30 rows):
  - Types 1..7: floor, blocks, elites, bosses, skills, locked chests, pickaxes bought.
  - Every quest has the same fixed reward: -500 x10, -5600 x200..700 and Baú divino 30000010.
- **Code:**
  - Manager: `decompiled/core_module/scripts/managers/DungeonExploManager.as`; actions 1..6 at lines 19-29; the send
    method (`sendDungeonOperate`) at line 135.
  - UI: `decompiled/m11/scripts/dungenexploration/*`. Block click: `item/DungenexploItem.as:103`.
  - Crystal shop: `decompiled/m15/scripts/view/subshop/DungenexShopFrame.as`.
- **Opcodes:**
  - `9763 C_THESEUS_DUNGEON_CLIENT_OP`, `PlayerOpMsg`: `op`, `pos`, `templateId`, `count`.
  - `779 U_C_THESEUS_DUNGEON_DATA`, `TheseusDungeonUserMsg`: `level`, `freeActionNum`, `buyActionNum`,
    `dayPurchasableActionNum`, `blockInfo[position,state,eventId]`, `skillIdList`.
  - `780 U_C_THESEUS_DUNGEON_TASK_DATA`.
- **Graphics:** `ResourcePath + "icon/theseusdungeon" + Icon` (`PathManager.theseusdungeonIconPath`), e.g.
  `/chest_locked.png`, `/battle_03.png`. UI assets use the prefix `asset.dungenexplo.*`.

### 6.2 Theseus Tower (Torre de Teseu): `TheseusTowerTmpls`

- **Overview:** 100 PvE stages (`TheseusTowerTmpls`). Each stage has an enemy hero (`Heroes`, `"10000xxx,5"`) and
  soldiers (`Pawns`, `410000xxx` at positions 2, 3 and 8).
- **Prizes:**
  - **Common prize**, on the 1st win (`FirstRewards`): 7450001 Pedra de Temperamento Divino, 5000 to 15000, and
    7460003 Pedra Divina Impecável, 20 to 68.
  - **Bot prize**, only on the highest cleared stage: `SweepRewards` 7450001 x(1000+10·(stage−1)), plus `SweepRandom`
    7460003 x1 (70), x2 (50), x5 (25).
- **Rules:**
  - A Challenge or a Bot run costs 1 "reward attempt".
  - Free attempts renew every Monday at 05:00 (`theseustower_income_week`; the key is absent from the local
    `ConfigInfos`).
  - Purchased attempts are permanent: 500/1000/1500/2000/3000 diamonds, max 5 per week (`theseustower_income_addprice`,
    `decompiled/m11/scripts/thessTower/view/ThesstowerView.as:53`).
  - Requirement: Royalty 6 (`OpenTower`).
- **Opcodes:**
  - `9760 C_THESEUS_TOWER_CLIENT_OP`: op 0 info, 1 challenge, 2 bot, 3 buy (`TheseussoulManager.as:651`).
  - `768 U_C_THESEUS_TOWER_DATA`, `PropertyMsg`: `param1` passLevel, `param2` free attempts, `param3` bought,
    `param10` purchases this week.
- **UI:** `decompiled/m11/scripts/thessTower/*`. Cards come in pages of 4; start = 3·⌊(passLevel−1)/3⌋+1
  (`ThesstowerView.as:189`).

### 6.3 Theseus Arena (Arena de Teseu, 1v1) and Theseus Multiplayer Arena (Arena Multiplayer de Teseu): `TheseusPvp*`, `TheseusMultiPvp*`

- **Overview:** cross-server duel ranked by points (`integral`), organized in seasons.
  - **Schedule:** `theseus_pvp_open_config=1,1` (1st week of the month, day 1); a season lasts 21 days; entry closes on
    day 7 at 23:00 (`theseus_pvp_open_times`).
  - **Fights:** 5 free per day. Extra fights cost "Rolo de Desafio da Arena de Teseu" 7640003 (op 14) or diamonds
    (`theseus_pvp_buy_count_points=1,20|2,30|3,50|4,50|5,100`, op 15).
  - **Rematch cooldown per division:** `theseus_pvp_matching_cd` = 60/30/30/20/15/10 min.
  - **Requirement:** Royalty 6 (`OpenPvp` → `royaltyTempCate.getPvpLv`).
  - **Help:** `ui.theseuspvp.Scene.helpTip`.
- **Ranks** (`TheseusPvpTmpls`, 16 rows; `Id = MainType*10+SonType`):

  | Rank | Min points |
  |---|---|
  | Prata I | 0 |
  | Prata II | 200 |
  | Prata III | 500 |
  | Ouro I | 950 |
  | Ouro II | 1350 |
  | Ouro III | 1700 |
  | Platina I | 2300 |
  | Platina II | 2850 |
  | Platina III | 3350 |
  | Diamante I | 4200 |
  | Diamante II | 5000 |
  | Diamante III | 5750 |
  | Lenda I | 6750 |
  | Lenda II | 7750 |
  | Lenda III | 8750 |
  | Hall | 10000 |

  - `MatchingSection` limits the possible opponents.
  - `OpenShop` (1..6) unlocks the matching Arena Shop tab, paid with Mérito de Teseu 7640001
    (`decompiled/m15/scripts/view/subshop/TheseuspvpShopFrame.as:121`).
- **Scoring** (`TheseusPvpIntegralTmpls`, 352 rows = 16 ranks × 2 modes × 11 bands):
  - **Win:** 100→40 (−6 per band).
  - **Loss:** 30→90 in mode 1 (attack). In mode 0 (defense, when another player challenges you) the loss is 0.
  - **Band** (`Section`): point difference from −9999..−1000 to 1001..9999 *(assumption: the difference reads as
    "mine − opponent")*.
  - **Win streak** (`WinningStreak`): 3→+10 ... 10→+80.
  - The result screen shows "vitórias x{0}, extra +{1}" (`decompiled/m3/scripts/theseuspvp/TheseusPvpResultFrame.as:181`).
  - **Data error:** band "-299,200" should be "-299,-200".
- **Prizes** (`TheseusPvpRewardTmpls`):
  - **Area 1, daily:** match 5/10×, win 1..10×; pays Glória da Arena 7640002.
  - **Area 2, rank:** Mérito de Teseu 100..2000.
  - **Area 3, season:** 1st place 2127023 x1000 + title 7640101 ... 51st-9999th place x200.
  - **Prêmio do Valente** (pass): daily Glory raises levels (Gear, op 10); the advanced track costs 1500 diamonds
    (op 9, `specialrewar_theseus_diamonds`). Unclaimed rewards arrive by mail.
  - Liking a player in the Hall da Glória gives -100 x50000 (`theseus_pvp_like_reward`).
- **Multiplayer** (room type `RoomType` 16, `TheseusMultiPvp*`):
  - Same 16 ranks (Id 1..16; the last is "Mestre"). Only mode 1 (176 rows).
  - Quests: match 2/4/6/10× pays Emblema da Glória 7650004; Area 1 also shows as a chest bar
    (`TheseusRoomReadyTopView.as:146`).
  - Rank prizes pay 7450001; season prizes pay 7460003.
  - Challenge scroll: `theseus_multi_pvp_item_count=7640003,10`. Fight purchase: 50 diamonds. Advanced track: 2000
    diamonds.
  - **Bug:** `TempleteManager` loads `"TheseusMultiPvpIntegralTmpl"` without the trailing "s"
    (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1400`), so the client probably ends up with an
    empty list. Only the server-side code uses the table.
- **Code:**
  - Manager: `decompiled/core_module/scripts/managers/TheseusPvpManager.as`. Receive handler at line 206; send methods
    `doSomething` (line 445, 1v1) and `doSomething1` (line 455, multi).
  - UI: `decompiled/m3/scripts/theseuspvp*`, `theseusdoublepvp*`; entry point in `decompiled/m11/scripts/godpvpenter/*`.
  - Screens: `TheseuspvpShopFrame` in [docs/ui/screens.md](../../docs/ui/screens.md).
- **Opcodes:**
  - Send: `9712 C_THESEUS_PVP_CLIENT_OP`, `9736 C_THESEUS_DOUBLEPVP_CLIENT_OP`. Ops 1..15: open, leave, match, cancel,
    reports, hall, claim, like, unlock advanced, claim level, claim all, server ranking, prize list, use scroll, buy.
  - Receive (1v1): 4312-4320 `U_C_THESEUS_PVP_USER/REWARD/RANK/SHOW/REPORT/LEAVE_REPORT/MATCH/FIGHT_RESULT/SEASON`.
  - Receive (multi): 575-583 `U_C_THESEUS_PVPDOUBLE_*`.
  - The multi room uses `5037 U_C_ROOM_STATE`, `5036 U_C_PLAYER_READY_STATE` and `5028 U_C_CAMPAIGN_ROOM_INVITE`.
  - Proto: `TheseusPvpUserMsg` with `integral`, `pvpId`, `rank`, `keepWin`, `freeCount`, `likeInfo`, `specialInfo`,
    `openPaySpecial`... and `TheseusPvpReportMsg.mode` (0 = defense).

### 6.4 Protection Spirit Arena (Arena do Espírito de Proteção): `ChildPvp` / `ChildNswar`

- **Overview:** formation duel with 3 main Protection Spirits (Guardians) that fight in turns and 2 support spirits
  that enter with 85% of their attributes.
  - The winner of each turn recovers 30% HP.
  - After 30 s, damage rises +100% every 30 s.
  - Help: `childnswar.team.helpTip`.
- **Ranks** (`ChildPvpTmpls`): 26 ranks, Prata I to Lenda V plus Hall (`Id = MainType*10+SonType`, SonType 1..5).
  Min points 0 to 10000. `MatchingSection` is a band per division.
- **Rules:**
  - Fixed points: +15 per win, −10 per loss (`child_pvp_rankpoints`).
  - 5 free + 5 extra fights per day (`child_pvp_day_free_count=5,5`). Purchases: 20/30/40/50/100 diamonds.
  - Hours: 01:00-23:00. 21-day season.
- **Prizes** (`ChildPvpRewardTmpls`):
  - TaskType 1: match. TaskType 2: win. Both pay Mérito da Arena do Espírito de Proteção 7650001.
  - TaskType 3: rank, 400..2000 Mérito.
  - TaskType 4: season ranking, -19000 Gema Poseidon from 15000 (1st) to 2000.
  - Shop with tabs by `OpenShop`: `decompiled/m15/scripts/view/subshop/ChildNswarShopFrame.as:128`.
- **Opcodes:**
  - Send: `9732 C_CHILD_PVP_CLIENT_OP`. Ops 1 open, 2 use scrolls, 3 buy, 4 match, 5 cancel/leave, 6 claim,
    7 ranking, 8 prizes, 9 save formation.
  - `25240 CR_CHILD_PVP_AID`: calls the support spirit during battle (`SocketSendManager.as:240`).
  - Receive: 568-574 `U_C_CHILD_PVP_USER/REWARD/RANK/MATCH/FIGHT_RESULT/SEASON/BATTLE`.
- **Code:** manager `decompiled/core_module/scripts/managers/ChildNswarManager.as`; UI `decompiled/m3/scripts/childnswar/*`.

### 6.5 Lord Trial (Julgamento Principal): `LordTrialTempInfos`

- **Overview:** weekly tower with 3 difficulties.
  - The week runs from Monday 01:00 to Sunday 23:00; the ranking is computed between cycles.
  - **Keys:** each floor consumes Chaves do Julgamento (-4300), obtained through **Oração** (prayer): 3 per day; each
    of the 5 cards has a 25% chance of being a key. **Sacrifício** (3 per day) keeps the keys already obtained
    (`lord_trial_pray_templates=3,3,25`).
  - **Bot:** 30 s and 10000 gold per floor; speed-up costs 5 diamonds (`lord_trial_sweep_templates`,
    `decompiled/m5/scripts/mopup/view/LordTrialMopupPrepareFrame.as:162`).
  - Spirit, Guardian and Einherjar stay locked until reset.
- **Template set** `LordTrialTempInfos` (90 rows), keyed by `para1`:
  - 0/1/2: per-floor drop for difficulty 1/2/3; `para2` = floor or range. Example: difficulty 1, floor 30 → 20 Pedras
    dos Deuses 212018 + 20 Cristais da Estrela 212015.
  - 100/101/102: weekly ranking prize; `para2` = position band (1-10, 11-20, 21-50, 51-100).
  - 200: prayer prize by key count (0..5). Example: 5 keys → 5 Chaves do Julgamento + 20 Pedras + 5 Cristais.
  - Lookup: `LordTrialTempCate.getItemsByPara1AndPara2` / `getRankRewrad` / `getPrayItems`.
- **Opcodes:**
  - `9650 C_LORD_TRIAL_OP`, `LordTrialOpType`: 0 open, 1 reset, 2 pray, 3 finish prayer, 4 sacrifice, 5 fight, 6 bot,
    7 cancel, 8 speed up, 9 collect.
  - `445 U_C_LORD_TRIAL`.
- **Code and screens:** `decompiled/core_module/scripts/yishi/manager/LordTrialManager.as`,
  `decompiled/m11/scripts/lordtrial/*`. Screens `LordTrialMainFrame`, `LordTrialPrayFrame` and `LordTrialRankFrame` in
  [docs/ui/screens.md](../../docs/ui/screens.md).

### 6.6 Ecliptic Palace (Palácio Zodiacal): `EclipticPalaceTempInfos`

- **Overview:** 12 houses (Áries..Peixes, `EclipticPalaceTempInfos.Layer`).
  - Challenging a house costs Spirit: `SpiritCost = 10+5·(Layer−1)`.
  - **Spirit:** max 200, +25 per hour; buy for 200 diamonds, up to 40 times (`ecliptic_palace_spirit_*`).
  - Leaving the palace takes 14 h (`ecliptic_palace_decline_layer_hour`).
  - Bosses get attribute bonuses from skills 90001..90004, 0% to 40% (`BossAdditionSkillId`, server-only).
  - Drops are in `EclipticPalaceDrop` (another group).
- **Opcodes:**
  - `5190 C_ECLIPTIC_PALACE_OP`: 1 open, 2 challenge, 3 hidden event, 4 buy spirit, 5 prizes
    (`EclipticPalaceConstClass.as:6`).
  - `173 U_C_ECLIPTIC_PALACE_INFO`, `174 U_C_ECLIPTIC_PALACE_REWARD_RECORD`.
- **Code:** UI in `decompiled/m14/scripts/eclipticpalace/EclipticPalaceFrame.as:334`. Graphics in
  `ui/zh_cn/swf/eclipticpalace.swf`.

### 6.7 Dream Arena (Arena Ilusória): `DreamArenaTemplates`

- **Overview:** draft arena. The player picks pre-built units from `DreamArenaTemplates` (71 rows), by `Type`:

  | Type | Unit | `TypeTemplateId` table |
  |---|---|---|
  | 1 | Hero, by class 1..3; class 0 = Dragon Talker | GameHeroTemplates |
  | 2 | Einherjar (pet) | PetTemplates |
  | 3 | Main spirit | ChildTemplates (grade 12) |
  | 4 | Support spirit | ChildTemplates (grade 12) |
  | 5 | Goddess | GoddessTemplates |
  | 6 | Artifact | ArtifactTemplates |
  | 7 | Arsenal/titan | ArmoryTemplates (profile 5) |
  | 8 | Talisman | ItemTempInfos |
  | 9 | Rune | RuneTemplates |

- **Unit data:**
  - Fixed attributes via `PropertyId` → `SkillPropertyTempInfos`. Example: 612001 gives Attack 3.7M and HP 12.2M.
  - A hero picks skill set `Skill1` or `Skill2` (`skillIndex1`), with passives `PassiveSkill1`/`PassiveSkill2`.
    `Param1=300199` is the talent "Selo Sagrado" Lv99. `Param2` = 4 visual items.
  - The Dragon Talker (Type 1, id 0) has its proficiencies in `Skill3`.
- **Rules:**
  - A run ends at 12 wins or 3 losses.
  - Entry requires ticket 208111 "Bilhete da Arena Ilusória". Fights run 19:30-21:30 (`dream_arena_*`).
- **Opcodes:**
  - `8654 C_DREAM_ARENA_CLIENT_OP`, ops 0..13: panel, ranking, picks 2..10, match, cancel, open.
  - 4581-4584 `U_C_DREAM_ARENA_USER/FIGHT/MATCH/TICKET`.
- **Code:** `decompiled/core_module/scripts/managers/DreamArenaManager.as`, `decompiled/m13/scripts/dreamarena/*`.
  Graphics in `ui/zh_cn/swf/dreamarena.swf`.

### 6.8 Monster Explore (Exploração de Monstros): `MonsterExploreDrop`

- **Overview:** idle system with 4 chapters (Pasto Livre, Floresta Nublada, Pântano Sem Fim, Deserto da Morte) and
  145 nodes.
  - The chosen node yields `MinuteGold`/`MinuteExp` per offline minute (10..730 gold, 20..1231 EXP) and
    `NpcGold`/`NpcExp` per kill (5/10/15/20).
  - Beating the node boss unlocks the next node; its drop comes from `BossDrop` → `MonsterExploreDrop.DropId`.
  - Fast combat: 10 per day; each gives 120 minutes of gains for 100 diamonds (`monster_explore_fast_config`).
  - Starting monster: 101 (`monster_explore_present`). The boss prize is capped at 10 per day.
- **Graphics:**
  - Chapter map: `swf/singlecampaign1/{ChapterMapPath}/map/{id}.swf`.
  - Node image: `images/InstanceImg/{NodeMapPath}/big.jpg`.
  - Background: `images/monsterexplore/{FightMapPath}.jpg`.
  - Node position on the map: `PosX`/`PosY`.
- **Opcodes:**
  - `8653 C_MONSTER_EXPLORE_CLIENT_OP`, ops 0..6: open, close, edit formation, choose node, speed up, boss, boss sweep.
  - 4576-4580 `U_C_MONSTER_EXPLORE_EDIT_DATA/FIGHT_DATA/USER_DATA/BOSS_REWARD/EXP`.
- **Code:** manager `decompiled/core_module/scripts/yishi/manager/MonsterExploreManager.as`.

### 6.9 Forbidden Boss (Chefão da Zona Proibida): `ForbiddenBossTemplates`

- **Overview:** cross-server bosses.
  - Servers are grouped every Monday, up to 4 per group.
  - Hours: 06:00-23:59 (`ForbiddenBoss_time`). The help text says 08:00-24:00.
  - The Zona Proibida does not allow the Dragon Talker.
  - Only own attributes + Theseus Soul/Armor count.
- **Template set** `ForbiddenBossTemplates` (47 bosses):
  - `Category` = zone, 1-5: Normal, Aventura, Pesadelo, Caverna, Pesadelo superior. Each zone unlocks via
    `RoyaltyTemplates.OpenForbidenBoss`.
  - `BossType` = seal: Comum, Estrela, Lua Vermelha, Demônio, Supremo.
  - `RefreshParm` = respawn 10/30/60/90/120 *(assumption: minutes)*. `BossCD` = 30..90.
  - `BAV` = recommended armor, 0 to 19000. Below it, skill 84101001 applies (−90% damage).
- **Rewards:**
  - **Ownership** (`RewardShow1`): goes to the player with the highest cumulative damage.
  - **Participation** (`RewardShow2`): goes to the members of the owner's guild.
  - Quotas per zone: 8 (Normal) and 3 elsewhere; totals 8+8 (`ForbiddenBoss_*Rewards_limit/max`).
  - Min damage for ownership: `ForbiddenBoss_Killhp=7000`, probably 70.00% in base 10000 *(assumption)*.
  - First-kill prize (`FirstRewards`): claimed via op 3.
- **Opcodes:**
  - `8675 C_FORBIDDEN_BOSS_CLIENT_OP`: 1 open, 2 enter, 3 prize, 4 record.
  - 4293-4297 `U_C_FORBIDDEN_BOSS_USER/LIST/RANK/RECORD/HP`.
- **Code and graphics:**
  - Manager: `decompiled/core_module/scripts/yishi/manager/ForbiddenBossManager.as`.
  - UI: `decompiled/m11/scripts/forbiddenboss/*`; map in
    `decompiled/m3/scripts/map/campaign/view/ui/ForbiddenBossMapFrame.as`.
  - Boss model: `swf/npc/forbiddenboss/{MarkImage}` (`PathManager.getForbiddenBossPath`).
  - Screens in [docs/ui/screens.md](../../docs/ui/screens.md): `ForbiddenBossFrame` 950×665, `ForbiddenRewardsFrame`,
    `ForbiddenRecordFrame`.

### 6.10 Royalty Road (Caminho da Realeza / Chefão da Realeza): `RoyaltyBossTemplates`, `RoyaltyTemplates`

- **Overview:** 600 sequential bosses (`RoyaltyBossTemplates.Level`). Help in
  `royaltyBossFrame.helperFrame.helpTxt.text`.
  - Each boss has a recommended armor (`ArmourValue`, 0 to 14783) and a recommended power (`SoulValue`).
  - Each win gives -19000 Gema Poseidon x200.
  - No Dragon Talker; only own attributes + Theseus Armor count.
- **Royalty level** (`RoyaltyTemplates`, 1..40): the highest `RoyaltyLevel` with `BossLevel ≤ passBossLevel`
  (1, 16, 24, 32, 42 ... 600). Each level gives:
  - Attribute skill `SkillId` (Lv1 Attack 150/HP 900 → Lv40 Attack 6000/HP 36000).
  - Unlocks:

    | Field | Unlocks |
    |---|---|
    | `OpenTheseus` | Theseus Armor sets, 1..9 |
    | `OpenForbidenBoss` | Zona Proibida, 1..5 |
    | `OpenShopLevel` | Poseidon Shop floor, 1..9 |
    | `OpenOutsideTreasureHoke` / `OpenInsideTreasureHoke` | Outer and inner treasure slots |
    | `OpenCoreTreasureHoke` | Max core level, up to 150 |
    | `OpenWarSoul` | War Spirits 3/6/9 |
    | `OpenWarSoulTower` | Torre da Guerra |
    | `OpenFinalRoad` | Caminho Final 1..3 |
    | `OpenPvp` / `OpenTower` | Theseus Arena and Tower, at level 6 |
    | `OpenDungeon` / `OpenSlate` | Dungeon and Slates, at level 30 |

  - The helpers `RoyaltyTempCate.get*Lv`
    (`decompiled/core_module/scripts/yishi/datas/templates/cate/RoyaltyTempCate.as:162-234`) compute the min level of
    each unlock.
- **Opcodes:**
  - `8674 C_ROYALTY_CLIENT_OP`: challenge, no body.
  - `4292 U_C_ROYALTY_DATA`, `PropertyMsg`: `param1` royaltyLevel, `param2` passBossLevel.
  - The ranking comes from `TEMPLATE_PATH + "royalty.xml"`, with `item@Order`, `NickName`, `RoyaltyLevel`, `BossLevel`.
- **Code:** `decompiled/m11/scripts/royaltyboss/*`. The module `decompiled/m5/scripts/theseus/*` (Theseus Armor)
  queries the unlocks.

### 6.11 Calabouço Aleatório buff shop: `RandomBossBuffInfos`

- **Scope:** this is **not** the World Boss buff. It is campaign node type 92 in the Calabouço Aleatório
  (`Random_Boss_Count=1` entry per day).
- **Rules:**
  - The server sends `4945 U_C_RANDOMBOSSBUFF`, `RandomBossBuffefMsg`: `turn` + `buffs[skillId, buy_count]`
    (`decompiled/m3/scripts/map/campaign/CampaignSocketManger.as:2321`).
  - Each round offers 4 buffs (`Index` 1..4); there are 18 sets of 4 (`SkillId` 801080..801151).
  - Each buff can be bought 3 times (`CanBuyCount`) for 6..9 Cristais de Sangue (2130058).
  - Purchase: `8582 C_BUY_TRIAL`, `TrialInfoMsg{skillId, count=1, param1}`
    (`decompiled/m3/scripts/map/campaign/view/ui/CampaignBuffShopItem.as:145`).
  - UI: `CampaignBuffFrame`.

### 6.12 World Boss (no template set in this group)

- **Rules (`ConfigInfos`):**
  - Buff purchasable for 5 diamonds or 5 gift (`WorldBoss_Buffer_*`).
  - Substitute: 30. Revive: 2. Enter immediately: 3.
  - Cumulative damage prize: `WorldBoss_Wound1..3` = 0.003/0.005/0.008.
- **Opcodes:**
  - Send: `8258 C_WORLD_BOSS_CMD`, `8259 C_WORLD_BOSS_REQ`, `8264 C_WORLDBOSS_PLAYER_LIVE`, `8271 C_WORLDBOSS_STATE`,
    `8526 C_OPRATE_REPLACEMENTS`, `8470 C_WORLDBOSS_BUFFER` (in `MapSocketOuterManager.as:120`).
  - Receive: `4374 U_C_WORLDBOSS_BUFFER`, `4381 U_C_WORLDBOSS_LOAD`, `4203 U_C_WORLDBOSS_REPORT`,
    `4369 C_WORLDBOSSWOUND_REWARD`.
- **Code:** `decompiled/core_module/scripts/managers/WorldBossSocketOutManager.as:31`. UI in
  `decompiled/m13/scripts/worldboss/*`.

### 6.13 Game Hall (Salão de jogo): `GameHallTemplates`

- **Overview:** cooperative team minigames (`GameHallTemplates`):

  | GameId | Game | Level | Days |
  |---|---|---|---|
  | 1 | Fase super-rápida | 36 | Mon/Thu/Sun |
  | 2 | Campo de Minas (5 stages with mines) | 80 / job transfer | Tue/Fri/Sun |
  | 3 | Plano de Crise (2 difficulties) | 80 | Wed/Sat/Sun |
  | 4 | Busca de ovos (Easter, 2019-05-17..24) | 160 | all |

- **Rules:**
  - `OpenDays`: 1 = Monday ... 7 = Sunday. Sunday arrives as 0 and is converted to 7
    (`decompiled/core_module/scripts/mvc/module/gamehall/GameHallModel.as:301-308`).
  - `Count` = 1 prize per day.
  - `ShowItems`, "|"-separated: showcase per difficulty.
  - `Tag=1` shows the "Novo" badge.
- **Opcodes:**
  - `8646 C_GAME_HALL_OP`, team ops 1..14: list, info, create, join, leave, kick, captain, password, game, start,
    accept invite, ready, search, cancel auto.
  - Other sends: `8647 C_GAME_HALL_EDIT_POS`, `8648 C_GAME_HALL_INVITE`, `8649 C_GAME_HALL_MOVE`,
    `8655 C_EASTER_CLIENT_OP`, `CR_GAME_HALL_CHAT`.
  - Receive: 4561-4565 `U_C_GAME_HALL_TEAM_LIST/DATA/POS/INVITE/MOVE`, 4585/4587 `U_C_EASTER_USER_DATA/LOTTERY_DATA`.
- **Code and screens:** UI in `decompiled/m3/scripts/gamehall/*`; screen `GameHallFrame` 975×645 in
  [docs/ui/screens.md](../../docs/ui/screens.md).

### 6.14 Colosseum (Coliseu)

- **Rules:**
  - Asynchronous challenge against ranked players.
  - Free challenges = `totalCount`. Each extra challenge costs `min((purchases+1)·2, 10)` diamonds
    (`decompiled/core_module/scripts/mvc/module/colosseum/ColosseumModel.as:82`).
  - 5 s wait between challenges (`ColosseumControler.as:289`).
  - The ranking comes from `TEMPLATE_PATH + "challengeorder.xml"`.
- **Opcodes:**
  - `8256 C_CHALLENGEINFO_REQUEST`, `ChallengeRequestMsg.type=0`.
  - `8253 C_CHALLENGE`, `ChallengeMsg{tarUserId, payType}`.
  - `4169 U_C_CHALLENGE_INFO`, `ChallengeInfoMsg`: `totalCount`, `totalBuyCount`, `challengeCount`, `curRank`,
    `lastWinCount`, `leftDay`, `noticMsg`, logs.
- **Code:** UI in `decompiled/m13/scripts/colosseum/*`.

### 6.15 Apex League (Liga do Pico)

- **Rules:**
  - Cross-server team league, room `RoomType=14`.
  - Schedule: Thursday; prep 18:00, start 20:00, end 21:00 (`apex_open_time=4|18:00,20:00,21:00`).
  - Captain sign-up: 3,000,000 gold. Min power: 1 million.
  - Groups by points:

    | Min points | Win | Loss |
    |---|---|---|
    | 0 | +80 | −30 |
    | 500 | +65 | −25 |
    | 1000 | +55 | −20 |
    | 1500 | +45 | −15 |
    | 1800 | +35 | −10 |
    | 2100 | +25 | −5 |

  - Killing the enemy captain gives +5. Title for 1st place in the Master final: appell 430.
  - The league has betting.
- **Opcodes:**
  - `5439 C_APEX_CLIENT_OP`, `param1` = op, 1 to 18 (`decompiled/core_module/scripts/yishi/manager/ApexManager.as:485-620`).
  - Receive: 184, 185, 191, 4214, 4681-4689, 4807 `U_C_APEX_*`.
- **Code:** UI in `decompiled/m9/scripts/apex/*`.

### 6.16 Rooms, friends, mail, marriage and rankings

- **Rooms:**
  - Types: `RoomType` (`decompiled/core_module/scripts/yishi/datas/consant/RoomType.as`). 0 PvE, 1 PvP, 2 vehicle,
    3 Molong / Fase super-rápida, 4 marriage, 5 MultiLords, 6 PvP-campaign, 7 group, 8 MateLords, 9 AresLords,
    13 sandbox, 14 Apex, 15 Glory, 16 Theseus multi, 100 bonfire.
  - States: `RoomState` 0..3 and `RoomPlayerState` 0 waiting, 1 ready, 2 owner.
  - Opcodes: `U_C_CAMPAIGN_ROOM_*` (send 5023-5039, receive 12-32/120/121), `8344 C_ROOM_PWDCHANGE`,
    `8465 U_C_ROOM_FIND`, `4984 U_C_VOTE_KILLPLAYER`, `4994 U_C_MATCH_COMFIRE`.
  - Code: `decompiled/core_module/scripts/managers/RoomManager.as:70`,
    `decompiled/m9/scripts/room/net/RoomSocketOuterManager.as`.
- **Friends:**
  - Relations (`RelationType`): 0 none, 1 friend, 2 blacklist, 3 stranger, 4 recent contact. Friend groups exist
    (`CH_ADD/DEL/RENAME_GROUP`, `CH_FRIEND_MOVE`).
  - Opcodes:
    - Send: `15003 U_CH_ADD_RELATIONSHIP`, `15004 U_CH_REMOVE_RELATIONSHIP`, `15012 U_CH_FRIENDADD_CONFIRM`,
      `15013 U_CH_RECOMMENDLIST`, `15042 CH_FRIEND_SEARCH`, `9606 C_GLOBAL_RELATION_GRAPH`.
    - Receive: 78/79/84/85/160/161/165/4227-4230/4246/4272/4273.
  - Code: `decompiled/core_module/scripts/managers/FriendSocketOutManager.as`,
    `decompiled/core_module/scripts/yishi/manager/FriendManager.as`; UI in `decompiled/m12/scripts/friends`.
- **Mail:**
  - Types (`EmailType`): 1 player, 2 system, 3 battle report, 4 stars, 5 pet.
  - `MailInfoMsg` has up to 5 attachments (`annexN`, `annexNCount`). Sending carries `send_type` and `pay_type`.
  - Opcodes: `8204/4131 U_C_MAIL_LIST`, `8205 U_C_MAIL_SEND`, `8206/4132 U_C_MAIL_DEL`, `5022/33 U_C_MAILITEM_MOVE`
    (result 114), `148 U_C_NEW_MAIL`, `9591/337 C_MAIL_CHECK`.
  - UI: `decompiled/m11/scripts/emailII`.
- **Marriage:**
  - Ops in `MarrySender` (`decompiled/core_module/scripts/mvc/module/marry/MarrySender.as`):
    - `8759 C_marriage_REQUEST`, opType 1..20: proposal, reply, quality, room, procession, divorce (8/14/15/16/17),
      ring, satisfaction, skill, find partner.
    - `8760 C_MARRIAGE_CAMPAIGN_REQUEST`, opType 104-112: ceremony gifts and invites.
    - `8773 C_MARRIAGE_TREE_REQUEST`, `8774 C_MARRIAGE_TASK_REQUEST`.
    - `8802 C_MARRIAGE_HEART`, opType 3003/3004: heart test.
    - `15049 CH_MARRIAGE_BUY_SPEC`.
  - Receive: 357-359, 4656-4678, 4690-4691 `U_C_MARRIAGE_*`.
  - The ceremony is a `RoomType.MARRY_CAMPAIGN=4` room. The marriage template sets belong to another group.
- **Rankings:**
  - The general ranking (`decompiled/core_module/scripts/mvc/controler/SortController.as:779`) loads static XMLs from
    `TEMPLATE_PATH`, one per `SortModel` type:

    | `SortModel` type | XML |
    |---|---|
    | 1 level | `day/week/total.xml` |
    | 2 | `fight.xml` |
    | 3 | `totalfightcapacity.xml` |
    | 4 | `constainfight.xml` |
    | 5 | `geste.xml` |
    | 6 | `daycharm/weekcharm/totalcharm.xml` |
    | 7 | `soulscore.xml` |
    | 9 | `petfightcapacityrank.xml` |
    | 12 | `returnedplayers.xml` |
    | 13 | `childfightcapacityrank.xml` |
    | 14 | `theseus.xml` |

  - Other XMLs: `royalty.xml`, `challengeorder.xml`, `tower/tower2/tower3.xml`, `singlepass.xml`, `dungeon.xml`,
    `guardpverank.xml` (`PathManager.as:486-760`).
  - The campaign ranking uses `4151 U_C_RANK_LIST`, in
    `decompiled/core_module/scripts/yishi/manager/CampaignRankManager.as:52`.
  - System-specific rankings (Theseus PvP, ChildPvp, Forbidden, Dream Arena) arrive through each system's `*_RANK`
    opcodes.

## 7. Seasonal events and rewards

This section covers the event calendar, the limited-time events (Easter, Christmas, Carnival, anniversaries) and the
reward tables of recurring systems (towers, leagues, collections) that live in the same template group.

### 7.1 Event time windows (calendar)

- **Generic mechanism:** the server sends `4590 U_C_TOP_TOOL_BTN` with a `PropertyMsg`. Each manager filters on
  `param1` = event id; `param7` = open (bool), `param4`/`param5` = start/end `"YYYY-MM-DD hh:mm:ss"`. The manager then
  fires `REFRESH_TOPTOOLS` (top bar button).
  - Examples:

    | Event id | Event | Handler |
    |---|---|---|
    | 4030 | Christmas | `decompiled/core_module/scripts/yishi/manager/ChristmasManager.as:118` |
    | 4025 | Carnival | `.../CarnivalManager.as:80`; closes the frame if `isOpen=false` |
    | 4020 | Easter | `decompiled/core_module/scripts/managers/GameHallManager.as:738` |
    | 2061 | Anniversary | `.../managers/YearActiveManager.as:86` |

  - Other ids (enum `top_tool_activity_id`): 2058 Poço dos Desejos, 2059 Super Check-in, 2064 Custom VIP,
    2065 Labirinto Negro, 4022 New First Recharge, 4023 Questions, 4024 Memory Cards, 4029 Secret War.
- **Dates and hours in `ConfigInfos.xml`** (read via `ConfigInfoManager`):
  - `christmas_time` 2025-12-23 → 2026-01-05; `christmas_answer_time` 12:00-14:00 | 19:00-21:00
    (`ConfigInfoManager.as:2068`); `christmas_answer_count`=15 questions per round; Nevoado closes 23:30-00:30 (help
    text).
  - `CarnivalStartDate/StopDate` 2024-12-24 12:00 → 2025-01-06 23:59; daily reset `CarnivalDailControl`=00:00.
  - `seven_year_start/stop_date` 2020-05-11 → 2020-06-08. `year_time`/`year_game_time` 2023-05-22 → 2023-06-05.
  - `unrealshooting_time`=16:00-16:15 | 21:00-21:15 (`ConfigInfoManager.as:767`).
  - Vórtice: the rift renews every hour at :05. Torre da Guerra, Caminho do Céu and League reset at 0h.
- **Activity queue and alerts** (Vórtice do Tempo `mainBar.view.QueueItem.TimeVortex01`, Guardiões Procurados):
  `QueueBarManager` (`decompiled/core_module/scripts/yishi/manager/QueueBarManager.as:87`).

### 7.2 Easter Game Hall event: `EasterTemplates`

- **Overview:** team game `gameId 4` of the Game Hall (m3/gamehall; screens in
  [docs/ui/screens.md](../../docs/ui/screens.md): `gamehall.GameHallFrame` "Salão de jogo", `GameHallEastShopFrame`
  "Sorteio de ovos").
  - The team picks a **difficulty** = `EasterTemplates.TemplateId` (1..120, sent as `GameTeam.difficulty`;
    `GameHallGameInfo.as:29`).
  - Unlocked stage list: `EasterUserMsg.openList` (`GameHallManager.as:607`), 5 per page.
- **Waves:** Boss1 (4 monsters at positions 2,3,8,9, e.g. "Lobo Do Pasto" 620001) → Boss2 (boss of the previous
  stage) → Boss3 (stage boss, position 5) → Boss4, a bonus "Ladrão de ovos" 619121 with `Probability`=20%
  *(assumption)*.
  - `heroId,pos` strings → `GameHeroTemp`.
  - Buff1/Buff4 = 9200005 (the monster ignores 100% damage).
  - Drop1..4 = server-side drop tables 1760001..1760128.
- **Curses and blessings:**
  - `Buff3` lists the boss curses: 9201xxx Flor de Gelo reflects 5%, 9202xxx Gelo, 9203xxx Nevasca recovers 150% HP
    per action, 9204xxx Violência +315% damage (SonType 78001..78004).
  - The player has **spring blessings** (`EasterUserMsg.wish` "skillId,level|..."): 9200001 Neve derretida,
    9200002 Broto, 9200003 Recuperação, 9200004 Vitalidade (same SonTypes).
  - Effective curse grade = `TemplateId - floor(level/5)`
    (`decompiled/m3/scripts/gamehall/room/GameHallSceneEastBlessView.as:440`).
  - `DropWishes` says which blessings matter (1 up to stage 30 ... 4 from 91).
- **Costs and config:**
  - `TicketCount`=1 ticket (`currencyInfo.eastTickesCoin`, `GameHallSceneBottomView.as:747`).
  - `easter_ticket_config`=1000,10,18,5 (price, quantity per purchase, purchases per day, free tickets).
  - `easter_egg_buff_config`=3,1000,35,6 (egg buff x3, price, uses, purchases per day).
  - `easter_reward_add`=30,10 (+10% per 30 levels of blessing difference).
  - The egg draw costs `easter_lottery_egg_count`=100 eggs (`ConfigInfoManager.as:1252`); pool in `EasterLotteryDrop`
    (group E).
- **Opcodes:**
  - `8655 C_EASTER_CLIENT_OP` via `opEastFrame(op,count)` (`GameHallManager.as:673`): op 0 open list, 2 open shop,
    3 draw 1/10, 4 other.
  - `4585 U_C_EASTER_USER_DATA` (buyCount, buyBuffCount, buffCount, openList, wish).
  - `4587 U_C_EASTER_LOTTERY_DATA`.
  - Rooms use `C_GAME_HALL_OP`/`U_C_GAME_HALL_TEAM_*`.
- **Graphics:** `icon/easter/<PreView[0]>.png` (`PathManager.as:267`); background frame = `PreView[1]` (1/2/3 per
  40-stage band); UI `raw/ui/zh_cn/xml/decoded/gamehall.xml`.

### 7.3 Christmas Party: `Christmas*`

- **Module:** m11/christmas + `ChristmasManager`/`ChristmasModel`. 8 tabs (`ChristmasItem.txt.text1..8`): Acender
  Pedido aos Deuses, Pacotes Especiais, Respostas Diárias, Virada da Sorte, Grande Prêmio de Natal, Mistério do
  Nevoado, Crítico de Gasto, Sucesso. Pending counter: `ChristmasModel.redCount` (`ChristmasModel.as:155-290`).
- **Light / Wish to the Gods (Acender Pedido aos Deuses):**
  - Lighting the tree requires `ChristmasActivities` MT1.Para1 (=1) × `christmas_light` 208611 and gives 212600921,
    the title card "Noite de Neve de Natal".
  - A wish costs `christmas_wish`=212600903 (Meia de Natal) ×1, 1 or 10 times (op 5). Pool:
    `ChristmasLotteryTemplates` MT2 (22 items, weights 2..100; e.g. 212600901 weight 2, 6260001×10 weight 100).
- **Special Packs (Pacotes Especiais, MT2):** SonType 1 free (Limit 1); 2 direct buy for Para2 diamonds (100/200/500,
  Limit 10/5/10); 3 requires a daily recharge of Para1 (500/4000) and costs Para2 (500/3000). Today's purchases are in
  `giftBuyInfo` "id,qty|...".
- **Daily Answers (Respostas Diárias):** 40 questions (`ChristmasAnswersTemplates`, options A/B; the server sends
  topicId, seconds left, A/B votes and my choice); 2 windows per day, 15 questions per round; prize by accumulated
  correct answers MT3 (4/8/12 → Meias + 21260570).
- **Virada da Sorte:** up to 4 spins, unlocked by accumulated recharge ≥ `christmas_rebate` 100/500/4000/20000
  diamonds. Spin N rolls the 10^(N-1) digit (MT1, Num 1..9000, weights 300..2000) → total diamonds = sum.
- **Grand Prize (Grande Prêmio de Natal):** costs `christmas_jackpot`=212600901 (Chapéu de Natal) ×1; 8 tiers MT3
  SonType 1..8 (Special Prize 300×Pedra de Avanço de Brasões weight 10 ... 7th prize weight 500), no repeats;
  `Score` 200..10 per tier *(assumption: Christmas Points)*.
- **Mistério do Nevoado:**
  - Teams of 2-4. Movement: `christmas_actionpower`=1000 initial, 100 per exploration, +100/30 min.
  - Nodes = `ChristmasActivities` MT4: SonType1 normal (10× -22005 Pontuação do Nevoado), 2 mini game (Para1 id →
    `StarareaManager.startMiniGame`), 3 monsters (requires an individual score of 20..80), 4 immediate event, 5 boss
    (requires 320 group points).
  - Ops 16-22 (`christmas_client_op`); `567 U_C_CHRISTMAS_SNOWY_MIST_DATA`.
- **Spending Crit (Crítico de Gasto, MT5):** accumulated spend Para1 = 1500/3000/10000/20000/35000. Normal claim
  (op 7 type 0) or crit paying Para2 = 150..3500 diamonds (type 1) → multiplier rolled from `ChristmasLottery` MT4:
  x2 35, x3 30, x4 20, x5 10, x6 5 (`view/ChristmasHirtView.as:146`).
- **Success (Sucesso):** 27 tasks in `ChristmasAchievementsTemplates` (9 types) give Christmas Points 5..400; MT6
  milestones at 30..4500 points (15 prizes; e.g. 4500 → 2183395 + 8407002).
- **Opcodes:**
  - `9217 C_CHRISTMS_OP` (`PlayerOpMsg op/id/type`, `ChristmasManager.as:208`).
  - `558 U_C_CHRISTMAS_DATA` (score, totalCharge, dayCharge, giftBuyInfo, luckCount/luckNum, jackpotRewardInfo,
    consumptionRewardList, totalConsume).
  - `559 U_C_CHRISTMAS_TASK_DATA`, `560 U_C_CHRISTMAS_ANSWER_DATA`, `567 U_C_CHRISTMAS_SNOWY_MIST_DATA`,
    `U_C_TOP_TOOL_BTN` (id 4030).
- **Graphics:** `raw/ui/zh_cn/xml/decoded/christmas.xml`. The "Pote Mágico" (`christmastree`/`ChristmasItems`) is a
  different event, not in this group.

### 7.4 Carnival (Folia): `Carnival*`

- **Module:** m11/carnvial (`CarnvialMainFrame`), `CarnivalManager`
  (`decompiled/core_module/scripts/yishi/manager/CarnivalManager.as:68`). Tabs `carnival.tab.names`: Pontos de Folia |
  Recarga Premiada | Virada da Sorte | Pacotes Especiais | Tesouro da Sorte | Missão Diária | Joguinho | Prêmio Online.
  Themed resources: `images/carnival/<CarnivalTabControl=101>/<name>.png` (`PathManager.as:948`).
- **Pontos de Folia:** earned from recharge (`CarnivalPayCount`=100,15 → 15 pts per 100 diamonds; old help text says
  5), Tesouro da Sorte (-20000) and quests (5 each). Milestones: `CarnivalPointExchangeTemplates` Type1, 25 steps
  100..10000 pts (e.g. 10000 → 2183343 + 15×208522 + 8407002).
- **Recarga Premiada** (`CarnivalLuckDraw` MT1): 1 spin per `CarnivalPayLuckyDraw`=100 diamonds; outer ring SonType1
  (14 items), inner ring SonType2 (8, includes 50..150 Moedas da Folia).
- **Virada da Sorte** (MT2): same as Christmas (thresholds `CarnivalRebate` 100,500,4000,20000; digits 1..9000
  diamonds).
- **Tesouro da Sorte** (MT3): costs `CarnivalLuckyDraw`=208600 ×1 (Moeda da Folia); always 2 prizes: an item
  (SonType1, e.g. 2183153 weight 1) + Pontos de Folia (SonType2: 1/2/4/6/10 with weights 50/30/15/3/2).
- **Special Packs (Pacotes Especiais, Type2):** 2001 free; 2002 200 diamonds; 2003 500 diamonds, requires a daily
  recharge of 500; 2004 1500 diamonds, requires 2500. Daily limits `carnival_buy_gift_limit` 2001:1, 2002:5, 2003:3,
  2004:2.
- **Online Prize (Prêmio Online, Type3):** 10/20/40/60/100/140 min online that day.
- **Daily Quest (Missão Diária):** 8 tasks (`CarnivalDailyChallengeTemplates`, TaskType 3,7..13), +5 pts each.
- **Minigame (Joguinho):** `CarnivalPlayGroundTemplates` Type 1 Match pairs (goal 500), 2 Memory (500), 3 Five cards
  (1000); 3 rewarded plays per day; these are the m3 AirGarden games (`AirGardenGameLlkFrame.as:140`).
- **Opcodes:** `9019 C_CARNIVAL_OP` (op 1 open, 2 claim milestone, 3 Recharge spin, 4 Virada, 5 buy pack, 6 Treasure,
  7 quest, 8 online, 9 minigame), `4304 U_C_CARNIVAL_DATA`, `4305 U_C_CARNIVAL_TASK_DATA`, `U_C_TOP_TOOL_BTN` id 4025.

### 7.5 7th Anniversary: `SevenYear*`

- **Module:** m11/sevenyear (`SevenYearMainFrame`; tabs Bandeira de Guerra, Supremacia Gloriosa, Space-time/StarArea,
  Shop, Achievements) + `decompiled/core_module/scripts/managers/SevenYearManager.as:72`.
- **Bandeira de Guerra:** level = Warrior Points / 1000 (`seven_year_grade_score`); buying the flag costs 1000 diamonds
  (`seven_year_buy_flag_point`); level packs 25/20000, 15/13500, 5/5000 diamonds; the daily game gives +200 pts.
- **Achievements** (`SevenYearAchievementTemplates`): 14 types × 3 grades; Score 100/350/550 (Aquarius/Treasure I-IV
  collections: 1000/5000/10000). Grade N requires grade N-1 completed. Claim: `sendOp(6,"",TemplateId)`; icon
  `icon/7year_achievement_<type>_<grade>.png`.
- **Knowledge Test** (`SevenYearQuestionTemplates`): 388 rows about skill icons.
  Type1 = "Este é o ícone de qual habilidade?" with text options; Type2 = "Qual é o ícone da habilidade X?" with icon options. The server sends
  `questionId` + `optionsArr` (ids from the same table); answer with `sendOp(7,"",id)`.
- **Opcodes:** `9692 C_SEVEN_YEAR_OP` (op 0 open, 1 buy flag, 2 send flag, 3 buy level, 4 claim level prize, 5 daily
  game, 6 achievement, 7 answer, 8 ...), `9695 C_TREASURE_BOX_OP`, `4986 U_C_SEVEN_YEAR_ACTIVE_INFO`, 4987
  `_USER_INFO`, 4988 `_ORDER_INFO`, 4989 `_QUESTION_INFO`, `200 U_C_SNOW_VEHICLE_SYNC_NUM`, `4898 U_C_TREASURE_BOX`.
  Related drops (`SevenYearRewardDrop` etc.) are in group E.

### 7.6 War Soul Tower (Torre da Guerra): `WarSoulTower*`

- **Rules** (help `warSoulTowerFrame.helperFrame.helpTxt.text`):
  - 1 challenge per day (`warsoultower_challenge_times`=1, reset at 0h); a challenge climbs floors in sequence.
  - A new floor gives the First Clear Prize; an already beaten floor gives the Repeat Prize; every 10 floors give a
    Stage Prize (`WarSoulTowerStageRewardTemplates`, 50 rows 10..500).
  - After the reset, the run starts 5 floors below the record. Leaving mid-run ends the day
    (`battleUIView.warsoulTower.content.txt`).
- **Floors** (`WarSoulTowerLevelTemplates`, 500): boss `Heroes` 8100000+N (pos 5) + soldiers `Pawns` (pos 1,3,7,9);
  `NeedArmourValue` 432 → 23544; `BossSkill` 84101001 = if armor is below the value, damage to the boss -90%.
  - Prizes: first clear 7620100 (10→255) + 7620401 (10→48); repeat 7620100 (5→104) + 7620401/7620301 alternating
    (1→20); stage 7620301 (10→110) + 7620100 (100→500).
- **UI:** 15-floor list (`beginLevel`, `WarSoulTowerModel.as:90`); the next 5 floors show the first-clear prize and
  the previous 5 show the repeat prize (`WarSoulTowerFrame.as:284-310`); the result lists Repeat/First/Stage per floor
  (`WarSoulTowerResultFrame.as:166`). Tasks use `highestLevel`
  (`decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:938`). UI layout: `warsoultower.xml`.
- **Opcodes:** `9709 C_WAR_SOUL_TOWER_CLIENT_OP` (`PropertyMsg.param1` 0=open, 1=fight), `530 U_C_WAR_SOUL_TOWER`
  (currentLevel, highestLevel, challengeTimes), `531 U_C_WAR_SOUL_TOWER_RESULT` (isNewRecord, startLevel, endLevel,
  rewards).

### 7.7 Theseus Collection rewards: `CollectionRewardTemplates`

- **Levels:** 75 (Id 1001..1075). `NeedNum` = total collection score (5, 10, 15 ... 300 at lv21 ... 2800 at lv75).
  Fixed prize `3505,1|20000000,50` (Diamond chest + 50 Metal Divino); up to 6 items per string.
- **Protocol and code:**
  - `594 U_C_COLLECTION_REWARD_DATA` → `CollectionRewardMsg` (boxCount, tasks[taskId,status]) in
    `decompiled/core_module/scripts/managers/TheseussoulManager.as:460`.
  - The list merges the server tasks with all levels (`:488-512`); the bar `curScore/NeedNum` is in
    `decompiled/m5/scripts/theseusCollention/pro/TheseusCollProView.as:176`.
  - Send via `9740 C_COLLECTION_CLIENT` (`TheseussoulManager.as:961`).
  - The collection itself (`584 U_C_COLLECTION_DATA`) belongs to another group.

### 7.8 Tiered special rewards: `SpecialRewardTmpls`

One template set serves 5 uses (enum `special_reward_type`; misnamed getter `theseusPvpRewardCate`,
`TempleteManager.as:1402`):

- **1 Theseus Arena Glory:** 15 steps by accumulated Glory (7640002) 100..2550; a free track (Pedra de Fort. Tesouro
  Externo/Ferro...) + **Advanced Reward** (PayReward, paid unlock `theseuspvp.gloryAdvanceAlert`). Claim with
  `TheseusPvpManager.doSomething(10,Gear)`; "claim all" is op 11
  (`decompiled/m3/scripts/theseuspvp/TheseusGloryRewardFrame.as:189`).
- **5 Duo Glory:** Emblema da Glória 7650004, 100..1500.
- **2 Anniversary Check-in:** 14 days; free track = keys -1801; paid advanced track `year_checkin_buy`=800 (making up
  a missed day costs 100 diamonds, op 4).
- **3 Treasure Hunt:** 15 floors, 1 Key per opening; fixed PayReward (7300001×floor) + 1 random RandReward item
  (quantity grows 5 per floor).
- **4 Gashapon:** milestones at 1/5/10/15 spins (War Soul fragment chests).

### 7.9 Anniversary Celebration / YearEgg (code)

- **Module:** m3/year2023 + `decompiled/core_module/scripts/managers/YearActiveManager.as`. Sub-events
  `yearactivity.type1..6`: Check-in, Random mini game, Treasure Hunt, Exploration (Labirinto Negro), Commemorative
  Collection, Lucky Gashapon.
- **Gashapon:** costs `year_gacha_extract`=20 Anniversary Coins per spin (1 or 10, op 10); recharge gives
  `year_gacha_buy`=100; pool `YearEggDrop` (`YearActiveDropCate`, group E), shown in `YearactiveEggDropFrame.as:62`.
- **Opcodes:** `9728 C_YEAR_ACTIVITY_CLIENT_OP`: 2 claim check-in, 3 check-in, 4 make up, 5/6 misc, 7 chest (pos),
  8/9 treasure hunt, 10 gashapon. Data: `551 U_C_YEAR_ACTIVITY_DATA` (checkinInfo, boxLevel, eggCount, curDay...).

### 7.10 Wanted Guardians (Guardiões Procurados, Guard PVE) and Abyss (Abismo, Guard Endless): `GuardPVETemp`

- **`GuardPVETemp`** has no flat fields (0 fields in the list); `getXmlFromRoot` reads it as nested XML
  (`TempleteManager.as:1210-1211`):
  - `GuardPVEBossTempInfos/GuardPVEBossInfo` (699): id, grade (1..100), bossName, icon, soldier1..3/hero1..3 ("id,pos"
    formations per wave), minLimit/maxLimit (level range), random, dropItems "item,qty", activeSkill (skill unlocked on
    a win; `getChildPveSkillUnlockGrade`), addDropItems → `ChildPveBossTemplateCate`.
  - `GuardPveExploreRewardInfos` (120): isSpirit (0/1), grade, itemId, count, ValidDate → Guardian patrol prizes
    (`GuardPveExploreTemplateCate.getDropList(isSpirit, growthGrade)`, used in
    `decompiled/m14/scripts/childpatrol/ChildPatrolExploreView.as:152`).
- **Rules** (`childpve.helpContent`): lv ≥70; up to 4 Guardians in formation; 1 clear per day; daily progress ranking
  (updates at 0h); wins unlock skills.
- **Opcodes:** `9548 C_GUARDPVE_REQ` (info, formation, fight: `ChildPveController.as:192-240`); reply
  `4979 U_C_GUARDPVE_OPRSP` (`AcceptProtocolType.as:1302`; opType 1 boss list, 2 update; wantedOrder, maxBossId,
  skills, guardPos); `8726 C_PET_CHALLENGE_SKILL` for skills. UI `childpve.xml`.
- **Abismo (Guard Endless):** `OutyardManager` (`decompiled/core_module/scripts/yishi/manager/OutyardManager.as:96-98`)
  + `AbysmModel` (layers, bossList, mopup, Horrible mode); `9644 C_GUARDENDLESS_OP`, `423 U_C_GUARDENDLESS_INFO`,
  `427 U_C_GUARD_ONFIGHT`, `428 U_C_GUARD_REWARD` (type 2 = sweep); drops `GuardEndlessDrop`/`GuardEndlessHorribleDrop`
  (`TempleteManager.as:1318`).

### 7.11 Einherjar League weekly prize: `PetChallengeRewards`

- **Ranking field:** `Ranking` = "group|rank" or "group|min,max". Groups: 2 Diamond, 3 White Gold, 4 Gold, 5 Silver,
  6 Bronze (1 Kingdom = top1).
- **Group by score:** ≥4000→2, ≥3500→3, ≥2400→4, ≥1600→5, else 6 (`Pet_Challenge_Default_Score_Line`,
  `PetChallengeModel.as:210`).
- **Bands:** G2 1/2-200/201+, G3 1/2-100/101+, G4 1/2-50/51+, G5-6 1/2-10/11+.
- **Items:** 208065 Fragmentos da Alma da Fusão (350→150), 2060488 (40→8), 3040001 (750→280), 3040002 (350→150). For
  the G2 top3 the client injects "Todos os atributos +50/40/30" (RewardType 2) and titles 47/48/49 (RewardType 3)
  (`PetChallengeRewardCate.as:25`).
- **Limits:** lv 50 (`Pet_Challenge_Grade`), 10 challenges per day.
- **Opcodes:** `8256 C_CHALLENGEINFO_REQUEST`, `8724 C_CHALLENGE_PET`, `8725 C_PET_CHALLENGE_FORMATION`,
  `8726 C_PET_CHALLENGE_SKILL`, `8728 C_PET_RANK_REWARD`, `8265 C_QUICKCOOL_CHALLENGE_TIME`, `4176 U_C_CHALLENGE_TIME`,
  `4611 U_C_PET_CHALLENGE_LIST`.

### 7.12 Quick Pass (Passagem Rápida): `QuickPassRewards`

- **Rules:** co-op campaign (colored keys, hammers and holes that only the partner sees); only the leader creates the
  team; team ≥2 (`RapidThroughPassManager.as:62-80`); `quickpass_max_count`=1 entry per day.
- **Time ranking:** 1st 5 Luxury Chests + 10 Normal + 20 Old; 2nd 4/8/16; 3rd 3/6/12; 4th-10th 2/4/10; 11th-50th 1/3/5.
- **Opcodes:** `9633 C_QUICKPASS_OP`, `405 U_C_QUICKPASSINFO`, `406 U_C_QUICKPASSRank`. UI m9/rapidthrouh.

### 7.13 Sky Trial (Caminho do Céu): `SkyOrderRewards`, `SkyRewards`

- **Portals:** `SkyTrialPortalTempInfos` (101 Reino do Fogo..., `EnergyCost` 20, `TotalSearchCount` 10). Max moves
  500; buy 25 diamonds→100 pts, up to 3× per day. Search points (max 1000) buy skills (100) or a helper (200, inherits
  75% of attributes) (configs `skytrial_*`).
- **Ranking** (`SkyOrderRewards`): bands 1,2,3,4-10,11-50,51-100 → 65/40/15/12/8/5 of each of the 6 Brasões Mágicos
  6261011..6261061.
- **Station points** (`SkyRewards`): per portal (`CampaignId`=PortalId, 90 portals) and station `Param2` 1..3 (periods
  `SkyTrial_Timer` 60/180/300 min). The reward is rolled among 6 emblems (4..14 units); after 5 h the prize goes by
  mail. Occupy: `sendPointOccupyRequest(11,portal,pos)` (`SkyBoxRoadStayPointItem.as:202`).
- **Opcodes:** `8636 C_SKY_TRIAL`, `4552 U_C_RES_SINGLEPASS_INFO`, `4551 U_C_UPDATE_AREA`, `460 U_C_SKY_RANK`,
  `459 U_C_SKY_POINT_REQ`, 4996 (portal clear prize).

### 7.14 Time Vortex (Vórtice do Tempo): `TimeVortexRewards`

- **Positions:** campaigns with `Types=26` (`TempleteManager.as:2592`; e.g. 50001 "Ninho dos Lobos" ... 50061
  "Santuário Eterno"). Each position has a boss and a **leader** (occupant) with a countdown; paid revenge (reduces
  20 min).
- **Time rift:** every hour at :05 on a position with a leader; challengeable as a team; 2 prizes per day per win
  (`time_crack_get_count`). The leader earns from defenses (`time_crack_defens_count`=10). Dragon Talker
  (`U_C_DRAGONTALKER_NODE`).
- **Sweep:** `TimeVortex_Sweep_Time`=60 (unit not stated), `TimeVortex_Sweep_Gold`=500000 gold.
- **Rewards by `RewardType`** (enum `time_vortex_reward_type`):
  - 1 boss: 3 Talisman Chests (green→orange by position).
  - 2 boss: Talismã de Experiência 8407001 (10→40).
  - 3/4 leader (1 and 5 chests).
  - 5 rift win per chapter 101..107 (Pedra Simbiótica 208066 ×1-2 + chest).
  - 6 rift defense (8407001 ×5).
- **Opcodes:** `9664 C_TIMEVORTEX_CLIENT_OP`, `4837 U_C_TIMEVORTEX_INFO`, 4838 `_BATCH_INFO`, 4839 `_CRACK_INFO`,
  4840 `_CRACK_TEAM_INFO`, 4841 `_CRACK_TEAM_READY`. UI `timevortex.xml`.

### 7.15 Unreal Hunt (Caça Fantástica) weekly prize: `UnrealWeekRewards`

- **Rules:** real-time 4v4 arena, 2 windows per day (16:00-16:15, 21:00-21:15), 1 entry per day, min 8 players;
  fantasy crystals are traded for buffs (`unreal_buffer`).
- **Weekly ranking prize** (`4835 U_C_UNREAL_WEEK_ORDER`): `Order` = 0-based lower bound → 1st 70×6260002+140×6260003,
  2nd 60/120, 3rd 55/110, 4th-10th 50/100, 11th-50th 40/80, 51st-100th 30/60, 101st+ 25/50 (requires 3000 pts).
- **Opcodes:** `9662 C_UNREAL_SHOOTING_OP`, `4828 U_C_UNREAL_SHOOTING_INFO`, `4836 U_C_UNREAL_ACTIVE_STATE`,
  `CR_UNREAL_ATTACK`/`CR_UNREAL_PICK`.

### 7.16 Astronomy / Stargazing (code)

- **Unlock:** when Archaeology reaches max level (`ArchaeologyMakeRightView.stargazingBtn.tipdata`).
- **Module:** m14/stargazing (StarChartView, StarForceView, StarPalaceView, StarWishView) +
  `decompiled/core_module/scripts/yishi/manager/StarGazingManager.as:49`. 12 zodiac palaces (Aries..Pisces), celestial
  cards with physical/magic Attack/Defense/HP bonuses, Star Force, starry-sky fragments.
- **Ops** (`StargazingOp`): 0 OPEN, 1 UPDATE, 2 PRAY, 3 NOMAL_REWARD, 4 SENIOR_REWARD, 5 UPGRADE_STAR, 6 USE_MAP_ITEM;
  `5188 C_STARGAZING_OP` / `4687 U_C_STARGAZING_OP`.
- **Wish pool** `StargazingDrop` (group E): `site` 1 ask, 2 normal wish, 3 advanced wish; `para2` = weekday (0..6,
  `sysCurtime.day`) (`StarWishView.as:162`). Images: `icon/stargazing/<palace>/<n>.jpg` (`PathManager.as:835`).

## 8. Drops and reward packs

Drop and reward packs are item lists that the server rolls and delivers. The client reads them only to display reward previews.

### 8.1 Drops and reward packs: common schema (`CommonDropTempInfo`)

~63 `*Drop`/`*Reward`/`*DropInfo` template sets define *item packs*: the server rolls and delivers them, and the client uses them only to **display** reward previews. 45 of them share the 10-field schema of `CommonDropTempInfo` (`decompiled/core_module/scripts/yishi/datas/templates/CommonDropTempInfo.as:3`). `TempleteManager` loads each set with `getXmlListByName("<Set>")` into its own *Cate* class (see the Cate column in §8.4). The Cate classes differ only in **how they filter** rows by `site`/`para2`.

| Field | Type | Meaning |
|---|---|---|
| `id` | int | Row id |
| `dropId` | int | Pack id (several rows = 1 pack). Referenced by the activity template (e.g. `EvilLandTemplates`, `MonsterExploreTemplates`, `ConsortiaPveTemplates`) |
| `site` | int | Filter 1: rank/wave/level/type/day/boss id, depending on the set |
| `para2` | string | Filter 2: often a `"min,max"` range (ranking, score, damage) or an index |
| `itemId` | int | `ItemTempInfos.TemplateId`; **negative = virtual currency** (enum `virtual_currency_item`) |
| `count` | int | Quantity |
| `isBind` | 0/1 | Bound |
| `appearType` | int | 1 fixed, 2 possible, 3 rare, 4 random (enum `drop_appear_type`) |
| `validDate` | int | Validity (0 = permanent) |
| `isShow` | 0/1 | Highlight; with `appearType=3`: 0 rare / 1 very rare |

### 8.2 Legacy schemas and empty sets

Older sets use their own field lists:

- `DropId,ItemId,Count,IsBind,ValidDate`: `EvilLandDrop`, `ConsortiaPveDrop`, `MonsterExploreDrop` (lookup by `DropId`).
- `District,ItemId,Count,ValidDate`: `DistrictDrop`/`DistrictSSSDrop` (per chapter).
- `DropId,Times,TemplateId,Data,ValidDate`: `SignDrop`.
- `DropId,Grade,TemplateId,Data,Job,ValidDate`: `TimeDrop`.
- `site,isWeek,itemId,count`: `LeedDrop`.
- `level,itemId,count`: `TitanlandDrop`.
- `site,itemId,count`: `VipDrop`.
- `mapId,campaignDataId,itemTempId,count`: `AreaMapDropInfos`.
- `Id,BoxTempId,ItemTempId,Count,AppearType,ValidDate`: `UpgradePresentBoxDrop`.

Empty sets on this server: `GradeDrop`, `ReloginDrops`, `PrivilegeDrops`, `ServenLeadRewards`, `TollgateReward`, `BoxItems`.

### 8.3 Virtual currencies (`itemId` < 0)

A negative `itemId` stands for a virtual currency. The client checks the balance in `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:168-226`. The full list is enum `virtual_currency_item` (77 values); the main ones:

| `itemId` | Currency | Balance field |
|---:|---|---|
| -100 | Ouro | `ResourceManager.gold` |
| -200 | Ametistas | `playerInfo.mineral` |
| -300 | Espírito | `strategy` |
| -400 | Diamante | `point` |
| -500 | Diamante Vinculado | `giftToken` |
| -600 | Cristal de Luz | `waterCrystal` |
| -700 | Experiência | |
| -800 | Cristal da Glória | `gloryPoint` |
| -1000 | Emblema do Rei | |
| -3900 | Pontos da Glória | |
| -4000 | Moeda do Jogo | |
| -4300 | Chaves do Julgamento | |
| -5500 | Mérito | |
| -17000 | Alma do labirinto | |
| -18000 | Pontos de Chefão | |
| -19000 | Gema Poseidon | |
| -21000 | Pontos Minos | |
| -23000 | Pontos Táticos | |

### 8.4 Drop and reward sets by activity

The Cate column gives the class and its line in `TempleteManager.as`. A `-` means the set has no `site`/`para2` filter (legacy schema).

| Set | Rows | Activity | `site` | `para2` | Cate (`TempleteManager.as`) | Example |
|---|---:|---|---|---|---|---|
| `GradeDrop` | 0 | Newbie box by level (`NoviceboxTemplateCate`; empty on this server) | - | - | `NoviceboxTemplateCate:1160` |  |
| `SignDrop` | 19 | Cumulative daily check-in rewards (`Times` = days signed) | - | - | `SignDropTemplateCate:1166` | Bolsa de Ouro x1 |
| `ReloginDrops` | 0 | Cumulative login (`CountLoginDropTemplateCate`, key `Times`; empty) | - | - | `CountLoginDropTemplateCate:1175` |  |
| `TimeDrop` | 53 | Online-time chest (TimeBox in the main bar; `Grade` = period index, `BoxManager.getCurrentTimePeriod`) | - | - | `TimeBoxTemplateCate:1161` | Cristal de Luz x5000 |
| `DistrictDrop` | 28 | Campaign chapter/area completion reward (`District` = `chapterId`) | - | - | `DistrictTemplateCate:1162` | Diamante Vinculado x20 |
| `LeedDrop` | 33 | Old Guide/Daily Activity rewards (`site` = chest index; `isWeek` 0/1 = daily/weekly) | activity chest index | - | `LeedDropTemplateCate:1164` | Fonte da Vida x10 |
| `TitanlandDrop` | 10 | Titan Land (backyard/outyard): reward per level | - | - | `OutyardTitanTemplateCate:1232` | Pedra do Poder do Espírito x15 |
| `VipDrop` | 50 | VIP gift pack (`site` = VIP level) | VIP level | - | `VipDropTemplateCate:1157` | Bolsa de Ouro x2 |
| `PrivilegeDrops` | 0 | 360/Bag360 privilege pack (key `Order`; empty) | - | - | `Bag360DropTemplateCate:1176` |  |
| `ServenLeadRewards` | 0 | 7-day journey rewards (key `Day`; empty) | - | - | `ServenLeadRewardTemplateCate:1188` |  |
| `TollgateReward` | 0 | Stage challenge reward by score (`NeedScore`; empty) | - | - | `TollgateRewardCate:1206` |  |
| `BoxItems` | 0 | Generic box contents (key `Param2`; empty) | - | - | `BoxItemTemplateCate:1198` |  |
| `DistrictSSSDrop` | 24 | Chapter reward for an SSS rating (all stages at 3 stars) | - | - | `DistrictSSSTemplateCate:1163` | Diamante Vinculado x200 |
| `GloryRoadDrop` | 6 | Caminho da Glória: per-floor rewards | floor/stage (1,3,5..13) | unused (0) | `GloryRoadDropTemplateCate:1241` | Pontos da Glória x20 |
| `GuardPvpDrop` | 40 | Guardians (children) arena / Guard PvP (`ChildArenaRewardTempCate`): reward by type and ranking position | type (1=daily, 2=season) *(assumption)* | ranking position/band | `ChildArenaRewardTempCate:1250` | Essência de Zeus x10 |
| `AreaMapDropInfos` | 36 | Drop preview per campaign map (`mapId`/`campaignDataId`) | - | - | `AreaMapDropTemplateCate:1239` | Cristal da Memória x2 |
| `StargazingDrop` | 116 | Stargazing: rewards by type and day | observation type (1..3) | day (0..6) | `StarGazingDropTempCate:1259` | Fragmento de Céu Estrelado x5 |
| `CrisisDrop` | 72 | Crise dos Planos (`PlaneCrisisGoodTempCate`): rewards by level and score band | crisis level/difficulty | score band 'min,max' | `PlaneCrisisGoodTempCate:1262` | Material de tatuagem x60 |
| `EclipticPalaceDrop` | 91 | Palácio Zodiacal: rewards by type (1=per-floor display) and floor | type (1=floor reward, 2/3=other) *(assumption)* | floor/stage | `EclipticPalaceRewardCate:1265` | Pedra de Gravação de Brasões Mágicos x5 |
| `UpgradePresentBoxDrop` | 31 | Evolution gift box (`UpgradePresentBox`): contents by `BoxTempId` | - | - | `UpgradePresentBoxDropTempCate:1266` | Pedra de Purificação nv. 3 (Descarte) x350 |
| `EvilLandDrop` | 1200 | Continente dos Demônios (EvilLand/DemonLand): fight drops by `DropId` (`EvilLandTemplates`) | - | - | `DemonLandDropTemplateCate:1268` | Fragmento da Deusa da Magia x3 |
| `EvilLandBoxDrop` | 25 | Continente dos Demônios: chests by accumulated stars (`site` = stars) | required stars | unused | `DemonLandBoxDropTemplateCate:1269` | Larimar x100 |
| `ConsortiaPveDrop` | 406 | Guild PvE (GuildFB): drops by `DropId` (`ConsortiaPveTemplates`) | - | - | `GuildFBDropTempCate:1278` | Prata de Moréia x250 |
| `ConsortiaPveRankDrop` | 16 | Guild PvE: reward by ranking band | unused (0) | ranking band 'min,max' | `GuildFBPveRankDropTempCate:1279` | Prata de Moréia x10000 |
| `ApexRewardDrop` | 60 | Apex (m9): reward by grade/round and ranking (`isGradeData` when `site` has 1 digit) | group/round (`site.length<2` = grade) | ranking band 'min,max' | `ApexRewardDropTempCate:1285` | Coração de Gelo x200 |
| `ApexRewardSingleDrop` | 2 | Apex: individual reward per fight | type | result (1=win, 2=loss) *(assumption)* | None:None | Coração de Gelo x10 |
| `ConsortiaWarSeasonDrop` | 7 | Guild war (CrossGuild): season reward by ranking | unused | ranking band 'min,max' | `CrossGuildRewardTempCate:1286` | Pedra da Coragem x2500 |
| `ConsortiaWarFightDrop` | 12 | Guild war: per-fight reward (`site` = result) | result (0/1/2: loss/win/draw) *(assumption)* | unused | `CrossGuildSingleRewardTempCate:1287` | Pedra da Coragem x225 |
| `ConsortiaWarUserDrop` | 9 | Guild war: individual contribution reward | unused | contribution band 'min,max' | `CrossGuildContributionRewardTempCate:1288` | Emblema da Guilda x75 |
| `MonsterCookDrop` | 9 | Monster kitchen: drops by dish type | type (1..3) | unused | `MonsterCookDropTempCate:1292` | Espeto de carne x1 |
| `MonsterExploreDrop` | 1015 | Monster Explore: drops by `DropId` (`MonsterExploreTemplates`) | - | - | `MonsterExploreDropTempCate:1294` | Gema do dragão x15 |
| `DreamArenaDrop` | 39 | Dream Arena (m13): reward by win count (`site`) and ranking (`para2`) | win count | ranking band | `DreamArenaRewardTempCate:1295` | Pedra do Poder do Espírito x100 |
| `EasterLotteryDrop` | 260 | Easter: draw (`GamehallEastShopTempCate`) | unused | prize index/group | `GamehallEastShopTempCate:1299` | Cristal do Guardião x14 |
| `RevengeRoadBoxDrop` | 8 | Caminho da Vingança: area chests | chest index | area | `RevengeRoadAreaBoxTempCate:1306` | Cristal da Vingança x50 |
| `RevengeRoadDrop` | 200 | Caminho da Vingança: fight drops by `DropId` | unused | unused | `RevengeRoadDropTempCate:1307` | Cristal da Vingança x5 |
| `ConsortiaWantDrop` | 19 | Guild Wanted (GuildWanted): reward by type and index | type (1..3) | index/star | `GuildWantedDropTempCate:1317` | Pedra Bestial x10 |
| `SevenYearRewardDrop` | 503 | 7-year event: rewards by grade (`site`) | pass grade/level | flag (0/1/3) | `SevenYearRewardDropCate:1314` | 0 x0 |
| `StarAreaDrop` | 11 | Star Area (StarAreaRoad): drops by type and node | type | node | `StarAreaDropCate:1311` | Pontos de guerreiro x200 |
| `TreasureBoxDrop` | 190 | 7-year/Year event: treasure chest (`site` = chest `ItemId`) | chest `ItemId` | unused | `SevenYearTreasureBoxDropCate:1315` | Poder de Severn x1 |
| `GloryRewardDrop` | 6 | Glory Games: reward by index | reward index | unused | `GloryRewardDropCate:1316` | Pontos de guerreiro x10000 |
| `GuardEndlessDrop` | 896 | Endless Abyss (Guard Endless/Abysm), normal mode: drop per wave (`site` = wave) | wave | unused | `AbysmDropTempCate:1318` | Roleta da Vida do Espírito de Proteção x1 |
| `GuardEndlessHorribleDrop` | 630 | Endless Abyss, Hell mode: drop per wave | wave | unused | `AbysmHellDropTempCate:1319` | Bola de Luz Elemental x1 |
| `RushCampaignDrop` | 13 | Race against time (RaceAgainstTime): reward by type and index | type (1..2) | index/position | `RaceAgainstTimeDropTempCate:1322` | Pedra de polir x1 |
| `ExpeditionFightDrop` | 60 | Spirit Expedition: fight drops by area and node | area | node | `SpiritExpeditionFightDropTempCate:1324` | Lâmina de Pedra x30 |
| `ExpeditionStarDrop` | 8 | Spirit Expedition: chests by accumulated stars (`site` = stars) | stars | unused | `SpiritExpeditionStarDropTempCate:1325` | Livro de Habilidades Passivas da Lâmina do Espírito de Proteção x25 |
| `SevenYearFreeRewardDrop` | 513 | 7-year event: free pass track by grade | grade | flag | `SevenYearFreeRewardDropCate:1304` | 0 x0 |
| `ShadowLandFightDrop` | 208 | Terra Sombria: drops by difficulty (`site`) and 'area,node' (`para2`) | difficulty | 'area,node' | `ShadowLandFightDropTempCate:1329` | Baú de Estela 1 estrela x1 |
| `ShadowLandBoxDrop` | 10 | Terra Sombria: chests by difficulty and area | difficulty | area | `ShadowLandBoxDropTempCate:1330` | Baú de Estela 2 estrelas x5 |
| `RemainsExploreDrop` | 336 | Exploração das Ruínas: node drops by `DropId` | unused | unused | `RemainsExploreDropTempCate:1343` | Baú de Estela 1 estrela x3 |
| `RemainsExploreBox` | 18 | Exploração das Ruínas: activity chests by type and index | type (1..2) | index | `RemainsExploreActivityDropTempCate:1345` | Pedra de Purificação da Estela x20 |
| `SkyStepDrop` | 7 | Sky Steps: drop by id (`site` = step/event id) | step id | unused | `SkyStepDropTempCate:1346` | Item de troca da Estela da Faca curva imperial x3 |
| `ConsortiaNewBossReward` | 2010 | New guild boss: reward by boss type (`site`) and ranking (`para2`) | boss id/type | position | `ConsortiaNewBossRankRewardTempCate:1348` | Pontos de Chefão x500 |
| `ConsortiaNewBossDamageReward` | 5000 | New guild boss: reward by damage band 'min,max' | boss id/type | damage band 'min,max' | `ConsortiaNewBossDamageRewardTempCate:1349` | Pontos de Chefão x51 |
| `AchievementTaskBuyDrop` | 360 | Achievement tasks: buyable pack per task (`site` = task id) | `AchievementTaskTemplates` id | price/value | `AchievementTaskBuyDropTemplateCate:1351` | Gema de Vida Nv. 8 x1 |
| `FirstPayDrop` | 1 | First recharge (new): drops by day and option | day/step | option 'a,b' | `NewFirstPayDropCate:1353` | Pedra da Qualificação Divina x150 |
| `QuestionDrop` | 5 | Questionnaire/Questions: reward | unused | unused | `QuestionDropTempCate:1354` | Martelo de Luz x10 |
| `ForbiddenBossBelongDrop` | 730 | Forbidden Boss: last-hit/owner reward (`site` = boss id) | boss id | unused | `ForbiddenBossBelongDropCate:1360` | Gema Poseidon x150 |
| `ForbiddenBossJoinDrop` | 730 | Forbidden Boss: participation reward | boss id | unused | `ForbiddenBossJoinDropCate:1361` | Gema Poseidon x150 |
| `ActivityDailyDrop` | 40 | Daily activity (activity points): chests by points (`site`) and level band (`para2`) | required activity points | level band/group (1..4) | `NewActiveLeedDailyCate:1385` | Força da Coragem x1 |
| `ActivityWeekDrop` | 48 | Weekly activity: chests by weekly points | required weekly points | level band/group (1..4) | `NewActiveLeedWeekCate:1386` | Fonte da Vida x3 |
| `YearEggDrop` | 19 | New Year/Anniversary event: egg (`YearActiveDropCate`) | unused | unused | `YearActiveDropCate:1411` | Larimar x10 |
| `CollectionGetDrop` | 9 | Collection: reward by collection % (`site`) | collection points/percentage | unused | `CollectionGetDrop:1194` | Baú de Prata x1 |
| `CollectionOpenDrop` | 154 | Collection: contents of opened packs | unused | unused | `CollectionOpenDrop:1195` | 350101 x1 |

### 8.5 Client consumers

Example client-side consumers:

- `mainBar/TimeBoxView.as:74`: `TimeDrop`.
- `m15/scripts/vip/VipGiftFrame.as:96`: `VipDrop`.
- `m13/scripts/selectcampaign/view/AreaView.as:268`: `DistrictDrop`.
- `m3/scripts/map/campaign/view/ui/sumcampaign/SumCampaignListView.as:99`: `AreaMapDropInfos`.
- `mvc/module/dayGuide/DayGuideCatecory.as:594`: `LeedDrop`.
- `m11/scripts/shadowland/ShadowLandFightFrame.as:95-110`: splits fixed × drop.
- `m11/scripts/sevenyear/SevenYearTreasureBoxFrame.as:732`: rare/very rare.

The client resolves `min,max` bands with `para2.split(",")` (e.g. `ConsortiaNewBossDamageRewardTempCate.as:27`).

## 9. Systems summary

One row per system: name and system id, category, template sets and opcodes. Long opcode lists are truncated and can end mid-name (e.g. `U_`).

| System | Category | Template sets | Opcodes |
|---|---|---|---|
| Castle: buildings and levels (`castle_buildings`) | economy | BuildingTempInfos, BuildingResInfos | C_BUILDING_CREATE, C_BUILDING_UPGRADE, C_BUILDING_INIT, U_C_BUILDINGINFO_LIST, U_C_LOAD_BUILD, U_C_LOAD_CASTLE, C_ENTER_CASTLE |
| Build queue and activity queues (`build_queue`) | economy | ConfigInfos | C_LOAD_BUILD_ORDER, U_C_LOAD_BUILD_ORDER, U_C_BUILDING_ORDER_SEND, U_C_BUILDING_ORDER_QUICK, U_C_BUILDING_ORDERADD, U_C_BUILDING_ORDER_INFO |
| Santuário (Seminário) technologies (`castle_technology`) | progression | BuildingTempInfos, EffectTempInfos | C_BUILDING_CREATE, C_BUILDING_UPGRADE, U_C_BUILDINGINFO_LIST |
| Player resources (gold, crystal, population, diamonds) (`castle_resources`) | economy | BuildingTempInfos, ConfigInfos, FirstChargeItems | U_C_CASTLE_UPDATE |
| Tax collection (Prefeitura) (`gold_levy`) | economy | BuildingTempInfos, MagicSpringTempInfos | C_GOLD_IMPOSE, U_C_GOLD_IMPOSERESULT |
| Transmissor and castle relocation (`castle_transfer`) | economy | BuildingTempInfos, ConfigInfos | U_C_BUILDING_UPENERGY, U_C_BUIDLING_TRANS_COOL, U_C_BUILDING_TRANSCASTLE, U_C_TRASNBUILDING_RESULT, C_CANCEL_TRANS |
| Wild lands / outer-map objects (`wild_land`) | pve | MapPhysicsTempInfos | U_C_SECURITY_INFO_UPDATE, U_C_UNOCCPWILDLAND, U_C_CASTLE_DEFENSE |
| Progression curves (`UpGradeTempInfos`) (`upgrade_curves`) | progression | UpGradeTempInfos |  |
| Global settings (`ConfigInfos`) (`config_infos`) | economy | ConfigInfos |  |
| Soldier special skill (`pawn_special_ability`) | progression | SpecialTempInfos |  |
| Top event bar (`top_toolbar`) | event | TopToolBtnInfos |  |
| Social sharing (`social_share`) | social | ShareTemplateInfos | U_C_SHARE, C_SHARE_TAKEREWARD |
| Returning-player privileges (regress) (`regress`) | event | RegressTemplateInfos | U_C_REGRESS_INFO, C_REGRESS_TAKE |
| Regresso do Rei (player return) (`older_reflux`) | event | OlderRefluxTempInfos, ConfigInfos | U_OLDER_REFLUX, C_OLDER_REFLUX_OP |
| Pequeno Secretário (`secretary`) | progression | AssistantTemplates | U_C_ASSISTANT_ITEMS |
| First recharge pack (`first_pay`) | economy | FirstPayTemplates, FirstChargeItems, ConfigInfos | U_C_FIRST_PAY_DATA, C_FIRST_PAY_CLIENT_OP |
| Questionnaire (`questionnaire`) | event | QuestionTemplates | U_C_QUESTION_DATA, C_QUESTION_CLIENT_OP |
| Guide reference values (server-side) (`guide_values`) | progression | GuideValueTemps |  |
| Fishing (Game Box) (`fishing_minigame`) | event | FishTemplateInfos, ConfigInfos | C_FISH_POOL, U_C_FISH_POOL, U_C_FISH_CHECK, U_C_FISH_INFOS, U_C_FISH_HELPOVER, U_C_FISH_CRAZY |
| Marriage (`marriage`) | social | MarrySpecTempInfos, HeartTempInfos, ConfigInfos | C_marriage_REQUEST, C_MARRIAGE_CAMPAIGN_REQUEST, C_MARRIAGE_TREE_REQUEST, C_MARRIAGE_TASK_REQUEST, C_MARRIAGE_HEART, CH_MARRIAGE_BUY_SPEC, U_C_MARRIAGE_INFO, U_ |
| Residence and furniture (`home_furniture`) | social | FurnitureTempInfos, ArchaeologyBookTemps | C_HOME_OP, U_C_HOME_INFO, U_C_SELECT_HOME, C_FURNITURE_SHOP_BUY |
| Archaeology (`archaeology`) | progression | ArchaeologyItemTemps, ArchaeologyBookTemps, UpGradeTempInfos, ConfigInfos | C_ARCHAEOLOGY_REQ, U_C_ARCHAEOLOGY_DATA, U_C_ARCHAEOLOGY_NODELIST, U_C_ARCHAEOLOGY_GOODLIST |
| Alchemy Workshop (`alchemy_workshop`) | progression | AlchemyMineTemplates, AlchemyFormulaTemplates, UpGradeTempInfos, ConfigInfos | C_ALCHEMY_WORKSHOP_OP, U_C_ALCHEMY_WORKSHOP_OP |
| Fonte Mágica (`magic_spring`) | economy | MagicSpringTempInfos, ConfigInfos | C_MAGIC_SPRING_OP, U_C_MAGIC_SPRING_INFO |
| Portal do Tempo (Terralém) (`shuttle`) | pve | ShuttleTempInfos, ShuttleRewardTempInfos, ConfigInfos | C_SHUTTLE_REQUEST, U_C_SHUTTLE |
| Bar da Fantasia (`magic_pub`) | social | MagicPubNpcInfos, MagicPubChatInfos, UpGradeTempInfos, ConfigInfos | C_MAGIC_PUB_OP, U_C_MAGIC_PUB |
| World maps and Reino do Céu (`world_and_space_maps`) | progression | MapInfos, MapNodeInfos | C_PLAYER_SPACE_ENTER, C_PLAYER_SPACE_LEAVE, C_PLAYER_SPACE_MOVE, C_PLAYER_SPACE_NODE_TRIGGER, C_GET_SPACE_PLAYER_ARMY_INFO, C_SPACE_COLLECTION_FINISHED, C_SPACE |
| PvE campaigns and instances (`pve_campaigns`) | pve | Campaigns, MapInfos, CampaignData | U_C_CAMPAIGN_ROOM_CREATE, U_C_CAMPAIGN_ROOM_ENTER, U_C_CAMPAIGN_ROOM_EXIT, U_C_CAMPAIGN_ROOM_LIST, U_C_CAMPAIGN_ENTER, U_C_CAMPAIGN_EXIT, U_C_CAMPAIGN_ARMY, U_C |
| Solo campaign (4-node trail) (`single_campaign_new`) | pve | SingleCampaignDatas, Campaigns | C_NEW_SINGLE_CAMPAIGN_FIGHT, U_C_NEW_SINGLE_CAMPAIGN |
| Campaign/map buffs (`campaign_buffers`) | pve | CampaignBufferTemps |  |
| Campaign energy (Vigor) (`weary_energy`) | progression | Campaigns | U_C_LEFT_WEARY |
| Caminho do Céu (Sky Trial) (`sky_trial`) | pve | SkyTrialLayerTempInfos, SkyTrialPortalTempInfos, SkyTrialEventTempInfos | C_SKY_TRIAL, U_C_RES_SINGLEPASS_INFO, U_C_SKY_RANK, U_C_SKY_POINT_REQ |
| Labirinto Negro (`dark_maze`) | event | DarkMazeLayerTemplates, DarkMazeEventTemplates, DarkMazeChildTemplates | C_DARK_MAZE_OP, U_C_DARK_MAZE_DATA, U_C_TOP_TOOL_BTN |
| Caminho Final (`final_road`) | pve | FinalRoadChapterTemplates, FinalRoadGroupTemplates, FinalRoadLevelTemplates, FinalRoadEventTemplates | C_FINAL_ROAD_CLIENT_OP, U_C_FINAL_ROAD_CHAPTER, U_C_FINAL_ROAD_GROUP, C_CAMPAIGN_SWEEP |
| Guerra dos Planos (`planes_war`) | pvp | PlanesTemplates, PlanesLayers, PlanesEvents, PlanesFuncTempInfos | C_PLANES_WAR_REQ, U_C_PLANES_WAR_LIST_MSG, U_C_PLANES_WAR_RSP_MSG, U_C_PLANES_WAR_MAP, U_C_PLANES_WAR_ENERGY |
| Crise dos Planos (`plane_crisis`) | pve | CrisisMapInfos, CrisisEventInfos | C_CRISIS_GAME_OP, U_C_CRISIS_PREPARE, U_C_CRISIS_GAME_START, U_C_CRISIS_GAME_INFO, U_C_CRISIS_GAME_QUIT, U_C_CRISIS_ATTACK_BOSS, U_C_CRISIS_MOVE, U_C_CRISIS_GAM |
| Labirinto de Minos (guild) (`minos_labyrinth`) | guild | MinosLevelTmpls, MinosNodeTmpls, MinosRewardTmpls | C_MINOS_CLIENT_OP, U_C_MINOS_DATA, U_C_MINOS_LEVEL_UPDATE, U_C_MINOS_MAP_DATA, U_C_MINOS_NODE_UPDATE, U_C_MINOS_PLAYER_DATA, U_C_MINOS_RANK_DATA |
| Expedição do Eremitério (秘境探险) (`secret_explore`) | pve | SecretMapLevelTemplates, SecretSonLevelTemplates, SecretMapDataTemplates, SecretEventTemplates | C_SECRET_EXPLORE_OP, U_C_SECRET_EXPLORE_PANEL_DATA, U_C_SECRET_EXPLORE_MAP_DATA, U_C_SECRET_EXPLORE_EVENT_DATA, U_C_SECRET_EXPLORE_CLOSE |
| Desafio de Teseus (秘宝探险 / StoreHouse) (`theseus_challenge`) | pve | StoreHouseChapterTmpls, StoreHouseMapTmpls | C_STORE_HOUSE_CLIENT_OP, U_C_STOREHOUSE_USER_DATA, U_C_STOREHOUSE_FIGHT_DATA, U_C_STOREHOUSE_ADD_SKILL |
| Exploração das Ruínas (遗迹探险) (`remains_explore`) | pve | RemainsExploreChapterTemps, RemainsExploreNodeTemps, RemainsExploreEventTemps, RemainsLeedTemps | C_REMAINS_EXPLORE_OP, U_C_REMAINS_EXPLORE_INFO, U_C_DO_EXPLORE_UPDATE, U_C_REMAINS_LEED_UPDATE |
| Terra Sombria (暗影之地) (`shadow_land`) | pve | ShadowLandTemplates | C_SHADOW_LAND_OP, U_C_SHADOW_LAND_INFO |
| Expedição dos Espíritos Protetores (护灵远征) (`spirit_expedition`) | pve | ExpeditionTemplates | C_EXPEDITION_CLIENT_OP, U_C_EXPEDITION_DATA, U_C_EXPEDITION_EDIT |
| Histórico de Conquistas (HeroRoad) (`hero_road`) | progression | HeroRoadTempInfos | C_HEROROAD_OP, C_ACHIEVEMENT_TASK_CLIENT_OP, U_C_HEROROAD_LIST, U_C_ACHIEVEMENT_TASK_DATA, U_C_ACHIEVEMENT_TASK_UPDATE |
| Continente dos Demônios (EvilLand/恶魔大陆) (`demon_land`) | pve | EvilLandTemplates | C_EVIL_LAND_OP, C_CAMPAIGN_SWEEP, U_C_EVIL_LAND, U_C_DIALOG |
| Caminho da Vingança (复仇之路) (`revenge_road`) | pve | RevengeRoadTemplates | C_REVENGE_ROAD_OP, U_C_REVENGEROAD_INFO, U_C_REVENGEROAD_DIALOG |
| Luta da Terralém (HugeHead/外域) (`outyard_war`) | guild | HugeHeadMapNodeTempInfos, StackHeadExploreTempInfos | C_HUGE_HEAD_REQUEST, C_HUGE_HEAD_NODE_BATTLE_REQ, C_STACK_HEAD_REQUEST, C_STACK_HEAD_EXPLORE, U_C_HUGE_HEAD_BATTLE_FIELD, U_C_HUGE_HEAD_MY_SIGN_IN_STATE, U_C_HU |
| Eremitério with sacred power (legacy, unused by the client) (`hermitage_holy_explore_legacy`) | pve | ExploreEventTemplates |  |
| Jardim Suspenso (空中花园) (`air_garden`) | social | AirGardenNodeTemplates | C_AIR_GARDEN_OP, U_C_AIR_GARDEN_STATE, U_C_AIR_GARDEN_LIST, U_C_AIR_GARDEN_CAMPAIGN_DETAIL, U_C_AIR_GARDEN_SELF, U_C_AIR_GARDEN_GAME_OPEN |
| Exploração Espaço-Tempo (时空探险/StarArea) (`stararea_explore`) | event | StarAreaRoadInfos | C_STARAREA_OP, U_C_STARAREA |
| Caminho da Glória (荣耀之路) (`glory_road`) | pve | GloryRoadBufferInfos | C_GLORY_ROAD_OP, U_C_GLORY_ROAD_DATA, U_C_GLORY_ROAD_MIRROR |
| Quests (main/daily/event/VIP/return) (`quest`) | progression | QuestTemps, QuestCondictionInfos, QuestGoods | U_C_QUEST_ADD, U_C_QUEST_FINISH, U_C_QUEST_UPDAT, C_CHECK_SEND |
| Caçador de Recompensas (`offer_reward`) | pve | RewardTemps, RewardCondictionInfos | C_REWARD_ADD, C_REWARD_REMOVE, C_REWARD_FRESH, C_REWARD_FINISH, C_REWARD_ARREST, C_REWARD_ONEKEY, U_C_REWARD_FRESH, U_C_REWARD_UPDATE, U_C_REWARD_COUNT |
| Missão de Ciclo (`ring_task`) | pve | RewardTemps, RewardCondictionInfos, RewardGoods | C_TAKE_REPEAT_REWARD, C_REPEAT_REWARD_FINISH, C_REPEAT_REWARD_FINISH_IMMEDIATELY, C_REPEAT_REWARD_UPDATE_FINISH, U_C_REPEAT_REWARD_UPDATE, U_C_REPEAT_REWARD_END |
| Marriage quests (`marry_task`) | social | RewardTemps, RewardCondictionInfos | C_MARRIAGE_TASK_REQUEST |
| Crepúsculo dos Deuses tasks (`gods_evening_tasks`) | pvp | RewardTemps |  |
| Guild quests and activity rewards (`guild_quests`) | guild | ConsortiaQuestTempInfos, ConsortiaQuestConditionTempInfos | U_C_CONSORTIA_QUEST_INFO, C_CONSORTIA_QUEST_GET_REWARD |
| Slate quests (Godhead/Theseus) (`theseus_slate_tasks`) | progression | SlateTaskTmpls | U_C_SLATE_USER_DATA |
| Navigation: port tasks (`navigation_trade`) | economy | NavigationTaskTempInfos | C_NAVIGATION, U_C_NAVIGATION_MSG, U_C_NAVIGATION_DATA_MSG |
| Histórico de Conquistas (Hero's Road) (`achievements_hero_road`) | progression | AchievementTaskTemplates | U_C_ACHIEVEMENT_TASK_DATA, U_C_ACHIEVEMENT_TASK_UPDATE, C_ACHIEVEMENT_TASK_CLIENT_OP, C_HEROROAD_OP |
| Activity Points (daily guide) (`activity_points`) | progression | ActivityDailyTemplates | U_C_ACTIVITY_UPDATE, C_ACTIVITY_DAILY_FINISH, C_ACTIVITY_BUY_BUFF |
| Shop (diamond market) (`main_shop`) | economy | ShopTempInfos | U_C_SHOP_BUY, U_C_SHOP_MAIN, U_C_SHOP_DISCOUNT, U_C_SHOP_HASBUY, U_C_BUY_DISCOUNT, U_C_SHOP_TEMPLATE_MSG, U_C_SHOP_DISCOUNT_INFO, C_FASHION_SHOP_BUY, C_SHOPCAR_ |
| Special-currency shops (sub-shops) (`sub_shops`) | economy | ShopTempInfos, FurnitureShopTempInfos | U_C_SHOP_BUY, U_C_SHOP_TEMPLATE_MSG, C_FURNITURE_SHOP_BUY, U_C_FROST_HEART_SHOP |
| Guild (levels, buildings, skills, ranks, contribution) (`consortia_core`) | guild | ConsortiaLevelInfos | U_C_CONSORTIA_CREATE, U_C_CONSORTIA_LEVEL, U_C_CONSORTIA_OFF, U_C_CONSORTIA_LEARN, U_C_CONSORTIA_DUTYUPDATE, U_C_CONSORTIA_DUTYEDIT, C_CONSORTIA_DUTY_RIGHTS_UPD |
| Guild shop (`consortia_shop`) | guild | ShopTempInfos | U_C_SHOP_BUY |
| Câmara de Comércio (supplies and Salão de Trocas) (`consortia_business`) | guild | ConsortiaShopTempInfos, CommerceShopTemplates | C_CONSORTIA_SHOP_BUY, U_C_CONSORTIA_SHOP_LIST, U_C_CONSORTIA_SHOP_SELF_BUY |
| Guild treasure (`consortia_treasure`) | guild | ConsortiaTreasureTempInfos | C_CONSORTIA_TREASURE_OP, U_C_CONSORTIA_TREASURE |
| Guild campaigns (`consortia_pve`) | guild | ConsortiaPveTemplates | C_CONSORTIA_PVE_CLIENT_OP, U_C_CONSORTIA_PVE_DATA, U_C_CONSORTIA_PVE_NODE_UPDATE, U_C_CONSORTIA_PVE_CUR_NODE, U_C_CONSORTIA_PVE_SEASON_DATA, U_C_CONSORTIA_PVE_B |
| Terra dos Sonhos (old guild boss) (`consortia_emedream_boss`) | guild | ConsortiaBossTempInfos | C_CONSORTIA_BOSS_CALL, C_CONSORTIA_BOSS_UPGRADE, U_C_CONSORTIA_BOSS_SKILLINFO, U_C_CONSORTIA_BOSS_SYNC_HP, U_C_CONSORTIA_BOSS_START, U_C_CONSORTIA_BOSS_STATE, U |
| Guild boss (new) (`consortia_new_boss`) | guild | ConsortiaNewBossTemplates, ShopTempInfos | C_CONSORTIA_NEWBOSS_CLIENT_OP, U_C_CONSORTIA_NEWBOSS_DATA, U_C_CONSORTIA_NEWBOSS_RANK, U_C_CONSORTIA_NEWBOSS_HP, U_C_CONSORTIA_NEWBOSS_USER, U_C_CONSORTIA_NEWBO |
| Guild Defense / cross-server guild war (`consortia_war`) | guild | ConsortiaWarQuestTemplates, ShopTempInfos | C_CONSORTIA_WAR_CLIENT_OP, U_C_CONSORTIA_WAR_DATA, U_C_CONSORTIA_WAR_SEASON_RANK, U_C_CONSORTIA_WAR_CONTRIBUTE_RANK, U_C_CONSORTIA_WAR_FIGHT_DATA, U_C_CONSORTIA |
| Duelo Tático (方寸对决) (`chess_pvp`) | guild | ShopTempInfos | C_CHESS_PVP_CLIENT_OP, CR_CHESS_PVP_CLIENT_OP, U_C_CHESS_PVP_DATA, U_C_CHESS_PVP_RANK, U_C_CHESS_PVP_RECORD, U_C_CHESS_PVP_BOARD_DATA, U_C_CHESS_PVP_BOARD_UPDAT |
| Supremacia do Legend (auto chess) (`auto_chess`) | event | AutoChessHeroInfos, AutoChessBuffInfos | C_SELF_CHESS_OP, CR_SELF_PROPELLED_CHESS, U_C_SELF_PROPELLED_CHESS_DATA, U_C_SELF_PROPELLED_CHESS_OVER, U_C_SELF_PROPELLED_CHESS_STATE, U_C_SELF_PROPELLED_CHESS |
| Return / Alliance Contract (同盟契约) (`alliance_contract`) | event | AllianceActivityTasks, AllianceRewardInfos, AlliancePrivileges, AllianceShopInfos | C_ALLIANCE_REGRESSION_OP, U_C_ALLIANCE_ACTIVITY_INFO, U_C_ALLIANCE_USER_DATA, U_C_ALLIANCE_SEARCH_ALLY, U_C_ALLIANCE_OP_RESP |
| Outer-city Loja Misteriosa (`outer_city_shop`) | economy | MapShopItemTemplateInfos | U_C_MAPSHOPINFO, U_C_OUTER_CITY_SHOP_PASS |
| Auction (player market) (`auction`) | economy |  | C_MALL_SELL_ITEM, C_MALL_LIST_SELL, C_MALL_PLAYER_ITEMS, C_MALL_AUCTION, C_MALL_LIST_AUCTION, C_MALL_FIX_AUCTION, C_MALL_CANCEL_SELL, C_MALL_SEARCH, U_C_MALL_SE |
| Flash auction (event) (`flash_auction`) | event |  | C_AUCTION_OP, U_C_AUCTION, U_C_AUCTION_STATE, U_C_AUCTION_NOTIC |
| Navigation shop (`navigation_shop`) | economy | NavigationShopTempInfos |  |
| Game Box (exchange) (`game_box_shop`) | event | GameBoxShopTempInfos | U_C_GAMEBOX_INFO, U_C_GAMEBOX_GAMESTART |
| Poseidon shop (`poseidon_shop`) | economy | PoseidonShopTemplates | C_POSDIDON_SHOP_PANEL, C_POSDIDON_SHOP_BUY, U_C_POSDIDON_SHOP_PANEL, U_C_POSEIDON_SHOP_BUY |
| Merit shop (Campo de Batalha Secreto) (`exploits_shop`) | pvp | ExploitsShopTemplates | C_EXPLOITS_SHOP_OP, U_C_EXPLOITS_SHOP |
| Masmorra de Teseu (block exploration) (`theseus_dungeon`) | pve | TheseusDungeonTemplates, TheseusDungeonEventTemplates, TheseusDungeonTaskTemplates | C_THESEUS_DUNGEON_CLIENT_OP, U_C_THESEUS_DUNGEON_DATA, U_C_THESEUS_DUNGEON_TASK_DATA |
| Torre de Teseu (`theseus_tower`) | pve | TheseusTowerTmpls | C_THESEUS_TOWER_CLIENT_OP, U_C_THESEUS_TOWER_DATA |
| Arena de Teseu (1v1, seasons) (`theseus_pvp_arena`) | pvp | TheseusPvpTmpls, TheseusPvpIntegralTmpls, TheseusPvpRewardTmpls | C_THESEUS_PVP_CLIENT_OP, U_C_THESEUS_PVP_USER, U_C_THESEUS_PVP_REWARD, U_C_THESEUS_PVP_RANK, U_C_THESEUS_PVP_SHOW, U_C_THESEUS_PVP_REPORT, U_C_THESEUS_PVP_LEAVE |
| Arena Multiplayer de Teseu (duo/team) (`theseus_multi_pvp_arena`) | pvp | TheseusMultiPvpTmpls, TheseusMultiPvpIntegralTmpls, TheseusMultiPvpRewardTmpls | C_THESEUS_DOUBLEPVP_CLIENT_OP, U_C_THESEUS_PVPDOUBLE_USER, U_C_THESEUS_PVPDOUBLE_REWARD, U_C_THESEUS_PVPDOUBLE_RANK, U_C_THESEUS_PVPDOUBLE_SHOW, U_C_THESEUS_PVP |
| Arena do Espírito de Proteção (ChildPvp/Nswar) (`child_pvp_arena`) | pvp | ChildPvpTmpls, ChildPvpRewardTmpls | C_CHILD_PVP_CLIENT_OP, CR_CHILD_PVP_AID, U_C_CHILD_PVP_USER, U_C_CHILD_PVP_REWARD, U_C_CHILD_PVP_RANK, U_C_CHILD_PVP_MATCH, U_C_CHILD_PVP_FIGHT_RESULT, U_C_CHIL |
| Julgamento Principal (Lord Trial) (`lord_trial`) | pve | LordTrialTempInfos | C_LORD_TRIAL_OP, U_C_LORD_TRIAL |
| Palácio Zodiacal (Ecliptic Palace) (`ecliptic_palace`) | pve | EclipticPalaceTempInfos | C_ECLIPTIC_PALACE_OP, U_C_ECLIPTIC_PALACE_INFO, U_C_ECLIPTIC_PALACE_REWARD_RECORD |
| Arena Ilusória (Dream Arena) (`dream_arena`) | pvp | DreamArenaTemplates | C_DREAM_ARENA_CLIENT_OP, U_C_DREAM_ARENA_USER, U_C_DREAM_ARENA_FIGHT, U_C_DREAM_ARENA_MATCH, U_C_DREAM_ARENA_TICKET |
| Exploração de Monstros (idle) (`monster_explore`) | progression | MonsterExploreTemplates | C_MONSTER_EXPLORE_CLIENT_OP, U_C_MONSTER_EXPLORE_EDIT_DATA, U_C_MONSTER_EXPLORE_FIGHT_DATA, U_C_MONSTER_EXPLORE_USER_DATA, U_C_MONSTER_EXPLORE_BOSS_REWARD, U_C_ |
| Chefão da Zona Proibida (`forbidden_boss`) | guild | ForbiddenBossTemplates | C_FORBIDDEN_BOSS_CLIENT_OP, U_C_FORBIDDEN_BOSS_USER, U_C_FORBIDDEN_BOSS_LIST, U_C_FORBIDDEN_BOSS_RANK, U_C_FORBIDDEN_BOSS_RECORD, U_C_FORBIDDEN_BOSS_HP |
| Caminho da Realeza (Royalty/Chefão da Realeza) (`royalty_path`) | progression | RoyaltyTemplates, RoyaltyBossTemplates | C_ROYALTY_CLIENT_OP, U_C_ROYALTY_DATA |
| Calabouço Aleatório buff shop (`random_boss_buff_shop`) | pve | RandomBossBuffInfos | U_C_RANDOMBOSSBUFF, C_BUY_TRIAL |
| Game Hall (team minigames) (`game_hall`) | event | GameHallTemplates | C_GAME_HALL_OP, C_GAME_HALL_EDIT_POS, C_GAME_HALL_INVITE, C_GAME_HALL_MOVE, C_EASTER_CLIENT_OP, CR_GAME_HALL_CHAT, U_C_GAME_HALL_TEAM_LIST, U_C_GAME_HALL_TEAM_D |
| Coliseu (asynchronous ranking arena) (`colosseum`) | pvp |  | C_CHALLENGE, C_CHALLENGEINFO_REQUEST, U_C_CHALLENGE_INFO |
| Liga do Pico (Apex) (`apex_league`) | pvp |  | C_APEX_CLIENT_OP, U_C_APEX_SIGN_IN_CONFIRM, U_C_APEX_SIGN_IN_STATE, U_C_APEX_TEAM_CLIENT_OP_RESP, U_C_APEX_RANK, U_C_APEX_BET_INFO, U_C_APEX_BET_WINNER, U_C_APE |
| Rooms (PvE, PvP, events) (`rooms`) | social |  | U_C_CAMPAIGN_ROOM_CREATE, U_C_CAMPAIGN_ROOM_ENTER, U_C_CAMPAIGN_ROOM_EXIT, U_C_CAMPAIGN_ROOM_LIST, U_C_CAMPAIGN_ROOM_INVITE, U_C_CAMPAGIN_ROOM_PLACESTATE, U_C_C |
| Friends and relations (`friends`) | social |  | U_CH_ADD_RELATIONSHIP, U_CH_REMOVE_RELATIONSHIP, U_CH_FRIENDADD_CONFIRM, U_CH_RECOMMENDLIST, CH_ADD_GROUP, CH_DEL_GROUP, CH_RENAME_GROUP, CH_FRIEND_MOVE, CH_FRI |
| Mail (`mail`) | social |  | U_C_MAIL_LIST, U_C_MAIL_SEND, U_C_MAIL_DEL, U_C_MAILITEM_MOVE, U_C_MAILITEM_MOVE_RESULT, U_C_NEW_MAIL, U_C_MAIL_DEL_RESULT, C_MAIL_CHECK, U_C_MAIL_CHECK |
| Rankings (`rankings`) | social |  | U_C_RANK_LIST |
| World Boss (`world_boss`) | event |  | C_WORLD_BOSS_CMD, C_WORLD_BOSS_REQ, C_WORLDBOSS_PLAYER_LIVE, C_WORLDBOSS_STATE, C_WORLDBOSS_BUFFER, C_OPRATE_REPLACEMENTS, U_C_WORLDBOSS_BUFFER, U_C_WORLDBOSS_L |
| Easter: Game Hall (Spring stages) (`easter_game_hall`) | event | EasterTemplates | C_EASTER_CLIENT_OP, U_C_EASTER_USER_DATA, U_C_EASTER_LOTTERY_DATA, U_C_TOP_TOOL_BTN, C_GAME_HALL_OP, U_C_GAME_HALL_TEAM_LIST, U_C_GAME_HALL_TEAM_DATA, U_C_GAME_ |
| Christmas Party (8 sub-activities) (`christmas_carnival`) | event | ChristmasLotteryTemplates, ChristmasActivitiesTemplates, ChristmasAnswersTemplates, ChristmasAchievementsTemplates | C_CHRISTMS_OP, U_C_CHRISTMAS_DATA, U_C_CHRISTMAS_TASK_DATA, U_C_CHRISTMAS_ANSWER_DATA, U_C_CHRISTMAS_SNOWY_MIST_DATA, U_C_TOP_TOOL_BTN |
| Carnival (Folia) (`carnival`) | event | CarnivalDailyChallengeTemplates, CarnivalLuckDrawTemplates, CarnivalPlayGroundTemplates, CarnivalPointExchangeTemplates | C_CARNIVAL_OP, U_C_CARNIVAL_DATA, U_C_CARNIVAL_TASK_DATA, U_C_TOP_TOOL_BTN |
| 7th Anniversary (Bandeira de Guerra) (`seven_year_anniversary`) | event | SevenYearAchievementTemplates, SevenYearQuestionTemplates | C_SEVEN_YEAR_OP, C_TREASURE_BOX_OP, U_C_SEVEN_YEAR_ACTIVE_INFO, U_C_SEVEN_YEAR_USER_INFO, U_C_SEVEN_YEAR_ORDER_INFO, U_C_SEVEN_YEAR_QUESTION_INFO, U_C_SNOW_VEHI |
| Torre da Guerra (`war_soul_tower`) | pve | WarSoulTowerLevelTemplates, WarSoulTowerStageRewardTemplates | C_WAR_SOUL_TOWER_CLIENT_OP, U_C_WAR_SOUL_TOWER, U_C_WAR_SOUL_TOWER_RESULT |
| Theseus Collection: level rewards (`theseus_collection_reward`) | progression | CollectionRewardTemplates | U_C_COLLECTION_REWARD_DATA, U_C_COLLECTION_DATA, C_COLLECTION_CLIENT |
| Tiered special rewards (Theseus Glory / Anniversary) (`special_reward_tiers`) | event | SpecialRewardTmpls | C_YEAR_ACTIVITY_CLIENT_OP, U_C_YEAR_ACTIVITY_DATA, U_C_TOP_TOOL_BTN |
| Anniversary Celebration (Year2023 / YearEgg) (`year_activity`) | event | SpecialRewardTmpls | C_YEAR_ACTIVITY_CLIENT_OP, U_C_YEAR_ACTIVITY_DATA, U_C_TOP_TOOL_BTN |
| Guardiões Procurados (Guard PVE) (`guard_pve_wanted`) | pve | GuardPVETemp | C_GUARDPVE_REQ, U_C_GUARDPVE_OPRSP, C_PET_CHALLENGE_SKILL |
| Abismo (Guard Endless) (`guard_endless_abysm`) | pve |  | C_GUARDENDLESS_OP, U_C_GUARDENDLESS_INFO, U_C_GUARD_ONFIGHT, U_C_GUARD_REWARD |
| Einherjar League/Challenge: weekly prizes (`pet_challenge_league`) | pvp | PetChallengeRewards | C_CHALLENGEINFO_REQUEST, C_CHALLENGE_PET, C_PET_CHALLENGE_FORMATION, C_PET_CHALLENGE_SKILL, C_PET_RANK_REWARD, C_QUICKCOOL_CHALLENGE_TIME, U_C_CHALLENGE_TIME, U |
| Passagem Rápida (team Quick Challenge) (`quick_pass`) | pve | QuickPassRewards | C_QUICKPASS_OP, U_C_QUICKPASSINFO, U_C_QUICKPASSRank |
| Caminho do Céu (Sky Trial) (`sky_box_road`) | pve | SkyOrderRewards, SkyRewards | C_SKY_TRIAL, U_C_RES_SINGLEPASS_INFO, U_C_UPDATE_AREA, U_C_SKY_RANK, U_C_SKY_POINT_REQ |
| Vórtice do Tempo (`time_vortex`) | pvp | TimeVortexRewards | C_TIMEVORTEX_CLIENT_OP, U_C_TIMEVORTEX_INFO, U_C_TIMEVORTEX_BATCH_INFO, U_C_TIMEVORTEX_CRACK_INFO, U_C_TIMEVORTEX_CRACK_TEAM_INFO, U_C_TIMEVORTEX_CRACK_TEAM_REA |
| Caça Fantástica (4v4 arena) (`unreal_shooting`) | pvp | UnrealWeekRewards | C_UNREAL_SHOOTING_OP, U_C_UNREAL_SHOOTING_INFO, U_C_UNREAL_MAIN_INFO, U_C_UPDATE_UNREAL_SCORE, U_C_UNREAL_REPORT, U_C_UNREAL_WEEK_ORDER, U_C_UNREAL_ACTIVE_STATE |
| Astronomy (Stargazing) (`stargazing`) | progression |  | C_STARGAZING_OP, U_C_STARGAZING_OP |
| Time windows / event buttons (`event_time_windows`) | event |  | U_C_TOP_TOOL_BTN |
| Drop and reward packs, see §8 (`reward_drop_packages`) | economy | GradeDrop, SignDrop, ReloginDrops, TimeDrop, DistrictDrop, LeedDrop, TitanlandDrop, VipDrop, PrivilegeDrops, ServenLeadRewards, TollgateReward, BoxItems, DistrictSSSDrop, GloryRoadDrop, GuardPvpDrop,  |  |

## 10. Formulas

Machine-derived catalog of the formulas recovered from the decompiled client and the template data, grouped by topic.
Each bullet reads **id**: `formula`. Description. (source reference)

### 10.1 Castle, buildings and resources

- **townhall_gold_yield**: `Property1(901,g) = 390 + 525*(g-1) if g<=60; 31365 + 285*(g-60) if g>60`. Prefeitura gold/h per level (verified on all 80 rows). (no source reference: `None`)
- **tech_bonus**: `bonus = EffectTempInfos[BuildingTempInfos.Property1].Property1 * BuildingGrade`. Technology bonus, e.g. gold 240×lv (19200/h at lv80), soldier HP 20×lv, hero HP 80×lv; basic and advanced technologies stack. (`decompiled/core_module/scripts/ui/toptoolbar/view/ExtraBufferItem.as:234`)
- **gold_levy_amount**: `levy = Prefeitura.Property1*6 + Furnace(101).Property1*3 (+ floor(AddValue_midas*levy/100) if buff 1 active); requires Leader >= 14`. Gold per tax collection. (`decompiled/m4/scripts/buildings/politics/view/LevyView.as:117`)
- **inner_gold_yield_display**: `internal = gold.baseYield - fieldYield; Midas bonus = floor(AddValue*internal/100)`. Gold/h tooltip; `CastleYieldMsg.gold_yield` is the sum of prefeitura + technology + lands + other sources. (`decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as:298`)
- **build_queue_cooldown_cost**: `diamonds = ceil(remainTime_s / 600)  (Quick_Cool = "1,10": 1 diamond per 10 min); active VIP = free`. Diamond cost to speed up a build queue. (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:598`)
- **build_queue_slots**: `queues = Castle_Order (1) + bought; max buildOrderLimit=2; purchase = Order_NeedPay (100 diamonds, requires allPoint>=100)`. Number of build queues. (`decompiled/core_module/scripts/ui/queuebar/QueueBar.as:485`)
- **building_upgrade_check**: `can = !max && gold>=next.GoldConsume && waterCrystal>=next.CrystalsConsume && prerequisites(PreTemplateId) && Leader.grades>=next.PlayerGrades && freeQueue`. Client-side validation before sending `C_BUILDING_UPGRADE`. (`decompiled/core_module/scripts/yishi/manager/BuildingManager.as:367`)
- **tech_prereq**: `tech(basic).PreTemplateId(lv N) = 50100+N; tech(advanced) = 50100+max(50,N); unlock: Santuário lv1..12 (basic), lv55 (advanced)`. Santuário level × technology prerequisites. (`decompiled/core_module/scripts/mvc/module/buildings/BuildingModel.as:306`)
- **upgrade_level_from_exp**: `level = first Grades-1 such that remaining_exp < Data, subtracting each level's Data (Data is incremental)`. EXP → level conversion for any `UpGradeTempInfos` `Types` value. (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2321`)
- **marriage_cost**: `cost = (now < marriage+259200s) ? ceil(Points*Discount/100/k) : Points/k ; k = 2 if returning player's 1st marriage else 1`. Diamond price of the wedding ceremony (`MarrySpecTempInfos`). (`decompiled/core_module/scripts/mvc/module/marry/MarryModel.as:572`)
- **alchemy_mine_output**: `ore = min(floor((now - startTime)/Speed), MaxCount)`. Accumulated alchemy mine output; the mine is full at `startTime + MaxCount*Speed`. (`decompiled/core_module/scripts/mvc/module/alchemical/AlchemicalMineInfo.as:37`)
- **regress_payout**: `paid = TakePercent * canTakeTotalCount / 100 (or TakeData if 0)`. Returning-player (regress) payout per goal. (`decompiled/m11/scripts/regress/RegressItem.as:90`)
- **resource_sync**: `client sends U_C_CASTLE_UPDATE (5015) every 30000 ms; reply 109 updates gold(baseYield,total,max), waterCrystal(0,crystals,1e8), population(0,cur,max)`. Periodic resource sync with the server. (`decompiled/core_module/scripts/yishi/manager/ResourceManager.as:39`)
- **archaeology_assembly**: `relic assemblable when chipCount >= NeedChip; progress% = chipCount*100/NeedChip`. Archaeology relic assembly. (`decompiled/m14/scripts/archaeology/ArchaeologyMakeRightView.as:145`)

### 10.2 Energy, campaigns and PvE modes

- **campaign_weary_cost**: `cost = 20 Energy per entry (single and multi); without Energy ≥ 20 the campaign gives no rewards`. `ConfigInfos` `SingleCampaign_Weary` / `MultiCampaign_Weary` = 20; the warning uses alert `disclist04`. (`decompiled/m13/scripts/selectcampaign/view/CampaignInfoView.as:318`)
- **weary_cap_and_reset**: `weary ≤ 200 (WEARY_MAX); refills to 200 at 0:00; potions: total recovered/day ≤ 600 (WEARY_GET_MAX); recoverable now = 200 - weary`. Energy cap and potion limits. (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as:90`)
- **weary_hook_regen**: `+1 Energy every 2 min practicing at the Santuário statue (hook)`. From the `HookHelperFrame` help text. (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:372`)
- **campaign_sweep**: `max_times = floor(weary/20); energy = n*20; time = n*Campaign_Sweep_Time(60 s); gold = 5000/sweep (Campaign_Sweep_Gold); speed-up Sweep_Fast = 1 diamond/10 min (reading is an assumption)`. Campaign sweep (mopup). (`decompiled/m5/scripts/mopup/view/CampaignMopupPrepareFrame.as:195`)
- **time_vortex_sweep**: `max_times = floor(weary/10)`. A Vórtice do Tempo sweep costs 10 Energy. (`decompiled/m5/scripts/mopup/view/TimeVortexMopupPrepareFrame.as:183`)
- **campaign_unlock_state**: `state = 2 (open) if PreCampaignId=0 or rank[PreCampaignId]; 1 if rank[CampaignId]; else 0 (locked)`. Sequential campaign unlock. (`decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:144`)
- **sky_trial_search_all**: `n = min(TotalSearchCount - searchCount, 10); if energy < 20*n then n = floor(energy/20); max energy 500; buy +100 per 25 diamonds up to 3x/day`. Batch search in Caminho do Céu. (`decompiled/m11/scripts/skyboxroad/view/SkyboxRoadExploreView.as:299`)
- **dark_maze_mercenary_power**: `power = Atk + Def + int(MAtk*1.05) + MDef + ForceHit + Live + Parry + (Penetrate + StunAttr)*20 + (ReduceResi + Fire + Water + Elect + Wind + Dark + Light)*10`. Combat power of a Labirinto Negro mercenary. (`decompiled/core_module/scripts/mvc/module/darkmaze/DarkMazeModel.as:371`)
- **dark_maze_soul_reward**: `soul = base + 10*(floor-1); base 100 common, 150 elite, 200 boss`. Alma do Labirinto progression (data from `DarkMazeEventTemplates.Reward`). (`decompiled/m11/scripts/darkmaze/DarkMazeCommonFrame.as:175`)
- **final_road_buy_price**: `price of the i-th weekly purchase = FinalroadChallengePrice[buyChapterTimes] (300,300,500,600,800,1000,2000); re-challenge 50 diamonds (max 3)`. Caminho Final costs. (`decompiled/m11/scripts/finalroad/FinalRoadFrame.as:138`)
- **planes_event_energy_cost**: `cost = int(EnergyCost*(1500+3R)/(1500+4R)), R = total resistance of element ResistType (≥0)`. E.g. 100 → 88 at R=300; the limit is 75. (`decompiled/core_module/scripts/mvc/module/planeswar/PlanesWarModel.as:402`)
- **planes_step_energy_cost**: `step_cost = int((1500+R)/(300+R))`. R=0 → 5, R≥1200 → 1 (the function is defined in the client but applied server-side). (`decompiled/core_module/scripts/mvc/module/planeswar/PlanesWarModel.as:379`)
- **planes_energy_regen**: `+50 energy every 30 min up to 1500 (planes_recover_energy, planes_max_recover_energy); buy 100 per 30 diamonds up to 5x/day`. Planes energy regeneration. (`decompiled/m3/scripts/planeswar/view/PlanesTopView.as:65`)
- **planes_market_price**: `diamond_price = int(basePrice*discount/100)`. Planes Mercado Negro price. (`decompiled/m3/scripts/planeswar/view/eventframe/PlanesBlackItemView.as:96`)
- **crisis_move_cost**: `1 move per step (crisis_activity_consume); initial 20; one-time purchase +10 for 20 diamonds or -10% of gains`. Crise dos Planos movement. (`decompiled/core_module/scripts/mvc/module/crisis/PlaneCrisisModel.as:138`)
- **minos_remaining_challenges**: `remaining = Minos_ChallengeCount(10) + buyCount - challengeCount; buyCount <= 5; price = 100 diamonds/purchase (Minos_ChallengePrice='5,100')`. Daily Labirinto de Minos attempts. (`decompiled/m6/scripts/consortia/view/minos/ui/MinosMapViewUI.as:372`)
- **minos_node_progress**: `new_progress = progress + GardenValue(difficulty); complete when progress >= NodeValueMax`. Node progress per win. (`decompiled/m6/scripts/consortia/view/minos/ui/MinosCardChoseViewUI.as:240`)
- **minos_node_id**: `Id = ForLevel*10000 + NodeType*1000 + NodeId*100 + NodeGrade`. Composition of `MinosNodeTmpls` IDs (from data). (`decompiled/core_module/scripts/yishi/datas/templates/cate/MinosNodeCate.as:39`)
- **secret_cell_id**: `cellId = row * maxColumns + column (MapDatas split '|' and ',')`. Hex cell ID in the Eremitério submap. (`decompiled/m3/scripts/secretadventure/map/SecretSonMapView.as:92`)
- **remains_boss_unlock**: `boss1 visible if !isBoss1Pass && progress >= 50; boss2 if !isBoss2Pass && progress >= 100`. Boss appearance in the Ruins. (`decompiled/core_module/scripts/mvc/module/remainsexplore/RemainsExploreNodeInfo.as:27`)
- **remains_tinder_config**: `remainsexplore_config = cost 20 Faíscas/exploration, max 300, 6 purchases/day, boss CD 6h, big boss CD 6h; purchase n: remainsexplore_tinder_buy = [200,200,300,500,800,1000] diamonds per 100 Faíscas`. Faíscas economy. (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1684`)
- **storehouse_award_roll**: `P(item) = weight/1000 (Award 'itemId,qty,weight|...'), rolled every 5 floors`. Desafio de Teseus drop. (`decompiled/m3/scripts/thessbox/view/ThessBoxLeftView.as:122`)
- **spirit_expedition_area_stars**: `area_stars = Σ Star of stages with NodeId <= passNodeId; chest unlocked if total_stars >= ExpeditionStarDrop.site (13,26,49,72,107,142)`. Expedition stars. (`decompiled/core_module/scripts/mvc/module/childspiritexpedition/SpiritExpeditionModel.as:106`)
- **spirit_expedition_energy**: `energy_cost = max(100, hp_lost% * 100/100) ; max energy 1000; recovery CD 3600 min; speed-up: 5 diamonds per 30 min`. Expedition energy (元神值) from the `expedition_*` configs. (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1602`)
- **shadow_land_energy**: `shadow_land_config = max 200, +10/h, 10 per entry; sweep 60s and 50000 gold per stage`. Terra Sombria energy. (`decompiled/core_module/scripts/mvc/module/shadowland/ShadowLandModel.as:91`)
- **demon_land_attempts**: `remaining = AttackCount - attackCount + buyCount; purchase = evilland_buy_count_cost (50 diamonds); cost per attack = Cost Lágrimas (evilland_goddess_tear_config '500,20,5,250')`. Continente dos Demônios attempts and cost. (`decompiled/m11/scripts/demonland/AwardView.as:246`)
- **revenge_road_attempts**: `boss: remaining = AttackCount + buyCount - attackCount; revenge_road_config = heart max 200, +10/h, 3 purchases at 500 diamonds, 3 boss purchases at 80 diamonds; attack costs Cost (20)`. Caminho da Vingança economy. (`decompiled/m11/scripts/revenge/RevengeFightFrame.as:222`)
- **air_garden_base_price**: `price = Cost[hasBuyCount] (or last value); limit = len(Cost.split(','))`. Progressive price of garden bases. (`decompiled/m15/scripts/view/subshop/AirGardenShopBedItem.as:133`)
- **glory_road_buff_sum**: `for Type 1..4: per = Σ Percent, value = Σ Value of bought buffs`. Cumulative Caminho da Glória buff bonus. (`decompiled/core_module/scripts/mvc/module/gloryroad/GloryRoadModel.as:235`)
- **outyard_explore_points**: `points = 600 (huge_head_explore_point); dice roll = 20; entry = 100; recharge = 100 diamonds -> 200 points`. Terralém exploration points. (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:129`)
- **stararea_action_power**: `each node step = 10 action; daily max 70 (star_area_action_power)`. Exploração Espaço-Tempo action points. (`decompiled/core_module/scripts/mvc/module/stararea/StarareaModel.as:144`)

### 10.3 Quests

- **quest_finished_bit**: `finished(id) = (questSite[(id-1) >> 3] & (1 << ((id-1) % 8))) != 0`. A quest is complete when bit (id-1) of the `questSite`/states bitset sent by the server is set. (`decompiled/core_module/scripts/yishi/manager/TaskManage.as:579`)
- **daily_quest_exp**: `exp = RewardPlayGP + (thane.grades - NeedMinLevel) * 500  (TemplateType = 1)`. Displayed daily quest EXP grows by 500 per level above the minimum. (`decompiled/m15/scripts/task/view/TaskRewardViewII.as:225`)
- **offer_reward_exp_gold**: `m = (q == 5 ? 6 : q); exp = RewardPlayGP * m * (grades + vg); gold = RewardGold * m * (grades + vg); vg = (isChangeJob ? 80 : vocationGrades)`. Caçador de Recompensas reward by quality q (1..5) and level; Fonte Mágica bonus = floor(AddValue * exp / 100). (`decompiled/m15/scripts/offerreward/view/OfferTaskItem.as:314`)
- **offer_reward_daily_limit**: `max = 20 + reward_count; remaining = max(0, max - thane.rewardCount)`. Daily reward-quest limit (20 base + server bonus, e.g. VIP). (`decompiled/core_module/scripts/managers/OfferRewardManager.as:88`)
- **offer_reward_refresh_timer**: `remain = min(1800, 1800 - (now - lastRefresh))`. The reward board auto-refreshes every 1800 s (30 min). (`decompiled/core_module/scripts/mvc/module/buildings/OfferRewardModel.as:162`)
- **ring_task_fixed_rewards**: `lvl 35-44: gold 400000 / strategy 2000000; 45-54: 480000/2400000; 55-64: 600000/3000000; 65-99: 800000/4000000`. Missão de Ciclo fixed reward by level band (overrides `RewardTemps`). (`decompiled/core_module/scripts/managers/RingTaskManager.as:214`)
- **ring_task_item_rewards**: `items = RewardGoods where RewardNum in RepeatStep.split(",") and RepeatMinLevel <= grades < RepeatMaxLevel`. Cycle item rewards every 10 quests (rewardNum % 10 == 0). (`decompiled/core_module/scripts/managers/RingTaskManager.as:290`)
- **navigation_trade**: `cost = ConsumedItems.qty * lots; currency = ObtainedCurrency * lots`. Navigation port trade. (`decompiled/m11/scripts/navigation/NavigationTaskItem.as:202`)
- **manual_quest_repeat_window**: `reopen if date(complete) != today or floor(hour(complete)/RepeatInterval) != floor(hour(now)/RepeatInterval)`. Repeat window for manual quests (`IsAuto=false`). (`decompiled/core_module/scripts/yishi/manager/TaskManage.as:645`)

### 10.4 Shops, guild and auction

- **shop_price_resolution**: `if ShopType in (8,15,1033,1035): price=Score; elif Point>0: price=Point,pay=1; elif GiftToken>0: pay=2; elif Gold>0: pay=3; elif Honor>0: pay=5; elif ShopType==17: Score,pay=12; elif ConsortiaOffer>0: pay=4; elif MazeCoin>0: pay=6; elif LordsScore>0: pay=7; ... else price=Score (shop currency)`. How the client resolves the price and currency of a `ShopTempInfos` row (the `Price`/`FirstPrice` columns are ignored). (`decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:469`)
- **shop_daily_remaining**: `remaining = (VIP0Count == -1) ? unlimited : VIP0Count - OneCurrentCount`. Daily purchase limit; `OneCurrentCount` comes from the server (opcodes 528/4145). (`decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:784`)
- **consortia_max_members**: `max_members = levels*20 + 10`. Member capacity by guild level (Lv1=30 ... Lv10=210; `Consortia_Member`=20). (`decompiled/m6/scripts/consortia/view/club/ConsortiaItem.as:174`)
- **consortia_weekly_maintenance**: `maintenance_per_week = levels*500`. Weekly upkeep (Fortuna) = `ConsortiaLevelInfos.Property2` of `Types`=1. (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaInfoView.as:231`)
- **consortia_upgrade_speedup_cost**: `diamonds = ceil(timeLeft_s / (60*10)) * 1`. Guild build speed-up: `Consortia_Fast='1,10'` = 1 diamond per 10 minutes remaining. (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaDevelopView.as:231`)
- **consortia_donation**: `contrib = fortune = floor(gold/1000) [min 1000 gold]; contrib = fortune = floor(diamonds/Point_ToOffer) [Point_ToOffer=1]; war_points = floor(spirit/1000)`. Guild donation (opcode 5144 `U_C_CONSORTIA_OFF`, `ConsortiaUserOfferReqMsg` `offerGold`/`offerPoint`). (`decompiled/m6/scripts/consortia/view/myConsortia/contribution/ConsortiaContributeFrame.as:353`)
- **consortia_shop_visibility**: `visible = NeedConsortiaLevels <= consortiaInfo.shopLevel + 1`. Guild Shop items are shown up to 1 level above the shop level (locked, with a tip). (`decompiled/core_module/scripts/mvc/controler/ShopControler.as:475`)
- **consortia_business_costs**: `supply_cost = CostConsortiaAsset*n (n <= MaxSupplyCount - stock); buy_cost = CostPersonReputation*n (n <= PersonBuyLimit - selfBought)`. Câmara de Comércio costs. (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaBusinessBuyFrame.as:157`)
- **auction_custody_fee**: `fee_gold = 250 * hours (8/24/48)`. Gold custody fee for an Auction listing. (`decompiled/m7/scripts/auction/view/sell/AuctionSellSubmitPane.as:144`)
- **auction_min_price**: `start >= max(2, StartingPrice*count); fixPrice > start; service_fee = 20% of the sold value`. Listing price validation (`StartingPrice` from `ItemTempInfos`). (`decompiled/m7/scripts/auction/view/sell/AuctionSellSubmitPane.as:163`)
- **auto_chess_unit_price**: `buy = Grade; sell = Grade + (Star-1)*2`. In-match auto chess gold to buy or sell a piece. (`decompiled/m3/scripts/chess/item/SelfChessTeamItem.as:288`)
- **emedream_boss_reward**: `win_terror_tooth = 600 + 200*Level; lost = win/4; item 2060802 x ceil(Level/2)`. `ConsortiaBossTempInfos` prize pattern (inferred from data). (`decompiled/m6/scripts/consortia/view/myConsortia/emedream/ConsortiaEmeDreamFrame.as:296`)
- **treasure_helper_reward**: `HelperDrop ≈ 0.8 * Drop`. Helper prize in the Guild Treasure (inferred from data). (`decompiled/m6/scripts/consortia/view/myConsortia/treasure/TreasureHelpItem.as:160`)
- **alliance_shop_limit**: `limit = Limited.split(',')[contractLevel-1]; max_qty = floor(currency/MoneyNum)`. Purchase limit in the Return event shop. (`decompiled/m11/scripts/oldplayerreturn/shop/OldPlayerReturnShopBuyFrame.as:136`)
- **consortia_newboss_skip**: `levels_skipped = 7 + a*(n-1), a=consortia_newboss_param=1; unlock by time: <=45min→7, 90→6, 180→5, 360→4, 720→3, 1440→2`. Guild Boss difficulty skip (config). (`decompiled/core_module/scripts/yishi/manager/ConsortiaNewBossManager.as:135`)
- **consortia_skill_adv_cost**: `Property2(level) = 200 * 2^(level-1); NeedOffer(level) = [2000,5000,10000,20000,30000,40000,50000,60000,80000,100000]`. Advanced guild skill costs (`Types` 13-21): `Property2` = Mérito to learn; `NeedOffer` = Fortuna to research. (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaSkillSchoolView.as:227`)

### 10.5 Arenas, Theseus and boss modes

- **theseus_pvp_points_delta**: `delta = (win ? Victory : -Defeat) from the TheseusPvpIntegralTmpls row with PvpId=current_rank, Mode=role and Section∋(my_points − opponent_points); if win and keepWin>=3: delta += bonus(WinningStreak[keepWin]) (3→10 ... 10→80)`. Theseus Arena scoring *(assumption: the point difference is the band key)*. (`decompiled/m3/scripts/theseuspvp/TheseusPvpResultFrame.as:179`)
- **pvp_rank_from_points**: `rank = max(Id) such that NeedIntegral <= points; next = getTempByType(MainType,SonType+1) ?? getTempByType(MainType+1,1)`. Rank and progress bar in the Theseus and ChildPvp arenas. (`decompiled/m3/scripts/theseuspvp/TheseusPvpResultFrame.as:189`)
- **child_pvp_points**: `win +15, loss −10 (child_pvp_rankpoints)`. Fixed Arena do Espírito de Proteção points (`ConfigInfos`). (no source reference: `None`)
- **theseus_dungeon_unlocked_floor**: `unlocked_floor = max(TemplateName) with server_day_of_month >= TimeUnlock`. Highest unlocked Masmorra de Teseu floor. (`decompiled/core_module/scripts/mvc/module/theseus/dungeon/TheseusDungeonModel.as:48`)
- **theseus_tower_card_page**: `start = 3*floor((passLevel−1)/3)+1; shows stages start..start+3`. Torre de Teseu 4-card pagination. (`decompiled/m11/scripts/thessTower/view/ThesstowerView.as:189`)
- **theseus_tower_buy_price**: `buy_price(n) = [500,1000,1500,2000,3000][n] diamonds; MAX_BUY = 5 per week`. Price of extra reward attempts (`theseustower_income_addprice`). (`decompiled/m11/scripts/thessTower/view/ThesstowerView.as:283`)
- **ecliptic_spirit_cost**: `SpiritCost(layer) = 10 + 5*(layer−1); spirit: max 200, +25/h, buy 200 diamonds (up to 40x)`. Palácio Zodiacal spirit cost. (`decompiled/m14/scripts/eclipticpalace/EclipticPalaceFrame.as:334`)
- **colosseum_buy_cost**: `cost = min((purchases_made+1)*2, 10) diamonds; free_remaining = max(totalFree − used, 0)`. Coliseu challenge purchase. (`decompiled/core_module/scripts/mvc/module/colosseum/ColosseumModel.as:82`)
- **forbidden_boss_armor_penalty**: `if theseus_armor < BAV: damage_to_boss *= 0.10 (BossSkill 84101001)`. Armor penalty in the Zona Proibida / Chefão da Realeza. (`decompiled/m3/scripts/map/campaign/view/ui/ForbiddenBossView.as:260`)
- **royalty_level_from_bosses**: `royaltyLevel = max(RoyaltyLevel) with BossLevel <= passBossLevel; missing = next_BossLevel − passBossLevel`. Royalty level from the bosses defeated. (`decompiled/m11/scripts/royaltyboss/RoyaltyBossFrame.as:281`)
- **monster_explore_idle_income**: `gain = minutes*MinuteGold/MinuteExp + kills*NpcGold/NpcExp; fast: 120 min per 100 diamonds, 10x/day`. Exploração de Monstros offline gains (`monster_explore_fast_config`). (`decompiled/m14/scripts/monsterexplore/MonsterExploreFrame.as:466`)
- **lord_trial_sweep**: `bot: 30 s and 10000 gold per floor; speed-up 5 diamonds (lord_trial_sweep_templates)`. Julgamento Principal sweep. (`decompiled/m5/scripts/mopup/view/LordTrialMopupPrepareFrame.as:162`)
- **apex_score**: `group by points [0,500,1000,1500,1800,2100]; win +[80,65,55,45,35,25], loss −[30,25,20,15,10,5] per group; captain kill +5`. Liga do Pico scoring (`apex_group_score`/`win`/`lost`). (`decompiled/core_module/scripts/mvc/module/apex/ApexModel.as:63`)

### 10.6 Seasonal events

- **easter_blessing_reward_bonus**: `bonus% = 10 per 30 levels of blessing difference (config easter_reward_add=30,10)`. Easter reward bonus by blessing level difference (server-side config; based on a reading of the Chinese description). (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1263`)
- **easter_lottery_cost**: `egg_draw_cost = easter_lottery_egg_count (100 colored eggs per draw; default 1)`. Eggs consumed per draw in the Easter Egg Shop. (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1252`)
- **easter_bless_counter_level**: `effective_skill = Buff3.TemplateId - floor(blessing_level_same_SonType / 5)`. Every 5 levels of spring blessing of the same `SonType` lower the displayed boss curse by 1 grade. (`decompiled/m3/scripts/gamehall/room/GameHallSceneEastBlessView.as:440`)
- **christmas_lucky_turn_eligibility**: `spins_unlocked = count(t in christmas_rebate[100,500,4000,20000] | totalCharge >= t) (max 4); gain = sum of the 4 rolled digits`. Christmas/Carnival Virada da Sorte: each recharge threshold unlocks one spin; spin N rolls the 10^(N-1) digit. (`decompiled/m11/scripts/christmas/ChristmasLuckyFrame.as:346`)
- **christmas_spend_crit**: `prize = Reward*multiplier, multiplier ∈ {2..6} with weights 35/30/20/10/5 when paying Para2 diamonds`. Spending Crit: on reaching accumulated spend `Para1`, the player claims normally or pays `Para2` to multiply the prize. (`decompiled/m11/scripts/christmas/view/ChristmasHirtView.as:146`)
- **christmas_snowymist_action_power**: `initial_moves=1000; exploration_cost=100; +100 every 30 min (christmas_actionpower)`. Mistério do Nevoado movement. (`decompiled/m11/scripts/christmas/ChristmasSnowymistMapItem.as:136`)
- **carnival_points_from_recharge**: `Pontos de Folia = floor(recharged_diamonds/100) * 15 (CarnivalPayCount=100,15; old help says 5)`. Recharge to Pontos de Folia conversion (server-side; config value). (`decompiled/m11/scripts/carnvial/view/CarnvialYearPage.as:142`)
- **carnival_minigame_remaining**: `remaining = max(0, PlayCount - plays_today[Type])`. Rewarded Minigame plays left. (`decompiled/m11/scripts/carnvial/item/CarnivalGameItem.as:109`)
- **seven_year_flag_level**: `flag_level = floor(warrior_points / 1000) (seven_year_grade_score)`. 1000 Warrior Points = 1 Bandeira de Guerra level; daily games give 200 points (`seven_year_game_score`). (`decompiled/m11/scripts/sevenyear/view/item/SevenYearAchievementItem.as:213`)

### 10.7 Towers, leagues and reward bands

- **war_soul_tower_window**: `beginLevel = isMax ? max-14 : max(1, level-7); shows 15 floors`. Floor window shown in the Torre da Guerra. (`decompiled/core_module/scripts/mvc/module/warsoultower/WarSoulTowerModel.as:90`)
- **war_soul_tower_first_reward**: `FirstRewardItemNum1 = 10 + 5*floor((LevelId-1)/10) (≈; 10 at floor 1, 255 at 500); Repeat1 ≈ 5 + 2*floor((LevelId-1)/10)`. Progression observed in the data. (`decompiled/m11/scripts/warsoultower/WarSoulTowerItem.as:54`)
- **war_soul_tower_armour_penalty**: `if armor < NeedArmourValue: damage_to_boss *= 0.10 (skill 84101001)`. Damage penalty when armor is below the floor's value. (`decompiled/m11/scripts/warsoultower/WarSoulTowerFrame.as:322`)
- **pet_challenge_group_by_score**: `group = 2 if score>=4000; 3 if >=3500; 4 if >=2400; 5 if >=1600; else 6`. Einherjar League group by score (`Pet_Challenge_Default_Score_Line`). (`decompiled/core_module/scripts/mvc/module/petchallenge/PetChallengeModel.as:210`)
- **unreal_rank_bracket**: `band_i = (Order_i + 1) .. Order_{i+1}`. Caça Fantástica ranking bands derived from the sorted `Order` values. (`decompiled/m9/scripts/unrealshooting/ranklists/UnrealShootingRewardView.as:87`)
- **time_vortex_crack_limits**: `rift_prizes_per_day = time_crack_get_count (2); rewarded_defenses = time_crack_defens_count (10); rift renews every hour at :05`. Time rift limits. (`decompiled/core_module/scripts/mvc/module/timevortex/TimeVortexModel.as:74`)
- **drop_range_match**: `min,max = para2.split(','); match = site == type && value >= int(min) && value <= int(max)`. Ranking, damage and score bands stored in `para2` as 'min,max' (e.g. damage 2000001..10000000 in `ConsortiaNewBossDamageReward`). (`decompiled/core_module/scripts/yishi/datas/templates/cate/ConsortiaNewBossDamageRewardTempCate.as:27`)
