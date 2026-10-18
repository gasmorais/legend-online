# Lotto (super lottery, "大乐透") (dormant)

Path aliases:

| Alias | File |
|---|---|
| VS | `decompiled/core_module/scripts/yishi/datas/VersionSwitch.as` |
| LIMI | `decompiled/core_module/scripts/mvc/module/superlottery/info/LotoInfoMsgInfo.as` |
| LRMI | `decompiled/core_module/scripts/mvc/module/superlottery/info/LotoRspMsgInfo.as` |
| LREQ | `decompiled/core_module/scripts/com/road/yishi/proto/active/LotoReqMsg.as` |
| LRSP | `decompiled/core_module/scripts/com/road/yishi/proto/active/LotoRspMsg.as` |

## 1. Overview

A daily bet: the player picks one of 12 Tarot cards and one of 12 zodiac signs and bets diamonds or gold. At 00:00 the server draws one card and one sign; both right is the first prize, one right is the second prize; prizes are mailed. This client ships only the data classes, the protobuf messages, the opcodes and the strings; the frame (`superlottery.SuperLotteryFrame`) is not in the decompiled modules and `VersionSwitch.SUPER_LOTTERY = false` (VS:58). Nothing references the info classes or the opcodes. Implement only if the frame is restored; otherwise reject the opcode.

Help text (`superlottery.helpStr`): "1. Apostas de imagens: Pode escolher uma imagem de Tarot e de signos do zodíaco 2. Valor de aposta: Aposta de Diamantes ou Ouro (escolha 1) 3. Regras dos prêmios: Primeiro prêmio: Tarot e Signos do Zodíaco, Segundo prêmio: Tarot ou Signos do Zodíaco (escolher 1). 4. Tempo de abertura de prêmios: Todos os dias às 0h é dada a informação dos prêmios e é feito o reset do evento, o prêmio é enviado para o e-mail."

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `superlottery.SuperLotteryFrame` (missing) | "Loteria" (`superlottery.SuperLotteryFrame.titleText`), toolbar tip "Lotto" | Pick a card ("Escolha a carta de Tarot") and a sign ("Escolha o signo"), bet with gold ("Usar {0} Ouro para apostar?") or diamonds ("Usar {0} Diamante(s) para apostar?"); today view of the last draw ("Tarot", "Signo de Zodiaco") | none in this client | cards `superlottery.cardName0..11`: Guarda, Torre, Força, Roda da Fortuna, Feitiçeiro, Ceptro, Santo Graal, Sol, Dinheiro, Estrela, Lua, Catapulta; signs `starName0..11`: Aquário, Peixes, Carneiro, Touro, Gémeos, Cancer, Leão, Virgem, Balança, Escorpião, Sagitário, Capricórnio |

## 3. Routes (client to server)

### R1. Open and bet
- Route: C>S 9529 (0x2539) `C_LOTO_BET_REQ` ("大乐透请求押注及界面打开", bet request and frame open).
- Body `active.LotoReqMsg`: `optype` (#1, INT32) open or bet (values unknown, assumption 1 open, 2 bet); `bet_phase` (#2, INT32) draw day id; `betInfo` (#3, `LotoInfoMsg`, repeated) the bet.
- `LotoInfoMsg`: `bet_type` (#1, INT32) currency (assumption 1 gold, 2 diamonds); `zoneA` (#2, INT32) card 0..11; `zoneB` (#3, INT32) sign 0..11.
- Client checks known from strings: a card and a sign selected ("Por favor escolha o gráfico da carta de Tarot", "Por favor escolha o gráfico do signo de zodiaco"); one bet per day ("A aposta já foi feita").
- Expected response: 4947 (S1).

## 4. Server messages (server to client)

### S1. 4947 (0x1353) `U_C_LOTO_BET`
- `active.LotoRspMsg`: `optype` (#1, INT32); `bet_phase` (#2, INT32); `self_bet` (#3, `LotoInfoMsg`) today's bet; `last_bet` (#4, `LotoInfoMsg`) the player's previous bet; `last_opened` (#5, `LotoInfoMsg`) last drawn card and sign.
- Receiver: none in this client (mirror class `LotoRspMsgInfo` LRMI with `op`, `phase`, `self_bet`, `last_bet`, `last_opened`).

## 5. Rules and formulas

From `raw/xml/tempinfos/ConfigInfos.xml`:

| Config | Value | Meaning |
|---|---|---|
| `loto_gold_bet` | 100000 | gold per gold bet |
| `loto_diamond_bet` | 1 | diamonds per diamond bet |
| `loto_gold_win` | 500,50 | bound diamonds won by a gold bet: first prize, second prize |
| `loto_diamond_win` | 1000,100 | bound diamonds won by a diamond bet: first prize, second prize |
| `loto_bet_forbit_time` | 00:00,05:00 | bets forbidden between 00:00 and 05:00 |

- Draw at 00:00, results mailed, daily reset (help text).
- Probabilities: card 1/12, sign 1/12; first prize 1/144, second prize 22/144.

## 6. Templates

Only `ConfigInfos.xml` (above).

## 7. Persistent state

```sql
CREATE TABLE lotteries.lotto_draw (
  draw_day  DATE     PRIMARY KEY,
  card      SMALLINT NOT NULL CHECK (card BETWEEN 0 AND 11),
  sign      SMALLINT NOT NULL CHECK (sign BETWEEN 0 AND 11)
);

CREATE TABLE lotteries.lotto_bet (
  draw_day   DATE     NOT NULL,
  player_id  INTEGER  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  currency   SMALLINT NOT NULL CHECK (currency IN (1, 2)),
  card       SMALLINT NOT NULL CHECK (card BETWEEN 0 AND 11),
  sign       SMALLINT NOT NULL CHECK (sign BETWEEN 0 AND 11),
  prize      SMALLINT,
  PRIMARY KEY (draw_day, player_id)
);
```

## 8. Backend implementation notes

- Until a frame exists: `lotteries::lotto::handle_bet` (9529) ignores the request.
- If restored: validate not in 05:00 window, one bet per day, debit gold or diamonds, insert `lotto_bet`, reply 4947. Daily job 00:00: insert `lotto_draw`, compute prizes, mail bound diamonds per `loto_*_win`.

## 9. Open questions and assumptions

- The `optype` and `bet_type` values are unknown (no client code).
- Dormant feature: version switch off, no frame.

## 10. Implementation checklist

- [ ] Reject 9529 while the frame is missing
- [ ] (Optional) Tables `lotto_draw`, `lotto_bet`, daily draw job, mail prizes
