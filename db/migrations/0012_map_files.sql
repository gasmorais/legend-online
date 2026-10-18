SET search_path = game, client, raw, meta, public;

CREATE TABLE game.map_files (
  map_file_id    integer PRIMARY KEY,
  width_px       integer NOT NULL,
  height_px      integer NOT NULL,
  cols           integer NOT NULL,
  rows           integer NOT NULL,
  cell_semantics text NOT NULL CHECK (cell_semantics IN ('walkable', 'obstacle')),
  marked_cells   integer NOT NULL,
  value_counts   jsonb NOT NULL,
  marked_bbox    integer[],
  border_cells   integer NOT NULL,
  floor_items    integer NOT NULL,
  movie_items    integer NOT NULL,
  top_items      integer NOT NULL,
  node_count     integer NOT NULL,
  source_ref     text NOT NULL
);
COMMENT ON TABLE  game.map_files IS 'Resumo de cada arquivo de mapa decodificado (59 MapFileIds): tamanho, grade de 20 px, células marcadas no .titles, borda e contagem de objetos/nós do .maps.';
COMMENT ON COLUMN game.map_files.map_file_id IS 'MapInfos.MapFileId (pasta maps/<id>/).';
COMMENT ON COLUMN game.map_files.width_px IS 'Largura usada pelo decodificador (MapInfos.Width ou extensão da grade).';
COMMENT ON COLUMN game.map_files.height_px IS 'Altura.';
COMMENT ON COLUMN game.map_files.cols IS 'Colunas da grade de 20 px.';
COMMENT ON COLUMN game.map_files.rows IS 'Linhas da grade de 20 px.';
COMMENT ON COLUMN game.map_files.cell_semantics IS 'O que significa uma célula presente no .titles: walkable (campanha/espacial) ou obstacle (cidade externa, mundos 1–5: OuterCityModel.getWalkable truthy = obstáculo).';
COMMENT ON COLUMN game.map_files.marked_cells IS 'Células presentes no .titles.';
COMMENT ON COLUMN game.map_files.value_counts IS 'Contagem por valor de célula ({"1": n, "2": n...}; ver enum titles_cell_value).';
COMMENT ON COLUMN game.map_files.marked_bbox IS 'Caixa das células marcadas: {col_min, row_min, col_max, row_max}.';
COMMENT ON COLUMN game.map_files.border_cells IS 'Células marcadas com ao menos um vizinho (4-conexo) não marcado = contorno (game.map_border_cells).';
COMMENT ON COLUMN game.map_files.floor_items IS 'Itens de chão (floorData).';
COMMENT ON COLUMN game.map_files.movie_items IS 'Animações de cenário (moviesData).';
COMMENT ON COLUMN game.map_files.top_items IS 'Objetos sobrepostos (topsData).';
COMMENT ON COLUMN game.map_files.node_count IS 'Nós de editor embutidos no .maps (NPC, monstro, início, fim, portal...).';
COMMENT ON COLUMN game.map_files.source_ref IS 'Arquivos de origem.';

CREATE TABLE game.map_walk_runs (
  map_file_id integer NOT NULL REFERENCES game.map_files(map_file_id) ON DELETE CASCADE,
  value       smallint NOT NULL,
  col         integer NOT NULL,
  row_from    integer NOT NULL,
  row_to      integer NOT NULL,
  PRIMARY KEY (map_file_id, value, col, row_from)
);
COMMENT ON TABLE  game.map_walk_runs IS 'Grade do .titles em runs verticais: na coluna col, linhas row_from..row_to (inclusive) têm o valor value. Célula (col,row) = px (col·20, row·20).';
COMMENT ON COLUMN game.map_walk_runs.map_file_id IS 'Mapa.';
COMMENT ON COLUMN game.map_walk_runs.value IS 'Valor da célula (enum titles_cell_value).';
COMMENT ON COLUMN game.map_walk_runs.col IS 'Coluna (x/20).';
COMMENT ON COLUMN game.map_walk_runs.row_from IS 'Primeira linha (y/20).';
COMMENT ON COLUMN game.map_walk_runs.row_to IS 'Última linha (inclusive).';

CREATE TABLE game.map_border_cells (
  map_file_id integer NOT NULL REFERENCES game.map_files(map_file_id) ON DELETE CASCADE,
  col         integer NOT NULL,
  row         integer NOT NULL,
  open_sides  smallint NOT NULL,
  PRIMARY KEY (map_file_id, col, row)
);
COMMENT ON TABLE  game.map_border_cells IS 'Borda da área marcada de cada mapa: células marcadas com vizinho não marcado. Em mapas walkable é o limite andável; nos mundos 1–5 é o contorno dos obstáculos.';
COMMENT ON COLUMN game.map_border_cells.map_file_id IS 'Mapa.';
COMMENT ON COLUMN game.map_border_cells.col IS 'Coluna (x/20).';
COMMENT ON COLUMN game.map_border_cells.row IS 'Linha (y/20).';
COMMENT ON COLUMN game.map_border_cells.open_sides IS 'Lados sem vizinho marcado (bits: 1 esquerda, 2 direita, 4 cima, 8 baixo).';

