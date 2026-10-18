# Equipe e missões de equipe (team)

Feature slug `team`, domain social. Client packages: `team` (core `mvc/module/team/FreedomTeamModel`, `yishi/actions/team/FreedomTeamApplyAction`, `managers/FreedomTeamManager`, `managers/FreedomTeamSocketOutManager`; views in `decompiled/m3/scripts/map/internals/view/team`) and `groupfb` (team missions: `decompiled/m9/scripts/groupfb`, `managers/GroupfbManager`, `mvc/module/groupfb/GroupfbSender`). Protobuf package `team` (12 messages) plus `room.TeamRoomMsg`, `room.TeamRoomListMsg`, `room.TeamPlayerMsg`, `room.MatchStateMsg`, `simple.PropertyMsg` and `marriage.MarriageOpMsg` reused as transport.

## What it does for the player

- "Equipe" (free team, `FreedomTeam`): up to 4 players form a team on the world map (space scene) to move together, chat on the team channel, enter multiplayer content and to satisfy marriage NPC requirements (propose, wedding quality, heart test need a 2 player team). Invite from any player menu, chat name menu, IM window or the team invite frame; the invitee gets "{0} Convidou você para formar equipe!". Players can also ask to join someone's team ("pedido de solicitação"), the captain sees the requests list. Captain can change captain ("Capitão"), kick ("Expulsar", "Deseja expulsar da equipe?"), open "Formação dos Soldados" to order the fight positions; anyone can leave ("Sair da Equipe", "Deseja sair da equipe?").
- Settings toggle to refuse team invitations.
- "Missão de equipe" (team mission, groupfb): rooms for a two side cooperative campaign ("Ruínas de Narendra"), list, search by number, quick join, create, password, ready state, side change, kick, change master, use reward chances ("Usar chances de ganhos"), start ("Depois da campanha iniciar os dois parceiros não podem trocar de membros"). Daily attempts `teamCount / teamMaxCount`. Opening hours `team_campaign_time = 19:00,23:00`.

## Entry points

| Entry | Code | Condition |
|---|---|---|
| Resource bar team button (`ResourceExtraView._teamBtn`) | `ResourceExtraView.__onTeamClick` `decompiled/core_module/scripts/ui/resourcebar/view/ResourceExtraView.as:158` creates `core.FreedomTeamManageFrame` | visible with a team (Assumption) |
| Team side panel on the map | `FreedomTeamListView` `decompiled/m3/scripts/map/internals/view/team/FreedomTeamListView.as` (member rows open `PlayerMenu`, `list/FreedomTeamListItemView.as:90`) | shown in space scene and some campaign maps (`FreedomTeamManager.showTeam` `decompiled/core_module/scripts/managers/FreedomTeamManager.as:697`) |
| "Convidar para a Equipe" in `PlayerMenu` | `PlayerMenu.__inviteHandler` `decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as:542` | `canInviteMember`: both levels >= 36 |
| Join request in `PlayerMenu` / chat menu | `PlayerMenu.__applyJoinHandler` `:553`, `ChatItemMenu` `decompiled/core_module/scripts/chat/view/ChatItemMenu.as:564` | |
| Main toolbar join requests button | `MainToolBar.__applyJoinTeamHandler` `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:981` opens friends controller frame type 7 (`core.JoinTeamFrame`) | requests pending |
| Team mission room list | `groupfb.GroupfbRoomListFrame` (controller `GroupfbController`, openType 1) | Open question: no opener found in this client |

## Modules

| Module | File | Scope |
|---|---|---|
| Free team | [freedom-team.md](freedom-team.md) | invite, answer, create on accept, member info pushes, captain change, kick, quit, dismiss, AFK, refuse setting, cross server (`CR_*`) variants |
| Join requests | [join-requests.md](join-requests.md) | ask to join (8807), requests list (4697), accept/reject/all (8808) |
| Fight positions | [fight-positions.md](fight-positions.md) | "Formação dos Soldados" (8737/25137, 4628) |
| Team missions | [team-missions.md](team-missions.md) | groupfb rooms (8972 ops 1 to 17), room list and state pushes (4784, 4785, 4786, 4791), map attack pushes (4790, 4792) |

## Dependencies

- [../friends/README.md](../friends/README.md): invite and join request entry points (PlayerMenu, IM, join requests frame under the friends controller), friend and guild lists in the invite frame, blacklist check on incoming invitations.
- [../chat/channels.md](../chat/channels.md): team channel 6 recipients come from the team; group team channel 14 from groupfb.
- [../marriage/README.md](../marriage/README.md): propose, wedding quality and heart test require a 2 member team with the captain acting.
- World map and campaigns (`docs/world/maps.md`), multiplayer rooms (room feature: invite hall 5027), world boss and SVS (cross team ops are used when `WorldBossHelper.checkSvs(mapId)`), Brave Legend team (blocks free team actions).
- [../hero/README.md](../hero/README.md) for the member snapshot fields.

## Suggested implementation order

1. [freedom-team.md](freedom-team.md) local server: invite, accept, create, info pushes, leave, kick, captain.
2. Team chat routing (chat feature) and map display.
3. [fight-positions.md](fight-positions.md).
4. [join-requests.md](join-requests.md).
5. Cross server variants.
6. [team-missions.md](team-missions.md) with the groupfb campaign.
