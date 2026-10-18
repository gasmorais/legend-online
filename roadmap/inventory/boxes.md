# Boxes, packs and online time chest

Module of [README.md](README.md). Opening item boxes from the bag (open boxes, paid chests, collection chests, novice packs, convertible materials) and the client package `box`: the novice level pack frame ("Pacote de Iniciante") and the online time chest ("Baú de Tesouros do tempo"). The Pandora lottery is in [pandora.md](pandora.md); the level privilege pack in [bag360.md](bag360.md).

Path aliases:

| Alias | File |
|---|---|
| PBC | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as` |
| GIM | `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as` |
| MUF | `decompiled/core_module/scripts/bag/view/MulItemUseFrame.as` |
| BXM | `decompiled/core_module/scripts/managers/BoxManager.as` |
| BXO | `decompiled/core_module/scripts/managers/BoxSocketOutManager.as` |
| GBF | `decompiled/m11/scripts/gradebox/GradeBoxFrame.as` |
| GBC | `decompiled/core_module/scripts/mvc/controler/GradeBoxControler.as` |
| TBF | `decompiled/m11/scripts/timebox/TimeBoxFrame.as` |
| TBV | `decompiled/core_module/scripts/mainBar/TimeBoxView.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |

## 1. Overview

- Item boxes are bag items opened with the use route 5006 ([item-usage.md](item-usage.md) U1). The server rolls the contents and pushes the new items with 115 (`is_new = true`, fly to bag animation). Box families:

| SonType | Name | Items | Opening rule |
|---|---|---:|---|
| 206 `SONTYPE_OPENBOX` | "Baú ..." boxes, keys | 975 | free; `Property1` = drop id (server table); `IsCanBatch` on 317 of them |
| 311 `SONTYPE_BOX` | paid chests ("Baú valioso", "Caixa de Retorno", "Baú do Copo de Deus") | 30 | pay `Property3` of currency `Property2` per box (all use -400 diamonds in data) |
| 350 | collection chests "Baú de Bronze/Prata/Ouro/Platina/diamante" (3501..3505) | 5 | free, drop rates in `Description` |
| 298 `SONTYPE_NOVICE_BOX` | "Pacote Iniciante Nv. N" | 16 | opened from `GradeBoxFrame`, hero level >= `NeedGrades` |
| 609 `TIMES_PROP` | monthly card style packs | 1 | one use per day, `Property2` uses |
| templates 2100038 "Cristais de Einherjar", 3101011..3101041 "Essência do Fogo/Água/Choque/Vento", 208001 "Medalhas", 208009 "Moeda do Labirinto", 208044 "Maçã de Ouro" | usable materials (`BH.checkCanUseGoods2`) | 8 | 5006 (208044 opens the guardian sex frame instead) |

