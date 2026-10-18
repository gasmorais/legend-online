package sacrifice
{
   import bag.events.BagEvent;
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.instance.ComponentGroupManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import mainBar.StripView;
   import mainBar.effects.MainToolBtnGlowEffect;
   import manager.LanguageMgr;
   import managers.VIPManager;
   import mvc.controler.SacrificeController;
   import mvc.module.sacrifice.SacrificeInfo;
   import ui.maintoolbar.MainToolBar;
   import ui.queuebar.QueueBar;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SacrificeFrame extends §CubXcb{qDD[o{Kn§
   {
      
      private static const ADVANCEDSACRIFICEINDEX:int = 3;
      
      private static const REWARDITEMNUM:int = 5;
      
      private static const NOTVIPTIMES:int = 3;
      
      private static const REFRESHCOST:int = 15;
      
      private static const MOVETOCENTERTIME:Array = [2,1,0.5,1,2];
      
      private var _controller:SacrificeController;
      
      private var _sacrificeBtn:BaseButton;
      
      private var _refreshRewardBtn:BaseButton;
      
      private var _isTimesUsed:Boolean;
      
      private var _isRewardGot:Boolean;
      
      private var _currentIndex:int;
      
      private var _sacrificeTimesGText:GradientText;
      
      private var _leftTimesStripView:StripView;
      
      private var _sacrificeMC:MovieClip;
      
      private var _sacrificeBGMC:MovieClip;
      
      private var _sacrificeBGFireMC:MovieClip;
      
      private var _choosenGoodsItem:BaseItemView;
      
      private var _rewardGoodsArr:Array = [];
      
      private var _sacrificeGoodsArr:Array = [];
      
      private var _goodsLvTxtArr:Array = [];
      
      private var _rewardItemdArr:Array = [];
      
      private var _sacrificeGoodsItemArr:Array = [];
      
      private var _sacrificeGoodsHbox:HBox;
      
      private var _sacrificeGoodsBg:Bitmap;
      
      private var _sacrificeGoodsBgTitle:GradientText;
      
      private var _effectDic:Dictionary = new Dictionary(true);
      
      private var _limitInfo:ConfigInfosTempInfo;
      
      private var _blackGound:Sprite;
      
      private var _isSacrifing:Boolean;
      
      private var _rewardItemGot:SacrificeGoodsItem;
      
      private var _isReqSend:Boolean = false;
      
      private var refuseInvite:Boolean;
      
      private var refuseTeamInvite:Boolean;
      
      public function SacrificeFrame()
      {
         super();
         _controller = FrameControllerManager.instance.sacrificeController;
         _controller.sendOpen();
         initView();
         addEvent();
         sendRefuseInvite();
      }
      
      private function initView() : void
      {
         ComponentGroupManager.Instance.disposeAllOpenFrame();
         _blackGound = new Sprite();
         addToContent(_blackGound);
         setUIVisible("1_2_8");
         setBg("asset.sacrifice.bg");
         _sacrificeBtn = ComponentFactory.Instance.creatComponentByStylename("sacrifice.SacrificeFrame.sacrificeBtn");
         _refreshRewardBtn = ComponentFactory.Instance.creatComponentByStylename("sacrifice.SacrificeFrame.refreshRewardBtn");
         _sacrificeMC = ComponentFactory.Instance.creatCustomObject("asset.sacrifice.sacrificeMC");
         _sacrificeGoodsHbox = ComponentFactory.Instance.creatComponentByStylename("sacrifice.sacfificeFrame.goodsHbox");
         _sacrificeGoodsBg = ComponentFactory.Instance.creatBitmap("asset.sacrifice.chooseGoodsBg");
         _sacrificeGoodsBgTitle = ComponentFactory.Instance.creatComponentByStylename("sacrifice.sacfificeFrame.goodsBgTitle");
         _choosenGoodsItem = ComponentFactory.Instance.creatComponentByStylename("sacrifice.sacfificeFrame.choosenGoodsItem");
         _sacrificeTimesGText = ComponentFactory.Instance.creatComponentByStylename("sacrifice.sacfificeFrame.leftTimesTxt");
         _leftTimesStripView = ComponentFactory.Instance.creatCustomObject("sacrifice.sacfificeFrame.leftTimesStripView");
         _sacrificeBGMC = ComponentFactory.Instance.creatCustomObject("asset.sacrifice.bgMC");
         _sacrificeBGFireMC = ComponentFactory.Instance.creatCustomObject("asset.sacrifice.bgFireMc");
         addToContent(_sacrificeBGMC);
         _sacrificeBGMC.visible = false;
         addToContent(_sacrificeBGFireMC);
         _sacrificeBGFireMC.visible = false;
         addToContent(_sacrificeBtn);
         addToContent(_sacrificeMC);
         _sacrificeMC.stop();
         _sacrificeMC["container"]["pos"].addChild(_choosenGoodsItem);
         addToContent(_sacrificeGoodsBg);
         addToContent(_sacrificeGoodsBgTitle);
         _sacrificeGoodsBgTitle.text = LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.goodsBgTitle");
         addToContent(_sacrificeGoodsHbox);
         _leftTimesStripView.addChild(_sacrificeTimesGText);
         addToContent(_leftTimesStripView);
         _limitInfo = TempleteManager.instance.getConfigInfoByConfigName("sacrifice_max_times");
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHanlder);
         NotificationManager.instance.addEventListener("CLOSE_SACRIFICE_FRAME",__closeFrameHandler);
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__closeFrameHandler);
         _sacrificeBtn.addEventListener("click",__sacrificeHandler);
         _refreshRewardBtn.addEventListener("click",__refreshRewardHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHanlder);
         NotificationManager.instance.removeEventListener("CLOSE_SACRIFICE_FRAME",__closeFrameHandler);
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__closeFrameHandler);
         _sacrificeBtn.removeEventListener("click",__sacrificeHandler);
         _refreshRewardBtn.removeEventListener("click",__refreshRewardHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagUpdateHandler);
         for each(var _loc1_:SacrificeGoodsItem in _sacrificeGoodsItemArr)
         {
            if(_loc1_)
            {
               _loc1_.removeEventListener("click",__SacrificeGoodsItemClick);
            }
         }
      }
      
      private function __bagUpdateHandler(param1:BagEvent) : void
      {
         refreshSacrificeGoodsCount();
      }
      
      private function __resizeHanlder(param1:Event) : void
      {
         x = (StageReferance.stageWidth - bg.width) / 2;
         y = (StageReferance.stageHeight - bg.height) / 2;
         _blackGound.graphics.clear();
         _blackGound.graphics.beginFill(0,1);
         _blackGound.graphics.drawRect(-200,-200,StageReferance.stage.stageWidth + 400,StageReferance.stage.stageHeight + 400);
         _blackGound.graphics.endFill();
      }
      
      private function __SacrificeGoodsItemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = _sacrificeGoodsItemArr.indexOf(param1.currentTarget);
         if(_loc2_ != -1)
         {
            _currentIndex = _loc2_;
            _choosenGoodsItem.data = _sacrificeGoodsArr[_currentIndex];
            setEffectStop();
         }
      }
      
      private function __sacrificeHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(!_isRewardGot && _rewardGoodsArr.length > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.getRewardTip"));
            return;
         }
         if(_isTimesUsed)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.timesUsedOut"));
            return;
         }
         if(!_choosenGoodsItem.data)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.chooseGoods"));
            _loc2_ = int(_sacrificeGoodsArr.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_sacrificeGoodsArr[_loc3_] && _sacrificeGoodsArr[_loc3_].count > 0)
               {
                  _effectDic[_loc3_].play();
               }
               _loc3_++;
            }
            return;
         }
         if(_choosenGoodsItem.data.count <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.goodsIsNotEnough"));
            return;
         }
         _controller.sendSacrifice(_choosenGoodsItem.data.templateId);
         setEffectStop();
      }
      
      private function setEffectStop() : void
      {
         for each(var _loc1_:MainToolBtnGlowEffect in _effectDic)
         {
            if(_loc1_)
            {
               _loc1_.stop();
            }
         }
      }
      
      private function __refreshRewardHandler(param1:MouseEvent) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(!_rewardGoodsArr || _rewardGoodsArr.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.refreshTip2"));
            return;
         }
         if(_isRewardGot || _rewardItemGot)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.refreshTip3"));
            return;
         }
         if(_isSacrifing)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.refreshTip4"));
            return;
         }
         if(isRefreshtodayNeedAlert())
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("sacrifice.SacrificeFrame.refreshNotAlert");
            _loc3_ = LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.refreshTip1",15);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_.show(_loc3_,_loc2_,refreshAlertCallBack,null,"center");
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < 15)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.pointNotEnough"));
            return;
         }
         _controller.sendRefreshReward();
      }
      
      private function refreshAlertCallBack(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.sacrificeRefreshNeedAlertCheckDate = new Date();
            SharedManager.instance.saveSacrificeRefreshNeedAlertCheckDate();
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < 15)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.pointNotEnough"));
            return;
         }
         _controller.sendRefreshReward();
      }
      
      private function isRefreshtodayNeedAlert() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.sacrificeRefreshNeedAlertCheckDate;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function __closeFrameHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      public function openFrame(param1:SacrificeInfo) : void
      {
         _sacrificeGoodsArr = param1.sacrificeGoodsArr;
         _rewardGoodsArr = param1.rewardArr;
         _isRewardGot = false;
         addSacrificeGoods();
         refreshView(param1);
         if(_rewardGoodsArr.length > 0)
         {
            _sacrificeMC.gotoAndStop(_sacrificeMC.totalFrames);
            (_sacrificeMC["rewarBG"] as MovieClip).stop();
            if(_rewardItemdArr.length <= 0)
            {
               addRewardItem();
            }
            refreshRewardItem();
         }
      }
      
      private function refreshView(param1:SacrificeInfo) : void
      {
         var _loc2_:int = 0;
         if(_limitInfo)
         {
            _isTimesUsed = param1.times >= parseInt(_limitInfo.ConfigValue) ? true : false;
            _loc2_ = param1.times > parseInt(_limitInfo.ConfigValue) ? 0 : parseInt(_limitInfo.ConfigValue) - param1.times;
            _sacrificeTimesGText.text = LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.timesLeft") + _loc2_ + "/" + _limitInfo.ConfigValue;
         }
      }
      
      private function getLimitTimes() : int
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(!VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
         {
            return 3;
         }
         var _loc2_:int = int(VIPManager.Instance.model.vipInfo.VipGrade);
         var _loc4_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getVipPrerogativeTypeTempList(201);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_].grade == _loc2_)
            {
               _loc1_ = int(_loc4_[_loc3_].para1);
            }
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function addSacrificeGoods() : void
      {
         var _loc3_:int = 0;
         var _loc1_:SacrificeGoodsItem = null;
         var _loc2_:MainToolBtnGlowEffect = null;
         var _loc4_:GoodsInfo = null;
         _sacrificeGoodsItemArr = [];
         _loc3_ = 0;
         while(_loc3_ < _sacrificeGoodsArr.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("sacrifice.sacfificeFrame.GoodsItem");
            _loc2_ = new MainToolBtnGlowEffect(_loc1_);
            _loc2_.stop();
            _loc1_.addEventListener("click",__SacrificeGoodsItemClick);
            _loc4_ = _sacrificeGoodsArr[_loc3_];
            _loc4_.count = GoodsManager.instance.getBagCountByTempId(1,_loc4_.templateId);
            _loc1_.data = _loc4_;
            _sacrificeGoodsHbox.addChild(_loc1_);
            _sacrificeGoodsItemArr.push(_loc1_);
            _effectDic[_loc3_] = _loc2_;
            _loc3_++;
         }
      }
      
      private function refreshSacrificeGoodsCount() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SacrificeGoodsItem = null;
         var _loc3_:GoodsInfo = null;
         _loc2_ = 0;
         while(_loc2_ < _sacrificeGoodsItemArr.length)
         {
            _loc1_ = _sacrificeGoodsItemArr[_loc2_];
            _loc3_ = _loc1_.data;
            _loc3_.count = GoodsManager.instance.getBagCountByTempId(1,_loc3_.templateId);
            _loc1_.data = _loc3_;
            _loc2_++;
         }
      }
      
      public function updateReward(param1:Array) : void
      {
         _rewardGoodsArr = param1;
         refreshRewardItem();
      }
      
      public function sacrifice(param1:SacrificeInfo) : void
      {
         if(_currentIndex == 3)
         {
            _sacrificeBGMC.visible = _sacrificeBGFireMC.visible = true;
            _sacrificeBGMC.alpha = _sacrificeBGFireMC.alpha = 0;
            TweenMax.to(_sacrificeBGMC,1,{"alpha":1});
            TweenMax.to(_sacrificeBGFireMC,1,{"alpha":1});
         }
         else
         {
            _sacrificeBGMC.visible = _sacrificeBGFireMC.visible = false;
         }
         _isSacrifing = true;
         refreshView(param1);
         _isRewardGot = false;
         _rewardGoodsArr = param1.rewardArr;
         _sacrificeMC.addEventListener("complete",__mcCompleteHandler);
         _sacrificeMC.gotoAndPlay(1);
      }
      
      private function __mcCompleteHandler(param1:Event) : void
      {
         _sacrificeMC.removeEventListener("complete",__mcCompleteHandler);
         (_sacrificeMC["rewarBG"] as MovieClip).stop();
         refreshSacrificeGoodsCount();
         if(_rewardItemdArr.length <= 0)
         {
            addRewardItem();
         }
         refreshRewardItem();
         _isSacrifing = false;
      }
      
      private function setRewardVisible(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _sacrificeMC["pos" + _loc2_].visible = param1;
            _loc2_++;
         }
      }
      
      private function addRewardItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SacrificeGoodsItem = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("sacrifice.sacfificeFrame.GoodsItem");
            _rewardItemdArr.push(_loc1_);
            _sacrificeMC["pos" + _loc2_].addChild(_loc1_);
            _loc1_.addEventListener("click",__rewardItemClickHandler);
            _loc1_.addEventListener("mouseOver",__rewardItemOverHandler);
            _loc1_.addEventListener("mouseOut",__rewardItemOuntHandler);
            _loc2_++;
         }
      }
      
      private function refreshRewardItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SacrificeGoodsItem = null;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _rewardItemdArr[_loc2_] as SacrificeGoodsItem;
            if(_loc1_)
            {
               _loc1_.data = _rewardGoodsArr[_loc2_] as GoodsInfo;
            }
            else
            {
               _loc1_.data = null;
            }
            _loc2_++;
         }
      }
      
      private function __rewardItemOverHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as SacrificeGoodsItem).buttonMode = true;
      }
      
      private function __rewardItemOuntHandler(param1:MouseEvent) : void
      {
         (param1.currentTarget as SacrificeGoodsItem).buttonMode = false;
      }
      
      private function __rewardItemClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:TodayNotAlertFrame = null;
         var _loc3_:String = null;
         var _loc2_:String = null;
         if(_isRewardGot)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.getRewardTip2"));
            return;
         }
         _rewardItemGot = param1.currentTarget as SacrificeGoodsItem;
         if(!_rewardItemGot.data || !_rewardItemGot)
         {
            return;
         }
         if(isgetRewardTodayNeedAlert())
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("sacrifice.SacrificeFrame.refreshNotAlert");
            _loc3_ = LanguageMgr.GetTranslation("sacrifice.sacrificeFrame.getRewarAlert",_rewardItemGot.data.templateInfo.TemplateName);
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_.show(_loc3_,_loc2_,getRewardAlertCallBack,cancleCallBack,"center");
            return;
         }
         _controller.sendGetReward(_rewardItemGot.data.templateId);
      }
      
      private function cancleCallBack() : void
      {
         if(_isReqSend)
         {
            return;
         }
         _rewardItemGot = null;
      }
      
      private function getRewardAlertCallBack(param1:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.sacrificeGetRewardAlertCheckDate = new Date();
            SharedManager.instance.savesacrificeGetRewardAlertCheckDate();
         }
         _controller.sendGetReward(_rewardItemGot.data.templateId);
         _isReqSend = true;
      }
      
      public function getRewarFlyAction(param1:SacrificeInfo) : void
      {
         _isReqSend = false;
         createIconAnime(_rewardItemGot.data.templateId);
      }
      
      public function getRewardDisappearAction(param1:SacrificeInfo) : void
      {
         _isReqSend = false;
         removeRewardItemArrAndBG();
      }
      
      private function createIconAnime(param1:int) : void
      {
         var _loc2_:BaseIconView = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         _loc2_.icon = IconFactory.getGoodsIconByTID(param1);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var _loc5_:Point = this.localToGlobal(new Point(_sacrificeMC.x + _rewardItemGot.parent.x,_sacrificeMC.y + _rewardItemGot.parent.y));
         var _loc2_:Point = this.localToGlobal(new Point(772,285));
         var _loc3_:DisplayObject = MainToolBar.instance.getButtnByType(2) as DisplayObject;
         var _loc4_:Point = _loc3_.localToGlobal(new Point(0,0));
         param1.x = _loc5_.x;
         param1.y = _loc5_.y;
         TweenMax.to(param1,getMoveToCenterTime(),{
            "x":_loc2_.x,
            "y":_loc2_.y,
            "onUpdate":__moveCenterUpdate,
            "onUpdateParams":[param1],
            "onComplete":__moveCenterComplete,
            "onCompleteParams":[param1,_loc4_]
         });
      }
      
      private function getMoveToCenterTime() : Number
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            if(_rewardItemdArr[_loc1_] == _rewardItemGot)
            {
               return Number(MOVETOCENTERTIME[_loc1_]);
            }
            _loc1_++;
         }
         return Number(MOVETOCENTERTIME[0]);
      }
      
      private function __moveCenterUpdate(param1:BaseIconView) : void
      {
         if(!param1.parent)
         {
            StageReferance.stage.addChild(param1);
            removeRewardItemArrAndBG();
         }
      }
      
      private function removeRewardItemArrAndBG() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SacrificeGoodsItem = null;
         (_sacrificeMC["rewarBG"] as MovieClip).visible = false;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = _rewardItemdArr[_loc2_];
            _loc1_.removeEventListener("click",__rewardItemClickHandler);
            _loc1_.removeEventListener("mouseOver",__rewardItemOverHandler);
            _loc1_.removeEventListener("mouseOut",__rewardItemOuntHandler);
            _loc1_.parent.removeChild(_loc1_);
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
            _loc2_++;
         }
         _rewardItemdArr = [];
         _isRewardGot = true;
         _rewardItemGot = null;
         _sacrificeBGMC.visible = _sacrificeBGFireMC.visible = false;
      }
      
      private function __moveCenterComplete(param1:BaseIconView, param2:Point) : void
      {
         if(param1)
         {
            TweenMax.to(param1,1,{
               "delay":0.4,
               "bezierThrough":[{
                  "x":param2.x,
                  "y":param2.y
               }],
               "scaleX":0.3,
               "scaleY":0.3,
               "orientToBezier":false,
               "ease":Quart.easeIn,
               "onComplete":_moveToBagComplete,
               "onCompleteParams":[param1]
            });
         }
      }
      
      private function _moveToBagComplete(param1:BaseIconView) : void
      {
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function disapearComplete(param1:BaseIconView) : void
      {
         ObjectUtils.disposeObject(param1);
      }
      
      private function isgetRewardTodayNeedAlert() : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         var _loc1_:Date = SharedManager.instance.sacrificeGetRewardAlertCheckDate;
         if(_loc1_)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == _loc1_.fullYear && _loc2_.month == _loc1_.month && _loc2_.date == _loc1_.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,6,true,true);
         KeyBoardRegister.instance.keyEnable = false;
         MainToolBar.instance.getButtnByType(10).visible = false;
         MainToolBar.instance.getButtnByType(15).visible = false;
         MainToolBar.instance.getButtnByType(16).visible = false;
         MainToolBar.instance.getButtnByType(9).enable = true;
         MainToolBar.instance.getMovieImageByType(1).visible = false;
         MainToolBar.instance.getMovieImageByType(2).visible = false;
         _controller.isInSacrificeFrame = true;
         __resizeHanlder(null);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function sendRefuseInvite() : void
      {
         refuseInvite = PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite;
         refuseTeamInvite = PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite;
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!PlayerManager.instance.currentPlayerModel.playerInfo.refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      private function removeRefuseInvite() : void
      {
         if(!refuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!refuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      override public function dispose() : void
      {
         removeRefuseInvite();
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         _controller.isInSacrificeFrame = false;
         _controller = null;
         setUIVisible("1_2_3_4_6_7_8_9");
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            QueueBar.instance.show();
         }
         MainToolBar.instance.buttonsStageByScene(SceneManager.instance.currentType);
         ObjectUtils.disposeViolentMc(_sacrificeMC);
         _sacrificeMC = null;
         ObjectUtils.disposeViolentMc(_sacrificeBGFireMC);
         _sacrificeBGFireMC = null;
         ObjectUtils.disposeObject(_sacrificeMC);
         _sacrificeMC = null;
         ObjectUtils.disposeObject(_choosenGoodsItem);
         _choosenGoodsItem = null;
         ObjectUtils.disposeObject(_sacrificeBGMC);
         _sacrificeBGMC = null;
         ObjectUtils.disposeObject(_sacrificeBtn);
         _sacrificeBtn = null;
         ObjectUtils.disposeObject(_refreshRewardBtn);
         _refreshRewardBtn = null;
         ObjectUtils.disposeObject(_leftTimesStripView);
         _leftTimesStripView = null;
         ObjectUtils.disposeObject(_blackGound);
         _blackGound = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

