# Lost treasure maps ("Tesouro Perdido")

Module `treasure-map` of feature `treasures`.

Path aliases:

| Alias | File |
|---|---|
| TMM | `decompiled/core_module/scripts/managers/TreasureMapManager.as` |
| TMS | `decompiled/core_module/scripts/managers/TreasureMapSocketOutManager.as` |
| TMO | `decompiled/core_module/scripts/mvc/module/treasuremap/TreasureMapModel.as` |
| TMC | `decompiled/core_module/scripts/mvc/controler/TreasureMapFrameController.as` |
| TGF | `decompiled/m3/scripts/map/internals/view/treasuremap/TreasureMapGetFrame.as` |
| TUF | `decompiled/m3/scripts/map/internals/view/treasuremap/TreasureMapUseFrame.as` |
| TGI | `decompiled/m3/scripts/map/internals/view/treasuremap/getframe/TreasureMapGetItemView.as` |
| SAH | `decompiled/m3/scripts/map/space/helper/hero/SpaceArmyViewHelper.as` |
| NVD | `decompiled/m3/scripts/map/campaign/view/frame/NewbieVillageDialogFrame.as` |
| COV | `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as` |

## 1. Overview

Every day the player can collect `join_tremap_count` (5) treasure maps and earn rewards `reward_tremap_count` (5) times (help text: "Pode coletar 5 mapas do tesouro diariamente, obtendo 5 prêmios, todos os dias às 0h da manhã será redefinido"). At the NPC option the server offers a ladder of 4 map qualities (`templateIds[0..3]`, items 2190001 Bronze, 2190002 Ferro, 2190003 Prata, 2190004 Ouro). `index` is the current quality. the refresh button pays diamonds or Baiding wine (208050, 1 wine = 5 diamonds) to try to upgrade the quality; the quick refresh button pays more to jump straight to orange (index 3). the collect button gives the map item of the current quality.

The map item stores a hidden location (map id in `randomSkill1`, x in `randomSkill2`, y in `randomSkill3`). Using it near the spot (or paying `treasure_imm_battle` = 10 diamonds to "Escavar tesouro já") starts a guardian battle (battle type 291 `TREASUREMAP_BATTLE`, see `docs/battle/hud.md`). Rewards scale with team size and map quality; the opener of an orange map gets more. Team members without a map may join the fight; members over their reward count fight without rewards ("Ladrões do Tesouro" give extra rewards).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `TreasureMapGetFrame` (TGF) | "Tesouro Perdido" | choose quality, refresh, collect | controller `treasuremap` without `openType` (TMC:28-39) from space node option 13 (SAH:208-209) | 4 `TreasureMapGetItemView` cells (discarded below `index`, selected at `index`, TGF:213-249), name of `templateIds[index]`, "restantes / max" = `joinMax - joinCount` / `joinMax` (TGF:223), refresh tips with costs |
| `TreasureMapUseFrame` (TUF) | map name (`MapTemplate.MapName`) | show a 3x3 mini map tile with a flag and "Escavar tesouro já" | controller `treasuremap` `openType = 2` with `frameData` GoodsInfo (TMC:20-37); no caller sets `openType = 2` in this client | tile `asset.treasuremap.map{mapId}{cell}`, flag position (TUF:369-414) |
| `MarryTaskMapFrame` (m9) | | same mini map for SonType 320 marriage task items; reuses `TMM.checkTreasureMap` | item use (TMM:114-132) | see [marriage](../marriage/README.md) |
| Task trace tip `TreasureMapTipView` (m16) | "Pesquisar Tesouro", "Obteu {0}" | after a map is obtained, highlight it in the bag | `TaskTraceTipManager` type 36 (`decompiled/core_module/scripts/managers/TaskTraceTipManager.as:809-810`) | item name |
| Alert on 4634 | "Você encontrou o tesouro, confirme se a sua equipe está com você, ou poderá perder parte do ganho" | confirm or cancel the dig | TMM:72-80 | |

