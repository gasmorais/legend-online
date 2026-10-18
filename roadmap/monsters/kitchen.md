# Kitchen (Cozinha)

Path aliases:

| Alias | File |
|---|---|
| MM | `decompiled/core_module/scripts/yishi/manager/MonsterManager.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| OVEN | `decompiled/m14/scripts/monster/item/MonsterKitchenItem.as` |
| V | `decompiled/m14/scripts/monster/` |

## 1. Overview

Four ovens ("Forno inicial", "Forno médio", "Forno avançado") produce beast food (item `SonType` 230) on a timer; the player collects it manually. Food is consumed by feeding ([growth.md](growth.md)). Help text item 2: "Os jogadores podem preparar comidas monstruosas usando a cozinha. Após cozinhar, precisa coletar manualmente." The module mirrors [summon.md](summon.md) but cooking needs no input.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/MonsterKitchenFrame.as` | "Cozinha" (`MonsterKitchenFrame.title.text`) | 4 oven slots (`cook_count = 4`, `:29`) | Embedded in the train tab (`V/view/MonsterTrainView.as:96,416-425`) | `cookDic` from 4575 `cooks` |
| `OVEN` | "Forno inicial/médio/avançado" | Idle: cook button, upgrade button, time "Tempo necessário: {0}", reward tip listing the possible foods of the oven level (`OVEN:302-331`); running: "Criando", countdown, cancel, finish now; done: "Criação terminada", collect; empty: unlock | kitchen frame | `level`, `state`, `stopTime`; tip from `MonsterCookDrop.xml` rows with `site` = level (`decompiled/core_module/scripts/yishi/datas/templates/cate/MonsterCookDropTempCate.as:20-31`) |

## 3. Routes (client to server)

