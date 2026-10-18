# Information screens and player lookup (Informações, Ver Informações)

Path aliases:

| Alias | File |
|---|---|
| IV | `decompiled/m5/scripts/armyII/viewII/information/InformationView.as` |
| PIF | `decompiled/m5/scripts/playerinfo/PlayerInfoFrameII.as` |
| PIM | `decompiled/core_module/scripts/yishi/manager/PlayerInfoManager.as` |
| PM | `decompiled/core_module/scripts/yishi/manager/PlayerManager.as` |
| SSM | `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as` |
| RV | `decompiled/core_module/scripts/yishi/view/community/RenameView.as` |
| SNS | `decompiled/core_module/scripts/managers/SNSManager.as` |
| CHF | `decompiled/core_module/scripts/yishi/view/frame/ChangeHeadIconFrame.as` |

## 1. Overview

- Own information tab ("Informações", hero level >= 10): name with "Modificar" (rename with "Carta de Renomeamento" 208018), portrait "Modificar Retrato", guild, honor progress, vocation help, SNS profile (sign, sex, birthday, horoscope, blood type, country/province/city) with save and reset, and an item exchange box (mystery shop, owned by [../shops/README.md](../shops/README.md)).
- Player lookup ("Ver Informações"): a read-only copy of another player's hero frame with equipment, attributes, mount, Einherjar, Guardian, titan, goddess, monster, Avenger, Theseus, divine weapon, tattoos, battle guard, magic cards and stars, all from one detail response.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `armyII.viewII.information.InformationView` (IV) | "Informações" (`armyII.ArmyFrameII.title04`) | Own profile and identity | `ArmyFrameII` tab | `thane`, `snsInfo`, honor tips "Para subir para {0} (nível {1}) ainda precisa de {2} de Honra\nHonras conquistadas hoje: {3}/{4}" |
| `armyII.viewII.information.BirthSelectComBox`, `AreaSelectComBox` | "Selecione" | Birthday and area pickers | IV | SNS templates (`snsManager.loadSnsTemplate`) |
| `armyII.viewII.information.ItemExchangeView`, `GoodsExchangeItem` | | Mystery shop refresh and links to shop 888 | IV | shop data |
| `yishi.view.community.RenameView` (RV) | "Nome do Personagem deve conter de 4~12 caracteres", "Renomeamento tomará efeito em 24 horas" | Rename input | "Modificar" with a rename card (IV:291-309) | |
| `yishi.view.frame.ChangeHeadIconFrame` (CHF) | | Portrait picker | "Modificar Retrato" (IV:286-289, `ArmyControler.openChangeHeadFrame`) | head ids |
| `playerinfo.PlayerInfoFrameII` (PIF) | "Ver Informações" (`yishi.view.PlayerMenu.info`) | Inspect any player | `PlayerInfoManager.show(data, op)` (PIM:39-45) from player menus | `DetailRspMsg`, `RelationPlayerMsg` |
| `playerinfo.view.EquipInfoView`, `EquipCheckList`, `MountInfoView`, `DragonTalkerEquipInfoView`, `InfoView` | "Montaria" (mount) | Tabs of PIF | PIF | |

## 3. Routes (client to server)

