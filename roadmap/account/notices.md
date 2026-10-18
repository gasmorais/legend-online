# Notices (update announcement) and client logging

Area: account, module `notices`. Covers the update announcement ("Anúncio de Atualização") shown on the loading screen (`notice.NoticeFrame`, module `18.png` / m18) and in game (`UpdateBroadCastFrame`), both fed by the static `{TEMPLATE_PATH}version.xml`; the system broadcast tip `111 U_C_CHANNEL_ALERT` as far as it concerns notices; and the client log upload servlet `logReuest`.

Conventions: see [login-session.md](login-session.md). Paths are relative to the repository root.

## 1. Overview

- The announcement is not a socket feature: the client downloads `version.xml` from the template server. During loading it is fetched on demand when the player clicks "notice" on the loading screen; in game it is preloaded with the startup resources (`decompiled/core_module/scripts/yishi/lunch/StartupResourcesLoader.as:130`, `:194-206`) and kept in `BaseManager.updateBroadcastContent`.
- After login, if `VersionMsg.open_version` is true and the player is level 25 or more in a normal scene, the in-game frame pops up once ([switches.md](switches.md), `decompiled/core_module/scripts/yishi/lunch/Yishi.as:600-604`). The minimap bar "update" button reopens it at any time.
- System broadcasts (`111`) are short center screen tips (maintenance warnings, event starts); their protocol is owned by [../chat/README.md](../chat/README.md).
- Client logging: the loader reports core parse failures to `logReuest`; the in-game logger is wired but its sender is a stub.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `notice.NoticeFrame` (`decompiled/m18/scripts/notice/NoticeFrame.as:22`) | "Anúncio de Atualização" (hardcoded, `NoticeFrame.as:92`) | Update notes while loading | Loading screen button `notice` (`decompiled/Loading/scripts/loading/MaxLoading.as:144`, `:183-230`); loads `18.png` first if needed | `time`, current notes (`curContent`), upcoming notes (`nextContent`) |
| `yishi.view.frame.UpdateBroadCastFrame` (style `mainToolBar.BroadCastFrame`, `decompiled/core_module/scripts/yishi/view/frame/UpdateBroadCastFrame.as:27`) | `yishi.view.UpdateBroadCastFrame.title` "Anúncio de Atualização" | Same content in game | Post login popup (`Yishi.as:600-604`), minimap button `smallMap.UpdateBtn` with tip `mainBar.SmallMapBar.updataBtnTipData_2` "Anúncio de Atualização" (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:306`, `:393`, `:823-852`) | Same; when `time` is missing shows tip `yishi.view.UpdateBroadCastFrame.Alert` "Não há comunicado de atualização" and closes |
| Center tip (`MessageTipManager`) | server text | System broadcast | `BaseManager.__serverBroadcastHandler` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:2171-2209`) | Text with `<... name="x">` tags replaced by `x` |

## 3. Routes (client to server)

### 3.1 HTTP `version.xml`

- Senders: `NoticeFrame.load` (`NoticeFrame.as:62-75`): `GET {TEMPLATE_PATH}version.xml?rnd=<random>` (`ComponentSetting.VERTION_PATH`, `decompiled/Loading/scripts/Loading.as:208`). In game: `StartupResourcesLoader.loadResources` through `PathManager.versionPath` (`decompiled/core_module/scripts/yishi/manager/PathManager.as:473-476`).
- Response format (read by `NoticeFrame.refreshView`, `NoticeFrame.as:149-241`, and `UpdateBroadCastFrame.refreshView`, `UpdateBroadCastFrame.as:170-262`):

```xml
<root>
  <time>2026-10-17</time>
  <curContent>
    <item><title>Novidades</title><content>Linha 1/nLinha 2</content></item>
  </curContent>
  <nextContent>
    <item><title>Em breve</title><content>...</content></item>
  </nextContent>
</root>
```

  - `time` is mandatory (frame closes otherwise). Any descendant `time` element is accepted (`xml..time[0]`).
  - Each `item` has optional `title` (yellow `#fef347`) and `content` (beige `#e4d9ba`, indented). The two characters `/n` are converted to line breaks.
  - The root element name is free (assumption: `root`).

### 3.2 HTTP `logReuest`

- Sender: `ErrorLog.sendLog(userId, text, config)` (`decompiled/Loading/scripts/ErrorLog.as:15-27`), called once by `NormalLuncher.unzipFile` when the core (`2.png`) fails to parse (`decompiled/Loading/scripts/NormalLuncher.as:194-200`).
- Request: `GET {REQUEST_PATH}logReuest`. The code puts `level=5000`, `text="UserId:<id>  <message>"`, `ran` into `URLLoader.data` instead of `URLRequest.data`, so in practice no parameters are sent (the request is a bare GET).
- In-game `logging.ServerLoggerImp` (`decompiled/core_module/scripts/logging/ServerLoggerImp.as:25-32`) builds the same fields (`level` 5000 info, 40000 error) but never sends them. `LoggerSys.logMode = 2` selects it (`decompiled/core_module/scripts/logging/LoggerSys.as:8-51`).
- Response: ignored.

