# Bloody realm ("Inferno Sangrento")

Aliases:

| Alias | File |
|---|---|
| BMG | `decompiled/m3/scripts/map/campaign/mediator/bloody/BloodyManager.as` |
| BSO | `decompiled/m3/scripts/map/campaign/view/ui/bloody/BloodySocketOut.as` |
| PEV | `decompiled/m3/scripts/map/campaign/view/ui/bloody/PoundEggView.as` |
| EIV | `decompiled/m3/scripts/map/campaign/view/ui/bloody/EggItemView.as` |
| BBX | `decompiled/m3/scripts/map/campaign/view/ui/bloody/BloodyBox.as` |
| CSM | `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as` |
| CMG | `decompiled/core_module/scripts/map/campaign/CampaignManager.as` |
| CMC | `decompiled/m3/scripts/map/campaign/CampaignMapController.as` |
| RSM | `decompiled/m3/scripts/map/campaign/mediator/randomboss/RandomShaiziManager.as` |
| IRV | `decompiled/m9/scripts/room/view/pve/instance/InstanceRightView.as` |

## 1. Overview

A team PvE instance (up to 4 players, cross-server matchmaking through the room hall) on map 9996 "Inferno Sangrento" (`MapInfos.xml`, `WorldBossHelper.checkBloody`, `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as:295-298`). Room text (`room.InstanceRightView.bloodyContent`): waves of creatures, killing the boss gives big rewards; each wave can be exchanged for a BUFF using material dropped by monsters; the BUFF can be changed during the fight; the "Demônio Sanguinário do Inferno" is challenged in groups, monsters refresh randomly. Rewards: 1 time per week ("Pode obter ganhos 1x por semana no Inferno Sangrento").

