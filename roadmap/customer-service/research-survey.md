# Research survey (Questionário da Pesquisa)

Area: customer-service, module `research-survey`. Covers the template driven player survey (`m11/scripts/question`, `managers/QuestionManager`): 12 fixed multiple choice questions from `QuestionTemplates.xml`, a time window announced with the top toolbar push `4590` (activity id 4023), one submission `8673 C_QUESTION_CLIENT_OP`, the stored answers echo `4291 U_C_QUESTION_DATA`, and rewards from `QuestionDrop.xml` sent by mail.

Conventions: see [support-tickets.md](support-tickets.md). Paths are relative to the repository root.

## 1. Overview

- Distinct from the server driven [questionnaire.md](questionnaire.md): the questions here are client templates and the whole survey is answered on one screen.
- The server opens the event with `4590` (`param1 = 4023`, `param7 = true`, open and stop times). The top toolbar shows the "newquestion" button while open (`decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:413-414`); it opens controller `question` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1503-1504`).
- The player must answer all 12 questions (each with a maximum number of choices), then submits once. After submission (or if already submitted, known from `4291`) the frame shows the saved answers read only with the submit button disabled. Rewards: "Após participar da pesquisa, você obterá os prêmios abaixo! (eles serão enviados por e-mail)".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `question.QuestionFrame` (`decompiled/m11/scripts/question/QuestionFrame.as:31`) | `questionFrame.titleText.text` "Questionário da Pequisa" | Answer the survey | Top button "newquestion" via `mvc.controler.QuestionController` (`frameClassName = "question.QuestionFrame"`) | `questionFrame.remainTxt.text` "Término do evento:" + stop time (`QuestionFrame.as:189-218`), description `questionFrame.descTxt.text`, reward icons from `QuestionDrop` (`:146-164`), the 12 questions (`:166-187`), submit |
| `question.QuestionItem` (`decompiled/m11/scripts/question/QuestionItem.as`) | `questionItem.subjectTxt.text` "{0}, {1}" (id, subject) | One question with check buttons | Frame | Options split by `|`; at most `MaxChoose` selections, enforced by `GroupSelectObj` with tip `groupSelectObj.selected.tipTxt` (`decompiled/core_module/scripts/yishi/view/base/GroupSelectObj.as:36-87`) |

## 3. Routes (client to server)

### 3.1 `8673 C_QUESTION_CLIENT_OP` (C>S, 0x21e1)

- UI control: submit button `questionFrame.submitBtn`.
- Sender: `QuestionFrame.__submitBtnClickHandler` (`QuestionFrame.as:110-132`) -> `QuestionManager.send` (`decompiled/core_module/scripts/managers/QuestionManager.as:82-88`).
- Client-side check: every question has at least one selection, else tip `questionFrame.submitBtn.text` "A resposta à pergunta {0} ainda não foi feita, selecione sua resposta" with the 1-based question number.
- Request `PlayerOpMsg` (package player), only `param1 (#15, STRING)` set: per question, in template order, the selected option indexes (0-based) joined by `,`; questions joined by `|`. Example `"0,3|1|2,4,5|...|0"`. Other fields (`op (#1)`, `type (#2)`, `payType (#3)`, `count (#4)`, `id (#5)`, `index (#6)`, `userId (#7)`, `templateId (#8)`, `campaignId (#9)`, `nodeId (#10)`, `chapterId (#11)`, `uuid (#12)`, `value1 (#13)`, `value2 (#14)`, `param2 (#16)`, `flag1 (#17)`, `flag2 (#18)`, `pos (#19)`, `ids (#20, repeated)`) are unset.
- Expected response: `4291` with `param4` = the stored string (locks the form). Rewards by mail.

## 4. Server messages (server to client)

### `4590 U_C_TOP_TOOL_BTN` (0x11ee), simple `PropertyMsg`, activity 4023

- Receiver for this module: `QuestionManager.__topBtnHandler` (`QuestionManager.as:55-68`); `4590` is a shared top toolbar activity push and other managers react to other `param1` values.
- Fields used: `param1 (#1, INT32) = 4023`, `param7 (#7, BOOL)` open flag, `param4 (#4, STRING)` open time, `param5 (#5, STRING)` stop time "YYYY-MM-DD hh:mm:ss". Field table of the simple `PropertyMsg`: [../account/login-session.md](../account/login-session.md) section 4.
- Effect: `model.isOpen`, `openTime`, `stopTime`; refreshes the toolbar; an open frame closes when `isOpen` becomes false (`QuestionFrame.as:134-144`).
- When: at login (with the other activity buttons) and at window start and end.

### `4291 U_C_QUESTION_DATA` (0x10c3), simple `PropertyMsg`

- Receiver: `QuestionManager.__updateQuestionData` (`QuestionManager.as:70-80`): `param4 (#4, STRING)` (when present) = the player's stored answer string, same format as 3.1.
- Effect: non empty value fills the selections, disables every item and the submit button (`QuestionFrame.as:199-217`).
- When: at login if the player already answered, and as the response to `8673`.

## 5. Rules and formulas

- Questions and limits (`raw/xml/tempinfos/QuestionTemplates.xml`, fields `Id`, `Subject`, `Options`, `MaxChoose`): 12 questions; `MaxChoose` per question 3, 3, 5, 5, 5, 5, 8, 1, 10, 9, 1, 5; option counts 7, 8, 8, 6, 5, 7, 8, 11, 14, 10, 5, 6.
- One submission per player per survey window.
- Rewards: every row of `QuestionDrop.xml` with `dropId = 20300001`: 208500 x10, 208055 x20, 208017 x20, 2131521 x10, 212027 x50, all bound (`isBind="1"`); sent by mail.
- Visibility only depends on `isOpen` (no level gate in `TopBtnCheckShowHelper.as:413-414`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/QuestionTemplates.xml` | `QuestionTemplate`: one question | `Id` order and label, `Subject` text, `Options` `|` separated, `MaxChoose` max selections (`QuestionTempInfo`) |
| `raw/xml/tempinfos/QuestionDrop.xml` | `QuestionDropInfo`: one reward item | `itemId`, `count` shown; `dropId`, `isBind`, `validDate`, `appearType` for the server grant (`TempleteManager.questionDropTempCate`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1354-1355`) |

## 7. Persistent state

```sql
CREATE TABLE customer_service.research_survey_windows (
  window_id        SERIAL      PRIMARY KEY,
  opens_at         TIMESTAMP   NOT NULL,
  closes_at        TIMESTAMP   NOT NULL,
  drop_id          INT         NOT NULL DEFAULT 20300001,
  CHECK (closes_at > opens_at)
);

CREATE TABLE customer_service.research_survey_answers (
  window_id        INT         NOT NULL REFERENCES customer_service.research_survey_windows(window_id),
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  answer           TEXT        NOT NULL CHECK (answer ~ '^[0-9,]+(\|[0-9,]+)*$'),
  rewarded         BOOLEAN     NOT NULL DEFAULT false,
  answered_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (window_id, player_id)
);
```

## 8. Backend implementation notes

- `customer_service::research_survey::push_top_button` (login and window edges): `4590 {param1: 4023, param7: open, param4: opens_at, param5: closes_at}`.
- `customer_service::research_survey::push_answers` (login): if a row exists for the current window, `4291 {param4: answer}`.
- `customer_service::research_survey::handle_submit` (8673): validate window open, not answered, exactly 12 groups, each with 1..MaxChoose distinct indexes within the option count. Transaction: insert answer, send the `QuestionDrop` items by mail ([../mail/README.md](../mail/README.md)), mark rewarded. Reply `4291` with the stored string. On validation failure reply nothing (client keeps the form) (assumption).

## 9. Open questions and assumptions

- Assumption: `4291` is the response to `8673` (the client only listens for it).
- Open: whether 8673 is also used by other "question" activities with other `param1` formats (only this sender found).

## 10. Implementation checklist

- [ ] Window table and `4590` activity 4023 push
- [ ] `4291` at login and after submit
- [ ] `8673` validation against `QuestionTemplates.xml`
- [ ] Mail rewards from `QuestionDrop.xml`
- [ ] Tables `research_survey_windows`, `research_survey_answers`
- [ ] Test: second submission rejected
- [ ] Test: question 8 with two selections rejected (MaxChoose 1)
