# Solo trail campaign (single campaign view)

Module `single-campaign` of [campaign](README.md). Every solo campaign started from [selection.md](selection.md) runs here: there is no walkable map, only a row of up to 4 enemy cards fought in order.

## 1. Overview

- `WorldBossHelper.checkPve()` is true when the instance template has `Types 0`, `Capacity 1` and `DungeonId != 0` (`CM/yishi/utils/WorldBossHelper.as:151-155`). This matches exactly the 83 campaigns of the selection frame (1001..1602 and 11101..11602).
- For these instances the campaign controller skips the map preload and builds `SingleCampaignMapView` instead of `CampaignMapView` (`M3/map/campaign/CampaignMapController.as:182-185, 249-254`). `CampaignManager.setup` creates `SingleCampaignModel` with the map id (`CM/map/campaign/CampaignManager.as:187-191`).
- The enemies come from `SingleCampaignDatas.xml` (301 rows). Cards use `Index` 1..4; `Index 0` rows are never displayed.
- The player presses "Desafiar" on the current card (the only card with a button). The client sends **8666** with no body. The server starts the battle, and after a win pushes **4282** with the next index. After the boss card (`Index 4`, `MasterType 41`) the campaign ends with the generic result, cards and finish flow of [node-combat.md](node-combat.md).

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SingleCampaignMapView` (`M3/map/campaign/mediator/singlecampaign/SingleCampaignMapView.as`) | none | Full screen black backdrop, background art `asset.SingleCampaignMapView.map` (1400x900 centered), small map mediator | scene `CAMPAIGN_MAP_SCENE` when `checkPve()` | container |
| `SingleCampaignUIView` (`.../SingleCampaignUIView.as`) | none | 4 card slots and the reward strip | inside the map view | Slot `i` (1..4) shows `getTempInfoByIndex(campaignId, i)` (:61-81). Reward strip from `Campaigns.Item` (:83-103). Refreshes on `UPDATE_SINGLE_CAMPAIGN` (:105-124) |
| `SingleCampaignNpcNode` (`.../SingleCampaignNpcNode.as`) | `NodeName` (e.g. "Lobo Do Pasto", boss "Lobo Maligno") | One card | slot | Pillar, boss glow when `Heros` is not empty (:86-87), challenge button only when `curIndex == Index` (:88), grey filter when `curIndex > Index` (beaten, :89-96). Avatar offset by `Param1`/`Param2` (:108-122) |
| `SingleCampaignNpcAvatarView` (`.../SingleCampaignNpcAvatarView.as`) | `NodeName` | Monster avatar | card | swf `PathManager.solveRolePath(ResPath)` (:80), scaled by `Scale`; name color frame 1 beaten, 3 boss, 2 normal (:72-79) |

## 3. Routes (client to server)

### 3.1 Fight the current card: 8666 C_NEW_SINGLE_CAMPAIGN_FIGHT

| Item | Value |
|---|---|
| UI control | card button `SingleCampaignNpcNode.__challengeClickHandler` (`M3/map/campaign/mediator/singlecampaign/SingleCampaignNpcNode.as:67-70`) |
| Sender | `CampaignSocketOutManager.sendSingleCampaignFight()` (`CM/map/campaign/CampaignSocketOutManager.as:327-331`) |
| Client checks | button visible only on the current card; no anti flood, no Energy check |
| Route | C>S **8666 (0x21da) C_NEW_SINGLE_CAMPAIGN_FIGHT**, no body |
| Server response | battle **157 U_B_PREPARE** (battleType 6 `CAMPAIGN_BATTLE` *(assumption)*), then 156, 153..., 154 and the end report 4103 ([../battle/README.md](../battle/README.md)). On victory push **4282** with the next index. On the boss victory: **137** result, **135** cards, then the client sends 5180 ([node-combat.md](node-combat.md)) |

### 3.2 Leave

Same as every campaign: main bar back button sends **5025** ([generic-routes.md](generic-routes.md)); the server answers **22**.

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **4282 (0x10ba) U_C_NEW_SINGLE_CAMPAIGN** | `simple.PropertyMsg`: `param1 (#1, INT32)` = current card index (1..4; 5 or higher once the boss is beaten *(assumption)*). Other params unused | `CampaignSocketManger.__singleCampaignHandler` (`M3/map/campaign/CampaignSocketManger.as:414, 3200-3210`) | after 125 (initial index, normally 1) and after each card victory | `singleCampaignModel.curIndex = param1` only when `param1` is present (`hasParam1`), then `UPDATE_SINGLE_CAMPAIGN` redraws the cards |
| 125, 21 | `RoomCreatedMsg`, `RoomEnterMsg` | [map-session.md](map-session.md) | instance creation | `CampaignManager.setup(map id)`, solo model |
| 127 | `CampaignNodeListMsg` | `CampaignManager.__campaignDataHandler` | optional | not used by the solo view; send an empty list or none *(assumption)* |
| 157... | battle | battle feature | after 8666 | battle scene, then return to `CAMPAIGN_MAP_SCENE` (`BattleManager.preScene`, `CampaignManager.as:205`) |
| 137, 135, 134 | see [node-combat.md](node-combat.md) | | after the boss | result grade, card draw, exit |

`simple.PropertyMsg` (CM copy): `param1 (#1, INT32)`, `param2 (#2, INT32)`, `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, STRING)`, `param7 (#7, BOOL)`, `param8 (#8, BOOL)`, `param9 (#9, BOOL)`, `param10 (#10, INT32)`, `param11 (#11, INT32)`, `param12 (#12, STRING)` (`CM/com/road/yishi/proto/simple/PropertyMsg.as:300-362`). This differs from `PropertyMsg` in `protocol/proto.json`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Card slots | indices 1..4; `Index 0` rows are hidden | `SingleCampaignUIView.as:61-81` |
| Current card | `curIndex == Index` has the button; `curIndex > Index` is beaten | `SingleCampaignNpcNode.as:88-96` |
| Boss card | `MasterType 41`, always `Index 4`; `Heros` set (e.g. "1011,5" = hero template 1011 at grid position 5) | `SingleCampaignDatas.xml` |
| Monster card | `MasterType 42`; `Soldiers` = "pawnTemplateId,pos" list separated by "|" (e.g. "2011,2\|2011,8") | `SingleCampaignDatas.xml` |
| Missing indices | 12 campaigns have no `Index 3`, many have no `Index 1`/`2`: the slot stays empty. The server must skip to the next existing index *(assumption)* | template statistics: Index 1 x63, 2 x76, 3 x21, 4 x83 |
| `Index 0` rows | 58 rows. *(assumption: extra enemy waves merged into the battle of the next visible card, or unused)* | template |
| EXP per card | `HeroGp` (e.g. 70 for "Lobo Do Pasto") *(assumption: hero EXP granted on the card victory)*; campaign `BaseGp` on completion | `SingleCampaignDatas.xml`, `Campaigns.xml` |
| Battle grid | positions 1..9 per side as in `docs/battle/formation.md` | battle feature |
| Exit buttons after the boss cards | "Sair" only when level < 30, map 4401 or hero difficulty; else "Sair" and "Desafiar novamente" (`ChestFrame`, scene type `SINGLE_CAMPAIGN_MAP_SCENE`) | `CM/map/internals/battle/ChestFrame.as:315-327` |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/SingleCampaignDatas.xml` (301 rows, `SingleCampaignDataTempCate`, lookup `getTempInfoByIndex`, `CM/yishi/datas/templates/cate/SingleCampaignDataTempCate.as:40-51`) | enemy card | `Id` (CampaignId x 100 + n), `CampaignId`, `NodeName`, `MasterType` (41 boss, 42 monster), `Index` (0 hidden, 1..4 slot), `Heros` ("heroTemplateId,pos"), `Soldiers` ("pawnId,pos\|..."), `HeroGp`, `Param1`/`Param2` (avatar offset px), `Scale` (%), `ResPath` (avatar swf, e.g. `monster002A`, `boss010B`) |
| `raw/xml/tempinfos/Campaigns.xml` | campaign | `Item` (reward strip), `BaseGp`, `StandSecond` (result grade) |
| `raw/xml/tempinfos/GameHeroTemp.xml`, `PawnTempInfos.xml` | enemy units | stats for the battle builder |

## 7. Persistent state (schema `campaign`)

The run state is per instance and lives in memory (see `campaign.instance` in [map-session.md](map-session.md)). Persist only what must survive a disconnect:

```sql
CREATE TABLE campaign.solo_trail_run (
  instance_id   bigint   PRIMARY KEY REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  player_id     integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  campaign_id   integer  NOT NULL,
  current_index smallint NOT NULL DEFAULT 1 CHECK (current_index BETWEEN 1 AND 5),
  failed_count  smallint NOT NULL DEFAULT 0 CHECK (failed_count >= 0),
  boss_seconds  integer,
  started_at    timestamptz NOT NULL DEFAULT now()
);
CREATE UNIQUE INDEX solo_trail_run_player ON campaign.solo_trail_run (player_id);
```

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::single_campaign::handle_fight` | 8666 | (1) player is in a solo trail instance; (2) not already in battle; (3) `current_index` has a card row | Build battle type 6 from the card: enemy heroes from `Heros`, soldiers from `Soldiers`, map `MapInfos.BattleGround` of the instance map; player army as usual |
| `campaign::single_campaign::on_battle_end` | battle report | the battle belongs to the run | win: grant `HeroGp` *(assumption)*, advance `current_index` to the next existing index, push 4282. Boss win: compute the grade ([stars-and-sweep.md](stars-and-sweep.md)), send 137, grant `BaseGp`, send 135 cards. Loss: `failed_count + 1`, push 4282 with the same index |

- On instance creation send 4282 `{param1 = 1}` (or the first existing index) right after 125/21 so the button appears.
- Battle config (`docs/battle/server-engine.md` §9.2): `{"battle_type": 6, "map": <MapInfos.BattleGround>, "heroes": [player hero, {"temp_id": <hero id from Heros>, "type": 3 if boss card, "pos": <pos>}], "soldiers": [player soldiers, {"temp_id": <pawn id>, "pos": <pos>} per Soldiers entry]}`.
- `failed_count` and the boss fight duration feed `CampaignReportMsg` (`failed_count`, `endBossTime`).

## 9. Open questions and assumptions

1. Battle type for solo trail fights (6 assumed).
2. Value of `param1` after the boss (5 assumed; the client never reads it after completion because 137 and 134 follow).
3. Role of `Index 0` rows and of campaigns without `Index 1`.
4. Whether `HeroGp` is granted per card or only `BaseGp` per campaign.

## 10. Implementation checklist

- [ ] Loader `SingleCampaignDatas` grouped by `CampaignId` and `Index`
- [ ] Screen check: `SingleCampaignMapView`, `SingleCampaignUIView`, `SingleCampaignNpcNode`, `SingleCampaignNpcAvatarView`
- [ ] Route 8666 -> battle 6 from the card
- [ ] Message 4282 after 125 and after each victory or loss
- [ ] Boss victory -> 137, 135, wait for 5180 ([node-combat.md](node-combat.md))
- [ ] Table `campaign.solo_trail_run`
- [ ] Rule: skip missing indices
- [ ] Test: campaign 1001 (rows with `Index` 1, 0, 0, 4) shows two cards; after the index 1 victory 4282 carries 4
- [ ] Test: reconnect during a run restores `current_index`
