# Tattoos and tattoo seals (Tatuagem, Selo de Tatuagem)

Path aliases:

| Alias | File |
|---|---|
| TC | `decompiled/core_module/scripts/mvc/controler/TattooController.as` |
| TM | `decompiled/core_module/scripts/mvc/module/tattoo/TattooModel.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| TV | `decompiled/m5/scripts/armyII/viewII/tattoo/TattooView.as` |
| TPF | `decompiled/m5/scripts/armyII/viewII/tattoo/TattooPopFrame.as` |
| TIF | `decompiled/m5/scripts/armyII/viewII/tattoo/TattooImprintFrame.as` |
| AF | `decompiled/m5/scripts/armyII/ArmyFrameII.as` |

## 1. Overview

After the first vocation upgrade the hero frame shows a "Tatuagem" tab with up to 8 tattoo holes (one more per vocation step). Each hole has a tattoo type (normal or "Avançada"), a positive attribute (+value) and a negative attribute (-value), each one of Força (0), Proteção (1), Inteligência (2), Liderança (3), Físico (5). Purifying with dyes rolls new values ("new" fields); the player keeps or replaces them. After quest 1911 (Royal Throne) the player can stamp seals ("Selo de Tatuagem") on up to 4 seal holes that multiply the total tattoo value of one attribute by a percentage. Tattoo totals are the job transfer requirement ([../hero/job-change.md](../hero/job-change.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.tattoo.TattooView` (TV) | hero frame tab | 8 holes ("Clique para purificar" / "Desbloqueado no nv.{0}"), totals "Adição de atributos totais de tatuagem:", seal button ("Clique para efetuar selo", locked until quest: "Ao concluir {0} ativará") | `ArmyFrameII` tab when `vocationGrades > 0` (AF:256-259, AF:981-985; data request AF:1237) | `TattooModel.holes`, `holeInfoIIs` |
| `armyII.viewII.tattoo.TattooPopFrame` (TPF) | "Purificação de tatuagem" (`tattoo.TattooPopFrame.title`) | Current vs new roll, normal/advanced purify, lock positive/negative, auto buy, replace | click a hole (`TC.openPopFrame`, TC:68-72) | dye counts (208101, 208102), ranges, diamond cost |
| `armyII.viewII.tattoo.TattooImprintFrame` (TIF) | "Selo de Tatuagem" (`tattoo.TattooImprintFrame.title`) | Seal a seal hole, optional blessing (100% success) | seal button | "Pedras de selo de tatuagem necessárias:", "Selo de tatuagem atual:", success rate |
| `TattooNewHoleView`, `TattooHoleView`, `TattooBagView` | "Selo de Força {0}", "Efeito de Tatuagem de Força +{0}%" | Seal hole and tattoo hole widgets | TV | |

## 3. Routes (client to server)

