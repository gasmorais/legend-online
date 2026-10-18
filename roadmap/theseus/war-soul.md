# Theseus: Espírito da Guerra (war souls: bag, equip, fight, hatch)

Module `war-soul`. Fourth tab of "Alma de Teseu", unlocked by quest 1389: collect war souls by hatching eggs, keep them in a bag split by type, equip one per element slot, choose the primary ("Primário") group that gives active and passive skills in battle, split stacks and lock them. Upgrades (stars, strengthen, reform, refine, skills, decompose) are in [war-soul-training.md](war-soul-training.md).

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| WSM | `decompiled/core_module/scripts/mvc/module/theseus/WarSoulModel.as` |
| WSI | `decompiled/core_module/scripts/mvc/module/theseus/TheseusWarsoulItemInfo.as` |
| W | `decompiled/m5/scripts/theseus/war` |
| T | `decompiled/m5/scripts/theseus` |
| CM | `decompiled/core_module/scripts` |

---

## 1. Overview

- Help text (`theseus.war.helpTip`): nine elements (água, fogo, vento, choque, luz, escuridão, marinha, celeste, terra) in three types Natural, Polar, Espectral; three positions Inferior (água, fogo, vento), Intermediário (choque, luz, escuridão), Superior (marinha, celeste, terra); growth by stars, strengthen and reform; type advantage Natural > Polar > Espectral > Natural; primary and secondary souls give different attribute bonuses; bag full blocks collecting.
- Template `WarSoulTmpls.xml` (54 rows): `WarSoulId` = element x 10 + quality (11..16 water ... 91..96), `SonType` element 1..9 (= equip slot), `MainType` 1 Natural / 2 Polar / 3 Espectral, `Profile` quality 1..6 (white..red), `MaxStar` 5/10/11/13/16/20, `Rank` position 1 Superior / 2 Intermediário / 3 Inferior.
- Equip slots: one per element (`SonType` 1..9), grouped in rows by `MainType` (Natural: 1 Água, 4 Choque, 7 Marinha; Polar: 2 Fogo, 5 Luz, 8 Terra; Espectral: 3 Vento, 6 Escuridão, 9 Celeste) (`W/item/TheseusWarEquipHItem.as:69-79`). Slot `s` opens when `RoyaltyTemplate.OpenWarSoul >= s`: 3 slots at royalty 10, 6 at 15, 9 at 20.
- Fight group ("Primário", `fightIdx` 1..3, 0 = none): the selected `MainType` row gives attributes + active skill + passive skills; the other rows give attributes only (`theseus.war.fightTip`).
- War souls stack: identical unmodified souls share one entry with `count` (`WSM:149-165`).
- Bag: per `MainType` 63 entries (7x9) (`W/view/TheseusWarEquipBagView.as:49`, `W/item/TheseusWarFuhuCell.as:259`).
- Hatching: 3 hatch slots; an egg item (SonType 760 "Alma da Guerra da Água·Branco" ... "Alma da Guerra Celeste·Vermelho") hatches in `Property2` minutes (60) into a war soul.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `T/view/TheseusWarPageView.as` | tab 4 of "Alma de Teseu" | Equip panel + bag | Main frame tab 4 | refreshes on `EVENT_WAR_EQUIP` ops 9, 10, 19 (`:43-59`) |
| `W/view/TheseusWarEquipPageView.as` | "Espírito" (`theseus.war.equipTitle`) | 3 rows `TheseusWarEquipHItem`, upgrade button, help "Instruções" | tab 4 | upgrade button opens openType 5 with `backTheseFrame` (`:103-107`) |
| `W/item/TheseusWarEquipHItem.as` | labels "Inferior", "Interm.", "Superior" (`ui.theseussoul.posDown/Mid/Up`) | One `MainType` row: 3 `TheseusWarEquipCell` + fight checkbox | equip panel | checkbox checked when `fightIdx == mainType` (`:81-88`) |
| `W/item/TheseusWarEquipCell.as` | slot name "Água".."Celeste" (`theseus.war.equipCellN`) | Equip slot; locked icon with tip "Abre com Realeza Nv. {0}" from config `warsoul_open_tips` (`:144-150`); vice password lock icon | row | icon, quality frame, stars (`:206-236`) |
| `W/view/TheseusWarEquipBagView.as` + `W/view/TheseusWarsoulBagView.as` | 3 page buttons (Natural, Polar, Espectral) | Bag of one `MainType`, unequipped only (`WSM:114-133`) | tab 4 | cells `TheseusInsfBagCell` (icon, quality, stars, count) |
| `W/view/TheseusWarFhuaFrame.as` | "Eclosão do Espírito" (`theseus.war.fuhuaTitle`) | 3 `TheseusWarFuhuCell` hatch slots | **no caller in this build** (only defined in `raw/ui/zh_cn/xml/decoded/theseuswarsoul.xml:1277`) | slot state 0 empty / 1 "Completado" / 2 "Eclodindo..." with countdown (`W/item/TheseusWarFuhuCell.as:84-207`) |
| `T/TheseuswarFuhuCFrame.as` + `W/view/TheseusWarFuHuaView.as` | "Eclosão do Espírito" | Choose an egg and start hatching in slot `idx` | empty hatch slot button, controller openType 4 with the slot index (`W/item/TheseusWarFuhuCell.as:243-246`) | egg picker `TheseusWarHufaChooseView` (bags 1/34, SonType 760), result name, "Tempo estimado: {0}" (`theseus.war.fuhuaNeedTime`), "(Qualidade: Branco-Vermelho)", VIP hints (privilege types 23/24) |
| Tooltip `decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as` | | War soul tooltip | hover | type, position, reform name, stars, max strengthen "MaxGrade", attributes, learned skill, refine skills, war intent bonuses, active/passive skills (`:298-500`) |
| Battle `CM/battle/view/ui/SkillWarsoulView.as` | | Fury bar and war soul skill buttons | battle HUD | see [../battle/README.md](../battle/README.md) |

