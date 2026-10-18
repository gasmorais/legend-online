# Rapid Through ("Completar fase rapidamente")

Area: trials, module `rapid-through`. Client packages `rapidThrough` (model `mvc.module.rapidThrough.RapidThroughModel`, campaign UI `decompiled/m3/scripts/map/campaign/view/ui/rapidThrough/RapidThroughView.as`) and `rapidthrouh` (rank frame `decompiled/m9/scripts/rapidthrouh/RapidThrouhtRankFrame.as`), manager `managers.RapidThroughPassManager`, controller key `rapidthrough`. Protos `campaign.CampaignReqMsg`, `campaign.QuickPassInfoMsg`, `campaign.QuickPassRankMsg`.

Path aliases:

| Alias | File |
|---|---|
| RTM | `decompiled/core_module/scripts/managers/RapidThroughPassManager.as` |
| RTV | `decompiled/m3/scripts/map/campaign/view/ui/rapidThrough/RapidThroughView.as` |
| RTR | `decompiled/m9/scripts/rapidthrouh/RapidThrouhtRankFrame.as` |

## 1. Overview

A timed cooperative team campaign (campaign 4801 "Completar fase rapidamente", `Types 23`, level 35..100, capacity 4, map check `WorldBossHelper.checkRapidMap(mapId) == 4801`, `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as:471-474`). The team crosses 9 stages ("Fase"); each stage requires the team to open a number of objects (chests, colored eggs, orifices) with keys and hammers whose colors only teammates can see ("Obs.: Você mesmo não consegue ver a cor das chaves, martelo, orifício..."). The run is timed; the best completion times are ranked and ranking rewards are granted (`QuickPassRewards.xml`). Rewards depend on a daily income count (`rapidPassNum`, player info field `quickPassCount` #140).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Confirm "Deseja entrar na campanha rapidamente?" (with income checkbox when `rapidPassNum > 0`) | | Captain creates the campaign | space NPC dialog option 109 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:731-742`): level >= 36, `checkScene()` | `rapidPassNum` |
| `core.InviteFrame` roomType 3 (`decompiled/core_module/scripts/yishi/view/frame/InviteFrame.as:133-168`, `:429-436`) | team invite with income checkbox; cancel and close disabled; timeout auto accepts | Teammates join | 16 `U_C_CAMPAIGN_ROOM_INVITE` with `room_type = 3` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:2248-2460`) | |
| `RapidThroughView` (`RTV`) in the campaign map | stage list "Fase {0}: Ao abrir o meso número de participantes de {1} poderá completar fase", progress "Já atingiu: {0}/{1}", current stage, timer, start button | Run HUD | campaign map 4801 (`decompiled/m3/scripts/map/campaign/mediator/rapidThrough/RapidThroughUIMediater.as`) | 405 |
| `RapidView` over teammates (`decompiled/m3/scripts/map/campaign/view/physics/CampaignArmyView.as:436-449`) | colors "Verde", "Azul", "Roxo", "Laranja", "Vermelho" | Shows the colors teammates hold | map | campaign data |
| `rapidthrouh.RapidThrouhtRankFrame` (`RTR`) | columns "Rank", "Nome", "Profissão", "Tempo encerrado"; "Última atualização: {0}" | Ranking, 8 rows per page, reward tips | NPC option 110 -> controller `rapidthrough` openType 1 (`decompiled/core_module/scripts/mvc/controler/RapidThroughController.as:21-29`), level >= 36 | 406 |

## 3. Routes (client to server)

All routes: send 9633 (0x25a1) `C_QUICKPASS_OP` with `campaign.CampaignReqMsg`: `para_int1` (#1, INT32) operation, `para_bool1` (#7, BOOL); other fields (`para_int2..5` #2..#5, `para_string1` #6, `server_name` #8, `isCross` #9) unused.

| # | UI control | Client sender | Client checks | Fields | Response |
|---|---|---|---|---|---|
| R1 | Captain confirm, teammate invite accept or timeout | `RTM.requestEnterRapidPass` -> `createMolongCampaign(true, useIncome)` (`RTM:61-113`), `InviteFrame.enterRapidThrough` | captain: in a team ("Favor formar equipe para entrar!"), team size >= 2 ("Equpe atual necessário mais de 3 pessoas."), captain ("Apenas o líder pode criar campanha!") | `para_int1 = 0`; `para_bool1 = true` when the player has no income left or chose not to use it, `false` to use one income | captain: campaign creation, 16 room invite (`room_type 3`) to teammates, then campaign enter flow ([campaign](../campaign/README.md)); 405 |
| R2 | "Iniciar" in the HUD | `RTM.requestRapidStart(1)` (`RTM:53-59`) from `RTV:172-185` | button enabled while not started | `para_int1 = 1` | 405 with `beginDate` |
| R3 | Rank frame open | `RTM.requestRapidStart(2)` from `RTR:90` | none | `para_int1 = 2` | 406 |

Stage interactions (opening chests, eggs, orifices) are campaign map node actions handled by the campaign module.

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 405 (0x0195) `U_C_QUICKPASSINFO` | `campaign.QuickPassInfoMsg`: `beginDate` (#1, STRING) start time (absent = not started); `saveDate` (#2, INT32) stage countdown in ms (client divides by 1000; 120 s triggers the stage pass animation); `turn` (#3, INT32) current stage; `pass` (#4, repeated `PassInfoMsg`: `index` (#1), `process` (#2) objects opened, `total` (#3) objects required), at most 9 entries | `RTM.returnUCQuickPassinfo` (`RTM:120-152`) -> `RTV` refresh (`RTV:280-310`) | After R1, R2 and on every stage progress |
| 406 (0x0196) `U_C_QUICKPASSRank` | `campaign.QuickPassRankMsg`: `updateTime` (#1, STRING); `myOrder` (#2, INT32); `pass` (#3, repeated `campaign.RankInfoMsg`: `order` (#1), `nickName` (#2), `passTime` (#3, INT32) seconds, `job` (#4)) | `RTM.returnUCQuickRankinfo` (`RTM:154-177`) | Reply to R3 |
| 16 (0x0010) `U_C_CAMPAIGN_ROOM_INVITE` | `room.RoomInviteMsg` with `room_type` (#6) = 3, `room_id` (#1), `player_id` (#2), `nick_name` (#3), `temp_id` (#7) | `BaseManager.__roomInviteHandler` | To teammates after the captain's R1 |
| 3 `U_C_PLAYER_INFO` | `PlayerMsg.quickPassCount` (#140, INT32) income runs left (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1181-1184`) | `PlayerManager` | Login and after a run |

