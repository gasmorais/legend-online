# Shared screens, alerts and tooltips ("Telas, avisos e dicas compartilhados")

Feature slug `shared-ui`, domain platform. This feature owns the generic user interface infrastructure reused by every other feature: the tooltip library (`yishi.view.tips`), the base frame/input classes (`yishi.view.base`), the generic alert and small frames (`yishi.view.frame`), the empty scene, and a handful of one-off frames that belong to the platform layer (anti-addiction alert, guardian removal confirmation, transfer animation, instant hook reward).

It has no client or protobuf package of its own (`yishi`, `ui`, `mainBar`, `mvc`, `map`, `com`, `simplegame` are listed as infrastructure in `tools/featuremap.py`), so the code lives under those shared packages. Whenever another feature doc references a shared tooltip or base frame, it points here.

## Modules

| Module | Scope |
|---|---|
| [frames](frames.md) | base frame and input classes, scene, generic alerts, confirmation frames, task trace helpers |
| [tips](tips.md) | every `yishi.view.tips.*` tooltip: generic text, entity/attribute, item/equipment, feature reward and buff tooltips |

## Conventions used here

- Tooltips extend `BaseTip` (`decompiled/m16/scripts/yishi/view/tips/BaseTip.as`) unless noted. They are instantiated by name through `TipManager` / `ComponentFactory` and fed a `tipData` object.
- Text is resolved through `LanguageMgr.GetTranslation("<key>")`. The pt-BR strings below come from `raw/ui/zh_cn/decoded/language.txt` and the decoded XML under `raw/ui/zh_cn/xml/decoded/`.
- The `yishi` package is the shared UI layer of the client; it is not a feature by itself.

## Dependencies

- [battle](../battle/README.md): `SpTip`, `AttackModeBtnTip`.
- [einherjar](../einherjar/README.md): the pet tooltips.
- [guardians](../guardians/README.md): the child tooltips.
- [hero](../hero/README.md): `HeroTip`, `HeroProfileTip`, `ThaneTip`.
- Every feature with reward chests uses `TimeBoxTip`, `MultipleGoodsTip` and `SinglePassRewardTip`.
