package outyard.event
{
   import battle.utils.Int64Utils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.hugehead.HugeHeadActiveMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import mvc.module.outyard.LandPoint;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.tips.MessageTipManager;
   
   public class OutyardEventRightView extends Component
   {
      
      private var _data:HugeHeadActiveMsg;
      
      private var _titleComponent:Component;
      
      private var _rightViewBg:Bitmap;
      
      private var _gap:MutipleImage;
      
      private var _rightViewBg1:Bitmap;
      
      private var _rightViewNote2:Bitmap;
      
      private var _rightViewNote1:Bitmap;
      
      private var _rightEnterBtn:IconButton;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _activityText:FilterFrameText;
      
      private var _openText:FilterFrameText;
      
      private var _desText:FilterFrameText;
      
      private var _timer:Timer;
      
      private var date:Date = new Date();
      
      public function OutyardEventRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _titleComponent = ComponentFactory.Instance.creatCustomObject("outyardEvent.titleComponent");
         _rightViewBg = ComponentFactory.Instance.creatBitmap("asset.outyard.rightViewBg");
         _gap = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.hgap");
         _rightViewBg1 = ComponentFactory.Instance.creatBitmap("asset.outyard.rightViewBg1");
         _rightViewNote2 = ComponentFactory.Instance.creatBitmap("asset.outyard.rightViewNote2");
         _rightViewNote1 = ComponentFactory.Instance.creatBitmap("asset.outyard.rightViewNote1");
         _rightEnterBtn = ComponentFactory.Instance.creatComponentByStylename("outyard.rightEnterBtn");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.serverTimeText");
         _activityText = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.activityText");
         _openText = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.openText");
         _desText = ComponentFactory.Instance.creatComponentByStylename("outyardEventFrame.desText");
         addChild(_titleComponent);
         addChild(_gap);
         addChild(_rightViewBg);
         addChild(_rightViewBg1);
         addChild(_rightViewNote2);
         addChild(_rightViewNote1);
         addChild(_rightEnterBtn);
         addChild(_remainTimeText);
         addChild(_activityText);
         addChild(_openText);
         addChild(_desText);
      }
      
      private function initEvent() : void
      {
         _rightEnterBtn.addEventListener("click",__enterClickHandler);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
         __timerHandler(null);
      }
      
      private function removeEvent() : void
      {
         _rightEnterBtn.removeEventListener("click",__enterClickHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      public function set data(param1:HugeHeadActiveMsg) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         _data = param1;
         ObjectUtils.disposeAllChildren(_titleComponent);
         var _loc5_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.outyard.rightTitle" + param1.type);
         _titleComponent.addChild(_loc5_);
         _rightEnterBtn.visible = false;
         var _loc8_:Number = 86400000;
         var _loc7_:Date = DateFormatter.parse(param1.date + " 00:00:00","YYYY-MM-DD hh:mm:ss");
         var _loc3_:Date = new Date();
         _loc3_.time = _loc7_.time + (7 * _loc8_ - 1);
         var _loc6_:Array = [];
         switch(int(_data.type) - 1)
         {
            case 0:
               _activityText.text = DateFormatter.timeFormat3(_loc7_) + "~" + DateFormatter.timeFormat3(_loc3_);
               _openText.text = getTimeStr(ConfigInfoManager.instance.getHugeHeadOpenTime());
               _loc4_ = int(OutyardManager.instance.model.getActiveRateByType(1));
               _desText.htmlText = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.desTxt" + param1.type,100 - _loc4_);
               break;
            case 1:
               _activityText.text = DateFormatter.timeFormat3(_loc7_) + "~" + DateFormatter.timeFormat3(_loc3_);
               _openText.text = getTimeStr(ConfigInfoManager.instance.getHugeHeadOpenTime());
               _desText.htmlText = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.desTxt" + param1.type,param1.effect);
               break;
            case 2:
               _activityText.text = DateFormatter.timeFormat3(_loc7_) + "~" + DateFormatter.timeFormat3(_loc3_) + " " + LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.allDayTime");
               _openText.text = "";
               _loc2_ = int(OutyardManager.instance.model.getActiveRateByType(3));
               _desText.htmlText = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.desTxt" + param1.type,100 - _loc2_);
               break;
            case 3:
               _activityText.text = "";
               _openText.text = getTimeStr(ConfigInfoManager.instance.getStackHeadOpenTime());
               _desText.htmlText = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.desTxt" + param1.type);
               break;
            case 4:
               _activityText.text = "";
               _openText.text = getTimeStr(ConfigInfoManager.instance.getHugeHeadOpenTime());
               _desText.htmlText = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.desTxt" + param1.type);
               break;
            case 5:
               _activityText.text = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.allDayTime");
               _openText.text = "";
               _desText.htmlText = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.desTxt" + param1.type);
               break;
            case 6:
               _activityText.text = "";
               _openText.text = getTimeStr(ConfigInfoManager.instance.getTitanOpenTime());
               _desText.htmlText = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.desTxt" + param1.type);
         }
      }
      
      private function getTimeStr(param1:Array) : String
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = String(param1[_loc3_]).split("-");
            _loc4_ += _loc2_[0] + "~" + _loc2_[1] + "  ";
            _loc3_++;
         }
         return _loc4_;
      }
      
      private function __enterClickHandler(param1:Event) : void
      {
         var _loc2_:HugeHeadStateMsg = null;
         var _loc8_:Number = NaN;
         var _loc3_:Date = null;
         var _loc5_:String = null;
         var _loc7_:LandPoint = null;
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         SoundManager.instance.play("022");
         switch(int(_data.type) - 1)
         {
            case 0:
               _loc2_ = OutyardManager.instance.model.stateMsg;
               if(!_loc2_.stackHeadState)
               {
                  _loc8_ = Number(_loc2_.stackHeadNextOpenTime[0] ? Int64Utils.int64ToNumber(_loc2_.stackHeadNextOpenTime[0].startTime) : 0);
                  _loc3_ = new Date(_loc8_);
                  _loc5_ = DateFormatter.timeFormat1(_loc3_);
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("outyard.TopToolsBar.nextOpenDate",_loc5_));
               }
               else
               {
                  FrameControllerManager.instance.openControllerByInfo("outyard");
               }
               break;
            case 1:
               break;
            case 2:
            case 5:
               _loc7_ = new LandPoint();
               _loc4_ = [601,602,603,604];
               _loc6_ = Math.random() * 3;
               _loc7_.id = _loc4_[_loc6_];
               NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_LAND_NODE",_loc7_));
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         date.time = playerModel.sysCurTimeBySecond * 1000;
         var _loc2_:String = DateFormatter.timeFormat4(date);
         _remainTimeText.text = LanguageMgr.GetTranslation("outyard.event.OutyardEventRightView.serverTime",_loc2_);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_titleComponent);
         _titleComponent = null;
         ObjectUtils.disposeObject(_rightViewBg);
         _rightViewBg = null;
         ObjectUtils.disposeObject(_gap);
         _gap = null;
         ObjectUtils.disposeObject(_rightViewBg1);
         _rightViewBg1 = null;
         ObjectUtils.disposeObject(_rightViewNote2);
         _rightViewNote2 = null;
         ObjectUtils.disposeObject(_rightViewNote1);
         _rightViewNote1 = null;
         ObjectUtils.disposeObject(_rightEnterBtn);
         _rightEnterBtn = null;
         ObjectUtils.disposeObject(_remainTimeText);
         _remainTimeText = null;
         ObjectUtils.disposeObject(_activityText);
         _activityText = null;
         ObjectUtils.disposeObject(_openText);
         _openText = null;
         ObjectUtils.disposeObject(_desText);
         _desText = null;
         _data = null;
         super.dispose();
      }
   }
}

