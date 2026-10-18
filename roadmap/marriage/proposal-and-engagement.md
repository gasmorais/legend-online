# Proposal and engagement

Feature `marriage`, module `proposal-and-engagement`. Marriage state, proposing, answering, the pending proposal list, and mate search.

Conventions: paths relative to the repository root; AS3 citations `decompiled/<module>/scripts/<path>.as:<line>`; opcodes from `protocol/opcodes.csv` or the client constant classes; fields `name (#tag, TYPE, repeated?)` from `protocol/proto.json`; "Assumption" marks behavior not visible in the client.

Shared request body `marriage.MarriageOpMsg` (all marriage requests): `user_id (#1, INT32)`, `op_type (#2, INT32)`, `pay_type (#3, INT32)`, `property1 (#4, INT32)`, `property2 (#5, INT32)`, `property3 (#6, STRING)`, `property4 (#7, STRING)`, `property5 (#8, BOOL)`, `userIds (#9, INT32, repeated)`, `properties (#10, PropertyListMsg, repeated)` (`property1 (#1, INT32)`, `property2 (#2, INT32)`), `isNoGet (#11, BOOL)`. Op codes are the literals in `MarrySender` (`decompiled/core_module/scripts/mvc/module/marry/MarrySender.as`).

Shared push body `marriage.MarriageProMsg`: `userId_a (#1, INT32)`, `nickName_a (#2, STRING)`, `job_a (#3, INT32)`, `userId_b (#4, INT32)`, `nickName_b (#5, STRING)`, `job_b (#6, INT32)`, `property1 (#7, BOOL)`, `property2 (#8, INT32)`, `property3 (#9, INT32)`, `property4 (#10, STRING)`, `property5 (#11, STRING)`, `property6 (#12, INT32)`, `property7 (#13, INT32)`, `property8 (#14, INT32)`, `property9 (#15, INT32)`, `property10 (#16, INT32)`; lists use `marriage.EngageMsg`: `engageInfos (#1, MarriageProMsg, repeated)`.

## 1. Overview

