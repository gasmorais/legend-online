# Sacrifice altar

Feature [sacrifice](README.md), module `altar`. Aliases in [README.md](README.md).

## 1. Overview

- Flow: open (op 1) -> pick an offering in the bottom bar (4 slots, one per offering level, count from the bag) -> "Sacrificar" (op 4) -> animation, 5 reward items appear -> optional refresh (op 2, 15 diamonds) -> click one reward and confirm (op 3) -> reward flies to the bag, the 5 items disappear.
- A pending, unchosen reward set blocks a new sacrifice ("Prêmio ainda não foi coletado, favor coletar primeiro.") and the player cannot leave without choosing ("Escolha seu premio para depois sair.").
- Daily limit `sacrifice_max_times` = 3 ("Nº de sacrifícios esgotados").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `SF` (`SacrificeFrame`) | "Sacrificios existentes", "Número de sacrifícios:" `{left}/{max}`, "Nível de sacrifícios" with levels "atual", "básico", "médio", "avançado", help "1. Ao sacrificar poderá obter vários prêmios, em cada sacrifício pode escolher um entre 5 prêmios.<br/>2. Quanto mais alto for o sacrifício, melhor serão os prêmios.<br/>3. Pode sacrificar 3x por dia, com VIP pode aumentar o número de sacrifícios." | Altar UI on layer 6 | planes list button or room NPC | offerings from `sacrifice_items_reward` with bag counts (`SF:393-431`), times left (`SF:360-369`), 5 reward slots (`SF:484-520`) |
| `decompiled/m11/scripts/sacrifice/SacrificeGoodsItem.as` | - | Offering / reward cell (counts >= 10000 shown in "万" style) | `SF` | `GoodsInfo` |
| `decompiled/m3/scripts/map/campaign/mediator/sacrifice/SacrificeRoomUIMediator.as`, `SRD` | "Sair" | Room UI and NPC dialog on map 9995 | campaign map 9995 | - |

## 3. Routes (client to server)

