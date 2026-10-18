# Game settings

Area: account, module `settings`. Covers the "Configuração" frame: audio and display options stored locally in the Flash `SharedObject` per player, and the three privacy toggles stored on the server (refuse friend requests `8285`, refuse room invitations `8286`, refuse team invitations `8746`) with their refresh pushes `4193`, `4194`, `4635`.

Conventions: see [login-session.md](login-session.md). Paths are relative to the repository root.

## 1. Overview

- Opened with the settings button of the minimap bar (`decompiled/core_module/scripts/mainBar/SmallMapBar.as:704-708`) or the Esc key when no frame is open (`decompiled/core_module/scripts/yishi/keyboard/KeyBoardRegister.as:136-137`, `:605-633`). Controller key `setting` (`decompiled/core_module/scripts/yishi/datas/UIModuleTypes.as:70`, `decompiled/core_module/scripts/yishi/manager/FrameControllerManager.as:853`, `:1393`).
- Local options apply live while the frame is open; "OK" keeps them and saves the SharedObject, "Cancel" or close reverts (`decompiled/m11/scripts/setting/SettingFrame.as:366-378`, `:481-530`, `:549-562`).
- Privacy toggles are sent to the server at click time. On cancel the client sends the toggle again for each one whose server value differs from the value at open time (`SettingFrame.as:517-528`). The server is the source of truth: `PlayerMsg.refuseFriend (#50)`, `refuseInvite (#51)`, `refuseTeamInvite (#86)` at login, and the three refresh pushes afterwards.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `setting.SettingFrame` (`decompiled/m11/scripts/setting/SettingFrame.as:128`) | `setting.SettingFrame.title` "Configuração" | Audio, display and privacy options | SmallMapBar settings button, Esc | See control table |

Controls (`SettingFrame.as:141-204`, initial values `:321-346`):

| Control (style) | Storage | Effect |
|---|---|---|
| `setting.BackMusicBtn` + `setting.BackMusicSilder` (0..100) | local `allowMusic`, `musicVolumn` (default true, 40) | `SoundManager.allowMusic` |
| `setting.MusicEffectBtn` + `setting.MusicEffectSilder` | local `allowSound`, `soundVolumn` (default true, 40) | Sound effects, battle sound toggle event `battleMusicOnOff` |
| `setting.SceneEffectBtn` | local `allowSceneEffect` (true) | Event `sceneEffectClose` |
| `setting.AttacedEffectBtn` | local `allowAttactedEffect` (true) | Battle hit effects (`decompiled/core_module/scripts/battle/view/roles/RoleViewBase.as:932`, `battle/utils/BattleUtils.as:397`) |
| `setting.BuildingNameBtn` | local `buildingName` (true) | `BuildingManager.isShowBuildingName` |
| `setting.ShadowEffectBtn` | local `shadowEffect` (true) | Skill shadows (`battle/skillsys/skills/BaseSkill.as:364`) |
| `setting.HideOthersBtn` | local `hideOthers` (false) | Event `HIDE_OTHERS`: hides other players in shared scenes |
| `setting.AllowInvitationBtn` | local `refuseInvitation` (false) | Mini game invitations (Gold Road, slots, fishing) read it (`decompiled/core_module/scripts/ui/toptoolbar/TopToolsBar.as:1215-1252`, `chat/view/ChatOutputViewII.as:1215`) |
| `setting.fullScreenBtn` | none | Toggles stage full screen; desktop client shows `setting.SettingFrame.fullScreenBtn.Tips` "O Dispositivo de Login não suporta tela cheia." |
| `setting.RefuseFriendBtn` | server `refuseFriend` | `8285` |
| `setting.refuseInviteBtn` | server `refuseInvite` | `8286` |
| `setting.refuseTeamInviteBtn` | server `refuseTeamInvite` | `8746` |
| `oneKeyBtn` "Elevar Clique Único", `resourceBtn` "Adicionar Recurso", `clearanceBtn` | none | Created but never added to the frame (`SettingFrame.as:191-202`); dead |

Local keys are stored in `SharedObject.getLocal("7road/files")` as `<name><userId>` (`decompiled/core_module/scripts/yishi/manager/SharedManager.as:604-640`, `save` at `:1728`).

## 3. Routes (client to server)

### 3.1 `8285 C_FRIEND_REFUSE` (C>S, 0x205d)

- UI control: `setting.RefuseFriendBtn` (`SettingFrame.as:440-444`), and revert on cancel (`SettingFrame.as:521-524`).
- Sender: `SocketSendManager.sendFriendRefuse` (`decompiled/core_module/scripts/yishi/service/managers/SocketSendManager.as:420-424`).
- Request: empty body (toggle).
- Expected response: `4193 U_C_REFUSEFRIEND_REFRESH` with the new value.

