# Team join requests

Feature `team`, module `join-requests`. A player asks to join another player's team; the captain reviews the requests.

Conventions as in [freedom-team.md](freedom-team.md). Opcodes 8807 and 8808 are missing from `protocol/opcodes.csv`; names come from `decompiled/core_module/scripts/yishi/datas/consant/ProtocolType.as:922` and `:924`.

## 1. Overview

"Aplicar para a Equipe" (`chatII.view.ChatItemMenu.applyJoinBtn`) from the player menu or the chat name menu sends 8807 with the target user id. The server adds the requester to the request list of the target's team captain (or of the target if he has no team, Assumption) and pushes the whole current request list as 4697. The captain opens the requests frame (main toolbar button) and accepts or rejects one request, or accepts all / rejects all (8808). Accepting adds the requester to the team (4626 to all, 4622 when a new team is created).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `core.JoinTeamFrame` (`ToolJoinTeamFrame` `decompiled/m12/scripts/friends/view/ToolJoinTeamFrame.as`) | columns "Nome", "Ação"; row buttons "Concordar", "Ignorar"; "Concordar Todos", "Ignorar Todos"; reject all confirm "Deseja ignorar todos os pedidos de solicitação de todos os jogadores?" (`friends.view.ToolJoinTeamList.rejectAlert`) | Review requests | `MainToolBar.__applyJoinTeamHandler` `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:981` (friends controller frame type 7, `decompiled/core_module/scripts/mvc/controler/FriendControler.as`) | `FriendManager.applyJoinList` (user id, nickname, level) |
| `ToolJoinTeamList` / `ToolJoinTeamItem` `decompiled/m12/scripts/friends/view/ToolJoinTeamList.as`, `ToolJoinTeamItem.as` | row: name link, level, accept, reject | | frame | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| J1 | "Aplicar para a Equipe" in `PlayerMenu` / `ChatItemMenu` / old player return menu | `PlayerMenu.__applyJoinHandler` `decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as:553`, `ChatItemMenu` `decompiled/core_module/scripts/chat/view/ChatItemMenu.as:564`, `OldPlayerReturnHeadMenu` `decompiled/m11/scripts/oldplayerreturn/alliance/OldPlayerReturnHeadMenu.as:200` then `FreedomTeamManager.joinTeam` `decompiled/core_module/scripts/managers/FreedomTeamManager.as:298` then `sendJoinTeam` `decompiled/core_module/scripts/managers/FreedomTeamSocketOutManager.as:87` | `checkScene(true)` | C>S 8807 0x2267 `C_JOIN_TEAM_APPLY` | `JoinTeamReqMsg`: `tar_userId (#1, INT32)` target player | 4697 to the captain |
| J2 | Accept one | `ToolJoinTeamItem.__acceptBtnHandler` `ToolJoinTeamItem.as:101` then `FreedomTeamManager.joinTeamOp(0, userId)` `:306` then `sendJoinTeamReply` `FreedomTeamSocketOutManager.as:95` | `checkScene(true)` | C>S 8808 0x2268 `C_JOIN_TEAM_REPLY` | `JoinTeamResultMsg`: `opType (#2, INT32)` = 0; `apply_userId (#1, INT32)` = requester | 4622 or 4626; 4697 refreshed list |
| J3 | Reject one | `ToolJoinTeamItem.__rejectBtnHandler` `:106` | | C>S 8808 | `opType` = 1, `apply_userId` = requester | 4697 |
| J4 | Reject all | `ToolJoinTeamList.rejectCall` `ToolJoinTeamList.as:96` after confirmation | | C>S 8808 | `opType` = 2, `apply_userId` not sent (`FreedomTeamSocketOutManager.as:100`) | 4697 empty |
| J5 | Accept all | `ToolJoinTeamList.__onAcceptHandler` `:83` | | C>S 8808 | `opType` = 3, `apply_userId` unset (0) | team pushes, 4697 |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When |
|---|---|---|---|
| S>C 4697 0x1259 `U_C_JOIN_TEAM` | `JoinTeamResMsg`: `joinList (#1, JoinTeamUserMsg, repeated)`: `apply_userId (#1, INT32)`, `apply_nickName (#2, STRING)`, `apply_grade (#5, INT32)` (read); `apply_sex (#3, INT32)`, `trans_grade (#4, INT32)`, `apply_job (#6, INT32)` (unused) | `FriendManager.__joinTeamListHandler` `decompiled/core_module/scripts/yishi/manager/FriendManager.as:845` replaces `applyJoinList` and dispatches `REFRESH_JOINTEAMLIST` | after each new request, after each reply, at login if requests are pending (Assumption) |
| S>C 4622 / 4626 | `TeamInfoMsg` | see [freedom-team.md](freedom-team.md) | after acceptance |

## 5. Rules and formulas

- The full list is always sent (the client replaces it).
- Assumption: requests expire after 10 minutes and are dropped when the requester joins another team or the team becomes full (4 members).
- Accept all stops at team capacity; remaining requests stay (Assumption).
- Same level 36 rule as invitations (Assumption; the client does not check it for J1).

## 6. Templates

None.

## 7. Persistent state

Runtime only (requests are short lived). Optional table for crash recovery:

```sql
CREATE TABLE team.join_request (
    target_player_id  BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE, -- captain or target
    applicant_id      integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    created_at        timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (target_player_id, applicant_id)
);
```

## 8. Backend implementation notes

- `team::join_requests::handle_apply` (8807): requester online, no team, scene allowed; target online; resolve the receiving captain (target's team captain, or target); skip duplicates; push 4697 to the captain.
- `team::join_requests::handle_reply` (8808): actor is the captain (or the target without team); `opType` 0 accept one, 1 reject one, 2 reject all, 3 accept all; accept reuses `team::freedom_team` join logic in one transaction; push 4697 with the remaining list.

## 9. Open questions and assumptions

1. Who receives a request when the target has no team: Assumption the target, and acceptance creates a team with the target as captain.
2. The applicant is not notified of rejection in this client (no handler).

## 10. Implementation checklist

- [ ] 8807 apply and 4697 push
- [ ] 8808 ops 0, 1, 2, 3
- [ ] Join on accept with team pushes
- [ ] Toolbar requests button and frame list
- [ ] Test: accept all respects capacity 4
