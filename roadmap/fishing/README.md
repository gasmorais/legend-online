# Pesca (`fishing`)

Domain: home. Client package `fish` (m11: `fish/FishFrame.as`, `fish/view/*`, `fish/mediator/*`) plus shared code in `core_module`: `managers/FishManager.as`, `mvc/module/fish/*` (model, enter frame handlers, enums), `mvc/controler/FishControler.as`, `cell/view/fishBag/FishBagCell.as`, `yishi/datas/templates/FishTemplateInfo.as` and `cate/FishTemplateCate.as`. Protobuf package `fish` (9 messages). Entry is through the "Caixa do jogo" (`gamebox`, feature [time-story](../time-story/README.md)), game id 1.

## Overview

"Pescar" is a mini game played in an 830 x 370 px pool frame (`FishFrame`, 940 x 560). Fish swim in 5 horizontal channels (y = 80, 160, 220, 280, 340). A harpoon ("lança") swings like a pendulum at the top; a click fires it, it travels down along its angle and hooks every fish it touches. Channel 1 holds obstacles (`IsBlock = 1`) that stop the harpoon. Caught fish give "Moeda do Jogo" (template -4000) or items into a dedicated basket ("Cabaz", bag type 23, 21 cells), fishing experience (40 fishing levels) and weekly points ("Pontos Semanais") for a ranking ("Ranking da Pesca", top 3 receive titles).

Some fish turn "violent" (`fishState = 3`, rage). Hooking one with the normal harpoon pins it: the fisher has 120 s to get 3 helpers ("Pedir auxílio") from world chat, guild chat or by paying diamonds ("robots"), otherwise the fish is landed without the rage bonus. Helpers join from a chat link and receive a help reward.

