# Smith ("Ferreiro"): fabricar, fortalecer, decompor

Feature slug `smith`, domain `character`. Client packages `store` (module m14 views, core_module controller / model / managers); `steel_forge` does not exist in this build. Protobuf package `store` (`StoreReqMsg`, `StoreRspMsg`, `SmithFreshReqMsg`, `SmithFreshRspMsg`, `SmithFreshReplaceRspMsg`, `SmithResolveRspMsg`, `SmithTransformRspMsg`, `RefreshPropertyReqMsg`, `RefreshPropertyRepMsg`) plus `item.ItemSmithyMsg`, `item.ItemUseStoreReqMsg`, `player.PlayerEnchantMsg`.

## Overview

The smith is the equipment workshop. The player opens the frame "Fabricar" (`store.MakeFrame`; the legacy frame title is "Ferreiro"), moves items from the bags into a hidden workspace (inventory bag type 0, slots 0..11) and runs one operation at a time; the server reads the workspace, applies the operation and pushes the updated items. Operations:

| Operation (pt-BR) | What it does | Module |
|---|---|---|
| Fortalecimento | +1 strengthen grade on equipment (gold, optional "Gema da Sorte" / "Pedra de Fortalecimento", success rate); treasure strengthen with treasure stones | [strengthen.md](./strengthen.md) |
| Inserção / Perfurar / Retirar gema | open sockets with "Perfurador", insert, replace and remove gems; "Selo da Alma" gem effect track | [gems.md](./gems.md) |
| Síntese (Sintetizar, Sintetizar Agora), Épico, Molde Divino | recipe synthesis of equipment, props and gems, equipment upgrade to epic, divine mould | [compose.md](./compose.md) |
| Purificação / Fundição | re roll random attributes of equipment / treasures with locks, then replace or keep | [refine.md](./refine.md) |
| Conversão | convert idle items into other items | [transfer.md](./transfer.md) |
| Decompor | decompose equipment, gems, mount cards, fashion, treasures, Avenger and Theseus items into materials | [decompose.md](./decompose.md) |
| Encantamento | legacy life skill enchant (no UI entry in this build) | [enchant.md](./enchant.md) |

## Entry points

| Entry | Opens | Unlock |
|---|---|---|
| Main toolbar button "Ferreiro" (`storeBtn`) | strengthen tab | hero level 7 ("Função habilitada no Nv. 7"); not while in an Athena team |
| Hotkey T | strengthen tab | tutorial progress `newbieProcess > 19000` |
| Castle map smithy building (SonType 1501) | strengthen tab | level 7, else "Ferreiro não está aberto!" |
| Equipped item upgrade button (`PlayerEquipCell`) | compose tab with the item | |
| Task trace tips, quest "go" links (condition types 17 strengthen, 18 inlay, 19 compose, 46 decompose, 47 refine), daily guide | matching panel | compose / inlay 15, refine / decompose / switch 19 |
| Army equipment view "jewel" button | "Selo da Alma" frame (route 8484) | none |
| NPC dialog option 33 (life skills) | missing life skill frame | level 35 |

Tab unlocks inside the frame: compose and inlay level 15; refine, decompose and switch level 19; divine mould level 80 plus advanced job (`vocationGrades > 0`); treasure strengthen / refine visible only with royalty level > 0. Details and citations: [store-frame.md](./store-frame.md).

## Modules

