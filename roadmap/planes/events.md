# Planes grid events, battles and revive

Feature [planes](README.md), module `events`. Aliases in [README.md](README.md).

## 1. Overview

When the hero triggers the event of his cell (op 2 with `[x, y]`, see [exploration.md](exploration.md)) the server resolves it by `PlanesEvents.EventType` (`PCC:6-42`):

| EventType | Constant | pt-BR example | Resolution |
|---|---|---|---|
| -1 | `WALL_TYPE` | "Vulcão", "Rocha", "Pico de Eletricidade", "Selva", "Árvore", "Coluna" | blocks movement, never triggered |
| 998 | `FONT_BASE_TYPE` | "Base de Entrada" (event 3) | entry cell; `occupy_name` shows the owner |
| 1 | `GOLD_MONSTER_TYPE` | "Schachter" ("Derrotando ... poderá obter a chave de ouro") | battle 3843, then card pick; gives a gold key |
| 2 | `MONSTER_EVENT_TYPE` | "Julgamentos Iniciais", "Julgamento Nv. Baixo" | battle 3843, then card pick |
| 3 | `MARKET_EVENT_TYPE` | "Empresário Escondido" | opens "Mercado Negro" (op 4) |
| 5 | `RESOURCE_EVENT_TYPE` | "Mina Comum", "Mina Elite" | occupy a mine (energy 100), see [resources.md](resources.md) |
| 61 / 62 | `COMMON_ENTRANCE/EXIT_TYPE` | "Transmissor Normal" | go to next / previous layer |
| 71 / 72 | `GOLD_ENTRANCE/EXIT_TYPE` | "Transmissor de ouro" | needs a gold key |
| 8 | `HIDE_ENTRANCE_TYPE` | "Entrada do transmissor oculto" | go to the hidden 3x3 layer (LayerNum 12) |
| 91 / 92 | `BRANCH_ENTRANCE/EXIT_TYPE` | "Transmissor secundário" | branch layer (LayerNum 11) |
| 10 | `SILVER_BOX_TYPE` | "Baú de Prata" (`Rewards -3100,250`) | needs a silver key, gives 250 energy |
| 11 | `COMMON_BOX_TYPE` | "Tesouro Perdido" | free chest, `Rewards` |
| 12 | `BOSS_EVENT_TYPE` | "Castelo de Gauguin" | battle 3843; winning marks the castle `occupied` and completes the plane ("Parabés por ocupar todo o Plano ...") |
| 13 | `SILVER_MONSTER_TYPE` | "Gauguin" patrol | battle 3843, gives a silver key |
| 14 | `GUARD_MONSTER_TYPE` | "Protetor" ("Derrotar o protetor para ocupar essa camada!") | battle 3843, winning occupies the layer (`occupy_userid`) |
| 15 | `HIDE_BOX_TYPE` | "Tesouro Perdido" in hidden layers | free chest |

Event frames opened from 4942 `event_info` by EventType (`PCTL:23-30`): 1, 2, 12, 13, 14 -> `PlanesCommonEventFrame` (card pick); 3 -> `PlanesBlackFrame` (market). Others have no frame.

Death: losing a battle sets `dead`; the hero shows a death effect with "Ressuscitar" (op 6) and "Ajuda" (help frame, op 33). Another player can click the world chat help link and revive him (op 34).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `M3P/view/eventframe/PlanesCommonEventFrame.as` | title = event `Name`, "Clique para receber uma recompensa" | Card pick after a won battle: N face down cards, auto pick after `planes_max_pick_card_time` (30 s) | 4942 with `event_info` and EventType 1, 2, 12, 13, 14 (`PWM:413-429`) | `event_info.paramInt` (see S1) |
| `M3P/view/eventframe/PlanesBlackFrame.as`, `PlanesBlackItemView.as` | "Mercado Negro" | Up to 3 discounted items | EventType 3 | `PlanesEvents.Parameter` `itemId,count,basePrice,discount|...`; `paramInt[i] == 1` = already bought (`PlanesBlackFrame.as:65-95`) |
| `M3P/view/PlanesArmyView.as` (death state) | revive tip "dungeonexplore.view.DunGeonExploreHeroView.backToLifeBtn", help tip "fish.FishHelpFrame.title" | Dead hero with revive and help buttons | `dead = true` (`PlanesWalkLayer.as:58-64`, `:131-137`) | - |
| `M3P/view/eventframe/PlanesGetHelpFrame.as` | "Ajuda de Planos" | 60 s countdown (`planes_help_revive_time`), button world help | death help button (`PlanesArmyView.as:331-335`) | countdown |

## 3. Routes (client to server)

Envelope 9527 `PlanesWarReqMsg`, see [transmitter.md](transmitter.md).

### R1. Trigger event (op 2, `[x, y]`)

Described in [exploration.md](exploration.md) R3. Server effects by EventType:

