# Ranking board

Feature `rankings`, module `ranking-board`. The `SortFrame` window with all ranking categories.

Conventions: paths are relative to the repository root; AS3 citations are `decompiled/<module>/scripts/<path>.as:<line>`; "Assumption" marks behavior not visible in the client. All lists are HTTP downloads; there is no socket request in this module.

## 1. Overview

The player picks a category on the left (`SortLeftview`), optionally a period (day, week, total) and an area (local server or cross server) on the right (`SortRightView`). The controller maps the selection to a file name, downloads `{TPL}<cross/>file.xml` once per window session, parses every row into `SortData` and shows 8 rows per page. The bottom strip (`MySortView`) shows the player's own position, mostly from `PlayerMsg` order fields kept in `PlayerInfo.playerOrdeInfo`, and for some lists by scanning the downloaded list.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `sort.SortFrame` `decompiled/m11/scripts/sort/SortFrame.as:34` | "Ranking" (`mainBar.SmallMapBar.rankingBtnTipData`, `:52`) | Container; switches between `SortRightView` and `RegressRightView` when category 12 is selected (`:113`) | controller key `sort` (`ShouBangFrame.showTotalHandler`, `ShouBangFrame.__onChangeHandler` regress button) | left tabs, right list, own position |
| `SortLeftview` `decompiled/m11/scripts/sort/SortLeftview.as:55` | tab images (no text keys) | Category tabs and the number one button | `SortFrame` | 10 tabs, see category table |
| `SortRightView` `decompiled/m11/scripts/sort/SortRightView.as:66` | "Última Atualização:" (`sort.view.SortRightView.lastUpdateTime`) | Period buttons (day, week, total), area buttons (local, cross), page arrows, list of `SortMemberItem`, update date `MM-DD hh:mm` from `info@createDate` (`:144`) | `SortFrame` | current page of `SortModel.currentShowList` |
| `RegressRightView` `decompiled/m11/scripts/sort/RegressRightView.as:55` | same date label | Returned players list (category 12), 10 rows per page | `SortFrame` when `currentSelected == 12` | `returnedplayers.xml` |
| `MemberTitleView` `decompiled/m11/scripts/sort/MemberTitleView.as:15` | column titles from `SortModel.initLanguageConfig` (`decompiled/core_module/scripts/mvc/module/sort/SortModel.as:369`) | Column headers, keyed by category or `"C"+category` for cross | right view | "Ranking", "Nome", "Profissão", "Nível", "Experiência", "Poder", "Poder de Combate Total", "Nome da Guilda", "Título", "Fama", "Charme", "Pontos Bestial", "Atributos", "Dono", "Nv. Einherjar", "Tempo de Retorno", "Valor de Armadura", "Servidor" |
| `SortMemberItem` `decompiled/m11/scripts/sort/SortMemberItem.as:63` | none | One row; VIP name coloring; vocation icon on the level list (`:226`) | right view | columns per category (`refreshView` `:460`, `refreshCrossView` `:248`) |
| `MySortView` `decompiled/m11/scripts/sort/MySortView.as:78` | images | Own position strip (`__onSelectedChangeHandler` `:196`) | `SortFrame` | see Rules |

Category table (`SortLeftview.__onChangeHandler` `decompiled/m11/scripts/sort/SortLeftview.as:193`, file names `SortController.getSortFileName` `decompiled/core_module/scripts/mvc/controler/SortController.as:779`):

| Tab button style | `currentSelected` | Period buttons | File (local) | XML row element | Columns |
|---|---:|---|---|---|---|
| `sort.selfPowBtn` | 2 | no | `fight.xml` | `PlayerFight` | rank, name, job, power (`fightCapaity`) |
| `sort.petPowBtn` | 9 | no (area yes) | `petfightcapacityrank.xml` | `PetCapabilityRankInfo` | rank, pet name, pet type, owner, pet level, pet power |
| `sort.childPowBtn` | 13 | no (area yes) | `childfightcapacityrank.xml` | `ChildCapabilityRankInfo` | rank, child name, owner, child job, power |
| `sort.consortiaLevelBtn` (field `_multiplePowBtn`) | 3 | no | `totalfightcapacity.xml` | `PlayerTotalFight` | rank, name, job, total power (`FightCapacity`) |
| `sort.consortiaPowBtn` | 4 | no | `constainfight.xml` | `fightItems` | rank, guild name, guild level, guild power |
| `sort.SoulBtn` | 7 | no | `soulscore.xml` | `SoulScoreTotalAdd` | rank, name, job, beast points |
| `sort.selfLevelBtn` | 1 | day, week, total (`addType` 1, 2, 3) | `day.xml`, `week.xml`, `total.xml` | `DayAdd`, `WeekAdd`, `TotalAdd` | rank, name, job, level, experience |
| `sort.honourBtn` | 5 | no | `geste.xml` | `PlayerGeste` | rank, name, job, honour title, honour |
| `sort.charmsBtn` | 6 | day, week, total | `daycharm.xml`, `weekcharm.xml`, `totalcharm.xml` | `CharmDayAdd`, `CharmWeekAdd`, `CharmTotalAdd` | rank, name, job, charm |
| `sort.theseusBtn` | 14 | no | `theseus.xml` | `Theseus` | rank, name, job, armour value |
| ShouBang "regress" button | 12 | no, local only | `returnedplayers.xml` | `ReturnedPalyer` (sic) | rank, name, job, return time (`ReturnedTime`) |

