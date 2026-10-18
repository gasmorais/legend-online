# SNS profile

Feature `friends`, module `sns-profile`. The player's social profile: signature, sex, birthday, sign, blood type, country, state and city, head id; and the SNS port hook.

Conventions as in [friend-list.md](friend-list.md). `simple.SNSInfoMsg` fields (from `proto.json` and `decompiled/core_module/scripts/com/road/yishi/proto/simple/SNSInfoMsg.as`): `id (#1, INT32)`, `user_id (#2, INT32)`, `nickname (#3, STRING)`, `sign_desc (#4, STRING)` signature, `sex (#5, INT32)`, `birthday_type (#6, INT32)`, `birth_year (#7, INT32)`, `birth_month (#8, INT32)`, `birth_day (#9, INT32)`, `star_id (#10, INT32)` sign (horoscope), `blood_type (#11, INT32)`, `country (#12, INT32)`, `province (#13, INT32)`, `city (#14, INT32)`, `head_id (#15, INT32)`, `job (#16, INT32)`.

## 1. Overview

The profile is pushed at login (4245) and edited in two places: the hero information panel (all fields, save and reset) and the friends frame signature line (signature only). Both send 15033 with `SNSInfoMsg`; the server answers 4239 (`SNSUpdatedMsg`). Reset sends 15036 and the client clears its fields locally. Selection lists (countries, states, cities, signs) come from `{TPL}sns_temp.xml`. The profile is embedded in friend lists, search results, recent contacts and ranking snapshots. The head image is changed through the army change head frame (hero feature) and stored in `head_id`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.information.InformationView` `decompiled/m5/scripts/armyII/viewII/information/InformationView.as` | buttons "Modificar Retrato" (`armyII.viewII.information.InformationView.changeHead`), "Modificar" (`changeName`); tip "Salvo com sucesso"; reset confirm "Essa ação irá redefinir todas suas informações, continuar?" | Edit birthday (`_birthSelectComBox`), area (`_areaSelectComBox`), signature (auto saved), save (`__onSaveClick` `:396`), reset (`__onResetClick` `:414`) | hero panel information tab (hero feature) | `thane.snsInfo` |
| `FriendsFrame` signature field | "Editar a Assinatura da personagem" | Edit the signature only, saved on focus out (`decompiled/m12/scripts/friends/view/FriendsFrame.as:347`) | friends frame | |
| `ConditionFindFriendView` | see [search-and-recommend.md](search-and-recommend.md) | uses the same lists | | |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Request | Response |
|---|---|---|---|---|---|---|
| P1 | Save in the information panel | `InformationView.__onSaveClick` `InformationView.as:396` then `SNSManager.sendUpdateSnsInfo` `decompiled/core_module/scripts/managers/SNSManager.as:210` | signature filtered with `FilterWordManager.filterWrod` | C>S 15033 0x3ab9 `CH_SNS_UPDATE` | `SNSInfoMsg`: `user_id`, `nickname`, `sign_desc`, `sex`, `birthday_type`, `birth_year`, `birth_month`, `birth_day`, `star_id`, `blood_type`, `country`, `province`, `city` (unchanged fields keep the current values) | 4239 |
| P2 | Signature edit (information panel `saveSign` `:409`, friends frame `:354`) | `SNSManager.sendAutoSaveInfo` `SNSManager.as:236` | filter | C>S 15033 | `SNSInfoMsg` with only `sign_desc` | 4239 |
| P3 | Reset | `InformationView.resetResponseHandler` (after confirmation) then `SNSManager.sendResetSnsInfo` `SNSManager.as:230` | confirmation | C>S 15036 0x3abc `CH_SNSINFO_RESET` | no body | Assumption: none (client resets locally, `BaseSnsInfo.reset` `decompiled/core_module/scripts/mvc/module/sns/BaseSnsInfo.as:99` clears sex, birthday, sign, blood type, area; signature and head kept) |
| P4 | Selection lists | `SNSManager.loadSnsTemplate` `SNSManager.as:138` | loaded once | HTTP GET `{TPL}sns_temp.xml` (`PathManager.snsTempPath` `decompiled/core_module/scripts/yishi/manager/PathManager.as:525`), loader type 5 (zlib) | | XML, see Templates |

## 4. Server messages (server to client)

| Route | Message | Client receiver | When | Reaction |
|---|---|---|---|---|
| S>C 4245 0x1095 `U_CH_SNS_REQ` | `simple.SNSInfoMsg` (all fields, `has*` checked) | `LoginInitDataAccept.__snsReqHandler` `decompiled/core_module/scripts/yishi/lunch/LoginInitDataAccept.as:239` | login sequence (account feature ordering) | fills `thane.snsInfo` |
| S>C 4239 0x108f `U_CH_SNS_UPDATED` | `simple.SNSUpdatedMsg`: `sns_info (#1, SNSInfoMsg)` saved values, `result (#2, INT32)` 1 = success | `SNSManager.__updateSnsInfoHandler` `SNSManager.as:60` | response to 15033 | success: copies present fields into `thane.snsInfo`, dispatches `SNSINFO_UPDATE` (tip "Salvo com sucesso" in the panel); else tip "Falha ao salvar" |
| S>C 4388 0x1124 `U_C_SNSINFO` | `SnsRspMsg` (external SNS share port) | `SnsPortManager._snsPortHandler` `decompiled/core_module/scripts/yishi/manager/SnsPortManager.as:59` | only when `VersionSwitch.SNS_PORT` and `SNSPATH` are set; the handler does nothing else in this client | Assumption: never send |

## 5. Rules and formulas

- Signature: forbidden word filter; Assumption max 30 characters.
- `birthday_type` (0 or a calendar type, Assumption: 1 solar, 2 lunar) is sent as is.
- Province list depends on country (`ProvinceXml/Province@CountryId`), city list on province (`CityXml/City@ProvinceId`).

## 6. Templates

`{TPL}sns_temp.xml` (`SNSManager.__loadSnsTempCompleteHandler` `SNSManager.as:147`):

| Element | Attributes |
|---|---|
| `CountryXml/Country` | `Id`, `CountryName` |
| `ProvinceXml/Province` | `Id`, `ProvinceName`, `CountryId` |
| `CityXml/City` | `Id`, `CityName`, `ProvinceId` |
| `StarXml/Star` | `Id`, `StarName` |

The file is not present under `raw/xml/`; it must be authored or fetched (gap). Blood types are client constants (no template).

## 7. Persistent state

```sql
CREATE TABLE friends.sns_profile (
    player_id      integer     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    signature      varchar(64) NOT NULL DEFAULT '',
    sex            smallint    NOT NULL DEFAULT 0,
    birthday_type  smallint    NOT NULL DEFAULT 0,
    birth_year     smallint    NOT NULL DEFAULT 0,
    birth_month    smallint    NOT NULL DEFAULT 0 CHECK (birth_month BETWEEN 0 AND 12),
    birth_day      smallint    NOT NULL DEFAULT 0 CHECK (birth_day BETWEEN 0 AND 31),
    star_id        smallint    NOT NULL DEFAULT 0,
    blood_type     smallint    NOT NULL DEFAULT 0,
    country        integer     NOT NULL DEFAULT 0,
    province       integer     NOT NULL DEFAULT 0,
    city           integer     NOT NULL DEFAULT 0,
    head_id        integer     NOT NULL DEFAULT 0,
    updated_at     timestamptz NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

| Opcode | Handler |
|---|---|
| 15033 | `friends::sns_profile::handle_update` |
| 15036 | `friends::sns_profile::handle_reset` |

- Update: apply only fields present in the message (signature only for auto save); filter the signature; upsert; respond 4239 with `result` 1 and the stored values.
- Reset: clear the same fields the client clears; no response.
- Login: push 4245 after 4156 (see [friend-list.md](friend-list.md)).
- Provide `friends::sns_profile::to_msg(player_id)` for friend lists, search, recent contacts and ranking snapshots (`PlayerSNSInfo` element, see [../rankings/ranking-generation.md](../rankings/ranking-generation.md)).

## 9. Open questions and assumptions

1. `sns_temp.xml` content is missing from the repository.
2. Signature length limit and `birthday_type` values.
3. SNS port (4388) is disabled in this client.

## 10. Implementation checklist

- [ ] Table `friends.sns_profile`
- [ ] Login push 4245
- [ ] Update 15033 (full and signature only) and 4239 result
- [ ] Reset 15036
- [ ] Serve `{TPL}sns_temp.xml` (author the data)
- [ ] Test: search finds a player by the saved fields
