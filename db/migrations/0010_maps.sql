SET search_path = game, client, raw, meta, public;

CREATE TYPE game.map_context AS ENUM ('space_map', 'world_map', 'campaign_map', 'castle', 'crisis_map', 'outyard_map',
                                      'monster_explore_map', 'battle', 'other');
CREATE TYPE game.point_source AS ENUM ('template', 'map_file', 'server_message', 'hardcoded');

CREATE TABLE game.map_point_kinds (
  code        text PRIMARY KEY,
  label_pt    text NOT NULL,
  source      game.point_source NOT NULL,
  location    text,
  units       text,
  description text,
  source_ref  text
);
COMMENT ON TABLE  game.map_point_kinds IS 'Tipos de ponto de mapa: nascimento/spawn, portal, nó de NPC, slot de prédio, nó de exploração, posição de batalha... e de onde vêm as coordenadas.';
COMMENT ON COLUMN game.map_point_kinds.code IS 'Nome semântico (inglês).';
COMMENT ON COLUMN game.map_point_kinds.label_pt IS 'Rótulo pt-BR.';
COMMENT ON COLUMN game.map_point_kinds.source IS 'template (tempinfos), map_file (.maps/.titles), server_message (protobuf) ou hardcoded (constante no AS3).';
COMMENT ON COLUMN game.map_point_kinds.location IS 'Campo/arquivo/mensagem de onde sai a coordenada.';
COMMENT ON COLUMN game.map_point_kinds.units IS 'Unidade: px, grid20 (células de 20 px), tile300, tile512.';
COMMENT ON COLUMN game.map_point_kinds.description IS 'Explicação.';
COMMENT ON COLUMN game.map_point_kinds.source_ref IS 'arquivo:linha.';

CREATE TABLE game.map_points (
  row_id        serial PRIMARY KEY,
  context       game.map_context NOT NULL,
  map_id        integer,
  kind          text NOT NULL REFERENCES game.map_point_kinds(code),
  name          text,
  ref_table     text,
  ref_id        text,
  x_px          integer,
  y_px          integer,
  grid_x        integer,
  grid_y        integer,
  target_map_id  integer,
  target_node_id integer,
  extra         jsonb,
  source_ref    text NOT NULL
);
COMMENT ON TABLE  game.map_points IS 'Todos os pontos posicionados conhecidos sem baixar arquivos de mapa: nós e nascimentos do mapa espacial, portais, nós da Crise/Quintal/Exploração de Monstros, campanhas no mapa-mundo, slots de prédios, grade de batalha e coordenadas fixas do código.';
COMMENT ON COLUMN game.map_points.row_id IS 'Chave substituta.';
COMMENT ON COLUMN game.map_points.context IS 'Tipo de mapa/cena.';
COMMENT ON COLUMN game.map_points.map_id IS 'Id do mapa no contexto (MapInfos.Id, MapId da lista, lado da batalha...).';
COMMENT ON COLUMN game.map_points.kind IS 'Tipo do ponto (game.map_point_kinds).';
COMMENT ON COLUMN game.map_points.name IS 'Nome pt-BR, quando houver.';
COMMENT ON COLUMN game.map_points.ref_table IS 'Tabela/lista de origem.';
COMMENT ON COLUMN game.map_points.ref_id IS 'Id do registro de origem.';
COMMENT ON COLUMN game.map_points.x_px IS 'x em px (calculado de grid_x·20 quando só há célula).';
COMMENT ON COLUMN game.map_points.y_px IS 'y em px.';
COMMENT ON COLUMN game.map_points.grid_x IS 'Coluna na grade de caminhada de 20 px (quando aplicável).';
COMMENT ON COLUMN game.map_points.grid_y IS 'Linha na grade de 20 px.';
COMMENT ON COLUMN game.map_points.target_map_id IS 'Portais: mapa de destino.';
COMMENT ON COLUMN game.map_points.target_node_id IS 'Portais: nó de destino.';
COMMENT ON COLUMN game.map_points.extra IS 'Atributos adicionais (raio de interação, orientação, ligações, tipo de nó...).';
COMMENT ON COLUMN game.map_points.source_ref IS 'Proveniência (tempinfos.xml#Lista[ordinal] ou arquivo:linha).';
CREATE INDEX ON game.map_points (context, map_id);
CREATE INDEX ON game.map_points (kind);

