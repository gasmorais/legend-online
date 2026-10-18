# VIP privileges ("Privilégio VIP")

Path aliases:

| Alias | File |
|---|---|
| VM | `decompiled/core_module/scripts/managers/VIPManager.as` |
| VMOD | `decompiled/core_module/scripts/mvc/module/vip/VIPModel.as` |
| VPT | `decompiled/core_module/scripts/mvc/module/vip/VipPrerogativeType.as` |
| VPF | `decompiled/m15/scripts/vip/VipPrivilegeFrame.as` |
| VCH | `decompiled/m15/scripts/vip/VipContentHelper.as` |
| GPI | `decompiled/m15/scripts/vip/GradePrivilegeItem.as` |
| NVO | `decompiled/core_module/scripts/yishi/view/frame/NewVipOpenView.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |

## 1. Overview

A privilege is a row of `VipPrerogativeTempInfos.xml` (`type`, `grade`, `para1`, `para2`, `para3`). It is active when the player is VIP (`is_vip`), his level equals `grade` and `para1 != 0`. `para1` is the value (percent, count, flag), `para3 = 1` marks a privilege new at that level (highlighted `#60d5f7`, VCH:47-50), `para2` is a display slot (assumption). The client applies most privileges itself from the template; the server must apply the same values where the effect is server side (EXP, activity points, limits, discounts, cooldowns, auto actions). This module also covers the VIP mount state push, the VIP customer service notice and the disabled VIP shop.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `vip.VipPrivilegeFrame` (VPF) | "Privilégio VIP" (VPF:66) | Nine level buttons; title "VIP{0} Desfrutem {1} privilégios" and the list of the selected level (VPF:123-167) | VIP frame privilege button (`VIPView.__privilegeHandler`), task tip 21, `VIPControler.showPrivilegeFrame` | `VipContentHelper.getContentByGrade(level, 3)` with `{para1}` / `{para2}` substituted (VCH:33-110); count = rows with `para1 != 0` (VCH:14-31) |
| `GradePrivilegeItem` (GPI) | comparison row | Per type value across levels: "+N%" (6), "+N pontos" (2), "+N" (7), "+N vezes" (8, 9, 14), "-N%" (15) (GPI:53-158) | privilege tables | |
| `NewVipOpenView(type)` (NVO) | link text "Habilitando VIP{0} ..." | Upsell link inside other frames: shows the current value ("VIP{0} atual pode desfrutar de recompensa: {1}", tipsData*) or the minimum level owning the privilege (`VIPManager.getMinVipPrerogativeGradeByType`, VM:144-156) and opens the VIP frame | cooldowns, conversion, Einherjar skills, PvP | NVO:40-130 |
| `VIPCustomTipView` | QQ contact tip | VIP customer service contact (China only) | push 4648 | `QQ:{0}~{1}` |

## 3. Routes (client to server)

