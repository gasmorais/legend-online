# Steel teams ("Aliança" of the Batalha de Ferro)

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| SSF | `decompiled/m11/scripts/steel/view/search/SteelSearchFrame.as` |
| SSR | `decompiled/m11/scripts/steel/view/search/SteelSearchRightView.as` |
| SRI | `decompiled/m11/scripts/steel/view/search/SteelRecordItem.as` |
| STI | `decompiled/m11/scripts/steel/view/search/SteelTeamInfoItem.as` |
| SMV | `decompiled/m11/scripts/steel/view/member/SteelMemberView.as` |
| SAF | `decompiled/m11/scripts/steel/view/auditing/SteelAuditingFrame.as` |
| SAI | `decompiled/m11/scripts/steel/view/auditing/SteelApplyPlayerItem.as` |
| SII | `decompiled/m11/scripts/steel/view/invite/SteelInviteItem.as` |
| SIB | `decompiled/m11/scripts/steel/view/invite/SteelInviteItemButton.as` |
| SAA | `decompiled/core_module/scripts/yishi/actions/steel/SteelApplyAction.as` |
| PMN | `decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as` |
| SUI | `decompiled/core_module/scripts/map/campaign/data/SteelUserInfo.as` |

## 1. Overview

A team ("Aliança de {nome}") is founded by one player, the host ("Aliança principal" column shows the host nickname). The host invites players or accepts applications, can kick members and can hand over the host role. Members can leave. A player belongs to at most one team and can have at most 5 pending applications. A team holds at most 20 members (`SM:16`, `SMV:155`). Teams are cross-server: every team row carries its server name and id.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `steel.view.search.SteelSearchFrame` (SSF), `openType` 2 | "Aliança" | Browse teams, apply, create; closes itself once `selfTeamUid` is set (`SSF:64-71`) | lobby "Entrar na Aliança" | requests op 8 on open (`SSF:29`) |
| `SteelSeachLeftView` (SLV) | columns "Aliança da Guerra", "Aliança principal", "Poder de combate da Aliança" | 8 rows with check boxes (`SLV:89-99`), buttons apply, create, refresh | SSF | `teamList` from 4768 sorted by `fightPower` desc (`SC:164`): name "Aliança de {teamName}", `hostNickName`, `fightPower` (`STI:145-151`) |
| `SteelSearchRightView` (SSR) | column "Aliança da Guerra" plus operation | My pending applications, each with "Revogar" | SSF | `applyList` from 4768 (`applyInfo`) |
| `steel.view.member.SteelMemberFrame` (SMF), `openType` 1 | "Aliança de {selfTeamName}" | Member list; host sees invite, audit, quit; member sees quit (`SMF:158-175`) | lobby "A minha Aliança", create success (4773) | requests op 7 on open (`SMF:46`) |
| `SteelMemberView` (SMV) | columns "Personagem", "Nível", "Estado de batalha", "Poder de combate", footer "Númeo de pessoas na Aliança:" N " / 20" | rows from `userList` (4767); host first then by `fightPower` desc (`SC:276-295`); rows with `isExist == false` and `hostPlayer == 0` are hidden (`SMV:129`); count capped at 50 (`SMV:154`) | SMF | per row: job icon, nickname (VIP style), grade, state "Já entrou na batalha" when `isEnter != 0` else a placeholder (`SMI:243-245`), fight power, host flag, gray when offline |
| `SteelMemberItem` (SMI) | delete button | host kicks a member (`SMI:169-177`); click on another member opens `PlayerMenu` with "Nomear Presidente" only for the host (`SMI:195-214`) | SMV | |
| `steel.view.auditing.SteelAuditingFrame` (SAF), `openType` 3 | "Analíse e Aprovação" | Applicant list, 8 per page, select all, accept / ignore selected or per row | SMF audit button (host) | requests op 11 on open (`SAL:58`); on close requests op 7 (`SAF:113`) |
| `steel.view.invite.SteelInviteFrame` (SIF), `openType` 4 | "Convidar" | Tabs "Guilda", "Amigo", "Salão" (hall); search box (12 chars, `SteelInviteSearchView.as:109`); per row invite button; quick invite | SMF invite button (host) | candidates are online, not blacklisted (`relation != 2`), not self, not already in the team (`SIF:394-410`); on close requests op 7 (`SIF:451-453`) |
| Confirm dialog from `SteelApplyAction` (SAA) | "{0} convidou você para entra na Aliança de {0}" (key `steel.view.search.SteelSearchFrame.TipsTxt04`, both placeholders receive `teamName`, `SC:216`) | Accept or refuse an invitation | push 4763 | team name |

