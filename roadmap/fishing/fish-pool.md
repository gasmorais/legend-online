# Fish pool ("Pescar")

Module `fish-pool` of feature `fishing`. The fishing session: open, fish spawning, harpoon catch, daily count, fishing level and weekly points, tools.

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/managers/FishManager.as` |
| FMO | `decompiled/core_module/scripts/mvc/module/fish/FishModel.as` |
| FPI | `decompiled/core_module/scripts/mvc/module/fish/FishPoolInfo.as` |
| FSI | `decompiled/core_module/scripts/mvc/module/fish/FishSigInfo.as` |
| FSM | `decompiled/core_module/scripts/mvc/module/fish/FishSigModel.as` |
| FPH | `decompiled/core_module/scripts/mvc/module/fish/FishPoolHandler.as` |
| FFH | `decompiled/core_module/scripts/mvc/module/fish/FishForkHandler.as` |
| FC | `decompiled/core_module/scripts/mvc/controler/FishControler.as` |
| GBM | `decompiled/core_module/scripts/managers/GameBoxManager.as` |
| FF | `decompiled/m11/scripts/fish/FishFrame.as` |
| FV | `decompiled/m11/scripts/fish/view/FishView.as` |
| FTI | `decompiled/m11/scripts/fish/view/FishToolItem.as` |
| FTM | `decompiled/m11/scripts/fish/mediator/FishToolItemClickMediator.as` |

## 1. Overview

A session belongs to one fisher (`fishPoolInfo.userId`); `model.isSelf` is true when that id equals the current player (`FMO:352-359`). Only the fisher can fire. The client simulates fish movement locally from server spawn data (`beginTime`, `now`, `channelId`, `point` direction, template `Speed`) and reports what happened (fish left the screen, fish hooked, fish caught); the server owns spawning, validation and rewards.

Harpoon: pendulum amplitude 65 degrees (50 for the triple harpoon), period 84 frames (`FFH:23-42`). Position `x = 415 - sin(rot) * (5.6 * count + 67)`, `y = cos(|rot|) * (5.6 * count + 67)` (`FFH:83-91`). It returns when it touches the border (`x <= -10`, `x >= 840`, `y >= 370`, `FV:513-527`), an obstacle, or after hooking a fish (normal harpoon). Harpoon types (`FishForkEnums`): 0 normal, 1 triple (three harpoons at rotation +15 / -15), 2 reinforced ("Lança Reforçada": does not stop on the first fish, at most one fish per channel, stops on an obstacle, `FV:167-190,548-563`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FishFrame` (`FF`) | "Pescar" (`fish.FishFrame.titleText`) | pool, harpoon, counters, tools, help view | controller `fish` (`FC`), see README entry points | fishing level (`Nv.`), gp bar `gp/next` or "Max." (`FF:450-486`), daily count "{0}/{1}" (`FF:462`), weekly points (`FF:463`), 4 tool counters (`FF:465-468`), "Ranking" link (`FF:223`) |
| `FishView` | | pool area 830 x 370, fish sprites (`FishSigleView`, swf `{RES}fish{Path}.swf`), harpoon movie, basket button | `FF` | fish positions, catch animation, reward icons flying to the basket (`FV:685-785`) |
| `FishToolItem` x4 | tips `fish.FishFrame.toolTip1..4` | use a tool (needs count > 0) | `FF:190-213` | count; disabled at 0 (`FTI:73-96`) |
| add buttons x4 | tip "Clique para comprar" + tool name | buy a tool | `FF:198-209` | |
| `FishSimpleHelpFrame` | "Instruções de ajuda da Pesca" | rules text `fish.FishSimpleHelpFrame.text` | help button | static |

Tool ids: 1 "Míssil Raso", 2 "Lança Tripla", 3 "Lança Reforçada", 4 "Míssil Profundo" (`fish.FishFrame.toolName1..4`). Display order 1, 4, 2, 3 (`FF:210-213`).

## 3. Routes (client to server)

All routes use C>S 9507 (0x2523) `C_FISH_POOL`, protobuf `FreshPoolMsg`: `op (#1, INT32)` action, `paras (#2, INT32, repeated)` arguments. Sender `FM.fishAction(op, paras)` (`FM:197-207`).

