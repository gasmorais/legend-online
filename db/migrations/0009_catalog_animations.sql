SET search_path = game, client, raw, meta, public;

ALTER TABLE client.assets
  ADD COLUMN family        text,
  ADD COLUMN owner_folder  text,
  ADD COLUMN variant       text,
  ADD COLUMN job_id        smallint,
  ADD COLUMN sex_id        smallint,
  ADD COLUMN numeric_ids   integer[],
  ADD COLUMN path_function text,
  ADD COLUMN path_variant  smallint,
  ADD COLUMN path_params   text[];
COMMENT ON COLUMN client.assets.family IS 'Família derivada do nome da pasta/arquivo (fashion_cloth, fashion_hat, wing, mount, pet, warrior_default, monster, tile, icon/appell...).';
COMMENT ON COLUMN client.assets.owner_folder IS 'Pasta "dona" da arte sem sufixos de variante (ex.: swf/avatar/fashion_cloth_ballet para .../fashion_cloth_ballet_mount/1_0.bswf); casa com Avata/AvatarPath dos templates.';
COMMENT ON COLUMN client.assets.variant IS 'Variante pela pasta/arquivo: normal, mount, up, down, up_mount, down_mount, cloak, cloak_mount, follow, front, back, dragonic.';
COMMENT ON COLUMN client.assets.job_id IS 'Classe extraída do nome <job>_<sexo>.(b)swf (moda/asa); NULL quando não se aplica.';
COMMENT ON COLUMN client.assets.sex_id IS 'Sexo extraído do nome: <job>_<sexo> ou <sexo>.(b)swf de equipamento (0 feminino, 1 masculino); arquivos 2.* (montaria/pet/filho) ficam NULL.';
COMMENT ON COLUMN client.assets.numeric_ids IS 'Todos os números presentes no caminho (ids de mapa, tile x/y, ícones, níveis...).';
COMMENT ON COLUMN client.assets.path_function IS 'Função do PathManager (routes/routes.json) cujo template gera este caminho — a mais específica que casa.';
COMMENT ON COLUMN client.assets.path_variant IS 'Variante do template em client.url_templates.';
COMMENT ON COLUMN client.assets.path_params IS 'Valores capturados para os parâmetros do template, na ordem em que aparecem.';
ALTER TABLE client.assets ADD FOREIGN KEY (job_id) REFERENCES game.jobs(id);
ALTER TABLE client.assets ADD FOREIGN KEY (sex_id) REFERENCES game.sexes(id);
CREATE INDEX ON client.assets (family);
CREATE INDEX ON client.assets (owner_folder);
CREATE INDEX ON client.assets (path_function);

CREATE TABLE client.swf_symbols (
  swf        text NOT NULL,
  char_id    integer NOT NULL,
  kind       text NOT NULL,
  linkage    text,
  width      numeric,
  height     numeric,
  frames     integer,
  label_count integer,
  place_ops  integer,
  fps        numeric,
  PRIMARY KEY (swf, char_id)
);
COMMENT ON TABLE  client.swf_symbols IS 'Personagens (char) de cada SWF de UI parseado em web/public/lib/<swf>/library.json (tools/swflib.py, da outra sessão): imagens, shapes e sprites com timeline.';
COMMENT ON COLUMN client.swf_symbols.swf IS 'Nome do SWF/pasta em web/public/lib.';
COMMENT ON COLUMN client.swf_symbols.char_id IS 'Id do personagem dentro do SWF.';
COMMENT ON COLUMN client.swf_symbols.kind IS 'Tipo do personagem (sprite, image, shape...).';
COMMENT ON COLUMN client.swf_symbols.linkage IS 'Nome de classe exportado (asset.<módulo>.<nome>), quando existe.';
COMMENT ON COLUMN client.swf_symbols.width IS 'Largura (imagens/shapes).';
COMMENT ON COLUMN client.swf_symbols.height IS 'Altura (imagens/shapes).';
COMMENT ON COLUMN client.swf_symbols.frames IS 'Quadros da timeline (sprites).';
COMMENT ON COLUMN client.swf_symbols.label_count IS 'Rótulos de quadro na timeline.';
COMMENT ON COLUMN client.swf_symbols.place_ops IS 'Total de operações de display list na timeline (place/move/remove), medida de complexidade da animação.';
COMMENT ON COLUMN client.swf_symbols.fps IS 'Taxa de quadros declarada no SWF.';
CREATE INDEX ON client.swf_symbols (linkage);

