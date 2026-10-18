#!/usr/bin/env python3
from __future__ import annotations

from common import RESEARCH_DIR, J, connect, copy_rows, load_json

SPACE = "decompiled/core_module/scripts/map/space/SpaceManager.as:344"
BASE_KINDS = [
    ("player_spawn", "Ponto de nascimento do jogador", "template", "MapNodeInfos.BornPoints (nó MasterType 40)", "grid20",
     "Células listadas em BornPoints do nó tipo 40; o cliente não lê este campo (SpaceManager.readSpaceNodeInfo) — provavelmente usado pelo servidor ao escolher RoomPlayerMsg.cur_pos.", SPACE),
    ("portal", "Portal / transferência de mapa", "template", "MapNodeInfos MasterType 171 + MoveToMapId/MoveToNodeId", "grid20",
     "Ao interagir, leva ao mapa/nó de destino.", SPACE),
    ("npc_node", "Nó de NPC/objeto", "template", "MapNodeInfos.PosX/PosY (células) e FixX/FixY (px)", "grid20",
     "NPC de diálogo, recompensa, gatilho, mapa do tesouro etc.; HandlerRange = raio de interação em células.", SPACE),
    ("gift_pile", "Pilha de presentes (evento)", "template", "MapNodeInfos MasterType 300..315/410", "grid20",
     "Nós de coleta de evento.", SPACE),
    ("crisis_node", "Nó da Crise dos Planos", "template", "CrisisMapInfos.X/Y", "px", "Ponto no mapa grande da Crise; LineNode liga nós.",
     "decompiled/m3/scripts/crisis/ui/item/PlaneCrisisPointItem.as:643"),
    ("outyard_node", "Nó do Quintal (HugeHead)", "template", "HugeHeadMapNodeTempInfos.PosX/PosY", "px", "Território ocupável; NodeLink liga nós.",
     "decompiled/core_module/scripts/mvc/module/outyard/LandPoint.as:82"),
    ("explore_node", "Nó da Exploração de Monstros", "template", "MonsterExploreTemplates.PosX/PosY", "px",
     "Nó no mapa do capítulo; linhas ligam (PosX+25, PosY+25).", "decompiled/m14/scripts/monsterexplore/MonsterExploreSelectPassFrame.as:305"),
    ("campaign_entry", "Ícone de campanha no mapa de seleção", "template", "Campaigns.PosX/PosY", "px",
     "Posição do ícone da área no mapa de seleção de campanhas.", "decompiled/core_module/scripts/yishi/manager/CampaignTemplateManager.as:122"),
    ("building_slot", "Posição de prédio no castelo", "template", "BuildingTempInfos.PosX/PosY (+TitleX/TitleY)", "px",
     "Onde o prédio é desenhado na cidade (CastleWalkLayer); 0 para tecnologias.", "decompiled/m4/scripts/castle/view/layer/CastleWalkLayer.as:149"),
    ("building_art_slot", "Sprite de prédio (castelo antigo)", "template", "BuildingResInfos.PosX/PosY", "px",
     "Arte legada por tipo/nível; não referenciada no cliente atual.", None),
    ("campaign_member_spawn", "Posição inicial na campanha", "server_message", "RoomEnterMsg.player[].cur_pos_x/y (U_C_CAMPAIGN_ENTER 21)", "grid20",
     "Spawn de cada membro ao entrar numa campanha/instância.", "decompiled/core_module/scripts/map/campaign/CampaignManager.as:636"),
    ("stand_pos", "Posição em pé / reviver / teleporte", "server_message", "StandPosMsg.pos_x/pos_y (U_C_SEND_STANDPOS 4126)", "grid20",
     "Encaixa o exército numa posição (também ao reviver).", "decompiled/m3/scripts/map/campaign/CampaignSocketManger.as:1465"),
    ("campaign_node", "Nó de campanha (NPC, monstro, baú, portal)", "server_message", "CampaignNodeMsg.pos_x/pos_y (células), fix_x/fix_y (px) (U_C_CAMPAIGN_NODE 127)", "grid20",
     "Nós do mapa de campanha; master_type 92 = baú; pre/next_node_ids = grafo; reset_x/y = posição de retorno.", "decompiled/core_module/scripts/map/campaign/CampaignManager.as:251"),
    ("castle_position", "Castelo no mapa-mundo", "server_message", "BaseCastleMsg.pos_x/pos_y/map_id (4153, 4129, 140)", "grid20",
     "Castelos de jogadores na cidade externa.", "decompiled/m3/scripts/map/outercity/OuterCityController.as:918"),
    ("wild_land", "Terra selvagem", "server_message", "WildLandMsg.pos_x/pos_y/size (4129, 140)", "grid20",
     "Terras ocupáveis no mapa-mundo.", "decompiled/m3/scripts/map/outercity/OuterCityController.as:947"),
    ("map_boss", "Chefe no mapa-mundo", "server_message", "MapBossMsg.bosslist[].x/y (U_C_MAPBOSS_DATAS 4938)", "grid20",
     "Chefes de campo.", "decompiled/core_module/scripts/map/outercity/manager/OuterCityManager.as:111"),
    ("map_box", "Baú no mapa-mundo", "server_message", "MapBoxMsg.boxlist[].x/y (U_C_MAPBOSS_BOX 4940)", "grid20",
     "Baús deixados por chefes.", "decompiled/core_module/scripts/map/outercity/manager/OuterCityManager.as:180"),
    ("battle_chest", "Baú de fim de batalha", "server_message", "BattleReportMsg.pos_x/pos_y (U_BATTLE_REPORT 4103)", "grid20",
     "Baú de drop na posição do exército.", "decompiled/m3/scripts/map/campaign/CampaignSocketManger.as:1028"),
    ("move_route", "Rota de movimento", "server_message", "PosMoveMsg.routes[] (RouteMsg x,y) 5124/4185/4213/8254/4167", "px",
     "Caminho enviado/recebido; único campo de posição em pixels além de fix_x/fix_y.", "decompiled/m3/scripts/map/net/MapSocketOuterManager.as:100"),
    ("battle_slot", "Posição na grade de batalha", "hardcoded", "BattleUtils.get9GridPos(295|905, 570)", "px",
     "12 posições por lado; 1/4/7/10 = linha de frente.", "decompiled/core_module/scripts/battle/utils/BattleUtils.as:124"),
]


