# VIP membership: open, renew, gift, levels and growth

Path aliases:

| Alias | File |
|---|---|
| VM | `decompiled/core_module/scripts/managers/VIPManager.as` |
| VMOD | `decompiled/core_module/scripts/mvc/module/vip/VIPModel.as` |
| VI | `decompiled/core_module/scripts/mvc/module/vip/VipInfo.as` |
| VC | `decompiled/core_module/scripts/mvc/controler/VIPControler.as` |
| VF | `decompiled/m15/scripts/vip/VIPFrame.as` |
| VV | `decompiled/m15/scripts/vip/VIPView.as` |
| OSV | `decompiled/m15/scripts/vip/OpenSelfView.as` |
| OFV | `decompiled/m15/scripts/vip/OpenFriendView.as` |
| OVI | `decompiled/m15/scripts/vip/OpenVipItem.as` |
| CGC | `decompiled/core_module/scripts/mvc/controler/ConsortiaGroupChatControler.as` |

## 1. Overview

VIP is time based: buying 1, 3 or 6 months adds 31, 93 or 186 days of validity. While valid the player is VIP (`is_vip`), has a VIP type (0 normal "VIP Comum", 1 golden purple "VIP Roxo Dourado", 2 temporary) and enjoys the privileges of his VIP level. The level (1 to 9) follows the growth points: +10 per day as normal VIP, +15 per day as golden purple, +1 per 100 consumed diamonds (also before activation), and -5 per day after expiry. The same request gifts VIP to a friend.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `vip.VIPFrame` (VF) | "Recarga VIP" (VF:56) | Tabs VIP and VIP shop (shop tab only if `VersionSwitch.VIPSHOP`, false in this build, VF:62-69) | HUD VIP button, `openControllerByInfo("vip")`; `VC.frameClassName` returns `vip.VipBoxFrame` for openType 3 (VC:71-78) | |
| `vip.VIPView` (VV) | VIP tab | VIP icon (normal or golden), level digits, growth bar, remaining time, buttons "self" / "friend", privilege button, help | VF tab 0 | remaining time `ExpirData - now` (VV:136); growth bar `VipGp / Data(level + 1)` from `UpGradeTempInfos` Types 4 (VV:158-173); tip "Valor de crescimento atual {0}" / "Crescimento atual = Crescimento diário + Crescimento de consumo (acumulo de 100 diamantes consumidos aumenta 1 ponto)" (VV:176-181); help "Ajuda de VIP" frame `vip.VIPHelpFrame` (VV:240-245) |
| `vip.OpenSelfView` (OSV) | self purchase | Three cards (6, 3, 1 months), privileges of the selected card, buttons "open", "renew", "gift pack" | VV self button | `OpenVipItem` cards (OSV:111-124); not VIP: open button glowing; VIP: renew + gift pack buttons, gift glow when `IsTakeGift` (OSV:80-100, 201-225); selected card privileges `VipContentHelper` of level 6 for the 6 months card, 2 for 3 months, 1 for 1 month (OSV:150-164, 227-238) |
| `vip.OpenVipItem` (OVI) | "VIP 6 Meses" / "VIP 3 Meses" / "VIP 1 Meses" | Price card | OSV, OFV | price from `Six_MonthPoint` 1588, `Three_MonthPoint` 868, `One_MonthPoint` 298 (OVI:43-85, VC:33-38); rebate badge only on 6 months |
| `vip.OpenFriendView` (OFV) | friend purchase | Name combo (friends or guild members), repeat name field, three cards, current diamonds | VV friend button | friend list = relations 1 and 3 (OFV:330-342), guild members (OFV:285-292); names limited to 12 chars (OFV:300-316) |
| Task trace tips | 21 "Elevar VIP" "Parabéns, VIP atingiu Nv. {0}!"; 22 "Coletar pacote VIP" "Você tem pacote VIP à coletar"; 23 "Ativar VIP" "VIP expirado, ativar agora?" | Notifications | VMOD:91-119, 136-144 | |

## 3. Routes (client to server)

