# "Destaques" / "Eventos magníficos" (sum-active activity frame, funny and specialfunny)

Feature `seasonal-events`, module `funny`. Client code: `CM/funny/*` (`FunnyFrame`, views, `FunnyHelper`, `datas/FunnyType`, `datas/FunnyConditionType`, `datas/FunnyBagData`, `groupbuy/*`, `activity/*`, `mountact/*`, `regression/*`, `newyearact/*`), `CM/mvc/module/funny/FunnyModel.as` (`FMo`), `CM/managers/FunnyManager.as` (`FM`), `CM/managers/ActivityManager.as` (`AM`), `CM/mvc/controler/FunnyControler.as`, and `M11/specialfunny/*` (online, timing and "Loucura do Povo" frames). The protocol engine (8586, 4475, 4476, 4714) is specified in [active-framework.md](active-framework.md); this file covers the screens, the per-type behaviour and the condition catalogue.

Conventions: see [README.md](README.md).

---

## 1. Overview

The "Destaques" frame (title `mainBar.TopToolsBar.funnyBtn.tipData` "Destaques", or "Eventos magníficos" when `ComponentSetting.isZhanQu` is false, `CM/funny/view/FunnyFrame.as:295-306`) lists every sum-active activity ("精彩活动") that the server configured, plus a few client side entries. Each activity has packages (reward tiers) with conditions; the player sees progress and claims tiers. Several activity types get their own frame or tool bar button instead of a row in the list.

| Entry | Type | Where it shows | Owner |
|---|---|---|---|
| Generic progress activities | 1..248 (see section 5) | "Destaques" left list, right view with bags | this module |
| "Prêmio de Evento" (activity codes) | 1001 (client side) | first left button | this module ("activity code" HTTP and 4251/166/5049) |
| "Evento da compra de diamantes em grupo" (group buy) | 1005 (client side) | second left button when the shop has group buy goods | this module (shop proto) |
| "Venda da Loja Limitada", "Venda Limitada de VIP" | 1002, 1004 (client side) | left list when the shop has time limited goods | [../shops/README.md](../shops/README.md) |
| "Forja Dupla da Deusa" | 232 (client side) | left list when the goddess double forge is open | [../goddess/README.md](../goddess/README.md) |
| New Year rebate | 49 | right view `NewYearPayActView` | [new-year.md](new-year.md) |
| Mount growth rebate | 62 | right view `MountActView` (8843 / 4723) | this module |
| Open server events ("Evento da Abertura do Servidor") | tiro types (6, 11, 19, 25, 36..39, 41, 42, 45) with `isInitiate > 0` | tool bar `tiro` (2003) → `TiroFunnyFrame` | this module |
| "Pacote Online" | 14 | tool bar `online` (3001) → `OnLineRewardFrame` | this module |
| "Pacote Online Fixo" | 50 | tool bar `timing` (2005) → `TimingRewardFrame` | this module |
| "Loucura do Povo" (全民大狂欢) | 51 | tool bar `karneval` (2009) → `KarnevalFrame` | this module |
| Hall of fame | 146 | tool bar `hallfame` | [../medals/hall-of-fame.md](../medals/hall-of-fame.md) |
| Egg summon | 201 | Summer carnival tab | [public-egg.md](public-egg.md) |
| Time limited recharge | 15 | tool bar `recharge` | [../recharge/README.md](../recharge/README.md) |
| Regression (returning players) | 4, 1007 | left list for back players | [../returning-players/README.md](../returning-players/README.md) |
| Cross server consumption ranks | 67, 73, 196, 197 | own frames | [../cross-server/README.md](../cross-server/README.md) |
| Login activities | 131, 231 | own frame | [../daily-activity/README.md](../daily-activity/README.md) |
| Continuous recharge rebate | 2500, 2501 | own frame | [../recharge/README.md](../recharge/README.md) |
| Gods treasure, sky treasure | 145, 70 | own frames | [../treasures/README.md](../treasures/README.md) |
| External link | 186 | first in the left list | this module |

---

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `funny.view.FunnyFrame` (765x515) | "Destaques" / "Eventos magníficos" | Activity list and details | Tool bar `funny` (TopToolBtnInfo 1001 "精彩活动", `TopToolsBar.as:1120-1130`), visible when `grades >= 6` (`TopBtnCheckShowHelper.as:215-216`); NPC options (birthday option 37, rave party link) | Left: activity code button, group buy button (if any), then 6 (or fewer with group buy) activities per page built by `FunnyFrame.as:160-278`: `ActivityManager.activityList`, hot buy, VIP buy, goddess double forge, then every `FunnyData` inside its show window except types 4/1007 for non back players and except 196, 67, 197, 73, 131, 201, 145, 2500, 2501, 231; type 186 first. Right: `FunnyRightView` |
| `funny.view.FunnyLeftButton` | activity `title` | One activity | Left list | "new" mark until opened (`SharedManager.funnyOldDic`), glow when `anyToGet` |
| `funny.view.FunnyRightView` + `FunnyBagView` + `FunnyBagItem` / `FunnyDoubleBagItem` / `DoubleGiftItem` | "Hora do Evento", `detail`, `condition_detail`, progress text | Bags of the selected activity | Selection | Time window (`startTime..endTime`), description, progress `FunnyHelper.processText` (`funny.FunnyRightView.process<NN>` with `finishNum`, plus "canGet" for some types), one item per package: condition text (section 5), rewards (`template_type == 1` items), claim button by `status`, countdown `remainTime`, multi-claim count, fashion try-on |
| `funny.view.FunnyMutiFrame` | count selector | Claim N times | Bag claim when `getWay == 2` (`FunnyBagItem.as:331-336`) | max = `getCount` or computed by `FunnyHelper.mutiMaxNum` (`FunnyHelper.as:979-1010`) |
| `funny.activity.ActivityCodeView` + `ActivityItem2` | "Prêmio de Evento" | Activity code redemption and GM activity list | Left button 1001 | `ActivityManager.activityList` (title, contents, award, time), code input |
| `funny.groupbuy.GroupBuyView` + `GroupBuyListBar` + `GroupBuyListItem` + `CheckView` + `ZuanshiView` | "Evento da compra de diamantes em grupo" | Group buy | Left button 1005 | goods, current price, all server buy count, my count, deposit (`frontMoney`), settlement |
| `funny.mountact.MountActView` | "Ao aumentar o Nv.da Montaria durante o Evento, poderá receber a recompensa pelo E-mail." | Mount growth rebate (type 62) | Right view when type 62 is selected (`FunnyFrame.as:560-570, 735-745`) | current and next mount level, cost, rebate % (`NewMountFeedMsg`) |
| `funny.newyearact.NewYearPayActView` | see [new-year.md](new-year.md) | type 49 | Right view | |
| `funny.view.TiroFunnyFrame` + `TiroFunnyLeftView` + `TiroFunnyButton` + `TiroRightView` + `TiroFunnyItem` | "Evento da Abertura do Servidor" | Open server events | Tool bar `tiro` (2003, `TopToolsBar.as:1131-1133` sends 8586 type 1 then opens controller `funny` openType 2) | `tiroFunnyList` |
| `specialfunny.OnLineRewardFrame` | "Pacote Online" | Online time chests (type 14) | Tool bar `online` (3001) visible when `grades >= 11` and type 14 exists (`TopBtnCheckShowHelper.as:228-229`), opens `onlinereward` 14 | current chest (`onLineCurrentData`), countdown `remainTime` |
| `specialfunny.TimingRewardFrame` | "Pacote Online Fixo" | Fixed time chests (type 50) | Tool bar `timing` (2005) when `timingBagData` (`:230-231`), opens `onlinereward` 50 | chest whose time `startTime + value*60` has come (`FMo:329-358`) |
| `specialfunny.karneval.KarnevalFrame` + `KarnevalBagItem` + `ExpenseItem` | "Loucura do Povo" | Daily server spend race (type 51) | Tool bar `karneval` (2009) when type 51 exists (`:232-233`) | top 3 spenders today, my spend and rank, tiers: all players, guild, VIP, rank (`KARNEVAL_*` conditions 51..54), need `appendParam` |
| `dayguide.GroupLuckFrame` (controller `funny` openType 3) | roulette | Group buy roulette | Group buy view | `VipRouletteMsg` items (see [../daily-activity/README.md](../daily-activity/README.md)) |

