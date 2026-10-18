# Farmland ("Fazenda")

Module `farmland` of feature `farm`. Crop plots: planting, pests, harvest, death and revival, acceleration, removal, stealing from friends and one key harvest.

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| FMO | `decompiled/core_module/scripts/farm/FarmModel.as` |
| FLI | `decompiled/core_module/scripts/farm/data/FarmLandInfo.as` |
| FLIT | `decompiled/core_module/scripts/farm/view/FarmLandItem.as` |
| FOM | `decompiled/core_module/scripts/farm/view/FarmOperMenu.as` |
| FBCD | `decompiled/core_module/scripts/farm/cell/FarmBagCellDropMediator.as` |
| HF | `decompiled/m3/scripts/farm/newview/HomeFrame.as` |
| FAM | `decompiled/m3/scripts/farm/view/FarmAutoMediator.as` |
| CT | `decompiled/m16/scripts/yishi/view/tips/CropTip.as` |
| ST | `decompiled/m16/scripts/yishi/view/tips/goods/SeedTip.as` |

## 1. Overview

A plot (`pos` 0..17) holds at most one crop (`item_template_id` = seed template, SonType 216). Client derived state (`FLI:92-226`):

- phase: 1 none, 2 growing, 3 ripe (`now >= mature_time` and healthy), 4 dead (`now > mature_time + Property1 minutes`, plots only);
- state: 1 none, 2 healthy, 3 worms, 4 weeds, 5 gloomy, 6 ill, 7 hungry (the last three are pasture only);
- action on click (`curOper`): empty own plot -> open the seed bag (1); dead own -> remove (10), dead friend -> revive (8); worms -> 2; weeds -> 3; ripe own -> harvest (6), ripe friend -> steal (14); growing own -> menu (22: accelerate, remove); otherwise nothing (21).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FarmLandItem` (`FLIT`) | | one plot: crop icon by phase, worm, weed and pick markers, cursor by action, experience float | `FarmLandLayer` in `FarmView` | `CropTip`: name, remaining time "needHM", growth progress, "unaccelerated" marker (`CT:102-161`) |
| `FarmOperMenu` (`FOM`) | | own growing crop: "Acelerar", "Remover" | `FLIT:564-572` | |
| Seed bag | "Armazém" | drag a seed onto an empty plot | `FLIT:169-171` | see [workshops.md](workshops.md) |

## 3. Routes (client to server)

All: C>S 15044 (0x3ac4) `CH_FARM_OPER_CHECK`, `FarmOperReqMsg` (fields in [farm-core.md](farm-core.md)); sender `FM.sendFarmOper(friendId, opType, pos, bagPos, templateId, useBind)` (`FM:635-651`), which also sends 8231 for the same owner. Each response is 4387 with the changed `FarmLandInfoMsg` carrying `op_type` and `result` (0 success, 1 failure).

### L1. Plant (op 1 `ADD_ITEM`)
- UI: drag a seed from the "Armazém" onto a plot (`FBCD:85-127`); several units can be dropped one per plot while dragging a stack.
- Client checks: seed SonType 1500 (animal) -> "Apenas pode crescer na zona das plantas"; plot not open or no data -> ignore; plot has a crop -> "Já há colheita nessa terra"; a crop with the same special group (`Property5 > 0`) already on this farm -> "Na fazenda já encontra-se colheita de mesma categoria".
- Fields: `friend_id` = plot owner (own farm), `op_type = 1`, `pos`, `bag_pos` = seed bag slot, `template_id` = seed template.
- Server: consume one seed, set `add_time = now`, `mature_time = now + Property1 min` (minus soil and acceleration bonuses), clear flags. Response 4387, 115 (bag).

### L2. Kill worms (op 2 `CLEARWORM`) and weed (op 3 `CLEARGRASS`)
- UI: click a plot with worms or weeds (own or friend) (`FLIT:192-197`).
- Fields: `friend_id` = owner, `op_type`, `pos`.
- Response 4387. Client on success: experience float (`FMO.expByOper`), local chat line "Extermínio de verme sucedido {0}" / "Capinação sucedida {0}" (+ ", experiência +{n}") (`FM:863-934`); on failure "Colheita está saudável, não é necessário exterminar vermes" / "... capinar" (`FLIT:379-409`).

### L3. Harvest (op 6 `REAP`)
- UI: click a ripe own plot (`FLIT:198-204`). Client check: seed output gold (`Property2 = -100`) and gold at the storage limit -> "Ouro atingiu limite de armazenamento, não é possível coletar" (`FLIT:229-237`).
- Response 4387 (plot emptied), 115 / resource pushes for the output, farm gp.

### L4. Revive (op 8 `REVIVE`)
- UI: click a dead crop on a friend farm (`FLIT:205-207`). Failure tip "Colheita está saudável, não é necessário ressuscitar".
- Server: assumption: restore the crop to ripe with a fresh death window; owner gets a log line, the helper gets experience 1.

### L5. Remove (op 10 `CLEARCROP`)
- UI: dead own crop click (`FLIT:208-214`) with confirm "Ao remover não poderá coletar os ganhos, amigo pode ressuscitar \ncolheita seca, remover?", or "Remover" in the menu (`FOM:87-97`) with "Ao remover não poderá coletar os ganhos, continuar?".
- Response 4387 (plot emptied, no output).

### L6. Accelerate (op 9 `ACCELERATE`)
- UI: "Acelerar" in the menu (`FOM:59-85`). Client checks: already accelerated (`accelerate_count > 0`) -> "Falha ao acelerar, colheita já foi acelerada"; confirm "Aceleraração de 50% do tempo de crescimento da colheita consume {0} diamantes, acelerar?" with `Farm_Accelerate_Point` = 10, alert `USEBINDPOINT_ALERT`.
- Fields: `op_type = 9`, `pos`, `pay_type` 0 (bound first) or 1.
- Server: debit 10, cut the remaining growth time by 50 % of the total (`accelerate_count = 1`). Response 4387, 3. Client tip "Aceleração sucedida".

### L7. Steal (op 14 `STOLEN`)
- UI: click a ripe crop on a friend farm (`FLIT:172-191`). Client checks: gold limit (as L3); already stolen by me -> "Você já coletou essa colheita, não é possível coletar novamente"; `stolen_count >= 3` -> "Colheita quase esgotada, não é possível coletar"; daily steals reached -> "Falha ao coletar, limite de colheitas atingida".
- Response 4387 with the updated `stolen_count` and `stolenUsers`; failure tip "Falha ao coletar, colheita já obtida" when the crop is gone.
- Server: steal a share of the yield (assumption: 10 % of the remaining yield, at least 1), increment counters, log to the owner.

### L8. One key harvest (op 25 `ONE_KEY_PLANT`)
- UI: quick harvest button on the farm tab (`HF:161-187`), and secretary chore 8 ([../secretary/chore-actions.md](../secretary/chore-actions.md)). Before op 25 the farm tab also sends 5178 (collect tree fruits, own farm, if `canPick`) and 15017 (energize the tree, if allowed) ([yggdrasil.md](yggdrasil.md)).
- Fields: `op_type = 25`, `friend_id` = selected farm owner (self or friend).
- Server: own farm: kill worms, weed, harvest every ripe plot (and remove nothing); friend farm: kill worms, weed, revive dead crops, steal every ripe crop within caps (assumption, mirrors `FAM:118-187`). Response 4387 with all changed plots, item and gp pushes, 592 when sent by the secretary.

`FarmAutoMediator` (`FAM`) implements a client side sequence (one op every 500 ms over all plots) but is never started in this client.

## 4. Server messages (server to client)

### S1. 4387 (0x1123) `U_C_FARMLAND_INFO`
See [farm-core.md](farm-core.md) S2. Client reaction per changed plot (`FLIT:259-340`): `result == 0` -> experience float and gp added locally (`model.myFarm.gp += exp`, on friend farms also `dayGpFromFriend`), chat tip, friend state refresh; `result == 1` -> failure tip.

### S2. 4190 `U_C_CANWATER_USERS`
Friend action flags after each operation (`FM:650`, [farm-core.md](farm-core.md) S3).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Seed fields | `Property1` growth minutes (also the death window after ripening), `Property2` output item (-100 gold, -300 "Espírito", -600 "Cristal de Luz", -700 "Experiência", -500 "Diamante Vinculado", 208001 "Medalhas", event items), `Property3` output count, `Property4` farm gp (assumption), `Property5` special group (one per farm) | `ST:149-190`, `FLI:294-306`, `FBCD:114-119` |
| Death | `now > mature_time + Property1 * 60 s` | `FLI:294-306` |
| Steal | max 3 per crop, once per user, daily 200 | `FMO:31`, `FLI:308-322`, `ConfigInfos.xml` |
| Acceleration | once per crop, 50 % of the growth time, 10 diamonds | `FOM:59-85`, `farm.view.FarmOperMenu.accelerateTip` |
| Pests | weeds 30 %, worms 20 % chance per growth cycle (assumption: rolled once at planting time and placed at a random time before maturity), each costs 10 % of the yield if still present at harvest | `farm_harmful_state_config` |
| Soil bonus | -2 % growth time and +3 % yield per soil level above 1 (assumption) | `FarmCrop_Mature_Percent`, `FarmCrop_Gains_Percent` |
| Magic Spring | slot 2 buff `AddValue` % more yield | `decompiled/m3/scripts/farm/newview/FarmView.as:71-85` |
| Gold limit | gold seeds cannot be harvested or stolen while gold is at its storage limit | `FLIT:229-237` |
| Experience | worm, weed, revive 1 each; friend farm experience capped 500 per day; farm level capped by hero level | `FMO:213-276` |

Seed catalogue highlights (`ItemTempInfos.xml` SonType 216, 82 rows): 1 hour seeds 2160001..2160012 (output 6000..84000 of gold, spirit, light crystal or experience, gp 20), 4 hour seeds 2160013..2160024 (gp 80), 12 hour seeds 2160025..2160036 (gp 240), "Fruto Misterioso" 2160037..2160041 (bound diamonds 5..20, special), "Semente de Medalha" 2160042..2160045 (medals 50..150), event seeds 2125031, 2126xxx.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ItemTempInfos.xml` SonType 216 | seed | `TemplateId`, `TemplateName`, `Profile`, `Property1..5`, `SellGold`, `Description` |
| `ConfigInfos.xml` | constants | `Farm_Accelerate_Point`, `FarmCrop_Operate_GP`, `farm_harmful_state_config`, `Farm_TodayStolen_Count` |

