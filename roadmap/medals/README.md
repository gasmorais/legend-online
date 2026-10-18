# Medals and achievements ("Medalhas e conquistas")

Feature slug `medals`, domain `character`. Registry: client package `hallfame`, proto packages `medal` and `achievementtask` (`roadmap/features.json`). Following the code shows that the feature is really three unrelated systems that only share the "honor and prestige" theme:

| Module | pt-BR name (client) | What it does for the player | Transport |
|---|---|---|---|
| [imperial-medal.md](imperial-medal.md) | "Desenvolver Medalhas", item "Medalha do Império Earl Nv.1..10" | The honor-slot equipment "Medalha do Império Earl" is fed with arena medals ("Medalhas") to gain medal GP, advanced to the next level with "Bastão do Império" once GP and honor (geste) are enough, and renewed for 1 or 15 days because it expires | socket 8838 / 4715 / 4717, proto `medal` |
| [achievements.md](achievements.md) | "Histórico de Conquistas" (tab 2 of the hero road frame) | 436 permanent achievements in 3 categories (character, dungeons, competitive). The server tracks progress, the player claims item rewards | socket 8671 ops 1 and 2 / 4288 / 4289, proto `achievementtask` (+ request `player.PlayerOpMsg`) |
| [achievement-gifts.md](achievement-gifts.md) | "o pacote desaparecerá", package names such as "Pacote de Gemas" | When an achievement flagged `IsPopout` is completed, a limited-time discount package (60 min) is offered for diamonds | socket 8671 ops 3 and 4 / 4288 / 4289 |
| [hall-of-fame.md](hall-of-fame.md) | "Hall de Fama" (tool bar tip "Evento do corredor da fama") | Time-limited event (sum-active type 146): each prize tier unlocks at a fight power ("poder") threshold and can be claimed once | socket 8586 / 4475 / 4476 / 4714 (generic sum-active engine, proto `active`) |

Out of scope although the name matches:
- `PlayerInfo.medalLv` / `PlayerMsg.medal_lv (#104)` / `ConsortiaInfoMsg.medal_lv (#62)` is a guild skill (type 18, `CM/yishi/datas/playerinfo/PlayerInfo.as:1415-1417`, `CM/yishi/utils/ConsortiaSkillHelper.as:54`): see [../guild/README.md](../guild/README.md).
- Arena medal currencies used as shop money (`LeagueMedalIcon`, `assaultwarMedal`, `isLandExploreMedal`, `PlayerCurrencyInfo.arenaMedal`): see [../currency/README.md](../currency/README.md) and [../shops/README.md](../shops/README.md). The imperial medal only spends `arenaMedal`.
- Christmas and seven-year "achievements" (`ChristmasAchievementsTempInfo`, `SevenYearAchievementTempInfo`, `SevenYearAchievementMsg`): see [../seasonal-events/README.md](../seasonal-events/README.md) and [../hermitage-war/README.md](../hermitage-war/README.md).
- The first tab of the hero road frame ("Histórico", chain packages, opcodes 9634 / 407, proto `heroroad`): see [../roads/README.md](../roads/README.md).
- Titles ("appell"): see [../hero/README.md](../hero/README.md).

Conventions used in every module file:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `build/` or `docs/`. `CM` = `core_module/scripts`.
- Opcode names come from `protocol/opcodes.csv`; proto fields from `protocol/proto.json`, tags checked against `build/as3/gen/com/road/yishi/proto/**.ts` `writeTo` (`writeTag(buf, wireType, tag)`).
- *(assumption)* marks anything the client does not prove.
- No HTTP servlet or AMF call is used by this feature.

## Entry points

