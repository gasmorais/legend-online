# Theseus arena: ranking, hall of fame and reports

Module `theseus_arena::ranking`. Prefixes as in [README.md](README.md).

## 1. Overview

- **Ranking** (op 12): cross server ladder of the current season ("Meu ranking" row for self; rank 0 shows "200+").
- **Hall of fame** (single only, op 6): top 3 of each past season with avatars and titles; the player can like each of the top 3 of the last finished season once (op 8), reward `theseus_pvp_like_reward` = -100,50000 (A: item -100 = gold, 50000).
- **Reports** (op 5): recent battles as attacker ("A") or defender ("D"), points delta, opponent, date; the red dot `redReport` flags unseen entries.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `theseuspvp.TheseusPvpServerSortFrame` | | ladder list: rank ("200+" when 0), name, server, head (`job`), points, stage; own row from `selfUserInfo` | scene right `SORT`; sends op 12 on open | 4314 (`M3/theseuspvp/TheseusPvpServerSortFrame.as:53-170`; rows `M3/theseuspvp/item/TheseuspvpSortItem.as:115-130`) |
| `theseusdoublepvp.TheseusDoublePvpServerSortFrame` | | MP ladder | `SORTDOUBLE`, op 12 | 577 |
| `theseuspvp.TheseusPvpGloryFrame` | | hall of fame pages by season ("{0} ——{1}" dates), 3 `TheseusPvpZanItem` with avatar, stage, title, like button | scene right `GLORY`; sends op 6 on open | 4315 (`M3/theseuspvp/TheseusPvpGloryFrame.as:57-265`; `M3/theseuspvp/item/TheseusPvpZanItem.as:90-200`) |
| `theseuspvp.TheseusPvpReportFrame` | Info do Combate | battle reports | bottom report button (`REPORT`); op 5 on open | 4316 (`M3/theseuspvp/TheseusPvpReportFrame.as:30`; `M3/theseuspvp/item/TheseusPvpReportItem.as:105-118`) |
| `theseusdoublepvp.TheseusDoublePvpReportFrame` | | MP reports | room list player view or room (`REPORTDOUBLE`), op 5 | 579 |

## 3. Routes (client to server)

| # | Action | Client sender | Request | Responses |
|---|---|---|---|---|
| K1 | Ladder | `TheseusPvpServerSortFrame()` (`:58`), `TheseusDoublePvpServerSortFrame()` (`:58`) | 9712 / 9736 `{op:12}` | 4314 / 577 |
| K2 | Hall of fame | `TheseusPvpGloryFrame()` (`:62`) | 9712 `{op:6}` | 4315 |
| K3 | Like | `TheseusPvpZanItem.zanHandler` (`:195-201`); enabled only on the page of the last finished season (`_keyList[pageMax-2]`) and when `likeInfo[slot] != 1` (`TheseusPvpGloryFrame.as:113-122`; `TheseusPvpZanItem.as:153-170`) | 9712 `{op:8, id:rank}` (rank 1..3 of the shown entry) | 4312 with `likeInfo` updated, reward items |
| K4 | Reports | `TheseusPvpReportFrame()` (`:30`), `TheseusDoublePvpReportFrame()` (`:30`), `TheseusPlayerListView.__zhanjiHandler` (`M3/theseusdoublepvproom/TheseusPlayerListView.as:111-115`) | 9712 / 9736 `{op:5}` | 4316 / 579, then 4312 / 575 with `redReport = false` |

## 4. Server messages (server to client)

| Opcode | Hex | Name | Body | Receiver |
|---|---|---|---|---|
| 4314 | 0x10DA | `U_C_THESEUS_PVP_RANK` | `TheseusPvpRankListMsg` | `__rankInfosHandler` (`TPM:282-305`), sorted by `rank` |
| 577 | 0x0241 | `U_C_THESEUS_PVPDOUBLE_RANK` | `TheseusMultiPvpRankListMsg` | `TPM:519-542` |
| 4315 | 0x10DB | `U_C_THESEUS_PVP_SHOW` | `TheseusPvpShowListMsg` | `__showInfosHandler` (`TPM:307-342`), grouped by `seasonId` |
| 578 | 0x0242 | `U_C_THESEUS_PVPDOUBLE_SHOW` | `TheseusMultiPvpShowListMsg` | `TPM:544-579` (no MP frame uses it) |
| 4316 | 0x10DC | `U_C_THESEUS_PVP_REPORT` | `TheseusPvpReportListMsg` | `__reportInfosHandler` (`TPM:344-365`) |
| 579 | 0x0243 | `U_C_THESEUS_PVPDOUBLE_REPORT` | `TheseusMultiPvpReportListMsg` | `TPM:581-602` |

