SET search_path = game, client, raw, meta, public;

CREATE TABLE game.scenes (
  scene_type        text PRIMARY KEY,
  scene_type_id     smallint,
  name_pt           text NOT NULL,
  class_name        text,
  class_module      text,
  class_source_ref  text,
  project_png       text,
  ui_resources      text[] NOT NULL DEFAULT '{}',
  client_state      smallint,
  enter_castle_flag boolean,
  map_ids           integer[] NOT NULL DEFAULT '{}',
  map_rule          text,
  layers            text[] NOT NULL DEFAULT '{}',
  entities          text,
  requirements      text,
  enter_summary     text,
  exit_summary      text,
  is_hub            boolean NOT NULL DEFAULT false,
  is_room           boolean NOT NULL DEFAULT false,
  is_dead_code      boolean NOT NULL DEFAULT false,
  source_ref        text NOT NULL
);
COMMENT ON TABLE  game.scenes IS 'Cenas do cliente (constantes de yishi.scene.SceneType). Cada cena é uma BaseSceneView criada por SceneCreate.create e trocada por SceneManager.setScene. Ver docs/WORLD.md §1.';
COMMENT ON COLUMN game.scenes.scene_type IS 'Constante SceneType (string usada em SceneManager.setScene), ex. SPACE_SCENE. [decompiled/core_module/scripts/yishi/scene/SceneType.as:6-78]';
COMMENT ON COLUMN game.scenes.scene_type_id IS 'Id numérico de SceneType.getSceneTypeById (usado pelo tutorial: NewbieBaseActionMediator.sendEnterScene); NULL = sem id. Id desconhecido cai em SPACE_SCENE. [SceneType.as:85-133]';
COMMENT ON COLUMN game.scenes.name_pt IS 'Nome da cena em pt-BR (nome do jogo quando existe, ex. "Reino do Céu").';
COMMENT ON COLUMN game.scenes.class_name IS 'Classe AS3 da cena (SceneCreate.getClassByType ou create). [SceneCreate.as:41-132]';
COMMENT ON COLUMN game.scenes.class_module IS 'Pasta de decompiled/ onde a classe está (core_module = 2.png; mN = N.png).';
COMMENT ON COLUMN game.scenes.class_source_ref IS 'Arquivo:linha da classe (getter SceneName).';
COMMENT ON COLUMN game.scenes.project_png IS 'Módulo de código carregado antes de criar a cena (SceneCreate.getProjectUrlByState); NULL = já no núcleo. [SceneCreate.as:134-186]';
COMMENT ON COLUMN game.scenes.ui_resources IS 'Pacotes de UI (ComponentSetting.getUISourcePath) de SceneCreate.getSceneResources; entradas "nome?condição" são condicionais. [SceneCreate.as:292-527]';
COMMENT ON COLUMN game.scenes.client_state IS 'Valor de ClientStateType enviado em 5035 U_PLAYER_CLIENT_STATE (LoginStateMsg.state) a cada setScene; NULL = não envia. 0 castelo, 2 sala PvE, 3 mapa-múndi, 4 campanha, 5 batalha, 6 sala PvP. [yishi/datas/consant/ClientStateType.as:25-44, SceneManager.as:329-336]';
COMMENT ON COLUMN game.scenes.enter_castle_flag IS 'setScene envia 8747 C_ENTER_CASTLE (PropertyMsg.param7) antes de trocar: true = CASTLE_SCENE/FARM, false = SPACE_SCENE; NULL = não envia. [SceneManager.as:169-181]';
COMMENT ON COLUMN game.scenes.map_ids IS 'Ids de MapInfos fixos da cena (ex. 10000 Reino do Céu, 1-5 mundos da cidade externa). Vazio quando o mapa vem do servidor.';
COMMENT ON COLUMN game.scenes.map_rule IS 'Como o mapa da cena é escolhido (texto).';
COMMENT ON COLUMN game.scenes.layers IS 'Camadas de exibição da cena, de baixo para cima.';
COMMENT ON COLUMN game.scenes.entities IS 'Entidades da cena: NPCs, portais, prédios, exércitos.';
COMMENT ON COLUMN game.scenes.requirements IS 'Requisitos para entrar (nível, newbieProcess, estado do jogador).';
COMMENT ON COLUMN game.scenes.enter_summary IS 'Como se entra (gatilho → opcode → setScene).';
COMMENT ON COLUMN game.scenes.exit_summary IS 'Como se sai.';
COMMENT ON COLUMN game.scenes.is_hub IS 'Cena-base para onde o jogo volta (CASTLE_SCENE, SPACE_SCENE: SwitchPageHelp.returnScene).';
COMMENT ON COLUMN game.scenes.is_room IS 'Cena de sala de espera multiplayer (salas criadas por 12 U_C_CAMPAIGN_ROOM_CREATE).';
COMMENT ON COLUMN game.scenes.is_dead_code IS 'Cena declarada mas sem chamada de setScene no cliente BR (ex. FARM, TRAINER_SCENE).';
COMMENT ON COLUMN game.scenes.source_ref IS 'Referências principais (arquivo:linha, relativas a decompiled/).';