def kinds(cur, research):
    rows = {k[0]: k for k in BASE_KINDS}
    for pk in (research.get("point_kinds") or []):
        code = pk.get("name")
        if code and code not in rows:
            src = pk.get("source") if pk.get("source") in ("template", "map_file", "server_message", "hardcoded") else "hardcoded"
            rows[code] = (code, pk.get("label_pt") or code, src, pk.get("where"), pk.get("units"), pk.get("description_pt"),
                          pk.get("source_ref"))
    copy_rows(cur, "game.map_point_kinds", ["code", "label_pt", "source", "location", "units", "description", "source_ref"],
              rows.values())
    return set(rows)


def points(cur, research, known):
    rows = []

    def add(ctx, map_id, kind, name, ref_table, ref_id, x, y, gx, gy, tmap, tnode, extra, src):
        rows.append((ctx, map_id, kind, name, ref_table, str(ref_id), x, y, gx, gy, tmap, tnode, J(extra), src))

    cur.execute("""SELECT id, map_id, name, master_type, son_type, grid_x, grid_y, fix_x, fix_y, move_to_map_id, move_to_node_id,
                          born_points_raw, toward, handler_range, source_ref FROM game.map_nodes ORDER BY id""")
    for (nid, mid, name, mt, st, gx, gy, fx, fy, tmap, tnode, born, toward, rng, src) in cur.fetchall():
        kind = "portal" if mt == 171 else "gift_pile" if (mt and (300 <= mt <= 315 or mt == 410)) else "npc_node"
        add("space_map", mid, kind, name, "game.map_nodes", nid, fx, fy, gx, gy, tmap, tnode,
            {"master_type": mt, "son_type": st, "toward": toward, "handler_range": rng}, src)
        for i, part in enumerate(p for p in (born or "").split("|") if p.strip()):
            try:
                bx, by = (int(v) for v in part.split(",")[:2])
            except ValueError:
                continue
            add("space_map", mid, "player_spawn", f"{name} #{i + 1}", "game.map_nodes", nid, bx * 20, by * 20, bx, by, None, None,
                {"ordinal": i, "node_master_type": mt}, src)
    cur.execute("SELECT id, map_id, node_id, x, y, node_type, linked_node_ids, source_ref FROM game.crisis_map_nodes")
    for tid, mid, node, x, y, nt, links, src in cur.fetchall():
        add("crisis_map", mid, "crisis_node", None, "game.crisis_map_nodes", tid, x, y, None, None, None, None,
            {"node_id": node, "node_type": nt, "links": links}, src)
    cur.execute("SELECT id, map_id, x, y, node_type, initial_force, can_occupy, linked_node_ids, source_ref FROM game.outyard_map_nodes")
    for nid, mid, x, y, nt, force, occ, links, src in cur.fetchall():
        add("outyard_map", mid, "outyard_node", None, "game.outyard_map_nodes", nid, x, y, None, None, None, None,
            {"node_type": nt, "initial_force": force, "can_occupy": occ, "links": links}, src)
    cur.execute("SELECT chapter_id, node_id, node_name, x, y, node_map, fight_map, source_ref FROM game.monster_explore_nodes")
    for ch, node, name, x, y, nmap, fmap, src in cur.fetchall():
        add("monster_explore_map", ch, "explore_node", name, "game.monster_explore_nodes", f"{ch}/{node}", x, y, None, None, None, None,
            {"node_id": node, "node_map": nmap, "fight_map": fmap}, src)
    cur.execute("SELECT id, name, land_id, area_id, pos_x, pos_y, campaign_type, source_ref FROM game.campaigns WHERE pos_x > 0 OR pos_y > 0")
    for cid, name, land, area, x, y, ct, src in cur.fetchall():
        add("world_map", land, "campaign_entry", name, "game.campaigns", cid, x, y, None, None, None, None,
            {"area_id": area, "campaign_type": ct}, src)
    cur.execute("""SELECT DISTINCT ON (son_type) son_type, name, pos_x, pos_y, title_x, title_y, source_ref
                   FROM game.buildings WHERE pos_x > 0 OR pos_y > 0 ORDER BY son_type, grade""")
    for st, name, x, y, tx, ty, src in cur.fetchall():
        add("castle", None, "building_slot", name, "game.buildings", st, x, y, None, None, None, None,
            {"son_type": st, "title_dx": tx, "title_dy": ty}, src)
    cur.execute("SELECT row_id, son_type, grade, x, y, title_dx, title_dy, depth, source_ref FROM game.castle_building_art")
    for rid, st, g, x, y, tx, ty, depth, src in cur.fetchall():
        add("castle", None, "building_art_slot", None, "game.castle_building_art", rid, x, y, None, None, None, None,
            {"son_type": st, "grade": g, "title_dx": tx, "title_dy": ty, "depth": depth}, src)
    cur.execute("SELECT side, position, x, y, grid_row, grid_col, is_front, source_ref FROM game.battle_grid_positions")
    for side, pos, x, y, row, col, front, src in cur.fetchall():
        add("battle", side, "battle_slot", f"lado {side} pos {pos}", "game.battle_grid_positions", f"{side}/{pos}", x, y, None, None,
            None, None, {"row": row, "col": col, "is_front": front}, src)
    hard_ctx = sorted({hp.get("context") or "other" for hp in research.get("hardcoded_points") or []} - known)
    for ctx in hard_ctx:
        ref = next(h.get("source_ref") for h in research["hardcoded_points"] if (h.get("context") or "other") == ctx)
        cur.execute("""INSERT INTO game.map_point_kinds(code, label_pt, source, location, units, description, source_ref)
                       VALUES (%s, %s, 'hardcoded', %s, 'px', 'Tabela de coordenadas fixa no código (ver docs/world/maps.md).', %s)
                       ON CONFLICT DO NOTHING""", (ctx, ctx.replace("_", " "), ref, ref))
        known.add(ctx)
    for hp in research.get("hardcoded_points") or []:
        ctx = hp.get("context") or "other"
        kind = ctx
        try:
            x, y = int(hp.get("x")), int(hp.get("y"))
        except (TypeError, ValueError):
            x = y = None
        scene = ("castle" if ctx.startswith("castle") else "space_map" if ctx.startswith(("space", "marry")) else
                 "campaign_map" if ctx in ("novice_start", "fixed_npc_view", "single_campaign_npc", "bloody_box_offset", "molong_box_ring") else
                 "outyard_map" if ctx.startswith("outyard") else "world_map" if ctx == "world_map_entry" else "other")
        add(scene, None, kind, hp.get("name"), "hardcoded", hp.get("name"), x, y, None, None, None, None,
            {"context": ctx, **(hp.get("extra") or {})}, hp.get("source_ref") or "data/research/maps_geometry.json")
    if any(r[2] == "hardcoded_point" for r in rows):
        cur.execute("""INSERT INTO game.map_point_kinds(code, label_pt, source, description) VALUES
                       ('hardcoded_point', 'Coordenada fixa no código', 'hardcoded', 'Ponto constante no AS3 (ver extra.context).')
                       ON CONFLICT DO NOTHING""")
    return copy_rows(cur, "game.map_points", ["context", "map_id", "kind", "name", "ref_table", "ref_id", "x_px", "y_px",
                                              "grid_x", "grid_y", "target_map_id", "target_node_id", "extra", "source_ref"], rows)


