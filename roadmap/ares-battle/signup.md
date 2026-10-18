# Ares battle: season, open state and signup

Module `ares_battle::signup`. Prefixes as in [README.md](README.md).

## 1. Overview

Every player above level 36 can open the Ares panel. The server answers op 1 with push 371, and the client picks the frame from two flags: signed up or event open -> Start frame, otherwise -> SignUp frame (`CM/yishi/manager/AresLordsManager.as:179-197`). Signup costs `Ares_NeedGold` = 1000000 gold, confirmed in a dialog. The top bar button shows a state badge driven by push 374.

Concepts (all server owned, mirrored in `AresLordsModel`, `CM/mvc/module/areslords/AresLordsModel.as`):

| Field | Meaning |
|---|---|
| `season` | edition number ("{0}ª edição"); also the frame of the room round image |
| `warIndex` | round (week) inside the edition ("{1}ª rodada") |
| `leftWarIndex` | rounds left in the edition ("Ainda falta(m) {0} rodada(s) para encerrar competição") |
| `isSign` | player signed up for the current round |
| `isOpen` | the fight window is open now |
| `isOver` | the edition is closed (signup refused client side, "Esta edição já foi encerrada!") |
| `openTime` | display string of the next or current fight time |
| `currentTurn`, `maxTurnCount` | turn progress during the fight window |
| `totalScore`, `teamType`, `order` | own score, group (0..5) and rank inside the group (0 = unranked) |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `areslords.AresLordsSignUpFrame` (884x640) | Batalha de Ares | sign up, see last top 3, open shop and ranking | controller `areslords` openType 0 (`CM/mvc/controler/AresLordsController.as:30-33`) from 371 when `!isOpen && !isSign` | cost "{0} ouro" (`areslords.SignUpFrame.cost`), `openTime`, "Batalha de Ares  {0}ª edição {1}ª rodada" (`season`, `warIndex`), 3 `AresLordsSignUpPlayerView` (top 3 of `info` sorted by `rankOrder`, padded with null) showing avatar, name and "{0}pts" (`M9/areslords/AresLordsSignUpFrame.as:64-221`; `M9/areslords/signup/AresLordsSignUpPlayerView.as:98`) |
| `areslords.AresLordsStartFrame` (884x640) | Batalha de Ares | status before and during the fight window, entry to the room, own group medal, ranking list of 5 per page | openType 1 from 371 when `isOpen` or `isSign` (`AresLordsManager.as:185-192`) | open: "{0}ª rodada  Em progresso  {1}/{2}" (`warIndex`, `currentTurn+1` capped, `maxTurnCount`); closed: `openTime`. Always "Ainda falta(m) {0} rodada(s)...", group medal with tip to the next group, "{0}: {1}pts" own score, paged `rankList` (`M9/areslords/AresLordsStartFrame.as:267-329`; rows `M9/areslords/start/AresLordsStartRankItemView.as`) |

Both frames have a shop button (`shop` openType 10, "Loja de Ares", [../shops/catalog.md](../shops/catalog.md)) and a rank button (op 4, see [ranking.md](ranking.md)). The Start frame also has the reward button (openType 3) and the start button (op 5, see [room.md](room.md)).

## 3. Routes (client to server)

All requests: **C to S 9615 (0x258F) `C_ARES_CLIENT_OP`** (PTT:1499, `CM/yishi/datas/consant/ProtocolType.as:1180`), body `AresLordsListMsg`; the client sets only `op`.

