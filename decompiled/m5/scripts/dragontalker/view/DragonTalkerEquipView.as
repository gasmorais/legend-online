package dragontalker.view
{
   import armyII.viewII.equip.FashionTick;
   import avatar.view.ShowAvatar;
   import bag.events.BagEvent;
   import cell.view.playerequip.HonorCell;
   import cell.view.playerequip.PlayerEquipCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import dragontalker.cell.DragonTalkerTalismanEquipCell;
   import events.FashionEvent;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import managers.FashionManager;
   import managers.VIPManager;
   import marry.view.MarryRingView;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.fashion.FashionModel;
   import mvc.module.vip.VIPModel;
   import utils.LogicUtils;
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
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.ThaneEquipShowHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerEquipView extends Component
   {
      
      private static const TALISMAN_COUNT:int = 6;
      
      private static var talismanPostions:Array = [[49,67],[23,135],[49,208],[255,67],[285,135],[255,208]];
      
      private var _figureBack:Image;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _consortiaText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _lvlText:FilterFrameText;
      
      private var _talismanContiner:Component;
      
      private var _figure:ShowAvatar;
      
      private var _equipGirdBack:MovieClip;
      
      private var _fightBg:MovieClip;
      
      private var _fightText:Bitmap;
      
      private var _relic:PlayerEquipCell;
      
      private var _heraldry:PlayerEquipCell;
      
      private var _honor:HonorCell;
      
      private var _marryRing:MarryRingView;
      
      private var _vipIconBtn:BaseButton;
      
      private var _novipIconBtn:BaseButton;
      
      private var _fightBmp:Bitmap;
      
      private var _fightMc:MovieClip;
      
      private var _attributeButton:BaseButton;
      
      private var _jobChangeBtn:ScaleFrameImage;
      
      private var _preFightValue:int;
      
      private var _simpleInfo:SimplePlayerInfo;
      
      private var _honerViewDic:SimpleDictionary;
      
      private var _equipViewDic:SimpleDictionary;
      
      private var _equipList:Vector.<PlayerEquipCell>;
      
      private var _buttonMc1:MovieClip;
      
      private var _fashionBtn:IconButton;
      
      private var _returnBtn:IconButton;
      
      private var _talismanList:Vector.<DragonTalkerTalismanEquipCell>;
      
      private var _equipSprite:Sprite;
      
      private var _fashionSprite:Sprite;
      
      private var _fashionGirdBack:MovieClip;
      
      private var _fashionPanel:Image;
      
      private var _fashionComposeBtn:BaseButton;
      
      private var _fashionSwitchBtn:BaseButton;
      
      private var _fashionRefreshBtn:BaseButton;
      
      private var _switchTip:TextButton;
      
      private var _fashionIdentityTip:BaseButton;
      
      private var _fashionProgressBar:MovieClip;
      
      private var _fashionProgressTxt:FilterFrameText;
      
      private var _fashionLvlBmp:Bitmap;
      
      private var _fashionLvlTxt:FilterFrameText;
      
      private var _fashionLvlStrip:StripView;
      
      private var _fashionList:Vector.<PlayerEquipCell>;
      
      private var _fashionTickList:Vector.<FashionTick>;
      
      private var _fashionDefaultBtn:SelectedButton;
      
      private var _fashionDefaultText:FilterFrameText;
      
      private var _headdressFshion:PlayerEquipCell;
      
      private var _clothesFashion:PlayerEquipCell;
      
      private var _wing:PlayerEquipCell;
      
      private var _weaponFashion:PlayerEquipCell;
      
      private var _tickFashion1:FashionTick;
      
      private var _tickFashion2:FashionTick;
      
      private var _tickFashion3:FashionTick;
      
      private var _tickFashion4:FashionTick;
      
      private var _fashionViewList:SimpleDictionary;
      
      private var _playFightMc:Boolean = false;
      
      public function DragonTalkerEquipView()
      {
         super();
         initView();
         initTalismanView();
         initOtherEquipView();
         createHeroFashion();
         addEvent();
         refreshView();
         refreshHeroFigure();
         __upvipInfoHandler(null);
         FashionManager.instance.getFashionBook();
      }
      
      private function initView() : void
      {
         this.mouseEnabled = false;
         _figureBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipView.figureBack");
         _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("army.VocationIcon");
         _lvlText = ComponentFactory.Instance.creatComponentByStylename("army.ThaneLevelTxt");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("army.ThaneNameTxt");
         _consortiaText = ComponentFactory.Instance.creatComponentByStylename("army.ThaneConsortiaTxt");
         _talismanContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipView.talismanContiner");
         _vipIconBtn = ComponentFactory.Instance.creatComponentByStylename("core.vip.vipIconBtn");
         _novipIconBtn = ComponentFactory.Instance.creatComponentByStylename("core.vip.NovipIconBtn");
         _equipGirdBack = ComponentFactory.Instance.creatCustomObject("DragonTalkerEquipView.EquipGird");
         _fightBg = ComponentFactory.Instance.creatCustomObject("army.FightBg");
         _fightText = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fightTxt");
         _fightBmp = ComponentFactory.Instance.creatBitmap("asset.playerinfo.fightNum");
         _fightMc = ComponentFactory.Instance.creat("asset.core.powerMc");
         _attributeButton = ComponentFactory.Instance.creatComponentByStylename("army.AttributeButton");
         _jobChangeBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerEquipView.JobChangeBtn");
         _fashionBtn = ComponentFactory.Instance.creatComponentByStylename("dragonTalkerEquipView.fashionBtn");
         _fashionDefaultBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionDefaultBtn");
         _fashionDefaultText = ComponentFactory.Instance.creatComponentByStylename("army.fashionDefaultText");
         _fashionDefaultText.text = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.fashionDefaultText");
         _figure = new ShowAvatar(true,null,false,true);
         _figure.x = 60;
         _figure.y = 40;
         _equipSprite = new Sprite();
         _fashionSprite = new Sprite();
         _figure.mouseChildren = _figure.mouseEnabled = false;
         addChild(_figureBack);
         addChild(_figure);
         addChild(_equipSprite);
         addChild(_fashionSprite);
         _equipSprite.addChild(_vocationIcon);
         _equipSprite.addChild(_lvlText);
         _equipSprite.addChild(_nameText);
         _equipSprite.addChild(_consortiaText);
         _equipSprite.addChild(_vipIconBtn);
         _vipIconBtn.x = 319;
         _vipIconBtn.y = 28;
         _equipSprite.addChild(_novipIconBtn);
         _novipIconBtn.x = 319;
         _novipIconBtn.y = 28;
         _equipSprite.addChild(_talismanContiner);
         _equipSprite.addChild(_equipGirdBack);
         _equipSprite.addChild(_fightBg);
         _equipSprite.addChild(_fightText);
         _equipSprite.addChild(_fightMc);
         _fightMc.x = 158;
         _fightMc.y = 376;
         _equipSprite.addChild(_attributeButton);
         _equipSprite.addChild(_jobChangeBtn);
         if(VersionSwitch.DRAGONIC_FASHION)
         {
            _equipSprite.addChild(_fashionBtn);
         }
         this.mouseEnabled = false;
         _vocationIcon.visible = false;
         _figureBack.setFrame(2);
         _jobChangeBtn.buttonMode = true;
         _jobChangeBtn.setFrame(1);
         _jobChangeBtn.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.JobChangeBtnClickTips");
         _novipIconBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.NovipIconTip");
         _fashionGirdBack = ComponentFactory.Instance.creatCustomObject("army.FashionGird");
         _fashionPanel = ComponentFactory.Instance.creatComponentByStylename("army.fashionPanel");
         _returnBtn = ComponentFactory.Instance.creatComponentByStylename("dragonTalkerEquipView.returnBtn");
         _fashionIdentityTip = ComponentFactory.Instance.creatComponentByStylename("army.fashionIdentityTip");
         _fashionIdentityTip.tipData = LanguageMgr.GetTranslation("fashion.tip.total",0,0,0,0);
         _fashionProgressBar = ComponentFactory.Instance.creatCustomObject("playerinfo.ProgressBar");
         _fashionProgressTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.ProgressLevelTxt");
         _fashionLvlBmp = ComponentFactory.Instance.creatBitmap("asset.playerinfo.lvlBmp");
         _fashionLvlTxt = ComponentFactory.Instance.creatComponentByStylename("playerinfo.fashionLevelTxt");
         _fashionLvlStrip = ComponentFactory.Instance.creatCustomObject("playerinfo.fashionProgressStrip");
         _fashionComposeBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionComposeBtn");
         _fashionSwitchBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionSwitchBtn");
         _fashionRefreshBtn = ComponentFactory.Instance.creatComponentByStylename("army.fashionRefreshBtn");
         _switchTip = ComponentFactory.Instance.creatComponentByStylename("army.fashionSwitcTip");
         _fashionLvlStrip.setHitArea(0,0,208,24);
         _fashionSprite.addChild(_fashionGirdBack);
         _fashionSprite.addChild(_fashionPanel);
         if(VersionSwitch.DRAGONIC_FASHION)
         {
            _fashionSprite.addChild(_returnBtn);
         }
         _fashionSprite.addChild(_fashionIdentityTip);
         _fashionSprite.addChild(_fashionProgressBar);
         _fashionSprite.addChild(_fashionProgressTxt);
         _fashionSprite.addChild(_fashionLvlBmp);
         _fashionSprite.addChild(_fashionLvlTxt);
         _fashionSprite.addChild(_fashionLvlStrip);
         _fashionSprite.addChild(_fashionComposeBtn);
         _fashionSprite.addChild(_fashionDefaultBtn);
         _fashionSprite.addChild(_fashionDefaultText);
         _fashionSprite.addChild(_fashionSwitchBtn);
         _fashionSprite.addChild(_fashionRefreshBtn);
         _fashionSprite.addChild(_switchTip);
         _fashionRefreshBtn.supportTipsWhenGray = true;
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
         updateFashionRefreshBtn();
         _fashionSprite.visible = false;
         _equipSprite.visible = true;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
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
      
      private function initTalismanView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerTalismanEquipCell = null;
         _talismanList = new Vector.<DragonTalkerTalismanEquipCell>();
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerEquipView.equipCell",[_loc2_]);
            _talismanContiner.addChild(_loc1_);
            _loc1_.x = talismanPostions[_loc2_][0];
            _loc1_.y = talismanPostions[_loc2_][1];
            _talismanList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initOtherEquipView() : void
      {
         _honerViewDic = new SimpleDictionary(true);
         _equipViewDic = new SimpleDictionary(true);
         _equipList = new Vector.<PlayerEquipCell>();
         _relic = ComponentFactory.Instance.creatCustomObject("playerinfo.HerorelicCell");
         _heraldry = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroheraldryCell");
         _honor = ComponentFactory.Instance.creatCustomObject("playerinfo.HonorCell1");
         _marryRing = new MarryRingView();
         _marryRing.x = VersionSwitch.GOD_HALIDOM ? 180 : 70;
         _marryRing.y = 295;
         _relic.sonType = 118;
         _heraldry.sonType = 117;
         _relic.acceptDrop = true;
         _heraldry.acceptDrop = true;
         _honor.acceptDrop = true;
         if(!VersionSwitch.GOD_HALIDOM)
         {
            _honor.x = 15;
         }
         if(VersionSwitch.GOD_HALIDOM)
         {
            _equipSprite.addChild(_relic);
            _equipSprite.addChild(_heraldry);
            _equipList.push(_relic);
            _equipList.push(_heraldry);
         }
         _equipSprite.addChild(_honor);
         _equipSprite.addChild(_marryRing);
      }
      
      private function createHeroFashion() : void
      {
         _fashionList = new Vector.<PlayerEquipCell>();
         _fashionTickList = new Vector.<FashionTick>();
         _fashionViewList = new SimpleDictionary(true);
         _headdressFshion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroHeaddressFashionCell");
         _headdressFshion.sonType = 110;
         _clothesFashion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroClothesFashionCell");
         _clothesFashion.sonType = 112;
         _weaponFashion = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWeaponFashionCell");
         _weaponFashion.sonType = 111;
         _wing = ComponentFactory.Instance.creatCustomObject("playerinfo.HeroWingCell");
         _wing.sonType = 109;
         _fashionList.push(_headdressFshion);
         _fashionList.push(_clothesFashion);
         _fashionList.push(_weaponFashion);
         _fashionList.push(_wing);
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
         for each(var _loc1_:PlayerEquipCell in _fashionList)
         {
            _loc1_.acceptDrop = true;
            _fashionSprite.addChild(_loc1_);
         }
         for each(var _loc2_:FashionTick in _fashionTickList)
         {
            _fashionSprite.addChild(_loc2_);
         }
      }
      
      private function addEvent() : void
      {
         vipModel.addEventListener("upframeview_change",__upvipInfoHandler);
         _vipIconBtn.addEventListener("click",__openVipHandler);
         _novipIconBtn.addEventListener("click",__openVipHandler);
         if(_attributeButton)
         {
            _attributeButton.addEventListener("click",__attributeClickHandler);
         }
         thane.addEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         thane.addEventListener("PLAYER_AVATA_CHANGE",__playerAvataChangeHandler);
         _jobChangeBtn.addEventListener("click",__jobChangeBtnClickHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateDragonTalkerState);
         MsgMan.addObserver("DRAGON_TALKER_TALISMAN_UPDATE",this,__updateDragonTalkerEquipHandler);
         MsgMan.addObserver("SWITCH_EQUIPVIEW",this,__switchHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         if(_returnBtn)
         {
            _returnBtn.addEventListener("click",__returnBtnHandler);
         }
         if(_fashionBtn)
         {
            _fashionBtn.addEventListener("click",__fashionBtnHandler);
         }
         if(_fashionIdentityTip)
         {
            _fashionIdentityTip.addEventListener("click",__fashionSwitchHandler);
         }
         NotificationManager.instance.addEventListener("FASHION_SHOW_CHANGE",__fashionMsgHandler);
         NotificationManager.instance.addEventListener("FASHION_CHANGE",__fashionChangeHandler);
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
         FashionManager.instance.addEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         if(_fashionDefaultBtn)
         {
            _fashionDefaultBtn.addEventListener("click",__fashionDefaultBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         vipModel.removeEventListener("upframeview_change",__upvipInfoHandler);
         _vipIconBtn.removeEventListener("click",__openVipHandler);
         _novipIconBtn.removeEventListener("click",__openVipHandler);
         if(_attributeButton)
         {
            _attributeButton.removeEventListener("click",__attributeClickHandler);
         }
         thane.removeEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         playerInfo.removeEventListener("PLAYER_INFO_UPDATE",__thaneInfoChangeHandler);
         thane.removeEventListener("PLAYER_AVATA_CHANGE",__playerAvataChangeHandler);
         if(_jobChangeBtn)
         {
            _jobChangeBtn.removeEventListener("click",__jobChangeBtnClickHandler);
         }
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateDragonTalkerState);
         MsgMan.removeObserver("DRAGON_TALKER_TALISMAN_UPDATE",this,__updateDragonTalkerEquipHandler);
         MsgMan.removeObserver("SWITCH_EQUIPVIEW",this,__switchHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         if(_returnBtn)
         {
            _returnBtn.removeEventListener("click",__returnBtnHandler);
         }
         if(_fashionBtn)
         {
            _fashionBtn.removeEventListener("click",__fashionBtnHandler);
         }
         if(_fashionIdentityTip)
         {
            _fashionIdentityTip.removeEventListener("click",__fashionSwitchHandler);
         }
         NotificationManager.instance.removeEventListener("FASHION_SHOW_CHANGE",__fashionMsgHandler);
         NotificationManager.instance.removeEventListener("FASHION_CHANGE",__fashionChangeHandler);
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
         FashionManager.instance.removeEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
         if(_fashionDefaultBtn)
         {
            _fashionDefaultBtn.removeEventListener("click",__fashionDefaultBtnHandler);
         }
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
         _loc1_.defaultFashion = _fashionDefaultBtn.selected ? 2 : 0;
         ArmyManager.instance.sendFashionChange(_loc1_);
      }
      
      private function __updateDragonTalkerEquipHandler(param1:String, param2:Object) : void
      {
         refreshTalismanView();
      }
      
      private function __switchHandler(param1:String, param2:Object) : void
      {
         _fashionSprite.visible = false;
         _equipSprite.visible = true;
      }
      
      private function __attributeClickHandler(param1:MouseEvent) : void
      {
         MsgMan.notifyObserver("ATTRIBUTE_CLICK");
      }
      
      private function __openVipHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
      }
      
      private function __jobChangeBtnClickHandler(param1:MouseEvent) : void
      {
         DragonTalkerManager.instance.sendDragonTalkerSwicthRequest();
      }
      
      private function refreshJobChangeBtn() : void
      {
         if(model.isDragonTalker)
         {
            _jobChangeBtn.setFrame(4);
         }
         else
         {
            _jobChangeBtn.setFrame(thane.templateInfo.Job);
         }
      }
      
      private function __thaneInfoChangeHandler(param1:PlayerEvent) : void
      {
         _simpleInfo = param1.currentTarget as SimplePlayerInfo;
         refreshView();
      }
      
      private function __playerAvataChangeHandler(param1:PlayerEvent) : void
      {
         refreshHeroFigure();
      }
      
      private function __upvipInfoHandler(param1:VIPEvent) : void
      {
         if(!vipModel.vipInfo.IsVipAndNoExpirt)
         {
            _vipIconBtn.visible = false;
            _novipIconBtn.visible = true;
         }
         else
         {
            _vipIconBtn.visible = true;
            _vipIconBtn.tipData = LanguageMgr.GetTranslation("armyII.viewII.equip.EquipView.vipIconTip",vipModel.vipInfo.VipGrade);
            _novipIconBtn.visible = false;
         }
      }
      
      private function __returnBtnHandler(param1:MouseEvent) : void
      {
         _fashionSprite.visible = false;
         _equipSprite.visible = true;
      }
      
      private function __fashionBtnHandler(param1:MouseEvent) : void
      {
         _fashionSprite.visible = true;
         _equipSprite.visible = false;
      }
      
      private function __fashionMsgHandler(param1:NotificationEvent = null) : void
      {
         updateFashionRefreshBtn();
         refreshFashionEquip();
         refreshHeroFigure();
      }
      
      private function refreshFashionEquip() : void
      {
         var _loc5_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:SimpleDictionary = null;
         var _loc2_:PlayerEquipCell = null;
         var _loc4_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         _fashionDefaultBtn.selected = _loc4_.defaultFashion == 2 ? true : false;
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
         _loc9_ = ArmyManager.instance.dragonFashionList;
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
                  _tickFashion4.data = _loc4_.isHidendDragonWingAvata;
                  _tickFashion4.id = _loc10_.templateId;
                  break;
               case 1:
                  _tickFashion1.visible = true;
                  _tickFashion1.data = _loc4_.isHidenDragonHatAvat;
                  _tickFashion1.id = _loc10_.templateId;
                  break;
               case 2:
                  _tickFashion2.visible = true;
                  _tickFashion2.data = _loc4_.isHidenDragonClothAvata;
                  _tickFashion2.id = _loc10_.templateId;
                  break;
               case 3:
                  _tickFashion3.visible = true;
                  _tickFashion3.data = _loc4_.isHidenDragonArmAvata;
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
                  _loc2_.dragonWingAvata = _tickFashion4.id;
                  _loc2_.isHidendDragonWingAvata = _tickFashion4.data;
                  break;
               case 1:
                  _loc2_.dragonHatAvata = _tickFashion1.id;
                  _loc2_.isHidenDragonHatAvat = _tickFashion1.data;
                  break;
               case 2:
                  _loc2_.dragonClothAvata = _tickFashion2.id;
                  _loc2_.isHidenDragonClothAvata = _tickFashion2.data;
                  break;
               case 3:
                  _loc2_.dragonArmAvata = _tickFashion3.id;
                  _loc2_.isHidenDragonArmAvata = _tickFashion3.data;
            }
         }
         ArmyManager.instance.sendFashionChange(_loc2_);
      }
      
      private function __fashionComposeHandler(param1:MouseEvent) : void
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
         FrameControllerManager.instance.openControllerByInfo("fashion",0,true);
      }
      
      private function __fashionRefreshHandler(param1:MouseEvent) : void
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
         FrameControllerManager.instance.openControllerByInfo("fashion",2,true);
      }
      
      private function __fashionSwitchHandler(param1:MouseEvent) : void
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
         FrameControllerManager.instance.openControllerByInfo("fashion",1,true);
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
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:PlayerEquipCell = _equipViewDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(!_loc2_)
         {
            _loc2_ = _fashionViewList[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         if(!_loc2_)
         {
            _loc2_ = _honerViewDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         if(_loc2_)
         {
            _loc2_.data = _loc3_;
         }
         refreshHeroFigure();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _equipViewDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(!_loc2_)
         {
            _loc2_ = _fashionViewList[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         if(!_loc2_)
         {
            _loc2_ = _honerViewDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         }
         if(_loc2_)
         {
            _loc2_.data = null;
         }
         refreshHeroFigure();
      }
      
      protected function refreshView() : void
      {
         var _loc2_:String = null;
         var _loc1_:String = null;
         if(thane.nickName == PlayerManager.instance.currentPlayerModel.userInfo.userId + "$")
         {
            _loc2_ = LanguageMgr.GetTranslation("public.nickName");
         }
         else
         {
            _loc2_ = thane.nickName;
         }
         _loc1_ = LanguageMgr.GetTranslation("sort.view.MemberTitleView.ConsortiaName");
         _loc1_ = thane.consortiaName ? LanguageMgr.GetTranslation("mounts.PropertyItem.tips02",_loc1_,thane.consortiaName) : "";
         _lvlText.text = LanguageMgr.GetTranslation("public.level2",thane.grades);
         _nameText.text = _loc2_;
         _consortiaText.text = _loc1_;
         setLevelAndNamePos(thane);
         if(_simpleInfo == null)
         {
            setFightNumberView(thane.fightingCapacity);
         }
         else
         {
            setFightNumberView(_simpleInfo.fightingCapacity);
         }
         refreshVocation();
         refreshJobChangeBtn();
         refreshTalismanView();
         refreshOtherEquipView();
         refreshFashionEquip();
      }
      
      private function setFightNumberView(param1:int = 0) : void
      {
         if(_preFightValue == param1)
         {
            return;
         }
         _fightText.x = (296 - getNumWidth(param1)) / 2 + 15;
         _fightMc.x = _fightText.x + 80;
         if(!_playFightMc)
         {
            NumberViewUtils.getNumberView(param1,_fightMc["new_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
            _fightMc.gotoAndStop(24);
            _preFightValue = param1;
            _playFightMc = true;
            return;
         }
         if(_preFightValue > 0)
         {
            NumberViewUtils.getNumberView(_preFightValue,_fightMc["old_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
         }
         NumberViewUtils.getNumberView(param1,_fightMc["new_power"],_fightBmp.bitmapData,26,25,19,26,"0123456789",2);
         _fightMc.gotoAndPlay(1);
         _preFightValue = param1;
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
            _lvlText.y = 12;
            _nameText.y = 12;
         }
         else
         {
            _lvlText.y = 9;
            _nameText.y = 9;
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
            _lvlText.x = 34;
            _nameText.x = 75;
         }
         else
         {
            _vocationIcon.visible = false;
            _lvlText.x = 9;
            _nameText.x = 50;
         }
      }
      
      private function refreshOtherEquipView() : void
      {
         var _loc3_:* = null;
         var _loc1_:PlayerEquipCell = null;
         var _loc4_:SimpleDictionary = GoodsManager.instance.getHeroGoodsListByTypeAndId(1,thane.id);
         for each(var _loc2_:PlayerEquipCell in _equipList)
         {
            _loc2_.data = null;
            _loc2_.bagType = 4;
            _loc2_.objectId = thane.id;
            _equipViewDic.add(_loc2_.pos + "_" + thane.id + "_" + _loc2_.bagType,_loc2_);
         }
         for each(_loc3_ in _loc4_)
         {
            _loc1_ = getItemViewByPos(_loc3_.pos,_loc3_.bagType);
            if(_loc1_)
            {
               _loc1_.data = _loc3_;
            }
         }
         _honerViewDic.clear();
         _honor.data = null;
         _honor.bagType = 3;
         _honor.objectId = thane.id;
         _honerViewDic.add(_honor.pos + "_" + thane.id + "_" + _honor.bagType,_honor);
         _loc4_ = GoodsManager.instance.getHeroHonerEquip(thane.id);
         for each(_loc3_ in _loc4_)
         {
            getItemViewByPos(_loc3_.pos,3).data = _loc3_;
            if(serverTime - _loc3_.beginDate.getTime() >= _loc3_.validDate * 60 * 1000)
            {
               SocketSendManager.instance.sendDeleteGoods(_loc3_.bagType,_loc3_.pos);
            }
         }
      }
      
      private function refreshHeroFigure() : void
      {
         var _loc7_:ThaneInfo = new ThaneInfo();
         var _loc5_:Boolean = true;
         var _loc2_:Dictionary = ArmyManager.instance.dragonFashionList;
         var _loc1_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc6_:GoodsInfo = _loc2_[8];
         var _loc3_:GoodsInfo = _loc2_[9];
         var _loc8_:GoodsInfo = _loc2_[10];
         var _loc4_:GoodsInfo = _loc2_[11];
         _loc7_.templateId = thane.templateId;
         if(_loc1_ && !_loc1_.isHidendDragonWingAvata)
         {
            _loc7_.wingAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc6_);
         }
         if(_loc1_ && !_loc1_.isHidenDragonArmAvata)
         {
            _loc7_.armsFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc4_);
         }
         if(_loc1_ && !_loc1_.isHidenDragonClothAvata)
         {
            _loc7_.bodyFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc8_);
         }
         if(_loc1_ && !_loc1_.isHidenDragonHatAvat)
         {
            _loc7_.hairFashionAvata = ThaneEquipShowHelper.getAvatarByEquipInfo(_loc3_);
         }
         _figure.data = _loc7_;
      }
      
      private function refreshTalismanView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerTalismanEquipCell = null;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = _talismanList[_loc2_];
            _loc1_.data = model.getEquipTalismanInfoBySontype(_loc2_ + 401);
            _loc2_++;
         }
      }
      
      public function getItemViewByPos(param1:int, param2:int = 4) : PlayerEquipCell
      {
         if(!thane)
         {
            return null;
         }
         var _loc3_:PlayerEquipCell = _equipViewDic[param1 + "_" + thane.id + "_" + param2];
         if(!_loc3_)
         {
            _loc3_ = _fashionViewList[param1 + "_" + thane.id + "_" + param2];
         }
         if(!_loc3_)
         {
            _loc3_ = _honerViewDic[param1 + "_" + thane.id + "_" + param2];
         }
         return _loc3_;
      }
      
      private function get serverTime() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function setFashionBtnVisible(param1:Boolean) : void
      {
         _fashionBtn.visible = param1;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_honor);
         _honor = null;
         ObjectUtils.disposeObject(_figureBack);
         _figureBack = null;
         ObjectUtils.disposeObject(_figure);
         _figure = null;
         ObjectUtils.disposeObject(_relic);
         _relic = null;
         ObjectUtils.disposeObject(_heraldry);
         _heraldry = null;
         ObjectUtils.disposeObject(_vocationIcon);
         _vocationIcon = null;
         ObjectUtils.disposeObject(_nameText);
         _consortiaText = null;
         ObjectUtils.disposeObject(_consortiaText);
         _consortiaText = null;
         ObjectUtils.disposeObject(_lvlText);
         _lvlText = null;
         ObjectUtils.disposeObject(_vipIconBtn);
         _vipIconBtn = null;
         ObjectUtils.disposeObject(_novipIconBtn);
         _novipIconBtn = null;
         ObjectUtils.disposeViolentMc(_fightBg);
         _fightBg = null;
         ObjectUtils.disposeObject(_fightText);
         _fightText = null;
         ObjectUtils.disposeViolentMc(_fightMc);
         _fightMc = null;
         ObjectUtils.disposeObject(_fightBmp);
         _fightBmp = null;
         ObjectUtils.disposeObject(_attributeButton);
         _attributeButton = null;
         ObjectUtils.disposeObject(_marryRing);
         _marryRing = null;
         LogicUtils.disposeDisplayCollection(_equipViewDic);
         _equipViewDic = null;
         LogicUtils.disposeDisplayCollection(_equipList);
         _equipList = null;
         LogicUtils.disposeDisplayCollection(_honerViewDic);
         _honerViewDic = null;
         LogicUtils.disposeDisplayCollection(_talismanList);
         _talismanList = null;
         ObjectUtils.disposeViolentMc(_fashionGirdBack);
         _fashionGirdBack = null;
         ObjectUtils.disposeObject(_fashionPanel);
         _fashionPanel = null;
         ObjectUtils.disposeObject(_fashionComposeBtn);
         _fashionComposeBtn = null;
         ObjectUtils.disposeObject(_fashionSwitchBtn);
         _fashionSwitchBtn = null;
         ObjectUtils.disposeObject(_fashionRefreshBtn);
         _fashionRefreshBtn = null;
         ObjectUtils.disposeObject(_switchTip);
         _switchTip = null;
         ObjectUtils.disposeObject(_fashionIdentityTip);
         _fashionIdentityTip = null;
         ObjectUtils.disposeViolentMc(_fashionProgressBar);
         _fashionProgressBar = null;
         ObjectUtils.disposeObject(_fashionProgressTxt);
         _fashionProgressTxt = null;
         ObjectUtils.disposeObject(_fashionLvlBmp);
         _fashionLvlBmp = null;
         ObjectUtils.disposeObject(_fashionLvlTxt);
         _fashionLvlTxt = null;
         ObjectUtils.disposeObject(_fashionLvlStrip);
         _fashionLvlStrip = null;
         ObjectUtils.disposeObject(_headdressFshion);
         _headdressFshion = null;
         ObjectUtils.disposeObject(_clothesFashion);
         _clothesFashion = null;
         ObjectUtils.disposeObject(_wing);
         _wing = null;
         ObjectUtils.disposeObject(_fashionBtn);
         _fashionBtn = null;
         ObjectUtils.disposeObject(_returnBtn);
         _returnBtn = null;
         ObjectUtils.disposeObject(_weaponFashion);
         _weaponFashion = null;
         ObjectUtils.disposeObject(_tickFashion1);
         _tickFashion1 = null;
         ObjectUtils.disposeObject(_tickFashion2);
         _tickFashion2 = null;
         ObjectUtils.disposeObject(_tickFashion3);
         _tickFashion3 = null;
         ObjectUtils.disposeObject(_tickFashion4);
         _tickFashion4 = null;
         ObjectUtils.disposeObject(_fashionSprite);
         _fashionSprite = null;
         ObjectUtils.disposeObject(_equipSprite);
         _equipSprite = null;
         ObjectUtils.disposeViolentMc(_equipGirdBack);
         _equipGirdBack = null;
         ObjectUtils.disposeObject(_talismanContiner);
         _talismanContiner = null;
         ObjectUtils.disposeObject(_jobChangeBtn);
         _jobChangeBtn = null;
         ObjectUtils.disposeObject(_fashionDefaultBtn);
         _fashionDefaultBtn = null;
         ObjectUtils.disposeObject(_fashionDefaultText);
         _fashionDefaultText = null;
         LogicUtils.disposeDisplayCollection(_fashionList);
         _fashionList = null;
         LogicUtils.disposeDisplayCollection(_fashionTickList);
         _fashionTickList = null;
         LogicUtils.disposeDisplayCollection(_fashionViewList);
         _fashionViewList = null;
         _simpleInfo = null;
         super.dispose();
      }
   }
}

