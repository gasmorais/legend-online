# World map: castle raids, army PvP and protection

Area: world-map, module `castle-pvp`. Covers attacking another player's castle ("saquear", 5160 on a castle cell), attacking another player's hero army on the map (8488), the daily attack counter (5 per day), castle protection ("Placa de Isenção de Batalhas", 4452, 118, 8562), the castle info frame and the post battle gains (4382).

Conventions: see [scene.md](scene.md).

## 1. Overview

From level 8 a player may raid other castles on the outer city. A raid is a two step action: choose "Ataque" in the castle menu (checks and the "Informações de Ataque" window with the remaining daily attacks), the army walks to the castle, then "Atacar" in the castle info frame sends 5160. The server starts a battle against the defender's garrison (hero and troops), applies plunder and sends the gains (4382) when the attacker returns to the map. Players can also hunt other heroes' armies with the attack cursor (key X): the army chases the target and, within 50 px, sends 8488. A castle under protection cannot be raided; attacking anyone removes the attacker's own protection.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `PhysicsMenu` on a castle (`M3/map/internals/view/displaye/PhysicsMenu.as:281-308`) | "Ataque", "Adicionar Amigo", "Enviar Email" (other castle); "Entrar no Castelo" (own); "Transferir" (empty site) | Castle radial menu | `MapPhysicsCastle.mouseClickHandler` (`M3/map/outercity/view/mapphysics/MapPhysicsCastle.as:55-78`) | |
| `outercity.AttackCastleAlertFrame` (`TodayNotAlertFrame`) | "Ao atacar outro jogador, seu efeito de proteção será anulado, continuar?" with "do not show today" | Shown once per day when the attacker is protected | `MapPhysicsCastle.showAttackAlert` (`:239-260`) | |
| `outercity.AttackAlertFrame` (`M3/map/outercity/view/frame/AttackAlertFrame.as`) | "Informações de Ataque", buttons "Atacar" / "Cancelar" | Confirms the raid and shows remaining attacks | `MapPhysicsCastle.attack` (`:164-219`) | "{castle name}({MapName} x,y)" in UI units, "{attackCount}/5" |
| `CityInfoFrame` / `CityInfoView` (`M3/map/outercity/view/frame/CityInfoFrame.as`, `M3/map/internals/view/frame/CityInfoView.as`) | "Informações do Castelo"; "Líder:", "Guilda:" ("Nenhum"); button "Atacar" (other), "Cidade" (own), "Transferir" (empty, no action) | Castle details; final attack button | Arrival at a castle (`OuterCityController.as:603-611`) or menu "Detalhes" | castle name, cell, owner, guild, VIP skin; owner ids ≥ 1900000000 show "Servidor Ocupado" on name click (`CityInfoView.as:98-108`) |
| Attack cursor (`PVP_ATTACT_CURSOR`) | "Atacar outro jogador \nAtalho:X" | Select an enemy army | Minimap attack button or key X (`CM/mainBar/SmallMapBar.as:1114-1122, 1166-1173`, `M3/map/outercity/mediator/mapview/OuterCityPkMediator.as:81-87`) | target marker on the chased army |
| `BattleGetMoviesAction` (`CM/yishi/actions/map/BattleGetMoviesAction.as`) | floating gains | Shows gold, experience, strategy gains over the army | 4382 | `FightOverMoiveMsg` |
| Protection buffer icon (template 2001, item 208006) | "Placa de Isenção de Batalhas" | Remaining protection time | `PlayerBufferManager.__updateDefenceTimeHandler` (`CM/yishi/manager/PlayerBufferManager.as:88-122`) | `defence_lefttime` |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| C1 | Castle menu "Ataque" → (protection notice) → "Informações de Ataque" "Atacar" → walk; then castle info "Atacar" | `MapPhysicsCastle.attack` (`MapPhysicsCastle.as:164-237`) → walk; `CityInfoFrame.__attackHandler` (`CityInfoFrame.as:30-45`) → `OuterCityController.sendAttack` (`M3/map/outercity/OuterCityController.as:657-666`) → `OuterCitySocketOutManager.sendAttack` (`M3/map/outercity/manager/OuterCitySocketOutManager.as:81-89`) | attacker level ≥ 8 (`MapPhysicsCastle.as:62-67`); target occupied ("Castelo inimigo foi transferido"); `abs(attacker level - castle grade) < 10` ("Diferença de nível maior que 10, não é possível saquear"); target `defenceLeftTime == 0` ("Alvo está em estado de proteção"); not the same guild name ("Não é possível atacar membros da mesma Guilda"); castle `state != 4` ("Alvo está em combate"); not already walking to attack it ("Atacando alvo"); own army usable (AM8 in [army-movement.md](army-movement.md)); `attackCount > 0` ("Ataques gratuitos de hoje atingiu limite") | C>S 5160 0x1428 `U_C_ARMY_ATTACK` | `MapPhysicAttackMsg` (worldmap): `map_id (#1, INT32)` shown world, `pos_x (#2, INT32)`, `pos_y (#3, INT32)` castle cell | Battle start (157, battle protocol) with battleType 4 (assumption); 140 type 2 castle `state 4` to viewers; after the battle 4382 and 3 (`attack_left_count`) |
| C2 | Attack cursor on an enemy army, chase until 50 px | `ArmyView.mouseClickHandler` (`M3/map/outercity/view/mapphysics/ArmyView.as:1277-1293`) → `OuterCityModel.selectPkArmy` (`CM/map/outercity/OuterCityModel.as:95-117`) → `OuterCityPkMediator.enterFrame` (`OuterCityPkMediator.as:134-188`) → `OuterCitySocketOutManager.sendPvpAttack` (`OuterCitySocketOutManager.as:64-70`) | target not in the attacker's guild (by guild id); target army `state != 2` ("Alvo está em combate"); the chase re-targets every 25 frames; distance < 50 px | C>S 8488 0x2128 `C_WORLDMAP_PVPFIGHT` | `ChallengeMsg` (player): `tar_userId (#1, INT32)` target player; `tar_armyId (#2)`, `pay_type (#3)`, `type (#4)`, `uuid (#5)` unset | Battle start (assumption battleType 4 or 5); armies set to state 2 (140 type 3) |
| C3 | Protection buffer timer reaches 0 on the client | `PlayerBufferManager.removeBuffer` (`PlayerBufferManager.as:368-385`) | buffer template 2001 | C>S 8562 0x2172 `C_CASTLE_TIME_CANCEL` | no body | 4452 with `defence_lefttime` 0 (assumption) |
| C4 | Use item 208006 "Placa de Isenção de Batalhas" | inventory item use ([../inventory/item-usage.md](../inventory/item-usage.md)) | item owned | item use route | | 4452 to the owner, 118 to viewers |
| C5 | Castle menu "Adicionar Amigo" / "Enviar Email" | `MapPhysicsCastle.addFriend` / `writeEmail` (`:80-88`) | | friends / mail routes | | owned by [../friends/README.md](../friends/README.md), [../mail/README.md](../mail/README.md) |

