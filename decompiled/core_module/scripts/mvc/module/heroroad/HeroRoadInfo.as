package mvc.module.heroroad
{
   import yishi.datas.templates.HeroRoadTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class HeroRoadInfo
   {
      
      public var taskTempId:int;
      
      public var masterType:int;
      
      public var takeItemsState:int;
      
      public var buysItemsState:int;
      
      public var takeNumbers:int;
      
      public var index:int;
      
      public function HeroRoadInfo()
      {
         super();
      }
      
      public function get templete() : HeroRoadTemplateInfo
      {
         return TempleteManager.instance.heroRoadTemplateCate.getTemplateByID(taskTempId);
      }
      
      public function get PreTaskTempId() : int
      {
         return templete.PreTaskTempId;
      }
      
      public function get Priority() : int
      {
         return templete.Priority;
      }
   }
}