Four tools, each limited to 5 units and bought for 10 diamonds, change the harpoon or clear the pool: "Míssil Raso", "Míssil Profundo", "Lança Tripla", "Lança Reforçada". The player can fish 20 times per day.

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| NPC dialog option 111 "Caixa do jogo" | hero level >= 28, else "DialogOptionItem.gloryroad.grade.text" with 28 | `gamebox` frame | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:752-759` |
| Game box item "start" button, game id 1 | not in `CAMPAIGN_MAP_SCENE` (tip `worldboss.helper.WorldBossHelper.tip06`) | C>S 9559 `C_GAMEBOX_OP` op 2, `starGameId = 1` | `decompiled/m11/scripts/gamebox/view/GameBoxItemView.as:172-180`, `decompiled/core_module/scripts/managers/GameBoxManager.as:76-83` |
| S>C 257 `U_C_GAMEBOX_GAMESTART` op 2, starGameId 1 | no free team ("Você se encontra na Equipe, não é possível participar no evento da Pesca"), level >= 28 | sends 9507 op 4 and op 1 `[10,20]`, opens controller `fish` | `GameBoxManager.as:116-131,143-174` |
| Chat link type 30 (system chat XML `t="102"`) "help fishing" | not in battle, no Athena team (`braveleg.Error.str08`), not in `OUTER_CITY_SCENE` ("Não pode auxiliar nesta área") | sends 9507 op 6 `[fisherId]` as helper | `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:1195-1230`, `decompiled/core_module/scripts/chat/utils/ChatFormat.as:238-243,417-425` |
| S>C 4920 `U_C_FISH_CRAZY` | any time it arrives (helper side) | opens controller `fish` | `decompiled/core_module/scripts/managers/FishManager.as:82-98` |

While the frame is open the client forces "refuse invitations", "refuse invite" and "refuse team invite" on, restoring them on close (`GameBoxManager.as:157-173`, `decompiled/m11/scripts/fish/FishFrame.as:645-660`).

## Modules

| Module | File | Scope |
|---|---|---|
| Fish pool | [fish-pool.md](fish-pool.md) | session open and close, fish spawning and refresh, harpoon catch, daily count, fishing level and points, tools (use and buy) |
| Rage help | [fish-help.md](fish-help.md) | violent fish, 120 s help window, chat help requests, paid help, helper session and reward |
| Basket and ranking | [fish-basket-ranking.md](fish-basket-ranking.md) | basket (bag 23) pickup, weekly ranking XML and titles |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 9507 | 0x2523 | `C_FISH_POOL` (`FreshPoolMsg`, op 1..13) | all |
| C>S | 9559 | 0x2557 | `C_GAMEBOX_OP` op 2 (not in `protocol/opcodes.csv`; name from `ProtocolTypeTable.as:1455`) | fish-pool (entry) |
| S>C | 257 | 0x0101 | `U_C_GAMEBOX_GAMESTART` | fish-pool (entry) |
| S>C | 4916 | 0x1334 | `U_C_FISH_POOL` | fish-pool, fish-help |
| S>C | 4917 | 0x1335 | `U_C_FISH_CHECK` | fish-pool |
| S>C | 4918 | 0x1336 | `U_C_FISH_INFOS` | fish-pool |
| S>C | 4919 | 0x1337 | `U_C_FISH_HELPOVER` | fish-help |
| S>C | 4920 | 0x1338 | `U_C_FISH_CRAZY` | fish-help |
| S>C | 115 | 0x0073 | `U_C_BAG_MOVE_UPDATE` (`ItemMovedListMsg`, bag type 23) | fish-basket-ranking |
| HTTP | | | `{TPL}fish.xml` ranking | fish-basket-ranking |

`FreshPoolMsg.op` values (`decompiled/core_module/scripts/mvc/module/fish/enums/FishActionEnums.as`):

| op | Constant | paras | Module |
|---|---|---|---|
| 1 | `FRESH_FISH` | `[10,20]` open, `[1,n,id...]` fish left the screen, `[20]` after a missile | fish-pool |
| 2 | `GETALL_FISH` | none | fish-basket-ranking |
| 3 | `COOLCD` | `[1]` or `[0]` (dead code in this client) | fish-pool |
| 4 | `FISHPOOL` | none | fish-pool |
| 5 | `USETOOL` | `[toolId]` | fish-pool |
| 6 | `HELP` | `[fisherUserId]` | fish-help |
| 7 | `SENDHELP` | `[2]` world, `[3]` guild, `[1]` paid help | fish-help |
| 8 | `CLOSE` | none | fish-pool, fish-help |
| 9 | `TIMEOVER` | none | fish-help |
| 10 | `CATCHFISH` | `[fishId...]` or none | fish-pool |
| 11 | `CRAZYFISH` | `[2,fishId]` hooked, `[1,fishId,angle,frame]` rage pinned | fish-pool, fish-help |
| 13 | `TOOL_BUY` | `[toolId]` | fish-pool |

## Dependencies

- [time-story](../time-story/README.md): game box frame and `C_GAMEBOX_OP` (game id 1 = fishing); "Moeda do Jogo" (-4000) is the game box currency.
- [currency](../currency/README.md): diamonds (`point`) for tools and paid help; game box coin -4000.
- [inventory](../inventory/README.md): bag push 115 for bag type 23 and the move to the main bag.
- [chat](../chat/README.md): system chat broadcast with the type 30 help link.
- [team](../team/README.md), [athena-battle](../athena-battle/README.md): team checks at entry.
- [hero](../hero/README.md): titles (appell 100, 101, 102) for the weekly top 3.
- [rankings](../rankings/README.md): weekly ranking generation (`fish.xml`).

## Suggested implementation order

1. Tables `fishing.fishers`, `fishing.sessions`, `fishing.fish` and the template loaders (`FishTemplateInfos.xml`, `UpGradeTempInfos.xml` Types 40, `ConfigInfos.xml` `Fish_*`).
2. 9559 op 2 game id 1 -> 257, then 9507 op 4 -> 4916 and op 1 -> 4918 (spawn engine).
3. Catch loop: op 11 `[2,id]`, op 10 -> 4917, rewards into bag 23, 4916 refresh; op 8 close.
4. Tools: op 13 buy, op 5 use (missiles and harpoon types).
5. Basket: op 2 pickup.
6. Rage help: op 11 `[1,...]`, op 7, op 6 helper join, 4920, 4919, op 9.
7. Daily reset and weekly ranking with titles.
