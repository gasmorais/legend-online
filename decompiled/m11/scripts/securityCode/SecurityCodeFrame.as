package securityCode
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.SocketSecurityCodeMessageManager;
   import mvc.module.securitycode.SecrityCodeModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.NumberViewUtils;
   
   public class SecurityCodeFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _canvas:Sprite;
      
      private var _alertTxt:FilterFrameText;
      
      private var _expTxt:FilterFrameText;
      
      private var _expValue:FilterFrameText;
      
      private var _expIcon:Bitmap;
      
      private var _timeBack:MutipleImage;
      
      private var _timeNumBitMap:Bitmap;
      
      private var _timeContainer:Sprite;
      
      private var _remainCountTxt:FilterFrameText;
      
      private var _tipTxt:FilterFrameText;
      
      private var _confirmBtn:IconButton;
      
      private var _timer:Timer;
      
      private var _count:int;
      
      private var _imgList:Vector.<SecurityCodeItem> = new Vector.<SecurityCodeItem>();
      
      public function SecurityCodeFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get model() : SecrityCodeModel
      {
         return FrameControllerManager.instance.securityCodeController.model;
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:SecurityCodeItem = null;
         var _loc5_:* = 0;
         var _loc4_:int = 0;
         _back = ComponentFactory.Instance.creatComponentByStylename("securitycode.rightBackground");
         _canvas = ComponentFactory.Instance.creatCustomObject("securitycode.Canvas");
         _alertTxt = ComponentFactory.Instance.creatComponentByStylename("securitycode.AlertTxt");
         _expTxt = ComponentFactory.Instance.creatComponentByStylename("securitycode.ExpTxt");
         _expValue = ComponentFactory.Instance.creatComponentByStylename("securitycode.ExpValueTxt");
         _expIcon = ComponentFactory.Instance.creatBitmap("asset.securitycode.ExpImg");
         _timeNumBitMap = ComponentFactory.Instance.creatBitmap("asset.securitycode.Numer");
         _timeBack = ComponentFactory.Instance.creatComponentByStylename("securitycode.TimeBack");
         _timeContainer = ComponentFactory.Instance.creatCustomObject("securitycode.TimeContainer");
         _remainCountTxt = ComponentFactory.Instance.creatComponentByStylename("securityCode.remainCountTxt");
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("securityCode.tipTxt");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("securitycode.ConfirmBtn");
         addToContent(_back);
         addToContent(_canvas);
         addToContent(_alertTxt);
         addToContent(_expTxt);
         addToContent(_expValue);
         addToContent(_expIcon);
         addToContent(_timeBack);
         addToContent(_timeContainer);
         addToContent(_remainCountTxt);
         addToContent(_tipTxt);
         addToContent(_confirmBtn);
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = new SecurityCodeItem();
            _loc1_.x = _loc3_ % 2 * _loc1_.viewRectangle.width;
            _loc1_.y = int(_loc3_ / 2) * _loc1_.viewRectangle.height;
            _loc1_.index = _loc3_ + 1;
            _canvas.addChild(_loc1_);
            _imgList.push(_loc1_);
            _loc3_++;
         }
         var _loc2_:Shape = new Shape();
         _loc2_.x = -2;
         _loc2_.y = -2;
         _loc2_.graphics.lineStyle(4,1657186,1);
         _loc2_.graphics.drawRect(0,0,304,304);
         _loc2_.graphics.lineStyle(3,1657186,1);
         _loc5_ = 1;
         while(_loc5_ < 2)
         {
            _loc2_.graphics.moveTo(0,150);
            _loc2_.graphics.lineTo(304,150);
            _loc5_++;
         }
         _loc4_ = 1;
         while(_loc4_ < 2)
         {
            _loc2_.graphics.moveTo(150,0);
            _loc2_.graphics.lineTo(150,304);
            _loc4_++;
         }
         _canvas.addChild(_loc2_);
         _alertTxt.text = LanguageMgr.GetTranslation("securityCode.alert");
         _expTxt.text = LanguageMgr.GetTranslation("securityCode.reward");
         _expValue.text = (ArmyManager.instance.thane.grades * 100).toString();
         _tipTxt.text = LanguageMgr.GetTranslation("securityCode.tip");
      }
      
      private function initEvent() : void
      {
         _confirmBtn.addEventListener("click",__confirmClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmClickHandler);
         }
      }
      
      protected function __confirmClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:SecurityCodeItem = null;
         var _loc2_:String = "";
         _loc4_ = 0;
         while(_loc4_ < 4)
         {
            _loc3_ = _imgList[_loc4_];
            if(_loc4_ == 0)
            {
               _loc2_ += _loc3_.index;
            }
            else
            {
               _loc2_ += "," + _loc3_.index;
            }
            _loc4_++;
         }
         SocketSecurityCodeMessageManager.sendSecurityCodeMessage(_loc2_);
         dispose();
      }
      
      private function setTimeNumberView(param1:int = 0) : void
      {
         NumberViewUtils.getNumberView(param1,_timeContainer,_timeNumBitMap.bitmapData,16,25,15,16,"0123456789",2);
      }
      
      private function timeControl() : void
      {
         _timer = new Timer(1000,model.remainTime / 1000);
         setTimeNumberView(_timer.repeatCount);
         _timer.addEventListener("timer",onTimerHandler);
         _timer.addEventListener("timerComplete",onTimerCompleteHandler);
         _timer.start();
      }
      
      private function onTimerHandler(param1:Event) : void
      {
         setTimeNumberView(_timer.repeatCount - _timer.currentCount);
      }
      
      private function onTimerCompleteHandler(param1:TimerEvent) : void
      {
         _timer.stop();
         _timer.removeEventListener("timer",onTimerHandler);
         _timer.removeEventListener("timerComplete",onTimerCompleteHandler);
         setTimeNumberView();
         dispose();
      }
      
      public function show() : void
      {
         dataHandler();
         LayerManager.Instance.addToLayer(this,2,true,true,1);
         titleText = LanguageMgr.GetTranslation("securitycode.view.SecurityCodeTxt");
         startShow();
      }
      
      private function dataHandler() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _imgList.length)
         {
            _imgList[_loc1_].bytes = model["byteArr_" + (_loc1_ + 1)];
            _loc1_++;
         }
         _remainCountTxt.text = LanguageMgr.GetTranslation("securityCode.remainCount",model.remainCount);
      }
      
      private function startShow() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",onTimerHandler);
            _timer.removeEventListener("timerComplete",onTimerCompleteHandler);
            _timer.stop();
         }
         timeControl();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_timeNumBitMap);
         _timeNumBitMap = null;
         ObjectUtils.disposeObject(_remainCountTxt);
         _remainCountTxt = null;
         ObjectUtils.disposeObject(_tipTxt);
         _tipTxt = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimerHandler);
            _timer.removeEventListener("timerComplete",onTimerCompleteHandler);
            _timer = null;
         }
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

