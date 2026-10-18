# Login count rewards ("Prêmio de Login")

Area: daily-activity, module `count-login`. Covers `countlogin.CountLoginFrame`, `countlogin.view.CountLoginItem` (m11), `mvc.controler.CountLoginControler`, `mvc.module.countlogin.CountLoginModel`, the `PlayerMsg` fields `relogin_process` and `relogin_count`, route 8496 and the template `ReloginDrops`.

Conventions: see [README.md](README.md).

## 1. Overview

Seven login milestones: "Login 1 dias" to "Login 7 dias". Each milestone becomes claimable once the account has logged in on that many distinct days, and is claimed once ("Obter Prêmio"). In this client build the frame is never opened (no `openControllerByInfo("countlogin")` caller, no top toolbar key); only the info tip counter 5 (unclaimed milestones) is computed. The UI pack `countlogin` is still loaded because [login-activity.md](login-activity.md) reuses its assets. The template `ReloginDrops.xml` is empty.

No server work is needed for parity beyond sending sane `relogin_process` and `relogin_count` values in `PlayerMsg`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `countlogin.CountLoginFrame` (`decompiled/m11/scripts/countlogin/CountLoginFrame.as:33`), style `countlogin.CountFrame` | "Prêmio de Login", columns "Dias de login", "Obter Prêmio" | 7 rows separated by lines (`refreshView` `:89`); closes itself when nothing is left to claim (`__updateHandler` `:81`) | `CountLoginControler` (`decompiled/core_module/scripts/mvc/controler/CountLoginControler.as:17`), unreachable | `PlayerInfo.reloginProcess`, `reloginCount` |
| `countlogin.view.CountLoginItem` (`decompiled/m11/scripts/countlogin/view/CountLoginItem.as:42`) | "Login {n} dias", claimed stamp | row with `ReloginDrops` items sorted gold, bound diamonds, spirit first (`dropsSortFunc` `:147`) | frame | template rows of index `n` |

## 3. Routes (client to server)

### C1. Claim milestone `n`

- UI: row button (`CountLoginItem.__clickHandler` `decompiled/m11/scripts/countlogin/view/CountLoginItem.as:79`), enabled when `n <= reloginCount` and not claimed (`:115-:116`).
- Route: C>S 8496 (0x2130) `C_PLAYER_RELOGIN_CMD`, `player.TakeLoginReward`: `index (#1, INT32)` milestone 1..7.
- Expected response: item grants, then S>C 3 `PlayerMsg` with bit `n - 1` set in `relogin_process`.

## 4. Server messages (server to client)

### S1. 3 (0x0003) `U_C_PLAYER_INFO`, fields `relogin_process (#63, INT32)` and `relogin_count (#64, INT32)`

- Receiver: `PlayerManager.__uPlayerInfoHandler` copies them (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:1004`, `:1008`); `PlayerInfo.reloginProcess` setter fires `RELOGINPROCESS_UPDATE` and info tip 5 (`decompiled/core_module/scripts/yishi/datas/playerinfo/PlayerInfo.as:970`).
- `relogin_process`: bit `n - 1` set = milestone `n` claimed (`PlayerInfo.checkIsReceived` `:1473`); `exitUnReceivedLogin` is true while any of the 7 bits is clear (`:1458`).
- `relogin_count`: number of login days counted (capped at 7 by the info tip, `decompiled/core_module/scripts/yishi/manager/InfoTipsManager.as:102`).
- When: login and after C1.

## 5. Rules and formulas

- Milestone `n` claimable when `n <= relogin_count` and bit `n - 1` clear.
- Info tip 5 = count of claimable milestones among 1..min(7, `relogin_count`) (`InfoTipsManager.as:100-:112`).
- Parity values: `relogin_process = 127` (all claimed) keeps every counter at 0.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/ReloginDrops.xml` (empty; `countLoginDropTemplateCate`, `decompiled/core_module/scripts/yishi/manager/TempleteManager.as:1175`) | `CountLoginDropTemplate` | index (milestone), `ItemId`, `Data` count |

## 7. Persistent state

```sql
CREATE TABLE daily_activity.login_milestone (
    player_id        BIGINT  PRIMARY KEY REFERENCES player.players(player_id) ON DELETE CASCADE,
    login_days       smallint NOT NULL DEFAULT 0 CHECK (login_days >= 0),
    last_login_on    date,
    claimed_mask     smallint NOT NULL DEFAULT 0 CHECK (claimed_mask BETWEEN 0 AND 127)
);
```

## 8. Backend implementation notes

- On the first login of a day increment `login_days`; expose `login_days` and `claimed_mask` as `relogin_count` and `relogin_process` in `PlayerMsg` ([hero](../hero/README.md) owns the message).
- `daily_activity::count_login::handle_claim` (8496): validate 1 <= index <= 7, `index <= login_days`, bit clear; set the bit and grant the `ReloginDrops` rows of that index in one transaction; push bag updates and 3.

## 9. Open questions and assumptions

- `ReloginDrops` content is missing; rewards cannot be reproduced.
- Assumption: login days are distinct calendar days, not consecutive days.

## 10. Implementation checklist

- [ ] `PlayerMsg.relogin_process` and `relogin_count` populated (127 / 0 for a disabled feature)
- [ ] Table `daily_activity.login_milestone` (only if revived)
- [ ] Route 8496 (only if revived)
