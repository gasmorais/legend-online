package mvc.module.outyard
{
   import yishi.datas.templates.OutyardAreaTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class AreaPoint
   {
      
      public var id:String;
      
      public var row:int;
      
      public var col:int;
      
      public var type:int;
      
      public var eventId:int;
      
      public var eventType:int;
      
      public var triggered:Boolean;
      
      public var lineArr:Array = [];
      
      public function AreaPoint()
      {
         super();
      }
      
      public function get template() : OutyardAreaTemplateInfo
      {
         return TempleteManager.instance.outyardAreaTemplateCate.getTemplateByID(eventId);
      }
      
      public function get url() : String
      {
         if(!template)
         {
            return "mapmaterial/build/2003.swf";
         }
         return template.Resource;
      }
   }
}

