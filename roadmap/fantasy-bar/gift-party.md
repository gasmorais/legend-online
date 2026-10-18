# Gift party (Magic Pub "giftwill")

Module `gift-party` of feature `fantasy-bar`. Protobuf package `giftparty`.

Path aliases:

| Alias | File |
|---|---|
| MPM | `decompiled/core_module/scripts/yishi/manager/MagicPubManager.as` |
| GTV | `decompiled/m11/scripts/magicpub/MagicPubGiftWillTeamView.as` |
| GTL | `decompiled/m11/scripts/magicpub/MagicPubGiftWillTeamListView.as` |
| GIV | `decompiled/m11/scripts/magicpub/MagicPubGiftWillTeamInfoView.as` |
| GII | `decompiled/m11/scripts/magicpub/MagicPubGiftWillTeamInfoItem.as` |
| TAO | `decompiled/core_module/scripts/ui/toptoolbar/view/TimeActiveBoxOpenTime.as` |

## 1. Overview

During the open windows (`Gift_Times` = 12:00-12:30 and 18:00-18:30) every participant owns a fragment with a quality (`fragQuality` 1 normal, 2 advanced, 3 epic; worth 1, 2, 3 points) and a position (`fragLevel` 1 top, 2 middle, 3 bottom). Teams have three seats, one per position. The leader ("master") starts when the others are ready; the team receives gift items according to the sum of the three qualities (levels 3..9 in the help list, for example "Nível 1 (1 ponto de qualidade): 2 papagaios, 2 sorvetes" up to "Nível 9 ..."). A player may instead sell his fragment directly (reward level = its quality) or refresh it for `Frag_Point` = 10 diamonds (refresh odds `Frag_Random` = 80, 50, 15 for normal, advanced, epic). `partyCount` is the number of reward boxes left; joining with 0 warns "O fragmento do baú atual é 0, não poderá receber Prêmios... Quer mesmo entrar?".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `MagicPubGiftWillView` | | container of team list and team info | `MagicPubFrame.show(3)` | |
| `MagicPubGiftWillTeamListView` (GTL) | | paged list of teams | gift party view | 412 pages "{page}/{total}" (GTL:105-125) |
| `MagicPubGiftWillTeamView` (GTV) | | one team card with join button | GTL | members per position |
| `MagicPubGiftWillTeamInfoView` (GIV) | "Você pode selecionar para entrar numa equipe ou criar uma equipe." | my fragment, create, refresh, sell, leave; "Horário de Abertura: {0}" | gift party view | `fragQuality`, `fragLevel`, `partyCount` digits; create panel when not in a team (GIV:157-190) |
| `MagicPubGiftWillTeamInfoItem` (GII) | "Preparado" / "Ainda não preparou" | seat with ready, kick, start buttons | GIV | member name, fragment, `placeState` (GII:109-150) |

## 3. Routes (client to server)

All use C>S 9636 (0x25a4) `C_GIFTPARTY_OP`, `GiftPartyMsg`, sender `MPM.OperateGiftParty(op, teamId, killUserId, readyState, pageIndex, payType)` (MPM:198-209). Request fields: `op (#1, INT32)`, `teamId (#2, INT32)`, `killUserId (#3, INT32)`, `readyState (#4, INT32)`, `pageIndex (#9, INT32)`, `payType (#11, INT32)`.

| op | Constant (MPM:32-48) | UI | Call site | Client checks | Fields | Response |
|---|---|---|---|---|---|---|
| 8 | `OP_INFO_REQUE` | open the gift party | `MagicPubFrame.showGiftWill(3)` (`decompiled/m11/scripts/magicpub/MagicPubFrame.as:126-131`) | level 32 | | 409 |
| 9 | `OP_LIST_TEAMS` | list paging, refresh after actions | GTL:93-102, 128-147; GIV:192-203 | | `pageIndex` | 412 |
| 1 | `OP_TEAM_ENTER` | create (teamId 0) or join a team | GIV:263-268, GTV:96-136 | join: open state (`noOpen` "Evento ainda não abriu, não é possível entrar."), confirm when `partyCount <= 0` | `teamId` | 409 to me, 409 to team members, 412 refresh |
| 2 | `OP_TEAM_LEAVE` | leave, or return to the bar while in a team | GIV:256-261, 270-283 | | | 409 |
| 3 | `OP_TEAM_READY` | ready button | GII:164-168 | own seat, `placeState == 0` | `readyState = 1` | 409 to members |
| 4 | `OP_TEAM_KILLD` | kick (leader) | GII:158-163 | leader only | `killUserId` | 409 to members and to the kicked player |
| 5 | `OP_TEAM_START` | start (leader) | GII:152-157 | leader only | | rewards, 409, 4725 |
| 6 | `OP_FRAG_REFER` | refresh fragment + confirm "Deseja consumir {0} diamantes para resfriar?" | GIV:205-232 | `allPoint >= Frag_Point` else recharge; bound flag | `payType` 0 bound allowed, 1 diamonds only | 409 |
| 7 | `OP_FRAG_SALED` | sell fragment + confirm "Deseja vender" | GIV:234-249 | not in a team (buttons hidden in a team) | | rewards, 409, 4725 |

## 4. Server messages (server to client)

### S1. 409 (0x0199) `U_C_GIFTPARTY_TEAMINFO`, `GiftPartyMsg`
Receiver `MPM.__teaminfoHandler` (MPM:113-120) -> `GIV.__playerInfoHandler`.

