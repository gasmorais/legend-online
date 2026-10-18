# Guild membership

Area: guild core, module `membership`. Covers guild search and list, guild info preview, create, apply, cancel application, invitations (send, receive, accept, reject), applicant review (accept, reject, close applications), member list, leave, kick and disband.

Conventions used in this file:

- Paths are relative to the repository root. AS3 citations use `decompiled/<module>/scripts/<path>.as:<line>`.
- Opcodes come from `protocol/opcodes.csv`. "C>S" means client to server (`send` rows), "S>C" means server to client (`accept` rows).
- Protobuf fields are written `name (#tag, TYPE, repeated?)` from `protocol/proto.json`. Two names collide in `proto.json` (`SimplePlayerInfoMsg`, `PropertyMsg`); for those the field table was read from the AS3 class `decompiled/core_module/scripts/com/road/yishi/proto/simple/*.as` (writer `writeTag` calls).
- There is no HTTP servlet in this area: every route is a socket packet.
- "Assumption" marks behavior not visible in client code.

Related files: [ranks.md](ranks.md) (duties, rights bitset, kick and promote permissions), [profile.md](profile.md) (`guild.guild` table, `ConsortiaInfoMsg`, level and member cap), [contribution.md](contribution.md), [election.md](election.md), [logs.md](logs.md) (events, login pushes, online status, chat).

## Overview

A player without a guild (`PlayerInfo.consortiaID == 0`) who clicks the main toolbar guild button (`MainToolBar._consortiaBtn`, opens at hero level 13, hotkey G, `decompiled/core_module/scripts/ui/maintoolbar/constant/MainToolCheckBtnOpen.as:42`, `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2151`) gets `ConsortiaSearchFrame` ("Guilda"). From there the player browses or searches guilds (8 per page), opens guild info, applies (up to 10 open applications), cancels applications, accepts or ignores invitations, or creates a guild (200000 gold, hero level 12, name 4 to 10 width units).

A guild member gets `ConsortiaFrame` instead (`decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:269`). Its member tab (`ConsortiaStaffPage`) lists members, lets privileged members review applicants ("Analíse e Aprovação"), invite players by nickname, kick members (player menu), and leave the guild. The chairman can only leave when he is the last member; that leave disbands the guild.

Other entry points:

- Invite a player from any player menu, chat name menu, IM window or world target menu when the inviter has right 9 and the target has no guild: `decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as:301` and `:586`, `decompiled/core_module/scripts/chat/view/ChatItemMenu.as:373`, `decompiled/m12/scripts/im/IMFrame.as:402`, `decompiled/core_module/scripts/ui/toptoolbar/view/TargetSelectView.as:173`.
- Click a guild name in a recruitment chat message (sent by [election.md](election.md) "Recrutamento") to open the guild info preview: `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:580`.
- Invitation popup pushed by the server at any time while the player has no guild: `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:698`, `:668`, `decompiled/core_module/scripts/yishi/actions/consortia/ConsortiaApplyAction.as:43`.
- Robot guild auto invite when the hero reaches level 15 without a guild: `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:143`.

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `consortia.view.club.ConsortiaSearchFrame` (`decompiled/m6/scripts/consortia/view/club/ConsortiaSearchFrame.as:42`) | "Guilda" (`consortia.view.club.ConsortiaSearchFrame.titleText`) | Container for the search list (left) and invite/apply records (right), plus the create button | `consortia` controller when `consortiaID == 0` (`ConsortiaControler.as:269`) | Left and right views below |
| `ConsortiaSeachLeftView` (`decompiled/m6/scripts/consortia/view/club/ConsortiaSeachLeftView.as:85`) | columns "Guilda", "Presidente", "Nível", "Membro"; input hint "Insira nome da Guilda que procura" | 8 guild rows with checkboxes, search, random, select all, join | Search frame | `ConsortiaInfo` from 4139: name, chairman, "Nv.{levels}", `currentCount / (levels*20+10)` (`decompiled/m6/scripts/consortia/view/club/ConsortiaItem.as:168`) |
| `ConsortiaSearchRightView` (`decompiled/m6/scripts/consortia/view/club/ConsortiaSearchRightView.as:62`) | tabs invite / apply; headers "Convidador" or "Presidente", "Ação" | Lists invitations (`from_type == true`) or own applications (`from_type == false`) from 4135 | Search frame; auto switches to the apply tab on `APPLY_CONSORTIA_SUCCESS` (`:221`) | `RecordItem`: guild name and inviter nickname or chairman nickname |
| `RecordItem` (`decompiled/m6/scripts/consortia/view/club/RecordItem.as:94`) | buttons "Concordar", "Ignorar" (invitation) or "Revogar" (application, accept hidden) | Accept or reject an invitation, or cancel an application | Right view | `ConsortiaInviteInfo` |
| `CreatConsortiaFrame` (`decompiled/m6/scripts/consortia/view/club/CreatConsortiaFrame.as:77`) | "Criar Guilda"; "Líder atingiu Nv. {0}", "Ouro {0}", "(Tamanho de 4 à 10 letras)", button "Criar" | Name input and create | Search frame create button (`ConsortiaSearchFrame.as:96`) | Gold and level condition coloring (`:193`) |
| `ConsortiaInfoFrame` (`decompiled/m6/scripts/consortia/view/club/ConsortiaInfoFrame.as:68`), style `lookconsortiainfoe.ConsortiaInfoFrame`, controller openType 6 | "Mensagem da Guilda" | Read only preview with an apply button | 4267 handler (`ConsortiaManager.as:388`) | name, chairman, level, wealth (`offer`), member count, honor, description |
| `ConsortiaStaffPage` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaStaffPage.as:79`) | buttons recruit, recruit link, events, rename, transfer, mail, settings or inquire, exit | Member tab of `ConsortiaFrame` | `ConsortiaFrame` tab 2 (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrame.as:173`) | Button visibility by rights (see [ranks.md](ranks.md)); applicant count badge |
| `ConsortiaMemberView` / `ConsortiaMemberList` / `ConsortiaMemberItem` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaMemberView.as:53`, `ConsortiaMemberList.as:61`, `ConsortiaMemberItem.as:178`) | sortable columns member, duty, job, level, contribution, power, offline time | Member list, min 15 rows, click opens `ConsortiaPlayerMenu` | Staff page; requests 8207 on creation (`ConsortiaMemberView.as:80`) | nickname, duty name, job, "Nv.{grades}", `consortiaOffer / consortiaTotalOffer`, `fightingCapacity`, offline text ("Online", "{0} horas", "{0} dias", "Longo", "1 hora") (`ConsortiaMemberItem.as:318`) |
| `ConsortiaAuditingFrame` + `ApplyPlayerList` + `ApplyPlayerItem` (`decompiled/m6/scripts/consortia/view/myConsortia/recruit/ConsortiaAuditingFrame.as:49`, `ApplyPlayerList.as:62`, `ApplyPlayerItem.as:184`) | "Analíse e Aprovação"; "Nome", "Ação", "Recrutar", "Recusar Inscrição", "Concordar", "Ignorar" | Applicant review, 8 per page, bulk accept/reject, close applications toggle | Staff page recruit button (right 9) (`ConsortiaStaffPage.as:301`) | nickname, level, power, transfer grade from 4140 |
| `ConsortiaRecruitFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/recruit/ConsortiaRecruitFrame.as:56`) | "Recrutar Membros"; "Insira apelido do jogador:" | Invite a player by nickname (resolves via 8257/4170) | Auditing frame "Recrutar" (`ConsortiaAuditingFrame.as:151`) | none |
| `ConsortiaPlayerMenu` (`decompiled/core_module/scripts/yishi/view/community/ConsortiaPlayerMenu.as:45`) | "Promover", "Rebaixar", "Expulsar" | Promote, demote ([ranks.md](ranks.md)) and kick | Member row click (`ConsortiaMemberItem.as:276`), contribution row click | target `ThaneInfo` |
| `TodayNotAlertFrame` (style `consortia.TodayNotAlertFrame`) | text "Em 24 hora após sair da Guilda, não será possível juntar-se ou criar uma Guilda, certeza ao sair?", checkbox "Consumir Cartão de Aliança (prioritário) ou {0} \ndiamantes para encerrar resfriamento" | Leave confirmation | Staff page exit button (`ConsortiaStaffPage.as:373`) | `Consortia_ClearCD_Point` |
| `ForbidConsortiaView` (`decompiled/core_module/scripts/mainBar/view/ForbidConsortiaView.as:27`) | tip "Antes do tempo esgotar não é possível \ncriar ou juntar-se à uma Guilda" | Top bar buff showing the 24 h rejoin cooldown | `TopToolsBar.consortiaView` (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:2177`) | `86400 - (now - lastOutConsortia)` |

