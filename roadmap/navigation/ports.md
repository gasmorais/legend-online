# Navigation ports and trade expeditions

Feature [navigation](README.md), module `ports`. Aliases in [README.md](README.md). Common request/response format in [hub.md](hub.md).

## 1. Overview

- Three ports: 1 "Porto do Céu", 2 "Porto do Amanhecer", 3 "Porto Azul" (`NavigationBuildView.nameText.text1..3`). Each port has a level 1..6 (`UpGradeTempInfos.xml` Types 161) and offers `ActiveObject` mission slots (3..5) drawn from `NavigationTaskTempInfos.xml` rows whose `RefreshPort` equals the port number.
- A mission asks to deliver `ConsumedItems` (`itemId,count`, negative id = currency) times a multiplier 1..`Data` ("N° de trocas", 1..6 by port level) and pays `ObtainedCurrency x multiplier` "Moedas de Navegação" ("Usar {0} x{1} para trocar {2} moedas de navegação").
- The player ticks the missions he can afford, picks an idle ship and sails ("Navios de Expedição"). Sailing costs 20 strength. The ship is away for the expedition time and the port is busy (`shippingBoatId` set).
- "Recusar" discards the current missions; the port then waits `navigation_port_task_refresh_cd = 20` minutes ("Já recusou troca:") before new missions. The wait can be skipped for 100 diamonds a limited number of times per day (`TemplateId` of the port level, 0..5).
- A single mission quality can be rerolled for 10 diamonds ("Resfriar qualidade da missão").
- Ports are upgraded with coins and diamonds (`TemplateName = "coins,diamonds"` of the next level).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `NAV/NavigationPortFrame.as` (580 x 505) | "Porto"; tabs upgrade/trade; "Nível atual:", "Próximo nível:", "Gasto de elevação:", "Entradas de troca: {0}", "N° de trocas: {0}", "Atualizações imediatas diárias: {0}" | Mission list, accept ("dealBtn") and refuse, port upgrade, cooldown skip (`:115-535`) | port hotspot, openType 3 with port index 1..3 (`:529-535`) | `portList[index - 1]`: level texts (`:404-446`), cooldown `portCd` (`:380-398`), busy state `isTasking` (`:399-403`), coins |
| `NAV/NavigationTaskItem.as` | "N° de trocas", "{0}x", "Aceitar" | One mission: description, owned amount "{0}:{1}/{2}", multiplier combo 1..`Data`, reroll button, select toggle (`:56-247`) | port frame | `taskId{n}`, `taskNum{n}`, `selectedTask{n}`, owned amount via `NavigationHelper.getNumByTempId` (`decompiled/core_module/scripts/mvc/module/navigation/NavigationHelper.as:13-43`) |
| `NAV/NavigationBoatPatrolFrame.as` (595 x 320) | "Navios de Expedição", "Clique para selecionar navio" | Select one idle ship and confirm (`:43-203`); also used for single ship fishing (type 16) | port "dealBtn" (openType 6) | ships, confirm enabled only for `state == 0` (`:173-180`) |

## 3. Routes (client to server)

### R1. Reroll one mission (op 9)

- UI: reroll button of a mission (`NAV/NavigationTaskItem.as:116-135`), disabled while the port is busy (`:224`).
- Client checks: confirmation "Deseja consumir {0} diamantes para atualizar missão atual?" (10, `navigation_port_task_refresh_point`) with the bound diamond option; `judgePointEnoughToShowPay(10, useBound)`.
- Request: `op = 9`, `param1 = portId`, `param2 = ""`, `param3 = useBound ? 0 : 1`, `param4 = slot index 1..ActiveObject`.
- Expected: 341 `{op: 9}`, 342 with the new `taskId{slot}` (new quality), player info 3.

### R2. Refuse missions (op 10)

- UI: "Recusar" (`NAV/NavigationPortFrame.as:351-367`), enabled when the port is not cooling down and not busy.
- Client checks: confirmation "Ao recusar esta troca terá que esperar {0} minutos para efetuar a próxima troca, deseja continuar?" (20).
- Request: `op = 10`, `param1 = portId`, `param2 = ""`.
- Expected: 341 `{op: 10}`, 342 with port `cd = now + 20 min` and no missions (assumption). At `cd`: new missions, 341 `{op: 12}` (PORT_NEW_TASK), 342.

### R3. Send expedition (op 11)

- UI: "dealBtn" (`NAV/NavigationPortFrame.as:330-349`) opens `NavigationBoatPatrolFrame` with `{type: 11, data: port, taskList, numList}`; confirm (`NAV/NavigationBoatPatrolFrame.as:124-148`).
- Client checks: `strength >= navigation_strength_shipping (20)` else "Pontos de movimento insuficiente, não é possível efetuar navegação"; at least one mission selected else "Ainda não escolheu uma missão, não pode realizar trocas."; a mission can only be selected when the player owns `count x multiplier` ("Material insuficiente, não é possível aceitar missão", `NAV/NavigationTaskItem.as:137-151`, `:186-226`) and the port is not busy ("O navio já partiu."); the chosen ship must have `state == 0`.
- Request: `op = 11`, `param1 = portId`, `param2 = boatId`, `param3 = 0`, `param4 = 0`, `param5 = [selected slot indices, 1 based]`, `param6 = [multiplier per selected slot]` (`NAV/NavigationPortFrame.as:478-512`).
- Expected: 341 `{op: 11}` (closes the selection and port frames), 342 with port `shippingBoatId = boatId`, `selectedTask{n}`, `taskNum{n}`, ship `state = 1`, ship `cd = return time`, `strength - 20`; bag 115 / player info 3 for consumed materials. On return: coins credited, ship to rest (event op 2), port gets new missions (event op 12) (assumptions), 342.

