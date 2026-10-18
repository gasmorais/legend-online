# Taxes ("Impostos") in the Prefeitura

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| LV | `decompiled/m4/scripts/buildings/politics/view/LevyView.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| LA | `decompiled/core_module/scripts/mvc/module/secretary/acts/LevyAction.as` |
| EGU | `decompiled/core_module/scripts/yishi/utils/ExitGameUtils.as` |

## 1. Overview

From Leader level 14 the player can collect taxes in the Prefeitura a limited number of times per day. Each collection grants gold equal to six hours of Prefeitura production (plus the legacy furnace term and the Midas bonus). The daily counter is stored on the Prefeitura building row: `property1` = collections used today, `property2` = collections allowed per day.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `buildings.politics.view.PoliticsFrame` | "Prefeitura Nv. {N}" | Prefeitura base frame ([buildings.md](buildings.md)) plus `LevyView` | Prefeitura click, tutorial | level, production |
| `buildings.politics.view.LevyView` (LV) | "Coletas de impostos restante de hoje:", "Ouro coletado em impostos:", note "Obs.: Quanto maior for a produção da prefeitura, mais ouro de impostos poderá ganhar." | Tax button and counters (`LV:60-138`) | PoliticsFrame | remaining `property2 - property1` " / " `property2`; gold per collection (0 below Leader 14) |

Other displays: castle bubble "castle.gold" ([scene.md](scene.md)), logout reminder "★ Impostos restantes {0} vezes" (`EGU:44-48`), secretary task "Coleta de Impostos" ([../secretary/README.md](../secretary/README.md)).

## 3. Routes (client to server)

### R1. Collect taxes once

- UI: `LevyView._levyBtn` (`LV:80`, handler `LV:92-96`).
- Client checks: button enabled only when `property2 - property1 > 0` and Leader >= 14 (`LV:114`); below 14 a lock strip shows "Função habilitada no Nv. 14" (`LV:74-75`).
- Sender: `PlayerManager.sendLevy(1)` (`PM:1708-1714`).
- Route: C>S 8327 (0x2087) `C_GOLD_IMPOSE`.
- Request `player.PlayerOpMsg`: `op (#1, INT32)` = 1. Other fields unset.
- Response: 4242 (S1) then 109 with the new gold ([resources.md](resources.md)).

### R2. Collect all remaining taxes (secretary)

- UI: Pequena Secretária task "Coleta de Impostos" (`LA:13-17`), see [../secretary/README.md](../secretary/README.md).
- Route: same 8327 with `PlayerOpMsg.op (#1, INT32)` = 2.
- Response: 4242 then 109. Assumption: op 2 collects every remaining collection of the day in one request.

## 4. Server messages (server to client)

### S1. 4242 (0x1092) `U_C_GOLD_IMPOSERESULT`

Message `simple.GoldImposeMsg`. Receiver `BM.__levyUpdateHandler` (`BM:112-124`): writes into the Prefeitura `BuildInfo` (SonType 901) `property1 = left_impose`, `property2 = max_impose`, dispatches `U_C_GOLD_IMPOSERESULT`, which refreshes `LevyView` (`LV:103-106`).

| Field | Tag, type | Meaning |
|---|---|---|
| `left_impose` | #1 INT32 | despite the name, collections already used today (the client shows `max - left` as remaining, `LV:115`, `CWL:552-560`, `EGU:44`) |
| `max_impose` | #2 INT32 | collections allowed per day |

When: response to 8327 (success or failure, with the unchanged counters on failure); push at the daily reset (counters 0 / max) so the castle bubble reappears without relog (assumption). The same values travel in `BuildingInfoMsg.propterty1/2` of the 901 row in 4154 / 4130.

## 5. Rules and formulas

- Gate: Leader level >= 14 (`LV:74`, `LV:114`, `CWL:555`).
- Gold per collection (`LV:117-129`): `levy = Prefeitura.Property1 * 6 + Furnace(SonType 101).Property1 * 3`. The furnace has no template rows in this build, so `levy = Property1 * 6` (390 * 6 = 2 340 at level 1; 26 115 * 6 = 156 690 at level 50; 37 065 * 6 = 222 390 at level 80).
- Midas bonus while Fonte Mágica buffer 1 is active: `+ floor(AddValue * levy / 100)` (`LV:124-129`).
- op 2: `levy * remaining` and `used = max` (assumption).
- Gold from taxes is not limited by `gold_max` (assumption, consistent with [resources.md](resources.md)).
- Daily reset at 00:00 server time: `used = 0` (assumption; the original reset hour is unknown).
- Open: `max_impose`. No template or VIP privilege carries it. Proposal: server config `castle.levy_daily_max`, default 10, flagged as unconfirmed.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/BuildingTempInfos.xml` | 901 rows | `Property1` gold per hour |
| `raw/xml/tempinfos/MagicSpringTempInfos.xml` | buffer 1 | `AddValue` |

## 7. Persistent state

```sql
CREATE TABLE castle.levy_state (
    player_id    bigint   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    used_count   smallint NOT NULL DEFAULT 0 CHECK (used_count >= 0),
    daily_max    smallint NOT NULL DEFAULT 10 CHECK (daily_max >= 0),
    reset_on     date     NOT NULL DEFAULT current_date,
    CONSTRAINT levy_used_within_max CHECK (used_count <= daily_max)
);
```

`castle.buildings.property1/2` of the 901 row are filled from this table when serializing `BuildingInfoMsg`.

## 8. Backend implementation notes

- `castle::levy::handle_collect` (8327): validation order: Leader >= 14; Prefeitura exists; lazy daily reset (`reset_on < today` sets `used_count = 0`); remaining > 0; `op` in {1, 2}. Transaction: lock `castle.levy_state` and `castle.resources`, compute `levy` from the current Prefeitura template and the active Midas buffer (fantasy-bar API), `add_gold` with reason `levy`, increment `used_count` by 1 (op 1) or set it to `daily_max` (op 2). After commit: 4242 then 109. On failure send 4242 with the current counters and a generic alert.
- Daily reset job at 00:00: for online players push 4242 (`0`, `daily_max`); offline players reset lazily.
- Feeds the daily activity points if the original game counted taxes (open, see [../daily-activity/README.md](../daily-activity/README.md)).

## 9. Open questions and assumptions

- Open: daily maximum, VIP bonus to it, and reset hour.
- Assumption: `left_impose` carries the used count (proven by three client readers).
- Assumption: op 2 collects every remaining collection.

## 10. Implementation checklist

- [ ] Table `castle.levy_state` and lazy reset.
- [ ] `handle_collect` op 1 and op 2.
- [ ] 4242 then 109 on success; 4242 with unchanged counters on failure.
- [ ] 901 row `propterty1/2` filled in 4154 / 4130.
- [ ] Daily reset push.
- [ ] Test: Leader 13 rejected; Leader 14 Prefeitura 14 collects 7 215 * 6 = 43 290 gold; counter decreases; bubble hides at 0.
