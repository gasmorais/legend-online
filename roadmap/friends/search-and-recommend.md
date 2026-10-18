# Friend search and recommendations

Feature `friends`, module `search-and-recommend`. "Novos Amigos" recommendations, "Procurar Amigo" by SNS conditions, and adding by exact nickname.

Conventions as in [friend-list.md](friend-list.md).

## 1. Overview

After login (and after each level up) the client asks for recommended players (15013); the server answers with two short lists (girls and boys) in 85. The toolbar shows a "new friends" button when the player is level 12 or more, below the friend limit and there are recommendations. The search frame offers an exact nickname add (15003 directly) and a condition search over SNS profiles (15042, 10 results per page, 4273).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `friends.RecommendFriendFrame` `decompiled/m12/scripts/friends/view/RecommendFriendFrame.as` | "Novos Amigos"; columns "Líder", "Nível", "Sexo", "Poder", "Ação"; add all | Recommended players, add one (`RecommendFriendItem` `decompiled/m12/scripts/friends/view/RecommendFriendItem.as:131`, "Adicionar") or all (`__bottomAllAddHandler` `:126`) | toolbar recommend button (friends type 2) | `FriendManager.recommendList` |
| `friends.FindFriendFrame` `decompiled/m12/scripts/friends/findfriend/FindFriendFrame.as` | "Procurar Amigo" | Container of exact and condition views | `FriendsFrame` "Procurar" (`FriendControler.openFindFriendFrame`) | |
| `ExactFindFriendView` `decompiled/m12/scripts/friends/findfriend/ExactFindFriendView.as` | "Insira apelido", "Clique no jogador na janela de conversa para obter apelido", "Confirmar" | Add by exact nickname (`__onAddFriendClick` `:110`, anti double click "Clique excessivo, tente novamente") | find frame | |
| `ConditionFindFriendView` `decompiled/m12/scripts/friends/findfriend/ConditionFindFriendView.as` | "Sexo", "Aniversário", "Signo", "Tipo Sanguíneo", "País", "Estado", "Cidade", "S/ Restrição"; "Insira pelo menos uma condição de procura" | Choose conditions (`__onFindClick` `:286`), loads `sns_temp.xml` for country/state/city/sign lists (`:120`) | find frame | `SNSModel` lists |
| `FindResultFrame` + `FindResultItem` `decompiled/m12/scripts/friends/findfriend/FindResultFrame.as:52`, `FindResultItem.as` | "Abaixo são os amigos encontrados", "Não há jogadores correspondente às condições!", "Página {0}", "Anterior", "Próxima" | Paged results, view info, add (`FindResultItem.as:129`) | condition search | `BaseSnsInfo` list |
| `FriendAutoSearchBox` `decompiled/m12/scripts/friends/view/FriendAutoSearchBox.as` | "Nenhum encontrado" | local name filter over the loaded friend list | friends frame | no server traffic |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| S1 | Login and level up | `FriendManager.setup` `decompiled/core_module/scripts/yishi/manager/FriendManager.as:152`, `__levelUpgradeHandler` `:1118` then `sendRecommendFriendRequest` `:874` then `FriendSocketOutManager.sendRecommendFriend` `decompiled/core_module/scripts/managers/FriendSocketOutManager.as:58` | none | C>S 15013 0x3aa5 `U_CH_RECOMMENDLIST` | no body | 85 |
| S2 | Add one / add all | `RecommendFriendItem` `:131`, `RecommendFriendFrame.__bottomAllAddHandler` | `FriendManager.sendAddFriendRequest` checks (level, limits) per name | C>S 15003 per player (relation 1) | see [friend-list.md](friend-list.md) F1 | 78 per player |
| S3 | Exact add | `ExactFindFriendView.__onAddFriendClick` `:110` then `FriendControler.sendAddFriendRequest` | nickname not empty, click throttle | C>S 15003 | relation 1 | 78 (failure text in `add_msg`) |
| S4 | Condition search and paging | `ConditionFindFriendView.__onFindClick` `:286` opens `FindResultFrame`, which calls `FriendSocketOutManager.sendFindFriend` `FriendSocketOutManager.as:106` (`FindResultFrame.as:182`) | at least one condition | C>S 15042 0x3ac2 `CH_FRIEND_SEARCH` | `simple.FriendSearchConditionReqMsg`: `page_index (#1, INT32)` 1 based; `sex (#2, INT32)`; `birth_month (#3, INT32)`; `birth_day (#4, INT32)`; `star_id (#5, INT32)` sign; `blood_type (#6, INT32)`; `country (#7, INT32)`; `province (#8, INT32)`; `city (#9, INT32)`; 0 means no restriction (Assumption) | 4273 |
| S5 | Add from a search result | `FindResultItem` `:129` | not already in the list ("Jogador já está na lista") | C>S 15003 | relation 1 | 78 |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 85 0x0055 `U_CH_RECOMMENDLIST` | `friend.RecommendListMsg`: `girlList (#1, FriendPlayer, repeated)`, `boyList (#2, FriendPlayer, repeated)`; `FriendPlayer`: `player_id (#1, INT32)`, `nick_name (#2, STRING)`, `level (#3, INT32)`, `sex (#4, INT32)`, `attack (#5, INT32)` power, `map_name (#6, STRING)`, `trans_grade (#7, INT32)`, `job (#8, INT32)`, `changeBranch (#9, INT32)` | `FriendManager._recommendFriend` `FriendManager.as:794` | response to 15013 | replaces `recommendList` (girls then boys); after a level up refreshes the toolbar button |
| S>C 4273 0x10b1 `U_CH_FRIEND_SEARCH` | `simple.FriendSearchRspMsg`: `total_rows (#1, INT32)`, `snsInfo (#2, simple.SNSInfoMsg, repeated)` (`user_id`, `nickname`, `sign_desc`, `sex`, `birthday_type`, `birth_year`, `birth_month`, `birth_day`, `star_id`, `blood_type`, `country`, `province`, `city`, `head_id`) | `FriendManager.__findFriendHandler` `:248` | response to 15042 | pages = `ceil(total_rows / 10)`; dispatches `GET_FIND_RESULTS` |
| S>C 78 | see [friend-list.md](friend-list.md) | | | removes the added player from the recommendation list (`removeFromRecmmondList` `:672`) |

