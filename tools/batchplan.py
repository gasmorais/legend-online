#!/usr/bin/env python3
import json
import pathlib
import re

ROOT = pathlib.Path(__file__).resolve().parent.parent

TEMPLATE_MAP = {
    "AlchemyFormulaTemplates": "alchemy", "AlchemyMineTemplates": "alchemy",
    "ApexRewardDrop": "casino", "ApexRewardSingleDrop": "casino",
    "ArchaeologyBookTemps": "archaeology",
    "BoxItems": "inventory",
    "BuildingResInfos": "castle",
    "CarnivalLuckDrawTemplates": "seasonal-events", "CarnivalPointExchangeTemplates": "seasonal-events",
    "ChildAssistUpgradeTemplates": "guardians", "ChildCampTemps": "guardians",
    "ChildPatrolMissionTempInfos": "guardians", "ChildPvpRewardTmpls": "guardians", "ChildPvpTmpls": "guardians",
    "ChristmasActivitiesTemplates": "seasonal-events",
    "ConsortiaLevelInfos": "guild", "ConsortiaTreasureTempInfos": "guild", "ConsortiaWantDrop": "guild",
    "CrisisDrop": "trials", "CrisisEventInfos": "trials", "CrisisMapInfos": "trials",
    "EasterTemplates": "seasonal-events",
    "ExpeditionFightDrop": "guardians", "ExpeditionTemplates": "guardians",
    "ExploitsShopTemplates": "shops",
    "ExploreEventTemplates": "exploration",
    "FashionPolishs": "fashion",
    "FinalRoadChapterTemplates": "roads", "FinalRoadGroupTemplates": "roads", "FinalRoadLevelTemplates": "roads",
    "FirstPayDrop": "recharge",
    "FishTemplateInfos": "fishing",
    "ForbiddenBossTemplates": "forbidden-boss",
    "FurnitureShopTempInfos": "farm", "FurnitureTempInfos": "farm",
    "GameBoxShopTempInfos": "time-story",
    "GameHallTemplates": "casino",
    "GloryRoadBufferInfos": "roads", "GloryRoadDrop": "roads",
    "GoddessEquipmentTempInfos": "goddess", "GoddessUnitedResiTemplates": "goddess", "GoddessUnitedSkillTemplates": "goddess",
    "AreaMapDropInfos": "campaign", "EvilLandDrop": "trials", "RushCampaignDrop": "campaign",
    "GuardPVETemp": "guardians", "GuardPvpDrop": "guardians",
    "GuideValueTemps": "tutorial",
    "HeartTempInfos": "marriage",
    "HeroRoadTempInfos": "roads",
    "HugeHeadMapNodeTempInfos": "outyard", "StackHeadExploreTempInfos": "outyard",
    "KingContracts": "returning-players",
    "LordTrialTempInfos": "trials",
    "MagicPubChatInfos": "fantasy-bar", "MagicPubNpcInfos": "fantasy-bar", "MagicSpringTempInfos": "fantasy-bar",
    "MapShopItemTemplateInfos": "shops",
    "MonsterExploreDrop": "exploration", "MonsterExploreTemplates": "exploration",
    "NavigationShopTempInfos": "navigation",
    "OlderRefluxTempInfos": "returning-players",
    "PetChallengeRewards": "einherjar", "PetComponseInfos": "einherjar", "PetContracTempInfos": "einherjar",
    "ProficiencyTemplates": "hero",
    "QuestionTemplates": "customer-service",
    "QuickPassRewards": "trials",
    "RandomBossBuffInfos": "world-boss",
    "RecipeTemplates": "smith",
    "RegressTemplateInfos": "returning-players",
    "RemainsExploreBox": "exploration", "RemainsExploreChapterTemps": "exploration",
    "RemainsExploreDrop": "exploration", "RemainsExploreEventTemps": "exploration",
    "RemainsExploreNodeTemps": "exploration", "RemainsLeedTemps": "exploration",
    "RemotePetTempInfos": "einherjar",
    "RevengeRoadBoxDrop": "roads", "RevengeRoadDrop": "roads", "RevengeRoadTemplates": "roads",
    "SecretEventTemplates": "exploration", "SecretMapLevelTemplates": "exploration", "SecretSonLevelTemplates": "exploration",
    "SevenYearAchievementTemplates": "hermitage-war", "SevenYearQuestionTemplates": "hermitage-war",
    "ShadowLandBoxDrop": "trials", "ShadowLandFightDrop": "trials",
    "ShareTemplateInfos": "friends",
    "ShuttleRewardTempInfos": "exploration", "ShuttleTempInfos": "exploration",
    "ActionTempInfos": "battle",
    "SkyOrderRewards": "treasures", "SkyRewards": "treasures", "SkyStepDrop": "treasures",
    "SkyTrialEventTempInfos": "trials", "SkyTrialPortalTempInfos": "trials",
    "StarAreaRoadInfos": "cosmos",
    "TalentEffectTempInfos": "skills",
    "TheseusMultiPvpIntegralTmpls": "theseus-arena", "TheseusMultiPvpRewardTmpls": "theseus-arena",
    "TheseusMultiPvpTmpls": "theseus-arena", "TheseusPvpIntegralTmpls": "theseus-arena",
    "TheseusPvpRewardTmpls": "theseus-arena", "TheseusPvpTmpls": "theseus-arena",
    "TimeVortexRewards": "trials",
    "TitanTempInfos": "dragon",
    "UpgradePresentBoxDrop": "vip",
    "WarSoulTmpls": "trials", "WarSoulTowerStageRewardTemplates": "trials",
}

