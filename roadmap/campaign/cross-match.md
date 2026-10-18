# Cross-server PvE matchmaking

Module `cross-match` of [campaign](README.md). Lets a team room (or a solo owner) be matched with players of other servers for a normal multiplayer instance, accept the match, continue matching from inside the instance and vote to kick a member.

## 1. Overview

- The room owner presses the cross start button (`room.roomRight.crossPveStartBtn`). The client sends **5039** with `isCross = true` ([rooms.md](rooms.md) R13). The room goes to state 2 (matching, **25**); the right panel shows a running "mm:ss" timer (`M9/room/view/pve/RoomRightView.as:758-806`). The owner can cancel with **5037** `state 1`.
- When the matcher finds a slot, every candidate receives **4994** (`CrossMatchAlertFrame`, "Combinação sucedida", "Número de Chefões Restantes: {0}/{1}", 45 s). Each answers **25157** accept or refuse.
- Inside a cross instance that is not full, the owner sees "continue matching" and "cancel" buttons on the main bar, driven by **4995** and answered with **25156**.
- A member can be voted out: **4984** asks everybody, answers go back with **25152**.
- Cross invitations: an invitee of a cross room answers with **9557** instead of 5024 ([rooms.md](rooms.md) R9).
- Open window: ConfigInfos `Multi_Match` = "00:00,23:59". Room panel shows "Poder necessário inter-servidor: {0}" (`NeedFightPower`) and the tip "Apenas campanhas multiplayer pode-se efetuar combinação inter-servidor".

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RoomRightView` cross start button and matching timer (`M9/room/view/pve/RoomRightView.as:179, 224, 885-961, 758-806`) | tip "Apenas campanhas multiplayer pode-se efetuar combinação inter-servidor" | Start or cancel matching | room scene | `NeedFightPower`, elapsed time |
| `CrossMatchAlertFrame` (`M9/room/view/pve/CrossMatchAlertFrame.as`) | "Combinação sucedida" | Accept a found match | 4994 | campaign name, "Número de Chefões Restantes: {0}/{1}", 45 s countdown |
| Main bar cross buttons (`CM/ui/maintoolbar/MainToolBar.as:727-830`) | "continuar" / "cancelar" art (`mainToolBar.crossGoOnBtn`, `mainToolBar.crossCancelBtn`) | Keep matching inside an unfinished cross instance | in a cross instance, owner, fewer than 4 players, template `Types 0`, `Capacity 4`, `DungeonId 1` | elapsed timer in state 2 |
| `CrossCampaignKillOutFrame` (`M3/map/campaign/view/frame/CrossCampaignKillOutFrame.as`) | text from the server | Vote to kick a member | 4984 | `content` = request `password` field, 45 s countdown |

## 3. Routes (client to server)

| # | Action | Sender (file:line) | Client checks | Route | Request fields | Server response |
|---|---|---|---|---|---|---|
| X1 | Start cross matching | `RoomRightView._startClick` with `crossPveStartBtn` (:897-905) -> `RoomSocketOuterManager.sendStartCampaignScene(campaignId, 0, null, isNoGet, true)` (`M9/room/net/RoomSocketOuterManager.as:76-98`) | owner; 2 s anti flood (:898-905) plus the 3 s start anti flood; a campaign selected; daily count warning. Readiness is **not** required for the cross button *(the enable state comes from `allPlayerReader`, :846)* | C>S **5039 (0x13af) U_C_CAMPAIGN_ENTER** | `CampaignReqMsg`: `para_int2 (#2)` = campaign id, `para_bool1 (#7)` = gains flag, `isCross (#9, BOOL)` = true | **25** `{room_state 2}` to the room; later **4994** to the candidates |
| X2 | Cancel matching | `RoomRightView._cancelClick` (:1392-1408) -> `sendRoomState(1)` | owner, state 2 | C>S **5037 (0x13ad) U_C_ROOM_STATE** | `RoomReqMsg{state (#6) = 1}` | **25** `{room_state 1}` |
| X3 | Answer a found match | `CrossMatchAlertFrame.__confirmClick` / `__cancleClick` / timeout / close (`M9/room/view/pve/CrossMatchAlertFrame.as:96-135`) -> `RoomSocketOuterManager.sendCrossAlertResult(choice, campaignUid, roomId)` (:125-133) | 45 s countdown (`leftCount = 45`, :38) | C>S **25157 (0x6245) CR_MULTI_MATCH_CHOOSE** | `simple.PropertyMsg`: `param1 (#1, INT32)` 1 accept / 0 refuse; `param5 (#5, STRING)` = campaign uid from 4994; `param6 (#6, STRING)` = room id from 4994 | all accepted: **125** (`is_cross` true) to every matched player; else matching resumes (25 stays 2) *(assumption)* |
| X4 | Continue or stop matching from the instance | main bar `__onCrossBtnClickHandler` (`CM/ui/maintoolbar/MainToolBar.as:768-778`) -> `RoomSocketOutManager.sendCrossGoOn(state, userId, serverName)` (`CM/managers/RoomSocketOutManager.as:78-86`) | buttons visible only in the conditions of §2 | C>S **25156 (0x6244) CR_MULTICAMPAIGN_MATCH** | `RoomReqMsg`: `state (#6)` 1 continue / 0 cancel, `user_id (#5)`, `serverName (#15)` | **4995** with the new button state |
| X5 | Vote on a kick | `CrossCampaignKillOutFrame.__confirmClick` / `__cancleClick` / timeout / close (`M3/map/campaign/view/frame/CrossCampaignKillOutFrame.as:80-122`) -> `CampaignSocketOutManager.sendCrossCmapignKillOutSelect(choice, serverName)` (`CM/map/campaign/CampaignSocketOutManager.as:159-166`) | 45 s | C>S **25152 (0x6240) C_VOTEKILL_CHOOSE** | `RoomReqMsg`: `state (#6)` 1 agree / 0 refuse, `serverName (#15)` = voter server | majority -> the target receives **28**/**22** and leaves *(assumption)* |
| X6 | Accept a cross invitation | `InviteFrame` with `isCross` (`CM/yishi/view/frame/InviteFrame.as:147-160, 228-246`) -> `RoomSocketOutManager.sendInviteOther(roomId, isGet)` (:88-95) | | C>S **9557 (0x2555) C_CROSS_INVITE_CHOOSE** | `RoomReqMsg{room_id (#1), is_get (#14)}` | **12** or **125** depending on the room state |

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When | Client effect |
|---|---|---|---|---|
| **4994 (0x1382) U_C_MATCH_COMFIRE** | `simple.PropertyMsg`: `param1 (#1, INT32)` remaining bosses, `param2 (#2, INT32)` total bosses, `param4 (#4, STRING)` campaign name, `param5 (#5, STRING)` campaign uid, `param6 (#6, STRING)` room id | `RoomManager.__crossMatchComfirmHandler` (`CM/managers/RoomManager.as:117, 563-579`) | a match proposal | `CrossMatchAlertFrame` |
| **4995 (0x1383) U_C_CAMPAIGN_MATCHSTATE** | `simple.PropertyMsg{param1 (#1, INT32)}`: 0 button disabled, 1 "continue" enabled, 2 matching (cancel button and elapsed timer) | `MainToolBar.__updateCrossBtnHanlder` (`CM/ui/maintoolbar/MainToolBar.as:743, 760-766, 780-818`) | after 25156 and when the instance team changes | main bar cross buttons |
| **4984 (0x1378) U_C_VOTE_KILLPLAYER** | `room.RoomReqMsg`, only `password (#11, STRING)` is read (the vote text) | `RoomManager.__crossCampaingkillOutHandler` (:110, 553-561) | a member asked to kick another in a cross instance | `CrossCampaignKillOutFrame` |
| 25 | `RoomStateRspMsg{room_state}` | [rooms.md](rooms.md) | matching start/stop | timer and buttons |
| 121 | `ChangeMasterRspMsg{..., serverName (#3), isCross (#4)}` | [rooms.md](rooms.md) | owner change in cross rooms | keeps the owner server |
| 125 | `RoomCreatedMsg{..., is_cross (#3, BOOL) = true}` | [map-session.md](map-session.md) | match accepted | `RoomInfo.isCross`, `CampaignMapModel.isCross` (cross identity = player id + server name) |

`room.MatchStateMsg{match_state (#1, BOOL), param1 (#2, STRING), param2 (#3, STRING)}` is in this feature's proto package but is used only for PvP and vehicle start notifications (`CM/yishi/manager/BaseManager.as:1485-1493, 2832-2840`; `CM/managers/GroupfbManager.as:123-127`), owned by [../arena/README.md](../arena/README.md), [../artillery/README.md](../artillery/README.md) and [../team/README.md](../team/README.md).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Eligible instances | normal multiplayer campaigns (`Types 0`, `Capacity 4`, `DungeonId 1`) | `MainToolBar.as:736-739` |
| Power requirement | `Campaigns.NeedFightPower` per player (3,000 to 7,000,000) *(assumption: checked by the server on each candidate)* | `RoomRightView.as:697-703` |
| Opening hours | `Multi_Match` "00:00,23:59" | ConfigInfos |
| Answer timeout | 45 s for the match and the kick vote | `CrossMatchAlertFrame.as:38`, `CrossCampaignKillOutFrame.as:38` |
| Identity | in cross instances a player is (`player_id`, `server_name`) | `CampaignSocketManger.isSelf` (`M3/map/campaign/CampaignSocketManger.as:1977-1984`) |
| Battle type | 3848 `CROSS_MULTI_CAMPAIGN` *(assumption)* | `CM/yishi/datas/battle/BattleType.as:126` |

## 6. Templates

| File | Use |
|---|---|
| `Campaigns.xml` | `NeedFightPower`, `Capacity`, `DungeonId`, `Types` |
| `ConfigInfos.xml` | `Multi_Match` |

## 7. Persistent state (schema `campaign`)

Matching is a live queue. Persist only the audit of matches.

```sql
CREATE TABLE campaign.cross_match (
  match_uid    text     PRIMARY KEY,
  campaign_id  integer  NOT NULL,
  room_id      integer  NOT NULL,
  state        smallint NOT NULL DEFAULT 0 CHECK (state IN (0, 1, 2, 3)),
  created_at   timestamptz NOT NULL DEFAULT now(),
  resolved_at  timestamptz
);

CREATE TABLE campaign.cross_match_candidate (
  match_uid   text     NOT NULL REFERENCES campaign.cross_match(match_uid) ON DELETE CASCADE,
  server_name text     NOT NULL,
  player_id   integer  NOT NULL,
  answer      smallint CHECK (answer IN (0, 1)),
  answered_at timestamptz,
  PRIMARY KEY (match_uid, server_name, player_id)
);

CREATE TABLE campaign.kick_vote (
  instance_id  bigint  NOT NULL REFERENCES campaign.instance(instance_id) ON DELETE CASCADE,
  target_server_name text NOT NULL,
  target_player_id integer NOT NULL,
  voter_server_name text NOT NULL,
  voter_player_id  integer NOT NULL,
  agree        boolean,
  created_at   timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (instance_id, target_server_name, target_player_id, voter_server_name, voter_player_id)
);
```

`state`: 0 proposed, 1 accepted by all, 2 refused or timed out, 3 cancelled. `player_id` here is not a foreign key because candidates can belong to other servers.

## 8. Backend implementation notes

| Handler | Opcode | Validation order | Effects |
|---|---|---|---|
| `campaign::cross_match::handle_start` | 5039 with `isCross` | owner; eligible campaign; within `Multi_Match`; power of the room members | enqueue the room; room state 2; 25 to the room |
| `campaign::cross_match::handle_cancel` | 5037 `state 1` | owner; state 2 | dequeue; 25 `{1}` |
| `campaign::cross_match::tick` | timer | queue | group rooms and solo players up to 4 for the same campaign; create `cross_match`; send 4994 to every candidate |
| `campaign::cross_match::handle_choose` | 25157 | candidate of `param5` | store the answer; all accepted: create the cross instance (`is_cross` true) and send 125 to all; any refusal or timeout (45 s): requeue the others, 2 |
| `campaign::cross_match::handle_continue` | 25156 | owner of a cross instance with fewer than 4 players | `state 1`: requeue the instance (4995 `{2}`); `state 0`: stop (4995 `{1}`) |
| `campaign::cross_match::handle_kick_vote` | 25152 | member of the instance with an open vote | majority agrees: remove the target (22 to all) *(assumption)*; close the vote |
| `campaign::cross_match::handle_invite_choose` | 9557 | pending cross invitation | join |

- Cross-server transport is outside this feature; in a single server deployment the matcher can run locally with `server_name` = local name.
- Who sends 4984 is not visible (no client request opcode to start a vote) *(assumption: the server starts a vote when a member is idle or on owner request through 5031)*.

## 9. Open questions and assumptions

1. Rules of the kick vote (who starts it, majority size).
2. What happens to refused matches (requeue vs cancel).
3. Whether readiness was required for cross start (client enables the button with `allPlayerReader`).
4. The `param5`/`param6` of 4994 are strings in the client message; the server can use any unique token.

## 10. Implementation checklist

- [ ] Screens check: room cross button and timer, `CrossMatchAlertFrame`, main bar cross buttons, `CrossCampaignKillOutFrame`
- [ ] 5039 `isCross` -> queue + 25
- [ ] Matcher tick -> 4994
- [ ] 25157 answers -> 125 (`is_cross`)
- [ ] 25156 -> 4995
- [ ] 4984 / 25152 vote
- [ ] 9557 cross invite
- [ ] Tables `cross_match`, `cross_match_candidate`, `kick_vote`
- [ ] Test: two rooms of 2 players matched into one instance after both accept
