# Aventura das Nuvens (monopoly, "云端历险")

Path aliases:

| Alias | File |
|---|---|
| MM | `decompiled/core_module/scripts/managers/MonopolyManager.as` |
| MSO | `decompiled/core_module/scripts/managers/MonopolySocketOutManager.as` |
| MMOD | `decompiled/core_module/scripts/mvc/module/monopoly/MonopolyModel.as` |
| MC | `decompiled/core_module/scripts/mvc/controler/MonopolyController.as` |
| MBV | `decompiled/m3/scripts/map/campaign/view/ui/monopoly/MonopolyBottomView.as` |
| MAF | `decompiled/core_module/scripts/monopoly/view/MonopolyAlertFrame.as` |
| MDF | `decompiled/core_module/scripts/monopoly/view/MonopolyDiceMagicFrame.as` |
| MFA | `decompiled/core_module/scripts/monopoly/view/MonopolyFriendAssistFrame.as` |
| MFR | `decompiled/core_module/scripts/monopoly/view/MonopolyFinishRewardFrame.as` |
| MGM | `decompiled/core_module/scripts/managers/MonopolyGemMazeManager.as` |
| MLM | `decompiled/core_module/scripts/managers/MonopolyLlkManager.as` |
| DOI | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as` |

## 1. Overview

A daily single player board game played inside a campaign map: the player rolls dice and moves along numbered nodes; each node triggers an event (creature battle, monster cave, demon king, fog, trap, sky treasure, paid toll) or a minigame (gem maze or link game). Normal dice are given each day; magic dice let the player choose the result (1..6) and can be bought. Battles use the elite spirit plus 2 Einherjar (no soldiers); friends can be called to help with war flags. Reaching the end gives extra rewards, more for unused dice, plus a final slot machine. Help (`Monopoly.helpContent`): level 55, once per day, individual only (no teams), leaving and re-entering keeps progress, settled runs reset daily at 05:00, unsettled runs can be reset manually.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| Campaign map with `MonopolyUIMediator`, `MonopolyTopView`, `MonopolyBottomView` (MBV), `MonopolyTeamView`, `MonopolySkillView` | board | Nodes with icons, dice counters (normal, magic, bought), roll normal, roll magic, buy magic dice, leave; team view of the spirit and 2 Einherjar with skill selection | Space NPC dialog option 26 `MONOPOLY` -> `MonopolySocketOutManager.sendEnterCampaign()` (DOI:90, 609-611) | 4711 |
| `monopoly.MonopolyDiceRollView` | dice animation | normal roll result | 4710 `type 0` (MM:147-162) | |
| `monopoly.MonopolyDiceMagicFrame` (MDF) | "Escolher os pontos necessários" | choose 1..6 | MBV magic button | |
| `monopoly.MonopolyAlertFrame` (MAF) | event titles `monopoly.view.MonopolyAlertFrame.TitleTxt<type>` | Event popup per node type: 1 "Encontro com Criatura", 2 "Entrar na Cave das Criaturas", 3 "Estrada do Rei das Criaturas" (fight self or ask friends), 4 "Encontrar Nevoeiro", 5 "Encontrar Armadilha", 6 "Baú de Tesouro do Céu", 11 "Recursos pagos" (pay to pass) | 4713 other types (MM:218-221) | node rewards |
| `monopoly.MonopolyFriendAssistFrame` (MFA) | "Pedir Assistência" | Friend list (name, level, power), war flags count and buy "Quer consumir {0} Diamantes para comprar 1 Bandeira de Guerra" | MAF friend fight (`openControllerByInfo("monopoly",3)`) | |
| `monopoly.MonopolyBattleFailureFrame` | "Batalha perdida" | "Somente após eliminar o Demónio é que pode continuar, Por favor escolha Continuar a combater Ou pedir Ajuda a amigos." | 4713 `type 8` | |
| `monopoly.MonopolyFinishRewardFrame` (MFR) | finish | Unused dice rewards "x{0}", slot machine "Número de Prendas x{0}", leave | 4713 `type 10` | `normal_times`, `magic_times`, `slot_machine_times`, `is_mail` |
| `monopoly.MonopolyGameOverFrame` | "Aventura terminada" | "Essa aventura já terminou, durante essa viagem você obteve." | 4712 | items |
| `monopoly.MonopolyGemMazeFrame`, `monopoly.MonopolyLlkFrame` | "Pontos do objetivo:", link game | Node minigames ("Termine o desafio da Divindade") | 4713 `type 12` (`gameType 1` gem maze, else link game) | 4760/4761, 4759 |
| `MonopolyPetFormationFrame` | formation | Spirit and Einherjar positions | team view, pet frames (`m14/scripts/pet/...`) | |

Frame keys (MC:38-56): 1 dice magic, 2 alert, 3 friend assist, 4 finish reward, 5 game over, 6 battle failure, 7 link game, 8 gem maze.

## 3. Routes (client to server)

| # | Action | UI | Client checks | Route and body | Expected reply |
|---|---|---|---|---|---|
| R1 | Enter | NPC option 26 | none (server: level 55, not in a team) | C>S 8823 (0x2277) `C_MONOPOLY_CAMPAIGN_ENTER`, empty | campaign enter (map session, [../campaign/map-session.md](../campaign/map-session.md)), 4711 |
| R2 | Roll normal dice | MBV normal (MBV:184-198) | game not over (else sends R8); `normal_point > 0` else "Os dados comuns já foram usados" | C>S 8824 (0x2278) `C_MONOPOLY_CAMPAIGN_ROLL_DICE`, `campaign.RollDiceMsg`: `type` (#1) 0, `point` (#2) 0 | 4710 |
| R3 | Roll magic dice | MDF choose 1..6 (MDF:200-224) | magic dice left or bought; else offer to buy ("Dados mágicos esgotados, ainda pode comprar {0}x") | 8824, `type 1`, `point` 1..6 | 4710 |
| R4 | Arrive on a node (trigger) | army arrives (`MonopolyArmyView.as:35`) | none | C>S 8825 (0x2279) `C_MONOPOLY_CAMPAIGN_TRIGGER_EVENT`, empty | 4713 |
| R5 | Confirm the event / fight / continue | MAF buttons, battle failure, minigame end (MAF:131-152, `MonopolyBattleFailureFrame.as:76-87`, `MonopolyGemMazeFrame.as:315`, `MonopolyLlkFrame.as:271`) | none | C>S 8833 (0x2281) `C_MONOPOLY_CAMPAIGN_TRIGGER_CONFIRM`, `campaign.TriggerEventMsg`: `userId` (#1, INT32) 0 = self, `param2` (#3, INT32) same | battle or result, 4713 |
| R6 | Fight with a friend's help | MFA item (`MonopolyFriendAssistItemView.as:125`) | friend level ("O Nv.da outra parte é inferior a {0}"); war flags | 8833 with `userId` = friend id | battle, 4713 |
| R7 | Buy magic dice / war flag | MBV buy (MBV:142-170), MFA buy (MFA:300-321) | count < max ("Já comprou o máximo de dados mágicos"); price <= diamonds (bound allowed by option) | C>S 8832 (0x2280) `C_MONOPOLY_CAMPAIGN_BUY_EVENT`, `TriggerEventMsg`: `userId` 1 magic dice, 2 war flag; `param1` 0 = use bound diamonds, 1 = diamonds only | 4720 |
| R8 | Leave | MBV leave, team view leave, finish frame (MBV:193, 210; `MonopolyTeamView.as:209`; MFR:349; main toolbar `MainToolBar.as:1751`) | none | C>S 8835 (0x2283) `C_MONOPOLY_CAMPAIGN_LEAVE`, `TriggerEventMsg` `param1` 1 leave (0 from the team view = reset run, "MonopolyManager.ResetBtnClickTip02") | 4712, return to space |
| R9 | Final slot machine | MFR (MFR:258) | `slot_machine_times > 0` | C>S 8836 (0x2284) `C_MONOPOLY_SLOT_MACHINE`, empty | 4721 |
| R10 | Formation | `MonopolyPetFormationFrame.as:443`, pet frames | none | C>S 8725 `PlayerPetMsg` `monopolyPos` (STRING), `operateType` 2 | owner [../einherjar/README.md](../einherjar/README.md) |
| R11 | Pet skills on the board | `MonopolyTeamItemView.as:208` | none | C>S 8726 `PetInfoMsg` `petId`, `monopolySkillIndexs` | owner einherjar |
| R12 | Link game ops | MonopolyLlkFrame | see [../mazes/README.md](../mazes/README.md) | C>S 8877 (0x22ad) `C_MONOPOLY_LINKGAME_OP`, `linkgame.LinkGameMsg` (`op_type` 1 open .. 12 start, `a_x`, `a_y`, `b_x`, `b_y`, `param1`) via MLM:65-92 | 4759 |
| R13 | Gem maze ops | MonopolyGemMazeFrame | see [minigames.md](minigames.md) | 8961 info, 8879 move (`GemMoveMsg`), 8878 buy moves (`GemMazeBuyTimesMsg`) via MGM:92-120 | 4760, 4761, 4864 |

## 4. Server messages (server to client)

`campaign.RollDiceMsg`: `type` (#1, INT32) 0 normal (animation), 1 magic; `point` (#2, INT32); `normal_point` (#3, INT32) normal dice left; `special_point` (#4, INT32) magic dice left; `war_flag` (#5, INT32); `result_point` (#6, INT32) rolled value; `position` (#7, INT32) node position after the move; `nodeInfo` (#8, `NodeMsg` repeated: `position` (#1), `type` (#2) node event type, `templateId` (#3) node content); `last_buy_special_point` (#9, INT32) magic dice purchases left; `last_buy_war_flag` (#10, INT32) war flag purchases left; `campaign_count` (#11, INT32) runs today. Only present fields overwrite (MM:73-112).

`campaign.CampaignNodeInfoMsg`: `type` (#1, INT32); `normal_times` (#2), `magic_times` (#3), `slot_machine_times` (#4) INT32; `is_mail` (#5, BOOL) rewards by mail; `nodeInfo` (#6, `TempMsg` repeated: `templateId` (#1), `count` (#2), `type` (#3)); `gameType` (#7, INT32).

| # | Opcode | Message | Receiver | When |
|---|---|---|---|---|
| S1 | 4711 (0x1267) `U_C_ENTER_MONOPOLY_CAMPAIGN` | `RollDiceMsg` with full `nodeInfo` | `__enterMonopolyCampaignResHandler` (MM:309-362): binds nodes to the map nodes sorted by `nodeId`, places the army at `position` | after R1 |
| S2 | 4710 (0x1266) `U_C_ROLL_DICE` | `RollDiceMsg` | `__rollDiceResHandler` (MM:141-173): animation for `type 0`, then moves along `getPath()` | reply to R2, R3 |
| S3 | 4713 (0x1269) `U_C_ROLL_DICE_CONFIRM` | `CampaignNodeInfoMsg` | `rollDiceConfirmCallBack` (MM:175-222): `type` 100 close frames; 10 finish reward frame; 8 battle failure; 7 battle reward line "Obteve: {0}" (`TempMsg` list) and hide boss; 12 minigame ("Termine o desafio da Divindade"; `gameType 1` gem maze, else link game); other values = alert frame type (1..6, 11) | reply to R4, R5, R6; after battles |
| S4 | 4720 (0x1270) `U_C_BUY_ROLL_DICE` | `RollDiceMsg` | `__buyRollDiceHandler` (MM:273-280) | reply to R7 |
| S5 | 4721 (0x1271) `U_C_SLOT_MACHINE` | `CampaignNodeInfoMsg` (`nodeInfo` = items won, times left) | `__slotMachineHandler` (MM:282-298) | reply to R9 |
| S6 | 4722 (0x1272) `U_C_SYC_DICE` | `RollDiceMsg` | `__sysDiceHandler` (MM:300-307) | push after battles and resets |
| S7 | 4712 (0x1268) `U_C_MONOPOLY_CAMPAIGN_OVER` | `CampaignNodeInfoMsg` | `monopolyCampaignOverCallBack` (MM:390-401): game over frame in space | after R8 or run end |
| S8 | 259 (0x0103) `U_C_MONOFIGHT_GOBACK` | `RollDiceMsg` buffered for the campaign scene | `onFightLoss` (MM:114-119) | after a lost node battle (assumption: same as 4710 payload) |

## 5. Rules and formulas

`raw/xml/tempinfos/ConfigInfos.xml`:

| Config | Value | Meaning |
|---|---|---|
| `Dice_Monopoly` | 10,7,5,50 | normal dice per run, magic dice per run, max magic dice purchases per day, diamonds per magic die (MMOD:83-89) |
| `Flag_Monopoly` | 5,10 | max war flags, diamonds per war flag |
| `Game_List` | `3,2,...` | game box preview: game 3 "云端历险" on weekdays 2, 5, 7 (owner [../time-story/README.md](../time-story/README.md) game box) |

- B1. Level 55, once per day, solo; daily reset 05:00 for settled runs.
- B2. Run ends when normal, magic and bought magic dice are all 0 (`gameIsOver`, MMOD:91-98).
- B3. Node events per type (alert frames); boss nodes must be defeated to continue (battle failure frame); friend help consumes a war flag and does not affect the friend.
- B4. Battles: elite spirit plus 2 Einherjar from the monopoly formation; skills from `monopolySkillIndexs`; no soldiers (help line 3).
- B5. End rewards: bonus per unused die, slot machine spins `slot_machine_times`, mail when the bag is full (`is_mail`).

## 6. Templates

Board layout and node contents are server data; map nodes come from the campaign map (`raw/xml/tempinfos/MapNodeInfos.xml`, see [../campaign/README.md](../campaign/README.md)).

## 7. Persistent state

```sql
CREATE TABLE casino.adventure_run (
  player_id          INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  run_day            DATE        NOT NULL,
  position           SMALLINT    NOT NULL DEFAULT 1,
  normal_dice        SMALLINT    NOT NULL DEFAULT 10,
  magic_dice         SMALLINT    NOT NULL DEFAULT 7,
  magic_buys_left    SMALLINT    NOT NULL DEFAULT 5,
  war_flags          SMALLINT    NOT NULL DEFAULT 0,
  war_flag_buys_left SMALLINT    NOT NULL DEFAULT 5,
  runs_today         SMALLINT    NOT NULL DEFAULT 0,
  board              JSONB       NOT NULL,
  pending_node       SMALLINT,
  slot_spins_left    SMALLINT    NOT NULL DEFAULT 0,
  settled            BOOLEAN     NOT NULL DEFAULT FALSE
);

