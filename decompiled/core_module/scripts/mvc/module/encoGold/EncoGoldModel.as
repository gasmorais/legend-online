package mvc.module.encoGold
{
   import flash.events.EventDispatcher;
   
   public class EncoGoldModel extends EventDispatcher
   {
      
      private var _currentDay:int;
      
      private var _dayMsgList:Array;
      
      public var stratTime:String;
      
      public var stopTime:String;
      
      public var totalTakePoint:int;
      
      public var totalBackPoint:int;
      
      public var maxBackPoint:int;
      
      public var limitConsumePoint:int;
      
      public var isOpen:Boolean;
      
      public var limitBackPer:int;
      
      public var maxBackPer:int;
      
      public function EncoGoldModel()
      {
         super();
      }
      
      public function get dayMsgList() : Array
      {
         return _dayMsgList;
      }
      
      public function set dayMsgList(param1:Array) : void
      {
         _dayMsgList = param1;
      }
      
      public function get currentDay() : int
      {
         return _currentDay;
      }
      
      public function set currentDay(param1:int) : void
      {
         _currentDay = param1;
      }
      
      public function get allMsgList() : Array
      {
         var _loc4_:EncoGoldItemInfo = null;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc2_:int = int(_dayMsgList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _dayMsgList[_loc3_];
            if(_currentDay == _loc3_ + 1)
            {
               _loc1_.unshift(_loc4_);
            }
            else
            {
               _loc1_.push(_loc4_);
            }
            _loc3_ += 1;
         }
         return _loc1_;
      }
      
      public function get currentMsgList() : Array
      {
         var _loc5_:EncoGoldItemInfo = null;
         var _loc1_:Array = [];
         var _loc2_:int = int(_dayMsgList.length);
         var _loc3_:Boolean = false;
         var _loc4_:int = _currentDay - 1;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = _dayMsgList[_loc4_];
            _loc5_.day = _loc4_ + 1;
            _loc1_.push(_loc5_);
            _loc4_ += 1;
         }
         return _loc1_;
      }
   }
}

