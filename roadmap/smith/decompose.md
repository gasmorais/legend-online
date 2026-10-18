# Smith: decompose ("Decompor")

Scope: the resolve tab of the smith frame (`NewResolveView`) and its four sub tabs: items (`ResolveView1`), Theseus war frame equipment (`TheseusRosolveView`), treasures (`TreasureResolveView`) and Avenger mythic spheres (`AvengerRosolveView`), plus the batch selection popups (`AllResolvePopFrame`, `TreasyreResolvePopFrame`). Frame shell, smith bags and placement into the hidden smith bag (bag 0, positions 0..11, route 5005 `U_C_BAG_MOVE`) are in [store-frame.md](./store-frame.md).

Path aliases:

| Alias | File |
|---|---|
| SSOM | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StoreControler.as` |
| SBCM | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellClickMediator.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/AvengerManager.as` |
| AMOD | `decompiled/core_module/scripts/mvc/module/avenger/AvengerModel.as` |
| TM | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| TMOD | `decompiled/core_module/scripts/mvc/module/theseus/TheseussoulModel.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| MF | `decompiled/m14/scripts/store/MakeFrame.as` |
| NRV | `decompiled/m14/scripts/store/NewResolveView.as` |
| RV1 | `decompiled/m14/scripts/store/ResolveView1.as` |
| ARV | `decompiled/m14/scripts/store/AvengerRosolveView.as` |
| TRV | `decompiled/m14/scripts/store/TheseusRosolveView.as` |
| TRSV | `decompiled/m14/scripts/store/treasure/TreasureResolveView.as` |
| ARPF | `decompiled/m14/scripts/store/resolve/AllResolvePopFrame.as` |
| TRPF | `decompiled/m14/scripts/store/treasure/TreasyreResolvePopFrame.as` |
| ASIC | `decompiled/m14/scripts/store/resolve/AvengerStoreItemCell.as` |
| TSIC | `decompiled/m14/scripts/store/resolve/TheseusStoreItemCell.as` |
| SB2 | `decompiled/m14/scripts/store/StoreBagII.as` |

## 1. Overview

Four decompose flows, each with its own route:

| Sub tab | Items | Where the selection lives | Route | Result push |
|---|---|---|---|---|
| Items ("propBtn") | equipment (MasterType 1, Profile 2..5), mount cards (SonType 218), fashion, dual attribute gems (228, 343, 344), magic crests (626) | hidden smith bag positions 0..11 | 8340 `C_ITEM_RESOLVE` (no body) | bag pushes + 4260 `U_C_RESOLVE` |
| Treasure | treasures SonType 750 (outer) / 751 (inner) | hidden smith bag positions 0..11 | 8683 `C_NEW_ITEM_RESOLVE` `PlayerOpMsg.type = 4` | bag pushes + 4260 |
| Avenger | mythic spheres SonType 670 in the Avenger virtual bag (type 3) | client list, sent as "templateId,count\|..." | 8657 `C_AVENGER_CLIENT_OP` op 8 | 212 `U_C_VIRTUAL_BAG_UPDATE` (type 3) + bag pushes |
| Theseus | war frame equipment SonType 720 in the Theseus armor bag | client list, sent as "instanceId,count\|..." | 8684 `C_THESEUS_WARFRAMECLIENT_OP` op 4 | Theseus bag / suit pushes (owned by [../theseus/README.md](../theseus/README.md)) |

- Unlock: hero level 19 (`MF:188-191`). Sub tab gates (`NRV:79-81`): Avenger only when deified (and `VersionSwitch.AVENGER`), Theseus and Treasure only when `royaltyLevel > 0`.
- Batch decompose ("Decompor em lote") exists for Avenger and Theseus: a filter popup marks every matching unlocked item.
- Related routes owned by other features: 8681 `C_VIRTUAL_ITEM_RESOLVE` type 5 (Theseus collection fragments, `TM:1010-1016`, `decompiled/m5/scripts/theseusCollention/item/SpliteCollectionFrame.as:28`) and 9720 `C_RUNE_RESOLVE`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `NRV` (`store.NewResolveView`) | tab 3 of "Fabricar" | Sub tab container | `MF.showResolveView` (`MF:369-377`), tab disabled below 19 with tip "Função habilitada no Nv. {0}" | 4 sub tab buttons; each switch moves smith slot items back (`NRV:97-157`) |
| `RV1` (`NewResolveView.propView`) | | Item decompose | `NRV` | 12 slots (hidden bag 0 pos 0..11, keys "pos_0_0", `RV1:100-114`), up to 6 result materials with counts and bound flag (`RV1:115-130`, `RV1:197-347`), gold cost, decompose button, `StoreBagII` with title "Material de decomposição obtido" |
| `TRSV` (`NewResolveView.treasureView`) | | Treasure decompose | `NRV` | 12 slots, up to 3 result materials (`TRSV:90-116`), `TreasureStoreBag` with tabs "Externo" / "Interno" (750 / 751) |
| `ARV` (`NewResolveView.avengerView`) | | Avenger sphere decompose | `NRV` | 4 selected spheres (`ARV:98-113`), up to 12 result materials (`ARV:115-130`), buttons decompose, batch, cancel batch, Avenger store bag |
| `TRV` (`NewResolveView.theseusView`) | | Theseus equipment decompose | `NRV` | 4 selected items, up to 12 results incl. strengthen and reform refunds (`TRV:308-467`), batch buttons |
| `ARPF` (`store.resolve.AllResolvePopFrame`) | "Decompor em lote" (`ARPF:287`) | Avenger batch filter | `ARV` batch button (`ARV:230-235`) | combo "Atributos do Equipamento" (sphere color: "Tudo", "Verde", "Azul", "Roxo", "Laranja", "Vermelho") and combo "Nível do Equipamento" ("Nv. {0} e abaixo") (`ARPF:60-89`, `ARPF:179-256`) |
| `TRPF` (`store.treasure.TreasyreResolvePopFrame`) | "Decompor em lote" | Theseus batch filter | `TRV` batch button (`TRV:203-208`) | combo element ("Tudo", "Água", "Fogo", "Choque", "Vento", "Luz", "Escuridão", "Marinha", "Terra", "Celeste") and "Qualidade do Equipamento" / level (`TRPF:89`, `TRPF:200-262`) |
| `decompiled/m14/scripts/store/resolve/ResolveView.as` | | Legacy item decompose (same logic as `RV1`) | legacy `StoreFrame` (`decompiled/m14/scripts/store/StoreFrame.as:325`) | |

## 3. Routes (client to server)

### R0. Place / remove items (shared)

- Items and treasures are moved into hidden bag 0 positions 0..11 with 5005 `U_C_BAG_MOVE` (`SBCM:238-271`), position from `SC.getGoodsPosForRelove` (`SC:928-966`, first empty of 12, `SC:968-985`). See [store-frame.md](./store-frame.md). Client checks before the move:
  - Locked item -> "Não é possível Decompor equipamento bloqueado" (`SBCM:66-70`, `SBCM:111-115`).
  - Not decomposable type -> "Tipo de equipamento incorrespondente"; equipment with inserted gems -> "Equipamento contêm gema inserida, não pode ser decomposto"; `Refresh == -1` -> "Este item não pode ser decomposto."; no free slot -> "Espaço cheio" (`SC:928-966`).
  - Mixing rules (`SC:987-1061`): dual attribute gems (228 / 343 / 344) only with the same template; crests 626 not with 228 / 343 / 344; others not with 228 / 343 / 344. Tips "Gemas de atributos duplos não pode ser decompostos com outros itens ou com outras gemas de atributos duplos diferentes!", "Equipamentos não podem ser decompostos por gemas de atributos duplos ou almas divinas de atributos duplos!", "Gemas com atributos duplos não podem ser decompostas com outros acessórios ou almas divinas de atributos duplos.", "Brasões Mágicos não podem ser decompostos com gemas de atributos duplos ou almas divinas de atributos duplos.".
  - Confirms with "do not ask again" (`SC:1063-1169`): mount card "Após a decomposição da montaria irá desaparecer e poderá ganhar a alma da Fera, deseja continuar?"; fashion "Após a decomposição da moda, irá desaparecer e você obterá fragmento da alma, continuar?"; strengthened equipment "Equipamento fortalecido, certeza ao decompor?"; strengthened treasure "O tesouro foi fortalecido. Deseja mesmo Decompor?".
- Avenger and Theseus selections are client side only (no route) until R3 / R4: double click adds (max 4 entries, `ASIC:167-190`, `TSIC:253-276`), drag swaps (`ASIC:118-160`); while a batch selection is active single moves are blocked with "Seleção múltipla ativa. Cancele para continuar." (`ASIC:169-173`, `TSIC:255-259`).

### R1. Decompose items

- UI: decompose button of `RV1` (`RV1:137`, `RV1:156-166`).
- Client checks: `gold < cost` -> "Ouro Insuficiente" (`RV1:159-164`); button enabled once `price >= 0` after at least one update (`RV1:338-346`).
- Client path: `SSOM.sendResolve()` (`SSOM:173-177`), also legacy `ResolveView.as:158`.
- Route: send 8340 (0x2094) `C_ITEM_RESOLVE`, no body. The server decomposes every item in hidden bag 0 positions 0..11.
- Response: bag pushes (items removed, materials added, gold), then 4260 `U_C_RESOLVE` (S1).

### R2. Decompose treasures

- UI: decompose button of `TRSV` (`TRSV:123`, `TRSV:150-153`); enabled when at least one result material is computed (`TRSV:255-274`).
- Client path: `SSOM.sendTreasureResolve()` (`SSOM:179-185`).
- Route: send 8683 (0x21eb) `C_NEW_ITEM_RESOLVE`, `PlayerOpMsg` (fields in section 4 table T1) with `type (#2) = 4`; all other fields unset. Targets: treasures in hidden bag 0 positions 0..11.
- Response: bag pushes, then 4260 (S1).

### R3. Decompose Avenger spheres

- UI: decompose button of `ARV` (`ARV:138`, `ARV:237-272`).
- Client checks: single mode: "do not ask again" alert "Decompor a Esfera Mítica, traz gastos à Pedra esculpida, quer ir adiante?" (`ARV:250-255`); batch mode: alert "Deseja decompor o equipamento <font color='#{1}'>{2}</font> de <font color='#ffffff'>{0}</font> na mochila?\n(Equipamentos bloqueados não serão decompostos)" with level, color and type (`ARV:242-249`, response codes 2 / 3 confirm `ARV:258-267`). Button enabled when the single or batch list is not empty (`ARV:409`).
- Client path: `AM.sendAvengerResolve(resolveIdCounts)` (`AM:249-256`); string built in `ARV.refreshClientView` (`ARV:307-410`): "templateId,count|" for each selected entry, single list then batch list.
- Route: send 8657 (0x21d1) `C_AVENGER_CLIENT_OP`, `PlayerOpMsg` with `op (#1) = 8`, `param1 (#15) = "6711101,1|6711102,3|"` style list. Other op values of 8657 belong to [../avenger/README.md](../avenger/README.md) (op 9 `sendChildNsUpgrade` etc., `AM:258-266`).
- Response: 212 `U_C_VIRTUAL_BAG_UPDATE` bagType 3 (S2), which triggers `DEVIL_ARMOR_BAG_UPDATE` and resets the view (`BM:350-351`, `ARV:215-220`); bag pushes for the materials.

### R4. Decompose Theseus war frame equipment

- UI: decompose button of `TRV` (`TRV:140`, `TRV:217-250`).
- Client checks: single mode: "do not ask again" alert "Deseja decompor os itens acima?" (`TRV:231-233`); batch mode: same batch alert as R3 (`TRV:222-230`).
- Client path: `TM.doWarFrameParam(4, 0, 0, resolveIdCounts)` (`TM:980-993`); string "instanceId,count|" (`WarFrameItemInfo.id`, `TRV:337`, `TRV:399`).
- Route: send 8684 (0x21ec) `C_THESEUS_WARFRAMECLIENT_OP`, `PlayerOpMsg` with `op (#1) = 4`, `id (#5) = 0`, `pos (#19) = 0`, `param1 (#15)` = list; `ids (#20)` unset. Other op values of 8684 belong to [../theseus/README.md](../theseus/README.md).
- Response: Theseus armor bag update and suit update pushes (Theseus feature); `TRV` refreshes on `TheseussoulManager EVENT_SUIT_UPDATE` (`TRV:139`, `TRV:210-215`). Bag pushes for the materials.

### R5. Batch selection (client only)

- Avenger: `ARPF` lists `ItemResolveSortTemplates` rows with `Sontype == 670` (from `AM.resolveList`, `ARPF:205-256`), plus "Tudo" (id 0); level combo "Nv. {0} e abaixo" for 1..`Propety2`. Confirm (the button stored as `_cancelBtn`) sets `isAllResolve = true` and notifies `AVENGER_ALL_RESOLVE` with `[level, type]` (`ARPF:268-273`). Each `ASIC` with showType 1 adds itself (full count) when `descTemplateInfo.Property1 <= level` and (`type == 0` or `descTemplateInfo.Profile == type`), skipping locked items (`ASIC:195-245`, `AMOD:207-221`).
- Theseus: `TRPF` lists rows with `Sontype == 720` (`TRPF:219-262`); `TSIC` adds items with `warTempInfo.Property4 <= level` and (`type == 0` or `warTempInfo.Property1 == type`), skipping locked and equipped ones (`TSIC:281-335`, `TMOD:252-275`).
- If nothing matched: "Nenhum equipamento disponível para Decompor" (`ARV:170-188`, `TRV:178-196`). Cancel clears the batch (`ARV:222-228`, `TRV:170-176`).

## 4. Server messages (server to client)

### T1. `PlayerOpMsg` (package player), used by R2, R3, R4

| Field | R2 (8683) | R3 (8657) | R4 (8684) |
|---|---|---|---|
| op (#1, INT32) | unset | 8 | 4 |
| type (#2, INT32) | 4 (treasure) | unset | unset |
| payType (#3, INT32) | unset | unset | unset |
| count (#4, INT32) | unset | unset | unset |
| id (#5, INT32) | unset | unset | 0 |
| index (#6, INT32) | unset | unset | unset |
| userId (#7, INT32) | unset | unset | unset |
| templateId (#8, INT32) | unset | unset | unset |
| campaignId (#9), nodeId (#10), chapterId (#11) (INT32) | unset | unset | unset |
| uuid (#12, STRING) | unset | unset | unset |
| value1 (#13), value2 (#14) (INT32) | unset | unset | unset |
| param1 (#15, STRING) | unset | "templateId,count\|..." | "itemId,count\|..." |
| param2 (#16, STRING) | unset | unset | unset |
| flag1 (#17), flag2 (#18) (BOOL) | unset | unset | unset |
| pos (#19, INT32) | unset | unset | 0 |
| ids (#20, INT32, repeated) | unset | unset | unset |

### S1. 4260 (0x10a4) `U_C_RESOLVE`, `SmithResolveRspMsg`

- result (#1, BOOL): true on success.
- Receivers: `RV1.__resolveResultHandler` (`RV1:136`, `RV1:386-415`), `TRSV.__resolveResultHandler` (`TRSV:122`, `TRSV:277-299`), legacy `ResolveView.as:132`. The body is not read: the client clears all 12 slots and material previews and resets the bag view regardless of `result`.
- When: after R1 and R2, after the bag pushes. On failure the server should keep the items, send `result = false` and a message tip (Assumption).

### S2. 212 (0x00d4) `U_C_VIRTUAL_BAG_UPDATE`, `VirtualBagMsg` (package item)

| Field | Meaning |
|---|---|
| bagType (#1, INT32) | 3 = Avenger armor bag (4 ignored, 5 Theseus collection, 6 Theseus box) |
| items (#2, VirtualItemMsg, repeated) | changed entries: templateId (#1, INT32), count (#2, INT32), pos (#3, INT32), isLock (#4, BOOL) |

- Receiver: `BM.__virtualBagUpdateHandler` (`BM:351`, `BM:407-420`) updates `AvengerModel.armorBagDic` and notifies `DEVIL_ARMOR_BAG_UPDATE`; `ARV.__updateBagViewHandler` resets selection (`ARV:215-220`). Full snapshot is 211 `U_C_VIRTUAL_BAG_DATA` (same message). Owned by [../avenger/README.md](../avenger/README.md); the smith handler must emit it after R3.

### S3. Bag and resource pushes

- Owned by inventory; see [store-frame.md](./store-frame.md) and [../inventory/README.md](../inventory/README.md). `RV1`, `TRSV` recompute on `UPDATE_BAG` / `DELETE_BAG` of hidden slots (`RV1:168-190`, `TRSV:155-177`).

## 5. Rules and formulas

### Items (R1), mirror of the client preview (`RV1:197-384`)
- Gold cost: 1000 per unit of every slot item, except crests (SonType 626) which cost 0.
- Output per slot item (count c = stack count in the slot):

| Source | Output template | Output count |
|---|---|---|
| SonType 218 mount card | 2120044 "Alma do Deus das Feras" | `Refresh * c` |
| SonType 228, 343, 344 dual attribute gem | template `Property5` and template `Property6` | `1 * c` each |
| fashion (`GoodsCheck.isFashion`) | 2120043 "Fragmento de Alma da Moda" | `Refresh * c` |
| SonType 626 crest | template `Refresh` | `Property2 * c` |
| other equipment | template `Refresh` (refine stone) | by Profile: 2 -> 1, 3 -> 4, 4 -> 18, 5 -> 18 (others 0), times c |

- Outputs keep the bound flag of the source (bound and unbound outputs of the same template are separate previews).
- Eligibility (`SC:1185-1201`, `SB2:682-723`): equipment MasterType 1 with `Refresh != 0`, `Profile < 6`, SonType 101..108 in the bag, not worn by the main hero; mount cards and fashion need `Refresh != -1`; no inserted gems; not locked.

### Treasures (R2) (`TRSV:184-275`)
- Output = `ItemResolveTemplates` Type 4 row with `ResolvedItem = treasure template`: `Item1..4 * Count1..4 * c` (17 rows, for example 7502101 -> 2127022 x1).
- Plus refund of strengthen materials: for strengthen grade s > 0, sum `StrengthenItemNum` of every `TheseusTreasureGrowupTemplates` row with `TreasureId = template` and `TreasureLevel < s`, grouped by `StrengthenItem` (`decompiled/core_module/scripts/yishi/datas/templates/cate/TheseusTreasureGrowupCate.as:49-70`).
- No gold cost in the client.

### Avenger (R3) (`ARV:307-410`)
- Output = `ItemResolveTemplates` Type 1 rows by `ResolvedItem = sphere template` (1680 rows; for example 6711102 -> 6920001 "Pedra de esculpir" x12) times count.
- Single selection adds 1 unit per template (max 4 templates, `AMOD:193-205`); batch adds the full owned count (`AMOD:207-221`). Locked spheres are refused.

### Theseus (R4) (`TRV:308-467`)
- Output = `ItemResolveTemplates` Type 3 rows by `ResolvedItem = template` (872 rows) plus the `Recovery` strings ("templateId,count|...") of the item current strengthen row (`TheseusEquipStrengthenTmpls`) and current reform row (`TheseusEquipQualityTmpls`), times count.
- Negative template ids in outputs (for example `-19000` in Type 3 rows and `Cost` strings) are resources, not items; the client skips them in the preview because no item template exists. Assumption: -19000 is a currency owned by the Theseus feature.
- Eligible items: SonType 720, `Property2 != 2`, not equipped, not locked (`TheseusStoreBag.as:271-276`, `TMOD:231-275`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ItemResolveTemplates.xml` (2600 rows, cate `ResolveTemplateCate` key `Type_ResolvedItem`, loaded `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1321`) | decompose result | `Id`, `Type` (1 Avenger, 2 Estrada Demoníaca, 3 Theseus, 4 treasure, 5 collection fragment), `ResolvedItem`, `Item1..4`, `Count1..4` |
| `raw/xml/tempinfos/ItemResolveSortTemplates.xml` (14 rows, loaded `TempleteManager.as:1284`) | batch filter options | `Sontype` (670 / 720), `Propety1` (Profile for 670, element 1..9 for 720), `PropetyName1` (pt-BR label), `Propety2` (max level in combo), `Color` |
| `raw/xml/tempinfos/TheseusTreasureGrowupTemplates.xml` | treasure strengthen step | `TreasureId`, `TreasureLevel`, `StrengthenItem`, `StrengthenItemNum` |
| `raw/xml/tempinfos/TheseusEquipStrengthenTmpls.xml`, `TheseusEquipQualityTmpls.xml` | Theseus strengthen / reform rows | `Recovery` refund string |
| `raw/xml/tempinfos/ItemTempInfos.xml` | item templates | `MasterType`, `SonType`, `Profile`, `Refresh`, `Property1`, `Property2`, `Property5`, `Property6` |

## 7. Persistent state

Items, the Avenger virtual bag and the Theseus armor bag are owned by inventory / avenger / theseus (Assumption). Only an audit log is smith specific:

```sql
CREATE TABLE smith.resolve_log (
    log_id        BIGSERIAL PRIMARY KEY,
    player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    flow          SMALLINT NOT NULL CHECK (flow IN (1, 2, 3, 4)),  -- 1 items, 2 treasure, 3 avenger, 4 theseus
    inputs        JSONB NOT NULL,      -- [{template_id, item_id, count, bound}]
    outputs       JSONB NOT NULL,      -- [{template_id, count, bound}]
    gold_spent    BIGINT NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX resolve_log_player_idx ON smith.resolve_log (player_id, created_at DESC);
```

## 8. Backend implementation notes

Handlers:
- 8340 -> `smith::decompose::handle_resolve_items`.
- 8683 -> `smith::decompose::handle_resolve_treasure` (only `type = 4`; other types reject).
- 8657 op 8 -> `smith::decompose::handle_resolve_avenger` (dispatch from the Avenger client op router).
- 8684 op 4 -> `smith::decompose::handle_resolve_theseus` (dispatch from the Theseus war frame op router).

`handle_resolve_items`:
1. Hero level >= 19. Load hidden bag 0 positions 0..11; reject when empty.
2. Re-validate every item: type eligibility, `Refresh` rules, no gems, not locked, not worn, mixing rules for 228 / 343 / 344 / 626.
3. Gold = 1000 per unit (626 free).
4. Compute outputs (table above) keeping bound flags; check bag space.
- Transaction: delete inputs, debit gold, add outputs, log. After commit: bag / resource pushes, then 4260 `result = true`.

`handle_resolve_treasure`: same skeleton with treasure eligibility (SonType 750 / 751, not locked), Type 4 rows plus growup refunds, no gold; 4260.

`handle_resolve_avenger`:
1. Parse `param1` as `templateId,count` pairs; reject malformed, duplicates or count <= 0.
2. Each template SonType 670, present in the Avenger virtual bag with enough unlocked count; hero deified.
3. Outputs from Type 1 rows.
- Transaction: decrement virtual bag, add outputs, log. After commit: 212 bagType 3 with changed entries, bag pushes.

`handle_resolve_theseus`:
1. Parse `itemId,count` pairs; each item in the Theseus armor bag, SonType 720, `Property2 != 2`, not equipped, not locked; royalty level > 0.
2. Outputs: Type 3 rows + strengthen and reform `Recovery`; negative ids credited as resources.
- Transaction: remove items, add outputs, log. After commit: Theseus bag / suit pushes (Theseus feature), bag pushes.

No timers, no battles, no pushes to other players.

## 9. Open questions and assumptions

- Assumption: 4260 carries `SmithResolveRspMsg`; the client never reads it.
- Assumption: the server re-validates all client side rules (mixing, eligibility) since 8340 / 8683 carry no item list.
- Open: Theseus bag update opcode after 8684 op 4 (no smith receiver; `EVENT_THESEUS_BAG_UPDATE` is never dispatched in the client, only `EVENT_SUIT_UPDATE`).
- Open: meaning of negative output ids (-19000) in Type 3 rows and Theseus `Recovery` strings.
- Open: treasure decompose gold cost (none in the client).
- Assumption: Avenger and Theseus decompose have no gold cost.

## 10. Implementation checklist

- [ ] Screen: `NewResolveView` with sub tab gates (level 19, deified, royalty level).
- [ ] Screen: `ResolveView1` 12 slots, material preview, gold.
- [ ] Screen: `TreasureResolveView` with outer / inner bag.
- [ ] Screen: `AvengerRosolveView` + `AllResolvePopFrame` batch.
- [ ] Screen: `TheseusRosolveView` + `TreasyreResolvePopFrame` batch.
- [ ] Route R1: 8340 item decompose.
- [ ] Route R2: 8683 `PlayerOpMsg.type = 4`.
- [ ] Route R3: 8657 op 8 `param1` list.
- [ ] Route R4: 8684 op 4 `param1` list.
- [ ] Server message S1: 4260 `SmithResolveRspMsg`.
- [ ] Server message S2: 212 `VirtualBagMsg` bagType 3 after Avenger decompose.
- [ ] Table `smith.resolve_log`.
- [ ] Rule: item outputs by SonType / Profile, bound flag kept, gold 1000 per unit.
- [ ] Rule: treasure outputs + growup refund.
- [ ] Rule: Avenger Type 1 and Theseus Type 3 + Recovery outputs.
- [ ] Rule: mixing restrictions for dual attribute gems and crests.
- [ ] Test: decompose 12 mixed equipment with bound and unbound sources.
- [ ] Test: reject locked or gem inserted equipment server side.
- [ ] Test: Avenger batch string with 20 templates; virtual bag counts updated.
