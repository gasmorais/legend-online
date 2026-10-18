# Rune sockets and rune gems (Runas, Escultura de slot de runa)

Path aliases:

| Alias | File |
|---|---|
| ASOM | `decompiled/core_module/scripts/managers/ArmySocketOutManager.as` |
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| AC | `decompiled/core_module/scripts/mvc/controler/ArmyControler.as` |
| S | `decompiled/m5/scripts/armyII/viewII/stone/` |
| RIV | `decompiled/m5/scripts/armyII/viewII/rune/RuneItemView.as` |
| SF | `decompiled/m5/scripts/armyII/SkillFrame.as` |

## 1. Overview

An extension of [runes.md](runes.md). Each learned rune can open a set of holes ("slots de runa"); each hole has a color ("xing", 1..n); rune gems (items in bag 40, the "Mochila de Runas") of the matching color are socketed into the holes (bag 41). Hole groups from `RuneHoleInfos` grant set effects (`RuneFsgainInfos`) and gem stats (`RuneGemInfos`) are added to the hero (`HeroRuneInfoMsg.baseProperties`). Gems are drawn with rune energy (regenerating) or diamonds, strengthened with "rune chips" (item 10000000), decomposed back into chips, and holes are re-rolled ("esculpir") with item 10010000.

Important: the BR client hides the whole system: `VersionSwitch.RUNE_STONE = false` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:242`). The stone tab only appears when `thane.runeStoneOpen && RUNE_STONE` (SF:161-174) and the socket button needs `RUNE_STONE` (RIV:158, RIV:697). Implement last, or skip unless the switch is enabled.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `S/view/StoneGetView.as` | "Runas" (`runetip.stone.title`, SF:617) | Draw gems: single (energy) and ten (diamonds), energy regen timer "Tempo de recuperação de energia:", "Sorteios de hoje: {0}" | `SkillFrame` stone tab | `StoneLotterInfo` (539), chip count (item 10000000) |
| `S/ArmyShowGetFrame.as` | | Shows drawn items (`items` string) | after a draw (`FUSHI_GET_SHOW`) | items |
| `S/ArmyStoneOpFrame.as` + `S/view/StoneOpView.as` | "Runas" (`army.rune.fuwen`) | Socket gems into one rune's holes, filter by quality ("Todas as runas", "Runas brancas", ... "Runas laranjas") | rune "Slot de runa" button (RIV:222-233, `FUWEN_EQUI`) | rune holes, bag 40, bag 41 |
| `S/ArmyStoneBagFrame.as` + `S/view/StoneBagOPView.as` | "Mochila de Runas" (`army.stone.bagTitle`) | Bag management: buy space, batch decompose, lock, "Volume: {0}" | stone tab bag button (`FUSHI_BAG`) | bag 40, `playerInfo.runeCount` |
| `S/ArmyStoneDKFrame.as` + `S/view/StoneDkView.as` | "Escultura de slot de runa" (`army.stone.dkTite`) | Re-roll the hole set, compare, replace | StoneOpView (`FUSHI_DIAOKE`) | current `rune_hole`, candidate `temp_hole`, item 10010000 count "{0}/{1}" |
| `S/ArmyStoneTipFrame.as` + `S/view/StoneDkTipView.as` | "Aviso"; "Deseja trocar para a seguinte combinação?" | Replace confirmation | dk view | holes |
| `S/ArmyStoneIntensifyFrame.as` + `S/view/StoneIntensifyView.as` | "Fortalecimento de Runa" (`army.stone.upGrade`) | Strengthen one gem with chips: "Quantidade a gastar:", "Possuído no momento: {0}", "Limite de nível: {0}" | gem menu "Elevação" (`FUSHI_INSTENSIFY`) | `strengthenGrade`, `strBlessValue` |
| `S/StonePreFrame.as` + `S/view/StonePreView.as` | "Prévia do conjunto de slots de runas" | Preview of hole groups of length 4 | dk view | `RuneHoleInfos` |
| `S/item/RuneCellMenu.as` | "Decompor", "Elevação", "Travar" | Context menu on a bag gem | bag cell click | |

## 3. Routes (client to server)

### R1. Activate holes of a rune (8605 op 5)
- UI: "Ativar slot de runa" on `RuneItemView` (state 1, RIV:222-227); once active the button reads "Slot de runa" and opens the socket frame (state 2).
- Client path: `ASOM.sendActiveRuneStone(runeId)` (ASOM:200-208): 8605 `U_C_HERO_RUNE_OP`, `HeroRuneOpMsg {user_id, runeId, opType 5}` (field list in [runes.md](runes.md)).
- Response: 4495 with `rune_hole` filled; the client sets `runeStoneOpen` and, on first activation, opens the socket frame (RIV:315-334).

### R2. Engrave holes (8605 op 6)
- UI: engrave button in `StoneDkView` (`S/view/StoneDkView.as:189-244`). Enabled when the player owns >= `runehole_use` (1) of item 10010000 (`:111-127`). Confirms: a pending candidate longer than the current set and >= 4 holes → "Este é um conjunto de slots de runas raro. Deseja esculpir novamente?" (`army.stone.dkTIP`); otherwise a pending candidate → "O slot de runa novo não foi substituído. Deseja seguir esculpindo?" (`stone.dk.tip`, with "Não alertar mais").
- Client path: `ASOM.sendOpStoneRune(runeId, 6)` (ASOM:132-140).
- Response: 4495 with `temp_hole` (candidate); `RUNE_NO_CHANGE` replays the effect.

### R3. Replace holes with the candidate (8605 op 7)
- UI: replace button (`S/view/StoneDkView.as:153-182`). Confirms "Para substituir o slot de runa, é necessário retirar a runa atual. Deseja prosseguir?" (`army.stone.replaceTip2`) or, when the current set is longer, "O conjunto de slots de runas atual é raro. Deseja mesmo substituí-lo?\n(É necessário retirar a runa atual)" (`army.stone.replaceTip1`).
- Client path: `ASOM.sendOpStoneRune(runeId, 7)`.
- Response: 4495 with new `rune_hole`, empty `temp_hole`; socketed gems return to bag 40 (bag pushes).

### R4. Socket, move or unsocket a gem
- Socket from bag (drag bag 40 → hole in bag 41, colors must match, else "O tipo da runa é incompatível." `army.stone.doEquipXing`): `ASOM.sendEquipStone(runeId, holePos, 1, bagPos)` (`S/item/StoneBagCellDropMediator.as:53-62`).
- Move between holes (41 → 41): `sendEquipStone(runeId, targetPos, 2, sourcePos)` (`:64-67`).
- Unsocket (drag a hole gem out, or double click): `ASOM.sendUnEquipStone(runeId, pos)` (`:68-76`, `S/item/StoneBagCellClickMediator.as:49-63`).
- Route socket/move: send 9719 (0x25f7) `C_EQUIP_RUNE_STOME`, `RuneMosReqMsg` (army): `runeId` (#1, INT32) rune template id; `runeIndex` (#2, INT32) target hole index; `runeStoneId` (#3, INT32) mode 1 = from bag 40, 2 = from another hole; `beginPos` (#4, INT32) source position.
- Route unsocket: send 9722 (0x25fa) `C_RUNE_UNLOAD`, `RuneUnloadReqMsg`: `runeId` (#1, INT32), `index` (#2, INT32) hole index.
- Response: bag 40/41 item pushes (inventory) and 4495 with updated `baseProperties` / `newSkillTempId` *(assumption)*.

### R5. Draw gems
- UI: `StoneGetView` (`S/view/StoneGetView.as`): on open and when the regen timer ends `sendGetStone(1)` (`:68`, `:167`); single draw needs `powerPointNum >= runehole_spot_use` (10) else "Energia de runa insuficiente." (`army.rune.pointNo`, `:245-257`); ten draw needs remaining daily count else "Número de sorteios esgotado." (`army.notime.get`), confirm "Deseja gastar {0} diamantes para sortear 10 vezes?" (`stoneGetView.ten.buy`, 498) and enough diamonds else recharge (`:259-285`).
- Route: send 9724 (0x25fc) `C_LOTTERY_RUNE`, `LotteryRuneReqMsg`: `op` (#1, INT32) 1 = query state, 2 = single draw, 3 = ten draw.
- Response: 539 (S1); drawn gems added to bag 40 (bag pushes); then `ArmyShowGetFrame` shows `items`.

### R6. Strengthen a gem
- UI: `StoneIntensifyView` (`S/view/StoneIntensifyView.as:186-190`), amount input capped by owned chips (item 10000000).
- Route: send 9721 (0x25f9) `C_RUNE_UP`, `RuneStoneUpReqMsg`: `pos` (#1, INT32) gem position; `id` (#2, INT32) = -1; `runeNum` (#3, INT32) chips to spend; `bagType` (#4, INT32) 40 or 41; `runeId` (#5, INT32) = -1.
- Response: item update push with new `strengthenGrade` / `strBlessValue` (the view listens to `UPDATE_BAG` and plays the effect, `:169-176`).

### R7. Decompose gems
- UI: menu "Decompor" (single, `S/item/RuneCellMenu.as:98-131`) or batch select in the bag (`S/view/StoneBagOPView.as:323-400`). Quality `Profile >= 4` asks "A runa atual é de qualidade rara. Deseja mesmo decompor?" / "Você selecionou runas de qualidade roxa ou superior. Deseja mesmo decompor?"; empty selection "Você não possui itens que possa decompor".
- Route: send 9720 (0x25f8) `C_RUNE_RESOLVE`, `RuneResolveReqMsg`: `pos` (#1, STRING) CSV of bag 40 positions.
- Response: bag removals and chip (10000000) additions.

### R8. Buy rune bag space
- UI: add button in `StoneBagOPView` (`:240-268`), confirm "Consumir diamantes x{0} para abrir espaços x{1} na Mochila de Runas?" (`stonebagOp.buyBag`, 12 slots for 12 x 20 = 240 diamonds) with bound checkbox.
- Route: send 5010 (0x1392) `U_C_BAG_BUY`, `PayTypeMsg`: `pay_type` (#1) 0 bound allowed / 1 diamonds; `type` (#4) = 1; `property1` (#2) = 1 (ASOM:210-218). *(assumption: type 1 / property1 1 select the rune bag; the inventory feature owns 5010)*.
- Response: 3 `U_C_PLAYER_INFO` with `rune_count` (#165) → `RUNE_COUNT_CHANGE`.

### R9. Lock a gem
`BagHelper.vpLockBtnClickHandler` (inventory item lock), blocked during batch decompose ("Não se pode trancar runas sob o status de decomposição em lote.").

## 4. Server messages (server to client)

### S1. 539 (0x021b) `U_C_LOTTERY_RUNE_INFO`
- `LotteryRuneRspMsg` (army): `powerPointNum` (#1, INT32) current energy; `runeChipNum` (#2, INT32); `runePointNum` (#3, INT32) energy bar value (capped by `runehole_spot` max 100 for the effect); `leftTime` (#4, INT32) seconds to next regen tick; `tenSpotCount` (#5, INT32, optional) ten draws used today; `items` (#6, STRING, optional) drawn items `"tid,count|tid,count"` (parsed in `S/ArmyShowGetFrame.as:89-124`).
- Receiver: `AM._runeGetStoneHandler` (AM:190-209) → `thane.runeCate.stoneLotterInfo`, dispatches `STONE_GET_CHANGE`.

### S2. 4495 `U_C_RUNE_OP`
For ops 5..7, as in [runes.md](runes.md) S1; `HeroRuneInfoMsg.rune_hole` (#4) and `temp_hole` (#5) use the format `"<holeGroupIds CSV>|<hole colors CSV>"`, e.g. `"1000003,1000001|3,1,1"`: group ids index `RuneHoleInfos.Id`, each group covers `Length` consecutive holes; colors give the accepted gem `Property1` per hole (`S/item/StoneGroupItem.as:109-160`).

### S3. 541 (0x021d) `U_C_TRIGGER_SKILL`
- `TriggerSkillListMsg` (battle): `skills` (#1, `TriggerSkillMsg`, repeated): `templated_id` (#1, INT32), `cool_down` (#2, INT32), `appear_cool_down` (#3, INT32).
- Receiver: `AM._stoneTriggerSkill` (AM:181-188) stores the list and dispatches `BATTLE_STONETRIGGER`; the battle HUD lets the player fire them with 10523 `B_USE_STONETRRIGERSKILL` (`UseSkillMsg {battle_id, hero_id, skill_id}`, `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:583-590`). Battle side in [../battle/README.md](../battle/README.md).

### S4. 3 `U_C_PLAYER_INFO` fields
`rune_count` (#165, INT32) purchased bag slots; `runePowerPoint` (#166, INT32) (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1219`).

