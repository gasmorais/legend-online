# Free team (Equipe)

Feature `team`, module `freedom-team`. Team lifecycle on the world map.

Conventions: paths relative to the repository root; AS3 citations `decompiled/<module>/scripts/<path>.as:<line>`; opcodes from `protocol/opcodes.csv` and `decompiled/core_module/scripts/yishi/datas/consant/ProtocolType.as` / `AcceptProtocolType.as` when missing from the CSV; `simple.PropertyMsg` fields come from the AS3 class (`decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as`) because the name collides in `proto.json`: `param1 (#1, INT32)`, `param2 (#2, INT32)`, `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, STRING)`, `param7 (#7, BOOL)`, `param8 (#8, BOOL)`, `param9 (#9, BOOL)`, `param10 (#10, INT32)`, `param11 (#11, INT32)`, `param12 (#12, STRING)`.

## 1. Overview

There is no explicit "create team" request. Player A invites B (8738); the server pushes 4620 to B; B accepts or rejects (8734 with `param7`). On accept, if A had no team the server creates one with A as captain and pushes 4622 (full `TeamInfoMsg`) to both; if A's team exists, B is added and every member gets 4626. Member state changes (position, online, map, power) arrive as 4624. Captain change 4627, member left 4629, kick 4630, dismiss 4625. The client keeps the team only in memory (`FreedomTeamManager._model`). On SVS (cross server world boss) maps the client uses the `CR_*` opcodes with server names.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `team.FreedomTeamManageFrame` `decompiled/m3/scripts/map/internals/view/team/FreedomTeamManageFrame.as` | "Gerenciamento da Equipe" (`map.campaign.view.frame.ArmyManageFrame.title`); buttons "Adicionar", "Capitão", "Formação dos Soldados"/"Ver Formação", "Expulsar", "Sair da Equipe" | Member cards (`manage/FreedomTeamManageHeroItem.as`), captain marker, actions | resource bar team button (`decompiled/core_module/scripts/ui/resourcebar/view/ResourceExtraView.as:158`), controller key `freedomteam` default type | `FreedomTeamModel.allMembers` |
| `team.FreedomTeamInviteFrame` `decompiled/m3/scripts/map/internals/view/team/FreedomTeamInviteFrame.as` | "Convidar"; tabs "Guilda", "Amigos" (and hall); "Atualizar" | Invite candidates sorted by level; refresh (`__refreshClick` `:168`: guild list, friend list, or 5027 hall list) | "Adicionar" (`FreedomTeamManageFrame.as:174`, controller `freedomteam` `OPEN_INVITEFRAME`) | friends, guild members, hall players |
| `invite/FreedomTeamInviteItem`, `FreedomTeamInviteItemButton` | level "Nv.{0}" | Invite one player; button enabled by `canInviteMember` (`FreedomTeamInviteItemButton.as:167`) | invite frame | |
| `FreedomTeamListView` + `list/FreedomTeamListItemView` | tooltip "Poder" | Side panel with members, online state, level, power | map scene (`showTeam`) | `memberState`, `memberFightCapacity` |
| Invitation popup (`FreedomTeamApplyAction`) `decompiled/core_module/scripts/yishi/actions/team/FreedomTeamApplyAction.as:40` | "{0} Convidou você para formar equipe!" (`managers.FreedomTeamManager.teamInviteTxt`), "Confirmar"/"Cancelar" | Accept or reject | push 4620 | inviter name |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| T1 | Invite ("Convidar para a Equipe", invite frame, IM invite button, chat menu) | `FreedomTeamManager.inviteMember` `decompiled/core_module/scripts/managers/FreedomTeamManager.as:204` then `FreedomTeamSocketOutManager.sendInvite` `decompiled/core_module/scripts/managers/FreedomTeamSocketOutManager.as:38`; callers `PlayerMenu.as:548`, `ChatItemMenu.as:552`, `IMFrame.__inviteBtnClickHandler` `decompiled/m12/scripts/im/IMFrame.as:248`, `FreedomTeamInviteItem.as:104`, `FreedomTeamInviteItemButton.as:141` | `checkScene(true)` (`:314`): not in Brave Legend team, not in the Ecliptic Palace frame, not in the land mine frame; scenes `SECRET_ADVENTURE_SCENE`, `THESE_PVP_SCENE`, `SECRET_WAR_SCENE`, `CHILD_NS_WAR_SCENE` block. Menu visibility `canInviteMember` (`:749`): local: target level >= 36, own level >= 36, target not in team, not on a market map | C>S 8738 0x2222 `C_INVITE_TEAM` | `PropertyMsg`: `param1` = target user id | target receives 4620 (or a 111 alert to the inviter on failure, Assumption) |
| T1x | Same on an SVS map (`isCrossAllowTeam`, `WorldBossHelper.checkSvs(mapId)`, `:191`) | `sendInviteCross` `FreedomTeamSocketOutManager.as:133` | only "target not in team" | C>S 25138 0x6232 `CR_INVITE_TEAM` | `PropertyMsg`: `param1` target id, `param4` own server name, `param5` target server name (from `SvsController.userDic` when missing, `:223`) | as T1 |
| T2 | Accept or reject invitation | `FreedomTeamApplyAction.__requestFrameCloseHandler` `FreedomTeamApplyAction.as:59` then `FreedomTeamManager.applyInvite` `:286` then `sendApplyInvite` `FreedomTeamSocketOutManager.as:21` | popup suppressed when the inviter is in the blacklist (relation 2) or `checkScene()` fails (`FreedomTeamManager.as:173`) | C>S 8734 0x221e `C_APPLY_INVITE_TEAM` | `PropertyMsg`: `param1` inviter user id, `param7` true accept / false reject | accept: 4622 to both if new team, else 4626 to all members; reject: Assumption 111 alert to the inviter |
| T2x | Same, SVS | `sendApplyInviteCross` `:112` | | C>S 25135 0x622f `CR_APPLY_INVITE_TEAM` | `param1` inviter id, `param4` own server, `param5` inviter server, `param7` accept | as T2 |
| T3 | "Capitão" | `FreedomTeamManageFrame.__changeBtnClickHandler` `FreedomTeamManageFrame.as:180` then `FreedomTeamManager.changeCaptain` `:238` | a member selected, actor is captain (button state) | C>S 8736 0x2220 `C_CHANGE_CAPTAIN` (`sendChangeCaptain` `:30`) / 25136 0x6230 `CR_CHANGE_CAPTAIN` (`:123`) | `PropertyMsg`: `param1` new captain id (cross: `param4` own server, `param5` target server) | 4627 to all members |
| T4 | "Expulsar" | `FreedomTeamManageFrame.__kickBtnClickHandler` `:195`, confirmation "Deseja expulsar da equipe?", `__requestKickBtnHandler` `:210` then `kickMember` `:250` | captain only | C>S 8739 0x2223 `C_KICK_TEAM_MEMBER` (`:46`) / 25139 0x6233 `CR_KICK_TEAM_MEMBER` (`:143`) | `PropertyMsg`: `param1` member id (cross: `param4`, `param5`) | 4630 to all members including the kicked one; 4625 if the team falls below 2 (Assumption) |
| T5 | "Sair da Equipe" | `FreedomTeamManageFrame.__quitBtnClickHandler` `:218`, confirmation "Deseja sair da equipe?", then `quit` `:262` | none | C>S 8741 0x2225 `C_QUIT_TEAM` (`:60`, no body) / 25140 0x6234 `CR_QUIT_TEAM` (`:153`, `param4` own server) | none / `PropertyMsg` | 4629 to all members including the leaver; 4625 to the last member when the team dissolves (Assumption) |
| T6 | Leave for now (AFK) | `FreedomTeamSocketOutManager.sendAFK` `:54` | no caller in this client | C>S 8740 0x2224 `C_LEAVE_TEAM_FOR_NOW` | no body | 4621 |
| T7 | Refuse team invitations toggle (settings, many mini game frames) | `SocketSendManager.sendRefuseTeamInvite` `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:432`; callers `SettingFrame` `decompiled/m11/scripts/setting/SettingFrame.as:461`, `TopToolsBar.as:1229`, `ChatOutputViewII.as:1229`, fish, slot, gold road frames | toggles; frames that need peace call it on open and close | C>S 8746 0x222a `C_TEAM_REFUSE` | no body | 4635 |