| File | Owner | Scope | Client to server | Server to client |
|---|---|---|---|---|
| [store-frame.md](./store-frame.md) | part A | `MakeFrame`, `StoreView1`, legacy `StoreFrame`, `StoreControler`, `StoreModel`, `StoreBagII` / `StoreBag` / `TreasureStoreBag` / `AvengerStoreBag` / `TheseusStoreBag`, workspace placement and return, generic request path, login recipe push, shared log | 5005 `U_C_BAG_MOVE` (workspace moves, inventory owned), 8224 `C_LONIG_LOAD_REQ` (`smith` flag) | 4184 `U_C_ITEM_SMITH`, 115 `U_C_BAG_MOVE_UPDATE`, 54 `U_C_BAG_MOVE`, 109 `U_C_CASTLE_UPDATE`, 3 `U_C_PLAYER_INFO`, 126 `U_C_MSG` |
| [strengthen.md](./strengthen.md) | part A | `IntensifyView`, `TreasureIntensifyView` | 5150 `U_C_ITEM_STRENGTHEN` (`opType` 0 normal, 1 one key, 3 treasure) | 86 `U_C_ITEM_STRENGTHEN` |
| [gems.md](./gems.md) | part A | `MountView`, sockets, gem removal, `JewelFrame` ("Selo da Alma"), gem synthesis rules | 5151 `U_C_ITEM_INLAY`, 5152 `U_C_ITEM_INLAYJOIN` (open socket / remove gem), 8484 `C_BAG_USESTORE`, 9741 `C_GEM_ONE_KEY_COMPOSE` (secretary) | 87 `U_C_ITEM_INLAY`, 88 `U_C_ITEM_INLAYJOIN`, 3 `U_C_PLAYER_INFO` (store grade fields), 593 `U_C_GEM_ONE_KEY_COMPOSE_NEED_GOLD` |
| [enchant.md](./enchant.md) | part A (extra module) | `EnchantView` and the life skill op channel | 8971 `C_LIFE_SKILL_OP` (op 7 enchant; ops 1..6, 8 without callers) | 4788 `U_C_EQUIPMENT_ENCHANT`, 4787 `U_C_LIFE_SKILL_UPDATE` |
| [compose.md](./compose.md) | part B | `ComposeView1`, `ComposeView`, compose lists, equipment upgrade, `CastView` (mould) | 5153 `U_C_ITEM_COMPOSE`, 8644 `C_MOULD_ITEM` | 89 `U_C_ITEM_COMPOSE`, 4558 `U_C_MOULD_ITEM`, 4184 (shared) |
| [refine.md](./refine.md) | part B | `RefreshView`, `TreasureRefreshView` | 8336 `C_ITEM_REFRESHFORRANDOM`, 8339 `C_ITEM_REFRESHFORREPLACE`, 8464 `C_ITEM_REFRESHPROPERTY` | 4258 `U_C_REFRESHFORRANDOM`, 4259 `U_C_REFRESHFORREPLACE`, 4368 `U_C_ITEM_REFRESHPROPERTY` |
| [transfer.md](./transfer.md) | part B | `SwitchView1`, `SwitchView` | 8538 `C_ITEM_TRANSFORM` | bag / resource pushes (`SmithTransformRspMsg` unused) |
| [decompose.md](./decompose.md) | part B | `NewResolveView`, `ResolveView1`, `ResolveView`, `AllResolvePopFrame`, `AvengerRosolveView`, `TheseusRosolveView`, `TreasureResolveView` | 8340 `C_ITEM_RESOLVE`, 8683 `C_NEW_ITEM_RESOLVE`, 8657 `C_AVENGER_CLIENT_OP`, 8684 `C_THESEUS_WARFRAMECLIENT_OP` | 4260 `U_C_RESOLVE`, 212 `U_C_VIRTUAL_BAG_UPDATE` |

Shared request path: every operation request is its own opcode; most carry `store.StoreReqMsg` (field usage table in [store-frame.md](./store-frame.md)). The server always pushes the item changes (115) before the operation result opcode, then resource pushes (109 gold, 3 diamonds / player fields). Fashion compose / switch (8594 / 8595, results 4487 / 4488) use the same manager but belong to [../fashion/README.md](../fashion/README.md).

## Persistent state (schema `smith`)

| Table | Defined in | Purpose |
|---|---|---|
| `smith.operation_log` | [store-frame.md](./store-frame.md) | audit of strengthen, gem and enchant operations |
| `smith.item_strengthen` | [strengthen.md](./strengthen.md) | strengthen grade and dragon bless per item (if inventory does not own them) |
| `smith.item_sockets` | [gems.md](./gems.md) | socket states and gems per item |
| `smith.player_soul_seal` | [gems.md](./gems.md) | "Selo da Alma" grades and progress |
| `smith.item_enchant`, `smith.player_life_skills` | [enchant.md](./enchant.md) | only if life skills are restored |
| `smith.known_recipes`, `smith.item_mould`, `smith.compose_log` | [compose.md](./compose.md) | recipes (4184), mould grade, compose audit |
| `smith.pending_refresh`, `smith.refresh_log` | [refine.md](./refine.md) | pending refine results, audit |
| `smith.transform_log` | [transfer.md](./transfer.md) | audit |
| `smith.resolve_log` | [decompose.md](./decompose.md) | audit |

