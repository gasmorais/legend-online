# Support tickets (Comentário / atendimento)

Area: customer-service, module `support-tickets`. Covers the in-game customer service frame: submitting a ticket by category with an optional screenshot, receiving GM replies (HTTP list at login plus socket push `4376`), reading, replying to and rating a reply. Almost everything goes over HTTP servlets on `{REQUEST_PATH}` and an upload server on `{UPLOAD_PATH}`; the socket only carries the reply push and an unused "can open" flag.

Conventions used in this file:

- Paths are relative to the repository root. AS3 citations use `decompiled/<module>/scripts/<path>.as:<line>`.
- Opcodes come from `protocol/opcodes.csv`. "C>S" is client to server, "S>C" is server to client.
- Protobuf fields are written `name (#tag, TYPE, repeated?)` from `protocol/proto.json`.
- "Assumption" marks behavior not visible in client code.

## 1. Overview

- Button "Comentário" on the minimap bar opens the frame when switch type 3 (`CUSTOMER_SERVICE`) is open; the button glows when a GM reply is waiting ([../account/switches.md](../account/switches.md)).
- If a reply is pending the frame opens directly on it ("ServiceReplyView") and marks it read; otherwise it opens the category selector with "Consulta de Problemas do Jogo" selected.
- A ticket is a title, a description (8 to 800 characters), an occurrence date and category specific fields, plus an optional image. After a successful submission the button is blocked for 30 minutes ("Seu problema está sendo solucionado, aguarde resposta antes de enviar novamente") until a reply arrives.
- On a reply the player can continue the conversation (reply) or rate it (Muito Satisfeito, Satisfeito, Razoável, Péssimo) with a comment.

## 2. Screens

