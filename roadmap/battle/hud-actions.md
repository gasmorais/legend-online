# Battle HUD actions: speed, skip and auto

Module `hud-actions` of the feature [Motor de batalha](README.md). Path prefixes as in [lifecycle.md](lifecycle.md); **UI** = `M10/battle/view/ui/BattleUIView.as`. Client detail: `docs/battle/hud.md` §2-§3 and §11 (HUD matrix per battleType).

## 1. Overview

The battle HUD gives the player few direct actions besides skills:

| Action | pt-BR | Server involvement |
|---|---|---|
| Speed | none: there is **no speed button**. `BattleQuickenControl` raises the animation step (1x..5x) when the measured FPS drops; the battle clock is unchanged | none |
| Skip / finish now | "Clique para pular batalha" (button `battle.petChallenge.finishNowBtn`) in battleTypes 16, 35, 307 | 8727: the server resolves the battle at once |
| Leave the War Tower | confirm "Deseja encerrar o desafio atual? Caso encerre, você não poderá entrar novamente na Torre da Guerra hoje." (button `battle.petChallenge.warsoulEndBtn`) in 3905 | 10497: the server ends the battle |
| Auto | auto button `battle.AutoFightBtn2` | 10020, see [ai-auto.md](ai-auto.md) |
| Hide others | "Ocultar unidades" (`battle.HideOthersBtn`) | none: local option `SharedManager.hideOthersInBattle` (`UI:1460-1468`) |
| Settings | "Configuração" (`battle.view.bottom.BottomBar.settingBtn.tipData`) | opens the `setting` frame ([../account/settings.md](../account/settings.md)) |
| Chat, message box | chat input, "Caixa de mensagens" | chat feature ([../chat/README.md](../chat/README.md)); battle chat uses channel 8 via 25024 in 10/308 |
| Debug win / lose | debug buttons, only with `StageReferance.isDebug` | 14002, see [lifecycle.md](lifecycle.md) L6 |

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `battle.view.ui.BattleUIView` (M10) | none | HUD root: bottom bar variant, buttons, top panels | `BattleSceneView` | per battleType layout (`docs/battle/hud.md` §11) |
| `_finishNowBtn` + `_stripView` in `BattleUIView` | "Contagem" N "segundos"; tooltip `BattleUIView.vip3` "Poderá usar se tiver VIP nv.3 ou acima" / `BattleUIView.vip3use` "Clique para pular batalha" | finish now | battleTypes 16 always; 35 and 307 with active VIP >= 3 (`UI:200-219`) | countdown N = `Imm_over_battle` / 1000 = 10 s |
| `_warsoulEndBtn` in `BattleUIView` | confirm text `battleUIView.warsoulTower.content.txt` | quit the War Tower | battleType 3905 (`UI:216-219`) | none |
| `battle.quicken.BattleQuickenControl` (CM) | none | FPS based animation acceleration | `BattleManager.setup` | none |

## 3. Routes (client to server)

### H1. Auto battle

See [ai-auto.md](ai-auto.md) route A1 (10020).

### H2. Finish now

| Item | Value |
|---|---|
| UI control | `battle.petChallenge.finishNowBtn`, enabled after the countdown |
| Client sender | `BattleUIView.__finishNowBtnClickHandler` (`UI:531-565`) -> `BattleSocketOuterManager.sendEndBattle` (`M10/battle/net/BattleSocketOuterManager.as:43-49`) |
| Client checks | button shown only in 16 (always) and 35/307 with VIP active and `VipGrade >= 3` (`UI:207-215`); enabled after `Imm_over_battle` ms (10 s) from HUD creation (`UI:222-307`); on click: 16 sends always; 35/307 send only with VIP >= 3; 307 also posts "A calcular a Força de Combate, por favor aguarde" (`battle.view.ui.BattleUIView.finishNowBtnClickTips`) to chat channel 3; the button is disabled afterwards; the client sets `isFinishNow = true` and ignores later 72 reinforcements |
| Route | C>S **8727 (0x2217) C_PET_CHALLENGE_END_BATTLE** |
| Request | `battle.BattleReqMsg`: `battleId (#2, STRING)` current battle; `userId (#1)`, `armyId (#3)`, `otherObj (#4)` unset |
| Expected response | the server simulates the rest of the battle instantly (or decides by combat power, as the 307 text says) and sends 154 then 4103 with the real result. No error message exists: on rejection send nothing |
| Owners | 16 arena ([battle-types.md](battle-types.md)); 35 [../einherjar/challenge-arena.md](../einherjar/challenge-arena.md); 307 casino monopoly |

