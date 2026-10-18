# Achievement limited-time gift packages

Feature `medals`, module `achievement-gifts`. Same opcodes as [achievements.md](achievements.md) (8671 / 4288 / 4289), ops 3 and 4. Config keys call it "成就限时礼包" (achievement limited-time gift package).

Conventions: see [README.md](README.md). `CM` = `core_module/scripts`.

---

## 1. Overview

- 214 achievements have `IsPopout = 1`. Completing one of them queues a discount package (`PackageName`, for example "Pacote de Gemas", "Pacote de Acessórios da Deusa") whose content and diamond price are in `AchievementTaskBuyDrop.xml` (rows with `site = achievement Id`).
- The offer pops up automatically in the space or castle scene, or from the queue bar pop button. When the gift frame is shown, the client tells the server (op 3) and the server answers with the remaining time; the offer lasts 60 minutes (`achievement_pushPackage_limitTimes`).
- The player buys with diamonds (op 4) or lets it expire. Offers are shown one at a time, oldest template id first, the running one at the head.

---

## 2. Screens

| Class (file) | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `heroroad.HeroRoadGiftFrame` (`m11/scripts/heroroad/HeroRoadGiftFrame.as`), 551x406, controller `heroroad` openType 2 with the `AchievementTaskInfo` as frame data (`CM/mvc/controler/HeroRoadControler.as:19-30, 38-41`) | no title; package name `PackageName` | Offer one package | Auto pop on scene entry (`m3/scripts/map/space/SpaceSceneController.as:522-526`, `m4/scripts/castle/CastleSceneView.as:382-386`) or on 4289 in those scenes (`CM/yishi/manager/HeroRoadManager.as:253-258`); queue bar `popBtn` (`CM/ui/queuebar/QueueBar.as:737-744`) | `PackageName`; item icons from `AchievementTaskBuyDrop` rows with `site = templateId` (`itemId`, `count`); price `para2`; "o pacote desaparecerá" (`HeroRoadGiftFrame.descTxt`); countdown `TimeDownView` fed by `currentLeftSecond` (`HeroRoadGiftFrame.as:176-227, 114-117`) |
| Queue bar `queueBar.popBtn` + `queueBar.countTime` (`CM/ui/queuebar/QueueBar.as`) | none | Re-open the running offer, show its countdown | Visible when level >= 11, `ACHIEVEMENT` on and `currentPopTemplateId > 0` (`:1020-1034`) | Remaining seconds (`setCountTime`, `:1045-1051`; refresh on `HEROROAD_ACHIEVEMENT_LIST_UPDATE`, `:679-693`); "Expirado" at 0 (`:705-722`) |
| Alert "Aviso" | "Quer usar {0} diamantes para comprar este pacote?" (`heroroad.HeroRoadGiftFrame.isBuy`) | Confirm purchase | Buy button (`HeroRoadGiftFrame.as:119-127`) | price |

---

## 3. Routes (client to server)

Opcode client → server **8671 (0x21df) C_ACHIEVEMENT_TASK_CLIENT_OP**, body `player.PlayerOpMsg` with `op (#1, INT32)` and `templateId (#8, INT32)` only (see [achievements.md](achievements.md) §3 for the full field list).

| # | UI control | Client sender (file:line) | Client checks, in order | Request | Expected response |
|---|---|---|---|---|---|
| G1 | Gift frame shown (any opening path) | `HeroRoadGiftFrame.show(info)` (`m11/scripts/heroroad/HeroRoadGiftFrame.as:267-276`) → `HeroRoadManager.popBuyFrame(templateId)` (`CM/yishi/manager/HeroRoadManager.as:411-418`) | `_data` not null | `{op=3, templateId}` | **4288** with `templateId` = this offer and `leftSecond` = remaining seconds (the frame countdown is only set from 4288, `HeroRoadGiftFrame.as:114-117`); `tasks` may be empty. Starts the 60 minute window on first display *(assumption)* |
| G2 | Buy button `heroRoadGiftFrame.getBtn` → confirm | `__getBtnHandler` (`:119-127`) → `buyOperate(true)` (`:129-156`) → `HeroRoadManager.buyPackage(templateId)` (`HeroRoadManager.as:401-409`) | 1. countdown already over → tip "Expirado" (`EquipTip.timeStr02`); 2. `playerInfo.point < price` → recharge prompt (`RechargeAlertMannager.show`); 3. less than 3000 ms since the previous buy → "Clique excessivo, tente novamente" (`activity.view.ActivityItem.command01`) | `{op=4, templateId}` | **4289** for that task with `isPopout=false`; diamond and bag pushes. The client already removed the offer locally (clears current offer, shifts the queue, closes the frame, `:150-153`) |
| G3 | Queue bar pop button | `QueueBar.__popBtnHandler` (`QueueBar.as:737-744`) | head of the queue poppable, scene is space or castle | none (opens the frame, which then sends G1) | as G1 |
| G4 | Close (X) | `__frameResponse` (`HeroRoadGiftFrame.as:257-265`) | none | none; the offer stays running, `count` stays 1 so it does not auto-pop again until bought or expired | none |

