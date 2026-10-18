# Quest conditions (`QuestCondictionInfos.CondictionType`)

Area: quests, module `quest-conditions`. Covers every condition type of the "Missão" quests: how the client computes progress (`TaskTemplate.getProgress` `decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:443`), which event listeners refresh it (`addListenerTo` `:218`), where the "Ir" button navigates (`SwitchPageHelp.skipPageByTaskCondictionType` `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:90`), and what the server must count. Bounty and cycle quest conditions (`RewardCondictionInfos`) are a different enum, see [offer-reward.md](offer-reward.md) and [ring-task.md](ring-task.md).

Conventions: see [README.md](README.md).

## 1. Overview

Each quest has 1 to 4 condition rows (`QuestCondictionInfos`, 851 rows; 828 quests have one row). Condition `i` (0 based, in template order) maps to `QuestInfo.condition_{i+1}`. A quest is complete when every condition returns the text "(Concluído)" (`buildings.offerreward.data.BaseOfferReward.progress`, `TaskTemplate.isCompleted` `:401`). Two kinds of conditions exist:

- Client state: the client compares live player state with `Para1`/`Para2` (level, buildings, bag items, guild, runes, avenger state, ...). The server sends nothing for them but must re check the same state when the reward is claimed.
- Server counter: the client compares `condition_N` from the last 112 push with the goal (`checkCount` `:1248`: `condition_N >= Para2`; `checkCount2` `:925`: `condition_N >= Para1`; `checkShadowLand` `:1482`: `>= Para3`; `checkTheseusOne` `:1296`: `>= 1`). The server increments the counter when the action happens and pushes 112.

## 2. Screens

No screen of its own. Progress text appears in the quest frame target list (`TaskTargetViewII`), the trace bar (`TaskTraceItem.refreshCondition`) and the completion tip. Texts: "(Concluído)", "(Não concluído)", "(x / y)".

## 3. Routes (client to server)

None specific. Related: the "Ir" button navigation is client only; type 92 starts a shadow challenge with C>S 8635 (`SocketSendManager.challengeSelf` `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:537`, body `quest.QuestInfo` with `template_id` only; owner [campaign](../campaign/README.md)); type 48 uses the phone routes of [quest-log.md](quest-log.md).

## 4. Server messages (server to client)

Progress travels in S>C 112 `U_C_QUEST_UPDAT` (`QuestInfo.condition_1..4`), see [quest-log.md](quest-log.md) S1.

## 5. Rules and formulas

General parameter use (from the checkers and the navigation switch):

- `Para1`: sub target (building `SonType`, pawn `MasterType`, `CampaignId`, item template, node or boss id, rune type, novice process value, difficulty).
- `Para2`: goal (count, level); `Para1` for types 270 to 273; `Para3` for type 254.
- `Para3`: campaign id used by "Ir" for types 13 and 24 to 28.
- `Para4`: "mapId,nodeId" auto walk target; when not "0" it takes precedence over the per type navigation (`SwitchPageHelp.as:106-:117`; during the novice single campaign it walks to the next node instead). Quest 1801 always opens the dragon transfer campaign (`:118`).
- Navigation with no specific case falls back to opening the quest frame (callback of the trace item).
- Listener driven refresh for client state types: level (1), building upgrade (2), pawn upgrade (10), friends (21), player info (22), novice process (23), bag counts (27, 28, 32, 49, 94), guild offer (29), formation (34), castle transfer (37, falls through to 38), tower info (38), day change (39), guild info (51), rune upgrade (76, 78), dragon soul (95), mount (203), vocation (211, 213, 236, 238, 260), talent (212, 237), titan (215), `TASK_UPDATE` notification (217), revenge road (239), avenger body and skills (246, 255 to 259) (`TaskTemplate.as:218-:330`).

Catalog (169 codes: constants of `decompiled/core_module/scripts/yishi/datas/consant/TaskConditionType.as` plus codes used only by the switch or the data; names from `data/research/world_progression.json`). Example = first data row: "title" (Para1, Para2, Para3, Para4).

