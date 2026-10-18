# Monster exploration ("Exploração de monstros")

Feature [exploration](README.md), module `monster-explore`. Aliases in [README.md](README.md).

## 1. Overview

- Idle progression with the player's combat beasts ("Monstros", feature [monsters](../monsters/README.md)). The player picks up to 3 beasts and a formation, chooses a map node (4 chapters named after the outer worlds: "Pasto Livre", "Floresta Nublada", "Pântano Sem Fim", "Deserto da Morte"; 145 nodes such as "Ninho dos Lobos 1"), and the team keeps fighting server simulated waves of soldiers on that node, online or offline ("Jogadores podem escolher um local específico no mapa para ficar offline").
- Per minute the player earns `MinuteGold` and `MinuteExp` of the node; each defeated wave adds `NpcGold`/`NpcExp`; beasts gain exp and level up.
- Beating the node boss (a real battle, battleType 3884) unlocks the next node and pays `BossDrop`. Boss rewards are limited to `monster_explore_boss_max_count = 10` per day; already beaten bosses can be "botted" (sweep) for rewards within the same daily cap.
- "Combate rápido": pay 100 diamonds to receive immediately `120 + bonus` minutes of idle gains; 10 per day; every use permanently adds 1 minute (`fastTotalCount`).
- The module is disabled in this build: `VersionSwitch.MONSTER_EXPLORE = false` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:158`).

## 2. Screens

Controller `monsterexplore` (`decompiled/core_module/scripts/mvc/controler/MonsterExploreControler.as:34-58`): openType `MAIN_FRAME` (default), `SELECT_PASS_FRAME`, `FORMATION_FRAME`, `FAST_FIGHT_FRAME`, `WIN_REWARD_FRAME`.

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ME/MonsterExploreFrame.as` (945 x 550) | node name; "(Quantidade de ganhos restante: {0}/{1})"; "(Bot já concluiu a última fase)" | Main view: battle animation, 3 beast cards, minute gold/exp, boss button, fast fight, map, sweep, drop preview (`:106-472`). Sends op 0 on open (`:113`) and op 1 on close (`:505`) | controller default | `curChapterId/curNodeId` template (`:455-472`), `bossHasCount`, formation, fight state |
| `ME/view/MonsterExploreBattleView.as`, `ME/view/MonsterExploreBattleAvatarView.as` | | Animates states 0 wait, 1 walk (`stateTime` of 10 s), 2 fight (damages), 3 fight over (victory, level up marks) (`MonsterExploreBattleView.as:116-235`) | main frame | 4577 lists |
| `ME/view/MonsterExploreMapView.as`, `ME/MonsterExploreSelectPassFrame.as`, `ME/view/MonsterExploreNodeDetailView.as`, `ME/item/MonsterExploreChapterNodeItem.as` | chapter name; "Ver Drop" | Chapter map with nodes (`PosX/PosY`), node detail with enter and sweep ("Bot") buttons (`MonsterExploreNodeDetailView.as:120-232`) | "fast pass" button (`ME/MonsterExploreFrame.as:384-387`) | templates, `maxChapterId/maxNodeId` |
| `ME/MonsterFormationFrame.as` (673 x 430) | "Ajustar Formação"; "Tornar líder" | Pick 3 beasts, drag them on 8 cells, set the captain; sends op 2 on close if changed (`:48-292`) | "select monster" button | `formationDic` |
| `ME/MonsterExploreFastFightFrame.as` (385 x 310) | "Combate rápido"; "Pode obter ganhos de {0}minutos no combate rápido. A cada uso acrescenta permanentemente 1 minuto de ganho"; "Oportunidades restantes hoje: {0}" | Fast fight (`:39-133`) | fast fight button | `fastUseCount`, `fastTotalCount`, config |
| `ME/MonsterSweepFrame.as` (310 x 235) | "Aviso"; "Deseja fazer Bot?... (Vezes de ganho restantes hoje: {0})"; "Vezes de Bots:" | Sweep count input (`:42-208`) | sweep buttons (`ME/MonsterExploreFrame.as:389-405`, `MonsterExploreNodeDetailView.as:120-136`) | remaining boss rewards |
| `ME/MonsterExploreWinRewardFrame.as` (385 x 310) | "Prêmio de vitória" | Boss/sweep reward list, "next node" button (`:45-170`) | after battle return (`decompiled/m3/scripts/map/space/SpaceSceneController.as:350-362`, `decompiled/m4/scripts/castle/CastleSceneView.as:215-227`) or push 4579 (`ME/MonsterExploreFrame.as:278-282`) | `bossWinReward` |

