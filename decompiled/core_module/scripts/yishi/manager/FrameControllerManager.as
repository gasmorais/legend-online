package yishi.manager
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.controls.Frame;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.controler.*;
   import mvc.controller.WishPoolController;
   import yishi.datas.VersionSwitch;
   import yishi.view.tips.MessageTipManager;
   
   public class FrameControllerManager
   {
      
      private static var _instance:FrameControllerManager;
      
      private var _hallFameController:HallFameController;
      
      private var _onLineController:OnLineController;
      
      private var _shopController:ShopControler;
      
      private var _dungeonexploController:DungeonexploController;
      
      private var _buildingController:BuildingControler;
      
      private var _armyController:ArmyControler;
      
      private var _storeController:StoreControler;
      
      private var _friendControler:FriendControler;
      
      private var _feedBackControler:FeedBackControler;
      
      private var _funnyControler:FunnyControler;
      
      private var _settingControler:SettingControler;
      
      private var _emailControler:EmailControler;
      
      private var _taskControler:TaskControler;
      
      private var _consortiaController:ConsortiaControler;
      
      private var _dayGuideController:DayGuideController;
      
      private var _offerRewardController:OfferRewardController;
      
      private var _sortController:SortController;
      
      private var _pveRoomlistControler:PVERoomListControler;
      
      private var _theseusRoomlistControler:TheseusRoomListControler;
      
      private var _pvpRoomlistControler:PVPRoomListControler;
      
      private var _selectCampaignControler:SelectCampaignController;
      
      private var _colosseumControler:ColosseumControler;
      
      private var _worldBossControler:WorldBossControler;
      
      private var _starController:StarController;
      
      private var _pvpControler:PvPControler;
      
      private var _matelordsController:MatelordsController;
      
      private var _gradeBoxControler:GradeBoxControler;
      
      private var _timeBoxControler:TimeBoxControler;
      
      private var _hookControler:HookContorler;
      
      private var _mazeControler:MazeControler;
      
      private var _pvpMapControler:PvpMapControler;
      
      private var _auctionController:AuctionControl;
      
      private var _vipControler:VIPControler;
      
      private var _securityCodeController:SecurityCodeControl;
      
      private var _fashionCodeController:FashionStoreControler;
      
      private var _countloginControler:CountLoginControler;
      
      private var _bag360Controler:Bag360Controler;
      
      private var _customerServiceController:CustomerServiceController;
      
      private var _mysteryShopController:MysteryShopControler;
      
      private var _supermarketController:SupermarketController;
      
      private var _seminaryBlessControler:SeminaryBlessControler;
      
      private var _firstPayControler:FirstPayControler;
      
      private var _exchargeAllController:ExchargeRankController;
      
      private var _mopupController:MopupController;
      
      private var _questionnaireController:QuestionnaireController;
      
      private var _mountsController:MountsController;
      
      private var _consortiaGroupChatControler:ConsortiaGroupChatControler;
      
      private var _kingcontractControler:KingContractControler;
      
      private var _goodsListControler:GoodsListControler;
      
      private var _secretaryContractControler:SecretaryContractControler;
      
      private var _teamControler:TeamSortControler;
      
      private var _timeStoryControler:TimeStoryControler;
      
      private var _appellControler:AppellControler;
      
      private var _vehicleDaimonController:VehicleDaimonController;
      
      private var _vehicleDaimonTrailController:VehicleDaimonTrialController;
      
      private var _bottleController:BottleControler;
      
      private var _petController:PetController;
      
      private var _petbossController:PetBossController;
      
      private var _fateRotaryControler:FateRotaryControler;
      
      private var _spaceController:SpaceController;
      
      private var _petchallengeController:PetChallengeController;
      
      private var _fundController:FundController;
      
      private var _fundVeinContrller:FundVeinController;
      
      private var _freedomTeamFrameController:FreedomTeamFrameController;
      
      private var _treasureMapFrameController:TreasureMapFrameController;
      
      private var _singlePassFrameController:SinglePassFrameController;
      
      private var _answeControler:AnswerControler;
      
      private var _funPreviewControler:FunPreviewControler;
      
      private var _expBackControler:ExpBackControler;
      
      private var _treasureHuntControler:TreasureHuntControler;
      
      private var _vicepasswordController:VicepasswordController;
      
      private var _magicCardControler:MagicCardControler;
      
      private var _slotController:SlotController;
      
      private var _playerinfoController:PlayerInfoController;
      
      private var _lotteryController:LotteryController;
      
      private var _guideTaskController:GuideTaskController;
      
      private var _molongControl:MolongController;
      
      private var _bloodyControl:BloodyController;
      
      private var _timeBuyController:TimeBuyController;
      
      private var _marryController:MarryController;
      
      private var _shoubangControler:ShouBangController;
      
      private var _fishControler:FishControler;
      
      private var _gemMazeControler:GemMazeControler;
      
      private var _worldMapController:WorldMapControler;
      
      private var _goldRoadControler:GoldRoadControler;
      
      private var _newYearActController:NewYearActController;
      
      private var _monopolyController:MonopolyController;
      
      private var _planesWarControler:PlanesWarControler;
      
      private var _outerCityShopControler:OuterCityShopControler;
      
      private var _loginActiveControler:LoginActiveControler;
      
      private var _childController:ChildControler;
      
      private var _llkController:LlkController;
      
      private var _svsController:SvsController;
      
      private var _battleMountController:BattleMountController;
      
      private var _steelController:SteelController;
      
      private var _skyTreasureControler:SkyTreasureControler;
      
      private var _birthdayController:BirthdayController;
      
      private var _farmController:FarmController;
      
      private var _remotePetController:RemotePetController;
      
      private var _childPveController:ChildPveController;
      
      private var _childArenaController:ChildArenaController;
      
      private var _tattooController:TattooController;
      
      private var _sacrificeController:SacrificeController;
      
      private var _godTreasureControler:GodTreasureControler;
      
      private var _christmasTreeController:ChristmasTreeControler;
      
      private var _groupfbController:GroupfbController;
      
      private var _duskAreaController:DuskAreaControler;
      
      private var _skyBoxRoadControler:SkyBoxRoadControler;
      
      private var _blackjackControler:BlackjackControler;
      
      private var _artifactControler:ArtifactControler;
      
      private var _regressControler:RegressControler;
      
      private var _bingoControler:BingoControler;
      
      private var _outyardControler:OutyardControler;
      
      private var _pokerControler:PokerControler;
      
      private var _catHouseController:CatHouseController;
      
      private var _registWelfareControler:RegistWelfareControler;
      
      private var _heroRoadControler:HeroRoadControler;
      
      private var _publicChairsControler:PublicChairsControler;
      
      private var _cultureActiveControler:CultureActiveControler;
      
      private var _goldenDionysiaControler:GoldendionysiaController;
      
      private var _ancientArtifactControler:AncientArtifactControler;
      
      private var _publicEggControler:PublicEggControler;
      
      private var _pandoraControler:PandoraControler;
      
      private var _chargeLotteryControler:ChargeLotteryControler;
      
      private var _magicPubControler:MagicPubControler;
      
      private var _gameboxControler:GameBoxControler;
      
      private var _perkinLabControler:PerkinLabControler;
      
      private var _mineFieldControler:MineFieldControler;
      
      private var _changeJobControler:ChangeJobControler;
      
      private var _dragonTitanControler:DragonTitanControler;
      
      private var _continuePayRebateControler:ContinuePayRebateControler;
      
      private var _archaeologyControler:ArchaeologyContorler;
      
      private var _childPatrolControler:ChildPatrolControler;
      
      private var _saleControler:SaleControler;
      
      private var _mailCheckControler:MailCheckControler;
      
      private var _navigationControler:NavigationControler;
      
      private var _crossCostController:CrossCostController;
      
      private var _luckyExchangeControler:LuckyExchangeControler;
      
      private var _exchangeBoxControler:ExchangeBoxControler;
      
      private var _crossGuildControler:CrossGuildControler;
      
      private var _aresLordsController:AresLordsController;
      
      private var _braveLegController:BraveLegController;
      
      private var _gloryRoadController:GloryRoadController;
      
      private var _discountShopController:DiscountShopController;
      
      private var _petHallowsControler:PetHallowsControler;
      
      private var _rapidThroughController:RapidThroughController;
      
      private var _ravePartyControler:RavePartyControler;
      
      private var _childsealControler:ChildesalControler;
      
      private var _encoGoldControler:EncoGoldControler;
      
      private var _childNursingSpiritControler:ChildNursingSpiritControler;
      
      private var _lordTrialController:LordTrialController;
      
      private var _spacetimeFault:SpaceTimeFaultController;
      
      private var _alchemicalController:AlchemicalController;
      
      private var _unrealShootingController:UnrealShootingController;
      
      private var _timeVortexController:TimeVortexController;
      
      private var _oldBackerControler:OldBackerControler;
      
      private var _dragonTalkerControler:DragonTalkerController;
      
      private var _godsEveningController:GodsEveningController;
      
      private var _dayLightControler:DayLightController;
      
      private var _pumpingJoyControler:PumpingJoyControler;
      
      private var _wholeRebateController:WholeRebateController;
      
      private var _stargazingController:StarGazingController;
      
      private var _dungeonController:DungeonController;
      
      private var _planeCrisisController:PlaneCrisisController;
      
      private var _magicSpringController:MagicSpringController;
      
      private var _eclipticPalaceController:EclipticPalaceControl;
      
      private var _monthCardController:MonthCardController;
      
      private var _upgradePresentController:UpgradePresentController;
      
      private var _goldenSheepController:GoldenSheepController;
      
      private var _landMineController:LandMineController;
      
      private var _goddessController:GodDessController;
      
      private var _demonLandController:DemonLandController;
      
      private var _foisonHornController:FoisonHornController;
      
      private var _guildfbController:GuildFbController;
      
      private var _mvpShopController:MvpShopController;
      
      private var _gameHallController:GameHallController;
      
      private var _apexController:ApexController;
      
      private var _monsterController:MonsterControler;
      
      private var _antaeusController:AntaeusController;
      
      private var _monsterExploreController:MonsterExploreControler;
      
      private var _luckyLotteryController:LuckyLotteryController;
      
      private var _dreamArenaController:DreamArenaController;
      
      private var _stokesOreControler:StokesOreControler;
      
      private var _airGardenControl:AirGardenControl;
      
      private var _revengeRoadController:RevengeRoadController;
      
      private var _avengerControl:AvengerControler;
      
      private var _wishPoolController:WishPoolController;
      
      private var _redemptionRoadControl:RedemptionRoadControl;
      
      private var _superSigninCardController:SuperSigninCardController;
      
      private var _proficiencyControler:ProficiencyControler;
      
      private var _kingbackControler:KingbackControler;
      
      private var _guildWantedController:GuildWantedController;
      
      private var _sevenYearController:SevenYearController;
      
      private var _allManExchangeController:AllManExchangeController;
      
      private var _increasinglyRoadControler:IncreasinglyRoadControler;
      
      private var _spiritExpeditionControl:SpiritExpeditionControl;
      
      private var _ylexpedtionController:YLExpeditionController;
      
      private var _platinumController:PlatinumControler;
      
      private var _demonroadShopController:DemonRoadShopController;
      
      private var _selfChessControl:SelfChessFrameContorller;
      
      private var _customizedVipControl:CustomizedVipControl;
      
      private var _shadowLandController:ShadowLandController;
      
      private var _darkMazeController:DarkMazeController;
      
      private var _stelesysController:SteleSysController;
      
      private var _remainsExploreController:RemainsExploreController;
      
      private var _skyStepController:SkyStepController;
      
      private var _consortiaNewBossController:ConsortiaNewBossControler;
      
      private var _newFirstPayController:NewFirstPayController;
      
      private var _questionController:QuestionController;
      
      private var _poseidonController:PoseidonController;
      
      private var _royaltyBossController:RoyaltyBossController;
      
      private var _forbiddenBossController:ForbiddenBossController;
      
      private var _theseussoulController:TheseussoulController;
      
      private var _newMemoryCardController:NewMemoryCardController;
      
      private var _secretAdController:SecretAdventureController;
      
      private var _carnivalController:CarnivalController;
      
      private var _newActiveLeedController:NewActiveLeedController;
      
      private var _warSoulTowerController:WarSoulTowerController;
      
      private var _finalRoadController:FinalRoadController;
      
      private var _skyTreasureController:SkyTreasureController;
      
      private var _godPvpEnterController:GodPvpEnterController;
      
      private var _theseusPvpController:TheseusPvpController;
      
      private var _sqMemoryController:SqMemoryController;
      
      private var _oldPlayerReturnController:OldPlayerReturnController;
      
      private var _secretwarContrl:SecretWarController;
      
      private var _yearactiveContrl:YearActiveController;
      
      private var _minousCrl:MinosController;
      
      private var _chessPvpCtl:ConsortiaChessController;
      
      private var _christmasController:ChristmasController;
      
      private var _childnswarContorller:ChildNswarController;
      
      private var _commonCtl:CommonController;
      
      private var _frameInfoDic:Dictionary = new Dictionary();
      
      public function FrameControllerManager()
      {
         super();
         _shopController = new ShopControler();
         _buildingController = new BuildingControler();
         _armyController = new ArmyControler();
         _storeController = new StoreControler();
         _friendControler = new FriendControler();
         _feedBackControler = new FeedBackControler();
         _funnyControler = new FunnyControler();
         _onLineController = new OnLineController();
         _settingControler = new SettingControler();
         _emailControler = new EmailControler();
         _taskControler = new TaskControler();
         _skyTreasureController = new SkyTreasureController();
         _dungeonexploController = new DungeonexploController();
         _consortiaController = new ConsortiaControler();
         _dayGuideController = new DayGuideController();
         _offerRewardController = new OfferRewardController();
         _sortController = new SortController();
         _pveRoomlistControler = new PVERoomListControler();
         _theseusRoomlistControler = new TheseusRoomListControler();
         _pvpRoomlistControler = new PVPRoomListControler();
         _selectCampaignControler = new SelectCampaignController();
         _colosseumControler = new ColosseumControler();
         _worldBossControler = new WorldBossControler();
         _starController = new StarController();
         _pvpControler = new PvPControler();
         _matelordsController = new MatelordsController();
         _gradeBoxControler = new GradeBoxControler();
         _timeBoxControler = new TimeBoxControler();
         _hookControler = new HookContorler();
         _mazeControler = new MazeControler();
         _pvpMapControler = new PvpMapControler();
         _auctionController = new AuctionControl();
         _vipControler = new VIPControler();
         _securityCodeController = new SecurityCodeControl();
         _fashionCodeController = new FashionStoreControler();
         _countloginControler = new CountLoginControler();
         _bag360Controler = new Bag360Controler();
         _customerServiceController = new CustomerServiceController();
         _mysteryShopController = new MysteryShopControler();
         _supermarketController = new SupermarketController();
         _seminaryBlessControler = new SeminaryBlessControler();
         _firstPayControler = new FirstPayControler();
         _exchargeAllController = new ExchargeRankController();
         _teamControler = new TeamSortControler();
         _mopupController = new MopupController();
         _questionnaireController = new QuestionnaireController();
         _consortiaGroupChatControler = new ConsortiaGroupChatControler();
         _kingcontractControler = new KingContractControler();
         _secretaryContractControler = new SecretaryContractControler();
         _goodsListControler = new GoodsListControler();
         _mountsController = new MountsController();
         _timeStoryControler = new TimeStoryControler();
         _appellControler = new AppellControler();
         _vehicleDaimonController = new VehicleDaimonController();
         _vehicleDaimonTrailController = new VehicleDaimonTrialController();
         _bottleController = new BottleControler();
         _petController = new PetController();
         _petbossController = new PetBossController();
         _fateRotaryControler = new FateRotaryControler();
         _spaceController = new SpaceController();
         _fundController = new FundController();
         _fundVeinContrller = new FundVeinController();
         _petchallengeController = new PetChallengeController();
         _answeControler = new AnswerControler();
         _freedomTeamFrameController = new FreedomTeamFrameController();
         _treasureMapFrameController = new TreasureMapFrameController();
         _singlePassFrameController = new SinglePassFrameController();
         _funPreviewControler = new FunPreviewControler();
         _expBackControler = new ExpBackControler();
         _playerinfoController = new PlayerInfoController();
         _lotteryController = new LotteryController();
         _slotController = new SlotController();
         _guideTaskController = new GuideTaskController();
         _treasureHuntControler = new TreasureHuntControler();
         _magicCardControler = new MagicCardControler();
         _marryController = new MarryController();
         _molongControl = new MolongController();
         _bloodyControl = new BloodyController();
         _timeBuyController = new TimeBuyController();
         _shoubangControler = new ShouBangController();
         _gemMazeControler = new GemMazeControler();
         _worldMapController = new WorldMapControler();
         _fishControler = new FishControler();
         _goldRoadControler = new GoldRoadControler();
         _vicepasswordController = new VicepasswordController();
         _newYearActController = new NewYearActController();
         _loginActiveControler = new LoginActiveControler();
         _monopolyController = new MonopolyController();
         _outerCityShopControler = new OuterCityShopControler();
         _planesWarControler = new PlanesWarControler();
         _childController = new ChildControler();
         _llkController = new LlkController();
         _svsController = new SvsController();
         _battleMountController = new BattleMountController();
         _steelController = new SteelController();
         _skyTreasureControler = new SkyTreasureControler();
         _farmController = new FarmController();
         _birthdayController = new BirthdayController();
         _remotePetController = new RemotePetController();
         _childPveController = new ChildPveController();
         _childArenaController = new ChildArenaController();
         _tattooController = new TattooController();
         _sacrificeController = new SacrificeController();
         _godTreasureControler = new GodTreasureControler();
         _hallFameController = new HallFameController();
         _christmasTreeController = new ChristmasTreeControler();
         _groupfbController = new GroupfbController();
         _duskAreaController = new DuskAreaControler();
         _skyBoxRoadControler = new SkyBoxRoadControler();
         _gameboxControler = new GameBoxControler();
         _blackjackControler = new BlackjackControler();
         _artifactControler = new ArtifactControler();
         _pokerControler = new PokerControler();
         _regressControler = new RegressControler();
         _bingoControler = new BingoControler();
         _outyardControler = new OutyardControler();
         _catHouseController = new CatHouseController();
         _registWelfareControler = new RegistWelfareControler();
         _heroRoadControler = new HeroRoadControler();
         _publicChairsControler = new PublicChairsControler();
         _cultureActiveControler = new CultureActiveControler();
         _goldenDionysiaControler = new GoldendionysiaController();
         _ancientArtifactControler = new AncientArtifactControler();
         _publicEggControler = new PublicEggControler();
         _pandoraControler = new PandoraControler();
         _chargeLotteryControler = new ChargeLotteryControler();
         _magicPubControler = new MagicPubControler();
         _perkinLabControler = new PerkinLabControler();
         _mineFieldControler = new MineFieldControler();
         _changeJobControler = new ChangeJobControler();
         _mailCheckControler = new MailCheckControler();
         _dragonTitanControler = new DragonTitanControler();
         _continuePayRebateControler = new ContinuePayRebateControler();
         _archaeologyControler = new ArchaeologyContorler();
         _childPatrolControler = new ChildPatrolControler();
         _saleControler = new SaleControler();
         _mailCheckControler = new MailCheckControler();
         _navigationControler = new NavigationControler();
         _crossCostController = new CrossCostController();
         _luckyExchangeControler = new LuckyExchangeControler();
         _exchangeBoxControler = new ExchangeBoxControler();
         _crossGuildControler = new CrossGuildControler();
         _aresLordsController = new AresLordsController();
         _braveLegController = new BraveLegController();
         _gloryRoadController = new GloryRoadController();
         _discountShopController = new DiscountShopController();
         _petHallowsControler = new PetHallowsControler();
         _rapidThroughController = new RapidThroughController();
         _ravePartyControler = new RavePartyControler();
         _childsealControler = new ChildesalControler();
         _encoGoldControler = new EncoGoldControler();
         _childNursingSpiritControler = new ChildNursingSpiritControler();
         _spacetimeFault = new SpaceTimeFaultController();
         _lordTrialController = new LordTrialController();
         _alchemicalController = new AlchemicalController();
         _unrealShootingController = new UnrealShootingController();
         _timeVortexController = new TimeVortexController();
         _oldBackerControler = new OldBackerControler();
         _dragonTalkerControler = new DragonTalkerController();
         _pumpingJoyControler = new PumpingJoyControler();
         _dayLightControler = new DayLightController();
         _godsEveningController = new GodsEveningController();
         _stargazingController = new StarGazingController();
         _wholeRebateController = new WholeRebateController();
         _dungeonController = new DungeonController();
         _planeCrisisController = new PlaneCrisisController();
         _magicSpringController = new MagicSpringController();
         _eclipticPalaceController = new EclipticPalaceControl();
         _monthCardController = new MonthCardController();
         _upgradePresentController = new UpgradePresentController();
         _demonLandController = new DemonLandController();
         _goldenSheepController = new GoldenSheepController();
         _landMineController = new LandMineController();
         _goddessController = new GodDessController();
         _foisonHornController = new FoisonHornController();
         _guildfbController = new GuildFbController();
         _mvpShopController = new MvpShopController();
         _gameHallController = new GameHallController();
         _apexController = new ApexController();
         _monsterController = new MonsterControler();
         _antaeusController = new AntaeusController();
         _monsterExploreController = new MonsterExploreControler();
         _luckyLotteryController = new LuckyLotteryController();
         _dreamArenaController = new DreamArenaController();
         _stokesOreControler = new StokesOreControler();
         _airGardenControl = new AirGardenControl();
         _avengerControl = new AvengerControler();
         _revengeRoadController = new RevengeRoadController();
         _wishPoolController = new WishPoolController();
         _redemptionRoadControl = new RedemptionRoadControl();
         _selfChessControl = new SelfChessFrameContorller();
         _superSigninCardController = new SuperSigninCardController();
         _proficiencyControler = new ProficiencyControler();
         _kingbackControler = new KingbackControler();
         _guildWantedController = new GuildWantedController();
         _sevenYearController = new SevenYearController();
         _allManExchangeController = new AllManExchangeController();
         _increasinglyRoadControler = new IncreasinglyRoadControler();
         _spiritExpeditionControl = new SpiritExpeditionControl();
         _ylexpedtionController = new YLExpeditionController();
         _platinumController = new PlatinumControler();
         _demonroadShopController = new DemonRoadShopController();
         _customizedVipControl = new CustomizedVipControl();
         _shadowLandController = new ShadowLandController();
         _darkMazeController = new DarkMazeController();
         _stelesysController = new SteleSysController();
         _remainsExploreController = new RemainsExploreController();
         _skyStepController = new SkyStepController();
         _consortiaNewBossController = new ConsortiaNewBossControler();
         _newFirstPayController = new NewFirstPayController();
         _questionController = new QuestionController();
         _poseidonController = new PoseidonController();
         _royaltyBossController = new RoyaltyBossController();
         _forbiddenBossController = new ForbiddenBossController();
         _theseussoulController = new TheseussoulController();
         _newMemoryCardController = new NewMemoryCardController();
         _secretAdController = new SecretAdventureController();
         _carnivalController = new CarnivalController();
         _newActiveLeedController = new NewActiveLeedController();
         _warSoulTowerController = new WarSoulTowerController();
         _finalRoadController = new FinalRoadController();
         _theseusPvpController = new TheseusPvpController();
         _godPvpEnterController = new GodPvpEnterController();
         _sqMemoryController = new SqMemoryController();
         _oldPlayerReturnController = new OldPlayerReturnController();
         _secretwarContrl = new SecretWarController();
         _yearactiveContrl = new YearActiveController();
         _minousCrl = new MinosController();
         _chessPvpCtl = new ConsortiaChessController();
         _christmasController = new ChristmasController();
         _childnswarContorller = new ChildNswarController();
         _commonCtl = new CommonController();
      }
      
      public static function get instance() : FrameControllerManager
      {
         if(!_instance)
         {
            _instance = new FrameControllerManager();
         }
         return _instance;
      }
      
      public static function checkFrame(param1:String, param2:String) : Boolean
      {
         var _loc4_:Frame = FrameControllerManager.instance[param1]["frame"];
         var _loc3_:String = "[object " + param2 + "]";
         return _loc4_ && _loc4_.toString() == _loc3_ && _loc4_.stage && _loc4_.visible;
      }
      
      private function getFrameInfo(param1:String) : ModuleFrameInfo
      {
         var _loc2_:ModuleFrameInfo = _frameInfoDic[param1] as ModuleFrameInfo;
         if(!_loc2_)
         {
            _loc2_ = new ModuleFrameInfo();
            _loc2_.isComplete = false;
            _loc2_.moduleUIName = getModuleUINameBytype(param1);
            _loc2_.needLoadArr = getResourceByType(_loc2_.moduleUIName);
            if(getProjectFileByType(param1) != "")
            {
               _loc2_.needLoadArr.push(getProjectFileByType(param1));
            }
            _frameInfoDic[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      private function getModuleUINameBytype(param1:String) : String
      {
         switch(param1)
         {
            case "casern":
            case "recruit_pawn":
               return "casern";
            case "auction":
            case "goodsList":
            case "mysteryshop":
               break;
            case "vehicledaimon":
               return "vehicleroomlist";
            default:
               return param1;
         }
         return "auction";
      }
      
      private function getProjectFileByType(param1:String) : String
      {
         switch(param1)
         {
            case "casern":
            case "crystal":
            case "politics":
            case "seminary":
            case "transferbuilding":
            case "residence":
            case "titan":
            case "market":
               return ComponentSetting.getProjectSourcePath("4.png");
            case "recruit_pawn":
            case "army":
            case "pawnupgrade":
            case "star":
            case "teammanager":
            case "mopup":
            case "appell":
            case "magiccard":
            case "playerinfo":
            case "changejob":
            case "dragontalker":
            case "goddess":
            case "avenger":
            case "proficiency":
            case "theseussoul":
            case "theseuscollention":
            case "theseusgodhead":
               return ComponentSetting.getProjectSourcePath("5.png");
            case "consortia":
            case "lookconsortiainfo":
            case "crossguild":
            case "guildfb":
            case "guildwanted":
            case "consortianewboss":
            case "minos":
               return ComponentSetting.getProjectSourcePath("6.png");
            case "auction":
            case "goodsList":
            case "mysteryshop":
            case "outercityshop":
               return ComponentSetting.getProjectSourcePath("7.png");
            case "hook":
            case "maze":
            case "pveroomlist":
            case "pvproomlist":
            case "theseusroomlist":
            case "pvp":
            case "pvpmap":
            case "vehicleroomlist":
            case "vehicledaimon":
            case "warlords":
            case "matelords":
            case "marry":
            case "areslords":
            case "gloryroad":
            case "rapidthrough":
            case "spacetimefault":
            case "unrealshooting":
            case "godsevening":
            case "dungeonturn":
            case "apex":
            case "airgarden":
               return ComponentSetting.getProjectSourcePath("9.png");
            case "dayguide":
            case "dayactivity":
            case "countlogin":
            case "bag360":
            case "customerservice":
            case "email":
            case "writeemail":
            case "firstpay":
            case "rechargetime":
            case "gradebox":
            case "kingcontract":
            case "questionnaire":
            case "securitycode":
            case "seminarybless":
            case "setting":
            case "sort":
            case "box":
            case "worldmap":
            case "timestory":
            case "bottle":
            case "faterotary":
            case "fund":
            case "answer":
            case "funpreview":
            case "expback":
            case "lottery":
            case "guidetask":
            case "godarrive":
            case "singlepass":
            case "slot":
            case "goldroad":
            case "onlinereward":
            case "newyearact":
            case "shoubang":
            case "timebuy":
            case "steelmap":
            case "birthday":
            case "monopoly":
            case "sacrifice":
            case "godtreasure":
            case "hallfame":
            case "blackjack":
            case "artifact":
            case "registwelfare":
            case "heroroad":
            case "publicchairs":
            case "cultureactive":
            case "goldendionysia":
            case "ancientartifact":
            case "publicegg":
            case "pandora":
            case "chargelottery":
            case "magicpub":
            case "perkinlab":
            case "poker":
            case "regress":
            case "bingo":
            case "outyard":
            case "cathouse":
            case "continuepayrebate":
            case "crosscost":
            case "luckyexchange":
            case "sale":
            case "exchangebox":
            case "fundnewbie":
            case "braveleg":
            case "discountshop":
            case "raveparty":
            case "childesal":
            case "encogold":
            case "abysm":
            case "lordtrial":
            case "timevortex":
            case "oldbacker":
            case "pumpingjoy":
            case "loginactive":
            case "wholerebate":
            case "magicspring":
            case "monthcard":
            case "upgradepresent":
            case "foisonhorn":
            case "goldensheep":
            case "landmine":
            case "demonland":
            case "mvpshop":
            case "fish":
            case "gamebox":
            case "navigation":
            case "antaeus":
            case "luckylottery":
            case "stokesore":
            case "revengeroad":
            case "wishpool":
            case "supersignincard":
            case "sevenyear":
            case "platinum":
            case "customizedvip":
            case "shadowland":
            case "remainsexplore":
            case "mailcheck":
            case "newfirstpay":
            case "question":
            case "poseidonshop":
            case "royaltyboss":
            case "forbiddenboss":
            case "newmemorycard":
            case "carnival":
            case "newactiveleed":
            case "warsoultower":
            case "finalroad":
            case "godpvpenter":
            case "sqmemory":
            case "oldplayerreturn":
            case "allmanexchange":
            case "christmas":
            case "kingback":
            case "mailcheck":
            case "SECRETARY":
            case "thesstower":
            case "dungenexplo":
            case "skytreasure1":
               break;
            case "friends":
            case "consortiagroupchat":
               return ComponentSetting.getProjectSourcePath("12.png");
            case "colosseum":
            case "selectcampaign":
            case "worldboss":
            case "freedomteam":
            case "treasuremap":
            case "dreamarena":
            case "redemptionroad":
               return ComponentSetting.getProjectSourcePath("13.png");
            case "store":
            case "mounts":
            case "fashion":
            case "pet":
            case "petchallenge":
            case "petboss":
            case "child":
            case "childpve":
            case "childarena":
            case "battleMount":
            case "remotepet":
            case "archaeology":
            case "dragontitan":
            case "childpatrol":
            case "ylexpedition":
            case "pethallows":
            case "childnursingspirit":
            case "childformation":
            case "alchemical":
            case "stargazing":
            case "eclipticpalace":
            case "monster":
            case "monsterexplore":
            case "spiritexpedition":
            case "stelesys":
               return ComponentSetting.getProjectSourcePath("14.png");
            case "task":
            case "offerreward":
            case "shop":
            case "vip":
            case "sevenyear":
            case "demonroadshop":
               return ComponentSetting.getProjectSourcePath("15.png");
            case "treasurehunt":
            case "farm":
            case "daylight":
            case "planecrisis":
            case "gamehall":
            case "airgardengame":
            case "secretadventure":
            case "secretwar":
            case "yearactive":
            case "thessbox":
               return ComponentSetting.getProjectSourcePath("3.png");
            default:
               return "";
         }
         return ComponentSetting.getProjectSourcePath("11.png");
      }
      
      private function getResourceByType(param1:String) : Array
      {
         var _loc2_:Array = [];
         _loc2_.push(ComponentSetting.getUISourcePath(param1));
         _loc2_.push(ComponentSetting.getUISourcePath("core"));
         _loc2_.push(ComponentSetting.getUISourcePath("common"));
         _loc2_.push(ComponentSetting.getUISourcePath("framebg"));
         _loc2_.push(ComponentSetting.getUISourcePath("fairycommon"));
         switch(param1)
         {
            case "chesspvp":
               _loc2_.push(ComponentSetting.getUISourcePath("consortiagroupchat"));
            case "email":
               _loc2_.push(ComponentSetting.getUISourcePath("writeemail"));
               break;
            case "writeemail":
               _loc2_.push(ComponentSetting.getUISourcePath("email"));
               break;
            case "mounts":
               _loc2_.push(ComponentSetting.getUISourcePath("castle"));
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               break;
            case "skytreasure1":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               break;
            case "army":
               _loc2_.push(ComponentSetting.getUISourcePath("playerinfo"));
               break;
            case "vehicleroomlist":
               _loc2_.push(ComponentSetting.getUISourcePath("baseroom"));
               break;
            case "casern":
            case "crystal":
            case "politics":
            case "seminary":
            case "residence":
            case "titan":
            case "market":
            case "transferbuilding":
               _loc2_.push(ComponentSetting.getUISourcePath("castle"));
               break;
            case "sort":
               _loc2_.push(ComponentSetting.getUISourcePath("tips"));
               _loc2_.push(ComponentSetting.getUISourcePath("sort"));
               break;
            case "dayguide":
               _loc2_.push(ComponentSetting.getUISourcePath("dayguide"));
               break;
            case "timestory":
               _loc2_.push(ComponentSetting.getUISourcePath("timestory"));
               break;
            case "friends":
               _loc2_.push(ComponentSetting.getUISourcePath("chatim"));
               break;
            case "shop":
               _loc2_.push(ComponentSetting.getUISourcePath("playerbg"));
               _loc2_.push(ComponentSetting.getUISourcePath("star"));
               _loc2_.push(ComponentSetting.getUISourcePath("exchangebox"));
               break;
            case "funny":
               _loc2_.push(ComponentSetting.getUISourcePath("groupbuy"));
               _loc2_.push(ComponentSetting.getUISourcePath("stokesore"));
               break;
            case "shoubang":
               _loc2_.push(ComponentSetting.getUISourcePath("shoubang"));
               _loc2_.push(ComponentSetting.getUISourcePath("dragontalker"));
               break;
            case "loginactive":
               _loc2_.push(ComponentSetting.getUISourcePath("countlogin"));
               break;
            case "matelords":
               _loc2_.push(ComponentSetting.getUISourcePath("warlords"));
               _loc2_.push(ComponentSetting.getUISourcePath("sort"));
               break;
            case "petchallenge":
               _loc2_.push(ComponentSetting.getUISourcePath("pet"));
               break;
            case "svsmap":
               _loc2_.push(ComponentSetting.getUISourcePath("warlords"));
               break;
            case "battleMount":
               _loc2_.push(ComponentSetting.getUISourcePath("sort"));
               break;
            case "steelmap":
               _loc2_.push(ComponentSetting.getUISourcePath("svsmap"));
               _loc2_.push(ComponentSetting.getUISourcePath("warlords"));
               _loc2_.push(ComponentSetting.getUISourcePath("invite"));
               _loc2_.push(ComponentSetting.getUISourcePath("consortia"));
               break;
            case "child":
               _loc2_.push(ComponentSetting.getUISourcePath("pet"));
               break;
            case "monopoly":
               _loc2_.push(ComponentSetting.getUISourcePath("llk"));
               _loc2_.push(ComponentSetting.getUISourcePath("gemmaze"));
               break;
            case "hallfame":
               _loc2_.push(ComponentSetting.getUISourcePath("funny"));
               break;
            case "childpatrol":
               _loc2_.push(ComponentSetting.getUISourcePath("child"));
               break;
            case "changejob":
               _loc2_.push(ComponentSetting.getUISourcePath("army"));
               break;
            case "artifact":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               break;
            case "archaeology":
               _loc2_.push(ComponentSetting.getUISourcePath("campaign"));
               break;
            case "crosscost":
               _loc2_.push(ComponentSetting.getUISourcePath("exchargeall"));
               break;
            case "fundnewbie":
               _loc2_.push(ComponentSetting.getUISourcePath("fund"));
               break;
            case "discountshop":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               break;
            case "farm":
               _loc2_.push(ComponentSetting.getUISourcePath("farmmap"));
               _loc2_.push(ComponentSetting.getUISourcePath("water"));
               break;
            case "rapidthrough":
               _loc2_.push(ComponentSetting.getUISourcePath("campaign"));
               _loc2_.push(ComponentSetting.getUISourcePath("sort"));
               break;
            case "publicegg":
               _loc2_.push(ComponentSetting.getUISourcePath("funny"));
               break;
            case "abysm":
            case "childpve":
            case "spiritexpedition":
               _loc2_.push(ComponentSetting.getUISourcePath("childformation"));
               break;
            case "childarena":
               _loc2_.push(ComponentSetting.getUISourcePath("child"));
               _loc2_.push(ComponentSetting.getUISourcePath("childformation"));
               break;
            case "childnursingspirit":
               _loc2_.push(ComponentSetting.getUISourcePath("pet"));
               _loc2_.push(ComponentSetting.getUISourcePath("child"));
               break;
            case "pandora":
               _loc2_.push(ComponentSetting.getUISourcePath("artifact"));
               break;
            case "goldendionysia":
               _loc2_.push(ComponentSetting.getUISourcePath("exchargeall"));
               break;
            case "unrealshooting":
               _loc2_.push(ComponentSetting.getUISourcePath("svsmap"));
               _loc2_.push(ComponentSetting.getUISourcePath("warlords"));
               _loc2_.push(ComponentSetting.getUISourcePath("invite"));
               _loc2_.push(ComponentSetting.getUISourcePath("consortia"));
               _loc2_.push(ComponentSetting.getUISourcePath("steelmap"));
               break;
            case "dragontalker":
               _loc2_.push(ComponentSetting.getUISourcePath("playerinfo"));
               _loc2_.push(ComponentSetting.getUISourcePath("army"));
               break;
            case "playerinfo":
               _loc2_.push(ComponentSetting.getUISourcePath("dragontalker"));
               break;
            case "daylight":
               _loc2_.push(ComponentSetting.getUISourcePath("campaign"));
               _loc2_.push(ComponentSetting.getUISourcePath("pvpmap"));
               break;
            case "demonland":
            case "revengeroad":
               _loc2_.push(ComponentSetting.getUISourcePath("mopup"));
               break;
            case "luckylottery":
               _loc2_.push(ComponentSetting.getUISourcePath("lottery"));
               break;
            case "airgarden":
               _loc2_.push(ComponentSetting.getProjectSourcePath("3.png"));
               _loc2_.push(ComponentSetting.getUISourcePath("llk"));
               _loc2_.push(ComponentSetting.getUISourcePath("airgardengame"));
               break;
            case "pumpingjoy":
               _loc2_.push(ComponentSetting.getUISourcePath("bottle"));
               break;
            case "appell":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               break;
            case "wishpool":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               _loc2_.push(ComponentSetting.getUISourcePath("funny"));
               break;
            case "sevenyear":
            case "yearactive":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               _loc2_.push(ComponentSetting.getUISourcePath("task"));
               break;
            case "avenger":
               _loc2_.push(ComponentSetting.getUISourcePath("avengereffect"));
               _loc2_.push(ComponentSetting.getUISourcePath("child"));
               _loc2_.push(ComponentSetting.getUISourcePath("childnursingspirit"));
               break;
            case "ylexpedition":
               _loc2_.push(ComponentSetting.getUISourcePath("child"));
               _loc2_.push(ComponentSetting.getUISourcePath("childpatrol"));
               break;
            case "platinum":
               _loc2_.push(ComponentSetting.getUISourcePath("bottle"));
               break;
            case "customizedvip":
               _loc2_.push(ComponentSetting.getUISourcePath("quickbuy"));
               break;
            case "dungenexplo":
               _loc2_.push(ComponentSetting.getUISourcePath("thessbox"));
               break;
            case "remainsexplore":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               _loc2_.push(ComponentSetting.getUISourcePath("dayguide"));
               break;
            case "skystep":
               _loc2_.push(ComponentSetting.getUISourcePath("space"));
               break;
            case "consortianewboss":
               _loc2_.push(ComponentSetting.getUISourcePath("consortia"));
               break;
            case "forbiddenboss":
               _loc2_.push(ComponentSetting.getUISourcePath("space"));
               break;
            case "oldplayerreturn":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               break;
            case "secretwar":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               _loc2_.push(ComponentSetting.getUISourcePath("outercityshop"));
               break;
            case "navigation":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               break;
            case "christmas":
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               _loc2_.push(ComponentSetting.getUISourcePath("carnival"));
               _loc2_.push(ComponentSetting.getUISourcePath("gamehall"));
               break;
            case "store":
               _loc2_.push(ComponentSetting.getUISourcePath("appell"));
               _loc2_.push(ComponentSetting.getUISourcePath("friends"));
               break;
            case "theseussoul":
               _loc2_.push(ComponentSetting.getUISourcePath("playerinfo"));
               _loc2_.push(ComponentSetting.getUISourcePath("theseuscollention"));
               _loc2_.push(ComponentSetting.getUISourcePath("consortianewboss"));
               _loc2_.push(ComponentSetting.getUISourcePath("platinum"));
               _loc2_.push(ComponentSetting.getUISourcePath("poseidonshop"));
               _loc2_.push(ComponentSetting.getUISourcePath("shop"));
               _loc2_.push(ComponentSetting.getUISourcePath("petchallenge"));
               _loc2_.push(ComponentSetting.getUISourcePath("raveparty"));
               _loc2_.push(ComponentSetting.getUISourcePath("theseusgodhead"));
               _loc2_.push(ComponentSetting.getUISourcePath("mailcheck"));
               break;
            case "theseusroomlist":
               _loc2_.push(ComponentSetting.getUISourcePath("pveroomlist"));
               _loc2_.push(ComponentSetting.getUISourcePath("theseuspvp"));
            case "SECRETARY":
               _loc2_.push(ComponentSetting.getUISourcePath("mopup"));
         }
         return _loc2_;
      }
      
      public function closeControllerByInfo(param1:String, param2:Object = null, param3:Object = null) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("yishi.manager.FrameControllerManager.vModuleFrameError");
         switch(param1)
         {
            case "offerreward":
               _offerRewardController.closeFrame();
               break;
            case "pveroomlist":
               _pveRoomlistControler.closeFrame();
               break;
            case "pvp":
               _pvpControler.closeFrame();
               _pvpRoomlistControler.closeFrame();
               _colosseumControler.closeFrame();
               break;
            case "vehicleroomlist":
               _vehicleDaimonTrailController.closeFrame();
               break;
            case "supermarket":
               _supermarketController.closeFrame();
               break;
            case "shop":
               _shopController.closeFrame();
               break;
            case "petchallenge":
               _petchallengeController.closeFrame();
               break;
            case "treasuremap":
               _treasureMapFrameController.closeFrame();
               break;
            case "singlepass":
               _singlePassFrameController.closeFrame();
               break;
            case "monopoly":
               _monopolyController.closeFrame();
               break;
            case "godtreasure":
               _godTreasureControler.closeFrame();
               break;
            case "consortia":
               _consortiaController.closeFrame();
         }
      }
      
      public function openControllerByInfo(param1:String, param2:Object = null, param3:Object = null, param4:Function = null) : void
      {
         var _loc6_:String = null;
         var _loc5_:ModuleFrameInfo = getFrameInfo(param1);
         _loc5_.openType = param2;
         _loc5_.frameData = param3;
         _loc5_.callBack = param4;
         if(!_loc5_.isComplete && LoaderManagerII.instance.hasPrority(10) && param1 != "timestory" && param1 != "dayguide" && param1 != "mopup" && param1 != "molong" && param1 != "monopoly" && param1 != "pvpmap" && param1 != "duskarea" && param1 != "farm" && param1 != "lordtrial" && param1 != "daylight" && param1 != "godsevening" && param1 != "dreamarena" && param1 != "mailcheck" && param1 != "remainsexplore" && param1 != "shadowland" && param1 != "heroroad" && param1 != "royaltyboss")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.resourceLoading"));
            return;
         }
         switch(param1)
         {
            case "countlogin":
               _countloginControler.start(_loc5_);
               break;
            case "bag360":
               _bag360Controler.start(_loc5_);
               break;
            case "fund":
               _fundController.start(_loc5_);
               break;
            case "fundnewbie":
               _fundVeinContrller.start(_loc5_);
               break;
            case "dayguide":
            case "dayactivity":
               _dayGuideController.start(_loc5_);
               break;
            case "recruit_pawn":
            case "army":
            case "pawnupgrade":
               _armyController.start(_loc5_);
               break;
            case "skytreasure1":
               _skyTreasureController.start(_loc5_);
               break;
            case "shop":
               _shopController.start(_loc5_);
               break;
            case "dungenexplo":
               _dungeonexploController.start(_loc5_);
               break;
            case "casern":
            case "crystal":
            case "politics":
            case "seminary":
            case "transferbuilding":
            case "residence":
            case "titan":
            case "market":
               _buildingController.start(_loc5_);
               break;
            case "store":
               _storeController.start(_loc5_);
               break;
            case "friends":
               _friendControler.start(_loc5_);
               break;
            case "setting":
               _settingControler.start(_loc5_);
               break;
            case "email":
               _emailControler.start(_loc5_);
               break;
            case "writeemail":
               _emailControler.start(_loc5_);
               break;
            case "task":
               _taskControler.start(_loc5_);
               break;
            case "consortiagroupchat":
               _consortiaGroupChatControler.start(_loc5_);
               break;
            case "consortia":
            case "lookconsortiainfo":
               _consortiaController.start(_loc5_);
               break;
            case "offerreward":
               _offerRewardController.start(_loc5_);
               break;
            case "sort":
               _sortController.start(_loc5_);
               break;
            case "pveroomlist":
               _pveRoomlistControler.start(_loc5_);
               break;
            case "theseusroomlist":
               _theseusRoomlistControler.start(_loc5_);
               break;
            case "pvproomlist":
               _pvpRoomlistControler.start(_loc5_);
               break;
            case "selectcampaign":
               _selectCampaignControler.start(_loc5_);
               break;
            case "colosseum":
               _colosseumControler.start(_loc5_);
               break;
            case "worldboss":
               _worldBossControler.start(_loc5_);
               break;
            case "star":
               _starController.start(_loc5_);
               break;
            case "pvp":
               _pvpControler.start(_loc5_);
               break;
            case "matelords":
               _matelordsController.start(_loc5_);
               break;
            case "gradebox":
               _gradeBoxControler.start(_loc5_);
               break;
            case "box":
               _timeBoxControler.start(_loc5_);
               break;
            case "hook":
               _hookControler.start(_loc5_);
               break;
            case "pvpmap":
               _pvpMapControler.start(_loc5_);
               break;
            case "auction":
               _auctionController.start(_loc5_);
               break;
            case "mysteryshop":
               _mysteryShopController.start(_loc5_);
               break;
            case "goodsList":
               _goodsListControler.start(_loc5_);
               break;
            case "vip":
               _vipControler.start(_loc5_);
               break;
            case "customerservice":
               _customerServiceController.start(_loc5_);
               break;
            case "securitycode":
               _securityCodeController.start(_loc5_);
               break;
            case "mopup":
               _mopupController.start(_loc5_);
               break;
            case "SECRETARY":
               _secretaryContractControler.start(_loc5_);
               break;
            case "kingcontract":
               _kingcontractControler.start(_loc5_);
               break;
            case "firstpay":
            case "rechargetime":
               _firstPayControler.start(_loc5_);
               break;
            case "exchargeall":
               _exchargeAllController.start(_loc5_);
               break;
            case "crosscost":
               _crossCostController.start(_loc5_);
               break;
            case "luckyexchange":
               _luckyExchangeControler.start(_loc5_);
               break;
            case "seminarybless":
               _seminaryBlessControler.start(_loc5_);
               break;
            case "maze":
               _mazeControler.start(_loc5_);
               break;
            case "mounts":
               _mountsController.start(_loc5_);
               break;
            case "questionnaire":
               _questionnaireController.start(_loc5_);
               break;
            case "teammanager":
               _teamControler.start(_loc5_);
               break;
            case "feedback":
               _feedBackControler.start(_loc5_);
               break;
            case "funny":
               _funnyControler.start(_loc5_);
               break;
            case "onlinereward":
               _onLineController.start(_loc5_);
               break;
            case "timestory":
               _timeStoryControler.start(_loc5_);
               break;
            case "appell":
               _appellControler.start(_loc5_);
               break;
            case "fashion":
               _fashionCodeController.start(_loc5_);
               break;
            case "vehicleroomlist":
               _vehicleDaimonTrailController.start(_loc5_);
               break;
            case "vehicledaimon":
               _vehicleDaimonController.start(_loc5_);
               break;
            case "bottle":
               _bottleController.start(_loc5_);
               break;
            case "pet":
               _petController.start(_loc5_);
               break;
            case "faterotary":
               _fateRotaryControler.start(_loc5_);
               break;
            case "space":
               _spaceController.start(_loc5_);
               break;
            case "petchallenge":
               _petchallengeController.start(_loc5_);
               break;
            case "answer":
               _answeControler.start(_loc5_);
               break;
            case "freedomteam":
               _freedomTeamFrameController.start(_loc5_);
               break;
            case "treasuremap":
               _treasureMapFrameController.start(_loc5_);
               break;
            case "singlepass":
               _singlePassFrameController.start(_loc5_);
               break;
            case "funpreview":
               _funPreviewControler.start(_loc5_);
               break;
            case "expback":
               _expBackControler.start(_loc5_);
               break;
            case "playerinfo":
               _playerinfoController.start(_loc5_);
               break;
            case "lottery":
               _lotteryController.start(_loc5_);
               break;
            case "guidetask":
               _guideTaskController.start(_loc5_);
               break;
            case "treasurehunt":
               _treasureHuntControler.start(_loc5_);
               break;
            case "magiccard":
               _magicCardControler.start(_loc5_);
               break;
            case "molong":
               _molongControl.start(_loc5_);
               break;
            case "bloody":
               _bloodyControl.start(_loc5_);
               break;
            case "marry":
               _marryController.start(_loc5_);
               break;
            case "shoubang":
               _shoubangControler.start(_loc5_);
               break;
            case "gemmaze":
               _gemMazeControler.start(_loc5_);
               break;
            case "slot":
               _slotController.start(_loc5_);
               break;
            case "worldmap":
               _worldMapController.start(_loc5_);
               break;
            case "fish":
               _fishControler.start(_loc5_);
               break;
            case "goldroad":
               _goldRoadControler.start(_loc5_);
               break;
            case "loginactive":
               _loginActiveControler.start(_loc5_);
               break;
            case "vicepassword":
               _vicepasswordController.start(_loc5_);
               break;
            case "newyearact":
               _newYearActController.start(_loc5_);
               break;
            case "petboss":
               _petbossController.start(_loc5_);
               break;
            case "monopoly":
               _monopolyController.start(_loc5_);
               break;
            case "timebuy":
               _timeBuyController.start(_loc5_);
               break;
            case "outercityshop":
               _outerCityShopControler.start(_loc5_);
               break;
            case "llk":
               _llkController.start(_loc5_);
               break;
            case "child":
               _childController.start(_loc5_);
               break;
            case "svsmap":
               _svsController.start(_loc5_);
               break;
            case "battleMount":
               _battleMountController.start(_loc5_);
               break;
            case "steelmap":
               _steelController.start(_loc5_);
               break;
            case "steelmap":
               _steelController.start(_loc5_);
               break;
            case "skytreasure":
               _skyTreasureControler.start(_loc5_);
               break;
            case "farm":
               _farmController.start(_loc5_);
               break;
            case "birthday":
               _birthdayController.start(_loc5_);
               break;
            case "remotepet":
               _remotePetController.start(_loc5_);
               break;
            case "sacrifice":
               _sacrificeController.start(_loc5_);
               break;
            case "godtreasure":
               _godTreasureControler.start(_loc5_);
               break;
            case "hallfame":
               _hallFameController.start(_loc5_);
               break;
            case "christmastree":
               _christmasTreeController.start(_loc5_);
               break;
            case "childpve":
               _childPveController.preStart(_loc5_);
               break;
            case "childarena":
               _childArenaController.start(_loc5_);
               break;
            case "duskarea":
               _duskAreaController.start(_loc5_);
               break;
            case "skyboxroad":
               _skyBoxRoadControler.start(_loc5_);
               break;
            case "gamebox":
               _gameboxControler.start(_loc5_);
               break;
            case "blackjack":
               _blackjackControler.start(_loc5_);
               break;
            case "artifact":
               _artifactControler.start(_loc5_);
               break;
            case "poker":
               _pokerControler.start(_loc5_);
               break;
            case "regress":
               _regressControler.start(_loc5_);
               break;
            case "bingo":
               _bingoControler.start(_loc5_);
               break;
            case "outyard":
               _outyardControler.start(_loc5_);
               break;
            case "cathouse":
               _catHouseController.start(_loc5_);
               break;
            case "registwelfare":
               _registWelfareControler.start(_loc5_);
               break;
            case "heroroad":
               _heroRoadControler.start(_loc5_);
               break;
            case "publicchairs":
               _publicChairsControler.start(_loc5_);
               break;
            case "cultureactive":
               _cultureActiveControler.start(_loc5_);
               break;
            case "goldendionysia":
               _goldenDionysiaControler.start(_loc5_);
               break;
            case "ancientartifact":
               _ancientArtifactControler.start(_loc5_);
               break;
            case "publicegg":
               _publicEggControler.start(_loc5_);
               break;
            case "pandora":
               _pandoraControler.start(_loc5_);
               break;
            case "chargelottery":
               _chargeLotteryControler.start(_loc5_);
               break;
            case "magicpub":
               _magicPubControler.start(_loc5_);
               break;
            case "perkinlab":
               _perkinLabControler.start(_loc5_);
               break;
            case "continuepayrebate":
               _continuePayRebateControler.start(_loc5_);
               break;
            case "minefield":
               _mineFieldControler.start(_loc5_);
               break;
            case "changejob":
               _changeJobControler.start(_loc5_);
               break;
            case "mailcheck":
               _mailCheckControler.start(_loc5_);
               break;
            case "archaeology":
               _archaeologyControler.start(_loc5_);
               break;
            case "dragontitan":
               _dragonTitanControler.start(_loc5_);
               break;
            case "childpatrol":
               _childPatrolControler.start(_loc5_);
               break;
            case "sale":
               _saleControler.start(_loc5_);
               break;
            case "navigation":
               _navigationControler.start(_loc5_);
               break;
            case "exchangebox":
               _exchangeBoxControler.start(_loc5_);
               break;
            case "crossguild":
               _crossGuildControler.start(_loc5_);
               break;
            case "areslords":
               _aresLordsController.start(_loc5_);
               break;
            case "braveleg":
               _braveLegController.start(_loc5_);
               break;
            case "gloryroad":
               _gloryRoadController.start(_loc5_);
               break;
            case "pethallows":
               _petHallowsControler.start(_loc5_);
               break;
            case "discountshop":
               _discountShopController.start(_loc5_);
               break;
            case "rapidthrough":
               _rapidThroughController.start(_loc5_);
               break;
            case "raveparty":
               _ravePartyControler.start(_loc5_);
               break;
            case "childesal":
               _childsealControler.start(_loc5_);
               break;
            case "encogold":
               _encoGoldControler.start(_loc5_);
               break;
            case "childnursingspirit":
               _childNursingSpiritControler.start(_loc5_);
               break;
            case "abysm":
               _outyardControler.start(_loc5_);
               break;
            case "childformation":
               _outyardControler.start(_loc5_);
               break;
            case "godsevening":
               _godsEveningController.start(_loc5_);
               break;
            case "spacetimefault":
               _spacetimeFault.start(_loc5_);
               break;
            case "lordtrial":
               _lordTrialController.start(_loc5_);
               break;
            case "alchemical":
               _alchemicalController.start(_loc5_);
               break;
            case "unrealshooting":
               _unrealShootingController.start(_loc5_);
               break;
            case "timevortex":
               _timeVortexController.start(_loc5_);
               break;
            case "oldbacker":
               _oldBackerControler.start(_loc5_);
               break;
            case "dragontalker":
               _dragonTalkerControler.start(_loc5_);
               break;
            case "pumpingjoy":
               _pumpingJoyControler.start(_loc5_);
               break;
            case "daylight":
               _dayLightControler.start(_loc5_);
               break;
            case "stargazing":
               _stargazingController.start(_loc5_);
               break;
            case "wholerebate":
               _wholeRebateController.start(_loc5_);
               break;
            case "dungeonturn":
               _dungeonController.start(_loc5_);
               break;
            case "planecrisis":
               _planeCrisisController.start(_loc5_);
               break;
            case "magicspring":
               _magicSpringController.start(_loc5_);
               break;
            case "eclipticpalace":
               _eclipticPalaceController.start(_loc5_);
               break;
            case "monthcard":
               _monthCardController.start(_loc5_);
               break;
            case "upgradepresent":
               _upgradePresentController.start(_loc5_);
               break;
            case "demonland":
               _demonLandController.start(_loc5_);
               break;
            case "goldensheep":
               _goldenSheepController.start(_loc5_);
               break;
            case "landmine":
               _landMineController.start(_loc5_);
               break;
            case "goddess":
               _goddessController.start(_loc5_);
               break;
            case "foisonhorn":
               _foisonHornController.start(_loc5_);
               break;
            case "guildfb":
               _guildfbController.start(_loc5_);
               break;
            case "mvpshop":
               _mvpShopController.start(_loc5_);
               break;
            case "gamehall":
               _gameHallController.start(_loc5_);
               break;
            case "apex":
               _apexController.start(_loc5_);
               break;
            case "monster":
               _monsterController.start(_loc5_);
               break;
            case "antaeus":
               if(!VersionSwitch.ANTAEUS)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("resourcebar.view.ChildrenFigureView.noOpen"));
                  return;
               }
               _antaeusController.start(_loc5_);
               break;
            case "monsterexplore":
               _monsterExploreController.start(_loc5_);
               break;
            case "luckylottery":
               _luckyLotteryController.start(_loc5_);
               break;
            case "dreamarena":
               _dreamArenaController.start(_loc5_);
               break;
            case "stokesore":
               _stokesOreControler.start(_loc5_);
               break;
            case "airgarden":
               _airGardenControl.start(_loc5_);
               break;
            case "avenger":
               _avengerControl.start(_loc5_);
               break;
            case "revengeroad":
               _revengeRoadController.start(_loc5_);
               break;
            case "wishpool":
               _wishPoolController.start(_loc5_);
               break;
            case "redemptionroad":
               _redemptionRoadControl.start(_loc5_);
               break;
            case "supersignincard":
               _superSigninCardController.start(_loc5_);
               break;
            case "proficiency":
               _proficiencyControler.start(_loc5_);
               break;
            case "kingback":
               _kingbackControler.start(_loc5_);
               break;
            case "guildwanted":
               _guildWantedController.start(_loc5_);
               break;
            case "sevenyear":
               _sevenYearController.start(_loc5_);
               break;
            case "allmanexchange":
               _allManExchangeController.start(_loc5_);
               break;
            case "increasinglyroad":
               _increasinglyRoadControler.start(_loc5_);
               break;
            case "spiritexpedition":
               _spiritExpeditionControl.start(_loc5_);
               break;
            case "ylexpedition":
               _ylexpedtionController.start(_loc5_);
               break;
            case "platinum":
               _platinumController.start(_loc5_);
               break;
            case "demonroadshop":
               _demonroadShopController.start(_loc5_);
               break;
            case "selfchess":
               _selfChessControl.start(_loc5_);
               break;
            case "customizedvip":
               _customizedVipControl.start(_loc5_);
               break;
            case "shadowland":
               _shadowLandController.start(_loc5_);
               break;
            case "darkmaze":
               _darkMazeController.start(_loc5_);
               break;
            case "stelesys":
               _stelesysController.start(_loc5_);
               break;
            case "remainsexplore":
               _remainsExploreController.start(_loc5_);
               break;
            case "skystep":
               _skyStepController.start(_loc5_);
               break;
            case "consortianewboss":
               _consortiaNewBossController.start(_loc5_);
               break;
            case "newfirstpay":
               _newFirstPayController.start(_loc5_);
               break;
            case "question":
               _questionController.start(_loc5_);
               break;
            case "poseidonshop":
               _poseidonController.start(_loc5_);
               break;
            case "royaltyboss":
               _royaltyBossController.start(_loc5_);
               break;
            case "forbiddenboss":
               _forbiddenBossController.start(_loc5_);
               break;
            case "theseussoul":
               _theseussoulController.start(_loc5_);
               break;
            case "newmemorycard":
               _newMemoryCardController.start(_loc5_);
               break;
            case "secretadventure":
               _secretAdController.start(_loc5_);
               break;
            case "carnival":
               _carnivalController.start(_loc5_);
               break;
            case "newactiveleed":
               _newActiveLeedController.start(_loc5_);
               break;
            case "warsoultower":
               _warSoulTowerController.start(_loc5_);
               break;
            case "finalroad":
               _finalRoadController.start(_loc5_);
               break;
            case "godpvpenter":
               _godPvpEnterController.start(_loc5_);
               break;
            case "theseuspvp":
               _theseusPvpController.start(_loc5_);
               break;
            case "sqmemory":
               _sqMemoryController.start(_loc5_);
               break;
            case "oldplayerreturn":
               _oldPlayerReturnController.start(_loc5_);
               break;
            case "secretwar":
               _secretwarContrl.start(_loc5_);
               break;
            case "yearactive":
               _yearactiveContrl.start(_loc5_);
               break;
            case "minos":
               _minousCrl.start(_loc5_);
               break;
            case "chesspvp":
               _chessPvpCtl.start(_loc5_);
               break;
            case "christmas":
               _christmasController.start(_loc5_);
               break;
            case "childnswar":
               _childnswarContorller.start(_loc5_);
               break;
            case "thesstower":
            case "thessbox":
               _commonCtl.start(_loc5_);
               break;
            default:
               _loc6_ = LanguageMgr.GetTranslation("yishi.manager.FrameControllerManager.vModuleFrameError");
               throw new Error(_loc6_ + ":" + param1);
         }
      }
      
      public function get shopController() : ShopControler
      {
         return _shopController;
      }
      
      public function get dungeonexploController() : DungeonexploController
      {
         return _dungeonexploController;
      }
      
      public function get buildingController() : BuildingControler
      {
         return _buildingController;
      }
      
      public function get armyController() : ArmyControler
      {
         return _armyController;
      }
      
      public function get storeController() : StoreControler
      {
         return _storeController;
      }
      
      public function get friendControler() : FriendControler
      {
         return _friendControler;
      }
      
      public function get settingControler() : SettingControler
      {
         return _settingControler;
      }
      
      public function get emailControler() : EmailControler
      {
         return _emailControler;
      }
      
      public function get taskControler() : TaskControler
      {
         return _taskControler;
      }
      
      public function get consortiaController() : ConsortiaControler
      {
         return _consortiaController;
      }
      
      public function get offerRewardController() : OfferRewardController
      {
         return _offerRewardController;
      }
      
      public function get sortController() : SortController
      {
         return _sortController;
      }
      
      public function get pveRoomListControler() : PVERoomListControler
      {
         return _pveRoomlistControler;
      }
      
      public function get theseusRoomListControler() : TheseusRoomListControler
      {
         return _theseusRoomlistControler;
      }
      
      public function get pvpRoomlistControler() : PVPRoomListControler
      {
         return _pvpRoomlistControler;
      }
      
      public function get selectCampaignControler() : SelectCampaignController
      {
         return _selectCampaignControler;
      }
      
      public function get colosseumControler() : ColosseumControler
      {
         return _colosseumControler;
      }
      
      public function get worldBossControler() : WorldBossControler
      {
         return _worldBossControler;
      }
      
      public function get starController() : StarController
      {
         return _starController;
      }
      
      public function get pvpControler() : PvPControler
      {
         return _pvpControler;
      }
      
      public function get matelordsController() : MatelordsController
      {
         return _matelordsController;
      }
      
      public function get gradeBoxControler() : GradeBoxControler
      {
         return _gradeBoxControler;
      }
      
      public function get timeBoxControler() : TimeBoxControler
      {
         return _timeBoxControler;
      }
      
      public function get feedBackControlerControler() : FeedBackControler
      {
         return _feedBackControler;
      }
      
      public function get funnyControler() : FunnyControler
      {
         return _funnyControler;
      }
      
      public function get onLineController() : OnLineController
      {
         return _onLineController;
      }
      
      public function get hookControler() : HookContorler
      {
         return _hookControler;
      }
      
      public function get mazeControler() : MazeControler
      {
         return _mazeControler;
      }
      
      public function get pvpMapControler() : PvpMapControler
      {
         return _pvpMapControler;
      }
      
      public function get auctionController() : AuctionControl
      {
         return _auctionController;
      }
      
      public function get vipController() : VIPControler
      {
         return _vipControler;
      }
      
      public function get countloginControler() : CountLoginControler
      {
         return _countloginControler;
      }
      
      public function get bag360Controler() : Bag360Controler
      {
         return _bag360Controler;
      }
      
      public function get customerServiceController() : CustomerServiceController
      {
         return _customerServiceController;
      }
      
      public function get mysteryShopController() : MysteryShopControler
      {
         return _mysteryShopController;
      }
      
      public function get supermarketController() : SupermarketController
      {
         return _supermarketController;
      }
      
      public function get seminaryBlessControler() : SeminaryBlessControler
      {
         return _seminaryBlessControler;
      }
      
      public function get firstPayControler() : FirstPayControler
      {
         return _firstPayControler;
      }
      
      public function get exchargeAllControler() : ExchargeRankController
      {
         return _exchargeAllController;
      }
      
      public function get mopupController() : MopupController
      {
         return _mopupController;
      }
      
      public function get questionnaireController() : QuestionnaireController
      {
         return _questionnaireController;
      }
      
      public function get mountsController() : MountsController
      {
         return _mountsController;
      }
      
      public function get consortiaGroupChatControler() : ConsortiaGroupChatControler
      {
         return _consortiaGroupChatControler;
      }
      
      public function get kingcontractControler() : KingContractControler
      {
         return _kingcontractControler;
      }
      
      public function get secretaryContractControler() : SecretaryContractControler
      {
         return _secretaryContractControler;
      }
      
      public function get goodsListControler() : GoodsListControler
      {
         return _goodsListControler;
      }
      
      public function get securityCodeController() : SecurityCodeControl
      {
         return _securityCodeController;
      }
      
      public function get dayGuideController() : DayGuideController
      {
         return _dayGuideController;
      }
      
      public function get timeStoryControler() : TimeStoryControler
      {
         return _timeStoryControler;
      }
      
      public function get appellControler() : AppellControler
      {
         return _appellControler;
      }
      
      public function get fashionCodeController() : FashionStoreControler
      {
         return _fashionCodeController;
      }
      
      public function get vehicleDaimonController() : VehicleDaimonController
      {
         return _vehicleDaimonController;
      }
      
      public function get vehicleDaimonTrailController() : VehicleDaimonTrialController
      {
         return _vehicleDaimonTrailController;
      }
      
      public function get petController() : PetController
      {
         return _petController;
      }
      
      public function get petbossController() : PetBossController
      {
         return _petbossController;
      }
      
      public function get spaceController() : SpaceController
      {
         return _spaceController;
      }
      
      public function get planeCrisisController() : PlaneCrisisController
      {
         return _planeCrisisController;
      }
      
      public function get fateRotaryControler() : FateRotaryControler
      {
         return _fateRotaryControler;
      }
      
      public function get fundController() : FundController
      {
         return _fundController;
      }
      
      public function get petchallengeController() : PetChallengeController
      {
         return _petchallengeController;
      }
      
      public function get freedomTeamFrameController() : FreedomTeamFrameController
      {
         return _freedomTeamFrameController;
      }
      
      public function get treasureMapFrameController() : TreasureMapFrameController
      {
         return _treasureMapFrameController;
      }
      
      public function get singlePassFrameController() : SinglePassFrameController
      {
         return _singlePassFrameController;
      }
      
      public function get funPreviewControler() : FunPreviewControler
      {
         return _funPreviewControler;
      }
      
      public function get answerController() : AnswerControler
      {
         return _answeControler;
      }
      
      public function get expBackControler() : ExpBackControler
      {
         return _expBackControler;
      }
      
      public function get lotteryController() : LotteryController
      {
         return _lotteryController;
      }
      
      public function get treasureHuntControler() : TreasureHuntControler
      {
         return _treasureHuntControler;
      }
      
      public function get magicCardControler() : MagicCardControler
      {
         return _magicCardControler;
      }
      
      public function get marryController() : MarryController
      {
         return _marryController;
      }
      
      public function get guideTaskController() : GuideTaskController
      {
         return _guideTaskController;
      }
      
      public function get fishControler() : FishControler
      {
         return _fishControler;
      }
      
      public function get gemMazeController() : GemMazeControler
      {
         return _gemMazeControler;
      }
      
      public function get worldMapController() : WorldMapControler
      {
         return _worldMapController;
      }
      
      public function get planesWarControler() : PlanesWarControler
      {
         return _planesWarControler;
      }
      
      public function get skyBoxRoadControler() : SkyBoxRoadControler
      {
         return _skyBoxRoadControler;
      }
      
      public function get increasinglyRoadControler() : IncreasinglyRoadControler
      {
         return _increasinglyRoadControler;
      }
      
      public function get yLExpedtionController() : YLExpeditionController
      {
         return _ylexpedtionController;
      }
      
      public function get blackjackControler() : BlackjackControler
      {
         return _blackjackControler;
      }
      
      public function get artifactControler() : ArtifactControler
      {
         return _artifactControler;
      }
      
      public function get pokerControler() : PokerControler
      {
         return _pokerControler;
      }
      
      public function get regressControler() : RegressControler
      {
         return _regressControler;
      }
      
      public function get bingoControler() : BingoControler
      {
         return _bingoControler;
      }
      
      public function get outyardControler() : OutyardControler
      {
         return _outyardControler;
      }
      
      public function get catHouseController() : CatHouseController
      {
         return _catHouseController;
      }
      
      public function get registWelfareControler() : RegistWelfareControler
      {
         return _registWelfareControler;
      }
      
      public function get heroRoadControler() : HeroRoadControler
      {
         return _heroRoadControler;
      }
      
      public function get publicChairsControler() : PublicChairsControler
      {
         return _publicChairsControler;
      }
      
      public function get cultureActiveControler() : CultureActiveControler
      {
         return _cultureActiveControler;
      }
      
      public function get goldendionysiaController() : GoldendionysiaController
      {
         return _goldenDionysiaControler;
      }
      
      public function get ancientArtifactControler() : AncientArtifactControler
      {
         return _ancientArtifactControler;
      }
      
      public function get publicEggControler() : PublicEggControler
      {
         return _publicEggControler;
      }
      
      public function get pandoraControler() : PandoraControler
      {
         return _pandoraControler;
      }
      
      public function get chargeLotteryControler() : ChargeLotteryControler
      {
         return _chargeLotteryControler;
      }
      
      public function get magicPubControler() : MagicPubControler
      {
         return _magicPubControler;
      }
      
      public function get molongControler() : MolongController
      {
         return _molongControl;
      }
      
      public function get bloodyControl() : BloodyController
      {
         return _bloodyControl;
      }
      
      public function get timeBuyController() : TimeBuyController
      {
         return _timeBuyController;
      }
      
      public function get crossGuildControler() : CrossGuildControler
      {
         return _crossGuildControler;
      }
      
      public function get goldRoadControler() : GoldRoadControler
      {
         return _goldRoadControler;
      }
      
      public function get loginActiveControler() : LoginActiveControler
      {
         return _loginActiveControler;
      }
      
      public function get outerCityShopControler() : OuterCityShopControler
      {
         return _outerCityShopControler;
      }
      
      public function get remotePetController() : RemotePetController
      {
         return _remotePetController;
      }
      
      public function get childPveController() : ChildPveController
      {
         return _childPveController;
      }
      
      public function get childArenaController() : ChildArenaController
      {
         return _childArenaController;
      }
      
      public function get tattooController() : TattooController
      {
         return _tattooController;
      }
      
      public function get hallFameController() : HallFameController
      {
         return _hallFameController;
      }
      
      public function get vicepasswordController() : VicepasswordController
      {
         return _vicepasswordController;
      }
      
      public function get newYearActController() : NewYearActController
      {
         return _newYearActController;
      }
      
      public function get monopolyController() : MonopolyController
      {
         return _monopolyController;
      }
      
      public function get svsController() : SvsController
      {
         return _svsController;
      }
      
      public function get steelController() : SteelController
      {
         return _steelController;
      }
      
      public function get skyTreasureControler() : SkyTreasureControler
      {
         return _skyTreasureControler;
      }
      
      public function get sacrificeController() : SacrificeController
      {
         return _sacrificeController;
      }
      
      public function get godTreasureControler() : GodTreasureControler
      {
         return _godTreasureControler;
      }
      
      public function get christmasTreeController() : ChristmasTreeControler
      {
         return _christmasTreeController;
      }
      
      public function get gameboxController() : GameBoxControler
      {
         return _gameboxControler;
      }
      
      public function get perkinLabControler() : PerkinLabControler
      {
         return _perkinLabControler;
      }
      
      public function get mineFieldControler() : MineFieldControler
      {
         return _mineFieldControler;
      }
      
      public function get continuePayRebateControler() : ContinuePayRebateControler
      {
         return _continuePayRebateControler;
      }
      
      public function get changeJobControler() : ChangeJobControler
      {
         return _changeJobControler;
      }
      
      public function get mailCheckControler() : MailCheckControler
      {
         return _mailCheckControler;
      }
      
      public function get dragonTitanControler() : DragonTitanControler
      {
         return _dragonTitanControler;
      }
      
      public function get archaologyControler() : ArchaeologyContorler
      {
         return _archaeologyControler;
      }
      
      public function get childPatrolControler() : ChildPatrolControler
      {
         return _childPatrolControler;
      }
      
      public function get saleControler() : SaleControler
      {
         return _saleControler;
      }
      
      public function get navigationControler() : NavigationControler
      {
         return _navigationControler;
      }
      
      public function get crossCostControler() : CrossCostController
      {
         return _crossCostController;
      }
      
      public function get luckyExchangeControler() : LuckyExchangeControler
      {
         return _luckyExchangeControler;
      }
      
      public function get exchangeBoxControler() : ExchangeBoxControler
      {
         return _exchangeBoxControler;
      }
      
      public function get aresLordsController() : AresLordsController
      {
         return _aresLordsController;
      }
      
      public function get braveLegController() : BraveLegController
      {
         return _braveLegController;
      }
      
      public function get petHallowsControler() : PetHallowsControler
      {
         return _petHallowsControler;
      }
      
      public function get rapidThroughController() : RapidThroughController
      {
         return _rapidThroughController;
      }
      
      public function get ravePartyControler() : RavePartyControler
      {
         return _ravePartyControler;
      }
      
      public function get childsealControler() : ChildesalControler
      {
         return _childsealControler;
      }
      
      public function get encoGoldControler() : EncoGoldControler
      {
         return _encoGoldControler;
      }
      
      public function get childNursingSpiritControler() : ChildNursingSpiritControler
      {
         return _childNursingSpiritControler;
      }
      
      public function get childControler() : ChildControler
      {
         return _childController;
      }
      
      public function get lordTrialController() : LordTrialController
      {
         return _lordTrialController;
      }
      
      public function get alchemicalController() : AlchemicalController
      {
         return _alchemicalController;
      }
      
      public function get unrealShootingController() : UnrealShootingController
      {
         return _unrealShootingController;
      }
      
      public function get timeVortexController() : TimeVortexController
      {
         return _timeVortexController;
      }
      
      public function get oldBackerControler() : OldBackerControler
      {
         return _oldBackerControler;
      }
      
      public function get dragonTalkerControler() : DragonTalkerController
      {
         return _dragonTalkerControler;
      }
      
      public function get godsEveningController() : GodsEveningController
      {
         return _godsEveningController;
      }
      
      public function get pumpingJoyControler() : PumpingJoyControler
      {
         return _pumpingJoyControler;
      }
      
      public function get dayLightControler() : DayLightController
      {
         return _dayLightControler;
      }
      
      public function get starGazingController() : StarGazingController
      {
         return _stargazingController;
      }
      
      public function get dungeonController() : DungeonController
      {
         return _dungeonController;
      }
      
      public function get goldenSheepController() : GoldenSheepController
      {
         return _goldenSheepController;
      }
      
      public function get landMineController() : LandMineController
      {
         return _landMineController;
      }
      
      public function get goddessController() : GodDessController
      {
         return _goddessController;
      }
      
      public function get guildFbController() : GuildFbController
      {
         return _guildfbController;
      }
      
      public function get mvpShopController() : MvpShopController
      {
         return _mvpShopController;
      }
      
      public function get gameHallController() : GameHallController
      {
         return _gameHallController;
      }
      
      public function get apexController() : ApexController
      {
         return _apexController;
      }
      
      public function get monsterController() : MonsterControler
      {
         return _monsterController;
      }
      
      public function get monsterExploreController() : MonsterExploreControler
      {
         return _monsterExploreController;
      }
      
      public function get luckyLotteryController() : LuckyLotteryController
      {
         return _luckyLotteryController;
      }
      
      public function get dreamArenaController() : DreamArenaController
      {
         return _dreamArenaController;
      }
      
      public function get stokesOreControler() : StokesOreControler
      {
         return _stokesOreControler;
      }
      
      public function get airGardenControl() : AirGardenControl
      {
         return _airGardenControl;
      }
      
      public function get avengerControl() : AvengerControler
      {
         return _avengerControl;
      }
      
      public function get wishPoolController() : WishPoolController
      {
         return _wishPoolController;
      }
      
      public function get redemptionRoadControl() : RedemptionRoadControl
      {
         return _redemptionRoadControl;
      }
      
      public function get superSigninCardController() : SuperSigninCardController
      {
         return _superSigninCardController;
      }
      
      public function get proficiencyControler() : ProficiencyControler
      {
         return _proficiencyControler;
      }
      
      public function get kingbackControler() : KingbackControler
      {
         return _kingbackControler;
      }
      
      public function get guildWantedController() : GuildWantedController
      {
         return _guildWantedController;
      }
      
      public function get sevenYearController() : SevenYearController
      {
         return _sevenYearController;
      }
      
      public function get allManExchangeController() : AllManExchangeController
      {
         return _allManExchangeController;
      }
      
      public function get spiritExpeditionControl() : SpiritExpeditionControl
      {
         return _spiritExpeditionControl;
      }
      
      public function get platinumControl() : PlatinumControler
      {
         return _platinumController;
      }
      
      public function get customizedVipControl() : CustomizedVipControl
      {
         return _customizedVipControl;
      }
      
      public function get shadowLandController() : ShadowLandController
      {
         return _shadowLandController;
      }
      
      public function get remainsExploreController() : RemainsExploreController
      {
         return _remainsExploreController;
      }
      
      public function get consortiaNewBossController() : ConsortiaNewBossControler
      {
         return _consortiaNewBossController;
      }
      
      public function get newFirstPayController() : NewFirstPayController
      {
         return _newFirstPayController;
      }
      
      public function get questionController() : QuestionController
      {
         return _questionController;
      }
      
      public function get poseidonController() : PoseidonController
      {
         return _poseidonController;
      }
      
      public function get royaltyBossController() : RoyaltyBossController
      {
         return _royaltyBossController;
      }
      
      public function get forbiddenBossController() : ForbiddenBossController
      {
         return _forbiddenBossController;
      }
      
      public function get theseussoulController() : TheseussoulController
      {
         return _theseussoulController;
      }
      
      public function get newMemoryCardController() : NewMemoryCardController
      {
         return _newMemoryCardController;
      }
      
      public function get secretAdController() : SecretAdventureController
      {
         return _secretAdController;
      }
      
      public function get newActiveLeedController() : NewActiveLeedController
      {
         return _newActiveLeedController;
      }
      
      public function get warSoulTowerController() : WarSoulTowerController
      {
         return _warSoulTowerController;
      }
      
      public function get finalRoadController() : FinalRoadController
      {
         return _finalRoadController;
      }
      
      public function get carnivalController() : CarnivalController
      {
         return _carnivalController;
      }
      
      public function get theseusPvpController() : TheseusPvpController
      {
         return _theseusPvpController;
      }
      
      public function get godPvpEnterController() : GodPvpEnterController
      {
         return _godPvpEnterController;
      }
      
      public function get oldPlayerReturnController() : OldPlayerReturnController
      {
         return _oldPlayerReturnController;
      }
      
      public function get secretwarContrl() : SecretWarController
      {
         return _secretwarContrl;
      }
      
      public function get yearactiveContrl() : YearActiveController
      {
         return _yearactiveContrl;
      }
      
      public function get minousCrl() : MinosController
      {
         return _minousCrl;
      }
      
      public function get christmasController() : ChristmasController
      {
         return _christmasController;
      }
      
      public function get chessPvpCtl() : ConsortiaChessController
      {
         return _chessPvpCtl;
      }
      
      public function get skyTreasureController() : SkyTreasureController
      {
         return _skyTreasureController;
      }
   }
}