## 4. Server messages (server to client)

`TeamInfoMsg` (`team`): `team_id (#1, INT32)`; `memberId (#2, INT32, repeated)` member ids, order = display order; `captain_id (#3, INT32)`; `memberDetail (#4, TeamPlayerInfoMsg, repeated)`; `captain_serverName (#5, STRING)`.

`TeamPlayerInfoMsg` fields read by `FreedomTeamManager.readMember` (`FreedomTeamManager.as:428`): `player_id (#6, INT32)`, `hero_id (#5, INT32)`, `grades (#7, INT32)`, `nick_name (#8, STRING)`, `server_name (#32, STRING)`, `template_id (#10, INT32)` (ignored for self), `head_id (#26, INT32)`, `arm (#11, STRING)`, `cloth (#12, STRING)`, `wing (#31, STRING)`, `hat (#33, STRING)`, `fashion_arm (#34, STRING)`, `fashion_cloth (#35, STRING)`, `hide (#36, BOOL)`, `change_shapeId (#21, INT32)`, `online_state (#18, BOOL)`, `geste (#25, INT32)`, `appellid (#37, INT32)`, `avenger_grade (#48, INT32)`, `vehicleTemplateId (#38, INT32)`, `is_vip (#27, BOOL)`, `vip_type (#28, INT32)`, `pet_name (#42, STRING)`, `pet_quqlity (#41, INT32)`, `petTemplateId (#40, INT32)`, `child_name (#45, STRING)`, `child_job (#44, INT32)`, `child_sex (#46, INT32)`, `growth_grade (#47, INT32)`, `consortia_id (#19, INT32)`, `consortia_name (#20, STRING)`, `fighting_capacity (#14, INT32)`, `is_back_player (#43, BOOL)`, `army_id (#13, INT32)`, `cur_pos_x (#15, INT32)`, `cur_pos_y (#16, INT32)`, `campaign_id (#17, INT32)` map id, `mount_tempId (#29, INT32)`, `mount_grade (#30, INT32)`. Unused by this reader: `count (#2)`, `hasLeftForNow (#4)`, `sex (#9)`, `army_state (#22)`, `team_id (#23)`, `buffer_tempId (#24)`, `fate_skills (#39)`, `growth_grade2 (#49)`.

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 4622 0x120e `U_C_TEAM_CREATE` | `TeamInfoMsg` (full) | `__teamCreateHandler` `FreedomTeamManager.as:83` | to every member when a team is formed | new model, `TEAM_INFO_UPDATE`, `HIDE_OTHERS` |
| S>C 4626 0x1212 `U_C_TEAM_ADD_MEMBER` | `TeamInfoMsg` (full list, details at least for the new member) | `__teamAddMemberHandler` `:125` | to all members (and the new one) on join | merges members |
| S>C 4624 0x1210 `U_C_TEAM_PLAYER_INFO` | `TeamInfoMsg` with changed `memberDetail` only | `__teamPlayerInfoHandler` `:154` | member moved, changed map, went online/offline, changed level/power/appearance | `TEAM_INFO_SYNC` (positions on the map) |
| S>C 4620 0x120c `U_C_TEAM_INVITE` | `InviteTeamMsg`: `team_id (#1, INT32)`, `inviter_id (#2, INT32)`, `inviter_name (#3, STRING)`, `inviter_serverName (#4, STRING)` | `__teamInviteHandler` `:173` | to the invitee, unless refusing invites | popup `FreedomTeamApplyAction` |
| S>C 4627 0x1213 `U_C_TEAM_CAPTAIN_CHANGE` | `PropertyMsg`: `param1` new captain id | `__teamCaptainChangeHandler` `:354` | to all members | |
| S>C 4629 0x1215 `U_C_TEAM_MEMBER_LEFT` | `PropertyMsg`: `param1` user id who left | `__teamMemberLeftHandler` `:367` | to all members incl. the leaver | self id clears the team (`removeMemberByUserId` `:393`) |
| S>C 4630 0x1216 `U_C_TEAM_KICK_MEMBER` | `PropertyMsg`: `param1` kicked user id | `__teamKickMemberHandler` `:380` | to all members incl. the kicked | as 4629 |
| S>C 4625 0x1211 `U_C_TEAM_DISMISS` | no body | `__teamDismissHandler` `:113` | team dissolved | clears the model |
| S>C 4621 0x120d `U_C_TEAM_LEAVE_FOR_NOW` | `PropertyMsg` (fields ignored) | `__teamAFKHandler` `:342` | after 8740 | refresh |
| S>C 4628 0x1214 `U_C_TEAM_FIGHT_POS_CHANGE` | see [fight-positions.md](fight-positions.md) | | | |
| S>C 4635 0x121b `U_C_REFUSETEAMINVITE_REFRESH` | `player.RefuseFriendRspMsg`: `result (#1, BOOL)` new refuse state | `PlayerManager.__uRefuseTeamInvite` `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:477`, `SettingFrame` | response to 8746 | `playerInfo.refuseTeamInvite` |
| S>C 4220 0x107c `U_C_WARFIELD_FLAG_END_TIME` | `WarFightFlagEndTimeMsg`: `endTime (#1, STRING)` | listened by `FreedomTeamManager.__timeendtimeCreateHandler` `:74` | war field feature (not team) | notification only |

