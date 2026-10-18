# Hall of fame ("Hall de Fama")

Feature `medals`, module `hall-of-fame`. Client package `hallfame` (`m11/scripts/hallfame/*`, transpiled `build/as3/gen/hallfame/*`). The hall of fame has **no protocol of its own**: it is the sum-active ("精彩活动", funny) activity of `active_type = 146`, served by the generic sum-active engine of [../seasonal-events/README.md](../seasonal-events/README.md) (opcodes 8586 / 4475 / 4476 / 4714, proto package `active`). This file documents the generic messages only as far as type 146 needs them, and the type 146 rules.

Conventions: see [README.md](README.md). `CM` = `core_module/scripts`.

---

## 1. Overview

- A rare, time-limited event (help: "Hall da fama é um evento raro, por favor participe"). The event defines several prize tiers; each tier requires a fight power ("poder") threshold. When the player's power reaches a tier, the prize can be collected once during the event.
- The frame lists tiers by threshold (highest first), shows the selected tier's rewards (featured rewards on top, the rest below), previews featured mounts in 3D (`MountsAvatarView`, paged) and lets the player try on fashion rewards.
- Help (`hallfame.helpFrame.helpContent`, summarized): you cannot collect until your power reaches the requirement; it is a rare event; you can preview the rare rewards; each prize can be collected once during the event; potions, scrolls and buffs that raise power temporarily do not count as effective battle power.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `hallfame.HallFameFrame` (`m11/scripts/hallfame/HallFameFrame.as`), 660x493, controller `hallfame` (`CM/mvc/controler/HallFameController.as:19-38`; UI assets of module `funny` are loaded with it, `CM/yishi/manager/FrameControllerManager.as:1118-1119`) | "Hall de Fama" (`hallfame.title`) | Event frame | Top tool bar button `hallfame` (TopToolBtnInfo 2038, tip "Evento do corredor da fama", `CM/ui/toptoolbar/TopToolsBar.as:1260-1266`) | Left list of tiers, right view, help button (`hallfame.helpFrame`) |
| `hallfame.views.HallFameLeftButton` (`m11/scripts/hallfame/views/HallFameLeftButton.as`) | "poder {0} pode coletar" (`hallfame.views.contentTxt`, `{0} = conditionList[0].value`), hint "clique para verificar prêmio" | One tier, selectable | Frame left VBox, one per package of the type 146 activity sorted by threshold descending (`CM/mvc/module/funny/FunnyModel.as:399-425`) | "get" icon visible when `status == 1` and inside the claim window (`HallFameLeftButton.as:78-107`). Frame index `1..n` selects the button art (`:32-47`) |
| `hallfame.views.HallFameRightView` (`m11/scripts/hallfame/views/HallFameRightView.as`) | "Hora do Evento: {0} -- {1}" (`funny.newyearact.NewYearPayActView.actTimeTxt`) | Event time, player power, mount preview | Selection change | Claim window `begin_date`..`end_date`; `finishNum` (ActiveData `value`) drawn with digit bitmaps next to the power label (`:176-187`); mount preview pages built from every featured reward (`bak..bak4`) whose item has SonType 218, mapped through `Property1` to `MountTempInfos` (`:82-127`), prev/next buttons (`:141-162`) |
| `hallfame.views.HallFameBagItem` (`m11/scripts/hallfame/views/HallFameBagItem.as`) | collect button, "received" stamp, try-on button | Rewards and claim | Inside the right view | Reward icons of `rewardList` entries with `temType == 1` (count, bind, strengthen grade); featured items (ids in `bak..bak4`) in the top row, others in the bottom row; light effect for items with `Profile >= 5` (`:74-161`). State by `status` (`:178-241`) |
| Fashion try-on (shop controller openType 9) | shop preview | Preview fashion rewards (SonType 109, 111, 112, 110) | `funnyRewardItem.wearBtn` (`HallFameBagItem.as:277-318`) | Buying is blocked: "Moda de evento não pode ser comprado" (`funny.view.FunnyBagItem.cannotBuy`) |

---

## 3. Routes (client to server)

Opcode client → server **8586 (0x218a) C_SUMACTIVE_GATE**, body `active.SumActiveGetPackageMsg`, sender `FunnyManager.sendGetBag(type, activeId = "", packageId = "", count = 1)` (`CM/managers/FunnyManager.as:969-978`). All four fields are assigned, so all are on the wire.

