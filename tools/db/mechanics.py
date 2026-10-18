from __future__ import annotations

M = []


def mech(code, name_pt, category, summary, modules=(), sets=(), tables=(), opcode_prefixes=(), proto_packages=(),
         asset_prefixes=()):
    M.append(dict(code=code, name_pt=name_pt, category=category, summary=summary, modules=list(modules),
                  sets=list(sets), tables=list(tables), opcode_prefixes=list(opcode_prefixes),
                  proto_packages=list(proto_packages), asset_prefixes=list(asset_prefixes)))


mech("hero", "Heróis", "unit", "Player character (job × sex × level) and NPC heroes/bosses; primary and combat stats, elemental resistances.",
     ["core_module", "m5"], ["GameHeroTemp"], ["heroes", "jobs", "sexes", "stat_types"], ["U_C_HERO", "C_HERO"], ["army", "player"], ["equip/", "swf/"])
mech("job", "Classes (jobs) e troca de classe", "unit", "Warrior, hunter, wizard, draconian; a newcomer picks a job (selectjobregister); job transfers unlock content.",
     ["core_module"], [], ["jobs"], ["U_C_SEX_CHANGE"], [], [])
mech("stats", "Atributos e poder", "combat", "Primary stats (strength, agility, intellect, physique, leadership, infantry) and combat stats (physical/magic attack and defense, HP, crit, block, determination, penetration, resistances).",
     ["core_module"], ["SkillPropertyTempInfos"], ["stat_types", "stat_bonus_profiles"], [], [], [])
mech("pawn", "Tropas (pawns/soldados)", "unit", "Soldiers recruited in buildings and led by heroes (Liderança/Infantaria), with per-level evolution and their own skills.",
     ["core_module", "m4"], ["PawnTempInfos", "SpecialTempInfos"], ["pawns"], ["U_C_ARMY", "C_ARMY"], ["army"], ["swf/"])
mech("army_formation", "Exército e formação (grade 3×4)", "combat", "Heroes, pawns, pets, children and goddess occupy positions 1..12 of a per-side grid; positions 1/4/7/10 are the front line.",
     ["core_module", "m5"], [], ["battle_grid_positions", "hero_ai_soldiers"], ["U_B_", "B_"], ["battle", "army"], [])
mech("monster", "Monstros colecionáveis", "unit", "Monsters with stars, max level, skills per son_type and a stat profile; resource swf/<res> with scale/offset.",
     ["m14"], ["MonsterTemplates", "MonsterExploreTemplates", "RecipeTemplates"], ["monsters"], ["MONSTER"], ["monster"], ["swf/"])
mech("monster_ai", "IA de NPCs e bosses", "combat", "HeroAis defines the cyclic skill sequence, trigger skills (low HP, death, rage, awaken) and escort troops.",
     ["core_module"], ["HeroAis"], ["hero_ais", "hero_ai_soldiers"], [], [], [])
mech("battle", "Batalha (fluxo e cena)", "combat", "Real-time battle driven by server frames (25 fps): prepare 157, start 156, attacks 153, end 154/4103. See docs/battle/README.md.",
     ["core_module", "m10"], ["ActionTempInfos", "ActionInfos"], ["battle_grid_positions", "blood_types", "animation_labels"], ["U_B_", "B_"], ["battle"], ["sceneima/", "skilleffect/"])
mech("skill", "Skills e ações animadas", "skill", "Skill → action (ActionId) → frame script (advance, attack label, effect, damage, projectile, shake) + applied buffs; rage cost, cooldown, target, QTE.",
     ["core_module", "m10"], ["SkillTempInfos", "ActionTempInfos", "ActionInfos"], ["skills", "actions", "action_frames", "action_frame_types", "skill_buff_links", "visual_effects", "action_frame_effects"], ["U_B_HERO_ORDER", "SKILL"], ["battle", "skill"], ["skilleffect/", "skillname/"])
