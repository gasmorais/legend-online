# First recharge packs ("Pacote de Primeira Recarga") and period recharge pack

Path aliases:

| Alias | File |
|---|---|
| NFM | `decompiled/core_module/scripts/managers/NewFirstPayManager.as` |
| NFMOD | `decompiled/core_module/scripts/mvc/module/newfirstpay/NewFirstPayModel.as` |
| NFF | `decompiled/m11/scripts/newfirstpay/NewFirstPayFrame.as` |
| RF | `decompiled/m11/scripts/firstpay/RechargeFrame.as` |
| FPF | `decompiled/m11/scripts/firstpay/FirstpayFrame.as` |
| FPC | `decompiled/core_module/scripts/mvc/controler/FirstPayControler.as` |
| FM | `decompiled/core_module/scripts/mvc/module/funny/FunnyModel.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

Three generations of "first recharge" rewards exist in the client:

| Variant | Toolbar key | State | Status in this build |
|---|---|---|---|
| New first recharge (`newfirstpay`) | "newfirstpay" (template 4022 "首充活动") | 4290 + 4590 | active: 3 tiers (500, 2000, 10000 recharged diamonds) x 3 days of rewards |
| Period recharge pack (`firstpay.RechargeFrame`, "rechargetime") | "recharge" (template 2010 "时段首充", tip "Pacote de Recarga em Etapas") | funny activity type 15 (4475 / 4476) | active when the activity exists |
| Legacy first pay (`firstpay.FirstpayFrame`) | "first" | `PlayerMsg.first_charge` | dead: no toolbar template "first" and `FirstPayControler` asks for the missing class `firstpay.FirstFrame` (FPC:17-28) |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `newfirstpay.NewFirstPayFrame` (NFF) | "Pacote de Primeira Recarga" (NFF:118) | Tier buttons 1..3 with red dots, day tabs "Primeiro dia", "Segundo dia", "Terceiro dia", avatar animation, reward items, one action button | TTB:1500-1501; visible when `model.isOpen` and hero level >= 6 (TBH:411-412); toolbar badge `topRedNum` = count of "1" states (NFMOD:20-44, TTB:2744, 2819-2820) | tier thresholds from `newFirstPay_eachQuality_diamonds` (NFF:180-184); text "Recarregue + {0} diamantes para receber" (missing amount) or "Recarregue {0} diamantes para receber" when tier 1 and nothing recharged (NFF:386-399); items from `FirstPayTemplates` by sex, job, tier, day (NFF:364-368, 410-415, 254-284) |
| `firstpay.RechargeFrame` (RF) | "Pacote de prendas de recarga" | Shows the first not yet reached tier of the period recharge activity: "{0}Recarga superior a {1} diamantes" and its items; pay button | TTB:1039-1062 (`openControllerByInfo("rechargetime")`); visible when hero level >= 11, an activity of type 15 exists and one of its packages has status 3 (TBH:241-242, FM:305-327) | packages of `FunnyModel.rechargeBagDataArr` (FM:271-283); closes when no package has status 3 (RF:97-147) |
| `firstpay.FirstpayFrame` (FPF) | "Pacote de Primeira Recarga", "Pode usar" "até o nv.50" | Legacy first recharge rewards by job and a pay button (FPF:57-92, 188-192) | unreachable | `FirstChargeItems` by job |

Click checks of the "recharge" toolbar button (TTB:1039-1062): hero level < 11 -> "Nível menor que 6, não é possível abrir o Guia Diário" (string as in the client); no type 15 package -> "Durante o evento, você já recarregou"; activity missing -> "Evento encerrado".

## 3. Routes (client to server)

### F1. Claim a new first recharge reward
- UI: NFF action button (NFF:304-319). State of (tier, day): "0" -> opens the recharge page (`navigateToRechargePage`, no request); "1" -> claim; "2" -> button hidden ("já coletado").
- Day tab state "0" with day 1 already >= "1": button disabled (the day is not unlocked yet) (NFF:432-450).
- Sender: `NewFirstPayManager.sendGetReward(tier, day)` (NFM:92-99).
- Route: send 8672 (0x21e0) `C_FIRST_PAY_CLIENT_OP`; message `player.PlayerOpMsg`: `payType` (#3, INT32) = tier 1..3 (field reused); `index` (#6, INT32) = day 1..3.
- Expected responses: bag updates, 4290 with that cell set to "2".

### F2. Period recharge and legacy frames
No request: both frames only open the recharge page ([payment.md](payment.md)). Period recharge rewards are granted by the server when the tier is reached (see rules).

## 4. Server messages (server to client)

### S1. 4290 (0x10c2) `U_C_FIRST_PAY_DATA`
- Message `simple.PropertyMsg`: `param1` (#1, INT32) diamonds recharged that count for the event (`chargeNum`); `param4` (#4, STRING) tier 1 states "d1,d2,d3"; `param5` (#5, STRING) tier 2 states; `param6` (#6, STRING) tier 3 states. Each state: "0" not reached or not unlocked, "1" claimable, "2" claimed.
- Receiver: `NewFirstPayManager.__updateOpenState` (NFM:51, 67-90): splits the strings, sets `chargeNum`, dispatches `change` and `INFO_TIPS_DATA_UPDATE`.
- When: login, after each credited recharge, after F1, at 00:00 when a new day unlocks.

### S2. 4590 (0x11ee) `U_C_TOP_TOOL_BTN` with `param1` = 4022
- Message `simple.PropertyMsg`: `param1` (#1) 4022; `param7` (#7, BOOL) open.
- Receiver: `NewFirstPayManager.__topBtnHandler` (NFM:52, 55-65).
- When: login and when the event opens or closes (closes after all 9 cells are claimed, assumption).

### S3. Funny activity messages (period recharge, type 15)
4475 (0x117b) `U_C_SUM_ACTIVE_TEMP` and 4476 (0x117c) `U_C_SUMACTIVE_DATA` (owned by [../seasonal-events/README.md](../seasonal-events/README.md), message fields in [continuous-pay.md](continuous-pay.md) S1 and S2). For type 15: one `SumActiveinfoMsg` with `active_type` 15, packages ordered by `order`, each with condition `condition_value` = recharge amount; `PackageData.status`: 1 reached, 2 granted, 3 not reached. The client shows the first package with status 3. If `start_time` is in the future the client keeps `isNeed` / `needTime` (`decompiled/core_module/scripts/managers/FunnyManager.as:448-460`).

## 5. Rules and formulas

### New first recharge
- Tiers (`ConfigInfos.xml` `newFirstPay_eachQuality_diamonds` = "500,2000,10000"): tier n reached when `chargeNum >= threshold[n]`.
- Day 1 of a tier becomes "1" when the tier is reached; day 2 the next server day; day 3 the day after (assumption from the day tabs and the disabled state of later days, NFF:432-450).
- Rewards: `raw/xml/tempinfos/FirstPayTemplates.xml` row with `PayQuality` = tier, `Time` = day, `Jobs` = hero job 1..3, `Gender` = hero sex 0/1; `Item` = "templateId,count|...". Example tier 1 day 1 job 1: 1011205 x1, 2061016 x10, 2040109 x15, 208017 x100, 2030503 x5. 54 rows (3 tiers x 3 days x 3 jobs x 2 genders).
- `chargeNum` counts diamonds credited since the character creation (assumption: lifetime first recharge offer).

### Period recharge pack (type 15)
- Packages are tiers of recharge during the activity window; the reward of a tier is granted automatically (status 3 -> 2) when the recharged amount in the window reaches `condition_value` (assumption: the frame has no claim button; mail when the bag is full).
- Display ordinal "1".."10" from `firstpay.RechargeFrame.num`.

### Legacy first pay
- `raw/xml/tempinfos/FirstChargeItems.xml` (`job`, `itemid`, `counts`): job 1: -300 x1000000 (Espírito), -100 x1000000 (gold), 2040109 x30, -600 x100000 (light crystal), 1011205 x1, 2030503 x2; jobs 2 and 3 alike. Not shown in this build; do not grant.
- `raw/xml/tempinfos/FirstPayDrop.xml` is loaded into `NewFirstPayDropCate` and never read.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/FirstPayTemplates.xml` | `FirstPayTemplate` | `Id`, `PayQuality` tier, `Time` day, `Jobs`, `Gender`, `Item`, `AvatarPath`, `ImagePath` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `newFirstPay_eachQuality_diamonds` | tier thresholds |
| `raw/xml/tempinfos/FirstChargeItems.xml` | `FirstChageItem` | legacy, unused |
| `raw/xml/tempinfos/FirstPayDrop.xml` | `FirstPayDropInfo` | unused |

