# Fantasy matrix ("Formação Mágica")

Aliases:

| Alias | File |
|---|---|
| CSM | `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as` |
| CSOM | `decompiled/core_module/scripts/map/campaign/CampaignSocketOutManager.as` |
| CMC | `decompiled/m3/scripts/map/campaign/CampaignMapController.as` |
| FMM | `decompiled/core_module/scripts/map/campaign/data/FantasyMatrixModel.as` |
| FMN | `decompiled/core_module/scripts/map/campaign/data/FantasyMatrixNodeInfo.as` |
| FMD | `decompiled/m3/scripts/map/campaign/mediator/fantasymatrix/` (directory) |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

A team instance (campaign 9997 "Formação Mágica", map 9997, up to 4 players, levels 38 to 80, room hall). The map is replaced by an isometric grid of squares (`FantasyMatrixMapView`, `CMC:255-266`); each square holds a monster. Defeating a monster lights its square. Four connected lit squares are eliminated and score points; bigger groups and higher monster levels score more. Squares can carry a box or a skill pickup. The room owner can trigger three team skills. The run lasts 15 minutes; score thresholds give boxes (template 2131515) and EXP.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Room hall instance panel (`decompiled/m9/scripts/room/view/pve/instance/InstanceRightView.as:609-615`) | "Apenas poderá obter semanalmente uma chance de ganhos na Formação Mágica.", "{rest}/{max}" | Select the instance | room hall | `PlayerMsg.fantasyMatrixCampaignCount (#131)`, `fantasyMatrixCampaignMaxCount (#132)` (`PlayerManager.as:1089-1093`) |
| `FantasyMatrixMapView` / `FantasyMatrixWarView` (FMD) | | Grid: square at x = `(posX + posY) * 100 + 105`, y = `(posY - posX) * 50 + 405` (`FantasyMatrixWarView.as:50-51`) | map 9997 | `nodeArr` |
| `FantasyMatrixWarNodeView` | | Square: box icon when `show_box`, skill animation `show_skill` 1..3, lit animation when `state == 2`, monster avatar when `state != 0` (`FantasyMatrixWarNodeView.as:82-100`) | grid | node |
| `FantasyMatrixNpcAvatarView` | "Este monstro está em combate" | Click a monster to fight (`FantasyMatrixNpcAvatarView.as:300-312`) | node | `fighting` |
| `FantasyMatrixLeftView`, `FantasyMatrixLeftBoxItem` | score bar and threshold boxes | Score progress up to the last threshold; box marked when `score >= threshold` | HUD | `score`, `fantasy_matrix_score_reward` |
| `FantasyMatrixRightView` | countdown, help ("vehicle.helpFrame1.title" tooltip), skills | Timer runs only when `count_down_start` (`FantasyMatrixRightView.as:100-112`) | HUD | `left_time` |
| `FantasyMatrixSkillItem` | "Energia de Fogo", "Energia de Água", "Energia de Vento"; confirm "Deseja usar {0}?" | Use a skill | HUD | counts |

Help (`fantasyMatrix.helpFrame.content`): attacking the monster on a square lights it; connecting 4 lit squares eliminates them and gives points; each square is worth 100 points; eliminating more than 4 at once gives 25 extra points per extra square; each monster level adds 25 points to the square.

## 3. Routes (client to server)

C>S 8473 (0x2119) `C_FANTASY_MATRIX_REQUEST`, body `fantasymatirx.FantasyMatrixRequestMsg`: `op (#1, INT32)`, `pos_x (#2, INT32)`, `pos_y (#3, INT32)`, `skill_id (#4, INT32)`.

### R1. Fight a square monster (op 5)

- UI: click on a monster with a non transparent pixel (`FantasyMatrixNpcAvatarView.as:300-312`).
- Client checks: `fighting` false else "Este monstro está em combate".
- Sender: `CampaignSocketOutManager.sendFantasyMatrixFight(x, y)` (`CSOM:299-307`). Fields: `op` = 5, `pos_x`, `pos_y`.
- Response: 4449 with the node `fighting = true`, battle start (battleType 3862 `FANTASY_MATRIX_BATTLE`), after the battle 4449 (lit or eliminated squares, refills) and 4448 (score).

### R2. Use a team skill (op 6)

- UI: skill item use button (`FantasyMatrixSkillItem.as:63-105`).
- Client checks: caller is the room owner (`RoomManager.roomInfo.houseOwnerId`) else "Apenas o líder pode usar esta habilidade"; count >= 1 else "Número de habilidades insuficientes, não é possível usar"; confirm.
- Sender: `sendFantasyMatrixUseSkill(skillId)` (`CSOM:309-316`). Fields: `op` = 6, `skill_id` = 1, 2 or 3.
- Response: 4448 with the count decreased.

## 4. Server messages (server to client)

### S1. 4448 (0x1160) `U_C_FANTASY_MATRIX_MAIN`

Opcode shared in `opcodes.csv` with `U_C_ALTARNPC_MOVE`; the campaign socket manager reads it as `FantasyMatrixMainMsg` (`CSM:403`, `CSM:3068-3081`).

