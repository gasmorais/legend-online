# Sky realm: NPC catalog

Area: sky-realm, module `npc-catalog`. Lists every node of `raw/xml/tempinfos/MapNodeInfos.xml` (58 rows, all on map 10000) with its dialog options, the action each option runs and the roadmap folder that owns what it opens. Mechanics (8692/4601, option parsing, option type enum, collections) are in [npc-interaction.md](npc-interaction.md).

Conventions: see [scene.md](scene.md). "Level" is the third field of the option in `Param3` (checked by `DialogOptionItem.__optionBtnClickHandler`, `M3/map/space/view/frame/DialogOptionItem.as:344-348`, message "Função habilitada no Nv. {0}"); extra code checks are listed in the action column and in [npc-interaction.md](npc-interaction.md) NI4. Every dialog also ends with "Sair" (type 99).

## 1. Overview

| Kind | Count | Ids |
|---|---:|---|
| Dialog NPCs (MasterType 61) | 36 | 1 to 54 except 5 and 14 (ids 7, 9, 11, 12, 13, 15, 19, 24, 26, 27, 29, 30, 33, 34, 38, 47 do not exist) |
| Portal (MasterType 171) | 1 | 5 |
| Spawn (MasterType 40) | 1 | 14 |
| Gift piles "Pilha de Presentes" (MasterType 300, SonType 10031) | 20 | 30001 to 30020 |

Summary of the 38 non pile nodes ("Options" counts `Param3` entries before client filtering):

| Id | Name (`NodeName`) | Kind | Cell | Dialogue | Options |
|---:|---|---|---|---|---:|
| 1 | Recompensa,Recompensas | dialog NPC | (200,46) | no | 1 |
| 2 | Tina, Portal dos Heróis | dialog NPC | (301,148) | yes | 1 |
| 3 | Anbuli, Arena Einherjar | dialog NPC | (392,96) | yes | 1 |
| 4 | Alice, Troca de Einherjar | dialog NPC | (428,118) | yes | 1 |
| 5 | Ilha dos Einherjars, Transmissor | portal | (429,96) | no | 0 |
| 6 | Glorya, Caminho da Glória | dialog NPC | (238,178) | yes | 2 |
| 8 | Lara | dialog NPC | (171,39) | yes | 0 |
| 10 | Rona, Loja Misteriosa | dialog NPC | (152,63) | yes | 1 |
| 14 | (no name) | spawn | (175,98) | yes | 0 |
| 16 | Lilith | dialog NPC | (311,170) | yes | 0 |
| 17 | Elena, Missão de Ciclo | dialog NPC | (107,86) | yes | 1 |
| 18 | Sarça, Planta Especial | dialog NPC | (110,229) | no | 1 |
| 20 | Tropa de Walf, Caminho do Céu | dialog NPC | (422,80) | yes | 1 |
| 21 | Carro de Casamento,Carro de Casamento | dialog NPC | (34,81) | yes | 1 |
| 22 | Andrew, Sacerdote | dialog NPC | (49,25) | yes | 5 |
| 23 | Alexey, Labirinto negro | dialog NPC | (350,195) | yes | 1 |
| 25 | Brad, Avançar profissão | dialog NPC | (72,112) | yes | 6 |
| 28 | Mensageiro Tim, Guardião Celeste | dialog NPC | (169,178) | yes | 4 |
| 31 | Athena, Expedição de Einherjar | dialog NPC | (405,86) | yes | 1 |
| 32 | Papai Noel, Evento de Inverno | dialog NPC | (208,115) | yes | 3 |
| 35 | Entrada da Terralém, Entrada da Terralém | dialog NPC | (198,101) | no | 0 |
| 36 | Entrada da Terralém, Entrada da Terralém | dialog NPC | (198,100) | no | 0 |
| 37 | Ifan | dialog NPC | (144,103) | yes | 0 |
| 39 | Bruno,Julgamento Principal | dialog NPC | (63,217) | yes | 1 |
| 40 | Salizette,Santuário de Titã | dialog NPC | (99,200) | yes | 1 |
| 41 | Walpoth,Portal do Tempo | dialog NPC | (147,249) | yes | 1 |
| 42 | Podor,Abismo Sem Fim | dialog NPC | (147,210) | yes | 1 |
| 43 | Warder,Cavernas do Tempo | dialog NPC | (202,253) | yes | 1 |
| 44 | Angelina, Salão do Jogo | dialog NPC | (189,130) | yes | 2 |
| 45 | Walponia, Templo Eclíptico | dialog NPC | (90,253) | yes | 1 |
| 46 | Walpodila, Continente dos Demônios | dialog NPC | (52,187) | yes | 1 |
| 48 | Tau Estranho | dialog NPC | (237,229) | yes | 1 |
| 49 | Eliza, chefe da Zona Proibida | dialog NPC | (250,254) | yes | 11 |
| 50 | Tifa, o caminho da salvação | dialog NPC | (342,237) | yes | 1 |
| 51 | Clarisse, Caminho da Vingança | dialog NPC | (389,214) | yes | 1 |
| 52 | Bellah,o caminho da salvação | dialog NPC | (301,218) | yes | 1 |
| 53 | Lucien | dialog NPC | (224,128) | yes | 0 |
| 54 | Kyle, Domínio da Arena | dialog NPC | (313,267) | yes | 1 |

