# Bots and sweep ("Bots e varredura", "Modo Bot")

Domain: pve. Client package `mopup` (M5 frames `mopup.view.*`, core `mvc.module.mopup`, `managers.MopupManager`, controller `mvc.controler.MopupController` key `mopup`). No own protobuf package: sweeps use the protocol of the activity they belong to. This feature catalogs every sweep ("Modo Bot", "BOT", "Bot") and auto battle route of the client so that each owning activity implements it consistently.

A sweep replays already cleared content without fighting: the player picks a count or a target floor, pays gold and the activity resource (Energia, Lágrimas da Deusa, Corações de Vingança, Chaves do Julgamento), and the server produces one result per fixed time slice (60 s per campaign run, 6 s per maze floor, 30 s per abyss/expedition/trial floor). The "in progress" frame polls the server, can be accelerated with diamonds ("Aceleramento consome {0} diamantes", `Sweep_Fast` = 1 diamond per 10 minutes) or for free with the elf contract buff ("Contrato dos Elfos", buff id 4), and keeps running offline ("Modo Bot pode estar em andamento offilne"). While a sweep runs the HUD shows a sweep state (`MainToolBar.mopupIng`, `SmallMapBar.mopupIng`, `TopToolsBar.mopupIng`).

PostgreSQL schema: `mopup` (shared sweep job table). Rust handlers: `mopup::<module>::handle_<action>`, called from the owner activity dispatchers.

Path aliases:

| Alias | Path |
|---|---|
| `MM` | `decompiled/core_module/scripts/managers/MopupManager.as` |
| `MMOD` | `decompiled/core_module/scripts/mvc/module/mopup/MopupModel.as` |
| `MC` | `decompiled/core_module/scripts/mvc/controler/MopupController.as` |
| `V` | `decompiled/m5/scripts/mopup/view/` |
| `OYM` | `decompiled/core_module/scripts/yishi/manager/OutyardManager.as` |

## Catalog of sweep and auto battle routes

| Activity (owner feature) | pt-BR | Request | Response | Frames (`MC` openType) | Module |
|---|---|---|---|---|---|
| Campaign ([campaign](../campaign/README.md)) | "Modo Bot" | 8528 `C_CAMPAIGN_SWEEP` sweepType 1 | 4425 `U_C_CAMPAIGN_SWEEP` | 1 prepare, 2 in progress | [campaign-sweep.md](campaign-sweep.md) |
| Labirinto / maze, also Abismo and Purgatório tabs ([mazes](../mazes/README.md)) | "Modo Bot", "Limpeza do Purgatório" | 8528 sweepType 2 | 4425 | 3, 4 | [campaign-sweep.md](campaign-sweep.md) |
| Secretary maze tasks ([secretary](../secretary/README.md)) | - | 8528 sweepType 2 (campaigns 8001, 8101, 8401) | 4425 | none (secretary UI) | [campaign-sweep.md](campaign-sweep.md) |
| Vórtice do Tempo ([trials](../trials/README.md)) | "Modo Bot" | 8528 sweepType 3 | 4425 | 11, 12 | [campaign-sweep.md](campaign-sweep.md) |
| Continente dos Demônios ([trials](../trials/README.md)) | "Bot do Continente dos Demônios" | 8528 sweepType 4 | 4425 | 13, 14 | [campaign-sweep.md](campaign-sweep.md) |
| Caminho da Vingança ([roads](../roads/README.md)) | "Bot do Caminho da Vingança" | 8528 sweepType 5 | 4425 | 15, 16 | [campaign-sweep.md](campaign-sweep.md) |
| Terra Sombria ([trials](../trials/README.md)) | "Bot da Terra Sombria" | 8528 sweepType 6 | 4425 | 19, 20 | [campaign-sweep.md](campaign-sweep.md) |
| Caminho Final ([roads](../roads/README.md)) | "Bot" | 8528 sweepType 8 | 4425 (assumption) | none | [campaign-sweep.md](campaign-sweep.md) |
| Abismo sem fim and Inferno ([abyss](../abyss/README.md)) | "Modo Bot Abismo sem fim", "Bot do Abismo Sem Fim (Inferno)" | 9644 `C_GUARDENDLESS_OP` opType 3, 4, 5, 6, 7 | 423, 428 | 7, 8, 17, 18 | [abyss-sweep.md](abyss-sweep.md) |
| Expedição (remote pets, [einherjar](../einherjar/README.md)) | "Expedição automática" | 9544 `C_REMOTE_PET_OP` op 7, 8, 9, 10 | 4964, 4967 | 5, 6 | [other-sweeps.md](other-sweeps.md) |
| Julgamento (lord trial, [trials](../trials/README.md)) | "Bot do Julgamento" | 9650 `C_LORD_TRIAL_OP` op 6, 7, 8 | 445 (op 9 items) | 9, 10 | [other-sweeps.md](other-sweeps.md) |
| Exploração de feras ([exploration](../exploration/README.md)) | "Vezes de Bots" | 8653 `C_MONSTER_EXPLORE_CLIENT_OP` opType 6 | activity reply | `MonsterSweepFrame` | [other-sweeps.md](other-sweeps.md) |
| Caminho dos Deuses (increasingly road, [roads](../roads/README.md)) | "Quer consumir {0} de Movimento e usar 1 Bot?" | 5195 `C_DEMON_ROAD_OP` op 6 | activity reply | none | [other-sweeps.md](other-sweeps.md) |
| Torre de Teseu ([theseus](../theseus/README.md)) | "Bot só é permitido na Fase de maior progresso atual" | 9760 `C_THESEUS_TOWER_CLIENT_OP` op 2 | activity reply | none | [other-sweeps.md](other-sweeps.md) |
| Battle auto attack (battle) | auto fight button | 10020 `B_SET_ATUO_ATTACK` `AttackModeMsg` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:383-392`, `decompiled/core_module/scripts/yishi/datas/BattleModel.as:296-309`) | battle pushes | battle UI | battle engine (`docs/battle/server-engine.md`), not a sweep |

## Modules

| Module | Content |
|---|---|
| [campaign-sweep.md](campaign-sweep.md) | 8528 / 4425 generic sweep (`CampaignSweepReq`/`Rsp`): sweep types 1..6 and 8, op types 1 start, 2 accelerate, 3 poll, 4 stop; status codes; the 12 prepare/in progress frames; gain list frame |
| [abyss-sweep.md](abyss-sweep.md) | Abyss and Hell Abyss bot on 9644 (ops 3..7), 423 and 428 |
| [other-sweeps.md](other-sweeps.md) | Remote pet expedition, lord trial, monster explore, increasingly road, Theseus tower bots |

## Dependencies

Every owner activity above. Gold and diamonds: [currency](../currency/README.md). Elf contract buff 4 ("Contrato dos Elfos", `KingContractManager.checkHasBuffById(4)`): [vip](../vip/README.md). Rewards to the bag: [inventory](../inventory/README.md).

## Suggested implementation order

1. Shared table `mopup.sweep_job` and a generic sweep scheduler (time slices, offline progress, accelerate, stop).
2. [campaign-sweep.md](campaign-sweep.md) sweepType 1 (campaign) end to end, then 2, 3, 4, 5, 6, 8 as their activities are implemented.
3. [abyss-sweep.md](abyss-sweep.md) with the abyss feature.
4. [other-sweeps.md](other-sweeps.md) with each owner feature.