### R1. Start fishing (game box)
- UI: game box "start" on game 1 (`decompiled/m11/scripts/gamebox/view/GameBoxItemView.as:172-180`).
- Sender: `GBM.starGame(1)` (`GBM:76-83`). Route C>S 9559 (0x2557) `C_GAMEBOX_OP`, `GameBoxInfoMsg`: `op (#7, INT32)` = 2, `starGameId (#5, INT32)` = 1; other fields (`tempId1..4 #1..#4`, `GameBoxMedal #6`, `ExchangeIndex #8`, `ExchangeCount #9`) unset.
- Expected response: S>C 257 (0x0101) `U_C_GAMEBOX_GAMESTART`, `GameBoxInfoMsg` with `op = 2`, `starGameId = 1`. Receiver `GBM.onOpenGame` (`GBM:116-131`) calls `enterGame1` (`GBM:143-174`).
- Client checks in `enterGame1`: free team -> "Você se encontra na Equipe, não é possível participar no evento da Pesca"; hero level >= 28.

### R2. Request pool info (op 4 `FISHPOOL`)
- Sent by `enterGame1` (`GBM:152`), paras empty.
- Response: 4916 `FishPoolMsg` of the caller's own pool.

### R3. Refresh fish (op 1 `FRESH_FISH`)
- `[10, 20]` on open (`GBM:153`).
- `[1, n, id1..idn]` every 50 frames when n fish left the screen, only for the fisher (`FPH:44-69`, `FSM:80-101`).
- `[20]` after the missile animation ends (`FTM:170`).
- Meaning of the first value is not explicit in the client. Assumption: `paras[0]` is a refresh mode (10 = initial fill up to `paras[1]` fish, 1 = replace the listed ids, 20 = refill the pool after a missile).
- Response: 4918 `FishInfosMsg` with new or changed fish.

### R4. Fire the harpoon
- UI: click on the pool (`FF:366-388` -> `FV.clickView` `FV:405-416`). No packet on click.
- Client checks: fisher only; `count > 0 && count >= maxCount` -> "Quantidade de Pescarias encerradas, tente novamente amanhã"; basket items >= 21 -> "O Cesto está cheio, favor coletar os prêmios disponíveis primeiro e depois tentar novamente."

### R5. Fish hooked (op 11 `CRAZYFISH`, `[2, fishId]`)
- Sent when a non obstacle fish outside channel 1 is hooked and is not raging (`FV:197-212`). The client also plays the "speed" animation.
- Response: none required (assumption). The server records the hook for validation of R6.

### R6. Catch result (op 10 `CATCHFISH`)
- Sent when the harpoon animation ends (`FV:608-681`): `[id...]` of every hooked non obstacle fish (`FV:633-660`), or no paras when nothing was hooked (`FV:674-677`). Not sent when a raging fish was pinned (see [fish-help.md](fish-help.md)).
- The client sets `fishState = -1` for caught fish (removed locally) and animates the reward icons (`RewardId`, plus `RageId1` on rage reward, `FV:685-710`).
- Response order (assumption based on handlers): 4917 `FishResultMsg` (per fish result), 115 bag 23 updates (rewards), 4916 (count, gp, level, score, tools), 4918 (replacement fish). An empty op 10 still consumes one daily attempt (assumption: every shot counts, see open questions).

### R7. Use a tool (op 5 `USETOOL`, `[toolId]`)
- UI: tool item click (`FTM:43-75`), also `FTI:110-113`.
- Client checks: harpoon idle (`isForkState(0)`) else "Durante a pesca não pode usar itens, tente mais tarde"; daily limit reached -> "Você já pescou até o limite diário, não pode usar itens. Tente novamente amanhã"; count > 0 (mediator only registered then).
- Missiles (1, 4): one at a time (`toolFlag`), send op 5, play the explosion; fish with `fishState == 4` fly out; then op 1 `[20]` (`FTM:57-70,116-171`).
- Harpoons (2, 3): if current type 0 send directly; same type as active -> ignored; switching between 2 and 3 asks "Deseja alterar a Lança Reforçada para a Lança Tripla?" / "Deseja alterar a Lança Tripla para a Lança Reforçada?" (`FTM:77-114`).
- Response: 4916 with decremented tool and `hookState` (harpoon type), 4918 with `state = 4` for every exploded fish.

