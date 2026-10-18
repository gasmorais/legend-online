# Login and session

Area: account, module `login-session`. Covers the portal hand-off, the HTTP login servlets (`loginselectlist`, `login`, `login2`) with the login queue, the socket gateway login (`20001`), the first player snapshot (`3`), the staged initial data load (`8224` sent three times), the login state (`6`), duplicate login kick (`3842`), disconnect handling, time sync, the client capability report (`flashversionservlet`) and the anti-addiction (AAS) hooks that the BR build keeps switched off.

Conventions used in this file:

- Paths are relative to the repository root. AS3 citations use `decompiled/<module>/scripts/<path>.as:<line>`.
- Opcodes come from `protocol/opcodes.csv`. "C>S" is client to server (`send` rows), "S>C" is server to client (`accept` rows).
- Protobuf fields are written `name (#tag, TYPE, repeated?)` from `protocol/proto.json`.
- Wire format (header, cipher, checksum) is documented once in `protocol/socket.md`; it is not repeated here.
- "Assumption" marks behavior not visible in client code.

Related modules: [server-select.md](server-select.md) (site node, server list row, RSA key), [register.md](register.md) (character creation, novice process servlet, rename), [switches.md](switches.md) (`4422`, `4233`), [security-code.md](security-code.md), [notices.md](notices.md).

## 1. Overview

The player never types a password in the client. The portal page embeds `Loading.swf` with flash vars (`user`, `key`, `site`, `p2`, `logintype`, `config`, `rid`, `http`). The loader:

1. Reads `config.xml`, picks the `<NODE site=...>` matching `site`, builds an RSA public key from it.
2. Calls `loginselectlist` to learn whether the account already has a character (`Active`) and its `userId`.
3. Calls `login` (or `login2` when `p2` is set) with an RSA-encrypted blob `user|key|tempPassword|userId`. The servlet answers with the socket address, or a queue position, or an error.
4. If the account has no character, shows the character creation screen ([register.md](register.md)); otherwise reads the novice process with `updateplayernovice op=0`.
5. Loads the core client (`2.png`), which connects the socket and sends `20001` with `key = MD5(tempPassword)` and 8 random cipher bytes.
6. The server answers `3 PlayerMsg`. The client loads templates, then sends `8224` (bulk request) and waits for 9 specific pushes, then sends `8224` (late request), then `8224 {user:true}`; the server answers `6 LoginStateMsg` and the scene entry push (`4595`).

`tempPassword` is a random integer generated per page load (`decompiled/Loading/scripts/Loading.as:169`); its MD5 (`userInfo.key`) is the session secret for every later servlet call and for `20001`.

## 2. Screens

