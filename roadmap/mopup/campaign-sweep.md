# Generic sweep (campaign sweep protocol)

Feature [mopup](README.md), module `campaign-sweep`. Aliases in [README.md](README.md).

## 1. Overview

One request opcode 8528 (0x2150) `C_CAMPAIGN_SWEEP` and one push 4425 (0x1149) `U_C_CAMPAIGN_SWEEP` serve seven activities through `sweep_type`:

| sweep_type | Activity | Prepare frame (openType) | In progress frame (openType) | Resource per run | Gold per run | Time per run |
|---|---|---|---|---|---|---|
| 1 | Campaign (solo campaign map) | `V/CampaignMopupPrepareFrame.as` (1) | `V/CampaignMopupIngFrame.as` (2) | 20 Energia (`weary`) | `Campaign_Sweep_Gold` 5000 | `Campaign_Sweep_Time` 60 s |
| 2 | Labirinto (maze), tabs normal / Abismo / Purgatório | `V/MazeMopupPrepareFrame.as` (3) | `V/MazeMopupIngFrame.as` (4) | none (floors) | `Tower_Sweep_Gold` 1000 per floor | `Tower_Sweep_Time` 6 s per floor |
| 3 | Vórtice do Tempo | `V/TimeVortexMopupPrepareFrame.as` (11) | `V/TimeVortexMopupIngFrame.as` (12) | 10 Energia | `TimeVortex_Sweep_Gold` 500000 | `TimeVortex_Sweep_Time` 60 s |
| 4 | Continente dos Demônios | `V/DemonLandMopupPrepareFrame.as` (13) | `V/DemonLandMopupIngFrame.as` (14) | land `Cost` Lágrimas da Deusa | `evilland_sweep_gold` 50000 | `evilland_sweep_time` 60 s |
| 5 | Caminho da Vingança | `V/RevengeRoadMopupPrepareFrame.as` (15) | `V/RevengeRoadMopupIngFrame.as` (16) | node `Cost` Corações de Vingança | `revengeroad_sweep_gold` 50000 | `revengeroad_sweep_time` 60 s |
| 6 | Terra Sombria | `V/ShadowLandMopupPrepareFrame.as` (19) | `V/ShadowLandMopupIngFrame.as` (20) | 10 shadow land energy | `shadow_land_sweep_config` `60,50000` | 60 s |
| 8 | Caminho Final | none (chapter button "Bot") | none | 1 chapter attempt | none known | instant (assumption) |

