# Pet growth: absorb, aptitude training, advance (growth), refine (compose), fusion (mix)

Path aliases:

| Alias | File |
|---|---|
| PSO | `decompiled/core_module/scripts/managers/PetSocketOut.as` |
| PD | `decompiled/core_module/scripts/mvc/module/pet/PetData.as` |
| PC | `decompiled/core_module/scripts/mvc/controler/PetController.as` |
| SW | `decompiled/m14/scripts/pet/swallow/PetSwallowView.as` |
| ST | `decompiled/m14/scripts/pet/strengthen/PetStrengthenView.as` |
| ADV | `decompiled/m14/scripts/pet/advanced/PetAdvancedView.as` |
| CMP | `decompiled/m14/scripts/pet/compose/PetComposeView.as` |
| MIX | `decompiled/m14/scripts/pet/mix/PetMixView.as` |

## 1. Overview

Five ways to grow a pet, each one a tab of the pet frame ([pets.md](pets.md)):

| Tab | pt-BR | op | Effect |
|---|---|---:|---|
| swallow | "Absorver" ("Einherjar" + "Sub-Einherjar") | 1 | Main pet gains 50 percent (or 100 percent paid) of the sub pet total EXP; sub pet is deleted. Help: "Ao absorver Einherjar poderá obter 50% de Experiência dos Einherjar absorvidos" |
| strengthen | "Fortalecer" with "Esfera de Energia" | 7 | Raises a random non full aptitude ("Força", "Proteção", "Inteligência", "Físico") toward its limit. Help: "Ao consumir esfera de energia pode adestrar a qualidade de einherjar" |
| advanced | "Evoluir"/"Avançar" with "Pedra do Crescimento" | 4 | Adds bless to the next internal quality step; at full bless the quality rises (higher aptitude limits and growth). Help: "Ao usar a Pedra do Espirito Sagrado pode avançar o Einherjar" |
| compose | "Refinar" (molde divino) | 13 | Tier 1 quality >= 4 pet becomes tier 2, tier 2 quality 5 becomes tier 3, inheriting part (or all, paid) of its quality and aptitudes |
| mix | "Fundir" | 15 | Two max quality pets of complementary elements fuse into a dual element pet (types 117..119) |

