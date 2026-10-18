# Questionnaire (Questionário, server driven survey)

Area: customer-service, module `questionnaire`. Covers the paged survey whose questions are sent by the server (`4428 U_C_QUESTIONNARIE_LIST`), answered page by page (`8534 C_QUESTIONNARIE_ANSWER`) and acknowledged with the list of answered questions (`4429 U_C_QUESTIONNARIE_ANSWER`). Proto package `questionnarie`.

Conventions: see [support-tickets.md](support-tickets.md). Paths are relative to the repository root.

## 1. Overview

- The server announces an active survey during the login bulk load (`PlayerDataMsg.questionnarie = true`, [../account/login-session.md](../account/login-session.md)). A survey with `id != 0` shows the top toolbar button "question" for players of level 20 or more.
- Opening the frame asks the server which questions are already answered; the frame shows the first remaining "page" (consecutive questions with the same `contenType`). "Next" submits the page; the server returns the answered list; the client removes them and shows the next page. The last page shows the "End" button, which submits with `isFirst = 2`, hides the button and closes the frame.
- Rewards (`itemId1..4`, `count1..4`) are sent in the survey message but the client does not display them; the server grants them when the survey is finished (assumption: by mail, [../mail/README.md](../mail/README.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `questionnaire.QuestionnaireFrame` (`decompiled/m11/scripts/questionnaire/QuestionnaireFrame.as:60`) | `questionnaire.QuestionnaireFrame.titleText` "Questionário"; header `titleField` "Conteúdo do Questionário" | Paged survey | Top toolbar button key `question` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1066-1067`), visible when level >= 20 and `questionnaireVisible` (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:245-246`) | Intro text `content` on the first page, questions of the current page, Next / End button |
| `questionnaire.view.QuestionItem` (`decompiled/m11/scripts/questionnaire/view/QuestionItem.as`) | question title | One question | Frame | Options `a..i` as multi select (`type != 0`, style `questionnaire.SelectText`) or single select (`type == 0`, `questionnaire.SingleSelectText`); option `j` as "other" with a free text input when `j` ends with `"1"` (label = first 6 characters of `j`) (`QuestionItem.as:110-152`, `QuestionnaireFrame.as:101-149`) |

Controller: `mvc.controler.QuestionnaireController` (`decompiled/core_module/scripts/mvc/controler/QuestionnaireController.as:19-25`), key `questionnaire`. Model: `mvc.module.questionnaire.QuestionnaireModel`.

## 3. Routes (client to server)

### 3.1 `8534 C_QUESTIONNARIE_ANSWER` (C>S, 0x2156)

Sender: `QuestionnaireManager.sendQuestionAnswer(isFirst, id, infolist)` (`decompiled/core_module/scripts/yishi/manager/QuestionnaireManager.as:101-109`).

Request `QuestionDataRspMsg` (package questionnarie):

- `isFirst (#1, INT32)`: `0` open (no answers), `1` submit a page, `2` submit the last page and finish.
- `id (#2, INT32)`: survey id from `4428`.
- `infolist (#3, MESSAGE QuestionDataRspInfo, repeated)`: `questId (#1, INT32)`, `answer (#2, STRING)`.

| Action | UI | Client checks | isFirst |
|---|---|---|---|
| Open | Top button | survey visible | 0, empty list (`QuestionnaireController.as:19-25`) |
| Next page | "Próximo" button (`questionnaire.NextStepBtn`) | enabled only when every question of the page has an answer (`QuestionnaireFrame.as:288-298`) | 1 (`QuestionnaireFrame.as:214-227`) |
| Finish | "End" button (`questionnaire.EndBtn`) | same | 2; client sets `questionnaireVisible = false` and closes |

`answer` format (`QuestionItem.answerData`, `QuestionItem.as:177-197`): the texts of the selected options, each followed by `|`, then the free text followed by `|` when the "other" option is selected, for example `"Fórum/BBS|Amigos|"`. Options whose text equals `"other:"` (`public.colon` with "other") are skipped.

Expected response: `4429` with the answered questions (for 0 and 1). For 2: assumption, `4428` with `id = 0` after granting the rewards.

## 4. Server messages (server to client)

### `4428 U_C_QUESTIONNARIE_LIST` (0x114c), `QuestionnarieInfoMsg` (package questionnarie)

Fields:

| Field | Meaning |
|---|---|
| `id (#1, INT32)` | Survey id; `0` = no active survey (hides the button) |
| `title (#2, STRING)` | not read |
| `content (#3, STRING)` | Intro text on the first page |
| `itemId1 (#4, INT32)`, `count1 (#5, INT32)` .. `itemId4 (#10, INT32)`, `count4 (#11, INT32)` | Reward items (stored in `questionGoodList`, not displayed) |
| `questiones (#12, MESSAGE QuestionInfoMsg, repeated)` | Questions in display order |

`QuestionInfoMsg`: `id (#1, INT32)`, `title (#2, STRING)`, `type (#3, INT32)` 0 single choice, non zero multiple choice, `contenType (#4, INT32)` page group, `a (#5)` .. `i (#13)` option texts (STRING, empty = absent), `j (#14, STRING)` "other" option, active when its last character is `1`.

- Receiver: `QuestionnaireManager.__getQuestionnaireHandler` (`QuestionnaireManager.as:56-91`), registered at `:52`.
- When: during login phase A when the player has an unfinished active survey; push when a survey starts or ends.

### `4429 U_C_QUESTIONNARIE_ANSWER` (0x114d), `QuestionDataRspMsg` (package questionnarie)

Fields as in 3.1; `infolist` = every question the player already answered (`answer` non empty and not `"0"`).

- Receiver: `QuestionnaireManager.__getAnswerHandler` (`QuestionnaireManager.as:93-99`) -> `QuestionnaireModel.answerList` setter (`decompiled/core_module/scripts/mvc/module/questionnaire/QuestionnaireModel.as:77-103`): removes those question ids from the list and fires `QUESTIONNAIRE_FRESH`, which renders the next page (`QuestionnaireFrame.as:229-275`). An empty remaining list closes the frame and hides the button.
- When: response to `8534` with `isFirst` 0 or 1.

## 5. Rules and formulas

- Visibility: level >= 20 and `id != 0`.
- Paging: one page = the leading run of remaining questions with equal `contenType`. The page with the last question shows "End".
- Every question of the page must be answered before Next is enabled.
- The server must accept answers only for questions of the current survey and only once per question.

## 6. Templates

None; surveys are server data (admin defined).

## 7. Persistent state

```sql
CREATE TABLE customer_service.surveys (
  survey_id        SERIAL      PRIMARY KEY,
  title            TEXT        NOT NULL,
  intro            TEXT        NOT NULL DEFAULT '',
  min_level        SMALLINT    NOT NULL DEFAULT 20,
  starts_at        TIMESTAMPTZ NOT NULL,
  ends_at          TIMESTAMPTZ NOT NULL,
  reward_items     JSONB       NOT NULL DEFAULT '[]'::jsonb,
  CHECK (ends_at > starts_at),
  CHECK (jsonb_array_length(reward_items) <= 4)
);

CREATE TABLE customer_service.survey_questions (
  question_id      INT         NOT NULL,
  survey_id        INT         NOT NULL REFERENCES customer_service.surveys(survey_id) ON DELETE CASCADE,
  sort_order       INT         NOT NULL,
  page_group       INT         NOT NULL,
  multiple_choice  BOOLEAN     NOT NULL DEFAULT false,
  title            TEXT        NOT NULL,
  options          TEXT[]      NOT NULL CHECK (cardinality(options) <= 9),
  other_label      TEXT,
  PRIMARY KEY (survey_id, question_id)
);

CREATE TABLE customer_service.survey_answers (
  survey_id        INT         NOT NULL,
  question_id      INT         NOT NULL,
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  answer           TEXT        NOT NULL,
  answered_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (survey_id, question_id, player_id),
  FOREIGN KEY (survey_id, question_id) REFERENCES customer_service.survey_questions(survey_id, question_id)
);

CREATE TABLE customer_service.survey_completions (
  survey_id        INT         NOT NULL REFERENCES customer_service.surveys(survey_id),
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  completed_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  rewarded         BOOLEAN     NOT NULL DEFAULT false,
  PRIMARY KEY (survey_id, player_id)
);
```

`reward_items`: `[{"item_id": 208500, "count": 10}, ...]`. `other_label` is sent as `j` with a trailing `1`.

## 8. Backend implementation notes

- `customer_service::questionnaire::push_login_survey` (login phase A, flag `questionnarie`): if an active survey exists, the player level >= `min_level` and no completion row, send `4428`; else nothing (or `id = 0`).
- `customer_service::questionnaire::handle_answer` (8534):
  1. Load the active survey; mismatch `id` -> reply `4428 {id: 0}`.
  2. `isFirst = 0`: reply `4429` with the stored answers.
  3. `isFirst = 1` or `2`: in one transaction insert `survey_answers` (ignore duplicates, trim to 500 characters); reply `4429` with all answered questions.
  4. `isFirst = 2` and every question answered: insert `survey_completions`, send the reward items by mail ([../mail/README.md](../mail/README.md)), set `rewarded`, push `4428 {id: 0}`.
- Survey start/end: scheduler pushes `4428` to online eligible players.

## 9. Open questions and assumptions

- Assumption: rewards are granted by mail on completion (the client never shows them).
- Assumption: `4428 {id: 0}` after finishing.
- Open: the original meaning of `title` (unused) and whether partial answers were kept across sessions (the open request `isFirst = 0` suggests yes).

## 10. Implementation checklist

- [ ] Admin tables `surveys`, `survey_questions`
- [ ] `4428` at login and on survey start/end
- [ ] `8534` handler for isFirst 0, 1, 2
- [ ] `4429` answered list
- [ ] Rewards by mail and completion row
- [ ] Tables `survey_answers`, `survey_completions`
- [ ] Test: two page survey with mixed single/multiple choice and "other" text
- [ ] Test: reopening mid survey resumes on the first unanswered page
