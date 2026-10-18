# Courtyard ("Casa de Gato")

Module `courtyard` of feature `cat-house`. The 5 toy spots: info request, placing a toy, the cats it attracts, growing timer, harvest and removal.

Path aliases:

| Alias | File |
|---|---|
| CHM | `decompiled/core_module/scripts/managers/CatHouseManager.as` |
| CHTC | `decompiled/core_module/scripts/yishi/datas/templates/cate/CatHouseTemplateCate.as` |
| CHF | `decompiled/m11/scripts/cathouse/CatHouseFrame.as` |
| CCY | `decompiled/m11/scripts/cathouse/CatCourtyard.as` |
| COPC | `decompiled/m11/scripts/cathouse/CatObjectPutConatiner.as` |
| CHEI | `decompiled/m11/scripts/cathouse/CatHouseExchangeItem.as` |
| CRT | `decompiled/m16/scripts/yishi/view/tips/CatRewardTips.as` |
| CWL | `decompiled/m4/scripts/castle/view/layer/CastleWalkLayer.as` |

## 1. Overview

The courtyard shows 5 spots at fixed positions (`CCY:16`). An empty spot shows a "lay" button; a placed toy shows its avatar, the cats around it and, depending on `state`, a "remove" button (growing, `state 1`) or a "harvest" button (ready, `state 2`) (`COPC:120-185`). Hovering the toy shows "Ouro obtido" and the remaining time; hovering a cat shows "Itens obtidos" with its material and count (`COPC:226-272`, `CRT:42-53`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `CatHouseFrame` (`CHF`) | "Casa de Gato" | container 786 x 620: currency bar, courtyard, Magic Spring buff | controller `cathouse` openType 0 | buff "Ouro coletado na Casa de Gatos +{0}%" when Magic Spring slot 1 is active (`CHF:61-76`) |
| `CatCourtyard` (`CCY`) | | 5 spots, sends op 5 on creation (`CCY:25`) | `CHF` | `CHM.cattoysDic[spot]` (`CCY:56-77`) |
| `CatObjectPutConatiner` (`COPC`) | | one spot | `CCY` | toy avatar (`Avatar`), up to `CatCount` cats (`catTemplateId..catTemplateId4`), buttons by state, tip "<b>{name}</b> Ouro obtido: {OutGold} {remaining}" (`catHouse.CatToyWarehouseBar.itemTip`) with remaining `cdTime/1000 - sysSecond` in minutes (`COPC:237-249`) |

## 3. Routes (client to server)

Route: C>S 9585 (0x2571) `C_CATTOYS_OP`, `CattoysInfoMsg`; sender `CHM.OperateCatHouse(op, templateId, id, payType)` (`CHM:137-146`) sets `op (#14, INT32)`, `templateId (#2, INT32)`, `id (#1, INT32)`, `payType (#18, INT32)` only.

### C1. Request courtyard (op 5 `OP_REQUEST`)
- Sent when `CatCourtyard` is created (`CCY:25`). All other fields 0.
- Response: 331 full list.

### C2. Place a toy (op 2 `OP_PLACE`)
- UI: "place" button in the exchange list when stock > 0 (`CHEI:195-198`).
- Fields: `templateId` = toy template, `id` = id of the first owned unplaced toy of that template (`CHM.getCattoysRandomId`, `CHM:126-135`).
- Client checks: none beyond stock > 0. The spot is implied by the toy type (`CHTC:19`).
- Server: the spot of that type must be empty; roll the cats; set `state 1`, `cdTime = now + GrowingMinute`.
- Response: 331.

### C3. Harvest (op 3 `OP_REWARD`)
- UI: "harvest" button, visible when `state == 2` (`COPC:178-181,203-205`).
- Fields: `id` = toy id.
- Server: grant `OutGold` (plus Magic Spring "Toque de Midas" +100% when active) and each cat's `OutTempId x OutTempCount` materials; free the spot.
- Response: 331, 4725 (materials), gold resource push.

### C4. Remove (op 4 `OP_DISMANTLE`)
- UI: "remove" button, visible when `state == 1` (`COPC:174-177,206-224`); confirm "Retirando <font color='#01ccff'>{0}</font> não obterá nenhum ganho, deseja continuar?".
- Fields: `id` = toy id.
- Server: destroy the toy and its cats, free the spot, no reward.
- Response: 331.

## 4. Server messages (server to client)

### S1. 331 (0x014b) `U_C_CATTOYS_INFO`, `CattoysInfoListMsg`
Receiver `CHM.__cattoysHandler` (`CHM:67-96`): rebuilds `cattoysList` (by template, only `isExist`) and `cattoysDic` (by `rotatePos >= 0`), dispatches `CATTOYS_UPDATE` (courtyard redraw `CCY:56-77`).

`cattoyInfos (#1, CattoysInfoMsg, repeated)`, every toy of the player:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `id` | #1 | INT32 | toy instance id |
| `templateId` | #2 | INT32 | toy template (`CattoysTemplateInfos`) |
| `rotatePos` | #3 | INT32 | spot index 0..4, -1 when not placed |
| `state` | #4 | INT32 | 0 normal (stock), 1 producing, 2 ready to harvest, 3 finished (`CHM:29-35`) |
| `profitState` | #5 | INT32 | unused by the client (assumption: 1 when Magic Spring bonus applied) |
| `count` | #6 | INT32 | unused (assumption: gold to receive) |
| `num` | #7 | INT32 | unused |
| `isExist` | #8 | BOOL | true when the toy is owned and unplaced (counts as stock) |
| `catTemplateId` .. `catTemplateId4` | #9..#13 | INT32 | cats attracted (0 = none) |
| `op` | #14 | INT32 | request only |
| `posX`, `posY` | #15, #16 | INT32 | unused |
| `cdTime` | #17 | INT64 | epoch ms when the toy becomes ready |
| `payType` | #18 | INT32 | request only |

Sent: response to every op; at login (assumption, needed for the castle bubble `CWL:676-679`); when a toy turns ready (assumption: push when `cdTime` passes so the bubble appears).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Spots | 5; spot i accepts type `[102,105,101,103,104][i]` | `CCY:14-16`, `CHTC:19` |
| Cats per toy | `CatCount` (swing 1..5 by profile, others 1); at most 5 rendered | `COPC:132,138-169` |
| Cat quality | random Profile in `[CatProfileLimit, CatProfileMax]`, then a random cat template of that Profile (Types 200 + Profile) | assumption from template fields |
| Growing time | `GrowingMinute` (180..1200 min) | `CattoysTemplateInfos.xml` |
| Toy gold | `OutGold` (36000 .. 24000000) | `COPC:248` |
| Cat material | `OutTempId x OutTempCount` (Profile 1 cats: Madeira or Corda; Profile 6: Pena or Nepenta) | `CRT:42-53` |
| Gold buff | Magic Spring slot 1 "Toque de Midas" `AddValue = 100` (%) | `CHF:61-76`, `MagicSpringTempInfos.xml` |
| Removal | no gain | `cathouse.opManager.removeHandler` |
| Castle bubble | any spot with `state == 2` | `CHM:113-124`, `CWL:676-679` |

Toy courtyard data (`CattoysTemplateInfos.xml`):

| Type | Profile 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Swing 101: gold / minutes / cats / cat profiles | 120000 / 360 / 1 / 1-3 | 1080000 / 480 / 2 / 1-4 | 2600000 / 600 / 3 / 1-5 | 6000000 / 720 / 4 / 1-6 | 24000000 / 1200 / 5 / 2-6 |
| Pad 102 | 60000 / 180 / 1 / 1-3 | 300000 / 240 / 1 / 1-4 | 1200000 / 300 / 1 / 1-5 | 3750000 / 360 / 1 / 1-6 | 12000000 / 600 / 1 / 2-6 |
| Stick 103 | 36000 / 180 | 150000 / 240 | 500000 / 300 | 1800000 / 360 | 7500000 / 600 |
| Ball 104 | 60000 / 180 | 150000 / 240 | 900000 / 300 | 3750000 / 360 | 12000000 / 600 |
| Box 105 | 36000 / 180 | 150000 / 240 | 750000 / 300 | 2250000 / 360 | 10500000 / 600 |

Stick, ball and box share the pad's cat count (1) and profile ranges.

Cats (Types 201..206 = Profile 1..6, 4 templates each, `OutTempId x OutTempCount`): Profile 1: 2011 "Gato Branco" -2000x3, 2012 "Gato Preto" -2000x4, 2013 -2100x1, 2014 -2100x2; Profile 2: 2021..2024 "Abissínio", "Brazilian Shorthair" -2100x3, -2100x4, -2200x1, -2200x2; Profile 3: 2031..2034 "Sphynx", "American Shorthair" -2200x3, -2200x4, -2300x1, -2300x2; Profile 4: 2041..2044 "Egyptian Mau", "Bengal" -2300x3, -2300x4, -2400x1, -2400x2; Profile 5: 2051..2054 "Ragdoll", "Norwegian Forest" -2400x3, -2400x4, -2500x1, -2500x2; Profile 6: 2061..2064 "Savannah", "Munchkin" -2500x3, -2500x4, -2600x1, -2600x2.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `CattoysTemplateInfos.xml` Types 101..105 | toy | `TemplateId`, `TemplateName`, `Avatar`, `Types`, `Profile`, `OutGold`, `CatProfileLimit`, `CatProfileMax`, `CatCount`, `GrowingMinute` |
| `CattoysTemplateInfos.xml` Types 201..206 | cat | `TemplateId`, `TemplateName`, `Avatar`, `Types`, `Profile`, `OutTempId`, `OutTempCount` |
| `MagicSpringTempInfos.xml` | buff 1 | `AddValue` |

## 7. Persistent state

Uses `cat_house.toys` ([toy-exchange.md](toy-exchange.md)): `spot_index`, `state`, `cat_template_ids`, `placed_at`, `ready_at`. Harvest log:

```sql
CREATE TABLE cat_house.harvest_log (
  log_id        BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   INTEGER NOT NULL,
  gold          BIGINT  NOT NULL,
  materials     JSONB   NOT NULL,
  removed       BOOLEAN NOT NULL DEFAULT false,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX harvest_log_player ON cat_house.harvest_log (player_id, created_at);
```

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 9585 op 5 | `cat_house::courtyard::handle_request` |
| 9585 op 2 | `cat_house::courtyard::handle_place` |
| 9585 op 3 | `cat_house::courtyard::handle_harvest` |
| 9585 op 4 | `cat_house::courtyard::handle_remove` |

- Building the list: compute `state` lazily (`state 1` and `now >= ready_at` -> 2). `rotatePos = spot_index` or -1; `isExist = spot_index IS NULL`.
- Place: toy belongs to the caller, unplaced, template type matches an empty spot -> roll `CatCount` cats -> set spot, `state 1`, `placed_at`, `ready_at = now + GrowingMinute` -> 331.
- Harvest: toy placed and ready -> one transaction: add gold (`OutGold * (1 + buff/100)`), add each cat's material tokens, delete the toy (assumption: the toy is consumed after one cycle; the client has no "replant") -> 331, 4725, gold push.
- Remove: toy placed and `state 1` -> delete -> 331.
- Timer: schedule a push of 331 at `ready_at` for online players (bubble); otherwise compute on login.
- No battle.

## 9. Open questions and assumptions

- Assumption: a harvested toy is consumed (state 3 "finish" may instead mean it stays on the spot without production; the client shows no button in state 3, so a state 3 toy would block the spot forever).
- Assumption: cat roll uses a uniform Profile in the template range.
- Unknown: meaning of `profitState`, `count`, `num`, `posX`, `posY`.

## 10. Implementation checklist

- [ ] Screens (client ready): `CatHouseFrame`, `CatCourtyard`, `CatObjectPutConatiner`, `CatAvatar`, `ToyAvatar`, `CatRewardTips`.
- [ ] Route 9585 op 5.
- [ ] Route 9585 op 2 with cat roll and timer.
- [ ] Route 9585 op 3 with gold buff and materials.
- [ ] Route 9585 op 4.
- [ ] Message 331 (login push and ready push), 4725.
- [ ] Table `cat_house.harvest_log`.
- [ ] Tests: placing a pad toy fills spot 0; placing into an occupied spot refused; harvest before `ready_at` refused; harvest with Magic Spring doubles gold; remove gives nothing and frees the spot.
