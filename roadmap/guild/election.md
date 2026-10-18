# Guild chairman election and chairman path

Area: guild core, module `election`. Covers the chairman impeachment election (`consortia.view.myConsortia.chairmanElection`) and the chairman path tools (`consortia.view.myConsortia.chairmanPath`): guild rename, recruitment broadcast ("Recrutamento") and guild mail ("Email da Guilda"). Leadership transfer, also in `chairmanPath`, is documented in [ranks.md](ranks.md); the legacy permission frame too.

Conventions: see [membership.md](membership.md). No HTTP servlet is involved (guild mail uses the socket mail route 8205).

## Overview

Election: when the chairman is absent for 10 days the server starts a transfer process. The help text (`consortia.view.myConsortia.chairmanElection.help`) states the rules: 1. "Ausência do Presidente por 10 dias" triggers it; 2. candidates are vice presidents "não estiverão ausentes por mais de 3 dias", falling back to the next lower duty when none qualify; 3. a single candidate becomes chairman directly, several candidates start a member vote; 4. "Jogadores com mais de 100 contribuiçãoes" can vote, the vote lasts 3 days, most votes wins; 5. the transfer is cancelled if the chairman returns. While `votingState` is 3 or 4 the info tab shows a "Destituição" button (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaInfoView.as:235`) that opens `ElectionFrame` ("Eleição de Presidente").

Chairman path (buttons in `ConsortiaStaffPage`, `decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaStaffPage.as:105`):

- "Renomear" (right 18): rename the guild for 1000 diamonds, or for free when the server marked the name after a server merge (name contains "!").
- "Recrutamento" (right 1): broadcast a recruitment line to world chat with a clickable guild name, limited by `speak_times` per day ("Esgotado, redefinido às 0h").
- "Email da Guilda" (right 1): send one mail to chosen members for `Mail_NeedPoint` = 50 diamonds.

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ElectionFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/chairmanElection/ElectionFrame.as:41`) | "Eleição de Presidente"; note "Obs: Novo Presidente em vigor no dia {1} de {0} às {2} horas"; vote button | Pick one candidate and vote | `ConsortiaInfoView.__impeachBtnClickHandler` (`ConsortiaInfoView.as:175`) | Candidates from 4389, note date = `votingDate + 14 days` (`ElectionFrame.as:56`) |
| `ElectionListView` / `ElectionListTitle` / `ElectionListItem` (`ElectionListView.as:97`, `ElectionListTitle.as:25`, `ElectionListItem.as:64`) | headers "Nome", "Votos" | Single choice list of candidates (`is_votingman` only) | Election frame | nickname, `votingData` (votes) |
| `ElectionHelperView` (`ElectionHelperView.as:29`) | "Ajuda" | Help text above | Election frame help button | static |
| `ConsortiaRenameFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/chairmanPath/ConsortiaRenameFrame.as:67`) | "Renomear"; "Clique para nomear Guilda", "(Tamanho de 4 à 10 letras)", "Obs: Essa ação consumirá {0} diamantes" or "Obs: Devido à troca de dados do servidor, esse renomeamento será gratuíto"; checkbox "Diamante vinculado prioritário"; "(Não participa no evento de consumo)" | Rename | Staff page rename button (`ConsortiaStaffPage.as:334`); forced on guild frame open when the chairman's guild name contains "!" (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrame.as:305`) | none |
| `RecruitMemberFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/chairmanPath/RecruitMemberFrame.as:47`) | "Recrutamento"; "Insira condição de recrutamento:"; "Obs:Hoje ainda pode enviar {0} vezes, redefinido às 0h diariamente." | Type a recruitment line | Staff page recruit link button (`ConsortiaStaffPage.as:311`) | `consortiaInfo.speakTimes` |
| `ConsortiaEmailGroupSendView` + `EmailConsortiaMemberView` + `ConsortiaEmailMemberItem` (`decompiled/m6/scripts/consortia/view/myConsortia/chairmanPath/consortiaEmail/ConsortiaEmailGroupSendView.as:88`, `EmailConsortiaMemberView.as:181`) | "Email da Guilda"; member picker columns "Membro", "Profissão" | Compose and send guild mail | Staff page mail button via `writeemail` module (`ConsortiaStaffPage.as:350`, `:367`) | member list sorted by duty, cost `Mail_NeedPoint` |

## Actions

