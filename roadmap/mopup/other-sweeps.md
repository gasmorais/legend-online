# Other bots (expedition, lord trial, monster explore, increasingly road, Theseus tower)

Feature [mopup](README.md), module `other-sweeps`. Aliases in [README.md](README.md). Each section lists only the sweep routes; the rest of each protocol belongs to the owner feature.

## 1. Overview

| Activity | Owner | Style |
|---|---|---|
| Expedição automática (remote pet turns) | [einherjar](../einherjar/README.md) | timed job like the abyss (30 s per turn, poll 5 s) with frames 5/6 |
| Bot do Julgamento (lord trial) | [trials](../trials/README.md) | timed job (`lord_trial_sweep_templates` time per floor) with frames 9/10, costs gold and trial keys |
| Exploração de feras bot | [exploration](../exploration/README.md) | instant N sweeps of a cleared node |
| Caminho dos Deuses bot (increasingly road, "demon road" protocol) | [roads](../roads/README.md), proto `demonroad` in [trials](../trials/README.md) | instant single sweep of a layer |
| Torre de Teseu bot | [theseus](../theseus/README.md) | instant sweep of the highest cleared stage |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/RemoteMopupPrepareFrame.as` (5), `V/RemoteMopupIngFrame.as` (6) | "Expedição automática", "Bot  piso {0}" | Choose target turn; progress | `decompiled/m14/scripts/remotepet/views/RemotePetTurnInfoItemView.as:203`, `RemotePetTurnDownView.as:92`; in progress reopened when `RemotePetModel.mopupCount > 0` (`decompiled/core_module/scripts/mvc/module/remotepet/RemotePetModel.as:136-157`) | `turnInfo.maxTurn`, results |
| `V/LordTrialMopupPrepareFrame.as` (9), `V/LordTrialMopupIngFrame.as` (10) | "Bot do Julgamento", "Ao ativar o contrato do elfo poderá usar o modo bot gratuitamente" | Target floor, gold, keys | `decompiled/m11/scripts/lordtrial/LordTrialMainFrame.as:500`; in progress from `LordTrialModel.mopupCount` (`decompiled/core_module/scripts/mvc/module/lordtrial/LordTrialModel.as:57-79`) | `maxMopupIndex`, `currentIndex`, keys |
| `decompiled/m14/scripts/monsterexplore/MonsterSweepFrame.as` | "Aviso", "Vezes de Bots:", "(Bot já concluiu a última fase)" | Number of sweeps | node detail view, confirm "Deseja fazer Bot?...\n(Vezes de ganho restantes hoje: {0})" | remaining daily gains |
| `decompiled/m11/scripts/increasinglyroad/view/IncreasinglyroadLayerItemView.as` | "Quer consumir {0} de Movimento e usar 1 Bot?" | Layer bot button | increasingly road frame | movement energy |
| `decompiled/m11/scripts/thessTower/view/ThesstowerView.as` | "Bot só é permitido na Fase de maior progresso atual", "Vezes de ganhos insuficientes" | Bot button (`_pupBtn`) with `SweepRewards`, `SweepRandom` preview | Theseus tower view | stage rewards |

## 3. Routes (client to server)

### R1. Remote pet expedition: 9544 (0x2548) `C_REMOTE_PET_OP`, `RemotePetOpMsg`

Fields used: `op` (#1, INT32), `sweepIndex` (#9, INT32), `payType` (#11, INT32). Senders `decompiled/core_module/scripts/managers/RemotePetManager.as:82-98`.

| op | Meaning | Sender | Client checks |
|---|---|---|---|
| 7 | start, `sweepIndex` = target turn | `V/RemoteMopupPrepareFrame.as:160-200` | AAS state; target > 0; target >= current; target <= max ("Número de bot deve ser maior que 0." etc.) |
| 8 | accelerate, `payType` 1 diamonds / free, 0 bound first | `V/RemoteMopupIngFrame.as:341-385` | cost `ceil(remainSeconds / 60)` diamonds |
| 9 | stop | `V/RemoteMopupIngFrame.as:552` (dispose) | cancel confirm |
| 10 | poll every 5 s | `V/RemoteMopupIngFrame.as:398-405` | - |

Replies: 4964 `U_C_REMOTE_PET_MSG` (`RemotePetMsg` with the sweep index, read at `RemotePetManager.as:144`), 4967 `U_C_REMOTE_REWARLD` `RemoteItemMsg` `type` (#1) 2 = sweep turn result, `count` (#2) turn, `items` (#3, STRING) (`RemotePetManager.as:182-196`).

### R2. Lord trial: 9650 (0x25b2) `C_LORD_TRIAL_OP`, `LordTrialOpMsg`

Fields used: `op` (#1, ENUM `LordTrialOpType`: 6 SWEEP, 7 CANCEL_SWEEP, 8 SPEED_SWEEP, 9 SWEEP_ITEM), `nowType` (#6, INT32) trial type, `sweepIndex` (#5, INT32) target floor, `payType` (#2, INT32). Senders `decompiled/core_module/scripts/yishi/manager/LordTrialManager.as:88-112`.

| op | Meaning | Sender | Client checks |
|---|---|---|---|
| 6 | start | `V/LordTrialMopupPrepareFrame.as:240-280` | floor > 0, >= current, <= max (maze texts); gold `floors * 10000` else "Ouro insuficiente"; floors <= `lordTrialKeyCount` else "Chaves do Julgamento insuficientes" |
| 7 | cancel | frame dispose (`V/LordTrialMopupIngFrame.as:605-608`) | - |
| 8 | accelerate | `V/LordTrialMopupIngFrame.as:420-472`; elf contract -> `payType = 1` | cost `(sweepIndex - currentIndex + 1) * 5` diamonds (`lord_trial_sweep_templates` third value) |

Reply: 445 `U_C_LORD_TRIAL` `LordTrialOpMsg`; `op = 9` (SWEEP_ITEM) carries one floor result (`nowIndex`, `indexItems`) (`LordTrialManager.as:155-164`); other ops carry the full state including `sweepIndex` (#5) that reopens the in progress frame (`:166-190`). `errorID` (#3) codes include 12 `IN_SWEEP`, 13 `LACK_GOLD`, 9 `LACK_KEY` (`decompiled/core_module/scripts/com/road/yishi/proto/lordtrial/ErrorID.as`).

### R3. Monster explore: 8653 (0x21cd) `C_MONSTER_EXPLORE_CLIENT_OP`, `MonsterExploreClientOpMsg`

- `opType` (#1) = 6, `chapterId` (#3), `nodeId` (#4), `quickNum` (#6) number of sweeps (`decompiled/core_module/scripts/yishi/manager/MonsterExploreManager.as:209-218`), sent from `MonsterSweepFrame.as:200-206` (empty input -> "Digite as vezes de Bots:").
- Reply: monster explore state and rewards (owner [exploration](../exploration/README.md)).

### R4. Increasingly road: 5195 (0x144b) `C_DEMON_ROAD_OP`, `DemonRoadMsg`

- `op` (#1) = 6, `level` (#3) current layer, `index` (#4) node index (`decompiled/core_module/scripts/managers/IncreasinglyRoadManager.as:192-200`), from `IncreasinglyroadLayerItemView.as:125-139` (needs `energy >= enterBattleCostEnergy`).
- Reply: demon road state with `items` rewards (owner).

### R5. Theseus tower: 9760 (0x2620) `C_THESEUS_TOWER_CLIENT_OP`, `PlayerOpMsg`

- `op` (#1) = 2 (bot; 1 = fight) (`decompiled/core_module/scripts/managers/TheseussoulManager.as:651-657`), from `ThesstowerView.as:244-260`: button enabled only on the highest cleared stage; `normalTime + buyTime > 0` else "Vezes de ganhos insuficientes".
- Reply: tower data push (owner [theseus](../theseus/README.md)) with `SweepRewards` and a roll of `SweepRandom`.

## 4. Server messages (server to client)

See each route: 4964, 4967 (remote pet), 445 (lord trial), owner pushes for R3 to R5.

## 5. Rules and formulas

- Remote pet: 30 s per turn, accelerate 1 diamond per started minute.
- Lord trial: `lord_trial_sweep_templates` = `30,10000,5` (30 s per floor, 10000 gold per floor, 5 diamonds per floor to accelerate); one trial key per floor.
- Monster explore: limited by remaining daily gains.
- Increasingly road: costs `enterBattleCostEnergy` movement.
- Theseus tower: consumes one reward attempt (`normalTime`/`buyTime`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `lord_trial_sweep_templates` | time, gold, accelerate |
| Theseus tower templates (owner) | `SweepRewards`, `SweepRandom` | bot rewards |

## 7. Persistent state

Timed bots (R1, R2) use `mopup.sweep_job` with `source` `remote_pet` / `lord_trial` ([campaign-sweep.md](campaign-sweep.md)). Instant bots (R3..R5) need no sweep state; they update the owner's counters.

## 8. Backend implementation notes

- `mopup::other_sweeps::handle_remote_pet` (9544 ops 7..10), `handle_lord_trial` (9650 ops 6..8, results as op 9 pushes), called by the owners' dispatchers; share the lazy run materialization of the campaign sweep.
- Instant bots: `mopup::other_sweeps::handle_monster_explore` (8653 opType 6), `handle_increasingly_road` (5195 op 6), `handle_theseus_tower` (9760 op 2): validate clear state and counters, grant N times the node reward in one transaction, reply with the owner's state push.

## 9. Open questions and assumptions

- `payType` meaning (same pattern as the campaign sweep).
- Remote pet sweep cost (none visible besides acceleration).

## 10. Implementation checklist

- [ ] Remote pet ops 7, 8, 9, 10 and pushes 4964, 4967
- [ ] Lord trial ops 6, 7, 8 and push 445 op 9
- [ ] Monster explore opType 6
- [ ] Increasingly road op 6
- [ ] Theseus tower op 2
- [ ] `mopup.sweep_job` rows for remote pet and lord trial
- [ ] Test: lord trial bot refused without keys
