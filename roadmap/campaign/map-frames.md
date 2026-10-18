# Campaign map frames

Module `map-frames`. The HUD frames that the campaign map engine (`map.campaign`, see [map-session.md](map-session.md)) overlays on the instance, plus the activity variants hosted on top of it. Titles and labels are the resolved pt-BR strings (`raw/ui/zh_cn/`).

## Base map HUD

| Class | pt-BR strings | Purpose | Source |
|---|---|---|---|
| `CampaignMapFrame` | "NPC/Func.", "Trans.", "NPC/Miss." | main campaign HUD: minimap legend for NPC functions, teleports and mission NPCs, drawn over the live instance | `decompiled/m3/scripts/map/campaign/view/frame/CampaignMapFrame.as` |
| `CampaignBuffFrame` | "Efeito do BUFF" | side panel listing the buffs currently applied to the campaign player, fed by the buff sync pushed with the instance | `decompiled/m3/scripts/map/campaign/view/frame/CampaignBuffFrame.as` |
| `PVPArmyManageFrame` | "Gerenciamento da Equipe", "Adicionar", "Expulsar", "Não há espaço livre" | team management for PvP campaign maps: add, kick and capacity check | `decompiled/core_module/scripts/map/campaign/view/frame/PVPArmyManageFrame.as` |
| `PvpMapFrame` | "Ranking de Pontos", "Campo de Batalha Encerrado" | PvP campaign map overlay with the live spot ranking and the closed-field state | `decompiled/m9/scripts/map/campaign/pvp/PvpMapFrame.as` |

## Activity variants on the campaign engine

| Class | pt-BR strings | Purpose | Source |
|---|---|---|---|
| `SkyStepMapFrame` | | sky-step (Celestial Treasure) walk map, the "jump the clouds" board | `decompiled/m3/scripts/map/campaign/view/ui/SkyStepMapFrame.as` |
| `AirGardenCampaignSmallMapFrame` | | small map drawn for the air garden campaign ([seasonal-events](../seasonal-events/README.md)) | `decompiled/m3/scripts/map/campaign/view/ui/airgarden/AirGardenCampaignSmallMapFrame.as` |
| `ShaiziView` | "Nº de tesouros" | dice roll view for the Molong random-boss maps (box count per roll) | `decompiled/m3/scripts/map/campaign/view/ui/molong/ShaiziView.as` |
| `RaceAgainstTimeView` | | progress view of the "Corrida contra o Tempo" campaign (reward preview from `raw/xml/tempinfos/RushCampaignDrop.xml`) | `decompiled/m3/scripts/map/campaign/view/ui/RaceAgainstTimeView.as` |

The "Corrida contra o Tempo" reward table `raw/xml/tempinfos/RushCampaignDrop.xml` is loaded into `RaceAgainstTimeDropTempCate` (`decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1322`, getter `raceAgainstTimeDropTempCate`) and read by both `RaceAgainstTimeView` and the shared `RaceAgainstTimeFrame` (`decompiled/core_module/scripts/yishi/view/frame/RaceAgainstTimeFrame.as`, see [shared-ui frames](../shared-ui/frames.md)) through `getRewardList` and `getDropsByTypeIndex`.

## Flame Temple campaign (flametemple)

A cross-server scored campaign. The client opens a small map plus a result and ranking set (`decompiled/m3/scripts/map/campaign/view/ui/flametemple/`).

| Class | pt-BR strings | Purpose |
|---|---|---|
| `FlameTempleFlameInfoTip` | "Tem Chamas" | tooltip for the flame counters on the map |
| `FlameTempleGameOverView` | "Rank do Herói no Campo de Batalha", "Atacar no Campo de Batalha", "Personagem", "Servidor", "Medalha", "Fama", "Selo da Alma", "Cristais da Alma", "Ver todos os prêmios" | end-of-battle result: the hero spot rank and its reward preview |
| `FlameTemplePersonRewardView` | "Prêmios de pontos pessoal" | personal score reward list |
| `FlameTempleScoreRankView` | "Ranking de Pontos", "Servidor", "Ranking", "Nome", "Atacar", "Fama", "Pontuação" | score ranking table by server |

## Related

- [map-session.md](map-session.md): how the instance, nodes and fog are created.
- [node-combat.md](node-combat.md): node arrive 5125 and battle start.
- [dusk-area.md](dusk-area.md): the war field that uses `PvpMapFrame`.
- [dungeon-turn.md](dungeon-turn.md): the dice board game, whose `ShaiziView` shares the dice art with Molong.
