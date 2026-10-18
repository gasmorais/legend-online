# Theseus: Tesouro / "Selo Regenerador" (treasure slots and core)

Module `treasure`. Third tab of "Alma de Teseu": a magic circle with 9 outer treasure slots, 3 inner treasure slots and a central core. Treasures are normal inventory items moved between the treasure storage bag (38) and the equipped treasure bag (39); the core has a level strengthened with 8680 op 5. Treasure strengthen, decompose and refine happen in the smith ([../smith/README.md](../smith/README.md)).

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/theseus/TheseussoulModel.as` |
| TV | `decompiled/m5/scripts/theseus/view` |
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| CM | `decompiled/core_module/scripts` |

---

## 1. Overview

- Title "Selo Regenerador" (`TreasurePageView.titleTxt`), description "O selo adormecido despertou chamando pelo poder perdido há milhares de anos..." (`TreasurePageView.descTxt`). Help "Sobre o Tesouro": "1. Desbloqueie mais slots do tesouro aumentando o Nível de Realeza. 2. Quanto mais alto for o nível de realeza, maior será a capacidade adquirida. 3. Os tesouros podem ser fortalecidos no Ferreiro..." (`TreasurePageView.helperFrame.helpTxt.text`).
- Slots (`TV/TreasurePageView.as:38-46, 164-203`):

| Index | Kind | Item filter | Class |
|---|---|---|---|
| 0..8 | Tesouro Externo ("Externo") | MasterType 11, SonType 750 | `TreasureOuterItem` (`type` 750) |
| 9..11 | Tesouro Interno ("Interno") | MasterType 11, SonType 751 | `TreasureInnerItem` (`type` 751) |
| 12 | Núcleo (core) | not an item; `coreLevel` | `TreasureCoreItem` (`type` 0) |

- Equipped treasures are items in bag 39 at `pos` = slot index; stored treasures are in bag 38 (`GM:2128-2140, 2193-2219`).
- Slot lock state comes from `TheseusUserMsg.hokeInfo` (CSV of 12 flags) and `coreLevel` (0 = core locked) ([soul.md](soul.md) S1).
- The core ("Misericórdia de Aegeus" in `TheseusTreasureCoreTemplates`) has levels 1..150, 1..6 stars (`Profile`), up to 3 core skills, and a cap set by the royalty level.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `TV/TreasurePageView.as` | "Selo Regenerador" | 13 slot buttons on a circle, detail panel of the selected slot | Main frame tab 3 | Locked overlay text "Não se sabe quantos anos se passaram..." (`TreasurePageView.lockTxt.text`) when the slot is locked (`:328-339`). Treasure: name, "Nv. strengthenGrade", "Atributos básicos:" from the growup row, "Bônus de fundição:" from `randomSkill1..5` (`:376-412, 473-502`), buttons replace / remove; empty slot: equip button, title, description. Core: description, level, stars `Profile`, attributes, 3 skill icons, "Fort. do Núcleo" button (`:346-374`). Link "Ver Atributos Gerais" when any treasure total > 0 (`:345`) |
| `TV/TreasureBagView.as` | "Tesouro" (`TreasureBagView.titleText.text`) | Choose a stored treasure of the slot kind and equip it | equip or replace button (`TV/TreasurePageView.as:291-300`) | bag 38 items with `SonType == kind`, at least 25 cells (`:127-163`) |
| `TV/TreasureCoreFrame.as` | "Fort. do Núcleo" (`TreasureCoreFrame.titleText.text`) | Strengthen the core | "Fort. do Núcleo" button (`TV/TreasurePageView.as:257-261`) | icon, level, stars, material 1 `StrengthenItem` "owned / need", material 2 `BreachItem` when the row has one (button label switches to break), 3 core skills (`:184-284`) |
| `TV/TreasureTotalFrame.as` | "Ver Atributos Gerais" (`TreasurePageView.allTxt.text`) | Totals of all treasures | link (`TV/TreasurePageView.as:251-255`) | `MOD.treasurePros.attNames/attValues` (17 labels `TheseusTreasureGrowupInfo.typeText01..17`), core skills (`:100-131`) |
| `TV/TreasureSkillItem.as` | tip "Alcance o nível {0} para desbloquear esta habilidade" | Core skill icon or lock | core frame, page, total frame | `getSkillGrade(index)` (`:42-60`) |
| `TV/TreasurePageViewLook.as`, `TV/TreasureOuterItemLook.as` | | Inspection of another player | [soul.md](soul.md) R3 | items with `bagType == 39` from the detail response (`TreasureOuterItemLook.as:133-141`) |

## 3. Routes (client to server)

### R1. Equip or replace a treasure

- UI: select a slot, button equip (empty) or replace (filled) opens `TreasureBagView(kind, slotIndex)`; select a cell; button equip (`TV/TreasureBagView.as:94-119`).
- Client checks: inner treasures (751) refuse a second treasure with the same `Property4` in another inner slot: "Não é possível equipar tesouro de tipo duplicado" (`TreasureBagView.equipClick.text`, `:103-113`). Locked slots show the overlay and no buttons (`TV/TreasurePageView.as:331-332`).
- Sender: `PlayerManager.moveBagToBag(38, objectId, pos, 39, 0, slotIndex, 1)` (`TV/TreasureBagView.as:115`, `CM/yishi/manager/PlayerManager.as:1602-1606`).
- Route: client to server, 5005 (0x138d) `U_C_BAG_MOVE`, `item.ItemReqMsg` (`CM/yishi/service/managers/SocketSendManager.as:139-155`):
  - `begin_bag_type` (#1, INT32): 38.
  - `begin_obj_id` (#2, INT32): item `objectId`.
  - `begin_pos` (#3, INT32): item position in bag 38.
  - `end_bag_type` (#4, INT32): 39.
  - `end_obj_id` (#5, INT32): 0.
  - `end_pos` (#6, INT32): slot index 0..11.
  - `count` (#7, INT32): 1.
  - `object_id` (#8, INT32): not set.
- Response: 115 (0x0073) `U_C_BAG_MOVE_UPDATE` (inventory, the page refreshes on it, `TV/TreasurePageView.as:207, 220-224`), the replaced treasure goes back to bag 38; then 4302 treasure totals and 4300 Theseus totals *(assumption)*.

### R2. Remove a treasure

- UI: remove button (`TV/TreasurePageView.as:302-305`).
- Sender: `moveBagToBag(39, 0, slotPos, 38, 0, 0, 1)`: route 5005 with `begin_bag_type` 39, `begin_obj_id` 0, `begin_pos` slot, `end_bag_type` 38, `end_obj_id` 0, `end_pos` 0, `count` 1.
- Client checks: none (no bag 38 capacity check).
- Response: 115, 4302, 4300 *(assumption: server places the item in the first free bag 38 position because `end_pos` is 0)*.

### R3. Strengthen the core

- UI: "Fort. do Núcleo" frame, grow or break button (`TV/TreasureCoreFrame.as:145-172`).
- Client checks, in order:
  1. `coreInfo.Level >= RoyaltyTemplate(royaltyLevel).OpenCoreTreasureHoke`: blocked;
  2. `coreInfo.SecretLevel > SecretAdventerManager.model.frameInfo.passMapId`: blocked;
  3. when blocked: "O limite do nível de fortalecimento foi atingido. O limite do nível pode ser aumentado aumentando o Nível de Realeza" if a next row exists, else "Atingiu o limite máximo do nível de fortalecimento!" (`TreasureCoreFrame.isGrowup.text`, `.text2`);
  4. button enabled only when `StrengthenItem` owned `>= StrengthenItemNum` and, if the row has a `BreachItem`, `BreachItem` owned `>= BreachItemNum` (`:226-238`), counting bags 1 and 34 (`GM:518-529, 2084-2092`).
- Sender: `TheseussoulManager.doSomething(5)` (`MGR:969-978`).
- Route: client to server, 8680 (0x21e8) `C_THESEUS_CLIENT_OP`, `player.PlayerOpMsg`: `op` (#1) 5 (`OP_CORE_STRENGTHEN`), `index` (#6) 0, `templateId` (#8) 0, `pos` (#19) 0.
- Response, in order: inventory updates for consumed stones; 4298 with the new `coreLevel` ([soul.md](soul.md) S1, triggers `EVENT_SUIT_UPDATE`, the frame refreshes `:140-143`); 4302; 4300.

### R4. Lock a treasure

- Vice password 8809 op_type 8 (bag 38 cell) or 13 (equipped slot) ([soul.md](soul.md) R2).

## 4. Server messages (server to client)

### S1. 4302 (0x10ce) `U_C_THESEUS_TREASURE_PROPERTY`

- Message `theseus.TheseusPropertyMsg` (same type as 4300): `power` (#1), `agility` (#2), `intellect` (#3), `captain` (#4), `physique` (#5), `attack` (#6), `defence` (#7), `magicAttack` (#8), `magicDefence` (#9), `forceHit` (#10), `parry` (#11), `live` (#12), `conat` (#13), `reduceResi` (#14), `fireResi` (#15), `waterResi` (#16), `electResi` (#17), `windResi` (#18), `darkResi` (#19), `lightResi` (#20), `strength` (#21), `tenacity` (#22), `penetrate` (#23), `stunAttr` (#24), `reduceResiAgainst` (#25), `resiPenetrate` (#26), all INT32 totals of the treasure system; `armour` (#27) ignored.
- Receiver: `MGR.__treasurePropertyInfosHandler` (`MGR:890-922`) fills `MOD.treasurePros` and dispatches `EVENT_SUIT_UPDATE`. The link "Ver Atributos Gerais" shows when any field > 0 (`CM/mvc/module/theseus/TreasurePropertys.as:69-72`).
- When: snapshot on open; after R1, R2, R3 and after smith treasure strengthen or refine of an equipped treasure *(assumption)*.

### S2. Other

- 115 `U_C_BAG_MOVE_UPDATE` and `UPDATE_BAG`/`DELETE_BAG` client events for bags 39 and 34 refresh the page (`TV/TreasurePageView.as:263-289`). Owned by [../inventory/README.md](../inventory/README.md).
- 4298 for `coreLevel` and `hokeInfo`.

## 5. Rules and formulas

- Outer slot unlock: number of open outer slots = `RoyaltyTemplate.OpenOutsideTreasureHoke` (3 at royalty 6, 5 at 8, 7 at 11, 9 at 15). Tip on a locked slot "Abre com Realeza Nv. {0}" using the lowest royalty level whose count reaches the slot (`TV/TreasureOuterItem.as:102-128`, `CM/yishi/datas/templates/cate/RoyaltyTempCate.as:90-97, 198-208`).
- Inner slot unlock: count = `OpenInsideTreasureHoke` (1 at royalty 6, 2 at 9, 3 at 13), plus secret adventure progress: `TheseusTreasureHokeTemplates` Type 2 row for the slot, `Property1` = required secret map id compared with `passMapId`, tip "Abre passando da Expedição do Eremitério {0}" (`TV/TreasureInnerItem.as:39-78`). All `Property1` values are 0 in data.
- Core unlock: `minCoreLv` = lowest royalty level with `OpenCoreTreasureHoke > 0` (6); core level 1 row `SecretLevel` (0) vs `passMapId` (`TV/TreasureCoreItem.as:35-63`). The client shows the core locked while `coreLevel == 0` (`TV/TreasureOuterItem.as:140-153`).
- `hokeInfo` the server must build: 12 values, index 0..8 = 1 when outer slot index < OpenOutsideTreasureHoke, index 9..11 = 1 when (index-9) < OpenInsideTreasureHoke and the secret condition holds, else 0. Core: set `coreLevel` to 1 when the royalty level reaches `minCoreLv` *(assumption: the client never sends an unlock request)*.
- Core cap: `coreLevel < OpenCoreTreasureHoke` (20 at royalty 6, 40 at 8, 60 at 10, 80 at 12, 100 at 14, 120 at 16, 140 at 18, 150 at 20).
- Core cost of L to L+1 = row(L).`StrengthenItem` x `StrengthenItemNum` (2127023 "Pedra de Fort. do Núcleo", 36 at level 1 up to 793+) plus, at levels 25, 50, 75, 100, 125, row(L).`BreachItem` 2127024 "Pedra de Superação do Núcleo" x 100/300/500/800/1000 (`TV/TreasureCoreFrame.as:193-238`). Interpretation: the button label becomes "break" on those rows.
- Core stars `Profile`: 1 at 1..25, 2 at 26..50, ..., 6 at 126..150. Core skills: `CoreSkills` "5000001" from 26, "5000001,5000002" from 76, three skills from 126.
- Core attributes = row(coreLevel) columns `PhyAttack` .. `ResiPenetrate`.
- Treasure attributes = `TheseusTreasureGrowupTemplates` row with `TreasureId = templateId` and `TreasureLevel = strengthenGrade` (`TV/TreasurePageView.as:406-411`); refine bonus = skills `randomSkill1..5` of the item.
- Max strengthen effect when `strengthenGrade == templateInfo.StrengthenMax` (30 outer, 40 inner) (`TV/TreasureOuterItem.as:187-193`).
- Inner treasure uniqueness: no two equipped inner treasures with the same `Property4` (1..3).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/TheseusTreasureHokeTemplates.xml` (12 rows) | slot | `TemplateId`, `Type` 1 outer / 2 inner, `HokeId` 1..9 or 1..3, `Property1` required secret map, `Property2` |
| `raw/xml/tempinfos/TheseusTreasureCoreTemplates.xml` (150 rows) | core level | `Level`, `Profile` stars, `Description`, `StrengthenItem`, `StrengthenItemNum`, `BreachItem`, `BreachItemNum`, `CoreSkills`, `Icon`, `SecretLevel`, `Property1`, 17 attribute columns |
| `raw/xml/tempinfos/TheseusTreasureGrowupTemplates.xml` | treasure level | `TemplateId`, `TreasureId`, `TreasureLevel`, `StrengthenItem` (2127022 outer, 2127026 inner), `StrengthenItemNum`, attribute columns (used by the smith strengthen) |
| `raw/xml/tempinfos/RoyaltyTemplates.xml` | slot counts and core cap | `OpenOutsideTreasureHoke`, `OpenInsideTreasureHoke`, `OpenCoreTreasureHoke` |
| `ItemTempInfos.xml` | treasures | MasterType 11, SonType 750 (8 templates) / 751 (9 templates, `Property4` kind 1..3), `StrengthenMax` |
| `ConfigInfos.xml` | `theseus_treasure_melting_const` "1,2,3,4" | extra refine stones per locked attribute (smith) |