Option to feature map (who implements what the option opens):

| Feature | Options (node: type) |
|---|---|
| [quests](../quests/README.md) | 1:1, 17:11, 18:12 (gather), 25:7 ×2, 48:7, 49:7 ×4, injected ring task talk (11) |
| [campaign](../campaign/README.md) | 2:2 |
| [einherjar](../einherjar/README.md) | 3:9, 31:101, portal 5 |
| [shops](../shops/README.md) | 4:8, 10:100, 49:157 |
| [arena](../arena/README.md) | 6:3, 54:162 |
| [roads](../roads/README.md) | 6:108, 49:161, 50:147, 51:145, 52:149 |
| [trials](../trials/README.md) | 20:14, 39:117, 43:131, 46:134, 49:160 |
| [marriage](../marriage/README.md) | 21:23, 22:90/17/19/20/25 (+91/92/93/97) |
| [mazes](../mazes/README.md) | 23:153 |
| [hero](../hero/README.md) | 25:15, 25:104, 25:154 |
| [avenger](../avenger/README.md) | 25:146 |
| [guardians](../guardians/README.md) | 28:103/105/27/113 |
| [seasonal-events](../seasonal-events/README.md) | 32:106/107/107, gift piles 30001..30020 |
| [outyard](../outyard/README.md) | 35, 36 (gates), 40:118, 41:119 |
| [abyss](../abyss/README.md) | 42:130 |
| [casino](../casino/README.md) | 44:135 |
| [time-story](../time-story/README.md) | 44:111 |
| [ecliptic-palace](../ecliptic-palace/README.md) | 45:133 |
| [royalty-boss](../royalty-boss/README.md) | 49:156 |
| [forbidden-boss](../forbidden-boss/README.md) | 49:158 |
| [theseus](../theseus/README.md) | 49:165 |
| [exploration](../exploration/README.md) | 49:167 (and quest 1936 of node 48) |
| [alchemy](../alchemy/README.md) | node 8 (dialog only) |

## 2. Screens

`SpaceDialogFrame` and the option rows, see [npc-interaction.md](npc-interaction.md) §2. Each option opens a screen of the owning feature.

## 3. Routes (client to server)

Hub routes: 8692 (all nodes), 8733 (node 18), 8994 (gift piles), 9586 (node 32), see [npc-interaction.md](npc-interaction.md) §3. Options that send their own packet directly from the dialog: type 15 → 8643, 23 → 8759 op 7, 106 → 9587, 107 → 9586, 146 → 8658, 154 → 8663, 14 → 8636 op 1, 11 → 8732/8729/8730 (ring task), 21 → 8774 op 2001, 96 → 8774 op 2005. All other options only open frames; the frame owner sends the packets.

## 4. Server messages (server to client)

4601, 143 `COLLECTION`, 4811, 125 (portal), see [npc-interaction.md](npc-interaction.md) §4.

## 5. Rules: catalog per node

#### Node 1: Recompensa,Recompensas

MasterType 61, SonType 2997, cell (200,46), HandlerRange 8, Resource 2, Param1 1, dialogue no, Sort 1.

