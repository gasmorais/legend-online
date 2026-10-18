# Character creation, novice process servlets and rename

Area: account, module `register`. Covers the character creation screen of a new account (`MainFigureView`, servlet `visualizeregister`), the novice process servlet `updateplayernovice` (read and write), the tutorial skip servlet `selectjobregister`, the nickname check servlet `nicknamecheck` and the in-game rename (`8345` / `4271`), including the forced free rename for names marked with `!`.

Conventions: see [login-session.md](login-session.md). Paths are relative to the repository root.

## 1. Overview

- A new account (no `Item` in `loginselectlist`, or `Active="false"`) never reaches the socket before it has a character. After `login` succeeds, `Loading.checkLunch` (`decompiled/Loading/scripts/Loading.as:433-447`) sets `noviceProcess = 0` and runs `RegisterLuncher` (`decompiled/Loading/scripts/RegisterLuncher.as:65-201`), which loads the `mainloadingii` UI, forbidden word lists and the random name library, then shows `MainFigureView`.
- The player picks one of 6 portraits (3 classes x 2 sexes) and a name (prefilled with a random name, dice button rerolls). Confirm posts `visualizeregister`. On success the client writes novice process `10000` with `updateplayernovice op=1` and starts the normal game load ([login-session.md](login-session.md)).
- Returning players read their novice process with `updateplayernovice op=0` before the core loads (`Loading.reqNoviceProcess`, `Loading.as:449-464`).
- In game, a name can be changed with a rename card item (paid) or, when the server marks the name with `!` (for example after a server merge), with a forced free rename at login. Both validate with `nicknamecheck` first, then send `8345`.

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `register.MainFigureView` (`decompiled/Loading/scripts/register/MainFigureView.as:33`) | hint `noviceII.node.AddUserNameFrame.describt01` "Nome do Personagem deve conter de 4~12 caracteres" | Choose portrait and name | `RegisterLuncher.showRegisterView` (`RegisterLuncher.as:191-201`) | 6 `HeadComp` portraits, body art `asset.mainloadingii.register.RoleIcon_<headId>`, name input, dice button, confirm |
| `register.HeadComp` (`decompiled/Loading/scripts/register/HeadComp.as:29`) | n/a | Portrait button (`headId` 1..6) | `MainFigureView.initView` (`MainFigureView.as:117-122`) | Portrait bitmaps `asset.mainloadingii.register.head<headId>` |
| `yishi.view.community.RenameView` type 1 (`decompiled/core_module/scripts/yishi/view/community/RenameView.as:70`) | input tip, warning `describt00` "Renomeamento tomará efeito em 24 horas" | Rename with a rename card, has a close button | Item use menus: `GoodsItemMenu.as:928`, `PlayerBagCellClickMediator.as:968`, `InformationView.as:307` (m5), `ArmoryGoodsItemMenu.as:360` (m11) | Name input |
| `RenameView` type 2 | free rename tip `asset.rename.ReNameFreeTipAsset`, no close button | Forced free rename at login | `LoginInitDataAccept.renameUiCallback` (`decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:221-229`) | Name input |
| Skip tutorial confirm (`SimpleAlertHelper`) | `mainBar.SmallMapBar.content` "Pular tutorial?" | Skip the newbie flow | `SmallMapBar.__skipNewbieHandler` (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:898-903`), button `smallMap.NoviceCloseBtn` | Confirm / cancel |

Validation messages (all `noviceII.node.AddUserNameFrame.*`): `describt02` "Nome do Personagem em branco!", `describt03` "Nome do Personagem muito curto!", `describt04` "Nome do Personagem muito longo!", `describt05` "Nome do Personagem contêm caracteres inválidos!", `describt06` "Falha no nomeamento", `describt07` "Nome já existente", `describt08` "Nomeamento com sucesso"; load error `noviceII.view.AddUserNameFrame.checkNickErrorEvent2` "Falha ao carregar verificação de apelido".

## 3. Routes (client to server)

### 3.1 HTTP `visualizeregister` (create character)

- UI control: confirm button `mainloadingii.register.ChooseView.ConfirmBtn` or Enter in the name input (`MainFigureView.as:249-262`).
- Sender: `MainFigureView.loadRegister` (`MainFigureView.as:351-397`).
- Client-side checks, in order (`MainFigureView.as:353-381`): name with `\r` removed; empty -> `describt02`; byte length < 4 -> `describt03`; byte length > 12 -> `describt04`; contains a forbidden character or `FilterWordManager.filterWrod(name) != name` -> `describt05`. Byte length is `ByteArray.writeMultiByte(name, "")` (system code page) (`MainFigureView.as:275-280`, `:355-357`). Typing beyond 12 bytes is reverted (`MainFigureView.as:264-273`). The confirm button is disabled while the request runs.
- Request: `POST {REQUEST_PATH}visualizeregister` (loader type 7), fields:

| Field | Value |
|---|---|
| `client` | `DesktopManager.isDesktop` |
| `userid` | `userInfo.userId` (from `login`) |
| `nickname` | chosen name |
| `jumpnovice` | `0` |
| `camp` | `1` |
| `sex` | `headId % 2` (`MainFigureView.as:326-329`) |
| `icon` | portrait icon, see 5 |
| `username` | portal user |
| `site` | site |
| `key` | `MD5(tempPassword)` session key |
| `ran` | random |

- Response XML root attributes, read by `MainFigureView.__onRegisterCompleteHandler` (`MainFigureView.as:399-450`): `value` (`"true"`/`"false"`), `type` (int), `message` (text).
  - `value == "true"` and `type` 0 or 3: success. Disables input, calls `setFirstLeave`, sends `updateplayernovice op=1 noviceprocess=10000` (`NewbieSPHelper.saveNoviceProcess`, `decompiled/Loading/scripts/newbie/NewbieSPHelper.as:22-40`), and on its completion launches `MaxLoadingII` + `NormalLuncher` (`MainFigureView.as:459-472`, `RegisterLuncher.as:203-209`).
  - Anything else: re-enables confirm and shows `message` verbatim in red (`MainFigureView.as:438-449`). The server must therefore return pt-BR text, for example `describt07` "Nome já existente".
  - IO error: `checkNickErrorEvent2` (`MainFigureView.as:452-457`).
- Site `duowan_*` also pings a partner URL `playerNotify` (`MainFigureView.as:415-435`); ignore for BR.
- `Loading.register` (`Loading.as:339-361`) builds another `visualizeregister`/`visualizeregister2` call with an empty nickname, but nothing calls it (dead code).

### 3.2 HTTP `updateplayernovice op=1` (write novice process)

- Senders: `NewbieSPHelper.saveNoviceProcess` (`NewbieSPHelper.as:22-40`) after registration (value `10000`). In game the novice process is written over the socket with `5017` instead ([../tutorial/README.md](../tutorial/README.md)).
- Request: `POST {REQUEST_PATH}updateplayernovice`, fields `op=1`, `userid`, `noviceprocess`, `key`, `rnd`.
- Response: ignored (completion only).
- Constants (`NewbieSPHelper.as:11-15`): `NEWBIE_NAMEEND = 10000` (name chosen), `NEWBIE_START_CAMPAIGN = 11000`, `NEWBIE_GOTOCASTLE = 19000`.

### 3.3 HTTP `updateplayernovice op=0` (read novice process)

- Sender: `Loading.reqNoviceProcess` (`Loading.as:449-464`), for active accounts after `login`.
- Request: `POST {REQUEST_PATH}updateplayernovice`, fields `op=0`, `userid`, `noviceprocess=0`, `key`, `rnd`.
- Response: plain text integer, parsed with `int(data)` (`Loading.as:466-473`) into `userInfo.noviceProcess`. It drives which assets are preloaded ([login-session.md](login-session.md) section 5). A finished tutorial is `99900`.

### 3.4 HTTP `selectjobregister` (skip tutorial)

- UI control: skip tutorial button on the minimap bar (`SmallMapBar.as:305`, `:438`), confirm "Pular tutorial?".
- Sender: `SmallMapBar.skipNewbieCall` (`SmallMapBar.as:905-921`).
- Request: `GET {REQUEST_PATH}selectjobregister?userid=<id>&key=<session key>&jump=true&ran=<random>`.
- Response XML `@value`, `@type`. `value == "true"` and `type == 12` calls `NewbieModule.updateCurNode(19000)` (`SmallMapBar.as:923-934`); the class `NewbieModule` does not exist in this build, so the client side update throws and the change only takes effect on the next login ([../tutorial/novice-process.md](../tutorial/novice-process.md)). Server: set novice process to 19000 and apply the skip rewards defined by [../tutorial/README.md](../tutorial/README.md).

### 3.5 HTTP `nicknamecheck`

- Sender: `RenameView.loadCheckNickname` (`RenameView.as:152-187`), after the same client checks as 3.1 but on the trimmed name with `StringHelper.checkStringLength` (`decompiled/core_module/scripts/yishi/utils/StringHelper.as:29-34`).
- Request: `GET {REQUEST_PATH}nicknamecheck?nickname=<name>&rnd=<random>`.
- Response XML: `@value == "true"` allows the rename; otherwise `@message` is shown verbatim (`RenameView.as:195-218`). Also used by pet, child and market naming ([../einherjar/README.md](../einherjar/README.md), [../guardians/README.md](../guardians/README.md), [../auction/README.md](../auction/README.md), see `routes/routes.md`).

### 3.6 `8345 C_PLAYER_RENAME_REQ` (C>S, 0x2099)

- UI control: `rename.SubmitBtn` (or Enter), after `nicknamecheck` succeeded.
- Sender: `SocketSendManager.sendRename` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:464-472`), from `RenameView.__onCheckNicknameComplete` (`RenameView.as:200-210`).
- Request `PlayerRenameReqMsg` (package player):
  - `nick_name (#1, STRING)`: new name.
  - `type (#2, INT32)`: `1` rename card, `2` forced free rename.
  - `pos (#3, INT32)`: bag position of the rename card (type 1 only, `GoodsInfo.pos`), `0` otherwise.
