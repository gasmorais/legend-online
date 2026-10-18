# Ecliptic Palace ("Palácio da Eclíptica", "Palácio Zodiacal", 黄道圣宫)

Domain: pve. Client packages `eclipticpalace` (M14 frames `eclipticpalace.*`, core model `mvc.module.eclipticpalace`, manager `managers.EclipticPalaceManager`, controller `mvc.controler.EclipticPalaceControl` key `eclipticpalace`). Protobuf package `eclipticpalace` (4 messages) plus `player.CommonMsg` for requests. Battle type 3879 `ECLIPTIC_PALACE`.

The player climbs 12 zodiac palaces ("templos": "Áries", "Touro", "Gêmeos", "Câncer", "Leão", "Virgem", "Libra", "Escorpião", "Sagitário", "Capricórnio", "Aquário", "Peixes"). In each palace he chooses one of 3 routes ("caminhos"); each route has 4 bosses fought in order. Every challenge spends "espírito primordial" (spirit: max 200, +25 per hour, cost 10 + 5 per palace). Clearing a route moves the player to the next palace and pays "Brasão Mágico" emblems and "Pedra de Gravação de Brasões Mágicos". Some bosses carry a hidden event ("evento escondido") that the player may trigger. If a palace is not finished within 14 hours, and every day at 00:00, the player is sent back to the previous palace. Each route lists 1 or 2 guardian classes ("Se {0} estiver na formação, pode obter {1}") that grant a skill bonus when fielded.

All traffic: send 5190 (0x1446) `C_ECLIPTIC_PALACE_OP` (`CommonMsg`), receive 173 (0x00ad) `U_C_ECLIPTIC_PALACE_INFO` and 174 (0x00ae) `U_C_ECLIPTIC_PALACE_REWARD_RECORD`. No HTTP. PostgreSQL schema: `ecliptic_palace`. Rust handlers: `ecliptic_palace::<module>::handle_<action>`.

Path aliases:

| Alias | Path |
|---|---|
| `EPM` | `decompiled/core_module/scripts/managers/EclipticPalaceManager.as` |
| `EPMOD` | `decompiled/core_module/scripts/mvc/module/eclipticpalace/EclipticPalaceModel.as` |
| `EPC` | `decompiled/core_module/scripts/mvc/module/eclipticpalace/EclipticPalaceConstClass.as` |
| `EPF` | `decompiled/m14/scripts/eclipticpalace/EclipticPalaceFrame.as` |
| `EPCI` | `decompiled/m14/scripts/eclipticpalace/item/EclipticPalaceChallengeItem.as` |
| `EPBI` | `decompiled/m14/scripts/eclipticpalace/item/EclipticPalaceBossItem.as` |
| `EPRF` | `decompiled/m14/scripts/eclipticpalace/EclipticPalaceRewardFrame.as` |
| `SPH` | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| Space scene NPC dialog option type 133 (`decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:794-796`) | `SPH.openEclipticPalaceFrame` (`SPH:2498-2515`): `VersionSwitch.ECLIPTIC_PALACE`, `thane.vocationGrades > 0` (profession advanced, else "armyII.viewII.talent.TalentTabBtnView.alert"), `checkScene()` (not in a campaign or room scene, `SPH:1883-1898`) | `EclipticPalaceFrame` with `frameData = true` -> op 1 |
| Daily guide item 88 (`decompiled/core_module/scripts/managers/DayGuideManager.as:945-947`) | same | same |
| Return from battle 3879 | `isOpenEclipticPalace` (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:441-444`), reopened by `decompiled/m4/scripts/castle/CastleSceneView.as:203-206` or `decompiled/m3/scripts/map/space/SpaceSceneController.as:334-337` | `EclipticPalaceFrame` without frameData (uses the cached 173) |

While the frame is open (`EPMOD.openEclipticPalaceFrame`) PK, team and brave legend invitations are suppressed (`decompiled/core_module/scripts/map/space/SpaceManager.as:163-166`, `decompiled/core_module/scripts/yishi/manager/BaseManager.as:532`, `:599`, `:2291`).

## Modules

| Module | Content |
|---|---|
| [palace.md](palace.md) | Main frame: state 173, op 1 refresh, op 2 challenge (battle 3879), op 3 hidden event, op 4 buy spirit, spirit regen, decline timer |
| [reward-log.md](reward-log.md) | "Itens obtidos esta semana": op 5 -> 174 |

Op map of 5190 (`EPC:6-14`): 1 `OPEN_FRAME`, 2 `CHALLENGE`, 3 `HIDDEN_EVENT`, 4 `SPIRIT_BUY`, 5 `REWARD_GOODS`.

## Dependencies

- Battle engine (battle type 3879): `docs/battle/server-engine.md`, `docs/battle/rules.md` row 3879.
- Guardian formation and child templates (route guard job types, `childTemplateCate.getTemplateByJobAndGrades`): [guardians](../guardians/README.md).
- Rewards are emblem items ("Brasão Mágico", SonType 626) used by [divine-weapon](../divine-weapon/README.md) emblems; bag pushes [inventory](../inventory/README.md); diamonds [currency](../currency/README.md).
- Space scene NPC (option 133): world / [navigation](../navigation/README.md).

## Suggested implementation order

1. Template loaders (`EclipticPalaceTempInfos`, `EclipticPalaceDrop`, ConfigInfos `ecliptic_palace_*`).
2. Table `ecliptic_palace.player_state` and route generation.
3. op 1 -> 173, spirit regen, decline timer.
4. op 2 challenge with battle 3879 and post battle state, rewards.
5. op 3 hidden event, op 4 buy spirit.
6. [reward-log.md](reward-log.md) op 5 -> 174, weekly reset.
