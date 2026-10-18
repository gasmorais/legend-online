# Goddess accessories: strengthen, advance, set bonus, double forge

Module `equipment`. Every active goddess has four fixed accessory slots ("Acessório da Deusa"). They are not bag items: each slot is a pair of levels (strengthen 0..240, advance 0..5) plus a blessing counter. Strengthening spends "Martelo de Luz" 208500 and gold and succeeds with a blessing based chance; advancing spends "Coração da Deusa" and "Tomo da Deusa" items and raises the strengthen cap and the percent bonus. When all four slots reach a set grade the goddess gains Hit and Penetration. A timed server event, "Forja Dupla da Deusa", is announced through opcode 4954.

Path aliases:

| Alias | File |
|---|---|
| GM | `decompiled/core_module/scripts/managers/GodDessManager.as` |
| GMOD | `decompiled/core_module/scripts/mvc/module/goddess/GodDessModel.as` |
| GEI | `decompiled/core_module/scripts/mvc/module/goddess/GoddessEquipInfo.as` |
| GET | `decompiled/core_module/scripts/yishi/datas/templates/GoddessEquipTempInfo.as` |
| GEC | `decompiled/core_module/scripts/yishi/datas/templates/cate/GoddessEquipTempCate.as` |
| V | `decompiled/m5/scripts/goddess/` |

Core goddess data, opcode 5191 and push 177 are documented in `goddess.md`; this file covers ops 8 and 10 and push 4954.

## 1. Overview

| Slot `equipType` | pt-BR name (`GET:45-63`) | Stat it adds to the goddess (`V/view/GoddessLevelView.as:168-178`) |
|---|---|---|
| 1 | Coroa Radiante | Live (HP) |
| 2 | Vontade de Ferro | Defance (physical defence) |
| 3 | Flor Milagrosa | Attack |
| 4 | Colar da Benção | MagicDefance |