## 7. Persistent state

```sql
CREATE TABLE recharge.first_pay_states (
  player_id    BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  tier         SMALLINT    NOT NULL CHECK (tier BETWEEN 1 AND 3),
  reached_at   TIMESTAMPTZ NOT NULL,
  claimed_days SMALLINT[]  NOT NULL DEFAULT '{}',
  PRIMARY KEY (player_id, tier)
);
```

`chargeNum` is `recharge.player_totals.total_diamonds` ([payment.md](payment.md)). Period recharge state lives in the funny activity tables of [../seasonal-events/README.md](../seasonal-events/README.md).

## 8. Backend implementation notes

- `recharge::first_pay::on_recharge(tx, player_id, total)`: insert `first_pay_states` rows for newly reached tiers with `reached_at = now`; after commit push 4290.
- State string per tier: day d is "2" if claimed, "1" if `days_between(reached_at::date, today) >= d - 1`, else "0".
- `recharge::first_pay::handle_claim` (8672): validate tier 1..3 (from `payType`) and day 1..3 (from `index`); lock row; require state "1"; grant the `FirstPayTemplates` row for sex and job (mail overflow); append day; push bag and 4290.
- Midnight job: push 4290 to online players with a reached tier and an unclaimed future day.
- Event visibility: send 4590 `param1` 4022 `param7` true while any cell is not "2" (assumption).
- Funny type 15: `funny::on_recharge` updates the activity value and grants reached packages (status 2), then pushes 4476.

## 9. Open questions and assumptions

- Assumption: day unlocking one per server day after reaching the tier.
- Assumption: `chargeNum` is lifetime, not per event window.
- Assumption: period recharge rewards are auto granted.
- Open: whether the new first recharge closes for good after all claims or after a date.

## 10. Implementation checklist

- [ ] Screen: tier and day tabs, red dots, toolbar badge
- [ ] Screen: period recharge frame shows the first unreached tier
- [ ] Route F1 8672 tier and day
- [ ] Server message S1 4290 states and `chargeNum`
- [ ] Server message S2 4590 id 4022
- [ ] Server message S3 funny type 15 data
- [ ] Table `recharge.first_pay_states`
- [ ] Rule: thresholds 500, 2000, 10000
- [ ] Rule: rewards by tier, day, job, sex
- [ ] Rule: day unlock schedule
- [ ] Test: claim of a day "0" is refused
- [ ] Test: recharge crossing two tiers unlocks day 1 of both
