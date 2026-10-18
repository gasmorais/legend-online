# Raid: rival list, refresh, raid battle, cooldown, winning streak

Module `raid` of feature `laboratory`. Covers the raid view of `PerkinLabFrame` ("Saquear"): 3 rival laboratories, the gold refresh and the automatic refresh, the raid (op 5) that starts a PvP battle (battleType 3851), its result (stolen materials, laboratory experience, winning streak bonus, logs), the daily raid count and the raid cooldown purchase (op 10).

Path aliases:

| Alias | File |
|---|---|
| PLM | `decompiled/core_module/scripts/managers/PerkinLabManager.as` |
| PMOD | `decompiled/core_module/scripts/mvc/module/perkinlab/PerkinLabModel.as` |
| V | `decompiled/m11/scripts/perkinlab/` |
| TIP | `decompiled/m16/scripts/yishi/view/tips/` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

- The raid view shows 3 rival laboratories (rival slots 0..2), each with the rival's name, a "Ver Informações" button (full player info from `DetailRspMsg`) and the expected loot. Rivals are flagged `isPerkinLabCrossInfo` and carry a `server_name`, so they may come from other servers.
- Clicking an unrobbed rival laboratory (`rob_state == 0`) asks "Deseja saquear {nome} Laboratório?" and sends op 5; the server starts a battle against the rival's army (battleType 3851 `PERKIN_LAB_BATTLE`). After the battle the client reopens the frame on the raid view.
- Limits: 5 raids per day ("Saqueamentos: x/5"), a 30 minute cooldown after each raid (purchasable), rivals refresh automatically every 120 minutes or on demand for gold.
- Help text: "Pode saquear laboratórios de outros jogadores para obter ganhos adicionais e EXP dos laboratórios ... o número de saques diário é limitado." and "O número de saques de tatuagem do laboratório é limitado, além disso as tatuagens avançadas não podem ser saqueadas."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/PerkinLabRobView.as` | "Saqueamentos: {0}/{1}", "Resfriado em:" + countdown, cooldown countdown and button, refresh button, winning streak gauge | rival list | Frame raid button (index 1) or openType 1; constructor sends op 1 (`:71-80`) | `5 - robCount`, `nextRefreshTime - now`, `robCdTime`, `victoryCount` (`:272-306`) |
| `V/PerkinLabKengView.as` (type 1) | rival name, "Ver Informações" | one rival laboratory; raid icon when robbable, "robbed" image otherwise | RobView | `robState`, `thane.nickName`, tip with `robReward` (`:188-250`) |
| `TIP/PerkinLabVictoryTip.as` | "Através de vitórias consecutivas poderá obter mais prêmios, caso falhar irá recomeçar.", "Nº de vitórias consecutivas:  {0}", "Sem prêmios" or "Próximo prêmio de vitória:" item x count | streak tooltip | gauge | (`:57-90`) |
| `PlayerInfoFrameII` | player info | rival details | "Ver Informações" (`V/PerkinLabKengView.as:168-171`, `PlayerInfoManager.show(thane, 10000)`) | `PerkinLabThaneInfo` built from `DetailRspMsg` (`PLM:170-735`); magic cards from `activeMagicCards` (`decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:261-265,307-310`) |
| `queueBar.VipCoolDownFrame` | "Resfriamento precisa consumir {0}" with "use bound diamonds" checkbox | cooldown purchase | cooldown button | cost (`V/PerkinLabRobView.as:136-172`) |

## 3. Routes (client to server)

All routes: C>S 9566 (0x255e) `C_PERKIN_LAB_CLIENT`, `PerkinLabClientMsg` = `op (#1, INT32)`, `index (#2, SINT32)` (default -1), `size (#3, SINT32)` unused. Sender `PLM.sendLabOperate` (`PLM:762-769`).

### C1. Open the raid view (op 1)
- UI: raid button or openType 1 (`V/PerkinLabFrame.as:143-153,190-201`); `PerkinLabRobView` constructor (`V/PerkinLabRobView.as:79`).
- Route: `op` = 1, `index` = -1.
- Response: three 273 messages, one per rival slot (0, 1, 2), each with `success = true` and `keng` set. If the rival list is not ready, one 273 with `success = false` (client shows "Carregando lista de saqueamentos, favor aguardar").

### C2. Raid a rival laboratory (op 5)
- UI: click on a rival laboratory (`V/PerkinLabKengView.as:294-305`).
- Client checks: `robCdTime > 0` -> "Tempo de resfriamento ainda em progresso"; rival `robState == 0`; raids left `5 - robCount > 0` else "Nº de saques diários insuficientes, favor voltar amanhã"; confirmation "Deseja saquear <nome> Laboratório?" (`:146-166`).
- Route: `op` = 5, `index (#2)` = rival slot (the `PerkinLabKengMsg.index` of the rival entry).
- Response: the battle creation sequence (64 `HeroFastKeyMsg`, 157 `BattlePrepareMsg` with battle type 3851, then the normal battle flow, see [battle](../battle/README.md)). After the report the client returns to the scene and opens `perkinlab` openType 1, which sends op 1 again. On validation failure send one 273 for that slot (state unchanged) and no battle.

### C3. Refresh rivals for gold (op 6) and finish animation (op 7)
- UI: refresh button (`V/PerkinLabRobView.as:192-230`).
- Client checks: 1 s anti double click ("Clique excessivo, tente novamente"); gold `>= refreshCost` else "Ouro Insuficiente"; confirmation "Deseja consumir {0} ouro para resfriar laboratório?" with "Não alertar mais" (`SharedManagerHelper.needAlert`).
- Route: `op` = 6, then the client plays the refresh animation and sends `op` = 7 at its last frame.
- Response: op 6: deduct gold (castle/currency push), roll 3 new rivals, set the next automatic refresh; op 7: three 273 messages (as C1). Sending the 273s directly after op 6 is also accepted by the client.

### C4. Automatic refresh (op 9)
- UI: the "Resfriado em:" countdown reaches 0 (`V/PerkinLabRobView.as:232-236`), then animation and op 7.
- Route: `op` = 9.
- Server: if `now >= rivals_refresh_at`, roll new rivals for free and set `rivals_refresh_at = now + 120 min`; reply to the following op 7 with three 273.

### C5. Buy the raid cooldown (op 10)
- UI: cooldown button, visible while `robCdTime > 0` (`V/PerkinLabRobView.as:136-190`).
- Client logic: with VIP cooldown privilege (`VIPModel.vipCoolPrivilege`) send at once with `index` = 0 when the VIP is valid (free), else 2; otherwise open `VipCoolDownFrame` with `cost = ceil(robCdTime / (60 * X)) * N` (`perkin_lab_rob_cool_need_point` "N,X" = "1,1": 1 diamond per started minute); on confirm `index` = 2 when "use bound diamonds" is checked, 1 otherwise, 0 if the VIP became valid. The frame checks the balance (`point`, or `point + giftToken` with bound diamonds) and opens the recharge alert when short.
- Route: `op` = 10, `index (#2)` = pay type: 0 VIP free, 1 diamonds only, 2 bound diamonds first.
- Response: one or three 273 with `rob_cd_time` = 0 and the slot entries (each 273 must include `keng`); currency push.

## 4. Server messages (server to client)

### S1. 273 (0x0111) `U_C_PERKIN_LAB_ROB`, `PerkinLabRobMsg`
Receiver `PLM.__updateRobKengList` (`PLM:132-168`, listener `PLM:105`) then `V/PerkinLabRobView.as:238-306`.

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `op` | #1 | INT32 | no | echo (not read) |
| `success` | #2 | BOOL | no | false = list not ready: tip and stop |
| `keng` | #3 | `PerkinLabKengMsg` | no | one rival laboratory (required: the view dereferences `keng.index`) |
| `rob_count` | #4 | INT32 | no | raids used today |
| `refresh_cost` | #5 | INT32 | no | gold cost of op 6 |
| `next_refresh_time` | #6 | INT64 | no | next automatic refresh, epoch ms (client: `ms/1000 - now`) |
| `rob_cd_time` | #7 | INT64 | no | remaining raid cooldown in **milliseconds** (client divides by 1000 and decrements every second) |

`PerkinLabKengMsg` for rivals:

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `uid` | #1 | STRING | no | rival laboratory id |
| `server_name` | #2 | STRING | no | rival server (not read) |
| `index` | #3 | INT32 | no | rival slot 0..2 (position in the view) |
| `rival_detail` | #4 | `simple.DetailRspMsg` | no | rival details: `army.simpleHero` (id, nickname, grade, stats, fashion), `grade`, `fightCapacity`, `item`, `star`, `cardInfos`, `starAdd`, `watch`, `mount`, `goddessInfo`, `monsterInfo`, `avengerInfo`, `theseusInfo`, `fightPet`, `fightChild`, `holeInfo` (tattoos), `titanInfo`, `dragonTalkerInfo`, `talismanInfo`, `petHallowInfo` (read at `PLM:170-735`; message owned by [hero](../hero/README.md)) |
| `rival_battle_army` | #5 | `ArmyMsg` | no | not read by the client; server side snapshot of the defender army (optional) |
| `size` | #6 | INT32 | no | not read (legacy lab size) |
| `harvest_time` | #7 | INT64 | no | rival lab ripe time, epoch ms (tip countdown, type 1 tips do not show it) |
| `missing_reward` | #8 | STRING | no | not used for rivals |
| `rob_reward` | #9 | STRING | no | loot if the raid wins, "templateId,count|..." (tip "Previsão de Ganhos:") |
| `rob_state` | #10 | INT32 | no | 0 = can raid; non zero = already raided (by this player) |

Client merges rival entries by `index` into `robKengList`, restarts the cooldown ticker, updates the raid count, refresh countdown and the streak gauge.

When: response to ops 1, 7, 10 (and optionally 6, 9, 5 failure); never pushed spontaneously.

### S2. 260 `U_C_PLAYER_EXTRA_FIELD_MSG` fields 12 (winning streak) and 20 (lab experience)
See [research.md](research.md) S2. Push after each raid result.

### S3. Battle messages (battleType 3851)
Owned by [battle](../battle/README.md). On exit the client sets `isOpenPerkinLab` and reopens the raid view (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:378-381`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Raids per day | 5 (`perkin_lab_rob_count`) | `CIM:586-593`, `ConfigInfos.xml` |
| Cooldown after a raid | 30 min (`perkin_lab_rob_cd_minute`) | `ConfigInfos.xml` |
| Cooldown price | `ceil(remaining_s / 60) * 1` diamonds (`perkin_lab_rob_cool_need_point` "1,1"); free with VIP cooldown privilege | `V/PerkinLabRobView.as:160-170`, `CIM:613-620` |
| Auto refresh | every 120 min (`perkin_lab_rob_refresh_minute`) | `ConfigInfos.xml` |
| Gold refresh price | `refresh_cost` from the server (no config key; assumption: a fixed gold amount, for example scaled by level) | open question |
| Loot on win | 10% (`perkin_lab_rob_percent`) of the rival laboratory's current normal production of the cycle, only item 208101 ("as tatuagens avançadas não podem ser saqueadas"); the rival keeps at least 50% (`perkin_lab_rob_left`) of the cycle production | `ConfigInfos.xml`, help text |
| Lab experience | +10 on win, +5 on loss (`perkin_lab_rob_add_gp` "10,5") | `ConfigInfos.xml` |
| Winning streak | win: bonus 208101 x `streakTable[min(streak, 10)]` with `streakTable` = 0,1,1,2,2,3,3,4,4,5,5 (`perkin_lab_winning_streak_reward` "208101#..."), then `streak += 1`; loss: `streak = 0` | `ConfigInfos.xml`, `TIP/PerkinLabVictoryTip.as:57-90`, `V/PerkinLabRobView.as:284-305` |
| Rival eligibility | other players with `vocationGrades > 0` (assumption: similar level, any server) with a laboratory not below the 50% floor | assumption |
| Raid counts | each raid (win or loss) uses one daily raid and starts the cooldown (assumption for losses) | |
| Daily reset | `rob_count = 0` at day change | assumption: 00:00 server time |

## 6. Templates

| File | Fields used |
|---|---|
| `ConfigInfos.xml` | `perkin_lab_rob_count` 5, `perkin_lab_rob_percent` 10, `perkin_lab_rob_left` 50, `perkin_lab_rob_refresh_minute` 120, `perkin_lab_rob_cd_minute` 30, `perkin_lab_rob_cool_need_point` "1,1", `perkin_lab_rob_add_gp` "10,5", `perkin_lab_winning_streak_reward` "208101#0,1,1,2,2,3,3,4,4,5,5" |
| `UpGradeTempInfos.xml` | Types 134 for the rival production (loot computation) |

## 7. Persistent state

Uses `laboratory.lab_state` (`rob_count`, `rob_count_day`, `rob_cooldown_until`, `rivals_refresh_at`, `win_streak`, `experience`), `laboratory.labs` and `laboratory.lab_losses` from [research.md](research.md).

```sql
CREATE TABLE laboratory.rivals (
  player_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot_index       SMALLINT NOT NULL CHECK (slot_index BETWEEN 0 AND 2),
  rival_player_id  BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  rival_lab_id     BIGINT NOT NULL REFERENCES laboratory.labs(lab_id) ON DELETE CASCADE,
  rob_state        SMALLINT NOT NULL DEFAULT 0 CHECK (rob_state IN (0, 1)),
  assigned_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, slot_index)
);
CREATE INDEX rivals_rival_lab_idx ON laboratory.rivals (rival_lab_id);
```

Cross-server rivals: `rival_player_id` must reference a player known to this database; a cross-server design needs a separate rival cache keyed by `(server_name, rival_player_id)` (open question).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9566 `op` 1 | `laboratory::raid::handle_open_list` |
| 9566 `op` 5 | `laboratory::raid::handle_rob` |
| 9566 `op` 6 | `laboratory::raid::handle_refresh_paid` |
| 9566 `op` 7 | `laboratory::raid::handle_refresh_done` |
| 9566 `op` 9 | `laboratory::raid::handle_refresh_auto` |
| 9566 `op` 10 | `laboratory::raid::handle_buy_cooldown` |
| battle end (3851) | `laboratory::raid::on_battle_end` |

- `handle_open_list`: `vocation_grades > 0` -> daily reset -> if no rivals or `now >= rivals_refresh_at`: roll rivals -> send three 273 (slot 0..2) with `rob_count`, `refresh_cost`, `next_refresh_time`, `rob_cd_time = max(0, rob_cooldown_until - now)` in ms, and `keng` = rival lab (uid, index = slot, `rival_detail`, `harvest_time`, `rob_reward` = computed loot, `rob_state`).
- `handle_rob` validation order: `rob_count < 5` -> `now >= rob_cooldown_until` -> slot exists with `rob_state = 0` -> no battle already running for the player -> lock the rival lab row. Then create the battle: battleType 3851, attacker = player hero and soldiers, defender = rival hero and soldiers snapshot (the same army used by arena PvP), auto fight; map: assumption, the arena map (see `docs/battle/server-engine.md` section 9). Mark the slot as "in battle" to forbid a second request.
- `on_battle_end` (one transaction): `rob_count += 1`; `rob_cooldown_until = now + 30 min`; experience +10/+5 and level recompute; on win compute loot (section 5, capped by the 50% floor of the rival lab), insert/accumulate `lab_losses` of the rival lab, give loot plus streak bonus to the attacker's bag, `win_streak += 1`, set `rob_state = 1`; on loss `win_streak = 0` (rob_state stays 1, assumption: a rival can be raided once per refresh); write two log rows ([log.md](log.md)); count quest condition 208. After commit: 260 (fields 12, 20) and bag pushes to the attacker; 272 push to the defender if online; the battle report carries the items for display (`BattleReportMsg`).
- `handle_refresh_paid`: gold `>= refresh_cost` -> deduct -> roll rivals -> `rivals_refresh_at = now + 120 min` -> currency push (273 optional).
- `handle_refresh_done`: three 273.
- `handle_refresh_auto`: roll rivals only if `now >= rivals_refresh_at`.
- `handle_buy_cooldown`: `rob_cooldown_until > now` -> pay type 0 requires the VIP cooldown privilege (VIP feature) -> types 1/2 compute `ceil(remaining_s/60)` diamonds, type 2 spends bound diamonds first -> clear the cooldown -> three 273 (or at least one with `keng`).
- Rival roll: pick 3 distinct players other than self with `vocation_grades > 0` and an existing lab, preferring hero level within a band (assumption), excluding players already at the 50% floor in all labs.

## 9. Open questions and assumptions

- Open: `refresh_cost` value (no config key); propose a constant (for example 10000 gold) in server config.
- Open: rival selection rules and cross-server scope (`server_name`, `isPerkinLabCrossInfo`).
- Assumption: losses also consume a raid and start the cooldown.
- Assumption: loot = 10% of the rival lab's current cycle production of 208101, floor 50%.
- Assumption: map and battle setup equal to arena PvP; `count_down` 180.
- Assumption: `rob_state` 1 after any raid (win or loss) until the next refresh.

## 10. Implementation checklist

- [ ] Screens (client ready): `PerkinLabRobView`, `PerkinLabKengView` (type 1), `PerkinLabVictoryTip`, `VipCoolDownFrame`, `PlayerInfoFrameII` with `DetailRspMsg`.
- [ ] Table `laboratory.rivals`.
- [ ] Route 9566 op 1 list (three 273, ms durations, `DetailRspMsg`).
- [ ] Route 9566 op 5 raid -> battle 3851; `on_battle_end` result transaction.
- [ ] Routes 9566 ops 6, 7, 9 refresh flows.
- [ ] Route 9566 op 10 cooldown purchase with pay types 0/1/2.
- [ ] Pushes 260 (fields 12, 20) and defender 272.
- [ ] Tests: 6th raid of the day refused; raid during cooldown refused; win steals 10% and respects the 50% floor; streak bonus sequence 0,1,1,2,...; loss resets the streak and gives 5 exp; cooldown price for 29 min 30 s is 30 diamonds; op 10 pay type 0 without VIP privilege refused; every 273 includes `keng`.