| Field | Tag | Type | Meaning |
|---|---|---|---|
| `op` | #1 | INT32 | echo |
| `fragQuality` | #5 | INT32 | my fragment quality 1..3 |
| `fragLevel` | #6 | INT32 | my fragment position 1..3 |
| `teamInfo` | #7 | `GiftPartyTeamInfoMsg`, repeated | empty when not in a team; else `[0]` = my team: `teamId (#1, INT32)`, `memberInfo (#2, TeamMemberInfoMsg, repeated)`, `masterUserId (#3, INT32)` |
| `partyCount` | #8 | INT32 | reward boxes left |
| others | | | unused here |

`TeamMemberInfoMsg`: `userId (#1, INT32)`, `nickName (#2, STRING)`, `fragQuality (#3, INT32)`, `fragLevel (#4, INT32)` seat index, `placeState (#5, INT32)` 0 not ready, 1 ready, 2 (assumption: leader).

### S2. 412 (0x019c) `U_C_GIFTPARTY_TEAMLIST`, `GiftPartyMsg`
Receiver MPM:122-129 -> GTL. Uses `teamInfo` (teams on the page), `pageIndex (#9)`, `totalPage (#10)`.

### S3. 413 (0x019d) `U_C_GIFTPARTY_OPENSTATE`, `simple.PropertyMsg`
Receiver MPM:131-137: `openGiftWill = param7`, read by the time activity box (TAO:128-143). `simple.PropertyMsg` fields (verified in `decompiled/core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as:56-360`; `protocol/proto.json` holds only `army.PropertyMsg` under this name): `param1..param3 (#1..#3, INT32)`, `param4..param6 (#4..#6, STRING)`, `param7..param9 (#7..#9, BOOL)`, `param10..param11 (#10..#11, INT32)`, `param12 (#12, STRING)`. Send `param7 = true` at window start and `false` at the end to all online players (and at login).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Open windows | 12:00-12:30, 18:00-18:30 | `Gift_Times`, `ConfigInfos.xml` |
| Level | 32 | `TopToolsBar.as:1407-1414` |
| Fragment points | normal 1, advanced 2, epic 3 | help item 1 |
| Team reward level | sum of the 3 members' points; reward list per level in the help text | help item 3 |
| Sell reward level | equals fragment quality | help item 2 |
| Refresh cost | 10 diamonds (`Frag_Point`), bound allowed when ticked | GIV:119, 214-232 |
| Refresh odds | `Frag_Random` = 80, 50, 15 (normal, advanced, epic weights, assumption) | `ConfigInfos.xml` |
| Team size | 3 seats (`_teamItem1..3` by `fragLevel`) | GIV:176-186 |

## 6. Templates

`ConfigInfos.xml`: `Gift_Times`, `Frag_Point`, `Frag_Random`. Reward lists only in the help text (`MagicPubFrame.helpFrame.content`); gift items are currencies -1700..-1709.

## 7. Persistent state

```sql
CREATE TABLE fantasy_bar.party_fragments (
  player_id       BIGINT PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  frag_quality    SMALLINT NOT NULL CHECK (frag_quality BETWEEN 1 AND 3),
  frag_position   SMALLINT NOT NULL CHECK (frag_position BETWEEN 1 AND 3),
  party_count     SMALLINT NOT NULL DEFAULT 0 CHECK (party_count >= 0),
  window_start    TIMESTAMPTZ NOT NULL
);

CREATE TABLE fantasy_bar.party_rewards (
  reward_level    SMALLINT PRIMARY KEY CHECK (reward_level BETWEEN 1 AND 9),
  items           JSONB NOT NULL
);

CREATE TABLE fantasy_bar.party_log (
  log_id          BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  team_id         INTEGER,
  reward_level    SMALLINT NOT NULL,
  sold            BOOLEAN NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Teams are in memory only (they live inside a 30 minute window).

## 8. Backend implementation notes

| op | Handler |
|---|---|
| 8 | `fantasy_bar::gift_party::handle_info` |
| 9 | `fantasy_bar::gift_party::handle_list` |
| 1 | `fantasy_bar::gift_party::handle_enter` |
| 2 | `fantasy_bar::gift_party::handle_leave` |
| 3 | `fantasy_bar::gift_party::handle_ready` |
| 4 | `fantasy_bar::gift_party::handle_kick` |
| 5 | `fantasy_bar::gift_party::handle_start` |
| 6 | `fantasy_bar::gift_party::handle_refresh_fragment` |
| 7 | `fantasy_bar::gift_party::handle_sell_fragment` |

- Window scheduler: at start roll a fragment for each participant on first request (lazy), set `party_count` (assumption: 1 per window), broadcast 413; at end disband teams, broadcast 413 false.
- Enter: the seat is the player's `frag_position`; reject if the seat is taken or the team is full.
- Start: all non leader members ready; grant `party_rewards[sum]` to each member with `party_count > 0` and decrement; push 4725 and 409 to members.
- Pushes to other members on every team change (409) and a list refresh (412) to viewers is optional (the client polls with op 9).

## 9. Open questions and assumptions

- `partyCount` semantics (reward boxes left) and per window amount.
- `placeState = 2` meaning (GII shows the selection mark for 1 or 2).
- Exact reward item counts per level beyond the help text.

## 10. Implementation checklist

- [ ] Gift party views
- [ ] Route 9636 ops 1..9
- [ ] Server messages 409, 412, 413
- [ ] Window scheduler and broadcast
- [ ] Tables `fantasy_bar.party_fragments`, `fantasy_bar.party_rewards`, `fantasy_bar.party_log`
- [ ] Tests: seat by position, ready and start rules, refresh odds and cost, sell reward level
