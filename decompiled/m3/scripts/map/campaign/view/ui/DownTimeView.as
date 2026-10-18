package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import yishi.timer.TimerTicker;
   import yishi.utils.NumberViewUtils;
   
   public class DownTimeView extends Sprite implements Disposeable
   {
      
      private var _count:int;
      
      private var _time:TimerTicker;
      
      private var _numberAsset:BitmapData;
      
      private var _hourContainer:Sprite;
      
      private var _minuteContainer:Sprite;
      
      private var _secondContainer:Sprite;
      
      private var _autoShowHour:Boolean;
      
      private var _symbol1:Bitmap;
      
      public function DownTimeView(param1:Boolean = true)
      {
         super();
         _autoShowHour = param1;
         init();
      }
      
      private function init() : void
      {
         var _loc2_:int = 30;
         var _loc1_:int = 27;
         _numberAsset = ComponentFactory.Instance.creatBitmapData("worldboss.river.NumberAsset");
         _symbol1 = ComponentFactory.Instance.creatBitmap("worldboss.river.RiverSymbolAsset");
         var _loc3_:Bitmap = new Bitmap(_symbol1.bitmapData);
         addChild(_symbol1);
         _symbol1.x = _loc1_ + 25;
         _symbol1.y = _loc2_ + 3;
         addChild(_loc3_);
         _loc3_.x = _loc1_ + 55;
         _loc3_.y = _loc2_ + 3;
         _hourContainer = new Sprite();
         addChild(_hourContainer);
         _hourContainer.y = _loc2_;
         _hourContainer.x = _loc1_;
         NumberViewUtils.getNumberView(0,_hourContainer,_numberAsset,20,23,13);
         _minuteContainer = new Sprite();
         NumberViewUtils.getNumberView(0,_minuteContainer,_numberAsset,20,23,13);
         addChild(_minuteContainer);
         _minuteContainer.x = _loc1_ + 29;
         _minuteContainer.y = _loc2_;
         _secondContainer = new Sprite();
         addChild(_secondContainer);
         _secondContainer.x = _loc1_ + 59;
         _secondContainer.y = _loc2_;
         NumberViewUtils.getNumberView(0,_secondContainer,_numberAsset,20,23,13);
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
         time = _count;
         if(!_time)
         {
            _time = new TimerTicker(1000,param1);
         }
         _time.reset();
         _time.addEventListener("timer",__timeHandler);
         _time.addEventListener("timerComplete",__timeCompleteHandler);
         _time.start();
      }
      
      private function __timeHandler(param1:int) : void
      {
         _count = _count - 1;
         time = _count;
      }
      
      public function updateTime(param1:Sprite, param2:int) : void
      {
         NumberViewUtils.getNumberView(param2,param1,_numberAsset,20,23,13,20);
      }
      
      private function __timeCompleteHandler(param1:TimerEvent) : void
      {
         this.dispatchEvent(new Event("complete"));
      }
      
      public function stop() : void
      {
         if(_time)
         {
            _time.stop();
         }
      }
      
      public function set time(param1:int) : void
      {
         var _loc2_:int = 0;
         _symbol1.visible = true;
         if(param1 >= 3600)
         {
            _loc2_ = param1 / 3600;
            updateTime(_hourContainer,_loc2_);
         }
         else if(_autoShowHour)
         {
            updateTime(_hourContainer,0);
         }
         else
         {
            ObjectUtils.disposeAllChildren(_hourContainer);
            _symbol1.visible = false;
         }
         if(param1 >= 60)
         {
            _loc2_ = param1 / 60;
            updateTime(_minuteContainer,int(_loc2_ % 60));
         }
         else
         {
            updateTime(_minuteContainer,0);
         }
         _loc2_ = param1 % 60;
         _loc2_ = int(_loc2_ > 0 ? _loc2_ : 0);
         updateTime(_secondContainer,_loc2_);
      }
      
      public function dispose() : void
      {
         if(_time)
         {
            _time.removeEventListener("timer",__timeHandler);
            _time.removeEventListener("timerComplete",__timeCompleteHandler);
            _time.stop();
         }
         _time = null;
         if(_numberAsset)
         {
            _numberAsset.dispose();
         }
         _numberAsset = null;
         ObjectUtils.disposeAllChildren(_hourContainer);
         _hourContainer = null;
         ObjectUtils.disposeAllChildren(_minuteContainer);
         _minuteContainer = null;
         ObjectUtils.disposeAllChildren(_secondContainer);
         _secondContainer = null;
         _symbol1 = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

