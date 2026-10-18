# Achievements ("Histórico de Conquistas")

Feature `medals`, module `achievements`. Proto package `achievementtask` (responses) plus `player.PlayerOpMsg` (requests). Client code lives in the hero road package: `CM/yishi/manager/HeroRoadManager.as` and `m11/scripts/heroroad/HeroRoadAchievement*.as`. The limited-time gift packages attached to some achievements are in [achievement-gifts.md](achievement-gifts.md); they share the same opcodes.

Conventions: see [README.md](README.md). `CM` = `core_module/scripts`.

---

## 1. Overview

- 436 permanent achievements (`AchievementTaskTemplates.xml`, ids 100001..830006) in three categories (`Classify`): 1 character growth (359), 2 dungeons and PvE (55), 3 competitive (22).
- Each achievement has a condition (`ConditionType` + `ConditionParm1/2/3`) that the **server** evaluates from events of other features. The client only displays `data / ConditionParm2`.
- Most achievements form chains (`PreAchievementId`, 326 of 436 have a predecessor), for example maze floors 10 → 30 → 50 → 80 → 100.
- When completed, the player presses "Coletar" to receive `Rewards` (items). Rewarded achievements stay listed, greyed, at the end.
- The achievement tab is the second tab of the hero road frame; with `VersionSwitch.ACHIEVEMENT = true` (`CM/yishi/datas/VersionSwitch.as:218`) the frame title becomes "Histórico de Conquistas" and the achievement tab is selected by default (`m11/scripts/heroroad/HeroRoadFrame.as:55-61`).
- The manager is created at login (`HeroRoadManager.setup`, `CM/yishi/lunch/Yishi.as:469`), so 4288 and 4289 are processed even while the frame is closed.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `heroroad.HeroRoadFrame` (`m11/scripts/heroroad/HeroRoadFrame.as`), 950x615, controller `heroroad` openType null (`CM/mvc/controler/HeroRoadControler.as:32-43`) | "Histórico de Conquistas" (`heroroad.HeroRoadFrame.titleText2`) | Two tabs: `btn1` hero road ("Histórico", roads feature) and `btn2` achievements | Queue bar `heroRoadBtn2` (level >= 11, `CM/ui/queuebar/QueueBar.as:1019-1025, 731-735`) | Tab content |
| `heroroad.HeroRoadAchievementView` (`m11/scripts/heroroad/HeroRoadAchievementView.as`) | none (tab) | Achievement list with 4 filter buttons and a scroll panel | Tab `btn2` (`HeroRoadFrame.as:111-124`) | Filter 0 `heroroad.allAchievementBtn` all; 1 `roleAchievementBtn` Classify 1; 2 `transcriptAchievementBtn` Classify 2; 3 `competitiveAchievementBtn` Classify 3 (`:59-76, 228-240`). Order: completed not rewarded, then in progress, then rewarded, each sorted by templateId (`CM/yishi/manager/HeroRoadManager.as:263-279, 425-493`). First 30 rows are created, the rest appended after (`:79-150`) |
| `heroroad.HeroRoadAchievementItemView` (`m11/scripts/heroroad/HeroRoadAchievementItemView.as`) | none (row) | One achievement | List | `ConditionTitle` (HTML), "(data/ConditionParm2)", reward icons parsed from `Rewards` "tid,count\|tid,count" (`:96-152`); state: `notAchieve` image when not completed, `getBtn` when completed and not rewarded, disabled `hasGetBtn` when rewarded (`:78-95`) |

---

## 3. Routes (client to server)

Opcode: client → server **8671 (0x21df) C_ACHIEVEMENT_TASK_CLIENT_OP**. Body: `player.PlayerOpMsg` (not an `achievementtask` message). Only the fields below are written; `writeToBuffer` skips unset fields (`build/as3/gen/com/road/yishi/proto/player/PlayerOpMsg.ts:308-350`).

| Field | Tag | Type | Repeated | Meaning |
|---|---|---|---|---|
| `op` | #1 | INT32 | no | 1 open (`OP_OPEN`), 2 claim reward (`OP_REWARD`), 3 gift frame shown (`OP_POP_BUY`), 4 buy gift (`OP_BUY`) (`HeroRoadManager.as:48-54`) |
| `templateId` | #8 | INT32 | no | Achievement template id (ops 2, 3, 4) |

