package mvc.module.crisis
{
   import yishi.datas.templates.PlaneCrisisEventTempInfo;
   import yishi.manager.TempleteManager;
   
   public class PlaneCrisisCountInfo
   {
      
      public var eventType:int;
      
      public var maxCount:int;
      
      public var currCount:int;
      
      private var _description:String;
      
      public function PlaneCrisisCountInfo()
      {
         super();
      }
      
      public function getDescription() : String
      {
         var _loc1_:PlaneCrisisEventTempInfo = null;
         if(_description == null)
         {
            _loc1_ = TempleteManager.instance.planeCrisisEventTempCate.getEventTempInfoByType(eventType);
            if(_loc1_ != null)
            {
               _description = _loc1_.Description;
            }
         }
         return _description;
      }
   }
}