Cross area: the same file name prefixed with `cross/` (`SortController.loadXMLData` `SortController.as:670`). The cross button is shown for every category of `SortRightView` (`SortRightView.__onSelectedChangeHandler` `decompiled/m11/scripts/sort/SortRightView.as:237`); category 12 uses `RegressRightView`, which has no area buttons (local only). Category values 8, 10 and 11 are unused. The controller also parses warlords (`LordsInfo`) and multilords (`TitansRecord`) rows into `warlordsDic` and `multilordsDic`, but no view of this package reads them and no file name maps to them (Open question 1).

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| R1 | Category tab | `SortLeftview.__onChangeHandler` `SortLeftview.as:193` then `SortController.setSelectType` `SortController.as:637` then `loadXMLData` `:670` then `loadData` `:855` | skip if same category; page reset to 1; file loaded only once per window session (`SortModel.loaded`, cleared on exit `SortController.as:887`) | HTTP GET | `{TPL}<file>` built by `PathManager.orderPath + file` (`PathManager.as:488` returns `TEMPLATE_PATH`); the loader lowercases the URL and may append a cache query (`?...`), stripped before the `loaded` key (`SortController.as:861`) | zlib compressed UTF-8 XML (loader type 5, `decompiled/Loading/scripts/com/pickgliss/loader/LoaderManagerII.as:397`), schema in [ranking-generation.md](ranking-generation.md) |
| R2 | Day, week, total buttons | `SortRightView.__onAddBtnHandler` `SortRightView.as:203` then `SortController.setAddType` `SortController.as:648` | only categories 1 and 6 show these buttons | HTTP GET | `day.xml`/`week.xml`/`total.xml` or the charm variants | as R1 |
| R3 | Local or cross area | `SortRightView.__onSelectedAreaChangeHandler` `SortRightView.as:210` then `SortController.setCross` `SortController.as:659` | none | HTTP GET | `{TPL}cross/<file>` | as R1; rows carry `serverId` |
| R4 | Page arrows | `SortRightView.__onPageBtnHandler` `SortRightView.as:197`, `RegressRightView.__onPageBtnHandler` `RegressRightView.as:171` then `SortController.pageBtnHandler` `SortController.as:902` | bounds `1..totalPage` | none (client paging) | none | none |
| R5 | Row click | `SortMemberItem.__onClickHandler` `SortMemberItem.as:145` | categories 1, 2, 3, 5, 6, 7, 14 open `PlayerMenu` (cross row from another server opens the menu in cross mode); 9 opens `pet` controller `LOOKUP_FRAME` with `petData`; 13 opens `child` controller `look_information` | see [../friends/friend-list.md](../friends/friend-list.md) for menu routes | none for viewing; menu actions have their own routes | none |
| R6 | Number one button | `SortLeftview.numberoneHandler` `SortLeftview.as:135` | loads the six podium files that are not loaded yet | HTTP GET (batch) | see [number-one.md](number-one.md) | as R1 |

## 4. Server messages (server to client)

