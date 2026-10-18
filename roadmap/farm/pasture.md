# Pasture ("Área de Pastagem")

Module `pasture` of feature `farm`. Livestock slots (`pos >= 1000`): adding animals, hunger, gloom and illness care, harvest, steal, sale, acceleration and one key harvest.

Path aliases:

| Alias | File |
|---|---|
| FM | `decompiled/core_module/scripts/farm/FarmManager.as` |
| FMO | `decompiled/core_module/scripts/farm/FarmModel.as` |
| FI | `decompiled/core_module/scripts/farm/data/FarmInfo.as` |
| FLI | `decompiled/core_module/scripts/farm/data/FarmLandInfo.as` |
| FAI | `decompiled/core_module/scripts/farm/view/FarmAnimalItem.as` |
| FAA | `decompiled/core_module/scripts/farm/view/FarmAnimalArea.as` |
| FAL | `decompiled/m3/scripts/farm/view/FarmAnimalLayer.as` |
| FOM | `decompiled/core_module/scripts/farm/view/FarmOperMenu.as` |
| FBCD | `decompiled/core_module/scripts/farm/cell/FarmBagCellDropMediator.as` |
| PV | `decompiled/m3/scripts/farm/newview/PastureView.as` |
| HF | `decompiled/m3/scripts/farm/newview/HomeFrame.as` |

## 1. Overview

Animals are items of SonType 1500 ("Cavalo Branco", "Cabra", "Touro de Leite", "Cervo") dropped onto the pasture area. Each occupies a server provided slot (`FarmLandInfoMsg.pos >= 1000`, kept in `FI.animalList`, `FI:162-213`). An animal grows from `feed_time` to `mature_time`, may become hungry, gloomy or ill, and when ripe produces "Leite de Cordeiro" (2131264). Animals are not consumed by harvesting (assumption: they restart a cycle until their feed limit is spent, see rules). The client wanders animals randomly in a 4 x 3 grid (`FAI:128-297`, display only).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `PastureView` (`PV`) | "Área de Pastagem" | pasture tab of `HomeFrame` | `HF` type 2 | capacity tip "Número de animais:{0}/{1}" (farm level >= 5) (`PV:149-165`), "Pastagem" board, Magic Spring buff 2 "Colheita da área de pastagem +{0}%" |
| `FarmAnimalLayer` / `FarmAnimalArea` (`FAL`, `FAA`) | "área de pastagem 1" | one area (type 0) with movement grid | `PV` | animals of `animalList` |
| `FarmAnimalItem` (`FAI`) | | one animal: markers hungry, anxious, ill, harvest; click action | `FAA` | `CropTip` with animal growth (`decompiled/m16/scripts/yishi/view/tips/CropTip.as:102-140`) |
| `FarmOperMenu` (`FOM`) | | own animal: "Acelerar", sell | `FAI:350-362` | sell price `SellGold` |

## 3. Routes (client to server)

All: C>S 15044 (0x3ac4) `CH_FARM_OPER_CHECK`, `FarmOperReqMsg` (fields in [farm-core.md](farm-core.md)), sender `FM.sendFarmOper` (`FM:635-651`). Response 4387 with the changed animal (`op_type`, `result`).

### P1. Add an animal (op 1 `ADD_ITEM`, pos >= 1000)
- UI: drag an animal from the "Armazém" onto the pasture area (`FBCD:128-146`).
- Client checks: item not SonType 1500 -> "este grão apenas pode ser plantado na fazenda"; no empty animal slot (`FI.hasAnimalPosByType`, first slot with `item_template_id = 0`, `FI:199-213`) -> "a área de pastagem está cheia".
- Fields: `friend_id` = own id, `op_type = 1`, `pos` = empty slot (>= 1000), `bag_pos` = bag slot, `template_id` = animal template.
- Server: consume the item, `feed_time = now`, `mature_time = now + Property1 min`. Response 4387, 115.

### P2. Feed (op 7 `FEED_LIVESTOCK`), comfort (op 4 `PACIFY`), cure (op 5 `CURE`)
- UI: click a hungry / gloomy / ill animal, own or friend (`FAI:306-320`), in that priority.
- Fields: `friend_id` = owner, `op_type`, `pos`.
- Server: clear the flag; feeding consumes "Ervas Frescas" (2131250, `Property6`) x `Property7` (5) from the caller's bag (assumption) and counts toward the help cap when on a friend farm. Response 4387; client tips "sucesso ao alimentar {0}", "sucesso ao confortar {0}", "sucesso no tratamento {0}" (`FM:863-934`).

### P3. Harvest (op 6 `REAP`) and steal (op 14 `STOLEN`)
- UI: click a ripe animal: own -> op 6; friend -> op 14 with the same checks as crops (already stolen, 3 steals, daily cap) (`FAI:321-345`).
- Response 4387, 115 (product), farm gp.

### P4. Sell (op 10 `CLEARCROP` on an animal)
- UI: menu sell button with confirm "ao vender este animal pode obter {0} ouro，confirmar a venda?" (`SellGold` = 200000) (`FOM:117-152`).
- Fields: `op_type = 10`, `pos` (>= 1000). Server: remove the animal, add `SellGold` gold. Response 4387, gold push.

