# Platinum pot: Pote Mágico de Ouro and Pote Mágico de platina

Module `platinum-pot` of feature `laboratory`. Covers the timed event "Pote Mágico de platina": event state (213), drop pools and the platinum chance (214), drawing with hammers (9645 with header `extend1 = 40`), and the gain tips (215).

Path aliases:

| Alias | File |
|---|---|
| PM | `decompiled/core_module/scripts/managers/PlatinumManager.as` |
| PMOD | `decompiled/core_module/scripts/mvc/module/platinum/PlatinumModel.as` |
| V | `decompiled/m11/scripts/platinum/` |

## 1. Overview

- Two pots: index 0 "Pote Mágico de Ouro" (gold pot, hammer 208530 "Martelo Mágico de Ouro"), index 1 "Pote Mágico de platina" (platinum pot, hammer 208531 "Martelo Mágico de Platina"). One hammer = one draw. Hammers are only usable during the event.
- Draw 1 or 10 at a time. Gold pot: a single draw has a chance to grant the platinum chance; 10 draws always grant it. Platinum pot: only usable while `hasChance` is true. The chance does not accumulate; any new draw (gold or platinum, 1 or 10) consumes it (help text items 2 and 3, `platinum.PlatinumFrame.helpFrame.helpContent`).
- Description shown on the gold tab: "Sorteia um item aleatório 1 vez e tem chance de sortear o Pote Mágico de platina. Não há garantia de sortear o Pote Mágico de platina acumulando 10 sorteios únicos.\nAbrir 10 vezes garante a chance de abrir o Pote Mágico de platina".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `V/PlatinumFrame.as` | "Pote Mágico de platina"; tabs gold/platinum (tips "Martelo Mágico de Ouro" / "Martelo Mágico de Platina"); "Evento encerrado em:" countdown; buttons x1, x10, "+" (quick buy hammer), item list, help | draws and animation | top bar `platinum` (controller `platinum`, `decompiled/core_module/scripts/mvc/controler/PlatinumControler.as`) | up to 6 notice items of the current pot (`:280-316`), hammer count from bag type 1 (`:451-467`), lucky list and personal list (`:379-431`), glow on the platinum tab while `hasChance` (`:439-449`) |
| `V/PlatinumDropFrame.as` | "Lista de Itens" | full pool of the current pot, sorted by Profile desc, SonType, id desc | list button (`V/PlatinumFrame.as:475-480`) | `goldItemInfo` or `platinumItemInfo` (`:55-98`) |
| confirmation | "Já obteve a chance de abrir o Pote Mágico de platina. A abertura do pote mágico de ouro pode fazer com que a chance desapareça." | warn before a gold draw while holding the chance | x1/x10 on the gold tab | (`V/PlatinumFrame.as:535-544`) |

The frame sends nothing on open: it relies on 213 and 214 pushed before (login). `refreshItem` dereferences `goldItemNoticeInfo`/`platinumItemNoticeInfo` and the timer reads `platinum_endDate`, so both pushes are mandatory before the button is shown.

## 3. Routes (client to server)

### C1. Draw (break a pot)
- UI: x1 (`_openBtn1`, 1 draw) or x10 (`_openBtn2`, 10 draws) (`V/PlatinumFrame.as:506-562`).
- Client checks:
  - event expired (`nowDate > platinum_endDate`) -> "Evento expirado";
  - hammers of the tab (`208530` or `208531`) `< drawCount` -> quick buy frame for the missing amount (`:529-534`, `quickUIcallback` `:364-372`, shop item with `ShopType` forced to 2);
  - gold tab with `hasChance` -> confirmation above;
  - platinum tab buttons enabled only while `hasChance` (`:707-711`).
- Then the close button, both draw buttons and both tabs are disabled until the animation ends (`:557-562`).
- Sender: `PM.sendOpenInfo(drawCount, canType)` (`PM:140-147`).
- Route: C>S 9645 (0x25ad) `C_CCCACTIVE_CLIENTOP`, packet header `extend1 = 40` (`new PackageOut(9645, 0, 40)`; 9645 is shared by many "cccactive" events, `extend1` selects the event: 27 PumpingJoy, 28 WholeRebate, 29 MonthCard, 30 FoisonHorn, 34 LuckyLottery, 36 WishPool, 38 SuperSigninCard, 40 Platinum, 41 CustomizedVip). Body `cccactive.PlatinaCanOpMsg`: `drawCount (#1, INT32)` 1 or 10; `canType (#2, INT32)` 0 gold pot, 1 platinum pot.
- Response, in this order: bag pushes (hammers consumed, items added); 214 with `hasChance` (new value); 215 with `itemIds` (one template id per drawn item, `drawCount` entries) and `personalTip` (new own gain lines) and, when rare items were drawn, `luckPassTip` (broadcast to all online players with the event open, see S3).

