package ui.resourcebar.view
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ArmyEvent;
   import events.SNSEvent;
   import events.VIPEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   import mainBar.SmallMapBar;
   import mainBar.StripView;
   import mainBar.view.CountExperenceView;
   import mainBar.view.HPExperenceView;
   import mainBar.view.PowerExperenceView;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.DragonTalkerManager;
   import managers.MagicSpringManager;
   import managers.SNSManager;
   import managers.VIPManager;
   import mvc.module.armyII.UserArmy;
   import mvc.module.children.ChildData;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.vip.VIPModel;
   import mvc.module.vip.VipInfo;
   import ui.resourcebar.view.quickbuy.QuickBuyFrame;
   import yishi.actions.base.AlertTipAction;
   import yishi.actions.hero.HeroLeveUpdateAction;
   import yishi.datas.VersionSwitch;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.events.PlayerEvent;
   import yishi.events.ResourceEvent;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DelayActionsUtils;
   import yishi.utils.FormularySets;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.LevelUpViewII;
   import yishi.view.component.MovieButton;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class ResourceView extends Sprite
   {
      
      public static const STEP:Number = 9999999;
      
      public static const STEP_ONE:Number = 99999;
      
      private var _back1:Image;
      
      private var _goldItem:StripView;
      
      private var _voucherItem:StripView;
      
      private var _giftItem:StripView;
      
      private var _goldIcon:Bitmap;
      
      private var _voucherIcon:Bitmap;
      
      private var _giftIcon:Bitmap;
      
      private var _goldTxt:FilterFrameText;
      
      private var _voucherTxt:FilterFrameText;
      
      private var _giftTxt:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      private var _iconMask:Sprite;
      
      private var _iconMaskAsset:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _level:FilterFrameText;
      
      private var _hpExp:HPExperenceView;
      
      private var _countExp:CountExperenceView;
      
      private var _powerExp:PowerExperenceView;
      
      private var _filter:IFilterFormat;
      
      private var _prevGrade:int = 0;
      
      private var _numberBitmapData:BitmapData;
      
      private var _goldOver:GoldOvertopView;
      
      private var _normalVipBtn:IconButton;
      
      private var _getVipBtn:IconButton;
      
      private var _goldEffect:MovieImage;
      
      private var _fullScreenMc:MovieButton;
      
      private var _tipButton:BaseButton;
      
      private var _vocationIcon:ScaleFrameImage;
      
      private var _jobChangeBtn:ScaleFrameImage;
      
      private var _secretaryBtn:BaseButton;
      
      private var _clickTime:int = 0;
      
      public function ResourceView()
      {
         super();
         init();
         initEffect();
         addEvent();
         defaultView();
      }
      
      private function get fieldYield() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = BuildingManager.instance.model.fieldDic.getList();
         var _loc4_:int = int(_loc1_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ += _loc1_[_loc3_].yield;
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function init() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.Back1");
         _icon = ComponentFactory.Instance.creatCustomObject("resoueceBar.PlayerIcon");
         _iconMaskAsset = ComponentFactory.Instance.creatBitmap("asset.resourceBar.ResourceView.MaskAsset1");
         _level = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.LevelText");
         _name = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.NickNameText");
         _goldIcon = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.GoldIconAsset");
         _voucherIcon = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.VoucherIconAsset");
         _giftIcon = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.GiftIconAsset");
         _goldTxt = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.GoldTxt");
         _giftTxt = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.GiftTxt");
         _voucherTxt = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.VoucherTxt");
         _goldItem = ComponentFactory.Instance.creatCustomObject("resoueceBar.GoldView");
         _voucherItem = ComponentFactory.Instance.creatCustomObject("resourceBar.VoucherItem");
         _giftItem = ComponentFactory.Instance.creatCustomObject("resourceBar.GIftItem");
         _secretaryBtn = ComponentFactory.Instance.creatComponentByStylename("secrearytary.icon");
         _goldItem.addChild(_goldIcon);
         _goldItem.addChild(_goldTxt);
         _goldItem.setHitArea(0,6,75,16);
         _voucherItem.addChild(_voucherIcon);
         _voucherItem.addChild(_voucherTxt);
         _voucherItem.setHitArea(0,6,75,16);
         _giftItem.addChild(_giftIcon);
         _giftItem.addChild(_giftTxt);
         _giftItem.setHitArea(0,6,75,16);
         _hpExp = ComponentFactory.Instance.creatCustomObject("resourceBar.HPExperenceView");
         _countExp = ComponentFactory.Instance.creatCustomObject("resourceBar.CountExperenceView");
         _powerExp = ComponentFactory.Instance.creatCustomObject("resourceBar.PowerExperenceView");
         _normalVipBtn = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.ResourceView.normalVipBtn");
         _getVipBtn = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.ResourceView.getVipBtn");
         _jobChangeBtn = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.JobChangeBtn");
         _icon.buttonMode = true;
         _iconMask = new Sprite();
         _iconMask.x = 15;
         _iconMask.y = 0;
         _iconMaskAsset.blendMode = "alpha";
         _iconMask.blendMode = "layer";
         _iconMask.addChild(_icon);
         _iconMask.addChild(_iconMaskAsset);
         _hpExp.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.hpExpTipData");
         _countExp.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.countExpTipData");
         _powerExp.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.componetPower",600);
         _numberBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_02");
         _getVipBtn.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.getVipBtnTip");
         _fullScreenMc = ComponentFactory.Instance.creatComponentByStylename("smallMap.FullScreenMC");
         _fullScreenMc.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.FullScreenBtnTip");
         _jobChangeBtn.buttonMode = true;
         _jobChangeBtn.setFrame(1);
         _jobChangeBtn.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.JobChangeBtnClickTips");
         addChild(_back1);
         addChild(_iconMask);
         addChild(_level);
         addChild(_name);
         addChild(_goldItem);
         addChild(_voucherItem);
         addChild(_giftItem);
         addChild(_hpExp);
         addChild(_countExp);
         addChild(_powerExp);
         addChild(_normalVipBtn);
         addChild(_getVipBtn);
         addChild(_jobChangeBtn);
         addChild(_secretaryBtn);
         setVocation();
         if(VersionSwitch.FULL_BUTTON)
         {
            addChild(_fullScreenMc);
         }
         _fullScreenMc.stopEffect();
         if(getFullScreenBtnHasShine())
         {
            _fullScreenMc.isPlaying = true;
            _fullScreenMc.playEffect();
         }
         __refreshVipBtn(null);
         setBloodBtn();
      }
      
      private function setVocation() : void
      {
         if(playerInfo.vocationGrades > 0)
         {
            if(_vocationIcon == null)
            {
               _vocationIcon = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.VocationIconBtn");
               addChild(_vocationIcon);
            }
            _vocationIcon.visible = true;
            _vocationIcon.tipData = "<font color=\'#f6c503\' size=\'14\'>" + PlayerManager.instance.getVocationName(thane.templateInfo.Job,playerInfo.vocationStep,playerInfo.vocationLevel) + "</font>";
            if(playerInfo.isHoly)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.holyTip");
            }
            else if(playerInfo.isAvenger)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.avengerTip");
            }
            else if(playerInfo.vocationIndex > 0)
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.transferTip");
            }
            else
            {
               _vocationIcon.tipData += LanguageMgr.GetTranslation("army.Equip.VocationIcon.tip");
            }
            _vocationIcon.setFrame(playerInfo.vocationLevel);
         }
      }
      
      private function initEffect() : void
      {
         _goldEffect = ComponentFactory.Instance.creatComponentByStylename("resourceBar.GoldEffect");
         _goldEffect.mouseChildren = false;
         _goldEffect.mouseEnabled = false;
         _goldEffect.movie.gotoAndStop(_goldEffect.movie.totalFrames);
         addChild(_goldEffect);
         _filter = new UIFilter();
         NumberViewUtils.refreshValue(100,_goldEffect.movie.content,_numberBitmapData,15,27,13,15,"+0123456789");
         _goldEffect.movie.play();
      }
      
      private function initTipData() : void
      {
         var _loc6_:int = 0;
         var _loc3_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         var _loc1_:String = LanguageMgr.GetTranslation("mainBar.view.ResourceView.gold");
         _loc3_.addItem(_loc1_,null);
         _loc1_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.goldInfo01");
         var _loc4_:int = gold.baseYield - fieldYield;
         var _loc2_:String = "";
         var _loc5_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(1);
         if(_loc5_)
         {
            _loc6_ = Math.floor(_loc5_.tempInfo.AddValue * _loc4_ / 100);
            _loc2_ = LanguageMgr.GetTranslation("MagicSpringFrame.buffer.addText",_loc6_);
         }
         _loc3_.addItem(LanguageMgr.GetTranslation("mainBar.view.ResourceView.inside"),_loc4_ + LanguageMgr.GetTranslation("mainBar.view.ResourceView.perHour") + _loc2_);
         _loc1_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.goldInfo07");
         _goldItem.tipData = _loc3_;
         _loc1_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.goldInfo05");
         _giftItem.tipData = _loc1_;
         _loc1_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.goldInfo06");
         _voucherItem.tipData = _loc1_;
      }
      
      private function addEvent() : void
      {
         StageReferance.addEventListener("resize",__onResizeHandler);
         gold.addEventListener(ResourceEvent.RESOURCE_UPDATE,__refreshGold);
         playerInfo.addEventListener("PLAYER_INFO_UPDATE",__playerDataUpdate);
         playerInfo.addEventListener("VOCATION_GRADES",__playerVocationUpdate);
         thane.addEventListener("THANE_LEVEL_UPDATE",__heroLevelUpdate);
         thane.addEventListener("THANE_INFO_UPDATE",__thaneInfoChangeHandler);
         thane.addEventListener("BLOOD_VISIBLE_UPDATE",__updateBloodBtnHandlerr);
         thane.addEventListener("BLOOD_UPDATE",__updateBloodHandler);
         serialArmy.addEventListener("ARMY_PAWN_CHANGE",__armyInfoChangeHandler);
         _icon.addEventListener("click",__playerIconClickHandler);
         _icon.addEventListener("mouseOver",__playaerIconOverHandler);
         _icon.addEventListener("mouseOut",__playaerIconOutHandler);
         SNSManager.instance.addEventListener("SNSINFO_UPDATE",__snsInfoUpdateHandler);
         _normalVipBtn.addEventListener("click",__openVipHandler);
         _getVipBtn.addEventListener("click",__openVipHandler);
         vipModel.addEventListener("upframeview_change",__refreshVipBtn);
         _fullScreenMc.addEventListener("click",__fullScreenHandler);
         _jobChangeBtn.addEventListener("click",__jobChangeBtnClickHandler);
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateDragonTalkerState);
         MsgMan.addObserver("INFO_CHANGE_BACK",this,__onMagicSpringBufferHandler);
         MsgMan.addObserver("MAKE_SUCCESS_BACK",this,__onMagicSpringBufferHandler);
         model.addEventListener("SecretAdEvent.frameUpdate",secretFrameHandler);
         _secretaryBtn.addEventListener("click",__secretaryClick);
      }
      
      protected function __secretaryClick(param1:Event) : void
      {
         FrameControllerManager.instance.openControllerByInfo("SECRETARY");
      }
      
      private function secretFrameHandler(param1:Event) : void
      {
         var _loc2_:String = SceneManager.instance.currentType;
         if(_loc2_ == "SECRET_ADVENTURE_SCENE" && _hpExp)
         {
            _hpExp.data = serialArmy;
         }
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      private function __onMagicSpringBufferHandler(param1:String, param2:Object) : void
      {
         initTipData();
      }
      
      private function getFullScreenBtnHasShine() : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc1_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc3_:Number = SharedManager.instance.todayFullScreenBtnShine;
         if(_loc1_.getTime() > _loc3_)
         {
            _loc4_ = true;
            if(_loc1_.hours < 5)
            {
               _loc1_.hours = 5;
               _loc1_.minutes = 0;
               SharedManager.instance.todayFullScreenBtnShine = _loc1_.getTime();
            }
            else
            {
               _loc1_.hours = 5;
               _loc1_.minutes = 0;
               _loc2_ = _loc1_.getTime() + 86400000;
               SharedManager.instance.todayFullScreenBtnShine = _loc2_;
            }
            SharedManager.instance.saveTodayFullScreenBtnShine();
         }
         return _loc4_;
      }
      
      private function __fullScreenHandler(param1:MouseEvent) : void
      {
         var _loc7_:String = null;
         var _loc2_:URLRequest = null;
         _fullScreenMc.isPlaying = false;
         _fullScreenMc.stopEffect();
         var _loc3_:String = Capabilities.version;
         var _loc4_:int = _loc3_.indexOf(" ") + 1;
         var _loc6_:Array = _loc3_.substring(_loc4_).split(",");
         var _loc5_:Boolean = false;
         if(_loc6_[0] > 11)
         {
            _loc5_ = true;
         }
         else if(_loc6_[0] == 11 && _loc6_[1] >= 3)
         {
            _loc5_ = true;
         }
         if(_loc5_)
         {
            if(_fullScreenMc.isPlaying)
            {
               _fullScreenMc.isPlaying = false;
               _fullScreenMc.stopEffect();
            }
            if(stage.displayState == "normal")
            {
               stage.displayState = "fullScreenInteractive";
            }
            else
            {
               stage.displayState = "normal";
            }
            if(_fullScreenMc.isPlaying)
            {
               _fullScreenMc.isPlaying = false;
               _fullScreenMc.stopEffect();
            }
         }
         else
         {
            _loc7_ = "http://get.adobe.com/cn/flashplayer/";
            _loc2_ = new URLRequest(_loc7_);
            navigateToURL(_loc2_,"_blank");
         }
      }
      
      private function __onResizeHandler(param1:Event) : void
      {
         if(stage == null)
         {
            return;
         }
         if(stage.displayState == "normal")
         {
            _fullScreenMc.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.FullScreenBtnTip");
         }
         else
         {
            _fullScreenMc.tipData = LanguageMgr.GetTranslation("mainBar.SmallMapBar.NormalScreenBtnTip");
         }
      }
      
      private function __refreshVipBtn(param1:VIPEvent) : void
      {
         var _loc2_:VipInfo = vipModel.vipInfo;
         if(!_loc2_.IsVipAndNoExpirt)
         {
            _normalVipBtn.visible = false;
            _getVipBtn.visible = true;
         }
         else
         {
            _normalVipBtn.visible = true;
            _getVipBtn.visible = false;
         }
      }
      
      private function __onQuickBuyBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:QuickBuyFrame = ComponentFactory.Instance.createComponentGroupByStylename("resourcesBar.QuickBuyFrame");
         if(_loc2_)
         {
            _loc2_.show();
         }
      }
      
      private function __updateBloodBtnHandlerr(param1:PlayerEvent) : void
      {
         setBloodBtn();
      }
      
      private function __updateBloodHandler(param1:PlayerEvent) : void
      {
         setBloodBtn();
         refreshView();
      }
      
      private function setBloodBtn() : void
      {
      }
      
      private function __snsInfoUpdateHandler(param1:SNSEvent) : void
      {
         refreshIcon();
      }
      
      private function __refreshGold(param1:ResourceEvent) : void
      {
         initTipData();
         ObjectUtils.removeChildAllChildren(_goldEffect.movie.content);
         if(param1.data > 0)
         {
            NumberViewUtils.refreshValue(param1.data,_goldEffect.movie.content,_numberBitmapData,15,27,13,15,"+0123456789");
            _goldEffect.movie.play();
            if(param1.data % 500 == 0 && thane.grades > 5)
            {
               SoundManager.instance.play("037",true);
            }
         }
         if(gold.count >= gold.limit)
         {
            _goldTxt.setFrame(2);
            isShowGoldOvertopView(param1.data);
         }
         else
         {
            _goldTxt.setFrame(1);
            if(_goldOver != null)
            {
               _goldOver.dispose();
               _goldOver = null;
            }
         }
         _goldTxt.text = FormularySets.toStringSelf(gold.count,9999999);
      }
      
      private function isShowGoldOvertopView(param1:int) : void
      {
         if(gold.count - param1 < gold.limit)
         {
            if(_goldOver == null)
            {
               _goldOver = new GoldOvertopView();
               _goldOver.x = 125;
               _goldOver.y = 58;
               addChild(_goldOver);
            }
         }
      }
      
      private function __playerDataUpdate(param1:PlayerEvent) : void
      {
         _level.text = thane.grades.toString();
         _voucherTxt.text = playerInfo.point.toString();
         _giftTxt.text = playerInfo.giftToken1.toString();
         if(playerInfo.nickName == playerInfo.userId + "$" || playerInfo.nickName == LanguageMgr.GetTranslation("public.nickName"))
         {
            _name.text = LanguageMgr.GetTranslation("public.nickName");
         }
         else
         {
            _name.text = playerInfo.nickName;
         }
         showTipButton();
         refreshView();
      }
      
      public function showTipButton() : void
      {
         if(_name.text.substring(_name.text.length - 3) == "..." && playerInfo.nickName.substring(playerInfo.nickName.length - 3) != "...")
         {
            if(!_tipButton)
            {
               _tipButton = ComponentFactory.Instance.creatComponentByStylename("core.CloseBtn");
               _tipButton.x = _name.x;
               _tipButton.y = _name.y;
               _tipButton.width = _name.width;
               _tipButton.height = _name.height;
               _tipButton.alpha = 0;
               _tipButton.tipData = playerInfo.nickName;
               addChild(_tipButton);
               _tipButton.tipGapH = 0;
               _tipButton.tipGapV = 0;
            }
         }
         else if(_tipButton)
         {
            ObjectUtils.disposeObject(_tipButton);
            if(_tipButton.parent)
            {
               _tipButton.parent.removeChild(_tipButton);
            }
            _tipButton = null;
         }
      }
      
      private function __playerVocationUpdate(param1:PlayerEvent) : void
      {
         DelayActionsUtils.instance.addAction(new AlertTipAction(true,showLevelUpView,"",3));
         setVocation();
      }
      
      private function __heroLevelUpdate(param1:PlayerEvent) : void
      {
         refreshView();
         _level.text = thane.grades.toString();
         setBloodBtn();
         if(thane.grades >= 20)
         {
            SmallMapBar.instance.checkFaceBookBtn();
         }
         if(thane.grades >= 3)
         {
            if(getTimer() - _clickTime > 500)
            {
               GameBaseQueueManager.instance.addAction(new HeroLeveUpdateAction(false),1200);
            }
            _clickTime = getTimer();
         }
         NotificationManager.instance.sendNotification("LEVEL_COMMIT",thane.grades);
      }
      
      private function showLevelUpView(param1:Boolean) : void
      {
         var isVocation:Boolean = param1;
         var showLevelUpCallback:* = function():void
         {
            var _loc1_:LevelUpViewII = ComponentFactory.Instance.creatCustomObject("core.LevelupViewII",[isVocation]);
            _loc1_.show();
            _loc1_.x = isVocation ? 420 : 420;
            _loc1_.y = 210;
         };
         CheckUIModuleUtil.instance.tryCall("playerlevelup",showLevelUpCallback);
      }
      
      private function __thaneInfoChangeHandler(param1:PlayerEvent) : void
      {
         refreshView();
         refreshIcon();
      }
      
      private function __armyInfoChangeHandler(param1:ArmyEvent) : void
      {
         refreshView();
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
      
      public function jobChangeBtnEnable(param1:Boolean) : void
      {
         if(_jobChangeBtn.buttonMode == param1)
         {
            return;
         }
         if(param1)
         {
            _jobChangeBtn.addEventListener("click",__jobChangeBtnClickHandler);
            _jobChangeBtn.buttonMode = true;
            _filter.setNormalFilter(_jobChangeBtn);
         }
         else
         {
            _jobChangeBtn.removeEventListener("click",__jobChangeBtnClickHandler);
            _jobChangeBtn.buttonMode = false;
            _filter.setGrayFilter(_jobChangeBtn);
         }
      }
      
      private function __updateDragonTalkerState(param1:String, param2:Object) : void
      {
         refreshJobChangeBtn();
      }
      
      public function refreshJobChangeBtn() : void
      {
         if(DragonTalkerManager.instance.model.isDragonTalker)
         {
            _jobChangeBtn.setFrame(4);
         }
         else
         {
            _jobChangeBtn.setFrame(thane.templateInfo.Job);
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         _hpExp.data = serialArmy;
         _countExp.data = serialArmy;
         _powerExp.data = serialArmy;
         __updateBloodBtnHandlerr(null);
         if(slavedChild && serialArmy)
         {
            _loc1_ = int(serialArmy.armyPawns[0].ownPawns);
            if(_loc1_ > 0)
            {
               ArmyManager.instance.army.removeArmyPawnCountByIndex(0,_loc1_);
               ArmyManager.instance.addPawnCountById(serialArmy.armyPawns[0].templateId,_loc1_);
               FrameControllerManager.instance.armyController.sendMovePawnInfo();
            }
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
      
      private function get slavedChild() : ChildData
      {
         return ChildManager.instance.model.getSlavedEnterWar();
      }
      
      public function refreshIcon() : void
      {
         var _loc1_:String = IconFactory.getPlayerIcon(thane.snsInfo.headId,"head");
         _icon.icon = _loc1_;
      }
      
      private function __playerIconClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.grades < 5)
         {
            return;
         }
         FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.ATTRIBUTE_PANEL);
      }
      
      private function __playaerIconOverHandler(param1:MouseEvent) : void
      {
         _filter.setLightingFilter(_icon);
      }
      
      private function __playaerIconOutHandler(param1:MouseEvent) : void
      {
         _filter.setNormalFilter(_icon);
      }
      
      private function __openVipHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("vip");
      }
      
      private function defaultView() : void
      {
         _goldTxt.text = FormularySets.toStringSelf(gold.count,9999999);
         _icon.icon = IconFactory.getPlayerIcon(thane.snsInfo.headId,"head");
         if(playerInfo.nickName == playerInfo.userId + "$" || playerInfo.nickName == LanguageMgr.GetTranslation("public.nickName"))
         {
            _name.text = LanguageMgr.GetTranslation("public.nickName");
         }
         else
         {
            _name.text = playerInfo.nickName;
         }
         showTipButton();
         _level.text = thane.grades.toString();
         _voucherTxt.text = FormularySets.toStringSelf(playerInfo.point,9999999);
         _giftTxt.text = FormularySets.toStringSelf(playerInfo.giftToken1,9999999);
         _hpExp.data = serialArmy;
         _countExp.data = serialArmy;
         _powerExp.data = serialArmy;
         initTipData();
         __updateBloodBtnHandlerr(null);
         refreshJobChangeBtn();
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function get population() : ResourceData
      {
         return ResourceManager.instance.population;
      }
      
      private function get serialArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get fatigueView() : PowerExperenceView
      {
         return _powerExp;
      }
      
      public function set iconClickEnable(param1:Boolean) : void
      {
         _icon.mouseChildren = param1;
         _icon.mouseEnabled = param1;
      }
      
      private function get vipModel() : VIPModel
      {
         return VIPManager.Instance.model;
      }
   }
}

