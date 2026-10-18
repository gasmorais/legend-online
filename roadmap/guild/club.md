# Guild club: search, apply, invites, create (consortia.view.club)

Module: lobby UI over `guild::membership` (see [membership.md](membership.md)). Protobuf package `com.road.yishi.proto.consortia` (plus `simple.SimplePlayerListRspMsg`, `player.PlayerMsg`). Client views `decompiled/m6/scripts/consortia/view/club/*`; controller `CM/mvc/controler/ConsortiaControler.as`; senders `CM/managers/ConsortiaSocketOutManager.as` (CSOut) and `M6/consortia/net/ConsortiaSocektSendManager.as` (CSock); receiver `CM/yishi/manager/ConsortiaManager.as` (CMgr).

Citation prefixes: `CM/` = `decompiled/core_module/scripts/`, `M6/` = `decompiled/m6/scripts/`, `TPL/` = `raw/xml/tempinfos/`, `LANG` = `index/language.json`. "(A)" marks an assumption.

## Overview

"Club" is the guild lobby a player sees while **not** in a guild: browse/search guilds, apply (up to 10 pending applications), see and answer invitations, withdraw applications, and create a guild. Membership itself (the guild and member tables, the 117 membership switch, the guild frame after joining) is specified in [membership.md](membership.md); this file is the exhaustive lobby UI and protocol map. Every request below except the reads (8209, 8213, 8214, 8343) changes membership and is implemented by the `guild::membership` handlers listed in Backend implementation notes.

Entry: main toolbar Guild button -> `openControllerByInfo("consortia",1)` (`CM/ui/maintoolbar/MainToolBar.as:2161`). `ConsortiaControler.frameClassName` returns `consortia.ConsortiaSearchFrame` when `playerInfo.consortiaID == 0` (`ConsortiaControler.as:268-271`). Gates: button opens at `grades >= 13` (`CM/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:42-43`, tip "Função habilitada no Nv. {0}"); blocked while in a Brave Legend team ("Favor sair primeiro do grupo atual!", `MainToolBar.as:2153-2156`).

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `consortia.view.club.ConsortiaSearchFrame` | Guilda | Root lobby: left (search list), right (invites/applications), Create button | Guild button with no guild | clears toolbar shine (`ConsortiaSearchFrame.as:44-60`) |
| `consortia.view.club.ConsortiaSeachLeftView` | (headers "Guilda", "Presidente", "Nível", "Membro") | Search input, refresh, select all "Todos", list of 8, Join | child | 4139 `consortiaInfo` (`ConsortiaSeachLeftView.as:117-152`) |
| `consortia.view.club.ConsortiaItem` | | Guild row with checkbox: name, chairman, "Nv.{0}", members "current / (levels*20+10)" | left view | `ConsortiaItem.as:171-174` |
| `consortia.view.club.ConsortiaSearchRightView` | (tabs Convites / Aplicações; headers "Guilda", "Convidador"/"Presidente", "Ação") | Invites received / my pending applications | child; Invite tab selected on open (:59) | 4135 split by `from_type` (:150-205) |
| `consortia.view.club.RecordItem` | | Invite row: inviter, "Concordar", "Ignorar". Application row: chairman, "Revogar" | right view | `RecordItem.as:94-110` |
| `consortia.view.club.CreatConsortiaFrame` | Criar Guilda | Name input (placeholder "Clique para nomear Guilda"), conditions "Líder atingiu Nv. 12", "Ouro 200000", "(Tamanho de 4 à 10 letras)", buttons "Criar", "Fechar" | search frame Create button (`ConsortiaSearchFrame.as:96-101`) | player grade and gold (`CreatConsortiaFrame.as:79,193-212`) |
| `consortia.view.club.ConsortiaInfoFrame` | Mensagem da Guilda | Read-only guild card with Apply | chat guild link -> 8343 -> 4267 -> `openControllerByInfo("lookconsortiainfo",6,info)` (`CMgr:388-403`; `ConsortiaControler.as:237-240`). `ConsortiaItem.__onInfoBtnHandler` is never wired | name, chairman (`creator_name`), level, wealth, members, honor, description (`ConsortiaInfoFrame.as:70,142-156`) |

