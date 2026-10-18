# Campo de Minas (land mine team game)

Feature [final-defense](README.md), module `land-mine`.

Path aliases:

| Alias | Path |
|---|---|
| `LMM` | `decompiled/core_module/scripts/yishi/manager/LandMineManager.as` |
| `LMMOD` | `decompiled/core_module/scripts/mvc/module/landmine/LandMineModel.as` |
| `LMC` | `decompiled/core_module/scripts/mvc/controler/LandMineController.as` |
| `LM` | `decompiled/m11/scripts/landmine/` |

## 1. Overview

- Help text: "1) Este é um evento multi-player de passagem de fases. Ao todo há cinco fases. O evento é ativado após o avanço de profissão. 2) Cada fase tem quatro posições de movimento com minas dispostas aleatoriamente. Um jogador que se mova para uma posição minada será eliminado do jogo, não se poderá mover mais. 3) Quando qualquer membro da equipe atinge a posição final, todos os membros da equipe obtêm prêmios. 4) Quando entra no jogo, é deduzida uma oportunidade obter prêmios. As oportunidades são resetadas às 0 horas. 5) Os prêmios são enviados por email."
- Board: start castle, 5 columns ("fases", `posX` 0..4) of 4 stones (`posY` 0..3), end castle. From the start the player may step on any stone of column 1, then only on the next column; after column 5 (`posX + 2 == 6`) only the end castle is enabled (`LM/LandMineView.as:943-960`).
- Mines per column from `land_mine_config` = `1,2,1,2,1` (assumption: number of mines in each column).
- Up to 4 players (the free team, `FreedomTeamManager`); only the captain can start; fewer than 4 asks "Este é um modo de jogo para quatro jogadores. A sua equipe atual não tem quatro pessoas. A dificuldade do desafio é bastante alta. Tem a certeza que deseja continuar?" (`LM/LandMineTeamFrame.as:207-233`).
- Reward: `land_mine_items` = `208055,75|2131521,45|212018,30|2030102,30` ("Pedra Requintada" x75, "Pedra de Refinação de Moda" x45, "Pedra dos Deuses" x30, "Bolsa de Ouro" x30) by mail when the team wins and the player still has a reward chance; `land_mine_max_reward_count` = 1 per day.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `LM/LandMineTeamFrame.as` | "Campo de Minas" | Team lobby: 4 member avatars, reward items, "{0}/{1}" chances, help, start | top toolbar `landmine` -> controller type 2 (`LMC:55-62`); sends op 4 on open (`:62-69`) and on team changes (`:189-193`) | `sapperDic`, `maxRewardCount - rewardCount` (`:296-300`), start enabled only for the captain or solo (`:302-310`) |
| `LM/LandMineTeamWaitView.as` | - | 10 s wait after start in a team | start (`LandMineTeamFrame.as:243-257`) | countdown |
| `LM/LandMineFrame.as`, `LM/LandMineView.as`, `LM/LandMineHeroView.as` | "Escolha posição para onde se mover e siga em direção à posição final!" | Full screen board with 4 heroes, stones, end castle, drag | 4882 op 0 opens controller type 1 (`LMM:77-103`) | positions and states of all sappers |
| `decompiled/m3/scripts/gamehall/view/GameHallRewardTipView.as` | - | Game hall reward tip | game hall | model rewards |

## 3. Routes (client to server)