Badge and glow: `FM.__funnyUserHandler` sets `anyToGet` when a package has `status == 1` (excluding types 14, 15, 146) and fires `ITEM_CANGET` (tool bar glow); types 73/197 fire `CROSS_COSTITEM_CANGET`, 196/67 `CROSS_PAY_CANGET` (`FM:686-705, 752-763`).

---

## 3. Routes (client to server)

### 3.1 Sum-active gate: 8586 (0x218a) `C_SUMACTIVE_GATE`

Body `active.SumActiveGetPackageMsg` (`activeId (#1, STRING)`, `packageId (#2, STRING)`, `type (#3, INT32)`, `count (#4, INT32)`); senders `FM.sendGetBag(type, activeId = "", packageId = "", count = 1)` (`FM:969-978`) and `FM.sedGetTiroBag(type, packageId, count = 1)` (`FM:980-989`, `activeId = tiroFunnySelectedId`). Full engine rules in [active-framework.md](active-framework.md).

| type | UI control | Call sites | Client checks | Response |
|---|---|---|---|---|
| 1 query | Frame opens; tool bar `funny`, `tiro`; online/timing/karneval frames; after the last 4475 page; timer end of a bag countdown | `FunnyFrame()` (`FunnyFrame.as:96-97`), `TopToolsBar.as:800, 1132`, `FunnyBagItem.as:386`, `OnLineRewardFrame.as:58`, `TimingRewardFrame.as:50`, `FM:639`, many other frames (hall of fame, login activity, cross cost, sale, continuous rebate) | none | 4476 for all activities |
| 2 claim | Bag "claim" | `FunnyBagItem.__clickHandler` (`FunnyBagItem.as:318-341`), `FunnyDoubleBagItem` (`:352`), `DoubleGiftItem` (`:81`), `FunnyMutiFrame.__confirmHandler` (`:126-133`, `count` = chosen N), `TiroFunnyItem.__getBtnHandler` (`:97-105`), `OnLineRewardFrame` (`:200`), `TimingRewardFrame` (`:113`) | activity `endTime > now` else "Evento expirado" (`feedback.FeedBackItem.outDate`); `getWay == 2` opens the count frame; `activeId == "REGRESS_ID"` goes to 8860 instead | 4476 with the package `status = 2`; bag pushes |
| 3 karneval query | "Loucura do Povo" opens; after the last 4475 page if type 51 exists | `KarnevalFrame` (`M11/specialfunny/karneval/KarnevalFrame.as:72`), `FM:627-630` | none | 4476 with `consumeMsg` ranking for type 51 |
| 4 karneval claim | Karneval tier claim | `KarnevalBagItem` (`M11/specialfunny/karneval/KarnevalBagItem.as:88-91`) | `status == 1` | 4476 |

### 3.2 Activity codes and GM activity list

| Route | Control | Sender | Fields | Response |
|---|---|---|---|---|
| 5049 (0x13b9) `C_ACTIVE_QUERY` | "Destaques" opens | `FM.sendGetActiveBagStatus(ActivityManager.activityList)` (`FM:1104-1132`, from `FunnyFrame.as:98`) | `active.QueryActiveMsg`: `actives (#4, ActiveInfoMsg, repeated)` with `active_id (#1)` of each listed activity; `query_type (#1)`, `param1 (#2)`, `param2 (#3)` not set; skipped when the list is empty | 166 |
| HTTP `{REQUEST_PATH}activecheck` | redeem a code for a listed activity | `AM.senActivityCode(number, activeId)` (`ActivityManager.as`, `senActivityCode`) from `ActivityItem2` | query `userId`, `key`, `activeId`, `number` (code), `rnd` | text "result\|...\|code"; tips `activity.ActivityManager.command01..15` by code (`returnResult`) |
| HTTP `{REQUEST_PATH}activecodeservlet` | redeem a generic code | `AM.senActivityCodeServlet(number)` from `ActivityCodeView` | `userId`, `key`, `number`, `rnd` | same format |

### 3.3 Group buy: 8645 (0x21c5) `C_GROUPON`, body `shop.ShopMsg`

| pay_type | Control | Sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| 3 | select a goods row | `GroupBuyListItem` (`CM/funny/groupbuy/GroupBuyListItem.as:93-101`) | | `buyInfo.good_id` | 4559 with the goods state |
| 1 | "buy" (deposit) | `GroupBuyView.confirmBuy` (`GroupBuyView.as:268-292`) | `frontMoney <= point` else recharge alert; confirm in `ZuanshiView` | `buyInfo.good_id`, `buyInfo.count = 1` | 4559 |
| 2 | "settle" | `GroupBuyView.requestBuyHandler` (`:400-449`) | confirm "funny.groupbuy.buyAlert1/2" (refund or extra payment) | `buyInfo.good_id` | 4560 settlement result |

`ShopMsg`: `buyInfo (#1, BuyInfo)`, `hasDataInfo (#2, repeated)`, `refresh_date (#3)`, `pay_type (#4, INT32)`, `item_templateId (#5)`, `refresh_interval (#6)`. `BuyInfo`: `is_discount (#1, BOOL)`, `good_id (#2, INT32)`, `count (#3, INT32)`, `receive_id (#4)`, `result (#5)`, `type (#6)`.

The roulette button sends 9523 `C_LEAD_EXTRACT` (`FunnyControler.sendLuckDraw(3)`, `CM/mvc/controler/FunnyControler.as:119-125`, body `LeadRewardMsg{op}`) and opens `GroupLuckFrame` on 338 `U_C_GROUPON_DROPITEM` (`VipRouletteMsg`) (`GroupBuyView.as:451-482`).

### 3.4 Mount growth rebate: 8843 (0x228b) `C_NEW_MOUNT_ACTIVE` (missing from `protocol/opcodes.csv`; name from `ProtocolType.as:900`)

