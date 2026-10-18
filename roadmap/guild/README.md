# Guild ("Guilda")

Client package `consortia` and related packages (`consortiawar`, `consortiachess`, `consortiaplay`, `guildfb`, Minos). Players create or join a guild and contribute to it. In return they get guild buildings, skills, shops, a warehouse and daily quests. Guild PvE: the boss, the dungeon and the Minos labyrinth. Guild PvP: "Defesa de Guilda" and guild chess.

All guild traffic is socket based; no HTTP routes. PostgreSQL schema: `guild`. Rust handlers: `guild::<module>::handle_<action>`.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| HUD guild button, player without guild | hero level 12 to apply or create | Club lobby: search, apply, invitations, create ([club.md](club.md)) |
| HUD guild button, player in a guild | none | Guild main frame: info, members, buildings, activities |
| Guild activity list | per activity: boss needs guild level 5, "Caçada da Guilda" guild level 10 | [activities.md](activities.md) hub |
| Chat links, mail, notifications | guild events | [logs.md](logs.md) |

## Modules

### Core

| Module | Content |
|---|---|
| [membership.md](membership.md) | Search, create, apply, invite, review applicants, member list (chunked 4133), kick, leave, disband, robot join |
| [ranks.md](ranks.md) | 5 ranks, rights bitmask (4137), vice chairman delegated rights, promote, demote, transfer leadership |
| [election.md](election.md) | Chairman election and impeachment, chairman tools (rename, recruitment broadcast, guild mail) |
| [profile.md](profile.md) | Guild info message, notice, description, level upgrade with fortune, shared cooldown, weekly maintenance, ranking |
| [contribution.md](contribution.md) | Donations in gold, diamonds and spirits; contribution ranking |
| [logs.md](logs.md) | Event log (12 types), login packet order, presence, guild chat, notifications, error alerts |
| [club.md](club.md) | Lobby UI for players without a guild; reuses membership tables and handlers |

### Economy

| Module | Content |
|---|---|
| [funds.md](funds.md) | Currency map (fortune, production, contribution, merit, activity points), shared spend/add API with ledger, reset calendar |
| [buildings.md](buildings.md) | Buildings 1..5, master tower 26, prerequisites, costs, upgrades, push 164 |
| [skills.md](skills.md) | Guild technologies 6..21, master research 22..25, personal learning, altar prayers |
| [treasure.md](treasure.md) | Treasure digging and helping (9629 ops 0..9, reply 390) |
| [warehouse.md](warehouse.md) | Guild warehouse (bag type 6), rented pages, return by mail on leave |
| [shop.md](shop.md) | Guild shop and "Câmara de Comércio" supply and trade (5438) |
| [quests.md](quests.md) | Daily personal, monthly collective and activity track quests (5437, 179, 180) |
| [wants.md](wants.md) | "Caçada da Guilda" hunts (8365, battleType 3890) |

### PvE

| Module | Content |
|---|---|
| [boss.md](boss.md) | "Terra dos Sonhos" (battleType 309, map 7701) and the new guild boss (battleType 3901) |
| [dungeon.md](dungeon.md) | "Campanha da Guilda" dungeon, 120 stages (battleType 3881) |
| [minos.md](minos.md) | "Reino de Minos" labyrinth, 16 x 10 grid (552..557, battleType 3909) |

### PvP

| Module | Content |
|---|---|
| [activities.md](activities.md) | Activity hub and `consortiaplay` index (9729) |
| [war.md](war.md) | "Defesa de Guilda" season: signup, defenders, strategy, rewards (8650 ops 1..5, 12, 13) |
| [cross-server-war.md](cross-server-war.md) | Fight day: towers, action points, attacks (battleType 296), interference (8650 ops 6..11) |
| [chess.md](chess.md) | "Duelo Tático" guild chess (9730, 25232, battleType 3910); disabled in this build |

## Cross-cutting rules

- Changing a player's guild requires both opcode 3 (player info) and opcode 117 (guild state push). 117 makes the client re-request ranks, members and guild info.
- Rights are authoritative on the server (4137). Client rank tables are display only.
- Guild failures have no dedicated packets; errors use the generic alert (assumed opcode 111, see [logs.md](logs.md)).
- Shared ids: `guild.guild(id)` and `public.player(id)` are `integer` across all modules.

## Dependencies

- [../hero/README.md](../hero/README.md): player info opcode 3 carries guild fields and personal guild skill levels.
- [../inventory/README.md](../inventory/README.md): generic bag opcodes 5005, 8220, 8346; warehouse bag type 6.
- [../shops/README.md](../shops/README.md): generic shop opcodes 8693, 8970.
- [../mail/README.md](../mail/README.md): guild mail (8205 send type 2), warehouse returns.
- [../chat/README.md](../chat/README.md): guild channel 5, recruitment message, chat link type 114.
- [../battle/README.md](../battle/README.md): battleTypes 296, 309, 3881, 3890, 3901, 3909, 3910.
- [../daily-activity/README.md](../daily-activity/README.md): activity points feeding guild quests.

## Implementation order

1. `funds`, `profile`, `ranks`, `membership`, `club`: a guild can exist, have members and rights.
2. `logs`, `contribution`, `election`: presence, events, donations, leadership.
3. `buildings`, `skills`, `warehouse`, `shop`, `quests`: progression and economy.
4. `treasure`, `wants`, `activities`: daily guild activities.
5. `boss`, `dungeon`, `minos`: guild PvE (needs the battle engine).
6. `war`, `cross-server-war`, `chess`: guild PvP and scheduled seasons.
