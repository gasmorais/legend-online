# Pets roster (Einherjar): sync, list, deploy, sacrifice, rename, lock, look up

Path aliases:

| Alias | File |
|---|---|
| PSO | `decompiled/core_module/scripts/managers/PetSocketOut.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| PD | `decompiled/core_module/scripts/mvc/module/pet/PetData.as` |
| PC | `decompiled/core_module/scripts/mvc/controler/PetController.as` |
| FRAME | `decompiled/m14/scripts/pet/PetFrame.as` |
| SHOW | `decompiled/m14/scripts/pet/property/PetShowView.as` |
| LIST | `decompiled/m14/scripts/pet/list/PetListView.as` |
| V | `decompiled/m14/scripts/pet/` |

## 1. Overview

"Einherjar" are the lord's pets. The player owns a list of pets (6 slots at start, more slots bought with diamonds), one pet "Perseguir Personagem" follows and fights with the lord, and pets can also be assigned to the main or secondary guardian ("Perseguir Guardião", guardians feature). Each pet has a template (type, tier `NeedGrade`, quality), level (max 80, never above the lord level), aptitudes ("Força", "Proteção", "Inteligência", "Físico"), growth ("Crescimento"), resistances, follow skills and awakening skills ("Habilidade de Transformação"), and up to 6 equipment pieces ([equipment.md](equipment.md)).

This module covers the entity and its sync, the frame shell, list and slot purchase, deploy and rest, "Prioritário" (move to top), sacrifice ("Sacrifício"), rename, vice password lock and looking at another player's pet. Growth actions are in [growth.md](growth.md), skills in [skills.md](skills.md).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `FRAME` | "Einherjar" (`pet.PetFrame.title`, `:152`) | Shell with 8 image tabs: property, advanced (growth stone + equipment bag), swallow, strengthen (button style `pet.HandbookBtn`), learn skill, compose, mix, equip store (`:120-127,417-549`); pet list on the left; help per tab (`PetFrame.help01..07`) | Toolbar pet button (lord level >= 50, `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1500-1515`, `decompiled/core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:26-27`), hotkey Y (`MainToolCheckBtnOpen.as:86-87`, `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:899`), `SwitchPageHelp.openPetFrame(tab)` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2184-2187`), add point tip (`decompiled/m16/scripts/tasktracetip/view/PetAddPointTip.as:59`) | `PlayerInfo.petList`; default tab by `openDefaultType` 0..6 (`:296-348`) |
| `LIST` + `V/list/PetListItemView.as` | | Paged pet list, badges "Este Einherjar já participou na Batalha.", "Este Einherjar está vinculado.", "Em Prática"; locked cells "Clique para abrir mais espaço de Einherjar" | frame | `petMaxCount`, `PD.petCarryLimit` (config `pet_maxCount`, default 18, `PD:750-763`) |
| `V/property/PropertyView.as` + `SHOW` | | Avatar, name, stars, level, fight power; buttons "Configuração de Batalha" menu ("Perseguir personagem", "Perseguir guardião principal", "Pergueguir guardião secundário", "Descansar"), "Sacrifício", "Prioritário", rename, lock, cancel practice; equipment cells | property tab | `PetData` |
| `V/property/GrowthInfoView.as` | "Crescimento" | Aptitudes with limits, growth, potential points, resistances | property tab | `coe*`, `coe*Limit`, `growthRate`, `res*` |
| `V/property/DetailInfoView.as` | "Detalhes" | Derived attributes (attack, defence, magic, HP) | property tab | formulas in Rules |
| `V/property/PetRenameView.as` | "Inserir nome:" | Rename popup ("O nome do {0} deve conter de 4 a 12 caracteres") | rename button (`SHOW:515-529`) | |
| `V/lookup/PetLookUpView.as`, `V/lookup/PetLookUpFrame.as` | "O meu Einherjar" / other player | Read only pet view | `PC` openType `LOOKUP_FRAME` from player info (`decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as:1544,1678`) and rankings (`decompiled/m11/scripts/sort/SortMemberItem.as:169`) | `PetData` from 4608 or rankings XML (`PD.createWithXML`, `PD:689-748`) |
| `decompiled/core_module/scripts/ui/resourcebar/view/PetSortItem.as`, `ResourcesBar.as` | | Quick deploy menu on the resource bar | resource bar | |

