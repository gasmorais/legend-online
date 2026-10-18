# Smith: Encantamento (equipment enchant) and the life skill channel

Path aliases:

| Alias | File |
|---|---|
| EV | `decompiled/m14/scripts/store/enchant/EnchantView.as` |
| SSOM | `decompiled/core_module/scripts/managers/StoreSocketOutManager.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StoreControler.as` |
| SM | `decompiled/core_module/scripts/mvc/module/store/StoreModel.as` |
| CLK | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellClickMediator.as` |
| DRP | `decompiled/core_module/scripts/cell/mediator/storebag/StoreBagCellDropMediator.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| IH | `decompiled/core_module/scripts/com/road/pb/helper/item/ItemHelper.as` |

## 1. Overview

Enchant applies a "life skill" effect (an extra skill / attribute set) to a piece of equipment using an enchant material (SonType 236). Help (`store.StoreControler.helpContent08`): "Todos os equipamentos do personagem podem ser encantados e pode-se obter atributos adicionais.", "Ao encantar com sucesso, consumirá habilidade vitais.", "Diferentes partes do equipamento precisam de diferentes materiais de encantamento." It is not strengthen-like (no grade, no rate), so it has its own module.

Status in this client build: legacy, unreachable.
- No shell creates `store.EnchantView`: neither `MakeFrame` / `StoreView1` nor the legacy `StoreFrame` has an enchant tab; only the panel id `STORE_PANEL_ENCHANT`, the help frame 8 (`SC:283-284`), the bag filters (`StoreBagII.as:859-868`, `StoreBag.as:540`) and the click / drop rules remain.
- `ItemTempInfos.xml` has no SonType 236 item, so no material exists.
- Enchant was part of the life skill system (`C_LIFE_SKILL_OP` 8971 op 7). The life skill frame `store.LifeSkillFrame` (style `store.makeFrame.lifeskill`, opened with openType `"SKILL"` from NPC dialog option 33 at level 35, `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:612-618`, `SC:99-107`) is declared in `raw/ui/zh_cn/xml/decoded/store.xml:3984-3986` but its class is absent from the decompiled client. The other life skill ops (mining, compose, learn, upgrade, forget, collect, select) have no callers.

Recommendation: implement the enchant handler and the life skill data model only if the life skill UI is restored; otherwise keep 8971 answering with 126 "função indisponível". This file documents everything the client still contains so the decision can be made later.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `EV` `store.EnchantView` | enchant panel, button `store.EnchantBtn` | Equipment cell `StoreEnchantCell1` (workspace slot 0), material cell `StoreEnchantCell2` (slot 1, `sonType = 236`), description text (`EV:76-121`) | Unreachable (would be a smith sub tab, panel `STORE_PANEL_ENCHANT`) | Equipment name colored by Profile; button enabled when both cells are filled (`EV:283-303`) |
| Confirm alert | "encantamento pode falhar (atributos não mudam)，tem a certeza que quer continuar a encantar?" (`Store.EnchantView.sameAlertTip`) or "o novo encantamento irá substituir o velho encantamento, tem a certeza que quer continuar a encantar?" (`Store.EnchantView.newAlertTip`) | Re enchant confirmation (`EV:193-228`) | `EV` button | |
| `store.LifeSkillFrame` | none (class missing; the layout comment says life skill popup for learn, upgrade, forget) | Missing class | NPC option 33 | |

## 3. Routes (client to server)

Placement (workspace slot 0 equipment, slot 1 material) uses [store-frame.md](./store-frame.md) R1/R2 with these checks:
- Double click: SonType 236 -> slot 1, MasterType 1 -> slot 0; compatibility with the other slot (`CLK:139-168`).
- Drop: SonType 236 onto slot 0 -> "Tipo de equipamento incorrespondente"; equipment onto slot 1 -> "Tipo de acessório incorrespondente"; incompatible pair -> "Itens não compatíveis" (`DRP:305-350`).
- Compatibility `canEnchant(equip, material)`: `equip.Property2 == material.SonType` or `equip.SonType == material.Property2` (`CLK:274-290`, `DRP:431-447`).

