# Loading doctor (client diagnostics)

Area: customer-service, module `loading-doctor`. Covers the "doctor" button of the loading screen (`m18/scripts/doctor`): a client-only diagnostic that re-downloads every MD5 checked client file, verifies it, tests `crossdomain.xml`, and lets the player copy a report to send to support. There is no game server protocol; the backend only has to serve the files and the policy file correctly.

Conventions: see [support-tickets.md](support-tickets.md). Paths are relative to the repository root.

## 1. Overview

While the game loads, the loading screen (`MaxLoading`) shows "notice" ([../account/notices.md](../account/notices.md)) and "doctor" buttons. Doctor loads module `18.png` on demand, lists the files of `ComponentSetting.checkMD5`, and on "start" downloads them one after another, checking each against its MD5 from the manifest. The report includes OS, Flash Player version and type, browser user agent and the crossdomain test. The final text asks the player to copy the result and send it to the support team ("SAC"), then clear the browser cache.

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `doctor.DoctorFrame` (`decompiled/m18/scripts/doctor/DoctorFrame.as:59`) | final text "Verificação dos documentos concluída, caso tenha aviso de erro, copie, salve e envie ao nosso SAC. ...", "Copiado com sucesso" (`DoctorFrame.as:244-259`) | Run checks, copy report | Loading screen doctor button (`decompiled/Loading/scripts/loading/MaxLoading.as:232-258`), mutually exclusive with the notice frame | File list, per file progress and result, system info |
| `doctor.view.LoaderInfoItem` (`decompiled/m18/scripts/doctor/view/LoaderInfoItem.as:47`) | "Progresso: Aguardando...", "Carregando arquivo...", "Verificando arquivo...", "Verificação do arquivo sucedido", "Falha na verificação do arquivo" | One file check | Frame | Progress percent and result |
| `doctor.DoctorStyle` | n/a | Registers the module UI styles | Frame creation | n/a |

## 3. Routes (client to server)

| Action | Sender | Request | Response use |
|---|---|---|---|
| Download each checked file | `LoaderInfoItem.start` (`LoaderInfoItem.as:94-106`) | `GET` the full CDN path of each key of `ComponentSetting.checkMD5` (`DoctorFrame.as:210-225`) | Bytes compared with `ComponentSetting.compareMD5` (`LoaderInfoItem.as:164-185`) |
| Crossdomain test | `DoctorFrame.tryCrossDomain` (`DoctorFrame.as:186-193`) | `GET {ResourcePath}crossdomain.xml` | IO error, success or sandbox error lines in the report |

No socket opcode and no servlet.

## 4. Server messages (server to client)

None.

## 5. Rules and formulas

- MD5 check: a file passes only when its path has a manifest MD5 and the downloaded bytes match it (`LoaderInfoItem.as:164-185`); files without an MD5 entry are reported as failures.
- The report is copied to the clipboard as plain text (`DoctorFrame.as:254-259`).

## 6. Templates

None. Inputs are the CDN manifest (`index/res_md5.raw`, `index/code_md5.raw`, served by `server/src/main.rs` `manifest`) and `crossdomain.xml`.

## 7. Persistent state

None. Reports reach the team through [support-tickets.md](support-tickets.md) when the player pastes them into a ticket.

## 8. Backend implementation notes

- Serve `crossdomain.xml` at the root of `ResourcePath` allowing the game origin (in the web port the runtime does not enforce it, but keep it for fidelity).
- Make sure every file in the manifest is served with the exact bytes the MD5 describes (the CDN handler in `server/src/main.rs` already strips the hash suffix).
- No Rust game handler is needed (`customer_service::loading_doctor` stays empty).

## 9. Open questions and assumptions

- Open: the exact content of `ComponentSetting.checkMD5` at run time depends on the manifest loaded by the loader.

## 10. Implementation checklist

- [ ] `crossdomain.xml` served at `ResourcePath`
- [ ] Manifest files served byte exact
- [ ] Test: doctor run on a clean install reports every file as "Verificação do arquivo sucedido"