| Field | Tag | Type | Repeated | Meaning |
|---|---|---|---|---|
| `activeId` | #1 | STRING | no | Activity id (`SumActiveinfoMsg.active_id`); "" for type 1 |
| `packageId` | #2 | STRING | no | Package id (`SumActivePackageMsg.packageId`); "" for type 1 |
| `type` | #3 | INT32 | no | 1 query user data of all activities, 2 claim a package (3 and 4 are used by other activity types) |
| `count` | #4 | INT32 | no | Claim count, always 1 here |

| # | UI control | Client sender (file:line) | Client checks | Request | Expected response |
|---|---|---|---|---|---|
| H1 | Tool bar button `hallfame` | `TopToolsBar` case `hallfame` (`CM/ui/toptoolbar/TopToolsBar.as:1260-1266`) | button visible only when `findDataByType(146)` returns an activity inside its show window and the scene is castle or space (`CM/ui/toptoolbar/TopBtnCheckShowHelper.as:345-346, 506-513`); opens only if the activity exists | none (opens the frame) | none |
| H2 | Frame opens | `HallFameFrame()` constructor (`m11/scripts/hallfame/HallFameFrame.as:43-51`) | none | `{type=1, activeId="", packageId="", count=1}` | **4476** `SumActiveDataMsg` with the user state of every activity, including type 146 |
| H3 | Collect button `HallFameBagItem.getBtn` (visible and enabled only when `status == 1` and inside the claim window) | `HallFameBagItem.__clickHandler` (`HallFameBagItem.as:262-275`) | 1. not inside `begin_date < now < end_date` → "Evento expirado" (`feedback.FeedBackItem.outDate`); 2. `end_date <= now` → same tip | `{type=2, activeId, packageId, count=1}` | **4476** with the package `status = 2`; bag pushes for the rewards |
| H4 | Tier selection, mount pages, try-on, help | client only | none | none | none |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver (file:line) | When to send | Client reaction |
|---|---|---|---|---|---|
| 4475 (0x117b) | U_C_SUM_ACTIVE_TEMP | `active.SumActivesMsg`: `actives (#1, SumActiveinfoMsg, repeated)`, `dataStamp (#2, INT32)` version (a higher value clears the cache), `curPage (#3, INT32)`, `maxPage (#4, INT32)` | `FunnyManager.__funnyTemHandler` (`CM/managers/FunnyManager.as:152, 409-641`) | Login and whenever the activity configuration changes (seasonal-events engine), paged | Activities whose `stop_time` is past are dropped (`:445`). Type 146 goes to `otherList[146]` (`:580`, `FunnyModel.isOtherType`, `FunnyModel.as:450-462`). After the last page (`count >= maxPage`) the client itself sends 8586 type 1 (`:639`) |
| 4476 (0x117c) | U_C_SUMACTIVE_DATA | `active.SumActiveDataMsg{datas (#1, ActiveData, repeated)}` | `FunnyManager.__funnyUserHandler` (`FunnyManager.as:153, 643-788`) | Response to 8586 type 1 and type 2; push when the player's state changes (here: a tier becomes claimable) | Matches each `ActiveData` by `(type, activeId)` (`:668`); sets `finishNum`, package `status`; type 146 is excluded from the "something to collect" glow (`:690`); fires `REFRESH_ITEM`, the hall frame redraws (`HallFameFrame.as:96-105`) |
| 4714 (0x126a) | U_C_CONSUME_RES | same `SumActiveDataMsg`, same handler (`FunnyManager.as:154`) | | Used by other activity types (consumption); not needed for type 146 | same |
| bag pushes | inventory | reward items | | After a claim | |

Fields used by type 146 (all tags checked in `build/as3/gen/com/road/yishi/proto/active/*.ts`):