Unused: `OuterCitySocketOutManager.setAddAttackCount` (9506 `C_CASTLE_ATTACK`) and 5021 `U_C_PLAYER_ADD_ATTACKCOUNT` have no sender; config `AddAttck_Point = 100` ("【外城】增加掠夺次数", diamonds per extra attack) and text "ao aumentar mais uma chance de ataque, irá consumir {0} diamantes." are present but not wired.

## 4. Server messages (server to client)

| Opcode | Message | Receiver | When | Client reaction |
|---|---|---|---|---|
| S>C 4382 0x111e `U_C_PLAY_GETMOIVE` | `FightOverMoiveMsg` (simple): `gp (#1, INT32)` experience, `gold (#2, INT32)`, `strategy (#3, INT32)` | `OuterCityManager.__playGetMovieHandler` → buffered for `OUTER_CITY_SCENE` → `playGetMovie` (`CM/map/outercity/manager/OuterCityManager.as:188-200`) | After a world map battle won by the player (castle raid, army fight, wild land) | Queues `BattleGetMoviesAction` on the own army: floating gold, exp, strategy (`BattleGetMoviesAction.as:23-82`) |
| S>C 4452 0x1164 `U_C_CASTLE_TIME` | `BaseCastleMsg`: only `defence_lefttime (#11)` read | `PlayerBufferManager.__updateDefenceTimeHandler` (`PlayerBufferManager.as:85-122`) | Own protection changed (item use, attack removes it, expiry) | Sets own `defenceLeftTime`; adds or removes buffer 2001 (goods 208006) and its timer |
| S>C 118 0x0076 `U_C_CASTLE_DEFENSE` | `CastleDefenseRspMsg`: `pos_x`, `pos_y`, `left_time` | `OuterCityController.__updateStatusHandler` (`OuterCityController.as:1096-1110`) | Protection change of a castle, to viewers of its chunk | Updates the castle at that cell (and, as coded, the own `defenceLeftTime` too: send 118 only for the own castle to its owner, or accept the client quirk) |
| S>C 3 `U_C_PLAYER_INFO` | `PlayerMsg.attack_left_count (#22, INT32)` | `PlayerManager` (`CM/yishi/manager/PlayerManager.as:887`) | After each raid and at login | Updates `attackCount` (AttackAlertFrame shows "{n}/5") |
| S>C 4202 0x106a `U_C_DATARESET` | `DataResetMsg` (player): `attack_count (#4)`, `trans_energy (#3)`, and other daily counters | `BaseManager.__resetDataHandler` (`CM/yishi/manager/BaseManager.as:1874-1900`) | Daily reset (0h) | Resets `attackCount` to the new value and the Transmissor energy |
| S>C 140 types 2, 3 | castle `state 4` during a raid, army `state 2` during fights | [scene.md](scene.md) | Battle start and end | Combat icons, menus refuse new attacks |
| Battle | 157 and the battle protocol | [../battle/README.md](../battle/README.md) | | Exit to `OUTER_CITY_SCENE` with `MapInitData` at the army position for battleType 1 to 5 (`CM/battle/handler/BattleResultHandler.as:172-177`) |

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| CP1 | Attacks per day: `Player_AttackCount = 5` (config), shown as "{n}/5"; reset at 0h by 4202. | `raw/xml/tempinfos/ConfigInfos.xml`, `AttackAlertFrame.as:104-126` |
| CP2 | Raid gates: attacker level ≥ 8, level gap < 10, target not protected, not same guild, castle not under attack, army usable, attacks left. Server must recheck all of them. | `MapPhysicsCastle.as:55-237`, `CM/map/outercity/OuterCityModel.as:517-560` |
| CP3 | Army PvP gates: not same guild id, target not in state 2, distance < 50 px; level ≥ 15 for the attack button. | `OuterCityPkMediator.as:134-188`, `OuterCityModel.as:95-117`, `SmallMapBar.as:629-640` |
| CP4 | Protection: item 208006 grants 8 hours ("Após utilizado, não sofrerá ataques de outros jogadores por 8 horas, perderá efeito se atacar outro jogador"); any raid or army attack by the protected player cancels it (client warns once per day). | `raw/xml/tempinfos/ItemTempInfos.xml` (208006), `MapPhysicsCastle.as:206-210, 239-276` |
| CP5 | Castle state 4 = under attack; only one raid at a time per castle (assumption). | `MapPhysicsCastle.as:193-198` |
| CP6 | Plunder and rewards are server side; the client only shows `gp`, `gold`, `strategy` of 4382 and the battle result. Assumption: gold plunder = a percentage of the defender's stored gold capped by the attacker's storage (owned by [../castle/resources.md](../castle/resources.md)). | `BattleGetMoviesAction.as` |
| CP7 | Owner ids ≥ 1900000000 are system castles ("Servidor Ocupado"). | `CityInfoView.as:98-108` |

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Player_AttackCount` 5, `AddAttck_Point` 100 |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208006 protection item |

## 7. Persistent state

```sql
CREATE TABLE world_map.daily_attacks (
    player_id        BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    day              DATE NOT NULL,
    attacks_used     SMALLINT NOT NULL DEFAULT 0 CHECK (attacks_used >= 0),
    attacks_bought   SMALLINT NOT NULL DEFAULT 0 CHECK (attacks_bought >= 0),
    PRIMARY KEY (player_id, day)
);

