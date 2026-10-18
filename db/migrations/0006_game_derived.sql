SET search_path = game, client, raw, meta, public;

INSERT INTO game.jobs VALUES
 (10, 'npc', 'NPC/monstro', NULL, NULL, NULL, NULL, false, 'data: GameHeroTemp.Job=10 em 7241 heróis NPC (sem constante em JobType.as)'),
 (99, 'dragon_talker_gear', 'Equipamento/moda do Domador de Dragões', NULL, NULL, NULL, NULL, false, 'data: ItemTempInfos.Job=99 (ver data/research/items_avatar.md)')
ON CONFLICT DO NOTHING;

CREATE TABLE game.skill_buff_links (
  skill_id integer NOT NULL REFERENCES game.skills(id) ON DELETE CASCADE,
  ordinal  smallint NOT NULL,
  buff_id  integer NOT NULL REFERENCES game.buffs(id),
  PRIMARY KEY (skill_id, ordinal)
);
COMMENT ON TABLE game.skill_buff_links IS 'Buffs aplicados por cada skill (SkillTempInfos.BufferIds normalizado; ids inexistentes vão para meta.load_issues).';
CREATE INDEX ON game.skill_buff_links (buff_id);

CREATE TABLE game.hero_ai_soldiers (
  ai_id    integer NOT NULL REFERENCES game.hero_ais(id) ON DELETE CASCADE,
  ordinal  smallint NOT NULL,
  pawn_id  integer REFERENCES game.pawns(id),
  position smallint NOT NULL CHECK (position BETWEEN 1 AND 12),
  PRIMARY KEY (ai_id, ordinal)
);
COMMENT ON TABLE game.hero_ai_soldiers IS 'Tropas que acompanham um herói NPC/boss (HeroAis.Soldiers "pawnId,pos|..."); position = posição na grade (game.battle_grid_positions).';

CREATE TYPE game.pet_skill_role AS ENUM ('follow', 'change', 'default');
CREATE TABLE game.pet_skill_links (
  pet_id   integer NOT NULL REFERENCES game.pets(id) ON DELETE CASCADE,
  role     game.pet_skill_role NOT NULL,
  ordinal  smallint NOT NULL,
  skill_id integer NOT NULL,
  skill_exists boolean NOT NULL,
  PRIMARY KEY (pet_id, role, ordinal)
);
COMMENT ON TABLE  game.pet_skill_links IS 'Skills do pet: follow = skills ao acompanhar o herói; change = skills na forma transformada/batalha; default = ataque básico.';
COMMENT ON COLUMN game.pet_skill_links.skill_exists IS 'false quando o id não existe em SkillTempInfos (skills de pet podem ser resolvidas por son_type).';

CREATE TABLE game.item_suite_pieces (
  suite_id     integer NOT NULL REFERENCES game.item_suites(id) ON DELETE CASCADE,
  slot         smallint NOT NULL CHECK (slot BETWEEN 1 AND 8),
  is_alternate boolean NOT NULL,
  item_id      integer NOT NULL,
  item_exists  boolean NOT NULL,
  PRIMARY KEY (suite_id, slot, is_alternate)
);
COMMENT ON TABLE game.item_suite_pieces IS 'Peças de cada conjunto (Template1..8 e variantes Template1s..8s).';

CREATE TABLE game.recipe_materials (
  recipe_kind text NOT NULL CHECK (recipe_kind IN ('compose', 'transform', 'resolve_output')),
  recipe_id   integer NOT NULL,
  slot        smallint NOT NULL,
  item_id     integer NOT NULL,
  quantity    integer,
  item_exists boolean NOT NULL,
  PRIMARY KEY (recipe_kind, recipe_id, slot)
);
COMMENT ON TABLE game.recipe_materials IS 'Materiais normalizados: compose = ComposeTempInfos (Material/Count), transform = TransformInfos, resolve_output = itens obtidos ao decompor (ItemResolveTemplates).';
CREATE INDEX ON game.recipe_materials (item_id);

CREATE TABLE game.item_categories (
  master_type   integer NOT NULL,
  son_type      integer NOT NULL,
  code          text NOT NULL,
  label_pt      text,
  system        text,
  avatar_layer  game.avatar_layer,
  property_semantics text,
  item_count    integer NOT NULL DEFAULT 0,
  source_ref    text,
  PRIMARY KEY (master_type, son_type)
);
COMMENT ON TABLE  game.item_categories IS 'Categorias de item (MasterType × SonType) com sistema dono, camada de avatar (para equipamentos/modas) e semântica de Property1..7.';
COMMENT ON COLUMN game.item_categories.system IS 'equipment, fashion, consumable, material, gem, mount, pet, currency...';