- The online time chest is not an item: a counter of online minutes unlocks rewards at 5, 10, 15, 20, 30, 40, 50, 60, 75, 90, 120, 150, 180 and 240 minutes (`TimeDrop.xml`); the claim uses the `box` protocol (5019 / 4).
- Contents are not in the client data: `BoxItems.xml`, `GradeDrop.xml` are empty, and no client table maps SonType 206 / 311 / 350 drop ids. The server must own the drop tables (see 9).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data |
|---|---|---|---|---|
| `gradebox.GradeBoxFrame` (`GBF:43-192`, controller `GBC:22-41`) | "Pacote de Iniciante" (`box.novice.GradeBoxFrame.title`); "Parabéns ao elevar para o Nv. {0}, prêmio obtido abaixo" / "Elevar ao Nv. {0}, poderá receber seguinte prêmio" | shows the pack contents for the hero class and a receive button (enabled when level reached) | double click, "Usar" or "Usar em massa" on SonType 298 (`PBC:244-247`, `GIM:302-305`, `GIM:157-160`) | `BoxManager.getGradeBoxGoodsByGrade(NeedGrades)` (rows of `GradeDrop` with `Job == hero job`, `BXM:115-127`), up to 6 cells |
| `timebox.TimeBoxFrame` (`TBF:54-251`) | "Prêmiação" (`box.timeBox.TimeBoxFrame.title`), countdown "Contagem" | rewards of the current period and a receive button enabled at 0 | click on the toolbar chest icon (`TBV:160-173`) or `BoxMovieView` (`decompiled/core_module/scripts/mainBar/view/BoxMovieView.as:69-73`) | `TimeDrop` rows of the current period |
| `mainBar.TimeBoxView` (`TBV`) | tooltip "Ao abrir o Baú de Tesouros do tempo poderá obter as seguintes recompensas" | toolbar chest icon with countdown; hidden in battle, rooms, vehicle, world boss maps (`TBV:107-136`) | shown when hero level >= 8 and periods remain (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:505-511`, `:1027-1030`) | `PlayerInfo.timeProgress`, `timeGet`, `timeRun` |
| Paid chest confirm | "Liberando{0} {1} irá consumir {2} “{3}”, deseja continuar?" | | 311 use | count, box name, cost, currency name |

## 3. Routes (client to server)

### X1. Open a box item

- 5006 `U_C_BAG_USEITEM` (`item.ItemUseMsg`: `pos` #1, `count` #2, `bag_type` #3 = 1, `battle_id` #4 empty, `friend_id` #5 = 0). See [item-usage.md](item-usage.md) U1 for the sender list.
- Client checks for SonType 311 (`PBC:328-431`, `GIM:333-436`, `MUF:171-275`): the player owns at least `Property3 * count` of `Property2` (gold -100, amethyst -200 `mineral`, spirit -300 and -700 `strategy`, diamonds -400 `point`, bound diamonds -500 `giftToken`, light crystal -600, glory -800 `gloryPoint`, else an item count); otherwise "Itens insuficientes para abrir o Baú, não poderá abrir"; then the confirmation.
- Response: 115 removing `count` boxes and adding the contents (`is_new = true`); 3 / 109 for currency contents and costs; 126 on failure.

### X2. Open a novice pack (`GradeBoxFrame`)

- UI: receive button or closing the frame while the button is enabled (`GBF:136-159`); if the level is not reached, closing opens the hero frame instead.
- Route: 5006 with the pack slot, `count = 1` (`GBF:142`, `GBF:156`).
- Response: as X1. Unused legacy route: `BXO.sendBoxNovice(grade)` -> C>S 5018 (0x139a, not in `protocol/opcodes.csv`) with `box.BoxMsg.grade` (#2) (`BXO:30-36`), no caller.

### X3. Query or claim the online time chest

- Query: `TBV.refreshView` on first show sends `BXO.sendBoxTime(false, -1)` (`TBV:203-225`).
- Claim: `TimeBoxFrame` receive button when the countdown is 0 (`TBF:122-139`) sends `BXO.sendBoxTime(true, period)`: period = first period when `timeProgress == 0`, else the next period after `timeProgress` when `timeGet` is true.
- Route: C>S 5019 (0x139b, not in `protocol/opcodes.csv`); request `box.BoxMsg`: `time` (#1, INT32) period in minutes or -1 for a query; `grade` (#2, INT32) unused; `operate` (#3, BOOL) true = claim, false = query; `timerun` (#4, INT32) unused (`BXO:21-28`).
- Response: S1 (4) with the new state, 115 for item rewards, 3 / 109 for currency rewards.

## 4. Server messages (server to client)

### S1. 4 (0x0004, not in `protocol/opcodes.csv`) time chest state

- Message `box.BoxMsg`: `time` (#1, INT32) last period reached (`timeProgress`); `operate` (#3, BOOL) whether that period was claimed (`timeGet`); `timerun` (#4, INT32) seconds already counted toward the next period (`timeRun`); `grade` (#2) unused.
- Receiver: `BoxManager.__getHaveTimeBox` (`BXM:58-67`, listener `BXM:55`) -> `UPDATE_TIME_BOX`: the view restarts the countdown `nextPeriod * 60 - timeRun` (`TBV:175-201`); the frame refreshes or closes when all periods are done (`TBF:141-151`).
- When: answer to X3 (query and claim) and at login (assumption).

### S2. 3 `U_C_PLAYER_INFO` (box fields)

`player.PlayerMsg`: `gradeProcess` (#31, STRING holding an integer bitmask, bit `level` set when the novice reward of that level was received, `BXM:95-103`), `timeProcess` (#32, INT32), `timeGet` (#33, BOOL), `timeRun` (#55, INT32) (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:980-993`).

### S3. 115, 109, 126

As in [item-usage.md](item-usage.md).

## 5. Rules and formulas

