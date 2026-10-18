# Smith: refine (random attribute refresh, "Purificação")

Scope: the "Purificar" panel of the smith store tab (`RefreshView`) and the treasure "Fundição" panel (`TreasureRefreshView`). Both re-roll the up to 5 random skills (`random_skill_1..5`) of the item placed in the hidden smith slot 0, show the candidate result, and let the player replace or keep. Frame shell, smith bags and the placement of items into hidden slot 0 (5005 `U_C_BAG_MOVE`) are in [store-frame.md](./store-frame.md).

Path aliases:

| Alias | File |
|---|---|
| SSOM | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StoreControler.as` |
| SV1 | `decompiled/m14/scripts/store/StoreView1.as` |
| RV | `decompiled/m14/scripts/store/refresh/RefreshView.as` |
| RAI | `decompiled/m14/scripts/store/refresh/RefreshAttriItem.as` |
| RNMI | `decompiled/m14/scripts/store/refresh/RefreshNeededMaterialItem.as` |
| TRV | `decompiled/m14/scripts/store/treasure/TreasureRefreshView.as` |
| TRAI | `decompiled/m14/scripts/store/treasure/TreasureRefreshAttriItem.as` |
| TSB | `decompiled/m14/scripts/store/treasure/TreasureStoreBag.as` |
| SB2 | `decompiled/m14/scripts/store/StoreBagII.as` |
| SBCM | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellClickMediator.as` |

## 1. Overview

- Equipment refine ("Purificar"): the equipment (MasterType 1, `Refresh != 0`) is placed in hidden slot 0. Each refine consumes refine stones (template = equipment `Refresh` field) and optionally diamonds (auto buy of missing stones, locks beyond the owned "Cadeado da Purificação" 208027). The server rolls new values for every unlocked random skill slot and keeps them pending; the player either presses "replace" (8339) to apply them or ignores them (keep).
- Locks: each of the 5 attribute rows has a lock checkbox; locked rows are kept by the roll. Lock count must be lower than the number of rolled rows.
- Treasure refine ("Fundição", royalty feature): same protocol for treasures (MasterType 11) with treasure stones only (no diamonds), lock cost scaling with `theseus_treasure_melting_const`.
- On placing / updating the item the client asks the server for a pending, not yet replaced result (8464) so it survives frame reopen.
- The same opcodes are reused by the Einherjar equipment refinery (`decompiled/m14/scripts/pet/equipstore/PetEquipRefineryView.as:237-259,552,650,670,740`) and the guardian equipment refresh (`decompiled/m14/scripts/child/equip/ChildRefreshEquipView.as:178-197,402`): see [../einherjar/README.md](../einherjar/README.md) and [../guardians/README.md](../guardians/README.md). The server must resolve the target item from the context (smith hidden slot 0 here).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `RV` (`store.RefreshView`) | tab "Purificar" in `SV1` | Equipment refine | `SV1.__onTabBtnHandler` case `_refreshBtn` (`SV1:224-227`); tab enabled at level >= 19 (`SV1:111`), click tip "Função habilitada no Nv. {0}" (`SV1:260-265`); default panel `STORE_PANEL_REFRESH` | equipment slot (hidden slot 0, key "0_0_0", `RV:194-195`); 5 `RAI` rows (current / new value + lock); material `RNMI` "owned/needed"; checkbox "Compra Automática" (`_pointBuy`); checkbox "Usar material vinculado" (`_bindingBut`, default checked, `RV:156`); "Travados:" + count of 208027 owned (`RV:173-182`); diamond cost (`_refreshPointTxt`); buttons refresh (tip "Ao purificar, irá aleatoriamente aumentar o nível de estrelas de purificação\nAo completar as estrelas, irá aleatoriamente purificar cada tipo de atributo.") and replace |
| `RAI` | | One random skill row | `RV` | `TemplateName + "({0} Estrelas)"` or `"({0}Esterlas Máx.)"` when `Parameter3 > 0` (`RAI:63-125`); lock checkbox |
| `RNMI` | | Material cell | `RV` | stone icon, "owned/needed" (`RNMI:46-65`) |
| `TRV` (`store.RefreshView.treasure`) | tab treasure refine in `SV1` | Treasure refine | `SV1` case `_treasureRefreshBtn` (`SV1:237-241`); visible when `royaltyLevel > 0` and `VersionSwitch.TREASURE` (`SV1:120`) | treasure slot, 5 `TRAI` rows, stone "owned/needed", own `TSB` bag (`TRV:76-123`) |
| `TRAI` | | Treasure row with lock | `TRV` | same as `RAI`; first lock asks "Os atributos bloqueados durante a fundição serão mantidos, mas cada fundição consumirá Pedras de Fundição adicionais. Quer mesmo bloquear?" (`TRAI:117-145`) |
| `decompiled/m14/scripts/store/StoreFrame.as:305` | | Legacy frame instance of `RefreshView` | legacy | same |

