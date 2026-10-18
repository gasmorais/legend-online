package mvc.module.dayGuide
{
   public class DaySignInfoData
   {
      
      public var signTimes:String;
      
      public var signCycle:int;
      
      public var resetDate:String;
      
      public var rewardTag:int;
      
      public var op:int;
      
      public var todayIndex:int;
      
      public function DaySignInfoData()
      {
         super();
      }
      
      public function get signCount() : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = signTimes.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_] == 1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function get signArr() : Array
      {
         return signTimes.split(",");
      }
   }
}

