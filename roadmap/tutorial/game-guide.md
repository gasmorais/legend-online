# Game guide ("Como obter ...?")

Area: tutorial, module `game-guide`. Covers `dayguide.gameguide.GameGuideView`, `GameGuideItem` (`decompiled/m11/scripts/dayguide/gameguide/`) and `mvc.module.gameguide.GameGuideModel`, `GameGuideInfo` (`decompiled/core_module/scripts/mvc/module/gameguide/`).

Conventions: see [README.md](README.md). The surrounding day guide frame (`DayGuideFrame`, sign in, activity points) belongs to [daily-activity](../daily-activity/README.md).

## 1. Overview

A static help panel answering "how do I get gold, equipment, experience, spirit, light crystal?". Five category buttons on the left; on the right a scrollable list of sources, each with a title, a 3 to 5 star rating, a description and an "Ir Agora" link that jumps to the relevant screen. All content is built in client code from `index/language.json`; there is no server data and no request.

In this client build `GameGuideView` is never instantiated (no `new GameGuideView` anywhere in `decompiled/`, and `DayGuideFrame` does not create it, `decompiled/m11/scripts/dayguide/DayGuideFrame.as:69`). The UI module key `gameguide` exists (`decompiled/core_module/scripts/yishi/datas/UIModuleTypes.as:136`) and notification `GAMEGUIDE_PAGE_CHANGE` is declared (`decompiled/core_module/scripts/yishi/events/NotificationEvent.as:112`) but unused. The "Ir Agora" string is reused by m16 task trace tips.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `dayguide.gameguide.GameGuideView` (`decompiled/m11/scripts/dayguide/gameguide/GameGuideView.as:48`) | buttons "Como obter Ouro?", "Como obter Equipamento?", "Como obter Experiência?", "Como obter Espírito?", "Como obter Cristal de Luz?" (`gameguide.GameGuideFrame.goldBtn.text`, `equipBtn`, `expBtn`, `soulBtn`, `crystalBtn`) | Category list and scroll panel; first category selected on open (`:56`) | not reachable in this build (intended: a tab of the day guide frame, Assumption) | `GameGuideModel` lists |
| `dayguide.gameguide.GameGuideItem` (`decompiled/m11/scripts/dayguide/gameguide/GameGuideItem.as:17`) | title, stars (`asset.core.StarLevelImg`), description, link "Ir Agora" (`gameguide.GameGuideFrame.skipNow`) | One source with a shortcut | view | `GameGuideInfo`: `key`, `title`, `starCount`, `describe` (`decompiled/core_module/scripts/mvc/module/gameguide/GameGuideInfo.as:6`) |

## 3. Routes (client to server)

None. The "Ir Agora" handler (`GameGuideItem.__skipHandler` `GameGuideItem.as:104`) only calls `SwitchPageHelp` navigation, which then uses the target feature's own routes.

## 4. Server messages (server to client)

None.

## 5. Rules and formulas

Content of `GameGuideModel` (`decompiled/core_module/scripts/mvc/module/gameguide/GameGuideModel.as:53` to `:240`); titles are `gameguide.GameGuideModel.guideInfoTitleNN`, descriptions `guideInfoDescribeNN`:

| Category | Key | Title | Stars | Description key | "Ir Agora" target (`GameGuideItem.as:104`) |
|---|---|---|---|---|---|
| Experiência | EXP_GET_01 | "Recompensa" | 5 | 01 | `gotoOfferRewardFrame` (bounty quests) |
| Experiência | EXP_GET_02 | "Portal dos Heróis" | 5 | 02 | `gotoHeroDoor` |
| Experiência | EXP_GET_03 | "Fazenda" | 5 | 03 | `gotoFarmFrame` |
| Experiência | EXP_GET_04 | "Labirinto" | 4 | 04 | `gotoMazeFrame` |
| Experiência | EXP_GET_05 | "Campanha" | 4 | 05 | `gotoSingleCampaign` |
| Equipamento | EQUIP_GET_01 | "Mercado" | 5 | 06 | `gotoMarkeFrame` |
| Equipamento | EQUIP_GET_02 | "Portal dos Heróis" | 5 | 07 | `gotoHeroDoor` |
| Equipamento | EQUIP_GET_03 | "Labirinto" | 5 | 08 | `gotoMazeFrame` |
| Equipamento | EQUIP_GET_04 | "Coliseu" | 5 | 09 | `gotoPvpFrame` |
| Equipamento | EQUIP_GET_05 | "Campanha" | 4 | 10 | `gotoSingleCampaign` |
| Ouro | GOLD_GET_01 | "Alquimia" | 5 | 12 | none (no case in the switch) |
| Ouro | GOLD_GET_02 | "Chefão Global" | 5 | 13 | `gotoWorldBossFrame` |
| Ouro | GOLD_GET_03 | "Fazenda" | 5 | 14 | `gotoFarmFrame` |
| Ouro | GOLD_GET_04 | "Saquear" | 4 | 15 | `gotoOuterCity` |
| Ouro | GOLD_GET_05 | "Mina Natural" | 3 | 16 | `gotoOuterCity` |
| Espírito | SOUL_GET_01 | "Convocação" | 5 | 20 | none (no case in the switch) |
| Espírito | SOUL_GET_02 | "Chefão Global" | 5 | 21 | `gotoWorldBossFrame` |
| Espírito | SOUL_GET_03 | "Fazenda" | 5 | 22 | `gotoFarmFrame` |
| Espírito | SOUL_GET_04 | "Monstro Selvagem" | 4 | 23 | `gotoOuterCity` |
| Cristal de Luz | CRYSTAL_GET_01 | "Fazenda" | 5 | 26 | `gotoFarmFrame` |
| Cristal de Luz | CRYSTAL_GET_02 | "Yggdrasil" | 4 | 27 | `gotoFarmFrame` |
| Cristal de Luz | CRYSTAL_GET_03 | "Saquear" | 4 | 28 | `gotoOuterCity` |

The switch also handles keys that the model never creates (`STORE_GET_01`, `GOLD_USE_01..03`, `SOUL_USE_01..02`, `CRYSTAL_USE_01..02`), pointing to the store, guild, star, barracks and seminary screens; they are leftovers of a "how to use" section.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `index/language.json` | `gameguide.GameGuideFrame.*`, `gameguide.GameGuideModel.guideInfoTitle01..21`, `guideInfoDescribe01..28` | all texts |

## 7. Persistent state

None.

## 8. Backend implementation notes

No handler. The shortcuts rely on the target features (bounty quests, hero portal, farm, maze, campaign, market, arena, world boss, outer city) being reachable.

## 9. Open questions and assumptions

- Assumption: the view was a tab of the day guide frame in an older build; it is unreachable now.
- GOLD_GET_01 and SOUL_GET_01 have no shortcut target.

## 10. Implementation checklist

- [ ] Confirm the view stays unreachable (no work) or wire it in a client patch
- [ ] If wired: test each "Ir Agora" target opens the right screen
