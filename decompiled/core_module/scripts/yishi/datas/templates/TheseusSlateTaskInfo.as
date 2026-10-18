package yishi.datas.templates
{
   import managers.TheseussoulManager;
   
   public class TheseusSlateTaskInfo
   {
      
      public var TemplateId:int;
      
      public var TaskDescription:String;
      
      public var TaskType:int;
      
      public var Part1:int;
      
      public var Part2:int;
      
      public var Part3:int;
      
      public var TaskReward:String;
      
      public var status:int;
      
      public function TheseusSlateTaskInfo()
      {
         super();
      }
      
      public function get state() : int
      {
         var _loc2_:Boolean = TheseussoulManager.Instance.modelGodhead.getStoneCountWithLevel(Part1,Part3) >= Part2;
         var _loc1_:Boolean = TheseussoulManager.Instance.modelGodhead.compeltedTasks[TemplateId] == 1 ? true : false;
         if(_loc1_)
         {
            return 2;
         }
         if(!_loc2_)
         {
            return 0;
         }
         if(_loc2_ && !_loc1_)
         {
            return 1;
         }
         return 0;
      }
      
      public function getRewardList() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Array = [];
         if(TaskReward)
         {
            _loc1_ = TaskReward.split("|");
            for each(var _loc4_:String in _loc1_)
            {
               _loc2_ = _loc4_.split(",");
               if(_loc2_.length >= 2)
               {
                  _loc3_.push({
                     "id":int(_loc2_[0]),
                     "count":int(_loc2_[1])
                  });
               }
            }
         }
         return _loc3_;
      }
   }
}