- Expected response: `4271 U_C_PLAYER_RENAME_RSP`, then `3 PlayerMsg` with the new `nick_name` (assumption: the hero feature pushes the changed field) and the bag update for the consumed card ([../inventory/README.md](../inventory/README.md)).

## 4. Server messages (server to client)

### `4271 U_C_PLAYER_RENAME_RSP` (0x10af), `PlayerRenameRspMsg` (package player)

Fields: `result (#1, BOOL)`.

- Receiver: `RenameView.__playerRenameRspHandler` (`RenameView.as:231-244`), registered while the view is open (`RenameView.as:77`).
- `true`: closes the view and runs its callback; for type 2 this resumes the login (`LoginInitDataAccept.checkNickName` callback, `LoginInitDataAccept.as:204-229`). `false`: re-enables the submit button with no message, so the server should also push a chat or tip error (assumption: send a system tip with `describt06`/`describt07`).

## 5. Rules and formulas

- Portraits (`MainFigureView.as:117-122`, `:296-349`): `HeadComp1..6` carry `headId` 2, 1, 4, 3, 6, 5. A random portrait is preselected (`MainFigureView.as:156-158`).

| headId | sex (`headId % 2`) | icon sent | Class group (title row) |
|---:|---:|---:|---|
| 1 | 1 | 1 | title1 |
| 2 | 0 | 4 | title1 |
| 3 | 1 | 3 | title3 |
| 4 | 0 | 6 | title3 |
| 5 | 1 | 2 | title5 |
| 6 | 0 | 5 | title5 |

  So `icon = job + (sex == 0 ? 3 : 0)` with job 1 for headIds 1/2, job 3 for 3/4, job 2 for 5/6. Jobs: 1 Guerreiro, 2 Arqueiro, 3 Feiticeiro (`docs/mechanics/items_avatar.md`, `Job` column). Assumption: the server derives `job = ((icon - 1) % 3) + 1` and stores `pic = icon`; the 4th job (Encantador de Dragões) is not selectable at creation.