All tattoo hole routes: send 9568 (0x2560) `C_TATTOO_REQ`, `TattooHoleReqMsg` (tattoo): `opType` (#1, INT32), `param1` (#2, INT32), `param2` (#3, INT32), `lock_pay_type` (#4, INT32), `material_pay_type` (#5, INT32), `refresh_lock_add` (#6, BOOL), `refresh_lock_minus` (#7, BOOL), `auto_buy` (#8, BOOL).

### R1. Load tattoo data (`opType 1`, `OP_INFO`)
- When: the tattoo tab is shown (AF:1237 → `TC.sendReqTattooInfo`, TC:36-42).
- Response: 274 with all holes (S1), 346 seal data (S2).

### R2. Purify a hole (`opType 2`, `OP_WASH`)
- UI: normal or advanced purify button (TPF:494-620).
- Client checks: if the positive value already reached the advanced cap (5000) or the normal cap (2000, normal purify only), confirm "O valor de atributos já atingiu o limite da tatuagem, ..." (`tattoo.TattooPopFrame.tattoo5000` / `tattoo2000`); a pending unreplaced roll asks "Tatuagem ainda não substituida, deseja purificar?"; without auto buy, the dye count must be >= 100 (`costNum`); with auto buy or locks, diamonds must cover `locks * tattoo_refresh_lock_price (10) + missing dyes * shop GiftToken`, else recharge. Lock confirm: "Ao efetuar tatuagem, os atributos bloqueados irão manter, \nmas sempre que efetuar tatuagem irá consumir diamantes, deseja bloquear?"; auto buy confirm "Quando não tiver materiais suficientes irá comprar automaticamente, deseja continuar?".
- Request (`TC.sendRefresh`, TC:44-57): `opType 2`, `param1` = tattoo type (1 normal with 208101, 2 advanced with 208102), `param2` = hole index + 1, `lock_pay_type` / `material_pay_type` = 2 when bound diamonds allowed else 1, `refresh_lock_add`, `refresh_lock_minus` = locks, `auto_buy`.
- Response: 274 `opType 2` with the hole's `New*` values; bag/currency updates.

### R3. Replace with the new roll (`opType 3`, `OP_REPLACE`)
- UI: replace button (TPF:489-492).
- Request (`TC.sendReplace`, TC:59-66): `opType 3`, `param2` = hole index + 1.
- Response: 274 `opType 3` (old ← new); 113 with new primary attributes.

### R4. Stamp a seal (`C_TATTOO_ENHANCE`)
- UI: seal button in TIF (TIF:279-310). Checks: owns `tattoo_enhance_consume_item` count for that seal hole (208056 x hole number) else "Selo de Tatuagem insuficiente, não é possível efetuar selo"; blessing needs `tattoo_enhance_wish_point` (500) diamonds, confirm "Deseja consumir {0} diamantes para efetuar bênção?"; blessing hidden under anti-addiction (`ConfigManager.info.AAS`).
- Route: send 9603 (0x2583) `C_TATTOO_ENHANCE`, `TattooEnhanceReqMsg` (tattoo): `holeId` (#1, INT32) seal hole 1..4, `wish` (#2, BOOL) blessing (TC:95-102).
- Response: 346 (S2), bag/currency updates, 113.

## 4. Server messages (server to client)

### S1. 274 (0x0112) `U_C_TATTOO_RSP`
- `TattooHoleRspMsg` (tattoo): `opType` (#1, INT32) echo; `holeInfo` (#2, `TattooHoleMsg`, repeated); `param1` (#3, INT32), `param2` (#4, INT32), `param3` (#5, STRING) unused.
- `TattooHoleMsg`: `hole` (#1, INT32) 1-based index, `OldAddProperty` (#2), `OldAddingValue` (#3), `OldReduceProperty` (#4), `OldReduceValue` (#5), `NewAddProperty` (#6), `NewAddingValue` (#7), `NewReduceProperty` (#8), `NewReduceValue` (#9), `OldTattooType` (#10), `NewTattooType` (#11), all INT32; property codes 0 Força, 1 Proteção, 2 Inteligência, 3 Liderança, 5 Físico; -1 = empty hole.
- Receiver: `AM.__tattooHandler` (AM:843-892): `opType 1` (or no cached holes) replaces the whole list; other op types update hole `hole - 1`; notifies `TATTOO_INFO`.
- Unlocked hole count = number of entries in the `opType 1` list (TV:125-165).

### S2. 346 (0x015a) `U_C_TATTOO_ENHANCE_DATA_MSG`
- `TattooEnhanceListMsg` (tattoo): `tattooEnhance` (#1, `TattooEnhanceMsg`, repeated): `holdId` (#1, INT32) seal hole id, `level` (#2, INT32), `property` (#3, INT32) attribute code, `enable` (#4, BOOL).
- Receiver: `AM.__tattooEnhanceDataHandler` (AM:983-1001): `holeInfoIIs` sorted by id, notifies `TATTOO_NEWHOLE_INFO`.

## 5. Rules and formulas

- Holes: 8 max; hole i is unlocked at vocation step i + 1 (`getShortVocationName(job, i + 1)` tip, TV:151-155).
- Value ranges (`ConfigInfos.xml`): normal add `Low_Tattoo_Proterty_Gegion` 1..2000, advanced add `Hight_Tattoo_Proterty_Gegion` 1..5000; reduce ranges 1..10000 (`Low_/Higth_Tattoo_Proterty_Reduce_Gegion`). UI ranges: normal "Pode elevar os atributos 1~{max}", advanced "21~{max}" (TPF:300-331).
- Purify cost: 100 dyes (`TattooModel.NEED_DYE_NUM_ONCE`, normal 208101, advanced 208102) plus 10 diamonds per locked side; auto buy charges the shop price (`GiftToken`) per missing dye.
- Totals (TM:52-155): sum `OldAddingValue` by add property and `OldReduceValue` by reduce property into [Força, Proteção, Inteligência, Físico, Liderança]; then each seal adds `sum(level percent) * total / 100` for its property (`UpGradeTempInfos` `Types 119` `Data` = percent per seal level).
- Seal: item 208056 x hole number (1..4) (`tattoo_enhance_consume_item` = `208056,1|208056,2|208056,3|208056,4`); success/stay/fail weights in `Types 119` `TemplateName` ("100,0,0" at level 1, "90,10,0" at 2, "80,20,0" at 3) *(assumption: success, unchanged, downgrade)*; blessing (500 diamonds) gives 100% (`TattooImprintFrame.successText.text2`); failure lowers the level (`TattooImprintFrame.alertText.text`).
- Seal unlock: quest 1911 completed (`TaskManage.ROYAL_THRONE_TASK`, `decompiled/core_module/scripts/yishi/manager/TaskManage.as:55`; TV:275-296).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ConfigInfos.xml` | | `Low_Tattoo_Proterty_Gegion`, `Hight_Tattoo_Proterty_Gegion`, `Low_Tattoo_Proterty_Reduce_Gegion`, `Higth_Tattoo_Proterty_Reduce_Gegion`, `tattoo_refresh_lock_price` (10), `tattoo_enhance_consume_item`, `tattoo_enhance_wish_point` (500) |
| `UpGradeTempInfos.xml` | `Types 119` | `Grades` (seal level), `Data` (% bonus), `TemplateName` (roll weights) |
| `ItemTempInfos.xml` | 208101, 208102 dyes; 208056 seal stone | consumption, shop prices |
| `QuestTemps.xml` | quest 1911 | seal unlock title |

## 7. Persistent state

```sql
CREATE TABLE fashion.tattoo_holes (
    player_id            BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    hole_index           SMALLINT NOT NULL CHECK (hole_index BETWEEN 1 AND 8),
    tattoo_type          SMALLINT NOT NULL DEFAULT 0,
    add_property         SMALLINT NOT NULL DEFAULT -1,
    add_value            INTEGER  NOT NULL DEFAULT 0,
    reduce_property      SMALLINT NOT NULL DEFAULT -1,
    reduce_value         INTEGER  NOT NULL DEFAULT 0,
    new_tattoo_type      SMALLINT,
    new_add_property     SMALLINT,
    new_add_value        INTEGER,
    new_reduce_property  SMALLINT,
    new_reduce_value     INTEGER,
    PRIMARY KEY (player_id, hole_index)
);

CREATE TABLE fashion.tattoo_seals (
    player_id   BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    hole_id     SMALLINT NOT NULL CHECK (hole_id BETWEEN 1 AND 4),
    property    SMALLINT NOT NULL,
    level       SMALLINT NOT NULL DEFAULT 0,
    enabled     BOOLEAN  NOT NULL DEFAULT FALSE,
    PRIMARY KEY (player_id, hole_id)
);
```

## 8. Backend implementation notes

- `fashion::tattoos::handle_request` (9568) dispatch:
  - `handle_info` (1): create holes up to the vocation step count; reply 274 (all holes) and 346.
  - `handle_purify` (2): validate hole unlocked, type 1/2, materials (or auto buy with diamonds; bound first when pay type 2), lock costs; roll new add/reduce property and values within the type's ranges, keeping locked sides; store as `new_*`; reply 274 `opType 2`; bag/currency pushes.
  - `handle_replace` (3): copy `new_*` into current, clear `new_*`; reply 274 `opType 3`; push 113.
- `fashion::tattoos::handle_enhance` (9603): quest 1911 done; consume 208056 x hole id; blessing 500 diamonds → success; else roll by `Types 119` weights; update level; reply 346; push 113.
- Tattoo totals feed hero stats and the job transfer check (`hero::job_change`).

## 9. Open questions and assumptions

- Assumption: `Types 119` `TemplateName` = success/unchanged/downgrade weights.
- Open: how the seal `property` of a seal hole is chosen (not sent by the client).
- Open: whether the server unlocks holes on vocation step changes automatically (push 274 then).

## 10. Implementation checklist

- [ ] Screens: TattooView, TattooPopFrame, TattooImprintFrame
- [ ] Route 9568 op 1 info
- [ ] Route 9568 op 2 purify (locks, auto buy)
- [ ] Route 9568 op 3 replace
- [ ] Route 9603 seal
- [ ] Server message 274
- [ ] Server message 346
- [ ] Table `fashion.tattoo_holes`
- [ ] Table `fashion.tattoo_seals`
- [ ] Rule: ranges, costs, totals with seal percentages
- [ ] Test: purify, lock positive, replace, job transfer check passes with tattoo totals