Template kinds in `GoddessEquipmentTempInfos.xml` (`AdvanceType`, `GET:8-12`): 1 = strengthen level row (`Grade` 0..240), 2 = advance row (`Grade` 0..5), 3 = set bonus row (one per slot index, `Grade` 40, 80, 160, 240).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/page/GoddessEquipPage.as` | tab "Acessórios" (index 3) | container with sub tabs strengthen / advance; default slot 1 on goddess change (`:69-91`) | `GodDessFrame` tab 3, `SwitchPageHelp.openStrengthenGodess` and `openAdvanceGodess` (frameData 3, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2856-2878`) | |
| `V/view/GoddessEquipView.as`, `V/item/GoddessEquipCell.as` | | four slot cells and four set icons | page | set tooltip "Liberado quando 4 peças de acessório atingirem nv. {1} （Apenas para Deusa）" with the set stats, grey until all 4 slots qualify (`:154-211`) |
| `V/view/GoddessEquipStrengthView.as`, `V/item/GoddessEquipStrengthItem.as` | "Martelo de Luz", "(Quantidade atual: {0})" | strengthen, auto strengthen, cancel auto | equip page | current/next strengthen row, blessing bar `equipCurBlessing / Blessing[1]`, gold cost, hammer cost, "double" badge when the event is on (`:163-235`) |
| `V/view/GoddessEquipStepView.as`, `V/item/GoddessStepItem.as` | "Nv. {0}", "Adição de qualidade {0}", "Limite de fortalecimento de {0}" | advance | equip page | current/next advance row, material list `have/need` (`:73-186`) |
| `V/view/GoddessEquipTip.as` | "(Pode fortalecer até {0})" | slot tooltip | cells | strengthen and advance rows, cap |
| `V/GodDessEquipInfoView.as`, `V/GodDessEquipLookInfoFrame.as` | "Acessório da Deusa" / "Meu Acessório da Deusa" | read only comparison with another player | player info (`decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:1454`), openType `LOOK_UP_GODDESS_EQUIP` | `thane.goddessInfo.equips` |
| `decompiled/core_module/scripts/funny/view/GoddessDoubleForgeActivityView.as` | "Forja Dupla da Deusa" | event page in the activities frame | Funny frame when `doubleOpen` | "{start} - {end}" |
| `decompiled/core_module/scripts/ui/toptoolbar/view/ExtraBufferItem.as:199-204` | "Horário de abrir: {0} \nHorário de fechar: {1}" | top bar buff icon type 40008 | top bar when `doubleOpen` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:2022-2028`) | |

## 3. Routes (client to server)

Both actions use send 5191 (0x1447) `C_GODDESS_OP`, `GoddessRequestMsg` (full field table in `goddess.md` section 3). Fields used here: `op` (#1, INT32), `templateId` (#2, INT32) = owner goddess (`GoddessEquipInfo.ownerId`, set from the goddess `templateId`, `GM:108`), `count` (#3, INT32) = slot `equipType` 1..4.

### A1. Strengthen a slot (op 8)
- UI: "Fortalecer" `_strengBtn` (`V/view/GoddessEquipStrengthView.as:316-322`); "auto" `_autoStrengBtn` repeats the request every 100 ms after each response until the level rises or a check fails (`:324-414`); `_cancelAutoBtn` stops it.
- Client checks, in order (`:416-431`): 
  1. `strengthenLevel < StrengthenLevelMax` of the current advance row (AdvanceType 2, `Grade` = `equipAdvanceLevel`) else "É necessário avançar para seguir fortalecendo".
  2. gold >= `Grade * 10000 + 1000000` where `Grade` = current strengthen level (`:248-257`) else "Ouro insuficiente".
  3. bag count of the hammer >= cost from `AdvanceCost` of the current strengthen row (`"208500,N"`, `:259-277`) else "Itens insuficientes".
  Hidden at `getMaxStrength()` (240).
- Request: `op`=8, `templateId`=owner goddess, `count`=slot.
- Response: push 177 with the goddess row whose `equipInfos` contains the updated slot (`equipStrengthenLevel`, `equipCurBlessing`); the handler fires `EVENT_EQUIP_UPDATA` (`GM:100-119`) which calls `updateView()`; if the level did not rise, auto mode sends the next request (`V/view/GoddessEquipStrengthView.as:380-401`). Also gold update (resource push, owner `../currency/README.md`) and bag update 115.

### A2. Advance a slot (op 10)
- UI: `_eqStepBtn` (`V/view/GoddessEquipStepView.as:207-217`).
- Client checks: every `id,count` pair of `AdvanceCost` (split by `#`) of the current advance row is owned, else "Itens insuficientes". Hidden at `getMaxStep()` (5). No check that the strengthen level reached the cap.
- Request: `op`=10, `templateId`=owner goddess, `count`=slot.
- Response: push 177 with `equipAdvanceLevel` raised; bag update 115.

## 4. Server messages (server to client)

