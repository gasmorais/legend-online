# Pet island (Ilha de Einherjar) and island defense boss (Proteção da Ilha de Einherjar)

Path aliases:

| Alias | File |
|---|---|
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| PBMOD | `decompiled/core_module/scripts/map/campaign/data/PetBossModel.as` |
| WBH | `decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as` |
| V | `decompiled/m14/scripts/petboss/` |

## 1. Overview

"Ilha de Einherjar" is a set of campaign maps (ids 20001..25000, 4 floors, `WBH.checkPetLand`, `WBH:225-228`) where players fight wild pets. Island monsters drop pet essences that are exchanged for "Esfera do Selo de Einherjar" (seal spheres) which hatch pets of the same element ("Troca Einherjar", `PetExchangeShopFrame.HelpFrame.Txt`): this is the main source of pets. The map scene itself (walking, monster nodes, battles) is the campaign engine ([../campaign/README.md](../campaign/README.md)); this module covers the pet specific entry and the timed event.

"Proteção da Ilha de Einherjar" is an event that opens every 3 hours (`pet_island_defend_hour` = 1,4,7,10,13,16,19,22): violent pets ("Einherjar violento") appear on an island map; killing medium and advanced ones fills a rage bar; at 100 rage the leader boss appears; teams fight it and are ranked by damage. Help (`PetBossInfoView.boss.helpFrame.helpContent`): "Os jogadores ao matarem um certo número de einherjars violento poderão ganhar prêmios (nº de prêmios redefinido às 0:00) ... Matando um certo número de einherjars médios e avançados irá aparecer o líder Einherjar ... recomenda-se a formar equipes para derrotá-los ... Começa diariamente às 1h, cada 3 horas irá aparecer 1x o einherjar violento."

Unlock: lord level >= 50 ("Nível 50 não atingido").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/PetBossFrame.as` | "Proteção da Ilha do Einherjar" (`ui.toptoolbar.TopToolsBar.petBossBtn.tipData`) | Event panel | top bar button "petboss" when level >= 50 (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1185-1191`), controller `decompiled/core_module/scripts/mvc/controler/PetBossController.as` | `PBMOD` |
| `V/PetbossItem.as` | "Chefão Aleatório da Ilha de Einherjar", "Participando, pode obter materiais de treinamento de Einherjar e Cristais de Einherjar.", "Chefão chegando em breve" | Boss card, countdown to next opening (`PBMOD.getNearlyOpenTimeSecond`), click walks to the event map node (`:211-229`) | frame | `heroId`, `mapId`, `leftTime` |
| Campaign HUD (`PetBossInfoView`, task trace `PetBossSortView`) | "Fúria de Einherjar médio: {0}/{1}", "Fúria de Einherjar avançado: {0}/{1}", "Fúria do Einherjar Líder: {0}/{1}", "Ranking de pontos   {0}º lugar  {1} ({2}%)" | Kill counters vs daily caps, rage, team ranking | inside the island map | 4686 fields |
| Space NPC dialog option 6 | | Enter the island | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:380-382` | |
| Bag item "transfer" (`decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as:809-885`) | "Deseja encaminhar até a Ilha de Einherjar {0} Piso?" | Teleport scroll to floor 1..4 (`Property1` 20001..20004) | bag | |
| `decompiled/m15/scripts/view/subshop/PetExchangeShopFrame.as` | "Troca Einherjar" | Exchange essences for seal spheres (shop feature) | shop | |

## 3. Routes (client to server)

### R1. Enter the island
- UI: NPC dialog option 6 with the map parameter.
- Sender: `SSM.enterPetLand(mapId = 20000)` (`SSM:513-519`).
- Route: send 8694 (0x21f6) `C_ENTER_PETISLAND`, `CampaignReqMsg` (package campaign): `paraInt1` = target map id (default 20000; floors 20001..20004).
- Response: campaign scene entry messages (campaign feature), then 4686 if the event is running on that map.

### R2. Teleport scroll
- UI: use the transfer item; allowed in space, castle, farm or an island map; refused while sweeping (`mopup.MopupManager.mopupTipData01`); else "O cenário atual não pode ser transmitido".
- Route: send 5006 `U_C_ITEM_USE` (`SSM.sendUseItem(pos)`); the server teleports to `Property1` map (inventory feature item effect).

### R3. Walk to the event
`SwitchPageHelp.walkToCrossMapTarget(mapId + "," + nodeId)` from `V/PetbossItem.as:220` (navigation, no own route).

Fights on the island are campaign node battles ([../campaign/README.md](../campaign/README.md)); boss fights require a team ("Necessário formar grupo para participar", "A força de um único jogador é fraca, Necessita de formar equipa para combater o Chefão ...").

## 4. Server messages (server to client)

### S1. 4686 (0x124e) `U_C_PETISLAND_BOSS_START`
- `PetIslandDefendStateMsg` (package pet): `left_time` (#1, INT64) ms or s until the end (assumption: seconds, `Int64Utils`); `map_id` (#2, INT32) event map, 0 = closed; `boss_id` (#3, INT32) hero template of the leader (`gameHeroTemplateCate`, `V/PetbossItem.as:170`); `peace_middle` (#4), `peace_high` (#5), `peace_boss` (#6) kill counts today (set together); `rage_point` (#7) current rage.
- Receivers: `BM.__petBossSwitchHandler` (`BM:1052-1077`): updates `PBMOD`, info tip 18, task tip 42, delayed alert "O evento de da Proteção da Ilha de Einherjar já começou" for level >= 50 when the map changes, notifies `CampaignEvent.PET_BOSS_SWITCH` (top bar refresh); also `decompiled/core_module/scripts/proxy/scene/CampaignSocketDataProxy.as:67` inside the campaign scene.
- When: at event start and end (broadcast to online players), on rage or counter changes (to players on the map), on map entry.

### S2. 4203 `WorldBossReportMsg` type 4
End of event report "Encerramento da batalha da proteção da ilha de Einherjar \n Você acumulou {0} pontos participando da equipe, Ranking {1}\n obterá {2}" (`BM:1801-1846`, fields `totalWound`, `order`, `property1`). Owned by [../world-boss/README.md](../world-boss/README.md).

## 5. Rules and formulas

- Island maps: 20001..25000 (`WBH:225-228`); floors 1..4 = 20001..20004 (`PlayerBagCellClickMediator.as:880-900`).
- Event hours `pet_island_defend_hour` = 1,4,7,10,13,16,19,22 (`PBMOD:37-55`); `petboss_time` = "全天".
- Daily reward caps `pet_island_defend_reward_count` = 20 medium, 10 advanced, 1 leader (reset 0:00).
- Rage: boss at `pet_island_defend_boss_rage` = 100; `pet_island_defend_rage_add` = 4 (medium), 10 (advanced).
- Boss damage rewards `petboss_wound` = "0.06,15|0.09,30|0.12,50" (damage share threshold, reward amount; assumption).
- Rewards: "materiais de treinamento de Einherjar e Cristais de Einherjar"; first team gets the top prize, others share gold and crystals by damage points (`yishi.view.tips.PetBossTips.*`).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `pet_island_defend_*`, `petboss_time`, `petboss_wound` |
| Campaign/map templates | island maps 20001..20004, monster nodes (campaign feature) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | transfer scrolls (`Property1` map), essences, seal spheres |

## 7. Persistent state

```sql
CREATE TABLE einherjar.island_event (
  event_id      BIGSERIAL   PRIMARY KEY,
  map_id        INTEGER     NOT NULL,
  boss_id       INTEGER     NOT NULL,
  rage_point    INTEGER     NOT NULL DEFAULT 0,
  boss_spawned  BOOLEAN     NOT NULL DEFAULT false,
  starts_at     TIMESTAMPTZ NOT NULL,
  ends_at       TIMESTAMPTZ NOT NULL
);