- Battle events (1, 2, 12, 13, 14): deduct event energy (`int(EnergyCost * (1500 + 3R) / (1500 + 4R))`); start battle type 3843 against the event monster with the layer `EnemySkill` applied to enemies (assumption). Win: cell cleared (`event_id = 0`), keys added (type 1 gold, 13 silver), layer occupied (14), castle occupied (12, `occupied = true`, `occupy_name`), `Rewards` granted, then 4942 with `event_info` for the card pick. Loss: `dead = true`.
- Chests 10, 11, 15: grant `Rewards` (`-3100` = planes energy, `-3200` = revive count, `-500` = bound diamonds, other ids = items; assumption from `Rewards` values and `planeswar.planesCommonEventFrame.descText5/8` "Obteve Energia +{0}", "Obteve número de ressurreições +1"), cell cleared; 10 consumes a silver key.
- Portals 61/62/71/72/8/91/92: activate and move to the linked layer as op 36 (4943 new stamp, 4981, 4942 `op = 36`); 71/72 consume a gold key.
- Market 3: 4942 `op = 2` with `event_info` (`event_id`, `respond_type`, `paramInt` = bought flags per slot).
- Mine 5: see [resources.md](resources.md).

### R2. Card pick (op 35)

- UI: click a card, or random index after the countdown when `respond_type == 0` (`PlanesCommonEventFrame.as:130-151`). If `respond_type != 0` the frame only shows the result (reopen after reconnect).
- Request: `op = 35`, `param = [paramInt[0], cardIndex]`.
- Response: 4942 `op = 35` with `event_info.respond_type = 1`, `paramInt = [cardCount?, ..., selectedIndex at [2], itemId_i at [3 + 2i], count_i at [4 + 2i]]`; the client flips the chosen card and then the others (`:153-259`). Grant the chosen item.

### R3. Black market buy (op 4)

- UI: buy button of an item (`PlanesBlackItemView.as:71-86`).
- Client checks: `allPoint >= int(basePrice * discount / 100)` else recharge; confirm "dungeonexplore.view.DungeonExploreBlackFrame.buyTips".
- Request: `op = 4`, `param = [slotIndex]` (0..2).
- Response: bag update, balance push, 4942 `op = 4` with `event_info` whose `paramInt[slot] = 1`. If the hero left the market cell the frame shows "Você já não está no mesmo local, não é possível comprar" (`PlanesBlackFrame.as:70-77`, triggered when `event_info` is absent, so send 4942 op 4 without `event_info` on failure).

### R4. Self revive (op 6)

- UI: revive button of the dead hero (`PlanesArmyView.as:313-369`), daily confirm "Deseja consumir {0} diamantes para ressuscitar?\n(Uso prioritário de chances de ressuscitação)" with `planes_buy_revive` = `10,1`.
- Request: `op = 6`, `param = [payType]` (1 diamonds, 2 bound first).
- Server: if `revive_left > 0` consume one, else charge 10 diamonds; `dead = false`; position: stay (assumption).
- Response: 4942 `op = 6` with `dead = false`, `revive_left` -> `PLANES_REVIVE_BACK`.

### R5. Ask world help (op 33)

- UI: "Ajuda de Planos" world button (`PlanesGetHelpFrame.as:117-143`). Client checks: owns bugle 208003 or has free small bugles (else quick buy).
- Request: `op = 33`, `param = [1]`.
- Server: consume a bugle (or free count); broadcast a world chat message with link type 112 carrying the dead player's user id (`decompiled/core_module/scripts/chat/datas/ChatCellData.as:220-223`); open a help window of `planes_help_revive_time` = 60 s.

### R6. Help revive another player (op 34)

- UI: clicking the chat link (`decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:302-316`), 3 s throttle, not self.
- Request: `op = 34`, `param = [deadUserId, helperUserId]`.
- Server: count distinct helpers; when `planes_help_revive_count` = 3 helpers clicked inside the window, revive the dead player (assumption on exact rule from config "复活需求助人数").
- Response to the dead player: 4942 `op = 34` with `dead = false` -> `HELP_RERIVE_BACK` closes the help frame (`PlanesGetHelpFrame.as:96-102`). Helper reward: none known.

## 4. Server messages (server to client)

### S1. 4942 `PlanesWarRspMsg.event_info` (#13, MESSAGE `PlanesWarEventMsg`)