CREATE TABLE casino.adventure_formation (
  player_id    INTEGER PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  positions    TEXT    NOT NULL
);
```

## 8. Backend implementation notes

- `casino::adventure::handle_enter` (8823): level 55 -> not in team -> run available today (or resume unsettled). Create the board (positions, node types, templates), enter the campaign map session, reply 4711.
- `casino::adventure::handle_roll` (8824): dice left by `type` -> move `point` (magic) or random 1..6; reply 4710.
- `casino::adventure::handle_trigger` (8825): resolve the node at `position`: reward nodes reply 4713 with `nodeInfo`; battle nodes reply 4713 with the alert type; minigame nodes reply 4713 `type 12`.
- `casino::adventure::handle_confirm` (8833): start the node battle (battle type of the monopoly campaign; units: the player's spirit plus 2 Einherjar, or a friend's when `userId` set and a war flag is spent) or apply the toll/trap; reply 4713 `type 7` win, `type 8` loss.
- `casino::adventure::handle_buy` (8832), `handle_leave` (8835: settle, rewards per unused dice, 4713 `type 10` or 4712), `handle_slot` (8836: spin, 4721).
- Daily job 05:00: reset settled runs.

## 9. Open questions and assumptions

- Assumption: node type values match the alert types (1..6, 11) plus 7, 8, 10, 12, 100 control values.
- Assumption: 259 carries a `RollDiceMsg` (the handler reads one).
- Open: board size and node distribution.

## 10. Implementation checklist

- [ ] Board UI in the campaign map, frames 1..8
- [ ] Routes 8823, 8824, 8825, 8832, 8833, 8835, 8836 (+ 8725, 8726 owned by einherjar; 8877, 8878, 8879, 8961 minigames)
- [ ] Messages 4710, 4711, 4712, 4713, 4720, 4721, 4722, 259
- [ ] Tables `adventure_run`, `adventure_formation`
- [ ] Node battles with spirit and Einherjar
- [ ] Test: run ends with 0 dice; 6th magic die purchase of the day refused