All requests: send 5192 (0x1448) `C_LANDMINE_OP`, protobuf `PlayerOpMsg` (package `player`): `op` (#1, INT32); `index` (#6, INT32) for move; other fields unused.

### R1. Team info (op 4)

- UI: team frame open and team change (`LMM:220-226`).
- Response: 4882 `op = 4` with `sappers` (team members) and `reward_count`.

### R2. Enter game (op 0)

- UI: start (`LandMineTeamFrame.as:250-257`), captain only, 2 s throttle.
- Server: all team members (or solo) not in another activity; generate mines; deduct a reward chance per member (`reward_count += 1`, help item 4); move every member into the game.
- Response to every member: 4882 `op = 0` with all `sappers` (initial `pos_x = pos_y = -1`, `state = 0`) -> opens the board (`LMM:77-103`). Then 4882 `op = 5` with `reward_count` (top toolbar effect, `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1000-1012`).

### R3. Move (op 2)

- UI: click an enabled stone (`LM/LandMineView.as:848-861`); `index` = stone index in its column (0..3); the column is implied (`posX + 1`).
- Request: `op = 2`, `index`.
- Server: player alive; target column = current `pos_x + 1`; set `pos_x`, `pos_y = index`; `state = 1` when the stone has a mine (dead).
- Response to all members: 4882 `op = 2` with `user_id`, `pos_x`, `pos_y`, `state`. When all members are dead: 4882 `op = 3` with `isWin = false`.

### R4. Reach the end (op 3)

- UI: end castle button, enabled after column 5 (`LandMineView.as:852-855`).
- Request: `op = 3`.
- Response to all members: 4882 `op = 3`, `user_id` = winner, `isWin = true` -> win animation and "Parabéns, a sua equipe chegou à posição final! O jogo terminou, o prêmio será enviado por email." when the player still had earnings (`LandMineView.as:766-800`). Rewards by mail to members with a reward chance consumed in R2.

### R5. Leave (op 1)

- UI: HUD exit with confirm "ui.maintoolbar.MainToolBar.exitLandMine" (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1597-1598`, `:1815-1820`).
- Response: 4882 `op = 1`, `user_id`: for self the board closes and the player returns to the game hall scene when he has a hall team (`LMM:104-123`); others hide that hero.

## 4. Server messages (server to client)

### 4882 (0x1312) `U_C_LANDMINE_INFO`

- Message `LandMineMsg` (package `module`): `op` (#1, INT32); `user_id` (#2, INT32); `pos_x` (#3, INT32) column 0..4 or -1; `pos_y` (#4, INT32) stone 0..3 or -1; `state` (#5, INT32) 0 alive, 1 dead on a mine; `isWin` (#6, BOOL); `reward_count` (#7, INT32) chances used today; `sappers` (#8, MESSAGE `SapperMsg`, repeated).
- `SapperMsg`: `user_id` (#1), `nick_name` (#2), `arm` (#3), `cloth` (#4), `wing` (#5), `hat` (#6), `fashion_arm` (#7), `fashion_cloth` (#8) (STRING avatar parts), `hide` (#9, BOOL) hide fashion, `sex` (#10), `template_id` (#11), `job` (#12), `pos_x` (#13), `pos_y` (#14), `state` (#15) (INT32), `is_dragon_talker` (#16, BOOL), `battle_beastId` (#17, INT32).
- Receiver: `LMM.__landmineInfoHandler` (`LMM:68-185`).

| op | Meaning | Client reaction |
|---|---|---|
| 0 | enter | fill sappers, open board |
| 1 | leave | self: close, maybe back to game hall; other: hide |
| 2 | move | animate; self also updates own position and state |
| 3 | end | `winnerId`, `isWin`, end sequence |
| 4 | team info | fill sappers, `rewardCount` |
| 5 | reward count | `rewardCount`, toolbar effect |
| 6 | cancel | close the wait view (`LandMineTeamFrame.as:195-199`) |

## 5. Rules and formulas

- 5 columns x 4 stones; mines per column `land_mine_config` = `1,2,1,2,1` (assumption).
- Daily reward chances `land_mine_max_reward_count` = 1, consumed on entering; reset 00:00.
- Unlock: profession advanced (`vocationGrades > 0`) and `VersionSwitch.LANDMINE`.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `land_mine_items`, `land_mine_max_reward_count`, `land_mine_config` | read by `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:954-970` and `LMMOD:33-60` |

## 7. Persistent state

```sql
CREATE TABLE final_defense.land_mine_player (
  player_id            INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  day                  DATE        NOT NULL,
  reward_count         SMALLINT    NOT NULL DEFAULT 0 CHECK (reward_count >= 0)
);

CREATE TABLE final_defense.land_mine_game_log (
  game_id              BIGSERIAL   PRIMARY KEY,
  member_ids           INTEGER[]   NOT NULL,
  mines                SMALLINT[]  NOT NULL,
  winner_id            INTEGER,
  is_win               BOOLEAN     NOT NULL DEFAULT false,
  started_at           TIMESTAMPTZ NOT NULL DEFAULT now(),
  ended_at             TIMESTAMPTZ
);
```

The running game (positions, states, mine layout) lives in memory.

## 8. Backend implementation notes

- `final_defense::land_mine::handle_team` (op 4), `handle_enter` (op 0), `handle_move` (op 2), `handle_end` (op 3), `handle_leave` (op 1).
- Enter: validate captain, members online and not busy; roll mines per column; persist chance consumption for each member in one transaction; broadcast op 0 and op 5.
- Move/end/leave broadcasts go to every member of the game. A member leaving does not end the game unless none remain (assumption).
- End: rewards mailed only to members whose chance was consumed this game (`hasEarnings` text variant).
- Daily reset job for `reward_count`.

## 9. Open questions and assumptions

- Meaning of `land_mine_config`.
- Whether a dead player's step reveals mines to others.
- Server reply when a non captain sends op 0 (assumed ignored).
- When op 6 cancel is sent (assumed when a member declines or the team breaks during the 10 s wait).

## 10. Implementation checklist

- [ ] Screen: `LandMineTeamFrame`, wait view, board
- [ ] Route R1 op 4
- [ ] Route R2 op 0 enter (team broadcast)
- [ ] Route R3 op 2 move
- [ ] Route R4 op 3 end
- [ ] Route R5 op 1 leave
- [ ] Server message 4882 ops 0..6
- [ ] Tables `final_defense.land_mine_player`, `land_mine_game_log`
- [ ] Mail rewards on win
- [ ] Daily reset
- [ ] Test: stepping on a mine sets state 1 and blocks further moves
