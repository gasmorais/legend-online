# Farm core

Module `farm-core` of feature `farm`. The farm frame, loading own and friend farms, farm level and experience, friend farm states, logs, soil upgrade and plot opening.

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| FMO | `decompiled/core_module/scripts/farm/FarmModel.as` |
| FI | `decompiled/core_module/scripts/farm/data/FarmInfo.as` |
| FLI | `decompiled/core_module/scripts/farm/data/FarmLandInfo.as` |
| FFS | `decompiled/core_module/scripts/farm/data/FriendFarmStateInfo.as` |
| LIDA | `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as` |
| FENF | `decompiled/m3/scripts/farm/FarmEnterNewFrame.as` |
| HF | `decompiled/m3/scripts/farm/newview/HomeFrame.as` |
| FV | `decompiled/m3/scripts/farm/newview/FarmView.as` |
| PV | `decompiled/m3/scripts/farm/newview/PastureView.as` |
| FSSM | `decompiled/m3/scripts/farm/net/FarmSocketSendManager.as` |
| FLL | `decompiled/m3/scripts/farm/view/FarmLandLayer.as` |
| FIV | `decompiled/m3/scripts/farm/view/FarmInfoView.as` |
| PTEV | `decompiled/m3/scripts/water/view/PlayerTreeExpView.as` |
| FFLV | `decompiled/m3/scripts/water/view/FarmFriendListView.as` |

## 1. Overview

The client keeps a `FarmInfo` per user id (`FMO:141-157`). Selecting a user (self by default, or a friend from the list) calls `FMO.defaultSelectedUserInfo` which sends 15044 op 0 for that user (`FMO:186-206`). The server answers 4386 with the whole farm; every later operation answers 4387 with only the changed plots or animals (and pet plots), carrying `op_type` and `result` in each changed `FarmLandInfoMsg` so the client can show the outcome (`FLI:329-338`, see [farmland.md](farmland.md)). Friend farm states (what the player can still do on each friend farm) come in 4190 and at login in 4157.