## 5. Rules and formulas

- Requirements: level 36 at the NPC (campaign template allows 35+), team of at least 2 (the pt-BR text says more than 3), captain starts.
- 9 stages; each `PassInfoMsg.total` objects; stage time limit from `saveDate`; campaign `StandSecond = 600` (10 minutes, assumption: total time limit).
- Income: one rewarded run per income count (`quickPassCount`); a player may enter without using income (`para_bool1 = true`).
- Ranking: best completion time; rewards by rank range from `QuickPassRewards.xml` (`Ranking` = "min,max" or single rank, `TemplateId`, `Count`; parsed by `decompiled/core_module/scripts/yishi/datas/templates/cate/RapidThroughRewardCate.as:20-45`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/Campaigns.xml` row 4801 | campaign | `MinLevel`, `MaxLevel`, `Capacity`, `StandSecond`, `Item` |
| `raw/xml/tempinfos/QuickPassRewards.xml` | rank reward | `Ranking`, `TemplateId`, `Count` |

## 7. Persistent state

```sql
CREATE TABLE trials.rapid_through_daily (
    player_id     integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    play_date     date     NOT NULL,
    income_used   smallint NOT NULL DEFAULT 0,
    PRIMARY KEY (player_id, play_date)
);

CREATE TABLE trials.rapid_through_run (
    run_id        bigserial   PRIMARY KEY,
    captain_id    integer     NOT NULL REFERENCES player.players(player_id),
    started_at    timestamptz,
    finished_at   timestamptz,
    pass_seconds  integer,
    stage_reached smallint    NOT NULL DEFAULT 0
);

CREATE TABLE trials.rapid_through_member (
    run_id      bigint   NOT NULL REFERENCES trials.rapid_through_run(run_id) ON DELETE CASCADE,
    player_id   integer  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    use_income  boolean  NOT NULL,
    PRIMARY KEY (run_id, player_id)
);
CREATE INDEX rapid_through_run_rank_idx ON trials.rapid_through_run (pass_seconds) WHERE finished_at IS NOT NULL;
```

## 8. Backend implementation notes

- `trials::rapid_through::handle_op` dispatches on `para_int1`: 0 `handle_enter`, 1 `handle_start`, 2 `handle_rank`.
- Enter: captain creates campaign 4801 for the team (campaign module), sends room invite 16 (`room_type 3`) to teammates; each member's answer (also 9633 op 0) records the income choice.
- Start: set `started_at`, send 405 with `beginDate` to all members; stage object actions in the campaign map update `process`; when `process >= total` advance `turn`, push 405 to all.
- Finish: store `pass_seconds`, grant run rewards to members using income, update `quickPassCount` (push 3).
- Rank: best time per team (captain) or per player (assumption), top list with `myOrder`; ranking rewards at period end (period unknown).

## 9. Open questions and assumptions

- Stage objects, key and hammer color assignment are campaign map mechanics not covered here (campaign node events).
- Ranking period and reward delivery time are unknown.
- Minimum team size: code checks 2, text says more than 3.

## 10. Implementation checklist

- [ ] Tables `trials.rapid_through_daily`, `rapid_through_run`, `rapid_through_member`
- [ ] R1 enter with room invite 16 type 3
- [ ] R2 start, 405 progress pushes
- [ ] R3 ranking 406
- [ ] Income counter in player info #140
- [ ] Integration with campaign map 4801 stage objects
- [ ] Tests: team checks, income flag, ranking order
