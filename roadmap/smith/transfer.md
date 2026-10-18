# Smith: transfer (item conversion, "Converter")

Scope: the switch tab of the smith frame (`SwitchView1`, legacy `SwitchView`). Despite the class names ("switch", proto `SmithTransformRspMsg`), the client does not move strengthen levels between equipment: it converts a stack of an item into another item of the same conversion group (`TransformInfos`), for example a level 1 attack gem into a level 1 defense gem, paying gold. Strengthen related transfers are not present in this client; see [strengthen.md](./strengthen.md) for intensify. Frame shell, bags and placement into hidden slot 0 (5005 `U_C_BAG_MOVE`) are in [store-frame.md](./store-frame.md).

Path aliases:

| Alias | File |
|---|---|
| SSOM | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| MF | `decompiled/m14/scripts/store/MakeFrame.as` |
| SW1 | `decompiled/m14/scripts/store/SwitchView1.as` |
| SW | `decompiled/m14/scripts/store/switched/SwitchView.as` |
| SI | `decompiled/m14/scripts/store/switched/SwitchItem.as` |
| SB2 | `decompiled/m14/scripts/store/StoreBagII.as` |
| SBCM | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellClickMediator.as` |

## 1. Overview

- The player places a convertible item (template `TransformId > 0`) in the smith slot (hidden bag 0, pos 0). The panel lists the other members of the same `TransformInfos` group (up to 7 targets out of `Material1..8`, the source excluded) as `SwitchItem` icons. The player chooses a target, sets a quantity (1..max) and presses convert.
- Cost: `CostGold * quantity`, reduced by the VIP conversion discount (VIP prerogative type 202).
- Unlock: hero level 19 (switch tab, `MF:192-195`).
- Groups (60 rows): groups 1..n are the 8 gem attributes of the same level (Ataque, Defesa, Magia, Resistência, Crítico, Vida, Liderança, Bloqueio), 10 000 gold for group 1 up to 2 560 000 for the dragon pearl groups 301..312.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SW1` (`store.SwitchView1`) | tab 2 of "Fabricar" | Conversion panel | `MF.showSwitchView` (`MF:359-367`), tab disabled below 19 with tip "Função habilitada no Nv. {0}" (`MF:192-195`) | source slot (key "0_0_0", `SW1:187-188`), 8 `SI` target cells (`SW1:189-199`), quantity box with min / - / + / max, gold cost, discounted cost with strike line and "{0}%Off" badge, VIP upsell `NewVipOpenView(202)` when no discount (`SW1:139`, `SW1:170-177`), own `StoreBag` (`SW1:140`) |
| `SI` | | Target item cell | `SW1` | target icon, quantity text, highlight when selected (`SI:76-160`) |
| `SW` | | Legacy version of the same panel | legacy `StoreFrame` (`decompiled/m14/scripts/store/StoreFrame.as:345`) | same logic, other layout |

## 3. Routes (client to server)

### R1. Convert

- UI: convert button `_switchBtn` (`SW1:208`, handler `SW1:458-477`).
- Client checks:
  1. Placement: store bag filter for the switch panel shows only `TransformId > 0` and SonType not 343 / 344 (`SB2:809-815`); locked items are refused with "Os itens bloqueados não podem ser trocados" (`SBCM:130-138`).
  2. Target selection: first target auto selected; clicking another target changes the selection (`SW1:415-456`).
  3. Quantity: 1..`maxCount`; `maxCount = min(stack count in the slot, floor(gold / (CostGold * discount)))` (`SW1:349-358`); the text box clamps to that range (`SW1:248-322`).
  4. `int(CostGold * quantity * discount) > gold` -> "Ouro Insuficiente" (`SW1:461-466`).
  5. If the source item is not bound, `sendSwitch` goes through `showSwitchAlert`, which always returns false (no dialog, `SW1:501-515`); if bound, it sends directly and disables the button (`SW1:467-476`). Both send the same message.
- Client path: `SSOM.sendSwitch(parentTemId, targetTemplateId, count)` (`SSOM:187-195`), from `SW1:474`, `SW1:507`, `SW1:522` (legacy `SW:467`, `SW:500`, `SW:515`).
- Route: send 8538 (0x215a) `C_ITEM_TRANSFORM`, `StoreReqMsg`:

