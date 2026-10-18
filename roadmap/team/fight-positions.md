# Team fight positions (Formação dos Soldados)

Feature `team`, module `fight-positions`. Ordering the team members on the battle grid.

Conventions as in [freedom-team.md](freedom-team.md).

## 1. Overview

When the sort frame opens the client asks for the current layout (8737 with `is_get = true`). The captain drags member heroes between grid cells; each drop sends the full layout (8737 with `is_get = false` and one `MemberFightPos` per placed member). The server stores it and pushes 4628 to all members. Members that are in battle (`state == 2`) cannot be moved ("Jogador está em combate, não é possível ajustar"). The layout is used when the team enters multiplayer battles (positions of each member's hero on the shared grid, see `docs/battle/formation.md`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `team.FreedomTeamSortFrame` `decompiled/m3/scripts/map/internals/view/team/FreedomTeamSortFrame.as` | "Formação dos Soldados" (`teammanager.pve.TeamSortFrame.title`) | 3 x 4 grid; 8 usable cells (`_legitPosList = [0,2,3,5,6,8,9,11]`, position values `_posList = [3,2,1,6,5,4,9,8,7,12,11,10]`, `:60`); drag enabled only for the captain (`:67`, `:93`) | `FreedomTeamManageFrame` "Formação dos Soldados" / "Ver Formação" (`FreedomTeamManageFrame.as:189`, controller `freedomteam` `OPEN_SORTFRAME`) | `FreedomTeamModel.memberFightPos` and member heroes |
| `sort/FreedomTeamSortCell` `decompiled/m3/scripts/map/internals/view/team/sort/FreedomTeamSortCell.as` | tip "Jogador está em combate, não é possível ajustar" (`teammanager.pve.command01`) | One cell, drag and drop swap (`onDragStop` `:366`) | frame | hero head, level |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| P1 | Frame opens | `FreedomTeamSortFrame` constructor `FreedomTeamSortFrame.as:46` then `FreedomTeamSocketOutManager.sendEditTeamFightPos()` `decompiled/core_module/scripts/managers/FreedomTeamSocketOutManager.as:66` | none (the client always uses the local opcode here) | C>S 8737 0x2221 `C_EDIT_TEAM_FIGHT_POS` | `MemberFightPosListMsg`: `is_get (#1, BOOL)` = true; `memberPos (#2, MemberFightPos, repeated)` empty; `serverName (#3, STRING)` unset | 4628 to the requester |
| P2 | Drop a hero on another cell | `FreedomTeamSortCell.onDragStop` `:366` dispatches `EDIT_TEAM_FIGHT_POS`, `FreedomTeamSortFrame.__editTeamFightPos` `:157` | captain only (drag disabled otherwise); neither member in battle (`state == 2`) | C>S 8737 | `is_get` = false; `memberPos`: per placed member `MemberFightPos`: `member_id (#1, INT32)` user id, `pos (#2, INT32)` grid position (1, 3, 4, 6, 7, 9, 10, 12), `serverName (#3, STRING)` unset | 4628 to all members |
| P2x | Same through `FreedomTeamManager.editTeamFightPos` on SVS maps | `FreedomTeamManager.editTeamFightPos` `decompiled/core_module/scripts/managers/FreedomTeamManager.as:274` then `sendEditTeamFightPosCross` `FreedomTeamSocketOutManager.as:161` | | C>S 25137 0x6231 `CR_EDIT_TEAM_FIGHT_POS` | as P2 plus `MemberFightPos.serverName` per member and `MemberFightPosListMsg.serverName` = own server | 4628 |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When |
|---|---|---|---|
| S>C 4628 0x1214 `U_C_TEAM_FIGHT_POS_CHANGE` | `MemberFightPosListMsg`: `is_get (#1, BOOL)` echo; `memberPos (#2, MemberFightPos, repeated)`: `member_id (#1, INT32)`, `pos (#2, INT32)`, `serverName (#3, STRING)`; `serverName (#3, STRING)` | `FreedomTeamManager.__teamFightPosChangeHandler` `FreedomTeamManager.as:410` (stores `memberFightPos`, `TEAM_INFO_UPDATE`) | response to P1 (requester only), push to all members after P2, and after membership changes (Assumption) |

## 5. Rules and formulas

- Valid positions: {1, 3, 4, 6, 7, 9, 10, 12} (grid numbering from `_posList`); at most one member per position; every member must have a position (Assumption: server assigns defaults 3, 6, 9, 12 in join order when a member joins).
- Only the captain may change the layout; the server must re-check.
- Members in battle cannot be moved (client); server should reject changes affecting members currently in a battle.

## 6. Templates

None.

## 7. Persistent state

`team.member.fight_pos` ([freedom-team.md](freedom-team.md)) with a partial unique index:

```sql
CREATE UNIQUE INDEX member_fight_pos_uq ON team.member (team_id, fight_pos) WHERE fight_pos IS NOT NULL;
ALTER TABLE team.member ADD CONSTRAINT member_fight_pos_ck CHECK (fight_pos IS NULL OR fight_pos IN (1, 3, 4, 6, 7, 9, 10, 12));
```

## 8. Backend implementation notes

- `team::fight_positions::handle_edit` (8737) and `handle_edit_cross` (25137): if `is_get`, reply 4628 with the stored layout. Else validate: actor in a team and captain; the list contains only members, distinct positions in the valid set, no member in battle; update `team.member.fight_pos` for all members in one transaction; push 4628 to all members.
- Battle setup for team content reads `team.member.fight_pos` to place each member's hero (see `docs/battle/server-engine.md`).

## 9. Open questions and assumptions

1. Default positions for new members (Assumption above).
2. Whether non captains can open the frame read only: yes, drag is disabled but P1 is sent.

## 10. Implementation checklist

- [ ] P1 get layout reply 4628
- [ ] P2 captain edit, validation, push to all members
- [ ] Cross variant 25137
- [ ] Default positions on join and cleanup on leave
- [ ] Test: non captain edit rejected, duplicate position rejected