| Code | Name | What is counted or checked | Progress source | Rows | Example | "Ir" target |
|---:|---|---|---|---:|---|---|
| 1 | player_grade | hero level >= Para2 | client `checkPlayerGrades` | 33 | "Coletar Prêmio" (1, 1, 0, 0) | message only |
| 2 | building_or_tech_grade | building with SonType Para1 at level >= Para2 | client `checkBuildingOrTecGrades` | 45 | "Elevar Prefeitura" (901, 2, 0, 0) | building frame Para1 (`walkNext` while novice process < 19000) |
| 3 | recruit_pawns | pawns of type Para1 recruited, count Para2 | server, `condition_N >= Para2` | 6 | "Recrutar Lanceiro" (1, 200, 0, 0) | `gotoCasernFrame` |
| 4 | counter_4 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 5 | hero_job_grade | hero of job Para1 (0 any) at level >= Para2 | client `checkHeroGrades` | 0 |  | open quest frame |
| 6 | unused_6 | never completes (empty case) | none | 0 |  | open quest frame |
| 7 | occupy_outer_city_node | outer city node type Para1 occupied Para2 times | server, `condition_N >= Para2` | 2 | "Ocupar Mina de Ouro" (2006, 2, 0, 0) | `gotoOuterCity` |
| 8 | plunder_city | plunders Para2 times (Para1 0 any) | server, `condition_N >= Para2` | 3 | "Saquear Cidade" (0, 1, 0, 0) | `gotoOuterCity` |
| 9 | world_map_action | counter, no data rows | server, `condition_N >= Para2` | 0 |  | `gotoWorldMapFrame` |
| 10 | pawn_grade | any barracks pawn of MasterType Para1 at level >= Para2 | client `checkPawnGrades` | 5 | "Elevar Lanceiro" (1, 3, 0, 0) | `gotoUpgradePawnFrame` |
| 11 | counter_11 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | message only |
| 12 | speed_up_building_cd | building cooldown speed ups | server, `condition_N >= Para2` | 3 | "Acelerar Resfriamento de Construções" (1, 1, 0, 0) | message only |
| 13 | campaign_counter | counter, no data rows | server, `condition_N >= Para2` | 0 |  | `gotoCampaignById` |
| 14 | pass_campaign | campaign Para1 passed Para2 times | server, `condition_N >= Para2` | 88 | "Concluir Planície dos Furries" (1005, 1, 1005, 0) | `gotoCampaignById` |
| 15 | counter_15 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 16 | join_pvp_arena | PvP arena participations | server, `condition_N >= Para2` | 2 | "Participar da Arena" (1, 3, 0, 0) | `gotoPvpFrame` |
| 17 | strengthen_equipment | equipment strengthen operations (Para1 target level, assumption) | server, `condition_N >= Para2` | 2 | "Fortaleça Equipamento ao Nível 3" (2, 1, 0, 0) | `gotoStoreFrame` |
| 18 | inlay_gem | gem inlays | server, `condition_N >= Para2` | 1 | "Inserir Gema" (1, 1, 0, 0) | `gotoStoreFrame` |
| 19 | compose_gem | gem compositions | server, `condition_N >= Para2` | 1 | "Sintetizar Gema" (0, 1, 0, 0) | `gotoStoreFrame` |
| 20 | farm_energize | Yggdrasil energize (Para1 0 friend, 1 own) | server, `condition_N >= Para2` | 4 | "Energizar Amigo" (0, 2, 0, 0) | `gotoFarmFrame` |
| 21 | friend_count | friend list size >= Para2 | client `checkFriendsCount` | 2 | "Adicionar Amigo" (0, 1, 0, 0) | `gotoFriendFrame` |
| 22 | join_guild | member of a guild | client `checkJoinConsortia` | 2 | "Criar / Adicionar Guilda" (0, 1, 0, 0) | `gotoConsortiaFrame` |
| 23 | newbie_process | novice process >= Para1 | client `checkAttack` | 9 | "Exterminar os Furbolgs" (11600, 1, 1, 0) | `walkNext` |
| 24 | campaign_counter_24 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | `gotoCampaignById` |
| 25 | kill_campaign_monster | campaign node monster Para1 killed Para2 times (Para3 campaign) | server, `condition_N >= Para2` | 38 | "Eliminar Soldado Imortal" (2041, 4, 1004, 0) | `gotoCampaignById` |
| 26 | kill_campaign_boss | campaign boss node Para1 killed Para2 times (Para3 campaign) | server, `condition_N >= Para2` | 33 | "Eliminar o Lobo Maligno" (1011, 1, 1001, 0) | `gotoCampaignById` |
| 27 | collect_item_event | bag holds >= Para2 of item Para1 | client `checkGoodsCount` | 21 | "Coletar Letra “恭”" (2125006, 1, 0, 0) | `gotoCampaignById` |
| 28 | collect_campaign_drop | bag holds >= Para2 of drop item Para1 (Para3 campaign) | client `checkGoodsCount` | 13 | "Mel da Yggdrasil" (2125011, 3, 0, 0) | `gotoCampaignById` |
| 29 | guild_contribution_total | guild total contribution >= Para2 | client `checkConsortiaOffer` | 4 | "Contribuição da Guilda" (0, 10, 0, 0) | `gotoConsortiaFrame` |
| 30 | guild_pray | guild prayers | server, `condition_N >= Para2` | 1 | "Oração da Guilda" (0, 1, 0, 0) | `gotoConsortiaFrame` |
| 31 | pass_any_campaign | campaigns passed (Para1 1 single player, >1 hero door) | server, `condition_N >= Para2` | 4 | "Concluir Mapa Singleplayer" (1, 3, 0, 0) | `gotoSingleCampaign` |
| 32 | collect_resource_item | bag holds >= Para2 of resource item Para1 (collection scene NeedFightId) | client `checkGoodsCount` | 13 | "Coletar Madeira" (2100022, 20, 0, 0) | `gotoCollectScene` |
| 33 | client_download | playing from the desktop launcher (only with CLIENT_DOWNLAND) | client `checkClientLogin` | 2 | "Utilizar o Dispositivo de Login" (0, 1, 0, 0) | open quest frame |
| 34 | adjust_formation | formation adjusted (ArmyManager.isSorted) | client `checkSortPawn` | 2 | "Ajustar Formação" (0, 1, 0, 0) | `gotoLineupFrame` |
| 35 | colosseum_challenge | colosseum challenges | server, `condition_N >= Para2` | 3 | "Desafio" (1, 3, 0, 0) | `gotoColosseumFrame` |
| 36 | astrology_cosmos | astrology draws | server, `condition_N >= Para2` | 3 | "Astrologia" (1, 1, 0, 0) | `gotoStarFrame` |
| 37 | reach_world_map | hero on world map Para2 | client `checkMapId` | 5 | "Ir aos Pastos Livres" (0, 1, 0, 0) | open quest frame |
| 38 | maze_floor | maze highest floor >= Para2 | client `checkMazeRecord` | 3 | "Atacar Labirinto Subterrâneo" (8001, 2, 0, 0) | `gotoMazeFrame` |
| 39 | double_login | logged in on a day other than the accept day | client `checkSencondLogin` | 1 | "Login Duplo" (0, 1, 0, 0) | message only |
| 40 | world_boss_battle | world boss battles | server, `condition_N >= Para2` | 2 | "Batalhar com Chefão Global" (0, 10, 0, 0) | `gotoWorldBossFrame` |
| 41 | world_boss_damage | world boss damage dealt | server, `condition_N >= Para2` | 1 | "Acumular Dano" (0, 50000, 0, 0) | `gotoWorldBossFrame` |
| 42 | collect_tax | tax collections | server, `condition_N >= Para2` | 1 | "Coletar Impostos" (0, 1, 0, 0) | `gotoOfficeFrame` |
| 43 | recharge | counter, no data rows | server, `condition_N >= Para2` | 0 |  | recharge page |
| 44 | join_battlefield | battlefield participations | server, `condition_N >= Para2` | 3 | "Participar do Campo de Batalha" (0, 1, 0, 0) | `gotoWorldFightFrame` |
| 45 | battlefield_kills | battlefield kills | server, `condition_N >= Para2` | 3 | "Eliminar o Campo de Batalha" (0, 70, 0, 0) | `gotoWorldFightFrame` |
| 46 | decompose_equipment | equipment decompositions | server, `condition_N >= Para2` | 1 | "Decompor Equipamento" (0, 1, 0, 0) | `gotoStoreFrame` |
| 47 | purify_equipment | equipment refines | server, `condition_N >= Para2` | 1 | "Purificar Equipamento" (0, 1, 0, 0) | `gotoStoreFrame` |
| 48 | phone_check | phone number verified (only with MOBILE_TASK) | server, `condition_N >= Para2` | 1 | "Preecher Número de Celular e Autenticação" (0, 1, 0, 0) | open quest frame |
| 49 | hold_item | bag holds >= Para2 of item Para1 | client `checkGoodsCount` | 16 | "Essência da Yggdrasil" (2125012, 5, 0, 0) | message only |
| 50 | battlefield_win | battlefield wins | server, `condition_N >= Para2` | 4 | "Vitória no Campo de Batalha" (0, 1, 0, 0) | `gotoWorldFightFrame` |
| 51 | guild_building_grade | guild level (Para1 1 guild, 2 shop, 3 altar, 4 school, 5 warehouse) >= Para2 | client `checkConsortuaGrade` | 2 | "Nível da Guilda" (1, 2, 0, 0) | `gotoConsortiaFrame` |
| 52 | star_bag_action | star bag actions | server, `condition_N >= Para2` | 1 | "Características da Apercepção do Soldado" (0, 2, 0, 0) | none |
| 53 | lock_star | cosmos locks | server, `condition_N >= Para2` | 1 | "Travar Cosmo" (0, 1, 0, 0) | `gotoStarBagFrame` |
| 54 | offer_reward_counter | counter, no data rows | server, `condition_N >= Para2` | 0 |  | `gotoOfferRewardFrame` |
| 55 | day_guide_counter | counter, no data rows | server, `condition_N >= Para2` | 0 |  | `gotoDayGuideFrame` |
| 56 | auction | auction listings | server, `condition_N >= Para2` | 1 | "Leiloar" (0, 1, 0, 0) | `gotoMarkeFrame` |
| 57 | blessing_roulette | blessing roulette spins | server, `condition_N >= Para2` | 1 | "Roleta da Benção" (0, 1, 0, 0) | `gotoSeminaryFrame` |
| 58 | soul_seal | soul seals | server, `condition_N >= Para2` | 1 | "Selo da Alma" (0, 1, 0, 0) | `gotoBagFrame` |
| 59 | farm_plant | farm plantings | server, `condition_N >= Para2` | 3 | "Plantar na Fazenda" (0, 1, 0, 0) | `gotoFarmFrame` |
| 60 | farm_harvest | farm harvests (Para1 0 own, 1 friend) | server, `condition_N >= Para2` | 4 | "Coletar a sua Fazenda" (0, 2, 0, 0) | `gotoFarmFrame` |
| 61 | farm_kill_worms | farm pest kills | server, `condition_N >= Para2` | 2 | "Exterminação na Fazenda" (1, 2, 0, 0) | `gotoFarmFrame` |
| 62 | counter_62 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 63 | activity_points | daily activity points reached (Para2) | server, `condition_N >= Para2` | 1 | "Nível de Atividade" (0, 20, 0, 0) | `gotoDayGuideFrame` |
| 64 | alchemy | alchemy completions | server, `condition_N >= Para2` | 1 | "Completar Alquimia" (0, 3, 0, 0) | open quest frame |
| 65 | summon | summons | server, `condition_N >= Para2` | 1 | "Completar Convocação" (0, 3, 0, 0) | open quest frame |
| 66 | world_boss_revive | world boss revives | server, `condition_N >= Para2` | 1 | "Ressuscitação Chefão Global" (0, 3, 0, 0) | open quest frame |
| 67 | counter_67 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 68 | counter_68 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 69 | counter_69 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 70 | counter_70 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 71 | train_mount | mount trainings | server, `condition_N >= Para2` | 1 | "Adestrar Montaria" (0, 1, 0, 0) | `gotoMounts` |
| 72 | counter_72 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 74 | enter_trial_tower | trial tower entries | server, `condition_N >= Para2` | 1 | "Entrar na Torre do Julgamento" (0, 1, 0, 0) | `gotoHeroDoor` |
| 75 | counter_75 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 76 | learn_rune | rune Para1 learned at level >= Para2 (Para1 0: number of runes learned) | client `checkRuneStudy` | 2 | "Aprender Runa da Fúria" (2, 1, 0, 0) | `gotoRunnesSkill` |
| 77 | absorb_rune | runes absorbed (Para1 rune item or 0) | server, `condition_N >= Para2` | 3 | "Absorver Runa Básica" (3020010, 5, 0, 0) | `gotoRunnesSkill` |
| 78 | rune_grade | rune Para1 (0 best) level >= Para2 | client `checkRuneGrade` | 6 | "Elevar Runa" (0, 3, 0, 0) | `gotoRunnesSkill` |
| 79 | join_timed_event | timed event participations (Matança de Madrugada) | server, `condition_N >= Para2` | 3 | "Participar do evento Matança de Madrugada" (0, 1, 0, 0) | `gotoDayLight` |
| 80 | win_timed_event | timed event wins | server, `condition_N >= Para2` | 3 | "Vencer no Julgamento TM" (0, 1, 0, 0) | `gotoDayLight` |
| 81 | counter_81 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 82 | counter_82 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 85 | talk_to_npc | NPC dialog finished on the client (finishStory flag, Para4 NPC node) | client `checkFinishPetStory` | 29 | "Conversar com o guarda" (0, 1, 0, 10000,9) | open quest frame |
| 86 | amethyst_battle | amethyst field battles | server, `condition_N >= Para2` | 1 | "Batalha das Ametistas" (0, 1, 0, 0) | `gotoMineField` |
| 87 | join_einherjar_arena | Einherjar arena participations | server, `condition_N >= Para2` | 2 | "Participa na Arena de Einherjar" (0, 1, 0, 10000,3) | open quest frame |
| 88 | obtain_einherjar | Einherjar obtained | server, `condition_N >= Para2` | 1 | "Obter Einherjar" (0, 1, 0, 0) | open quest frame |
| 89 | dig_treasure | treasure digs | server, `condition_N >= Para2` | 1 | "Participe para Escavar Tesouro" (0, 1, 0, 0) | open quest frame |
| 90 | insert_guard_crystal | guard crystals inserted | server, `condition_N >= Para2` | 1 | "Inserir Cristais de Proteção" (0, 1, 0, 0) | `openBattleGuardFrame` |
| 91 | treasure_hunt | treasure hunts | server, `condition_N >= Para2` | 1 | "Caça ao Tesouro" (0, 1, 0, 0) | `gotoTreasureHunt` |
| 92 | challenge_shadow | shadow challenges (started from the quest with 8635) | server, `condition_N >= Para2` | 6 | "Desafiar a sua Sobra 1 vez" (50, 1, 0, 0) | `challengeSelf(TemplateId)` (8635) |
| 93 | sky_road_win | sky road wins | server, `condition_N >= Para2` | 1 | "Vitória na Batalha do Caminho do Céu" (0, 1, 0, 10000,20) | open quest frame |
| 94 | hold_item_94 | bag holds >= Para2 of item Para1 | client `checkGoodsCount` | 0 |  | `gotoWorldFightFrame` |
| 95 | dragon_soul_grade | dragon soul grade >= Para2 (or dragon soul type 102) | client `checkDragonSoulGrade` | 5 | "Elevar para o nível Alma do Dragão Filhote" (0, 1, 0, 0) | `gotoDragonSoulFrame` |
| 96 | refine_mount | mount refines | server, `condition_N >= Para2` | 1 | "Refinar Montaria" (0, 1, 0, 0) | `gotoMountsFrame` |
| 97 | monopoly_complete | cloud adventure completions | server, `condition_N >= Para2` | 1 | "Completar Aventura em Nuvem" (0, 1, 0, 0) | `gotoMonopolyFrame` |
| 98 | monopoly_move | cloud adventure moves | server, `condition_N >= Para2` | 1 | "Movimento da Aventura em Nuvem" (0, 1, 0, 0) | `gotoMonopolyFrame` |
| 99 | monopoly_event | cloud adventure battles | server, `condition_N >= Para2` | 1 | "Combate Normal Aventura em Nuvem" (1, 3, 0, 0) | `gotoMonopolyFrame` |
| 201 | vip_activity_points | VIP activity points | server, `condition_N >= Para2` | 1 | "Nível de Atividade" (0, 5, 0, 0) | open quest frame |
| 202 | misc_event_action | misc event actions selected by Para1 | server, `condition_N >= Para2` | 4 | "Placa Exemplar" (1, 3, 0, 0) | open quest frame |
| 203 | mount_soul_grade | mount grade >= Para2 | client `checkMountSoulGrades` | 4 | "Fera alcançou 5ª ordem" (0, 5, 0, 0) | `gotoMountsFrame` |
| 204 | mount_counter | counter, no data rows | server, `condition_N >= Para2` | 0 |  | `gotoMountsFrame` |
| 205 | mount_king_grade | any king mount grade >= Para2 | client `checkMountKingGrade` | 0 |  | `gotoMountsFrame` |
| 206 | counter_206 | counter, no data rows | server, `condition_N >= Para2` | 0 |  | open quest frame |
| 207 | perkinlab_build | Perkin lab builds | server, `condition_N >= Para2` | 1 | "Entrar no Laboratório de Platina" (0, 1, 0, 0) | `gotoPerkinLabFrame` |
| 208 | perkinlab_rob | Perkin lab robberies | server, `condition_N >= Para2` | 1 | "Saquear uma vez o laboratório de platina de outros jogadores" (0, 1, 0, 0) | `gotoPerkinLabFrame` |
| 209 | add_tattoo | tattoo purifications | server, `condition_N >= Para2` | 1 | "Purificar uma tatuagem" (0, 1, 0, 0) | `gotoTattooFrame` |
| 210 | replace_tattoo_attribute | tattoo attribute replacements | server, `condition_N >= Para2` | 1 | "Purificar tatuagens já existentes" (0, 1, 0, 0) | `gotoTattooFrame` |
| 211 | vocation_grade | evolution level 80 reached or job advanced | client `checkVocationGrade` | 1 | "Nível de Evolução atingir nível máximo" (0, 1, 0, 0) | open quest frame |
| 212 | talent_grade | talent 179 and advanced talent 50 | client `checkTalentLvl` | 1 | "Nível de Dom Natural atingir nível máximo" (0, 1, 0, 0) | `gotoMarkingSkill` |
| 213 | complete_change_job | job branch chosen (vocationIndex > 0) | client `checkChooseBranch` | 1 | "Efetuar avanço de profissão" (0, 1, 0, 10000,25) | open quest frame |
| 214 | child_patrol | guardian patrols | server, `condition_N >= Para2` | 1 | "Completar a missão de patrulha do Guardião Escolhido x1" (0, 1, 0, 0) | `gotoChild` |
| 215 | titan_level | titan star level >= Para2 | client `checkTitanLevel` | 2 | "Adestrar o nível de Titã até nv.1" (0, 10, 0, 0) | open quest frame |
| 216 | navigation_trade | navigation trades | server, `condition_N >= Para2` | 1 | "Efetuar uma vez navegação" (0, 1, 0, 0) | `gotoFarmFrame` |
| 217 | marry | married (state 3) | client `checkWhetherMarry` | 1 | "Casar" (0, 1, 0, 0) | visit space NPC 22 |
| 218 | titan_inject | titan injections | server, `condition_N >= Para2` | 1 | "Poder de Espírito de Titã" (0, 1, 0, 0) | `gotoTitanInject` |
| 219 | outyard_titan | titan temple runs | server, `condition_N >= Para2` | 1 | "Santuário de Titã" (0, 1, 0, 0) | `openTitanTemple` |
| 220 | glory_road | glory road stage completions | server, `condition_N >= Para2` | 1 | "Conclusão da 1ª fase do Caminho da Glória" (1, 1, 1, 0) | `walkToCrossMapTarget` |
| 221 | star_sublime | cosmos sublimations | server, `condition_N >= Para2` | 1 | "Ativação do elevamento de cosmos" (1, 1, 1, 0) | `gotoStarFrame` |
| 222 | outyard_shuttle | time portal challenges | server, `condition_N >= Para2` | 1 | "Desafiar  Portal do Tempo" (1, 1, 1, 0) | `openShuttleFrame` |
| 223 | magic_pub | magic pub NPC talks | server, `condition_N >= Para2` | 1 | "Fale com o NPC do Bar da Fantasia." (0, 1, 0, 0) | `gotoMagicPub` |
| 224 | dragontalker_challenge | dragon talker challenges | server, `condition_N >= Para2` | 1 | "Se desafiar nas Cavernas do Tempo" (0, 5, 0, 0) | `openTimeVortexFrame` |
| 225 | child_explore | guardian wanted fights | server, `condition_N >= Para2` | 1 | "Derrotar monstros numa Posição de Guardião Procurado" (0, 1, 0, 0) | `gotoChild` |
| 226 | star_gazing | star gazing draws | server, `condition_N >= Para2` | 1 | "Pedir aos Deuses na Astronomia" (0, 1, 0, 0) | `openStarGazingFrame` |
| 227 | planes_explore | plane crisis explorations | server, `condition_N >= Para2` | 1 | "Explorar no Plano de Crise uma vez" (0, 1, 0, 10000,44) | open quest frame |
| 228 | ecliptic_palace | ecliptic palace wins | server, `condition_N >= Para2` | 1 | "Vencer um combate no Templo Elíptico" (0, 1, 0, 10000,45) | open quest frame |
| 229 | goddess_task | goddess activations | server, `condition_N >= Para2` | 1 | "Ativar uma Deusa" (0, 1, 0, 0) | open quest frame |
| 230 | demonland_task | demon land chapter Para1 progress | server, `condition_N >= Para2` | 1 | "Ir salvar o Continente dos Demônios e completar o primeiro capítulo." (1, 10, 0, 10000,46) | open quest frame |
| 231 | monster_explore_boss | monster expedition boss challenges | server, `condition_N >= Para2` | 1 | "Desafiar 1 boss da Expedição Monstruosa" (0, 1, 0, 0) | `goSpaceAndFind(48)` |
| 232 | monster_call | monster summons | server, `condition_N >= Para2` | 1 | "Invocar 1 monstro" (0, 1, 0, 0) | `openMonsterFrame` |
| 233 | monster_cook | monster cooking | server, `condition_N >= Para2` | 1 | "Fazer 1 comida" (0, 1, 0, 0) | `openMonsterFrame` |
| 234 | monster_train | monster feeding | server, `condition_N >= Para2` | 1 | "Alimentar 1 monstro" (0, 1, 0, 0) | `openMonsterFrame` |
| 235 | monster_evolve | monster evolutions | server, `condition_N >= Para2` | 1 | "Evoluir 1 monstro" (0, 1, 0, 0) | `openMonsterFrame` |
| 236 | avenger_grade | avenger evolution level 80 and job advanced | client `checkAvengerGrade` | 1 | "Nível de Título atingir nível máximo" (0, 1, 0, 0) | open quest frame |
| 237 | avenger_talent | talent level >= Para2 after job advance | client `checkAvengerTalentLvl` | 1 | "Nível de Dom Natural atingir nível 40" (0, 40, 0, 0) | `gotoMarkingSkill` |
| 238 | avenger_transfer | job index >= 3 (Divine class) | client `checkAvengerComplete` | 1 | "Avançar para Classe Divindade" (0, 1, 0, 10000,25) | open quest frame |
| 239 | revenge_road | revenge road node >= 10 | client `checkRevengeCurrentId` | 1 | "Complete o Capítulo 1 do Caminho da Vingança" (0, 1, 0, 10000,51) | `gotoRevengeRoad` |
| 240 | consortia_want | guild wanted hunts | server, `condition_N >= Para2` | 1 | "Desafie a Caçada da Guilda 1 vezes" (0, 1, 0, 0) | `openGuildWantedFrame` |
| 241 | redemption_road | redemption road wins | server, `condition_N >= Para2` | 1 | "Vença 1 combates do Caminho da Salvação" (0, 1, 0, 10000,50) | `gotoRedeptionRoad` |
| 242 | inject_spirit | spirit treasure infusions | server, `condition_N >= Para2` | 1 | "Faça 1 infusões de energia em qualquer tesouro dos Espíritos de Proteção" (0, 1, 0, 0) | `openInjectSpirit` |
| 243 | strengthen_goddess | goddess accessory strengthens | server, `condition_N >= Para2` | 1 | "Fortaleça 1 vezes qualquer Acessório da Deusa" (0, 1, 0, 0) | `openStrengthenGodess` |
| 244 | advance_goddess | goddess accessory advances | server, `condition_N >= Para2` | 1 | "Avance 1 vezes com qualquer Acessório da Deusa" (0, 1, 0, 0) | `openAdvanceGodess` |
| 245 | potential_training | potential trainings | server, `condition_N >= Para2` | 1 | "Participe do Treino Potencial 1 vezes" (0, 1, 0, 0) | `openPotential` |
| 246 | revenge_soul | avenger degree >= 1 | client `checkRevengeSoul` | 1 | "Eleve o Caminho da Vingança até o nível 1" (0, 1, 0, 0) | `openRevengeSoul` |
| 247 | advance_revenge_skill | avenger skill evolutions | server, `condition_N >= Para2` | 1 | "Evolua quaisquer 1 habilidades do Vingador 1 vezes" (0, 1, 0, 0) | `openAdvanceRevengeSkill` |
| 248 | avenger_childns_grade | guardian spirit blade level (counter >= Para2) | server, `condition_N >= Para2` | 1 | "Lâmina de um Espírito de Proteção atingir Nv. 10" (0, 10, 0, 0) | `openAdvanceRevengeSkill` |
| 249 | avenger_childns_stage | guardian spirit blade stage (counter >= Para2) | server, `condition_N >= Para2` | 1 | "Lâmina de um Espírito de Proteção atingir Nv. 1" (0, 1, 0, 0) | `openAdvanceRevengeSkill` |
| 250 | avenger_passive_skill | guardian spirit passive skills learned | server, `condition_N >= Para2` | 1 | "Espírito aprender habilidades ativas da Lâmina do Espírito de Proteção" (0, 1, 0, 0) | `openAdvanceRevengeSkill` |
| 251 | avenger_active_skill | guardian spirit active skills learned | server, `condition_N >= Para2` | 1 | "Espírito aprender habilidades passivas da Lâmina do Espírito de Proteção" (0, 1, 0, 0) | `openAdvanceRevengeSkill` |
| 252 | child_camp | guardian camp lodgings | server, `condition_N >= Para2` | 1 | "Alojar 1 vez no Espírito de Proteção ao combate" (0, 1, 0, 0) | `openYLExpeditionFrame` |
| 253 | spirit_expedition | spirit expedition wins | server, `condition_N >= Para2` | 1 | "Vencer 1 batalha na Expedição do Espírito de Proteção" (0, 1, 0, 0) | `openSpiritExpeditionFrame` |
| 254 | shadow_land | shadow land stages of difficulty Para1 chapter Para2, goal Para3 | server, `condition_N >= Para3` | 3 | "Concluir Terra Sombria Fase 1 do Cap. 1" (1, 1, 1, 0) | `openShadowLandFrameByTask` |
| 255 | holy_grade | holy evolution level 30 as avenger | client `checkHolyGrade` | 1 | "Elevar os Olhos da Verdade para o nível 30" (0, 30, 0, 0) | `openAdvanceRevengeSkill` |
| 256 | holy_body_skill | 6 avenger skills at grade >= Para2 | client `checkAvengerAllSkill` | 1 | "Atingir nv. 3 em todas as habilidades do Corpo de Julgamento" (0, 3, 0, 0) | `openAdvanceRevengeSkill` |
| 257 | holy_soul | avenger body degree >= Para2 | client `checkAvengerSoulDegree` | 1 | "Caminho da Vingança atingir nv. 10" (0, 10, 0, 0) | `openAdvanceRevengeSkill` |
| 258 | holy_devil_armor_grade | devil armor grade >= Para2 | client `checkDevilArmorGrade` | 1 | "Atingir nível 5 da Armadura Demoníaca" (0, 5, 0, 0) | `openAdvanceRevengeSkill` |
| 259 | holy_devil_armor_hole | 6 devil armor holes at grade >= Para2 | client `checkDevilArmorHole` | 1 | "Todos os níveis do Buraco Mítico atingirem nível 10" (0, 10, 0, 0) | `openAdvanceRevengeSkill` |
| 260 | holy_transfer | holy class reached | client `checkHolyComplete` | 1 | "Avançar para Classe Consagrada" (0, 0, 0, 10000,25) | open quest frame |
| 261 | theseus_level | royalty level >= Para2 | client `checkTheseusLv` | 40 | "Nível de Realeza atingir Nv. 1" (0, 1, 0, 0) | open quest frame |
| 262 | theseus_boss_fight | forbidden zone boss Para1 fought Para2 times | server, `condition_N >= Para2` | 41 | "Lutar uma batalha com o chefe da Zona Proibida Sombras de Kroraina" (31001, 1, 0, 0) | open quest frame |
| 263 | theseus_boss_kill_guild | forbidden zone boss Para1 killed by the guild Para2 times | server, `condition_N >= Para2` | 41 | "Derrotar o Chefão da Zona Proibida Sombras de Kroraina (estando na mesma Guilda do Possessor do Prêmio)" (31001, 1, 0, 0) | open quest frame |
| 264 | theseus_equip_one | Theseus item Para2 equipped (server sets the counter to 1) | server, `condition_N >= 1` | 36 | "Usar Equipamento de Teseu - Arma da Água Nv.3" (0, 7211003, 0, 0) | open quest frame |
| 265 | theseus_equip_suit | Theseus suit part Para3 of series Para1 at level >= Para2 | server, `condition_N >= Para2` | 106 | "Todos os equipamentos do Conjunto de Arma da Água com Nv. 3" (1, 3, 1, 0) | open quest frame |
| 266 | theseus_war_intent | all war intent parts at level >= Para2 | server, `condition_N >= Para2` | 10 | "Todas as partes de Intenção de Guerra atingir nv. 5" (0, 5, 0, 0) | open quest frame |
| 267 | secret_adventure | secret adventure map Para1 passed | client `checkSecretCount` | 4 | "Passar da Domínio do Fogo" (1, 0, 0, 0) | open quest frame |
| 268 | warsoul_tower_level | war soul tower floor >= Para2 | client `checkWarSoulTowerLevel` | 22 | "Passar pelo 10º andar da Torre da Guerra" (0, 10, 0, 0) | open quest frame |
| 269 | final_road_chapter | final road difficulty Para2 passed | client `checkFinalRoadChapter` | 3 | "Passar no Caminho Final na Dificuldade Fácil" (0, 1, 0, 0) | open quest frame |
| 270 | rune_stone_slot | rune stone slots opened (goal Para1) | server, `condition_N >= Para1` | 1 | "Ative o slot de qualquer Runa" (1, 0, 0, 0) | `openControllerByInfo` |
| 271 | rune_stone_draw | rune stone draws (goal Para1) | server, `condition_N >= Para1` | 1 | "Sortear Runas 1 vez no Templo das Runas" (1, 0, 0, 0) | `openControllerByInfo` |
| 272 | rune_stone_insert | rune stones inserted (goal Para1) | server, `condition_N >= Para1` | 1 | "Incrustar 1 Runa em qualquer slot de Runa" (1, 1, 0, 0) | `openControllerByInfo` |
| 273 | secret_war_battle | secret war battles (goal Para1) | server, `condition_N >= Para1` | 1 | "Completar 1 Batalha do Eremitério" (1, 0, 0, 0) | `openControllerByInfo` |
Server counter semantics: every "server" row is one counter per accepted quest condition. When the player performs the action described, the server increments `condition_N` of every accepted, incomplete quest whose condition `N` has that type and whose `Para1` matches (or is 0 when the type uses `Para1` as a filter), caps it at the goal, and pushes 112 for the changed quests. Counters only count actions done after the quest was accepted (assumption, consistent with `add_date`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/QuestCondictionInfos.xml` (851 rows, `TaskCondictionTemplateResolve`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1434`) | `TaskCondictionTemplate` (`decompiled/core_module/scripts/mvc/module/task/TaskCondictionTemplate.as`) | `TemplateId` (quest), `CondictionType`, `CondictionTitle` (pt-BR text shown in the target list), `Para1`, `Para2`, `Para3` (ints), `Para4` (string "mapId,nodeId" or "0") |

