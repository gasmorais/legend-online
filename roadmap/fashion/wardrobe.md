# Wardrobe and appearance (Moda, Ocult.)

Path aliases:

| Alias | File |
|---|---|
| AM | `decompiled/core_module/scripts/yishi/manager/ArmyManager.as` |
| EV | `decompiled/m5/scripts/armyII/viewII/equip/EquipView.as` |
| FT | `decompiled/m5/scripts/armyII/viewII/equip/FashionTick.as` |
| TI | `decompiled/core_module/scripts/yishi/datas/playerinfo/ThaneInfo.as` |
| TIH | `decompiled/core_module/scripts/com/road/pb/helper/army/ThaneInfoHelper.as` |
| FSV | `decompiled/m14/scripts/fashion/FashionSwitchView.as` |
| SSM | `decompiled/core_module/scripts/map/space/manager/SpaceSocketManager.as` |

## 1. Overview

The worn fashion set is a server record (`FashionInfoMsg`) of four template ids per look (player look and DragonTalker look), four hide flags per look, the fashion level (`gp`, `grades`) and a "default fashion" flag. The client builds pseudo bag items (bag type 4, positions 8 wing, 9 hat, 10 cloth, 11 weapon) from it (AM:900-981). The avatar uses fashion art over equipment art unless the piece is hidden.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.equip.EquipView` fashion panel (EV) | panel switch "Equipamentos"/fashion | 4 fashion cells (`PlayerEquipCell`, bag 4), one "Ocult." tick per worn piece (`FashionTick`, FT:34-90), default fashion button, DragonTalker look switch, buttons to compose/book/refine | hero frame | `ArmyManager.fashionList`, `fashionInfoMsg` (EV:1440-1485) |
| `armyII.viewII.equip.HeroFigureView` | | Avatar preview | EV | `ThaneInfo` built from equipment + fashion (EV:1340-1378) |
| `fashion.FashionSwitchView` (FSV) | "Avaliação da Moda" | Try-on and "save" of a new set | `FashionStoreFrame` tab 1 | see [fashion-book.md](fashion-book.md) |

## 3. Routes (client to server)

### R1. Update the worn set (`C_FASHION_EXCHANGE`)
- Triggers (all send the full current `FashionInfoMsg` copy with modifications):
  - hide tick toggled (FT:86-90 → `EV.__fashionChangeHandler`, EV:1486-1510): sets `wingAvata`/`hatAvata`/`clothAvata`/`armAvata` to the tick's template id and the matching `isHiden*` flag;
  - save after try-on in the book (FSV:380-444): sets `armAvata` (111), `clothAvata` (112), `hatAvata` (110), `wingAvata` (109) from `saveList`, or the `dragon*` fields from `dragonTalkerSaveList` when the DragonTalker look is selected;
  - default fashion button (EV:776-817): `defaultFashion` = 1/0 after confirm "Após selecionar a aparência predefinida, esta aparência aparecerá como predefinida nas campanhas do personagem e a exibição de aparência. Após trocar a profissão, não poderá mudar a aparência do personagem. Confirma que deseja continuar?" (`armyII.viewII.equip.EquipView.defaultFashionTips`).
- Client path: `AM.sendFashionChange(msg)` (AM:894-898).
- Route: send 9582 (0x256e) `C_FASHION_EXCHANGE`, `FashionInfoMsg` (fashion):

| Field | Tag/type | Meaning |
|---|---|---|
| `gp` | #1, INT32 | fashion level EXP (echo, server-owned) |
| `grades` | #2, INT32 | fashion level (echo) |
| `wingAvata`, `hatAvata`, `armAvata`, `clothAvata` | #3-#6, INT32 | worn template ids, player look (0 = none) |
| `isHidenWingAvata`, `isHidenHatAvat`, `isHidenArmAvata`, `isHidenClothAvata` | #7-#10, BOOL | hide flags, player look |
| `dragonWingAvata`, `dragonHatAvata`, `dragonArmAvata`, `dragonClothAvata` | #11-#14, INT32 | DragonTalker look |
| `isHidendDragonWingAvata`, `isHidenDragonHatAvat`, `isHidenDragonArmAvata`, `isHidenDragonClothAvata` | #15-#18, BOOL | DragonTalker hide flags |
| `defaultFashion` | #19, INT32 | 1 = use this set as the default appearance in campaigns |

- Client checks: none (trust nothing).
- Response: 301 (S1); appearance broadcast 149 (S2) to players who see the hero; 113/150 avatar strings for the own hero *(assumption)*.

### R2. Global "hide fashion" button (no server call)
`EV.__hideFashionHandler` (EV:880-887) sets `thane.hideFashion` locally and calls `ArmySocketOutManager.sendHideFashion`, which is an empty function (`decompiled/core_module/scripts/managers/ArmySocketOutManager.as:297-299`). The persisted flag arrives through `ArmyMsg.hide` (#32) / `HeroEquUpdatedMsg.hide` (#8); implement it server-side as derived from the four `isHiden*` flags *(assumption)*.

The DragonTalker look switch button calls `DragonTalkerManager.sendDragonTalkerSwicthRequest` (EV:819-827; 3 s throttle "Clicou demasiado rapidamente, tente mais tarde"; blocked in Theseus PvP scenes "Na cena atual não pode mudar de forma!"), owned by [../dragon/README.md](../dragon/README.md).

## 4. Server messages (server to client)

### S1. 301 (0x012d) `U_C_FASHION_INFO`
- `FashionInfoMsg` (fields above).
- Receiver: `AM.__fashionHandler` (AM:900-981): stores `fashionInfoMsg`; rebuilds `fashionList` and `dragonFashionList` with pseudo items at bag 4 positions 8 (wing), 9 (hat), 10 (cloth), 11 (arm) for every non-zero template; dispatches `FASHION_SHOW_CHANGE`.
- When: login (after 150), after 9582, after compose (level/gp change), after book changes that alter the set.

### S2. 149 (0x0095) `U_C_HERO_BROAD_EQUIPMENT`
- `HeroEquUpdatedMsg` (army): `player_id` (#1, INT32), `arm_str` (#2, STRING) equipment weapon art, `cloth_str` (#3, STRING) equipment cloth art, `wing` (#4, STRING) wing art, `hat` (#5, STRING) hat fashion art, `fashion_arm` (#6, STRING), `fashion_cloth` (#7, STRING), `hide` (#8, BOOL), `appellId` (#9, INT32), `trans_grade` (#10, INT32), `changeBranch` (#11, INT32).
- Receivers: Sky realm map (SSM:186-207), rooms (`decompiled/core_module/scripts/managers/RoomManager.as:116`), space proxy. Updates the other hero's avatar strings, title and vocation.
- When: broadcast to players sharing a map or room whenever equipment, fashion, hide flag, title or vocation changes.

## 5. Rules and formulas

- Avatar selection (TI:677-823): body = fashion cloth art if not hidden and non-empty, else equipment cloth; arms and hair likewise; wing hidden entirely when `hideFashion`. Art strings are `ItemTempInfos.Avata` of the template (`ThaneEquipShowHelper.getAvatarByEquipInfo`, `decompiled/core_module/scripts/yishi/utils/ThaneEquipShowHelper.as:48-61`).
- Only owned (book) templates of the right SonType may be worn: 109 wing, 110 hat, 111 weapon, 112 cloth (`FashionManager.getSonTypeByindex`, `decompiled/core_module/scripts/managers/FashionManager.as:209-226`).
- DragonTalker fashions have `Job = "99"` and SonType 278 is the fashion material type (`FashionModel` constants, `decompiled/core_module/scripts/mvc/module/fashion/FashionModel.as:49-55`).
- `defaultFashion = 1` freezes the appearance after job transfer (UI text).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ItemTempInfos.xml` | fashion items (SonType 109..112, Job "99" for DragonTalker) | `TemplateId`, `TemplateName`, `SonType`, `Job`, `Avata` (art path), `Profile` (quality) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS fashion;

