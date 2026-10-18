package mvc.module.heroroad
{
   public class AchievementTaskInfo
   {
      
      public var templateId:int;
      
      public var data:int;
      
      public var isCompleted:Boolean;
      
      public var isPopout:Boolean;
      
      public var isReward:Boolean;
      
      private var _sort:int;
      
      public function AchievementTaskInfo()
      {
         super();
      }
      
      public function get sort() : int
      {
         return _sort;
      }
      
      public function set sort(param1:int) : void
      {
         _sort = param1;
      }
   }
}