OPCODE_MAP = {
    4796: "hero", 5009: "tutorial", 5128: "army", 5159: "army", 5162: "army", 8194: "army",
    5193: "team", 4883: "team", 8251: "world-boss", 8287: "daily-activity",     8333: "battle", 8541: "guild", 8542: "guild", 8593: "guild",
    8468: "guild", 8471: "guild", 8478: "guild", 8546: "guild", 8547: "guild", 8550: "guild",
    8551: "guild", 8565: "guild", 8566: "guild", 8743: "guild", 4377: "guild", 4378: "guild",
    4379: "guild", 4380: "guild", 4436: "guild", 4632: "guild",
    8485: "castle", 8583: "artillery", 8633: "mines", 8796: "account", 8803: "quiz",
    8967: "marriage", 9550: "account", 4980: "account", 9590: "friends", 4921: "friends",
    9612: "castle", 9655: "cross-server", 10510: "battle", 20008: "account", 20009: "account",
    4123: "campaign", 4127: "campaign", 4165: "campaign", 4206: "campaign", 4240: "campaign",
    4247: "campaign", 4265: "campaign", 4789: "campaign", 4623: "campaign", 8195: "campaign",
    4413: "daily-activity", 4433: "exchange", 4438: "world-map",
    4464: "cross-server", 4482: "cross-server", 4494: "cross-server",
    4548: "mines", 4549: "mines", 4618: "hero", 4619: "einherjar",
    4643: "three-kingdoms", 4644: "three-kingdoms", 4663: "dragon", 4664: "dragon",
    4718: "inventory", 4891: "abyss",
}

SCREEN_KEYWORDS = [
    ("guardians", "child children battleGuard guardPvp guardpve childpvp spiritExpedition"),
    ("guild", "consortia guild newGuild minos"),
    ("campaign", "campaign room tollgate mopUp hangUp escort copyNode selectCampaign"),
    ("casino", "bingo slot poker blackjack gameHall apex monopoly"),
    ("lotteries", "lottery roulette wishPool gashapon pumping foison horn"),
    ("seasonal-events", "christmas carnival carnval easter newyear birthday culture year2023 karneval rave airgarden dionysia sheep"),
    ("trials", "warSoul lordTrial crisis timeVortex shadowLand skyTrial skybox rapid singlePass quickPass demonland"),
    ("roads", "finalRoad gloryRoad goldRoad heroRoad redemptionRoad increasing revenge road"),
    ("einherjar", "pet challenge petBoss petLand petHallows"),
    ("theseus-arena", "theseusPvp theseusDouble"),
    ("theseus", "theseus godHead thssTower collention"),
    ("dragon", "dragon titan"),
    ("athena-battle", "braveleg athena"),
    ("ares-battle", "areslords ares"),
    ("venus-battle", "matelords multilords mateLords"),
    ("world-boss", "worldBoss specialBoss randomBoss"),
    ("castle", "castle building seminary blessing transmitter activityQueue technology landUp"),
    ("vip", "vip monthCard registWelfare upgradePresent"),
    ("recharge", "firstPay pay rebate encoGold publicchairs feedback chargelottery"),
    ("mounts", "mount avartar wildSoul"),
    ("fishing", "fish"),
    ("navigation", "navigation boat port"),
    ("shops", "shop mall limiteTimeDiscount buy"),
    ("auction", "auction sale"),
    ("exchange", "exchange allman lucky"),
    ("mazes", "maze llk linkGame gemmaze darkmaze evilLand"),
    ("mines", "mine fund vein tramcar"),
    ("quiz", "quiz answer question"),
    ("customer-service", "questionnaire customerService questionNaire"),
    ("exploration", "secret remains explore seek shuttle monsterExplore"),
    ("goddess", "goddess daimon"),
    ("cosmos", "star stargazing starArea"),
    ("marriage", "marry wedding heart"),
    ("friends", "friend sns fb share rose"),
    ("mail", "mail email"),
    ("army", "army formation soldier"),
    ("team", "team group mission"),
    ("monsters", "monster summon"),
    ("inventory", "bag box pandora slate item rune jewel goods equipConcise equipContrast"),
    ("hero", "thane hero appell vocation"),
    ("smith", "intensify fortify"),
    ("magic-cards", "magicCard"),
    ("auto-chess", "pawn"),
    ("world-map", "worldMap outerCity areaMap"),
    ("outyard", "outyard hugeHead stackHead titanLand"),
    ("fashion", "fashion tattoo polish"),
    ("memory-games", "memoryCard sqmemory"),
    ("time-story", "gameBox timeStory"),
    ("sky-realm", "space skyRealm"),
    ("alchemy", "alchem"),
    ("assistant", "antaeus"),
    ("rankings", "rank sort"),
    ("league", "pvpLeague"),
    ("arena", "dreamArena colosseum"),
    ("cat-house", "catToy cathouse"),
    ("artillery", "vehicle mapPhysics"),
    ("account", "indulge"),
    ("farm", "waterTree"),
    ("treasures", "skyStep treasure"),
    ("battle", "battle fight warfield revive"),
]


