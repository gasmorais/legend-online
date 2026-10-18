# Amigos e social (friends)

Feature slug `friends`, domain social. Client packages: `friends` (`decompiled/m12/scripts/friends`), `im` (`decompiled/m12/scripts/im`, `decompiled/core_module/scripts/im`), `groupchat` (`decompiled/m12/scripts/groupchat`) and `sns` (core `mvc/module/sns`, `managers/SNSManager`, `yishi/manager/SnsPortManager`). Shared managers: `yishi.manager.FriendManager`, `managers.FriendSocketOutManager`, `managers.IMManager`, `mvc.controler.FriendControler`, `mvc.controler.ConsortiaGroupChatControler`, `yishi.view.community.PlayerMenu`, `yishi.view.frame.ApplyFriendFrame`, `yishi.actions.friend.ApplyFriendAction`. Protobuf packages `friend` and `im`, plus `simple.FriendRelationList`, `simple.RelationPlayerMsg`, `simple.FriendInfoMsg`, `simple.FriendGroupMsg`, `simple.SNSInfoMsg`, `simple.SNSUpdatedMsg`, `simple.FriendSearchConditionReqMsg`, `simple.FriendSearchRspMsg`, `simple.InfoReqMsg`, `chat.ChatStateMsg`, `chat.ChatStateListRspMsg`, `chat.RecentContractsStateReqMsg`.

## What it does for the player

- "Social" window (`FriendsFrame`, toolbar friends button, level 6): own head, level, signature ("Editar a Assinatura da personagem"), friend list in groups: mate (spouse), "Contatos recentes [n]", default group "Amigos" plus up to 3 custom groups ("Clique para adicionar grupo", rename, delete), "Desconhecidos [n]", "Lista negra [n]", and the cross server groups "Amigo inter-servidor", "Desconhecido inter-servidor", "Lista Negra inter-servidor".
- Add friend by name, from menus, from the "Novos Amigos" recommendation list, or by searching with SNS conditions ("Procurar Amigo": sex, birthday, sign, blood type, country, state, city). Friend requests arrive as a popup ("Pedido de adição") and in the toolbar invite list ("Convite de Amigo", "Concordar", "Ignorar", "Concordar Todos", "Ignorar Todos").
- Blacklist ("Lista Negra", max 50), delete friend, move friend to a group, friend login notices ("está online"), intimacy level gains ("O seu nível de amizade com {0} aumentou + {1}"). Max friends `200 + VIP bonus`.
- Private chat (IM) windows (max 3 open), message history ("Registro de mensagem", 8 per page, local), status "Online", "Ausente", "Ocupado", "Não pertube" with auto reply (max 60 chars), auto away after 5 minutes idle, quick actions in the IM window (give roses "Dar Flores", guild invite, propose, add friend, blacklist, team invite).
- SNS profile (signature, birthday, blood type, country/state/city, sign) edited in the hero information panel and used for friend search.
- Guild group chat window ("Minha Guilda", "Histórico", announcement "Anúncio").
- Cross server relations (follow/unfollow, blacklist) and cross server private chat.
- Settings: refuse friend requests.

There is no enemy or revenge list in this client: relation values are 1 friend, 2 blacklist, 3 stranger (one way contact), 4 recent contact (client only).

## Entry points

| Entry | Code | Condition |
|---|---|---|
| Main toolbar "Social" button (`FriendsBtn`) | `MainToolBar.__onFriendsClick` `decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:2315` then friends controller type 1 (`FriendControler.frameClassName` `decompiled/core_module/scripts/mvc/controler/FriendControler.as:53`) | hero level >= 6 (`MainToolCheckBtnOpen.as:56`); when friend requests are buffered (received in battle) the click pops them instead |
| Toolbar recommendation button | `MainToolBar.recommendBtnIsExist` `MainToolBar.as:1098` then friends type 2 (`RecommendFriendFrame`) | level >= 12, recommendations exist, friend count below max |
| Toolbar invite list | friends type 3 (`core.FriendsInviteFrame`, `ToolInviteFriendFrame`) | pushed 4246 requests |
| Player menus (map, chat, rankings, guild, team panel) | `PlayerMenu` `decompiled/core_module/scripts/yishi/view/community/PlayerMenu.as`, `ChatItemMenu` | |
| Hero information panel | `InformationView` `decompiled/m5/scripts/armyII/viewII/information/InformationView.as` | SNS profile |
| Login | `LoginInitDataAccept.__loadFriendListHandler` `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:385` | friend list pushed during login |

## Modules

| Module | File | Scope |
|---|---|---|
| Friend list and relations | [friend-list.md](friend-list.md) | login list 4156, add/remove/blacklist (15003, 15004, 78, 79), requests (84, 4246), groups (15025 to 15028), online pushes (160, 161), intimacy update (165), recent contacts (15038/4256, 15043/4272), refuse setting (8285/4193), limits |
| Search and recommendations | [search-and-recommend.md](search-and-recommend.md) | recommendations 15013/85, condition search 15042/4273, add by exact name |
| SNS profile | [sns-profile.md](sns-profile.md) | 4245 login, update 15033/4239, reset 15036, `sns_temp.xml`, SNS port 4388 |
| Instant messages | [instant-messages.md](instant-messages.md) | private chat 15023/4231/4236, chat state 15029/4232, IM window actions, history |
| Cross server relations | [cross-server-relations.md](cross-server-relations.md) | relation graph 9606/347, global messages 348 |
| Guild group chat | [guild-group-chat.md](guild-group-chat.md) | group chat window over the guild channel |

## Dependencies

- [../chat/README.md](../chat/README.md): channel 3 notices, guild channel 5, outyard and cross chat on channel 109.
- [../team/README.md](../team/README.md): team invite and join requests from friend menus; join requests frame lives in the friends controller (type 7).
- [../marriage/README.md](../marriage/README.md): mate group (-2), propose from IM and menus, divorce moves the ex mate to the default group.
- [../guild/README.md](../guild/README.md): guild invite from IM, guild member list, group chat placard (8544).
- [../mail/README.md](../mail/README.md): friend list feeds the mail recipient combo.
- [../inventory/README.md](../inventory/README.md): roses 2170001 "1 Rosa(s)" and 2170005 "9999 Rosa(s)" are given with item use 5006 (`ItemUseMsg.friend_id`), charm feeds [../rankings/README.md](../rankings/README.md).
- [../hero/README.md](../hero/README.md): player info frames, head ids, VIP friend privilege.
- [../account/README.md](../account/README.md): login push order (4156 before 4245), `PlayerMsg` refuse flags.

## Suggested implementation order

1. [friend-list.md](friend-list.md): tables, login list, add/remove/blacklist, online pushes.
2. [instant-messages.md](instant-messages.md): private chat and states.
3. [search-and-recommend.md](search-and-recommend.md).
4. [sns-profile.md](sns-profile.md).
5. [guild-group-chat.md](guild-group-chat.md) (needs the guild channel).
6. [cross-server-relations.md](cross-server-relations.md) once a cross server service exists.