Items themselves (including the workspace, bag type 0) are `inventory.items` rows owned by [../inventory/README.md](../inventory/README.md).

## Dependencies

- [../inventory/README.md](../inventory/README.md): bag 0 workspace, 5005 moves, 115 item pushes, item fields (`strengthen_grade`, `join_1..4`, `random_skill_1..5`, `mould_grade`, `str_bless_value`, `is_locked`), stone bag 34, item use 5006 (recipe scrolls).
- [../currency/README.md](../currency/README.md): gold (109) and diamonds for every paid operation and auto buy.
- [../hero/README.md](../hero/README.md): `U_C_PLAYER_INFO` fields (Selo da Alma, life skills), hero level / advanced job unlocks, attribute recomputation after changes on equipped items.
- [../shops/README.md](../shops/README.md): quick buy of "Perfurador", shop prices for gem auto buy and discounts.
- [../quests/README.md](../quests/README.md): task condition types 17, 18, 19, 46, 47.
- [../avenger/README.md](../avenger/README.md): Avenger compose types and Avenger sphere decompose.
- [../theseus/README.md](../theseus/README.md): Theseus compose types, war frame decompose, treasure growup templates.
- [../divine-weapon/README.md](../divine-weapon/README.md): artifact compose (recipe Types 20).
- [../mounts/README.md](../mounts/README.md): mount card (SonType 218) decompose into beast soul, wild soul checks in compose.
- [../fashion/README.md](../fashion/README.md): fashion decompose and fashion compose / switch routes in the same manager.
- [../royalty-boss/README.md](../royalty-boss/README.md): royalty level gates the treasure tabs.
- [../secretary/README.md](../secretary/README.md): one key gem compose 9741 / 593.
- [../einherjar/README.md](../einherjar/README.md), [../guardians/README.md](../guardians/README.md), [../monsters/README.md](../monsters/README.md), [../goddess/README.md](../goddess/README.md): their gem / equipment recipes (Types 8, 9, 12, 13, 17) are synthesized here; pet, child and monster equipment views reuse 5153 / 8644 / 4258 / 86.
- [../account/README.md](../account/README.md): login load 8224 with the `smith` flag.
- [../castle/README.md](../castle/README.md), [../steles/README.md](../steles/README.md), [../daily-activity/README.md](../daily-activity/README.md): entry points.

## Suggested implementation order

1. [store-frame.md](./store-frame.md): workspace rules on top of the inventory move handler, workspace cleanup on login / logout, 4184 at login, `smith.operation_log`, per player serialization.
2. [strengthen.md](./strengthen.md): equipment strengthen (most used, quest 17), then treasure strengthen once royalty exists.
3. [gems.md](./gems.md): punch, inlay, replace, remove; then "Selo da Alma".
4. [compose.md](./compose.md): recipes (equipment, props, gems with auto buy), epic upgrade, divine mould.
5. [refine.md](./refine.md): refine and replace, locks, treasure refine.
6. [decompose.md](./decompose.md): item decompose, then Avenger / Theseus / treasure variants.
7. [transfer.md](./transfer.md): conversion.
8. [enchant.md](./enchant.md): only if the life skill system is restored.

## Client quirks worth knowing

- `GoodsInfo.isViceEquip` is read in several smith views but never assigned (only `GoodsTemplateInfo.isViceEquip` exists), so dragon equipment branches never run on the client ([strengthen.md](./strengthen.md), [gems.md](./gems.md)).
- `MakeFrame` opens the compose tab only for `STORE_PANEL_COMPOSE`; links to resolve / switch land on the strengthen sub tab ([store-frame.md](./store-frame.md)).
- 87, 88 and 54 have no client listener; the UI refreshes only from 115.
- `PlayerMsg.storeGrade` / `storeGp` are applied only when `grades` / `grade_process` are present in the same message ([gems.md](./gems.md)).
- Recipe scroll items in the data are SonType 208 ("Fórmula de Gema - ...", `Property1` = recipe id) while the client "already learned" check tests SonType 211 ([gems.md](./gems.md), [compose.md](./compose.md)).