| Class | pt-BR title / text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `Loading` tip text (`decompiled/Loading/scripts/Loading.as:103`) | error strings of `LoginResultValue` plus " Retorno à página de login em 3 segundos" | Shows login errors, then returns to the portal after 3 s | `showError` (`Loading.as:525`) | Translated error |
| `queue.LoginQueueView` (`decompiled/Loading/scripts/queue/LoginQueueView.as:10`) | "正在估算中", "  分钟" (Chinese, untranslated in BR) | Login queue overlay | `showError(..., 1, ...)` (`Loading.as:533`) | Queue position, estimated minutes, third value `countTxt` |
| `loading.SmallLoading` / `loading.MaxLoading` (`decompiled/Loading/scripts/loading/MaxLoading.as`) | "Carregando ...", "Iniciando Jogo", "Carregando Campanha Tutorial" | Progress bars while resources load; MaxLoading also holds the Notice and Doctor buttons ([notices.md](notices.md), [../customer-service/README.md](../customer-service/README.md)) | `Loading.__onLoginComplete` (`Loading.as:429`), `Loading.lunchNormal` (`Loading.as:483`) | Progress percent |
| Disconnect alert (`AlertManager.simpleAlert`) | title `public.prompt`, text `yishi.manager.BaseManager.content01` = "Conexão desconectada" | Socket closed | `BaseManager.__socketCloseHandler` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:2721`) | Fixed text; any button exits the game page |
| Duplicate login alert | title `public.prompt`, text = `GatewayMsg.notify_msg` from server | Account logged in elsewhere | `BaseManager.__loginOtherHandler` (`BaseManager.as:2745`) | Server text |
| `RenameView` type 2 | see [register.md](register.md) | Forced rename when the nickname contains `!` | `LoginInitDataAccept.checkNickName` (`decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:204`) | Name input |
| AAS `IndulgeView` / `IndulgeFrame` | `mainBar.view.IndulgeView.describe`, `mainBar.view.IndulgeFrame.command01/02` | Anti-addiction timer and ID registration (China only) | Resources bar when `ConfigManager.info.AAS` is true | Online time |

## 3. Routes (client to server)

### 3.1 HTTP `loginselectlist`

- Trigger: automatic after `config.xml` loads and the RSA key is built (`Loading.__configLoadComplete`, `decompiled/Loading/scripts/Loading.as:219-223`).
- Sender: `Loading.loadSelectList` (`decompiled/Loading/scripts/Loading.as:303`).
- Request: `GET {REQUEST_PATH}loginselectlist?username=<user>&site=<site>&rnd=<random>` (`Loading.as:305-314`).
- Response (XML), read by `Loading.__loadSelectListComplete` (`Loading.as:322-337`):

```xml
<Result value="true"><Item ID="<userId>" Active="true|false" /></Result>
```

  - Only the first `Item` is read. `Active="true"` means the account already created its character (`isActive = true`). `ID` is the player id (`userId`). No `Item` means a new account (`userId = 0`, `isActive` undefined, so character creation runs).
  - IO error throws `SELECTLIST_LOAD_ERROR` ("Load selectList fail! Please try again later!", `Loading.as:317-320`): the client stays on a blank loader.
- Always sets `canJumpNovie = true` (`Loading.as:335`). See [server-select.md](server-select.md) for the multi-server meaning of this list.

### 3.2 HTTP `login` / `login2` (with queue)

- Trigger: automatic after `loginselectlist` (`Loading.as:336`).
- Sender: `Loading.loadLogin` (`decompiled/Loading/scripts/Loading.as:369-398`) through `queue.LoginQueue.load` (`decompiled/Loading/scripts/queue/LoginQueue.as:33-45`).
- Request: `POST {REQUEST_PATH}login` (or `login2` when flash var `p2` is non empty, `Loading.as:386-393`), form fields:

| Field | Value | Source |
|---|---|---|
| `p` | Base64 of RSA PKCS#1 v1.5 encryption (public key from `config.xml`) of the UTF-8 bytes `urlencode(user) + "|" + key + "|" + tempPassword + "|" + userId` | `Loading.as:373-376`, `decompiled/Loading/scripts/utils/CrytoUtils.as:50-55` |
| `site` | flash var `site` | `Loading.as:382` |
| `p2` | flash var `p2` | `Loading.as:383` |
| `loginType` | `1` web, `2` desktop client (forced when `DesktopManager.isDesktop`), `3`, `4` | `Loading.as:127-142`, `:377-380` |
| `client` | `DesktopManager.Instance.isDesktop` (`true`/`false`) | `Loading.as:385` |
| `rnd` | random, refreshed on every retry | `LoginQueue.as:37` |

  `user` is percent-encoded byte by byte with `escape` (`Loading.myUrlEncode`, `Loading.as:400-412`). `key` is the portal flash var `key` (portal login token), not the MD5 session key.

- Response (XML), parsed by `LoginQueue.__onLoginComplete` (`LoginQueue.as:47-126`). Attributes on the root element:

| Case | Attributes | Client reaction |
|---|---|---|
| Queued | `message="<position>|<waitMs or -2>|<third>"` (contains `|`) | Shows `LoginQueueView` with position, minutes (`waitMs/1000/60 + 1`, or "estimating" when `-2`) and `<third>` in `countTxt`; retries `login` after 5 s (position <= 100), 10 s (> 100), 20 s (> 200), 30 s (> 300) (`LoginQueue.as:60-97`) |
| Success | `value` not `"false"`, `userId` non zero, `Address`, `Port`, `CurrentServerName`, `message` without `|` | `Loading.__onLoginComplete` (`Loading.as:414-431`): stores `userId`, `serverName`; overrides `config.xml` `SocktPath` value and `SocketPort` with `Address`/`Port`; loads the socket policy file `xmlsocket://<Address>:843`; continues to `checkLunch` |
| Error | `value="false"` or `userId="0"`, `message="<code>"` | `Loading.showError(message, 0)` (`Loading.as:525-544`): text from `LoginResultValue.getTipMessageByType`, returns to the portal after 3 s |
| No `message` attribute | | `showError("error", 0)` |

  Error codes and their pt-BR text (`decompiled/Loading/scripts/LoginResultValue.as:45-102`):

| `message` | Text shown |
|---|---|
| `Login Failed` | "Servidor está ocupado" |
| `User IS Forbid` | "O usuário actual foi bloqueado" |
| `Data Update Error` | "Servidor está ocupado" |
| `Login Invalidation` | "Falha do Login" |
| `Parameter P Data Error` | "Servidor está ocupado" |
| `Parameter Site Data Error` | "Erro de Parametro de Site" |
| `Login Succeed No Visualize` | "Servidor está ocupado" |
| `Login Enter Is Close` | "Entrada de Log está fechada" |
| `Login Max` | "Os usuários estão online já atingiu o máximo" |
| `Client Exception` | "Detectou anormalidades de Cliente, por favor login após 2 Min." |
| `Client Plug Exception` | "A sua conta está no estado de deteção de anti-plugin, por favor, logia após 30 Min." |
| `Ip Is Forbid ` (trailing space) | "O IP atual foi proibido" |
| `Check Code Failed 2` / `3` / `4` | anti-plugin lockout texts (5, 15, 30 minutes) |
| `Check Code Failed 1`, `Login Succeed`, any other | shown verbatim or "Login" |

- After success, `checkLunch` (`Loading.as:433-447`): when `isActive` is false the character creation flow starts ([register.md](register.md)); otherwise `reqNoviceProcess` calls `updateplayernovice op=0` ([register.md](register.md) section 3.3) and then `NormalLuncher` loads the core.

### 3.3 Socket connect and `20001 U_G_LOGIN_GATEWAY` (C>S, 0x4e21)