- `PlanesWarEventMsg`: `event_id` (#1, INT32) `EventTempId`; `respond_type` (#2, INT32) 0 = waiting for the player, 1 = already resolved; `paramInt` (#3, INT32, repeated) event data.
- Card events: `paramInt[0]` card set id echoed in op 35 (also used as a loop bound when disabling cards), `paramInt[1]` number of cards (1..5), `paramInt[2]` selected index (after op 35), then pairs `itemId, count` per card starting at index 3 (`PlanesCommonEventFrame.as:86-128`, `:185-205`).
- Market events: `paramInt[i]` 1 = slot i sold out.
- Receiver: `PWM.__planesWarMsgHandler` (`PWM:163-186`); frame opening is buffered until the scene is ready (`SocketSceneBufferManager`, scene `PLANES_WAR_SCENE`). Without `event_info` the client sets `eventId = 0`.

### S2. Battle 3843

- Battle start and result use the generic battle protocol (`docs/battle/server-engine.md`). On exit the client returns to `PLANES_WAR_SCENE` when `isInPlanesWar` (`decompiled/core_module/scripts/battle/handler/BattleResultHandler.as:214-223`). Then send 4943 (cell update), 4942 (keys, dead, `event_info` for cards), 4981 (occupation).

### S3. World chat link 112

- Chat message type with a "pedir auxílio" link; owner [chat](../chat/README.md). Must carry the dead player's `userId`.

## 5. Rules and formulas

- Revives: start `planes_default_revive` = 1, max accumulated `planes_max_revive` = 10, buy `planes_buy_revive` = 10 diamonds for 1.
- Card pick timeout 30000 ms (`planes_max_pick_card_time`).
- Market price: `int(basePrice * discount / 100)` diamonds (`PlanesBlackItemView.as:88-102`), e.g. `208024,80,1600,20` = 80x item 208024 for 320.
- `planes_default_attack` = 3 ("初始攻击次数") belongs to the unused PvP attack system.
- Rewards encoding in `PlanesEvents.Rewards`: `id,count|...`; negative ids are virtual currencies (-3100 energy, -3200 revive, -500 bound diamonds; assumption based on values and texts).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/PlanesEvents.xml` | 107 events, EventType counts: -1 x6, 1 x12, 2 x31, 3 x18, 5 x4, 8, 10, 11 x6, 12 x6, 13 x6, 14, 15 x8, 61, 62, 71, 72, 91, 92, 998 | `Rewards`, `Parameter` (market `itemId,count,price,discount|...`; mine `1440,60,-500,20`), `EnergyCost`, `Description` |
| `raw/xml/tempinfos/ConfigInfos.xml` | `planes_buy_revive`, `planes_default_revive`, `planes_max_revive`, `planes_max_pick_card_time`, `planes_help_revive_count`, `planes_help_revive_time` | see section 5 |

## 7. Persistent state

Event state lives in `planes.cell.event_state` and `planes.session.is_dead` ([exploration.md](exploration.md)); keys and revives in `planes.player_state` ([transmitter.md](transmitter.md)). Additional tables:

```sql
CREATE TABLE planes.pending_card_pick (
  player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_id             INTEGER     NOT NULL,
  card_set_id          INTEGER     NOT NULL,
  cards                JSONB       NOT NULL,
  selected_index       SMALLINT,
  expires_at           TIMESTAMPTZ NOT NULL
);

CREATE TABLE planes.help_request (
  dead_player_id       BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  expires_at           TIMESTAMPTZ NOT NULL,
  helper_ids           INTEGER[]   NOT NULL DEFAULT '{}'
);
```

## 8. Backend implementation notes

- `planes::events::handle_trigger` (op 2 two params): load cell, check energy and level, dispatch by EventType. Battle events build a battle config: battleType 3843, attacker = player army, defender = event monster (monster data not in client templates; assumption: generated from plane size and `EnemySkill`). Store the pending battle in `cell.event_state`.
- `planes::events::handle_battle_end` (battle callback): update cell, keys, occupation; create `pending_card_pick` with cards rolled from the event `Rewards`; push 4943, 4981, 4942 with `event_info`.
- `planes::events::handle_card_pick` (op 35): validate set id and index; grant; delete pending row; reply 4942 op 35. Timer job: auto pick at `expires_at`.
- `planes::events::handle_market_buy` (op 4): hero on the market cell; slot not sold; charge; grant; mark sold.
- `planes::events::handle_revive` (op 6), `planes::events::handle_help_request` (op 33, chat broadcast), `planes::events::handle_help_revive` (op 34, push to the dead player if online).

## 9. Open questions and assumptions

- Monster lineups for planes battles are not in client data.
- Card set meaning of `paramInt[0]` and card count source.
- Virtual reward ids (-3100, -3200, -500) meanings are inferred.
- Help revive rule (3 helpers within 60 s) inferred from config names.

## 10. Implementation checklist

- [ ] Screen: `PlanesCommonEventFrame` card pick with timeout
- [ ] Screen: `PlanesBlackFrame` market
- [ ] Screen: death state and `PlanesGetHelpFrame`
- [ ] Route R1 trigger per EventType (walls, chests, portals, keys, market, battle)
- [ ] Route R2 op 35 card pick
- [ ] Route R3 op 4 market buy
- [ ] Route R4 op 6 revive
- [ ] Route R5 op 33 world help (chat link 112)
- [ ] Route R6 op 34 help revive
- [ ] Server message 4942 `event_info`
- [ ] Battle 3843 start and end hooks
- [ ] Tables `planes.pending_card_pick`, `planes.help_request`
- [ ] Test: layer occupation after beating event 14001
- [ ] Test: card auto pick after 30 s

## Screens

- `PlanesEventBaseFrame` (`decompiled/m3/scripts/planeswar/view/eventframe/PlanesEventBaseFrame.as`) is the base frame all planes war event popups extend.