## Actions

Client request routes. "Resp" lists what the server must send, in order.

| # | UI control | Client sender | Client checks | Route | Request message and fields | Resp |
|---|---|---|---|---|---|---|
| M1 | Open search frame (toolbar) | `ConsortiaControler.showFrame` `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:168` (openType 1), `ConsortiaSeachLeftView.initData` `decompiled/m6/scripts/consortia/view/club/ConsortiaSeachLeftView.as:139` | hero level >= 13 for the button; blocked when in a Brave Legend team ("Favor sair primeiro do grupo atual!", `MainToolBar.as:2153`) | C>S 8214 0x2016 `U_C_CONSORTIA_INVITE_LIST`; C>S 8209 0x2011 `U_C_INVITEINFO_LIST`; C>S 8213 0x2015 `U_C_CONSORTIA_SEARCH` | 8214 `SearchConditionMsg`: `page_index (#1, INT32)` = 1, `is_newOpen (#3, BOOL)` = true. 8209: no body. 8213 `SearchConditionMsg`: `page_index` = 1, `consortia_name (#2, STRING)` = "", `is_newOpen` = true | 4140 (empty list when the player has no guild), 4135, 4139 |
| M2 | Search button or Enter | `ConsortiaSeachLeftView.__onSearchHandler` `ConsortiaSeachLeftView.as:251` | name max 10 chars (`:104`); empty text behaves like random | C>S 8213 0x2015 | `consortia_name` = text, `page_index` = `randomCount` (reset to 1 when the text changed or when `(randomCount-1)*8 >= totalRows`), `is_newOpen` = true | 4139 |
| M3 | Random button | `__onRandomHandler` `ConsortiaSeachLeftView.as:274` | none | C>S 8213 0x2015 | `consortia_name` = "", `page_index` = ++`randomCount`, `is_newOpen` = false | 4139; set `is_reset = true` when the page wrapped so the client resets `randomCount = 1` (`ConsortiaControler.as:478`) |
| M4 | Join button (checked rows) | `__onJoinHandler` `ConsortiaSeachLeftView.as:297` then `ConsortiaSocektSendManager.applyJoinConsortia` `decompiled/m6/scripts/consortia/net/ConsortiaSocektSendManager.as:208` per guild | at least one row ("Escolha Guilda que deseja juntar"); `selected + applyList.length <= 10` ("Número máximo de inscrições atingido"); per guild `checkApply` (`:217`): not already applied ("Você já inscreveu-se à essa Gulda"), hero level >= 12 ("Nível insuficiente, só pode inscrever-se no Nv. {0}"), `applyList.length < 10`. Rejoin cooldown: if `isAuto && lastOutConsortia + 86400 > now`, popup `Consortia.ConsortiaSocketOutManager.content` ("... Consumir 50 diamantes para juntar-se à uma Guilda imediatamente?"); on confirm requires `point >= Consortia_ClearCD_Point` (bound diamonds not counted) else recharge popup (`:157`) | C>S 5135 0x140f `U_C_CONSORTIA_USERINVITE` | `ConsortiaMsg`: `consortia_id (#1, INT32)` target guild, `is_pay (#17, BOOL)` true when paying 50 diamonds to skip the cooldown | 35 (`apply_id` = new application id, 0 on failure); optional 111 tip on failure |
| M5 | Apply in guild info preview | `ConsortiaInfoFrame.__onApplyHandler` `decompiled/m6/scripts/consortia/view/club/ConsortiaInfoFrame.as:135` | same as M4 `checkApply` | C>S 5135 0x140f | as M4 | 35 |
| M6 | Click guild name in recruit chat | `ChatOutputViewII.__consortiaClickHandler` `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:580` -> `ConsortiaSocketOutManager.consortiaLink` `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as:45` | blocked if the player already has a guild ("Você já juntou-se à uma Guilda, não é possível aplicar à Guilda") | C>S 8343 0x2097 `C_CONSORTIA_LINK` | `ConsortiaLinkReqMsg`: `consortia_id (#1, INT32)` | 4267 |
| M7 | "Revogar" on own application | `RecordItem.__onRejectHandler` `decompiled/m6/scripts/consortia/view/club/RecordItem.as:75` (`from_type == false`) -> `ConsortiaSocektSendManager.deleteApplyConsortia` `ConsortiaSocektSendManager.as:149` | none | C>S 5141 0x1415 `U_C_CONSORTIA_INVITEDEL` | `ConsortiaMsg`: `apply_id (#2, INT32)` application id | 36 (body unused), then the client re-requests 8209 |
| M8 | "Concordar" / "Ignorar" on an invitation (list or popup) | `RecordItem.__onAcceptHandler` `RecordItem.as:70`, `RecordItem.__onRejectHandler` `:85`, `ConsortiaApplyAction.__requestFrameCloseHandler` `decompiled/core_module/scripts/yishi/actions/consortia/ConsortiaApplyAction.as:59` -> `ConsortiaControler.operateConsortiaApply` `ConsortiaControler.as:518` -> `ConsortiaSocketOutManager.operateConsortiaApply` `ConsortiaSocketOutManager.as:53` | none (Assumption: server rechecks cooldown, level and guild capacity) | C>S 5143 0x1417 `U_C_CONSORTIA_USERPASS` | `ConsortiaMsg`: `apply_id (#2)` invitation id, `result (#14, BOOL)` true = accept, false = reject | 37 to the invitee; on accept also the join sequence J (below) |
| M9 | Create button | `CreatConsortiaFrame.__onCreatHandler` `decompiled/m6/scripts/consortia/view/club/CreatConsortiaFrame.as:237` -> `canCreat` `:252` -> `ConsortiaControler.creatConsortia` `ConsortiaControler.as:596` -> `ConsortiaSocketOutManager.creatConsortia` `ConsortiaSocketOutManager.as:62` | gold >= 200000 ("Ouro inferior à {0}, não é possível criar Guilda"); hero level >= 12 ("Líder não atingiu Nv. {0}, não é possível criar Guilda"); trimmed name not empty ("Insira o nome da Guilda"); no forbidden words in `name` and `chat` lists ("Nome da Guilda contêm caractéres inválidos, insira novamente"); width 4..10 where each char outside `\x00-\xff` counts 2 ("Tamanho do nome da Guilda inválido, insira novamente"). Rejoin cooldown popup `Consortia.ConsortiaSocketOutManager.content2` with 50 diamonds as in M4 | C>S 5130 0x140a `U_C_CONSORTIA_CREATE` | `ConsortiaMsg`: `consortia_name (#13, STRING)`, `is_pay (#17, BOOL)` | Create sequence C (below). 34 `U_C_CONSORTIA_CREATE` has no client listener |
| M10 | Review applicants page arrows | `ApplyPlayerList.__onPageBtnHandler` `decompiled/m6/scripts/consortia/view/myConsortia/recruit/ApplyPlayerList.as:255` -> `ConsortiaControler.getConsortiaApplyInfos` `ConsortiaControler.as:807`; first page from `ApplyPlayerList.initData` `:156` | page bounds | C>S 8214 0x2016 | `SearchConditionMsg`: `page_index` (1 based), `is_newOpen` = true | 4140 |
| M11 | Accept / reject applicant (row or bulk) | `ApplyPlayerItem.__onAcceptHandler` `decompiled/m6/scripts/consortia/view/myConsortia/recruit/ApplyPlayerItem.as:119`, `__onRejectHandler` `:129`, `ApplyPlayerList.__onAcceptHandler` `:261`, `__onRejectHandler` `:276` -> `ConsortiaControler.consortiaAcceptOrRejectApply` `ConsortiaControler.as:829` -> `ConsortiaSocketOutManager.consortiaAcceptOrRejectApply` `ConsortiaSocketOutManager.as:123`, one packet per selected applicant | entry visible with right 9; accepting an applicant whose `consortiaID != 0` is blocked locally ("Usuário já é membro da Guilda") | C>S 5134 0x140e `U_C_CONSORTIA_PASS` | `ConsortiaMsg`: `apply_id (#2)` = applicant row `parameter1`, `result (#14)` accept or reject | 40 per request; on accept join sequence J for the applicant |
| M12 | "Recusar Inscrição" checkbox | `ApplyPlayerList.__onRejectApplyHandler` `ApplyPlayerList.as:302` -> `ConsortiaControler.ifOpenApply` `ConsortiaControler.as:1081` -> `ConsortiaSocketOutManager.ifOpenApply` `ConsortiaSocketOutManager.as:175` | visible only with right 33 (`ApplyPlayerList.as:207`) | C>S 5149 0x141d `U_C_CONSORTIA_OPENAPP` | `ConsortiaMsg`: `result (#14)` = true to accept applications (`open_app`), false to refuse | 164 refresh with new `open_app` (Assumption; 51 `U_C_CONSORTIA_OPENAPP` has no listener) |
| M13 | Invite from menus | `ConsortiaControler.sendConsortiaInvitePlayer` `ConsortiaControler.as:1074` -> `ConsortiaSocketOutManager.consortiaInvitePlayer` `ConsortiaSocketOutManager.as:167`; callers `PlayerMenu.__consortiaHandler` `PlayerMenu.as:586`, `ChatItemMenu.__consortiaHandler` `ChatItemMenu.as:373`, `IMFrame.__consortiaBtnClickHandler` `IMFrame.as:402`, `ConsortiaRecruitFrame.__getUserInfoHandler` `ConsortiaRecruitFrame.as:158` | right 9 and target without guild (`PlayerMenu.as:301`). Recruit frame path: target found, not self ("Não pode convidar a si mesmo!"), level >= 12 ("Nível insuficiente do jogador, não pode convidar!"), no guild ("Jogador já é membro de outra Guilda!"). Client shows "Convite enviado!" immediately | C>S 5142 0x1416 `U_C_CONSORTIA_INVITE` | `ConsortiaMsg`: `other_id (#3, INT32)` invited user id | none to inviter. Push 41 to the invitee if online |
| M14 | Recruit frame confirm | `ConsortiaRecruitFrame.__onConfirmHandler` `ConsortiaRecruitFrame.as:194` -> `ConsortiaControler.SearchPlayer` `ConsortiaControler.as:756` | nickname not empty ("Insira apelido do jogador!"), width <= 12 | C>S 8257 0x2041 `C_PLAYER_SEARCH` | `SimplePlayerSearchReqMsg`: `other_nickname (#1, STRING)` | 4170 |
| M15 | Member tab open | `ConsortiaMemberView.initData` `ConsortiaMemberView.as:80` -> `ConsortiaManager.getConsortiaUserInfos` `ConsortiaManager.as:876` -> `ConsortiaSocketOutManager.getConsortiaUserInfos` `ConsortiaSocketOutManager.as:189` | none | C>S 8207 0x200f `U_C_CONSORTIAUSER_LIST` | no body | 4133 (one or more chunks) |
| M16 | "Expulsar" in member menu | `ConsortiaPlayerMenu.__onFireHandler` `ConsortiaPlayerMenu.as:155`, confirm "Certeza ao expulsar", then `ConsortiaControler.fireMember` `ConsortiaControler.as:1066` -> `ConsortiaSocketOutManager.fireMember` `ConsortiaSocketOutManager.as:159` | button visible only with right 5; enabled when own duty < target duty and own duty != 5 (`ConsortiaPlayerMenu.as:214`) | C>S 5132 0x140c `U_C_CONSORTIA_DELUSER` | `ConsortiaMsg`: `other_id (#3)` member to kick | Kick sequence K. No client listener for a kick result |
| M17 | Exit button | `ConsortiaStaffPage._extiConsortiaBtnHandler` `ConsortiaStaffPage.as:373`, `exitCallback` `:384` -> `ConsortiaSocektSendManager.exitConsortia` `ConsortiaSocektSendManager.as:141` | chairman with `currentCount > 1` blocked ("Guilda possui outros membros, presidente não pode sair da Guilda!"). If the clear cooldown checkbox is set: needs item 208013 ("Cartão de Aliança") count > 0 or `point > 50`, else recharge popup. Frame closes immediately | C>S 5146 0x141a `U_C_CONSORTIA_QUIT` | `ConsortiaQuitReqMsg`: `clear_CD_type (#1, INT32)` 0 = normal, 1 = pay to clear the 24 h cooldown (item 208013 first, else `Consortia_ClearCD_Point` diamonds); `pay_type (#2, INT32)` not set by client (0) | Leave sequence L; disband sequence D when the leaver is the last member |
| M18 | Robot guild auto invite | `ConsortiaManager.__levelUpgradeHandler` `ConsortiaManager.as:143` -> `ConsortiaSocketOutManager.autoInvite` `ConsortiaSocketOutManager.as:183` | hero level reaches 15 (`AUTO_INVITE_LEVEL`, `:88`) and no guild | C>S 8197 0x2005 `U_C_CONSORTIA_ROBOTJOIN` | no body | Assumption: server picks a robot guild and pushes 41 (invitation) so the player sees the popup; see Open questions |