| # | UI control | Client sender | Client checks | Route | Request message and fields | Resp |
|---|---|---|---|---|---|---|
| E1 | "Destituição" button | `ConsortiaInfoView.__impeachBtnClickHandler` `ConsortiaInfoView.as:175` -> `ConsortiaControler.getVotingUserInfos` `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:1104` -> `ConsortiaSocketOutManager.getVotingUserInfos` `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as:257` | button visible only when `votingState` is 3 or 4 | C>S 8241 0x2031 `C_CONSORTIA_VOTING_LIST` | no body | 4389 |
| E2 | Vote button | `ElectionFrame.__sendVoteInfo` `ElectionFrame.as:89` -> `ConsortiaSocektSendManager.sendVotingInfo` `decompiled/m6/scripts/consortia/net/ConsortiaSocektSendManager.as:64` | a candidate selected ("Escolha um candidato"); button enabled only if list not empty, `hasVotePermission` (`consortiaOffer >= 100` or `consortiaTotalOffer >= 100`, `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as:903`) and not `hasVoted` (`ElectionFrame.as:103`) | C>S 8481 0x2121 `C_CONSORTIA_VOTING` | `ConsortiaVotingReqMsg`: `voting_user (#1, INT32)` candidate user id | 4390, then the client re-requests 8241 |
| E3 | Rename confirm | `ConsortiaRenameFrame.__onConfirmBtnHandler` `ConsortiaRenameFrame.as:192` -> `ConsortiaSocektSendManager.consortiaRename` `ConsortiaSocektSendManager.as:86` | width 4..10, non Latin-1 counts 2 (`:180`); forbidden words ("Nome da Guilda contêm caractéres inválidos, insira novamente"); paid rename needs `point (+ giftToken when the bind checkbox is set) >= 1000` else recharge popup (`:203`) | C>S 5148 0x141c `U_C_CONSORTIA_RENAME` | `ConsortiaRenameReqMsg`: `same (#1, BOOL)` true = free merge rename (frame opened with a callback), `newName (#2, STRING)`, `pay_type (#3, INT32)` 0 = bound diamonds first allowed, 1 = real diamonds only | 49; on success 164 and 3 to all online members |
| E4 | Recruit broadcast confirm | `RecruitMemberFrame.__confirmhandler` `RecruitMemberFrame.as:101` | staff page blocks when `speakTimes <= 0` ("Esgotado, redefinido às 0h", `ConsortiaStaffPage.as:315`); text trimmed, filtered, HTML escaped, cut at 54 width units (`:85`); default prompt text becomes "" | C>S 8335 0x208f `C_CONSORTIA_SPEAK` | `ConditionSpeakMsg`: `speak (#1, STRING)` recruitment condition text | 83 broadcast with `type = 2`; 164 with decremented `speak_times` |
| E5 | Guild mail send | `ConsortiaEmailGroupSendView` send handler (`ConsortiaEmailGroupSendView.as:180` to `:226`), `sendEmail` `:228`, `sendMailCall` `:238` -> `ConsortiaControler.sendEmail` `ConsortiaControler.as:1099` -> `EmailSocketOutManager.sendEmail` `decompiled/core_module/scripts/managers/EmailSocketOutManager.as:46` | recipients, subject, content not empty; every recipient nickname must be a current member ("Um ou mais jogadores não estão em sua Guilda"); confirm "Deseja consumir {0} diamantes para enviar email da guilda." with bind option | C>S 8205 0x200d `U_C_MAIL_SEND` | `MailSendReqMsg`: `receiverUserId (#1, INT32, repeated)`, `title (#2, STRING)`, `contents (#3, STRING)`, `send_type (#4, INT32)` = 2 guild mail, `pay_type (#5, INT32)` 0 bound first, 1 real only | Mail system responses (cross area); server debits 50 diamonds once per send |

## Server messages

