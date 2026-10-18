# Busca de ovos (Easter egg hunt, game hall game 4, "复活节活动")

Path aliases:

| Alias | File |
|---|---|
| GHM | `decompiled/core_module/scripts/managers/GameHallManager.as` |
| GHMOD | `decompiled/core_module/scripts/mvc/module/gamehall/GameHallModel.as` |
| GHBV | `decompiled/m3/scripts/gamehall/room/GameHallSceneBottomView.as` |
| GESF | `decompiled/m3/scripts/gamehall/GameHallEastShopFrame.as` |
| GEAV | `decompiled/m3/scripts/gamehall/view/GameHallActiveEastView.as` |
| GETL | `decompiled/m3/scripts/gamehall/view/GameHallTeamEastLeftView.as` |
| PCM | `decompiled/core_module/scripts/managers/PlayerCurrencyManager.as` |
| CIM | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A timed team PvE event played from the game hall ([game-hall.md](game-hall.md), `gameId 4`, "Busca de ovos", group "Páscoa", level 160). Help (`gamehall.HelpFrame4.helpContent`): "1. Durante o evento, ao realizar Arqueologia nos Arredores você pode ganhar também bilhetes 2. Você pode gastar bilhetes para entrar nas fases do evento, onde você pode derrotar monstros e ganhar ovos 3. Os monstros carregam diferentes maldições, ao derrotá-los você ganha bençãos capazes de neutralizar as maldições 4. Passando da última fase aberta ou seguindo as fases mais posteriores passadas pela equipe você pode entrar nas fases e abrir a próxima 5. Caso tenha dificuldades você pode formar equipes ou aumentar o nível de suas bençãos".

Parts: tickets ("Bilhetes", currency 36) spent to enter a map (`EasterTemplates.xml`, 120 maps, `difficulty` = map id); eggs ("ovos coloridos", currency 35) won in maps; blessings ("bençãos") with levels; "Benção da Primavera" buff that multiplies eggs; auto repeat and auto sequence modes; and the egg lottery "Sorteio de ovos" with a finite pool ("Bolo").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `GameHallActiveEastView` (GEAV), `GameHallTeamEastLeftView` (GETL) | Easter panels of the game hall tabs | Open maps (`openList`), blessings with levels, buff "Benção da primavera" / "Recompensa de Ovos Coloridos", tips "Realize Arqueologia para buscar bilhetes e ovos", "Desafie monstros para ganhar vários ovos", "Use ovos para realizar sorteios" | game hall frame when Easter is open (GEAV:102, GETL:49 send op 0) | 4585 |
| `GameHallSceneEastBlessView` | blessings in the room | "É recomendado 4 pessoas, as bençãos dos jogadores podem neutralizar maldições de inimigos e enfraquecer os monstros" | room scene | `buff` of each member (4562 op 106) |
| `gamehall.GameHallEastShopFrame` (GESF), 810x630 | "Sorteio de ovos" | Pool of prizes with remaining counts, "(Itens restantes: {0}/{1})", "{0}° bolo", draw x1 and x10 (eggs), refresh pool, description "Bolo" | Easter view lottery button (`openControllerByInfo("gamehall", ...)`) | 4587 |
| `gamehall.GameHallEastShopDescFrame` | "Bolo" | Rules: "1. Cada sorteio tira itens do bolo, reduzindo seu número; 2. Existem itens especiais no bolo e, caso não sorteados, não permitem que o bolo seja renovado; 3. Quando não restarem mais itens especiais no bolo pode-se renová-lo; 4. Os itens restantes no bolo não são preservados após a atualização; 5. Há um limite de número de bolos, após o último não é mais possível renovar." | GESF desc button (GESF:377-380) | |
| `gamehall.GameHallEastShopAnimationFrame` / `ResultFrame` | draw animation and result | Shows `result` items | 4587 with `result` (GHM:709-713) | |

Toolbar: `gamehall` (TopToolBtnInfos 4020 "复活节活动") visible when `eastIsOpen` (TBH:389-390), set by 4590 `param1 4020` (GHM:733-743).

## 3. Routes (client to server)

