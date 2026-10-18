package mvc.module.dayGuide
{
   import events.DayGuideEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.templates.LeedTempInfo;
   import yishi.manager.TempleteManager;
   
   public class LeedInfo extends EventDispatcher
   {
      
      public var templateId:int;
      
      public var userId:int;
      
      public var beginDate:Date;
      
      public var isComplete:Boolean;
      
      private var _currentCount:int;
      
      private var _type:int;
      
      public function LeedInfo()
      {
         super();
      }
      
      public function get templateInfo() : LeedTempInfo
      {
         return TempleteManager.instance.leedTemplateCate.getTemplateByID(templateId);
      }
      
      public function get currentCount() : int
      {
         return _currentCount;
      }
      
      public function set currentCount(param1:int) : void
      {
         if(!templateInfo)
         {
            return;
         }
         _currentCount = param1 > templateInfo.PassCount ? templateInfo.PassCount : param1;
         dispatchEvent(new DayGuideEvent("LEEDINFO_CHANGE"));
      }
      
      public function get sort() : int
      {
         var _loc1_:LeedTempInfo = templateInfo;
         return _loc1_ ? _loc1_.Sort : 0;
      }
      
      public function get type() : int
      {
         var _loc1_:LeedTempInfo = templateInfo;
         return _loc1_ ? _loc1_.Type : 0;
      }
   }
}

