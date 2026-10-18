#!/usr/bin/env python3
import html
import json
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parent.parent
ROADMAP = ROOT / "roadmap"

GLOBAL = {
    "yishi", "ui", "mainBar", "mainbar", "maintoolbar", "MainToolBar", "view", "views", "public",
    "tasktracetip", "tasktrace", "asset", "cell", "managers", "manager", "sandbox", "toptoolbar",
    "resourcebar", "resourceBar", "mediator", "dataFormatter", "frame", "tips", "Action", "ArialFont",
    "mainloadingii", "mainTool", "groupSelectObj", "scene", "information", "playerInfo", "playerMenu",
    "playermenu", "BaseManager", "YiShi", "PropertyName", "GoodsItem6", "EquipTipsContent", "LineUpLeftItem",
    "RankRewardView", "GrowthInfoView", "SkillView", "TimesPropTip01", "TimesPropTip02",
    "TimesPropTip03", "CannotEnterVehicle", "buffer", "queueBar", "QueueItem", "svsFrame",
    "HigherGradeOpenTipView", "TalentTips", "MonsterTips", "simpleskill", "SkillTips",
    "mvc", "physics", "notBeActivated", "wanttoreplace", "wanttoremove", "riverView",
}

PREFIX = {
    "newbieXml": "tutorial", "noviceII": "tutorial", "newbie": "tutorial", "newbieBaseActionMediator": "tutorial",
    "godsEvening": "three-kingdoms",
    "warlords": "venus-battle", "warlordsroom": "venus-battle",
    "selfchess": "auto-chess",
    "stela": "steles", "stala": "steles",
    "vicepassword": "account",
    "active": "daily-activity", "daylight": "daily-activity",
    "oldback": "returning-players", "expback": "returning-players", "oldbacker": "returning-players",
    "kingtower": "returning-players", "KingBackDayPage": "returning-players",
    "house": "farm", "FurnitureBagCell": "farm", "FurnitureBagView": "farm", "FurnitureShopItem": "farm",
    "FarmShopFrame": "farm", "FarmSelectPetMeun": "farm", "FarmCanPickTipView": "farm",
    "farmSelectMountMeun": "farm", "FarmPetLandView": "farm",
    "godarrive": "campaign",
    "SevenYearGloryGame": "glory-supremacy",
    "assaultwar": "cross-server", "crossscore": "cross-server", "crossBottomBar": "cross-server",
    "SvSShopFrame": "cross-server", "CrossPvPShopFrame": "cross-server",
    "planeCrisis": "trials", "planeCriris": "trials", "PlanesEventTips": "artillery",
    "dungeonexplore": "campaign", "DuskAreaInfoView": "campaign", "InstanceRightView": "campaign",
    "flametemple": "campaign", "flameTempleTopInfoView": "campaign", "flameTempleScoreRankView": "campaign",
    "flameTempleFlameInfoTip": "campaign",
    "royaltyBossFrame": "royalty-boss", "royaltyFightFrame": "royalty-boss", "royaltyLevelItem": "royalty-boss",
    "royaltyRankFrame": "royalty-boss", "royaltyBossItem": "royalty-boss", "royaltyFightFrameItem": "royalty-boss",
    "chatII": "chat", "ChatOutputViewII": "chat", "ChatItemMenu": "chat", "consortiagroupchat": "chat",
    "petCompose": "einherjar", "petswallow": "einherjar", "petFrame": "einherjar", "petSwallowView": "einherjar",
    "petBossFrame": "einherjar", "checkForUsePetLandTransfer": "einherjar", "checkForUsePetExpBook": "einherjar",
    "childpvp": "guardians", "childNswar": "guardians", "childFrame": "guardians", "childnsframe": "guardians",
    "childnsbuffShow": "guardians", "childNsLifeWheel": "guardians", "childMostConversionInfoView": "guardians",
    "ChildPveFrame": "guardians", "ChildNursingSpiritItem": "guardians", "ChildWarUIView": "guardians",
    "battleGuard": "guardians", "BattleGuard": "guardians", "spiritExpedition": "guardians",
    "ylexpedition": "guardians", "YLExpeditionItem": "guardians",
    "DragonTitan": "dragon", "dragontaler": "dragon", "dragonTalker": "dragon", "DragonTalker": "dragon",
    "DragonSoulView": "dragon",
    "gvg": "guild", "Gvg": "guild", "GVG": "guild", "gvgBufferIcon": "guild", "gvgbuffericon": "guild",
    "crossGvg": "guild", "Guildfb": "guild", "consortianewboss": "guild", "Consortia": "guild", "consortia": "guild",
    "Consorienewboss": "guild", "GvgRankListFrame": "guild",
    "Auction": "auction", "SaleRightView": "auction", "SaleBagCell": "auction", "SaleItemView": "auction",
    "market": "auction", "AuctionCategoryPane": "auction",
    "allmainexchange": "exchange", "exchangebox": "exchange", "ExchangeBoxFrame": "exchange",
    "quickbuy": "shops", "BuyFrameI": "shops", "Store": "shops", "StoreBagII": "shops", "TreasureStoreBag": "shops",
    "WishPoolShopFrame": "lotteries", "PumpingJoy": "lotteries", "pumpingJoy": "lotteries",
    "rouletteBox": "lotteries", "foisonHornRewardTips": "lotteries", "foisonHornFrame": "lotteries",
    "luckyLotteryFrame": "lotteries", "fateRotarySkillItem": "lotteries",
    "gameHall": "casino", "apex": "casino", "apexroom": "casino", "PokerExchangeView": "casino",
    "Monopoly": "casino", "MonopolyManager": "casino", "MonopolyBottomView": "casino",
    "skyTreasure": "treasures", "SkyTreasure": "treasures", "skyStepView": "treasures", "skyStepTip": "treasures",
    "TreasurePageView": "treasures", "TreasureOuterItem": "treasures", "TreasureSkillItem": "treasures",
    "treasureMap": "treasures", "hunt": "treasures", "SkyBoxRoad": "treasures",
    "remainsExplore": "exploration", "remiansExplore": "exploration", "permaneceExplore": "exploration",
    "MonsterExplore": "exploration", "islandexplore": "exploration", "IsLandExploreSpeedUpFrame": "exploration",
    "secretwar": "hermitage-war", "secreat": "hermitage-war", "DeepPrisonRightUIView": "hermitage-war",
    "warSoulTower": "trials", "ShadowLand": "trials", "rapid": "trials", "raipthrough": "trials",
    "RapidView": "trials", "lordTrial": "trials", "TimeActiveBoxView": "trials",
    "finalRoad": "roads", "goldRoad": "roads", "GoldRoadCell": "roads", "demonroad": "roads",
    "redemptionRoad": "roads", "RedemptionRoadDiffItem": "roads", "revengeroad": "roads",
    "GloryRoadTreasureCell": "roads", "GloryBloodHead": "roads", "GloryShopFrame": "roads",
    "GloryroadModel": "roads",
    "building": "castle", "CastleBuildingView": "castle", "CastleServer": "castle",
    "SeminaryFrameRightView": "castle", "transferBuildFrame": "castle", "stone": "castle",
    "stoneGetView": "castle", "stonebagOp": "castle",
    "fashion": "fashion", "fashionStoreFrame": "fashion", "fashioncomposetip": "fashion",
    "fashionRefresh": "fashion", "fashionIdentityBufferTipView": "fashion", "Tattoo": "fashion", "tattoo": "fashion",
    "switchAppell": "fashion",
    "appell": "hero", "appellFrame": "hero", "appellModel": "hero", "ThaneAttributeTip": "hero",
    "ProficiencyPropItem": "hero", "playerBufferInfo": "hero",
    "Avenger": "avenger", "SelfAvengerView": "avenger",
    "PlayerBagCellClickMediator": "inventory", "SoulMake": "inventory", "soulMake": "inventory",
    "soulmake": "inventory", "rune": "inventory", "runeitemView": "inventory", "runetip": "inventory",
    "Rune": "inventory",
    "questionFrame": "customer-service", "questionItem": "customer-service", "question": "customer-service",
    "CustomerService": "customer-service", "customerservice": "customer-service", "mailCheckFrame": "customer-service",
    "customerserviceManger": "customer-service",
    "CustomizedVip": "vip", "MonthCardGiftItem": "vip", "UpgradePresentGoodsItem": "vip", "promotion": "vip",
    "Multilords": "venus-battle", "Matelords": "venus-battle", "multilordsroom": "venus-battle",
    "matelordsroom": "venus-battle", "multilordsroomView": "venus-battle",
    "godpvp": "arena", "PvpHeroFrame": "arena", "PvpSortListView": "arena", "pvpHeroHelperFrame": "arena",
    "pvpHeroFrame": "arena", "DreamArena": "arena", "dreamArena": "arena", "dreamarea": "arena",
    "outerCity": "world-map", "OuterCityArchaeologyView": "world-map", "outercityArchaeology": "world-map",
    "SpaceDialogFrame": "world-map", "DuskAreaInfoViewMap": "campaign",
    "Archaeology": "archaeology", "ArchaeologyUpgradeRewardTips": "archaeology", "ArchaeologyBookItem": "archaeology",
    "ArchaeologyMakeRightView": "archaeology",
    "Navigation": "navigation",
    "Alchemical": "alchemy", "alchemy": "alchemy", "alchemySoul": "alchemy",
    "PerkinLab": "laboratory", "platinumFrame": "laboratory",
    "EclipticPalaceChallengeItem": "ecliptic-palace",
    "SevenYear": "hermitage-war", "SevenYearBuyItem": "hermitage-war",
    "CultureActive": "seasonal-events", "cultureActiveView": "seasonal-events", "GoldenDionysia": "seasonal-events",
    "goldenDionysia": "seasonal-events", "goldendionysia": "seasonal-events", "RaveParty": "seasonal-events",
    "christmas": "seasonal-events", "Christmas": "seasonal-events", "pblicegg": "seasonal-events",
    "AirGarden": "seasonal-events", "airGarden": "seasonal-events", "funny": "seasonal-events",
    "FunnyModel": "seasonal-events", "funnybag": "seasonal-events", "sumcampaign": "seasonal-events",
    "yearactivity": "seasonal-events", "yearactive": "seasonal-events", "snowball": "seasonal-events",
    "SnowballReportFrame": "seasonal-events",
    "RuneCell": "smith", "IntensifyView": "smith", "IntensifyTip": "smith",
    "mount": "mounts", "mountTip": "mounts", "battleMount": "mounts", "wildSoulFrame": "mounts",
    "mountsPromotionView": "mounts", "mountsFrame": "mounts", "mountsFrmae": "mounts", "mountFrame": "mounts",
    "MountKingTrainView": "mounts", "MountRefiningSoulItem": "mounts", "MountShopFrame": "mounts",
    "quiz": "quiz",
    "NewMemoryCardItem": "memory-games", "sqMemory": "memory-games",
    "catHouse": "cat-house",
    "theseus": "theseus", "Theseus": "theseus", "thesstower": "theseus", "theseuscollectbox": "theseus",
    "thesebox": "theseus", "theseusoul": "theseus", "theesus": "theseus", "theseuspvpMulti": "theseus-arena",
    "magicCard": "magic-cards", "fantasyMatrix": "magic-cards", "FantasyMatrixSkillItem": "magic-cards",
    "StarGazing": "cosmos", "StarWishView": "cosmos", "StarForceView": "cosmos", "StarHelper": "cosmos",
    "Monster": "monsters", "monster": "monsters",
    "Action": "auction", "CrossBugleFrame": "chat", "changeJob": "hero",
    "activity": "daily-activity", "simplegame": "friends", "rareweapon": "divine-weapon",
    "mosterSweepFrame": "mopup", "selectCP": "campaign", "forbiddenBossFrame": "forbidden-boss",
    "forbiddenBossItem": "forbidden-boss", "forbiddenBossView": "forbidden-boss",
    "forbiddenBossRankItem": "forbidden-boss", "forbiddenRecordFrame": "forbidden-boss",
    "forbiddenRecordItem": "forbidden-boss", "forbiddenRewardsFrame": "forbidden-boss",
    "oldPlayerReturn": "returning-players", "OldPlayerReturn": "returning-players",
    "oldPlayerReturnContractView": "returning-players", "oldPlayerReturnFrame": "returning-players",
    "oldPlayerReturnTaskView": "returning-players", "oldPlayerReturnFindFrame": "returning-players",
    "oldPlayerReturnHeadMenu": "returning-players", "expBack": "returning-players",
    "OldBackerRewardItem": "returning-players", "oldbackerFrame": "returning-players",
    "selecteCP": "campaign", "PlanesRewardTip": "planes", "poundEggView": "daily-activity",
    "MagicPub": "fantasy-bar",
    "rewardsFindBackFrame": "time-story", "planesWar": "planes", "planesRenameFrame": "planes",
    "planesTopView": "planes", "planesItemView": "planes", "planesTaskItem": "planes",
    "TransferPlanesLayerFrame": "planes", "planesCardEventFrame": "planes", "Planes": "planes",
    "PlanesLeftItemView": "planes", "PlanesRightView": "planes", "PlanesWarIconHelpView": "planes",
    "planesRewardItemTip": "planes", "planesRewardTip": "planes", "planesResourceItemView": "planes",
    "planesTransferItemView": "planes", "PerkinLab": "laboratory", "PerkinLabVictoryTip": "laboratory",
    "PerkinLabKengTip": "laboratory", "PerkinLabExpTips": "laboratory", "PerkinLabRobView": "laboratory",
    "PerkinLabKengView": "laboratory", "PerkinLabEventItem": "laboratory",
    "dungeoturn": "campaign", "dungeonturn": "campaign", "DungeonTurnFrame": "campaign",
    "duengeonturn": "campaign", "RaceAgainstTimeFrame": "campaign", "RaceAgainstTimeItem": "campaign",
    "RaceAgainstTimeUpView": "campaign", "castSkillMediator": "battle", "WoundInfoView": "world-boss",
    "MagicSpringBufferAddView": "fantasy-bar", "refine": "smith", "refine2": "smith",
    "canntAttackWarCar": "artillery", "NormalSkillView": "battle", "pvpselectFrame": "arena",
    "CrossBugleFrame": "chat", "svs": "cross-server",
}