## 7. Persistent state

- Equipped and stored treasures are inventory rows (bags 38/39) of [../inventory/README.md](../inventory/README.md). Required constraint there: at most one item per (player, bag 39, pos 0..11).
- Core level: `theseus.player_progress.core_level` ([soul.md](soul.md) §7).
- No new table.

## 8. Backend implementation notes

- Inventory hook `theseus::treasure::validate_bag_move` called by the 5005 handler when `begin_bag_type` or `end_bag_type` is 39:
  1. end pos must be 0..11; outer kinds (750) only at 0..8, inner (751) only at 9..11;
  2. slot opened (`hokeInfo` rule §5);
  3. inner: no other equipped inner treasure with the same `Property4`;
  4. swap with the occupant back to bag 38 (fail if bag 38 full);
  5. after commit push 115 (inventory), 4302 and 4300.
- `theseus::treasure::handle_core_strengthen` (8680 op 5), validation order:
  1. `core_level > 0` (core unlocked) and `core_level < OpenCoreTreasureHoke(royalty)`;
  2. `SecretLevel` of row(core_level) `<= passMapId`;
  3. stones in bags 1/34: `StrengthenItemNum` (+ `BreachItemNum` of 2127024 when set);
  4. transaction: consume, `core_level + 1`;
  5. push inventory update, 4298, 4302, 4300.