CREATE TABLE game.fashion_items (
  item_id     integer PRIMARY KEY REFERENCES game.items(id) ON DELETE CASCADE,
  layer       game.avatar_layer NOT NULL,
  son_type    integer NOT NULL,
  avatar_path text NOT NULL,
  map_dir_hint text NOT NULL,
  has_map_assets boolean NOT NULL,
  has_battle_assets boolean NOT NULL,
  has_show_assets boolean NOT NULL
);
COMMENT ON TABLE  game.fashion_items IS 'Itens de moda (ItemTempInfos MasterType 1, SonType 109 asa, 110 chapéu/cabelo, 111 arma, 112 roupa) e a camada de avatar que substituem.';
COMMENT ON COLUMN game.fashion_items.map_dir_hint IS 'Pasta .bswf esperada no mapa (chapéus usam <path>up/<path>down → hair_up/hair_down; montado sem IsStand usa sufixo _mount).';
COMMENT ON COLUMN game.fashion_items.has_map_assets IS 'Existe ao menos um recurso swf/avatar<path>* no manifesto (o manifesto é parcial).';

CREATE TYPE game.avatar_owner_kind AS ENUM ('item', 'mount', 'mount_wing', 'pet', 'child', 'dragon_mount', 'monster', 'pawn', 'hero_npc', 'vehicle');
CREATE TYPE game.resource_context AS ENUM ('map', 'battle', 'show', 'icon');

CREATE TABLE game.avatar_resource_dirs (
  owner_kind  game.avatar_owner_kind NOT NULL,
  owner_id    integer NOT NULL,
  context     game.resource_context NOT NULL,
  variant     text NOT NULL,
  dir         text NOT NULL,
  asset_count integer NOT NULL,
  files       text[] NOT NULL,
  PRIMARY KEY (owner_kind, owner_id, dir)
);
COMMENT ON TABLE  game.avatar_resource_dirs IS 'Pastas do CDN (client.assets.dir) que contêm a arte de cada dono: map = .bswf de mapa (S_/W_), battle = MovieClip com rótulos Stand/Walk/..., show = avatar de UI front/back.';
COMMENT ON COLUMN game.avatar_resource_dirs.variant IS 'normal, mount (peça _mount usada montado), up/down (metades de cabelo/chapéu), dragonic (versão draconiana 4_x), front/back (show).';
COMMENT ON COLUMN game.avatar_resource_dirs.files IS 'Arquivos da pasta: <job>_<sexo>.bswf|swf para modas, <sexo>.swf para equipamentos, 2.bswf/2.swf para montarias/pets/filhos.';
CREATE INDEX ON game.avatar_resource_dirs (dir);

CREATE TABLE game.mount_animations (
  mount_id    integer NOT NULL REFERENCES game.mounts(id) ON DELETE CASCADE,
  context     game.resource_context NOT NULL,
  state       text NOT NULL,
  layer       game.avatar_layer NOT NULL,
  resource    text NOT NULL,
  frame_class_pattern text,
  directions  smallint,
  frames      smallint,
  asset_id    integer REFERENCES client.assets(id),
  PRIMARY KEY (mount_id, context, state, layer)
);
COMMENT ON TABLE  game.mount_animations IS 'Animações de cada montaria: no mapa parado (S, 3 direções × 5 quadros) e andando (W, 5 direções × 6 quadros) para corpo e asa; em batalha só a montaria dragão (equip/dragonic<path>/2.swf, rótulos de batalha).';
COMMENT ON COLUMN game.mount_animations.frame_class_pattern IS 'Classe BitmapData de cada quadro dentro do .bswf: asset.<pasta>_2.S_<frame>_<dir> / .W_<frame>_<dir>.';
COMMENT ON COLUMN game.mount_animations.asset_id IS 'Recurso no manifesto, quando presente (o manifesto é parcial).';

CREATE TYPE game.visual_effect_kind AS ENUM ('skill_effect', 'hit_effect', 'projectile', 'dust', 'buff_effect', 'other');
CREATE TABLE game.visual_effects (
  name        text PRIMARY KEY,
  kind        game.visual_effect_kind NOT NULL,
  swf_path    text NOT NULL,
  asset_id    integer REFERENCES client.assets(id),
  usage_count integer NOT NULL DEFAULT 0
);
COMMENT ON TABLE  game.visual_effects IS 'Efeitos visuais referenciados por frames de ação e buffs. Nome = nome de link da classe; arquivo = skillEffect/<nome com . → _>.swf (SkillResourceLoader.as:182-187); skill_public.swf é sempre carregado.';

CREATE TABLE game.action_frame_effects (
  action_frame_row_id integer NOT NULL REFERENCES game.action_frames(row_id) ON DELETE CASCADE,
  param_index smallint NOT NULL,
  effect_name text NOT NULL REFERENCES game.visual_effects(name),
  PRIMARY KEY (action_frame_row_id, param_index)
);
COMMENT ON TABLE game.action_frame_effects IS 'Qual parâmetro de qual frame de ação referencia qual efeito visual.';
CREATE INDEX ON game.action_frame_effects (effect_name);

CREATE TABLE game.action_frame_types (
  code        smallint PRIMARY KEY,
  name        text NOT NULL,
  label_pt    text NOT NULL,
  param_names text[] NOT NULL DEFAULT '{}',
  description text,
  source_ref  text
);
COMMENT ON TABLE  game.action_frame_types IS 'Tipos de evento de frame (SkillFrameType) e o layout do CSV Para de cada tipo.';

