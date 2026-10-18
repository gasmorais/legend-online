# Guild ranks and permissions

Area: guild core, module `ranks`. Covers the five duty levels, the rights bitset, every right number and the client controls it unlocks, vice chairman custom rights (settings frame), promote, demote and leadership transfer.

Conventions: see [membership.md](membership.md) (paths, route notation, proto field notation). No HTTP servlet is involved.

## Overview

Every member has a `dutyId` (duty level) from 1 to 5. The server sends one duty record per level (`ConsortiaDutyInfoMsg`) with a `rights` byte array; the client derives the local player's rights from the record of his own duty (`ConsortiaManager.setRightsList`, `decompiled/core_module/scripts/yishi/manager/ConsortiaManager.as:837`) and every UI gate calls `ConsortiaControler.getRightsByIndex(n)` (bit `n-1`, `decompiled/core_module/scripts/mvc/controler/ConsortiaControler.as:551`). The hard coded arrays in `ConsortiaDutyInfo` are only used to render the settings and legacy permission frames, so the server is authoritative.

Some rights can be delegated by the chairman to the vice chairman duty (level 2): they are stored as a comma separated list `rightsStr` on the level 2 record and checked by `getRightsByNum(n)` (`ConsortiaControler.as:568`), which requires the local player to hold right 19 and the level 2 `rightsStr` to contain `n`.

The chairman promotes and demotes through the member menu, opens the settings frame ("Configurações de Privilégios"), and transfers leadership by nickname ("Transferir Guilda"). Others see the read only "Ver privilégios" frame.

## Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `ConsortiaPlayerMenu` (`decompiled/core_module/scripts/yishi/view/community/ConsortiaPlayerMenu.as:45`) | "Promover", "Rebaixar", "Expulsar" | Promote, demote, kick (kick in [membership.md](membership.md)) | Member row click (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaMemberItem.as:276`), contribution row click (`decompiled/m6/scripts/consortia/view/myConsortia/contribution/ConsortiaContributionItem.as:85`) | Buttons enabled by `setRights` (`:192`) |
| `ConsortiaSettingFrame` + 15 `ConsortiaSettingItem` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaSettingFrame.as:62`, `ConsortiaSettingItem.as:84`) | chairman: "Configurações de Privilégios"; others: "Ver privilégios"; columns "Líder da Guilda", "Vice-líder da Guilda", "Oficial", "Membro"; footer "* O líder da guilda pode alterar os privilégios dos membros *" | Matrix of 15 rights by duty; chairman toggles the vice column for rights 20, 41, 43, 45, 46 | Staff page settings button (chairman) or inquire button (others) (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaStaffPage.as:156`, `:263`) | Static arrays plus level 2 `rightsStr` |
| `ConsortiaTransferFrame` (`decompiled/m6/scripts/consortia/view/myConsortia/chairmanPath/ConsortiaTransferFrame.as:55`) | "Transferir Guilda"; hint "Clique para ins. apelido"; "Aviso: Só pode transferir para membros dessa Guilda" | Transfer leadership by nickname | Staff page transfer button (right 1) (`ConsortiaStaffPage.as:142`, `:342`) | none |
| `ConsortiaPermissionFrame` / `ConsortiaPermissionItem` (`decompiled/m6/scripts/consortia/view/myConsortia/chairmanPath/ConsortiaPermissionFrame.as:93`) | "Visualizar Privilégios" | Legacy read only rights viewer; duty rename only edits the local object (`ConsortiaPermissionItem.as:110`) | `ConsortiaFrame.__helpBtnClickHandler` (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrame.as:224`), not wired to any button: unreachable | Static arrays |

## Duty levels

| `dutyId` | Constant (`decompiled/core_module/scripts/mvc/module/consortia/ConsortiaDutyLevel.as:8`) | Display name (`getDutyByButyLevel` `:23`) | Settings column |
|---|---|---|---|
| 1 | CHAIRMAN | "Presidente" | "Líder da Guilda" (`chairman` array) |
| 2 | VICE_CHAIRMAN | "Vice" | "Vice-líder da Guilda" (`vicePresident`) |
| 3 | OFFICIAL | "Oficial" | "Oficial" (`officer`) |
| 4 | ELITE | "Membro" | "Membro" (`Elite`) |
| 5 | NORMAL | "Membro" | not shown |

New members start at 5 (Assumption based on `refreshChairman` demoting the old chairman to 5, `ConsortiaManager.as:594`). The develop tab of `ConsortiaFrame` is added only when the local member has `dutyId == 1` (`ConsortiaFrame.as:116`).

## Rights

Right numbers are the `ConsortiaDutyInfo` constants (`decompiled/core_module/scripts/mvc/module/consortia/ConsortiaDutyInfo.as:8` to `:74`). Default holders come from the static arrays at `:76` to `:82` (the `Elite` array contains a decompiler `undefined` entry, ignore it). "Client gate" lists every place that checks the right.

| # | Constant | Chairman | Vice | Officer | Elite (4) | Client gate (what it unlocks) |
|---|---|---|---|---|---|---|
| 1 | TRANSFER | yes | | | | Staff page recruit broadcast button, transfer button, guild mail button (`ConsortiaStaffPage.as:124`, `:142`, `:149`); business shop supply column (`decompiled/m6/scripts/consortia/view/myConsortia/item/ConsortiaBusinessItem.as:106`); new boss call (`decompiled/m6/scripts/consortia/view/newboss/ConsortiaNewBossCallFrame.as:225`, `ConsortiaNewBossFrame.as:484`); dream land operate (`decompiled/core_module/scripts/mvc/module/consortia/ConsortiaViewHelper.as:253`). Effectively "is chairman" |
| 2 | UPDATESKILL | yes | yes | | | Research skill button (`decompiled/m6/scripts/consortia/view/myConsortia/skill/ConsortiaResearchSkillItem.as:194`) |
| 3 | UPDATEBUILDING | yes | | | | Guild/building upgrade and speed up buttons (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaDevelopView.as:216`, `:272`, `:344`); notice editable in info tab (`decompiled/m6/scripts/consortia/view/myConsortia/newui/ConsortiaInfoView.as:253`); skill school research (`ConsortiaSkillSchoolView.as:276`); group chat notice edit (`decompiled/m12/scripts/groupchat/ConsortiaGroupChatFrame.as:616`, `:703`) |
| 4 | MOIDIFYBBS | yes | | | | Legacy placard edit (`decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrameRightContent.as:408`, unreachable view) |
| 5 | KICKMEMBER | yes | yes | yes | | Kick button; without it promote/demote/kick buttons are hidden (`ConsortiaPlayerMenu.as:214`) |
| 6 | LOOKLOG | yes | yes | yes | yes | none found |
| 7 | DUTYEDIT | yes | | | | none found |
| 8 | INVITEMEMBER | yes | yes | yes | | none found (invites use right 9) |
| 9 | PASSINVITE | yes | yes | yes | | Applicant review button and badge (`ConsortiaStaffPage.as:109`, `:284`, `decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaFrame.as:234`, `:297`, `ConsortiaManager.as:1543`); invite buttons (`decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as:306`, `decompiled/core_module/scripts/chat/view/ChatOutputViewII.as:554`, `decompiled/m12/scripts/im/IMFrame.as:411` "friends.im.IMFrame.consortia.TipTxt1", `decompiled/core_module/scripts/ui/toptoolbar/view/TargetSelectView.as:178`) |
| 10 | PURSE | yes | yes | yes | yes | none |
| 11 | OPTATIVE | yes | yes | yes | yes | none |
| 12 | LOOKBBS | yes | yes | yes | yes | none |
| 13 | USESKILL | yes | yes | yes | yes | none (settings row "Aprender Habilidade") |
| 14 | USESTORE | yes | yes | yes | yes | none |
| 15 | USESHOP | yes | yes | yes | yes | none |
| 16 | QUIT | yes | yes | yes | yes | none |
| 17 | LEVEL | yes | | | | none (settings row "Elevação da Guilda") |
| 18 | RENAME | yes | | | | Rename button (`ConsortiaStaffPage.as:135`) |
| 19 | CHANGEJOB | yes | yes | | | Promote/demote (`ConsortiaPlayerMenu.as:194`); prerequisite of every `getRightsByNum` |
| 20 | CREATEFIGHT | yes | delegable | | | `getRightsByNum(20)`: cross guild war sign up (`decompiled/m6/scripts/consortia/view/crossguild/CrossGuildSignFrame.as:214`) |
| 21 | JOINFIGHT | yes | yes | yes | yes | none |
| 22 | LOOKFIGHT | yes | yes | yes | yes | none |
| 23 | VIEWMEMBER | yes | yes | yes | yes | none |
| 28 | INVITELIST | yes | yes | yes | | none |
| 30 | MODIFYDESC | yes | | | | Legacy description edit (`ConsortiaFrameRightContent.as:387`, unreachable) |
| 31 | INVITEDEL | yes | yes | yes | | none |
| 32 | DISBAND | yes | | | | none |
| 33 | OPENAPP | yes | | | | "Recusar Inscrição" toggle (`decompiled/m6/scripts/consortia/view/myConsortia/recruit/ApplyPlayerList.as:209`) |
| 41 | CALL_BOSS | yes | delegable | | | `getRightsByNum(41)` new boss call (`ConsortiaNewBossCallFrame.as:227`) |
| 43 | STOCK | yes | delegable | | | `getRightsByNum(43)` business supply (`ConsortiaBusinessItem.as:108`) |
| 44 | MASTER_SKILL | yes | | | | none (settings row "Pesquisa de Habilidades Mestre") |
| 45 | CALL_FARM_TREE | yes | delegable | | | `getRightsByNum(45)` secret land tree (`decompiled/m3/scripts/map/campaign/view/ui/secretland/ConsortiaSecretInfoView.as:228`) |
| 46 | HUGE_HEAD_SIGN | yes | delegable | | | `getRightsByNum(46)` Terralém sign up (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1625`) |
| 47 | CONSORTIA_BOSS | yes | | | | none (settings row "Ativar Terra dos Sonhos") |

Settings rows (`ConsortiaSettingItem.arr`, `ConsortiaSettingItem.as:37`) and labels (`ConsortiaSettingItem.txt.text0..14`): 8 "Recrutar membro", 5 "Expulsar membro", 19 "Elevar/Rebaixar", 18 "Mudar nome da Guilda", 4 "Mudar Anúncio", 17 "Elevação da Guilda", 13 "Aprender Habilidade", 2 "Pesquisa de Habilidades", 44 "Pesquisa de Habilidades Mestre", 45 "Invocação de Yggdrasil", 43 "Liberar coluna de itens de suprimentos", 41 "Ativar o Chefão da Guilda", 47 "Ativar Terra dos Sonhos", 20 "Inscrições para Defesa de Guilda", 46 "Inscrições no Terralém". Only 45, 41, 20, 46, 43 are toggleable (vice column, chairman only, `ConsortiaSettingItem.as:99`).

Rights encoding (`decompiled/core_module/scripts/yishi/utils/BitArray.as:23`): right `n` is bit `(n-1) & 7` (LSB first) of byte `(n-1) >> 3`. Rights up to 47 fit in 6 bytes. Server stores one bitset per duty.

Proposed server defaults: chairman = all rights in the `chairman` array; vice = `vicePresident` array (2,5,6,8,9,10,11,12,13,14,15,16,19,21,22,23,28,31) plus custom delegated rights; officer = `officer` array; levels 4 and 5 = `Elite` array (Assumption: both share the "Membro" column).

## Actions

| # | UI control | Client sender | Client checks | Route | Request message and fields | Resp |
|---|---|---|---|---|---|---|
| R1 | Load duties (login, join, create) | `ConsortiaManager.setup` `ConsortiaManager.as:127` -> `getConsortiaDutyInfos` `:775` -> `ConsortiaSocketOutManager.getConsortiaDutyInfos` `decompiled/core_module/scripts/managers/ConsortiaSocketOutManager.as:216` | in a guild | C>S 8211 0x2013 `U_C_DUTY_LIST` | no body | 4137 |
| R2 | "Promover" | `ConsortiaPlayerMenu.__onPromotionHandler` `ConsortiaPlayerMenu.as:136` -> `ConsortiaControler.changeDuty` `ConsortiaControler.as:1061` -> `ConsortiaSocketOutManager.changeDuty` `ConsortiaSocketOutManager.as:150` | enabled when actor has right 19, actor duty != 0, actor duty < target duty, actor duty != 4, target duty > 2 and actor duty < target duty - 1 (`ConsortiaPlayerMenu.as:197`) | C>S 5137 0x1411 `U_C_CONSORTIA_DUTYUPDATE` | `ConsortiaMsg`: `position_id (#7, INT32)` new duty = target 5 -> 3, otherwise target - 1; `other_id (#3, INT32)` target user id | 50 to all online members |
| R3 | "Rebaixar" | `ConsortiaPlayerMenu.__onDeomotionHandler` `ConsortiaPlayerMenu.as:149` | right 19, actor duty < target duty, actor duty != 4, target duty < 4 (`:203`) | C>S 5137 0x1411 | `position_id` = target duty + 1, `other_id` | 50 |
| R4 | Settings frame vice toggle | `ConsortiaSettingItem.__btn2ClickHandler` `decompiled/m6/scripts/consortia/view/myConsortia/ConsortiaSettingItem.as:79` -> `ConsortiaSocketOutManager.updateRights` `ConsortiaSocketOutManager.as:382` | chairman only (listener added only when chairman, `:63`); right in {20,41,43,45,46} (`:99`) | C>S 9723 0x25fb `C_CONSORTIA_DUTY_RIGHTS_UPDATE` | `simple.PropertyMsg`: `param1 (#1, INT32)` right number to toggle in the level 2 `rightsStr` | 4137 with the updated level 2 record (Assumption: the open frame does not refresh; it reads the model when reopened) |
| R5 | Transfer confirm | `ConsortiaTransferFrame.__onConfirmBtnHandler` `ConsortiaTransferFrame.as:161` -> `ConsortiaControler.SearchPlayer` `ConsortiaControler.as:756` | nickname not empty ("Insira apelido do jogador!"), width <= 12 (`:141`) | C>S 8257 0x2041 `C_PLAYER_SEARCH` | `SimplePlayerSearchReqMsg`: `other_nickname (#1, STRING)` | 4170 |
| R6 | Transfer after search | `ConsortiaTransferFrame.__getUserInfoHandler` `ConsortiaTransferFrame.as:175` -> `ConsortiaControler.consortiaTransfer` `ConsortiaControler.as:764` -> `ConsortiaSocketOutManager.consortiaTransfer` `ConsortiaSocketOutManager.as:103` | found and nickname matches (else "Usuário não encontrado!"); not self ("Não pode transferir para si mesmo!"); level >= 12 ("Nível insuficiente do jogador, não pode transferir!"). Membership is not checked client side | C>S 5131 0x140b `U_C_CONSORTIA_CHANGE` | `ConsortiaMsg`: `other_id (#3, INT32)` new chairman | 164 to all online members with the new `chairman_id`/`chairman_name`; 4137 if rights change (Assumption). 47 `U_C_CONSORTIA_CHANGE` has no listener |

## Server messages

| Route | Message and fields read | When | Client handler and effect |
|---|---|---|---|
| S>C 4137 0x1029 `U_C_DUTY_LIST` | `ConsortiaDutyListRspMsg`: `dutyInfo (#1, repeated ConsortiaDutyInfoMsg)`: `levels (#1, INT32)` duty 1..5, `duty_name (#2, STRING)`, `rights (#3, BYTES)` bitset, `rightsStr (#4, STRING)` comma separated delegated rights (used only on level 2) | Response to 8211; push after 9723 or any rights change | `ConsortiaManager.__refreshDutyInfos` `ConsortiaManager.as:785` stores by `levels` then `setRightsList` (`:837`) which copies the own duty `rights` into `model.usrRights` and dispatches `UPDA_CONSORTIA_RIGHTS` (staff page buttons, applicant list toggle, group chat). Must include all five levels: a member whose duty record is missing gets no rights |
| S>C 50 0x0032 `U_C_CONSORTIA_DUTYUPDATE` | `ConsortiaMsg`: `other_id (#3)` member, `position_id (#7)` new duty | Push to all online members after 5137 (and for both parties after a transfer, Assumption) | `ConsortiaManager.__updataDutyInfo` `ConsortiaManager.as:803`: updates the member `dutyId`; if it is the local player, recomputes rights |
| S>C 164 0x00a4 `U_CH_CONSORTIA_FRESHINFO` / 4138 0x102a `U_C_CONSORTIA_INFO` | `ConsortiaInfoMsg` `chairman_id (#3)`, `chairman_name (#31)` (full message in [profile.md](profile.md)) | After transfer or election result | `ConsortiaManager.__refreshConsortiaInfo` `ConsortiaManager.as:483`: when `chairman_id` changed and the previous value was non zero, `refreshChairman` (`:588`) sets old chairman `dutyId = 5`, new chairman `dutyId = 1`, recomputes rights if the local player is one of them, dispatches `UPDA_CONSORTIA_CHAIRMAN` |
| S>C 4170 0x104a `U_C_PLAYER_SEARCH` | `SimplePlayerSearchRspMsg`: `info (#1, simple.SimplePlayerInfoMsg)` with `userId (#1)`, `nickName (#2)`, `grades (#14)`, `consortiaID (#8)` | Response to 8257 | `ConsortiaTransferFrame.__getUserInfoHandler` `ConsortiaTransferFrame.as:175`; omit `info` when not found |
| S>C 111 0x006f `U_C_CHANNEL_ALERT` | `ChatChannelMsg.encode_msg (#3)` | Rejections (Assumption) | `BaseManager.__serverBroadcastHandler` `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2171` |

## Rules and formulas

- Rights check: `rights` bit `n-1` of the actor's duty record (`ConsortiaControler.as:551`). Delegated check: actor has right 19 and `n` is in the level 2 `rightsStr` (`ConsortiaControler.as:568`). Server must apply the same two rules (delegated rights are effectively vice chairman only; the chairman passes them through `chairmanID == userId` checks at call sites such as `TopToolsBar.as:1625`, `decompiled/m6/scripts/consortia/view/crossguild/CrossGuildSignFrame.as:214`).
- Promotion ladder (client): 5 -> 3 (skips 4), 4 -> 3, 3 -> 2 (only the chairman can, since actor < target - 1). Demotion ladder: 2 -> 3, 3 -> 4. Nobody can promote to 1 (transfer instead) or demote to 5 (Assumption from the UI; validate server side).
- Promote/demote validation server side: actor has right 19; actor duty < old target duty; actor duty < new duty; new duty in 2..5; actor duty != 4.
- Limits per duty (for example number of vice chairmen) are not visible in the client (Open question).
- Transfer: chairman only (right 1 for the button), target must be a member of the same guild, level >= 12, not self. Effect: old chairman duty 5, target duty 1, `guild.chairman_id` updated, event type 7 "CHANGE" ([logs.md](logs.md)). Robot guild rule `Consortia_Change = 20` (see [membership.md](membership.md)).
- Settings toggle: chairman only; right in {20, 41, 43, 45, 46}; toggles presence in level 2 `rightsStr` (format "41,45" without spaces, parsed with `parseInt` per item, `ConsortiaSettingItem.as:108`).

## Templates

None. Defaults are code constants (`ConsortiaDutyInfo.as:76`). Labels in `index/language.json`: `ConsortiaSettingItem.txt.text0..14`, `ConsortiaSettingFrame.*`, `consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name00..03`, `consortia.view.myConsortia.ConsortiaPlayerMenu.*`, `consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command01..06`.

## Persistent state

```sql
CREATE TABLE guild.duty (
    guild_id        integer   NOT NULL REFERENCES guild.guild(id) ON DELETE CASCADE,
    level           smallint  NOT NULL CHECK (level BETWEEN 1 AND 5),
    name            text      NOT NULL,                       -- duty_name
    rights          bytea     NOT NULL,                       -- bitset, bit n-1 for right n
    delegated_rights smallint[] NOT NULL DEFAULT '{}'         -- rightsStr, only level 2
        CHECK (delegated_rights <@ ARRAY[20,41,43,45,46]::smallint[]),
    PRIMARY KEY (guild_id, level)
);
```

`guild.member.duty_level` ([membership.md](membership.md)) references the duty level; the unique partial index `member_one_chairman` keeps one chairman. `guild.guild.chairman_id` ([profile.md](profile.md)) must match the member with duty 1 (update both in the same transaction).

Alternative: store rights once per server in code and keep only `delegated_rights` per guild; the `rights` bytes are then computed when encoding 4137.

## Backend implementation notes

| Opcode | Handler |
|---|---|
| 8211 | `guild::ranks::handle_list_duties` |
| 5137 | `guild::ranks::handle_change_duty` |
| 9723 | `guild::ranks::handle_toggle_delegated_right` |
| 5131 | `guild::ranks::handle_transfer_leadership` |
| 8257 | `guild::membership::handle_player_search` (shared) |

Validation order for 5137: actor member; target member of the same guild; actor right 19; hierarchy rules; new duty range. One transaction updating `guild.member.duty_level`. Push 50 to every online member.

Validation order for 5131: actor is chairman; target member of same guild; target level >= 12; not self. One transaction: swap duties (old chairman 5, target 1), update `guild.guild.chairman_id`, insert event type 7. Push 164 to all online members, and 50 for both users (Assumption, harmless because the client ignores unchanged duties).

Validation order for 9723: actor is chairman; right in allowed set. Toggle in `guild.duty.delegated_rights` for level 2. Push 4137 to all online members (vice chairmen need the new `rightsStr`).

Encoding helper: `fn rights_bytes(rights: &[u8]) -> Vec<u8>` setting bit `(n-1)&7` of byte `(n-1)>>3`.

## Open questions

1. Maximum number of members per duty (vice chairmen, officers).
2. Does level 5 carry the same rights as level 4, or fewer?
3. Should a transfer push 4137 (rights are per duty, not per member, so not needed unless delegated rights reset)?
4. Is there a server side duty rename (opcode 44 `U_C_CONSORTIA_DUTYEDIT` exists S>C, no C>S request found)?

## Implementation checklist

Client flows:

- [ ] Duty list at login and after join populates rights (staff page buttons appear per rights)
- [ ] Promote normal member to officer, officer to vice (chairman), demote vice and officer
- [ ] Buttons disabled per hierarchy in `ConsortiaPlayerMenu`
- [ ] Settings frame for chairman toggles vice rights 20, 41, 43, 45, 46; read only "Ver privilégios" for others
- [ ] Transfer leadership by nickname; old chairman becomes member, develop tab moves to the new chairman after reopening

Backend:

- [ ] Table `guild.duty` seeded on guild creation with the five default records
- [ ] Rights bitset encoder and server side rights check helper used by every guild handler
- [ ] Handlers 8211, 5137, 9723, 5131 (plus shared 8257)
- [ ] Pushes 4137, 50, 164
- [ ] Event type 7 on transfer
