# Theseus dungeon ("Masmorra de Teseus" / "Exploração da masmorra")

Area: PvE, feature `theseus`, module `dungeon` (code names `theseusdungeon`, `dungenexplo`, "dilao").

The player digs through a 28-floor dungeon:
- each floor is a grid of blocks (15, 25 or 45);
- breaking a block costs one pickaxe ("Picareta da masmorra") and reveals an event:
  - a chest (gold, dungeon crystals, slate dust, slates, keys);
  - a locked chest that needs a dungeon key;
  - a monster fight (normal, elite or boss; battleType **3915**);
  - a random stat buff ("skill") that lasts for the run;
- 25 free pickaxes per day, plus up to 20 bought with diamonds;
- one new floor unlocks per day of the month;
- the dungeon resets monthly;
- a task list ("Prêmio da exploração") pays bound diamonds, crystals and slate chests;
- crystals are spent in the dungeon shop.

Conventions:
- Paths are relative to `decompiled/` unless they start with `raw/`, `protocol/`, `index/`, `build/` or `docs/`. `CM` = `core_module/scripts`, `M11` = `m11/scripts`.
- Opcode names come from `protocol/opcodes.csv`. Proto tags were checked against the generated `writeToBuffer` in `build/as3/gen/com/road/yishi/proto/theseusdungeon/*.ts`. `protocol/proto.json` maps `TaskMsg` to an unrelated package because of a name collision. The real `theseusdungeon.TaskMsg` is `tasks (#1, TaskInfo, repeated)`.
- *(assumption)* marks anything the client does not prove.
- **Registry overlap:** `roadmap/features.json` lists the UI package `dungenexploration` under feature `exploration`. This file maps it fully because it is the only UI of `theseusdungeon`. The coordinator should keep one owner.

---

## 1. Overview

- **Entry.** Space map 10000 (Reino do Céu), NPC node 49 "Eliza, chefe da Zona Proibida". Its dialog option "167, Masmorra de Teseus" is listed in `raw/xml/tempinfos/MapNodeInfos.xml` Id 49 `Param3`. Client path:
  - `DialogOptionItem` case 167 (`m3/scripts/map/space/view/frame/DialogOptionItem.as:785-787`; constant `DUNGEONEXPLO = 167`, `:234`);
  - → `SwitchPageHelp.opendungeonexploFrame` (`CM/yishi/SwitchPageHelp.as:2365-2374`).
- **Unlock.** `RoyaltyBossManager.model.royaltyLevel >= royaltyTempCate.getdilaoLv(1)`, i.e. the first RoyaltyLevel with `OpenDungeon=1`. That is **RoyaltyLevel 30** in `raw/xml/tempinfos/RoyaltyTemplates.xml` (`CM/yishi/datas/templates/cate/RoyaltyTempCate.as:114-116, 228-232`). Otherwise the client shows "Abre com Realeza Nv. {0}" (`poseidon.shop.openLv`).
- **Frame.** Controller key `dungenexplo` (`mvc.controler.DungeonexploController`, `CM/mvc/controler/DungeonexploController.as:20-27`):

  | openType | Frame |
  |---|---|
  | 1 | main frame `dungenexploration.DungenexploFrame` |
  | 2 | task frame |
  | 3 | skill bag |
  | other | `view.subshop.DungenexShopFrame` (not used; the shop is opened through `shop` 1034) |

  The main frame constructor sends 9763 op 1 (`M11/dungenexploration/DungenexploFrame.as:96-99`).
