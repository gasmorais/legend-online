package vehicle.daimontrial.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.controler.VehicleDaimonTrialController;
   import vehicle.VehicleEventII;
   import vehicle.daimontrial.DaimonRoomSearchFrame;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.BaseManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.component.MovieButton;
   import yishi.view.tips.MessageTipManager;
   
   public class DaimonTrialBottomView extends Component
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _btnBg:Bitmap;
      
      private var _line:Bitmap;
      
      private var _descTxt01:FilterFrameText;
      
      private var _descTxt02:FilterFrameText;
      
      private var _createBtn:IconButton;
      
      private var _findBtn:IconButton;
      
      private var _startBtn:MovieButton;
      
      private var _cancelBtn:MovieButton;
      
      private var _searchFrame:DaimonRoomSearchFrame;
      
      private var _controller:VehicleDaimonTrialController;
      
      private var _timer:Timer;
      
      private var _timeNumber:int;
      
      private var _timeTxt:GradientText;
      
      private var _sprite:Component;
      
      private var _countBmp:Bitmap;
      
      private var _playerInfo:PlayerInfo;
      
      private var _lastClickTime:Number = 0;
      
      public function DaimonTrialBottomView()
      {
         super();
         _controller = FrameControllerManager.instance.vehicleDaimonTrailController;
         _playerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         initView();
         addEvent();
         __daimonTrialStartHandler();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("daimonFrame.describeBackground_style02");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialLeftView.CreateBtn");
         _findBtn = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialLeftView.FindBtn");
         _descTxt01 = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialBottomView.DescTxt");
         _descTxt02 = ComponentFactory.Instance.creatComponentByStylename("DaimonTrialBottomView.DescTxt2");
         _startBtn = ComponentFactory.Instance.creatCustomObject("DaimonTrial.StartBtn");
         _cancelBtn = ComponentFactory.Instance.creatCustomObject("DaimonTrial.CancelBtn");
         _btnBg = ComponentFactory.Instance.creatBitmap("asset.daimontrial.StartBtnBg");
         _line = ComponentFactory.Instance.creatBitmap("asset.daimontrial.Line");
         addChild(_bg);
         addChild(_line);
         addChild(_descTxt01);
         addChild(_descTxt02);
         addChild(_btnBg);
         addChild(_createBtn);
         addChild(_findBtn);
         addChild(_startBtn);
         addChild(_cancelBtn);
         _cancelBtn.visible = false;
         _createBtn.delayClickTime = 3000;
         _descTxt01.htmlText = LanguageMgr.GetTranslation("vehicle.helpText01");
         _descTxt02.htmlText = LanguageMgr.GetTranslation("vehicle.helpText02");
         _timer = new Timer(1000);
         _timer.stop();
         _sprite = new Component();
         _sprite.x = 0;
         _sprite.y = -238;
         _sprite.graphics.beginFill(0,0.4);
         _sprite.graphics.drawRect(0,0,575,240);
         _sprite.graphics.endFill();
         _countBmp = ComponentFactory.Instance.creatBitmap("asset.daimontrial.CountTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("VehicleRoom.timeTxt");
         _sprite.addChild(_countBmp);
         _sprite.addChild(_timeTxt);
      }
      
      private function uintView() : void
      {
         _bg = null;
         _createBtn = null;
         _findBtn = null;
         _descTxt01 = null;
         _descTxt02 = null;
         if(_timer)
         {
            _timer.stop();
         }
         _timeTxt = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
      }
      
      private function addEvent() : void
      {
         _createBtn.addEventListener("click",__createBtnClickHandler);
         _findBtn.addEventListener("click",__findBtnClickHandler);
         _startBtn.addEventListener("click",__startClickHandler);
         _cancelBtn.addEventListener("click",__cancelClickHandler);
         _timer.addEventListener("timer",__onTimerHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4525,__startCountHandler);
         _playerInfo.addEventListener("VEHICLESTART",__daimonTrialStartHandler);
      }
      
      private function removeEvent() : void
      {
         _createBtn.removeEventListener("click",__createBtnClickHandler);
         _findBtn.removeEventListener("click",__findBtnClickHandler);
         _startBtn.removeEventListener("click",__startClickHandler);
         _cancelBtn.removeEventListener("click",__cancelClickHandler);
         _timer.removeEventListener("timer",__onTimerHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4525,__startCountHandler);
         _playerInfo.removeEventListener("VEHICLESTART",__daimonTrialStartHandler);
      }
      
      private function __createBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _controller.createRoom();
      }
      
      private function __findBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_searchFrame)
         {
            _searchFrame.dispose();
            _searchFrame = null;
         }
         _searchFrame = ComponentFactory.Instance.creatComponentByStylename("daimontrial.DaimonRoomSearchFrame");
         _searchFrame.show();
      }
      
      private function __startClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         var _loc3_:Number = getTimer();
         if(_loc3_ - _lastClickTime < 5000)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         _lastClickTime = _loc3_;
         _controller.quickStart();
      }
      
      private function __cancelClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         _controller.cancelStart();
         _cancelBtn.visible = false;
         _startBtn.visible = true;
         _createBtn.enable = true;
         _findBtn.enable = true;
         _timer.stop();
         if(_sprite.parent)
         {
            _sprite.parent.removeChild(_sprite);
         }
         dispatchEvent(new VehicleEventII("SINGLE_CANCLE"));
         __daimonTrialStartHandler();
      }
      
      private function __onTimerHandler(param1:TimerEvent = null) : void
      {
         var _loc2_:String = null;
         _timeNumber = _timeNumber + 1;
         _loc2_ = String(int(_timeNumber / 60) > 9 ? int(_timeNumber / 60) : "0" + int(_timeNumber / 60));
         _loc2_ += ":" + (String(int(_timeNumber % 60) > 9 ? int(_timeNumber % 60) : "0" + int(_timeNumber % 60)));
         _timeTxt.text = _loc2_;
      }
      
      private function __startCountHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 1)
         {
            _cancelBtn.visible = true;
            _startBtn.visible = false;
            _createBtn.enable = false;
            _findBtn.enable = false;
            _timeNumber = 0;
            _timer.start();
            __onTimerHandler();
            addChild(_sprite);
            dispatchEvent(new VehicleEventII("SINGLE_START"));
            BaseManager.instance.existRoomInvate = true;
         }
      }
      
      private function __daimonTrialStartHandler(param1:PlayerEvent = null) : void
      {
         if(_startBtn)
         {
            _startBtn.enable = _playerInfo.isVehicleStart;
         }
         if(_findBtn)
         {
            _findBtn.enable = _playerInfo.isVehicleStart;
         }
         if(_createBtn)
         {
            _createBtn.enable = _playerInfo.isVehicleStart;
         }
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         BaseManager.instance.existRoomInvate = false;
         if(_cancelBtn.visible)
         {
            _controller.cancelStart();
         }
         removeEvent();
         uintView();
         if(_searchFrame)
         {
            _searchFrame.dispose();
            _searchFrame = null;
         }
         _controller = null;
         super.dispose();
      }
   }
}

