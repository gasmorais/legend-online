# Pet skills: learn, random learn, forget, skill bar order, battle skill data

Path aliases:

| Alias | File |
|---|---|
| PSO | `decompiled/core_module/scripts/managers/PetSocketOut.as` |
| PD | `decompiled/core_module/scripts/mvc/module/pet/PetData.as` |
| LSV | `decompiled/m14/scripts/pet/learnskill/PetLearnSkillView.as` |
| MSV | `decompiled/m14/scripts/pet/property/MorphingSkillView.as` |
| SAC | `decompiled/core_module/scripts/managers/PetSacristyManager.as` |
| SHOP | `decompiled/core_module/scripts/mvc/module/shop/ShopModel.as` (holder of `petSkillBookDic`) |

## 1. Overview

A pet has two skill lists in `PetInfoMsg`:
- `followSkills` (#28): template follow skills (from `PetTempInfos.xml` `FollowSkills`), passive effects while following the lord.
- `changeSkills` (#29): awakening ("Habilidade de Transformação") skills used in battle: up to 5 active (`UseWay` 1) and 3 passive (`UseWay` 2) (`PD:1326-1360`).

Skills are learned from skill books (shop hidden goods whose `Property1` is the skill template, sorted per pet type) or by a random learn ("compreensão aleatória") that is free every `pet_learn_random_skill_interval` minutes (480, minus a VIP privilege). A skill can be forgotten ("Esquecer") for diamonds. The order of the 5 active skills is the skill bar order in battle (`fast_key`). Help: "O Einherjar de Nv.≥55 poderá aprender novas habilidades" (`PetFrame.help05`).

During battle the server pushes the pet awakening value (391) and the pet skill bar (392); the player casts pet skills with 10519 `B_PET_ORDER`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `LSV` | learn skill tab | 5 active + 3 passive skill cells (`V/learnskill/PetSkillItemViewII.as`, buttons "Aprender"/"Esquecer"), skill books of the pet type paged (`V/learnskill/PetSkillBookItemView.as`, "Aprendido" when learned), random learn button "Habilidade de despertamento", timer "Após {0} obterá compreensão aleatória gratuita" / "Pode obter gratuitamente compreensão aleatória", note "Obs.: Ao aprender irá adicionar mais habilidades, mas se a barra de habilidades estiver cheia, você pode mudar habilidades já existentes." | pet frame learn skill tab | `changeSkills`, `fast_key`, `PlayerInfo.lastFreeSkillLearnTime` |
| `MSV` | "Habilidade de Transformação" | Read only awakening skills on the property tab; drag to reorder sends the fast key | property tab | same |
| `V/property/NormalSkillView.as`, `V/property/PetNormalSkillItemView.as`, `V/property/PetSkillItemView.as` | | Follow skills | property tab | `followSkills` |

## 3. Routes (client to server)

All: send 8621 (0x21ad) `C_PLAYER_PET_OP`, `PlayerPetOpMsg` (fields in [pets.md](pets.md)).

### R1. Learn from a skill book (op 5, value 1)
- UI: click a book or its learn button (`LSV:452-527`).
- Client checks: skill already learned -> "Habilidade existente" (`PD.checkSkillIsLearned` on `changeSkills`, `LSV:477-482`); greyed or zero count books ignored. If the player owns the book: confirm "Deseja aprender {0}" (`PetLearnSkillView.useBookTip.randomSkill`); otherwise buy from shop: confirm "Consumir {0} diamantes para aprender habilidade nova?" with price `Point + GiftToken` of the shop row; insufficient -> recharge (`LSV:529-568`).
- Request (`LSV:587-603`): op 5, `pet_id`, `skillId` (#8) = skill template id from book `Property1`, `value` (#5) = 1, `pay_type` (#7) = 0 when bound diamonds are allowed, else 1.
- Server: consume the book (bound first) or diamonds; if active list (5) or passive list (3) is full, replace a random existing skill of the same `UseWay` (string "Tem probabilidade de mudar uma habilidade existente, deseja continuar?"); append otherwise.
- Response: 4540 with `changeSkills`, `fast_key`; 115 for the book.

### R2. Random learn (op 5, value 2)
- UI: random learn button (`LSV:644-671`).
- Free when `now - lastFreeSkillLearnTime > (pet_learn_random_skill_interval - vipPara1) * 60` seconds (`LSV:804-833`, VIP privilege type 205 `para1` minutes); otherwise confirm "Você pode consumir {0} diamantes, para aprender uma habilidade nova" with `pet_learn_random_skill` = 100 (client default 200) (`LSV:673-710`).
- Request: op 5, `skillId` = 0, `value` = 2, `pay_type`.
- Server: pick a random skill of the pet type (or generic `MasterType` 107); update `lastFreeSkillLearnTime` when free.
- Response: 4540; 3 `U_C_PLAYER_INFO` with `lastFreeSkillLearnTime` (PlayerMsg field read at `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1150`).

### R3. Forget a skill (op 18)
- UI: "Esquecer" on a skill cell (notification `QUIT_PET_SKILL`, `V/learnskill/PetSkillItemViewII.as:187`, `LSV:712-772`), confirm "Consumir {0} diamantes para esquecer esta habilidade" with `pet_forget_skill` = 200.
- Client bug: the balance check uses the random learn price instead of the forget price (`LSV:737-763`).
- Request: op 18, `pet_id`, `skillId` = skill template id, `pay_type`.
- Response: 4540.

### R4. Reorder active skills (op 11)
- UI: dropping a skill in another cell fires `PET_SKILL_CHANGE`; `LSV:447-450` and `MSV:89-118` send the order.
- Request: op 11, `pet_id`, `pet_name` (#3, STRING) = 5 comma separated `SonType`s with `-1` for empty slots and a trailing comma (`LSV:840-860`).
- Response: 4540 with `fast_key` (#39).

### R5. Battle: cast a pet skill
- Route: send 10519 (0x2917) `B_PET_ORDER`, `UseSkillMsg` (package battle): `battle_id` (#1, STRING), `hero_id` (#2, INT32), `skill_id` (#3, INT32) (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:287-295`, caller `decompiled/core_module/scripts/battle/view/ui/PetSkillItemListController.as`). Owned by [../battle/README.md](../battle/README.md).

## 4. Server messages (server to client)

| Opcode | Message | Fields | Receiver | When |
|---|---|---|---|---|
| 4540 (0x11bc) `U_C_PLAYER_PETINFO` | `PlayerPetMsg` | `petInfo.changeSkills` (#29), `followSkills` (#28), `fast_key` (#39) | `PlayerManager.__petInfoHandler` | After R1..R4 |
| 392 (0x0188) `U_C_PET_SKILL` | `PetSkillMsg`: `user_id` (#1, INT32), `living_id` (#2, INT32) pet unit id, `skillId` (#3, INT32, repeated) skill bar, `relicSkillId` (#4, INT32) hallow skill | `SAC.__petSkillHandler` (`SAC:39-52`) caches it for the battle skill bar | Battle start |
| 391 (0x0187) `U_C_UPDATE_PET_POWER` | `AwakeMsg` (package battle): `awake` (#1, AwakeInfoMsg, repeated: `living_id` #1, `awake` #2, `childAwake` #3) | `SAC.__updatePowerHandler` (`SAC:54-60`) stores `awake[0].awake` and notifies `UPDATE_PET_POWER` | During battle when the awakening value changes |

## 5. Rules and formulas

- Capacity: 5 active, 3 passive awakening skills (`PD:1352-1360`).
- Awakening value: "O personagem durante o combate pode acumular o valor de despertamento. Antes do Einherjar alcançar Nv.55, esse valor crescerá mais vagarosamente" (`PetFrame.help01`); `MORPH_OPEN_GRADE` = 55 (`PD:29`).
- Skill books: shop hidden goods whose skill template `MasterType` equals the pet type (101..106, 117..119) or 107 (generic); active (`UseWay` 1) first, sorted by `Profile` descending (`SHOP` `petSkillBookDic`, lines 888-935).
- Learn requires pet level >= 55 (strings "Einherjar aberto no nível 55", "Einherjar Nv. {0} poderá aprender novas habilidades."; the view in this client does not lock, enforce server side).
- Prices: `pet_learn_skill` 200 (book bought in place: shop price), `pet_learn_random_skill` 100, `pet_forget_skill` 200, free interval `pet_learn_random_skill_interval` 480 minutes.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/SkillTempInfos.xml` | pet skills (`MasterType` pet type or 107, `UseWay`, `SonType`) |
| `raw/xml/tempinfos/PetTempInfos.xml` | `FollowSkills`, `ChangeSkills`, `DefaultSkills` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | skill books (`Property1` = skill template) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `pet_learn_skill`, `pet_learn_random_skill`, `pet_forget_skill`, `pet_learn_random_skill_interval` |

## 7. Persistent state

Skills are columns of `einherjar.pets` (`follow_skills`, `change_skills`, `fast_key`) and `einherjar.player_state.last_free_skill_learn_at` (see [pets.md](pets.md)). If a normalized form is preferred:

```sql
CREATE TABLE einherjar.pet_skills (
  pet_id       BIGINT   NOT NULL REFERENCES einherjar.pets(pet_id) ON DELETE CASCADE,
  skill_id     INTEGER  NOT NULL,
  use_way      SMALLINT NOT NULL CHECK (use_way IN (1, 2)),
  bar_slot     SMALLINT CHECK (bar_slot BETWEEN 0 AND 4),
  PRIMARY KEY (pet_id, skill_id)
);
```

## 8. Backend implementation notes

- `einherjar::skills::handle_learn` (op 5): `value` 1: skill exists, belongs to the pet type or 107, not learned; consume book or diamonds (`pay_type`); `value` 2: free if interval passed else diamonds; choose random skill; insert or replace when full; push 4540 (+3 for free timestamp, +115 for books).
- `einherjar::skills::handle_forget` (op 18): skill learned -> debit 200 diamonds -> remove, fix `fast_key` -> push 4540.
- `einherjar::skills::handle_fast_key` (op 11): parse 5 `SonType`s, each must be an active learned skill or -1 -> save -> push 4540.
- Battle: on battle creation send 392 per pet unit with its bar and hallow relic skill ([hallows.md](hallows.md)); accumulate awakening per turn and send 391; accept 10519 only when awakening suffices (battle engine, `docs/battle/server-engine.md`).

## 9. Open questions and assumptions

- Replacement rule when the list is full (random vs chosen).
- Awakening cost per skill and gain per turn (battle engine data).
- `pet_learn_skill` usage (likely the price of a book bought in place).

## 10. Implementation checklist

- [ ] Screen: learn skill tab with books, random learn timer, forget
- [ ] Screen: morphing skill view drag reorder
- [ ] Route op 5 value 1 (book) and value 2 (random, free timer)
- [ ] Route op 18 forget
- [ ] Route op 11 fast key
- [ ] Server message 392 and 391 in battle
- [ ] Rule: 5 active / 3 passive caps, level 55
- [ ] Table `einherjar.pet_skills` (optional)
- [ ] Tests: duplicate learn rejected, free interval with VIP reduction

## Screens

- `MorphingSkillLockTip` (`decompiled/m14/scripts/pet/property/MorphingSkillLockTip.as`, "Despertar Avançado", "Aberto no nível 55 do Einherjar", "Aumento do despertamento eleva 10 vezes; Dano de habilidade eleva 10%; pode aprender mais habilidades de despertamento.") explains why an advanced awakening skill is still locked and the level it opens at.
