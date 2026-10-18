# Time Portal and Restricted Area boss ("Portal do Tempo", "Chefão da Área Restrita")

Feature [exploration](README.md), module `shuttle` (protobuf package `shuttle`; Chinese name 时空之门). The UI classes live in the `outyard` client package (`outyard.shuttle.*`) and are opened through the `outyard` controller, see [../outyard/README.md](../outyard/README.md). Aliases in [README.md](README.md).

## 1. Overview

- Einherjar PvE ladder. The player sets up to 3 Einherjars ([einherjar](../einherjar/README.md)) and one active fighter, picks a difficulty 1..4 and challenges 7 areas. Each area has a challenge limit (`MaxChallenge`) and pays "pontos do tempo" (`ShuttleScore`) on victory; a defeat costs nothing ("caso fracassar não descontará o número de desafios"). Einherjar HP persists between fights (`petHpPercent`).
- Points unlock 15 chests per difficulty ("baús do tempo", items 208062 and 208063).
- Resets: 2 free resets per week plus 2 paid resets at 2000 diamonds; each reset restores challenges, Einherjar HP and chests. Changing difficulty counts as a reset unless no chest was collected. Refresh ("atualizar o número e desafios restantes"): 10 per reset at 100 diamonds.
- Higher difficulties require Einherjar divine weapons ("Ativar {0} arma divina de einherjar"): difficulty N needs N - 1 hallows (`PetHallowsManager.hallowsInfoList`).
- Every challenge may spawn a "Chefão da Área Restrita" (Restricted Area boss) that escapes after `arcane_zone_boss_escape_time = 120` minutes. The finder can share it with friends; attacking costs one "Ordem da Área Restrita" (10 granted per week, up to 10 more bought at 100 diamonds, max 10 held). Its HP is shared (battle push 4462). Rewards are sent after the kill ("Após derrotar o chefão será enviado o prêmio").
- Weekly refresh Sunday 00:00 of reset counts (progress is kept).

## 2. Screens

