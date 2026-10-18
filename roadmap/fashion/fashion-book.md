# Fashion book and appraisal (Avaliação da Moda)

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/managers/FashionManager.as` |
| FMOD | `decompiled/core_module/scripts/mvc/module/fashion/FashionModel.as` |
| FSF | `decompiled/m14/scripts/fashion/FashionStoreFrame.as` |
| FSV | `decompiled/m14/scripts/fashion/FashionSwitchView.as` |
| FSI | `decompiled/m14/scripts/fashion/FashionSwitchItem.as` |

## 1. Overview

The book lists every fashion template the hero owns (player and DragonTalker sets, per slot: wings, hats, clothes, weapons). From it the player:
- tries pieces on (client preview, `FMOD.wearFahion`/`getOffFashion`, `TRY_ON`/`GET_OFF` steps) and saves the outfit ([wardrobe.md](wardrobe.md) R1);
- clears the "new" mark of a piece;
- appraises a piece ("Não avaliado" → gold) and later re-rolls it ("Purificar" → "Alma da Moda" 208020) to get a bonus skill (`appraisal_skill`) up to grade 5;
- buys a missing piece with diamonds (shop feature).

The "Avaliação da Moda" total (sum of fashion attributes) is shown in `FashionStoreFrame` ("Poder +{0}", "Armadura +{0}", "Inteligência +{0}", "Físico+{0}", FSF:402-431).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `fashion.FashionStoreFrame` (FSF) | "Modas" (`fashionStoreFrame.title`), help "Instruções da Moda" | Container with hero preview ("Nv.{0}", "P. Combate"), tabs compose / book / refine, shop link, look switch "Mudar para Encantador de Dragões" / "Mudar para\nJogador" (only after vocation: "Pode ativar o Encantador de Dragões depois de avançar a Profissão") | EquipView buttons (`openControllerByInfo("fashion", 0/1/2)`) | `fashionInfoMsg`, book |
| `fashion.FashionSwitchView` (FSV) | "Avaliação da Moda" (`fashion.FashionStoreFrame.showSwitchView.text`) | Paged grid of book entries per slot, save button (tip "Ainda não provou outras modas") | tab 1 | `FMOD.fashionIds`, `bookList`, `identityedList` |
| `fashion.FashionSwitchItem` (FSI) | "Não avaliado", "Purificar" | One entry: try-on, appraisal button, buy button | FSV | template, appraisal skill |

## 3. Routes (client to server)

### R1. Request the book (`C_FASHION_INFO`)
- When: `FM.setup()` at client start (FM:44-50) and on demand (`FM.getFashionBook`, FM:52-56).
- Route: send 8625 (0x21b1) `C_FASHION_INFO`, no body.
- Response: 4542 (S1).

### R2. Clear the "new" mark (`C_FASHION_SPECIAL`)
- UI: clicking an entry whose `bookList[tid] == false` (FSI:452-462).
- Route: send 8631 (0x21b7) `C_FASHION_SPECIAL`, `FashionMsg` (fashion): `template_id` (#1, INT32); `info` (#2) and `fashionIds` (#3) unset (FM:201-207).
- Response: 4542 with `is_switch = true` for that entry *(assumption)*.

### R3. Appraise or re-roll (`C_FASHION_APPLRAISAL`)
- UI: appraisal button (FSI:514-590).
- Client checks: not already at max ("A moda já foi ativada até os pontos máximos de atributos", appraisal skill grade 5, `FMOD.hasRefreshFull`, FMOD:1029-1044); hero level >= 27 ("Nível necessário {0}", `FashionModel.INDENTITY_OPEN_GRADE`); first appraisal costs `(6 - TransformId) * 200000` gold with confirm "Desja consumir {0} ouro para avaliar?" and gold check "Ouro Insuficiente"; re-roll costs `Property2` (`getCountForRefresh`, FMOD:993-996) x 208020 with confirm "Deseja consumir {0} Alma da Moda para avaliar?"; missing souls open the quick buy.
- Route: send 8781 (0x224d) `C_FASHION_APPLRAISAL`, `FashionMsg`: `template_id` (#1, INT32) (FM:174-180).
- Response: 4542 with the new `appraisal_skill`; currency/bag updates; 113 for stats.

### R4. Wear a template directly (`C_FASHION_SWITCH`)
- UI: no fashion screen; the wedding flow puts on the wedding outfit pieces (`decompiled/m3/scripts/map/campaign/mediator/marry/MarryUIMediator.as:282-296`) via `FM.saveBook(tid)` (FM:162-172).
- Route: send 8595 (0x2193) `C_FASHION_SWITCH`, `FashionMsg`: `template_id` (#1, INT32). (`StoreSocketOutManager.sendFashionSwitch` also targets 8595 with an empty `StoreReqMsg`, but has no caller.)
- Response: 301 ([wardrobe.md](wardrobe.md)); 4488 `U_C_FASHION_SWITCH` has no client listener.

### R5. Buy a missing piece
- UI: buy button on an unowned entry (FSI:477-507): confirm "Atualmente,  não <font color='#00ff00'>{0}</font>,  deseja consumir <font color='#ff0000'>{1}</font> diamantes para ..." with bound diamond checkbox; then `ShopManager.buyOne(shopId, 1, userId, payType, false)`.
- Route and response: shop feature ([../shops/README.md](../shops/README.md)); the bought piece must be added to the book (S1 push).

## 4. Server messages (server to client)

### S1. 4542 (0x11be) `U_C_FASHION_BOOK`
- `FashionMsg` (fashion): `template_id` (#1, INT32) unused here; `info` (#2, `FashionBook`, repeated): `temp_id` (#1, INT32), `is_switch` (#2, BOOL) false = new (shows the "new" mark), `appraisal_skill` (#3, INT32) skill id rolled by appraisal (0 = not appraised); `fashionIds` (#3, INT32, repeated) owned fashion template ids.
- Receiver: `FM.__receivedBookHandler` (FM:68-118): rebuilds `bookList` (template → `is_switch`), `identityedList` (entries with an appraisal skill), and `fashionIds` (only ids with an item template, sorted descending); dispatches `FASHION_BOOK_RECEIVE`.
- When: response to 8625, after 8631, 8781, after obtaining a fashion.

### S2. 301 `U_C_FASHION_INFO`
See [wardrobe.md](wardrobe.md).

## 5. Rules and formulas

- Appraisal unlock: hero level 27 (`FashionModel.INDENTITY_OPEN_GRADE`, FMOD:29).
- First appraisal gold: `(6 - TransformId) * 200000` (`TransformId` of the fashion item template).
- Re-roll cost: template `Property2` units of 208020 "Alma da Moda".
- Max appraisal: skill `Grades` 5.
- The guide flash for appraisal uses `SharedManager.fashionIdentityProgress` (client only).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ItemTempInfos.xml` | fashion items | `SonType` (109..112), `Job` ("99" DragonTalker), `TransformId` (appraisal price factor), `Property2` (re-roll souls), `Property5` (switch filter, `decompiled/core_module/scripts/cell/view/fashionbag/FashionBag.as:156`) |
| `SkillTempInfos.xml` | appraisal skills | `Grades` (1..5), effects |

