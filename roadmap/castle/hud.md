# Castle HUD entry points

Aliases: see [README.md](README.md). Extra aliases (all under `decompiled/core_module/scripts/`):

| Alias | File |
|---|---|
| SMB | `mainBar/SmallMapBar.as` |
| MTB | `ui/maintoolbar/MainToolBar.as` |
| TTB | `ui/toptoolbar/TopToolsBar.as` |
| RV | `ui/resourcebar/view/ResourceView.as` |
| CHB | `mainBar/ChatBar.as` |
| TBV | `mainBar/TimeBoxView.as` |
| TSV | `ui/toptoolbar/view/TargetSelectView.as` |
| TTV | `ui/tasktracebar/view/TaskTraceView.as` |
| TTI | `ui/tasktracebar/view/TaskTraceItem.as` |
| SHB | `ui/tasktracebar/view/SelfHelpButtonView.as` |
| SMBV | `ui/tasktracebar/view/SpaceMapButtonView.as` |
| NTTV | `ui/tasktracebar/view/NewbieTaskTraceView.as` |
| CFV | `ui/resourcebar/view/ChildrenFigureView.as` |
| TBIV | `ui/toptoolbar/TopBtnItemView.as` |

## 1. Overview

`CastleSceneView.enterOver` shows the HUD bars `TopToolsBar`, `MainToolBar`, `TipsBar`, `FullBar`, `QueueBar`, `ChatBar`, `TaskTraceBar`, `SmallMapBar`, `ResourcesBar` (`decompiled/m4/scripts/castle/CastleSceneView.as:101-110`) and hides them on `leaving` (`:405-413`). This module lists every clickable entry of those bars and the feature folder that owns the opened screen and its server traffic. The castle owns only the scene buttons, the resource counters ([resources.md](resources.md)) and the activity queue list ([activity-queue.md](activity-queue.md)).

Data source: handlers resolved from the decompiled code, cross checked with `docs/ui/navigation.md` and `data/navigation.json`. Level conditions are client gates; the owning feature must enforce them server side.

## 2. Screens

The HUD bars are views, not frames. Each row below is an entry point.

### SmallMapBar (SMB, top right)

| Button | Label (pt-BR) | Handler | Opens | Condition | Owner |
|---|---|---|---|---|---|
| `_returnCastleBtn` | "Transferir de volta à cidade" | `SMB:1105` | hero back to the castle on the world map | | [../world-map/README.md](../world-map/README.md) |
| `_transmitBtn` | "Transferir Herói para qualquer lugar" | `SMB:1125` | hero teleport mode | Leader >= 15 | [../world-map/README.md](../world-map/README.md) |
| `_attackBtn` | "Atacar outro jogador  Atalho:X" | `SMB:1114` | attack mode | Leader >= 15 | [../world-map/README.md](../world-map/README.md) |
| `_zoomBtn` | "Localizar entrada de coordenadas" | `SMB:1144` | coordinate input | | [../world-map/README.md](../world-map/README.md) |
| `_spaceBtn` | "Ir ao Reino dos Ceús" | `SMB:854` | sends 8688, sky realm | Leader >= 16 | [../sky-realm/README.md](../sky-realm/README.md) |
| `_castleBtn` | "Ir ao Castelo" | `SMB:859` | scene `CASTLE_SCENE` (8747) | Leader >= 11 | castle, [scene.md](scene.md) |
| `_outercityBtn` | world map | `SMB:864` | `worldmap` > `WorldMapFrame` | Leader >= 15 | [../world-map/README.md](../world-map/README.md) |
| `_skipNewbieBtn` | skip tutorial | `SMB:898` | local | novice map only | [../tutorial/README.md](../tutorial/README.md) |
| `_dayGuideBtn` | "Guia Diário" | `SMB:877` | `newactiveleed` > "Pontos de Atividade" | Leader >= 11 | [../daily-activity/README.md](../daily-activity/README.md) |
| `_pvpHelpBtn` | help | `SMB:870` | `worldboss.pvpHelperFrame` | | [../world-boss/README.md](../world-boss/README.md) |
| `_updateBtn` | "Anúncio de Atualização" | `SMB:823` | `UpdateBroadCastFrame` | Leader >= 16 | [../account/README.md](../account/README.md) |
| `_setBtn` | "Configuração" | `SMB:703` | `setting` > `SettingFrame` | | [../account/README.md](../account/README.md) |
| `_rankingBtn` | "Ranking" | `SMB:709` | `shoubang` > "1º Ranking" | | [../rankings/README.md](../rankings/README.md) |
| `_mailBtn` | "Email" | `SMB:766` | `email` > `EmailFrame` | Leader >= 6 | [../mail/README.md](../mail/README.md) |
| `_othersShowBtn`, `_othersHideBtn` | "Mostrar Jogadores", "Ocultar Jogadores" | `SMB:782`, `SMB:789` | local visibility toggle | `canHideCampaign()` | [../campaign/README.md](../campaign/README.md) |
| `_customerServiceBtn` | "Comentário" | `SMB:689` | `customerservice` | config `CUSTOMER_SERVICE` | [../customer-service/README.md](../customer-service/README.md) |
| `_funPreviewBtn` | "Ver Função" | `SMB:892` | `funpreview` > `FunPreviewFrame` | | [../tutorial/README.md](../tutorial/README.md) (assumption, package not in the registry) |
| `_guideTaskBtn` | "Objetivo dos 7 dias" | `SMB:523` | `guidetask` 1 | | [../tutorial/README.md](../tutorial/README.md) |
| `_faceBookBtn` | Facebook | `SMB:1175` | local share | config `FACE_BOOK`, Leader >= 20 | [../friends/README.md](../friends/README.md) |

