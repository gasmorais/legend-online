# Auto chess rounds and battles

Module `auto_chess::rounds`. Citation prefixes: see [README.md](README.md).

## 1. Overview

The server drives the match: a preparation phase (`state = 1`, 46 s in round 1, 31 s afterwards), then a battle phase where players are paired and each pair fights an automatic battle of type 349 built from their `battleAry`. After the battles the server applies HP loss, income and streaks, increments `round`, refreshes unlocked shops and starts the next preparation. Players at HP 0 are eliminated; the last alive wins.

Design reference: `docs/battle/chess-modes.md` B.1, B.2, B.4, B.7 (how `chessList` enters the battle), and `docs/battle/formation.md` for the 3x4 battle grid.

## 2. Screens

| Class | Purpose |
|---|---|
| `SelfChessTopView` | round label: `round <= 2` -> stage 1, sub = round; else stage = `ceil((round-2)/5 + 1)`, sub = `(round-2) % 5` (0 -> 5) (`CH/SelfChessTopView.as:45-71`); countdown 46 s (round 1) or 31 s when `state == 1`, else "Aguardando a batalha terminar" (`:73-93`) |
| Battle scene (battleType 349) | normal battle client with `SelfChessRoleView` pieces, no bottom bar; returns to `SELF_CHESS_SCENE` at the end (`CM/battle/handler/BattleResultHandler.as:293-295`) |

## 3. Routes (client to server)

None specific. The battle client sends the usual battle acknowledgements of the generic pipeline (see `docs/battle/README.md`).

## 4. Server messages (server to client)

| Opcode | Message | When | Effect |
|---|---|---|---|
| 4216 op 9 | `ChessRoomMsg` with `state = 1` and new `round` | start of each preparation | timer starts; full redraw |
| 4216 op 9 | `ChessRoomMsg` with `state = 2` (A: any value other than 1) | end of preparation | "Aguardando a batalha terminar" |
| 157 `BattlePrepareMsg` (`battleType = 349`) | pieces in `chessList` (#29, `HeroMsg` repeated): `tempId` = AutoChess template, `heroId`, `livingId2` = owner userId, `nickName`, `pos`, `side`, `maxHp`, `hp`, `hp2`, `sp`, `skillId[]`, `awake`, `qteTime`, `castTime` (`CM/map/internals/utils/SocketGameReader.as:397-445`); soldiers via the usual army lists; the player's own heroes/pets are not added (`CM/battle/transaction/CreateGameTransaction.as:126-141`) | per pair | battle plays automatically |
| battle stream (156, 153..., 154, 4103) | generic | during the battle | |
| 4219 `param1 = 1` | "Oponente sem herói em batalha. Obteve Vitória!" | the opponent has no unit on the field: no battle, automatic win | tip |
| 4216 op 9 | new `hp`, `gold`, `winCount`, `grade`, `exp`, `cardPool`, `rank` | after all battles | full redraw |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Start HP | 100 | `CH/item/SelfChessPlayerItem.as:65-83` |
| Preparation time | round 1: 46 s; later: 31 s | `CH/SelfChessTopView.as:81-84` |
| HP loss | winner loses nothing; loser loses HP based on the winner's remaining pieces (A: sum of `Hit` of surviving pieces, `Hit` = 1/2/4 at Grade 1 to 4/6/8 at Grade 5 by star) | `sevenyear.selfchess.helpContent`; `TPL/AutoChessHeroInfos.xml` `Hit` |
| Income per round | base +5, interest `min(5, floor(gold/10))`, streak bonus (win or loss) 2-5 -> +1, 6-8 -> +2, 9+ -> +3 | `selfchess.point.addTip`; `CH/SelfChessBottomLeftView.as:148-149` |
| Streak | `winCount` > 0 wins, < 0 losses | `SelfChessPlayerMsg.winCount` |
| Free XP | (A) +1 XP per round as in common auto-chess rules; the client does not show it |
| Shop refresh | automatic each round unless `lock = 1` (lock then resets) | `selfchess.lockBtn.Tip` |
| Synergies | count distinct `MasterType` on the field per class and race; tiers from `AutoChessBuffInfos` (`Amount`), applied as skills `SkillId` in battle (`AcceptObject` 2 all units, 3 synergy units) | `CM/mvc/module/chess/SelfChessModel.as:116-169`; `CM/yishi/datas/templates/cate/SelfChessBuffTampCate.as:43-65` |
| Field to grid | slots 1-4 back column (grid 3, 6, 9, 12), 5-8 front column (grid 1, 4, 7, 10) (declared, unused `_standPos`) | `CH/SelfChessHeroTeamView.as:18`; use explicit `HeroMsg.pos` |
| PvE rounds | 19 Grade 0 "Apolo (monstro)" templates (MasterType 91-97) in groups of 1, 2, 2, 3, 3, 4, 4 (A: creep rounds, e.g. rounds 1-2 and every 5th) | `TPL/AutoChessHeroInfos.xml` |
| Pairing | (A) random pairs among alive players, avoiding the previous opponent; with an odd count one player fights a copy (ghost) of an eliminated or random player |
| Elimination | HP <= 0 -> placement = number of alive players + 1 | |

## 6. Templates

`TPL/AutoChessHeroInfos.xml` (stats: `Attack`, `Defence`, `MagicAttack`, `MagicDefence`, `Live`, `Parry`, `ForceHit`, `DefaultSkill`, `SkillScript` per star, `Scale`, `ResType`, `ResPath`), `TPL/AutoChessBuffInfos.xml`, `TPL/UpGradeTempInfos.xml` Types=81.

## 7. Persistent state

In memory. Optional per-round log for debugging:

```sql
CREATE TABLE auto_chess.round_log (
  room_uuid     UUID NOT NULL,
  round         SMALLINT NOT NULL,
  player_id     BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  opponent_id   BIGINT,
  won           BOOLEAN NOT NULL,
  hp_after      SMALLINT NOT NULL,
  gold_after    SMALLINT NOT NULL,
  PRIMARY KEY (room_uuid, round, player_id)
);
```

## 8. Backend implementation notes

- `ChessRoom` actor with a phase timer: Preparation(46/31 s) -> Battle -> Resolve -> next round.
- Battle phase: snapshot each `battleAry`; for each pair build a battle 349 through the battle engine (`docs/battle/server-engine.md`): two sides, pieces as `HeroMsg` in `chessList` with stats from templates scaled by star, synergy skills, `livingId2` = owner. Send 157 and the stream to both players of the pair. Run all pairs in parallel; the phase ends when all battles end (A: or a hard timeout of 60 s).
- Resolve: HP loss, streaks, income, auto shop refresh (respect lock), free XP (A), eliminations; broadcast 4216 op 9; check game over ([game-over.md](game-over.md)).
- Ops from [preparation.md](preparation.md) are refused outside `state == 1`.
- Disconnected players keep playing with their current board (A).

## 9. Open questions and assumptions

- (A) HP loss formula (`Hit` meaning), pairing, PvE round schedule, free XP, battle timeout.
- (A) `state` value used during battles (the client only tests `state == 1`).

## 10. Implementation checklist

- [ ] Phase scheduler with 46/31 s preparation.
- [ ] Pairing and ghost opponent.
- [ ] Battle 349 builder with `chessList`, star stats and synergy skills.
- [ ] Auto win tip 4219 = 1 when the opponent has an empty field.
- [ ] HP loss, streaks, income, interest, auto refresh with lock.
- [ ] Eliminations and placement.
- [ ] 4216 op 9 at every phase change.
- [ ] Tests: empty field both sides, all losses streak income, lock across rounds, elimination order ties.