## 3. Routes (client to server)

All routes use C>S 8962 (0x2302) `C_STEEL_PLAYER_OP` with request `steel.SteelTeamInfoMsg`; only the listed fields are set. Full field list of `SteelTeamInfoMsg`: `teamUid (#1, STRING)`, `teamName (#2, STRING)`, `serverName (#3, STRING)`, `site (#4, STRING)`, `hostNickName (#5, STRING)`, `counts (#6, INT32)`, `succCount (#7, INT32)`, `lostCount (#8, INT32)`, `scoreMarks (#9, STRING)`, `enterPlayers (#10, STRING)`, `serverId (#11, INT32)`, `groupId (#12, INT32)`, `states (#13, INT32)`, `crossOrder (#14, INT32)`, `otherSide (#15, STRING)`, `property1 (#16, STRING)`, `property2 (#17, STRING)`, `property3 (#18, STRING)`, `param1 (#19, INT32)`, `param2 (#20, INT32)`, `param3 (#21, INT32)`, `param4 (#22, STRING)`, `param5 (#23, STRING)`, `param6 (#24, STRING)`, `fightPower (#25, INT32)`.

### R1. Create team (op 1)

- UI: SLV create button (`SLV:135-138`), confirm "Deseja consumir 1000000 ouro para criar Aliança？" (`SLV:149-157`).
- Client checks: gold >= 1 000 000 else tip "Ouro Insuficiente" (`SLV:164-169`).
- Sender: `SteelController.sendSteelCreateTeam` (`SC:496-502`).
- Fields: `param1 (#19)` = 1.
- Response: S1 4773; on success also S3 4767 is expected when the member frame opens (it sends op 7) and 109 gold update ([../castle/resources.md](../castle/resources.md)).

### R2. Kick member (op 2)

- UI: SMI delete button, visible for the host on non host rows (`SMI:246`, `SMI:169-177`). No confirmation.
- Sender: `sendSteelKillPlayer(userId)` (`SC:504-511`). Fields: `param1` = 2, `param2 (#20, INT32)` = target user id.
- Response: S3 4767 to the host (assumption) and to every member online; S6 4772 with empty `teamUid` to the kicked player (assumption).

### R3. Invite player (op 3)

- UI: invite button in SIF rows (`SII:115-143`, `SIB:148-169`). The button is replaced by an "invited" mark (no undo). Checks copied from the room invite: if a campaign room is open and its map `MinLevel` exceeds the target grade, tip "Nível insuficiente do jogador" and stop (`SII:128-141`); inside a wedding the click sends a wedding invite instead (`SII:123-127`).
- Sender: `sendSteelInvitePlayer(userId)` (`SC:513-520`). Fields: `param1` = 3, `param2` = target user id.
- Response: S5 4763 pushed to the target. No response to the host (assumption).
- Supporting routes in the frame: hall tab and refresh send C>S 5027 (0x13a3) `U_C_CAMPAIGN_INVITE_PLAYER_LIST` with empty body (`SocketSendManager.as:394-398`), answered by 4161 `U_C_INVITE_PLAYER_LIST` (`room.RoomPlayerListMsg`, `SIF:184-260`), see [../campaign/README.md](../campaign/README.md) (rooms). The quick invite button needs item 208003 or a free small bugle; else "Não há acessório correspondente, essa função não pode ser utilizada" and quick buy; then opens `pveroomlist` quick invite type 3 ([../chat/README.md](../chat/README.md)).

### R4. Apply to teams (op 4)

- UI: SLV apply button for every checked row (`SLV:174-200`).
- Client checks: at least one row selected else "Selecione Aliança"; `selected + applyList.length > 5` gives "As aplicações para a Aliança atingiram o máximo" (`SLV:187-192`).
- Sender: one request per team, `sendSteelApplyEnter(teamUid)` (`SC:522-529`). Fields: `param1` = 4, `param4 (#22, STRING)` = team uid.
- Response: S2 4768 to the applicant (refreshes `applyList`); S4 4774 to the host if online (assumption).