### MainToolBar (MTB, bottom)

Each main button can have a small second button (`.child`).

| Button | Label (pt-BR) | Handler | Opens | Condition | Owner |
|---|---|---|---|---|---|
| `_armyBtn` | "Guarda / Atalho A" | `MTB:2193` | `child` main > "Guardião" | Leader >= 70 | [../guardians/README.md](../guardians/README.md) |
| `_armyBtn.child` | | `MTB:2193` | `childnursingspirit` > "Espirito de Proteção" | Leader >= 70 | [../guardians/README.md](../guardians/README.md) |
| `_petBtn` | "Einherjar / Atalho Y" | `MTB:1500` | `pet` > "Einherjar" | pet system open, Leader >= 50 | [../einherjar/README.md](../einherjar/README.md) |
| `_petBtn.child` | | `MTB:1500` | `pethallows` 1 > "Armas Divinas" | same | [../einherjar/README.md](../einherjar/README.md) |
| `_storeBtn` | "Ferreiro / Atalho T" | `MTB:2170` | `STORE_PANEL_INTENSIFY` > "Fabricar" | Leader >= 7 | [../smith/README.md](../smith/README.md) |
| `_storeBtn.child` | | `MTB:2170` | `stelesys` > "Estela" | Leader >= 7 | [../steles/README.md](../steles/README.md) |
| `_skillBtn` | "Habilidade / Atalho S" | `MTB:2212` | `SKILL_PANEL` > "Habilidade" | Leader >= 7 | [../skills/README.md](../skills/README.md) |
| `_skillBtn.child` | | `MTB:2212` | `goddess` > `GodDessFrame` | Leader >= 7 | [../goddess/README.md](../goddess/README.md) |
| `_bagBtn` | "Mochila / Atalho B" | `MTB:2230` | `EQUIP_PANEL` > `ArmyFrameII` "Equipamentos" | Leader >= 4 | [../inventory/README.md](../inventory/README.md) (frame code in [../army/README.md](../army/README.md)) |
| `_bagBtn.child` | | `MTB:2230` | `ancientartifact` > "Arma Divina" | Leader >= 4, `ANCIENTARTIFACT` switch | [../divine-weapon/README.md](../divine-weapon/README.md) |
| `_dragonTalkerBtn` | "Atalho D" | `MTB:2292` | `dragontalker` > "Encantador de Dragões" | class advanced | [../dragon/README.md](../dragon/README.md) |
| `_dragonTalkerBtn.child` | | `MTB:2292` | `dragontitan` > "Titã" | class changed, titan template | [../dragon/README.md](../dragon/README.md) |
| `_friendsBtn` | "Amigo / Social" | `MTB:2315` | `FriendsFrame` "Social" | Leader >= 6 | [../friends/README.md](../friends/README.md) |
| `_marryBtn` | "Alguém pediu você em casamento" | `MTB:712` | `marry` RECEIVE | proposal pending | [../marriage/README.md](../marriage/README.md) |
| `_consortiaBtn` | "Guilda / Atalho G" | `MTB:2151` | `consortia` 1 | Leader >= 13, no Athena team | [../guild/README.md](../guild/README.md) |
| `_poptipBtn` | "Chat da Guilda" | `MTB:2503` | `consortiagroupchat` | in a guild | [../guild/README.md](../guild/README.md) |
| `_campaignBtn` | "Campanha / Atalho Z" | `MTB:1360` | `selectcampaign` | novice process >= 23000 | [../campaign/README.md](../campaign/README.md) |
| `_outerCityBtn` | "Arredores / Atalho Q" | `MTB:1372` | scene `OUTER_CITY_SCENE` | Leader > 12 | [../world-map/README.md](../world-map/README.md) |
| `_castleBtn` | "Cidade / Atalho Q" | `MTB:1385` | scene `CASTLE_SCENE` (8747) | | castle, [scene.md](scene.md) |
| `_archaeologyBtn` | "Atalho R" | `MTB:2336` | `archaeology` | Leader >= 15, no Athena team | [../archaeology/README.md](../archaeology/README.md) |
| `_archaeologyBtn.child` | | `MTB:2336` | `theseussoul` > "Alma de Teseu" | Leader >= 15 | [../theseus/README.md](../theseus/README.md) |
| `_payBtn` | recharge | `MTB:1391` | external recharge page | | [../recharge/README.md](../recharge/README.md) |
| `_shopBtn` | "Loja / Atalho O" | `MTB:1543` | `shop` | Leader >= 10 | [../shops/README.md](../shops/README.md) |
| `_returnBtn` | "Voltar" | `MTB:1549` | leaves the current scene (sends the scene leave opcode, for example 8688, 8636, 8662, 8835) and returns to `CASTLE_SCENE` | outside the castle | castle ([scene.md](scene.md)); leave opcodes by scene owner |
| `_recommendBtn` | new friends | `MTB:1409` | `RecommendFriendFrame` | 12 friends and recommendations | [../friends/README.md](../friends/README.md) |
| `_mountBtn` | "Montaria / Atalho P" | `MTB:1417` | `mounts` 1 | Leader >= 16 | [../mounts/README.md](../mounts/README.md) |
| `_mountBtn.child` | | `MTB:1417` | `monster` > "Monstro" | Leader >= 16 | [../monsters/README.md](../monsters/README.md) |
| `_InviteBtn` | friend invite | `MTB:976` | `ToolInviteFriendFrame` | | [../friends/README.md](../friends/README.md) |
| `_applyJoinTeamBtn` | team application | `MTB:981` | `ToolJoinTeamFrame` "Aplicar para a Equipe" | | [../team/README.md](../team/README.md) |
| `_crossGoOnBtn`, `_crossCancelBtn` | cross server match | `MTB:768` | sends 25156 `CR_MULTICAMPAIGN_MATCH` | matching | [../campaign/README.md](../campaign/README.md) |
| `_starBtn` | "Astrologia / Atalho H" | `MTB:1523` | `star` | Leader >= 18 | [../cosmos/README.md](../cosmos/README.md) |
| `_starBtn.child` | | `MTB:1523` | `avenger` > "Vingador" | Leader >= 18 | [../avenger/README.md](../avenger/README.md) |

