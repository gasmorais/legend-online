package yishi.view.community
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   
   public class TimeDownBitmapView extends Component
   {
      
      public static const P_timeTxtField:String = "timeTxtField";
      
      public static const P_timeCount:String = "timeCount";
      
      public static const P_countStyle:String = "countStyle";
      
      public static const P_timeBitmap:String = "timeBitmap";
      
      public static const DELAYTIME:int = 1000;
      
      public static const TIMER_UPDATA:String = "timerDown_updata";
      
      public static const TIMERCOMPLETE:String = "timerDown_complete";
      
      public static const TIMERUPDATE:String = "TIMERUPDATE";
      
      private var _timer:Timer;
      
      protected var _timeCount:int;
      
      protected var _timeTxt:FilterFrameText;
      
      protected var _timeTxtStyle:String;
      
      protected var _countStyle:int;
      
      protected var _timeBitmap:Bitmap;
      
      protected var _timeBitmapStyle:String;
      
      public function TimeDownBitmapView()
      {
         super();
      }
      
      override protected function init() : void
      {
         _timer = new Timer(1000);
         _timer.stop();
         _timer.addEventListener("timer",_timerHandler);
         _timer.addEventListener("timerComplete",_timerCompleteHandler);
         super.init();
      }
      
      private function _timerHandler(param1:TimerEvent) : void
      {
         if(parent)
         {
            dispatchEvent(new Event("timerDown_updata"));
         }
         if(_timeCount == 0)
         {
            _timer.stop();
            return;
         }
         _timeCount = _timeCount - 1;
         setTimeCount();
      }
      
      private function _timerCompleteHandler(param1:TimerEvent) : void
      {
         _timer.stop();
         if(parent)
         {
            dispatchEvent(new Event("timerDown_complete"));
         }
      }
      
      public function pause() : void
      {
         _timer.stop();
         _timeTxt.text = "";
      }
      
      public function start() : void
      {
         _timer.start();
         setTimeCount();
      }
      
      public function set countStyle(param1:String) : void
      {
         _countStyle = int(param1);
      }
      
      public function get timeCount() : int
      {
         return _timeCount;
      }
      
      public function set timeCount(param1:int) : void
      {
         param1 = int(param1 < 0 ? 0 : param1);
         if(_timeCount == param1)
         {
            setTimeCount();
            return;
         }
         _timeCount = param1;
         onPropertiesChanged("timeCount");
      }
      
      public function get timeTxtStyle() : String
      {
         return _timeTxtStyle;
      }
      
      public function set timeTxtStyle(param1:String) : void
      {
         if(_timeTxtStyle == param1)
         {
            return;
         }
         _timeTxtStyle = param1;
         timeTxt = ComponentFactory.Instance.creat(_timeTxtStyle);
      }
      
      public function get timeBitmapStyle() : String
      {
         return _timeBitmapStyle;
      }
      
      public function set timeBitmapStyle(param1:String) : void
      {
         if(_timeBitmapStyle == param1)
         {
            return;
         }
         _timeBitmapStyle = param1;
         timeBitmap = ComponentFactory.Instance.creatBitmap(_timeBitmapStyle);
      }
      
      public function set timeTxt(param1:FilterFrameText) : void
      {
         if(_timeTxt == param1)
         {
            return;
         }
         _timeTxt = param1;
         onPropertiesChanged("timeTxtField");
      }
      
      public function get timeTxt() : FilterFrameText
      {
         return _timeTxt;
      }
      
      public function set timeBitmap(param1:Bitmap) : void
      {
         if(_timeBitmap == param1)
         {
            return;
         }
         _timeBitmap = param1;
         onPropertiesChanged("timeBitmap");
      }
      
      public function get timeBitmap() : Bitmap
      {
         return _timeBitmap;
      }
      
      override protected function addChildren() : void
      {
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(!_changedPropeties["timeTxtField"])
         {
         }
         if(_changedPropeties["timeCount"])
         {
            _timer.reset();
            _timer.repeatCount = _timeCount;
            _timer.start();
            setTimeCount();
         }
      }
      
      private function setTimeCount() : void
      {
         dispatchEvent(new Event("TIMERUPDATE"));
         if(_countStyle == 1)
         {
            if(_timeCount >= 3600)
            {
               _timeTxt.text = int(_timeCount / 3600) + LanguageMgr.GetTranslation("public.time.sigHour");
            }
            else if(_timeCount >= 60)
            {
               _timeTxt.text = int(_timeCount / 60) + LanguageMgr.GetTranslation("public.minute");
            }
            else
            {
               _timeTxt.text = DateFormatter.getCountDate(_timeCount,2,2);
            }
         }
         else
         {
            _timeTxt.text = DateFormatter.getCountDate(_timeCount,2,2);
         }
         NumberViewUtils.refreshTimeValue(_timeTxt.text,this,_timeBitmap.bitmapData,42,49,30,42,"0123456789:");
      }
      
      override public function dispose() : void
      {
         if(_timeTxt)
         {
            ObjectUtils.disposeObject(_timeTxt);
         }
         _timeTxt = null;
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",_timerHandler);
            _timer.removeEventListener("timerComplete",_timerCompleteHandler);
            _timer = null;
         }
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