Each player has a marriage record (`MarriageMsg`, 4657): partner id and name, state (1 engaged, 2 engagement cancelled, 3 married, 4 divorced, 0/none single), wedding quality template, marriage time and daily counters. A single player of level 36 proposes to another single player with a ring (item 208033): the client first asks the target's info (op 9 -> 4659), then sends the proposal (op 1). The target receives the proposal in the pending list (4656, toolbar propose box) and accepts or refuses (op 3). Accepting makes both engaged (4657 to both), removes the proposal (4656 with `property1 = false`, `property7 = 1` opens the wedding quality frame for the receiver), and the couple continues in [wedding.md](wedding.md). Single players can also ask for mate recommendations (op 20 -> 359).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `marry.propose.MarryQuestFrame` `decompiled/m9/scripts/marry/propose/MarryQuestFrame.as` | "Pedir em casamento"; default text "Vamos casar, irei usar a minha vida para proteger você para sempre!"; ring icon 208033 | Write the proposal (`__proposeHandler`), quick buy the ring ("Não! Já não há anéis à venda!!!" when not sold) | controller `marry` `QUEST` from `MarryManager.creatProposeQuestFrame` `decompiled/core_module/scripts/managers/MarryManager.as:621` (only when self is single and target is not self): PlayerMenu, chat menu, IM, NPC option 90 | target from 4659: name, guild (`property4`), level (`property3`), head (`property6`), intimacy (friend grade) |
| `marry.propose.MarryAnswerFrame` `decompiled/m9/scripts/marry/propose/MarryAnswerFrame.as` | "Ninguém pediu você em casamento" (title key `marry.propose.MarryAnswerFrame.titleText`); reject button | Accept or refuse one proposal (`:177`, `:183`) | `RECEIVE` from the propose box (`decompiled/core_module/scripts/marry/view/ProposeBoxItem.as:57`) or the toolbar marry button (`MainToolBar.as:712`) | proposal entry: name, level (`property3`), text (`property5`), head (`property6`) |
| `marry.view.ProposeBoxView` / `ProposeBoxItem` `decompiled/core_module/scripts/marry/view/` | "{0} pediu te em casamento" | Pending proposals box | `MarryManager.createIMMsgBox` `MarryManager.as:696` | `MarryModel.proposeDic` |
| `marry.propose.MarryRewardFrame2` | "Parabéns!" | Success frame | `SUCCEED` via `creatSucceedFrame` (castle or space scene) | |
| `marry.income.MateRecommendFrame` + `MateRecommendItem` + `SearchMateView` `decompiled/m9/scripts/marry/income/` | columns "Nome", "Sexo", "Nível de Perfeição", "Nível do Anel de Casamento", "Ação"; title "Novos Amigos" | Mate recommendations; add as friend (`MateRecommendItem.as:124`) | `SearchMateView` button inside the satisfaction view (single players), `SEARCH_MATE` after 359 | `MarryManager.recommendMatesList` |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| P1 | Open the propose frame | `MarryQuestFrame.show` then `MarrySender.proposeInfo` `MarrySender.as:207` | own state single | C>S 8759 0x2237 `C_marriage_REQUEST` | `op_type` = 9, `property1` = target user id | 4659 |
| P2 | Propose | `MarryQuestFrame.__proposeHandler` then `MarrySender.proposeQuest` `MarrySender.as:131` | own level >= 36 ("dayGuide.DayGuideManager.command02" with 36); target single (`property1` of 4659, else "O adversário já tem cônjuge"); text without forbidden words ("Conteúdo contém caractéres inválidos"); owns item 208033, else quick buy | C>S 8759 | `op_type` = 1, `property1` = target id, `property3` = message | 4656 to the target (new entry); Assumption: 111 alert to the proposer on success |
| P3 | NPC option 90 "propose" | `DialogOptionItem` case 90 `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as:438` | free team of exactly 2 members (`map.space.view.frame.DialogOptionItem.propose.overLimit`), self captain (`...propose.onlyCaptain`); target = the other member | opens P1/P2 | | |
| P4 | Accept / refuse | `MarryAnswerFrame` `:177` / `:183` then `MarrySender.proposeAnswer` `MarrySender.as:150` | none | C>S 8759 | `op_type` = 3, `property1` = proposer id, `property5` = true accept / false refuse | accept: 4657 to both, 4656 removal (`property7 = 1`) to the receiver, 4656 removals of other proposals, `SUCCEED` frame (Assumption: triggered by 4657 change), announcement on channel 12; refuse: 4656 removal |
| P5 | Search mates | `SearchMateView.__searchMatesHandler` `decompiled/m9/scripts/marry/income/SearchMateView.as:23` then `MarrySender.findMates` `MarrySender.as:310` | none | C>S 8759 | `op_type` = 20 | 359 |
| P6 | Auto cancel engagement timer | `MarryManager.onCd` `MarryManager.as:551` sends `cancleEngaged(14, 1)` | dead code in this client (`checkTime` is never called) | C>S 8759 | `op_type` = 14, `pay_type` = 1 | see [divorce.md](divorce.md) |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 4657 0x1231 `U_C_MARRIAGE_INFO` | `marriage.MarriageMsg`: `user_id (#1, INT32)` partner id (0 = none); `state (#2, INT32)` 1 engaged, 2 engagement cancelled, 3 married, 4 divorced; `template_id (#3, INT32)` ring/quality template; `marriage_time (#4, STRING)` epoch seconds as text (used as `int(marriage_time) + 259200`); `speTemplate_id (#5, INT32)` purchased wedding quality (`MarrySpecTempInfos` id, 0 = none); `quest_count (#6, INT32)` marriage tasks taken today; `nick_name (#7, STRING)` partner name; `over_time (#8, INT32)` (unused); `answer_num (#9, INT32)` heart quizzes done today; `logout_days (#10, INT32)` partner offline days; `is_back_player_first_married (#11, BOOL)` returning player half price | `MarryManager.__marryInfoHandler` `MarryManager.as:512` | login, and after any state change, to both partners | stores `selfMarryInfo`; refreshes tasks; within 72 h of `marriage_time` refreshes the top tool bar (discount icon) |
| S>C 4659 0x1233 `U_C_ENGAGED_INFO` | `MarriageProMsg`: `userId_a` target, `nickName_a`, `property1` target is single (can be proposed to), `property3` level, `property4` guild name, `property6` head id | `MarryManager.__loverInfoHandler` `:497` | response to op 9 | fills the propose frame |
| S>C 4656 0x1230 `U_C_ENGAGE_LIST` | `EngageMsg` of `MarriageProMsg`: `userId_a` proposer id, `nickName_a`, `job_a`, `property1` true = add or update, false = remove; `property2` (stored, unused); `property3` level; `property4` proposal time `YYYY-MM-DD hh:mm:ss` (parsed into `time`, the answer frame also prints it in the guild label); `property5` message; `property6` head id; `property7` 1 on removal opens the wedding quality frame | `MarryManager.__proposeListHandler` `:579`, `MarryModel.updateProposeList` `decompiled/core_module/scripts/mvc/module/marry/MarryModel.as:261` | login (all pending), on a new proposal, on answer | updates the propose box and toolbar |
| S>C 359 0x0167 `U_C_MARRIAGE_RECOMMENDLIST` | `friend.RecommendListMsg`: `girlList (#1, FriendPlayer, repeated)`, `boyList (#2, FriendPlayer, repeated)`; `FriendPlayer` `player_id`, `nick_name`, `level`, `sex`, `attack`, `map_name`, `trans_grade`, `job`, `changeBranch` | `MarryManager.__recommendMates` `:143` | response to op 20 | opens `SEARCH_MATE` |

