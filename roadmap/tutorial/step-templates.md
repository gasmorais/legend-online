# Step templates

Area: tutorial, module `step-templates`. Covers `U_C_STEP_MSG` 321 ("阶段模板数据", stage template data) and the `step` proto package (`StepListMsg`, `StepMsg`). Despite being registered under this feature, the only client consumer is the Arma Divina gift activity progress bar (`ArtifactManager`, [divine-weapon](../divine-weapon/README.md)).

Conventions: see [README.md](README.md).

## 1. Overview

The server pushes a list of stage records. The client keeps them in `ArtifactManager._stepTempDic` keyed by `step` and uses them to draw the activity score bar: the score needed for the next stage, the cumulative score, and the stage count. There is no request; the data must be pushed before the player opens the activity frame (Assumption: at login when the activity is open, next to 323 and 322).

## 2. Screens

| Class | pt-BR text | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `artifact.ArtifactProgressView` (`decompiled/m11/scripts/artifact/ArtifactProgressView.as:160`) | progress tip "Sempre que completar um nível tem a chance de sortear uma vez\nNível atual/Nível total: {0}/{1}\nPontos totais necessários: {2}/{3}" (`artifact.ArtifactBoxView.progressStrip`); progress text "score/next" or "max" | Score bar of the gift activity | Arma Divina gift activity frame ([divine-weapon](../divine-weapon/README.md)) | `ArtifactGiftActivityMsg.ScoreStep`, `Score`, step templates |

## 3. Routes (client to server)

None. The activity operations (9580 `C_ARTIFACT_GIFT_ACTIVITY` with op 0, 1, 2 from `ArtifactProgressView.as:155`, `ArtifactBoxView.as:274`, `:282`) belong to [divine-weapon](../divine-weapon/README.md).

## 4. Server messages (server to client)

| Route | Message and fields | When | Client handler and effect |
|---|---|---|---|
| S>C 321 0x0141 `U_C_STEP_MSG` | `StepListMsg` (package `step`): `type (#1, INT32)` list mode; `step (#2, StepMsg, repeated)`. `StepMsg`: `Id (#1, INT32)` record id, `Name (#2, STRING)` label, `Type (#3, INT32)` record type, `Step (#4, INT32)` stage number (dictionary key), `Value (#5, INT32)` score needed to complete this stage | Push before the gift activity UI is used (Assumption: login and whenever the activity configuration changes) | `ArtifactManager.__stepTempHandler` `decompiled/core_module/scripts/yishi/manager/ArtifactManager.as:68` (listener `:62`, set up from `decompiled/core_module/scripts/yishi/lunch/Yishi.as:440`). `type == 0`: rebuild the dictionary keeping only records with `Type == 1` (`:76`). `type == 1`: rebuild with every record (`:96`). Any other `type`: ignored. Records with the same `Step` overwrite each other |

## 5. Rules and formulas

From `ArtifactManager` (`decompiled/core_module/scripts/yishi/manager/ArtifactManager.as`):

- Max stage = greatest `Step` (`getMaxStep` `:197`). When `ScoreStep >= maxStep` the bar shows "max" at 100% (`decompiled/m11/scripts/artifact/ArtifactProgressView.as:172`).
- Score needed for the next stage = `Value` of the record with `Step == ScoreStep + 1` (`getNextStepTemp` `:220`); bar percent = `Score / Value * 100` (`ArtifactProgressView.as:180`).
- Total score earned = `Score + sum(Value for Step <= ScoreStep)` (`getCurrentTotalScore` `:237`).
- Total score of all stages = `sum(Value)` (`getAllScore` `:210`).
- So `Value` is the per stage increment and `Score` resets to 0 at each stage; the server activity logic must use the same model (Assumption).

## 6. Templates

No tempinfo file matches this data (no `StepTemp*` file in `raw/xml/tempinfos/`; `StelaStepTemplates.xml`, `GoddessStepTemplates.xml` and `SkyStepDrop.xml` belong to other features). The content is server configuration.

## 7. Persistent state

```sql
CREATE TABLE tutorial.step_template (
    list_kind   smallint    NOT NULL DEFAULT 1,        -- which activity set; 1 = Arma Divina gift activity (Assumption)
    id          integer     NOT NULL,                  -- StepMsg.Id
    name        text        NOT NULL DEFAULT '',       -- StepMsg.Name
    record_type smallint    NOT NULL DEFAULT 1,        -- StepMsg.Type (only 1 is kept when StepListMsg.type = 0)
    step        smallint    NOT NULL CHECK (step > 0), -- StepMsg.Step
    score_value integer     NOT NULL CHECK (score_value > 0), -- StepMsg.Value
    PRIMARY KEY (list_kind, id),
    UNIQUE (list_kind, record_type, step)
);
```

Per player progress (`Score`, `ScoreStep`) is activity state owned by [divine-weapon](../divine-weapon/README.md).

## 8. Backend implementation notes

- `tutorial::step_templates::push_step_list(player, list_kind)`: read rows ordered by `step`, send 321 with `StepListMsg.type = 1` (send every record) to avoid the client filter. Called by the divine weapon activity at login (when the activity is open) and on configuration reload (broadcast to online players).
- No request handler.
- The activity score logic must treat `score_value` as the increment of stage `step`.

## 9. Open questions and assumptions

- The meaning of `StepListMsg.type == 0` versus 1 and of `StepMsg.Type` beyond "1 kept in mode 0" is unknown.
- Whether other features (not present in this client build) consumed 321 is unknown; the feature registry placed it in tutorial.
- Push timing is an assumption; the client shows "max" or divides by an undefined record if 321 is missing (`getNextStepTemp` returns null and the view would throw).

## 10. Implementation checklist

- [ ] Table `tutorial.step_template` with seed data for the gift activity
- [ ] Server message 321 push at login when the activity is open
- [ ] Rule: `score_value` is the per stage increment
- [ ] Test: progress bar shows `score/value` of stage `ScoreStep + 1` and "max" at the last stage
- [ ] Test: tip shows cumulative and total scores
