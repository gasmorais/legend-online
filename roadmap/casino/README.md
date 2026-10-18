# Salão de jogo e cassino (casino)

Client packages `gamehall` (m3 UI, core model), `poker`, `blackjack`, `slot`, `bingo` (m11 UI, core models), `apex` (m9 UI, core model) and `monopoly` (core views, m11 minigame frames, m3 campaign UI); protobuf packages `gamehall`, `blackjack`, `bingo`, `apex`, `minigame`. Texas poker uses messages of package `pet`; the Easter hunt uses package `module`; the slot uses package `active`; the cloud adventure uses package `campaign`.

| System | pt-BR | What the player does |
|---|---|---|
| Game hall | "Salão de jogo" | Form teams of up to 4 in a lobby room and start hall games (rapid through, mine field, crisis plan, Easter hunt) |
| Easter egg hunt | "Busca de ovos" (Páscoa) | Spend tickets to clear 120 Easter maps for eggs, level blessings, buy the spring buff, draw eggs in a finite pool |
| Texas poker | "Texas Poker" | Cross server Hold'em twice a day with chips bought with diamonds; 20 percent commission refunded as points for a shop |
| Blackjack | "Chegada do BlackJack" | Pay diamonds per hand against the bank, replace the last card for diamonds, collect score for an exchange pack |
| Bingo | "Maçã Alegre" | Buy bets on card groups with 2 lucky numbers until 19:10; balls called at 19:40; red crystal prizes |
| Slot check-in | "Caça-Niquel" | One reel per event day; the digits form the reward; buy missed days on old servers |
| Apex league | "Liga do Pico" | Weekly cross server 4 player team league with divisions, rounds, bets in "Corações de Gelo" |
| Cloud adventure | "Aventura das Nuvens" | Daily dice board in a campaign map with events, battles, friend help, minigames and a final slot |
| Minigames | "Jogo de 5 Cartas", "Jogo da memória", gem maze | Protocol of package `minigame` used by the air garden and the cloud adventure |