## 5. Rules and formulas

- Single: partner id 0 or state 2 or 4 (`MarryModel.isSingle` `MarryModel.as:180`); engaged: state 1; married: state 3.
- Propose: proposer level >= 36; target single; ring 208033 consumed on proposal (Assumption: refunded when refused or expired is not visible; Assumption: not refunded).
- A player may receive several proposals; accepting one removes all others (Assumption).
- Proposals expire (Assumption: 24 h from `property4`).
- Mate recommendation columns "Nível de Perfeição" and "Nível do Anel de Casamento" map to `FriendPlayer.level` and `attack` (Assumption from column order; the item reuses the friend recommendation row).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208033 "Anel de Casamento" |
| shop templates | ring price for quick buy |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS marriage;

CREATE TABLE marriage.marriage (
    marriage_id            serial      PRIMARY KEY,
    player_a_id            integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE, -- proposer
    player_b_id            integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    state                  smallint    NOT NULL CHECK (state IN (1, 2, 3, 4)), -- engaged, engagement cancelled, married, divorced
    quality_template_id    integer     NOT NULL DEFAULT 0,  -- speTemplate_id (MarrySpecTempInfos)
    ring_template_id       integer     NOT NULL DEFAULT 208033, -- template_id
    engaged_at             timestamptz NOT NULL DEFAULT now(),
    married_at             timestamptz,                    -- marriage_time
    ended_at               timestamptz,
    CHECK (player_a_id <> player_b_id)
);
CREATE UNIQUE INDEX marriage_active_a_idx ON marriage.marriage (player_a_id) WHERE state IN (1, 3);
CREATE UNIQUE INDEX marriage_active_b_idx ON marriage.marriage (player_b_id) WHERE state IN (1, 3);

CREATE TABLE marriage.proposal (
    proposer_id   integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    target_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    message       varchar(100) NOT NULL DEFAULT '',
    created_at    timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (proposer_id, target_id)
);
CREATE INDEX proposal_target_idx ON marriage.proposal (target_id, created_at);

CREATE TABLE marriage.player_state (
    player_id                    integer  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    is_back_player_first_married boolean  NOT NULL DEFAULT false,
    daily_task_count             smallint NOT NULL DEFAULT 0,   -- quest_count
    daily_heart_count            smallint NOT NULL DEFAULT 0,   -- answer_num
    daily_reset_on               date     NOT NULL DEFAULT CURRENT_DATE
);
```

Exactly one active (state 1 or 3) marriage per player is enforced by the partial unique indexes (a player appears either as A or B; the service must also check the other column).

## 8. Backend implementation notes

- One dispatcher `marriage::handle_request` (8759) routes by `op_type`: 1 `marriage::proposal::handle_propose`, 3 `handle_answer`, 9 `handle_target_info`, 20 `handle_find_mates`; 4, 5, 6, 7, 10, 13 to [wedding.md](wedding.md); 11, 12, 18, 19 to [married-life.md](married-life.md); 8, 14, 15, 16, 17 to [divorce.md](divorce.md).
- Propose: validate level 36, both single (no active marriage), not self, target exists; consume one 208033 (inventory API); upsert `marriage.proposal`; push 4656 (add) to the target if online.
- Answer accept: lock both players; re-check both single; insert `marriage.marriage` (state 1); delete all proposals involving either player (push 4656 removals); push 4657 to both, 4656 removal with `property7 = 1` to the accepter; send a channel 12 announcement (Assumption).
- Login: 4657, 357 ([married-life.md](married-life.md)), 4656 list.
- Daily reset of counters at 00:00 (lazy on read using `daily_reset_on`).

## 9. Open questions and assumptions

1. Ring consumption and refund rules.
2. Proposal expiry.
3. The client shows `property4` both as a date and as a guild label in the answer frame; Assumption: send the date.

## 10. Implementation checklist

- [ ] Tables `marriage.marriage`, `marriage.proposal`, `marriage.player_state`
- [ ] 4657 at login and on changes
- [ ] Op 9 -> 4659
- [ ] Op 1 propose with ring consumption -> 4656 to the target
- [ ] Op 3 accept/refuse -> 4657, 4656 removals, success frame
- [ ] NPC option 90 with a 2 member team
- [ ] Op 20 -> 359 mate recommendations
- [ ] Test: two proposals to the same target, accepting one clears the other
