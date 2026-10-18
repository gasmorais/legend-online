SET search_path = game, client, raw, meta, public;

CREATE TYPE client.asset_kind AS ENUM (
  'map_avatar',
  'battle_equipment',
  'ui_show',
  'unit_movie',
  'npc',
  'skill_effect',
  'skill_name',
  'battle_map',
  'map_data',
  'map_tile',
  'map_material',
  'stage3d_texture',
  'icon',
  'image',
  'ui_module',
  'planes_war',
  'vehicle',
  'goddess',
  'audio',
  'config',
  'code_module',
  'other'
);
COMMENT ON TYPE client.asset_kind IS 'Classificação do recurso pelo prefixo de caminho; ver docs/GRAPHICS.md.';

CREATE TABLE client.assets (
  id          serial PRIMARY KEY,
  manifest    text NOT NULL CHECK (manifest IN ('res', 'code')),
  path        text NOT NULL,
  dir         text NOT NULL,
  file_name   text NOT NULL,
  ext         text NOT NULL,
  md5         char(8) NOT NULL,
  byte_size   integer NOT NULL CHECK (byte_size >= 0),
  kind        client.asset_kind NOT NULL,
  url         text NOT NULL,
  UNIQUE (manifest, path)
);
COMMENT ON TABLE  client.assets IS 'Recursos do CDN conforme o manifesto res_md5.dat/code_md5.dat (index/manifest_res.json + manifest_all.csv).';
COMMENT ON COLUMN client.assets.path IS 'Caminho lógico em minúsculas com "/" (ex.: equip/dragonic/fashion_hat_dragon_amberdream/4_0.swf).';
COMMENT ON COLUMN client.assets.dir IS 'Diretório do recurso; para avatares é a pasta da peça (ex.: swf/avatar/fashion_cloth_ballet).';
COMMENT ON COLUMN client.assets.md5 IS 'MD5 truncado (8 hex) — entra na URL real: <caminho>_<md5>.<ext>; sem ele o CDN responde 403.';
COMMENT ON COLUMN client.assets.url IS 'URL completa no CDN res1264oas.';
CREATE INDEX assets_dir_idx  ON client.assets (dir);
CREATE INDEX assets_kind_idx ON client.assets (kind);
CREATE INDEX assets_path_pattern_idx ON client.assets (path text_pattern_ops);

CREATE TABLE client.opcodes (
  direction  text NOT NULL CHECK (direction IN ('send', 'accept')),
  code       integer NOT NULL,
  name       text NOT NULL,
  PRIMARY KEY (direction, code, name)
);
COMMENT ON TABLE  client.opcodes IS 'Opcodes do socket TCP :5004 (ProtocolType.as). send = cliente→servidor; accept = servidor→cliente. Ver protocol/socket.md.';
COMMENT ON COLUMN client.opcodes.code IS 'Código numérico no cabeçalho do pacote (decimal).';
CREATE INDEX opcodes_name_idx ON client.opcodes (name);

CREATE TABLE client.proto_messages (
  name     text PRIMARY KEY,
  package  text NOT NULL,
  fqcn     text GENERATED ALWAYS AS ('com.road.yishi.proto.' || package || '.' || name) STORED
);
COMMENT ON TABLE  client.proto_messages IS 'Mensagens protobuf do payload do socket (com.road.yishi.proto.*), 1423 no total. Ver protocol/proto.md.';
COMMENT ON COLUMN client.proto_messages.package IS 'Área/pacote (battle, pet, consortia...).';

CREATE TABLE client.proto_fields (
  message_name text NOT NULL REFERENCES client.proto_messages(name) ON DELETE CASCADE,
  field_number integer NOT NULL,
  name         text NOT NULL,
  proto_type   text NOT NULL,
  wire_type    smallint NOT NULL,
  is_repeated  boolean NOT NULL,
  PRIMARY KEY (message_name, field_number)
);
COMMENT ON TABLE  client.proto_fields IS 'Campos de cada mensagem protobuf (número, tipo, wire type, repeated).';
COMMENT ON COLUMN client.proto_fields.proto_type IS 'Tipo protobuf (INT32, STRING, MESSAGE...). Para MESSAGE o tipo concreto não foi preservado no descritor decompilado.';

CREATE TABLE client.opcode_messages (
  direction    text NOT NULL CHECK (direction IN ('send', 'accept')),
  code         integer NOT NULL,
  message_name text NOT NULL REFERENCES client.proto_messages(name) ON DELETE CASCADE,
  handler      text,
  source_ref   text NOT NULL,
  PRIMARY KEY (direction, code, message_name, source_ref)
);
COMMENT ON TABLE client.opcode_messages IS 'Associação opcode → mensagem protobuf inferida do código (envio em SocketSendManager / leitura nos handlers).';

CREATE TABLE client.localized_texts (
  key     text NOT NULL,
  locale  text NOT NULL DEFAULT 'pt_BR',
  text    text NOT NULL,
  PRIMARY KEY (key, locale)
);
COMMENT ON TABLE client.localized_texts IS 'Textos de UI (ui/zh_cn/language.txt servido em pt-BR; index/language.json): chave → texto.';

CREATE TABLE client.screens (
  class_name  text PRIMARY KEY,
  kind        text NOT NULL,
  module      text NOT NULL,
  title_pt    text,
  extends     text[] NOT NULL DEFAULT '{}',
  subviews    text[] NOT NULL DEFAULT '{}',
  swfs        text[] NOT NULL DEFAULT '{}',
  size        text,
  stats       jsonb
);
COMMENT ON TABLE  client.screens IS 'Telas compostas (frames/views) do cliente com título pt-BR; ver docs/SCREENS.md e index/screens.json.';
COMMENT ON COLUMN client.screens.module IS 'Módulo do cliente (core_module, m3..m18).';

CREATE TABLE client.ui_styles (
  style_name text PRIMARY KEY,
  file       text NOT NULL,
  source_swf text,
  tag        text NOT NULL,
  attrs      jsonb NOT NULL DEFAULT '{}'
);
COMMENT ON TABLE  client.ui_styles IS 'Estilos PickGliss (XML de UI): componentes, TextFormats, bitmapData; ver docs/UI.md e index/styles.json.';
CREATE INDEX ui_styles_class_idx ON client.ui_styles ((attrs->>'classname'));

CREATE TABLE client.url_bases (
  key   text PRIMARY KEY,
  value text NOT NULL
);
COMMENT ON TABLE client.url_bases IS 'Bases de URL de raw/config.xml: {RES}, {TPL}, {REQ}, {AMF}, {SOCKET}...';

CREATE TABLE client.url_templates (
  function_name text NOT NULL,
  variant       smallint NOT NULL,
  args          jsonb NOT NULL DEFAULT '{}',
  template      text NOT NULL,
  base          text,
  manifest_hits integer,
  examples      text[] NOT NULL DEFAULT '{}',
  PRIMARY KEY (function_name, variant)
);
COMMENT ON TABLE client.url_templates IS 'Funções do PathManager que montam URLs de recursos (template com {RES}/{TPL} e parâmetros); ver routes/routes.md.';

CREATE TABLE client.http_endpoints (
  path        text PRIMARY KEY,
  source_refs text[] NOT NULL DEFAULT '{}'
);
COMMENT ON TABLE client.http_endpoints IS 'Endpoints HTTP sob {REQ} usados pelo cliente (login, listas, verificação de nome...).';

INSERT INTO meta.schema_migrations(version, description) VALUES ('0002', 'client artifacts') ON CONFLICT DO NOTHING;
