# Contracts (Contrato)

Path aliases:

| Alias | File |
|---|---|
| MM | `decompiled/core_module/scripts/yishi/manager/MonsterManager.as` |
| MMOD | `decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as` |
| CV | `decompiled/m14/scripts/monster/view/MonsterContractView.as` |
| CI | `decompiled/m14/scripts/monster/item/MonsterContractItem.as` |
| CS | `decompiled/m14/scripts/monster/view/MonsterContractSelectView.as` |

## 1. Overview

Three contract slots bind beasts to the lord. In combat the lord gains the active characteristic of each contracted beast's accessory: "Através da força do contrato o personagem pode obter em combate o efeito da habilidade do acessório do monstro" (`CV:47`). Help item 7: "Através do Poder do Contrato, os jogadores podem receber um efeito de bônus da habilidade do acessório equipado pelo monstro." Contracts with the same accessory kind and characteristic type do not stack: "Caso use monstro com mesmo efeito de acessório o efeito causado é melhor, não podendo acumular" (`CI:39`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `CV` | (tab 4) | 3 slots (`contractLen = 3`, `CV:27,49-62`) | MonsterFrame tab 4 | `MMOD.contractIds` (default `[0,0,0]`, `MMOD:80`) |
| `CI` | | Slot: beast icon, stars, accessory effect text or "Este monstro não tem acessório equipado", warning icon when another slot has the same kind and type with a higher level (`CI:180-246`, `MMOD:1001-1049`), remove button | contract view | beast + equipped accessory (bag 37) |
| `CS` | | Popup list of beasts not in any slot, sorted by star, level, type (`MMOD:962-999`); empty list text `MonsterExploreHeadSelectView.alertText.text` | click on a slot (`CI:122-140`); empty roster -> "Não há monstro a selecionar" | |

## 3. Routes (client to server)

### R1. Set a contract (op 21, CONTRACT)
- UI: pick a beast in `CS` (`CS:66-74`).
- Sender: `MM.sendSelectContract(index, monsterId)` (`MM:331-339`).
- Route: send 8652 (0x21cc) `C_MONSTER_CLIENT_OP`, `MonsterClientOpMsg`: `opType` (#1, INT32) = 21, `index` (#4, INT32) = slot 0..2, `monsterId` (#2, INT32) = beast id.
- Response: 4575 `opType` 8 with `contracts` (3 ids).

### R2. Remove a contract (op 21 with monster 0)
- UI: remove button `_delBtn` (`CI:150-153`).
- Route: 8652, `opType` = 21, `index` = slot, `monsterId` = 0.
- Response: 4575 `opType` 8 with the slot set to 0.

## 4. Server messages (server to client)

| Opcode | Message | Fields | Receiver | When |
|---|---|---|---|---|
| 4575 (0x11df) `U_C_MONSTER_USER_DATA` | `MonsterUserMsg` `opType` 8 | `contracts` (#7, INT32, repeated): always 3 entries, beast id or 0 | `MM.__monsterUserInfoHandler` (`MM:196-199,228-231`) -> `CONTRACT_INFO_CHANGE` -> `CV:66-100` | After R1/R2; after a contracted beast is consumed or deleted; also inside the opType 0 full sync |

The client ignores an empty `contracts` list, so always send exactly 3 values.

## 5. Rules and formulas

- 3 slots, a beast can occupy one slot only (the select list excludes contracted ids, `MMOD:962-974`). Setting a beast into a slot replaces the previous one.
- Effect per slot: the accessory characteristic computed as in [accessories.md](accessories.md) (highest summed `SonType`). Between slots with the same accessory kind (`Property6`) and the same characteristic `SonType`, only the highest summed grade applies (`MMOD:1001-1049`).
- No level or star restriction on contracted beasts in the client.
- Contracts are independent from "in battle" and "follow".

## 6. Templates

Uses the accessory and characteristic templates listed in [accessories.md](accessories.md).

## 7. Persistent state

```sql
CREATE TABLE monsters.contracts (
  player_id   BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  slot_index  SMALLINT NOT NULL CHECK (slot_index BETWEEN 0 AND 2),
  monster_id  BIGINT   REFERENCES monsters.monsters(monster_id) ON DELETE SET NULL,
  PRIMARY KEY (player_id, slot_index),
  UNIQUE (player_id, monster_id)
);
```

## 8. Backend implementation notes

- `monsters::contracts::handle_set` (op 21): `index` in 0..2 -> `monsterId` 0 clears; otherwise beast exists and belongs to the player -> transaction: remove the beast from any other slot, upsert the slot -> push 4575 opType 8 (3 ids).
- When a contracted beast is deleted (evolution or skill material), clear the slot and push opType 8.
- Battle configuration: when building the lord unit, add the buffs of each contract characteristic (skill template `SonType` 850..858 at the summed grade, de-duplicated per kind and type) to the lord; see `docs/battle/server-engine.md`.

## 9. Open questions and assumptions

- Assumption: contracts have no unlock condition beyond the frame unlock (level 70).
- Whether the characteristic also applies to the beast itself in battle (help says "o monstro e o personagem" for each characteristic, so the wearer gets it too; contracts extend it to the lord).
- Exact effect values are in skill buffer and talent templates (shared skills feature).

## 10. Implementation checklist

- [ ] Screen: contract tab, select popup, warning icon
- [ ] Route 8652 op 21 set and clear
- [ ] Server message 4575 opType 8 (always 3 ids)
- [ ] Table `monsters.contracts`
- [ ] Rule: one slot per beast, non stacking per kind and type
- [ ] Battle hook: contract characteristics on the lord
- [ ] Tests: replace slot, clear on beast deletion