- Random name: `NamesLibManager.newName(sex)` = random family name + random given name list by sex (`decompiled/Loading/scripts/manager/NamesLibManager.as:34-50`), from `ui/zh_cn/nameslib.txt`.
- Name validation: 4..12 bytes, no character from the `unableChar` set, no forbidden word from `zip_dirty.txt` + `proxy_dirty.txt` (`decompiled/Loading/scripts/manager/FilterWordManager.as:48-55`, `:74-88`, `:269-290`). The server must re-run the same checks plus uniqueness (case insensitive, assumption).
- Session key: `visualizeregister`, `updateplayernovice` and `selectjobregister` must reject a `key` that does not match the open session of `userid`.
- Forced rename: a name containing `!` blocks the login until renamed (`LoginInitDataAccept.as:204-219`); the rename of type 2 is free.
- Rename card: type 1 consumes one rename card at `pos`. Warning text says the rename "takes effect in 24 hours" (`describt00`); assumption: name changes apply immediately in our server, and a cooldown of 24 h between paid renames is enforced.

## 6. Templates

- `raw/xml/zip_dirty.txt` (compressed forbidden words, also nickname extra words `NICKADDWORDS`), `raw/xml/proxy_dirty.txt` (agent forbidden words). The server should load the same lists for validation.
- `ui/zh_cn/nameslib.txt` (random names, client only).
- Rename card item template: the item whose use opens `RenameView(1, ...)`; see [../inventory/README.md](../inventory/README.md) for its `TemplateId` (assumption: the menu entry is keyed on the item's son type).

## 7. Persistent state

Character rows live in `player.players` (owned by [../hero/README.md](../hero/README.md)); this module adds:

```sql
CREATE TABLE account.player_registrations (
  player_id        BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  account_id       BIGINT      NOT NULL REFERENCES account.accounts(account_id),
  head_id          SMALLINT    NOT NULL CHECK (head_id BETWEEN 1 AND 6),
  icon             SMALLINT    NOT NULL CHECK (icon BETWEEN 1 AND 6),
  sex              SMALLINT    NOT NULL CHECK (sex IN (0, 1)),
  job              SMALLINT    NOT NULL CHECK (job BETWEEN 1 AND 3),
  camp             SMALLINT    NOT NULL DEFAULT 1,
  is_desktop       BOOLEAN     NOT NULL DEFAULT false,
  registered_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE account.player_names (
  name_lower       TEXT        PRIMARY KEY,
  player_id        BIGINT      NOT NULL UNIQUE REFERENCES player.players(player_id)
);

CREATE TABLE account.name_history (
  history_id       BIGSERIAL   PRIMARY KEY,
  player_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  old_name         TEXT        NOT NULL,
  new_name         TEXT        NOT NULL,
  rename_type      SMALLINT    NOT NULL CHECK (rename_type IN (0, 1, 2)),
  item_template_id INT,
  renamed_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX name_history_player_idx ON account.name_history (player_id, renamed_at DESC);

CREATE TABLE account.forbidden_words (
  word             TEXT        PRIMARY KEY,
  list             TEXT        NOT NULL CHECK (list IN ('dirty', 'proxy', 'nick_add'))
);
```

`player.players.novice_process` (INT, default 0) and `player.players.nick_name` are assumed to exist in the hero schema; `rename_type` 0 is the initial name.

## 8. Backend implementation notes

- `account::register::handle_visualize_register` (`POST /visualizeregister`):
  1. Validate session (`userid`, `key`) against `account.sessions`; fail `value="false" type="1" message="Falha no nomeamento"` (assumption for the code).
  2. Reject if `account_players.is_active` already true (`type="2"`, assumption).
  3. Validate `nickname` (bytes, characters, forbidden words); fail with `describt03/04/05` text.
  4. In one transaction: insert `account.player_names` (unique violation -> "Nome já existente"), create `player.players` with defaults from the hero feature (level 1, novice 0, `sex`, `pic = icon`, `job`, `camp`), insert `player_registrations`, set `account_players.is_active = true`, insert `name_history` type 0.
  5. Return `<Result value="true" type="0" message=""/>`.
- `account::register::handle_update_player_novice` (`POST /updateplayernovice`): validate session; `op=0` returns the stored integer as plain text; `op=1` stores `noviceprocess` only if it is greater than the stored value and a multiple of 100 (same rule as `PlayerManager.sendSaveProcess`, `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:2114-2126`), returns `ok`.
- `account::register::handle_select_job_register` (`GET /selectjobregister`): validate session; set novice 19000 via the tutorial service; return `<Result value="true" type="12"/>`.
- `account::register::handle_nickname_check` (`GET /nicknamecheck`): run validation and uniqueness; return `<Result value="true" message=""/>` or `value="false"` with the pt-BR message. No session needed (it is also used before pet naming).
- `account::register::handle_rename` (8345): validation order: name rules, uniqueness, type 2 requires the current name to contain `!`, type 1 requires a rename card at `pos` and cooldown elapsed. Transaction: swap `player_names` rows, update `player.players.nick_name`, consume the card (inventory service), insert `name_history`. Reply `4271 {result}`; on success push `3 PlayerMsg {nick_name}` and notify friends/guild caches.

## 9. Open questions and assumptions

- Assumption: `type` codes other than 0/3 in `visualizeregister` are free for errors; 3 probably meant "already registered, continue".
- Assumption: icon to job mapping derived from the portrait layout (section 5); confirm against the original `Job` of starter heroes in templates.
- Open: `camp` is always 1; camps are unused in BR.
- Open: `jumpnovice=0` is always sent at creation; skipping is handled later by `selectjobregister` and `8871` ([../tutorial/README.md](../tutorial/README.md)).
- Open: whether the rename card rename is delayed 24 h on the original server.
- Open (shared with tutorial): `updateplayernovice` (HTTP) and `5017` (socket) both write the novice process; keep a single column in `player.players` and treat both as writers of a monotonic maximum, as proposed in [../tutorial/novice-process.md](../tutorial/novice-process.md).

## 10. Implementation checklist

- [ ] Screen flow: register only for accounts without an active character
- [ ] `visualizeregister` with validation, uniqueness and character creation transaction
- [ ] `updateplayernovice` op 0 (plain integer) and op 1
- [ ] `selectjobregister` skip with `type="12"`
- [ ] `nicknamecheck`
- [ ] `8345` rename (types 1 and 2) and `4271` response
- [ ] Forbidden word lists loaded from `zip_dirty.txt` / `proxy_dirty.txt`
- [ ] Tables `account.player_registrations`, `account.player_names`, `account.name_history`, `account.forbidden_words`
- [ ] Test: name of 3 bytes and of 13 bytes rejected
- [ ] Test: duplicate name returns "Nome já existente" and the confirm button re-enables
- [ ] Test: login with `!` in the name blocks until type 2 rename succeeds
- [ ] Test: rename card consumed exactly once