INSERT INTO game.action_frame_types(code, name, label_pt, param_names, source_ref) VALUES
 (-1, 'none', 'Nenhum', '{}', 'data: ActionInfos com ActionType=-1'),
 (0, 'move_forward', 'Avançar até o alvo', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:6'),
 (1, 'play_attack_action', 'Tocar rótulo de ataque', '{label}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:8'),
 (2, 'add_release_effect', 'Efeito de lançamento', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:10'),
 (3, 'add_damage', 'Aplicar dano (Danny)', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:12'),
 (4, 'zoom', 'Zoom de câmera', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:14'),
 (5, 'gas_effect', 'Efeito de "gás" (camada de efeito)', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:16'),
 (6, 'background_color', 'Cor do fundo', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:18'),
 (7, 'background_shake', 'Tremor de tela', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:20'),
 (11, 'shoot', 'Projétil', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:22'),
 (12, 'shoot_beam', 'Projétil 2 (raio/laser)', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:24'),
 (23, 'displacement_forward', 'Deslocamento para frente', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:26'),
 (24, 'displacement_back', 'Deslocamento para trás', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:28'),
 (25, 'hide', 'Esconder', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:30'),
 (99, 'finish', 'Fim da ação', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:32'),
 (100, 'move_back', 'Voltar à posição', '{}', 'decompiled/core_module/scripts/battle/skillsys/constants/SkillFrameType.as:34');

ALTER TABLE game.action_frames ADD CONSTRAINT action_frames_frame_type_fkey
  FOREIGN KEY (frame_type) REFERENCES game.action_frame_types(code) DEFERRABLE INITIALLY DEFERRED;

CREATE TABLE game.blood_types (
  code       smallint PRIMARY KEY,
  name       text NOT NULL,
  label_pt   text NOT NULL,
  source_ref text NOT NULL
);
COMMENT ON TABLE game.blood_types IS 'Tipos de atualização de barra em batalha (AttackData.bloodType; BloodType.as).';
INSERT INTO game.blood_types VALUES
 (6, 'hit_points', 'HP do herói/unidade', 'decompiled/core_module/scripts/battle/data/BloodType.as:8'),
 (7, 'troops', 'HP da tropa', 'decompiled/core_module/scripts/battle/data/BloodType.as:6'),
 (8, 'third_bar', 'Terceira barra', 'decompiled/core_module/scripts/battle/data/BloodType.as:10'),
 (9, 'skill_points', 'SP/Fúria', 'decompiled/core_module/scripts/battle/data/BloodType.as:12'),
 (10, 'revive', 'Reviver', 'decompiled/core_module/scripts/battle/data/BloodType.as:14'),
 (11, 'disable_skill', 'Desabilitar skill', 'decompiled/core_module/scripts/battle/data/BloodType.as:16'),
 (21, 'max_hit_points', 'HP máximo', 'decompiled/core_module/scripts/battle/data/BloodType.as:18'),
 (24, 'hit_point_counter', 'Pontos de golpe (HitPoint)', 'decompiled/core_module/scripts/battle/data/BloodType.as:20'),
 (26, 'belief', 'Crença (deusa)', 'decompiled/core_module/scripts/battle/data/BloodType.as:22');

CREATE TABLE game.drop_entries (
  row_id        serial PRIMARY KEY,
  drop_set      text NOT NULL,
  entry_id      bigint,
  drop_id       bigint,
  site          integer,
  param2        text,
  item_id       integer,
  quantity      integer,
  is_bound      boolean,
  appear_type   smallint,
  valid_days    integer,
  is_shown      boolean,
  source_record_id bigint NOT NULL REFERENCES raw.template_records(id) ON DELETE CASCADE
);
COMMENT ON TABLE  game.drop_entries IS 'Entradas de todas as listas de drop/recompensa (≈60 listas *Drop, *Reward, *DropInfo) normalizadas no esquema comum de pacote de drop.';
COMMENT ON COLUMN game.drop_entries.drop_set IS 'Lista de origem (raw.template_sets.name).';
COMMENT ON COLUMN game.drop_entries.drop_id IS 'Pacote de drop referenciado pela atividade (dropId/DropId).';
COMMENT ON COLUMN game.drop_entries.site IS 'Posição/condição dentro do pacote (significado por lista; ver data/research/world_progression.md).';
COMMENT ON COLUMN game.drop_entries.param2 IS 'Parâmetro 2 (frequentemente faixa "min,max" de rank/nível).';
COMMENT ON COLUMN game.drop_entries.item_id IS 'Item (ItemTempInfos; ids negativos = moedas virtuais).';
COMMENT ON COLUMN game.drop_entries.appear_type IS 'Modo de aparição (1 fixo, 3 raro...; enum drop_appear_type).';
CREATE INDEX ON game.drop_entries (drop_set, drop_id);
CREATE INDEX ON game.drop_entries (item_id);

INSERT INTO meta.schema_migrations(version, description) VALUES ('0006', 'game derived tables') ON CONFLICT DO NOTHING;