CREATE TABLE game.scene_transitions (
  id               serial PRIMARY KEY,
  from_scene       text REFERENCES game.scenes(scene_type) ON DELETE CASCADE,
  to_scene         text NOT NULL REFERENCES game.scenes(scene_type) ON DELETE CASCADE,
  trigger_pt       text NOT NULL,
  opcode_direction text CHECK (opcode_direction IN ('send', 'accept')),
  opcode           integer,
  opcode_name      text,
  proto_message    text,
  condition_pt     text,
  source_ref       text NOT NULL
);
COMMENT ON TABLE  game.scene_transitions IS 'Transições cena A → cena B: o que dispara, opcode envolvido (pedido do cliente ou resposta do servidor que chama setScene) e condição. from_scene NULL = de qualquer cena / login. Ver docs/WORLD.md §1.2.';
COMMENT ON COLUMN game.scene_transitions.from_scene IS 'Cena de origem (NULL = qualquer cena ou login).';
COMMENT ON COLUMN game.scene_transitions.to_scene IS 'Cena de destino.';
COMMENT ON COLUMN game.scene_transitions.trigger_pt IS 'Gatilho (botão, NPC, resposta do servidor, fim de batalha...).';
COMMENT ON COLUMN game.scene_transitions.opcode_direction IS 'send = pedido do cliente; accept = mensagem do servidor que efetiva a troca.';
COMMENT ON COLUMN game.scene_transitions.opcode IS 'Código do pacote (protocol/opcodes.csv).';
COMMENT ON COLUMN game.scene_transitions.opcode_name IS 'Nome do opcode.';
COMMENT ON COLUMN game.scene_transitions.proto_message IS 'Mensagem protobuf do pacote.';
COMMENT ON COLUMN game.scene_transitions.condition_pt IS 'Condição verificada pelo cliente (nível, estado, flags).';
COMMENT ON COLUMN game.scene_transitions.source_ref IS 'Arquivo:linha.';

