# Summon (Invocar círculo)

Path aliases:

| Alias | File |
|---|---|
| MM | `decompiled/core_module/scripts/yishi/manager/MonsterManager.as` |
| MMOD | `decompiled/core_module/scripts/mvc/module/monster/MonsterModel.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| CIRCLE | `decompiled/m14/scripts/monster/item/MonsterCircleItem.as` |
| CALL | `decompiled/m14/scripts/monster/MonsterCallFrame.as` |
| V | `decompiled/m14/scripts/monster/` |

## 1. Overview

New beasts come from four magic circles ("Círculo inicial", "Círculo médio", "Círculo avançado"). A circle consumes 3 to 6 summon materials (crystals and essences, item `SonType` 231, gathered in Monster Exploration), runs a timer (120, 240 or 480 minutes by circle level) and then yields a random beast that the player collects. Diamonds can unlock a new circle, finish a timer at once or (disabled in this client) upgrade a circle. Help text item 1: "Jogadores podem invocar monstros através do círculo de invocação. Para invocar é preciso gastar materiais de monstros. Diferente monstros podem ser invocados combinando materiais diferentes."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/MonsterMagicCircleFrame.as` | "Invocar círculo" (`:47`) | 4 circle slots (`circle_count = 4`, `:29`) sorted by `index` (`:92-103`) | Embedded in the handbook tab (`V/view/MonsterHandBookView.as:34,80-89`) | `MMOD.magicCircleDic` from 4575 `calls` |
| `CIRCLE` | "Círculo inicial/médio/avançado" (`MonsterCircleItem.nameText.text1..3`) | One slot: idle (summon + upgrade buttons, "Tempo necessário: {0}"), running ("Invocando", countdown, cancel + finish now), done ("Invocação concluída", collect), empty slot (unlock button) | circle frame | `level`, `state`, `stopTime` (`CIRCLE:283-336`) |
| `CALL` | "Invocar" (`ChildHandBookItem.callBtn.text`, `:301-306`) | Pick materials: recipe pager (name and description of `RecipeTemplates.xml`, display only, `:114-122,199-211`), 10 bag cells of `SonType` 231 items, 6 material slots, text "N° de materiais necessários: {0}" (`:272-281`) | circle "summon" button (`CIRCLE:271-277`) | `MMOD.callBagDic`, `MMOD.callMaterialList` |

## 3. Routes (client to server)