### H3. Leave the War Tower

| Item | Value |
|---|---|
| UI control | `battle.petChallenge.warsoulEndBtn` then confirm |
| Client sender | `BattleUIView.__warsoulEndBtnClickHandler` / `callBack` (`UI:567-585`) -> `SocketSendManager.sendRemoveBattle` (`CM/yishi/service/managers/SocketSendManager.as:499-505`) |
| Client checks | battleType 3905; confirmation accepted |
| Route | C>S **10497 (0x2901) B_REMOVE_BATTLE** |
| Request | `battle.BattleReqMsg`: `battleId (#2, STRING)` |
| Expected response | the tower settles the floors reached, then 154 and 4103 (defeat) ([../trials/war-soul-tower.md](../trials/war-soul-tower.md)) |

## 4. Server messages (server to client)

None specific. The outcome of H2/H3 is the normal end sequence 154 + 4103 ([lifecycle.md](lifecycle.md) §4.5-§4.6). Spectators leaving receive 4803 (the client tries to disable `finishNowBtn` there, which throws and is swallowed: `CM/managers/BattleViewManager.as:165-178`).

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Speed (quicken) | every 10 frames `fps = 10000 / elapsed ms`; `step = clamp(5 - ceil(fps/5), 1, 5)`: fps >= 16 -> 1, 11-15 -> 2, 6-10 -> 3, 1-5 -> 4, 0 -> 5; applies only to effect and hero body animations | `CM/battle/quicken/BattleQuickenControl.as:46-111` |
| Battle clock | 25 fps fixed (`_addFrame = 1`, `setBattleFrameRate` never called): the server must not expect speed changes | `CM/battle/BattleManager.as:58, 175-188` |
| Finish now wait | `Imm_over_battle` = 10000 ms | `ConfigInfos.xml` |
| Finish now VIP | 35 and 307 need VIP active and grade >= 3; 16 no VIP | `UI:207-215, 531-565` |
| Finish now result | server side full simulation without real time pacing *(assumption)*; 307 by combat power *(assumption from text)* | `finishNowBtnClickTips` |
| War Tower quit | allowed any time in 3905; the tower closes for the day | `battleUIView.warsoulTower.content.txt` |
| Auto | see [ai-auto.md](ai-auto.md) | |
| Hide others | client only | `UI:1460-1468` |

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `Imm_over_battle` | `ConfigValue` = 10000 |
| `raw/xml/tempinfos/VipPrerogativeTempInfos.xml` | VIP privileges | owned by [../vip/README.md](../vip/README.md) (grade 3 gate is hard coded in the client) |

## 7. Persistent state

None.

## 8. Backend implementation notes

- **`battle::hud::handle_finish_now` (8727):** validate battle exists and is active, sender is a participant, battleType in {16, 35, 307}; for 35/307 the sender has active VIP grade >= 3 ([../vip/README.md](../vip/README.md)); at least `Imm_over_battle` ms since 156; not already finishing. Then run the actor in "fast forward" (simulate every remaining frame without sleeping, apply the time limit rule), then send 154 and 4103 as usual. Optionally skip sending the intermediate 153 stream (the client ignores reinforcements after finish now and the result handler waits only ~3 s) *(assumption: send only the final state)*.
- **`battle::hud::handle_remove_battle` (10497):** validate battleType 3905 and that the sender owns the battle; delegate settlement to `trials::war_soul_tower` (shared handler, see [../trials/war-soul-tower.md](../trials/war-soul-tower.md)); end the battle as a defeat with 154 + 4103.
- Speed: nothing to implement server side; keep the 40 ms frame and real time pacing.

## 9. Open questions and assumptions

1. How the original server resolved finish now (fast simulation vs combat power comparison).
2. Whether 8727 was accepted before the 10 s countdown (client side only gate).
3. `einherjar/challenge-arena.md` states `BattleReqMsg.battle_id (#1)`; the decompiled writer uses tag 2 for `battleId` (`CM/com/road/yishi/proto/battle/BattleReqMsg.as:119-134`).

## 10. Implementation checklist

- [ ] Route 8727 -> `battle::hud::handle_finish_now` (battleType, VIP, delay checks; fast forward)
- [ ] Route 10497 -> `battle::hud::handle_remove_battle` delegating to the War Tower
- [ ] Route 10020 (see ai-auto.md)
- [ ] Rule: no server side speed changes
- [ ] Test: finish now before 10 s is ignored; after 10 s ends the battle with the simulated winner
- [ ] Test: 35 without VIP 3 is ignored
- [ ] Test: 10497 outside 3905 is ignored