def bounds(cur):
    cur.execute("""
      INSERT INTO game.map_bounds
      SELECT m.id, m.map_file_id, m.width, m.height,
             CASE WHEN m.map_file_id BETWEEN 1 AND 5 THEN 512 ELSE 300 END,
             CASE WHEN m.map_file_id BETWEEN 1 AND 5 THEN 20 ELSE ceil(m.width / 300.0) END,
             CASE WHEN m.map_file_id BETWEEN 1 AND 5 THEN 20 ELSE ceil(m.height / 300.0) END,
             ceil(m.width / 20.0), ceil(m.height / 20.0),
             (SELECT count(*) FROM client.assets a WHERE a.dir = 'mapmaterial/land/' || m.map_file_id AND a.file_name LIKE 'tile\\_%'),
             EXISTS (SELECT 1 FROM client.assets a WHERE a.path = format('maps/%s/%s.maps', m.map_file_id, m.map_file_id)),
             EXISTS (SELECT 1 FROM client.assets a WHERE a.path = format('maps/%s/%s.titles', m.map_file_id, m.map_file_id)),
             m.battle_ground_id,
             CASE WHEN m.map_file_id BETWEEN 1 AND 5 THEN 'Mundo: 20×20 tiles de 512 px (.jpg e .png.atf, Stage3D).'
                  ELSE 'Instância/campanha: tiles de 300 px tile_<col>_<row>.jpg (BgLayer).' END
      FROM game.maps m WHERE m.width IS NOT NULL AND m.height IS NOT NULL""")
    return cur.rowcount