### R1. Rename the hero
- UI: "Modificar" (IV:291-309): needs item 208018 in the bag; without it, quick buy (hero level >= 10, else "Nível insuficiente. Nv. {0}, incapaz de comprar a Carta de Renomeamento.").
- Client checks (RV:147-187): trimmed name not empty ("Nome do Personagem em branco!"), length 4..12 ("muito curto!" / "muito longo!"), no forbidden words or characters ("Nome do Personagem contêm caracteres inválidos!").
- HTTP pre-check: `GET {REQUEST_PATH}nicknamecheck?nickname=<name>&rnd=<random>` → XML with attribute `value="true"` when free (RV:182-216; `routes/routes.md` row `nicknamecheck`).
- Route: send 8345 (0x2099) `C_PLAYER_RENAME_REQ` (SSM:464-472), `PlayerRenameReqMsg` (player): `nick_name` (#1, STRING), `type` (#2, INT32) 1 = with rename card, 2 = free rename (tutorial/other entry), `pos` (#3, INT32) bag position of the card (type 1).
- Response: 4271 (S1); then 3 `PlayerMsg.nick_name` and 113 `nick_name` *(assumption: the new name applies after 24 h per the warning text, but the client updates on push)*.

### R2. Change portrait
- UI: CHF confirm (CHF:163-176) when the selected head differs.
- Route: send 15033 (0x3ab9) `CH_SNS_UPDATE`, `SNSInfoMsg` (simple) with only `head_id` (#15, INT32).
- Response: 4239 (S2) and 113 `head_id` (#46).

### R3. Save SNS profile
- UI: save button (IV:396-412); the sign field is also auto-saved (`sendAutoSaveInfo`, only `sign_desc`).
- Route: send 15033 `CH_SNS_UPDATE` (SNS:210-241), `SNSInfoMsg`: `id` (#1), `user_id` (#2, INT32), `nickname` (#3, STRING), `sign_desc` (#4, STRING, filtered), `sex` (#5, INT32), `birthday_type` (#6, INT32), `birth_year` (#7), `birth_month` (#8), `birth_day` (#9), `star_id` (#10, horoscope), `blood_type` (#11), `country` (#12), `province` (#13), `city` (#14), `head_id` (#15), `job` (#16), all INT32 unless noted.
- Response: 4239; the view shows "Salvo com sucesso" (IV:332-336).

### R4. Reset SNS profile
- UI: reset button, confirm "Essa ação irá redefinir todas suas informações, continuar?" (IV:414-430).
- Route: send 15036 (0x3abc) `CH_SNSINFO_RESET`, no body (SNS:230-234).
- Response: 4239 with defaults.

### R5. Look up another player
- UI: any "Ver Informações" entry → PIF initialization (PIF:255-293).
- Routes (both sent):
  - 15038 (0x3abe) `CH_SIMPLEUSER_INFO`, `InfoReqMsg` (simple): `other_id` (#1, INT32), `from` (#2, INT32) = 1 (PM:1654-1661). Response 4256 (S3).
  - 8199 (0x2007) `C_BAG_EQUIPLOOK`, `DetailReqMsg` (simple): `other_id` (#3, INT32), `item_info` (#5, BOOL), `army_info` (#6, BOOL), `hero_info` (#7, BOOL), `pawn_info` (#8, BOOL); the frame sends `(id, 1, true, true, true)` so `item_info` = true and the others true (PIM:47-57). `user_id` (#1), `server_name` (#2), `other_name` (#4) are only set for the cross-server variant 25097 `CR_WARFIELD_USER_INFO` (PIM:67-76). Response 4125 (S4).
- Sub-requests from PIF buttons (owned by other features): Einherjar data, Guardian data (`sendRequestPetData`, `sendRequistChildData`), mount (`MountsManager.mountOperateSend(5, 0, 0, userId)`).

### R6. Simple info (other callers)
- 8200 (0x2008) `C_SIMPLEUSER_INFO`, `InfoReqMsg` (`PM.sendRequestSimpleInfo`, PM:1645-1652; `PIM.sendRequestSimpleInfo`, PIM:59-65) → 4128 (S5). Used by friend and chat tooltips.

## 4. Server messages (server to client)

### S1. 4271 (0x10af) `U_C_PLAYER_RENAME_RSP`
`PlayerRenameRspMsg`: `result` (#1, BOOL). Receiver `RV.__playerRenameRspHandler` (RV:231-245): true closes the view, false re-enables the button.

### S2. 4239 (0x108f) `U_CH_SNS_UPDATED`
`SNSInfoMsg` (fields above). Receiver `SNSManager.__updateSnsInfoHandler` (SNS:57-60); owned by [../friends/README.md](../friends/README.md).

### S3. 4256 (0x10a0) `U_CH_SIMPLEUSER_INFO`
`RelationPlayerMsg` (simple): `relation` (#1, INT32), `friend_rp` (#2, INT32), `friend_grade` (#3, INT32), `group_id` (#4, INT32), `player` (#5, `simple.SimplePlayerInfoMsg`), `sns_info` (#6, `SNSInfoMsg`), `from` (#7, INT32) echo, `is_vip` (#8, INT32), `trans_grade` (#9, INT32), `changeBranch` (#10, INT32). Receiver `PM.__getSimpleAndSnsInfoHandler` (PM:1577-1600) → event `REQUEST_SIMPLEANDSNS_INFO` (PIF:1248-1268); `from` 2/3 update the friend list.

`simple.SimplePlayerInfoMsg` (field numbers from `decompiled/core_module/scripts/com/road/yishi/proto/simple/SimplePlayerInfoMsg.as`; `protocol/proto.json` holds a different message with the same name from package `allianceregression`): `userId` (#1), `nickName` (#2, STRING), `isExist` (#3), `sexs` (#4), `pics` (#5), `camp` (#6), `state` (#7), `consortiaID` (#8), `strategy` (#9, INT64), `consortiaName` (#10, STRING), `consortiaOffer` (#11), `claimId` (#12), `claimName` (#13, STRING), `grades` (#14), `gp` (#15, INT64), `repute` (#16), `logOutTime` (#17, STRING), `dutyId` (#18), `parameter1` (#19), `gpOrder` (#20), `fightingCapacity` (#21), `matchWin` (#22), `matchFailed` (#23), `right` (#24), `challenge_rank` (#25), `job` (#26), `consortiaTotalOffer` (#27), `storeGrade` (#28), `storeGp` (#29), `is_teamPlayer` (#30, BOOL), `role` (#31), `is_vip` (#32, BOOL), `vip_type` (#33), `is_inwar` (#34), `head_id` (#35), `seniorStoreGrade` (#36), `cross_guildTeamId` (#37), `trans_grade` (#38), `is_hide` (#39, BOOL), `cur_fightPetTempId` (#40), `is_back_player` (#41, BOOL), `changeBranch` (#42), `uuid` (#43, STRING); INT32 unless noted.

### S4. 4125 (0x101d) `U_C_BAG_EQUIPLOOK`
- `DetailRspMsg` (simple): `other_id` (#1, INT32), `server_name` (#2, STRING), `item` (#3, `SimpleItemInfoMsg`, repeated) equipped items, `army` (#4, `SimpleArmyMsg`), `star` (#5, `SimpleStarInfoMsg`, repeated), `starAdd` (#6, `SimpleStarAdditionMsg`, repeated), `hide_fashion` (#7, BOOL), `watch` (#8, `SimpleWatchMsg`, repeated) battle guard, `cardInfos` (#9, `SimpleMagicCardInfoMsg`, repeated), `grade` (#10, INT32), `fightCapacity` (#11, INT32), `mount` (#12, `MountInfoMsg`), `fightPet` (#13, `PlayerPetMsg`), `fightChild` (#14, `ChildrenInfoMsg`), `holeInfo` (#15, `TattooHoleMsg`, repeated), `titanInfo` (#16, `TitanDataMsg`), `tattooEnhanceInfo` (#17, `TattooEnhanceListMsg`), `petHallowInfo` (#18, `PetHallowInfoMsg`, repeated), `artifactInfo` (#19, `ArtifactInfoMsg`), `dragonTalkerInfo` (#20, `DragonTalkerInfoMsg`), `talismanInfo` (#21, `TalismanMsg`, repeated), `goddessInfo` (#22, `GoddessInfoMsg`), `monsterInfo` (#23, `MonsterMsg`), `avengerInfo` (#24, `AvengerMsg`), `theseusInfo` (#25, `TheseusUserMsg`), `rageInfo` (#26, `TheseusRageListMsg`), `warSoulInfo` (#27, `WarSoulListMsg`).
- `SimpleArmyMsg` hero-relevant fields: `simple_hero` (#22, `SimpleHeroMsg`), `armyPawn` (#19, `SimpleArmyPawnMsg`, repeated), `consortia_id` (#20), `consortia_name` (#21), `appellid` (#27), `fateTotalGp` (#28), `fateGrades` (#29, STRING), `dragon_grade` (#30, STRING), `transfer_grade` (#31), `changeBranch` (#33), `equipment_refining_grade` (#34).
- `SimpleHeroMsg` (80 fields): same attribute blocks as `SimpleHeroInfoMsg` plus `total_geste` (#48), `total_charm` (#49), `fashion_add_power` (#61), `fashion_add_armor` (#62), `fashion_add_intellect` (#63), `fashion_add_life` (#64), `ring_grade` (#67), `nick_nameB` (#68), `fashion_wing` (#71), `fashion_hat` (#72), `fashion_cloth` (#73), `fashion_arm` (#74), `fashion_gp` (#75), `fashion_grades` (#76); full list in `protocol/proto.json`.
- Receiver: `PIF.__receiveEquipHandler` (PIF:598-1230), ignores responses whose `simple_hero.player_id` differs from the frame's player (PIF:656-662).
- Sub-objects are documented by their owning features.

### S5. 4128 (0x1020) `U_C_SIMPLEUSER_INFO`
`InfoRspMsg` (simple): `info` (#1, `simple.SimplePlayerInfoMsg`), `from` (#2, INT32). Receiver `PM.__getSimpleInfoHandler` (PM:1306-1340).

## 5. Rules and formulas

- Information tab unlock: hero level 10 (`decompiled/m5/scripts/armyII/ArmyFrameII.as:319`, `:352-355`).
- Rename: 4..12 characters (`StringHelper.checkStringLength`), filtered words, unique name (HTTP check), consumes one 208018 (type 1); applies within 24 h per UI text.
- Honor progress uses `thane.nextHonerTemp` (`Data` threshold) and daily caps `honerDayMax`, potions `honerDayMedicinal` (IV:440-458), owned by [../rankings/README.md](../rankings/README.md) *(assumption: honor ranks live there)*.
- Lookup privacy: none in the client; any player can be inspected.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `ItemTempInfos.xml` | 208018 rename card | consumption |
| SNS templates (loaded by `SNSManager.loadSnsTemplate`) | birthday/horoscope/area lists | combo boxes ([../friends/README.md](../friends/README.md)) |

## 7. Persistent state

```sql
CREATE TABLE hero.name_history (
    history_id   BIGSERIAL PRIMARY KEY,
    player_id    BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    old_name     TEXT   NOT NULL,
    new_name     TEXT   NOT NULL,
    rename_type  SMALLINT NOT NULL CHECK (rename_type IN (1, 2)),
    requested_at TIMESTAMPTZ NOT NULL DEFAULT now(),
    applies_at   TIMESTAMPTZ NOT NULL
);
CREATE UNIQUE INDEX hero_name_unique ON hero.heroes (lower(nick_name));
```

Portrait is `hero.heroes.head_id`; SNS profile fields belong to the friends schema.

## 8. Backend implementation notes

- HTTP `GET /nicknamecheck`: `<result value="true|false"/>` *(assumption on the XML root name; the client reads only `@value`)*.
- `hero::info_screens::handle_rename` (8345): validate length and words, uniqueness (case-insensitive), card at `pos` (type 1); transaction: consume card, insert history, update name; reply 4271 `{result}`; push 3 and 113; notify guild/friends caches.
- `hero::info_screens::handle_lookup_detail` (8199) and cross 25097: build `DetailRspMsg` by calling each owning feature's "public view" builder; reply 4125.
- `hero::info_screens::handle_lookup_simple` (15038 → 4256, 8200 → 4128).
- SNS routes 15033/15036 are implemented by `friends::sns::*`; the hero feature only reacts to `head_id`.

## 9. Open questions and assumptions

- Assumption: rename type 2 is the free rename (tutorial or forced rename).
- Open: when the 24 h delay applies (server) versus immediate push.
- Open: which `from` values exist besides 1 (lookup), 2 and 3 (friend list).

## 10. Implementation checklist

- [ ] Screens: InformationView, RenameView, ChangeHeadIconFrame, PlayerInfoFrameII tabs
- [ ] HTTP `nicknamecheck`
- [ ] Route 8345 rename
- [ ] Route 15033 portrait/profile (with friends feature)
- [ ] Route 15036 reset profile
- [ ] Route 15038 and 8199 (and 25097) lookup
- [ ] Route 8200 simple info
- [ ] Server messages 4271, 4239, 4256, 4125, 4128
- [ ] Table `hero.name_history`, unique name index
- [ ] Test: lookup of an offline player returns a complete `DetailRspMsg`
