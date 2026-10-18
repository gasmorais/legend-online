# Plane Crisis ("Plano de Crise")

Area: trials, module `plane-crisis`. Client package `crisis` (`decompiled/m3/scripts/crisis`), manager `yishi.manager.PlaneCrisisManager`, model `mvc.module.crisis.PlaneCrisisModel`, controller key `planecrisis`, scene `PLANE_CRISRIS` (`crisis.PlaneCrisisSecenView`), proto package `crisis`.

Path aliases:

| Alias | File |
|---|---|
| PCM | `decompiled/core_module/scripts/yishi/manager/PlaneCrisisManager.as` |
| PCMOD | `decompiled/core_module/scripts/mvc/module/crisis/PlaneCrisisModel.as` |
| EF | `decompiled/m3/scripts/crisis/PlaneCrisisEnterFrame.as` |
| ECF | `decompiled/m3/scripts/crisis/ui/PlaneCrisisEnterConformFrame.as` |
| PI | `decompiled/m3/scripts/crisis/ui/item/PlaneCrisisPointItem.as` |
| RPF | `decompiled/m3/scripts/crisis/PlaneCrisisReportFrame.as` |

## 1. Overview

A team exploration on a node graph map. The team captain picks "Dificuldade I" or "Dificuldade II"; every member confirms (with or without spending the daily income count). Members move node to node spending action points ("pontos de movimento"); nodes hold events: mechanisms that buff the final boss, crystal monsters, fog whirls, chests and keys, crystals, action recovery stones. Collecting enough crystals unlocks the final boss ("alvo final"); attacking it pulls the whole team into a battle (battleType 3877 `PLANE_CRISIS`). Victory ends the game and rewards are computed from a score: 2 points per crystal plus 1 point per action point left. Buying extra action points either costs diamonds or reduces the final rewards by a percentage.

