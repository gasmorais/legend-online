# Athena battle: team, inspiration and matches

Module `athena_battle::team`. Prefixes as in [README.md](README.md). None of the pushes below is received by this client build (see the README).

## 1. Overview

A team has a leader (`isMaster`), up to 4 members and 3 groups (`groupId` 1..3). The leader drags members between groups (op 11) and kicks members (op 5); anyone can leave (op 4, also on frame close). A countdown `leftTime` runs to the next turn; in the last 60 s the team can buy inspiration for a group (op 10, `Brave_Inspire` = 200 diamonds, limited by `maxInspireCount`) and change the inspiration type of a group (op 12: life 9010, damage 9020, fury 9030). At each turn the server matches teams and runs battle 3861 `CROSS_BRAVE_BATTLE`: three group battles, the team with 2 group wins wins. After the battle the client reopens the Team frame.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `braveleg.BraveLegTeamFrame` (720x515) | Batalha de Athena | 4 member slots, 3x3 group grid, remaining turns "{0}/{1}", inspirations "Número de inspirações restantes: {0}/{1}", countdown, warning "Quando o número de membros ≥ 2...", buttons formation and invite; close asks `braveleg.Dialog.quit` "Deseja sair da equipe atual?" then op 4 | presumed 378 `__teamInfoHandler` (tab 1) (`CM/yishi/manager/BraveLegManager.as:254-268`); after battle 3861 | `teamInfo` (`M11/braveleg/BraveLegTeamFrame.as:253-445`) |
| `braveleg.team.BraveLegTeammateItem` | | member card: "Nome：", "Profissãos：", "Ponto：", "Poder：", kick button for the leader (`braveleg.Dialog.kick` "Deseja expulsar {0}?") | team frame | `M11/braveleg/team/BraveLegTeammateItem.as:168-272` |
| `braveleg.team.BraveLegTeammateGroupItem` | | group slot, drag and drop between groups (leader) | team frame | `M11/braveleg/team/BraveLegTeammateGroupItem.as:122-170` |
| `braveleg.team.BraveLegGroupInspireView` / `BraveLegGroupInspireItem` | | per group: inspiration skill icon and level (`grades - 1`), button enabled in the last 60 s (tip `braveleg.Tip.inspireCD` "1 min antes da batalha poderá efetuar inspiração..."), click opens the type selector | team frame | `InspireTeamInfoMsg` (`M11/braveleg/team/BraveLegGroupInspireView.as:50-70`; `M11/braveleg/team/BraveLegGroupInspireItem.as:123-218`) |
| `braveleg.team.BraveLegSkillSelectView` | | choose type 9010/9020/9030 for a group | inspire item icon | `M11/braveleg/team/BraveLegSkillSelectView.as:16,75-92` |
| `braveleg.BraveLegMatrixFrame` (350x195) | Alteração da Formação | hero and pawn positions | tab 4 from the team frame (`BraveLegTeamFrame.as:300-304`) | army positions; sends `ArmySocketOutManager.sendEditArmyPos` ([army](../army/README.md)) (`M11/braveleg/BraveLegMatrixFrame.as:160-176`) |

## 3. Routes (client to server)

9619 `C_BRAVELEG_CLIENT_OP`, `BraveLegListMsg` (fields in [signup.md](signup.md)).

| # | Action | UI control | Client sender | Client checks | Request | Presumed responses |
|---|---|---|---|---|---|---|
| T1 | Leave team | frame close + confirm | `BraveLegTeamFrame.conformQuit` -> `requestLeaveTeam` (`BraveLegTeamFrame.as:437-444`; `BraveLegManager.as:134-146`) | client drops its team model immediately | `{op:4}` | 378 to remaining members; leader passes to the next member (A) |
| T2 | Kick member | member kick button (leader) | `BraveLegTeammateItem` -> `requestKillTeammate(userId)` (`team/BraveLegTeammateItem.as:204-272`; `BraveLegManager.as:148-155`) | leader only; not after the event is over | `{op:5, userId}` | 378 to members; kicked player gets 379 (A) |
| T3 | Move member to a group | drag between group slots (leader) | `BraveLegTeammateGroupItem.onDragStop` -> `requestEditTeam(userId, groupId)` (`team/BraveLegTeammateGroupItem.as:158-170`; `BraveLegManager.as:199-207`) | target group differs | `{op:11, userId, groupId}` | 378 |
| T4 | Inspire group | inspire button | `BraveLegGroupInspireItem.__onClickBtnHandler` -> `conformInspire` -> `requestInspireTeam(groupId)` (`team/BraveLegGroupInspireItem.as:175-218`; `BraveLegManager.as:190-197`) | remaining count > 0 else `braveleg.Error.str07` "Número de inspirações insuficiente!"; next level exists else `str09` "Inspiração já atingiu o nível mais alto!"; diamonds >= `Brave_Inspire` else recharge; confirmation `braveleg.Dialog.inspire` "Deseja consumir {0} diamantes para inspirar o grupo?" | `{op:10, groupId}` | 383 to all members, diamond update |
| T5 | Change inspiration type | type selector | `BraveLegSkillSelectView.__mouseClickHandler` -> `requestChangeInspire(groupId, MasterType)` (`team/BraveLegSkillSelectView.as:81-92`; `BraveLegManager.as:209-217`) | different skill only | `{op:12, groupId, skillMasterType}` | 383 |
| T6 | Invite | invite button | op 9 then tab 3 | | see [signup.md](signup.md) | |
| T7 | Formation | formation button | tab 4 | | army module | |

## 4. Server messages (server to client), presumed mapping

