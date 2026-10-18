# Link game ("Labirinto do Tesouro", llk)

Feature `mazes`, module `link-game`. Client: `M11/llk/view/*` (7 classes), `CM/managers/LlkManager.as`, `CM/mvc/module/llk/*`, `CM/mvc/controler/LlkController.as`. Proto package `linkgame` (`LinkGameMsg`). Conventions: see [README.md](README.md).

**Status: dormant in this client.** No code calls `LlkManager.opLlkFrame` or `opSortFrame` from outside the module, and `LlkManager.setup` (`CM/managers/LlkManager.as:117-119`, called at login `CM/yishi/lunch/Yishi.as:424`) registers no listener: `__llkInfoHandler` and `__llkSortHandler` are never attached, so the frame would never receive data. The same opcodes are used by the air garden variant (`CM/managers/AirGardenGameLlkManager.as`, listens to 4736, owned by [../seasonal-events/README.md](../seasonal-events/README.md)) and the monopoly variant (8877/4759, [../casino/README.md](../casino/README.md)). Implement this module only if the standalone link game is re-enabled; the protocol below is what the dormant handlers expect.

---

## 1. Overview

- Board of 8 rows x 14 columns (`LlkModel.ROW`, `COLUMN`, `CM/mvc/module/llk/LlkModel.as:10-12`); the outer ring is empty so that paths can go around; playable cells are rows 1..6, columns 1..12 (`M11/llk/view/LlkFrame.as:620-660`).
- Two equal tiles are removed when they can be linked by a path with at most two turns through empty cells (`LlkModel.checkByPos`, `oneCorner`, `twoCorner`, `connectRow`, `connectCol`, `:54-264`).
- Each level ("Check point", `tollgate`) costs stamina to start; clearing the board gives score; faster clears give more score; removing pairs within 3 s builds combos (help text `llk.view.LlkFrame.helpTxt`).
- Tools: bomb (removes a pair), reshuffle ("Baralhar Cartas"); both can be bought with diamonds.
- Five score boxes (`scoreValue` thresholds) with claim flags (`reward`); "get all" moves won items to the bag; a ranking shows titles "Caçador de tesouros", "Mestre dos Tesouros", "Amante dos Tesouros" for the top 3.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `llk.view.LlkFrame` (`M11/llk/view/LlkFrame.as`), controller `llk` openType `LLK_FRAME` (`CM/mvc/controler/LlkController.as`) | "Labirinto do Tesouro" (`llk.view.LlkFrame.title`) | Board | none (dormant) | Level number, score, stamina, time, 5 boxes with progress bar (`:540-575`), goods items (bomb, reshuffle), bag view, start button when the board is empty |
| `llk.view.LlkGoodsItem` | "Bomba", "Baralhar Cartas" | Use or buy a tool | Frame | Counts `bombCount`, `resetCount`; buy prices `linkgame_bomb_need`, `linkgame_reset_need` (default 10 diamonds, `:54-68`) |
| `llk.view.LlkBoxItem` | none | Score box | Frame | Claim at `scoreValue[i]` (`:130-140`) |
| `llk.view.LlkSortFrame`, `LlkSortItemView` | ranking | Ranking | Ranking button | Order, nickname, level reached, score, title |

---

## 3. Routes (client to server)

Opcode **8859 (0x229b) C_LINKGAME_OP**, body `linkgame.LinkGameMsg` (`CM/managers/LlkManager.as:74-110`):

| Field | Tag | Type | Meaning in requests |
|---|---|---|---|
| `op_type` | #1 | INT32 | 1 open, 2 use bomb, 3 reshuffle, 4 delete pair, 5 buy stamina, 6 buy bomb, 7 buy reshuffle, 8 ranking, 9 get all items, 10 claim score box, 11 close, 12 start level (`LlkManager.as:30-52`) |
| `a_x`, `a_y` | #2, #3 | INT32 | first tile row, column (op 4) |
| `b_x`, `b_y` | #4, #5 | INT32 | second tile row, column (op 4) |
| `param1` | #12 | INT32 | ops 5, 6, 7: 0 = bound diamonds allowed, 1 = diamonds only; op 10: box level 0..4 |

