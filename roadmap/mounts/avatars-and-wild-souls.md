# Avatars and wild souls ("Feras", "Alma da Fera")

Scope: the collection of mount appearances a player owns (client name "wild soul", screen "Feras"), how each is unlocked (mount grade, card item, unlock item or diamonds, VIP, king item), expiry of temporary avatars, switching the ridden appearance, the "Ponto Bestial" soul score, the purchasable flying ability, and the mount card items (use and decomposition into "Essência da Fera"). Stars are in [star-promotion.md](star-promotion.md); king mount training in [mount-king.md](mount-king.md).

Path aliases (all under `decompiled/`):

| Alias | File |
|---|---|
| MM | `core_module/scripts/managers/MountsManager.as` |
| WSC | `core_module/scripts/mvc/module/mounts/WildSoulCollection.as` |
| WSI | `core_module/scripts/mvc/module/mounts/WildSoulInfo.as` |
| MT | `core_module/scripts/yishi/datas/templates/MountTemplate.as` |
| MF | `m14/scripts/mounts/MountsFrame.as` |
| WSF | `m14/scripts/mounts/WildSoulFrame.as` |
| WSIT | `m14/scripts/mounts/WildSoulItem.as` |
| MTIP | `m16/scripts/yishi/view/tips/MountTip.as` |
| BM | `core_module/scripts/yishi/manager/BaseManager.as` |
| PBCM | `core_module/scripts/cell/mediator/playerbag/PlayerBagCellClickMediator.as` |
| GIM | `core_module/scripts/cell/view/GoodsItemMenu.as` |

## 1. Overview

- The server keeps one row per owned appearance (`AvatarInfoMsg`): template, activation date, expiry date (year 2000 = permanent), star level, blessing, purchased flight.
- Presence in the list is what the client treats as "unlocked" (`WSC.isLightTemplate`, `WSC:529-532`). The selected appearance (`MountInfoMsg.mount_tempId`) must be one of them.
- Unlock paths by `MountType` (`core_module/scripts/mvc/module/mounts/MountType.as:6-14`, template counts from `raw/xml/tempinfos/MountTempInfos.xml`):

| MountType | Meaning | Count | Unlock |
|---|---|---|---|
| 0 NORMAL | grade horses | 8 | automatic when mount grade >= `Property2` (see [mount-core.md](mount-core.md)) |
| 1 SPECIAL | regular special mounts | 713 | op 4 with `NeedItemId` in bag or `Property1` diamonds; or using the mount card (SonType 218) |
| 2 HIDE | hidden until owned | 6 | as type 1; shown in the special lists only once owned (`WSC:318-350`) |
| 3 VIP | VIP exclusive (1131 "Cavalo Imperial Azul") | 1 | granted while VIP is active, removed on expiry (4610) |
| 4 MOUNT_KING | king mounts 9001..9004 | 4 | op 4 consuming config `mount_king_active_item` 2131500 "Despertamento da Fera"; listed only at lord grade >= 70 (`WSC:489-499`) |
| 5 (no client constant) | 1132 "Cavalo Imperial Vermelho" | 1 | only via its card 2180046 (click does nothing, `WSF:505-604`) |