All: send 8652 (0x21cc) `C_MONSTER_CLIENT_OP`, `MonsterClientOpMsg` with `opType` (#1, INT32) and `index` (#4, INT32) oven slot. Sender `MM.sendMonsterCallAndCookRequest(op, index)` (`MM:251-261`); `index` is omitted when the second argument is -1.

| Action | UI and client checks | op | Fields | Response |
|---|---|---:|---|---|
| Cook | cook button on an idle oven (`OVEN:229-236`) | 8 COOK | `index` | 4575 `opType` 3 with the oven `state` 1 and `stopTime` = now + duration |
| Finish now | confirm "Deseja gastar {0} diamantes para criar agora?" with `monster_cook_point_config[0]` = 100, then `judgePointEnoughToShowPay` (`OVEN:170-195`) | 9 COOK_FINISH | `index` | 4575 `opType` 3 with `stopTime` <= now; currency push |
| Collect | collect button when the timer is over (`OVEN:197-204`) | 11 COOK_GET | `index` | 4575 `opType` 3 (oven idle) and 4575 `opType` 4 (food counts) |
| Cancel | confirm "Deseja cancelar criação?" (`OVEN:206-227`) | 10 COOK_CANCEL | `index` | 4575 `opType` 3 |
| Upgrade | `isOpenUpGrade` is hard coded false: always "Esta função ainda não abriu" (`OVEN:74,238-268`); would confirm "Deseja gastar {0} diamantes para elevar para forno médio?" (500) / "...forno avançado?" (1000) | 12 COOK_UPGRADE | `index` | 4575 `opType` 3 with `level` + 1 |
| Unlock | unlock button on an empty slot, confirm "Deseja gastar {0} diamantes para liberar forno?" with 200 (`OVEN:270-295`) | 13 COOK_UNLOCK | none | 4575 `opType` 3 with the new `CookInfoMsg` |

## 4. Server messages (server to client)

| Opcode | Message | Fields | Receiver | When |
|---|---|---|---|---|
| 4575 (0x11df) `U_C_MONSTER_USER_DATA` | `MonsterUserMsg` `opType` 3 | `cooks` (#3, CookInfoMsg, repeated): `index` (#1, INT32), `level` (#2, INT32 1..3), `state` (#3, INT32 0 idle / 1 cooking or done), `stopTime` (#4, STRING `YYYY-MM-DD hh:mm:ss`) | `MM.__monsterUserInfoHandler` (`MM:160-172,212-215`) -> `MONSTER_COOK_CHANGE` -> `V/MonsterKitchenFrame.as:74-103` | After ops 8..13 |
| 4575 | `MonsterUserMsg` `opType` 4 | `items` (#4, ItemCountMsg, repeated): `templateId` (#1), `count` (#2); full list, client clears and refills (`MM:173-191`) | `MONSTER_ITEMMSG_CHANGE` refreshes the food bag of the train tab | After op 11 |

## 5. Rules and formulas

| Oven level | Duration | Possible foods (tip) |
|---|---|---|
| 1 Forno inicial | 30 min | 230001, 230002, 230003 |
| 2 Forno médio | 60 min | 230001 |
| 3 Forno avançado | 120 min | 230003 |

- Durations: `monster_cook_config` = "30,60,120" minutes (`raw/xml/tempinfos/ConfigInfos.xml`, `CIM:1071-1078`).
- Diamonds: `monster_cook_point_config` = "100,200,500,1000" (finish now, unlock, upgrade to medium, upgrade to advanced) (`CIM:1080-1087`).
- Drops: `raw/xml/tempinfos/MonsterCookDrop.xml`. Level 1 (`site` 1, `dropId` 1730100): 230001 x1 with `appearType` 1, and 230001, 230002, 230003 x1 with `appearType` 2 and 4. Level 2 (`site` 2, 1730200): 230001 x1 `appearType` 1. Level 3 (`site` 3, 1730300): 230003 x1 `appearType` 1. Assumption: `appearType` 1 = guaranteed, 2 and 4 = random pick groups of the shared drop engine (same semantics as other `*Drop.xml` files).
- Foods: 230001 "Espeto de carne" (20 food), 230002 "Espeto de carne e cogumelo" (10 food, 25 percent big success), 230003 "Espeto de cogumelo" (5 food, 50 percent big success) (`ItemTempInfos.xml` `Property1`, `Property2`).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/MonsterCookDrop.xml` | `dropId`, `site` (oven level), `itemId`, `count`, `isBind`, `appearType` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | foods `SonType` 230 |
| `raw/xml/tempinfos/ConfigInfos.xml` | `monster_cook_config`, `monster_cook_point_config` |

## 7. Persistent state

Uses `monsters.workshops` with `kind` = 2 and `monsters.material_items` (both defined in [summon.md](summon.md)). Optionally store the rolled result in `input_items` at cook time so finish/collect is deterministic.

## 8. Backend implementation notes

- `monsters::kitchen::handle_cook` (op 8): oven unlocked and idle -> `state` 1, `stop_at` = now + duration -> push 4575 opType 3.
- `monsters::kitchen::handle_finish` (op 9): running and not done -> debit 100 diamonds -> `stop_at` = now -> push.
- `monsters::kitchen::handle_cancel` (op 10): running -> reset -> push.
- `monsters::kitchen::handle_collect` (op 11): running and `stop_at <= now` -> roll `MonsterCookDrop` for `site` = level -> add to `material_items` -> reset oven -> push 4575 opType 3 then opType 4.
- `monsters::kitchen::handle_upgrade` (op 12): optional (client never sends).
- `monsters::kitchen::handle_unlock` (op 13): unlocked ovens < 4 -> debit 200 -> insert next slot -> push.
- One transaction per handler; no scheduler (lazy completion).

## 9. Open questions and assumptions

- Assumption: one oven unlocked by default.
- `appearType` semantics in `MonsterCookDrop.xml` (shared drop engine).
- Whether cooking has a gold cost (client shows none).
- Cancel refund: nothing to refund.

## 10. Implementation checklist

- [ ] Screen: kitchen frame inside the train tab, 4 ovens with tips
- [ ] Route op 8 cook
- [ ] Route op 9 finish now (100 diamonds)
- [ ] Route op 10 cancel
- [ ] Route op 11 collect with drop roll
- [ ] Route op 12 upgrade (optional)
- [ ] Route op 13 unlock (200 diamonds)
- [ ] Server message 4575 opType 3 and opType 4
- [ ] Table usage `monsters.workshops` kind 2, `monsters.material_items`
- [ ] Rule: durations 30/60/120 min and drops by oven level
- [ ] Tests: collect before end rejected, food counts added
