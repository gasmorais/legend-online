package mvc.module.guidetask
{
   import com.road.yishi.proto.leed.SimpleTaskMsg;
   
   public class SingleDayInfo
   {
      
      private var _day:int;
      
      private var _isGetReward:int;
      
      private var _simpleTaskArr:Array;
      
      public function SingleDayInfo()
      {
         super();
      }
      
      public function get day() : int
      {
         return _day;
      }
      
      public function set day(param1:int) : void
      {
         _day = param1;
      }
      
      public function get isGetReward() : int
      {
         return _isGetReward;
      }
      
      public function set isGetReward(param1:int) : void
      {
         _isGetReward = param1;
      }
      
      public function get simpleTaskArr() : Array
      {
         return _simpleTaskArr;
      }
      
      public function set simpleTaskArr(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:SimpleTaskMsg = null;
         var _loc5_:SimpleTaskInfo = null;
         _simpleTaskArr = [];
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = param1[_loc4_] as SimpleTaskMsg;
            _loc5_ = new SimpleTaskInfo();
            _loc5_.taskId = _loc2_.taskId;
            _loc5_.isComplete = _loc2_.isComplete;
            _simpleTaskArr.push(_loc5_);
            _loc4_++;
         }
      }
   }
}

