# Stage grades ("stars") and sweep

Module `stars-and-sweep` of [campaign](README.md). Covers the per-campaign best grade (D to SSS, the game's "stars"), the rank list 4151 that drives every unlock, and the campaign sweep protocol ("Modo Bot") 8528/4425. The sweep frames belong to the [mopup](../mopup/README.md) feature; this module defines the server contract for `sweep_type 1` (campaigns) and lists the other sweep types sharing the same messages.

## 1. Overview

- Every graded campaign run ends with a grade 1..7 (D, C, B, A, S, SS, SSS), shown in `CampaignResultView` ([node-combat.md](node-combat.md)). The server keeps the best grade per campaign and sends the full list with **4151 U_C_RANK_LIST**.
- `CampaignRankManager` (`CM/yishi/manager/CampaignRankManager.as`) keeps `rankDic` (campaign -> grade) and `singleRankDic` (area -> best grade), then recomputes unlock states with `CampaignTemplateManager.checkCanChoose` (`CM/yishi/manager/CampaignTemplateManager.as:132-162`).
- Grades unlock: the next campaign (`PreCampaignId`), the "Herói" difficulty (Normal grade >= 5), harder room difficulties, the chapter SSS reward (every area SSS), and the sweep button (any grade).
- Sweep ("Modo Bot"): the player picks a cleared campaign and a number of runs; the server simulates the runs over time (60 s each), consumes Energy and gold per run, and reports results. It can be sped up with diamonds and keeps running offline.

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Grade badges in `CampaignInfoView`, `CampaignPointView` (`M13/selectcampaign/view/`), `InstanceItem`, `InstanceRightView`, `RoomRightView` (`M9/room/view/pve/`) | "Avaliação" + "--\|D\|C\|B\|A\|S\|SS\|SSS" (`room.InstanceItem.gradeText`) | Best grade | selection and rooms | `rankDic[campaignId].rank` |
| `CampaignMopupPrepareFrame` (`M5/mopup/view/CampaignMopupPrepareFrame.as`) | campaign name; "Alerta modo Bot:" with 4 rules | Choose run count and options | selection "Modo Bot" button (`M13/selectcampaign/view/CampaignInfoView.as:310-331`) | runs (default 1, max floor(Energy / 20)), Energy "20" per run, gold `Campaign_Sweep_Gold` per run, time `Campaign_Sweep_Time` per run, checkboxes "Consuma ouro para abrir Baú de Prata." and "Consuma chave-caveira para abrir Baú Misterioso.", "Habilitando Contrato dos Elfos tem Modo Bot gratuito" (:180-290) |
| `CampaignMopupIngFrame` (`M5/mopup/view/CampaignMopupIngFrame.as`) | "Modo Bot {n}" | Progress | 4425 status 1 with `sweep_type 1` (`CM/managers/MopupManager.as:120-150`) | remaining time, per run results (EXP, items), current run, speed-up ("Aceleramento consome {0} diamantes"), cancel ("Cancelar Modo Bot?"), end |
| `MopupGainGoodsFrame` | drop list | Items won so far | link in the progress frame | `dropItems` |

## 3. Routes (client to server)

### 3.1 Grades

No request. 4151 is pushed by the server.

### 3.2 Sweep: 8528 C_CAMPAIGN_SWEEP

Sender: `MopupManager.sendMopupInfo(sweepType, opType, campaignId, count, eIndex, enterType = 1, openSilverBox = false, openSecretBox = false, payType = 2)` (`CM/managers/MopupManager.as:264-278`). Route C>S **8528 (0x2150) C_CAMPAIGN_SWEEP** (the CSV also lists the alias `U_C_ASSISTANT_ITEMS` for 8528). Request `campaign.CampaignSweepReq`: `sweep_type (#1, INT32)`, `op_type (#2, INT32)`, `campaign_id (#3, INT32)`, `count (#4, INT32)`, `e_index (#5, INT32)`, `enter_type (#6, INT32)`, `open_silver_box (#7, BOOL)`, `open_secret_box (#8, BOOL)`, `pay_type (#9, INT32)`.

| # | Action | Caller (file:line) | Client checks | Fields | Expected response |
|---|---|---|---|---|---|
| S1 | Start a campaign sweep | `CampaignMopupPrepareFrame.__startMopupHandler` (`M5/mopup/view/CampaignMopupPrepareFrame.as:237-266`) | runs > 0; `Energy >= runs x 20` ("Energia insuficiente"); gold >= runs x `Campaign_Sweep_Gold` ("Ouro insuficiente"); opened from the selection: level >= 20, campaign graded, not in the outer city | `sweep_type 1`, `op_type 1`, `campaign_id`, `count` = runs, `e_index 0`, `enter_type 1`, `open_silver_box`, `open_secret_box`, `pay_type 2` | 4425 `status 1`, `sweep_type 1` (opens the progress frame) with the first `result` (time) |
| S2 | Speed up (finish now) | `CampaignMopupIngFrame.__accelerateHandler` / `accelerateBack` (`M5/mopup/view/CampaignMopupIngFrame.as:433-480`) | not ended ("Modo Bot encerrado"); confirm with the diamond cost; King Contract buff 4 sends without confirmation and `pay_type 1` | `sweep_type 1`, `op_type 2`, `campaign_id`, `pay_type` = 0 diamonds or 1 bound diamonds (the alert's second checkbox) | 4425 with all remaining results and `status 10` (end); 4425 `status 4` -> recharge alert when diamonds are missing |
| S3 | Progress tick | `CampaignMopupIngFrame.__timeCompleteHandler` (:495-504), every `Campaign_Sweep_Time` s | none | `sweep_type 1`, `op_type 3`, `campaign_id` | 4425 with the result of the finished run (or nothing new) |
| S4 | Stop / close | `CampaignMopupIngFrame.dispose` (:628-638) after "Cancelar Modo Bot?" | none | `sweep_type 1`, `op_type 4`, `campaign_id` | 4425 `status 11` or `15` (end) *(assumption)*; remaining runs are not charged |

Other sweep types on the same opcode (owned by their features, same server dispatcher):

| `sweep_type` | Mode | Callers | Owner |
|---|---|---|---|
| 2 | Labirinto floors (maze tower), `campaign_id` 8001/8101/8401, `e_index` = floor, `enter_type` = double profit | `MazeMopupPrepareFrame.as:254`, secretary acts `DixAction.as:73`, `SyAction.as:73`, `LyAction.as:73` | [../mazes/README.md](../mazes/README.md), [../secretary/README.md](../secretary/README.md) |
| 3 | Vórtice do Tempo | `TimeVortexMopupPrepareFrame.as:253`, `TimeVortexMopupIngFrame.as:410-612` | [../trials/README.md](../trials/README.md) |
| 4 | Continente dos Demônios (chapter, node) | `DemonLandMopupPrepareFrame.as:290`, `DemonLandManager.as:262` | [../trials/README.md](../trials/README.md) |
| 5 | Caminho da Vingança | `RevengeRoadMopupPrepareFrame.as:296`, `RevengeRoadMopupIngFrame.as:410-610` | [../roads/README.md](../roads/README.md) |
| 6 | Terra Sombria | `ShadowLandMopupPrepareFrame.as:251`, `ShadowLandMopupIngFrame.as:396-596` | [../trials/README.md](../trials/README.md) |

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **4151 (0x1037) U_C_RANK_LIST** | `campaign.RankListRspMsg{rankInfo (#1, RankMsg, repeated)}`; `RankMsg{user_id (#1, INT32), campaign_id (#2, INT32), rank (#3, INT32) 1..7}` | `CampaignRankManager.__rankListHandler` (`CM/yishi/manager/CampaignRankManager.as:52-88`) | login (full list) and after a new or better grade (the changed entries or the full list) | entries are merged (never removed); unknown campaign ids are skipped; `singleRankDic` keeps the best grade per `AreaId`; `checkCanChoose` recomputes states |
| **4425 (0x1149) U_C_CAMPAIGN_SWEEP** | `campaign.CampaignSweepRsp{result (#1, SweepResult, repeated), status (#2, INT32), sweep_type (#3, INT32), total_gp (#4, INT32), dropItems (#5, ItemTemplate, repeated), campaign_id (#6, INT32)}`; `SweepResult{type (#1, INT32) 1 normal end / 2 interrupted, gold (#3, INT32), gp (#4, INT32), campaign_id (#5, INT32), time (#6, INT32) remaining s, items (#7, ItemTemplate, repeated), cIndex (#8, INT32), eIndex (#9, INT32), finishCount (#10, INT32) run number, count (#11, INT32), mailIn (#12, INT32) items sent by mail}`; `ItemTemplate{template_id (#1, INT32), count (#2, INT32)}` | `MopupManager.__refreshMopupInfoHandler` (`CM/managers/MopupManager.as:59-236`); also secretary acts (`CM/mvc/module/secretary/acts/DixAction.as:86` and siblings) | every sweep step and status change; at login when a sweep finished offline (status 10, shown when back in `SPACE_SCENE`, :205-215, 238-262) | results appended; `time` -> remaining time; `gp` summed; `dropItems` = pending loot list, reduced by each result's items |

4425 `status` values (`MopupManager.as:120-233`, switch on `status - 1`):

| status | Meaning | Client reaction |
|---|---|---|
| 0 | data only | merge results |
| 1 | sweep started or running | open the progress frame for `sweep_type` (1 -> mopup 2, 2 -> 4, 3 -> 12, 4 -> 14, 5 -> 16, 6 -> 20); with the secretary open and type 2 notifies it instead |
| 2 | already sweeping | "Modo Bot em andamento" |
| 3 | not enough gold | "Ouro insuficiente" |
| 4 | not enough diamonds | recharge alert |
| 6 | not enough Energy | "Energia insuficiente" |
| 7 | nothing | |
| 9 | ignored (handler returns before commit) | |
| 10 | finished; `total_gp`; last result `type` 1 = normal end, 2 = not normal | end state; reopened in the Reino do Céu after 1 s |
| 11 | finished normally | `mopupEnd`, `isNormalEnd = true` |
| 12 | daily maze challenges used | "Desafios de hoje esgotados!" |
| 14 | invalid maze floor | "Piso do Modo Bot deve ter maior que piso atual" |
| 15 | finished abnormally | `mopupEnd`, `isNormalEnd = false` |
| 16 | demon land refusal | `demonland.main.text7` |
| 17 | revenge road refusal | `revengeroad.main.text7` |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Grade scale | 1 D, 2 C, 3 B, 4 A, 5 S, 6 SS, 7 SSS | `CampaignResultView.addProfileMc` (`CM/map/internals/view/displaye/CampaignResultView.as:134-160`) |
| Best grade | keep the maximum per campaign; the area keeps the maximum of its campaigns | `CampaignRankManager.as:63-84` |
| Unlock next campaign | campaign state 2 when `PreCampaignId` has a grade or is 0; 1 when graded; else 0 | `CampaignTemplateManager.as:132-162` |
| Hero difficulty | Normal grade >= 5 | `CampaignInfoView.as:250-255` |
| Room difficulties | difficulty 2 needs a grade on 1; 3 needs a grade on 2 | `RoomRightView.as:1350-1370` |
| Chapter SSS | every area graded 7 (areas > 10200), every Normal campaign graded | `CampaignChapterInfo.isAllOpenArea` (`CM/mvc/module/selectcampaign/CampaignChapterInfo.as:53-79`) |
| Grade formula (server) | inputs: boss kill time vs `StandSecond`, deaths (`failed_count`), shown in the result. Proposed: time appraisal = 7 when time <= `StandSecond`, minus one step per extra 25% *(assumption)*; death appraisal = 7 with 0 deaths, minus one per death *(assumption)*; total = floor((time + death) / 2) clamped 1..7 *(assumption)* | `CampaignResultView.as:100-118` |
| Sweep eligibility | campaign graded (`state == 1`), level >= 20, not in the outer city, no other sweep | `CampaignInfoView.as:134-142, 310-331, 524-531`; status 2 |
| Sweep runs | 1..floor(Energy / 20) | `CampaignMopupPrepareFrame.as:192-196, 237-256` |
| Sweep cost per run | 20 Energy (`SingleCampaign_Weary`), `Campaign_Sweep_Gold` 5000 gold, `Campaign_Sweep_Time` 60 s. "Ouro é consumido de acordo com o progresso do Modo Bot": charge per completed run | ConfigInfos; `mopup.view.MazeMopupPrepareFrame.mopupTipTxt` |
| Speed-up cost | `Sweep_Fast` "1,10": ceil(remaining_s / (60 x 10)) x 1 diamond | `CampaignMopupIngFrame.as:446-449` |
| Free sweep | King Contract buff 4 ("Contrato dos Elfos"): speed-up without diamonds (`pay_type 1`); the gold waiver flag `hasMopupBuff` is hard coded false | `CampaignMopupIngFrame.as:441-444`; `CampaignMopupPrepareFrame.as:289-292` |
| Chests during sweep | `open_silver_box`: pay gold for the silver chest of each run; `open_secret_box`: use a skull key for the mystery chest | mopup prepare frame tips |
| Offline | the sweep continues while offline; results are pushed at login | `mopupTipTxt` rule 1; `MopupManager.as:205-215` |
| Rewards per run | the same drop as a real run with the best grade *(assumption)*: `BaseGp` EXP and the card pool; items over the bag limit go by mail (`mailIn`) | |

## 6. Templates

| File | Use |
|---|---|
| `Campaigns.xml` | `CampaignId`, `PreCampaignId`, `AreaId`, `DifficultyGrade`, `StandSecond`, `BaseGp` |
| `ConfigInfos.xml` | `Campaign_Sweep_Time` 60, `Campaign_Sweep_Gold` 5000, `Sweep_Fast` "1,10", `SingleCampaign_Weary` 20 |
| `DistrictSSSDrop.xml` | chapter SSS rewards ([selection.md](selection.md)) |

## 7. Persistent state (schema `campaign`)

```sql
CREATE TABLE campaign.player_campaign_grade (
  player_id    integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  campaign_id  integer  NOT NULL,
  best_grade   smallint NOT NULL CHECK (best_grade BETWEEN 1 AND 7),
  clear_count  integer  NOT NULL DEFAULT 1 CHECK (clear_count >= 1),
  best_boss_ms integer,
  first_cleared_at timestamptz NOT NULL DEFAULT now(),
  updated_at   timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, campaign_id)
);

CREATE TABLE campaign.sweep (
  sweep_id      bigserial PRIMARY KEY,
  player_id     integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  sweep_type    smallint NOT NULL CHECK (sweep_type BETWEEN 1 AND 6),
  campaign_id   integer  NOT NULL,
  e_index       integer  NOT NULL DEFAULT 0,
  run_count     smallint NOT NULL CHECK (run_count > 0),
  done_count    smallint NOT NULL DEFAULT 0 CHECK (done_count >= 0),
  open_silver_box boolean NOT NULL DEFAULT false,
  open_secret_box boolean NOT NULL DEFAULT false,
  seconds_per_run integer NOT NULL,
  started_at    timestamptz NOT NULL DEFAULT now(),
  finished_at   timestamptz,
  end_status    smallint,
  total_gp      integer  NOT NULL DEFAULT 0,
  CHECK (done_count <= run_count)
);
CREATE UNIQUE INDEX sweep_active ON campaign.sweep (player_id) WHERE finished_at IS NULL;

CREATE TABLE campaign.sweep_result (
  sweep_id     bigint   NOT NULL REFERENCES campaign.sweep(sweep_id) ON DELETE CASCADE,
  run_number   smallint NOT NULL CHECK (run_number > 0),
  gold_spent   integer  NOT NULL DEFAULT 0,
  gp           integer  NOT NULL DEFAULT 0,
  items        jsonb    NOT NULL DEFAULT '[]'::jsonb,
  mailed_items jsonb    NOT NULL DEFAULT '[]'::jsonb,
  completed_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (sweep_id, run_number)
);
```

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::stars::send_rank_list` | push 4151 | at login | every `player_campaign_grade` row |
| `campaign::stars::record_grade` (internal, from [node-combat.md](node-combat.md)) | run end | grade 1..7 | upsert with `best_grade = max`; push 4151 with that entry; re-check chapter rewards ([selection.md](selection.md)) |
| `campaign::sweep::handle_request` | 8528 | dispatch on `sweep_type`: 1 here, 2..6 to the owning feature | |
| `campaign::sweep::handle_start` | 8528 type 1 op 1 | (1) no active sweep (else status 2); (2) level >= 20; (3) campaign graded by the player; (4) Energy >= 20 x count (else status 6); (5) gold >= 5000 x count (else status 3) | insert `sweep`; reply 4425 `{status 1, sweep_type 1, campaign_id, result[{type 1, time = count x 60, finishCount 0}], dropItems: pending}` |
| `campaign::sweep::handle_tick` | 8528 type 1 op 3 | active sweep | resolve every run whose time has elapsed: charge 20 Energy and 5000 gold, roll rewards, grant (mail overflow), insert `sweep_result`; reply 4425 `{status 0, result[...], dropItems}`; when all runs are done reply `{status 10, total_gp}` and close |
| `campaign::sweep::handle_speed_up` | 8528 type 1 op 2 | active; diamonds >= ceil(remaining / 600) for `pay_type 0` or bound diamonds for `pay_type 1` (else status 4); King Contract buff 4 free | resolve all remaining runs now; 4425 `{status 10}` |
| `campaign::sweep::handle_stop` | 8528 type 1 op 4 | active | close without the remaining runs; 4425 `{status 11 or 15}` |
| `campaign::sweep::job_resolve` | timer | active sweeps | resolve elapsed runs while offline; at login push 4425 `{status 10}` for sweeps finished offline |

## 9. Open questions and assumptions

1. The grade formula (proposed above).
2. Sweep rewards: same pool as a real run, or a reduced pool.
3. Meaning of `status 10` vs `11` vs `15` for the campaign type (end variants).
4. `pay_type` mapping (0 diamonds, 1 bound diamonds or free, 2 default on start).
5. Whether 4151 after a run carries only the changed entry (the client merges, so both work).

## 10. Implementation checklist

- [ ] 4151 at login and on grade improvement
- [ ] Grade computation and `player_campaign_grade`
- [ ] Unlock checks reused by selection, rooms and sweep
- [ ] 8528 dispatcher by `sweep_type`
- [ ] Campaign sweep ops 1..4, statuses 1, 2, 3, 4, 6, 10, 11, 15
- [ ] Offline resolution job and login push
- [ ] Tables `player_campaign_grade`, `sweep`, `sweep_result`
- [ ] Test: grade S on 1101 unlocks 11101 ("Herói") and 1102
- [ ] Test: sweep 3 runs with 60 Energy: 3 ticks of 60 s, Energy 0, gold -15000, then status 10