mech("buff", "Buffs, debuffs e estados", "skill", "Temporary skill effects (turns/count), stacking, dispel, immunity; visual effects AddEffect/ActionEffect/LastEffect.",
     ["core_module"], ["SkillBufferTempInfos", "CampaignBufferTemps", "RandomBossBuffInfos", "GloryRoadBufferInfos"], ["buffs", "campaign_buffs", "skill_buff_links"], ["BUFF"], ["battle"], ["skilleffect/"])
mech("talent", "Talentos", "skill", "Modifiers that change cost, damage, cooldown, crit and buffs of the skills of one son_type.",
     ["core_module", "m5"], ["TalentEffectTempInfos"], ["talent_effects"], ["TALENT"], [], [])
mech("qte", "QTE em batalha", "combat", "A skill with QTETime opens a key prompt (QteView); success sends 10015 and boosts the skill.",
     ["m10"], ["SkillTempInfos"], ["skills"], ["QTE"], ["battle"], [])
mech("awaken", "Despertar (awaken)", "combat", "Battle awaken bar (U_C_UPDATE_AWAKE 4600) unlocks AwakenSkill.",
     ["core_module"], ["HeroAis"], ["hero_ais"], ["AWAKE"], ["battle"], [])
mech("avenger", "Vingador (avenger)", "combat", "Vingador body and per-job skills, with its own battle SP (4589/4591).",
     ["m5"], ["AvengerSkillTemplates", "AvengerBodyTemplates", "AvengerHoleTemplates"], ["avenger_skills", "avenger_bodies"], ["AVENGER"], ["avenger"], [])
mech("war_soul", "Espírito de guerra (warsoul)", "combat", "Equippable spirits with stars, strengthening and reform; battle SP (4311); spirit tower.",
     ["m5", "m11"], ["WarSoulTmpls", "WarSoulStarTmpls", "WarSoulStrengthenTmpls", "WarSoulReformTmpls", "WarSoulTowerLevelTemplates", "WarSoulTowerStageRewardTemplates"], ["war_souls"], ["WARSOUL"], [], [])
mech("rune", "Runas", "skill", "Equippable runes that grant skills (rage, heal...) and evolve with GP; rune gems and holes.",
     ["core_module", "m5"], ["RuneTempInfos", "RuneGemInfos", "RuneHoleInfos", "RuneFsgainInfos"], ["runes"], ["RUNE"], ["rune"], [])
mech("star", "Estrelas (astrologia)", "progression", "Collected/bought stars that grant stats and a skill; star bag.",
     ["core_module"], ["starTempInfos"], ["stars"], ["STAR"], ["star"], [])
mech("magic_card", "Cartas mágicas", "skill", "Cards activated by item, with grades that grant skills; evolved with magic dust.",
     ["m14"], ["MagicCardTempInfos"], ["magic_cards"], ["CARD"], ["powcard"], [])
mech("stela", "Estelas", "progression", "Stelae with stages, properties and resistances.", ["m14"],
     ["StelaTemplates", "StelaStepTemplates", "StelaPropertyTemplates", "StelaResistTemplates"], [], ["STELA"], [], [])