`MountActSocketOutManager.sendGetMountActInfo()` sends an empty body when type 62 is loaded or selected (`FM:467-470`, `FunnyFrame.as:564-566, 737-741`). Response 4723. The mount feature also sends 8843 after a mount grade change ([../mounts/mount-core.md](../mounts/mount-core.md)).

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 4475 (0x117b) | U_C_SUM_ACTIVE_TEMP | `active.SumActivesMsg` | `FM.__funnyTemHandler` (`FM:152, 409-641`) | Login and configuration change | see [active-framework.md](active-framework.md); this frame uses `FMo.data`, `tiroFunnyList`, `otherList` |
| 4476 (0x117c) | U_C_SUMACTIVE_DATA | `active.SumActiveDataMsg` | `FM.__funnyUserHandler` (`FM:153, 643-788`) | 8586 responses and state pushes | per activity: `finishNum = value`, `canGet = activeCharge`; per package: `status`, `remainTime = countDown`, `isShow`, `param1`, `finshCount = finish_value`, `getCount = get_count`; type 51 copies `consumeMsg`; fires `REFRESH_ITEM` and the glow events |
| 4714 (0x126a) | U_C_CONSUME_RES | same | same handler (`FM:154`) | Push after a diamond spend that changes progress *(assumption)* | same |
| 4251 (0x109b) | U_C_ACTIVE | `active.ActiveRspMsg` | `AM.__activityHandler` (`ActivityManager.as:50`) | Login and list change | builds the GM activity list (`activeId`, `title`, `contents`, `awardContent`, `description`, `actionTimeContent`, `consortia`, `grades`, `sort`, `startDate`, `endDate`, `has_key`); sorted by `sort` |
| 166 (0x00a6) | U_C_ACTIVE_INFO | `active.QueryActiveMsg` | `AM.__returnActiveStatusHandler` (`:51`) | Response to 5049 | sets `status = state` per `active_id`; `REFRESH_ITEM` |
| 4559 (0x11cf) | U_C_GROUPON_INFO (missing from `opcodes.csv`, `AcceptProtocolType.as:1010`) | `shop.GrouponShopMsg` | `GroupBuyView.updateDataHandler` (`GroupBuyView.as:114, 141-170`) | after 8645 pay_type 1 or 3 | goods state (`cur_price`, `cur_count`, `buy_count`, `total_point`, `frontMoney`) |
| 4560 (0x11d0) | U_C_GROUPON_RESULT (`AcceptProtocolType.as:1012`) | `shop.GrouponShopMsg` | `GroupBuyView.checkResultHandler` (`:115, 126-139`) | after settlement | `CheckView(buy_count, total_point, param1)` |
| 338 (0x0152) | U_C_GROUPON_DROPITEM | `vip.VipRouletteMsg` | `GroupBuyView.zhuanpanResultHandler` (`:116, 475-482`) | after 9523 | opens the roulette with `left_count`, `leftItem` |
| 4723 (0x1273) | U_C_NEW_MOUNT_ACTIVE (missing from `opcodes.csv`) | `active.NewMountFeedMsg` | `FM.__mountActHandler` (`FM:156, 365-407`) | after 8843 and on mount level change | `begin_tm`, `end_tm`, `mount_level`, `rebate` (%), `toal_cost`, `rebate_point`, `complete`; hides type 62 when nothing was spent and the mount level differs |
| 4492 (0x118c) | U_C_GAMETIMES_INFO | | `FunnyControler.__updateHandler` | game times update | forces a reload of `gametimes.xml` (`funny@res` theme name) before the next open |

