# Activity queue (QueueBar daily counters)

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| QI | `decompiled/core_module/scripts/ui/queuebar/view/QueueItem.as` |
| BOI | `decompiled/core_module/scripts/yishi/datas/playerinfo/BuildingOrderInfo.as` |

## 1. Overview

The left side QueueBar ("左侧队列") lists daily activity counters such as "Bênção da Guilda 3/30" or "Recompensa 12/20" with an optional countdown. Each counter is a `BuildingOrderInfo` with `orderType = 4` stored in `BuildingModel.activeOrderList` (`BMOD:16-48`, `BMOD:102-128`). Values come from 366 `U_C_ACTIVE_QUEUE_LIST` (`building.ActiveQueueListMsg`, a castle owned protobuf) and from pushes of the owning features that `QueueBarManager` intercepts. Clicking an item jumps to the activity.

This module owns the 366 message and the list assembly. Every counter value is owned by the feature listed in the table of section 5.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ui.queuebar.QueueBar` (QB) | none | Vertical list: "Pontos de Atividade" item (Leader >= 6), daily sign in item, time vortex item (after class advancement), then one item per active order (`QB:831-1008`) | castle and other scenes HUD | counters, countdowns |
| `ui.queuebar.view.QueueItem` (QI) | per order, for example "Bênção da Guilda {0}/{1}" (`QI:324-450`) | Title, countdown (`QI:479-500`), speed up button for orders 5 and 6 (`QI:180-221`) | QB | `currentCount`, `totalCount`, `remainTime` |

## 3. Routes (client to server)

The list has no request of its own. Item clicks open other features (`QB:235-347`, see [hud.md](hud.md)). The speed up button for orders 5 and 6 uses the arena and einherjar cooldown routes ([../arena/README.md](../arena/README.md), [../einherjar/README.md](../einherjar/README.md)).

## 4. Server messages (server to client)

### S1. 366 (0x016e) `U_C_ACTIVE_QUEUE_LIST`

Message `building.ActiveQueueListMsg`. Receiver `QBM.__loadActiveQueueListHandler` (`QBM:109-165`).

| Field | Tag, type | Meaning |
|---|---|---|
| `list` | #1 MESSAGE `ActiveQueueMsg`, repeated | counters |
| `op` | #2 INT32 | 4 = outyard only update; any other value = full or partial list |

`building.ActiveQueueMsg`:

| Field | Tag, type | Meaning |
|---|---|---|
| `type` | #1 INT32 | order id 1..16 (section 5) |
| `current` | #2 INT32 | remaining uses (shown as `{0}`) |
| `max` | #3 INT32 | daily maximum (shown as `{1}`) |
| `count_down_time` | #4 INT32 | seconds until refresh or cooldown end; client counts down every second (`BOI:44-72`) |

Client behavior: for each entry, an existing order with the same id is updated; a new id creates an order that is appended (`QBM:138-160`). Orders are sorted by a fixed `sortId` (`BMOD:178-244`). `op = 4` only touches order 3 and dereferences a null object when the order is missing (`QBM:117-136`): never send `op = 4`.

When: at login after the login load (assumption) with every order id the player has unlocked; again when a counter changes and the owning feature has no dedicated push (assumption). Owning features may instead keep using their own pushes listed below.

## 5. Rules and formulas

| Order id | Title (pt-BR) | Owner | Other updaters | Visible when (`QB:1053-1110`) | Click |
|---|---|---|---|---|---|
| 1 | "Bênção da Guilda {0}/{1}" | [../guild/README.md](../guild/README.md) | 45 altar (`QBM:194-218`), 46 quit (`QBM:167-180`) | in a guild, `current > 0` | `DayGuideManager.switchScene(12)` |
| 2 | "Recompensa {0}/{1}" | [../quests/README.md](../quests/README.md) | 4197 reward list, countdown 1800 s (`QBM:220-263`) | `current > 0` | `switchScene(24)` |
| 3 | "Pontos de Movimento da Terralém {0}/{1}" | [../outyard/README.md](../outyard/README.md) | 350, 311, 306 (`QBM:295-424`), 30 min regen timer (`QBM:672-700`) | `property1 != 0` and signed in | `TopToolsBar.enterOutyardScene` |
| 4 | "Navegação {0}/{1}" | [../navigation/README.md](../navigation/README.md) | 342 (`QBM:425-470`) | `info.strength != 0` | `openControllerByInfo("navigation", 1)` |
| 5 | "Arena de Einherjar {0}/{1}" | [../einherjar/README.md](../einherjar/README.md) | 4176 (`QBM:472-498`) | Leader >= 50, `current > 0` | cooldown or `petchallenge` 2 |
| 6 | "Desfio individual {n}/{m}" | [../arena/README.md](../arena/README.md) | 4176 (`QBM:500-535`, `LIDA:360-385`) | never listed (excluded by the switch at `QB:961-978`) | colosseum |
| 7 | "Guardiões Procurados {0}/{1}" | [../guardians/README.md](../guardians/README.md) | 4979 (`QBM:537-576`) | `current > 0` | `switchScene(43)` |
| 8 | "Pontos de Movimento do Caminho do Céu {0}/{1}" | [../trials/README.md](../trials/README.md) | 4552 (`QBM:578-592`) | `current > 0` | `switchScene(40)` |
| 9 | "Campanha Multiplayer {0}/{1}" | [../campaign/README.md](../campaign/README.md) | client built from `playerInfo.multiCopyCount` at Leader >= 20 (`QB:887-905`) | `current > 0` | `switchScene(5)` |
| 10 | "Arqueologia {0}/{1}" | [../archaeology/README.md](../archaeology/README.md) | 260 extra field 9, max `archaeology_max_count` (`QBM:594-623`) | Leader >= 15, `current > 0` | `switchScene(64)` |
| 11 | "Patrulha do Guardião {0}/{1}" | [../guardians/README.md](../guardians/README.md) | client built at Leader >= 70 (`QB:862-872`) | always once created | `childpatrol` 1 (Leader >= 55) |
| 12 | "Essência de planos {0}/{1}" | [../planes/README.md](../planes/README.md) | client built at Leader >= 55 and planes enabled (`QB:851-861`) | always once created | Transmissor frame ([transmitter.md](transmitter.md)) |
| 13 | "Pesquisa da Terrálem {0}/{1}" | [../outyard/README.md](../outyard/README.md) | 260 extra field 15, max `huge_head_explore_point` | `property1` not 0 or 1, signed in | `enterOutyardScene` |
| 14 | "Caminho da Glória {0}/{1}" | [../roads/README.md](../roads/README.md) | client built at Leader >= 15, total 15 (`QB:873-886`) | `current > 0` | `gloryroad` |
| 15 | "Portal do Tempo {0}/{1}" | [../exploration/README.md](../exploration/README.md) | 4460 shuttle (`QBM:350-364`) | class changed | `SwitchPageHelp.openShuttleFrame` |
| 16 | "Expedição do Espírito de Proteção {0}/{1}" | [../guardians/README.md](../guardians/README.md) | expedition model events (`QBM:182-192`) | spirit expedition enabled and avenger unlocked | `openSpiritExpeditionFrame` |

The client pre creates orders 3, 15, 13, 6 and 5 with zero counters (`QBM:265-293`) so their pushes always have a target.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | | `archaeology_max_count`, `huge_head_explore_point`, `Challenge_Cool`, `Quick_Cool` |

## 7. Persistent state

None in this module. Each counter is stored by its owner. The 366 assembler queries a registry of providers.

## 8. Backend implementation notes

- `castle::activity_queue::build(player) -> ActiveQueueListMsg`: iterate a static provider registry (order id to owning feature function returning `current`, `max`, `count_down_time`, or none when locked). `op = 0`.
- `castle::activity_queue::push(player, order_ids)`: send 366 with the listed entries; owners call it after a counter change when they have no dedicated push.
- Login: send 366 after the login load (with 4176 for orders 5 and 6, owned by arena).
- 8281 ([buildings.md](buildings.md)) also answers with 366.

## 9. Open questions and assumptions

- Assumption: 366 is sent at login and after counter changes; the client has no request for it.
- Open: the exact set of order ids the original server sent in 366 versus the ids the client builds itself (9, 11, 12, 14).

## 10. Implementation checklist

- [ ] Provider registry with the 16 order ids and owner callbacks.
- [ ] 366 at login and on demand; never `op = 4`.
- [ ] Test: player in a guild with 30 altar prayers sees "Bênção da Guilda 30/30"; after one prayer 29/30.
