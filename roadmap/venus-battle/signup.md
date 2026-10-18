# Venus battle: main panel and couple signup

Module `venus_battle::signup`. Prefixes as in [README.md](README.md).

## 1. Overview

Opening the main frame always sends 8979 (empty body); the server answers 4799 with the global state, the couple's info and the ranking rows. The captain of a two member team made of the married couple signs up for 2000000 gold. Before the fight window the frame shows "Equipe de Casal", cost and `openTime`; once signed or open it shows the join button and the turn progress.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `matelords.MatelordsFrame` | Batalha de Vênus | signup, join room, couple display, links help and ranking, shop | controller `matelords` default openType (`CM/mvc/controler/MatelordsController.as:22-33`) | not signed and not open: signup button, "Equipe de Casal", "{0}Ouro" (`Mate_Join`), `openTime`; signed or open: join button; open: round digits (`warIndex`) and turn "{n}/{max}"; signed: `openTime` as "next", "Equipe {0}" (`teamName`); `isOver`: finish image, all buttons hidden (`M9/matelords/MatelordsFrame.as:120-419`) |
| `matelords.MatelordsTopListView` / `MatelordsTopItemView` | | two avatars: self and partner, only when signed | inside the frame | `topPlayerList` = [own `ThaneInfo`, partner `ThaneInfo` built from 4799 `job`, `sexJob`, `nickName`, fashion fields] (`CM/yishi/manager/MatelordsManager.as:86-144`; `M9/matelords/MatelordsTopListView.as:62-80`) |
| Help frame | Instruções da Batalha da vênus | static help | help link (`MatelordsFrame.as:342-347`) | `matelords.MatelordsFrame.helpContent` |

## 3. Routes (client to server)

All Venus requests except the altar shop have **no body** (`sendProtoBuffer(pkg, null)`, `MatelordsManager.as:360-363`).

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| S1 | Open the panel | frame constructor | `MatelordsFrame()` -> `MatelordsManager.matelordsMainInfo` (`MatelordsFrame.as:102-107`; `MatelordsManager.as:327-331`) | none | C to S 8979 (0x2313) `C_MATE_LORDS_MAININFO`, empty | 4799 |
| S2 | Sign up the couple | `_signupBtn` | `__signupBtnClickHandler` -> `signupCallBack` -> `matelordsSignup` (`MatelordsFrame.as:281-334`; `MatelordsManager.as:333-337`) | in order: married (`matelords.MatelordsFrame.str06` "Falha ao inscrever, apenas poderá-se inscrever se estiver casado"); has team (`str07`); is captain (`str08`); team = 2 members including the spouse (`str09`); all members level >= 36 (`str10`); confirmation `str03` "Deseja consumir {0} ouro para inscrever-se na Batalha de Vênus?\n(Será baseado no estado de casamento durante a inscrição)"; gold >= `Mate_Join` else tip `public.gold` | C to S 8975 (0x230F) `C_MATE_LORDS_SIGNUP`, empty | 4799 with `isSign = true` to both partners (A), gold update, 4801 (A) |
| S3 | Open ranking | rank link | `__rankLinkClickHandler` -> openType 1 (`:336-340`) | none | none (uses 4799 `info`) | none |
| S4 | Open the shop | `_shopBtn` | `__shopBtnClickHandler` -> `shop` openType 20 (`:349-353`) | none | shop module | |
| S5 | Join the room | `_joinBtn` | see [room.md](room.md) | | 8976 | |

## 4. Server messages (server to client)

### 4799 (0x12BF) `U_C_MATE_LORDS_MAININFO`, `MateLordsListMsg`

Opcode from PTT:668 ("永恒之战主面板信息"); it is missing from `protocol/opcodes.csv`. Receiver `MatelordsManager.__matelordsMainInfoHandler` (`MatelordsManager.as:66,71-146`); common fields via `resovleMateLordsInfo` (`:165-231`, each copied only when present); `info` replaces `model.rankList`; event `INFO_UPDATE`.