---

## 4. Server messages (server to client)

| Opcode | Name | Message | Client receiver (file:line) | When to send | Client reaction |
|---|---|---|---|---|---|
| 4288 (0x10c0) | U_C_ACHIEVEMENT_TASK_DATA | `AchievementTaskListMsg`: `templateId (#2, INT32)` running offer id; `leftSecond (#3, INT32)` seconds left; `tasks (#4, repeated)` optional here; `opType (#1)` unused | `HeroRoadManager.__achievenmentDataList` (`HeroRoadManager.as:143-194`) | Response to op 3; at login and on op 1 when an offer is running | Moves the task to the head of the queue, sets `currentPopTemplateId`, `currentLeftSecond`, shows the queue bar pop button and countdown (`:182-192`). **Precondition:** the task must already be known by the client (an earlier 4288 list or 4289), otherwise `indexOf(undefined)` is -1 and `splice(-1, 1)` drops the last queued offer (`:184-187`). When in doubt send the full `tasks` list in the same message |
| 4289 (0x10c1) | U_C_ACHIEVEMENT_TASK_UPDATE | `AchievementTaskMsg{templateId #1, data #2, isCompleted #3, isPopout #4, isReward #5}` | `HeroRoadManager.__achievenmentUpdate` (`:196-261`) | (a) on completion of an `IsPopout` achievement with `isPopout=true`; (b) after purchase with `isPopout=false`; (c) after expiry with `isPopout=false` *(assumption)* | (a) queues the offer and may auto-open the frame; (b)/(c) updates the flag; the queue bar hides the pop button when the queue is empty (`QueueBar.as:696-702`) |
| currency / bag | currency, inventory | diamonds debit, package items | | After op 4 | |

The client never sends anything on expiry: its own countdown hides the button, shifts the queue and resets the counters (`HeroRoadGiftFrame.as:158-167`, `QueueBar.as:705-722`). The next queued offer pops on the next scene entry or the next 4289.

No result codes; refusals are silent *(assumption: use the generic message tip)*.

---

## 5. Rules and formulas

- **Price** = `para2` of the BuyDrop rows with `site = templateId` (all rows of one site carry the same value; observed prices 100..1500 diamonds). Currency: diamonds (`playerInfo.point`, `HeroRoadGiftFrame.as:140`).
- **Content** = every BuyDrop row of the site: `itemId` x `count`, `isBind` (always 1), `validDate` (always 0 = permanent), `appearType` 1 (guaranteed) *(assumption)*.
- **Offer lifetime** = `achievement_pushPackage_limitTimes` = 60 minutes (`raw/xml/tempinfos/ConfigInfos.xml`). Counted from the first op 3 for that offer *(assumption; alternatively from completion)*.
- **Queue release** = `achievement_pushPackage_triggersNumb` = 1. Description: "when the number of achievement rewards claimed after logging in equals this value, push the whole gift queue again". Proposed behaviour *(assumption)*: offers completed while the player was offline or not yet shown stay `queued`; after the first achievement reward claim (op 2) of a session, send them (4289 `isPopout=true` or a 4288 list) so they pop.
- **One purchase per offer**; after purchase or expiry the offer is closed for good *(assumption: no re-offer)*.
- **Ordering**: the client sorts poppable offers by templateId ascending and pins the running one first (`HeroRoadManager.as:180, 245-252`).
- **Anti-spam**: client 3 s between buys (`HeroRoadManager.intervalTime`, `:408`; `HeroRoadGiftFrame.as:145-149`).

---

## 6. Templates

| File | Record meaning | Fields used |
|---|---|---|
| `raw/xml/tempinfos/AchievementTaskBuyDrop.xml` (360 rows, 214 sites), class `AchievementTaskBuyDropTemplateInfo`, lookup `getTemplatesByTaskId(site)` sorted by `id` (`CM/yishi/datas/templates/cate/AchievementTaskBuyDropTemplateCate.as`), loaded at `CM/yishi/manager/TempleteManager.as:1351` | One item of a gift package | `id`; `dropId` package group; `site` achievement Id; `para2` price in diamonds; `itemId`; `count`; `isBind`; `appearType`; `validDate`; `isShow` (unused by the client) |
| `raw/xml/tempinfos/AchievementTaskTemplates.xml` | Achievement | `IsPopout` (1 = has an offer), `PackageName` |
| `raw/xml/tempinfos/ConfigInfos.xml` | Server config | `achievement_pushPackage_limitTimes` = 60 (minutes); `achievement_pushPackage_triggersNumb` = 1 |