CREATE TYPE game.scene_layer AS ENUM ('floor', 'movie', 'top');
CREATE TABLE game.map_scene_objects (
  row_id      serial PRIMARY KEY,
  map_file_id integer NOT NULL REFERENCES game.map_files(map_file_id) ON DELETE CASCADE,
  layer       game.scene_layer NOT NULL,
  ordinal     integer NOT NULL,
  name        text,
  url         text,
  x           integer,
  y           integer,
  base_num    integer,
  rotation    numeric,
  scale_x     numeric,
  scale_y     numeric,
  alpha       numeric,
  width       integer,
  height      integer,
  chunk       text,
  node_id     bigint,
  asset_id    integer REFERENCES client.assets(id)
);
COMMENT ON TABLE  game.map_scene_objects IS 'Objetos de cenário dos .maps: floor (chão, baseNum 101 = fundo repetido; só > 101 é desenhado), movie (swf abaixo do avatar) e top (acima), em px absolutos.';
COMMENT ON COLUMN game.map_scene_objects.row_id IS 'Chave substituta.';
COMMENT ON COLUMN game.map_scene_objects.map_file_id IS 'Mapa.';
COMMENT ON COLUMN game.map_scene_objects.layer IS 'floor, movie ou top.';
COMMENT ON COLUMN game.map_scene_objects.ordinal IS 'Ordem no arquivo.';
COMMENT ON COLUMN game.map_scene_objects.name IS 'Nome/camada do item.';
COMMENT ON COLUMN game.map_scene_objects.url IS 'Recurso relativo ({RES}<url>, ex.: mapmaterial/build/2336.swf).';
COMMENT ON COLUMN game.map_scene_objects.x IS 'x em px (canto superior esquerdo).';
COMMENT ON COLUMN game.map_scene_objects.y IS 'y em px.';
COMMENT ON COLUMN game.map_scene_objects.base_num IS 'Camada/z (floor: 101 fundo; > 101 desenhado em ordem).';
COMMENT ON COLUMN game.map_scene_objects.rotation IS 'Rotação em graus.';
COMMENT ON COLUMN game.map_scene_objects.scale_x IS 'Escala x.';
COMMENT ON COLUMN game.map_scene_objects.scale_y IS 'Escala y.';
COMMENT ON COLUMN game.map_scene_objects.alpha IS 'Transparência.';
COMMENT ON COLUMN game.map_scene_objects.width IS 'Largura declarada.';
COMMENT ON COLUMN game.map_scene_objects.height IS 'Altura declarada.';
COMMENT ON COLUMN game.map_scene_objects.chunk IS 'Bloco de 1000 px "cx,cy".';
COMMENT ON COLUMN game.map_scene_objects.node_id IS 'Nó de editor ao qual o objeto pertence (quando houver).';
COMMENT ON COLUMN game.map_scene_objects.asset_id IS 'Recurso no manifesto (client.assets).';
CREATE INDEX ON game.map_scene_objects (map_file_id, layer);

CREATE VIEW game.v_map_overview AS
SELECT b.map_id, m.name, b.map_file_id, b.width_px, b.height_px, f.cell_semantics, f.marked_cells, f.border_cells,
       f.floor_items, f.movie_items, f.top_items, f.node_count,
       (SELECT count(*) FROM game.map_points p WHERE p.map_id = b.map_file_id AND p.kind = 'player_spawn' AND p.ref_table = 'map_file') AS spawn_cells,
       (SELECT count(*) FROM game.map_points p WHERE p.map_id = b.map_file_id AND p.kind = 'portal' AND p.ref_table = 'map_file') AS portals
FROM game.map_bounds b JOIN game.maps m ON m.id = b.map_id
LEFT JOIN game.map_files f ON f.map_file_id = b.map_file_id;
COMMENT ON VIEW game.v_map_overview IS 'Por mapa (MapInfos): limites, semântica da grade, borda, objetos de cenário, nós, spawns e portais vindos dos arquivos de mapa.';

ALTER TABLE client.assets ADD COLUMN local_path text;
COMMENT ON COLUMN client.assets.local_path IS 'Caminho local quando o arquivo já foi baixado para raw/<caminho> (maps, sceneima, skilleffect, swf/boss*, swf/monster*...); NULL = só no CDN.';

INSERT INTO meta.schema_migrations(version, description) VALUES ('0012', 'decoded map files') ON CONFLICT DO NOTHING;