All other `PlayerOpMsg` fields (`type #2`, `payType #3`, `count #4`, `id #5`, `index #6`, `userId #7`, `campaignId #9`, `nodeId #10`, `chapterId #11`, `uuid #12`, `value1 #13`, `value2 #14`, `param1 #15`, `param2 #16`, `flag1 #17`, `flag2 #18`, `pos #19`, `ids #20 repeated`) are unused here.

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| A1 | Opening the achievement tab (also every time the tab is re-created) | `HeroRoadAchievementView()` constructor (`m11/scripts/heroroad/HeroRoadAchievementView.as:45-51`) → `HeroRoadManager.achivementOpenFrame` (`CM/yishi/manager/HeroRoadManager.as:384-390`) | none | `{op=1}` | **4288** with the full `tasks` list; `templateId`/`leftSecond` set only if a gift offer is running (see [achievement-gifts.md](achievement-gifts.md)) |
| A2 | "Coletar" `heroRoadAchievementItemView.getBtn` (visible only when `isCompleted && !isReward`) | `HeroRoadAchievementItemView._getBtnClickHandler` (`HeroRoadAchievementItemView.as:170-174`) → `achivementGetReward(templateId)` (`HeroRoadManager.as:392-399`) | none besides button visibility; no bag-space check | `{op=2, templateId}` | **4289** for that task with `isReward=true`; bag pushes for the items (inventory feature) |
| A3 | Filter buttons, scroll | client only (`HeroRoadAchievementView.as:228-240`) | none | none | none |
| A4 | Tab `btn1` | roads feature (opcode 9634) | none | none | none |
| (A5, A6) | ops 3 and 4 | see [achievement-gifts.md](achievement-gifts.md) | | | |

---

## 4. Server messages (server to client)

| Opcode | Name | Message, fields (tag, type) | Client receiver (file:line) | When to send | Client reaction |
|---|---|---|---|---|---|
| 4288 (0x10c0) | U_C_ACHIEVEMENT_TASK_DATA | `achievementtask.AchievementTaskListMsg`: `opType (#1, INT32)` not read; `templateId (#2, INT32)` id of the achievement whose gift offer is running, 0 if none; `leftSecond (#3, INT32)` remaining seconds of that offer; `tasks (#4, AchievementTaskMsg, repeated)` the list | `HeroRoadManager.__achievenmentDataList` (`CM/yishi/manager/HeroRoadManager.as:111, 143-194`) | Response to op 1; at login *(assumption, so that pending gifts can pop on scene entry)*; response to op 3 (gift part) | If `tasks` is non-empty: **replaces** the whole dictionary and the pop queue (tasks with `isPopout && isCompleted`), recomputes template `sort`. If `templateId > 0`: that task is moved to the head of the pop queue, `currentPopTemplateId`/`currentLeftSecond` set, queue bar pop button and countdown shown (`QueueBar.initHeroRoadBtn`, `setCountTime`). Fires `HEROROAD_ACHIEVEMENT_LIST_UPDATE` (list redraw unless the gift frame is open, `HeroRoadAchievementView.as:219-226`) |
| 4289 (0x10c1) | U_C_ACHIEVEMENT_TASK_UPDATE | `achievementtask.AchievementTaskMsg` (one task, see below) | `HeroRoadManager.__achievenmentUpdate` (`HeroRoadManager.as:112, 196-261`) | Push on every progress change of a visible task, on completion, after reward claim (op 2), after gift purchase or gift expiry (gift module), and when a successor task becomes visible *(assumption)* | Inserts or updates the task; adds it to the pop queue if `isPopout && isCompleted`; if the first queued task is poppable, the player is in the space or castle scene and nothing was popped yet (`count == 0`), opens the gift frame (`:253-258`); fires `HEROROAD_ACHIEVEMENT_ITEM_UPDATE` (rows refreshed in place, `HeroRoadAchievementView.as:166-217`; queue bar hides the pop button when the queue is empty, `QueueBar.as:696-702`) |
| bag pushes | inventory | items of `Rewards` | `GoodsManager` | After op 2 | none specific |

