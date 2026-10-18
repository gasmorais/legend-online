# Tooltip catalogue

Module `tips`. Every tooltip in `yishi.view.tips`. They all extend `BaseTip` (`decompiled/m16/scripts/yishi/view/tips/BaseTip.as`) unless the base column says otherwise, and are shown by the global `TipManager` / `ComponentFactory` machinery, usually fed a `tipData` object. Concrete sources are under `decompiled/m16/scripts/yishi/view/tips/` (imported as `m16` below) and `decompiled/core_module/scripts/yishi/view/tips/` (`core` below); item tooltips are under the `goods/` sub package. Text is resolved with `LanguageMgr.GetTranslation`; the pt-BR strings shown are the resolved values.

## 1. Generic text tooltips

| Class | Base | Labels (pt-BR) | Purpose | Source |
|---|---|---|---|---|
| `OneLineTip` | `BaseTip` | | one-line description popup, base of the multi-line variants | core |
| `MultipleLineTip` | `OneLineTip` | | the same body split over several lines | m16 |
| `MultipleDictionaryTip` | `BaseTip` | | rows of `key: value` pairs | m16 |
| `MultipleGoodsTip` | `BaseTip` | | grid of several item icons with a common header | m16 |
| `TimeTip` | `BaseTip` | | remaining time of a timed object | m16 |
| `BufferTips` | `BaseTip` | "Restante", "D", "M", "H", "<font color='#ff0000'>Prolongar até conclusão da Arena Einherjar da próxima semana</font>" | buff description, includes the Einherjar arena prolong note | m16 |
| `ExtraBufferTips` | `BaseTip` | | secondary buff line appended to `BufferTips` | m16 |
| `IMButtonTip` | `BaseTip` | | instant-messenger button tooltip | core |
| `TaskTraceTip` | `BaseTip` | "Fortuna da Guilda:", "Cristal de Luz:", "Prêmio de Conclusão", "Ouro:", "Experiência:", "Contribuição da Guilda:", "Prêmios de cada 50 ciclos", "Prêmio dos 200 ciclos" | guild activity trace bar rewards | core |
| `FavourTip` | `BaseTip` | "Amizade", "Adição de equipe", "Nível de amizade decide a adição quando estiver em mesma equipe do amigo" | friendship level and party bonus | m16 |
| `MarryTip` | `BaseTip` | "Atualmente você não contém parceiro(a)", "Hab. de Casamento:" | marriage status | m16 |
| `KingTips` | `BaseTip` | "(31 Dias)" | returning-king contract duration | m16 |
| `ExtralKingTips` | `BaseTip` | "Contrato dos Elfos" | extra king (elf) contract | m16 |
| `EastBlessTips` | `BaseTip` | "Bençãos do jogador" | east blessing list | m16 |
| `TmpTips` | `BaseTip` | | scratch tooltip filled at runtime | core |
| `MonsterTips` | `BaseTip` | "Monstro" | monster name and info | core |
| `ShopMainTips` | `BaseTip` | "Tem" | shop entry header | m16 |
| `FoisonHornRewardTips` | `BaseTip` | "Grande Pacote da Cornucópia", "Os jogadores que colecionarem todos os itens podem compartilhar os itens abaixo:" | cornucopia collection reward | m16 |
| `ContinuePayRebateChestIconTip` | `BaseTip` | | continuing-recharge rebate chest icon | m16 |

## 2. Entity and attribute tooltips

| Class | Base | Labels (pt-BR) | Purpose | Source |
|---|---|---|---|---|
| `HeroTip` | `BaseTip` | "Força", "Inteligência", "Liderança", "Cresimento", "Nível", "Profissão", "Proteção" | full hero stat popup fed a `ThaneInfo` | m16 |
| `HeroProfileTip` | `BaseTip` | | compact hero profile popup | m16 |
| `ThaneTip` | `BaseTip` | "Poder", "Nível", "Profissão" | short hero tooltip | m16 |
| `ChildrenFigureTip` | `BaseTip` | "P. Combate" | guardian figure preview with combat power | m16 |
| `PetFigureTip` | `BaseTip` | "Potencial", "Ataque", "Defesa", "Magia", "Resistência", "Proteção", "Crescimento", "Vida", "Inteligência", "Físico" | pet figure stats | m16 |
| `PetTip` | `BaseTip` | "Einherjar atual", "Antes de Refinar", "Depois de Refinar" | pet stat comparison before/after refining | m16 |
| `PetComposeCompareTip` | `BaseTip` | | pet compose attribute comparison | m16 |
| `PetHallowsLookTips` | `BaseTip` | "Arma Divina", "Estado", "Poder" | pet sacred weapon view | m16 |
| `RemotePetTip` | `BaseTip` | | remote pet detail | m16 |
| `RemotePetTurnTip` | `BaseTip` | "Drop aleatório", "Primeiro prêmio" | remote pet draw result | m16 |
| `DreamArenaPetTips` | `BaseTip` | "Ataque", "Defesa", "Magia", "Resistência", "Proteção", "Vida", "Inteligência", "Físico", "Força" | pet stats inside the dream arena | m16 |
| `DreamArenaTalismanTips` | `BaseTip` | "Efeitos do Conjunto" | talisman set effect in the dream arena | m16 |
| `VocationBranchTips` | `BaseTip` | "Atributos de tatuagem necessário:" | vocation branch requirements | m16 |
| `GoddessBufferTip` | `BaseTip` | | goddess buff detail | m16 |
| `DaimonSkillTip` | `BaseTip` | "Nível Tecnológico TM", "Decidido de acordo com nível de controle da Artilharia TM de todos os jogadores" | goddess skill scaled by TM artillery technology | m16 |