### P1. VIP customer service "add contact"
- UI: button of the task trace tip type 39 (`decompiled/m16/scripts/tasktracetip/view/VIPCustomTipView.as:68-76`): opens `http://wpa.qq.com/msgrd?V=1&Uin=<title>&Site=sq.7road.com&Menu=yes` and sends.
- Sender: `SocketSendManager.vipCustomAdd` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:545-549`).
- Route: send 8756 (0x2234) `C_VIPCUSTOM_ADD`, empty body.
- Expected response: 4648 with `param1` != 1 to clear the tip (assumption).

The privilege frame itself sends nothing. Every privilege is consumed by the requests of the owning features.

## 4. Server messages (server to client)

### S1. 4610 (0x1202) `U_C_VIPMOUNT_STATE`
- Message `simple.PropertyMsg`: `param7` (#7, BOOL) true = VIP exclusive mount active, false = lost.
- Receiver: `BaseManager.__vipMountStateHandler` (BM:325, 1318-1343): ignored below hero level 16; true shows tip 34 ("Obteu VIP Exclusivo de Montaria", "Ver Montaria") and refreshes the mount list (`MountsManager.requestWildSoulList`); false shows tip 35 ("Falha no VIP Exclusivo de Montaria", "Renovar").
- When: when privilege 19 starts (VIP activation with hero level >= 16, or reaching level 16 while VIP) and when it ends (expiry).

### S2. 4648 (0x1228) `U_C_VIPCUSTOM_NOTIFY`
- Message `simple.PropertyMsg`: `param1` (#1, INT32) 1 = show, other = clear; `param4` (#4, STRING) QQ number; `param5` (#5, STRING) contact name.
- Receiver: `BaseManager.__vipCustomNotifyHandler` (BM:328, 1099-1122): shows tip 39 "QQ:{0}~{1}" or clears it.
- When: China only; this build never needs it. Server sends nothing (assumption).

### S3. 4410 `U_C_VIP_INFO`
Privileges are recomputed client side whenever 4410 arrives ([membership.md](membership.md) S1).

## 5. Rules and formulas

### Privilege values by level (`para1`; "-" = no row)

| Type (VPT) | pt-BR text (template `name`) | L1 | L2 | L3 | L4 | L5 | L6 | L7 | L8 | L9 |
|---:|---|---|---|---|---|---|---|---|---|---|
| 1 CASTLE_VIEW | "Aparência distinta do castelo" | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 2 |
| 2 LIVENEWSS | "Facilidade em completar os pontos de atividade, pontos de atividade +{para1}" | 0 | 0 | 10 | 10 | 20 | 20 | 30 | 30 | 40 |
| 3 AUTO_SIGN_IN | "Check-in automático, obtenha o prêmio de check-in facilmente" | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 4 FRIEND_LIMIT | "Aumenta o limite de amigos, mais amigos para jogar com você" | 0 | 0 | 50 | 50 | 50 | 50 | 50 | 50 | 50 |
| 6 GP_ADDITION | "Ajuda você a elevar de nível rapidamente, adição de EXP de campanha: {para1}%" | 100 | 120 | 140 | 160 | 180 | 200 | 220 | 240 | 300 |
| 10 VIP_COINS | "Moeda VIP exclusiva, obtenha facilmente itens raros" | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 11 ONE_KEY_STAR | "x-adquirir cosmos, operação mais conveniente e rápida" | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 13 | "Pacote Semanal Exclusivo, Obtenha recompensa semanalmente" | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 15 GESTE_DECREAS | "Diminuição da fama no Campo de Batalha: {para1}%" / "Não perde fama no Campo de Batalha" | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 16 ORDER_QUICK | "resfriamento gratuito" | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 18 | "Pular batalha da Arena dos Einherjar" | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 19 | "Montaria exclusiva (ativado no nv.16)" | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 20 | "Baú de Campanha exclusiva, muitos prêmios à sua espera" | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 21 | "Tempere característica de acessório de monstro automaticamente" | - | - | - | 1 | 1 | 1 | 1 | 1 | 1 |
| 200 PLANES_COUNT | "Planos Máximos: {para1}" | 3 | 3 | 3 | 3 | 4 | 4 | 4 | 4 | 5 |
| 202 ITEM_TRANSFORM_DISCOUNT | "Desconto de conversão: {para1}%Off" | 90 | 85 | 80 | 75 | 70 | 65 | 60 | 55 | 50 |
| 203 VEHICLE_REWARD_ADDITION | "Aumento extra de baú da vitória/derrota de artilharia: {para1}x" | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 204 CROSS_INVITE_FREE_ADDITION | "Aumento gratuito de megafones inter-servidor da campanha multiplayer: x{para1}" | 0 | 0 | 0 | 1 | 1 | 2 | 2 | 3 | 3 |
| 205 PET_FREE_SKILL_CD_REDUCE | "Redução do tempo de aprendizagem da habilidade de einherjar: {para1}min" | 30 | 40 | 50 | 60 | 90 | 120 | 150 | 180 | 240 |
| 206 AUTO_STAR | "Auto-Adquirir Cosmos" | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
| 207 | "Inscrição automática na Arena do Guardião" | - | - | - | 1 | 1 | 1 | 1 | 1 | 1 |
| 208 | "compre na Loja VIP e aproveite {para1} de desconto" | 95 | 95 | 95 | 90 | 90 | 90 | 90 | 90 | 85 |
| 209 | "aumenta quantidade de ganhos no mapa de multiplayer diariamente {para1} vez(es)" | 1 | 1 | 1 | 1 | 2 | 2 | 2 | 2 | 2 |

Types declared in VPT but without rows (no effect in this build): 5 SHOP_DISCOUNT, 7 WATERCRYSTAL_ADDITION, 8 GOLD_REFINE_TIMES, 9 SOUL_REFINING_TIMES, 14 STERY_TIMES, 23 CD_WARSOUL, 24 CD_PROFILE_WARSOUL; 201 is read by `SacrificeFrame.as:380` without rows.

### Where each privilege applies

| Type | Consumer (client) | Server effect |
|---|---|---|
| 1 | castle skin | castle appearance level `para1` sent with castle info ([../castle/README.md](../castle/README.md)) |
| 2 | `VIPModel.vipActivePrivilege` (VMOD:170-188) shown "+N" in `dayguide/ProjectItem.as:133,166`, `newleed/ActiveLeedItem.as:122` | add `para1` activity points per completed daily item ([../daily-activity/README.md](../daily-activity/README.md), assumption on per item) |
| 3 | daily guide: VIP >= 3 adds a completed entry (templateId -1) (`DayGuideCatecory.as:305-322`) | auto sign in each day ([../daily-activity/README.md](../daily-activity/README.md)) |
| 4 | `FriendManager.as:756`: friend limit `200 + vipFriendPrivilege`, which is 50 when `para1 != 0` (VMOD:146-168) | friend limit 250 from VIP 3 |
| 6 | campaign result | campaign EXP x (1 + para1 / 100) ("Apenas poderá desfrutar após ativar", only while VIP) |
| 10, 13 | VIP coin usage, weekly pack | [roulette.md](roulette.md), [weekly-gift.md](weekly-gift.md) |
| 11, 206 | `star/view/DisplayStarView.as:354` (one key, VIP >= 1), `:296` (auto, VIP >= 2); alerts `vip.newVipOpenView.alert1/2` | cosmos one key and auto acquire allowed ([../cosmos/README.md](../cosmos/README.md)) |
| 15 | `NewVipOpenView(15)` in `worldboss/PvpSelectFrame.as:91`, `duskarea/DuskAreaSelfInfoView.as:94`, `flametemple/FlameTempleSelfInfoView.as:90` | honor loss reduction `para1`% (all 0 in data: no reduction) |
| 16 | `VIPModel.vipCoolPrivilege` (VMOD:190-212): skips the paid cooldown confirmation in `ui/queuebar/view/QueueItem.as:207`, `petchallenge/views/PetChallengeListView.as:185`, `colosseum/ColosseumFrame.as:173`, `colosseum/view/ChallengeView.as:164`, `perkinlab/PerkinLabRobView.as:151` | the matching "clear cooldown" requests are free for VIP |
| 18 | `battle/view/ui/BattleUIView.as:208, 289, 545, 1255` (VIP >= 3); `Pet_BattleOver_Grade` 3 | Einherjar arena and monopoly help battles may be skipped |
| 19 | 4610 (S1) | VIP mount granted at hero level 16 ([../mounts/README.md](../mounts/README.md)) |
| 20 | campaign | extra VIP chest at campaign end (assumption) |
| 21 | `monster/view/MonsterAccessoriesView.as:348`, `monster/MonsterAutoHammerFrame.as:210` (VIP >= 4) | auto temper accessories ([../monsters/README.md](../monsters/README.md)) |
| 200 | planes | max planes `para1` |
| 202 | `store/switched/SwitchView.as:481`, `store/SwitchView1.as:488`, `tips/goods/SwitchVipPrivilegeTip.as:76`, `NewVipOpenView(202)` | conversion cost x `para1` / 100 ([../smith/README.md](../smith/README.md)) |
| 203 | `NewVipOpenView(203)` in `vehicle/daimontrial/DaimonTrialFrame.as:55` | artillery chest multiplier (0 in data) |
| 204 | `NewVipOpenView(204)` in `room/view/invite/QuickInviteFrame.as:144` | free cross server bugles per day |
| 205 | `pet/learnskill/PetLearnSkillView.as:829` | Einherjar skill learning time minus `para1` minutes |
| 207 | `childarena/ChildArenaSignFrame.as:396`; config `GuardPvp_AutoSign_VipGrade` 4 | auto sign up for the guardian arena |
| 208 | `ShopGoodsInfo.getDiscountByLevel` (`mvc/module/shop/ShopGoodsInfo.as:745-760`, value `para1 / 10`), `BuyFrameI.as:388`, `VipShopItem.as:151` | VIP shop price x `para1` / 100 (VIP shop disabled) |
| 209 | multiplayer map | extra daily reward count |
| other VIP gates | guild altar quick bless VIP >= 4 (`consortia/view/myConsortia/building/ConsortiaAltarFrame.as:242`) | [../guild/buildings.md](../guild/buildings.md) |

### VIP shop (disabled)
`VersionSwitch.VIPSHOP = false` (`decompiled/core_module/scripts/yishi/datas/VersionSwitch.as:260`): the VIP frame has no shop tab. When enabled it is ShopType 1033 (`ShopGoodsInfo.as:235`) priced in token 41 "Moeda Estelar", with `VipInfo.VipShopLevel` / `VipShopExp` ("Receba 1 EXP adicional a cada 1 Diamante obtido por Recarga") never filled by 4410. Not to implement.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/VipPrerogativeTempInfos.xml` | `VipPrerogativeTempInfo` (201 rows) | `id`; `name` pt-BR text with `{para1}`/`{para2}`; `type` privilege type; `grade` VIP level 1..9; `para1` value (0 = not owned); `para2` display slot; `para3` 1 = new at this level |
| `raw/xml/tempinfos/ConfigInfos.xml` | `Pet_BattleOver_Grade` 3, `GuardPvp_AutoSign_VipGrade` 4 | thresholds |