Unused senders exist for op 2 (add attribute points), op 3 (wash points, `pet_reset_att` 100 diamonds) and op 8 (resistance training) (`PSO:54-86,127-136`); no view calls them in this client.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SW` | "Einherjar" / "Sub-Einherjar" slots | Drag main and sub pets, preview grade after absorbing, checkbox "Consumir {0} Obterá 100% de EXP" | frame swallow tab (`decompiled/m14/scripts/pet/PetFrame.as:470-475`) | EXP 50 percent or 100 percent, preview grade (`SW:587-604,769-806`) |
| `ST` | strengthen tab | Train count input, cost tip "Sempre que fortalecer consumirá 10 diamantes ou 1 esfera de energia", owned count, aptitude bars | frame strengthen tab | `coe*` vs `coe*Limit` |
| `ADV` | advanced tab | Quality step bless bar, next quality preview, crit animation (blessing x5), count input, tips "A cada elevação consumirá {0} diamantes ou 1 Pedra do Espírito Sagrado"; also hosts the equipment bag (`V/advanced/PetEquipBagView.as`) | frame advanced tab | `curQualityGp`, quality tables |
| `CMP` | compose tab | Main pet slot, preview "Antes de Refinar"/"Depois de Refinar", materials, buttons refine, refine now (buy missing), full inherit "Consumir {0} Herdar totalmente" | frame compose tab | `PetComponseInfos.xml` rows with `Pet2Types = 0` (`PC:85-99`) |
| `MIX` | mix tab | Pet 1 slot, auto picked pet 2 of the complementary type, result preview, materials, fuse and fuse now | frame mix tab | rows with `Pet2Types != 0` (`PC:101-116`) |

## 3. Routes (client to server)

All: send 8621 (0x21ad) `C_PLAYER_PET_OP`, `PlayerPetOpMsg` (fields in [pets.md](pets.md)). Response for all: 4540 `U_C_PLAYER_PETINFO` with the changed pets (deleted ones with `isDel`), plus 115 `U_C_BAG_MOVE_UPDATE` for consumed items and currency pushes.

### R1. Absorb (op 1)
- UI: absorb button (`SW:338-388`).
- Client checks, in order: no main -> "Escolher Einherjar"; no sub -> "Escolher Sub-Einherjar"; sub has equipment -> "Ainda há equipamento no Einherjar que não pode ser absorvido"; sub locked -> `vicepassword.description4`; same pet -> ignore; sub fighting -> "Einherjar combatente, não é possível absorver"; sub practicing -> "Sub-Einherjar em prática, não é possível absorver"; main at max EXP (level 80 or level >= lord level with full bar) -> "Limite de experiência do Einherjar atingida"; EXP gained <= 0 -> "Absorvendo Sub-Einherjar não é possível obter experiência"; sub in arena team -> "Einherjar que encontram-se na equipe de batalha da Arena não podem ser absorvidos"; sub in expedition -> "Einherjar não pode ser absorvido na expedição de Einherjar de equipe" (`SW:411-439`).
- Confirms: bound main "Ao absorver, Sub-Einherjar desaparecerá, continuar?"; unbound main "Depois de Absoraver, o Sub-Einherjars irá desaparecer. O Enherjar principal será vinculado com a personagem, ..." (`SW:482-498`); sub guarding the farm "Sub-Einherjar está em estado de proteção" (`SW:471-480`); 100 percent EXP "Deseja consumir {0} diamantes obtendo 100% de EXP? (usando prioritáriamente{1})" (`SW:441-469`).
- `pay_type` (`SW:520-545`): -1 normal (50 percent); 3 when the player owns "Pedra da Herança" 208029; else 2 (bound diamonds allowed) or 1 (diamonds only) with cost `swallow_fullgp_points` = 50; insufficient diamonds opens recharge (`SW:547-560`).
- Request: op 1, `pet_id` main, `value` sub pet id, `pay_type`.
- Server: EXP = `floor(sub.total_exp * 0.5)` or `sub.total_exp` when paid; add to main, level up with `Types=25` up to `min(80, lord level)` (`SW:769-806`); delete sub; bind main; remove sub from monopoly formation.

### R2. Train aptitudes (op 7)
- UI: train button (`ST:323-345`), confirm "Deseja usar {0} {1} ou {2} diamantes para fortalecer?\n(Prioridade de uso {3})" (`ST:347-358`), optional bound goods confirm (`ST:385-462`).
- Client checks: 500 ms click throttle; all aptitudes at limit -> "Classificação máxima atingida do Einherjar" (`PD.isFullRes`, `PD:1275-1282`); without goods, diamonds >= `pet_up_apt` (5) * count else recharge (`ST:479-507`).
- Goods: "Esfera de Energia de Einherjar" 3040001, tier 3 pets use "Esfera de Energia Avançada" 3040002 (`ST:385-416,538-566`).
- Request: op 7, `pet_id`, `value` = times, `pay_type` 0 (bound diamonds allowed) / 1, `item_pos` = goods mode 0 any, 1 bound only, 2 unbound only.
- Server: per time consume 1 goods (or 5 diamonds), add aptitude points to a random aptitude below its limit (amount: assumption, server table).

### R3. Advance growth (op 4)
- UI: advance button (`ADV:363-385`), confirm "Deseja usar {0} {1} ou {2} diamantes para evoluir?" (`ADV:386-397`).
- Client checks: 400 ms throttle; no next quality template -> "Benção máxima atingida, não é possível avançar" (`ADV:379-384`); diamonds >= `pet_up_quality` (5) * count when no goods (`ADV:522-550`).
- Goods: "Pedra do Crescimento" 208023, tier 3 "Pedra de Crescimento Avançada" 208045 (`ADV:430-440,555-578`).
- Request: op 4, `pet_id`, `value` = times, `pay_type`, `item_pos` = goods mode.
- Server: per time add bless to `quality_bless` (with a chance of blessing x5, "Probabilidade de surgir efeito de benção (5x exp obtida)"); when bless >= `Data` of the next quality row, raise internal `quality` by 1 and carry the remainder; recompute aptitude limits and growth.

### R4. Refine / divine mould (op 13)
- UI: refine (`CMP:288-332`), refine now (`CMP:334-382`), full inherit option (`CMP:426-466`).
- Client checks (`CMP:784-829`): tier 1 needs lord level >= 50 ("Personagem com nível {0} ou superior pode proceder proceder à refinação divina de [{1}]") and quality >= 4 ("Poderá efetuar molde divino no einherjar [{0}] roxo ou laranja"); tier 2 needs `VersionSwitch.SENIOR_PETCOMPOSE` and quality 5 ("...[{0}] laranja"); tier 3 refused ("Einherjars avançados não poderão fazer a refinação divina"); gold >= `NeedGold`; materials present (normal) or diamonds for missing items at shop `GiftToken` price ("Itens insuficientes, deseja consumir {0} diamantes para refinar já."); tier 2 pets without full aptitudes get "Depois de refinar alma divina avançada, não pode usar Esfera de Energia de Einherjar para aumentar a qualidade, deseja continuar?". Drag checks also refuse fighting, practicing, arena team, expedition and equipped pets (`petCompose.*`, `pet.inPetChanglle3`, `pet.inRemotePet3`, `pet.inPetChanglle6`).
- Request (after the animation, `CMP:683-700`): op 13, `pet_id`, `skillId` = compose type (-1 normal inherit, 1 full inherit paying `fuse_pet_points` = 200 diamonds (`PC:58-71`), 2 buy missing materials), `pay_type` (0 for -1/1; 1 or 2 for type 2).
- Server: find the row by (`PetType`, tier, quality); consume items and gold; replace the template with (`ResultPetTypes`, `ResultPetGrade`, `ResultQuality`); inherit quality and aptitudes "por uma certa percentagem" (assumption: ratio server side; 100 percent with type 1).

### R5. Fusion (op 15)
- UI: fuse (`MIX:456-530`), fuse now (`MIX:532-602`).
- Client checks (`MIX:401-428,456-530`): pet 1 type in 101..106, level >= tier, all aptitudes full, quality 5 (tier 2) or 6 (tier 3); a matching pet 2 exists ("Nenhum einherjar que satisfaz as condições"); neither locked ("Einherjar travado, não é capaz de efetuar fusão"); both full aptitudes ("Qualificação de Einherjar não atingiu o limite máximo, não pode fundir"); materials ("Materiais insuficientes, não pode fundir"); lord level ("Nível do personagem insuficiente, não pode fundir"); diamonds `NeedPoint` (`point + giftToken`). Confirm "Deseja consumir {0} diamantes para fundir {1} e {2} para {3}?" (`pet.PetMixView.ConfiramMix` / `ConfiramMixMixedPet`).
- Request (after the animation, `MIX:670-690`): op 15, `pet_id` pet 1, `value` pet 2 id, `skillId` = mix type (0 normal, 2 buy missing materials), `pay_type` 1 or 2.
- Server: both pets consumed, one new dual element pet (`ResultPetTypes` 117..119) created with full aptitudes (assumption).

## 4. Server messages (server to client)

| Opcode | Message | Fields used | Receiver | When |
|---|---|---|---|---|
| 4540 (0x11bc) `U_C_PLAYER_PETINFO` | `PlayerPetMsg` | `petInfo` rows: `cur_gp`, `cur_grade`, `total_gp`, `quality`, `curQualityGp`, `*Apti`, `growthRate`, `template_id`, `isDel`, `isBind`, `fightingCapacity` (full list in [pets.md](pets.md)) | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1474-1567` | After every route |
| 115 (0x0073) `U_C_BAG_MOVE_UPDATE` | inventory | consumed goods | GoodsManager | When goods are used |