### S1. 177 (0x00b1) `U_C_GODDESSINFO`, `GoddessInfoMsg.equipInfos` (#21, repeated `GoddessEquipInfoMsg`)
Receiver `GM.__godInfosHandler` (`GM:100-119`). Only slots of known types 1..4 are applied (the four objects are pre created by `GoddessInfo.init`, `decompiled/core_module/scripts/mvc/module/goddess/GoddessInfo.as:75-93`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `equipType` | #1 | INT32 | slot 1..4 |
| `equipStrengthenLevel` | #2 | INT32 | 0..240 |
| `equipAdvanceLevel` | #3 | INT32 | 0..5 (name color frame = level + 1) |
| `equipCurBlessing` | #4 | INT32 | blessing points accumulated at the current strengthen level |

Also `GoddessInfoMsg.equiSuitOpenMax` (#20, INT32), unused by the client.

### S2. 4954 (0x135a) `U_GODDESS_EQUIMENT_DOUBLE`, message `com.road.yishi.proto.simple.PropertyMsg`
Receiver `GM.__godDoubleOpenInfoHandler` (`GM:139-151`). Note: `protocol/proto.json` keys messages by name and holds another `PropertyMsg`; the one used here is the `simple` package version, tags read from `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as:365-470`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `param7` | #7 | BOOL | event active (`model.doubleOpen`) |
| `param4` | #4 | STRING | start time text (`doubleOpenString`) |
| `param5` | #5 | STRING | end time text (`doubleEndString`) |

Other tags (`param1..3` INT32 #1..#3, `param6` STRING #6, `param8..9` BOOL #8..#9, `param10..11` INT32 #10..#11, `param12` #12) are unused here. Send at login when an event window is active or scheduled *(assumption)*, at window start and at window end (with `param7` false). The client then notifies `GODDESS_EQUIMENT_DOUBLE` (top bar, activity frame, strengthen view badge).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Strengthen row | `getEquipTempInfo(1, equipType, strengthenLevel)` | `GEC:38-48` |
| Strengthen cost | gold `Grade * 10000 + 1000000`; hammer 208500 x N from `AdvanceCost` (5 at low levels, up to 50; level 240 row is a sentinel `99999,99999`) | `V/view/GoddessEquipStrengthView.as:248-277` |
| Strengthen cap | `StrengthenLevelMax` of advance row: step 0 -> 40, 1 -> 80, 2 -> 120, 3 -> 160, 4 -> 200, 5 -> 240 | `GoddessEquipmentTempInfos.xml` |
| Blessing | `Blessing` = "a,b,c,d", bar max = `b` (350..450). Meaning of `a`, `c`, `d` is not in the client. *(assumption)* `a` = base success chance in per mille, `b` = blessing at which success is guaranteed, `c..d` = random blessing gained on failure; blessing resets to 0 on success | `V/view/GoddessEquipStrengthView.as:179-180` |
| Double forge | while `doubleOpen` the badge "double" shows. *(assumption)* blessing gain (or success chance) is doubled during the window | `GM:139-151` |
| Advance row | `getEquipTempInfo(2, equipType, advanceLevel)`; cost of going from N to N+1 = `AdvanceCost` of row N: step 0 `208511,5`, 1 `208512,5`, 2 `208513,5#208520,20`, 3 `208514,5#208521,20`, 4 `208515,5#208522,20`; row 5 is a sentinel | `V/view/GoddessEquipStepView.as:113-154` |
| Advance success | always succeeds *(assumption: no rate field)* | |
| Slot stat | `base = first value of strengthen row`; `pct = first value of advance row` (50, 100, ... 250); add = `base + floor(base * pct / 100)` | `V/view/GoddessLevelView.as:182-204` |
| Set bonus | for set row of slot index k (`getSuitTempInfo(3, k)`): active when all 4 slots have `equipStrengthenLevel >= Grade` (40, 80, 160, 240); grants `HitValue` and `PenetrationValue` (100000, 200000, 350000, 500000) to the goddess only | `V/view/GoddessEquipView.as:154-211` |
| Stat keys | `getKeyValues` order: HpValue, PhysicalDefenceValue, MagicalDefenceValue, AttackValue, HitValue, PenetrationValue | `GET:65-93` |
| Material source | hammer from "Caverna do Ouro Negro (Avançado)"; hearts compose in the smith (`StoreModel.COMPOSE_TYPE_GODDESS_EQUIP` 17, `decompiled/core_module/scripts/mvc/module/store/StoreModel.as:53`, owner `../smith/README.md`) | item descriptions |

## 6. Templates

| File | Fields used |
|---|---|
| `GoddessEquipmentTempInfos.xml` (992 rows: 4 x 241 strengthen, 4 x 6 advance, 4 set) | `Id`, `AdvanceType`, `EquipType`, `Grade`, `AdvanceCost` (`id,count#id,count`), `StrengthenLevelMax`, `HpValue`, `PhysicalDefenceValue`, `MagicalDefenceValue`, `AttackValue`, `HitValue`, `PenetrationValue`, `Blessing` |
| `ItemTempInfos.xml` | 208500 "Martelo de Luz"; 208511..208515 "Coração da Deusa nv. 1..5"; 208520..208522 "Tomo da Deusa nv. 1..3" |

## 7. Persistent state

```sql
CREATE TABLE goddess.accessories (
  player_id         BIGINT   NOT NULL,
  template_id       SMALLINT NOT NULL,
  equip_type        SMALLINT NOT NULL CHECK (equip_type BETWEEN 1 AND 4),
  strengthen_level  SMALLINT NOT NULL DEFAULT 0 CHECK (strengthen_level BETWEEN 0 AND 240),
  advance_level     SMALLINT NOT NULL DEFAULT 0 CHECK (advance_level BETWEEN 0 AND 5),
  blessing          INTEGER  NOT NULL DEFAULT 0 CHECK (blessing >= 0),
  PRIMARY KEY (player_id, template_id, equip_type),
  FOREIGN KEY (player_id, template_id) REFERENCES goddess.goddesses(player_id, template_id) ON DELETE CASCADE
);

CREATE TABLE goddess.double_forge_windows (
  window_id  BIGSERIAL PRIMARY KEY,
  starts_at  TIMESTAMPTZ NOT NULL,
  ends_at    TIMESTAMPTZ NOT NULL,
  CHECK (ends_at > starts_at)
);
CREATE INDEX double_forge_windows_time ON goddess.double_forge_windows (starts_at, ends_at);
```

Create the four accessory rows when the goddess is activated (op 1 in `goddess.md`).

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 8 | `goddess::equipment::handle_strengthen` |
| 10 | `goddess::equipment::handle_advance` |

- Strengthen validation order: goddess active -> slot 1..4 -> level < 240 -> level < cap of advance row -> gold -> hammers. Transaction: consume gold and hammers, roll success using blessing (section 5 assumption), update `strengthen_level` / `blessing`, commit. Push gold update, 115, then 177 with the goddess row (stats recomputed, equipInfos with at least the changed slot). The auto mode on the client depends on getting 177 after every attempt, even on failure.
- Advance validation: goddess active -> slot -> level < 5 -> all materials; transaction consume + `advance_level + 1`; push 115 and 177.
- Recompute goddess stats (section 5 of `goddess.md`) and hero power after each change.
- Scheduler: at `starts_at` and `ends_at` of each `double_forge_windows` row broadcast 4954 to all online players; on login send the current state.

## 9. Open questions and assumptions

- *(assumption)* Meaning of `Blessing` fields `a`, `c`, `d` and the success roll.
- *(assumption)* Effect of "Forja Dupla" (double blessing or double chance).
- *(assumption)* Advance does not require the strengthen cap to be reached (client does not check).
- Set bonus applies to the goddess only ("Apenas para Deusa"); how Hit/Penetration enter goddess battle stats must follow the battle engine (`docs/battle/server-engine.md`).

## 10. Implementation checklist

- [ ] Route 5191 op 8 strengthen with cap, gold, hammer checks and blessing roll.
- [ ] Route 5191 op 10 advance with multi item cost.
- [ ] 177 `equipInfos` on every change, also on failed strengthen.
- [ ] 4954 double forge push at login and window edges.
- [ ] Tables `goddess.accessories`, `goddess.double_forge_windows`.
- [ ] Slot stat and set bonus formulas in goddess stat computation.
- [ ] Look up: `DetailRspMsg.goddessInfo.equipInfos` (4125).
- [ ] Tests: cap blocks at 40 until advance; cost formula at level 0 is 1000000 gold and 5 hammers; set bonus active only when all 4 slots >= 40; auto strengthen loop ends on level up.
