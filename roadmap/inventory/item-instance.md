# Item instances and bag synchronization

Module of [README.md](README.md). The item row (one stack in one slot of one bag), its wire format `item.ItemInfoMsg`, the generic slot update push 115 used by every item feature, the login load, and the client side cache. Every other module and feature that creates, moves, consumes or modifies items goes through this module.

Path aliases:

| Alias | File |
|---|---|
| GM | `decompiled/core_module/scripts/yishi/manager/GoodsManager.as` |
| GI | `decompiled/core_module/scripts/yishi/datas/goods/GoodsInfo.as` |
| IH | `decompiled/core_module/scripts/com/road/pb/helper/item/ItemHelper.as` |
| IIM | `decompiled/core_module/scripts/com/road/yishi/proto/item/ItemInfoMsg.as` |
| BT | `decompiled/core_module/scripts/bag/datas/BagType.as` |
| BE | `decompiled/core_module/scripts/bag/events/BagEvent.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| LIDA | `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as` |
| MTB | `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as` |

## 1. Overview

- An item instance is one stack: template, count, owner, location `(bag_type, object_id, pos)` and per instance state (bind, validity, enhancement, gems, random skills, mould, lock, pet payload...).
- The client keeps every instance of every bag in one dictionary `GM._goodsListByPos` keyed `"<pos>_<objectId>_<bagType>"` (`GM:146-150`, `GM:197-200`). Everything the client shows (bag, equipment, warehouse, smith workspace, pet and guardian equipment, market stall...) is a filtered view of that dictionary.
- The server never sends a full bag object. It sends slot deltas with opcode 115 `U_C_BAG_MOVE_UPDATE`: each entry names a slot; with an item the slot is created or replaced, without an item the slot becomes empty. The login load sends every slot of the player in 115 pushes.
- `object_id` is the owner inside a bag: 0 for player bags, the hero id for hero equipment (bag 4), medals (bag 3) and battle runes (bag 2, see open questions), the pet id for Einherjar equipment (bag 26), the guardian id for guardian equipment (bag 30).

## 2. Screens

No screen. Client data layer:

| Class | Role |
|---|---|
| `yishi.manager.GoodsManager` (`GM:96-249`) | listener of 115, owner of `_goodsListByPos`, query helpers per bag type, sell selection, emits `BagEvent` |
| `yishi.datas.goods.GoodsInfo` (`GI:16-99`) | client item model |
| `com.road.pb.helper.item.ItemHelper` (`IH:17-67`) | `ItemInfoMsg` to `GoodsInfo` copy (`readGoodsInfo`), `SimpleItemInfoMsg` copy (`readGoodsInfo2`, `IH:69-103`), chat link builder (`IH:105-126`) |

`BagEvent` types emitted by `GM.__bagUpdateHandler` (`BE:9-56`): `ADD_GOODS` (new key), `UPDATE_BAG` (any filled slot), `DELETE_BAG` (slot emptied), `NEW_GOODS` (items with `is_new` in bag 1 or 34, plays sound "030" and the fly to bag animation in `MainToolBar`, `MTB:1143-1180`), `BAG_FULL` (always, re-evaluates the bag button blink), bag specific `UPDATE_/DELETE_BOTTLE_BAG` (22), `UPDATE_/DELETE_GOLDROAD_BAG` (25), `UPDATE_/DELETE_CHRISTMASTREE_BAG` (33), `DELETE_FISH_BAG` (23), `UPDATE_/DELETE_EQUIP` (4), `DELETE_TREASURE_MAP` (SonType 219 removed), `DELETE_MARRY_TASK_MAP` (SonType 320 removed). Any change in bag 4 also fires `REFRESH_FIGHT` (power recompute).

## 3. Routes (client to server)

### R1. Login load (bag part)

- Sender: `LoginInitDataAccept.request` (`LIDA:154-185`) -> `SSM.loginDataReq` (`SSM:83-87`).
- Route: C>S 8224 (0x2020) `C_LONIG_LOAD_REQ`, message `player.PlayerDataMsg` with `bag (#9, BOOL) = true` (plus `smith (#8)`, `army (#3)` and many other flags owned by other features).
- Expected server response, in order: 3 `U_C_PLAYER_INFO` (`PlayerMsg` with `bagCount` #35, `rentalBagTime` #97, `status` #98, `stoneBagCount` #125, see [bag.md](bag.md)); then one or more 115 pushes containing every item row of the player (all bag types, `is_new = false`).
- The project server currently pushes the bag on 8322 `C_LEED_CLIENT` (docs/ui/navigation.md, "login data"); the target design answers 8224 directly.

No other route belongs to this module. All mutations are routes of [bag.md](bag.md), [item-usage.md](item-usage.md), [sell.md](sell.md), [storehouse.md](storehouse.md), [equipment-slots.md](equipment-slots.md) and of other features; they all answer with S1.

## 4. Server messages (server to client)

### S1. 115 (0x0073) `U_C_BAG_MOVE_UPDATE`

- Message `item.ItemMovedListMsg`: `moved` (#1, MESSAGE `ItemMoveUpdateMsg`, repeated).
- `item.ItemMoveUpdateMsg`: `change_type` (#1, INT32) bag type of the slot; `change_obj_id` (#2, INT32) owner id of the slot; `change_pos` (#3, INT32) position; `item` (#4, MESSAGE `item.ItemInfoMsg`, optional) the new content, absent when the slot is now empty.
- Receiver: `GM.__bagUpdateHandler` (`GM:101-249`, listener `GM:98`). For each entry: with `item`, create or update the `GoodsInfo` at key `pos_obj_bag` (copy by `IH.readGoodsInfo`); without `item`, delete the key and emit `DELETE_BAG` with the old data. After the loop it recounts bag 1 totals per template (`GM:251-290`), emits `NEW_GOODS` for new items and `BAG_FULL`, and refreshes the info tips counters.
- When: answer to every item mutation, push for every server side item change (rewards, mail attachment taken, consumption by another feature, expiry), and the login load.
- Important: the key uses the slot fields of the entry, but the stored `GoodsInfo` takes `pos`, `object_id`, `bag_type` from the embedded item. The server must keep both consistent (`change_pos == item.pos`, etc.).
- A move between two slots is two entries in the same message (source cleared or updated, destination filled).

### S2. `item.ItemInfoMsg` (field list, `IIM:959-1149` write, `IIM:1198-1513` read)

| Field | Tag | Type | Client field (`IH:23-65`) | Meaning |
|---|---:|---|---|---|
| `id` | 1 | INT32 | `id` | unique item id (int32 on the wire) |
| `template_id` | 2 | INT32 | `templateId` | `ItemTempInfos.TemplateId` |
| `pos` | 3 | INT32 | `pos` | slot position |
| `exist` | 4 | BOOL | `isExist` | always true for live rows (assumption) |
| `object_id` | 5 | INT32 | `objectId` | owner inside the bag (hero, pet, guardian) |
| `bag_type` | 6 | INT32 | `bagType` | bag type (table below) |
| `bind` | 7 | BOOL | `isBinds` | bound flag ([item-catalog.md](item-catalog.md) 5.9) |
| `used` | 8 | BOOL | `isUsed` | used flag (no client logic found) |
| `valid_date` | 9 | INT32 | `validDate` | validity in minutes, 0 = permanent |
| `begin_date` | 10 | STRING | `beginDate` | `YYYY-MM-DD hh:mm:ss`, start of validity |
| `count` | 11 | INT32 | `count` | stack count |
| `attack` | 12 | INT32 | `attack` | instance stat bonus (legacy) |
| `defence` | 13 | INT32 | `defence` | |
| `agility` | 14 | INT32 | `agility` | |
| `ability` | 15 | INT32 | `intellect` | |
| `captain` | 16 | INT32 | `captain` | |
| `strengthen_grade` | 17 | INT32 | `strengthenGrade` | enhancement +N ([../smith/README.md](../smith/README.md)) |
| `join_1`..`join_4` | 18..21 | INT32 | `join1..4` | socket content: -1 closed (client default), 0 open empty, >0 gem template id |
| `random_skill_1`..`random_skill_5` | 22..26 | INT32 | `randomSkill1..5` | random skill ids (SkillPropertyTempInfos); reused by some props (SonType 320 uses `random_skill_5 = 1` as "expired") |
| `is_new` | 27 | BOOL | `isNew` | newly obtained, triggers `NEW_GOODS` |
| `user_id` | 28 | INT32 | `userId` | owner player id |
| `property1` | 29 | STRING | `property1` | free payload; `"1"` flag for 2032101; serialized `PetData` for Einherjar orbs (`GI:111-123`) |
| `strength` | 30 | INT32 | (not copied) | |
| `tenacity` | 31 | INT32 | (not copied) | |
| `mould_grade` | 32 | INT32 | `mouldGrade` | mould grade, rank and star derived (`GI:125-142`) |
| `bless_value` | 33 | INT32 | `blessValue` | smith bless counter |
| `appraisal_skill` | 34 | INT32 | `appraisal_skill` | fashion appraisal skill |
| `is_locked` | 35 | BOOL | `isLock` | second password lock ([../account/item-lock.md](../account/item-lock.md)) |
| `str_bless_value` | 36 | INT32 | `strBlessValue` | strengthen bless |
| `desc_templateId` | 37 | INT32 | `descTemplateId` | template used for the tooltip instead of `template_id` (`GI:221-228`) |
| `usedTimes` | 38 | INT32 | `usedTimes` | uses of a times prop (SonType 609), copied only when present |
| `isTodayUsed` | 39 | BOOL | `isTodayUsed` | times prop used today |

Variants of the same data in other packages: `simple.SimpleItemInfoMsg` (auction, mail lists, read by `IH.readGoodsInfo2`, tags differ: `is_locked` #36, `desc_templateId` #37, `life_skill` #38), `chat.ChatItemInfoMsg` (chat links, see [bag.md](bag.md) B13). `protocol/proto.json` keeps only one `ItemInfoMsg` (the `active` one, 2 fields); use the field table above for `item.ItemInfoMsg`.

### S3. 54 (0x0036) `U_C_BAG_MOVE`

Declared answer to 5005, no client listener. Assumption: not sent; S1 is the real answer. Same for 55 `U_C_BAG_USEITEM` and 56 `U_C_BAG_SELL`.

### S4. 126 (0x007e) `U_C_MSG`

Generic text notice (`campaign.CampaignNotifyMsg`: `id` #1, `scene` #2, `mapId` #3, `body` #4 text, `delay` #5) handled by `BaseManager.__msgHandler` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:2070-2085`). Recommended way to report item request failures (bag full, not enough items) because the item routes have no result message.

## 5. Rules and formulas

### 5.1 Bag types (`BT:7-60`)

| Value | Constant | Use | Owner module or feature |
|---:|---|---|---|
| 0 | `Hide` | smith workspace, positions 0..11 (`GM:1155-1158`) | [../smith/README.md](../smith/README.md) |
| 1 | `Player` | main bag | [bag.md](bag.md) |
| 2 | `Battle` | battle runes (SonType 214), 3 slots | [equipment-slots.md](equipment-slots.md) |
| 3 | `Honer` | medal slot, object = hero | [equipment-slots.md](equipment-slots.md) |
| 4 | `HeroEquipment` | hero equipment and fashion, object = hero | [equipment-slots.md](equipment-slots.md) |
| 6 | `Storage` | guild warehouse | [../guild/warehouse.md](../guild/warehouse.md) |
| 7 | `Temporary` | temporary bag (no client use found) | |
| 8 | `PrizeBox` | legacy guild prize chests | [../guild/warehouse.md](../guild/warehouse.md) |
| 10 | `mail` | mail attachments | [../mail/README.md](../mail/README.md) |
| 11 | `auction` | auction | [../auction/README.md](../auction/README.md) |
| 22 | `Bottle` | golden tree storage | [../golden-tree/README.md](../golden-tree/README.md) |
| 23 | `Fish` | fish basket | [../fishing/README.md](../fishing/README.md) |
| 24 | `Maze` | maze bag | [../mazes/README.md](../mazes/README.md) |
| 25 | `GoldRoad` | gold road temporary bag | [../roads/README.md](../roads/README.md) |
| 26 | `PetEquipment` | Einherjar equipment, object = pet id | [../einherjar/README.md](../einherjar/README.md) |
| 27 | `LLK_BAG` | link game bag | [../mazes/README.md](../mazes/README.md) |
| 28, 29, 30 | `CHILD`, `CHILD_HIDE`, `CHILD_EQUI` | guardian bag, hidden, equipment | [../guardians/README.md](../guardians/README.md) |
| 32 | `MARKET` | market stall slots | [market-stall.md](market-stall.md) |
| 33 | `ChristmasTree` | magic pot storage | [../seasonal-events/README.md](../seasonal-events/README.md) |
| 34 | `STONE_BAG` | treasure bag "Bolsa de tesouro" | [storehouse.md](storehouse.md) |
| 35 | `SALE_PREVIEW` | auction sale preview | [../auction/README.md](../auction/README.md) |
| 36, 37 | `MONSTER_ACCESSORIES_BAG`, `MONSTER_EQUIP_BAG` | monsters | [../monsters/README.md](../monsters/README.md) |
| 38, 39 | `TREASURE`, `TREASURE_EQUIP` | treasures | [../theseus/README.md](../theseus/README.md) |
| 40, 41 | `RUNE`, `RUNE_EQUIP` | rune stones ("Mochila de Runas"), equipped runes in groups of 10 | [../army/README.md](../army/README.md) |

### 5.2 Instance invariants

- One row per `(player, bag_type, object_id, pos)`; positions are 0 based.
- `1 <= count <= MaxCount`; `MaxCount == 1` implies `count == 1`.
- Two rows of the same template and bind flag may coexist (partial stacks); merges only happen on explicit moves or arrange with `isStackItem`.
- Expired rows (`valid_date > 0` and `now >= begin_date + valid_date minutes`) are deleted by the server (scheduler) or when the client asks with 8346 ([bag.md](bag.md) B9).
- `is_new` is true only in the push that creates or increases the item; the stored row keeps it false (assumption).

### 5.3 Client side helpers that the server must mirror

- Count of a template in bag 1 (`GM.getGoodsNumByTempId`), in bags 1 and 34 (`GM.getBagCountInPlayerAndStoneByTempId`, `GM:518-529`), not locked (`GM:1213-1236`). Costs paid with items should consume from bag 1 and bag 34 (assumption, from `isStoreOrPlayerBag`, `GM:2084-2095`).
- First free slot of bag 1: lowest `pos < bagTotalCount` without a row (`GM:644-657`).

## 6. Templates

`ItemTempInfos.xml` ([item-catalog.md](item-catalog.md)) for `MaxCount`, validity and stack rules.

## 7. Persistent state

Schema `inventory`. The item table is shared by all features (smith, guild warehouse, einherjar, guardians, auction escrow...).

```sql
CREATE SCHEMA IF NOT EXISTS inventory;

CREATE SEQUENCE inventory.item_id_seq MAXVALUE 2147483647;

CREATE TABLE inventory.items (
  item_id          BIGINT      PRIMARY KEY DEFAULT nextval('inventory.item_id_seq')
                               CHECK (item_id BETWEEN 1 AND 2147483647),
  player_id        INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id      INTEGER     NOT NULL,
  bag_type         SMALLINT    NOT NULL CHECK (bag_type >= 0),
  object_id        INTEGER     NOT NULL DEFAULT 0,
  position         INTEGER     NOT NULL CHECK (position >= 0),
  count            INTEGER     NOT NULL CHECK (count > 0),
  is_bound         BOOLEAN     NOT NULL DEFAULT false,
  is_used          BOOLEAN     NOT NULL DEFAULT false,
  is_locked        BOOLEAN     NOT NULL DEFAULT false,
  valid_minutes    INTEGER     NOT NULL DEFAULT 0 CHECK (valid_minutes >= 0),
  begin_at         TIMESTAMPTZ NOT NULL DEFAULT now(),
  attack           INTEGER     NOT NULL DEFAULT 0,
  defence          INTEGER     NOT NULL DEFAULT 0,
  agility          INTEGER     NOT NULL DEFAULT 0,
  ability          INTEGER     NOT NULL DEFAULT 0,
  captain          INTEGER     NOT NULL DEFAULT 0,
  strength         INTEGER     NOT NULL DEFAULT 0,
  tenacity         INTEGER     NOT NULL DEFAULT 0,
  strengthen_grade INTEGER     NOT NULL DEFAULT 0,
  socket_1         INTEGER     NOT NULL DEFAULT -1,
  socket_2         INTEGER     NOT NULL DEFAULT -1,
  socket_3         INTEGER     NOT NULL DEFAULT -1,
  socket_4         INTEGER     NOT NULL DEFAULT -1,
  random_skill_1   INTEGER     NOT NULL DEFAULT 0,
  random_skill_2   INTEGER     NOT NULL DEFAULT 0,
  random_skill_3   INTEGER     NOT NULL DEFAULT 0,
  random_skill_4   INTEGER     NOT NULL DEFAULT 0,
  random_skill_5   INTEGER     NOT NULL DEFAULT 0,
  mould_grade      INTEGER     NOT NULL DEFAULT 0,
  bless_value      INTEGER     NOT NULL DEFAULT 0,
  str_bless_value  INTEGER     NOT NULL DEFAULT 0,
  appraisal_skill  INTEGER     NOT NULL DEFAULT 0,
  desc_template_id INTEGER     NOT NULL DEFAULT 0,
  used_times       INTEGER     NOT NULL DEFAULT 0,
  last_used_on     DATE,
  payload          TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (player_id, bag_type, object_id, position)
);
CREATE INDEX items_player_template_idx ON inventory.items (player_id, template_id);
CREATE INDEX items_expiry_idx ON inventory.items ((begin_at + make_interval(mins => valid_minutes)))
  WHERE valid_minutes > 0;

CREATE TABLE inventory.item_log (
  log_id       BIGSERIAL   PRIMARY KEY,
  player_id    INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  item_id      BIGINT,
  template_id  INTEGER     NOT NULL,
  delta        INTEGER     NOT NULL,
  reason       TEXT        NOT NULL,
  opcode       INTEGER,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX item_log_player_idx ON inventory.item_log (player_id, created_at DESC);
```

Column mapping to `ItemInfoMsg`: `socket_N` -> `join_N`, `is_bound` -> `bind`, `valid_minutes` -> `valid_date`, `begin_at` -> `begin_date`, `payload` -> `property1`, `is_today_used` = `last_used_on = current_date`.

## 8. Backend implementation notes

- `inventory::store` (Rust): `load_all(player)`, `slot(player, bag, obj, pos)`, `free_slot(player, bag)`, `add(player, template, count, bind, source) -> Vec<SlotChange>` (fills existing stacks first, then free slots, overflow goes to mail, assumption), `remove(player, template, count) -> Vec<SlotChange>`, `set(row)`. All functions return `SlotChange { bag, obj, pos, item: Option<Row> }`.
- `inventory::sync::push(player, changes)` encodes S1. Every handler collects changes inside its transaction and pushes after commit (one 115 per request).
- `inventory::sync::handle_login_load` (8224 with `bag = true`): push all rows, chunked (for example 200 entries per 115) to stay under the packet size limit.
- Item ids are int32 on the wire: never reuse ids, never exceed 2^31-1 (sequence above).
- `is_new` is a transient flag set only in the push of S1 for rows created or increased by a reward or purchase.
- Expiry job: every minute delete rows past their validity and push S1 to online owners (the client also asks with 8346).
- Item log: every change with reason (opcode or feature) for support and anti duplication.

## 9. Open questions and assumptions

- Battle runes (bag 2) are read with key `pos_0_2` (`decompiled/core_module/scripts/yishi/manager/GoodsManager.as:1048`) but moved with `end_obj_id = hero id` (`decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:626-633`). Assumption: the server stores bag 2 rows with `object_id = 0`.
- `exist` (#4) and `used` (#8) have no client logic; send `exist = true`, `used = false`.
- Overflow when the bag is full: assumption, rewards go to mail ([../mail/README.md](../mail/README.md)); the client only blinks the bag button (`MTB:2592-2611`).
- Whether the original server sent 54 or only 115 after 5005 is unknown.

## 10. Implementation checklist

- [ ] Table `inventory.items` and `inventory.item_log`
- [ ] `inventory::store` add/remove/move primitives returning slot changes
- [ ] Encoder for `item.ItemInfoMsg` (39 fields) and 115 `ItemMovedListMsg`
- [ ] Login load: 8224 `bag` flag -> 3 then 115 with all rows
- [ ] Expiry scheduler and push
- [ ] `is_new` flag only on reward pushes
- [ ] 126 `U_C_MSG` helper for item errors
- [ ] Test: move entry pairs (source cleared, destination filled) in one 115
- [ ] Test: item ids stay within int32
