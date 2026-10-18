#!/usr/bin/env python3
import collections
import json
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
ROADMAP = ROOT / "roadmap"

DOMAINS = [
    ("account", "Account and session"),
    ("character", "Character and progression"),
    ("companions", "Companions"),
    ("economy", "Economy, items and shops"),
    ("home", "Castle and home"),
    ("social", "Social"),
    ("guild", "Guild"),
    ("world", "World and exploration"),
    ("pve", "PvE challenges"),
    ("pvp", "PvP and competitive"),
    ("events", "Events and minigames"),
    ("monetization", "VIP, recharge and rewards"),
    ("platform", "Platform services"),
]

FEATURES = [
    ("account", "account", "Conta, login e cadastro", ["loading", "register", "securityCode", "securitycode", "setting", "notice", "logging", "gateway", "queue"], ["gateway", "switches", "module", "timer", "simple"]),
    ("account", "tutorial", "Tutorial e novato", ["guidetask", "gameguide", "dialog", "funpreview"], ["novice", "gameplot", "step"]),
    ("account", "customer-service", "Atendimento e questionários", ["customerService", "question", "questionnaire", "mailcheck", "doctor"], ["customer", "questionnarie"]),
    ("character", "hero", "Herói, atributos e informações", ["playerinfo", "proficiency", "appell", "changejob", "viceplayer"], ["player", "changejob", "viceplayer", "watch"]),
    ("character", "army", "Tropa, soldados e formação", ["armyII", "teammanager"], ["army"]),
    ("character", "skills", "Habilidades e talentos", [], []),
    ("character", "fashion", "Modas e aparência", ["fashion", "tattoo"], ["fashion", "tattoo"]),
    ("character", "smith", "Ferreiro: fabricar, fortalecer, decompor", ["store", "steel_forge"], ["store"]),
    ("character", "cosmos", "Cosmos e astrologia", ["star", "stararea", "stargazing"], ["star", "stargazing"]),
    ("character", "steles", "Estelas", ["stele", "stelesys"], ["stela"]),
    ("character", "magic-cards", "Cartas mágicas", ["magicCard", "card"], ["magiccard", "powcard"]),
    ("character", "divine-weapon", "Arma Divina", ["ancientartifact", "artifact"], ["artifactgiftactivity"]),
    ("character", "theseus", "Teseu: conjuntos, alma e placas divinas", ["theseus", "theseusCollention", "theseusgodhead", "thessTower", "thessbox"], ["theseus", "theseusdungeon", "collection"]),
    ("character", "avenger", "Vingador", ["avenger"], ["avenger"]),
    ("character", "medals", "Medalhas e conquistas", ["hallfame"], ["medal", "achievementtask"]),
    ("companions", "mounts", "Montarias", ["mounts", "spacetime"], []),
    ("companions", "einherjar", "Einherjar (pets)", ["pet", "petchallenge", "pethallows", "remotepet", "petboss", "petland"], ["pet", "remotepet"]),
    ("companions", "guardians", "Guardiões e Espírito de Proteção", ["child", "children", "childabysm", "childarena", "childesal", "childformation", "childnswar", "childpatrol", "childpve", "childseal", "childspiritexpedition", "ylex"], ["children", "childpatrol", "childseal", "expedition", "guardpve", "guardpvp"]),
    ("companions", "dragon", "Encantador de Dragões e Titã", ["dragontalker", "dragontitan", "dragonTitan"], ["dragontalker", "titan"]),
    ("companions", "goddess", "Deusa", ["goddess"], ["goddess"]),
    ("companions", "monsters", "Feras de combate e invocação", ["monster"], ["monster"]),
    ("economy", "inventory", "Mochila e itens", ["bag", "bag360", "pandora", "box"], ["item", "storehouse", "slate", "box"]),
    ("economy", "shops", "Lojas", ["shop", "discountshop", "outercityshop", "poseidon", "mvpshop", "timebuy"], ["shop", "mall", "mapshop", "poseidonshop", "exploitsshop"]),
    ("economy", "auction", "Mercado e leilão", ["auction", "sale"], ["auction"]),
    ("economy", "exchange", "Trocas", ["allmanexchange", "luckyexchange", "exchange"], ["lucky"]),
    ("economy", "alchemy", "Fábrica de Alquimia", ["alchemical"], ["alchemyworkshop"]),
    ("economy", "laboratory", "Laboratório de Platina e pote mágico", ["perkinlab", "platinum"], ["perkinlab"]),
    ("economy", "mines", "Minas do Tesouro", ["fund", "fundVein", "mineField"], []),
    ("economy", "currency", "Moedas e recursos", ["currency"], []),
    ("home", "castle", "Castelo e prédios", ["castle", "buildings", "hook", "seminaryBless"], ["castle", "building"]),
    ("home", "farm", "Fazenda e residência", ["farm", "home", "water"], ["farm"]),
    ("home", "golden-tree", "Árvore de Ouro", ["bottle"], ["bottle"]),
    ("home", "cat-house", "Casa de Gato", ["cathouse"], ["cat"]),
    ("home", "fishing", "Pesca", ["fish"], ["fish"]),
    ("home", "secretary", "Pequena Secretária", ["secretary"], []),
    ("social", "friends", "Amigos e social", ["friends", "sns", "im", "groupchat"], ["friend", "im"]),
    ("social", "chat", "Chat", ["chat"], ["chat"]),
    ("social", "marriage", "Casamento", ["marry"], ["marriage"]),
    ("social", "mail", "Email", ["emailII"], ["mail"]),
    ("social", "team", "Equipe e missões de equipe", ["team", "groupfb"], ["team"]),
    ("social", "rankings", "Rankings", ["sort"], []),
    ("guild", "guild", "Guilda", ["consortia", "guildfb", "guildwanted", "crossguild", "gvgcross", "minos", "consortiachess"], ["consortia", "consortiaplay", "consortiapve", "consortiawant", "consortiawar", "guildcampaign"]),
    ("world", "world-map", "Mapa mundi e cidade exterior", ["worldmap", "outercity"], ["outercity", "worldmap"]),
    ("world", "sky-realm", "Reino do Céu", ["space"], []),
    ("world", "campaign", "Campanhas e salas", ["selectcampaign", "singlecampaign", "pveroomlist", "room", "duskarea"], ["campaign", "room", "tollgate", "dungeon", "dungeonturn"]),
    ("world", "archaeology", "Arqueologia", ["archaeology", "archeology"], ["archaeology"]),
    ("world", "navigation", "Navegação e navios", ["navigation"], []),
    ("world", "exploration", "Explorações e ruínas", ["monsterexplore", "remainsexplore", "dungenexploration", "secretadventure", "secret"], ["secretexplore", "seek", "shuttle"]),
    ("world", "outyard", "Terrálem", ["outyard"], ["hugehead", "stackhead", "titanland"]),
    ("pve", "world-boss", "Chefão global", ["worldboss"], []),
    ("pve", "forbidden-boss", "Chefão da Zona Proibida", ["forbiddenboss"], ["forbiddenboss"]),
    ("pve", "royalty-boss", "Caminho da Realeza", ["royaltyboss"], []),
    ("pve", "abyss", "Abismo sem fim", ["abysm"], ["guardendless"]),
    ("pve", "mazes", "Labirintos", ["maze", "darkmaze", "gemmaze", "llk"], ["linkgame"]),
    ("pve", "trials", "Torres e provações", ["warsoultower", "lordtrial", "crisis", "timevortex", "shadowland", "demonland", "skyboxroad", "singlepass", "rapidThrough", "rapidthrouh"], ["warsoultower", "lordtrial", "crisis", "timevortex", "skytrial"]),
    ("pve", "roads", "Caminhos", ["finalroad", "gloryroad", "goldroad", "heroroad", "redemptionroad", "increasingly", "increasingroad", "increasinglyroad", "revenge"], ["finalroad", "gloryroad", "goldenroad", "heroroad", "redemptionroad", "demonroad"]),
    ("pve", "planes", "Planos", ["planeswar"], ["planes"]),
    ("pve", "ecliptic-palace", "Palácio da Eclíptica", ["eclipticpalace"], ["eclipticpalace"]),
    ("pve", "final-defense", "Defesa final", ["finaldefense", "landmine", "unrealshooting"], ["unrealshooting", "guardscuffle"]),
    ("pve", "mopup", "Bots e varredura", ["mopup"], []),
    ("pve", "sacrifice", "Sacrifício", ["sacrifice"], []),
    ("pvp", "arena", "Arena e coliseu", ["pvp", "pvproomlist", "colosseum", "godpvpenter", "dreamarena"], ["pvp"]),
    ("pvp", "ares-battle", "Batalha de Ares", ["areslords"], ["areslords"]),
    ("pvp", "venus-battle", "Batalha de Vênus", ["matelords", "multilords"], ["matelords"]),
    ("pvp", "athena-battle", "Batalha de Athena", ["braveleg"], ["braveleg"]),
    ("pvp", "theseus-arena", "Arena de Teseu", ["theseuspvp", "theseusdoublepvp", "theseusDoublepvpscene", "theseusdoublepvproom", "theseuspvpscene"], []),
    ("pvp", "artillery", "Artilharia TM", ["vehicle"], ["vehicle"]),
    ("pvp", "auto-chess", "Supremacia do Legend (auto chess)", ["chess", "chesspvp"], []),
    ("pvp", "hermitage-war", "Batalha do Eremitério", ["war2023", "sevenyear"], ["secretwar"]),
    ("pvp", "glory-supremacy", "Supremacia da Glória", ["gloryGame"], ["Glory"]),
    ("pvp", "league", "Liga e aliança", ["steel"], ["steel", "allianceregression"]),
    ("pvp", "three-kingdoms", "Hegemonia dos Três Reinos", ["godsevening"], ["gods"]),
    ("pvp", "cross-server", "Disputas inter-servidor", ["crosscost", "exchargerank", "stokesore"], ["cross", "bloodyrealm", "fantasymatirx"]),
    ("events", "daily-activity", "Atividade diária e check-in", ["dayguide", "dayGuide", "newactiveleed", "countlogin", "loginactivity", "supersignincard", "onlinereward"], ["activity", "activitydaily", "leed", "daylight"]),
    ("events", "quests", "Missões", ["task", "ringtask", "offerreward"], ["quest", "simpletask", "reward"]),
    ("events", "seasonal-events", "Eventos sazonais", ["christmas", "carnival", "carnvial", "raveparty", "publicegg", "newyearact", "newyearactivity", "year2023", "birthday", "cultureactive", "culture", "funny", "specialfunny", "airgarden", "goldenDionysia", "goldensheep", "sevenyear_events"], ["christmas", "carnival", "culture", "giftparty", "airgarden", "active", "active.anniversary", "cccactive", "universalActive", "sumpassion"]),
    ("events", "lotteries", "Roletas e sorteios", ["lottery", "luckylottery", "chargelottery", "superlottery", "pumpingjoy", "pumpingegg", "foisonhorn", "faterotary", "wishpool"], ["lottery", "fate"]),
    ("events", "casino", "Salão de jogo e cassino", ["gamehall", "poker", "blackjack", "slot", "bingo", "apex", "monopoly"], ["gamehall", "blackjack", "bingo", "apex", "minigame"]),
    ("events", "memory-games", "Jogos de memória", ["newmemorycard", "sqmemory"], ["memorycard", "sqmemory"]),
    ("events", "treasures", "Caças ao tesouro e tesouros", ["treasurehunt", "skytreasure", "godTreasure", "treasuremap"], ["treasuremap"]),
    ("events", "quiz", "Resposta de Inteligência", ["answer"], ["answerquestion"]),
    ("events", "fantasy-bar", "Bar da Fantasia e Fonte Mágica", ["magicpub", "magicspring"], ["magicpub", "party"]),
    ("events", "returning-players", "Regresso de jogadores", ["kingback", "oldplayerreturn", "oldbacker", "regress", "kingcontract"], ["oldbacker", "olderreflux", "regress", "recover", "retrieve"]),
    ("events", "time-story", "Histórias e eventos de tempo", ["timestory", "gamebox", "findback"], ["gamebox"]),
    ("monetization", "vip", "VIP e privilégios", ["vip", "customizedvip", "monthcard", "registwelfare", "upgradepresent", "bag360_vip"], ["vip", "privilege"]),
    ("monetization", "recharge", "Recarga, primeira recarga e reembolsos", ["firstpay", "newfirstpay", "continuePayRebate", "wholerebate", "encoGold", "feedback", "publicchairs"], ["rebate"]),
    ("platform", "assistant", "Assistente de Anteus", ["antaeus"], ["antaeus"]),
    ("platform", "battle", "Motor de batalha", ["battle"], ["battle"]),
    ("platform", "shared-ui", "Telas, avisos e dicas compartilhados", [], []),
]