Controller `outyard` (`decompiled/core_module/scripts/mvc/controler/OutyardControler.as:49-96`): openType 10 `OutyardShuttleFrame`, 6 `OutyardShuttleFightPetFrame`, 5 `OutyardArcaneFrame`. `SY` = `decompiled/m11/scripts/outyard/shuttle/`.

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SY/OutyardShuttleFrame.as` (1173 x 746) | help "Instruções"; "Todas os Domingos às 0h é atualizado o número de redefinições." | 4 difficulty tabs, 7 area cards, chest progress, pet list, reset/refresh/claim all, boss counter; sends op 1 on open (`:111-117`) | `SwitchPageHelp.openShuttleFrame` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2351-2363`): NPC node 41 "Walpoth, Portal do Tempo" dialog option 119 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:779-781`), daily guide 73, queue bar order 15 ("Portal do Tempo {0}/{1}"), link 222; after a shuttle battle (`decompiled/m3/scripts/map/space/SpaceSceneController.as:330-333`) | 4460 state (`:285-348`) |
| `SY/OutyardShuttleView.as` | | Older embedded variant with the same logic (`:340-378`) | | |
| `SY/OutyardLevelItem.as` | lock tip "Ativar {0} arma divina de einherjar" | Difficulty tab (`:72-141`) | frame | hallows count |
| `SY/OutyardShuttleItem.as` | "Clique par entrar na batalha" | Area card: score (+ Magic Spring buffer 16 bonus), challenges left (`:74-116`) | frame | `areaLeftCount[area]`, template |
| `SY/OutyardProgressView.as`, `SY/OutyardProgressChest.as` | "Pontos do tempo insuficientes, não é possível coletar.", "Este baú já foi coletado." | Chest track by score (`OutyardProgressView.as:82-216`, `OutyardProgressChest.as:65-129`) | frame | `shuttleScore`, `rewardState[]` |
| `SY/ShuttlePetHeadListView.as`, `SY/ShuttlePetHeadSelectView.as`, `SY/ShuttlePetHeadItemView.as`, `SY/ShuttlePetHeadSelectItemView.as` | | 3 Einherjar slots and selector (`ShuttlePetHeadListView.as:95-177`) | frame | `petList`, `petHpPercent` |
| `SY/OutyardShuttleFightPetFrame.as` (341 x 312) | "Einherjars em Combate"; "Favor selecionar Einherjars a entrar em combate." | Choose the active fighter among the 3 (`:42-175`) | "fight" button (openType 6) | `fightPet` |
| `SY/OutyardArcaneFrame.as` (753 x 602) | "Chefão da Área Restrita"; "Após derrotar o chefão será enviado o prêmio, favor convidar os seus amigos." | Paged boss list (3 per page), order counter, buy orders; sends 8476 op 1 on open (`:63-180`) | forbidden area icon (`SY/OutyardShuttleFrame.as:407-411`), openType 5 | 4451 |
| `SY/OutyardArcaneItem.as` | "Descobridor: {0}"; "Tempo restante de refúgio: {0}" | Boss card with avatar, HP bar, escape countdown, share (finder only) and attack (`:86-168`) | arcane frame | `ArcaneZoneBossMsg` |

## 3. Routes (client to server)

### Time Portal: 8475 (0x211b) `C_SHUTTLE_REQUEST`

`ShuttleRequestMsg`: `op` (#1, INT32); `petList` (#2, INT32, repeated) 3 Einherjar ids (0 empty; default `[0,0,0]`); `fightPet` (#3, INT32); `difficulty` (#4, INT32); `area` (#5, INT32) 1..7; `rewardIndex` (#6, INT32) chest index 0..14; `payType` (#7, INT32) default 1. Sender `OutyardManager.OperateShuttle(op, fightPet, difficulty, area, rewardIndex, petList, payType)` (`decompiled/core_module/scripts/yishi/manager/OutyardManager.as:324-336`).

| # | op | UI and sender | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| T1 | 1 open | frame open (`SY/OutyardShuttleFrame.as:116`) | hero has changed class ("Necessário atingir profissão cavaleiro para entrar", `isChangeJob`) | none | 4460 `op = 1` (client resets area indices) and 4451 |
| T2 | 2 set Einherjars | pick in the slot selector (`SY/ShuttlePetHeadListView.as:173-177`) | an Einherjar in a fight cannot be changed (help text, server rule) | `petList` | 4460 |
| T3 | 3 set fighter | select in `OutyardShuttleFightPetFrame` (`:134-145`) | pet in the list | `fightPet` | 4460 |
| T4 | 4 challenge area | area card click (`SY/OutyardShuttleItem.as:112-116`) | none client side | `area` | battle start (battleType 3864 or 3865, see rules); after battle 4460 with score, `areaLeftCount`, pet HP; possibly 4451 with a new boss |
| T5 | 5 change difficulty | difficulty tab (`SY/OutyardLevelItem.as:129-141` -> `decompiled/core_module/scripts/mvc/controler/OutyardControler.as:98-216`) | tab unlocked by hallows; confirm "Devido ao fato de não ter coletado o prêmio, esta troca de dificuldade não consumirá chances de redefinição." or "Esta troca de dificuldade consumirá 1 chance de redefinição."; when no free reset is left: reset limit and 2000 diamonds (`point`) with "Deseja consumir {0} diamantes para efetuar {1} redefinições?..." | `difficulty = N` | 4460 |
| T6 | 6 reset | reset button (`SY/OutyardShuttleFrame.as:350-354` -> `OutyardControler.refreshBtnClick(0)`) | same as T5; "Nº de redefinições atingiu o limite, não é possível comprar." when `resetCount >= free + paid max` | none | 4460 `op = 6` |
| T7 | 7 refresh | refresh button (`SY/OutyardShuttleFrame.as:356-393`) | `refreshCount < 10` else "Número de atualizações atingiu o limite, não é possível comprar"; confirm "Deseja consumir {0} diamantes para atualizar {1} vez(es) o número e desafios restantes?"; diamonds check | `payType = 2` bound first or `1` real only | 4460, player info 3 |
| T8 | 8 claim chest | chest click (`SY/OutyardProgressChest.as:95-109`) | `shuttleScore >= ShuttleScore`, not claimed | `rewardIndex = chest index` | 4460 with `rewardState[i] = true`, bag 115 |
| T9 | 9 claim all | "x-coleta dos prêmios de baú" (`SY/OutyardShuttleFrame.as:401-405`) | none | none | 4460, bag 115 |

### Restricted Area: 8476 (0x211c) `C_ARCANE_ZONE_REQUEST` and 15058 (0x3ad2) `CH_ARCANE_ZONE_SHARE`

`ArcaneZoneRequestMsg`: `op` (#1, INT32), `bossId` (#2, INT32). Senders `OutyardManager.OperateArcane` (`OutyardManager.as:338-345`) and `OperateArcaneShare` (`:347-354`, same message on 15058).

| # | opcode, op | UI | Client checks | Expected reply |
|---|---|---|---|---|
| A1 | 8476 op 1 list | arcane frame open (`SY/OutyardArcaneFrame.as:68`) | | 4451 `op = 1` with the boss list |
| A2 | 8476 op 3 attack | "attack" (`SY/OutyardArcaneItem.as:164-168`) | none client side (order count checked server side) | battle start with shared boss HP (4462 during battle); 4451 after |
| A3 | 8476 op 4 buy order | "+" (`SY/OutyardArcaneFrame.as:151-181`) | `arcaneZoneBuyCount < 10` else "Compra da Ordem da Área Restrita atingiu o limite"; `arcaneZoneCount < arcane_zone_max (10)`; confirm "Deseja consumir {0} diamantes para comprar {1} ordens da área restrita.?"; `point >= 100` | 4451 with counts, player info 3 |
| A4 | 15058 op 2 share | "share" (finder only, `SY/OutyardArcaneItem.as:158-162`) | `selfFound` | the boss becomes visible to the finder's friends (4451 `op = 5` to them, assumption) |

## 4. Server messages (server to client)

### 4460 (0x116c) `U_C_SHUTTLE`

`ShuttleInfoMsg`: `op` (#1, INT32) request op answered (1 triggers a full redraw); `currentDifficulty` (#2, INT32) 1..4; `petList` (#3, INT32, repeated) 3 Einherjar ids; `petHpPercent` (#4, INT32, repeated) HP % per slot; `fightPet` (#5, INT32); `areaLeftCount` (#6, INT32, repeated) challenges left indexed by area (the client reads indices 1..7, index 0 unused, `SY/OutyardShuttleFrame.as:307-313`); `rewardState` (#7, BOOL, repeated) one per chest of the difficulty; `arcaneZoneCount` (#8, INT32) orders held; `shuttleScore` (#9, INT32); `resetCount` (#10, INT32) resets used this week; `refreshCount` (#11, INT32) refreshes used since the last reset. Receivers `OutyardShuttleModel.shuttleHandler` (`decompiled/core_module/scripts/mvc/module/outyard/OutyardShuttleModel.as:23-48`, via `OutyardManager.as:189-195`) and `QueueBarManager.__shuttleHandler` (`decompiled/core_module/scripts/yishi/manager/QueueBarManager.as:350-364`, order 15 shows free resets left).

### 4451 (0x1163) `U_C_ARCANE_ZONE`

`ArcaneZoneMsg`: `op` (#1, INT32) 1 or 5 rebuild the list, others only refresh counters (`SY/OutyardArcaneFrame.as:138-149`); `bossList` (#2, `ArcaneZoneBossMsg`, repeated): `bossId` (#1, INT32) instance id; `heroTempId` (#2, INT32) boss hero template (appearance from `arcane_zone_boss_temp_id = 250000,2402`); `name` (#3, STRING) finder nickname; `escapeTime` (#4, INT64) epoch ms of escape; `selfFound` (#5, BOOL); `hpPercent` (#6, INT32); `arcaneZoneCount` (#3, INT32) orders held; `arcaneZoneBuyCount` (#4, INT32) orders bought this week. Receiver `OutyardShuttleModel.arcaneHandler` (`OutyardShuttleModel.as:50-61`).

### 4462 (0x116e) `U_C_ARCANE_ZONE_BOSS_HP_SYNC`

`simple.WorldBossInfoMsg` (`curHp` #1 INT64, `totalNum` #2, `campaignId` #3, `woundInfo` #4 repeated, `totalHp` #5 INT64, `myWound` #6 INT64, `grades` #7, `currentMillis` #8 INT64, `castleWound` #9 repeated, `bufferGrade` #10, `bossType` #11, `bossState` #12). Battle UI receiver `RoleShowViewII.__syncBossHpHandler` (`decompiled/m10/scripts/battle/view/ui/RoleShowViewII.as:220`, `:264-286`), forwarded in campaign scenes by `decompiled/core_module/scripts/proxy/scene/CampaignSocketDataProxy.as:63`. When: periodically during a Restricted Area boss battle, to every attacker.

`ArcaneZoneBossShareMsg` (`bossId` #1, `friendUseridList` #2 repeated) exists in the package but the client sends `ArcaneZoneRequestMsg` on 15058.

## 5. Rules and formulas

- Config: `shuttle_reset_free = 2`, `shuttle_reset = 2,2000` (paid resets, price), `shuttle_refresh = 10,100` (refreshes per reset, price), `arcane_zone_max = 10`, `arcane_zone_buy_count = 10,100`, `arcane_zone_boss_escape_time = 120`, `arcane_zone_recover_time = 0`, `arcane_zone_boss_temp_id = 250000,2402`.
- Areas (`ShuttleTempInfos.xml`): per difficulty 7 areas with `ShuttleScore` 10, 20, 30, 40, 50, 50, 50 and `MaxChallenge` 5, 3, 2, 2, 1, 1, 1 (difficulty 1 sample), enemy `HeroTempId` 2500xx.
- Chests (`ShuttleRewardTempInfos.xml`): 15 per difficulty at increasing `ShuttleScore`, items 208062 and 208063.
- Score bonus from Magic Spring buffer 16: `floor(AddValue x ShuttleScore / 100)` (`SY/OutyardShuttleItem.as:99-110`).
- Battle types 3864 and 3865 return to the shuttle frame (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:398-405`); assumption: 3864 area challenge, 3865 Restricted Area boss.
- Boss spawn chance per challenge and boss rewards are not in client data.
- Weekly reset Sunday 00:00: `resetCount = 0`, 10 orders granted (cap 10), buy count reset.

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/ShuttleTempInfos.xml` (`outyardShuttleTemplateCate`) | `TemplateId`, `Difficulty`, `Area`, `ShuttleScore`, `MaxChallenge`, `HeroTempId` |
| `raw/xml/tempinfos/ShuttleRewardTempInfos.xml` (`outyardShuttleRewardTemplateCate`) | `TemplateId`, `Difficulty`, `ShuttleScore`, `RewardItem` "id,count\|..." |
| `ConfigInfos.xml` | keys above |

## 7. Persistent state

```sql
CREATE TABLE exploration.shuttle_state (
  player_id          BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  difficulty         SMALLINT    NOT NULL DEFAULT 1 CHECK (difficulty BETWEEN 1 AND 4),
  pet_ids            INTEGER[]   NOT NULL DEFAULT '{0,0,0}',
  pet_hp_percent     SMALLINT[]  NOT NULL DEFAULT '{100,100,100}',
  fight_pet_id       INTEGER     NOT NULL DEFAULT 0,
  area_left          SMALLINT[]  NOT NULL,
  chests_claimed     BOOLEAN[]   NOT NULL,
  score              INTEGER     NOT NULL DEFAULT 0,
  week_start         DATE        NOT NULL,
  resets_used        SMALLINT    NOT NULL DEFAULT 0,
  refreshes_used     SMALLINT    NOT NULL DEFAULT 0,
  orders             SMALLINT    NOT NULL DEFAULT 10 CHECK (orders BETWEEN 0 AND 10),
  orders_bought      SMALLINT    NOT NULL DEFAULT 0
);