## 7. Persistent state

```sql
CREATE TABLE fashion.book_entries (
    player_id          BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    template_id        INTEGER NOT NULL,
    seen               BOOLEAN NOT NULL DEFAULT FALSE,
    appraisal_skill_id INTEGER NOT NULL DEFAULT 0,
    obtained_at        TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, template_id)
);
```

## 8. Backend implementation notes

- `fashion::book::handle_request` (8625): reply 4542 with all rows (`info`) and owned ids (`fashionIds`).
- `fashion::book::handle_clear_new` (8631): set `seen`; reply 4542.
- `fashion::book::handle_appraise` (8781): owned; hero level >= 27; first time gold cost, else 208020 x `Property2`; roll the appraisal skill (pool and weights server-side *(assumption: grade-weighted pool per SonType)*); reply 4542; push 113.
- `fashion::book::handle_switch` (8595): template must be owned or granted by the wedding; set the slot of its SonType in `fashion.wardrobe`; reply 301; broadcast 149.
- `fashion::book::grant(player, template_id)`: called by item use/shop/rewards; insert with `seen = false`; push 4542.

## 9. Open questions and assumptions

- Assumption: a fashion enters the book when its item is used or bought; the item is consumed.
- Assumption: appraisal skill pool and odds are server data not present in the client.
- Open: meaning of `is_switch` beyond the "new" mark.

## 10. Implementation checklist

- [ ] Screens: FashionStoreFrame tab 1, FashionSwitchView, FashionSwitchItem
- [ ] Route 8625
- [ ] Route 8631
- [ ] Route 8781 (first appraisal and re-roll)
- [ ] Route 8595
- [ ] Route shop purchase (with shops)
- [ ] Server message 4542
- [ ] Table `fashion.book_entries`
- [ ] Rule: level 27 gate, costs, max grade 5
- [ ] Test: obtain → new mark → clear → appraise → save outfit
