# Sky treasure flight ("Tesouro do Céu")

Module `sky-treasure-flight` of feature `treasures`. Older time limited event: charge action energy with "Pedra de Fonte de Energia" (208049), fly up hitting boxes, rank by height ("Pontos"), collect height rewards.

Path aliases:

| Alias | File |
|---|---|
| STM | `decompiled/core_module/scripts/yishi/manager/SkyTreasureManager.as` |
| STV | `decompiled/core_module/scripts/mvc/module/skytreasure/info/SkyTreasurePlayerVO.as` |
| SKF | `decompiled/m11/scripts/skytreasure/SkyTreasureFrame.as` |
| SCV | `decompiled/m11/scripts/skytreasure/view/SkyTreasureCenterView.as` |
| SBV | `decompiled/m11/scripts/skytreasure/view/SkyTreasureBagView.as` |
| SBM | `decompiled/m11/scripts/skytreasure/SkyTreasureBoxManager.as` |

## 1. Overview

The frame shows a sky with a ball (the player) and boxes that scroll past. the start button starts the flight; every box that collides with the ball costs 1 action energy and sends a hit; when energy reaches 0 the flight finishes. the speed up button ends the flight at once, consuming all remaining energy for points. the charge button consumes 1 energy stone, the advanced charge button consumes 50 stones. The player's height is his score; rewards unlock by height (type 1 rewards) and by final rank (other type). The bag area lists unlocked height rewards and the collect button takes them.

