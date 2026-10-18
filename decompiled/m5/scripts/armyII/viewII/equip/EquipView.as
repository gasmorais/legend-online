package armyII.viewII.equip
{
   import avatar.view.ShowAvatar;
   import bag.events.BagEvent;
   import cell.view.playerequip.HonorCell;
   import cell.view.playerequip.PlayerEquipCell;
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import events.FashionEvent;
   import events.MagicCardEvent;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mainBar.StripView;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.ArmySocketOutManager;
   import managers.DragonTalkerManager;
   import managers.FashionManager;
   import managers.TreasureHuntManager;
   import managers.VIPManager;
   import marry.view.MarryRingView;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.card.MagicCardModel;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.fashion.FashionModel;
   import mvc.module.faterotary.FateRotarySkillInfo;
   import mvc.module.vip.VIPModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.SimplePlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.PlayerEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.MagicCardManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class EquipView extends Sprite implements Disposeable
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _figureBack:ScaleFrameImage;
      
      private var _figure:ShowAvatar;
      
      private var _equipGirdBack:MovieClip;
      
      private var _fashionGirdBack:MovieClip;
      
      private var _fightBg:MovieClip;
      
      private var _fightText:Bitmap;
      
      private var _equipViewList:SimpleDictionary;
      
      private var _fashionViewList:SimpleDictionary;
      
      private var _honerViewList:SimpleDictionary;
      
      private var _equipList:Vector.<PlayerEquipCell>;
      
      private var _fashionList:Vector.<PlayerEquipCell>;
      
      private var _fashionTickList:Vector.<FashionTick>;
      
      private var _weapon:PlayerEquipCell;
      
      private var _headdress:PlayerEquipCell;
      
      private var _clothes:PlayerEquipCell;
      
      private var _necklace:PlayerEquipCell;
      
      private var _ring1:PlayerEquipCell;
      
      private var _ring2:PlayerEquipCell;
      
      private var _trinket1:PlayerEquipCell;
      
      private var _trinket2:PlayerEquipCell;
      
      private var _wing:PlayerEquipCell;
      
      private var _weaponFashion:PlayerEquipCell;
      
      private var _relic:PlayerEquipCell;
      
      private var _heraldry:PlayerEquipCell;
      
      private var _headdressFshion:PlayerEquipCell;
      
      private var _clothesFashion:PlayerEquipCell;
      
      private var _tickFashion1:FashionTick;
      
      private var _tickFashion2:FashionTick;
      
      private var _tickFashion3:FashionTick;
      
      private var _tickFashion4:FashionTick;
      
      private var _honor1:HonorCell;
      
      private var _marryRing:MarryRingView;
      
      private var _strip1:StripView;
      
      private var _strip2:StripView;
      
      private var _strip3:StripView;
      
      private var _strip4:StripView;
      
      private var _jewelSuitBtn:BaseButton;
      
      private var _seniorJewelSuitBtn:BaseButton;
      
      private var _jewelJSuitLevel:FilterFrameText;
      
      private var _fateRotaryBtn:BaseButton;
      
      private var _conciseBtn:BaseButton;
      
      private var _conciseText:FilterFrameText;
      
      private var _starSuitBtn:BaseButton;
      
      private var _starSuitLevel:FilterFrameText;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _levelTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _consortiaTxt:FilterFrameText;
      
      private var _vipIconBtn:BaseButton;
      
      private var _NovipIconBtn:BaseButton;
      
      private var _equip:Sprite;
      
      private var _fashion:Sprite;
      
      private var _fashionBtn:IconButton;
      
      private var _equipBtn:IconButton;
      
      private var _fashionPanel:Image;
      
      private var _fashionComposeBtn:BaseButton;
      
      private var _fashionSwitchBtn:BaseButton;
      
      private var _fashionRefreshBtn:BaseButton;
      
      private var _switchTip:TextButton;
      
      private var _hideBtn:SelectedButton;
      
      private var _hideTxt:FilterFrameText;
      
      private var _hGap:Bitmap;
      
      private var _fightValue:int;
      
      private var _fightBmp:Bitmap;
      
      private var _fightMc:MovieClip;
      
      private var _jobChangeBtn:ScaleFrameImage;
      
      private var _attributeButton:BaseButton;
      
      private var _fashionIdentityTip:BaseButton;
      
      private var _fashionProgressBar:MovieClip;
      
      private var _fashionProgressTxt:FilterFrameText;
      
      private var _fashionLvlBmp:Bitmap;
      
      private var _fashionLvlTxt:FilterFrameText;
      
      private var _fashionLvlStrip:StripView;
      
      private var _firstEffect:IEffect;
      
      private var _simpleInfo:SimplePlayerInfo;
      
      private var _fashionDefaultBtn:SelectedButton;
      
      private var _fashionDefaultText:FilterFrameText;
      
      private var _magicCardBtn:BaseButton;
      
      private var _equipBox:VBox;
      
      private var _buttonMc1:MovieClip;
      
      private var _buttonMc2:MovieClip;
      
      private var _buttonMc3:MovieClip;
      
      private var _magicCardBtnEffect:MainToolBtnGlowEffect;
      
      private var _playFightMc:Boolean = false;
      
      public function EquipView()
      {
         super();
         initView();
         createHeroEquip();
         refreshView();
         refreshHeroFigure();
         addEvent();
         FashionManager.instance.getFashionBook();
      }
      
      private function initView() : void
      {
         this.mouseEnabled = false;
         _back1 = ComponentFactory.Instance.creatComponentByStylename("army.FrameBack1");
         _figureBack = ComponentFactory.Instance.creatComponentByStylename("army.HeroFigureBack");
         _equipGirdBack = ComponentFactory.Instance.creatCustomObject("army.EquipGird");
         _fashionGirdBack = ComponentFactory.Instance.creatCustomObject("army.FashionGird");
         _fightBg = ComponentFactory.Instance.creatCustomObject("army.FightBg");
         _fightText = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fightTxt");
         _strip1 = ComponentFactory.Instance.creatCustomObject("army.JewelSuitBtnTip");
         _strip2 = ComponentFactory.Instance.creatComponentByStylename("army.FateBtnTip");
         _strip3 = ComponentFactory.Instance.creatComponentByStylename("army.CradBtnTip");
         _strip4 = ComponentFactory.Instance.creatCustomObject("army.conciseBtnTip");
         _jewelSuitBtn = ComponentFactory.Instance.creatComponentByStylename("army.JewelSuitBtn");
         _seniorJewelSuitBtn = ComponentFactory.Instance.creatComponentByStylename("army.SeniorJewelSuitBtn");
         _jewelJSuitLevel = ComponentFactory.Instance.creatComponentByStylename("army.JewelSuitLevel");
         _fateRotaryBtn = ComponentFactory.Instance.creatComponentByStylename("army.FateRotaryBtn");
         _conciseBtn = ComponentFactory.Instance.creatComponentByStylename("army.conciseBtn");
         _conciseText = ComponentFactory.Instance.creatComponentByStylename("army.conciseText");
         _starSuitBtn = ComponentFactory.Instance.creatComponentByStylename("army.StarSuitBtn");
         _starSuitLevel = ComponentFactory.Instance.creatComponentByStylename("army.StarSuitLevel");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("army.ThaneLevelTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("army.ThaneNameTxt");
         _consortiaTxt = ComponentFactory.Instance.creatComponentByStylename("army.ThaneConsortiaTxt");
         _vipIconBtn = ComponentFactory.Instance.creatComponentByStylename("core.vip.vipIconBtn");
         _NovipIconBtn = ComponentFactory.Instance.creatComponentByStylename("core.vip.NovipIconBtn");
         _NovipIconBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.NovipIconTip");
         _fashionPanel = ComponentFactory.Instance.creatComponentByStylename("army.fashionPanel");
         _hGap = ComponentFactory.Instance.creatBitmap("asset.playerinfo.hGapLine");
         _fashionBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionBtn");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("army.equipBtn");
         _fashionComposeBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionComposeBtn");
         _fashionSwitchBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionSwitchBtn");
         _fashionRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionRefreshBtn");
         _switchTip = ComponentFactory.Instance.creatComponentByStylename("army.fashionSwitcTip");
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("army.hideFashionBtn");
         _hideTxt = ComponentFactory.Instance.creatComponentByStylename("army.hideFashionTxt");
         _hideTxt.text = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.hideTxt");
         _fightBmp = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fightNum");
         _fightMc = ComponentFactory.Instance.creat("asset.core.powerMc");
         _jobChangeBtn = ComponentFactory.Instance.creatComponentByStylename("army.equipview.JobChangeBtn");
         _attributeButton = ComponentFactory.Instance.creatComponentByStylename("army.AttributeButton");
         _magicCardBtn = ComponentFactory.Instance.creatComponentByStylename("army.MagicCardBtn");
         _fashionDefaultBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionDefaultBtn");
         _fashionDefaultText = ComponentFactory.Instance.creatComponentByStylename("army.fashionDefaultText");
         _fashionDefaultText.text = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.fashionDefaultText");
         _fashionIdentityTip = ComponentFactory.Instance.creatComponentByStylename("army.fashionIdentityTip");
         _fashionIdentityTip.tipData = LanguageMgr.GetTranslation("fashion.tip.total",0,0,0,0);
         _fashionProgressBar = ComponentFactory.Instance.creatCustomObject("playerinfo.ProgressBar");
         _fashionProgressTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ProgressLevelTxt");
         _fashionLvlBmp = ComponentFactory.Instance.creatBitmap("asset.playerinfo.lvlBmp");
         _fashionLvlTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.fashionLevelTxt");
         _fashionLvlStrip = ComponentFactory.Instance.creatCustomObject("playerinfo.fashionProgressStrip");
         _fashionLvlStrip.setHitArea(0,0,208,24);
         if(VersionSwitch.GOD_HALIDOM)
         {
            _equipGirdBack = ComponentFactory.Instance.creatCustomObject("playerinfo.EquipGird");
         }
         else
         {
            _equipGirdBack = ComponentFactory.Instance.creatCustomObject("playerinfo.EquipGird2");
         }
         _figure = new ShowAvatar(true);
         _figure.x = 60;
         _figure.y = 40;
         _figure.mouseChildren = _figure.mouseEnabled = false;
         _hGap.width = 371;
         _hGap.x = 3;
         _hGap.y = 349;
         _switchTip.mouseEnabled = false;
         if(fashionModel.newFashionCount + fashionModel.newFashionDragonTalkerCount > 0)
         {
            _switchTip.text = fashionModel.newFashionCount + fashionModel.newFashionDragonTalkerCount + "";
            _switchTip.visible = true;
         }
         else
         {
            _switchTip.visible = false;
         }
         _vocationIcon.visible = false;
         addChild(_back1);
         addChild(_figureBack);
         _figureBack.setFrame(2);
         addChild(_figure);
         addChild(_hGap);
         _equip = new Sprite();
         _fashion = new Sprite();
         addChild(_equip);
         addChild(_fashion);
         _fashion.addChild(_fashionGirdBack);
         _fashion.addChild(_fashionPanel);
         _fashion.addChild(_equipBtn);
         _fashion.addChild(_fashionIdentityTip);
         _fashion.addChild(_fashionProgressBar);
         _fashion.addChild(_fashionProgressTxt);
         _fashion.addChild(_fashionLvlBmp);
         _fashion.addChild(_fashionLvlTxt);
         _fashion.addChild(_fashionLvlStrip);
         _fashion.addChild(_fashionComposeBtn);
         if(DragonTalkerManager.instance.model.isOpen && Boolean(VersionSwitch.DRAGONIC_FASHION))
         {
            _fashion.addChild(_fashionDefaultBtn);
            _fashion.addChild(_fashionDefaultText);
         }
         if(FashionManager.instance.fashionIdentityProgress <= 3)
         {
            _buttonMc2 = ComponentFactory.Instance.creat("asset.core.TaskRewardButtonMc3");
            _buttonMc2.pos.addChild(_fashionSwitchBtn);
            _buttonMc2.stop();
            _buttonMc2.mouseEnabled = false;
            _buttonMc2.pos.mouseEnabled = false;
            _fashion.addChild(_buttonMc2);
         }
         else
         {
            _fashion.addChild(_fashionSwitchBtn);
         }
         _fashion.addChild(_fashionRefreshBtn);
         _fashionRefreshBtn.supportTipsWhenGray = true;
         updateFashionRefreshBtn();
         _fashion.addChild(_switchTip);
         _equip.addChild(_strip1);
         _equip.addChild(_strip2);
         _equip.addChild(_strip4);
         _equip.addChild(_equipGirdBack);
         _equip.addChild(_jewelJSuitLevel);
         _equip.addChild(_conciseText);
         _equip.addChild(_starSuitLevel);
         _equip.addChild(_vipIconBtn);
         _equip.addChild(_NovipIconBtn);
         _equip.addChild(_vocationIcon);
         _equip.addChild(_levelTxt);
         _equip.addChild(_nameTxt);
         _equip.addChild(_consortiaTxt);
         if(FashionManager.instance.fashionIdentityProgress <= 1)
         {
            _buttonMc1 = ComponentFactory.Instance.creat("asset.core.TaskRewardButtonMc3");
            _buttonMc1.pos.addChild(_fashionBtn);
            _buttonMc1.play();
            _buttonMc1.mouseEnabled = false;
            _buttonMc1.pos.mouseEnabled = false;
            _equip.addChild(_buttonMc1);
         }
         else
         {
            _equip.addChild(_fashionBtn);
         }
         _equip.addChild(_fightBg);
         _equip.addChild(_fightText);
         _equip.addChild(_fightMc);
         _fightMc.x = 158;
         _fightMc.y = 376;
         _equip.addChild(_attributeButton);
         _equip.addChild(_jobChangeBtn);
         _jobChangeBtn.buttonMode = true;
         _jobChangeBtn.setFrame(1);
         _jobChangeBtn.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.JobChangeBtnClickTips");
         _strip1.addChild(_jewelSuitBtn);
         _jewelSuitBtn.enable = false;
         _jewelSuitBtn.visible = true;
         _strip1.addChild(_seniorJewelSuitBtn);
         _seniorJewelSuitBtn.visible = false;
         _strip2.addChild(_fateRotaryBtn);
         _strip4.addChild(_conciseBtn);
         _strip1.tipData = LanguageMgr.GetTranslation("army.Equip.JewelSuitBtnTip");
         _strip4.tipData = LanguageMgr.GetTranslation("army.Equip.conciseBtnTip");
         __UpvipInfoHandler(null);
         if(fashionModel.selectedPanel != "EQUIP_PANEL" && fashionModel.selectedPanel != "FASHION_PANEL")
         {
            _fashion.visible = false;
            fashionModel.selectedPanel = "EQUIP_PANEL";
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.showVersion && thane.grades >= 55 && thane.fateRotarySkillList.length > 0)
         {
            playFirstOpen();
         }
         if(VersionSwitch.MAGIC_CARD)
         {
            _strip3.addChild(_magicCardBtn);
         }
         if(playerInfo.isFirstOpenBagFrame)
         {
            FrameControllerManager.instance.treasureHuntControler.sendHuntRequest(1);
            _onMagicCardBtnHandler();
            playerInfo.isFirstOpenBagFrame = false;
         }
      }
      
      private function updateFashionRefreshBtn() : void
      {
         if(ArmyManager.instance.fashionInfoMsg.grades > 0)
         {
            _fashionRefreshBtn.enable = true;
            _fashionRefreshBtn.tipData = null;
         }
         else
         {
            _fashionRefreshBtn.enable = false;
            _fashionRefreshBtn.tipData = LanguageMgr.GetTranslation("equipView.fashionRefresh.openAlert");
         }
      }
      
      public function playFirstOpen() : void
      {
         _firstEffect = EffectManager.Instance.creatEffect(3,_fateRotaryBtn,{
            "color":"gold",
            "speed":0.4,
            "blurWidth":10,
            "intensity":40,
            "strength":0.6
         });
         _firstEffect.play();
      }
      
      private function createHeroEquip() : void
      {
         _equipViewList = new SimpleDictionary(true);
         _fashionViewList = new SimpleDictionary(true);
         _equipList = new Vector.<PlayerEquipCell>();
         _fashionList = new Vector.<PlayerEquipCell>();
         _fashionTickList = new Vector.<FashionTick>();
         _weapon = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWeaponCell");
         _weapon.sonType = 101;
         _headdress = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroHeaddressCell");
         _headdress.sonType = 103;
         _clothes = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroClothesCell");
         _clothes.sonType = 104;
         _necklace = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroNecklaceCell");
         _necklace.sonType = 106;
         _ring1 = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroRing1Cell");
         _ring1.sonType = 107;
         _ring2 = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroRing2Cell");
         _ring2.sonType = 107;
         _trinket1 = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroTrinket1Cell");
         _trinket1.sonType = 108;
         _trinket2 = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroTrinket2Cell");
         _trinket2.sonType = 108;
         _relic = ComponentFactory.Instance.creatCustomObject("playerinfo.HerorelicCell");
         _relic.sonType = 118;
         _heraldry = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroheraldryCell");
         _heraldry.sonType = 117;
         _headdressFshion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroHeaddressFashionCell");
         _headdressFshion.sonType = 110;
         _clothesFashion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroClothesFashionCell");
         _clothesFashion.sonType = 112;
         _weaponFashion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWeaponFashionCell");
         _weaponFashion.sonType = 111;
         _wing = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWingCell");
         _wing.sonType = 109;
         _tickFashion1 = ComponentFactory.Instance.creatCustomObject("playerinfo.FashionTick1");
         _tickFashion1.pos = 9;
         _tickFashion2 = ComponentFactory.Instance.creatCustomObject("playerinfo.FashionTick2");
         _tickFashion2.pos = 10;
         _tickFashion3 = ComponentFactory.Instance.creatCustomObject("playerinfo.FashionTick3");
         _tickFashion3.pos = 11;
         _tickFashion4 = ComponentFactory.Instance.creatCustomObject("playerinfo.FashionTick4");
         _tickFashion4.pos = 8;
         _fashionTickList.push(_tickFashion1);
         _fashionTickList.push(_tickFashion2);
         _fashionTickList.push(_tickFashion3);
         _fashionTickList.push(_tickFashion4);
         _equipList.push(_weapon);
         _equipList.push(_headdress);
         _equipList.push(_clothes);
         _equipList.push(_necklace);
         _equipList.push(_ring1);
         _equipList.push(_ring2);
         _equipList.push(_trinket1);
         _equipList.push(_trinket2);
         if(VersionSwitch.GOD_HALIDOM)
         {
            _equipList.push(_relic);
            _equipList.push(_heraldry);
         }
         _fashionList.push(_headdressFshion);
         _fashionList.push(_clothesFashion);
         _fashionList.push(_weaponFashion);
         _fashionList.push(_wing);
         for each(var _loc2_:PlayerEquipCell in _equipList)
         {
            _loc2_.acceptDrop = true;
            _equip.addChild(_loc2_);
         }
         for each(var _loc1_:PlayerEquipCell in _fashionList)
         {
            _loc1_.acceptDrop = true;
            _fashion.addChild(_loc1_);
         }
         for each(var _loc3_:FashionTick in _fashionTickList)
         {
            _fashion.addChild(_loc3_);
         }
         _honerViewList = new SimpleDictionary(true);
         _honor1 = ComponentFactory.Instance.creatCustomObject("playerinfo.HonorCell1");
         _honor1.acceptDrop = true;
         _equip.addChild(_honor1);
         if(!VersionSwitch.GOD_HALIDOM)
         {
            _honor1.x = 15;
         }
         _marryRing = new MarryRingView();
         _marryRing.x = VersionSwitch.GOD_HALIDOM ? 180 : 70;
         _marryRing.y = 295;
         _equip.addChild(_marryRing);
      }
      
      protected function addEvent() : void
      {
         _jewelSuitBtn.addEventListener("click",__jewelClickHandler);
         _seniorJewelSuitBtn.addEventListener("click",__jewelClickHandler);
         _fateRotaryBtn.addEventListener("click",__fateRotaryClickHandler);
         _conciseBtn.addEventListener("click",__conciseClickHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         vipModel.addEventListener("upframeview_change",__UpvipInfoHandler);
         _vipIconBtn.addEventListener("click",__openVipHandler);
         _NovipIconBtn.addEventListener("click",__openVipHandler);
         if(_hideBtn)
         {
            _hideBtn.addEventListener("select",__hideFashionHandler);
         }
         if(_fashionBtn)
         {
            _fashionBtn.addEventListener("click",__fashionHandler);
         }
         if(_equipBtn)
         {
            _equipBtn.addEventListener("click",__equipHandler);
         }
         if(_fashionComposeBtn)
         {
            _fashionComposeBtn.addEventListener("click",__fashionComposeHandler);
         }
         if(_fashionSwitchBtn)
         {
            _fashionSwitchBtn.addEventListener("click",__fashionSwitchHandler);
         }
         if(_fashionRefreshBtn)
         {
            _fashionRefreshBtn.addEventListener("click",__fashionRefreshHandler);
         }
         fashionModel.addEventListener("SWITCH_EQUIPVIEW",__panelHandler);
         if(_attributeButton)
         {
            _attributeButton.addEventListener("click",__attributeClickHandler);
         }
         thane.addEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         FashionManager.instance.addEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         _fashionIdentityTip.addEventListener("click",__fashionSwitchHandler);
         _magicCardBtn.addEventListener("click",__magicCardHandler);
         MagicCardManager.Instance.addEventListener("MAGICCARD_UPDATE",__cardUpdateHandler);
         thane.addEventListener("PLAYER_AVATA_CHANGE",__playerAvataChangeHandler);
         TreasureHuntManager.instance.addEventListener("HUNT_TEM",_onMagicCardBtnHandler);
         NotificationManager.instance.addEventListener("FASHION_SHOW_CHANGE",__fashionMsgHandler);
         NotificationManager.instance.addEventListener("FASHION_CHANGE",__fashionChangeHandler);
         _jobChangeBtn.addEventListener("click",__jobChangeBtnClickHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateDragonTalkerState);
         if(_fashionDefaultBtn)
         {
            _fashionDefaultBtn.addEventListener("click",__fashionDefaultBtnHandler);
         }
      }
      
      private function _onMagicCardBtnHandler(param1:* = null) : void
      {
         if(TreasureHuntManager.instance.model.seekCount > 0)
         {
            _magicCardBtnEffect = new MainToolBtnGlowEffect(_magicCardBtn);
            _magicCardBtnEffect.play();
            return;
         }
         if(MagicCardManager.Instance.cardModel.hasCanExplainCard)
         {
            _magicCardBtnEffect = new MainToolBtnGlowEffect(_magicCardBtn);
            _magicCardBtnEffect.play();
            return;
         }
         if(MagicCardManager.Instance.cardModel.hasCanActiveCard)
         {
            _magicCardBtnEffect = new MainToolBtnGlowEffect(_magicCardBtn);
            _magicCardBtnEffect.play();
         }
      }
      
      protected function __cardUpdateHandler(param1:MagicCardEvent) : void
      {
         var _loc2_:int = int(MagicCardManager.Instance.cardModel.getSelectedItem);
         if(_loc2_ != -1)
         {
            if(!FrameControllerManager.instance.magicCardControler.frame)
            {
               FrameControllerManager.instance.openControllerByInfo("magiccard");
            }
         }
      }
      
      private function __magicCardHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("magiccard");
      }
      
      private function __receivedBookHandler(param1:FashionEvent) : void
      {
         var _loc2_:Array = null;
         var _loc5_:Array = null;
         var _loc3_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         if(fashionModel.newFashionCount + fashionModel.newFashionDragonTalkerCount > 0)
         {
            _switchTip.text = fashionModel.newFashionCount + fashionModel.newFashionDragonTalkerCount + "";
            _switchTip.visible = true;
         }
         else
         {
            _switchTip.visible = false;
         }
         if(_fashionIdentityTip)
         {
            _loc2_ = FashionManager.instance.fashionModel.getIdentityedProperties();
            _loc5_ = FashionManager.instance.fashionModel.getAllSwitchAdd();
            _loc3_ = LanguageMgr.GetTranslation("fashion.tip.total2");
            _loc6_ = int(_loc5_.length);
            _loc7_ = "";
            _loc4_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc4_ = Math.floor(_loc5_[_loc8_] / 100 * _loc2_[_loc8_]);
               _loc7_ = LanguageMgr.GetTranslation("fashion.refreshView.tips09",_loc4_);
               _loc3_ += "\n" + LanguageMgr.GetTranslation("fashion.tip.total0" + (_loc8_ + 1),_loc2_[_loc8_],_loc7_);
               _loc8_ += 1;
            }
            _fashionIdentityTip.tipData = _loc3_;
         }
      }
      
      protected function removeEvent() : void
      {
         _jewelSuitBtn.removeEventListener("click",__jewelClickHandler);
         _seniorJewelSuitBtn.removeEventListener("click",__jewelClickHandler);
         _fateRotaryBtn.removeEventListener("click",__fateRotaryClickHandler);
         _conciseBtn.removeEventListener("click",__conciseClickHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         vipModel.removeEventListener("upframeview_change",__UpvipInfoHandler);
         _vipIconBtn.removeEventListener("click",__openVipHandler);
         _NovipIconBtn.removeEventListener("click",__openVipHandler);
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("select",__hideFashionHandler);
         }
         if(_fashionBtn)
         {
            _fashionBtn.removeEventListener("click",__fashionHandler);
         }
         if(_equipBtn)
         {
            _equipBtn.removeEventListener("click",__equipHandler);
         }
         if(_fashionComposeBtn)
         {
            _fashionComposeBtn.removeEventListener("click",__fashionComposeHandler);
         }
         if(_fashionSwitchBtn)
         {
            _fashionSwitchBtn.removeEventListener("click",__fashionSwitchHandler);
         }
         if(_fashionRefreshBtn)
         {
            _fashionRefreshBtn.removeEventListener("click",__fashionRefreshHandler);
         }
         fashionModel.removeEventListener("SWITCH_EQUIPVIEW",__panelHandler);
         if(_attributeButton)
         {
            _attributeButton.removeEventListener("click",__attributeClickHandler);
         }
         thane.removeEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         FashionManager.instance.removeEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         if(_fashionIdentityTip)
         {
            _fashionIdentityTip.removeEventListener("click",__fashionSwitchHandler);
         }
         _magicCardBtn.removeEventListener("click",__magicCardHandler);
         MagicCardManager.Instance.removeEventListener("MAGICCARD_UPDATE",__cardUpdateHandler);
         thane.removeEventListener("PLAYER_AVATA_CHANGE",__playerAvataChangeHandler);
         TreasureHuntManager.instance.removeEventListener("HUNT_TEM",_onMagicCardBtnHandler);
         NotificationManager.instance.removeEventListener("FASHION_SHOW_CHANGE",__fashionMsgHandler);
         NotificationManager.instance.removeEventListener("FASHION_CHANGE",__fashionChangeHandler);
         if(_jobChangeBtn)
         {
            _jobChangeBtn.removeEventListener("click",__jobChangeBtnClickHandler);
         }
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateDragonTalkerState);
         if(_fashionDefaultBtn)
         {
            _fashionDefaultBtn.removeEventListener("click",__fashionDefaultBtnHandler);
         }
      }
      
      private function __thaneInfoChangeHandler(param1:PlayerEvent) : void
      {
         _simpleInfo = param1.currentTarget as SimplePlayerInfo;
         refreshView();
         updateFashionRefreshBtn();
      }
      
      private function __updateDragonTalkerState(param1:String, param2:Object) : void
      {
         refreshJobChangeBtn();
      }
      
      private function __fashionDefaultBtnHandler(param1:MouseEvent) : void
      {
         var _loc5_:TodayNotAlertFrame = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = Boolean(SharedManager.instance.setDefaultFashionFlag);
         if(_fashionDefaultBtn.selected && _loc3_)
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("army.TodayNotAlertFrame");
            _loc4_ = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.defaultFashionTips");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.SimpleAlert.choiceTxt");
            _loc5_.show(_loc4_,_loc2_,__todayNotAlertSetDefaultFashion,__todayNotAlertClose,"center",2,true);
         }
         else
         {
            setDefaultFashion();
         }
      }
      
      private function __todayNotAlertSetDefaultFashion(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.setDefaultFashionFlag = false;
         }
         setDefaultFashion();
      }
      
      private function __todayNotAlertClose() : void
      {
         if(_fashionDefaultBtn)
         {
            _fashionDefaultBtn.selected = false;
         }
      }
      
      private function setDefaultFashion() : void
      {
         var _loc1_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         _loc1_.defaultFashion = _fashionDefaultBtn.selected ? 1 : 0;
         ArmyManager.instance.sendFashionChange(_loc1_);
      }
      
      private function __jobChangeBtnClickHandler(param1:MouseEvent) : void
      {
         if(checkScene())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("scene.switch.dragonTip"));
            return;
         }
         DragonTalkerManager.instance.sendDragonTalkerSwicthRequest();
      }
      
      private function checkScene() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         switch(_loc1_)
         {
            case "THESE_PVP_SCENE":
               return true;
            case "THESE_Double_PVP_SCENE":
               return true;
            default:
               return false;
         }
      }
      
      private function refreshJobChangeBtn() : void
      {
         if(dragonTalkerModel.isDragonTalker)
         {
            _jobChangeBtn.setFrame(4);
         }
         else
         {
            _jobChangeBtn.setFrame(thane.templateInfo.Job);
         }
         if(SceneManager.instance.currentType == "SECRET_ADVENTURE_SCENE")
         {
            _jobChangeBtn.visible = false;
         }
         else
         {
            _jobChangeBtn.visible = true;
         }
      }
      
      private function __fashionMsgHandler(param1:NotificationEvent = null) : void
      {
         updateFashionRefreshBtn();
         refreshFashionEquip();
         refreshHeroFigure();
      }
      
      private function __playerAvataChangeHandler(param1:PlayerEvent) : void
      {
         refreshHeroFigure();
      }
      
      private function __attributeClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new BagEvent("ATTRIBUTE_CLICK",null));
      }
      
      protected function __hideFashionHandler(param1:Event) : void
      {
         thane.beginChanges();
         thane.hideFashion = _hideBtn.selected;
         ArmySocketOutManager.sendHideFashion(_hideBtn.selected);
         refreshHeroFigure();
         thane.commit();
      }
      
      protected function __fashionComposeHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",10);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         GoodsManager.instance.filterFlag = false;
         GoodsManager.instance.filterGoodsInGeneralAndConsortiaBag();
         FrameControllerManager.instance.openControllerByInfo("fashion",0);
      }
      
      protected function __fashionRefreshHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",10);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         GoodsManager.instance.filterFlag = false;
         GoodsManager.instance.filterGoodsInGeneralAndConsortiaBag();
         FrameControllerManager.instance.openControllerByInfo("fashion",2);
      }
      
      protected function __fashionSwitchHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ArmyManager.instance.thane.grades < 10)
         {
            _loc2_ = LanguageMgr.GetTranslation("dayGuide.DayGuideManager.command02",10);
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(FashionManager.instance.fashionIdentityProgress <= 2)
         {
            SharedManager.instance.fashionIdentityProgress = 3;
         }
         if(_buttonMc2)
         {
            _buttonMc2.gotoAndStop(1);
         }
         if(_buttonMc1)
         {
            _buttonMc1.gotoAndStop(1);
         }
         GoodsManager.instance.filterFlag = false;
         GoodsManager.instance.filterGoodsInGeneralAndConsortiaBag();
         FrameControllerManager.instance.openControllerByInfo("fashion",1);
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      protected function __activedBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.activedBtnClickTip");
         MessageTipManager.instance().show(_loc2_);
      }
      
      protected function __panelHandler(param1:FashionEvent) : void
      {
         if(fashionModel.selectedPanel == "EQUIP_PANEL")
         {
            __equipHandler(null);
         }
         else if(fashionModel.selectedPanel == "FASHION_PANEL")
         {
            __fashionHandler(null);
         }
      }
      
      protected function __equipHandler(param1:MouseEvent) : void
      {
         _equip.visible = true;
         _fashion.visible = false;
         fashionModel.selectedPanel = "EQUIP_PANEL";
      }
      
      protected function __fashionHandler(param1:MouseEvent) : void
      {
         _equip.visible = false;
         _fashion.visible = true;
         if(_buttonMc1)
         {
            _buttonMc1.gotoAndStop(1);
         }
         if(_buttonMc2)
         {
            if(FashionManager.instance.fashionIdentityProgress <= 2)
            {
               _buttonMc2.play();
            }
            else
            {
               _buttonMc2.gotoAndStop(1);
            }
         }
         if(FashionManager.instance.fashionIdentityProgress <= 1)
         {
            SharedManager.instance.fashionIdentityProgress = 2;
         }
         fashionModel.selectedPanel = "FASHION_PANEL";
      }
      
      private function __UpvipInfoHandler(param1:VIPEvent) : void
      {
         if(!vipModel.vipInfo.IsVipAndNoExpirt)
         {
            _vipIconBtn.visible = false;
            _NovipIconBtn.visible = true;
         }
         else
         {
            _vipIconBtn.visible = true;
            _vipIconBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.vipIconTip",vipModel.vipInfo.VipGrade);
            _NovipIconBtn.visible = false;
         }
      }
      
      private function __openVipHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
      }
      
      private function __jewelClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.armyController.openJewelFrame();
      }
      
      private function __fateRotaryClickHandler(param1:MouseEvent) : void
      {
         PlayerManager.instance.currentPlayerModel.playerInfo.showVersion = false;
         if(_firstEffect)
         {
            _firstEffect.stop();
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("faterotary");
      }
      
      private function __conciseClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.armyController.openConciseFrame();
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:GoodsInfo = param1.info;
         var _loc2_:PlayerEquipCell = _equipViewList[_loc4_.pos + "_" + _loc4_.objectId + "_" + _loc4_.bagType];
         if(!_loc2_)
         {
            _loc2_ = _fashionViewList[_loc4_.pos + "_" + _loc4_.objectId + "_" + _loc4_.bagType];
         }
         if(!_loc2_)
         {
            _loc2_ = _honerViewList[_loc4_.pos + "_" + _loc4_.objectId + "_" + _loc4_.bagType];
         }
         if(_loc2_)
         {
            if(_loc4_.pos == 0)
            {
               _loc3_ = _loc2_.sonType == 101;
               if(_loc3_ && (!_loc2_.data || _loc2_.preTemp != _loc4_.id))
               {
                  NotificationManager.instance.sendNotification("WEAPON_CHANGE",null);
               }
            }
            _loc2_.data = _loc4_;
            refreshHeroFigure();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _equipViewList[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(!_loc2_)
         {
            _loc2_ = _fashionViewList[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         if(!_loc2_)
         {
            _loc2_ = _honerViewList[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         if(_loc2_)
         {
            _loc2_.data = null;
            refreshHeroFigure();
         }
      }
      
      private function compare(param1:FateRotarySkillInfo, param2:FateRotarySkillInfo) : Number
      {
         if(param1.templateId > param2.templateId)
         {
            return 1;
         }
         if(param1.templateId == param2.templateId)
         {
            return 0;
         }
         return -1;
      }
      
      protected function refreshView() : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         var _loc1_:MultipleDictionaryInfo = null;
         var _loc6_:String = null;
         var _loc9_:String = null;
         var _loc7_:MultipleDictionaryInfo = null;
         var _loc10_:String = null;
         var _loc13_:FateRotarySkillInfo = null;
         var _loc11_:Number = NaN;
         var _loc8_:* = undefined;
         var _loc4_:int = 0;
         var _loc12_:String = null;
         var _loc5_:String = null;
         if(thane.nickName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
         {
            _loc3_ = LanguageMgr.GetTranslation("public.nickName");
         }
         else
         {
            _loc3_ = thane.nickName;
         }
         _loc2_ = LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName");
         _loc2_ = thane.consortiaName ? LanguageMgr.GetTranslation("mounts.PropertyItem.tips02",_loc2_,thane.consortiaName) : "";
         _levelTxt.text = LanguageMgr.GetTranslation("public.level2",thane.grades);
         _nameTxt.text = _loc3_;
         _consortiaTxt.text = _loc2_;
         setLevelAndNamePos(thane);
         if(_simpleInfo == null)
         {
            setFightNumberView(thane.fightingCapacity);
         }
         else
         {
            setFightNumberView(_simpleInfo.fightingCapacity);
         }
         if(thane.grades < 32)
         {
            _magicCardBtn.enable = false;
            _loc1_ = new MultipleDictionaryInfo();
            _loc10_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.title");
            _loc6_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.Close",_loc10_);
            _loc1_.addItem(_loc6_,null);
            _loc10_ = LanguageMgr.GetTranslation("playerinfo.view.EquipInfoView.WillOpenAt",32);
            _loc9_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.Close",_loc10_);
            _loc1_.addItem(_loc9_,null);
            _strip3.tipData = _loc1_;
         }
         else
         {
            _magicCardBtn.enable = true;
            _loc1_ = new MultipleDictionaryInfo();
            _loc10_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.title");
            _loc6_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.Open.Title",_loc10_);
            _loc1_.addItem(_loc6_,null);
            _loc10_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.count1",MagicCardManager.Instance.cardModel.activedPer.toFixed(1));
            _loc9_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.Open.Content",_loc10_);
            _loc1_.addItem(_loc9_,null);
            _loc10_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.count3",MagicCardManager.Instance.cardModel.averageGrades.toFixed(2));
            _loc9_ = LanguageMgr.GetTranslation("army.Equip.CardBtnTip.Open.Content",_loc10_);
            _loc1_.addItem(_loc9_,null);
            _strip3.tipData = _loc1_;
         }
         if(thane.grades >= 35)
         {
            _strip1.tipData = null;
            _jewelSuitBtn.tipData = thane;
            _jewelJSuitLevel.text = thane.jewelGrades.toString();
            _jewelSuitBtn.enable = true;
            _seniorJewelSuitBtn.visible = false;
            _jewelSuitBtn.visible = true;
            if(thane.jewelGrades >= 80 && playerInfo.vocationGrades > 0)
            {
               _seniorJewelSuitBtn.visible = true;
               _jewelSuitBtn.visible = false;
               _seniorJewelSuitBtn.tipData = thane;
               _jewelJSuitLevel.text = thane.seniorStoreGrade.toString();
            }
         }
         if(thane.grades >= 55 && thane.fateRotarySkillList.length > 0)
         {
            _fateRotaryBtn.enable = true;
            _loc11_ = 0;
            _loc7_ = new MultipleDictionaryInfo();
            _loc8_ = thane.fateRotarySkillList;
            _loc8_.sort(compare);
            _loc4_ = 0;
            while(_loc4_ < _loc8_.length)
            {
               _loc13_ = _loc8_[_loc4_];
               if(_loc13_.template)
               {
                  _loc10_ = LanguageMgr.GetTranslation("public.grade") + "  " + _loc13_.grades;
                  _loc12_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.SkillTip","  " + _loc13_.template.TemplateName);
                  _loc5_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.SkillTip",_loc10_);
                  _loc7_.addItem(_loc12_ + "       " + _loc5_,null);
                  _loc11_ += _loc13_.totalGp;
               }
               _loc4_++;
            }
            _loc10_ = LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.FateTip1",_loc11_ * 10);
            _loc7_.addItemAt(_loc10_,null);
            _strip2.tipData = _loc7_;
         }
         else
         {
            _fateRotaryBtn.enable = false;
            _loc7_ = new MultipleDictionaryInfo();
            _loc10_ = "<font size=\'14\' color=\'ffffff\'>" + LanguageMgr.GetTranslation("faterotary.FateRotaryFrame.FrameTitle1") + "</font>";
            _loc7_.addItem(_loc10_,null);
            _loc10_ = "<font size=\'14\' color=\'ffffff\'>" + LanguageMgr.GetTranslation("playerinfo.view.EquipInfoView.WillOpenAt",55) + "</font>";
            _loc7_.addItem(_loc10_,null);
            _strip2.tipData = _loc7_;
         }
         if(VersionSwitch.EQUIP_CONCISE)
         {
            if(thane.vocationGrades > 0)
            {
               _strip4.tipData = null;
               _conciseBtn.tipData = thane;
               _conciseText.text = thane.conciseGrades.toString();
               _conciseBtn.enable = true;
            }
            else
            {
               _conciseBtn.enable = false;
            }
         }
         else
         {
            _strip4.visible = false;
            _conciseBtn.visible = false;
            _conciseText.visible = false;
         }
         refreshJobChangeBtn();
         refreshVocation();
         refreshHeroEquip();
         refreshFashionEquip();
      }
      
      private function setFightNumberView(param1:int = 0) : void
      {
         if(_fightValue == param1)
         {
            return;
         }
         _fightText.x = (305 - getNumWidth(param1)) / 2 + 10;
         _fightMc.x = _fightText.x + 70;
         if(!_playFightMc)
         {
            NumberViewUtils.getNumberView(param1,_fightMc["new_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
            _fightMc.gotoAndStop(24);
            _fightValue = param1;
            _playFightMc = true;
            return;
         }
         if(_fightValue > 0)
         {
            NumberViewUtils.getNumberView(_fightValue,_fightMc["old_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
         }
         NumberViewUtils.getNumberView(param1,_fightMc["new_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
         _fightMc.gotoAndPlay(1);
         _fightValue = param1;
      }
      
      private function getNumWidth(param1:int) : int
      {
         var _loc2_:String = null;
         _loc2_ = param1 + "";
         return _loc2_.length * 19;
      }
      
      private function setLevelAndNamePos(param1:ThaneInfo) : void
      {
         if(param1.consortiaName)
         {
            _levelTxt.y = 12;
            _nameTxt.y = 12;
         }
         else
         {
            _levelTxt.y = 9;
            _nameTxt.y = 9;
         }
      }
      
      private function refreshVocation() : void
      {
         if(playerInfo.vocationGrades > 0)
         {
            _vocationIcon.tipData = "<font color=\'#f6c503\' size=\'14\'>" + PlayerManager.instance.getVocationName(thane.templateInfo.Job,playerInfo.vocationStep,playerInfo.vocationLevel) + "</font>";
            if(thane.isHoly)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.holyTip");
            }
            else if(thane.isAvenger)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.avengerTip");
            }
            else if(thane.vocationIndex > 0)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.transferTip");
            }
            else
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.tip");
            }
            _vocationIcon.setFrame(playerInfo.vocationLevel);
            _vocationIcon.visible = true;
            _levelTxt.x = 34;
            _nameTxt.x = 75;
         }
         else
         {
            _vocationIcon.visible = false;
            _levelTxt.x = 9;
            _nameTxt.x = 50;
         }
      }
      
      public function synHideFashion() : void
      {
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("select",__hideFashionHandler);
            _hideBtn.selected = thane.hideFashion;
            refreshHeroFigure();
            _hideBtn.addEventListener("select",__hideFashionHandler);
         }
      }
      
      private function refreshHeroFigure() : void
      {
         var _loc2_:Dictionary = null;
         if(fashionModel.lookDragonTalkerFashion)
         {
            return;
         }
         if(playerInfo.vocationGrades > 0)
         {
            _figureBack.setFrame(5);
         }
         else
         {
            _figureBack.setFrame(2);
         }
         var _loc1_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc6_:ThaneInfo = new ThaneInfo();
         _loc6_.templateId = thane.templateId;
         _loc6_.hideFashion = thane.hideFashion;
         _loc2_ = ArmyManager.instance.fashionList;
         var _loc5_:GoodsInfo = _loc2_[8];
         var _loc3_:GoodsInfo = _loc2_[9];
         var _loc7_:GoodsInfo = _loc2_[10];
         var _loc4_:GoodsInfo = _loc2_[11];
         _loc6_.hairEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_headdress.data);
         _loc6_.bodyEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_clothes.data);
         _loc6_.armsEquipAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_weapon.data);
         if(_loc1_ && !_loc1_.isHidenWingAvata)
         {
            _loc6_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc5_);
         }
         if(_loc1_ && !_loc1_.isHidenArmAvata)
         {
            _loc6_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
         }
         if(_loc1_ && !_loc1_.isHidenClothAvata)
         {
            _loc6_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc7_);
         }
         if(_loc1_ && !_loc1_.isHidenHatAvat)
         {
            _loc6_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         }
         _figure.data = _loc6_;
      }
      
      private function refreshHeroEquip() : void
      {
         var _loc1_:PlayerEquipCell = null;
         _equipViewList.clear();
         var _loc3_:SimpleDictionary = GoodsManager.instance.getHeroGoodsListByTypeAndId(1,thane.id);
         for each(var _loc2_:PlayerEquipCell in _equipList)
         {
            _loc2_.data = null;
            _loc2_.bagType = 4;
            _loc2_.objectId = thane.id;
            _equipViewList.add(_loc2_.pos + "_" + thane.id + "_" + _loc2_.bagType,_loc2_);
         }
         for each(var _loc4_:GoodsInfo in _loc3_)
         {
            _loc1_ = getItemViewByPos(_loc4_.pos,_loc4_.bagType);
            if(_loc1_)
            {
               _loc1_.data = _loc4_;
            }
         }
         _honerViewList.clear();
         _honor1.data = null;
         _honor1.bagType = 3;
         _honor1.objectId = thane.id;
         _honerViewList.add(_honor1.pos + "_" + thane.id + "_" + _honor1.bagType,_honor1);
         _loc3_ = GoodsManager.instance.getHeroHonerEquip(thane.id);
         for each(_loc4_ in _loc3_)
         {
            getItemViewByPos(_loc4_.pos,3).data = _loc4_;
            if(serverTime - _loc4_.beginDate.getTime() >= _loc4_.validDate * 60 * 1000)
            {
               SocketSendManager.instance.sendDeleteGoods(_loc4_.bagType,_loc4_.pos);
            }
         }
      }
      
      private function refreshFashionEquip() : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:SimpleDictionary = null;
         var _loc2_:PlayerEquipCell = null;
         var _loc4_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         _fashionDefaultBtn.selected = _loc4_.defaultFashion == 1 ? true : false;
         _fashionLvlTxt.text = _loc4_.grades.toString();
         _fashionLvlStrip.tipData = _loc4_.grades;
         var _loc7_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc4_.grades + 1,113);
         if(!_loc7_)
         {
            _fashionProgressTxt.text = "max";
            _loc5_ = 100;
         }
         else
         {
            _loc8_ = int(_loc4_.gp);
            _loc6_ = int(_loc7_.Data);
            _fashionProgressTxt.text = _loc8_ + "/" + _loc6_;
            _loc5_ = _loc8_ / _loc6_ * 100;
         }
         _fashionProgressBar.gotoAndStop(_loc5_);
         _fashionViewList.clear();
         for each(var _loc1_:PlayerEquipCell in _fashionList)
         {
            _loc1_.data = null;
            _loc1_.bagType = 4;
            _loc1_.objectId = thane.id;
            _fashionViewList.add(_loc1_.pos + "_" + thane.id + "_" + _loc1_.bagType,_loc1_);
         }
         for each(var _loc3_:FashionTick in _fashionTickList)
         {
            _loc3_.visible = false;
         }
         _loc9_ = ArmyManager.instance.fashionList;
         for each(var _loc10_:GoodsInfo in _loc9_)
         {
            _loc2_ = getItemViewByPos(_loc10_.pos,_loc10_.bagType);
            if(_loc2_)
            {
               _loc2_.data = _loc10_;
            }
            switch(int(_loc10_.pos) - 8)
            {
               case 0:
                  _tickFashion4.visible = true;
                  _tickFashion4.data = _loc4_.isHidenWingAvata;
                  _tickFashion4.id = _loc10_.templateId;
                  break;
               case 1:
                  _tickFashion1.visible = true;
                  _tickFashion1.data = _loc4_.isHidenHatAvat;
                  _tickFashion1.id = _loc10_.templateId;
                  break;
               case 2:
                  _tickFashion2.visible = true;
                  _tickFashion2.data = _loc4_.isHidenClothAvata;
                  _tickFashion2.id = _loc10_.templateId;
                  break;
               case 3:
                  _tickFashion3.visible = true;
                  _tickFashion3.data = _loc4_.isHidenArmAvata;
                  _tickFashion3.id = _loc10_.templateId;
            }
         }
      }
      
      private function __fashionChangeHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         for each(var _loc3_:FashionTick in _fashionTickList)
         {
            switch(_loc3_.pos - 8)
            {
               case 0:
                  _loc2_.wingAvata = _tickFashion4.id;
                  _loc2_.isHidenWingAvata = _tickFashion4.data;
                  break;
               case 1:
                  _loc2_.hatAvata = _tickFashion1.id;
                  _loc2_.isHidenHatAvat = _tickFashion1.data;
                  break;
               case 2:
                  _loc2_.clothAvata = _tickFashion2.id;
                  _loc2_.isHidenClothAvata = _tickFashion2.data;
                  break;
               case 3:
                  _loc2_.armAvata = _tickFashion3.id;
                  _loc2_.isHidenArmAvata = _tickFashion3.data;
            }
         }
         ArmyManager.instance.sendFashionChange(_loc2_);
      }
      
      public function getItemViewByPos(param1:int, param2:int = 4) : PlayerEquipCell
      {
         if(!thane)
         {
            return null;
         }
         var _loc3_:PlayerEquipCell = _equipViewList[param1 + "_" + thane.id + "_" + param2];
         if(!_loc3_)
         {
            _loc3_ = _fashionViewList[param1 + "_" + thane.id + "_" + param2];
         }
         if(!_loc3_)
         {
            _loc3_ = _honerViewList[param1 + "_" + thane.id + "_" + param2];
         }
         return _loc3_;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get cardModel() : MagicCardModel
      {
         return MagicCardManager.Instance.cardModel;
      }
      
      private function get uArmy() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      public function get weapon() : PlayerEquipCell
      {
         return _weapon;
      }
      
      public function get wing() : PlayerEquipCell
      {
         return _wing;
      }
      
      private function get serverTime() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      public function get magicCardBtn() : BaseButton
      {
         return _magicCardBtn;
      }
      
      private function get dragonTalkerModel() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_firstEffect)
         {
            PlayerManager.instance.currentPlayerModel.playerInfo.showVersion = false;
            _firstEffect.stop();
            _firstEffect.dispose();
            _firstEffect = null;
         }
         ObjectUtils.disposeAllChildren(_fateRotaryBtn);
         _fateRotaryBtn = null;
         ObjectUtils.disposeAllChildren(_magicCardBtn);
         _magicCardBtn = null;
         ObjectUtils.disposeAllChildren(_fashion);
         _fashion = null;
         ObjectUtils.disposeAllChildren(_equip);
         _equip = null;
         ObjectUtils.disposeObject(_honor1);
         _honor1 = null;
         ObjectUtils.disposeObject(_wing);
         _wing = null;
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_figureBack);
         _figureBack = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_equipGirdBack);
         _equipGirdBack = null;
         ObjectUtils.disposeObject(_weapon);
         _weapon = null;
         ObjectUtils.disposeObject(_weaponFashion);
         _weaponFashion = null;
         ObjectUtils.disposeObject(_headdress);
         _headdress = null;
         ObjectUtils.disposeObject(_headdressFshion);
         _headdressFshion = null;
         ObjectUtils.disposeObject(_clothes);
         _clothes = null;
         ObjectUtils.disposeObject(_clothesFashion);
         _clothesFashion = null;
         ObjectUtils.disposeObject(_necklace);
         _necklace = null;
         ObjectUtils.disposeObject(_ring1);
         _ring1 = null;
         ObjectUtils.disposeObject(_ring2);
         _ring2 = null;
         ObjectUtils.disposeObject(_trinket1);
         _trinket1 = null;
         ObjectUtils.disposeObject(_trinket2);
         _trinket2 = null;
         ObjectUtils.disposeObject(_relic);
         _relic = null;
         ObjectUtils.disposeObject(_heraldry);
         _heraldry = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_consortiaTxt);
         _consortiaTxt = null;
         ObjectUtils.disposeObject(_strip1);
         _strip1 = null;
         ObjectUtils.disposeObject(_strip2);
         _strip2 = null;
         ObjectUtils.disposeObject(_strip3);
         _strip3 = null;
         ObjectUtils.disposeObject(_strip4);
         _strip4 = null;
         ObjectUtils.disposeObject(_jewelSuitBtn);
         _jewelSuitBtn = null;
         ObjectUtils.disposeObject(_seniorJewelSuitBtn);
         _seniorJewelSuitBtn = null;
         ObjectUtils.disposeObject(_jewelJSuitLevel);
         _jewelJSuitLevel = null;
         ObjectUtils.disposeObject(_conciseBtn);
         _conciseBtn = null;
         ObjectUtils.disposeObject(_conciseText);
         _conciseText = null;
         ObjectUtils.disposeObject(_starSuitBtn);
         _starSuitBtn = null;
         ObjectUtils.disposeObject(_starSuitLevel);
         _starSuitLevel = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_vipIconBtn);
         _vipIconBtn = null;
         ObjectUtils.disposeObject(_NovipIconBtn);
         _NovipIconBtn = null;
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         ObjectUtils.disposeObject(_hideTxt);
         _hideTxt = null;
         ObjectUtils.disposeObject(_hGap);
         _hGap = null;
         ObjectUtils.disposeObject(_fightBg);
         _fightBg = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeViolentMc(_fightMc);
         _fightMc = null;
         ObjectUtils.disposeObject(_fightBmp);
         _fightBmp = null;
         ObjectUtils.disposeObject(_fashionDefaultBtn);
         _fashionDefaultBtn = null;
         ObjectUtils.disposeObject(_fashionDefaultText);
         _fashionDefaultText = null;
         ObjectUtils.disposeObject(_fashionBtn);
         _fashionBtn = null;
         ObjectUtils.disposeObject(_equipBtn);
         _equipBtn = null;
         ObjectUtils.disposeObject(_fashionPanel);
         _fashionPanel = null;
         ObjectUtils.disposeObject(_fashionComposeBtn);
         _fashionComposeBtn = null;
         ObjectUtils.disposeObject(_fashionRefreshBtn);
         _fashionRefreshBtn = null;
         ObjectUtils.disposeObject(_fashionSwitchBtn);
         _fashionSwitchBtn = null;
         ObjectUtils.disposeObject(_attributeButton);
         _attributeButton = null;
         ObjectUtils.disposeObject(_switchTip);
         _switchTip = null;
         ObjectUtils.disposeObject(_buttonMc1);
         _buttonMc1 = null;
         ObjectUtils.disposeObject(_buttonMc2);
         _buttonMc2 = null;
         ObjectUtils.disposeObject(_buttonMc3);
         _buttonMc3 = null;
         ObjectUtils.disposeObject(_marryRing);
         _marryRing = null;
         _equipViewList = null;
         _fashionViewList = null;
         _equipList = null;
         _fashionList = null;
         _honerViewList = null;
         _simpleInfo = null;
         if(_magicCardBtnEffect)
         {
            _magicCardBtnEffect.stop();
            _magicCardBtnEffect = null;
         }
      }
   }
}