`AresLordsListMsg` fields: `op` (#1, INT32), `eventId` (#2, INT32), `uuid` (#3, STRING), `userId` (#4, INT32), `serverId` (#5, INT32), `openTime` (#6, STRING), `isSign` (#7, BOOL), `isOpen` (#8, BOOL), `leftTime` (#9, INT32), `season` (#10, INT32), `warIndex` (#11, INT32), `currentTurn` (#12, INT32), `maxTurnCount` (#13, INT32), `totalScore` (#14, INT32), `teamType` (#15, INT32), `order` (#16, INT32), `info` (#17, `AresLordsInfoMsg`, repeated), `isOver` (#18, BOOL), `leftWarIndex` (#19, INT32).

Op constants: 1 REQOPENTABLE, 2 REQUESTSIGNS, 3 REFERSHSKILL, 4 REQUESTORDER, 5 REQENTERGAME (`AresLordsManager.as:32-40`).

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| A1 | Open the panel | top bar `areslords`; controller id `areslords` | `AresLordsManager.requestViewInfo` (`CM/yishi/manager/AresLordsManager.as:66-77`) | `thane.grades >= 36`, else tip `armyII.viewII.information.GoodsExchangeItem.areslordsShopPrompt` "Batalha de Ares será disponível ao atingir Nv.{0}" | `{op:1}` | 371 `U_C_ARES_VIEW_INFO` |
| A2 | Sign up | SignUp frame `_signUpBtn` | `AresLordsSignUpFrame.__signUpBtnClickHandler` -> `conformSignUp` -> `AresLordsManager.requestSignUp` (`M9/areslords/AresLordsSignUpFrame.as:181-202`; `AresLordsManager.as:79-85`) | if `isOver` tip `areslords.Error.str03` "Esta edição já foi encerrada!"; confirmation `areslords.Dialog.signup` "Deseja consumir {0} ouro para inscrever na batalha de ares?" with `Ares_NeedGold`. No gold check on the client | `{op:2}` | 371 with `isSign = true` (client reopens the Start frame through the 371 handler), gold update of the player resource push (A), 374 `param1 = 1` to this player (A) |
| A3 | Open the shop | `_shopBtn` | `__shopBtnClickHandler` (`AresLordsSignUpFrame.as:168-172`, `AresLordsStartFrame.as:218-222`) | none | none here (shop module) | see [../shops/catalog.md](../shops/catalog.md) |

## 4. Server messages (server to client)

### 371 (0x0173) `U_C_ARES_VIEW_INFO`, `AresLordsListMsg`

Receiver `AresLordsManager.__aresLordsViewInfoHandler` (`AresLordsManager.as:179-197`). Every field is copied only when present (`resovleBaseInfo`, `:217-263`).

| Field | Use |
|---|---|
| `isSign`, `isOpen`, `season`, `warIndex`, `currentTurn`, `maxTurnCount`, `totalScore`, `teamType`, `order`, `isOver`, `leftWarIndex` | model fields (section 1) |
| `openTime` | text shown as is (send a formatted date/time string) |
| `info` | SignUp frame: top 3 players of the previous round, sorted by `rankOrder` (`:265-294`); Start frame: current ranking list sorted by `rankOrder`, padded to a multiple of 5 (`:296-334`) |

`AresLordsInfoMsg`: `uuid` (#1, STRING, unique row id; null marks an empty row), `userId` (#2, INT32), `serverName` (#3, STRING), `nickName` (#4, STRING), `sexJob` (#5, INT32, hero template id used to draw the avatar), `grades` (#6, INT32), `fightPower` (#7, INT32), `totalScore` (#8, INT32), `teamType` (#9, INT32, group 0..5), `rankOrder` (#10, INT32), `fashionArm` (#11), `fashionWing` (#12), `fashionCloth` (#13), `fashionHair` (#14), `fashionHat` (#15) (STRING avatar resources; a value containing "fashion" is a fashion item, otherwise an equipment avatar, `:407-459`), `arm` (#16, STRING), `season` (#17, INT32), `orderTemp` (#18, INT32), `result` (#19, INT32), `addScore` (#20, INT32), `descScore` (#21, INT32). Fields #16 to #21 are not read by the client (A: per battle result data for the server or a report).

When: response to op 1, op 2 and any time the server wants the frame reopened. Effect: opens Start frame (openType 1) if `isOpen || isSign`, else SignUp frame (openType 0). It always opens a frame, so do not push it unsolicited.

### 374 (0x0176) `U_C_ARES_OPENSTATE`, `simple.PropertyMsg`

Receiver `BaseManager.__areslordsOpenHandler` (`CM/yishi/manager/BaseManager.as:340,2850-2856`) -> `TopToolsBar.areslordsState = param1`. Only `param1` (#1, INT32) is read. Values (badge text `toptoolbar.topBtn.matelords.stateText{n}`, `CM/ui/toptoolbar/TopBtnItemView.as:302-305`):

| param1 | Badge | Meaning (A from usage) |
|---|---|---|
| 0 | "Ativado" | idle / no special state |
| 1 | "Participar da Batalha" | fight window open |
| 2 | "Inscrição inscrever" | signup open (`TopToolBtnTempInfo.isSignUpState`, `CM/yishi/datas/templates/TopToolBtnTempInfo.as:154-155`) |

The full `PropertyMsg` (package `simple`) has `param1`..`param12`; `protocol/proto.json` collapses it with `army.PropertyMsg`, read `CM/com/road/yishi/proto/simple/PropertyMsg.as` instead.

When: at login and on every state change, to every online player of level 36+ (A: to all; the client ignores the level for the badge).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| R1 | Minimum level 36 for the panel and the top bar | `AresLordsManager.as:68`; `TopBtnCheckShowHelper.as:351-352` |
| R2 | Signup cost `Ares_NeedGold` = 1000000 gold; server must check and debit atomically and refuse when already signed or `isOver` | `TPL/ConfigInfos.xml`; `CM/yishi/datas/ConfigInfoManager.as:502-505` |
| R3 | Fight day `Ares_Day` = 2 "每周的第几天比赛", window `Ares_Time` = 20:00,21:00. (A) Day numbering follows `MateLords_Day` (1..7 = Monday..Sunday), so 2 = Tuesday | `TPL/ConfigInfos.xml` |
| R4 | Frame routing: `isOpen || isSign` -> Start frame; else SignUp frame | `AresLordsManager.as:185-196` |
| R5 | Signup is per round (`warIndex`). (A) A signup made before the fight day is consumed by that fight day; the player must sign again for the next round | top bar `isCanSignUp = !isSign` (`TopToolBtnTempInfo.as:177-178`) |
| R6 | Edition = `season`, made of rounds `warIndex`; `leftWarIndex` = rounds remaining. (A) An edition has a fixed number of weekly rounds chosen by the server; ranking rewards are paid per round (see ranking.md) | `areslords.SignUpFrame.round`, `areslords.StartFrame.left` |
| R7 | The SignUp frame shows exactly 3 players of `info` | `AresLordsSignUpFrame.as:94-102` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `TPL/ConfigInfos.xml` | `Ares_NeedGold` 1000000, `Ares_Day` 2, `Ares_Time` 20:00,21:00 | `ConfigName`, `ConfigValue` |
| `TPL/TopToolBtnTempInfo` (top bar templates, `BtnKey = areslords`) | top bar button | handled by the toolbar module |

## 7. Persistent state

Schema `ares_battle`.

```sql
CREATE TABLE ares_battle.edition (
  edition_id      integer PRIMARY KEY,                 -- season
  started_at      timestamptz NOT NULL,
  round_count     smallint NOT NULL CHECK (round_count > 0),
  current_round   smallint NOT NULL DEFAULT 1,         -- warIndex
  closed          boolean NOT NULL DEFAULT false       -- isOver
);

CREATE TABLE ares_battle.round (
  edition_id      integer NOT NULL REFERENCES ares_battle.edition(edition_id),
  round_no        smallint NOT NULL,                   -- warIndex
  fight_starts_at timestamptz NOT NULL,                -- Ares_Day + Ares_Time start
  fight_ends_at   timestamptz NOT NULL,
  max_turns       smallint NOT NULL,                   -- maxTurnCount
  current_turn    smallint NOT NULL DEFAULT 0,
  state           smallint NOT NULL DEFAULT 0 CHECK (state BETWEEN 0 AND 2), -- 374 param1
  rewards_paid    boolean NOT NULL DEFAULT false,
  PRIMARY KEY (edition_id, round_no)
);

CREATE TABLE ares_battle.signup (
  edition_id      integer NOT NULL,
  round_no        smallint NOT NULL,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  server_id       integer NOT NULL,
  gold_paid       bigint NOT NULL,
  signed_at       timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (edition_id, round_no, player_id),
  FOREIGN KEY (edition_id, round_no) REFERENCES ares_battle.round(edition_id, round_no)
);
```

The persistent score lives in `ares_battle.player_score` ([ranking.md](ranking.md)).

## 8. Backend implementation notes

- `ares_battle::signup::handle_view_info` (9615 op 1): check level >= 36 (silently drop otherwise), load edition, round, signup row, score row, build 371. `info`: SignUp case = top 3 of the previous round (or of the current edition); Start case = current group ranking (A: same list as op 4, limited to the player's group or the top rows).
- `ares_battle::signup::handle_sign_up` (9615 op 2): validation order: level >= 36, edition not closed, signup window open (round state 2), not already signed, gold >= `Ares_NeedGold`. One transaction: debit gold, insert `signup`, create `player_score` row if missing. Then send the gold resource update, 371, and 374 for this player.
- Scheduler: at signup start push 374 `param1 = 2` to all online players; at fight start (`Ares_Day` `Ares_Time`) set state 1 and push 374; at fight end set 0, pay rewards ([ranking.md](ranking.md)), advance `warIndex`, close the edition after the last round.
- Cross server: all participating servers share the same edition and pool; store `server_id` and send `serverName` in rows.

## 9. Open questions and assumptions

- (A) Meaning of 374 values 0/1/2 inferred from the badge strings and `isSignUpState`.
- (A) Number of rounds per edition and whether signup is per round or per edition: the client only shows `isSign` and `leftWarIndex`.
- (A) Weekday numbering of `Ares_Day`.
- (A) Content of `info` in the Start frame outside the fight window.
- No error code exists in 371; failures (no gold, already signed) need a generic notice (A: 126 `U_C_MSG` tip used by the core module).

## 10. Implementation checklist

- [ ] Tables `edition`, `round`, `signup`
- [ ] Scheduler: signup open, fight open, fight close, edition close; 374 pushes
- [ ] 374 at login
- [ ] 9615 op 1 -> 371 (both frame variants)
- [ ] 9615 op 2 with gold debit, idempotency and `isOver` check
- [ ] Rule R1 level gate server side
- [ ] Test: below 36 no response; signup twice debits once; SignUp vs Start routing
