# Royalty levels and unlocks ("Nível de Realeza")

Feature `royalty-boss`, module `royalty-levels`. Client: `CM/yishi/datas/templates/RoyaltyTempInfo.as`, `CM/yishi/datas/templates/cate/RoyaltyTempCate.as`, `CM/mvc/module/royaltyboss/RoyaltyBossModel.as` and every consumer listed in §5. Conventions: see [README.md](README.md).

This module has no route of its own. It is the shared reference that every feature gated by royalty must use on the server side. The client trusts `RoyaltyBossManager.instance.model.royaltyLevel` (filled by 4292, see [royalty-path.md](royalty-path.md)); the server must enforce the same gates.

---

## 1. Overview

- 40 royalty levels (`RoyaltyTemplates.xml`, `Id` 1001..1040, `RoyaltyLevel` 1..40). Level 0 means "no royalty" (no boss killed).
- A level is reached by killing `BossLevel` bosses of the royalty chain.
- Each level row holds cumulative values: a column is either a count or tier reached so far, or a 0/1 flag. The UI lists, for a selected level, every column whose value grew compared with the previous level (`M11/royaltyboss/RoyaltyBossFrame.as:299-442`).
- Each level grants the attribute skill `SkillId` (attack and HP bonus).

---

## 2. Screens

No screen of its own. Displayed by `royaltyboss.RoyaltyBossFrame` (level roll and unlock lines, [royalty-path.md](royalty-path.md) §2) and used as a lock by the consumer screens of §5.

Unlock line texts (`RoyaltyBossFrame.as:348-442`, strings from `index/language.json`):

| Column grew | Line shown |
|---|---|
| `OpenTheseus` | "Desbloqueio de {OpenTheseus} Armadura de Teseu" (`royaltyBossFrame.openTheseus.text`) |
| `OpenForbidenBoss` | `royaltyBossFrame.openForbidenBoss.text{value}`: 1 "Desbloqueio da Zona Proibida Normal", 2 "... de Aventura", 3 "... Pesadelo", 4 "Desbloqueio da Caverna da Zona Proibida", 5 "Besbloqueio da Zona Proibida do Pesadelo" |
| `OpenShopLevel` | "Desbloqueio da loja Poseidon Piso {OpenShopLevel}" |
| `OpenOutsideTreasureHoke` | "Libera novo slot de Tesouro Externo" |
| `OpenInsideTreasureHoke` | "Libera novo slot de Tesouro Interno" |
| `OpenCoreTreasureHoke` | "Libera limite de nível de Núcleo nv. {OpenCoreTreasureHoke}" |
| `OpenSecret` | "Libera Expedição do Eremitério {SecretMapLevelTemplate(OpenSecret).MapName}" |
| `OpenTower` | "Abrir a Torre de Teseus" |
| `OpenSlate` | "Placas divinas de Teseus liberadas" |
| `OpenDungeon` | "Masmorra de Teseus liberada" |
| `OpenWarSoul` | `royaltyBossFrame.openWarSoul.text{value}`: 3 "Liberação do Espírito da Guerra da Água, Fogo e Vento", 6 "... do Choque, Luz e Escuridão", 9 "... Marinho, Terra e Celeste" |
| `OpenWarSoulTower` | "Abertura da Torre da Guerra" |
| `OpenFinalRoad` | `royaltyBossFrame.openFinalRoad.text{value}`: 1 "(fácil)", 2 "(Normal)", 3 "(Difícil)" |
| `OpenPvp` | no line (not listed by the frame) |
| `SkillId` | one line per `|` part of `SkillTempInfos.Description`, for example "Ataque:150", "Vida:900" |

---

## 3. Routes (client to server)

None. The level changes only through the royalty fight ([royalty-path.md](royalty-path.md) R1).

---

## 4. Server messages (server to client)

