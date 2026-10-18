package mvc.module.theseus
{
   public class ThessBoxInfo
   {
      
      public var opType:int;
      
      public var count:int;
      
      public var passChapter:int;
      
      private var _firstRewardList:Array = [];
      
      private var _firstReward:String;
      
      public function ThessBoxInfo()
      {
         super();
      }
      
      public function get firstRewardList() : Array
      {
         return _firstRewardList;
      }
      
      public function set firstReward(param1:String) : void
      {
         if(_firstReward == param1)
         {
            return;
         }
         _firstReward = param1;
         if(_firstReward != null)
         {
            _firstRewardList = _firstReward.split(",");
         }
      }
   }
}