| Field | Tag, type | Meaning |
|---|---|---|
| `left_time` | #1 INT32 | seconds left |
| `score` | #2 INT32 | team score |
| `box_count` | #3 INT32 | boxes earned |
| `skill_attack_up` | #4 INT32 | skill 1 count |
| `skill_score_up` | #5 INT32 | skill 2 count |
| `skill_add_score` | #6 INT32 | skill 3 count |
| `count_down_start` | #7 BOOL | timer running |

When: on entry and after every change (score, skill, pickup).

### S2. 4449 (0x1161) `U_C_FANTASY_MATRIX_MAP`

`FantasyMatrixMapMsg`: `op (#1, INT32)`, `nodeList (#2, FantasyMatrixNodeMsg, repeated)`. Receiver `CSM:3083-3108`: upsert by (`pos_x`, `pos_y`); `op` is not read.

| Field | Tag, type | Meaning |
|---|---|---|
| `pos_x` | #1 INT32 | column |
| `pos_y` | #2 INT32 | row (`posId = x * 5 + y`, `FMN:29-32`, 5 x 5 grid assumption) |
| `pawn_level` | #3 INT32 | monster level |
| `pawn_temp_id` | #4 INT32 | monster template |
| `show_box` | #5 BOOL | box on the square |
| `show_skill` | #6 INT32 | skill pickup 1..3, 0 none |
| `fighting` | #7 BOOL | a member is fighting it |
| `state` | #8 INT32 | 0 empty, 2 lit, other values monster present (assumption: 1 normal) |
| `pawn_sontype` | #9 INT32 | monster son type |

When: full grid on entry, changed squares afterwards.

## 5. Rules and formulas

Config (`raw/xml/tempinfos/ConfigInfos.xml`):

| Key | Value | Meaning |
|---|---|---|
| `fantasy_matrix_box_temp_id` | 2131515 | box item (`FMM:6`, `CIM:527-530`) |
| `fantasy_matrix_score_reward` | `5000,7\|8000,7\|12000,7\|18000,7\|24000,7` | score threshold, boxes (assumption: 7 boxes, or box template count) |
| `fantasy_matrix_add_score` | `100,25,15` | base points per square, extra per square beyond 4, bonus per monster level (the help says 25 per level; config says 15) |
| `fantasy_matrix_campaign_time` | 15 | minutes |
| `fantasy_matrix_campaign_count` | 1 | runs (weekly per room text) |
| `fantasy_matrix_exp_reward` | `5000,3500000\|8000,8500000\|12000,13500000\|18000,18500000\|24000,30000000` | EXP by threshold |

- Score of an elimination of n >= 4 squares: `sum(100 + level_i * 15) + max(0, n - 4) * 25` (assumption combining help and config).
- Skills: 1 "Energia de Fogo": all members +100% damage for 1 minute; 2 "Energia de Água": all points +50% for 1 minute; 3 "Energia de Vento": +400 points immediately (`FantasyMatrixSkillItem.*.tipData`).
- Campaign row 9997: `Item="-700,2131515"` (reward preview), `EnterNumb` 1, `DungeonId` 3.
- Battle type 3862.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/Campaigns.xml` | 9997 |
| `raw/xml/tempinfos/MapInfos.xml` | 9997, 1600 x 1500 |
| `raw/xml/tempinfos/ConfigInfos.xml` | `fantasy_matrix_*` |
| monster templates | `pawn_temp_id` (server choice) |

## 7. Persistent state

```sql
CREATE TABLE cross_server.fantasy_matrix_weekly (
    player_id   bigint   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    week_start  date     NOT NULL,
    runs        smallint NOT NULL DEFAULT 0,
    best_score  integer  NOT NULL DEFAULT 0,
    PRIMARY KEY (player_id, week_start)
);
```

Grid state is in memory.

## 8. Backend implementation notes

- Instance creation by the room start (5039); generate the grid, push 4449 (full) and 4448.
- `cross_server::fantasy_matrix::handle_request` (8473): op 5: square exists, monster present, not fighting; set fighting, push 4449, start battle 3862 with the square monster; on victory mark lit (2), detect groups of >= 4 connected lit squares (4-neighbour), score, clear and refill squares, maybe drop box / skill; push 4449 and 4448. op 6: caller is room owner, count > 0; apply the effect; push 4448.
- Timer: 15 minutes from the first fight (`count_down_start`); at the end grant boxes and EXP by thresholds once per week (`runs`), exit the instance.

## 9. Open questions and assumptions

- Assumption: grid size 5 x 5, state values, score formula, meaning of the `,7` in score rewards.
- Open: `FantasyMatrixMapMsg.op` values, other request ops (1 to 4).

## 10. Implementation checklist

- [ ] Grid instance on map 9997.
- [ ] Route 8473 ops 5 and 6.
- [ ] Server messages 4448, 4449.
- [ ] Table `cross_server.fantasy_matrix_weekly`.
- [ ] Battle 3862 integration.
- [ ] Tests: skill by non owner refused; elimination of 5 level 1 squares scores 5 * 115 + 25 = 600.