CREATE TABLE exploration.arcane_boss (
  boss_id        BIGSERIAL   PRIMARY KEY,
  finder_id      INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  hero_temp_id   INTEGER     NOT NULL,
  hp             BIGINT      NOT NULL,
  max_hp         BIGINT      NOT NULL,
  escapes_at     TIMESTAMPTZ NOT NULL,
  killed_at      TIMESTAMPTZ
);
CREATE INDEX arcane_boss_alive_idx ON exploration.arcane_boss (escapes_at) WHERE killed_at IS NULL;

CREATE TABLE exploration.arcane_boss_access (
  boss_id     BIGINT  NOT NULL REFERENCES exploration.arcane_boss(boss_id) ON DELETE CASCADE,
  player_id   BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  damage      BIGINT  NOT NULL DEFAULT 0,
  PRIMARY KEY (boss_id, player_id)
);
```

## 8. Backend implementation notes

- `exploration::shuttle::handle_request` (8475) dispatching ops 1..9; `exploration::shuttle::handle_arcane` (8476) ops 1, 3, 4; `exploration::shuttle::handle_arcane_share` (15058) op 2.
- Challenge: area left > 0, fighter set and alive (`pet_hp_percent > 0`) -> battle (battleType 3864) with the fighter Einherjar against `HeroTempId`; on win `area_left -= 1`, `score += ShuttleScore (+ buffer bonus)`, persist HP; roll a Restricted Area boss spawn (insert `arcane_boss`, access row for the finder, push 4451).
- Reset/difficulty: compute whether a reset is consumed (any chest claimed), free vs paid (2000 diamonds), restore areas, HP, chests, score; `refreshes_used = 0`.
- Arcane attack: access row exists, boss alive, not escaped, `orders > 0` -> consume one order, battle (battleType 3865) against the shared HP, stream 4462 to participants; on kill send rewards by mail to all participants (assumption) and remove the boss.
- Share: add access rows for the finder's friends; push 4451 `op = 5` to online friends.
- Weekly job Sunday 00:00 and an escape job deleting bosses past `escapes_at`.

## 9. Open questions and assumptions

- Battle type split between 3864 and 3865; boss spawn rate; boss rewards and how shared damage is rewarded.
- Exact semantics of `payType` (2 bound first, 1 real, from the client) for other ops.
- Who receives a shared boss (all friends or the friend list sent in `ArcaneZoneBossShareMsg`).

## 10. Implementation checklist

- [ ] Screens: shuttle frame, level tabs, area cards, chests, pet slots, fight pet frame
- [ ] Screens: arcane frame and boss cards
- [ ] Routes T1..T9 on 8475
- [ ] Routes A1, A3 on 8476; A2 battle; A4 on 15058
- [ ] Server messages 4460, 4451, 4462
- [ ] Tables `exploration.shuttle_state`, `arcane_boss`, `arcane_boss_access`
- [ ] Template loaders `ShuttleTempInfos.xml`, `ShuttleRewardTempInfos.xml`
- [ ] Battles 3864/3865, shared boss HP sync
- [ ] Weekly reset and boss escape jobs