| Opcode | Name | Use |
|---|---|---|
| 4292 (0x10c4) | U_C_ROYALTY_DATA | `simple.PropertyMsg {param1 (#1, INT32) = royalty level, param2 (#2, INT32) = passBossLevel}` at login and after each level change; details in [royalty-path.md](royalty-path.md) §4 |

Other features expose the royalty level of other players through their own messages, for example the Theseus inspection `level (#11, INT32)` read by `TheseussoulModel.getRoyaltyLevel` (`CM/mvc/module/theseus/TheseussoulModel.as:182-189`, [../theseus/soul.md](../theseus/soul.md)).

---

## 5. Rules: field reference and consumers

### 5.1 Fields of `RoyaltyTemplates.xml` (`RoyaltyTempInfo`, `CM/yishi/datas/templates/RoyaltyTempInfo.as`)

| Field | Kind | Meaning | First level per value | Client consumer (file:line) | Owner feature |
|---|---|---|---|---|---|
| `Id` | key | 1000 + level | | `RoyaltyTempCate.getTemplates` (`CM/yishi/datas/templates/cate/RoyaltyTempCate.as:54-127`) | |
| `RoyaltyLevel` | 1..40 | The level | | `getTempInfoByLevel` (`:129-140`) | |
| `BossLevel` | count | Total royalty bosses killed needed for this level | see §5.2 | `RoyaltyBossFrame.as:278-283` | royalty-boss |
| `SkillId` | skill id | Attribute skill of the level: `SkillPropertyTempInfos` `AddType=1`, `Attack = MagicAttack = 150 x level`, `Live = 900 x level` (84102001: 150/150/900 .. 84102040: 6000/6000/36000). Only the skill of the current level applies *(assumption: not cumulative, values already scale with the level)* | 8410200L at level L | `RoyaltyBossFrame.as:443-456` (display only) | hero stat calculator |
| `OpenTheseus` | count 1..9 | Number of Theseus armour suits usable. Suit index n (1..9) is usable when `OpenTheseus >= n`. Suit order in the UI `[8,6,7,9,4,2,1,3,5]` | 1@1, 2@4, 3@9, 4@14, 5@19, 6@24, 7@28, 8@32, 9@37 | `M5/theseus/view/ThereussoulEquipView.as:144-169` (level 0 treated as 1), `M5/theseus/view/ThereussoulEquipViewLook.as:98-125` (other player), `M5/theseus/mediator/TheseusBagCellClickMediator.as:23-25`, `CM/mvc/module/theseus/TheseussoulModel.as:339-344` (red dots) | [../theseus/equipment-suits.md](../theseus/equipment-suits.md) |
| `OpenForbidenBoss` | tier 1..5 | Forbidden zone categories open: 1 Normal, 2 Aventura, 3 Pesadelo, 4 Caverna, 5 Pesadelo (category 5). Category c is open when `OpenForbidenBoss >= c` | 1@1, 2@5, 3@10, 4@15, 5@21 | `CM/yishi/SwitchPageHelp.as:3097-3102` (category 1 to open the frame), `M11/forbiddenboss/ForbiddenBossFrame.as:236-257` (lock of tabs 2..5), `RoyaltyBossModel.forbidenBossLevel` (`CM/mvc/module/royaltyboss/RoyaltyBossModel.as:21-29`, unused) | [../forbidden-boss/README.md](../forbidden-boss/README.md) |
| `OpenShopLevel` | floor 1..9 | Poseidon shop floors open (`ShopLevel`); floor f open when `OpenShopLevel >= f`. `maxLv` = 9 = number of floor tabs | 1@1, 2@5, 3@10, 4@15, 5@20, 6@25, 7@29, 8@33, 9@38 | `CM/yishi/SwitchPageHelp.as:3065-3074` (floor 1 to open), `M11/poseidon/view/PoseidonView.as:132-140` (tab locks, "poseidon.shopRightLock"). Items also have their own `OpenCondition` royalty level (`M11/poseidon/item/PoseidonItem.as:106-111`) | [../shops/README.md](../shops/README.md) |
| `OpenOutsideTreasureHoke` | count 0..9 | Outer treasure slots of the Theseus treasure; slot n open when `>= n` | 3@6, 5@8, 7@11, 9@15 | `M5/theseus/view/TreasureOuterItem.as:105-125` (lock tip "TreasureOuterItem.royalty.text") | [../theseus/treasure.md](../theseus/treasure.md) |
| `OpenInsideTreasureHoke` | count 0..3 | Inner treasure slots; slot n (item index - 8) open when `>= n`; also needs the secret map of `TheseusTreasureHoke.Property1` | 1@6, 2@9, 3@13 | `M5/theseus/view/TreasureInnerItem.as:48-70` | theseus treasure |
| `OpenCoreTreasureHoke` | level cap 0..150 | Max level of the treasure core; core can grow while `coreInfo.Level < OpenCoreTreasureHoke`. `minCoreLv` = first royalty level with value > 0 = 6 locks the core item | 20@6, 40@8, 60@10, 80@12, 100@14, 120@16, 140@18, 150@20 | `M5/theseus/view/TreasureCoreFrame.as:145-160`, `M5/theseus/view/TreasureCoreItem.as:38-56` | theseus treasure |
| `OpenWarSoul` | count 0/3/6/9 | War soul equipment SonType usable: cell of `SonType s` usable when `OpenWarSoul >= s` (3 = water, fire, wind; 6 = shock, light, dark; 9 = sea, earth, sky) | 3@10, 6@15, 9@20 | `M5/theseus/war/item/TheseusWarEquipCell.as:64-70`, `M5/theseus/war/item/TheseusWarEquipCellLook.as:19-24`, `M5/theseus/war/mediator/TheseusInsfBagCellClickMediator.as:62-75` | [../theseus/war-soul.md](../theseus/war-soul.md) |
| `OpenWarSoulTower` | flag | War soul tower ("Torre da Guerra") open | 1@10 | `CM/yishi/SwitchPageHelp.as:3120-3147` (`getWarSoulTowerLv(1)`, also quest 1390 and knight job change) | [../trials/README.md](../trials/README.md) |
| `OpenFinalRoad` | tier 0..3 | Final road difficulty chapters open: 1 easy, 2 normal, 3 hard; chapter index i open when royalty level >= first level with value i | 1@10, 2@20, 3@30 | `CM/yishi/SwitchPageHelp.as:3199-3235` (tier 1 to open, also quest `FINAL_ROAD`), `M11/finalroad/FinalRoadItem.as:178-190` | [../roads/README.md](../roads/README.md) |
| `OpenPvp` | flag | Theseus single and double PvP entries open | 1@6 | `M11/godpvpenter/item/TheseusPvpEnterItem.as:88-96, 182-183`, `M11/godpvpenter/item/TheseusDoublePvpEnterItem.as:102-103, 181-182, 225-226` | [../arena/README.md](../arena/README.md), [../theseus-arena/README.md](../theseus-arena/README.md) |
| `OpenTower` | flag | Theseus tower open | 1@6 | `CM/yishi/SwitchPageHelp.as:3165-3183` | [../theseus/tower.md](../theseus/tower.md) |
| `OpenDungeon` | flag | Theseus dungeon (block exploration) open | 1@30 | `CM/yishi/SwitchPageHelp.as:2365-2374` (`getdilaoLv(1)`) | [../theseus/dungeon.md](../theseus/dungeon.md) |
| `OpenSlate` | flag | God plates ("Placas divinas", godhead button) visible | 1@30 | `M5/theseus/view/ThereussoulEquipView.as:185-194` (`OpenSlate == 1`) | [../theseus/godhead.md](../theseus/godhead.md) |
| `OpenSecret` | secret map id | Highest secret adventure map ("Expedição do Eremitério") whose card is unlocked: card `MapId <= OpenSecret` and `<= current progress` | 0 at every level in the local data | `M3/secretadventure/view/SecretAdRightView.as:94-145` | [../exploration/README.md](../exploration/README.md) |