The NPC option text is rewritten as "{0} (Quantidade de ganho {1} / {2})" with `rewardMax - rewardCount` and `rewardMax` (NVD:277-281). `DayGuideManager` shows `rewardCount` as daily progress (`decompiled/core_module/scripts/managers/DayGuideManager.as:266`).

## 3. Routes (client to server)

All routes use C>S 8744 (0x2228) `C_TREASUREMAP_OP` with `PlayerTreasureMsg` (package `treasuremap`):

| Field | Tag | Type | Meaning in requests |
|---|---|---|---|
| `user_id` | #1 | INT32 | unused in requests |
| `join_count` | #2 | INT32 | unused |
| `reward_count` | #3 | INT32 | unused |
| `index` | #4 | INT32 | bag position of the map item (ops 3, 4, 5) |
| `templateIds` | #5 | INT32, repeated | unused |
| `op_type` | #6 | INT32 | operation, `TMO:7-17` |
| `pay_type` | #7 | INT32 | 0 = may use bound diamonds (`giftToken`), 1 = diamonds only (TMS:24-38, 49-63) |
| `refresh_type` | #8 | BOOL | op 2: false = normal refresh, true = quick refresh to orange |
| `is_reward` | #9 | BOOL | op 4: answer of the 4634 alert |
| `is_firstQuest`, `is_firstGet`, `is_firstUse` | #10..#12 | BOOL | unused in requests |

### R1. Open the get frame (op 6 `REQUEST_TREASUREMAP`)
- Trigger: `TreasureMapGetFrame` constructor, `TMS.sendRequestTreasureMap` (TMS:16-22), called at TGF:81.
- Client checks: on `show`, if `joinCount == joinMax` shows "Já coletou todos os maps do tesouro do dia" and closes (TGF:424-432).
- Response: 4633 with the full state.

### R2. Refresh quality (op 2 `REFRESH`, `refresh_type = false`)
- UI: the refresh button button (TGF:338-356). First use pops `worldboss.RiverNotAlert` "consumir {0} diamantes para elevar a qualidade do mapa do tesouro (Vinho de Baiding prioritário)" with a "use bound" checkbox; "do not ask again" persists in `SharedManager.refreshRewardNotAlert` / `refreshRewardUseBind` (TGF:360-366).
- Client checks (TGF:379-404): enabled only when `index < 3` and `joinCount < joinMax` (TGF:253-262); funds = `point + wine(208050) * 5 (+ giftToken if pay_type 0)` must be >= `Property3(templateIds[index]) * 5`, else `RechargeAlertMannager.show()`.
- Sender `TMS.sendRefreshTreasureMap(false, useBind)` (TMS:24-39).
- Server: consume Baiding wine first (`Property3` of current quality), then diamonds for the rest, roll an upgrade of `index` (assumption: per quality chance from item template; see section 5), push 4633.

### R3. Quick refresh to orange (op 2, `refresh_type = true`)
- UI: the quick refresh button (TGF:317-335), alert "Consumindo {0} diamantes irá elevar o mapa do tesouro para laranja (Vinho de Baiding prioritário)". The button glows until clicked when `isFirstQuest` is false (TGF:262-264).
- Cost: `treasure_refresh_item` (8) wine or `8 * 5 = 40` diamonds (`treasure_refresh_points` = 40) (TGF:77-78).
- Server: set `index = 3`, push 4633.

### R4. Collect the current map (op 1 `GET_TREASUREMAP`)
- UI: the collect button (TGF:289-305). If the player has no full free team and has not ticked "do not ask", alert "Deseja coletar o mapa do tesouro da qualidade atual?" (TGF:294-299); flag in `SharedManager.receiveMapFlag` (TGF:308-315).
- Client check: `joinCount < joinMax`.
- Server: give item `templateIds[index]` with a random hidden location (`randomSkill1` map id, `randomSkill2` x, `randomSkill3` y in map tiles, `randomSkill5` expiry flag), `joinCount += 1`, reset `index = 0` and roll a new ladder (assumption), push the bag update (115) then 4633. The task trace tip type 36 should be pushed (see [inventory](../inventory/README.md)).

