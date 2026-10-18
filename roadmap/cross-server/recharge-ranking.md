# Cross-server recharge ranking ("Recarga Total")

Aliases:

| Alias | File |
|---|---|
| ERF | `decompiled/m11/scripts/exchargerank/ExchargeRankingFrame.as` |
| ECV | `decompiled/m11/scripts/exchargerank/view/ExchargeCrossSerRankView.as` |
| EBV | `decompiled/m11/scripts/exchargerank/view/ExchargeRankBagView.as` |
| ERI | `decompiled/m11/scripts/exchargerank/view/ExchargeRewardItem.as` |
| EDI | `decompiled/m11/scripts/exchargerank/view/ExchargeDataItem.as` |
| ERC | `decompiled/core_module/scripts/mvc/controler/ExchargeRankController.as` |
| ERM | `decompiled/core_module/scripts/managers/ExchargeRankManager.as` |
| ERMOD | `decompiled/core_module/scripts/mvc/module/exchargerank/ExchargeRankModel.as` |

## 1. Overview

Twin of [consumption-ranking.md](consumption-ranking.md) for diamond recharges, over up to 5 event days:

1. "Ranking de Recarga Inter-Serv.": daily ranks (days 1..5) and the accumulated rank across servers, from the file `chargerank.xml`.
2. "Prêmio de ranking inter-serv.": packages of funny activity type 196 (rank rewards; the top 20 claim the next day).
3. "Prêmio de recarga do serv.": packages of funny activity type 67 (single server: personal threshold, VIP accumulation, all players).