`AchievementTaskMsg` fields (`protocol/proto.json`, tags checked in `build/as3/gen/com/road/yishi/proto/achievementtask/AchievementTaskMsg.ts:91-111`):

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `templateId` | #1 | INT32 | `AchievementTaskTemplates.Id` |
| `data` | #2 | INT32 | Current progress, displayed against `ConditionParm2` |
| `isCompleted` | #3 | BOOL | Condition met |
| `isPopout` | #4 | BOOL | A gift offer is (still) attached to this completed achievement; must be false once bought or expired (gift module) |
| `isReward` | #5 | BOOL | Reward claimed |

Client states (`HeroRoadAchievementItemView.as:78-95`, `HeroRoadManager.as:263-279`):

| isCompleted | isReward | Row | Sort group |
|---|---|---|---|
| false | false | "não alcançado" image | 2 |
| true | false | "Coletar" button | 1 (top) |
| true | true | disabled collected button | 3 (bottom) |
| false | true | treated as collected (else branch) | 0, not listed by the filters (invalid state, never send) |

No error code exists: a refused claim simply produces no 4289. Use the generic message tip for errors *(assumption)*.

---

## 5. Rules and formulas

- **Visibility** *(assumption)*: the client lists whatever the server sends. Recommended: send every achievement whose `PreAchievementId` is 0 or whose predecessor is completed, so each chain shows its rewarded steps plus the current step.
- **Progress**: `data` is a counter (count conditions) or the best level reached (level conditions). `isCompleted` when `data >= ConditionParm2` (for 136, `ConditionParm2 = 1` and the quality target is `ConditionParm3`). Cap `data` at `ConditionParm2` *(assumption, the client prints it raw)*.
- **Level conditions must be back-filled**: when a task becomes visible, compute `data` from the current state of the source feature (for example equipment strengthen level), not from zero.
- **Count conditions**: count events from the moment the task becomes visible *(assumption; alternatively keep one lifetime counter per condition key and share it across the chain)*. Recommended: one lifetime counter per `(player, ConditionType, ConditionParm1, ConditionParm3)` so chain steps share progress.
- **Claim** (op 2): only if visible, `isCompleted && !isReward`. Grants each `tid,count` of `Rewards` (bind state *(assumption: bound)*), sets `isReward`.
- `IsPopout = 1` (214 rows) attaches a gift offer on completion: see [achievement-gifts.md](achievement-gifts.md).

Condition types (`ConditionType`, counts from `AchievementTaskTemplates.xml`; text is the first `ConditionTitle` of the type; owner features marked "to confirm" were not traced):

