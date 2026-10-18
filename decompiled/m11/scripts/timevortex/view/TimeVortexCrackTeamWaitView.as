package timevortex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.utils.NumberViewUtils;
   
   public class TimeVortexCrackTeamWaitView extends Sprite implements Disposeable
   {
      
      public static const ORIGIN_X:int = 217;
      
      private var _tipsImg:Image;
      
      private var _countDownTxtContainer:Sprite;
      
      private var _numberBtmData:BitmapData;
      
      private var _callBack:Function;
      
      private var _timer:Timer;
      
      private var _timeCount:int;
      
      public function TimeVortexCrackTeamWaitView(param1:Function = null)
      {
         _callBack = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _tipsImg = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexCrackTeamWaitView.tipsImg");
         _countDownTxtContainer = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexCrackTeamWaitView.countDownTxtContainer");
         _numberBtmData = ComponentFactory.Instance.creatBitmapData("asset.timevortex.crackWaitTipsNumberAsset").clone();
         _timer = new Timer(1010);
         addChild(_tipsImg);
         addChild(_countDownTxtContainer);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_countDownTxtContainer);
         ObjectUtils.disposeObject(_tipsImg);
         _tipsImg = null;
         ObjectUtils.disposeObject(_countDownTxtContainer);
         _countDownTxtContainer = null;
         ObjectUtils.disposeObject(_numberBtmData);
         _numberBtmData = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         _timer.addEventListener("timer",__timerHandler);
      }
      
      private function removeEvent() : void
      {
         _timer.removeEventListener("timer",__timerHandler);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _timeCount = _timeCount - 1;
         refreshCountDownView();
         if(_timeCount <= 0)
         {
            dispose();
         }
      }
      
      public function set timeCount(param1:int) : void
      {
         _timeCount = param1;
      }
      
      private function refreshCountDownView() : void
      {
         NumberViewUtils.printNumber(_timeCount,_countDownTxtContainer,_numberBtmData,"1234567890",-8);
         _countDownTxtContainer.x = 217 - _countDownTxtContainer.width * 0.5;
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,2,true,true,1);
         if(_timeCount > 0)
         {
            refreshCountDownView();
            if(_timer)
            {
               _timer.start();
            }
         }
      }
      
      public function dispose() : void
      {
         if(_callBack != null)
         {
            _callBack();
         }
         if(_timer)
         {
            _timer.stop();
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         _timer = null;
      }
   }
}