| Message | Field (tag, type) | Type 146 meaning |
|---|---|---|
| `SumActiveinfoMsg` | `active_id (#1, STRING)` | Activity id |
| | `begin_date (#2, STRING "YYYY-MM-DD hh:mm:ss")`, `end_date (#3, STRING)` | Claim window (`startTime`, `endTime`) shown as "Hora do Evento" |
| | `title (#4)`, `detail (#5)`, `condition_detail (#6)`, `getway (#7, INT32)`, `order (#12)`, `appendParam (#13)`, `isInitiate (#14)` | Stored by the engine, not shown by the hall frame |
| | `packages (#8, SumActivePackageMsg, repeated)` | Tiers |
| | `active_type (#9, INT32)` | **146** |
| | `start_time (#10, STRING)`, `stop_time (#11, STRING)` | Show window (tool bar button visibility, `FunnyModel.findDataByType`, `FunnyModel.as:125-142`) |
| `SumActivePackageMsg` | `packageId (#1, STRING)`, `order (#2, INT32)` | Tier id; order unused (the hall sorts by threshold) |
| | `items (#3, SumActiveItemInfoMsg, repeated)` | Rewards: `template_id (#1)`, `template_type (#2)` must be 1 to be displayed, `count (#3)`, `isbind (#4, BOOL)`, `length (#5)` strengthen grade, `job (#6)` |
| | `conditions (#4, PackageConditionMsg, repeated)` | Only `conditions[0]` is read: `condition_id (#1)` unused; `condition_value (#2)` = power threshold; `condition_bak (#3)`, `condition_bak2 (#4)`, `condition_bak3 (#5)`, `condition_bak4 (#6)` = up to four featured reward template ids (0 = none) |
| `ActiveData` | `activeId (#3, STRING)`, `type (#5, INT32 = 146)` | Match key |
| | `value (#2, INT32)` | Player power shown in the right view (`finishNum`) |
| | `packdata (#1, PackageData, repeated)` | One per tier |
| | `is_show (#4)`, `activeCharge (#6)`, `consumeMsg (#7)` | Unused for 146 |
| `PackageData` | `packId (#1, STRING)`, `status (#2, INT32)` | Status: 1 claimable, 2 collected, 3 not reached |
| | `countDown (#3)`, `is_show (#4)`, `param1 (#5)`, `finish_value (#6)`, `get_count (#7)` | Unused for 146 |

Client states by `status` (`HallFameBagItem.as:178-241`):

| status | Rewards | Collect button | Try-on | Left icon |
|---|---|---|---|---|
| 1 | normal | visible, enabled only inside the claim window | enabled | shown inside the claim window |
| 2 | greyed, "received" stamp | hidden | hidden | hidden |
| 3 | normal | visible, disabled | enabled | hidden |
| other (0) | **unchanged from the previous state** (no default branch) | | | |

So the server must send a `PackageData` with status 1, 2 or 3 for **every** tier of the type 146 activity.

No error code: a refused claim returns the unchanged 4476 *(assumption: plus a generic message tip)*.

---

## 5. Rules and formulas

- Activity windows: show window `start_time..stop_time` (button and frame), claim window `begin_date..end_date` (collect) (`HallFameBagItem.as:243-255`, `HallFameLeftButton.as:99-107`).
- Tier status: `2` if collected; else `1` if `effective_power >= condition_value` and inside the claim window; else `3`.
- `effective_power` *(assumption)*: the player's fight power without temporary buffs, potions and scrolls (help item 5). Whether it is the current value or the best value reached during the event is not visible; recommended: best value reached during the claim window, so a later loss of power does not remove an unlocked tier. `ActiveData.value` sends that same number.
- Each tier can be collected once per activity (help item 4). Claim grants every `items` entry (`template_type == 1` are items; other `template_type` values are not displayed by this frame and should not be used for 146 *(assumption)*).
- Featured rewards: ids in `bak..bak4` are drawn in the top row and feed the mount preview when SonType 218.
- Ordering: tiers sorted by `condition_value` descending (`FunnyModel.as:414-425`).
- Not shown in the "anything to collect" glow (`FunnyManager.as:690`).

---

## 6. Templates

No XML template: the activity, its tiers and rewards come from the server's sum-active configuration (seasonal-events admin data). Client-side lookups:

| File | Use |
|---|---|
| `raw/xml/tempinfos/ItemTempInfos.xml` | Reward icons, `Profile >= 5` light effect, SonType 218 mount items (`Property1` = mount template), SonType 109/110/111/112 fashion slots |
| `raw/xml/tempinfos/MountTempInfos.xml` | Mount preview (`TempleteManager.mountTemplateDic[Property1]`) |
| `raw/xml/tempinfos/ShopTempInfos.xml` | Try-on preview (`getShopTempInfoByItemId`) |
| `raw/xml/tempinfos/TopToolBtnInfos.xml` | Button `hallfame`, TemplateId 2038, Sort 2038 |