### R8. Buy a tool (op 13 `TOOL_BUY`, `[toolId]`)
- UI: add buttons (`FF:289-340`). Mapping: add1 -> 1, add2 -> 4, add3 -> 2, add4 -> 3.
- Client: confirm "Deseja consumir {0} diamantes para comprar {1}?" with price 10 (the decompiled `finally` block always forces 10, `FF:313-324`; config `FishTool_Point = 10`), skippable via "do not ask again" (`SharedManagerHelper` key `fishToolItem_onAddHandler`).
- No client diamond or cap check. Server must check diamonds and `FishTool_Max = 5` (tip key `fish.FishFrame.toolFull` "Limite deste item atingido o máximo" exists but is not referenced by this client).
- Response: 4916 with the new tool count; diamonds via the player info push 3.

### R9. Close (op 8 `CLOSE`)
- UI: frame close (`FF:555-611`).
- Client checks: any harpoon in flight (state not 0 and not 3) -> "Quando tiver pescando não pode fechar a tela, tente novamente mais tarde"; fisher with a pinned rage fish -> confirm "Saindo não poderá obter o prêmio deste peixe. Deseja sair?"; helper -> confirm, see [fish-help.md](fish-help.md).
- Effect: op 8, frame disposed, model cleaned (`FMO:124-131`). No response required.

### R10. Cool down (op 3 `COOLCD`, `[1]` or `[0]`)
- `FF.allCoolBack` (`FF:403-416`) and the CD timer (`FF:488-498`) are never wired in this client (dead code). Config `Fish_Cd_Point = 3`. Language: "Acelarar resfriamento (Contrato dos Elfos Grátis)", "Resfriar imediatamente, serão consumidos {0} diamantes". Implement as no-op returning 4916.

## 4. Server messages (server to client)

