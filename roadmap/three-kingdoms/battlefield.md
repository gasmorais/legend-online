# Battlefield (map 8501)

Aliases: see [README.md](README.md). Extra aliases:

| Alias | File |
|---|---|
| CAS | `decompiled/core_module/scripts/map/campaign/data/CampaignArmyState.as` |
| GAV | `decompiled/m3/scripts/map/campaign/view/physics/GodsEveningArmyView.as` |
| GMAP | `decompiled/m3/scripts/map/campaign/view/frame/GodsEveningMapFrame.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| CF | `decompiled/core_module/scripts/chat/utils/ChatFormat.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

Map 8501 hosts the three teams of a match. HUD (registered by `GodsEveningUIMediator`, `GUI:45-65`): left rank panel (personal and server ranks of the current round), top countdown, right panel with server tasks, personal tasks, self info and the inspiration button, and a "cancel delivery" button while the player carries something.

Objects (node `nodeId` = camp data id, `param1` = owning team):

| Nodes | Name | Interaction |
|---|---|---|
| 850104, 850105, 850106 | protector ("protetor") per team | attack (battle); killing gives the enemy team the debuff "Queda do Protetor" |
| 850107, 850108, 850109 | leader ("líder") per team | arrive opens `GodsEveningDialogFrame`: delivery of resources or a kidnapped god; when `param2 == 2` the leader is in battle: tip "A batalha de líderes está decorrendo. Volte a tentar mais tarde." (`CAVH:158-167`); killing a leader gives that team's protector the debuff "Cidade Sem Dono" until the leader respawns 1 minute later |
| 850110, 850111, 850112 | god ("deus") per team, rendered with the avatar of a real player of that team (245) | kidnap: the carrier enters state 12; delivering it to the own leader grants the "Devastador" buff to the whole team |
| type 91 nodes | resources | gather enemy resources (carrier state 2), deliver to the own leader |