KEYWORDS = [
    ("guardians", "child children nursing spirit battleGuard guardPvp guardPve childpvp childNs"),
    ("guild", "consortia guild newGuild minos gvg consorienewboss"),
    ("campaign", "campaign room tollgate mopup hangup escort copynode selectcampaign flametemple duskarea dungeonturn dungeonexplore"),
    ("casino", "bingo slot poker blackjack gamehall apex monopoly"),
    ("lotteries", "lottery roulette wishpool gashapon pumping foison horn fate"),
    ("seasonal-events", "christmas carnival carnval easter newyear birthday culture year2023 karneval rave airgarden dionysia sheep funny goldenDionysia snowball pblicegg"),
    ("trials", "warsoul lordtrial crisis timevortex shadowland skytrial skybox rapid singlepass quickpass demonland planetrial"),
    ("roads", "finalroad gloryroad goldroad heroroad redemptionroad increasing revenge demonstrate demonroad"),
    ("einherjar", "pet challenge petboss petland pethallows remotepet"),
    ("theseus-arena", "theseuspvp theseusdouble"),
    ("theseus", "theseus godhead thssTower collention thesecoll"),
    ("dragon", "dragon titan"),
    ("athena-battle", "braveleg athena"),
    ("ares-battle", "areslords ares"),
    ("venus-battle", "matelords multilords warlords"),
    ("world-boss", "worldboss specialboss randomboss"),
    ("castle", "castle building seminary blessing transmitter activityqueue technology landup"),
    ("vip", "vip monthcard registwelfare upgradepresent customizedvip"),
    ("recharge", "firstpay pay rebate encogold publicchairs feedback chargelottery"),
    ("mounts", "mount avartar wildsoul"),
    ("fishing", "fish"),
    ("navigation", "navigation boat port"),
    ("shops", "shop mall limiteTimeDiscount quickbuy"),
    ("auction", "auction sale market"),
    ("exchange", "exchange allman lucky"),
    ("mazes", "maze llk linkgame gemmaze darkmaze evilland"),
    ("mines", "mine fund vein tramcar"),
    ("quiz", "quiz answer question"),
    ("customer-service", "questionnaire customerservice questionNaire question"),
    ("exploration", "secret remains explore seek shuttle monsterexplore islandexplore"),
    ("goddess", "goddess daimon"),
    ("cosmos", "star stargazing stararea starwish"),
    ("marriage", "marry wedding heart"),
    ("friends", "friend sns fbevent rose share"),
    ("mail", "mail email"),
    ("army", "army formation soldier novice"),
    ("team", "team group mission"),
    ("monsters", "monster summon"),
    ("inventory", "bag box pandora slate item rune jewel goods equipconcise equipcontrast"),
    ("hero", "thane hero appell vocation"),
    ("smith", "intensify fortify"),
    ("magic-cards", "magiccard fantasyMatrix"),
    ("auto-chess", "pawn selfchess"),
    ("world-map", "worldmap outercity areamap"),
    ("outyard", "outyard hugehead stackhead titanland"),
    ("fashion", "fashion tattoo polish"),
    ("memory-games", "memorycard sqmemory"),
    ("time-story", "gamebox timestory"),
    ("sky-realm", "space skyrealm"),
    ("alchemy", "alchem"),
    ("assistant", "antaeus"),
    ("rankings", "rank sort"),
    ("league", "pvpleague"),
    ("arena", "dreamarena colosseum godpvp pxphero pvpsort"),
    ("cat-house", "cattoy cathouse"),
    ("artillery", "vehicle mapphysics"),
    ("account", "indulge vicepassword"),
    ("farm", "watertree house furniture"),
    ("treasures", "skystep treasure skybox hunt"),
    ("battle", "battle fight warfield revive"),
    ("tutorial", "newbie novice guide"),
    ("returning-players", "oldback regress kingcontract kingback recovery"),
    ("three-kingdoms", "godsevening godsevening"),
    ("daily-activity", "dayguide daylight activeleed activite signin"),
    ("quiz", "quiz answer"),
]