### R1. Enchant equipment
- UI: `store.EnchantBtn` (`EV:193-220`).
- Client checks: both cells filled; if the equipment already has an enchant (`enchantSkillId != 0`), confirm: same skill family (`skill.MasterType == material.Property4`) -> `sameAlertTip`, else `newAlertTip` (`EV:202-219`).
- Sender: `EV.sendItemEnchant` -> `SSOM.sendEnchant(equipTemplateId)` (`EV:230-233`, `SSOM:268-275`).
- Route: client to server, 8971 (0x230b) `C_LIFE_SKILL_OP`, `simple.PropertyMsg`:
  - `param1` (#1, INT32) = 7 (`LIFE_SKILL_OP_ENCHANT`, `SSOM:31`).
  - `param2` (#2, INT32) = template id of the equipment in slot 0 (the client passes `templateId`, not the item id).
  - Unused: `param3` (#3, INT32), `param4` (#4, STRING), `param5` (#5, STRING), `param6` (#6, STRING), `param7` (#7, BOOL), `param8` (#8, BOOL), `param9` (#9, BOOL), `param10` (#10, INT32), `param11` (#11, INT32), `param12` (#12, STRING).
- Expected response: 115 (material consumed, equipment updated), 4788 `U_C_EQUIPMENT_ENCHANT` (S1), 3 / 4787 with the reduced life skill proficiency (help: "consumirá habilidade vitais").

### R2. Other life skill ops (no caller in this build)
All on 8971 `C_LIFE_SKILL_OP` with `simple.PropertyMsg.param1` = op (`SSOM:19-33,205-315`):

| op | Constant | Sender | Fields | Client check |
|---|---|---|---|---|
| 1 | `LIFE_SKILL_OP_MINING` | `sendLifeSkillCollect(nodeId)` / `sendOuterLifeSkillCollect(a, b, c)` | `param2` node, outer: `param3`, `param4` (STRING) | level >= 35 else "Nível insuficiente, a função só é ativada no nível 35." |
| 2 | `LIFE_SKILL_OP_COMPOSE` | `sendLifeSKillCompose(a, b)` | `param2`, `param3` | |
| 3 | `LIFE_SKILL_OP_LEARN` | `sendLifeSkillLearn(a, b)` | `param2`, `param3` | |
| 4 | `LIFE_SKILL_OP_UPGRADE` | `sendLifeSkillUpdate(a, b)` | `param2`, `param3` | |
| 5 | `LIFE_SKILL_OP_FORGET` | `sendLifeSkillForget(a, b)` | `param2`, `param3` | |
| 6 | `LIFE_SKILL_OP_COLLECT_CONFIRM` | `sendLifeSkillCollectConfirm(node)` / `sendOuterLifeSkillCollectConfirm(a, b, c)` | `param2`, outer: `param3`, `param4` | |
| 7 | `LIFE_SKILL_OP_ENCHANT` | R1 | `param2` | |
| 8 | `LIFE_SKILL_OP_SELECT` | `sendSelectNodeInfo(node)` | `param2` | level >= 35 (silent) |

The year box collection ops in the same class use another opcode, 8994 (0x2322) `C_NEW_YEAR_BOX_ACTIVE` (`sendYearBoxCollect`, `sendYearBoxCollectConfirm`, `searchYearBox`, `SSOM:317-346`), called from the map scenes; they are not smith and belong to [../seasonal-events/README.md](../seasonal-events/README.md) / [../world-map/README.md](../world-map/README.md).

## 4. Server messages (server to client)

### S1. 4788 (0x12b4) `U_C_EQUIPMENT_ENCHANT`
- Message `player.PlayerEnchantMsg`:
  - `skillId` (#1, INT32): enchant skill id applied.
  - `skillGrade` (#2, INT32): enchant level.
  - `skillProficiency` (#3, INT32): remaining life skill proficiency.
  - `pos` (#4, INT32): workspace slot of the equipment (0).
  - `objectId` (#5, INT32): object id (0).
  - `bagType` (#6, INT32): bag (0).
- Receiver: `EV.__enchantResultHandler` (`EV:179,257-276`): effect, re reads the workspace item at `pos`, hides the description, tip "Encantamento sucedido, elevamento dos atributos do equipamento!". A second handler `PM.__receiveEquipEnchantDataHandler` exists but is never registered (`PM:1843-1848`).
- When: response to R1 on success. Failure (help: "encantamento pode falhar (atributos não mudam)"): Assumption: 126 notice and no 4788.

### S2. 4787 (0x12b3) `U_C_LIFE_SKILL_UPDATE`
- No listener. Assumption: `player.PlayerLifeSkillMsg`: `skillId` (#1, STRING, comma list), `skillGrade` (#2, STRING), `skillProficiency` (#3, STRING), `collectCampaignId` (#4, STRING), `skillComposeTimes` (#5, INT32), `skillCollectTimes` (#6, INT32), `composeId` (#7, STRING).

### S3. 3 (0x0003) `U_C_PLAYER_INFO` life skill fields
- `player.PlayerMsg`: `skills` (#111, STRING), `skill_grade` (#112, STRING), `skill_proficiency` (#113, STRING), `skill_compose_times` (#115, INT32), `skill_collect_times` (#116, INT32), `composeId` (#117, STRING), `lastFreeSkillLearnTime` (#124, STRING). The model parses the comma lists into 5 fixed skill slots (ids 1..5) (`SM:501-554`, from `playerInfo.lifeSkillId`, `lifeSKillGrade`, `lifeSKillProficiency`). Owner of the message: [../hero/README.md](../hero/README.md).

### Item enchant display
- The enchant skill of an item is read from `SimpleItemInfoMsg.life_skill` (#38) and `ChatItemInfoMsg.life_skill` (#33) into `GoodsInfo.enchantSkillId` (`IH:69,100`), i.e. only for items viewed on other players or in chat. The own item message `item.ItemInfoMsg` has no such field, so the client cannot know the own equipment enchant (the R1 confirmation always takes the first branch). Open question.

## 5. Rules and formulas

- Life skill ids (`StoreModel`, `SM:193-209`): practice list 3, grind list 4, extraction list 5, jewelry 6, alchemy 7, enchant 8; skill types `JEWELY = 9`, `ENCHANT = 10`, `ALCHEMY = 11`. Unlock level 35 for life skills.
- Material lookup helper: enchant material of an equipment = template with SonType 236 and `Property2 == equipment Profile` (`EV:278-281`, unused).
- Compatibility rule: see section 3.
- Re enchant replaces the old enchant ("o novo encantamento irá substituir o velho encantamento"); a same family re enchant may fail and keep the old one.
- Cost: the material (1) and life skill proficiency (amount unknown).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | enchant materials SonType 236 | none in this build; expected `Property2` = equipment part / Profile, `Property4` = skill family |
| same | equipment | `Property2` / `SonType` for the compatibility rule |
| `raw/xml/tempinfos/SkillTempInfos.xml` | enchant skills | `MasterType` compared with material `Property4` (`TempleteManager.getSkillById`, `EV:208-210`); see [../skills/README.md](../skills/README.md) |

## 7. Persistent state

Only needed if the feature is restored.

```sql
CREATE TABLE smith.item_enchant (
    item_id         BIGINT   PRIMARY KEY REFERENCES inventory.items(item_id) ON DELETE CASCADE,
    skill_id        INTEGER  NOT NULL,
    skill_grade     SMALLINT NOT NULL DEFAULT 1,
    enchanted_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE smith.player_life_skills (
    player_id       BIGINT   NOT NULL REFERENCES player.players(player_id),
    skill_id        SMALLINT NOT NULL CHECK (skill_id BETWEEN 1 AND 5),
    grade           SMALLINT NOT NULL DEFAULT 1,
    proficiency     INTEGER  NOT NULL DEFAULT 0 CHECK (proficiency >= 0),
    learned_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, skill_id)
);
```

Log: `smith.operation_log` with `operation = 'enchant'` ([store-frame.md](./store-frame.md)).

## 8. Backend implementation notes

- `smith::enchant::handle_life_skill_op` (8971): dispatch on `param1`.
  - op 7 -> `smith::enchant::handle_enchant`: lock player; slot 0 equipment whose template id equals `param2`; slot 1 SonType 236 compatible; player has the enchant life skill with enough proficiency; roll success (rate unknown); on success set `smith.item_enchant`, consume material and proficiency; push 115, 4788, 3 (life skill fields).
  - ops 1..6, 8: reply 126 until the life skill UI exists (Assumption).
- Expose the enchant skill in the item info sent for other players (`SimpleItemInfoMsg.life_skill`) and in battle unit setup if enchant skills affect combat ([../battle/README.md](../battle/README.md)).

## 9. Open questions and assumptions

- Open: whether to restore the feature at all (no UI entry, no materials).
- Open: success rate, proficiency cost, and the enchant skill catalogue.
- Open: own item enchant is not carried by `item.ItemInfoMsg`.
- Assumption: `param2` (template id) is only a consistency check; the server uses workspace slot 0.

## 10. Implementation checklist

- [ ] Decide restore vs stub for life skills.
- [ ] Route R1 8971 op 7 enchant (or 126 stub).
- [ ] Route R2 8971 ops 1..6, 8 stubs.
- [ ] Server message S1 4788.
- [ ] Server message S3 life skill fields in 3.
- [ ] Rule: compatibility `Property2` / `SonType`.
- [ ] Tables `smith.item_enchant`, `smith.player_life_skills` (only when restored).
- [ ] Tests: incompatible pair, re enchant confirmation paths, missing life skill.