### TopToolsBar chrome (TTB)

| Button | Handler | Opens | Owner |
|---|---|---|---|
| `_topCondenseBtn`, `_topExtrudeBtn` | `TTB:627`, `TTB:602` | collapse / expand the icon bar, local | castle HUD |
| `preBtn`, `nextBtn` | `TTB:511`, `TTB:517` | icon pages, local | castle HUD |
| `_extralItem` and `ExtraBufferItem` icons | `TTB:2417`, `decompiled/core_module/scripts/ui/toptoolbar/view/ExtraBufferItem.as:72-110` | buff icons: 1 guild skills > `consortia` ([../guild/README.md](../guild/README.md)); 2 technologies > Santuário ([technologies.md](technologies.md)); 3 blessing (never created); 5 battlefield transport cancel 8535 ([../world-boss/README.md](../world-boss/README.md)); 21 titles > `appell` ([../hero/README.md](../hero/README.md)); 20000 fashion ([../fashion/README.md](../fashion/README.md)) | per buff |
| `TopBtnItemView.btn` | `TBIV:709` | dispatches `TOPTOOLBAR_BUTTON_CLICK` with the icon key | see activity icons |

### Activity icons (TTB, `__onTopBtnClickHandler`, `TTB:1016`)

Icons are data driven (`TopToolBtnInfos`); the key decides the target.

