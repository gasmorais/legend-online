package yishi.view.component
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TimerButton extends BaseButton
   {
      
      public static const P_timeStyle:String = "timeStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      private var _timeStyle:String;
      
      private var _iconStyle:String;
      
      private var _timeTxt:FilterFrameText;
      
      private var _icon:DisplayObject;
      
      private var _time:Number = 0;
      
      private var _timer:Timer;
      
      private var _timeEnable:Boolean;
      
      public function TimerButton()
      {
         super();
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.addEventListener("timerComplete",__completeHandler);
      }
      
      public function get timeStyle() : String
      {
         return _timeStyle;
      }
      
      public function set timeStyle(param1:String) : void
      {
         if(param1 == _timeStyle)
         {
            return;
         }
         _timeStyle = param1;
         _timeTxt = ComponentFactory.Instance.creat(_timeStyle);
         onPropertiesChanged("timeStyle");
      }
      
      public function get iconStyle() : String
      {
         return _iconStyle;
      }
      
      public function set iconStyle(param1:String) : void
      {
         if(param1 == _iconStyle)
         {
            return;
         }
         _iconStyle = param1;
         _icon = ComponentFactory.Instance.creat(_iconStyle);
         onPropertiesChanged("iconStyle");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_icon)
         {
            addChild(_icon);
         }
         if(_timeTxt)
         {
            addChild(_timeTxt);
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         _time = _time - 1;
         _timeTxt.text = _time.toString();
      }
      
      private function __completeHandler(param1:TimerEvent) : void
      {
         _timer.stop();
         if(_timeEnable)
         {
            enable = true;
         }
         dispatchEvent(new Event("complete"));
      }
      
      public function set time(param1:Number) : void
      {
         _timeTxt.text = param1.toString();
         _time = param1;
         if(param1 > 0)
         {
            _timer.reset();
            _timer.repeatCount = param1;
            _timer.start();
            if(_timeEnable)
            {
               enable = false;
            }
         }
         else
         {
            dispatchEvent(new Event("complete"));
            if(_timeEnable)
            {
               enable = true;
            }
         }
      }
      
      public function get time() : Number
      {
         return _time;
      }
      
      public function set timeEnable(param1:Boolean) : void
      {
         _timeEnable = param1;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(_timer)
         {
            _timer.stop();
         }
         _timer = null;
         super.dispose();
      }
   }
}