No dialog: 4601 opens the `offerreward` frame directly after the level 17 check (`SpaceSceneController.as:688-703`).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 1 | Recompensa | 17 |  | frame `offerreward` | [quests](../quests/README.md) |

#### Node 2: Tina, Portal dos Heróis

MasterType 61, SonType 3000, cell (301,148), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 2.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 2 | Portal dos Heróis | 20 |  | frame `pveroomlist` | [campaign](../campaign/README.md) |

#### Node 3: Anbuli, Arena Einherjar

MasterType 61, SonType 3001, cell (392,96), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 5.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 9 | Arena dos Einherjar | 50 |  | frame `petchallenge` openType 2 | [einherjar](../einherjar/README.md) |

#### Node 4: Alice, Troca de Einherjar

MasterType 61, SonType 2194, cell (428,118), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 6.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 8 | Troca de Einherjar | 50 |  | frame `shop` openType 888 | [shops](../shops/README.md) |

#### Node 5: Ilha dos Einherjars, Transmissor

MasterType 171, SonType 2336, cell (429,96), HandlerRange 4, Resource 2, Param1 2, dialogue no, Sort 7.

No dialog. `Param3 = "50"` is the required level (not an option list); `MoveToMapId 20001`, `MoveToNodeId 2000101`. Stepping inside `HandlerRange` at walk end sends 8692 (`Param1 = 2`); the server answers 125 and the player enters the Ilha dos Einherjars, owned by [einherjar](../einherjar/README.md). If a 4601 were sent instead, the client would call `openNodeFrame(50)`, which opens nothing.

#### Node 6: Glorya, Caminho da Glória

MasterType 61, SonType 3004, cell (238,178), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 3 | Coliseu |  |  | frame `pvp` (Coliseu) | [arena](../arena/README.md) |
| 1 | 108 | Caminho da Glória | 11 |  | frame `gloryroad` (level ≥ 15) | [roads](../roads/README.md) |

#### Node 8: Lara

MasterType 61, SonType 3006, cell (171,39), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 4.

Dialog only (no option besides "Sair"). `Param4 = "|1926"` and `Param5` hold a story for quest 1926 "Encaminhar até à viagem de alquimia" but `Param3` is empty, so it never shows. Name button only with `VersionSwitch.ALCHEMY_WORKSHOP` (`SpaceUIMediator.as:98`). Related feature: [alchemy](../alchemy/README.md).

#### Node 10: Rona, Loja Misteriosa

MasterType 61, SonType 3008, cell (152,63), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 19.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 100 | Loja Misteriosa | 11 |  | frame `outercityshop` (level ≥ 26) | [shops](../shops/README.md) |

#### Node 14: spawn point

MasterType 40, SonType 2301, cell (175,98), HandlerRange 0, Resource 2, Param1 0, dialogue yes, Sort 0.

Spawn point (MasterType 40). Never interactive; used as fallback position ([movement.md](movement.md) MV3).

#### Node 16: Lilith

MasterType 61, SonType 3005, cell (311,170), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 14.

Dialog only. Name button only with `VersionSwitch.REMAINS_EXPLORE` (`SpaceUIMediator.as:110`).

#### Node 17: Elena, Missão de Ciclo

MasterType 61, SonType 3010, cell (107,86), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 15.

With level ≥ 35 the dialog shows the ring task rewards for 50 and 200 rings (`SpaceDialogFrame.as:144-157`). While a ring task is active the option is replaced by the ring task talk content (`:193-201, 277-280`).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 11 | Missão de Ciclo | 35 |  | ring task (`accessRingTask` on node 17) | [quests](../quests/README.md) |

#### Node 18: Sarça, Planta Especial

MasterType 61, SonType 9005, cell (110,229), HandlerRange 4, Resource 2, Param1 1, dialogue no, Sort 0.

No dialog, building sprite. Interaction is a gather: client checks the ring task condition (type 4, `Para1` = 2100027), sends 8692, server answers 143 `COLLECTION`, client sends 8733 at the end ([npc-interaction.md](npc-interaction.md) N1, N2).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 12 |  |  | 2100027 | ring task collection (via 143 COLLECTION) | [quests](../quests/README.md) |

#### Node 20: Tropa de Walf, Caminho do Céu

