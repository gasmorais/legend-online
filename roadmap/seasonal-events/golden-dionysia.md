# Golden Dionysia ("Carnaval Dourado", 金色狂欢节, internal name GoldCrazy)

Feature `seasonal-events`, module `golden-dionysia`. Client package `goldenDionysia` (`M11/goldenDionysia/{prizeInfo,middleInfo,rank}/*`), shared `CM/yishi/manager/GoldenDionysiaManager.as` (`GDM`), controller `CM/mvc/controler/GoldendionysiaController.as`. Proto package `cccactive` (`GoldCrazyMsg`, `GoldCrazyRewardMsg`, `CrazyOrderInfoMsg`, `CrazyOrderListMsg`, `GoldCrazyInfoMsg`, `GoldLotteryMsg`). It is a cccactive sub-activity: requests go through 9645 with header `extend1 = 25` ([active-framework.md](active-framework.md)).

Conventions: see [README.md](README.md).

---

## 1. Overview

A cross-server diamond spending jackpot in two phases (`state`):

1. **Accumulation** (`state = 1`): every single diamond spend of at least `joinOnePoint` adds `onePointPer`% of it to a shared jackpot (`currentPoint`); a player whose event spend reaches `joinTotalPoint` takes part. When the jackpot reaches `activeLinePoint` the jackpot is "released"; when it reaches `activeRewardPoint` it is "lit" ("iluminado") and every prize gets a bonus.
2. **Prize phase** (`state = 2`): five prize sets (`rewardType`): 1st, 2nd, 3rd place (mailed), lucky prize (the player throws 3 dice in the frame; if the sum is in the configured range and slots remain they win), and the illumination prize (mailed to everyone else who took part).

Help (`goldenDionysiaFrame.helpContent`) states all of the above; rank and jackpot are refreshed every 3 minutes across servers (`GoldenDionysiaMiddle1.tipsStrip1/2`). Prizes are paid in bound diamonds.

---

## 2. Screens

Controller `goldendionysia`: openType 1 `goldenDionysia.prizeInfo.GoldenDionysiaFrame`, openType 2 `goldenDionysia.rank.GoldenDionysiaWinnerFrame` (`GoldendionysiaController.as:30-40`).

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `prizeInfo.GoldenDionysiaFrame` | help `goldenDionysiaFrame.helpContent` | Main frame | Tool bar `goldendionysia` (TopToolBtnInfo 2047, `TopToolsBar.as:1311-1312`), visible when `grades >= 6` and `openGoldenDionysia` (`TopBtnCheckShowHelper.as:321-322`) | 5 prize columns (`getRewardArrByType(1..5)`), phase 1 middle and time view, or phase 2 middle and lucky view (`GoldenDionysiaFrame.as:160-180`); dice animation and result tip |
| `middleInfo.GoldenDionysiaMiddle1` (phase 1) | "Ativar luz {0}", "Tempo de abertura de prêmio desta temporada: {0}", description "1. Condições de Participação: ... {0} diamantes. 2. ... {1} diamantes, irá sortear {2}% ..." | Jackpot progress | Phase 1 | `currentPoint` (animated digits), `activeLinePoint`, `activeRewardPoint`, `myOrder`, `myConsumPoint`, "(Ainda não atingiu o valor do evento)" or "(Já participou do evento)" by `myConsumPoint < joinTotalPoint`; shine animation when the jackpot grows (`GoldenDionysiaMiddle1.as:160-240`) |
| `middleInfo.GoldenDionysiaMiddle2` (phase 2) | "Obter adição" / "Sem adição" | Lucky draw | Phase 2 | jackpot, my spend, lit flag; draw button enabled by `isLuckReward > 0` (`GoldenDionysiaMiddle2.as:130-152`) |
| `prizeInfo.GoldenDionysiaItem` + `GoldenDionysiaBetItem` | "{0}º lugar", "Restantes: {0}/{1}", "(Valor de participação {0}-{1}º lugar)", "(Sorteando {0}-{1}pts poderá obter)", "Diversos", reward texts `goldenDionysia.rewardTxt<site><kind>` | Prize set and its lines | Frame | `GoldCrazyRewardMsg` rows: refund % of spend, fixed amount, jackpot share, max cap |
| `prizeInfo.GoldenDionysiaLuckyView` | "Lista de Sorteados" link, "O jogador {0} está com muita sorte..." | Last lucky winners | Phase 2 | `orderInfo` rows with `rewardType == 2` |
| `rank.GoldenDionysiaRankView` + `RankItem` | "Valor de consumo acumulado" | Top 100 spenders | Frame | `orderInfo` (first 100) |
| `rank.GoldenDionysiaWinnerFrame` (openType 2) | winners | Lucky winners list | Lucky view link | `getLuckyRankList(2)` |

