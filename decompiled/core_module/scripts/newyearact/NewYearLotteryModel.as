package newyearact
{
   import flash.events.EventDispatcher;
   
   public class NewYearLotteryModel extends EventDispatcher
   {
      
      private var _lotteryGoodsList:Array;
      
      private var _delayTime:Number = 0;
      
      public var beginTime:Number;
      
      public var endTime:Number;
      
      public var lotteryCount:int;
      
      public var onceNeedPoint:int;
      
      public var defectPoint:int;
      
      public var rewardItem:int;
      
      public var count:int;
      
      public var statu:int;
      
      public var isMail:Boolean;
      
      public function NewYearLotteryModel()
      {
         super();
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

