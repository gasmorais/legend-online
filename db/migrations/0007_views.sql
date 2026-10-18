SET search_path = game, client, raw, meta, public;

CREATE FUNCTION meta.enum_label(p_enum text, p_code bigint) RETURNS text
LANGUAGE sql STABLE AS $$
  SELECT coalesce(label_pt, name) FROM meta.enum_values WHERE enum_name = p_enum AND code = p_code
$$;
COMMENT ON FUNCTION meta.enum_label(text, bigint) IS 'Rótulo pt-BR (ou nome) de um código de enum; NULL se desconhecido. Ex.: meta.enum_label(''skill_master_type'', 109).';

CREATE VIEW raw.v_template_coverage AS
SELECT s.load_order, s.name, s.record_count, s.mechanic_code, s.semantic_table, s.source_ref,
       count(f.attribute) AS field_count, count(f.description) AS described_fields,
       count(f.semantic_column) AS mapped_fields
FROM raw.template_sets s LEFT JOIN raw.template_fields f ON f.set_id = s.id
GROUP BY s.id ORDER BY s.load_order;
COMMENT ON VIEW raw.v_template_coverage IS 'Cobertura por lista de template: mecânica, tabela semântica, campos descritos pela pesquisa e mapeados para colunas.';

CREATE VIEW client.v_opcode_messages AS
SELECT o.direction, o.code, o.name AS opcode_name, m.message_name, p.package, m.handler, m.source_ref
FROM client.opcodes o
LEFT JOIN client.opcode_messages m ON m.direction = o.direction AND m.code = o.code
LEFT JOIN client.proto_messages p ON p.name = m.message_name;
COMMENT ON VIEW client.v_opcode_messages IS 'Opcodes com a(s) mensagem(ns) protobuf inferida(s) do código.';

CREATE VIEW game.v_skills AS
SELECT s.id, s.name, s.master_type, meta.enum_label('skill_master_type', s.master_type) AS master_type_label,
       s.son_type, s.grade, s.use_way, meta.enum_label('skill_use_way', s.use_way) AS use_way_label,
       s.target_kind, meta.enum_label('skill_accept_object', s.target_kind) AS target_label,
       s.cost, s.cooldown_ms, s.param1, s.param2, s.param3, s.description,
       s.action_id, a.name AS action_name, a.frame_count, a.attack_times,
       (SELECT array_agg(f.params[1] ORDER BY f.row_id) FROM game.action_frames f WHERE f.action_id = s.action_id AND f.frame_type = 1) AS attack_labels,
       (SELECT array_agg(DISTINCT e.effect_name) FROM game.action_frames f JOIN game.action_frame_effects e ON e.action_frame_row_id = f.row_id WHERE f.action_id = s.action_id) AS effects,
       (SELECT array_agg(b.name ORDER BY l.ordinal) FROM game.skill_buff_links l JOIN game.buffs b ON b.id = l.buff_id WHERE l.skill_id = s.id) AS buff_names
FROM game.skills s LEFT JOIN game.actions a ON a.id = s.action_id;
COMMENT ON VIEW game.v_skills IS 'Skill com rótulos de enum, ação animada, rótulos de ataque, efeitos visuais e buffs.';

CREATE VIEW game.v_items AS
SELECT i.*, c.code AS category_code, c.label_pt AS category_label, c.system, c.avatar_layer,
       su.name AS suite_name
FROM game.items i
LEFT JOIN game.item_categories c USING (master_type, son_type)
LEFT JOIN game.item_suites su ON su.id = i.suite_id;
COMMENT ON VIEW game.v_items IS 'Itens com categoria (sistema, camada de avatar) e conjunto.';