## 7. Persistent state

```sql
CREATE TABLE farm.plots (
  player_id        BIGINT   NOT NULL REFERENCES farm.farms(player_id) ON DELETE CASCADE,
  pos              INTEGER  NOT NULL CHECK (pos BETWEEN 0 AND 17 OR pos >= 1000),
  template_id      INTEGER  NOT NULL DEFAULT 0,
  planted_at       TIMESTAMPTZ,
  fed_at           TIMESTAMPTZ,
  mature_at        TIMESTAMPTZ,
  accelerated      BOOLEAN  NOT NULL DEFAULT false,
  has_worm         BOOLEAN  NOT NULL DEFAULT false,
  has_weed         BOOLEAN  NOT NULL DEFAULT false,
  is_gloomy        BOOLEAN  NOT NULL DEFAULT false,
  is_ill           BOOLEAN  NOT NULL DEFAULT false,
  is_hungry        BOOLEAN  NOT NULL DEFAULT false,
  feed_count       SMALLINT NOT NULL DEFAULT 0,
  pest_due_at      TIMESTAMPTZ,
  yield_count      INTEGER  NOT NULL DEFAULT 0,
  stolen_count     SMALLINT NOT NULL DEFAULT 0 CHECK (stolen_count BETWEEN 0 AND 3),
  PRIMARY KEY (player_id, pos)
);

CREATE TABLE farm.plot_thieves (
  player_id   BIGINT  NOT NULL,
  pos         INTEGER NOT NULL,
  thief_id    BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  amount      INTEGER NOT NULL,
  stolen_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, pos, thief_id),
  FOREIGN KEY (player_id, pos) REFERENCES farm.plots(player_id, pos) ON DELETE CASCADE
);
```