Server sequences referenced above:

- C (create): validate (B1 to B6 in Backend notes); insert guild, duties ([ranks.md](ranks.md)), member as chairman (duty 1); debit 200000 gold (and 50 diamonds if `is_pay`); delete all own applications and pending invitations. Push to creator: 3 `U_C_PLAYER_INFO` (`PlayerMsg` `consortia_id (#12)`, `consortia_name (#13)`, `consortia_offer (#19)` = 0, `consortia_totaloffer (#52)` = 0, gold via the resource push used elsewhere), then 117 `U_C_CONSORTIA_STATIC` (`consortia_id`). 117 triggers `ConsortiaManager.setup` (`ConsortiaManager.as:729`) which requests 8211, 8207, 8212 and treasure 9629; answer them with 4137, 4133, 4138. Event type 1 is not needed for creation (Assumption).
- J (join, from M8 or M11): insert member with duty 5, `consortia_offer` 0 (Assumption: personal contribution resets on join, see Open questions), delete the joiner's other applications and invitations. Push to joiner if online: 37 (`result` true, `apply_id`) only for M8, then 3 (`consortia_id`, `consortia_name`), then 117 (`consortia_id`). Push 164 `U_CH_CONSORTIA_FRESHINFO` (`ConsortiaInfoMsg` with new `current_count`) to every online member; their clients re-request 8207 because `current_count` changed (`ConsortiaManager.as:504`). Optional 4266 to the accepted applicant (see Server messages). Insert event type 1.
- K (kick): delete member. Push to kicked if online: 3 (`consortia_id` 0, `consortia_name` ""), 117 (`consortia_id` 0, `return_item` per [Open questions]). Push 164 to remaining online members. Insert event type 2. Assumption: kicked players get no rejoin cooldown (`is_auto` false).
- L (leave): delete member; set player `last_left_guild_at = now`, `left_voluntarily = true` unless `clear_CD_type == 1` was paid. Push to leaver: 46 `U_C_CONSORTIA_QUIT` (`ConsortiaQuitReqMsg`, body ignored except by queue bar), 3 (`consortia_id` 0, `is_auto (#58)`, `lastOutConsortia (#59)` as "YYYY-MM-DD hh:mm:ss"), 117 (`consortia_id` 0). Push 164 to remaining members. Insert event type 3.
- D (disband): as L for the last member, then delete the guild row and all dependent rows (duties, applications, invitations, events, election). Storage items go back by mail and `return_item = true` in 117 (cross area, economy).