The manager listens to the generic funny messages 4475 / 4476 itself and keeps only activities of types 66, 67 and 196 (`ERM:100-242`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `exchargerank.ExchargeRankingFrame` (ERF), controller key `exchargeall`, frame class `excharerank.main` (`ERC:42-45`) | "Ranking de Recarga Inter-Serv." / "Prêmio de ranking inter-serv." / "Prêmio de recarga do serv." (`ERF:183-221`); tip "Instruções: \nO rank de recarga do dia é resfriado a cada hora." | Tabs; reward tabs only for active activities 196 / 67 (`ERF:238-263`); own "today" and "total" (`ERF:156-157`) | top bar `exchargeall` | `_dayTotalCount`, `_myTotalCount` (4745) |
| `ExchargeCrossSerRankView` (ECV) | columns "Rank", "Apelido", "Poder de combate", "Servidor local", "Quantidade de recarga" | Day tabs shown only for days present in the file, accumulated tab (`ECV:98-210`), paging | tab 1 | rows of `exchargeRankList` |
| `ExchargeRankBagView` (EBV) | "Introdução ao evento", "[Tempo do evento] {0} - {1}", "[Conteúdo so evento] {0}" | Package list | tabs 2 and 3 | `ExchargeData` |
| `ExchargeRewardItem` (ERI) | "Acumulação: {0} diamantes", "Jogadores VIP podem obter", "Os jogadores de todos os servidores podem obter", title74 texts | Claim button by status 1 / 2 / 3 | EBV | `FunnyBagData` |

Titles (`ERI:122-186`): condition id 67 with `bak` 1 (title), 2 (accumulation `_chargeNumber` plus VIP text), 3 (all servers text); other packages `value` 2: "Rank {1} de recarga de {0} dias acumulados, (necessário recarregar no mínimo {2} diamantes) poderá obter:" (`funny.datas.FunnyBagData.title74`), `value` 1: title, `value` 3: "TOP{0} jogador do rank de consumo, pode obter aleatoriamente:".

## 3. Routes (client to server)

### R1. Open: refresh activity data

- UI: ERF constructor (`ERF:81`).
- Sender: `ExchargeRankManager.sendInitBagData(1)` (`ERM:360-366`).
- Route: C>S 8586 (0x218a) `C_SUMACTIVE_GATE`, `active.SumActiveGetPackageMsg`: `type (#3, INT32)` = 1.
- Response: 4476.

### R2. Recharge counters

- UI: when activity 67 is parsed (`ERM:173-176`) and when the single server tab is selected (`ERF:286-289`).
- Sender: `ExchargeRankManager.sendPointMsg` (`ERM:62-66`).
- Route: C>S 8866 (0x22a2) `C_REQUEST_CHARGE_REWARD`, empty body.
- Response: S1 4745.

### R3. Ranking file

- UI: `ERF.show` calls `ExchargeRankController.loadXML` (`ERF:93-96`, `ERC:68-79`); reload rule as in the consumption ranking (hour of `createDate`).
- Route: HTTP GET `{TPL}chargerank.xml`, compressed text loader (type 5 `COMPRESS_TEXT_LOADER`, `ERC:81-85`): the body is `ByteArray.uncompress()`ed (zlib) then read as UTF-8 (`decompiled/m18/scripts/com/pickgliss/loader/LoaderManagerII.as:403-405`).
- Format (`ERC:105-160`): `<info createDate="..."/>` and `<ChargeRank rank="" nickName="" fightPower="" level="" serverName="" amount="" vip="" day=""/>` rows grouped by `day`; `day` 0 = accumulated, 1..5 = event days (`ERC:162-199`).

### R4. Claim a package

- UI: claim button of ERI (`ERI:283-286`).
- Sender: `sendGetBag(2, activeId, packageId)` then `sendInitBagData(1)` (`ERM:349-366`).
- Route: C>S 8586 `SumActiveGetPackageMsg` `type` 2 with `activeId (#1, STRING)`, `packageId (#2, STRING)`, `count (#4, INT32)` = 1; then `type` 1.
- Response: items, 4476.

## 4. Server messages (server to client)

### S1. 4745 (0x1289) `U_C_CHARGE_RANK`

`active.ChargeRewardMsg`. Receiver `ExchargeRankManager.__exchargeNumberHandler` (`ERM:90-98`): `_chargeNumber = totalCount (#1)` (VIP accumulation text), `_dayTotalCount = dayTotalCount (#4)`, `_myTotalCount = myTotalCount (#3)`. `topThreeCount (#2)` is ignored. When: response to 8866.

### S2. 4475 / 4476 (funny engine)

Shared messages ([../seasonal-events/README.md](../seasonal-events/README.md)); ERM specific handling:

- 4475 `SumActivesMsg`: keeps activities whose `stop_time` is not past; `active_type` 196 or 67 sets `_isOpen` (top bar); 67 also triggers 8866; only one activity of type 66 and one of type 67 are kept (`ERM:122-159`); for type 196 packages whose first condition has `bak == bak2` in 1..3 fill `topBagList[bak]`; type 67 packages are reordered by `condition_bak` 1..3 (`ERM:257-273`).
- 4476 `SumActiveDataMsg`: per activity `value` = finish number, `activeCharge` = can get; per package `status`, `countDown`, `is_show`, `param1`, `finish_value`, `get_count`; status 1 marks "any to get" and lights the info tip 23 (`ERM:275-332`).

## 5. Rules and formulas

- Visibility: Leader level >= 20 and `_isOpen` (`TopBtnCheckShowHelper.as:279-280`).
- Help (`mainBar.TopToolsBar.exchargeRankingTxt`): the cross ranking refreshes every hour; settlement at 24:00, the top 20 can claim the next day; the single server rewards refresh at 24:00 and players meeting the requirement can claim; VIP rewards need VIP1 bought for more than one month, invalid after expiry.
- Ranked value: diamonds recharged (real money top ups) during the event.

## 6. Templates

None (activities are server configuration of the funny engine).

## 7. Persistent state

```sql
CREATE TABLE cross_server.recharge_rank_entries (
    activity_id  text        NOT NULL,
    day_no       smallint    NOT NULL CHECK (day_no BETWEEN 0 AND 5),
    server_id    integer     NOT NULL,
    server_name  text        NOT NULL,
    user_id      bigint      NOT NULL,
    nick_name    text        NOT NULL,
    grade        integer     NOT NULL DEFAULT 0,
    fight_power  bigint      NOT NULL DEFAULT 0,
    is_vip       boolean     NOT NULL DEFAULT false,
    amount       bigint      NOT NULL DEFAULT 0,
    updated_at   timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (activity_id, day_no, server_id, user_id)
);
CREATE INDEX recharge_rank_order_idx ON cross_server.recharge_rank_entries (activity_id, day_no, amount DESC);
```

## 8. Backend implementation notes

- Recharge hook: `cross_server::recharge_rank::record(player, diamonds)` from the recharge feature while activity 196 or 67 is open.
- `cross_server::recharge_rank::handle_counters` (8866): reply 4745 (`totalCount` = server or VIP accumulation, `myTotalCount`, `dayTotalCount`).
- Hourly job: zlib compress and write `xml/chargerank.xml`; daily settlement at 24:00 updates package statuses of activity 196 for the top 20 and of activity 67 thresholds.

## 9. Open questions and assumptions

- Open: semantics of `totalCount` (server total versus own accumulation) for the VIP package.
- Open: activity type 66 is deduplicated but never displayed.

## 10. Implementation checklist

- [ ] Screens ERF, ECV, EBV, ERI.
- [ ] Routes 8586 types 1 and 2, 8866, HTTP file.
- [ ] Server message 4745; ERM handling of 4475 / 4476.
- [ ] Table `cross_server.recharge_rank_entries`.
- [ ] Hourly file job, daily settlement.
- [ ] Tests: file without day 4 hides tab 4; claim with status 1 succeeds once.
