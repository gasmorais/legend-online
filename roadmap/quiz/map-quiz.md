# Map quiz (campaign map 5101)

Module `map-quiz` of feature `quiz`.

Path aliases:

| Alias | File |
|---|---|
| CSM | `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as` |
| QAM | `decompiled/m3/scripts/map/campaign/mediator/QuizActivity/QuizActivityMediator.as` |
| QV | `decompiled/m3/scripts/map/campaign/view/ui/QuizActivity/QuizView.as` |
| QTT | `decompiled/m3/scripts/map/campaign/view/ui/QuizActivity/QuizTopTenView.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| WBH | `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as` |

## 1. Overview

A quiz played by moving. In campaign map 5101 (`WBH:275-278`) the server pushes a two option question with a deadline. Standing in the left half of the map (`curPosX * 20 <= Width / 2`) selects option 1, the right half selects option 2 (QAM:95-106, QV:170-196). When time runs out the correct side is highlighted for 5 s ("Contagem decrescente para a próxima pergunta: {0}"). The server evaluates positions, updates the top 10 ("Lista de resultados    Nome da Personagem      Perguntas correctas") and a personal line "A minha pontuação: {0}   Respostas correctas: {1}/{2}".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `QuizView` (QV) | | question, two options, countdown "Contagem decrescente: {0}" | mediator init when the campaign map is 5101 or `campaignTemplate.Types == 17` (`decompiled/m3/scripts/map/campaign/view/CampaignMapView.as:324-326`) | `id.question`, "Ande para a Esquerda" + option1, "Ande para a Direita:" + option2, selected side colour |
| `QuizTopTenView` (QTT) | "Resultado das Respostas" | top 10 and self line | same | 4692 and 4695 |

The UI skin `quiz` is preloaded when entering map 5101 (`decompiled/core_module/scripts/yishi/scene/SceneCreate.as:340-342`). Leaving shows "As perguntas ainda não terminaram, deseja sair?" (language key `quiz.exitScene`; caller not found in this client).

## 3. Routes (client to server)

No quiz specific request. The answer is the player's position, sent by the normal campaign walk packets (see [campaign](../campaign/README.md)). Entering and leaving map 5101 use the campaign enter and leave routes.

## 4. Server messages (server to client)

### S1. 4694 (0x1256) `U_C_SHOW_QUIZ_BTN`, `AnswerQuestionMsg`
Receiver `BM.__showQuizHandler` (BM:1035-1048). `isOpen (#1, BOOL)` sets `GlobalConfig.isQuizOpen` and refreshes the toolbar. No toolbar key reads the flag in this client (gap). Send at activity start and end.

### S2. 4693 (0x1255) `U_C_GET_QUESTION`, `SingleAnswerQuestionMsg`
Receiver `CSM.__getQuestionHandler` -> `sendGetQuestion` (CSM:384, 824-836) -> `QV.__getQuestionHandler` (QV:168-197).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `id` | #1 | INT32 | question number; for `id == 1` the view stays hidden while more than 25 s remain |
| `question` | #2 | STRING | text |
| `option1` | #3 | STRING | left option |
| `option2` | #4 | STRING | right option |
| `result` | #5 | INT32 | correct side: 1 left, else right (QV:130-137) |
| `time` | #6 | STRING | deadline as epoch milliseconds; countdown = `(time - now) / 1000`, shown when <= 25 s |

Send for each question to everyone in map 5101 at least 25 s before the deadline.

### S3. 4692 (0x1254) `U_C_QUIZ_RANKING`, `AnswerQuestionRankListMsg`
Receiver CSM:386, 799-810 -> `QAM.updateAllRankInfo`. `answerQuestionRank (#1, AnswerQuestionRankMsg, repeated)`: `userId (#1, INT32)`, `nickName (#2, STRING)`, `job (#3, INT32)`, `rightCount (#4, INT32)`, `point (#5, INT32)`, `rank (#6, INT32)`.

### S4. 4695 (0x1257) `U_C_QUIZ_RANKING_MY_INFO`, `AnswerQuestionPlayerMsg`
Receiver CSM:385, 812-822 -> `QTT.updateMyInfoTips`. `rank (#1, INT32)`, `point (#2, INT32)`, `rightCount (#3, INT32)`, `totalCount (#4, INT32)`, `rankGolden (#5, INT32)`, `exp (#6, INT32)`, `golden (#7, INT32)` (reward preview used by `QuizRewordTips`, `decompiled/core_module/scripts/yishi/view/tips/goods/QuizRewordTips.as:56-60`). Default text uses 30 as total questions (QTT:47).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Map | 5101 | WBH:275-278 |
| Side split | x pixel = `curPosX * 20` vs `mapTempInfo.Width / 2` | QAM:95-106 |
| Question visible | last 25 s before deadline; result 5 s after | QV:100-140 |
| Questions per session | 30 (client default) | QTT:47 |
| Rewards | gold and experience by rank and right answers (`rankGolden`, `golden`, `exp`) | 4695 fields |

## 6. Templates

None in XML. Question bank shared with [online-quiz.md](online-quiz.md) using options 1 and 2 only (assumption) or a separate two option bank.

## 7. Persistent state

```sql
CREATE TABLE quiz.map_sessions (
  session_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  starts_at       TIMESTAMPTZ NOT NULL,
  ends_at         TIMESTAMPTZ,
  total_count     SMALLINT NOT NULL DEFAULT 30
);

CREATE TABLE quiz.map_participants (
  session_id      BIGINT NOT NULL REFERENCES quiz.map_sessions(session_id) ON DELETE CASCADE,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  points          INTEGER NOT NULL DEFAULT 0,
  right_count     SMALLINT NOT NULL DEFAULT 0,
  rewarded        BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (session_id, player_id)
);
CREATE INDEX map_participants_rank ON quiz.map_participants (session_id, right_count DESC, points DESC);
```

## 8. Backend implementation notes

- No request handler. Scheduler `quiz::map_quiz::run_session`: broadcast 4694 `isOpen = true`, then per question push 4693 to map members, at the deadline read each member's last known position from the campaign map state, update `right_count` and `points`, push 4692 to all and 4695 to each; at the end grant rewards (mail or direct) and push 4694 `isOpen = false`.
- Use the server side position, never a client claim.

## 9. Open questions and assumptions

- How players enter map 5101 (campaign list entry or NPC) is outside this feature; the toolbar flag from 4694 is unused.
- Points formula and reward amounts are unknown.

## 10. Implementation checklist

- [ ] Map 5101 scene and overlays
- [ ] Server messages 4694, 4693, 4692, 4695
- [ ] Position based evaluation at deadline
- [ ] Tables `quiz.map_sessions`, `quiz.map_participants`
- [ ] Rewards at session end
- [ ] Tests: side split at Width/2, timing windows, ranking order
