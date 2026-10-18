# Residence (house and garden)

Module `residence` of feature `farm`. The player residence maps: house interior (maps 5601..5605) and garden (maps 5501..5505), entering, `HomeMsg`, furniture layout editing, furniture purchase, random event furniture and the dormant house management ops.

Path aliases:

| Alias | File |
|---|---|
| HS | `decompiled/core_module/scripts/home/HomeSender.as` |
| HM | `decompiled/core_module/scripts/managers/HomeManager.as` |
| HMO | `decompiled/core_module/scripts/mvc/module/home/HomeModel.as` |
| HI | `decompiled/core_module/scripts/mvc/module/home/HomeInfo.as` |
| FTY | `decompiled/core_module/scripts/mvc/module/home/FurnitureType1.as`, `FurnitureType2.as`, `FurnitureType3.as` |
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| HUV | `decompiled/m3/scripts/map/campaign/view/house/HouseUIView.as` |
| HSV | `decompiled/m3/scripts/map/campaign/view/house/HouseStoreView.as` |
| FL | `decompiled/m3/scripts/map/campaign/view/house/FurnitureLayer.as` |
| FV | `decompiled/m3/scripts/map/campaign/view/house/FurnitureView.as` |
| FBC | `decompiled/m3/scripts/map/campaign/view/house/FurnitureBagCell.as` |
| FCCM | `decompiled/m3/scripts/map/campaign/mediator/house/FurnitureCellClickMediator.as` |
| HUM | `decompiled/m3/scripts/map/campaign/mediator/house/HouseUIMediator.as` |
| FSBF | `decompiled/core_module/scripts/yishi/view/frame/FurnitureShopBuyFrame.as` |
| SHM | `decompiled/core_module/scripts/managers/ShopManager.as` |
| WBH | `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as` |
| CMV | `decompiled/m3/scripts/map/campaign/view/CampaignMapView.as` |

## 1. Overview

The residence is a pair of campaign maps owned by a player (or a married couple: `HomeMsg.userId_a`, `userId_b`): the house interior (`WBH.checkInHouse`, maps 5601..5605) and the garden (`WBH.checkInHome` / `checkFarm`, maps 5501..5505) (`WBH:310-313,466-479`). The map id follows the house and garden levels (UpGrade Types 45 / 46 `TemplateId`). In the house map the client registers `HouseUIMediator` and `HouseMoveMediator`; in the garden map `FarmMediator` (farm layers, bonfire UI) (`CMV:356-364`). Visitors walk around; the owner can enter edit mode, move, rotate and store furniture, and save the layout. Furniture is bought in a shop with "Cristais de Vênus".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `HouseUIView` (`HUV`) | "Dono da Residência:{0}" | residence HUD: title, luxury, edit button, move / rotate / store buttons, friend list (type 1), bonfire button, "Voltar à residência" | map enter (`HUM` / `FarmMediator`) | house or garden owner name (`HUV:148-157`), luxury sum of placed furniture (`HUV:354-385`) |
| `HouseStoreView` (`HSV`) | | edit mode bottom bar: furniture bag, buy mode, all in, save, leave | `HUV` edit mode | `FurnitureBagView` cells by category, "Coloque-os na residência: {0}" |
| `FurnitureBagCell` (`FBC`) | | one furniture template: owned count, buy button (only when `NeedPoints > 0`) | `HSV` | tip with required level, luxury, price or "Não está à venda" |
| `FurnitureShopBuyFrame` (`FSBF`) | "Comprar" | furniture shop purchase | farm shop furniture tab ([shops catalog](../shops/catalog.md)) | "Contém: {0}/{1}" owned vs allowed |
| Map furniture (`FL`, `FV`) | | placed furniture, grid placement, event furniture sparkle | maps | `HomeInfo.layList1/2` |

## 3. Routes (client to server)

C>S 8873 (0x22a9) `C_HOME_OP`, `children.ChildrenOpMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op_type` | #1 | INT32 | operation |
| `pay_type` | #2 | INT32 | 0 bound diamonds first, 1 diamonds |
| `property1` | #3 | INT32 | target user id or template id |
| `property2` | #4 | INT32 | extra integer (mount template, op 13) |
| `property3` | #5 | STRING | unused |
| `property4` | #6 | STRING | unused |
| `property5` | #7 | BOOL | accept flag (op 1007) |
| `property6` | #8 | INT32 | unused |
| `furniture` | #9 | `FurnitureDecMsg`, repeated | layout: `id (#1)`, `pos_x (#2)`, `pos_y (#3)`, `rotation (#4)` |
| `property7` | #10 | INT32 | unused |
| `poses` | #11 | `PosMsg`, repeated | unused |
| `inviteFriendids` | #12 | INT32, repeated | invited friends (op 1006) |