| Class | pt-BR title / text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `customerService.CustomerServiceFrame` (`decompiled/m11/scripts/customerService/CustomerServiceFrame.as:55`) | `customerservice.CustomerServiceFrame.title` "Comentário" | Container with category combo box and the current view | Minimap button (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:687-698`), mail check frame link (`decompiled/m11/scripts/mailcheck/MailCheckFrame.as:226-244`, opens with category 6), item lock set view link (`decompiled/core_module/scripts/mainBar/vicePassword/SetVPView.as:163-169`) | Category list `problemList` (`decompiled/core_module/scripts/mvc/module/customerService/CustomerServiceModel.as:121-155`) |
| `ConsultingGameView` (category 1) | `customerService.view.ConsultingGameView.systemDescTxt` (rules text) | Game question | default | title, date bar, description, upload button; voice entries when switch 11 (`VOICE`) is open (`decompiled/m11/scripts/customerService/view/ConsultingGameView.as:32`) |
| `ActivityView` (2) | "Consulta de Eventos" | Event question | combo | `activity_name`, yes/no `activity_is_error` (`ActivityView.as:61-72`) |
| `GoodsMissView` (3) | "Anormalia de Perda de Acessórios" | Lost item | combo | `goods_get_method`, `goods_get_date` (`GoodsMissView.as:33-37`) |
| `HanckingView_1` / `HanckingView_2` (4) | "Problemas de Hack"; rules `customerservice.HanckingView_1.content1..23` | Hacked account, page 1 rules then page 2 form | combo | same fields as 3 with required checks `CustomerServiceManger.goodsTimeNull/goodsWayNull` (`HanckingView_2.as:62-79`) |
| `ChargeView` (5) | "Problemas de Recarga" | Payment problem | combo | `charge_order_id`, `charge_method`, `charge_moneys` (`ChargeView.as:37-42`) |
| `ProposalView` (6), `BugReportView` (7), `ReportIllegalView` (8), `OtherView` (10) | "Comentários e Sugestões", "Comentários de BUG", "Reportar Ilegalidades", "Outros" | Generic | combo | base fields |
| `ComplainView` (9) | "Reclamações" | Complaint | combo | `user_full_name` (required, `CustomerServiceManger.playerNameNull`), `user_phone`, `complaints_title`, `complaints_source` (`ComplainView.as:48-61`) |
| `ServiceReplyView` | reply view | Show the GM reply | auto when a reply is pending (`CustomerServiceFrame.as:203-212`) | title, player text, `replayContent`, date; "continue" disabled when `stopReply` (`ServiceReplyView.as:50-53`) |
| `PlayerToReplyView` | reply form | Answer the GM | "continue" (`ServiceReplyView.as:79-82`) | description |
| `EvaluationPlayersView` | `customerservice.EvaluationPlayersView.veryGood/good/general/poor` | Rate the reply | "result posted" (`ServiceReplyView.as:84-87`) | grade 4..1 and comment |
| `ContactFrame` | `customerservice.view.ContactFrame.title` "Modo de contato" | Static contact info (phone `0755-61886777`, Chinese original) | contact button | static |
| `tool.TimeBar` | year/month/day combos | Occurrence date | base view | `Date(year, month, day)` (`decompiled/m11/scripts/customerService/view/tool/TimeBar.as:229-232`) |

Shared base: `CustomerServiceBaseView` (`decompiled/m11/scripts/customerService/view/CustomerServiceBaseView.as`): description max 800 characters with counter `customerservice.CustomerServiceBaseView.content01` "(Min. de 8 letras,{0} letras restantes)" (`:134-173`), text inputs max 20 characters (`:293`), submit debounce 5 s with tip `activity.view.ActivityItem.command01` "Clique excessivo, tente novamente" (`:224-249`).

## 3. Routes (client to server)

All HTTP posts use `application/x-www-form-urlencoded` (`URLVariables`). Base fields always present in `model.data`: `user_id` (player id), `question_type` (category 0..10) (`CustomerServiceModel.refreshData`, `CustomerServiceModel.as:157-167`).

### 3.1 HTTP `complaintshandle` (submit a ticket)

- UI control: submit button of any category view.
- Sender: `CustomerServiceBaseView._submitBtnHandler` (`CustomerServiceBaseView.as:207-222`) -> `CustomerServiceManager.sendHttpRequest` (`decompiled/core_module/scripts/yishi/manager/CustomerServiceManager.as:230-248`). URL `PathManager.customerPath` = `{REQUEST_PATH}complaintshandle` (`decompiled/core_module/scripts/yishi/manager/PathManager.as:600-603`).
- Client-side checks (`CustomerServiceManager.checkBlank`, `:316-334`): title not empty (`content05` "Título em branco"), description not empty (`content06`), description length >= 8 (`content07`); category 0 not allowed (`customerservice.CustomerServiceSelectedView.content` "Escolha tipo de pergunta"); category specific required fields; 5 s debounce.
- Fields: `user_id`, `question_type`, `question_title`, `question_content`, `occur_time` (AS3 `Date.toString()`, for example "Sat Oct 17 00:00:00 GMT-0300 2026"), `pic_url` = `/fileupload/pic/<fileName>` when an image was chosen (`CustomerServiceManager.as:97-105`), plus the category fields of section 2.
- Response: plain integer text, read by `_onResultCompleted` (`CustomerServiceManager.as:270-296`):

| Value | Client reaction |
|---:|---|
| 1 | `content01` "Enviado com sucesso"; `hasSubmit = true`; `lastReplyTime = now` (button blocked 30 min) |
| 0 | `content02` "Falha ao enviar" |
| -2 | `content03` "4 vezes ultrapassadas" (daily limit reached) |
| -3 | `content04` "Erro desconhecido" |
| other | nothing |

- When an image was selected, the client uploads it right after the post (3.5).

### 3.2 HTTP `questionreplaylist` type 0 (load replies)

- Trigger: once at login, `CustomerServiceManager.setup` -> `getReplyList` (`CustomerServiceManager.as:67-72`, `:151-164`), called from `Yishi.setupManager` (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:729`).
- Request: `POST {REQUEST_PATH}questionreplaylist` with `user_id`, `type=0` (`PathManager.as:605-608`).
- Response: binary, zlib compressed UTF-8 XML (`CustomerServiceManager.as:166-186`). Each `Info` element anywhere in the document is decoded into `ServiceReplyInfo` by attribute name (`decompiled/core_module/scripts/yishi/resolve/QuestionReplyInfoResolve.as:18-24`, `decompiled/core_module/scripts/mvc/module/customerService/ServiceReplyInfo.as`): `questionId`, `type`, `userId`, `Site`, `title`, `content`, `replayUserName`, `replayContent`, `stopReply`, `employ`, `date`. Only unread replies should be listed; a non empty list makes the button glow (`new_reply`).

### 3.3 HTTP `questionreplaylist` type 1 (mark read)

- Trigger: opening the frame on a pending reply (`CustomerServiceFrame.as:203-212`).
- Sender: `CustomerServiceManager.sendRead` (`CustomerServiceManager.as:129-142`): `user_id`, `type=1`, `question_id`.
- Response ignored.

### 3.4 HTTP `questionreplaylist` type 2 (player reply)

- UI: `PlayerToReplyView` submit (`decompiled/m11/scripts/customerService/view/PlayerToReplyView.as:58-62`).
- Sender: `CustomerServiceManager.sendServiceReply` (`CustomerServiceManager.as:250-268`): base fields plus `question_title` (from the reply), `nick_name`, `question_id`, `type=2`, `reply_content` (the text), `question_content=""`.
- Response: integer like 3.1, but the callback signature does not match the loader (`LoaderManagerII` passes `LoaderInfo`, the handler expects an `Event` and returns early), so the client shows nothing (`CustomerServiceManager.as:262`, `:270-276`).