## Server messages

| Route | Message and fields read | When | Client handler and effect |
|---|---|---|---|
| S>C 4139 0x102b `U_C_CONSORTIA_SEARCH` | `ConsortiaSearchRspMsg`: `total_rows (#1, INT32)` total matches; `consortiaInfo (#2, ConsortiaInfoMsg, repeated)` reading only `consortia_id (#1)`, `consortia_name (#29)`, `chairman_name (#31)`, `levels (#4)`, `offer (#20)`, `current_count (#6)`, `honor (#21)`, `description (#28)`, `is_robot (#46)`; `is_reset (#3, BOOL)` | Response to 8213 | `ConsortiaControler.__refreshConsortiaList` `ConsortiaControler.as:463` sets `model.consortiaList` and `setTotalRows`; listener only while a consortia frame is open (`:103`). Rows beyond 8 are ignored (`ConsortiaSeachLeftView.as:328`) |
| S>C 4135 0x1027 `U_C_INVITEINFO_LIST` | `ConsortiaUserInviteInfoListRspMsg`: `inviteInfo (#1, repeated ConsortiaUserInviteInfoMsg)`: `id (#1)` record id, `consortia_id (#2)`, `consortia_name (#3)`, `create_date (#4, STRING "YYYY-MM-DD hh:mm:ss")`, `user_id (#5)` invitee or applicant, `user_nickname (#6)`, `invite_id (#7)` inviter user id, `invite_nickname (#8)`, `chairman_nickname (#9)`, `invite_date (#10)`, `from_type (#11, BOOL)` true = invitation from a guild, false = own application, `isexist (#12, BOOL)` | Response to 8209; also after 35, 36, 41 | `ConsortiaManager.__refreshRecordList` `ConsortiaManager.as:627`: splits into `inviteList` and `applyList`, max 10 each; shines the guild button when invitations exist; if a 41 id is pending, queues the invitation popup "{0} o convida à participar da Guilda: {1}" (`:668`) |
| S>C 35 0x0023 `U_C_CONSORTIA_USERINVITE` | `ConsortiaMsg`: `apply_id (#2)` non zero = success | Response to 5135 | `ConsortiaManager.__joinConsortiaHandler` `ConsortiaManager.as:405`: re-requests 8209, tip "Aplicação sucedida". `ConsortiaControler.__joinConsortiaHandler` `ConsortiaControler.as:500` (frame open): re-requests 8209 and dispatches `APPLY_CONSORTIA_SUCCESS` (switch to apply tab). Zero `apply_id` gives no tip; send a 111 alert with the reason |
| S>C 36 0x0024 `U_C_CONSORTIA_INVITEDEL` | body ignored | Response to 5141 | `ConsortiaControler.__deleteApplyConsortiaHandler` `ConsortiaControler.as:513` re-requests 8209 |
| S>C 37 0x0025 `U_C_CONSORTIA_USERPASS` | `ConsortiaMsg`: `result (#14)` accepted, `apply_id (#2)` invitation id | Response to 5143 | `ConsortiaManager.__operateConsortiaApplyResult` `ConsortiaManager.as:361`: if `result`, tip "Parabéns ao juntar-se à Guilda {0}" using the name from `inviteList` (send 37 before any 4135 refresh). `ConsortiaControler.__operateConsortiaApplyResult` `ConsortiaControler.as:523` removes the record from `inviteList` |
| S>C 41 0x0029 `U_C_CONSORTIA_INVITE` | `ConsortiaMsg`: `apply_id (#2)` invitation record id | Push to an online invitee without guild (listener only while `consortiaID == 0`, `ConsortiaManager.as:139`, `:356`, `:739`) | `ConsortiaManager.__consortiaInviteHandler` `ConsortiaManager.as:698`: stores the id and requests 8209; 4135 then shows the popup |
| S>C 40 0x0028 `U_C_CONSORTIA_PASS` | body ignored | Response to each 5134 | `ConsortiaControler.__consortiaAcceptApplyHandler` `ConsortiaControler.as:849`: `recruitNum--`; when it reaches 0, re-requests 8214 |
| S>C 4140 0x102c `U_C_CONSORTIA_INVITE_LIST` | `SimplePlayerListRspMsg` (simple): `total_rows (#1)` total applicants, `playerInfo (#2, repeated simple.SimplePlayerInfoMsg)` reading `consortiaID (#8)`, `nickName (#2)`, `grades (#14)`, `job (#26)`, `storeGrade (#28)`, `fightingCapacity (#21)`, `parameter1 (#19)` = application id, `trans_grade (#38)`, `changeBranch (#42)`; `uuid (#3)` unused here | Response to 8214 | `ConsortiaManager.__refreshApplyList` `ConsortiaManager.as:421`: pages = `ceil(total_rows/8)`, `recruitNum = total_rows` (badge, red dot via `giftCount` `:1538` when right 9) |
| S>C 4266 0x10aa `U_C_CONSORTIA_PASS_USER` | body ignored | Assumption: push to managers (right 9) when a new application arrives, or to an applicant when accepted | `ConsortiaManager.__operateConsortiaPassUser` `ConsortiaManager.as:336`: shines the toolbar guild button if the guild frame is closed |
| S>C 4267 0x10ab `U_C_CONSORTIA_LINK` | `ConsortiaLinkRspMsg`: `consortia_id (#1)`, `consortia_name (#2)`, `creator_name (#3)` shown as chairman, `levels (#4)`, `Offer (#5)`, `current_count (#6)`, `honor (#7)`, `description (#8)` | Response to 8343 | `ConsortiaManager.__linkConsortia` `ConsortiaManager.as:388` opens `lookconsortiainfo` openType 6 (`ConsortiaInfoFrame`). Note: field 3 is labelled creator but displayed as chairman; send the current chairman nickname |
| S>C 4170 0x104a `U_C_PLAYER_SEARCH` | `SimplePlayerSearchRspMsg`: `info (#1, simple.SimplePlayerInfoMsg)`: `userId (#1)`, `nickName (#2)`, `grades (#14)`, `consortiaID (#8)` | Response to 8257 | `ConsortiaRecruitFrame.__getUserInfoHandler` `ConsortiaRecruitFrame.as:158` (case insensitive nickname match, else "Usuário não encontrado!") |
| S>C 4133 0x1025 `U_C_CONSORTIAUSER_LIST` | `SimplePlayerListRspMsg`: `total_rows (#1)` = total members, `playerInfo (#2, repeated)`, `uuid (#3, STRING)` required. Per member (simple.SimplePlayerInfoMsg): `userId (#1)`, `nickName (#2)`, `grades (#14)`, `consortiaOffer (#11)`, `consortiaTotalOffer (#27)`, `consortiaName (#10)`, `fightingCapacity (#21)`, `sexs (#4)`, `state (#7)` (0 offline, non zero online), `job (#26)`, `role (#31)`, `is_teamPlayer (#30)`, `is_inwar (#34)`, `logOutTime (#17, "YYYY-MM-DD hh:mm:ss")`, `is_vip (#32)`, `vip_type (#33)`, `head_id (#35)`, `dutyId (#18)`, `cross_guildTeamId (#37)`, `is_back_player (#41)`, `trans_grade (#38)`, `changeBranch (#42)` | Response to 8207 | `ConsortiaManager.__updateConsortiaMember` `ConsortiaManager.as:882`: packets without `uuid` are dropped; chunks with the same `uuid` are concatenated until `playerInfo.length == total_rows`, then the member dictionary is replaced (`:985`), own rights recomputed, `UPDATA_CONSORTIA_MEMBER` dispatched. Members with empty nickname are skipped (`:942`) |
| S>C 117 0x0075 `U_C_CONSORTIA_STATIC` | `ConsortiaMsg`: `consortia_id (#1)` new guild id or 0, `return_item (#16, BOOL)` storage items mailed back | Push to a player whose guild changed (create, join, leave, kick, disband) | `ConsortiaManager.__consortiaStageChange` `ConsortiaManager.as:721`: non zero runs `setup()` (requests 8211, 8207, 8212, treasure), stops listening 41, dispatches `IS_CONSORTIA_EXIST` (controller reopens the guild frame, `ConsortiaControler.as:541`); zero clears member list, skills, ranking, secret land data, returns to space if inside the guild secret land map, queues the mail notice popup if `return_item`, listens 41 again |
| S>C 3 0x0003 `U_C_PLAYER_INFO` | `PlayerMsg`: `consortia_id (#12)`, `consortia_name (#13)`, `consortia_offer (#19)`, `consortia_totaloffer (#52)`, `is_auto (#58, BOOL)`, `lastOutConsortia (#59, STRING)`, `point (#6)`, `gift_token (#7)` | Login and after any membership or currency change | `PlayerManager.__uPlayerInfoHandler` `decompiled/core_module/scripts/yishi/manager/PlayerManager.as:496` (guild fields `:663`, `:667`, `:679`, `:683`, `:857`, `:861`). A `consortiaID` change fires `CONSORTIA_CHANGE` (`decompiled/core_module/scripts/yishi/datas/playerinfo/SimplePlayerInfo.as:1367`): when 0, `ConsortiaManager.__consortiaChangeHandler` `ConsortiaManager.as:344` shows "Você saiu da Guilda" and closes guild frames |
| S>C 46 0x002e `U_C_CONSORTIA_QUIT` | `ConsortiaQuitReqMsg` (fields ignored) | Push to the leaver after 5146 | `ConsortiaManager.__consortiaQuitHandler` `ConsortiaManager.as:1281` clears secret land, quests, business lists; `QueueBarManager.__consortiaQuitHandler` `decompiled/core_module/scripts/yishi/manager/QueueBarManager.as:167` resets the altar queue entry |
| S>C 164 0x00a4 / 4138 0x102a | `ConsortiaInfoMsg` (see [profile.md](profile.md)) | Membership change refresh | `ConsortiaManager.__refreshConsortiaInfo` `ConsortiaManager.as:457`; a changed `current_count` with a previous non zero value triggers 8207 (`:504`) |
| S>C 111 0x006f `U_C_CHANNEL_ALERT` | `ChatChannelMsg`: `encode_msg (#3, STRING)` text, XML tags replaced by their `name` attribute | Any rejection reason (Assumption: generic server error tip) | `BaseManager.__serverBroadcastHandler` `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2171` shows a floating tip |