- **Return from battle.** After a 3915 battle, `BattleResultHandler` sets `preSceneData.dungeonexplo` (`CM/battle/handler/BattleResultHandler.as:522-524`). The exit scene is `SPACE_SCENE` (`:323-327`). The space scene reopens `dungenexplo` 1 (`m3/scripts/map/space/SpaceSceneController.as:498-503`); the castle scene does the same (`m4/scripts/castle/CastleSceneView.as:362`).
- **Run window.** `ConfigInfos` `t_s_theseusdungeon_time` = "2026-04-01 00:00:00|2030-03-31 23:59:59" (open and close). The client does not check it.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `dungenexploration.DungenexploFrame` (`M11/dungenexploration/DungenexploFrame.as`), 1139x746, groups MAIN_TOOLS_GROUP and BAG_GROUP | "Exploração da masmorra" (`TheseusDungeonEventInfo.message5`, `:209`) | Floor grid, counters, navigation | NPC option 167; return from battle 3915 | 45 cells of 9 columns x 5 rows (`initMapItem`, `:114-130`). "{0}° andar" (`message6`, current floor `level`). "Andar atual desbloqueado: {0}" (`message7`, `getCurrentUnlockedLevel`). Pickaxes = free + bought (`:238`). Crystals = currency `theseusshuijing` (type 71). Keys = bag count of item 30000015 (`:241`). Hint "À 00h00 de todos os dias, a entrada para o próximo andar é desbloqueada" (`message8`). Buttons: rewards (opens type 2), shop (`shop` 1034), skill bag (opens type 3), "Para o próximo andar" (`message9`; topBtn4 when `level < unlocked`, else topBtn5 which only shows `message1`), buy pickaxes, help |
| `dungenexploration.item.DungenexploItem` (`M11/dungenexploration/item/DungenexploItem.as`) | none | One grid cell | Built by the frame | `model.blockInfo[index]`: null = wall (`shuizhuanBukepohuai`); otherwise event icon `icon/theseusdungeon<Icon>` (`PathManager.theseusdungeonIconPath`) under a breakable overlay for state 0. State switch in `refreshView` (`:156-190`) |
| `dungenexploration.DungenexploTaskFrame` (`M11/dungenexploration/DungenexploTaskFrame.as`), 583x652 | "Prêmio da exploração" (`message14`, `:173`) | Task list | Rewards button (`openControllerByInfo("dungenexplo",2)`, `DungenexploFrame.as:254-257`) | Hint "◇ Cumpra as condições indicadas para obter prêmios" (`dungenexploration.season.des`). Rows `DungeonrewardItem` with `Detail` + "(count/PassCount)", reward icons from `Reward`, claim button. Sort: claimable (status 1), then pending (0), then claimed (2) (`sortItemList`, `:108-150`) |
| `dungenexploration.DungenSkillBagFrame` + `view.DungenBoxBagView` (`M11/dungenexploration/DungenSkillBagFrame.as`, `M11/dungenexploration/view/DungenBoxBagView.as`), 625x522 | "Mochila de habilidades" (`thessbox.skT3`) | Read-only list of the buffs gained this run | Skill bag button (`openControllerByInfo("dungenexplo",3)`, `DungenexploFrame.as:264-267`) | "Habilidades Obtidas" (`thessbox.skT2`). 36 skill cells from `skillIdList` (icons from `SkillTempInfos`). Summed bonus text per stat from `SkillPropertyTempInfos` (AddType 0 shown as "%"; AddType 1 flat) (`updateView`, `:67-188`). Cells can be dragged but no request is sent (`DungenBoxSkillCellDropMediator`) |
| Help frame `dungenexploration.DungenexploFrame.helpFrame` | "Guia da masmorra de Teseus" (`dungenexploration.DungenexploFrame.helpFrametitle`) | Rules text | Help button (`:327-332`) | `dungenexploration.DungenexploFrame.helpFramecount` (28 floors, one per day, pickaxes reset daily, crystals for the shop, keys and crystals kept between runs) |
| `yishi.view.frame.BuyFrameI` (quick buy, style `quickbuy.buyFrame`) | quick-buy frame | Buy pickaxes | Buy button (`buyClickHandler`, `DungenexploFrame.as:349-362` → `quickUIcallback`, `:334-347`) | Item 30000013 "Picareta da masmorra", unit price `Point` = config[1] = 20 diamonds, daily cap `VIP0Count` = config[0] = 20, already bought = `20 - dayPurchasableActionNum` |
| `view.subshop.DungenexShopFrame` (m15) | "Loja de exploração de masmorra" (`message11`) | Crystal shop | `openControllerByInfo("shop",1034)` (`DungenexploFrame.as:259-262`) | Owned by the `shops` feature (`ShopControler.initDungenexShopFrame`, templates `getdungenexShopTempInfoList`) |
| Confirm popups (`SimpleAlertHelper`, title "Aviso") | none | Confirmations | Cell clicks, next floor | "Quer entrar no piso seguinte? (Não é possível voltar a este andar)" (`message2`). "Consuma {0} chave(s) do baú de masmorra para abrir. Pode obter itens valiosos aleatórios (incluindo placas divinos de alta qualidade)" (`message3`). "Deseja atacar o monstro?\nO monstro desaparecerá independentemente do resultado da batalha." (`message4`) |

---

## 3. Routes (client to server)

All requests use **9763 (0x2623) `C_THESEUS_DUNGEON_CLIENT_OP`** with `com.road.yishi.proto.player.PlayerOpMsg`. The sender is `DungeonExploManager.sendDungeonOperate(op, pos=0, templateId=0, count=0)` (`CM/managers/DungeonExploManager.as:135-145`).

The sender always sets four fields (zero when unused):
- `op (#1, INT32)`;
- `pos (#19, INT32)`: block position;
- `template_id (#8, INT32)`: task id;
- `count (#4, INT32)`: pickaxes to buy.