### P5. Accelerate (op 9 on an animal)
- UI: menu "Acelerar": already accelerated -> "falha ao acelerar, a velocidade de criação do animal já foi acelerada"; confirm "para acelerar a velocidade de criação do animal por 50% precisa de consumir {0} diamantes, quer aumentar a velociade?" (10 diamonds) (`FOM:59-85`).
- Same as crop acceleration ([farmland.md](farmland.md) L6).

### P6. One key harvest (op 26 `ONE_KEY_ANIMAL`)
- UI: quick harvest on the pasture tab (`HF:183-186`) and secretary chore 8.
- Fields: `op_type = 26`, `friend_id` = selected farm owner.
- Server: feed, comfort, cure every animal that needs it (help caps on friend farms) and harvest or steal every ripe animal. Response 4387 with all changed animals.

## 4. Server messages (server to client)

4387 and 4190 as in [farm-core.md](farm-core.md). Animal specific fields of `FarmLandInfoMsg`: `feed_time` (#6) growth start, `is_gloomy` (#13), `is_ill` (#14), `is_hunger` (#16). The client does not read the animal level or feed count; growth bar uses `feed_time` to `mature_time` (`FLI:255-291`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | farm level 5 | `PV:155`, `farm.anima.animalContentTips` |
| Capacity | 3 at farm level 5, +1 per 5 farm levels, max 18 | `farm.anima.animalContentTips` |
| Animal templates | SonType 1500: `Property1` 480 min growth, `Property2` 2131264 "Leite de Cordeiro" output, `Property3` output count (30, "Touro de Leite" 150), `Property4` 60 (farm gp, assumption), `Property5` 9 feed limit ("Limite de alimentação"), `Property6` 2131250 "Ervas Frescas" feed item, `Property7` 5 (feed item count, assumption), `SellGold` 200000 | `ItemTempInfos.xml`, `decompiled/m16/scripts/yishi/view/tips/goods/SeedTip.as:174-181` |
| Feed limit | an animal produces up to `Property5` (9) cycles, then must be sold or removed (assumption) | `SeedTip.raisedCeilingTxt` |
| Special reward | `Farm_Special_Reward_Percent` = 100: chance (%) of a special extra reward on pasture harvest | `ConfigInfos.xml` |
| Ailments | gloom 30 %, illness 20 % chance, each costs 10 % yield (assumption, same config as crops); hunger when a cycle completes without feeding (assumption) | `farm_harmful_state_config` |
| Help caps | feed help 20 per day, harvest help 100 per day | `Farm_Today_HelpFeed_Count`, `Farm_Today_HelpReap_Count` |
| Experience | comfort, cure, feed: 1 each | `FMO:240-248` |
| No death | animals never die (`isDie` false for pos >= 1000) | `FLI:294-306` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ItemTempInfos.xml` SonType 1500 | animal | `Property1..7`, `SellGold`, `Profile` |
| `ItemTempInfos.xml` 2131264, 2131250 | product, feed | names, SonType 212 / 1501 |
| `ConfigInfos.xml` | constants | `Farm_Special_Reward_Percent`, help caps |

## 7. Persistent state

Animals live in `farm.plots` with `pos >= 1000` ([farmland.md](farmland.md)); columns `fed_at`, `is_gloomy`, `is_ill`, `is_hungry`, `feed_count` are animal specific. Slots are created as empty rows when capacity grows.

## 8. Backend implementation notes

| Opcode / op | Handler |
|---|---|
| 15044 op 1 (pos >= 1000) | `farm::pasture::handle_add_animal` |
| 15044 op 4 | `farm::pasture::handle_pacify` |
| 15044 op 5 | `farm::pasture::handle_cure` |
| 15044 op 7 | `farm::pasture::handle_feed` |
| 15044 op 6, 14 (pos >= 1000) | `farm::pasture::handle_harvest`, `farm::pasture::handle_steal` |
| 15044 op 9, 10 (pos >= 1000) | `farm::pasture::handle_accelerate`, `farm::pasture::handle_sell` |
| 15044 op 26 | `farm::pasture::handle_auto_harvest` |

- Dispatch ops 1, 6, 9, 10, 14 by `pos >= 1000` between farmland and pasture.
- Validation order mirrors farmland; help actions on friend farms consume the help counters.
- After harvest: increment `feed_count`; if below `Property5` restart (`fed_at = now`, new `mature_at`), else keep the animal ripe-empty until sold (assumption).

## 9. Open questions and assumptions

- Assumption: harvest does not consume the animal until its feed limit.
- Assumption: feeding consumes "Ervas Frescas".
- Unknown: the second animal area (`animalArea1`, `FAL:60-76`) is never created; area type strings "área de pastagem 2" are unused.

## 10. Implementation checklist

- [ ] Screens (client ready): `PastureView`, `FarmAnimalLayer`, `FarmAnimalArea`, `FarmAnimalItem`, `FarmOperMenu` (animal mode).
- [ ] Routes 15044 ops 1, 4, 5, 6, 7, 9, 10, 14, 26 for animals.
- [ ] Capacity growth on farm level up.
- [ ] Tests: 4th animal at farm level 5 refused; friend feed beyond 20 per day refused; sell credits 200000 gold; ripe animal stolen at most 3 times.
