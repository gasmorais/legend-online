# Item usage ("Usar", "Usar em massa")

Module of [README.md](README.md). Using consumables and special items from the bag: client routing per SonType, single and batch use, the use request 5006 and its variants (8665 stele items, 8521 VIP coin, 8345 rename card), effect families, item buffers (4188), learned recipes (4184), cooldown like limits and results. Opening boxes and packs is detailed in [boxes.md](boxes.md).

Path aliases:

| Alias | File |
|---|---|
| PBC | `decompiled/core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as` |
| GIM | `decompiled/core_module/scripts/cell/view/GoodsItemMenu.as` |
| MUF | `decompiled/core_module/scripts/bag/view/MulItemUseFrame.as` |
| BH | `decompiled/core_module/scripts/bag/helper/BagHelper.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| PBM | `decompiled/core_module/scripts/yishi/manager/PlayerBufferManager.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| MM | `decompiled/core_module/scripts/managers/MountsManager.as` |
| GC | `decompiled/core_module/scripts/bag/helper/GoodsCheck.as` |

## 1. Overview

- Usable items: MasterType 2 or 4 whose SonType is in `BH.checkCanUseGoods` (`BH:76-139`: 201, 203, 206, 209, 211, 213, 217, 218, 219, 221, 222, 226, 237, 278, 280, 282, 289, 292, 294, 296, 298, 302, 306, 308, 311, 313, 314, 315, 316, 320, 322, 331, 340, 399, 510, 600, 601, 602, 603, 604, 606, 607, 608, 609, 621, 622, 624, 625, 626, 710, 800, 801) or whose template is in `BH.checkCanUseGoods2` (`BH:141-158`: 2100038, 3101011, 3101021, 3101031, 3101041, 208001, 208044, 208009).
- Single click on a usable item opens the menu "Usar", "Mover" and, when allowed, "Usar em massa" (`PBC:117-170`). Double click uses directly (`PBC:182-599`). Both run the same SonType switch; many SonTypes open another feature's frame instead of sending a request.
- The default request is 5006 `U_C_BAG_USEITEM` with slot, count and bag. The server consumes `count` items, applies the effect and answers with 115 for the slot plus the pushes of the effect (player counters, buffers, new items, titles, mounts...). There is no dedicated result message; failures are silent or a 126 text.
- No generic cooldown exists for items. Limits: buffer strength (a weaker buffer cannot replace a stronger one), energy caps, daily times props (SonType 609), level requirement (`NeedGrades`), context checks (scene, guild, pets).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from |
|---|---|---|---|
| `cell.view.GoodsItemMenu` (`core.GoodsItemMenu`) | buttons "Usar" (`cell.view.GoodsItemMenu.use`), "Mover" (`.move`), "Usar em massa" (`.mul`) | per item menu (`GIM:92-108`) | single click on usable item; never for bag 6 (`PBC:1047-1058`) |
| `bag.view.MulItemUseFrame` (`core.MulItemUseFrame`, extends `SpliteItemFrame`) | "Usar em massa" (`bag.view.MulItemUseFrame.command01`) | quantity input, default = stack count (SonType 311: what the player can pay) (`MUF:42-99`) | "Usar em massa" |
| Simple alerts | "Liberando{0} {1} irá consumir {2} “{3}”, deseja continuar?" (paid chest, `cell.mediator.playerbag.PlayerBagCellClickMediator.command09`); "Use o Cartão de alteração de sexo para modificar o seu sexo atual, continuar?" (`yishi.service.managers.SocketSendManager.sendUseSexChangeCard`); "Ao usar aumentará {0} experiência do Einherjar combatente, continuar?" (`checkForUsePetExpBook.content02`); "Deseja encaminhar até a Ilha de Einherjar {0} Piso?" (`checkForUsePetLandTransfer.content01`); energy caps (`...command06`, `...command07`); "Após usar reduzirá {0}pts de energia..." (`PlayerBagCellClickMediator.useGroupfbIncome.Tips`); "Esta montaria está ativada permanentemente, ao utilizar irá decompor Essência da Fera x{0}, deseja continuar?" (`cell.mediator.playerbag.useMountCardAlert`) | confirmations | per SonType |
| Task trace "use now" popups `VIPCardTipView`, `KingContractTipView`, `CampaignCardTipView` | | offer to use a just obtained card | `TaskTraceTipManager` on new items (`decompiled/m16/scripts/tasktracetip/view/VIPCardTipView.as:90-93`, `KingContractTipView.as:41-45`, `CampaignCardTipView.as:97-100`) |

