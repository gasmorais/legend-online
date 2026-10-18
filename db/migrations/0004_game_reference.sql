SET search_path = game, client, raw, meta, public;

CREATE TABLE game.jobs (
  id                  smallint PRIMARY KEY,
  code                text NOT NULL UNIQUE,
  name_pt             text NOT NULL,
  short_label_pt      text,
  avatar_default_dir  text,
  battle_default_dir  text,
  sitdown_body        text,
  is_playable         boolean NOT NULL DEFAULT true,
  source_ref          text NOT NULL
);
COMMENT ON TABLE  game.jobs IS 'Classes (JobType). 1 guerreiro, 2 caçador (arqueiro), 3 mago (feiticeiro), 4 draconiano; 0 = sem restrição; 100 = recém-chegado/"misterioso" (antes de escolher classe).';
COMMENT ON COLUMN game.jobs.avatar_default_dir IS 'Prefixo das peças default de mapa (.bswf): <prefixo>body, <prefixo>arms, <prefixo>hairUp...; ver JobType.getDefaultBodyEquipNameByJob.';
COMMENT ON COLUMN game.jobs.battle_default_dir IS 'Prefixo das peças default de batalha: equip/<dir>_<parte>/<sexo>.swf (PathManager.solveRoleDefaultPath).';
COMMENT ON COLUMN game.jobs.sitdown_body IS 'Corpo usado quando o herói está sentado (JobType.getSitDownBodyEquipNameBtJob).';

INSERT INTO game.jobs VALUES
 (0,   'unrestricted', 'Sem restrição', 'S/ Restrição', NULL, NULL, NULL, false, 'decompiled/core_module/scripts/yishi/datas/consant/JobType.as:8'),
 (1,   'warrior',  'Guerreiro',  'Gue.', '/warrior_default_', 'warrior_default', '/warrior_sitdown_body', true, 'decompiled/core_module/scripts/yishi/datas/consant/JobType.as:12'),
 (2,   'hunter',   'Caçador',    'Arq.', '/hunter_default_',  'hunter_default',  '/sword_sitdown_body',   true, 'decompiled/core_module/scripts/yishi/datas/consant/JobType.as:14'),
 (3,   'wizard',   'Mago',       'Fei.', '/wizard_default_',  'wizard_default',  '/wizard_sitdown_body',  true, 'decompiled/core_module/scripts/yishi/datas/consant/JobType.as:16'),
 (4,   'dragonman','Draconiano', NULL,   '/dragonic/dragonman_default_', 'dragonic/dragonman_default', NULL, true, 'decompiled/core_module/scripts/yishi/datas/consant/JobType.as:18'),
 (100, 'newcomer', 'Misterioso', 'Mestirioso', NULL, 'mystery_default', NULL, false, 'decompiled/core_module/scripts/yishi/datas/consant/JobType.as:10');

CREATE TABLE game.sexes (
  id        smallint PRIMARY KEY,
  code      text NOT NULL UNIQUE,
  label_pt  text NOT NULL,
  source_ref text NOT NULL
);
COMMENT ON TABLE game.sexes IS 'Sexo (SexType.getSexDescript): 0 feminino, 1 masculino, 2 sem restrição. Nos recursos de avatar o sufixo _<sexo> usa 0/1.';
INSERT INTO game.sexes VALUES
 (0, 'female', 'Feminino', 'decompiled/core_module/scripts/yishi/datas/consant/SexType.as:16'),
 (1, 'male', 'Masculino', 'decompiled/core_module/scripts/yishi/datas/consant/SexType.as:18'),
 (2, 'any', 'Sem restrição', 'decompiled/core_module/scripts/yishi/datas/consant/SexType.as:20');

CREATE TYPE game.stat_category AS ENUM ('primary', 'combat', 'resistance', 'special');
CREATE TABLE game.stat_types (
  code          text PRIMARY KEY,
  template_attr text NOT NULL UNIQUE,
  category      game.stat_category NOT NULL,
  label_pt      text NOT NULL,
  description   text,
  source_ref    text
);
COMMENT ON TABLE  game.stat_types IS 'Catálogo dos atributos que aparecem como colunas em heróis, pawns, itens, montarias, coleções etc. code = nome da coluna nas tabelas game.*';
COMMENT ON COLUMN game.stat_types.template_attr IS 'Nome do atributo XML nos templates (Attack, Live, ForceHit...).';

