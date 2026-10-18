# Pet hallows (Armas Divinas): contracts, hallow training, equip, inscriptions

Path aliases:

| Alias | File |
|---|---|
| PHM | `decompiled/core_module/scripts/yishi/manager/PetHallowsManager.as` |
| PHMOD | `decompiled/core_module/scripts/mvc/module/pet/pethallows/PetHallowsModel.as` |
| PHC | `decompiled/core_module/scripts/mvc/controler/PetHallowsControler.as` |
| OPC | `decompiled/core_module/scripts/mvc/module/pet/pethallows/PetHallowsOpClass.as` |
| V | `decompiled/m14/scripts/pethallows/` |

## 1. Overview

Three "Armas Divinas" exist, one per dual element pet family: type 1 "Sombra Luz- Escuridã" (pets 117xx), type 2 "Chuva de Vento/Água" (118xx), type 3 "Iluminação Fogo-Choq" (119xx). A hallow is activated by completing the "Contrato de Einherjar" chain of its family: each contract node is a pet `SonType` with grades fed by "Esfera Mágica de Einherjar"; higher nodes require previous ones ("Necessário completar o contrato do einherjar anterior"). Text: "Ativando um Einherjar avançado, o Einherjar do mesmo tipo de nível baixo também será ativado. Quando todos os contratos de Einherjars relacionados forem completados a Arma Sagrada correspondente será ...".

An active hallow levels up 1..99 with "Esfera do Poder do Espírito do Einherjar" (every 10th level is a breakthrough paid with "Esfera de Limite de Einherjar"), gives attack, defence, magic defence, HP and resistances plus a battle skill (relic skill), and is equipped on one pet of its family. Six inscription lines ("Inscrição") add extra stats that grow by infusing materials, with optional locks paid in diamonds.