TEMPLATE_PREFIX = {
    "Apex": "casino", "BoxItems": "inventory", "Building": "castle", "Carnival": "seasonal-events",
    "Child": "guardians", "Christmas": "seasonal-events", "Consortia": "guild", "Crisis": "trials",
    "Easter": "seasonal-events", "Expedition": "guardians", "Exploit": "shops", "Explore": "exploration",
    "Fashion": "fashion", "FinalRoad": "roads", "FirstPay": "recharge", "Fish": "fishing",
    "ForbiddenBoss": "forbidden-boss", "Furniture": "farm", "GameBox": "time-story", "GameHall": "casino",
    "GloryRoad": "roads", "Goddess": "goddess", "Guard": "guardians", "Heart": "marriage",
    "HeroRoad": "roads", "HugeHead": "outyard", "KingContract": "returning-players", "LordTrial": "trials",
    "MagicPub": "fantasy-bar", "MagicSpring": "fantasy-bar", "MapShop": "shops", "MonsterExplore": "exploration",
    "NavigationShop": "navigation", "OlderReflux": "returning-players", "Pet": "einherjar", "Proficiency": "hero",
    "Question": "customer-service", "QuickPass": "trials", "RandomBoss": "world-boss", "Recipe": "smith",
    "Regress": "returning-players", "Remains": "exploration", "RemotePet": "einherjar", "RevengeRoad": "roads",
    "Secret": "exploration", "SevenYear": "hermitage-war", "ShadowLand": "trials", "ShareTemplate": "friends",
    "Shuttle": "exploration", "Sky": "treasures", "StarArea": "cosmos", "Theseus": "theseus-arena",
    "TimeVortex": "trials", "Titan": "dragon", "UpgradePresent": "vip", "WarSoul": "trials",
    "CarnivalPoint": "seasonal-events", "AreaMap": "campaign", "EvilLand": "trials", "RushCampaign": "campaign",
    "GuideValue": "tutorial", "StackHead": "outyard", "Alchemy": "alchemy", "Archaeology": "archaeology",
    "DarkMaze": "mazes", "EclipticPalace": "ecliptic-palace", "Planes": "planes", "Royalty": "royalty-boss",
    "Stela": "steles", "Stele": "steles", "TalentEffect": "skills", "Vehicle": "artillery", "Minos": "guild",
    "War": "guild", "Guild": "guild", "CampaignBuffer": "world-boss", "Campaigns": "campaign",
}