- Trigger: `Yishi.lunch` (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:296-313`) calls `onSocketConnect` (`Yishi.as:351-355`), which connects to `SocktPath:SocketPort` (values from the login servlet). On `connect`, `SocketManager.__chatSocketConnected` (`decompiled/core_module/scripts/yishi/service/managers/SocketManager.as:81-86`) sets `PackageOut.clientId = userId` (header field) and calls `SocketSendManager.loginCmd`.
- Sender: `SocketSendManager.loginCmd` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:65-75`):
  1. `resetKey()`: send and receive keys go back to the fixed initial key.
  2. Sends `20001` encrypted with the initial key.
  3. `setKey(ekeys)`: both send and receive keys switch to `ekeys` for every following packet (`decompiled/core_module/scripts/yishi/comm/ByteSocket.as:74-86`).
- Request `LoginReqMsg` (package player):
  - `player_id (#1, INT32)`: not set by the client (header `clientId` carries the id).
  - `key (#2, STRING)`: `userInfo.key` = `MD5(tempPassword)` (lowercase hex, `Loading.as:170`).
  - `ekeys (#3, INT32, repeated)`: 8 values in 1..255, the new cipher key.
- Expected response: `3 U_C_PLAYER_INFO` with the full `PlayerMsg`. Until `SocketManager.acceptData` becomes true the client drops every packet except code `3` (`SocketManager.as:107-118`), so nothing else may be required before the templates finish loading.
- Failure: the client has no listener for `3841 U_G_LOGIN_GATEWAY` (S>C). A rejected login must close the socket, which shows "Conexão desconectada" (assumption: the original server closed the socket).

### 3.4 `8224 C_LONIG_LOAD_REQ` (C>S, 0x2020), three phases

Request `PlayerDataMsg` (package player), every field `BOOL`, a `true` asks the server to push the matching data: `user (#1)`, `castle (#2)`, `army (#3)`, `quest (#4)`, `build (#5)`, `tree (#6)`, `aas (#7)`, `smith (#8)`, `bag (#9)`, `leed (#10)`, `star (#11)`, `friend (#12)`, `effect (#13)`, `sys (#14)`, `offline (#15)`, `reward (#16)`, `tower (#17)`, `shop (#18)`, `chall_reward (#19)`, `sns_req (#20)`, `active (#21)`, `switches (#22)`, `sweep (#23)`, `questionnarie (#24)`, `king_contract (#25)`, `rebate_charge (#26)`, `rebate_consum (#27)`, `sum_active (#28)`, `cross_score_reward (#29)`, `appell (#30)`, `bottle (#31)`, `pet_challenge_reward (#32)`, `powcard_info (#33)`, `christmas (#34)`.

Sender: `SocketSendManager.loginDataReq` (`SocketSendManager.as:83-87`). The client sends three requests in order:

**Phase A, bulk load.** `LoginInitDataAccept.request` (`decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:154-185`), triggered by `StartupResourcesLoader.reqLoginInitData` after templates are parsed (`decompiled/core_module/scripts/yishi/lunch/StartupResourcesLoader.as:271-283`, which also sets `acceptData = true`). Flags: `army, castle, build, friend, sns_req, tree, aas, bag, leed, reward, smith, star, effect, tower, sys, offline, sweep, questionnarie, king_contract, rebate_charge, sum_active, appell, bottle, powcard_info, pet_challenge_reward, christmas`. Immediately after, the client sends `8322 C_LEED_CLIENT` with templateId 1 (`DayGuideSocketOutManager.sendLeedClientUpdate(1)`, `LoginInitDataAccept.as:184`; owned by [../daily-activity/README.md](../daily-activity/README.md)).

The client counts these pushes and continues only after `total = 9` (+ `maxPage - 1` extra friend pages) arrive (`LoginInitDataAccept.as:70`, `:194-202`, `:503-506`):

| Order (any) | Opcode | Message | Client handler | Counts |
|---|---|---|---|---|
| 1 | `4245 U_CH_SNS_REQ` (0x1095) | `SNSInfoMsg` | `__snsReqHandler` (`LoginInitDataAccept.as:239-304`) | yes |
| 2 | `4233 U_C_SEND_VERSION` (0x1089) | `VersionMsg` ([switches.md](switches.md)) | `__versionHandler` (`:316-325`) | yes |
| 3 | `4160 U_C_SEND_SYSPROPERTY` (0x1040) | `SystemPropertyMsg` | `__setSystemTime` (`:327-337`) | yes |
| 4 | `4173 U_C_PLAYER_AASREFRESH` (0x104d) | `PlayerAASRefreshMsg` | `__refreshIndygleTime` (`:348-358`) | yes |
| 5 | `4176 U_C_CHALLENGE_TIME` (0x1050) | `ChallengeCoolTimeMsg` | `__colosseumTimeHandler` (`:360-384`) | yes, only when `type != 1` (a `type = 1` packet returns before counting) |
| 6 | `4156 U_C_LOAD_FRIEND_LIST` (0x103c) | `FriendRelationList` ([../friends/README.md](../friends/README.md)) | `__loadFriendListHandler` (`:386-517`) | yes, once per page; `maxPage > 1` raises `total` |
| 7 | `4157 U_C_LOAD_WATER` (0x103d) | `LoadFarmRsp` ([../farm/README.md](../farm/README.md), [../golden-tree/README.md](../golden-tree/README.md)) | `__loadFarmHandler` (`:519-559`) | yes |
| 8 | `4153 U_C_LOAD_CASTLE` (0x1039) | `BaseCastleMsg` ([../castle/README.md](../castle/README.md)) | `__loadCastleHandler` (`:817-847`) | yes |
| 9 | `4154 U_C_LOAD_BUILD` (0x103a) | `BuildingInfoListMsg` ([../castle/README.md](../castle/README.md)) | `__loadBuildHandler` (`:849-873`) | yes |
| extra | `362 U_C_TIME_ZONE` (0x016a) | `TimeZoneMsg` | `__setTimeZone` (`:339-346`) | no |
| extra | `4244 U_C_ISTAKE_CHALLENGEREWARD` (0x1094) | `ChallengeRankRewardMsg` | `__challengeTakeHandler` (`:231-237`) | no |
| extra | `4481 U_C_ISTAKE_CROSS_SCORE_REWARD` (0x1181) | `ChallengeRankRewardMsg` | `__pvpTakeHandler` (`:306-314`) | no |
| extra | `4613 U_C_PET_RANK_REWARD` (0x1205) | `PetRankRewardMsg` | `__petRankRewardHandler` (`:131-152`) | no |