## Actions

| # | Action | UI control / client sender | Client checks | Request (dir, opcode, name, message, fields) | Responses |
|---|---|---|---|---|---|
| K1 | Open the lobby | controller start openType 1 (`ConsortiaControler.as:168-171`) | none | C to S 8214 (0x2016) `U_C_CONSORTIA_INVITE_LIST`, `SearchConditionMsg` {`page_index` #1 = recruit page, `is_newOpen` #3 = true} (CSOut:230-237) | 4140 `SimplePlayerListRspMsg` (empty for a player without guild) |
| K2 | Load lists (auto) | `ConsortiaSeachLeftView.initData` (:139-145) | none | C to S 8209 (0x2011) `U_C_INVITEINFO_LIST`, empty body (CSOut:204-208); C to S 8213 (0x2015) `U_C_CONSORTIA_SEARCH`, `SearchConditionMsg` {`page_index` 1, `consortia_name` "" (#2), `is_newOpen` true} (CSock:76-84) | 4135, 4139 |
| K3 | Search | search button or Enter (`ConsortiaSeachLeftView.__onSearchHandler` :251-272, :188-195) | input max 10 chars; page counter rules: empty text -> next page, `is_newOpen` false; new text -> page 1, `is_newOpen` true; wraps when `(page-1)*8 >= total_rows` | 8213 {`page_index`, `consortia_name`, `is_newOpen`} | 4139 |
| K4 | Random / next page | refresh button (`__onRandomHandler` :274-280) | none | 8213 {`page_index` = counter+1, `consortia_name` "", `is_newOpen` false} | 4139 (`is_reset` true resets the counter to 1) |
| K5 | Select rows | checkbox / "Todos" (:197-233; `ConsortiaItem.__onClickHandler` :104-116) | client only | none | none |
| K6 | Apply to selected guilds | Join (`__onJoinHandler` :297-320) -> `CSock.applyJoinConsortia(id)` (:208-215) -> `checkApply` (:217-243) -> `applyJoinConsortiaSend` (:157-206) | at least one selected ("Escolha Guilda que deseja juntar"); selected + pending <= 10 ("Número máximo de inscrições atingido"); not already applied ("Você já inscreveu-se à essa Gulda"); grade >= 12 ("Nível insuficiente, só pode inscrever-se no Nv. {0}"); 24h cooldown when `isAuto` and `lastOutConsortia + 86400 > now`: confirm "Em 24 horas após sair de uma Guilda não é possível juntar-se à uma Guilda. <br/>Consumir <font color='#ff0000'>50</font> diamantes para juntar-se à uma Guilda imediatamente?", diamonds >= `Consortia_ClearCD_Point` (50) else recharge | C to S 5135 (0x140F) `U_C_CONSORTIA_USERINVITE`, `ConsortiaMsg` {`consortia_id` #1, `is_pay` #17} (one packet per guild) | 35 `ConsortiaMsg` {`apply_id` #2}; client shows "Aplicação sucedida", re-sends 8209, switches to the Applications tab |
| K7 | Apply from the guild card | `ConsortiaInfoFrame.__onApplyHandler` (:135-140) | same as K6 (single id) | 5135 | 35 |
| K8 | Accept an invite | "Concordar" (`RecordItem.__onAcceptHandler` :70-73 -> `ConsortiaControler.operateConsortiaApply` :518-521) | none | C to S 5143 (0x1417) `U_C_CONSORTIA_USERPASS`, `ConsortiaMsg` {`apply_id` #2, `result` #14 = true} (CSOut:53-60) | 37 {`apply_id`, `result`}; then 117 (membership), 3, guild data |
| K9 | Reject an invite | "Ignorar" (`__onRejectHandler` :75-87) | none | 5143 {`apply_id`, `result` false} | 37 |
| K10 | Withdraw my application | "Revogar" (same handler -> `CSock.deleteApplyConsortia` :149-155) | none | C to S 5141 (0x1415) `U_C_CONSORTIA_INVITEDEL`, `ConsortiaMsg` {`apply_id` #2} | 36 (no body read), client re-sends 8209 |
| K11 | Open create frame | Create (`ConsortiaSearchFrame.__onCreatHandler` :96-101) | none | none | none |
| K12 | Create a guild | "Criar" (`CreatConsortiaFrame.__onCreatHandler` :237-250 -> `canCreat` :252-289 -> `ConsortiaControler.creatConsortia` :596-633) | gold >= 200000 ("Ouro inferior à {0}, não é possível criar Guilda"); grade >= 12 ("Líder não atingiu Nv. {0}, não é possível criar Guilda"); trimmed name not empty ("Insira o nome da Guilda"); no forbidden words ("Nome da Guilda contêm caractéres inválidos, insira novamente"); byte length 4..10, non-ASCII = 2 ("Tamanho do nome da Guilda inválido, insira novamente"); 24h cooldown confirm with `content2` ("...não é possível criar uma Guilda..."), 50 diamonds | C to S 5130 (0x140A) `U_C_CONSORTIA_CREATE`, `ConsortiaMsg` {`consortia_name` #13, `is_pay` #17} (CSOut:62-69) | no listener for 34; success observed via 117, 3, 109 (gold), then guild data |
| K13 | Answer an invitation popup | `ConsortiaApplyAction` confirm/cancel (`CM/yishi/actions/consortia/ConsortiaApplyAction.as:59-72`) after 41 + 8209 + 4135 | none | 5143 {`apply_id`, `result`} | 37, 117 |
| K14 | Open a guild card from chat | `ChatOutputViewII.as:590` | none | C to S 8343 (0x2097) `C_CONSORTIA_LINK`, `ConsortiaLinkReqMsg` {`consortia_id` #1} | 4267 |
| K15 | Robot guild auto-join | level up to `grades >= 15` with no guild (`CMgr:143-153`; CSOut:183-187) | automatic | C to S 8197 (0x2005) `U_C_CONSORTIA_ROBOTJOIN`, empty | 117 |

Errors: 35 with `apply_id == 0` is the only client-visible failure signal (no text). For other failures (name taken, guild full, invite expired) the client has no handler; send the project generic notice (A) and keep lists consistent by pushing 4135.

## Server messages

| Opcode | Name | Message (fields) | Receiver | When | Client effect |
|---|---|---|---|---|---|
| 4139 (0x102B) | `U_C_CONSORTIA_SEARCH` | `ConsortiaSearchRspMsg` {`total_rows` #1 INT32, `consortiaInfo` #2 repeated `ConsortiaInfoMsg`, `is_reset` #3 BOOL}; reads from `ConsortiaInfoMsg`: `consortia_id` #1, `levels` #4, `current_count` #6, `offer` #20, `honor` #21, `description` #28, `consortia_name` #29, `chairman_name` #31, `is_robot` #46 | `ConsortiaControler` (:463-498), only while the controller frame is open (:103,151) | reply to 8213 | `consortiaList` -> 8 rows; `total_rows`; `is_reset` resets paging |
| 4135 (0x1027) | `U_C_INVITEINFO_LIST` | `ConsortiaUserInviteInfoListRspMsg` {`inviteInfo` #1 repeated `ConsortiaUserInviteInfoMsg` {`id` #1 apply id, `consortia_id` #2, `consortia_name` #3, `create_date` #4, `user_id` #5, `user_nickname` #6, `invite_id` #7, `invite_nickname` #8, `chairman_nickname` #9, `invite_date` #10, `from_type` #11 BOOL (true invite, false my application), `isexist` #12 BOOL}} | `CMgr:627-666` | reply to 8209 | split into inviteList/applyList (max 10 each); toolbar shine; pending invite popup |
| 35 (0x0023) | `U_C_CONSORTIA_USERINVITE` | `ConsortiaMsg` {`apply_id` #2} | `CMgr:405-419`; `ConsortiaControler.as:500-511` | reply to 5135 | `apply_id != 0`: "Aplicação sucedida", re-send 8209, Applications tab |
| 36 (0x0024) | `U_C_CONSORTIA_INVITEDEL` | (body not read) | `ConsortiaControler.as:513-516` | reply to 5141 | re-send 8209 |
| 37 (0x0025) | `U_C_CONSORTIA_USERPASS` | `ConsortiaMsg` {`apply_id` #2, `result` #14} | `CMgr:361-386`; `ConsortiaControler.as:523-539` | reply to 5143 | on accept "Parabéns ao juntar-se à Guilda {0}"; removes the row |
| 41 (0x0029) | `U_C_CONSORTIA_INVITE` | `ConsortiaMsg` {`apply_id` #2} | `CMgr:698-705` (listened only while no guild) | push when a guild invites this player | client sends 8209, then shows "{0} o convida à participar da Guilda: {1}" |
| 117 (0x0075) | `U_C_CONSORTIA_STATIC` | `ConsortiaMsg` {`consortia_id` #1, `return_item` #16} | `CMgr:721-752` | push after create, accept, robot join (and leave/kick in core) | sets `consortiaID`; if > 0 the client requests 8211, 8207, 8212, 9629 x3 and reopens the guild frame |
| 4267 (0x10AB) | `U_C_CONSORTIA_LINK` | `ConsortiaLinkRspMsg` {`consortia_id` #1, `consortia_name` #2, `creator_name` #3, `levels` #4, `Offer` #5, `current_count` #6, `honor` #7, `description` #8} | `CMgr:388-403` | reply to 8343 | opens ConsortiaInfoFrame |
| 4140 (0x102C) | `U_C_CONSORTIA_INVITE_LIST` | `SimplePlayerListRspMsg` {`total_rows` #1, `playerInfo` #2, `uuid` #3} | consortia controller | reply to 8214 | (recruit list, empty here) |
| 3 (0x0003) | `U_C_PLAYER_INFO` | `PlayerMsg` (fields used: `consortiaId` #12, `consortiaName` #13, `point` #6, `isAuto` #58, `lastOutConsortia` #59) | `CM/yishi/manager/PlayerManager.as:665-686` | login and changes | cooldown and diamonds |
| 34 (0x0022) | `U_C_CONSORTIA_CREATE` | (no client listener) | none | optional | none |

## Rules and formulas

| # | Rule | Source |
|---|---|---|
| L1 | Create: gold >= 200000; leader grade >= 12 in the client, but config `Consortia_Grade` = 13 and the Guild button needs 13, so enforce 13 server side (A) | `CreatConsortiaFrame.as:99-101,256-262`; `TPL/ConfigInfos.xml` |
| L2 | Name: trimmed, non-empty, no forbidden words (name and chat lists), byte length 4..10 with non-ASCII = 2; unique (server) | `CreatConsortiaFrame.as:142-150,268-287`; `decompiled/Loading/scripts/manager/FilterWordManager.as:48-155` |
| L3 | Apply: grade >= 12 (client), not already applied to that guild, at most 10 pending applications | CSock:217-243; `ConsortiaSeachLeftView.as:309` |
| L4 | Cooldown: 24 hours after leaving when `isAuto`; skip for `Consortia_ClearCD_Point` = 50 diamonds (`is_pay` true) for both apply and create | CSock:168-205; `ConsortiaControler.as:605-632` |
| L5 | Member capacity = levels * 20 + 10 (`Consortia_Member` = 20) | `ConsortiaItem.as:174` |
| L6 | Search page size 8; random paging wraps through `is_reset` | `ConsortiaSeachLeftView.as:152,265` |
| L7 | Invite and application lists capped at 10 each | `CMgr:640-649` |
| L8 | Robot guild auto-join at grade 15 with no guild | `CMgr:143-153` |

## Templates

| File | Fields |
|---|---|
| `TPL/ConfigInfos.xml` | `Consortia_ClearCD_Point` 50 (read by client); `Consortia_Grade` 13, `Consortia_Gold` 200000, `Consortia_Member` 20 (server) |
| Filter word lists (Loading module) | forbidden name words |

## Persistent state

The club owns no table. It uses the membership tables defined in **[membership.md](membership.md)**:

- `guild.join_request` (`id` = `apply_id`; `kind` 'application' = `from_type` false, 'invitation' = `from_type` true; unique per guild, player, kind) for 4135 rows, 5135, 5141, 5143;
- `guild.player_state` (`last_left_at` = `lastOutConsortia`, `left_voluntarily` = `isAuto`, `robot_invite_sent`) for the 24 hour cooldown and the robot join;
- `guild.member` and `guild.guild` ([profile.md](profile.md)) for search rows, capacity and creation.

## Backend implementation notes

All lobby requests are implemented by the membership service; the handler names below are the ones in membership.md (do not create a second `guild::club` implementation):

| Request | Handler |
|---|---|
| 8214 | `guild::membership::handle_list_applicants` |
| 8209 | `guild::membership::handle_list_join_requests` |
| 8213 | `guild::membership::handle_search` |
| 5135 | `guild::membership::handle_apply` |
| 5141 | `guild::membership::handle_cancel_application` |
| 5143 | `guild::membership::handle_answer_invitation` |
| 5130 | `guild::membership::handle_create` |
| 8343 | `guild::membership::handle_link` |
| 8197 | `guild::membership::handle_robot_join` |

Lobby rules each handler must enforce (on top of membership.md):

- `handle_apply`: player has no guild -> guild exists and not full (L5) -> grade >= 13 (A, L1) -> not already applied -> pending applications < 10 (L3) -> cooldown (L4) or `is_pay` with diamonds >= 50 (debit in the same transaction). Reply 35 {`apply_id`}; `apply_id` 0 on failure.
- `handle_answer_invitation` (`result` true): invitation exists for this player -> player has no guild -> guild not full -> transaction: add member, delete all join requests of the player. Reply 37, then 117 {`consortia_id`}, 3 (guild fields). `result` false: delete the row, reply 37.
- `handle_cancel_application`: delete own application, reply 36.
- `handle_create`: no guild, gold >= 200000 (L1), grade >= 13 (A), name valid and unique (L2), cooldown or `is_pay`. Transaction: debit gold (and diamonds), create guild and chairman member, delete pending requests. After commit: 117, 3, 109 (gold). 34 is optional (no listener).
- `handle_search`: 8 per page (L6), random order when `consortia_name` is empty (A), `is_reset` true when the page wraps.
- Pushes: 41 to the invited player (core invite action); refresh 4135 after any change to that player's requests.

No battles. No schedules (the cooldown is checked lazily).

Cross-area dependencies: membership.md (all tables and handlers), profile.md (guild row), ranks.md (officer rights for invitations), economy (gold, diamonds), player (grade), chat (guild link 8343).

## Open questions

1. Minimum grade 12 (client) vs 13 (config, Guild button).
2. Meaning of `isAuto` (voluntary leave vs kicked) for the 24h cooldown.
3. Whether a SonType 295 item can replace the gold for creation (`CreatConsortiaFrame.as:195-196` only recolors).
4. Failure feedback for 5130, 5135, 5143.
5. Exact push order after create: 117, 3, 109, then guild data.
6. Random search ordering and `is_reset` trigger.

## Implementation checklist

Client (present, verify):
- [ ] ConsortiaSearchFrame with left/right views, 8 rows, paging
- [ ] Apply flow incl. cooldown dialog
- [ ] Invites/Applications tabs with accept/ignore/withdraw
- [ ] CreatConsortiaFrame validations
- [ ] ConsortiaInfoFrame from chat link
- [ ] Invitation popup (41 -> 8209 -> 4135)

Backend:
- [ ] `guild::membership::handle_list_applicants` -> 4140 (empty for a player without guild)
- [ ] `guild::membership::handle_list_join_requests` -> 4135
- [ ] `guild::membership::handle_search` -> 4139 (8 per page, `is_reset`)
- [ ] `guild::membership::handle_apply` -> 35 (lobby rules L3, L4, L5)
- [ ] `guild::membership::handle_cancel_application` -> 36
- [ ] `guild::membership::handle_answer_invitation` -> 37, 117, 3
- [ ] `guild::membership::handle_create` -> 117, 3, 109 (rules L1, L2, L4)
- [ ] `guild::membership::handle_link` -> 4267
- [ ] `guild::membership::handle_robot_join` -> 117
- [ ] Name filter and uniqueness check
- [ ] Tables from membership.md: `guild.join_request`, `guild.player_state`