### R1. Enter a house (op 1003)
- UI: "Residência" button (own) (`decompiled/m3/scripts/farm/FarmEnterNewFrame.as:167-170`), "Voltar à residência" (`HUV:387-391`), friend list item in a residence map (`decompiled/m3/scripts/water/view/FarmFriendListView.as:446-460`).
- Sender `HS.enterHouse(userId)` (`HS:123-130`): `op_type = 1003`, `property1` = owner user id.
- Server: create or reuse the owner's residence room and move the caller into the house map for the owner's house level (campaign enter messages of [campaign](../campaign/README.md)); then push 4753 `HomeMsg` with `tar_user_id` = owner (sets `masterId`), and the garden state (4982 when a party is scheduled). Error tip key exists: "O dono ainda não comprou residência" (unused by this client).
- The garden map is reached from the house through a map portal (assumption; op 1002 `enterHome` exists but is never sent, `HS:114-121`).

### R2. Save the layout (op 3 house, op 6 garden)
- UI: save in edit mode (`HSV:245-298`); only one wall (Type 1) and one floor (Type 2) are kept in the house.
- Sender `HS.setFurnitureHouse(list)` / `HS.setFurnitureHome(list)` (`HS:96-112`): `op_type = 3` or 6, `furniture` = every placed piece `{id, pos_x, pos_y, rotation}`; pieces not listed go back to storage.
- Client checks (placement, `FL:680-710`): per furniture type maximum from Types 45 / 46 `TemplateName` (comma list indexed by `FurnitureType - 1`) -> "O monte de mobília atingiu o limite"; rotation rules -> "Esta mobília não pode ser rodaada." / "... neste local." (`HUV:446-475`); leaving without saving asks "Você não salvou o laioute, deseja sair?" (`HSV:300-334`).
- Response: 4753 with `is_refresh = true` (ends edit mode, `HM:208-212`), pushed to everyone in the map (assumption).

### R3. Buy furniture in the shop
- UI: `FSBF` confirm (`FSBF:172-185`). Client check: owned count < allowed count ("Atingiu o limite não é possível comprar mais").
- Sender `SHM.buyFurnitureGoods(shopId, count)` (`SHM:1248-1255`): C>S 9519 (0x252f) `C_FURNITURE_SHOP_BUY`, `children.FurnitureShopBuyMsg`: `shop_id (#1, INT32)` = `FurnitureShopTempInfos.Id`, `count (#2, INT32)`.
- Server: cost `CostItemId` (-1600 "Cristais de Vênus") x `CostItemCount` (100) per unit, add furniture rows to storage. Response: currency push, 4753 (new furniture in storage, `pos_x = pos_y = -1`).

### R4. Buy furniture by template (op 2)
- UI: buy button in the furniture bag (`FBC:176-290`), only when `NeedPoints > 0` (0 for every shipped template, so the button is disabled); confirms "Quer consumir {0} diamantes para comprar [{1}]?".
- Sender `HS.buyFurniture(templateId, useBind)` (`HS:177-192`): `op_type = 2`, `property1` = template, `pay_type`.

### R5. Click event furniture (op 1004)
- UI: click a sparkling furniture (`FV:199-225`) when `HomeMsg.random_id` names a piece; visitor clicks on another player's residence.
- Sender `HS.clickFurniture(ownerId)` (`HS:212-219`): `op_type = 1004`, `property1` = residence owner.
- Server: random reward to the clicker (assumption), clear `random_id`; push 4753.

### R6. Dormant ops (sender exists, no caller in this client)

| op | Sender | Meaning (from names and strings) |
|---|---|---|
| 1001 | `HS.buyHouse` (`HS:132-143`), level >= 70 else "O seu nível é insuficiente nv.{0} não pode comprar residência" | buy residence; strings mention 10000000 or 8000000 gold |
| 1 | `HS.upgradeHouse(useBind)` (`HS:145-159`) | house level up: luxury >= Types 45 `Data`, cost `ActiveObject` diamonds ("Deseja consumir {0} diamantes para elevar residência?", "Grau de luxo insuficiente...") |
| 5 | `HS.upgradeHome(useBind)` (`HS:161-175`) | garden level up (Types 46) |
| 4 | `HS.confirmHomeMastre(userId)` (`HS:194-201`) | confirm garden owner (couple) |
| 7, 9 | `HS.getReward`, `HS.requestReward` (`HS:48-62`) | garden reward |
| 8, 10 | `HS.employ`, `HS.reEmploy` (`HS:64-94`) | maid employ / renew (cleanliness, `maidExpireDate`) |
| 1002 | `HS.enterHome(userId)` (`HS:114-121`) | enter garden |
| 1005 | `HS.requestHomeInfoByUserId(userId)` (`HS:203-210`) | select home info -> 4757 |