| Route | Message and fields read | When | Client handler and effect |
|---|---|---|---|
| S>C 4389 0x1125 `U_C_CONSORTIA_VOTING_LIST` | `ConsortiaVotingUsersMsg`: `info (#1, repeated ConsortiaVotingUserMsg)`: `user_id (#1, INT32)`, `nick_name (#2, STRING)`, `voting_id (#3, INT32)` user this member voted for (Assumption), `is_votingman (#4, BOOL)` candidate flag, `votingTime (#5, INT32)` > 0 when this member already voted, `votingData (#6, INT32)` votes received | Response to 8241 | `ConsortiaControler.__setVotingUsers` `ConsortiaControler.as:1109`: sets `hasVoted` from the local user's entry; sorts by `votingData` descending (`ConsortiaModel.as:883`); `ElectionListView` shows only candidates. Include every eligible member (at least the local player) so `hasVoted` is correct. Listener only while the guild frame is open |
| S>C 4390 0x1126 `U_C_CONSORTIA_VOTING` | `ConsortiaVotingRspMsg`: `result (#1, BOOL)` | Response to 8481 | `ConsortiaControler.__updateVotingState` `ConsortiaControler.as:1136`: `hasVoted = result`, tip "Voto sucedido" or "Falha na votação", re-requests 8241 |
| S>C 49 0x0031 `U_C_CONSORTIA_RENAME` | `ConsortiaRenameRspMsg`: `result (#1, BOOL)` | Response to 5148 | `ConsortiaRenameFrame.__renameHandler` `ConsortiaRenameFrame.as:133`: closes on success, re-enables confirm on failure (free rename path keeps the frame until the response) |
| S>C 164 0x00a4 / 4138 0x102a | `ConsortiaInfoMsg`: `consortia_name (#29)`, `speak_times (#48)`, `votingDate (#49, STRING)`, `votingStatic (#50, INT32)` voting state, `votingId (#51, INT32)` | After rename, broadcast, election state changes | `ConsortiaManager.__refreshConsortiaInfo` `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:469`, `:552` to `:554`; info tab shows or hides the impeach button and disposes an open election frame when the state leaves 3/4 (`ConsortiaInfoView.as:235`) |
| S>C 3 0x0003 `U_C_PLAYER_INFO` | `PlayerMsg.consortia_name (#13)` | After rename, to every online member | `PlayerManager.__uPlayerInfoHandler` `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:667`; the forced rename check reads `playerInfo.consortiaName` (`ConsortiaFrame.as:308`) |
| S>C 83 0x0053 `U_CH_CHANNEL_CHA` | `ChatChannelMsg`: `channel (#1)` (Assumption: 10 WORLD), `type (#2)` = 2 recruitment, `encode_msg (#3)` text, `other_id (#4)` sender id, `name (#5)` sender nickname, `consortia_id (#7)`, `consortia_name (#8)`, `grades (#26)` | Broadcast after 8335 to every online player | `ChatManager.__channelChatHandler` `decompiled/core_module/scripts/chat/ChatManager.as:110`; `ChatFormat` builds a clickable guild cell for `type == 2` (`decompiled/core_module/scripts/chat/utils/ChatFormat.as:997`); click sends 8343 ([membership.md](membership.md) M6) |
| S>C 50 0x0032 | `ConsortiaMsg` `other_id`, `position_id` | Election result: new chairman 1, old chairman 5 | `ConsortiaManager.__updataDutyInfo` `ConsortiaManager.as:803` |

## Rules and formulas

- Voting states (`decompiled/core_module/scripts/mvc/module/consortia/VotingState.as:6`): 0 NONE, 1 VOTINGMAIL (members notified by mail, Assumption), 2 VOTINGBEGIN, 3 VOTINGMAN (candidates fixed), 4 VOTINGING (voting open), 5 VOTINGEND. The client only distinguishes 3/4 (button visible) from the rest. Default client value is -1 (`decompiled/core_module/scripts/mvc/module/consortia/ConsortiaInfo.as:153`).
- Trigger: chairman offline 10 days. Candidates: vice chairmen online within the last 3 days; if none, next lower duty. One candidate: instant transfer. Several: vote for 3 days (help text). Effective date shown is `votingDate + 14 days` at the hour of `votingDate` (`ConsortiaModel.VOTING_DAY = 14` `ConsortiaModel.as:56`, `ElectionFrame.as:60`). The 14 day note conflicts with "3 days" in the help (Open question; suggestion: `votingDate` = date the process started, chairman change at `votingDate + 14 days`).
- Voter eligibility: personal `consortiaOffer >= 100` or `consortiaTotalOffer >= 100` (`ConsortiaModel.as:903`); one vote per voter per election.
- Chairman return (login) during the process cancels it: state back to 0, push 164.
- Rename: cost `Consortia_Rename` = 1000 diamonds (`ConsortiaModel.CONSORTIA_RENAME_NEEDED_POINT` `ConsortiaModel.as:50`, `ConsortiaRenameFrame.as:82`); free when `same = true` and the stored name is marked from a merge (contains "!", `ConsortiaFrame.as:313`). Same name rules as creation (width 4..10, forbidden words, unique). Right 18.
- Recruitment broadcast: right 1; one use consumes one `speak_times`; reset daily at 00:00 (`consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command05`). Daily amount not visible (Open question).
- Guild mail: right 1; cost `Mail_NeedPoint` = 50 diamonds (`ConsortiaEmailGroupSendView.as:88`, `raw/xml/tempinfos/ConfigInfos.xml`); recipients must be members; content max 7 lines client side.

## Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | ConfigInfo | `Consortia_Rename` 1000, `Mail_NeedPoint` 50 |
| `index/language.json` | strings | `consortia.view.myConsortia.chairmanElection.*`, `consortia.view.myConsortia.chairmanPath.*`, `consortia.view.myConsortia.ConsortiaActivityPage.impeach` |