Other gates that only test `royaltyLevel > 0`:

| Gate | File:line | Owner |
|---|---|---|
| Theseus child button of the archaeology toolbar button (`ProficiencyBtn`): `royaltyLevel > 0 && VersionSwitch.THESESOUL && vocationIndex > 0` | `CM/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:70-72` | [../theseus/soul.md](../theseus/soul.md) |
| Theseus hotkey (E) | `CM/yishi/keyboard/KeyBoardRegister.as:1176-1190` | theseus |
| `TheseusOtherFrame` tabs | `M5/theseus/TheseusOtherFrame.as:37, 181` | theseus |
| Smith compose tab "Teseu" | `M14/store/ComposeView1.as:134` | [../smith/README.md](../smith/README.md) |
| Smith resolve tabs "Teseu" and treasure | `M14/store/NewResolveView.as:80-81` | smith |
| Smith treasure and treasure refresh buttons (also `VersionSwitch.TREASURE`) | `M14/store/StoreView1.as:119-120` | smith |
| Currency bar shows `poseidonCoin` | `CM/managers/PlayerCurrencyManager.as:733-736` | [../currency/README.md](../currency/README.md) |
| Task condition 261 "royalty level >= Para2" | `CM/mvc/module/task/TaskTemplate.as:887-888, 958-966` | [../quests/README.md](../quests/README.md) |

