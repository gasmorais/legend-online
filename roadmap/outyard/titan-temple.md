# Titan temple ("Santuário de Titã")

Feature [outyard](README.md), module `titan-temple`. Protobuf package `titanland` (registered under [dragon](../dragon/README.md), which owns the titans themselves). Aliases in [README.md](README.md).

## 1. Overview

- A 5 level tower of opponents: each level shows 4 opponents (other players' titan teams, `TitanlandBoosMsg`). The player challenges them from the bottom up ("Os jogadores podem desafiar progressivamente os adversários de baixo para cima"); opponent HP persists between fights ("No final do combate a vida do adversário é mantida"); when all opponents are beaten new ones are generated.
- Challenges: `titanland_fightcount_buy = 100,8,10` (8 per day, buy more at 100 diamonds, up to 10 bought).
- Blessings: 3 temple skills (`titanland_skill = 41101001,41101002,41101003`), owned counts start at 3 and can be bought at 100 diamonds up to 5 (`titanland_skillcount_buy`). They are used in the temple battles ("Apenas é válido no santuário de titã").
- Domain bonus by number of owned titans (`titanland_buff = 1,41102001|2,41102002|3,41102003|5,41102004|7,41102005|9,41102006`), shown as "Contém {0} titãs".
- Level clear rewards: `TitanlandDrop.xml` items 208059 and 208060 per level.
- Open 06:00..23:00 (`huge_titan_open_time`); requires the class change ("Necessário atingir profissão cavaleiro para entrar").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `OY/titan/OutyardTitanFrame.as` (922 x 680) | help "Ajuda do Santuário de Titã" / "Explicação do Santuário de Titã" | Tower with 5 level rows, progress, challenges left with "+" (op 2); sends op 0 on open (`:68-250`); Magic Spring buffer 15 display | `SwitchPageHelp.openTitanTemple` (`decompiled/core_module/scripts/yishi/SwitchPageHelp.as:2331-2349`): NPC node 40 option 118, daily guide 72, link 219; after a 3860 battle (`decompiled/m3/scripts/map/space/SpaceSceneController.as:326-329`) | 375 |
| `OY/titan/OutyardTitanView.as` | | Embedded variant with the same logic (`:64-192`) | | |
| `OY/titan/OutyardTitanPlayerView.as`, `OY/titan/OutyardTitanPlayerItem.as` | | One level row: 4 opponents with HP bars, level reward chest tip, grayed when locked (`OutyardTitanPlayerView.as:61-104`); click shows the player menu | frame | `bossInfo` filtered by `level` |
| `OY/titan/OutyardTitanRightView.as` | "Contém {0} titãs", "Contém {0}+ titãs", "(Apenas é válido no santuário de titã)", "(As chances são atualizadas diariamente)" | Blessing buttons with counts, domain bonus list, challenge button (`:63-254`) | frame | `skillCount1..3`, `fightLeftCount` |

## 3. Routes (client to server)

Send 9617 (0x2591) `C_TITAN_LAND_OP`, `TitanlandOpMsg` (package `titanland`; request uses `op` (#1, ENUM `TitanlandOpState`), `payType` (#2, INT32), `skillIndex` (#3, INT32)). Sender `OutyardManager.OperateTitan(op, payType, skillIndex)` (`OM:314-322`). Ops: 0 OPEN, 1 BUY_SKILL, 2 BUY_FIGHT_COUNT, 3 FIGHT, 4 UPDATE, 5 CLOSE, 6 STATUS (`decompiled/core_module/scripts/com/road/yishi/proto/titanland/TitanlandOpState.as`).

| # | op | UI and sender | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|
| T1 | 0 OPEN | frame open (`OY/titan/OutyardTitanFrame.as:73`) | class changed; 06:00..23:00 | | 375 `op = 0` (client resets the 5 rows) |
| T2 | 1 BUY_SKILL | blessing buttons (`OY/titan/OutyardTitanRightView.as:174-243`) | `skillCountN < 5` else "Compra de habilidades já atingiu o limite máximo"; confirm "Deseja consumir {0} diamantes para comprar esta habilidade?" with bound option; diamonds | `payType` 0 bound first / 1 real, `skillIndex` 1..3 | 375 with the new count, player info 3 |
| T3 | 2 BUY_FIGHT_COUNT | "+" (`OY/titan/OutyardTitanFrame.as:186-235`) | `10 - fightAddCount > 0` else "Limite de compras atingida"; confirm "Deseja consumir {0} diamantes para comprar 1 chance de desafiar? (Hoje ainda pode comprar {1}x)"; diamonds | `payType` | 375, player info 3 |
| T4 | 3 FIGHT | "Desafiar" (`OY/titan/OutyardTitanRightView.as:188-197`) | `fightLeftCount > 0` else "Chances de desafio insuficiente, não é possível desafiar" | | battle start (battleType 3860) against the current opponent; after: 375 with HP and level |

Ops 4, 5, 6 have no client sender (server pushes).

## 4. Server messages (server to client)

### 375 (0x0177) `U_C_TITAN_LAND`

`TitanlandOpMsg`: `op` (#1, ENUM) 0 open (full redraw) or other; `payType` (#2); `skillIndex` (#3); `fightLeftCount` (#4, INT32); `fightAddCount` (#5, INT32) challenges bought today; `skillCount1..3` (#6..#8, INT32); `bossHp1..4` (#9..#12, INT32) HP % of the 4 opponents of the current level; `curLevel` (#13, INT32) 1..5; `bossInfo` (#14, `TitanlandBoosMsg`, repeated: `userId` #1, `orderId` #2 ranking id, `nickName` #3, `job` #4, `level` #5 tower level); `status` (#15, INT32). Handler `OutyardTitanModel.titanHandler` (`OMOD/OutyardTitanModel.as:20-74`, via `OM:181-187`): sets each opponent's display HP (current level from `bossHpN`, lower levels 100, upper levels 1).

## 5. Rules and formulas

- Config: `huge_titan_open_time = 6:00-23:00`, `titanland_skill`, `titanland_buff`, `titanland_fightcount_buy = 100,8,10`, `titanland_skillcount_buy = 100,3,5|100,3,5|100,3,5`.
- Reset skill id constant `OutyardTitanModel.ResetSkill = 41101001`.
- Daily reset of challenges and skill counts ("As chances são atualizadas diariamente").
- Opponents: 4 per level x 5 levels, chosen from players with titans (assumption: by ranking `orderId`).

## 6. Templates

| File | Fields |
|---|---|
| `raw/xml/tempinfos/TitanlandDrop.xml` (`outyardTitanTemplateCate`) | `level` 1..5, `itemId` 208059 / 208060, `count`, `ValidDate` |
| `ConfigInfos.xml` | keys above |

## 7. Persistent state

```sql
CREATE TABLE outyard.titan_temple_state (
  player_id        BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  day              DATE        NOT NULL,
  cur_level        SMALLINT    NOT NULL DEFAULT 1 CHECK (cur_level BETWEEN 1 AND 5),
  fights_left      SMALLINT    NOT NULL DEFAULT 8,
  fights_bought    SMALLINT    NOT NULL DEFAULT 0 CHECK (fights_bought BETWEEN 0 AND 10),
  skill_counts     SMALLINT[]  NOT NULL DEFAULT '{3,3,3}'
);

CREATE TABLE outyard.titan_temple_opponent (
  player_id        BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  level            SMALLINT NOT NULL CHECK (level BETWEEN 1 AND 5),
  slot             SMALLINT NOT NULL CHECK (slot BETWEEN 1 AND 4),
  opponent_id      INTEGER  NOT NULL,
  order_id         INTEGER  NOT NULL,
  hp_percent       SMALLINT NOT NULL DEFAULT 100 CHECK (hp_percent BETWEEN 0 AND 100),
  PRIMARY KEY (player_id, level, slot)
);
```

## 8. Backend implementation notes

- `outyard::titan_temple::handle_op` (9617) dispatching OPEN, BUY_SKILL, BUY_FIGHT_COUNT, FIGHT.
- Fight: within opening hours, `fights_left > 0`, pick the first living opponent of `cur_level`; build battle 3860 with the player's titans plus domain buffs and temple blessings vs the opponent's titans with persisted HP; on end persist HP; when the 4 opponents of the level die grant `TitanlandDrop` for the level and advance; after level 5 regenerate opponents.
- Daily reset of counts.

## 9. Open questions and assumptions

- Opponent selection, `status` meaning, whether blessings are consumed per battle.
- Battle composition for titans (dragon feature).

## 10. Implementation checklist

- [ ] Screens: titan frame, level rows, right view
- [ ] Routes T1..T4 on 9617
- [ ] Server message 375
- [ ] Tables `outyard.titan_temple_state`, `outyard.titan_temple_opponent`
- [ ] Template loader `TitanlandDrop.xml`
- [ ] Battle 3860 with persistent opponent HP
- [ ] Daily reset