---

## 7. Persistent state (PostgreSQL, schema `medals`)

```sql
CREATE TABLE medals.achievement_gift_offers (
  player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  template_id   integer     NOT NULL,              -- achievement Id = BuyDrop site
  status        smallint    NOT NULL DEFAULT 0 CHECK (status BETWEEN 0 AND 3),  -- 0 queued, 1 running, 2 bought, 3 expired
  queued_at     timestamptz NOT NULL DEFAULT now(),
  started_at    timestamptz,                       -- first op 3
  expires_at    timestamptz,                       -- started_at + limitTimes
  closed_at     timestamptz,
  price_paid    integer     CHECK (price_paid IS NULL OR price_paid >= 0),
  PRIMARY KEY (player_id, template_id),
  FOREIGN KEY (player_id, template_id) REFERENCES medals.achievement_tasks(player_id, template_id) ON DELETE CASCADE
);
CREATE INDEX achievement_gift_offers_running ON medals.achievement_gift_offers (expires_at) WHERE status = 1;
CREATE UNIQUE INDEX achievement_gift_offers_one_running ON medals.achievement_gift_offers (player_id) WHERE status = 1;  -- assumption: one running offer at a time
```

`isPopout` on the wire = `status IN (0, 1)`.

---

## 8. Backend implementation notes

| Handler | Route | Validation order | Transaction and pushes |
|---|---|---|---|
| `medals::achievement_gifts::enqueue` (internal) | called by `medals::achievements::on_event` on completion when `IsPopout = 1` | template has BuyDrop rows | Insert `status 0`. If online: push 4289 `{isCompleted=true, isPopout=true}` |
| `medals::achievement_gifts::handle_open_offer` | 8671 op 3 | offer exists with status 0 or 1 → no other running offer of the player (or the same one) | Status 0 → 1, `started_at = now`, `expires_at = now + 60 min`. Reply 4288 `{templateId, leftSecond = expires_at - now, tasks = full list}` |
| `medals::achievement_gifts::handle_buy` | 8671 op 4 | offer status 1 (or 0, if the server accepts a buy before op 3 *(assumption)*) → `now < expires_at` → diamonds >= price → bag space | One tx: debit diamonds, grant items, status 2, `price_paid`. After commit: 4289 `{isPopout=false}`, currency and bag pushes |
| `medals::achievement_gifts::tick_expiry` | scheduled, every minute | status 1 and `expires_at <= now` | status 3; push 4289 `{isPopout=false}` to online players |
| `medals::achievement_gifts::on_reward_claimed` | hook from op 2 | session claim count == `triggersNumb` | Push 4289 `isPopout=true` for queued offers *(assumption, see §5)* |

- Purchases are diamond spending: log them in the economy ledger (recharge/currency feature).
- No battle, no push to other players.

---

## 9. Open questions and assumptions

- *(assumption)* The 60 minute window starts at the first op 3; the client's only source of `leftSecond` is the 4288 answer.
- *(assumption)* Exact meaning of `achievement_pushPackage_triggersNumb`.
- *(assumption)* Behaviour after expiry (no re-offer) and whether several offers may run in parallel (the client shows one countdown, so one running offer is assumed).
- Client fragility: 4288 with `templateId > 0` for a task unknown to the client corrupts the queue (§4). Always send the full list.
- Client fragility: a 4289 with `isPopout=false` does not remove the task from the client queue; the client removes the head itself on buy or expiry. If the server expires an offer earlier than the client countdown, the head stays non-poppable and blocks the queue until the client timer fires.

---

## 10. Implementation checklist

**Screens:**
- [ ] `HeroRoadGiftFrame` content, price, countdown, buy confirm, expired state
- [ ] Queue bar pop button and countdown
- [ ] Auto pop on space/castle scene entry and on 4289

**Routes:**
- [ ] 8671 op 3 start/refresh offer timer
- [ ] 8671 op 4 buy

**Server messages:**
- [ ] 4288 with `templateId`/`leftSecond` (+ full list)
- [ ] 4289 `isPopout` true on completion, false on purchase and expiry

**Tables:**
- [ ] `medals.achievement_gift_offers`

**Rules:**
- [ ] BuyDrop loader, price per site, item grant
- [ ] 60 minute window, expiry job
- [ ] Queue release after first reward claim

**Tests:**
- [ ] Buy without diamonds, after expiry, twice
- [ ] Two offers completed together: order and one running at a time
- [ ] Reconnect during a running offer: 4288 restores the countdown