### R1. Open or renew VIP for self
- UI: OSV open or renew button `__openVipHandler` (OSV:166-180).
- Client checks: `playerInfo.point >= card.point` (bound diamonds not accepted) else `RechargeAlertMannager.show()` (OSV:169-173); confirmation "Certeza ao ativar {0} meses de VIP? Essa ativação consumirá {1} diamantes" (OSV:174-179).
- Sender: `_confirmFun` (OSV:182-188) -> `VIPManager.openVip(false, 0, "", months * 31)` (VM:133-142).
- Route: send 8513 (0x2141) `C_VIP_OPEN`; message `VipOpenInfoMsg` (vip): `is_friend` (#1, BOOL) false; `friend_id` (#2, INT32) 0; `friend_nick_name` (#3, STRING) empty; `days` (#4, INT32) 186, 93 or 31.
- Expected responses in order: 3 (`point` decreased), 4410 `U_C_VIP_INFO` with the new expiry, level and type, 4455 to online guild members if `is_vip` or `vip_type` changed, 4610 VIP mount state if the mount privilege became active and hero level >= 16 ([privileges.md](privileges.md)).

### R2. Gift VIP to a friend
- UI: OFV open button `__openVipHandler` (OFV:188-211).
- Client checks: both name fields filled else "Insira nome"; names equal ignoring case else "Nomes inseridos não coincidem"; `point >= card.point` else recharge alert; confirm "Deseja ativar VIP de {0} mês(es) para o seu amigo? Necessário consumir {1} diamantes" (OFV:213-221).
- Sender: `_confirmFun` (OFV:223-238): when a combo entry was picked and its nick equals the typed name, `openVip(true, userId, nickName, months * 31)`; otherwise `openVip(true, 0, typedName, months * 31)`.
- Route: send 8513 (0x2141) `C_VIP_OPEN`; `is_friend` (#1) true, `friend_id` (#2) target player id or 0, `friend_nick_name` (#3) target nick, `days` (#4).
- Expected responses: to the buyer 3 (`point`); to the target, if online, 4410 and 3 (assumption) plus a system mail for the gift (assumption); 4455 to the target's guild members.

## 4. Server messages (server to client)

### S1. 4410 (0x113a) `U_C_VIP_INFO`
- Message `VipInfoMsg` (vip): `is_vip` (#1, BOOL) VIP and not expired; `vip_gp` (#2, INT32) growth points; `vip_grade` (#3, INT32) level 0..9; `expirt_date` (#4, STRING "YYYY-MM-DD hh:mm:ss") expiry; `is_takeGift` (#5, BOOL) weekly gift available ([weekly-gift.md](weekly-gift.md)); `vip_type` (#6, INT32) 0 normal, 1 golden purple, 2 temporary (VI:9-13); `is_expirt` (#7, BOOL) not read by the client; `take_giftDate` (#8, STRING) next date the weekly gift becomes available.
- Receiver: `VIPManager._vipInfoHandler` (VM:52, 107-123): copies into `VipInfo`, sets `thane.vipType` and `thane.IsVipAndNoExpirt`, then `VIPModel.vipInfo` setter (VMOD:91-119): tip 21 when the level rose from a level > 0, tip 22 when `is_takeGift && is_vip`, then `upframeview_change` (HUD button, VIP views, customized VIP flicker).
- When: login; after R1/R2; after each growth tick that changes `vip_gp` or `vip_grade`; at expiry; after the weekly gift is taken or becomes available.

### S2. 4416 (0x1140) `U_C_VIP_OPENTIPS`
- Message: none read (VM:63-66).
- Receiver: `VIPModel.vipOpenTips` (VMOD:136-144) shows tip 23 "Ativar VIP" / "VIP expirado, ativar agora?".
- When: at expiry and at login while expired (assumption: once per login while `vip_grade > 0` and not VIP).

### S3. 4455 (0x1167) `U_C_CONSORTIA_VIP`
- Message `VipToConsortiaMsg` (vip): `userid` (#1, INT32) member; `is_vip` (#2, BOOL); `vip_type` (#3, INT32); `consortia_id` (#4, INT32).
- Receiver: `ConsortiaGroupChatControler.__vipInfoChangeHandler` (CGC:117, 120-132) updates the guild chat member list icons.
- When: push to every online member of the player's guild after his VIP state or type changes.

No result codes exist for 8513; refusals (not enough diamonds, unknown nick, target is self) use 126 `U_C_MSG` (assumption).

## 5. Rules and formulas

- Prices (`raw/xml/tempinfos/ConfigInfos.xml`): `One_MonthPoint` 298, `Three_MonthPoint` 868, `Six_MonthPoint` 1588 diamonds. Days = months * 31 (OSV:186, OFV:229-233). Server validates `days` in {31, 93, 186} and derives the price from it.
- Diamonds only (`playerInfo.point`, OSV:169): bound diamonds are not accepted; the spend counts as consumption (VIP growth +1 per 100 diamonds applies to the buyer).
- Expiry: `expires_at = max(now, expires_at) + days`.
- Immediate level: a single purchase of 3 months makes the player at least VIP 2, 6 months at least VIP 4 ("Ativação única de 3 meses, diretamente VIP 2", "Ativação única de 6 meses, diretamente VIP 4"): raise `vip_gp` to `Data(2) = 100` or `Data(4) = 500` when lower.
- VIP type: golden purple (type 1) after a single activation of 6 months (help `vip.view.AllPrivilegeView.allShenquGrowTxt` item 4; `vip.view.OpenSelfView.framePrompt` says 3 months, see open questions). Type 2 (temporary) comes from trial items (assumption) and is excluded from the customized VIP free box.
- Growth per day while VIP: `Vip_DailyAddGp` 10 (normal), `Vip_GoldDailyAddGp` 15 (golden purple). After expiry: `Vip_ExpirtDailyMinusGp` 5 per day.
- Growth from consumption: `Vip_ConsumeGp` 0.01 per diamond (1 point per 100), consumption before activation counts, auction excluded (help item 5).
- Level from growth (`raw/xml/tempinfos/UpGradeTempInfos.xml`, `Types="4"`, `Grades` = level, `Data` = minimum growth): 1: 0, 2: 100, 3: 250, 4: 500, 5: 900, 6: 1500, 7: 2300, 8: 3300, 9: 4500. Level = highest level with `Data <= vip_gp`; the bar shows `vip_gp / Data(level + 1)` and full at level 9 (VV:158-173).
- Decay: "Quando os pontos de VIP atingirem 0, o nível de VIP irá decrescer e ficará com VIP1": the level follows growth downward but never below 1 once the player has been VIP.
- Max level: 9 in templates and help ("9 fases"); `VIPManager.VIP_MAX_LEVEL = 12` (VM:26) and `VipInfo.MaxGrade` reads a missing config `VIP_MAX_GRADE` (VI:44-47): use 9.
- VIP title: `vip_appell_template_id` 431 (`ConfigInfos.xml`) granted while VIP (assumption: owned by [../medals/README.md](../medals/README.md) titles).
- Gift targets: any existing player by nick (assumption: same server only); the friend combo lists relations 1 and 3 and guild members.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `ConfigInfo` | `One_MonthPoint`, `Three_MonthPoint`, `Six_MonthPoint`, `Vip_DailyAddGp`, `Vip_GoldDailyAddGp`, `Vip_ExpirtDailyMinusGp`, `Vip_ConsumeGp`, `vip_appell_template_id` |
| `raw/xml/tempinfos/UpGradeTempInfos.xml` | `UpGradeTempInfo` `Types="4"` | `Grades` VIP level, `Data` growth needed |
| `raw/xml/tempinfos/VipPrerogativeTempInfos.xml` | privileges per level | see [privileges.md](privileges.md) |

## 7. Persistent state

```sql
CREATE SCHEMA IF NOT EXISTS vip;

CREATE TABLE vip.memberships (
  player_id          BIGINT      PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  vip_type           SMALLINT    NOT NULL DEFAULT 0 CHECK (vip_type IN (0, 1, 2)),
  expires_at         TIMESTAMPTZ,
  growth_points      INTEGER     NOT NULL DEFAULT 0 CHECK (growth_points >= 0),
  level              SMALLINT    NOT NULL DEFAULT 0 CHECK (level BETWEEN 0 AND 9),
  consume_remainder  INTEGER     NOT NULL DEFAULT 0 CHECK (consume_remainder BETWEEN 0 AND 99),
  growth_applied_on  DATE,
  weekly_gift_available BOOLEAN  NOT NULL DEFAULT false,
  next_weekly_gift_at   TIMESTAMPTZ,
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX memberships_expires_idx ON vip.memberships (expires_at);

CREATE TABLE vip.purchases (
  id              BIGSERIAL   PRIMARY KEY,
  buyer_id        BIGINT      NOT NULL REFERENCES player.players(player_id),
  target_id       BIGINT      NOT NULL REFERENCES player.players(player_id),
  days            SMALLINT    NOT NULL CHECK (days IN (31, 93, 186)),
  price           INTEGER     NOT NULL CHECK (price > 0),
  expires_before  TIMESTAMPTZ,
  expires_after   TIMESTAMPTZ NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX purchases_target_idx ON vip.purchases (target_id, created_at DESC);
```

`is_vip` is derived: `expires_at > now()`.

## 8. Backend implementation notes

- `vip::membership::handle_open` (8513): validate `days`; resolve the target (self when `is_friend` false; `friend_id` when > 0 and its nick matches, else lookup by `friend_nick_name`; refuse self as friend); price from config; in one transaction: `currency::spending::spend(Diamonds{price, pay_type: 1, allow_bound: false}, reason "vip.open")`, lock target membership, extend expiry, apply the immediate level floor (3 months -> level 2, 6 months -> level 4) and golden type for 186 days, insert `vip.purchases`. After commit: push 3 to the buyer, 4410 to the target if online, 4455 to the target's guild, 4610 if the mount privilege toggled, mail to the target when it is a gift.
- `vip::membership::add_consume_growth(tx, player_id, diamonds)`: `consume_remainder += diamonds`; `growth += floor(remainder / 100)`; keep `remainder % 100`; recompute level; push 4410 after commit when changed (debounce to one push per second).
- Daily job at 00:00 server time: for every membership, apply +10 / +15 while VIP or -5 after expiry (floor 0), recompute level with floor 1 for ex VIPs, set `growth_applied_on`; push 4410 to online players whose values changed.
- Expiry watcher (every minute): memberships with `expires_at` passed since the last run: push 4410 (`is_vip` false) and 4416, push 4455, 4610 (mount lost).
- Login: send 4410, then 4416 when expired and level > 0.
- `vip::membership::is_vip(player_id)` and `level(player_id)` are read by [privileges.md](privileges.md).

## 9. Open questions and assumptions

- Conflict: golden purple after 3 months (`vip.view.OpenSelfView.framePrompt`) or after 6 months (help text). Chosen: 6 months, assumption.
- Assumption: the immediate level floors apply to a single purchase, not to the sum of purchases.
- Assumption: gift recipients get a mail; no client string confirms the mail text.
- Open: `is_expirt` (#7) meaning (probably `!is_vip` with level > 0); send it as `!is_vip && level > 0`.
- Open: whether growth decay stops at 0 or the level drops step by step; chosen: level recomputed from growth with floor 1.

## 10. Implementation checklist

- [ ] Screen: VIP frame shows icon, level, growth bar and remaining time from 4410
- [ ] Screen: self cards prices 1588 / 868 / 298
- [ ] Screen: friend combo lists friends and guild members
- [ ] Route R1 8513 self
- [ ] Route R2 8513 friend by id and by nick
- [ ] Server message S1 4410 at login and after every change
- [ ] Server message S2 4416 at expiry
- [ ] Server message S3 4455 to guild members
- [ ] Table `vip.memberships`
- [ ] Table `vip.purchases`
- [ ] Rule: days 31 / 93 / 186 and diamond only payment
- [ ] Rule: level floors 2 and 4, golden type
- [ ] Rule: daily growth +10 / +15, decay -5, consumption 1 per 100
- [ ] Rule: level table Types 4
- [ ] Test: renew extends from the current expiry
- [ ] Test: expiry pushes 4410 and 4416 and removes privileges
- [ ] Test: consuming 250 diamonds adds 2 growth and keeps 50 as remainder
