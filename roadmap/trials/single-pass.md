# Single Pass, legacy ("Caminho do Paraíso")

Area: trials, module `single-pass`. Client package `singlepass` (`decompiled/m11/scripts/singlepass`), managers `managers.SinglePassManager` and `managers.SinglePassSocketOutManager`, model `mvc.module.singlepass.SinglePassModel`, controller key `singlepass` (`decompiled/core_module/scripts/mvc/controler/SinglePassFrameController.as`). Protos `tollgate.SinglePassMsg`, `player.ChallengeMsg`, `vip.VipRouletteMsg`.

Path aliases:

| Alias | File |
|---|---|
| SPM | `decompiled/core_module/scripts/managers/SinglePassManager.as` |
| SPO | `decompiled/core_module/scripts/managers/SinglePassSocketOutManager.as` |
| SP | `decompiled/m11/scripts/singlepass/` |

## 1. Overview

The first version of 天穹之径: floors ("Piso") of 10 stages each, a daily attack limit (`SinglePass_Count = 10`, extra attacks with item 3140001), a star judge per stage (best rating), floor rewards, and "Chifres do Paraíso" (bugles, item 3150001) earned every 5 stages and spent in a roulette ("bugle").

State of this build: dormant. `SinglePassManager.setup` (the only place that registers 4551..4554 listeners for this feature) is never called, and no UI path opens the controller key `singlepass` (only `DayGuideManager` reads `SinglePassManager.instance.model.count`, `decompiled/core_module/scripts/managers/DayGuideManager.as:269`). Opcodes 8636 and 4552 are now used by [sky-trial.md](sky-trial.md) with different messages. No server work is required for parity; this file keeps the protocol for reference.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from |
|---|---|---|---|
| `singlepass.SinglePassFrame` (`SP/SinglePassFrame.as`), 715 x 550, with `SP/view/SinglePassView`, `SinglePassCardView`, `SinglePassCardItemView`, `SinglePassBtnView` | floor title `singlepass.order.SinglePassView.TitleTxt` | 10 stage cards per floor, judge stars, attack, floor reward, bugle button | controller `singlepass` openType 1 (unreachable) |
| `singlepass.bugle.SinglePassBugleFrame` (`SP/bugle/`), 880 x 516 | | Bugle roulette | openType 2 |
| `singlepass.order.SinglePassOrderFrame` (`SP/order/`), 467 x 458 | "Ranking do Caminho do Paraíso" | Ranking from `{TPL}singlepass.xml` (`PathManager.getSinglePassOrderPath`, `decompiled/core_module/scripts/yishi/manager/PathManager.as:515`) | frame |

## 3. Routes (client to server)

| # | Control | Sender | Client checks | Route and message | Expected response |
|---|---|---|---|---|---|
| P1 | Frame open | `SPO.sendRequestSinglePassInfo` (`SPO:17-23`) from `SP/view/SinglePassView.as:87` | none | 8753 (0x2231) `C_TOLLGATE_REQUEST`, `player.ChallengeMsg`: `type` (#4, INT32) 0 | 4552 `SinglePassMsg` |
| P2 | Stage attack | `SPM.sendRequestSinglePassAttack(index)` (`SPM:130-176`) -> `SPO.sendRequestSinglePassAttack` (`SPO:25-32`) | daily count < `SinglePass_Count` or owns item 3140001 ("Limite de desafios do dia atingido"); `index <= maxIndex + 1` ("Favor concluir primeiro a fase anterior"); not max judge ("Você já atingiu a Avaliação Máxima nesta missão. Tente outra fase"); confirm "Deseja iniciar essa missão?" | 8755 (0x2233) `C_TOLLGATE_REQUEST_ATTACK`, `ChallengeMsg`: `type` (#4) 0, `tar_userId` (#1) stage index | battle 293 (assumption), 4552 |
| P3 | Next floor | `SPO.sendRequestUpdateArea` (`SPO:34-38`) from `SP/view/SinglePassView.as:261` | none | 8636 (0x21bc) `C_SKY_TRIAL` with no body | 4551 |
| P4 | Floor reward | `SPM.sendRequestGetAreaReward` (`SPM:178-190`) -> 8637 (0x21bd) `C_GET_AREA_REWARD`, no body | floor completed (`maxIndex == area x 10`, "Ainda não concluiu todas as fases deste Piso") | | 4552 |
| P5 | Get bugles | `SPO.sendRequestGetBugle` -> 8638 (0x21be) `C_GET_BUGLE`, no body (`SP/view/SinglePassView.as:243`) | | | 4552 `item_count` |
| P6 | Bugle roulette | `SPO.sendRequestBugleRoulette(leftCount, flag)` (`SPO:52-66`) -> 8639 (0x21bf) `C_BUGLE_ROULETTE`, `vip.VipRouletteMsg`: `left_count` (#1), `op_type` (#7) 0 or 1 | | | 4554 |
| P7 | Bugle open | `SPO.sendRequestBugleOpen` -> 8640 (0x21c0) `C_BUGLE_OPEN`, no body | | | 4553 |

## 4. Server messages (server to client)

| Opcode | Message | Receiver (never registered) |
|---|---|---|
| 4552 (0x11c8) `U_C_RES_SINGLEPASS_INFO` | `tollgate.SinglePassMsg`: `user_id` (#1), `area` (#2) current floor, `max_index` (#3) highest stage, `area_reward` (#4, STRING CSV) floor rewards taken, `rankInfo` (#5, repeated `RankInfoMsg`: `index` (#1) stage, `rank` (#2) judge), `count` (#6) attacks today, `item_count` (#7) bugles taken | `SPM.__resSinglePassInfoHandler` (`SPM:66-93`) |
| 4551 (0x11c7) `U_C_UPDATE_AREA` | empty | `SPM.__updateAreaHandler` (`SPM:62-64`, empty body) |
| 4553 (0x11c9) `U_C_BUGLE_REQ` | `VipRouletteMsg.leftItem` (#4, repeated `VipItemInfoMsg`: `temp_id` (#1), `count` (#2)) | `SPM.__bugleReqHandler` (`SPM:107-115`) |
| 4554 (0x11ca) `U_C_BUGLE_REWARDS` | `VipRouletteMsg`: `need_vipItem` (#2), `left_count` (#1), `openIndex` (#3, repeated), `leftItem` (#4) | `SPM.__bugleRewardsHandler` (`SPM:117-128`) |

## 5. Rules and formulas

- `SinglePass_Count = 10` attacks per day; extra attacks use item 3140001.
- Bugles: `floor(maxIndex / 5) x bugleCount - itemCount` available (`SPM:87`).
- Floor = 10 stages; floor reward requires all 10.
- Stage data from `GodArrive` templates (`godArriveTemplateCate.getGodArriveData(40001, tollgate)`, `SPM:153`).

## 6. Templates

`raw/xml/tempinfos/ConfigInfos.xml` `SinglePass_Count`; GodArrive templates for stage suggestions; `SinglePassAreaRewardTemplateCate`, `SinglePassBossRewardTemplateCate` (`decompiled/core_module/scripts/yishi/datas/templates/cate/`).

## 7. Persistent state

None (dormant).

## 8. Backend implementation notes

Do not implement. Opcode 8636 must be routed to `trials::sky_trial` and 4552 must carry `SkyTrialInfoMsg`.

## 9. Open questions and assumptions

- Whether any server build still answers 8753/8755 is unknown; the current client never sends them.

## 10. Implementation checklist

- [ ] Confirm no route reaches controller `singlepass` (keep dormant)
- [ ] Ensure 8636 and 4552 are owned by the sky trial handler