| Type | Rows | Classify | Parm1 | Parm2 range | Parm3 | Example title | Kind | Source feature |
|---|---|---|---|---|---|---|---|---|
| 101 | 11 | 2 | maze 1 Subterrâneo, 2 Abismo, 3 Purgatório | 10..100 floor | | "Concluir até o piso 10 do Labirinto Subterrâneo" | level | [../mazes/README.md](../mazes/README.md) |
| 102 | 18 | 2 | treasure quality 2 blue, 3 purple, 4 orange | 1..500 | | "Guilda Escavar 10 vezes o tesouro azul" | count | [../guild/README.md](../guild/README.md) (treasure) |
| 104 | 9 | 1 | 0 | 10..1000 | | "Escavar na Arqueologia ou Astrolábio 10 vezes" | count | [../archaeology/README.md](../archaeology/README.md), [../cosmos/README.md](../cosmos/README.md) |
| 105 | 7 | 1 | 0 | 5..300 | | "Colher recursos na fazenda ou pastagem 5 vezes" | count | [../farm/README.md](../farm/README.md) |
| 106 | 18 | 1 | slot 101 weapon, 103 helmet, 104 armor, 106 necklace, 107 any ring, 108 any ornament | 10..36 | | "Nv. de fortalecimento do equipamento (Arma) atingir 10" | level | [../smith/README.md](../smith/README.md) |
| 107 | 28 | 1 | mount 9001..9004 | 10..180 | | "Treinar a Montaria Nirvana Dourada ao nível 10" | level | [../mounts/README.md](../mounts/README.md) |
| 108 | 9 | 1 | quality 5 orange | 10..800 | | "Concluir 10 missões de recompensa Laranja" | count | [../quests/README.md](../quests/README.md) |
| 109 | 10 | 1 | 0 | 10..100 | | "Refinar qualquer parte da moda ao nível 10" | level | [../fashion/README.md](../fashion/README.md) |
| 110 | 12 | 1 | rune 2 Fúria, 3 Proteção, 8 Sangramento, 9 Restauração | 3..8 | | "Runa da Fúria atingir Nv. 3" | level | runes (to confirm) |
| 111 | 5 | 1 | 0 | 100..1200 | | "Concluir 100 Missões de Ciclo" | count | [../quests/README.md](../quests/README.md) |
| 112 | 6 | 1 | 1 stage, 2 heart level | 1..8 | | "Alma do Dragão atingir Alma do Dragão Filhote" | level | dragon soul (to confirm) |
| 113 | 10 | 1 | 30 common talent, 60 advanced talent | 10..179 | | "Dom Natural comum atingir Nv. 30" | level | [../skills/README.md](../skills/README.md) (to confirm) |
| 114 | 4 | 3 | 0 | 100000..100000000 | | "Dano acumulado no Chefão Global atingir 100.000" | count (damage sum) | [../world-boss/README.md](../world-boss/README.md) |
| 115 | 4 | 2 | 0 | 10..75 | | "Concluir fase da Expedição de Einherjar nr. 10" | level | [../einherjar/README.md](../einherjar/README.md) (to confirm) |
| 116 | 2 | 3 | 0 | 5..10 | | "Fazer 5 Sacrifícios do Plano" | count | [../planes/README.md](../planes/README.md) |
| 117 | 4 | 2 | 0 | 3..20 | | "Caminho do Céu atingir piso 3" | level | [../trials/README.md](../trials/README.md) |
| 118 | 4 | 1 | 0 | 10..300 | | "Concluir Guardiões Procurados 10 vezes" | count | [../guardians/README.md](../guardians/README.md) |
| 119 | 2 | 1 | 0 | 5..10 | | "Atingir Nv. 5 da Base Grande do Guardião" | level | guardians |
| 120 | 5 | 1 | 0 | 10..500 | | "Fazer exploração do Guardião 10 vezes" | count | guardians |
| 121 | 5 | 1 | 0 | 10..500 | | same title as 120 (second exploration kind, to confirm) | count | guardians |
| 122 | 4 | 3 | 0 | 10..500 | | "Em qualquer Arena do Guardião, vencer 10 vezes" | count | guardians |
| 123 | 4 | 1 | 0 | 3..12 | | "Atingir o Nv. 3 com qualquer Guardião" | level | guardians |
| 124 | 2 | 1 | 0 | 3..5 | | "Alcance o Nv. 3 em qualquer habilidade do Guardião" | level | guardians |
| 125 | 2 | 1 | 0 | 5..10 | | "Atingir o Nv. 5 em qualquer Emblema do Guardião" | level | guardians |
| 126 | 3 | 1 | 0 | 2..5 | | "Qualquer Nível de Estrelas de despertamento do Guardião atingir o Nv. 2" | level | guardians |
| 127 | 4 | 2 | chapter 3, 9, 20, 30 | 1 (stage) | | "Passar até o 3° capítulo do Continente dos Demônios, fase 1" | flag | [../trials/README.md](../trials/README.md) (demon land) |
| 128 | 4 | 2 | 0 | 100..3000 | | "Desafiar com sucesso qualquer fase do Continente dos Demônios 100 vezes" | count | trials |
| 129 | 5 | 2 | 0 | 30..500 | | "Desafiar com sucesso qualquer fase do Vórtice Temporal 30 vezes" | count | trials |
| 130 | 24 | 1 | divine weapon 100, 200, .. 1200 | 3..5 stars | | "Atingir 3 estrelas na Arma Divina Vladlak" | level | [../divine-weapon/README.md](../divine-weapon/README.md) |
| 131 | 8 | 1 | heraldry quality 2 blue .. 5 red | 3..6 distinct | | "Ter 3 brasões azuis diferentes" | count (distinct owned) | heraldry (to confirm) |
| 132 | 15 | 1 | heraldry quality 1 green .. 5 red | 2..5 | | "Qualquer Brasão verde atingir o Nv. 2" | level | heraldry (to confirm) |
| 133 | 2 | 1 | 0 | 3..5 | | "Fera de Combate do Encantador de Dragões atingir nv. 3" | level | [../dragon/README.md](../dragon/README.md) |
| 134 | 2 | 1 | 0 | 5..10 | | "Simbiose de qualquer parte do Encantador de Dragões atingir Nv. 5" | level | dragon |
| 135 | 20 | 1 | goddess 1 Magia, 2 Criação, 3 Esperança, 4 Destino, 5 Guerra | 30..150 | | "Deusa da Magia atingir 30" | level | [../goddess/README.md](../goddess/README.md) |
| 136 | 15 | 1 | goddess 1..5 | 1 | quality 3 purple, 4 orange, 5 red | "Qualidade da Deusa da Magia atingir roxo" | flag | goddess |
| 137 | 10 | 1 | goddess 1..5 | 3..5 | | "Deusa da Magia atingir oferenda Nv. 3" | level | goddess |
| 138 | 100 | 1 | goddess 1..5 | 30..240 | equipment 1 Coroa Radiante, 2 Vontade de Ferro, 3 Flor Milagrosa, 4 Colar da Benção | "Coroa Radiante da Deusa da Magia atingir nv. 30" | level | goddess |
| 139 | 7 | 3 | 0 | 2..50 | | "Participar 2 vezes da Liga do Pico" | count | [../casino/README.md](../casino/README.md) (apex) |
| 140 | 5 | 3 | 0 | 2..24 | | "Fazer 2 apostas da Liga do Pico" | count | casino (apex) |
| 141 | 5 | 2 | 0 | 10..500 | | "Desafiar e vencer Templo Eclíptico 10 vezes" | count | [../ecliptic-palace/README.md](../ecliptic-palace/README.md) |
| 142 | 5 | 1 | 0 | 1..20 | | "Buraco Mítico chegar ao nível 1" | level | to confirm |
| 143 | 5 | 1 | 0 | 1..20 | | "Armadura Demoníaca chegar ao nível 1" | level | to confirm |
| 147 | 6 | 1 | 0 | 2000..20000 | | "Armadura chegar a 2000 pontos" | level | to confirm |
| 148 | 6 | 1 | 0 | 20..120 | | "Núcleo de Tesouro chegar ao nível 20" | level | [../theseus/README.md](../theseus/README.md) (to confirm) |

