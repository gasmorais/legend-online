# Server selection and site configuration

Area: account, module `server-select`. Covers how the client knows which game server (world) it plays on: the portal flash vars, the `config.xml` site node (`<SITES><NODE site=...>`), the per site RSA key, the server row returned by `loginselectlist`, the socket address and server name returned by `login`, and how the server name is shown and used across servers.

Conventions: see [login-session.md](login-session.md). Paths are relative to the repository root.

## 1. Overview

There is no server list screen inside the client. The Oasis portal page lets the player pick a world (in BR the single world `broas_1264`, server id `21264` in the PAY url of `raw/config.xml:26`) and embeds the loader with `site=<site>` and `config=<url of config.xml>`. Everything that depends on the chosen world comes from:

1. `config.xml`: global URLs plus one `<NODE site=...>` per site, with the RSA public key (`raw/config.xml:17-36`).
2. `loginselectlist`: the player row of that account on that world (`decompiled/Loading/scripts/Loading.as:303-337`).
3. `login`: the socket `Address`, `Port` and `CurrentServerName` (`Loading.as:414-425`), which override `config.xml`.

The new backend must therefore model "servers" (worlds), keep one character per account per server, and serve a `config.xml` whose `NODE` matches the site the portal passes.

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Portal page (outside the SWF) | n/a | World choice, embeds `Loading.swf` with flash vars | Browser | Worlds list (served by our web portal) |
| `Loading` tip text | "Site não encontrado:<site> Retorno à página de login em 3 segundos" | Unknown site in `config.xml` | `Loading.setRSAKey` (`decompiled/Loading/scripts/Loading.as:270-287`) | Site |
| Client title (`ExternalInterfaceManager.setExternalInfo`) | `CLIENT_LOGIN_NAME` ("Oasis Games"), `VERSION` ("1.3.0") | Browser title and version label | `Loading.__configLoadComplete` (`Loading.as:200-203`) | Node values |

## 3. Routes (client to server)

### 3.1 HTTP `config.xml`

- Sender: `Loading.loadConfig` (`decompiled/Loading/scripts/Loading.as:174-183`), `GET <config flash var or "config.xml">?rnd=<random>`.
- Response: XML document; the loader reads `..config[0]` (`Loading.as:197-214`); the core reparses it in `ConfigParaser.paras` (`decompiled/core_module/scripts/yishi/lunch/ConfigParaser.as:26-80`).
- Elements read (all as `@value` unless noted):

| Element | Used for | Citation |
|---|---|---|
| `REQUEST_PATH` | Base of every servlet (`{REQ}`) | `Loading.as:204-206`, `ConfigParaser.as:65` |
| `TEMPLATE_PATH` | Templates and `version.xml` (`{TPL}`) | `Loading.as:207-208`, `ConfigParaser.as:70` |
| `ResourcePath`, `Backup_ResourcePath` | CDN | `Loading.as:209-210` |
| `LANGUAGE` | `zh_cn` folder name of language files | `Loading.as:211` |
| `SocktPath @value @SocketPort` | Socket host and port (overridden by `login`) | `ConfigParaser.as:73-74` |
| `CastleServicePath` | AMF endpoint | `ConfigParaser.as:71` |
| `UPLOAD_PATH` | Customer service screenshot upload | `ConfigParaser.as:78` |
| `FOWARDSITE @value @siteName` | Favorite / home link | `ConfigParaser.as:68-69` |
| `VERSION`, `FACE_NUM`, `UI_REQUEST_SIZE @registerSize @normalSize`, `FACEBOOK_SHARE_PATH`, `FACEBOOK_SHARE_APPID`, `BattleSocketPath`, `StoryMovie`, `corssdomainfile` | Misc | `ConfigParaser.as:32-77` |
| `SITES/NODE[@site=<site>]` children: `SITE`, `PAY`, `SNSPATH`, `CLIENT_LOGIN_PATH`, `CLIENT_LOGIN_NAME`, `AAS @request @register`, `ONLINE`, `NICK_NAME_PATH`, `DOCTOR`, `READVIP`, `PORTPATH`, `SWITCHS` | Per site links | `ConfigParaser.as:40-61`, `Loading.as:200-205` |
| `SITES/NODE/RSAKey @PublicKeyModulus @publicExponent` | Login encryption | `Loading.as:270-283` |

When the `http` flash var is `https:`, every `root`, `source` and `value` attribute except `UPLOAD_PATH` is rewritten from `http` to `https` and `:8080` is removed (`Loading.configConvertToHTTPS`, `Loading.as:229-268`).

### 3.2 HTTP `loginselectlist`

Documented in [login-session.md](login-session.md) section 3.1. Server selection meaning: the response is scoped to the server identified by `site`; `ID` is the player id on that server and `Active` says whether the character exists there.

### 3.3 HTTP `login`

Documented in [login-session.md](login-session.md) section 3.2. Server selection meaning: `Address` and `Port` choose the game node; `CurrentServerName` becomes `userInfo.serverName` (`Loading.as:423`). The policy file is fetched from port 843 of `Address` (`Loading.as:427-428`; in the web port the WebSocket gateway replaces it).