---

## 3. Routes (client to server)

Route: **9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`**, packet header `extend1 = 25` (`new PackageOut(9645, 0, 25)`), body `cccactive.GoldCrazyMsg`; sender `GoldenDionysiaManager.OperateGoldenDionysiaReq(op, myRewardType = 0)` (`GDM:183-190`); only `op (#1)` and `myRewardType (#17)` are set.

| op | UI control | Sender call site | Client checks | Expected response |
|---|---|---|---|---|
| 1 OPEN | Frame opens | `GoldenDionysiaFrame()` (`prizeInfo/GoldenDionysiaFrame.as:60-65`) | none | 440 |
| 2 REWARD | "draw" button in phase 2 | `GoldenDionysiaMiddle2` (`middleInfo/GoldenDionysiaMiddle2.as:118-122`) | button enabled when `isLuckReward > 0` | 441 with `myRewardType` 4 (lucky) or 5 (illumination), `myLuckNum` dice sum, `myRewardPoint`, `myRewardGift`; then 440 refreshed |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Receiver | When | Reaction |
|---|---|---|---|---|---|
| 440 (0x01b8) | U_C_GOLDCRAZY_INFO | `cccactive.GoldCrazyMsg` | `GDM.__onInfoHandler` (`GDM:58, 63-70`) | op 1; push every jackpot refresh (3 min) to players with the frame open *(assumption)* | Stores the message, fires `GOLDEN_DIONYSIA_INFO` |
| 441 (0x01b9) | U_C_GOLDCRAZY_LUCKY_RESULT | `cccactive.GoldCrazyMsg` | `GDM.__onLuckResultHandler` (`GDM:59, 72-78`) | op 2 | Fires `GOLDEN_DIONYSIA_RESULT [myRewardType, myLuckNum, myRewardPoint, myRewardGift]`; for 4 or 5 the frame splits `myLuckNum` into 3 dice (1..6) and then shows "Parabéns, você obteve o prêmio da sorte!" (4) or "Lamentamos. você não obteve o prêmio da sorte, obteve o prêmio da iluminação!" (5) (`GoldenDionysiaFrame.as:186-262`) |
| 443 (0x01bb) | U_C_GOLDCRAZY_OPENSTATE | `simple.PropertyMsg` | `GDM.__onSwitchDataHandler` (`GDM:60, 80-86`) | Login, start, end | `openGoldenDionysia = param7`; refresh tool bar |
| 442 (0x01ba) | U_C_GOLDCRAZY_RANK | (`CrazyOrderListMsg` by name) | none | not listened by this client | Do not send |

`GoldCrazyMsg` fields: `op` (#1, INT32); `openTime` (#2, STRING); `stopTime` (#3, STRING) end of the current phase (countdown); `currentPoint` (#4, INT32) jackpot; `activeLinePoint` (#5, INT32) release threshold; `activeRewardPoint` (#6, INT32) light threshold (`isActive = currentPoint >= activeRewardPoint > 0`, `GDM:157-160`); `joinTotalPoint` (#7, INT32) participation spend; `joinOnePoint` (#8, INT32) min single spend; `onePointPer` (#9, INT32) percent added; `luckMaxCount` (#10, INT32) lucky slots; `currentLuckCount` (#11, INT32); `isLuckReward` (#12, INT32) draws available; `myConsumPoint` (#13, INT32); `myOrder` (#14, INT32); `myRewardPoint` (#15, INT32); `myRewardGift` (#16, INT32); `myRewardType` (#17, INT32); `reward` (#18, GoldCrazyRewardMsg, repeated); `goldInfo` (#19, GoldCrazyInfoMsg, repeated) not read; `myLuckNum` (#20, INT32) dice sum; `activeUuid` (#21, STRING); `lottery` (#22, GoldLotteryMsg) not read; `state` (#23, INT32) 1 accumulation, 2 prizes; `orderInfo` (#24, CrazyOrderInfoMsg, repeated); `activeLuckMaxCount` (#25, INT32) lucky slots when lit.

`GoldCrazyRewardMsg`: `rewardType` (#2, INT32) set 1..5; `rewardData` (#3, INT32) fixed bound diamonds; `rewardPer` (#4, INT32) percent; `rewardSite` (#5, INT32) text family 1 refund of spend, 2 refund in bound diamonds, 3 jackpot share, 4 illumination bonus (`allocationActive` true when a row has site 4, `GDM:88-104`); `rewardPerMaxData` (#6, INT32) cap; `needNum1` (#7), `needNum2` (#8) INT32 rank range or dice sum range.

`CrazyOrderInfoMsg`: `order` (#1, INT32); `nickName` (#2, STRING); `serverName` (#3, STRING); `consumePoint` (#4, INT32); `rewardType` (#5, INT32) 2 marks lucky winners. `CrazyOrderListMsg`: `orderInfo` (#1, repeated), `rankType` (#2) (unused). `GoldCrazyInfoMsg`: `uUID` (#1), `userId` (#2), `serverName` (#3), `nickName` (#4), `totalConsumPoint` (#5), `oneConsumePoint` (#6), `order` (#7) (unused). `GoldLotteryMsg` (unused).

---

## 5. Rules and formulas

- Spend hook during phase 1: if a single spend `s >= joinOnePoint`, `jackpot += floor(s * onePointPer / 100)`; `myConsumPoint += s`. Participation when `myConsumPoint >= joinTotalPoint`.
- Release and light: released when `jackpot >= activeLinePoint`; lit when `jackpot >= activeRewardPoint` (lucky slots grow from `luckMaxCount` to `activeLuckMaxCount`, prizes get the site 4 bonus).
- Prize lines: `rewardPer`% of own spend (or of the jackpot for site 3) plus `rewardData`, capped by `rewardPerMaxData`.
- Lucky draw: the server rolls 3 dice; win when the sum lies in `[needNum1, needNum2]` of the lucky set and slots remain; otherwise illumination prize *(assumption: the draw is single use: `isLuckReward` decrements)*.
- 1st..3rd place and illumination prizes are mailed at the end.
- Tool bar requires `grades >= 6`.

---

## 6. Templates

None. All values come from the server (activity configuration per `activeUuid`).

---

## 7. Persistent state (PostgreSQL, schema `seasonal_events`)

```sql
CREATE TABLE seasonal_events.gold_crazy_events (
  active_uuid          text PRIMARY KEY,
  open_time            timestamptz NOT NULL,
  prize_time           timestamptz NOT NULL,
  stop_time            timestamptz NOT NULL,
  jackpot              bigint  NOT NULL DEFAULT 0,
  active_line_point    integer NOT NULL,
  active_reward_point  integer NOT NULL,
  join_total_point     integer NOT NULL,
  join_one_point       integer NOT NULL,
  one_point_per        integer NOT NULL,
  luck_max_count       integer NOT NULL,
  active_luck_max_count integer NOT NULL,
  rewards              jsonb   NOT NULL
);

CREATE TABLE seasonal_events.gold_crazy_players (
  active_uuid   text    NOT NULL REFERENCES seasonal_events.gold_crazy_events(active_uuid) ON DELETE CASCADE,
  player_id     bigint  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  server_name   text    NOT NULL,
  consume_point bigint  NOT NULL DEFAULT 0,
  luck_draws    smallint NOT NULL DEFAULT 0,
  reward_type   smallint,
  luck_num      smallint,
  reward_point  integer,
  PRIMARY KEY (active_uuid, player_id)
);
CREATE INDEX gold_crazy_players_rank ON seasonal_events.gold_crazy_players (active_uuid, consume_point DESC);
```

---

## 8. Backend implementation notes

| Handler | Route | Notes |
|---|---|---|
| `seasonal_events::golden_dionysia::handle_open` | 9645/25 op 1 | 440 with the cached cross-server jackpot and rank |
| `seasonal_events::golden_dionysia::handle_reward` | 9645/25 op 2 | phase 2 → participant → draws left → roll 3 dice → lucky slot check (atomic counter) → grant bound diamonds; 441 then 440 |

- Spend hook from the currency feature ([../currency/README.md](../currency/README.md)).
- Cross-server jackpot and ranking aggregated every 3 minutes ([../cross-server/README.md](../cross-server/README.md)).
- Schedules: 443 broadcast at start and end; phase switch at `prize_time` (push 440); mail ranks 1..3 and illumination at the end.

---

## 9. Open questions and assumptions

- *(assumption)* Exact payout formula per `rewardSite`; the client only renders text.
- *(assumption)* Single lucky draw per participant.
- 442 `U_C_GOLDCRAZY_RANK`, `goldInfo`, `lottery` unused by this client.

---

## 10. Implementation checklist

- [ ] Tool bar 2047 (`grades >= 6`)
- [ ] Frame phase 1 and phase 2 views, rank view, winner frame
- [ ] 9645/25 ops 1, 2
- [ ] 440, 441, 443
- [ ] Tables `gold_crazy_events`, `gold_crazy_players`
- [ ] Spend hook, cross-server aggregation, phase scheduler, end mail
- [ ] Tests: spend below `joinOnePoint` adds nothing; lucky slots exhausted gives illumination
