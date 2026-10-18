# Rankings (Rankings)

Feature slug `rankings`, domain social. Client package `sort` (`decompiled/m11/scripts/sort`), controller `mvc.controler.SortController` and model `mvc.module.sort.SortModel` in the core module. There is no protobuf package: every ranking list is a zlib compressed XML file downloaded over HTTP from the template base URL (`{TPL}` = `TEMPLATE_PATH`, `/xml/` on our server, see `server/src/main.rs:39`). The socket only carries the player's own positions inside `PlayerMsg` (opcode 3).

## What it does for the player

- "Ranking" window (`SortFrame`, title "Ranking"): tabs for power ("Poder"), Einherjar power, guardian (child) power, total combat power ("Poder de Combate Total"), guild power, beast points ("Pontos Bestial"), level and experience ("Nível", "Experiência", with daily, weekly and total views), honour ("Fama", with honour title "Título"), charm ("Charme", daily, weekly, total), armour value ("Valor de Armadura", Theseus) and the returned players list ("Tempo de Retorno"). Each list has a local server view and a cross server view ("Servidor" column), 8 rows per page (10 for returned players), the date of the last update ("Última Atualização:") and the player's own position ("Iniciante" when not ranked).
- "1º Ranking" window (`ShouBangFrame`): a podium with the number one of six lists (power, total level, honour, total charm, beast points, Einherjar power), local or cross server, plus a button to the returned players list.
- Clicking a player row opens the shared player menu (`PlayerMenu`, view info, add friend, private chat), an Einherjar row opens the pet look up frame, a guardian row opens the child info frame. The info frames use the player snapshot embedded in the ranking XML (no extra request), see [ranking-generation.md](ranking-generation.md).

## Entry points

| Entry | Code | Condition |
|---|---|---|
| Small map bar "Ranking" button (`smallMap.RankingBtn`, tip "Ranking") | `SmallMapBar.__rankingHander` `decompiled/core_module/scripts/mainBar/SmallMapBar.as:709` then `openNumOne` `:715` | none (always visible). Opens `ShouBangFrame` (controller key `shoubang`) after loading the six local XML files |
| Total ranking button in `ShouBangFrame` (style `sort.numberone.btntotal`, image only) | `ShouBangFrame.showTotalHandler` `decompiled/m11/scripts/sort/shoubang/ShouBangFrame.as:138` | opens controller key `sort` (`SortFrame`) |
| Number one button in `SortFrame` | `SortLeftview.numberoneHandler` `decompiled/m11/scripts/sort/SortLeftview.as:135` | back to `ShouBangFrame` |
| Colosseum self view | `ColosseumSelfView` `decompiled/m13/scripts/colosseum/view/ColosseumSelfView.as:183` | reads `fight.xml` through `SortController.loadData` (shared data source, colosseum feature) |
| PvP room list | `PVPRoomListView` `decompiled/m9/scripts/pvproomlist/view/PVPRoomListView.as:130` | loads UI module `sort` before use |

Controller keys: `sort` (`FrameControllerManager.as:1415`, frame class `sort.SortFrame`, `SortController.as:882`), `shoubang`.

## Modules

| Module | File | Scope |
|---|---|---|
| Ranking board | [ranking-board.md](ranking-board.md) | `SortFrame`: categories, tabs, local and cross area, paging, own position, row click actions |
| Number one podium | [number-one.md](number-one.md) | `ShouBangFrame` and `ShouBangItem` |
| Ranking generation | [ranking-generation.md](ranking-generation.md) | Server side job that computes rankings and writes the XML files, XML schemas, `PlayerMsg` order fields, storage |

## Dependencies

- [../hero/README.md](../hero/README.md): player snapshot fields (attributes, equipment, fashion, titles) and the player info frame `playerinfo` opened with a `SortData`.
- [../einherjar/README.md](../einherjar/README.md) (pet power list, `PetData.createWithXML`), [../guardians/README.md](../guardians/README.md) (child power list, `ChildData.createChildWithXML`), [../theseus/README.md](../theseus/README.md) (armour list), [../guild/README.md](../guild/README.md) (guild power order `ConsortiaInfoMsg.orderInfo.fightPowerOrder`), [../friends/README.md](../friends/README.md) (row menu actions, charm comes from rose gifts), [../account/README.md](../account/README.md) (`PlayerMsg` login push).
- Colosseum uses `fight.xml` too.

## Suggested implementation order

1. [ranking-generation.md](ranking-generation.md): tables and the periodic job, with only `fight.xml`, `total.xml`, `geste.xml` first; serve the files compressed under `/xml/`.
2. `PlayerMsg.gp_order` and `PlayerMsg.order` (#29, #47) in the login push and on refresh.
3. [ranking-board.md](ranking-board.md) end to end for the local area, then the cross area files under `/xml/cross/`.
4. [number-one.md](number-one.md).
5. Remaining lists (charm day/week/total, soul score, pet, child, Theseus, returned players).