Plot positions: `pos` 0..17 are farm plots; `pos >= 1000` are pasture animals (`FM:186-206,457-476`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FarmEnterNewFrame` (`FENF`) | "Residência" | hub with 4 buildings: farm, pasture, ship, residence (cat button handler exists but is not wired) | castle building 1509, `gotoFarmFrame` | labels "Fazenda", "Área de Pastagem", navigation title, "Residência" (`FENF:83-86`) |
| `HomeFrame` (`HF`) | "Fazenda" (type 1) / "Área de Pastagem" (type 2) | farm or pasture of the selected user, friend list, buttons: quick harvest, return home, farm shop, "Oficina de magia", "Armazém", switch farm/pasture | `FENF:137-145`; residence map when `showHomeFarmValue != 0` | `FarmView` or `PastureView`, `FarmInfoView`, `FarmFriendListView` (type 2 farm, 3 pasture) (`HF:270-314`) |
| `FarmView` (`FV`) | | 18 plots (`FarmLandLayer`), Yggdrasil (`WaterView`), soil level button | `HF` type 1 | soil level, Magic Spring buff 2 "Colheita da fazenda +{0}%" (`FV:71-85,143-169`) |
| `PastureView` (`PV`) | "Área de Pastagem" | 2 animal areas, marriage tree, capacity board | `HF` type 2 | "Número de animais:{0}/{1}" when farm level >= 5 (`PV:149-165`), buff 2 "Colheita da área de pastagem +{0}%" |
| `FarmInfoView` (`FIV`) | | farm level bar (own) or own experience from friends (friend farm) | `HF` | `PlayerTreeExpView`: level and `gp / next` from UpGrade Types 17 (`PTEV:134-160`), "Nível máximo atingido" |
| `FarmFriendListView` (`FFLV`) | | friends with level >= 12 and a known farm state, pages, icons per possible action | `HF`, residence maps | `FFS` flags |

## 3. Routes (client to server)

All farm operations: C>S 15044 (0x3ac4) `CH_FARM_OPER_CHECK`, `FarmOperReqMsg`:

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `user_id` | #1 | INT32 | never set by the client |
| `friend_id` | #2 | INT32 | farm owner user id (self or friend) |
| `op_type` | #3 | INT32 | `FarmOperateType` |
| `pos` | #4 | INT32 | plot (0..17), animal slot (>= 1000) or pet plot |
| `template_id` | #5 | INT32 | seed or animal template (op 1), constant for pet ops |
| `pay_type` | #6 | INT32 | 0 bound diamonds first, 1 diamonds only (paid ops) |
| `bag_pos` | #7 | INT32 | bag slot of the seed (op 1) or pet id (pet ops) |

### C1. Load a farm (op 0 `QUERY`)
- Sender `FM.sendReqFarmInfo(userId)` (`FM:617-624`), called by `FMO.defaultSelectedUserInfo` on frame open, user change and return home (`FMO:186-206`, `HF:212-217,270-314`).
- Fields: `op_type = 0`, `friend_id` = farm owner.
- Response: 4386 `FarmInfoRspMsg` for that user. Assumption: a friend farm is only served for friends (client lists only friends).

### C2. Request friend farm states
- Sender `FM.reqFriendFarmState(ids)` (`FM:653-663`) from the friend list refresh (`FFLV:235-270`) and after every 15044 operation for the target owner (`FM:650`).
- Route C>S 8231 (0x2027) `C_REQ_FRIEND_FARM_STATE`, `FriendUserIdsMsg`: `friendId (#1, INT32, repeated)`; an empty list is sent as `[0]`.
- Response: 4190 with one `FriendFarmStateMsg` per id.

### C3. Upgrade the soil (op 11 `FARM_LAND_UPGRADE`)
- UI: "Nível do Solo" button on the own farm (`FV:105-121`).
- Client checks: farm level >= 30 else "Função de elevamento de solo disponível após fazenda Nv. 30"; soil level >= 10 -> "Nível máximo do solo atingido".
- Confirm "Consumir {0} diamante para elevar solo ao nível {1}?" with `FarmLand_Points[soil - 1]` (18, 27, 45, 75, 120, 183, 267, 375, 510), alert style `USEBINDPOINT_ALERT` (`FSSM:24-42`).
- Sender `FSSM.sendLandUpCall` (`FSSM:44-60`): `op_type = 11`, `pay_type` 0 (bound first) or 1; `friend_id` unset.
- Response: 4387 (or 4386) with the new `land_grades`; diamonds push 3.

### C4. Quick harvest (op 25 / 26)
- UI: `HF` quick harvest button (`HF:161-187`). Farm tab: collect Yggdrasil fruits if possible (5178) and energize the tree if allowed (15017), then op 25 for the selected farm; pasture tab: op 26. Details in [farmland.md](farmland.md) and [pasture.md](pasture.md).

### C5. Integrity probe answer
- When a 4387 `FarmLandInfoMsg` carries both `param1` and `param2`, the client sends C>S 8598 `C_CC` with `simple.PropertyMsg { param6 (#6, STRING) = param1, param7 (#7, BOOL) = class named by param2 is missing }` (`FM:477-486`). Owned by [account security-code](../account/security-code.md); the farm server never needs to set these fields.

## 4. Server messages (server to client)

### S1. 4386 (0x1122) `U_C_FARM_INFO`, `FarmInfoRspMsg`
Receiver `FM.__getFarmInfoHandler` (`FM:162-170`) -> `readFarmInfoMsg` (`FM:172-269`), event `FARM_CURRENT_USER_CHANGE`.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `user_id` | #1 | INT32 | farm owner |
| `nick_name` | #2 | STRING | owner name |
| `grades` | #3 | INT32 | farm level (0..80) |
| `land_grades` | #4 | INT32 | soil level (1..10) |
| `gp` | #5 | INT32 | farm experience inside the level |
| `total_gp` | #6 | INT32 | unused by the client |
| `today_from_friend_gp` | #7 | INT32 | experience earned today on friend farms (cap 500) |
| `farmLandInfo` | #8 | `FarmLandInfoMsg`, repeated | open plots (pos < 1000) and animal slots (pos >= 1000) |
| `tree_info` | #9 | `TreeInfoMsg` | Yggdrasil of the owner ([yggdrasil.md](yggdrasil.md)) |
| `today_stolen_count` | #10 | INT32 | steals done today by the viewer (client compares with the daily cap) |
| `today_feed_count` | #11 | INT32 | unused (assumption: help feeds today, cap 20) |
| `today_help_reap_livestock` | #12 | INT32 | unused (assumption: help reaps today, cap 100) |
| `petInfo` | #13 | `FarmPetInfoMsg`, repeated | pet practice plots ([pet-practice.md](pet-practice.md)) |
| `guard_pet_info` | #14 | `FarmPetInfoMsg` | guard pet, `pet_id = 0` for none |
| `marriage_tree` | #15 | `MarriageTreeMsg` | couple tree ([marriage-tree.md](marriage-tree.md)) |

`FarmLandInfoMsg` (read field by field with `has*` checks, `FM:276-373`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `user_id` | #1 | INT32 | owner |
| `type` | #2 | INT32 | plot kind (stored, unused; assumption: animal area for pasture) |
| `pos` | #3 | INT32 | plot or animal slot |
| `item_template_id` | #4 | INT32 | seed or animal template, 0 = empty |
| `add_time` | #5 | STRING | planted at "YYYY-MM-DD hh:mm:ss" |
| `feed_time` | #6 | STRING | animals: last feed time (growth start) |
| `mature_time` | #7 | STRING | ripe at |
| `crop_state` | #8 | INT32 | stored, the client derives state from the flags |
| `accelerate_count` | #9 | INT32 | > 0 when already accelerated |
| `stolen_count` | #10 | INT32 | times stolen (max 3) |
| `is_worm` | #11 | BOOL | worms |
| `is_grass` | #12 | BOOL | weeds |
| `is_gloomy` | #13 | BOOL | animal gloomy |
| `is_ill` | #14 | BOOL | animal ill |
| `is_can_reap` | #15 | BOOL | harvestable |
| `is_hunger` | #16 | BOOL | animal hungry |
| `stolenUsers` | #17 | INT32, repeated | users who stole this crop |
| `reward_count` | #18 | INT32 | expected yield (display) |
| `op_type` | #19 | INT32 | operation this update answers |
| `result` | #20 | INT32 | 0 success, 1 failure (`FLI:329-338`) |
| `param1` | #21 | STRING | integrity probe token (C5) |
| `param2` | #22 | STRING | integrity probe class name (C5) |

### S2. 4387 (0x1123) `U_C_FARMLAND_INFO`, `FarmInfoRspMsg`
Receiver `FM.__farmlandUpdateHandler` (`FM:425-517`): applies only changed plots, animals and pet plots of `user_id` (falls back to the selected farm, then to the own farm); `guard_pet_info` when present. Response to every 15044 operation and push to viewers of a farm when it changes (assumption: to the owner when a friend acts, so the owner sees it live). The farm level, soil level and gp are not read from 4387 by this handler; resend 4386 after level changes (assumption).

### S3. 4190 (0x105e) `U_C_CANWATER_USERS`, `LoadFarmRsp`
Receivers `FM.__getFriendFarmStateHandler` (`FM:538-569`) and `FarmMediator` (`decompiled/m3/scripts/map/campaign/mediator/farm/FarmMediator.as:125-155`). Only `friendFarmState (#1)` is read: `FriendFarmStateMsg`:

| Field | Tag | Type | Client flag | Meaning |
|---|---|---|---|---|
| `user_id` | #1 | INT32 | | friend |
| `is_charge_energy` | #2 | BOOL | `canGivePower` | the viewer can still energize this friend's tree today |
| `is_revive` | #3 | BOOL | `canRevive` | a dead crop to revive |
| `is_worm` | #4 | BOOL | `canWorm` | worms to kill |
| `isGrass` | #5 | BOOL | `canWeed` | weeds |
| `isFeed` | #6 | BOOL | `canFeed` | a practicing pet to feed |
| `is_feed_livestock` | #7 | BOOL | `canFeedLivestock` | hungry animal |
| `is_pacify` | #8 | BOOL | `canPacify` | gloomy animal |
| `is_cure` | #9 | BOOL | `canCure` | ill animal |
| `is_plant_reap` | #10 | BOOL | `canFarmSteal` | ripe crop the viewer may steal |
| `is_animal_reap` | #11 | BOOL | `canPastureSteal` | ripe animal the viewer may steal |

### S4. 4157 (0x103d) `U_C_LOAD_WATER`, `LoadFarmRsp` (login)
Receiver `LIDA.__loadFarmHandler` (`LIDA:519-557`), part of the login sequence ([account](../account/README.md)).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `friendFarmState` | #1 | `FriendFarmStateMsg`, repeated | states of all friends (also marks them `isShow` for the friend list) |
| `farm` | #2 | `FarmInfoRspMsg` | own farm (only read when `tree_info` is present) |
| `farmLog` | #3 | `FarmLogRsp`, repeated | log history ([yggdrasil.md](yggdrasil.md)) |

### S5. 145 `U_C_WATERLOG_SEND`
Log line pushes, see [yggdrasil.md](yggdrasil.md).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | hero level >= 12 | `decompiled/m4/scripts/castle/view/CastleBuildingView.as:343-348` |
| Plots | 18; 3 open by default; plot `p >= 3` opens at farm level `(p - 2) * 5` (5, 10, ..., 75) | `FMO:21-25`, `FLL:36-52,125-150` |
| Farm level curve | UpGrade Types 17: Data = gp to reach the grade; grade 1 = 0, 2 = 3, ..., 40 = 150, 41 = 320, ..., 80 = 1700 | `PTEV:134-160`, `UpGradeTempInfos.xml` |
| Level cap | farm level cannot exceed the hero level: experience is cut to the next threshold (`fullExpType 1` "Experiência da fazenda atingiu limite máximo") | `FMO:249-264` |
| Friend experience cap | 500 per day from friend farms (`Farm_TodayFromFriend_GP`), "Limite de experiência em fazenda de amigos atingido" | `FMO:87,266-274` |
| Experience per action | worm, weed, revive: `FarmCrop_Operate_GP` = 1; comfort, cure, feed animal: 1; energize tree and pick fruits: `_expGivePower` / `_expTreePick` (never initialized, 0); harvest: assumption seed `Property4` | `FMO:86,213-248` |
| Soil level | 1..10, unlocks at farm level 30; cost `FarmLand_Points` (diamonds) for soil 1->2 .. 9->10 | `FV:105-121`, `FSSM:24-42` |
| Soil effect | per soil level: maturity time bonus `FarmCrop_Mature_Percent` = 2 %, yield bonus `FarmCrop_Gains_Percent` = 3 % (assumption: linear per level above 1) | `ConfigInfos.xml` |
| Pasture capacity | farm level 5: 3 animals, +1 per 5 levels, max 18 | `farm.anima.animalContentTips` |
| Steal caps | 3 steals per crop (`MAX_STOLEN_COUNT`), one per user; daily `Farm_TodayStolen_Count` = 200 (the client compares with `Farm_TodayFromFriend_GP` by mistake, `FMO:88`) | `FMO:31`, `FLI:308-322` |
| Help caps | `Farm_Today_HelpFeed_Count` 20, `Farm_Today_HelpReap_Count` 100 per day | `ConfigInfos.xml` |
| Pest odds | `farm_harmful_state_config` "30,20,30,20\|10,10,10,10": chance of weeds, worms, gloom, illness and the yield loss % each | `ConfigInfos.xml` |
| Friend list | friends with level >= 12 and a known state | `FFLV:210-232` |
| Castle bubble | any ripe plot or animal of the own farm | `FM:665-687` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `UpGradeTempInfos.xml` Types 17 | farm level | `Grades`, `Data` |
| `UpGradeTempInfos.xml` Types 7 | Yggdrasil energy per farm level | see [yggdrasil.md](yggdrasil.md) |
| `ConfigInfos.xml` | constants | `FarmCrop_Operate_GP` 1, `Farm_TodayFromFriend_GP` 500, `Farm_Accelerate_Point` 10, `FarmLand_Points`, `FarmCrop_Mature_Percent` 2, `FarmCrop_Gains_Percent` 3, `Farm_TodayStolen_Count` 200, `Farm_Today_HelpFeed_Count` 20, `Farm_Today_HelpReap_Count` 100, `Farm_Special_Reward_Percent` 100, `farm_harmful_state_config` |
| `MagicSpringTempInfos.xml` slot 2 | harvest buff | `AddValue` |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS farm;

CREATE TABLE farm.farms (
  player_id            BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  level                SMALLINT NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 80),
  gp                   INTEGER  NOT NULL DEFAULT 0 CHECK (gp >= 0),
  total_gp             BIGINT   NOT NULL DEFAULT 0,
  soil_level           SMALLINT NOT NULL DEFAULT 1 CHECK (soil_level BETWEEN 1 AND 10),
  friend_gp_today      INTEGER  NOT NULL DEFAULT 0,
  steals_today         INTEGER  NOT NULL DEFAULT 0,
  help_feeds_today     INTEGER  NOT NULL DEFAULT 0,
  help_reaps_today     INTEGER  NOT NULL DEFAULT 0,
  counters_day         DATE     NOT NULL DEFAULT current_date,
  created_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE farm.logs (
  log_id         BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player_id      BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  actor_id       BIGINT  REFERENCES player.players(player_id) ON DELETE SET NULL,
  actor_name     TEXT    NOT NULL DEFAULT '',
  log_type       SMALLINT NOT NULL,
  description    TEXT    NOT NULL,
  amount         INTEGER NOT NULL DEFAULT 0,
  adds_friend_gp BOOLEAN NOT NULL DEFAULT false,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX logs_player ON farm.logs (player_id, created_at DESC);
```

Plots and animals: `farm.plots` ([farmland.md](farmland.md)). Friend states are computed, not stored.

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 15044 op 0 | `farm::farm_core::handle_query` |
| 15044 op 11 | `farm::farm_core::handle_soil_upgrade` |
| 15044 dispatcher | `farm::farm_core::handle_oper` (routes by `op_type` to farmland, pasture, pet practice) |
| 8231 | `farm::farm_core::handle_friend_states` |
| login | `farm::farm_core::push_login_data` (4157) |

- Query: create `farm.farms` lazily for level >= 12 players; evaluate plots lazily (growth, pests, death) before serializing; for a friend farm compute `stolenUsers`, `stolen_count` and the viewer's `today_stolen_count`.
- Friend states: for each id compute the 11 flags from that farm's plots against the caller's daily counters (`is_charge_energy` = caller has not energized that tree today and the tree is not full).
- Soil upgrade validation order: own farm -> farm level >= 30 -> soil < 10 -> diamonds per `pay_type` >= `FarmLand_Points[soil - 1]` -> transaction: debit, `soil_level += 1` -> push 3, 4386.
- Level up: after adding gp loop on Types 17; on each new level open plots per the `(p - 2) * 5` rule and pasture slots per the capacity rule (send 4386 so the client receives the new plots, `LAND_OPEN` events `FI:139-155`).
- Daily reset of the per day counters at 00:00 server time (lazy on first access).
- Pushes to other players: when a friend acts on a farm, push 4387 to the owner if online and refresh 4190 for the actor.

## 9. Open questions and assumptions

- Assumption: harvest experience equals seed `Property4` (20, 80, 240 for 1 h, 4 h, 12 h seeds).
- Assumption: soil bonuses are linear per level.
- Assumption: `today_feed_count` and `today_help_reap_livestock` map to the help caps.
- Gap: the client compares steals against `Farm_TodayFromFriend_GP` (500) instead of `Farm_TodayStolen_Count` (200); the server must enforce 200.
- Gap: `_expGivePower` and `_expTreePick` are never set in the client, so it predicts 0 experience for tree actions; the server decides.

## 10. Implementation checklist

- [ ] Screens (client ready): `FarmEnterNewFrame`, `HomeFrame`, `FarmView`, `PastureView`, `FarmInfoView`, `PlayerTreeExpView`, `FarmFriendListView`, `FarmFriendItem`.
- [ ] Route 15044 op 0 -> 4386.
- [ ] Route 8231 -> 4190.
- [ ] Route 15044 op 11 -> 3, 4386.
- [ ] Login push 4157.
- [ ] Messages 4386, 4387, 4190, 4157.
- [ ] Tables `farm.farms`, `farm.logs`.
- [ ] Rules: level curve and hero cap, friend gp cap, plot opening, pasture capacity, daily counters.
- [ ] Tests: level 11 player cannot load a farm; soil upgrade at farm level 29 refused; 9th soil upgrade costs 510; reaching farm level 10 opens plot 4; friend gp stops at 500.
