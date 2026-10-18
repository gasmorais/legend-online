# Theseus: Armadura de Teseu (armor bag, equip, suits)

Module `equipment-suits`. First tab of "Alma de Teseu": nine elemental armor suits of 12 slots each, a dedicated Theseus bag (armor pieces plus Theseus materials), equip / unequip / move / tidy, suit set bonuses, armor value and red dots. Upgrading pieces (strengthen, quality) and decomposing them are in [war-frame.md](war-frame.md).

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/theseus/TheseussoulModel.as` |
| SUIT | `decompiled/core_module/scripts/mvc/module/theseus/TheseusSuitInfo.as` |
| WFI | `decompiled/core_module/scripts/mvc/module/theseus/WarFrameItemInfo.as` |
| T | `decompiled/m5/scripts/theseus` |
| CM | `decompiled/core_module/scripts` |

---

## 1. Overview

- Nine suits, index 1..9 (`theseus.equip.suitName1..9`): "Armadura da Água", "de Fogo", "de Choque", "de Vento", "de Luz", "da Escuridão", "Marinha", "da Terra", "Celeste". Suit `n` is selectable when `RoyaltyTemplate.OpenTheseus >= n` (`T/view/ThereussoulEquipView.as:144-169`).
- Each suit has 12 equip positions (pos 0..11). The part type (`sonType`) of each position is `SONTYPES = [0,2,3,4,1,5,8,8,9,9,6,7]` (`MOD:35`):

| pos | sonType | Part (`theseus.equip.partN`) |
|---|---|---|
| 0 | 0 | Arma |
| 1 | 2 | Escudo |
| 2 | 3 | Manto |
| 3 | 4 | Colar |
| 4 | 1 | Roupa |
| 5 | 5 | Elmo |
| 6, 7 | 8 | Anel |
| 8, 9 | 9 | Bracelete |
| 10 | 6 | Cinto |
| 11 | 7 | Sapato |

- Pieces are items with `MasterType 10, SonType 720` in `ItemTempInfos.xml` (908 templates, e.g. 7211001 "Arma da Água Nv. 1"). Item properties: `Property1` suit index 1..9, `Property2` part group 1/2/3, `Property3` part sonType 0..9, `Property4` piece level (Nv. 1..20), `Property5` base armor value, `Property6` 1 when the piece is at max synthesis level (required by war-frame).
- The Theseus bag (`MOD.armorBagDic`, keyed by Theseus item id) also stores Theseus materials (MasterType 10, SonTypes 730/740/750/751, e.g. 7400001 "Aço da Intenção de Guerra", 7450001 "Pedra de Temperamento Divino", 7460003 "Pedra Divina Impecável") as stacked entries with `type != 1` (`CM/yishi/manager/GoodsManager.as:1251-1266`).
- Suit set bonuses: three groups per suit, "Conjunto de Arma" (pos 0+4), "Conjunto de Escudo" (pos 1+2) and "Conjunto de Acessório" (pos 3,5..11) (`SUIT:93-109`). A group is active when all its positions are filled and the lowest piece level reaches `NeedMinLevel` (`T/item/TheseusInfoItem.as:99-111`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `T/view/TheseusEquipPageView.as` | tab 1 of "Alma de Teseu" | Container of equip view and bag (`:20-26`) | Main frame tab 1 | |
| `T/view/ThereussoulEquipView.as` | suit name in `_equipTName` (`theseus.equip.suitNameN`) | Hero avatar, 12 `TheseussoulEquipCell` of the selected suit, 9 `TheseusTaoItem` suit selectors, armor value, buttons | tab 1 | Cells from `MOD.suitInfo.getSuitArray(currSuitIdx)` and `armorBagDic` (`:212-255`); armor value `propertys.armour`, toggled by `_refresh` to the selected suit sum (`:342-363`); link "Atributos do Conjunto" (`theseus.equip.LookTxt`) opens openType 1 (`:365-368`); armor upgrade button opens openType 8 (`:299-303`); "Coleção" button (if `VersionSwitch.TREASURECANGPING`, `:174-182`, part B); "Divino" button visible when `OpenSlate == 1` (`:183-194`, part B) |
| `T/item/TheseusTaoItem.as` | suit name | Suit selector; locked icon when not opened; red dot | equip view, order `[8,6,7,9,4,2,1,3,5]` (`ThereussoulEquipView.as:145`) | click sets `MOD.currSuitIdx` (`:105-108`); red dot from `MOD.checkOneSuitRed` (`:110-130`) |
| `T/item/TheseussoulEquipCell.as` | | One equip slot | equip view | piece icon, level "Nv." from `Property4` (`:242`), strengthen number |
| `T/view/TheseusEquipBagView.as` | "Organizar" button (`armyII.ArmyFrameII.tidy`) | Theseus bag, 6 page buttons, tidy | tab 1 | `TheseusBagView(7,8,6)`: 7 columns x 8 rows x 6 pages = 336 slots (`:72`); shows every non equipped entry placed by `pos` (`T/view/TheseusBagView.as:87-113, 152-164`) |
| `T/TheseusSuitFrame.as` | "Atributo do Conjunto" (`theseus.equip.suitTitle`) | Read-only suit bonus list of the selected suit, three `TheseusInfoItem` (groups 1,2,3) | link "Atributos do Conjunto", controller openType 1 | per group: "SuiteName(filled/total)", attribute names and values from the suit skill's `skillPropertyTemplate`, description, next tier tip `theseus.equip.suitNextTip1/2/3` (`T/item/TheseusInfoItem.as:65-184`); grey filter when inactive |
| Tooltip `CM/yishi/view/tips/goods/TheseusEquipTip.as` | "Valor de Armadura Equipada:" (`TheseusEquipTip.desc1`) | Piece tooltip | hover | quality name `theseus.war.gzN`, attributes |

## 3. Routes (client to server)

All routes use `TheseussoulManager.doWarFrameParam(op, id, pos, param1, ids)` (`MGR:980-993`) and opcode 8684 (0x21ec) `C_THESEUS_WARFRAMECLIENT_OP`, message `player.PlayerOpMsg` with fields `op` (#1, INT32), `id` (#5, INT32), `pos` (#19, INT32), `param1` (#15, STRING, always "" here). `ids` (#20) is not set.

### R1. Tidy the bag ("Organizar")

- UI: `_tidyBtn` (`T/view/TheseusEquipBagView.as:93-96`).
- Client checks: none.
- Request: `op` 1, `id` 0, `pos` 0, `param1` "".
- Response: 4323 op 1 with every bag entry and its new `pos` (S1).

### R2. Move a piece inside the bag

- UI: drag a `TheseusBagCell` onto another `TheseusBagCell` (`T/mediator/TheseusBagCellDropMediator.as:88-94`).
- Client checks: none (target may be empty or occupied).
- Request: `op` 2, `id` = source item id, `pos` = target bag slot (0..335), `param1` "".
- Response: 4323 op 2 with the moved item and, if swapped, the other item *(assumption: swap when occupied)*.

### R3. Equip a piece

- UI A: double click a bag cell (`T/mediator/TheseusBagCellClickMediator.as:38-88`). Checks in order:
  1. Bag shown inside the armor upgrade frame and `Property6 != 1`: tip "Nível não está no máximo, não é possível prosseguir." (`theseus.equip.QHtips`, `:46-50`) (that path is war-frame).
  2. `SonType != 720`: ignore (materials) (`:51-54`).
  3. Inside the upgrade frame: put into the upgrade slot instead (`:55-59`).
  4. `RoyaltyTemplate.OpenTheseus < Property1`: tip "Abra o Conjunto correspondente primeiro" (`theseus.equip.suitNeedChoose`, `:62-66`).
  5. Switches the displayed suit to the piece's suit (`:67-71`).
  6. Target pos: first pos whose sonType equals `Property3`; for rings and bracelets (two positions) use the second pos when the first is occupied (`:72-82`, `getSontypePos` `:90-105`).
- UI B: drag a bag cell onto a `TheseussoulEquipCell` (`T/mediator/TheseusBagCellDropMediator.as:68-87`). Checks: `Property3 != cell.sonType` tip "O tipo do Equipamento não corresponde" (`theseus.equip.putNo`); `Property1 != currSuitIdx` tip "O tipo do Conjunto não corresponde" (`theseus.equip.suitNo`).
- Request: `op` 7, `id` = item id, `pos` = equip position 0..11.
- Response: 4323 op 7 with the equipped item (`isEquip` true, `equipPos`) and, if the slot was occupied, the replaced item back in the bag (`isEquip` false, new `pos`); then 4300 (property totals).

### R4. Unequip a piece

- UI A: double click an equip cell (`T/mediator/TheseussoulEquipCellClickMediator.as:27-37`).
- UI B: drag an equip cell onto any bag cell (`T/mediator/TheseussoulEquipCellDropMediator.as:40-54`); the target bag slot is not sent.
- Client checks: none (no bag full check).
- Request: `op` 8, `id` = item id, `pos` = the equip position being emptied (`_cell.pos`).
- Response: 4323 op 8 with the item (`isEquip` false, a free bag `pos`), then 4300. The client clears the id from the suit array on op 8 (`MGR:697-700`).

### R5. Lock a piece

- Via vice password, 8809 op_type 11 (see [soul.md](soul.md) R2). No 8684 op 3 sender exists.

## 4. Server messages (server to client)

### S1. 4323 (0x10e3) `U_C_THESEUS_EQUIP_DATA`

- Message `theseus.TheseusEquipListMsg`:
  - `theseusEquips` (#1, `TheseusEquipMsg`, repeated): changed entries.
  - `op` (#2, INT32): echo of the 8684 op that caused the push; 0 for snapshot or unsolicited pushes (new items from drops, compose, quests).
- `theseus.TheseusEquipMsg`:
  - `id` (#1, INT32): Theseus item id (bag key).
  - `templateId` (#2, INT32): item template.
  - `type` (#3, INT32): 1 = armor piece; other = stacked material *(assumption: 2)*. `strengthen`/`quality` are only read when `type == 1` (`MGR:688-692`).
  - `pos` (#4, INT32): bag slot 0..335 (ignored while equipped).
  - `count` (#5, INT32): stack size; `count <= 0` deletes the entry (`MOD:161-175`).
  - `strengthen` (#6, INT32): strengthen level 0..400.
  - `quality` (#7, INT32): quality grade (client field `reform`), starts at the item `Profile` (3).
  - `isExist` (#8, BOOL): entry exists.
  - `isLock` (#9, BOOL): vice password lock.
  - `isEquip` (#10, BOOL): equipped.
  - `equipPos` (#11, INT32): equip position 0..11 when equipped.
- Receiver: `MGR.__warFrameInfosHandler` (`MGR:672-732`):
  1. For each entry builds a `WarFrameItemInfo` (template, strengthen and quality template lookups `WFI:77-115`).
  2. If `op == 8`, or `op == 0` with `count <= 0` and `type == 1`: removes the id from the suit string `suite{Property1}` (`MOD.updateSuite2`, `MOD:95-109`).
  3. If `isEquip`: writes the id at `equipPos` of `suite{Property1}` (`MOD.updateSuite1`, `MOD:85-93`).
  4. `op == 4`: delete when `count <= 0`, else upsert; other ops: upsert (upsert drops entries with `count <= 0`).
  5. Sorts the bag (`MOD.sortArmorBagDic`, `MOD:131-159`); dispatches `OP_WarEQUIP_STRENGTHENSTR` with op for 5 and 6, then `EVENT_SUIT_UPDATE`.
- When: response to R1..R4 and to war-frame ops 4..6; snapshot on [soul.md](soul.md) R1; push whenever Theseus items are gained or consumed (drops, compose in the smith, war intent materials, decompose returns).
- Errors: none; a rejected request gets no 4323 *(assumption)*.

## 5. Rules and formulas

- Suit unlock: suit `n` usable when `RoyaltyTemplate(royaltyLevel).OpenTheseus >= n`: `OpenTheseus` is 1 at royalty 1..3, 2 at 4, 3 at 9, 4 at 14, 5 at 19, 6 at 24, 7 at 28, 8 at 32, 9 at 37 (`RoyaltyTemplates.xml`). Server must reject equipping a piece of a locked suit.
- Position rule: piece `Property3` must equal `SONTYPES[pos]`; piece `Property1` is the suit; one piece per (suit, pos).
- Bag: 336 slots (7x8x6). Equipped pieces leave the bag (no `pos`). Server must reject unequip/gain when the bag is full *(assumption: no client check, `theseus.war.mainTypeBag*` style tips do not exist for this bag)*.
- Suit group activation (`T/item/TheseusInfoItem.as:65-111`, `SUIT:57-91`, `CM/yishi/datas/templates/cate/TheseusEquipSuiteTempCate.as:36-71`):
  - group parts: 1 = pos {0,4}, 2 = pos {1,2}, 3 = pos {3,5,6,7,8,9,10,11};
  - `minLv` = lowest `Property4` among the group's equipped pieces (1 if any position is empty);
  - candidate rows: `TheseusEquipSuiteTemplates` with `NeedIndex = suit`, `NeedPart = group`, sorted by `NeedMinLevel`; active row = last row with `NeedMinLevel <= minLv`;
  - active only when every position of the group is filled and `minLv >= row.NeedMinLevel`; bonus = attributes of `SkillId` (`skillPropertyTemplate`, `hasValueAtt + hasKanAtt`).
- Armor value of a piece ("Valor de Armadura", `MOD:421-433`): `Property5 + quality.Fraction + strengthen.Fraction` (quality row by `TemplateId + Quality`, strengthen row by `Type = Property3 + Strengthen`). Suit armor value = sum over equipped pieces of the suit (`MOD:407-419`). Total `armour` in 4300 = sum over all equipped pieces *(assumption)*.
- Red dot (`MOD:327-373, 435-469`), only for opened suits: an equipped position is red when the bag has an unequipped piece of the same suit and part with a higher score `Property5 + quality.CountFraction + strengthen.CountFraction`; an empty position is red when any unequipped piece of that suit and part exists.
- Bag sort (`MOD:131-159`): equipped first, then quality desc, strengthen desc, template id desc, `Property4` desc.
- Piece stats: quality `Attr` and strengthen `Attr` strings "attrId,value|..." with attrId 1 Attack, 2 Defence, 3 MagicAttack, 4 MagicDefence, 5 Live (`CM/mvc/module/theseus/AttributeUtils.as:27-71`); see war-frame §5.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | Theseus pieces (MasterType 10, SonType 720) and materials (730, 740, 750, 751) | `Property1` suit, `Property2` group, `Property3` part, `Property4` level, `Property5` armor value, `Property6` max synthesis flag, `Profile` initial quality, `NeedGrades` 80 |
| `raw/xml/tempinfos/TheseusEquipSuiteTemplates.xml` (106 rows) | suit group tier | `TemplateId`, `SuiteType` (suit*100+group), `SuiteName` (e.g. "Conjunto de Arma da Água"), `SuiteLevel`, `NeedIndex` suit 1..9, `NeedPart` group 1..3, `NeedMinLevel` (1..20), `SkillId` (attribute skill) |
| `SkillTempInfos.xml` + skill property templates | suit bonus values | `SkillId` attributes |
| `TheseusEquipQualityTmpls.xml`, `TheseusEquipStrengthenTmpls.xml` | armor value parts | `Fraction`, `CountFraction` (see war-frame) |

## 7. Persistent state

```sql
CREATE TABLE theseus.armor_items (
    item_id          integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id        bigint NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id      integer NOT NULL,
    item_kind        smallint NOT NULL CHECK (item_kind IN (1, 2)),   -- 1 armor piece, 2 material stack
    bag_slot         smallint CHECK (bag_slot BETWEEN 0 AND 335),
    quantity         integer NOT NULL CHECK (quantity > 0),
    strengthen_level smallint NOT NULL DEFAULT 0 CHECK (strengthen_level BETWEEN 0 AND 400),
    quality          smallint NOT NULL DEFAULT 0,
    is_locked        boolean NOT NULL DEFAULT false,
    suit_index       smallint CHECK (suit_index BETWEEN 1 AND 9),     -- copy of template Property1 when equipped
    equip_pos        smallint CHECK (equip_pos BETWEEN 0 AND 11),
    created_at       timestamptz NOT NULL DEFAULT now(),
    CHECK ((suit_index IS NULL) = (equip_pos IS NULL)),
    CHECK (equip_pos IS NULL OR (item_kind = 1 AND quantity = 1 AND bag_slot IS NULL)),
    CHECK (equip_pos IS NOT NULL OR bag_slot IS NOT NULL)
);
CREATE UNIQUE INDEX armor_items_equip_uq ON theseus.armor_items (player_id, suit_index, equip_pos) WHERE equip_pos IS NOT NULL;
CREATE UNIQUE INDEX armor_items_slot_uq  ON theseus.armor_items (player_id, bag_slot) WHERE bag_slot IS NOT NULL;
CREATE INDEX armor_items_player_idx ON theseus.armor_items (player_id);
```

- Stacking: identical pieces (same template, strengthen 0, base quality, unlocked, unequipped) may share one row with `quantity > 1` *(assumption from `count` and the "new id after strengthen" logic in war-frame)*; equipping takes one unit out into its own row.

## 8. Backend implementation notes

- `theseus::equipment_suits::handle_tidy` (8684 op 1): one transaction; reorder unequipped rows by the client sort (§5) and merge stackable rows; push 4323 op 1 with all bag rows.
- `theseus::equipment_suits::handle_move` (op 2): validate ownership, target slot in 0..335; swap if occupied; push 4323 op 2 with both rows.
- `theseus::equipment_suits::handle_equip` (op 7), validation order:
  1. item exists, belongs to the player, `item_kind = 1`, not equipped;
  2. template `SonType = 720`; suit opened (`OpenTheseus >= Property1`);
  3. `pos` in 0..11 and `SONTYPES[pos] = Property3`;
  4. transaction: split one unit from a stack if `quantity > 1`; if (suit, pos) is occupied move the old piece to a free bag slot (fail if none); set `suit_index`, `equip_pos`, clear `bag_slot`;
  5. push 4323 op 7 (new, old, remaining stack), recompute and push 4300.
- `theseus::equipment_suits::handle_unequip` (op 8): validate the piece is equipped at `pos`; find a free bag slot (fail if none); transaction; push 4323 op 8 and 4300.
- `theseus::equipment_suits::set_lock` (called by the 8809 handler, op_type 11): toggle `is_locked`, push 4323 *(op 3)*.
- `theseus::equipment_suits::grant_items(player_id, template_id, count)`: used by drops, quests, compose and decompose returns; stack materials, place pieces in free slots, push 4323 op 0.
- Suit bonuses and armor value must be applied to the hero combat stats (shared with [../hero/README.md](../hero/README.md)); recompute after every change.
- No timers, no battles.

## 9. Open questions and assumptions

1. `TheseusEquipMsg.type` value for materials is not visible (only `== 1` is tested).
2. Whether pieces stack (`count > 1`) and get a new id on upgrade is inferred from war-frame `updateId` lookups.
3. Bag full behavior on unequip and on item gain is not checked client side.
4. Whether all nine suits contribute stats at the same time, or only the displayed one, is not visible; the client shows a total armor value across suits.
5. `TheseusUserMsg.suite1..9` are not used to rebuild suits; the suit layout is rebuilt only from `isEquip`/`equipPos` in 4323.

## 10. Implementation checklist

- [ ] Screens: equip view, suit selectors with locks and red dots, bag 336 slots with paging, suit attribute frame.
- [ ] Route 8684 op 1 tidy.
- [ ] Route 8684 op 2 move/swap.
- [ ] Route 8684 op 7 equip with suit unlock and part checks.
- [ ] Route 8684 op 8 unequip with bag space check.
- [ ] Lock hook for 8809 op_type 11.
- [ ] Server message 4323 `TheseusEquipListMsg` with correct `op` echo and `count` semantics.
- [ ] Table `theseus.armor_items` with equip and slot uniqueness.
- [ ] Rule: suit group activation and bonus skill attributes.
- [ ] Rule: armor value per piece, per suit, total.
- [ ] `grant_items` used by drops, compose, quests.
- [ ] Test: equip into an occupied ring slot fills the second ring position (client) and server accepts both positions.
- [ ] Test: equipping a suit 9 piece at royalty 30 is rejected.
- [ ] Test: suit group becomes active only when all positions are filled and the lowest level reaches `NeedMinLevel`.