INFRA = {"asset", "avatar", "cell", "com", "core", "core2", "core2_fla", "core_fla", "events", "flash", "manager", "managers",
         "mediator", "mediators", "nodes", "org", "preload", "proxy", "stage3drender", "starling", "ui", "utils", "view", "views",
         "yishi", "mvc", "dragonBones", "map", "mainBar", "sandbox", "svs", "simplegame", "tasktracetip", "datas", "infotips",
         "smallloading_fla", "yzhkof", "pveroom", "spacetime"}


def packages():
    idx = json.loads((ROOT / "build/as3/index.json").read_text())["classes"]
    cnt = collections.Counter()
    for k in idx:
        p = k.split(".")
        key = p[2] if k.startswith("mvc.module.") and len(p) > 3 else p[0]
        cnt[key] += 1
    return cnt


def proto_packages():
    proto = json.loads((ROOT / "protocol/proto.json").read_text())
    m = proto.get("messages", proto)
    return collections.Counter(v.get("package") for v in m.values())


def titles():
    out = collections.defaultdict(list)
    for s in json.loads((ROOT / "index/screens.json").read_text())["screens"]:
        p = s["class"].split(".")
        key = p[2] if s["class"].startswith("mvc.module.") and len(p) > 3 else p[0]
        out[key].append(s)
    return out