## 3. Item, equipment and skill tooltips

| Class | Base | Labels (pt-BR) | Purpose | Source |
|---|---|---|---|---|
| `EquipConciseTips` | `BaseTip` | "Refinar Equipamentos", "Nível atual:", "Próximo:", "Nível máximo atingido" | concise refine summary | m16 |
| `TwoEquipContrastTips` | `BaseTip` | | compare two pieces of equipment | `goods/` |
| `FourEquipContrastTips` | `BaseTip` | | compare four pieces of equipment | `goods/` |
| `JewelSuitTips` | `BaseTip` | "Selo da Alma", "Nível atual:", "Próximo:", "Nível máximo atingido" | soul seal jewel set | m16 |
| `RuneTips` | `BaseTip` | "Nível máximo atingido", "[Individual aleatório]", "[Aleatório duplo]", "[Todos]", "[Si mesmo]", "[Indivíduo com menor sangue]", "[Individual frontal]", "[Individual traseiro]", "[Linha frontal]", "[Linha traseira]" | rune effect targeting labels | `goods/` |
| `MagicCardTip` | `BaseTip` | | magic card detail | `goods/` |
| `SkillNotShowGradeTips` | `BaseTip` | "Passivo" plus the targeting labels | skill with the grade removed | `goods/` |
| `SkillShowCurrentGradeTips` | `BaseTip` | "Passivo" plus the targeting labels | skill with the current grade | `goods/` |
| `TalentTips` | `BaseTip` | "[Pulverização]", "[2 à 4 Aleatórios]", "[Prioridade em atacar jogador]", "Nível máximo atingido" plus targeting labels | talent detail | `goods/` |
| `ShopGoodsTips` | `EquipTip` | | goods detail inside a shop | `goods/` |
| `GroupbuyCheckTips` | `BaseTip` | | group-buy confirmation | `goods/` |
| `FashionComposeTip` | `BaseTip` | "Absorção de Moda Nível Atual", "Absorção de Moda Já está no nível máximo.", "Absorção de Moda Próximo Nível" | fashion absorption | `goods/` |
| `FundBuyItemTip` | `BaseTip` | "obterá os seguintes itens:" | fund purchase contents | m16 |
| `IntensifyTip` | `BaseTip` | | strengthen (intensify) preview | m16 |
| `TreasureIntensifyTip` | `BaseTip` | | treasure strengthen preview | m16 |
| `AncientArmoryTips` | `BaseTip` | | ancient armory (divine weapon) entry | m16 |
| `TheseusItemTip` | `BaseTip` | | Theseus item tooltip | m16 |
| `PawnSpecialTips` | `BaseTip` | | auto-chess pawn special trait | m16 |
| `WarlordMountTip` | `BaseTip` | "Validade: Permanente", "<font>Força +{0}</font>", "<font>Inteligência +{0}</font>", "<font>Movimentação +{0}%</font>" | warlord mount stat lines | m16 |
| `BuyAvartarTip` | `BaseTip` | | avatar purchase tooltip | m16 |
| `TimeBoxTip` | `BaseTip` | "Ao abrir o Baú de Tesouros do tempo poderá obter as seguintes recompensas" | time treasure box contents | core |

## 4. Feature, buff and reward tooltips