- `theseus::treasure::on_royalty_level_changed` (from [../royalty-boss/README.md](../royalty-boss/README.md)): set `core_level = 1` when reaching `minCoreLv`; push 4298 when `hokeInfo` changes.
- `theseus::treasure::totals(player_id)`: sum of growup rows of equipped treasures + refine skills + core row + core skills; builds 4302 and feeds 4300.
- No timers, no battles.

## 9. Open questions and assumptions

1. Core unlock (`coreLevel` 0 to 1) has no client request; assumed automatic on royalty level 6.
2. `BreachItem` rows: whether break is a separate action is unknown; the client sends the same op 5 for both buttons (`TV/TreasureCoreFrame.as:127-128`).
3. Removal sends `end_pos` 0; assumed "first free slot".
4. Whether 4300 includes treasure totals is not visible.
5. Treasure acquisition (drops, shops) is outside this feature.

## 10. Implementation checklist

- [ ] Screen `TreasurePageView` with 13 slots, locks, tips and detail panel.
- [ ] Screens `TreasureBagView`, `TreasureCoreFrame`, `TreasureTotalFrame`, `TreasureSkillItem`.
- [ ] Route 5005 hooks for bags 38/39 (equip, replace, remove) with slot and duplicate rules.
- [ ] Route 8680 op 5 core strengthen with royalty cap, secret level and break items.
- [ ] Server message 4302 treasure totals.
- [ ] `hokeInfo` builder in 4298.
- [ ] Royalty level hook for core unlock.
- [ ] Test: equipping an outer treasure into slot 4 at royalty 6 (3 slots) is rejected.
- [ ] Test: two inner treasures with the same `Property4` cannot be equipped.
- [ ] Test: core strengthen at level 20 with royalty 6 is rejected; at level 25 requires 100 x 2127024.