| Field | Value / meaning |
|---|---|
| hole_pos (#1, INT32) | unused |
| operate (#2, BOOL) | unused |
| bag_type (#3, INT32) | unused |
| bag_pos (#4, INT32) | unused |
| mount_pos (#5, INT32) | unused |
| compose_id (#6, INT32) | unused |
| compose_num (#7, INT32) | unused |
| auto_buy (#8, BOOL) | unused |
| src_itemid (#9, INT32) | source item template id (`SwitchItem.parentTemId` = `GoodsInfo.templateId` of the slot item), not an instance id |
| des_itemid (#10, INT32) | target template id (one of `Material1..8` of the same `TransformId` group) |
| count (#11, INT32) | quantity to convert |
| pay_type (#12, INT32) | unused |
| opType (#13, INT32) | unused |

- Expected response: no dedicated response opcode is handled by the client. The server updates the hidden slot item (source stack reduced or removed, converted items added) through bag pushes; `SW1.__bagItemUpdateHandler` / `__bagItemDeleteHandler` refresh the panel (`SW1:334-370`). Gold through the resource push.

## 4. Server messages (server to client)

### S1. Bag / resource pushes

- Item update or delete of the hidden slot 0 stack, item add of the converted stack, gold update; owned by inventory ([../inventory/README.md](../inventory/README.md), [store-frame.md](./store-frame.md)).
- Receivers: `SW1.__bagItemUpdateHandler` (`SW1:334-347`): sets `maxCount`, forces the displayed count to 1 and rebuilds targets; `SW1.__bagItemDeleteHandler` (`SW1:360-370`).

### S2. `SmithTransformRspMsg` (proto `store`)

- result (#1, BOOL).
- No opcode in `protocol/opcodes.csv` carries it and no client code reads it. Assumption: it is an unused legacy response; the server may skip it. If a response opcode is desired, document it in the server only.

## 5. Rules and formulas

- Eligibility: template `TransformId > 0`, SonType not 343 / 344 (dual attribute gems), item not locked (`SB2:809-815`, `SBCM:130-138`).
- Target must be a different template of the same `TransformInfos` row (`SW1:406-437`); `Material8 = 0` rows have 7 members.
- Gold: `int(CostGold * count * discount)` (`SW1:381-393`, `SW1:461`).
- VIP discount (`SW1:479-499`): when VIP is active and not expired, `discount = para1 / 100` of `VipPrerogativeTempInfos` type 202 for the VIP grade: grade 1: 90, 2: 85, 3: 80, 4: 75, 5: 70, 6: 65, 7: 60, 8: 55, 9: 50 ("Desconto de conversão: {para1}%Off"); otherwise 1. Badge text "{0}%Off" with `100 - int(discount * 100)` (`SW1:176`).
- Count: `1 <= count <= stack count in slot`, and gold must cover it.
- Bound flag: Assumption: converted items inherit the bound flag of the source stack (the client distinguishes bound sources only for the confirm path).
- The source stack is consumed from hidden slot 0 (Assumption: the server identifies the source as the stack of `src_itemid` in hidden slot 0 and rejects if it holds fewer than `count`).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/TransformInfos.xml` (60 rows, loaded `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1169`, cate `transformBackTemplateCate`) | conversion group | `TransformId`, `Material1..8` (member templates, 0 = empty), `CostGold` (gold per unit) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | item template | `TransformId` (group of the item), `SonType` |
| `raw/xml/tempinfos/VipPrerogativeTempInfos.xml` | VIP prerogative type 202 | `grade`, `para1` (percent paid) |

## 7. Persistent state

No feature specific entity: the conversion only changes `inventory.items` rows (Assumption: owned by inventory). Optional audit table:

```sql
CREATE TABLE smith.transform_log (
    log_id        BIGSERIAL PRIMARY KEY,
    player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    src_template  INTEGER NOT NULL,
    dst_template  INTEGER NOT NULL,
    count         INTEGER NOT NULL CHECK (count > 0),
    gold_spent    BIGINT NOT NULL CHECK (gold_spent >= 0),
    created_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
    CHECK (src_template <> dst_template)
);
CREATE INDEX transform_log_player_idx ON smith.transform_log (player_id, created_at DESC);
```

## 8. Backend implementation notes

Handler: 8538 -> `smith::transfer::handle_transform`.

Validation order:
1. Hero level >= 19.
2. Source stack: hidden smith slot 0 item with `template_id = src_itemid`, not locked, owned by the player.
3. Source template `TransformId > 0`, SonType not 343 / 344; destination template present in the same `TransformInfos` row and different from the source.
4. `1 <= count <= stack count`.
5. Gold `int(CostGold * count * vipDiscount)` with the VIP grade discount (type 202) when VIP is active.
6. Bag space for the converted stack (Assumption: the result goes to the main bag, bag 1; or back into slot 0 if the source stack is fully consumed).
- Transaction: debit gold, reduce or delete the source stack, add `count` of the destination template with the source bound flag, insert `transform_log`. After commit: item and resource pushes. No response opcode (S2 unused).

No timers, no battles, no pushes to other players.

## 9. Open questions and assumptions

- Open: the brief names this module "strengthen / attribute transfer"; the client implements only template conversion. If a strengthen transfer exists server side it has no client UI in this build.
- Assumption: no response opcode; `SmithTransformRspMsg` unused.
- Assumption: destination of the converted stack (bag 1 vs hidden slot 0); the client only refreshes from bag pushes.
- Assumption: bound flag inherited from the source.
- Open: fashion conversion uses 8595 `C_FASHION_SWITCH` / 4488 (`decompiled/core_module/scripts/managers/FashionManager.as:168`), owned by [../fashion/README.md](../fashion/README.md).

## 10. Implementation checklist

- [ ] Screen: `SwitchView1` with target list, quantity box, gold and VIP discount display.
- [ ] Route R1: 8538 `StoreReqMsg` (`src_itemid`, `des_itemid`, `count`).
- [ ] Server message S1: item / resource pushes after conversion.
- [ ] Server message S2: decide on `SmithTransformRspMsg` (unused).
- [ ] Table `smith.transform_log` (optional).
- [ ] Rule: eligibility (`TransformId`, SonType 343 / 344 excluded, locked excluded).
- [ ] Rule: gold `CostGold * count * discount`, VIP type 202 grades.
- [ ] Test: convert 5 gems of group 1 from attack to defense, gold debited with and without VIP.
- [ ] Test: reject destination outside the group and count above the stack.