CREATE VIEW game.v_fashion AS
SELECT f.item_id, i.name, f.layer, f.son_type, i.sex_id, i.job_ids, i.profile, i.default_skill_ids, f.avatar_path,
       (SELECT array_agg(d.dir ORDER BY d.dir) FROM game.avatar_resource_dirs d WHERE d.owner_kind = 'item' AND d.owner_id = f.item_id AND d.context = 'map') AS map_dirs,
       (SELECT array_agg(d.dir ORDER BY d.dir) FROM game.avatar_resource_dirs d WHERE d.owner_kind = 'item' AND d.owner_id = f.item_id AND d.context = 'battle') AS battle_dirs,
       (SELECT array_agg(d.dir ORDER BY d.dir) FROM game.avatar_resource_dirs d WHERE d.owner_kind = 'item' AND d.owner_id = f.item_id AND d.context = 'show') AS show_dirs
FROM game.fashion_items f JOIN game.items i ON i.id = f.item_id;
COMMENT ON VIEW game.v_fashion IS 'Moda: camada, skills concedidas e pastas de arte no mapa (.bswf), batalha (equip) e UI (equip_show).';

CREATE VIEW game.v_mounts AS
SELECT m.id, m.name, m.mount_type, meta.enum_label('mount_type', m.mount_type) AS mount_type_label,
       m.speed, m.is_standing, m.is_flying, m.avatar_path, m.wing_avatar_path,
       m.power, m.agility, m.intellect, m.physique, m.star_additions, m.grade_type,
       m.required_item_id, it.name AS required_item_name,
       (SELECT jsonb_agg(jsonb_build_object('context', a.context, 'state', a.state, 'layer', a.layer, 'resource', a.resource,
                                            'frame_class', a.frame_class_pattern, 'directions', a.directions, 'frames', a.frames,
                                            'url', ast.url) ORDER BY a.context, a.layer, a.state)
        FROM game.mount_animations a LEFT JOIN client.assets ast ON ast.id = a.asset_id WHERE a.mount_id = m.id) AS animations
FROM game.mounts m LEFT JOIN game.items it ON it.id = m.required_item_id;
COMMENT ON VIEW game.v_mounts IS 'Montaria com atributos, item de ativação e animações (mapa S/W corpo+asa; batalha para dragão) com URL quando no manifesto.';

CREATE VIEW game.v_unit_movies AS
SELECT 'pawn'::text AS unit_kind, p.id, p.name, p.movie_res AS res, d.dir, d.files
FROM game.pawns p LEFT JOIN game.avatar_resource_dirs d ON d.owner_kind = 'pawn' AND d.owner_id = p.id
UNION ALL
SELECT 'hero_npc', h.id, h.name, h.res_path, d.dir, d.files
FROM game.heroes h LEFT JOIN game.avatar_resource_dirs d ON d.owner_kind = 'hero_npc' AND d.owner_id = h.id WHERE h.res_path IS NOT NULL
UNION ALL
SELECT 'monster', m.id, m.name, m.res_path, d.dir, d.files
FROM game.monsters m LEFT JOIN game.avatar_resource_dirs d ON d.owner_kind = 'monster' AND d.owner_id = m.id;
COMMENT ON VIEW game.v_unit_movies IS 'Unidades de batalha com MovieClip próprio (swf/<res>/<res>.swf, classe slg.resource.movie.MovieAsset<res>).';

CREATE VIEW game.v_drops AS
SELECT d.drop_set, d.drop_id, d.site, d.param2, d.item_id, i.name AS item_name,
       coalesce(meta.enum_label('virtual_currency_item', d.item_id), i.name) AS item_label,
       d.quantity, d.is_bound, d.appear_type, meta.enum_label('drop_appear_type', d.appear_type) AS appear_label
FROM game.drop_entries d LEFT JOIN game.items i ON i.id = d.item_id;
COMMENT ON VIEW game.v_drops IS 'Drops com nome do item (ou moeda virtual) e rótulo de raridade.';

INSERT INTO meta.schema_migrations(version, description) VALUES ('0007', 'query views') ON CONFLICT DO NOTHING;
