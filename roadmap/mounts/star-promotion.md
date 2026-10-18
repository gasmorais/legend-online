# Star promotion ("Refinar", "Refinação de montarias")

Scope: raising the star level (0..5) of an owned permanent appearance with "Armação da Fera" (208035), the blessing counter that guarantees success when full, the free first refine, and the per-star attribute bonus. Opcode 4679 is shared with [avatars-and-wild-souls.md](avatars-and-wild-souls.md).

Path aliases (all under `decompiled/`):

| Alias | File |
|---|---|
| MM | `core_module/scripts/managers/MountsManager.as` |
| WSC | `core_module/scripts/mvc/module/mounts/WildSoulCollection.as` |
| WSI | `core_module/scripts/mvc/module/mounts/WildSoulInfo.as` |
| MT | `core_module/scripts/yishi/datas/templates/MountTemplate.as` |
| MC | `core_module/scripts/mvc/controler/MountsController.as` |
| MF | `m14/scripts/mounts/MountsFrame.as` |
| WSF | `m14/scripts/mounts/WildSoulFrame.as` |
| WSIT | `m14/scripts/mounts/WildSoulItem.as` |
| MPV | `m14/scripts/mounts/MountsPromotionView.as` |
| CIM | `core_module/scripts/yishi/datas/ConfigInfoManager.as` |

## 1. Overview

Each owned, permanent, non-VIP, non-king appearance has `star_level` (0..`maxStarGrade`) and `blessing`. A refine attempt consumes one "Armação da Fera" (208035, "É produzida principalmente na Roleta da Masmorra"). It either succeeds (star +1) or adds 1 blessing point; when the blessing reaches the threshold of the next star the success rate is 100%. Each star adds the template `StarAddition[star-1]` to all four attributes of that avatar. Unlocked at lord grade 70 ("A refinação de montarias é ativada no nível 70", item 208035 description).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `mounts.MountsPromotionView` (`MPV`), embedded in WildSoulFrame | "Refinar" (`refine2`, `WSF:671`); help "Instruções da Refinação" (`mounts.PromotionHelpTitle`, text `mounts.PromotionHelpTxt`) | Refine one avatar | Refine button on a WildSoulItem (`WSF:485-494, 630-676`); star button next to the mount name in MountsFrame (`MF:886-891`, opens controller `mounts` openType 2 with the template id, `MC:54-65`) | Left: name, big star bar, avatar (`MPV:484-489`). Right: star bar; four rows (Strength, Intellect, Stamina, Armor) "current -> next (+delta)" using `starAddList` (`MPV:511-533`); blessing bar "{bless}/{Data}" (`MPV:492-493`); "100%" success badge only when the blessing is full (`MPV:494-500`); count "x {n}" of 208035 (`MPV:186-187, 573-574`); buttons "Refinar" (tip `mountsPromotionView.promotBtn.tip`), advanced x10 (tip `mountsPromotionView.advpromotBtn.tip`), return. At max star: "MAX", buttons disabled, max image (`MPV:535-566`) |
| `mounts.MountsPromotionItemView` | row | One attribute row of the view | MPV | values only |
| Refine button flash | | Tool bar mount button and MountsFrame star button flash while `WSC.firstBless` (`MF:320-323`, `core_module/scripts/ui/maintoolbar/MainToolBar.as:1036-1039`) | | |

## 3. Routes (client to server)

All: 8529 (0x2151) `C_MOUNT_OP`, `MountEditMsg`, `op` = 6 (`MOUNT_START`). Note the unusual use of `property_type` for the template id.