## 3. Routes (client to server)

All requests: send 8653 (0x21cd) `C_MONSTER_EXPLORE_CLIENT_OP`, protobuf `MonsterExploreClientOpMsg` (package `monster`): `opType` (#1, INT32), `monsterId` (#2, INT32, unused), `chapterId` (#3, INT32), `nodeId` (#4, INT32), `edits` (#5, MESSAGE `MonsterExploreEditMsg`, repeated: `index` (#1, INT32) slot 1..3, `monsterId` (#2, INT32) beast instance id, `fightPos` (#3, INT32) formation cell, `isCaptain` (#4, BOOL)), `quickNum` (#6, INT32). Senders in `decompiled/core_module/scripts/yishi/manager/MonsterExploreManager.as` (`MEM`): `sendClientRequest(op)` (`MEM:191-197`), `sendChapterNodeSelect` (`MEM:199-207`), `sendMopupBoss` (`MEM:209-218`), `sendMonsterFormation` (`MEM:220-236`). Op constants `decompiled/core_module/scripts/mvc/module/monsterexplore/MonsterExploreConstClass.as:6-18`.

| # | op | UI and sender | Client checks | Expected reply |
|---|---|---|---|---|
| M0 | 0 OPEN_PANEL | main frame constructor (`ME/MonsterExploreFrame.as:113`) | entry checks (see README) | 4576 formation, 4578 user info, 4577 current fight state; the server starts streaming 4577/4580 while the panel is open (assumption) |
| M1 | 1 CLOSE_PANEL | main frame dispose (`ME/MonsterExploreFrame.as:505`) | none | none; stop streaming |
| M2 | 2 EDIT_MONSTER | formation frame close when changed (`ME/MonsterFormationFrame.as:271-283`) | max 3 beasts; cells limited to 3, 6, 9, 12, 1, 4, 7, 10 and one beast per row pair (`:44-46`, `:195-208`); captain toggle (`ME/item/MonsterFormationSelectItem.as:215-240`) | 4576 with the saved formation; 4578 `isEditSwitch` (assumption) |
| M3 | 3 SELECT_NODE | node "enter" (`ME/view/MonsterExploreNodeDetailView.as:162-181`), "next" in the reward frame (`ME/MonsterExploreWinRewardFrame.as:103-112`) | node unlocked: `chapter < max` or same chapter and `node <= maxNode + 1` else "Por favor complete primeiro a fase anterior." (`MonsterExploreNodeDetailView.as:183-190`) | 4578 with `curChapterId/curNodeId`, `isNodeSwitch`; 4577 reset |
| M4 | 4 FAST_FIGHT | fast fight confirm (`ME/MonsterExploreFastFightFrame.as:89-120`) | `fastUseCount < 10` else "Vezes restantes insuficientes"; confirm "Deseja gastar {0} diamantes para realizar 1 combate rápido?" (100); real diamonds only (`judgePointEnoughToShowPay(cost, false)`) | 4578 (`fastUseCount + 1`, `fastTotalCount + 1`), 4580 exp, player info 3 (gold, diamonds), bag pushes |
| M5 | 5 BOSS_FIGHT | boss button (`ME/MonsterExploreFrame.as:427-440`) | a captain is set else "É necessário se escolher um líder para desafiar o boss" | battle start (battleType 3884); after the battle 4579 with the drop and 4578 with new `passChapterId/passNodeId`, `bossCount` |
| M6 | 6 BOSS_MOPUP | sweep frame (`ME/MonsterSweepFrame.as:194-208`) | remaining `10 - bossCount > 0` else "Todos os ganhos do desafio com o BOSS de hoje já foram usados"; node already beaten (`canMopup`, `MonsterExploreNodeDetailView.as:192-199`); count 1..remaining | 4579 with the merged drop (opens the reward frame), 4578 `bossCount + quickNum` |

## 4. Server messages (server to client)

Receivers in `MEM:53-189` (listeners `MEM:55-59`).

### 4576 (0x11e0) `U_C_MONSTER_EXPLORE_EDIT_DATA`

`MonsterExploreEditListMsg`: `curEdits` (#1, MESSAGE `MonsterExploreEditMsg`, repeated). Replaces `formationDic` and `exploreMonsterDic` (`MEM:62-83`). When: reply to op 0 and op 2.

### 4577 (0x11e1) `U_C_MONSTER_EXPLORE_FIGHT_DATA`

`MonsterExploreFightMsg`: `state` (#1, INT32) 0 wait, 1 walk, 2 fight, 3 fight over; `stateTime` (#2, INT32) ms elapsed in the state (client `/1000`; walk lasts 10 s, `MonsterExploreModel.WALK_TOTAL_TIME`); `attackers` (#3, `MonsterExploreHeroMsg`, repeated) the beasts; `defender` (#4, `MonsterExploreHeroMsg`, repeated) the wave; `isEditSwitch` (#5, BOOL) a formation change is pending until the next wave (animation). `MonsterExploreHeroMsg`: `index` (#1, INT32) slot; `templateId` (#2, INT32) beast or pawn template; `name` (#3, STRING); `isMonster` (#4, BOOL) true for the player's beasts; `curHp` (#5, INT32); `maxHp` (#6, INT32); `damages` (#7, INT32, repeated) hp changes to animate. Handler `MEM:85-124`. When: each state change while the panel is open (assumption: wait -> walk 10 s -> fight -> over -> wait).

### 4578 (0x11e2) `U_C_MONSTER_EXPLORE_USER_DATA`

`MonsterExploreUserMsg`: `curChapterId` (#1), `curNodeId` (#2) current node; `passChapterId` (#3), `passNodeId` (#4) furthest beaten boss; `isNodeSwitch` (#5, BOOL) node change pending; `isEditSwitch` (#6, BOOL) formation change pending; `fastTotalCount` (#7) bonus minutes from fast fights; `fastUseCount` (#8) fast fights today; `bossCount` (#9) boss rewards used today; all INT32 except the BOOLs. Applied only when present (`MEM:135-177`). Sweep and drop buttons hide when the current node is 0 (`ME/MonsterExploreFrame.as:351-362`).

### 4579 (0x11e3) `U_C_MONSTER_EXPLORE_BOSS_REWARD`

`MonsterExploreDropItemMsg`: `items` (#1, STRING) `"itemId,count|itemId,count"`. Stored in `bossWinReward`, notifies `MOPUP_BOSS_INFO`, which opens the reward frame (`MEM:126-133`, `ME/MonsterExploreFrame.as:278-282`). After a boss battle the scene return code opens the reward frame when `bossWinReward != null`.

### 4580 (0x11e4) `U_C_MONSTER_EXPLORE_EXP`

`MonsterExploreExpMsg`: `type` (#1, INT32) 0 minute exp of the node (shows "+N EXP"), 1 fight exp for living beasts; `exp` (#2, INT32); `indexs` (#3, INT32, repeated) beast slots that leveled up (level up effect at state 3). Handler `MEM:179-189`.

Related: beast level/exp changes go through the monsters feature push (`MONSTER_INFO_CHANGE`), gold through player info 3.

## 5. Rules and formulas

- Unlock: `VersionSwitch.MONSTER_EXPLORE` (false in this build); hero level >= 70; task 1936 completed ("Primeiro complete a missão: {0}") (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2581-2608`). First time gift beast template `monster_explore_present = 101`.
- Team: up to 3 beasts from `MonsterModel.showMonsterList`; one captain required for boss fights (`decompiled/core_module/scripts/mvc/module/monsterexplore/MonsterExploreModel.as:143-153`).
- Idle gains: `MinuteGold`, `MinuteExp` per minute (online and offline); per defeated wave `NpcGold`, `NpcExp` (assumption on the split).
- Fast fight (`monster_explore_fast_config = 10,120,100`): 10 per day, `120 + fastTotalCount` minutes of gains, 100 diamonds; daily reset at midnight (help text).
- Boss: battleType 3884 (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:449-452`), map `FightMapPath`; drop `BossDrop` -> `MonsterExploreDrop.xml` rows; win sets `pass = (chapter, node)` when it was the frontier.
- Daily boss reward cap 10 (`monster_explore_boss_max_count`) shared by boss wins and sweeps.
- Node unlocking is linear inside a chapter; the next chapter opens after its last node (40 nodes in chapter 4, 35 in others).

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/MonsterExploreTemplates.xml` (`monsterExploreTemplateCate.getTemplateByChapterAndNode`), 145 rows | `ChapterId` 1..4, `ChapterName`, `NodeId`, `NodeName`, `PosX/PosY` node position, `ChapterMapPath` chapter background (`images/monsterexplore/{id}.jpg`), `NodeMapPath` node icon, `FightMapPath` battle map and music, `MusicPath`, `MinuteGold` 10.., `MinuteExp` 20.., `NpcGold`, `NpcExp` 5..20, `BossGold`, `BossExp` (0), `BossDrop` drop id |
| `raw/xml/tempinfos/MonsterExploreDrop.xml` (`monsterExploreDropTempCate.getTemplatesByDropId`), 1015 rows | `DropId`, `ItemId`, `Count`, `IsBind`, `ValidDate` |
| `ConfigInfos.xml` | `monster_explore_fast_config`, `monster_explore_present`, `monster_explore_boss_max_count` |

## 7. Persistent state

Schema `exploration`.

```sql
CREATE TABLE exploration.monster_explore_state (
  player_id            INTEGER     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  cur_chapter_id       SMALLINT    NOT NULL DEFAULT 1,
  cur_node_id          SMALLINT    NOT NULL DEFAULT 1,
  pass_chapter_id      SMALLINT    NOT NULL DEFAULT 0,
  pass_node_id         SMALLINT    NOT NULL DEFAULT 0,
  fast_bonus_minutes   INTEGER     NOT NULL DEFAULT 0,
  day                  DATE        NOT NULL,
  fast_used_today      SMALLINT    NOT NULL DEFAULT 0,
  boss_rewards_today   SMALLINT    NOT NULL DEFAULT 0,
  last_settled_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE exploration.monster_explore_slot (
  player_id    INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot         SMALLINT NOT NULL CHECK (slot BETWEEN 1 AND 3),
  monster_id   INTEGER  NOT NULL,
  fight_pos    SMALLINT NOT NULL CHECK (fight_pos IN (1, 3, 4, 6, 7, 9, 10, 12)),
  is_captain   BOOLEAN  NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, slot),
  UNIQUE (player_id, monster_id)
);
CREATE UNIQUE INDEX monster_explore_one_captain ON exploration.monster_explore_slot (player_id) WHERE is_captain;
```

`monster_id` references the beast instance table of [monsters](../monsters/README.md).

## 8. Backend implementation notes

- `exploration::monster_explore::handle_op` (8653) dispatching to `handle_open`, `handle_close`, `handle_edit`, `handle_select_node`, `handle_fast_fight`, `handle_boss_fight`, `handle_mopup`.
- Idle settlement `settle(player, now)`: minutes since `last_settled_at` x node minute gains, plus simulated waves; grant gold and exp to the beasts; called on open, node change, formation change, login and a periodic job. Fast fight calls the same settlement with `120 + fast_bonus_minutes` minutes.
- While the panel is open, a per player ticker emits 4577 state transitions and 4580 exp (cosmetic simulation; results must match the settlement).
- Boss fight: build battle battleType 3884, map `FightMapPath`, attackers = the 3 beasts (captain as leader), defenders = node boss (template not in the client; open question). On win: if node is the frontier update `pass_*`; if `boss_rewards_today < 10` roll `BossDrop`, increment and push 4579.
- Mop up: node beaten, `quickNum <= 10 - boss_rewards_today` -> roll `BossDrop` `quickNum` times, merge, push 4579 and 4578.
- Daily reset at midnight: `fast_used_today = 0`, `boss_rewards_today = 0`.

## 9. Open questions and assumptions

- Boss and wave unit composition (pawn templates) are not in client data.
- Exact streaming cadence of 4577 and whether it is needed while the panel is closed (assumed not).
- Whether `NpcGold/NpcExp` are per wave and how many waves per minute.
- Feature is switched off in this build; confirm whether to enable.

## 10. Implementation checklist

- [ ] Screen: `MonsterExploreFrame` and battle animation
- [ ] Screen: chapter map, node detail, sweep frame
- [ ] Screen: formation frame
- [ ] Screen: fast fight, win reward
- [ ] Route M0 op 0 open, M1 op 1 close
- [ ] Route M2 op 2 formation
- [ ] Route M3 op 3 select node
- [ ] Route M4 op 4 fast fight
- [ ] Route M5 op 5 boss battle (battleType 3884)
- [ ] Route M6 op 6 sweep
- [ ] Server messages 4576, 4577, 4578, 4579, 4580
- [ ] Tables `exploration.monster_explore_state`, `exploration.monster_explore_slot`
- [ ] Template loaders `MonsterExploreTemplates.xml`, `MonsterExploreDrop.xml`
- [ ] Idle settlement job and daily reset
- [ ] Test: node unlock rule and boss reward cap