Op constants (`DungeonExploManager`):

| Op | Constant |
|---|---|
| 1 | ACTION_OPEN_INTERFACE |
| 2 | ACTION_ENTER_NEXT_FLOOR |
| 3 | ACTION_CLICK_BLOCK |
| 4 | ACTION_ACTIVATE_EVENT |
| 5 | ACTION_BUY_ENERGY |
| 6 | ACTION_TASK_FINISHED |

| # | UI control | Client sender (file:line) | Client checks, in order | Request body | Expected response |
|---|---|---|---|---|---|
| D1 | Open the dungeon | `DungenexploFrame()` (`M11/dungenexploration/DungenexploFrame.as:96-99`) | `opendungeonexploFrame` royalty check (`CM/yishi/SwitchPageHelp.as:2367-2372`) | `{op=1}` | **779** full user state, then **780** full task list *(assumption: the task frame never asks for tasks, and `__taskStateHandler` only merges when the list is non-empty, so the first 780 must contain all 30 tasks)* |
| D2 | "Para o próximo andar", then "Confirmar" | `_gonextstage` (`:269-279`) → `buyCallBack1` (`:280-286`) | Button visible only when `model.level < getCurrentUnlockedLevel()` (`__onDungeonDataUpdate`, `:233-252`); otherwise the other button shows "A sala do andar inferior ainda não foi ativada" (`message1`, `:288-291`). Confirm `message2` | `{op=2}` | **779** with the new `level` and the new floor `block_info`; **780** if the "reach floor N" tasks advance |
| D3 | Click a covered block (state 0) | `DungenexploItem.__clickHandler` (`M11/dungenexploration/item/DungenexploItem.as:82-92`) → `buyCallBack1` (`:64-80`) | `freeActionNum + buyActionNum > 0`, else "Picareta insuficiente" (`message13`). No adjacency check | `{op=3, pos(#19)=block.position}` | **779** with the block now in state 1 (event revealed) or state 2 (empty), and the pickaxe counters decremented; **780** for "Quebrar N blocos". The client plays the pickaxe effect locally |
| D4 | Click a revealed event (state 1) | `__clickHandler` (`:93-125`), branch on `TheseusDungeonEventTemplates.CondictionType`: **1 chest**: if `Property1 != "0"` (locked chest) confirm `message3` with {0}=`Property2`, then `buyCallBack` (`:56-62`); else send directly. **2 battle**: confirm `message4`, then send. **3 skill buff**: send directly | No key count check (the server must check `Property1` x `Property2`) | `{op=4, pos(#19)=block.position}` | Chest or skill: **779** (block state 2; `skill_id_list` grows for type 3) and inventory or currency pushes for the reward; **780** for task types 5 and 6. Battle: battle start **157** with battle_type **3915**, then the normal battle flow (156, 153..., 154, 4103). After the report, the block is set to state 2 whatever the result (`message4`). The client reopens the frame, which sends D1 again |
| D5 | Buy pickaxes (quick-buy confirm) | `buyClickHandler` (`DungenexploFrame.as:349-362`) → `quickUIcallback` (`:334-347`) → `BuyFrameI` confirm, `ItemId == 30000013` branch (`CM/yishi/view/frame/BuyFrameI.as:882-886`) | 1. `dayPurchasableActionNum > 0`, else "As compras de hoje atingiram o limite" (`theseuspvp.buyMax`); 2. generic BuyFrameI money check (diamonds, `Point * count`; "shop.view.frame.BuyFrameI.MoneyLack"); 3. count bounded by the remaining daily purchases *(assumption: BuyFrameI caps the count at OneDayCount - OneCurrentCount)* | `{op=5, count(#4)=n}` | **779** with `buy_action_num += n` and `day_purchasable_action_num -= n`; diamond balance push (core); **780** for "Comprar N picaretas" |
| D5b | (dead) `confirmChoose` | `DungenexploFrame.confirmChoose` (`:364-370`) | no caller | `{op=5}` (count 0) | Treat count 0 as 1 or reject *(assumption: reject)* |
| D6 | Task "claim" button | `DungeonrewardItem.getHandler` (`M11/dungenexploration/item/DungeonrewardItem.as:95-101`) | Button enabled only when `status == 1` (`set data`, `:195-215`) | `{op=6, template_id(#8)=TheseusDungeonTaskTemplates.TemplateId}` | **780** with the task in `status=2`; inventory and currency pushes for `Reward` |