| Field | Value |
|---|---|
| `property_type` (#1, INT32) | avatar template id |
| `pay_type` (#2, INT32) | 0 = use owned 208035 only; 1 = buy the missing 208035 with real diamonds (`point`); 2 = buy them with bound diamonds allowed (`point + giftToken`) |
| `param1` (#3, INT32) | 0 = single refine; 1 = advanced refine (10 attempts) |
| `param2` (#4, INT32) | 0 |
| `op` (#5, INT32) | 6 |

### P1. Single refine with owned items
- UI: "Refinar" `_promotBtn` (`MPV:275-303`).
- Client checks: no avatar -> nothing; unless `firstBless`, owned 208035 < 1 -> goes to P2. Confirmation "Deseja consumir {0} x{1} para refinar {1} vez(es)?" with "Não alertar mais" (`MPV:342-378`), skipped when already dismissed or on the first free refine.
- Request: `property_type` = template, `pay_type` 0, `param1` 0.

### P2. Refine buying the missing items
- UI: P1 or P3 with too few items -> `MPV.showPromptAlert(n, mode)` (`MPV:305-314`): "Itens insuficientes, deseja consumir {0} diamantes para refinar?" with {0} = `Mount_Star_Point * n` (config 10, `CIM:792-799`), `USEBINDPOINT_ALERT` checkbox.
- Client checks: balance (`allPoint` when the checkbox is on, else `point`) < cost -> recharge alert (`MPV:316-340`).
- Request: `property_type` = template, `pay_type` = 2 with bound diamonds, 1 without; `param1` = 0 for a single refine (n = 1) or 1 for advanced (n = 10 - owned).

### P3. Advanced refine (x10)
- UI: advanced button `_advPromotBtn` (`MPV:380-402`), disabled during the free first refine (`MPV:502-509`).
- Client checks: owned 208035 < 10 -> P2 with n = 10 - owned; confirmation `mountsPromotionView.promotBtn.prompt` with 10 (`MPV:404-440`).
- Request: `property_type` = template, `pay_type` 0, `param1` 1.

Response for all: 4679 `AvatarInfoMsg` with `mount_tempId`, `star_level`, `blessing`. Also 4426 when the star changed (attribute totals), 115 for consumed 208035, 3 for diamonds. The view reloads on `mountItemChange`/`mountListChange` (`MPV:240-273`) and plays the up-star effect when the star grew (`MPV:567-585`).

## 4. Server messages (server to client)

### S1. 4679 (0x1247) `U_C_MOUNT_UPGRADESTAR`, `AvatarInfoMsg` (package `campaign`)
Receiver `MM.__onMountStarUpdate` (`MM:311-361`). Fields and partial semantics in [avatars-and-wild-souls.md](avatars-and-wild-souls.md#s2-4679-0x1247-u_c_mount_upgradestar-avatarinfomsg). For this module send at least `mount_tempId` (#1), `star_level` (#6) and `blessing` (#7). No failure code exists: a failed attempt is visible as `blessing` + 1.

### Current server behavior
No rule answers op 6. The fixed 4427 list declares `star_level` 1 for three avatars but with empty expiry dates, so the client hides stars.

## 5. Rules and formulas

Eligibility (`MM.canShowStar`, `MM:400-424`, and `WSIT:333`): avatar owned, `is_exist`, permanent (`validity == -1`), `MountType` not 3 (VIP) nor 4 (king), lord grade >= 70 (`MF:607`). Server must validate the same.

Max stars (`MT:80-96`): `maxStarGrade` = number of comma separated values in `StarAddition`. Template distribution: 643 with 5 stars ("10,20,30,40,50"), 25 with 4, 31 with 3, 17 with 2, 11 with 1, 6 with "0" (VIP, king and 1132; only 1132 is eligible and its single star adds 0).

Star bonus: an avatar at star s adds `starAddList[s-1]` to each of Strength, Intellect, Stamina and Armor (`MPV:515-531`, `m16/scripts/yishi/view/tips/MountTip.as:145-149`). With the common "10,20,30,40,50" that is +10 .. +50 per attribute (not cumulative per step; the value of the current star replaces the previous one).

Blessing threshold (`raw/xml/tempinfos/UpGradeTempInfos.xml` Types 37, keyed by `TemplateId` = template `GradeType` and `Grades` = target star, `WSI:41-73`); `Data` = blessing needed for a guaranteed success:

| Target star | Data | Exists for GradeType |
|---|---|---|
| 1 | 50 | 1..5 |
| 2 | 100 | 2..5 |
| 3 | 200 | 3..5 |
| 4 | 200 | 4, 5 |
| 5 | 250 | 5 |

`GradeType` equals `maxStarGrade` in the data.

Attempt resolution (help text `mounts.PromotionHelpTxt`, `MM.getPromotSuccessRate` `MM:460-471`):
- If `blessing >= Data(star+1)`: success.
- Else success with probability 5% (assumption: the client constant 5 returned by `getPromotSuccessRate` is the base rate; it is never displayed).
- On failure `blessing += 1`; on success `star_level += 1` and `blessing = 0` (assumption on reset).
- Advanced (`param1` = 1): up to 10 attempts, each consuming one 208035; stop at the first success (assumption) and do not consume the remaining items.

Cost: one 208035 per attempt. Missing items for the request (1 or 10 minus owned) are paid at `Mount_Star_Point` = 10 diamonds each (`ConfigInfos` "【坐骑炼化】坐骑升星一次点券，神兽之蹄钻石价格"); `pay_type` 2 lets bound diamonds pay first (assumption on order).

Free first refine (`WSC.firstBless`, `WSC:507-527`): lord grade >= 70 and the sum of `blessing` and `star_level` over all owned avatars is 0. The client skips the item check and sends `pay_type` 0 (`MPV:285-298`). Server: allow exactly one attempt without items while that condition holds; outcome assumption: guaranteed success (tutorial gift). After any star or blessing exists the condition is false.

Max star: reject the request when `star_level >= maxStarGrade`.

## 6. Templates

| File | Records and fields used |
|---|---|
| `raw/xml/tempinfos/MountTempInfos.xml` | `StarAddition` (per-star bonus list), `GradeType` (blessing curve id), `Power`, `Intellect`, `Physique`, `Agility`, `MountType` |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` Types 37 | `TemplateId` (GradeType), `Grades` (target star), `Data` (blessing threshold) |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Mount_Star_Point` = 10 |
| `raw/xml/tempinfos/ItemTempInfos.xml` | 208035 "Armação da Fera" (SonType 208, MaxCount 9999) |

## 7. Persistent state

Star and blessing live in `mounts.avatar` (`star_level`, `blessing`, see [avatars-and-wild-souls.md](avatars-and-wild-souls.md#7-persistent-state)). Audit log:

```sql
CREATE TABLE mounts.star_log (
  log_id        BIGSERIAL   PRIMARY KEY,
  player_id     BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   INTEGER     NOT NULL,
  attempts      SMALLINT    NOT NULL CHECK (attempts BETWEEN 1 AND 10),
  items_used    SMALLINT    NOT NULL DEFAULT 0,
  items_bought  SMALLINT    NOT NULL DEFAULT 0,
  point_spent   INTEGER     NOT NULL DEFAULT 0,
  star_before   SMALLINT    NOT NULL,
  star_after    SMALLINT    NOT NULL,
  bless_after   INTEGER     NOT NULL,
  was_free      BOOLEAN     NOT NULL DEFAULT false,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX star_log_player_time ON mounts.star_log (player_id, created_at);
```

## 8. Backend implementation notes

Handler `mounts::star::handle_upgrade_star` (8529 op 6).

Validation order: lord grade >= 70 -> `param1` in {0,1} -> `pay_type` in {0,1,2} -> avatar owned, permanent, valid, MountType not 3/4 -> `star_level < maxStarGrade` -> free-first-refine check -> items: needed = 1 or 10; if owned < needed and `pay_type` 0 -> reject; else price the missing ones and check the balance.

Transaction: lock the avatar row; buy missing items virtually (debit diamonds) and consume owned ones as attempts happen; loop attempts with the rule above (server RNG); update `star_level`, `blessing`; insert `star_log`; commit. Pushes: 4679, then 4426 if the star changed (new totals), 115 for items, 3 for diamonds. Recompute fighting capacity.

## 9. Open questions and assumptions

- Base success rate (assumption 5% from the client constant).
- Blessing reset on success (assumption: reset to 0).
- Advanced refine stopping at first success and item refund (assumption).
- Outcome of the free first refine (assumption: guaranteed success).
- Whether bought items are consumed from the bag or only virtually (assumption: virtual, no bag push for bought ones).

## 10. Implementation checklist

- [ ] Screen `mounts.MountsPromotionView` driven by 4679 (`star_level`, `blessing`)
- [ ] Route op 6 single (`param1` 0) with owned items
- [ ] Route op 6 buying missing items (`pay_type` 1 and 2)
- [ ] Route op 6 advanced x10 (`param1` 1)
- [ ] Server message 4679 with star and blessing
- [ ] Server message 4426 after a star change
- [ ] Table `mounts.star_log` (and `mounts.avatar` columns)
- [ ] Rule: eligibility (permanent, not VIP/king, lord grade 70)
- [ ] Rule: Types 37 blessing thresholds by `GradeType`
- [ ] Rule: free first refine
- [ ] Rule: star bonus `starAddList[star-1]` in the attribute totals
- [ ] Test: 50 failures fill the blessing for star 1 then the next attempt succeeds
- [ ] Test: max star rejects; VIP avatar rejects
