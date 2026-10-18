# Sacrifice ("Sacrifício", 献祭, "Templo da eternidade")

Domain: pve. Client packages `sacrifice` (M11 frame `sacrifice.SacrificeFrame`, core model `mvc.module.sacrifice`, manager `yishi.manager.SacrificeManager`, controller `mvc.controler.SacrificeController` key `sacrifice`) and the sacrifice room map mediator `map.campaign.mediator.sacrifice`. Protobuf messages `active.SacrificeReqMsg` / `active.SacrificeRspMsg` (package `active`, owned by this feature in practice; `roadmap/features.json` lists no proto package).

The player offers a sacrifice item ("Oferta Iniciante", "Oferta Nv. Baixo", "Oferta Nv. Médio", "Oferta Nv. Avançado") at the altar. The altar then shows 5 reward items; the player chooses 1 of them ("em cada sacrifício pode escolher um entre 5 prêmios"). Before choosing he may refresh the 5 rewards for 15 diamonds. Higher offerings give better rewards. 3 sacrifices per day (VIP may raise it). Offerings are dropped by planes events and other activities.

All traffic: send 9543 (0x2547) `C_SACRIFICE_REQ`, receive 4962 (0x1362) `U_C_SACRIFICE_RSP`. No HTTP. PostgreSQL schema: `sacrifice`. Rust handlers: `sacrifice::altar::handle_<action>`.

Path aliases:

| Alias | Path |
|---|---|
| `SM` | `decompiled/core_module/scripts/yishi/manager/SacrificeManager.as` |
| `SMOD` | `decompiled/core_module/scripts/mvc/module/sacrifice/SacrificeModel.as` |
| `SC` | `decompiled/core_module/scripts/mvc/controler/SacrificeController.as` |
| `SF` | `decompiled/m11/scripts/sacrifice/SacrificeFrame.as` |
| `SRD` | `decompiled/m3/scripts/map/campaign/view/frame/SacrificeRoomDialogFrame.as` |

## Entry points

| Entry | Condition | Opens |
|---|---|---|
| "Sacrifício" button in the planes list of the "Transmissor" (`decompiled/m4/scripts/buildings/transferbuilding/view/PlanesListView.as:198-201`) | planes unlocked (level 55); badge shows `min(sacrifice_max_times - InfoTips[24], offerings owned)` (`PlanesListView.as:140-166`) | `SacrificeFrame` |
| Sacrifice room map 9995 NPC dialog (`decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as:315-318`, `SRD:17-28`, `decompiled/m3/scripts/map/campaign/CampaignMapController.as:871-874`) | inside campaign map 9995 | `SacrificeFrame` |

While the frame is open (`isInSacrificeFrame`) the HUD hides several buttons and room/team invites are refused (`SF:710-722`, `:729-753`).

## Modules

| Module | Content |
|---|---|
| [altar.md](altar.md) | Whole feature: op 1 open, op 4 sacrifice, op 2 refresh rewards, op 3 choose reward, push 4962 |

## Dependencies

- Offerings 2131121..2131124 (SonType 210) in the bag: [inventory](../inventory/README.md).
- Diamonds (refresh): [currency](../currency/README.md). VIP sacrifice count (prerogative type 201, unused path `SF:371-391`): [vip](../vip/README.md).
- Entry from [planes](../planes/README.md) and campaign map 9995 ([campaign](../campaign/README.md)).
- Info tips key 24 (remaining sacrifices badge).

## Suggested implementation order

1. Config loaders (`sacrifice_max_times`, `sacrifice_items_reward`, `sacrifice_fresh_diamond`) and reward pools.
2. Table `sacrifice.player_state`.
3. op 1 -> 4962, op 4, op 3, op 2.
4. Daily reset and info tips key 24 push.