mech("slate", "Lousas (slate)", "progression", "Slates with levels and tasks.", ["m11"], ["SlateTmpls", "SlateUpgradeTmpls", "SlateTaskTmpls"], [], ["SLATE"], [], [])
mech("proficiency", "Proficiência", "progression", "Proficiency per type with a per-level bonus.", ["core_module"], ["ProficiencyTemplates"], [], ["PROFICIENCY"], [], [])
mech("auto_chess", "Xadrez automático", "event", "Auto-chess mode with its own heroes and buffs.", ["m3"], ["AutoChessHeroInfos", "AutoChessBuffInfos"], [], ["CHESS"], ["consortiachess"], [])
mech("theseus", "Teseu (equipamento, fúria, tesouro, PvP, masmorra)", "progression", "Teseu system family: equipment with quality/strengthening, rage, treasure, single/multi PvP, tower and dungeon.",
     ["m5", "m3"], ["TheseusEquipSuiteTemplates", "TheseusRageTemplates", "TheseusRageSuiteTemplates", "TheseusTreasureHokeTemplates", "TheseusTreasureCoreTemplates", "TheseusTreasureGrowupTemplates", "TheseusPvpTmpls", "TheseusPvpIntegralTmpls", "TheseusPvpRewardTmpls", "TheseusEquipStrengthenTmpls", "TheseusEquipQualityTmpls", "TheseusMultiPvpTmpls", "TheseusMultiPvpIntegralTmpls", "TheseusMultiPvpRewardTmpls", "TheseusTowerTmpls", "TheseusDungeonTemplates", "TheseusDungeonEventTemplates", "TheseusDungeonTaskTemplates", "StoreHouseChapterTmpls", "StoreHouseMapTmpls"], [], ["THESEUS"], ["theseus"], ["icon/theseusdungeon"])

mech("item", "Itens e inventário", "item", "All items (equipment, fashion, consumables, materials, gems, virtual currencies) categorized by MasterType/SonType.",
     ["core_module"], ["ItemTempInfos", "BoxItems", "HeartTempInfos"], ["items", "item_categories"], ["U_C_BAG", "C_BAG", "ITEM"], ["item", "store"], ["icon/"])
mech("equipment", "Equipamentos e fortalecimento", "item", "Weapons, armor and accessories with stats, strengthening (StrengthenMax), random skills, gems, transformation and decomposition.",
     ["core_module", "m14"], ["ItemTempInfos", "TransformInfos", "ItemResolveTemplates", "ItemResolveSortTemplates"], ["items", "item_transforms", "item_resolves", "recipe_materials"], ["STRENGTH", "STORE"], ["store"], ["equip/"])
mech("item_suite", "Conjuntos (sets)", "item", "Suite pieces grant bonuses by number of equipped pieces.", ["core_module"], ["SuiteTempInfos"], ["item_suites", "item_suite_pieces"], [], [], [])
mech("crafting", "Forja/composição", "item", "Composition recipes (up to 4 materials + gold) and fusions.", ["m14"], ["ComposeTempInfos", "AlchemyFormulaTemplates", "AlchemyMineTemplates"], ["item_compose_recipes", "recipe_materials"], ["COMPOSE"], [], [])
mech("fashion", "Moda (fashion)", "avatar", "Fashion parts (wing, hat/hair, weapon, outfit) that replace avatar layers on the map, in battle and in the UI; grant stats via skills and polishing.",
     ["core_module", "m14"], ["ItemTempInfos", "FashionPolishs"], ["fashion_items", "fashion_polish_levels", "avatar_layers", "avatar_layer_z_orders", "avatar_part_draw_orders", "avatar_resource_dirs", "battle_movie_parts", "animation_labels"], ["FASHION"], [], ["swf/avatar", "equip/", "equip_show/"])
mech("avatar", "Avatar e animações", "avatar", "Layered hero composition: map (.bswf S_/W_ with per-direction z-order), battle (synced MovieClips with labels) and UI (show front/back).",
     ["core_module", "m3"], [], ["avatar_layers", "avatar_layer_z_orders", "avatar_part_draw_orders", "animation_labels", "battle_movie_parts", "avatar_resource_dirs"], [], [], ["swf/avatar", "equip/", "equip_show/"])
mech("mount", "Montarias", "avatar", "Mounts with stats, speed, mount wing, flight, standing pose (IsStand) or _mount parts, stars and soul; own map animations.",
     ["core_module", "m14"], ["MountTempInfos"], ["mounts", "mount_animations", "avatar_resource_dirs"], ["MOUNT"], [], ["swf/avatar/mount"])
