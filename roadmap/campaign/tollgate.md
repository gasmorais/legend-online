# Tollgates ("Chegada dos Deuses" protocol)

Module `tollgate` of [campaign](README.md). The `tollgate` protobuf package and the opcodes 8752..8755 / 4645..4647 belong to a "诸神降临" (gods arrival, "Chegada dos Deuses") tollgate event: timed stages with attempts, scores, a score ranking and stage rewards. In this BR client **no screen consumes the tollgate event messages**; only the Solo Pass ("天穹之径", trials feature) reuses two of the request opcodes. This module documents the full protocol so it can be implemented if needed and specifies the part Solo Pass depends on.

## 1. Overview

| Opcode | Name (`protocol/opcodes.csv`) | Chinese description (`CM/yishi/datas/consant/ProtocolTypeTable.as:496-498, 1301-1304`) | Client use |
|---|---|---|---|
| 8752 | C_TOLLGATE_GET_REWARD | 诸神降临活动领取奖励 (claim reward) | no sender |
| 8753 | C_TOLLGATE_REQUEST | 诸神降临活动请求信息 (request info) | **Solo Pass info request** |
| 8754 | C_TOLLGATE_SCORE | 诸神降临活动请求积分排行榜 (request score ranking) | no sender |
| 8755 | C_TOLLGATE_REQUEST_ATTACK | 诸神降临活动请求挑战 (request a challenge) | **Solo Pass attack** |
| 4645 | U_C_TOLLGATE_IS_OPEN | 诸神降临活动开启与关闭 (event open/close) | no listener |
| 4646 | U_C_TOLLGATE_SCORE | 诸神降临活动积分排行榜 (score ranking) | no listener |
| 4647 | U_C_TOLLGATE_REWARD | 诸神降临活动通关奖励结果 (clear reward result) | no listener |

- Boss data for the gods arrival tollgates would come from `CampaignData.xml` (`GodArriveTemplateCate`, campaign 40001, `getGodArriveData(40001, tollgate)`), which is **empty** in the BR dump (`docs/mechanics/world_progression.md` §2.6); `TollgateReward.xml` is empty too.
- Solo Pass (OpenGrades `SINGLE_PASS` = level 60, `CM/yishi/OpenGradesII.as:216`; 100 stages in 10 floors; `SinglePass_Count` = 10 attempts per day) uses 8753 and 8755 with `player.ChallengeMsg` (not `tollgate.ChallengeMsg`) and receives `tollgate.SinglePassMsg` on **4552**. Its UI and the other opcodes (4551, 4553, 4554, 8636..8640) are owned by [../trials/README.md](../trials/README.md).

## 2. Screens

None in this feature. Solo Pass screens (`M11/singlepass/view/SinglePassView.as` and siblings) are in the trials feature; it calls 8753 on open (`SinglePassView.as:87`).

## 3. Routes (client to server)

| # | Action | Sender (file:line) | Client checks | Route | Request | Server response |
|---|---|---|---|---|---|---|
| T1 | Solo Pass info | `SinglePassSocketOutManager.sendRequestSinglePassInfo` (`CM/managers/SinglePassSocketOutManager.as:17-23`), caller `M11/singlepass/view/SinglePassView.as:87` | none | C>S **8753 (0x2231) C_TOLLGATE_REQUEST** | `player.ChallengeMsg`: `type (#4, INT32)` = 0; `tar_userId (#1)`, `tar_armyId (#2)`, `pay_type (#3)`, `uuid (#5)` unset | **4552** `tollgate.SinglePassMsg` |
| T2 | Solo Pass attack a stage | `SinglePassManager.sendRequestSinglePassAttack(index)` (`CM/managers/SinglePassManager.as`) -> confirm "Deseja iniciar essa missão?" / "Você ainda não obteve avaliação máxima, deseja tentar novamente esse desafio?" -> `SinglePassSocketOutManager.sendRequestSinglePassAttack(index)` (:25-31) | `count < SinglePass_Count` or owns item 3140001 ("Limite de desafios do dia atingido"); `index <= maxIndex + 1` ("Favor concluir primeiro a fase anterior"); stage not at max judge 5 ("Você já atingiu a Avaliação Máxima nesta missão. Tente outra fase") | C>S **8755 (0x2233) C_TOLLGATE_REQUEST_ATTACK** | `player.ChallengeMsg`: `type (#4)` = 0, `tar_userId (#1, INT32)` = stage index 1..100 | battle 157 with battleType 293 `SINGLE_PASS` (`CM/yishi/datas/battle/BattleType.as:68`); after the battle **4552** with the new state |
| T3 | Event info (not used) | none | | 8753 with `type != 0` *(assumption)* | `player.ChallengeMsg{type}` | 4645 + `TollgateMsg` *(assumption)* |
| T4 | Event score ranking (not used) | none | | C>S **8754 (0x2232) C_TOLLGATE_SCORE** | *(assumption: no body)* | 4646 |
| T5 | Event reward claim (not used) | none | | C>S **8752 (0x2230) C_TOLLGATE_GET_REWARD** | *(assumption: no body)* | 4647 |