PostgreSQL schema: `casino`. Rust handlers: `casino::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens | Citation |
|---|---|---|---|
| Space NPC dialog option 135 `GAME_HALL` | `VersionSwitch.GAME_HALL`, right scene | `gamehall.GameHallFrame` | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:172, 800-801`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2552-2564` |
| Top toolbar `gamehall` (TopToolBtnInfos 4020 "复活节活动") | 4590 id 4020 open | game hall with the Easter panels | `TopBtnCheckShowHelper.as:389-390`, `TopToolsBar.as:1470-1472` |
| Top toolbar `poker` (4006 "德州扑克") | level 6, castle or space, time box 6 open (`poker_open_time`) | `poker.PokerFrame` | `TopBtnCheckShowHelper.as:289-290`, `TopToolsBar.as:1396-1406` |
| Top toolbar `blackjack` (2045 "黑杰克") | level 6, switch 3060 window | `blackjack.BlackjackFrame` | `TopBtnCheckShowHelper.as:283-284`, `TopToolsBar.as:1274-1276` |
| Top toolbar `bingo` (2032 "开心宾果") | level 11, switch 3068 window | `bingo.BingoFrame` | `TopBtnCheckShowHelper.as:293-294`, `TopToolsBar.as:1290-1292` |
| Top toolbar `slot` (2033 "拉霸") | level 12+, 4901 `open`, castle or space, not in a team | `slot.SlotFrame` | `TopBtnCheckShowHelper.as:339-340`, `TopToolsBar.as:1236-1255` |
| Top toolbar `apex` (4018 "巅峰联赛") | `VersionSwitch.APEX`, level 80 | 5439 op 1 -> `apex.ApexHallFrame` | `TopBtnCheckShowHelper.as:381-382`, `TopToolsBar.as:1450-1452` |
| Space NPC dialog option 26 `MONOPOLY` | level 55 (server), solo | 8823 -> monopoly campaign | `DialogOptionItem.as:90, 609-611` |
| Air garden game nodes | air garden event | 381 -> five card or memory card frames | `decompiled/core_module/scripts/managers/AirGardenManager.as:62, 239-261` |

## Modules

| Module | Content | Opcodes |
|---|---|---|
| [game-hall.md](game-hall.md) | Lobby, team lifecycle, invites, movement, formation, game schedule (`GameHallTemplates.xml`) | 8646, 8647, 8648, 8649 -> 4561, 4562, 4563, 4564, 4565 |
| [easter-egg-hunt.md](easter-egg-hunt.md) | Tickets, maps, blessings, spring buff, egg lottery pools | 8655 -> 4585, 4587; 4590 (4020) |
| [texas-poker.md](texas-poker.md) | Queue, chips, table protocol, actions, pots, commission and points | 9571, 25165, 25166, 25167 -> 277..293, 328 |
| [blackjack.md](blackjack.md) | Tables, hand flow, gold card, exchange | 9565 -> 268, 269, 271 |
| [bingo.md](bingo.md) | Card groups, bets, lucky numbers, draw, pool | 9625 -> 386 |
| [slot-machine.md](slot-machine.md) | Daily reels, missed days, collect | 9500 -> 4901 |
| [apex-league.md](apex-league.md) | Teams, sign up, rounds, divisions, bets, rank, room | 5439 -> 184, 185, 191, 528, 4214, 4681..4689, 4807 |
| [cloud-adventure.md](cloud-adventure.md) | Dice board, node events, battles, friend help, finish slot | 8823..8836 -> 4710..4722, 259 |
| [minigames.md](minigames.md) | Package `minigame`: five card poker, air garden memory card, gem maze messages | 5443, 5444 -> 192..195; gem maze definitions |

Out of scope (owned elsewhere): game box frame and its game list (`GameBoxManager` 256, 257, [../time-story/README.md](../time-story/README.md)); air garden event and link game ([../seasonal-events/README.md](../seasonal-events/README.md), [../mazes/README.md](../mazes/README.md)); standalone gem maze 9508..9517 ([../mazes/README.md](../mazes/README.md)); crisis game 9675 ([../trials/README.md](../trials/README.md)); land mine ([../final-defense/README.md](../final-defense/README.md)); glory game bets 9694, 9699 ([../glory-supremacy/README.md](../glory-supremacy/README.md)); memory games of events ([../memory-games/README.md](../memory-games/README.md)).

## Dependencies

| Feature | Why |
|---|---|
| [../account/switches.md](../account/switches.md) | Switches 3060 (blackjack) and 3068 (bingo) in push 4422 |
| [../currency/README.md](../currency/README.md) | Diamonds, bound diamonds, gold; Easter tickets and eggs (4725 types 36, 35); apex coin; red crystals |
| [../hero/README.md](../hero/README.md) | Extra fields 6, 7 (poker), 22 (hall game 2) in 260; level gates |
| [../shops/README.md](../shops/README.md) | Shops 1003 (poker), 1015 (apex), bingo shop "Loja da Maçã" |
| [../campaign/README.md](../campaign/README.md) | Campaign map sessions for hall games and the cloud adventure; rooms for apex |
| [../einherjar/README.md](../einherjar/README.md) | Spirit and Einherjar formation and skills in the cloud adventure (8725, 8726) |
| [../friends/README.md](../friends/README.md) | Invites, blacklist checks, friend help |
| [../cross-server/README.md](../cross-server/README.md) | Poker tables, bingo pool and apex league are cross server |
| [../mail/README.md](../mail/README.md) | Overflow rewards |
| [../inventory/README.md](../inventory/README.md) | Item rewards, push 115 |

## Suggested implementation order

1. [slot-machine.md](slot-machine.md), [blackjack.md](blackjack.md): single player, small state.
2. [game-hall.md](game-hall.md): lobby needed by the hall games.
3. [bingo.md](bingo.md): daily job and pool.
4. [cloud-adventure.md](cloud-adventure.md) and [minigames.md](minigames.md): need campaign sessions and battles.
5. [texas-poker.md](texas-poker.md): real time table engine.
6. [easter-egg-hunt.md](easter-egg-hunt.md): seasonal, depends on the hall and campaigns.
7. [apex-league.md](apex-league.md): cross server league, battles and rooms.
