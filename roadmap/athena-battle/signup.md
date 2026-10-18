# Athena battle: signup, team list and invitations

Module `athena_battle::signup`. Prefixes as in [README.md](README.md). Read the critical finding in the README first: none of the server messages below is received by this client build.

## 1. Overview

The SignUp frame (tab 0) shows the personal category, score, event time, the signup button, the create team button and the list of open teams (auto refresh every 10 s while the event is open). The Invite frame (tab 3) lists signed players without a team, refreshed every 60 s. An invited player gets a dialog and joins with op 3 + team uid.

## 2. Screens

Controller `braveleg`: `openType.tab` 0 SignUp, 1 Team, 2 Rank, 3 Invite, 4 Matrix (`CM/mvc/controler/BraveLegController.as:31-49`).

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `braveleg.BraveLegSignUpFrame` (1084x625) | Batalha de Athena | signup, team list, create team, top players, shop, ranking | presumed 379 handler `__viewInfoHandler` (only in `SPACE_SCENE` or `CASTLE_SCENE`) (`CM/yishi/manager/BraveLegManager.as:228-252`) | category medal and next category tip (`Brave_TeamType`), score, `braveleg.SignUp.Desc` "Inscrição: Modo individual Tempo do Evento: {0}Modo de combate: 2~4 jogadores ... Ainda falta(m) {1} rodadas" (`openTime`, `leftWarIndex`), signup button disabled when `isSign` (tip "Já se inscreveu"), create team enabled only when `isOpen` (tip "Evento ainda não iniciou"), top list 5 per page (`M11/braveleg/BraveLegSignUpFrame.as:423-505`) |
| `braveleg.signup.BraveLegTeamItem` | | one open team: name "Equipe {0}", members count, info and join buttons | team list | `teamList` (`M11/braveleg/signup/BraveLegTeamItem.as:107-123`) |
| `braveleg.BraveLegInviteFrame` (306x442) | Convidar | invite signed players without team; refresh button (1 s throttle) and auto refresh 60 s ("Após {0}seg será atualizado automaticamente") | Team frame invite button -> op 9 then tab 3 (`M11/braveleg/BraveLegTeamFrame.as:306-311`) | `inviteList` sorted by level desc (`M11/braveleg/BraveLegInviteFrame.as:89-115`; `M11/braveleg/invite/BraveLegInviteItem.as:82-105`) |

## 3. Routes (client to server)