Types 103 and 144..146 do not appear in the data.

---

## 6. Templates

| File | Record meaning | Fields used |
|---|---|---|
| `raw/xml/tempinfos/AchievementTaskTemplates.xml`, loaded as `AchievementTaskTemplates` (`CM/yishi/manager/TempleteManager.as:1350`), class `AchievementTaskTemplateInfo`, lookup by `@Id` (`CM/yishi/datas/templates/cate/AchievementTaskTemplateCate.as`) | One achievement | `Id`; `Classify` 1/2/3 tab; `ConditionTitle` HTML title; `PreAchievementId` predecessor (the client class field is spelled `PreAchievementID`, so this attribute is never mapped on the client, server only); `ConditionType`, `ConditionParm1`, `ConditionParm2` (target, shown as denominator), `ConditionParm3`; `Rewards` "tid,count\|..."; `IsPopout` 1 = gift offer on completion; `PackageName` gift package title |
| `raw/xml/tempinfos/ConfigInfos.xml` | Gift offer config | see [achievement-gifts.md](achievement-gifts.md) |

---

## 7. Persistent state (PostgreSQL, schema `medals`)

```sql
CREATE TABLE medals.achievement_tasks (
  player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   integer     NOT NULL,                 -- AchievementTaskTemplates.Id
  progress      integer     NOT NULL DEFAULT 0 CHECK (progress >= 0),
  completed_at  timestamptz,
  rewarded_at   timestamptz,
  created_at    timestamptz NOT NULL DEFAULT now(),
  updated_at    timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, template_id),
  CHECK (rewarded_at IS NULL OR completed_at IS NOT NULL)
);
CREATE INDEX achievement_tasks_open ON medals.achievement_tasks (player_id) WHERE completed_at IS NULL;

-- Shared lifetime counters for count-type conditions, keyed by condition, so chain steps share progress.
CREATE TABLE medals.achievement_counters (
  player_id       integer NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  condition_type  smallint NOT NULL,
  condition_parm1 integer  NOT NULL DEFAULT 0,
  condition_parm3 integer  NOT NULL DEFAULT 0,
  value           bigint   NOT NULL DEFAULT 0 CHECK (value >= 0),   -- bigint: type 114 reaches 100000000
  updated_at      timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, condition_type, condition_parm1, condition_parm3)
);
```