- Rank row (`ranks` #1 repeated): `rank` (#1, INT32), `integral` (#2, INT32), `pvpId` (#3, INT32), `nickName` (#4, STRING), `serverName` (#5, STRING), `job` (#6, INT32, head icon), `fightCapacity` (#7, INT32), `uuid` (#8, STRING), `site` (#9, STRING, A: server site key).
- Show row (`shows` #1 repeated): `seasonId` (#1), `rank` (#2, 1..3), `integral` (#3), `pvpId` (#4), `startDate` (#5), `stopDate` (#6), `playerUid` (#7), `nickName` (#8), `serverName` (#9), avatar `arm` (#10), `cloth` (#11), `wing` (#12), `hat` (#13), `fashionArm` (#14), `fashionCloth` (#15), `hideFashion` (#16, BOOL), `isDragonTalker` (#17, BOOL), `job` (#18), `fightCapacity` (#19), `vipType` (#20), `heroTempId` (#21). A season with fewer than 3 entries shows "aguardando" (`ui.theseuspvp.waitRank`). The current season is always added as a page (empty) (`TheseusPvpGloryFrame.as:143-149`).
- Report row (`reports` #1 repeated): `integral` (#1, INT32, signed delta), `isWin` (#2, BOOL), `mode` (#3, INT32: 0 attacker "A", 1 defender "D"), `nickName` (#4), `serverName` (#5), `job` (#6), `fightCapacity` (#7), `fightDate` (#8, STRING, shown as is).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| L1 | Ladder ordering by points desc (A: ties by earliest reach); list limited to the top 200 ("200+") | `TheseuspvpSortItem.as:123` |
| L2 | Hall of fame = top 3 of each settled season; likes once per slot per season, only for the last settled season | `TheseusPvpGloryFrame.as:113-160` |
| L3 | Like reward `theseus_pvp_like_reward` = -100,50000 | config |
| L4 | Reports: last N battles (A: 20) for both roles | |

## 6. Templates

`TPL/TheseusPvpTmpls.xml` (stage names), `TPL/ConfigInfos.xml` `theseus_pvp_like_reward`, appellation templates for hall titles (`appellInfoTemplateCate`).

## 7. Persistent state

```sql
CREATE TABLE theseus_arena.hall_of_fame (
  mode            smallint NOT NULL,
  season_id       integer NOT NULL,
  rank            smallint NOT NULL CHECK (rank BETWEEN 1 AND 3),
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  points          integer NOT NULL,
  stage_id        integer NOT NULL,
  avatar          jsonb NOT NULL,                      -- arm, cloth, wing, hat, fashion, job, heroTempId, vipType
  PRIMARY KEY (mode, season_id, rank)
);

CREATE TABLE theseus_arena.hall_like (
  mode            smallint NOT NULL,
  season_id       integer NOT NULL,
  rank            smallint NOT NULL,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  liked_at        timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (mode, season_id, rank, player_id)
);
```

Reports come from `theseus_arena.match` / `multi_match_player` ([single-match.md](single-match.md), [multi-rooms.md](multi-rooms.md)).

## 8. Backend implementation notes

- `theseus_arena::ranking::handle_rank` (op 12): top 200 of `player_state` by points for the season, cross server.
- `handle_show` (op 6): all `hall_of_fame` rows for mode 1.
- `handle_like` (op 8): `id` = rank; validate last settled season, not yet liked; insert `hall_like`; grant L3; send 4312 with `likeInfo`.
- `handle_reports` (op 5): last N matches of the player, attacker and defender; clear `red_report`.
- Season settlement writes `hall_of_fame` from the final ladder.

## 9. Open questions and assumptions

- (A) Meaning of `site`, list size, report count, like reward item -100.

## 10. Implementation checklist

- [ ] Ops 5, 6, 8, 12 for the relevant modes
- [ ] 4314/577, 4315, 4316/579
- [ ] Tables `hall_of_fame`, `hall_like`
- [ ] Tests: like twice, like old season, rank 0 display