C>S 8655 (0x21cf) `C_EASTER_CLIENT_OP`, body `player.PlayerOpMsg` with `op` (#1, INT32) and `count` (#4, INT32) (other 18 fields unused). Sender `GameHallManager.opEastFrame(op, count = 0)` (GHM:673-680).

| # | op | Action | UI | Client checks | Expected reply |
|---|---|---|---|---|---|
| R1 | 0 | Load Easter data | Easter views (GEAV:102, GETL:49), entering the scene with game 4 (GHM:567-574) | none | 4585 |
| R2 | 1 | Buy tickets | "buy tickets" (GHMOD:468-500), also when starting without tickets (GHBV:534-552) | event not ended ("activity.ActivityManager.command02"); `todayHasGetNum < dailyBuys` else "Limite de compras diárias atingido"; confirm "Gaste {0} diamantes para comprar {2} {1}\nComprados hoje"; `point >= price` | 4585, 3, 4725 |
| R3 | 2 | Open egg lottery | GESF build (GESF:88) | none | 4587 |
| R4 | 3 | Draw x1 / x10 | GESF buttons (GESF:241-259) | eggs >= `easter_lottery_egg_count * n` else "Ovos insuficientes, não é possível realizar sorteio" | 4587 with `result`, 4725, 115 |
| R5 | 4 | Refresh pool | GESF refresh (GESF:261-302) | no special prize (`isShow == 1`) left with `remainNum != 0`, else "Ainda há prêmios especiais restantes, não é possível atualizar" | 4587 |
| R6 | 5 | Buy "Benção da Primavera" | buff button (GHMOD:502-545); also offered once a day before start or ready when the buff has no charges (GHBV:534-640, "Compre a Benção da Primavera agora...") | event not ended; `todayHasBuyBufferNum < dayLimit`; confirm "Gaste {0} diamantes para comprar a Bênção da Primavera e aumentar o ganho de ovos na fase em {1} vezes. N° de efeitos de Benção:"; `point >= price` | 4585, 3 |

Start and ready of an Easter team use the game hall routes ([game-hall.md](game-hall.md) R10, R12) with `autoType` (0 none, 1 repeat, 2 sequence, GHBV:762-775) and the ticket check `eastTickesCoin >= EasterTemplate.TicketCount` (GHBV:740-751; failure "Bilhetes insuficientes, não é possível preparar").

## 4. Server messages (server to client)

### S1. 4585 (0x11e9) `U_C_EASTER_USER_DATA`
- `module.EasterUserMsg`: `userId` (#1, INT32); `wish` (#2, STRING) blessings `"skillTemplateId,level|..."`; `buyCount` (#3, INT32) ticket purchases today; `openList` (#4, INT32, repeated) open map ids; `buffCount` (#5, INT32) remaining buff charges; `buyBuffCount` (#6, INT32) buff purchases today.
- Receiver: `GameHallManager.__eastUserDataHandler` (GHM:593-629): `todayHasGetNum`, `todayHasBuyBufferNum`, `remainEffectiveNum`, `eastOpenTemplateIdArr`, `wishArray` (sorted by skill `Index`).
- When: reply to R1, R2, R6; push after a map is cleared (new open map, blessing level).

### S2. 4587 (0x11eb) `U_C_EASTER_LOTTERY_DATA`
- `module.EasterLotteryMsg`: `userId` (#1, INT32); `result` (#2, INT32, repeated) prize template ids won by this draw (`EasterLotteryDrop.id`); `lottery` (#3, STRING) pool `"prizeId,remain|..."`; `num` (#4, INT32) pool number ("{0}° bolo").
- Receiver: `GameHallManager.__eastLotteryDataHandler` (GHM:682-714): rebuilds the pool sorted by id, opens the animation frame when `result` is not empty.
- When: reply to R3, R4, R5.

### S3. 4590 (0x11ee) `U_C_TOP_TOOL_BTN` with `param1 = 4020`
- `PropertyMsg`: `param7` open (GHM:733-743).

### S4. 4725 currency refresh (types 35 eggs, 36 tickets)
- Receiver `PlayerCurrencyManager.__currencyRefreshHandler` (PCM:71, 388-401). Owner: [../currency/README.md](../currency/README.md).

### S5. 4562 op 106
- Team blessing update for the room (see [game-hall.md](game-hall.md)).

## 5. Rules and formulas

`raw/xml/tempinfos/ConfigInfos.xml` (read by CIM:1254-1280 and GHMOD:151-180):

| Config | Value | Meaning |
|---|---|---|
| `easter_ticket_config` | 1000,10,18,5 | diamonds per purchase, tickets per purchase, purchases per day, free tickets given (assumption: daily) |
| `easter_lottery_egg_count` | 100 | eggs per draw |
| `easter_reward_add` | 30,10 | reward bonus: blessing level difference, bonus percent |
| `easter_egg_buff_config` | 3,1000,35,6 | egg multiplier, diamonds per buff, charges per buff, buff purchases per day |

- B1. Event window: GameHall template 4 `StartDate..StopDate` (2019-05-17 11:00:00 to 2019-05-24 23:59:59 in this data) and 4590 open flag.
- B2. Entering a map costs `TicketCount` tickets per member (1 in every row).
- B3. Map unlock: clearing the last open map, or following a team that cleared a later map, opens the next one (help line 4).
- B4. Each map has 4 boss waves (`Boss1..Boss4` "monsterId,position|..."), curse buffs per wave (`Buff1..4`, skill buffs), egg drops per wave (`Drop1..4`, drop ids of a server side table, 0 = none), `Probability` 20 and `DropWishes` (blessing drop).
- B5. Buff: while `buffCount > 0`, eggs gained in a map are multiplied by 3 and one charge is consumed per run (assumption).
- B6. Lottery: each draw takes one prize out of the current pool; refresh allowed only when every `isShow 1` prize is exhausted; pools are numbered and limited (dropIds 1770001..1770020).
- B7. Auto modes: repeat the same map or advance to the next after each victory; stop on defeat or when any member lacks tickets (`gameHall.east.autoRepeatDes`, `autoNextDes`).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/EasterTemplates.xml` | `EasterTemplate` (120 maps, names "1 - Planície dos Furries" .. "120 - Coliseu") | `TemplateId` map id (= `difficulty`), `TemplateName`, `MapId`, `PreView`, `Boss1..4`, `Buff1..4`, `Drop1..4`, `Probability`, `TicketCount`, `DropWishes` |
| `raw/xml/tempinfos/EasterLotteryDrop.xml` | `EasterLotteryDropInfo` (20 pools `dropId` 1770001..1770020, 8 to 17 prizes each) | `id` prize id, `dropId` pool, `itemId`, `count` stock, `isShow` 1 = special prize, `isBind` |
| `raw/xml/tempinfos/GameHallTemplates.xml` | `GameId 4` | window, level 160 |
| `raw/xml/tempinfos/SkillTempInfos.xml` | blessing skills (`wish` ids) | `Index` order, names |

## 7. Persistent state

```sql
CREATE TABLE casino.easter_player (
  player_id        BIGINT   PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  day              DATE      NOT NULL DEFAULT CURRENT_DATE,
  ticket_buys_day  SMALLINT  NOT NULL DEFAULT 0,
  buff_buys_day    SMALLINT  NOT NULL DEFAULT 0,
  buff_charges     INTEGER   NOT NULL DEFAULT 0,
  open_maps        INTEGER[] NOT NULL DEFAULT '{1}',
  pool_number      SMALLINT  NOT NULL DEFAULT 1
);

CREATE TABLE casino.easter_blessing (
  player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  skill_id    INTEGER  NOT NULL,
  level       SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, skill_id)
);

CREATE TABLE casino.easter_pool_stock (
  player_id   BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  prize_id    INTEGER NOT NULL,
  remaining   INTEGER NOT NULL CHECK (remaining >= 0),
  PRIMARY KEY (player_id, prize_id)
);
```

Tickets and eggs are currencies (types 36 and 35) in the currency feature.

## 8. Backend implementation notes

- `casino::easter::handle_op` (8655) on `op`: 0 `handle_load` (reply 4585), 1 `handle_buy_tickets`, 2 `handle_open_lottery` (create the pool from `pool_number` if empty; reply 4587), 3 `handle_draw` (`count` 1 or 10; eggs >= 100 * count; weighted by remaining stock; reply 4587 with `result`, 4725, 115), 4 `handle_refresh_pool` (special prizes exhausted, next pool exists; reply 4587), 5 `handle_buy_buff`.
- Map run (game hall start with `gameId 4`, `difficulty` = map): check every member has `TicketCount` tickets and the map is open for the captain (or a member, B3); debit tickets; start the campaign with `EasterTemplate.MapId`, waves `Boss1..4`, curse buffs `Buff1..4`; blessings of members reduce curses (`easter_reward_add`). On victory: eggs from `Drop1..4` times the buff multiplier, blessing drop `DropWishes` with `Probability`, open the next map, push 4585 and 4562 op 106; auto modes chain the next start.
- Push 4590 (`param1 4020`) at login and on event start or end; daily reset at 00:00 lazily by `day`.

## 9. Open questions and assumptions

- Assumption: the fourth value of `easter_ticket_config` is free tickets per day.
- Assumption: `Drop1..4` reference a map drop table not present in the client (`EasterLotteryDrop` is the lottery pool).
- Open: blessing level up rules and how blessings neutralize curses in battle (battle engine, see [../../docs/battle/server-engine.md](../../docs/battle/server-engine.md)).

## 10. Implementation checklist

- [ ] Easter panels, room blessing view, lottery frames
- [ ] Route 8655 ops 0..5
- [ ] Messages 4585, 4587, 4590 (4020), currency 35/36 in 4725
- [ ] Tables `easter_player`, `easter_blessing`, `easter_pool_stock`
- [ ] Map run: tickets, waves, eggs, unlocks, auto modes
- [ ] Test: draw x10 needs 1000 eggs; refresh refused with special prizes left