CREATE TABLE einherjar.island_daily_kills (
  player_id     BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  day           DATE     NOT NULL,
  middle_kills  SMALLINT NOT NULL DEFAULT 0,
  high_kills    SMALLINT NOT NULL DEFAULT 0,
  boss_kills    SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, day)
);

CREATE TABLE einherjar.island_boss_damage (
  event_id   BIGINT  NOT NULL REFERENCES einherjar.island_event(event_id) ON DELETE CASCADE,
  team_id    BIGINT  NOT NULL,
  player_id  BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  damage     BIGINT  NOT NULL DEFAULT 0,
  PRIMARY KEY (event_id, team_id, player_id)
);
```

## 8. Backend implementation notes

- `einherjar::boss_island::handle_enter` (8694): level >= 50 -> map id within 20000..25000 (20000 = default floor, assumption 20001) -> campaign enter flow -> push 4686 when an event is active.
- Scheduler at each `pet_island_defend_hour`: create `island_event` (random island map and leader template), broadcast 4686 with `map_id`; spawn violent pets on the map; on kills update daily counters and rage (+4/+10) and push 4686 to players on the map; at rage 100 spawn the leader; at the end (duration assumption: until the next slot or boss death) compute team ranking, grant rewards, send 4203 type 4 to participants and broadcast 4686 with `map_id` 0.
- Battles: campaign node battles with pet monsters; boss battle requires a team (team feature).

## 9. Open questions and assumptions

- Event duration and `left_time` unit.
- How essences drop per element and seal sphere exchange prices (shop feature, `PetExchangeShopFrame`).
- Meaning of `petboss_wound` values.

## 10. Implementation checklist

- [ ] Screen: pet boss frame and boss card countdown
- [ ] Route 8694 enter island
- [ ] Item transfer scroll effect (inventory)
- [ ] Server message 4686 broadcasts
- [ ] Event scheduler, rage, boss spawn, rankings, 4203 type 4 report
- [ ] Tables `einherjar.island_event`, `einherjar.island_daily_kills`, `einherjar.island_boss_damage`
- [ ] Tests: daily caps reset, rage thresholds, level gate