### R5. Change host (op 5)

- UI: `PlayerMenu` "Nomear Presidente" button `_changeMastBtn1` (`PMN:515-521`), shown only when the menu is opened from a member row by the host (`SMI:205-206`).
- Sender: `sendSteelChangeMast(userId)` (`SC:531-538`). Fields: `param1` = 5, `param2` = new host user id.
- Response: S3 4767 to all members (new `hostPlayer` flags).

### R6. List members (op 7)

- UI: SMF open (`SMF:46`), SAF close, SIF close.
- Sender: `sendSteelListUsers` (`SC:548-554`). Fields: `param1` = 7.
- Response: S3 4767.

### R7. List teams (op 8)

- UI: SSF open (`SSF:29`), SLV refresh (`SLV:140-147`).
- Sender: `sendSteelListTeams` (`SC:556-562`). Fields: `param1` = 8.
- Response: S2 4768.

### R8. Cancel application (op 10)

- UI: "Revogar" in SSR rows (`SRI:56-60`).
- Sender: `sendSteelCancelApply(teamUid)` (`SC:572-579`). Fields: `param1` = 10, `param4` = team uid.
- Response: S2 4768.

### R9. List applicants (op 11)

- UI: SAF open (`SAL:58`).
- Sender: `sendSteelApplyListReq` (`SC:581-587`). Fields: `param1` = 11.
- Response: S4 4774.

### R10. Accept or refuse applicant (op 12)

- UI: per row "Concordar" / "Ignorar" (`SAI:118-131`) or bulk buttons over checked rows (`SAL:245-285`). No confirmation.
- Sender: `sendSteelAgreeApply(userId, agree)` (`SC:589-597`). Fields: `param1` = 12, `param2` = applicant user id, `param3 (#21, INT32)` = 1 accept, 0 refuse.
- Response: S4 4774 (applicant removed); on accept S3 4767 to members and S6 4772 to the new member (assumption).

### R11. Reply to invitation (op 13)

- UI: confirm dialog from SAA (`SAA:56-68`).
- Sender: `sendSteelInviteReply(teamUid, accept)` (`SC:599-607`). Fields: `param1` = 13, `param2` = 1 accept, 0 refuse, `param4` = team uid.
- Response: on accept S6 4772 and S3 4767 (assumption); on refuse nothing.

### R12. Quit team (op 14)

- UI: SMF quit button (host) or member quit button, confirm "Deseja sair da Aliança?" (`SMF:111-133`); the frame closes after sending.
- Sender: `sendSteelQuit` (`SC:609-615`). Fields: `param1` = 14.
- Response: S6 4772 with empty `teamUid`; S3 4767 to remaining members. Host quitting: assumption below.

## 4. Server messages (server to client)

`SteelUserInfoMsg` fields: `teamUid (#1, STRING)`, `userId (#2, INT32)`, `nickName (#3, STRING)`, `grades (#4, INT32)`, `job (#5, INT32)`, `fightPower (#6, INT32)`, `hostPlayer (#7, INT32)` 1 = host, `isEnter (#8, INT32)` 1 = already in the battle, `isExist (#9, BOOL)` still a member, `property1 (#10, STRING)`, `property2 (#11, STRING)`, `isOnline (#12, BOOL)`. Client converts to `ThaneInfo` with `consortiaID = 1` and `state = 7` when online (`SUI`).

`SteelTeamListMsg` fields: `param1 (#1, INT32)`, `param2 (#2, INT32)`, `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, STRING)`, `states (#7, INT32)`, `group (#8, INT32)`, `eventType (#9, INT32)`, `teamInfo (#10, MESSAGE SteelTeamInfoMsg, repeated)`, `applyInfo (#11, MESSAGE SteelTeamInfoMsg, repeated)`.

`SteelUserListMsg` fields: `param1 (#1, INT32)`, `param2 (#2, INT32)`, `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, STRING)`, `userInfo (#7, MESSAGE SteelUserInfoMsg, repeated)`.