| Entry | Where | Unlock condition | Opens |
|---|---|---|---|
| Up arrow on the honor equipment slot | Player info equipment panel `HonorCell` (`m5/scripts/playerinfo/view/EquipInfoView.as:304-307`) and the dragon talker equip view (`m5/scripts/dragontalker/view/DragonTalkerEquipView.as:92`) | Own character, equipped item SonType 301 whose TemplateId is in `UpGradeTempInfos` Types 43 (`CM/cell/view/playerequip/HonorCell.as:34-59`) | `army.MedalFrame` via `ArmyControler.openMedalFrame` (`CM/mvc/controler/ArmyControler.as:299-303`) |
| Queue bar button `queueBar.heroRoadBtn2` | Right-side queue bar (`CM/ui/queuebar/QueueBar.as:775-779, 1010-1035`) | Hero level >= 11 and `VersionSwitch.ACHIEVEMENT = true` (`CM/yishi/datas/VersionSwitch.as:218`) | `heroroad.HeroRoadFrame`, achievement tab preselected (`m11/scripts/heroroad/HeroRoadFrame.as:55-61`) |
| Queue bar button `queueBar.popBtn` + countdown | Same bar | Level >= 11, a gift offer active (`currentPopTemplateId > 0`) | `heroroad.HeroRoadGiftFrame` (`QueueBar.as:737-744`) |
| Automatic gift pop-up | On entering the space or castle scene, and on any 4289 while in those scenes | A completed achievement with `isPopout = true` is queued and nothing was popped since the last reset (`HeroRoadManager.count == 0`) | `heroroad.HeroRoadGiftFrame` (`m3/scripts/map/space/SpaceSceneController.as:522-526`, `m4/scripts/castle/CastleSceneView.as:382-386`, `CM/yishi/manager/HeroRoadManager.as:253-258`) |
| Top tool bar button `hallfame` (TopToolBtnInfo 2038 "名人堂") | Top tool bar | A sum-active of type 146 is inside its show window and the scene is castle or space (`CM/ui/toptoolbar/TopBtnCheckShowHelper.as:345-346, 506-513`) | `hallfame.HallFameFrame` (`CM/ui/toptoolbar/TopToolsBar.as:1260-1266`) |

No VIP condition exists in any of the four modules.

## Dependencies

| Feature | Why |
|---|---|
| [../inventory/README.md](../inventory/README.md) | Medal item lives in the honor equip slot (bag type 3); 208041 count; reward and package delivery; bag update pushes |
| [../currency/README.md](../currency/README.md) | `arenaMedal` (currency type 8) spent by feed and renewal; diamonds (`playerInfo.point`) spent by gift packages |
| [../hero/README.md](../hero/README.md) | Honor/geste (`ThaneInfo.honer`) gate for medal advance; fight power for the hall of fame; hero level 11 gate |
| [../shops/README.md](../shops/README.md) | The medal item 3010001 is bought in the honor shop (ShopTempInfo 30034, Honor 6000, NeedGeste 450000) and 208041 in other shops |
| [../roads/README.md](../roads/README.md) | Hosts the frame (`HeroRoadFrame`, `HeroRoadControler`) and `HeroRoadManager` that also serves the hero road tab |
| [../seasonal-events/README.md](../seasonal-events/README.md) | Owns the generic sum-active engine (8586 / 4475 / 4476 / 4714, proto `active`) that the hall of fame is one type of |
| [../mounts/README.md](../mounts/README.md), [../fashion/README.md](../fashion/README.md) | Hall of fame previews mount and fashion rewards |
| Every feature that feeds an achievement condition | See the condition table in [achievements.md](achievements.md) §5 (mazes, guild treasure, archaeology, farm, smith, mounts, quests, runes, dragon soul, talents, world boss, einherjar, planes, trials, guardians, divine weapon, steles/heraldry, dragon talker, goddess, league, ecliptic palace, theseus) |

## Suggested implementation order

1. Template loaders: `UpGradeTempInfos` Types 43, the ten medal items and suites, `AchievementTaskTemplates`, `AchievementTaskBuyDrop`, `ConfigInfos` achievement keys.
2. [imperial-medal.md](imperial-medal.md): table, login push 4717, ops 1/3/4/5, expiry handling in the stat calculator.
3. [achievements.md](achievements.md): table, 4288 at login and on op 1, reward claim op 2, then the progress tracker hooks, one condition type at a time (start with those whose source feature already exists).
4. [achievement-gifts.md](achievement-gifts.md): offer queue, op 3 timer start, op 4 purchase, expiry job.
5. [hall-of-fame.md](hall-of-fame.md): after the sum-active engine of seasonal-events exists; only the type 146 condition evaluator and claim rules are specific.