### 5.2 Level table (`raw/xml/tempinfos/RoyaltyTemplates.xml`)

Column names shortened: Theseus = `OpenTheseus`, Forbid = `OpenForbidenBoss`, Shop = `OpenShopLevel`, Outer/Inner/Core = `Open*TreasureHoke`, WarSoul = `OpenWarSoul`, WSTower = `OpenWarSoulTower`, FinalRoad = `OpenFinalRoad`, Pvp = `OpenPvp`, Tower = `OpenTower`, Dungeon = `OpenDungeon`, Slate = `OpenSlate`, Secret = `OpenSecret`. `Id = 1000 + Lv`.

| Lv | BossLevel | Theseus | Forbid | Shop | Outer | Inner | Core | WarSoul | WSTower | FinalRoad | Pvp | Tower | Dungeon | Slate | Secret | SkillId |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 84102001 |
| 2 | 16 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 84102002 |
| 3 | 24 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 84102003 |
| 4 | 32 | 2 | 1 | 1 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 84102004 |
| 5 | 42 | 2 | 2 | 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 84102005 |
| 6 | 52 | 2 | 2 | 2 | 3 | 1 | 20 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 84102006 |
| 7 | 62 | 2 | 2 | 2 | 3 | 1 | 20 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 84102007 |
| 8 | 72 | 2 | 2 | 2 | 5 | 1 | 40 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 84102008 |
| 9 | 84 | 3 | 2 | 2 | 5 | 2 | 40 | 0 | 0 | 0 | 1 | 1 | 0 | 0 | 0 | 84102009 |
| 10 | 96 | 3 | 3 | 3 | 5 | 2 | 60 | 3 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102010 |
| 11 | 108 | 3 | 3 | 3 | 7 | 2 | 60 | 3 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102011 |
| 12 | 120 | 3 | 3 | 3 | 7 | 2 | 80 | 3 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102012 |
| 13 | 134 | 3 | 3 | 3 | 7 | 3 | 80 | 3 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102013 |
| 14 | 148 | 4 | 3 | 3 | 7 | 3 | 100 | 3 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102014 |
| 15 | 162 | 4 | 4 | 4 | 9 | 3 | 100 | 6 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102015 |
| 16 | 176 | 4 | 4 | 4 | 9 | 3 | 120 | 6 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102016 |
| 17 | 192 | 4 | 4 | 4 | 9 | 3 | 120 | 6 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102017 |
| 18 | 208 | 4 | 4 | 4 | 9 | 3 | 140 | 6 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102018 |
| 19 | 224 | 5 | 4 | 4 | 9 | 3 | 140 | 6 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 84102019 |
| 20 | 240 | 5 | 4 | 5 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102020 |
| 21 | 256 | 5 | 5 | 5 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102021 |
| 22 | 272 | 5 | 5 | 5 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102022 |
| 23 | 288 | 5 | 5 | 5 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102023 |
| 24 | 304 | 6 | 5 | 5 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102024 |
| 25 | 320 | 6 | 5 | 6 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102025 |
| 26 | 336 | 6 | 5 | 6 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102026 |
| 27 | 352 | 6 | 5 | 6 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102027 |
| 28 | 368 | 7 | 5 | 6 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102028 |
| 29 | 384 | 7 | 5 | 7 | 9 | 3 | 150 | 9 | 1 | 2 | 1 | 1 | 0 | 0 | 0 | 84102029 |
| 30 | 400 | 7 | 5 | 7 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102030 |
| 31 | 420 | 7 | 5 | 7 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102031 |
| 32 | 440 | 8 | 5 | 7 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102032 |
| 33 | 460 | 8 | 5 | 8 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102033 |
| 34 | 480 | 8 | 5 | 8 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102034 |
| 35 | 500 | 8 | 5 | 8 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102035 |
| 36 | 520 | 8 | 5 | 8 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102036 |
| 37 | 540 | 9 | 5 | 8 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102037 |
| 38 | 560 | 9 | 5 | 9 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102038 |
| 39 | 580 | 9 | 5 | 9 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102039 |
| 40 | 600 | 9 | 5 | 9 | 9 | 3 | 150 | 9 | 1 | 3 | 1 | 1 | 1 | 1 | 0 | 84102040 |