CREATE TABLE client.swf_frame_labels (
  swf      text NOT NULL,
  char_id  integer NOT NULL,
  label    text NOT NULL,
  frame    integer NOT NULL,
  ordinal  smallint NOT NULL,
  PRIMARY KEY (swf, char_id, label),
  FOREIGN KEY (swf, char_id) REFERENCES client.swf_symbols(swf, char_id) ON DELETE CASCADE
);
COMMENT ON TABLE  client.swf_frame_labels IS 'Rótulos de quadro das timelines de UI, em ordem (ordinal) — a "ordem de animação" de cada MovieClip de UI.';
COMMENT ON COLUMN client.swf_frame_labels.swf IS 'SWF.';
COMMENT ON COLUMN client.swf_frame_labels.char_id IS 'Sprite.';
COMMENT ON COLUMN client.swf_frame_labels.label IS 'Rótulo.';
COMMENT ON COLUMN client.swf_frame_labels.frame IS 'Quadro (base 0 como em library.json).';
COMMENT ON COLUMN client.swf_frame_labels.ordinal IS 'Ordem do rótulo na timeline.';

CREATE TABLE client.symbol_linkages (
  linkage text PRIMARY KEY,
  swf     text NOT NULL,
  char_id integer NOT NULL
);
COMMENT ON TABLE  client.symbol_linkages IS 'Índice global nome de classe → SWF de UI/personagem (web/public/lib/linkage.json).';
COMMENT ON COLUMN client.symbol_linkages.linkage IS 'Nome de classe exportado.';
COMMENT ON COLUMN client.symbol_linkages.swf IS 'SWF que o define.';
COMMENT ON COLUMN client.symbol_linkages.char_id IS 'Personagem no SWF.';

CREATE TABLE client.name_pool (
  ordinal integer PRIMARY KEY,
  name    text NOT NULL,
  locale  text NOT NULL DEFAULT 'pt_BR'
);
COMMENT ON TABLE  client.name_pool IS 'Nomes de personagem do sorteio de nomes (ui/zh_cn/nameslib.txt decodificado). O cabeçalho do arquivo diz que o planejamento desligou o nome aleatório.';
COMMENT ON COLUMN client.name_pool.ordinal IS 'Posição no arquivo.';
COMMENT ON COLUMN client.name_pool.name IS 'Nome.';
COMMENT ON COLUMN client.name_pool.locale IS 'Locale do conteúdo servido (pt_BR).';

CREATE TABLE game.avatar_direction_map (
  is_stand_pos_mount boolean NOT NULL,
  angle_from   numeric NOT NULL,
  angle_to     numeric NOT NULL,
  frame_y      smallint NOT NULL CHECK (frame_y BETWEEN 0 AND 4),
  mirror       smallint NOT NULL CHECK (mirror IN (-1, 1)),
  source_ref   text NOT NULL,
  PRIMARY KEY (is_stand_pos_mount, angle_from)
);
COMMENT ON TABLE  game.avatar_direction_map IS 'Ângulo de movimento → linha de quadros (frameY = direção 0..4) e espelho (scaleX) do avatar de mapa (HeroAvatar.set angle). Ângulo em graus de tela: 90 = para baixo, 270 = para cima, 0 = direita.';
COMMENT ON COLUMN game.avatar_direction_map.is_stand_pos_mount IS 'true = tabela usada quando montado em pose em pé (faixas diagonais mais estreitas).';
COMMENT ON COLUMN game.avatar_direction_map.angle_from IS 'Início da faixa (inclusivo).';
COMMENT ON COLUMN game.avatar_direction_map.angle_to IS 'Fim da faixa (exclusivo; faixas que cruzam 0° aparecem em duas linhas).';
COMMENT ON COLUMN game.avatar_direction_map.frame_y IS 'Direção: 0 baixo, 1 diagonal-baixo, 2 lado, 3 diagonal-cima, 4 cima.';
COMMENT ON COLUMN game.avatar_direction_map.mirror IS '1 normal, -1 espelhado (lado esquerdo).';
COMMENT ON COLUMN game.avatar_direction_map.source_ref IS 'arquivo:linha.';