Rows in `achievement_tasks` exist only for visible tasks. `progress` is INT32 on the wire; clamp to `ConditionParm2` before sending.

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `medals::achievements::handle_open` | 8671 op 1 | none | Read only. Send 4288 `{tasks = all visible tasks, templateId/leftSecond = running gift offer or 0}` |
| `medals::achievements::handle_claim_reward` | 8671 op 2 | `templateId` exists in templates → row visible → `completed_at` set → `rewarded_at` null → bag space for all reward items (inventory) | One tx: set `rewarded_at`, grant items. After commit: 4289 `{isCompleted=true, isReward=true, isPopout = gift state}`, bag pushes. If the reward unlocks no new task nothing else; successors are already visible after completion |
| `medals::achievements::on_event` (internal, called by other features) | none | map event to `(condition_type, parm1, parm3)` | Update counter or level value; for every visible, not completed task matching the key, recompute `progress`; on `progress >= ConditionParm2` set `completed_at`, make successors visible (insert rows with back-filled progress), and if `IsPopout = 1` enqueue a gift offer (gift module). Push 4289 for every changed task to the online player |
| `medals::achievements::send_login` | login hook | none | 4288 full list (and the running gift offer, gift module) |

- Event bus: expose one function `medals::achievements::record(player_id, condition_type, parm1, parm3, value, mode)` where mode is `Add` (count) or `Max` (level). Each source feature calls it after its own commit (at-least-once; idempotence is not required for `Max`, keep `Add` inside the source transaction when possible).
- Back-fill on first deployment: create the root tasks of every chain for every player and compute level conditions from current state.
- Throttle 4289 pushes for high-frequency events (type 114 damage) to one per battle.
- No battle, no schedule (except the gift module), no push to other players.

---

## 9. Open questions and assumptions

- *(assumption)* Which tasks are sent (visibility through `PreAchievementId`); the client accepts any subset.
- *(assumption)* Count conditions share a lifetime counter across the chain; the original server may count per task.
- *(assumption)* 4288 at login. Without it, gift offers queued at login could not pop on scene entry (`SpaceSceneController.as:522-526` reads `popTaskInfo` on scene entry).
- Owners of conditions 110, 112, 113, 115, 131, 132, 142, 143, 147, 148 to confirm in their features.
- Types 120 and 121 have identical titles; their difference (probably two exploration modes) is unknown.
- `opType (#1)` of 4288 is never read.
- Reward bind state and validity are not in the template *(assumption: bound, permanent)*.
- No client-side bag-full check; the server must refuse or mail the overflow (inventory policy).

---

## 10. Implementation checklist

**Screens:**
- [ ] `HeroRoadFrame` achievement tab default when `ACHIEVEMENT` is on
- [ ] `HeroRoadAchievementView` filters (all, Classify 1, 2, 3) and ordering
- [ ] `HeroRoadAchievementItemView` three states and reward icons

**Routes:**
- [ ] 8671 op 1 open
- [ ] 8671 op 2 claim reward

**Server messages:**
- [ ] 4288 full list at login and on op 1
- [ ] 4289 on progress, completion, claim

**Tables:**
- [ ] `medals.achievement_tasks`
- [ ] `medals.achievement_counters`

**Rules:**
- [ ] Template loader `AchievementTaskTemplates`
- [ ] Chain visibility and back-fill
- [ ] `record()` hooks for each of the 44 condition types (one checkbox per source feature: mazes, guild treasure, archaeology/cosmos, farm, smith, mounts, quests, fashion, runes, dragon soul, talents, world boss, einherjar, planes, trials, guardians, divine weapon, heraldry, dragon talker, goddess, apex league, ecliptic palace, mythic hole, demonic armor, armor points, treasure core)
- [ ] Claim validation and item grant

**Tests:**
- [ ] Claim before completion, double claim, unknown id
- [ ] Level condition back-fill when a successor appears
- [ ] Count condition shared across a chain
- [ ] Type 114 large values (bigint counter, INT32 clamp on the wire)
- [ ] Filters and sort order with mixed states
