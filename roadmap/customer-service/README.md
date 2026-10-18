# Customer service (Atendimento e questionários)

Feature slug `customer-service`, domain `account`. Player support and player feedback: support tickets with GM replies and ratings, two kinds of surveys, e-mail verification with a reward, the recharge rebate frame that lives in the `feedback` client package, and the loading screen diagnostic ("doctor").

Client packages (from `roadmap/features.json`): `customerService` (m11 views, `mvc/module/customerService`), `question` (m11, `mvc/module/question`), `questionnaire` (m11, `mvc/module/questionnaire`), `mailcheck` (m11, `mvc/module/mailcheck`), `feedback` (`core_module/scripts/feedback`), `doctor` (m18). Managers followed: `yishi/manager/CustomerServiceManager`, `managers/QuestionManager`, `yishi/manager/QuestionnaireManager`, `managers/MailCheckManager`, `managers/FeedBackManager`.

Proto packages: `customer` (`FastOpenCustomerMsg`, `QuestionReplayMsg`, `ReplayListMsg`), `questionnarie` (`QuestionDataRspInfo`, `QuestionDataRspMsg`, `QuestionInfoMsg`, `QuestionnarieInfoMsg`). Also used: `player.MailCheckMsg`, `player.PlayerOpMsg`, simple `PropertyMsg`, and `rebate.*` (owned by [../recharge/README.md](../recharge/README.md)).

## Player view

- "Comentário" button on the minimap bar: pick a problem type (game question, events, lost items, hacked account, recharge, suggestions, bug, report, complaint, other), describe it, attach a screenshot, send. GM answers make the button glow; the player can answer back or rate the answer.
- "Questionário" (top toolbar, level 20+): paged survey defined by the operators, with rewards.
- "Questionário da Pesquisa" (top toolbar while the event runs): 12 fixed market research questions, rewards by mail.
- "Verificação de email": verify an e-mail address with a PIN for 1000 bound diamonds and items; offered after login.
- Loading screen "doctor": checks client files and copies a report for support.

## Entry points

| Entry | Where | Condition |
|---|---|---|
| Minimap "Comentário" button | `decompiled/core_module/scripts/mainBar/SmallMapBar.as:538-542`, `:687-698` | Switch 3 open; 30 min cooldown after a ticket unless a reply arrived |
| Top toolbar `question` | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1066-1067` | Level >= 20, active survey (`4428` with `id != 0`) |
| Top toolbar `newquestion` | `TopToolsBar.as:1503-1504` | `4590` activity 4023 open |
| Mail check popup | `decompiled/core_module/scripts/yishi/lunch/Yishi.as:587-592`, `decompiled/core_module/scripts/managers/MailCheckManager.as:101-104` | Switch 3066, not verified, level >= 25 (login) or state 0/4 in sky city/castle |
| Top toolbar `feedback` | `TopToolsBar.as:1069-1074` | Level >= 6, rebate event running |
| Loading screen doctor | `decompiled/Loading/scripts/loading/MaxLoading.as:232-258` | While loading |

## Modules

| Module | File | Routes | Server messages | Tables |
|---|---|---|---|---|
| Support tickets | [support-tickets.md](support-tickets.md) | HTTP `complaintshandle`, `questionreplaylist` (types 0, 1, 2), `appraisereplayservlet`, `{UPLOAD_PATH}fileupload/upload` | `4376`, `4392` | `tickets`, `ticket_messages`, `ticket_ratings`, `uploads` |
| Questionnaire | [questionnaire.md](questionnaire.md) | `8534` (isFirst 0, 1, 2) | `4428`, `4429` | `surveys`, `survey_questions`, `survey_answers`, `survey_completions` |
| Research survey | [research-survey.md](research-survey.md) | `8673` | `4590` (activity 4023), `4291` | `research_survey_windows`, `research_survey_answers` |
| Email verification | [mail-check.md](mail-check.md) | `9591` (op 1, op 2) | `337` | `email_verifications` |
| Recharge rebate (`feedback` package) | [recharge-rebate.md](recharge-rebate.md) | `8574` (op 1, op 2) | `4461`, `4463` | `rebate_claims` |
| Loading doctor | [loading-doctor.md](loading-doctor.md) | CDN downloads, `crossdomain.xml` | none | none |

## Dependencies

- [../account/README.md](../account/README.md): session binding for servlets, login phase A flags `questionnarie` and `rebate_charge`, switches 3 (`CUSTOMER_SERVICE`), 11 (`VOICE`), 3066 (`MAIL_CHECK`), loading screen.
- [../mail/README.md](../mail/README.md): survey rewards by mail.
- [../inventory/README.md](../inventory/README.md), [../currency/README.md](../currency/README.md): item and bound diamond rewards.
- [../recharge/README.md](../recharge/README.md): owns the `rebate` protos and recharge points.
- [../daily-activity/README.md](../daily-activity/README.md): shared top toolbar activity push `4590`.

## Suggested implementation order

1. [mail-check.md](mail-check.md) (small, self contained, shown right after login).
2. [support-tickets.md](support-tickets.md) with a minimal GM admin endpoint.
3. [research-survey.md](research-survey.md) (templates already in `raw/xml/tempinfos`).
4. [questionnaire.md](questionnaire.md).
5. [recharge-rebate.md](recharge-rebate.md) together with the recharge feature.
6. [loading-doctor.md](loading-doctor.md) (verify static serving only).

## Notable gaps

- Ticket servlets carry no session key; the backend must bind them to the open session itself.
- `4376` handler reuses one object for all list elements: send one reply per packet.
- Reply and rating servlet results are never shown (callback signature mismatch in `CustomerServiceManager`).
- `4392` value is never read by the client.
- Mail check states 3 and 4 and the questionnaire reward delivery are inferred, not visible in the client.
- The `feedback` (rebate) frame has no pt-BR strings in `index/language.json`.