CREATE TABLE game.worlds (
  map_id       integer PRIMARY KEY,
  world_kind   text NOT NULL CHECK (world_kind IN ('outer_city_world', 'space_hub', 'floor_chain', 'novice', 'dungeon_floor', 'event_map')),
  name_pt      text,
  scene_type   text REFERENCES game.scenes(scene_type),
  width_px     integer,
  height_px    integer,
  tile_px      integer,
  tile_grid    text,
  coord_unit   text,
  map_file_id  integer,
  campaign_id  integer,
  min_level    integer,
  notes        text,
  source_ref   text NOT NULL
);
COMMENT ON TABLE  game.worlds IS 'Mapas que formam o "mundo" navegável: os 5 mundos da cidade externa (1-5), o Reino do Céu (10000), os andares da Ilha de Einherjar (20001-20004), os mapas do tutorial e os andares de dungeons com portal. Cruza com game.maps (MapInfos). Ver docs/WORLD.md §2.';
COMMENT ON COLUMN game.worlds.map_id IS 'MapInfos.Id (game.maps.id).';
COMMENT ON COLUMN game.worlds.world_kind IS 'outer_city_world = mundo 10000×10000 da cidade externa; space_hub = Reino do Céu; floor_chain = andar ligado por CrossMapSearchActionQueue; novice = tutorial; dungeon_floor = andar de instância com portal de editor; event_map = mapa de atividade.';
COMMENT ON COLUMN game.worlds.name_pt IS 'Nome pt-BR (MapInfos.Name).';
COMMENT ON COLUMN game.worlds.scene_type IS 'Cena que exibe o mapa.';
COMMENT ON COLUMN game.worlds.width_px IS 'Largura (MapInfos.Width).';
COMMENT ON COLUMN game.worlds.height_px IS 'Altura (MapInfos.Height).';
COMMENT ON COLUMN game.worlds.tile_px IS 'Lado do tile de fundo em px (512 nos mundos 1-5, 300 em BgLayer).';
COMMENT ON COLUMN game.worlds.tile_grid IS 'Grade de tiles (ex. "20x20").';
COMMENT ON COLUMN game.worlds.coord_unit IS 'Unidade das posições do protocolo neste mapa (célula de 20 px, px...).';
COMMENT ON COLUMN game.worlds.map_file_id IS 'MapInfos.MapFileId (pasta maps/<id> e mapmaterial/land/<id>).';
COMMENT ON COLUMN game.worlds.campaign_id IS 'MapInfos.CampaignId (0 = mapa de mundo/espaço).';
COMMENT ON COLUMN game.worlds.min_level IS 'Nível mínimo para entrar (cliente).';
COMMENT ON COLUMN game.worlds.notes IS 'Observações.';
COMMENT ON COLUMN game.worlds.source_ref IS 'Arquivo:linha.';

CREATE TABLE game.world_links (
  id           serial PRIMARY KEY,
  from_map_id  integer NOT NULL,
  to_map_id    integer NOT NULL,
  via_node_id  bigint,
  link_kind    text NOT NULL CHECK (link_kind IN ('space_portal', 'cross_map_route', 'editor_portal', 'editor_exit', 'scene_switch', 'server_transfer')),
  direction    text NOT NULL DEFAULT 'one_way' CHECK (direction IN ('one_way', 'both')),
  condition_pt text,
  source_ref   text NOT NULL
);
COMMENT ON TABLE  game.world_links IS 'Arestas do grafo de mundos: portais do Reino do Céu (MapNodeInfos tipo 171), rota fixa do CrossMapSearchActionQueue (10000 ↔ 20001-20004), portais de editor nos .maps (tipo 62 + moveToNodeIds), saídas (tipo 41) e trocas por cena/servidor. Ver docs/WORLD.md §2.';
COMMENT ON COLUMN game.world_links.from_map_id IS 'Mapa de origem (MapInfos.Id).';
COMMENT ON COLUMN game.world_links.to_map_id IS 'Mapa de destino (MapInfos.Id; 0 = volta ao hub/returnScene).';
COMMENT ON COLUMN game.world_links.via_node_id IS 'Nó atravessado (id de MapNodeInfos, campDataId ou id de nó do editor).';
COMMENT ON COLUMN game.world_links.link_kind IS 'space_portal = nó 171 do Reino do Céu; cross_map_route = tabela map1/map2 de CrossMapSearchActionQueue; editor_portal = nó 62 do .maps com moveToNodeIds; editor_exit = nó 41 "退出副本"; scene_switch = botão/setScene; server_transfer = servidor recria a campanha (125 RoomCreatedMsg.created_type=3).';
COMMENT ON COLUMN game.world_links.direction IS 'one_way ou both.';
COMMENT ON COLUMN game.world_links.condition_pt IS 'Condição (nível, item, estado).';
COMMENT ON COLUMN game.world_links.source_ref IS 'Arquivo:linha.';

