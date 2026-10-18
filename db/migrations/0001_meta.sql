CREATE SCHEMA IF NOT EXISTS meta;
CREATE SCHEMA IF NOT EXISTS client;
CREATE SCHEMA IF NOT EXISTS raw;
CREATE SCHEMA IF NOT EXISTS game;

COMMENT ON SCHEMA meta   IS 'Metadados: migrations, fontes de dados, problemas de carga, enums documentados, catálogo de mecânicas e fórmulas.';
COMMENT ON SCHEMA client IS 'Artefatos técnicos do cliente Flash/AIR: recursos do CDN, opcodes, mensagens protobuf, textos pt-BR, telas, estilos de UI, rotas.';
COMMENT ON SCHEMA raw    IS 'Templates de jogo brutos de {TPL}tempinfos.xml: todo registro de todo template, sem perda (atributos em JSONB).';
COMMENT ON SCHEMA game   IS 'Modelo semântico das mecânicas: heróis, unidades, skills, buffs, itens, modas, montarias, pets, filhos, deusas, mundo, missões, lojas...';

DO $$ BEGIN
  EXECUTE format('ALTER DATABASE %I SET search_path = game, client, raw, meta, public', current_database());
END $$;
SET search_path = game, client, raw, meta, public;

CREATE TABLE meta.schema_migrations (
  version     text PRIMARY KEY,
  description text NOT NULL,
  applied_at  timestamptz NOT NULL DEFAULT now()
);
COMMENT ON TABLE meta.schema_migrations IS 'Migrations aplicadas (cada arquivo db/migrations/NNNN_*.sql se registra no fim; tools/db/migrate.py pula as já registradas).';

CREATE TABLE meta.data_sources (
  id           serial PRIMARY KEY,
  name         text NOT NULL UNIQUE,
  kind         text NOT NULL CHECK (kind IN ('server_xml', 'cdn_manifest', 'decompiled_code', 'project_index', 'research')),
  location     text NOT NULL,
  version      text,
  sha256       text,
  byte_size    bigint,
  loaded_at    timestamptz NOT NULL DEFAULT now(),
  notes        text
);
COMMENT ON TABLE  meta.data_sources IS 'Proveniência: cada arquivo/fonte carregado (URL original ou caminho local), com versão e hash.';
COMMENT ON COLUMN meta.data_sources.kind IS 'server_xml = baixado de {TPL}; cdn_manifest = res_md5.dat; decompiled_code = AS3; project_index = JSON de index/ ou protocol/; research = mapeamentos manuais em data/research.';
COMMENT ON COLUMN meta.data_sources.version IS 'Versão declarada pela fonte (ex.: uint de cabeçalho do tempinfos.xml).';

CREATE TABLE meta.load_issues (
  id          bigserial PRIMARY KEY,
  table_name  text NOT NULL,
  column_name text,
  record_key  text,
  value       text,
  issue       text NOT NULL,
  logged_at   timestamptz NOT NULL DEFAULT now()
);
COMMENT ON TABLE meta.load_issues IS 'Inconsistências encontradas ao popular o modelo semântico (ex.: referência a template inexistente → coluna FK gravada NULL, valor original mantido aqui e em raw.template_records).';

CREATE TABLE meta.enum_types (
  name           text PRIMARY KEY,
  description    text,
  source_ref     text,
  applies_to     text[] NOT NULL DEFAULT '{}'
);
COMMENT ON TABLE  meta.enum_types IS 'Códigos numéricos usados pelos templates/protocolo (ex.: job, sexo, tipo de frame de ação), mapeados a partir do código AS3.';
COMMENT ON COLUMN meta.enum_types.applies_to IS 'Campos de template onde o código aparece, no formato TemplateSet.Field.';
COMMENT ON COLUMN meta.enum_types.source_ref IS 'Arquivo:linha no código decompilado onde o enum está definido/usado.';

CREATE TABLE meta.enum_values (
  enum_name   text NOT NULL REFERENCES meta.enum_types(name) ON DELETE CASCADE,
  code        bigint NOT NULL,
  name        text NOT NULL,
  label_pt    text,
  note        text,
  source_ref  text,
  PRIMARY KEY (enum_name, code)
);
COMMENT ON TABLE  meta.enum_values IS 'Valores de cada enum: código → nome semântico em inglês + rótulo pt-BR.';
COMMENT ON COLUMN meta.enum_values.name IS 'Nome semântico em inglês snake_case.';

CREATE TYPE meta.mechanic_category AS ENUM (
  'unit', 'combat', 'skill', 'item', 'avatar', 'companion', 'progression',
  'economy', 'pve', 'pvp', 'guild', 'social', 'event', 'system'
);

CREATE TABLE meta.mechanics (
  code        text PRIMARY KEY,
  name_pt     text NOT NULL,
  category    meta.mechanic_category NOT NULL,
  summary_pt  text,
  modules     text[] NOT NULL DEFAULT '{}',
  source_ref  text,
  doc_anchor  text,
  parent_code text REFERENCES meta.mechanics(code) ON DELETE SET NULL
);
COMMENT ON TABLE  meta.mechanics IS 'Catálogo de mecânicas/sistemas de jogo documentados em docs/MECHANICS.md (mecânicas principais) e docs/mechanics/*.md (subsistemas, com parent_code).';
COMMENT ON COLUMN meta.mechanics.parent_code IS 'Mecânica principal à qual um subsistema pertence (ex.: ring_task → quest).';
COMMENT ON COLUMN meta.mechanics.code IS 'Identificador semântico em inglês (ex.: fashion, mount, pet, war_soul).';
COMMENT ON COLUMN meta.mechanics.modules IS 'Módulos do cliente onde a mecânica vive (core_module, m3..m18).';
COMMENT ON COLUMN meta.mechanics.doc_anchor IS 'Âncora da seção em docs/MECHANICS.md.';

CREATE TABLE meta.mechanic_links (
  mechanic_code text NOT NULL REFERENCES meta.mechanics(code) ON DELETE CASCADE,
  target_kind   text NOT NULL CHECK (target_kind IN ('template_set', 'table', 'opcode', 'proto_message', 'screen', 'asset_prefix')),
  target        text NOT NULL,
  PRIMARY KEY (mechanic_code, target_kind, target)
);
COMMENT ON TABLE meta.mechanic_links IS 'Liga cada mecânica aos templates, tabelas do banco, opcodes, mensagens protobuf, telas e prefixos de recursos relacionados.';

CREATE TABLE meta.formulas (
  name        text PRIMARY KEY,
  mechanic    text REFERENCES meta.mechanics(code) ON DELETE SET NULL,
  expression  text NOT NULL,
  description text,
  source_ref  text
);
COMMENT ON TABLE meta.formulas IS 'Fórmulas de jogo extraídas do código (dano, atributos derivados, posições na grade, etc.).';

INSERT INTO meta.schema_migrations(version, description) VALUES ('0001', 'meta schemas') ON CONFLICT DO NOTHING;