CREATE TYPE game.avatar_layer AS ENUM ('body', 'arms', 'hair_up', 'hair_down', 'cloak', 'wing', 'mount', 'mount_wing', 'pet');
CREATE TYPE game.avatar_action AS ENUM ('stand', 'walk');

CREATE TABLE game.avatar_layers (
  layer          game.avatar_layer PRIMARY KEY,
  code_name      text NOT NULL,
  label_pt       text NOT NULL,
  map_path_rule  text NOT NULL,
  battle_part    text,
  show_order     smallint,
  has_mount_variant boolean NOT NULL DEFAULT false,
  source_ref     text NOT NULL
);
COMMENT ON TABLE  game.avatar_layers IS 'Camadas que compõem o herói no mapa/cidade (AvatarPosition.as) e suas regras de recurso. Ver docs/GRAPHICS.md §1.';
COMMENT ON COLUMN game.avatar_layers.code_name IS 'Constante usada no código (body, army, hairUp, hairDown, cloak, wing, mount, mountWing, pet).';
COMMENT ON COLUMN game.avatar_layers.map_path_rule IS 'Como o .bswf é resolvido: swf/avatar<res>/<sexo>.bswf (equipamento), <job>_<sexo>.bswf (moda/asa), 2.bswf (montaria/pet).';
COMMENT ON COLUMN game.avatar_layers.battle_part IS 'Parte correspondente no MovieClip de batalha (HeroMovieClip: cloak1/2, arms/arms2, hair1..4, body, mount).';
COMMENT ON COLUMN game.avatar_layers.show_order IS 'Ordem de desenho no avatar "show" de UI (ShowAvatar.as:110-178), de trás para frente.';
COMMENT ON COLUMN game.avatar_layers.has_mount_variant IS 'Montado sem pose em pé (MountTempInfo.IsStand=0) a peça troca para <peça>_mount.';

INSERT INTO game.avatar_layers VALUES
 ('body',      'body',      'Corpo/roupa',      'swf/avatar<res>/<job>_<sexo>.bswf (moda) | <sexo>.bswf (equip.)', 'body', 5, true,  'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:8'),
 ('arms',      'army',      'Arma',             'swf/avatar<res>/<job>_<sexo>.bswf | <sexo>.bswf',                  'arms, arms2', 4, true, 'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:6'),
 ('hair_up',   'hairUp',    'Cabelo (frente)',  'swf/avatar<res>/<job>_<sexo>.bswf',                                'hair1..hair4 (um SWF, ClassExport1..4)', 7, true, 'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:10'),
 ('hair_down', 'hairDown',  'Cabelo (trás)',    'swf/avatar<res>/<job>_<sexo>.bswf',                                'hair1..hair4', 1, true, 'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:12'),
 ('cloak',     'cloak',     'Capa',             'swf/avatar<res>/<job>_<sexo>.bswf',                                'cloak1, cloak2', 3, true, 'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:14'),
 ('wing',      'wing',      'Asa',              'swf/avatar<res>/<job>_<sexo>.bswf (wingAvatarResourcePath)',      'cloak1, cloak2', 2, true, 'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:16'),
 ('mount',     'mount',     'Montaria',         'swf/avatar<AvatarPath>/2.bswf',                                    'mount (só montaria dragon: equip/dragonic<AvatarPath>/2.swf)', NULL, false, 'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:18'),
 ('mount_wing','mountWing', 'Asa da montaria',  'swf/avatar<parte após | em AvatarPath>/2.bswf',                    NULL, NULL, false, 'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:20'),
 ('pet',       'pet',       'Pet seguidor',     'swf/avatar<PetAvatar>/2.bswf',                                     'pet: equip<PetAvatar>/2.swf', 8, false, 'decompiled/core_module/scripts/avatar/data/AvatarPosition.as:22');

CREATE TABLE game.avatar_layer_z_orders (
  layer      game.avatar_layer NOT NULL REFERENCES game.avatar_layers(layer),
  action     game.avatar_action NOT NULL,
  is_mounted boolean NOT NULL,
  direction  smallint NOT NULL CHECK (direction BETWEEN 0 AND 4),
  weight     smallint NOT NULL,
  source_ref text NOT NULL,
  PRIMARY KEY (layer, action, is_mounted, direction)
);
COMMENT ON TABLE  game.avatar_layer_z_orders IS 'Peso de profundidade por camada/ação/direção (AvatarStaticData.getBaseNumByType). Ordenação DESC: peso maior é desenhado primeiro (fica atrás).';
COMMENT ON COLUMN game.avatar_layer_z_orders.direction IS 'Walk: 0 baixo, 1 diagonal-baixo, 2 lado, 3 diagonal-cima, 4 cima (esquerda = espelho, scaleX=-1). Stand: 0..2 (dir 0/1→0, 2/3→1, 4→2).';