Notes:
- The skill bag, the help and the shop button send nothing to this module. The shop uses the shops area protocol.
- Items 30000014 "Saco de picareta da masmorra" ("Ao usar aumenta o movimento da masmorra x100") and 30000013 used from the bag are item-use flows of the inventory area. They must add pickaxes here *(assumption: +100 and +1 bought actions, then push 779)*.

---

## 4. Server messages (server to client)

### 779 (0x030b) `U_C_THESEUS_DUNGEON_DATA`

- Message: `com.road.yishi.proto.theseusdungeon.TheseusDungeonUserMsg`.
- Receiver: `DungeonExploManager.__moneyReturnStateHandler` (`CM/managers/DungeonExploManager.as:63, 98-134`).
- When: response to ops 1 to 5, and a push at the daily and monthly resets when the frame is open *(assumption)*.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| op_type | 1 | INT32 | Not read by the client. Echo the op *(assumption)* |
| level | 2 | INT32 | Current floor number (1..28 = `TheseusDungeonTemplates.TemplateName`) |
| free_action_num | 3 | INT32 | Free pickaxes left today |
| buy_action_num | 4 | INT32 | Bought pickaxes left today |
| day_purchasable_action_num | 5 | INT32 | Purchases still allowed today (cap 20 minus bought) |
| block_info | 6 | TheseusDungeonBlockInfo, repeated | Floor blocks: `position (#1, INT32)` server id echoed in ops 3 and 4; `state (#2, INT32)`, see below; `event_id (#3, INT32)` `TheseusDungeonEventTemplates.Id`, 0 = empty |
| skill_id_list | 7 | INT32, repeated | Buffs gained this run (`SkillPropertyTempInfos` / `SkillTempInfos` ids 81000001..81000016) |

Block states (client: `DungenexploItem.__clickHandler` `:93-131`, `refreshView` `:175-190`):

| State | Meaning | Click result |
|---|---|---|
| 0 | Covered, breakable | D3 |
| 1 | Broken, event waiting | D4 |
| 2 | Done | "Área Concluída" (`ChristmasSnowymistMapItem.message.txt3`) |
| 3 | Unreachable *(assumption: not adjacent to an opened block)* | "Área bloqueada. Explore outras áreas primeiro." (`...txt1`) |

Grid layout, applied by the client on `block_info` (`:107-127`):
- **15 blocks**: 3 rows of 5, centred in the 9x5 grid at rows 1..3, columns 2..6. The client inserts 4 nulls after each 5 blocks, 11 nulls in front and 5 at the end.
- **25 blocks**: 5 rows of 5 at columns 2..6.
- **45 blocks**: used as is, row-major 9x5.

So the server must send the blocks **in row-major order of the floor's own grid**, exactly 15, 25 or 45 entries (= `TheseusDungeonTemplates.Grid`). The array index, not `position`, decides where a block is drawn.

Client effect: stores the fields, then dispatches `THESEUS_DUNGEON_DATA`. The frame redraws all cells, the floor texts, the counters and the next-floor button (`DungenexploFrame.__onDungeonDataUpdate`, `:233-252`).

### 780 (0x030c) `U_C_THESEUS_DUNGEON_TASK_DATA`

- Message: `theseusdungeon.TaskMsg` = `tasks (#1, TaskInfo, repeated)`. `TaskInfo` = `task_id (#1, INT32)`, `status (#2, INT32)` (0 in progress, 1 claimable, 2 claimed), `count (#3, INT32)` progress shown as "(count/PassCount)".
- Receiver: `DungeonExploManager.__taskStateHandler` (`CM/managers/DungeonExploManager.as:64, 67-97`).
- Behaviour: when the model list is empty, it takes the whole list. Otherwise it **replaces only the tasks whose `taskId` already exists**; new ids are ignored. Then it sends the notification `THESEUS_DUNGEON_TASK_DATA` (the task frame redraws, `DungenexploTaskFrame.updateRewardHandler`, `:79-107`).
- When: after op 1 (full list of 30), and after any progress or claim (changed tasks only, or full list).

### Unused

`theseusdungeon.EventItemMsg { items (#1, ItemMsg{item_id #1, num #2}, repeated) }` and `theseusdungeon.ItemMsg` have no reader in the client (grep of `build/as3/gen`). They need not be implemented. They may have been used for a reward popup.

### Related pushes owned by other areas

- Currency type 71 `theseusshuijing` ("Cristal da masmorra", item id -5600). The frame reads `PlayerCurrencyManager.currencyInfo.theseusshuijing` (`build/as3/gen/managers/PlayerCurrencyManager.ts`, case 71) and refreshes on `CURRENCYREFRESH`. The currency push is 4725 `U_C_PLAYER_TOKENINFO` (`AcceptProtocolType`), absent from `protocol/opcodes.csv`.
- Bag count of item 30000015 "Chave de baú de masmorra" (`GoodsManager.getBagCountInPlayerAndStoneByTempId`).
- Diamond, bound-diamond and gold balances.
- Battle messages for 3915 (`docs/battle/README.md`).