`GrouponShopMsg`: `buy_count` (#1), `total_point` (#2), `cur_price` (#3), `cur_count` (#4), `good_id` (#5), `param1` (#6) INT32, `param2` (#7, STRING), `count` (#8, INT32), `is_reward` (#9, BOOL), `frontMoney` (#10, INT32).

Other handlers registered by `FunnyManager` but owned by other features: 4550 `U_C_NEW_PLAYER_GIFT`, 4739 `U_C_RETURNER_CHARGE_REWARD`, 4740 `U_C_RETURNER_COMMON_REWARD`, 8860 `C_RETURNER_PLAYER` ([../returning-players/README.md](../returning-players/README.md)); 345 `U_C_CONSUM_RANK` ([../cross-server/README.md](../cross-server/README.md)).

---

## 5. Rules and formulas

- Visibility: an activity is listed when `showStart <= now <= showEnd` (`start_time`, `stop_time`); claims require `endTime > now` (`end_date`). The countdown "Tempo restante" uses `endTime`.
- Package `status`: 1 claimable (claim button), 2 claimed (grey, stamp), 3 not reached (disabled; for condition id 3 a recharge button with the missing amount, `FunnyBagItem.as:293-312`).
- Multi-claim (`getWay == 2`): the player chooses N up to `get_count` or a value derived from the first condition (`FunnyHelper.mutiMaxNum`), sent as `count`.
- Progress text per type: `FunnyHelper.processText` (`CM/funny/FunnyHelper.as:29-960`) picks `funny.FunnyRightView.process<NN>` with `finishNum` (activity `value`) and adds "canGet" (`activeCharge`) for consumption types.
- Online chests (type 14): sequential; `countDown` seconds until the next chest; claim when it reaches 0. Fixed time chests (type 50): chest k unlocks at `begin_date + value_k minutes`.
- "Loucura do Povo" (type 51): daily server spend race; tiers by condition 51 rank, 52 guild, 53 VIP, 54 all; `appendParam` = minimum spend; ranking in `consumeMsg` (`user_id`, `order`, `point`, `nick_name`, `is_vip`).
- Mount growth rebate (type 62): during the event, diamonds spent on mount growth are refunded at `rebate`% by mail when the next mount level is reached.
- Activity code: the GM activity list comes from 4251; redemption is HTTP; the result codes map to tips `activity.ActivityManager.command01..15`.

Condition catalogue (`PackageConditionMsg.condition_id`; text built by `FunnyBagData` with `condition_value` as `{0}` and `condition_bak` as `{1}`; numbers in the last column are lines of `CM/funny/datas/FunnyBagData.as`):

| id | Constant (`FunnyConditionType`) | pt-BR condition text (key, `FunnyBagData.as` line) |
|---|---|---|
| 1 | `MOUNTS_GRADES` | Durante o evento, elevar montaria ao nível {0}, (`title1`, :68) |
| 2 | `ROSE` | Durante o evento, presentear diariamente {0} rosas, (`title2`, :71) |
| 3 | `OFF_LINE` | Retorno do Herói, colete gratuitamente os itens abaixo: (`title17`, :767) |
| 4 | `PLAYER_GRADES` | Durante o evento, nível atingir {0}, (`title4`, :74) |
| 5 | `EQUIP_ATTRIBUTE` | Durante o evento, purificar {0} equipamentos à {1} estrelas, (`title5`, :77) |
| 6 | `GEMSTONE_COMPOSE` | Durante o evento, sintetizar {0} gemas nível {1}, (`title6`, :80) |
| 7 | `HONOR` | Durante o evento, fama atingir {0}, (`title7`, :83) |
| 8 | `STAR` | Durante o evento, adquirir {0} cosmos de cor {1}, (`title8`, :86) |
| 9 | `POINT_USED` | Durante o evento, ao consumir {0} diamantes, (`title9`, :89) |
| 10 | `RECHARGE_ONCE` | Durante o evento, recarga única de {0} ~ {1} diamantes, (`title10`, :92) |
| 11 | `EXCHANGE` | Durante o evento, ao coletar {0} x{1}, (`title11`, :101) |
| 12 | `FASHION_COMPOSE` | Durante o evento, sintetizar {0} ao nível ≥{1}, (`title12`, :115) |
| 13 | `ACTIVE_VALUE` | Durante o evento, nível de atividade atingir {0}, (`title13`, :118) |
| 14 | `LOGIN` | Durante o evento, todos os jogadores ao logarem diariamente, (`title14`, :123) |
| 15 | `ON_LINE` | Durante o event, tempo online do jogador atingir {0}, (`title16`, :135) |
| 16 | `RECHARGE_TIME` | Durante o evento, recarregar qualquer quantia, (`title19`, :138) |
| 17 | `ONE_CONSUME` | Consumo único {0} ~ {1} diamantes, (`title20`, :141) |
| 18 | `MOUNT_CULTIVATE` | Adestrou montaria {0} vezes, (`title21`, :146) |
| 19 | `SOUL_STAMP` | Consumiu {0} x{1} Cristais de Almas, (`title22`, :154) |
| 20 | `ASTROLOGY` | Adquiriu {0} cosmos, (`title23`, :157) |
| 21 | `ALCHEMY` | Você realizou {0} alquimias, (`title24`, :160) |
| 22 | `REFINE_SOUL` | Realizou {0} convocações, (`title25`, :163) |
| 23 | `REWARD` | Concluiu {0} missões de recompensa, (`title26`, :166) |
| 24 | `MYSTERY_FRESH` | Atualizou {0} vezes a Loja Misteriosa, (`title27`, :169) |
| 25 | `RUNE_SWALLOW` | Absorveu {1} {0}, (`title28`, :172) |
| 26 | `CHALLENGE` | Desafiou no Coliseu {0} vezes, (`title29`, :175) |
| 27 | `MULTI_CHALLENGE` | Você participou da arena {0} vezes, (`title30`, :178) |
| 28 | `WAR_FIELD_KILL` | Você matou {0} pessoas no Campo de batalha, (`title31`, :181) |
| 29 | `OTHERS` |  (no text) |
| 30 | `PET_QUALITY` | Durante o evento, Evoluir {1} Einherjar {0}, (`title32`, :184) |
| 31 | `PET_GRADE` | Nível do Einherjar atingiu {0}, (`title33`, :187) |
| 32 | `PET_FIGHT_CAPACITY` | Poder do Einherjar atingiu {0}, (`title34`, :190) |
| 34 | `PET_GRADE_RANK` | Posição {0} no Ranking de Nv. Einherjar, (`title35`, :195) |
| 35 | `PET_CAPACITY_RANK` | Posição {0} no Ranking de Poder Einherjar, (`title37`, :205) |
| 36 | `FIGHT_CAPACITY_RANKING` | Posição {0} no Ranking de Poder, (`title39`, :215) |
| 37 | `GRADE_RANKING` | Obtendo {0}º Lugar no Ranking de Nível Pessoal, (`title41`, :225) |
| 38 | `CONSORTIA_RANKING` | Guilda atingiu nível {0}, todos os membros (`title43`, :237) |
| 39 | `CONSORTIA_REWARD_SCORE` | Durante o Evento, completando missões de recompensa poderá obter pontos, consumir {0} pontos (`title47`, :254) |
| 40 | `CONSORTIA_STORE_COUNT` | Durante o evento, equipar gemas de Nv.{0} x{1} (`title48`, :257) |
| 41 | `CONSORTIA_TOWER_FIRST_BLOODER` | Durante o Evento, todos os servidores {0} completarem pela primeira vez {1} Piso {2} do Labirinto, (`title49`, :260) |
| 42 | `CONSORTIA_MOUNT_GREADE` | Durante o evento, a montaria ao atingir nv.{0} acima, (`title50`, :264) |
| 43 | `CONSORTIA_MOUNT_FOSTER` |  (no text) |
| 44 | `REFRESH_TREASURE_MAP_NUM` | Durante o Evento, resfriando {0} vezes {1} mapa do tesouro, (`title51`, :267) |
| 45 | `UPGRADE_LEVEL` | Durante o Evento, poder pessoal atingir {0} ou mais, (`title54`, :275) |
| 46 | `COMPOSITE_GUARD_CRYSTAL` | Durante o Evento, sintetizar {0} Cristais de Nível {1}, (`title52`, :270) |
| 47 | `PET_GROWUP` | Durante o evento, evoluir Einherjar {0} vezes, (`title56`, :283) |
| 48 | `PET_APTITUDE` | Durante o evento, fortalecer Einherjar {0} vezes (`title57`, :286) |
| 50 | `TIME_REWARD` |  (no text) |
| 51 | `KARNEVAL_RANK` |  (no text) |
| 52 | `KARNEVAL_CONSORTIA` |  (no text) |
| 53 | `KARNEVAL_VIP` |  (no text) |
| 54 | `KARNEVAL_ALL` |  (no text) |
| 55 | `MOUNT_FEED` | Durante o evento,  adestrar montaria com diamantes {0} vezes, (`title59`, :301) |
| 56 | `PET_FEED` | Durante o evento,  consumir diamantes para elevar einherjar {0} vezes, (`title60`, :304) |
| 58 | `TYPE_PET_EQUIP_STRENG` | Durante o evento, fortalecer {0} vez(es) equipamento(s) de einherjar, (`title068`, :385) |
| 59 | `TYPE_PET_EQUIP_REFRESH` | Durante o evento, consumir Água Dourada x{0} (`title61`, :388) |
| 60 | `TYPE_PET_GEM_COMPOSE` | Durante o evento, Sintetizar {1} Alma Divina nv.{0}, (`title62`, :391) |
| 61 | `TYPE_MOUNT_UPGRADE` | Durante o evento,  refinar montaria x{0}, (`title63`, :394) |
| 62 | `TYPE_MOUNT_CULTURE` |  (no text) |
| 66 | `TYPE_CHARGE_RANK` | {0}º jogador do Ranking de consumo (precisa de consumir no mínimo {1} diamantes), (`title68`, :402) |
| 67 | `TYPE_CHARGE_REWARD` | O jogador do servidor recarregou {0} diamantes, (`title69`, :412) |
| 71 | `EQUIPMENT_CASTCOUNT` | Efeutar molde divino em equipamentos {0} vez(es), (`title071`, :549) |
| 73 | `CROSS_TOTAL_COST` | O jogador do servidor consumiu acumuladamente {0} diamantes, (`title82`, :422) |
| 100 | `RUNE` | Durante o evento, elevar Runas {0} vezes diariamente, (`title100`, :307) |
| 101 | `SEEK` | Durante o evento, {0} Caça ao Tesouro diariamente, (`title101`, :310) |
| 102 | `POWCARD_EAT` | Durante o evento, consumir {0} cartas, (`title102`, :313) |
| 103 | `POWCARD_GRADE` | Durante o evento, elevar 1 carta ao nv. {0}, (`title103`, :316) |
| 104 | `POWCARD_GET_SPEC` | Durante o evento, ativar carta de qualidade {0}, (`title104`, :319) |
| 105 | `KINGTOWER_JOIN` | Durante o evento, participar {0} vezes na Torre do Soberano, (`title105`, :322) |
| 106 | `BLESS_COUNT` | Durante o evento, ativar {0} vezes a Roleta da Benção, (`title106`, :325) |
| 107 | `BLESS_PRECENT` | Durante o evento, atingir {0}% na Roleta da Benção, (`title107`, :328) |
| 108 | `FATE_TURN` | Durante o evento, ativar {0} vezes a Roleta do Destino, (`title108`, :331) |
| 109 | `FATE_EAT` | Durante o evento, absorver {0} Pedras do Destino, (`title109`, :334) |
| 110 | `PET_CHALLENGE` | Durante o evento, participação da Arena Einherjar diária é {0} vezes, (`title110`, :337) |
| 111 | `MINEFIELD_BATTLE` | Durante o evento, participação da Mina de Ametista é de {0} vezes, (`title111`, :340) |
| 112 | `FISH_TIMES` | Durante o Evento, participar Pesca {0} vezes, (`title112`, :343) |
| 113 | `SINGLEPASS_TIMES` | Durante o Evento, Participar no Caminho do Céu {0} vezes, (`title113`, :346) |
| 114 | `TYPE_ONLYONE_POWERCARD_PROFILE` | Durante o Evento, qualidade das cartas atingir {0} ou {0} acima, (`title114`, :349) |
| 115 | `TYPE_ONLYONE_FASHION_GRADES` | Durante o Evento, se {0} atingir Nv.{1} ou Nv.{1} acima, (`title115`, :352) |
| 116 | `TYPE_ONLYONE_HONOR` | Durante o Evento, Fama atingir {0} ou mais de {0}, (`title116`, :355) |
| 117 | `REASUREMAP_GET` | Durante o Evento, participar no combate do mapa do tesouro{0} vezes, (`title117`, :358) |
| 118 | `TOWER2_FLOORS` | Durante o evento, concluir hoje {0} pisos do labirinto abismo, (`title118`, :361) |
| 119 | `TOWER1_FLOORS` | Durante o evento, concluir hoje {0} pisos do labirinto subterrâneo, (`title119`, :364) |
| 120 | `FASHION_IDENTIFY` | Durante o evento, ao avaliar moda {0} vezes, (`title58`, :367) |
| 121 | `FASHION_APPRASIAL_STAR` |  (no text) |
| 122 | `REWARD_TASK` | Durante o evento, concluir {1} missões de recompensa {0}, (`title122`, :370) |
| 123 | `FATE_LEVEL` | Durante o evento, atingir nv.{0} na proteção do destino. (`title123`, :379) |
| 124 | `SPECIAL_MOUNT` | Durante o Evento, Recolher Montaria Especial: {0} (`title124`, :373) |
| 125 | `ASTRALS_LEVEL` | Durante o evento ,se {0} cosmos atingirem o nv.{1} (`title125`, :382) |
| 126 | `HOURSE_GREADE` | Durante o evento, a montaria ao atingir nv.{0} acima, (`title50`, :264) |
| 127 | `SPECIAL_MOUNT_NUM` | Durante o Evento, Recolheu {0} Montarias Especiais (`title127`, :376) |
| 129 | `EQUIP_COLLECT` | Durante o evento, colete {0} equipamentos {2} nv.{1}, (`title129`, :450) |
| 138 | `ATTEND_VEHICLE` | Durante o evento, ao participar da Batalha TM e vencer, (`title138`, :522) |
| 141 | `CITY_BATTLE` | Durante o evento, acomulou {0} saques de cidades, (`title141`, :525) |
| 142 | `WORLD_MAP_BATTLE` | Durante o evento, matou acumuladamente {0} monstros, (`title142`, :528) |
| 143 | `ITEM_COST` | Durante o evento, consumir {0} x{1}, (`title143`, :453) |
| 152 | `TYPE_GUARD_REFRESH` | Durante o evento, equipamentos dos guardiões foram purificados {0} vezes com nível {1} ou superior de atributos estrelar (`title152`, :493) |
| 153 | `TYPE_GUARD_ADVANCE` | Durante o evento, treinou {0} equipamentos de Guardiões até nível {1}, (`title153`, :496) |
| 154 | `TYPE_GUARD_COMPOSE` | Durante o evento, sintetizar {0} Ágata(s) nível {1}. (`title154`, :499) |
| 155 | `TYPE_GUARD_SKILL_COMMON` | Elevar {0} habilidade(s) comum  do guardião até o nv.{1}: (`title155`, :507) |
| 156 | `TYPE_GUARD_SKILL_MUTILPE` | Elevar {0} habilidade(s) comum  do guardião até o nv.{1}: (`title155`, :507) |
| 157 | `TYPE_GUARD_SKILL_PROFE_SINGLE` | Elevar {0} habilidade(s) de profissão do guardião até o nv.{1}: (`title157`, :503) |
| 158 | `TYPE_GUARD_SKILL_PROFE_MUTILPE` | Elevar {0} habilidade(s) de profissão do guardião até o nv.{1}: (`title157`, :503) |
| 159 | `CHILD_EMBLEM_CONSUME` | Durante o evento, consumir {0} Cristal do Guarda da Guerra, (`title159`, :456) |
| 160 | `CHILD_EMBLEM_GRADES` | Durante o evento, emblema de guerra atingir nv.{0}, (`title160`, :459) |
| 161 | `CHILD_EMBLEM_REDUCE_UPGRADE` | Durante o evento, consumir {0} Guarda da Diminuição de Resistência, (`title161`, :462) |
| 162 | `CHILD_EMBLEM_REDUCE_LEVEL` | Durante o evento, anti-res do emblema de guerra atinge nv.{0}, (`title162`, :471) |
| 163 | `CHILD_EMBLEM_RESIST_UPGRADE` | Durante o evento, consumir {0} Guarda da Essência da Resistência, (`title163`, :474) |
| 164 | `CHILD_EMBLEM_RESIST_LEVEL` | Resistência de {0} guardiões ao atingir nv.{1} poderá obter: (`title164`, :477) |
| 165 | `TYPE_PET_BOSS` | Durante o evento, participar da batalha contra o Chefão da ilha de einherjar {0} vez(es), (`title165`, :513) |
| 166 | `TOTAL_RECHARGE_DAYS` | Durante o tempo do evento, se fizer uma recarga de {1} diamantes durante {0} dias (uma por dia), (`title166`, :480) |
| 167 | `GOD_HALIDOM_REFRESH` | Durante o evento, brasões ou criaturas foram purificadas{0}vezes com nível{1}ou superior de atributos estrelares, (`title167`, :483) |
| 168 | `TYPE_GUARD_ZEUS` | Durante o evento, consumiu {0} Sangue de Zeus (`title168`, :486) |
| 169 | `TYPE_GUARD_PROMOTE_SINGLE` | Durante o evento, treinou {0} Guardiões até nível {1}, (`title169`, :490) |
| 170 | `TYPE_GUARD_PROMOTE_MUTILPE` | Durante o evento, treinou {0} Guardiões até nível {1}, (`title169`, :490) |
| 171 | `MOUNTS_DISCOUNT` | Durante o evento, brasões ou criaturas foram purificadas{0}vezes com nível{1}ou superior de atributos estrelares, (`title167`, :510) |
| 174 | `PET_EQUIPMENT_ADVANCE` | Durante o evento, criar {0} equipamento(s) de Einherjar até nível {1}, (`title174`, :531) |
| 175 | `PET_EQUIPMENT_ADVANCE_COST` | Durante o evento, consumir {1} x{0}, (`title175`, :534) |
| 176 | `TYPE_CHILD_COMMON_SKILL` | Durante o evento, Usando {0} Pergaminho de habilidades comuns do Guardião, (`title176`, :516) |
| 177 | `TYPE_CHILD_PRO_SKILL` | Durante o evento, Usando {0} Pergaminho de Habilidades Ativas do Guardião ou Pergaminho de Habilidades Passivas do Guard (`title177`, :519) |
| 178 | `EQUIPMENT_CAST` | Durante o evento, efetuar molde divino em {1} equipamento(s) até o nível {0}, (`title178`, :537) |
| 179 | `HIGH_LV_PEARL_STRENGTHEN` | Durante o evento, fortalecer Einherjar {0} vezes (`title57`, :540) |
| 180 | `NEW_FASHION_COMPOSE` |  (`title180_`, :543) |
| 181 | `NEW_TATTOO_REFRESH` |  (`title181_`, :546) |
| 182 | `MOUNT_KING_ADDGP` | Durante o evento, usar diamantes para destrar montaria {0} vez(es), (`title182`, :552) |
| 183 | `CHANGEJOB_TALENT_UPGRADE` | Ao usar {0} diamantes poderá elevar o Dom Natural, (`title183`, :555) |
| 184 | `TITAN_LEVEL_UPGRADE` | Usar diamantes para adestrar titã {0} vez(es), (`title184`, :558) |
| 185 | `FASHION_LEVEL_UPGRADE` | Durante o evento, atingir moda nv.{0}, (`title185`, :561) |
| 187 | `TYPE_PLANES_COST_ENERGY` | Durante o evento, você consumiu {0} energia(s) no plano (`title187`, :564) |
| 188 | `TYPE_PLANES_COMMEN_EVENT` | Durante o Evento, você desafiou  {0} vez(es) no julgamento do plano, (`title188`, :567) |
| 189 | `TYPE_PLANES_BOSS_EVENT` | Durante o evento, você ocupou {0} base(s) no plano (`title189`, :570) |
| 190 | `TYPE_SKYBOXROAD_COST_ENERGY` | Durante o evento, você consumiu {0} pontos de movimento no cominho do céu, (`title190`, :573) |
| 191 | `TYPE_PERKINLAB_HARVEST` | Durante o evento, obteve {0} no laboratório de platina, (`title191`, :576) |
| 192 | `TYPE_PERKINLAB_ROB` | Durante o evento, saqueou com sucesso no laboratório de platina {0} vez(es), (`title192`, :579) |
| 193 | `TYPE_PETLAND_KILL_MIDDLE` | Durante o evento, na proteção da ilha de einherjar matou {0} einherjars médio, (`title193`, :582) |
| 194 | `TYPE_PETLAND_KILL_SENIOR` | Durante o evento, na proteção da ilha de einherjar matou {0} einherjars avançado, (`title194`, :585) |
| 195 | `TYPE_ARCHAEOLOGY_DIG` | Durante o Evento, participou da escavação de arqueologia {0} vez(es), (`title195`, :588) |
| 196 | `TYPE_CROSS_SERVER_EXCHARGERANK` | {0}º jogador do  Ranking de consumo (precisa de consumir no mínimo {1} diamantes), (`title90`, :432) |
| 197 | `CROSS_RANK_COST` | {0}º jogador do  Ranking de consumo (precisa de consumir no mínimo {1} diamantes), (`title81`, :442) |
| 198 | `NAVIGATION` | Durante o evento, você consumiu {0} pontos de movimento (`title198`, :591) |
| 199 | `OUTYARD` | Durante o evento, você consumiu {0} pontos de pesquisa (`title199`, :594) |
| 200 | `OUTYARD_BATTLE` | Durante o Evento, participando da luta da base de terralém {0}vezes, (`title200`, :597) |
| 201 | `EGG_SUMMON` | Durante o evento, coletar {0} x {1}, (`title201`, :111) |
| 202 | `DRAGON_TITAN_INJIE` | Durante o evento, consumir {0} pedras de espírito de alma, (`title202`, :600) |
| 203 | `DRAGON_TITAN_CHARGE` | Durante o evento, consumir {0} fragmento de energização, (`title203`, :603) |
| 204 | `SUB_STAR` | Durante o evento, consumir {0} Pó da Ilusão, (`title204`, :606) |
| 205 | `TYPE_PET_CONTRAC` | Durante o evento, consumir {0} Esfera Mágica de Einherjar, (`title205`, :609) |
| 206 | `TYPE_PET_HELLOWS_FEED` | Durante o evento, consumir {0} Esfera de poder do espírito, (`title206_1`, :614) |
| 207 | `TYPE_PET_HELLOWS_GRADE` | Durante o evento, treinou {0} armas divinas de einherjar até o nível{1}, (`title207`, :622) |
| 208 | `TYPE_PET_INSCRIPTION` | Durante o Evento, participou da inscrição de armas divinas {0} vez(es), (`title208`, :625) |
| 209 | `MOHUAN_FANGZHEN` | Durante o evento, participar na formação mágica x{0}, (`title209`, :628) |
| 210 | `RONGYAO_ZHILU` | Durante o evento, completar o {0} piso do Caminho da Glória, (`title210`, :631) |
| 211 | `MOFA_JIUGUAN` | Durante o evento, presentear {0} no bar da fantasia, (`title211`, :634) |
| 212 | `TYPE_CONSORTIA_WAJUE` | Durante o Evento, escavou {0} vez(es) o tesouro da guilda, (`title212`, :637) |
| 213 | `TYPE_CONSORTIA_HELP` | Durante o Evento, ajudou o amigo a escavar {0} vez(es) o tesouro da guilda, (`title213`, :640) |
| 214 | `TYPE_EQUIP_LINGLIAN` | Durante o evento, consumir {0} pedras requintadas, (`title214`, :643) |
| 215 | `TYPE_TITAN_PEIYANG` | Durante o evento, consumir {0} pedras de alma de titã, (`title215`, :646) |
| 216 | `TYPE_FISION_JINGLIAN` | Durante o evento, consumir {0} Pedras de refinação da moda, (`title216`, :649) |
| 217 | `TYPE_ARTIFACT_CAST` | Durante o evento, consumir {0} pedras de espírito de alma, (`title217`, :652) |
| 218 | `TYPE_ARTIFACT_ADVANCE_STAR` | Durante o evento, consumir {0} cristais da Estrela para elevar a arma divina (`title218`, :655) |
| 219 | `TYPE_ARTIFACT_ADVANCE_MONTH` | Durante o evento, consumir {0} cristais de lua para elevar a arma divina (`title219`, :658) |
| 220 | `TYPE_ARTIFACT_ADVANCE_SUN` | Durante o evento, consumir {0} cristais de sol para elevar a arma divina (`title220`, :661) |
| 223 | `TYPE_ARTIFACT_CALL` | Durante o evento, convocar {0} armas divinas, (`title223`, :664) |
| 224 | `TYPE_CHILD_AWAKEN_TRAIN` | Durante o evento, consumir {0} essências de Zeus para adestrar o despertamento da proteção da alma, (`title224`, :667) |
| 225 | `TYPE_RESONATE_TRAIN` | Durante o evento, consumir {0} cristais de ressonância, (`title225`, :670) |
| 226 | `TYPE_ARMORY_MARK_TRAIN` | Durante o evento, consumir {0} pedras de brasão de arma divina, (`title226`, :673) |
| 227 | `TYPE_ARMORY_GRADE_TRAIN` | Durante o evento, avançar até o nível {1} com {0} brasões, (`title227`, :677) |
| 228 | `DRAGONTALKER_UPGRADE_SYMBIONT` | Durante o evento, gastando {0} Pedras Simbióticas, (`title228`, :680) |
| 229 | `DRAGONTALKER_UPGRADE_TALISMAN` | Durante o evento, gastando {0} Talismãs de Experiência, (`title229`, :683) |
| 230 | `DRAGONTALKER_UPGRADE_MOUNT` | Durante o evento, gastando {0} Forragens do Outro Mundo, (`title230`, :686) |
| 247 | `` | Durante o evento, fortaleça a Intenção de Guerra {0} vezes para receber o prêmio, (`title247`, :689) |
| 248 | `` | Durante o evento, fortaleça o Tesouro do Núcleo {0} vezes para receber o prêmio, (`title248`, :692) |
| 249 | `THESECOLLECTBOX1` | Durante o evento, abra {0} baú(s) de diamante no sistema de coletáveis, (`title249`, :465) |
| 250 | `THESECOLLECTBOX2` | Durante o evento, ganha {0} ponto(s) de baú de coletáveis, (`title250`, :468) |
| 2500 | `ACTIVE_2500` |  (no text) |
| 2501 | `ACTIVE_2501` |  (no text) |
| 10066 | `TYPE_REGRESS_CHARGE` | Durante o evento,  o regresso dos jogadores,  acumular diariamente recarga de {0} diamantes, (`title67`, :397) |

Activity type ids (`CM/funny/datas/FunnyType.as`): 1 `TYPE_CONSUM`; 2 `TYPE_HOURSE`; 3 `TYPE_ROSE`; 4 `TYPE_LEAVE`; 5 `TYPE_EQUIP`; 6 `TYPE_STORE`; 7 `TYPE_HONOR`; 8 `TYPE_STAR`; 9 `TYPE_CHARGE`; 10 `TYPE_EXCHANGE`; 11 `TYPE_FASHION_COMPOSE`; 12 `TYPE_ACTIVE_NUM`; 13 `TYPE_LOGIN`; 14 `TYPE_ONLINE`; 15 `RECHARGE_TIME`; 16 `TYPE_ONE_CONSUME`; 18 `TYPE_MOUNT_CULTIVATE`; 19 `TYPE_SOUL_STAMP`; 20 `TYPE_ASTROLOGY`; 21 `TYPE_ALCHEMY`; 22 `TYPE_REFINE_SOUL`; 23 `TYPE_REWARD`; 24 `TYPE_MYSTERY_FRESH`; 25 `TYPE_RUNE_SWALLOW`; 26 `TYPE_CHALLENGE`; 27 `TYPE_MULTI_CHALLENGE`; 28 `TYPE_WAR_FIELD_KILL`; 29 `TYPE_OTHERS`; 30 `PET_QUALITY`; 31 `PET_GRADE`; 32 `PET_FIGHT_CAPACITY`; 34 `PET_GRADE_RANK`; 35 `PET_CAPACITY_RANK`; 36 `TYPE_FIGHT_CAPACITY`; 37 `TYPE_GRADE_RANKING`; 38 `TYPE_CONSORTIA_RANKING`; 39 `TYPE_REWARD_SCORE`; 40 `TYPE_STORE_COUNT`; 41 `TYPE_TOWER_FIRST_BLOODER`; 42 `TYPE_MOUNT_GREADE`; 43 `TYPE_MOUNT_FOSTER`; 44 `REFRESH_TREASURE_MAP_NUM`; 45 `UPGRAD_LEVEL`; 46 `COMPOSITE_GUARD_CRYSTAL`; 47 `PET_GROWUP`; 48 `PET_APTITUDE`; 49 `NEWYEAR_PAYACT`; 50 `TIMING_REWARD`; 51 `TYPE_KARNEVAL`; 55 `TYPE_MOUNT_FEED`; 56 `TYPE_PET_FEED`; 58 `TYPE_PET_EQUIP_STRENG`; 59 `TYPE_PET_EQUIP_REFRESH`; 60 `TYPE_PET_GEM_COMPOSE`; 61 `TYPE_MOUNT_UPGRADE`; 62 `TYPE_MOUNT_CULTURE`; 67 `TYPE_CHARGE_REWARD`; 68 `TYPE_MOUNT_EXCHANGE`; 70 `TYPE_SKY_TREASURE`; 71 `TYPE_EQUIPMENT_CASTCOUNT`; 73 `CROSS_TOTAL_COST`; 98 `TYPE_NEW_ACTIVE_NUM`; 100 `TYPE_RUNE`; 101 `TYPE_SEEK`; 102 `TYPE_POWCARD_EAT`; 103 `TYPE_POWCARD_GRADE`; 104 `TYPE_POWCARD_GET_SPEC`; 105 `TYPE_KINGTOWER_JOIN`; 106 `TYPE_BLESS_COUNT`; 107 `TYPE_BLESS_PRECENT`; 108 `TYPE_FATE_TURN`; 109 `TYPE_FATE_EAT`; 110 `TYPE_PET_CHALLENGE`; 111 `TYPE_MINEFIELD_BATTLE`; 112 `FISH_TIMES_TYPE`; 113 `SINGLEPASS_TIMES_TYPE`; 114 `TYPE_ONLYONE_POWERCARD_PROFILE`; 115 `TYPE_ONLYONE_FASHION_GRADES`; 116 `TYPE_ONLYONE_HONOR`; 117 `TYPE_REASUREMAP_GET`; 118 `TYPE_TOWER1_FLOORS`; 119 `TYPE_TOWER2_FLOORS`; 120 `FASHION_IDENTIFY`; 121 `TYPE_FASHION_APPRASIAL_STAR`; 122 `TYPE_REWARD_QUALITY`; 123 `TYPE_FATE_LEVEL`; 124 `TYPE_HOURSE_COLLECT_TYPE`; 125 `TYPE_STAR_LEVEL`; 126 `TYPE_HOURSE_GREADE`; 127 `TYPE_HOURSE_COLLECT_COUNT`; 131 `LOGIN_ACTIVE`; 141 `CITY_BATTLE`; 142 `WORLD_MAP_BATTLE`; 143 `TYPE_ITEM_COST`; 145 `TYPE_GODS_TREASURE_ACTIVE`; 146 `TYPE_EMINENT_PERSON`; 152 `TYPE_GUARD_REFRESH`; 153 `TYPE_GUARD_ADVANCE`; 154 `TYPE_GUARD_COMPOSE`; 155 `TYPE_GUARD_SKILL_COMMON`; 156 `TYPE_GUARD_SKILL_MUTILPE`; 157 `TYPE_GUARD_SKILL_PROFE_SINGLE`; 158 `TYPE_GUARD_SKILL_PROFE_MUTILPE`; 159 `TYPE_CHILD_EMBLEM_CONSUME`; 160 `TYPE_CHILD_EMBLEM_GRADES`; 161 `TYPE_CHILD_EMBLEM_REDUCE_UPGRADE`; 162 `TYPE_CHILD_EMBLEM_REDUCE_LEVEL`; 163 `TYPE_CHILD_EMBLEM_RESIST_UPGRADE`; 164 `TYPE_CHILD_EMBLEM_RESIST_LEVEL`; 165 `TYPE_PET_BOSS`; 166 `TYPE_TOTAL_RECHARGE_DAYS`; 167 `TYPE_GOD_HALIDOM_REFRESH`; 168 `TYPE_GUARD_ZEUS`; 169 `TYPE_GUARD_PROMOTE_SINGLE`; 170 `TYPE_GUARD_PROMOTE_MUTILPE`; 171 `TYPE_MOUNTS_DISCOUNT`; 174 `TYPE_PET_EQUIPMENT_ADVANCE`; 175 `TYPE_PET_EQUIPMENT_ADVANCE_COST`; 176 `TYPE_CHILD_COMMON_SKILL`; 177 `TYPE_CHILD_PRO_SKILL`; 178 `TYPE_EQUIPMENT_CAST`; 179 `HIGH_LV_PEARL_STRENGTHEN`; 180 `NEW_FASHION_COMPOSE`; 181 `NEW_TATTOO_REFRESH`; 182 `TYPE_MOUNT_KING_ADDGP`; 183 `TYPE_CHANGEJOB_TALENT_UPGRADE`; 184 `TITAN_LEVEL_UPGRADE`; 185 `FASHION_LEVEL_UPGRADE`; 186 `OUT_LINK`; 187 `PLANES_COST_ENERGY`; 188 `PLANES_COMMEN_EVENT`; 189 `PLANES_BOSS_EVENT`; 190 `SKYBOXROAD_COST_ENERGY`; 191 `PERKINLAB_HARVEST`; 192 `PERKINLAB_ROB`; 193 `PETLAND_KILL_MIDDLE`; 194 `PETLAND_KILL_SENIOR`; 195 `ARCHAEOLOGY_DIG`; 196 `TYPE_CROSS_SERVER_EXCHARGERANK`; 197 `CROSS_RANK_COST`; 198 `NAVIGATION`; 199 `OUTYARD`; 200 `OUTYARD_BATTLE`; 201 `EGG_SUMMON`; 202 `DRAGON_TITAN_INJIE`; 203 `DRAGON_TITAN_CHARGE`; 204 `SUB_STAR`; 205 `PET_CONTRAC_TYPE`; 206 `PET_HELLOWS_FEED`; 207 `PET_HELLOWS_GRADE`; 208 `PET_INSCRIPTION`; 209 `MOHUAN_FANGZHEN`; 210 `RONGYAO_ZHILU`; 211 `MOFA_JIUGUAN`; 212 `TYPE_CONSORTIA_WAJUE`; 213 `TYPE_CONSORTIA_HELP`; 214 `TYPE_EQUIP_LINGLIAN`; 215 `TYPE_TITAN_PEIYANG`; 216 `TYPE_FISION_JINGLIAN`; 217 `TYPE_ARTIFACT_CAST`; 218 `TYPE_ARTIFACT_ADVANCE_STAR`; 219 `TYPE_ARTIFACT_ADVANCE_MONTH`; 220 `TYPE_ARTIFACT_ADVANCE_SUN`; 223 `TYPE_ARTIFACT_CALL`; 224 `TYPE_CHILD_AWAKEN_TRAIN`; 225 `TYPE_RESONATE_TRAIN`; 226 `TYPE_ARMORY_MARK_TRAIN`; 227 `TYPE_ARMORY_GRADE_TRAIN`; 228 `DRAGONTALKER_UPGRADE_SYMBIONT`; 229 `DRAGONTALKER_UPGRADE_TALISMAN`; 230 `DRAGONTALKER_UPGRADE_MOUNT`; 231 `LOING_CONTINUE_DAYS`; 232 `GODDESS_DOUBLE_FORGE`; 233 `SPIRIT_EMBLEM`; 234 `SPIRIT_REDUCE_RESIST`; 235 `SPIRIT_RESIST`; 236 `SPIRIT_LIFE_WHEEL`; 237 `SPIRIT_LIFE_TALENT`; 238 `MONSTER_ACCESSORY`; 239 `GODDESS_GRADE`; 240 `GODDESS_STEP`; 241 `GODDESS_ACCESSORY`; 242 `AVENGER_GRADE`; 243 `GODDESS_FORMATION`; 244 `AVENGER_DEVILARMOR`; 245 `AVENGER_EYE`; 246 `VOCATIONGRADES3`; 247 `THESEUS_ZHANYI`; 248 `THESEUS_BAOWU`; 1001 `ACTIVITY_CODE_TYPE`; 1002 `HOT_BUY_TYPE`; 1003 `REDEEMING_TYPE`; 1004 `VIP_BUY_TYPE`; 1005 `GROUP_BUY_TYPE`; 1007 `REGRESS_TYPE`; 2500 `TYPE_ACTIVE_2500`; 2501 `TYPE_ACTIVE_2501`.

Types with special client rules (`FMo.isOtherType`, `FunnyModel.as:450-469`): 14, 15, 51, 70, 73, 145, 146, 197 are stored in `otherList` and found with `findDataByType`. Tiro types (`FMo.isTiroType`, `:471-490`): 6, 11, 19, 25, 36, 37, 38, 39, 41, 42, 45 go to `tiroFunnyList` when `isInitiate > 0`. `appendParam` is copied only for types 49, 51, 186, 197 (`FM:463-466`).

---

## 6. Templates

No XML for activities: they come from 4475. Client lookups: `ItemTempInfos.xml` (rewards, fashion try-on SonTypes 109..112), `ShopTempInfos.xml` (try-on, hot buy, group buy), `TopToolBtnInfos.xml` (`funny` 1001, `tiro` 2003, `timing` 2005, `karneval` 2009, `online` 3001), `gametimes.xml` (`funny@res`).

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

The activity definitions, per player progress and claims are the sum-active engine tables of [active-framework.md](active-framework.md) (`sum_activities`, `sum_activity_packages`, `sum_activity_progress`, `sum_activity_claims`). This module adds:

```sql
CREATE TABLE seasonal_events.gm_activities (
  active_id        text PRIMARY KEY,
  title            text NOT NULL,
  contents         text NOT NULL,
  award_content    text NOT NULL,
  description      text NOT NULL,
  action_time_text text NOT NULL,
  consortia        integer NOT NULL DEFAULT 0,
  min_grade        integer NOT NULL DEFAULT 0,
  sort             integer NOT NULL DEFAULT 0,
  has_key          integer NOT NULL DEFAULT 0,
  start_date       timestamptz NOT NULL,
  end_date         timestamptz NOT NULL
);

CREATE TABLE seasonal_events.activity_codes (
  code        text PRIMARY KEY,
  active_id   text REFERENCES seasonal_events.gm_activities(active_id),
  reward      jsonb NOT NULL,
  max_uses    integer NOT NULL DEFAULT 1,
  used        integer NOT NULL DEFAULT 0
);

CREATE TABLE seasonal_events.activity_code_uses (
  code        text    NOT NULL REFERENCES seasonal_events.activity_codes(code),
  player_id   bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  used_at     timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (code, player_id)
);

CREATE TABLE seasonal_events.group_buys (
  good_id      integer PRIMARY KEY,
  cur_count    integer NOT NULL DEFAULT 0,
  front_money  integer NOT NULL,
  settle_at    timestamptz NOT NULL
);

CREATE TABLE seasonal_events.group_buy_orders (
  good_id    integer NOT NULL REFERENCES seasonal_events.group_buys(good_id),
  player_id  bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  count      integer NOT NULL DEFAULT 0,
  paid       integer NOT NULL DEFAULT 0,
  settled    boolean NOT NULL DEFAULT false,
  PRIMARY KEY (good_id, player_id)
);

CREATE TABLE seasonal_events.mount_rebates (
  active_id   text    NOT NULL,
  player_id   bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  start_level integer NOT NULL,
  total_cost  integer NOT NULL DEFAULT 0,
  completed   boolean NOT NULL DEFAULT false,
  PRIMARY KEY (active_id, player_id)
);
```

---

## 8. Backend implementation notes

| Handler | Route | Notes |
|---|---|---|
| `seasonal_events::funny::handle_active_query` | 5049 | 166 with `state` per requested `active_id` (claimed or not) |
| `seasonal_events::funny::http_activecheck`, `http_activecodeservlet` | HTTP | validate session `key`, code, activity window, single use; mail or grant; reply "result\|...\|code" |
| `seasonal_events::funny::handle_groupon` | 8645 | pay_type 3 info → 4559; 1 deposit `frontMoney` → 4559; 2 settle at the final price (refund or charge) → 4560 |
| `seasonal_events::funny::handle_mount_act` | 8843 | 4723 |
| sum-active handlers | 8586 | [active-framework.md](active-framework.md) |

- Login pushes: 4251 (GM list), 4475 pages, then the client asks 8586 type 1.
- Progress hooks: every feature named in the condition catalogue reports its counter through the engine (`seasonal_events::sum_active::record(player, condition_id, amount, bak)`).

---

## 9. Open questions and assumptions

- *(assumption)* 4714 is pushed after consumption; content identical to 4476.
- 4559, 4560, 4723 and 8843 are missing from `protocol/opcodes.csv`; names come from `CM/yishi/datas/consant/AcceptProtocolType.as` and `ProtocolType.as`.
- The HTTP result format is only partially visible (`returnResult` reads the first and last fields).

---

## 10. Implementation checklist

- [ ] Tool bar `funny`, `tiro`, `online`, `timing`, `karneval` buttons and glow
- [ ] FunnyFrame left list rules, right view, bag items, multi-claim frame
- [ ] Tiro, online, timing and karneval frames
- [ ] Activity code view (4251, 5049/166, HTTP)
- [ ] Group buy (8645, 4559, 4560, 9523/338)
- [ ] Mount rebate (8843, 4723)
- [ ] Condition catalogue wired to feature hooks
- [ ] Tables `gm_activities`, `activity_codes`, `activity_code_uses`, `group_buys`, `group_buy_orders`, `mount_rebates`
- [ ] Tests: claim after `end_date`, multi-claim above max, code reused, karneval ranking ties