CREATE TABLE game.campaign_nodes (
  row_id           serial PRIMARY KEY,
  map_file_id      integer NOT NULL REFERENCES game.map_files(map_file_id) ON DELETE CASCADE,
  ordinal          integer NOT NULL,
  node_id          bigint,
  item_type        integer NOT NULL,
  item_type_name   text,
  name_zh          text,
  x_px             integer,
  y_px             integer,
  cell_x           integer,
  cell_y           integer,
  start_cells      text,
  next_node_ids    bigint[] NOT NULL DEFAULT '{}',
  move_to_node_ids bigint[] NOT NULL DEFAULT '{}',
  patrol_cells     text,
  battle_type      integer,
  ai_class         text,
  exist_hero       boolean NOT NULL DEFAULT false,
  exist_pawn       boolean NOT NULL DEFAULT false,
  hero             jsonb,
  pawns            jsonb,
  handler_range    integer,
  toward           integer,
  attack_types     integer,
  is_repeat        boolean,
  node_state       integer,
  name_color       integer,
  resource         integer,
  params           jsonb,
  property3        integer,
  property4        integer,
  building_url     text,
  raw              jsonb NOT NULL,
  UNIQUE (map_file_id, ordinal)
);
COMMENT ON TABLE  game.campaign_nodes IS 'Nós de editor embutidos nos .maps (220 nós em 14 mapas): início, fim, monstros/chefes, NPCs, portais, coleta, travessias. São o desenho do mapa; em jogo o servidor manda os nós reais por 127 U_C_CAMPAIGN_NODE (CampaignNodeListMsg). Ver docs/WORLD.md §3.';
COMMENT ON COLUMN game.campaign_nodes.map_file_id IS 'Arquivo de mapa (game.map_files).';
COMMENT ON COLUMN game.campaign_nodes.ordinal IS 'Posição do nó na lista do arquivo.';
COMMENT ON COLUMN game.campaign_nodes.node_id IS 'Id do nó no editor (mapId·100+n em instâncias; NULL em 7602).';
COMMENT ON COLUMN game.campaign_nodes.item_type IS 'Tipo do nó = PosType/MasterType (enum pos_type): 40 início, 41 fim/chefe, 42 monstro/gatilho, 53 pedágio, 61 NPC/diálogo, 62 portal, 91 coleta, 121/131 travessia, 0 decoração.';
COMMENT ON COLUMN game.campaign_nodes.item_type_name IS 'Rótulo do enum pos_type.';
COMMENT ON COLUMN game.campaign_nodes.name_zh IS 'Nome do editor (chinês); o nome pt-BR vem do servidor em CampaignNodeMsg.node_name.';
COMMENT ON COLUMN game.campaign_nodes.x_px IS 'Posição X em px.';
COMMENT ON COLUMN game.campaign_nodes.y_px IS 'Posição Y em px.';
COMMENT ON COLUMN game.campaign_nodes.cell_x IS 'x_px/20 (célula da grade de caminhada).';
COMMENT ON COLUMN game.campaign_nodes.cell_y IS 'y_px/20.';
COMMENT ON COLUMN game.campaign_nodes.start_cells IS 'startPos: células de spawn "gx,gy|…" (nós 40 e 62 de chegada).';
COMMENT ON COLUMN game.campaign_nodes.next_node_ids IS 'nextNodeIds (grafo de progressão; vazio em todos os 220 nós baixados).';
COMMENT ON COLUMN game.campaign_nodes.move_to_node_ids IS 'moveToNodeIds: nó de destino de um portal (ex. 235103 → 235201).';
COMMENT ON COLUMN game.campaign_nodes.patrol_cells IS 'patrolmanPoint: rota de patrulha "gx,gy|gx,gy" em células.';
COMMENT ON COLUMN game.campaign_nodes.battle_type IS 'BattleType do editor (0 em todos os nós baixados; o tipo real vem do servidor).';
COMMENT ON COLUMN game.campaign_nodes.ai_class IS 'Classe de IA do servidor (com.road.yishi.mapphysics.node.ai.*), ex. CNRoomBossNodeAi.';
COMMENT ON COLUMN game.campaign_nodes.exist_hero IS 'Nó tem herói (chefe).';
COMMENT ON COLUMN game.campaign_nodes.exist_pawn IS 'Nó tem tropas.';
COMMENT ON COLUMN game.campaign_nodes.hero IS 'Campo hero do editor (null nos dados).';
COMMENT ON COLUMN game.campaign_nodes.pawns IS '{pawn1, pawnNum1, pawn2, pawnNum2} do editor.';
COMMENT ON COLUMN game.campaign_nodes.handler_range IS 'Raio de interação em células.';
COMMENT ON COLUMN game.campaign_nodes.toward IS 'Direção (graus).';
COMMENT ON COLUMN game.campaign_nodes.attack_types IS 'AttackTypes (1 = monstro que ataca/patrulha).';
COMMENT ON COLUMN game.campaign_nodes.is_repeat IS 'IsRepeat.';
COMMENT ON COLUMN game.campaign_nodes.node_state IS 'NodeState inicial (enum node_state).';
COMMENT ON COLUMN game.campaign_nodes.name_color IS 'Cor do nome.';
COMMENT ON COLUMN game.campaign_nodes.resource IS '1 = avatar andante; outro = prédio mapmaterial/build/<sonType>.swf.';
COMMENT ON COLUMN game.campaign_nodes.params IS 'Param1..Param6 (Param1 = lado/time em PvP: 1/2).';
COMMENT ON COLUMN game.campaign_nodes.property3 IS 'property3 (célula X de referência/retorno em vários nós).';
COMMENT ON COLUMN game.campaign_nodes.property4 IS 'property4 (célula Y de referência/retorno).';
COMMENT ON COLUMN game.campaign_nodes.building_url IS 'url do gráfico do nó (mapmaterial/build/*.swf).';
COMMENT ON COLUMN game.campaign_nodes.raw IS 'Objeto original do JSON.';