CREATE TABLE fashion.wardrobe (
    player_id            BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    wing_template_id     INTEGER NOT NULL DEFAULT 0,
    hat_template_id      INTEGER NOT NULL DEFAULT 0,
    arm_template_id      INTEGER NOT NULL DEFAULT 0,
    cloth_template_id    INTEGER NOT NULL DEFAULT 0,
    hide_wing            BOOLEAN NOT NULL DEFAULT FALSE,
    hide_hat             BOOLEAN NOT NULL DEFAULT FALSE,
    hide_arm             BOOLEAN NOT NULL DEFAULT FALSE,
    hide_cloth           BOOLEAN NOT NULL DEFAULT FALSE,
    dragon_wing_template_id  INTEGER NOT NULL DEFAULT 0,
    dragon_hat_template_id   INTEGER NOT NULL DEFAULT 0,
    dragon_arm_template_id   INTEGER NOT NULL DEFAULT 0,
    dragon_cloth_template_id INTEGER NOT NULL DEFAULT 0,
    dragon_hide_wing     BOOLEAN NOT NULL DEFAULT FALSE,
    dragon_hide_hat      BOOLEAN NOT NULL DEFAULT FALSE,
    dragon_hide_arm      BOOLEAN NOT NULL DEFAULT FALSE,
    dragon_hide_cloth    BOOLEAN NOT NULL DEFAULT FALSE,
    default_fashion      BOOLEAN NOT NULL DEFAULT FALSE,
    fashion_level        SMALLINT NOT NULL DEFAULT 0 CHECK (fashion_level BETWEEN 0 AND 200),
    fashion_exp          INTEGER NOT NULL DEFAULT 0 CHECK (fashion_exp >= 0),
    updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- `fashion::wardrobe::handle_exchange` (9582): ignore client `gp`/`grades`; for each slot accept 0 or a template present in `fashion.book_entries` with the right SonType (and `Job 99` only for the dragon fields); store flags and `defaultFashion`; reply 301; recompute avatar strings and broadcast 149 to the map/room; push 113 if fashion attributes depend on worn pieces *(assumption: attributes come from the book and level, not the worn set)*.
- `fashion::wardrobe::push_fashion_info` at login after 150.
- Avatar strings in 150 (`ArmyMsg.wing`, `hat`, `fashion_arm`, `fashion_cloth`, `hide`) and in map/room snapshots come from this table.

## 9. Open questions and assumptions

- Assumption: the global hide button is client-only (empty sender); the server derives `hide` from the per-slot flags.
- Open: whether 9582 can also unequip a slot by sending 0 (the client never sends 0 for a worn slot).

## 10. Implementation checklist

- [ ] Screen: EquipView fashion cells and hide ticks, HeroFigureView
- [ ] Route 9582 (hide, save, default)
- [ ] Server message 301 at login and after changes
- [ ] Server message 149 broadcast
- [ ] Table `fashion.wardrobe`
- [ ] Rule: avatar selection and hide semantics
- [ ] Rule: only owned templates per SonType
- [ ] Test: another player sees the new outfit on the Sky realm map
