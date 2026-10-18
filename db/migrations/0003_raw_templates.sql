SET search_path = game, client, raw, meta, public;

CREATE TABLE raw.template_sets (
  id            serial PRIMARY KEY,
  name          text NOT NULL UNIQUE,
  root_element  text NOT NULL,
  item_elements text[] NOT NULL DEFAULT '{}',
  record_count  integer NOT NULL DEFAULT 0,
  xml_bytes     integer NOT NULL DEFAULT 0,
  load_order    integer NOT NULL,
  mechanic_code text REFERENCES meta.mechanics(code) ON DELETE SET NULL,
  semantic_table text,
  description   text,
  source_ref    text
);
COMMENT ON TABLE  raw.template_sets IS 'Cada lista de templates dentro de tempinfos.xml (292 no total), na ordem do arquivo.';
COMMENT ON COLUMN raw.template_sets.name IS 'Nome do registro no binário (ex.: SkillTempInfos, MountTempInfos).';
COMMENT ON COLUMN raw.template_sets.item_elements IS 'Nome(s) dos elementos-filho (ex.: SkillTempInfo).';
COMMENT ON COLUMN raw.template_sets.semantic_table IS 'Tabela do schema game que modela esta lista (quando existe).';
COMMENT ON COLUMN raw.template_sets.source_ref IS 'Onde o cliente resolve a lista (TempleteManager / yishi/resolve/*).';

CREATE TABLE raw.template_fields (
  set_id          integer NOT NULL REFERENCES raw.template_sets(id) ON DELETE CASCADE,
  attribute       text NOT NULL,
  position        integer NOT NULL,
  inferred_type   text NOT NULL CHECK (inferred_type IN ('int', 'bigint', 'numeric', 'text')),
  present_count   integer NOT NULL,
  distinct_count  integer NOT NULL,
  sample          text,
  description     text,
  enum_name       text REFERENCES meta.enum_types(name) ON DELETE SET NULL,
  references_field text,
  semantic_column text,
  source_ref      text,
  PRIMARY KEY (set_id, attribute)
);
COMMENT ON TABLE  raw.template_fields IS 'Atributos XML de cada lista, com tipo inferido, cardinalidade, exemplo e semântica mapeada do código.';
COMMENT ON COLUMN raw.template_fields.references_field IS 'Quando o campo é id de outro template: TemplateSet.Field alvo.';
COMMENT ON COLUMN raw.template_fields.semantic_column IS 'Coluna correspondente no schema game (tabela.coluna).';

CREATE TABLE raw.template_records (
  id          bigserial PRIMARY KEY,
  set_id      integer NOT NULL REFERENCES raw.template_sets(id) ON DELETE CASCADE,
  ordinal     integer NOT NULL,
  element     text NOT NULL,
  record_key  text,
  attrs       jsonb NOT NULL,
  children    jsonb,
  UNIQUE (set_id, ordinal)
);
COMMENT ON TABLE  raw.template_records IS 'Todo registro de todo template (atributos como strings em JSONB, exatamente como no XML).';
COMMENT ON COLUMN raw.template_records.record_key IS 'Valor do id principal do registro (TemplateId/Id/ID/... quando existe) para busca rápida.';
COMMENT ON COLUMN raw.template_records.children IS 'Sub-elementos aninhados (apenas listas como GuardPVETemp).';
CREATE INDEX template_records_key_idx   ON raw.template_records (set_id, record_key);
CREATE INDEX template_records_attrs_idx ON raw.template_records USING gin (attrs jsonb_path_ops);

INSERT INTO meta.schema_migrations(version, description) VALUES ('0003', 'raw templates') ON CONFLICT DO NOTHING;