Status: the frame (style `skytreasure.frame`, class `SkyTreasureFrame`) is reachable only through controller `skytreasure` (`decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1650-1651`); no button, NPC or link opens it in this client. 4769 also calls `TopToolsBar.instance.show()` (STM:258).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SkyTreasureFrame` (SKF) | "Tesouro do Céu" | container, activity time, my height and rank, reward tip, help "Instruções de Pesquisa do Céu" | controller `skytreasure` | "Tempo do evento:{0} até {1}" (SKF:89-96), height and rank (SKF:135-142); closes when `isOpen` false (SKF:167-174); close blocked while flying (SKF:176-184) |
| `SkyTreasureCenterView` (SCV) | | flight area and buttons | inside SKF | "Pedras da energia restantes:{0}" (SCV:79), "Valor de Movimento: {0}" (SCV:259-262) |
| `SkyTreasureBagView` (SBV) | | unlocked height rewards and the collect button | inside SKF | rewards with `statu == 1` and `height >= param` (SBV:110-130) |
| `SkyTreasureBoxView`, `SkyTreasureRankView`, `SkyTreasureRankShowView` | "Ranking", "Nome", "Pontos" | reward ladder, top list, rank reward tip | inside SKF | `chargeRewardList`, `rankList`, `ranRewardsList` |

## 3. Routes (client to server)

All use C>S 8966 (0x2306) `C_TREASURE_HUNT_OPTION` with `TreasureHuntOpMsg` (package `active`): `opType (#1, INT32)`, `feedType (#2, INT32)` charge kind, `packageId (#3, STRING)` never set by this client.

| op | Constant (STM:60-80) | UI / trigger | Sender | Client checks | Expected response |
|---|---|---|---|---|---|
| 3 | `REQUEST_ACTIVE` | frame constructor | `getActivesInfo` (STM:452-458), SKF:75 | none | 4769 |
| 4 | `REQUEST_RANK` | frame constructor | `getRanksInfo` (STM:460-466), SKF:76 | none | 4770 |
| 1, feedType 1 | `CHARGE` / `COMMON_CHARGE` | the charge button (SCV:283-297) | `commonCharge` (STM:434-441) | not flying ("Durante o voo, ignorar as outras operações..."), stones >= 1 else "Pedras da energia insuficientes" | 4769 with new `actionEnergy` (assumption) |
| 1, feedType 2 | `SENOIR_CHARGE` | the advanced charge button + confirm "Deseja consumir 50 {0} para energizar 50 vezes?" (SCV:299-328) | `senoirCharge` (STM:443-450) | not flying, stones >= 50 | 4769 |
| 8 | `START` | the start button (SCV:120-142) | `sendStart` (STM:492-498) | `actionEnergy > 0` else "Valor de Movimento insuficiente, ..." | none required |
| 5 | `HIT_BOX` | box collision in `enterFrame` (SCV:175-226) | `sendHitBox` (STM:468-474) | flying, energy > 0; client decrements energy locally | 4956 `param = 5` |
| 7 | `FINISH` | energy reached 0 after a hit (SCV:221-225) | `sendFinish` (STM:484-490) | | 4956 `param = 7` |
| 6 | `SPEEDUP` | the speed up button (SCV:154-163) | `sendSpeedup` (STM:476-482) | flying | 4956 `param = 6` with `crashScore` |
| 2 | `GETREWARD` | the collect button (SBV:138-146) | `getBoxGoods` (STM:426-432) | none | bag update and 4769 with `statu` changed |

## 4. Server messages (server to client)

### S1. 4769 (0x12a1) `U_C_TREASURE_HUNT_ACTIVE_INFO`, `TreasureHuntActiveMsg`
Receiver `STM.__skyTreasureHandler` (STM:232-355).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `active_id` | #1 | STRING | activity id |
| `begin_date` | #2 | STRING | "YYYY-MM-DD hh:mm:ss" |
| `end_date` | #3 | STRING | same format |
| `isOpen` | #4 | BOOL | false closes the frame |
| `joinInfo` | #5 | `PlayerJoinInfoMsg` | `height (#1, INT32)` score, `rank (#2, INT32)`, `actionEnergy (#3, INT32)` |
| `rewards` | #6 | `RewardInfoMsg`, repeated | `packageId (#1, STRING)`, `items (#2, ItemInfoMsg {templateId #1, count #2}, repeated)`, `type (#3, INT32)` 1 = height reward else rank reward, `param (#4, INT32)` height threshold or rank, `statu (#5, INT32)` 1 = unlocked not collected (assumption: 0 locked, 2 collected) |

Client sorts both reward lists by `param`. The difference between the new and old `height` becomes the displayed integral (STV:updateHeightAndIntegral).

### S2. 4770 (0x12a2) `U_C_TREASURE_HUNT_RANK_INFO`, `TreasureRankMsg`
Receiver STM:396-419. `rankInfos (#1, PlayerRankMsg, repeated)`: `userId (#1, INT32)`, `nickname (#2, STRING)`, `height (#3, INT32)`, `rank (#4, INT32)`.

### S3. 4956 (0x135c) `U_C_TREASURE_HUNT_CRASH_SCORE`, `PlayerCrashInfoMsg`
Receiver STM:191-225. `height (#1, INT32)` new height (always applied), `crashScore (#2, INT32)` points gained, `param (#3, INT32)`:

| param | Client reaction |
|---|---|
| 5 | hit result: integral = crashScore, rank view refresh |
| 6 | speed up result: alert "A aceleração consumirá {0}, valor de movimento, obtém {1} pontos.", energy set to 0 (SCV:264-276) |
| 7 | flight finished |
| 9 | activity ended: `isOpen = false`, frame closes |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Normal charge | 1 stone 208049 -> energy (assumption: +1, stone `Property1` = 10 may be the energy per stone) | SCV:283-297, `ItemTempInfos.xml` 208049 |
| Advanced charge | 50 stones | SCV:304-310, `activity.skytreasure.center.seniorchargeTip` |
| Hit cost | 1 energy per box | STV:useActionEnergy, SCV:216-226 |
| Box spawn | client timer every 600 ms | SBM:42-50 |
| Speed up | consumes all remaining energy, returns crashScore | SCV:154-163, 264-276 |
| Points per hit / speed up | server side (unknown) | open question |

## 6. Templates

None in XML. Rewards and activity window come from the server (4769).

## 7. Persistent state

```sql
CREATE TABLE treasures.flight_activities (
  activity_id     TEXT PRIMARY KEY,
  begins_at       TIMESTAMPTZ NOT NULL,
  ends_at         TIMESTAMPTZ NOT NULL
);

CREATE TABLE treasures.flight_rewards (
  package_id      TEXT PRIMARY KEY,
  activity_id     TEXT NOT NULL REFERENCES treasures.flight_activities(activity_id) ON DELETE CASCADE,
  reward_type     SMALLINT NOT NULL,
  threshold       INTEGER NOT NULL,
  items           JSONB NOT NULL
);

CREATE TABLE treasures.flight_players (
  activity_id     TEXT NOT NULL REFERENCES treasures.flight_activities(activity_id) ON DELETE CASCADE,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  height          INTEGER NOT NULL DEFAULT 0,
  action_energy   INTEGER NOT NULL DEFAULT 0 CHECK (action_energy >= 0),
  flying          BOOLEAN NOT NULL DEFAULT false,
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (activity_id, player_id)
);
CREATE INDEX flight_players_rank ON treasures.flight_players (activity_id, height DESC, updated_at);

CREATE TABLE treasures.flight_reward_claims (
  activity_id     TEXT NOT NULL,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  package_id      TEXT NOT NULL REFERENCES treasures.flight_rewards(package_id) ON DELETE CASCADE,
  claimed_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, package_id)
);
```

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 3 | `treasures::sky_treasure_flight::handle_active_info` |
| 4 | `treasures::sky_treasure_flight::handle_rank` |
| 1 | `treasures::sky_treasure_flight::handle_charge` |
| 8 | `treasures::sky_treasure_flight::handle_start` |
| 5 | `treasures::sky_treasure_flight::handle_hit_box` |
| 6 | `treasures::sky_treasure_flight::handle_speed_up` |
| 7 | `treasures::sky_treasure_flight::handle_finish` |
| 2 | `treasures::sky_treasure_flight::handle_collect` |

- Anti cheat: the client decides collisions; cap hits per second (box every 600 ms) and require `flying`.
- At activity end push 4956 `param = 9` to online participants, mail rank rewards.

## 9. Open questions and assumptions

- Entry point missing in this client; implement only if an opener is added.
- Energy per stone, points per hit, height formula unknown.
- `statu` values other than 1 are assumptions.

## 10. Implementation checklist

- [ ] Screen `SkyTreasureFrame` with center, bag, box and rank views
- [ ] Route 8966 ops 1..8
- [ ] Server messages 4769, 4770, 4956 (params 5, 6, 7, 9)
- [ ] Tables `treasures.flight_*`
- [ ] Activity end job and rank rewards
- [ ] Tests: energy accounting, hit rate cap, reward unlock by height