## 5. Rules and formulas

- Recommendation button: level >= 12, `countFriend < maxFriendCount`, list not empty (`decompiled/core_module/scripts/ui/maintoolbar/MainToolBar.as:1098`).
- Recommendation selection (Assumption, not in client): online players of similar level (±5), not already related, not blacklisted either way, not refusing friend requests, up to 5 girls and 5 boys.
- Condition search page size 10 (`FriendManager.as:253`); only players who filled the matching SNS fields are found; exclude self and players refusing requests (Assumption).

## 6. Templates

| File | Use |
|---|---|
| `{TPL}sns_temp.xml` (`PathManager.snsTempPath`) | country, province, city, sign lists used by the condition view; see [sns-profile.md](sns-profile.md) |

## 7. Persistent state

No new table: reads `friends.relation` ([friend-list.md](friend-list.md)), `friends.sns_profile` ([sns-profile.md](sns-profile.md)) and player data.

```sql
CREATE INDEX IF NOT EXISTS sns_profile_search_idx ON friends.sns_profile (sex, birth_month, star_id, blood_type, country, province, city);
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 15013 | `friends::search::handle_recommend` |
| 15042 | `friends::search::handle_condition_search` |

- Recommendation: query online players from the session registry, filter with relation and setting tables, randomize, respond 85.
- Condition search: build the query from non zero fields, `LIMIT 10 OFFSET (page_index-1)*10`, count total rows, respond 4273.

## 9. Open questions and assumptions

1. Recommendation criteria and list sizes are not visible in the client.
2. Whether 0 means "any" for every condition field (Assumption yes, the UI default "S/ Restrição").

## 10. Implementation checklist

- [ ] 15013 / 85 recommendations at login and level up
- [ ] Toolbar recommendation button logic
- [ ] Add one and add all from recommendations
- [ ] Exact nickname add
- [ ] Condition search 15042 / 4273 with paging
- [ ] `sns_temp.xml` served for the selectors