All routes: send 8652 (0x21cc) `C_MONSTER_CLIENT_OP`, `MonsterClientOpMsg` fields used: `opType` (#1, INT32), `index` (#4, INT32) circle slot, `items` (#6, INT32, repeated) material template ids (one entry per unit). Unused here: `monsterId` (#2), `skillId` (#3), `payType` (#5), `param1` (#7), `param2` (#8), `param3` (#9, STRING), `param4` (#10, STRING).

### R1. Summon (op 2, CALL)
- UI: circle "summon" button -> `CALL`; "Invocar" `_callBtn` (`CALL:213-226`).
- Client checks: number of selected units >= `needMinCount` = first value of `monster_call_config[level - 1]` (3, 4, 5) else "Material insuficiente, não pode convocar" (`CALL:219-224,272-281`); at most 6 units (`MMOD:365-371`, message "Espaço na mochila insuficiente").
- Sender: `MM.sendMonsterCall(index, items)` (`MM:263-271`).
- Request: `opType` = 2, `index` = slot, `items` = template ids (duplicates allowed).
- Response: 4575 `opType` 2 with the slot now `state` 1 and `stopTime` = now + duration (the call frame closes on `MONSTER_CALL_CHANGE`, `CALL:186-189`); 4575 `opType` 4 with the full remaining material list.

### R2. Finish now (op 3, CALL_FINISH)
- UI: finish button while running, confirm "Deseja gastar {0} diamantes para invocar agora?" with `monster_call_point_config[0]` = 100 (`CIRCLE:153-178`).
- Client checks: `LogicUtils.judgePointEnoughToShowPay(100)` (diamonds, opens recharge when short).
- Request: `opType` = 3, `index`.
- Response: 4575 `opType` 2 with `stopTime` <= now (slot shows "Invocação concluída" and collect). Diamond balance push (currency feature).

### R3. Cancel (op 4, CALL_CANCEL)
- UI: cancel while running, confirm "Deseja cancelar invocação?" (`CIRCLE:180-201`).
- Request: `opType` = 4, `index`.
- Response: 4575 `opType` 2 slot back to `state` 0; materials refund is an assumption (see Open questions); if refunded also 4575 `opType` 4.

### R4. Collect (op 5, CALL_GET)
- UI: collect button when the timer is over (`CIRCLE:262-269,326-334`).
- Request: `opType` = 5, `index`.
- Server checks: slot running and `stop_at <= now`; roster size < 40.
- Response: 4574 `opType` 5 with the new beast; 4575 `opType` 2 with the slot idle.

### R5. Upgrade circle (op 6, CALL_UPGRADE)
- UI: upgrade button visible on idle circles with `level < 3` (`CIRCLE:316`), but `isOpenUpGrade` is hard coded false so the client always shows "Esta função ainda não abriu" and never sends (`CIRCLE:65,230-236`).
- Would send: confirm "Deseja gastar {0} diamantes para elevar para círculo médio?" (500) or "...círculo avançado?" (1000) (`monster_call_point_config[2]`, `[3]`, `CIRCLE:300`), then `opType` = 6, `index`.
- Response if implemented: 4575 `opType` 2 with `level` + 1.

### R6. Unlock a circle (op 7, CALL_UNLOCK)
- UI: unlock button on an empty slot (no `CallInfoMsg` for that position), confirm "Deseja gastar {0} diamantes para liberar círculo?" with `monster_call_point_config[1]` = 200 (`CIRCLE:203-228`).
- Client bug: the handler returns early when `data` is set, so it only works on empty slots (intended).
- Request: `opType` = 7, no `index` (server unlocks the next slot).
- Response: 4575 `opType` 2 with the new `CallInfoMsg` (`index` = next, `level` 1, `state` 0).

## 4. Server messages (server to client)

| Opcode | Message | Fields used here | Receiver | When |
|---|---|---|---|---|
| 4575 (0x11df) `U_C_MONSTER_USER_DATA` | `MonsterUserMsg` `opType` 2 | `calls` (#2, CallInfoMsg, repeated): `index` (#1), `level` (#2), `state` (#3, 0 idle, 1 running or done), `stopTime` (#4, STRING `YYYY-MM-DD hh:mm:ss`) | `MM.__monsterUserInfoHandler` (`MM:147-159,208-211`) -> `MONSTER_CALL_CHANGE` refreshes `V/MonsterMagicCircleFrame.as:86-103` and closes `CALL` | After ops 2..7 |
| 4575 | `MonsterUserMsg` `opType` 4 | `items` (#4, ItemCountMsg, repeated) full list of material counts (client clears then refills, `MM:173-191`) | same, `MONSTER_ITEMMSG_CHANGE` | After op 2 and any material change |
| 4575 | `MonsterUserMsg` `opType` 5 | `recipes` (#5, INT32, repeated) | `MONSTER_RECIPE_CHANGE` (only refreshes the recipe text, `CALL:191-197`) | Unknown trigger (assumption: recipe discovered) |
| 4574 (0x11de) `U_C_MONSTER_DATA_LIST` | `MonsterListMsg` `opType` 5 | new `MonsterMsg` row | `MM.__monsterListHandler` | After op 5 |

The circle shows "Invocando" while `stopTime > server time` and "Invocação concluída" otherwise (`CIRCLE:338-360`), so the server only stores the end time.

## 5. Rules and formulas

| Circle level | Min materials | Duration | Source |
|---|---|---|---|
| 1 Círculo inicial | 3 | 120 min | `monster_call_config` = "3,120|4,240|5,480" (`raw/xml/tempinfos/ConfigInfos.xml`, defaults `CIM:1053-1060`) |
| 2 Círculo médio | 4 | 240 min | same |
| 3 Círculo avançado | 5 | 480 min | same |

- Max materials per summon: 6 slots (`CALL:126-138`, `MMOD:367`).
- Diamond costs `monster_call_point_config` = "100,200,500,1000": finish now, unlock circle, upgrade to medium, upgrade to advanced (`CIM:1062-1069`).
- Slots: 4 maximum. Initial unlocked slots: assumption 1 (the client renders missing slots as locked).
- Result: recipes in `RecipeTemplates.xml` describe the pool. Recipe 0 "Círculo de invocação de monstros": any materials, random beast. Recipes 1..4: "Pelo menos 4 materiais coletados do" Pasto Livre / Floresta Nublada / Pântano Sem Fim / Deserto da Morte, each with its beast list (for example Deserto da Morte: Soldado Imortal, Guardião Imortal, Lanceiro Demônio, Arqueiro Demônio, Verme Devorador de Espíritos, Verme Devorador de Almas, Espada Destruidora de Almas, Arma de Espíritos, Escudo Protetor de Almas). Server rule (assumption): when >= 4 units come from the same region (crystal 23100N or essence 23100N+5 of region N) use that region recipe, else recipe 0; pick a random beast type of the pool; star 1, level 1, stage 0.
- Material regions: 231001/231006 Pasto Livre, 231002/231007 Floresta Nublada, 231003/231008 Pântano Sem Fim, 231004/231009 Deserto da Morte, 231005/231010 Dimensão do Abismo (no recipe row for the last one).
- Roster cap 40 checked at collect.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/RecipeTemplates.xml` | `TemplateId` 0..4, `Name`, `Desc` (display; pools only in text) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | `SonType` 231 materials 231001..231010 |
| `raw/xml/tempinfos/MonsterTemplates.xml` | beast types by name for the pools |
| `raw/xml/tempinfos/ConfigInfos.xml` | `monster_call_config`, `monster_call_point_config` |

## 7. Persistent state

```sql
CREATE TABLE monsters.material_items (
  player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id INTEGER NOT NULL,
  count       INTEGER NOT NULL CHECK (count >= 0),
  PRIMARY KEY (player_id, template_id)
);

CREATE TABLE monsters.workshops (
  player_id     BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  kind          SMALLINT    NOT NULL CHECK (kind IN (1, 2)),
  slot_index    SMALLINT    NOT NULL CHECK (slot_index BETWEEN 1 AND 4),
  level         SMALLINT    NOT NULL DEFAULT 1 CHECK (level BETWEEN 1 AND 3),
  state         SMALLINT    NOT NULL DEFAULT 0 CHECK (state IN (0, 1)),
  stop_at       TIMESTAMPTZ,
  input_items   INTEGER[]   NOT NULL DEFAULT '{}',
  result_type   SMALLINT,
  PRIMARY KEY (player_id, kind, slot_index)
);

CREATE TABLE monsters.recipes_unlocked (
  player_id  BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  recipe_id  SMALLINT NOT NULL,
  PRIMARY KEY (player_id, recipe_id)
);
```

`kind` 1 = summon circle, 2 = kitchen oven ([kitchen.md](kitchen.md)). `material_items` holds the item counts sent in `MonsterUserMsg.items` (`SonType` 230 food and 231 summon materials); they live outside the normal bag.

## 8. Backend implementation notes

- `monsters::summon::handle_call` (op 2): validate slot unlocked and idle -> `items` count between `min` and 6 -> every template has `SonType` 231 and the player owns the counts -> transaction: decrement `material_items`, set `state` 1, `stop_at` = now + duration(level), store `input_items` (and optionally roll `result_type` now) -> push 4575 opType 2, 4575 opType 4.
- `monsters::summon::handle_finish` (op 3): slot running and `stop_at > now` -> debit 100 diamonds -> `stop_at` = now -> push 4575 opType 2 + currency update.
- `monsters::summon::handle_cancel` (op 4): slot running -> reset slot (refund policy per Open questions) -> push.
- `monsters::summon::handle_collect` (op 5): slot running and `stop_at <= now` -> roster < 40 -> create beast (type from `result_type` or roll now) -> reset slot -> push 4574 opType 5 and 4575 opType 2.
- `monsters::summon::handle_upgrade` (op 6): optional (client never sends); debit 500/1000, level + 1.
- `monsters::summon::handle_unlock` (op 7): count unlocked circles < 4 -> debit 200 -> insert next slot -> push 4575 opType 2.
- No scheduler needed: completion is lazy (`stop_at` compared at collect). Optional tip push when a timer ends.

## 9. Open questions and assumptions

- Assumption: cancel refunds nothing (the confirm text gives no hint). Alternative: refund `input_items`.
- Assumption: one circle is unlocked by default (exploration first gift may also unlock it).
- The exact beast pool weights and the effect of essences vs crystals are server side only.
- Meaning of `recipes` (#5) is unknown; the client stores it but never reads it.
- Circle upgrade is disabled client side; implement only if the server should accept it.

## 10. Implementation checklist

- [ ] Screen: magic circle frame (4 slots: locked, idle, running, done)
- [ ] Screen: call frame material selection and minimum count text
- [ ] Route op 2 summon
- [ ] Route op 3 finish now (100 diamonds)
- [ ] Route op 4 cancel
- [ ] Route op 5 collect -> new beast
- [ ] Route op 6 upgrade (optional)
- [ ] Route op 7 unlock (200 diamonds)
- [ ] Server message 4575 opType 2, 4, 5
- [ ] Server message 4574 opType 5
- [ ] Table `monsters.material_items`
- [ ] Table `monsters.workshops` (kind 1)
- [ ] Table `monsters.recipes_unlocked`
- [ ] Rule: min materials and durations by level
- [ ] Rule: region recipe selection and roster cap
- [ ] Tests: timer states, diamond debit, collect before end rejected