### 3.2 `8286 C_ROOM_REFUSE` (C>S, 0x205e)

- UI control: `setting.refuseInviteBtn` (`SettingFrame.as:424-428`), revert `:517-520`.
- Sender: `SocketSendManager.sendRefuseInvite` (`SocketSendManager.as:426-430`).
- Request: empty body (toggle).
- Expected response: `4194 U_C_REFUSEINVITE_REFRESH`.

### 3.3 `8746 C_TEAM_REFUSE` (C>S, 0x222a)

- UI control: `setting.refuseTeamInviteBtn` (`SettingFrame.as:459-463`), revert `:525-528`.
- Sender: `SocketSendManager.sendRefuseTeamInvite` (`SocketSendManager.as:432-436`).
- Request: empty body (toggle).
- Expected response: `4635 U_C_REFUSETEAMINVITE_REFRESH`.
- Note: `protocol/opcodes.csv` lists `8746` twice (`C_TREASUREMAP_REQUEST` and `C_TEAM_REFUSE`, both declared in `decompiled/core_module/scripts/yishi/datas/consant/ProtocolType.as:762`, `:770`). The only sender found is `sendRefuseTeamInvite`; no code uses `C_TREASUREMAP_REQUEST`, so route `8746` to the team refuse toggle.

## 4. Server messages (server to client)

All three use `RefuseFriendRspMsg` (package player): `result (#1, BOOL)` = new refuse state.

| Opcode | Receivers | Effect |
|---|---|---|
| `4193 U_C_REFUSEFRIEND_REFRESH` (0x1061) | `PlayerManager.__uRefusefriend` (`decompiled/core_module/scripts/yishi/manager/PlayerManager.as:461-467`), `SettingFrame.__uRefusefriend` (`SettingFrame.as:306-309`) | `playerInfo.refuseFriend`, checkbox |
| `4194 U_C_REFUSEINVITE_REFRESH` (0x1062) | `PlayerManager.__uRefuseInvite` (`PlayerManager.as:469-475`), `SettingFrame.__uRefuseInvite` (`SettingFrame.as:311-314`) | `playerInfo.refuseInvite` |
| `4635 U_C_REFUSETEAMINVITE_REFRESH` (0x121b) | `PlayerManager.__uRefuseTeamInvite` (`PlayerManager.as:477-483`), `SettingFrame.__uRefuseTeamInvite` (`SettingFrame.as:316-319`) | `playerInfo.refuseTeamInvite` |

When: immediate response to the matching toggle. Also included in `3 PlayerMsg` at login (`PlayerManager.as:875-883`).

## 5. Rules and formulas

- Toggles flip the stored boolean; there is no explicit value in the request.
- `refuseFriend = true`: the friends feature must reject friend add requests targeting this player ([../friends/README.md](../friends/README.md)).
- `refuseInvite = true`: room / campaign invitations to this player are rejected ([../campaign/README.md](../campaign/README.md)).
- `refuseTeamInvite = true`: team invitations are rejected ([../team/README.md](../team/README.md)).
- Local settings never reach the server.

## 6. Templates

None.

## 7. Persistent state

```sql
CREATE TABLE account.player_privacy (
  player_id            BIGINT      PRIMARY KEY REFERENCES player.players(player_id),
  refuse_friend        BOOLEAN     NOT NULL DEFAULT false,
  refuse_room_invite   BOOLEAN     NOT NULL DEFAULT false,
  refuse_team_invite   BOOLEAN     NOT NULL DEFAULT false,
  updated_at           TIMESTAMPTZ NOT NULL DEFAULT now()
);
```

## 8. Backend implementation notes

- `account::settings::handle_refuse_friend` (8285), `handle_refuse_room_invite` (8286), `handle_refuse_team_invite` (8746): `UPDATE ... SET col = NOT col RETURNING col` (upsert on first use), reply with the matching push. Single statement, no other side effect.
- Expose `account::settings::privacy(player_id)` for the friends, room and team services to check before delivering an invitation.
- Include the three flags in the login `PlayerMsg` (hero feature reads this table).

## 9. Open questions and assumptions

- Resolved: the `8746` name collision is nominal; only the team refuse toggle sends it (see 3.3).
- Assumption: refused invitations are silently dropped or answered with the inviter's generic failure; the exact inviter feedback belongs to each inviting feature.

## 10. Implementation checklist

- [ ] `8285` / `4193`
- [ ] `8286` / `4194`
- [ ] `8746` / `4635`
- [ ] `PlayerMsg` refuse fields at login
- [ ] Privacy checks in friends, room and team invitations
- [ ] Table `account.player_privacy`
- [ ] Test: toggle twice returns to the original value
- [ ] Test: cancel after toggling restores the server value
