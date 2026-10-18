# Online quiz ("Resposta de Inteligência")

Module `online-quiz` of feature `quiz`.

Path aliases:

| Alias | File |
|---|---|
| AM | `decompiled/core_module/scripts/yishi/manager/AnswerManager.as` |
| AMO | `decompiled/core_module/scripts/mvc/module/answer/AnswerModel.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/AnswerControler.as` |
| AF | `decompiled/m11/scripts/answer/AnswerFrame.as` |
| AV | `decompiled/m11/scripts/answer/view/AnswerView.as` |
| AQI | `decompiled/m11/scripts/answer/view/base/AnswerQuestionItem.as` |
| ARV | `decompiled/m11/scripts/answer/view/AnswerRankView.as` |
| CDT | `decompiled/m11/scripts/answer/view/base/CDTimeView.as` |

## 1. Overview

A server wide quiz session runs a state machine (`AnswerStateEnums`):

| state | Constant | Meaning | Client display |
|---|---|---|---|
| 0 | `ANSWER_STATE_UNSTART` | no session | toolbar hidden |
| 1 | `ANSWER_STATE_READY` | session announced, countdown to first question | "Início:", `CDTimeView` "Tempo de começo de perguntas:" (AF:116-124) |
| 2 | `ANSWER_STATE_READ` | question shown, cannot answer (5 s) | "Análise:", timer 5 s (AV:286-330) |
| 3 | `ANSWER_STATE_ASK` | answering window (15 s) | "Resposta:", timer 15 s (AV:331-350) |
| 4 | `ANSWER_STATE_ANSWER` | result shown (5 s) | "Próxima", right or wrong mark and score |
| 5 | `ANSWER_STATE_END` | session finished | rewards alert |

Options are shuffled on the client: `AnswerData.index` (1..4) is the server option number, `tmpIndex` is the display slot (AM:298-339).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `AnswerFrame` (AF) | "Resposta de Inteligência" | container, help "Ajuda", tip "Aviso: Quanto mais rápido responder, maior sua pontuação." | top toolbar `answer` | state, timers, rewards alert |
| `AnswerView` (AV) | | question, 4 `AnswerQuestionItem`, helper items with counts and tips, "Corretas:" and "Restantes:" | inside AF | `systemTotalNum`, `systemLastNum`, item tips "Ao usar dará dobro de pontos nessa pergunta (apenas essa pergunta)", "Ao usar dará diretamente a resposta correta ...", "Ao usar eliminará 2 respostas incorretas ..." |
| `AnswerRankView` (ARV) | "Colocação", "Personagem", "Pontos", "Ranking" | top 10 and self rank | inside AF | 4910 rows, self `ranKing`, `totalSocre`, `curExp` (AF:95-104) |
| Rewards alert | "Pergunta e Resposta Encerrada" | final score and experience | 4907 after state 5 (AM:230-234, AF:80-92) | "Evento encerrado, sua pontuação é {0}\nObtendo {1} experiência \nExperiência adicional de {2} pelo Ranking." or without the extra line |

While the frame is open, team and room invitations are ignored (`decompiled/core_module/scripts/yishi/manager/BraveLegManager.as:343-346`, `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2367-2370`).

## 3. Routes (client to server)

All use C>S 9501 (0x251d) `C_ANSWER_REQUEST_OPTION`, `AnswerquestionReqMsg { type (#1, INT32), count (#2, INT32) }`, sender `AM.sendRequestMsg` (AM:515-522). `type` = `AnswerOperationTypeEnums` (1 system, 2 item, 3 answer).

### R1. Open UI (`type 1`, `count 11`)
- Trigger: `AC.showFrame` -> `AM.sendRequestOpenUI` (AC, AM:485-504).
- Server: register the player as viewer; respond 4908 (current state, counts, timers), 4907 (player info), 4909 (current question if state 2..4, with `answer` per section 4), 4910 (top 10).

### R2. Close UI (`type 1`, `count 12`)
- Trigger: `AC.exitFrame` -> `AM.sendRequestCloseUI` (AM:506-513).
- Server: remove the viewer (still keeps his score for rewards).

### R3. Answer (`type 3`, `count = option index 1..4`)
- UI: click an option when its state is 0 (AQI:78-87) -> `SELECT_ANSWER` (AV:412-415) -> `AM.__onSelectAnswerHandler` (AM:117-127), `count = getIndexByTmp(tmp)` (AMO:183-199).
- Client effect: option marked selected, helpers eyes and heart disabled for this question.
- Server: accept once per question during state 3; compute score from the elapsed time; no immediate response is required (score appears in 4907 at state 4).