| Key | Label (pt-BR) | Opens / sends | Owner |
|---|---|---|---|
| `renotereward` | "Prêmio de Expedição" | sends 9544 `C_REMOTE_PET_OP` | [../einherjar/README.md](../einherjar/README.md) |
| `exchargeall` | "Recarga Total" | `exchargeall` | [../cross-server/README.md](../cross-server/README.md) |
| `first`, `recharge`, `newfirstpay` | "Pacote de Primeira Recarga" | `firstpay`, `rechargetime`, `newfirstpay` | [../recharge/README.md](../recharge/README.md) |
| `matelords` | "Batalha de Vênus" | `matelords` | [../venus-battle/README.md](../venus-battle/README.md) |
| `question`, `newquestion`, `feedback`, `mailcheck` | "Pesquisa de Questionário", "Pacote de Feedback de Recarga", "Verificação de Email" | `questionnaire`, `question`, `feedback`, `mailcheck` | [../customer-service/README.md](../customer-service/README.md) |
| `skytreasure1` | "Tesouro celeste" | `skytreasure1` | [../treasures/README.md](../treasures/README.md) |
| `online`, `timing` | "Pacote Online", "Pacote Online Fixo" | `onlinereward` 14 / 50 (Leader >= 11) | [../daily-activity/README.md](../daily-activity/README.md) (assumption, package not in the registry) |
| `karneval` | "Loucura do Povo" | `onlinereward` 51 | [../seasonal-events/README.md](../seasonal-events/README.md) |
| `funny`, `tiro` | "Destaques", "Evento da Abertura do Servidor" | `funny`, 8586 | [../seasonal-events/README.md](../seasonal-events/README.md) |
| `crosspvpreward` | "Prêmio Inter-Servidores" | sends 8590 | [../cross-server/README.md](../cross-server/README.md) |
| `bottle` | "Árvore de Ouro" | sends 8604 | [../golden-tree/README.md](../golden-tree/README.md) |
| `petweedreward`, `petboss` | "Prêmio semanal de Arena de Einherjar", "Ilha da Proteção de Einherjar" | 8728, `petboss` | [../einherjar/README.md](../einherjar/README.md) |
| `fund`, `fundnewbie` | "Minas do Tesouro", "Minas de Iniciante" | 8703, `fundnewbie` | [../mines/README.md](../mines/README.md) |
| `regression1`, `regression2`, `regress`, `kingback`, `oldplayerreturn`, `oldplayerreturn2` | "Pacote do novo rei", "Pacote do Regresso", "Privilégios de Velhos jogadores" | 8634, 8860, `oldbacker`, `kingback`, `oldplayerreturn` | [../returning-players/README.md](../returning-players/README.md) |
| `lottery`, `chargelottery`, `pumpingjoy`, `foisonhorn`, `luckylottery`, `wishpool` | "Roleta da Sorte", "Roleta de Recarga", "Gashapon", "Grande prêmio da Alegria" | same keys | [../lotteries/README.md](../lotteries/README.md) |
| `newyear`, `newyearlottery`, `cultureactive`, `goldendionysia`, `publicegg_total`, `publicegg_egg`, `publicegg_sumgift`, `sumcampaign`, `raveparty`, `carnival`, `christmas`, `sevenyear` | "Login do Ano Novo", "Baú da Sorte", "Evento de Adestração", "Carnaval de Ouro", "Carnaval do Verão", "Verão 9 dias", "Festa do Carnaval", "Festival da Folia" | same keys, 9639 | [../seasonal-events/README.md](../seasonal-events/README.md) |
| `crossgvg` | "Defesa de Guilda" | `crossguild`, 8650 | [../guild/README.md](../guild/README.md) |
| `limitbuy`, `discountshop`, `mvpshop` | "Compra Limitada", "Loja de Descontos", "MVP geral" | `timebuy`, `discountshop`, `mvpshop` | [../shops/README.md](../shops/README.md) |
| `crosscost`, `stokesore` | "Consumo do Povo" | `crosscost`, `stokesore` | [../cross-server/README.md](../cross-server/README.md) |
| `answer` | "Respostas online" | `answer` | [../quiz/README.md](../quiz/README.md) |
| `goldroad` | "Caminho de Ouro" | `goldroad` | [../roads/README.md](../roads/README.md) |
| `loginactive`, `supersignincard`, `daylight` | "Evento de login", "Super cartão de check-in" | `loginactive`, `supersignincard`, 9670 | [../daily-activity/README.md](../daily-activity/README.md) |
| `slot`, `blackjack`, `bingo`, `poker`, `apex`, `gamehall` | "Caça-Niquel", "Chegada do BlackJack", "Maça Alegre", "Texas Poker", "Liga do Pico", "Salão de jogo" | same keys, 5439 | [../casino/README.md](../casino/README.md) |
| `hallfame` | "Evento do corredor da fama" | `hallfame` | [../medals/README.md](../medals/README.md) |
| `auctionsale` | "Sistema do Leilão" | `sale` | [../auction/README.md](../auction/README.md) |
| `artifact` | "Roleta da Arma Divina" | `artifact` | [../divine-weapon/README.md](../divine-weapon/README.md) |
| `outyard` | "Terrálem" | `outyard` 3 | [../outyard/README.md](../outyard/README.md) |
| `outyardreward` | "Prêmio da Luta" | sends 9594 `C_HUGE_HEAD_REQUEST` | [../auto-chess/README.md](../auto-chess/README.md) |
| `luckyexchange`, `allmanexchange` | "Troca da Sorte", "Troca geral" | same keys | [../exchange/README.md](../exchange/README.md) |
| `publicchairs`, `continuepayrrbate`, `encoGold`, `wholerebate` | "Recarga de coletivo", "Evento de recarga contínua", "Ouro da Incentivação", "Compensação Geral" | same keys | [../recharge/README.md](../recharge/README.md) |
| `pandora` | "Caixa de Pandora" | `pandora` | [../inventory/README.md](../inventory/README.md) |
| `registwelfare`, `monthcard`, `customizedvip` | "Privilégio de Novatos", "Pacote personalizado VIP" | same keys | [../vip/README.md](../vip/README.md) |
| `wedding` | "Cerimónia de Casamento" | `marry` QUALITY_SELECT | [../marriage/README.md](../marriage/README.md) |
| `areslords` | "Batalha de Ares" | sends 9615 | [../ares-battle/README.md](../ares-battle/README.md) |
| `braveleg` | "Batalha de Athena" | sends 9619 | [../athena-battle/README.md](../athena-battle/README.md) |
| `pvp`, `dreamarena` | "Arena", "Arena Ilusória" | `pvproomlist`, `dreamarena` | [../arena/README.md](../arena/README.md) |
| `rvr1`, `worldboss` | "Campo de Batalha", "Chefão Global" | `worldboss` 3 / 1 | [../world-boss/README.md](../world-boss/README.md) |
| `vehicel` | "Julgamento TM" | `vehicleroomlist` | [../artillery/README.md](../artillery/README.md) |
| `crossmuticampaign` | "Campanha Multiplayer" | `pveroomlist` | [../campaign/README.md](../campaign/README.md) |
| `childArena`, `childarenareward` | "Arena de Guardiao", "Prêmios de Guardião Leida" | `childarena`, 9657 | [../guardians/README.md](../guardians/README.md) |
| `giftwill`, `magicspring` | "Bar da Fantasia", "Fonte Mágica" | `magicpub` 0 (Leader >= 32), `magicspring` | [../fantasy-bar/README.md](../fantasy-bar/README.md) |
| `unrealshooting`, `landmine` | "Caça Fantástica", "Campo de Minas" | same keys | [../final-defense/README.md](../final-defense/README.md) |
| `godsevening` | "Hegemonia dos Três Reinos" | `godsevening` | [../three-kingdoms/README.md](../three-kingdoms/README.md) |
| `platinum` | "Pote Mágico de platina" | `platinum` | [../laboratory/README.md](../laboratory/README.md) |
| `darkmaze` | Labirinto Negro | scene `DARK_MAZE_SCENE` | [../mazes/README.md](../mazes/README.md) |
| `timebox1` | time box | local | [../inventory/README.md](../inventory/README.md) |
| `newmemorycard`, `sqmomery` | "Jogo da memória" | `newmemorycard`, 9716 | [../memory-games/README.md](../memory-games/README.md) |
| `secretwar` | "Batalha do Eremitério" | `secretwar` | [../hermitage-war/README.md](../hermitage-war/README.md) |