The other phase A flags are answered by the owning features' pushes (army `150 ArmyMsg`, bag, star, smith, effect, tower, offline `4195`, questionnaire, and so on); they are not counted, but `150 ArmyMsg` must arrive before the scene entry of phase C because `BaseManager.__createSpaceHandler` compares the player id with `ArmyManager.army.userId` (`BaseManager.as:1352`).

When the counter completes, `checkNickName` (`LoginInitDataAccept.as:204-219`) opens the forced rename when `nickName` contains `!`, otherwise calls back `StartupResourcesLoader.onLoginInitDataAcceptComplete` (`StartupResourcesLoader.as:285-296`), which:

- When `noviceProcess == 10000`, sets it to `11000` and sends `5017 U_C_PLAYER_NOVICE` (owned by [../tutorial/README.md](../tutorial/README.md)).
- Sends phase B, dispatches `coreSetupLoadComplete`, and posts `flashversionservlet` (3.6).

**Phase B, late load.** `LoginInitDataAccept.loginOverRequest` (`LoginInitDataAccept.as:86-96`): flags `quest, shop, active, chall_reward, switches, cross_score_reward`. Expected pushes: quests ([../quests/README.md](../quests/README.md)), shop data ([../shops/README.md](../shops/README.md)), activities ([../daily-activity/README.md](../daily-activity/README.md)), `4244`, `4422 U_C_SWITCH` ([switches.md](switches.md)), `4481`. None are awaited.

