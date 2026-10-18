# Navigation ("Mistério de Navegação")

Domain: world. Client packages `navigation` (M11 frames), `mvc.module.navigation` (model), `managers.NavigationManager`; the shop frame lives in M15 (`view.subshop.NavigationShopFrame`). Protobuf messages are in package `pet` (`Navigation*Msg`), which is why `roadmap/features.json` lists no proto package for this feature.

The player owns up to 5 ships ("Navio") and 3 ports ("Porto do Céu", "Porto do Amanhecer", "Porto Azul"). Ports offer trade missions: the player delivers resources or items (multiplied 1..N times) and sends an idle ship on an expedition; on return he earns "Moedas de Navegação". Coins upgrade ships (shorter expeditions) and ports (more mission slots, bigger multipliers) and buy items in the "Loja de Navegação". Ship upgrades take hours and online friends can be invited to speed them up. At fixed times of day ships can also go fishing for periodic rewards. Expeditions and assists cost "pontos de movimento" (strength, 100 per day).

All traffic is socket based: one request opcode 9600 (0x2580) `C_NAVIGATION` with an `op` enum, and pushes 341, 342, 343, 178. No HTTP. PostgreSQL schema: `navigation`. Rust handlers: `navigation::<module>::handle_<action>`.

Path aliases used in every module:

| Alias | Path |
|---|---|
| `NM` | `decompiled/core_module/scripts/managers/NavigationManager.as` |
| `NMOD` | `decompiled/core_module/scripts/mvc/module/navigation/NavigationModel.as` |
| `NAV` | `decompiled/m11/scripts/navigation/` |
| `SHOP` | `decompiled/m15/scripts/view/subshop/` |
| `CFG` | `decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as` |
| `BM` | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| "Residência" frame (`CastleBuildingView.FarmEnterNewFrame`), ship button "Mistério de Navegação" | `VersionSwitch.NAVIGATION` (true) else "Função de navio ainda não ativado"; hero level >= 80 else "Função habilitada no Nv. 80" (`decompiled/m3/scripts/farm/FarmEnterNewFrame.as:152-166`) | controller `navigation` openType 1 -> `NavigationFrame` |
| Daily guide item 66 | hero level >= 80 (`decompiled/core_module/scripts/managers/DayGuideManager.as:839-846`) | same |
| HUD queue bar order 4 (free ports `n/3`) | order active (`decompiled/core_module/scripts/yishi/manager/QueueBarManager.as:425-469`) | `decompiled/core_module/scripts/ui/queuebar/QueueBar.as:264-266` -> openType 1 |
| Friend invitation popup (push 343) | not in battle (`BM:3068-3088`) | `NavigationInviteAssistFrame` ([boats.md](boats.md)) |

Controller `decompiled/core_module/scripts/mvc/controler/NavigationControler.as:14-45`: openType 1 `NavigationFrame`, 2 `NavigationBoatFrame`, 3 `NavigationPortFrame` (frame data = port index 1..3), 4 `NavigationInviteFrame` (data = ship), 5 `NavigationBoatPreviewFrame`, 6 `NavigationBoatPatrolFrame` (data `{type: 11|16, data, taskList, numList}`), 7 `NavigationBoatPatrolFrameII` (multi ship fishing). The shop is controller `shop` openType 9001 (`decompiled/core_module/scripts/mvc/controler/ShopControler.as:143`).

## Modules

| Module | Content |
|---|---|
| [hub.md](hub.md) | Main frame, state push 342 (`NavigationMsg`), result push 341, op enum, strength and its purchase (op 8), daily reset |
| [boats.md](boats.md) | Ships: activate slot (op 0), upgrade (op 3), invite friends (op 4, push 343), assist (op 5), level preview, ship states |
| [ports.md](ports.md) | Port trade missions: refresh quality (op 9), refuse (op 10), send expedition (op 11), port upgrade (op 19), pay to skip cooldown (op 20) |
| [shop.md](shop.md) | "Loja de Navegação": 6 random offers, buy (op 14), free/paid refresh (op 15) |
| [fishing.md](fishing.md) | Ship fishing windows (push 178), send ships fishing (op 16), reward ticks (ops 17, 18) |

## Dependencies

- Friends list and online state for invitations: [friends](../friends/README.md).
- Diamonds (real and bound), gold, Espírito, Cristal de Luz and bag items consumed by missions: [currency](../currency/README.md), [inventory](../inventory/README.md).
- "Residência" frame: [farm](../farm/README.md). Queue bar and daily guide: HUD (account/hero).
- The separate "Pesca" feature is [fishing](../fishing/README.md); ship fishing here is independent.

## Suggested implementation order

1. Tables, template loaders (`UpGradeTempInfos.xml` Types 118 and 161, `NavigationTaskTempInfos.xml`, `NavigationShopTempInfos.xml`, config keys `navigation_*`).
2. [hub.md](hub.md): build and push 342 at login and after every op; 341 result; strength purchase; daily reset.
3. [ports.md](ports.md) and the expedition timer (needs ships from [boats.md](boats.md)).
4. [boats.md](boats.md): activation, upgrade timer, invitations and assists.
5. [shop.md](shop.md).
6. [fishing.md](fishing.md) with its scheduler.
