# Cross-server consumption ranking ("Consumo do Povo")

Aliases:

| Alias | File |
|---|---|
| CCF | `decompiled/m11/scripts/crosscost/CrossCostFrame.as` |
| CCV | `decompiled/m11/scripts/crosscost/view/CrossCostView.as` |
| CCI | `decompiled/m11/scripts/crosscost/view/CrossCostItem.as` |
| CRV | `decompiled/m11/scripts/crosscost/view/CrossCostRewardView.as` |
| CRI | `decompiled/m11/scripts/crosscost/view/CrossCostRewardItem.as` |
| CRI2 | `decompiled/m11/scripts/crosscost/view/CrossCostRewardItem2.as` |
| CCC | `decompiled/core_module/scripts/mvc/controler/CrossCostController.as` |
| FM | `decompiled/core_module/scripts/managers/FunnyManager.as` |
| FMOD | `decompiled/core_module/scripts/mvc/module/funny/FunnyModel.as` |
| ERM | `decompiled/core_module/scripts/managers/ExchargeRankManager.as` |

## 1. Overview

A 3 day event that ranks diamond consumption across servers. The frame has up to three tabs:

1. "Rank de consumo inter-servidor": daily and total rankings (top players of all servers) read from the static file `consumrank_unzip.xml`, plus two counters: the server-wide (or top three) consumption and the event target.
2. "Prêmio de Rank inter-servidor": reward packages of funny activity type 197 (cross ranking rewards, claimable the next day by top ranks).
3. "Prêmio de consumo inter-servidor": reward packages of funny activity type 73 (single server consumption rewards: thresholds, VIP only rewards and all server rewards).

Reward packages, claim states and claims use the generic funny engine ([../seasonal-events/README.md](../seasonal-events/README.md)); this module only adds the ranking file and the counters message 345.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `crosscost.CrossCostFrame` (CCF) | "Rank de consumo inter-servidor", "Prêmio de Rank inter-servidor", "Prêmio de consumo inter-servidor" (`CCF:300-352`); tip "Instruções: \nO rank de consumo do dia é resfriado a cada hora." | Left tabs present only for active activities (`CCF:170-212`); own "today" and "total" consumption texts (`CCF:252-256`) | top bar `crosscost` | `currentCost.dayTotalCount`, `myTotalCount` |
| `CrossCostView` (CCV) | columns "Rank", "Apelido", "Nível", "Servidor local", "Quantidade de Consumo" | Day tabs 1..`len` (max 3) and a total tab; paging | tab 1 | rows from the ranking file; counters: `threeTotalValue` (345) and `appendParam` of activity 197 (`CCV:313-330`) |
| `CrossCostItem` (CCI) | | Row: rank, nickname (gold color and VIP mark when `vip == 1`), level (hidden when 0), server, amount with the literal "Necessário Consumir" removed (`CCI:140-160`) | CCV | |
| `CrossCostRewardView` (CRV) | "[Tempo do Evento]" "{0}-{1}", "[Conteúdo do Evento]" | Package list of the selected activity; for activity 73 rows 2 and 3 are merged into one two column item (`CRV:184-191`) | tabs 2 and 3 | `FunnyData` (title, `condition`, `describe`, dates, `bagList`) |
| `CrossCostRewardItem` (CRI), `CrossCostRewardItem2` (CRI2) | titles below, "Acumulação: {0} diamantes", "Jogadores VIP podem obter", "Os jogadores de todos os servidores podem obter" | Claim button: status 1 enabled, 2 claimed (gray, mark), 3 not reached (disabled) (`CRI:288-343`) | CRV | package rewards and conditions |

Package titles (`CRI:178-250`): for condition id 73: `bak` 1 uses the package title, `bak` 2 adds "Acumulação: {0} diamantes" (`currentValue` from 345) and "Jogadores VIP podem obter", `bak` 3 shows "Os jogadores de todos os servidores podem obter"; otherwise `value` 2: "Rank {1} de recarga de {0} dias acumulados, (necessário recarregar no mínimo {2} diamantes) poderá obter:" (`funny.datas.FunnyBagData.title80`, `{0}` = `bak`, `{1}` = `bak2` in Chinese upper numerals, `{2}` = `bak3`), `value` 1: package title, `value` 3: "TOP{0} jogador do rank de consumo, pode obter aleatoriamente:".

## 3. Routes (client to server)

### R1. Open: refresh activity data

- UI: CCF constructor (`CCF:75`).
- Sender: `FunnyManager.sendGetBag(1)` (`FM:969-978`).
- Route: C>S 8586 (0x218a) `C_SUMACTIVE_GATE`, `active.SumActiveGetPackageMsg`: `type (#3, INT32)` = 1; `activeId (#1, STRING)`, `packageId (#2, STRING)` empty, `count (#4, INT32)` = 1.
- Response: 4476 `SumActiveDataMsg` ([../seasonal-events/README.md](../seasonal-events/README.md)).

### R2. Counters

- UI: CCF constructor (`CCF:79`).
- Sender: `CrossCostController.sendInfo` (`CCC:185-190`).
- Route: C>S 9602 (0x2582) `C_REQUEST_CONSUM_REWARD`, `active.ChargeRewardMsg` with no field set.
- Response: S1 345.

