# Guard scuffle protocol (unused)

Feature [final-defense](README.md), module `guard-scuffle`.

## 1. Overview

Protobuf package `guardscuffle` ("守卫竞技", guardian scuffle arena) is registered under this feature, but no client class reads or writes its messages in this build. The receive opcodes declared for it, 4992 `U_C_GUARD_SCUFFLE_RSP` and 4993 `U_C_GUARD_SCUFFLE_OP_RSP` (`decompiled/core_module/scripts/yishi/datas/consant/AcceptProtocolType.as:1328-1330`, descriptions "守卫竞技响应请求" and "守卫竞技准备进入战斗时收取敌人信息" in `ProtocolTypeTable.as:691-692`), are also declared as `U_C_GLORY_OPEN_BET_VIEW` and `U_C_GLORY_ROOM_UPDATE` (`AcceptProtocolType.as:2072-2074`) and are only listened to by `GloryGameManager` (`decompiled/core_module/scripts/managers/GloryGameManager.as:61-62`). No send opcode exists for the request message. A config key `GuardScuffleOpenTime` is read by `ConfigInfoManager` (`decompiled/core_module/scripts/yishi/datas/ConfigInfoManager.as:409`) but has no caller in the UI.

Guardian related live protocols are owned elsewhere: `guardpve` -> [guardians](../guardians/README.md) (`guardians/pve.md`), `guardendless` -> [abyss](../abyss/README.md), `guardpvp` -> [arena](../arena/README.md) and [guardians](../guardians/README.md).

## 2. Screens

None.

## 3. Routes (client to server)

None. Message for reference only: `GuardScuffleReqMsg`: `opType` (#1, INT32), `guardIndex` (#2, MESSAGE `GuardIndexMsg`, repeated: `param1` #1 INT32, `param2` #2 INT32), `param1` (#3, INT32), `param2` (#4, INT32), `param3` (#5, STRING).

## 4. Server messages (server to client)

None must be sent. Reference: `GuardScuffleRspMsg`: `opType` (#1, INT32), `score` (#2, INT32), `guardIdAndPos` (#3, STRING), `result` (#4, INT32), `joinTimes` (#5, INT32). Do not send it on 4992/4993: the client would parse it as a glory game message.

## 5. Rules and formulas

None.

## 6. Templates

`raw/xml/tempinfos/ConfigInfos.xml`: `GuardScuffleOpenTime` = `14:00,16:00` ("【守卫竞技】开放时间段", open window), unused by the client.

## 7. Persistent state

None.

## 8. Backend implementation notes

Do not implement. Reserve opcodes 4992/4993 for the glory game ([glory-supremacy](../glory-supremacy/README.md)).

## 9. Open questions and assumptions

- Whether a later client version uses this package.

## 10. Implementation checklist

- [ ] Confirm no handler is registered for `guardscuffle`
- [ ] Test: 4992/4993 used only by the glory game
