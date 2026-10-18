package mvc.module.navigation
{
   import yishi.datas.templates.NavigationTaskTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class NavigationPortInfo
   {
      
      public var portId:String;
      
      public var taskId1:int;
      
      public var taskId2:int;
      
      public var taskId3:int;
      
      public var taskId4:int;
      
      public var taskId5:int;
      
      public var taskId6:int;
      
      public var portCd:Number;
      
      public var boatId:String;
      
      public var selectedTask1:Boolean;
      
      public var selectedTask2:Boolean;
      
      public var selectedTask3:Boolean;
      
      public var selectedTask4:Boolean;
      
      public var selectedTask5:Boolean;
      
      public var selectedTask6:Boolean;
      
      public var taskNum1:int;
      
      public var taskNum2:int;
      
      public var taskNum3:int;
      
      public var taskNum4:int;
      
      public var taskNum5:int;
      
      public var taskNum6:int;
      
      public var payBusinessNum:int;
      
      public var grades:int;
      
      public function NavigationPortInfo()
      {
         super();
      }
      
      public function getTaskTemp(param1:int) : NavigationTaskTempInfo
      {
         return TempleteManager.instance.navigationTaskTemplateCate.getTemplateByID(param1);
      }
      
      public function get isTasking() : Boolean
      {
         return !StringHelper.isNullOrEmpty(boatId);
      }
      
      public function get upgradeTemplates() : Array
      {
         var _loc1_:Array = null;
         if(!_loc1_)
         {
            _loc1_ = TempleteManager.instance.getTemplatesByType(161);
            _loc1_.sortOn("Grades",16);
         }
         return _loc1_;
      }
      
      public function get currentTemplte() : UpgradeTemplateInfo
      {
         return upgradeTemplates[grades - 1];
      }
      
      public function get upgradeTemplte() : UpgradeTemplateInfo
      {
         return upgradeTemplates[grades];
      }
   }
}