mech("dragon_talker", "Domador de dragões (montaria dragão)", "avatar", "Dragon mount shown in battle behind the hero, with grades and stats.", ["m5"], ["DragonTalkerFightMountTemplates"], ["dragon_battle_mounts", "mount_animations"], ["DRAGON"], ["dragontalker"], ["equip/dragonic"])
mech("pet", "Pets (Einherjar)", "companion", "Pets with quality, aptitudes, growth, follow/transform skills, fusion, contracts, relics and challenge.",
     ["m14"], ["PetTempInfos", "PetComponseInfos", "PetContracTempInfos", "PetHallowsTempInfos", "PetChallengeRewards", "RemotePetTempInfos"], ["pets", "pet_fusions", "pet_skill_links"], ["PET"], ["pet"], ["swf/avatar/pet", "equip/pet"])
mech("child", "Filhos", "companion", "Children with their own classes, summoning, growth, assist, camp, patrol and PvP.",
     ["m14"], ["ChildTempInfos", "ChildTypeTempInfos", "ChildComposeTempInfos", "ChildAssistUpgradeTemplates", "ChildCampTemps", "ChildPatrolMissionTempInfos", "ChildPvpTmpls", "ChildPvpRewardTmpls"], ["children"], ["CHILD"], ["children", "childpatrol"], ["equip/hychild"])
mech("goddess", "Deusas", "companion", "Goddesses with levels (240), steps/stars, devotion, equipment and united resistances; enter battle (4102) with faith.",
     ["m5"], ["GoddessTemplateInfos", "GoddessUpgradeTemplates", "GoddessStepTemplates", "GoddessDevoteTemplates", "GoddessEquipmentTempInfos", "GoddessUnitedResiTemplates", "GoddessUnitedSkillTemplates"], ["goddesses", "goddess_levels", "goddess_steps"], ["GODDESS"], [], ["goddess/"])
mech("vehicle", "Veículos", "companion", "Vehicle minigame with its own skills, buffs and objects.", ["m9"], ["VehicleObjectTempInfos", "VehicleSkillTempInfos", "VehicleBuffTempInfos"], ["vehicles", "vehicle_skills", "vehicle_buffs"], ["VEHICLE"], ["vehicle"], ["vehicle/"])
mech("artifact", "Artefatos", "item", "Legendary artifacts with aptitudes and stat conversion; emblem armory.", ["m11"], ["ArtifactTemplateInfos", "ArftiArmoryTemplateInfos"], ["artifacts"], ["ARTIFACT"], [], [])
mech("appellation", "Títulos (appell)", "social", "Titles earned by condition (ranking, event), shown next to the name, granting skills.", ["core_module"], ["AppellInfos"], ["appellations"], ["APPELL"], [], [])
mech("collection", "Coleção", "progression", "Collectibles album with stars, stats and sets.", ["m11"], ["CollectionTemplates", "CollectionSuitTemplates", "CollectionRewardTemplates"], ["collections"], ["COLLECTION"], [], [])
mech("vip", "VIP", "economy", "VIP levels with privileges (purchase limits, bonuses, appearance) and rewards.", ["m15"], ["VipPrerogativeTempInfos", "VipDrop", "FirstChargeItems"], ["vip_privileges"], ["VIP"], [], [])

mech("castle", "Castelo/cidade e prédios", "economy", "Buildings with levels, gold/crystal costs, production and city effects; troop recruiting.",
     ["m4", "core_module"], ["BuildingTempInfos", "BuildingResInfos", "EffectTempInfos", "MapPhysicsTempInfos"], ["buildings", "city_effects", "castle_building_art"], ["CASTLE", "BUILDING"], ["building", "castle"], ["mapmaterial/build"])
