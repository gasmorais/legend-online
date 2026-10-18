# Socket protocol: Legend Online BR (OAS1264)

Source: `yishi/comm/ByteSocket.as`, `PackageIn.as`, `PackageCheckController.as`, `SocketManager.as`, `ProtocolType.as`, `AcceptProtocolType.as` (core module `2.png`).

## Transport
- Direct TCP to `SocktPath : SocketPort` returned at login (observed `s1264oas.creaction-network.com:5004`).
- Socket policy: `xmlsocket://<host>:843`.
- Flow: `connect` → client sends login → server replies.

## Cipher (stream, 8-byte key)
Initial key `RECEIVE_KEY = SEND_KEY = [174,191,86,120,171,205,239,241]` (`AE BF 56 78 AB CD EF F1`). The key **evolves on every byte**.

**Send (client → server)**, `ByteSocket.send`:
```
for i in 0..n-1:
  if i > 0:
     KEY[i%8] = (KEY[i%8] + data[i-1]) & 0xFF XOR i
     data[i]  = ((data[i] XOR KEY[i%8]) + data[i-1]) & 0xFF
  else:
     data[0] ^= KEY[0]
```

**Receive (server → client)**, `ByteSocket.decrptBytes` / `PackageIn.loadE`:
```
for i in 0..n-1:
  if i > 0:
     KEY[i%8] = (KEY[i%8] + raw[i-1]) & 0xFF XOR i
     out[i]   = ((raw[i] - raw[i-1]) & 0xFF) XOR KEY[i%8]
  else:
     out[0] = raw[0] ^ KEY[0]
```

> The key uses the **previous** byte (already encrypted when sending, raw received byte when receiving).
> `tools/decode.py socket-decrypt` implements receive.

## Header (20 bytes, big-endian)
| offset | type | field | note |
|---|---|---|---|
| 0 | u16 | magic | `29099` = `0x71AB`; used to sync the packet start |
| 2 | u16 | length | total packet size (header included) |
| 4 | u16 | checksum | validated (below) |
| 6 | u16 | **code** | opcode (see `opcodes.json`) |
| 8 | u32 | clientId | player id |
| 12 | u32 | extend1 | free per message |
| 16 | u32 | extend2 | free (e.g. remaining time) |

Body starts at offset 20. `PackageIn.readHeader()` reads in this order.

## Checksum
```
sum = 119
for i in 6..length-1: sum += byte[i]
checksum == sum & 0x7F7F
```
Invalid packets are dropped in `ByteSocket.handlePackage`.

## Body
**Protobuf** serialization (`com.netease.protobuf`). Each `code` maps to a message `com.road.yishi.proto.<area>.<Name>Msg`. See `protocol/proto.md`.

## Routing
`SocketManager.__chatSocketData` dispatches `SLGSocketEvent" + code`. Listeners register via `listener(code, fn)`. Special cases:

| code | target |
|---|---|
| `140` | `MapUpdatedMsg` (wildland/castle/army) |
| `143` | `U_PLAY_MOVIE` |
| `154` | `VictoryFailTransaction` |
| `157` | `CoreTransactionManager` |
| `171` | `BattleManager.plotHandler` |

## Anti-desync counters
For some opcodes the client requires a strict sequence (otherwise it closes the socket):
- campaign: `8196, 8549, 5125, 8255, 8548, 5121, 5033, 5124, 25202, 25203, 9669`
- vehicle: `8616, 8617, 8615`
- snow: `25217, 25216, 25218`

## Opcode tables
- **send** (client→server): `ProtocolType`, 729 codes
- **accept** (server→client): `AcceptProtocolType`, 1147 codes
- Indexes: `protocol/opcodes.json` and `protocol/opcodes.csv`

## FSM
`FSM(2059198199, 1501)`: pseudo-random generator used for extra obfuscation (`updateState = (~state + adder) * multiper; state ^= state>>16`).