### 3.5 HTTP upload `fileupload/upload`

- UI: upload button (`CustomerServiceBaseView.as:178-205`) opens a file browser filtered to jpg, gif, png, jpeg, bmp (`CustomerServiceManager.as:84-95`).
- Sender: `CustomerServiceManager.sendImg` (`CustomerServiceManager.as:107-118`): `FileReference.upload` (multipart, field name `Filedata`, Flash default) to `{UPLOAD_PATH}fileupload/upload` (`PathManager.as:615-618`), with file name `<site>_<userId>_<GUID><ext>`.
- Response: ignored (`uploadCompleteData` only clears the name). The server must store the file so that `pic_url` `/fileupload/pic/<name>` resolves.

### 3.6 HTTP `appraisereplayservlet` (rate a reply)

- UI: `EvaluationPlayersView` submit (`decompiled/m11/scripts/customerService/view/EvaluationPlayersView.as:99-111`); grade required (`customerService.view.EvaluationPlayerView.content01` "Selecione nível de avaliação").
- Sender: `CustomerServiceManager.sendEvaluate` (`CustomerServiceManager.as:298-314`): base fields plus `question_title`, `question_id`, `appraisal_grade` (4 Muito Satisfeito, 3 Satisfeito, 2 Razoável, 1 Péssimo, `EvaluationPlayersView.as:80-97`), `appraisal_content`, `question_content=""`. Same title/description checks as 3.1.
- Response: integer, ignored for the same callback reason as 3.4. URL `PathManager.customerSubmitEvaluatePath` (`PathManager.as:610-613`).

## 4. Server messages (server to client)

### `4376 U_C_QUESTION_REPLAY` (0x1118), `ReplayListMsg` (package customer)

Fields: `questionInfos (#1, MESSAGE QuestionReplayMsg, repeated)`.

`QuestionReplayMsg`: `question_id (#1, STRING)`, `type (#2, INT32)` category, `user_id (#3, INT32)`, `title (#4, STRING)`, `content (#5, STRING)` player text, `replay_content (#6, STRING)` GM text, `commit_time (#7, BYTES)` 7 bytes: year int16 big-endian, month 1..12, day, hour, minute, second (`decompiled/core_module/scripts/com/road/pb/helper/PkgHelper.as:13-21`), `replay_user_name (#8, STRING)` GM name, `employ (#9, INT32)`, `stop_reply (#10, INT32)` 1 disables "continue".

- Receiver: `CustomerServiceManager._messageHandler` (`CustomerServiceManager.as:197-222`), registered at `:81`.
- When: push when a GM answers a ticket of an online player.
- Client quirk: one `ServiceReplyInfo` object is reused for every element of the list, so only the last element survives (`CustomerServiceManager.as:203-220`). Send one reply per packet.
- Effect: glow on the button, re-enables it (`lashReplyTime = 0`).

### `4392 U_C_OPEN_CUSTOMER` (0x1128), `FastOpenCustomerMsg` (package customer)

Fields: `can_open (#1, INT32)`.