Daily income count: `crisis_available_times = 1` (`EF:39`); the counter `usePlaneCrisis` is pushed by 4875.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `crisis.PlaneCrisisEnterFrame` (`EF:36`), 380 x 230 | "Escolha de Dificuldade"; buttons "Dificuldade I (indicada para jogadores que ainda não tenham obtido a Profissão Avançada)", "Dificuldade II (...)", "Ver prêmios" | Captain chooses difficulty, reward tip | controller `planecrisis` openType `ENTER_CRISIS` (`decompiled/core_module/scripts/mvc/controler/PlaneCrisisController.as:16-24`) from space NPC dialog option 132 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:791-792`, `:906-918`, requires `VersionSwitch.PLANE_CRISIS_OPEN`) | `usePlaneCrisis`, config |
| Confirm "Deseja entrar no Plano de Crise {0}? (ganhos: {1}/{2})" with checkbox "Utilizar a quantidade de ganhos diária" (`EF:133-145`) | | Captain confirmation | enter button | |
| `crisis.ui.PlaneCrisisEnterConformFrame` (`ECF`), 330 x 120 | difficulty name, 10 s countdown, checkbox "Utilizar a quantidade de ganhos diária" | Each member accepts or refuses | 4873 (`PCM:86-103`) | difficulty |
| `crisis.PlaneCrisisSecenView` (scene `PLANE_CRISRIS`) with `PlaneCrisisMapView`, `PlaneCrisisSmallMapView` ("Mapa"), `PlaneCrisisArmyView`, `PlaneCrisisLeftView`, `PlaneCrisisTopView` | "Cristais coletados: {0}", "Movimento restante: {0} pts.", event progress, team list | Map exploration | 4867 `setScene("PLANE_CRISRIS")` (`PCM:130`) | 4867, 4868 |
| Node item `PlaneCrisisPointItem` (`PI`) | buttons "Transmissor" (invite), attack, transport to final boss | Node actions | map | node event template |
| Buy action points `TodayNotAlertFrame` style `ui.planeCrisis.buyFrame` | "Deseja reduzir seus ganhos finais em {0}% e assim obter {1} pontos de movimento?\nVezes que ainda pode comprar ({2}/{3})"; checkbox "Comprar por {0} diamantes" | Buy action points | `PCM.alertBuy` (`PCM:342-359`) | config |
| `crisis.PlaneCrisisReportFrame` (`RPF`), 535 x 360 | "Pontuação", "Prêmio de Eliminação", "Movimento comprado {0} vezes, {1} vezes com diamantes, os ganhos foram reduzidos em {2}%" | End report: score, rewards, players | controller `planecrisis` (default openType) after 4869 (`PCM:373-440`) | 4869 |

## 3. Routes (client to server)

All routes: send 9675 (0x25cb) `C_CRISIS_GAME_OP`, sender `PlaneCrisisManager.gameOp(op, p1, p2, p3)` (`PCM:442-451`), message `crisis.CrisisOpMsg`: `op` (#1, ENUM `CrisisOp`), `param1` (#2, INT32), `param2` (#3, INT32), `param3` (#4, INT32, never set by the client).

`CrisisOp` (`decompiled/core_module/scripts/com/road/yishi/proto/crisis/CrisisOp.as`): 1 START_GAME, 2 STEP, 3 ATTACK_BOSS, 4 INVITE, 5 GET_INVITE, 6 BUY_ENERGY, 7 QUIT, 8 GOTO_ENDBOSS, 9 PREPARE_CHOICE, 10 MOVE.

| # | UI control | Client sender | Client checks | Fields | Expected server response |
|---|---|---|---|---|---|
| C1 | Difficulty button + confirm | `EF.clickHandler` -> `confirmEnterFun` (`EF:105-151`) | hero level >= 80 ("... Nv. 80"); in a team ("Apenas pode entrar no Plano de Crise em equipe."); captain ("Apenas o líder pode ativar o Plano de Crise."); checkbox disabled when no income left | `op 1`, `param1` 1 use income / 0 not, `param2` difficulty 1 or 2 | 4873 to every team member, including the captain (assumption) |
| C2 | Member accept / refuse | `ECF.__confirmHandler` / `__cancelHandler` (`ECF:181-198`); timeout closes without sending | none | `op 9`, `param1` use income 1/0, `param2` 1 accept / 0 refuse | when all accepted: 4875 (new income count), 4867 to all; refuse: abort and notify (assumption) |
| C3 | Click an adjacent node | `PI.clickMoveHandler` (`PI:95-124`) | node connected to the current node (`LineNode`, "Apenas se pode mover para posições limítrofes."); not moving; action points >= `crisis_activity_consume` (1) else buy dialog | `op 10`, `param1` target node id | 4872 to all members, 4868 with the new energy |
| C4 | Walk animation finished | `PlaneCrisisWarkLayer.__warkOverHandler` (`decompiled/m3/scripts/crisis/ui/PlaneCrisisWarkLayer.as:123-133`) | own army only | `op 2`, `param1` node reached | node event resolution: 4868 (node `isPick`, crystals, energy, counters); 4876 for a teleport; battle for monsters |
| C5 | Attack button on the current node | `PI.attackHandler` (`PI:335-372`), confirm "Para atacar este alvo gastará {0} pontos de movimento." or for the final boss "Após confirmar, todos os membros da equipe deixarão a exploração e entrarão automaticamente em combate..." (+ offline warning) | on the node; action points >= `bossAttackNum` (`Property3` second value) else buy dialog | `op 3` | battle 3877 (single player for middle bosses, whole team for the final boss); 4871 to the other members for a middle boss (help request); 4868 after the battle |
| C6 | Help request accepted | `PCM.jionAttackBoss` (`PCM:260-279`) after 4871 "Ajudar a atacar o chefão" | action points >= `bossAttackNum` of the node the player stands on | `op 3` | as C5 |
| C7 | "Transmissor" (invite) | `PI.invateHandler` (`PI:328-333`) | enabled only on own node with `bossTransNum > 0` | `op 4` | team chat link of chat cell type 118 with data `[inviter id, node id]` (`decompiled/core_module/scripts/chat/datas/ChatCellData.as:244-247`) |
| C8 | Click the chat link | `PCM.acceptInvate` (`PCM:299-332`) via `CRISIS_ATTACK_INVATE_CLICK` (`decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:1332-1345`) | in scene `PLANE_CRISRIS`; not already on that node ("Já está na posição atual, não precisa se teleportar."); action points >= `bossTransNum`; confirm "Para se teleportar desta vez gastará {0} pontos de movimento." | `op 5`, `param1` node id, `param2` link data[0] (inviter) | 4872 (teleport), 4868 |
| C9 | Transport button on the final boss node | `PI.transHandler` -> `doTranEndBoss` (`PI:126-142`, `:319-326`) | node open and not picked; confirm "Utilize o transmissor para se teleportar o mais rapidamente possível para o alvo final." | `op 8` | 4872, 4868 |
| C10 | Buy action points | `PCM.buyBackFun` (`PCM:361-371`) | none (server checks the limit) | `op 6`, `param1` 0 = pay diamonds (checkbox checked), 1 = reduce rewards | 4868 with new `energy`, `buyCount`, `diamondBuyCount`, `rewardDelRate` |
| C11 | Exit (main toolbar return) | `MainToolBar.exitPlaneCrisisGame` (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1840-1846`) | confirm | `op 7` | 4870 to all members with the quitter id |