There is no result or error code. Rejections send nothing *(open question)*.

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | RoyaltyLevel 30 or more (`OpenDungeon=1`) | `RoyaltyTemplates.xml`; `SwitchPageHelp.as:2365-2374` |
| Floors | 28 (`TheseusDungeonTemplates` Id 101..128, `TemplateName` 1..28, chained by `Prelayersid`) | template |
| Floor size | `Grid` = 15 (floor 1), 25 (floor 2), 45 (floors 3..28) | template |
| Daily unlock | Floor N is unlocked when the day of the month (server time with `castle_offset`) is `>= TimeUnlock`: floors 1 and 2 on day 1, floor N on day N-1 for N >= 3 (floor 28 on day 27). Client: `TheseusDungeonModel.getCurrentUnlockedLevel` (`CM/mvc/module/theseus/dungeon/TheseusDungeonModel.as:48-62`). **Client bug:** it compares `TemplateId (101..) > result (1..28)`, which is always true, so it returns the `TemplateName` of the last template iterated with `TimeUnlock <= day`. With ascending iteration that equals the maximum | model |
| Next floor | Allowed when `level < unlocked`. No return to earlier floors ("Não é possível voltar a este andar"). The client does not require clearing the floor. *(assumption: the server does not either)* | `message2`; `DungenexploFrame.as:233-252` |
| Monthly reset | `t_s_theseusdungeon_reset` = 1: on day 1 of each month the run restarts at floor 1 with fresh grids and empty `skill_id_list`. Tasks reset too *(assumption)*. Keys (30000015) and crystals (-5600) are kept (help text item 6) | `ConfigInfos.xml` |
| Free pickaxes | `t_s_theseusdungeon_free` = 25 per day. At 00:00 free and bought pickaxes are reset; unused ones are lost (help item 4) | `ConfigInfos.xml` |
| Bought pickaxes | `t_s_theseusdungeon_pay` = "20,20": max 20 purchases per day, 20 diamonds each (the `Point` of the quick buy; the payment type is diamonds per `message12` "Deseja gastar {0} diamantes para comprar 1 picareta?") | `ConfigInfoManager.gettheseusdungeon` (`CM/yishi/datas/ConfigInfoManager.as:52`); `DungenexploFrame.as:334-347` |
| Pickaxe use order | Free first, then bought *(assumption)* | none |
| Break a block | 1 pickaxe. Reveals `event_id` (state 1), or state 2 when empty | `DungenexploItem.as:64-80` |
| Floor content | `EventGroup` = "eventId,count\|...". Place exactly these events at random positions among the `Grid` blocks; the rest are empty. Example floor 1 (15 blocks): 5 x 10005 "?" chests, 3 x 10002 crystal sacks, 1 x 20101 normal monster, 1 x 30001 skill, 5 empty | template |
| Chest events (CondictionType 1) | Reward1 = weighted list "item,count,weight\|..."; draw one entry by weight *(assumption)*. 10001 gold 50 000; 10002 crystals 100..300; 10003 key x1; 10004 locked chest needs `Property1`=30000015 x `Property2`=1 (slate dust, 1-slot to 4-slot slates); 10005 slate dust 20..50; 10006 divine chest (slates). Items 3001xxxx..3004xxxx are slates (`godhead` module, MasterType 15 SonType 800, `Property1` = slate template) | template |
| Battle events (CondictionType 2) | `Property1` 1 normal, 2 elite, 3 boss. Normal and elite: `Property2` = "pawnTemplateId,pos\|..." (PawnTempInfos, e.g. 31000001 "Espadachim do Julgamento" at pos 2, 3 and 8; elite has 32000001 "Cavaleiro do Julgamento" at pos 8). Boss: `Property3` = "GameHeroTemp,pos" (e.g. 30000001 "Espadachim Soenke" HeroType 3 at pos 5; floor 28 boss 30000028 "Kanuos"). `BattleGround` 12 or 13 = battle background. Win reward `Reward1` (crystals 100; weight 100 normal, 500 elite, 1000 boss *(assumption: the weight is irrelevant with one entry)*); boss extra `Reward2` = key 30000015 x1. Monster removed after the battle, win or lose | template; `message4` |
| Skill event (CondictionType 3, id 30001) | Draw one of 81000001..81000016 (weight 100 each) and append it to `skill_id_list`. Effects (`SkillPropertyTempInfos`, AddType 0 = percent): Live +5/10/20/30 %, Attack +5/10/15/20 %, Defence +10/20 %, MagicAttack +5/10/15/20 %, MagicDefence +10/20 %. They apply to the player in 3915 battles until the monthly reset *(assumption)* | template; `DungenBoxBagView.as:67-188` |
| Tasks | 30 rows. Type 1 reach floor N (2, 5, 10, 15, 20, 25, 28); 2 break N blocks (10..700); 3 win N elite battles; 4 win N boss battles; 5 obtain skills N times; 6 open N locked chests; 7 buy N pickaxes. Each reward = "-500,10" (Diamante Vinculado) + "-5600,N" crystals + "30000010,1" (Baú divino) | `TheseusDungeonTaskTemplates.xml` |