## 3. Routes (client to server)

### U1. Use item (5006)

- Senders: `PBC.__mouseDoubleClick` (`PBC:182-599`), `GIM.__userHandler` (`GIM:249-665`), `MUF.__confirmHandler` (`MUF:109-341`, count from the input), popups above, `GradeBoxFrame` ([boxes.md](boxes.md)), `MountsManager.sendUseGoods` (`MM:369-386`), rose frames (`decompiled/core_module/scripts/simplegame/roses/RosePresentView.as:190-206`), cross server bugle (`decompiled/core_module/scripts/yishi/view/community/CrossBugleFrame.as:99`), planes bag (SonType 606, `decompiled/m4/scripts/buildings/transferbuilding/view/planesbag/PlanesBagCellClickMediator.as:32-40`), armory bag of the divine weapon (`decompiled/m11/scripts/ancientartifact/view/ArmoryGoodsItemMenu.as`), campaign energy shortcut (`decompiled/m13/scripts/selectcampaign/view/CampaignInfoView.as:375-404`, energy potions 2030500..2030503).
- Client path: `SSM.sendUseItem(pos, count = 1, bagType = 1, battleId = "", friendId = 0)` (`SSM:157-167`).
- Route: C>S 5006 (0x138e) `U_C_BAG_USEITEM`.
- Request `item.ItemUseMsg`: `pos` (#1, INT32) slot; `count` (#2, INT32) quantity (1 unless batch use); `bag_type` (#3, INT32) always 1 from the client; `battle_id` (#4, STRING) free text payload: chat text for the cross server bugle (SonType 280) and the rose / snow rose message (SonType 217, 399), empty otherwise; `friend_id` (#5, INT32) target player for roses, snow roses and gifts (`HandlselFrame`), 0 otherwise.
- Response: 115 for the consumed slot + effect pushes (5.2). Optional 126 on failure.

### U2. Use stele exchange item (8665)

- SonType 710 (`PBC:324-327`, `GIM:329-332`, `MUF:132-136`): `SSM.sendUseStelaItem(pos, count)` (`SSM:169-179`).
- Route: C>S 8665 (0x21d9) `C_STELA_BOX`; request `item.ItemUseMsg` (same fields as U1). Effect: converts to `Property2` units of `Property1` ([../steles/README.md](../steles/README.md)). Response 115.

### U3. VIP coin (SonType 292, "Moeda VIP")

- Checks: not in bot mode ("Modo Bot em andamento", `mopup.MopupManager.mopupTipData01`); shows a modal mask (`PBC:432-442`).
- Route: C>S 8521 (0x2149) `C_VIP_COIN_OPEN`, empty body (`SSM:202-206`). Effect and reply owned by [../vip/README.md](../vip/README.md) (random VIP reward); 115 consumes one coin.

### U4. Rename card (SonType 289, "Carta de Renomeamento")

- Opens `RenameView(1, null, goods)`; on confirm `SSM.sendRename(nick, 1, pos)` (`decompiled/core_module/scripts/yishi/view/community/RenameView.as:205`).
- Route: C>S 8345 (0x2099) `C_PLAYER_RENAME_REQ`; `player.PlayerRenameReqMsg`: `nickName` (#1, STRING), `type` (#2, INT32) 1 = by card, `pos` (#3, INT32) card slot. Owner [../account/README.md](../account/README.md); the server consumes the card (115).

### U5. Buffer expiry stop (client driven)

- When a local buffer timer completes, `PBM.removeBuffer` (`PBM:364-384`) sends C>S 8283 (0x205b) `C_EFFECT_STOP` with `player.EffectRemoveReqMsg`: `templateId` (#1, INT32) buffer id, `ownType` (#2, INT32) buffer type; for buffer 2001 ("Placa de Isenção de Batalhas") it sends 8562 (0x2172) `C_CASTLE_TIME_CANCEL` with no body. Expected reply: 4188 with `validity_date <= 0` for that buffer.

### U6. Client routing per SonType (double click and "Usar")

Common checks first (`PBC:222-229`, `GIM:272-278`): hero level >= `NeedGrades` (except SonType 298) else "Nível insuficiente".

| SonType / template | Action | Extra client checks | Request |
|---|---|---|---|
| 201, 237 (buffers) | use | if a buffer with id `Property1` is active and `Property3 < active grade` -> "Você possui efeito mais forte, não é possível substituir" (`PBC:567-578`, `GIM:628-638`) | 5006 |
| 203 (utilities) | use | P1 in [8, 22] requires a guild ("Você não é membro de Guilda, não é possível usar esse item", `PBC:1000-1006`); P1 = 5 energy caps (5.3) | 5006 |
| 203 2032102 | use | confirm; class change done (`fund.fundRewardView.NewbieTip`); `weary >= P3` ("Energia insuficiente") (`PBC:722-751`) | 5006 |
| 206 (open box), 2100038, 3101011..3101041, 208001, 208009 | use | none | 5006 ([boxes.md](boxes.md)) |
| 208044 | Guardian sex frame `ChildManager.openSexFram(pos)` when `applyInfo.state == 0` else "Não tem Guardião, não é possível usar" | | guardians feature |
| 209 (blood) | use | none | 5006 |
| 211 (recipe scroll) | use | recipe already known -> "Você já aprendeu essa fórmula" (`PBC:1007-1012`) | 5006, then 4184 |
| 213 (bounty card) | use | not in bot mode; no bounty task running ("Já tem missão de recompensa em andamento..."); daily bounty left (`...OfferTaskItem.command02`) (`PBC:1013-1033`) | 5006 ([../quests/README.md](../quests/README.md)) |
| 217 (rose), 399 (snow rose) | opens `RosePresentView` / `SnowRosePresentView` (choose friend, message, count) | | 5006 with `friend_id`, `battle_id` = message |
| 218 (mount card) | `MountsManager.sendUseGoods` (`MM:369-386`): mount class >= `P3` ("Requer Classe {0}"); if the mount is already owned: permanent (P2 = -1) cards ask to decompose into "Essência da Fera" x `Power * mount_card_resolve_multiple`, or refuse when `Refresh == -1` ("Esta carta de montaria já foi ativada permanentemente, não pode decompor") (`PBC:455-486`) | | 5006 ([../mounts/README.md](../mounts/README.md)) |
| 219 (gashapon coupon) | opens the gashapon frame (`SwitchPageHelp.openPumpingJoyFrame`) | | none |
| 221 (title card) | title already active and not long term (`IsLong == 0`) -> "Já ativou este título. Não tem como usar este item." (`PBC:287-302`) | | 5006 ([../hero/README.md](../hero/README.md) titles) |
| 222 (new year card) | opens `newyearact` HANDLSEL frame | | seasonal events |
| 226 (guardian skill book) | opens the guardian frame tab 3 | | guardians |
| 277 (guardian exchange) | `ChildManager.checkForExchangeChild` | | guardians |
| 278 (fashion soul) | opens the fashion frame | | fashion |
| 280 (cross server bugle) | opens `CrossBugleFrame` (text, forbidden words check) | | 5006 with `battle_id` = text |
| 289 (rename) | U4 | | 8345 |
| 292 (VIP coin) | U3 | | 8521 |
| 294 (alliance card) | only when the guild join cooldown is active (`now - lastOutConsortia < 86400` and auto join) else "Estado atual não requer uso do Cartão de Aliança" (`PBC:230-235`) | | 5006 |
| 298 (novice pack) | opens `GradeBoxFrame` ([boxes.md](boxes.md)) | | 5006 from the frame |
| 302 (passive rune) | opens the hero skill panel | | skills |
| 306 (Einherjar orb) | pet count < `petMaxCount` else "Limite de Einherjar atingido!" (`PBC:1034-1043`) | | 5006 |
| 308 (pet exp book) | confirm; fighting pet exists and not full exp (`PBC:772-807`) | | 5006 |
| 311 (paid chest) | player owns `P3 * count` of currency `P2` else "Itens insuficientes para abrir o Baú, não poderá abrir"; confirm (`PBC:328-431`) | | 5006 ([boxes.md](boxes.md)) |
| 313 (pet island transmitter) | scene must be space, castle, farm or a pet island map; confirm; not in bot mode; stops team follow (`PBC:809-878`) | | 5006 (teleport) |
| 315 (single pass bugle) | level >= 60 ("Nível não atingiu nv.{0}...") then opens the single pass frame | | trials |
| 320 (Cupid arrow / treasure map) | `random_skill_5 == 1` -> "Item inválido"; else `TreasureMapManager.useTreasureMap` | | treasures |
| 340 (sex change card) | confirm (`SSM:181-200`) | | 5006 |
| 510 (campaign gain card) | campaign `P2` open (`CampaignTemplateManager.isOpenByActiveCampaign`) else "A Campanha atual não está aberta, este item não pode ser usado" | | 5006 |
| 622 (summer boss summon) | only in the outer city scene ("Esta carta de convocação do chefão apenas pode ser usado nos arredores.") | | 5006 |
| 624 (protection spirit skill book) | opens the guardian NS frame | | guardians |
| 710 (stele item) | U2 | | 8665 |
| 800, 801 (stargazing) | archaeology level >= 3 ("Ativado quando a Arqueologia atinge o nível máximo."); opens stargazing tab 0/1/2 by template | | cosmos |
| any other usable SonType (209, 282, 296, 314, 316, 322, 331, 600..609, 621, 625, 626) | default branch: buffer check then 5006 (`PBC:567-598`) | | 5006 |

### U7. Batch use ("Usar em massa")

- Shown when `IsCanBatch` is true, or SonType 311 and the player can pay for more than one, or a `checkCanUseGoods2` template with `count > 1`; never for 208044 (`PBC:120-168`).
- `GIM.__useMulHandler` (`GIM:142-247`) repeats the level and context checks; SonType 298 and 222 open their frames; opens `MulItemUseFrame` with `count` default = stack (or payable amount).
- Confirm (`MUF:109-341`): 209 -> 5006 with count; 710 -> 8665 with count; 292 -> 8521; 217 -> rose frame with count; 308 -> confirm with `P2 * count` exp; 510 -> campaign check then 5006 with count; 311 -> currency check `P3 * count` and confirm; others -> guild check for 203 P1 = 8 (`MUF:475-486`), buffer grade check, energy caps with `P2 * count`, then 5006 with count.
- Guardian variant (`_isItem = false`): template 208042 -> `ChildSender.useResetGoods`, SonType 226 -> `ChildSender.upgradeSkill` (guardians feature, 8868 `C_CHILDREN_OP`).

## 4. Server messages (server to client)

| Opcode | Message and fields | Receiver | When |
|---|---|---|---|
| 115 (0x0073) `U_C_BAG_MOVE_UPDATE` | [item-instance.md](item-instance.md) S1 | `GM.__bagUpdateHandler` | every use: consumed slot, new items (`is_new = true` triggers the fly animation and sound) |
| 3 (0x0003) `U_C_PLAYER_INFO` | `player.PlayerMsg` counters: `point` #6, `giftToken` #7, `weary` #21, `wearyLimit` #81, `gp` #17 (exp), `repute` #18, `consortiaOffer` #19, `strategy` #20 ... | `PM.__uPlayerInfoHandler` (`PM:150`) | after SonType 203 currencies, energy, exp, VIP trial |
| 109 (0x006d) `U_C_CASTLE_UPDATE` | gold | `ResourceManager.__resourceUpgrade` | gold boxes |
| 4188 (0x105c) `U_C_ITEM_BUFFER` | `item.ItemBufferRspMsg`: `bufferData` (#1, repeated `item.BufferDataMsg`): `template_id` (#1, INT32) buffer id (= item `Property1`), `validity_date` (#2, INT32) remaining minutes (<= 0 removes), `grade` (#3, INT32) strength, `type` (#4, INT32) buffer type (5 ignored by the client; 4 and 7 always listed), `type_templateid` (#5, INT32) item template that created it (0 = not shown unless type 4/7), `isCancel` (#6, BOOL) | `PBM.__refreshItemBufferHandler` (`PBM:311-352`, listener `PBM:82`): updates the buffer list, removal tip `addBufferDisapearTip` | login and after a buffer item use or expiry |
| 4184 (0x1058) `U_C_ITEM_SMITH` | `item.ItemSmithyMsg`: `composeId` (#1, INT32, repeated) learned recipe ids | `PM.__addComposeTempHandler` (`PM:450-459`): appends to `composeList` | after using a recipe scroll; full list at login ([../smith/compose.md](../smith/compose.md)) |
| 126 `U_C_MSG` | text | | failures |
| feature pushes | titles, mounts, pets, guardians, VIP, campaign counters, teleport scene change | owning features | per effect |

## 5. Rules and formulas

### 5.1 Consumption

- Every successful use consumes `count` items from the slot (box style items) except items whose effect is a frame (no request). Assumption: when the effect fails (for example bag full for a box), nothing is consumed and 126 is sent.
- Use from bag 1 only (`bag_type` is always 1 from the client); the server should also accept bag 34 rows only if they are usable (none of the treasure bag types are usable).

### 5.2 Effect families (server)

| Family | SonTypes | Effect |
|---|---|---|
| Currency / counter | 203 (P1 table in [item-catalog.md](item-catalog.md) 5.4.1), 602, 621, 296 | add `P2 * count` to the counter; push 3 or 109 or the feature counter |
| Buffer | 201, 237 | create or extend buffer `P1` with grade `P3` for `P2` minutes; refuse a lower grade over a higher active one; push 4188 |
| Box / pack | 206, 298, 311, 350, 609, `checkCanUseGoods2` templates | roll drop `P1` (or fixed contents), pay `P3 * count` of currency `P2` for 311; push 115 with new items ([boxes.md](boxes.md)) |
| Unlock / grant | 218 mount, 221 title, 306 Einherjar, 607 guardian, 600 magic card, 625 divine weapon, 626 crest, 282 titan seal | grant the referenced object; feature push |
| Learn | 211 recipe | add recipe; push 4184 |
| Task | 213 bounty, 608 task scroll | start a task; quest push |
| Teleport | 313, 606 | change scene to map `P1` |
| Social | 217, 399, 280, 316 | charm and friendship to `friend_id`, broadcast with `battle_id` text |
| Account | 289 rename, 340 sex change, 292 VIP coin, 294 alliance card (clears guild join cooldown) | account / guild / VIP features |
| Campaign | 510 (gain count +1 for campaign `P2`), 2032102 (team campaign gain, costs `P3` energy), 622 (summon boss in outer city), 203 P1 15 | campaign counters |

### 5.3 Limits

- Energy potions (SonType 203, P1 5): weary cap 200 per player; daily recovery cap 600 (`wearyLimit` counts what was recovered today). Client asks for confirmation when `P2 * count > 200 - weary` or `> 600 - wearyLimit` (`PBC:900-957`). Server: credit `min(amount, 200 - weary, 600 - wearyLimit)` (assumption: the item is still consumed).
- Buffers: one active buffer per buffer id; a new item with lower grade is refused, equal or higher replaces or extends (assumption: extends duration when same grade).
- Times props (SonType 609): one use per day, `P2` uses in total; instance `usedTimes`, `isTodayUsed` (`decompiled/core_module/scripts/yishi/view/tips/goods/PropTips.as:203-213`).
- Level: `NeedGrades` (except novice packs, which show their level but can be opened only when reached, [boxes.md](boxes.md)).
- No cooldown timers exist for bag items in this client.

## 6. Templates

| File | Fields |
|---|---|
| `ItemTempInfos.xml` | `SonType`, `Property1..3`, `IsCanBatch`, `NeedGrades`, `MaxCount` |
| `ConfigInfos.xml` | `mount_card_resolve_multiple` (mount card decompose factor) |
| `EffectTempInfos.xml` | buffer definitions (assumption: keyed by buffer id = item `Property1`) |
| `MountTempInfos.xml`, `AppellInfos.xml`, `PetTempInfos.xml`, `ComposeTempInfos.xml` | targets of grants |

## 7. Persistent state

Items: `inventory.items`. Buffers created by items:

```sql
CREATE TABLE inventory.item_buffers (
  player_id          INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  buffer_id          INTEGER     NOT NULL,
  buffer_type        SMALLINT    NOT NULL,
  grade              INTEGER     NOT NULL CHECK (grade >= 0),
  source_template_id INTEGER     NOT NULL,
  expires_at         TIMESTAMPTZ NOT NULL,
  PRIMARY KEY (player_id, buffer_id)
);
CREATE INDEX item_buffers_expiry_idx ON inventory.item_buffers (expires_at);

CREATE TABLE inventory.item_use_log (
  use_id       BIGSERIAL   PRIMARY KEY,
  player_id    INTEGER     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id  INTEGER     NOT NULL,
  count        INTEGER     NOT NULL CHECK (count > 0),
  target_id    INTEGER,
  opcode       INTEGER     NOT NULL,
  used_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX item_use_log_player_idx ON inventory.item_use_log (player_id, used_at DESC);
```

Daily energy recovery (`wearyLimit`) and weary are player counters ([../hero/README.md](../hero/README.md)).

## 8. Backend implementation notes

- `inventory::usage::handle_use` (5006): lock the slot; validation order: slot exists in bag 1 and owned -> `1 <= count <= row.count` -> template usable (5.2 family exists) -> level -> family specific checks (guild, pet slots, scene, currency for 311, buffer grade, daily limits) -> apply effect -> consume -> commit -> push 115 then effect pushes. Dispatch table `son_type -> fn(ctx, row, count, battle_id, friend_id)`.
- `inventory::usage::handle_use_stele` (8665): same pipeline with the stele family.
- `inventory::usage::buffers`: scheduler removes expired buffers and pushes 4188 (`validity_date = 0`); `handle_effect_stop` (8283) removes the buffer early when the client timer ends; 8562 owned by castle protection ([../castle/README.md](../castle/README.md)).
- Login: push 4188 with active buffers and 4184 with learned recipes.
- Rewards that create items use `inventory::store::add` with `is_new = true`.

## 9. Open questions and assumptions

- Exact effect of each 203 subtype amount with `count > 1` (assumption: linear).
- Buffer extension rules for equal grade (assumption: replace and reset duration).
- Transformation cards (201 with `P4`): shape change push owned by battle / hero (`U_C_ARMY_CHANGESHARP` 4164, assumption).
- Whether 5006 with `bag_type` other than 1 must be supported (the client never sends it).

## 10. Implementation checklist

- [ ] Use menu and batch frame behaviour (client already implemented)
- [ ] Route 5006 with dispatch per SonType (all rows of U6)
- [ ] Route 8665 stele items
- [ ] Route 8521 VIP coin (with vip feature)
- [ ] Route 8345 rename by card (with account feature)
- [ ] Route 8283 effect stop and 8562
- [ ] Push 4188 buffers, 4184 recipes, 3 counters
- [ ] Energy caps 200 / 600
- [ ] Times prop daily counter
- [ ] Tables `inventory.item_buffers`, `inventory.item_use_log`
- [ ] Tests: buffer grade refusal, batch use counts, paid chest currency debit, guild only items
