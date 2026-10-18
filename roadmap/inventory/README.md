# Inventory ("Mochila e itens")

Feature `inventory` (domain economy) of the [roadmap](../README.md). Client packages `bag`, `bag360`, `pandora`, `box`; proto packages `item`, `storehouse`, `slate`. It owns the item model used by the whole game: item templates, item rows in every bag, the generic slot update push, the main bag ("Mochila"), the treasure bag ("Bolsa de tesouro"), using and selling items, boxes and packs, and the wire format of every `item` message.

## Overview for the player

- "Mochila": a 7 x 8 grid with up to 4 pages of permanent slots (42 free, rows of 7 bought with diamonds) and 2 rented pages ("Mochila Temporária", 30 / 90 / 180 days). Buttons "Organizar", "Dividir", "Vender", a sort filter ("Ordem Padrão", "Moda", "Acessório", "Equipamento", "Gema") and item lock ("Bloquear").
- "Bolsa de tesouro": a permanent 280 slot second bag for gems, crystals, divine souls and agates (1 000 diamonds).
- Items are used from the bag ("Usar", "Usar em massa"), equipped by double click or drag, sold to the system ("Itens à Venda"), linked in chat (shift + click), and expire when their validity ends.
- Boxes and packs: open boxes, paid chests, collection chests, novice packs ("Pacote de Iniciante"), the online time chest ("Baú de Tesouros do tempo"), the security privilege pack ("Pacote de Previlégio de Segurança") and the Pandora diamond lottery ("Caixa de Pandora").
- Market stalls ("Barraca") on the market map, divine slates ("Placa divina") and the Theseus challenge ("Desafio de Teseus") use messages of the inventory proto packages.

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Main toolbar "Mochila" (shortcut B) | hero level >= 4 | `armyII.ArmyFrameII` "Equipamentos" with the bag ([bag.md](bag.md)) |
| Bag tab "Bolsa de tesouro" | always; purchase view until bought | [storehouse.md](storehouse.md) |
| "Vender" / "Bloquear" buttons | hero level >= 10 | [sell.md](sell.md), [../account/item-lock.md](../account/item-lock.md) |
| Using a novice pack | item SonType 298 | "Pacote de Iniciante" ([boxes.md](boxes.md)) |
| Toolbar time chest icon | hero level >= 8, periods left | "Prêmiação" ([boxes.md](boxes.md)) |
| Top toolbar "Caixa de Pandora" | hero level >= 6, event open | [pandora.md](pandora.md) |
| Market map 5801 sell button | hero level >= 40 | [market-stall.md](market-stall.md) |
| Theseus frames | Theseus feature | [slate.md](slate.md), [thess-box.md](thess-box.md) |
| `bag360` frame | no caller in this build | [bag360.md](bag360.md) |

## Modules

| Module | Content | Routes (C>S) | Server messages (S>C) | Tables |
|---|---|---|---|---|
| [item-catalog.md](item-catalog.md) | `ItemTempInfos` fields, MasterType / SonType table, quality, requirements, stacks, binding, validity, currencies, tooltips | none | none | none (XML registry) |
| [item-instance.md](item-instance.md) | item row, `ItemInfoMsg`, 115 slot push, login load, bag type table | 8224 (`bag` flag) | 115, 3, 126 | `inventory.items`, `inventory.item_log` |
| [bag.md](bag.md) | main bag: pages, capacity, move / split / merge, arrange, sort, row purchase, rental pages, expired removal, lock, chat links | 5005, 8220, 5010, 8819, 8346, 8809 | 115, 4709, 3 | `inventory.bag_capacity`, `inventory.bag_purchase_log` |
| [sell.md](sell.md) | sell to the system | 5007, 8624 | 115, 109 | `inventory.sell_log` |
| [item-usage.md](item-usage.md) | use, batch use, routing per SonType, buffers, recipes | 5006, 8665, 8521, 8345, 8283, 8562 | 115, 3, 109, 4188, 4184 | `inventory.item_buffers`, `inventory.item_use_log` |
| [boxes.md](boxes.md) | boxes, paid chests, novice packs, online time chest | 5006, 5019 (5018 unused) | 4, 115, 3 | `inventory.drop_tables`, `inventory.novice_pack_claims`, `inventory.time_chest_state` |
| [storehouse.md](storehouse.md) | treasure bag (bag 34) | 9569, 5005, 8220 | 276, 3, 115 | (columns of `inventory.bag_capacity`) |
| [equipment-slots.md](equipment-slots.md) | wear / unwear hero equipment, medal, battle runes | 5005 | 115, 149 | none |
| [market-stall.md](market-stall.md) | player stalls on map 5801 | 8969 | 4781, 4782 | `inventory.market_sales` |
| [slate.md](slate.md) | divine slates (proto `slate`) | 9762 | 1024 | `inventory.slates`, `inventory.slate_grid`, `inventory.slate_tasks` |
| [thess-box.md](thess-box.md) | Theseus challenge (proto `storehouse`) | 9761 | 769, 770, 771 | `inventory.thess_box_progress`, `inventory.thess_box_first_rewards`, `inventory.thess_box_runs` |
| [pandora.md](pandora.md) | Pandora diamond lottery | 9645 (sub type 23) | 429, 430 | `inventory.pandora_events`, `inventory.pandora_levels`, `inventory.pandora_progress` |
| [bag360.md](bag360.md) | level privilege packs | 8722, 8723 | 4543 | `inventory.privilege_pack_claims` |
| [protocol-index.md](protocol-index.md) | every message of `item`, `storehouse`, `slate` with opcodes and owners | | | |