### R4. Upgrade port (op 19)

- UI: level button in the upgrade tab (`NAV/NavigationPortFrame.as:283-304`).
- Client checks: confirmation "Deseja gastar {0} Moeda(s) de Navegação e {1} Diamante(s) para melhorar o Porto? (Diamantes vinculados são usados primeiro)"; `currency >= coins` else "Moedas de Navegação insuficientes, não é possível elevar"; `allPoint >= diamonds` else recharge. Costs from the next level `TemplateName` (`:456-476`).
- Request: `op = 19`, `param1 = portId`, `param2 = ""`.
- Expected: 341 `{op: 19}`, 342 with `grades + 1` and more mission slots, player info 3.

### R5. Pay to skip the refusal cooldown (op 20)

- UI: refresh button visible during the port cooldown (`NAV/NavigationPortFrame.as:258-281`, `:380-389`).
- Client checks: `remaining = currentTemplate.TemplateId - payBusinessNum > 0` else "Vezes de encerramento de resfriamento insuficientes"; confirmation "Deseja gastar {0} Diamante(s) para encerrar o resfriamento (restam {1}x)? (Diamantes vinculados são usados primeiro)" with `navigation_refresh_consumption = 100`; `allPoint >= 100` else recharge.
- Request: `op = 20`, `param1 = portId`, `param2 = ""`.
- Expected: 341 `{op: 20}`, 342 with `cd = 0`, new missions, `payBusinessNum + 1`, player info 3.

## 4. Server messages (server to client)

### 342 port rows

`NavigationPortMsg` (package `pet`), field `port` (#9) of `NavigationMsg`, stored by `NM:151-183`:

| Field | Tag, type | Meaning |
|---|---|---|
| `id` | #1, STRING | port id; sorted as string, must sort as 1, 2, 3 (the frame uses list index `portIndex - 1`) |
| `cd` | #2, INT64 | epoch ms end of the refusal cooldown (0 or past when free) |
| `shippingBoatId` | #3, STRING | ship currently on this port's expedition, empty when free (`isTasking`) |
| `taskId1..6` | #4..#9, INT32 | mission template per slot (0 none) |
| `taskNum1..6` | #10..#15, INT32 | chosen multiplier per slot (default 1) |
| `selectedTask1..6` | #16..#21, BOOL | slot taken in the running expedition |
| `payBusinessNum` | #22, INT32 | cooldown skips used today |
| `grades` | #23, INT32 | port level 1..6 |

### 341

Replies `{op: 9|10|11|19|20}`; events `{op: 12}` new missions, `{op: 2}` ship back (see [boats.md](boats.md)).

## 5. Rules and formulas

- Port level table (`UpGradeTempInfos.xml` Types 161, `Grades`: `ActiveObject` slots, `Data` max multiplier, `TemplateId` daily skips, `TemplateName` upgrade cost to reach this level): 1: 3, 1, 0, "0"; 2: 3, 2, 1, "300,50"; 3: 4, 3, 2, "400,100"; 4: 4, 4, 3, "500,200"; 5: 4, 5, 4, "600,300"; 6: 5, 6, 5, "700,400" (max). Client reads `upgradeTemplates[grades - 1]` as current and `[grades]` as next (`decompiled/core_module/scripts/mvc/module/navigation/NavigationPortInfo.as:72-91`).
- Mission pool per port from `RefreshPort`: port 1 types 34..38 (items 2400001..2400005, coins 1..250 per unit); port 2 types 1, 3, 5, 6, 9, 11, 12, 21, 24, 25, 27, 29; port 3 types 2, 4, 7, 8, 10, 20, 22, 23, 26, 28, 30..33. Each type has 5 qualities (`Quality` 1..5, text color frame); standard rows pay 20/40/60/80/100 coins per unit by quality.
- Mission cost = `ConsumedItems.count x multiplier`; reward = `ObtainedCurrency x multiplier`.
- Expedition duration (assumption): `navigation_boat_shipping_cd (60) - ActiveObject(ship grade)` minutes. Rest after return `navigation_boat_stopping_cd (10)` minutes (assumption).
- Strength cost 20 per expedition regardless of missions count.
- Reroll cost 10 diamonds; skip cost 100 diamonds; refusal cooldown 20 minutes.
- Quality distribution of new missions and reroll results is not in client data.
- `NavigationHelper.getNumByTempId` defines owned amounts: -4000 game box coin, -3000 mount coin, -1400 guild skill points, -600 Cristal de Luz, -300 Espírito, -200 mineral, -100 gold, 208001 arena medal, 208009 maze gold, other ids = bag count.

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/NavigationTaskTempInfos.xml` (`navigationTaskTemplateCate`), 155 rows | `TemplateId`; `Types` 1..38 mission kind; `Quality` 1..5; `ConsumedItems` "id,count"; `ObtainedCurrency` coins per unit; `RefreshPort` 1..3 |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 161 | port levels (above) |
| `ConfigInfos.xml` | `navigation_strength_shipping` 20, `navigation_port_task_refresh_point` 10, `navigation_port_task_refresh_cd` 20, `navigation_boat_shipping_cd` 60, `navigation_refresh_consumption` 100 |

## 7. Persistent state

```sql
CREATE TABLE navigation.port (
  player_id          INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  port_no            SMALLINT    NOT NULL CHECK (port_no BETWEEN 1 AND 3),
  grade              SMALLINT    NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 6),
  cooldown_ends_at   TIMESTAMPTZ,
  shipping_ship_id   UUID        REFERENCES navigation.ship(ship_id) ON DELETE SET NULL,
  skips_today        SMALLINT    NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, port_no)
);