All requests: send 9543 (0x2547) `C_SACRIFICE_REQ`, protobuf `SacrificeReqMsg` (package `active`): `opType` (#1, INT32) action; `param1` (#2, INT32) argument. Sender `SM.sendReq(op, param)` (`SM:64-71`) through `SC` (`SC:73-90`).

### R1. Open (op 1)

- UI: frame constructor (`SF:119-127`).
- Request: `opType = 1`.
- Response: 4962 `opType = 1` with `times` and any pending reward set in `tempIds` (`SMOD:20-28`); the frame restores the pending rewards (`SF:341-358`).

### R2. Sacrifice (op 4)

- UI: sacrifice button (`SF:220-256`).
- Client checks, in order: pending rewards not chosen -> "Prêmio ainda não foi coletado, favor coletar primeiro."; times used up (`times >= sacrifice_max_times`) -> "Nº de sacrifícios esgotados"; no offering selected -> "Escolha os bens" and glow on owned offerings; selected count <= 0 -> "Itens insuficientes".
- Request: `opType = 4`, `param1` = offering template id (2131121..2131124).
- Server: validate times and item; consume 1 offering; roll 5 rewards from the pool of that offering level; store as pending; `times += 1`.
- Response: 4962 `opType = 3` with `times` and `tempIds` (the controller maps response op 3 to the sacrifice animation `frame.sacrifice`, `SC:51-71`; response op 3 also updates info tip key 24, `SM:56-59`). Bag update for the offering.

### R3. Refresh rewards (op 2)

- UI: refresh button (`SF:269-318`).
- Client checks: no pending rewards -> "Ainda não sacrificou, não pode atualizar"; reward already chosen -> "O prêmio foi coletado, não pode atualizar"; animation running -> "Sacrificando, não pode atualizar."; daily confirm "Deseja consumir {0} diamantes para atualizar prêmios?" (15); `playerInfo.point < 15` -> "Diamantes insuficientes" (real diamonds only).
- Request: `opType = 2`.
- Response: 4962 `opType = 2` with new `tempIds` -> `frame.updateReward`. Balance push.

### R4. Choose reward (op 3)

- UI: click a reward slot (`SF:531-575`), daily confirm "Tem a certeza que deseja escolher <{0}> como seu sacrifício?". Already chosen -> "Prêmio coletado".
- Request: `opType = 3`, `param1` = chosen item template id.
- Response: 4962 `opType = 4` -> fly animation to the bag (`SF:577-581`), then 4962 `opType = 5` -> remove the 5 items (`SF:583-587`) (assumption on sequencing: the client handles both separately). Bag update.

## 4. Server messages (server to client)

### 4962 (0x1362) `U_C_SACRIFICE_RSP`

- Message `SacrificeRspMsg` (package `active`): `opType` (#1, INT32) see table; `godsFavor` (#2, INT32) not read by the client (assumption: altar experience); `godsReward` (#3, INT32) not read (assumption: altar level, see `UpGradeTempInfos` Types 108); `times` (#4, INT32) sacrifices done today; `tempIds` (#5, STRING) rewards `itemId&count|itemId&count|...` (`SMOD:63-84`); `count` (#6, INT32) not read.
- Receiver: `SM.__sacrificeRspHandler` (`SM:51-62`) -> `SMOD.updateInfo` (`SMOD:20-42`) -> `SC.__infoUpdateHandler` (`SC:51-71`).

| opType | Client reaction |
|---|---|
| 1 | `openFrame`: times, pending rewards (empty `tempIds` = none) |
| 2 | `updateReward`: new reward set |
| 3 | `sacrifice`: times + reward set, play animation |
| 4 | `getRewarFlyAction`: chosen reward flies to the bag |
| 5 | `getRewardDisappearAction`: clear reward slots |

- Info tips key 24 is updated with `times` on opType 1 and 3 (`SM:56-59`), used for the planes list badge.

## 5. Rules and formulas

- Daily sacrifices: `sacrifice_max_times` = 3 (`SF:161`, `:360-369`); VIP increase through prerogative type 201 `para1` (`SF:371-391`, not called; assumption: server uses it).
- Offerings (`sacrifice_items_reward` = `1&2131121|2&2131122|3&2131123|4&2131124`): level 1..4.
- Refresh cost: `sacrifice_fresh_diamond` = 15 diamonds (client hardcodes 15).
- 5 rewards per sacrifice, choose exactly 1.
- Altar level: `UpGradeTempInfos` Types 108, 20 levels, `Data` = exp to reach the level (0, 150, 250, ..., 1950) (`SMOD:44-61`, unused); "Após elevar o Nível do Dependente do Deus Eterno, ao fazer sacriifícios podera aparecer mais itens raros ou prêmios." (assumption: each sacrifice adds favor exp; higher level improves the pool).
- Daily reset at 00:00 of `times` (assumption).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `sacrifice_max_times` = 3, `sacrifice_items_reward`, `sacrifice_fresh_diamond` = 15 | limits, offerings, refresh cost |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | Types 108, Grades 1..20 | `Data` exp per level |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 2131121..2131124 "Oferta ..." SonType 210 | offerings |

Reward pools per offering level are not in client data.

## 7. Persistent state

Schema `sacrifice`.

```sql
CREATE TABLE sacrifice.player_state (
  player_id            BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  day                  DATE        NOT NULL,
  times_today          SMALLINT    NOT NULL DEFAULT 0 CHECK (times_today >= 0),
  favor_exp            INTEGER     NOT NULL DEFAULT 0 CHECK (favor_exp >= 0),
  favor_level          SMALLINT    NOT NULL DEFAULT 1 CHECK (favor_level BETWEEN 1 AND 20),
  pending_offering_level SMALLINT  CHECK (pending_offering_level BETWEEN 1 AND 4),
  pending_rewards      JSONB,
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE sacrifice.reward_pool (
  offering_level       SMALLINT    NOT NULL CHECK (offering_level BETWEEN 1 AND 4),
  favor_level_min      SMALLINT    NOT NULL DEFAULT 1,
  item_template_id     INTEGER     NOT NULL,
  count                INTEGER     NOT NULL CHECK (count > 0),
  weight               INTEGER     NOT NULL CHECK (weight > 0),
  PRIMARY KEY (offering_level, favor_level_min, item_template_id, count)
);
```

`pending_rewards` = array of `{template_id, count}` (5 entries).

## 8. Backend implementation notes

- `sacrifice::altar::handle_request` dispatches 9543 by `opType`.
- `handle_open` (op 1): roll the day; reply op 1 with `times` and pending rewards.
- `handle_sacrifice` (op 4): validation order: no pending rewards -> times left (3 + VIP) -> offering template in the configured list -> owned. Transaction: remove item, roll 5 distinct rewards weighted from `reward_pool`, store pending, increment `times_today`, add favor exp. Reply op 3.
- `handle_refresh` (op 2): pending set exists; spend 15 diamonds (real diamonds); reroll with the same offering level; reply op 2.
- `handle_choose` (op 3): template id is in the pending set; grant item (mail if bag full); clear pending; reply op 4 then op 5.
- No battle, no pushes to other players.

## 9. Open questions and assumptions

- Request vs response op numbering is inferred from the controller (`SC:51-90`): request 3 = choose, request 4 = sacrifice; response 3 = sacrifice result, 4 = chosen, 5 = clear.
- Reward pools, favor exp gain and the meaning of `godsFavor`, `godsReward`, `count`.
- VIP sacrifice count values.

## 10. Implementation checklist

- [ ] Screen: `SacrificeFrame`
- [ ] Screen: room 9995 NPC dialog
- [ ] Route R1 op 1 open
- [ ] Route R2 op 4 sacrifice
- [ ] Route R3 op 2 refresh (15 diamonds)
- [ ] Route R4 op 3 choose
- [ ] Server message 4962 opTypes 1..5
- [ ] Tables `sacrifice.player_state`, `sacrifice.reward_pool`
- [ ] Rule: 3 per day plus VIP
- [ ] Info tips key 24 update
- [ ] Test: cannot sacrifice with pending rewards
- [ ] Test: refresh refused after choosing