MasterType 61, SonType 2175, cell (422,80), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 12.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 14 | Caminho do Céu | 60 |  | `SkyboxRoadManager.getData` (8636 op 1) | [trials](../trials/README.md) |

#### Node 21: Carro de Casamento,Carro de Casamento

MasterType 61, SonType 3020, cell (34,81), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 0.

Marriage car. On 4601 the client opens the dialog only when `MarryManager.model.canRideCar`, else shows "Você não realizou o casamento de mil anos, não pode montar." or "Já montou na carruagem de casamento" by `roomInfo.property7` (`SpaceSceneController.as:643-675`). Portrait hidden (`SpaceDialogFrame.as:124-131`).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 23 | Entrar no Carro de Casamento |  |  | 8759 op 7 ride marriage car | [marriage](../marriage/README.md) |

#### Node 22: Andrew, Sacerdote

MasterType 61, SonType 3019, cell (49,25), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 13.

Options are filtered by the marriage model: 17 needs `canCreateWedding`, 19 `canEnterWedding`, 20 `canDivorce`, 25 `canAnswer`, 90 hidden when `marriangeState == 3`; a pending marriage talk task adds type 97 (`SpaceDialogFrame.as:223-227, 288-294, 396-438`).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 90 | Pedido de Casamento |  |  | propose frame | [marriage](../marriage/README.md) |
| 1 | 17 | Cerimônia de Casamento |  |  | wedding ceremony quality frame | [marriage](../marriage/README.md) |
| 2 | 19 | Entrar no Salão de Casamento |  |  | wedding room list | [marriage](../marriage/README.md) |
| 3 | 20 | Inscrever-se para divórcio |  |  | divorce sub options 92/93/91 | [marriage](../marriage/README.md) |
| 4 | 25 | Apaixonados (Diário) |  |  | "Apaixonados" quiz | [marriage](../marriage/README.md) |

#### Node 23: Alexey, Labirinto negro

MasterType 61, SonType 2265, cell (350,195), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 8.

Name button only with `VersionSwitch.SAND_BOX` (`SpaceUIMediator.as:108`).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 153 | Loja do Labirinto Negro |  |  | frame `shop` 1023 (Labirinto Negro shop) | [mazes](../mazes/README.md) |

#### Node 25: Brad, Avançar profissão

MasterType 61, SonType 2263, cell (72,112), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 16.

`Param5` steps: option 0 (quest 757 "Avanço da Profissão Final") one step; option 3 (quest 1925 "Convocar Arma Divina") one step; the second `$` block is unused. Option 1 shows only with `matchTransferCondition`, option 2 only with `matchChangeJobCondition` (its `Param4` 1912 is quest "Audiência real III", unused by type 104), option 4 only with `isShowAvengerItem` (quest 1944 "Prova de Deificação III"), option 5 only with `isShowFourTransferItem` (quest 1965 "Prova de Consagração VI").

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 7 | Entender o avanço de profissão |  | 757 | story task steps, accepts the task | [quests](../quests/README.md) |
| 1 | 15 | Avanço de profissão | 80 |  | 8643 `C_DRAGON_TRANSFER` (class advancement) | [hero](../hero/README.md) |
| 2 | 104 | Audiência real III |  | 1912 | frame `changejob` | [hero](../hero/README.md) |
| 3 | 7 | Invocação de Arma divina |  | 1925 | story task steps, accepts the task | [quests](../quests/README.md) |
| 4 | 146 | Prova de Vingador |  | 1944 | 8658 `C_THIRD_TRANSFER` (avenger) | [avenger](../avenger/README.md) |
| 5 | 154 | Prova de Consagração |  | 1965 | 8663 `C_FOURTH_TRANSFER` | [hero](../hero/README.md) |

#### Node 28: Mensageiro Tim, Guardião Celeste

MasterType 61, SonType 3021, cell (169,178), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 19.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 103 | Arena do Guardião |  |  | `gotoChildArenaFrame` (level ≥ 70) | [guardians](../guardians/README.md) |
| 1 | 105 | Patrulha do Guardião Procurado | 70 |  | frame `childpatrol` (level ≥ 70, has guardian) | [guardians](../guardians/README.md) |
| 2 | 27 | Convocar Guarda Escolhido | 70 |  | `ChildManager.checkForExchangeChild` | [guardians](../guardians/README.md) |
| 3 | 113 | Selo do Guardião |  |  | frame `childesal` (class advancement) | [guardians](../guardians/README.md) |