## 5. Rules and formulas

- Team size max 4 (`teamIsFull` `FreedomTeamManager.as:793`).
- Level 36 for both inviter and target on local maps (`canInviteMember` `:749`); no level rule on SVS maps.
- Marriage team: exactly 2 members and the partner is a member (`isMarryTeam` `:688`).
- `memeberGradesValid(level)` helper for content that requires every member above a level (`:640`).
- Online state is from `online_state`; offline members stay in the team (Assumption: the team survives logout, members are shown offline).
- Pet quality display: `petQuqlity < 26 ? (q-1)/5+1 : (q-1)/5` (`FreedomTeamManager.as:542`).
- Blacklisted inviters are ignored client side; the server should also drop invites from players on the target's blacklist.
- `refuseTeamInvite` state is also sent at login inside player data (Assumption, field in `PlayerMsg`, account feature).
- Team chat: see [../chat/channels.md](../chat/channels.md).

## 6. Templates

None.

## 7. Persistent state

Teams are runtime objects; persistence is only needed for crash recovery and the refuse setting.

```sql
CREATE SCHEMA IF NOT EXISTS team;

CREATE TABLE team.team (
    team_id       serial      PRIMARY KEY,
    captain_id    integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    created_at    timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE team.member (
    player_id     integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    team_id       integer     NOT NULL REFERENCES team.team(team_id) ON DELETE CASCADE,
    slot          smallint    NOT NULL CHECK (slot BETWEEN 0 AND 3),  -- memberId order
    fight_pos     smallint,                                           -- see fight-positions.md
    away          boolean     NOT NULL DEFAULT false,                 -- hasLeftForNow
    joined_at     timestamptz NOT NULL DEFAULT now(),
    UNIQUE (team_id, slot)
);

CREATE TABLE team.player_setting (
    player_id            integer PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    refuse_team_invite   boolean NOT NULL DEFAULT false
);
```