CREATE TABLE game.map_bounds (
  map_id          integer PRIMARY KEY REFERENCES game.maps(id) ON DELETE CASCADE,
  map_file_id     integer,
  width_px        integer,
  height_px       integer,
  tile_px         smallint,
  tiles_x         integer,
  tiles_y         integer,
  walk_cols       integer,
  walk_rows       integer,
  manifest_tiles  integer NOT NULL DEFAULT 0,
  has_maps_file   boolean NOT NULL DEFAULT false,
  has_titles_file boolean NOT NULL DEFAULT false,
  battle_scene_id integer,
  notes           text
);
COMMENT ON TABLE  game.map_bounds IS 'Limites de cada mapa (MapInfos): retângulo em px, grade de tiles de arte e grade de caminhada de 20 px. A borda andável exata vem das chaves "{x}_{y}" do .titles (não baixado: ver has_titles_file).';
COMMENT ON COLUMN game.map_bounds.map_id IS 'MapInfos.Id.';
COMMENT ON COLUMN game.map_bounds.map_file_id IS 'MapInfos.MapFileId (pasta maps/<id>/ e mapmaterial/land/<id>/).';
COMMENT ON COLUMN game.map_bounds.width_px IS 'Largura total do mapa (limite da câmera).';
COMMENT ON COLUMN game.map_bounds.height_px IS 'Altura total do mapa.';
COMMENT ON COLUMN game.map_bounds.tile_px IS 'Lado do tile de fundo: 300 (instâncias/campanha) ou 512 (mundos 1–5).';
COMMENT ON COLUMN game.map_bounds.tiles_x IS 'Colunas de tiles = ceil(largura/tile_px) (mundos: 20).';
COMMENT ON COLUMN game.map_bounds.tiles_y IS 'Linhas de tiles.';
COMMENT ON COLUMN game.map_bounds.walk_cols IS 'Colunas da grade de caminhada = ceil(largura/20).';
COMMENT ON COLUMN game.map_bounds.walk_rows IS 'Linhas da grade de caminhada = ceil(altura/20).';
COMMENT ON COLUMN game.map_bounds.manifest_tiles IS 'Tiles de mapmaterial/land/<map_file_id>/ presentes no manifesto.';
COMMENT ON COLUMN game.map_bounds.has_maps_file IS 'maps/<id>/<id>.maps está no manifesto (chão, movies, tops).';
COMMENT ON COLUMN game.map_bounds.has_titles_file IS 'maps/<id>/<id>.titles está no manifesto (grade andável).';
COMMENT ON COLUMN game.map_bounds.battle_scene_id IS 'MapInfos.BattleGround → sceneIma/<id>/map<id>.swf.';
COMMENT ON COLUMN game.map_bounds.notes IS 'Observações.';

CREATE TABLE game.map_file_formats (
  file_kind    text PRIMARY KEY,
  url_template text,
  structure    text NOT NULL,
  fields       jsonb,
  source_ref   text
);
COMMENT ON TABLE  game.map_file_formats IS 'Formato dos arquivos de mapa (.maps, .titles, .rd, .path, tiles) como o cliente os lê.';
COMMENT ON COLUMN game.map_file_formats.file_kind IS 'Extensão/tipo.';
COMMENT ON COLUMN game.map_file_formats.url_template IS 'Template de URL (PathManager).';
COMMENT ON COLUMN game.map_file_formats.structure IS 'Estrutura (pt-BR).';
COMMENT ON COLUMN game.map_file_formats.fields IS 'Campos [{name, type, meaning_pt}].';
COMMENT ON COLUMN game.map_file_formats.source_ref IS 'arquivo:linha.';

INSERT INTO meta.schema_migrations(version, description) VALUES ('0010', 'map geometry') ON CONFLICT DO NOTHING;
