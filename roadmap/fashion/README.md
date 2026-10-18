# Fashion and appearance (Modas e aparência)

Feature slug: `fashion`. Domain: character. PostgreSQL schema: `fashion`. Rust module: `fashion`.

## Overview

Cosmetic and stat layers on top of the hero's equipment:
- **Wardrobe ("Moda")**: four fashion slots shown on the avatar: wing (SonType 109, position 8), hat (110, position 9), cloth (112, position 10), weapon (111, position 11). Each slot can be hidden ("Ocult."), and a separate set exists for the DragonTalker look. The worn set is a list of template ids (`FashionInfoMsg`), not bag items.
- **Fashion book ("Avaliação da Moda")**: every fashion ever collected; the player tries pieces on, saves the outfit, and appraises ("Não avaliado" / "Purificar") a piece to roll a bonus skill.
- **Fashion level ("Composição"/absorption)**: fashion items, "Alma da Moda" (208020) and "Amuleto da Sorte" (208021) are fed to raise a global fashion level (200 levels) that grants passive skills.
- **Refining ("Refinação"/polish)**: per slot (wing, hat, weapon, cloth), refinement levels raise fashion attributes by 10% per level and appraisal attributes every 10 levels.
- **Tattoos ("Tatuagem")**: holes with a positive and a negative primary attribute, purified with dyes, plus seals ("Selo de Tatuagem") that multiply a tattoo attribute; tattoos are the requirement for job transfer.

Avatar rendering rules are in [wardrobe.md](wardrobe.md); they also govern what other players see.

## Entry points

| Entry | Condition | Opens | Citation |
|---|---|---|---|
| Hero frame "Equipamentos" → fashion sub-panel | always | `EquipView` fashion slots, hide ticks, default fashion button, DragonTalker switch | `decompiled/m5/scripts/armyII/viewII/equip/EquipView.as:954-997` |
| Fashion buttons in EquipView | hero level >= 10 ("dayGuide.DayGuideManager.command02") | `fashion.FashionStoreFrame` "Modas" tab 0 (compose), 1 (book), 2 (refine) | `EquipView.as:889-941` |
| Buff bar fashion icon | | `fashion` tab 1 | `decompiled/core_module/scripts/ui/toptoolbar/view/ExtraBufferItem.as:108` |
| Hero frame tab "Tatuagem" | `vocationGrades > 0` | `TATTOO_PANEL` → `armyII.viewII.tattoo.TattooView` | `decompiled/m5/scripts/armyII/ArmyFrameII.as:256-259`, `:981-985`, `:1237` |
| Shop fashion tab | | buying fashions ([../shops/README.md](../shops/README.md)) | `decompiled/core_module/scripts/managers/ShopManager.as:604-640` |

## Modules

| Module | File | Routes | Server messages | Tables |
|---|---|---:|---:|---:|
| Wardrobe and appearance | [wardrobe.md](wardrobe.md) | 1 | 2 | 1 |
| Fashion book and appraisal | [fashion-book.md](fashion-book.md) | 5 | 2 | 1 |
| Fashion level (absorption) | [fashion-compose.md](fashion-compose.md) | 2 | 2 | 0 (columns in `fashion.wardrobe`) |
| Refining (polish) | [fashion-polish.md](fashion-polish.md) | 2 | 1 | 1 |
| Tattoos and seals | [tattoos.md](tattoos.md) | 4 | 2 | 2 |

## Protocol summary

| Dir | Opcode | Name | Module |
|---|---|---|---|
| send | 9582 | `C_FASHION_EXCHANGE` | wardrobe |
| accept | 301 | `U_C_FASHION_INFO` | wardrobe |
| send | 8625 | `C_FASHION_INFO` | book |
| accept | 4542 | `U_C_FASHION_BOOK` | book |
| send | 8595 | `C_FASHION_SWITCH` | book (save into book) |
| send | 8631 | `C_FASHION_SPECIAL` | book (clear "new") |
| send | 8781 | `C_FASHION_APPLRAISAL` | book (appraise) |
| send | 8594 | `C_FASHION_COMPOSE` | compose |
| accept | 4487 | `U_C_FASHION_COMPOSE` | compose |
| send | 9635 | `C_FASHION_POLISH_OP` | polish |
| accept | 408 | `U_C_FASHION_POLISH_LIST` | polish |
| send | 9568 | `C_TATTOO_REQ` | tattoos |
| accept | 274 | `U_C_TATTOO_RSP` | tattoos |
| send | 9603 | `C_TATTOO_ENHANCE` | tattoos |
| accept | 346 | `U_C_TATTOO_ENHANCE_DATA_MSG` | tattoos |
| send/accept | 8592 / 4486 | `C_FASHION_SHOP_BUY` / `U_C_FASHION_SHOP_BUY` | [../shops/README.md](../shops/README.md) |
| send/accept | 9613 / 367, 368, 369 | `C_FASHION_MOUNT_LOTTERY` / lottery data, hot items, drops (`ExchangeBoxManager`) | [../lotteries/README.md](../lotteries/README.md) |
| accept | 4488 | `U_C_FASHION_SWITCH` | no client listener |

## Dependencies

- [../hero/README.md](../hero/README.md): avatar fields in 150/113, fashion attribute totals (`SimpleHeroMsg.fashion_add_*`), job transfer uses tattoo totals ([../hero/job-change.md](../hero/job-change.md)).
- [../army/README.md](../army/README.md): `ArmyManager` receives 301, 274, 346.
- [../inventory/README.md](../inventory/README.md): fashion items in bags, hidden bag 0 for compose, bag moves 5005.
- [../shops/README.md](../shops/README.md): fashion shop, quick buy of 208020 and polish material 2131521.
- [../dragon/README.md](../dragon/README.md): DragonTalker look and its fashion set.
- [../currency/README.md](../currency/README.md): gold, diamonds.

## Suggested implementation order

1. [wardrobe.md](wardrobe.md): 301 at login and 9582, avatar fields in 150 and map broadcasts.
2. [fashion-book.md](fashion-book.md): 8625 → 4542, saving and appraisal.
3. [fashion-compose.md](fashion-compose.md).
4. [fashion-polish.md](fashion-polish.md).
5. [tattoos.md](tattoos.md) (needed before job transfer).