## 7. Persistent state

No table of its own: privileges are a pure function of `vip.memberships` and the template. Cached in memory as `HashMap<(type, level), Privilege>` loaded at boot from `VipPrerogativeTempInfos.xml`. VIP mount ownership is stored by [../mounts/README.md](../mounts/README.md); this module keeps only the last state pushed:

```sql
CREATE TABLE vip.privilege_states (
  player_id     BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  privilege     SMALLINT    NOT NULL,
  active        BOOLEAN     NOT NULL,
  changed_at    TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, privilege)
);
```

## 8. Backend implementation notes

- `vip::privileges::value(player_id, type) -> Option<i32>`: `None` unless VIP; looks up `(type, level)`; returns `para1` when non zero. All features call this instead of reading levels.
- `vip::privileges::min_level(type)`: lowest level with `para1 > 0` (mirror of VM:144-156) for error texts.
- `vip::privileges::on_membership_change(tx, player_id, old, new)`: computes toggles of state based privileges (19 mount, 3 auto sign in, 207 auto sign up), updates `vip.privilege_states`, and after commit pushes 4610 when 19 toggled and the hero is level >= 16. Also called when the hero reaches level 16.
- `vip::privileges::handle_custom_add` (8756): no-op, reply nothing (assumption).
- Daily auto actions run in the owners' daily jobs: auto sign in (3), guardian arena auto sign up (207).