## 4. Server messages (server to client)

### `111 U_C_CHANNEL_ALERT` (0x006f), `ChatChannelMsg` (package chat)

- Receiver: `BaseManager.__serverBroadcastHandler` (`BaseManager.as:2171-2209`), registered at `BaseManager.as:300`.
- Field used: `encode_msg (#3, STRING)`. The full message is documented in [../chat/README.md](../chat/README.md).
- Ignored before `6` LoginState (`loginState < 0`) and in battle. XML-like tags inside the text are replaced by their `name` attribute.
- Use for maintenance and operator notices: build `encode_msg` with plain pt-BR text.

## 5. Rules and formulas

- In-game popup conditions: level >= 25, normal scene, mail check popup not pending, no pending marriage question, `showVersion` true (`Yishi.as:581-625`).
- The loading screen notice and the doctor button are mutually exclusive (opening one disposes the other, `MaxLoading.as:186`, `:213-214`).

## 6. Templates

- `{TEMPLATE_PATH}version.xml`: announcement content, format in 3.1. Not present in `raw/xml/`; the backend must generate or serve it.

## 7. Persistent state

```sql
CREATE TABLE account.update_announcements (
  announcement_id  SERIAL      PRIMARY KEY,
  version_id       INT         REFERENCES account.client_versions(version_id),
  published_on     DATE        NOT NULL,
  is_current       BOOLEAN     NOT NULL DEFAULT false
);
CREATE UNIQUE INDEX update_announcements_current_idx ON account.update_announcements (is_current) WHERE is_current;

CREATE TABLE account.update_announcement_items (
  item_id          SERIAL      PRIMARY KEY,
  announcement_id  INT         NOT NULL REFERENCES account.update_announcements(announcement_id) ON DELETE CASCADE,
  section          TEXT        NOT NULL CHECK (section IN ('current', 'next')),
  sort_order       INT         NOT NULL DEFAULT 0,
  title            TEXT,
  content          TEXT
);
CREATE INDEX update_announcement_items_idx ON account.update_announcement_items (announcement_id, section, sort_order);

CREATE TABLE account.client_logs (
  log_id           BIGSERIAL   PRIMARY KEY,
  player_id        BIGINT      REFERENCES player.players(player_id),
  level            INT         NOT NULL,
  message          TEXT        NOT NULL,
  client_ip        INET,
  logged_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX client_logs_time_idx ON account.client_logs (logged_at DESC);
```

## 8. Backend implementation notes

- `account::notices::handle_version_xml` (`GET {TEMPLATE_PATH}version.xml`): render the current announcement; cache and invalidate on edit. Escape XML; keep `/n` as the line break marker.
- `account::notices::broadcast_system_tip(text)`: build `ChatChannelMsg {encode_msg: text}` and push `111` to every online player with `login_state >= 0` (delegate to the chat service).
- `account::notices::handle_log_request` (`GET/POST /logReuest`): accept optional `level`, `text`, store in `client_logs` with a rate limit per IP; always return 200 with empty body.
- Publishing an announcement should create a new `client_versions` row so `VersionMsg.open_version` pops it once ([switches.md](switches.md)).

## 9. Open questions and assumptions

- Assumption: root element name of `version.xml`.
- Open: the original content and date format of `time` (displayed as is).
- Open: whether the original `111` also drove the scrolling marquee; that belongs to chat.

## 10. Implementation checklist

- [ ] `version.xml` renderer and admin tables
- [ ] Loading screen notice frame displays the generated file
- [ ] In-game popup once per version and minimap button
- [ ] `111` system tip helper (with chat service)
- [ ] `logReuest` sink with rate limit
- [ ] Tables `account.update_announcements`, `account.update_announcement_items`, `account.client_logs`
- [ ] Test: missing `time` shows "Não há comunicado de atualização"
- [ ] Test: `/n` renders a line break

## Screens

- `IndulgeInfoFrame` (`decompiled/core_module/scripts/mainBar/view/IndulgeInfoFrame.as`, "Alerta de mensagem anti-vício", "Informação Anti-Vício", "Preencher informações anti-vício", "Após registrar, terá que acessar novamente no jogo.", "Prezado Usuário:") collects the anti-addiction identity data; on submit the client forces a relog.
