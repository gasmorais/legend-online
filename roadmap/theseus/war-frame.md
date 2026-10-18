# Theseus: Fortalecimento de Armadura (armor strengthen, quality, decompose)

Module `war-frame`. Upgrades of Theseus armor pieces (client package `theseus/warFrame`): strengthen level (8684 op 5) and quality grade (8684 op 6) in the frame "Fortalecimento de Armadura", plus decomposition of pieces (8684 op 4) from the smith's resolve screen. Bag, equip and suits are in [equipment-suits.md](equipment-suits.md).

Path aliases:

| Alias | File |
|---|---|
| MGR | `decompiled/core_module/scripts/managers/TheseussoulManager.as` |
| MOD | `decompiled/core_module/scripts/mvc/module/theseus/TheseussoulModel.as` |
| WFI | `decompiled/core_module/scripts/mvc/module/theseus/WarFrameItemInfo.as` |
| WF | `decompiled/m5/scripts/theseus/warFrame` |
| T | `decompiled/m5/scripts/theseus` |
| RV | `decompiled/m14/scripts/store/TheseusRosolveView.as` |
| CM | `decompiled/core_module/scripts` |

---

## 1. Overview

- Only pieces at max synthesis level (`Property6 == 1`, e.g. "Bracelete Celeste Nv.20") can enter the upgrade frame: tips "Nível não está no máximo, não é possível prosseguir." (`theseus.equip.QHtips`) and "Requer nível máximo de síntese" (`theseus.equip.QHtips1`, `WF/WarframeEnhancementFrame.as:125`).
- Strengthen: +1 level per request, up to the current quality's `StrengthenLimit` (100/200/300/400). Cost per level from `TheseusEquipStrengthenTmpls.xml` (material 7450001 "Pedra de Temperamento Divino" + "Gema Poseidon" -19000).
- Quality ("Qualidade", names `theseus.war.gz0..6`: [Não reformado], [Normal], [Avançado], [Requintado], [Magnífico], [Perfeito], [Celestial]): +1 grade per request, from the item `Profile` (3) up to the last row of `TheseusEquipQualityTmpls.xml` (6). Raises `StrengthenLimit` ("Limite de nível de Fortalecimento {0}") and adds flat attributes. Cost: material 7460003 "Pedra Divina Impecável" (+ Gema Poseidon, 0 in data).
- Decompose: in the smith resolve screen (tab enabled when royalty level > 0, `decompiled/m14/scripts/store/NewResolveView.as:80`), the player chooses up to 4 pieces or an "all" filter; the server deletes them and returns `ItemResolveTemplates` Type 3 items plus the recovery of strengthen and quality costs.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `WF/WarframeEnhancementFrame.as` | "Fortalecimento de Armadura" (`theseus.warFrame.intensifyTitle`, `:87`) | Frame 760x536 with two tabs (strengthen `_qhBtn`, quality `_gzBtn`, `:108-111`), shared bag `WarFrameBag`, Gema Poseidon balance (`:128-134`), "Dividir" button (no effect here, §9) | Armor upgrade button on the equip tab, controller openType 8 with `backTheseFrame` (`T/view/ThereussoulEquipView.as:299-303`) | |
| `WF/view/WarFrameBag.as` | "Equipar" / material title | Left: pieces (`TheseusWarframeBagView`, only SonType 720, `WF/view/TheseusWarframeBagView.as:92-120`); right: materials of the tab (`:295-316`): tab 5 SonType 750 with `Property7 == 1` ("Material de Fortalecimento"), tab 6 SonType 751 with `Property7` 3 or 4 ("Material para Aumento") | frame | Theseus bag entries |
| `WF/view/WarframeEnhancementView.as` | tab strengthen | Source cell, material cell, preview cell "Prévia", cost, button, max banner "Limite de fortalecimento atingido" / "(Aumentar a Qualidade da Armadura pode aumentar o limite)" | tab 1 | name "+strengthen" colored by quality (`:193-197`); material and Poseidon cost from the current strengthen row (`:174-192`) |
| `WF/view/WarframeTransformationView.as` | tab quality | Source cell, up to 3 material cells, current and next quality names, current and next `StrengthenLimit`, current and next 5 attributes, cost, max banner "Limite de Aumento atingido" (`theseus.warframe.gzFull`) | tab 2 | `:307-435` |
| `RV` (`TheseusRosolveView`) inside `NewResolveView` | smith resolve tab "Teseu" | Decompose pieces: 4 selection slots, 12 preview material slots, buttons decompose / all / cancel | smith resolve screen, tab enabled with royalty > 0 | preview = resolve template items + recovery strings (`RV:308-430`) |
| `decompiled/m14/scripts/store/TheseusStoreBag.as` | | Lists unequipped pieces with `Property2 != 2` and materials (`:262-283`) | `RV` | |

