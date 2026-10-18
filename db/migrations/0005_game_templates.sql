SET search_path = game, client, raw, meta, public;

CREATE TABLE game.hero_ais (
  id integer NOT NULL,
  skill_sequence integer[],
  crazy_skill_id integer,
  bottom_skill_id integer,
  bottom_skill_ids integer[],
  dead_skill_id integer,
  less_hp_skill_id integer,
  angry_skill_id integer,
  awaken_skill_id integer,
  soldiers_raw text,
  change_skill_ids integer[],
  change_icon text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.hero_ais IS 'Roteiro de IA de heróis NPC/bosses: sequência de skills por turno e skills especiais por gatilho (HP baixo, morte, fúria, despertar) e tropas que acompanham. Origem: tempinfos.xml/HeroAis.';
COMMENT ON COLUMN game.hero_ais.id IS 'Id da IA (GameHeroTemp.AI / PawnTempInfos.AI). ID da IA (8.080 linhas; 100…904510403). Referenciado por GameHeroTemp.AI e PawnTempInfos.AI: 7.774 IDs usados, 306 órfãos. [decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:6] XML: HeroAis.ID';
COMMENT ON COLUMN game.hero_ais.skill_sequence IS 'Sequência cíclica de SkillTempInfo ids usada a cada ação (CSV terminado em vírgula). CSV ordenado (vírgula final) de SkillTempInfos.TemplateId: a rotação de habilidades por ação, cíclica (suposição; o servidor executa). Ex.: Lanceiro AI 100 = ''10,11,10,11,…'' (Ataque Normal e Ataque Forte alternados); Sacerdote AI 500 = ''50,50,50,50,51,50,50,51,50,50''. Tamanho de 2 a 12+ (3 é o mais comum, 3.416 linhas). De 33.318 referências, 979 não existem em SkillTempInfos (ex.: 650062 ×66). O cliente só junta tudo em getSkills() para pré-carregar. [decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:33] XML: HeroAis.Skills';
COMMENT ON COLUMN game.hero_ais.crazy_skill_id IS 'Skill de fúria/berserk. Skill de ''fúria/enrage'' do chefe (suposição: usada após certo número de rodadas). 2.420 linhas ≠ 0; 9 valores, ex.: 60997 ''Fúria'' (1.196), 3860000 ''Grande jogada do chefe da guilda'' (1.167), 650493 ''Transformação de Monstro''. [decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:39] XML: HeroAis.CrazySkill';
COMMENT ON COLUMN game.hero_ais.bottom_skill_id IS 'Skill de fundo/passiva principal. Skill disparada quando o chefe chega ao ''fundo'' (HP baixo / última resistência, suposição). 336 linhas ≠ 0; 76 valores, ex.: 60172 ''Múmia b (Chefão) Restaurar'', 60205 ''Fúria da Morte''. [decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:40] XML: HeroAis.BottomSkill';
COMMENT ON COLUMN game.hero_ais.bottom_skill_ids IS 'Lista de skills de fundo. Rotação alternativa (CSV de skill ids) usada depois que o chefe entra no estado ''fundo'' (suposição). 437 linhas preenchidas; ''0,'' = vazio. [decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:41] XML: HeroAis.BottomSkills';
COMMENT ON COLUMN game.hero_ais.dead_skill_id IS 'Skill disparada ao morrer. Skill ao morrer; sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:42] XML: HeroAis.DeadSkill';
COMMENT ON COLUMN game.hero_ais.less_hp_skill_id IS 'Skill disparada com HP baixo (valor pode ser limiar %). 0 em 8.077 linhas e 40 em 3 (AI 11811, ''Sacrifício de Sofia''). O cliente trata como skill id (40 = ''Ataque Normal''), mas pode ser um limiar de HP de 40% (suposição). [decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:43] XML: HeroAis.LessHpSkill';
COMMENT ON COLUMN game.hero_ais.angry_skill_id IS 'Skill de raiva. Skill de raiva; sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/HeroAisTemplate.as:44] XML: HeroAis.AngrySkill';
COMMENT ON COLUMN game.hero_ais.awaken_skill_id IS 'Skill de despertar (awaken). Skill de ''despertar'' que convoca as tropas de Soldiers: preenchida exatamente nas mesmas 144 linhas que Soldiers. 26 valores, ex.: 6190001 (61), 60183 ''Anjo Demônio Convocação'', 60263 ''Convocação da Tina''. O cliente pré-carrega as skills das tropas convocadas (getAwakenSkillByAi). [decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:690] XML: HeroAis.AwakenSkill';
COMMENT ON COLUMN game.hero_ais.soldiers_raw IS 'Tropas: ''pawnId,pos|pawnId,pos'' (ver game.hero_ai_soldiers). Tropas convocadas: ''pawnTemplateId,pos|pawnTemplateId,pos'' (pode terminar em ''|''). O id é PawnTempInfos.TemplateId (41 distintos, todos válidos). pos é a casa da grade 1–12 (docs/BATTLE.md §4); usadas 1,2,3,4,5,7,8,9. Ex.: AI 1008 ''Cavaleiro das Chamas Débora'' = ''2006,1|2006,7'' (Guardião do Império nas casas 1 e 7). Mais comum: ''621001,1|621002,2|621003,7|621004,8|'' (61 linhas). [decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:697] XML: HeroAis.Soldiers';
COMMENT ON COLUMN game.hero_ais.change_skill_ids IS 'Skills após transformação. Rotação depois da transformação (CSV de skill ids). Só 3 linhas úteis: ''40212,40213,'' (''Após Deborah Transformar 1'' e ''… 2 Grupo''); 555 linhas ''0,''. Não é declarado em HeroAisTemplate.as, então o cliente ignora (o servidor manda HeroMsg.changeSkills). [data/tpl/tempinfos/HeroAis.xml] XML: HeroAis.ChangeSkills';
COMMENT ON COLUMN game.hero_ais.change_icon IS 'Ícone/recurso após transformação (ex.: boss032a). Retrato/recurso após a transformação: ''boss032a'' em 3 linhas (Débora); ''0'' em 555. Também não é lido pelo cliente. [data/tpl/tempinfos/HeroAis.xml] XML: HeroAis.ChangeIcon';
COMMENT ON COLUMN game.hero_ais.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.hero_ais.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.pawns (
  id integer NOT NULL,
  master_type integer,
  son_type integer,
  camp smallint,
  level integer,
  next_level_id integer,
  name text,
  description text,
  crystals_cost integer,
  gold_cost integer,
  required_building_id integer,
  train_time integer,
  population_cost integer,
  hit_points integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  critical integer,
  parry integer,
  penetration integer,
  determination integer,
  fire_resist integer,
  water_resist integer,
  electric_resist integer,
  wind_resist integer,
  dark_resist integer,
  light_resist integer,
  resist_reduction integer,
  resist_reduction_defense integer,
  resist_penetration integer,
  movie_res text,
  attack_type smallint,
  default_skill_id integer,
  high_skill integer,
  hero_skill integer,
  icon text,
  ai_id integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.pawns IS 'Tropas/soldados (pawns) e unidades de monstro: cada nível de cada tipo é um template; liderados por heróis e posicionados na grade 3×4. Origem: tempinfos.xml/PawnTempInfos.';
COMMENT ON COLUMN game.pawns.id IS 'ID do soldado (6.464 linhas). Soldados do jogador: 10000 + MasterType·100 + Nível (10101 = Lanceiro Nv1, 11180 = Anjo Mágico Nv80). ArmyManager.initPawnList cria as 11 entradas base ''Nv1'' com ''10''+i+''01'' / ''1''+i+''01''. NPCs: 2006…904510403 (às vezes = AI). [decompiled/core_module/scripts/yishi/manager/ArmyManager.as:130] XML: PawnTempInfos.TemplateId';
COMMENT ON COLUMN game.pawns.master_type IS 'Categoria da tropa (infantaria, arqueiro, cavalaria, mago, monstro...; ver meta.enum_values pawn_master_type). Classe/categoria do soldado: 13 valores (1–11 do jogador, 80 linhas cada; 12 = 85 linhas; 101 = 5.499 linhas). Usado em getCasernPawnByMastertype e em BattleModel.isHideOtherInBattle (>100 = NPC). Enum: meta.enum_values.enum_name=''pawn_master_type''. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:13] XML: PawnTempInfos.MasterType';
COMMENT ON COLUMN game.pawns.son_type IS 'Linhagem/tipo específico; níveis do mesmo son_type formam a cadeia de evolução. Chave da ''linha'' do soldado (560 valores). Nos soldados do jogador é 100+MasterType (101–111) e é a chave dos dicionários casernPawnList/castlePawnList; elevar o nível mantém o SonType (synchronizationAllPawn compara SonType). Nos NPCs é um grupo livre (ex.: 2073, 2072, 4057). [decompiled/core_module/scripts/yishi/manager/ArmyManager.as:146] XML: PawnTempInfos.SonType';
COMMENT ON COLUMN game.pawns.camp IS 'Facção (1). Facção; sempre 1. Enum: meta.enum_values.enum_name=''pawn_camp''. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:17] XML: PawnTempInfos.Camp';
COMMENT ON COLUMN game.pawns.level IS 'Nível da tropa. Nível do soldado: 1–80 nos soldados do jogador e 1–99 nos NPCs (80 é o mais comum). Aparece no nome em combate (''Nome Nv.X'', PawnRoleView.as:155). Para elevar: nível do próximo ≤ nível do Quartel e nível < nível do herói − 3. [decompiled/core_module/scripts/battle/view/roles/PawnRoleView.as:155] XML: PawnTempInfos.Level';
COMMENT ON COLUMN game.pawns.next_level_id IS 'Template do próximo nível (evolução). TemplateId do mesmo soldado no nível seguinte; 0 = nível máximo ou sem cadeia. Só os soldados do jogador têm cadeia: 869 elos (11 × 79), todos válidos; os 5.595 restantes são 0. ArmyPawn.nextTemplate e canUpgradePawn usam o campo. [decompiled/core_module/scripts/mvc/module/armyII/ArmyPawn.as:198] XML: PawnTempInfos.NextLevelTemplateId';
COMMENT ON COLUMN game.pawns.name IS 'Nome pt-BR (415 distintos). Ex.: ''Lanceiro'', ''Guardião do Império'', ''Lanceiro Sangrento'' (116 linhas). O getter Name devolve PawnName. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:77] XML: PawnTempInfos.PawnName';
COMMENT ON COLUMN game.pawns.description IS 'Descrição; vazia em todas as linhas. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:21] XML: PawnTempInfos.Description';
COMMENT ON COLUMN game.pawns.crystals_cost IS 'Custo em cristais para recrutar. Custo em cristais para recrutar; sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:27] XML: PawnTempInfos.CrystalsConsume';
COMMENT ON COLUMN game.pawns.gold_cost IS 'Custo em ouro por soldado. Ouro por soldado recrutado. Jogador: Lanceiro/Arqueiro 2, Espadachim/Griffin/Sacerdote 3, Cavaleiro em diante 4. Custo real = GoldConsume·(1 − Quartel.Property4/100), com bônus do jogador. Nos NPCs (0–1000, ex.: 580) não é usado no recrutamento. [decompiled/core_module/scripts/yishi/view/frame/CasernRecruitFrame.as:306] XML: PawnTempInfos.GoldConsume';
COMMENT ON COLUMN game.pawns.required_building_id IS 'Prédio exigido (BuildingTempInfos). Construção exigida para recrutar (BuildingTempInfos.TemplateId = Quartel em certo nível). É String (split '',''); 8 valores; 0 = nenhum. Também ordena as listas (PawnTileList, PawnLevelUpFrame.sortByNeedBuild) e entra no desempate do auto-alocar. Enum: meta.enum_values.enum_name=''pawn_need_building''. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:72] XML: PawnTempInfos.NeedBuilding';
COMMENT ON COLUMN game.pawns.train_time IS 'Tempo de treino. Tempo de recrutamento; sempre 0 (recrutar é instantâneo). [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:33] XML: PawnTempInfos.NeedTime';
COMMENT ON COLUMN game.pawns.population_cost IS 'População consumida por soldado. População por soldado; sempre 1. É o divisor de Liderança e de população livre (BaseArmy.getLeftPopulation, ArmyModel.getPawnNumber, CasernRecruitFrame). [decompiled/core_module/scripts/mvc/module/armyII/BaseArmy.as:161] XML: PawnTempInfos.NeedPopulation';
COMMENT ON COLUMN game.pawns.hit_points IS 'Vida (HP) (Live). Vida base por soldado. Lanceiro: 323 (Nv1) a 1.034 (Nv80); Cavaleiro Mágico Nv80: 9.910; NPCs: 2 a 91.040.000. ArmyPawn.live = PawnProperty.getTotalJoin(Live), com os bônus (tecnologia, características) somados. [decompiled/core_module/scripts/mvc/module/armyII/ArmyPawn.as:62] XML: PawnTempInfos.Live';
COMMENT ON COLUMN game.pawns.attack IS 'Ataque físico (Attack). Ataque físico (''Ataque Físico''); 0 nas classes mágicas. Lanceiro: 64 → 1.644 (Nv1 → Nv80). [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:49] XML: PawnTempInfos.Attack';
COMMENT ON COLUMN game.pawns.defense IS 'Defesa física (Defence). Defesa física. Lanceiro: 50 → 2.844. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:51] XML: PawnTempInfos.Defence';
COMMENT ON COLUMN game.pawns.magic_attack IS 'Ataque mágico (MagicAttack). Ataque mágico; 0 nas classes físicas do jogador. Presbítera: 481 → 12.343. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:53] XML: PawnTempInfos.MagicAttack';
COMMENT ON COLUMN game.pawns.magic_defense IS 'Defesa mágica (MagicDefence). Defesa mágica. Lanceiro: 40 → 1.821. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:55] XML: PawnTempInfos.MagicDefence';
COMMENT ON COLUMN game.pawns.critical IS 'Crítico (ForceHit). Crítico (''PropertyName.ForceHit'' = Crítico): 64 no Nv1 e 1.170 no Nv80 em todas as classes do jogador; NPCs até 1.089.472. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:57] XML: PawnTempInfos.ForceHit';
COMMENT ON COLUMN game.pawns.parry IS 'Bloqueio (aparar) (Parry). Bloqueio; sempre 0 nos soldados. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:59] XML: PawnTempInfos.Parry';
COMMENT ON COLUMN game.pawns.penetration IS 'Penetração (Penetrate). Penetração; 577 NPCs com valor ≠ 0 (até 1.050.000); 0 nos soldados do jogador. Vai em SoldierMsg.penetrate. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.Penetrate';
COMMENT ON COLUMN game.pawns.determination IS 'Determinação/Força Consistente (resistência a atordoamento) (StunAttr). ''Determinação'' (Tip27); −1 em 6.462 linhas e 0 em 2. Vai em SoldierMsg.stunAttr. Enum: meta.enum_values.enum_name=''pawn_stun_attr''. [protocol/proto.json] XML: PawnTempInfos.StunAttr';
COMMENT ON COLUMN game.pawns.fire_resist IS 'Resistência a fogo (FireResi). Resistência a Fogo. 0 nos soldados do jogador; 1.392 NPCs com resistências (faixa −200 a 40.000; ex.: ''Lava Geocêntrica'' Fogo 500). Calculada no servidor; o cliente não lê do PawnTemplate. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.FireResi';
COMMENT ON COLUMN game.pawns.water_resist IS 'Resistência a água (WaterResi). Resistência a Água. 0 nos soldados do jogador; 1.392 NPCs com resistências (faixa −200 a 40.000; ex.: ''Lava Geocêntrica'' Fogo 500). Calculada no servidor; o cliente não lê do PawnTemplate. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.WaterResi';
COMMENT ON COLUMN game.pawns.electric_resist IS 'Resistência a eletricidade (ElectResi). Resistência a Choque. 0 nos soldados do jogador; 1.392 NPCs com resistências (faixa −200 a 40.000; ex.: ''Lava Geocêntrica'' Fogo 500). Calculada no servidor; o cliente não lê do PawnTemplate. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.ElectResi';
COMMENT ON COLUMN game.pawns.wind_resist IS 'Resistência a vento (WindResi). Resistência a Vento. 0 nos soldados do jogador; 1.392 NPCs com resistências (faixa −200 a 40.000; ex.: ''Lava Geocêntrica'' Fogo 500). Calculada no servidor; o cliente não lê do PawnTemplate. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.WindResi';
COMMENT ON COLUMN game.pawns.dark_resist IS 'Resistência a trevas (DarkResi). Resistência a Escuridão. 0 nos soldados do jogador; 1.392 NPCs com resistências (faixa −200 a 40.000; ex.: ''Lava Geocêntrica'' Fogo 500). Calculada no servidor; o cliente não lê do PawnTemplate. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.DarkResi';
COMMENT ON COLUMN game.pawns.light_resist IS 'Resistência a luz (LightResi). Resistência a Luz. 0 nos soldados do jogador; 1.392 NPCs com resistências (faixa −200 a 40.000; ex.: ''Lava Geocêntrica'' Fogo 500). Calculada no servidor; o cliente não lê do PawnTemplate. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.LightResi';
COMMENT ON COLUMN game.pawns.resist_reduction IS 'Redução de resistência (anti-RES) (ReduceResi). Anti-resistência (''Resistência a Redução''). 0 nos soldados do jogador; 1.328 NPCs com valor ≠ 0 (até 40.000). Não é lido do template; vai ao combate pelo HeroMsg/servidor. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.ReduceResi';
COMMENT ON COLUMN game.pawns.resist_reduction_defense IS 'Defesa contra redução de resistência (ReduceResiAgainst). ''Resistência à anti-RES'' (PropertyName.ReduceResiAgainst); sempre 0 nos soldados. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.ReduceResiAgainst';
COMMENT ON COLUMN game.pawns.resist_penetration IS 'Penetração de resistência (ResiPenetrate). ''Penetração de Resistência''; sempre 0 nos soldados. [data/tpl/tempinfos/PawnTempInfos.xml] XML: PawnTempInfos.ResiPenetrate';
COMMENT ON COLUMN game.pawns.movie_res IS 'Recurso de batalha: swf/<res>/<res>.swf, classe slg.resource.movie.MovieAsset<res>. Pasta do SWF de combate: {RES}swf/<Swf>/<Swf>.swf (PathManager.solveRolePath). Jogador: ''001''…''011''; NPCs: ''monsterNNNx'' (82 distintos, ex.: monster012A em 283 linhas). PawnViewType.swf pode sobrescrever (debug). [decompiled/core_module/scripts/battle/BattleResPreloadManager.as:99] XML: PawnTempInfos.Swf';
COMMENT ON COLUMN game.pawns.attack_type IS '1 = físico, 2 = mágico (suposição: alinhado a ActionTempInfos.AttackType). Tipo de dano: 1 físico, 2 mágico. É String no AS3 e não é lido pelo cliente. Enum: meta.enum_values.enum_name=''pawn_attack_type''. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:39] XML: PawnTempInfos.AttackType';
COMMENT ON COLUMN game.pawns.default_skill_id IS 'Ataque básico. Ataque básico: 10000 = SkillTempInfos ''Ataque Normal''. Valores 1 e 2 são índices de animação (Attack01/02) usados na Exploração de Monstros. DefaultSkillTemplateInfo resolve pelo SkillTempInfos. Enum: meta.enum_values.enum_name=''pawn_default_skill''. [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:82] XML: PawnTempInfos.DefaultSkill';
COMMENT ON COLUMN game.pawns.high_skill IS 'Skill avançada/índice de skill especial da tropa. Habilidade especial (CSV de SkillTempInfos.TemplateId). Só nas 11 classes do jogador, 1 por classe: 11, 21, …, 91, 86, 96. Exibida no PawnTip (m16) e na tela Elevar Soldado; o recurso é pré-carregado. Enum: meta.enum_values.enum_name=''pawn_high_skill''. [decompiled/core_module/scripts/battle/skillsys/loader/SkillResourceLoader.as:285] XML: PawnTempInfos.HighSkill';
COMMENT ON COLUMN game.pawns.hero_skill IS 'Habilidade concedida ao herói; vazia em todas as linhas (declarada em PawnTemplate, sem uso). [decompiled/core_module/scripts/yishi/datas/templates/PawnTemplate.as:63] XML: PawnTempInfos.HeroSkill';
COMMENT ON COLUMN game.pawns.icon IS 'Retrato: {RES}icon<Icon> (IconFactory.getSoldierIconByIcon), ex.: /head_pawn1.jpg. 38 distintos; 5.167 NPCs usam /head_unknown.jpg. [decompiled/core_module/scripts/yishi/utils/IconFactory.as:35] XML: PawnTempInfos.Icon';
COMMENT ON COLUMN game.pawns.ai_id IS 'Roteiro de IA. FK para HeroAis.ID (rotação de habilidades no combate). Jogador: 100·MasterType (850 e 950 nas classes 10 e 11). NPC: geralmente = TemplateId (3.270 linhas). 3.446 valores distintos; todos, exceto 0 (104 linhas), existem em HeroAis. O cliente só usa o campo para pré-carregar skills e as tropas convocadas. [decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:249] XML: PawnTempInfos.AI';
COMMENT ON COLUMN game.pawns.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.pawns.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.heroes (
  id integer NOT NULL,
  name text,
  hero_type smallint,
  job_id smallint,
  sex_id smallint,
  icon text,
  grade integer,
  ai_id integer,
  default_skill_id integer,
  power integer,
  agility integer,
  intellect integer,
  physique integer,
  leadership integer,
  troop_capacity integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  hit_points integer,
  critical integer,
  parry integer,
  skill_script integer[],
  res_path text,
  arm_path text,
  cloth_path text,
  reject_types integer[],
  fire_resist integer,
  water_resist integer,
  electric_resist integer,
  wind_resist integer,
  dark_resist integer,
  light_resist integer,
  resist_reduction integer,
  resist_reduction_defense integer,
  resist_penetration integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.heroes IS 'Templates de heróis: personagens jogáveis por classe/sexo/nível e heróis NPC/bosses de campanha (ResPath). Origem: tempinfos.xml/GameHeroTemp.';
COMMENT ON COLUMN game.heroes.id IS 'PK do template de herói/unidade (7370 linhas). 1-9 = classes do jogador; 11001.. NPCs de classe; demais = monstros/chefes NPC. Referenciado por ThaneInfo.templateId (herói do jogador), HeroMsg.temp_id em batalha, WarSoulTowerLevelTemplates.Heroes, chefes de campanha/guilda. [decompiled/core_module/scripts/yishi/datas/templates/GameHeroTempInfo.as:6] XML: GameHeroTemp.TemplateId';
COMMENT ON COLUMN game.heroes.name IS 'Nome pt-BR exibido (829 distintos; nomes se repetem por nível/variante, ex. ''Intruso'' 160x). [decompiled/core_module/scripts/yishi/datas/templates/GameHeroTempInfo.as:8] XML: GameHeroTemp.TemplateName';
COMMENT ON COLUMN game.heroes.hero_type IS 'Tipo de herói (jogador, NPC, boss...; ver meta.enum_values hero_type). Tipo de unidade: 1 herói do jogador, 2 NPC com aparência de classe, 3 monstro/chefe, 7/8 NPC especiais. Distribuição: 3=6865, 7=196, 8=180, 2=120, 1=9. Enum: meta.enum_values.enum_name=''hero_type''. [decompiled/core_module/scripts/battle/BattleResPreloadManager.as:68] XML: GameHeroTemp.HeroType';
COMMENT ON COLUMN game.heroes.job_id IS 'Classe. Classe: 1 Guerreiro, 2 Arqueiro, 3 Feiticeiro (0/4/100 existem no enum); NPCs = 10. Usado para inicializar skills/runas/talentos (ThaneInfo.as:397-399) e avatar padrão (ShowAvatar.as:117). Enum: meta.enum_values.enum_name=''job_type''. [decompiled/core_module/scripts/yishi/datas/playerinfo/ThaneInfo.as:397] XML: GameHeroTemp.Job';
COMMENT ON COLUMN game.heroes.sex_id IS 'Sexo. Sexo: 0 feminino, 1 masculino. Compõe nome do SWF do avatar e o pacote de skills (BattleResPreloadManager.as:117). Enum: meta.enum_values.enum_name=''sex_type''. [decompiled/core_module/scripts/avatar/view/ShowAvatar.as:117] XML: GameHeroTemp.Sexs';
COMMENT ON COLUMN game.heroes.icon IS 'Caminho do retrato relativo a {resourcePath}icon (IconFactory.getHeroIconByPics → resourcePath+''icon''+Icon). Ex.: ''/player/1/head.png'', ''/head_monster011A.jpg''. [decompiled/core_module/scripts/yishi/utils/IconFactory.as:81] XML: GameHeroTemp.Icon';
COMMENT ON COLUMN game.heroes.grade IS 'Nível do herói. Nível da unidade (0..99; 5793 NPC com 80). Mostrado no cabeçalho do chefe em batalha (BossInfoView.as:230, asset.battle.BossGradeNumAsset). Para heróis do jogador é o nível inicial (1). [decompiled/core_module/scripts/battle/view/ui/top/BossInfoView.as:230] XML: GameHeroTemp.Grades';
COMMENT ON COLUMN game.heroes.ai_id IS 'Roteiro de IA (heróis NPC). ID da IA/rotação de skills do NPC; 0 para heróis do jogador. Todos os 7234 valores ≠0 existem em HeroAis.ID. O cliente usa para pré-carregar as skills da IA (heroAISTemplateCate.getTemplateByID(AI).getSkills()). [decompiled/core_module/scripts/battle/BattleResPreloadManager.as:56] XML: GameHeroTemp.AI';
COMMENT ON COLUMN game.heroes.default_skill_id IS 'Ataque básico. Skill de ataque básico (SkillTempInfos.TemplateId): 10000/20000/30000 ''Ataque Normal'' por classe; NPC usam skills de monstro (60073 ''Lagarto B'', 40101 ''Águia Serpente A''...). Pré-carregada em CreateGameTransaction.as:316. [decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:316] XML: GameHeroTemp.DefaultSkill';
COMMENT ON COLUMN game.heroes.power IS 'Força (Power). Força (力量) base. Cada ponto = +4 Ataque físico e +1 Defesa (armyII.ThaneAttributeView.strength). Jogador começa com 5; NPC 0 (stats já finais). [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:590] XML: GameHeroTemp.Power';
COMMENT ON COLUMN game.heroes.agility IS 'Proteção (XML Agility: +4 defesa, +4 resistência) (Agility). ''Proteção'' (护甲, armadura; o nome do campo é Agility mas não é agilidade). Cada ponto = +4 Defesa e +4 Resistência (defesa mágica) (armyII.ThaneAttributeView.agility). Base 5 no jogador. [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:590] XML: GameHeroTemp.Agility';
COMMENT ON COLUMN game.heroes.intellect IS 'Inteligência (Intellect). Inteligência (智力). Cada ponto = +4 Magia (ataque mágico) e +1 Resistência (armyII.ThaneAttributeView.ability). Base 5. [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:590] XML: GameHeroTemp.Intellect';
COMMENT ON COLUMN game.heroes.physique IS 'Físico (constituição) (Physique). Físico (体质). Cada ponto = +20 Vida (armyII.ThaneAttributeView.physique). Base 5. [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:590] XML: GameHeroTemp.Physique';
COMMENT ON COLUMN game.heroes.leadership IS 'Liderança (Captain). Duplo uso. Jogador: Liderança (统帅) base = 100; cada ponto de Liderança = +1 ''Infantaria'' (totalConatArmy, nº de soldados liderados). NPC chefe: número de faixas da barra de HP do chefe (BattleModel.getBossHpStripNum = max(Captain,1)); valores 0,3..8. [decompiled/core_module/scripts/yishi/datas/BattleModel.as:139] XML: GameHeroTemp.Captain';
COMMENT ON COLUMN game.heroes.troop_capacity IS 'Infantaria (capacidade de tropa) (Conat). Infantaria/soldados (ConatArmy): número de soldados adicionais. Jogador recebe +1 por ponto de Liderança; nos dados vale 0/1 (146 NPC HeroType 3 com 1, suposição: NPC acompanhado de tropa). ''Aumento do número de soldados'' (ExplainTip12). Em equipamentos soma 1:1 no score. [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:730] XML: GameHeroTemp.Conat';
COMMENT ON COLUMN game.heroes.attack IS 'Ataque físico (Attack). Ataque físico (PhyAttack) base do template. ''Causa danos ao alvo'' (ExplainTip06). NPC até 995.090.000. [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:709] XML: GameHeroTemp.Attack';
COMMENT ON COLUMN game.heroes.defense IS 'Defesa física (Defence). Defesa física. ''Reduz danos de ataque causados pelo alvo'' (ExplainTip07). [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:712] XML: GameHeroTemp.Defence';
COMMENT ON COLUMN game.heroes.magic_attack IS 'Ataque mágico (MagicAttack). Magia (ataque mágico). ''Causa danos de magia ao alvo'' (ExplainTip08). [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:715] XML: GameHeroTemp.MagicAttack';
COMMENT ON COLUMN game.heroes.magic_defense IS 'Defesa mágica (MagicDefence). Resistência (defesa mágica). ''Reduz danos de magia causados pelo alvo'' (ExplainTip09). [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:718] XML: GameHeroTemp.MagicDefence';
COMMENT ON COLUMN game.heroes.hit_points IS 'Vida (HP) (Live). Vida máxima (HP) base; ''Adição ao limite de vida'' (ExplainTip11). Jogador 90 no nível 1; NPC 5..1.800.000.000. Em batalha vira HeroMsg.max_hp (int64). [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:727] XML: GameHeroTemp.Live';
COMMENT ON COLUMN game.heroes.critical IS 'Crítico (ForceHit). Crítico (暴击): ''Aumenta a probabilidade de crítico contra o alvo'' (ExplainTip10). Jogador: 10 (Arqueiro 100). Valor em pontos, a conversão para % é feita no servidor. [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:721] XML: GameHeroTemp.ForceHit';
COMMENT ON COLUMN game.heroes.parry IS 'Bloqueio (aparar) (Parry). Bloqueio (格挡): ''Aumento da probabilidade do bloqueio do ataque do alvo'' (ExplainTip19). Contraposto por Penetração (''Reduz a probabilidade de bloqueio do alvo''). [decompiled/m5/scripts/playerinfo/view/ThaneAttributeFrame.as:724] XML: GameHeroTemp.Parry';
COMMENT ON COLUMN game.heroes.skill_script IS 'Skills de roteiro do herói NPC. CSV de SkillTempInfos.TemplateId das skills ativas do herói (ex. ''10711,10811'' = ''Ataque Supressivo'',''Ataque Fulminante'' do Guerreiro). 16 valores distintos; vazio em 7223 NPC (NPC usam HeroAis). Em batalha vem em HeroMsg.skill_script. [decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as:398] XML: GameHeroTemp.SkillScript';
COMMENT ON COLUMN game.heroes.res_path IS 'Recurso de batalha do NPC: swf/<res>/<res>.swf. Nome do SWF de corpo do NPC: swf/<ResPath>/<ResPath>.swf (PathManager.solveRolePath). Ex. ''boss032'', ''monster010A''. Vazio para heróis de jogador (usam avatar). [decompiled/core_module/scripts/yishi/manager/PathManager.as:135] XML: GameHeroTemp.ResPath';
COMMENT ON COLUMN game.heroes.arm_path IS 'Caminho de arma do avatar; vazio em todas as 7370 linhas (campo legado, não usado). [decompiled/core_module/scripts/yishi/datas/templates/GameHeroTempInfo.as:40] XML: GameHeroTemp.ArmPath';
COMMENT ON COLUMN game.heroes.cloth_path IS 'Caminho de roupa do avatar; vazio em todas as linhas (legado). [decompiled/core_module/scripts/yishi/datas/templates/GameHeroTempInfo.as:42] XML: GameHeroTemp.ClothPath';
COMMENT ON COLUMN game.heroes.reject_types IS 'Tipos de efeito/buff aos quais o herói é imune. XML: GameHeroTemp.RejectType';
COMMENT ON COLUMN game.heroes.fire_resist IS 'Resistência a fogo (FireResi). Resistência a Fogo (pontos). Reduz dano de skills desse elemento; quando a Anti-Resistência (ReduceResi) do adversário chega a 0 a redução vale (ThaneAttributeTip.ThaneTip). O 1º elemento >0 (ordem Fogo,Água,Choque,Vento,Escuridão,Luz) é o ''elemento'' do chefe (getHeroResistance). 100000 em 1000 chefes (ids 5000001..) = praticamente imune. Enum: meta.enum_values.enum_name=''hero_element_resistance''. [decompiled/core_module/scripts/yishi/datas/templates/cate/GameHeroTemplateCate.as:20] XML: GameHeroTemp.FireResi';
COMMENT ON COLUMN game.heroes.water_resist IS 'Resistência a água (WaterResi). Resistência a Água (pontos). Reduz dano de skills desse elemento; quando a Anti-Resistência (ReduceResi) do adversário chega a 0 a redução vale (ThaneAttributeTip.ThaneTip). O 1º elemento >0 (ordem Fogo,Água,Choque,Vento,Escuridão,Luz) é o ''elemento'' do chefe (getHeroResistance). 100000 em 1000 chefes (ids 5000001..) = praticamente imune. Enum: meta.enum_values.enum_name=''hero_element_resistance''. [decompiled/core_module/scripts/yishi/datas/templates/cate/GameHeroTemplateCate.as:20] XML: GameHeroTemp.WaterResi';
COMMENT ON COLUMN game.heroes.electric_resist IS 'Resistência a eletricidade (ElectResi). Resistência a Choque/Elétrico (pontos). Reduz dano de skills desse elemento; quando a Anti-Resistência (ReduceResi) do adversário chega a 0 a redução vale (ThaneAttributeTip.ThaneTip). O 1º elemento >0 (ordem Fogo,Água,Choque,Vento,Escuridão,Luz) é o ''elemento'' do chefe (getHeroResistance). 100000 em 1000 chefes (ids 5000001..) = praticamente imune. Enum: meta.enum_values.enum_name=''hero_element_resistance''. [decompiled/core_module/scripts/yishi/datas/templates/cate/GameHeroTemplateCate.as:20] XML: GameHeroTemp.ElectResi';
COMMENT ON COLUMN game.heroes.wind_resist IS 'Resistência a vento (WindResi). Resistência a Vento (pontos). Reduz dano de skills desse elemento; quando a Anti-Resistência (ReduceResi) do adversário chega a 0 a redução vale (ThaneAttributeTip.ThaneTip). O 1º elemento >0 (ordem Fogo,Água,Choque,Vento,Escuridão,Luz) é o ''elemento'' do chefe (getHeroResistance). 100000 em 1000 chefes (ids 5000001..) = praticamente imune. Enum: meta.enum_values.enum_name=''hero_element_resistance''. [decompiled/core_module/scripts/yishi/datas/templates/cate/GameHeroTemplateCate.as:20] XML: GameHeroTemp.WindResi';
COMMENT ON COLUMN game.heroes.dark_resist IS 'Resistência a trevas (DarkResi). Resistência a Escuridão/Trevas (pontos). Reduz dano de skills desse elemento; quando a Anti-Resistência (ReduceResi) do adversário chega a 0 a redução vale (ThaneAttributeTip.ThaneTip). O 1º elemento >0 (ordem Fogo,Água,Choque,Vento,Escuridão,Luz) é o ''elemento'' do chefe (getHeroResistance). 100000 em 1000 chefes (ids 5000001..) = praticamente imune. Enum: meta.enum_values.enum_name=''hero_element_resistance''. [decompiled/core_module/scripts/yishi/datas/templates/cate/GameHeroTemplateCate.as:20] XML: GameHeroTemp.DarkResi';
COMMENT ON COLUMN game.heroes.light_resist IS 'Resistência a luz (LightResi). Resistência a Luz (pontos). Reduz dano de skills desse elemento; quando a Anti-Resistência (ReduceResi) do adversário chega a 0 a redução vale (ThaneAttributeTip.ThaneTip). O 1º elemento >0 (ordem Fogo,Água,Choque,Vento,Escuridão,Luz) é o ''elemento'' do chefe (getHeroResistance). 100000 em 1000 chefes (ids 5000001..) = praticamente imune. Enum: meta.enum_values.enum_name=''hero_element_resistance''. [decompiled/core_module/scripts/yishi/datas/templates/cate/GameHeroTemplateCate.as:20] XML: GameHeroTemp.LightResi';
COMMENT ON COLUMN game.heroes.resist_reduction IS 'Redução de resistência (anti-RES) (ReduceResi). Anti-Resistência / ''Redução de resistência'' (BattleWill, totalBattleWill): pontos que consomem/anulam as resistências elementais do alvo. Em batalha HeroMsg.reduce_resi. Valores comuns 0, 1500, 6000, 100000. [decompiled/core_module/scripts/mvc/controler/SortController.as:182] XML: GameHeroTemp.ReduceResi';
COMMENT ON COLUMN game.heroes.resist_reduction_defense IS 'Defesa contra redução de resistência (ReduceResiAgainst). ''Anti_Res.'' (PropertyName.ReduceResiAgainst; baseProperty.totalResistResi): resistência contra a Anti-Resistência do atacante (protege as próprias resistências). Valores 0, 300, 3000, 100000. [decompiled/core_module/scripts/mvc/controler/SortController.as:190] XML: GameHeroTemp.ReduceResiAgainst';
COMMENT ON COLUMN game.heroes.resist_penetration IS 'Penetração de resistência (ResiPenetrate). ''Res. de Penetração'' (PropertyName.ResiPenetrate; baseProperty.totalStrikeResi): penetração de resistência — ignora parte da ReduceResiAgainst do alvo (suposição pela nomenclatura). Valores 0, 750, 3000, 100000. [decompiled/core_module/scripts/mvc/controler/SortController.as:189] XML: GameHeroTemp.ResiPenetrate';
COMMENT ON COLUMN game.heroes.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.heroes.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.monsters (
  id integer NOT NULL,
  name text,
  monster_type integer,
  star smallint,
  max_level integer,
  property_id integer,
  skill_son_types integer[],
  passive_skill_son_types integer[],
  icon text,
  res_path text,
  res_type integer,
  default_skill_id integer,
  scale_percent integer,
  offset_y integer,
  default_attack_label text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.monsters IS 'Monstros colecionáveis/de exploração (sistema ''monster'' do m14): tipo, estrelas, skills e recurso gráfico com escala e deslocamento. Origem: tempinfos.xml/MonsterTemplates.';
COMMENT ON COLUMN game.monsters.id IS 'ID = Type·100 + Star (101 = Lobo Demoníaco 1★; 9904 = Asas Violentas 4★). 73 linhas. ArmyMsg.monster_id / ArmyMonsterInfo.monsterTemplateId apontam para cá. [decompiled/core_module/scripts/yishi/datas/templates/cate/MonsterTemplateCate.as:71] XML: MonsterTemplates.TemplateId';
COMMENT ON COLUMN game.monsters.name IS 'Nome pt-BR (22 distintos; ''Guerreiro Tau'' aparece em 2 tipos). Exibido sobre o avatar que segue o jogador no mapa. [decompiled/core_module/scripts/yishi/datas/templates/MonsterTempInfo.as:8] XML: MonsterTemplates.Name';
COMMENT ON COLUMN game.monsters.monster_type IS 'Espécie; 23 valores (1–19 e 96–99). Chave junto com Star. Enum: meta.enum_values.enum_name=''monster_type''. [decompiled/core_module/scripts/yishi/datas/templates/MonsterTempInfo.as:10] XML: MonsterTemplates.Type';
COMMENT ON COLUMN game.monsters.star IS 'Estrela 1–4; evoluir = Star+1 (MonsterEvolveFrame.as:230). Enum: meta.enum_values.enum_name=''monster_star''. [decompiled/core_module/scripts/yishi/datas/templates/MonsterTempInfo.as:12] XML: MonsterTemplates.Star';
COMMENT ON COLUMN game.monsters.max_level IS 'Nível máximo por estrela: 40/80/120/160. Para evoluir é preciso grade ≥ MaxLevel e stageGrade ≥ star. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:890] XML: MonsterTemplates.MaxLevel';
COMMENT ON COLUMN game.monsters.property_id IS 'Perfil de atributos (SkillPropertyTempInfos). FK para SkillPropertyTempInfos.TemplateId (84TTSS01): atributos base do monstro (Attack, Defence, MagicAttack, MagicDefence, ForceHit, Penetrate, Parry, Live, StunAttr). Ex.: 84010101 → Attack 8000, Live 48000. Escala pela fórmula monster_property. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:506] XML: MonsterTemplates.PropertyId';
COMMENT ON COLUMN game.monsters.skill_son_types IS 'SonTypes de skills ativas. CSV de SkillTempInfos.SonType das habilidades ativas (UseWay 1), uma por estrela (830101; 830101,830102; …). Cada SonType tem várias linhas de Grades (nível da habilidade, treinável). O cliente agrupa as skills por SonType em monsterSkillTempDic. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:110] XML: MonsterTemplates.SkillSonTypes';
COMMENT ON COLUMN game.monsters.passive_skill_son_types IS 'SonTypes de skills passivas. CSV de SonTypes passivos (UseWay 2); igual em todas as linhas: ''830001,830002'' = ''Transmissão de Resistência'' e ''Transmissão de Anti-resistência''. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:111] XML: MonsterTemplates.PassiveSkillSonTypes';
COMMENT ON COLUMN game.monsters.icon IS 'Retrato: {RES}icon/<Icon> (IconFactory.getCommonIconPath), ex.: /head_monster002A.jpg; 23 distintos. [decompiled/m14/scripts/monster/item/MonsterListItem.as:118] XML: MonsterTemplates.Icon';
COMMENT ON COLUMN game.monsters.res_path IS 'MovieClip de batalha swf/<res>/<res>.swf. SWF de combate/vitrine: {RES}swf/<ResPath>/<ResPath>.swf, classe ''slg.resource.movie.MovieAsset''+ResPath. Ex.: monster002B. [decompiled/m14/scripts/monsterexplore/view/MonsterExploreBattleAvatarView.as:340] XML: MonsterTemplates.ResPath';
COMMENT ON COLUMN game.monsters.res_type IS 'ID do sprite de NPC que anda no mapa: {RES}swf/npc/<ResType>.bswf (getAvatarResourcePath com tipo 2). Ex.: 2114. Só é usado com VersionSwitch.MONSTER_FOLLOW, que é false por padrão. [decompiled/m3/scripts/map/outercity/view/mapphysics/ArmyView.as:757] XML: MonsterTemplates.ResType';
COMMENT ON COLUMN game.monsters.default_skill_id IS 'Ataque normal do monstro (SkillTempInfos.TemplateId, ex.: 83010001 ''Ataque normal do Lobo''). Não existe em MonsterTempInfo.as, então o cliente ignora; só o servidor usa. [data/tpl/tempinfos/MonsterTemplates.xml] XML: MonsterTemplates.DefaultSkill';
COMMENT ON COLUMN game.monsters.scale_percent IS 'Escala do MovieClip em %. Escala do avatar em %: setBodyScale(Scale/100). Valores 50, 70, 80, 90, 100 (100 em 39 linhas). [decompiled/m14/scripts/monster/MonsterEvolveFrame.as:275] XML: MonsterTemplates.Scale';
COMMENT ON COLUMN game.monsters.offset_y IS 'Deslocamento vertical em px. Ajuste vertical do avatar em px: y = pos_leg.y + base + Offset (base 195 na Evolução, 185 no Treino, 135 no Manual). Faixa −25 a 45. [decompiled/m14/scripts/monster/MonsterEvolveFrame.as:277] XML: MonsterTemplates.Offset';
COMMENT ON COLUMN game.monsters.default_attack_label IS 'Rótulo de ataque padrão (ex.: Attack02). Rótulo da animação do ataque básico (''Attack01''/''Attack02''). Enum: meta.enum_values.enum_name=''monster_default_attack''. [decompiled/m14/scripts/monsterexplore/view/MonsterExploreBattleView.as:211] XML: MonsterTemplates.DefaultAttack';
COMMENT ON COLUMN game.monsters.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.monsters.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.level_thresholds (
  id integer NOT NULL,
  upgrade_type integer,
  template_id integer,
  name text,
  grade integer,
  value bigint,
  active_object integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.level_thresholds IS 'Tabelas de progressão por nível (experiência e valores por grau) de vários sistemas, discriminadas por upgrade_type. Origem: tempinfos.xml/UpGradeTempInfos.';
COMMENT ON COLUMN game.level_thresholds.id IS 'PK da linha (13335 linhas). Para Types=1 é igual a TemplateId da tropa. [decompiled/core_module/scripts/yishi/datas/templates/UpgradeTemplateInfo.as:5] XML: UpGradeTempInfos.Id';
COMMENT ON COLUMN game.level_thresholds.upgrade_type IS 'Sistema (ver meta.enum_values upgrade_type: jogador, herói, prédio, pet...). Tipo da tabela de progressão (110 distintos). Principais para heróis: 3 = nível do jogador 1..80 (Data = EXP, 3000 no nv2 até 110.946.655 no nv80, soma 1,41 bi); 105 = 1ª transferência (80 níveis, 99.000..273.761.441); 110 = 2ª transferência (80 níveis); 152 = Vingador (30); 158 = Sagrado (40); 1 = tropas (879 linhas, nível 1..80 por TemplateId de PawnTempInfos); 21/38 = talento. Enum: meta.enum_values.enum_name=''upgrade_type''. [decompiled/core_module/scripts/ui/maintoolbar/view/PlayerExperenceView.as:147] XML: UpGradeTempInfos.Types';
COMMENT ON COLUMN game.level_thresholds.template_id IS 'Sub-chave dentro do tipo (getTemplateByTypeAndLevelAndID). Em Types=1 é o PawnTempInfos.TemplateId (879/879 batem); em Types=138 é o profile; na maioria dos tipos é constante. [decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2304] XML: UpGradeTempInfos.TemplateId';
COMMENT ON COLUMN game.level_thresholds.name IS 'Texto auxiliar; em tipos de profissão contém nomes por classe separados por ''|'', indexados por Job-1 (PlayerManager.getVocationName: TemplateName.split(''|'')[job-1]). Ex. Types=110: ''Espadachim Básico|Artilheiro ...|Deus Mago ...''; Types=152: ''Deus espadachim vingador|Deus arqueiro vingador|Deus mago vingador''. Em outros tipos guarda listas CSV/pipe de ids ou nomes (ex. Types=14 ''Civil'', ''Cavaleiro Dragão''). [decompiled/core_module/scripts/yishi/manager/PlayerManager.as:2128] XML: UpGradeTempInfos.TemplateName';
COMMENT ON COLUMN game.level_thresholds.grade IS 'Nível. Nível alvo desta linha (0..3000 conforme o tipo). A barra de EXP usa a linha Grades = nível atual + 1. [decompiled/core_module/scripts/ui/maintoolbar/view/PlayerExperenceView.as:183] XML: UpGradeTempInfos.Grades';
COMMENT ON COLUMN game.level_thresholds.value IS 'Valor exigido/obtido (ex.: experiência acumulada). Valor principal: EXP/custo necessário para subir ao nível Grades (não acumulado: a barra mostra gp/Data). Ex. Types=3 Grades=2 Data=3000. [decompiled/core_module/scripts/ui/maintoolbar/view/PlayerExperenceView.as:186] XML: UpGradeTempInfos.Data';
COMMENT ON COLUMN game.level_thresholds.active_object IS 'Parâmetro secundário dependente do tipo (objeto/efeito liberado no nível): ex. Types=19 montaria 1006/2001..; Types=101 Alma do Dragão 7101..7105; Types=152 30..1 (ordem/ranking); Types=28 slot de guarda liberado. 0 na maioria. [decompiled/core_module/scripts/yishi/datas/templates/UpgradeTemplateInfo.as:11] XML: UpGradeTempInfos.ActiveObject';
COMMENT ON COLUMN game.level_thresholds.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.level_thresholds.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.actions (
  id integer NOT NULL,
  name text,
  attack_times smallint,
  frame_count integer,
  attack_type smallint,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.actions IS 'Ações (animações) de skill: nome, nº de golpes e duração em frames. Os frames detalhados ficam em game.action_frames. Origem: tempinfos.xml/ActionTempInfos.';
COMMENT ON COLUMN game.actions.id IS 'PK da animação (mesmo id de ActionInfos e SkillTempInfos.ActionId). 3 = Vitória, 4 = Derrota, 700001-700004 morph. [decompiled/core_module/scripts/yishi/datas/templates/ActionTemplateInfo.as:6] XML: ActionTempInfos.ActionId';
COMMENT ON COLUMN game.actions.name IS 'Nome interno (zh). Nome interno em chinês (descrição do designer). [decompiled/core_module/scripts/yishi/datas/templates/ActionTemplateInfo.as:8] XML: ActionTempInfos.ActionName';
COMMENT ON COLUMN game.actions.attack_times IS 'Quantidade de golpes. Nº de golpes (=quadros de dano 3/11/12 na maioria: 479 de 593 com 1). [decompiled/core_module/scripts/yishi/datas/templates/ActionTemplateInfo.as:10] XML: ActionTempInfos.AttackTimes';
COMMENT ON COLUMN game.actions.frame_count IS 'Duração total em frames (25 fps). Total de quadros da animação (≈ Frame do quadro 99; 260 coincidem). Não lido pelo cliente. [data/tpl/tempinfos/ActionTempInfos.xml] XML: ActionTempInfos.FrameNum';
COMMENT ON COLUMN game.actions.attack_type IS '1 = corpo a corpo (CommonActionSkill), 2 = à distância (ShootActionSkill) (suposição alinhada a presentType). 1 (589) / 0 (4). Não lido pelo cliente (suposição: 0 = sem ataque). [data/tpl/tempinfos/ActionTempInfos.xml] XML: ActionTempInfos.AttackType';
COMMENT ON COLUMN game.actions.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.actions.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.action_frames (
  row_id serial,
  action_id integer NOT NULL,
  frame_type smallint,
  frame integer,
  sex_id smallint,
  params text[],
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (row_id)
);
COMMENT ON TABLE game.action_frames IS 'Roteiro de frames de cada ação: em que frame acontece cada evento (avanço, rótulo de ataque, efeito, dano, zoom, tremor, projétil...). Para = CSV com layout por tipo. Origem: tempinfos.xml/ActionInfos.';
COMMENT ON COLUMN game.action_frames.row_id IS 'Chave substituta (a lista de origem não tem id único).';
COMMENT ON COLUMN game.action_frames.action_id IS 'FK -> ActionTempInfos.ActionId; várias linhas (quadros) por ação, agregadas em ActionTemplateData.frames. [decompiled/core_module/scripts/yishi/resolve/ActionTemplateInfoResolveII.as:33] XML: ActionInfos.ActionId';
COMMENT ON COLUMN game.action_frames.frame_type IS 'Tipo do evento (ver game.action_frame_types). Tipo do quadro. Enum: meta.enum_values.enum_name=''action_frame_type''. [decompiled/core_module/scripts/yishi/resolve/ActionTemplateInfoResolveII.as:20] XML: ActionInfos.ActionType';
COMMENT ON COLUMN game.action_frames.frame IS 'Frame em que o evento dispara (-1 = imediato). Quadro (25 fps, 40 ms) em que o evento dispara, contado desde o início do SimpleScriptAction de ataque; -1 = fora da linha do tempo (movimentos 0/100). Frame 0 executa em onPrepare. [decompiled/core_module/scripts/battle/skillsys/skills/CommonActionSkill.as:83] XML: ActionInfos.Frame';
COMMENT ON COLUMN game.action_frames.sex_id IS 'Sexo a que se aplica (2 = ambos). Filtro de sexo do quadro. Enum: meta.enum_values.enum_name=''frame_sex''. [decompiled/core_module/scripts/battle/skillsys/skills/BaseSkill.as:734] XML: ActionInfos.Sex';
COMMENT ON COLUMN game.action_frames.params IS 'Parâmetros CSV crus (layout em game.action_frame_types.param_names). CSV cujo layout depende de ActionType (ver action_para_layouts). [decompiled/core_module/scripts/battle/skillsys/transform/SkillFrameDataTransform.as:21] XML: ActionInfos.Para';
COMMENT ON COLUMN game.action_frames.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.action_frames.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.skills (
  id integer NOT NULL,
  name text,
  icon text,
  master_type integer,
  son_type integer,
  grade integer,
  prev_skill_ids integer[],
  next_skill_id integer,
  required_player_grade integer,
  slot_index integer,
  use_way smallint,
  appear_time smallint,
  target_kind integer,
  action_id integer,
  cost integer,
  qte_time integer,
  param1 integer,
  param2 integer,
  param3 integer,
  priority smallint,
  buff_ids integer[],
  property_type smallint,
  count_way smallint,
  cooldown_ms integer,
  description text,
  usable_when_dead boolean,
  appear_cooldown_ms integer,
  own_requirements text,
  hit_point_cost integer,
  upgrade_item_id integer,
  upgrade_item_count integer,
  profile smallint,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.skills IS 'Skills de todos os sistemas (herói, tropa, pet, runa, moda, título, deusa, filho...): custo, recarga, alvo, ação animada e buffs aplicados. Origem: tempinfos.xml/SkillTempInfos.';
COMMENT ON COLUMN game.skills.id IS 'PK da skill. Cada nível é uma linha própria (Grades). Ids especiais: 1-4 (SkillData.SKILL_ID_*; 3 Vitória, 4 Derrota), 101-104, 105 (SpecialActionSkill105), 700001/700002 morph/unmorph pet, 700003/700004 morph criança. [decompiled/core_module/scripts/battle/data/SkillData.as:18] XML: SkillTempInfos.TemplateId';
COMMENT ON COLUMN game.skills.name IS 'Nome pt-BR (vazio em muitas genéricas; chinês em auto-xadrez). [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:16] XML: SkillTempInfos.TemplateName';
COMMENT ON COLUMN game.skills.icon IS 'Ícone ''/skill_xxx.png'' -> {RES}icon{Icons} (IconFactory.getTecIconByIcon). [decompiled/core_module/scripts/yishi/utils/IconFactory.as:30] XML: SkillTempInfos.Icons';
COMMENT ON COLUMN game.skills.master_type IS 'Sistema/categoria da skill (ver meta.enum_values skill_master_type). Sistema dono da skill (ver enum). Enum: meta.enum_values.enum_name=''skill_master_type''. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:22] XML: SkillTempInfos.MasterType';
COMMENT ON COLUMN game.skills.son_type IS 'Linha da skill; níveis da mesma linha compartilham son_type. Família/linha da skill (todos os níveis de uma skill compartilham SonType). Usado em upgrades (getSkillTemplateInfoBySonTypeAndGrade), talentos (TalentEffect.EffSkillType) e Vingador (AvengerSkillTemplates.SkillSonType). SonType 1001/2001/3001 = talentos (SkillData.SKILL_SONTYPE_TALENT_ARR). [decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1903] XML: SkillTempInfos.SonType';
COMMENT ON COLUMN game.skills.grade IS 'Nível da skill. Nível da skill dentro do SonType (1..N; 0 em genéricas). Tooltip ''Nv.{Grades}''. [decompiled/m16/scripts/yishi/view/tips/goods/SkillTips.as:193] XML: SkillTempInfos.Grades';
COMMENT ON COLUMN game.skills.prev_skill_ids IS 'Skill(s) do nível anterior/pré-requisito. CSV de TemplateIds pré-requisitos (texto; valores <=0 ignorados) -> preTempList. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:148] XML: SkillTempInfos.PreTemplateId';
COMMENT ON COLUMN game.skills.next_skill_id IS 'Próximo nível. TemplateId do próximo nível (0 = máximo). nextTemp. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:164] XML: SkillTempInfos.NextTemplateId';
COMMENT ON COLUMN game.skills.required_player_grade IS 'Nível de jogador necessário para aprender/subir (0 = sem requisito). [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:32] XML: SkillTempInfos.NeedPlayerGrade';
COMMENT ON COLUMN game.skills.slot_index IS 'Posição no painel de skills. Posição/slot da skill no painel ou ordem (AvengerModel usa Index 30 = skill de perfil; sort por MasterType,Index). [decompiled/core_module/scripts/mvc/module/avenger/AvengerModel.as:283] XML: SkillTempInfos.Index';
COMMENT ON COLUMN game.skills.use_way IS 'Modo de uso (ativa/passiva/automática; ver SkillUseWayType). Ativa/passiva/ataque padrão/gatilho de lousa. Enum: meta.enum_values.enum_name=''skill_use_way''. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:169] XML: SkillTempInfos.UseWay';
COMMENT ON COLUMN game.skills.appear_time IS 'Não lido pelo cliente; 1/2. Enum: meta.enum_values.enum_name=''skill_appear_time''. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:38] XML: SkillTempInfos.AppearTime';
COMMENT ON COLUMN game.skills.target_kind IS 'Alvo (próprio, aliado, inimigo, área...; ver enum accept_object). Alvo da skill; getter retorna o EffAttackObject do último talento aplicável se != 0. Enum: meta.enum_values.enum_name=''skill_accept_object''. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:133] XML: SkillTempInfos.AcceptObject';
COMMENT ON COLUMN game.skills.action_id IS 'Ação animada. Animação: ActionTempInfos/ActionInfos.ActionId (0 = sem animação -> BaseSkill vazio). 17089 skills têm 0. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:143] XML: SkillTempInfos.ActionId';
COMMENT ON COLUMN game.skills.cost IS 'Custo (fúria/SP). Fúria (SP). Negativo = consumo, mostrado como ''Consumo de fúria: |Cost|'' (ou ''Consumo: N'' quando ''param1'' no tooltip). Para MasterType 500/501 e Cost>0 = custo em slots de vingança Cost/10. Getter aplica talentos: Cost + Cost*ΣEffSpPercent/100 + ΣEffSpValue. Placeholder {Cost} na descrição. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:216] XML: SkillTempInfos.Cost';
COMMENT ON COLUMN game.skills.qte_time IS 'Janela de QTE em ms (0 = sem QTE). Janela de QTE em ms (HeroOrderMsg.qte_time; QteView usa time/1500 teclas e timeout time-400). Sempre 0 nos dados BR => QTE desativado. Ver docs/BATTLE.md §4. [decompiled/core_module/scripts/battle/view/ui/SkillItemListController.as:924] XML: SkillTempInfos.QTETime';
COMMENT ON COLUMN game.skills.param1 IS 'Parâmetro 1 (geralmente % de dano). Parâmetro 1 (normalmente % de dano). Placeholder {Parameter1} na Description, modificado por ΣEffDamPercent e mostrado em valor absoluto. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:383] XML: SkillTempInfos.Parameter1';
COMMENT ON COLUMN game.skills.param2 IS 'Parâmetro 2 (geralmente % de chance). Parâmetro 2 (normalmente dano fixo). {Parameter2} = |P2 + P2*ΣEffDamPercent/100 + ΣEffDamValue|. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:408] XML: SkillTempInfos.Parameter2';
COMMENT ON COLUMN game.skills.param3 IS 'Parâmetro 3. O cliente trata como id de skill alternativa no auto-combate (controllers ...ItemListController: TemplateId==id || (isAutoFight && Parameter3==id)) e pré-carrega seus recursos (SkillResourceLoader.as:297). Nos dados BR só aparece 2..18 em talentos ''Laceração'' (redução de fúria) – não é id. [decompiled/core_module/scripts/battle/skillsys/loader/SkillResourceLoader.as:297] XML: SkillTempInfos.Parameter3';
COMMENT ON COLUMN game.skills.priority IS 'Prioridade de execução (SkillPriorityType). Tier: 3 = super skill (efeito profound + selo na barra). Enum: meta.enum_values.enum_name=''skill_priority''. [decompiled/core_module/scripts/battle/skillsys/skills/CommonActionSkill.as:39] XML: SkillTempInfos.Priority';
COMMENT ON COLUMN game.skills.buff_ids IS 'Buffs aplicados (ver game.skill_buff_links). CSV de SkillBufferTempInfos.Id que a skill pode aplicar. Usado para pré-carregar efeitos (SkillResourceLoader.addSkill) e para coletar TalentEffIds; os buffs reais vêm do servidor em AttackOrderMsg.buffers. [decompiled/core_module/scripts/battle/skillsys/loader/SkillResourceLoader.as:160] XML: SkillTempInfos.BufferIds';
COMMENT ON COLUMN game.skills.property_type IS 'Elemento/propriedade do dano. Moldura de qualidade (setFrame) em itens de tesouro/Teseu. Enum: meta.enum_values.enum_name=''skill_proper_type''. [decompiled/core_module/scripts/yishi/view/tips/goods/TreasureSkillItem.as:30] XML: SkillTempInfos.ProperType';
COMMENT ON COLUMN game.skills.count_way IS 'Forma de cálculo do valor. Modo de cálculo do servidor; não lido pelo cliente. Enum: meta.enum_values.enum_name=''skill_count_way''. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:58] XML: SkillTempInfos.CountWay';
COMMENT ON COLUMN game.skills.cooldown_ms IS 'Recarga em ms. Recarga em ms (tooltip mostra CoolDown*0.001 s). Getter: (CD + CD*ΣEffCdPercent/100 + ΣEffCdValue) truncado para múltiplo de 1000 ms. Ex.: 30000 (680 skills), 15000 (624). [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:182] XML: SkillTempInfos.CoolDown';
COMMENT ON COLUMN game.skills.description IS 'Texto pt-BR com placeholders {Parameter1} {Parameter2} {Cost} {HitPointCost} substituídos por getDealDescript. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:442] XML: SkillTempInfos.Description';
COMMENT ON COLUMN game.skills.usable_when_dead IS '1 = item/skill utilizável com herói morto (TrailPropInfo em SkillItemListView). Só 103 e 40201009. [decompiled/core_module/scripts/battle/view/ui/SkillItemListView.as:480] XML: SkillTempInfos.IsUseOnDead';
COMMENT ON COLUMN game.skills.appear_cooldown_ms IS 'CD inicial (ms) antes de a skill ficar disponível na batalha (startAppearCD). 10000 em 16 skills EX de pet (Despertar). [decompiled/core_module/scripts/battle/view/ui/BattleSkillItemII.as:677] XML: SkillTempInfos.AppearCD';
COMMENT ON COLUMN game.skills.own_requirements IS 'Requisitos do dono: CSV numérico (ex.: "1,7") ou, em skills de guilda, texto livre com a condição. Formato ''tipoSombra,quantidade'' -> efeito fantasma no corpo (ShadowEffectMaker.startPhantom(body, qtd, 0, ShadowTypeEnum[tipo])). Em 2 linhas contém texto de requisito de guilda (GuildFbOneBuffTip mostra o texto). Enum: meta.enum_values.enum_name=''shadow_effect_type''. [decompiled/core_module/scripts/battle/skillsys/skills/BaseSkill.as:370] XML: SkillTempInfos.OwnRequirements';
COMMENT ON COLUMN game.skills.hit_point_cost IS 'Custo de hit point (recurso do DragonTalker, BloodType 24). Negativo = consumo, tooltip ''Consumo de HP: |v|''; placeholder {HitPointCost}. [decompiled/m16/scripts/yishi/view/tips/goods/SkillTips.as:222] XML: SkillTempInfos.HitPointCost';
COMMENT ON COLUMN game.skills.upgrade_item_id IS 'ItemTempInfos.TemplateId necessário para subir (pet de expedição 2131200, guardião PVE 2131201). [decompiled/core_module/scripts/mvc/module/armyII/SkillInfo.as:152] XML: SkillTempInfos.UpgradeNeedItem';
COMMENT ON COLUMN game.skills.upgrade_item_count IS 'Quantidade do item de upgrade (comparado com o próximo nível). [decompiled/m14/scripts/remotepet/views/RemoteSkillItemView.as:125] XML: SkillTempInfos.UpgradeNeedCount';
COMMENT ON COLUMN game.skills.profile IS 'Qualidade/cor. Sempre vazio nos dados BR; sem campo na classe SkillTempInfo (ignorado). [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:11] XML: SkillTempInfos.Profile';
COMMENT ON COLUMN game.skills.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.skills.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.buffs (
  id integer NOT NULL,
  name text,
  attack_data smallint,
  add_way smallint,
  attack_type integer,
  target_kind smallint,
  valid_count integer,
  attack_way smallint,
  value integer,
  count_way smallint,
  icon text,
  add_effect text,
  action_effect text,
  value_percent integer,
  last_effect text,
  press_count integer,
  talent_effect_ids integer[],
  dispellable boolean,
  extra_text text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.buffs IS 'Buffs/debuffs aplicados por skills: modo de aplicação, alvo, valor fixo/percentual, duração em turnos/contagem, efeitos visuais (AddEffect/ActionEffect/LastEffect). Origem: tempinfos.xml/SkillBufferTempInfos.';
COMMENT ON COLUMN game.buffs.id IS 'PK do buff (BufferMsg.template_id). [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:6] XML: SkillBufferTempInfos.Id';
COMMENT ON COLUMN game.buffs.name IS 'Nome/descrição pt-BR; pode ter UM placeholder {Campo} (ex. {ValuePercent}) substituído por |template[Campo]| * layerCount no tooltip. [decompiled/core_module/scripts/battle/view/buffer/BufferListItemTip.as:178] XML: SkillBufferTempInfos.BufferName';
COMMENT ON COLUMN game.buffs.attack_data IS 'Polaridade (benéfico/maléfico). Enum: meta.enum_values.enum_name=''buff_polarity''. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:10] XML: SkillBufferTempInfos.AttackData';
COMMENT ON COLUMN game.buffs.add_way IS 'Como é aplicado/empilhado. Quando aplicar (effectiveType). Enum: meta.enum_values.enum_name=''buff_add_way''. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:20] XML: SkillBufferTempInfos.AddWay';
COMMENT ON COLUMN game.buffs.attack_type IS 'Tipo do efeito (atributo/estado afetado). Tipo de efeito (código < 2000) ou id de template para buffs roteirizados. Enum: meta.enum_values.enum_name=''buff_attack_type''. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:12] XML: SkillBufferTempInfos.AttackType';
COMMENT ON COLUMN game.buffs.target_kind IS 'Objeto do efeito; não lido pelo cliente. Enum: meta.enum_values.enum_name=''buff_attack_object''. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:14] XML: SkillBufferTempInfos.AttackObject';
COMMENT ON COLUMN game.buffs.valid_count IS 'Duração (turnos/ações; -1 = permanente). Duração em turnos (BufferMsg.max_turn/cur_turn, tooltip ''N turnos''); -1 = permanente; 99/999 ≈ permanente. Placeholder {ValidCount} em Parm3. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:16] XML: SkillBufferTempInfos.ValidCount';
COMMENT ON COLUMN game.buffs.attack_way IS 'Gatilho. Enum: meta.enum_values.enum_name=''buff_attack_way''. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:22] XML: SkillBufferTempInfos.AttackWay';
COMMENT ON COLUMN game.buffs.value IS 'Valor fixo. Valor fixo do efeito (pontos; ex. 30 de fúria inicial). Para AttackType 310 = 1º slot selado. Escalado por talentos: AV*(100+ΣEffBuffPercent)/100+ΣEffBuffValue. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:24] XML: SkillBufferTempInfos.AttackValue';
COMMENT ON COLUMN game.buffs.count_way IS 'Máximo de disparos (''vezes''). Enum: meta.enum_values.enum_name=''buff_count_way''. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:34] XML: SkillBufferTempInfos.CountWay';
COMMENT ON COLUMN game.buffs.icon IS 'Ícone ''/xxx.png'' -> {RES}icon/{Icon} (IconFactory.getCommonIconPath); vazio = buff invisível. [decompiled/core_module/scripts/battle/view/buffer/BufferListItemTip.as:116] XML: SkillBufferTempInfos.Icon';
COMMENT ON COLUMN game.buffs.add_effect IS 'Efeito visual ao aplicar: ''chave,parâmetro'' (ex.: buff.action.attack,2). ''chave,pos'' – animação única ao adicionar (SHOW_BUFFER). chave = link de classe; pos = special_pos. Enum: meta.enum_values.enum_name=''buff_effect_anim_key''. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:59] XML: SkillBufferTempInfos.AddEffect';
COMMENT ON COLUMN game.buffs.action_effect IS 'Efeito visual ao agir. ''chave,pos'' – animação a cada disparo (bufferAffectActionII -> addBufferActionEffect). Enum: meta.enum_values.enum_name=''buff_effect_anim_key''. [decompiled/core_module/scripts/battle/view/roles/RoleViewBase.as:693] XML: SkillBufferTempInfos.ActionEffect';
COMMENT ON COLUMN game.buffs.value_percent IS 'Valor percentual. Valor percentual do efeito (ex. -90 = -90% dano recebido). Para 310 = último slot selado. Escalado como AttackValue. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:28] XML: SkillBufferTempInfos.ValuePercent';
COMMENT ON COLUMN game.buffs.last_effect IS 'Efeito visual contínuo: ''chave,camada,duração'' (ex.: buff.add.MDFup,1,5). ''chave,pos,intervalo'' – animação contínua enquanto o buff existe (BufferLastEffect); intervalo em quadros (x40 ms) entre repetições, 0 = loop. Enum: meta.enum_values.enum_name=''buff_effect_anim_key''. [decompiled/core_module/scripts/battle/view/buffer/BufferLastEffect.as:49] XML: SkillBufferTempInfos.LastEffect';
COMMENT ON COLUMN game.buffs.press_count IS 'Limite de acúmulo. Máximo de camadas (stack); 0 = não acumula; ícone mostra layerCount (BufferMsg.pressed_num) se >1. Tooltip ''Pode no máximo acumular camadas: N camadas''. [decompiled/core_module/scripts/battle/view/buffer/BufferListItemTip.as:146] XML: SkillBufferTempInfos.PressCount';
COMMENT ON COLUMN game.buffs.talent_effect_ids IS 'Efeitos de talento ligados. CSV de TalentEffectTempInfos.TemplateId que este buff ativa (modificadores de skill enquanto o buff está no herói/aprendido como talento). [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:302] XML: SkillBufferTempInfos.TalentEffIds';
COMMENT ON COLUMN game.buffs.dispellable IS '1 = indispersável. Enum: meta.enum_values.enum_name=''buff_dispel''. [decompiled/core_module/scripts/yishi/datas/templates/BufferTemplateInfo.as:18] XML: SkillBufferTempInfos.Dispel';
COMMENT ON COLUMN game.buffs.extra_text IS 'Texto/descrição adicional. Texto de descrição extra (traços de acessório de monstro) com {AttackValue} {ValuePercent} {Random} {ValidCount}, ou listas ''buffId,peso;...'' / ids (suposição). ''0'' = vazio. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:778] XML: SkillBufferTempInfos.Parm3';
COMMENT ON COLUMN game.buffs.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.buffs.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.talent_effects (
  id integer NOT NULL,
  skill_son_type integer,
  sp_percent integer,
  sp_value integer,
  damage_percent integer,
  damage_value integer,
  cooldown_percent integer,
  cooldown_value integer,
  cast_time_percent integer,
  cast_time_value integer,
  critical_value integer,
  target_kind integer,
  buff_flag integer,
  buff_ids integer[],
  buff_type integer,
  buff_percent integer,
  buff_value integer,
  random_percent integer,
  random_value integer,
  count_percent integer,
  count_value integer,
  is_active boolean,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.talent_effects IS 'Modificadores de talento sobre skills: alteram custo, dano, recarga, crítico, buffs e aleatoriedade de skills de um tipo. Origem: tempinfos.xml/TalentEffectTempInfos.';
COMMENT ON COLUMN game.talent_effects.id IS 'ID do efeito de talento; referenciado por SkillBufferTempInfos.TalentEffIds. [decompiled/core_module/scripts/yishi/datas/templates/TalentEffectInfo.as:6] XML: TalentEffectTempInfos.TemplateId';
COMMENT ON COLUMN game.talent_effects.skill_son_type IS 'SonType da skill afetada. Habilidade afetada: compara com SkillTempInfos.SonType (-1 = todas). Enum: meta.enum_values.enum_name=''talent_eff_skill_type''. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:308] XML: TalentEffectTempInfos.EffSkillType';
COMMENT ON COLUMN game.talent_effects.sp_percent IS 'Variação % do custo de Fúria (SP) da habilidade (−30/−50…). [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:230] XML: TalentEffectTempInfos.EffSpPercent';
COMMENT ON COLUMN game.talent_effects.sp_value IS 'Variação absoluta do custo de Fúria. Cost é negativo = consumo, logo +20 reduz consumo em 20 e −2 aumenta em 2. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:234] XML: TalentEffectTempInfos.EffSpValue';
COMMENT ON COLUMN game.talent_effects.damage_percent IS 'Variação % aplicada a Parameter1/Parameter2 (dano %) da habilidade. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:396] XML: TalentEffectTempInfos.EffDamPercent';
COMMENT ON COLUMN game.talent_effects.damage_value IS 'Valor fixo somado a Parameter2; sempre 0 no XML. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:426] XML: TalentEffectTempInfos.EffDamValue';
COMMENT ON COLUMN game.talent_effects.cooldown_percent IS 'Variação % do CoolDown (−100 = zera CD; talento 2000/…). [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:196] XML: TalentEffectTempInfos.EffCdPercent';
COMMENT ON COLUMN game.talent_effects.cooldown_value IS 'Variação da recarga em ms. Variação do CoolDown em milissegundos (−1000…−34000; resultado truncado a segundos inteiros). [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:200] XML: TalentEffectTempInfos.EffCdValue';
COMMENT ON COLUMN game.talent_effects.cast_time_percent IS 'Variação % do tempo de conjuração/QTE (suposição); sempre 0, sem uso no cliente. [decompiled/core_module/scripts/yishi/datas/templates/TalentEffectInfo.as:22] XML: TalentEffectTempInfos.EffCtPercent';
COMMENT ON COLUMN game.talent_effects.cast_time_value IS 'Variação absoluta do tempo de conjuração (suposição); sempre 0, sem uso no cliente. [decompiled/core_module/scripts/yishi/datas/templates/TalentEffectInfo.as:24] XML: TalentEffectTempInfos.EffCtValue';
COMMENT ON COLUMN game.talent_effects.critical_value IS 'Bônus de crítico (pontos %) da habilidade — calculado no servidor (sem uso no cliente). [decompiled/core_module/scripts/yishi/datas/templates/TalentEffectInfo.as:26] XML: TalentEffectTempInfos.EffCriValue';
COMMENT ON COLUMN game.talent_effects.target_kind IS 'Se ≠0 substitui AcceptObject (alvo) da habilidade; sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/SkillTempInfo.as:262] XML: TalentEffectTempInfos.EffAttackObject';
COMMENT ON COLUMN game.talent_effects.buff_flag IS 'Flag ''adiciona buffer'' (suposição); sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/TalentEffectInfo.as:30] XML: TalentEffectTempInfos.EffBuffer';
COMMENT ON COLUMN game.talent_effects.buff_ids IS 'Lista CSV de SkillBufferTempInfos.Id aplicados/pré-carregados pelo talento (SkillResourceLoader carrega efeitos visuais). [decompiled/core_module/scripts/battle/skillsys/loader/SkillResourceLoader.as:110] XML: TalentEffectTempInfos.EffBufferIds';
COMMENT ON COLUMN game.talent_effects.buff_type IS 'Buffer (ou AttackType) cujo valor é modificado pelos campos EffBuff*/EffRand*/EffCount*. Enum: meta.enum_values.enum_name=''talent_eff_buffer_type''. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:762] XML: TalentEffectTempInfos.EffBufferType';
COMMENT ON COLUMN game.talent_effects.buff_percent IS '% somado a AttackValue e ValuePercent do buffer-alvo: v*(100+Σ)/100 (valores 200-1500). [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:777] XML: TalentEffectTempInfos.EffBuffPercent';
COMMENT ON COLUMN game.talent_effects.buff_value IS 'Valor fixo somado a AttackValue/ValuePercent do buffer-alvo. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:777] XML: TalentEffectTempInfos.EffBuffValue';
COMMENT ON COLUMN game.talent_effects.random_percent IS '% aplicado à probabilidade (Random) do buffer-alvo. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:779] XML: TalentEffectTempInfos.EffRandPercent';
COMMENT ON COLUMN game.talent_effects.random_value IS 'Pontos somados à probabilidade (Random) do buffer-alvo (100 = garante). [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:779] XML: TalentEffectTempInfos.EffRandValue';
COMMENT ON COLUMN game.talent_effects.count_percent IS '% aplicado a ValidCount (duração/turnos) do buffer-alvo; sempre 0. [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:768] XML: TalentEffectTempInfos.EffCountPercent';
COMMENT ON COLUMN game.talent_effects.count_value IS 'Turnos/contagens somados a ValidCount do buffer-alvo (1/2/4). [decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as:780] XML: TalentEffectTempInfos.EffCountValue';
COMMENT ON COLUMN game.talent_effects.is_active IS 'Flag ativo/condicional (sem uso no cliente). Enum: meta.enum_values.enum_name=''talent_is_active''. [decompiled/core_module/scripts/yishi/datas/templates/TalentEffectInfo.as:48] XML: TalentEffectTempInfos.EffIsActive';
COMMENT ON COLUMN game.talent_effects.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.talent_effects.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.stat_bonus_profiles (
  id integer NOT NULL,
  add_type smallint,
  power integer,
  agility integer,
  intellect integer,
  physique integer,
  leadership integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  hit_points integer,
  critical integer,
  parry integer,
  penetration integer,
  determination integer,
  fire_resist integer,
  water_resist integer,
  electric_resist integer,
  wind_resist integer,
  dark_resist integer,
  light_resist integer,
  resist_reduction integer,
  resist_reduction_defense integer,
  resist_penetration integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.stat_bonus_profiles IS 'Perfis de bônus de atributos referenciados por skills passivas, monstros e outros sistemas (AddType = fixo ou percentual). Origem: tempinfos.xml/SkillPropertyTempInfos.';
COMMENT ON COLUMN game.stat_bonus_profiles.id IS 'PK = SkillTempInfos.TemplateId da skill passiva de atributo (11541 de 11924 casam). Lido por runas/estelas/títulos/moda/casamento/monstros (skillPropertyTemplateCate.getTemplateByID(skillId)). [decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as:496] XML: SkillPropertyTempInfos.TemplateId';
COMMENT ON COLUMN game.stat_bonus_profiles.add_type IS '1 = valor fixo, 2 = percentual (suposição). 0 = %, 1 = fixo, 2 = especial. Enum: meta.enum_values.enum_name=''skill_property_add_type''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:8] XML: SkillPropertyTempInfos.AddType';
COMMENT ON COLUMN game.stat_bonus_profiles.power IS 'Força (Power). Bônus de Força (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Power';
COMMENT ON COLUMN game.stat_bonus_profiles.agility IS 'Proteção (XML Agility: +4 defesa, +4 resistência) (Agility). Bônus de Proteção (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Agility';
COMMENT ON COLUMN game.stat_bonus_profiles.intellect IS 'Inteligência (Intellect). Bônus de Inteligência (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Intellect';
COMMENT ON COLUMN game.stat_bonus_profiles.physique IS 'Físico (constituição) (Physique). Bônus de Físico (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Physique';
COMMENT ON COLUMN game.stat_bonus_profiles.leadership IS 'Liderança (Captain). Bônus de Liderança (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Captain';
COMMENT ON COLUMN game.stat_bonus_profiles.attack IS 'Ataque físico (Attack). Bônus de Ataque Físico (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Attack';
COMMENT ON COLUMN game.stat_bonus_profiles.defense IS 'Defesa física (Defence). Bônus de Defesa Física (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Defence';
COMMENT ON COLUMN game.stat_bonus_profiles.magic_attack IS 'Ataque mágico (MagicAttack). Bônus de Ataque Mágico (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.MagicAttack';
COMMENT ON COLUMN game.stat_bonus_profiles.magic_defense IS 'Defesa mágica (MagicDefence). Bônus de Defesa Mágica (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.MagicDefence';
COMMENT ON COLUMN game.stat_bonus_profiles.hit_points IS 'Vida (HP) (Live). Bônus de Vida (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Live';
COMMENT ON COLUMN game.stat_bonus_profiles.critical IS 'Crítico (ForceHit). Bônus de Crítico (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.ForceHit';
COMMENT ON COLUMN game.stat_bonus_profiles.parry IS 'Bloqueio (aparar) (Parry). Bônus de Bloqueio (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Parry';
COMMENT ON COLUMN game.stat_bonus_profiles.penetration IS 'Penetração (Penetrate). Bônus de Penetração (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.Penetrate';
COMMENT ON COLUMN game.stat_bonus_profiles.determination IS 'Determinação/Força Consistente (resistência a atordoamento) (StunAttr). Bônus de Atributo de atordoamento/Determinação (suposição) (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.StunAttr';
COMMENT ON COLUMN game.stat_bonus_profiles.fire_resist IS 'Resistência a fogo (FireResi). Bônus de Resistência a Fogo (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.FireResi';
COMMENT ON COLUMN game.stat_bonus_profiles.water_resist IS 'Resistência a água (WaterResi). Bônus de Resistência a Água (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.WaterResi';
COMMENT ON COLUMN game.stat_bonus_profiles.electric_resist IS 'Resistência a eletricidade (ElectResi). Bônus de Resistência a Choque (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.ElectResi';
COMMENT ON COLUMN game.stat_bonus_profiles.wind_resist IS 'Resistência a vento (WindResi). Bônus de Resistência a Vento (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.WindResi';
COMMENT ON COLUMN game.stat_bonus_profiles.dark_resist IS 'Resistência a trevas (DarkResi). Bônus de Resistência a Escuridão (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.DarkResi';
COMMENT ON COLUMN game.stat_bonus_profiles.light_resist IS 'Resistência a luz (LightResi). Bônus de Resistência a Luz (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.LightResi';
COMMENT ON COLUMN game.stat_bonus_profiles.resist_reduction IS 'Redução de resistência (anti-RES) (ReduceResi). Bônus de Resistência a Redução (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.ReduceResi';
COMMENT ON COLUMN game.stat_bonus_profiles.resist_reduction_defense IS 'Defesa contra redução de resistência (ReduceResiAgainst). Bônus de Anti-Res. (PropertyName.ReduceResiAgainst) (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.ReduceResiAgainst';
COMMENT ON COLUMN game.stat_bonus_profiles.resist_penetration IS 'Penetração de resistência (ResiPenetrate). Bônus de Res. de Penetração (unidade conforme AddType: pontos ou %). allAttName lista colunas != 0. Enum: meta.enum_values.enum_name=''stat_attribute_name''. [decompiled/core_module/scripts/yishi/datas/templates/SkillPropertyTempInfo.as:67] XML: SkillPropertyTempInfos.ResiPenetrate';
COMMENT ON COLUMN game.stat_bonus_profiles.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.stat_bonus_profiles.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.city_effects (
  id integer NOT NULL,
  camp smallint,
  name text,
  owner_type smallint,
  max_grade integer,
  required_player_grade integer,
  required_building_id integer,
  prev_effect_id integer,
  use_type smallint,
  property_type1 integer,
  property1 integer,
  property_type2 integer,
  property2 integer,
  property_type3 integer,
  property3 integer,
  description text,
  icon text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.city_effects IS 'Efeitos/tecnologias de cidade (castelo): bônus de produção, disfarce etc. Origem: tempinfos.xml/EffectTempInfos.';
COMMENT ON COLUMN game.city_effects.id IS 'PK; = OwnTypes*1000 + PropertyType1 na maioria. Referenciado por PlayerBufferInfo (tipos 2 e 4) e PlayerTalentInfo. [decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerBufferInfo.as:259] XML: EffectTempInfos.TemplateId';
COMMENT ON COLUMN game.city_effects.camp IS 'Sempre 1 (facção; suposição). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:36] XML: EffectTempInfos.Camp';
COMMENT ON COLUMN game.city_effects.name IS 'Nome pt-BR (vazio nos blocos de construção). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:8] XML: EffectTempInfos.EffectName';
COMMENT ON COLUMN game.city_effects.owner_type IS 'Dono do efeito. Enum: meta.enum_values.enum_name=''effect_own_type''. [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:10] XML: EffectTempInfos.OwnTypes';
COMMENT ON COLUMN game.city_effects.max_grade IS 'Nível máximo (sempre 1). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:12] XML: EffectTempInfos.MaxGrade';
COMMENT ON COLUMN game.city_effects.required_player_grade IS 'Nível de jogador requerido (sempre 1). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:14] XML: EffectTempInfos.PlayerGrade';
COMMENT ON COLUMN game.city_effects.required_building_id IS 'Prédio pré-requisito (texto; sempre 0). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:34] XML: EffectTempInfos.PreBuildingtemplateId';
COMMENT ON COLUMN game.city_effects.prev_effect_id IS 'Efeito pré-requisito (sempre 0). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:16] XML: EffectTempInfos.PreTemplateId';
COMMENT ON COLUMN game.city_effects.use_type IS 'Sempre 1 (suposição: efeito passivo permanente enquanto o buff durar). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:18] XML: EffectTempInfos.UseType';
COMMENT ON COLUMN game.city_effects.property_type1 IS 'Código do atributo afetado. Enum: meta.enum_values.enum_name=''stat_property_code''. [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:20] XML: EffectTempInfos.PropertyType1';
COMMENT ON COLUMN game.city_effects.property1 IS 'Valor por nível/grau (ex. 240 ouro; 1 quando o valor real vem do grau do buff -> {Grades} na Description). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:22] XML: EffectTempInfos.Property1';
COMMENT ON COLUMN game.city_effects.property_type2 IS '2º código (sempre 1 = sem uso). Enum: meta.enum_values.enum_name=''stat_property_code''. [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:24] XML: EffectTempInfos.PropertyType2';
COMMENT ON COLUMN game.city_effects.property2 IS 'Sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:26] XML: EffectTempInfos.Property2';
COMMENT ON COLUMN game.city_effects.property_type3 IS '3º código (sempre 1 = sem uso). Enum: meta.enum_values.enum_name=''stat_property_code''. [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:28] XML: EffectTempInfos.PropertyType3';
COMMENT ON COLUMN game.city_effects.property3 IS 'Sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:30] XML: EffectTempInfos.Property3';
COMMENT ON COLUMN game.city_effects.description IS 'Texto pt-BR; {Grades} = grau/valor do buff do jogador (BufferDataMsg.grade). [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:32] XML: EffectTempInfos.Description';
COMMENT ON COLUMN game.city_effects.icon IS 'Ícone do buff de jogador. [decompiled/core_module/scripts/yishi/datas/templates/EffectTemplateInfo.as:38] XML: EffectTempInfos.Icon';
COMMENT ON COLUMN game.city_effects.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.city_effects.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.campaign_buffs (
  id integer NOT NULL,
  name text,
  icon text,
  buff_type smallint,
  grade integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  lead_pawn integer,
  hit_points integer,
  critical integer,
  parry integer,
  description text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.campaign_buffs IS 'Buffs temporários de campo de batalha/campanha (ex.: ao matar o guardião), com bônus de atributos. Origem: tempinfos.xml/CampaignBufferTemps.';
COMMENT ON COLUMN game.campaign_buffs.id IS 'PK (PlayerBufferType 0 / ArmyBufferMsg.buffer_tempId). [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:6] XML: CampaignBufferTemps.TemplateId';
COMMENT ON COLUMN game.campaign_buffs.name IS 'Nome pt-BR. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:8] XML: CampaignBufferTemps.TemplateName';
COMMENT ON COLUMN game.campaign_buffs.icon IS 'Ícone. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:14] XML: CampaignBufferTemps.Icon';
COMMENT ON COLUMN game.campaign_buffs.buff_type IS 'Família. Enum: meta.enum_values.enum_name=''campaign_buffer_type''. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:10] XML: CampaignBufferTemps.Types';
COMMENT ON COLUMN game.campaign_buffs.grade IS 'Nível dentro da família (getTemplateByTypeAndGrades). [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:12] XML: CampaignBufferTemps.Grades';
COMMENT ON COLUMN game.campaign_buffs.attack IS 'Bônus de Ataque (% na maioria; pontos em Types 7 ''Ataque +500''). Tooltip godsEvening.campaignBuffer.tip usa addCount*Attack. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:16] XML: CampaignBufferTemps.Attack';
COMMENT ON COLUMN game.campaign_buffs.defense IS 'Bônus de Defesa (% na maioria; pontos em Types 7 ''Ataque +500''). Tooltip godsEvening.campaignBuffer.tip usa addCount*Attack. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:16] XML: CampaignBufferTemps.Defence';
COMMENT ON COLUMN game.campaign_buffs.magic_attack IS 'Bônus de Magia (% na maioria; pontos em Types 7 ''Ataque +500''). Tooltip godsEvening.campaignBuffer.tip usa addCount*Attack. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:16] XML: CampaignBufferTemps.MagicAttack';
COMMENT ON COLUMN game.campaign_buffs.magic_defense IS 'Bônus de Resistência (% na maioria; pontos em Types 7 ''Ataque +500''). Tooltip godsEvening.campaignBuffer.tip usa addCount*Attack. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:16] XML: CampaignBufferTemps.MagicDefence';
COMMENT ON COLUMN game.campaign_buffs.lead_pawn IS 'Bônus de tropa liderada. Bônus de Infantaria/tropa (% na maioria; pontos em Types 7 ''Ataque +500''). Tooltip godsEvening.campaignBuffer.tip usa addCount*Attack. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:16] XML: CampaignBufferTemps.Leadpawn';
COMMENT ON COLUMN game.campaign_buffs.hit_points IS 'Bônus de Vida (% na maioria; pontos em Types 7 ''Ataque +500''). Tooltip godsEvening.campaignBuffer.tip usa addCount*Attack. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:16] XML: CampaignBufferTemps.Live';
COMMENT ON COLUMN game.campaign_buffs.critical IS 'Bônus de crítico (150 em 3 linhas). Coluna não existe na classe AS3 (ignorada pelo cliente). [data/tpl/tempinfos/CampaignBufferTemps.xml] XML: CampaignBufferTemps.Crit';
COMMENT ON COLUMN game.campaign_buffs.parry IS 'Bônus de bloqueio (150 em 3 linhas). Coluna não existe na classe AS3. [data/tpl/tempinfos/CampaignBufferTemps.xml] XML: CampaignBufferTemps.Block';
COMMENT ON COLUMN game.campaign_buffs.description IS 'Texto pt-BR. [decompiled/core_module/scripts/yishi/datas/templates/CampaignBufferTemp.as:32] XML: CampaignBufferTemps.Description';
COMMENT ON COLUMN game.campaign_buffs.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.campaign_buffs.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.items (
  id integer NOT NULL,
  name text,
  master_type integer,
  son_type integer,
  sex_id smallint,
  required_grade integer,
  max_stack integer,
  job_ids integer[],
  refresh integer,
  icon text,
  description text,
  profile smallint,
  sell_gold integer,
  default_skill_ids integer[],
  avatar_path text,
  strengthen_max integer,
  random_skill_count integer,
  suite_id integer,
  starting_price integer,
  transform_id integer,
  is_batch_usable boolean,
  feed integer,
  required_job_change integer,
  property1 integer,
  property2 integer,
  property3 integer,
  property4 integer,
  property5 integer,
  property6 integer,
  property7 integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  hit_points integer,
  critical integer,
  parry integer,
  power integer,
  agility integer,
  intellect integer,
  physique integer,
  leadership integer,
  determination integer,
  troop_capacity integer,
  strength integer,
  tenacity integer,
  penetration integer,
  fire_resist integer,
  water_resist integer,
  electric_resist integer,
  wind_resist integer,
  dark_resist integer,
  light_resist integer,
  resist_reduction integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.items IS 'Todos os itens: equipamentos, modas, consumíveis, gemas, materiais, moedas virtuais (ids negativos). MasterType/SonType definem a categoria. Origem: tempinfos.xml/ItemTempInfos.';
COMMENT ON COLUMN game.items.id IS 'Id do item; negativos = moedas virtuais (-100 ouro, -400 diamante...). Id do item. Negativos = moedas virtuais (-100 Ouro, -200 Ametistas, -300 Espírito, -400 Diamante, -500 Diamante vinculado, -700 Experiência, -1000 Emblema do Rei...). [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:14] XML: ItemTempInfos.TemplateId';
COMMENT ON COLUMN game.items.name IS 'Nome pt-BR. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:26] XML: ItemTempInfos.TemplateName';
COMMENT ON COLUMN game.items.master_type IS 'Categoria (1 equipamento/moda, 2 consumível/material, ...; ver game.item_categories). Categoria principal. Enum: meta.enum_values.enum_name=''item_master_type''. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:16] XML: ItemTempInfos.MasterType';
COMMENT ON COLUMN game.items.son_type IS 'Subcategoria (101 arma, 104 armadura, 109 asa, 110 chapéu, 111 arma de moda, 112 roupa de moda...). Subtipo; define slot de equipamento, tip, uso e semântica de Property1..7. Enum: meta.enum_values.enum_name=''item_son_type''. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:18] XML: ItemTempInfos.SonType';
COMMENT ON COLUMN game.items.sex_id IS 'Sexo exigido (2 = qualquer). Enum: meta.enum_values.enum_name=''item_sex''. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:20] XML: ItemTempInfos.Sexs';
COMMENT ON COLUMN game.items.required_grade IS 'Nível mínimo do herói (0 = sem). Para 117/118 com transferência usa vocationGrades. [decompiled/core_module/scripts/bag/datas/GoodsSonType.as:471] XML: ItemTempInfos.NeedGrades';
COMMENT ON COLUMN game.items.max_stack IS 'Tamanho máximo da pilha (1, 99, 999, 9999, 99999, 10000000, 100000000). [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:24] XML: ItemTempInfos.MaxCount';
COMMENT ON COLUMN game.items.job_ids IS 'Classes permitidas (0 = todas). CSV de profissões permitidas (0 = todas; 99 = Encantador de Dragões; 5..10/101..105 = tipos de guardião). Enum: meta.enum_values.enum_name=''job_type''. [decompiled/core_module/scripts/bag/datas/GoodsSonType.as:449] XML: ItemTempInfos.Job';
COMMENT ON COLUMN game.items.refresh IS 'Equipamento: TemplateId da Pedra da Purificação para re-sortear habilidades aleatórias; também flag de decomposição (0 não, -1 bloqueado). Enum: meta.enum_values.enum_name=''item_refresh''. [decompiled/core_module/scripts/mvc/controler/StoreControler.as:1185] XML: ItemTempInfos.Refresh';
COMMENT ON COLUMN game.items.icon IS 'Ícone: PathManager.resourcePath + ''icon'' + Icon (ex.: icon/wing_abyssforger.png). [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:135] XML: ItemTempInfos.Icon';
COMMENT ON COLUMN game.items.description IS 'Descrição pt-BR (origem do item). [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:76] XML: ItemTempInfos.Description';
COMMENT ON COLUMN game.items.profile IS 'Qualidade/cor (1 branco ... 5+ lendário). Qualidade/cor. Enum: meta.enum_values.enum_name=''item_profile''. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:78] XML: ItemTempInfos.Profile';
COMMENT ON COLUMN game.items.sell_gold IS 'Preço de venda ao NPC em ouro (getSellGold). [decompiled/core_module/scripts/bag/helper/GoodsCheck.as:369] XML: ItemTempInfos.SellGold';
COMMENT ON COLUMN game.items.default_skill_ids IS 'Skills concedidas pelo item (modas dão atributos via skills passivas). CSV de SkillTempInfos fixas do item. Moda: habilidade-objeto base (6001 chapéu, 7001 arma, 8001 roupa, ''5101,5001'' asa); Grades da skill = estrelas da moda. Equipamento: skills de base somadas no score. [decompiled/core_module/scripts/cell/mediator/fashionbag/FashionBagCellDropMediator.as:192] XML: ItemTempInfos.DefaultSkill';
COMMENT ON COLUMN game.items.avatar_path IS 'Recurso visual: swf/avatar<path>/..., equip<path>/..., equip_show<path>/... Recurso gráfico (''/nome''): moda/asa/arma/armadura → camada de avatar; semente → ''/farm/x''; animal → ''horse''. Ver avatar_layers. [decompiled/core_module/scripts/yishi/utils/ThaneEquipShowHelper.as:43] XML: ItemTempInfos.Avata';
COMMENT ON COLUMN game.items.strengthen_max IS 'Nível máximo de fortalecimento (+N). Para equip. pet/guardião limita mouldGrade. [decompiled/core_module/scripts/yishi/utils/StoreHelper.as:58] XML: ItemTempInfos.StrengthenMax';
COMMENT ON COLUMN game.items.random_skill_count IS 'Nº de habilidades aleatórias (randomSkill1..5 da instância, SkillPropertyTempInfos) sorteadas ao obter/refrescar. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:828] XML: ItemTempInfos.RandomSkillCount';
COMMENT ON COLUMN game.items.suite_id IS 'Conjunto (set). Conjunto (set) do equipamento. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:960] XML: ItemTempInfos.SuiteId';
COMMENT ON COLUMN game.items.starting_price IS 'Preço inicial em leilão. Preço mínimo por unidade no leilão/mercado (MarketSellAlertFrame impõe preço >= StartingPrice*qtd). [decompiled/core_module/scripts/cell/mediator/marketbag/MarketSellAlertFrame.as:143] XML: ItemTempInfos.StartingPrice';
COMMENT ON COLUMN game.items.transform_id IS 'Equipamento/gema: receita de transformação (TransformInfos); moda: grau 1..5 = S/A/B/C/D (enum fashion_grade). Gemas/pérolas: grupo de conversão (TransformInfos). Moda: grau S..D (fashion_grade) e índice de taxa de identificação. Enum: meta.enum_values.enum_name=''fashion_grade''. [decompiled/m14/scripts/store/SwitchView1.as:351] XML: ItemTempInfos.TransformId';
COMMENT ON COLUMN game.items.is_batch_usable IS '''true'' = pode ser usado em lote (uso múltiplo). [decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:122] XML: ItemTempInfos.IsCanBatch';
COMMENT ON COLUMN game.items.feed IS '>0 = item pode alimentar a Árvore do Casamento (valor = peso/qtd, suposição). [decompiled/m9/scripts/marry/income/MarryTreeFosterFrame.as:779] XML: ItemTempInfos.Feed';
COMMENT ON COLUMN game.items.required_job_change IS 'Requisito de transferência de classe. Enum: meta.enum_values.enum_name=''need_change_job''. [decompiled/core_module/scripts/mvc/controler/StoreControler.as:728] XML: ItemTempInfos.NeedChangeJob';
COMMENT ON COLUMN game.items.property1 IS 'Semântica depende da categoria (ver game.item_categories.property_semantics). Parâmetro genérico 1; semântica depende de MasterType/SonType — ver item_categories[].property_semantics_pt. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:60] XML: ItemTempInfos.Property1';
COMMENT ON COLUMN game.items.property2 IS 'Parâmetro genérico 2; semântica depende de MasterType/SonType — ver item_categories[].property_semantics_pt. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:62] XML: ItemTempInfos.Property2';
COMMENT ON COLUMN game.items.property3 IS 'Parâmetro genérico 3; semântica depende de MasterType/SonType — ver item_categories[].property_semantics_pt. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:64] XML: ItemTempInfos.Property3';
COMMENT ON COLUMN game.items.property4 IS 'Parâmetro genérico 4; semântica depende de MasterType/SonType — ver item_categories[].property_semantics_pt. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:66] XML: ItemTempInfos.Property4';
COMMENT ON COLUMN game.items.property5 IS 'Parâmetro genérico 5; semântica depende de MasterType/SonType — ver item_categories[].property_semantics_pt. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:68] XML: ItemTempInfos.Property5';
COMMENT ON COLUMN game.items.property6 IS 'Parâmetro genérico 6; semântica depende de MasterType/SonType — ver item_categories[].property_semantics_pt. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:70] XML: ItemTempInfos.Property6';
COMMENT ON COLUMN game.items.property7 IS 'Parâmetro genérico 7; semântica depende de MasterType/SonType — ver item_categories[].property_semantics_pt. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:72] XML: ItemTempInfos.Property7';
COMMENT ON COLUMN game.items.attack IS 'Ataque físico (Attack). Ataque Físico. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:40] XML: ItemTempInfos.Attack';
COMMENT ON COLUMN game.items.defense IS 'Defesa física (Defence). Defesa Física. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:42] XML: ItemTempInfos.Defence';
COMMENT ON COLUMN game.items.magic_attack IS 'Ataque mágico (MagicAttack). Ataque Mágico. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:44] XML: ItemTempInfos.MagicAttack';
COMMENT ON COLUMN game.items.magic_defense IS 'Defesa mágica (MagicDefence). Defesa Mágica. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:46] XML: ItemTempInfos.MagicDefence';
COMMENT ON COLUMN game.items.hit_points IS 'Vida (HP) (Live). Vida (HP). Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:56] XML: ItemTempInfos.Live';
COMMENT ON COLUMN game.items.critical IS 'Crítico (ForceHit). Crítico. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:48] XML: ItemTempInfos.ForceHit';
COMMENT ON COLUMN game.items.parry IS 'Bloqueio (aparar) (Parry). Bloqueio. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:52] XML: ItemTempInfos.Parry';
COMMENT ON COLUMN game.items.power IS 'Força (Power). Força (atributo primário). Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:30] XML: ItemTempInfos.Power';
COMMENT ON COLUMN game.items.agility IS 'Proteção (XML Agility: +4 defesa, +4 resistência) (Agility). Proteção/Armadura (atributo primário). Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:32] XML: ItemTempInfos.Agility';
COMMENT ON COLUMN game.items.intellect IS 'Inteligência (Intellect). Inteligência. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:34] XML: ItemTempInfos.Intellect';
COMMENT ON COLUMN game.items.physique IS 'Físico (constituição) (Physique). Físico. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:36] XML: ItemTempInfos.Physique';
COMMENT ON COLUMN game.items.leadership IS 'Liderança (Captain). Liderança. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:38] XML: ItemTempInfos.Captain';
COMMENT ON COLUMN game.items.determination IS 'Determinação/Força Consistente (resistência a atordoamento) (StunAttr). Atributo de atordoamento (''Força Consistente''). Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:50] XML: ItemTempInfos.StunAttr';
COMMENT ON COLUMN game.items.troop_capacity IS 'Infantaria (capacidade de tropa) (Conat). Nº de soldados/infantaria. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:58] XML: ItemTempInfos.Conat';
COMMENT ON COLUMN game.items.strength IS 'Intensidade (% = x·100/(x+8000)) (Strength). Força (stat de batalha extra). Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:102] XML: ItemTempInfos.Strength';
COMMENT ON COLUMN game.items.tenacity IS 'Tenacidade (% = x·100/(x+8000)) (Tenacity). Durabilidade/tenacidade. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:104] XML: ItemTempInfos.Tenacity';
COMMENT ON COLUMN game.items.penetration IS 'Penetração (Penetrate). Penetração. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:54] XML: ItemTempInfos.Penetrate';
COMMENT ON COLUMN game.items.fire_resist IS 'Resistência a fogo (FireResi). Resistência a fogo. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:108] XML: ItemTempInfos.FireResi';
COMMENT ON COLUMN game.items.water_resist IS 'Resistência a água (WaterResi). Resistência a água. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:110] XML: ItemTempInfos.WaterResi';
COMMENT ON COLUMN game.items.electric_resist IS 'Resistência a eletricidade (ElectResi). Resistência a eletricidade. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:112] XML: ItemTempInfos.ElectResi';
COMMENT ON COLUMN game.items.wind_resist IS 'Resistência a vento (WindResi). Resistência a vento. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:114] XML: ItemTempInfos.WindResi';
COMMENT ON COLUMN game.items.dark_resist IS 'Resistência a trevas (DarkResi). Resistência a trevas. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:116] XML: ItemTempInfos.DarkResi';
COMMENT ON COLUMN game.items.light_resist IS 'Resistência a luz (LightResi). Resistência a luz. Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:118] XML: ItemTempInfos.LightResi';
COMMENT ON COLUMN game.items.resist_reduction IS 'Redução de resistência (anti-RES) (ReduceResi). Redução de resistência (anti-RES). Bônus fixo do item (equipamento/gema). Em equipamento é ampliado por fortalecimento (getStrengthenAddition) e fundição (getMouldAddition); em gema soma direto. [decompiled/core_module/scripts/yishi/datas/templates/GoodsTemplateInfo.as:106] XML: ItemTempInfos.ReduceResi';
COMMENT ON COLUMN game.items.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.items.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.item_suites (
  id integer NOT NULL,
  name text,
  piece1_item_id integer,
  piece2_item_id integer,
  piece3_item_id integer,
  piece4_item_id integer,
  piece5_item_id integer,
  piece6_item_id integer,
  piece7_item_id integer,
  piece8_item_id integer,
  piece1_alt_item_id integer,
  piece2_alt_item_id integer,
  piece3_alt_item_id integer,
  piece4_alt_item_id integer,
  piece5_alt_item_id integer,
  piece6_alt_item_id integer,
  piece7_alt_item_id integer,
  piece8_alt_item_id integer,
  bonus1 integer,
  bonus2 integer,
  bonus3 integer,
  bonus4 integer,
  bonus5 integer,
  bonus6 integer,
  bonus7 integer,
  bonus8 integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.item_suites IS 'Conjuntos de equipamento: peças (Template1..8, variantes Template1s..8s) e bônus por nº de peças (Property1..8). Origem: tempinfos.xml/SuiteTempInfos.';
COMMENT ON COLUMN game.item_suites.id IS 'Id do conjunto (= ItemTempInfos.SuiteId). [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:7] XML: SuiteTempInfos.TemplateId';
COMMENT ON COLUMN game.item_suites.name IS 'Nome do conjunto. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:9] XML: SuiteTempInfos.TemplateName';
COMMENT ON COLUMN game.item_suites.piece1_item_id IS 'Peça 1 do conjunto (ItemTempInfos.TemplateId). 0 = sem peça. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:148] XML: SuiteTempInfos.Template1';
COMMENT ON COLUMN game.item_suites.piece2_item_id IS 'Peça 2 do conjunto (ItemTempInfos.TemplateId). 0 = sem peça. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:148] XML: SuiteTempInfos.Template2';
COMMENT ON COLUMN game.item_suites.piece3_item_id IS 'Peça 3 do conjunto (ItemTempInfos.TemplateId). 0 = sem peça. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:148] XML: SuiteTempInfos.Template3';
COMMENT ON COLUMN game.item_suites.piece4_item_id IS 'Peça 4 do conjunto (ItemTempInfos.TemplateId). 0 = sem peça. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:148] XML: SuiteTempInfos.Template4';
COMMENT ON COLUMN game.item_suites.piece5_item_id IS 'Peça 5 do conjunto (ItemTempInfos.TemplateId). 0 = sem peça. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:148] XML: SuiteTempInfos.Template5';
COMMENT ON COLUMN game.item_suites.piece6_item_id IS 'Peça 6 do conjunto (ItemTempInfos.TemplateId). 0 = sem peça. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:148] XML: SuiteTempInfos.Template6';
COMMENT ON COLUMN game.item_suites.piece7_item_id IS 'Peça 7 do conjunto (ItemTempInfos.TemplateId). 0 = sem peça. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:148] XML: SuiteTempInfos.Template7';
COMMENT ON COLUMN game.item_suites.piece8_item_id IS 'Peça 8 do conjunto (ItemTempInfos.TemplateId). 0 = sem peça. [decompiled/core_module/scripts/yishi/datas/templates/SuiteTempInfo.as:148] XML: SuiteTempInfos.Template8';
COMMENT ON COLUMN game.item_suites.piece1_alt_item_id IS 'Variante alternativa da peça 1 (ex.: versão melhorada/[Ω]) que também conta para o set. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:972] XML: SuiteTempInfos.Template1s';
COMMENT ON COLUMN game.item_suites.piece2_alt_item_id IS 'Variante alternativa da peça 2 (ex.: versão melhorada/[Ω]) que também conta para o set. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:972] XML: SuiteTempInfos.Template2s';
COMMENT ON COLUMN game.item_suites.piece3_alt_item_id IS 'Variante alternativa da peça 3 (ex.: versão melhorada/[Ω]) que também conta para o set. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:972] XML: SuiteTempInfos.Template3s';
COMMENT ON COLUMN game.item_suites.piece4_alt_item_id IS 'Variante alternativa da peça 4 (ex.: versão melhorada/[Ω]) que também conta para o set. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:972] XML: SuiteTempInfos.Template4s';
COMMENT ON COLUMN game.item_suites.piece5_alt_item_id IS 'Variante alternativa da peça 5 (ex.: versão melhorada/[Ω]) que também conta para o set. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:972] XML: SuiteTempInfos.Template5s';
COMMENT ON COLUMN game.item_suites.piece6_alt_item_id IS 'Variante alternativa da peça 6 (ex.: versão melhorada/[Ω]) que também conta para o set. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:972] XML: SuiteTempInfos.Template6s';
COMMENT ON COLUMN game.item_suites.piece7_alt_item_id IS 'Variante alternativa da peça 7 (ex.: versão melhorada/[Ω]) que também conta para o set. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:972] XML: SuiteTempInfos.Template7s';
COMMENT ON COLUMN game.item_suites.piece8_alt_item_id IS 'Variante alternativa da peça 8 (ex.: versão melhorada/[Ω]) que também conta para o set. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:972] XML: SuiteTempInfos.Template8s';
COMMENT ON COLUMN game.item_suites.bonus1 IS 'Bônus com 1 peça(s) (id de skill/perfil) Bônus do set ativo com >= 1 peças: SkillTempInfos.TemplateId (0 = nenhum). Ex.: suite 100 Property2=1222. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:987] XML: SuiteTempInfos.Property1';
COMMENT ON COLUMN game.item_suites.bonus2 IS 'Bônus com 2 peça(s) (id de skill/perfil) Bônus do set ativo com >= 2 peças: SkillTempInfos.TemplateId (0 = nenhum). Ex.: suite 100 Property2=1222. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:987] XML: SuiteTempInfos.Property2';
COMMENT ON COLUMN game.item_suites.bonus3 IS 'Bônus com 3 peça(s) (id de skill/perfil) Bônus do set ativo com >= 3 peças: SkillTempInfos.TemplateId (0 = nenhum). Ex.: suite 100 Property2=1222. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:987] XML: SuiteTempInfos.Property3';
COMMENT ON COLUMN game.item_suites.bonus4 IS 'Bônus com 4 peça(s) (id de skill/perfil) Bônus do set ativo com >= 4 peças: SkillTempInfos.TemplateId (0 = nenhum). Ex.: suite 100 Property2=1222. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:987] XML: SuiteTempInfos.Property4';
COMMENT ON COLUMN game.item_suites.bonus5 IS 'Bônus com 5 peça(s) (id de skill/perfil) Bônus do set ativo com >= 5 peças: SkillTempInfos.TemplateId (0 = nenhum). Ex.: suite 100 Property2=1222. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:987] XML: SuiteTempInfos.Property5';
COMMENT ON COLUMN game.item_suites.bonus6 IS 'Bônus com 6 peça(s) (id de skill/perfil) Bônus do set ativo com >= 6 peças: SkillTempInfos.TemplateId (0 = nenhum). Ex.: suite 100 Property2=1222. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:987] XML: SuiteTempInfos.Property6';
COMMENT ON COLUMN game.item_suites.bonus7 IS 'Bônus com 7 peça(s) (id de skill/perfil) Bônus do set ativo com >= 7 peças: SkillTempInfos.TemplateId (0 = nenhum). Ex.: suite 100 Property2=1222. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:987] XML: SuiteTempInfos.Property7';
COMMENT ON COLUMN game.item_suites.bonus8 IS 'Bônus com 8 peça(s) (id de skill/perfil) Bônus do set ativo com >= 8 peças: SkillTempInfos.TemplateId (0 = nenhum). Ex.: suite 100 Property2=1222. [decompiled/core_module/scripts/yishi/view/tips/goods/EquipTipsContent.as:987] XML: SuiteTempInfos.Property8';
COMMENT ON COLUMN game.item_suites.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.item_suites.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.item_compose_recipes (
  id integer NOT NULL,
  compose_type integer,
  material1_item_id integer,
  material1_count integer,
  material2_item_id integer,
  material2_count integer,
  material3_item_id integer,
  material3_count integer,
  material4_item_id integer,
  material4_count integer,
  required_level integer,
  required_building_id integer,
  result_item_id integer,
  result_count integer,
  gold_cost integer,
  property1 integer,
  is_learned boolean,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.item_compose_recipes IS 'Receitas de composição/forja: até 4 materiais → novo item, custo em ouro. Origem: tempinfos.xml/ComposeTempInfos.';
COMMENT ON COLUMN game.item_compose_recipes.id IS 'Id da receita. [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:6] XML: ComposeTempInfos.Id';
COMMENT ON COLUMN game.item_compose_recipes.compose_type IS 'Categoria da receita. Enum: meta.enum_values.enum_name=''compose_type''. [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:8] XML: ComposeTempInfos.Types';
COMMENT ON COLUMN game.item_compose_recipes.material1_item_id IS 'Material 1 (ItemTempInfos.TemplateId; 0 = vazio). [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:10] XML: ComposeTempInfos.Material1';
COMMENT ON COLUMN game.item_compose_recipes.material1_count IS 'Quantidade do material 1. [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:12] XML: ComposeTempInfos.Count1';
COMMENT ON COLUMN game.item_compose_recipes.material2_item_id IS 'Material 2 (ItemTempInfos.TemplateId; 0 = vazio). [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:14] XML: ComposeTempInfos.Material2';
COMMENT ON COLUMN game.item_compose_recipes.material2_count IS 'Quantidade do material 2. [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:16] XML: ComposeTempInfos.Count2';
COMMENT ON COLUMN game.item_compose_recipes.material3_item_id IS 'Material 3 (ItemTempInfos.TemplateId; 0 = vazio). [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:18] XML: ComposeTempInfos.Material3';
COMMENT ON COLUMN game.item_compose_recipes.material3_count IS 'Quantidade do material 3. [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:20] XML: ComposeTempInfos.Count3';
COMMENT ON COLUMN game.item_compose_recipes.material4_item_id IS 'Material 4 (ItemTempInfos.TemplateId; 0 = vazio). [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:22] XML: ComposeTempInfos.Material4';
COMMENT ON COLUMN game.item_compose_recipes.material4_count IS 'Quantidade do material 4. [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:24] XML: ComposeTempInfos.Count4';
COMMENT ON COLUMN game.item_compose_recipes.required_level IS 'Nível mínimo do herói (lista esconde receitas com NeedMinLevel > nível+10). [decompiled/m14/scripts/store/compose/ComposeSubListView.as:144] XML: ComposeTempInfos.NeedMinLevel';
COMMENT ON COLUMN game.item_compose_recipes.required_building_id IS 'Prédio exigido (sempre 0 nos dados). [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:28] XML: ComposeTempInfos.NeedBuildingTemp';
COMMENT ON COLUMN game.item_compose_recipes.result_item_id IS 'Item produzido. [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:30] XML: ComposeTempInfos.NewMaterial';
COMMENT ON COLUMN game.item_compose_recipes.result_count IS 'Quantidade produzida (sempre 1). [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:32] XML: ComposeTempInfos.Counts';
COMMENT ON COLUMN game.item_compose_recipes.gold_cost IS 'Custo em ouro. [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:34] XML: ComposeTempInfos.NeedGold';
COMMENT ON COLUMN game.item_compose_recipes.property1 IS 'Parâmetro extra (2..12 em 86 receitas de gemas/joias) (suposição: nível/grau de joalheria exigido). [decompiled/core_module/scripts/yishi/datas/templates/ComposeGoodsTemplete.as:36] XML: ComposeTempInfos.Property1';
COMMENT ON COLUMN game.item_compose_recipes.is_learned IS 'Receita precisa ser aprendida (sempre 0; não lido pelo cliente) (suposição). [data/tpl/tempinfos/ComposeTempInfos.xml] XML: ComposeTempInfos.IsLearn';
COMMENT ON COLUMN game.item_compose_recipes.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.item_compose_recipes.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.item_transforms (
  id integer NOT NULL,
  material1_item_id integer,
  material2_item_id integer,
  material3_item_id integer,
  material4_item_id integer,
  material5_item_id integer,
  material6_item_id integer,
  material7_item_id integer,
  material8_item_id integer,
  gold_cost integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.item_transforms IS 'Transformação de equipamento: até 8 materiais e custo em ouro (ItemTempInfos.TransformId). Origem: tempinfos.xml/TransformInfos.';
COMMENT ON COLUMN game.item_transforms.id IS 'Grupo de conversão (= ItemTempInfos.TransformId de gemas/pérolas do dragão do mesmo nível). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:6] XML: TransformInfos.TransformId';
COMMENT ON COLUMN game.item_transforms.material1_item_id IS 'Item 1 do grupo — converte-se entre si (ex.: grupo 1 = 8 gemas Nv.1: Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:8] XML: TransformInfos.Material1';
COMMENT ON COLUMN game.item_transforms.material2_item_id IS 'Item 2 do grupo — converte-se entre si (ex.: grupo 1 = 8 gemas Nv.1: Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:10] XML: TransformInfos.Material2';
COMMENT ON COLUMN game.item_transforms.material3_item_id IS 'Item 3 do grupo — converte-se entre si (ex.: grupo 1 = 8 gemas Nv.1: Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:12] XML: TransformInfos.Material3';
COMMENT ON COLUMN game.item_transforms.material4_item_id IS 'Item 4 do grupo — converte-se entre si (ex.: grupo 1 = 8 gemas Nv.1: Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:14] XML: TransformInfos.Material4';
COMMENT ON COLUMN game.item_transforms.material5_item_id IS 'Item 5 do grupo — converte-se entre si (ex.: grupo 1 = 8 gemas Nv.1: Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:16] XML: TransformInfos.Material5';
COMMENT ON COLUMN game.item_transforms.material6_item_id IS 'Item 6 do grupo — converte-se entre si (ex.: grupo 1 = 8 gemas Nv.1: Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:18] XML: TransformInfos.Material6';
COMMENT ON COLUMN game.item_transforms.material7_item_id IS 'Item 7 do grupo — converte-se entre si (ex.: grupo 1 = 8 gemas Nv.1: Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:20] XML: TransformInfos.Material7';
COMMENT ON COLUMN game.item_transforms.material8_item_id IS 'Item 8 do grupo — converte-se entre si (ex.: grupo 1 = 8 gemas Nv.1: Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio). [decompiled/core_module/scripts/yishi/datas/templates/SwitchGoodsTemplete.as:22] XML: TransformInfos.Material8';
COMMENT ON COLUMN game.item_transforms.gold_cost IS 'Ouro por unidade convertida (× desconto). [decompiled/m14/scripts/store/SwitchView1.as:352] XML: TransformInfos.CostGold';
COMMENT ON COLUMN game.item_transforms.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.item_transforms.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.item_resolves (
  id integer NOT NULL,
  resolve_type integer,
  resolved_item_id integer,
  output1_item_id integer,
  output1_count integer,
  output2_item_id integer,
  output2_count integer,
  output3_item_id integer,
  output3_count integer,
  output4_item_id integer,
  output4_count integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.item_resolves IS 'Decomposição de itens: item decomposto → até 4 itens resultantes. Origem: tempinfos.xml/ItemResolveTemplates.';
COMMENT ON COLUMN game.item_resolves.id IS 'Id único (não usado em buscas). [decompiled/core_module/scripts/yishi/datas/templates/ResolveTemplateInfo.as:6] XML: ItemResolveTemplates.Id';
COMMENT ON COLUMN game.item_resolves.resolve_type IS 'Contexto. Enum: meta.enum_values.enum_name=''resolve_type''. [decompiled/core_module/scripts/yishi/datas/templates/ResolveTemplateInfo.as:8] XML: ItemResolveTemplates.Type';
COMMENT ON COLUMN game.item_resolves.resolved_item_id IS 'Item decomposto (chave Type_ResolvedItem). [decompiled/core_module/scripts/yishi/datas/templates/cate/ResolveTemplateCate.as:19] XML: ItemResolveTemplates.ResolvedItem';
COMMENT ON COLUMN game.item_resolves.output1_item_id IS 'Material obtido 1 (negativo = moeda). [decompiled/core_module/scripts/yishi/datas/templates/ResolveTemplateInfo.as:12] XML: ItemResolveTemplates.Item1';
COMMENT ON COLUMN game.item_resolves.output1_count IS 'Qtd. por unidade (total = count×Count1). [decompiled/m14/scripts/store/AvengerRosolveView.as:332] XML: ItemResolveTemplates.Count1';
COMMENT ON COLUMN game.item_resolves.output2_item_id IS 'Material obtido 2 (negativo = moeda). [decompiled/core_module/scripts/yishi/datas/templates/ResolveTemplateInfo.as:16] XML: ItemResolveTemplates.Item2';
COMMENT ON COLUMN game.item_resolves.output2_count IS 'Qtd. por unidade (total = count×Count2). [decompiled/m14/scripts/store/AvengerRosolveView.as:332] XML: ItemResolveTemplates.Count2';
COMMENT ON COLUMN game.item_resolves.output3_item_id IS 'Material obtido 3 (negativo = moeda). [decompiled/core_module/scripts/yishi/datas/templates/ResolveTemplateInfo.as:20] XML: ItemResolveTemplates.Item3';
COMMENT ON COLUMN game.item_resolves.output3_count IS 'Qtd. por unidade (total = count×Count3). [decompiled/m14/scripts/store/AvengerRosolveView.as:332] XML: ItemResolveTemplates.Count3';
COMMENT ON COLUMN game.item_resolves.output4_item_id IS 'Material obtido 4 (negativo = moeda). [decompiled/core_module/scripts/yishi/datas/templates/ResolveTemplateInfo.as:24] XML: ItemResolveTemplates.Item4';
COMMENT ON COLUMN game.item_resolves.output4_count IS 'Qtd. por unidade (total = count×Count4). [decompiled/m14/scripts/store/AvengerRosolveView.as:332] XML: ItemResolveTemplates.Count4';
COMMENT ON COLUMN game.item_resolves.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.item_resolves.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.fashion_polish_levels (
  son_type integer NOT NULL,
  level integer NOT NULL,
  exp integer,
  other_level integer,
  level_bonus integer,
  sp_bonus integer,
  appraisal_bonus integer,
  required_count integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (son_type, level)
);
COMMENT ON TABLE game.fashion_polish_levels IS 'Polimento (aprimoramento) de moda por parte (SonType 109..112): exp por nível e bônus percentuais. Origem: tempinfos.xml/FashionPolishs.';
COMMENT ON COLUMN game.fashion_polish_levels.son_type IS 'Parte de moda (109 asa, 110 chapéu, 111 arma, 112 roupa). Parte da moda polida (109 asa, 110 chapéu, 111 arma, 112 roupa). Enum: meta.enum_values.enum_name=''item_son_type''. [decompiled/core_module/scripts/yishi/datas/templates/FashionPolishTemplateInfo.as:6] XML: FashionPolishs.SonType';
COMMENT ON COLUMN game.fashion_polish_levels.level IS 'Nível de polimento 0..100 (chave SonType/Level). [decompiled/core_module/scripts/yishi/datas/templates/cate/FashionPolishTemplateCate.as:28] XML: FashionPolishs.Level';
COMMENT ON COLUMN game.fashion_polish_levels.exp IS 'Experiência necessária. EXP necessária para o nível (barra de progresso); asas exigem 5× (25 vs 5 por nível). [decompiled/m14/scripts/fashion/FashionRefreshItem.as:226] XML: FashionPolishs.Exp';
COMMENT ON COLUMN game.fashion_polish_levels.other_level IS 'Nos níveis 11,21,...: nível que as outras partes precisam ter (gate de 10 em 10) (suposição; não lido no cliente). [decompiled/core_module/scripts/yishi/datas/templates/FashionPolishTemplateInfo.as:12] XML: FashionPolishs.OtherLevel';
COMMENT ON COLUMN game.fashion_polish_levels.level_bonus IS '% do atributo base da moda (SkillProperty do nível de moda, UpGrade Types 113) somado: Level×10%. Parte asa→todos 5 stats; chapéu→Vida; roupa→Def+DefMág; arma→Atq+AtqMág. [decompiled/core_module/scripts/mvc/module/fashion/FashionModel.as:1231] XML: FashionPolishs.LevelAdd';
COMMENT ON COLUMN game.fashion_polish_levels.sp_bonus IS 'Bônus de SP/''fúria'' no nível múltiplo de 10 (2,4..20) usando o menor nível entre as 4 partes (template SonType 109). [decompiled/core_module/scripts/mvc/module/fashion/FashionModel.as:1240] XML: FashionPolishs.SpAdd';
COMMENT ON COLUMN game.fashion_polish_levels.appraisal_bonus IS 'Bônus (%) de identificação (''switch add'') liberado se nº de modas da parte no livro >= NeedCount. [decompiled/core_module/scripts/mvc/module/fashion/FashionModel.as:1277] XML: FashionPolishs.AppraisalAdd';
COMMENT ON COLUMN game.fashion_polish_levels.required_count IS 'Nº de modas coletadas (livro de modas) da parte exigido para AppraisalAdd (5,10..50). [decompiled/core_module/scripts/mvc/module/fashion/FashionModel.as:1275] XML: FashionPolishs.NeedCount';
COMMENT ON COLUMN game.fashion_polish_levels.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.fashion_polish_levels.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.mounts (
  id integer NOT NULL,
  name text,
  mount_type smallint,
  power integer,
  agility integer,
  intellect integer,
  physique integer,
  expand_level integer,
  speed integer,
  avatar_path text,
  wing_avatar_path text,
  required_item_id integer,
  property1 integer,
  property2 integer,
  required_mount_grade integer,
  description text,
  soul_score integer,
  sort_order integer,
  star_additions integer[],
  grade_type smallint,
  required_time_item_id integer,
  area smallint,
  is_flying boolean,
  is_standing boolean,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.mounts IS 'Montarias: atributos, velocidade no mapa, recurso visual ''corpo|asa'', se o cavaleiro fica em pé (IsStand) ou usa peças _mount, se voa, estrelas. Origem: tempinfos.xml/MountTempInfos.';
COMMENT ON COLUMN game.mounts.id IS 'Id da montaria/aparência. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:6] XML: MountTempInfos.TemplateId';
COMMENT ON COLUMN game.mounts.name IS 'Nome. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:8] XML: MountTempInfos.TemplateName';
COMMENT ON COLUMN game.mounts.mount_type IS 'Tipo (normal, especial, voadora...; ver enum mount_type). Tipo. Enum: meta.enum_values.enum_name=''mount_type''. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:24] XML: MountTempInfos.MountType';
COMMENT ON COLUMN game.mounts.power IS 'Força (Power). Força concedida ao ativar a aparência (tip: ''Força +{0}''). [decompiled/core_module/scripts/yishi/view/tips/goods/MountCardTip.as:394] XML: MountTempInfos.Power';
COMMENT ON COLUMN game.mounts.agility IS 'Proteção (XML Agility: +4 defesa, +4 resistência) (Agility). Proteção (armadura) concedida. [decompiled/core_module/scripts/yishi/view/tips/goods/MountCardTip.as:394] XML: MountTempInfos.Agility';
COMMENT ON COLUMN game.mounts.intellect IS 'Inteligência (Intellect). Inteligência concedida. [decompiled/core_module/scripts/yishi/view/tips/goods/MountCardTip.as:394] XML: MountTempInfos.Intellect';
COMMENT ON COLUMN game.mounts.physique IS 'Físico (constituição) (Physique). Físico concedido. [decompiled/core_module/scripts/yishi/view/tips/goods/MountCardTip.as:394] XML: MountTempInfos.Physique';
COMMENT ON COLUMN game.mounts.expand_level IS 'Aumenta o nível máximo dos atributos treinados (''Nível máximo de atributos +{0}''). [decompiled/core_module/scripts/yishi/view/tips/goods/MountCardTip.as:394] XML: MountTempInfos.ExpandLevel';
COMMENT ON COLUMN game.mounts.speed IS 'Velocidade de deslocamento no mapa. Velocidade extra no mapa; somada só se MountType==1 (speedAdd = 20+ceil(grau/2)*10 [+Speed]). [decompiled/core_module/scripts/mvc/module/mounts/MountInfo.as:44] XML: MountTempInfos.Speed';
COMMENT ON COLUMN game.mounts.avatar_path IS 'Parte do corpo (antes de ''|''): swf/avatar<path>/2.bswf. ''/recurso'' ou ''/recurso|wing'' (sufixo wing = também usa camada mountWing). Mapa: swf/avatar{path}/2.bswf; UI: equip_show{path}/2.swf. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:84] XML: MountTempInfos.AvatarPath (pipe0)';
COMMENT ON COLUMN game.mounts.wing_avatar_path IS 'Asa da montaria (depois de ''|''), camada mountWing. ''/recurso'' ou ''/recurso|wing'' (sufixo wing = também usa camada mountWing). Mapa: swf/avatar{path}/2.bswf; UI: equip_show{path}/2.swf. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:84] XML: MountTempInfos.AvatarPath (pipe1)';
COMMENT ON COLUMN game.mounts.required_item_id IS 'Item que ativa a montaria. Carta de montaria (SonType 218) que ativa a aparência. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:26] XML: MountTempInfos.NeedItemId';
COMMENT ON COLUMN game.mounts.property1 IS 'Custo em diamantes para destravar sem a carta (1198/1398); <=0 = não destravável. [decompiled/m14/scripts/mounts/WildSoulFrame.as:560] XML: MountTempInfos.Property1';
COMMENT ON COLUMN game.mounts.property2 IS 'MountType 0: nível de montaria exigido para a forma (''Nv. {0}''); demais: ordem/validade (suposição). [decompiled/m14/scripts/mounts/WildSoulItem.as:291] XML: MountTempInfos.Property2';
COMMENT ON COLUMN game.mounts.required_mount_grade IS 'Nível de montaria exigido para ativar (todos 0 nos dados). [decompiled/m14/scripts/mounts/WildSoulFrame.as:514] XML: MountTempInfos.NeedMountGrade';
COMMENT ON COLUMN game.mounts.description IS 'Descrição pt-BR. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:30] XML: MountTempInfos.Description';
COMMENT ON COLUMN game.mounts.soul_score IS 'Pontos de alma (coleção/treino). ''Ponto Bestial'' somado ao ranking de alma de montaria (50..500). [decompiled/core_module/scripts/yishi/view/tips/goods/MountCardTip.as:411] XML: MountTempInfos.SoulScore';
COMMENT ON COLUMN game.mounts.sort_order IS 'Ordem de exibição na coleção. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:42] XML: MountTempInfos.Sort';
COMMENT ON COLUMN game.mounts.star_additions IS 'Bônus % por estrela (CSV). CSV de % de bônus por estrela (ex. ''10,20,30,40,50''); nº de itens = estrelas máximas (maxStarGrade). [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:117] XML: MountTempInfos.StarAddition';
COMMENT ON COLUMN game.mounts.grade_type IS 'Raridade/grau. Grupo de UpGradeTempInfos Types=37 que define custos/bênção por estrela. Enum: meta.enum_values.enum_name=''mount_grade_type''. [decompiled/core_module/scripts/mvc/module/mounts/WildSoulInfo.as:67] XML: MountTempInfos.GradeType';
COMMENT ON COLUMN game.mounts.required_time_item_id IS 'Item de tempo (montaria temporária) — sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:28] XML: MountTempInfos.NeedTimeItemId';
COMMENT ON COLUMN game.mounts.area IS 'Aba da coleção. Enum: meta.enum_values.enum_name=''mount_area''. [decompiled/core_module/scripts/mvc/module/mounts/WildSoulCollection.as:77] XML: MountTempInfos.Area';
COMMENT ON COLUMN game.mounts.is_flying IS 'Montaria voadora (flight do .bswf). 1 = voa (ignora obstáculos no mapa espacial; FindPath8 _isFly); também via compra de voo (isBuyFly). Enum: meta.enum_values.enum_name=''bool_int''. [decompiled/core_module/scripts/map/space/SpaceModel.as:169] XML: MountTempInfos.IsFly';
COMMENT ON COLUMN game.mounts.is_standing IS 'Cavaleiro em pé: usa peças normais; senão usa <peça>_mount. 1 = cavaleiro usa pose em pé (partes SEM sufixo _mount); 0 = partes ''{res}_mount''. Enum: meta.enum_values.enum_name=''bool_int''. [decompiled/core_module/scripts/yishi/datas/templates/MountTemplate.as:139] XML: MountTempInfos.IsStand';
COMMENT ON COLUMN game.mounts.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.mounts.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.dragon_battle_mounts (
  grade integer NOT NULL,
  power integer,
  agility integer,
  intellect integer,
  physique integer,
  hit_point integer,
  mount_template_id integer,
  name text,
  avatar_path text,
  description text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (grade)
);
COMMENT ON TABLE game.dragon_battle_mounts IS 'Montaria dragão de batalha (Dragon Talker): aparece no MovieClip de batalha do herói (equip/dragonic<AvatarPath>/2.swf). Origem: tempinfos.xml/DragonTalkerFightMountTemplates.';
COMMENT ON COLUMN game.dragon_battle_mounts.grade IS 'Nível exigido da montaria de batalha (UpGrade type 140). [decompiled/core_module/scripts/mvc/module/dragontalker/DragonTalkerModel.as:156] XML: DragonTalkerFightMountTemplates.Grade';
COMMENT ON COLUMN game.dragon_battle_mounts.power IS 'Força (Power). Força concedida. [decompiled/core_module/scripts/yishi/datas/templates/DragonTalkerFightMountTempInfo.as:31] XML: DragonTalkerFightMountTemplates.Power';
COMMENT ON COLUMN game.dragon_battle_mounts.agility IS 'Proteção (XML Agility: +4 defesa, +4 resistência) (Agility). Agilidade concedida. [decompiled/core_module/scripts/yishi/datas/templates/DragonTalkerFightMountTempInfo.as:31] XML: DragonTalkerFightMountTemplates.Agility';
COMMENT ON COLUMN game.dragon_battle_mounts.intellect IS 'Inteligência (Intellect). Inteligência concedida. [decompiled/core_module/scripts/yishi/datas/templates/DragonTalkerFightMountTempInfo.as:31] XML: DragonTalkerFightMountTemplates.Intellect';
COMMENT ON COLUMN game.dragon_battle_mounts.physique IS 'Físico (constituição) (Physique). Físico concedido. [decompiled/core_module/scripts/yishi/datas/templates/DragonTalkerFightMountTempInfo.as:31] XML: DragonTalkerFightMountTemplates.Physique';
COMMENT ON COLUMN game.dragon_battle_mounts.hit_point IS 'Pontos de ataque iniciais. [decompiled/m5/scripts/dragontalker/item/DragonTalkerBattleBeastPropItem.as:67] XML: DragonTalkerFightMountTemplates.HitPoint';
COMMENT ON COLUMN game.dragon_battle_mounts.mount_template_id IS 'Id/chave (battleBeastId). [decompiled/core_module/scripts/battle/view/roles/HeroLoadDataFactory.as:235] XML: DragonTalkerFightMountTemplates.MountTempId';
COMMENT ON COLUMN game.dragon_battle_mounts.name IS 'Nome (Grendel, Fafnir...). [decompiled/core_module/scripts/yishi/datas/templates/DragonTalkerFightMountTempInfo.as:20] XML: DragonTalkerFightMountTemplates.TemplateName';
COMMENT ON COLUMN game.dragon_battle_mounts.avatar_path IS 'Batalha equip/dragonic{AvatarPath}/2.swf; prévia equip_show/dragonic{AvatarPath}/2.swf. [decompiled/core_module/scripts/yishi/utils/MountAvatarPathHelper.as:18] XML: DragonTalkerFightMountTemplates.AvatarPath';
COMMENT ON COLUMN game.dragon_battle_mounts.description IS 'Vazio. [data/tpl/tempinfos/DragonTalkerFightMountTemplates.xml] XML: DragonTalkerFightMountTemplates.Description';
COMMENT ON COLUMN game.dragon_battle_mounts.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.dragon_battle_mounts.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.pets (
  id integer NOT NULL,
  name text,
  avatar_path text,
  son_type integer,
  pet_type integer,
  quality smallint,
  power integer,
  intellect integer,
  physique integer,
  armor integer,
  power_aptitude integer[],
  intellect_aptitude integer[],
  physique_aptitude integer[],
  armor_aptitude integer[],
  max_hp integer,
  growth_rate integer,
  fire_resist integer,
  water_resist integer,
  electric_resist integer,
  wind_resist integer,
  dark_resist integer,
  light_resist integer,
  follow_skill_ids integer[],
  change_skill_ids integer[],
  default_skill_id integer,
  required_grade integer,
  description text,
  property1 integer,
  property2 integer,
  property3 integer,
  property4 integer,
  property5 integer,
  property6 integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.pets IS 'Pets (Einherjar): tipo, qualidade, aptidões min/max, crescimento, resistências e skills (seguir, transformação, padrão). Origem: tempinfos.xml/PetTempInfos.';
COMMENT ON COLUMN game.pets.id IS 'Id = PetType*1000 + (SonType%100)*100 + Quality (ex. 101101 Amazona Q1). [decompiled/core_module/scripts/yishi/datas/templates/cate/PetTemplateCate.as:28] XML: PetTempInfos.TemplateId';
COMMENT ON COLUMN game.pets.name IS 'Nome da espécie (agrupa qualidades). [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:8] XML: PetTempInfos.TemplateName';
COMMENT ON COLUMN game.pets.avatar_path IS 'Recurso: swf/avatar<path>/2.bswf (mapa) e equip<path>/2.swf (batalha). Prefixo de recurso ''/pet_x'': batalha equip{PetAvatar}/2.swf; seguidor equip{PetAvatar}_follow/2.swf; UI equip_show{PetAvatar}/2.swf; mapa swf/avatar{PetAvatar}/2.bswf. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:12] XML: PetTempInfos.PetAvatar';
COMMENT ON COLUMN game.pets.son_type IS 'Linha/espécie = PetType*100 + nº (10101..11904). [decompiled/core_module/scripts/yishi/datas/templates/cate/PetTemplateCate.as:111] XML: PetTempInfos.SonType';
COMMENT ON COLUMN game.pets.pet_type IS 'Elemento. Enum: meta.enum_values.enum_name=''pet_type''. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1673] XML: PetTempInfos.PetType';
COMMENT ON COLUMN game.pets.quality IS 'Qualidade inicial do modelo. Enum: meta.enum_values.enum_name=''pet_quality''. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1141] XML: PetTempInfos.Quality';
COMMENT ON COLUMN game.pets.power IS 'Força base nv1. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:811] XML: PetTempInfos.Power';
COMMENT ON COLUMN game.pets.intellect IS 'Inteligência base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:811] XML: PetTempInfos.Intel';
COMMENT ON COLUMN game.pets.physique IS 'Físico base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:811] XML: PetTempInfos.Physi';
COMMENT ON COLUMN game.pets.armor IS 'Proteção base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:811] XML: PetTempInfos.Armor';
COMMENT ON COLUMN game.pets.power_aptitude IS 'Aptidão de força ''min,max''. Aptidão de Força ''min,max'' (InitPowerCoeLimitMin, InitPowerCoeLimit). [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:93] XML: PetTempInfos.PowerApt';
COMMENT ON COLUMN game.pets.intellect_aptitude IS 'Aptidão de Inteligência ''min,max''. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:93] XML: PetTempInfos.IntelApt';
COMMENT ON COLUMN game.pets.physique_aptitude IS 'Aptidão de Físico ''min,max''. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:93] XML: PetTempInfos.PhysiApt';
COMMENT ON COLUMN game.pets.armor_aptitude IS 'Aptidão de Proteção ''min,max''. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:93] XML: PetTempInfos.ArmorApt';
COMMENT ON COLUMN game.pets.max_hp IS 'HP fixo somado à vida. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:786] XML: PetTempInfos.MaxHp';
COMMENT ON COLUMN game.pets.growth_rate IS 'Taxa de crescimento (pontos de atributo por nível ×80), interpolada por estrela. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1180] XML: PetTempInfos.GrowthRate';
COMMENT ON COLUMN game.pets.fire_resist IS 'Resistência a fogo (FireResi). Resistência a fogo base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1000] XML: PetTempInfos.FireResi';
COMMENT ON COLUMN game.pets.water_resist IS 'Resistência a água (WaterResi). Resistência a água base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1000] XML: PetTempInfos.WaterResi';
COMMENT ON COLUMN game.pets.electric_resist IS 'Resistência a eletricidade (ElectResi). Resistência a choque base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1000] XML: PetTempInfos.ElectResi';
COMMENT ON COLUMN game.pets.wind_resist IS 'Resistência a vento (WindResi). Resistência a vento base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1000] XML: PetTempInfos.WindResi';
COMMENT ON COLUMN game.pets.dark_resist IS 'Resistência a trevas (DarkResi). Resistência a escuridão base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1000] XML: PetTempInfos.DarkResi';
COMMENT ON COLUMN game.pets.light_resist IS 'Resistência a luz (LightResi). Resistência a luz base. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1000] XML: PetTempInfos.LightResi';
COMMENT ON COLUMN game.pets.follow_skill_ids IS 'CSV de habilidades seguidoras/passivas (suposição; cliente usa PetInfoMsg.followSkills). [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1089] XML: PetTempInfos.FollowSkills';
COMMENT ON COLUMN game.pets.change_skill_ids IS 'CSV de habilidades de transformação/morph (suposição; MORPH_OPEN_GRADE=55). [decompiled/core_module/scripts/mvc/module/pet/PetData.as:29] XML: PetTempInfos.ChangeSkills';
COMMENT ON COLUMN game.pets.default_skill_id IS 'Habilidade de ataque padrão. [decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:329] XML: PetTempInfos.DefaultSkills';
COMMENT ON COLUMN game.pets.required_grade IS 'Classe 1/2/3 do Einherjar (baixo/médio/avançado). Enum: meta.enum_values.enum_name=''pet_class_grade''. [decompiled/core_module/scripts/mvc/module/pet/PetData.as:1748] XML: PetTempInfos.NeedGrade';
COMMENT ON COLUMN game.pets.description IS 'Igual a NeedGrade (1..3); não lido (suposição). Enum: meta.enum_values.enum_name=''pet_class_grade''. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:70] XML: PetTempInfos.Description';
COMMENT ON COLUMN game.pets.property1 IS '1 = modelo grande/centrado (Kersi, Hércules, Zeus...): centraliza avatar e reposiciona nome/sombra. Enum: meta.enum_values.enum_name=''bool_int''. [decompiled/core_module/scripts/avatar/view/ShowPetAvatar.as:127] XML: PetTempInfos.Property1';
COMMENT ON COLUMN game.pets.property2 IS '1 = forma especial Escarlate/Crepúsculo (117308..119308), excluída de getTemplateByTNQ. Enum: meta.enum_values.enum_name=''bool_int''. [decompiled/core_module/scripts/yishi/datas/templates/cate/PetTemplateCate.as:103] XML: PetTempInfos.Property2';
COMMENT ON COLUMN game.pets.property3 IS 'Sempre 0, não usado. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:78] XML: PetTempInfos.Property3';
COMMENT ON COLUMN game.pets.property4 IS 'Não usado. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:80] XML: PetTempInfos.Property4';
COMMENT ON COLUMN game.pets.property5 IS 'Não usado. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:82] XML: PetTempInfos.Property5';
COMMENT ON COLUMN game.pets.property6 IS 'Não usado. [decompiled/core_module/scripts/yishi/datas/templates/PetTemplate.as:84] XML: PetTempInfos.Property6';
COMMENT ON COLUMN game.pets.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.pets.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.pet_fusions (
  id integer NOT NULL,
  pet1_type integer,
  pet2_type integer,
  pet1_grade integer,
  pet2_grade integer,
  pet1_quality integer,
  pet2_quality integer,
  item1_id integer,
  item1_count integer,
  item2_id integer,
  item2_count integer,
  item3_id integer,
  item3_count integer,
  gold_cost bigint,
  point_cost integer,
  result_pet_type integer,
  result_grade integer,
  result_quality integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.pet_fusions IS 'Fusão de pets: dois pets (tipo/grau/qualidade) + itens/ouro/pontos → pet resultante. Origem: tempinfos.xml/PetComponseInfos.';
COMMENT ON COLUMN game.pet_fusions.id IS 'Id da receita (1..34). Pet2Types==0 → refinação/composição de 1 pet; !=0 → fusão de 2. [decompiled/core_module/scripts/yishi/resolve/PetComposeTemInfoResolve.as:24] XML: PetComponseInfos.TemplateId';
COMMENT ON COLUMN game.pet_fusions.pet1_type IS 'PetType do pet 1. Enum: meta.enum_values.enum_name=''pet_type''. [decompiled/m14/scripts/pet/compose/PetComposeView.as:938] XML: PetComponseInfos.Pet1Types';
COMMENT ON COLUMN game.pet_fusions.pet2_type IS 'PetType do pet 2 (0 = nenhum). Enum: meta.enum_values.enum_name=''pet_type''. [decompiled/m14/scripts/pet/mix/PetMixView.as:769] XML: PetComponseInfos.Pet2Types';
COMMENT ON COLUMN game.pet_fusions.pet1_grade IS 'Classe exigida do pet 1. Enum: meta.enum_values.enum_name=''pet_class_grade''. [decompiled/m14/scripts/pet/compose/PetComposeView.as:938] XML: PetComponseInfos.Pet1Grade';
COMMENT ON COLUMN game.pet_fusions.pet2_grade IS 'Classe exigida do pet 2. Enum: meta.enum_values.enum_name=''pet_class_grade''. [decompiled/m14/scripts/pet/mix/PetMixView.as:774] XML: PetComponseInfos.Pet2Grade';
COMMENT ON COLUMN game.pet_fusions.pet1_quality IS 'Qualidade exigida do pet 1. Enum: meta.enum_values.enum_name=''pet_quality''. [decompiled/m14/scripts/pet/mix/PetMixView.as:767] XML: PetComponseInfos.Pet1Quality';
COMMENT ON COLUMN game.pet_fusions.pet2_quality IS 'Qualidade exigida do pet 2. Enum: meta.enum_values.enum_name=''pet_quality''. [decompiled/m14/scripts/pet/mix/PetMixView.as:775] XML: PetComponseInfos.Pet2Quality';
COMMENT ON COLUMN game.pet_fusions.item1_id IS 'Material 1 (ex. 2125051 Lágrima Estrelar - Fogo). [decompiled/m14/scripts/pet/mix/PetMixView.as:814] XML: PetComponseInfos.NeedItemTempId1';
COMMENT ON COLUMN game.pet_fusions.item1_count IS 'Qtd. material 1. [decompiled/m14/scripts/pet/compose/PetComposeView.as:875] XML: PetComponseInfos.NeedItemTempIdCount1';
COMMENT ON COLUMN game.pet_fusions.item2_id IS 'Material 2 (ex. 2125057 Areia Estrelar). [decompiled/m14/scripts/pet/mix/PetMixView.as:814] XML: PetComponseInfos.NeedItemTempId2';
COMMENT ON COLUMN game.pet_fusions.item2_count IS 'Qtd. material 2. [decompiled/m14/scripts/pet/compose/PetComposeView.as:875] XML: PetComponseInfos.NeedItemTempIdCount2';
COMMENT ON COLUMN game.pet_fusions.item3_id IS 'Material 3 (ex. 2125059 Fragmento Divino). [decompiled/m14/scripts/pet/mix/PetMixView.as:814] XML: PetComponseInfos.NeedItemTempId3';
COMMENT ON COLUMN game.pet_fusions.item3_count IS 'Qtd. material 3. [decompiled/m14/scripts/pet/compose/PetComposeView.as:875] XML: PetComponseInfos.NeedItemTempIdCount3';
COMMENT ON COLUMN game.pet_fusions.gold_cost IS 'Ouro (0, 5.000.000, 50.000.000). [decompiled/m14/scripts/pet/compose/PetComposeView.as:321] XML: PetComponseInfos.NeedGold';
COMMENT ON COLUMN game.pet_fusions.point_cost IS 'Diamantes (0/20000; padrão 60000; zerado com item 211002 Alma da Fusão). [decompiled/m14/scripts/pet/mix/PetMixView.as:176] XML: PetComponseInfos.NeedPoint';
COMMENT ON COLUMN game.pet_fusions.result_pet_type IS 'PetType resultante. Enum: meta.enum_values.enum_name=''pet_type''. [decompiled/m14/scripts/pet/mix/PetMixView.as:338] XML: PetComponseInfos.ResultPetTypes';
COMMENT ON COLUMN game.pet_fusions.result_grade IS 'Classe resultante. Enum: meta.enum_values.enum_name=''pet_class_grade''. [decompiled/m14/scripts/pet/compose/PetComposeView.as:954] XML: PetComponseInfos.ResultPetGrade';
COMMENT ON COLUMN game.pet_fusions.result_quality IS 'Qualidade resultante. Enum: meta.enum_values.enum_name=''pet_quality''. [decompiled/m14/scripts/pet/mix/PetMixView.as:338] XML: PetComponseInfos.ResultQuality';
COMMENT ON COLUMN game.pet_fusions.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.pet_fusions.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.children (
  job_type integer NOT NULL,
  grade integer NOT NULL,
  job_name text,
  master_type integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  hit_points integer,
  critical integer,
  parry integer,
  determination integer,
  penetration integer,
  fire_resist integer,
  water_resist integer,
  electric_resist integer,
  wind_resist integer,
  dark_resist integer,
  light_resist integer,
  resist_reduction integer,
  resist_reduction_defense integer,
  resist_penetration integer,
  icon text,
  res_path text,
  skill_master_type integer,
  call_need_items integer[],
  artifact_name text,
  artifact_path text,
  call_total_growth integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (job_type, grade)
);
COMMENT ON TABLE game.children IS 'Filhos (hychild): classes de filho por grau, atributos, recurso visual, invocação e artefato (arma) do filho. Origem: tempinfos.xml/ChildTempInfos.';
COMMENT ON COLUMN game.children.job_type IS 'Classe do guardião. Enum: meta.enum_values.enum_name=''child_job_type''. [decompiled/core_module/scripts/yishi/datas/templates/cate/ChildTemplateCate.as:19] XML: ChildTempInfos.JobType';
COMMENT ON COLUMN game.children.grade IS 'Grau de crescimento 1..12 (chave JobType_Grades). [decompiled/core_module/scripts/yishi/datas/templates/cate/ChildTemplateCate.as:32] XML: ChildTempInfos.Grades';
COMMENT ON COLUMN game.children.job_name IS 'Nome da classe. [decompiled/m14/scripts/child/attribute/ChildItemView.as:155] XML: ChildTempInfos.JobName';
COMMENT ON COLUMN game.children.master_type IS 'Guardião comum/Espírito. Enum: meta.enum_values.enum_name=''child_master_type''. [decompiled/core_module/scripts/mvc/module/children/ChildData.as:375] XML: ChildTempInfos.MasterType';
COMMENT ON COLUMN game.children.attack IS 'Ataque físico (Attack). % herdado do maior ataque (físico/mágico) do herói. [decompiled/m14/scripts/child/attribute/ChildUpgradeGrowthView.as:223] XML: ChildTempInfos.Attack';
COMMENT ON COLUMN game.children.defense IS 'Defesa física (Defence). % da defesa física total do herói. [decompiled/m14/scripts/child/attribute/ChildUpgradeGrowthView.as:223] XML: ChildTempInfos.Defence';
COMMENT ON COLUMN game.children.magic_attack IS 'Ataque mágico (MagicAttack). % herdado do ataque mágico/maior ataque. [decompiled/m14/scripts/child/attribute/ChildUpgradeGrowthView.as:223] XML: ChildTempInfos.MagicAttack';
COMMENT ON COLUMN game.children.magic_defense IS 'Defesa mágica (MagicDefence). % da defesa mágica total. [decompiled/m14/scripts/child/attribute/ChildUpgradeGrowthView.as:223] XML: ChildTempInfos.MagicDefence';
COMMENT ON COLUMN game.children.hit_points IS 'Vida (HP) (Live). % da vida total do herói. [decompiled/m14/scripts/child/attribute/ChildUpgradeGrowthView.as:223] XML: ChildTempInfos.Live';
COMMENT ON COLUMN game.children.critical IS 'Crítico (ForceHit). Crítico (não lido; servidor envia JoinInfoMsg) (suposição: %). [data/tpl/tempinfos/ChildTempInfos.xml] XML: ChildTempInfos.ForceHit';
COMMENT ON COLUMN game.children.parry IS 'Bloqueio (aparar) (Parry). Bloqueio (idem, suposição). [data/tpl/tempinfos/ChildTempInfos.xml] XML: ChildTempInfos.Parry';
COMMENT ON COLUMN game.children.determination IS 'Determinação/Força Consistente (resistência a atordoamento) (StunAttr). Atordoamento (idem, suposição). [data/tpl/tempinfos/ChildTempInfos.xml] XML: ChildTempInfos.StunAttr';
COMMENT ON COLUMN game.children.penetration IS 'Penetração (Penetrate). Penetração (idem, suposição). [data/tpl/tempinfos/ChildTempInfos.xml] XML: ChildTempInfos.Penetrate';
COMMENT ON COLUMN game.children.fire_resist IS 'Resistência a fogo (FireResi). Resistência a fogo absoluta. [decompiled/core_module/scripts/mvc/module/children/ChildData.as:366] XML: ChildTempInfos.FireResi';
COMMENT ON COLUMN game.children.water_resist IS 'Resistência a água (WaterResi). Resistência a água. [decompiled/core_module/scripts/mvc/module/children/ChildData.as:366] XML: ChildTempInfos.WaterResi';
COMMENT ON COLUMN game.children.electric_resist IS 'Resistência a eletricidade (ElectResi). Resistência a choque. [decompiled/core_module/scripts/mvc/module/children/ChildData.as:366] XML: ChildTempInfos.ElectResi';
COMMENT ON COLUMN game.children.wind_resist IS 'Resistência a vento (WindResi). Resistência a vento. [decompiled/core_module/scripts/mvc/module/children/ChildData.as:366] XML: ChildTempInfos.WindResi';
COMMENT ON COLUMN game.children.dark_resist IS 'Resistência a trevas (DarkResi). Resistência a escuridão. [decompiled/core_module/scripts/mvc/module/children/ChildData.as:366] XML: ChildTempInfos.DarkResi';
COMMENT ON COLUMN game.children.light_resist IS 'Resistência a luz (LightResi). Resistência a luz. [decompiled/core_module/scripts/mvc/module/children/ChildData.as:366] XML: ChildTempInfos.LightResi';
COMMENT ON COLUMN game.children.resist_reduction IS 'Redução de resistência (anti-RES) (ReduceResi). Anti-resistência absoluta (ResiValueArr[0]). [decompiled/core_module/scripts/mvc/module/children/ChildData.as:363] XML: ChildTempInfos.ReduceResi';
COMMENT ON COLUMN game.children.resist_reduction_defense IS 'Defesa contra redução de resistência (ReduceResiAgainst). Sempre 0; fora da classe (suposição: resist. a anti-res). [data/tpl/tempinfos/ChildTempInfos.xml] XML: ChildTempInfos.ReduceResiAgainst';
COMMENT ON COLUMN game.children.resist_penetration IS 'Penetração de resistência (ResiPenetrate). Sempre 0; fora da classe (suposição: penetração de resistência). [data/tpl/tempinfos/ChildTempInfos.xml] XML: ChildTempInfos.ResiPenetrate';
COMMENT ON COLUMN game.children.icon IS 'Ícone icon{Icon} (ex. icon/hychild/warrior.png). [decompiled/core_module/scripts/yishi/utils/IconFactory.as:165] XML: ChildTempInfos.Icon';
COMMENT ON COLUMN game.children.res_path IS 'Batalha: equip/hychild<res>/2.swf. Recurso de batalha equip/hychild{ResPath}/2.swf; UI equip_show/hychild{ResPath}/2.swf (muda a cada 2 graus). [decompiled/core_module/scripts/yishi/manager/PathManager.as:61] XML: ChildTempInfos.ResPath';
COMMENT ON COLUMN game.children.skill_master_type IS 'SkillTempInfos.MasterType das habilidades da classe (44 = comuns). [decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2025] XML: ChildTempInfos.SkillMasterType';
COMMENT ON COLUMN game.children.call_need_items IS 'Item e quantidade para invocar ''id,qtd''. Itens para convocar ''id,qtd|id,qtd'' (''0'' = nenhum). [decompiled/m14/scripts/child/handbook/ChildCallAlertFrame.as:122] XML: ChildTempInfos.CallNeedItems';
COMMENT ON COLUMN game.children.artifact_name IS 'Nome do artefato do Espírito. [decompiled/m14/scripts/child/nursingspirit/ChildNSMostConversionInfoView.as:394] XML: ChildTempInfos.ArtifactName';
COMMENT ON COLUMN game.children.artifact_path IS 'Recurso swf/avatar/hychild/weapon/{ArtifactPath}.swf. [decompiled/core_module/scripts/yishi/manager/PathManager.as:675] XML: ChildTempInfos.ArtifactPath';
COMMENT ON COLUMN game.children.call_total_growth IS 'Nível de ''Pontos de crescimento'' exigido para convocar. [decompiled/m14/scripts/child/handbook/ChildCallAlertFrame.as:112] XML: ChildTempInfos.CallTotalGrowth';
COMMENT ON COLUMN game.children.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.children.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.goddesses (
  id integer NOT NULL,
  name text,
  goddess_type smallint,
  required_item_id integer,
  required_item_count integer,
  picture text,
  resource text,
  max_grade integer,
  max_step integer,
  max_devote integer,
  battle_picture text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.goddesses IS 'Deusas: entidades que entram em batalha (U_B_GODDESS_STAGE) com níveis, estágios e devoção. Origem: tempinfos.xml/GoddessTemplateInfos.';
COMMENT ON COLUMN game.goddesses.id IS 'Id da deusa 1..5 (GoddessInfoMsg.templateId); ícone goddess/small{Id}.png. [decompiled/core_module/scripts/yishi/datas/templates/GoddessTempInfo.as:6] XML: GoddessTemplateInfos.TemplateId';
COMMENT ON COLUMN game.goddesses.name IS 'Nome. [decompiled/core_module/scripts/yishi/datas/templates/GoddessTempInfo.as:8] XML: GoddessTemplateInfos.TemplateName';
COMMENT ON COLUMN game.goddesses.goddess_type IS 'Tipo; batalha goddess/battle/swf/{Type}.swf. Enum: meta.enum_values.enum_name=''goddess_type''. [decompiled/core_module/scripts/yishi/datas/templates/GoddessTempInfo.as:10] XML: GoddessTemplateInfos.Type';
COMMENT ON COLUMN game.goddesses.required_item_id IS 'Fragmento para ativar (212029..212033). [decompiled/m5/scripts/goddess/view/GoddessActiveView.as:101] XML: GoddessTemplateInfos.NeedItemId';
COMMENT ON COLUMN game.goddesses.required_item_count IS 'Qtd. para ativar (50). [decompiled/m5/scripts/goddess/view/GoddessActiveView.as:101] XML: GoddessTemplateInfos.NeedItemCount';
COMMENT ON COLUMN game.goddesses.picture IS '''/icon/1'' → goddess/view/icon/1.png. [decompiled/core_module/scripts/yishi/manager/PathManager.as:874] XML: GoddessTemplateInfos.Pic';
COMMENT ON COLUMN game.goddesses.resource IS '''/swf/1'' → goddess/view/swf/1.swf. [decompiled/core_module/scripts/yishi/manager/PathManager.as:889] XML: GoddessTemplateInfos.Resource';
COMMENT ON COLUMN game.goddesses.max_grade IS 'Nível máx. (240). [decompiled/core_module/scripts/yishi/datas/templates/GoddessTempInfo.as:20] XML: GoddessTemplateInfos.MaxGrade';
COMMENT ON COLUMN game.goddesses.max_step IS 'Estágio máx. (40). [decompiled/core_module/scripts/yishi/datas/templates/GoddessTempInfo.as:22] XML: GoddessTemplateInfos.MaxStep';
COMMENT ON COLUMN game.goddesses.max_devote IS 'Devoção máx. (5). [decompiled/core_module/scripts/yishi/datas/templates/GoddessTempInfo.as:24] XML: GoddessTemplateInfos.MaxDevote';
COMMENT ON COLUMN game.goddesses.battle_picture IS 'Vazio; ignorado (não existe na classe) (suposição: imagem antiga). [data/tpl/tempinfos/GoddessTemplateInfos.xml] XML: GoddessTemplateInfos.BattlePic';
COMMENT ON COLUMN game.goddesses.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.goddesses.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.goddess_levels (
  id integer NOT NULL,
  goddess_type smallint,
  level integer,
  required_item_id integer,
  required_gp integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  hit_points integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.goddess_levels IS 'Níveis das deusas (1..240): custo e atributos concedidos. Origem: tempinfos.xml/GoddessUpgradeTemplates.';
COMMENT ON COLUMN game.goddess_levels.id IS 'Type×100000+Type×1000+Level. [data/tpl/tempinfos/GoddessUpgradeTemplates.xml] XML: GoddessUpgradeTemplates.TemplateId';
COMMENT ON COLUMN game.goddess_levels.goddess_type IS 'Tipo. Enum: meta.enum_values.enum_name=''goddess_type''. [decompiled/core_module/scripts/yishi/datas/templates/GoddessUpLevelTempInfo.as:6] XML: GoddessUpgradeTemplates.Type';
COMMENT ON COLUMN game.goddess_levels.level IS 'Nível 1..240 (chave Type_Level). [decompiled/core_module/scripts/yishi/datas/templates/GoddessUpLevelTempInfo.as:8] XML: GoddessUpgradeTemplates.Level';
COMMENT ON COLUMN game.goddess_levels.required_item_id IS 'Item de EXP (212027 Larimar). [decompiled/core_module/scripts/yishi/datas/templates/GoddessUpLevelTempInfo.as:10] XML: GoddessUpgradeTemplates.NeedItemId';
COMMENT ON COLUMN game.goddess_levels.required_gp IS 'EXP para chegar ao nível. [decompiled/m5/scripts/goddess/view/GoddessLevelView.as:210] XML: GoddessUpgradeTemplates.NeedGp';
COMMENT ON COLUMN game.goddess_levels.attack IS 'Ataque físico base. [decompiled/m5/scripts/goddess/item/GoddessLevelItem.as:148] XML: GoddessUpgradeTemplates.Attack';
COMMENT ON COLUMN game.goddess_levels.defense IS 'Defesa física. [decompiled/m5/scripts/goddess/item/GoddessLevelItem.as:149] XML: GoddessUpgradeTemplates.Defance';
COMMENT ON COLUMN game.goddess_levels.magic_attack IS 'Ataque mágico (não exibido). [decompiled/core_module/scripts/yishi/datas/templates/GoddessUpLevelTempInfo.as:16] XML: GoddessUpgradeTemplates.MagicAttack';
COMMENT ON COLUMN game.goddess_levels.magic_defense IS 'Defesa mágica. [decompiled/m5/scripts/goddess/item/GoddessLevelItem.as:150] XML: GoddessUpgradeTemplates.MagicDefance';
COMMENT ON COLUMN game.goddess_levels.hit_points IS 'Vida. [decompiled/m5/scripts/goddess/item/GoddessLevelItem.as:151] XML: GoddessUpgradeTemplates.Live';
COMMENT ON COLUMN game.goddess_levels.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.goddess_levels.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.goddess_steps (
  id integer NOT NULL,
  goddess_type smallint,
  level integer,
  star smallint,
  required_item_id integer,
  required_gp integer,
  bonus_percent integer,
  skill_id integer,
  initial_belief integer,
  action_belief integer,
  required_grade integer,
  quality smallint,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.goddess_steps IS 'Estágios/estrelas das deusas: custo, % adicional, skill liberada e crença. Origem: tempinfos.xml/GoddessStepTemplates.';
COMMENT ON COLUMN game.goddess_steps.id IS 'Type×100+Level. [data/tpl/tempinfos/GoddessStepTemplates.xml] XML: GoddessStepTemplates.TemplateId';
COMMENT ON COLUMN game.goddess_steps.goddess_type IS 'Tipo. Enum: meta.enum_values.enum_name=''goddess_type''. [decompiled/core_module/scripts/yishi/datas/templates/GoddessAdvaceTempInfo.as:8] XML: GoddessStepTemplates.Type';
COMMENT ON COLUMN game.goddess_steps.level IS 'Estágio 0..40. [decompiled/core_module/scripts/yishi/datas/templates/GoddessAdvaceTempInfo.as:10] XML: GoddessStepTemplates.Level';
COMMENT ON COLUMN game.goddess_steps.star IS 'Estrelas 0..10 (reinicia a cada 10). [decompiled/m5/scripts/goddess/view/GoddessAvaterView.as:194] XML: GoddessStepTemplates.Star';
COMMENT ON COLUMN game.goddess_steps.required_item_id IS 'Fragmento consumido. [decompiled/core_module/scripts/yishi/datas/templates/GoddessAdvaceTempInfo.as:14] XML: GoddessStepTemplates.NeedItemId';
COMMENT ON COLUMN game.goddess_steps.required_gp IS 'EXP de estágio. [decompiled/m5/scripts/goddess/page/GoddessAdvancePage.as:104] XML: GoddessStepTemplates.NeedGp';
COMMENT ON COLUMN game.goddess_steps.bonus_percent IS '% de bônus sobre stats de nível (+15/estágio). [decompiled/m5/scripts/goddess/page/GoddessAdvancePage.as:310] XML: GoddessStepTemplates.AddPer';
COMMENT ON COLUMN game.goddess_steps.skill_id IS 'Habilidade ativa (''dança''). [decompiled/core_module/scripts/yishi/datas/templates/GoddessAdvaceTempInfo.as:35] XML: GoddessStepTemplates.SkillId';
COMMENT ON COLUMN game.goddess_steps.initial_belief IS 'Fé inicial em batalha. [decompiled/core_module/scripts/managers/GodDessManager.as:94] XML: GoddessStepTemplates.InitBelief';
COMMENT ON COLUMN game.goddess_steps.action_belief IS 'Fé ganha por ação (suposição). [decompiled/core_module/scripts/managers/GodDessManager.as:95] XML: GoddessStepTemplates.ActionBelief';
COMMENT ON COLUMN game.goddess_steps.required_grade IS 'Nível mínimo da deusa para avançar. [decompiled/m5/scripts/goddess/page/GoddessAdvancePage.as:261] XML: GoddessStepTemplates.NeedGrade';
COMMENT ON COLUMN game.goddess_steps.quality IS 'Qualidade/frame. Enum: meta.enum_values.enum_name=''goddess_step_quality''. [decompiled/m5/scripts/goddess/item/GoddessSelectItem.as:105] XML: GoddessStepTemplates.Quality';
COMMENT ON COLUMN game.goddess_steps.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.goddess_steps.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.vehicles (
  id integer NOT NULL,
  name text,
  attack integer,
  diamond_cost integer,
  defense integer,
  hp integer,
  dodge integer,
  genius_skill_id integer,
  normal_skill_id integer,
  description text,
  avatar_path text,
  required_grade integer,
  speed integer,
  sort_order integer,
  vehicle_type smallint,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.vehicles IS 'Veículos (minijogo de veículos/batalha de máquinas): atributos, skills e avatar. Origem: tempinfos.xml/VehicleObjectTempInfos.';
COMMENT ON COLUMN game.vehicles.id IS 'Id. [decompiled/core_module/scripts/yishi/datas/templates/VehicleObjectTempInfo.as:8] XML: VehicleObjectTempInfos.TemplateId';
COMMENT ON COLUMN game.vehicles.name IS 'Nome. [decompiled/core_module/scripts/yishi/datas/templates/VehicleObjectTempInfo.as:10] XML: VehicleObjectTempInfos.TemplateName';
COMMENT ON COLUMN game.vehicles.attack IS 'Ataque base. [decompiled/core_module/scripts/yishi/datas/templates/VehicleObjectTempInfo.as:12] XML: VehicleObjectTempInfos.Attack';
COMMENT ON COLUMN game.vehicles.diamond_cost IS 'Diamantes para desbloqueio antecipado. [decompiled/m9/scripts/vehicle/daimon/view/DaimonRightView.as:215] XML: VehicleObjectTempInfos.NeedDiamond';
COMMENT ON COLUMN game.vehicles.defense IS 'Defesa base. [decompiled/core_module/scripts/yishi/datas/templates/VehicleObjectTempInfo.as:14] XML: VehicleObjectTempInfos.Defence';
COMMENT ON COLUMN game.vehicles.hp IS 'Vida base. [decompiled/core_module/scripts/yishi/datas/templates/VehicleObjectTempInfo.as:16] XML: VehicleObjectTempInfos.Hp';
COMMENT ON COLUMN game.vehicles.dodge IS 'Esquiva % (suposição; não lido). [decompiled/core_module/scripts/yishi/datas/templates/VehicleObjectTempInfo.as:18] XML: VehicleObjectTempInfos.Dodge';
COMMENT ON COLUMN game.vehicles.genius_skill_id IS 'Skill de talento/passiva. [decompiled/m17/scripts/com/map/vehicle/data/PlayerVehicleInfo.as:191] XML: VehicleObjectTempInfos.GeniusSkill';
COMMENT ON COLUMN game.vehicles.normal_skill_id IS 'Skill normal. [decompiled/m17/scripts/com/map/vehicle/data/PlayerVehicleInfo.as:201] XML: VehicleObjectTempInfos.NormalSkill';
COMMENT ON COLUMN game.vehicles.description IS 'Descrição. [decompiled/core_module/scripts/yishi/datas/templates/VehicleObjectTempInfo.as:24] XML: VehicleObjectTempInfos.Description';
COMMENT ON COLUMN game.vehicles.avatar_path IS '''/vehicle_N'' → vehicle/avatar{Avatar}/2.swf; prévia equip_show{Avatar}/2.png. [decompiled/core_module/scripts/yishi/manager/PathManager.as:630] XML: VehicleObjectTempInfos.Avatar';
COMMENT ON COLUMN game.vehicles.required_grade IS 'Nível tecnológico mínimo. [decompiled/m9/scripts/vehicle/daimon/view/DaimonRightView.as:209] XML: VehicleObjectTempInfos.NeedGrades';
COMMENT ON COLUMN game.vehicles.speed IS 'Velocidade base. [decompiled/m17/scripts/com/map/vehicle/data/PlayerVehicleInfo.as:324] XML: VehicleObjectTempInfos.Speed';
COMMENT ON COLUMN game.vehicles.sort_order IS 'Ordem. [decompiled/core_module/scripts/mvc/module/vehicle/DaimonModel.as:207] XML: VehicleObjectTempInfos.Sort';
COMMENT ON COLUMN game.vehicles.vehicle_type IS 'Categoria. Enum: meta.enum_values.enum_name=''vehicle_object_type''. [decompiled/core_module/scripts/mvc/module/vehicle/DaimonModel.as:44] XML: VehicleObjectTempInfos.Type';
COMMENT ON COLUMN game.vehicles.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.vehicles.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.vehicle_skills (
  id integer NOT NULL,
  action_id integer,
  name text,
  icon text,
  cast_time_ms integer,
  cooldown_ms integer,
  injury_effect integer,
  friend_or_foe smallint,
  power integer,
  power2 integer,
  maximum integer,
  attack_range integer,
  damage_coverage integer,
  description text,
  buffs integer[],
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.vehicle_skills IS 'Skills de veículo: tempo de conjuração, recarga, alcance, área e buffs. Origem: tempinfos.xml/VehicleSkillTempInfos.';
COMMENT ON COLUMN game.vehicle_skills.id IS 'Id. [decompiled/core_module/scripts/yishi/datas/templates/VehicleSkillTempInfo.as:6] XML: VehicleSkillTempInfos.TemplateId';
COMMENT ON COLUMN game.vehicle_skills.action_id IS 'Animação vehicle/skill/{ActionId}.swf. [decompiled/m17/scripts/com/map/vehicle/SkillEffectFactory.as:60] XML: VehicleSkillTempInfos.ActionId';
COMMENT ON COLUMN game.vehicle_skills.name IS 'Nome. [decompiled/core_module/scripts/yishi/datas/templates/VehicleSkillTempInfo.as:8] XML: VehicleSkillTempInfos.TemplateName';
COMMENT ON COLUMN game.vehicle_skills.icon IS 'Ícone. [decompiled/m17/scripts/com/map/vehicle/view/VehicleSkillIcon.as:90] XML: VehicleSkillTempInfos.Icons';
COMMENT ON COLUMN game.vehicle_skills.cast_time_ms IS 'Conjuração ms. [decompiled/m17/scripts/com/map/vehicle/action/CastAction.as:154] XML: VehicleSkillTempInfos.CastTime';
COMMENT ON COLUMN game.vehicle_skills.cooldown_ms IS 'Recarga ms. [decompiled/m16/scripts/yishi/view/tips/DaimonSkillTip.as:62] XML: VehicleSkillTempInfos.CoolDown';
COMMENT ON COLUMN game.vehicle_skills.injury_effect IS 'Alvo/forma. Enum: meta.enum_values.enum_name=''vehicle_injury_effect''. [decompiled/m3/scripts/map/internals/constant/MapGlobal.as:9] XML: VehicleSkillTempInfos.InjuryEffect';
COMMENT ON COLUMN game.vehicle_skills.friend_or_foe IS 'Quem pode ser alvo. Enum: meta.enum_values.enum_name=''vehicle_iff''. [decompiled/m17/scripts/com/map/vehicle/action/CastAction.as:374] XML: VehicleSkillTempInfos.IFF';
COMMENT ON COLUMN game.vehicle_skills.power IS '% do ataque como dano (não lido). [data/tpl/tempinfos/VehicleSkillTempInfos.xml] XML: VehicleSkillTempInfos.Power';
COMMENT ON COLUMN game.vehicle_skills.power2 IS 'Valor fixo (cura/dano) (suposição). [data/tpl/tempinfos/VehicleSkillTempInfos.xml] XML: VehicleSkillTempInfos.Power2';
COMMENT ON COLUMN game.vehicle_skills.maximum IS 'Cargas/munição (-1 ilimitado). [decompiled/m17/scripts/com/map/vehicle/data/VehicleSkillbag.as:34] XML: VehicleSkillTempInfos.Maximum';
COMMENT ON COLUMN game.vehicle_skills.attack_range IS 'Alcance px. [decompiled/m17/scripts/com/map/vehicle/action/CastAction.as:78] XML: VehicleSkillTempInfos.AttackRange';
COMMENT ON COLUMN game.vehicle_skills.damage_coverage IS 'Raio de área px. [decompiled/m17/scripts/com/map/vehicle/action/CastAction.as:308] XML: VehicleSkillTempInfos.DamageCoverage';
COMMENT ON COLUMN game.vehicle_skills.description IS 'Texto. [decompiled/m16/scripts/yishi/view/tips/DaimonSkillTip.as:63] XML: VehicleSkillTempInfos.Description';
COMMENT ON COLUMN game.vehicle_skills.buffs IS 'Pares buffId,chance. ''buffId,chance%'' (não lido). [data/tpl/tempinfos/VehicleSkillTempInfos.xml] XML: VehicleSkillTempInfos.Buffs';
COMMENT ON COLUMN game.vehicle_skills.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.vehicle_skills.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.vehicle_buffs (
  id integer NOT NULL,
  name text,
  icon text,
  effect_type integer,
  effect_value integer,
  effect_percent integer,
  toggle_percent integer,
  prepare_time_ms integer,
  duration_ms integer,
  interval_ms integer,
  last_effect text,
  description text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.vehicle_buffs IS 'Buffs do minijogo de veículos. Origem: tempinfos.xml/VehicleBuffTempInfos.';
COMMENT ON COLUMN game.vehicle_buffs.id IS 'Id do buff. [decompiled/core_module/scripts/yishi/datas/templates/VehicleSkillBuffTemplate.as:8] XML: VehicleBuffTempInfos.TemplateId';
COMMENT ON COLUMN game.vehicle_buffs.name IS 'Nome. [decompiled/core_module/scripts/yishi/datas/templates/VehicleSkillBuffTemplate.as:10] XML: VehicleBuffTempInfos.Name';
COMMENT ON COLUMN game.vehicle_buffs.icon IS 'icon{Icon}. [decompiled/m17/scripts/com/map/vehicle/view/VehicleBufferBar.as:98] XML: VehicleBuffTempInfos.Icon';
COMMENT ON COLUMN game.vehicle_buffs.effect_type IS 'Efeito. Enum: meta.enum_values.enum_name=''vehicle_buff_effect_type''. [decompiled/m3/scripts/map/campaign/action/ActiveVehicleDannyAction.as:282] XML: VehicleBuffTempInfos.EffectType';
COMMENT ON COLUMN game.vehicle_buffs.effect_value IS 'Valor plano (19 = id do veículo). [decompiled/m3/scripts/map/campaign/action/ActiveVehicleDannyAction.as:304] XML: VehicleBuffTempInfos.EffectValue';
COMMENT ON COLUMN game.vehicle_buffs.effect_percent IS 'Valor %. [decompiled/m17/scripts/com/map/vehicle/data/PlayerVehicleInfo.as:360] XML: VehicleBuffTempInfos.EffectPercent';
COMMENT ON COLUMN game.vehicle_buffs.toggle_percent IS 'Chance de ativar % (não lido). [data/tpl/tempinfos/VehicleBuffTempInfos.xml] XML: VehicleBuffTempInfos.TogglePercent';
COMMENT ON COLUMN game.vehicle_buffs.prepare_time_ms IS 'Atraso (ms), sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/VehicleSkillBuffTemplate.as:26] XML: VehicleBuffTempInfos.PrepareTime';
COMMENT ON COLUMN game.vehicle_buffs.duration_ms IS 'Duração ms (-1 permanente, 0 instantâneo). [decompiled/core_module/scripts/yishi/datas/templates/VehicleSkillBuffTemplate.as:62] XML: VehicleBuffTempInfos.Duration';
COMMENT ON COLUMN game.vehicle_buffs.interval_ms IS 'Tick ms de DoT/HoT. [data/tpl/tempinfos/VehicleBuffTempInfos.xml] XML: VehicleBuffTempInfos.Interval';
COMMENT ON COLUMN game.vehicle_buffs.last_effect IS 'Classe asset.vehicle.{LastEffect} (_a cabeça, _b corpo). [decompiled/m17/scripts/com/map/vehicle/SkillEffectFactory.as:160] XML: VehicleBuffTempInfos.LastEffect';
COMMENT ON COLUMN game.vehicle_buffs.description IS 'Texto. [data/tpl/tempinfos/VehicleBuffTempInfos.xml] XML: VehicleBuffTempInfos.Description';
COMMENT ON COLUMN game.vehicle_buffs.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.vehicle_buffs.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.runes (
  id integer NOT NULL,
  name text,
  rune_type integer,
  son_type integer,
  job_id smallint,
  rune_grade integer,
  skill_id integer,
  rune_index integer,
  icon text,
  next_rune_id integer,
  required_gp integer,
  use_count integer,
  required_grade integer,
  description text,
  level integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.runes IS 'Runas: cada runa é uma skill (SkillTemplateId) com nível, custo em GP e cadeia de evolução. Origem: tempinfos.xml/RuneTempInfos.';
COMMENT ON COLUMN game.runes.id IS 'ID do grau da runa: RuneType*100 + grau (avançadas 211-218, 311-318, 811-818, 911-918). [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:6] XML: RuneTempInfos.TemplateId';
COMMENT ON COLUMN game.runes.name IS 'Nome pt-BR (14 distintos: 10 básicos + 4 ''Avançada''). [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:8] XML: RuneTempInfos.TemplateName';
COMMENT ON COLUMN game.runes.rune_type IS 'Tipo de runa (1-10). Enum: meta.enum_values.enum_name=''rune_type''. [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:12] XML: RuneTempInfos.RuneType';
COMMENT ON COLUMN game.runes.son_type IS 'Subtipo constante 91 (sem uso no cliente; suposição: categoria ''runa''). [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:10] XML: RuneTempInfos.SonType';
COMMENT ON COLUMN game.runes.job_id IS 'Profissões permitidas (string; ''0'' = todas). [decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2176] XML: RuneTempInfos.Job';
COMMENT ON COLUMN game.runes.rune_grade IS 'Grau dentro da camada (1-10 básica, 1-8 avançada). [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:16] XML: RuneTempInfos.RuneGrade';
COMMENT ON COLUMN game.runes.skill_id IS 'Habilidade de combate da runa (SkillTempInfos, SonType 9001-9010, CD 75 s básica/45 s avançada). [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:20] XML: RuneTempInfos.SkillTemplateId';
COMMENT ON COLUMN game.runes.rune_index IS 'Posição/ordem do slot da runa na barra (0-9) e chave em thane.runeCate. [decompiled/m5/scripts/armyII/viewII/rune/RuneView.as:191] XML: RuneTempInfos.RuneIndex';
COMMENT ON COLUMN game.runes.icon IS 'Ícone PNG (/rune_rage.png, /rune_crazy.png, /rune_crazyex.png …; ''ex'' = avançada). [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:22] XML: RuneTempInfos.Icon';
COMMENT ON COLUMN game.runes.next_rune_id IS 'Próximo grau (0 = máximo). Se Level do próximo ≠ atual, exige promoção (RUNE_PROMOT). [decompiled/core_module/scripts/mvc/module/armyII/RuneInfo.as:51] XML: RuneTempInfos.NextRuneId';
COMMENT ON COLUMN game.runes.required_gp IS 'XP rúnica (pedras rúnicas absorvidas) necessária para alcançar este grau; 0 no grau 1. [decompiled/m5/scripts/armyII/viewII/rune/RuneUpgradeView.as:586] XML: RuneTempInfos.NeedGp';
COMMENT ON COLUMN game.runes.use_count IS 'Usos máximos por batalha (1-4) — ''Uso máximo em combate: {0} vezes''. [decompiled/m16/scripts/yishi/view/tips/goods/RuneTips.as:135] XML: RuneTempInfos.UseCount';
COMMENT ON COLUMN game.runes.required_grade IS 'Nível exigido: do herói (Level 0, 35-80) ou de profissão/vocação (Level 1, 1-71). [decompiled/m5/scripts/armyII/viewII/rune/RuneItemView.as:732] XML: RuneTempInfos.NeedGrade';
COMMENT ON COLUMN game.runes.description IS 'Efeito pt-BR do grau. [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:32] XML: RuneTempInfos.Description';
COMMENT ON COLUMN game.runes.level IS 'Camada: 0 básica, 1 avançada. Enum: meta.enum_values.enum_name=''rune_level''. [decompiled/core_module/scripts/yishi/datas/templates/RuneTemplateInfo.as:34] XML: RuneTempInfos.Level';
COMMENT ON COLUMN game.runes.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.runes.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.magic_cards (
  template_id integer NOT NULL,
  name text,
  grade integer NOT NULL,
  card_type smallint,
  active_scene smallint,
  profile smallint,
  position smallint,
  skill_id integer,
  magic_dust_cost integer,
  icon text,
  description1 text,
  description2 text,
  activation_item_id integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (template_id, grade)
);
COMMENT ON TABLE game.magic_cards IS 'Cartas mágicas: cada carta (template) tem graus; cada grau concede uma skill; ativada por item. Origem: tempinfos.xml/MagicCardTempInfos.';
COMMENT ON COLUMN game.magic_cards.template_id IS 'ID da carta (20 cartas: 10001-10004, 10011-10026); chave composta com Grades. [decompiled/core_module/scripts/yishi/datas/templates/MagicCardTemplateInfo.as:6] XML: MagicCardTempInfos.TemplateId';
COMMENT ON COLUMN game.magic_cards.name IS 'Nome pt-BR (ex.: ''Soldado Tau - Kyle''). [decompiled/core_module/scripts/yishi/datas/templates/MagicCardTemplateInfo.as:8] XML: MagicCardTempInfos.TemplateName';
COMMENT ON COLUMN game.magic_cards.grade IS 'Nível da carta 1-9 (cada carta tem 9 linhas). [decompiled/core_module/scripts/yishi/datas/templates/MagicCardTemplateInfo.as:10] XML: MagicCardTempInfos.Grades';
COMMENT ON COLUMN game.magic_cards.card_type IS 'Série da carta. Enum: meta.enum_values.enum_name=''magic_card_type''. [decompiled/core_module/scripts/yishi/datas/templates/MagicCardTemplateInfo.as:12] XML: MagicCardTempInfos.Types';
COMMENT ON COLUMN game.magic_cards.active_scene IS 'Modo de jogo onde a carta vale (== Types). Enum: meta.enum_values.enum_name=''magic_card_active_scene''. [decompiled/core_module/scripts/yishi/datas/templates/MagicCardTemplateInfo.as:14] XML: MagicCardTempInfos.ActiveScene';
COMMENT ON COLUMN game.magic_cards.profile IS 'Qualidade 1-4 (== Pos). Enum: meta.enum_values.enum_name=''magic_card_profile''. [decompiled/core_module/scripts/yishi/datas/templates/MagicCardTemplateInfo.as:16] XML: MagicCardTempInfos.Profile';
COMMENT ON COLUMN game.magic_cards.position IS 'Posição na série 1-4. Enum: meta.enum_values.enum_name=''magic_card_pos''. [decompiled/core_module/scripts/yishi/datas/templates/MagicCardTemplateInfo.as:18] XML: MagicCardTempInfos.Pos';
COMMENT ON COLUMN game.magic_cards.skill_id IS 'Habilidade(s) passiva(s) da carta neste nível (SkillTempInfos 403TTPGG, ex.: ''Diminui 6% do dano recebido''). [decompiled/m5/scripts/magicCard/view/MagicCardCell.as:308] XML: MagicCardTempInfos.SkillTempIds';
COMMENT ON COLUMN game.magic_cards.magic_dust_cost IS 'Pó mágico para subir a ESTE nível (Nv.1 = 0; Profile 1: 50…500; Profile 4: 200…2000). [decompiled/m16/scripts/yishi/view/tips/MagicCardLvUpTips.as:118] XML: MagicCardTempInfos.NeedMagicDust';
COMMENT ON COLUMN game.magic_cards.icon IS 'Imagem da carta (/card_tauren01, /card_skeleton0N, /card_light0N, /card_dark0N, /card_old0N). [decompiled/core_module/scripts/yishi/datas/templates/MagicCardTemplateInfo.as:24] XML: MagicCardTempInfos.Icon';
COMMENT ON COLUMN game.magic_cards.description1 IS 'Texto descritivo (sempre 0). [decompiled/m5/scripts/magicCard/view/MagicCardCell.as:325] XML: MagicCardTempInfos.Description1';
COMMENT ON COLUMN game.magic_cards.description2 IS 'Texto secundário (sempre 0). [decompiled/m5/scripts/magicCard/view/MagicCardCell.as:329] XML: MagicCardTempInfos.Description2';
COMMENT ON COLUMN game.magic_cards.activation_item_id IS 'Item que ativa a carta (ItemTempInfos SonType 600, 6000001-6000026, ex.: ''Soldado Tau · Kyle''). [decompiled/core_module/scripts/mvc/module/card/MagicCardModel.as:157] XML: MagicCardTempInfos.ActiveNeedTempId';
COMMENT ON COLUMN game.magic_cards.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.magic_cards.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.artifacts (
  id integer NOT NULL,
  name text,
  son_type integer,
  attack_aptitude integer[],
  defense_aptitude integer[],
  magic_attack_aptitude integer[],
  magic_defense_aptitude integer[],
  penetration_aptitude integer[],
  parry_aptitude integer[],
  hit_points_aptitude integer[],
  attack_conversion integer[],
  defense_conversion integer[],
  magic_attack_conversion integer[],
  magic_defense_conversion integer[],
  penetration_conversion integer[],
  parry_conversion integer[],
  hit_points_conversion integer[],
  required_item_id integer,
  icon text,
  skill_id integer,
  is_open boolean,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.artifacts IS 'Artefatos lendários: aptidões ''base,máx'' e conversões de atributo, item de ativação e skill. Origem: tempinfos.xml/ArtifactTemplateInfos.';
COMMENT ON COLUMN game.artifacts.id IS 'Id (100..1200). [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:6] XML: ArtifactTemplateInfos.TemplateId';
COMMENT ON COLUMN game.artifacts.name IS 'Nome. [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:8] XML: ArtifactTemplateInfos.TemplateName';
COMMENT ON COLUMN game.artifacts.son_type IS 'Id visual → swf/avatar/legend/{SonType}.swf. [decompiled/core_module/scripts/yishi/manager/PathManager.as:670] XML: ArtifactTemplateInfos.SonType';
COMMENT ON COLUMN game.artifacts.attack_aptitude IS '''min,max'': [0] valor inicial, [1] teto de treino (max = min×1000). [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:41] XML: ArtifactTemplateInfos.AttackApt';
COMMENT ON COLUMN game.artifacts.defense_aptitude IS '''min,max'': [0] valor inicial, [1] teto de treino (max = min×1000). [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:41] XML: ArtifactTemplateInfos.DefenceApt';
COMMENT ON COLUMN game.artifacts.magic_attack_aptitude IS '''min,max'': [0] valor inicial, [1] teto de treino (max = min×1000). [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:41] XML: ArtifactTemplateInfos.MagicAttackApt';
COMMENT ON COLUMN game.artifacts.magic_defense_aptitude IS '''min,max'': [0] valor inicial, [1] teto de treino (max = min×1000). [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:41] XML: ArtifactTemplateInfos.MagicDefenceApt';
COMMENT ON COLUMN game.artifacts.penetration_aptitude IS '''min,max'': [0] valor inicial, [1] teto de treino (max = min×1000). [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:41] XML: ArtifactTemplateInfos.PenetrateApt';
COMMENT ON COLUMN game.artifacts.parry_aptitude IS '''min,max'': [0] valor inicial, [1] teto de treino (max = min×1000). [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:41] XML: ArtifactTemplateInfos.ParryApt';
COMMENT ON COLUMN game.artifacts.hit_points_aptitude IS '''min,max'': [0] valor inicial, [1] teto de treino (max = min×1000). [decompiled/core_module/scripts/yishi/datas/templates/ArtifactTemplateInfo.as:41] XML: ArtifactTemplateInfos.LiveApt';
COMMENT ON COLUMN game.artifacts.attack_conversion IS 'Não lido pelo cliente (suposição: faixa de pontos por Pedra dos Deuses 212018 no fortalecimento). [data/tpl/tempinfos/ArtifactTemplateInfos.xml] XML: ArtifactTemplateInfos.AttackConv';
COMMENT ON COLUMN game.artifacts.defense_conversion IS 'Não lido pelo cliente (suposição: faixa de pontos por Pedra dos Deuses 212018 no fortalecimento). [data/tpl/tempinfos/ArtifactTemplateInfos.xml] XML: ArtifactTemplateInfos.DefenceConv';
COMMENT ON COLUMN game.artifacts.magic_attack_conversion IS 'Não lido pelo cliente (suposição: faixa de pontos por Pedra dos Deuses 212018 no fortalecimento). [data/tpl/tempinfos/ArtifactTemplateInfos.xml] XML: ArtifactTemplateInfos.MagicAttackConv';
COMMENT ON COLUMN game.artifacts.magic_defense_conversion IS 'Não lido pelo cliente (suposição: faixa de pontos por Pedra dos Deuses 212018 no fortalecimento). [data/tpl/tempinfos/ArtifactTemplateInfos.xml] XML: ArtifactTemplateInfos.MagicDefenceConv';
COMMENT ON COLUMN game.artifacts.penetration_conversion IS 'Não lido pelo cliente (suposição: faixa de pontos por Pedra dos Deuses 212018 no fortalecimento). [data/tpl/tempinfos/ArtifactTemplateInfos.xml] XML: ArtifactTemplateInfos.PenetrateConv';
COMMENT ON COLUMN game.artifacts.parry_conversion IS 'Não lido pelo cliente (suposição: faixa de pontos por Pedra dos Deuses 212018 no fortalecimento). [data/tpl/tempinfos/ArtifactTemplateInfos.xml] XML: ArtifactTemplateInfos.ParryConv';
COMMENT ON COLUMN game.artifacts.hit_points_conversion IS 'Não lido pelo cliente (suposição: faixa de pontos por Pedra dos Deuses 212018 no fortalecimento). [data/tpl/tempinfos/ArtifactTemplateInfos.xml] XML: ArtifactTemplateInfos.LiveConv';
COMMENT ON COLUMN game.artifacts.required_item_id IS 'Item que ativa (241001..241012, SonType 625). [decompiled/m11/scripts/ancientartifact/view/AncientMiddleView.as:209] XML: ArtifactTemplateInfos.NeedItem';
COMMENT ON COLUMN game.artifacts.icon IS 'icon/legend_{id}.png. [decompiled/core_module/scripts/yishi/utils/IconFactory.as:40] XML: ArtifactTemplateInfos.Icon';
COMMENT ON COLUMN game.artifacts.skill_id IS 'SonType de skill (SkillTempInfos.SonType + grau). [decompiled/core_module/scripts/yishi/view/tips/goods/ArtifactEquipTip.as:165] XML: ArtifactTemplateInfos.Skills';
COMMENT ON COLUMN game.artifacts.is_open IS '1 = aparece na lista. Enum: meta.enum_values.enum_name=''bool_int''. [decompiled/core_module/scripts/yishi/manager/AncientArtifactManager.as:316] XML: ArtifactTemplateInfos.IsOpen';
COMMENT ON COLUMN game.artifacts.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.artifacts.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.appellations (
  id integer NOT NULL,
  appell_type smallint,
  title text,
  description text,
  quality smallint,
  notice boolean,
  prefix text,
  sort_order integer,
  is_permanent boolean,
  condition_type integer,
  condition_params text,
  job_id smallint,
  show_params integer[],
  skill_id integer,
  buffs text,
  duration integer,
  is_hidden boolean,
  is_title_hidden boolean,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.appellations IS 'Títulos (appell): condição de obtenção, prefixo exibido sobre o nome, skills/buffs concedidos e duração. Origem: tempinfos.xml/AppellInfos.';
COMMENT ON COLUMN game.appellations.id IS 'Id do título (1..1834); chave de AppellsMsg.appellId/ThaneInfo.appellId; ItemTempInfos(SonType 221).Property1 aponta para cá. [decompiled/core_module/scripts/yishi/datas/templates/AppellInfoTemplate.as:8] XML: AppellInfos.TemplateId';
COMMENT ON COLUMN game.appellations.appell_type IS 'Aba. Enum: meta.enum_values.enum_name=''appell_type''. [decompiled/core_module/scripts/mvc/module/appell/AppellModel.as:87] XML: AppellInfos.Type';
COMMENT ON COLUMN game.appellations.title IS 'Nome (''\n'' vira quebra em htmlTitle). [decompiled/core_module/scripts/yishi/datas/templates/AppellInfoTemplate.as:63] XML: AppellInfos.Title';
COMMENT ON COLUMN game.appellations.description IS 'Descrição/condição. [decompiled/m5/scripts/appell/AppellFrame.as:679] XML: AppellInfos.Descript';
COMMENT ON COLUMN game.appellations.quality IS 'Estilo do nome. Enum: meta.enum_values.enum_name=''appell_quality''. [decompiled/core_module/scripts/yishi/manager/AppellManager.as:75] XML: AppellInfos.Quality';
COMMENT ON COLUMN game.appellations.notice IS '''true'' = popup AppellGetView + notificação ao ganhar (opcode 4491). Enum: meta.enum_values.enum_name=''bool_text''. [decompiled/core_module/scripts/yishi/manager/AppellManager.as:113] XML: AppellInfos.Notice';
COMMENT ON COLUMN game.appellations.prefix IS 'Prefixo ''texto|estilo'' exibido junto ao nome. Prefixo de chat ''texto|n'' (n = índice em COLORS); vazio = sem prefixo; bitmap asset.chatII.Appell1..12 por id. Enum: meta.enum_values.enum_name=''appell_color''. [decompiled/core_module/scripts/chat/datas/ChatCellData.as:105] XML: AppellInfos.Perfix';
COMMENT ON COLUMN game.appellations.sort_order IS 'Prioridade de ordenação (desc), após isGet. [decompiled/core_module/scripts/mvc/module/appell/AppellModel.as:74] XML: AppellInfos.Sort';
COMMENT ON COLUMN game.appellations.is_permanent IS '''true'' = renovável/temporário (ids 140-142, 431); se já obtido e false, carta não pode ser usada. Enum: meta.enum_values.enum_name=''bool_text''. [decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:603] XML: AppellInfos.IsLong';
COMMENT ON COLUMN game.appellations.condition_type IS 'Condição de obtenção (ranking, conquista...). Condição de obtenção. Enum: meta.enum_values.enum_name=''appell_condition_type''. [decompiled/core_module/scripts/mvc/module/appell/AppellModel.as:136] XML: AppellInfos.CondtionType';
COMMENT ON COLUMN game.appellations.condition_params IS 'Parâmetros ''a,b,...,alvo'' (''|'' separa sub-condições; último número = alvo); progresso exibido ''{atual}∕{alvo}''. [decompiled/core_module/scripts/yishi/datas/templates/AppellInfoTemplate.as:164] XML: AppellInfos.Para';
COMMENT ON COLUMN game.appellations.job_id IS 'Restrição de classe. Enum: meta.enum_values.enum_name=''appell_job''. [decompiled/core_module/scripts/yishi/manager/AppellManager.as:79] XML: AppellInfos.Job';
COMMENT ON COLUMN game.appellations.show_params IS 'Parâmetros de exibição (cores/posição). ''ImgId,Largura,Altura,txtY,fontSize,colorId'' — imagem icon/appell/{ImgId}.png sobre o personagem; ''0'' = default (65,18,0,16,1). Enum: meta.enum_values.enum_name=''appell_color''. [decompiled/core_module/scripts/avatar/view/AppellView.as:35] XML: AppellInfos.ShowParam';
COMMENT ON COLUMN game.appellations.skill_id IS 'CSV de skills passivas (atributos via SkillPropertyTempInfos; ex. 8957 ''Vida +3000''). [decompiled/core_module/scripts/mvc/module/appell/AppellModel.as:193] XML: AppellInfos.Skills';
COMMENT ON COLUMN game.appellations.buffs IS 'CSV de buffs (CampaignBufferTemps) — sempre vazio. [decompiled/core_module/scripts/mvc/module/appell/AppellModel.as:274] XML: AppellInfos.Buffs';
COMMENT ON COLUMN game.appellations.duration IS 'Não lido pelo cliente (suposição: duração; 0 permanente, 1 VIP, 3 ranking Teseu). Validade real = AppellInfoMsg.validDate. [decompiled/core_module/scripts/yishi/datas/templates/AppellInfoTemplate.as:54] XML: AppellInfos.Time';
COMMENT ON COLUMN game.appellations.is_hidden IS '1 = oculto até ser obtido. Enum: meta.enum_values.enum_name=''bool_int''. [decompiled/core_module/scripts/mvc/module/appell/AppellModel.as:94] XML: AppellInfos.IsHide';
COMMENT ON COLUMN game.appellations.is_title_hidden IS '1 = não desenha o texto sobre a imagem (sempre 0). Enum: meta.enum_values.enum_name=''bool_int''. [decompiled/core_module/scripts/avatar/view/AppellView.as:105] XML: AppellInfos.IsTitleHide';
COMMENT ON COLUMN game.appellations.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.appellations.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.vip_privileges (
  id integer NOT NULL,
  name text,
  privilege_type integer,
  vip_grade integer,
  param1 integer,
  param2 integer,
  param3 integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.vip_privileges IS 'Privilégios VIP por nível: tipo de privilégio e parâmetros ({para2} no texto). Origem: tempinfos.xml/VipPrerogativeTempInfos.';
COMMENT ON COLUMN game.vip_privileges.id IS 'Id. [decompiled/core_module/scripts/yishi/datas/templates/VipPrerogativeInfo.as:6] XML: VipPrerogativeTempInfos.id';
COMMENT ON COLUMN game.vip_privileges.name IS 'Texto com placeholders {para1}/{para2}. [decompiled/m15/scripts/vip/VipContentHelper.as:71] XML: VipPrerogativeTempInfos.name';
COMMENT ON COLUMN game.vip_privileges.privilege_type IS 'Tipo de privilégio. Enum: meta.enum_values.enum_name=''vip_prerogative_type''. [decompiled/core_module/scripts/yishi/datas/templates/VipPrerogativeInfo.as:10] XML: VipPrerogativeTempInfos.type';
COMMENT ON COLUMN game.vip_privileges.vip_grade IS 'Nível VIP. Enum: meta.enum_values.enum_name=''vip_grade''. [decompiled/core_module/scripts/yishi/datas/templates/VipPrerogativeInfo.as:12] XML: VipPrerogativeTempInfos.grade';
COMMENT ON COLUMN game.vip_privileges.param1 IS 'Valor (unidade por tipo); 0 = indisponível neste grau. [decompiled/core_module/scripts/managers/VIPManager.as:144] XML: VipPrerogativeTempInfos.para1';
COMMENT ON COLUMN game.vip_privileges.param2 IS 'Ordem na lista do grau (prefixo ''{para2},''). [decompiled/core_module/scripts/yishi/datas/templates/cate/VipPrerogativeTemplateCate.as:112] XML: VipPrerogativeTempInfos.para2';
COMMENT ON COLUMN game.vip_privileges.param3 IS '1 = destaque (novo/melhorado), cor #60d5f7. Enum: meta.enum_values.enum_name=''bool_int''. [decompiled/m15/scripts/vip/VipContentHelper.as:47] XML: VipPrerogativeTempInfos.para3';
COMMENT ON COLUMN game.vip_privileges.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.vip_privileges.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.stars (
  id integer NOT NULL,
  master_type integer,
  son_type integer,
  required_grade integer,
  name text,
  job_id smallint,
  power integer,
  agility integer,
  intellect integer,
  physique integer,
  leadership integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  hit_points integer,
  critical integer,
  parry integer,
  penetration integer,
  determination integer,
  troop_capacity integer,
  icon text,
  description text,
  profile smallint,
  sell_gold integer,
  star_point integer,
  sell_gp integer,
  default_skill_id integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.stars IS 'Estrelas (astrologia/constelação): itens de estrela que concedem atributos e skill padrão; vendidas por GP/ouro. Origem: tempinfos.xml/starTempInfos.';
COMMENT ON COLUMN game.stars.id IS 'ID do cosmo (estrela de Astrologia); id = MasterType*100 + Profile (ex.: 205 = Ataque laranja); 1-5 especiais. [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:6] XML: starTempInfos.TemplateId';
COMMENT ON COLUMN game.stars.master_type IS 'Família/atributo do cosmo; únicos por herói (não equipa dois iguais). Enum: meta.enum_values.enum_name=''star_master_type''. [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:8] XML: starTempInfos.MasterType';
COMMENT ON COLUMN game.stars.son_type IS 'Subtipo; no XML = TemplateId (exceto 1-5 = 100). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:10] XML: starTempInfos.SonType';
COMMENT ON COLUMN game.stars.required_grade IS 'Nível mínimo do herói para o cosmo (1, 40 buffs, 60 avançados, 81 Sagrado avançado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:12] XML: starTempInfos.NeedGrades';
COMMENT ON COLUMN game.stars.name IS 'Nome pt-BR (ex.: ''Divino · Áries'', ''Sagrado · Gêmeos''). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:14] XML: starTempInfos.TemplateName';
COMMENT ON COLUMN game.stars.job_id IS 'Restrição de profissão (string); sempre 0 = todas. [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:16] XML: starTempInfos.Job';
COMMENT ON COLUMN game.stars.power IS 'Força (Power). Força concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:28] XML: starTempInfos.Power';
COMMENT ON COLUMN game.stars.agility IS 'Proteção (XML Agility: +4 defesa, +4 resistência) (Agility). Proteção/Agilidade concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:30] XML: starTempInfos.Agility';
COMMENT ON COLUMN game.stars.intellect IS 'Inteligência (Intellect). Inteligência concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:32] XML: starTempInfos.Intellect';
COMMENT ON COLUMN game.stars.physique IS 'Físico (constituição) (Physique). Físico concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:34] XML: starTempInfos.Physique';
COMMENT ON COLUMN game.stars.leadership IS 'Liderança (Captain). Liderança concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:36] XML: starTempInfos.Captain';
COMMENT ON COLUMN game.stars.attack IS 'Ataque físico (Attack). Ataque físico concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:38] XML: starTempInfos.Attack';
COMMENT ON COLUMN game.stars.defense IS 'Defesa física (Defence). Defesa física concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:40] XML: starTempInfos.Defence';
COMMENT ON COLUMN game.stars.magic_attack IS 'Ataque mágico (MagicAttack). Ataque mágico concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:42] XML: starTempInfos.MagicAttack';
COMMENT ON COLUMN game.stars.magic_defense IS 'Defesa mágica (MagicDefence). Defesa mágica concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:44] XML: starTempInfos.MagicDefence';
COMMENT ON COLUMN game.stars.hit_points IS 'Vida (HP) (Live). Vida concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:50] XML: starTempInfos.Live';
COMMENT ON COLUMN game.stars.critical IS 'Crítico (ForceHit). Crítico concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:46] XML: starTempInfos.ForceHit';
COMMENT ON COLUMN game.stars.parry IS 'Bloqueio (aparar) (Parry). Bloqueio concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:48] XML: starTempInfos.Parry';
COMMENT ON COLUMN game.stars.penetration IS 'Penetração (Penetrate). Penetração (só MasterType 17-19) concedido POR NÍVEL do cosmo (valor exibido = base×grade, +% do slot refinado). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:56] XML: starTempInfos.Penetrate';
COMMENT ON COLUMN game.stars.determination IS 'Determinação/Força Consistente (resistência a atordoamento) (StunAttr). Atributo de atordoamento; sempre 0 e NÃO existe na classe StarTemplate (ignorado pelo cliente). [data/tpl/tempinfos/starTempInfos.xml] XML: starTempInfos.StunAttr';
COMMENT ON COLUMN game.stars.troop_capacity IS 'Infantaria (capacidade de tropa) (Conat). Atributo extra por nível (exibido com rótulo Tip17); sempre 0. Significado provável: tenacidade/constituição (suposição). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:52] XML: starTempInfos.Conat';
COMMENT ON COLUMN game.stars.icon IS 'Animação SWF do cosmo: /star/<id>.swf (0.swf/2.swf para energia, 1.swf para lixo). [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:18] XML: starTempInfos.Icon';
COMMENT ON COLUMN game.stars.description IS 'Texto interno: ''测试用'' (teste) ou ''高级星运'' (cosmo avançado) — não traduzido. [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:20] XML: starTempInfos.Description';
COMMENT ON COLUMN game.stars.profile IS 'Qualidade/cor; define tabela de XP de nível. Enum: meta.enum_values.enum_name=''star_profile''. [decompiled/core_module/scripts/yishi/datas/templates/StarTemplate.as:22] XML: starTempInfos.Profile';
COMMENT ON COLUMN game.stars.sell_gold IS 'Ouro recebido ao vender (só exibido para cosmos na bag temporária; buffer da Fonte Mágica pode somar %): 1200/3600/6000/8400/10800/13200/25000. [decompiled/core_module/scripts/yishi/view/tips/goods/StarTip.as:213] XML: starTempInfos.SellGold';
COMMENT ON COLUMN game.stars.star_point IS 'Preço em Pontos de Astrologia na loja ''Resgatar Pontos'' (StarShopFrame); 0 = não vendável. Loja lista os com StarPoint>0 (2000/7000/15000/30000/45000; energia 1000/5000). [decompiled/core_module/scripts/yishi/datas/templates/cate/StarTempalteCate.as:44] XML: starTempInfos.StarPoint';
COMMENT ON COLUMN game.stars.sell_gp IS 'XP base que o cosmo fornece ao ser absorvido por outro (somado ao gp acumulado): 10/30/50/70/90; energia 500/2500. [decompiled/core_module/scripts/yishi/utils/StarHelper.as:119] XML: starTempInfos.SellGp';
COMMENT ON COLUMN game.stars.default_skill_id IS 'Buffer passivo do cosmo (FK SkillBufferTempInfos.Id), valor escala com o nível ({ValuePercent}/{AttackValue}×grade). Vazio para cosmos de atributo. [decompiled/core_module/scripts/yishi/utils/StarHelper.as:307] XML: starTempInfos.DefaultSkill';
COMMENT ON COLUMN game.stars.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.stars.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.war_souls (
  id integer NOT NULL,
  name text,
  description text,
  icon text,
  profile smallint,
  main_type smallint,
  son_type integer,
  max_star smallint,
  clear_skill_id integer,
  clear_items integer[],
  decompose_items integer[],
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  hit_points integer,
  rank smallint,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.war_souls IS 'Espíritos de guerra (warsoul): tipo, estrelas máximas, skill/itens de limpeza e atributos base. Origem: tempinfos.xml/WarSoulTmpls.';
COMMENT ON COLUMN game.war_souls.id IS 'Id = SonType*10 + Profile (11..96; 54 = 9 elementos x 6 qualidades). Chave de Star/Strengthen/Reform. [decompiled/core_module/scripts/yishi/datas/templates/WarSoulTempInfo.as:6] XML: WarSoulTmpls.WarSoulId';
COMMENT ON COLUMN game.war_souls.name IS 'Nome pt-BR (9 distintos, ex.: ''Espírito da Guerra da Água''; ''Choque'' tem espaço inicial no XML). [decompiled/core_module/scripts/yishi/datas/templates/WarSoulTempInfo.as:8] XML: WarSoulTmpls.Name';
COMMENT ON COLUMN game.war_souls.description IS 'Descrição (vazia em todas as 54 linhas). [decompiled/core_module/scripts/yishi/datas/templates/WarSoulTempInfo.as:10] XML: WarSoulTmpls.Description';
COMMENT ON COLUMN game.war_souls.icon IS 'Arquivo do ícone ''<WarSoulId>.png'' (IconFactory.getTheseusWarSoulIcon). [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:313] XML: WarSoulTmpls.Icon';
COMMENT ON COLUMN game.war_souls.profile IS 'Qualidade/cor 1-6. Enum: meta.enum_values.enum_name=''warsoul_profile''. [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:314-315] XML: WarSoulTmpls.Profile';
COMMENT ON COLUMN game.war_souls.main_type IS 'Tipo principal (Natural/Polar/Espectral). Enum: meta.enum_values.enum_name=''warsoul_main_type''. [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:307] XML: WarSoulTmpls.MainType';
COMMENT ON COLUMN game.war_souls.son_type IS 'Elemento/slot 1-9. Enum: meta.enum_values.enum_name=''warsoul_son_type''. [decompiled/m5/scripts/theseus/war/item/TheseusWarEquipCell.as:144] XML: WarSoulTmpls.SonType';
COMMENT ON COLUMN game.war_souls.max_star IS 'Estrela máxima (5/10/11/13/16/20 por Profile). Estrelas exibidas em grupos de 5 com asset.core.profie.star{1..4}. [decompiled/m5/scripts/theseus/war/view/TheseusWarStarPageView.as:195,352-373] XML: WarSoulTmpls.MaxStar';
COMMENT ON COLUMN game.war_souls.clear_skill_id IS 'Pool de atributos aleatórios do Polimento = SkillTempInfos.MasterType (76401..76406 = Profile 1..6; 480 skills ''Aumento do Ataque'' etc., 8 SonTypes x 10 Grades). Resultado em WarSoulMsg.ramdomSkills. [data/tpl/tempinfos/SkillTempInfos.xml] XML: WarSoulTmpls.ClearSkill';
COMMENT ON COLUMN game.war_souls.clear_items IS 'Custo de um Polimento ''itemId,qtd'': 7620200 ''Pedra de Purificação da Guerra'' x10*Profile. [decompiled/m5/scripts/theseus/war/view/TheseusWarRefPageView.as:247-250] XML: WarSoulTmpls.ClearItem';
COMMENT ON COLUMN game.war_souls.decompose_items IS 'Retorno base ao decompor: ''7620100,1'' (1 Pedra de Fort. da Guerra) em todas. [decompiled/m5/scripts/theseus/war/view/TheseusWarFenJiePageView.as:155] XML: WarSoulTmpls.Decompose';
COMMENT ON COLUMN game.war_souls.attack IS 'Ataque físico (Attack). Ataque base (5*Profile). Valor final = base * Star.Attack/100. [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:235-237] XML: WarSoulTmpls.Attack';
COMMENT ON COLUMN game.war_souls.defense IS 'Defesa física (Defence). Defesa base (5*Profile); Star.Defence é sempre 100 → sem escala. [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:324] XML: WarSoulTmpls.Defence';
COMMENT ON COLUMN game.war_souls.magic_attack IS 'Ataque mágico (MagicAttack). Ataque Mágico base (5*Profile). [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:325] XML: WarSoulTmpls.MagicAttack';
COMMENT ON COLUMN game.war_souls.magic_defense IS 'Defesa mágica (MagicDefence). Defesa Mágica base (5*Profile). [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:326] XML: WarSoulTmpls.MagicDefence';
COMMENT ON COLUMN game.war_souls.hit_points IS 'Vida (HP) (Live). Vida base (40*Profile). [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:327] XML: WarSoulTmpls.Live';
COMMENT ON COLUMN game.war_souls.rank IS 'Escalão 1 Superior/2 Interm./3 Inferior; livro de habilidade exige Item.Property2 == Rank. Enum: meta.enum_values.enum_name=''warsoul_rank''. [decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:308] XML: WarSoulTmpls.Rank';
COMMENT ON COLUMN game.war_souls.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.war_souls.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.avenger_skills (
  id integer NOT NULL,
  skill_son_type integer,
  job_id smallint,
  skill_grade integer,
  required_body_grade integer,
  item1_id integer,
  item1_count integer,
  item2_id integer,
  item2_count integer,
  item3_id integer,
  item3_count integer,
  item4_id integer,
  item4_count integer,
  item5_id integer,
  item5_count integer,
  item6_id integer,
  item6_count integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.avenger_skills IS 'Skills do Vingador (avenger) por classe e grau, com até 6 materiais exigidos. Origem: tempinfos.xml/AvengerSkillTemplates.';
COMMENT ON COLUMN game.avenger_skills.id IS 'Id único = SkillSonType*100 + SkillGrade (51101..53610; 180 linhas = 18 SonTypes x 10 níveis). [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:6] XML: AvengerSkillTemplates.Id';
COMMENT ON COLUMN game.avenger_skills.skill_son_type IS 'Família da habilidade do Vingador (= SkillTempInfos.SonType). Chave de busca junto com SkillGrade. Enum: meta.enum_values.enum_name=''avenger_skill_son_type''. [decompiled/core_module/scripts/yishi/datas/templates/cate/AvengerSkillTempCate.as:32] XML: AvengerSkillTemplates.SkillSonType';
COMMENT ON COLUMN game.avenger_skills.job_id IS 'Profissão (1 Guerreiro, 2 Arqueiro, 3 Feiticeiro); só no XML, não lido pelo cliente. Enum: meta.enum_values.enum_name=''avenger_skill_job_type''. [data/tpl/tempinfos/AvengerSkillTemplates.xml] XML: AvengerSkillTemplates.JobType';
COMMENT ON COLUMN game.avenger_skills.skill_grade IS 'Nível atual da habilidade (1-10) = SkillTempInfos.Grades. A linha do nível N descreve o custo para evoluir N→N+1 (linha 10 tem itens 0 = máximo). [decompiled/m5/scripts/avenger/AvengerSkillEvolveFrame.as:165-166] XML: AvengerSkillTemplates.SkillGrade';
COMMENT ON COLUMN game.avenger_skills.required_body_grade IS 'BodyGrade mínimo do Corpo do Julgamento para evoluir deste nível: 33,55,77,99,121,143,165,187,209 (níveis 1-9; =BodyType 3,5,...,19 início), 0 no nível 10. Checado em AvengerSkillEvolveFrame (''Nível do Espírito da Vingança insuficiente''); o texto mostra o BodyType desse grau. [decompiled/m5/scripts/avenger/AvengerSkillEvolveFrame.as:147,180-181] XML: AvengerSkillTemplates.NeedBodyGrade';
COMMENT ON COLUMN game.avenger_skills.item1_id IS 'Material 1 para evoluir (Pedra de Julgamento; 0 = sem). Ex.: 5001101 ''Pedra de Julgamento básica - Ataque'' ... 5003406 ''especial''. Slot 1 corresponde ao atributo Ataque. Entregue item a item via op 2 (botão ''Elevar''); progresso em AvengerSkillMsg.itemInfo. [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:14] XML: AvengerSkillTemplates.NeedItem1';
COMMENT ON COLUMN game.avenger_skills.item1_count IS 'Quantidade do material 1 (10,10,10,10,10,10,15,15,20 nos níveis 1-9; 0 no 10). [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:16] XML: AvengerSkillTemplates.NeedItemNum1';
COMMENT ON COLUMN game.avenger_skills.item2_id IS 'Material 2 para evoluir (Pedra de Julgamento; 0 = sem). Ex.: 5001101 ''Pedra de Julgamento básica - Ataque'' ... 5003406 ''especial''. Slot 2 corresponde ao atributo Defesa. Entregue item a item via op 2 (botão ''Elevar''); progresso em AvengerSkillMsg.itemInfo. [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:18] XML: AvengerSkillTemplates.NeedItem2';
COMMENT ON COLUMN game.avenger_skills.item2_count IS 'Quantidade do material 2 (10,10,10,10,10,10,15,15,20 nos níveis 1-9; 0 no 10). [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:20] XML: AvengerSkillTemplates.NeedItemNum2';
COMMENT ON COLUMN game.avenger_skills.item3_id IS 'Material 3 para evoluir (Pedra de Julgamento; 0 = sem). Ex.: 5001101 ''Pedra de Julgamento básica - Ataque'' ... 5003406 ''especial''. Slot 3 corresponde ao atributo Vida. Entregue item a item via op 2 (botão ''Elevar''); progresso em AvengerSkillMsg.itemInfo. [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:22] XML: AvengerSkillTemplates.NeedItem3';
COMMENT ON COLUMN game.avenger_skills.item3_count IS 'Quantidade do material 3 (10,10,10,10,10,10,15,15,20 nos níveis 1-9; 0 no 10). [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:24] XML: AvengerSkillTemplates.NeedItemNum3';
COMMENT ON COLUMN game.avenger_skills.item4_id IS 'Material 4 para evoluir (Pedra de Julgamento; 0 = sem). Ex.: 5001101 ''Pedra de Julgamento básica - Ataque'' ... 5003406 ''especial''. Slot 4 corresponde ao atributo Crítico. Entregue item a item via op 2 (botão ''Elevar''); progresso em AvengerSkillMsg.itemInfo. [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:26] XML: AvengerSkillTemplates.NeedItem4';
COMMENT ON COLUMN game.avenger_skills.item4_count IS 'Quantidade do material 4 (10,10,10,10,10,10,15,15,20 nos níveis 1-9; 0 no 10). [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:28] XML: AvengerSkillTemplates.NeedItemNum4';
COMMENT ON COLUMN game.avenger_skills.item5_id IS 'Material 5 para evoluir (Pedra de Julgamento; 0 = sem). Ex.: 5001101 ''Pedra de Julgamento básica - Ataque'' ... 5003406 ''especial''. Slot 5 corresponde ao atributo Bloqueio. Entregue item a item via op 2 (botão ''Elevar''); progresso em AvengerSkillMsg.itemInfo. [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:30] XML: AvengerSkillTemplates.NeedItem5';
COMMENT ON COLUMN game.avenger_skills.item5_count IS 'Quantidade do material 5 (10,10,10,10,10,10,15,15,20 nos níveis 1-9; 0 no 10). [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:32] XML: AvengerSkillTemplates.NeedItemNum5';
COMMENT ON COLUMN game.avenger_skills.item6_id IS 'Material 6 para evoluir (Pedra de Julgamento; 0 = sem). Ex.: 5001101 ''Pedra de Julgamento básica - Ataque'' ... 5003406 ''especial''. Slot 6 corresponde ao atributo Penetração. Entregue item a item via op 2 (botão ''Elevar''); progresso em AvengerSkillMsg.itemInfo. [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:34] XML: AvengerSkillTemplates.NeedItem6';
COMMENT ON COLUMN game.avenger_skills.item6_count IS 'Quantidade do material 6 (10,10,10,10,10,10,15,15,20 nos níveis 1-9; 0 no 10). [decompiled/core_module/scripts/yishi/datas/templates/AvengerSkillTempInfo.as:36] XML: AvengerSkillTemplates.NeedItemNum6';
COMMENT ON COLUMN game.avenger_skills.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.avenger_skills.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.avenger_bodies (
  id integer NOT NULL,
  body_type smallint,
  body_grade integer,
  required_item_id integer,
  required_item_count integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  hit_points integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.avenger_bodies IS 'Corpo do Vingador: graus por tipo, custo e atributos. Origem: tempinfos.xml/AvengerBodyTemplates.';
COMMENT ON COLUMN game.avenger_bodies.id IS 'Id = 50000 + BodyGrade (221 linhas, 50000-50220). [decompiled/core_module/scripts/yishi/datas/templates/AvengerBodyTempInfo.as:6] XML: AvengerBodyTemplates.Id';
COMMENT ON COLUMN game.avenger_bodies.body_type IS 'Estágio do Corpo = floor(BodyGrade/11) (0-20); exibido como número grande no AvengerBodyView e muda o efeito visual. Enum: meta.enum_values.enum_name=''avenger_body_type''. [decompiled/m5/scripts/avenger/view/AvengerBodyView.as:199,235-244] XML: AvengerBodyTemplates.BodyType';
COMMENT ON COLUMN game.avenger_bodies.body_grade IS 'Grau do Corpo do Julgamento (0-220), chave única do template (getTemplateByGrade). = AvengerMsg.grade. Estrelas = grade%11; quando (grade+1)%11==0 o botão vira ''evoluir''. [decompiled/core_module/scripts/yishi/datas/templates/cate/AvengerBodyTempCate.as:27] XML: AvengerBodyTemplates.BodyGrade';
COMMENT ON COLUMN game.avenger_bodies.required_item_id IS 'Material de elevação: sempre 5010001 ''Cristal da Vingança''. [decompiled/m5/scripts/avenger/view/AvengerBodyView.as:205-207] XML: AvengerBodyTemplates.NeedItem';
COMMENT ON COLUMN game.avenger_bodies.required_item_count IS 'EXP (cristais) para ir do grau atual ao próximo: 5,10,...,250 (+5 por grau, teto 250 a partir do grau 49). Barra = exp/NeedItemNum. Total 0→220 = 48.875 cristais. [decompiled/m5/scripts/avenger/view/AvengerBodyView.as:213-214] XML: AvengerBodyTemplates.NeedItemNum';
COMMENT ON COLUMN game.avenger_bodies.attack IS 'Ataque Físico concedido = 800*BodyGrade (máx 176.000). Mostrado como ''Ataque''. [decompiled/core_module/scripts/mvc/module/avenger/AvengerModel.as:92] XML: AvengerBodyTemplates.PhyAttack';
COMMENT ON COLUMN game.avenger_bodies.defense IS 'Defesa Física = 800*BodyGrade. Mostrado como ''Defesa''. [decompiled/core_module/scripts/mvc/module/avenger/AvengerModel.as:92] XML: AvengerBodyTemplates.PhyDefence';
COMMENT ON COLUMN game.avenger_bodies.magic_attack IS 'Ataque Mágico = 800*BodyGrade. NÃO é exibido (showPropValueAry omite). [decompiled/core_module/scripts/yishi/datas/templates/AvengerBodyTempInfo.as:31-34] XML: AvengerBodyTemplates.MagAttack';
COMMENT ON COLUMN game.avenger_bodies.magic_defense IS 'Defesa Mágica = 800*BodyGrade. Exibido como ''Resistência'' (AvengerBodyPropItem.propText13). [decompiled/core_module/scripts/mvc/module/avenger/AvengerModel.as:92] XML: AvengerBodyTemplates.MagDefence';
COMMENT ON COLUMN game.avenger_bodies.hit_points IS 'Vida = 4800*BodyGrade (máx 1.056.000). [decompiled/core_module/scripts/mvc/module/avenger/AvengerModel.as:92] XML: AvengerBodyTemplates.Health';
COMMENT ON COLUMN game.avenger_bodies.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.avenger_bodies.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.collections (
  id integer NOT NULL,
  template_id integer,
  name text,
  description text,
  icon text,
  quality smallint,
  star smallint,
  upgrade_gold integer,
  upgrade_need integer[],
  special_effect_id integer,
  special_effect_desc text,
  power integer,
  agility integer,
  intellect integer,
  physique integer,
  parry integer,
  penetration integer,
  leadership integer,
  critical integer,
  tenacity integer,
  troop_capacity integer,
  hit_points integer,
  attack integer,
  defense integer,
  magic_attack integer,
  magic_defense integer,
  fire_resist integer,
  water_resist integer,
  electric_resist integer,
  wind_resist integer,
  dark_resist integer,
  light_resist integer,
  resist_reduction integer,
  resist_reduction_defense integer,
  resist_penetration integer,
  determination integer,
  strength integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.collections IS 'Coleção (álbum de colecionáveis): cada item colecionado em cada estrela concede atributos e efeito especial. Origem: tempinfos.xml/CollectionTemplates.';
COMMENT ON COLUMN game.collections.id IS '= TemplateId*1000 + Star + 1. [decompiled/core_module/scripts/yishi/datas/templates/cate/CollectionTempCate.as:30] XML: CollectionTemplates.Id';
COMMENT ON COLUMN game.collections.template_id IS 'Item coletável (SonType 2002). [decompiled/m5/scripts/theseusCollention/UI/TheseusCollenedRightViewUi.as:354] XML: CollectionTemplates.TemplateId';
COMMENT ON COLUMN game.collections.name IS 'Nome. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:8] XML: CollectionTemplates.CollectionName';
COMMENT ON COLUMN game.collections.description IS 'Igual a Star. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:10] XML: CollectionTemplates.Description';
COMMENT ON COLUMN game.collections.icon IS 'Ícone → icon/collection/{TemplateId}.png. [decompiled/core_module/scripts/yishi/manager/PathManager.as:808] XML: CollectionTemplates.Icon';
COMMENT ON COLUMN game.collections.quality IS 'Qualidade 1..3. Enum: meta.enum_values.enum_name=''collection_quality''. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:14] XML: CollectionTemplates.Quality';
COMMENT ON COLUMN game.collections.star IS 'Estrela 0..10 (linha = stats totais nessa estrela + custo para chegar nela). [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionInfo.as:42] XML: CollectionTemplates.Star';
COMMENT ON COLUMN game.collections.upgrade_gold IS 'Ouro para subir para esta estrela (×1.5 por estrela). [decompiled/m5/scripts/theseusCollention/UI/TheseusCollenedRightViewUi.as:466] XML: CollectionTemplates.UpGold';
COMMENT ON COLUMN game.collections.upgrade_need IS '''itemId,qtd'' para subir de estrela. ''itemId,qtd'' ou ''itemId,qtd|itemId,qtd'' (fragmento TemplateId*1000; 20000000 Metal Divino). [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:125] XML: CollectionTemplates.UpNeed';
COMMENT ON COLUMN game.collections.special_effect_id IS 'Efeito passivo especial (não lido no cliente). [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:22] XML: CollectionTemplates.Specialeffect';
COMMENT ON COLUMN game.collections.special_effect_desc IS '''Nome:valor'' (inativo mostra '':0''). [decompiled/m5/scripts/theseusCollention/UI/TheseusCollenedRightViewUi.as:384] XML: CollectionTemplates.SpecialeffectDesc';
COMMENT ON COLUMN game.collections.power IS 'Força (Power). Atributo fixo (Power) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Power';
COMMENT ON COLUMN game.collections.agility IS 'Proteção (XML Agility: +4 defesa, +4 resistência) (Agility). Atributo fixo (Agility) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Agility';
COMMENT ON COLUMN game.collections.intellect IS 'Inteligência (Intellect). Atributo fixo (Intellect) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Intellect';
COMMENT ON COLUMN game.collections.physique IS 'Físico (constituição) (Physique). Atributo fixo (Physique) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Physique';
COMMENT ON COLUMN game.collections.parry IS 'Bloqueio (aparar) (Parry). Atributo fixo (Parry) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Parry';
COMMENT ON COLUMN game.collections.penetration IS 'Penetração (Penetrate). Atributo fixo (Penetrate) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Penetrate';
COMMENT ON COLUMN game.collections.leadership IS 'Liderança (Captain). Atributo fixo (Captain) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Captain';
COMMENT ON COLUMN game.collections.critical IS 'Crítico (ForceHit). Atributo fixo (ForceHit) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.ForceHit';
COMMENT ON COLUMN game.collections.tenacity IS 'Tenacidade (% = x·100/(x+8000)) (Tenacity). Atributo fixo (Tenacity) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Tenacity';
COMMENT ON COLUMN game.collections.troop_capacity IS 'Infantaria (capacidade de tropa) (Conat). Atributo fixo (Conat) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Conat';
COMMENT ON COLUMN game.collections.hit_points IS 'Vida (HP) (Live). Atributo fixo (Live) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Live';
COMMENT ON COLUMN game.collections.attack IS 'Ataque físico (Attack). Atributo fixo (Attack) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Attack';
COMMENT ON COLUMN game.collections.defense IS 'Defesa física (Defence). Atributo fixo (Defence) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Defence';
COMMENT ON COLUMN game.collections.magic_attack IS 'Ataque mágico (MagicAttack). Atributo fixo (MagicAttack) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.MagicAttack';
COMMENT ON COLUMN game.collections.magic_defense IS 'Defesa mágica (MagicDefence). Atributo fixo (MagicDefence) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.MagicDefence';
COMMENT ON COLUMN game.collections.fire_resist IS 'Resistência a fogo (FireResi). Atributo fixo (FireResi) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.FireResi';
COMMENT ON COLUMN game.collections.water_resist IS 'Resistência a água (WaterResi). Atributo fixo (WaterResi) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.WaterResi';
COMMENT ON COLUMN game.collections.electric_resist IS 'Resistência a eletricidade (ElectResi). Atributo fixo (ElectResi) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.ElectResi';
COMMENT ON COLUMN game.collections.wind_resist IS 'Resistência a vento (WindResi). Atributo fixo (WindResi) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.WindResi';
COMMENT ON COLUMN game.collections.dark_resist IS 'Resistência a trevas (DarkResi). Atributo fixo (DarkResi) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.DarkResi';
COMMENT ON COLUMN game.collections.light_resist IS 'Resistência a luz (LightResi). Atributo fixo (LightResi) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.LightResi';
COMMENT ON COLUMN game.collections.resist_reduction IS 'Redução de resistência (anti-RES) (ReduceResi). Atributo fixo (ReduceResi) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.ReduceResi';
COMMENT ON COLUMN game.collections.resist_reduction_defense IS 'Defesa contra redução de resistência (ReduceResiAgainst). Atributo fixo (ReduceResiAgainst) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.ReduceResiAgainst';
COMMENT ON COLUMN game.collections.resist_penetration IS 'Penetração de resistência (ResiPenetrate). Atributo fixo (ResiPenetrate) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.ResiPenetrate';
COMMENT ON COLUMN game.collections.determination IS 'Determinação/Força Consistente (resistência a atordoamento) (StunAttr). Atributo fixo (StunAttr) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.StunAttr';
COMMENT ON COLUMN game.collections.strength IS 'Intensidade (% = x·100/(x+8000)) (Strength). Atributo fixo (Strength) na estrela; round(Max*(k+1)/11). Só Live/Attack/Defence/MagicAttack/MagicDefence ≠ 0. [decompiled/core_module/scripts/mvc/module/theseus/TheseusCollectionStarInfo.as:36] XML: CollectionTemplates.Strength';
COMMENT ON COLUMN game.collections.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.collections.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.buildings (
  id integer NOT NULL,
  camp smallint,
  name text,
  master_type integer,
  son_type integer,
  grade integer,
  prev_template_id integer,
  next_grade_id integer,
  next_template_ids integer[],
  required_player_grade integer,
  crystals_cost integer,
  gold_cost integer,
  reputation integer,
  upgrade_time integer,
  property1 integer,
  property2 integer,
  property3 integer,
  property4 integer,
  property5 integer,
  property6 integer,
  description text,
  activity_text text,
  icon text,
  pos_x integer,
  pos_y integer,
  title_x integer,
  title_y integer,
  pic_path text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.buildings IS 'Prédios do castelo por nível: custo, tempo, requisitos, produção (Property1..6) e posição na cidade. Origem: tempinfos.xml/BuildingTempInfos.';
COMMENT ON COLUMN game.buildings.id IS 'PK do nível de edifício. Convenção SonType*100+BuildingGrade (ex.: 40201 = Quartel nv.1; 90180 = Prefeitura nv.80; tecnologias SonType*100+grau, ex. 130400 = Produção de Ouro nv.0). 2189 linhas. [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:13] XML: BuildingTempInfos.TemplateId';
COMMENT ON COLUMN game.buildings.camp IS 'Facção/campo do edifício; sempre 1 no BR (constante, sem uso funcional) (suposição). [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:15] XML: BuildingTempInfos.Camp';
COMMENT ON COLUMN game.buildings.name IS 'Nome pt-BR do edifício/tecnologia (32 distintos: Prefeitura, Quartel, Santuário, Transmissor, Labirinto, Residência, Bar da Fantasia, Laboratório de Platina, "Produção de Ouro", "Vida do Soldado Avançado"…). [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:17] XML: BuildingTempInfos.BuildingName';
COMMENT ON COLUMN game.buildings.master_type IS 'Categoria (ver enum building_master_type). Categoria principal (MasterTypes): 4 militar (Quartel), 5 técnico (Santuário/Seminário), 8 transferência (Transmissor), 9 política (Prefeitura), 13 tecnologia interna (ouro), 14 tecnologia militar (atributos), 15 edifícios-portal sem nível (Labirinto, Residência), 16 Bar da Fantasia, 17 Laboratório de Platina. Enum: meta.enum_values.enum_name=''building_master_type''. [decompiled/core_module/scripts/mvc/module/buildings/BuildingModel.as:442] XML: BuildingTempInfos.MasterType';
COMMENT ON COLUMN game.buildings.son_type IS 'Tipo de prédio (BuildingType); recurso mapmaterial/build/<son_type>.swf. Tipo concreto (BuildingType): 402 Quartel, 501 Santuário, 901 Prefeitura, 1304/2304 tecnologia de ouro (básica/avançada), 1420-1424 e 2420-2424 atributos de soldado, 1441-1446 e 2441-2446 atributos de herói, 1507 Labirinto, 1509 Residência, 1511 Transmissor, 1601 Bar da Fantasia, 1701 Lab. Platina. Chave de agrupamento dos níveis. Enum: meta.enum_values.enum_name=''building_type''. [decompiled/core_module/scripts/mvc/module/buildings/BuildingModel.as:399] XML: BuildingTempInfos.SonType';
COMMENT ON COLUMN game.buildings.grade IS 'Nível do edifício/tecnologia (0–80; tecnologias começam em 0 = não pesquisada). Máximo global BUILD_MAX_GRADE=80 (ConfigInfos). [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:21] XML: BuildingTempInfos.BuildingGrade';
COMMENT ON COLUMN game.buildings.prev_template_id IS 'Pré-requisito(s): lista separada por vírgula de BuildingTempInfos.TemplateId que devem existir com grau >= ao indicado. Quartel/Santuário nv.N exigem Prefeitura nv.N (901xx); tecnologia básica nv.N exige Santuário nv.N (501xx); tecnologia avançada nv.N exige Santuário nv.max(50,N). Vazio para Prefeitura. [decompiled/core_module/scripts/mvc/module/buildings/BuildingModel.as:306] XML: BuildingTempInfos.PreTemplateId';
COMMENT ON COLUMN game.buildings.next_grade_id IS 'TemplateId do próximo nível (0 = nível máximo). Usado por isMaxLevel e pelo cálculo de custo do próximo upgrade. [decompiled/core_module/scripts/mvc/module/buildings/BuildingModel.as:399] XML: BuildingTempInfos.NextGradeTemplateId';
COMMENT ON COLUMN game.buildings.next_template_ids IS 'Só no Santuário (501): lista de TemplateIds de tecnologias (nível 0) liberadas ao atingir este nível. Nv.1 libera 130400 (Produção de Ouro), nv.2–12 liberam uma tecnologia militar cada, nv.55 libera as 12 tecnologias avançadas (230400,244500,…). Texto com espaços residuais no XML. [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:27] XML: BuildingTempInfos.NextTemplateId';
COMMENT ON COLUMN game.buildings.required_player_grade IS 'Nível do Líder exigido para subir PARA este nível (checkPlayerGrade usa o do próximo nível). Prefeitura: = BuildingGrade (1–80); demais = 1. [decompiled/core_module/scripts/yishi/manager/BuildingManager.as:419] XML: BuildingTempInfos.PlayerGrades';
COMMENT ON COLUMN game.buildings.crystals_cost IS 'Custo em Cristal de Luz (waterCrystal, item -600) para subir a este nível. Usado só pelas tecnologias: básica 50→32100 (nv.1→80, total 858 850), avançada 250→160500 (total 4 294 250). [decompiled/core_module/scripts/yishi/manager/BuildingManager.as:393] XML: BuildingTempInfos.CrystalsConsume';
COMMENT ON COLUMN game.buildings.gold_cost IS 'Custo em Ouro (-100) para subir a este nível. Quartel 130 (nv.2)→302180 (nv.80); Prefeitura 200→324760 (total 7 235 500); Santuário 10→308460. [decompiled/core_module/scripts/yishi/manager/BuildingManager.as:393] XML: BuildingTempInfos.GoldConsume';
COMMENT ON COLUMN game.buildings.reputation IS 'Reputação exigida (legado do jogo original); sempre 0. [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:31] XML: BuildingTempInfos.Reputation';
COMMENT ON COLUMN game.buildings.upgrade_time IS 'Duração da ordem de construção em segundos que vai para a fila (BuildingOrder.remainTime): 5 s até nv.20, depois 10,20,30,60,120…840 s (nv.21–34), 900 s a partir do nv.35. 0 no nv.1/0. [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:43] XML: BuildingTempInfos.UpgradeTime';
COMMENT ON COLUMN game.buildings.property1 IS 'Valor do efeito. Prefeitura (901): produção de ouro/hora (390 + 525·(nv-1) até nv.60; 31365 + 285·(nv-60) depois; 37 065/h no nv.80). Tecnologias (MasterType 13/14): EffectTempInfos.TemplateId do efeito (ex. 1104 ouro, 1120 vida soldado). Demais: 0. [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:45] XML: BuildingTempInfos.Property1';
COMMENT ON COLUMN game.buildings.property2 IS 'Valor auxiliar. Só o Transmissor (151101) usa: 500 = energia máxima. Em runtime BuildInfo.property2 da Prefeitura = máx. de impostos/dia (servidor). [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:47] XML: BuildingTempInfos.Property2';
COMMENT ON COLUMN game.buildings.property3 IS 'Não usado (sempre 0). [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:49] XML: BuildingTempInfos.Property3';
COMMENT ON COLUMN game.buildings.property4 IS 'Não usado (sempre 0). [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:51] XML: BuildingTempInfos.Property4';
COMMENT ON COLUMN game.buildings.property5 IS 'Não usado (sempre 0). [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:53] XML: BuildingTempInfos.Property5';
COMMENT ON COLUMN game.buildings.property6 IS 'Não usado (sempre 0). [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:55] XML: BuildingTempInfos.Property6';
COMMENT ON COLUMN game.buildings.description IS 'Descrição longa; vazia no BR. [decompiled/core_module/scripts/yishi/datas/templates/BuildingTempInfo.as:57] XML: BuildingTempInfos.Description';
COMMENT ON COLUMN game.buildings.activity_text IS 'Texto do efeito do nível. Texto pt-BR do efeito exibido na janela do edifício e no buff extra (ex. "Produção de Ouro 390/hr", "Vida de Soldados+180"); 1056 distintos. BaseBuildFrame mostra Activity do nível atual e do próximo; ExtraBufferItem faz split("+") para somar bônus. [decompiled/m4/scripts/buildings/BaseBuildFrame.as:199] XML: BuildingTempInfos.Activity';
COMMENT ON COLUMN game.buildings.icon IS 'Ícone do edifício/tecnologia (ex. /icon/building/jh30.png, /science_GOLD.png) via IconFactory.getBuidIconByIcon / getTecIconByIcon. [decompiled/m4/scripts/buildings/seminary/view/TechnologyItem.as:189] XML: BuildingTempInfos.Icon';
COMMENT ON COLUMN game.buildings.pos_x IS 'Posição X (px) do edifício no mapa do castelo (CastleWalkLayer); 0 para tecnologias. [decompiled/m4/scripts/castle/view/layer/CastleWalkLayer.as:149] XML: BuildingTempInfos.PosX';
COMMENT ON COLUMN game.buildings.pos_y IS 'Posição Y (px) do edifício no mapa do castelo. [decompiled/m4/scripts/castle/view/layer/CastleWalkLayer.as:149] XML: BuildingTempInfos.PosY';
COMMENT ON COLUMN game.buildings.title_x IS 'Deslocamento X (px) da placa de nome do edifício. [decompiled/m4/scripts/castle/view/BuildingBase.as:129] XML: BuildingTempInfos.TitleX';
COMMENT ON COLUMN game.buildings.title_y IS 'Deslocamento Y (px) da placa de nome do edifício. [decompiled/m4/scripts/castle/view/BuildingBase.as:129] XML: BuildingTempInfos.TitleY';
COMMENT ON COLUMN game.buildings.pic_path IS '''swf|classe|...'' da vista do prédio. Recurso gráfico "swf|classeView|classeEffect" carregado de RESOURCE_PATH (ex. images/binyin.swf|binyin_view|binyin_effect). [decompiled/m4/scripts/castle/loader/CastleBuildingLoader.as:24] XML: BuildingTempInfos.PicPath';
COMMENT ON COLUMN game.buildings.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.buildings.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.maps (
  id integer NOT NULL,
  campaign_id integer,
  name text,
  map_type smallint,
  min_level integer,
  max_level integer,
  width integer,
  height integer,
  map_file_id integer,
  battle_ground_id integer,
  music text,
  description text,
  sort_index integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.maps IS 'Mapas (mundo, campanhas, instâncias): dimensões, arquivo de mapa, cenário de batalha e música. Origem: tempinfos.xml/MapInfos.';
COMMENT ON COLUMN game.maps.id IS 'ID do mapa (cena andável). 1-5 = mapas do mundo/cidade externa (Pasto Livre, Floresta Nublada, Pântano Sem Fim, Deserto da Morte, Terra do Julgamento), 100 = Costa do Crepúsculo (novato), 10000 = Reino do Céu (mapa espacial/hub), 8001-8430 andares do Labirinto, 40101-43000 baús de Teseu, 41xxx/42xxx instâncias; IDs >100000 são remapeados para 100 no cliente. [decompiled/core_module/scripts/yishi/datas/templates/cate/MaptemplateCate.as:22] XML: MapInfos.Id';
COMMENT ON COLUMN game.maps.campaign_id IS 'Campanha/instância dona do mapa (0 = mapa de mundo/espaço). Vários mapas podem pertencer à mesma campanha (ex.: 8001 Labirinto tem um mapa por andar). 1086 de 1112 linhas apontam para Campaigns existentes. [decompiled/core_module/scripts/map/internals/data/template/MapTemplate.as:10] XML: MapInfos.CampaignId';
COMMENT ON COLUMN game.maps.name IS 'Nome exibido do mapa (pt-BR), ex. "Pasto Livre", "Toca dos Lobos". [decompiled/core_module/scripts/map/internals/data/template/MapTemplate.as:12] XML: MapInfos.MapName';
COMMENT ON COLUMN game.maps.map_type IS 'Tipo de mapa: 0 = mundo/cidade externa (ids 1-5, 100 + alguns eventos), 1 = mapa de campanha/instância (1105 linhas), 5 = mapa espacial "Reino do Céu" (10000). Não há comparação direta no cliente (suposição pelos dados). Enum: meta.enum_values.enum_name=''map_type''. [decompiled/core_module/scripts/map/internals/data/template/MapTemplate.as:14] XML: MapInfos.Type';
COMMENT ON COLUMN game.maps.min_level IS 'Nível mínimo do mapa (0 na maioria; 1 nos mapas de mundo; 8 na Costa do Crepúsculo). [decompiled/core_module/scripts/map/internals/data/template/MapTemplate.as:16] XML: MapInfos.MinLevel';
COMMENT ON COLUMN game.maps.max_level IS 'Nível máximo do mapa (0 = sem limite; 999 nos mapas de mundo; 10 na Costa do Crepúsculo; 50/100 em mapas de evento). [decompiled/core_module/scripts/map/internals/data/template/MapTemplate.as:18] XML: MapInfos.MaxLevel';
COMMENT ON COLUMN game.maps.width IS 'Largura do mapa em pixels (1900 mais comum; mundo = 10000). Usada para montar a grade de tiles de 300 px do BgLayer. [decompiled/m3/scripts/com/road/yishi/bg/BgLayer.as:55] XML: MapInfos.Width';
COMMENT ON COLUMN game.maps.height IS 'Altura do mapa em pixels (1800 mais comum; mundo = 10000). [decompiled/m3/scripts/com/road/yishi/bg/BgLayer.as:55] XML: MapInfos.Height';
COMMENT ON COLUMN game.maps.map_file_id IS 'maps/<id>/<id>.maps e mapmaterial/land/<id>/. ID do pacote gráfico do mapa: tiles em mapmaterial/land/{MapFileId}/tile_{x}_{y}.jpg, dados em maps/{MapFileId}/{MapFileId}.maps|.titles e nome animado images/mapName/{MapFileId}.png. Muitos mapas compartilham o mesmo arquivo (224 distintos). [decompiled/m3/scripts/com/road/yishi/bg/BgLayer.as:361] XML: MapInfos.MapFileId';
COMMENT ON COLUMN game.maps.battle_ground_id IS 'Cenário de batalha sceneIma/<id>/map<id>.swf. ID do cenário de batalha usado quando se luta neste mapa: sceneIma/{BattleGround}/map{BattleGround}.swf; também escolhe a trilha de batalha (BattleGround+1). Valores 1-17 (10 = mais comum). [decompiled/core_module/scripts/battle/transaction/CreateGameTransaction.as:117] XML: MapInfos.BattleGround';
COMMENT ON COLUMN game.maps.music IS 'Música de fundo (ids de som, vários separados por vírgula = sorteio aleatório), ex. "outercity", "BGM0081", "BGM_Space". [decompiled/m3/scripts/map/campaign/view/CampaignMapView.as:172] XML: MapInfos.MusicPath';
COMMENT ON COLUMN game.maps.description IS 'Descrição do mapa (sempre vazia nos dados). [decompiled/core_module/scripts/map/internals/data/template/MapTemplate.as:58] XML: MapInfos.Description';
COMMENT ON COLUMN game.maps.sort_index IS 'Índice/ordem (sempre 0; sem uso no cliente). [decompiled/core_module/scripts/map/internals/data/template/MapTemplate.as:52] XML: MapInfos.Index';
COMMENT ON COLUMN game.maps.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.maps.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.campaigns (
  id integer NOT NULL,
  name text,
  campaign_type integer,
  son_type integer,
  land_id integer,
  dungeon_id integer,
  area_id integer,
  min_level integer,
  max_level integer,
  prev_campaign_id integer,
  next_campaign_id integer,
  capacity integer,
  difficulty smallint,
  description text,
  card_payment integer,
  pos_x integer,
  pos_y integer,
  item_ids integer[],
  stand_seconds integer,
  standard_damage integer,
  standard_hurt integer,
  base_gp integer,
  open_time text,
  stop_time text,
  requires_transfer boolean,
  required_fight_power integer,
  map_ids integer[],
  requires_job_change boolean,
  requires_third_transfer boolean,
  required_transfer_type integer,
  enter_count integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.campaigns IS 'Campanhas/instâncias/eventos de mapa: tipo, faixa de nível, pré-requisitos, horários e recompensa base. Origem: tempinfos.xml/Campaigns.';
COMMENT ON COLUMN game.campaigns.id IS 'ID da campanha/instância/atividade de mapa. Faixas: 1001-1602 campanhas solo (capítulos), 2xxx-3xxx multi, 3001 veículo, 4xxx-8xxx atividades, 31001+ Zona Proibida, 50001+ Vórtice do Tempo/Teseu. [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:9] XML: Campaigns.CampaignId';
COMMENT ON COLUMN game.campaigns.name IS 'Nome pt-BR da campanha (ex. "Toca dos Lobos"). [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:11] XML: Campaigns.CampaignName';
COMMENT ON COLUMN game.campaigns.campaign_type IS 'Categoria da campanha (define em que dicionário/tela entra): 0 PvE normal, 1 Chefão Global, 4 Labirinto, 9 veículo, 13 Roleta da Masmorra, 26 Vórtice do Tempo, 51 Zona Proibida, etc. (ver enum campaign_type). Enum: meta.enum_values.enum_name=''campaign_type''. [decompiled/core_module/scripts/yishi/manager/TempleteManager.as:2580] XML: Campaigns.Types';
COMMENT ON COLUMN game.campaigns.son_type IS 'Subtipo: em Types=0 marca atividades especiais (301 Torre do Julgamento, 303 Molong, 304 Demônio Sanguinário, 305 Formação Mágica, 306 Piso do Tempo, 307 Roleta da Masmorra, 308 Caverna do Ouro Negro, 309 Corrida contra o tempo, 310 Floresta Elemental, 400 instâncias de área especial); em Types=26 é o id do avatar do chefe exibido (2102…2405); 29999 Teseu; 0 = campanha comum. Enum: meta.enum_values.enum_name=''campaign_son_type''. [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:221] XML: Campaigns.SonTypes';
COMMENT ON COLUMN game.campaigns.land_id IS 'Continente/lista na seleção: 1 = aparece na seleção de campanhas (solo/Vórtice), 0 = instâncias multi (abertas via sala PvE) ou atividades. CampaignTemplateManager ignora landId 0 no landList. [decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:56] XML: Campaigns.LandId';
COMMENT ON COLUMN game.campaigns.dungeon_id IS 'Capítulo (CampaignChapterInfo.chapterId) ao qual a área pertence: 1/3/4 capítulos multi/solo, 101-107 capítulos do Vórtice do Tempo, 999 especial. [decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:63] XML: Campaigns.DungeonId';
COMMENT ON COLUMN game.campaigns.area_id IS 'Área (agrupa a mesma instância em dificuldades 1-3); também chave de imagens images/InstanceImg/{AreaId}/*. Especiais: 400 Templo de Tara, 401 Ruínas de Narendra, 402 Corrente Mágica, 403 Santuário da Arma Divina, 404 Batalha dos Guardiões (guerra de crianças), 405 Prisão do Abismo, 406 Abismo de Gelo e Fogo, 308 Rei das Trevas. [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:163] XML: Campaigns.AreaId';
COMMENT ON COLUMN game.campaigns.min_level IS 'Nível mínimo do herói para entrar (ex. Toca dos Lobos 11). [decompiled/m9/scripts/room/view/pve/RoomRightView.as:1288] XML: Campaigns.MinLevel';
COMMENT ON COLUMN game.campaigns.max_level IS 'Nível máximo recomendado/permitido (checado em atividades como Demônio Sanguinário). [decompiled/m9/scripts/room/view/pve/RoomRightView.as:1341] XML: Campaigns.MaxLevel';
COMMENT ON COLUMN game.campaigns.prev_campaign_id IS 'Campanha pré-requisito (0 = já liberada). Estado: rank na pré → liberada (2); sem rank → bloqueada (0). [decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:144] XML: Campaigns.PreCampaignId';
COMMENT ON COLUMN game.campaigns.next_campaign_id IS 'Próxima campanha para pré-carregar mapa (sempre 0 nos dados). [decompiled/core_module/scripts/map/campaign/preload/PreLoadNextCampaign.as:115] XML: Campaigns.NextCampaignId';
COMMENT ON COLUMN game.campaigns.capacity IS 'Máximo de jogadores: 1 = solo, 4 = equipe (instância multi), 10000 = mapa aberto/atividade. Enum: meta.enum_values.enum_name=''campaign_capacity''. [decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1102] XML: Campaigns.Capacity';
COMMENT ON COLUMN game.campaigns.difficulty IS 'Dificuldade: 1 Normal, 2 Pesadelo, 3 Inferno (texto room.instanceRight.difText.text{grade*2}). Enum: meta.enum_values.enum_name=''campaign_difficulty''. [decompiled/m9/scripts/room/view/pve/RoomRightView.as:631] XML: Campaigns.DifficultyGrade';
COMMENT ON COLUMN game.campaigns.description IS 'Descrição curta da atividade (preenchida só em 7 linhas, ex. "Batalhando o Chefão Global receberá Ouro e Espírito"). [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:39] XML: Campaigns.Description';
COMMENT ON COLUMN game.campaigns.card_payment IS 'Preço das cartas pagas pós-campanha (sempre 0; o preço real vem em CampaignCardsMsg.price) (suposição). [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:41] XML: Campaigns.CardPayment';
COMMENT ON COLUMN game.campaigns.pos_x IS 'Posição X do ícone da área no mapa de seleção de campanhas. [decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:122] XML: Campaigns.PosX';
COMMENT ON COLUMN game.campaigns.pos_y IS 'Posição Y do ícone da área no mapa de seleção. [decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:123] XML: Campaigns.PosY';
COMMENT ON COLUMN game.campaigns.item_ids IS 'Lista "," de TemplateIds de itens exibidos como possíveis recompensas/drops (ex. "2129006,2040103"). [decompiled/m9/scripts/room/view/pve/RoomRightView.as:706] XML: Campaigns.Item';
COMMENT ON COLUMN game.campaigns.stand_seconds IS 'Tempo padrão (segundos) para matar o chefe usado na nota do resultado (120/300/600). [decompiled/core_module/scripts/map/internals/view/displaye/CampaignResultView.as:105] XML: Campaigns.StandSecond';
COMMENT ON COLUMN game.campaigns.standard_damage IS 'Multiplicador de dano causado em base 10000 (10000 = 100%) em mapas especiais (Templo das Chamas, Terra do Crepúsculo, Jardim…); 0 = padrão (suposição). [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:53] XML: Campaigns.StandardDamage';
COMMENT ON COLUMN game.campaigns.standard_hurt IS 'Multiplicador de dano recebido em base 10000 (suposição). [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:55] XML: Campaigns.StandardHurt';
COMMENT ON COLUMN game.campaigns.base_gp IS 'Experiência (GP) base da campanha; cresce com o nível (1001: 1100, 1102: 6000) (suposição — usado no servidor). [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:51] XML: Campaigns.BaseGp';
COMMENT ON COLUMN game.campaigns.open_time IS 'Hora de abertura "HH:MM" para atividades com horário (ex. Chefão Global 13:00). [decompiled/m13/scripts/worldboss/view/WorldBossItem.as:119] XML: Campaigns.OpenTime';
COMMENT ON COLUMN game.campaigns.stop_time IS 'Hora de encerramento "HH:MM" (ex. 13:25). [decompiled/m13/scripts/worldboss/view/WorldBossItem.as:119] XML: Campaigns.StopTime';
COMMENT ON COLUMN game.campaigns.requires_transfer IS 'Exige 1º avanço de profissão (vocationGrades > 0). [decompiled/m9/scripts/room/view/pve/RoomRightView.as:1294] XML: Campaigns.NeedTransfer';
COMMENT ON COLUMN game.campaigns.required_fight_power IS 'Poder de combate mínimo exibido para entrada inter-servidor (3000 … 7.000.000). [decompiled/m9/scripts/room/view/pve/RoomRightView.as:703] XML: Campaigns.NeedFightPower';
COMMENT ON COLUMN game.campaigns.map_ids IS 'Para Vórtice do Tempo/Teseu: "heroTemplateId,posição" do chefe (ex. "232001,5") — o nome do chefe vem de GameHeroTemp. [decompiled/m11/scripts/timevortex/TimeVortexChallengeFrame.as:592] XML: Campaigns.MapIds';
COMMENT ON COLUMN game.campaigns.requires_job_change IS 'Exige troca de classe (isChangeJob). [decompiled/m9/scripts/room/view/pve/RoomRightView.as:1300] XML: Campaigns.NeedChangeJob';
COMMENT ON COLUMN game.campaigns.requires_third_transfer IS 'Exige 3º avanço (Vingador, isAvenger). [decompiled/m9/scripts/room/view/pve/RoomRightView.as:1306] XML: Campaigns.NeedThirdTransfer';
COMMENT ON COLUMN game.campaigns.required_transfer_type IS '4 = exige 4º avanço (Sagrado, isHoly); 0 = nenhum. [decompiled/core_module/scripts/yishi/datas/templates/CampaignTemplate.as:295] XML: Campaigns.NeedTransferType';
COMMENT ON COLUMN game.campaigns.enter_count IS 'Número mínimo de jogadores na sala para iniciar (>1 bloqueia início solo); 0/1 = sem mínimo. [decompiled/m9/scripts/room/view/pve/RoomRightView.as:929] XML: Campaigns.EnterNumb';
COMMENT ON COLUMN game.campaigns.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.campaigns.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.map_nodes (
  id integer NOT NULL,
  map_id integer,
  name text,
  master_type integer,
  son_type integer,
  dialogue text,
  grid_x integer,
  grid_y integer,
  back_grid_x integer,
  back_grid_y integer,
  fix_x integer,
  fix_y integer,
  move_to_map_id integer,
  move_to_node_id integer,
  patrol_pos text,
  born_points_raw text,
  name_color integer,
  size_type integer,
  toward integer,
  resource integer,
  handler_range integer,
  param1 integer,
  param2 integer,
  param3 text,
  param4 text,
  param5 text,
  sort_order integer,
  item_exchange text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.map_nodes IS 'Nós do mapa espacial (MapId 10000 ''Reino do Céu'', 9000×6000): NPCs, portais, pilhas de presente, pontos de nascimento. Cada linha vira um SpaceNode (SpaceManager.as:344-386). Origem: tempinfos.xml/MapNodeInfos.';
COMMENT ON COLUMN game.map_nodes.id IS 'ID do nó (NPC/objeto) do mapa espacial; 1-54 NPCs fixos, 30001-30020 pilhas de presentes. Id 14 = ponto de nascimento. [decompiled/core_module/scripts/yishi/datas/templates/SpaceMapNodeInfoTemplate.as:6] XML: MapNodeInfos.Id';
COMMENT ON COLUMN game.map_nodes.map_id IS 'Mapa onde o nó aparece (sempre 10000 = Reino do Céu). [decompiled/core_module/scripts/yishi/datas/templates/SpaceMapNodeInfoTemplate.as:8] XML: MapNodeInfos.MapId';
COMMENT ON COLUMN game.map_nodes.name IS '"Nome,Função" separados por vírgula: parte 0 = nome do NPC, parte 1 = subtítulo/função (funcType). Ex. "Tina, Portal dos Heróis". [decompiled/core_module/scripts/map/space/SpaceManager.as:347] XML: MapNodeInfos.NodeName';
COMMENT ON COLUMN game.map_nodes.master_type IS 'Tipo de nó (40 nascimento, 61 recompensa, 171 portal, 300 pilha de presente...). Tipo do nó físico (info.types): 1 NPC móvel/patrulha, 40 ponto de nascimento, 42 gatilho, 61 NPC de diálogo, 62 transferência, 171 portal para outro mapa, 191 mapa do tesouro, 300-315/410 nós de coleta de evento de Ano Novo (aqui 300 = "Pilha de Presentes"). Enum: meta.enum_values.enum_name=''map_node_type''. [decompiled/core_module/scripts/map/space/SpaceManager.as:353] XML: MapNodeInfos.MasterType';
COMMENT ON COLUMN game.map_nodes.son_type IS 'Subtipo/recurso visual do nó: para Resource=2 é o id do swf de construção mapmaterial/build/{SonType}.swf; para Resource=1 é o avatar do NPC. Ex. 2997, 3000, 10031 (pilha de presentes), 2336 (portal Ilha dos Einherjars). [decompiled/core_module/scripts/map/space/SpaceManager.as:356] XML: MapNodeInfos.SonType';
COMMENT ON COLUMN game.map_nodes.dialogue IS 'Fala do NPC exibida ao abrir o diálogo (pt-BR). [decompiled/core_module/scripts/map/space/SpaceManager.as:373] XML: MapNodeInfos.Dialogue';
COMMENT ON COLUMN game.map_nodes.grid_x IS 'Posição em células de 20 px. Posição X em células da grade (1 célula = 20 px). [decompiled/m3/scripts/map/space/view/layer/SpaceBuildingLayer.as:92] XML: MapNodeInfos.PosX';
COMMENT ON COLUMN game.map_nodes.grid_y IS 'Posição em células de 20 px. Posição Y em células da grade (20 px). [decompiled/m3/scripts/map/space/view/layer/SpaceBuildingLayer.as:93] XML: MapNodeInfos.PosY';
COMMENT ON COLUMN game.map_nodes.back_grid_x IS 'resetPos (sempre 0 nos dados). Posição X de retorno/reset (resetPosX); sempre 0. [decompiled/core_module/scripts/map/space/SpaceManager.as:361] XML: MapNodeInfos.BackPosX';
COMMENT ON COLUMN game.map_nodes.back_grid_y IS 'Posição Y de retorno/reset (resetPosY); sempre 0. [decompiled/core_module/scripts/map/space/SpaceManager.as:362] XML: MapNodeInfos.BackPosY';
COMMENT ON COLUMN game.map_nodes.fix_x IS 'Posição de desenho em px (≈ PosX·20 ± 35). Posição X absoluta em pixels do gráfico (sobrepõe PosX*20 quando FixX e FixY ≠ 0). Ex. 4011. [decompiled/m3/scripts/map/space/view/layer/SpaceBuildingLayer.as:87] XML: MapNodeInfos.FixX';
COMMENT ON COLUMN game.map_nodes.fix_y IS 'Posição de desenho em px. Posição Y absoluta em pixels do gráfico. Ex. 931. [decompiled/m3/scripts/map/space/view/layer/SpaceBuildingLayer.as:88] XML: MapNodeInfos.FixY';
COMMENT ON COLUMN game.map_nodes.move_to_map_id IS 'Portal: mapa de destino. Mapa de destino quando o nó é portal (171): 20001 = Ilha dos Einherjars; 0 = não é portal. [decompiled/core_module/scripts/map/space/SpaceManager.as:365] XML: MapNodeInfos.MoveToMapId';
COMMENT ON COLUMN game.map_nodes.move_to_node_id IS 'Portal: nó de destino. Nó de destino no mapa alvo (ex. 2000101). [decompiled/core_module/scripts/map/space/SpaceManager.as:366] XML: MapNodeInfos.MoveToNodeId';
COMMENT ON COLUMN game.map_nodes.patrol_pos IS 'Rota de patrulha "x,y|x,y" (células) para NPC móvel (tipo 1); vazia nos dados. [decompiled/m3/scripts/stage3drender/WalkLayer.as:296] XML: MapNodeInfos.PatrolPos';
COMMENT ON COLUMN game.map_nodes.born_points_raw IS 'Pontos de nascimento ''gx,gy|gx,gy'' em células de 20 px (ver game.map_points); não lido pelo cliente (provável uso no servidor). Lista de pontos de nascimento "x,y|x,y|..." (células) do nó 40; não existe na classe SpaceMapNodeInfoTemplate — usado só pelo servidor (suposição). XML: MapNodeInfos.BornPoints';
COMMENT ON COLUMN game.map_nodes.name_color IS 'Cor do nome do NPC (índice de paleta; sempre 4). [decompiled/core_module/scripts/map/space/SpaceManager.as:368] XML: MapNodeInfos.NameColor';
COMMENT ON COLUMN game.map_nodes.size_type IS 'Classe de tamanho do avatar (afeta altura do nome; 10 força direção 0). Sempre 0. [decompiled/m3/scripts/map/space/view/physics/SpaceNpcView.as:161] XML: MapNodeInfos.SizeType';
COMMENT ON COLUMN game.map_nodes.toward IS 'Orientação 0 ou 180 (espelho). Direção para a qual o NPC olha, em graus (0 ou 180). [decompiled/m3/scripts/map/space/view/physics/SpaceNpcView.as:162] XML: MapNodeInfos.Toward';
COMMENT ON COLUMN game.map_nodes.resource IS 'Camada/forma de render: 1 = NPC com avatar (camada de NPCs), 2 = objeto/construção estática (camada de construções, swf por SonType). Enum: meta.enum_values.enum_name=''space_node_resource''. [decompiled/m3/scripts/map/space/view/layer/SpaceBuildingLayer.as:77] XML: MapNodeInfos.Resource';
COMMENT ON COLUMN game.map_nodes.handler_range IS 'Raio em losango (células) em que o jogador interage; só células andáveis. Raio de interação em células: o jogador aciona o nó quando a distância ≤ HandlerRange (0, 4 ou 8). [decompiled/core_module/scripts/map/space/SpaceModel.as:391] XML: MapNodeInfos.HandlerRange';
COMMENT ON COLUMN game.map_nodes.param1 IS 'Parâmetro 1: 1 = NPC comum; 2 = PARAM_TRANSFER (nó de transferência); 0 = ponto de nascimento. [decompiled/core_module/scripts/map/space/data/SpaceNodeType.as:18] XML: MapNodeInfos.Param1';
COMMENT ON COLUMN game.map_nodes.param2 IS 'Parâmetro 2 (sempre 0). [decompiled/core_module/scripts/map/space/SpaceManager.as:375] XML: MapNodeInfos.Param2';
COMMENT ON COLUMN game.map_nodes.param3 IS 'Opções do diálogo do NPC: lista "|" de "tipoOpção,título,nívelMín" (ex. "2,Portal dos Heróis,20" abre lista de salas PvE com nível ≥ 20). Os tipos de opção abrem sistemas (ver enum space_npc_option_type). Enum: meta.enum_values.enum_name=''space_npc_option_type''. [decompiled/m3/scripts/map/space/view/frame/SpaceDialogFrame.as:205] XML: MapNodeInfos.Param3';
COMMENT ON COLUMN game.map_nodes.param4 IS 'Parâmetro por opção, alinhado por índice com Param3 ("|"): ex. id de tarefa de história (opção 7) "|1926", ou índice de troca. [decompiled/m3/scripts/map/space/view/frame/SpaceDialogFrame.as:206] XML: MapNodeInfos.Param4';
COMMENT ON COLUMN game.map_nodes.param5 IS 'Falas extras por opção separadas por "$" (cada uma com passos "|") para opção 7 (tarefa de história). [decompiled/m3/scripts/map/space/view/frame/SpaceDialogFrame.as:210] XML: MapNodeInfos.Param5';
COMMENT ON COLUMN game.map_nodes.sort_order IS 'Ordem de exibição na lista de NPCs (0 = usa o Id). [decompiled/core_module/scripts/map/space/SpaceManager.as:380] XML: MapNodeInfos.Sort';
COMMENT ON COLUMN game.map_nodes.item_exchange IS 'Trocas de itens do NPC (opção 107): lista "|" de "itemCusto,qtd#itemRecebido,qtd" — ex. "2126900,5#2060072,2" (5 do item 2126900 → 2 do 2060072). [decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:931] XML: MapNodeInfos.ItemExchange';
COMMENT ON COLUMN game.map_nodes.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.map_nodes.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.crisis_map_nodes (
  id integer NOT NULL,
  map_id integer,
  node_id integer,
  x integer,
  y integer,
  node_type integer,
  linked_node_ids integer[],
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.crisis_map_nodes IS 'Nós do mapa da Crise dos Planos (3 mapas): posição em px, tipo de nó e ligações. Origem: tempinfos.xml/CrisisMapInfos.';
COMMENT ON COLUMN game.crisis_map_nodes.id IS 'ID da linha (105-399); ignorado pelo cliente (chave real = "MapId_NodeId"). XML: CrisisMapInfos.TemplateId';
COMMENT ON COLUMN game.crisis_map_nodes.map_id IS 'Mapa da Crise dos Planos (1, 2, 3). [decompiled/core_module/scripts/yishi/datas/templates/cate/PlaneCrisisTempCate.as:27] XML: CrisisMapInfos.MapId';
COMMENT ON COLUMN game.crisis_map_nodes.node_id IS 'ID do nó dentro do mapa. [decompiled/core_module/scripts/yishi/datas/templates/cate/PlaneCrisisTempCate.as:27] XML: CrisisMapInfos.NodeId';
COMMENT ON COLUMN game.crisis_map_nodes.x IS 'px Posição X em pixels no mapa grande (377-2293). [decompiled/m3/scripts/crisis/ui/item/PlaneCrisisPointItem.as:643] XML: CrisisMapInfos.X';
COMMENT ON COLUMN game.crisis_map_nodes.y IS 'px Posição Y em pixels (220-2094). [decompiled/m3/scripts/crisis/ui/item/PlaneCrisisPointItem.as:644] XML: CrisisMapInfos.Y';
COMMENT ON COLUMN game.crisis_map_nodes.node_type IS 'Tipo do nó: 0 normal, 1 nascimento dos jogadores, 2 nascimento do boss, 10/11/12 nuvem verde/vermelha/amarela (mecanismos). Enum: meta.enum_values.enum_name=''crisis_node_type''. [decompiled/core_module/scripts/mvc/module/crisis/PlaneCrisisNodeType.as:6] XML: CrisisMapInfos.NodeType';
COMMENT ON COLUMN game.crisis_map_nodes.linked_node_ids IS 'Nós ligados (CSV). NodeIds adjacentes separados por "," (grafo simétrico); só se move para nós conectados. [decompiled/core_module/scripts/yishi/datas/templates/PlaneCrisisTempInfo.as:25] XML: CrisisMapInfos.LineNode';
COMMENT ON COLUMN game.crisis_map_nodes.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.crisis_map_nodes.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.outyard_map_nodes (
  id integer NOT NULL,
  map_id integer,
  x integer,
  y integer,
  initial_force integer,
  node_type integer,
  can_occupy boolean,
  linked_node_ids integer[],
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.outyard_map_nodes IS 'Nós do mapa do Quintal (HugeHead/Outyard): posição em px, força inicial, ocupação e ligações. Origem: tempinfos.xml/HugeHeadMapNodeTempInfos.';
COMMENT ON COLUMN game.outyard_map_nodes.id IS 'ID do nó do mapa da Luta da Terralém. [decompiled/core_module/scripts/mvc/module/outyard/LandPoint.as:53] XML: HugeHeadMapNodeTempInfos.NodeTempId';
COMMENT ON COLUMN game.outyard_map_nodes.map_id IS 'Mapa/região (1-4 regiões das facções, 5 centro com cristal). [decompiled/core_module/scripts/mvc/module/outyard/LandPoint.as:77] XML: HugeHeadMapNodeTempInfos.MapId';
COMMENT ON COLUMN game.outyard_map_nodes.x IS 'px Posição X em pixels no mapa. [decompiled/core_module/scripts/mvc/module/outyard/LandPoint.as:82] XML: HugeHeadMapNodeTempInfos.PosX';
COMMENT ON COLUMN game.outyard_map_nodes.y IS 'px Posição Y em pixels no mapa. [decompiled/core_module/scripts/mvc/module/outyard/LandPoint.as:87] XML: HugeHeadMapNodeTempInfos.PosY';
COMMENT ON COLUMN game.outyard_map_nodes.initial_force IS 'Facção dona inicial (1-4; 0 = neutro). [decompiled/core_module/scripts/yishi/datas/templates/OutyardTemplateInfo.as:14] XML: HugeHeadMapNodeTempInfos.InitForce';
COMMENT ON COLUMN game.outyard_map_nodes.node_type IS 'Tipo do nó. Enum: meta.enum_values.enum_name=''huge_head_node_type''. [decompiled/core_module/scripts/mvc/module/outyard/LandPoint.as:92] XML: HugeHeadMapNodeTempInfos.NodeType';
COMMENT ON COLUMN game.outyard_map_nodes.can_occupy IS 'true = pode ser ocupado em batalha (só territórios tipo 2). [decompiled/core_module/scripts/yishi/datas/templates/OutyardTemplateInfo.as:18] XML: HugeHeadMapNodeTempInfos.CanOccupy';
COMMENT ON COLUMN game.outyard_map_nodes.linked_node_ids IS 'IDs de nós vizinhos (arestas) separados por vírgula. [decompiled/core_module/scripts/mvc/module/outyard/LandPoint.as:97] XML: HugeHeadMapNodeTempInfos.NodeLink';
COMMENT ON COLUMN game.outyard_map_nodes.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.outyard_map_nodes.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.castle_building_art (
  row_id serial,
  son_type integer,
  grade integer,
  sort_id integer,
  x integer,
  y integer,
  title_dx integer,
  title_dy integer,
  pic_path text,
  flash_path text,
  depth integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (row_id)
);
COMMENT ON TABLE game.castle_building_art IS 'Arte e posição dos prédios na cidade por tipo e nível (legado): posição, título, imagem, efeito e profundidade. Origem: tempinfos.xml/BuildingResInfos.';
COMMENT ON COLUMN game.castle_building_art.row_id IS 'Chave substituta (a lista de origem não tem id único).';
COMMENT ON COLUMN game.castle_building_art.son_type IS 'SonType do edifício (101 fornalha de cristal, 301 depósito, 402 quartel, 501 santuário, 601, 801 transmissor, 901 prefeitura, 1001, 1101 mercado, 1201 casas) — tabela de arte da versão antiga do castelo; NÃO é lida pelo cliente atual (nenhuma referência no código) (suposição). XML: BuildingResInfos.SonType';
COMMENT ON COLUMN game.castle_building_art.grade IS 'Nível visual do edifício (0–30) a que o sprite se aplica. XML: BuildingResInfos.Grades';
COMMENT ON COLUMN game.castle_building_art.sort_id IS 'Índice da instância quando o edifício tem várias cópias (0–3; só 101 e 1201 têm 4). XML: BuildingResInfos.SortId';
COMMENT ON COLUMN game.castle_building_art.x IS 'px Posição X (px) do sprite no castelo antigo. XML: BuildingResInfos.PosX';
COMMENT ON COLUMN game.castle_building_art.y IS 'px Posição Y (px) do sprite no castelo antigo. XML: BuildingResInfos.PosY';
COMMENT ON COLUMN game.castle_building_art.title_dx IS 'Deslocamento X (px) do nome. XML: BuildingResInfos.TitleX';
COMMENT ON COLUMN game.castle_building_art.title_dy IS 'Deslocamento Y (px) do nome. XML: BuildingResInfos.TitleY';
COMMENT ON COLUMN game.castle_building_art.pic_path IS 'Imagem estática do edifício (ex. images/mjl/cl-rz-mjl-ko15.png; Prefeitura usa swf citywall_15). XML: BuildingResInfos.PicPath';
COMMENT ON COLUMN game.castle_building_art.flash_path IS 'Efeito animado opcional "swf|classe" (ex. images/effect/jh.swf|jh_25). XML: BuildingResInfos.FlashPath';
COMMENT ON COLUMN game.castle_building_art.depth IS 'Ordem de profundidade (z-order) do sprite (0–25). XML: BuildingResInfos.Depth';
COMMENT ON COLUMN game.castle_building_art.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.castle_building_art.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.monster_explore_nodes (
  chapter_id integer NOT NULL,
  chapter_name text,
  node_id integer NOT NULL,
  node_name text,
  x integer,
  y integer,
  chapter_map integer,
  node_map integer,
  fight_map integer,
  music text,
  gold_per_minute integer,
  exp_per_minute integer,
  npc_gold integer,
  npc_exp integer,
  boss_gold integer,
  boss_exp integer,
  boss_drop_id integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (chapter_id, node_id)
);
COMMENT ON TABLE game.monster_explore_nodes IS 'Nós da Exploração de Monstros: capítulo, posição no mapa do capítulo, mapas e ganhos por minuto. Origem: tempinfos.xml/MonsterExploreTemplates.';
COMMENT ON COLUMN game.monster_explore_nodes.chapter_id IS 'Capítulo (1..4) da Exploração de Monstros; PK composta (ChapterId,NodeId). [decompiled/core_module/scripts/yishi/datas/templates/cate/MonsterExploreTemplateCate.as:19] XML: MonsterExploreTemplates.ChapterId';
COMMENT ON COLUMN game.monster_explore_nodes.chapter_name IS 'Nome do capítulo: Pasto Livre, Floresta Nublada, Pântano Sem Fim, Deserto da Morte. [decompiled/core_module/scripts/yishi/datas/templates/MonsterExploreTempInfo.as:8] XML: MonsterExploreTemplates.ChapterName';
COMMENT ON COLUMN game.monster_explore_nodes.node_id IS 'Nó/ponto do mapa (1..40, numeração contínua por capítulo; 35/35/35/40 nós). [decompiled/core_module/scripts/yishi/datas/templates/MonsterExploreTempInfo.as:10] XML: MonsterExploreTemplates.NodeId';
COMMENT ON COLUMN game.monster_explore_nodes.node_name IS 'Nome do nó (ex. "Ninho dos Lobos 1"). [decompiled/core_module/scripts/yishi/datas/templates/MonsterExploreTempInfo.as:12] XML: MonsterExploreTemplates.NodeName';
COMMENT ON COLUMN game.monster_explore_nodes.x IS 'px Posição X (px) do nó no mapa do capítulo; linhas ligam nós em (PosX+25,PosY+25). [decompiled/m14/scripts/monsterexplore/MonsterExploreSelectPassFrame.as:305] XML: MonsterExploreTemplates.PosX';
COMMENT ON COLUMN game.monster_explore_nodes.y IS 'px Posição Y (px) do nó no mapa do capítulo. [decompiled/m14/scripts/monsterexplore/MonsterExploreSelectPassFrame.as:306] XML: MonsterExploreTemplates.PosY';
COMMENT ON COLUMN game.monster_explore_nodes.chapter_map IS 'Mapa do capítulo (101..104): ResourcePath+"swf/singlecampaign1/{id}/map/{id}.swf". [decompiled/m14/scripts/monsterexplore/MonsterExploreSelectPassFrame.as:237] XML: MonsterExploreTemplates.ChapterMapPath';
COMMENT ON COLUMN game.monster_explore_nodes.node_map IS 'Imagem do nó: ResourcePath+"images/InstanceImg/{id}/big.jpg" (ex. 1001). [decompiled/m14/scripts/monsterexplore/view/MonsterExploreNodeDetailView.as:219] XML: MonsterExploreTemplates.NodeMapPath';
COMMENT ON COLUMN game.monster_explore_nodes.fight_map IS 'Fundo da cena de exploração "images/monsterexplore/{id}.jpg" (1,4,5,6,9) e id da música de batalha. [decompiled/m14/scripts/monsterexplore/view/MonsterExploreMapView.as:94] XML: MonsterExploreTemplates.FightMapPath';
COMMENT ON COLUMN game.monster_explore_nodes.music IS 'BGM do nó (ex. BGM101204). Não usado pelo cliente (suposição: servidor/compat). [decompiled/core_module/scripts/yishi/datas/templates/MonsterExploreTempInfo.as:24] XML: MonsterExploreTemplates.MusicPath';
COMMENT ON COLUMN game.monster_explore_nodes.gold_per_minute IS 'Ouro por minuto de exploração offline no nó (10..730). [decompiled/m14/scripts/monsterexplore/MonsterExploreFrame.as:466] XML: MonsterExploreTemplates.MinuteGold';
COMMENT ON COLUMN game.monster_explore_nodes.exp_per_minute IS 'Experiência por minuto no nó (20..1231). [decompiled/m14/scripts/monsterexplore/MonsterExploreFrame.as:467] XML: MonsterExploreTemplates.MinuteExp';
COMMENT ON COLUMN game.monster_explore_nodes.npc_gold IS 'Ouro por monstro comum abatido (5/10/15/20 por capítulo). [decompiled/core_module/scripts/yishi/datas/templates/MonsterExploreTempInfo.as:30] XML: MonsterExploreTemplates.NpcGold';
COMMENT ON COLUMN game.monster_explore_nodes.npc_exp IS 'EXP por monstro comum abatido (5/10/15/20). [decompiled/core_module/scripts/yishi/datas/templates/MonsterExploreTempInfo.as:32] XML: MonsterExploreTemplates.NpcExp';
COMMENT ON COLUMN game.monster_explore_nodes.boss_gold IS 'Ouro ao derrotar o chefe do nó (0 em todas). [decompiled/core_module/scripts/yishi/datas/templates/MonsterExploreTempInfo.as:34] XML: MonsterExploreTemplates.BossGold';
COMMENT ON COLUMN game.monster_explore_nodes.boss_exp IS 'EXP ao derrotar o chefe do nó (0 em todas). [decompiled/core_module/scripts/yishi/datas/templates/MonsterExploreTempInfo.as:36] XML: MonsterExploreTemplates.BossExp';
COMMENT ON COLUMN game.monster_explore_nodes.boss_drop_id IS 'Id do drop do chefe (FK MonsterExploreDrop.DropId), ex. 1740101 = cap.1 nó 1. [decompiled/m14/scripts/monsterexplore/view/MonsterExploreNodeDetailView.as:220] XML: MonsterExploreTemplates.BossDrop';
COMMENT ON COLUMN game.monster_explore_nodes.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.monster_explore_nodes.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.quests (
  id integer NOT NULL,
  quest_type smallint,
  title text,
  detail text,
  objective text,
  required_fight_id integer,
  required_building_id integer,
  required_item_id integer,
  required_pos integer,
  min_level integer,
  max_level integer,
  prev_quest_ids integer[],
  is_guild boolean,
  is_auto boolean,
  is_repeatable boolean,
  is_lost boolean,
  repeat_interval_hours integer,
  repeat_max integer,
  reward_player_gp integer,
  reward_hero_gp integer,
  reward_gold integer,
  reward_crystal integer,
  reward_dower integer,
  reward_money integer,
  reward_guild_offer integer,
  reward_player_offer integer,
  start_date text,
  end_date text,
  week_space text,
  hour_space text,
  reward_strategy integer,
  sort_order numeric,
  show_type smallint,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.quests IS 'Missões: tipo, requisitos, repetição, janela de datas e recompensas em recursos. Origem: tempinfos.xml/QuestTemps.';
COMMENT ON COLUMN game.quests.id IS 'ID da missão (1..1972, 835 linhas). Também é o índice do bit no BitArray de missões concluídas (questSite): bit (id-1). [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:46] XML: QuestTemps.TemplateId';
COMMENT ON COLUMN game.quests.quest_type IS 'Categoria da missão: 0 principal (781), 1 diária (35), 2 evento (14), 3 VIP (3), 4 regresso (2). Enum: meta.enum_values.enum_name=''task_type''. [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:48] XML: QuestTemps.TemplateType';
COMMENT ON COLUMN game.quests.title IS 'Título pt-BR exibido na lista de missões (ex.: "Trilhas de Llane", "Desafio do Coliseu (Diário)"). [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:50] XML: QuestTemps.Title';
COMMENT ON COLUMN game.quests.detail IS 'Texto/história da missão (HTML simples), exibido no painel de descrição. [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:52] XML: QuestTemps.Detail';
COMMENT ON COLUMN game.quests.objective IS 'Objetivo textual; vazio em todas as linhas (não usado). [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:54] XML: QuestTemps.Objective';
COMMENT ON COLUMN game.quests.required_fight_id IS 'Campanha/cena de batalha associada (0 ou 6001 = cena de coleta de recursos do worldBossTemplateDict). Se != 0 o painel mostra botão "Ir à campanha" que chama worldBossControler.sendEnterBattle. [decompiled/m15/scripts/task/TaskFrameII.as:348] XML: QuestTemps.NeedFightId';
COMMENT ON COLUMN game.quests.required_building_id IS 'Construção exigida (BuildingTempInfos.TemplateId) para aceitar; sempre 0. Verificado em chechNeedBuilding. [decompiled/core_module/scripts/yishi/manager/TaskManage.as:527] XML: QuestTemps.NeedBuildingTemp';
COMMENT ON COLUMN game.quests.required_item_id IS 'Item exigido para a missão (ItemTempInfos.TemplateId); só nas missões de teste 1900/1901 (210001/210002). checkNeedGoods existe mas não é chamado. [decompiled/core_module/scripts/yishi/manager/TaskManage.as:546] XML: QuestTemps.NeedItemTemp';
COMMENT ON COLUMN game.quests.required_pos IS 'Posição/cargo exigido (suposição); sempre 0, sem uso no cliente. [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:62] XML: QuestTemps.NeedPos';
COMMENT ON COLUMN game.quests.min_level IS 'Nível mínimo do lorde para aceitar (1..80; 184 missões nível 1, 362 nível 80). Rejeita se thane.grades < NeedMinLevel. [decompiled/core_module/scripts/yishi/manager/TaskManage.as:466] XML: QuestTemps.NeedMinLevel';
COMMENT ON COLUMN game.quests.max_level IS 'Nível máximo para aceitar (padrão 100; 320 nas missões de runa; faixas 25-30...71-75 em Cristal das Trevas da guilda). Rejeita se thane.grades > NeedMaxLevel. [decompiled/core_module/scripts/yishi/manager/TaskManage.as:475] XML: QuestTemps.NeedMaxLevel';
COMMENT ON COLUMN game.quests.prev_quest_ids IS 'Pré-requisitos: lista de TemplateId separados por vírgula (todos devem estar concluídos no BitArray; vazio = nenhum). 652 com 1 id, 47 com 2 ids (ex.: "190,200"), 136 vazios. [decompiled/core_module/scripts/yishi/manager/TaskManage.as:515] XML: QuestTemps.PreQuestId';
COMMENT ON COLUMN game.quests.is_guild IS 'true = exige pertencer a guilda (checkConsortia: consortiaID != 0). 19 missões (ex.: "Contribuição da Guilda 1", "Orar na Guilda"). [decompiled/core_module/scripts/yishi/manager/TaskManage.as:562] XML: QuestTemps.IsLeague';
COMMENT ON COLUMN game.quests.is_auto IS 'true = aceita automaticamente (requestCanAcceptTask envia U_C_QUEST_ADD em lote); false = vai para lista manual e o jogador aceita (12 missões "Caminho do Desafio"/"Coletar Recursos"). [decompiled/core_module/scripts/yishi/manager/TaskManage.as:600] XML: QuestTemps.IsAuto';
COMMENT ON COLUMN game.quests.is_repeatable IS 'true = repetível (pode ser aceita de novo mesmo com bit de concluída). 40 missões (todas as diárias tipo 1). [decompiled/core_module/scripts/yishi/manager/TaskManage.as:418] XML: QuestTemps.IsRepeat';
COMMENT ON COLUMN game.quests.is_lost IS 'Flag de missão perdível/expirável (suposição); sempre false, sem uso no cliente. [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:76] XML: QuestTemps.IsLost';
COMMENT ON COLUMN game.quests.repeat_interval_hours IS 'Intervalo de repetição em horas (sempre 24). Missões manuais reabrem quando floor(hora/RepeatInterval) muda. [decompiled/core_module/scripts/yishi/manager/TaskManage.as:645] XML: QuestTemps.RepeatInterval';
COMMENT ON COLUMN game.quests.repeat_max IS 'Máximo de conclusões por período (1; 100 nas de teste). Bloqueia se repeatFinish >= RepeatMax e a conclusão foi hoje. [decompiled/core_module/scripts/yishi/manager/TaskManage.as:484] XML: QuestTemps.RepeatMax';
COMMENT ON COLUMN game.quests.reward_player_gp IS 'Recompensa de EXP do lorde (ex.: 15000). Para tipo 1 (diária) exibe RewardPlayGP + (nível - NeedMinLevel) * 500. [decompiled/m15/scripts/task/view/TaskRewardViewII.as:225] XML: QuestTemps.RewardPlayGP';
COMMENT ON COLUMN game.quests.reward_hero_gp IS 'EXP de herói (sempre 0, não exibido). [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:84] XML: QuestTemps.RewardHeroGP';
COMMENT ON COLUMN game.quests.reward_gold IS 'Recompensa de ouro (ex.: 2000). [decompiled/m15/scripts/task/view/TaskRewardViewII.as:53] XML: QuestTemps.RewardGold';
COMMENT ON COLUMN game.quests.reward_crystal IS 'Recompensa de cristal (0, 500..100000). [decompiled/m15/scripts/task/view/TaskRewardViewII.as:53] XML: QuestTemps.RewardCrystal';
COMMENT ON COLUMN game.quests.reward_dower IS 'Recompensa de dote/pontos (sempre 0, não exibido) (suposição). [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:90] XML: QuestTemps.RewardDower';
COMMENT ON COLUMN game.quests.reward_money IS 'Recompensa em diamantes/moeda paga (50 só na missão 1 "Evento Diário"); não listado em _rewardList (suposição: diamante). [decompiled/core_module/scripts/mvc/module/task/TaskTemplate.as:92] XML: QuestTemps.RewardMoney';
COMMENT ON COLUMN game.quests.reward_guild_offer IS 'Pontos de contribuição para a guilda (20/40). [decompiled/m15/scripts/task/view/TaskRewardViewII.as:53] XML: QuestTemps.RewardConsortiaOffer';
COMMENT ON COLUMN game.quests.reward_player_offer IS 'Contribuição pessoal de guilda do jogador (10/20/40). [decompiled/m15/scripts/task/view/TaskRewardViewII.as:53] XML: QuestTemps.RewardPlayerOffer';
COMMENT ON COLUMN game.quests.start_date IS 'Início de disponibilidade "YYYY-MM-DD hh:mm:ss"; antes disso a missão não é oferecida (2050-01-01 = desativada, 32 linhas). [decompiled/core_module/scripts/yishi/manager/TaskManage.as:456] XML: QuestTemps.StartDate';
COMMENT ON COLUMN game.quests.end_date IS 'Fim de disponibilidade; após EndDate a missão expira (2000-01-01 = já expirada, 282 linhas; 2050 = permanente). [decompiled/core_module/scripts/yishi/manager/TaskManage.as:445] XML: QuestTemps.EndDate';
COMMENT ON COLUMN game.quests.week_space IS 'Dias da semana em que a missão abre (vazio; checkInWeek retorna sempre false). [decompiled/core_module/scripts/yishi/manager/TaskManage.as:574] XML: QuestTemps.WeekSpace';
COMMENT ON COLUMN game.quests.hour_space IS 'Faixa horária de disponibilidade (vazio; checkInHour retorna sempre false). [decompiled/core_module/scripts/yishi/manager/TaskManage.as:569] XML: QuestTemps.HourSpace';
COMMENT ON COLUMN game.quests.reward_strategy IS 'Recompensa de "estratégia" = EXP de soldados/pontos de estratégia (playerInfo.strategy) (ex.: 50000). [decompiled/m15/scripts/task/view/TaskRewardViewII.as:53] XML: QuestTemps.RewardStrategy';
COMMENT ON COLUMN game.quests.sort_order IS 'Ordem de exibição (float; 2, 111, 1114, 9999...). Lista ordenada por isCompleted e Sort. [decompiled/m15/scripts/task/view/TaskMenuII.as:247] XML: QuestTemps.Sort';
COMMENT ON COLUMN game.quests.show_type IS 'Ícone de tipo no painel (0 = sem ícone; >0 = frame do _taskTypeIcon). Sempre 0. [decompiled/m15/scripts/task/TaskFrameII.as:309] XML: QuestTemps.ShowType';
COMMENT ON COLUMN game.quests.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.quests.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.quest_conditions (
  row_id serial,
  quest_id integer,
  condition_type integer,
  title text,
  param1 text,
  param2 integer,
  param3 integer,
  param4 text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (row_id)
);
COMMENT ON TABLE game.quest_conditions IS 'Condições (objetivos) das missões: tipo de condição e parâmetros. Origem: tempinfos.xml/QuestCondictionInfos.';
COMMENT ON COLUMN game.quest_conditions.row_id IS 'Chave substituta (a lista de origem não tem id único).';
COMMENT ON COLUMN game.quest_conditions.quest_id IS 'Missão dona da condição (até 4 condições por missão = condition_1..4; 828 missões com 1). Linha órfã: 622. [decompiled/core_module/scripts/mvc/module/task/TaskCondictionTemplate.as:6] XML: QuestCondictionInfos.TemplateId';
COMMENT ON COLUMN game.quest_conditions.condition_type IS 'Tipo da condição (145 códigos usados nos dados). Ver enum task_condition_type. Enum: meta.enum_values.enum_name=''task_condition_type''. [decompiled/core_module/scripts/mvc/module/task/TaskCondictionTemplate.as:8] XML: QuestCondictionInfos.CondictionType';
COMMENT ON COLUMN game.quest_conditions.title IS 'Texto do objetivo exibido com progresso "(x / Para2)" (ex.: "Elevar ao Nível 20"). [decompiled/core_module/scripts/mvc/module/task/TaskCondictionTemplate.as:10] XML: QuestCondictionInfos.CondictionTitle';
COMMENT ON COLUMN game.quest_conditions.param1 IS 'Parâmetro 1: sub-alvo conforme o tipo (SonType de construção, MasterType de soldado, CampaignId, ItemTemplateId, ID de nó/chefe, tipo de runa, newbieProcess). [decompiled/core_module/scripts/mvc/module/task/TaskCondictionTemplate.as:12] XML: QuestCondictionInfos.Para1';
COMMENT ON COLUMN game.quest_conditions.param2 IS 'Parâmetro 2: valor-alvo (quantidade, nível, andar). Comparado com condition_N ou com o estado do jogador. [decompiled/core_module/scripts/mvc/module/task/TaskCondictionTemplate.as:14] XML: QuestCondictionInfos.Para2';
COMMENT ON COLUMN game.quest_conditions.param3 IS 'Parâmetro 3: CampaignId usado na navegação (gotoCampaignById) para tipos 13/24-28, ou alvo extra (254 Terra Sombria, 265 parte do conjunto). [decompiled/core_module/scripts/yishi/SwitchPageHelp.as:179] XML: QuestCondictionInfos.Para3';
COMMENT ON COLUMN game.quest_conditions.param4 IS 'Destino de auto-caminhada "mapId,nodeId" (vários separados por "|"); "0" = nenhum. Ex.: "10000,25" (Espaço/cidade), "20001,2000149" (Ilha de Einherjar). [decompiled/core_module/scripts/yishi/SwitchPageHelp.as:115] XML: QuestCondictionInfos.Para4';
COMMENT ON COLUMN game.quest_conditions.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.quest_conditions.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.quest_reward_items (
  row_id serial,
  quest_id integer,
  item_id integer,
  is_selectable boolean,
  count integer,
  job_id smallint,
  valid_days integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (row_id)
);
COMMENT ON TABLE game.quest_reward_items IS 'Itens de recompensa das missões (por classe, opcionalmente selecionáveis). Origem: tempinfos.xml/QuestGoods.';
COMMENT ON COLUMN game.quest_reward_items.row_id IS 'Chave substituta (a lista de origem não tem id único).';
COMMENT ON COLUMN game.quest_reward_items.quest_id IS 'Missão dona do item de recompensa (154 missões, 191 linhas). [decompiled/core_module/scripts/mvc/module/task/TaskGoodsTemplate.as:6] XML: QuestGoods.TemplateId';
COMMENT ON COLUMN game.quest_reward_items.item_id IS 'Item de recompensa (ItemTempInfos.TemplateId; negativos = moeda virtual, ex.: -19000 em 25 linhas). [decompiled/core_module/scripts/mvc/module/task/TaskGoodsTemplate.as:8] XML: QuestGoods.RewardItemID';
COMMENT ON COLUMN game.quest_reward_items.is_selectable IS 'true = item escolhível (o jogador escolhe 1; enviado em QuestFinishedReqMsg.reward_item_id). Sempre false nos dados. [decompiled/core_module/scripts/mvc/module/task/TaskGoodsTemplate.as:10] XML: QuestGoods.IsSelect';
COMMENT ON COLUMN game.quest_reward_items.count IS 'Quantidade do item (1..100000; comum 24, 1, 200). [decompiled/core_module/scripts/mvc/module/task/TaskGoodsTemplate.as:12] XML: QuestGoods.RewardItemCount';
COMMENT ON COLUMN game.quest_reward_items.job_id IS 'Classe que recebe o item (0 = todas; 1/2/3 = classe específica, ex.: missão 1823 dá arma por classe). fitJob(job). [decompiled/core_module/scripts/mvc/module/task/TaskGoodsTemplate.as:23] XML: QuestGoods.ToJob';
COMMENT ON COLUMN game.quest_reward_items.valid_days IS 'Validade do item em dias (0 = permanente); copiado para goodInfo.validDate. [decompiled/m15/scripts/task/view/TaskGoodItemView.as:69] XML: QuestGoods.ValidDate';
COMMENT ON COLUMN game.quest_reward_items.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.quest_reward_items.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.shop_items (
  id integer NOT NULL,
  shop_type integer,
  area integer,
  item_id integer,
  price_point integer,
  price_gift_token integer,
  price_gold integer,
  price_guild_offer integer,
  price_honor integer,
  required_grade integer,
  price_maze_coin integer,
  maze_layers integer,
  maze_layers2 integer,
  required_guild_level integer,
  required_min_vip integer,
  vip0_limit integer,
  vip1_limit integer,
  vip2_limit integer,
  vip3_limit integer,
  vip4_limit integer,
  vip5_limit integer,
  vip6_limit integer,
  first_price integer,
  discount integer,
  price integer,
  sort_order integer,
  is_hot boolean,
  labels integer,
  valid_minutes integer,
  price_geste integer,
  rands integer,
  price_score integer,
  price_lords_score integer,
  required_item_id integer,
  price_mine_score integer,
  min_grade integer,
  max_grade integer,
  price_cross_guild_score integer,
  price_cross_league_medal integer,
  price_poker_score integer,
  sell_max_count integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.shop_items IS 'Itens de lojas (por ShopType/Area): preços em várias moedas, limites por VIP, requisitos e janelas. Origem: tempinfos.xml/ShopTempInfos.';
COMMENT ON COLUMN game.shop_items.id IS 'PK da linha da loja (1..~6e7). Chave do dicionário para a maioria dos tipos (ver ShopGoodsInfoResolve); tipos 2,3,4,5,6,7,8,10,11,35,100 são indexados por ItemId. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:367] XML: ShopTempInfos.Id';
COMMENT ON COLUMN game.shop_items.shop_type IS 'Tipo de loja (43 valores nos dados; ver enum shop_type com contagens). Define dicionário, moeda (PayType) e janela. Enum: meta.enum_values.enum_name=''shop_type''. [decompiled/core_module/scripts/yishi/resolve/ShopGoodsInfoResolve.as:168] XML: ShopTempInfos.ShopType';
COMMENT ON COLUMN game.shop_items.area IS 'Aba/categoria dentro da loja. Loja 1: 2 itens, 4 outros, 6 materiais, 8 troca por Cupom de Retorno, 10 diamante, 12 guardião, 16 herói, 18 einherjar, 52 oculto (fora da busca). Lojas 1027/1031: aba 1-6; loja 1013: nível do pacote (35/50/70/80). Enum: meta.enum_values.enum_name=''shop_main_area''. [decompiled/core_module/scripts/mvc/module/shop/ShopModel.as:240] XML: ShopTempInfos.Area';
COMMENT ON COLUMN game.shop_items.item_id IS 'Item vendido. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:373] XML: ShopTempInfos.ItemId';
COMMENT ON COLUMN game.shop_items.price_point IS 'Preço em diamantes (point). Preço em Diamante (moeda paga, -400). Prioridade 1 em setPrice → PayType 1. Ex.: 1000; 999999999 = não comprável (vitrine, loja 36). [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:528] XML: ShopTempInfos.Point';
COMMENT ON COLUMN game.shop_items.price_gift_token IS 'Preço em diamantes vinculados. Preço em Diamante vinculado (-500). Usado em 346 das 367 linhas da Loja principal (ex. 20, 100, 588) → PayType 2. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:533] XML: ShopTempInfos.GiftToken';
COMMENT ON COLUMN game.shop_items.price_gold IS 'Preço em ouro (só Loja da Fazenda, ex. 500..200000) → PayType 3. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:538] XML: ShopTempInfos.Gold';
COMMENT ON COLUMN game.shop_items.price_guild_offer IS 'Preço em contribuição pessoal da guilda (Loja da Guilda tipo 2; ex. 2..1000) → PayType 4. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:553] XML: ShopTempInfos.ConsortiaOffer';
COMMENT ON COLUMN game.shop_items.price_honor IS 'Preço em Honra (Loja da Arena, tipo 3) → PayType 5. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:543] XML: ShopTempInfos.Honor';
COMMENT ON COLUMN game.shop_items.required_grade IS 'Nível exigido da Fazenda (só ShopType 6; 1..39). Itens até 5 níveis acima aparecem bloqueados. [decompiled/core_module/scripts/mvc/controler/ShopControler.as:492] XML: ShopTempInfos.NeedGrades';
COMMENT ON COLUMN game.shop_items.price_maze_coin IS 'Preço em Moeda do labirinto (ShopType 4; 1..300) → PayType 6. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:558] XML: ShopTempInfos.MazeCoin';
COMMENT ON COLUMN game.shop_items.maze_layers IS 'Andar mínimo do Labirinto/torre 1 (towerInfo1.maxIndex) para comprar (loja 4: 5..30); na loja 1024 = dificuldade do Chefão da Guilda vencida (passLevel); 100 = valor especial (ordenado como topo). [decompiled/m15/scripts/view/GoodsItem.as:606] XML: ShopTempInfos.MazeLayers';
COMMENT ON COLUMN game.shop_items.maze_layers2 IS 'Andar mínimo da torre 2 (towerInfo2.maxIndex); sempre 0 nos dados. [decompiled/m15/scripts/view/GoodsItem.as:610] XML: ShopTempInfos.MazeLayers2';
COMMENT ON COLUMN game.shop_items.required_guild_level IS 'Nível mínimo da Loja da Guilda (shopLevel); itens com NeedConsortiaLevels <= shopLevel+1 aparecem (1..10). Lojas 2 e 17. [decompiled/core_module/scripts/mvc/controler/ShopControler.as:475] XML: ShopTempInfos.NeedConsortiaLevels';
COMMENT ON COLUMN game.shop_items.required_min_vip IS 'VIP mínimo para comprar; sempre 0 nos dados (campo existe no ShopGoodsInfo/proto). [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:399] XML: ShopTempInfos.NeedMinVip';
COMMENT ON COLUMN game.shop_items.vip0_limit IS 'Limite de compra no VIP 0 (-1 = sem limite) Limite diário de compra (OneDayCount). -1 = ilimitado. O cliente usa SOMENTE VIP0Count como limite (canOneCount = VIP0Count - comprados hoje). Ex.: 500, 50, 9999. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:813] XML: ShopTempInfos.VIP0Count';
COMMENT ON COLUMN game.shop_items.vip1_limit IS 'Limite de compra no VIP 1 (-1 = sem limite) Limite diário para VIP1 (-1 = ilimitado). Não usado pelo cliente (só VIP0Count); nos dados = VIP0Count, só difere de -1 em 3 linhas da loja 1034 (3/10/1). Classe também tem VIP7..9Count. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:419] XML: ShopTempInfos.VIP1Count';
COMMENT ON COLUMN game.shop_items.vip2_limit IS 'Limite de compra no VIP 2 (-1 = sem limite) Limite diário para VIP2 (-1 = ilimitado). Não usado pelo cliente (só VIP0Count); nos dados = VIP0Count, só difere de -1 em 3 linhas da loja 1034 (3/10/1). Classe também tem VIP7..9Count. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:421] XML: ShopTempInfos.VIP2Count';
COMMENT ON COLUMN game.shop_items.vip3_limit IS 'Limite de compra no VIP 3 (-1 = sem limite) Limite diário para VIP3 (-1 = ilimitado). Não usado pelo cliente (só VIP0Count); nos dados = VIP0Count, só difere de -1 em 3 linhas da loja 1034 (3/10/1). Classe também tem VIP7..9Count. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:423] XML: ShopTempInfos.VIP3Count';
COMMENT ON COLUMN game.shop_items.vip4_limit IS 'Limite de compra no VIP 4 (-1 = sem limite) Limite diário para VIP4 (-1 = ilimitado). Não usado pelo cliente (só VIP0Count); nos dados = VIP0Count, só difere de -1 em 3 linhas da loja 1034 (3/10/1). Classe também tem VIP7..9Count. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:425] XML: ShopTempInfos.VIP4Count';
COMMENT ON COLUMN game.shop_items.vip5_limit IS 'Limite de compra no VIP 5 (-1 = sem limite) Limite diário para VIP5 (-1 = ilimitado). Não usado pelo cliente (só VIP0Count); nos dados = VIP0Count, só difere de -1 em 3 linhas da loja 1034 (3/10/1). Classe também tem VIP7..9Count. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:427] XML: ShopTempInfos.VIP5Count';
COMMENT ON COLUMN game.shop_items.vip6_limit IS 'Limite de compra no VIP 6 (-1 = sem limite) Limite diário para VIP6 (-1 = ilimitado). Não usado pelo cliente (só VIP0Count); nos dados = VIP0Count, só difere de -1 em 3 linhas da loja 1034 (3/10/1). Classe também tem VIP7..9Count. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:429] XML: ShopTempInfos.VIP6Count';
COMMENT ON COLUMN game.shop_items.first_price IS 'Preço original (riscado) — sempre 0 e sem propriedade em ShopGoodsInfo (ignorado pelo cliente). (suposição) XML: ShopTempInfos.FirstPrice';
COMMENT ON COLUMN game.shop_items.discount IS 'Desconto (%) — sempre 0. Se !=0 o selo Labels não é desenhado. [decompiled/m15/scripts/view/GoodsItem3.as:210] XML: ShopTempInfos.Discount';
COMMENT ON COLUMN game.shop_items.price IS 'Coluna sempre 0; o preço real é calculado em setPrice() a partir das colunas de moeda (ShopGoodsInfo.price é privado/derivado). [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:464] XML: ShopTempInfos.Price';
COMMENT ON COLUMN game.shop_items.sort_order IS 'Ordem de exibição dentro da aba (sortOn(''Sort'') numérico; 207 valores). [decompiled/core_module/scripts/mvc/module/shop/ShopModel.as:266] XML: ShopTempInfos.Sort';
COMMENT ON COLUMN game.shop_items.is_hot IS 'Item em destaque/popular (true/false; 173 true). Usado também pela Loja Misteriosa. [decompiled/core_module/scripts/mvc/controler/MysteryShopControler.as:57] XML: ShopTempInfos.IsHot';
COMMENT ON COLUMN game.shop_items.labels IS 'Selo do item: 1 novo, 2 recomendado, 3 popular. Enum: meta.enum_values.enum_name=''shop_label''. [decompiled/m15/scripts/view/GoodsItem3.as:220] XML: ShopTempInfos.Labels';
COMMENT ON COLUMN game.shop_items.valid_minutes IS 'Validade do item comprado em minutos (0 = permanente; 10080 = 7 dias, 21600 = 15 dias, 43200 = 30 dias). Copiado para GoodsInfo.validDate. [decompiled/m15/scripts/view/GoodsItem.as:1033] XML: ShopTempInfos.ValidDate';
COMMENT ON COLUMN game.shop_items.price_geste IS 'Honra (thane.honer) mínima exigida — título de honra via HonorHelper (lojas 3/1020/1021; ex. 2000). [decompiled/m15/scripts/view/GoodsItem.as:593] XML: ShopTempInfos.NeedGeste';
COMMENT ON COLUMN game.shop_items.rands IS 'Peso/aleatoriedade (sempre 0; recebido no proto). (suposição) [decompiled/core_module/scripts/managers/ShopManager.as:814] XML: ShopTempInfos.Rands';
COMMENT ON COLUMN game.shop_items.price_score IS 'Preço genérico na moeda própria da loja (tipos 8,10,15-20,35,37,38,10xx). Ex.: Pontos da Glória, Medalha da Chama. Moeda definida por ShopType. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:475] XML: ShopTempInfos.Score';
COMMENT ON COLUMN game.shop_items.price_lords_score IS 'Preço em Coração de Ares (loja 10) → PayType 7. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:563] XML: ShopTempInfos.LordsScore';
COMMENT ON COLUMN game.shop_items.required_item_id IS 'Item consumido como moeda (Score = quantidade): 2125048 Cupom de Retorno (loja 1 área 8), 3101071/3101081/3101091 essências (loja 8), 2100038 Cristais de Einherjar (loja 15). [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:474] XML: ShopTempInfos.NeedItem';
COMMENT ON COLUMN game.shop_items.price_mine_score IS 'Preço em Ametista/pontos de mineração (loja 11; 200..15000). [decompiled/core_module/scripts/mvc/controler/ShopControler.as:352] XML: ShopTempInfos.MineScore';
COMMENT ON COLUMN game.shop_items.min_grade IS 'Nível mínimo do herói. Valores 81/161/241 representam etapa de transferência (1ª/2ª/3ª) nas lojas 1023/1024. [decompiled/core_module/scripts/mvc/controler/ShopControler.as:1510] XML: ShopTempInfos.NeedMinGrade';
COMMENT ON COLUMN game.shop_items.max_grade IS 'Nível máximo do herói (0 = sem limite; sempre 0). [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:387] XML: ShopTempInfos.NeedMaxGrade';
COMMENT ON COLUMN game.shop_items.price_cross_guild_score IS 'Preço em pontos do Império/guerra entre servidores (loja 13) → PayType 10. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:573] XML: ShopTempInfos.CrossGuildScore';
COMMENT ON COLUMN game.shop_items.price_cross_league_medal IS 'Preço em Medalha da Liga (loja 14) → PayType 11. [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:586] XML: ShopTempInfos.CrossLeagueMedal';
COMMENT ON COLUMN game.shop_items.price_poker_score IS 'Preço em Pontos de Texas (loja 1003; sempre 0 no XML). [decompiled/core_module/scripts/mvc/module/shop/ShopGoodsInfo.as:601] XML: ShopTempInfos.PokerScore';
COMMENT ON COLUMN game.shop_items.sell_max_count IS 'Limite total/por conta de compra (lojas 1012 =1 e 1013 =3). 0 = sem limite. [decompiled/core_module/scripts/mvc/module/upgradepresent/UpgradePresentInfo.as:94] XML: ShopTempInfos.SellMaxCount';
COMMENT ON COLUMN game.shop_items.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.shop_items.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.guild_levels (
  id integer NOT NULL,
  level_type integer,
  level integer,
  name text,
  prev_template_id integer,
  next_template_ids integer[],
  required_offer integer,
  cooldown_seconds integer,
  property1 integer,
  property2 integer,
  property3 integer,
  icon text,
  description text,
  building_type integer,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (id)
);
COMMENT ON TABLE game.guild_levels IS 'Níveis da guilda (consortia) e de seus prédios/tecnologias por tipo: custo em contribuição, tempo e efeito. Origem: tempinfos.xml/ConsortiaLevelInfos.';
COMMENT ON COLUMN game.guild_levels.id IS 'PK (Types*100+Levels, ex. 101; mestre 4001..; torre 3000..). Também indexado como ''Types_Levels''. [decompiled/core_module/scripts/yishi/resolve/ConsortiaTempInfoResolve.as:16] XML: ConsortiaLevelInfos.TemplateId';
COMMENT ON COLUMN game.guild_levels.level_type IS 'Construção/habilidade (26 tipos). Enum: meta.enum_values.enum_name=''consortia_upgrade_type''. [decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as:8] XML: ConsortiaLevelInfos.Types';
COMMENT ON COLUMN game.guild_levels.level IS 'Nível 0..10 (MAX_LEVEL=10). [decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as:10] XML: ConsortiaLevelInfos.Levels';
COMMENT ON COLUMN game.guild_levels.name IS 'Nome pt-BR da construção/habilidade. [decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as:12] XML: ConsortiaLevelInfos.LevelName';
COMMENT ON COLUMN game.guild_levels.prev_template_id IS 'Pré-requisito (TemplateId de outra construção que precisa estar no nível indicado), ex. Loja Nv2 exige Guilda Nv2 (102). [decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaDevelopView.as:262] XML: ConsortiaLevelInfos.PreTemplateId';
COMMENT ON COLUMN game.guild_levels.next_template_ids IS 'CSV de TemplateIds desbloqueados por este nível (ex. Instituto Nv1 → 601,801,...). [decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as:16] XML: ConsortiaLevelInfos.NextTemplateId';
COMMENT ON COLUMN game.guild_levels.required_offer IS 'Custo do nível: Fortuna da guilda (consortiaInfo.offer) para construções; Fortuna/asset (consortiaAsset) para Types 26-28; contribuição pessoal (consortiaOffer) para aprender habilidades comuns (6-12). Ex. Guilda Nv10 = 90000. [decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaDevelopView.as:294] XML: ConsortiaLevelInfos.NeedOffer';
COMMENT ON COLUMN game.guild_levels.cooldown_seconds IS 'Tempo de construção/cooldown em segundos (ex. 1800 = 30min ... 172800 = 48h). [decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as:20] XML: ConsortiaLevelInfos.CodeTime';
COMMENT ON COLUMN game.guild_levels.property1 IS 'Parâmetro 1: Altar = custo em contribuição por oração (20); Habilidades = id do atributo/efeito (3001..3019); Torre de Mestre = tempo de pesquisa (2520-180*nível; minutos, suposição). [decompiled/m6/scripts/consortia/view/myConsortia/building/ConsortiaAltarView.as:240] XML: ConsortiaLevelInfos.Property1';
COMMENT ON COLUMN game.guild_levels.property2 IS 'Parâmetro 2: Guilda = manutenção semanal (500*nível); Altar = orações/dia (3*nível); habilidades comuns = valor do atributo; avançadas = Mérito/itens 208040 para aprender (200*2^(nível-1)). [decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaSkillSchoolView.as:227] XML: ConsortiaLevelInfos.Property2';
COMMENT ON COLUMN game.guild_levels.property3 IS 'Parâmetro 3 (sempre 0). [decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as:26] XML: ConsortiaLevelInfos.Property3';
COMMENT ON COLUMN game.guild_levels.icon IS 'Ícone relativo a <resource>/icon (ex. /consortia_heroAT.png) via IconFactory.getTecIconByIcon. [decompiled/m6/scripts/consortia/view/myConsortia/skill/ConsortiaSkillItem.as:234] XML: ConsortiaLevelInfos.Icon';
COMMENT ON COLUMN game.guild_levels.description IS 'Descrição pt-BR do efeito do nível. [decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaDevelopView.as:211] XML: ConsortiaLevelInfos.Description';
COMMENT ON COLUMN game.guild_levels.building_type IS 'Categoria (1 salão, 2 construção, 3 habilidade, 4 construção nova, 5 mestre). Enum: meta.enum_values.enum_name=''consortia_building_category''. [decompiled/core_module/scripts/mvc/module/consortia/ConsortiaTemplete.as:32] XML: ConsortiaLevelInfos.BuildingType';
COMMENT ON COLUMN game.guild_levels.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.guild_levels.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

CREATE TABLE game.config_entries (
  row_id serial,
  name text,
  value text,
  description text,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE,
  source_ref text NOT NULL,
  PRIMARY KEY (row_id)
);
COMMENT ON TABLE game.config_entries IS 'Configuração global do servidor/cliente (chave → valor), ex.: limites, custos, liberações. Origem: tempinfos.xml/ConfigInfos.';
COMMENT ON COLUMN game.config_entries.row_id IS 'Chave substituta (a lista de origem não tem id único).';
COMMENT ON COLUMN game.config_entries.name IS 'Chave (há 7 chaves repetidas no XML; vale a última no cliente). Chave de configuração global (983 distintas em 990 linhas; duplicadas: Inlay_JoinOpen, Altar_RewardCount×6, alliance_returnplayer_grade). Lida por TempleteManager.getConfigInfoByConfigName(nome) (dicionário: a última duplicada vence). [decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1476] XML: ConfigInfos.ConfigName';
COMMENT ON COLUMN game.config_entries.value IS 'Valor em texto; formatos: número, lista "a,b,c", pares "a,b|c,d", horários "HH:MM,HH:MM", datas "YYYY-MM-DD hh:mm:ss", ou HTML. O cliente faz split conforme a chave (ex. Quick_Cool "1,10" = 1 diamante/10 min). [decompiled/core_module/scripts/ui/queuebar/view/QueueItem.as:192] XML: ConfigInfos.ConfigValue';
COMMENT ON COLUMN game.config_entries.description IS 'Descrição (zh). Comentário original em chinês (frequentemente com tag de sistema 【…】), útil para classificar a chave. [decompiled/core_module/scripts/yishi/datas/templates/ConfigInfosTempInfo.as:10] XML: ConfigInfos.Description';
COMMENT ON COLUMN game.config_entries.source_record_id IS 'Registro bruto de origem em raw.template_records.';
COMMENT ON COLUMN game.config_entries.source_ref IS 'Proveniência: tempinfos.xml#<Lista>[<ordinal>].';

ALTER TABLE game.hero_ais ADD CONSTRAINT hero_ais_crazy_skill_id_fkey FOREIGN KEY (crazy_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.hero_ais ADD CONSTRAINT hero_ais_bottom_skill_id_fkey FOREIGN KEY (bottom_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.hero_ais ADD CONSTRAINT hero_ais_dead_skill_id_fkey FOREIGN KEY (dead_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.hero_ais ADD CONSTRAINT hero_ais_angry_skill_id_fkey FOREIGN KEY (angry_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.hero_ais ADD CONSTRAINT hero_ais_awaken_skill_id_fkey FOREIGN KEY (awaken_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.pawns ADD CONSTRAINT pawns_required_building_id_fkey FOREIGN KEY (required_building_id) REFERENCES game.buildings(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.pawns ADD CONSTRAINT pawns_default_skill_id_fkey FOREIGN KEY (default_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.pawns ADD CONSTRAINT pawns_ai_id_fkey FOREIGN KEY (ai_id) REFERENCES game.hero_ais(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.heroes ADD CONSTRAINT heroes_job_id_fkey FOREIGN KEY (job_id) REFERENCES game.jobs(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.heroes ADD CONSTRAINT heroes_sex_id_fkey FOREIGN KEY (sex_id) REFERENCES game.sexes(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.heroes ADD CONSTRAINT heroes_ai_id_fkey FOREIGN KEY (ai_id) REFERENCES game.hero_ais(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.heroes ADD CONSTRAINT heroes_default_skill_id_fkey FOREIGN KEY (default_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.monsters ADD CONSTRAINT monsters_property_id_fkey FOREIGN KEY (property_id) REFERENCES game.stat_bonus_profiles(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.monsters ADD CONSTRAINT monsters_default_skill_id_fkey FOREIGN KEY (default_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.action_frames ADD CONSTRAINT action_frames_action_id_fkey FOREIGN KEY (action_id) REFERENCES game.actions(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.action_frames ADD CONSTRAINT action_frames_sex_id_fkey FOREIGN KEY (sex_id) REFERENCES game.sexes(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.skills ADD CONSTRAINT skills_action_id_fkey FOREIGN KEY (action_id) REFERENCES game.actions(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.skills ADD CONSTRAINT skills_upgrade_item_id_fkey FOREIGN KEY (upgrade_item_id) REFERENCES game.items(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.items ADD CONSTRAINT items_sex_id_fkey FOREIGN KEY (sex_id) REFERENCES game.sexes(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.items ADD CONSTRAINT items_suite_id_fkey FOREIGN KEY (suite_id) REFERENCES game.item_suites(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.item_compose_recipes ADD CONSTRAINT item_compose_recipes_result_item_id_fkey FOREIGN KEY (result_item_id) REFERENCES game.items(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.mounts ADD CONSTRAINT mounts_required_item_id_fkey FOREIGN KEY (required_item_id) REFERENCES game.items(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.pets ADD CONSTRAINT pets_default_skill_id_fkey FOREIGN KEY (default_skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.goddesses ADD CONSTRAINT goddesses_required_item_id_fkey FOREIGN KEY (required_item_id) REFERENCES game.items(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.goddess_steps ADD CONSTRAINT goddess_steps_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.vehicles ADD CONSTRAINT vehicles_genius_skill_id_fkey FOREIGN KEY (genius_skill_id) REFERENCES game.vehicle_skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.vehicles ADD CONSTRAINT vehicles_normal_skill_id_fkey FOREIGN KEY (normal_skill_id) REFERENCES game.vehicle_skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.runes ADD CONSTRAINT runes_job_id_fkey FOREIGN KEY (job_id) REFERENCES game.jobs(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.runes ADD CONSTRAINT runes_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.magic_cards ADD CONSTRAINT magic_cards_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.magic_cards ADD CONSTRAINT magic_cards_activation_item_id_fkey FOREIGN KEY (activation_item_id) REFERENCES game.items(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.artifacts ADD CONSTRAINT artifacts_required_item_id_fkey FOREIGN KEY (required_item_id) REFERENCES game.items(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.artifacts ADD CONSTRAINT artifacts_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.appellations ADD CONSTRAINT appellations_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES game.skills(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.avenger_skills ADD CONSTRAINT avenger_skills_job_id_fkey FOREIGN KEY (job_id) REFERENCES game.jobs(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.map_nodes ADD CONSTRAINT map_nodes_map_id_fkey FOREIGN KEY (map_id) REFERENCES game.maps(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.quest_conditions ADD CONSTRAINT quest_conditions_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES game.quests(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.quest_reward_items ADD CONSTRAINT quest_reward_items_quest_id_fkey FOREIGN KEY (quest_id) REFERENCES game.quests(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.quest_reward_items ADD CONSTRAINT quest_reward_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES game.items(id) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE game.shop_items ADD CONSTRAINT shop_items_item_id_fkey FOREIGN KEY (item_id) REFERENCES game.items(id) DEFERRABLE INITIALLY DEFERRED;

CREATE INDEX ON game.action_frames (action_id);
CREATE INDEX ON game.action_frames (sex_id);
CREATE INDEX ON game.appellations (skill_id);
CREATE INDEX ON game.artifacts (required_item_id);
CREATE INDEX ON game.artifacts (skill_id);
CREATE INDEX ON game.artifacts (son_type);
CREATE INDEX ON game.avenger_skills (job_id);
CREATE INDEX ON game.buildings (master_type);
CREATE INDEX ON game.buildings (son_type);
CREATE INDEX ON game.campaigns (son_type);
CREATE INDEX ON game.castle_building_art (son_type);
CREATE INDEX ON game.children (master_type);
CREATE INDEX ON game.goddess_steps (skill_id);
CREATE INDEX ON game.goddesses (required_item_id);
CREATE INDEX ON game.hero_ais (angry_skill_id);
CREATE INDEX ON game.hero_ais (awaken_skill_id);
CREATE INDEX ON game.hero_ais (bottom_skill_id);
CREATE INDEX ON game.hero_ais (crazy_skill_id);
CREATE INDEX ON game.hero_ais (dead_skill_id);
CREATE INDEX ON game.heroes (ai_id);
CREATE INDEX ON game.heroes (default_skill_id);
CREATE INDEX ON game.heroes (job_id);
CREATE INDEX ON game.heroes (sex_id);
CREATE INDEX ON game.item_compose_recipes (result_item_id);
CREATE INDEX ON game.items (master_type);
CREATE INDEX ON game.items (sex_id);
CREATE INDEX ON game.items (son_type);
CREATE INDEX ON game.items (suite_id);
CREATE INDEX ON game.magic_cards (activation_item_id);
CREATE INDEX ON game.magic_cards (skill_id);
CREATE INDEX ON game.map_nodes (map_id);
CREATE INDEX ON game.map_nodes (master_type);
CREATE INDEX ON game.map_nodes (son_type);
CREATE INDEX ON game.monsters (default_skill_id);
CREATE INDEX ON game.monsters (property_id);
CREATE INDEX ON game.mounts (required_item_id);
CREATE INDEX ON game.pawns (ai_id);
CREATE INDEX ON game.pawns (default_skill_id);
CREATE INDEX ON game.pawns (master_type);
CREATE INDEX ON game.pawns (required_building_id);
CREATE INDEX ON game.pawns (son_type);
CREATE INDEX ON game.pets (default_skill_id);
CREATE INDEX ON game.pets (son_type);
CREATE INDEX ON game.quest_conditions (quest_id);
CREATE INDEX ON game.quest_reward_items (item_id);
CREATE INDEX ON game.quest_reward_items (quest_id);
CREATE INDEX ON game.runes (job_id);
CREATE INDEX ON game.runes (skill_id);
CREATE INDEX ON game.runes (son_type);
CREATE INDEX ON game.shop_items (item_id);
CREATE INDEX ON game.skills (action_id);
CREATE INDEX ON game.skills (master_type);
CREATE INDEX ON game.skills (son_type);
CREATE INDEX ON game.skills (upgrade_item_id);
CREATE INDEX ON game.stars (master_type);
CREATE INDEX ON game.stars (son_type);
CREATE INDEX ON game.vehicles (genius_skill_id);
CREATE INDEX ON game.vehicles (normal_skill_id);
CREATE INDEX ON game.war_souls (son_type);

INSERT INTO meta.schema_migrations(version, description) VALUES ('0005', 'game template tables (generated)') ON CONFLICT DO NOTHING;