Specific to this module: the egg minigame between waves. After a wave, a window with 12 eggs opens for 30 s; each player smashes one egg and gets a grade (iron, copper, silver, gold); then reward boxes fall next to the spawn point for 30 s and players pick them up by walking over them. The instance reuses the dragon (Molong) timer and random boss buff systems (`RSM` extends `MolongManager`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Room hall instance panel (IRV) | "Pode obter ganhos 1x por semana no Inferno Sangrento", count "{rest}/{max}" | Select the instance | room hall ([../campaign/README.md](../campaign/README.md)) | `randomBossCount` = `PlayerMsg.bloodyRealmCampaignCount (#133)`, `randomBossMaxCount` = `#134` (`PlayerManager.as:1129-1133`, `IRV:551-557`) |
| Map 9996 (`CampaignMapView`) | | Waves, boss, buffs (random boss UI), wave timer | campaign start | 335, 4665, 4945 |
| `PoundEggView` (PEV), controller `bloodyControl` | "O jogador pode clicar nos 12 ovos abaixo, cada jogador apenas tem uma chance de quebrar um ovo. Após quebrar tem a chance de obter ovo de ouro, prata, bronze e 4 tipos de pintinhos." | 12 eggs in a 4 x 3 grid (`PEV:86-100`), 30 s countdown (`PEV:66-82`), auto close 3 s after boxes fall | first 333 of a wave (`BMG:268-281`) | other players' eggs placed randomly, own egg at the clicked index (`PEV:139-165`) |
| `BloodyBox` (BBX) | | Box on the map near the spawn point (offsets (10, -60) and (10, 60), `BMG:65`), map physics by son type | 334 | box type 2201 iron, 2202 copper, 2203 silver, 2200 gold, 2210 (source 1) (`BMG:81`) |
| Box countdown | | 30 s (`BMG:397-398`) | 334 | |

## 3. Routes (client to server)

### R1. Smash an egg

- UI: click on an egg (`EIV:72-82`).
- Client checks: only the first click per wave (`myClickEggIndex == -1`).
- Sender: `BloodySocketOut.poundEgg` (`BSO:15-21`).
- Route: C>S 9588 (0x2574) `C_CAMPAIGN_BLOODY_REALM_POUND_EGG`, body `bloodyrealm.EggInfoMsg` with no field set.
- Response: S1 333 broadcast to the instance.

### R2. Pick up a box

- UI: walking; when the own army is within 80 px of a box (`BMG:205-243`).
- Client checks: `GlobalConfig.isGet` (weekly gains not used yet, set from the campaign start, `CMG:577`) else tip "Hoje você já obteu ganhos, não poderá coletar mais." once; each box id once.
- Sender: `BloodySocketOut.pickUpBox(id)` (`BSO:23-30`).
- Route: C>S 9589 (0x2575) `C_CAMPAIGN_BLOODY_REALM_PICKUP_EGG`, `bloodyrealm.EggInfoMsg`: `id (#1, INT32)` = box id (1 or 2).
- Response: S2 334 with the box `status = true`; item grant.

## 4. Server messages (server to client)

`EggInfoMsg`: `id (#1, INT32)`, `state (#2, ENUM EGG_STATE)`, `source (#3, INT32)`, `status (#4, BOOL)`. `EGG_STATE`: 0 `NONE`, 1 `IRON`, 2 `COPPER`, 3 `SILVER`, 4 `GLOD` (`decompiled/core_module/scripts/com/road/yishi/proto/bloodyrealm/EGG_STATE.as`).

### S1. 333 (0x014d) `U_C_CAMPAIGN_POUND_EGG_MSG`

`bloodyrealm.PoundEggMsg`: `campaign_id (#1, INT32)`, `current_ware (#2, INT32)` wave, `expire_time (#3, INT64)` window end, `state (#4, EggStateMsg, repeated)` with `user_id (#1, INT32)` and `state (#3, ENUM EGG_STATE)`. Receiver `CSM.bloodyRollResult` (`CSM:2099-2135`): ignored unless the caller's `user_id` is in the list; stores `bloodyRollInfos`, wave and expiry, opens PEV for a new wave, animates eggs with `state > 0`. When: at wave end with all `state` 0 (opens the window, the caller must be listed), then after each smash with the updated list.

### S2. 334 (0x014e) `U_C_CAMPAIGN_POUND_EGG_FINISHED_MSG`

`bloodyrealm.PickupEggMsg`: `campaign_id (#1, INT32)`, `current_ware (#2, INT32)`, `expire_time (#3, INT64)`, `eggInfo (#4, EggInfoMsg, repeated)`. Receiver `CSM.bloodyFallBoxResult` (`CSM:2137-2181`): if no box has `status` true, every box falls (`FALL_BOXES`, `BMG:373-399`, position by `id`, type by `state`, 2210 when `source == 1`); otherwise boxes with `status` true are reported picked (`BOX_HAS_PICK`). When: when the egg window closes (30 s) and after each pickup.

### S3. 335 (0x014f) `U_C_CAMPAIGN_BLOODY_REALM_INFO_MSG`

`bloodyrealm.BloodyRealmCampaignInfoMsg`: `campaign_id (#1, INT32)`, `current_ware (#2, INT32)`. Receivers `CMG.bloodyRealmInfoHandle` (`CMG:224-235`) and `CSM.bloodyRealmInfoHandle` (`CSM:2183-2194`): store the wave, notify `RANDOM_CAMPAIGN_WAVE_CHANGE` / `RANDOM_CAMPAIGN_UPDATE_TIME`; a new wave resets the egg grid. When: on instance entry and at each wave start.

Shared messages (owned elsewhere): 4665 `U_C_DRAGON_CAMPAIGN_INFO` `campaign.DragonCampaingnDataMsg` (`type #1`, `campaignTm #2` remaining ms, `stateTm #3`, `state #4` (2, 3, 5 egg window, 4 boxes on ground), `cur_round #5`, `rollInfos #6`, `boxInfos #7` (`userId #1`, `boxId #2`, `statu #3`), `param1 #8`, `param2 #9`) used for reconnection (`BMG:149-203`, `BMG:314-356`, `CSM:2085-2097`); 4945 `U_C_RANDOMBOSSBUFF` `RandomBossBuffefMsg` (`turn #1`, `buffs #2`). See [../trials/README.md](../trials/README.md) (Molong) and [../campaign/README.md](../campaign/README.md).

## 5. Rules and formulas

- Map 9996; campaign template with `SonTypes == 304` and `AreaId == 304` (`CampaignTemplate.as:140-147`, `CMC:499-502`, `CampaignTemplateManager.as:219`). **No campaign row with SonTypes or AreaId 304 exists in `raw/xml/tempinfos/Campaigns.xml`**, so the room hall cannot list the instance with this data.
- Weekly gains: 1 per week (room text); counters `bloodyRealmCampaignCount` / `MaxCount` in player info 3.
- Egg window 30 s, boxes stay 30 s; one egg per player per wave; 12 eggs; 2 box positions.
- Egg grade probabilities and box contents: not in the client (open).
- Battle type 3854 `BLOODY_REALM_BATTLE` for wave fights (`BattleType.as:146`).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/MapInfos.xml` | 9996 "Inferno Sangrento", 2000 x 2000, `BattleGround` 4 |
| `raw/xml/tempinfos/Campaigns.xml` | missing rows for area 304 |
| map physics son types 2200, 2201, 2202, 2203, 2210 | box graphics (`PathManager.solveMapPhysicsBySonType`, `BBX:38-41`) |

## 7. Persistent state

```sql
CREATE TABLE cross_server.bloody_realm_weekly (
    player_id   bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    week_start  date     NOT NULL,
    runs        smallint NOT NULL DEFAULT 0,
    gains_taken smallint NOT NULL DEFAULT 0 CHECK (gains_taken BETWEEN 0 AND 1),
    PRIMARY KEY (player_id, week_start)
);
```

Instance, waves, eggs and boxes are in memory.

## 8. Backend implementation notes

- Instance start (room start 5039, campaign feature) on map 9996; set `isNoGet` in the start message when `gains_taken = 1` (drives `GlobalConfig.isGet`).
- Wave end: push 335 with the next wave, then 333 with every member at `state` 0 and `expire_time` = now + 30 s.
- `cross_server::bloody_realm::handle_pound_egg` (9588): instance member, window open, not smashed this wave. Roll the grade, push 333 to all members.
- Window end: build up to 2 boxes from the grades (assumption: best grade of the team, `source` 1 for a special box), push 334, keep 30 s.
- `cross_server::bloody_realm::handle_pickup` (9589): box exists, not picked, player close enough (server check optional), weekly gains available. Transaction: grant box rewards, mark picked, increment `gains_taken` on the final boss reward (assumption); push 334.

## 9. Open questions and assumptions

- Open: missing campaign template for area 304.
- Open: egg grade odds, box contents, wave count.
- Assumption: box generation rule and who can pick (any member, first come).

## 10. Implementation checklist

- [ ] Instance on map 9996 with waves.
- [ ] Routes 9588, 9589.
- [ ] Server messages 333, 334, 335 (plus shared 4665, 4945).
- [ ] Table `cross_server.bloody_realm_weekly`.
- [ ] Tests: second smash in the same wave refused; pickup without weekly gains refused; reconnect during the egg window restores PEV through 4665.