### R4. Use helper item (`type 2`, `count = 21 | 22 | 23`)
- UI: item buttons (AV:417-420) -> `AM.__onSelectItemHandler` (AM:129-182).
- Client checks: state not <= 1 and not >= 5 ("Evento ainda não aberto" / "Evento Encerrado"); 21 double: state 2 or 3 and `doubleCount > 0`; 22 heart: state 3 and `heartCount > 0`; 23 eyes: state 3 and `eyeCount > 0`.
- Server: consume one charge and push 4907 (lower count makes the client mark it used, AM:196-214); for 23 push 4909 with the same `id` and `answer` = two digit number of the wrong options to hide (for example 24); for 22 push 4909 with the same `id` and `answer` = correct option (< 10) and treat the question as answered correctly; for 21 double this question's score.

## 4. Server messages (server to client)

### S1. 4908 (0x132c) `U_C_ANSWER_SYSTEM_STATE`, `SysAnswerQuestionStateMsg`
Receiver `AM.__recieveSystemStateHandler` (AM:342-388).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `sysState` | #1 | INT32 | state 0..5 |
| `sysAnswerCount` | #2 | INT32 | total questions in the session ("Corretas:" label pairs with it) |
| `left_count` | #3 | INT32 | questions remaining ("Restantes:") |
| `begin_date` | #4 | STRING | numeric string, stored as `startTime` |
| `last_date` | #5 | STRING | numeric string in milliseconds: remaining time of the current state; client uses `int(last_date) / 1000` seconds |

Send to all viewers at every state change and on open. Client side transitions: 2 -> 3 clears the selection; 3 -> 4 marks unselected options; 4 -> 5 triggers the rewards alert on the next 4907; any 0 refreshes the toolbar.

### S2. 4909 (0x132d) `U_C_ANSWER_SINGLER_QUESTION`, `singleranswerquestionMsg`
Receiver AM:260-340.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `id` | #1 | INT32 | question number in the session |
| `question` | #2 | STRING | text |
| `option1..option4` | #3..#6 | STRING | options |
| `answer` | #7 | INT32 | 0 while hidden; in state 4 the correct option 1..4; after eyes a two digit code of wrong options; after heart the correct option |

New `id` -> new question (state 2 resets helpers). Same `id` in state 4 -> result display, score shown is the last score delta (AM:281-295).

### S3. 4907 (0x132b) `U_C_ANSWER_PLAYER_INFO`, `playeranswerquestionMsg`
Receiver AM:184-236.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `user_id` | #1 | INT32 | player |
| `curOrder` | #2 | INT32 | current rank |
| `currentScore` | #3 | INT32 | total score |
| `getEXP` | #4 | INT32 | experience earned so far |
| `playerAnswerSucCount` | #5 | INT32 | correct answers |
| `doubleBlessCount` | #6 | INT32 | helper 21 left |
| `wisdomHeartCount` | #7 | INT32 | helper 22 left |
| `choiceEyesCount` | #8 | INT32 | helper 23 left |
| `extraEXP` | #9 | INT32 | top 10 extra experience (end) |
| `go_date` | #10 | STRING | unused |

Send on open, after each helper use, after scoring (state 4) and at the end (state 5, with final experience).

### S4. 4910 (0x132e) `U_C_ANSWER_RANK_LIST`, `TenAnswerQuestionOrderMsg`
Receiver AM:238-258. `tenAQ_Info (#1, answerquestionorderMsg, repeated)` with `userId (#1, INT32)`, `nickName (#2, STRING)`, `curOrder (#3, INT32)`, `currentScore (#4, INT32)`. Send after each result to viewers.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Schedule | Mon, Wed, Fri 19:30-20:00; `AnswerQuestionTime` = 19:30:00 | `answer.view.helpHtmlTxt`, `ConfigInfos.xml` |
| Timings | read 5 s, answer 15 s, result 5 s | help text, AV timer clamps 5 and 15 |
| Score | faster gives more; wrong or none gives 1 (`SCORE_MIN = 1`) | help text, AM:26 |
| Level | 30 (`OPEN_GRADE`) | AM:28, AM:83-90 |
| Helpers | 21 double (states 2-3), 22 heart (state 3), 23 eyes (state 3); VIP extra | AM:141-175, help item 4 |
| Rewards | experience by score; top 10 extra | help item 5, `answer.view.rewards1` |
| Question count | server configuration (`sysAnswerCount`) | assumption: 30 |