Pending invitations are kept in memory with a timeout (Assumption: 60 s).

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8738 / 25138 | `team::freedom_team::handle_invite` |
| 8734 / 25135 | `team::freedom_team::handle_answer_invite` |
| 8736 / 25136 | `team::freedom_team::handle_change_captain` |
| 8739 / 25139 | `team::freedom_team::handle_kick` |
| 8741 / 25140 | `team::freedom_team::handle_quit` |
| 8740 | `team::freedom_team::handle_leave_for_now` |
| 8746 | `team::freedom_team::handle_toggle_refuse` |

- Invite validation: actor online and not in a blocking scene; target online; target `refuse_team_invite` false; actor not on target's blacklist; levels >= 36 (local); actor has no team or is captain of a non full team; target has no team. Store the pending invite (inviter, target, team id) and push 4620.
- Answer: pending invite exists; on accept re-check capacity and that the target has no team; create or extend the team in one transaction; push 4622 (new team) or 4626 to all members; on reject delete the pending invite and notify the inviter (111).
- Captain change, kick: actor is captain, target is a member. Quit: remove member; if the captain leaves, the next slot becomes captain (4627, Assumption); if one member remains, dismiss (4625).
- Position sync: the map movement code calls `team::freedom_team::on_member_changed(player)` to push 4624 to the other members (throttle to 1 per second per member).
- On logout: keep membership, push 4624 with `online_state = false`. Assumption: after 30 minutes offline the member is removed.
- Cross variants: same logic keyed by (server name, user id); route through the cross server gateway.

## 9. Open questions and assumptions

1. No client code shows an explicit dismiss request; dismissal happens through quit/kick (Assumption).
2. AFK (8740) has no caller; implement as a flag only.
3. The resource bar team button visibility rule is not mapped (resource bar feature).
4. Server error feedback uses 111 alerts (Assumption).

## 10. Implementation checklist

- [ ] Invite from PlayerMenu, chat menu, IM, invite frame (8738) with level 36 rule
- [ ] Invitation popup and answer (4620, 8734)
- [ ] Team creation push 4622 and add member push 4626
- [ ] Member info sync 4624 on movement, map change, online change
- [ ] Change captain (8736/4627), kick (8739/4630), quit (8741/4629), dismiss 4625
- [ ] Refuse invitations toggle (8746/4635)
- [ ] Cross server opcodes 25135 to 25140 on SVS maps
- [ ] Tables `team.team`, `team.member`, `team.player_setting`
- [ ] Test: full team of 4 rejects a fifth member
- [ ] Test: blacklisted inviter is ignored