#### Node 31: Athena, Expedição de Einherjar

MasterType 61, SonType 2259, cell (405,86), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 101 | Expedição de Einherjar | 50 |  | frame `remotepet` (level ≥ 50, 01:00 to 23:00) | [einherjar](../einherjar/README.md) |

#### Node 32: Papai Noel, Evento de Inverno

MasterType 61, SonType 3026, cell (208,115), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

Visible and usable only inside the new year window (`BaseManager.checkIsNeedShow`, `SpaceMapFrame.checkIsNeedShow`). `ItemExchange = "2126900,5#2060072,2|2100041,1#2060072,1"`: option index 1 gives 5 × 2126900 for 2 × 2060072, option index 2 gives 1 × 2100041 for 1 × 2060072 (`SpaceDialogFrame.as:341-358`; 9586 sends `para_int2` = option index).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 106 | Entrada do Evento do Inverno | 40 |  | 9587 enter holiday vehicle campaign (new year window) | [seasonal-events](../seasonal-events/README.md) |
| 1 | 107 | Troca do Fruto de Natal | 40 |  | 9586 item exchange (new year window) | [seasonal-events](../seasonal-events/README.md) |
| 2 | 107 | Troca do Coração de Neve | 40 |  | 9586 item exchange (new year window) | [seasonal-events](../seasonal-events/README.md) |

#### Node 35: Entrada da Terralém, Entrada da Terralém

MasterType 61, SonType 3030, cell (198,101), HandlerRange 4, Resource 2, Param1 1, dialogue no, Sort 3.

Terralém gate (state A). No dialog: 4601 calls `TopToolsBar.enterOutyardScene` (`SpaceSceneController.as:680-683`). Visible when neither Terralém head state is 3. Feature: [outyard](../outyard/README.md).

#### Node 36: Entrada da Terralém, Entrada da Terralém

MasterType 61, SonType 3031, cell (198,100), HandlerRange 4, Resource 2, Param1 1, dialogue no, Sort 3.

Terralém gate (state B). Same as node 35; visible when one Terralém head state is 3. Feature: [outyard](../outyard/README.md).

#### Node 37: Ifan

MasterType 61, SonType 405, cell (144,103), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

Dialog only; no name button (`SpaceUIMediator.as:112`).

#### Node 39: Bruno,Julgamento Principal

MasterType 61, SonType 607, cell (63,217), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 117 | Julgamento Principal |  |  | frame `lordtrial` | [trials](../trials/README.md) |

#### Node 40: Salizette,Santuário de Titã

MasterType 61, SonType 407, cell (99,200), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 118 | Santuário de Titã |  |  | frame `outyard` 9 (Santuário de Titã) | [outyard](../outyard/README.md) |

#### Node 41: Walpoth,Portal do Tempo

MasterType 61, SonType 601, cell (147,249), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 119 | Portal do Tempo |  |  | frame `outyard` 10 (Portal do Tempo) | [outyard](../outyard/README.md) |

#### Node 42: Podor,Abismo Sem Fim

MasterType 61, SonType 205, cell (147,210), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 130 | Abismo Sem Fim |  |  | frame `abysm` 7 | [abyss](../abyss/README.md) |

#### Node 43: Warder,Cavernas do Tempo

MasterType 61, SonType 207, cell (202,253), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 3.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 131 | Cavernas do Tempo |  |  | frame `timevortex` | [trials](../trials/README.md) |

#### Node 44: Angelina, Salão do Jogo

MasterType 61, SonType 3018, cell (189,130), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 21.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 135 | Salão do Jogo |  |  | frame `gamehall` | [casino](../casino/README.md) |
| 1 | 111 | Caixa do jogo | 28 |  | frame `gamebox` (level ≥ 28) | [time-story](../time-story/README.md) |

#### Node 45: Walponia, Templo Eclíptico

MasterType 61, SonType 3027, cell (90,253), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 22.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 133 | Templo Eclíptico |  |  | frame `eclipticpalace` | [ecliptic-palace](../ecliptic-palace/README.md) |

#### Node 46: Walpodila, Continente dos Demônios