STRING_ATTRS = re.compile(r'(Name|Desc|Description|Tips|Tip|Title|Content|Info|Msg|Talk|Words|Note|Text|Introduce|Introduction)$')
TEXTUAL = re.compile(r'[A-Za-zÀ-ÿ]')


def load_owner():
    feats = json.loads((ROADMAP / "features.json").read_text())
    pkg2feat = {}
    for slug, f in feats.items():
        for p in f["client_packages"]:
            pkg2feat[p] = slug
    cls2feat = {}
    for c in json.loads((ROOT / "index/classes.json").read_text()):
        parts = c.split(".")
        pkg = parts[2] if c.startswith("mvc.module.") and len(parts) > 3 else parts[0]
        f = pkg2feat.get(pkg)
        if f:
            cls2feat[parts[-1]] = f
    return pkg2feat, cls2feat


def owner(key, pkg2feat, cls2feat):
    for seg in key.split("."):
        if seg in cls2feat:
            return cls2feat[seg]
    pre = key.split(".")[0]
    if pre in pkg2feat:
        return pkg2feat[pre]
    if pre in PREFIX:
        return PREFIX[pre]
    low = key.lower()
    for feat, kws in KEYWORDS:
        for kw in kws.split():
            if kw.lower() in low:
                return feat
    if pre in GLOBAL:
        return "shared-ui"
    return "shared-ui"