Views refresh through `PetData` `PETINFO_CHANGE` and bag events (`ADV:552-580`, `ST:509-513`).

## 5. Rules and formulas

- Absorb EXP: `floor(total_exp * 0.5)` (`EXP_TRANSFORM_RATIO` 0.5, `PD:33`, `SW:587-604`), 100 percent with payment. Level cap `min(80, lord level)`.
- Aptitude limit for internal quality q (`PD.calculateCoeLimit`, `PD:273-362`): let `Q = display quality(q)`, `S = star(q)`, `step = Q == 5 ? 10 : 5`, `t0` = template (same type and tier, quality Q), `t1` = next quality template; `limit = t0.Init*CoeLimit + int((t1.Init*CoeLimit - t0.Init*CoeLimit) / step) * (S - 1)` (last quality: `t0` value). Growth uses `GrowthRate` the same way. `PetTempInfos.xml` `*Apt` columns are "min,max" (assumption: `InitPowerCoeLimitMin`, `InitPowerCoeLimit`).
- Auto aptitude bonus from quality advance: `(1.2^(quality - initQuality) - 1) * template InitPowerCoeLimitMin` (`PD:891-933`).
- Advance tables: `UpGradeTempInfos` `Types=27` (tier 1), `29` (tier 2), `107` (tier 3) (`PD:229-246`); row `Grades` = internal quality, `Data` = bless needed (10, 20, 30 .. 35000 at 21; tier 3 up to 38000 at 31). Next step = row `quality + 1`; none for tier < 3 at quality 30 (`PD:1261-1273`). `QUALITY_LEVEL_UP_SER` 0.02 (`PD:35`) is a client constant (assumption: bless crit related).
- Prices: `pet_up_apt` 5 diamonds per aptitude train, `pet_up_quality` 5 per advance (client default 10), `swallow_fullgp_points` 50, `fuse_pet_points` 200 (client default 200) (`ConfigInfos.xml`).
- Refine recipes `PetComponseInfos.xml` (34 rows). Examples: id 1: type 101 tier 1 quality 4 + 2125051 "Lágrima Estrelar - Fogo" x10 + 2125057 "Areia Estrelar" x1000 + 5000000 gold -> 101 tier 2 quality 4; id 13: 101 tier 2 quality 4 + 2125123 x500 + 2125124 x500 + 5000000 gold -> tier 3; types 105/106 also need 2125059 "Fragmento Divino" x500 (tier 1) or 2125125 x500 (tier 2); dual types 117..119 tier 2 -> 3 need x5000 materials and 50000000 gold.
- Fusion recipes: 105 + 106 (Escuridão + Luz) -> 117; 102 + 104 (Água + Vento) -> 118; 101 + 103 (Fogo + Choque) -> 119; tier 2 quality 5 pairs give tier 2 quality 5, tier 3 quality 6 pairs give tier 3 quality 6; materials 2125126, 2125127 and an element item (2125128, 2125130, 2125134); `NeedPoint` 20000.

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/PetTempInfos.xml` | aptitude ranges, growth, tier, quality |
| `raw/xml/tempinfos/PetComponseInfos.xml` | `Pet1Types`, `Pet1Grade`, `Pet1Quality`, `Pet2Types`, `Pet2Grade`, `Pet2Quality`, `NeedItemTempId1..3`, `NeedItemTempIdCount1..3`, `NeedGold`, `NeedPoint`, `ResultPetTypes`, `ResultPetGrade`, `ResultQuality` |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `Types` 25 (level), 27/29/107 (quality bless) |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208023, 208045, 3040001, 3040002, 208029, 2125051..2125134 |
| `raw/xml/tempinfos/ConfigInfos.xml` | `pet_up_apt`, `pet_up_quality`, `swallow_fullgp_points`, `fuse_pet_points`, `pet_reset_att` |

## 7. Persistent state

Updates `einherjar.pets` ([pets.md](pets.md)). Optional audit:

```sql
CREATE TABLE einherjar.growth_log (
  log_id      BIGSERIAL   PRIMARY KEY,
  player_id   BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pet_id      BIGINT      NOT NULL,
  op_type     SMALLINT    NOT NULL CHECK (op_type IN (1, 4, 7, 13, 15)),
  detail      JSONB       NOT NULL DEFAULT '{}',
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX growth_log_player_idx ON einherjar.growth_log (player_id, created_at);
```

## 8. Backend implementation notes

- `einherjar::growth::handle_swallow` (op 1): ownership of both -> server side copies of the client checks (lock, fight, practice, arena team, expedition, equipment, full EXP) -> payment by `pay_type` -> transaction: delete sub, add EXP, bind main -> push 4540 (main + sub `isDel`), 115 or diamonds.
- `einherjar::growth::handle_train_coe` (op 7): not full -> loop `value` times consuming goods by `item_pos` mode then diamonds by `pay_type` -> random aptitude gain capped by limit -> push 4540, 115.
- `einherjar::growth::handle_train_growth` (op 4): next row exists -> loop: consume, add bless (crit x5), level quality -> push 4540, 115.
- `einherjar::growth::handle_compose` (op 13): recipe lookup, checks, payment for missing items (type 2) or full inherit (type 1) -> replace template -> push 4540.
- `einherjar::growth::handle_mix` (op 15): recipe lookup by the pair, checks, diamonds -> delete both, create result -> push 4540 (two `isDel` + new pet).
- Remove consumed pets from every formation string (arena, monopoly, guild boss, etc.).
- Recompute `fight_capacity` after each change; fighting pet changes affect the lord fighting capacity (hero feature).

## 9. Open questions and assumptions

- Aptitude gain per train and bless per advance (server tables not in the client).
- Inherit ratio for normal refine.
- Meaning of `pay_type` 0/1/2 across ops: 0 = bound diamonds allowed (gift token first), 1 = diamonds only, 2 = "use bind" in alerts (swallow, compose, mix use 1/2 from the alert checkbox); verify per handler.
- Whether swallow requires main and sub of any tier.

## 10. Implementation checklist

- [ ] Screen: swallow, strengthen, advanced, compose, mix tabs
- [ ] Route op 1 absorb with pay types -1/1/2/3
- [ ] Route op 7 aptitude training
- [ ] Route op 4 growth advance with bless and crit
- [ ] Route op 13 refine with types -1/1/2
- [ ] Route op 15 fusion with types 0/2
- [ ] Rule: aptitude limits per internal quality
- [ ] Rule: quality bless tables 27/29/107
- [ ] Rule: recipes from `PetComponseInfos.xml`
- [ ] Table `einherjar.growth_log` (optional)
- [ ] Tests: absorb EXP cap by lord level, refine tier checks, fusion pairing
