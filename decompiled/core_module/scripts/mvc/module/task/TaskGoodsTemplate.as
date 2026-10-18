package mvc.module.task
{
   public class TaskGoodsTemplate
   {
      
      public var TemplateId:int;
      
      public var RewardItemID:int;
      
      public var IsSelect:Boolean;
      
      public var RewardItemCount:int;
      
      public var ToJob:int;
      
      public var ValidDate:int;
      
      public function TaskGoodsTemplate()
      {
         super();
      }
      
      public function fitJob(param1:int) : Boolean
      {
         if(ToJob == 0)
         {
            return true;
         }
         if(param1 == ToJob)
         {
            return true;
         }
         return false;
      }
   }
}