CREATE TABLE navigation.port_mission (
  player_id     INTEGER  NOT NULL,
  port_no       SMALLINT NOT NULL,
  slot          SMALLINT NOT NULL CHECK (slot BETWEEN 1 AND 6),
  template_id   INTEGER  NOT NULL,
  multiplier    SMALLINT NOT NULL DEFAULT 1 CHECK (multiplier BETWEEN 1 AND 6),
  selected      BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, port_no, slot),
  FOREIGN KEY (player_id, port_no) REFERENCES navigation.port(player_id, port_no) ON DELETE CASCADE
);

CREATE TABLE navigation.expedition (
  id            BIGSERIAL   PRIMARY KEY,
  player_id     INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  port_no       SMALLINT    NOT NULL,
  ship_id       UUID        NOT NULL REFERENCES navigation.ship(ship_id) ON DELETE CASCADE,
  reward_coins  INTEGER     NOT NULL CHECK (reward_coins >= 0),
  departed_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  returns_at    TIMESTAMPTZ NOT NULL,
  settled_at    TIMESTAMPTZ
);
CREATE INDEX expedition_open_idx ON navigation.expedition (returns_at) WHERE settled_at IS NULL;
```

## 8. Backend implementation notes

- `navigation::ports::handle_reroll` (op 9): port free, slot exists -> charge 10 diamonds per `param3` -> new template of the same port pool (random quality).
- `navigation::ports::handle_refuse` (op 10): port free and not cooling -> clear missions, `cooldown_ends_at = now + 20 min`; schedule new missions.
- `navigation::ports::handle_accept` (op 11). Validation order: port free and not cooling -> ship owned and `state = 0` -> `param5` and `param6` same length, slots valid, multipliers 1..`Data` -> strength >= 20 -> materials owned. Transaction: consume materials and strength, mark missions selected with multipliers, set `shipping_ship_id`, ship `state = 1`, `state_ends_at = returns_at`, insert `expedition` with `reward_coins = sum(ObtainedCurrency x multiplier)`.
- Timer `navigation::ports::on_return`: credit coins, settle expedition, clear port, generate new missions (event 12), ship to rest (event 2, [boats.md](boats.md)).
- `navigation::ports::handle_upgrade` (op 19): next level exists -> coins and diamonds (bound first) -> `grade + 1`, add a mission slot if `ActiveObject` grew.
- `navigation::ports::handle_pay_business` (op 20): port cooling, `skips_today < TemplateId(grade)` -> charge 100 diamonds (bound first) -> clear cooldown, new missions, `skips_today + 1`.
- Every reply: 341 then 342 ([hub.md](hub.md)). No battles.

## 9. Open questions and assumptions

- Reward timing (at departure or return) and whether failures exist.
- Expedition duration formula and whether ports get new missions automatically after an expedition.
- Whether rerolled quality is uniform or weighted.
- Initial port level and missions when navigation unlocks.

## 10. Implementation checklist

- [ ] Screen: `NavigationPortFrame` trade and upgrade tabs
- [ ] Screen: `NavigationTaskItem` mission row with multiplier
- [ ] Screen: `NavigationBoatPatrolFrame` ship selection
- [ ] Route R1 op 9 reroll
- [ ] Route R2 op 10 refuse and event op 12
- [ ] Route R3 op 11 send expedition
- [ ] Route R4 op 19 port upgrade
- [ ] Route R5 op 20 cooldown skip
- [ ] Server message 342 port rows
- [ ] Table `navigation.port`
- [ ] Table `navigation.port_mission`
- [ ] Table `navigation.expedition`
- [ ] Template loaders Types 161, `NavigationTaskTempInfos.xml`
- [ ] Timer: cooldown end, expedition return
- [ ] Test: material consumption equals count x multiplier
- [ ] Test: busy port refuses reroll, refuse and accept