- Receiver: `PlayerManager._openCustomerHandler` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1731-1737`) stores `openCustomerServiceFrame`. No code reads the value; optional.

## 5. Rules and formulas

- Cooldown: after a successful submit the button refuses to open for 1 800 000 ms of server time (`CustomerServiceModel.canOpen`, `CustomerServiceModel.as:265-276`), unless a reply arrives.
- Daily limit: the server answers `-2` after 4 tickets per day (text "4 vezes ultrapassadas"; assumption: per player per server day).
- Description length 8..800, text fields 20 characters, image types jpg/gif/png/jpeg/bmp.
- Categories (id: pt-BR): 1 "Consulta de Problemas do Jogo", 2 "Consulta de Eventos", 3 "Anormalia de Perda de Acessórios", 4 "Problemas de Hack", 5 "Problemas de Recarga", 6 "Comentários e Sugestões", 7 "Comentários de BUG", 8 "Reportar Ilegalidades", 9 "Reclamações", 10 "Outros" (`CustomerServiceModel.as:121-155`, language `customerservice.CustomerServiceModel.content02..11`).
- Gate: switch 3 (`CUSTOMER_SERVICE`) enables the button (`SmallMapBar.as:538-542`).

## 6. Templates

None. Category names come from `index/language.json`.

## 7. Persistent state

Schema `customer_service`.

```sql
CREATE TABLE customer_service.tickets (
  ticket_id          BIGSERIAL   PRIMARY KEY,
  player_id          BIGINT      NOT NULL REFERENCES player.players(player_id),
  category           SMALLINT    NOT NULL CHECK (category BETWEEN 1 AND 10),
  title              TEXT        NOT NULL CHECK (length(title) BETWEEN 1 AND 100),
  content            TEXT        NOT NULL CHECK (length(content) BETWEEN 8 AND 800),
  occurred_on        DATE,
  picture_path       TEXT,
  extra              JSONB       NOT NULL DEFAULT '{}'::jsonb,
  status             SMALLINT    NOT NULL DEFAULT 0 CHECK (status IN (0, 1, 2, 3)),
  stop_reply         BOOLEAN     NOT NULL DEFAULT false,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX tickets_player_idx ON customer_service.tickets (player_id, created_at DESC);
CREATE INDEX tickets_open_idx ON customer_service.tickets (status) WHERE status IN (0, 1);

CREATE TABLE customer_service.ticket_messages (
  message_id         BIGSERIAL   PRIMARY KEY,
  ticket_id          BIGINT      NOT NULL REFERENCES customer_service.tickets(ticket_id) ON DELETE CASCADE,
  author_kind        SMALLINT    NOT NULL CHECK (author_kind IN (0, 1)),
  author_name        TEXT        NOT NULL,
  body               TEXT        NOT NULL,
  picture_path       TEXT,
  employ             INT         NOT NULL DEFAULT 0,
  read_at            TIMESTAMPTZ,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX ticket_messages_unread_idx ON customer_service.ticket_messages (ticket_id) WHERE author_kind = 1 AND read_at IS NULL;

CREATE TABLE customer_service.ticket_ratings (
  ticket_id          BIGINT      PRIMARY KEY REFERENCES customer_service.tickets(ticket_id) ON DELETE CASCADE,
  grade              SMALLINT    NOT NULL CHECK (grade BETWEEN 1 AND 4),
  comment            TEXT,
  rated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE customer_service.uploads (
  file_name          TEXT        PRIMARY KEY,
  player_id          BIGINT      REFERENCES player.players(player_id),
  content_type       TEXT        NOT NULL,
  size_bytes         INT         NOT NULL CHECK (size_bytes <= 2097152),
  storage_path       TEXT        NOT NULL,
  uploaded_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

`status`: 0 open, 1 answered, 2 closed by player rating, 3 closed by GM. `author_kind`: 0 player, 1 GM. `extra` holds the category fields (`activity_name`, `charge_order_id`, and so on).

## 8. Backend implementation notes

- Servlets do not carry the session key, only `user_id`. Bind them to the session: require the client IP and an open session of that player ([../account/login-session.md](../account/login-session.md)); reject otherwise (assumption, the original did not authenticate).
- `customer_service::support_tickets::handle_complaints` (`POST /complaintshandle`): validate switch 3, the field rules and the daily limit (`count(*) WHERE created_at >= server day start` < 4); insert `tickets` and the first `ticket_messages` row; return `1`, `0`, `-2` or `-3` as text.
- `customer_service::support_tickets::handle_reply_list` (`POST /questionreplaylist`): `type=0` returns zlib compressed `<Result><Info .../></Result>` with unread GM messages of the player; `type=1` sets `read_at`; `type=2` appends a player message and sets the ticket status back to 0 unless `stop_reply`. Return `1`.
- `customer_service::support_tickets::handle_appraise` (`POST /appraisereplayservlet`): insert `ticket_ratings`, close the ticket, return `1`.
- `customer_service::support_tickets::handle_upload` (`POST {UPLOAD_PATH}fileupload/upload`): accept images up to 2 MB, store under the given name after sanitizing it to `[A-Za-z0-9_.-]`, return `1`. Serve `GET /fileupload/pic/<name>` to the GM tool only.
- GM tool (admin API, not in client): answering a ticket inserts a GM message and, if the player is online, pushes `4376` with that single reply.
- `4392` may be sent at login with `can_open = 1` for fidelity.

## 9. Open questions and assumptions

- Assumption: limit of 4 tickets per day from the "4 vezes ultrapassadas" text.
- Assumption: servlets need session binding even though the original only used `user_id`.
- Open: meaning of `employ` (possibly "adopted" suggestion flag) and of `Site` in the list.
- Open: whether the original GM replies also arrived by in-game mail.

## 10. Implementation checklist

- [ ] Customer service button gated by switch 3, glow on pending reply
- [ ] `complaintshandle` with validation, daily limit and result codes
- [ ] `questionreplaylist` types 0 (compressed XML), 1, 2
- [ ] `appraisereplayservlet`
- [ ] Upload endpoint and picture storage
- [ ] GM answer flow and `4376` push (one reply per packet)
- [ ] Optional `4392`
- [ ] Tables `customer_service.tickets`, `ticket_messages`, `ticket_ratings`, `uploads`
- [ ] Test: description of 7 characters rejected client and server side
- [ ] Test: fifth ticket of the day returns `-2`
- [ ] Test: reply pushed while online opens the reply view on next click