Proposed configuration shape for one hall of fame event *(assumption)*: one sum-active row `active_type = 146`, N packages, each with one condition `{condition_value = power threshold, bak..bak4 = featured items}` and reward items.

---

## 7. Persistent state (PostgreSQL, schema `medals`)

The activity definition and the generic claim ledger belong to the sum-active engine (seasonal-events). If that feature already provides a generic per-package claim table, use it and keep only `hall_of_fame_progress` here.

```sql
CREATE TABLE medals.hall_of_fame_progress (
  player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  active_id     text        NOT NULL,              -- SumActiveinfoMsg.active_id of the type 146 activity
  best_power    bigint      NOT NULL DEFAULT 0 CHECK (best_power >= 0),
  updated_at    timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, active_id)
);

CREATE TABLE medals.hall_of_fame_claims (
  player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  active_id     text        NOT NULL,
  package_id    text        NOT NULL,
  power_at_claim bigint     NOT NULL,
  claimed_at    timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, active_id, package_id)
);
CREATE INDEX hall_of_fame_claims_active ON medals.hall_of_fame_claims (active_id);
```

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `medals::hall_of_fame::build_active_data` | called by the sum-active engine when answering 8586 type 1 (or pushing 4476) for an activity of type 146 | activity in show window | Read only: `value = best_power` (clamped to INT32), one `PackageData{packId, status}` per package (§5) |
| `medals::hall_of_fame::handle_claim` | 8586 type 2 routed by the engine when the activity type is 146 | activity exists and type 146 → `begin_date < now < end_date` → package belongs to the activity → not already claimed → `best_power >= condition_value` → bag space | One tx: insert claim, grant items. After commit: 4476 with this activity's `ActiveData`, bag pushes |
| `medals::hall_of_fame::on_power_changed` | hook from the hero power calculator | an activity of type 146 is in its claim window | Update `best_power` if higher (excluding temporary buffs). If a tier crosses its threshold, push 4476 for this activity to the online player |

- No battle, no schedule (the windows are evaluated on read), no push to other players.
- Power can change very often; debounce the 4476 push to threshold crossings only.

---

## 9. Open questions and assumptions

- *(assumption)* Current power vs best power during the event; best power recommended.
- *(assumption)* Which power counts (help says temporary consumables do not); the exact exclusion list belongs to the hero power calculator.
- *(assumption)* Status 3 for "not reached"; the client has no default branch, so a missing status keeps stale UI.
- The tier button art has a finite number of frames (`hallfame.views.back`, `setFrame(index)`); the maximum tier count is not visible in the code (asset dependent).
- `docs/ui/navigation.md:254` lists sends 8294 and 9647 for `hallfame`; the hall frame code does not send them (only 8586 type 1 and 2 were found). Treat that row as unrelated.
- `HallFameRightView.initData` reads `findDataByType(146)` without a null check (`HallFameRightView.as:87-89`); the frame must never open without the activity (the tool bar already guards it).

---

## 10. Implementation checklist

**Screens:**
- [ ] Tool bar button visibility (type 146 in show window, castle or space scene)
- [ ] `HallFameFrame` tiers sorted by threshold, help
- [ ] `HallFameRightView` event time, power digits, mount preview paging
- [ ] `HallFameBagItem` featured and normal rows, three states, try-on

**Routes:**
- [ ] 8586 type 1 includes type 146 data (engine)
- [ ] 8586 type 2 claim for type 146

**Server messages:**
- [ ] 4475 contains the type 146 activity with packages, conditions and items
- [ ] 4476 with `value` and a status for every tier
- [ ] 4476 push on threshold crossing

**Tables:**
- [ ] `medals.hall_of_fame_progress`
- [ ] `medals.hall_of_fame_claims` (or the engine's generic claim table)

**Rules:**
- [ ] Effective power without temporary buffs
- [ ] Claim window and one claim per tier

**Tests:**
- [ ] Claim before threshold, after end_date, twice
- [ ] Power drop after unlocking keeps the tier claimable (if best power is chosen)
- [ ] Missing activity: no button, no frame