- Tabs ("areas", `core_module/scripts/mvc/module/mounts/MountAreaType.as:6-16`): 0 normal, 1 magic, 2 livestock, 3 beast, 4 technology (bitmap buttons, no text). The template `Area` decides the tab.
- Every owned avatar adds its base attributes, star bonus and `ExpandLevel` to the mount totals (tooltip `mounts.WildsoulItem.tips01` "Força +{0}|Inteligência +{0}|Físico +{0}|Proteção +{0}|Nível máximo de atributos +{0}|Movimentação +{0}%|Pontos +{0}", `MTIP:140-192`; card text "Atributos da montaria são acumulativos"). The sum of `SoulScore` is the "Ponto Bestial" (assumption: sum over owned avatars, tip "Ponto Bestial pode ser obtido ativando novas Feras").

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mounts.WildSoulFrame` (`WSF`) | "Feras" (`mounts.command08`, `WSF:197`) | Grid of 8 appearances per page (`WSC.PAGE_SIZE`), 5 area tabs, page buttons, soul score | MountsFrame "Feras" button (`MF:649-653`), controller `mounts` openType 2 (`core_module/scripts/mvc/controler/MountsController.as:22-25`; forced when a tab shines, `:33-52`), VIP tip 34 (`m16/scripts/tasktracetip/view/VipMountActivityTipView.as:70-71`), mount box frame (`m11/scripts/exchangebox/ExchangeBoxFrame.as:403-407`) | "Ponto Bestial" `soulScore` (`WSF:202-215`), page "{0}/{1}" (`WSF:384`), tab shine from `MM.isShineArray` (`WSF:237-252`). Requests 8530 on open (`WSF:121-129`) |
| `mounts.WildSoulItem` (`WSIT`) | one card | Avatar cell | WildSoulFrame | Name; for MountType 0 "Nv. {Property2}" (`WSIT:283-292`); lock and grey filter when not owned (`WSIT:310-313, 521-537`); VIP flag (`WSIT:314-317`); star bar `star / maxStarGrade` and the refine button when lord grade >= 70, permanent and not VIP/king (`WSIT:318-340`); "Montaria Temporária" or "Ainda não ativou" (`WSIT:341-359`); countdown "Restante:  {0} dia(s)" / "{0}h" / "{0}min" (`WSIT:363-456`); king board and king train button for MountType 4 (`WSIT:295-300`); hover button "Transformar" (`mounts.Illusion`) on owned cells (`WSIT:219-235`); tooltip `MountTip` |
| `MountTip` (`MTIP`) | tooltip | Template details | hover | attributes with star or king bonus, "Ponto Bestial +{0}" (`mountTip.soulscore`), "Classe {0}" need grade, "Necessário: {0}" item, "Validade: Permanente" / "Validade: {0} dias", "Habilidade especial: Vôo" for `IsFly` or `is_buy_fly` (`MTIP:140-319, 397`) |
| MountsFrame fly buttons | "Pode voar" / "Não pode voar" | Fly state of the selected avatar; "Não pode voar" opens the purchase confirm | MountsFrame (`MF:237-238, 584-592, 893-910`) | |
| `VipMountActivityTipView` (tip 34) / `VipMountLoseTipView` (tip 35) | "Obteu VIP Exclusivo de Montaria" ("Ver Montaria") / "Falha no VIP Exclusivo de Montaria" ("Renovar") | VIP mount granted or lost | 4610 (`BM:1318-1343`) | |

## 3. Routes (client to server)

### A1. Request the avatar list
- Senders: `MM.requestWildSoulList` (`MM:363-367`) at login from `MM.setup` (`MM:98`), on WildSoulFrame open (`WSF:123`), after a mount level up (`MF:920`), after 4610 activation (`BM:1334`), and when 4679 names an unknown template (`MM:318-321`).
- Route: send 8530 (0x2152) `C_MOUNT_AVATARLIST`, no body.
- Response: 4427 `MountAvatarMsg`, possibly split in pages (S1).

### A2. Activate a locked appearance (op 4, `MOUNTAVATAR_ACTIVE`)
- UI: click on a locked cell (`WSF:469-605`).
- Client checks (`WSF:512-604`):
  - MountType 1, 2 or 4 and locked: `NeedMountGrade > mount grade` -> "Requer Classe {0}" (`mounts.UseGoodNeedGrade`). Unlock item = template `NeedItemId`, or for MountType 4 the first value of config `mount_king_active_item` (2131500). If the item is in the bag: confirm "Utilizar {0}({1}) Ativar?" (`mounts.command10`, {1} = "{n} dias" or "Permanente" from the item `Property2`) or for kings "Quer usar {0} para ativar?" (`mounts.kingAlert.command01`). Else if `Property1 <= 0`: "{0} não encontrado na Mochila, não é possível ativar" (`mounts.command12`) and stop; else confirm "Você não tem {0}, consumir {1} diamantes para destravar?" (`mounts.command11`) as a `USEBINDPOINT_ALERT` with cost `Property1`. Templates without an unlock item: only the diamond path.
  - MountType 3 locked and the lord is not an active VIP: confirm "Ativando Privilégios VIP de Montaria é preciso habilitar VIP, habilitar agora?" -> opens controller `vip` (`WSF:588-614`). Nothing is sent.
  - MountType 0 locked: nothing (`WSF:601-604`).
- Request: `op` = 4; `pay_type` = 0 when the bound diamond checkbox is ticked, 1 otherwise (`WSF:616-628`); `param1` = template id; `property_type` 0; `param2` 0. The chosen path (item or diamonds) is not sent: the server uses the item when present, else charges `Property1` diamonds.
- Response: 4679 `AvatarInfoMsg` for the new template (the client does not know it yet, so it re-requests 8530, `MM:317-321`), or directly 4427 with the full list (assumption: either works). Then 4426 with the new totals and soul score effect, 115 bag update for the consumed item, 3 for diamonds.

### A3. Change the ridden appearance (op 2, `MOUNT_CHANGE`)
- UI: hover button "Transformar" on an owned cell -> `WSF.onChange(index)` (`WSIT:171-174`, `WSF:409-413`) -> `WSF.__onChangeBtnClick` (`WSF:415-440`). The `_changeBtn` icon is built but never added to the display list.
- Client checks: transformed lord -> "Não é possível transformar"; in space when the new template cannot land here (`SpaceModel.canLand(templateId)`) -> "Não é possível remover estado de montaria voadora"; in a campaign on an obstacle the client resets the position first. The frame closes after sending.
- Request: `op` = 2, `param1` = template id.
- Response: 4426 with `mount_tempId` = new template; when riding, also 150 `ArmyMsg` with the new `mount_tempId` (assumption, required for the map avatar to change).

### A4. Use a mount card (item use, inventory route)
- UI: bag cell click or bag menu "use" on an item with `SonType` 218 (`PBCM:456-485`, `GIM:477-506`).
- Client logic: card `Property1` = mount template; if already owned: when the card is temporary (`Property2 != -1`) use it directly; when permanent and `Refresh == -1` -> "Esta carta de montaria já foi ativada permanentemente, não pode decompor" and stop; else confirm "Esta montaria está ativada permanentemente, ao utilizar irá decompor Essência da Fera x{0}, deseja continuar?" with {0} = template `Power * mount_card_resolve_multiple` (4). Not owned: use directly and mark the area tab to shine (`MM:369-386`).
- `MM.sendUseGoods`: card `Property3 > 0` and mount grade below it -> "Requer Classe {0}" (no current card sets `Property3`); then `SocketSendManager.sendUseItem(pos)` and the tool bar mount button shines.
- Route: send 5006 (0x138e) `U_C_BAG_USEITEM` `ItemUseMsg` (`pos` #1, `count` #2 = 1, `bag_type` #3 = 1, `battle_id` #4, `friend_id` #5) owned by [../inventory/README.md](../inventory/README.md); the inventory handler must delegate SonType 218 to `mounts::avatars::use_mount_card`.
- Response: new avatar -> 4679 (client then re-requests 8530) + 4426 + 115; decomposition -> mount coin `+Power*4` (4725 `U_C_PLAYER_TOKENINFO`, token masterType 14, see [mount-shop.md](mount-shop.md)) + 115; temporary card on an owned temporary avatar -> extend `expair_date` by `Property2` days (assumption) and push 4679.

### A5. Buy flight for the selected avatar (op 13, `OP_BUY_FLY`)
- UI: "Não pode voar" button (`MF:893-902`), visible when the selected avatar has neither `IsFly = 1` nor `is_buy_fly`.
- Client: confirm "Deseja gastar {0} diamantes ou 1 Pedras de Voo para transformar sua montaria em uma montaria voadora?\n(Pedras de Voo são usadas primeiro)\nPedras de Voo restantes: {1}" with {0} = config `mount_buy_fly_point` (500; client default 1000, `core_module/scripts/yishi/datas/ConfigInfoManager.as:1279-1286`) and {1} = count of 208131 "Pedra de Voo" (`MM:49`). No balance check client side.
- Request: `op` = 13, `param1` = current `mount_tempId` (`MF:904-910`).
- Response: 4679 `AvatarInfoMsg` with `is_buy_fly` = true (the client also flags the template, `MM:351-359`), 115 or 3 for the cost.

## 4. Server messages (server to client)

### S1. 4427 (0x114b) `U_C_MOUNT_AVATARLIST`, `MountAvatarMsg` (package `campaign`)
Receiver `MM.__onMountListUpdate` / `__readMountList` (`MM:157-226`). Response to 8530.

| Field | Tag, type | Meaning |
|---|---|---|
| `avatarInfo` | #1, `AvatarInfoMsg`, repeated | owned avatars of this page |
| `soulScore` | #2, INT32 | "Ponto Bestial"; read from the first page only (`MM:197`) |
| `count` | #3, INT32 | total avatar count (not read) |
| `stamp` | #4, INT32 | page group key; all pages of one answer share it |
| `totalPage` | #5, INT32 | page count; when > 1 the client concatenates pages keyed by `"4427_" + stamp` and applies the list after `totalPage` pages (`MM:165-190`) |

`AvatarInfoMsg` (package `campaign`):

| Field | Tag, type | Meaning | Client |
|---|---|---|---|
| `mount_tempId` | #1, INT32 | template | key |
| `is_exist` | #2, BOOL | avatar currently valid | required for stars (`MM:407-410`) |
| `expair_date` | #3, STRING `YYYY-MM-DD hh:mm:ss` | expiry; year 2000 means permanent (`WSI:75-83`) | `validity` = -1 for permanent, else whole days left |
| `active_date` | #4, STRING same format | activation time | stored |
| `validity` | #5, INT32 | days | not read (computed client side) |
| `star_level` | #6, INT32 | stars 0..`maxStarGrade` | [star-promotion.md](star-promotion.md) |
| `blessing` | #7, INT32 | star blessing points | [star-promotion.md](star-promotion.md) |
| `param1` | #8, INT32 | unknown | stored only |
| `param2` | #9, INT32 | unknown | stored only |
| `is_buy_fly` | #10, BOOL | flight purchased | sets `MT.isBuyFly` (`MM:210-218`) |

Client reaction: clears and rebuilds the collection, dispatches `mountListChange` (refreshes WildSoulFrame, MountsFrame stars, shop "already active" flags). Any avatar with `star_level > 0` stops the refine button flashing (`MM:219-222`). Dates are parsed by `DateFormatter.parse` (`core_module/scripts/yishi/utils/DateFormatter.as:16-52`): an empty string yields an invalid date and `validity` 0, which hides the stars and labels the avatar "Montaria Temporária".

### S2. 4679 (0x1247) `U_C_MOUNT_UPGRADESTAR`, `AvatarInfoMsg`
Receiver `MM.__onMountStarUpdate` (`MM:311-361`). Partial update of one avatar: every field is applied only when present (`has*`). Unknown template -> the client sends 8530. Dispatches `mountItemChange` (star view, fly buttons). Used after op 4 (new avatar), op 6 (stars), op 13 (fly), card use and expiry changes.

### S3. 4610 (0x1202) `U_C_VIPMOUNT_STATE`, `simple.PropertyMsg`
Receiver `BM.__vipMountStateHandler` (`BM:325, 1318-1343`); ignored below lord grade 16. `param7` (#7, BOOL) true -> trace tip 34 and 8530 request; false -> trace tip 35. Push when VIP starts (grant avatar 1131) or ends (remove or expire it). `simple.PropertyMsg` (`core_module/scripts/com/road/yishi/proto/simple/PropertyMsg.as`) fields: `param1`..`param3` (#1..#3, INT32), `param4`..`param6` (#4..#6, STRING), `param7`..`param9` (#7..#9, BOOL), `param10`, `param11` (#10, #11, INT32), `param12` (#12, STRING). It is missing from `protocol/proto.json` (name collision with `army.PropertyMsg`).

### Current server behavior (`server/flows/navigation.json:1052-1100`)
8530 always answers one 4427 page with three fixed avatars (1003, 1102, 1117 with `is_buy_fly` true), `star_level` 1, `expair_date` "" and `soulScore` 150. Problems: no persistence; `expair_date` "" makes every avatar temporary (stars hidden, "Montaria Temporária"); the default 1000 and the grade-unlocked normal horses are missing; `soulScore` does not match the templates. The real handler must read `mounts.avatar`, send `2000-01-01 00:00:00` for permanent avatars and page large lists.

## 5. Rules and formulas

- Ownership is the unlock state. Default row: 1000 "Cavalo Branco" (MountType 0, `Property2` 1) at character creation (assumption, it is grade 1 in Types 19).
- Normal avatars: when the mount grade reaches a row of Types 19, insert its `ActiveObject` template (permanent). Display rule: a MountType 0 cell with `Property2 - grade > 1` only shows "Desabilitado" (`WSIT:276-280`).
- Activation by op 4 (server validation): template exists and is not owned (or owned but expired, assumption: re-activation allowed); MountType in {1, 2, 4} (types 0, 3, 5 rejected); mount grade >= `NeedMountGrade` (all current rows have 0); for MountType 4 lord grade >= 70; payment: unlock item (`NeedItemId`, or 2131500 x1 for kings, config `mount_king_active_item` = "2131500,1") consumed if present, else `Property1` diamonds (`Property1 <= 0` means item only); `pay_type` 0 allows bound diamonds. Duration: item `Property2` days (-1 permanent); diamond unlock permanent (assumption). King activation also creates the king row ([mount-king.md](mount-king.md)) and pushes 4973.
- Mount cards: `ItemTempInfos` SonType 218 (721 cards). `Property1` = template, `Property2` = days (-1 permanent; two cards have 7), `Refresh == -1` = cannot be decomposed (442 cards). Decomposition value: template `Power * mount_card_resolve_multiple` (4) mount coin; config `mount_card_resolve_to_item` = -3000 is the reward id (assumption: -3000 denotes the mount coin token).
- Expiry: `validity = floor((expair - now) / 1 day)`; year 2000 means permanent (`WSI:75-83`). A scheduler must expire temporary avatars: set `is_exist` false or delete the row (assumption: delete, since presence means unlocked for the client), switch the selected appearance back to the best normal horse if it was the expired one, push 4679/4427 and 4426, and 150 if riding.
- Countdown text is only shown for templates 3002, 3005 and 1132 and for the VIP mount (`WSIT:376-455`; the first branch tests `TemplateId == 3002 && TemplateId == 3005` and never runs).
- VIP mount (1131): owned while VIP is active; the countdown uses the VIP expiry (`WSIT:407-423`). Server: grant on VIP activation/renewal, remove on expiry, push 4610 with `param7` true/false ([../vip/README.md](../vip/README.md)).
- Sorting (client only, `WSC:128-316`): normal tab = owned first, then by `Property2`; other tabs = king, VIP, owned, then `Power + Speed` descending, then name.
- Change appearance (op 2): template must be owned and valid; cannot change while transformed; in space a non-flying template cannot be selected over an obstacle.
- Flight: a template flies when `IsFly = 1` (364 templates) or `is_buy_fly` (`core_module/scripts/map/space/SpaceModel.as:162-174`). Purchase: 1 "Pedra de Voo" (208131) if present, else `mount_buy_fly_point` (500) diamonds; only for an owned avatar that does not already fly; permanent (assumption). Flying changes space movement (walk on obstacles, `SpaceModel.getAroundWalkPoint`) and blocks dismount over obstacles ([../sky-realm/README.md](../sky-realm/README.md)).
- Soul score: `soulScore = sum(SoulScore of owned avatars)` (assumption); used by the soul score ranking (sort type 7, [../rankings/README.md](../rankings/README.md)).
- Avatar attribute contribution to the mount totals: base attrs + star bonus for every valid owned avatar, and `ExpandLevel` to `level_max` (assumption, see [mount-core.md](mount-core.md)). The VIP avatar contributes only while VIP is active.

## 6. Templates

| File | Records and fields used |
|---|---|
| `raw/xml/tempinfos/MountTempInfos.xml` | all fields listed in [mount-core.md](mount-core.md); here `MountType`, `Area`, `NeedItemId`, `Property1`, `Property2`, `NeedMountGrade`, `SoulScore`, `IsFly`, `ExpandLevel`, `Power`..`Agility`, `Speed` |
| `raw/xml/tempinfos/ItemTempInfos.xml` | SonType 218 mount cards (`Property1` template, `Property2` days, `Refresh`); unlock items 2180001.. (`NeedItemId`); 2131500 "Despertamento da Fera" (SonType 210); 208131 "Pedra de Voo" (SonType 208) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `mount_buy_fly_point` = 500; `mount_card_resolve_multiple` = 4; `mount_card_resolve_to_item` = -3000; `mount_king_active_item` = "2131500,1" |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 19 | `ActiveObject` normal avatar per mount grade |

## 7. Persistent state

```sql
CREATE TABLE mounts.avatar (
  player_id     BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   INTEGER     NOT NULL,
  activated_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  expires_at    TIMESTAMPTZ,
  source        SMALLINT    NOT NULL DEFAULT 0 CHECK (source BETWEEN 0 AND 5),
  star_level    SMALLINT    NOT NULL DEFAULT 0 CHECK (star_level BETWEEN 0 AND 5),
  blessing      INTEGER     NOT NULL DEFAULT 0 CHECK (blessing >= 0),
  is_buy_fly    BOOLEAN     NOT NULL DEFAULT false,
  param1        INTEGER     NOT NULL DEFAULT 0,
  param2        INTEGER     NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, template_id)
);
CREATE INDEX avatar_expiry ON mounts.avatar (expires_at) WHERE expires_at IS NOT NULL;
```

- `expires_at` NULL = permanent (encode as `2000-01-01 00:00:00` on the wire). `source`: 0 grade, 1 item/card, 2 diamonds, 3 VIP, 4 king item, 5 other (audit only).
- `star_level` and `blessing` belong to [star-promotion.md](star-promotion.md).
- Mount coin balance lives in the currency/token store ([../currency/README.md](../currency/README.md)).

## 8. Backend implementation notes

Handlers:
- `mounts::avatars::handle_avatar_list` (8530): select the player's rows, compute `soul_score`, split into pages (suggested 100 avatars per page) with one random `stamp`, send 4427 pages in order.
- `mounts::avatars::handle_activate` (8529 op 4).
- `mounts::avatars::handle_change` (8529 op 2).
- `mounts::avatars::handle_buy_fly` (8529 op 13).
- `mounts::avatars::use_mount_card` (called by the inventory 5006 handler for SonType 218).
- `mounts::avatars::on_vip_changed` (called by the VIP feature).
- `mounts::avatars::expire_job` (scheduler).

op 4 validation order: grade >= 16 -> template exists -> MountType in {1,2,4} -> not owned (or expired) -> lord grade >= 70 for kings -> `NeedMountGrade` -> payment available (item first, else diamonds by `pay_type`). Transaction: lock player, consume item or diamonds, insert `avatar`, for kings insert `king_mount`, recompute totals; commit; push 4679, 4426, 115/3, and 4973 for kings.

op 2: owned, valid, not transformed, map rules; update `mount_state.current_template_id`; push 4426; if riding push 150 and the scene army update.

op 13: owned, valid, not `IsFly`, not `is_buy_fly`; pay 208131 x1 or diamonds; set `is_buy_fly`; push 4679, 115/3.

Card use: owned and permanent -> refuse when `Refresh == -1`, else consume the card and credit `Power * 4` mount coin (push 4725); owned and temporary -> extend; not owned -> insert with `Property2` days; push 4679 and 4426. Fighting capacity recompute after any change.

Expiry job (every minute): rows with `expires_at <= now()`: delete, fix the selection, push to online owners.

## 9. Open questions and assumptions

- Semantics of `param1`/`param2` in `AvatarInfoMsg` (never read by the client).
- Whether expired avatars stay listed with `is_exist` false or are removed (assumption: removed).
- Whether a diamond unlock (op 4) is permanent (assumption: yes).
- Soul score formula (assumption: sum of `SoulScore`).
- Extension rule for temporary cards on owned temporary avatars (assumption: add days).
- `mount_card_resolve_to_item` -3000 meaning (assumption: mount coin token).
- Page size of 4427 (not visible in the client; assumption 100).
- Whether op 2 must also send 150 when riding (assumption: yes).

## 10. Implementation checklist

- [ ] Screen `mounts.WildSoulFrame` and `WildSoulItem` render from 4427 (lock, stars, countdown, VIP flag, king board)
- [ ] Screen MountsFrame fly buttons from `is_buy_fly` / `IsFly`
- [ ] Route 8530 -> 4427 with paging and correct date sentinel
- [ ] Route op 4 activate (item or diamonds, kings with 2131500)
- [ ] Route op 2 change appearance (+150 when riding)
- [ ] Route op 13 buy flight (208131 first, else 500 diamonds)
- [ ] Inventory hook for SonType 218 cards (activate, extend, decompose to mount coin)
- [ ] Server message 4427 `MountAvatarMsg` / `AvatarInfoMsg`
- [ ] Server message 4679 partial `AvatarInfoMsg`
- [ ] Server message 4610 VIP mount state (`simple.PropertyMsg` encoder)
- [ ] Table `mounts.avatar`
- [ ] Rule: grade unlock of MountType 0 rows
- [ ] Rule: expiry scheduler and selection fallback
- [ ] Rule: VIP grant and removal
- [ ] Rule: soul score
- [ ] Replace the `server/flows/navigation.json` 8530 rule
- [ ] Test: activate with item, with diamonds, without either (rejected)
- [ ] Test: permanent avatar shows stars (expiry `2000-01-01 00:00:00`)
- [ ] Test: 4427 with 2 pages assembled by the client
- [ ] Test: card decomposition credits `Power*4` mount coin