## 5. Rules and formulas

From `ConfigInfos.xml`:
- `runehole_bag` = `12,120`: 12 default slots, 120 max; `runehole_bag_buy` = `12,20`: 12 slots per purchase at 20 diamonds each.
- `runehole_spot` = `10,45,100`: +10 energy every 45 minutes, natural cap 100; `runehole_spot_use` = 10 per single draw.
- `runehole_tenspot_use` = `1,498`: 1 ten draw per day, 498 diamonds.
- `runehole_special_add` = 3: special bonus per draw *(meaning unclear)*.
- `runehole_use` = 1 engraving item (10010000) per engrave.
- `runehole_random` = `1,200|2,300|3,400|4,100`: hole color weights; `runehole_length` = `1,100|2,500|3,350|4,50`: set length weights.
- `runehole_decompose` = 80: decompose returns 80% of materials; `runehole_grade_gold` = 0: no gold cost for strengthening.
- Equipped gem position in bag 41: `(RuneType - 1) * 10 + holeIndex` (`S/item/StoneGroupItem.as:124`).
- Strengthen: `RuneGemInfos` row by (`Types` = gem SonType, `RuneGemTypes` = `Property1`, `Grades`) gives stats; bless progress `strBlessValue` vs next row `Data` (`S/view/StoneIntensifyView.as:232-298`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `RuneHoleInfos.xml` | hole group (133 rows) | `Id`, `Length` (holes covered), `Hole1..Hole5` (colors), `GainEffectID1/2` (→ `RuneFsgainInfos`), `BanRuneType`, `Random` (weight), `ExtractTags`, `Description` |
| `RuneFsgainInfos.xml` | set effect (179 rows) | `Condition`, `ConditionParam` (activation), `EffectType`, `AttributeType`, `ValueType`, `ValueParam`, `NewRuneSkill` (replacement rune skill), `RuneType` (restriction CSV) |
| `RuneGemInfos.xml` | gem level stats (375 rows) | `Types`, `RuneGemTypes`, `Grades`, `Power`, `Agility`, `Intellect`, `Physique`, `Captain` |
| `ItemTempInfos.xml` | gems (bag 40), 10000000 chips, 10010000 engraving | `Property1` (color), `Profile` (quality), `Refresh` (strengthen material id) |
| `ConfigInfos.xml` | `runehole_*` | see section 5 |

## 7. Persistent state

```sql
CREATE TABLE skills.rune_gem_profile (
    player_id             BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    energy                INTEGER NOT NULL DEFAULT 100 CHECK (energy >= 0),
    energy_updated_at     TIMESTAMPTZ NOT NULL DEFAULT now(),
    ten_draws_today       SMALLINT NOT NULL DEFAULT 0,
    ten_draws_date        DATE,
    bag_extra_slots       SMALLINT NOT NULL DEFAULT 0 CHECK (bag_extra_slots BETWEEN 0 AND 108)
);

CREATE TABLE skills.rune_gem_sockets (
    player_id    BIGINT   NOT NULL,
    rune_type    SMALLINT NOT NULL,
    hole_index   SMALLINT NOT NULL CHECK (hole_index BETWEEN 0 AND 9),
    item_id      BIGINT   NOT NULL UNIQUE,
    PRIMARY KEY (player_id, rune_type, hole_index),
    FOREIGN KEY (player_id, rune_type) REFERENCES skills.runes(player_id, rune_type) ON DELETE CASCADE
);
```

Hole layouts live in `skills.runes.hole_layout` / `pending_hole_layout` ([runes.md](runes.md)). Gems are rows of `inventory.items` (bag types 40 and 41) with `strengthen_grade` and `bless_value` *(assumption: inventory feature schema)*.

## 8. Backend implementation notes

- `skills::rune_stones::handle_activate_holes` (8605 op 5): roll a hole set with `runehole_length` then `RuneHoleInfos` weights; save; reply 4495.
- `skills::rune_stones::handle_engrave` (op 6): consume 1 x 10010000; roll into `pending_hole_layout`; reply 4495.
- `skills::rune_stones::handle_replace_holes` (op 7): move socketed gems back to bag 40 (needs free space), swap layouts, recompute stats; reply 4495 and bag pushes.
- `skills::rune_stones::handle_socket` (9719) / `handle_unsocket` (9722): validate color, ownership, positions; move items between bags 40/41; recompute `baseProperties` and `newSkillTempId` from active `RuneFsgainInfos`; reply 4495 and bag pushes; hero stats refresh (113).
- `skills::rune_stones::handle_lottery` (9724): regen energy lazily (`+10 / 45 min`, cap 100), op 2 costs 10 energy, op 3 costs 498 diamonds and 1 daily use; roll gems; reply 539 with `items`, bag pushes.
- `skills::rune_stones::handle_strengthen` (9721): consume chips, add bless value, level up per `RuneGemInfos`; item push.
- `skills::rune_stones::handle_decompose` (9720): delete gems, return 80% chips; pushes.
- Battle: send 541 with trigger skills of the hero before battle; handle 10523 in the battle engine.

## 9. Open questions and assumptions

- The system is disabled in BR (`RUNE_STONE = false`); all behavior is inferred from the client and templates.
- Assumption: the 5010 rune bag selector (`type 1`, `property1 1`).
- Open: exact gem drop table for draws (no template in `raw/xml/tempinfos` names it).
- Open: meaning of `runehole_special_add`, `runeChipNum` and `runePointNum` versus `powerPointNum`.

## 10. Implementation checklist

- [ ] Screens: StoneGetView, StoneOpView, StoneBagOPView, StoneDkView, StoneIntensifyView, StonePreView
- [ ] Route 8605 op 5 activate holes
- [ ] Route 8605 op 6 engrave
- [ ] Route 8605 op 7 replace
- [ ] Route 9719 socket/move
- [ ] Route 9722 unsocket
- [ ] Route 9724 draw (ops 1..3)
- [ ] Route 9721 strengthen
- [ ] Route 9720 decompose
- [ ] Route 5010 rune bag purchase
- [ ] Server message 539
- [ ] Server message 4495 hole fields
- [ ] Server message 541 and battle 10523
- [ ] Server message 3 `rune_count`
- [ ] Table `skills.rune_gem_profile`
- [ ] Table `skills.rune_gem_sockets`
- [ ] Rules: energy regen, daily ten draw, weights, decompose ratio
- [ ] Test: full loop draw → socket → set effect → replace holes