## 3. Routes (client to server)

All pet operations use send 8621 (0x21ad) `C_PLAYER_PET_OP` with `PlayerPetOpMsg` (package pet): `pet_id` (#1, INT32), `op_type` (#2, INT32), `pet_name` (#3, STRING), `attributes` (#4, INT32, repeated), `value` (#5, INT32), `item_pos` (#6, INT32), `pay_type` (#7, INT32), `skillId` (#8, INT32), `fightType` (#9, INT32). Senders are static methods of `PSO`.

Full `op_type` table (owner module in brackets):

| op | Sender | Fields | Module |
|---:|---|---|---|
| 1 | `PSO.swallowPet` (`PSO:25-34`) | pet_id main, value = sub pet id, pay_type | [growth.md](growth.md) |
| 2 | `PSO.addPoint` (`PSO:54-72`) | pet_id, attributes[4] | growth (no caller in this client) |
| 3 | `PSO.washPoint` (`PSO:74-86`) | pet_id, pay_type | growth (no caller) |
| 4 | `PSO.trainGrowthRate` (`PSO:138-152`) | pet_id, value = times, pay_type, item_pos = goods mode | [growth.md](growth.md) |
| 5 | `PSO.learnSkill` (`PSO:104-114`) | pet_id, skillId, value = mode, pay_type | [skills.md](skills.md) |
| 6 | `PSO.sacrifice` (`PSO:16-23`) | pet_id | this module |
| 7 | `PSO.trainCoe` (`PSO:88-102`) | pet_id, value = times, pay_type, item_pos = goods mode | [growth.md](growth.md) |
| 8 | `PSO.trainResistance` (`PSO:127-136`) | pet_id, value, item_pos | growth (no caller) |
| 9 | `PSO.enterWar` (`PSO:36-43`) | pet_id | this module |
| 10 | `PSO.rest` (`PSO:45-52`) | pet_id | this module |
| 11 | `PSO.setSkillFastKey` (`PSO:154-162`) | pet_id, pet_name = key string | [skills.md](skills.md) |
| 12 | `PSO.addPetCarryNum` (`PSO:164-172`) | value = new slot count, pay_type | this module |
| 13 | `PSO.composePet` (`PSO:174-183`) | pet_id, skillId = compose type, pay_type | [growth.md](growth.md) |
| 14 | `PSO.shiftToTop` (`PSO:185-192`) | pet_id | this module |
| 15 | `PSO.mixDoublePet` (`PSO:194-204`) | pet_id, value = second pet id, skillId = mix type, pay_type | [growth.md](growth.md) |
| 16 | `PSO.enterChildPet` (`PSO:206-214`) | pet_id, fightType 1 main guardian / 2 secondary guardian | this module |
| 17 | `PSO.restChildPet` (`PSO:216-223`) | pet_id | this module |
| 18 | `PSO.quitSkill` (`PSO:116-125`) | pet_id, skillId, pay_type | [skills.md](skills.md) |

Every successful op is answered with 4540 (S1) containing the changed `PetInfoMsg` rows (and `pet_count` when slots change). Errors are plain tips (assumption: server sends the generic message opcode used by other features).

### R1. Deploy with the lord (op 9)
- UI: "Configuração de Batalha" -> "Perseguir personagem" (`SHOW:719-775`), resource bar menu (`PetSortItem.as:117`, `ResourcesBar.as:221`).
- Client checks: lord level >= template `NeedGrade` else "Necessário jogador nível {0}"; unbound pet: deploy binds it (`SHOW:861-881`, string "Einherjar combatente tornará-se vinculado, continuar?" exists but the client skips the confirm). The strings "Einherjar em prática, não é possível batalhar" and "Para participar na batalha o nível da Einherjar não pode ultrapassar o nível da personagem." exist but are not checked in `SHOW`; enforce both server side (assumption).
- Also clears the pet from the monopoly formation (`SHOW:597-611`, `MonopolySocketOutManager.sendPetFormation`, casino feature).
- Request: op 9, `pet_id`.
- Server: set `is_fight` on this pet, clear it on the previous one, clear guardian assignment of this pet, bind it.
- Response: 4540 with both pets; 150 `ArmyMsg` pet fields for map avatars (hero feature).

### R2. Rest (op 10) and guardian assignment (ops 16, 17)
- UI: "Descansar" (op 10 when `isFight`, op 17 when `isChildFight != 0`), "Perseguir guardião principal" (op 16, `fightType` 1), "Pergueguir guardião secundário" (op 16, `fightType` 2) (`SHOW:719-823`).
- Client checks: guardian buttons need lord level >= 70 and a deployed main or secondary guardian (`SHOW:776-823`).
- Response: 4540 (`isFight`, `isChildFight` #55).

### R3. Prioritize (op 14)
- UI: "Prioritário" tip "Configure este Einherjar para o primeiro da lista" (`SHOW:883-892`). Client moves the pet to the top locally.
- Response: 4540 with new `position` (#41) values.

### R4. Sacrifice (op 6)
- UI: "Sacrifício" (`SHOW:531-595`).
- Client checks in order: locked -> "O Einherjar atual foi bloqueado, por favor desbloqueie"; practicing (farm pet land) -> "Einherjar em prática, não é possível sacrificar"; fighting -> "Einherjar combatente não pode ser sacrificado"; guardian assignment -> "O guardião do einherjar não poderá ser sacrificado"; in pet arena team (`petChallengeFormation`) -> "Einherjar que encontram-se na equipe de batalha da Arena não podem ser sacrificados"; in remote expedition -> "Einherjar não pode ser sacrificado na expedição de Einherjar de equipe"; has equipment -> "Ainda há equipamento no Einherjar que não pode ser sacrificado". Quality < 3: simple confirm (with defender warning "Einherjar está em estado {0}, sacrificar?" if guarding the farm); quality >= 3: type "YES" confirm ("Digite abaixo [YES] para confirmar o Sacrifício.", `SHOW:657-690`).
- Last pet: "Não é capaz de sacrificar o último Einherjar" (server rule, assumption).
- Request: op 6, `pet_id`.
- Server: delete the pet, grant "Esfera de Energia de Einherjar" 3040001 (quality 1: 1..2, quality 2: 2..3, quality 3..5: `(quality-1)^4`) or "Esfera de Energia Avançada"/"Pérolas de Espirito Coagulado avançadas" for quality >= 6 (`SHOW:692-717`).
- Response: 4540 with `isDel` true; 115 bag update for the reward.

### R5. Buy pet slots (op 12)
- UI: click a locked list cell (`LIST:190-232`), confirm "Deseja consumir {0} diamantes, para liberar {1} espaço de Einherjar?".
- Cost per slot k (k = slots already bought beyond 6): `min(a + k * b, c)` with `add_pet_count` = "100,100,300" (client default "100,50,500") (`LIST:192-211`).
- Request: op 12, `value` = number of slots to add (`param3`), `pay_type` 0 = bound diamonds allowed, 1 = diamonds only (`LIST:220-231`).
- Response: 4540 with `pet_count` (#7).

### R6. Rename (AMF)
- UI: rename (`SHOW:515-529`) -> `V/property/PetRenameView.as`. Validation: 4..12 length (CJK counts 2), not empty, not equal, legal characters (`PetRenameView.as:120-160`), then HTTP `{REQUEST_PATH}nicknamecheck?nickname=&type=1` (`:182-189`), then AMF `ServerRequest.renamePet` `[key, uid, petId, name]` (`decompiled/core_module/scripts/yishi/service/managers/CastleServiceManager.as:50-53`, `protocol/amf.md`). `result == 3` = success "Nomeamento sucedido"; else "Falha no nomeamento". First rename is free ("É grátis mudar de nome pela primeira vez"; later cost unknown).
- Server: update the name, push 4540 with `pet_name`.

### R7. Lock (vice password)
- UI: lock button (`SHOW:208-236`); same flow as other locks; sends 8809 `C_LOCK_OR_UNLOCK` `LockAndUnlockMsg` `op_type` (#1) = 2, `item_pos` (#2) = 0, `pet_id` (#3) (`decompiled/core_module/scripts/mainBar/vicePassword/VicePasswordUtil.as:40-49`). Response: 4540 `is_locked` (#42).

### R8. Look at another player's pet
- Sender: `PM.sendRequestPetData(userId)` (`PM:1747-1753`), called from `PlayerInfoFrameII.as:1544`.
- Route: send 8702 (0x21fe) `C_GET_PLAYER_PET_INFO`, `PlayerPetOpMsg.pet_id` (#1) = target user id.
- Response: 4608 (S2).

### R9. Cancel pet land practice
`FarmManager.sendFarmOper(userId, 16, landPos, petId, 0)` from `SHOW:825-859`; see [pet-land.md](pet-land.md).

## 4. Server messages (server to client)

### S1. 4540 (0x11bc) `U_C_PLAYER_PETINFO`
- `PlayerPetMsg` (package pet): `user_id` (#1, INT32); `petInfo` (#2, PetInfoMsg, repeated) changed pets; `nick_name` (#3, STRING); `order` (#4, INT32) and `score` (#6, INT32) used by the arena; `cha_pos` (#5, STRING) pet arena formation; `pet_count` (#7, INT32) slot count; `operate_type` (#8, INT32); `lords_pos` (#9, STRING); `monopoly_pos` (#10, STRING); `uuid` (#11, STRING); `equipmets` (#12, PetEquipmentMsg, repeated); `consortia_pos` (#13, STRING) guild boss formation; `mate_lords_pos` (#14, STRING); `transfer_pos` (#15, STRING) flame formation.
- `PetInfoMsg`: `pet_id` (#1), `template_id` (#2), `pet_name` (#3, STRING), `cur_gp` (#4) EXP in level, `cur_grade` (#5) level, `power` (#6), `intel` (#7), `physi` (#8), `armor` (#9) attribute points, `remainPoints` (#10), `initPowerApti` (#11) .. `initArmorApti` (#14) base aptitudes, `powerApti` (#15) .. `armorApti` (#18) current aptitudes, `curQualityGp` (#19) advance bless, `growthRate` (#20), `maxHp` (#21), `fireResi` (#22), `waterResi` (#23), `electResi` (#24), `windResi` (#25), `darkResi` (#26), `lightResi` (#27), `followSkills` (#28, STRING ids), `changeSkills` (#29, STRING awakening ids), `isFight` (#30, BOOL), `isPractice` (#31, BOOL), `isBind` (#32, BOOL), `total_gp` (#33, INT64), `fightingCapacity` (#34), `isDel` (#35, BOOL) delete, `quality` (#36) internal quality 1..31, `isGuard` (#37, BOOL), `cha_skill_indexs` (#38, STRING) arena skills, `fast_key` (#39, STRING), `init_quality` (#40), `position` (#41) list order, `is_locked` (#42, BOOL), `lords_skill_indexs` (#43), `monopoly_skill_indexs` (#45), `bag_attack` (#46), `bag_defence` (#47), `bag_magicattack` (#48), `bag_magicdefence` (#49), `bag_living` (#50) equipment totals, `consortia_skill_indexs` (#51), `remote_pet_skill_indexs` (#52), `remoteHp` (#53), `isRemote` (#54, BOOL), `isChildFight` (#55, INT32 0/1/2), `mate_lords_skill_indexs` (#56), `transfer_skill_indexs` (#57). All INT32 unless noted; only fields with `has*` set are applied (`PD:417-636`).
- Receiver: `PM.__petInfoHandler` (`PM:1474-1567`): upserts or removes pets on `PlayerInfo` and `ThaneInfo`, sorts by `pos` once, dispatches `PET_LEVEL_UP` when the fighting pet level changes, copies the fighting pet template, name and quality into `ThaneInfo` (map avatar).
- When: login (full list), after every 8621 op, after battles (EXP), arena, expedition, hallows.

### S2. 4608 (0x1200) `U_C_RECEIVE_PET_DATA`
- `PlayerPetMsg` with `user_id`, one `petInfo` and `equipmets` (`PetEquipmentMsg`: `templateId` #1, `pos` #2, `join1..4` #3..#6, `randomSkill1..5` #7..#11, `mouldGrade` #12, `isBind` #13 BOOL).
- Receiver: `PM.__receivePetDataHandler` (`PM:1762-1797`) dispatches `QUERY_PETDATA_RESULT` for the look up view.

### S3. 0 (0x0000) `U_C_PET_REMOVE`
Listed in `protocol/opcodes.csv`; no client listener found. Removal is done with 4540 `isDel`.

## 5. Rules and formulas

- Templates `PetTempInfos.xml` (108 rows): `TemplateId` = `PetType * 1000 + NeedGrade * 100 + Quality` (for example 101101 "Amazona" type 101 tier 1 quality 1). `PetType` 101..106 single element, 117..119 dual element ("Fogo|Água|Choque|Vento|Escuridão|Luz|Luz/Escuridão|Vento/Água|Fogo/Choque", `pet.petTypeList`). `NeedGrade` = tier (1 normal, 2 divine mould, 3 advanced) and lord level needed to fight.
- Internal quality `quality` (#36) 1..31 maps to display quality: `q < 26 ? (q-1)/5 + 1 : (q-1)/5` and star `q < 21 ? q % 5 (0 -> 5) : q % 10 (0 -> 10)` (`PD:248-271`).
- Level: max 80 (`UpGradeTempInfos` `Types=25`, `PD:210-227`), row index `grade` gives EXP to next (3000 at Lv2 .. 58760136 at Lv80); pet level cannot exceed the lord level (`PD.isFullExp`, `PD:1283-1300`).
- Attribute points: 5 per level (`EACH_LEVEL_POINT`, `PD:31`).
- Base stats per level: `stat_base = template stat + floor((grade - 1) * growthRate / 80)` (`PD:801-850`).
- Derived (`PD:786-993`): `HP = floor(6 * physi * physiApti / 1000) + MaxHp + equip_hp + hallows`; `Attack = floor(power * 1.8 * powerApti / 1000) + equip + hallows[0]`; `MagicAttack = floor(intel * 1.8 * intelApti / 1000) + equip + hallows[0]`; `Defence = floor((armor * 0.9 * armorApti + power * 0.9 * powerApti) / 1000) + equip + hallows[1]`; `MagicDefence = floor((armor * 0.9 * armorApti + intel * 0.9 * intelApti) / 1000) + equip + hallows[2]`.
- Fight power (client fallback): `700 + MagicAttack + MagicDefence + Attack + Defence + HP / 5` (`PD:204-208`); the server sends `fightingCapacity`.
- Slots: start 6, cap `pet_maxCount` (default 18) (`PD:750-763`).
- Initial pets granted on activation: `Init_Pets` = 101103, 102103, 103103, 104103 (`ConfigInfos.xml`; assumption: at lord level 50 when the system opens).
- One pet follows the lord (`isFight`), at most one per guardian slot (`isChildFight` 1 or 2).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/PetTempInfos.xml` | `TemplateId`, `TemplateName`, `PetAvatar`, `SonType`, `PetType`, `Quality`, `Power`, `Intel`, `Physi`, `Armor`, `PowerApt`/`IntelApt`/`PhysiApt`/`ArmorApt` ("min,max"), `MaxHp`, `GrowthRate`, resistances, `FollowSkills`, `ChangeSkills`, `DefaultSkills`, `NeedGrade`, `Property1` (0 = flying avatar offset in battle, `docs/battle/formation.md`) |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types` 25 pet level EXP |
| `raw/xml/tempinfos/ConfigInfos.xml` | `pet_maxCount`, `add_pet_count`, `Init_Pets` |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS einherjar;

CREATE TABLE einherjar.pets (
  pet_id            BIGSERIAL   PRIMARY KEY,
  player_id         BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id       INTEGER     NOT NULL,
  name              TEXT        NOT NULL,
  renamed           BOOLEAN     NOT NULL DEFAULT false,
  level             SMALLINT    NOT NULL DEFAULT 1 CHECK (level BETWEEN 1 AND 80),
  exp               BIGINT      NOT NULL DEFAULT 0,
  total_exp         BIGINT      NOT NULL DEFAULT 0,
  quality           SMALLINT    NOT NULL CHECK (quality BETWEEN 1 AND 31),
  init_quality      SMALLINT    NOT NULL,
  quality_bless     INTEGER     NOT NULL DEFAULT 0,
  power             INTEGER     NOT NULL,
  intel             INTEGER     NOT NULL,
  physi             INTEGER     NOT NULL,
  armor             INTEGER     NOT NULL,
  remain_points     INTEGER     NOT NULL DEFAULT 0,
  init_power_apt    INTEGER     NOT NULL,
  init_intel_apt    INTEGER     NOT NULL,
  init_physi_apt    INTEGER     NOT NULL,
  init_armor_apt    INTEGER     NOT NULL,
  power_apt         INTEGER     NOT NULL,
  intel_apt         INTEGER     NOT NULL,
  physi_apt         INTEGER     NOT NULL,
  armor_apt         INTEGER     NOT NULL,
  fire_resi         INTEGER     NOT NULL DEFAULT 0,
  water_resi        INTEGER     NOT NULL DEFAULT 0,
  elect_resi        INTEGER     NOT NULL DEFAULT 0,
  wind_resi         INTEGER     NOT NULL DEFAULT 0,
  dark_resi         INTEGER     NOT NULL DEFAULT 0,
  light_resi        INTEGER     NOT NULL DEFAULT 0,
  follow_skills     TEXT        NOT NULL DEFAULT '',
  change_skills     TEXT        NOT NULL DEFAULT '',
  fast_key          TEXT        NOT NULL DEFAULT '',
  is_fight          BOOLEAN     NOT NULL DEFAULT false,
  child_fight       SMALLINT    NOT NULL DEFAULT 0 CHECK (child_fight IN (0, 1, 2)),
  is_bind           BOOLEAN     NOT NULL DEFAULT false,
  is_locked         BOOLEAN     NOT NULL DEFAULT false,
  position          INTEGER     NOT NULL DEFAULT 0,
  fight_capacity    INTEGER     NOT NULL DEFAULT 0,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX pets_player_idx ON einherjar.pets (player_id);
CREATE UNIQUE INDEX pets_one_fighter ON einherjar.pets (player_id) WHERE is_fight;
CREATE UNIQUE INDEX pets_one_child_slot ON einherjar.pets (player_id, child_fight) WHERE child_fight > 0;

CREATE TABLE einherjar.player_state (
  player_id                 BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  pet_slots                 SMALLINT    NOT NULL DEFAULT 6,
  last_free_skill_learn_at  TIMESTAMPTZ,
  challenge_formation       TEXT        NOT NULL DEFAULT '',
  lords_formation           TEXT        NOT NULL DEFAULT '',
  mate_lords_formation      TEXT        NOT NULL DEFAULT '',
  monopoly_formation        TEXT        NOT NULL DEFAULT '',
  consortia_formation       TEXT        NOT NULL DEFAULT '',
  transfer_formation        TEXT        NOT NULL DEFAULT ''
);
```

Per mode skill selections (`cha_skill_indexs`, `lords_skill_indexs`, ...) are stored by their owner modules (for example [challenge-arena.md](challenge-arena.md)); a generic table:

```sql
CREATE TABLE einherjar.pet_mode_skills (
  pet_id     BIGINT   NOT NULL REFERENCES einherjar.pets(pet_id) ON DELETE CASCADE,
  mode       TEXT     NOT NULL CHECK (mode IN ('challenge','lords','mate_lords','monopoly','consortia','remote','transfer')),
  skill_idx  TEXT     NOT NULL,
  PRIMARY KEY (pet_id, mode)
);
```

## 8. Backend implementation notes

- `einherjar::pets::handle_pet_op` decodes 8621 and dispatches by `op_type` to the module handlers listed above.
- `einherjar::pets::handle_enter_war` (op 9): own pet -> lord level >= template `NeedGrade` -> pet level <= lord level -> not practicing (pet land) -> transaction: clear other fighter, set `is_fight`, `child_fight = 0`, `is_bind = true` -> push 4540 (both rows), 150 `ArmyMsg` pet fields to viewers.
- `einherjar::pets::handle_rest` (op 10), `handle_enter_child` (op 16), `handle_rest_child` (op 17): guardian checks (lord level >= 70, guardian deployed, guardians feature).
- `einherjar::pets::handle_shift_to_top` (op 14): reorder `position` values.
- `einherjar::pets::handle_sacrifice` (op 6): checks of R4 server side (lock, practice, fight, guardian, arena formation, expedition, equipment, last pet) -> delete pet, remove from formations -> grant reward items -> push 4540 `isDel`, 115.
- `einherjar::pets::handle_add_slots` (op 12): slots + `value` <= cap -> cost sum -> debit diamonds (`pay_type` 0 bound first) -> push 4540 `pet_count`.
- `einherjar::pets::handle_query_other` (8702): load target pet (the fighting pet, assumption) and equipment -> 4608.
- AMF `ServerRequest.renamePet`: validate, `renamed` flag for free first rename, return 3, push 4540.
- Login: send 4540 with every pet and all formation strings.
- Battle configuration: the fighting pet is added to `pets[]` linked to the lord (`living_id2`), see `docs/battle/formation.md`; pet skill casts arrive as 10519 `B_PET_ORDER` (`UseSkillMsg`, `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:287-295`); battle pushes 391/392 are in [skills.md](skills.md).

## 9. Open questions and assumptions

- Cost of renames after the first one.
- Exact sacrifice reward ranges (tips show 1-2, 2-3 and `(q-1)^4`).
- Whether 8702 returns the fighting pet or a specific pet.
- `U_C_PET_REMOVE` (0) has no listener; assumption: unused.
- `Init_Pets` grant moment.
- Ops 2, 3, 8 have senders but no caller; implement only if needed (`pet_reset_att` = 100 diamonds for wash).

## 10. Implementation checklist

- [ ] Screen: PetFrame tabs and default tab
- [ ] Screen: list with slot purchase
- [ ] Screen: property, growth info, detail info, rename, look up
- [ ] Route 8621 op 9 / 10 / 16 / 17 deploy and rest
- [ ] Route 8621 op 14 prioritize
- [ ] Route 8621 op 6 sacrifice with rewards
- [ ] Route 8621 op 12 slots
- [ ] Route 8702 -> 4608
- [ ] Route 8809 op 2 lock
- [ ] AMF `renamePet` + `nicknamecheck`
- [ ] Server message 4540 encoder (all 57 fields, partial updates)
- [ ] Server message 4608 encoder
- [ ] Table `einherjar.pets`
- [ ] Table `einherjar.player_state`
- [ ] Table `einherjar.pet_mode_skills`
- [ ] Rule: derived stats, quality mapping, level cap = lord level
- [ ] Tests: sacrifice blocked states, slot cost, single fighter