## Persistent state

```sql
CREATE TABLE guild.election (
    id            serial      PRIMARY KEY,                       -- votingId
    guild_id      integer     NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
    state         smallint    NOT NULL CHECK (state BETWEEN 0 AND 5),  -- votingStatic
    started_at    timestamptz NOT NULL,                          -- votingDate
    vote_ends_at  timestamptz NOT NULL,
    resolves_at   timestamptz NOT NULL,                          -- started_at + 14 days (Assumption)
    old_chairman_id integer   REFERENCES public.player(id) ON DELETE SET NULL,
    winner_id     integer     REFERENCES public.player(id) ON DELETE SET NULL,
    closed_at     timestamptz
);
CREATE UNIQUE INDEX election_one_open ON guild.election (guild_id) WHERE closed_at IS NULL;

CREATE TABLE guild.election_candidate (
    election_id integer NOT NULL REFERENCES guild.election(id) ON DELETE CASCADE,
    player_id   integer NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
    PRIMARY KEY (election_id, player_id)
);

CREATE TABLE guild.election_vote (
    election_id  integer     NOT NULL REFERENCES guild.election(id) ON DELETE CASCADE,
    voter_id     integer     NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
    candidate_id integer     NOT NULL,
    voted_at     timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (election_id, voter_id),
    FOREIGN KEY (election_id, candidate_id) REFERENCES guild.election_candidate (election_id, player_id)
);
CREATE INDEX election_vote_candidate_idx ON guild.election_vote (election_id, candidate_id);
```

Columns on `guild.guild` ([profile.md](profile.md)) used here: `name`, `name_needs_change` (boolean, merge rename), `recruit_broadcasts_left` (`speak_times`), `recruit_broadcasts_reset_on` (date).

## Backend implementation notes

| Opcode | Handler |
|---|---|
| 8241 | `guild::election::handle_list_candidates` |
| 8481 | `guild::election::handle_vote` |
| 5148 | `guild::election::handle_rename` |
| 8335 | `guild::election::handle_recruit_broadcast` |
| 8205 (send_type 2) | `guild::election::handle_guild_mail` (delegates to the mail module after guild checks) |

Scheduled job `guild::election::tick` (every hour, Assumption): start an election for guilds whose chairman `last_logout_at` is older than 10 days (state 4 when several candidates, direct transfer when one), close votes, apply the winner (same effects as a transfer in [ranks.md](ranks.md)), cancel on chairman login (hook in the login path). After every state change push 164 to online members; after a chairman change push 50 for both users.

Validation for 8481: member; election open in state 4; voter eligible (offer >= 100); not already voted; candidate in `guild.election_candidate`. One insert; respond 4390 `result` true, else false.

Validation for 5148: member with right 18; name rules; if `same` then `name_needs_change` must be true and no charge, else debit 1000 diamonds (`pay_type` 0 bound first). One transaction for name, diamonds, and clearing `name_needs_change`. Respond 49, then push 164 and 3 to all online members, event type 9 (Assumption).

Validation for 8335: member with right 1; `recruit_broadcasts_left > 0` (after daily reset); text length. Decrement, broadcast 83 to all online players, push 164 to guild members.

Validation for guild mail: sender right 1; every receiver is a member; 50 diamonds; then normal mail creation per receiver.

## Open questions

1. Exact timings: 3 day vote vs 14 day effective date.
2. Meaning of `voting_id` in `ConsortiaVotingUserMsg` and `votingId` in `ConsortiaInfoMsg` (election id assumed).
3. Daily recruitment broadcast quota and chat channel used for the broadcast.
4. Whether VOTINGMAIL (1) sends an actual mail to members.
5. Event type used for rename (none of the event types matches exactly).

## Implementation checklist

Client flows:

- [ ] Impeach button appears with `votingStatic` 3 or 4; election frame lists candidates and votes
- [ ] Vote once; second open shows disabled vote button; members below 100 contribution cannot vote
- [ ] Rename paid (1000 diamonds, bind option) and free merge rename forced on frame open
- [ ] Recruitment broadcast appears in world chat with a clickable guild name; quota decrements and blocks at 0
- [ ] Guild mail to selected members with 50 diamond confirmation

Backend:

- [ ] Tables `guild.election`, `guild.election_candidate`, `guild.election_vote`; guild columns for rename flag and broadcast quota
- [ ] Handlers 8241, 8481, 5148, 8335 and guild branch of 8205
- [ ] Election scheduler and chairman login cancel hook
- [ ] Pushes 4389, 4390, 49, 83, 164, 3, 50
- [ ] Daily reset of `recruit_broadcasts_left`