MasterType 61, SonType 3028, cell (52,187), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 9.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 134 | Continente dos Demônios |  |  | frame `demonland` 1 | [trials](../trials/README.md) |

#### Node 48: Tau Estranho

MasterType 61, SonType 2137, cell (237,229), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 1.

`Param4 = "|1936"` puts the quest id on index 1 while the only option is index 0, so the type 7 option resolves task 0, is hidden, and the dialog shows only "Sair". `Param5` holds the 4-step story of quest 1936 "Tau Estranho", which unlocks [exploration](../exploration/README.md) (monster explore). Name button only with `VersionSwitch.MONSTER_EXPLORE` (`SpaceUIMediator.as:102`).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 7 | Tau Estranho |  |  | story task steps, accepts the task | [quests](../quests/README.md) |

#### Node 49: Eliza, chefe da Zona Proibida

MasterType 61, SonType 3029, cell (250,254), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 1.

Option 3 (quest 1100 "Abertura da Realeza") gets the fourth `$` block of `Param5` as its single step. Options 8 to 10 (quests 1389 "Abertura do Espírito da Guerra", 1390 "Desafio até o Topo", 1391 "O Eco Final") have no steps: clicking jumps to the task target without accepting it (`SpaceDialogFrame.as:530-559`). Option 4 needs quest `WARSOUL_TOWER` finished, option 5 quest `FINAL_ROAD`.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 156 | Caminho da Realeza |  |  | frame `royaltyboss` | [royalty-boss](../royalty-boss/README.md) |
| 1 | 157 | Loja Poseidon |  |  | frame `poseidonshop` | [shops](../shops/README.md) |
| 2 | 158 | BOSS da Zona Proibida |  |  | frame `forbiddenboss` | [forbidden-boss](../forbidden-boss/README.md) |
| 3 | 7 | Libera a Realeza |  | 1100 | story task steps, accepts the task | [quests](../quests/README.md) |
| 4 | 160 | Torre da Guerra |  |  | frame `warsoultower` (task WARSOUL_TOWER done) | [trials](../trials/README.md) |
| 5 | 161 | Caminho Final |  |  | frame `finalroad` (task FINAL_ROAD done) | [roads](../roads/README.md) |
| 6 | 165 | Torre de Teseus |  |  | frame `thesstower` | [theseus](../theseus/README.md) |
| 7 | 167 | Masmorra de Teseus |  |  | frame `dungenexplo` 1 | [exploration](../exploration/README.md) |
| 8 | 7 | Desbloquear Guerra |  | 1389 | story task steps, accepts the task | [quests](../quests/README.md) |
| 9 | 7 | Desbloquear Torre da Guerra |  | 1390 | story task steps, accepts the task | [quests](../quests/README.md) |
| 10 | 7 | Desbloquear Caminho Final |  | 1391 | story task steps, accepts the task | [quests](../quests/README.md) |

#### Node 50: Tifa, o caminho da salvação

MasterType 61, SonType 3030, cell (342,237), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 1.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 147 | o caminho da salvação |  |  | frame `redemptionroad` | [roads](../roads/README.md) |

#### Node 51: Clarisse, Caminho da Vingança

MasterType 61, SonType 3031, cell (389,214), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 1.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 145 | Caminho da Vingança |  |  | frame `revengeroad` | [roads](../roads/README.md) |

#### Node 52: Bellah,o caminho da salvação 

MasterType 61, SonType 2254, cell (301,218), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 1.

Name button only with `VersionSwitch.INCREASINGLY_ROAD` (`SpaceUIMediator.as:104`).

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 149 | o caminho da salvação |  |  | `IncreasinglyRoadManager.getData` | [roads](../roads/README.md) |

#### Node 53: Lucien

MasterType 61, SonType 3032, cell (224,128), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 1.

Dialog only. Name button only with `VersionSwitch.SHADOW_LAND` (`SpaceUIMediator.as:106`).

#### Node 54: Kyle, Domínio da Arena

MasterType 61, SonType 110, cell (313,267), HandlerRange 4, Resource 1, Param1 1, dialogue yes, Sort 1.

| # | Type | Title (verbatim) | Level | Param4 | Action | Feature |
|---:|---:|---|---:|---|---|---|
| 0 | 162 | Domínio da Arena |  |  | frame `godpvpenter` | [arena](../arena/README.md) |