### ResourceView (RV, top left)

| Button | Label | Handler | Opens | Condition | Owner |
|---|---|---|---|---|---|
| `_icon` | portrait | `RV:740` | `ATTRIBUTE_PANEL` > `ArmyFrameII` | Leader >= 5 | [../hero/README.md](../hero/README.md) |
| `_normalVipBtn`, `_getVipBtn` | "Clique para ativar VIP" | `RV:760` | `vip` > "Recarga VIP" | VIP state | [../vip/README.md](../vip/README.md) |
| `_fullScreenMc` | "Tela Cheia" | `RV:393` | local | | castle HUD |
| `_jobChangeBtn` | "Clicar para trocar de profissão" | `RV:641` | sends 9667 `C_DRAGONTALKER_OP` | | [../dragon/README.md](../dragon/README.md) |
| `_secretaryBtn` | Pequena Secretária | `RV:342` | `SECRETARY` > `LittleSecretaryFrame` | | [../secretary/README.md](../secretary/README.md) |
| gold, crystal counters | "Ouro", "Cristal de luz" | tooltips only | | | castle, [resources.md](resources.md) |
| `ChildrenFigureView` strips (CFV:320, CFV:361) | "Você ainda não tem Guardião", "Você ainda não tem Einherjar" | local | | | [../guardians/README.md](../guardians/README.md), [../einherjar/README.md](../einherjar/README.md) |