def screen_feature(cls, assigned):
    if assigned and not assigned.startswith("unassigned package"):
        return assigned
    name = cls.split(".")[-1]
    lower = cls.lower()
    for feat, kws in SCREEN_KEYWORDS:
        for kw in kws.split():
            if kw.lower() in lower:
                return feat
    return "shared-ui"


def main():
    cov = (ROOT / "roadmap/COVERAGE.md").read_text()
    sections = {}
    cur = None
    for line in cov.splitlines():
        if line.startswith("## "):
            cur = line[3:].strip()
            sections[cur] = []
        elif cur:
            sections[cur].append(line)
    feats = json.loads((ROOT / "roadmap/features.json").read_text())

    batches = {}
    for line in sections.get("Uncovered screens", []):
        m = re.match(r"^\| ([\w.]+) \| (\w+) \| (.*?) \| (.*?) \|$", line)
        if not m or m.group(1) == "class":
            continue
        cls, mod, title, assigned = m.groups()
        feat = screen_feature(cls, assigned.strip())
        b = batches.setdefault(feat, {"screens": [], "templates": [], "opcodes": []})
        b["screens"].append({"class": cls, "module": mod, "title": title})

    for line in sections.get("Uncovered templates", []):
        m = re.match(r"`raw/xml/tempinfos/([\w.]+)`", line.strip().strip("|").strip())
        if not m:
            continue
        stem = m.group(1).rsplit(".", 1)[0]
        feat = TEMPLATE_MAP.get(stem, "RESEARCH")
        batches.setdefault(feat, {"screens": [], "templates": [], "opcodes": []})["templates"].append(stem)

    table = {}
    t = (ROOT / "decompiled/core_module/scripts/yishi/datas/consant/ProtocolTypeTable.as").read_text(errors="replace")
    for m in re.finditer(r'(\d+)\s*:\s*"\d+\s+(\w+)\s+([^"]*)', t):
        table[int(m.group(1))] = (m.group(2), m.group(3).strip())
    for line in sections.get("Uncovered opcodes", []):
        m = re.match(r"^\| (send|accept) \| (\d+) \| (0x[0-9a-f]+) \| (\w+) \|$", line)
        if not m:
            continue
        d, c, h, n = m.group(1), int(m.group(2)), m.group(3), m.group(4)
        desc = table.get(c, ("", ""))[1]
        feat = OPCODE_MAP.get(c, "RESEARCH")
        batches.setdefault(feat, {"screens": [], "templates": [], "opcodes": []})["opcodes"].append(
            {"dir": d, "code": c, "name": n, "desc": desc})

    (ROOT / ".batches.json").write_text(json.dumps(batches, ensure_ascii=False, indent=1))
    total = sum(len(b["screens"]) + len(b["templates"]) + len(b["opcodes"]) for b in batches.values())
    print(f"{len(batches)} batches, {total} items")
    for k in sorted(batches, key=lambda k: -(len(batches[k]['screens']) + len(batches[k]['templates']) + len(batches[k]['opcodes']))):
        b = batches[k]
        print(f"{k:22} screens {len(b['screens']):>3}  templates {len(b['templates']):>3}  opcodes {len(b['opcodes']):>3}")


if __name__ == "__main__":
    main()
