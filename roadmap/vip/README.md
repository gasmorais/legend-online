# VIP and privileges ("VIP e privilégios")

Paid membership and the paid welfare packs around it. A player buys VIP time with diamonds (1, 3 or 6 months, for himself or for a friend), accumulates growth points ("Valor de crescimento") that set the VIP level 1 to 9, and gets level based privileges ("Privilégio VIP") used all over the client: free cooldowns, extra activity points, campaign EXP, friend limit, shop and conversion discounts, VIP mount, auto sign in, weekly pack ("Pacote Semanal VIP") and the VIP roulette ("Roleta VIP"). Around it sit the diamond packs of the same registry entry: customized VIP pack ("Pacote personalizado VIP"), month card ("天天大礼包", daily pack), newbie privilege ("Privilégio de Novatos"), level up support ("Apoio de Elevação") and the dormant 360 privilege pack.

All traffic is socket based. Several packs share the multiplexed request 9645 `C_CCCACTIVE_CLIENTOP` with `extend1` selecting the pack (29 month card, 41 customized VIP). PostgreSQL schema: `vip`. Rust handlers: `vip::<module>::handle_<action>`.

Registry note: `bag360_vip` does not exist as a client package. The `bag360` package (registry: [../inventory/README.md](../inventory/README.md)) is the 360 platform privilege pack and uses this feature's `privilege` proto package, so it is documented here in [privilege-360.md](privilege-360.md).

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| HUD resource bar "Ativar VIP" (not VIP) or "VIP Comum" (VIP) button (`decompiled/core_module/scripts/ui/resourcebar/view/ResourceView.as:456-469, 760-763`) | always | `vip` frame "Recarga VIP" ([membership.md](membership.md)) |
| Task trace tips 21 "Elevar VIP", 22 "Coletar pacote VIP", 23 "Ativar VIP" | pushes 4410 / 4416 | VIP frame, privilege frame or gift frame |
| `NewVipOpenView(type)` link inside feature frames (cooldowns, conversion, Einherjar skills, PvP honor) | privilege not owned | VIP frame ([privileges.md](privileges.md)) |
| Use item "Moeda VIP" 208015 (SonType 292) in the bag | not in mop up | VIP roulette ([roulette.md](roulette.md)) |
| Top toolbar "customizedvip" (template 2064) | hero level > 1 and activity open (4590 `param1` 2064) | [customized-vip.md](customized-vip.md) |
| Top toolbar "monthcard" (template 2051) | `VersionSwitch.MONTH_CARD` and 175 `isOpen` | [month-card.md](month-card.md) |
| Top toolbar "registwelfare" (template 2001) | hero level >= 6 and newbie privilege end date in the future | [regist-welfare.md](regist-welfare.md) |
| Queue bar "upgradepresent" button | `VersionSwitch.UPGRADE_PRESENT` and at least one pack buyable | [upgrade-present.md](upgrade-present.md) |

## Modules

| Module | Content |
|---|---|
| [membership.md](membership.md) | VIP frame, open and renew (self 8513), gift VIP to a friend (8513), VIP info 4410, expiry tip 4416, guild VIP broadcast 4455, growth points, levels, expiry decay |
| [privileges.md](privileges.md) | Privilege templates (23 types x 9 levels), where each one is applied, privilege frame, `NewVipOpenView`, VIP mount 4610, disabled VIP shop, VIP customer service 4648 / 8756 |
| [weekly-gift.md](weekly-gift.md) | "Pacote Semanal VIP": 8505, `VipDrop` per level, weekly availability flag |
| [roulette.md](roulette.md) | "Roleta VIP": open with Moeda VIP 8521, spin 8519 single or all, 4414 / 4415 |
| [customized-vip.md](customized-vip.md) | "Pacote personalizado VIP": 9645 extend1 41 ops 0..2, 4277, free daily VIP box, choose one item per area, daily buy limits |
| [month-card.md](month-card.md) | Daily pack month card: 9645 extend1 29 ops 1..3, 175, mail on unclaimed day |
| [regist-welfare.md](regist-welfare.md) | "Privilégio de Novatos": discounted chain packs 9561 (261), newbie tasks with paid extra reward 9564 (265, 266), extra fields 260 |
| [upgrade-present.md](upgrade-present.md) | "Apoio de Elevação": level gated diamond packs (ShopType 1013) bought through 8970, state 176 |
| [privilege-360.md](privilege-360.md) | 360 platform privilege pack: 8723 / 8722 / 4543, dormant in this build |

## Dependencies

- [../currency/README.md](../currency/README.md): every pack is paid in diamonds through `currency::spending::spend`; VIP growth comes from `currency::spending::on_consumption`.
- [../recharge/README.md](../recharge/README.md): "Diamante insuficiente, recarregar?" leads to the recharge page.
- [../friends/README.md](../friends/README.md): friend list for VIP gifts and the friend limit privilege (200 + 50).
- [../guild/README.md](../guild/README.md): guild member VIP icons (4455), altar quick bless needs VIP 4.
- [../shops/README.md](../shops/README.md): upgrade present packs are shop items (8970 / 4783); VIP shop discount privilege 208.
- [../mail/README.md](../mail/README.md): rewards that do not fit the bag and unclaimed month card days.
- [../mounts/README.md](../mounts/README.md): VIP exclusive mount (4610).
- [../daily-activity/README.md](../daily-activity/README.md): activity point bonus (privilege 2) and auto sign in (3).
- [../inventory/README.md](../inventory/README.md): Moeda VIP item 208015, drops granted to the bag.
- Feature consumers of privileges: [../cosmos/README.md](../cosmos/README.md), [../einherjar/README.md](../einherjar/README.md), [../monsters/README.md](../monsters/README.md), [../smith/README.md](../smith/README.md), [../army/README.md](../army/README.md).

## Suggested implementation order

1. `vip.memberships` and 4410 at login; growth job and expiry ([membership.md](membership.md)).
2. Open and renew 8513 for self, then gift to a friend.
3. Privilege lookup service `vip::privileges::value(player, type)` used by other features ([privileges.md](privileges.md)).
4. Weekly gift 8505, then roulette 8521 / 8519.
5. Packs: month card, customized VIP, upgrade present, newbie privilege.
6. 360 privilege only if the platform switch is needed.