## 7. Persistent state

Counters live in `quests.quest_progress` ([quest-log.md](quest-log.md) section 7): one row per accepted quest with `condition_1..4`. Optional dispatch index:

```sql
CREATE TABLE quests.condition_template (
    quest_id        integer  NOT NULL,
    condition_index smallint NOT NULL CHECK (condition_index BETWEEN 0 AND 3),
    condition_type  smallint NOT NULL,
    para1           integer  NOT NULL DEFAULT 0,
    para2           integer  NOT NULL DEFAULT 0,
    para3           integer  NOT NULL DEFAULT 0,
    para4           text     NOT NULL DEFAULT '0',
    PRIMARY KEY (quest_id, condition_index)
);
CREATE INDEX condition_template_type_idx ON quests.condition_template (condition_type, para1);
```

Loaded from the XML at boot (or kept in memory only).

## 8. Backend implementation notes

- `quests::conditions::record(player, condition_type, para1, amount)`: the single entry point called by every owning feature (campaign, battle, smith, farm, guild, runes, mounts, monsters, avenger, Theseus, ...). Looks up accepted quests with a condition of that type, applies the `Para1` filter, increments, caps, persists and pushes 112. Called inside the transaction of the owning action.
- `quests::conditions::evaluate(player, quest)`: server side mirror of the client checkers for client state types (level, building level, bag counts, guild membership and levels, friends, rune grades, dragon soul, mount, vocation, talent, titan, marriage, avenger and holy states, royalty level, war soul tower, final road, secret adventure). Used by the turn in handler; refuse the turn in when it fails.
- Type 85 (talk to NPC) has no server signal in this client: the dialog sets a client flag only. Assumption: accept the turn in when the quest has been accepted (optionally require that the player stood on the `Para4` node).
- Types 33 and 48 are hidden unless `CLIENT_DOWNLAND` / `MOBILE_TASK` is enabled in the client config; with both disabled these quests never show (`TaskCategory.addAccepted` `decompiled/core_module/scripts/mvc/module/task/TaskCategory.as:71`).
- Type 6 never completes; avoid it in data.

## 9. Open questions and assumptions

- Exact counted action for several types is inferred from titles (17 strengthen target level, 36 cosmos amount, 202 misc actions, 230 demon land progress).
- Whether counters include actions done before acceptance is unknown (assumption: no).
- Type 85 validation (assumption above).

## 10. Implementation checklist

- [ ] `record` API and calls from every owner listed in the catalog
- [ ] `evaluate` for every client state type
- [ ] Para1 filter rules per type
- [ ] Caps at the goal and 112 push
- [ ] Test: multi condition quest (4 rows), checkCount2 types use Para1, type 254 uses Para3, type 264 counter 1
