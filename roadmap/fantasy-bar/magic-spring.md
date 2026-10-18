# Magic spring ("Fonte Mágica")

Module `magic-spring` of feature `fantasy-bar`.

Path aliases:

| Alias | File |
|---|---|
| MSM | `decompiled/core_module/scripts/managers/MagicSpringManager.as` |
| MSO | `decompiled/core_module/scripts/mvc/module/magicspring/MagicSpringModel.as` |
| MSC | `decompiled/core_module/scripts/mvc/module/magicspring/MagicSpringConstClass.as` |
| MSF | `decompiled/m11/scripts/magicspring/MagicSpringFrame.as` |
| MSI | `decompiled/m11/scripts/magicspring/item/MagicSpringSlotItem.as` |

## 1. Overview

The player brews "magias" from recipes (`MagicSpringTempInfos.xml`, 21 recipes). Each recipe consumes three kinds of potions (250001 "Força da Coragem", 250002 "Coração da Sabedoria", 250003 "Fonte da Vida" for the basic recipes; 250004 "Poeira dos sonhos", 250005 "Chifre da Resistência", 250006 "Pena Etérea" for advanced ones) and fills one slot with a buff that lasts `ValidTime` hours ("Duração: {0} horas"). The same recipe cannot be active twice. Slot 1 is open; slots 2..5 unlock after using enough potions (`magic_spring_slot_open_count`) or by paying diamonds (`magic_spring_slot_open_forward_cost`). Cancelling a buff does not refund potions. Other features read active buffs by recipe id (`MSO.checkIsExistBuffer(id)`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `MagicSpringFrame` (MSF) | "Fonte Mágica" | recipe list, potions owned, recipe cost, make button, slot bar, help "Ajuda da Fonte Mágica" | toolbar `magicspring` (level 50) | potion counts (bag + stone), required `PotionCount1..3`, `Desc`, duration, make enabled when `totalGrade >= NeedGrade` (MSF:378-430) |
| `MagicSpringFormulaLeftView` / `MagicSpringFormulaLeftItem` | "Abre quando a função Receita atinge o nível {0}." | recipe list | MSF | icons, `NeedGrade` lock |
| `MagicSpringSlotTopView` / `MagicSpringSlotItem` (MSI) | "Desbloquear", "Condições de desbloqueamento", "Gastar {0} {1}/{2}" | 5 slots with countdown, unlock and cancel | MSF | `validCountDown` as countdown (MSI:226-240), unlock progress `potionCountN / slotOpenCount[slot-2][N-1]` (MSI:199-224) |
| `MagicSpringBufferAddView` | "Bônus de buff mágico: {0}", "Efeito temporário: {0}" | badge in consumer screens | consumers | buff desc and time |

## 3. Routes (client to server)

All use C>S 5189 (0x1445) `C_MAGIC_SPRING_OP`, `player.CommonMsg`, sender `MSM.sendMagicSpringRequest(param1, param2)` (MSM:103-110). Only `param1 (#1, INT32)` = op and `param2 (#2, INT32)` = argument are set; other `CommonMsg` fields `param3 (#3, INT32)`, `param4 (#4, STRING)`, `param5 (#5, STRING)`, `param6 (#6, INT64)`, `param7 (#7, INT64)` are unused.

| op | Constant (MSM:20-26) | UI | Call site | Client checks | Server effect |
|---|---|---|---|---|---|
| 1 | `OPEN_SLOT` | "Desbloquear" + "Deseja gastar {0} diamantes para abrir antecipadamente um slot de equipamento mágico?" | MSI:99-121 | `point >= slotNeedCost[slot-2]` else recharge | debit diamonds, `open_slot_count += 1`, push 172 |
| 2 | `MAKE_FORMULA`, `param2 = recipe id` | make + "Confirma que deseja gastar poções mágicas para preparar {0}?" | MSF:331-377 | 2 s anti double click; potions enough ("Poções mágicas insuficientes, não é possível preparar."); not already active ("Não pode preparar repetidamente a mesma magia."); free slot ("Todos slots de equipamento mágico estão ocupados; não é possível preparar."); level >= `NeedGrade` | consume potions, add usage counters, add slot with `ValidTime * 3600` s, push 172 with `new_temp_id` |
| 3 | `CANCEL_FORMULA`, `param2 = recipe id` | cancel + "Deseja cancelar o efeito mágico atual? Se cancelar, as poções mágicas usadas para preparar a magia não serão devolvidas." | MSI:123-143 | | remove slot, push 172 |
| 4 | `REQUEST_INFO` | automatic when any slot countdown reaches 0 | `MSO.checkBufferTime` (MSO:65-81), called every second from `PlayerModel` (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerModel.as:413`) | | drop expired slots, push 172 |

## 4. Server messages (server to client)

### S1. 172 (0x00ac) `U_C_MAGIC_SPRING_INFO`, `player.MagicSpringMsg`
Receiver `MSM.__updateMagicSpringMsg` (MSM:63-101).

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `open_slot_count` | #1 | INT32 | unlocked slots (client default 1) |
| `slotList` | #2 | `MagicSpringSlotMsg`, repeated | active buffs: `temp_id (#1, INT32)` recipe id, `valid_count_down (#2, INT32)` seconds left |
| `potion_count_1..3` | #3..#5 | INT32 | cumulative potions used of 250001, 250002, 250003 (slot unlock progress) |
| `new_temp_id` | #6 | INT32 | non zero after a successful make: client plays `MAKE_SUCCESS_BACK`; else `INFO_CHANGE_BACK` |

The slot list is always replaced. Send at login, after every 5189 and when a buff expires (or let op 4 trigger it).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Open level | 50 (`magic_spring_open_grade`) | `ConfigInfos.xml`, `TopBtnCheckShowHelper.as:369-370` |
| Potions | 250001..250006 (`magic_spring_item_tempid`) | `ConfigInfos.xml`, MSO constructor |
| Slot unlock by usage | slot 2: 100/60/20, slot 3: 200/120/60, slot 4: 400/240/120, slot 5: 800/480/240 of potions 1/2/3 used | `magic_spring_slot_open_count`, MSI:209-221 |
| Slot unlock by diamonds | slot 2: 100, 3: 200, 4: 300, 5: 400 | `magic_spring_slot_open_forward_cost` |
| Duration | `ValidTime` hours | MSF:424 |
| One per recipe | yes | MSF:351-356 |

Recipes (`MagicSpringTempInfos.xml`: id, name, AddValue %, hours, potion1 x n, potion2 x n, potion3 x n, NeedGrade):

| id | Name | Add | h | Cost | Need | Consumer (`MagicSpringConstClass`) |
|---|---|---|---|---|---|---|
| 1 | Toque de Midas | 100 | 2 | 250001x25, 250002x5, 250003x5 | 50 | CASTLE_GOLD: castle levy, buildings, cat house, battle report (`decompiled/m4/scripts/buildings/politics/view/LevyView.as:124`) |
| 2 | Adivinhação | 100 | 8 | x40, x20, x5 | 50 | FARM_PRODUCT (`decompiled/m3/scripts/farm/newview/FarmView.as:74`) |
| 4 | Olho de Águia | 50 | 2 | x50, x30, x5 | 50 | SINGLE_CAMPAIGN_ITEM (`decompiled/m13/scripts/selectcampaign/SelectCampaignFrame.as:84-93` also checks 3) |
| 5 | Clarividência | -25 | 2 | x50, x10, x5 | 50 | STAR_REDUCE: cosmos cost (`decompiled/m5/scripts/star/view/MakeStarView.as:140`) |
| 6 | Ora‎ção | 50 | 4 | x45, x25, x5 | 50 | REWARD_QUEST_EXP (`decompiled/m15/scripts/offerreward/OfferRewardFrame.as:69`) |
| 7 | Proteção Divina | 50 | 2 | x10, x15, x5 | 55 | PET_REMOTE_ITEM (`decompiled/m14/scripts/remotepet/RemotePetTurnFrame.as:92`) |
| 8 | Coração Honrado | 50 | 8 | x35, x10, x5 | 50 | WAR_FIELD_HONOR (`decompiled/m13/scripts/worldboss/PvpSelectFrame.as:114`) |
| 10 | Teleportação | 100 | 4 | x35, x60, x25 | 50 | REPEAT_REWARD_BOX (`decompiled/m15/scripts/task/TaskFrameII.as:245`) |
| 11 | Sacrifício | 100 | 6 | x20, x20, x10 | 50 | PET_ISLAND_DROP_ITEM |
| 12 | Luz da Vida | 50 | 2 | x15, x20, x10 | 60 | SKY_TRIAL_SCAN_ITEM (`decompiled/m11/scripts/skyboxroad/SkyBoxRoadFrame.as:177`) |
| 13 | Milagre da Multiplicação | 50 | 4 | x15, x40, x15 | 70 | CHILD_PATROL_ITEM (`decompiled/m14/scripts/childpatrol/ChildPatrolHallFrame.as:139`) |
| 14 | Técnica de refino | 50 | 4 | x20, x30, x10 | 70 | COAGULATION_ITEM |
| 15 | Coração sincero | 100 | 2 | x35, x10, x5 | 70 | SINCERE_HEART_ITEM: magic pub (`decompiled/m11/scripts/magicpub/MagicPubListView.as:88`) |
| 16 | Poção de profecia | 50 | 4 | 250004x25, 250005x35, 250006x35 | 70 | PROPHET_MEDICAMENT_ITEM (`decompiled/m11/scripts/outyard/shuttle/OutyardShuttleFrame.as:220`) |
| 17 | Bênção do Titã | 50 | 4 | x30, x25, x15 | 70 | TEMPLE_SECRET_ITEM (`decompiled/m11/scripts/outyard/titan/OutyardTitanFrame.as:123`) |
| 18 | Poção de Vitalidade | 100 | 2 | x35, x25, x25 | 70 | ENERGY_MEDICAMENT_ITEM (`decompiled/m11/scripts/abysm/AbysmFrame.as:120`) |
| 20 | Tatuagem | 100 | 8 | 250001x5, 250002x25, 250003x10 | 70 | PERKIN_LAB_ITEM (`decompiled/m11/scripts/perkinlab/PerkinLabFrame.as:107`) |
| 21 | Círculo de Magia Negra | 100 | 2 | 250004x40, x20, x10 | 70 | DEMON_LANG_ITEM (`decompiled/m11/scripts/demonland/DemonLandFrame.as:146`) |
| 22, 23, 24 | Redentor, Vingador, Deus do Combate | 100 | 2 | 250004..250006 | 161 | no constant in this client |

Constants 3 (SINGLE_CAMPAIGN_EXP), 9 (ISLAND_EXPLORE) and 19 (FAITH_POWERL_ITEM, `decompiled/m11/scripts/lordtrial/LordTrialMainFrame.as:209`) have no recipe row in the shipped XML.

## 6. Templates

| File | Fields |
|---|---|
| `MagicSpringTempInfos.xml` | `TemplateId`, `TemplateName`, `Desc`, `AddValue`, `ValidTime`, `ItemTempId1..3`, `PotionCount1..3`, `NeedGrade`, `Icon`, `IsActive` |
| `ConfigInfos.xml` | `magic_spring_open_grade`, `magic_spring_item_tempid`, `magic_spring_slot_open_count`, `magic_spring_slot_open_forward_cost` |

## 7. Persistent state

```sql
CREATE TABLE fantasy_bar.spring_states (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  open_slot_count SMALLINT NOT NULL DEFAULT 1 CHECK (open_slot_count BETWEEN 1 AND 5),
  potion_used_1   INTEGER NOT NULL DEFAULT 0,
  potion_used_2   INTEGER NOT NULL DEFAULT 0,
  potion_used_3   INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE fantasy_bar.spring_buffs (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  recipe_id       SMALLINT NOT NULL,
  expires_at      TIMESTAMPTZ NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, recipe_id)
);
CREATE INDEX spring_buffs_expiry ON fantasy_bar.spring_buffs (expires_at);
```

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 1 | `fantasy_bar::magic_spring::handle_open_slot` |
| 2 | `fantasy_bar::magic_spring::handle_make` |
| 3 | `fantasy_bar::magic_spring::handle_cancel` |
| 4 | `fantasy_bar::magic_spring::handle_info` |

- Make: validate recipe exists and `IsActive`, level, not active, free slot (`count(buffs) < open_slot_count`), potions in bag and stone storage; consume, add usage counters (assumption: only potions 1..3 count toward unlock), insert buff, push 172 with `new_temp_id`.
- Unlock by usage: when counters reach the next slot thresholds, auto increase `open_slot_count` (assumption: server applies it on make).
- Expose `fantasy_bar::magic_spring::active_bonus(player_id, recipe_id) -> Option<i32 AddValue>` for other features; they must apply the multiplier server side.

## 9. Open questions and assumptions

- Whether usage counters include potions 4..6.
- Recipes 22..24 have no consumer constant in this client.

## 10. Implementation checklist

- [ ] Screen `MagicSpringFrame` with slots and recipes
- [ ] Route 5189 ops 1..4
- [ ] Server message 172 at login and after changes
- [ ] Tables `fantasy_bar.spring_states`, `fantasy_bar.spring_buffs`
- [ ] Bonus API used by castle, farm, campaign, cosmos, offer reward, pets, war field, tasks, sky trial, child patrol, magic pub, outyard, abyss, laboratory, demon land
- [ ] Tests: slot thresholds, duplicate recipe, expiry, cancel without refund