## Rules and formulas

- Search page size 8 (`ConsortiaModel.CONSORTIA_SEARCH_PAGE_NUM`, `decompiled/core_module/scripts/mvc/module/consortia/ConsortiaModel.as:26`; 8 rows `ConsortiaSeachLeftView.as:152`). Pages are 1 based. Name search: `page_index` restarts at 1 for a new text; the client wraps when `(page-1)*8 >= total_rows` (`ConsortiaSeachLeftView.as:265`). Random browse: server decides order; it must return `is_reset = true` when it wraps back to page 1 (`ConsortiaControler.as:478`). Assumption: random browse returns guilds that accept applications (`open_app`), excluding full guilds, ordered randomly or by level.
- Member cap = `levels * 20 + 10` (`ConsortiaItem.as:174`; matches `ConsortiaLevelInfos.xml` descriptions 30 at level 1 to 210 at level 10 and `Consortia_Member = 20` in `raw/xml/tempinfos/ConfigInfos.xml`).
- Create: cost 200000 gold (`ConsortiaModel.CREAT_NEEDED_GOLD` `ConsortiaModel.as:30`, `CreatConsortiaFrame.as:256`, config `Consortia_Gold = 200000`); hero level >= 12 client side (`CREAT_NEEDED_GRADES` `ConsortiaModel.as:32`, `CreatConsortiaFrame.as:262`) but config `Consortia_Grade = 13` (Open question; the guild button itself opens at 13, so effective minimum is 13). Name width 4..10 where non Latin-1 chars count 2 (`CreatConsortiaFrame.as:281`); forbidden words checked client side; server must also enforce uniqueness (case insensitive, Assumption) and the forbidden word list.
- Apply: hero level >= 12 (`ConsortiaSocektSendManager.as:230`); max 10 outstanding applications (`ConsortiaModel.APPLY_MAX = 10` `ConsortiaModel.as:48`, `ConsortiaSocektSendManager.as:236`); no duplicate application to the same guild (`:221`). Server: reject if the player already has a guild, guild is full, or `open_app` is false (Assumption).
- Invitations: client keeps at most 10 invitations and 10 applications (`ConsortiaManager.as:643`). Inviter needs right 9 (PASSINVITE). Target: level >= 12, no guild.
- Rejoin cooldown: 24 h after leaving voluntarily. Client gate is `isAuto && lastOutConsortia + 86400 > now` (`ConsortiaSocektSendManager.as:170`, `ConsortiaControler.as:607`, `TopToolsBar.as:2181`). Pay to skip on apply or create: `Consortia_ClearCD_Point` = 50 diamonds (real diamonds `point`, `ConsortiaSocektSendManager.as:178`). Pay to skip on leave: item 208013 first, else 50 diamonds (`ConsortiaStaffPage.as:399`, text `consortia.view.myConsortia.ConsortiaFrame.checkTxt`).
- Applicant review: page size 8 (`APPLY_CONSORTIA_PAGE_NUM` `ConsortiaModel.as:38`, `ApplyPlayerList.as:66`); sorted client side by power descending (`ConsortiaModel.as:770`). Right 9 to review (`ConsortiaStaffPage.as:109`), right 33 to toggle `open_app` (`ApplyPlayerList.as:209`).
- Kick: right 5; actor duty < target duty and actor duty != 5 (`ConsortiaPlayerMenu.as:222`). `kick_count`/`kick_date` exist in `ConsortiaInfoMsg` (#7, #37), suggesting a daily kick limit (Open question).
- Leave: chairman cannot leave while `current_count > 1` (`ConsortiaStaffPage.as:391`). Chairman alone leaving disbands the guild (Assumption based on the same check; there is no dedicated disband opcode in the client; `DISBAND` right 32 is never checked in UI).
- Member list: own row first, then by duty ascending on first display (`ConsortiaMemberList.as:153`); column sorts are client side. Offline text uses `logOutTime`; `logOutTime == 2000-01-01 00:00` (946656000000 ms, local time of the original server) prints "1 dias" (`ConsortiaMemberItem.as:343`). `right == 3` marks a robot member (`ConsortiaMemberItem.as:333`, `ConsortiaManager.as:979`).
- Robot guilds: `is_robot` guilds are listed (`ConsortiaModel.robotConsortiaList` `ConsortiaModel.as:449`); the client fabricates a fake chairman member (level 12, duty 1, offer 10) if the chairman is not in the member list (`ConsortiaManager.as:958`). `Consortia_Change = 20` (robot guild transfer member threshold, server rule, Assumption: chairmanship moves to a real player once the robot guild reaches 20 members).

## Templates

| File | Record | Fields used here |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `ConfigName`/`ConfigValue` | `Consortia_Gold` 200000 create cost; `Consortia_Grade` 13 create level; `Consortia_Member` 20 members per level; `Consortia_ClearCD_Point` 50 diamonds to skip the 24 h cooldown; `Consortia_Change` 20 robot guild transfer threshold |
| `raw/xml/tempinfos/ConsortiaLevelInfos.xml` | `ConsortiaLevelInfo` Types=1 | Member cap description per level (see [profile.md](profile.md)) |
| `index/language.json` | pt-BR strings | Keys under `consortia.view.club.*`, `consortia.ConsortiaControler.command0*`, `Consortia.ConsortiaSocketOutManager.content*`, `yishi.manager.ConsortiaManager.*`, `consortia.view.myConsortia.recruit.*`, `consortia.view.myConsortia.ConsortiaFrame.*` |

## Persistent state

`guild.guild` is defined in [profile.md](profile.md). Duties and rights are in [ranks.md](ranks.md).

```sql
CREATE TABLE guild.member (
    guild_id            integer     NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
    player_id           BIGINT     NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,
    duty_level          smallint    NOT NULL DEFAULT 5 CHECK (duty_level BETWEEN 1 AND 5),
    contribution        integer     NOT NULL DEFAULT 0 CHECK (contribution >= 0),        -- consortiaOffer, spendable
    total_contribution  integer     NOT NULL DEFAULT 0 CHECK (total_contribution >= 0),  -- consortiaTotalOffer
    cross_guild_team_id integer     NOT NULL DEFAULT 0,
    joined_at           timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id),
    UNIQUE (guild_id, player_id)
);
CREATE UNIQUE INDEX member_one_chairman ON guild.member (guild_id) WHERE duty_level = 1;
CREATE INDEX member_guild_idx ON guild.member (guild_id, duty_level);

CREATE TABLE guild.join_request (
    id            serial      PRIMARY KEY,                -- apply_id / ConsortiaUserInviteInfoMsg.id / parameter1
    guild_id      integer     NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
    player_id     BIGINT     NOT NULL REFERENCES public.player(id) ON DELETE CASCADE,  -- applicant or invitee
    inviter_id    integer     REFERENCES public.player(id) ON DELETE SET NULL,          -- set for invitations
    kind          text        NOT NULL CHECK (kind IN ('application', 'invitation')),   -- from_type false / true
    created_at    timestamptz NOT NULL DEFAULT now(),
    UNIQUE (guild_id, player_id, kind)
);
CREATE INDEX join_request_player_idx ON guild.join_request (player_id, kind);
CREATE INDEX join_request_guild_idx ON guild.join_request (guild_id, kind, created_at);

CREATE TABLE guild.player_state (
    player_id          BIGINT     PRIMARY KEY REFERENCES public.player(id) ON DELETE CASCADE,
    last_left_at       timestamptz,                         -- lastOutConsortia
    left_voluntarily   boolean     NOT NULL DEFAULT false,  -- is_auto
    robot_invite_sent  boolean     NOT NULL DEFAULT false
);
```

Notes: `public.player` stands for the existing player table (name to align with the server schema). The player's `consortia_id`/`consortia_name` sent in `PlayerMsg` are derived from `guild.member` join `guild.guild`.

## Backend implementation notes

Handlers (one per request opcode):

| Opcode | Handler |
|---|---|
| 8213 | `guild::membership::handle_search` |
| 8209 | `guild::membership::handle_list_join_requests` |
| 8343 | `guild::membership::handle_link` |
| 5135 | `guild::membership::handle_apply` |
| 5141 | `guild::membership::handle_cancel_application` |
| 5143 | `guild::membership::handle_answer_invitation` |
| 5130 | `guild::membership::handle_create` |
| 8214 | `guild::membership::handle_list_applicants` |
| 5134 | `guild::membership::handle_review_applicant` |
| 5149 | `guild::membership::handle_set_open_applications` |
| 5142 | `guild::membership::handle_invite` |
| 8257 | `guild::membership::handle_player_search` (shared with transfer, see [ranks.md](ranks.md)) |
| 8207 | `guild::membership::handle_list_members` |
| 5132 | `guild::membership::handle_kick` |
| 5146 | `guild::membership::handle_leave` |
| 8197 | `guild::membership::handle_robot_join` |

Validation order (apply, create, answer invitation): B1 player has no guild; B2 hero level; B3 cooldown (`left_voluntarily && last_left_at + 24h > now`) unless `is_pay` and enough diamonds; B4 target guild exists and `open_app` (apply only); B5 capacity `member count < levels*20+10` (join only); B6 name rules and uniqueness, 200000 gold (create only); B7 outstanding applications < 10 and no duplicate (apply only).

Validation order (review, kick, invite): actor is member; actor right bit (9 review and invite, 33 open_app, 5 kick) from `guild.duty` ([ranks.md](ranks.md)); hierarchy (kick: actor duty < target duty, actor duty != 5); target state (applicant still without guild and request still exists; target is a member of the same guild); capacity on accept.

Transactions: create (guild + duties + member + gold debit + request cleanup), join (member insert + request cleanup + event), leave/kick/disband (member delete + player_state + event, plus guild delete on disband) are each one database transaction. Send pushes only after commit.

Push fan out:

- Every membership change: 164 `ConsortiaInfoMsg` to all online members of the guild (they refresh the list with 8207).
- To the affected player: 3, then 117 (plus 37 or 46 as described). Joining also clears the 41 listener client side.
- New application: 4266 to online members with right 9 (Assumption) so their badge refreshes after they request 8214.
- Invitation: 41 to the invitee if online; offline invitees see it in 8209 at login (`decompiled/core_module/scripts/yishi/lunch/Yishi.as:623`).
- Member list chunks: send 4133 in chunks of at most 50 members, all with the same random `uuid` and the full `total_rows`.

## Open questions

1. Create level: client checks 12, config `Consortia_Grade` says 13. Use 13 server side (button opens at 13) unless the original server is known.
2. `CreatConsortiaFrame.checkEnabled` (`:195`) treats items of son type 295 as an alternative to gold for display only; `canCreat` still requires gold. Does a guild creation token exist server side?
3. 8197 robot join: does the server join the player directly (then 117) or send an invitation (41)? Popup text supports the invitation path.
4. Does personal `consortia_offer` survive leaving a guild? The client keeps it in `PlayerInfo`; skill levels depend on it (economy area).
5. 4266 exact recipient.
6. Daily kick limit (`kick_count`, `kick_date`).
7. Invitation and application expiry time (client shows `create_date`/`invite_date` but never filters).
8. Whether kicked players also get the 24 h cooldown (`is_auto`).
9. Error feedback channel for failures (111 assumed).

## Implementation checklist

Client flows to verify in the browser:

- [ ] Toolbar guild button opens `ConsortiaSearchFrame` for a player without guild (8214, 8209, 8213 answered)
- [ ] Search by name, paging wrap, random browse with `is_reset`
- [ ] Select all and join several guilds (multiple 5135, 35 each)
- [ ] Apply from `ConsortiaInfoFrame` (via 8343/4267 from recruit chat link)
- [ ] Rejoin cooldown popup and paid apply/create (`is_pay`)
- [ ] Cancel application ("Revogar", 5141/36)
- [ ] Invitation popup (41 -> 8209 -> 4135 -> `ConsortiaApplyAction`) and accept/reject (5143/37)
- [ ] Invitation list accept/reject in `RecordItem`
- [ ] Create guild (5130 -> 3 -> 117 -> 8211/8207/8212 -> `ConsortiaFrame` opens)
- [ ] Member tab list with chunked 4133 and sorting
- [ ] Applicant review frame: paging, accept, reject, bulk, badge count, "Recusar Inscrição"
- [ ] Invite by nickname (8257/4170 -> 5142) and from player menus, chat menu, IM, target menu
- [ ] Kick from member menu (5132)
- [ ] Leave with and without paid cooldown clear (5146 -> 46, 3, 117); `ForbidConsortiaView` countdown
- [ ] Chairman leave blocked with members; disband when alone
- [ ] Robot join at level 15 (8197)

Backend:

- [ ] Tables `guild.member`, `guild.join_request`, `guild.player_state`
- [ ] Handlers listed in Backend implementation notes (16)
- [ ] `ConsortiaSearchRspMsg`, `ConsortiaUserInviteInfoListRspMsg`, `ConsortiaLinkRspMsg`, `SimplePlayerListRspMsg` (chunked with `uuid`), `simple.SimplePlayerInfoMsg` encoders
- [ ] Pushes 35, 36, 37, 40, 41, 46, 117, 164, 4266, 3, 111
- [ ] Name validation (width rule, forbidden words, uniqueness)
- [ ] Cooldown logic and diamond/item payment (item 208013)
- [ ] Capacity check `levels*20+10`
- [ ] Event rows types 1, 2, 3 ([logs.md](logs.md))
- [ ] Disband cascade and storage mail return (economy dependency)
- [ ] Flow rules in `server/flows/navigation.json` for 8213 and 8214 replaced by real handlers
