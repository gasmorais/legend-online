# Ares battle ("Batalha de Ares")

Feature slug `ares-battle`. Client package `areslords` (`decompiled/m9/scripts/areslords`, models in `decompiled/core_module/scripts/mvc/module/areslords`). Protobuf package `com.road.yishi.proto.areslords`. Client manager `yishi.manager.AresLordsManager`.

Citation prefixes used in every module file: `CM/` = `decompiled/core_module/scripts/`, `M9/` = `decompiled/m9/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`, `PTT` = `CM/yishi/datas/consant/ProtocolTypeTable.as`. "(A)" marks an assumption that the client code does not prove.

## What it is for the player

A weekly, cross server, solo PvP tournament (Chinese name 阿瑞斯之战, PTT:1499). The player pays gold to sign up for the current edition, then on fight day (config `Ares_Day` = 2, `Ares_Time` = 20:00 to 21:00) enters a one-seat waiting room. The server runs a fixed number of turns (`maxTurnCount`); every turn it pairs the waiting players automatically and starts a battle of type 3859 `CROSS_ARESLORDS_BATTLE`. Wins and losses change a persistent score. The score places the player in one of six groups ("Básico", "Profissão", "Especialista", "Mestre", "Lendário", "Titã"), which drives ranking and the reward in "Coração de Ares" (currency 18), spent in "Loja de Ares". In the room the player holds a random set of battle skills ("Almas") from skill MasterType 301 that can be rerolled (3 free, then 20 diamonds).

pt-BR strings: title "Batalha de Ares" (`areslords.title`), edition line "Batalha de Ares  {0}ª edição {1}ª rodada", fight line "{0}ª rodada  Em progresso  {1}/{2}".

## Entry points

| Entry | Condition | Code |
|---|---|---|
| Top bar button `areslords` | `thane.grades >= 36` | `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:351-352`; click `CM/ui/toptoolbar/TopToolsBar.as:1341-1342` -> `AresLordsManager.requestViewInfo` |
| `FrameControllerManager.openControllerByInfo("areslords", n)` from other code (navigation id `areslords`) | same | `CM/yishi/manager/FrameControllerManager.as:1776-1777` |
| Exchange item / shop link | level 36 prompt "Batalha de Ares será disponível ao atingir Nv.{0}" | `decompiled/m5/scripts/armyII/viewII/information/GoodsExchangeItem.as:443` |
| Top bar badge text | push 374 `param1` (0 "Ativado", 1 "Participar da Batalha", 2 "Inscrição inscrever") | `CM/yishi/manager/BaseManager.as:340,2850-2856`; `CM/ui/toptoolbar/TopBtnItemView.as:302-305` |

`requestViewInfo` itself refuses below level 36 with the same prompt (`CM/yishi/manager/AresLordsManager.as:68-72`).

## Modules

| Module | File | Content |
|---|---|---|
| Season and signup | [signup.md](signup.md) | open state, main panel (371), signup frame, start frame, signup with gold |
| Fight room and matches | [room.md](room.md) | enter room (op 5 -> room type 9), `ARESLORDS_ROOM` scene, turn loop, skill reroll, battle 3859, exit |
| Ranking and rewards | [ranking.md](ranking.md) | groups, rank frame (373), reward frame, score decay, weekly reward, shop link |

## Dependencies

| Feature | Why |
|---|---|
| [campaign](../campaign/README.md) | room protocol: 12 `U_C_CAMPAIGN_ROOM_CREATE` (`RoomMsg.roomType = 9`), 120 room member, 5025 room exit, `RoomManager` |
| [shops](../shops/catalog.md) | "Loja de Ares" (`shop` openType 10, currency 18 "Coração de Ares"), buy push 528 |
| [currency](../currency/README.md) | gold (signup), diamonds (`point`, skill reroll), currency 18 |
| [venus-battle](../venus-battle/README.md), [athena-battle](../athena-battle/README.md) | sibling tournaments with the same structure; share code paths in the server |
| Battle engine (`docs/battle/server-engine.md`, `docs/battle/rules.md` type 3859) | automatic PvP battles with trial props |
| Cross server infrastructure ([cross-server](../cross-server/README.md)) | players of several servers share a room pool (`serverName` in every row) |

## Suggested implementation order

1. Tables and the season scheduler (edition, round, open window) from [signup.md](signup.md).
2. Push 374 at login and on state change, op 1 view info (371), op 2 signup.
3. Op 5 enter room: room type 9, 370 push, the turn loop and pairing, battle 3859 with the skill set as trial props.
4. Op 3 skill reroll (372).
5. Score update, group, decay, op 4 ranking (373) and the reward mail at round end.