## 4. Server messages (server to client)

| Opcode | Message and fields | Client receiver | When |
|---|---|---|---|
| 4873 (0x1309) `U_C_CRISIS_PREPARE` | `simple.PropertyMsg`: `param1` (#1, INT32) difficulty 1/2 | `PCM.__enterGameHandler` (`PCM:86-103`) shows `PlaneCrisisEnterConformFrame` | After C1, to team members |
| 4867 (0x1303) `U_C_CRISIS_GAME_START` | `crisis.CrisisGameStartMsg`: `mapId` (#1, INT32) 1..3; `difficulty` (#2, INT32); `players` (#3, repeated `CrisisPlayerMsg`: `id` (#1, INT32) member id, `currentNodeId` (#2, INT32), `energy` (#3, INT32) action points, `color` (#4, INT32) marker color, `player` (#5, `room.RoomPlayerMsg` appearance: `player_id` (#6), `grades` (#7), `nick_name` (#8), `template_id` (#10), `arm` (#11), `cloth` (#12), `online_state` (#18), `change_shapeId` (#21), `geste` (#25), `head_id` (#26), `wing` (#31), `hat` (#33), `fashion_arm` (#34), `fashion_cloth` (#35), `hide` (#36); other RoomPlayerMsg fields unused)); `eventCountInfos` (#4, repeated `CrisisEventCountMsg`: `eventType` (#1), `eventMaxCount` (#2)); `needCrystal` (#5, INT32) crystals to unlock the final boss | `PCM.__gameStartHandler` (`PCM:105-131`, `readPlayerInfos` `:458-519`); switches to scene `PLANE_CRISRIS` | Game start and relogin into a running game (assumption) |
| 4868 (0x1304) `U_C_CRISIS_GAME_INFO` | `crisis.CrisisInfoMsg`: `players` (#1, repeated `CrisisPlayerInfo`: `id` (#1), `preNodeId` (#2), `currentNodeId` (#3), `crystal` (#4), `energy` (#5), `isQuit` (#6, BOOL), `buyCount` (#7), `isOffline` (#8, BOOL), `diamondBuyCount` (#9), `rewardDelRate` (#10) percent); `nodes` (#2, repeated `CrisisNodeInfo`: `nodeId` (#1), `eventId` (#2) `CrisisEventInfos.EventId`, `isOpen` (#3, BOOL) fog cleared, `isPick` (#4, BOOL) event consumed); `eventCountInfos` (#3, repeated `CrisisEventCount`: `eventType` (#1), `eventCount` (#2)); `isRelogin` (#4, BOOL) | `PCM.__updateGameInfoHandler` (`PCM:133-198`): updates nodes (marks final boss node), players, counters | Delta push after every change; full state on relogin |
| 4872 (0x1308) `U_C_CRISIS_MOVE` | `PropertyMsg`: `param1` member id, `param2` from node, `param3` to node | `PCM._moveHandler` (`PCM:200-216`) animates the army | After C3, C8, C9 |
| 4876 (0x130c) `U_C_CRISIS_FOCUS` | empty (body not read) | `PCM.__moveMapHandler` -> `PCMOD.transMoveMap` (`PCM:77-84`, `PCMOD:105-108`) recenters the map on the own army | After a teleport of the player |
| 4871 (0x1307) `U_C_CRISIS_ATTACK_BOSS` | `PropertyMsg` (fields not read) | `PCM.__attackBossHandler` (`PCM:246-258`): "Ajudar a atacar o chefão" | To other members when one attacks a middle boss |
| 4870 (0x1306) `U_C_CRISIS_GAME_QUIT` | `PropertyMsg.param1` member id | `PCM.__exitGameHandler` (`PCM:218-244`): self -> return to game hall or space; other -> remove from map | After C11 or disconnect timeout |
| 4869 (0x1305) `U_C_CRISIS_GAME_END` | `crisis.CrisisGameEndMsg`: `players` (#1, repeated `CrisisPlayerInfo`), `items` (#2, repeated `CrisisItemMsg`: `templateId` (#1), `count` (#2)), `crystalCount` (#3, INT32) score | `PCM.__gameEndHandler` (`PCM:373-435`): leaves the scene, then opens the report with own `buyCount`, `diamondBuyCount`, `rewardDelRate` | After the final boss battle (victory) or when the game ends |
| 4875 (0x130b) `U_C_CRISIS_REWARD_COUNT` | `PropertyMsg.param1` income runs used today | `PlayerManager.__crisisrewardTimeHandler` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:186-193`) -> `usePlaneCrisis` | Login and after a start with income |

## 5. Rules and formulas

- Requirements: level 80, team, captain starts (`EF:105-121`).
- Maps: `CrisisMapInfos.xml` maps 1..3 (295 nodes), node graph via `LineNode`; map size and offset from `crisis_map_coordinate`.
- Initial action points: `crisis_map_activity` = `map,difficulty,points` (20 for every map and difficulty).
- Move cost: `crisis_activity_consume` = 1 per step.
- Buy action points: `crisis_activity_additional = 20,10|10,10|1`: diamonds price 20 for 10 points (`pointBuyPrice`, `buyActionNum`); reward reduction 10% for 10 points (`buffPrice`); limit 1 purchase (`limitBuy`) (`PCMOD:138-152`). The client always shows the reduction offer; the diamond checkbox selects the payment.
- Node events (`PlaneCrisisEventType`, `decompiled/core_module/scripts/mvc/module/crisis/PlaneCrisisEventType.as:28-44`): 1 END_BOSS, 2 TRAP_BOSS (mechanism that buffs the final boss), 3 MIDDLE_BOSS (crystal monster), 4 DISPERSE_FOG, 5 TREASURE_BOX (needs a key), 6 KEY, 7 CRYSTAL (`Property1` crystals), 8 REWARD (action recovery stone), 9 NULL.
- Event template `Property3 = "transCost|attackCost"` (`bossTransNum`, `bossAttackNum`); `Property1`/`Property2` monster or drop ids by difficulty (assumption); `Property4`/`Property5` boss buff data.
- Final boss: unlocked when team crystals >= `needCrystal`; attacking it moves all online members into the battle; offline members do not participate nor get rewards.
- Score (`crisis_bonus_rate = 1,2` and `planeCrisis.rewardDesTip`): 1 point per action point left, 2 per crystal. Reward tiers per difficulty `crisis_bonus_show` (difficulty 1: 0-400, 401-2000, 2001-2600, 2601-3599, 3600+; difficulty 2: 0-600, 601-3000, 3001-4000, 4001-5399, 5400+), items in `CrisisDrop.xml` with `site = "map,difficulty"` and `para2 = "min,max"` score range. Rewards reduced by `rewardDelRate` percent.
- Income: rewards only when the member used an income count (`crisis_available_times = 1` per day).
- Battle: battleType 3877; after the battle the client returns depending on the activity manager (see [docs/battle/rules.md](../../docs/battle/rules.md) section 7.2).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/CrisisMapInfos.xml` | node | `TemplateId`, `MapId`, `NodeId`, `X`, `Y`, `NodeType` (0 normal, 1 start, 2, 10..12 special, assumption), `LineNode` CSV of connected nodes |
| `raw/xml/tempinfos/CrisisEventInfos.xml` | event (32 rows) | `EventId`, `EventType`, `Property1..5`, `Description`, `Icon` |
| `raw/xml/tempinfos/CrisisDrop.xml` | reward rows (72) | `dropId`, `site` "map,difficulty", `para2` score range, `itemId`, `count`, `isBind` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `crisis_map_coordinate`, `crisis_bonus_rate`, `crisis_available_times`, `crisis_map_activity`, `crisis_activity_consume`, `crisis_activity_additional`, `crisis_bonus_show` | see rules |

## 7. Persistent state

Game sessions are in memory (team scoped, short lived). Persist only the daily counter and finished games.

```sql
CREATE TABLE trials.plane_crisis_daily (
    player_id     BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    play_date     date     NOT NULL,
    income_used   smallint NOT NULL DEFAULT 0 CHECK (income_used >= 0),
    PRIMARY KEY (player_id, play_date)
);

CREATE TABLE trials.plane_crisis_game (
    game_id        bigserial   PRIMARY KEY,
    map_id         smallint    NOT NULL CHECK (map_id BETWEEN 1 AND 3),
    difficulty     smallint    NOT NULL CHECK (difficulty IN (1, 2)),
    captain_id     integer     NOT NULL REFERENCES player.players(player_id),
    started_at     timestamptz NOT NULL DEFAULT now(),
    finished_at    timestamptz,
    boss_defeated  boolean     NOT NULL DEFAULT false
);

CREATE TABLE trials.plane_crisis_member (
    game_id            bigint   NOT NULL REFERENCES trials.plane_crisis_game(game_id) ON DELETE CASCADE,
    player_id          BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    use_income         boolean  NOT NULL,
    crystals           integer  NOT NULL DEFAULT 0,
    energy_left        integer  NOT NULL DEFAULT 0,
    buy_count          smallint NOT NULL DEFAULT 0,
    diamond_buy_count  smallint NOT NULL DEFAULT 0,
    reward_del_rate    smallint NOT NULL DEFAULT 0 CHECK (reward_del_rate BETWEEN 0 AND 100),
    score              integer,
    quit               boolean  NOT NULL DEFAULT false,
    PRIMARY KEY (game_id, player_id)
);
```

## 8. Backend implementation notes

- Handlers: `trials::plane_crisis::handle_start` (op 1), `handle_prepare_choice` (9), `handle_move` (10), `handle_step` (2), `handle_attack_boss` (3), `handle_invite` (4), `handle_get_invite` (5), `handle_buy_energy` (6), `handle_quit` (7), `handle_goto_end_boss` (8).
- Session object per team: map id (random among 1..3, assumption), difficulty, node states (event id per node, open, picked), members (node, energy, crystals, purchases), event counters with maxima, `need_crystal`.
- Start: validate captain, team members level >= 80, nobody in another activity; send 4873 to all; wait 10 s for op 9 answers; timeouts count as refusal (assumption). On success deduct income where chosen (`plane_crisis_daily`), push 4875, push 4867 to all.
- Move: validate adjacency and energy; deduct energy; broadcast 4872 and 4868. Step: resolve the node event once (`isPick`), reveal neighbours (fog), push 4868.
- Middle boss attack: deduct `bossAttackNum`, start battle 3877 for the attacker (monsters from the event template), broadcast 4871 to others. Final boss: start one team battle 3877 with all online members; on victory compute scores, grant rewards per member in one transaction, send 4869, then 4870 for everyone or scene exit (assumption).
- Quit: remove member, broadcast 4870; end the session when no member is left.
- Team chat link type 118 must be emitted by the chat module with data `[inviter id, node id]`.

## 9. Open questions and assumptions

- Map selection rule (random or by difficulty) is unknown; `crisis_map_activity` lists maps 1..3 for both difficulties.
- Monster ids per event and difficulty (`Property1`, `Property2`) need verification against `CampaignData`/monster templates.
- Exact meaning of `NodeType` values other than 0 and 1.
- Whether a defeat in the final boss battle ends the game.
- 4871 body content is ignored by the client; the server may send the attacker id.

## 10. Implementation checklist

- [ ] Template loaders for `CrisisMapInfos.xml`, `CrisisEventInfos.xml`, `CrisisDrop.xml`, crisis config keys
- [ ] Tables `trials.plane_crisis_daily`, `plane_crisis_game`, `plane_crisis_member`
- [ ] In memory team session with node graph
- [ ] C1, C2 start and confirmation (4873, 4867, 4875)
- [ ] C3, C4 move and step (4872, 4868)
- [ ] C5, C6 attacks and battle 3877, help push 4871
- [ ] C7, C8 invite chat link and teleport
- [ ] C9 transport to final boss, 4876 focus
- [ ] C10 buy energy (diamonds or reward reduction)
- [ ] C11 quit (4870)
- [ ] End and rewards (4869)
- [ ] Tests: adjacency, energy purchase limit, score tiers, offline member exclusion, income flag