BASE_FORMATS = [
    (".maps", "{RES}maps/{id}/{id}.maps", "zlib + 3 objetos AMF3 lidos em sequência: floorData (chão: itens {url,x,y,rotation,baseNum}, baseNum 101 = fundo repetido; chave = retângulo), moviesData (animações, chave \"x,y\") e topsData (camada de cima, chave \"x,y\").",
     [{"name": "floorData", "type": "AMF3 Object", "meaning_pt": "peças de chão por retângulo"},
      {"name": "moviesData", "type": "AMF3 Object", "meaning_pt": "MovieClips do cenário"},
      {"name": "topsData", "type": "AMF3 Object", "meaning_pt": "objetos sobrepostos ao avatar"}],
     "decompiled/core_module/scripts/map/campaign/preload/PreCampaignData.as:69"),
    (".titles", "{RES}maps/{id}/{id}.titles", "zlib + 1 objeto AMF3 (mapTielsData): dicionário cujas chaves \"{x}_{y}\" (células de 20 px) presentes são andáveis — a borda do mapa é o contorno desse conjunto.",
     [{"name": "\"{x}_{y}\"", "type": "chave", "meaning_pt": "célula andável (x = px/20, y = px/20)"}],
     "decompiled/m3/scripts/map/internals/scenePathSearcher/PathMapHitTester.as:27"),
    (".rd", "{RES}maps/{id}/{id}.rd", "Carregado só por StealthyPreCampaignData (nodes); classe nunca instanciada — código morto.", None,
     "decompiled/core_module/scripts/yishi/manager/PathManager.as:216"),
    (".path", "{RES}maps/{id}/{id}.path", "getOuterCityNotePaths nunca é chamado — código morto.", None,
     "decompiled/core_module/scripts/yishi/manager/PathManager.as:220"),
    ("tile", "{RES}mapmaterial/land/{MapFileId}/tile_{col}_{row}.jpg", "Fundo em tiles: 300 px nas instâncias (ceil(W/300)×ceil(H/300), coluna primeiro); mundos 1–5 = 20×20 de 512 px (+ .png.atf).", None,
     "decompiled/m3/scripts/com/road/yishi/bg/BgLayer.as:55"),
]


def formats(cur, research):
    rows = {f[0]: f for f in BASE_FORMATS}
    for ff in research.get("map_file_formats") or []:
        k = ff.get("file")
        if k and k not in rows:
            rows[k] = (k, None, ff.get("structure_pt") or "", ff.get("fields"), ff.get("source_ref"))
    copy_rows(cur, "game.map_file_formats", ["file_kind", "url_template", "structure", "fields", "source_ref"],
              ((a, b, c, J(d), e) for a, b, c, d, e in rows.values()))
    return len(rows)


def main():
    p = RESEARCH_DIR / "maps_geometry.json"
    research = load_json(p) if p.exists() else {}
    conn = connect()
    with conn, conn.cursor() as cur:
        cur.execute("TRUNCATE game.map_points, game.map_bounds, game.map_file_formats RESTART IDENTITY")
        cur.execute("DELETE FROM game.map_point_kinds")
        known = kinds(cur, research)
        print("tipos de ponto", len(known))
        print("pontos", points(cur, research, known))
        print("limites de mapa", bounds(cur))
        print("formatos de arquivo", formats(cur, research))


if __name__ == "__main__":
    main()
