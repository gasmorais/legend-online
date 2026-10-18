package yishi.datas.templates
{
   public class AchievementTaskTemplateInfo
   {
      
      public var Id:int;
      
      public var Classify:int;
      
      public var ConditionTitle:String;
      
      public var PreAchievementID:int;
      
      public var ConditionType:int;
      
      public var ConditionParm1:int;
      
      public var ConditionParm2:int;
      
      public var ConditionParm3:int;
      
      public var Rewards:String;
      
      public var IsPopout:int;
      
      public var PackageName:String;
      
      private var _sort:int;
      
      public function AchievementTaskTemplateInfo()
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