---

## 6. Templates

| File (`raw/xml/tempinfos/`) | Loader | Record meaning | Fields used |
|---|---|---|---|
| `TheseusDungeonTemplates.xml` (28 rows) | `TheseusDungeonCate` (`CM/yishi/manager/TempleteManager.as:1377`) | Floor | `TemplateId` 101..128; `TemplateName` floor number "1".."28"; `Prelayersid` previous floor id; `TimeUnlock` day of month 1..27; `Grid` 15/25/45; `EventGroup` "eventId,count\|..." |
| `TheseusDungeonEventTemplates.xml` (91 rows) | `TheseusDungeonEventCate` (`:1378`; `getListById` linear scan) | Block event | `Id`; `CondictionType` 1 chest, 2 battle, 3 skill; `Notes` (Chinese designer note); `Property1` (chest: required item or 0; battle: 1/2/3 kind); `Property2` (chest: required count; battle: soldiers "temp,pos\|..."); `Property3` (boss "heroTemp,pos"); `Icon` (`icon/theseusdungeon/<Icon>`); `BattleGround` 12/13; `Reward1` weighted "item,count,weight\|..."; `Reward2` extra (boss key) |
| `TheseusDungeonTaskTemplates.xml` (30 rows) | `TheseusDungeonTaskCate` (`:1379`) | Task | `TemplateId` 1..30; `Detail` ("Chegar ao 2º andar"); `Type` 1..7; `PassCount`; `Sort`; `Reward` "item,count\|..." |
| `SkillPropertyTempInfos.xml` rows 81000001..81000016 | `SkillPropertyTemplateCate` (`:1174`) | Buff stats | `AddType` (0 percent); `Live`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence` |
| `SkillTempInfos.xml` rows 81000001..81000016 | `getSkillById` | Buff skill (icon, name, e.g. "A vida máxima aumenta em 5%.", `BufferIds` 81000001) | `Icons`, `TemplateName`, `BufferIds` |
| `ConfigInfos.xml` | `ConfigInfoManager` | Dungeon config | `t_s_theseusdungeon_time` "2026-04-01 00:00:00\|2030-03-31 23:59:59"; `t_s_theseusdungeon_reset` "1"; `t_s_theseusdungeon_free` "25"; `t_s_theseusdungeon_pay` "20,20" |
| `PawnTempInfos.xml` 31000001..31000028, 32000001..32000028 | soldier templates | Normal and elite monsters | stats for the battle |
| `GameHeroTemp.xml` 30000001..30000028 | hero templates | Floor bosses (HeroType 3, Grades 80) | stats, AI, ResPath |
| `ItemTempInfos.xml` | goods | Items | 30000013 "Picareta da masmorra"; 30000014 "Saco de picareta da masmorra"; 30000015 "Chave de baú de masmorra"; 30000010 "Baú divino"; -5600 "Cristal da masmorra"; -500 "Diamante Vinculado"; -100 "Ouro" |
| `RoyaltyTemplates.xml` | `RoyaltyTempCate` | Unlock | `OpenDungeon` |
| `MapNodeInfos.xml` Id 49 | space nodes | NPC entry | `Param3` option 167 |

---

## 7. Persistent state

Schema `theseus`.

```sql
CREATE TABLE theseus.dungeon_runs (
  player_id                BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  run_month                date     NOT NULL,              -- first day of the month of this run
  floor                    smallint NOT NULL DEFAULT 1 CHECK (floor BETWEEN 1 AND 28),
  free_actions             smallint NOT NULL DEFAULT 25 CHECK (free_actions >= 0),
  bought_actions           smallint NOT NULL DEFAULT 0 CHECK (bought_actions >= 0),
  purchases_left_today     smallint NOT NULL DEFAULT 20 CHECK (purchases_left_today >= 0),
  actions_day              date     NOT NULL,              -- day the action counters belong to
  skill_ids                integer[] NOT NULL DEFAULT '{}',
  updated_at               timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE theseus.dungeon_blocks (
  player_id   BIGINT  NOT NULL REFERENCES theseus.dungeon_runs(player_id) ON DELETE CASCADE,
  floor       smallint NOT NULL,
  position    smallint NOT NULL CHECK (position BETWEEN 0 AND 44),  -- row-major index in the floor grid
  state       smallint NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 3),
  event_id    integer  NOT NULL DEFAULT 0,                          -- 0 = empty
  PRIMARY KEY (player_id, floor, position)
);

