# Seasonal events ("Eventos sazonais")

Domain: events. Time limited events of Legend Online BR (Christmas, Carnival, New Year, anniversaries, summer events, cross-server races) and the generic activity framework they share: the "Destaques" sum-active engine, the cccactive gateway and the event window pushes.

Registry (`roadmap/features.json`): client packages `christmas`, `carnival`/`carnvial`, `raveparty`, `publicegg`, `newyearact`, `newyearactivity`, `year2023`, `birthday`, `cultureactive`/`culture`, `funny`, `specialfunny`, `airgarden`, `goldenDionysia`, `goldensheep`, `sevenyear_events`; proto packages `christmas`, `carnival`, `culture`, `giftparty`, `airgarden`, `active`, `active.anniversary`, `cccactive`, `universalActive`, `sumpassion`.

## Conventions

- Citations: `decompiled/<module>/scripts/<path>.as:line`. Abbreviations: `CM` = `decompiled/core_module/scripts`, `M3` = `decompiled/m3/scripts`, `M4` = `decompiled/m4/scripts`, `M9` = `decompiled/m9/scripts`, `M11` = `decompiled/m11/scripts`, `M15` = `decompiled/m15/scripts`. Each module defines its own short names for its managers (for example `CHM` = `CM/yishi/manager/ChristmasManager.as`).
- Templates are in `raw/xml/tempinfos/`; pt-BR strings come from `index/language.json` and are quoted verbatim.
- Protobuf fields are written `name (#tag, TYPE[, repeated])` with the wire names of the decompiled classes (`CM/com/road/yishi/proto/<package>/<Message>.as`).
- Tables use the schema `seasonal_events`; every per player table references `player.players(player_id)` (BIGINT). Event instances reference `seasonal_events.event_windows` ([active-framework.md](active-framework.md)).
- "(assumption)" marks behaviour the client does not reveal.

## Entry points

| Event | Entry | Unlock / visibility | Window source |
|---|---|---|---|
| "Destaques" / "Eventos magníficos" | Tool bar `funny` (1001) | `grades >= 6` | 4475 activities |
| Open server events | Tool bar `tiro` (2003) | tiro activities with `isInitiate > 0` | 4475 |
| "Pacote Online", "Pacote Online Fixo", "Loucura do Povo" | Tool bar `online` (3001), `timing` (2005), `karneval` (2009) | `grades >= 11` and activity types 14, 50, 51 | 4475 |
| "Carnaval de Natal" (Christmas) | Tool bar `christmas` (4030) | `VersionSwitch.CHRISTMAS` and 4590 id 4030 | 4590 |
| Carnival ("Folia") | Tool bar `carnival` (4025) | 4590 id 4025 | 4590 |
| Rave party | Tool bar `raveparty` (2011) | `grades >= 11`, 401 state 1 | 401 |
| Summer carnival (eggs, gifts) | Tool bar `publicegg_total` (2027), `publicegg_egg` (2028), `publicegg_sumgift` (2029) | `grades >= 6`, 416 / 418 | 416, 418 |
| Recharge crowdfunding | Tool bar `publicchairs` (2015) | `grades >= 6`, 414 | 414 |
| "Verão 9 dias" | Tool bar `sumcampaign` (2030) | `grades >= 6`, 426 | 426 |
| New Year login, New Year chest | Tool bar `newyear` (2043), `newyearlottery` (2018) | `grades >= 11`, switch 2005, 4708 window | 4422, 4708 |
| Anniversary 2023 | Tool bar `sevenyear` (2061, opens `yearactive`) | 4590 id 2061 | 4590 |
| Seventh anniversary hub | after a star area battle (`sevenyear` openType 1) | 4986 | 4986 ([../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md)) |
| Game birthday board | Anniversary NPC dialog options 36..38 | switch 2007 | 4422 |
| Whole server training | Tool bar `cultureactive` (2046) | `grades >= 11`, 435 | 435 |
| Golden Dionysia | Tool bar `goldendionysia` (2047) | `grades >= 6`, 443 | 443 |
| Golden sheep | Resource bar button, tool bar info icon `goldensheep` (2053) | `VersionSwitch.GOLDEN_SHEEP`, 4881 state | 4881 |
| Air garden | Space NPC dialog options 137..144 | `VersionSwitch.AIR_GARDEN` (false in this client), job advanced (`vocationGrades > 0`) | 376 |