Army states (`CAS:6-30`, from 4175 `state`): 0 alive, 1 dead, 2 carrying resources (`STATE_TRAN`), 3 dead while carrying (`STATE_DIEDTRAN`), 10 carrying a god (`STATE_GODDESS_TRAN`), 11 dead while carrying a god, 12 god kidnapped state (`STATE_GODDESS`). The UI shows the cancel button for states 2, 3, 10, 11 (`GUI:91-101`); delivery option 1 requires state 2 or 10, option 2 requires state 12 or 10 (`GDF:66-96`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `GodsEveningLeftView` (person / server tabs) | "Rank", "Nome", "Formação", "Pontos" | Live ranks of the round | map HUD | `personRankDataDic`, `serverRankDataDic` from 247 |
| `GodsEveningTopView` | countdown | Time left = `mapModel.endTime - now` while `gameState == 1` (`GMOD:103-114`) | map HUD | campaign end time |
| `GodsEveningRightView` (GRV) | inspiration counter, buttons | Tasks ([tasks.md](tasks.md)), self info ("No Ranking" when rank 0), map button, inspiration | map HUD | `inspireLevel`, rank, score |
| `GodsEveningDialogFrame` (GDF) | leader dialog: own leader "Jovem, vá saquear os recursos dos inimigos e todos os deuses!" options "Entregar os recursos", "Entregar deus"; `param2 == 1` variant: "Ouvi dizer que agora os recursos têm se de entregar ao líder. Vou ver ali!" | Deliver | arrive on a leader node | |
| `GodsEveningMapFrame` (GMAP), controller `space` openType 7 | node list with "{0}:" and "Ir" | Mini map with leaders, protectors, gods and carriers | map button / hotkey (`KeyBoardRegister.as:504-507`) | node states, carriers (states 10, 12) |
| Cancel button | | Abort carrying | HUD | state 2, 3, 10, 11 |
| Buff bar in the top bar | debuff icon | Shows `bossDebuffId` when `bossDebuffShowFlag == 0` (`TTB:2096-2104`) | 4171 | buffer template |

## 3. Routes (client to server)

### R1. Arrive at a node

Generic C>S 5125 arrive ([../campaign/README.md](../campaign/README.md)) sent by `CampaignManager.controller.sendCampaignArrive(armyId, nodeId)` for leader nodes not in battle (`CAVH:158-167`). The server answers with a dialog (opens GDF) or starts a battle (protector, enemy leader, players).

### R2. Deliver at the leader (dialog)

- UI: GDF option click (`GDF:57-97`).
- Client checks: option 1 needs state 2 or 10 else "A entrega falhou. É preciso coletar os recursos dos inimigos."; option 2 needs state 12 or 10 else "A entrega falhou. É preciso saquear os deuses inimigos.".
- Sender: `MapSocketOuterManager.sendFrameCallBackGodsEvening(mapId, nodeId, true, option)` (`MSOM:173-182`).
- Route: C>S 5033 (0x13a9) `U_C_CAMPAIGN_CONFIRM`, `campaign.CampaignReqMsg`: `para_int1 (#1, INT32)` = map id 8501, `para_int2 (#2, INT32)` = node id, `para_int5 (#5, INT32)` = 1 deliver resources / 2 deliver god, `para_bool1 (#7, BOOL)` = true.
- Leave option: `sendFrameCallBack(mapId, nodeId, false)` (`MSOM:82-90`), same opcode with `para_bool1 = false`.
- Response: 4175 state back to 0, score update 247, notice 253.

### R3. Cancel carrying

- UI: HUD cancel button (`GUI:85-89`).
- Sender: `GodsEveningManager.sendCancelTransport(userId, serverName)` (`GEM:432-440`).
- Route: C>S 25041 (0x61d1) `CR_GODS_PLAYER_OP`, `CrossGodsMsg`: `op_type (#1)` = 2, `user_id (#11, INT32)`, `server_name (#10, STRING)`.
- Response: 4175 with state 0 (the carried god returns to its node, resources are lost; assumption).

### R4. Inspiration (op 4)

- UI: GRV inspiration button (`GRV:132-162`).
- Client checks: `inspireLevel >= 10` gives "Já atingiu o nível de inspiração máximo."; confirm "Deseja gastar {0} diamantes para inspirar o servidor, aumentando todos os atributos dos jogadores deste servidor em {1}%?" with `{0}` = `gods_inspire` config (default 100, `CIM:828-835`) and `{1}` = 5; diamonds (`point`) < cost opens the recharge alert.
- Sender: `sendInspire(0)` (`GEM:442-449`).
- Route: C>S 5101 (0x13ed) `C_GODS_CLIENT_OP`, `CrossGodsMsg`: `op_type` = 4, `param1 (#5, INT64)` = 0.
- Response: 247 with the team row `buffer_lv` raised (updates `inspireLevel`), player info 3 (diamonds), notice 253 type 9.

## 4. Server messages (server to client)

### S1. 247 (0x00f7) `U_C_GODS_CAMPAIGN`

`gods.CrossGodsMsg`. Receiver `GEM.__campaignInfoHandler` (`GEM:203-334`):

- `my_info`: `teamId`, `readyScore`, `readyOrder`, `finalScore`, `finalOrder`.
- `info` rows: `teamDataDic[team_id] = server_name`; the caller's team row gives `inspireLevel = buffer_lv`.
- `taskInfo` rows ([tasks.md](tasks.md)).
- `playerInfo` rows: for `gameState == 1` keyed by `readyOrder` with `readyScore`; for `gameState == 2` keyed by `finalOrder` with `finalScore`; fields `user_id`, `nick_name`, `server_name`, `team_id`.
- `info` rows also feed the server rank (`readyOrder` / `finalOrder`, `readyScore` / `finalScore`).

Events fired: `MY_INFO`, `TASK_INFO`, `PERSON_RANK_INFO`, `SERVER_RANK_INFO`, `INSPIRE_INFO` when the matching lists are present. When: on entry and on every score, task or inspiration change (throttle to 1 per second per player; send only changed lists).

### S2. 245 (0x00f5) `U_C_GODS_NODES`

`CrossGodsMsg`, `playerInfo` rows. Receiver `__npcNodeInfoHandler` (`GEM:349-394`): for each row builds a `ThaneInfo` keyed `team_id + "_" + id` with `template_id`, `nick_name`, `server_name`, `head_id`, and avatar strings `wingAvata`, `slotAvata`, `clothAvate`, `hatAvata`, `fashionArmAvata`, `fashionClothAvata`; then copies the god nodes 850110 to 850112 into `npcNodeViewDic` (`GMOD:160-212`). `id` is the node role (assumption: 1 leader, 2 protector, 3 god, matching `GodsEveningController.NODE_TYPE_1..3`). When: on entry; the avatar is a top player of each team (assumption: highest fight power).

### S3. 244 (0x00f4) `U_C_GODS_BOSS_HP`

`CrossGodsMsg`. Receiver `CSM.__godsEveningBossHpHandler` (`CSM:616-627`): node `param3 (#7, INT32)` gets `curHp = param1 (#5, INT64)` and `totalHp = param2 (#6, INT64)`. When: push to the instance when a leader or protector HP changes.

### S4. 4171 (0x104b) `U_C_GODS_BUFFER`

`simple.PropertyMsg`. Receiver `__godsBufferHandler` (`GEM:61-69`): `bossDebuffId = param1`, `bossDebuffShowFlag = param2` (0 shows the icon). When: push to the affected team when a debuff starts or ends ("Cidade Sem Dono", "Queda do Protetor").

### S5. 4175 (0x104f) `U_C_PLAYER_DIE_STATE`

`simple.PlayerStateListMsg` (`playerState (#1, WorldBossPlayerStateMsg, repeated)`, `userId (#2, INT32, repeated)`), rows: `army_id (#1, INT32)`, `state (#2, INT32)`, `left_time (#3, INT32)` respawn ms, `server_name (#4, STRING)`, `res_count (#5, INT32)` carried resources, `npcNodeId (#6, INT32)` carried god node, `templateId (#7, INT32)` team of the carried god. Receiver `CSM.__playerDieStateHandler` (`CSM:1338-1375`) sets `goddessTeamId`, `goddessId`, `isDie`, `oreNum` and notifies `GODS_EVENING_GODDESS`. Owned by [../world-boss/README.md](../world-boss/README.md).

### S6. 253 (0x00fd) `U_C_CHANNEL_GODS_ALERT`

`chat.ChatChannelMsg` with `type == 6` and an XML element in the message: attributes `type` (notice 1..11), `team_a`, `team_b`, `newTimeId`, `nickName_a`, `nickName_b`, `text`, `score`, `position` (`CF:1447-1500`). Receiver `BaseManager.__godsEveningNoticeHandler` (`BM:2087-2160`), filtered by `job` (0, 4 or own job). Notice keys `godsEvening.chatData.notice1..11` (chat) and `godsEvening.mseeageTip.notice1..11` (center tip):

| type | Event | Points in text |
|---|---|---|
| 1 / 10 | kill streak announced, "Alguém vá terminar o combo dele!" | bounty `score` |
| 2 / 11 | streak ended | `score` |
| 3 | leader killed, enemy protector gets "Cidade Sem Dono" | |
| 4 | leader respawned, debuff removed | |
| 5 | god being kidnapped ("Ir Ajudar" / "Ir Socorrer" links) | 200 |
| 6 | kidnap intercepted | 200 |
| 7 | god delivered, team gains "Devastador" | |
| 8 | protector killed, team gets "Queda do Protetor" | |
| 9 | inspiration, level `{4}`, all attributes +`{5}`% | |

## 5. Rules and formulas

- Inspiration: max level 10 (`GMOD:16`), +5% attributes per level (`GMOD:20`), cost `gods_inspire` (absent from `ConfigInfos.xml`, so 100 diamonds); applies to the whole team (server).
- Campaign buffer tip: "Ataque e Defesa do jogador +{0}%. Apenas têm efeito em combates da Hegemonia dos Três Reinos." (`godsEvening.campaignBuffer.tip`).
- Leader respawn: 1 minute (help item 7).
- Scoring (help item 4): kills, ending streaks, leaders, protectors, resource collection, kidnaps, tasks. Values not in the client except 200 for kidnap rescue notices; configure the rest (assumption).
- Server score = sum of member points except server task points (help item 4).
- Battles: PvP and NPC fights use battleType 330 `GODS_BATTLE`; the inspiration percentage adds to attack and defense (assumption).
- Idle kick 5 minutes ([lobby.md](lobby.md)).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/MapInfos.xml` | map 8501 |
| `raw/xml/tempinfos/MapNodeInfos.xml` | no node rows for map 8501 (nodes must be authored server side) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `gods_inspire` absent (default 100) |

## 7. Persistent state

Instance state is in memory. Persisted: scores in `three_kingdoms.participants` and `three_kingdoms.match_teams` ([lobby.md](lobby.md)), inspiration in `match_teams.inspire_level`.

```sql
CREATE TABLE three_kingdoms.inspirations (
    event_id   bigint      NOT NULL REFERENCES three_kingdoms.events(event_id) ON DELETE CASCADE,
    player_id  bigint      NOT NULL REFERENCES player.players(player_id),
    server_id  integer     NOT NULL,
    new_level  smallint    NOT NULL CHECK (new_level BETWEEN 1 AND 10),
    diamonds   integer     NOT NULL,
    created_at timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- Instance: one campaign instance of map 8501 per group; spawn per team; nodes created with `param1 = team_id`.
- `three_kingdoms::battlefield::handle_arrive` (5125 on map 8501): leader of own team: dialog (5033 callback); enemy leader / protector: battle 330 against the NPC (send 244 on HP change); god of another team: start kidnap (state 12 for the carrier), notice 5; resource node of another team: gather (state 2, `res_count`).
- `three_kingdoms::battlefield::handle_deliver` (5033 with `para_int5`): validate state and node (own leader), apply score, team buff for gods, reset state, push 4175, 247, 253.
- `three_kingdoms::battlefield::handle_cancel_transport` (25041 op 2): carrier state back to 0, god returns.
- `three_kingdoms::battlefield::handle_inspire` (5101 op 4): level < 10, diamonds >= cost. Transaction: spend diamonds (currency API), raise team level, insert inspiration; push 247 to the whole team and 253 notice to the match.
- PvP: player versus player battles on contact or attack (battleType 330); death sets state 1 or 3/11 (carrying), respawn after `left_time`.
- Debuffs: leader killed: protector debuff until leader respawn (60 s), push 4171 to that team (`param2` 0 show, 1 hide).

## 9. Open questions and assumptions

- Open: numeric score per action, kill streak rules, respawn times.
- Open: node layout of map 8501 (no data).
- Assumption: `GodsPlayerInfoMsg.id` role meaning in 245.
- Assumption: cancel carrying returns the god.

## 10. Implementation checklist

- [ ] Map 8501 instance with team nodes 850104 to 850112 and resource nodes.
- [ ] Routes 5125 handling, 5033 delivery, 25041 op 2, 5101 op 4.
- [ ] Server messages 247, 245, 244, 4171, 4175, 253.
- [ ] Table `three_kingdoms.inspirations`.
- [ ] Battles 330.
- [ ] Tests: deliver option 1 while in state 0 refused; inspiration at level 10 refused; leader killed toggles 4171 for 60 s.