Unlock: lord changed job (`thane.isChangeJob`, `decompiled/core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:46-47`), button = child button of the pet toolbar button (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1516-1520`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/PetHallowsFrame.as` | "Armas Divinas" | Shell with tabs contract, hallow, inscription; requests data on open (`:47-58`) | `PHC` openType 1 (pet toolbar child button) | 388 data |
| `V/PetHallowsLeftView.as`, `V/PetHallowsLeftItem.as` | "Não Ativado" | Hallow selector | frame | `hallowsInfoList` |
| `V/PetContracView.as`, `V/PetContracIconView.as` | "Progresso do contrato: {0}/{1}", "(Ativado)" / "(Não Ativado)" | Contract tree per hallow (`LineIndex`) | contract tab | `contracInfoDic` |
| `V/PetContracUpgradeFrame.as` | "Contrato de Einherjar" | Feed one contract node | contract icon (`PHC` openType 2 -> `PetContracIconView.upgradeFrame`) | node template, item count |
| `V/PetHallowsView.as`, `V/PetHallowsRightSkillView.as`, `V/PetHallowsMcView.as`, `V/PetHallowsPropAddItem.as` | "Pode equipar einherjar: {0}", "Favor selecionar einherjar a ser equipado" | Level, stats, skill, feed/break buttons, equipped pet, select pet, rest | hallow tab | `PetHallowInfoMsg` |
| `V/PetInscriptionView.as`, `V/PetInscriptionItemView.as` | "Disputa de Inscrição", "Rodapé de Inscrição", "Abrigo de Inscrição", "Inscrição da Vida Eterna", "Inscrição do Vazio.", "Inscrição do Escudo" | 6 inscription lines with EXP "EXP: {0}/{1}", locks, material choice (208062, 208063, 208064) | inscription tab | `prop*Gp`, `prop*Grade` |
| `decompiled/core_module/scripts/ui/resourcebar/view/PetSortItem.as` | | Equip the selected hallow on a pet from the pet menu (`:129`) | resource bar | |

## 3. Routes (client to server)

All: send 9627 (0x259b) `C_PETHALLOW_OP`, `PetHallowListMsg` (package pet): `op` (#1, INT32), `sonType` (#2, INT32), `petId` (#3, INT32), `contractInfo` (#4, PetContractInfoMsg, repeated, unused in requests), `hallowInfo` (#5, repeated, unused), `lockSet` (#6, INT32, repeated), `removeItemTempId` (#7, INT32), `payType` (#8, INT32). Senders `PHM.sendPetHallowsRequest(op, sonType, petId)` (`PHM:103-116`, zero values are omitted) and `PHM.sendPetInscriptionRequest` (`PHM:118-127`). Op constants (`OPC`): 1 `OP_CONTRAC_FEED`, 2 `OP_HALLOWS_FEED`, 3 `OP_HALLOWS_EQUIP`, 4 `OP_HALLOWS_REQU`, 5 `PET_INSCRIPTION_OP`.

| op | UI and client checks | Fields | Server effect |
|---:|---|---|---|
| 4 | Frame open (`V/PetHallowsFrame.as:56`) | none | Return everything |
| 1 | Contract button (`V/PetContracUpgradeFrame.as:180-194`): 1 s throttle; node not unlocked or prerequisites incomplete -> "Ainda não atingiu as condições do contrato, não é possíve fazer operação." (`PHMOD:247-281`); items < `NeedItemCount` -> "Esfera de magia de einherjar insuficiente, não possível fazer o contrato." | `sonType` = contract `PetSonType` | Consume 208062 x `NeedItemCount` of the next grade, contract grade + 1; when all contracts of a hallow are complete, activate it at grade 1 |
| 2 | Feed / break buttons (`V/PetHallowsRightSkillView.as:165-174`): not enough items -> "Materiais necessários insuficentes, não é possível efetuar operação." | `sonType` = `HallowType` | Consume 208063 x `NeedItemCount1` (normal levels) or 208064 x `NeedItemCount2` (levels 10, 20, ... breakthroughs); grade + 1; new `PropertyDatas` and skill |
| 3 | Select a pet (`PetSortItem.as:129`) or rest (`V/PetHallowsView.as:144-151`, `petId` 0); hallow not active -> "Arma divina atual não ativada, não é possível equipar einherjar."; no matching pet -> "Não contém einherjars que satisfazem as condições" | `sonType` = `HallowType`, `petId` (0 = unequip) | Pet template `SonType` must be in `EquipPetSonTypes`; one hallow per pet |
| 5 | Infuse button (`V/PetInscriptionView.as:274-313`); locks need >= 1 unlocked line ("Necessário guardar no mínimo 1 atributo."); with locks confirm "Deseja consumir {0} diamantes para encerrar {1} barra de atributos para efetuar a operação de antique." | `sonType` = `HallowType`, `removeItemTempId` = material (208062, 208063 or 208064, `:334-352`), `payType` 0 no locks, 1 diamonds, 2 bound diamonds allowed, `lockSet` = locked line numbers 1..6 | Consume 1 material (assumption), add EXP to unlocked lines (`prop*Gp`), level them (`prop*Grade`) |

Response for every op: 388 (S1) with the full state. Pet stats change, so 4540 with `fightingCapacity` follows (assumption).

## 4. Server messages (server to client)

### S1. 388 (0x0184) `U_C_PETHALLOW`
- `PetHallowListMsg` with `hallowInfo` (#5, repeated `PetHallowInfoMsg`) and `contractInfo` (#4, repeated `PetContractInfoMsg`).
- `PetHallowInfoMsg`: `hallowSonType` (#1) hallow type 1..3; `hallowTempId` (#2) current `PetHallowsTempInfos` id; `infuseIndex` (#3); `attackData` (#4), `defenceData` (#5), `magicDefenceData` (#6), `liveData` (#7), `reduceResiData` (#8), `otherResiData` (#9) inscription values per line; `equipPetId` (#10); `attackGp` (#11) .. `otherResiGp` (#16) inscription EXP; `attackGrade` (#17) .. `otherResiGrade` (#22) inscription levels; `activeSkillTempId` (#23). All INT32.
- `PetContractInfoMsg`: `petSonType` (#1), `contractTempId` (#2) current contract template.
- Receiver: `PHM.__updateHallowsMsgHandler` (`PHM:47-101`): replaces `hallowsInfoList` (sorted by type) and `contracInfoDic`, fires `PET_HALLOWS_MSG_UPDATE`.
- When: response to every 9627 op; login (assumption, the pet stats formula reads it, `decompiled/core_module/scripts/mvc/module/pet/PetData.as:1751-1770`).

### S2. 392 `U_C_PET_SKILL.relicSkillId`
The equipped hallow skill is sent in battle ([skills.md](skills.md)).

## 5. Rules and formulas

- `PetHallowsTempInfos.xml` (297 rows): `HallowType` 1..3, `Grades` 1..99, `NeedItemCount1` (208063, normal levels, 20 at low grades up to 2000), `NeedItemCount2` (208064, at grades 10, 20, 30, 40, 50 ...), `PropertyDatas` "attack,defence,magicDefence,HP,reduceResi,otherResi" (grade 2: 500,500,500,3000,100,100; grade 99: 315800,315800,315800,1894800,63160,63160), `SkillTempId` (41210101 .. upgraded every 10 grades), `EquipPetSonTypes` (type 1: 11702,11703,11704; type 2: 11802,11803; type 3: 11902,11903).
- `PetContracTempInfos.xml` (168 rows): `HallowType`, `PetSonType` (node), `Grades` 0..6, `NeedItemCount` (208062), `PropertyType`/`PropertyData` bonus (types in `PetContracAddTips.addPropText*`: 0 Ataque, 1 Magia, 7 Defesa, 9 Resistência, 10 Pontos de Vida, ...), `PrePetSonTypes` (prerequisite nodes that must be at max grade), `LineIndex` (tree column).
- Hallow stat on the equipped pet: for each line i, `value_i + floor(value_i * ActiveObject / 100)` where `ActiveObject` comes from `UpGradeTempInfos` `Types=127` at the inscription grade (`PetData.as:1751-1770`); indexes 0 attack/magic attack, 1 defence, 2 magic defence, 3 HP.
- Inscription lock prices `Lock_PetHallow` = "10,10,20,20,30" diamonds for 1..5 locked lines (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:557-560`).
- Items: 208062 "Esfera Mágica de Einherjar", 208063 "Esfera do Poder do Espírito do Einherjar", 208064 "Esfera de Limite de Einherjar".

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/PetHallowsTempInfos.xml` | hallow levels |
| `raw/xml/tempinfos/PetContracTempInfos.xml` | contract nodes |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types` 127 inscription bonus percent |
| `raw/xml/tempinfos/SkillTempInfos.xml` | relic skills 412xxxxx |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Lock_PetHallow` |

## 7. Persistent state

```sql
CREATE TABLE einherjar.hallows (
  player_id        BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  hallow_type      SMALLINT NOT NULL CHECK (hallow_type BETWEEN 1 AND 3),
  template_id      INTEGER  NOT NULL,
  equip_pet_id     BIGINT   REFERENCES einherjar.pets(pet_id) ON DELETE SET NULL,
  infuse_index     INTEGER  NOT NULL DEFAULT 0,
  active_skill_id  INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, hallow_type),
  UNIQUE (equip_pet_id)
);

CREATE TABLE einherjar.hallow_inscriptions (
  player_id    BIGINT   NOT NULL,
  hallow_type  SMALLINT NOT NULL,
  line_index   SMALLINT NOT NULL CHECK (line_index BETWEEN 1 AND 6),
  value        INTEGER  NOT NULL DEFAULT 0,
  exp          INTEGER  NOT NULL DEFAULT 0,
  grade        SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, hallow_type, line_index),
  FOREIGN KEY (player_id, hallow_type) REFERENCES einherjar.hallows(player_id, hallow_type) ON DELETE CASCADE
);

CREATE TABLE einherjar.pet_contracts (
  player_id      BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pet_son_type   INTEGER  NOT NULL,
  template_id    INTEGER  NOT NULL,
  PRIMARY KEY (player_id, pet_son_type)
);
```

## 8. Backend implementation notes

- `einherjar::hallows::handle_op` (9627) dispatches by `op`.
- op 4 `handle_request`: build 388 from the three tables.
- op 1 `handle_contract_feed`: next contract row exists, prerequisites at max grade, items -> consume, upgrade, activate hallow when the family is complete (insert `hallows` at grade 1 template) -> 388.
- op 2 `handle_hallow_feed`: active, next grade exists, items (1 or 2 by grade) -> consume, set template -> 388; recompute equipped pet stats (4540).
- op 3 `handle_equip`: active, pet owned and family matches, unequip previous holder -> 388, 4540 for both pets.
- op 5 `handle_inscription`: at least one unlocked line, lock cost, material -> add EXP and grades -> 388, 4540.
- Battle: when a pet with an equipped hallow fights, add the relic skill (`relicSkillId` in 392).

## 9. Open questions and assumptions

- EXP and value gained per inscription infusion and the role of each material (208062/208063/208064).
- Contract `PropertyType` application target (lord or pet).
- `infuseIndex` meaning (assumed infusion counter).

## 10. Implementation checklist

- [ ] Screen: hallows frame with contract, hallow and inscription tabs
- [ ] Route 9627 op 4 -> 388
- [ ] Route 9627 op 1 contract feed
- [ ] Route 9627 op 2 hallow feed and breakthrough
- [ ] Route 9627 op 3 equip / unequip
- [ ] Route 9627 op 5 inscription with locks
- [ ] Server message 388 encoder
- [ ] Tables `einherjar.hallows`, `einherjar.hallow_inscriptions`, `einherjar.pet_contracts`
- [ ] Rule: family `EquipPetSonTypes`, prerequisites, lock prices
- [ ] Tests: activation after full contract chain, equip only family pets
