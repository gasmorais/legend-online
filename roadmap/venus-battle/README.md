# Venus battle ("Batalha de Vênus")

Feature slug `venus-battle`. Client packages `matelords` (`decompiled/m9/scripts/matelords`, models `decompiled/core_module/scripts/mvc/module/matelords`) and `multilords` (model only, `decompiled/core_module/scripts/mvc/module/multilords`). Protobuf package `com.road.yishi.proto.matelords`. Client manager `yishi.manager.MatelordsManager`.

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M9/` = `decompiled/m9/scripts/`, `M5/` = `decompiled/m5/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`, `PTT` = `CM/yishi/datas/consant/ProtocolTypeTable.as`. "(A)" marks an assumption.

## What it is for the player

A weekly cross server tournament for married couples (Chinese 永恒之战 / 维纳斯之战). The couple forms a two member "freedom team" with the spouse, the captain pays `Mate_Join` = 2000000 gold to sign up ("Equipe de Casal"). On fight day (`MateLords_Day` = 7, Sunday, `Mate_Time` 20:00 to 21:00) each partner enters the two seat room individually. The server runs turns; at each turn it pairs couple teams and starts battle 315 `CROSS_MATELORDS_BATTLE`. Team score places the couple in one of four groups ("Grupo de Diamantes", "Ouro", "Prata", "Ferro"), which drives the weekly reward of "Cristais de Vênus" (currency 12, "Loja de Vênus"). After each battle the team earns "Pontos de Bênção" (altar score) spent in the altar shop ("Bênção de Pontos") on score multipliers and battle skills. Inspiration (200 diamonds, up to 10 levels, +10% attributes each) boosts the next battle.

Help text (`matelords.MatelordsFrame.helpContent`, excerpts): "A Batalha de Vênus, é um sistema inter-servidor entre equipes de casais."; "A Batalha de Vênus será durante 3 meses, todas as semanas será realizada uma competição em tempo determinado."; "...necessário no mínimo 200 pontos para ser premiado".

## Entry points

| Entry | Condition | Code |
|---|---|---|
| Top bar button `matelords` | `thane.grades >= 36 && VersionSwitch.MATE_LORDS` (true) | `CM/ui/toptoolbar/TopBtnCheckShowHelper.as:249-250`; click `CM/ui/toptoolbar/TopToolsBar.as:1063-1064` -> controller `matelords` |
| Controller `matelords` (navigation id `matelords`) | | `CM/mvc/controler/MatelordsController.as:22-33` |
| Top bar badge | push 4801 `param1` | `CM/yishi/manager/BaseManager.as:339,2842-2848`; `CM/ui/toptoolbar/TopBtnItemView.as:297-300` |

## Modules

| Module | File | Content |
|---|---|---|
| Main panel and signup | [signup.md](signup.md) | main frame, 8979 main info (4799), couple team signup 8975, open state 4801 |
| Fight room, inspiration and matches | [room.md](room.md) | 8976 room create (type 8), `MATELORDS_ROOM`, room info 4798, inspiration 8981, turn loop, battle 315, team order |
| Altar shop ("Bênção de Pontos") | [altar-shop.md](altar-shop.md) | 9611 / 365, altar score, multipliers and skills |
| Groups, ranking and rewards | [ranking.md](ranking.md) | rank frame, groups, decay, weekly reward |
| Titan battle (multilords), legacy | [multilords.md](multilords.md) | opcodes 8841..8856 and battle 308; no UI scripts in this client |

## Dependencies

| Feature | Why |
|---|---|
| [marriage](../marriage/README.md) | must be married; team must be the couple (`MarryManager.model.isMarry`, `selfMarryInfo.userId`) |
| [team](../team/README.md) | freedom team (`FreedomTeamManager`: has team, captain, 2 members) and fight positions (`teammanager.MatelordsSortFrame`, [../team/fight-positions.md](../team/fight-positions.md)) |
| [campaign](../campaign/README.md) | room protocol: 12 (`roomType 8`), 120, 5025 exit, 15 |
| [shops](../shops/catalog.md) | "Loja de Vênus" `shop` openType 20, currency 12 |
| [ares-battle](../ares-battle/README.md), [athena-battle](../athena-battle/README.md) | sibling tournaments |
| Battle engine | battle 315 (`docs/battle/rules.md`), inspiration icon "+10%/level" |

## Suggested implementation order

1. Couple team validation helpers (marriage + freedom team) and tables.
2. 4801 state push, 8979 -> 4799, 8975 signup.
3. 8976 room, 4798 room info, turn scheduler, pairing, battle 315 with fight positions of the team.
4. 8981 inspiration.
5. Altar score and 9611 / 365 shop.
6. Group ranking, decay and weekly reward.
7. Multilords only if the UI module is recovered (see [multilords.md](multilords.md)).
