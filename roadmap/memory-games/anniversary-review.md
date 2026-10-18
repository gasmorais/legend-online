# Retrospectiva de aniversário (sq memory, "周年回顾")

Path aliases:

| Alias | File |
|---|---|
| SQM | `decompiled/core_module/scripts/managers/SqMemoryManger.as` |
| SQU | `decompiled/core_module/scripts/mvc/module/sqmemory/SqmemoryUserInfo.as` |
| SQMAIN | `decompiled/m11/scripts/sqmemory/SqmemoryMainFrame.as` |
| SQSH | `decompiled/m11/scripts/sqmemory/SqmemoryShareFrame.as` |
| SQLB | `decompiled/m11/scripts/sqmemory/SqmemoryLabelFrame.as` |
| SQRW | `decompiled/m11/scripts/sqmemory/SqmemoryRewardFrame.as` |
| SQP | `decompiled/m11/scripts/sqmemory/page/SqmemoryPage<n>.as` |
| SQBP | `decompiled/m11/scripts/sqmemory/page/SqmemoryBasePage.as` |
| TTB | `decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as` |
| TBH | `decompiled/core_module/scripts/ui/toptoolbar/TopBtnCheckShowHelper.as` |

## 1. Overview

A "10th anniversary" personal review book (Chinese "周年回顾"). The server computes statistics of the player's history (first login, friends, growth, honor, legend) and the client renders them on 8 pages in 5 chapters, then a summary card with tags ("Sua Tag do 10º aniversário de Legend Online é:"). Sharing the card (upload a JPEG, open Facebook share) gives a one time reward ("Compartilhe a viagem e ganhe posteriormente:", `anniversary_review_reward`). It is a memory book, not a card matching game.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `sqmemory.SqmemoryMainFrame` (SQMAIN) | chapter titles `sqmemory.page.title1..5`: "Começo da Aventura", "Testemunho de amizade", "Selo de crescimento", "Testemunhe a glória", "Viagem Lendária" (SQMAIN:86) | Book with pages 1..8 | opened by the client when 4321 arrives with `opType 0` (SQM:53-56) | page data below |
| `sqmemory.SqmemoryShareFrame` (SQSH) | "Sua Tag do 10º aniversário de Legend Online é:" | Summary lines from `shareInfo`, hero figure, change tag, share | end of the book | `shareInfo` |
| `sqmemory.SqmemoryLabelFrame` (SQLB) | "Troca de Tag" | Choose the displayed tag (`currSelectIdx`) | SQSH change button (`openControllerByInfo("sqmemory", 2, tags)`) | |
| `sqmemory.SqmemoryRewardFrame` (SQRW) | "public.prompt" | Shows the share reward from `anniversary_review_reward` (SQRW:48-49) | SQSH share when `isReward` false (`openControllerByInfo("sqmemory", 3)`) | reward list |

Toolbar `sqmomery` (TopToolBtnInfos 4026 "周年回顾"): visible when `ConfigManager.info.SQ_MEMORY && grades >= 80 && SQ_MEMORY_START <= now < SQ_MEMORY_END` (TBH:417-418); these values come from the switch push 4422 `SwitchInfoListMsg` entry `switchType 3073` (`isOpen`, `beginDate`, `endDate`) (`decompiled/core_module/scripts/yishi/manager/BaseManager.as:316, 1505-1611`), owned by [../account/switches.md](../account/switches.md); click calls `SqMemoryManger.doSomething()` (TTB:1512-1514).

## 3. Routes (client to server)

### R1. Request the review
- UI: toolbar click.
- Sender: `SqMemoryManger.doSomething()` (SQM:59-63).
- Route: C>S 9716 (0x25f4) `C_SQMEMORY_CLIENT_OP`, empty body.
- Expected response: 4321 with `opType 0` (opens the book).

### R2. Share (HTTP)
- UI: share button (SQSH:531-541): if `isReward` already true, tip "Já recebeu o Prêmio de compartilhamento"; else opens the reward frame. In both cases uploads the card.
- Route: HTTP POST `{REQ}sqshare?uid=<userId>&appid=<FACEBOOK_SHARE_APPID>&appurl=<FACEBOOK_SHARE_PATH>`, body JPEG (quality 90) of the card, `Content-Type: application/octet-stream` (SQSH:543-562).
- Expected response: XML `<... value="1" message="<public image url>"/>`; the client opens `https://www.facebook.com/sharer.php?u=<message>` (SQSH:568-586). `value != 1` does nothing.
- Reward grant: assumption, the server grants `anniversary_review_reward` on the first successful upload and pushes 4321 with `isReward true` and `opType 1` (so the book does not reopen).

## 4. Server messages (server to client)