## Modules

| Module | Content | C>S routes | S>C messages |
|---|---|---|---|
| [active-framework.md](active-framework.md) | Event windows, sum-active engine, cccactive gateway (14 sub-events), proto ownership index | 8586, 9645, 5049 | 4475, 4476, 4714, 4590, open-state pushes |
| [funny.md](funny.md) | "Destaques" frame, special frames (tiro, online, timing, karneval), activity codes, group buy, mount rebate, condition catalogue (175 condition ids) | 8586, 5049, HTTP `activecheck` and `activecodeservlet`, 8645, 9523, 8843 | 4475, 4476, 4714, 4251, 166, 4559, 4560, 338, 4723, 4492 |
| [christmas.md](christmas.md) | "Carnaval de Natal": light and wish, packs, daily quiz, lucky digits, jackpot, snowy mist team exploration, spending crit, achievements | 9217 (23 ops) | 558, 559, 560, 567, 4590 |
| [carnival.md](carnival.md) | "Folia": points, recharge wheel, lucky digits, packs, treasure, daily tasks, mini games, online boxes | 9019 (9 ops) | 4304, 4305, 4590, 381 |
| [air-garden.md](air-garden.md) | Air garden parties (disabled) and the link game; launcher of the five card and memory games | 5442, 8859 (5443, 5444 via casino) | 376..381, 4736 (192..195 via casino) |
| [rave-party.md](rave-party.md) | Cross-server points ladders and ranks | 9630 (4 ops) | 393, 400, 401, 402, 403 |
| [public-egg.md](public-egg.md) | Summer carnival: eggs, summer gifts, summon tab | 9640, 9642 | 416, 417, 418, 419 |
| [crowdfunding.md](crowdfunding.md) | Recharge crowdfunding rounds | 9638 | 414, 415 |
| [summer-campaign.md](summer-campaign.md) | "Verão 9 dias" dungeon tasks | 9639 | 425, 426 |
| [new-year.md](new-year.md) | New Year login calendar, chest lottery, consumption rebate (type 49) | 8816, 8817, 8818 | 4704..4708, 4422 |
| [year-2023.md](year-2023.md) | Anniversary 2023 screens and rewards (protocol shared with daily-activity) | 9728 (9 ops) | 551, 4590 |
| [seven-year.md](seven-year.md) | Pointer to the 7th anniversary hub owned by hermitage-war; `active.anniversary` catalogue | (9692, 9695 there) | (4986..4989, 200, 4898 there) |
| [birthday.md](birthday.md) | Birthday wishing board, reward and buff | 8984 (4 ops) | 4972, 4422 |
| [culture.md](culture.md) | "Evento de Adestração": personal, guild and server training goals and ranks | 9647 (3 ops) | 435, 436, 437 |
| [golden-dionysia.md](golden-dionysia.md) | Cross-server spending jackpot with dice draw | 9645/25 | 440, 441, 443 |
| [golden-sheep.md](golden-sheep.md) | Timed server-wide lucky box | 9645/31 | 4881 |

## Dependencies