## Dependencies

| Feature | Relation |
|---|---|
| [../currency/README.md](../currency/README.md) | negative template ids, gold / diamond / bound diamond debits and credits |
| [../hero/README.md](../hero/README.md), [../army/README.md](../army/README.md) | hero stats after equipment changes, titles, rune bag, `PlayerMsg` |
| [../smith/README.md](../smith/README.md) | workspace bag 0, enhancement, gems, recipes (4184), 8484 / 9592 |
| [../guild/warehouse.md](../guild/warehouse.md) | bag 6 hooks on 5005, 8220, 8346 |
| [../account/item-lock.md](../account/item-lock.md) | 8809 lock flag, second password |
| [../fashion/README.md](../fashion/README.md), [../mounts/README.md](../mounts/README.md), [../einherjar/README.md](../einherjar/README.md), [../guardians/README.md](../guardians/README.md), [../monsters/README.md](../monsters/README.md) | items that unlock or equip their objects (bags 26, 30, 36, 37) |
| [../theseus/README.md](../theseus/README.md) | screens of slates and the challenge, virtual bags 5 and 6 |
| [../avenger/README.md](../avenger/README.md) | virtual bag 3 |
| [../golden-tree/README.md](../golden-tree/README.md), [../seasonal-events/README.md](../seasonal-events/README.md) | bottle / magic pot messages of the `item` package, Pandora dispatcher (`cccactive`) |
| [../campaign/README.md](../campaign/README.md) | battle chest cards (135 / 5122 / 26), market map scene, Theseus challenge campaigns |
| [../shops/README.md](../shops/README.md), [../auction/README.md](../auction/README.md) | quick blood purchase (5633 / 170), bound item rules, luck broadcasts |
| [../mail/README.md](../mail/README.md) | overflow rewards and attachments |
| [../vip/README.md](../vip/README.md) | VIP coin (8521), `privilege` package |
| [../chat/README.md](../chat/README.md) | item links (`ChatItemInfoMsg`) |
| [../quests/README.md](../quests/README.md), [../steles/README.md](../steles/README.md), [../cosmos/README.md](../cosmos/README.md) | bounty cards, stele items (8665), stargazing items |

## Suggested implementation order

1. [item-catalog.md](item-catalog.md): template registry and enums.
2. [item-instance.md](item-instance.md): `inventory.items`, encoders for `ItemInfoMsg` and 115, login load.
3. [bag.md](bag.md): capacity, 5005 with hooks, 8220, 8346, 5010, 8819.
4. [equipment-slots.md](equipment-slots.md): equip hooks and hero recompute.
5. [sell.md](sell.md).
6. [item-usage.md](item-usage.md): dispatch table, buffers, recipes.
7. [boxes.md](boxes.md): drop tables, novice packs, time chest.
8. [storehouse.md](storehouse.md).
9. [market-stall.md](market-stall.md).
10. [slate.md](slate.md), [thess-box.md](thess-box.md) together with the Theseus feature.
11. [pandora.md](pandora.md), [bag360.md](bag360.md).

## Main gaps

- Box contents (SonType 206, 298, 311, 350) and pack contents (`GradeDrop.xml`, `BoxItems.xml`, `PrivilegeDrops.xml`) are missing from the client data.
- Opcodes 4, 5018, 5019, 9762 are absent from `protocol/opcodes.csv`.
- Binding origin rules are server side only; only textual evidence exists.
- Bag 1 item moves to the treasure bag on arrange, rental expiry behaviour and allowed treasure bag types are assumptions.
