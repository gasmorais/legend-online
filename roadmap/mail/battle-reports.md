# Battle reports (Relatório de Batalhas)

Feature `mail`, module `battle-reports`. Mails of `MailType = 3` whose `Contents` is an XML battle summary, shown in the "Relatório de Batalhas" tab.

Conventions as in [mailbox.md](mailbox.md).

## 1. Overview

When a player's castle or army in the outer city is attacked (or attacks), the server writes a type 3 mail to each involved player. The client parses the body with `BattleReportHelp.covertToBattleInfo` (`decompiled/core_module/scripts/yishi/utils/BattleReportHelp.as:13`) when the mail enters the list (`EmailCategory.addBattleReport`, `EmailInfo.synchronization`). Two layouts exist: a text report (`info@type = 2`) and a duel summary with both sides (any other type). The summary links to the battle position on the outer city map.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `EmailFrame` reports tab | "Relatório de Batalhas" | List of type 3 mails; a blinking effect when unread reports exist (`EmailFrame.__newBattleChangeHandler` `decompiled/m11/scripts/emailII/EmailFrame.as:178`) | mailbox | |
| `ReadEmailFrame` with `ReadBattleReportView` `decompiled/m11/scripts/emailII/view/ReadBattleReportView.as:55` | title "Relatório de Batalhas" (`ReadEmailFrame.as:75`) | Time, enemy name, position link "(x,y)MapName", text "sofreu sua punição" (camp 1) or "lançou ataque contra você" (other camps) (`getContent` `:162`), two `BattleReportItem` panels | report row click | `BattleInfo` |
| `BattleReportItem` `decompiled/m11/scripts/emailII/view/BattleReportItem.as` | "Poder", "Ouro" | One side: hero head (`heroId`), level "Nv.{0}", win icon (`result == 1` for self), power, gold gained (with Magic Spring bonus text when the player has that buff), crystal | report view | side attributes |

## 3. Routes (client to server)

| # | UI control | Client sender | Client checks | Route | Response |
|---|---|---|---|---|---|
| R1 | Open a report | same as mailbox B3 (`maillist` with `reqType=1` if unread) | none | HTTP POST `{REQ}maillist` | see [mailbox.md](mailbox.md) |
| R2 | Click the position link | `ReadBattleReportView.__onPosClickHandler` `ReadBattleReportView.as:216` | report `mapId` must equal the current outer city map, else "Você não está nesse mapa, não é possível transferência direta"; not in auto battle ("Modo Bot em andamento"); not in a campaign map; not in the space scene | none: client changes scene to `OUTER_CITY_SCENE` at `pos` (`MapGrid` grid to pixels x50) | scene change (outer city feature) |
| R3 | Delete | mailbox B4 (8206) | | | |

## 4. Server messages (server to client)

`Contents` of a type 3 mail (XML string inside the `maillist` `Info@Contents` attribute or `MailInfoMsg.contents`):

```xml
<report>
  <info type="1" time="2026-10-17 20:15" camp="1" result="1" playerName="Inimigo"
        siteName="..." pos="120,45" mapId="10001"/>
  <me heroId="101" site1Name="..." site1Count="300" site2Name="..." site2Count="0"
      strategy="0" gold="1500" fight="12345" grade="40" crystal="0"/>
  <he heroId="102" site1Name="..." site1Count="250" site2Name="..." site2Count="0"
      strategy="0" gold="0" fight="11000" grade="38" crystal="0"/>
</report>
```

| Element@attribute | `BattleInfo` field | Meaning |
|---|---|---|
| `info@type` | `type` | 2 = text only report (uses `info@content`), other values = duel summary |
| `info@time` | `time` | display string |
| `info@content` | `content` | text body for type 2 |
| `info@camp` | `camp` | 1 = the reader was the attacker ("sofreu sua punição" shown about the enemy), else the reader was attacked |
| `info@result` | `result` | 1 = the reader won |
| `info@playerName`, `info@siteName` | `playerName`, `siteName` | enemy name, site name |
| `info@pos` | `pos` | `"x,y"` grid position |
| `info@mapId` | `mapId` | outer city map template id (`mapName` resolved from map templates) |
| `me@*`, `he@*` | `self*`, `enemy*` | `heroId` (hero template for the head), `site1Name`/`site1Count`, `site2Name`/`site2Count` (troop names and counts), `strategy`, `gold` (gold plundered), `fight` (power, string), `grade` (level), `crystal` |

The root element name is not read; `info`, `me` and `he` must be direct children of the root.

## 5. Rules and formulas

- Reports are regular mails for list, read, expiry and delete purposes; they never carry attachments ("Extrair" is disabled on this tab).
- Gold bonus text: if the reader has the Magic Spring buff, the client shows `floor(AddValue * gold / 100)` as bonus (`BattleReportItem.as:229`); the server must include the bonus in its own gold credit (Magic Spring feature).

## 6. Templates

| File | Use |
|---|---|
| map templates (`TempleteManager.mapTemplateCate`) | `MapName` for `mapId` |

## 7. Persistent state

Stored in `mail.mail` with `mail_type = 3`, `sender_id` null, `contents` = the XML above. No additional table.

## 8. Backend implementation notes

- Outer city battle resolution (castle and world features) calls `mail::battle_reports::write(attacker, defender, outcome)` which renders two XML bodies (one per side, `camp` 1 for the attacker) and delivers them with `mail::mailbox::deliver` inside the battle result transaction; push 148 after commit.
- Escape attribute values (player names may contain XML special characters).

## 9. Open questions and assumptions

1. Which battles create reports is defined by the outer city and castle features (Assumption: castle attack, resource site attack).
2. `strategy` and `crystal` meanings come from attribute names only.
3. Report validity (Assumption: 7 days).

## 10. Implementation checklist

- [ ] `mail::battle_reports::write` renders both XML bodies
- [ ] Reports appear in the reports tab and blink when unread
- [ ] Text report (`type=2`) layout
- [ ] Duel summary layout with win icon, power, gold, crystal
- [ ] Position link transfers on the same outer city map
- [ ] Test: names with `<`, `&`, quotes are escaped