### R5. Use the map at the spot (item use)
- UI: bag "Usar" on the map item. For SonType 320 the client calls `TMM.useTreasureMap` (TMM:114-132): if the item is expired (`randomSkill5 == 1`) "outDateGoods" tip (`decompiled/core_module/scripts/cell/view/GoodsItemMenu.as:291-298`); `checkTreasureMap` (TMM:142-200) checks scene map id equals `randomSkill1` and Chebyshev distance in pixels <= 15*20; otherwise shows "O tesouro está longe de você {0}" (> 1600 px), "O tesouro não está longe {0}" (> 800 px), "O tesouro está perto, encaminhe {0} e tente" (> 300 px) with an 8 way direction (TMM:218-258).
- The only live sender in this client is `MarrySender.useTaskGoods(pos)` (C>S 8774 `C_MARRIAGE_OP` op 2004, `decompiled/core_module/scripts/mvc/module/marry/MarrySender.as:60-67`) because the bag dispatch only covers SonType 320. Maps 2190001..2190004 have SonType 208 and no client use path.
- Intended route (dead code): op 5 `USE_TREASUREMAP` with `index = bag pos`, sender `TMS.sendUseTreasureMap` (TMS:66-73), called only from the private unused `TMM.digBtnAlertCallBack` (TMM:134-140).
- Server: validate location, start guardian battle (section 8), or push 4634 to ask for the team confirmation.

### R6. Dig immediately (op 3 `EXCAVATEIMM`)
- UI: `TreasureMapUseFrame` "Escavar tesouro já" (TUF:172-193). Allowed scenes: `SPACE_SCENE` or a pet land campaign map (`WorldBossHelper.checkPetLand`), else "Não pode escavar agora tesouro deste mapa" (TUF:195-214). Confirm "Deseja consumir {0} diamantes para escavar o tesouro imediatamente (equipe de {1} pessoas podem obter mais prêmios)" with `treasure_imm_battle` = 10 and 4 (TUF:182-186); funds `point (+ giftToken)` >= 10, else recharge (TUF:228-250). Button disabled when `rewardCount >= rewardMax` (TUF:216-226).
- Sender `TMS.sendDigTreasureMap(pos, useBind)` (TMS:49-64), `index = pos`.
- Server: charge 10 diamonds, consume the map, start the guardian battle, push 4633.

### R7. Confirm the reward / battle (op 4 `CONFIRM_GET_REWARD`)
- Trigger: answer to 4634 (TMM:82-92), `index = model.lastTreasureMap.pos`, `is_reward = true` on confirm, `false` on cancel. Note `lastTreasureMap` is never assigned in this client, so the client throws when it answers (gap).
- Server: true -> start the guardian battle with the current team (assumption), false -> abort and keep the map (assumption).

### R8. Reinforce a team mate (8745 `C_TREASUREMAP_BATTLE_REINFORCE`)
- Chat reinforce link (type 21) stores `reinforceTarget` and walks to it (COV:1165-1192); on arrival `TMM.checkReinforce` (TMM:300-359) returns true when in team, same map and distance < 40 px. No packet is sent by this client; 8745 has no sender. Open question.

## 4. Server messages (server to client)

### S1. 4633 (0x1219) `U_C_TREASUREMAP_INFO`, `PlayerTreasureMsg`
Receiver `TMM.__treasureMapInfoHandler` (TMM:57-70), dispatches `TREASURE_INFO_UPDATE`.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `user_id` | #1 | INT32 | player id (ignored) |
| `join_count` | #2 | INT32 | maps collected today |
| `reward_count` | #3 | INT32 | rewards earned today |
| `index` | #4 | INT32 | current quality index 0..3 |
| `templateIds` | #5 | INT32, repeated | exactly 4 map template ids, low to high quality |
| `op_type`, `pay_type`, `refresh_type`, `is_reward` | #6..#9 | | ignored |
| `is_firstQuest` | #10 | BOOL | false -> quick refresh button glows |
| `is_firstGet` | #11 | BOOL | stored only |
| `is_firstUse` | #12 | BOOL | false and not `SharedManager.isUsedTreaSureMap` -> team guide `treasuremap.NewGuildFrame` on the use frame (TUF:425-435) |