CREATE TABLE theseus.dungeon_task_progress (
  player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  run_month   date     NOT NULL,
  task_id     smallint NOT NULL,                                    -- TheseusDungeonTaskTemplates.TemplateId
  progress    integer  NOT NULL DEFAULT 0,
  claimed_at  timestamptz,
  PRIMARY KEY (player_id, run_month, task_id)
);

CREATE TABLE theseus.dungeon_pending_battles (
  battle_id   text     PRIMARY KEY,
  player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  floor       smallint NOT NULL,
  position    smallint NOT NULL,
  event_id    integer  NOT NULL,
  started_at  timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX dungeon_pending_battles_player ON theseus.dungeon_pending_battles (player_id);
```

- Only the current floor's blocks are needed. Delete the rows of a floor when the player leaves it.
- Task `status` is derived: 2 if `claimed_at` is set; 1 if `progress >= PassCount`; else 0. For type 1, progress = the highest floor reached.
- Keys, crystals and diamonds live in the inventory and currency tables.

---

## 8. Backend implementation notes

### Handlers (one per op of 9763)

Before every handler, apply the lazy resets:
- if `run_month` < the current month (reset day 1), or no row exists: create a new run on floor 1, generate the floor 1 grid, clear `skill_ids` and the task rows;
- if `actions_day` < today: `free_actions = 25`, `bought_actions = 0`, `purchases_left_today = 20`.

Also refuse outside `t_s_theseusdungeon_time` and below royalty level 30.

| Handler | Op | Validation order | Transaction and response |
|---|---|---|---|
| `theseus::dungeon::handle_open` | 1 | unlock, window | read (and lazy reset in a tx). Send 779 (blocks in row-major order, `event_id` 0 for state 0 and 3 blocks *(assumption: hide unrevealed events; the client draws the icon under the overlay anyway)*), then 780 with all 30 tasks |
| `theseus::dungeon::handle_next_floor` | 2 | floor < 28 → floor+1 unlocked today (`TimeUnlock` of the next template `<=` day of month) → no pending battle | tx: floor+1, delete the old blocks, generate the new grid from `EventGroup` (random placement; initial states 0 for the starting reachable set and 3 for the others *(assumption)*), update the type 1 task progress. Send 779, 780 if changed |
| `theseus::dungeon::handle_break_block` | 3 | block exists on the current floor → state 0 → free_actions + bought_actions > 0 | tx: spend 1 action (free first), state = 1 if event_id != 0 else 2, unlock neighbours from 3 to 0 *(assumption)*, task type 2 progress +1. Send 779, 780 if changed |
| `theseus::dungeon::handle_activate_event` | 4 | block state 1 → event exists. Chest with `Property1 != 0`: player has `Property2` of item `Property1`. Battle: player not in another battle or team | Chest: tx: consume the key (locked chest), draw a reward from Reward1, grant it, state 2, task type 6 progress for 10004. Skill: draw the skill id, append it to skill_ids, state 2, task type 5 progress. Battle: insert `dungeon_pending_battles`, start the battle (below); on the report (4103) tx: state 2 (win or lose), on win grant Reward1 (and Reward2 for bosses), task type 3 (elite) or 4 (boss) progress. Send 779 (and 780) after the tx; after a battle send them when the client reopens (op 1) |
| `theseus::dungeon::handle_buy_actions` | 5 | count >= 1 → count <= purchases_left_today → diamonds >= 20 x count | tx: debit diamonds, bought_actions += count, purchases_left_today -= count, task type 7 progress += count. Send 779, the diamond push, 780 if changed |
| `theseus::dungeon::handle_claim_task` | 6 | task exists → progress >= PassCount → not claimed | tx: set claimed_at, grant `Reward` (bound diamonds -500, crystals -5600, item 30000010). Send 780 (task status 2) and the currency and inventory pushes |

### Battle configuration (3915)

Uses `docs/battle/server-engine.md` §9.2:

```json
{"battle_type":3915,
 "map":"<MapInfos.Id whose BattleGround equals the event BattleGround, e.g. 10000 for 12 or 987 for 13 (assumption)>",
 "count_down":180,
 "heroes":[ "<player hero with the run buffs applied: each skill_ids entry adds its SkillPropertyTempInfos percent to the matching stat>",
            "<boss only: {temp_id: Property3 hero, type: 3, pos: Property3 pos}>" ],
 "soldiers":[ "<player soldiers>",
              "<normal/elite: one entry per Property2 pair {temp_id: pawn, pos}>" ],
 "report":{"battle_result":1, "items":"<Reward1 (+ Reward2 for bosses)>"},
 "report_defeat":{"battle_result":2}}
```

On exit, the client goes to `SPACE_SCENE` and reopens the dungeon frame, which sends op 1.

### Schedules and pushes

- Schedules: none required (lazy resets at request time). Optionally push 779 at 00:00 to online players with the frame open *(assumption)*.
- Pushes to other players: none.

---

## 9. Open questions and assumptions

1. **Ownership:** the UI package `dungenexploration` is registered under feature `exploration`. The theseus brief assigns the model and proto here. One owner must be chosen.
2. Meaning of block state 3 and the reachability rule (adjacency to opened blocks is assumed from the text "Explore outras áreas primeiro").
3. Initial reachable blocks of a new floor; whether `event_id` is hidden for covered blocks.
4. Whether elite, boss and normal battle wins depend on the result for rewards (the text says the monster vanishes either way; rewards are assumed only on a win).
5. Battle map id for BattleGround 12 and 13 (the client needs a `MapInfos` id).
6. Whether tasks and skills reset monthly with the run, and whether the floor is reset when the month changes mid-floor.
7. Use order of free vs. bought pickaxes, and the effect of items 30000013 and 30000014 used from the bag.
8. Reward draw semantics for `Reward1` (single weighted draw assumed).
9. The client day-unlock bug in `getCurrentUnlockedLevel` (§5). The server is authoritative.
10. Error channel for rejected ops (none in the protocol).
11. `docs/battle/rules.md` labels 3915 "Labirinto da Aventura" (`dungeonexplore.view.Title`, an older feature's key). The in-frame title is "Exploração da masmorra".

---

## 10. Implementation checklist

**Screens:**

- [ ] NPC 49 option 167 → royalty check → `dungenexplo` 1
- [ ] `DungenexploFrame`: grid layouts 15, 25 and 45, counters, next-floor buttons, help
- [ ] `DungenexploItem` click flows for states 0, 1, 2, 3 and CondictionType 1, 2, 3
- [ ] `DungenexploTaskFrame` + `DungeonrewardItem` (sort, progress text, claim)
- [ ] `DungenSkillBagFrame` / `DungenBoxBagView` (skills and summed bonus)
- [ ] Quick buy of pickaxes through `BuyFrameI` (item 30000013)
- [ ] Shop 1034 link (shops area)
- [ ] Return from battle 3915 reopens the frame

**Routes:**

- [ ] 9763 op 1 `handle_open`
- [ ] 9763 op 2 `handle_next_floor`
- [ ] 9763 op 3 `handle_break_block`
- [ ] 9763 op 4 `handle_activate_event` (chest, locked chest, skill, battle)
- [ ] 9763 op 5 `handle_buy_actions`
- [ ] 9763 op 6 `handle_claim_task`

**Server messages:**

- [ ] 779 `TheseusDungeonUserMsg` (row-major blocks, exact Grid length)
- [ ] 780 `TaskMsg` (full list first, then deltas)
- [ ] Currency 71 and inventory pushes; battle messages for 3915

**Tables:**

- [ ] `theseus.dungeon_runs`
- [ ] `theseus.dungeon_blocks`
- [ ] `theseus.dungeon_task_progress`
- [ ] `theseus.dungeon_pending_battles`

**Rules and templates:**

- [ ] Loaders: TheseusDungeonTemplates, TheseusDungeonEventTemplates, TheseusDungeonTaskTemplates, SkillPropertyTempInfos 8100xxxx, ConfigInfos `t_s_theseusdungeon_*`, RoyaltyTemplates.OpenDungeon
- [ ] Daily reset (25 free, 20 purchasable) and monthly reset (day 1)
- [ ] Floor generation from EventGroup; day-of-month unlock
- [ ] Reward draws; key consumption; skill buffs applied in 3915

**Tests:**

- [ ] Break with 0 pickaxes refused; free then bought consumption
- [ ] Locked chest without a key refused; with a key consumes 1
- [ ] Next floor refused before its unlock day and at floor 28
- [ ] Buy beyond 20 per day refused; diamonds debited 20 each
- [ ] Battle loss still clears the block; win grants rewards; boss grants a key
- [ ] Task progress per type and single claim
- [ ] Monthly rollover keeps keys and crystals and resets the floor