def template_owner(stem, features):
    if stem in TEMPLATE_PREFIX:
        return TEMPLATE_PREFIX[stem]
    low = stem.lower()
    for feat, kws in KEYWORDS:
        for kw in kws.split():
            if kw.lower() in low:
                return feat
    for pre, feat in TEMPLATE_PREFIX.items():
        if stem.lower().startswith(pre.lower()):
            return feat
    return "shared-ui"


def xml_strings(path):
    raw = path.read_text(errors="replace")
    rows = re.findall(r"<[A-Za-z_][\w.]*\b[^>]*>", raw)
    out = []
    for r in rows:
        for m in re.finditer(r'([A-Za-z_]\w*)\s*=\s*"([^"]*)"', r):
            attr, val = m.group(1), html.unescape(m.group(2))
            if STRING_ATTRS.search(attr) and TEXTUAL.search(val):
                out.append((attr, val))
    return len(rows), out


def main():
    pkg2feat, cls2feat = load_owner()
    lang = json.loads((ROOT / "index/language.json").read_text())
    texts = {}
    for key, val in lang.items():
        texts.setdefault(owner(key, pkg2feat, cls2feat), []).append((key, val))

    tmpl = {}
    for p in sorted((ROOT / "raw/xml/tempinfos").glob("*.xml")):
        feat = template_owner(p.stem, None)
        tmpl.setdefault(feat, []).append(p)

    all_feats = set(texts) | set(tmpl)
    written = {}
    for feat in sorted(all_feats):
        L = [f"# Texts owned by `{feat}`", "",
             "Generated by `tools/textmap.py`. Language keys come from `index/language.json`; the pt-BR string is the value the client renders. Template strings are extracted from `raw/xml/tempinfos/*.xml` (attributes named Name, Desc, Description, Tip(s), Title, Content, Info, Msg, Talk, Words, Note or Text).", ""]
        keys = sorted(texts.get(feat, []))
        L += [f"## Language keys ({len(keys)})", ""]
        if keys:
            L += ["| key | pt-BR |", "|---|---|"]
            for k, v in keys:
                L.append("| `" + k + "` | " + v.replace("\n", " ").replace("|", "\\|") + " |")
        else:
            L.append("None.")
        L.append("")
        files = tmpl.get(feat, [])
        L += [f"## Template strings ({len(files)} files)", ""]
        if not files:
            L.append("None.")
        for p in files:
            try:
                nrows, strings = xml_strings(p)
            except Exception as e:
                L.append(f"- `{p.name}`: unreadable ({e})")
                continue
            L.append(f"### `{p.name}` ({nrows} rows)")
            if not strings:
                L.append("No text attributes.")
                L.append("")
                continue
            seen = []
            for a, v in strings:
                if (a, v) not in seen:
                    seen.append((a, v))
            cap = 40
            L.append("| attr | text |")
            L.append("|---|---|")
            for a, v in seen[:cap]:
                L.append(f"| {a} | {v.replace(chr(10),' ').replace('|','\\|')} |")
            if len(seen) > cap:
                L.append(f"| ... | +{len(seen)-cap} more |")
            L.append("")
        out = ROADMAP / feat / "texts.md"
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text("\n".join(L))
        written[feat] = (len(keys), len(files))

    total_keys = sum(v[0] for v in written.values())
    print(f"{len(written)} features, {total_keys}/{len(lang)} language keys, {sum(v[1] for v in written.values())} template files")
    for feat in sorted(written, key=lambda f: -written[f][0])[:12]:
        print(f"  {feat:22} keys {written[feat][0]:>5} templates {written[feat][1]:>3}")


if __name__ == "__main__":
    main()