## 4. Server messages (server to client)

### S1. 213 (0x00d5) `U_C_PLATINA_CAN_OPEN_STATE`, `simple.PropertyMsg`
Receiver `PM.__updateOpenState` (`PM:67-76`, listener `PM:62`). Note: `simple.PropertyMsg`, not `army.PropertyMsg` (`protocol/proto.json` keeps only the army one; tags from `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as:305-360`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `param1`..`param3` | #1..#3 | INT32 | no | unused |
| `param4` | #4 | STRING | no | event begin `YYYY-MM-DD hh:mm:ss` |
| `param5` | #5 | STRING | no | event end `YYYY-MM-DD hh:mm:ss` (countdown and expiry check) |
| `param6` | #6 | STRING | no | unused |
| `param7` | #7 | BOOL | no | event open (`openBottle`): shows the top bar button (with `grades >= 11`); false closes an open frame (`V/PlatinumFrame.as:489-495`) |
| `param8`..`param12` | #8..#12 | BOOL/INT32/STRING | no | unused |

When: login; event start and end (push to all online players). Client dispatches `REFRESH_TOPTOOLS`.

### S2. 214 (0x00d6) `U_C_PLATINA_ACTIVE_INFO`, `cccactive.PlatinaCanOpMsg`
Receiver `PM.__updateActiveInfo` (`PM:78-112`, listener `PM:63`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `drawCount` | #1 | INT32 | no | unused in responses |
| `canType` | #2 | INT32 | no | unused in responses |
| `hasChance` | #3 | BOOL | no | platinum chance (applied only when present) |
| `goldItems` | #4 | `PlatinaItemInfoMsg` | yes | gold pot pool (replaced only when non empty) |
| `platinaItems` | #5 | `PlatinaItemInfoMsg` | yes | platinum pot pool (replaced only when non empty) |

`PlatinaItemInfoMsg`: `templateId (#1, INT32)`; `count (#2, INT32)`; `isNotice (#3, BOOL)` shown in the 6 highlighted cells.

When: login (full pools and `hasChance`, mandatory); after each draw (`hasChance` only).

### S3. 215 (0x00d7) `U_C_PLATINA_ACTIVE_ITEM_TIP`, `cccactive.PlatinaItemGainTipMsg`
Receiver `PM.__updateActiveItemTip` (`PM:114-138`, listener `PM:64`).

| Field | Tag | Type | Rep | Meaning |
|---|---|---|---|---|
| `luckPassTip` | #1 | STRING | yes | server wide lucky list (replaces the list when non empty); each line is rendered as chat content on channel 21 (BOTTLE), so it may contain chat elements such as player links `<a t="1" .../>` and items `<a t="2" .../>` ([chat](../chat/README.md)) |
| `personalTip` | #2 | STRING | yes | own gain lines (appended to the list) |
| `itemIds` | #3 | INT32 | yes | items of the last draw, in order; triggers the animation (`PLATINA_ACTIVE_ITEMID`) |

When: after each draw (with `itemIds`, mandatory: without a non empty `itemIds` the frame stays locked with the close button disabled); at login with the lucky list and the player's previous gains (optional); to other players when someone draws a rare item (only `luckPassTip`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Hammers | 208530 gold, 208531 platinum, consumed 1 per draw from the bag | `V/PlatinumFrame.as:69-71,464-466` |
| Hammer shop | ShopTempInfo 11001 (208530, 10 diamonds), 11002 (208531, 20 diamonds), ShopType 1 Area 10 | `ShopTempInfos.xml` |
| Platinum access | `hasChance` true | `V/PlatinumFrame.as:707-711` |
| Chance gain | gold draw x10: always; gold draw x1: probability p (not in client data) | help text |
| Chance loss | any draw consumes the current chance before evaluating a new one | help text item 3 |
| Visibility | `grades >= 11` and event open | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as:401-404` |
| Pools and weights | server config per pot (`count` and `isNotice` sent to the client; weights hidden) | assumption |

## 6. Templates

| File | Fields used |
|---|---|
| `ItemTempInfos.xml` | 208530, 208531 (hammers); pool items for names, icons, Profile and SonType sort |
| `ShopTempInfos.xml` | 11001, 11002 hammer prices |
| top bar template 2063 `platinum` | button |

No drop table exists in client data; pools must be server config.

## 7. Persistent state

Schema `laboratory` (feature slug).

```sql
CREATE TABLE laboratory.platinum_events (
  event_id      SERIAL PRIMARY KEY,
  begins_at     TIMESTAMPTZ NOT NULL,
  ends_at       TIMESTAMPTZ NOT NULL,
  single_chance_percent  SMALLINT NOT NULL DEFAULT 10 CHECK (single_chance_percent BETWEEN 0 AND 100),
  CHECK (ends_at > begins_at)
);

CREATE TABLE laboratory.platinum_pool_items (
  event_id          INTEGER NOT NULL REFERENCES laboratory.platinum_events(event_id) ON DELETE CASCADE,
  pot_type          SMALLINT NOT NULL CHECK (pot_type IN (0, 1)),   -- 0 gold, 1 platinum
  item_template_id  INTEGER NOT NULL,
  count             INTEGER NOT NULL CHECK (count > 0),
  weight            INTEGER NOT NULL CHECK (weight > 0),
  is_notice         BOOLEAN NOT NULL DEFAULT false,
  is_lucky          BOOLEAN NOT NULL DEFAULT false,                  -- broadcast in luckPassTip
  PRIMARY KEY (event_id, pot_type, item_template_id, count)
);

CREATE TABLE laboratory.platinum_players (
  event_id     INTEGER NOT NULL REFERENCES laboratory.platinum_events(event_id) ON DELETE CASCADE,
  player_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  has_chance   BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (event_id, player_id)
);

CREATE TABLE laboratory.platinum_draws (
  draw_id           BIGSERIAL PRIMARY KEY,
  event_id          INTEGER NOT NULL REFERENCES laboratory.platinum_events(event_id) ON DELETE CASCADE,
  player_id         BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pot_type          SMALLINT NOT NULL CHECK (pot_type IN (0, 1)),
  item_template_id  INTEGER NOT NULL,
  count             INTEGER NOT NULL,
  is_lucky          BOOLEAN NOT NULL DEFAULT false,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX platinum_draws_player_idx ON laboratory.platinum_draws (event_id, player_id, created_at DESC);
CREATE INDEX platinum_draws_lucky_idx ON laboratory.platinum_draws (event_id, created_at DESC) WHERE is_lucky;
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 9645 with `extend1 = 40` | `laboratory::platinum_pot::handle_draw` (the 9645 dispatcher routes by header `extend1`) |
| login, event start/end | `laboratory::platinum_pot::push_state` (213, 214, 215) |

- `handle_draw` validation order: active event and `now < ends_at` -> `grades >= 11` -> `drawCount` in {1, 10} and `canType` in {0, 1} -> `canType = 1` requires `has_chance` -> hammers `>= drawCount`. On failure still reply 215 is impossible (empty `itemIds` is ignored), so validate exactly as the client does and treat failures as client bugs (log them); the frame stays locked until reopened.
- Transaction: consume hammers; `has_chance = false`; roll `drawCount` items from the pot pool by weight; for a gold draw set `has_chance = true` when `drawCount = 10` or a roll under `single_chance_percent`; add items to the bag; insert draw rows. After commit: bag pushes, 214 `{hasChance}`, 215 `{itemIds, personalTip}`; for lucky items push 215 `{luckPassTip}` (last N lucky lines) to every online player (assumption: N = 20).
- `push_state` at login when an event exists: 213 (`param4`, `param5`, `param7`), 214 with both pools and `hasChance`, 215 with `luckPassTip` and the player's `personalTip`. At event end push 213 with `param7 = false`.
- Tip lines are free text built by the server; use the chat element syntax for links (owned by [chat](../chat/README.md)).

## 9. Open questions and assumptions

- Open: single draw chance to gain the platinum chance (default 10%, configurable).
- Open: pool contents and weights for both pots (not in client data).
- Assumption: hammers left after the event stay in the bag (unusable).
- Assumption: `luckPassTip` lists the last 20 lucky draws server wide.
- Assumption: the server never fails a valid draw; on invalid input it sends nothing (the client stays locked).

## 10. Implementation checklist

- [ ] Screens (client ready): `PlatinumFrame`, `PlatinumDropFrame`, `PlatinumDropItem`.
- [ ] 9645 dispatcher by header `extend1` (shared with other cccactive events).
- [ ] Tables `laboratory.platinum_events`, `laboratory.platinum_pool_items`, `laboratory.platinum_players`, `laboratory.platinum_draws`.
- [ ] Login pushes 213, 214 (pools), 215 (tips).
- [ ] Route 9645 draw: hammers, chance rules, weighted roll, bag rewards.
- [ ] Server messages 214 (`hasChance`) and 215 (`itemIds`, tips) after each draw; lucky broadcast.
- [ ] Event start/end push 213.
- [ ] Tests: gold x10 sets `hasChance`; platinum draw without chance refused; platinum draw clears the chance; gold x1 while holding the chance clears it unless re-rolled; `itemIds` length equals `drawCount`; event ended refuses draws.