**Phase C, login state.** `Yishi.requestLoginState` (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:567-573`), from `__onCoreSetupLoadComplete` (`Yishi.as:560-565`): flags `user` only. Expected response: `6 U_C_PLAYER_LOGINSTATEE`, then the scene entry for the state (normally `4595 U_C_PLAYER_SPACE_CREATE` with `RoomEnterMsg`, see [../navigation/README.md](../navigation/README.md)). The client listens for the first `SWITCH_SCENE` notification and then runs the post login popups (`Yishi.loginInitDataAcceptComplete`, `Yishi.as:581-625`).

### 3.5 `5035 U_PLAYER_CLIENT_STATE` (C>S, 0x13ab)

- Sender: `SocketSendManager.sendCurrentClientState` (`SocketSendManager.as:102-108`), called by `SceneManager` on scene changes (`decompiled/core_module/scripts/yishi/scene/SceneManager.as:334`).
- Request `LoginStateMsg`: `player_id (#1, INT32)` unset, `state (#2, INT32)` client scene state (default 1).
- No response. The server stores the value for presence (assumption: used to route pushes and to know whether the player is in battle).

### 3.6 HTTP `flashversionservlet`

- Sender: `StartupResourcesLoader.sendFlashPlayerVersion` (`StartupResourcesLoader.as:341-362`), once per login.
- Request: `POST {REQUEST_PATH}flashversionservlet`, field `v = "<flash version digits>|<screenX>*<screenY>"`.
- Response ignored. Store for analytics.

### 3.7 `5020 U_C_PLAYER_LOGINSTATE` (C>S, 0x139c)

`SocketSendManager.loginState` (`SocketSendManager.as:77-81`) builds an empty `5020` packet but has no caller in the decompiled code. Implement as a no-op that answers `6` like phase C (assumption).

### 3.8 Anti-addiction (AAS), disabled in BR

| Action | Sender | Opcode | Request |
|---|---|---|---|
| Register real name and ID card | `IndulgeFrame.__clickHandler` (`decompiled/core_module/scripts/mainBar/view/IndulgeFrame.as:137-162`) | `8260 C_PLAYER_AASCHANGE` (0x2044) | `PlayerAASReqMsg`: `card_name (#1, STRING)`, `card_id (#2, STRING)` |
| Report online time every 5 minutes | `IndulgeView.__timerHandler` (`decompiled/core_module/scripts/ui/resourcebar/view/IndulgeView.as:148-206`) | `8261 C_PLAYER_AASREFRESH` (0x2045) | `PlayerAASRefreshMsg`: `aasOnlineTime (#1, INT32)` seconds, `isCloseAAS (#2, BOOL)`, `sysSwitch (#3, BOOL)` |
| Partner site verified the user (site `kxin` only) | `BaseManager.__onGetResultCompleted` (`BaseManager.as:1677-1697`) | `8620 C_PLAYER_AAS_SWITCH_CHANGE` (0x21ac) | `PlayerAASRefreshMsg` with `isCloseAAS = true` |

The client only runs these when `ConfigManager.info.AAS` is true (switch type 13 or `PlayerAASRefreshMsg.sysSwitch`). The BR server must send `4173` with `isCloseAAS = true`, `sysSwitch = false` and never ask for an ID card. Do not implement storage of identity documents.

## 4. Server messages (server to client)

### `3 U_C_PLAYER_INFO` (0x0003), `PlayerMsg` (package player)

- Receiver: `PlayerManager.__uPlayerInfoHandler` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:496-1240`), registered at `PlayerManager.as:150`.
- When: response to `20001`, then as a push whenever any field changes (partial messages are allowed: every field is read with `hasX`).
- The full message has 166 fields owned by [../hero/README.md](../hero/README.md). Fields the login depends on:

| Field | Meaning | Client use |
|---|---|---|
| `player_id (#1, INT32)` | Player id | `playerInfo.userId` (`PlayerManager.as:601`). Must be non zero: `Yishi.__tryLoadStartupResource` only starts loading when `userId != 0` (`Yishi.as:357-366`) |
| `nick_name (#2, STRING)` | Name | `PlayerManager.as:609`; a `!` triggers the forced rename |
| `server_name (#74, STRING)` | Server display name | `playerInfo.serviceName` (`PlayerManager.as:597`) |
| `novice_process (#23, INT32)` | Tutorial step | `playerInfo.noviceProcess` (`PlayerManager.as:891`) |
| `jump_novice (#110, BOOL)` | Tutorial skipped | `PlayerManager.as:1137`; forces novice process 99900 (`StartupResourcesLoader.as:388-395`) |
| `refuseFriend (#50, BOOL)`, `refuseInvite (#51, BOOL)`, `refuseTeamInvite (#86, BOOL)` | Privacy toggles | [settings.md](settings.md) |
| `hasVicePassword (#95, INT32)` | Item lock password set | [item-lock.md](item-lock.md) |
| `grades (#16, INT32)` | Level | many gates (mail check at 25, Facebook at 20) |

- The first `3` of the session (local `userId == 0`) only dispatches `LOGIN_SUCCESS` and returns before `commit()` (`PlayerManager.as:1225-1229`).

### `6 U_C_PLAYER_LOGINSTATEE` (0x0006), `LoginStateMsg` (package player)

Fields: `player_id (#1, INT32)`, `state (#2, INT32)`.

- Receiver: `BaseManager.__loginStateHandler` (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:1904-1975`), one shot (removes its listener).
- When: response to phase C `8224 {user:true}`.
- `state` values (`BaseManager.as:1920-1960`):

| state | Meaning | Client reaction |
|---|---|---|
| 0 to 3 | Normal (castle / sky city) | If novice process < 19000: sends `5127 U_C_CAMPAIGN_TRAINING` with `NoviceReqMsgMsg.type = 1` (tutorial campaign, [../tutorial/README.md](../tutorial/README.md)). Else if level > 16 and novice < 36000: saves 36000 and opens the castle. Else if level <= 16: opens the castle. Otherwise waits for the scene push (`4595`) |
| 4 | In a campaign instance | log only; server must resend the campaign scene ([../campaign/README.md](../campaign/README.md)) |
| 5 | In a battle | `BattleManager.loginToBattleFlag = true`; server resends the battle ([../battle/README.md](../battle/README.md)) |
| 6 | In Sandbox ("黎明杀机") | `SandboxManager.loginToSandboxFlag = true` |
| 7 | In the game hall | `GameHallManager.loginToGameHallFlag = true` |
| 8 | In Secret War | `SecretWarManager.loginToSecretWarFlag = true` |

  Afterwards `NewbieManager.start()` runs and `LOGIN_STATE` is broadcast (`BaseManager.as:1961-1962`). `loginState < 0` (before `6`) suppresses system broadcasts (`BaseManager.as:2179`).

### `3842 U_G_LOGIN_OTHER` (0x0f02), `GatewayMsg` (package gateway)

Fields: `notify_msg (#1, STRING)`, the text shown.

- Receiver: `BaseManager.__loginOtherHandler` (`BaseManager.as:2745-2763`), registered at `BaseManager.as:293`.
- When: push to the old session when the same account logs in again, just before the server closes that socket.
- Reaction: modal alert with `notify_msg`, keyboard disabled; any button calls `ExternalInterfaceManager.existGame` (leaves the page). The later socket close shows no second alert (`_loginFrame` guard, `BaseManager.as:2726`).

### `4160 U_C_SEND_SYSPROPERTY` (0x1040), `SystemPropertyMsg` (package player)

Fields: `sys_curtime (#1, STRING)` "YYYY-MM-DD hh:mm:ss" server local time, `sys_starTime (#2, STRING)` server open date, `sys_millisecond (#3, INT64)` epoch milliseconds.

- Receiver: `LoginInitDataAccept.__setSystemTime` (`LoginInitDataAccept.as:327-337`). Counted in phase A.

### `4234 U_C_SYNCHRONIZED_TIME` (0x108a), `SynchronizedTimeMsg` (package player)

Fields: `sys_curtime (#1, STRING)`, `sys_millisecond (#2, INT64)`.

- Receiver: `PlayerManager.__sysTimeHandler` (`PlayerManager.as:352-359`). Push at any time to resynchronize the client clock (assumption: every few minutes and after day change).

### `362 U_C_TIME_ZONE` (0x016a), `TimeZoneMsg` (package player)

Fields: `grand_world_id (#1, STRING)`, `grand_world_offset (#2, SINT32)`, `castle_id (#3, STRING)`, `castle_offset (#4, SINT32)`.

- Receiver: `LoginInitDataAccept.__setTimeZone` (`LoginInitDataAccept.as:339-346`): stores `castle_offset` and `grand_world_offset` (time zone offsets of the home server and of the cross server world). Not counted.

### `4245 U_CH_SNS_REQ` (0x1095), `SNSInfoMsg` (package simple)

Fields: `id (#1, INT32)`, `user_id (#2, INT32)`, `nickname (#3, STRING)`, `sign_desc (#4, STRING)`, `sex (#5, INT32)`, `birthday_type (#6, INT32)`, `birth_year (#7, INT32)`, `birth_month (#8, INT32)`, `birth_day (#9, INT32)`, `star_id (#10, INT32)`, `blood_type (#11, INT32)`, `country (#12, INT32)`, `province (#13, INT32)`, `city (#14, INT32)`, `head_id (#15, INT32)`, `job (#16, INT32)`.

- Receiver: `LoginInitDataAccept.__snsReqHandler` (`LoginInitDataAccept.as:239-304`). Counted. Profile content is owned by [../friends/README.md](../friends/README.md); account only guarantees the push (an empty message is valid).

### `4173 U_C_PLAYER_AASREFRESH` (0x104d), `PlayerAASRefreshMsg` (package player)

Fields: `aasOnlineTime (#1, INT32)`, `isCloseAAS (#2, BOOL)`, `sysSwitch (#3, BOOL)`.

- Receiver: `LoginInitDataAccept.__refreshIndygleTime` (`LoginInitDataAccept.as:348-358`): `isInAAS = !isCloseAAS`, `indulgeTime = aasOnlineTime`, `ConfigManager.info.AAS = sysSwitch`. Counted. BR value: `{aasOnlineTime: 0, isCloseAAS: true, sysSwitch: false}`.

### `4172 U_C_PLAYER_AASCHANGE` (0x104c), `PlayerAASRspMsg` (package player)

Fields: `result (#1, BOOL)`, `age (#2, INT32)`, `card_id (#3, STRING)`. Receiver `BaseManager.__changeHandler` (`BaseManager.as:1699-1713`): `age >= 18` closes the AAS view. Not needed in BR.

### `4176 U_C_CHALLENGE_TIME` (0x1050), `ChallengeCoolTimeMsg` (package player)

Fields: `left_time (#1, INT32)`, `challenge_count (#2, INT32)`, `total_count (#3, INT32)`, `type (#4, INT32)`, `total_buyCount (#5, INT32)`.

- Receiver: `LoginInitDataAccept.__colosseumTimeHandler` (`LoginInitDataAccept.as:360-384`). The arena content is owned by [../arena/README.md](../arena/README.md); account must send exactly one `4176` with `type != 1` during phase A or the login never completes.

### `4244`, `4481` `ChallengeRankRewardMsg` (package player) and `4613` `PetRankRewardMsg` (package pet)

`ChallengeRankRewardMsg`: `is_take (#1, BOOL)`, `param1 (#2, INT32)`, `param2 (#3, INT32)`, `param3 (#4, INT32)`, `param4 (#5, INT32)`. `4244` sets `playerInfo.isChallReward`, `4481` sets `canAcceptCrossScoreAward`. `PetRankRewardMsg`: `type (#1)`, `status (#2)`, `rank (#3)`, `opType (#4)`, `reward_type (#5)`, `score (#6)`, all `INT32`; `status == 0 && type == 2` marks the weekly pet challenge reward. Owned by [../arena/README.md](../arena/README.md) and [../einherjar/README.md](../einherjar/README.md).

### `4598 U_C_PLAYER_LOGIN_SYNC_MAPID` (0x11f6), simple `PropertyMsg`

Field used: `param1 (#1, INT32)` = current map id (sky city or Einherjar island). Receiver `PlayerManager.__loginSyncMapIdHandler` (`PlayerManager.as:1242-1248`) sets `spaceMapId`. Send before `4595` when the player logs back in on a non default map (see [../navigation/README.md](../navigation/README.md)).

The simple `PropertyMsg` (`decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as:300-365`, not the army one in `proto.json`): `param1 (#1, INT32)`, `param2 (#2, INT32)`, `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, STRING)`, `param7 (#7, BOOL)`, `param8 (#8, BOOL)`, `param9 (#9, BOOL)`, `param10 (#10, INT32)`, `param11 (#11, INT32)`, `param12 (#12, STRING)`.

### Socket close

`SocketManager.__socketClose` (`SocketManager.as:71-79`) re-dispatches `close`; `BaseManager.__socketCloseHandler` (`BaseManager.as:2721-2743`) shows "Conexão desconectada" and exits on any button. There is no automatic reconnect in the client: every reconnect is a full page reload through the portal.

## 5. Rules and formulas

- Session secret: `tempPassword = int(random * 10000000)` per page load, `key = MD5(tempPassword)` lowercase hex (`Loading.as:169-170`). The login servlet learns `tempPassword` from the RSA blob, stores `MD5(tempPassword)`, and validates it on `20001` and on every servlet that sends `key` (`updateplayernovice`, `visualizeregister`).
- RSA: modulus and exponent are Base64 big-endian integers in `config.xml` (`<RSAKey PublicKeyModulus=... publicExponent="AQAB"/>`, `raw/config.xml:32-35`). The server holds the matching private key per site (`CrytoUtils.generateRsaKey`, `decompiled/Loading/scripts/utils/CrytoUtils.as:29-39`). Padding is the `com.hurlant` `RSAKey.encrypt` default (PKCS#1 v1.5 type 2).
- Queue retry interval by position: 5 s (<= 100), 10 s (101..200), 20 s (201..300), 30 s (> 300) (`LoginQueue.as:64-80`).
- Socket cipher: initial key for `20001`, then `ekeys` in both directions (`SocketSendManager.as:67-74`, `ByteSocket.as:74-91`). The server must switch its receive key after decoding `20001` and its send key before writing `3`.
- Login completion requires exactly the 9 counted pushes (plus friend pages) of phase A.
- Novice thresholds read at login (owned by tutorial): `< 19000` loads the tutorial campaign assets, `< 99900` loads the novice module, `< 11300` loads `newguidestart`, `< 15000` preloads map 10002 (`StartupResourcesLoader.as:145-162`, `:209-215`); `10000` is bumped to `11000` after phase A (`:287-291`).
- Post login popups (`Yishi.as:581-625`), only in non battle scenes (`Yishi.as:673-707`) and level >= 25: mail check if enabled ([../customer-service/README.md](../customer-service/README.md)), else marriage heart question, else the update announcement when `VersionMsg.open_version` ([notices.md](notices.md)), else the daily sign-in or activity guide.
- Duplicate login: one live session per player; the newer login wins (assumption consistent with `3842`).

## 6. Templates

None. Static configuration comes from `raw/config.xml` (`REQUEST_PATH`, `SocktPath`, `SITES/NODE`, `RSAKey`) and is documented in [server-select.md](server-select.md).

## 7. Persistent state

Schema `account`.

```sql
CREATE TABLE account.accounts (
  account_id      BIGSERIAL PRIMARY KEY,
  site            TEXT        NOT NULL,
  username        TEXT        NOT NULL,
  portal_secret   TEXT        NOT NULL,
  status          SMALLINT    NOT NULL DEFAULT 0 CHECK (status IN (0, 1, 2)),
  banned_until    TIMESTAMPTZ,
  ban_reason      TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_login_at   TIMESTAMPTZ,
  last_login_ip   INET,
  UNIQUE (site, username)
);

CREATE TABLE account.sessions (
  session_id      BIGSERIAL PRIMARY KEY,
  account_id      BIGINT      NOT NULL REFERENCES account.accounts(account_id),
  player_id       BIGINT      REFERENCES player.players(player_id),
  server_id       INT         NOT NULL REFERENCES account.servers(server_id),
  session_key_md5 CHAR(32)    NOT NULL,
  login_type      SMALLINT    NOT NULL DEFAULT 1,
  is_desktop      BOOLEAN     NOT NULL DEFAULT false,
  client_ip       INET,
  flash_version   TEXT,
  screen_size     TEXT,
  issued_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  connected_at    TIMESTAMPTZ,
  last_seen_at    TIMESTAMPTZ,
  closed_at       TIMESTAMPTZ,
  close_reason    TEXT CHECK (close_reason IN ('logout', 'kicked_duplicate', 'kicked_admin', 'timeout', 'error'))
);
CREATE INDEX sessions_player_open_idx ON account.sessions (player_id) WHERE closed_at IS NULL;
CREATE UNIQUE INDEX sessions_key_open_idx ON account.sessions (session_key_md5) WHERE closed_at IS NULL;

CREATE TABLE account.ip_bans (
  ip              INET        PRIMARY KEY,
  reason          TEXT,
  banned_until    TIMESTAMPTZ
);

CREATE TABLE account.login_events (
  event_id        BIGSERIAL PRIMARY KEY,
  account_id      BIGINT      REFERENCES account.accounts(account_id),
  player_id       BIGINT      REFERENCES player.players(player_id),
  occurred_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
  client_ip       INET,
  result_code     TEXT        NOT NULL
);
CREATE INDEX login_events_account_idx ON account.login_events (account_id, occurred_at DESC);

CREATE TABLE account.player_presence (
  player_id       BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  login_state     SMALLINT    NOT NULL DEFAULT 0 CHECK (login_state BETWEEN 0 AND 8),
  client_state    INT         NOT NULL DEFAULT 1,
  space_map_id    INT         NOT NULL DEFAULT 10000,
  online          BOOLEAN     NOT NULL DEFAULT false,
  last_logout_at  TIMESTAMPTZ,
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

`account.servers` and `account.account_players` are defined in [server-select.md](server-select.md). The login queue is in memory (position list per server); it does not need a table.

## 8. Backend implementation notes

HTTP servlets (axum routes, plain `application/xml` responses):

- `account::login_session::handle_login_select_list` (`GET /loginselectlist`): look up `account.accounts` by `(site, username)`, then `account.account_players` for the current server. Return `<Result value="true"><Item ID=".." Active="true"/></Result>` or `<Result value="true"/>` when no character exists.
- `account::login_session::handle_login` (`POST /login`, `/login2`):
  1. Decode Base64 `p`, RSA decrypt with the site private key; split by `|` into `user`, `portal_key`, `temp_password`, `user_id`. Failure: `message="Parameter P Data Error"`. Unknown `site`: `Parameter Site Data Error`.
  2. Validate `portal_key` against the portal (or `account.accounts.portal_secret`); failure `Login Invalidation`. Create the account row on first login (assumption: portal already authenticated the user).
  3. Check `ip_bans` (`Ip Is Forbid `), `accounts.status/banned_until` (`User IS Forbid`), server status closed (`Login Enter Is Close`).
  4. If online count >= `servers.max_online`, enqueue and return `message="<pos>|<eta_ms or -2>|<queue_len>"` (assumption: third value is the queue length shown in `countTxt`).
  5. Insert `account.sessions` with `session_key_md5 = md5(temp_password)`; insert `login_events`. Return `value="true" userId=<player_id or account placeholder> Address Port CurrentServerName`. For accounts without a character, `userId` must still be non zero (the client rejects `userId == 0`); use the reserved `player_id` from [register.md](register.md).
- `account::login_session::handle_flash_version` (`POST /flashversionservlet`): store `v` on the open session, return `<Result value="true"/>`.

Socket handlers:

- `account::login_session::handle_gateway_login` (20001): header `clientId` = player id; find the open session with `session_key_md5 = key` and that player; on mismatch close the socket. Switch both cipher keys to `ekeys`. If another live socket exists for the player, push `3842` with "Sua conta foi conectada em outro local." (assumption, exact BR text unknown) to it and close it, marking `close_reason = 'kicked_duplicate'`. Mark `player_presence.online = true`. Reply `3` with the full `PlayerMsg` (built by the hero feature).
- `account::login_session::handle_login_load` (8224): dispatch per flag to the owning feature's `push_login_*` function, in this fixed order for phase A: `4245`, `4233`, `4160`, `362`, `4173`, `4176` (type 0), `4156` (paged), `4157`, `150`, then the remaining features, then `4153`, `4154`. Phase B: quests, shops, activities, `4244`, `4422`, `4481`. Phase C (`user` only): `4598` if needed, `6`, then the scene entry (`4595` or the campaign / battle resume).
- `account::login_session::handle_client_state` (5035): update `player_presence.client_state`.
- `account::login_session::handle_login_state` (5020): same as phase C.
- `account::login_session::handle_aas_register` (8260), `handle_aas_refresh` (8261), `handle_aas_switch` (8620): reply with AAS closed; do not persist identity data.
- Disconnect: on socket close set `sessions.closed_at`, `player_presence.online = false`, `last_logout_at`; notify friends and guild (`161`, `163` pushes owned by [../friends/README.md](../friends/README.md) and [../guild/README.md](../guild/README.md)).
- Timers: `4234` every 5 minutes and at 00:00 server time (assumption). Session keys expire if `20001` does not arrive within 10 minutes of `login` (assumption).
- Transactions: `login` writes session and event in one transaction; `20001` updates session and presence in one transaction before any push.

## 9. Open questions and assumptions

- Assumption: the original server closed the socket on a bad `20001` (no client listener for `3841`).
- Assumption: the third queue value is the total queue length.
- Assumption: exact BR text of `3842 notify_msg` is not in the client; it is server provided.
- Open: `login2` differs only by the `p2` portal parameter (partner login); treat both with the same handler and log `p2`.
- Open: `loginType` 3 and 4 meanings (4 sets `DesktopManager.desktopType = 4`); store only.
- Open: whether the original server sent `362`, `4244`, `4481`, `4613` during phase A or B; they are safe in phase A.
- Assumption: the `portal_secret` check is done by our own portal; the original validated `key` with the Oasis portal.

## 10. Implementation checklist

- [ ] HTTP `loginselectlist` with `Item ID/Active`
- [ ] HTTP `login` and `login2`: RSA decrypt, validation order, error codes table, queue messages
- [ ] Login queue (in memory) with position and ETA
- [ ] HTTP `flashversionservlet`
- [ ] Socket `20001`: session key check, cipher key switch, duplicate login kick with `3842`
- [ ] `3 PlayerMsg` full snapshot on login (with hero feature)
- [ ] `8224` phase A: the 9 counted pushes in order, friend paging, `150` before scene entry
- [ ] `8224` phase B: quests, shops, activities, `4244`, `4422`, `4481`
- [ ] `8224` phase C: `4598` (when needed), `6`, scene entry
- [ ] `6` login state values 0..8 and resume of campaign, battle, sandbox, game hall, secret war
- [ ] `4160`, `4234`, `362` time messages; periodic `4234`
- [ ] `4173` with AAS closed; `8260`, `8261`, `8620` no-op handlers
- [ ] `5035` client state, `5020` no-op
- [ ] Disconnect handling and presence update
- [ ] Tables `account.accounts`, `account.sessions`, `account.ip_bans`, `account.login_events`, `account.player_presence`
- [ ] Test: full login of an existing character reaches the sky city scene
- [ ] Test: login with `nick_name` containing `!` opens the forced rename
- [ ] Test: second login kicks the first with `3842`
- [ ] Test: `4176` with `type = 1` only (login must hang, documents the rule)
- [ ] Test: queue response retries at the right interval