- Paid chest cost: `Property3 * count` of `Property2`, paid before rolling; the 30 chests in data all cost diamonds (-400) from 1 to 1 500 per box.
- Collection chest drop rates are written in `Description` (for example 3501 "Bolsa de Ouro: 90% Fragmento de Coletável Azul: 7% ...").
- Novice pack: openable when `hero.level >= NeedGrades` (16 packs in three series 2060109..2060113, 2060207..2060212, 2060308..2060312, levels 35..60, `Job = 0`); contents by hero class (`GradeDrop.Job`). `Property1` drop ids 90140..90365 (series 1: 90100 + level, series 2: 90200 + level, series 3: 90305 + level).
- Time chest periods (minutes of online time, cumulative): 5, 10, 15, 20, 30, 40, 50, 60, 75, 90, 120, 150, 180, 240. A period can be claimed when `timeRun >= period * 60` seconds since the previous claim (assumption: the counter restarts after each claim, `TBV:181-201`). Visible from hero level 8; disappears after the 240 minute period is claimed (`BXM:168-175`). Daily reset: assumption, at 00:00 like other daily data.
- Example time chest rewards: period 5 = 5 000 light crystal (-600), 10 000 gold (-100), 25 000 spirit (-300); period 20 adds 5 bound diamonds (-500).
- Bag space: assumption, the server refuses to open when the contents do not fit (126) instead of mailing.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | box items | `SonType`, `Property1` (drop id), `Property2`/`Property3` (311 cost), `NeedGrades` (298), `IsCanBatch`, `Description` |
| `raw/xml/tempinfos/TimeDrop.xml` | `TimeDropInfo` (rows per period) | `DropId` (10000 + period), `Grade` = period in minutes, `TemplateId` reward (negative = currency), `Data` = count, `Job` (0 any), `ValidDate` |
| `raw/xml/tempinfos/GradeDrop.xml` | `GradeDropInfo` (class `BoxTemplateInfo`: `Grade`, `TemplateId`, `Data`, `DropId`, `Job`) | empty in this build |
| `raw/xml/tempinfos/BoxItems.xml` | `BoxItemTemplate` (`TemplateId`, `Count`, `Param1`, `Param2`, grouped by `@Times`) | empty; no client caller |

## 7. Persistent state

```sql
CREATE TABLE inventory.drop_tables (
  drop_id      INTEGER  NOT NULL,
  entry_no     SMALLINT NOT NULL,
  template_id  INTEGER  NOT NULL,
  count_min    INTEGER  NOT NULL CHECK (count_min > 0),
  count_max    INTEGER  NOT NULL CHECK (count_max >= count_min),
  weight       INTEGER  NOT NULL CHECK (weight >= 0),
  job          SMALLINT NOT NULL DEFAULT 0,
  is_bound     BOOLEAN  NOT NULL DEFAULT true,
  valid_minutes INTEGER NOT NULL DEFAULT 0,
  guaranteed   BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (drop_id, entry_no)
);

CREATE TABLE inventory.novice_pack_claims (
  player_id    BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  level        SMALLINT    NOT NULL,
  claimed_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, level)
);

CREATE TABLE inventory.time_chest_state (
  player_id        BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  last_period      SMALLINT    NOT NULL DEFAULT 0,
  last_claimed     BOOLEAN     NOT NULL DEFAULT false,
  seconds_counted  INTEGER     NOT NULL DEFAULT 0 CHECK (seconds_counted >= 0),
  reset_on         DATE        NOT NULL DEFAULT current_date
);
```

`drop_tables` is a server owned data table (seeded from a JSON or XML under `server/`), shared with every feature that rolls drops. `novice_pack_claims` backs `gradeProcess`.

## 8. Backend implementation notes

- Box family handlers plug into `inventory::usage::handle_use`: `inventory::boxes::open(ctx, row, count)`: check bag space for the worst case -> pay 311 cost (`currency::spend`) -> roll `drop_tables[drop_id]` per box (guaranteed entries plus weighted picks) -> `inventory::store::add` with `is_new = true` -> consume boxes -> one transaction -> push 115, 3, 109.
- Novice pack: check level, class rows, record `novice_pack_claims`, update `gradeProcess` bit, push 3.
- `inventory::boxes::handle_time_chest` (5019): query -> push 4; claim -> validate period is the next one and `seconds_counted >= period * 60` -> grant `TimeDrop` rows for the hero class -> update state -> push 4, 115, 3/109. Online seconds accumulate from the session tracker; daily reset job.
- Use `server/flows.json` rules only for prototyping; final handlers in Rust.

## 9. Open questions and assumptions

- Drop tables for 206 (859 drop ids), 311, 350 and 298 are missing from the client; contents must be reconstructed from `Description` texts and external references.
- Opcodes 4, 5018, 5019 are absent from `protocol/opcodes.csv`; values come from the client code.
- Time chest reset policy and whether the counter restarts after each claim.
- Bound state of box contents (assumption: bound, except items bought for diamonds).

## 10. Implementation checklist

- [ ] Table `inventory.drop_tables` and loader; seed data for every box drop id
- [ ] Box opening (206, 350, 298, 609, materials) inside 5006
- [ ] Paid chest cost (311)
- [ ] GradeBoxFrame flow and `gradeProcess` bitmask in PlayerMsg
- [ ] Route 5019 and push 4 (time chest), PlayerMsg `timeProcess`, `timeGet`, `timeRun`
- [ ] Tables `inventory.novice_pack_claims`, `inventory.time_chest_state`
- [ ] Tests: batch open with partial bag space, 311 insufficient currency, time chest period order
