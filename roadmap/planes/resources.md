# Planes mines and occupation income

Feature [planes](README.md), module `resources`. Aliases in [README.md](README.md).

## 1. Overview

- Mines ("Mina Comum" 50001/500001, "Mina Elite" 50002/500002, EventType 5, `EnergyCost` 100) are occupied by triggering them in the grid ([events.md](events.md)). An occupied mine produces bound diamonds periodically: `Parameter` = `totalMinutes,intervalMinutes,rewardId,count` = `1440,60,-500,20` (common) or `1440,60,-500,50` (elite): 20 or 50 bound diamonds per hour for 24 hours.
- "Informação de Planos de mina" (`PlanesResourceFrame`) lists the occupied mines with remaining time, next reward time and accumulated rewards; "Coletar" collects (op 31).
- Occupied layers (guardian 14001 beaten) give daily items `DailyRewards` by mail ("O lucros são enviados directamente para o e-mail") and permanent per mille resistance bonuses ("Adição dos efeitos de cristal": "Anti-RES: +{0}‰", "Anti-Fogo: +{0}‰", ...), summed in the planes list ([transmitter.md](transmitter.md)).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `PRF` (`PlanesResourceFrame`) | "Informação de Planos de mina" | Paged list of occupied mines, 1 s countdown | "Informação de Planos de mina" button in the list (`PLV:286-290`) and in the scene left view (`M3P/view/PlanesLeftView.as:106-110`); sends op 30 on open (`PRF:55-62`) | `planesResourceList` |
| `PRIV` (`PlanesResourceItemView`) | "Tempo restante: {0}", "Tempo do próximo prêmio: {0}", "Prêmio acumulado", "Ainda não chegou  o tempo de coleta, favor aguardar" | One mine row and collect button | `PRF` | event `Name`, reward item `Parameter[2]` x `Parameter[3]`, `canGetCount` |
| `M3P/view/PlanesRightView.as` | "Após completar este piso pode no máximo produzir adicionalmente:" | Current layer rewards and bonuses | scene | `DailyRewards`, `*ResiBonus` |
| `decompiled/m16/scripts/yishi/view/tips/PlanesRewardTip.as` | "Ganhos da conquista de planos", "Lucro do Plano de Recursos", "Lucro do Plano de Resistência" | Income tooltip | planes list | totals |

## 3. Routes (client to server)

### R1. Mine list (op 30)

- UI: opening `PRF` (`PRF:60`).
- Request: 9527 `op = 30`.
- Response: 4978 `U_C_PLANES_WAR_RESOURCE_LIST`.

### R2. Collect a mine (op 31)

- UI: "Coletar" (`PRIV:84-92`). Client check: `canGetCount > 0`, else "Ainda não chegou  o tempo de coleta, favor aguardar".
- Request: 9527 `op = 31`, `param = [layerId, posX, posY]`.
- Response: currency push (bound diamonds) and 4978 with the updated list (`can_reward_count = 0`). Expired mines with nothing left are removed (assumption).

## 4. Server messages (server to client)

### 4978 (0x1372) `U_C_PLANES_WAR_RESOURCE_LIST`