CREATE TABLE game.dungeon_types (
  code            text PRIMARY KEY,
  name_pt         text NOT NULL,
  room_type       smallint,
  scene_type      text REFERENCES game.scenes(scene_type),
  campaign_types  integer[] NOT NULL DEFAULT '{}',
  map_ids         integer[] NOT NULL DEFAULT '{}',
  min_players     integer,
  max_players     integer,
  min_level       integer,
  entry_pt        text,
  flow_pt         text,
  rewards_pt      text,
  requirements_pt text,
  source_ref      text NOT NULL
);
COMMENT ON TABLE  game.dungeon_types IS 'Modos multiplayer / dungeons: salas PvE (Portal dos Heróis), PvP, Multi/Mate/Ares Lords, Apex, Jogo da Glória, Teseu, veículo, Grupo FB, equipe livre, etc. Ver docs/WORLD.md §4.';
COMMENT ON COLUMN game.dungeon_types.code IS 'Código interno (inglês).';
COMMENT ON COLUMN game.dungeon_types.name_pt IS 'Nome pt-BR.';
COMMENT ON COLUMN game.dungeon_types.room_type IS 'RoomMsg.room_type (enum room_type) que BaseManager.__createRoomHandler usa para escolher a cena; NULL = não usa sala.';
COMMENT ON COLUMN game.dungeon_types.scene_type IS 'Cena de espera (sala) ou de jogo.';
COMMENT ON COLUMN game.dungeon_types.campaign_types IS 'Campaigns.Types (enum campaign_type) jogados neste modo.';
COMMENT ON COLUMN game.dungeon_types.map_ids IS 'Mapas fixos do modo (WorldBossHelper).';
COMMENT ON COLUMN game.dungeon_types.min_players IS 'Mínimo de jogadores para iniciar (Campaigns.EnterNumb quando aplicável).';
COMMENT ON COLUMN game.dungeon_types.max_players IS 'Máximo de jogadores (RoomMsg.capacity / Campaigns.Capacity / slots da UI).';
COMMENT ON COLUMN game.dungeon_types.min_level IS 'Nível mínimo checado no cliente.';
COMMENT ON COLUMN game.dungeon_types.entry_pt IS 'Como se entra.';
COMMENT ON COLUMN game.dungeon_types.flow_pt IS 'Fluxo criar → entrar → pronto → iniciar.';
COMMENT ON COLUMN game.dungeon_types.rewards_pt IS 'Recompensas.';
COMMENT ON COLUMN game.dungeon_types.requirements_pt IS 'Requisitos.';
COMMENT ON COLUMN game.dungeon_types.source_ref IS 'Arquivo:linha.';