| Opcode | Hex | PTT name | Body | Handler it would feed |
|---|---|---|---|---|
| 378 | 0x017A | `U_C_BRAVE_ENTER_RESULT` "进入勇者征程队伍后" | `BraveLegListMsg` | `__teamInfoHandler` (`BraveLegManager.as:254-268`, `resovleTeamInfo` `:466-503`): closes SignUp, sets `currentTurn`, `maxTurnCount`, `leftTime` (seconds), `info` = members (leader first, then userId desc; `isMaster` of self), opens tab 1 |
| 383 | 0x017F | `U_C_BRAVE_INSPIRERESULT` "鼓舞结果" | `InspireTeamInfoMsg` | `__teamInspireInfoHandler` (`:392-409`) |

`InspireTeamInfoMsg`: `groupType1` (#1), `groupType2` (#2), `groupType3` (#3) (INT32, skill MasterType 9010/9020/9030 per group, 0 = none), `groupGrade1` (#4), `groupGrade2` (#5), `groupGrade3` (#6) (INT32, skill grade; the UI shows `grade - 1` as level, so grade 1 = level 0), `inspireCount` (#7, INT32, used), `maxInspireCount` (#8, INT32).

Battle: battle type 3861; result sets `isCrossBraveBattle` and the space or castle scene reopens tab 1 (`CM/battle/handler/BattleResultHandler.as:410-413`; `decompiled/m3/scripts/map/space/SpaceSceneController.as:293-298`).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| T-R1 | 3 groups per team, a fight is won with 2 group wins | LANG `braveleg.SignUp.Desc` |
| T-R2 | Inspiration only in the last 60 s before a turn (`_timeCount <= 60`); effects reset at the end of the event | `BraveLegTeamFrame.as:272-298`; LANG `braveleg.Tip.inspire` |
| T-R3 | Inspiration cost `Brave_Inspire` = 200 diamonds per level; team limit `maxInspireCount` (A: server value) | config; `BraveLegGroupInspireItem.as:185-199` |
| T-R4 | Skills: 9010 "Salmo da Vida" (life +30%..+66%), 9020 "Determinação da Luta" (damage +20%..+65%), 9030 "Luz da Coragem" (fury limit +30..+75); grades 1..10 | `TPL/SkillTempInfos.xml` MasterType 9010/9020/9030 |
| T-R5 | Changing type keeps the grade (A) | |
| T-R6 | Per battle reward: chance of "lágrimas de Athena" by points (LANG `braveleg.SignUp.RewardTip`) (A: amount server side) | LANG |

## 6. Templates

`TPL/SkillTempInfos.xml` MasterType 9010/9020/9030 (`TemplateId`, `Grades`, `Icons`, `Description`); `TPL/ConfigInfos.xml` `Brave_Inspire`.

## 7. Persistent state

```sql
CREATE TABLE athena_battle.team (
  team_uid        uuid PRIMARY KEY,
  season_no       integer NOT NULL,
  round_no        smallint NOT NULL,
  leader_id       integer NOT NULL REFERENCES player.players(player_id),
  inspire_used    smallint NOT NULL DEFAULT 0,
  inspire_max     smallint NOT NULL,
  created_at      timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE athena_battle.team_member (
  team_uid        uuid NOT NULL REFERENCES athena_battle.team(team_uid) ON DELETE CASCADE,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  group_id        smallint NOT NULL CHECK (group_id BETWEEN 1 AND 3),
  joined_at       timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (team_uid, player_id)
);
CREATE UNIQUE INDEX ON athena_battle.team_member (player_id);

CREATE TABLE athena_battle.team_inspire (
  team_uid        uuid NOT NULL REFERENCES athena_battle.team(team_uid) ON DELETE CASCADE,
  group_id        smallint NOT NULL CHECK (group_id BETWEEN 1 AND 3),
  skill_master_type integer NOT NULL CHECK (skill_master_type IN (9010, 9020, 9030)),
  grade           smallint NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 10),
  PRIMARY KEY (team_uid, group_id)
);

CREATE TABLE athena_battle.match (
  match_id        bigserial PRIMARY KEY,
  season_no       integer NOT NULL,
  round_no        smallint NOT NULL,
  turn_no         smallint NOT NULL,
  team_a          uuid NOT NULL,
  team_b          uuid,
  group_wins_a    smallint NOT NULL DEFAULT 0,
  group_wins_b    smallint NOT NULL DEFAULT 0,
  winner_team     uuid,
  fought_at       timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- Handlers `athena_battle::team::handle_leave` (op 4), `handle_kick` (op 5), `handle_edit_group` (op 11), `handle_inspire` (op 10), `handle_change_inspire` (op 12). Validate membership, leader rights, not in battle, inspiration window (<= 60 s before the turn), counts and diamonds. Push 378 / 383 to every online member.
- Turn scheduler: teams with >= 2 members are paired; three group battles of type 3861 (each group's members vs the opponent group with the same id; an empty group loses by default, A); apply group inspiration skills as battle buffs; score per player; push 378 after each battle.

## 9. Open questions and assumptions

- (A) Composition rule when a team has 2 or 3 members for 3 groups.
- (A) `maxInspireCount` value.
- (A) Whether the 3 group battles run in parallel or in sequence.

## 10. Implementation checklist

- [ ] Restore listeners decision (blocking)
- [ ] Tables `team`, `team_member`, `team_inspire`, `match`
- [ ] Ops 4, 5, 10, 11, 12 and pushes 378, 383
- [ ] Turn scheduler and battle 3861 with three group fights
- [ ] Tests: kick by non leader, inspire outside the window, max grade, move to same group
