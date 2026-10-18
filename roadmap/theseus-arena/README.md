# Theseus arena ("Arena de Teseu" and "Arena MP Teseu")

Feature slug `theseus-arena`. Client packages `theseuspvp`, `theseuspvpscene`, `theseusdoublepvp`, `theseusDoublepvpscene`, `theseusdoublepvproom` (all `decompiled/m3/scripts/`), models `decompiled/core_module/scripts/mvc/module/theseuspvp` and `.../theseusdoublepvp`. Protobuf messages `TheseusPvp*` and `TheseusMultiPvp*` live in package `com.road.yishi.proto.pvp` (registered under [arena](../arena/README.md) in `features.json`, documented here). One manager serves both modes: `managers.TheseusPvpManager` (`decompiled/core_module/scripts/managers/TheseusPvpManager.as`).

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M3/` = `decompiled/m3/scripts/`, `M11/` = `decompiled/m11/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`, `TPM` = `CM/managers/TheseusPvpManager.as`. "(A)" marks an assumption.

## What it is for the player

Two seasonal, cross server, ranked PvP ladders opened from the hub "Domínio da Arena" (see [../arena/arena-domain.md](../arena/arena-domain.md)):

- **Arena de Teseu** (single, Chinese 竞技神域-忒修斯擂台): the player enters scene `THESE_PVP_SCENE`, presses match, is paired with an opponent whose score is inside the stage `MatchingSection`, fights battle 3907 `THESE_PVP_BATTLE`, and gains or loses points ("Pontos") by score difference. Points place the player on 16 stages ("Graduação": Prata I..III, Ouro, Platina, Diamante, Lenda I..III, Hall). 5 free matches a day, more by diamonds or by the item "Rolo de Desafio da Arena de Teseu".
- **Arena MP Teseu** (multiplayer, 忒修斯多人竞技): players form a room of type 16 (scene `THESE_Double_PVP_SCENE`), get ready, the owner starts matching, rooms are paired and fight battle 3912 `THESE_MultiPVP_BATTLE`; same stage ladder (16 stages, last "Mestre").

Both have daily tasks, stage rewards, end of season rank rewards, a "Glory" reward track with a paid advanced lane ("Prêmio do Valente" / "Prêmio da Glória"), a ranking and battle reports; the single mode also has a hall of fame with likes. Shop: "Loja da Arena" (`shop` openType 1027, currency 59).

Season config (`TPL/ConfigInfos.xml`): `theseus_pvp_open_config` = 1,1 (week 1, day 1 of each month), `theseus_pvp_open_days` = 21, `theseus_pvp_open_times` = 00:00:00,22:00:00,7:23:00:00 (season start time, season end time, entry close "N days later at time"); same keys with `theseus_multi_pvp_` for MP.

## Entry points

| Entry | Condition | Code |
|---|---|---|
| NPC dialog option 162 -> `SwitchPageHelp.openGodPvpFrame` -> controller `godpvpenter` | | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:886-887`; `CM/yishi/SwitchPageHelp.as:3150-3153` |
| Hub item "Arena de Teseu" | not dragon talker; royalty level >= `RoyaltyTemplates` min level with `OpenPvp = 1` (6); season started | `M11/godpvpenter/item/TheseusPvpEnterItem.as:175-195` |
| Hub item "Arena MP Teseu" (buttons join / create) | same checks | `M11/godpvpenter/item/TheseusDoublePvpEnterItem.as:174-238` |
| Return from battles 3907 / 3912 | | `CM/battle/handler/BattleResultHandler.as:306-311` |

## Modules

| Module | File | Content |
|---|---|---|
| Season, user state and entry | [season.md](season.md) | 4320/583 season, 4312/575 user, op 1 open, op 2 leave, 4317/580 absence report |
| Single arena matches | [single-match.md](single-match.md) | `THESE_PVP_SCENE`, ops 3/4/14/15, 4318 match, battle 3907, 4319 result, points formula |
| MP arena rooms and matches | [multi-rooms.md](multi-rooms.md) | room list/create/enter/search/invite (room type 16), ready/start (5036/5037/5039), 581 match, battle 3912, 582 result, ops 14/15 |
| Tasks, glory track and shop | [rewards.md](rewards.md) | ops 13/7 (4313/576), ops 9/10/11 special rewards, currencies 59/60/69 |
| Ranking, hall of fame and reports | [ranking.md](ranking.md) | op 12 (4314/577), op 6/8 (4315), op 5 (4316/579) |

## Dependencies

| Feature | Why |
|---|---|
| [arena](../arena/arena-domain.md) | hub frame "Domínio da Arena" (`godpvpenter`) |
| [campaign](../campaign/README.md) | room protocol 5023/5024/5025/5026/5028/5036/5037/5039, 12/13/15/16/24/25/120/4270/4370 |
| [royalty-boss](../royalty-boss/README.md) | royalty level gate (`RoyaltyBossManager.model.royaltyLevel`) |
| [dragon](../dragon/README.md) | dragon talker state blocks entry |
| [shops](../shops/catalog.md) | shop 1027 |
| [currency](../currency/README.md) | currencies 59 (medal), 60 (single honor), 69 (MP honor) |
| [theseus](../theseus/README.md) | Theseus character systems that the battles use (A) |

## Suggested implementation order

1. Season scheduler and tables; 4320/583 and 4312/575 at login.
2. Single arena: op 1/2, matchmaking op 3/4 with 4318, battle 3907, 4319, points.
3. Tasks and rewards (op 13/7), purchases (op 14/15), ranking (op 12), reports (op 5), hall (op 6/8), glory (op 9/10/11).
4. MP arena: room type 16, ready/start, matchmaking 581, battle 3912, 582.
5. Season close: rank rewards, hall of fame snapshot, absence reports.