INSERT INTO game.avatar_direction_map VALUES
 (true, 270, 310, 4,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:103'),
 (true, 225, 270, 4, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:108'),
 (true, 310, 320, 3,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:113'),
 (true, 320, 360, 2,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:118'),
 (true,   0,  40, 2,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:118'),
 (true,  40,  45, 1,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:123'),
 (true,  45,  90.0001, 0, 1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:128'),
 (true,  90.0001, 135, 0, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:133'),
 (true, 135, 140, 1, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:138'),
 (true, 140, 220, 2, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:143'),
 (true, 220, 225, 3, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:148'),
 (false, 270, 280, 4,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:154'),
 (false, 260, 270, 4, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:159'),
 (false, 280, 350, 3,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:164'),
 (false, 350, 360, 2,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:169'),
 (false,   0,  10, 2,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:169'),
 (false,  10,  80, 1,  1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:174'),
 (false,  80,  90.0001, 0, 1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:179'),
 (false,  90.0001, 100, 0, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:184'),
 (false, 100, 170, 1, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:189'),
 (false, 170, 190, 2, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:194'),
 (false, 190, 260, 3, -1, 'decompiled/m3/scripts/avatar/view/HeroAvatar.as:199');

CREATE TABLE game.avatar_frame_sequences (
  action       game.avatar_action NOT NULL,
  frame_y      smallint NOT NULL,
  frame_x      smallint NOT NULL,
  class_suffix text NOT NULL,
  stand_dir_for_walk_dirs smallint[],
  source_ref   text NOT NULL,
  PRIMARY KEY (action, frame_y, frame_x)
);
COMMENT ON TABLE  game.avatar_frame_sequences IS 'Ordem dos quadros do avatar de mapa: classe BitmapData asset.<pasta>_<arquivo>.<class_suffix> dentro de cada .bswf. Valores padrão (Stand 5×3, Walk 6×5); o número real de quadros pode vir do cabeçalho do .bswf (tag 6 curTotalFrameX). O quadro avança 1 por tick e volta a 0 (loop); de pé montado o Stand avança a cada _standWalkDValue ticks.';
COMMENT ON COLUMN game.avatar_frame_sequences.action IS 'stand (prefixo S) ou walk (prefixo W).';
COMMENT ON COLUMN game.avatar_frame_sequences.frame_y IS 'Linha de direção (Walk 0..4; Stand 0..2).';
COMMENT ON COLUMN game.avatar_frame_sequences.frame_x IS 'Índice do quadro na ordem de reprodução.';
COMMENT ON COLUMN game.avatar_frame_sequences.class_suffix IS 'Sufixo da classe: S_<frame_x>_<frame_y> / W_<frame_x>_<frame_y>.';
COMMENT ON COLUMN game.avatar_frame_sequences.stand_dir_for_walk_dirs IS 'Stand: direções de Walk que usam esta linha (0/1→0, 2/3→1, 4→2).';
COMMENT ON COLUMN game.avatar_frame_sequences.source_ref IS 'arquivo:linha.';
INSERT INTO game.avatar_frame_sequences
SELECT 'stand'::game.avatar_action, y, x, format('S_%s_%s', x, y),
       CASE y WHEN 0 THEN '{0,1}'::smallint[] WHEN 1 THEN '{2,3}' ELSE '{4}' END,
       'decompiled/m3/scripts/avatar/view/HeroAvatar.as:640 (getFrameY) / docs/GRAPHICS.md §1'
FROM generate_series(0, 2) y, generate_series(0, 4) x
UNION ALL
SELECT 'walk'::game.avatar_action, y, x, format('W_%s_%s', x, y), NULL,
       'decompiled/m3/scripts/avatar/view/HeroAvatar.as:675 (nextFrameX) / docs/GRAPHICS.md §1'
FROM generate_series(0, 4) y, generate_series(0, 5) x;

CREATE TABLE game.battle_label_transitions (
  from_label  text NOT NULL,
  trigger     text NOT NULL,
  to_label    text NOT NULL,
  ordinal     smallint NOT NULL,
  description text,
  source_ref  text NOT NULL,
  PRIMARY KEY (from_label, trigger)
);
COMMENT ON TABLE  game.battle_label_transitions IS 'Máquina de estados dos rótulos de batalha (ActionMovie.actionAndPlay + pipeline de skill): qual rótulo toca depois de qual, e por quê.';
COMMENT ON COLUMN game.battle_label_transitions.from_label IS 'Rótulo atual (* = qualquer).';
COMMENT ON COLUMN game.battle_label_transitions.trigger IS 'Evento que dispara a troca.';
COMMENT ON COLUMN game.battle_label_transitions.to_label IS 'Rótulo seguinte.';
COMMENT ON COLUMN game.battle_label_transitions.ordinal IS 'Ordem típica dentro de um turno de ataque.';
COMMENT ON COLUMN game.battle_label_transitions.description IS 'Detalhe.';
COMMENT ON COLUMN game.battle_label_transitions.source_ref IS 'arquivo:linha.';
INSERT INTO game.battle_label_transitions VALUES
 ('Stand', 'battle_start/idle', 'Stand', 0, 'Loop de espera (REPEAT).', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:255'),
 ('Stand', 'frame_type_0_move_forward', 'Walk', 1, 'Frame tipo 0: avança até o alvo tocando Walk.', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:6'),
 ('Walk', 'frame_type_1_attack', '<attack>', 2, 'Frame tipo 1: toca o rótulo ActionInfos.Para[0] (Attack01..04, Skill...).', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:8'),
 ('Stand', 'frame_type_1_attack', '<attack>', 2, 'Skills sem avanço (à distância) atacam do lugar.', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:8'),
 ('<attack>', 'label_end', 'Stand', 3, 'WAIT_AND_GOTO: ao terminar o rótulo volta para Stand (nextType padrão).', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:186'),
 ('<attack>', 'frame_type_100_move_back', 'Walk', 4, 'Frame tipo 100: volta à posição tocando Walk, depois Stand.', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:34'),
 ('*', 'frame_type_3_damage_on_target', 'Danny', 5, 'No alvo: DannyAction.initHurt pisca e toca Danny; depois volta a Stand.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:186'),
 ('Danny', 'label_end', 'Stand', 6, 'WAIT_AND_GOTO → Stand.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:186'),
 ('*', 'hp_zero', 'Die', 7, 'Morte; segue efeito de partículas crush/cut/freeze.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:186'),
 ('*', 'battle_won (ActionId 3)', 'Victory', 8, 'SuccessSkill no fim; STOP no último quadro.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:259'),
 ('*', 'battle_lost (ActionId 4)', 'Failed', 9, 'FailedSkill no fim; STOP no último quadro.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:260'),
 ('Stand', 'ready_pose', 'Ready', 1, 'Pose de preparação (REPEAT).', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:257');

CREATE VIEW game.v_action_timelines AS
SELECT f.action_id, a.name AS action_name, a.frame_count, a.attack_times,
       row_number() OVER (PARTITION BY f.action_id ORDER BY f.row_id) AS step,
       f.frame, f.frame_type, t.name AS frame_type_name, t.label_pt AS frame_type_label,
       f.params,
       (SELECT jsonb_object_agg(coalesce(t.param_names[i], 'p' || i), f.params[i])
          FROM generate_subscripts(f.params, 1) i) AS named_params,
       CASE WHEN f.frame_type = 1 THEN f.params[1] END AS attack_label
FROM game.action_frames f
JOIN game.actions a ON a.id = f.action_id
LEFT JOIN game.action_frame_types t ON t.code = f.frame_type;
COMMENT ON VIEW game.v_action_timelines IS 'Sequência ordenada de eventos de cada ação de skill: passo, quadro, tipo, parâmetros nomeados e rótulo de ataque.';

CREATE VIEW client.v_asset_catalog AS
SELECT kind, family, count(*) AS files, sum(byte_size) AS bytes,
       count(DISTINCT owner_folder) AS owners, count(path_function) AS with_path_function,
       (array_agg(path ORDER BY path))[1:3] AS examples
FROM client.assets GROUP BY kind, family;
COMMENT ON VIEW client.v_asset_catalog IS 'Resumo do manifesto por tipo e família: arquivos, bytes, donos distintos, cobertura por função do PathManager e exemplos.';

INSERT INTO meta.schema_migrations(version, description) VALUES ('0009', 'asset catalog, swf timelines, names, animation orders') ON CONFLICT DO NOTHING;
