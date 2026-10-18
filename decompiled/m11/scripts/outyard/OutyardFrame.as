package outyard
{
   import battle.utils.Int64Utils;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.HugeHeadOpenTimeMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import com.road.yishi.proto.hugehead.StackHeadSelfMsg;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import map.campaign.data.OutyardForceInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardFrame extends Frame implements IManualSize
   {
      
      private var _back:DisplayObject;
      
      private var _bg:DisplayObject;
      
      private var _shopBtn:IconButton;
      
      private var _inputBgBmp:ScaleBitmapImage;
      
      private var _fightPlayerBtn:IconButton;
      
      private var _executionBmp:DisplayObject;
      
      private var _executionValueTxt:FilterFrameText;
      
      private var _lastAttackTxt:FilterFrameText;
      
      private var _bottomAttackNoteTxt:FilterFrameText;
      
      private var _bottomDefenceNoteTxt:FilterFrameText;
      
      private var _bottomAttackValueTxt:FilterFrameText;
      
      private var _bottomDefenceValueTxt:FilterFrameText;
      
      private var _openingView:OutyardOpeningView;
      
      private var _noticeView:OutyardNoticeView;
      
      private var _figureView:OutyardFigureView;
      
      private var _actorContain:Sprite;
      
      private var _executionStrip:StripView;
      
      private var _addExecutionBtn:BaseButton;
      
      private var _actorList:Array = [];
      
      private var _figurePos:Array = [[1,113],[312,84],[342,346],[11,385]];
      
      private var _timer:Timer;
      
      private var _maxLimit:int;
      
      private var _recoverSpeed:int;
      
      private var _usePoint:int;
      
      public function OutyardFrame()
      {
         super();
         initView();
         addEvent();
         OutyardManager.instance.OperateMapOutyard(1);
         OutyardManager.instance.OperateOutyard(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,853,645);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:OutyardActorView = null;
         var _loc3_:int = 0;
         titleText = LanguageMgr.GetTranslation("outyard.OutyardFrame.titleText");
         _back = ComponentFactory.Instance.creatBitmap("asset.outyard.back");
         _bg = ComponentFactory.Instance.creatBitmap("asset.outyard.bg");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.shopBtn");
         _inputBgBmp = ComponentFactory.Instance.creatComponentByStylename("outyard.inputBgBmp");
         _fightPlayerBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.fightPlayerBtn");
         _executionBmp = ComponentFactory.Instance.creatBitmap("asset.outyard.executionBmp");
         _executionValueTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardFrame.executionValueTxt");
         _lastAttackTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardFrame.lastAttackTxt");
         _bottomAttackNoteTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardFrame.bottomAttackNoteTxt");
         _bottomDefenceNoteTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardFrame.bottomDefenceNoteTxt");
         _bottomAttackValueTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardFrame.bottomAttackValueTxt");
         _bottomDefenceValueTxt = ComponentFactory.Instance.creatComponentByStylename("outyard.OutyardFrame.bottomDefenceValueTxt");
         _openingView = ComponentFactory.Instance.creatCustomObject("outyard.OutyardOpeningView");
         _noticeView = ComponentFactory.Instance.creatCustomObject("outyard.OutyardNoticeView");
         _figureView = ComponentFactory.Instance.creatCustomObject("outyard.OutyardFigureView");
         _actorContain = ComponentFactory.Instance.creatCustomObject("outyard.OutyardFrame.actorContain");
         _executionStrip = ComponentFactory.Instance.creatCustomObject("outyard.executionStrip");
         _addExecutionBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.addExecutionBtn");
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("outyard.OutyardActorView");
            _loc2_.x = _figurePos[_loc3_][0];
            _loc2_.y = _figurePos[_loc3_][1];
            _actorContain.addChild(_loc2_);
            _actorList.push(_loc2_);
            _loc3_++;
         }
         addToContent(_back);
         addToContent(_bg);
         addToContent(_openingView);
         addToContent(_noticeView);
         addToContent(_figureView);
         addToContent(_actorContain);
         addToContent(_shopBtn);
         addToContent(_inputBgBmp);
         addToContent(_fightPlayerBtn);
         addToContent(_executionBmp);
         addToContent(_executionValueTxt);
         addToContent(_lastAttackTxt);
         addToContent(_bottomAttackNoteTxt);
         addToContent(_bottomDefenceNoteTxt);
         addToContent(_bottomAttackValueTxt);
         addToContent(_bottomDefenceValueTxt);
         addToContent(_executionStrip);
         addToContent(_addExecutionBtn);
         _bottomAttackNoteTxt.text = LanguageMgr.GetTranslation("outyard.OutyardFrame.bottomAttackNoteTxt");
         _bottomDefenceNoteTxt.text = LanguageMgr.GetTranslation("outyard.OutyardFrame.bottomDefenceNoteTxt");
         var _loc4_:Array = ConfigInfoManager.instance.getStackHeadActionPoint();
         var _loc1_:String = "";
         if(thane.grades >= 1 && thane.grades <= 79)
         {
            _loc1_ = _loc4_[0];
         }
         else if(thane.grades == 80)
         {
            if(ArmyManager.instance.thane.vocationGrades <= 0)
            {
               _loc1_ = _loc4_[1];
            }
            else
            {
               _loc1_ = _loc4_[2];
            }
         }
         _maxLimit = _loc1_.split(",")[0];
         _recoverSpeed = _loc1_.split(",")[1];
         _usePoint = ConfigInfoManager.instance.getStackHeadChargePoint();
         _executionStrip.setHitArea(0,0,72,32);
         _executionStrip.tipData = LanguageMgr.GetTranslation("outyard.OutyardFrame.limitExecutionTxt",_maxLimit,_recoverSpeed);
         _timer = new Timer(20000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _shopBtn.addEventListener("click",__shopBtnHandler);
         _fightPlayerBtn.addEventListener("click",__fightPlayerBtnHandler);
         _addExecutionBtn.addEventListener("click",__addExecutionBtnHandler);
         NotificationManager.instance.addEventListener("OUTYARD_FULL_INFO",__refreshActorContain);
         NotificationManager.instance.addEventListener("OUTYARD_UPDATE_INFO",__refreshActorContain);
         NotificationManager.instance.addEventListener("OUTYARD_SELF_INFO",__selfInfoHandler);
         NotificationManager.instance.addEventListener("OUTYARD_STATE_INFO",__stateInfoHandler);
         NotificationManager.instance.addEventListener("OUTYARD_CHANNEL_CHANGE",__outyardChannelHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _shopBtn.removeEventListener("click",__shopBtnHandler);
         _fightPlayerBtn.removeEventListener("click",__fightPlayerBtnHandler);
         _addExecutionBtn.removeEventListener("click",__addExecutionBtnHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_FULL_INFO",__refreshActorContain);
         NotificationManager.instance.removeEventListener("OUTYARD_UPDATE_INFO",__refreshActorContain);
         NotificationManager.instance.removeEventListener("OUTYARD_SELF_INFO",__selfInfoHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_STATE_INFO",__stateInfoHandler);
         NotificationManager.instance.removeEventListener("OUTYARD_CHANNEL_CHANGE",__outyardChannelHandler);
         _timer.stop();
         _timer.removeEventListener("timer",__timerHandler);
         _timer = null;
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         OutyardManager.instance.OperateOutyard(2);
         refrshState();
      }
      
      private function __shopBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",1004);
      }
      
      private function __fightPlayerBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("outyard",1);
      }
      
      private function __addExecutionBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         var _loc4_:StackHeadSelfMsg = OutyardManager.instance.crystalModel.selfMsg;
         if(_loc4_.actionPoint >= _maxLimit)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.OutyardFrame.limitCannotBuy"));
            return;
         }
         if(_usePoint > PlayerManager.instance.currentPlayerModel.playerInfo.point)
         {
            RechargeAlertMannager.show();
            return;
         }
         SimpleAlertHelper.instance.data = [__alertOutyardHandler];
         _loc2_ = LanguageMgr.GetTranslation("public.confirm");
         _loc3_ = LanguageMgr.GetTranslation("public.cancel");
         _loc5_ = LanguageMgr.GetTranslation("public.prompt");
         _loc6_ = LanguageMgr.GetTranslation("outyard.OutyardFrame.addExecutionTxt",_usePoint,_maxLimit);
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true);
      }
      
      private function __alertOutyardHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            OutyardManager.instance.OperateOutyard(10);
         }
      }
      
      private function __refreshActorContain(param1:NotificationEvent) : void
      {
         var _loc4_:OutyardActorView = null;
         var _loc8_:int = 0;
         var _loc9_:OutyardForceInfo = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:Array = OutyardManager.instance.crystalModel.forceArr;
         var _loc5_:OutyardForceInfo = OutyardManager.instance.crystalModel.myForce;
         if(!_loc3_ || !_loc5_)
         {
            return;
         }
         _loc3_.sortOn("score",16);
         var _loc10_:int = int(_loc3_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc9_ = _loc3_[_loc6_] as OutyardForceInfo;
            if(_loc9_.score != _loc8_)
            {
               _loc8_ = int(_loc9_.score);
               _loc10_ = _loc3_.length - _loc6_;
            }
            _loc9_.order = _loc10_;
            _loc6_++;
         }
         _loc3_.sortOn("forceIndex",16);
         _loc7_ = 0;
         while(_loc7_ < _actorList.length)
         {
            _loc4_ = _actorList[_loc7_] as OutyardActorView;
            _loc4_.data = _loc3_[_loc7_];
            _loc7_++;
         }
         var _loc11_:Array = ConfigInfoManager.instance.getStackHeadAttackBuff();
         var _loc2_:Array = ConfigInfoManager.instance.getStackHeadDefenceBuff();
         _bottomAttackValueTxt.text = "" + int(_loc5_.attackBuffLevel * _loc11_[1]) + "%";
         _bottomDefenceValueTxt.text = "" + int(_loc5_.defenceBuffLevel * _loc2_[1]) + "%";
         _bottomAttackValueTxt.x = _bottomAttackNoteTxt.x + _bottomAttackNoteTxt.textWidth + 10;
         _bottomDefenceValueTxt.x = _bottomDefenceNoteTxt.x + _bottomDefenceNoteTxt.textWidth + 10;
         refrshState();
      }
      
      private function __selfInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:StackHeadSelfMsg = OutyardManager.instance.crystalModel.selfMsg;
         _executionValueTxt.text = "" + _loc2_.actionPoint;
      }
      
      private function __stateInfoHandler(param1:NotificationEvent) : void
      {
         var _loc2_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         if(_loc2_.stackHeadState == 0 || _loc2_.stackHeadState == 1)
         {
            dispose();
         }
      }
      
      private function __outyardChannelHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function refrshState() : void
      {
         var _loc3_:HugeHeadOpenTimeMsg = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         _lastAttackTxt.visible = false;
         var _loc1_:Array = ConfigInfoManager.instance.getStackHeadWeekUnion();
         var _loc2_:HugeHeadStateMsg = OutyardManager.instance.model.stateMsg;
         if(_loc2_.stackHeadState == 2)
         {
            _loc3_ = _loc2_.stackHeadOpenTime[_loc2_.stackHeadSession - 1] as HugeHeadOpenTimeMsg;
            _loc4_ = Int64Utils.int64ToNumber(_loc3_.startTime) / 1000 - PlayerManager.instance.currentPlayerModel.sysSecond;
            _loc5_ = DateFormatter.getStopDateString(_loc4_);
            _lastAttackTxt.htmlText = LanguageMgr.GetTranslation("outyard.OutyardFrame.intervalTime",_loc5_);
            if(_loc4_ <= 60)
            {
               _lastAttackTxt.htmlText = LanguageMgr.GetTranslation("outyard.OutyardFrame.intervalTime1");
            }
            _lastAttackTxt.visible = true;
         }
         else if(_loc2_.stackHeadState == 3)
         {
            _lastAttackTxt.htmlText = LanguageMgr.GetTranslation("outyard.OutyardFrame.carryOut");
            _lastAttackTxt.visible = true;
            if(OutyardManager.instance.crystalModel.weekUnion)
            {
               _lastAttackTxt.htmlText = LanguageMgr.GetTranslation("outyard.OutyardFrame.lastAttackTxt",LanguageMgr.GetTranslation("outyard.scene.OutyardInfoView.forceName" + OutyardManager.instance.crystalModel.weekUnion),_loc1_[1]);
            }
         }
         else if(_loc2_.stackHeadState == 5)
         {
            _lastAttackTxt.htmlText = LanguageMgr.GetTranslation("outyard.OutyardFrame.carryOutOver");
            _lastAttackTxt.visible = true;
         }
         else
         {
            _lastAttackTxt.htmlText = "";
         }
         _lastAttackTxt.y = 20 - (_lastAttackTxt.numLines - 1) * 10;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_inputBgBmp);
         _inputBgBmp = null;
         ObjectUtils.disposeObject(_fightPlayerBtn);
         _fightPlayerBtn = null;
         ObjectUtils.disposeObject(_executionBmp);
         _executionBmp = null;
         ObjectUtils.disposeObject(_executionValueTxt);
         _executionValueTxt = null;
         ObjectUtils.disposeObject(_lastAttackTxt);
         _lastAttackTxt = null;
         ObjectUtils.disposeObject(_bottomAttackNoteTxt);
         _bottomAttackNoteTxt = null;
         ObjectUtils.disposeObject(_bottomDefenceNoteTxt);
         _bottomDefenceNoteTxt = null;
         ObjectUtils.disposeObject(_bottomAttackValueTxt);
         _bottomAttackValueTxt = null;
         ObjectUtils.disposeObject(_bottomDefenceValueTxt);
         _bottomDefenceValueTxt = null;
         ObjectUtils.disposeObject(_openingView);
         _openingView = null;
         ObjectUtils.disposeObject(_noticeView);
         _noticeView = null;
         ObjectUtils.disposeObject(_figureView);
         _figureView = null;
         if(_actorList)
         {
            while(_actorList.length)
            {
               ObjectUtils.disposeObject(_actorList.pop());
            }
         }
         _actorList = null;
         ObjectUtils.disposeObject(_actorContain);
         _actorContain = null;
         super.dispose();
      }
   }
}