## 6. Templates

No question bank XML in `raw/xml/tempinfos` (`QuestionTemplates.xml` is the questionnaire). Server needs its own bank (section 7). `ConfigInfos.xml` `AnswerQuestionTime`.

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS quiz;

CREATE TABLE quiz.questions (
  question_id     INTEGER PRIMARY KEY,
  body            TEXT NOT NULL,
  option1         TEXT NOT NULL,
  option2         TEXT NOT NULL,
  option3         TEXT NOT NULL,
  option4         TEXT NOT NULL,
  correct_option  SMALLINT NOT NULL CHECK (correct_option BETWEEN 1 AND 4),
  enabled         BOOLEAN NOT NULL DEFAULT true
);

CREATE TABLE quiz.sessions (
  session_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  starts_at       TIMESTAMPTZ NOT NULL,
  ends_at         TIMESTAMPTZ,
  question_count  SMALLINT NOT NULL,
  question_ids    INTEGER[] NOT NULL
);

CREATE TABLE quiz.participants (
  session_id      BIGINT NOT NULL REFERENCES quiz.sessions(session_id) ON DELETE CASCADE,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  score           INTEGER NOT NULL DEFAULT 0,
  correct_count   SMALLINT NOT NULL DEFAULT 0,
  exp_earned      INTEGER NOT NULL DEFAULT 0,
  extra_exp       INTEGER NOT NULL DEFAULT 0,
  double_left     SMALLINT NOT NULL,
  heart_left      SMALLINT NOT NULL,
  eyes_left       SMALLINT NOT NULL,
  rewarded        BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (session_id, player_id)
);
CREATE INDEX participants_rank ON quiz.participants (session_id, score DESC);

CREATE TABLE quiz.answers (
  session_id      BIGINT NOT NULL,
  player_id       BIGINT NOT NULL,
  question_no     SMALLINT NOT NULL,
  chosen_option   SMALLINT,
  answered_ms     INTEGER,
  used_double     BOOLEAN NOT NULL DEFAULT false,
  used_heart      BOOLEAN NOT NULL DEFAULT false,
  used_eyes       BOOLEAN NOT NULL DEFAULT false,
  points          INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (session_id, player_id, question_no),
  FOREIGN KEY (session_id, player_id) REFERENCES quiz.participants(session_id, player_id) ON DELETE CASCADE
);
```

The live session state (current question, phase deadline, viewer set) stays in memory.

## 8. Backend implementation notes

| Request | Handler |
|---|---|
| 9501 type 1 count 11 | `quiz::online_quiz::handle_open` |
| 9501 type 1 count 12 | `quiz::online_quiz::handle_close` |
| 9501 type 2 | `quiz::online_quiz::handle_use_item` |
| 9501 type 3 | `quiz::online_quiz::handle_answer` |

- Scheduler: at `AnswerQuestionTime` on Mon/Wed/Fri create a session, broadcast 4908 state 1 with countdown to all online level 30+ players (so the toolbar appears); loop questions: state 2 (5 s, push 4909 with `answer = 0`), state 3 (15 s), state 4 (5 s, push 4909 with the answer, score everyone, 4907 to each viewer, 4910 to viewers); after the last, state 5, grant experience, push 4907 with totals, then state 0.
- Score formula (assumption): `points = 1 + max(0, 15 - seconds_taken)` on a right answer, doubled with item 21; heart counts as right with full time score.
- Helper counts per session: base plus VIP bonus (assumption: VIP level table).
- Persist participants at session end in one transaction with experience grants.

## 9. Open questions and assumptions

- Exact scoring curve, experience formula, top 10 extra and helper counts per VIP level are server data not in the client.
- Encoding of `answer` after eyes: digits of the two removed option indexes (AMO:225-245).
- `begin_date` meaning (stored only).

## 10. Implementation checklist

- [ ] Screen `AnswerFrame` with view, rank, countdown and rewards alert
- [ ] Route 9501 open, close, answer, item
- [ ] Server messages 4908, 4909, 4907, 4910
- [ ] Scheduler (Mon/Wed/Fri 19:30, 30 minutes)
- [ ] Tables `quiz.questions`, `quiz.sessions`, `quiz.participants`, `quiz.answers`
- [ ] Rewards at state 5
- [ ] Tests: state machine timings, one answer per question, helper rules per state, score ordering
