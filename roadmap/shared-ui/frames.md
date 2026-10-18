# Shared frames, alerts and scenes

Module `frames`. Generic client windows that are not tied to a single game system. All live under `decompiled/core_module/scripts/yishi/` except the task trace helpers in `decompiled/core_module/scripts/ui/tasktracebar/`.

## Base classes

| Class | Base | Purpose | Source |
|---|---|---|---|
| `BaseInputFrame` | `Frame` | input dialog with a title and a single search/input field ("Campo de entrada", "Condição de busca", confirm button) | `decompiled/core_module/scripts/yishi/view/base/BaseInputFrame.as` |
| `ViewBaseFrame` | `Frame` | empty shell frame used by views that build their content from a subclass | `decompiled/core_module/scripts/yishi/view/base/ViewBaseFrame.as` |
| `EmptyScene` | `BaseSceneView` | blank scene shown while a real scene loads or as a placeholder | `decompiled/core_module/scripts/yishi/scene/EmptyScene.as` |
| `CacheTipFrame` | `Frame` | frame that caches and shows a tooltip body | `decompiled/core_module/scripts/yishi/view/frame/CacheTipFrame.as` |

## Confirmation and alert frames

| Class | Base | pt-BR strings | Purpose | Source |
|---|---|---|---|---|
| `WithChoiceAlert` | `SimpleAlert` | | alert with a checkbox "do not warn again" | `decompiled/core_module/scripts/yishi/view/frame/WithChoiceAlert.as` |
| `UseBindPointWithChoiceAutoLayoutAlert` | `SimpleAlert` | "Diamante vinculado prioritário", "(Não participa no evento de consumo)" | bind-diamond spending prompt with the same opt-out layout | `decompiled/core_module/scripts/yishi/view/frame/UseBindPointWithChoiceAutoLayoutAlert.as` |
| `ChatInvieAlert` | `SimpleAlert` | "Utilizar a quantidade de ganhos diária" | alert about the daily chat invitation quota | `decompiled/core_module/scripts/yishi/view/frame/ChatInvieAlert.as` |
| `MultiFailedAlertFrame` | `Frame` | "Esse mapa tem dificuldade elevada, aconselhável elevar seu poder de combate antes de desafiá-lo.", "Aviso", "Não alertar mais" | warns that a map is above the player power before entering, remembered per map | `decompiled/core_module/scripts/yishi/view/frame/MultiFailedAlertFrame.as` |
| `ChildRemoveAlert` | `Frame` | "Abandonar Guardião", "Este Guardião irá desaparecer da lista dos Guardiões permanentemente.", "Não pode recuperar os atributos, habilidades e equipamento do Guardião.", "Favor inserir [YES] em baixo para confirmar." | guardian abandon confirmation, the player must type `YES` | `decompiled/core_module/scripts/ui/tasktracebar/view/ChildRemoveAlert.as` |
| `QteUpgradeTipFrame` | `Frame` | "Aviso", "Não alertar mais" | generic alert with an opt-out checkbox; despite living in the `yishi.view.guild` namespace it is raised by army skill upgrades and by battle entry (`decompiled/m5/scripts/armyII/SkillFrame.as`, `decompiled/core_module/scripts/battle/control/EnterBattleController.as`) | `decompiled/core_module/scripts/yishi/view/guild/QteUpgradeTipFrame.as` |

## Reward and animation frames

| Class | Base | pt-BR strings | Purpose | Source |
|---|---|---|---|---|
| `RaceAgainstTimeFrame` | `Frame` | "Coleta de Prêmio", "Você não passou, sem prêmios por enquanto!" | timed-mode result frame that pays a completion reward | `decompiled/core_module/scripts/yishi/view/frame/RaceAgainstTimeFrame.as` |
| `HookRewardFrame` | `Frame` | "Não há valor de experiência a ser obtido" | instant hook ("Gancho") reward summary | `decompiled/core_module/scripts/yishi/view/frame/HookRewardFrame.as` |
| `TransferAnimationView` | `Frame` | | item or currency transfer animation used by the task trace bar | `decompiled/core_module/scripts/ui/tasktracebar/view/TransferAnimationView.as` |

## Related

- Confirmation dialogs built on `SimpleAlert` are the shared pattern reused by every feature before a destructive action.
- The guardian abandon flow is described in [guardians/roster](../guardians/roster.md).
