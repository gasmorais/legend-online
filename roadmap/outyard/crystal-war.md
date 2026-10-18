# Central crystal war ("Luta da Terrálem", stack head)

Feature [outyard](README.md), module `crystal-war`. Aliases in [README.md](README.md).

## 1. Overview

- During crystal sessions ([season.md](season.md): Monday, Wednesday, Friday, 4 sessions of 30 minutes) the 4 forces of a battlefield fight over the central crystal. Each force has a score and a defence army made of its members ("Grupo de Guarniação"; each member is one defence team) plus 4 senior generals ("quatro generais") chosen by the force.
- Blessings ("Bênção"): attack blessing (+1 % attack per level, costs 50 action points, adds 1000 score) and garrison blessing (+1 % defence per level, costs 30 action points, adds 800 score), each capped at 500 levels per force. During the preparation phase (state 2) only garrison blessings are allowed, at most 5 per player.
- Attack ("Atacar"): a player attacks another force (60 action points) and fights one of its living defence teams (battleType 3855). A win loots 2 % of the target's score (minimum 200), weakens the defeated defence team (5 % per defeat, up to 10 layers) and kills it; killing a senior general multiplies the score by 2, 3, 4 or 5 (by general index).
- Weak union: when a force reaches 50000 points it is "strong" and the other forces get +100 % score ("O jogador {0} é muito forte, as outras guildas atacaram pela última vez...").
- Action points ("pontos de movimento"): cap and regeneration per hour by level band (`stack_head_action_point = 100,20|300,50|600,100`: level 1..79, level 80 without class, level 80 with class). Refill to the cap for 100 diamonds (`stack_head_charge_point`).
- Event "Dia de Saqueamento de Cristais" (active type 1) reduces action point costs to `effect` % (`OutyardModel.getActiveRateByType(1)`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OY/OutyardFrame.as` (853 x 645) | "Luta da Terrálem"; "Bênção, tempo de entrada", "Tempo de Guarnição"; "Ainda faltam {0}min para a próxima batalha", "Luta em processo", "Luta do dia encerrada"; "Limite {0}, o sistema a cada 1h irá recuperar {1} pontos de movimento..." | 4 force cards ranked by score, own attack/defence bonus, action points with "+" refill, shop and member buttons; sends 9594 op 1 and 9599 op 1 on open, 9599 op 2 every 20 s (`:91-374`) | crystal node "Entrar" in the map (`OY/scene/OutyardInfoView.as:230-248`), calendar, after a 3855 battle (`decompiled/m3/scripts/map/space/SpaceSceneController.as:280-288`) | 308, 311, 306 |
| `OY/OutyardActorView.as` | "Equipes restantes {0}", "Pontos {0}", buttons "Bênção" / "Atacar" | Force card: rank, name, defence teams alive, score; bless on own force, attack on others (`:83-120`) | crystal frame | `OutyardForceInfo` |
| `OY/OutyardFigureView.as`, `OY/OutyardFigureItem.as` | | 12 attack arrows between forces with live counts (`OutyardFigureView.as:63-120`) | crystal frame | `attackList` |
| `OY/OutyardOpeningView.as`, `OY/OutyardOpeningItem.as` | | Today's session times (`OutyardOpeningView.as:57-74`) | crystal frame | 306 `stackHeadOpenTime` |
| `OY/OutyardBlessFrame.as` (542 x 484) | "Grupo de Guarniação"; "(Consumir pontos de movimento {0})"; "Ao salvar poderá efetuar bênção {0} vez(es)" | Attack and garrison blessing buttons (`:66-245`) | "Bênção" (openType 2) | own force buff levels, `readyBuffCount`, action points |
| `OY/OutyardMemberFrame.as`, `OY/OutyardMemberItem.as` (569 x 543) | "Grupo de Guarniação"; columns "Profissão", "Jogador", "Nível", "Poder Total", "Estado" ("Em guarnição" / "Foi repelido"); senior tab "Adição extra de Guarniação", "Renomear" | Defence team list and the 4 senior generals with their bonus 50/100/150/200 %; sends op 7 on open (`OutyardMemberFrame.as:66-217`, `OutyardMemberItem.as:126-200`) | crystal frame members button (openType 1) | 309 lists |
| `OY/OutyardChangeFrame.as`, `OY/OutyardChangeView.as`, `OY/OutyardChangeItem.as` (480 x 500) | "Lista de Participantes" | Pick the member for the selected senior slot (op 8) (`OutyardChangeItem.as:117-128`) | senior slot "Renomear" | members |
| `decompiled/m10/scripts/battle/view/ui/OutyardShowView.as` | "Equipe restante {0}", "Poder de guarnição reduz {0}%" | Battle overlay: target defence progress, debuff, senior generals alive/in battle (`:104-139`) | battle 3855 | 310 |
| `OY/OutyardNoticeView.as` | | Force notice editor (120 chars), sends 9594 op 6 ([land-map.md](land-map.md)) (`:85-93`) | crystal frame | force notice |

## 3. Routes (client to server)

Send 9599 (0x257f) `C_STACK_HEAD_REQUEST`, `StackHeadRequestMsg` (package `hugehead`): `op` (#1, INT32); `forceIndex` (#2, INT32); `seniorGeneral` (#3, MESSAGE `StackHeadSeniorGeneralMsg`: `userUid` #1 STRING, `index` #2 INT32 slot 1..4, `alive` #3 BOOL, `inBattle` #4 BOOL); `userUid` (#4, STRING); `battleFieldUid` (#5, STRING). Sender `OutyardManager.OperateOutyard(op, forceIndex, unused, seniorGeneral)` (`OM:304-312`). Op constants `OMOD/OutyardCrystalModel.as:23-45`: 1 OPEN_FRAME, 2 HEART, 3 CLOSE_FRAME, 4 DEFENCE_BUFF, 5 ATTACK_BUFF, 6 ATTACK, 7 REQUEST_LIST, 8 SET_SENIOR, 9 CHANGE_NOTICE, 10 BUY_EXECUTION, 11 ENTER, 12 CRYSTAL (push op).

| # | op | UI and sender | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| C1 | 1 open | crystal frame (`OY/OutyardFrame.as:97`) | | | 308 `op = 1` full, 311 self, 306 |
| C2 | 2 heart | every 20 s (`OY/OutyardFrame.as:185-187`, `:219-223`) | | | 308 `op = 12` deltas, 311 |
| C3 | 4 garrison blessing | `OY/OutyardBlessFrame.as:174-190` | `defenceBuffLevel < 500` else "Bênção de Guarnição atingiu o limite"; state 2: action points >= 30 and `readyBuffCount < 5` ("Nº de guarnições esgotadas..."); state 3: action points >= `ceil(30 x rate / 100)`; state 4 "Contabilizando..."; state 5 "Encerrado..."; client optimistic +1 | | 308 `op = 12`, 311 |
| C4 | 5 attack blessing | `OY/OutyardBlessFrame.as:156-172` | `attackBuffLevel < 500` else "Bênção de Ataque atingiu o limite"; state 2 -> "Em guarnição, não pode efetuar bênção"; state 3 action points >= `ceil(50 x rate / 100)`; states 4, 5 as above | | 308, 311 |
| C5 | 6 attack | force card "Atacar" (`OY/OutyardActorView.as:106-120`) | 1 s debounce; `stackHeadState == 3` else "Se não tiver dentro do tempo de luta não poderá atacar outras guildas" | `forceIndex` target | battle start (battleType 3855) with 310 during the battle; after: 308 `op = 12` with `attackList` deltas, 311 |
| C6 | 7 member list | member frame open (`OY/OutyardMemberFrame.as:72`) | | | 309 `op = 7` (possibly several pages `current/total`), 309 `op = 8` senior list |
| C7 | 8 set senior general | change list item (`OY/OutyardChangeItem.as:117-128`) | none client side (server: chairman or right) | `seniorGeneral {userUid, index}` | 309 `op = 8` |
| C8 | 10 buy action points | "+" (`OY/OutyardFrame.as:237-269`, `OY/scene/OutyardInfoTopView.as:194-250`) | `actionPoint < cap` else "Pontos de movimento atingiram o limite, não é possível comprar"; `point >= 100`; confirm "Deseja consumir {0} diamantes para recuperar {1} pontos de movimento?" | | 311, player info 3 |

Ops 3, 9, 11 have no client sender in this build (notice uses 9594 op 6).

## 4. Server messages (server to client)

Receivers `OMOD/OutyardCrystalModel.as` via `OM:118-158`.

### 308 (0x0134) `U_C_STACK_HEAD_UPDATE`

`StackHeadBattleFieldMsg`: `op` (#1, INT32) 1 full (opens the frame, `OUTYARD_OPEN_FRAME`) or 12 delta (`OUTYARD_UPDATE_INFO`); `forceList` (#2, `StackHeadForceMsg`, repeated: `forceIndex` #1, `score` #2, `attackBuffLevel` #3, `defenceBuffLevel` #4, `defenceAliveCount` #5, `defenceTotalCount` #6 (INT32), `defenceSeniorGeneral` #7 `StackHeadSeniorGeneralMsg` repeated, `userList` #8 `StackHeadUserMsg` repeated: `userUid` #1, `alive` #2 BOOL, `guildUid` #3); `attackList` (#3, `StackHeadAttackMsg`, repeated: `fromPos` #1, `toPos` #2, `totalCount` #3, `changeCount` #4) attacks between forces; `battleFieldUid` (#4, STRING); `weekUnionStrongForce` (#5, INT32) strong force index (0 none). Handler `crystalHandler` (`OutyardCrystalModel.as:69-153`); the client builds the 12 directed pairs 1..4 x 1..4 and matches `fromPos_toPos`.

### 309 (0x0135) `U_C_STACK_HEAD_USER_LIST`

`StackHeadForceUserListMsg`: `op` (#1, INT32) 7 member page or 8 senior list; `current` (#2, INT32) page; `total` (#3, INT32) pages; `guild` (#4, `HugeHeadGuildMsg`: `battleFieldUid` #1, `forceIndex` #2, `guildUid` #3, `site` #4, `serverName` #5, `guildName` #6, `totalFightCapacity` #7 INT64, `userList` #8 `HugeHeadUserMsg` repeated: `userUid` #1, `nickName` #2, `stackHeadAlive` #3 BOOL, `stackHeadDebuffLevel` #4, `fightCapacity` #5, `grade` #6, `firstChangeGrade` #7, `secondChangeGrade` #8, `changeBranch` #9, `job` #10, `userid` #11); `seniorGeneralUser` (#5, `StackHeadSeniorGeneralMsg`, repeated). Handler `userlistHandler` (`OutyardCrystalModel.as:155-216`): op 7 appends members, op 8 rebuilds the 4 seniors from the member list.

### 310 (0x0136) `U_C_STACK_HEAD_BATTLE_DEFENCE`

`StackHeadBattleDefenceMsg`: `defenceArmyAlive` (#1, INT32); `defenceArmyTotal` (#2, INT32); `defenceProperty` (#3, INT32) remaining defence percent; `defenceSeniorGeneral` (#4, repeated). Handler `battleDefenceHandler` (`OutyardCrystalModel.as:218-222`) -> battle overlay. When: at battle start and on changes during a 3855 battle.

### 311 (0x0137) `U_C_STACK_HEAD_SELF`

`StackHeadSelfMsg`: `uid` (#1, STRING) user uid; `actionPoint` (#2, INT32); `readyBuffCount` (#3, INT32) preparation blessings used. Handler `selfInfoHandler` (`OutyardCrystalModel.as:224-228`).

## 5. Rules and formulas

| Key | Value | Meaning |
|---|---|---|
| `stack_head_action_point` | `100,20\|300,50\|600,100` | cap, regen per hour by level band |
| `stack_head_charge_point` | 100 | diamonds to refill |
| `stack_head_attack_action_point` | 60 | action points per attack |
| `stack_head_attack_buff` | `50,1,500,1000` | cost, % per level, max levels, score |
| `stack_head_defence_buff` | `30,1,500,800` | cost, % per level, max levels, score |
| `stack_head_ready_buff_max` | 5 | blessings per player during preparation |
| `stack_head_senior_general_buff` | `50,100,150,200` | extra defence % of senior slots 1..4 |
| `stack_head_kill_senior_general_extra_score` | `2,3,4,5` | score multiplier for killing senior 1..4 |
| `stack_head_defence_debuff` | `5,10` | % weakening per defeat, max layers |
| `stack_head_win_score` | `2,200` | % of target score looted, minimum |
| `stack_head_week_union` | `50000,100` | strong force threshold, weak forces bonus % |
| `stack_head_defence_npc` | 240000 | NPC hero used when a force has no defence team |

- Costs scale with the active rate: `ceil(cost x rate / 100)` (`OY/OutyardBlessFrame.as:145-149`, `:226-234`).
- Session end: forces ranked by score; rewards per session and an extra reward for the last session (help text `desTxt4`); reward tables not in client data.

## 6. Templates

Config keys above (`CFG` getters `getStackHead*`).

## 7. Persistent state

```sql
CREATE TABLE outyard.crystal_force (
  battlefield_uid   TEXT     NOT NULL REFERENCES outyard.battlefield(battlefield_uid) ON DELETE CASCADE,
  force_index       SMALLINT NOT NULL CHECK (force_index BETWEEN 1 AND 4),
  session_date      DATE     NOT NULL,
  score             INTEGER  NOT NULL DEFAULT 0,
  attack_buff_level SMALLINT NOT NULL DEFAULT 0 CHECK (attack_buff_level BETWEEN 0 AND 500),
  defence_buff_level SMALLINT NOT NULL DEFAULT 0 CHECK (defence_buff_level BETWEEN 0 AND 500),
  PRIMARY KEY (battlefield_uid, force_index, session_date)
);

CREATE TABLE outyard.crystal_senior (
  battlefield_uid TEXT     NOT NULL,
  force_index     SMALLINT NOT NULL,
  slot            SMALLINT NOT NULL CHECK (slot BETWEEN 1 AND 4),
  user_uid        TEXT     NOT NULL,
  PRIMARY KEY (battlefield_uid, force_index, slot)
);

CREATE TABLE outyard.crystal_member (
  user_uid        TEXT     PRIMARY KEY,
  player_id       INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  battlefield_uid TEXT     NOT NULL,
  force_index     SMALLINT NOT NULL,
  alive           BOOLEAN  NOT NULL DEFAULT true,
  debuff_level    SMALLINT NOT NULL DEFAULT 0 CHECK (debuff_level BETWEEN 0 AND 10),
  action_points   SMALLINT NOT NULL DEFAULT 0,
  ap_updated_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
  ready_buffs     SMALLINT NOT NULL DEFAULT 0
);

CREATE TABLE outyard.crystal_attack_stat (
  battlefield_uid TEXT     NOT NULL,
  from_force      SMALLINT NOT NULL,
  to_force        SMALLINT NOT NULL,
  total_count     INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (battlefield_uid, from_force, to_force)
);
```

## 8. Backend implementation notes

- `outyard::crystal_war::handle_request` (9599) dispatching ops 1, 2, 4, 5, 6, 7, 8, 10.
- Action points: lazy regeneration from `ap_updated_at` at the band rate, capped.
- Blessing: validate state and limits (section 3), deduct action points, increment force level, add score (1000 or 800), broadcast 308 `op = 12` to the battlefield's online members.
- Attack: state 3, target force != own, action points >= 60 x rate -> pick a living defence team of the target (senior generals last, assumption) or the NPC 240000 -> battle 3855 with attacker buff vs defender buff and the defender's debuff; on win loot score, increment debuff, mark dead, update attack stats, broadcast 308.
- Senior general: sender is chairman (or right 46, assumption) of a guild of the force; user belongs to the force.
- Session settlement in the season scheduler: ranks, rewards (mail), reset buffs and teams for the next session.

## 9. Open questions and assumptions

- Defence team selection order and senior generals' extra HP formula.
- Who can set senior generals.
- Session rewards and the final session bonus.
- Whether action points persist between days.

## 10. Implementation checklist

- [ ] Screens: crystal frame, force cards, arrows, opening times, bless frame, member frame, change frame, battle overlay
- [ ] Routes C1..C8 on 9599
- [ ] Server messages 308, 309, 310, 311
- [ ] Tables `outyard.crystal_force`, `crystal_senior`, `crystal_member`, `crystal_attack_stat`
- [ ] Battle 3855 with buffs and debuffs
- [ ] Action point regeneration
- [ ] Test: preparation phase allows only garrison blessings (max 5)
