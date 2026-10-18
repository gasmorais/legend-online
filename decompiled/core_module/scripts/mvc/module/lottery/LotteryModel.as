package mvc.module.lottery
{
   import events.LotteryEvent;
   import flash.events.EventDispatcher;
   
   public class LotteryModel extends EventDispatcher
   {
      
      private var _delayTime:Number = 0;
      
      private var _info:LotteryInfo;
      
      private var _lotteryShowInfo:Array;
      
      private var _lotteryGoodsList:Array;
      
      public var dropId:int;
      
      public var dropCount:int;
      
      public function LotteryModel()
      {
         super();
         _info = new LotteryInfo();
      }
      
      public function get lotteryGoodsList() : Array
      {
         if(!_lotteryGoodsList)
         {
            _lotteryGoodsList = [];
         }
         return _lotteryGoodsList;
      }
      
      public function set lotteryGoodsList(param1:Array) : void
      {
         _lotteryGoodsList = param1;
      }
      
      public function get lotteryShowInfo() : Array
      {
         return _lotteryShowInfo;
      }
      
      public function set lotteryShowInfo(param1:Array) : void
      {
         _lotteryShowInfo = param1;
         dispatchEvent(new LotteryEvent("UPDATE_SHOW_INFO"));
      }
      
      public function get info() : LotteryInfo
      {
         return _info;
      }
      
      public function get delayTime() : Number
      {
         return _delayTime;
      }
      
      public function set delayTime(param1:Number) : void
      {
         _delayTime = param1;
      }
   }
}