## 3. Routes (client to server)

War soul requests use `TheseussoulManager.doWarsoulParam(op, index=-1, id=0, type=-1, ids=null)` (`MGR:995-1008`), opcode 8680 (0x21e8) `C_THESEUS_CLIENT_OP`, `player.PlayerOpMsg` fields `op` (#1, INT32), `index` (#6, INT32), `id` (#5, INT32), `type` (#2, INT32), `ids` (#20, INT32, repeated, unpacked).

### R1. Equip a war soul

- UI A: double click a bag cell (`W/mediator/TheseusInsfBagCellClickMediator.as:57-79`); check `RoyaltyTemplate.OpenWarSoul >= warTempInfo.SonType`, else "Condições não atendidas" (`theseus.war.noDoEquip`).
- UI B: drag a bag cell onto an unlocked equip cell (`W/mediator/TheseusInsfBagCellDropMediator.as:96-110`); check `SonType == cell.sonType`, else tip key `theseus.war.doEquip` (missing in `index/language.json`).
- Request: `op` 10, `index` -1, `id` = war soul uid, `type` 0 (equip).
- Response: 4307 op 10 with the equipped soul (`isEquip` true), the soul previously in that slot (`isEquip` false) and the source stack if one unit was taken; 4300; 4299 is not needed (bonus levels are computed client side from `reformBuff`).

### R2. Unequip a war soul

- UI: double click an equip cell (`W/mediator/TheseusWarEquipCellClickMediator.as:51-58`) or drag it onto a bag cell (`W/mediator/TheseusWarEquipCellDropMediator.as:112-124`).
- Client checks: none (no bag full check).
- Request: `op` 10, `index` -1, `id` = uid, `type` 1 (unequip).
- Response: 4307 op 10 (`isEquip` false), 4300.

### R3. Select the primary group ("Primário")

- UI: checkbox of a row (`W/item/TheseusWarEquipHItem.as:112-137`).
- Client checks: the row must have at least one equipped soul, else "O tipo selecionado não está equipado com Espírito da Guerra" (`theseus.war.doNofightTip`).
- Request: `op` 19, `index` = mainType 1..3 to select, or 0 when unchecking the selected row; `id` 0; `type` -1.
- Response: 4307 op 19 with `fightIdx` (may carry no war souls), 4300.

### R4. Split a stack ("Dividir")

- UI: "Dividir" button of the upgrade frame, then click a bag cell (`W/utils/TheseusWarBitPool.as:58-81`, button `T/TheseuswarIntensifyFrame.as:197-201`).
- Client checks: target is a `TheseusInsfBagCell` with `num > 1`.
- Request: `op` 21, `index` -1, `id` = uid, `type` -1.
- Response: 4307 op 21 with the reduced stack and a new entry of count 1 *(assumption: one unit split off; no amount is sent)*.

### R5. Put an egg into the hatcher

- UI: egg cell of `TheseusWarFuHuaView` (`W/view/TheseusWarFuHuaView.as:167-183`) opens the picker; picking moves the egg (`W/TheseusWarHufaChooseView.as:99-108`).
- Client checks: at least one SonType 760 item in bags 1/34, else "No momento não há materiais" (`theseus.war.chooseNo`).
- Route: 5005 (0x138d) `U_C_BAG_MOVE`, `item.ItemReqMsg`: `begin_bag_type` (#1) item bag, `begin_obj_id` (#2), `begin_pos` (#3), `end_bag_type` (#4) 0 (hidden work bag), `end_obj_id` (#5) 0, `end_pos` (#6) 0, `count` (#7) 1.
- Response: 115 `U_C_BAG_MOVE_UPDATE`; the view reads bag 0 pos 0 (`W/view/TheseusWarFuHuaView.as:123-165`). Closing the view moves every bag 0 item back to bag 1 (`:185-192`, 5005 with `end_bag_type` 1).

### R6. Start hatching

- UI: confirm button `fuhuBtn2` (`T/TheseuswarFuhuCFrame.as:52-56`), enabled after an egg is in bag 0 pos 0.
- Request: `op` 7, `index` = hatch slot 1..3, `id` 0, `type` -1.
- Response: inventory update (egg consumed from bag 0), 4309 op 7 with the slot (`useItem` = egg template, start and stop dates).

### R7. Speed up hatching

- UI: speed button of a running slot (`W/item/TheseusWarFuhuCell.as:272-303`).
- Client checks: config `warsoul_hatch_fast` "60,100" = (minutes, diamonds); diamonds `point >= 100` else recharge alert; confirm "Consumir {0} diamantes para acelerar a Eclosão em {1}?" (`theseus.war.fuhuaSpeed`).
- Request: `op` 8, `index` = slot.
- Response: currency update; 4309 op 8 with the new `stopDate` (60 minutes earlier, not before now).

### R8. Collect a hatched war soul

- UI: collect button of a completed slot (`W/item/TheseusWarFuhuCell.as:248-270`).
- Client checks: `getListByMainType(resultMainType).length < 63`, else "Mochila Natural Cheia" / "Mochila Polar Cheia" / "Mochila Espectral Cheia" (`theseus.war.mainTypeBag1..3`).
- Request: `op` 9, `index` = slot.
- Response: 4309 op 9 with the slot (client deletes it, `MGR:795-798`) and 4307 op 9 with the new war soul (or the increased stack).

### R9. Lock

- Vice password 8809 op_type 9, `pet_id` = uid ([soul.md](soul.md) R2).

### R10. Battle use (other feature)

- Active skill of the primary group: 10522 (0x291a) `B_USE_WARSOUL_SKILL`, `battle.UseSkillMsg` `battle_id` (#1, STRING), `hero_id` (#2, INT32), `skill_id` (#3, INT32) (`CM/yishi/service/managers/SocketSendManager.as:218-225`, caller `CM/battle/view/ui/SkillWarsoulView.as:359-364`). Fury push 4311 `U_C_WARSOUL_SP`, `battle.AwakeMsg` (`CM/battle/transaction/BattleWarsoulSpTransaction.as:21-65`). Specified in [../battle/README.md](../battle/README.md) and `docs/battle/rules.md`.

## 4. Server messages (server to client)

### S1. 4306 (0x10d2) `U_C_WARSOUL_LIST` and 4307 (0x10d3) `U_C_WARSOUL_UPDATE`

- Message `theseus.WarSoulListMsg`:
  - `op` (#1, INT32): echo of the request op (0 for snapshot or unsolicited pushes).
  - `warSouls` (#2, `WarSoulMsg`, repeated).
  - `fightIdx` (#3, INT32): primary group 0..3. **Always send it**: the handler overwrites `fightIdx` on every message (`MGR:753`).
- `theseus.WarSoulMsg`:
  - `id` (#1, INT32): war soul uid.
  - `warSoulId` (#2, INT32): template id.
  - `star` (#3, INT32), `strengthen` (#4, INT32), `reform` (#5, INT32).
  - `learnSkill` (#6, INT32): learned trigger skill id, 0 none.
  - `ramdomSkills` (#7, STRING): CSV of 5 refine skill ids ("0" for empty or locked rows).
  - `reformBuff` (#8, STRING): "pos,level|pos,level|..." war intent bonuses.
  - `isEquip` (#9, BOOL), `isExist` (#10, BOOL; false deletes, `MGR:756-759`).
  - `count` (#11, INT32): stack size.
  - `newLearnSkill` (#12, INT32): pending skill waiting for replace.
  - `isLock` (#13, BOOL).
- Receiver: `MGR.__warsoulInfosHandler` (`MGR:746-784`): upsert or delete by `id`, dispatch `EVENT_WAR_EQUIP` with `op`. Consumers per op: equip panel and bag (10, 9, 19), upgrade pages (11, 12, 13, 14, 17, 20, any for 18), bag views.
- When: 4306 on the open snapshot; 4307 after every war soul request and on unsolicited gains *(assumption: both opcodes are interchangeable for the client)*. Also embedded in `DetailRspMsg.warSoulInfo` (#27) for inspection.

### S2. 4308 (0x10d4) `U_C_WARSOUL_HATCH_LIST` and 4309 (0x10d5) `U_C_WARSOUL_HATCH_UPDATE`

- Message `theseus.WarSoulHatchListMsg`: `op` (#1, INT32), `hatchs` (#2, `WarSoulHatchMsg`, repeated).
- `theseus.WarSoulHatchMsg`: `hatchNum` (#1, INT32) slot 1..3; `useItem` (#2, INT32) egg template id; `startDate` (#3, STRING) and `stopDate` (#4, STRING), format "YYYY-MM-DD hh:mm:ss" server time (`CM/mvc/module/theseus/TheseusWarsoulHatchInfo.as:35-53`).
- Receiver: `MGR.__hatchInfosHandler` (`MGR:786-814`): op 9 deletes the listed slots, other ops upsert; dispatch `EVENT_WAR_EGG` (consumer `W/view/TheseusWarFhuaFrame.as:72-75`).
- When: 4308 snapshot on open (only running/finished slots); 4309 after R6, R7, R8.

### S3. Errors

- No result field. Failures: nothing sent *(assumption)*.

## 5. Rules and formulas

- Tab unlock: quest 1389 finished and `VersionSwitch.WARSOUL` ([soul.md](soul.md) §3).
- Slot unlock: `OpenWarSoul >= sonType` (`W/item/TheseusWarEquipCell.as:66-72`); config `warsoul_open_tips` "10,10,10,15,15,15,20,20,20" is tip text only.
- One soul per slot; slot = `WarSoulTmpl.SonType`.
- Fight: `fightIdx` must be 0 or a `MainType` with at least one equipped soul; unequipping the last soul of the primary row should reset `fightIdx` to 0 *(assumption)*.
- Attributes of one soul (`decompiled/m16/scripts/yishi/view/tips/TheseusWarsoulEquipTip.as:225-256, 322-350`), for attr in Attack, Defence, MagicAttack, MagicDefence, Live:
  - base = `WarSoulTmpl.attr * WarSoulStarTmpl(warSoulId, star).attr / 100`;
  - strengthen = `WarSoulStrengthenTmpl(warSoulId, strengthen).attr * star.attr / 100` when strengthen > 0;
  - reform = `WarSoulReformTmpl(warSoulId, reform).attr` when reform > 0.
  - Primary row souls also grant `OpenActiveSkill` and `OpenPassiveSkill` of their strengthen row; secondary souls only attributes (`theseus.war.fightTip`). The exact primary/secondary attribute ratio is not in the client *(assumption: full attributes for both)*.
- Battle: fury +20 per round (config `warsoul_add_sp` 20), maximum 100 (`CM/yishi/datas/objects/HeroRoleInfo.as:103, 248-253`); at 100 the primary soul's active skill can be used (`theseus.war.skUpTip` item 5). Type advantage modifies skill effects *(server side, values not in client)*.
- Stack identity: same `warSoulId`, `star`, strengthen 0, reform 0, no skills (`WSM:149-165`); a stack is never equipped.
- Hatching:
  - 3 slots, no unlock condition visible;
  - egg must be in bag 0 pos 0; duration = egg `Property2` minutes (60) minus VIP privilege type 23 `para1`; zero when VIP privilege type 24 `para1 >= egg Profile` (`W/view/TheseusWarFuHuaView.as:144-162`). Types 23 and 24 do not exist in `VipPrerogativeTempInfos.xml`, so duration is always 60 minutes in this data;
  - result template: element = egg `Property7` (1..9), quality = egg `Profile` (1..6), so `warSoulId = Property7 * 10 + Profile`, star 0 *(assumption; the UI only shows the first template of the element, `:137-142`)*;
  - speed up: 100 diamonds per 60 minutes, repeatable;
  - collect allowed when `now >= stopDate` and the target `MainType` bag has < 63 entries.
- Split: stack `count > 1`.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/WarSoulTmpls.xml` (54) | war soul | `WarSoulId`, `Name`, `Icon`, `Profile`, `MainType`, `SonType`, `MaxStar`, `ClearSkill`, `ClearItem`, `Decompose`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `Live`, `Rank` |
| `WarSoulStarTmpls.xml`, `WarSoulStrengthenTmpls.xml`, `WarSoulReformTmpls.xml` | growth rows | see [war-soul-training.md](war-soul-training.md) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | eggs SonType 760 (54), fragments 761 (54) | egg `Property1` own id, `Property2` hatch minutes, `Property7` element, `Profile` quality |
| `raw/xml/tempinfos/RoyaltyTemplates.xml` | `OpenWarSoul` 0/3/6/9 | slot unlock |
| `raw/xml/tempinfos/ConfigInfos.xml` | `warsoul_hatch_fast` "60,100", `warsoul_open_tips`, `warsoul_add_sp` 20 | |
| `raw/xml/tempinfos/VipPrerogativeTempInfos.xml` | privilege types 23, 24 | absent |

## 7. Persistent state

```sql
CREATE TABLE theseus.war_souls (
    war_soul_uid          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id             bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    war_soul_template_id  integer  NOT NULL,
    element               smallint NOT NULL CHECK (element BETWEEN 1 AND 9),     -- template SonType, equip slot
    main_type             smallint NOT NULL CHECK (main_type BETWEEN 1 AND 3),   -- template MainType, bag page
    star                  smallint NOT NULL DEFAULT 0 CHECK (star BETWEEN 0 AND 20),
    strengthen_level      smallint NOT NULL DEFAULT 0 CHECK (strengthen_level BETWEEN 0 AND 300),
    reform_level          smallint NOT NULL DEFAULT 0 CHECK (reform_level BETWEEN 0 AND 6),
    learned_skill_id      integer  NOT NULL DEFAULT 0,
    pending_skill_id      integer  NOT NULL DEFAULT 0,
    refine_skill_ids      integer[] NOT NULL DEFAULT '{0,0,0,0,0}' CHECK (cardinality(refine_skill_ids) = 5),
    quantity              integer  NOT NULL DEFAULT 1 CHECK (quantity > 0),
    is_equipped           boolean  NOT NULL DEFAULT false,
    is_locked             boolean  NOT NULL DEFAULT false,
    created_at            timestamptz NOT NULL DEFAULT now(),
    CHECK (NOT is_equipped OR quantity = 1)
);
CREATE UNIQUE INDEX war_souls_slot_uq ON theseus.war_souls (player_id, element) WHERE is_equipped;
CREATE INDEX war_souls_bag_idx ON theseus.war_souls (player_id, main_type) WHERE NOT is_equipped;

CREATE TABLE theseus.war_soul_reform_buffs (
    war_soul_uid      integer  NOT NULL REFERENCES theseus.war_souls(war_soul_uid) ON DELETE CASCADE,
    ordinal           smallint NOT NULL CHECK (ordinal BETWEEN 0 AND 11),
    war_intent_pos    smallint NOT NULL CHECK (war_intent_pos BETWEEN 1 AND 12),
    bonus_level       smallint NOT NULL CHECK (bonus_level BETWEEN 1 AND 45),
    PRIMARY KEY (war_soul_uid, ordinal)
);

CREATE TABLE theseus.war_soul_hatcheries (
    player_id        bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    hatch_num        smallint NOT NULL CHECK (hatch_num BETWEEN 1 AND 3),
    egg_template_id  integer  NOT NULL,
    started_at       timestamptz NOT NULL,
    finishes_at      timestamptz NOT NULL,
    PRIMARY KEY (player_id, hatch_num)
);
```

- `fightIdx`: `theseus.player_progress.war_soul_fight_main_type` ([soul.md](soul.md) §7).
- Bag capacity (63 per `main_type`) is counted as rows (stacks), matching the client.

## 8. Backend implementation notes

- `theseus::war_soul::handle_equip` (8680 op 10, `type` 0/1):
  - equip: owned, exists, not equipped; `OpenWarSoul(royalty) >= element`; transaction: split one unit from a stack, unequip the current soul of that element, set `is_equipped`; push 4307 op 10 (+ `fightIdx`), 4300.
  - unequip: equipped and owned; bag of `main_type` < 63 rows; merge into an identical stack when possible; if it was the last soul of the primary row set `fightIdx` 0 *(assumption)*; push 4307 op 10, 4300.
- `theseus::war_soul::handle_fight_select` (op 19): `index` 0..3; when > 0 the row must have an equipped soul; update `player_progress`; push 4307 op 19 with `fightIdx` and empty list; 4300.
- `theseus::war_soul::handle_split` (op 21): `quantity > 1`, bag room; decrement and insert a copy with quantity 1; push 4307 op 21.
- `theseus::war_soul::handle_hatch_start` (op 7): slot 1..3 empty; bag 0 pos 0 holds a SonType 760 egg owned by the player; consume 1; `finishes_at = now + Property2 minutes` (minus VIP reduction when privileges exist); push inventory update and 4309 op 7.
- `theseus::war_soul::handle_hatch_speed_up` (op 8): slot running; diamonds >= config value; `finishes_at = max(now, finishes_at - 60 min)`; push currency and 4309 op 8.
- `theseus::war_soul::handle_hatch_collect` (op 9): slot finished (`now >= finishes_at`); bag of the result `main_type` < 63; delete the slot row; create the soul (stack if identical); push 4309 op 9 and 4307 op 9.
- No server timer is needed for hatching (completion is checked on collect); the client counts down locally.
- Battle: when a battle starts the server must load the equipped souls, the primary row skills (`OpenActiveSkill`, `OpenPassiveSkill` of each soul's strengthen row), learned and refine skills, and run the fury counter (+20 per round, cap 100, push 4311); see `docs/battle/server-engine.md`.
- `theseus::war_soul::set_lock` (8809 op_type 9): toggle `is_locked` (only on single units) and push 4307.

## 9. Open questions and assumptions

1. `TheseusWarFhuaFrame` (hatch slot list) is never opened in this build, so the hatch flow is unreachable from the UI unless another caller exists in server-driven UI; implement the routes anyway.
2. Result template of a hatched egg (element and quality mapping) is assumed from item properties.
3. 4306 vs 4307 and 4308 vs 4309 are handled by the same functions; the split snapshot/update is assumed.
4. Primary vs secondary attribute ratio and type advantage numbers are not in the client.
5. Tip key `theseus.war.doEquip` is missing from the language file.
6. `fightIdx` reset when the primary row becomes empty is assumed.

## 10. Implementation checklist

- [ ] Screens: war tab equip rows with slot locks, bag pages by type, hatch frame and egg picker.
- [ ] Route 8680 op 10 equip/unequip.
- [ ] Route 8680 op 19 fight group.
- [ ] Route 8680 op 21 split.
- [ ] Route 5005 to bag 0 for eggs (inventory hook) and back.
- [ ] Routes 8680 ops 7, 8, 9 hatching.
- [ ] Lock hook 8809 op_type 9.
- [ ] Server messages 4306/4307 (always with `fightIdx`) and 4308/4309.
- [ ] Tables `theseus.war_souls`, `theseus.war_soul_reform_buffs`, `theseus.war_soul_hatcheries`.
- [ ] Battle integration: skills of the primary row, fury 4311, skill use 10522.
- [ ] Test: equipping a Celeste soul (slot 9) at royalty 15 is rejected.
- [ ] Test: collecting with a full Natural bag (63 stacks) is rejected.
- [ ] Test: speed up twice on a 60 minute hatch makes it collectable immediately.
