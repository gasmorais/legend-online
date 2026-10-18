package pumpingjoy
{
   import chat.datas.ChatData;
   import com.greensock.TweenMax;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.PumpingJoyManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.pumpingegg.PumpingJoyModel;
   import mvc.module.pumpingegg.PumpingJoyRewardInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.GoodsHelp;
   import yishi.utils.MsgMan;
   
   public class PumpingJoyFrame extends Frame
   {
      
      private var _leftTime:FilterFrameText;
      
      private var _hasCouponText:FilterFrameText;
      
      private var _floorNeedText:FilterFrameText;
      
      private var _border:ScaleBitmapImage;
      
      private var _timeImage:Image;
      
      private var _tenPumpBtn:IconButton;
      
      private var _onePumpBtn:IconButton;
      
      private var _luckyImage:Image;
      
      private var _getBtn:BaseButton;
      
      private var _shopBtn:BaseButton;
      
      private var _pumpBack:MutipleImage;
      
      private var _couponImage:MutipleImage;
      
      private var _activeLeftTime:GradientText;
      
      private var _exchangeLeftTime:GradientText;
      
      private var _floorImage:Image;
      
      private var _scoreImage:MutipleImage;
      
      private var _scoreText:FilterFrameText;
      
      private var _lookText:FilterFrameText;
      
      private var _pumpMc:MovieClip;
      
      private var _luckyCountMc:MovieClip;
      
      private var itemList:Vector.<PumpingJoyShowRewardItem>;
      
      private var _timer:Timer;
      
      private var hasMaterialCount:int;
      
      private var sendType:int;
      
      private var isPlayMc:Boolean = false;
      
      public function PumpingJoyFrame()
      {
         super();
         initView();
         initShowListView();
         addEvent();
         PumpingJoyManager.instance.sendPumpRequest(1);
      }
      
      public static function getGoodsName(param1:int) : String
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1).TemplateName;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _leftTime = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00_n12_mfm0");
         _hasCouponText = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00_n6_mfm0");
         _floorNeedText = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00_n5_mfm0");
         _border = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00.border");
         _timeImage = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00.timeImage");
         _tenPumpBtn = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00.tenPumpBtn");
         _onePumpBtn = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00.onePumpBtn");
         _luckyImage = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00.luckyImage");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00.getBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00.shopBtn");
         _pumpBack = ComponentFactory.Instance.creatComponentByStylename("PumpingJoy.mfm00.pumpBack");
         _couponImage = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyPumpingJoyFrame.couponImage");
         _scoreImage = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyFrame.scoreImage");
         _scoreText = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyFrame.scoreText");
         _floorImage = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyFrame.floorImage");
         _activeLeftTime = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyFrame.activeLeftTime");
         _exchangeLeftTime = ComponentFactory.Instance.creatComponentByStylename("PumpingJoyFrame.exchangeLeftTime");
         _lookText = ComponentFactory.Instance.creatComponentByStylename("pumpingjoy.PumpingJoyAwardLook");
         _lookText.htmlText = "<a href=\'event:#\'>" + LanguageMgr.GetTranslation("PumpingJoy.lookAward") + "</a>";
         _pumpMc = ComponentFactory.Instance.creatCustomObject("PumpingJoyFrame.pumpMc");
         _pumpMc.mouseChildren = _pumpMc.mouseEnabled = false;
         _pumpMc.gotoAndStop(1);
         _luckyCountMc = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
         _luckyCountMc.mouseChildren = _luckyCountMc.mouseEnabled = false;
         _luckyCountMc.visible = false;
         _luckyCountMc.x = 245;
         _luckyCountMc.y = 560;
         addToContent(_border);
         addToContent(_pumpBack);
         addToContent(_couponImage);
         addToContent(_hasCouponText);
         addToContent(_timeImage);
         addToContent(_floorNeedText);
         addToContent(_floorImage);
         addToContent(_luckyImage);
         addToContent(_scoreImage);
         addToContent(_scoreText);
         addToContent(_leftTime);
         addToContent(_shopBtn);
         addToContent(_getBtn);
         addToContent(_pumpMc);
         addToContent(_luckyCountMc);
         addToContent(_onePumpBtn);
         addToContent(_tenPumpBtn);
         addToContent(_activeLeftTime);
         addToContent(_exchangeLeftTime);
         addToContent(_lookText);
         _timer = new Timer(1000);
         _timer.start();
         _couponImage.tipData = LanguageMgr.GetTranslation("PumpingJoyPumpingJoyFrame.couponImage.tipdata");
      }
      
      private function initShowListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PumpingJoyShowRewardItem = null;
         itemList = new Vector.<PumpingJoyShowRewardItem>();
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("PumpingJoyFrame.rewardItem");
            addToContent(_loc1_);
            _loc1_.x = int(_loc2_ % 3) * 150 + 70;
            _loc1_.y = int(_loc2_ / 3) * 135 + 90;
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tenPumpBtn.addEventListener("click",_pumpBtnClickHandler);
         _onePumpBtn.addEventListener("click",_pumpBtnClickHandler);
         _getBtn.addEventListener("click",_getBtnClickHandler);
         _shopBtn.addEventListener("click",_shopBtnClickHandler);
         _timer.addEventListener("timer",__timeUpdateHandler);
         _lookText.addEventListener("click",__onLinkHandler);
         MsgMan.addObserver("PUMPING_JOY_MSG_BACK",this,__updatePumpingJoyInfo);
         MsgMan.addObserver("PUMPING_JOY_SHOW_REWARD",this,__rewardChatAlert);
         MsgMan.addObserver("PUMPING_JOY_DRAW_BACK",this,__pumpResultHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_tenPumpBtn)
         {
            _tenPumpBtn.removeEventListener("click",_pumpBtnClickHandler);
         }
         if(_onePumpBtn)
         {
            _onePumpBtn.removeEventListener("click",_pumpBtnClickHandler);
         }
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",_getBtnClickHandler);
         }
         if(_shopBtn)
         {
            _shopBtn.removeEventListener("click",_shopBtnClickHandler);
         }
         if(_timer)
         {
            _timer.removeEventListener("timer",__timeUpdateHandler);
         }
         _lookText.removeEventListener("click",__onLinkHandler);
         MsgMan.removeObserver("PUMPING_JOY_MSG_BACK",this,__updatePumpingJoyInfo);
         MsgMan.removeObserver("PUMPING_JOY_SHOW_REWARD",this,__rewardChatAlert);
         MsgMan.removeObserver("PUMPING_JOY_DRAW_BACK",this,__pumpResultHandler);
      }
      
      private function _shopBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",1012);
      }
      
      private function _getBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         PumpingJoyManager.instance.sendPumpRequest(3);
      }
      
      private function _pumpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:String = null;
         var _loc5_:String = null;
         if(param1.currentTarget is IconButton && param1.currentTarget.stylename == "PumpingJoy.mfm00.onePumpBtn")
         {
            sendType = 1;
            _loc2_ = 1;
            _loc4_ = int(model.oneNeedPoint);
         }
         else if(param1.currentTarget is IconButton && param1.currentTarget.stylename == "PumpingJoy.mfm00.tenPumpBtn")
         {
            sendType = 2;
            _loc2_ = 10;
            _loc4_ = int(model.tenNeedPoint);
         }
         if(hasMaterialCount >= _loc2_ || playerModel.playerInfo.point >= _loc4_)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            if(hasMaterialCount < _loc2_)
            {
               _loc5_ = LanguageMgr.GetTranslation("PumpingJoy.pumpCount.ContentText2",_loc4_,_loc2_);
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("PumpingJoy.pumpCount.ContentText1",_loc4_,_loc2_,hasMaterialCount);
            }
            SharedManagerHelper.ins.needAlert("PumpingJoy.pumpCount.alertText" + sendType,pumpResultHandler,_loc3_,_loc5_);
         }
         else
         {
            RechargeAlertMannager.show();
         }
      }
      
      private function pumpResultHandler() : void
      {
         PumpingJoyManager.instance.sendPumpRequest(2,sendType);
      }
      
      private function __timeUpdateHandler(param1:TimerEvent) : void
      {
         refreshTimeView();
      }
      
      private function __updatePumpingJoyInfo(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __pumpResultHandler(param1:String, param2:Object) : void
      {
         var _loc3_:Array = param2 as Array;
         if(_pumpMc)
         {
            _pumpMc.gotoAndPlay(1);
         }
         isPlayMc = true;
         this.closeButton.enable = false;
         _tenPumpBtn.enable = false;
         _onePumpBtn.enable = false;
         TweenMax.to(_pumpMc,1.8,{
            "frame":_pumpMc.totalFrames - 1,
            "onComplete":movieOverHandler,
            "onCompleteParams":[_loc3_]
         });
      }
      
      private function movieOverHandler(param1:Array) : void
      {
         if(!isDie)
         {
            isPlayMc = false;
            this.closeButton.enable = true;
            _tenPumpBtn.enable = model.isCanJoy;
            _onePumpBtn.enable = model.isCanJoy;
         }
         if(_pumpMc)
         {
            _pumpMc.gotoAndStop(1);
         }
         FrameControllerManager.instance.openControllerByInfo("pumpingjoy","REWARD_FRAME",param1);
      }
      
      private function __rewardChatAlert(param1:String, param2:Object) : void
      {
         var _loc3_:int = param2 as int;
         showChatReward(_loc3_);
      }
      
      private function __onLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:PumpingJoyDropFrame = ComponentFactory.Instance.creatComponentByStylename("pumpingjoy.PumpingJoyDropFrame");
         _loc2_.show();
      }
      
      private function refreshView() : void
      {
         _floorNeedText.text = model.floorNeedPumps + "";
         _scoreText.text = model.totalScore + "";
         hasMaterialCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208068);
         _hasCouponText.text = hasMaterialCount + "";
         refreshReward();
         refreshTimeView();
      }
      
      private function refreshReward() : void
      {
         var _loc5_:int = 0;
         var _loc3_:PumpingJoyShowRewardItem = null;
         var _loc2_:Array = model.getShowListByType(1);
         var _loc4_:int = int(_loc2_.length);
         _loc5_ = 0;
         while(_loc5_ < itemList.length)
         {
            _loc3_ = itemList[_loc5_];
            _loc3_.data = _loc5_ < _loc4_ ? _loc2_[_loc5_] : null;
            _loc5_++;
         }
         var _loc8_:Array = model.getShowListByType(2);
         var _loc6_:String = LanguageMgr.GetTranslation("PumpingJoyFrame.luckyImage.tipData") + "\n";
         var _loc9_:String = LanguageMgr.GetTranslation("PumpingJoyFrame.luckyImage.leftLuckyAlert",model.luckyLeftCount);
         _luckyImage.tipData = _loc6_ + GoodsHelp.getRewardDesc(_loc8_) + "\n" + _loc9_;
         var _loc7_:Array = model.getShowListByType(3);
         var _loc1_:String = LanguageMgr.GetTranslation("PumpingJoyFrame.floorImage.tipData") + "\n";
         _floorImage.tipData = _loc1_ + GoodsHelp.getRewardDesc(_loc7_);
      }
      
      private function refreshTimeView() : void
      {
         if(model.curLuckyInfo)
         {
            _leftTime.text = DateFormatter.getCountDateByMS(model.curLuckyInfo.leftTime);
            _getBtn.enable = true;
            _luckyCountMc.visible = true;
            _luckyCountMc.txt.text = model.luckyNum;
         }
         else
         {
            _leftTime.text = "";
            _getBtn.enable = false;
            _luckyCountMc.visible = false;
         }
         _onePumpBtn.enable = _tenPumpBtn.enable = !isPlayMc && Boolean(model.isCanJoy);
         if(model.endDateNum > playerModel.sysCurTimeBySecond)
         {
            if(model.endDateNum - playerModel.sysCurTimeBySecond < 60)
            {
               _activeLeftTime.text = DateFormatter.getDefaultFullDateString(model.endDateNum - playerModel.sysCurTimeBySecond);
            }
            else
            {
               _activeLeftTime.text = DateFormatter.getStopDateString(model.endDateNum - playerModel.sysCurTimeBySecond);
            }
         }
         else
         {
            _activeLeftTime.text = LanguageMgr.GetTranslation("warlords.WarlordsBetFrame.str02");
         }
         if(model.exchangeEndDateNum > playerModel.sysCurTimeBySecond)
         {
            if(model.exchangeEndDateNum - playerModel.sysCurTimeBySecond < 60)
            {
               _exchangeLeftTime.text = DateFormatter.getDefaultFullDateString(model.exchangeEndDateNum - playerModel.sysCurTimeBySecond);
            }
            else
            {
               _exchangeLeftTime.text = DateFormatter.getStopDateString(model.exchangeEndDateNum - playerModel.sysCurTimeBySecond);
            }
         }
         else
         {
            _exchangeLeftTime.text = LanguageMgr.GetTranslation("warlords.WarlordsBetFrame.str02");
         }
      }
      
      private function showChatReward(param1:int) : void
      {
         var _loc3_:String = getChatContent(param1);
         if(_loc3_ == null || _loc3_ == "")
         {
            return;
         }
         var _loc2_:ChatData = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc2_)
         {
            _loc2_.channel = 3;
            _loc2_.msg = _loc3_;
            _loc2_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc2_);
         }
      }
      
      private function getChatContent(param1:int) : String
      {
         var _loc2_:PumpingJoyRewardInfo = model.getRewardInfoById(param1);
         if(!_loc2_)
         {
            return "";
         }
         var _loc3_:int = _loc2_.profile == 3 ? 1 : 0;
         var _loc4_:String = LanguageMgr.GetTranslation("PumpingJoyFrame.reward.chatContent" + _loc3_);
         return _loc4_ + (getGoodsName(_loc2_.tempId) + "x" + _loc2_.count + "," + LanguageMgr.GetTranslation("PumpingJoyFrame.reward.scoreAdd",_loc2_.rewardScore));
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_pumpingjoy");
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function get model() : PumpingJoyModel
      {
         return PumpingJoyManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timeUpdateHandler);
            _timer = null;
         }
         ObjectUtils.disposeObject(_leftTime);
         _leftTime = null;
         ObjectUtils.disposeObject(_hasCouponText);
         _hasCouponText = null;
         ObjectUtils.disposeObject(_floorNeedText);
         _floorNeedText = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_timeImage);
         _timeImage = null;
         ObjectUtils.disposeObject(_tenPumpBtn);
         _tenPumpBtn = null;
         ObjectUtils.disposeObject(_onePumpBtn);
         _onePumpBtn = null;
         ObjectUtils.disposeObject(_luckyImage);
         _luckyImage = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_pumpBack);
         _pumpBack = null;
         ObjectUtils.disposeObject(_activeLeftTime);
         _activeLeftTime = null;
         ObjectUtils.disposeObject(_exchangeLeftTime);
         _exchangeLeftTime = null;
         ObjectUtils.disposeObject(_floorImage);
         _floorImage = null;
         ObjectUtils.disposeObject(_scoreImage);
         _scoreImage = null;
         ObjectUtils.disposeObject(_scoreText);
         _scoreText = null;
         ObjectUtils.disposeViolentMc(_luckyCountMc);
         _luckyCountMc = null;
         ObjectUtils.disposeObject(_couponImage);
         _couponImage = null;
         ObjectUtils.disposeObject(_lookText);
         _lookText = null;
         ObjectUtils.disposeViolentMc(_pumpMc);
         _pumpMc = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