### R3. Ranking file

- UI: tab 1 (`CCF:313-316`), `CrossCostController.loadXML` (`CCC:64-75`): reload when the current hour differs from the file hour or the file was never loaded.
- Route: HTTP GET `{TPL}consumrank_unzip.xml` (`PathManager.orderPath`, uncompressed text loader type 8, `CCC:77-81`).
- Format (`CCC:96-150`): root with `<info createDate="YYYY-MM-DD hh:mm:ss.fff"/>` and `<ConsumRank rank="" nickName="" level="" serverName="" amount="" vip="" day=""/>` rows grouped by `day` (rows of the same day must be contiguous). `day` 1, 2, 3 = daily ranks of event days, 0 = total (`CCC:152-183`). `amount` is a display string.

### R4. Claim a package

- UI: claim button of CRI / CRI2 (`CRI:345-349`).
- Client checks: status 1.
- Sender: `ExchargeRankManager.sendGetBag(2, activeId, packageId)` then `sendInitBagData(1)` (`ERM:349-366`).
- Route: C>S 8586 `C_SUMACTIVE_GATE`, `SumActiveGetPackageMsg`: first `type` = 2, `activeId (#1)`, `packageId (#2)`, `count` = 1; then `type` = 1 (refresh).
- Response: item grants, 4476 with `status` 2.

## 4. Server messages (server to client)

### S1. 345 (0x0159) `U_C_CONSUM_RANK`

`active.ChargeRewardMsg`. Receiver `FunnyManager.__returnCrossCostHandler` (`FM:159`, `FM:216-228`): `currentCost = {currentValue: totalCount, threeTotalValue: topThreeCount, dayTotalCount, myTotalCount}`, event `REFRESH_CURRENT_COST`.

| Field | Tag, type | Meaning |
|---|---|---|
| `totalCount` | #1 INT32 | server consumption total ("Acumulação: {0} diamantes" in VIP packages) |
| `topThreeCount` | #2 INT32 | counter shown in the rank tab (assumption: sum of the top 3 across servers) |
| `myTotalCount` | #3 INT32 | caller's total consumption during the event |
| `dayTotalCount` | #4 INT32 | caller's consumption today |

When: response to 9602.

4475 and 4476 carry the activities 197 and 73 (funny engine). Activity 197 `appendParam (#13)` is the second counter of the rank tab (`FM:463-466`, `CCV:319-322`).

## 5. Rules and formulas

- Visibility: Leader level >= 20 and activity type 73 or 197 present (`TopBtnCheckShowHelper.as:305-308`).
- Day tabs: `len = min(3, days since FunnyModel.openDate)` (`CCF:159-168`); the default tab is the latest day.
- Help (`mainBar.TopToolsBar.crosscostTxt`): the ranking refreshes every hour; daily settlement at 24:00, eligible players must claim on the same day; VIP rewards need a VIP of one month or more and are lost when it expires.
- Counted value: diamonds spent (assumption: paid diamonds only, not bound).

## 6. Templates

None. Activity definitions come from the funny engine (server configuration), ranking from the generated file.

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS cross_server;

CREATE TABLE cross_server.spend_rank_entries (
    activity_id  text        NOT NULL,
    day_no       smallint    NOT NULL CHECK (day_no BETWEEN 0 AND 3),
    server_id    integer     NOT NULL,
    server_name  text        NOT NULL,
    user_id      bigint      NOT NULL,
    nick_name    text        NOT NULL,
    grade        integer     NOT NULL DEFAULT 0,
    is_vip       boolean     NOT NULL DEFAULT false,
    amount       bigint      NOT NULL DEFAULT 0,
    updated_at   timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (activity_id, day_no, server_id, user_id)
);
CREATE INDEX spend_rank_order_idx ON cross_server.spend_rank_entries (activity_id, day_no, amount DESC);
```

`user_id` is the id on the origin server (no foreign key). Claims are stored by the funny engine.

## 8. Backend implementation notes

- Ledger hook: every diamond spend calls `cross_server::consumption::record(player, amount)` while an activity 73/197 is open; updates day and total rows (also forwarded to the cross service for other servers).
- `cross_server::consumption::handle_counters` (9602): reply 345 from the ledger.
- Hourly job: write `xml/consumrank_unzip.xml` (top N per day and total, `createDate` = generation time) under the CDN root; daily job at 24:00: settle the day ranks and set package statuses of activity 197 (status 1 for qualified ranks with `bak3` minimum) through the funny engine.
- Claims run through `seasonal_events::funny::handle_gate` (8586 type 2).

## 9. Open questions and assumptions

- Assumption: meaning of `topThreeCount` and `appendParam` counters.
- Assumption: N rows per day in the file (proposal 20, as in the recharge help).
- Open: whether only paid diamonds count.

## 10. Implementation checklist

- [ ] Screen CCF with tabs, CCV, CRV, CRI, CRI2.
- [ ] Routes 9602, 8586 types 1 and 2, HTTP ranking file.
- [ ] Server message 345.
- [ ] Table `cross_server.spend_rank_entries`.
- [ ] Hourly file job and daily settlement.
- [ ] Tests: file rows grouped by day map to tabs 1..3 and total; claim of a status 3 package refused.