`MateLordsListMsg`: `isSign` (#1, BOOL), `isOpen` (#2, BOOL), `order` (#3, INT32, own team rank in group, 0 = unranked), `eventId` (#4, INT32), `teamType` (#5, INT32, group 1..4), `openTime` (#6, STRING, display text), `totalScore` (#7, INT32, team score), `altarScore` (#8, INT32, blessing points), `inspirLevel` (#9, INT32, 0..10), `maxTurnCount` (#10, INT32), `currentTurn` (#11, INT32), `leftTime` (#12, INT32, **milliseconds**, the client divides by 1000), `info` (#13, `MateLordsInfoMsg`, repeated), `masterUserId` (#14, INT32, team captain), `teamUid` (#15, STRING), `teamName` (#16, STRING, shown "Equipe {0}"), `warIndex` (#17, INT32, week of the season), `serverId` (#18, INT32), partner avatar `fashionArm` (#19), `fashionWing` (#20), `fashionCloth` (#21), `fashionHair` (#22), `fashionHat` (#23), `arm` (#24) (STRING), `job` (#25, INT32), `nickName` (#26, STRING, partner name), `isOver` (#27, BOOL, season finished), `sexJob` (#28, INT32, partner hero template).

`MateLordsInfoMsg` (one per team row): `uuid` (#1, STRING), `teamUid` (#2, STRING), `userId` (#3, INT32), `serverName` (#4, STRING), `nickName` (#5, STRING, team name = "Equipe {0}" built from it), `userKeys` (#6, STRING, A: member ids), `job` (#7, INT32), `sexJob` (#8, INT32), `grades` (#9, INT32), `fightPower` (#10, INT32, team power), `totalWinCount` (#11, INT32, not read), `teamType` (#12, INT32), `warIndex` (#13, INT32), `curreOrder` (#14, INT32, rank in group), `result` (#15, INT32, not read), `turnCount` (#16, INT32), `addScore` (#17, not read), `totalScore` (#18, INT32), `property1` (#19, STRING, not read), `clearRateItems` (#20, INT32 repeated, not read), `descScore` (#21, not read).

Partner avatar: when `isSign`, `topPlayerList` = [own thane, partner from the top level fields] (`:86-144`).

When: response to 8979 and 8975; (A) to both partners when the signup changes.

### 4801 (0x12C1) `U_C_MATE_LORDS_OPENSTATE`, `simple.PropertyMsg`

PTT:670 ("永恒之战开启"), missing from `protocol/opcodes.csv`. Receiver `BaseManager.__matelordsOpenHandler` (`CM/yishi/manager/BaseManager.as:339,2842-2848`) -> `TopToolsBar.matelordsState = param1`. Badge text `toptoolbar.topBtn.matelords.stateText{param1}`: 0 "Ativado", 1 "Participar da Batalha", 2 "Inscrição inscrever" (`TopBtnItemView.as:297-300`; `TopToolBtnTempInfo.isSignUpState` uses 2, `CM/yishi/datas/templates/TopToolBtnTempInfo.as:156-157`). Top bar `isOpen` uses `MatelordsManager.model.isOpen` (`TopToolBtnTempInfo.as:67-70`). When: login and every state change.

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| V1 | Level 36 for the top bar and every team member | `TopBtnCheckShowHelper.as:249-250`; `MatelordsFrame.as:309` |
| V2 | Team = freedom team with exactly 2 members, one of them the spouse; only the captain signs | `MatelordsFrame.as:285-308`; `CM/managers/FreedomTeamManager.as:640-695` |
| V3 | Cost `Mate_Join` = 2000000 gold (captain pays) | `TPL/ConfigInfos.xml`; `CM/yishi/datas/ConfigInfoManager.as:362-365` |
| V4 | Signup is bound to the marriage state at signup time ("Será baseado no estado de casamento durante a inscrição"); a player can only fight while still in the same marriage (help item 7). Server must recheck at room entry | LANG |
| V5 | Schedule `MateLords_Day` = 7 (1..7 = Monday..Sunday), `Mate_Time` = 20:00,21:00; season of about 3 months of weekly fights (help) | config |
| V6 | Minimum team fight power: string `str11` "poder total do casal não atingiu {0}0000" and `str01` exist, but no client check uses them (A: server side check, value unknown) | LANG |
| V7 | Error strings for closed signup `str04` "inscrição da {0}ª Batalha da vênus ainda não começou", `str05` "...encerrado" have no client trigger (A: server notice text) | LANG |

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `TPL/ConfigInfos.xml` | `Mate_Join`, `MateLords_Day`, `Mate_Time` | values above |

## 7. Persistent state

Schema `venus_battle`.

```sql
CREATE TABLE venus_battle.season (
  season_id       integer PRIMARY KEY,
  starts_at       timestamptz NOT NULL,
  ends_at         timestamptz NOT NULL,
  current_week    smallint NOT NULL DEFAULT 1,         -- warIndex
  closed          boolean NOT NULL DEFAULT false       -- isOver
);

CREATE TABLE venus_battle.couple_team (
  team_uid        uuid PRIMARY KEY,
  season_id       integer NOT NULL REFERENCES venus_battle.season(season_id),
  captain_id      integer NOT NULL REFERENCES player.players(player_id),
  partner_id      integer NOT NULL REFERENCES player.players(player_id),
  marriage_id     bigint NOT NULL,                     -- marriage row at signup time
  server_id       integer NOT NULL,
  team_name       text NOT NULL,                       -- captain nick
  gold_paid       bigint NOT NULL,
  signed_at       timestamptz NOT NULL DEFAULT now(),
  CHECK (captain_id <> partner_id),
  UNIQUE (season_id, captain_id),
  UNIQUE (season_id, partner_id)
);

CREATE TABLE venus_battle.week_signup (
  team_uid        uuid NOT NULL REFERENCES venus_battle.couple_team(team_uid),
  week_no         smallint NOT NULL,
  PRIMARY KEY (team_uid, week_no)
);
```

## 8. Backend implementation notes

- `venus_battle::signup::handle_main_info` (8979): build 4799 from season, team (by player id, either member), score row, altar score, inspiration; `info` = ranking rows of all groups.
- `venus_battle::signup::handle_sign_up` (8975): validation order V1, V2 (server copies of the team and marriage), season open and signup window, not already signed, gold. Transaction: debit captain gold, insert `couple_team` (first time in the season) and `week_signup`. Send 4799 to both partners if online, gold update to the captain.
- Scheduler: 4801 pushes at signup open (2), fight open (1), fight close (0).

## 9. Open questions and assumptions

- (A) Whether signup is per week or per season (`isSign` is per state; the help says couples sign "antes do início da batalha").
- (A) Who pays when the partner is the captain: the captain.
- (A) Minimum fight power for V6.
- (A) What happens to the team when the couple divorces mid season: disqualify.

## 10. Implementation checklist

- [ ] Tables `season`, `couple_team`, `week_signup`
- [ ] 8979 -> 4799 with partner avatar fields
- [ ] 8975 with V1..V4 server checks and gold debit
- [ ] 4801 at login and on schedule
- [ ] Add 4798, 4799, 4801 to `protocol/opcodes.csv` (A: tooling fix outside this folder)
- [ ] Tests: unmarried, not captain, third member, low level, insufficient gold, double signup