## 3. Routes (client to server)

### R1. Query pending refine result

- Trigger (automatic): every `UPDATE_BAG` of the item in hidden slot 0 (placement, after refine, after replace) (`RV:343-354`, `TRV:182-193`).
- Client path: `SSOM.sendRefreshProperty(item.id)` (`SSOM:159-165`).
- Route: send 8464 (0x2110) `C_ITEM_REFRESHPROPERTY`, `RefreshPropertyReqMsg`:
  - item_id (#1, INT32): item instance id (`GoodsInfo.id`).
- Response: 4368 `U_C_ITEM_REFRESHPROPERTY` (S2).

### R2. Refine equipment

- UI: refresh button (`RV:206`, `RV:509-519`).
- Client checks, in order:
  1. Button enabled only when an item is placed and (owned stones >= needed, or auto buy checked and the stone is sold in the shop) (`RV:710-725`).
  2. Item locked (`isLock`) -> "Os items bloqueados não podem ser purificados, por favor desbloqueie o equipamento" (`RV:512-517`).
  3. `lockCount >= lockOverflow` -> "Não há atributo a ser purificado" (`RV:536-541`). `lockOverflow` = `min(Profile, 5)` for vice equipment, else number of non zero random skills (`RV:641-666`).
  4. If any new (unreplaced) row shows "9 Estrelas" or "10 Estrelas" and is not locked -> confirm "Existe um atributo estrelar que não foi trocado, poderá desaparecer se continuar a purificar, deseja continuar?" (`RV:555-581`, `RV:612-626`).
  5. If diamond cost `_allNeedPoint > 0` -> "do not ask again" alert "Materiais insuficientes, deseja consumir {0} diamantes para purificar?" with bound first option; then `allPoint` (bound first) or `point` must cover the cost, else recharge alert (`RV:585-610`).
  6. Auto buy checkbox: requires an item ("Por favor, insira primeiro o equipamento que é preciso purificar.") and a shop entry ("Este item não pode ser comprado diretamente."); first use per day asks "Quando pedra de purificação for insuficiente, irá comprar automaticamente as pedras que faltam, confirmar?" (`RV:245-307`).
  7. First lock click asks "Ao purificar, os atributos travados serão mantidos, porém consumirão diamantes por purificação. Travar?" (`RAI:137-181`).
- Client path: `SSOM.sendRefreshforRandom(lockArray, bindingType, useBindPoint)` (`SSOM:131-143`), called from `RV:597` or `RV:609`.
- Route: send 8336 (0x2090) `C_ITEM_REFRESHFORRANDOM`, `SmithFreshReqMsg`:

| Field | Value / meaning |
|---|---|
| lock (#1, BOOL, repeated) | 5 entries, true = keep row i (random_skill_{i+1}) |
| bind_type (#2, INT32) | 0 = "Usar material vinculado" checked (bound and unbound stones), 2 = unbound stones only (`RV:535`) |
| pay_type (#3, INT32) | never set by the client (0) |
| material_pay_type (#4, INT32) | 0 = bound diamonds first (default and when the alert option is checked), 1 = diamonds only (`SSOM:137-141`) |

- Auto buy itself is not a flag: the server must buy missing stones whenever owned stones are short and diamonds are enough (the client only sends when either stones suffice or the player accepted the diamond cost).
- Response: bag pushes (stones, 208027 locks, diamonds), 115 `U_C_BAG_MOVE_UPDATE` (lock item count, `RV:212`, `RV:221-226`), then 4258 `U_C_REFRESHFORRANDOM` (S1).

### R3. Refine treasure

- UI: refresh button of `TRV` (`TRV:127`, `TRV:291-320`).
- Client checks: owned treasure stones >= needed (`TRV:356-367`); `lockOverflow > 0 && lockCount >= lockOverflow` -> "Não há atributo a ser purificado" (`TRV:300-305`); first lock confirm (`TRAI:117-133`). No diamond path.
- Client path: `SSOM.sendRefreshforRandom(lockArray, 0, true)` (`TRV:319`).
- Route: 8336 `SmithFreshReqMsg` with `lock` x5, `bind_type = 0`, `material_pay_type = 0`.
- Response: as R2.

### R4. Replace (apply pending result)

- UI: replace button, enabled only after a 4258 or a 4368 with `result == 1` (`RV:395`, `RV:414`, `RV:668-671`; `TRV:341-344`).
- Route: send 8339 (0x2093) `C_ITEM_REFRESHFORREPLACE`, no body (`SSOM:167-171`).
- Response: item update push of the hidden slot item with the new random skills (client resets rows on `UPDATE_BAG`, `RV:368-381`, and re-sends R1), then 4259 `U_C_REFRESHFORREPLACE` (S3).

### R5. Keep

- No route: keeping the current values means not pressing replace. The pending result stays on the server until replaced or overwritten by the next refine (Assumption), and is shown again through R1 / S2.

## 4. Server messages (server to client)

### S1. 4258 (0x10a2) `U_C_REFRESHFORRANDOM`, `SmithFreshRspMsg`

- randomSkill (#1, INT32, repeated): 5 new candidate skill template ids (`SkillTempInfos.TemplateId`), locked rows repeat the current value, empty slots 0.
- Receiver: `RV.__refreshSkillHandler` (`RV:383-397`), `TRV.__refreshSkillHandler` (`TRV:222-236`): fills the "new" column and enables replace.
- When: response to 8336 on success. On failure the server should not send 4258 and should send a message tip (Assumption; the client has no error code).

### S2. 4368 (0x1110) `U_C_ITEM_REFRESHPROPERTY`, `RefreshPropertyRepMsg`

| Field | Meaning |
|---|---|
| randomSkill (#1, INT32, repeated) | 5 pending candidate skill ids |
| lockPos (#2, BOOL, repeated) | 5 lock flags used for the pending roll |
| result (#3, INT32) | 1 = a pending result exists for this item, other = none |

- Receiver: `RV.__refreshProperty` (`RV:399-422`), `TRV.__refreshProperty` (`TRV:238-261`): when 1, shows candidates, restores lock checkboxes, enables replace; else disables replace.
- When: response to 8464.

### S3. 4259 (0x10a3) `U_C_REFRESHFORREPLACE`, `SmithFreshReplaceRspMsg`

- result (#1, BOOL): true when applied.
- Receiver: none in the client. Send after the item update push for protocol completeness.

### S4. 115 (0x0073) `U_C_BAG_MOVE_UPDATE`

- Owned by inventory ([../inventory/README.md](../inventory/README.md)); `RV.__bagUpdateHandler` only re-reads the count of 208027 (`RV:221-226`). Item update and resource pushes as described in [store-frame.md](./store-frame.md).

## 5. Rules and formulas

### Eligibility
- Store bag shows for the refine panel: SonType 215, equipment with `Refresh != 0`, and the lock item 208027 (`SB2:794-808`). Double click accepts only MasterType 1 ("Tipo de equipamento incorrespondente", `SBCM:124-129`).
- Treasure panel accepts only MasterType 11 ("O tipo de tesouro não corresponde", `SBCM:226-235`).
- Locked items cannot be refined (`RV:512-517`).
- Random skill slots: `random_skill_1..5` of the item (`SimpleItemInfoMsg` #22..#26); the number of active slots per template is `ItemTempInfos.RandomSkillCount` (Assumption: the server limits rolls to that count).

### Equipment refine cost (`RV:424-501`, `RV:683-708`)
- Stone template = equipment `Refresh` (for example 2127004 "Pedra da Purificação nv. 4", 2127006 "Pedra da Essência da Purificação", 2127007 "Pedra da Purificação Divina").
- Stones needed per refine by equipment `Profile`: 1 or 2 -> 1; 3 -> 4; 4 or 5 -> 18; 6 -> 24; 7 -> 48.
- Owned = bound + unbound stones when `bind_type = 0`, unbound only when `bind_type = 2`.
- Auto buy price = `ShopTempInfo.GiftToken * (needed - owned)` diamonds (example: 2127004 costs 2).
- Lock cost: `Lock_Point = 10` diamonds per lock (`ConfigInfos.xml`, `RV:201`); with `VersionSwitch.REFRESH_LOCK` each owned 208027 "Cadeado da Purificação" covers one lock: diamonds = `max(0, locks - owned208027) * 10` (`RV:683-708`). Assumption: the server consumes `min(locks, owned208027)` lock items.
- Total diamonds = auto buy price (if checked) + lock diamonds.
- Display: star level from the skill template `Grades`; "Máx." when `Parameter3 > 0` (`RAI:63-125`). Rows at 9 or 10 stars trigger the overwrite confirm.

### Treasure refine cost (`TRV:263-289`)
- Stone template = treasure `Refresh` (2127021 "Pedra de Dissolução do Tesouro Externo" or 2127025 "... Interno", `decompiled/core_module/scripts/mvc/module/store/StoreModel.as:185-187`).
- Needed = `Property6 + Property3 * meltingConst[locks - 1]` (no extra when 0 locks), `meltingConst = theseus_treasure_melting_const` or default [1, 2, 4, 8] (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:1883-1890`; the key is absent from `ConfigInfos.xml`).
- Owned counts bags 1 and 34 (`GoodsManager.getBagCountInPlayerAndStoneByTempId`).

### Roll
- Unlocked active slots get new skill ids; star progression: "Ao purificar, irá aleatoriamente aumentar o nível de estrelas de purificação. Ao completar as estrelas, irá aleatoriamente purificar cada tipo de atributo." (button tip). Assumption: each skill id encodes type and star level in `SkillTempInfos` (`Grades` = stars, `Parameter3 > 0` = max star); the roll either raises the star of the same type or, at max, picks a new type. Probabilities are server side and unknown.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | equipment / treasure template | `Refresh` (stone template, -1 / 0 = not refinable), `Profile`, `MasterType`, `SonType`, `RandomSkillCount`, `Property3`, `Property6` (treasure) |
| `raw/xml/tempinfos/SkillTempInfos.xml` | random skill | `TemplateId`, `TemplateName`, `Grades` (stars), `Parameter3` (> 0 = max star) |
| `raw/xml/tempinfos/ShopTempInfos.xml` | stone shop entry | `ItemId`, `GiftToken` (diamond price) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Lock_Point` = 10 | diamonds per lock |

## 7. Persistent state

Assumption: the current random skills are columns of `inventory.items` (`random_skill_1..5`). The pending roll is smith state.

```sql
CREATE TABLE smith.pending_refresh (
    item_id      BIGINT PRIMARY KEY REFERENCES inventory.items(item_id) ON DELETE CASCADE,
    player_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    new_skills   INTEGER[] NOT NULL CHECK (cardinality(new_skills) = 5),
    lock_mask    BOOLEAN[] NOT NULL CHECK (cardinality(lock_mask) = 5),
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX pending_refresh_player_idx ON smith.pending_refresh (player_id);

CREATE TABLE smith.refresh_log (
    log_id         BIGSERIAL PRIMARY KEY,
    player_id      BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    item_id        BIGINT NOT NULL,
    old_skills     INTEGER[] NOT NULL,
    new_skills     INTEGER[] NOT NULL,
    lock_mask      BOOLEAN[] NOT NULL,
    stones_used    INTEGER NOT NULL DEFAULT 0,
    points_spent   INTEGER NOT NULL DEFAULT 0,
    replaced       BOOLEAN NOT NULL DEFAULT false,
    created_at     TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

Handlers:
- 8464 -> `smith::refine::handle_query_pending`.
- 8336 -> `smith::refine::handle_refresh`.
- 8339 -> `smith::refine::handle_replace`.

`handle_query_pending`: item must belong to the player; return 4368 with `result = 1` and the pending row, else `result = 0` and 5 zeros / falses.

`handle_refresh` validation order:
1. Resolve target: item in hidden smith slot 0 of the player (bag 0, pos 0). (For the Einherjar / guardian contexts, their own slots; see those features.)
2. Item not locked; template `Refresh > 0`; MasterType 1 (equipment path) or 11 (treasure path); hero level >= 19 (equipment) or royalty level > 0 (treasure).
3. `lock` has 5 entries; count active slots; `locks < active slots`.
4. Equipment: stones needed by Profile; count owned by `bind_type`; missing stones are bought at `GiftToken` each; lock diamonds `max(0, locks - owned208027) * Lock_Point`; debit diamonds per `material_pay_type` (0 bound first, 1 diamonds only); reject when insufficient.
   Treasure: stones `Property6 + Property3 * const[locks-1]`; reject when short.
5. Roll new values for unlocked active slots; locked slots keep current ids.
- Transaction: consume stones and lock items, debit diamonds, upsert `smith.pending_refresh`, insert `refresh_log`. After commit: bag / resource pushes, 115, then 4258.

`handle_replace`: load pending row for the hidden slot 0 item; copy `new_skills` into the item, delete pending, mark log `replaced`; push item update, then 4259 `result = true`. Without a pending row reply 4259 `result = false`.

No timers, no battles, no pushes to other players.

## 9. Open questions and assumptions

- Assumption: the pending result is per item and survives logout (the client queries it on every placement).
- Assumption: a new refine overwrites an unreplaced pending result (client confirm text "poderá desaparecer se continuar a purificar").
- Open: roll probabilities and star progression table are not in the client.
- Open: whether `pay_type` (#3) has any meaning; never set by the client.
- Assumption: lock items 208027 are consumed one per lock before charging diamonds.
- Open: treasure refine uses `material_pay_type = 0` but never diamonds; reject auto buy for treasures.

## 10. Implementation checklist

- [ ] Screen: `RefreshView` with stone, auto buy, bound material, lock count, diamond cost.
- [ ] Screen: `TreasureRefreshView` with treasure stone cost by lock count.
- [ ] Route R1: 8464 query pending -> 4368.
- [ ] Route R2: 8336 equipment refine (`lock`, `bind_type`, `material_pay_type`).
- [ ] Route R3: 8336 treasure refine.
- [ ] Route R4: 8339 replace -> item update + 4259.
- [ ] Server message S1: 4258 `SmithFreshRspMsg`.
- [ ] Server message S2: 4368 `RefreshPropertyRepMsg`.
- [ ] Server message S3: 4259 `SmithFreshReplaceRspMsg`.
- [ ] Table `smith.pending_refresh`, `smith.refresh_log`.
- [ ] Rule: stones by Profile, bound filter, auto buy price, lock cost with 208027.
- [ ] Rule: treasure stones `Property6 + Property3 * const[locks-1]`.
- [ ] Rule: `locks < active slots`, locked item rejection.
- [ ] Test: refine then reopen frame shows the pending result via 8464.
- [ ] Test: replace applies and clears pending; second replace returns false.
- [ ] Test: diamonds charged only for missing stones and excess locks.
