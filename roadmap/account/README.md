# Account (Conta, login e cadastro)

Feature slug `account`, domain `account`. Everything between the portal and the first scene, plus the account level systems that wrap the whole session: login and session lifecycle, server/site selection, character creation and renaming, anti-bot security code, item lock second password, settings, server function switches and the update announcement.

Client packages (from `roadmap/features.json`): `loading`, `register`, `queue` (`decompiled/Loading/scripts/`), `securityCode` (m11), `securitycode` (`mvc/module`), `setting` (m11 and `mvc/module`), `notice` (m18), `logging` (`core_module`), `gateway` (proto). Shared code followed: `yishi/lunch/*` (`Yishi`, `StartupResourcesLoader`, `LoginInitDataAccept`, `ConfigParaser`), `yishi/service/managers/SocketManager`, `SocketSendManager`, `yishi/manager/BaseManager`, `PlayerManager`, `SharedManager`, `mainBar/vicePassword/*`, `managers/SocketSecurityCodeMessageManager`.

Proto packages: `gateway` (`GatewayMsg`), `switches` (`SwitchInfoListMsg`, `SwitchInfoMsg`), `timer` (`TimerInfoListMsg`, `TimerInfoMsg`, unused by the client), `simple` and `module` (grab bags: only `SNSInfoMsg`, `CheckImageMsg` and the simple `PropertyMsg` are used by account; the rest belong to friends, auction, mall, world boss, dream arena, remains explore, land mine and other features and are documented there). Account also uses these `player` package messages: `LoginReqMsg`, `PlayerDataMsg`, `LoginStateMsg`, `SystemPropertyMsg`, `SynchronizedTimeMsg`, `TimeZoneMsg`, `VersionMsg`, `PlayerAASRefreshMsg`, `PlayerAASReqMsg`, `PlayerAASRspMsg`, `PlayerRenameReqMsg`, `PlayerRenameRspMsg`, `RefuseFriendRspMsg`, `VicePasswordMsg`, `LockAndUnlockMsg`.

## Player view

- The portal opens the game; the loader shows a progress bar (with "notice" and "doctor" buttons), sometimes a login queue ("posição na fila").
- New players pick one of six portraits (Guerreiro, Arqueiro, Feiticeiro, male or female) and a name, with a dice for random names.
- In game: "Configuração" (Esc) for sound, effects, hide players and privacy toggles (refuse friends, room invites, team invites); "Bloqueio de Itens" to protect items with a 6 digit password; occasionally a "Número de autenticação" puzzle; "Anúncio de Atualização" after updates; forced rename after server merges; "Conexão desconectada" or a duplicate login message when the session ends.

## Entry points

| Entry | Where | Condition |
|---|---|---|
| Portal embed `Loading.swf?user&key&site&p2&logintype&config&rid&http` | Web page | Always |
| Character creation | Loader, after `login` | Account has no character on the server |
| Loading screen "notice" button | `MaxLoading` | While loading |
| Settings | Minimap bar button, Esc key | Always in game |
| Item lock | Lock buttons in bag/army, Cosmos, Einherjar, monsters, Theseus | Level >= 10 |
| Security code puzzle | Automatic (`8516` after first scene, or server push) | Switch 14 open |
| Update announcement | Post login popup, minimap "update" button | Level >= 25 for the popup, `VersionMsg.open_version` |
| Forced rename | Automatic during login | Name contains `!` |
| Rename card | Item use menu | Owns a rename card |
| Skip tutorial | Minimap button | During tutorial ([../tutorial/README.md](../tutorial/README.md)) |

## Modules

