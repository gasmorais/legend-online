# King return ("Regresso do Rei")

Module `kingback` of feature `returning-players`. Protobuf package `olderreflux`.

Path aliases:

| Alias | File |
|---|---|
| KBM | `decompiled/core_module/scripts/managers/KingbackManager.as` |
| KBO | `decompiled/core_module/scripts/mvc/module/kingback/KingbackModel.as` |
| KBI | `decompiled/core_module/scripts/mvc/module/kingback/KingbackInfo.as` |
| KBT | `decompiled/core_module/scripts/yishi/datas/templates/KingbackTempInfo.as` |
| KBF | `decompiled/m11/scripts/kingback/KingbackFrame.as` |
| KGP | `decompiled/m11/scripts/kingback/page/KingbackGiftPage.as` |
| KDI | `decompiled/m11/scripts/kingback/item/KingbackDayItem.as` |
| KOI | `decompiled/m11/scripts/kingback/item/KingbackOtherItem.as` |
| KOP | `decompiled/m11/scripts/kingback/page/KingbackOtherPage.as` |

## 1. Overview

A personal event for returning players. Eligibility from `older_reflux_conf` = `10,55,30000,50,33`: away at least 10 days, level >= 55, power >= 30000; activity points count 50% and recharge 33% toward the "Pontuação de regresso" (assumption on the meaning of the last two values, matching "a cada {0} pontos de atividade, pode-se aumentar {1} pontos de regresso. Cada recarga de {2} diamantes pode aumentar {3} pontos de regresso"). Tabs come from template `Type` (`KBO` constants):

| Type | Tab (`kingback.tabBtn.titleN`) | Content |
|---|---|---|
| 1 | "Chegando em uma suntuosa cerimônia" | day login rewards (ConditionType 1 and 2, `Topic` = day, `Param2` = previous step) |
| 2 | "Oferta de grande prêmio" | regress score targets (`Topic` = score) |
| 3 | "Pacote Especial" | discounted packs (`Point` price in diamonds, `Param1` original price, `Param2` purchase limit, SubType 4..8 = pack family) |
| 4 | "Infusão espiritual em armas sagradas" | spend `CostItems` 208063 targets |
| 5 | "Fundição de Armas Divinas" | spend 212018 |
| 6 | "Treinamento da Deusa" | spend 212027 |
| 7 | "Evolução de Einherjars" | spend 208023 |
| 8 | "Elevar Guardião/Espírito de Proteção" | spend 2250001 |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `KingbackFrame` (KBF) | "Regresso do Rei" | tabbed container with red dots per tab (`KingbackTabBtn`, rewardState 1) | toolbar `kingback` | event time |
| `KingbackDayPage` / `KingbackDayItem` (KDI) | | daily login rewards, recharge link | tab 1 | reward items, state 0 locked, 1 claimable, 2 claimed |
| `KingbackOtherPage` / `KingbackOtherItem` (KOI, KOP) | "Pontuação de regresso: {0}", "{0} gastos: {1}" | score and spend targets | tabs 2, 4..8 | `needCounts` (current score or spent amount), target text "Prêmio {0} da pontuação de regresso:" / "Gastar {0}* {1} prêmio:" |
| `KingbackGiftPage` (KGP) | "Limite de Compras Restantes: {0}", "Tempo restante:  {0}" | packs | tab 3 | old and new price (`Param1`, `Point`), remaining = `Param2 - needCounts` (KGP:112-113) |

## 3. Routes (client to server)

### R1. Claim or buy (C>S 9690 0x25da `C_OLDER_REFLUX_OP`)
- Request `player.PlayerOpMsg`, sender `KBM.sendOp(templateId, op)` (KBM:98-105): `op (#1, INT32)` always 1 in this client, `templateId (#8, INT32)` the template row. Other `PlayerOpMsg` fields unused.
- Callers: day claim (KDI:120-125), score/spend claim (KOI:95-98), pack buy after "Quer consumir {0} diamantes para comprar este pacote?" with `point >= Point` else recharge (KGP:156-183).
- Server: validate the event is open for the player, the row exists and is in reach (`needCounts` vs target, `rewardState == 1` for claims; for packs remaining limit and diamonds), grant `RewardTemplate` (`id,count|id,count`, negative ids are currencies), mark state, push 515 with the changed rows, 4725 / bag updates.