## 3. Routes (client to server)

Opcode 8684 (0x21ec) `C_THESEUS_WARFRAMECLIENT_OP`, `player.PlayerOpMsg`, sender `TheseussoulManager.doWarFrameParam` (`MGR:980-993`): `op` (#1, INT32), `id` (#5, INT32), `pos` (#19, INT32, 0 here), `param1` (#15, STRING).

### R1. Strengthen a piece (+1)

- UI: put a piece in the source cell (double click `T/mediator/TheseusBagCellClickMediator.as:55-59` or drop on `WarframeQhCell` `T/mediator/TheseusBagCellDropMediator.as:51-63`, both require `Property6 == 1`), then the strengthen button (`WF/view/WarframeEnhancementView.as:147-153`).
- Client checks (`:164-215`): button enabled only if the material cell is satisfied and `poseidonCoin.amount >= cost`; when `strengthen + 1 > quality.StrengthenLimit` the max banner replaces the button.
- Request: `op` 5, `id` = piece id, `pos` 0, `param1` "".
- Response: 4323 op 5 with the upgraded piece (and the remaining stack if a unit was split), consumed material stacks; the client then reselects the item with `strengthen + 1` and same template, quality and equip state (`:126-145`); 4300 if the piece is equipped; currency push for Gema Poseidon *(see [../currency/README.md](../currency/README.md))*.

### R2. Raise quality (+1)

- UI: quality tab, source cell, button `_gz4Btn` (`WF/view/WarframeTransformationView.as:282-296`).
- Client checks (`:361-391`): every material of `quality.Cost` must be enough; currency check is inverted (`enable = poseidonCoin.amount < cost`, `:369`, harmless because all costs are 0 in data); hidden when no next quality row (`:414-434`). No confirmation (the alert text is built but unused, `:288-289`).
- Request: `op` 6, `id` = piece id.
- Response: 4323 op 6 with the piece (`quality + 1`), consumed materials; client reselects the item with `quality + 1` (`:232-251`); 4300 if equipped.

### R3. Decompose pieces

- UI: smith resolve tab "Teseu" (`RV`):
  - manual: double click or drag up to 4 pieces into the selection (`decompiled/m14/scripts/store/resolve/TheseusStoreItemCell.as:251-275`); each selected piece counts 1 unit (`MOD.moveBagToResolve`, `MOD:231-242`);
  - all: popup `TreasyreResolvePopFrame` picks a max level and optional suit; every unequipped, unlocked piece with `Property4 <= level` (and `Property1 == suit` when set) is added with its full count (`TheseusStoreItemCell.as:285-338`, `MOD:252-275`).
- Client checks: locked pieces refused "Não é possível Decompor equipamento bloqueado" (`MOD:233-237`); confirm "Deseja decompor os itens acima?" (`theseusoul.store.resolveToday`, `RV:231-233`, remembered by `SharedManagerHelper`) or, in all mode, "Deseja decompor o equipamento ... na mochila? (Equipamentos bloqueados não serão decompostos)" (`RV:222-229`).
- Request (`RV:247-250`): `op` 4, `id` 0, `pos` 0, `param1` = "id,count|id,count|..." (trailing "|", `RV:337, 399`).
- Response: 4323 op 4 with the decomposed entries (`count` 0 deletes, positive count updates, `MGR:705-715`) and the returned material stacks; inventory pushes for normal items (Gema Poseidon via currency).

## 4. Server messages (server to client)

- 4323 (0x10e3) `U_C_THESEUS_EQUIP_DATA`, `theseus.TheseusEquipListMsg`: full field list in [equipment-suits.md](equipment-suits.md) S1. For op 5 and 6 the handler dispatches `OP_WarEQUIP_STRENGTHENSTR` with the op (`MGR:723-730`); receivers `WarframeEnhancementView.updateHandler` (`WF/view/WarframeEnhancementView.as:126-133`, op 5) and `WarframeTransformationView.updateHandler` (`:244-251`, op 6). For op 4 entries with `count <= 0` are deleted (`MGR:705-711`); `RV` listens to `EVENT_SUIT_UPDATE` and resets its selection (`RV:139, 210-215`).
- 4300 `U_C_THESEUS_PROPERTY_DATA` after upgrades of equipped pieces ([soul.md](soul.md) S2).
- No result code: failures send nothing *(assumption)*.

## 5. Rules and formulas

- Eligibility: `SonType 720`, `Property6 == 1`, piece in the Theseus bag or equipped (both lists come from `MOD.itemSort`, which includes equipped pieces, `WF/view/TheseusWarframeBagView.as:87-90`).
- Strengthen row: `TheseusEquipStrengthenTmpls` where `Type = Property3` (part 0..9) and `Strengthen = current level` (`CM/yishi/manager/TheseusEquipStrengthenTmpl.as:35-45`, `WFI:99-104`). Levels 0..400 per part.
  - Cost to go from L to L+1 = row(L).`Cost` = "7450001,n|-19000,m" (material, Gema Poseidon). Example Type 0: 349 stones + 3490 Gema Poseidon per level.
  - Attributes at level L = row(L).`Attr` "1,a|2,b|3,c|4,d|5,e" (1 Attack, 2 Defence, 3 MagicAttack, 4 MagicDefence, 5 Live).
  - `Recovery` = cumulative refund on decompose; `Fraction` adds to the armor value; `CountFraction` is the red dot score.
  - Cap: `L + 1 <= quality(Q).StrengthenLimit` (`WF/view/WarframeEnhancementView.as:198-208`).
- Quality row: `TheseusEquipQualityTmpls` where `TemplateId = item template` and `Quality = Q` (`CM/yishi/manager/TheseusEquipQualityTmpl.as:35-45`). 908 templates x 4 grades (3..6).
  - Cost to go from Q to Q+1 = row(Q).`Cost` = "7460003,n|-19000,0" (last pair is the currency); empty `Cost` and no row Q+1 = max.
  - Row(Q).`Attr` flat bonus, `StrengthenLimit` 100/200/300/400, `Recovery` cumulative refund, `Fraction`, `CountFraction`.
- Success rate: always 100% (no probability field) *(assumption)*.
- Decompose return per unit = `ItemResolveTemplates` Type 3 row of the template (Item1..4 x Count1..4, e.g. 7211001 gives 50 Gema Poseidon) + strengthen row `Recovery` + quality row `Recovery` (`RV:339-385`).
- Decompose filters: unequipped, unlocked; the store bag hides pieces with `Property2 == 2` (`TheseusStoreBag.as:271-273`) *(assumption: group 2 pieces cannot be decomposed; server should enforce the same filter)*.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/TheseusEquipStrengthenTmpls.xml` (4010 rows) | strengthen level per part | `Id`, `Type` part 0..9, `Strengthen` 0..400, `Attr`, `Cost`, `Recovery`, `Fraction`, `CountFraction` |
| `raw/xml/tempinfos/TheseusEquipQualityTmpls.xml` (3632 rows) | quality grade per piece template | `Id`, `TemplateId`, `Quality` 3..6, `StrengthenLimit`, `Attr`, `Cost`, `Recovery`, `Fraction`, `CountFraction` |
| `raw/xml/tempinfos/ItemResolveTemplates.xml` | decompose result | `Type` 3, `ResolvedItem`, `Item1..4`, `Count1..4` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | materials | 7450001 (SonType 750, `Property7` 1), 7460003 (SonType 751, `Property7` 4); currency -19000 "Gema Poseidon" |

## 7. Persistent state

Uses `theseus.armor_items.strengthen_level` and `quality` ([equipment-suits.md](equipment-suits.md) §7). No new table. Optional audit:

```sql
CREATE TABLE theseus.armor_upgrade_log (
    log_id       bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    player_id    bigint NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    item_id      integer,
    action       smallint NOT NULL CHECK (action IN (4, 5, 6)),   -- decompose, strengthen, quality
    before_value smallint,
    after_value  smallint,
    created_at   timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX armor_upgrade_log_player_idx ON theseus.armor_upgrade_log (player_id, created_at);
```

## 8. Backend implementation notes

- `theseus::war_frame::handle_strengthen` (8684 op 5), validation order:
  1. piece exists, owned, `item_kind = 1`, template `Property6 = 1`;
  2. next level `L + 1 <= quality.StrengthenLimit`;
  3. strengthen row(L) exists; enough material (Theseus bag stack 7450001) and Gema Poseidon;
  4. transaction: split one unit if `quantity > 1` (new row keeps the old values), consume costs, `strengthen_level + 1`;
  5. push 4323 op 5 (piece, split rest, material stack), currency update, 4300 if equipped.
- `theseus::war_frame::handle_quality_up` (op 6): same pattern with quality rows; reject when row Q+1 is missing.
- `theseus::war_frame::handle_decompose` (op 4):
  1. parse `param1` "id,count|..." (ignore empty tokens); reject duplicates, counts <= 0, counts > quantity;
  2. each piece: owned, unequipped, unlocked, `item_kind = 1`, `Property2 != 2` *(assumption)*;
  3. transaction: decrement or delete rows, grant returns (Theseus materials into `armor_items`, other items to the inventory, Gema Poseidon to currency);
  4. push 4323 op 4 with deleted (`count` 0) and updated rows, inventory and currency pushes.
- No timers, no battles.

## 9. Open questions and assumptions

1. Whether strengthen/quality create a new id (stack split) or keep the id: the client handles both by searching the bag for the upgraded copy (`WarframeEnhancementView.as:135-145`, `WarframeTransformationView.as:232-242`).
2. The "Dividir" (split) button of the frame drops only on war soul cells (`T/war/utils/TheseusWarBitPool.as:58-81`), so it does nothing in this frame.
3. Quality tab currency check is inverted on the client (`:369`); server must check `amount >= cost` normally.
4. The `Property2 != 2` decompose filter meaning is unclear.
5. No failure chance exists for either upgrade.

## 10. Implementation checklist

- [ ] Screen `WarframeEnhancementFrame` with strengthen and quality tabs and material bag.
- [ ] Screen `TheseusRosolveView` in the smith resolve tab (royalty > 0).
- [ ] Route 8684 op 5 strengthen.
- [ ] Route 8684 op 6 quality.
- [ ] Route 8684 op 4 decompose with `param1` parsing.
- [ ] Server message 4323 for ops 4, 5, 6 (+ 4300 when equipped).
- [ ] Templates loader: strengthen rows by (part, level), quality rows by (template, quality), resolve Type 3.
- [ ] Rule: strengthen cap = quality `StrengthenLimit`.
- [ ] Rule: decompose return = resolve template + recoveries.
- [ ] Test: strengthen at the cap is rejected; quality up raises the cap.
- [ ] Test: decompose of a locked or equipped piece is rejected.
- [ ] Test: decompose of a +100 piece refunds 34900 stones (Type 0 Recovery at 100).