CREATE TABLE game.room_protocol (
  id             serial PRIMARY KEY,
  dungeon_code   text REFERENCES game.dungeon_types(code) ON DELETE CASCADE,
  phase          text NOT NULL CHECK (phase IN ('list', 'create', 'enter', 'invite', 'slot', 'ready', 'start', 'in_game', 'leave', 'kick', 'master', 'state', 'match', 'result')),
  step_order     integer NOT NULL,
  direction      text NOT NULL CHECK (direction IN ('send', 'accept')),
  opcode         integer NOT NULL,
  opcode_name    text,
  proto_message  text,
  client_method  text,
  notes_pt       text,
  source_ref     text NOT NULL
);
COMMENT ON TABLE  game.room_protocol IS 'Passos do protocolo das salas/dungeons: listar, criar, entrar, convidar, slots, pronto, iniciar, sair, expulsar, trocar dono, partida. dungeon_code NULL = comum a todas as salas. Ver docs/WORLD.md §4.';
COMMENT ON COLUMN game.room_protocol.dungeon_code IS 'Modo (game.dungeon_types) ou NULL = genérico.';
COMMENT ON COLUMN game.room_protocol.phase IS 'Fase do fluxo.';
COMMENT ON COLUMN game.room_protocol.step_order IS 'Ordem dentro do fluxo.';
COMMENT ON COLUMN game.room_protocol.direction IS 'send = cliente→servidor; accept = servidor→cliente.';
COMMENT ON COLUMN game.room_protocol.opcode IS 'Código do pacote.';
COMMENT ON COLUMN game.room_protocol.opcode_name IS 'Nome em protocol/opcodes.csv.';
COMMENT ON COLUMN game.room_protocol.proto_message IS 'Mensagem protobuf.';
COMMENT ON COLUMN game.room_protocol.client_method IS 'Método do cliente que envia/trata.';
COMMENT ON COLUMN game.room_protocol.notes_pt IS 'Campos relevantes e efeito.';
COMMENT ON COLUMN game.room_protocol.source_ref IS 'Arquivo:linha.';

CREATE VIEW game.v_world_graph AS
SELECT l.id, l.link_kind, l.from_map_id, fm.name AS from_map, l.to_map_id, tm.name AS to_map, l.via_node_id,
       l.direction, l.condition_pt, l.source_ref
FROM game.world_links l
LEFT JOIN game.maps fm ON fm.id = l.from_map_id
LEFT JOIN game.maps tm ON tm.id = l.to_map_id;
COMMENT ON VIEW game.v_world_graph IS 'Arestas de game.world_links com os nomes pt-BR dos mapas.';

CREATE VIEW game.v_scene_graph AS
SELECT t.id, coalesce(t.from_scene, '*') AS from_scene, fs.name_pt AS from_name, t.to_scene, ts.name_pt AS to_name,
       t.trigger_pt, t.opcode_direction, t.opcode, t.opcode_name, t.proto_message, t.condition_pt, t.source_ref
FROM game.scene_transitions t
LEFT JOIN game.scenes fs ON fs.scene_type = t.from_scene
JOIN game.scenes ts ON ts.scene_type = t.to_scene;
COMMENT ON VIEW game.v_scene_graph IS 'Transições entre cenas com nomes pt-BR.';

CREATE VIEW game.v_multiplayer_campaigns AS
SELECT c.id AS campaign_id, c.name, c.campaign_type, meta.enum_label('campaign_type', c.campaign_type) AS campaign_type_label,
       c.son_type, c.area_id, c.dungeon_id, c.difficulty, c.capacity, c.enter_count, c.min_level, c.max_level,
       c.requires_transfer, c.required_fight_power, c.item_ids AS reward_item_ids, c.base_gp,
       (SELECT array_agg(m.id ORDER BY m.id) FROM game.maps m WHERE m.campaign_id = c.id) AS map_ids
FROM game.campaigns c
WHERE c.capacity > 1;
COMMENT ON VIEW game.v_multiplayer_campaigns IS 'Campanhas com Capacity > 1 (equipe de 4 ou mapa aberto 10000): o catálogo de dungeons multiplayer com requisitos, vitrine de recompensas e mapas (andares).';

INSERT INTO meta.schema_migrations(version, description) VALUES ('0013', 'world: scenes, transitions, worlds, links, campaign nodes, dungeons, room protocol') ON CONFLICT DO NOTHING;