## 9. Open questions and assumptions

- Data says type 15 (honor loss), 203 (artillery chest) give nothing at any level although UI texts advertise them; follow the data.
- Assumption: `para2` is only a display slot.
- Assumption: privilege 2 adds `para1` once per completed daily item; the original rule may be per day total.
- Open: privilege 20 server behavior (extra campaign chest content) is not in any template.
- Open: type 1 value 2 at level 9 implies a second castle skin variant.

## 10. Implementation checklist

- [ ] Screen: privilege frame lists per level text with substitutions and counts
- [ ] Screen: `NewVipOpenView` shows the minimum level and opens the VIP frame
- [ ] Route P1 8756 accepted
- [ ] Server message S1 4610 on mount privilege toggle (level >= 16)
- [ ] Server message S2 4648 not sent in this region
- [ ] Table `vip.privilege_states`
- [ ] Rule: privilege active only while VIP and `para1 != 0`
- [ ] Rule: friend limit 250 from VIP 3
- [ ] Rule: campaign EXP bonus by level
- [ ] Rule: free cooldown for VIP
- [ ] Rule: conversion discount 202 and Einherjar skill reduction 205
- [ ] Test: expired VIP loses free cooldown and the queue asks for diamonds again
- [ ] Test: VIP 4 can auto temper monster accessories, VIP 3 cannot