### S1. 4773 (0x12a5) `U_C_STEEL_CREATERESULT`

`SteelTeamInfoMsg`. Receiver `__teamCreateResultHandler` (`SC:132-143`): when `states (#13) == 1`, opens SMF (`steelmap`, 1), stores `selfTeamUid = teamUid (#1)` and commits. Any other `states` value: no client reaction (send a generic alert, assumption 111 `U_C_CHANNEL_ALERT`). When: response to op 1.

### S2. 4768 (0x12a0) `U_C_STEEL_TEAMLIST`

`SteelTeamListMsg`. Receiver `__teamListHandler` (`SC:145-168`): `teamInfo` becomes `model.teamList`, `applyInfo` becomes `model.applyList`, both sorted by `fightPower` desc. Team row fields read: `teamUid`, `teamName`, `hostNickName`, `fightPower` (plus every other field copied, `SC:336-440`). The left list shows the first 8 rows only (no paging, `SLV:218-228`). When: response to ops 4, 8, 10.

### S3. 4767 (0x129f) `U_C_STEEL_USERLIST`

`SteelUserListMsg`. Receiver `__userListHandler` (`SC:170-190`): `selfTeamName = param4 (#4)`, `hostPlayerId` = user with `hostPlayer == 1`, `userList` sorted host first. When: response to op 7, and push to online members on any membership change (assumption).

### S4. 4774 (0x12a6) `U_C_STEEL_APPLYLIST`

`SteelUserListMsg`. Receiver `__applyListHandler` (`SC:192-209`): `auditList = userInfo` sorted by fight power, page count `ceil(n / 8)`. When: response to ops 11 and 12, push to the host when a new application arrives (assumption).

### S5. 4763 (0x129b) `U_C_STEEL_INVITE`

`SteelTeamInfoMsg`. Receiver `__inviteHandler` (`SC:211-218`): queues `SteelApplyAction(teamUid, text)` in `PopFrameCheck`; the dialog appears when the scene allows (`SAA:26-38`). Fields read: `teamUid (#1)`, `teamName (#2)`. When: push to the invitee after op 3.

### S6. 4772 (0x12a4) `U_C_MYTEANINFO`

See [steel-lobby.md](steel-lobby.md). Used here to tell a player that his team changed.

## 5. Rules and formulas

- Create cost: 1 000 000 gold (`SLV:53`, `SLV:164`). Creator becomes host; one team per player.
- Member cap: 20 (`SM:16`, footer `SMV:155`). Applications per player: 5 (`SM:18`, `SLV:187`). Applicant list page: 8 (`SM:12`).
- Only the host can invite, audit, kick and change host (UI visibility `SMF:158-175`, `SMI:246`); the server must enforce it.
- Team name: the client never sends a name; it shows "Aliança de {teamName}" where `teamName` is the host nickname (assumption: server sets `teamName` = host nickname).
- Team fight power: sum of member fight power (assumption).
- Membership changes are forbidden while the team is in battle (assumption).
- Host quits: assumption, the host role passes to the member with the highest fight power; if the team becomes empty it is dissolved and the creation gold is not refunded.

## 6. Templates

None. Strings: `index/language.json` keys `steel.view.search.*`, `steel.view.member.*`.

## 7. Persistent state