### S1. 4321 (0x10e1) `U_C_SQMEMORY_USER_DATA`
- `sqmemory.SqMemoryUserMsg`: `opType` (#1, INT32) 0 opens the book; `beginInfo` (#2, STRING); `friendShipInfo` (#3, STRING); `growthInfo` (#4, STRING); `honourInfo` (#5, STRING); `legendInfo` (#6, STRING); `shareInfo` (#7, STRING); `isReward` (#8, BOOL) share reward already taken.
- Receiver: `SqMemoryManger.__userDataInfosHandler` (SQM:40-57).
- Info string format: segments separated by `|`; each segment is either `#` (no data) or comma separated arguments substituted into a language string (`LanguageMgr.GetTranslation(key, args...)`). `createNote(segment, [keyYes, keyNo], ...)` uses `keyYes` with the args, or `keyNo` without args when the segment is `#`; a `true` fourth argument cuts the first arg to 10 chars (a date) (SQBP:14-42).

| Field | Segment | Language key (`sqMemory.note.*` unless stated) | Page |
|---|---|---|---|
| `beginInfo` | 0 | `adventure1` (first arg a date) | 1 |
| `beginInfo` | 1 | `adventure2` / `adventure2_N` | 1 |
| `beginInfo` | 2.. | `adventure3_Y_<n>` / `adventure3_N_<n>` (n = 1..) | 1 |
| `friendShipInfo` | 0..4 | `friend1_Y/N`, `friend2_Y/N`, `friend3` (always args), `friend4_Y/N`, `friend5_Y/N` | 2 |
| `growthInfo` | 0, 1 | `grow1_Y_1/N_1`, `grow1_Y_2/N_2` | 3 |
| `growthInfo` | 3..5 | `grow4_Y_<1..3>` / `grow4_N_<1..3>` | 4 |
| `growthInfo` | 6..8 | `grow5_Y_<1..3>` / `grow5_N_<1..3>`; segments 7 and 8 also carry `job` (arg 2) and `growthGrade` (arg 3) for avatars | 4 |
| `honourInfo` | 0..2 | `honor2`, `honor3`, `honor4` | 5 |
| `honourInfo` | 3 | `honor7` | 6 |
| `legendInfo` | 0..3 | `legend1`, `legend2`, `legend3_Y_1`, `legend3_Y_2` | 7 |
| `legendInfo` | 4..6 | `legend4`, `legend5`, `legend6` / `legend6_N` | 8 |
| `shareInfo` | 0..7 | `sqMemory.summary.day`, `forcevalue<tag>`, `honor`, `due`, `fb`, `fashion<tag>`, `mount<tag>`, `party1` or `party2`; the first arg of each segment is a number mapped to a tag level (`getDayTag`, `getFightTag`, ...) | share |

- When: reply to R1 (`opType 0`); after the share reward (assumption, `opType 1`).
- 4322 `U_C_SQMEMORY_ACTIVE_DATA` exists in the opcode table but has no client receiver (`SqmemoryActiveInfo` with `isOpen`, `startDate`, `stopDate`, `reward` is unused); do not send it.

## 5. Rules and formulas

- B1. Level 80 (`anniversary_review_level = 80` in ConfigInfos and the toolbar check).
- B2. Period from switch 3073 in push 4422 (`SQ_MEMORY_START`..`SQ_MEMORY_END`); the server must send it at login.
- B3. Share reward once per player: `anniversary_review_reward = 2030102,30|-400,40|208017,50|208023,60` (item, count; negative ids are currency codes, -400 assumption: bound diamonds, see [../currency/README.md](../currency/README.md)).
- B4. Statistics are computed by the server from history (first login date, friends, guild, level, power, honor, victories, dungeons, fashions, mounts). Exact args per language string must be read from `index/language.json`.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `anniversary_review_level`, `anniversary_review_reward` | B1, B3 |
| `index/language.json` | `sqMemory.note.*`, `sqMemory.summary.*` | text templates and argument order |

## 7. Persistent state

```sql
CREATE TABLE memory_games.review_share (
  player_id   BIGINT     PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
  image_url   TEXT        NOT NULL,
  rewarded_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

Statistics are computed on demand from other features' tables (no copy).

## 8. Backend implementation notes

- `memory_games::review::handle_request` (9716): level >= 80; build the six strings from player data (`#` for missing parts); `isReward` from `review_share`; reply 4321 `opType 0`.
- HTTP `POST /sqshare`: authenticate `uid` with the session, store the JPEG (file store), insert `review_share` if absent and grant the reward (inventory and currency), reply `<result value="1" message="<url>"/>`; push 4321 `opType 1` with `isReward true`.

## 9. Open questions and assumptions

- Assumption: share reward granted by the server on upload; the client never sends a claim.
- Assumption: response XML root name (client reads only `@value` and `@message`).
- Open: exact statistics for each argument; requires reading every `sqMemory.note.*` string.

## 10. Implementation checklist

- [ ] Switch 3073 in 4422 at login
- [ ] Route 9716 -> 4321 `opType 0`
- [ ] Builders for `beginInfo`, `friendShipInfo`, `growthInfo`, `honourInfo`, `legendInfo`, `shareInfo`
- [ ] HTTP `/sqshare` upload, reward, 4321 push
- [ ] Table `review_share`
- [ ] Test: second share shows "Já recebeu o Prêmio de compartilhamento" and grants nothing