### QueueBar (QB, left)

| Entry | Handler | Opens | Owner |
|---|---|---|---|
| `_expBackBtn` | `QB:725` | `expback` > "Recuperação de EXP" (Leader >= 40, `RECOVER_BAK`) | [../returning-players/README.md](../returning-players/README.md) |
| `_upgradePresentBtn` | `QB:748` | `upgradepresent` > "Apoio de Elevação" | [../vip/README.md](../vip/README.md) |
| `_heroRoadBtn`, `_heroRoadBtn2`, `_popBtn` | `QB:731`, `QB:737` | `heroroad` > "Histórico de Conquistas", gift popup | [../roads/README.md](../roads/README.md) |
| item type 5 "Pontos de Atividade" | `QB:249-251` | `newactiveleed` | [../daily-activity/README.md](../daily-activity/README.md) |
| item type 10 "Check-in diário" | `QB:341-343` | `dayguide` 1 > `SignDayFrame` | [../daily-activity/README.md](../daily-activity/README.md) |
| item type 11 "Vórtice do Tempo" | `QB:344-346` | `timevortex` | [../trials/README.md](../trials/README.md) |
| item type 9 (activity orders 1..16) | `QB:252-340` | per order id | castle list, owners in [activity-queue.md](activity-queue.md) |