#### Gift piles 30001 to 30020: "Pilha de Presentes"

MasterType 300, SonType 10031 (replaced by `son_type` of 4811), HandlerRange 4, Resource 2, no dialogue, no options. Drawn only while listed as active by 4811. Interaction: 8692 → 4601 → 8994 op 1 (level ≥ 35) → 143 `COLLECTION` → 8994 op 2 ([npc-interaction.md](npc-interaction.md) N3 to N5). Rewards owned by [seasonal-events](../seasonal-events/README.md).

| Id | Cell |
|---:|---|
| 30001 | (58,28) |
| 30002 | (41,80) |
| 30003 | (58,87) |
| 30004 | (76,107) |
| 30005 | (102,100) |
| 30006 | (149,39) |
| 30007 | (158,49) |
| 30008 | (198,52) |
| 30009 | (175,74) |
| 30010 | (138,99) |
| 30011 | (200,120) |
| 30012 | (208,143) |
| 30013 | (243,161) |
| 30014 | (280,147) |
| 30015 | (302,175) |
| 30016 | (351,214) |
| 30017 | (322,233) |
| 30018 | (285,255) |
| 30019 | (213,269) |
| 30020 | (300,250) |

#### Injected options

| Condition | Option | Source |
|---|---|---|
| Ring task of type 16 whose talk target is this node | `"11,Missão de Ciclo,35"` → after acceptance text "Já recebi a mensagem de Asuna. Muito Obrigado!" and type 98 "Missão completada" | `SpaceDialogFrame.as:215-222, 813-853` |
| Marriage talk task targeting this node, not completed | `"97, missão de casamento,36"` (type 97, title "missão de casamento", level 36) → text "Já recebemos a carta de Andrew, obrigado(a)!" and type 96 "Missão completada" | `SpaceDialogFrame.as:223-227, 791-811` |
| Marriage task accepted at node 22 | type 21 then 95 "Começar" or 94 "Abrir mochila" by condition type | `SpaceDialogFrame.as:748-789` |

## 6. Templates

| File | Fields used |
|---|---|
| `raw/xml/tempinfos/MapNodeInfos.xml` | `Id`, `NodeName`, `MasterType`, `SonType`, `PosX`, `PosY`, `HandlerRange`, `Resource`, `Dialogue`, `Param1`, `Param3`, `Param4`, `Param5`, `ItemExchange`, `MoveToMapId`, `MoveToNodeId`, `Sort` |
| `raw/xml/tempinfos/QuestTemps.xml` | quests 757, 1100, 1389, 1390, 1391, 1912, 1925, 1926, 1936, 1944, 1965 |

## 7. Persistent state

None beyond [npc-interaction.md](npc-interaction.md) §7. NPC availability depends on state owned by other features (quests, marriage, Terralém, new year window).

## 8. Backend implementation notes

- Load `MapNodeInfos` once; expose `sky_realm::npc_catalog::node(id)` for distance checks and portal data.
- The server does not need option titles or dialogues; it must enforce the level of every option whose packet reaches a hub handler (gift piles 35, portal 50, node 1 level 17 when its frame requests data, option levels inside the owning features).
- Each feature that owns an option implements its own checks again on its routes (the client checks are cosmetic).

## 9. Open questions and assumptions

- Nodes 8 and 48 never show their story options because of misaligned `Param4` (reproduce as is).
- Quests 1389 to 1391 on node 49 are not accepted by the dialog (no steps); acceptance must come from the quest system.
- Option type 101 checks level 50 while its message says 60 ("Apenas os jogadores com nível 60 ou superior podem participar").

## 10. Implementation checklist

- [ ] Every dialog NPC answers 8692 with 4601 (36 nodes)
- [ ] Node 1 direct frame, nodes 35/36 Terralém gates
- [ ] Node 5 portal → 125 (einherjar)
- [ ] Node 18 gather → 143 → 8733 (quests)
- [ ] Gift piles 30001..30020 (seasonal events)
- [ ] Node 32 only inside the new year window
- [ ] Each owning feature implements the frame opened by its options (feature map above)
- [ ] Test: walk to every NPC from the map frame and open its dialog