| Module | File | Routes (C>S and HTTP) | Server messages | Tables |
|---|---|---|---|---|
| Login and session | [login-session.md](login-session.md) | HTTP `loginselectlist`, `login`, `login2`, `flashversionservlet`; `20001`, `8224` (3 phases), `5035`, `5020`, `8260`, `8261`, `8620` | `3`, `6`, `3842`, `4160`, `4234`, `362`, `4245`, `4173`, `4172`, `4176`, `4244`, `4481`, `4613`, `4598`, socket close | `accounts`, `sessions`, `ip_bans`, `login_events`, `player_presence` |
| Server selection | [server-select.md](server-select.md) | HTTP `config.xml` (plus `loginselectlist`, `login` semantics) | none | `sites`, `servers`, `account_players` |
| Character creation and rename | [register.md](register.md) | HTTP `visualizeregister`, `updateplayernovice` (op 0, op 1), `selectjobregister`, `nicknamecheck`; `8345` | `4271` | `player_registrations`, `player_names`, `name_history`, `forbidden_words` |
| Security code | [security-code.md](security-code.md) | `8516`, `8514`, `8598` | `4402`, `4401`, `4490` | `security_challenges`, `security_lockouts` |
| Item lock | [item-lock.md](item-lock.md) | `8806` (ops 1..4), `8809` (11 object kinds) | `4696` (ops 1..6) | `item_lock_passwords`, `object_locks` |
| Settings | [settings.md](settings.md) | `8285`, `8286`, `8746` | `4193`, `4194`, `4635` | `player_privacy` |
| Switches and version flags | [switches.md](switches.md) | none (via `8224`) | `4422`, `4233` | `feature_switches`, `client_versions`, `player_version_seen` |
| Notices and client logging | [notices.md](notices.md) | HTTP `version.xml`, `logReuest` | `111` (via chat) | `update_announcements`, `update_announcement_items`, `client_logs` |

## Dependencies

- [../hero/README.md](../hero/README.md): owns `player.players` and the full `PlayerMsg` (`3`); account creates the row and fills login fields.
- [../tutorial/README.md](../tutorial/README.md): novice process values, `5017`, `5127`, `8871`, tutorial campaign; account provides the `updateplayernovice` and `selectjobregister` servlets.
- [../castle/README.md](../castle/README.md) (`4153`, `4154`), [../friends/README.md](../friends/README.md) (`4156`, `4245` content, online/offline pushes), [../farm/README.md](../farm/README.md) and [../golden-tree/README.md](../golden-tree/README.md) (`4157`), [../arena/README.md](../arena/README.md) (`4176`, `4244`, `4481`), [../army/README.md](../army/README.md) (`150`), [../navigation/README.md](../navigation/README.md) (`4595` scene entry), [../daily-activity/README.md](../daily-activity/README.md) (`8322` after phase A, post login sign-in popup), [../quests/README.md](../quests/README.md) and [../shops/README.md](../shops/README.md) (phase B): pushes required by the login sequence.
- [../inventory/README.md](../inventory/README.md), [../einherjar/README.md](../einherjar/README.md), [../monsters/README.md](../monsters/README.md), [../theseus/README.md](../theseus/README.md), [../cosmos/README.md](../cosmos/README.md): honor item locks.
- [../chat/README.md](../chat/README.md): `111` system tips, chat ban switch 223.
- [../customer-service/README.md](../customer-service/README.md): switch 3 and 11, mail check popup after login (switch 3066), doctor button on the loading screen.
- [../battle/README.md](../battle/README.md), [../campaign/README.md](../campaign/README.md): resume after `6` states 4 and 5.

## Suggested implementation order

1. [server-select.md](server-select.md): `sites`, `servers`, `config.xml` with RSA key.
2. [login-session.md](login-session.md): `loginselectlist`, `login`, `20001`, `3`, the 9 counted pushes of phase A (stub owners with empty but valid messages), phases B and C, `6`, scene entry.
3. [register.md](register.md): `visualizeregister`, `updateplayernovice`, then rename.
4. [switches.md](switches.md): `4422`, `4233`.
5. [settings.md](settings.md): privacy toggles.
6. [notices.md](notices.md): `version.xml`, `logReuest`.
7. [item-lock.md](item-lock.md), then hooks in owning features.
8. [security-code.md](security-code.md).

## Notable gaps

- No client handler for `3841`: a failed gateway login can only close the socket.
- `4401` (security code success) and `TimerInfoListMsg` have no client reader.
- `4696` and `8598` are missing from `protocol/opcodes.csv` (names from `ProtocolTypeTable.as`).
- The login hangs forever unless exactly the 9 phase A pushes arrive, and `4176` with `type = 1` does not count.
- Original BR switch values, queue message third field, and lockout policy of the security code are not in the client.