| Class | Base | Labels (pt-BR) | Used by |
|---|---|---|---|
| `BattleGuardItemTip` | `BaseTip` | "Anti-resistência, escudo de madeira, escudo de ferro, escudo de cobre, escudo de prata, escudo de ouro, escudo de diamante", "Não inserido" | [guardians](../guardians/README.md) |
| `ChildGrowthBufferTips` | `BaseTip` | "Ganhos de pontos totais de crescimento atual:", "Ganhos totais de crescimento do próx. nível:", "Nenhum" | [guardians](../guardians/README.md) |
| `ChildNSTalentItemTips` | `BaseTip` | "Próximo" | [guardians](../guardians/nursing-spirit.md) |
| `ChildNsEmblemResiUpTips` | `BaseTip` | | [guardians](../guardians/nursing-spirit.md) |
| `ChildPatrolItemTip` | `BaseTip` | | [guardians](../guardians/patrol.md) |
| `ChildPveRewardTip` | `BaseTip` | "Ao vencer o Boss pode obter prêmios:" | [guardians](../guardians/pve.md) |
| `SpiritExpeditionNodeTips` | `BaseTip` | "Drop de fase" | [guardians](../guardians/spirit-expedition.md) |
| `ConsortiaSkillTip` | `BaseTip` | | [guild](../guild/README.md) |
| `ConsortiaNewBossBufferTip` | `BaseTip` | "perde o efeito", "tempo válido" | [guild](../guild/README.md) |
| `ConsortiaNewBossDamageRewardTip` | `BaseTip` | "Meu dano:", "Prêmio de dano", "Prêmios:" | [guild](../guild/README.md) |
| `ConsrortiaBossRewardTips` | `BaseTip` | | [guild](../guild/README.md) |
| `GuildFbOneBuffTip` | `BaseTip` | "Condições:" | [guild](../guild/README.md) |
| `GuildFbPreviewBuffTip` | `BaseTip` | | [guild](../guild/README.md) |
| `CampaignMapPhysicsTip` | `MultipleDictionaryTip` | | [campaign](../campaign/README.md) |
| `MapPhysicsTip` | `MultipleDictionaryTip` | | [artillery](../artillery/README.md) |
| `LandUpTip` | `BaseTip` | "Nenhum", "Nível atual", "Nível máximo atingido", "Condições de elevamento", "Nível da Fazenda", "Condição de elevamento" | [farm](../farm/README.md) / [castle](../castle/README.md) |
| `TechnologyTip` | `BaseTip` | "Nível atual", "Necessário do nível", "Líder", "Recursos necessários", "Próximo", "Condição de elevamento", "Pré-requisito de estrutura", "Nível máximo" | [castle](../castle/README.md) |
| `WaterTreeTip` | `BaseTip` | | [farm](../farm/README.md) |
| `MazeFloorTips` | `BaseTip` | "Drop do piso" | [mazes](../mazes/README.md) |
| `SkyStepTip` | `BaseTip` | "Produção do Chefão atual:" | [treasures](../treasures/README.md) |
| `SinglePassRewardTip` | `BaseTip` | "Prêmio da Conclusão de Missão:", "Concluindo a Missão com Avaliação S poderá ganhar prêmios adicionais", "Acumulando obterá os seguintes pontos:", "Prêmio da 1ª Morte:" | [trials](../trials/README.md) |
| `SkyboxRaodRewardTips` | `BaseTip` | "Prêmio da Conclusão de Missão:" | [trials](../trials/README.md) |
| `BingoCardTips` | `BaseTip` | | [casino](../casino/README.md) |
| `CatToyTips` | `BaseTip` | "Ouro" | [cat-house](../cat-house/README.md) |
| `PVPLeagueRewardTips` | `BaseTip` | "Emblema da Liga" | [league](../league/README.md) |
| `ActiveVehicleBoxTip` | `BaseTip` | "Permanente", "seg" | [artillery](../artillery/README.md) |
| `VehicleBuffTip` | `BaseTip` | "seg" | [artillery](../artillery/README.md) |
| `MapVehicleBuffTip` | `BaseTip` | "seg" | [artillery](../artillery/README.md) |
| `DragonTalkerHeroEquipTips` | `BaseTip` | "Equipado", "Adição da purificação:" | [dragon](../dragon/README.md) |
| `DragonTalkerSymbioteContrastTips` | `BaseTip` | | [dragon](../dragon/README.md) |
| `DragonTalkerTalismanContrastTips` | `BaseTip` | | [dragon](../dragon/README.md) |

## 5. Notes

- `ShopGoodsTips` extends `EquipTip`, the equipment tooltip, so it renders the full equipment body.
- `Buffers`, `ExtraBufferTips` and `BufferTips` are pushed by the buff list message; see [battle](../battle/README.md) for `U_C_BUFFER_LIST`.
- Tooltip classes are referenced by string from UI XML and by `ComponentFactory`; adding a new one only requires the class plus its `var` assets.
