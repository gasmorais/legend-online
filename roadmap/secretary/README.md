# Pequena Secretária (`secretary`)

Domain: home. Client package `secretary` (m11: `secretary/LittleSecretaryFrame.as`, `SecretaryAwardFrame.as`, `item/*`, `view/*`) plus shared code in `core_module`: `managers/SecretaryManager.as`, `managers/LitteActionManager.as`, `mvc/controler/SecretaryContractControler.as`, `mvc/module/secretary/SecretaryData.as`, `SecretaryItemData.as` and the 9 task actions in `mvc/module/secretary/acts/*`. No protobuf package of its own: it uses `player.AssistantMsg`, `player.NeedGoldMsg`, `player.PlayerOpMsg` and the routes of the features it automates. Template `AssistantTemplates.xml`.

## Overview

"Pequena Secretária" is a one click daily chores assistant opened from the resource bar. It lists 9 chores grouped in 5 tabs ("Recompensa", "Labirinto", "Fabricar", "Cidade", "Guilda"). Each chore is shown only when it can run now; the player can untick chores and choose "Uso de diamantes vinculados prioritários" for paid ones. The execute button (style `LittleSecretaryFrame.exeBtn`, label is artwork) runs the chores of the current tab, the execute all button (`LittleSecretaryFrame.allBtn`) runs every chore. After a confirmation summarizing diamonds, bound diamonds and gold to spend, the panel hides and an "Executando" result frame lists what each chore produced (maze sweeps progress live), switching to "Execução Concluída" when the queue ends.

| Type | Tab (`MaterType`) | Chore (pt-BR) | What it does | Owner feature |
|---|---|---|---|---|
| 1 | 1 Recompensa | "Recompensa": "Concluir Todas as Missões de Recompensa" | one key completion of every remaining bounty quest (68 diamonds) | [quests](../quests/README.md) |
| 2 | 2 Labirinto | "Labirinto Subterrâneo" | buy 1 "Chave do Labirinto" if needed, reset and sweep maze 8001 with double gains | [mazes](../mazes/README.md), [mopup](../mopup/README.md) |
| 3 | 2 Labirinto | "Labirinto do Abismo" | same with 3 keys, maze 8101 | [mazes](../mazes/README.md), [mopup](../mopup/README.md) |
| 4 | 2 Labirinto | "Labirinto do Purgatório" | same with 3 "Chave do Purgatório", maze 8401 | [mazes](../mazes/README.md), [mopup](../mopup/README.md) |
| 5 | 3 Fabricar | "Síntese de Gemas": "Sintetizar todos os Gemas da Mochila para Nv. 6" | one key gem compose (owned here: 9741 / 593) | this feature, rules from [smith](../smith/README.md) |
| 6 | 4 Cidade | "Coleta de Impostos" | collect every remaining tax | [castle](../castle/levy.md) |
| 7 | 4 Cidade | "Laboratório de Platina" | one key lab collection (9566 op 11, owned here) | [laboratory](../laboratory/README.md) |
| 8 | 4 Cidade | "Fazenda e Pastagem" | auto harvest farm and pasture (15044 op 25 and 26) | [farm](../farm/README.md) |
| 9 | 5 Guilda | "Altar" | bless the guild altar as many times as allowed | [guild](../guild/buildings.md) |

## Entry points

| Entry | Condition | Opens | Source |
|---|---|---|---|
| Resource bar secretary icon (`secrearytary.icon`) | always present | controller `SECRETARY` openType 0 -> `LittleSecretaryFrame` (preloads the `mopup` UI) | `decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as:185,232,339-345`, `decompiled/core_module/scripts/mvc/controler/SecretaryContractControler.as:25-32`, `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:1282-1283,1478-1479` |
| Execution start (non gem chore) | | controller `SECRETARY` openType 1 -> `SecretaryAwardFrame` | `decompiled/m11/scripts/secretary/LittleSecretaryFrame.as:279-283,366-370` |

## Modules

| Module | File | Scope |
|---|---|---|
| Assistant panel | [assistant-panel.md](assistant-panel.md) | panel data requests, chore visibility and cost rules, selection, confirmation, execution queue, result frame and 592 |
| Chore actions | [chore-actions.md](chore-actions.md) | the 9 chores: routes sent, server behavior, responses; owns 9741 one key gem compose and 9566 op 11 lab collection |

## Protocol summary

| Dir | Opcode | Hex | Name | Module |
|---|---|---|---|---|
| C>S | 9742 | 0x260e | `C_GET_TOWER_LIST` (empty body) | assistant-panel |
| C>S | 8215 | 0x2017 | `U_C_CONSORTIA_ALTERINFO` request (empty body) | assistant-panel |
| C>S | 9741 | 0x260d | `C_GEM_ONE_KEY_COMPOSE` (`PlayerOpMsg` op 0 query, 1 execute) | assistant-panel, chore-actions |
| C>S | 9583 | 0x256f | `C_REWARD_ONEKEY` (`PayTypeMsg`) | chore-actions |
| C>S | 8970 | 0x230a | `C_SHOPCAR_BUY` (maze keys) | chore-actions |
| C>S | 8299 | 0x206b | `C_TOWER_RESET` (`TowerInfoReqMsg`) | chore-actions |
| C>S | 8528 | 0x2150 | `C_CAMPAIGN_SWEEP` (`CampaignSweepReq`) | chore-actions, assistant-panel (accelerate) |
| C>S | 8327 | 0x2087 | `C_GOLD_IMPOSE` (`PlayerOpMsg` op 2) | chore-actions |
| C>S | 9566 | 0x255e | `C_PERKIN_LAB_CLIENT` (op 11) | chore-actions |
| C>S | 15044 | 0x3ac4 | `CH_FARM_OPER_CHECK` (op 25, 26) | chore-actions |
| C>S | 5145 | 0x1419 | `U_C_CONSORTIA_FRESHALTAR` (`PropertyMsg`) | chore-actions |
| S>C | 4373 | 0x1115 | `U_C_TOWERLIST` (`TowerListMsg`) | assistant-panel |
| S>C | 4141 | 0x102d | `U_C_CONSORTIA_ALTERINFO` (`ConsortiaMsg`) | assistant-panel |
| S>C | 593 | 0x0251 | `U_C_GEM_ONE_KEY_COMPOSE_NEED_GOLD` (`NeedGoldMsg`) | assistant-panel |
| S>C | 592 | 0x0250 | `U_C_ASSISTANT_ITEMS` (`AssistantMsg`) | assistant-panel |
| S>C | 4783 | 0x12af | `U_C_SHOPCAR_RESULT` (`ShopCarListMsg`) | chore-actions |
| S>C | 4425 | 0x1149 | `U_C_CAMPAIGN_SWEEP` (`CampaignSweepRsp`) | chore-actions |

## Dependencies

All chore effects belong to their owner features (table above); the secretary server side only adds the 592 summary after each chore and the two routes it owns (9741, 9566 op 11). Also: [currency](../currency/README.md) (diamonds, bound diamonds, gold), [vip](../vip/README.md) (King Contract buff 4 for free sweep acceleration), [shops](../shops/README.md) (8970).

## Suggested implementation order

1. Panel data: 9742 -> 4373, 8215 -> 4141, 9741 op 0 -> 593 (the panel renders from existing player state).
2. 592 `AssistantMsg` emission hooks in each owner handler when the request comes from the secretary (or always, see open questions).
3. Owned chores: 9741 op 1 gem compose, 9566 op 11 lab collection.
4. Delegated chores in dependency order: levy (8327 op 2), farm (15044 op 25/26), offer reward (9583), altar (5145), mazes (8970, 8299, 8528).