- Message `PlanesResourceListMsg`: `resourceList` (#1, MESSAGE `PlanesResourceMsg`, repeated).
- `PlanesResourceMsg`: `layer_id` (#1, INT32); `pos_x` (#2, INT32); `pos_y` (#3, INT32); `event_id` (#4, INT32) mine event; `total_count_down` (#5, INT64) ms until the mine stops producing; `next_reward_count_down` (#6, INT64) ms until the next tick; `can_reward_count` (#7, INT32) ticks accumulated and not collected.
- Receiver: `PWM.__updatePlanesResourceHandler` (`PWM:243-265`) -> `PLANES_RESOURCE_UPDATE` -> `PRF.__resourceUpdateHandler` (`PRF:135-143`).
- Client side projection while open (`PRIV:141-152`): `canGetCount = base + int((I*60 - baseTotal % (I*60) + baseTotal - totalLeft) / I / 60)` with I = interval minutes, so the server must send consistent countdowns.
- When: reply to op 30 and op 31.

## 5. Rules and formulas

- Mine production: one tick every `Parameter[1]` minutes during `Parameter[0]` minutes after occupation; each tick adds `Parameter[3]` of reward `Parameter[2]` (-500 = bound diamonds, assumption). Max 24 ticks.
- Layer daily rewards (`PlanesLayers.DailyRewards`): `208028,100|208030,35` (Secundário/Baixo), `208028,200|208030,65`, `208028,380|208030,125` by size. Sent by mail every day for each occupied layer (assumption: 00:00 job).
- Resistance bonuses: `ReduceResiBonus` 10/20/30, element bonuses 5/15/20 (per mille) per occupied layer, summed per player (`PMOD:186-259`); applied to hero attributes ([hero](../hero/README.md)).

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/PlanesEvents.xml` | EventType 5 mines (50001, 50002, 500001, 500002) | `Name`, `EnergyCost`, `Parameter` |
| `raw/xml/tempinfos/PlanesLayers.xml` | layers | `DailyRewards`, `ReduceResiBonus`, `FireResiBonus`, `WaterResiBonus`, `ElectResiBonus`, `WindResiBonus`, `DarkResiBonus`, `LightResiBonus` |

## 7. Persistent state

```sql
CREATE TABLE planes.mine (
  layer_id             BIGINT      NOT NULL REFERENCES planes.layer(layer_id) ON DELETE CASCADE,
  x                    SMALLINT    NOT NULL,
  y                    SMALLINT    NOT NULL,
  player_id            BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  event_id             INTEGER     NOT NULL,
  occupied_at          TIMESTAMPTZ NOT NULL DEFAULT now(),
  ends_at              TIMESTAMPTZ NOT NULL,
  collected_ticks      SMALLINT    NOT NULL DEFAULT 0 CHECK (collected_ticks >= 0),
  PRIMARY KEY (layer_id, x, y)
);
CREATE INDEX mine_player_idx ON planes.mine (player_id);

CREATE TABLE planes.daily_reward_log (
  player_id            BIGINT     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  layer_id             BIGINT      NOT NULL REFERENCES planes.layer(layer_id) ON DELETE CASCADE,
  day                  DATE        NOT NULL,
  PRIMARY KEY (player_id, layer_id, day)
);
```

Accumulated ticks = `min(24, floor((min(now, ends_at) - occupied_at) / interval)) - collected_ticks`.

## 8. Backend implementation notes

- `planes::resources::handle_list` (op 30): compute countdowns from `mine` rows; reply 4978.
- `planes::resources::handle_collect` (op 31): lock the row, compute ticks, grant `ticks * count` bound diamonds, update `collected_ticks`, delete when expired and fully collected; reply 4978.
- `planes::resources::occupy_mine` (called from [events.md](events.md) trigger): energy 100 (with resistance formula), insert `mine`.
- Daily job: for each occupied layer mail `DailyRewards` once per day (`daily_reward_log`).
- Resistance bonuses are derived data: recompute the hero attribute cache when a layer occupation changes.

## 9. Open questions and assumptions

- Whether mines can be stolen by other players (PvP config exists, no client flow).
- Meaning of reward id -500 (assumed bound diamonds from the "diamantes vinculados" description).
- Daily reward schedule and mail template.

## 10. Implementation checklist

- [ ] Screen: `PlanesResourceFrame` and item countdown
- [ ] Route R1 op 30 -> 4978
- [ ] Route R2 op 31 collect
- [ ] Server message 4978 `PlanesResourceListMsg`
- [ ] Tables `planes.mine`, `planes.daily_reward_log`
- [ ] Job: daily layer rewards by mail
- [ ] Rule: resistance bonuses applied to hero
- [ ] Test: tick math matches client projection