### S1. 4916 (0x1334) `U_C_FISH_POOL`, `FishPoolMsg`
Receiver `FM.__fishPoolHandler` (`FM:100-134`), then `FishFrame.data` when `isSelf` (`FF:442-486`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `userId` | #1 | INT32 | pool owner (fisher) |
| `level` | #2 | INT32 | fishing level 0..40 |
| `gp` | #3 | INT32 | experience inside the level; client clamps to the level cap |
| `score` | #4 | INT32 | weekly points |
| `cd` | #5 | INT64 | cooldown ms (stored, unused) |
| `count` | #6 | INT32 | attempts used today; only applied when present (`hasCount`); updates info tip 2 with `maxCount - count` |
| `maxCount` | #7 | INT32 | daily maximum (`Fish_Count` = 20) |
| `tool1..tool4` | #8..#11 | INT32 | owned tools by id |
| `hookState` | #12 | INT32 | harpoon type 0 normal, 1 triple, 2 reinforced |
| `order` | #13 | INT32 | ranking position (stored as `sort`, unused in UI) |
| `fishplayers` | #14 | `FishPlayer`, repeated | helpers: `helpId (#1, INT32)`, `nickName (#2, STRING)` |

Sent: response to op 4, 1 (open), 5, 10, 13, 3, and to every member of the session when helpers change.

### S2. 4918 (0x1336) `U_C_FISH_INFOS`, `FishInfosMsg`
Receiver `FM.__fishInfoHandler` (`FM:136-179`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `userId` | #1 | INT32 | pool owner |
| `fishs` | #2 | `FishInfo`, repeated | fish list |

`FishInfo`: `fishId (#1, INT32)` unique in session; `templateId (#2, INT32)` `FishTemplateInfos.TemplateId`; `point (#3, BOOL)` true = swims left to right; `beginTime (#4, INT64)` spawn time ms; `channelId (#5, INT32)` 1..5; `state (#6, INT32)` 1 normal, 3 rage, 4 disposed (exploded), 5 invisible; `now (#7, INT64)` server time ms.

Client: a new id creates a fish; an existing id is updated only if it is moving and the state changed (`FM:145-156`). Start x = `-(beginTime - now) * Speed / 40` when `point`, else `830 + (beginTime - now) * Speed / 40` (`FM:165-175`): `beginTime` in the future places the fish outside the pool. Speed is px per frame (template `Speed`).

### S3. 4917 (0x1335) `U_C_FISH_CHECK`, `FishResultMsg`
Receiver `FM.__fishCheckHandler` (`FM:181-195`): appended to `model.fishResult`, not displayed.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `userId` | #1 | INT32 | fisher |
| `results` | #2 | `Result`, repeated | `fishId (#1, INT32)`, `state (#2, INT32)` validation result, `tool (#3, INT32)` tool dropped by the fish (help text item 4: special items) |

Assumption: `state` 1 = caught, 0 = rejected; `tool` = tool id gained (0 none). Tools drop during fishing per tooltips "(pode-se obterá durante a pesca)".

### S4. 257 (0x0101) `U_C_GAMEBOX_GAMESTART`, `GameBoxInfoMsg`
See R1. Only `op = 2` and `starGameId` are read (`GBM:116-131`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | hero level >= 28; not in a free team | `GBM:145-150`, `DialogOptionItem.as:754` |
| Daily attempts | `Fish_Count` = 20 (`maxCount`), reset daily | `ConfigInfos.xml`, help text item 2 |
| Basket limit | 21 items in bag 23 blocks firing | `FF:382-386` |
| Pool size | 830 x 370, channels y = 80, 160, 220, 280, 340 | `FMO:21-25`, `FSI:58-65` |
| Obstacles | `IsBlock = 1` (templates 1000, 1011, 1012, channel 1); not catchable; stop the harpoon | `FV:192-212,548-563` |
| Catchable | `!IsBlock && channelId != 1` | `FV:201` |
| Level curve | `UpGradeTempInfos` Types 40, Grades 1..40, Data = gp to reach that grade: 150 + 50 * (grade - 1) (150 .. 2100). Bar max for level L is the row at index L (Grades L+1); max level 40 shows "Max." | `FPI:97-112,152-155` |
| Fishing gp and points per fish | template `GP` and `Score` are 0 for every row; help text: deeper fish give more points | assumption: server table by channel (see open questions) |
| Fish rewards | `RewardId` x `RewardCount` (-4000 "Moeda do Jogo", 208012 "Cristal das Trevas", 2130005 "Doc. de Recompensa Avançado"); rage adds `RageId1 x RageCount1` (catch) and `RageId2 x RageCount2` (assumption: helper reward) | `FishTemplateInfos.xml`, `FV:695-708` |
| Tool price | 10 diamonds (`FishTool_Point`) | `FF:313-324` |
| Tool cap | 5 each (`FishTool_Max`) | `ConfigInfos.xml` |
| Shallow missile (1) | destroys all obstacles; no new obstacles for 20 s | `fish.FishFrame.toolTip1` |
| Deep missile (4) | destroys all shallow fish including obstacles; no fish for 3 s | `fish.FishFrame.toolTip4` |
| Triple harpoon (2) | 3 harpoons, amplitude 50 | `FFH:28-41` |
| Reinforced harpoon (3) | keeps going through fish, one fish per channel | `FV:176-186` |
| Harpoon duration | assumption: a tool harpoon type lasts for one shot (server resets `hookState` to 0 after op 10) | open question |
| Rage fish | `state = 3`; only rows with `RageId1 > 0` (1003, 1004, 1005, 1009, 1010; channels 4 and 5) | `FishTemplateInfos.xml`, help text item 5 |

Fish templates (`FishTemplateInfos.xml`, 13 rows):

| Id | Channel | Speed | Block | Reward | Rage 1 | Rage 2 |
|---|---|---|---|---|---|---|
| 1000 | 1 | 1 | yes | | | |
| 1011 | 1 | 2 | yes | | | |
| 1012 | 1 | 3 | yes | | | |
| 1001 | 2 | 2 | | -4000 x1 | | |
| 1006 | 2 | 2 | | 208012 x1 | | |
| 1008 | 2 | 4 | | 2130005 x1 | | |
| 1002 | 3 | 3 | | -4000 x2 | | |
| 1007 | 3 | 3 | | 208012 x2 | | |
| 1003 | 4 | 4 | | -4000 x5 | -4000 x3 | -4000 x1 |
| 1005 | 4 | 4 | | 208012 x2 | -4000 x3 | -4000 x1 |
| 1004 | 5 | 4 | | 2130005 x2 | -4000 x5 | -4000 x2 |
| 1009 | 5 | 4 | | -4000 x10 | -4000 x5 | -4000 x2 |
| 1010 | 5 | 4 | | 2130005 x2 | -4000 x5 | -4000 x2 |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `FishTemplateInfos.xml` | one fish type | `TemplateId`, `ChannelIds` (channel), `Speed` (px per frame), `Length`, `IsBlock`, `Path` (swf), `RewardId`, `RewardCount`, `RageId1`, `RageCount1`, `RageId2`, `RageCount2`; `Type`, `Level`, `GP`, `Score` are 0 |
| `UpGradeTempInfos.xml` Types 40 | fishing level | `Grades`, `Data` (gp threshold) |
| `ConfigInfos.xml` | constants | `Fish_Count` 20, `Fish_Cd_Point` 3, `Fish_Help_Point` 5, `Fish_Help_Count` 3, `FishTool_Max` 5, `FishTool_Point` 10 |
| `ItemTempInfos.xml` | rewards | -4000, 208012, 2130005 |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS fishing;

CREATE TABLE fishing.fishers (
  player_id        BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  level            SMALLINT NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 40),
  gp               INTEGER  NOT NULL DEFAULT 0 CHECK (gp >= 0),
  weekly_score     INTEGER  NOT NULL DEFAULT 0 CHECK (weekly_score >= 0),
  score_week       DATE     NOT NULL DEFAULT date_trunc('week', now())::date,
  daily_count      SMALLINT NOT NULL DEFAULT 0 CHECK (daily_count >= 0),
  count_day        DATE     NOT NULL DEFAULT current_date,
  tool_shallow_missile SMALLINT NOT NULL DEFAULT 0 CHECK (tool_shallow_missile BETWEEN 0 AND 5),
  tool_triple_harpoon  SMALLINT NOT NULL DEFAULT 0 CHECK (tool_triple_harpoon BETWEEN 0 AND 5),
  tool_power_harpoon   SMALLINT NOT NULL DEFAULT 0 CHECK (tool_power_harpoon BETWEEN 0 AND 5),
  tool_deep_missile    SMALLINT NOT NULL DEFAULT 0 CHECK (tool_deep_missile BETWEEN 0 AND 5),
  cooldown_until   TIMESTAMPTZ
);
CREATE INDEX fishers_weekly_score ON fishing.fishers (score_week, weekly_score DESC);
```

Live session state (in memory, optionally mirrored for crash recovery):

```sql
CREATE TABLE fishing.sessions (
  fisher_id     BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  hook_state    SMALLINT NOT NULL DEFAULT 0 CHECK (hook_state IN (0,1,2)),
  next_fish_id  INTEGER  NOT NULL DEFAULT 1,
  rage_fish_id  INTEGER,
  rage_until    TIMESTAMPTZ,
  block_obstacles_until TIMESTAMPTZ,
  block_fish_until      TIMESTAMPTZ,
  opened_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE fishing.fish (
  fisher_id    BIGINT  NOT NULL REFERENCES fishing.sessions(fisher_id) ON DELETE CASCADE,
  fish_id      INTEGER NOT NULL,
  template_id  INTEGER NOT NULL,
  channel_id   SMALLINT NOT NULL CHECK (channel_id BETWEEN 1 AND 5),
  left_to_right BOOLEAN NOT NULL,
  begin_time   TIMESTAMPTZ NOT NULL,
  state        SMALLINT NOT NULL CHECK (state IN (1,3,4,5)),
  hooked       BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (fisher_id, fish_id)
);
```

Basket items live in the generic item table with `bag_type = 23` ([inventory](../inventory/README.md)).

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 9559 op 2 id 1 | `time_story::game_box::handle_start_game` (delegates to `fishing::fish_pool::handle_open`) |
| 9507 op 4 | `fishing::fish_pool::handle_pool_info` |
| 9507 op 1 | `fishing::fish_pool::handle_refresh` |
| 9507 op 11 `[2,id]` | `fishing::fish_pool::handle_hook` |
| 9507 op 10 | `fishing::fish_pool::handle_catch` |
| 9507 op 5 | `fishing::fish_pool::handle_use_tool` |
| 9507 op 13 | `fishing::fish_pool::handle_buy_tool` |
| 9507 op 8 | `fishing::fish_pool::handle_close` |
| 9507 op 3 | `fishing::fish_pool::handle_cool_down` |

- Open: validate level >= 28, no team; reset `daily_count` if `count_day < today` and `weekly_score` if the week changed; create the session; reply 257, then on op 4 send 4916, on op 1 generate fish and send 4918.
- Spawning: keep about 20 fish (assumption from `[10,20]` and `[20]`); choose templates per channel with weights by fishing level (help text: higher level unlocks more fish types; no template field drives it, assumption); `beginTime` may be up to a few seconds in the future to stagger entries; set `state = 3` on some channel 4 and 5 fish with `RageId1 > 0`.
- Catch validation order: session exists and caller is the fisher -> `daily_count < 20` -> basket has < 21 items -> every id exists, is not a block, not channel 1, was hooked (op 11) and is plausibly on screen (`now` vs `begin_time` and `Speed`) -> in one transaction: increment `daily_count`, grant `RewardId x RewardCount` to bag 23 (or currency -4000 directly, assumption: virtual items in the basket are converted on pickup), add gp (level up loop on Types 40) and weekly score, roll tool drops (cap 5) -> push 4917, 115, 4916, then spawn replacements (4918).
- Use tool: count > 0, harpoon idle, `daily_count < maxCount`; missiles: mark affected fish `state = 4` and block spawning (20 s obstacles or 3 s all shallow fish); harpoons: set `hook_state` 1 or 2.
- Buy tool: diamonds >= 10, count < 5; debit and push 3 and 4916.
- Close: drop the session; if helpers are attached and the help is not finished, push 4919 `result = false` to them.
- No battle.

## 9. Open questions and assumptions

- Assumption: `FRESH_FISH` paras semantics (mode 10 / 1 / 20) as described in R3.
- Assumption: a shot with no fish still consumes an attempt (the client sends op 10 with no paras at `FV:674-677`; `count` comes only from the server).
- Assumption: gp and score per fish by channel depth (template values are 0). Proposed: gp = 5 * channel, score = channel - 1.
- Assumption: `FishResultMsg.Result.state` 1 success, `tool` dropped tool id.
- Assumption: tool harpoon lasts one shot.
- Unknown: the cooldown (`cd`) is never shown; send 0.
- Gap: appell templates 100, 101, 102 used for the ranking titles are missing from `AppellInfos.xml`.

## 10. Implementation checklist

- [ ] Screens (client ready): `FishFrame`, `FishView`, `FishToolItem`, `FishSimpleHelpFrame`.
- [ ] Route 9559 op 2 game 1 -> 257 (shared with game box).
- [ ] Route 9507 op 4 -> 4916.
- [ ] Route 9507 op 1 (three forms) -> 4918.
- [ ] Route 9507 op 11 `[2,id]` hook record.
- [ ] Route 9507 op 10 -> 4917, 115, 4916, 4918.
- [ ] Route 9507 op 5 (four tools) -> 4916, 4918.
- [ ] Route 9507 op 13 -> 3, 4916.
- [ ] Route 9507 op 8 close.
- [ ] Route 9507 op 3 no-op.
- [ ] Messages 4916, 4917, 4918, 257.
- [ ] Tables `fishing.fishers`, `fishing.sessions`, `fishing.fish`.
- [ ] Rules: daily reset 20, weekly reset, level curve Types 40, basket 21, tool cap 5 and price 10, missile blocks.
- [ ] Tests: level < 28 refused; 21st shot refused; catch of an obstacle id rejected; catch of a non hooked id rejected; level up across the 150 gp threshold; buying a 6th tool refused; deep missile sets state 4 on shallow fish (assumption: channels 1 to 3).