### 5.3 Lookup helpers of `RoyaltyTempCate` (`CM/yishi/datas/templates/cate/RoyaltyTempCate.as`)

The client never searches "the value at level L" for gates; it searches "the first royalty level whose column equals v" and compares the player's level with it. All helpers are built once in `getTemplates` (`:54-127`):

| Helper | Returns | Used with |
|---|---|---|
| `getTempInfoByLevel(L)` (`:129-140`) | row of level L, null for 0 | suits, war soul cells, core cap, slate, secret |
| `getLockLv(f)` (`:162-166`) | min level with `OpenShopLevel == f` | Poseidon floors |
| `getForbiddenLv(c)` (`:192-196`) | min level with `OpenForbidenBoss == c` | forbidden zone tabs |
| `getOuterTreasureLv(n)`, `getInnerTreasureLv(n)` (`:198-208`) | min level with that slot count; 0 when the count never appears (for example outer 1, 2, 4), so the item loops to the next index | treasure tips |
| `getFinalRoadLv(t)`, `getWarSoulTowerLv(1)`, `getPvpLv(1)`, `getThessTowerLv(1)`, `getdilaoLv(1)` (`:210-238`) | min level of the tier or flag | gates |
| `minCoreLv` (`:156-160`) | min level with `OpenCoreTreasureHoke > 0` (6) | core item lock |
| `maxLv` (`:150-154`) | max `OpenShopLevel` (9) | Poseidon tab count |
| `getOpenWarsoul(sonType)` (`:168-190`) | never called; buggy (returns the dictionary entry of the argument instead of the matched key) | none |

Server rule: implement the same semantics with "value at the player's level >= required value" which is equivalent because every column is non decreasing.