A row exists for every open plot (empty when `template_id = 0`); thieves are cleared when the plot is emptied.

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 15044 op 1 (pos < 1000) | `farm::farmland::handle_plant` |
| 15044 op 2 | `farm::farmland::handle_clear_worm` |
| 15044 op 3 | `farm::farmland::handle_clear_weed` |
| 15044 op 6 (pos < 1000) | `farm::farmland::handle_harvest` |
| 15044 op 8 | `farm::farmland::handle_revive` |
| 15044 op 9 (pos < 1000) | `farm::farmland::handle_accelerate` |
| 15044 op 10 (pos < 1000) | `farm::farmland::handle_remove` |
| 15044 op 14 (pos < 1000) | `farm::farmland::handle_steal` |
| 15044 op 25 | `farm::farmland::handle_auto_harvest` |

- Common validation order: owner farm exists -> caller is the owner (ops 1, 6, 9, 10, 25 on own farm) or a friend (ops 2, 3, 8, 14, 25 on friend farm) -> plot open -> state precondition -> caps (daily counters, steal rules, gold limit) -> transaction (plot row, items, currencies, gp, counters, log) -> push 4387 to the caller (and to the owner when different and online) with `op_type` and `result`; on a failed precondition reply 4387 with the unchanged plot and `result = 1`.
- Lazy state evaluation on read: compute pests and death from timestamps; persist when changed.
- Experience: own actions add to `farm.farms.gp`; friend actions add to the caller's farm gp and `friend_gp_today` (cap 500); apply the hero level cap.
- Logs: steals and helps insert `farm.logs` for the owner and push 145.
- No timers needed beyond lazy evaluation; optional scheduler to push the castle bubble state.

## 9. Open questions and assumptions

- Assumption: steal share 10 % of the remaining yield (min 1).
- Assumption: pests roll at planting and appear at a random time during growth.
- Assumption: revive restores a ripe crop.
- Unknown: exact effect of op 25 on friend farms; follow the client sequence in `FAM:118-187`.

## 10. Implementation checklist

- [ ] Screens (client ready): `FarmLandLayer`, `FarmLandItem`, `FarmOperMenu`, `CropTip`, `SeedTip`.
- [ ] Routes 15044 ops 1, 2, 3, 6, 8, 9, 10, 14, 25 for plots.
- [ ] Message 4387 with `op_type` and `result`; 115 for seeds and outputs.
- [ ] Tables `farm.plots`, `farm.plot_thieves`.
- [ ] Rules: growth and death timers, pests, steal caps, acceleration once, gold limit, special group.
- [ ] Tests: plant on an occupied plot -> result 1; two special crops of the same group refused; steal 4th time refused; accelerate twice refused; dead crop cannot be harvested but can be revived by a friend.