When: answer to every 8744 op, at login (assumption, `DayGuideManager` and the NPC title read the counters) and at the daily reset.

### S2. 4634 (0x121a) `U_C_TREASUREMAP_REWARD`
No body is read (TMM:72-80). Client shows "Você encontrou o tesouro, ..." and answers with op 4. Send when the player reaches the spot (or uses the map there) and his team is not all present (assumption from the text).

### S3. Bag and battle
- 115 `U_C_BAG_MOVE_UPDATE` for map items and costs; `GoodsManager` dispatches `DELETE_TREASURE_MAP` only for SonType 219 (`decompiled/core_module/scripts/yishi/manager/GoodsManager.as:221-224`), so the use frame closes on deletion only by its own dispose.
- Battle start pushes per [docs/battle/server-engine.md](../../docs/battle/server-engine.md) with `battle_type = 291`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Daily maps | `join_tremap_count` = 5 (client default 5) | `ConfigInfos.xml`, TMO:69-83 |
| Daily rewards | `reward_tremap_count` = 5 | `ConfigInfos.xml`, TMO:73 |
| Reset | 00:00 server time | help text `TreasureMapGetFrame.helpContent` |
| Refresh cost | `Property3` of current map wine, or `Property3 * 5` diamonds (Bronze 1, Ferro 2, Prata 4) | TGF:213-220, `ItemTempInfos.xml` 2190001..2190003 |
| Quick refresh cost | 8 wine or 40 diamonds (`treasure_refresh_item`, `treasure_refresh_points`) | TGF:77-78, `ConfigInfos.xml` |
| Wine to diamond rate | 1 wine (208050) = 5 diamonds (`COST_ITEM_TO_POINTS`) | TMO:37, TGF:379-397 |
| Refresh disabled | `index >= 3` or `joinCount >= joinMax` | TGF:253-262 |
| Dig immediately | 10 diamonds (`treasure_imm_battle`), bound allowed if ticked | TUF:82, TUF:228-250 |
| Use distance | Chebyshev distance <= 300 px (15 tiles x 20 px); hints at 800 and 1600 px | TMM:181-199, TMO:25-29 |
| Upgrade chance | assumption: `Property1` of the current map template is the percent chance to move up one quality (90, 50, 40) | `ItemTempInfos.xml` |
| Other map properties | `Property2` (5, 10, 20) and `Property4` (75, 65, 55, 50) meaning unknown (assumption: base reward multiplier and guardian strength) | open question |
| Team bonus | rewards grow with team members; orange opener gets more; members over their reward count get nothing | help text |
| Reward items bound | yes | help text item 6 |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ConfigInfos.xml` | `join_tremap_count`, `reward_tremap_count`, `treasure_refresh_item`, `treasure_refresh_points`, `treasure_imm_battle` | values above |
| `ItemTempInfos.xml` | 2190001..2190004 maps, 208050 "Vinho de Baiding" | `TemplateName`, `Property1..4` |
| `MapTemplate` (map template cate) | `randomSkill1` map | `Width`, `Height`, `MapName` for the 3x3 tile (TUF:369-414) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS treasures;

CREATE TABLE treasures.map_daily (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  join_count      SMALLINT NOT NULL DEFAULT 0 CHECK (join_count >= 0),
  reward_count    SMALLINT NOT NULL DEFAULT 0 CHECK (reward_count >= 0),
  quality_index   SMALLINT NOT NULL DEFAULT 0 CHECK (quality_index BETWEEN 0 AND 3),
  ladder          INTEGER[] NOT NULL CHECK (cardinality(ladder) = 4),
  first_quest     BOOLEAN NOT NULL DEFAULT false,
  first_get       BOOLEAN NOT NULL DEFAULT false,
  first_use       BOOLEAN NOT NULL DEFAULT false,
  reset_on        DATE NOT NULL
);

CREATE TABLE treasures.map_items (
  item_id         BIGINT PRIMARY KEY,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id     INTEGER NOT NULL,
  map_id          INTEGER NOT NULL,
  pos_x           INTEGER NOT NULL,
  pos_y           INTEGER NOT NULL,
  expires_at      TIMESTAMPTZ,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX map_items_player ON treasures.map_items (player_id);

CREATE TABLE treasures.map_battles (
  battle_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  owner_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id     INTEGER NOT NULL,
  paid_points     INTEGER NOT NULL DEFAULT 0,
  team_size       SMALLINT NOT NULL,
  won             BOOLEAN,
  started_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  finished_at     TIMESTAMPTZ
);
CREATE INDEX map_battles_owner_day ON treasures.map_battles (owner_id, started_at);
```