## 4. Server messages (server to client)

### S1. 515 (0x0203) `U_OLDER_REFLUX`, `OlderRefluxMsg`
Receiver `KBM.__kingbackInfosHandler` (KBM:53-96).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | unused by the client |
| `openTime` | #2 | STRING | event start "YYYY-MM-DD hh:mm:ss" |
| `stopTime` | #3 | STRING | event end |
| `info` | #4 | `OlderRefluxInfoMsg`, repeated | `templateId (#1, INT32)`, `needCounts (#2, INT32)` progress (score, spend, purchases), `rewardState (#3, INT32)` 0 not reached, 1 claimable, 2 claimed (merged by templateId) |
| `openState` | #5 | INT32 | 1 shows the toolbar button |
| `chargeTotalCount` | #6 | INT32 | recharge total during the event |
| `templateId` | #7 | INT32 | unused |

The client counts claimable rows of types other than 3 into info tip 32 (toolbar red number, KBM:89-94). Send at login, on progress changes and after each 9690.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Eligibility | away >= 10 days, level >= 55, power >= 30000 | `older_reflux_conf` |
| Score sources | activity points and recharge (50 / 33 percent, assumption) | `older_reflux_conf`, `kingback.active.des2` |
| Day chain | `Param2` = previous day's TempId must be claimed (assumption) | `OlderRefluxTempInfos.xml` |
| Spend targets min level | 4: 161, 5: 81, 6: 81, 7: 50, 8: 70 (`MinGrade`) | template |
| Pack limits | `Param2` purchases | KGP:112-113 |

## 6. Templates

`OlderRefluxTempInfos.xml` (`KingbackTemplateCate`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1309`): `TempId`, `Type`, `SubType`, `MinGrade`, `MinPower`, `IsCondition`, `ConditionType`, `Topic` (day, score or spend target), `Point` (pack price), `CostItems`, `RewardTemplate`, `Desc`, `Param1`, `Param2`, `IsExist`.

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS returning_players;

CREATE TABLE returning_players.kingback_events (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  opens_at        TIMESTAMPTZ NOT NULL,
  closes_at       TIMESTAMPTZ NOT NULL,
  regress_score   INTEGER NOT NULL DEFAULT 0,
  charge_total    INTEGER NOT NULL DEFAULT 0,
  login_days      SMALLINT NOT NULL DEFAULT 0
);

CREATE TABLE returning_players.kingback_progress (
  player_id       BIGINT NOT NULL REFERENCES returning_players.kingback_events(player_id) ON DELETE CASCADE,
  template_id     INTEGER NOT NULL,
  need_counts     INTEGER NOT NULL DEFAULT 0,
  reward_state    SMALLINT NOT NULL DEFAULT 0 CHECK (reward_state BETWEEN 0 AND 2),
  PRIMARY KEY (player_id, template_id)
);
```

## 8. Backend implementation notes

- `returning_players::kingback::handle_op` for 9690. At login check eligibility (last logout vs `older_reflux_conf`), create the event row with the configured duration (assumption: 15 days like `backBufferDays`), push 515.
- Hooks: activity points, recharge and item consumption (208063, 212018, 212027, 208023, 2250001) update `need_counts` and flip `reward_state` to 1.

## 9. Open questions and assumptions

- Event duration, exact score conversion, and how `op` values other than 1 behave.

## 10. Implementation checklist

- [ ] Screens frame and pages
- [ ] Route 9690 claim and buy
- [ ] Server message 515 at login and on progress
- [ ] Tables `returning_players.kingback_*`
- [ ] Progress hooks from activity, recharge and spends
- [ ] Tests: eligibility, chain order, pack limit