```sql
CREATE TABLE league.steel_teams (
    team_uid       uuid        PRIMARY KEY,
    season_id      bigint      REFERENCES league.steel_seasons(season_id),
    server_id      integer     NOT NULL,
    server_name    text        NOT NULL,
    team_name      text        NOT NULL,
    host_player_id bigint      NOT NULL REFERENCES player.players(player_id),
    battles        integer     NOT NULL DEFAULT 0 CHECK (battles >= 0),
    wins           integer     NOT NULL DEFAULT 0 CHECK (wins >= 0),
    losses         integer     NOT NULL DEFAULT 0 CHECK (losses >= 0),
    cross_order    integer,
    group_id       integer,
    state          smallint    NOT NULL DEFAULT 0,
    created_at     timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX steel_teams_season_idx ON league.steel_teams (season_id, cross_order);

CREATE TABLE league.steel_team_members (
    team_uid   uuid        NOT NULL REFERENCES league.steel_teams(team_uid) ON DELETE CASCADE,
    player_id  bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    is_host    boolean     NOT NULL DEFAULT false,
    entered_battle boolean NOT NULL DEFAULT false,
    joined_at  timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (team_uid, player_id),
    UNIQUE (player_id)
);
CREATE UNIQUE INDEX steel_team_one_host ON league.steel_team_members (team_uid) WHERE is_host;

CREATE TABLE league.steel_applications (
    team_uid   uuid        NOT NULL REFERENCES league.steel_teams(team_uid) ON DELETE CASCADE,
    player_id  bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    applied_at timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (team_uid, player_id)
);
CREATE INDEX steel_applications_player_idx ON league.steel_applications (player_id);

CREATE TABLE league.steel_invitations (
    team_uid   uuid        NOT NULL REFERENCES league.steel_teams(team_uid) ON DELETE CASCADE,
    player_id  bigint      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    invited_by bigint      NOT NULL REFERENCES player.players(player_id),
    invited_at timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (team_uid, player_id)
);
```

Cross-server note: when teams of several servers meet on a central server, `player_id` references stay local and the cross service keys players by `(server_id, player_id)` (assumption, see [../cross-server/README.md](../cross-server/README.md)).

## 8. Backend implementation notes

Handlers (called by `league::steel::handle_player_op`):

| op | Handler | Validation order | Transaction |
|---|---|---|---|
| 1 | `league::steel_teams::handle_create` | season open, no team, gold >= 1 000 000 | spend gold (castle API, reason `steel_team_create`), insert team and host member, delete own applications; reply 4773 `states` 1, then 109 |
| 2 | `handle_kick` | caller is host, target member, target not host, team not in battle | delete member; push 4767 to members, 4772 to target |
| 3 | `handle_invite` | caller is host, team size < 20, target online, target without team | upsert invitation; push 4763 to target |
| 4 | `handle_apply` | no team, pending applications < 5, team exists, team size < 20 | insert application; reply 4768; push 4774 to host |
| 5 | `handle_change_host` | caller is host, target member | swap `is_host`, update `host_player_id` and `team_name` if it follows the host; push 4767 |
| 7 | `handle_list_members` | caller in a team | reply 4767 (`param4` = team name) |
| 8 | `handle_list_teams` | none | reply 4768 (`teamInfo` = open teams of the season, `applyInfo` = caller's applied teams) |
| 10 | `handle_cancel_apply` | application exists | delete; reply 4768 |
| 11 | `handle_list_applicants` | caller is host | reply 4774 |
| 12 | `handle_review_applicant` | caller is host, application exists, on accept: applicant without team and size < 20 | delete application; on accept insert member and delete the applicant's other applications; reply 4774, push 4767 and 4772 |
| 13 | `handle_reply_invite` | invitation exists, on accept: no team and size < 20 | delete invitation; on accept insert member, delete own applications; push 4772 and 4767 |
| 14 | `handle_quit` | caller in a team, team not in battle | delete member; host transfer or dissolve; push 4772 to caller, 4767 to others |

Failures: generic alert (assumption 111) and no state change.

## 9. Open questions and assumptions

- Assumption: server responses not proven by the client (pushes after kick, accept, reply, quit).
- Assumption: `teamName` equals the host nickname, team fight power is the member sum.
- Assumption: host quit transfers the host role.
- Open: whether the team must be cross-server unique per season and how teams are grouped (`groupId`, `serverId`).
- Open: invitation expiry (no client timer).

## 10. Implementation checklist

- [ ] Screens SSF, SMF, SAF, SIF and the invitation dialog.
- [ ] Routes 8962 ops 1, 2, 3, 4, 5, 7, 8, 10, 11, 12, 13, 14.
- [ ] Supporting route 5027 / 4161 (campaign rooms).
- [ ] Server messages 4773, 4768, 4767, 4774, 4763, 4772.
- [ ] Tables `league.steel_teams`, `league.steel_team_members`, `league.steel_applications`, `league.steel_invitations`.
- [ ] Rules: 1 000 000 gold, 20 members, 5 applications, host only actions.
- [ ] Tests: create with 999 999 gold rejected; sixth application rejected; non host kick rejected; accept fills the team and clears other applications; quit as host transfers the role.