CREATE TABLE game.avatar_part_draw_orders (
  frame_prefix char(1) NOT NULL CHECK (frame_prefix IN ('S', 'W')),
  direction    smallint NOT NULL,
  part         text NOT NULL,
  is_mounted   boolean NOT NULL,
  draw_order   smallint NOT NULL,
  source_ref   text NOT NULL,
  PRIMARY KEY (frame_prefix, direction, part, is_mounted)
);
COMMENT ON TABLE game.avatar_part_draw_orders IS 'Tabela AvatarStaticData.dic: ordem fixa de partes por quadro "S_<dir>_<parte>[_mount]" / "W_..." (chaves repetidas: vale a última atribuição, semântica AS3).';

CREATE TYPE game.animation_context AS ENUM ('map_avatar', 'battle_unit', 'ui_show');
CREATE TYPE game.animation_repeat AS ENUM ('repeat', 'stop', 'wait_and_goto');

CREATE TABLE game.animation_labels (
  context     game.animation_context NOT NULL,
  label       text NOT NULL,
  label_pt    text NOT NULL,
  repeat_mode game.animation_repeat NOT NULL,
  directions  smallint,
  frames      smallint,
  next_label  text,
  description text,
  source_ref  text NOT NULL,
  PRIMARY KEY (context, label)
);
COMMENT ON TABLE  game.animation_labels IS 'Estados de animação: no mapa (.bswf com classes S_<frame>_<dir>/W_<frame>_<dir>) e em batalha (rótulos de frame do MovieClip, ActionMovie.as). Rótulos de ataque vêm de ActionInfos.Para[0] (ver game.action_frames).';
COMMENT ON COLUMN game.animation_labels.repeat_mode IS 'ActionMovie.getDefaultRepeatType: Stand/Walk/Ready = repeat; Victory/Failed = stop; demais (ataques, Danny, Die) = wait_and_goto (toca e volta para next_label).';