Implement them as no-ops returning 4753 (assumption) unless a later client uses them.

## 4. Server messages (server to client)

### S1. 4753 (0x1291) `U_C_HOME_INFO`, `children.HomeMsg`
Receivers `HM.__homeInfoHandler` (`HM:71-214`) and `FM.__homeInfoHandler` (`FM:115-145`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `home_id` | #1 | INT32 | residence id |
| `userId_a`, `userId_b` | #2, #3 | INT32 | owners (couple); key `a_b` in `HMO.homeDic` |
| `courtyardGarde` | #4 | INT32 | garden level (Types 46) |
| `houseGrade` | #5 | INT32 | house level (Types 45) |
| `state` | #6 | INT32 | residence state (stored) |
| `furniture` | #7 | `FurnitureMsg`, repeated | house furniture: `id (#1)`, `templateId (#2)`, `pos_x (#3)`, `pos_y (#4)`, `rotation (#5)`; `pos < 0` = in storage. Without a placed wall / floor the client places 101002 / 202001 at (0,0) (`HM:147-178`) |
| `random_id` | #8 | INT32 | event furniture id (R5) |
| `cour_userid`, `cour_nickname` | #9, #10 | INT32, STRING | garden owner |
| `house_userid`, `house_nickname` | #11, #12 | INT32, STRING | house owner |
| `tar_user_id` | #13 | INT32 | residence being viewed (`masterId`) |
| `is_refresh` | #14 | BOOL | layout saved, leave edit mode |
| `courFurniture` | #15 | `FurnitureMsg`, repeated | garden furniture |
| `is_get` | #16 | BOOL | garden reward taken (stored only) |
| `is_big_bonfire` | #17 | BOOL | today's big bonfire used ([bonfire-party.md](bonfire-party.md)) |
| `cleanness` | #18 | INT32 | cleanliness (stored only) |
| `maidExpireDate` | #19 | STRING | maid expiry (stored only) |
| `today_bonfire_count` | #20 | INT32 | unused |
| `showMount` | #21 | `ShowMountMsg`, repeated | garden mount showcase ([bonfire-party.md](bonfire-party.md)) |
| `leftTime`, `beginLeftTime` | #22, #23 | INT32 | bonfire timers (read from 4982) |

### S2. 4757 (0x1295) `U_C_SELECT_HOME`, `HomeMsg`
Receiver `HM.__selectInfoHandler` (`HM:60-69`): when `userId_a` or `userId_b` is the player's spouse id, notifies `ChildEvent.HOME_INFO`. Answer to op 1005 (dormant).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Maps | house 5601 (level 1), 5602 (level 2); garden 5501, 5502 | UpGrade Types 45 / 46 `TemplateId` |
| House level 2 | luxury 800 (`Data`), 1000 diamonds (`ActiveObject`) (assumption from strings) | Types 45 |
| Garden level 2 | luxury 200, 1000 diamonds | Types 46 |
| House furniture caps by `FurnitureType` (1 wall .. 11 paper) | level 1: 1,1,2,4,4,2,4,4,2,4,6; level 2: 1,1,2,8,8,2,8,16,8,16,10 | Types 45 `TemplateName`, `FTY` |
| Garden furniture caps (6 kinds: small plant, big plant, water plant, stone, sculpture, other) | level 1: 4,2,4,2,1,5; level 2: 8,4,8,4,2,10 | Types 46 `TemplateName` |
| Default wall and floor | 101002, 202001 | `HM:20-22` |
| Furniture shop | 12 rows, ShopType 20, 100 "Cristais de Vênus" each, 1 piece | `FurnitureShopTempInfos.xml` |
| Furniture templates | 73 rows; `Type` (1 wall, 2 floor, 3 carpet, 4 house item, 5 garden, 7 decoration), `FurnitureType`, `Icon1` "resource,w,h" grid footprint; `Grade`, `Luxury`, `NeedPoints` are 0 in this dump | `FurnitureTempInfos.xml` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `FurnitureTempInfos.xml` | furniture | `TemplateId`, `TemplateName`, `Type`, `FurnitureType`, `Grade`, `Luxury`, `NeedPoints`, `Icon1`, `Icon2` |
| `FurnitureShopTempInfos.xml` | shop row | `Id`, `ShopType`, `CostItemId`, `CostItemCount`, `SellFurnitureId`, `SellFurnitureCount` |
| `UpGradeTempInfos.xml` Types 45 / 46 | house / garden level | `Grades`, `TemplateId` (map), `TemplateName` (caps), `Data`, `ActiveObject` |
| `Campaigns.xml`, `MapInfos.xml` | maps | only 5602 "Jardim" is present in this dump |

## 7. Persistent state

```sql
CREATE TABLE farm.residences (
  residence_id     BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  owner_a_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  owner_b_id       BIGINT REFERENCES player.players(player_id) ON DELETE SET NULL,
  house_level      SMALLINT NOT NULL DEFAULT 1 CHECK (house_level BETWEEN 1 AND 5),
  garden_level     SMALLINT NOT NULL DEFAULT 1 CHECK (garden_level BETWEEN 1 AND 5),
  state            SMALLINT NOT NULL DEFAULT 0,
  cleanness        INTEGER  NOT NULL DEFAULT 0,
  maid_expires_at  TIMESTAMPTZ,
  event_furniture_id BIGINT,
  garden_reward_taken BOOLEAN NOT NULL DEFAULT false,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (owner_a_id)
);
CREATE UNIQUE INDEX residences_owner_b ON farm.residences (owner_b_id) WHERE owner_b_id IS NOT NULL;

CREATE TABLE farm.furniture (
  furniture_id   BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  residence_id   BIGINT   NOT NULL REFERENCES farm.residences(residence_id) ON DELETE CASCADE,
  template_id    INTEGER  NOT NULL,
  area           SMALLINT NOT NULL CHECK (area IN (1, 2)),
  pos_x          INTEGER  NOT NULL DEFAULT -1,
  pos_y          INTEGER  NOT NULL DEFAULT -1,
  rotation       SMALLINT NOT NULL DEFAULT 1,
  acquired_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX furniture_residence ON farm.furniture (residence_id, area);
```

`area` 1 = house, 2 = garden.

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 8873 op 1003 | `farm::residence::handle_enter_house` |
| 8873 op 3 / 6 | `farm::residence::handle_save_layout` |
| 8873 op 1004 | `farm::residence::handle_click_event_furniture` |
| 8873 op 2 | `farm::residence::handle_buy_furniture` |
| 8873 ops 1, 4, 5, 7, 8, 9, 10, 1001, 1002, 1005 | `farm::residence::handle_dormant` |
| 9519 | `farm::residence::handle_furniture_shop_buy` |

- Residence creation: create lazily on first enter (assumption: free level 1 residence for level >= 12 players, since the buy UI is missing).
- Enter: resolve the owner's residence, open or join the campaign room of map `Types45[house_level].TemplateId`, send campaign enter data, then 4753 (`tar_user_id` = owner) and the garden mounts.
- Save layout validation: caller is an owner; every id belongs to the residence and area; per type caps from Types 45 / 46; at most one wall and one floor; positions inside the map grid -> update rows -> broadcast 4753 `is_refresh = true` to the room.
- Furniture shop: row exists, count > 0, owned + count <= cap, currency -1600 >= 100 * count -> transaction -> currency push, 4753.
- Event furniture: daily random selection per residence (assumption) and reward on first visitor click.

## 9. Open questions and assumptions

- Assumption: residence is free and auto created; buy, upgrade, maid and reward ops are dormant.
- Assumption: the garden map is reached by a portal node in the house map.
- Gap: maps 5501, 5502, 5601 are missing from `Campaigns.xml` / `MapInfos.xml` in this dump; layouts and nodes must be recovered.
- Unknown: luxury values are 0 in every furniture template, so the luxury display is always 0.

## 10. Implementation checklist

- [ ] Screens (client ready): `HouseUIView`, `HouseStoreView`, `FurnitureBagView`, `FurnitureBagCell`, `FurnitureLayer`, `FurnitureView`, `FurnitureShopBuyFrame`.
- [ ] Route 8873 op 1003 with campaign room enter and 4753.
- [ ] Route 8873 ops 3 and 6 with caps.
- [ ] Route 9519 furniture shop.
- [ ] Route 8873 op 1004 event furniture; op 2.
- [ ] Dormant ops handled safely.
- [ ] Messages 4753, 4757.
- [ ] Tables `farm.residences`, `farm.furniture`.
- [ ] Tests: saving 2 walls keeps 1; 5th house mural at level 1 refused; furniture shop purchase beyond cap refused; visitor cannot save a layout.