mech("leveling", "Níveis e experiência", "progression", "Per-level EXP/value tables for many systems (UpGradeTempInfos.Types).", ["core_module"], ["UpGradeTempInfos"], ["level_thresholds"], [], [], [])
mech("map", "Mapas e mundo", "pve", "World/outer city, campaign maps and instances; .maps/.titles data, tiles and battle backdrop.", ["m3"], ["MapInfos", "MapNodeInfos", "MapShopItemTemplateInfos"], ["maps", "map_nodes", "map_points", "map_bounds", "map_file_formats", "map_point_kinds"], ["MAP"], ["worldmap"], ["maps/", "mapmaterial/", "sceneima/"])
mech("campaign", "Campanhas e instâncias", "pve", "Campaigns (dungeons, map events, instances) with levels, prerequisites, schedules and rewards.", ["m3", "m13"], ["Campaigns", "CampaignData", "SingleCampaignDatas", "CampaignBufferTemps"], ["campaigns", "campaign_buffs"], ["CAMPAIGN"], ["campaign"], ["images/instanceimg"])
mech("exploration", "Modos de exploração", "pve", "Exploration modes: Minos, Eremitério (Secret*), Tesouro de Teseu (StoreHouse), Ruínas (RemainsExplore), Terra das Sombras, Expedição, Estrada dos Heróis, Terra Demoníaca, Estrada da Vingança, Quintal (HugeHead/StackHead), Jardim Aéreo, Área Estelar, Labirinto Sombrio, Estrada Final, Teste Celestial, Crise, Planos.",
     ["m3", "m6", "m11", "m14"], ["MinosLevelTmpls", "MinosNodeTmpls", "MinosRewardTmpls", "SecretMapLevelTemplates", "SecretSonLevelTemplates", "SecretMapDataTemplates", "SecretEventTemplates", "RemainsExploreChapterTemps", "RemainsExploreNodeTemps", "RemainsExploreEventTemps", "RemainsLeedTemps", "ShadowLandTemplates", "ExpeditionTemplates", "HeroRoadTempInfos", "EvilLandTemplates", "RevengeRoadTemplates", "HugeHeadMapNodeTempInfos", "StackHeadExploreTempInfos", "AirGardenNodeTemplates", "StarAreaRoadInfos", "DarkMazeLayerTemplates", "DarkMazeEventTemplates", "DarkMazeChildTemplates", "FinalRoadChapterTemplates", "FinalRoadGroupTemplates", "FinalRoadLevelTemplates", "FinalRoadEventTemplates", "SkyTrialLayerTempInfos", "SkyTrialPortalTempInfos", "SkyTrialEventTempInfos", "CrisisMapInfos", "CrisisEventInfos", "PlanesLayers", "PlanesEvents", "PlanesTemplates", "PlanesFuncTempInfos", "ExploreEventTemplates", "ArchaeologyBookTemps", "ArchaeologyItemTemps", "NavigationTaskTempInfos", "NavigationShopTempInfos", "EclipticPalaceTempInfos", "MagicSpringTempInfos", "LordTrialTempInfos", "GuardPVETemp"], ["crisis_map_nodes", "outyard_map_nodes", "monster_explore_nodes"], [], [], ["planeswar/"])
mech("boss", "Chefes mundiais e de guilda", "pve", "World boss, guild boss (new), forbidden boss, royalty boss, random boss.", ["m13", "m6"], ["ConsortiaBossTempInfos", "ConsortiaNewBossTemplates", "ForbiddenBossTemplates", "RoyaltyBossTemplates", "RandomBossBuffInfos"], [], ["BOSS"], ["forbiddenboss", "worldmap"], [])
mech("quest", "Missões", "progression", "Main, daily, guild and repeatable quests with conditions and rewards; guide and achievement tasks.",
     ["m15", "core_module"], ["QuestTemps", "QuestGoods", "QuestCondictionInfos", "RewardTemps", "RewardGoods", "RewardCondictionInfos", "GuideValueTemps", "AchievementTaskTemplates"], ["quests", "quest_conditions", "quest_reward_items"], ["U_C_QUEST", "QUEST"], ["quest", "reward"], [])