All: **C to S 9619 (0x2593) `C_BRAVELEG_CLIENT_OP`**, body `BraveLegListMsg`: `op` (#1, INT32), `eventId` (#2), `uid` (#3, STRING, team uid), `userId` (#4, INT32, target player), `serverId` (#5), `openTime` (#6, STRING), `isSign` (#7, BOOL), `isOpen` (#8, BOOL), `leftTime` (#9, INT32), `season` (#10), `warIndex` (#11), `currentTurn` (#12), `maxTurnCount` (#13), `totalScore` (#14), `teamType` (#15), `order` (#16), `isOver` (#17, BOOL), `leftWarIndex` (#18), `info` (#19, `BraveLegInfoMsg`, repeated), `headId` (#20), `groupId` (#21, INT32, 1..3), `skillMasterType` (#22, INT32). Op constants `BraveLegManager.as:31-53`: 1 OPENTABLE, 2 REQUTSIGN, 3 CREATTEAM, 4 LEAVETEAM, 5 KILLSTEAM, 6 LISTTEAMS, 7 INVITEING, 8 RANKSLIST, 9 PLAYERLIST, 10 INSPIRE, 11 EDITTEAM, 12 CHANGE_INSPIRE.

| # | Action | UI control | Client sender | Client checks | Request | Presumed responses |
|---|---|---|---|---|---|---|
| B1 | Open | top bar `braveleg` | `requestViewInfo` (`BraveLegManager.as:83-94`) | `grades >= 40` else `armyII.viewII.information.GoodsExchangeItem.bravelegShopPrompt` "Batalha de Athena apenas liberado ao atingir Nv.{0}" | `{op:1}` | 379 (if the player has a team the server should instead send 378, A) |
| B2 | Sign up | `_signUpBtn` | `__signUpBtnClickHandler` -> `conformSignUp` -> `requestSignUp` (`M11/braveleg/BraveLegSignUpFrame.as:327-351,416-422`; `BraveLegManager.as:96-102`) | `isOver` -> `braveleg.Error.str03` "Edição atual encerrada!"; `isSign` -> `str04` "Você já se inscreveu na batalha de Athena!" and re-request op 1; `isOpen` -> `str05` "Batalha de Athena iniciou!"; confirmation `braveleg.Dialog.signup` "Deseja consumir {0} ouro para inscrever-se na Batalha de Athena?" (`Brave_NeedGold`) | `{op:2}` | 379 with `isSign = true`, gold update |
| B3 | List teams | frame open, refresh button (throttle, `str06` "Atualizou muito rápido..."), 10 s timer | `requestTeamList` (`BraveLegManager.as:157-163`; `BraveLegSignUpFrame.as:115,290-312`) | `isOpen` for the timer | `{op:6}` | 377 |
| B4 | Create team | `_createTeamBtn` | `__createTeamBtnClickHandler` -> `requestCreateTeam()` (`BraveLegSignUpFrame.as:353-371`; `BraveLegManager.as:112-132`) | `isOver` `str03`; not signed `str02` "Ainda não se inscreveu na Batalha de Athena!"; not open `str01` "A Batalha de Athena ainda não começou!" | `{op:3}` | 378 (team) |
| B5 | Join a team | team item join | `BraveLegTeamItem.__joinBtnClickHandler` -> `requestCreateTeam(uid)` (`signup/BraveLegTeamItem.as:115-123`) | same as B4 inside the manager | `{op:3, uid}` | 378 to the joiner, 378 to all members (A) |
| B6 | Invite list | Team frame invite button, Invite refresh / 60 s timer | `requestInviteList` (`BraveLegManager.as:165-171`) | 1 s throttle | `{op:9}` | 382 |
| B7 | Invite player | invite item button | `BraveLegInviteItem.__inviteClick` -> `requestInviteFriend(userId)` (`invite/BraveLegInviteItem.as:82-89`; `BraveLegManager.as:173-180`) | none | `{op:7, userId}` | 380 to the target |
| B8 | Accept invitation | dialog on 380 | `__inviteInfoHandler.conformInvite` -> `requestCreateTeam(msg.uid, true)` (`BraveLegManager.as:291-372`) | dialog suppressed in battle, vehicle, campaign map, cross guild scene, poker, child arena, ecliptic palace, land mine, dream arena matching, answer frame, mop-up, marriage lock, group dungeon team, outyard apply; text `braveleg.Dialog.invite` "{0} convidou você para entrar na batalha de Athena?"; open/sign checks skipped (`param2 = true`) | `{op:3, uid}` | 378 |
| B9 | Shop | shop button | `shop` openType 16 (`BraveLegSignUpFrame.as:314-318`) | | shop module | |

## 4. Server messages (server to client), presumed mapping

Mapping from PTT names (PTT:815-822); no listener exists in this client.

| Opcode | Hex | PTT name | Body | Handler it would feed |
|---|---|---|---|---|
| 379 | 0x017B | `U_C_BRAVE_INFO` "打开勇者征程面板信息" | `BraveLegListMsg` | `__viewInfoHandler` (`:228-252`): `isSign`, `isOpen`, `isOver`; clears team; opens tab 0 with `resovleSignUpInfo` (`openTime`, `isSign`, `isOpen`, `season`, `warIndex`, `currentTurn`, `maxTurnCount`, `totalScore`, `teamType`, `order`, `isOver`, `leftWarIndex`, `info` top list sorted by `rankOrder` padded to 5); if open sends op 6 |
| 377 | 0x0179 | `U_C_BRAVE_ALLTEAMS` | `BraveLegListMsg` | `__teamListInfoHandler` (`:270-289`): each `info` row is a team: `uid` team uid, captain fields, `result` (#18) = member count (`teammateNum`) |
| 380 | 0x017C | `U_C_BRAVE_INV` | `BraveLegInfoMsg` | `__inviteInfoHandler`: `uid` (team), `nickName` (inviter) |
| 382 | 0x017E | `U_C_BRAVE_PLAYERLIST` | `BraveLegListMsg` | `__playerListInfoHandler` (`:383-390`): `info` = signed players without team |
| 376 | 0x0178 | `U_C_BRAVE_OPENSTATE` "雅典娜之战-按钮状态" | (A) `simple.PropertyMsg` like 374/4801 | would set `TopToolsBar.braveLegState` (badge 0/1/2, `CM/ui/toptoolbar/TopBtnItemView.as:307-310`) |

`BraveLegInfoMsg`: `uid` (#1, STRING), `userId` (#2, INT32), `serverName` (#3, STRING), `nickName` (#4, STRING), `headId` (#5, INT32), `grades` (#6, INT32), `fightPower` (#7, INT32), `teamType` (#8, INT32, category 0..5), `totalScore` (#9, INT32), `rankOrder` (#10, INT32), `season` (#11, INT32), `groupId` (#12, INT32, group 1..3 inside the team), `isMaster` (#13, BOOL, team leader), `orderTemp` (#14), `sexJob` (#15, INT32), `dayScore` (#16), `lastTotalScore` (#17), `result` (#18, INT32; member count in 377), `lastWinCount` (#19) (#14, #16, #17, #19 not read).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| S1 | Level 40 | `BraveLegManager.as:85`; `TopBtnCheckShowHelper.as:353` |
| S2 | Signup cost `Brave_NeedGold` = 1000000 gold; only before the event opens and when not over | config; B2 checks |
| S3 | Schedule `Brave_Day` = 4 (A: Thursday with Monday = 1), `Brave_Time` 20:00,21:00 | config |
| S4 | Team size 2..4; fight requires >= 2 members ("Quando o número de membros ≥ 2, a competição poderá iniciar normalmente.") | LANG `braveleg.SignUp.Desc`, `braveleg.Team.Warn`; Team frame shows 4 slots |
| S5 | Teams can only be created or joined while the event is open and the player is signed | `BraveLegManager.as:112-123` |
| S6 | A player in a team cannot open guild or archaeology frames | navigation |

## 6. Templates

`TPL/ConfigInfos.xml`: `Brave_NeedGold`, `Brave_Day`, `Brave_Time`.

## 7. Persistent state

Schema `athena_battle`.

```sql
CREATE TABLE athena_battle.round (
  season_no       integer NOT NULL,
  round_no        smallint NOT NULL,                   -- warIndex
  fight_starts_at timestamptz NOT NULL,
  fight_ends_at   timestamptz NOT NULL,
  max_turns       smallint NOT NULL,
  closed          boolean NOT NULL DEFAULT false,
  PRIMARY KEY (season_no, round_no)
);

CREATE TABLE athena_battle.signup (
  season_no       integer NOT NULL,
  round_no        smallint NOT NULL,
  player_id       integer NOT NULL REFERENCES player.players(player_id),
  server_id       integer NOT NULL,
  gold_paid       bigint NOT NULL,
  signed_at       timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (season_no, round_no, player_id),
  FOREIGN KEY (season_no, round_no) REFERENCES athena_battle.round(season_no, round_no)
);

CREATE TABLE athena_battle.invitation (
  team_uid        uuid NOT NULL,
  inviter_id      integer NOT NULL REFERENCES player.players(player_id),
  invitee_id      integer NOT NULL REFERENCES player.players(player_id),
  created_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (team_uid, invitee_id)
);
```

Teams are in [team.md](team.md).

## 8. Backend implementation notes

- `athena_battle::signup::handle_view_info` (op 1), `handle_sign_up` (op 2), `handle_list_teams` (op 6), `handle_create_or_join_team` (op 3), `handle_invite_list` (op 9), `handle_invite` (op 7). Validation as in the client checks plus: one team per player, team not full (4), team not in battle.
- Gate: until the client listeners are restored, do not emit 376..383 (they collide with Air Garden and campaign handlers).

## 9. Open questions and assumptions

- (A) Opcode to handler mapping from PTT names.
- (A) 376 body type.
- (A) Signup per round or per season.

## 10. Implementation checklist

- [ ] Decision on restoring listeners (blocking)
- [ ] Tables `round`, `signup`, `invitation`
- [ ] Ops 1, 2, 3, 6, 7, 9 and pushes 379, 377, 378, 380, 382
- [ ] Tests: signup checks; join full team; invitation to a player already in a team