| Feature | Why |
|---|---|
| [../currency/README.md](../currency/README.md) | Diamond, bound diamond and virtual currency grants and spends (-400, -500, -20000 "Pontos de Folia", -22005 "Pontuação do Mistério do Nevoado", -15000 warrior points, -1801 keys); recharge and spend hooks feed most events |
| [../recharge/README.md](../recharge/README.md) | Recharge events (totals per event and per day); owns sum-active types 15, 2500, 2501 and `encoGold` |
| [../inventory/README.md](../inventory/README.md) | Item grants, bag space checks, Pandora (9645/23), rental bag messages of `active` |
| [../account/switches.md](../account/switches.md) | Switches 2005 (New Year login) and 2007 (birthday) |
| [../cosmos/stararea.md](../cosmos/stararea.md) | Star area mini games used by Christmas snowy mist, the anniversary games and the air garden link game |
| [../casino/minigames.md](../casino/minigames.md) | Five card and memory card handlers (5443, 5444) used by Carnival and the air garden |
| [../mazes/link-game.md](../mazes/link-game.md), [../mazes/dark-maze.md](../mazes/dark-maze.md) | Standalone link game (dormant), anniversary exploration (dark maze) |
| [../daily-activity/year-activity.md](../daily-activity/year-activity.md) | Protocol and state of the anniversary 2023 (9728/551) |
| [../hermitage-war/seven-year-event.md](../hermitage-war/seven-year-event.md) | 7th anniversary hub and the collection treasure box (9695/4898) reused by 2023 |
| [../medals/hall-of-fame.md](../medals/hall-of-fame.md) | Sum-active type 146 |
| [../cross-server/README.md](../cross-server/README.md) | Cross-server consumption and recharge ranks (types 67, 73, 196, 197, 345), Hephaestus ore (9645/35), rave party and culture aggregation |
| [../daily-activity/README.md](../daily-activity/README.md) | Login activity (types 131, 231), super sign-in card (9645/38), daily activity points for the rave party |
| [../returning-players/README.md](../returning-players/README.md) | Regression types 4 and 1007 and the returner messages handled in `FunnyManager` |
| [../lotteries/README.md](../lotteries/README.md), [../vip/README.md](../vip/README.md), [../laboratory/platinum-pot.md](../laboratory/platinum-pot.md), [../treasures/README.md](../treasures/README.md) | cccactive sub-events and sum-active types 70 and 145 |
| [../shops/README.md](../shops/README.md) | Hot buy, VIP buy, group buy goods, event shops (2023 coins) |
| [../goddess/README.md](../goddess/README.md) | "Forja Dupla da Deusa" entry (232) and goddess level activities |
| [../mounts/mount-core.md](../mounts/mount-core.md) | Mount grade change sends 8843 for the mount rebate (type 62) |
| [../alchemy/README.md](../alchemy/README.md) and every feature named in the condition catalogue ([funny.md](funny.md)) | Progress hooks for sum-active conditions and for culture goals |
| [../guild/README.md](../guild/README.md) | Guild membership for rave party and culture guild scopes |
| [../campaign/README.md](../campaign/README.md), [../battle/README.md](../battle/README.md) | "Verão 9 dias" dungeon maps 6001..6009 and their battles; air garden campaign map |
| [../artillery/README.md](../artillery/README.md), [../glory-supremacy/README.md](../glory-supremacy/README.md), [../auto-chess/README.md](../auto-chess/README.md) | Anniversary hub tabs |
| [../fantasy-bar/README.md](../fantasy-bar/README.md), [../marriage/README.md](../marriage/README.md) | Owner of `giftparty`; marriage delegates the `party` proto (rave party) here |

## Suggested implementation order

1. [active-framework.md](active-framework.md): event windows and scheduler, sum-active tables, 4475 paging, 8586 query and claim, `record_progress` hooks, 9645 dispatcher. Many features depend on it.
2. [funny.md](funny.md): the "Destaques" frame on top of the engine, online and timing chests, then activity codes.
3. Recharge and spend driven events with simple state: [golden-sheep.md](golden-sheep.md), [crowdfunding.md](crowdfunding.md), [public-egg.md](public-egg.md), [new-year.md](new-year.md), [birthday.md](birthday.md).
4. Ladders and ranks: [rave-party.md](rave-party.md), [culture.md](culture.md), [golden-dionysia.md](golden-dionysia.md) (needs cross-server aggregation).
5. Hub events: [carnival.md](carnival.md) (with the air garden link game from [air-garden.md](air-garden.md) and casino games), [christmas.md](christmas.md) (snowy mist last), [year-2023.md](year-2023.md).
6. Optional: [summer-campaign.md](summer-campaign.md) (needs campaign maps), air garden parties (disabled in this client), the 7th anniversary hub via hermitage-war.

## Notable gaps

- `sevenyear_events` is not a client package; the hub is `sevenyear`, registered to hermitage-war ([seven-year.md](seven-year.md)).
- `publicchairs`, `sumcampaign` and `exchangebox` are not in the registry; the first two use this feature's proto packages and are mapped here ([crowdfunding.md](crowdfunding.md), [summer-campaign.md](summer-campaign.md)); `exchangebox` (fashion and mount lottery, 9613/367..369) has no owner (listed in [active-framework.md](active-framework.md)).
- `ChristmasTreeManager` (4957..4963, 9542) is dead code ([christmas.md](christmas.md)).
- Opcodes 4559, 4560, 4723 and 8843 are missing from `protocol/opcodes.csv`.
