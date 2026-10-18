package map.campaign.view.ui.unrealshooting
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import yishi.utils.NumberViewUtils;
   
   public class UnrealShootingDownTimeView extends Component
   {
      
      private var _count:int;
      
      private var _time:Timer;
      
      private var _numberAsset:BitmapData;
      
      private var _hourContainer:Sprite;
      
      private var _minuteContainer:Sprite;
      
      private var _secondContainer:Sprite;
      
      private var fontWidth:int = 20;
      
      private var fontHeight:int = 23;
      
      private var bitWidth:int = 13;
      
      private var resLink:String = "worldboss.river.NumberAsset";
      
      private var equal:int = 20;
      
      private var type:int = 1;
      
      public function UnrealShootingDownTimeView(param1:int = 1)
      {
         type = param1;
         if(type == 2)
         {
            fontWidth = 30;
            fontHeight = 34;
            bitWidth = 22;
            equal = 28;
            resLink = "asset.vehiclemap.TeamCountNum";
         }
         super();
      }
      
      override protected function init() : void
      {
         var _loc3_:Bitmap = null;
         var _loc4_:Bitmap = null;
         var _loc2_:int = 30;
         var _loc1_:int = 27;
         if(type == 1)
         {
            _numberAsset = ComponentFactory.Instance.creatBitmapData(resLink);
            _loc3_ = ComponentFactory.Instance.creatBitmap("worldboss.river.RiverSymbolAsset");
            _loc4_ = new Bitmap(_loc3_.bitmapData);
            addChild(_loc3_);
            _loc3_.x = _loc1_ + 25;
            _loc3_.y = _loc2_ + 3;
            addChild(_loc4_);
            _loc4_.x = _loc1_ + 55;
            _loc4_.y = _loc2_ + 3;
            _hourContainer = new Sprite();
            addChild(_hourContainer);
            _hourContainer.y = _loc2_;
            _hourContainer.x = _loc1_;
            NumberViewUtils.getNumberView(0,_hourContainer,_numberAsset,fontWidth,fontHeight,bitWidth);
            _minuteContainer = new Sprite();
            NumberViewUtils.getNumberView(0,_minuteContainer,_numberAsset,fontWidth,fontHeight,bitWidth);
            addChild(_minuteContainer);
            _minuteContainer.x = _loc1_ + 29;
            _minuteContainer.y = _loc2_;
            _secondContainer = new Sprite();
            addChild(_secondContainer);
            _secondContainer.x = _loc1_ + 59;
            _secondContainer.y = _loc2_;
            NumberViewUtils.getNumberView(0,_secondContainer,_numberAsset,fontWidth,fontHeight,bitWidth);
         }
         else
         {
            _numberAsset = ComponentFactory.Instance.creatBitmapData(resLink);
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.TeamCountColon");
            _loc4_ = new Bitmap(_loc3_.bitmapData);
            addChild(_loc3_);
            _loc3_.x = 71;
            _loc3_.y = 36;
            addChild(_loc4_);
            _loc4_.x = 122;
            _loc4_.y = 36;
            _hourContainer = new Sprite();
            addChild(_hourContainer);
            _hourContainer.y = 32;
            _hourContainer.x = 27;
            NumberViewUtils.getNumberView(0,_hourContainer,_numberAsset,fontWidth,fontHeight,bitWidth);
            _minuteContainer = new Sprite();
            NumberViewUtils.getNumberView(0,_minuteContainer,_numberAsset,fontWidth,fontHeight,bitWidth);
            addChild(_minuteContainer);
            _minuteContainer.x = 79;
            _minuteContainer.y = 32;
            _secondContainer = new Sprite();
            addChild(_secondContainer);
            _secondContainer.x = 129;
            _secondContainer.y = 32;
            NumberViewUtils.getNumberView(0,_secondContainer,_numberAsset,fontWidth,fontHeight,bitWidth);
         }
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
         time = _count;
         if(!_time)
         {
            _time = new Timer(1000,param1);
            _time.addEventListener("timer",__timeHandler);
            _time.addEventListener("timerComplete",__timeCompleteHandler);
         }
         _time.reset();
         _time.repeatCount = param1;
         _time.start();
      }
      
      private function __timeHandler(param1:int) : void
      {
         _count = _count - 1;
         time = _count;
      }
      
      public function updateTime(param1:Sprite, param2:int) : void
      {
         NumberViewUtils.getNumberView(param2,param1,_numberAsset,fontWidth,fontHeight,bitWidth,equal);
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
         if(param1 >= 3600)
         {
            _loc2_ = param1 / 3600;
            updateTime(_hourContainer,_loc2_);
         }
         else
         {
            updateTime(_hourContainer,0);
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
      
      override public function dispose() : void
      {
         if(_time)
         {
            _time.removeEventListener("timer",__timeHandler);
            _time.removeEventListener("timerComplete",__timeCompleteHandler);
            _time.stop();
         }
         _time = null;
         ObjectUtils.disposeObject(_numberAsset);
         _numberAsset = null;
         ObjectUtils.disposeAllChildren(_hourContainer);
         _hourContainer = null;
         ObjectUtils.disposeAllChildren(_minuteContainer);
         _minuteContainer = null;
         ObjectUtils.disposeAllChildren(_secondContainer);
         _secondContainer = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         super.dispose();
      }
   }
}

