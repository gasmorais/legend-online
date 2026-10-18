# Number one podium (1º Ranking)

Feature `rankings`, module `number-one`. The `ShouBangFrame` window that shows the first row of six ranking lists.

Conventions as in [ranking-board.md](ranking-board.md). No socket traffic: only HTTP downloads of ranking files.

## 1. Overview

The small map bar "Ranking" button first downloads the six local podium files that are not cached yet, shows a loading bar with combined progress, then opens the podium. Two tabs switch between local and cross server podiums (cross files are downloaded on first use). A third tab opens `SortFrame` on the returned players list. Each podium slot shows the head icon, the VIP marker and the name of row 0 of its list, or "Aguardando" when the list is empty. Clicking a slot opens the player info frame (or a pet comparison tip for the Einherjar slot).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `sort.shoubang.ShouBangFrame` `decompiled/m11/scripts/sort/shoubang/ShouBangFrame.as:64` | "1º Ranking" (`sort.shoubang.frametitle`, `:75`) | Podium with 6 slots at fixed positions (`HEAD_POS` `:34`), tabs local (`sort.shoubang.localBtn`), cross (`sort.shoubang.crossBtn`), regress (`sort.shoubang.regressBtn`), total button (`sort.numberone.btntotal`) | controller key `shoubang` from `SmallMapBar.openNumOne` `decompiled/core_module/scripts/mainBar/SmallMapBar.as:715` and `SortLeftview.numberoneHandler` `decompiled/m11/scripts/sort/SortLeftview.as:135` | first row of six lists |
| `ShouBangItem` `decompiled/m11/scripts/sort/shoubang/ShouBangItem.as:55` | "Aguardando" (`sort.shoubang.blankhead`) when empty (`blankHead` `:75`) | One slot: title badge `asset.shoubang.chenghao<n>`, head icon from `snsInfo.headId`, VIP icon, name (`updateData` `:116`) | `ShouBangFrame.initHead` `:103` | `SortData` row 0 |
| `LoadingSceneView` | none | Progress while loading the batch (`SortController.progressHandler` `decompiled/core_module/scripts/mvc/controler/SortController.as:734`) | `loadAllLocalXML` `:713`, `loadAllCrossXML` `:692` | percentage |

Slot mapping (`ShouBangFrame.updateData` `ShouBangFrame.as:250`):

| Slot `n` | List | Local file | Cross file |
|---:|---|---|---|
| 1 | power (`playerFightList`) | `fight.xml` | `cross/fight.xml` |
| 2 | total level and experience (`accumulationAddList`) | `total.xml` | `cross/total.xml` |
| 3 | honour (`playerHonourList`) | `geste.xml` | `cross/geste.xml` |
| 4 | total charm (`charmsTotalAddList`) | `totalcharm.xml` | `cross/totalcharm.xml` |
| 5 | beast points (`soulScoreTotalAddList`) | `soulscore.xml` | `cross/soulscore.xml` |
| 6 | Einherjar power (`petPowerList`) | `petfightcapacityrank.xml` | `cross/petfightcapacityrank.xml` |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| N1 | Small map bar "Ranking" (`smallMap.RankingBtn`) | `SmallMapBar.__rankingHander` `SmallMapBar.as:709`, `openNumOne` `:715` | only lists still empty in `SortModel` are requested | HTTP GET, one per missing file | `{TPL}fight.xml`, `{TPL}total.xml`, `{TPL}geste.xml`, `{TPL}totalcharm.xml`, `{TPL}soulscore.xml`, `{TPL}petfightcapacityrank.xml` | zlib XML; when all six complete the callback opens `shoubang` |
| N2 | Local tab | `ShouBangFrame.__onChangeHandler` `ShouBangFrame.as:151` (`_btnLocal`) | same lazy check | HTTP GET (missing files) | as N1 | as N1, then `updateData` |
| N3 | Cross tab | `ShouBangFrame.__onChangeHandler` (`_btnCross`) | lazy check on the `...List2` arrays | HTTP GET (missing files) | `{TPL}cross/<file>` for the six files | as N1 |
| N4 | Regress tab | `ShouBangFrame.__onChangeHandler` (`_btnRegress`, `:244`) | none | none; sets `currentSelected = 12` and opens controller `sort` | none | `SortFrame` then downloads `returnedplayers.xml` |
| N5 | Total button | `ShouBangFrame.showTotalHandler` `:138` | none | none; opens controller `sort` | none | `SortFrame` |
| N6 | Click a slot | `ShouBangItem.clickHandler` `ShouBangItem.as:200` | ignored on blank slots | none for slots 1 to 5 (`PlayerInfoManager.show(SortData, 0)` opens `playerinfo` with the embedded snapshot, `decompiled/core_module/scripts/yishi/manager/PlayerInfoManager.as:39`); slot 6 shows `yishi.view.tips.PetCompareTip` | none | none |

Note: the batch loader counts completions, not successes. A missing file (HTTP 404) still decrements the counter only if the loader reports completion; the server must always answer 200 (see [ranking-generation.md](ranking-generation.md)).

## 4. Server messages (server to client)

None. The podium uses only the static ranking files.

## 5. Rules and formulas

- The first row of each list (index 0) is the number one; there is no separate "champion" file.
- The window disposes the shared `SortModel` data on close unless it was closed to open `SortFrame` (`SortFrame.dispose` keeps data when `_isShowNumOne`, `decompiled/m11/scripts/sort/SortFrame.as:137`; `ShouBangFrame.dispose` calls `cleanData`).
- Head icon path: `IconFactory.getPlayerIcon(headId, "head")`; `headId` comes from `PlayerSNSInfo@HeadId` inside the row for player lists and from `@HeadId` on the row for the pet list.

## 6. Templates

None besides language keys `sort.shoubang.frametitle` ("1º Ranking") and `sort.shoubang.blankhead` ("Aguardando").

## 7. Persistent state

None of its own; uses the files from [ranking-generation.md](ranking-generation.md).

## 8. Backend implementation notes

- Same HTTP handler as the board (`rankings::board::handle_get_file`).
- The six podium files must exist for both areas even when empty; otherwise the loading bar may not complete.
- Snapshot rows for the podium must carry `PlayerSNSInfo` with `HeadId` and `IsVip` so the slot renders correctly.

## 9. Open questions and assumptions

1. Assumption: the loader calls the completion callback with empty data on HTTP errors (not verified in `LoaderManagerII`); serving empty documents avoids the question.
2. The title badges `asset.shoubang.chenghao1..6` are images; their text is not in `language.json`.

## 10. Implementation checklist

- [ ] Ranking button loads six local files with progress and opens the podium (N1)
- [ ] Local and cross tabs (N2, N3)
- [ ] Regress tab opens `SortFrame` on returned players (N4)
- [ ] Total button opens `SortFrame` (N5)
- [ ] Slot click opens player info from the snapshot; pet slot shows the comparison tip (N6)
- [ ] Blank slot "Aguardando" for empty lists
- [ ] Test: all twelve podium files return 200 even when empty