## 4. Server messages (server to client)

No socket message is specific to this module. Server names reach the client in:

- `PlayerMsg.server_name (#74, STRING)` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:597`), shown in profile views ([../hero/README.md](../hero/README.md)).
- `ChatChannelMsg.server_name (#20, STRING)`, `RoomPlayerMsg` and cross server rankings, used to prefix names in cross server content ([../cross-server/README.md](../cross-server/README.md), [../chat/README.md](../chat/README.md)).

## 5. Rules and formulas

- One character per account per server: `loginselectlist` reads only the first `Item` (`Loading.as:326-334`).
- The site string selects the RSA key; an unknown site aborts the login after 3 seconds (`Loading.as:284-286`). For BR sites (`brazil`, `broas`, `337pt`, `pt` in the name) the abort calls the page function `callInterruption(user, site)` instead of navigating (`Loading.as:291-298`).
- `SocketPort` in `config.xml` is `5000` (`raw/config.xml:10`) but the observed live port was `5004` (`protocol/socket.md`); the `login` response is authoritative.
- Server name must be unique across servers that share cross server content (assumption).

## 6. Templates

None. `raw/config.xml` is a deployment file generated per environment from `account.servers` and `account.sites` (proposal below).

## 7. Persistent state

```sql
CREATE TABLE account.sites (
  site                TEXT        PRIMARY KEY,
  client_login_name   TEXT        NOT NULL DEFAULT 'Oasis Games',
  site_url            TEXT        NOT NULL,
  pay_url             TEXT,
  sns_url             TEXT,
  doctor_url          TEXT,
  read_vip_url        TEXT,
  rsa_modulus_b64     TEXT        NOT NULL,
  rsa_exponent_b64    TEXT        NOT NULL DEFAULT 'AQAB',
  rsa_private_pem     TEXT        NOT NULL
);

CREATE TABLE account.servers (
  server_id           INT         PRIMARY KEY,
  site                TEXT        NOT NULL REFERENCES account.sites(site),
  display_name        TEXT        NOT NULL UNIQUE,
  socket_host         TEXT        NOT NULL,
  socket_port         INT         NOT NULL CHECK (socket_port BETWEEN 1 AND 65535),
  status              SMALLINT    NOT NULL DEFAULT 1 CHECK (status IN (0, 1, 2)),
  max_online          INT         NOT NULL DEFAULT 5000 CHECK (max_online > 0),
  opened_at           TIMESTAMPTZ NOT NULL,
  merged_into         INT         REFERENCES account.servers(server_id),
  UNIQUE (site)
);

CREATE TABLE account.account_players (
  account_id          BIGINT      NOT NULL REFERENCES account.accounts(account_id),
  server_id           INT         NOT NULL REFERENCES account.servers(server_id),
  player_id           BIGINT      NOT NULL UNIQUE REFERENCES player.players(player_id),
  is_active           BOOLEAN     NOT NULL DEFAULT false,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (account_id, server_id)
);
```

`status`: 0 closed (`Login Enter Is Close`), 1 open, 2 maintenance. `opened_at` feeds `SystemPropertyMsg.sys_starTime` ([login-session.md](login-session.md)). `is_active` becomes true when `visualizeregister` succeeds ([register.md](register.md)).

## 8. Backend implementation notes

- `account::server_select::handle_config_xml` (`GET /config.xml`): render the global elements plus the `NODE` of the requested site from `account.sites` and `account.servers`; never expose `rsa_private_pem`.
- `account::server_select::handle_server_list` (portal only, not used by the SWF): list servers of a site with status and whether the account has a character (`account_players.is_active`).
- `loginselectlist` and `login` live in `account::login_session` and read `account.servers` by `site` to pick the node, port and name.
- Server status changes take effect on the next `login`; online players are not kicked (assumption).
- Server merges: when `merged_into` is set, `login` on the old site resolves to the target server and keeps `account_players` rows (assumption: name collisions are resolved by appending `!` to force a rename, which is exactly what the client handles in [register.md](register.md)).

## 9. Open questions and assumptions

- Assumption: one site per server (the BR deployment had a single site node `broas_1264`).
- Assumption: merged server names are fixed with the `!` forced rename rule.
- Open: the meaning of the `ONLINE` node value and of `PORTPATH` (`snsevents`) is not read by gameplay code found so far.
- Open: `Backup_ResourcePath` failover rules belong to the CDN layer, not the backend.

## 10. Implementation checklist

- [ ] `account.sites`, `account.servers`, `account.account_players` tables
- [ ] `config.xml` renderer per site, including `RSAKey`
- [ ] RSA key pair per site, private key used by `login`
- [ ] Portal server list endpoint
- [ ] `loginselectlist` scoped by site/server
- [ ] `login` returns `Address`, `Port`, `CurrentServerName` from `account.servers`
- [ ] Server status gate (`Login Enter Is Close`) and `max_online` queue trigger
- [ ] Test: unknown site shows "Site não encontrado"
- [ ] Test: `https:` flash var rewrites URLs
- [ ] Test: two servers on the same account keep separate characters