`treasures.map_items.item_id` is the inventory item id (`inventory` owns the row; this table keeps the hidden location; alternative: store it in the item's `random_skill1..3` columns).

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 8744 op 6 | `treasures::treasure_map::handle_request` |
| 8744 op 2 | `treasures::treasure_map::handle_refresh` |
| 8744 op 1 | `treasures::treasure_map::handle_get` |
| 8744 op 3 | `treasures::treasure_map::handle_dig_now` |
| 8744 op 5 | `treasures::treasure_map::handle_use` |
| 8744 op 4 | `treasures::treasure_map::handle_confirm_reward` |
| 8774 op 2004 (marriage) | delegate to `treasures::treasure_map::handle_use` when the item is a treasure map (assumption) |

- Validation order: load `map_daily` with lazy daily reset, check counters, check costs (wine first, then `giftToken` when `pay_type = 0`, then `point`), apply, push 4633.
- Transaction: currency debit, item grant/consume, counter update in one transaction; pushes after commit.
- Battle: `battle_type = 291`, map = the scene map, attackers = the owner and his free team members present on the map, defenders = guardian NPC chosen by map quality (assumption: monster template from `Property4` or a drop table); on win increment `reward_count` for members with `reward_count < 5`, grant drops (quality and team scaled), consume the map.
- Daily reset at 00:00: zero counters, roll a new ladder.

## 9. Open questions and assumptions

- Assumption: upgrade chance uses `Property1`; meaning of `Property2` and `Property4` unknown.
- Assumption: after the collect button the index resets to 0 with a new ladder.
- Gap: maps (SonType 208) have no client use path; `TreasureMapUseFrame` is never opened with `openType = 2`; op 5 sender is dead; 4634 answer reads an unassigned `lastTreasureMap`. The live client path is only R1..R4.
- Gap: 8745 reinforcement has no sender; 4634 has no body.
- Reward tables and guardian monsters are not in the client templates.

## 10. Implementation checklist

- [ ] Screen `TreasureMapGetFrame` opens from node option 13 and receives 4633
- [ ] Screen `TreasureMapUseFrame` (only if a use path is added)
- [ ] Route 8744 op 6 request
- [ ] Route 8744 op 2 normal refresh (wine first, bound flag)
- [ ] Route 8744 op 2 quick refresh
- [ ] Route 8744 op 1 collect
- [ ] Route 8744 op 3 dig now
- [ ] Route 8744 op 5 use and 4634 / op 4 confirm
- [ ] Server message 4633 after every op and at login
- [ ] Server message 4634
- [ ] Table `treasures.map_daily`, `treasures.map_items`, `treasures.map_battles`
- [ ] Daily reset job at 00:00
- [ ] Battle type 291 setup and reward distribution with team scaling
- [ ] Tests: refresh cost math with wine and bound diamonds, join and reward caps, distance check, reset