### Other HUD views

| View | Entry | Handler | Opens | Owner |
|---|---|---|---|---|
| ChatBar | `_upBtn`, `_downBtn` "Expandir", "Diminuir" | `CHB:105` | local | [../chat/README.md](../chat/README.md) |
| TimeBoxView | self | `TBV:160` | `box` > `TimeBoxFrame` | [../inventory/README.md](../inventory/README.md) |
| TargetSelectView | `_operateBtn` | `TSV:173` | guild right 9 > "Câmara de comércio" | [../guild/README.md](../guild/README.md) |
| TaskTraceView | `_container` "Missão (Atalho: L)", `_hideBtn` | `TTV:259`, `TTV:336` | `task` > `TaskFrameII` | [../quests/README.md](../quests/README.md) |
| TaskTraceItem | `_quickBtn` "Concluir", self | `TTI:357`, `TTI:577` | 8730, `kingcontract`, quest targets | [../quests/README.md](../quests/README.md) |
| NewbieTaskTraceView | `_continueBtn` "Concluir missão" | `NTTV:186` | quest reward and targets | [../tutorial/README.md](../tutorial/README.md) |
| SelfHelpButtonView | help, full screen, hide or show players | `SHB:99`, `SHB:106`, `SHB:184` | local | castle HUD |
| SpaceMapButtonView | `_mapBtn` "Atalho : M" | `SMBV:49` | `space` > `SpaceMapFrame` | [../sky-realm/README.md](../sky-realm/README.md) |

### Castle map buildings

Building clicks are listed in [scene.md](scene.md) section 3, R2 (Prefeitura, Quartel, Santuário, Transmissor owned here; Labirinto, Residência, Bar da Fantasia, Laboratório de Platina owned by mazes, farm, magic-cards, laboratory).

## 3. Routes (client to server)

Castle owned routes reachable from the HUD: 8747 (castle buttons, [scene.md](scene.md)), 5015 (resource bar init, [resources.md](resources.md)). All other routes belong to the owners above.

## 4. Server messages (server to client)

Castle owned pushes rendered by the HUD: 109 (resource counters), 366 (queue items), 4130 with technologies (buff icon type 2). Others belong to the owners.

## 5. Rules and formulas

- Bot mode ([../mopup/README.md](../mopup/README.md)) blocks building clicks and queue clicks with "Modo Bot em andamento" (`decompiled/m4/scripts/castle/view/CastleBuildingView.as:284-289`, `QB:240-245`).
- Level gates listed above are client side; each owner validates again.

## 6. Templates

| File | Record | Fields used |
|---|---|---|
| `raw/xml/tempinfos/TopToolBtnInfos.xml` | activity icons | key, order, time window (owned by each event feature) |

## 7. Persistent state

None.

## 8. Backend implementation notes

None beyond the castle routes. Use this table to verify that every owner implements the request opcodes its entry sends.

## 9. Open questions and assumptions

- Assumption: `funpreview` belongs to tutorial, `onlinereward` to daily-activity, `publicchairs` to recharge, `mineField` to mines; these client packages are not in `roadmap/features.json`.

## 10. Implementation checklist

- [ ] Castle buttons (`MTB._castleBtn`, `SMB._castleBtn`, `MTB._returnBtn`) reach the castle and send 8747.
- [ ] Resource counters update from 109.
- [ ] Queue list renders from 366.
- [ ] Each owner folder confirms its HUD entries above.