mech("drop", "Pacotes de drop e recompensas", "economy", "≈60 drop lists with a shared schema (package, position, range, item, count, bind, rarity).", ["core_module"], [], ["drop_entries"], ["REWARD"], ["reward"], [])
mech("shop", "Lojas", "economy", "Shops by type/area with several currencies (diamond, bound diamond, gold, honor, contribution, points), VIP limits and requirements.",
     ["m7", "core_module"], ["ShopTempInfos", "AllianceShopInfos", "ConsortiaShopTempInfos", "GameBoxShopTempInfos", "FurnitureShopTempInfos", "PoseidonShopTemplates", "ExploitsShopTemplates", "CommerceShopTemplates", "CarnivalPointExchangeTemplates"], ["shop_items"], ["SHOP", "MALL", "BAG_BUY"], ["shop", "mall"], [])
mech("guild", "Guilda (consortia) e aliança", "guild", "Guild levels and buildings, treasury, quests, shop, PvE, guild war, alliance privileges and activities.",
     ["m6"], ["ConsortiaLevelInfos", "ConsortiaTreasureTempInfos", "ConsortiaQuestTempInfos", "ConsortiaQuestConditionTempInfos", "ConsortiaShopTempInfos", "ConsortiaPveTemplates", "ConsortiaWarQuestTemplates", "AllianceActivityTasks", "AlliancePrivileges", "AllianceShopInfos"], ["guild_levels"], ["CONSORTIA"], ["consortia", "consortiawar", "consortiaplay"], [])
mech("pvp", "PvP e arenas", "pvp", "Arena dos Sonhos, colosseum, Ápice, Teseu PvP, royalty ranking, pet and child challenges.", ["m9", "m13"], ["DreamArenaTemplates", "RoyaltyTemplates", "PetChallengeRewards", "QuickPassRewards"], [], ["PVP", "APEX"], ["pvp", "apex"], [])
mech("social", "Social: casamento, amigos, correio", "social", "Marriage (MarrySpecTempInfos), friends/chat, mail and king contracts.", ["m9", "m12"], ["MarrySpecTempInfos", "KingContracts", "HeartTempInfos"], [], ["MARRY", "FRIEND", "MAIL"], ["marriage", "friend", "mail", "chat"], [])
mech("event", "Eventos e atividades", "event", "Seasonal events (Easter, Christmas, Carnival, 7th anniversary, New Year), daily activities, quizzes, first top-up, player return, lotteries.",
     ["m11", "m15"], ["EasterTemplates", "ChristmasLotteryTemplates", "ChristmasActivitiesTemplates", "ChristmasAnswersTemplates", "ChristmasAchievementsTemplates", "CarnivalDailyChallengeTemplates", "CarnivalLuckDrawTemplates", "CarnivalPlayGroundTemplates", "SevenYearAchievementTemplates", "SevenYearQuestionTemplates", "ActivityDailyTemplates", "QuestionTemplates", "FirstPayTemplates", "OlderRefluxTempInfos", "RegressTemplateInfos", "ShareTemplateInfos", "GameHallTemplates", "MagicPubNpcInfos", "MagicPubChatInfos", "FishTemplateInfos", "ShuttleTempInfos", "ShuttleRewardTempInfos", "CattoysTemplateInfos", "FurnitureTempInfos", "TitanTempInfos", "AssistantTemplates", "SpecialRewardTmpls"], [], ["ACTIVE"], ["active", "cccactive", "christmas"], ["icon/easter"])
mech("config", "Configuração global", "system", "ConfigInfos: ~990 config keys (daily limits, costs, unlocks) and top bar buttons.", ["core_module"], ["ConfigInfos", "TopToolBtnInfos"], ["config_entries"], [], [], [])
mech("protocol", "Protocolo de rede", "system", "TCP socket :5004 with opcodes and protobuf payloads; auxiliary AMF and HTTP. See protocol/socket.md.", ["core_module"], [], [], [], [], [])
mech("ui", "Telas e UI", "system", "1097 screens composed of PickGliss styles; pt-BR texts.", ["core_module", "m3", "m4", "m5", "m6", "m7", "m8", "m9", "m10", "m11", "m12", "m13", "m14", "m15", "m16", "m17", "m18"], [], [], [], [], ["ui/"])