## 4. Server messages (server to client)

### 4.1 Used: 4552 for Solo Pass

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **4552 (0x11c8) U_C_RES_SINGLEPASS_INFO** | `tollgate.SinglePassMsg`: `user_id (#1, INT32)`, `area (#2, INT32)` current floor, `max_index (#3, INT32)` highest cleared stage, `area_reward (#4, STRING)`, `rankInfo (#5, tollgate.RankInfoMsg, repeated)`, `count (#6, INT32)` attempts used today, `item_count (#7, INT32)` bugles received | `SinglePassManager.__resSinglePassInfoHandler` (`CM/managers/SinglePassManager.as:57`), also `SkyboxRoadManager.as:66`, `QueueBarManager.as:88` | reply to 8753 and after each attack | stage judges, floors, bugle tip at first load (`int(maxIndex / 5) * 2 - item_count` bugles left) |

`tollgate.RankInfoMsg` (AS class `CM/com/road/yishi/proto/tollgate/RankInfoMsg.as:70-80`): `index (#1, INT32)` stage, `rank (#2, INT32)` judge (5 = max). **Not** the `campaign.RankInfoMsg{order, nickName, passTime, job}` that `protocol/proto.json` shows under the same short name.

### 4.2 Event messages (no consumer in this client)

Field tags verified in `CM/com/road/yishi/proto/tollgate/*.as`.

| Message | Fields |
|---|---|
| `TollgateMsg` (`TollgateMsg.as:330-412`) | `type (#1, INT32)`, `user_id (#2, INT32)`, `end_time (#3, STRING)`, `order (#4, INT32)`, `score (#5, INT32)`, `remain_count (#6, INT32)`, `remain_time (#7, INT32)`, `challengeInfo (#8, tollgate.ChallengeMsg, repeated)`, `scoreInfo (#9, ChallengeScoreMsg, repeated)`, `isOpen (#10, BOOL)`, `cur_tollgate_id (#11, INT32)`, `lucky_reward (#12, STRING)`, `remain_buy_count (#13, INT32)`, `start_time (#14, STRING)`, `add_time_count (#15, INT32)` |
| `tollgate.ChallengeMsg` (`ChallengeMsg.as:160-192`) | `tollgate_id (#1, INT32)`, `attack_userid (#2, INT32)`, `attack_name (#3, STRING)`, `attack_time (#4, STRING)`, `remain_time (#5, INT32)`, `last_hp (#6, INT32)` |
| `ChallengeScoreMsg` (`ChallengeScoreMsg.as:258-308`) | `user_id (#1, INT32)`, `tollgate_id (#2, INT32)`, `score (#3, INT32)`, `order (#4, INT32)`, `is_lucky (#5, BOOL)`, `nick_name (#6, STRING)`, `is_vip (#7, BOOL)`, `grade (#8, INT32)`, `consortia_name (#9, STRING)`, `fight_capacity (#10, INT32)` |
| `TollgateRewardMsg` (`TollgateRewardMsg.as:138-163`) | `user_id (#1, INT32)`, `score (#2, INT32)`, `order (#3, INT32)`, `score_items (#4, STRING)`, `lucky_items (#5, STRING)` |
| `ChallengeRewardMsg` (`ChallengeRewardMsg.as:90-105`) | `user_id (#1, INT32)`, `message (#2, STRING)`, `items (#3, STRING)` |