def main():
    pk, pp, tt = packages(), proto_packages(), titles()
    client_claimed = {p for f in FEATURES for p in f[3]}
    proto_claimed = {p for f in FEATURES for p in f[4]}
    unclaimed_client = sorted(k for k, v in pk.items() if v >= 2 and k not in INFRA and k not in client_claimed)
    unclaimed_proto = sorted(k for k in pp if k and k not in proto_claimed)
    if unclaimed_client or unclaimed_proto:
        print("unclaimed client packages:", unclaimed_client)
        print("unclaimed proto packages:", unclaimed_proto)
        sys.exit(1)
    lines = ["# Roadmap", "",
             "Feature map of the complete game. Each feature has a folder `roadmap/<feature>/` with a `README.md` and one Markdown file per module, written in technical English for implementation: routes (opcodes and HTTP paths), protobuf messages, client classes with `file:line`, server responses, rules, templates, PostgreSQL tables and an implementation checklist.",
             "", "Generated by `tools/featuremap.py`. Every client package and every protobuf package is assigned to exactly one feature. The coverage audit is in [COVERAGE.md](COVERAGE.md) (generated by `tools/coverage.py`), the conventions are in [CONVENTIONS.md](CONVENTIONS.md) and the opcode name index is in [OPCODES.md](OPCODES.md).", ""]
    for dom, title in DOMAINS:
        rows = [f for f in FEATURES if f[0] == dom]
        if not rows:
            continue
        lines += [f"## {title}", "", "| Feature | pt-BR | Client classes | Screens | Proto messages | Folder |", "|---|---|---:|---:|---:|---|"]
        for _, slug, pt, cpk, ppk in rows:
            classes = sum(pk.get(p, 0) for p in cpk)
            screens = sum(len(tt.get(p, [])) for p in cpk)
            msgs = sum(pp.get(p, 0) for p in ppk)
            folder = ROADMAP / slug
            link = f"[{slug}/]({slug}/)" if folder.exists() else f"`{slug}/` (pending)"
            lines.append(f"| {slug} | {pt} | {classes} | {screens} | {msgs} | {link} |")
        lines.append("")
    (ROADMAP / "README.md").write_text("\n".join(lines))
    meta = {slug: {"domain": dom, "name_pt": pt, "client_packages": cpk, "proto_packages": ppk} for dom, slug, pt, cpk, ppk in FEATURES}
    (ROADMAP / "features.json").write_text(json.dumps(meta, ensure_ascii=False, indent=1))
    print(f"{len(FEATURES)} features written to roadmap/README.md")


if __name__ == "__main__":
    main()
