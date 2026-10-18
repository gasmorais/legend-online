package yishi.datas.playerinfo
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class BuildingOrderInfo extends EventDispatcher
   {
      
      public var userId:int;
      
      public var orderType:int;
      
      public var orderId:int;
      
      public var totalCount:int;
      
      public var currentCount:int;
      
      public var totalBuyCount:int;
      
      public var beginTime:Date;
      
      public var needTime:int;
      
      private var _remainTime:Number;
      
      public var info:Object = {};
      
      public var sortId:int;
      
      public var property1:int;
      
      public var property2:Boolean;
      
      private var _time:Timer;
      
      public function BuildingOrderInfo()
      {
         super();
      }
      
      private function __updateHandler(param1:TimerEvent) : void
      {
         _remainTime = _remainTime - 1;
         dispatchEvent(new Event("change"));
         if(remainTime <= 0)
         {
            dispatchEvent(new Event("complete"));
            if(_time)
            {
               _time.stop();
            }
         }
      }
      
      public function set remainTime(param1:Number) : void
      {
         _remainTime = param1;
         dispatchEvent(new Event("change"));
         if(_remainTime > 0)
         {
            if(!_time)
            {
               _time = new Timer(1000);
            }
            _time.addEventListener("timer",__updateHandler);
            _time.reset();
            _time.start();
         }
      }
      
      public function get remainTime() : Number
      {
         return _remainTime;
      }
      
      public function get remainCount() : int
      {
         var _loc1_:int = totalCount - currentCount;
         return _loc1_ > 0 ? _loc1_ : 0;
      }
      
      public function get remainBuyCount() : int
      {
         if(remainCount > 0)
         {
            return totalBuyCount;
         }
         return totalBuyCount - (currentCount - totalCount);
      }
      
      public function get currentBuyCount() : int
      {
         return totalBuyCount - remainBuyCount;
      }
      
      public function sendDataChange() : void
      {
         dispatchEvent(new Event("change"));
      }
   }
}

