# Dragon Talker symbiosis ("Sistema de Simbiose")

Module `symbiote`. Six symbiosis slots, one per talisman slot type. Each slot has a level (1..29) raised with "Pedra Simbiótica"; the level sets a percentage ("Simbiose {0}%", 9% at level 1 up to 50% at level 29) of the matching hero equipment's attributes (base, strengthen, refine, gems, refresh skills) that the Dragon Talker inherits while in Dragon Talker form.

Path aliases:

| Alias | File |
|---|---|
| DTM | `decompiled/core_module/scripts/managers/DragonTalkerManager.as` |
| DSI | `decompiled/core_module/scripts/mvc/module/dragontalker/DragonTalkerSymbioteInfo.as` |
| SPH | `decompiled/core_module/scripts/dragontalker/DragonTalkerSymbiotePropHelper.as` |
| V | `decompiled/m5/scripts/dragontalker/` |

`DragonTalkerOpMsg` and 4845 are documented in `talker.md`.

## 1. Overview

- Slot `index` 0..5 maps to talisman slot `401 + index` (Chapéu, Anel, Arma, Colar, Acessório, Vestuário) (`V/DragonTalkerSymbioteUpgradeFrame.as:218-242`) and to a hero equipment position through `DragonTalkerViewHelper.GetIndexByPos` (`SPH:26-53`).
- Exp curve: `UpGradeTempInfos` Types 142 (`Data` 0, 20, 120, 270, ... 63370 for levels 1..29), `ActiveObject` = inherited percent (9..50).
- Material: config `DragonTalker_Gp_Item_Config` items [0] = 208066 "Pedra Simbiótica", [1] = 10 exp per stone (`V/DragonTalkerSymbioteUpgradeFrame.as:91-97`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/view/DragonTalkerSymbioteView.as` (`equipView` + `DragonTalkerSymbioteBagView`) | tab symbiosis | six slots with level and percent, hero equipment preview | `DragonTalkerFrame` tab 1 | "Simbiose {0}%" per slot (`V/item/DragonTalkerSymbioteItem.as`); tooltips "O Encantador de Dragões obtém os seguintes atributos:" / "O personagem obtém os seguintes atributos:" (`SPH` sums) |
| `V/DragonTalkerSymbioteUpgradeFrame.as` | "Sistema de Simbiose" | feed stones to one slot | slot click, `DragonTalkerController` openType `SYMBIOTE_FRAME` | "Personagem" + slot name, "Nv. {n}", "Nível atual:Simbiose de atributos {0}%", "Próximo nível:Simbiose de atributos {0}%", "Gasto:", "{0} atual:{1}" (owned stones in bag and storehouse, `getBagCountInPlayerAndStoneByTempId`) (`:218-260`) |

## 3. Routes (client to server)

### A1. Feed a slot (op 7 STRENGTHEN_SYMBIONT)
- UI: confirm button (`V/DragonTalkerSymbioteUpgradeFrame.as:200-209`); count input clamped to `[1, min(owned, 9999)]` with "+N" exp preview (`:183-198`).
- Client checks: owned < count or count <= 0 -> "PetHallowsRightSkillView.train.noGoodsAlert".
- Sender: `DTM.sendSymbiontStrengthReq(index, count)` (`DTM:298-306`).
- Request: send 9667 (0x25c3) `C_DRAGONTALKER_OP`, `op`=7, `symbiontIndex` (#9) = 0..5, `count` (#3).
- Response: bag update 115; 4845 with `symbiontGpList` (#5) (the client rebuilds the whole list when non empty, so send all six entries, `DTM:114-133`).

## 4. Server messages (server to client)

4845 (0x12ed) `U_C_DRAGONTALKER_INFO`, field `symbiontGpList` (#5, repeated `SymbiontGp`): `index` (#1, INT32) slot 0..5, `totalGp` (#2, INT32) total exp. The client computes `grade` (Types 142), `exp` inside the level and `curMaxExp`.

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Exp per stone | 10 | config |
| Level | Types 142, 1..29 | `DTM:121-129` |
| Percent | `ActiveObject` of row `grade - 1` in the sorted Types 142 list (level 1 -> 9%, level 29 -> 50%) | `DSI:27-35` |
| Inherited value | per hero equipment attribute: `floor((base + strengthen add + refine of strengthen add + new add + refine of new add) * percent / 100)`, plus gem (mount gem) and refresh skill bonuses with the same percent | `SPH:56-90` and following helpers |
| Scope | applies while in Dragon Talker form (help text item 2) | `DragonTalkerFrame.helperFrame.helpTxt.text` |

## 6. Templates

| File | Use |
|---|---|
| `UpGradeTempInfos.xml` Types 142 | exp curve and percent |
| `ConfigInfos.xml` | `DragonTalker_Gp_Item_Config` |
| `ItemTempInfos.xml` | 208066 "Pedra Simbiótica" |

## 7. Persistent state

```sql
CREATE TABLE dragon.symbiosis_slots (
  player_id   BIGINT   NOT NULL REFERENCES dragon.talkers(player_id) ON DELETE CASCADE,
  slot_index  SMALLINT NOT NULL CHECK (slot_index BETWEEN 0 AND 5),
  total_gp    INTEGER  NOT NULL DEFAULT 0 CHECK (total_gp >= 0),
  PRIMARY KEY (player_id, slot_index)
);
```

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 7 | `dragon::symbiote::handle_feed` |

- Validation: feature open -> index 0..5 -> count 1..9999 -> stones owned (bag and storehouse, as the client counts both) -> not max level.
- Transaction: consume stones, add exp (cap at 63370), push 115 and 4845 with all six `SymbiontGp`.
- Recompute Dragon Talker stats (hero attribute pipeline, [hero](../hero/README.md)) when the player is in Dragon Talker form.

## 9. Open questions and assumptions

- *(assumption)* Stones are taken from the storehouse when the bag is short (client counts both).
- *(assumption)* Exp beyond max is not consumed.

## 10. Implementation checklist

- [ ] Op 7 feed.
- [ ] 4845 `symbiontGpList` with six entries.
- [ ] Table `dragon.symbiosis_slots`.
- [ ] Inherited stat computation in the Dragon Talker stat pipeline.
- [ ] Tests: 2 stones from level 1 reach level 2 (20 exp, 10%); max level 29 rejects feeding.
