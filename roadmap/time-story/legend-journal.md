# Legend journal ("Jornal Legend")

Module `legend-journal` of feature `time-story`.

Path aliases:

| Alias | File |
|---|---|
| TSC | `decompiled/core_module/scripts/mvc/controler/TimeStoryControler.as` |
| TSM | `decompiled/core_module/scripts/mvc/module/timestory/TimeStoryModel.as` |
| TSF | `decompiled/m11/scripts/timestory/TimeStoryFrame.as` |
| UBV | `decompiled/m11/scripts/timestory/UpdateBroadcastView.as` |

## 1. Overview

A paged newspaper ("神曲时报", shown as "Edição {0}"). Content is the XML `{TPL}gametimes.xml` (`PathManager.timeStoryPath`, `decompiled/core_module/scripts/yishi/manager/PathManager.as:468-471`) with modules (`modulename` 1..n, `totalpage`, `page@res` image paths). Module 1 gets an extra first page, the update broadcast (`UpdateBroadcastView`, from `BaseManager.updateBroadcastContent`). Page content may hold links: buy (quick buy), shop, goto attribute / fashion (level 10) / title "appell" (level 30), convert (opens `funny`). Turning pages reports progress to the server, which may drop an egg ("Ao ler o Jornal Legend poderá receber Ovos"); clicking the egg (or 7 s timeout) claims it.

Status: controller `timestory` has no opener in this client. `FunnyControler` also downloads `gametimes.xml` to read `funny@res` (`decompiled/core_module/scripts/mvc/controler/FunnyControler.as:71-95`).

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `TimeStoryFrame` (TSF) | "Edição {0}" + `activeDate` | module tabs, page buttons, egg | controller `timestory` (`show(openType)` selects the module tab, TSF:494-498) | page images `PathManager.getTimeStoryResPath(res)` (TSF:272-287) |
| `UpdateBroadcastView` (UBV) | | update notes page | page 1 | `time`, `curContent..item` (UBV:90-120); error "yishi.view.UpdateBroadCastFrame.Alert" |

## 3. Routes (client to server)

### R1. Page viewed (C>S 8629 0x21b5 `C_GAME_STORY_REQUEST`)
- Trigger: every page change (`TSF.setEggByPageChange`, TSF:289-304).
- `active.GameStoryMsg`: `is_access (#1, BOOL)` true every 5th page change of the session, `index (#2, INT32)` page number (1 based), `is_drop (#3, BOOL)` unused in requests.
- Server: when `is_access` and the daily egg limit is not reached, roll a drop and push 4546.

### R2. Claim egg (C>S 8630 0x21b6 `C_GAME_STORY_REWARD`)
- Trigger: egg click or 7 s timeout (TSF:193-218). No body.
- Server: grant the egg reward if a drop is pending, clear it.

### R3. Journal content (HTTP)
- `GET {TPL}gametimes.xml` with `rnd` cache buster (FunnyControler). Root attributes `Time`, `Title`, `Id`, `IsActive`, `OpUser`, `ActiveDate`, `Remark`, `NextDate`; children `Module@modulename`, `Module@totalpage`, `page@res`, and `funny@res` (TSC:65-111). The frame refuses to open when total pages < 3.

## 4. Server messages (server to client)

| Opcode | Name | Body | Receiver | Meaning |
|---|---|---|---|---|
| 4492 (0x118c) | `U_C_GAMETIMES_INFO` | none read | `TSC.__updateHandler` (TSC:40-48) | journal changed; next open reloads the XML |
| 4546 (0x11c2) | `U_C_GAME_STORY_DROP` | none read | `TSF.__eggDropHandler` (TSF:193-204) | show the egg |

## 5. Rules and formulas

| Rule | Value | Source |
|---|---|---|
| Egg chance window | every 5th page change sends `is_access = true` | TSF:292-302 |
| Egg auto claim | 7000 ms | TSF:203 |
| Link level gates | fashion 10, title 30, wing shop > 4 | TSF:420-460 |

## 6. Templates

`gametimes.xml` (CDN template path, not in `raw/xml/tempinfos`). Egg rewards: server data.

## 7. Persistent state

```sql
CREATE TABLE time_story.journal_eggs (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  egg_day         DATE NOT NULL,
  drops           SMALLINT NOT NULL DEFAULT 0,
  pending         BOOLEAN NOT NULL DEFAULT false,
  PRIMARY KEY (player_id, egg_day)
);
```

## 8. Backend implementation notes

`time_story::legend_journal::handle_page_view` (8629), `handle_claim_egg` (8630). Serve `gametimes.xml` statically; broadcast 4492 when the file changes.

## 9. Open questions and assumptions

- No opener in this client; egg drop chance, daily limit and reward unknown.

## 10. Implementation checklist

- [ ] Serve `{TPL}gametimes.xml`
- [ ] Route 8629, 8630
- [ ] Server messages 4492, 4546
- [ ] Table `time_story.journal_eggs`
- [ ] Tests: 5th page access flag, pending egg claim once
