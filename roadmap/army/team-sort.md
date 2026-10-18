# Room team order (Formação dos Soldados)

Path aliases:

| Alias | File |
|---|---|
| ASSM | `decompiled/m5/scripts/army/net/ArmySocketSendManager.as` |
| TM | `decompiled/m5/scripts/teammanager/` |
| RSOM | `decompiled/core_module/scripts/managers/RoomSocketOutManager.as` |
| RM | `decompiled/core_module/scripts/managers/RoomManager.as` |
| GS | `decompiled/core_module/scripts/mvc/module/groupfb/GroupfbSender.as` |

Detailed screen geometry and mapping tables: `docs/battle/formation.md` §7.14 (rooms), §7.15 (Batalha de Vênus), §7.16 (Missão de equipe).

## 1. Overview

In multiplayer rooms the leader orders the players' heroes on the grid. The package `teammanager` contains three frames, all titled "Formação dos Soldados". The room features own the rooms; this module owns the position protocol.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `teammanager.TeamSortFrame` + `TeamSortItem`, `TeamSortCell`, `PawnSortCell` | "Formação dos Soldados" | 4 rows, front/back per row; only the room owner edits; blocked if a player is in combat ("Jogador está em combate") | PvE/PvP room right view, glory game room, campaign army manage frame (`docs/battle/formation.md` §7.14) | `RoomInfo.armyFightPos` |
| `teammanager.MatelordsSortFrame` + `MatelordsTeamSortCell` | "Formação dos Soldados" | 4 slots `[3,1,9,7]`, hero and own Guardian move together; only the leader | Batalha de Vênus room | same |
| `teammanager.GroupSortFrame` + `GroupSortCell` | "Formação dos Soldados" | 2 teams x 8 cells `SERVER_POS_LIST = [3,1,6,4,9,7,12,10]`; only the captain; one player per row | Missão de equipe (Groupfb) | `GroupfbRoomInfo` team lists |

## 3. Routes (client to server)

### R1. Request room positions
- Client path: `RSOM.sendRequestTeamPos` (RSOM:55-59) or cross-server `RSOM.sendRequestCrossTeamPos(serverName)` (RSOM:61-67).
- Route: send 8278 (0x2056) `C_CAMPIAGN_ARMYPOS_REQ` (no body) or 25159 (0x6247) `CR_FIGHTPOS_REQ` with `RoomReqMsg.serverName`.
- Response: 4186 (S1).

### R2. Save room positions (TeamSortFrame, MatelordsSortFrame)
- Client path: `ASSM.sendEditTeamPos(list, serverName)` (ASSM:19-44); cross rooms (`roomInfo.isCross`) use 25160.
- Route: send 8277 (0x2055) `C_CAMPIAGN_ARMYPOS_EDIT` or 25160 (0x6248) `CR_FIGHTPOS_EDIT`. Request `ArmyFightPosEditListMsg` (army): `armyFightPos` (#1, `ArmyFightPosEditMsg`, repeated) each with `user_id` (#1, INT32), `hero_pos` (#2, INT32, grid cell 1..12), `serverName` (#4, STRING); `pawn_pos` (#3) unset; `serverName` (#2, STRING) of the list.
- Client checks: owner/leader only (`TM/TeamSortFrame.as`, `TM/MatelordsSortFrame.as`), no player in combat.
- Response: 4186 broadcast to all room members.

### R3. Save team positions (GroupSortFrame)
- Client path: on close `GS.editPos()` (GS:161-178).
- Route: send 8972 (0x230c) `C_TEAM_CAMPAIGN_OP`, `MarriageOpMsg` (marriage package): `op_type` (#2, INT32) = 12; `properties` (#10, `PropertyListMsg`, repeated) with `property1` (#1, INT32) user id and `property2` (#2, INT32) cell; other fields unset.
- Response: 4786 `U_C_TEAM_CAMPAIGN_PLAYER_STATE` (S2), owned by [../team/README.md](../team/README.md).

## 4. Server messages (server to client)

### S1. 4186 (0x105a) `U_C_CAMPAIGN_ARMYPOS_SEND`
- `ArmyFightPosEditListMsg` (fields above). Receiver `RM.__requestTeamPosHandler` (RM:198-204) → `RoomInfo.armyFightPos`, event `UPDATE_TEAM_FIGHT_POS`.
- When: response to 8278/25159 and broadcast after 8277/25160 to every room member.

### S2. 4786 (0x12b2) `U_C_TEAM_CAMPAIGN_PLAYER_STATE`
- `TeamRoomMsg.infos[].fightPos` and `.team` (`decompiled/core_module/scripts/managers/GroupfbManager.as:63`, `:179-240`); see [../team/README.md](../team/README.md).

## 5. Rules and formulas

- TeamSortFrame mapping: row r (1..4) front = `3r - 2`, back = `3r`; reading `heroPos % 3 == 0 ? heroPos / 3 : (heroPos + 2) / 3`.
- Matelords: hero and child in the same row, columns 1↔3 and 7↔9.
- Groupfb: visual index i → row `int(i / 2)`, column `i % 2`.
- Server must reject duplicates and cells outside the mode's set.

## 6. Templates

None.

## 7. Persistent state

Room positions are transient (room lifetime). Optional table if rooms are persisted:

```sql
CREATE TABLE army.room_positions (
    room_id     BIGINT  NOT NULL,
    player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    hero_pos    SMALLINT NOT NULL CHECK (hero_pos BETWEEN 1 AND 12),
    team_index  SMALLINT NOT NULL DEFAULT 1,
    PRIMARY KEY (room_id, player_id),
    UNIQUE (room_id, team_index, hero_pos)
);
```

*(assumption: in-memory room state is enough; the table is only needed for crash recovery)*

## 8. Backend implementation notes

- `army::team_sort::handle_request_positions` (8278, 25159): reply 4186 with the room's list.
- `army::team_sort::handle_edit_positions` (8277, 25160): sender is owner/leader; all user ids are members; unique valid cells; store; broadcast 4186 to members.
- 8972 op 12 is handled by `team::...` (team feature) and calls into the same validation.
- Battle configuration: room battles place each hero at `hero_pos` (battle types in `docs/battle/formation.md` §7.14-7.16).

## 9. Open questions and assumptions

- Assumption: positions are in-memory per room.
- Open: cross-server routing of 25159/25160 (cross-server feature).

## 10. Implementation checklist

- [ ] Screens: TeamSortFrame, MatelordsSortFrame, GroupSortFrame
- [ ] Route 8278/25159 request
- [ ] Route 8277/25160 save
- [ ] Route 8972 op 12 (with team feature)
- [ ] Server message 4186 broadcast
- [ ] Server message 4786 (team feature)
- [ ] Rule: per-mode cell sets and uniqueness
- [ ] Test: owner reorders, members receive 4186