---

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/RoyaltyTemplates.xml` (40 rows), loaded as `RoyaltyTemplates` (`CM/yishi/manager/TempleteManager.as:1358`) | One royalty level | All fields of §5.1 |
| `raw/xml/tempinfos/SkillPropertyTempInfos.xml` 84102001..84102040 | Attribute bonus of the royalty skill | `AddType` 1 (flat), `Attack`, `MagicAttack`, `Live` |
| `raw/xml/tempinfos/SkillTempInfos.xml` 84102001..84102040 | Royalty skill names "Habilidade de Realeza Nv. L" and display description | `TemplateName`, `Description` |
| `raw/xml/tempinfos/SecretMapLevelTemplates.xml` | Name of the `OpenSecret` map | `MapName` |

---

## 7. Persistent state

No table of its own. The royalty level lives in `royalty_boss.progress.royalty_level` ([royalty-path.md](royalty-path.md) §7). Features that cache unlocks (for example opened treasure slots) must derive them from it, not store a copy.

---

## 8. Backend implementation notes

- Provide one read API in the `royalty_boss` crate module `royalty_boss::levels`:
  - `royalty_level(player_id) -> u8` (0..40, from `progress`).
  - `row(level) -> Option<&RoyaltyTemplate>` (None for 0).
  - `value(player_id, Field) -> i32` = column value at the player's level (0 when level 0).
  - `required_level(Field, value) -> Option<u8>` = first level whose column `>= value` (used for refusal messages "Abre com Realeza Nv. {0}").
- Level-up hook `royalty_boss::levels::on_level_changed(player_id, old, new)`: recompute hero stats (skill bonus), and notify the features whose derived state depends on it (Theseus treasure slot info push 4298 when `Outer`, `Inner` or `Core` changed, see [../theseus/treasure.md](../theseus/treasure.md); Poseidon shop floor list; forbidden zone categories). Pushing 4292 is enough for every client gate listed in §5.1.
- Every consumer handler must re-check its gate on the server (the client gates are cosmetic): Theseus equip refuses a suit index above `OpenTheseus`; war soul equip refuses `SonType > OpenWarSoul`; core strengthen refuses `level >= OpenCoreTreasureHoke`; forbidden boss enter refuses category `> OpenForbidenBoss`; Poseidon buy refuses floor `> OpenShopLevel` and items with `OpenCondition > royalty level`; tower, dungeon, war soul tower, final road and Theseus PvP refuse when the flag or tier is not reached.
- Royalty attribute skill: add `Attack`, `MagicAttack`, `Live` of `SkillPropertyTempInfos[SkillId of current level]` to the hero (`AddType=1` flat) in every battle and in the displayed attributes *(assumption: applies everywhere, not only in royalty battles)*.

---

## 9. Open questions and assumptions

- *(assumption)* The royalty skill bonus is not cumulative across levels (values already grow linearly with the level).
- *(assumption)* The royalty skill bonus applies to the hero in all content.
- `OpenSecret` is 0 at every level in the local data, while `SecretAdRightView` locks every secret adventure card with `MapId > OpenSecret`. Either the live server ships different data or the card lock is cosmetic; check with [../exploration/README.md](../exploration/README.md) before enforcing it on the server.
- `OpenPvp` has no unlock line in the royalty frame although it gates Theseus PvP.

---

## 10. Implementation checklist

- [ ] Loader `RoyaltyTemplates.xml` with all 17 columns, validation that every column is non decreasing.
- [ ] Loader `SkillPropertyTempInfos` rows 84102001..84102040.
- [ ] `royalty_boss::levels` API (`royalty_level`, `row`, `value`, `required_level`).
- [ ] Level-up hook and hero stat recompute.
- [ ] Server gate in each consumer of §5.1 (tracked in the owner feature checklists).
- [ ] Test: level 9 player can equip suit 3 but not suit 4.
- [ ] Test: level 14 player opens forbidden category 3, refused on category 4.
- [ ] Test: level 20 player can use war soul SonType 9 and core level cap 150.
- [ ] Test: level 29 player is refused on the Theseus dungeon; level 30 accepted.
