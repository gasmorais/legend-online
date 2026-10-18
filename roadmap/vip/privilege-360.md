# 360 platform privilege pack ("Pacote de Previlégio de Segurança")

Path aliases:

| Alias | File |
|---|---|
| B3M | `decompiled/core_module/scripts/managers/Bag360Manager.as` |
| B3F | `decompiled/m11/scripts/bag360/Bag360Frame.as` |
| B3I | `decompiled/m11/scripts/bag360/Bag360Item.as` |
| B3C | `decompiled/core_module/scripts/mvc/controler/Bag360Controler.as` |

## 1. Overview

A platform privilege (360 security guard users in the Chinese release) with six free packs unlocked at hero levels 5, 10, 20, 30, 40 and 50. It uses the `privilege` proto package (`PrivilegeMsg`). In this build it is dormant: `Bag360Manager.setup()` is never called (no call in `Yishi.as`), no toolbar template has a "bag360" key and `raw/xml/tempinfos/PrivilegeDrops.xml` is empty. The registry slug `bag360_vip` does not exist; the client package is `bag360`.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `bag360.Bag360Frame` (B3F) | "Pacote de Previlégio de Segurança" (`ui.toptoolbar.TopToolsBar.bag360Btn.tipData`), columns "Nível do Personagem" and reward | Six `Bag360Item` rows | module `bag360` (`FrameControllerManager` case "bag360", B3C) with no caller in this build | row state 2 (level not reached, button disabled), 3 (taken), 1 (claimable) (B3F:114-148); closes when all six are taken (B3F:92-102) |
| `Bag360Item` (B3I) | level digits `levelDic[index]` | One pack | B3F | drops of `PrivilegeDrops` filtered by job "1"/"2"/"3" (B3I:159-216) |

## 3. Routes (client to server)

### B1. Request state
- UI: B3F constructor (B3F:52-56) and `Bag360Manager.getBagState` (B3M:41-45).
- Route: send 8723 (0x2213) `C_REQUEST_360_REWARD`, empty body.
- Expected response: 4543.

### B2. Take a pack
- UI: B3I button when state 1 (B3I:103-113).
- Route: send 8722 (0x2212) `C_TAKE_360_REWARD`; message `PrivilegeMsg` (privilege): `index` (#4, INT32) pack 1..6.
- Expected response: bag updates, 4543 with the index added.

## 4. Server messages (server to client)

### S1. 4543 (0x11bf) `U_C_REQUEST_360_REWARD`
- Message `PrivilegeMsg` (privilege): `is_privilege` (#1, BOOL) platform privilege owned (not read); `list` (#2, INT32, repeated) taken indexes; `user_name` (#3, STRING); `index` (#4, INT32); `param1` (#5, STRING); `param2` (#6, STRING) (not read).
- Receiver: `Bag360Manager.__receiveBag360Handler` (B3M:49, 52-67), notifies `RECEIVE_BAG_360`; `allGet` when six are taken (B3M:69-72).
- When: reply to 8723 and 8722.

## 5. Rules and formulas

- Level per index: 1: 5, 2: 10, 3: 20, 4: 30, 5: 40, 6: 50 (B3M:83-96).
- Each index once per character; requires the platform privilege (`is_privilege`, assumption).
- Content: `PrivilegeDrops.xml` (`Bag360Template`: `ItemId`, `Count`, `Job` list, by index); empty in this build.

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/PrivilegeDrops.xml` | `Bag360Template` | index, `ItemId`, `Count`, `Job` (empty file) |

## 7. Persistent state

```sql
CREATE TABLE vip.platform_privilege_claims (
  player_id   BIGINT      NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  pack_index  SMALLINT    NOT NULL CHECK (pack_index BETWEEN 1 AND 6),
  claimed_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (player_id, pack_index)
);
```

## 8. Backend implementation notes

- `vip::privilege_360::handle_state` (8723): reply 4543 with `is_privilege` false (no 360 platform in BR) and the taken list.
- `vip::privilege_360::handle_take` (8722): refuse unless `is_privilege`; level check; insert claim; grant drops; reply 4543.
- Low priority: unreachable from the UI in this build.

## 9. Open questions and assumptions

- Assumption: the BR server never grants the platform privilege; implement only the empty state reply.

## 10. Implementation checklist

- [ ] Route B1 8723 replies 4543
- [ ] Route B2 8722 refused without privilege
- [ ] Server message S1 4543
- [ ] Table `vip.platform_privilege_claims`
- [ ] Rule: levels 5, 10, 20, 30, 40, 50
- [ ] Test: unknown index refused