| Route | Message and fields | Client receiver | When |
|---|---|---|---|
| S>C 3 0x0003 `U_C_PLAYER_INFO` | `PlayerMsg`: `gp_order (#29, INT32)` own level/experience rank; `order (#47, PlayerOrderMsg)`: `player_id (#1, INT32)`, `fight_capacity_order (#2, INT32)`, `geste_Order (#3, INT32)`, `charm_Order (#4, INT32)`, `soul_score_Order (#5, INT32)` | `PlayerManager` reads them only when `hasGpOrder` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:961`); also at login `LoginInitDataAccept.as:419` | Login and after each ranking recomputation (Assumption: push 3 with only these fields to online players when the job runs) |
| S>C 164/4138 `ConsortiaInfoMsg` | `orderInfo` (guild order, `fightPowerOrder`) | `ConsortiaManager.readOrderInfo` (`ConsortiaManager.as:572`) | Guild info refresh, see [../guild/profile.md](../guild/profile.md) |

The ranking lists themselves are static files, not messages.

## 5. Rules and formulas

- Page size 8 (`SortModel.PAGE_NUM`, `decompiled/core_module/scripts/mvc/module/sort/SortModel.as:15`), 10 for category 12 (`REGRESS_PAGE_NUM` `:17`, `pageNum` `:251`); `totalPage = ceil(rows / pageSize)` (`:263`). The client shows every row of the file; the file size defines the list length (Assumption: 100 rows per list, Open question 2).
- Row order: the client does not sort (except returned players by `orderId`, `SortController.as:1335`); the server writes rows in rank order and sets `orderId`.
- Own position (`MySortView.__onSelectedChangeHandler` `decompiled/m11/scripts/sort/MySortView.as:196`): level list uses `playerOrdeInfo.getGpOrder()` (`gp_order`), shows hero level and total GP; power uses `fight_capacity_order` and `fightingCapacity`; total power uses `multipleApOrder`, which is filled from the downloaded `totalfightcapacity.xml` row matching own `userid` and server (`SortController.as:1041`); guild uses `ConsortiaInfo.orderInfo.fightPowerOrder` and `fightPower` or "0" without guild; honour uses `geste_Order` and `thane.honer`; charm uses `charm_Order`; soul uses `soul_score_Order`; pet, child and Theseus scan the downloaded list for the own `userId` (`SortController.as:1003`, `:1270`, `:1313`). In cross view the order is found by scanning the list for own server name, user id and nickname (`getPlayerCrossOrder1` `:400`) or own guild (`getPlayerCrossOrder2` `:417`).
- "Iniciante" (`colosseum.view.ColosseumPlayerItem.newPeople`) is shown when the order is 0 or >= 15000 (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerOrderInfo.as:49`). The server must send 0 for unranked players.
- Honour title column: highest `UpGradeTempInfo` with `Types=14` and `Data <= CurrentGeste` (`SortModel.getHonourName` `SortModel.as:302`).
- Server name column: `LanguageMgr.GetTranslation("sort.serverName", serverId)` = the raw `serverId` attribute (`SortController.as:113`), so `serverId` must hold the display name of the server.
- Update date: `info@createDate` (`YYYY-MM-DD hh:mm:ss`), shown as `MM-DD hh:mm`; the client truncates the parsed date to 00:00 (`SortController.as:943`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `UpGradeTempInfo Types="14"` honour titles | `TemplateName` title ("Civil", "Soldado", "Elite", ...), `Data` honour threshold |
| `index/language.json` | `sort.*` keys | column titles and labels listed above |

## 7. Persistent state

No table of its own: the board reads files produced by [ranking-generation.md](ranking-generation.md) (`rankings.snapshot` and `rankings.entry`).

## 8. Backend implementation notes

- No socket handler. The HTTP layer must serve `GET /xml/<name>.xml` and `GET /xml/cross/<name>.xml` with the zlib (RFC 1950) compressed bytes of the current snapshot, regardless of query string and in lowercase path (`LoaderManagerII.load` lowercases URLs, `LoaderManagerII.as:90`). Recommended handler: `rankings::board::handle_get_file(path)`, reading the latest `rankings.snapshot.xml_zlib` for that file key.
- Return HTTP 200 with an empty but valid document (`<Result><info createDate="..."/></Result>`) when a list has no rows, so the client renders an empty page instead of failing.
- Cache headers: allow caching for the snapshot period; the client never re-requests within one window session.

## 9. Open questions and assumptions

1. Warlords (`LordsInfo` with `lordsIndex`, `SortController.as:1133`) and multilords (`TitansRecord` with `rank` and nested `PlayerInfo`, `:1187`) parsers exist without a tab or file name; Assumption: legacy, owned by the warlords/titan features if anywhere, skip here.
2. Assumption: list length 100 rows per file (not visible in the client).
3. Assumption: the original server regenerated files once per day; the date label supports any period.
4. `ReturnedPalyer` is spelled this way in the client and must be kept.

## 10. Implementation checklist

- [ ] `SortFrame` opens from `ShouBangFrame` "total" button
- [ ] Every tab downloads its file once and renders rows (R1)
- [ ] Day, week, total switching for level and charm (R2)
- [ ] Cross area switching with `/xml/cross/` files and server column (R3)
- [ ] Paging 8 rows, 10 rows for returned players (R4)
- [ ] Row click menu, pet look up, child look up (R5)
- [ ] Own position strip for each category, "Iniciante" for 0 or >= 15000
- [ ] `PlayerMsg.gp_order` and `PlayerMsg.order` sent at login and after recomputation
- [ ] Honour title lookup from `UpGradeTempInfos.xml` type 14
- [ ] HTTP file handler with zlib compression, lowercase paths, ignored query string
- [ ] Test: empty list file renders without errors