Probable mapping *(assumption)*: 4645 -> `TollgateMsg` (`isOpen`, times, attempts), 4646 -> `TollgateMsg.scoreInfo`, 4647 -> `TollgateRewardMsg` or `ChallengeRewardMsg`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Event attempts | `tollgate_count` = 5 base attempts | ConfigInfos ("诸神降临基础次数") |
| Event diamond challenge | `tollgate_attack_count` = 10 diamonds | ConfigInfos ("诸神降临花费钻石挑战") |
| Event extra attempts cap | `tollgate_add_count` = 1000 | ConfigInfos ("诸神降临购买额外挑战次数上限") |
| Event max cost step | `tollgate_add_time_count` = 20 | ConfigInfos ("诸神降临扣除最大费用对应次数") |
| Solo Pass stages | 100 (`10 * 10`), 10 per floor; floor reward when `max_index == area * 10` ("Ainda não concluiu todas as fases deste Piso") | `CM/mvc/module/singlepass/SinglePassModel.as:60-110`; `SinglePassManager.sendRequestGetAreaReward` |
| Solo Pass attempts | `SinglePass_Count` = 10 per day; item 3140001 allows more | ConfigInfos; `SinglePassManager.sendRequestSinglePassAttack` |
| Solo Pass judge | max 5 per stage | `SinglePassModel.isMaxJudge` (:234-242) |

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/TollgateReward.xml` | empty (`<TollgateReward/>`) |
| `raw/xml/tempinfos/CampaignData.xml` | empty; would hold `GodArriveData` (`CampaignId 40001`, `Level` = tollgate, `HeroIds`, `BattleType`, `Formation`, `Param1..6`) |
| `ConfigInfos.xml` | keys above |

## 7. Persistent state (schema `campaign`)

Solo Pass state is owned by the trials feature. For the event (only if implemented):

```sql
CREATE TABLE campaign.tollgate_event (
  event_id     integer PRIMARY KEY,
  start_at     timestamptz NOT NULL,
  end_at       timestamptz NOT NULL,
  CHECK (end_at > start_at)
);

CREATE TABLE campaign.tollgate_player (
  event_id       integer NOT NULL REFERENCES campaign.tollgate_event(event_id) ON DELETE CASCADE,
  player_id      BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  score          integer NOT NULL DEFAULT 0,
  cur_tollgate_id integer NOT NULL DEFAULT 1,
  remain_count   smallint NOT NULL DEFAULT 5,
  bought_count   smallint NOT NULL DEFAULT 0 CHECK (bought_count <= 1000),
  reward_claimed boolean NOT NULL DEFAULT false,
  PRIMARY KEY (event_id, player_id)
);
CREATE INDEX tollgate_player_score ON campaign.tollgate_player (event_id, score DESC);
```

## 8. Backend implementation notes

| Handler | Opcode | Effects |
|---|---|---|
| `campaign::tollgate::handle_request` | 8753 | `type 0`: delegate to `trials::single_pass::handle_info` (reply 4552). Other types: event info (4645) *(assumption)* |
| `campaign::tollgate::handle_attack` | 8755 | `type 0`: delegate to `trials::single_pass::handle_attack` (battle 293, then 4552). Other types: event challenge |
| `campaign::tollgate::handle_score` | 8754 | event ranking 4646 (optional) |
| `campaign::tollgate::handle_get_reward` | 8752 | event reward 4647 (optional) |

Priority: implement only the Solo Pass delegation; the event part has no client.

## 9. Open questions and assumptions

1. Original request bodies of 8752 and 8754 and the exact response message of 4645..4647.
2. Whether `ChallengeMsg.type != 0` selected the gods arrival event on 8753/8755.

## 10. Implementation checklist

- [ ] 8753 `type 0` -> trials Solo Pass info -> 4552 (`tollgate.SinglePassMsg` with `tollgate.RankInfoMsg{index, rank}`)
- [ ] 8755 `type 0` -> trials Solo Pass attack -> battle 293 -> 4552
- [ ] Encoders keyed by package (`tollgate.RankInfoMsg` vs `campaign.RankInfoMsg`, `tollgate.ChallengeMsg` vs `player.ChallengeMsg`)
- [ ] Optional: event tables and 8752/8754, 4645..4647