INSERT INTO game.animation_labels VALUES
 ('map_avatar', 'S', 'Parado (mapa)', 'repeat', 3, 5, NULL, 'Classe asset.<pasta>_<arquivo>.S_<frame>_<dir>; 3 direções (dir 0/1→0, 2/3→1, 4→2), 5 quadros.', 'decompiled/m3/scripts/avatar/view/HeroAvatar.as'),
 ('map_avatar', 'W', 'Andando (mapa)', 'repeat', 5, 6, NULL, 'Classe asset.<pasta>_<arquivo>.W_<frame>_<dir>; 5 direções, 6 quadros; esquerda espelhada.', 'decompiled/m3/scripts/avatar/view/HeroAvatar.as'),
 ('battle_unit', 'Stand',   'Parado',            'repeat', NULL, NULL, NULL, 'Pose de espera em batalha.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:255'),
 ('battle_unit', 'Walk',    'Andando',           'repeat', NULL, NULL, NULL, 'Avanço/retorno (frames tipo 0 e 100).', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:256'),
 ('battle_unit', 'Ready',   'Preparado',         'repeat', NULL, NULL, NULL, 'Pose de preparação antes de agir.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:257'),
 ('battle_unit', 'Danny',   'Levando dano',      'wait_and_goto', NULL, NULL, 'Stand', 'Tocado por DannyAction.initHurt ao receber dano.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:186'),
 ('battle_unit', 'Die',     'Morte',             'wait_and_goto', NULL, NULL, NULL, 'Morte; seguida de partículas (battle/particle crush/cut/freeze).', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:186'),
 ('battle_unit', 'Victory', 'Vitória',           'stop', NULL, NULL, NULL, 'SuccessSkill (ActionId 3) no fim da batalha.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:259'),
 ('battle_unit', 'Failed',  'Derrota',           'stop', NULL, NULL, NULL, 'FailedSkill (ActionId 4) no fim da batalha.', 'decompiled/core_module/scripts/yishi/view/tools/ActionMovie.as:260'),
 ('battle_unit', '<attack>','Ataque (rótulo da ação)', 'wait_and_goto', NULL, NULL, 'Stand', 'Rótulo vindo de ActionInfos.Para[0] no frame de ActionType 1 (ex.: Attack01, Attack02, Skill01).', 'decompiled/core_module/scripts/yishi/resolve/ActionTemplateInfoResolveII.as'),
 ('ui_show', 'front', 'Frente (UI)', 'repeat', NULL, NULL, NULL, 'Pasta /front/ do SWF equip_show; ordem: backHair, wing, backCloak, arms, body, frontCloak, frontHair, pet.', 'decompiled/core_module/scripts/avatar/view/ShowAvatar.as:110'),
 ('ui_show', 'back',  'Costas (UI)', 'repeat', NULL, NULL, NULL, 'Pasta /back/ do SWF equip_show.', 'decompiled/core_module/scripts/avatar/view/ShowAvatar.as:110');

CREATE TABLE game.battle_movie_parts (
  part        text PRIMARY KEY,
  stack_order smallint NOT NULL UNIQUE,
  layer       game.avatar_layer REFERENCES game.avatar_layers(layer),
  class_export text NOT NULL,
  source_ref  text NOT NULL
);
COMMENT ON TABLE  game.battle_movie_parts IS 'Partes empilhadas do herói em batalha (HeroMovieClip.as:112-121), de trás (1) para frente. Todas tocam o mesmo rótulo sincronizadas; âncoras pos_head/pos_body/pos_leg/shadow.';
COMMENT ON COLUMN game.battle_movie_parts.class_export IS 'Classe exportada usada do SWF: índice 0 → ClassExport, n → ClassExport<n> (cabelo: um SWF com 4 camadas).';
INSERT INTO game.battle_movie_parts VALUES
 ('cloak2', 1, 'cloak', 'ClassExport2', 'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:112'),
 ('mount',  2, 'mount', 'ClassExport',  'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:113'),
 ('arms2',  3, 'arms',  'ClassExport2', 'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:114'),
 ('hair4',  4, 'hair_down', 'ClassExport4', 'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:115'),
 ('hair3',  5, 'hair_down', 'ClassExport3', 'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:116'),
 ('body',   6, 'body',  'ClassExport',  'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:117'),
 ('hair2',  7, 'hair_up', 'ClassExport2', 'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:118'),
 ('arms',   8, 'arms',  'ClassExport1', 'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:119'),
 ('hair1',  9, 'hair_up', 'ClassExport1', 'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:120'),
 ('cloak1', 10, 'cloak', 'ClassExport1', 'decompiled/core_module/scripts/yishi/view/tools/HeroMovieClip.as:121');

CREATE TABLE game.battle_grid_positions (
  side       smallint NOT NULL CHECK (side IN (1, 2)),
  position   smallint NOT NULL CHECK (position BETWEEN 1 AND 12),
  grid_row   smallint NOT NULL,
  grid_col   smallint NOT NULL,
  x          integer NOT NULL,
  y          integer NOT NULL,
  is_front   boolean NOT NULL,
  source_ref text NOT NULL,
  PRIMARY KEY (side, position)
);
COMMENT ON TABLE  game.battle_grid_positions IS 'Grade 3×4 de posições de unidades em batalha (BattleUtils.get9GridPos + rolePointByPos). Lado 1 = esquerda (o próprio, quando selfSide=1).';
COMMENT ON COLUMN game.battle_grid_positions.grid_row IS 'Fila (0..3) = (pos-1)/3; cada fila desce 60 px e recua 40 px em x.';
COMMENT ON COLUMN game.battle_grid_positions.grid_col IS 'Índice de coluna no array (0..2) após o mapeamento de rolePointByPos.';
COMMENT ON COLUMN game.battle_grid_positions.is_front IS 'Posições 1,4,7,10 ficam na coluna mais próxima do centro (linha de frente).';

INSERT INTO game.battle_grid_positions
SELECT s, p, (p - 1) / 3,
       CASE WHEN s = 1 THEN 2 - (p - 1) % 3 ELSE (p - 1) % 3 END,
       CASE WHEN s = 1 THEN (2 - (p - 1) % 3) * 150 + 295 - 40 * ((p - 1) / 3)
            ELSE ((p - 1) % 3) * 150 + 905 + 40 * ((p - 1) / 3) END,
       570 + 60 * ((p - 1) / 3),
       (p - 1) % 3 = 0,
       'decompiled/core_module/scripts/battle/utils/BattleUtils.as:124'
FROM generate_series(1, 2) s, generate_series(1, 12) p;

INSERT INTO meta.schema_migrations(version, description) VALUES ('0004', 'game reference tables') ON CONFLICT DO NOTHING;
