# Plot and dialog

Area: tutorial, module `plot-dialog`. Covers server pushed story dialogs ("游戏剧情", game plot) in maps and battles: `U_C_GAME_PLOT` 138 and `U_C_BATTLE_TALK` 171 carrying `gameplot.PlotMsg`, the dialog UI (`dialog` package), plot events (`SESSION_OVER` that starts a battle through 5032), the battle plot acknowledgement (10022), and the client side scripted dialogs used by the novice script (`NoviceDialogueXml`).

Conventions: see [README.md](README.md). Related: [guided-steps.md](guided-steps.md), [../campaign/README.md](../campaign/README.md), [../battle/README.md](../battle/README.md).

## 1. Overview

A plot is an ordered list of lines. Each line is either spoken text (portrait left or right, name, text, auto advance delay) or an event (a client notification name with a parameter string). The server pushes a whole plot in one packet. The client queues it behind other map actions, shows it only in the scene the plot was written for, locks the keyboard, darkens the screen, types the text, and advances on click, Space, or after the delay. When the plot ends the client either does nothing (map plots) or acknowledges (battle plots, 10022). An event line named `SESSION_OVER` makes the client ask the server to start the battle of a campaign node (5032).

The same `PlotMsg` is reused by other features with their own opcodes: 4878 `U_C_DIALOG` (demon land, [trials](../trials/README.md), `decompiled/core_module/scripts/yishi/manager/DemonLandManager.as:49`) and 4896 `U_C_REVENGEROAD_DIALOG` ([roads](../roads/README.md), `decompiled/core_module/scripts/yishi/manager/RevengeRoadManager.as:62`). They share the data model below.

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `dialog.view.DialogView` (`decompiled/core_module/scripts/dialog/view/DialogView.as:61`), styles `core.novice.DialogUpBg`, `core.novice.DialogBg`, `core.novice.ContinueBtnMc` | "Clique para continuar({0})" (`dialog.view.DialogView.continueBtn.Text`, countdown seconds) | Cinematic letterbox with portraits, name and typed text | `DialogControl.show` (`decompiled/core_module/scripts/dialog/DialogControl.as:89`) | `DialogMessageInfo`: `roleId` portrait, `roleName`, `txt`, `direction` |
| `dialog.view.DialogRoleImage` | none | Portrait per `roleId` (0 replaced by the player's `pics`) | `DialogView.setRoles` | left roles (`direction != 1`) and right roles (`direction == 1`) (`decompiled/core_module/scripts/dialog/DialogModel.as:75`) |
| `dialog.DialogWordView` + `DialogWordHandler` | none | Typewriter effect (0.25 s fade per character group, `decompiled/core_module/scripts/dialog/DialogWordHandler.as:24`) | `DialogView.showMessage` (`DialogView.as:243`) | text |

## 3. Routes (client to server)

| # | UI control / trigger | Client sender | Client checks | Route | Request | Expected response |
|---|---|---|---|---|---|---|
| P1 | Plot line with `event == "SESSION_OVER"` reached | `DialogControl.dispatchDialogEvent` `decompiled/core_module/scripts/dialog/DialogControl.as:146` -> notification `SESSION_OVER` -> `BaseManager.__sessionOverHandler` `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2237` -> `SocketSendManager.sendSessionOverToBattle` `decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:363` | none; the dialog continues immediately (`callBack` is called before sending) | C>S 5032 0x13a8 `U_C_CAMPAIGN_CALLBACK` ("会话结束后触发战斗", start the battle after the conversation) | `CallBackReqMsg` (package `campaign`): `map_id (#1, INT32)` from tag `mapId:`, `node_id (#2, INT32)` from tag `nodeId:`, `cmd (#3, INT32)` from tag `command:` of the line `param` split on `|` | Battle start on that node ([campaign](../campaign/README.md), [battle](../battle/README.md)). Other senders of 5032: `CampaignMapController` (`decompiled/m3/scripts/map/campaign/CampaignMapController.as:956`, cmd 2) and `CollectionAction` (`decompiled/core_module/scripts/yishi/actions/map/collection/CollectionAction.as:466`, cmd 2) |
| P2 | Battle plot dialog closed | `BattleDialogAction.dispose` `decompiled/core_module/scripts/battle/actions/BattleDialogAction.as:15` -> `SocketSendManager.sendBattlePlotComplete` `SocketSendManager.as:89` | only when a battle model exists | C>S 10022 0x2726 `B_PAUSE_FINISHED` | `BattleReqMsg` (package `battle`): `battleId (#2, STRING)` | Battle resumes (Assumption: the server paused the battle while the talk was shown) |

No request asks for a plot; plots are always pushed.

## 4. Server messages (server to client)

### 4.1 `PlotMsg` (package `gameplot`)

| Field | Meaning |
|---|---|
| `loop (#1, BOOL)` | Stored in `DialogModel.isLoop` (`decompiled/core_module/scripts/yishi/actions/map/DialogAction.as:65`) but never read for 138. For 4878 and 4896 `true` means "show the dialog, then open the module", `false` means "open the module directly" (`RevengeRoadManager.as:71`) |
| `scene_type (#2, INT32)` | Scene the plot belongs to (`SceneType.getSceneTypeById`, `decompiled/core_module/scripts/yishi/scene/SceneType.as:85`): 1 castle, 2 outer city, 3 campaign map, 4 battle, 5 PvE room, 6 PvP room, 7 farm, 8 vehicle, 10 sky realm, other values up to 32; unknown ids map to sky realm (`SPACE_SCENE`) |
| `info (#3, PlotInfoMsg, repeated)` | Lines in display order |

`PlotInfoMsg`:

| Field | Meaning and client handling (`DialogAction.readPackage` `DialogAction.as:57`) |
|---|---|
| `index (#1, INT32)` | Line index (copied, not used for ordering; packet order is used) |
| `direction (#2, INT32)` | 0 portrait on the left, 1 on the right (`decompiled/core_module/scripts/dialog/data/DialogConstInfo.as:6`) |
| `role_id (#3, INT32)` | Portrait id; 0 means the player's own portrait (`playerInfo.pics`) |
| `role_name (#4, STRING)` | Speaker name; `"%s"` means the player's nickname; `"<own userId>$"` shows "Herói" (`public.nickName`) |
| `event (#5, STRING)` | Empty for a spoken line; otherwise a notification name sent with `{callBack, data}` instead of showing text (`DialogControl.as:131`). Known consumer: `SESSION_OVER` (P1) |
| `param (#6, STRING)` | Event parameter; for `SESSION_OVER` the format is `nodeId:<id>|mapId:<id>|command:<n>` |
| `text (#7, STRING)` | Line text; every `%s` is replaced by the resolved speaker name. Texts longer than 100 characters are split into extra lines of 100 characters (`DialogControl.TxtArray` `DialogControl.as:66`) |
| `delayTime (#8, INT32)` | Auto advance after N seconds; 0 means 10 (`DialogView.as:258`) |

### 4.2 Messages

| Route | Message | When | Client handler and effect |
|---|---|---|---|
| S>C 138 0x008a `U_C_GAME_PLOT` | `PlotMsg` | Push when a story moment happens on a map (campaign node reached, quest step, castle event; Assumption) | `BaseManager.__gamePlotHandler` `decompiled/core_module/scripts/yishi/manager/BaseManager.as:2211`: if `scene_type` equals the current scene the packet is queued on the core transaction queue with the delay of header field `extend2` in frames (`CoreTransactionManager.currentTimeAddQueue` `decompiled/core_module/scripts/yishi/manager/CoreTransactionManager.as:120`, header layout in `protocol/socket.md`); otherwise it is buffered until the player enters that scene, or 90 s (`decompiled/core_module/scripts/yishi/manager/SocketSceneBufferManager.as:103`). `DialogTransation` (`decompiled/core_module/scripts/map/internals/transaction/DialogTransation.as:14`) re-dispatches it; `__gamePlotActionHandler` (`BaseManager.as:2232`) queues a `DialogAction` on `GameBaseQueueManager`; the dialog opens one frame later (`DialogAction.as:33`). If the scene changes during the plot it closes (`DialogControl.as:102`) |
| S>C 171 0x00ab `U_C_BATTLE_TALK` ("战斗剧情") | `PlotMsg` | Push during a battle | `SocketManager` routes it to `BattleManager.plotHandler.handler` (`decompiled/core_module/scripts/yishi/service/managers/SocketManager.as:148`); `BattlePlotHandler` (`decompiled/core_module/scripts/battle/handler/BattlePlotHandler.as:27`) shows queued talks one at a time when all roles are static, or immediately for battle types 311, 312, 313 (`:59`); active between battle start and result (`EnterBattleController.as:296`, `BattleResultHandler.as:114`). On close sends P2 |
| S>C 4878 `U_C_DIALOG`, 4896 `U_C_REVENGEROAD_DIALOG` | `PlotMsg` | Owned by [trials](../trials/README.md) and [roads](../roads/README.md) | Same parsing, then open their module |

## 5. Rules and formulas

- One dialog at a time per queue; `DialogManager.isExistDialog` tracks script dialogs (`decompiled/core_module/scripts/dialog/DialogManager.as:39`).
- `DialogAction` releases the map action queue after 600 frames even if the dialog is still open (`DialogAction.as:39`).
- Advance: click anywhere or Space (key 32) (`DialogView.as:284`, `:306`); a click during typing completes the line first. Auto advance counts down `delayTime` seconds (default 10) and shows the countdown in "Clique para continuar({0})" (`DialogView.as:265`).
- While open: keyboard disabled, dynamic layers cleared, UI hidden (`UI_OUT_SCENE`), restored on close (`DialogControl.as:91`, `:155`).
- Name substitution: `%s` in `role_name` and in `text` become the nickname or resolved speaker (`DialogAction.as:78`, `:94`).

### 5.1 Client side scripted dialogs

`NoviceDialogueXml.xml` (`decompiled/core_module/scripts/dialog/data/NoviceDialogueXml.as:6`) embeds 21 `story` blocks (`nameId` 1 to 26) with `sceneType` and pt-BR lines (`direction`, `roleId`, `delayTime`, `roleName`, `txt`), for example story 1 opens with "Alteza, você está envolvida com o assassinato do Rei.Você tem que voltar para ser julgada!" spoken by "Guardas do Reino". They are played by the novice script action `showDialog(<nameId>)` through `DialogManager.showDialog` (`DialogManager.as:16`, `DialogModel.setXmlResources` `decompiled/core_module/scripts/dialog/DialogModel.as:101`). Stories used by reachable nodes: 1, 2, 17, 4, 6, 7, 9, 10, 11 ([guided-steps.md](guided-steps.md)). No server data is needed for them.

## 6. Templates

| File | Record | Fields used here |
|---|---|---|
| `decompiled/core_module/scripts/dialog/data/NoviceDialogueXml.as` | `story@sceneType`, `story@nameId`, `item@direction`, `@roleId`, `@delayTime`, `@roleName`, `@txt` | client scripted dialogs |
| `index/language.json` | `dialog.view.DialogView.continueBtn.Text`, `public.nickName` | UI strings |

No tempinfo file contains server plots. The plot texts the original server pushed are not in the client (Open question).

## 7. Persistent state

Server authored plot content and per player "already seen" markers:

```sql
CREATE TABLE tutorial.plot (
    plot_id      integer     PRIMARY KEY,
    scene_type   smallint    NOT NULL,                 -- PlotMsg.scene_type
    is_loop      boolean     NOT NULL DEFAULT false,   -- PlotMsg.loop
    channel      smallint    NOT NULL DEFAULT 138 CHECK (channel IN (138, 171, 4878, 4896)),
    trigger_kind text        NOT NULL,                 -- e.g. 'campaign_node', 'quest_accept', 'battle_round'
    trigger_ref  integer,                              -- node id, quest id, battle template id
    replayable   boolean     NOT NULL DEFAULT false,
    description  text
);
CREATE INDEX plot_trigger_idx ON tutorial.plot (trigger_kind, trigger_ref);

CREATE TABLE tutorial.plot_line (
    plot_id       integer  NOT NULL REFERENCES tutorial.plot(plot_id) ON DELETE CASCADE,
    line_index    smallint NOT NULL,
    direction     smallint NOT NULL DEFAULT 0 CHECK (direction IN (0, 1)),
    role_id       integer  NOT NULL DEFAULT 0,          -- 0 = player portrait
    role_name     text     NOT NULL DEFAULT '',         -- '%s' = player nickname
    event         text     NOT NULL DEFAULT '',         -- '' or e.g. 'SESSION_OVER'
    event_param   text     NOT NULL DEFAULT '',         -- 'nodeId:..|mapId:..|command:..'
    body          text     NOT NULL DEFAULT '',
    delay_seconds smallint NOT NULL DEFAULT 10 CHECK (delay_seconds >= 0),
    PRIMARY KEY (plot_id, line_index)
);

CREATE TABLE tutorial.player_plot_seen (
    player_id  integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    plot_id    integer     NOT NULL REFERENCES tutorial.plot(plot_id) ON DELETE CASCADE,
    seen_at    timestamptz NOT NULL DEFAULT now(),
    PRIMARY KEY (player_id, plot_id)
);
```

## 8. Backend implementation notes

- Plot sender service `tutorial::plot_dialog::push_plot(player, plot_id, delay_frames)`: load lines ordered by `line_index`, build `PlotMsg`, write header `extend2` = delay in client frames (0 to show at once), send on `channel`. Skip when `replayable` is false and a seen row exists; insert the seen row in the same transaction as the triggering game event.
- Triggers are called from other features (campaign node arrive, quest accept or finish, castle events, battle scripts). For a pre battle conversation on a campaign node, end the plot with an event line `SESSION_OVER` and `event_param` `nodeId:<node>|mapId:<map>|command:<cmd>`; do not start the battle until P1 arrives.
- `tutorial::plot_dialog::handle_session_over` (5032, shared with campaign; Assumption: implement in `campaign::...` and call it from here): validate that the player is on `map_id`, that `node_id` exists and is attackable, and that a session was pending for that node; then start the node battle.
- Battle talk (171): push from the battle engine at scripted moments; pause the battle clock until 10022 for that `battleId` (handled by `battle::...`). Add a server side timeout (for example 120 s, the unused `DialogControl.MAX_TIME_OUT` constant is 120000 ms, `DialogControl.as:24`) so a closed client does not freeze the battle forever.

## 9. Open questions and assumptions

- The catalog of server plots (texts, portraits, triggers) of the original game is not in the client data; content must be captured or authored.
- Event names other than `SESSION_OVER` that the server may have used are unknown; only `SESSION_OVER` has a listener in this build.
- `command` values of 5032 besides 2 are unknown.
- Assumption: 171 pauses the battle server side; confirmed only by the client sending 10022 after the talk.
- `loop` meaning for 138 is unknown (ignored by the client).

## 10. Implementation checklist

- [ ] Tables `tutorial.plot`, `tutorial.plot_line`, `tutorial.player_plot_seen`
- [ ] `PlotMsg` encoder with header `extend2` delay
- [ ] Server message 138 push with scene type
- [ ] Server message 171 push from battle scripts with pause
- [ ] Route P1 5032 session over starts the node battle (with campaign)
- [ ] Route P2 10022 resumes a paused battle (with battle)
- [ ] Rule: `%s` and `<userId>$` name placeholders left to the client
- [ ] Rule: lines over 100 characters are fine (client splits)
- [ ] Test: plot for scene 3 sent while in castle is shown after entering the campaign
- [ ] Test: `SESSION_OVER` line produces 5032 with the parsed ids
- [ ] Test: battle talk pauses and resumes on 10022