`op_type`: 1 start, 2 accelerate, 3 poll a finished slice, 4 stop (sent when the in progress frame closes). Sweeps continue offline; on login the server answers with status 10 and the client reopens the in progress frame when the player reaches the space scene (`MM:183-206`, `:238-262`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Prepare frames (see table) | "Modo Bot", "Alerta modo Bot:", tips "1. Modo Bot pode estar em andamento offilne 2. Modo Bot pode concluir missão e adquirir itens de missões ...", "Habilitando Contrato dos Elfos tem Modo Bot gratuito" | Choose count or floor; shows time, energy and gold | campaign info "Modo Bot" (`decompiled/m13/scripts/selectcampaign/view/CampaignInfoView.as:330`); maze (`decompiled/m9/scripts/maze/MazeFrame.as:450-509`); time vortex (`decompiled/m11/scripts/timevortex/TimeVortexChallengeFrame.as:490`); demon land (`decompiled/m11/scripts/demonland/AwardView.as:181`); revenge road (`decompiled/m11/scripts/revenge/RevengeFightFrame.as:120-125`); shadow land (`decompiled/m11/scripts/shadowland/ShadowLandFightFrame.as:139`) | counts, `count * time`, `count * gold` (0 with the elf contract), `count * resource`; campaign prepare forces `CASTLE_SCENE` unless in castle or space (`V/CampaignMopupPrepareFrame.as:117-122`) |
| In progress frames | "Modo Bot {0}", "Modo Bot Piso {0}", "Em combate......", "Experiência", "Itens", "Acelarar(Contrato dos Elfos Grátis)", "Cancelar Modo Bot?", "Modo Bot encerrado" | Result list per run, remaining time, accelerate, cancel/close | 4425 status 1 or 10 (`MM:127-206`) | `resultInfoList` (`type` 1 = finished run with `gp` and items), `mopupExt` total exp, `mopupRemainTime` (`V/CampaignMopupIngFrame.as:274-390`) |
| `V/MopupGainGoodsFrame.as` | drop list | Items gained in the sweep | link in the in progress frame (`V/CampaignMopupIngFrame.as:506-512`) | `_goodsList` |

## 3. Routes (client to server)

All requests: send 8528 (0x2150) `C_CAMPAIGN_SWEEP` (the opcode table also names 8528 `U_C_ASSISTANT_ITEMS`, a duplicate entry), protobuf `CampaignSweepReq` (package `campaign`): `sweep_type` (#1, INT32) activity; `op_type` (#2, INT32) action; `campaign_id` (#3, INT32) campaign / maze campaign / time vortex campaign / demon land chapter / revenge node / shadow land checkpoint / final road chapter; `count` (#4, INT32) runs; `e_index` (#5, INT32) maze target floor, demon land node, revenge node; `enter_type` (#6, INT32) maze 1 normal, 2 double profit; `open_silver_box` (#7, BOOL) campaign "Consuma ouro para abrir Baú de Prata."; `open_secret_box` (#8, BOOL) campaign "Consuma chave-caveira para abrir Baú Misterioso."; `pay_type` (#9, INT32) accelerate payment. Sender `MM.sendMopupInfo` (`MM:264-278`).

### R1. Start (op_type 1)

| sweep_type | Sender | Client checks | Fields |
|---|---|---|---|
| 1 | `V/CampaignMopupPrepareFrame.as:237-266` | count >= 1; `weary >= count * 20` else "Energia insuficiente"; gold >= cost else "Ouro insuficiente"; max count `floor(weary / 20)` (`:184-204`) | `campaign_id`, `count`, `open_silver_box`, `open_secret_box` |
| 2 | `V/MazeMopupPrepareFrame.as:220-255` | floor > 0 ("Piso do Modo Bot tem que ser maior que 0"); floor >= current ("... deve ter maior que piso atual"); floor <= record ("... deve ser menor que recorde atual"); gold for `(floor - current + 1) * 1000`; double profit needs keys (`decompiled/m9/scripts/maze/MazeFrame.as:454-484`, keys 208008 or 208037); not in the outer city ("No cenário atual não é possível usar o Modo BOT") | `campaign_id` = maze campaign, `e_index` = target floor, `enter_type` 1/2 |
| 2 (secretary) | `decompiled/core_module/scripts/mvc/module/secretary/acts/DixAction.as:73`, `:134`; `SyAction.as`, `LyAction.as` same lines | secretary rules | `campaign_id` 8001 / 8101 / 8401, `e_index` floor, `enter_type` 2 |
| 3 | `V/TimeVortexMopupPrepareFrame.as:232-253` | `weary >= count * 10`; gold; max `min(floor(weary / 10), challengeMax - timeVortexCount)` (`:172-186`) | `campaign_id`, `count` |
| 4 | `V/DemonLandMopupPrepareFrame.as:279-290` | tears >= count * land `Cost`; max `min(tears / Cost, AttackCount - attackCount + buyCount)` (unlimited when `AttackCount == 0`) (`:197-210`); refill offer "Deseja gastar {0} diamantes para repor as Lágrimas da Deusa? (Ainda pode repor {1} vezes.)" | `campaign_id` = chapter, `count`, `e_index` = node |
| 5 | `V/RevengeRoadMopupPrepareFrame.as:280-296` | hearts >= count * node `Cost`; max attempts when `AttackCount > 0` (`:183-212`); refill offer "Deseja gastar {0} diamantes para repor {1} Corações de Vingança? (Pode repor mais {2}vezes)" | `campaign_id` = node, `count`, `e_index` = node |
| 6 | `V/ShadowLandMopupPrepareFrame.as:229-251` | energy >= count * 10; gold | `campaign_id` = checkpoint, `count` |
| 8 | `decompiled/m11/scripts/finalroad/FinalRoadItem.as:100-137` | chapter attempts left ("Não restam capítulos para escolher nesta semana"); chapter fully cleared before ("Requer a conclusão total antes de usar o Bot"); not the chapter being challenged ("O Capítulo escolhido está sendo desafiado, não é possível usar o Bot"); confirm "Deseja consumir 1 tentativa do Capítulo para usar o Bot?" | `campaign_id` = chapter index |

- Expected reply: 4425 `status = 1` and `sweep_type` (opens the in progress frame for types 1..6, or the little secretary notification for type 2 when `LitteActionManager.isOpen`, `MM:132-165`), `dropItems` expected total drops, `campaign_id`, then results over time.

### R2. Accelerate (op_type 2)

- UI: "Acelarar" (`V/CampaignMopupIngFrame.as:433-480`; same in the other in progress frames, e.g. `V/MazeMopupIngFrame.as:441-475`, `V/DemonLandMopupIngFrame.as:407-441`).
- Client: with elf contract buff 4: send directly with `pay_type = 1` (free). Else confirm with cost `ceil(remainSeconds / (60 * 10)) * 1` diamonds (`Sweep_Fast` = `1,10`) and a "use bound diamonds" option; `pay_type = 1` when not using bound, `0` when bound first (as coded: `_loc4_ = 0; if(!useBind) _loc4_ = 1`).
- Server: charge, finish all remaining runs immediately, reply 4425 with all results and status 10 or 11.

### R3. Poll (op_type 3)

- Trigger: in progress timer every run duration (`V/CampaignMopupIngFrame.as:495-504`; maze uses the floor time).
- Reply: 4425 with the newly finished `result` entries and remaining `time`.

### R4. Stop (op_type 4)

- Trigger: in progress frame dispose (`V/CampaignMopupIngFrame.as:628-640`), after the cancel confirm "Cancelar Modo Bot?" or after the end.
- Server: stop the job; unconsumed runs refund nothing beyond resources not yet charged (assumption: resources are charged per finished run).

## 4. Server messages (server to client)

### 4425 (0x1149) `U_C_CAMPAIGN_SWEEP`

- Message `CampaignSweepRsp`: `result` (#1, MESSAGE `SweepResult`, repeated); `status` (#2, INT32); `sweep_type` (#3, INT32); `total_gp` (#4, INT32) total exp (status 10); `dropItems` (#5, MESSAGE `ItemTemplate`, repeated) expected drops still to come (decremented client side by received items, `MM:102-123`); `campaign_id` (#6, INT32).
- `SweepResult`: `type` (#1, INT32) 1 finished run, 2 still running; `gold` (#3, INT32); `gp` (#4, INT32) exp; `campaign_id` (#5, INT32); `time` (#6, INT32) remaining seconds; `items` (#7, MESSAGE `ItemTemplate`, repeated: `template_id` #1, `count` #2); `cIndex` (#8, INT32); `eIndex` (#9, INT32) floor; `finishCount` (#10, INT32) runs done; `count` (#11, INT32) runs total; `mailIn` (#12, INT32) items sent by mail (bag full, assumption).
- Receiver: `MM.__refreshMopupInfoHandler` (`MM:62-236`), model events `MOPUP_RESULT_LIST_REFRESH`, `MOPUP_END`.

| status | Client reaction (`MM:127-233`) |
|---|---|
| 1 | start accepted: open in progress frame by `sweep_type` (1 -> 2, 2 -> 4, 3 -> 12, 4 -> 14, 5 -> 16, 6 -> 20) |
| 2 | "Modo Bot em andamento" (already sweeping) |
| 3 | "Ouro insuficiente" |
| 4 | recharge dialog (diamonds) |
| 6 | "Energia insuficiente" |
| 7 | nothing |
| 9 | ignored entirely (no model commit) |
| 10 | offline sweep state at login: `total_gp`, end flag from the last result `type`; after 1 s buffered until `SPACE_SCENE`, then opens the in progress frame (`MM:238-262`) |
| 11 | sweep ended normally (`isNormalEnd = true`) |
| 12 | "Desafios de hoje esgotados!" |
| 14 | "Piso do Modo Bot deve ter maior que piso atual" |
| 15 | sweep ended abnormally (`isNormalEnd = false`) |
| 16 | "Lágrimas da Deusa insuficientes." |
| 17 | "Corações de Vingança insuficientes" |

- When: reply to every op_type; at login when a sweep job exists (status 10); after each poll.

## 5. Rules and formulas

- Campaign: runs <= `floor(weary / 20)`; cost per run 20 energy, 5000 gold (0 with elf contract, client `hasMopupBuff` is hardcoded false: server decides), 60 s.
- Maze: floors `target - current + 1`, 1000 gold and 6 s each; double profit `enter_type = 2` needs keys.
- Accelerate: `ceil(remaining_s / 600)` diamonds.
- Time vortex: `min(floor(weary / 10), challengeMax - timeVortexCount)` runs.
- Demon land and revenge road: resource `Cost` from their templates, attempt caps `AttackCount` (0 = unlimited).
- Shadow land: 10 energy per run, `shadow_land_sweep_config` = `60,50000`.
- Sweeping grants the normal rewards of the content (exp `gp`, gold, drops) and counts for quests ("Modo Bot pode concluir missão").

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Campaign_Sweep_Time`, `Campaign_Sweep_Gold`, `Tower_Sweep_Time`, `Tower_Sweep_Gold`, `Sweep_Fast`, `TimeVortex_Sweep_Time`, `TimeVortex_Sweep_Gold`, `evilland_sweep_time`, `evilland_sweep_gold`, `evilland_goddess_tear_config`, `revengeroad_sweep_time`, `revengeroad_sweep_gold`, `shadow_land_sweep_config`, `demon_road_sweep_time` / `demon_road_sweep_gold` (marked "废弃", deprecated) | see section 5 |
| Activity templates (owners) | campaign, maze, time vortex, `EvilLandTemplates`, `RevengeRoad*`, `ShadowLandTemplates` | `Cost`, `AttackCount`, drops |

## 7. Persistent state

Schema `mopup`.

```sql
CREATE TABLE mopup.sweep_job (
  player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  source               TEXT        NOT NULL CHECK (source IN ('campaign','maze','time_vortex','demon_land','revenge_road','shadow_land','final_road','abyss','hell_abyss','remote_pet','lord_trial')),
  sweep_type           SMALLINT,
  target_id            INTEGER     NOT NULL,
  target_index         INTEGER     NOT NULL DEFAULT 0,
  enter_type           SMALLINT    NOT NULL DEFAULT 1,
  total_runs           INTEGER     NOT NULL CHECK (total_runs > 0),
  finished_runs        INTEGER     NOT NULL DEFAULT 0 CHECK (finished_runs >= 0),
  run_seconds          INTEGER     NOT NULL CHECK (run_seconds > 0),
  started_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  options              JSONB       NOT NULL DEFAULT '{}',
  total_exp            BIGINT      NOT NULL DEFAULT 0,
  ended                BOOLEAN     NOT NULL DEFAULT false,
  normal_end           BOOLEAN     NOT NULL DEFAULT true
);

CREATE TABLE mopup.sweep_result (
  player_id            BIGINT     NOT NULL REFERENCES mopup.sweep_job(player_id) ON DELETE CASCADE,
  run_no               INTEGER     NOT NULL,
  gold                 INTEGER     NOT NULL DEFAULT 0,
  exp                  INTEGER     NOT NULL DEFAULT 0,
  items                JSONB       NOT NULL DEFAULT '[]',
  floor_index          INTEGER,
  finished_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, run_no)
);
```

One sweep at a time per player ("Modo Bot em andamento").

## 8. Backend implementation notes

- `mopup::campaign_sweep::handle_request` (8528) dispatches by `op_type`; per `sweep_type` it calls the owner activity for validation, cost and reward roll (`campaign::sweep_run`, `mazes::sweep_floor`, `trials::time_vortex::sweep_run`, ...).
- Start: validation order: no active job (status 2) -> activity unlocked and cleared -> resources (status 6/16/17) -> gold (status 3) -> create job; reply status 1 with expected `dropItems`.
- Runs are materialized lazily: on poll/login compute `finished = min(total, floor((now - started_at) / run_seconds))`, roll and grant each missing run in a transaction (resources, gold, exp, items), insert `sweep_result`, reply with new results. Status 11 when finished.
- Accelerate: charge diamonds (status 4 on failure), finish all runs now.
- Stop (op 4): delete the job and results after granting finished runs.
- Login: when a job exists send 4425 status 10 with all results so far.
- Elf contract buff 4: gold cost 0 and free accelerate.

## 9. Open questions and assumptions

- Meaning of `pay_type` values for accelerate (client sends 1 when not using bound diamonds, 0 otherwise; with the elf contract 1).
- Whether resources are charged up front or per run (assumed per run).
- Status 5, 8, 13 are not handled by the client; their meaning is unknown.
- Final road (type 8) reply flow; no in progress frame exists.

## 10. Implementation checklist

- [ ] Screens: 6 prepare frames, 6 in progress frames, gain list frame
- [ ] Route R1 start for sweep types 1, 2, 3, 4, 5, 6, 8
- [ ] Route R2 accelerate (Sweep_Fast, elf contract)
- [ ] Route R3 poll
- [ ] Route R4 stop
- [ ] Server message 4425 with every status code
- [ ] Tables `mopup.sweep_job`, `mopup.sweep_result`
- [ ] Offline progress and login status 10
- [ ] Test: second sweep refused with status 2
- [ ] Test: accelerate cost `ceil(remaining / 600)`