Other fields (`score #6`, `time #7`, `strength #8`, `points #9 STRING`, `bomb_count #10`, `reset_count #11`, `tollgate #13`, `reward #14 STRING`, `comb_count #15`, `add_score #16`, `point_value #17`, `scoreValue #18 repeated INT32`) are response fields.

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| K1 | Frame shown, after daily reset prompt | `LlkFrame` (`:400-403`) | | `{op_type=1}` | 4736 |
| K2 | "Iniciar" | `LlkFrame.__startBtnHandler` (`:405-418`) | stamina > 0, else buy prompt "Stamina insuficiente, Deseja Consumir {0} Diamantes para comprar?" (`linkgame_strength_need`, default 10) | `{op_type=12}` | 4736 with a new board |
| K3 | Buy stamina and start | `LlkFrame.confirmCall` (`:520-535`) | diamonds | `{op_type=5, param1}` then `{op_type=12}` | 4736 |
| K4 | Click two linkable tiles | `LlkFrame.__clickHandler` (`:614-660`) → `LlkManager.llkDelete` (`:100-110`) | path check client side | `{op_type=4, a_x, a_y, b_x, b_y}` | 4736 with the removed pair, combo and added score |
| K5 | Bomb / reshuffle | `LlkGoodsItem` (`M11/llk/view/LlkGoodsItem.as:150-182`) | count > 0 and level started ("Check point ainda não iniciou") | `{op_type=2}` / `{op_type=3}` | 4736 |
| K6 | Buy bomb / reshuffle | `LlkGoodsItem.buyAlertBack` (`:230-256`) | confirmation ("Deseja Consumir{0} Diamantes para comprar 1 Bomba") | `{op_type=6 or 7, param1}` | 4736 |
| K7 | Ranking | `LlkFrame.__sortBtnHandler` (`:425-432`) | | `{op_type=8}` | 4737 |
| K8 | Get all items | `LlkFrame.__allGetBtnHandler` (`:434-437`) | | `{op_type=9}` | bag pushes |
| K9 | Claim a box | `LlkBoxItem` (`M11/llk/view/LlkBoxItem.as:130-140`) → `llkGetScoreReward(level)` (`LlkManager.as:82-89`) | score reached, not claimed | `{op_type=10, param1=level}` | 4736 (`reward` flags) |
| K10 | Close | `LlkFrame.dispose` (`:680-690`) | | `{op_type=11}` | none |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Expected client handler | When | Reaction (as coded) |
|---|---|---|---|---|---|
| **4736 (0x1280)** | U_C_LINK_GAME_INFO | `LinkGameMsg`: `score (#6)`, `time (#7)` level timer, `strength (#8)` stamina, `points (#9, STRING)` 112 comma separated tile values (0 = empty), `bomb_count (#10)`, `reset_count (#11)`, `tollgate (#13)` level, `reward (#14, STRING)` "0,1,0,0,0" claimed flags, `scoreValue (#18, repeated)` 5 box thresholds, and for a removal `a_x/a_y/b_x/b_y (#2..#5)`, `point_value (#17)` tile value, `comb_count (#15)`, `add_score (#16)` | `LlkManager.__llkInfoHandler` (`CM/managers/LlkManager.as:121-185`), never registered | After every op | Updates the model, queues the removal animation, rebuilds the board when `points` has 112 values, notifies `LLK_INFO` |
| **4737 (0x1281)** | U_C_LINK_GAME_ORDER | `pet.PetBossScoreMsg`: `order (#1, INT32)` own rank; `infos (#5, ScoreInfoMsg, repeated)` with `nickName (#1)`, `order (#2)`, `score (#3)`, `team_id (#4)` used as user id, `job (#5)` used as level reached; other fields `score #2`, `property1 #3`, `property2 #4`, `remain_time #6`, `wound #7` unused | `LlkManager.__llkSortHandler` (`:198-228`), never registered | Response to op 8 | Ranking list with titles for orders 1..3 |
| **4738 (0x1282)** | U_C_LINK_GAME_RESET | no field read | `LlkFrame.__resetHandler` (`M11/llk/view/LlkFrame.as:355, 389-399`) | Daily reset while the frame is open | Alert "Reset do Check point", then op 1 |

---

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Board | 8 x 14 with an empty border; 72 playable cells | `LlkModel` |
| Link rule | straight, one turn or two turns through empty cells | `LlkModel.checkByPos` |
| Prices | stamina `linkgame_strength_need`, bomb `linkgame_bomb_need`, reshuffle `linkgame_reset_need`; all absent from the local config, client default 10 diamonds | `LlkFrame.as:167-172`, `LlkGoodsItem.as:54-68` |
| Score | faster clears and combos (< 3 s between pairs) give more | help text |
| Boxes | 5 thresholds from `scoreValue`; tips from `TollgateReward.xml` (empty locally) | `LlkFrame.as:155-166` |
| Reset | daily (4738) | |

---

## 6. Templates

`raw/xml/tempinfos/TollgateReward.xml` (`TollgateRewardCate`, loaded `CM/yishi/manager/TempleteManager.as:1206`) is empty in the local data. Config keys `linkgame_*` are absent.

---

## 7. Persistent state (PostgreSQL, schema `mazes`)

```sql
CREATE TABLE mazes.link_game_state (
  player_id     integer  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  level         smallint NOT NULL DEFAULT 1,
  board         smallint[] NOT NULL DEFAULT '{}',   -- 112 values, empty when no level is running
  level_started_at timestamptz,
  score         integer  NOT NULL DEFAULT 0,
  stamina       smallint NOT NULL DEFAULT 0,
  bombs         smallint NOT NULL DEFAULT 0,
  reshuffles    smallint NOT NULL DEFAULT 0,
  box_claimed   boolean[] NOT NULL DEFAULT '{false,false,false,false,false}',
  last_pair_at  timestamptz,
  combo         smallint NOT NULL DEFAULT 0,
  day           date     NOT NULL
);
```

---

## 8. Backend implementation notes

- The original client never registers the 4736/4737 listeners of `LlkManager` and has no entry point. The project principles (run the original code, patch generated code only for decompiler artifacts) mean the standalone link game stays unreachable; no server work is required for it. The air garden and monopoly variants are implemented by their own features with the same opcodes.
- Handlers would be `mazes::link_game::handle_op` dispatching on `op_type`, validating the pair path on the server with the same two-turn rule, timers for level time and combos, and daily reset with 4738 to online players.

---

## 9. Open questions and assumptions

- Whether the standalone link game should ship at all (no entry point in this client).
- Stamina regeneration, level layouts, score formula and box rewards are unknown.

---

## 10. Implementation checklist

- [ ] Confirm with the air garden and monopoly owners that 8859/4736 (and 8877/4759) are implemented there.
- [ ] Only if a future client build exposes the standalone game: table `mazes.link_game_state`, route 8859 ops 1..12, pushes 4736/4737/4738, server side path validation.
