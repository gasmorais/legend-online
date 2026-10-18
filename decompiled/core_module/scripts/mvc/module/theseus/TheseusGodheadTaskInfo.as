package mvc.module.theseus
{
   public class TheseusGodheadTaskInfo
   {
      
      public var TemplateId:int;
      
      public var TaskDescription:String;
      
      public var TaskType:int;
      
      public var Part1:int;
      
      public var Part2:int;
      
      public var Part3:int;
      
      public var TaskReward:String;
      
      public var status:int;
      
      public function TheseusGodheadTaskInfo()
      {
         super();
      }
      
      public function isCompleted() : Boolean
      {
         return status == 2;
      }
      
      public function canReceiveReward() : Boolean
      {
         return status == 2;
      }
   }
}

