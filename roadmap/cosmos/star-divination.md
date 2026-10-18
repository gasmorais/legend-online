# Star divination: crystals, temporary area, pick and sell, quick and auto astrology

Module `star-divination` of feature `cosmos`. Covers the "Astrologia" frame: rolling stars on five crystals, the 18 cell temporary area (bag type 0), collecting into the cosmos bag, selling, synthesis inside the temporary area, quick ("X-Adquirir Cosmos") and auto astrology, and the daily free count reset. Bag, equip slots and devour are in [star-equip.md](star-equip.md).

Path aliases:

| Alias | File |
|---|---|
| SM | `decompiled/core_module/scripts/yishi/manager/StarManager.as` |
| SMOD | `decompiled/core_module/scripts/mvc/module/star/StarModel.as` |
| SH | `decompiled/core_module/scripts/yishi/utils/StarHelper.as` |
| SC | `decompiled/core_module/scripts/mvc/controler/StarController.as` |
| V | `decompiled/m5/scripts/star/` |
| PMGR | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| PMOD | `decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerModel.as` |
| SHM | `decompiled/core_module/scripts/yishi/manager/SharedManager.as` |

## 1. Overview

| Concept | Client | Meaning |
|---|---|---|
| Bag types | `yishi/datas/consant/StarBagType.as:6-14` | -1 RECYCLE, 0 TEMP (temporary area), 1 PLAYER (cosmos bag), 2 THANE (equipped), 3 SUBLIME (sublimation slot) |
| Temporary area | `SM._tempStarList` keyed by `dropSite` (0..17) | `DisplayStarView.MAX_DISPLAY_STAR = 18` (`V/view/DisplayStarView.as:45`) |
| Crystals | `SM._randomPosList` (5 ints, 1 = usable) | index 0 "Estrela Mística", 1 "Estrela Angelical", 2 "Estrela Espiritual", 3 "Estrela Divina", 4 "Estrela de Deus" (`SMOD:24`) |
| Star quality | `StarTemplate.Profile` 1..8 | colors `#999999` 1 (shown as "Branco"), `#59cd41` 2 "Verde", `#32a2f8` 3 "Azul", `#a838f7` 4 "Roxo", `#ff8000` 5 "Laranja", `#ce0f0f` 6/7 (`SH:332-335`); 6 = energy stars (exp only), 7 = "Divino"/"Deus" red, 8 = "Sagrado" |
| Free uses | `PlayerInfo.starFreeCount` from `PlayerMsg.startFree` (#48) | "Hoje ainda pode aquirir {n} cosmos gratuitamente" |
| Astrology points | `PlayerInfo.starPoint` from `PlayerMsg.starpoint` (#57) | earned per roll, spent in [star-shop.md](star-shop.md) |
| Delete animation | `SMOD.delWay` 1 pick, 2 sell, 3 compose (`SMOD:18-22`) | client only |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/StarFrame.as` | "Astrologia" (`:58`) | container: crystals, temporary area, horoscope toggle, help | toolbar, hotkey H, `SwitchPageHelp`, day guide, task tip (controller `star` default openType, `SC:32-46`) | toggles the embedded `HoroscopeFrame` (`:113-130`); closing the frame (not via the horoscope toggle) auto collects all stars (`:196-199`) |
| `V/view/MakeStarView.as` | "Resgatar" button, crystal tips "Estrela da Fada ... Pontos de astrologia: {0} Custo para adquirir cosmos: {1}{2}" | five crystals, free count, star points | StarFrame | `starFreeCount`, `starPoint`, crystal enabled when `randomPosList[i] == 1` (`:218-248`), magic spring cost reduction (`:140-165`) |
| `V/view/DisplayStarView.as` | buttons quick star, quick compose, quick pickup, quick sell + quality combo, auto star, auto settings | temporary area of 18 `StarIconView` | StarFrame | temp stars; tips "Adquirir cosmos e vender cosmos brancos automaticamente", "Vende cosmos brancos e sintetiza os outros automaticamente", "Colher todos os cosmos de cor verde e superiores", "Vende cosmos do nível escolhido e os inferiores à ele" (`:91-97`) |
| `V/view/StarIconView.as` | "Colher", "Vender" | one temporary star | DisplayStarView | name colored by profile, tip; no "Colher" for Profile <= 1 (`:173-184`) |
| `V/AutoStarSetFrame.as` | "Astrologia automática" (`:72`) | choose auto budget, auto sell quality, auto compose quality | gear button (openType 3, `V/view/DisplayStarView.as:340-343`) | combos "100000 Ouro" / "1000000 Ouro" / "10000000 Ouro"; "Cosmos de nível Branco/Verde/Azul"; "Cosmos de nível Roxo/Laranja/Vermelho" (`:82-90`) |
| `star.StarHelpFrame` | "Explicação" | static help (`star.view.StarHelpFrame.helpContent`) | help button (`SC:60-64`) | |

## 3. Routes (client to server)

### R1. Roll on a crystal
- UI: click a crystal (`V/view/MakeStarView.as:250-274`).
- Client checks, in order: `starFreeCount <= 0 && gold < 20000` -> "Seu ouro está escasso, economize e volte uma próxima vez"; `starFreeCount <= 0 && gold < cost[i]` with `cost = [4000,5000,6000,8000,10000]` (`:89`) -> "Ouro insuficiente"; temporary area count >= 18 -> "Espaço cheio, colete ou venda para continuar". Disabled crystals (`randomPosList[i] != 1`) are not clickable (`:239`).
- Sender: `SM.sendRandomStar(i)` (`SM:351-357`).
- Route: C>S 8269 (0x204d) `C_STAR_RAND`, `StarRandReqMsg`: `site (#1, INT32)` crystal index 0..4.
- Response order: 4180 `U_C_STAR_RAND` (new crystal state in `site`, new temp star in `starRand`), 3 `U_C_PLAYER_INFO` with `startFree` (#48) and `starpoint` (#57) when changed, castle/resource update 109 with new gold when paid.

### R2. Quick astrology ("X-Adquirir Cosmos")
- UI: quick star button (`V/view/DisplayStarView.as:345-376`).
- Client checks: when hero level < `astrology_free_function_level[0]` (60) and not (active VIP with `VipGrade >= 1`) -> confirm "X-Adquirir Cosmos liberada no nível {0}\nVocê pode liberar o X-Adquirir Cosmos com VIP1. Deseja ativar o VIP?" which opens the VIP frame (`:352-363`, `:378-384`); temp count >= 18 -> "Espaço cheio, colete ou venda para continuar"; gold < 20000 -> "Seu ouro está escasso, economize e volte uma próxima vez".
- Route: 8269 `StarRandReqMsg.site = -1`.
- Server: roll repeatedly (assumption: always on the currently highest open crystal, as the original game did), auto selling Profile 1 stars, until the temporary area is full or gold is insufficient. Response: one or more 4180 (and 4179 for sold whites), 3, 109.

### R3. Collect one star ("Colher")
- UI: `StarIconView` pickup (`V/view/StarIconView.as:140-156`).
- Client checks: bag count >= `12 + starBagCount` -> "Mochila de cosmos está cheia, não é possível coletar". Button absent for Profile <= 1.
- Sender: `SM.sendStarPick(pos, 1)` (`SM:369-376`), `delWay = 1`.
- Route: C>S 8268 (0x204c) `C_STAR_PICK`, `StarPickReqMsg`: `dropsite (#1, INT32)` temp position 0..17; `way (#2, INT32)` 1 = pick.
- Response: 4179 with `starRand[0].dropSite = pos` (removes it from the temp area), then 4178 `U_C_START_MOVE_UPDATE` with the new bag 1 cell (see [star-equip.md](star-equip.md)).

### R4. Sell one star ("Vender")
- UI: `StarIconView` sell (`V/view/StarIconView.as:108-138`).
- Client checks: `grade > 1 || gp > 0` -> "Cosmos sintetizados não podem ser vendidos"; Profile >= 5 and != 6 -> typed confirmation "Vender {0}?" + "[YES]".
- Route: 8268 `dropsite = pos`, `way = 2`. `delWay = 2`; the client animates "Obtido {0} ouro" with `SellGold` plus the magic spring bonus (`V/view/DisplayStarView.as:224-249`).
- Response: 4179 (remove), 109 gold.

### R5. Collect all ("Colher todos")
- UI: quick pickup button (`V/view/DisplayStarView.as:386-395`); also automatic when `StarFrame` is closed by its close button (`V/StarFrame.as:196-199`).
- Client checks (`SMOD.checkAction(1)`, `SMOD:124-173`): temp empty -> "Não há cosmos, adquira cosmo primeiro" (only while the frame is open); bag count + collectable count > capacity -> warning "Mochila de cosmos está cheia, não é possível coletar" but still sends; bag already full -> same text and stop; no temp star with Profile > 1 -> "Não há cosmo a ser coletado".
- Route: 8268 `dropsite = -2`, `way = 0` (`SMOD:115-122`).
- Server: move every temp star with Profile > 1 to free bag cells in temp position order until the bag is full; Profile 1 stars stay. Response: 4179 listing removed positions, 4178 with the new bag cells.

### R6. Sell by quality
- UI: quick sell button with combo (1 "Branco", 2 "Verde", 3 "Azul"; persisted locally `SharedManager.starQuickSellType`, `SMOD:63-76`) (`V/view/DisplayStarView.as:397-406`).
- Client checks (`SMOD.checkAction(2, type)`, `SMOD:174-184`): at least one temp star with `Profile <= type && grade == 1 && gp == 0`, else "Não há cosmo que satisfaz as condições".
- Route: 8268 `dropsite = -1`, `way = type` (max Profile to sell).
- Server: sell all temp stars with `Profile <= way`, `grade == 1`, `gp == 0`, not locked. Response: 4179, 109.

### R7. Synthesis inside the temporary area
- UI: quick compose button (`V/view/DisplayStarView.as:408-513`).
- Client checks: temp count <= 1 -> "Não há cosmos disponíveis para síntese"; exp sum over unlocked Profile > 1 stars; target = an unlocked, non energy (Profile != 6) star below its max grade (the decompiled ternaries are no-ops, so the client effectively picks the last iterated candidate, `:424-445`); remaining exp <= 0 -> same message. Confirmation with a "não perguntar novamente" checkbox (`StarManager.isNotAlert`): "{star}" + "Consumirá todos os cosmos acima do nível branco, adicionando {0} pontos de experiência" + ", \n elevado ao Nv. {0}". Second typed confirmation "Certeza ao converter {0} em experiência?" when any other unlocked star has Profile >= 5 and != 6 (`:469-501`).
- Sender: `SM.sendQuickCompose(target.pos, 0)` (`SM:419-426`), `delWay = 3`.
- Route: C>S 8331 (0x208b) `C_STAR_COMPOSE`, `StarComposeReqMsg`: `pos (#1, INT32)` target temp position; `bag_type (#2, INT32)` 0.
- Server: sell every Profile 1 temp star, add `SH.getStarTotalExp` of every other unlocked star (Profile > 1) to the target, apply level ups (section 5), delete the consumed stars. Response: 4479 `U_C_STAR_COMPOSE` listing every surviving temp star (target and locked stars). Gold 109 for the whites sold.

### R8. Auto astrology
- UI: auto star button (`V/view/DisplayStarView.as:284-330`).
- Client checks: level < `astrology_free_function_level[1]` (80) and not (active VIP with `VipGrade >= 2`) -> confirm "Auto-Astrologia liberada no nível {0}\nVocê pode liberar a Auto-Astrologia com VIP2. Deseja ativar o VIP?"; budget = 100000 / 1000000 / 10000000 for `SharedManager.autoStarCostGold` 1 / 2 / 3; gold < budget -> "Seu ouro está escasso, economize e volte uma próxima vez".
- Sender: `SM.sendAutoStar(golden, sell, compose)` (`SM:359-367`).
- Route: C>S 8876 (0x22ac) `C_STAR_SPECIAL`, `StarVipEventMsg`: `golden (#1, INT32)` gold budget; `sell_max_quality (#2, INT32)` = `autoStarSell` 1..3 (sell temp stars with Profile <= value); `compose_max_quality (#3, INT32)` = `autoStarCompose + 3` = 4..6.
- Server: loop R1 on the best open crystal while spent gold < `golden`, gold suffices and the temp area has space; after each roll sell stars with Profile <= `sell_max_quality`; synthesize the remaining stars with Profile <= `compose_max_quality` into the best one (assumption, the client gives no further hint). Response: stream of 4180, 4179, 4479, then 3 and 109.

### R9. Auto settings (local only)
- `AutoStarSetFrame.__confirmBtnHandler` stores `autoStarCostGold`, `autoStarSell`, `autoStarCompose` in the Flash shared object per user (`V/AutoStarSetFrame.as:137-145`, `SHM:221-225,560-562,1210-1221`). No server route.

### R10. Daily data reset
- Trigger: client clock tick, every exact hour (`currentSysSecond % 3600 == 0`) when the hour is 5 (`PMOD:362-396`).
- Sender: `SM.sendResetStarData()` (`SM:437-441`).
- Route: C>S 8325 (0x2085) `C_STAR_DATA_RESET`, no body.
- Server: idempotent; if the 05:00 reset was not yet applied today, restore `free_count` and push 3 with `startFree`. The server must also apply the reset itself at 05:00 for offline players and at login (assumption: the request is only a nudge).

## 4. Server messages (server to client)

### S1. 4180 (0x1054) `U_C_STAR_RAND`, `StarRandRspMsg`
Receiver `SM.__starRandHandler` (`SM:193-258`, listener `SM:87`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `starRand` | #1 | `StarRandMsg` | yes | new or updated temp stars |
| `site` | #3 | INT32 | yes | crystal state, 5 entries, 1 = usable |

`StarRandMsg`: `dropSite (#1, INT32)` temp position 0..17; `starInfo (#2, StarInfoMsg)`.

`StarInfoMsg` (all star pushes): `id (#1, INT32)` unique star id; `template_id (#2, INT32)` `starTempInfos` id; `user_id (#3, INT32)` owner; `object_id (#4, INT32)` origin bag type (read as `oldBagType`, only meaningful in bag 3); `pos (#5, INT32)` cell; `exist (#6, BOOL)` unused by the client; `bag_type (#7, INT32)` 0..3; `grade (#8, INT32)` level 1..10; `gp (#9, INT32)` exp inside the current level; `is_lock (#10, BOOL)` synthesis lock.

Client reaction: the first 4180 ever received stores `site` as is (must be sent at login, `MakeStarView` reads `randomPosList.length` in its constructor, `V/view/MakeStarView.as:221-222`). Later ones compare index by index; for each changed index `openCrystal` toggles between that index and -1 and `RANDOMPOS_CHANGE` refreshes the crystals (`SM:211-226`). Each `starRand` entry creates or updates `tempStarList[dropSite]`; a new entry shows "Obtido {0} nível {1}" plus ", {0} habilitado" when a crystal was just opened (`V/view/DisplayStarView.as:183-200`).

When: login (full temp area and crystal state), after R1, R2, R8.

### S2. 4179 (0x1053) `U_C_STAR_PICK`, `StarRandRspMsg`
Receiver `SM.__starPickHandler` (`SM:169-191`). Only `starRand[].dropSite` is read: each listed temp position is removed (`addDictionary`/`deleteDictionary` events animate according to `delWay`). `site` and `starInfo` may be empty. When: after R3, R4, R5, R6, and inside R2/R8 for sold stars.

### S3. 4479 (0x117f) `U_C_STAR_COMPOSE`, `StarRandRspMsg`
Receiver `SM.__starQuickComposeHandler` (`SM:260-298`). For every star currently in the temp area: if an entry with `dropSite == star.pos` exists, the star is updated from `starInfo` and `COMPOSE_STAR` refreshes its icon; otherwise the star is deleted. The server must therefore list every surviving temp star. When: after R7 (bag 0). Do not send 4479 for a bag 1 synthesis (it would wipe the temp area).

### S4. 3 (0x0003) `U_C_PLAYER_INFO`, `PlayerMsg` (fields owned here)
Receiver `PMGR.__uPlayerInfoHandler` (`PMGR:496`, star fields `PMGR:1018-1029`): `startFree (#48, INT32)` -> `starFreeCount` (event `STAR_FREECOUNT_CHANGE`), `star_count (#43, INT32)` -> `starBagCount` extra bag cells, `starpoint (#57, INT32)` -> `starPoint` (event `STAR_POINT_UPDATE`). Send at login and whenever any of them changes.

### S5. 109 (0x006d) `U_C_CASTLE_UPDATE`
Gold balance after paid rolls and sales (owner: [currency](../currency/README.md)).

No result codes exist in these messages; on validation failure the server sends nothing (assumption: or a generic system tip used by other features).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Unlock | hero level >= 18 to open the frame | `decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:596-602`, `decompiled/core_module/scripts/yishi/SwitchPageHelp.as:1165-1175` |
| Roll cost | crystal i: `StarPickGold{i}` = 4000, 5000, 6000, 8000, 10000 gold, or one free use | `ConfigInfos.xml`, `V/view/MakeStarView.as:89` |
| Points per roll | crystal i: `StarPoint{i}` = 1, 2, 3, 4, 5 astrology points | `ConfigInfos.xml`, tips `V/view/MakeStarView.as:149-153` |
| Magic spring buffer 5 | cost shown reduced by `floor(AddValue * cost / 100)`; sell price shown increased by `floor(AddValue * SellGold / 100)` | `V/view/MakeStarView.as:156-165`, `V/view/DisplayStarView.as:226-232` |
| Free uses | `startFree` per day, reset at 05:00 | `PMOD:387-396` |
| Crystal chain | crystal 0 always usable (assumption); rolling on crystal i may open crystal i+1 ("Cada astrologia tem uma oportunidade de abrir a bola de cristal, quanto mais alta for a bola de cristal, mais chances tem de obter uma estrela rara") and consumes crystal i when i > 0 (assumption based on the toggle logic `SM:215-218`) | help text |
| Roll result | star template drawn from `starTempInfos` (Profiles 1..5 plus energy stars 4 and 5, Profile 6) with probabilities rising with the crystal index (assumption: no probability table ships with the client; design one server side); `NeedGrades` filters templates by hero level | `starTempInfos.xml` |
| Temporary area | 18 cells, positions 0..17 | `V/view/DisplayStarView.as:45` |
| Bag capacity | `12 + starBagCount` (max 18) | `SM:497-512` |
| Quick astrology gate | level >= 60 or VIP >= 1; gold >= 20000 | `V/view/DisplayStarView.as:352-374`, `astrology_free_function_level` |
| Auto astrology gate | level >= 80 or VIP >= 2; budget 1e5 / 1e6 / 1e7 | `V/view/DisplayStarView.as:294-329` |
| Sell price | `StarTemplate.SellGold` (1200 for Profile 1 ... 25000 Profile 8) | `starTempInfos.xml` |
| Sell allowed | `grade == 1 && gp == 0` (never synthesized) | `V/view/StarIconView.as:116` |
| Pick allowed | Profile > 1 | `V/view/StarIconView.as:177`, `SMOD:160-166` |
| Exp of a star | `SH.getStarTotalExp`: sum of `Data` of the profile upgrade rows with `Grades <= grade` + `gp` + template `SellGp`; Profile 8 counts as Profile 7 grade 10 with 91 extra | `SH:114-135` |
| Level up | upgrade rows by profile: 2 -> type 9, 3 -> 10, 4 -> 11, 5 -> 12, 6 -> 13, 7 -> 22; `Data` of row `Grades = g` is the exp needed to go from g-1 to g; carry over while `gp >= next.Data`; max grade = highest `Grades` (10, energy stars 2) | `SH:50-112`, `UpGradeTempInfos.xml` |

## 6. Templates

| File | Cate | Fields used |
|---|---|---|
| `starTempInfos.xml` (82 rows) | `TempleteManager.starTempalteCate` (`TempleteManager.as:1167`) | `TemplateId`, `MasterType` (attribute family, unique when equipped), `SonType`, `NeedGrades`, `TemplateName`, `Icon`, `Profile`, `SellGold`, `SellGp`, `StarPoint` (shop price), stats `Power`, `Agility`, `Intellect`, `Physique`, `Captain`, `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `ForceHit`, `Parry`, `Live`, `Conat`, `Penetrate`, `DefaultSkill` (buffer id for energy stars) |
| `UpGradeTempInfos.xml` | `TempleteManager.getTemplatesByType` | types 9, 10, 11, 12, 13, 22: `Grades`, `Data` (exp per level, e.g. type 9: 0, 50, 200, 600, 1200, 2400, 4800, 9600, 19200, 38400) |
| `ConfigInfos.xml` | `getConfigInfoByConfigName` | `StarPickGold0..4`, `StarPoint0..4`, `astrology_free_function_level` = "60,80" |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS cosmos;

-- Per player astrology state (fields of PlayerMsg owned by this feature).
CREATE TABLE cosmos.star_state (
  player_id        BIGINT   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  free_count       SMALLINT NOT NULL DEFAULT 0 CHECK (free_count >= 0),
  star_point       INTEGER  NOT NULL DEFAULT 0 CHECK (star_point >= 0),
  extra_bag_cells  SMALLINT NOT NULL DEFAULT 0 CHECK (extra_bag_cells BETWEEN 0 AND 6),
  crystal_sites    SMALLINT[] NOT NULL DEFAULT '{1,0,0,0,0}' CHECK (array_length(crystal_sites, 1) = 5),
  last_reset_on    DATE     NOT NULL DEFAULT CURRENT_DATE
);

-- Every star of every bag (temp 0, bag 1, equipped 2, sublimation 3).
CREATE TABLE cosmos.stars (
  star_id          INTEGER  GENERATED ALWAYS AS IDENTITY PRIMARY KEY,  -- StarInfoMsg.id is INT32
  player_id        BIGINT   NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id      INTEGER  NOT NULL,
  bag_type         SMALLINT NOT NULL CHECK (bag_type BETWEEN 0 AND 3),
  pos              SMALLINT NOT NULL CHECK (pos BETWEEN 0 AND 17),
  origin_bag_type  SMALLINT NOT NULL DEFAULT 0,   -- StarInfoMsg.object_id, used by bag 3
  origin_pos       SMALLINT,                      -- where to return from bag 3
  grade            SMALLINT NOT NULL DEFAULT 1 CHECK (grade BETWEEN 1 AND 10),
  gp               INTEGER  NOT NULL DEFAULT 0 CHECK (gp >= 0),
  is_locked        BOOLEAN  NOT NULL DEFAULT FALSE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE (player_id, bag_type, pos)
);
CREATE INDEX stars_player_bag ON cosmos.stars (player_id, bag_type);
```

Star ids must stay below 2^31 (protocol INT32). Stars are not inventory items; they never go to `inventory.items`.

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 8269 | `cosmos::star_divination::handle_rand` (site 0..4) and `handle_quick_rand` (site -1) |
| 8268 | `cosmos::star_divination::handle_pick` (dispatch on dropsite >= 0 / -1 / -2 and way) |
| 8331 bag 0 | `cosmos::star_divination::handle_temp_compose` (bag 1 goes to `cosmos::star_equip::handle_bag_compose`) |
| 8876 | `cosmos::star_divination::handle_auto_rand` |
| 8325 | `cosmos::star_divination::handle_daily_reset` |

- Login burst: 3 (star fields), 4178 with every star of bags 1, 2, 3, 4180 with `site` and all temp stars, 4677 troughs ([star-addition.md](star-addition.md)).
- R1 validation: level >= 18 -> site in 0..4 and `crystal_sites[site] == 1` -> temp count < 18 -> free_count > 0 or gold >= cost -> one transaction: decrement free or gold, add points, draw template, insert star (bag 0, first free pos), update crystal sites -> commit -> push 4180, 3, 109.
- R3..R6: lock rows of the player's stars `FOR UPDATE`; bag capacity `12 + extra_bag_cells`; locked stars are never sold.
- R2/R8 run the R1 loop server side in a single transaction per batch; cap iterations at the 18 cell limit.
- Daily reset job at 05:00 server time: `free_count = <daily free uses>` (assumption: value is server config, not in the client), `last_reset_on = today`; push 3 to online players.
- No battle.

## 9. Open questions and assumptions

- Assumption: number of daily free rolls (not in client templates).
- Assumption: crystal open/close probabilities and the star draw table per crystal (no template ships with the client).
- Assumption: quick astrology always rolls on the highest open crystal; auto astrology semantics of `compose_max_quality`.
- Assumption: 8325 only nudges the reset; the server owns the 05:00 schedule.
- The temp compose target picked by the client may not be the best star (decompiled no-op ternaries); the server must honor `pos` as sent.
- Assumption: rolls with Profile 1 results are allowed into the temp area (they can only be sold).

## 10. Implementation checklist

- [ ] Screens (client ready): `StarFrame`, `MakeStarView`, `DisplayStarView`, `StarIconView`, `AutoStarSetFrame`, help frame.
- [ ] Table `cosmos.star_state`, table `cosmos.stars`.
- [ ] Login burst: 3 star fields, 4180 with 5 `site` entries and temp stars.
- [ ] Route 8269 site 0..4 (cost, free count, points, crystal chain).
- [ ] Route 8269 site -1 quick astrology with VIP/level gate.
- [ ] Route 8268 pick one, sell one, collect all (-2), sell by quality (-1).
- [ ] Route 8331 bag 0 synthesis and 4479 full temp list.
- [ ] Route 8876 auto astrology with VIP/level gate and budget.
- [ ] Route 8325 and the 05:00 reset job.
- [ ] Push 4180, 4179, 4479, 3, 109.
- [ ] Rule: exp formula and level up per profile upgrade type.
- [ ] Tests: free roll does not cost gold; paid roll with insufficient gold rejected; temp area full rejects roll; collect all skips Profile 1 and stops at bag capacity; sell rejects synthesized stars; synthesis keeps locked stars and sells whites; 4479 lists all survivors; reset restores free count once per day.
