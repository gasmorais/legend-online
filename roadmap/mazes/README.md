# Mazes ("Labirintos")

Feature slug `mazes`, domain `pve`. Registry: client packages `maze` (`decompiled/m9/scripts/maze`), `darkmaze`, `gemmaze`, `llk` (`decompiled/m11/scripts/...`) and proto package `linkgame` (`roadmap/features.json`). The messages actually used also come from packages `campaign` (tower messages, owned by [../campaign/README.md](../campaign/README.md)), `avenger` (`DarkMazeMsg`, `DarkMazeChildMsg`, owned by [../avenger/README.md](../avenger/README.md) in the registry), `minigame` (gem maze, owned by [../casino/README.md](../casino/README.md)), `player` and `simple`.

Four unrelated modes share the name "labirinto":

| Module | pt-BR name | What it does for the player | Transport |
|---|---|---|---|
| [maze.md](maze.md) | "Labirinto" (tabs "Labirinto Subterrâneo", "Labirinto do Abismo", "Labirinto Pergatório"), shop "Loja do Labirinto", ranking "Ranking do Labirinto" | Daily floor climbing in campaign maps: 100 floors (8001..8100), 30 floors (8101..8130) and 30 floors (8401..8430). One run per day, double rewards with maze keys, revive on death, record, ranking, bot sweep after floor 10 | 8297 → 4205, 8296, 8299, 8300, 4207, 4419, 4373, 9742; sweep 8528 (mopup); HTTP `tower*.xml` |
| [dark-maze.md](dark-maze.md) | "Labirinto Negro", "Loja do Labirinto Negro" | Time-limited event: 20 layers of a 22-node graph explored with guardians and hired mercenaries; battles, elite and boss nodes, healing fountain, demon pact, mercenary hunter, discount shop; rewards "Alma do labirinto" | 8662 → 4278, 4590 (top button), battle 3898 |
| [gem-maze.md](gem-maze.md) | "Saqueador Soldado" | Match-3 minigame of the game box: swap adjacent gems, score, level, score boxes, friend help invitations, private bag | 9508..9517 → 4922..4930 |
| [link-game.md](link-game.md) | "Labirinto do Tesouro" (link game, 连连看) | Pair matching board 8x14 with stamina, bombs, reshuffles, score boxes and ranking | 8859 → 4736, 4737, 4738 (dormant in this client: no entry point and no listener) |

Out of scope although the code is shared: the monopoly variants of the gem maze and link game (`MonopolyGemMazeManager`, `MonopolyLlkManager`, opcodes 8877..8961, 4759..4864, [../casino/README.md](../casino/README.md)) and the air garden link game (`AirGardenGameLlkManager`, 4736 listener, [../seasonal-events/README.md](../seasonal-events/README.md)); the "Torre do Julgamento" campaigns 8201..8208 (`Types 0, SonTypes 301`) handled by the campaign feature; the maze sweep itself ([../mopup/README.md](../mopup/README.md)).

Conventions used in every module file:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `docs/` or `build/`.
- `CM` = `core_module/scripts`, `M3` = `m3/scripts`, `M4` = `m4/scripts`, `M5` = `m5/scripts`, `M9` = `m9/scripts`, `M11` = `m11/scripts`, `M15` = `m15/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags were read from the AS3 `writeToBuffer` of each class.
- *(assumption)* marks anything the client does not prove.

## Entry points

| Entry | Where | Unlock condition | Opens |
|---|---|---|---|
| Castle building "Labirinto" (SonType 1507) | `M4/castle/view/CastleBuildingView.as:332` (`docs/ui/navigation.md` castle buildings) | Hero level >= 12 | `maze.MazeFrame` (controller `maze`, `CM/mvc/controler/MazeControler.as`) |
| Daily guide or quest skip | `SwitchPageHelp.gotoMazeFrame` (`CM/yishi/SwitchPageHelp.as:1524-1545`) | not in bot mode, level >= 12, `checkScene()` | same |
| Return from a maze campaign | `CastleSceneView` (`M4/castle/CastleSceneView.as:137`), `SwitchPageHelp.as:1127` | | `maze` openType 2 |
| Top tool bar button `darkmaze` | `CM/ui/toptoolbar/TopToolsBar.as:1490-1495` | Visible when `DarkMazeModel.darkMazeIsOpen` (from 4590) and the 2023 year event is not active (`CM/ui/toptoolbar/TopBtnCheckShowHelper.as:407-408`); click: `checkDarkMaze` time window, `VersionSwitch.DARK_MAZE`, knight job change (`CM/yishi/SwitchPageHelp.as:2774-2787`) | Scene `DARK_MAZE_SCENE` (`darkmaze.DarkMazeMainFrame`) |
| 2023 year event panel | `M3/year2023/ui/item/YearActive4UI.as:128` | same | same |
| NPC option 153 "Loja do Labirinto Negro" | NPC 23 "Alexey, Labirinto negro", space map 10000 | `SwitchPageHelp.openDarkMazeShopFrame` (`CM/yishi/SwitchPageHelp.as:3019-3039`): switch, job change, at most 7 days after the event end | shop 1023 ([../shops/README.md](../shops/README.md)) |
| Game box game 2 | `GameBoxManager.enterGame2` (`CM/managers/GameBoxManager.as:174-177`) after 257 `U_C_GAMEBOX_GAMESTART` | game box rules ([../time-story/README.md](../time-story/README.md)) | `gemmaze.GemMazeFrame` |
| Link game | none: `LlkManager.opLlkFrame` is never called | | `llk.view.LlkFrame` |

## Dependencies

| Feature | Why |
|---|---|
| [../campaign/README.md](../campaign/README.md) | Maze floors are campaigns (`Types 4`, capacity 1) with the generic campaign map protocol; `campaign` proto package |
| [../mopup/README.md](../mopup/README.md) | Maze sweep (`mopup` openType 3, opcode 8528 `C_CAMPAIGN_SWEEP`) |
| [../shops/README.md](../shops/README.md) | "Loja do Labirinto" (shop 4, coin 208009 "Moeda do Labirinto"), "Loja do Labirinto Negro" (shop 1023, currency -17000 "Alma do labirinto") |
| [../guardians/README.md](../guardians/README.md) | Dark maze units are the player's guardians plus hired mercenaries |
| [../battle/README.md](../battle/README.md) | Maze battles (campaign battles, auto fight `MazeModel.isAuto`), dark maze battle 3898 (P-CHILD, P-NOHERO) |
| [../time-story/README.md](../time-story/README.md) | Game box launches the gem maze |
| [../friends/README.md](../friends/README.md) | Gem maze help invitations target friends |
| [../secretary/README.md](../secretary/README.md) | The secretary resets mazes (8299) and asks the tower list (9742) |
| [../returning-players/README.md](../returning-players/README.md) | King contract buffs used by sweeps and revives |
| [../medals/achievements.md](../medals/achievements.md) | Achievement condition 101 "Concluir até o piso N" of mazes 1, 2, 3 |
| [../currency/README.md](../currency/README.md) | Diamonds, "Alma do labirinto" (`darkmazeSoulCoin`) |

## Suggested implementation order

1. [maze.md](maze.md): tower info (8297/4205/4373), enter (8296) into floor campaigns, death and revive (4207/8300), reset (8299), report (4419), ranking file.
2. [dark-maze.md](dark-maze.md): event window config, 4590 top button, 8662 ops 1..7, layer generation from `DarkMazeLayerTemplates`, battles 3898.
3. [gem-maze.md](gem-maze.md): board engine and the 9508..9517 routes.
4. [link-game.md](link-game.md): only if the link game is re-enabled.