CREATE TABLE world_map.castle_raids (
    raid_id          BIGSERIAL PRIMARY KEY,
    attacker_id      BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    defender_id      BIGINT REFERENCES player.players(player_id) ON DELETE SET NULL,
    kind             TEXT NOT NULL CHECK (kind IN ('castle','army')),
    site_id          INTEGER REFERENCES world_map.castle_sites(site_id),
    battle_id        BIGINT,
    winner_id        BIGINT REFERENCES player.players(player_id),
    gold_plundered   BIGINT NOT NULL DEFAULT 0,
    exp_gained       INTEGER NOT NULL DEFAULT 0,
    strategy_gained  INTEGER NOT NULL DEFAULT 0,
    started_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
    finished_at      TIMESTAMPTZ
);
CREATE INDEX castle_raids_defender_idx ON world_map.castle_raids (defender_id, started_at DESC);
```

Protection uses `world_map.castle_sites.protected_until` ([scene.md](scene.md)).

## 8. Backend implementation notes

- `world_map::castle_pvp::handle_attack` (5160) is the shared attack entry: find the entity at (`map_id`, `pos_x`, `pos_y`): castle site → this module; wild land → [wild-lands.md](wild-lands.md). For castles: validate CP2 (army within 100 px of the castle, assumption), consume one attack (`daily_attacks`), clear the attacker's protection (4452 to self, 118 to viewers), set the castle `state 4` and army `state 2` (140), insert `castle_raids`, start the battle (attacker hero and army vs defender hero and garrison, battleType 4, map `MapInfos.BattleGround` of the world). On end: compute plunder (castle resources API), reward exp, set states back, push 3, 4382 to the attacker, 140 to viewers, mail a battle report to the defender ([../mail/README.md](../mail/README.md)).
- `world_map::castle_pvp::handle_pvp_fight` (8488): target online on the same world, within 60 px of the attacker's stored position, not same guild, not in battle; same battle flow with `kind = 'army'` (assumption: consumes no daily attack).
- `world_map::castle_pvp::handle_protection_cancel` (8562): if `protected_until <= now` reply 4452 with 0; else reply 4452 with the remaining seconds (client resync).
- `world_map::castle_pvp::grant_protection(player, seconds)` called by the item use handler: set `protected_until`, push 4452 to the owner and 118 to viewers.
- Daily reset job at 0h: `attack_left_count = 5` via 4202 (shared daily reset owner, [../daily-activity/README.md](../daily-activity/README.md) or account).

## 9. Open questions and assumptions

- Battle types for raids and army fights (4 or 5) are assumptions; both exit to the outer city.
- Plunder formula, defender losses and garrison composition are unknown.
- Whether army PvP consumes a daily attack is unknown.
- 118 also overwrites the receiver's own `defenceLeftTime` in the client (quirk).

## 10. Implementation checklist

- [ ] Screens: castle menu, attack info window, castle info frame, attack cursor
- [ ] Route C1 5160 castle raid in `handle_attack`
- [ ] Route C2 8488 `handle_pvp_fight`
- [ ] Route C3 8562 `handle_protection_cancel`
- [ ] Protection grant API for item 208006
- [ ] Server messages 4382, 4452, 118, 3 (`attack_left_count`), 4202
- [ ] Tables `world_map.daily_attacks`, `world_map.castle_raids`
- [ ] Daily reset of attacks
- [ ] Test: raid refused for protected, same guild, level gap ≥ 10, zero attacks
- [ ] Test: raid removes the attacker's protection and shows gains after the battle
