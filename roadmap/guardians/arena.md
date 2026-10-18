# Guardian arena ("Guardião Leida" / "Arena do Guardião")

Module `arena`. A daily cross server bracket tournament of guardian teams. Players sign up in one of two territories ("Território do Céu" or "Território da Terra"), the server groups them into brackets of 16, other players bet gold on a contestant, then rounds are fought automatically at fixed times (battleType 3847 `CHILD_ARENA_BATLE`) and rewards are collected. The guardian team (8 grid slots) is set in the common formation frame.

Path aliases:

| Alias | File |
|---|---|
| CS | `decompiled/core_module/scripts/mvc/module/children/ChildSender.as` |
| CM | `decompiled/core_module/scripts/managers/ChildManager.as` |
| AM | `decompiled/core_module/scripts/mvc/module/children/ChildArenaModel.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/ChildArenaController.as` |
| V | `decompiled/m14/scripts/childarena/` |
| OPE | `decompiled/core_module/scripts/com/road/yishi/proto/guardpvp/GuardPvpOp.as` |

Proto package `guardpvp` is registered under [arena](../arena/README.md) in `roadmap/features.json`, but its only client user is this guardian module.

## 1. Overview

- Send 9657 (0x25b9) `C_GUARDPVP_CLIENT_OP` and receive 453 (0x01c5) `U_C_GUARDPVP`, both `GuardPvpListMsg`.
- `guardPvpOp` (#1, ENUM `GuardPvpOp`): 0 OPEN_SIGNUP, 1 OPEN_FIGHT_TABLE, 2 SIGNUP, 3 SET_GUARD, 4 GET_REWARD, 5 NOTICE_REWARD, 6 STATUS, 7 BET, 8 CLOSE_FIGHT_TABLE, 9 AUTO_SIGN.
- States (`AM:13-27`): -1 init, 0 sign up, 1 grouping, 2 bet, 3 before fight, 4 fight, 5 reward, 6 finish. Schedule config `guard_pvp_gimes` = "19:01,23:59,01:00,18:00,19:00" (sign up start, grouping, bet, fight, end) (`AM:144-147`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from |
|---|---|---|---|
| `V/ChildArenaSignFrame.as` | "Guardião Leida", "Inscrição:{0}-{1}", "Tempo de competição:{0}-{1}" | sign up territory, auto sign up, open main frame | `AC` openType `SIGN_FRAME`: `SwitchPageHelp` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2215-2242`), top bar time box (`decompiled/core_module/scripts/ui/toptoolbar/view/TimeActiveBoxView.as:140`) |
| `V/ChildArenaMainFrame.as`, `V/ChildArenaLeftView.as`, `V/ChildArenaRightView.as`, `V/ChildArenaPlayerItem.as` ("Pendente"), `V/ChildArenaHeadItemView.as`, `V/ChildArenaRewardItem.as` | "Arena do Guardião", "Tempo de Aposta:{0}-{1}", "Tempo de Competição:{0}-{1}", "Prêmio do Rank" | bracket 16/8/4/2, bet, team heads, rewards | `AC` openType `MAIN_FRAME` (state 4 and signed) |
| `decompiled/m14/scripts/childformation/ChildCommonFormationFrame.as` | | set the 8 slot guardian team (`_formationType` 1) | `AC` openType `FORMATION_FRAME` |

Entry checks (`SwitchPageHelp.as:2215-2242`): hero level 70 ("Apenas jogadores com nv.70 podem participar"), at least one guardian, state 1 (grouping) blocks with "childpvp.enter.groupAlert".

## 3. Routes (client to server)

All: 9657 `GuardPvpListMsg` with the fields below (`CS:619-665`).

| op | UI | Fields | Client checks | Response |
|---|---|---|---|---|
| 0 | sign frame open (`V/ChildArenaSignFrame.as:75`) | | | 453 status (`isSign`, `status`, `teamType`, `autoTeamType`) |
| 1 | main frame open (`V/ChildArenaMainFrame.as:32`); auto when 453 op 6 says state 4 while inside (`CM:389-392`) | | | 453 `guardPvpOp` 1 with `info` (bracket) |
| 2 | sign up (`V/ChildArenaSignFrame.as:300-322`) | `teamType` (#10) = 1 Céu / 2 Terra | job changed ("{0} ativado após a tingir a profissão cavaleiro"), sign up window, confirm "Deseja participar de {0}\n (após confirmar, não poderá modificar mais no dia)" | 453 `isSign` true |
| 3 | save team (`decompiled/m14/scripts/childformation/ChildCommonFormationFrame.as:393`, `V/ChildArenaHeadItemView.as:162`) | `guardPos` (#13, repeated `GuardPvpPosMsg`: `param1` child id, `param2` attack pos, `param3` stand pos) | not during matching ("Durante a combinação de batalha, não é possível alterar guardião!") | 453 `guardPos` |
| 4 | collect reward (top bar `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1421`) | | `hasReward` ("Não há prêmios a coletar") | 453 `hasReward` false, bag 115 |
| 7 | bet (`V/ChildArenaRightView.as:120-148`) | `betWinCount` (#9) = chosen bracket position | bet state ("Tempo atual não poderá participar da aposta"), selection ("Favor selecioanr o nome a apostar"), confirm "Deseja consumir {0} ouro para apostar?" with `guard_pvp_bet_need_gold` 10000000 | 453 `betWinCount` |
| 8 | close bracket (`V/ChildArenaMainFrame.as:85`) | | | none |
| 9 | auto sign up (`V/ChildArenaSignFrame.as:210-260`) | `autoTeamType` (#11) = territory or 0 | VIP >= `GuardPvp_AutoSign_VipGrade` (4) ("Precisa de nível VIP 4...") | 453 `autoTeamType` |

## 4. Server messages (server to client)

### S1. 453 (0x01c5) `U_C_GUARDPVP`, `GuardPvpListMsg`
Receiver `CM.__childArenaBackHandler` (`CM:346-425`); only present fields are applied (`has*`).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `guardPvpOp` | #1 | ENUM | 1 = bracket list in `info`; else `guardPos` refresh; 6 = status push |
| `eventId` | #2 | INT32 | event instance |
| `uuid` | #3 | STRING | player cross id |
| `userId` | #4 | INT32 | |
| `serverId` | #5 | INT32 | |
| `isSign` | #6 | BOOL | signed up |
| `status` | #7 | INT32 | state (`AM:13-27`); 1 fires `CHILD_ARENA_ISGROUPING` |
| `nextFightTime` | #8 | STRING | "YYYY-MM-DD hh:mm:ss" |
| `betWinCount` | #9 | INT32 | own bet (`guessIndex`) |
| `teamType` | #10 | INT32 | territory |
| `autoTeamType` | #11 | INT32 | auto sign up territory |
| `info` | #12 | GuardPvpInfoMsg repeated | `uuid` #1, `userId` #2, `serverName` #3, `nickName` #4, `fightPower` #5, `winCount` #6, `teamType` #7, `teamIndex` #8, `teamPos` #9 (1..16 bracket seat), `crossServerId` #10, `signUpTime` #11 INT64 |
| `guardPos` | #13 | GuardPvpPosMsg repeated | team (`ChildCommonFormationInfo`: child, attack pos, stand pos) |
| `hasReward` | #14 | BOOL | reward to collect (top bar) |
| `currentTurn` | #15 | INT32 | round |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Schedule | sign up 19:01..23:59, grouping until 01:00, bet until 18:00, fights 18:00..19:00 *(assumption on reading of the 5 time nodes)* | `guard_pvp_gimes` |
| Bracket | 16 seats; winCount >= 1/2/3 builds the 8/4/2 columns | `AM.commitListData` (`AM:149-178`) |
| Bet | 10,000,000 gold, a correct bet doubles rewards ("Aposta sucedida, irá obter prêmios em dobro") | config, strings |
| Auto sign up | VIP 4 | config |
| Team | 8 grid slots `[1,4,7,10,3,6,9,12]`, guardians only | `formation.md` |
| Battle | 3847 with HurtUp mode (damage up over time), guardian units only | `docs/battle/rules.md` row 3847 |
| Cross server | contestants come from several servers (`serverName`, `crossServerId`) | proto |

## 6. Templates

`ConfigInfos.xml`: `guard_pvp_bet_need_gold`, `guard_pvp_gimes`, `GuardPvp_AutoSign_VipGrade`. Reward tables are not in the client templates *(assumption: server side)*.

## 7. Persistent state

```sql
CREATE TABLE guardians.arena_events (
  event_id     BIGSERIAL PRIMARY KEY,
  event_date   DATE     NOT NULL,
  team_type    SMALLINT NOT NULL CHECK (team_type IN (1,2)),
  state        SMALLINT NOT NULL DEFAULT 0,
  current_turn SMALLINT NOT NULL DEFAULT 0,
  UNIQUE (event_date, team_type)
);

CREATE TABLE guardians.arena_entries (
  event_id     BIGINT   NOT NULL REFERENCES guardians.arena_events(event_id) ON DELETE CASCADE,
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  team_index   SMALLINT,
  team_pos     SMALLINT CHECK (team_pos BETWEEN 1 AND 16),
  win_count    SMALLINT NOT NULL DEFAULT 0,
  fight_power  INTEGER  NOT NULL DEFAULT 0,
  signed_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  reward_claimed BOOLEAN NOT NULL DEFAULT FALSE,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE guardians.arena_bets (
  event_id     BIGINT   NOT NULL REFERENCES guardians.arena_events(event_id) ON DELETE CASCADE,
  player_id    BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  bet_pos      SMALLINT NOT NULL,
  gold         BIGINT   NOT NULL,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE guardians.arena_settings (
  player_id       BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  auto_team_type  SMALLINT NOT NULL DEFAULT 0
);
```

Team: `guardians.formations` mode `arena` (`formation.md`).

## 8. Backend implementation notes

Handlers `guardians::arena::handle_<action>`: `open_signup` (0), `open_fight_table` (1), `signup` (2), `set_guard` (3), `get_reward` (4), `bet` (7), `close_fight_table` (8), `auto_sign` (9).

- Scheduler per config time nodes: auto sign up, grouping into 16 seat brackets per territory, bet window, rounds (simulate battles 3847 server side with stored teams, increment `win_count`), rewards; push 453 op 6 status to online participants at each transition.
- Cross server: if multiple servers are not supported, run per server and keep the fields filled with local values *(assumption)*.

## 9. Open questions and assumptions

- *(assumption)* Exact meaning of the five schedule nodes and reward amounts.
- *(assumption)* Whether rounds are watched live (op 1 while state 4) or only simulated.

## 10. Implementation checklist

- [ ] 9657 ops 0..4, 7..9; push 453.
- [ ] Tables `guardians.arena_events`, `arena_entries`, `arena_bets`, `arena_settings`.
- [ ] Scheduler and battle 3847 simulation.
- [ ] Tests: sign up outside the window rejected; second sign up the same day rejected; bet without 10,000,000 gold rejected; auto sign up below VIP 4 rejected.
