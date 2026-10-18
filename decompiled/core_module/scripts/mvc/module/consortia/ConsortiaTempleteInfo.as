package mvc.module.consortia
{
   import events.ConsortiaEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import yishi.manager.TempleteManager;
   
   public class ConsortiaTempleteInfo extends EventDispatcher
   {
      
      private var _templateId:int;
      
      public var type:int;
      
      private var _level:int;
      
      public var isNext:Boolean;
      
      public function ConsortiaTempleteInfo(param1:IEventDispatcher = null)
      {
         super();
      }
      
      public function get templateInfo() : ConsortiaTemplete
      {
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(type,level);
      }
      
      public function get nextTemplateInfo() : ConsortiaTemplete
      {
         if(level == 10)
         {
            return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(type,level);
         }
         return TempleteManager.instance.getConsortiaTempleteByTypeAndLevel(type,level + 1);
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         _templateId = param1;
         dispatchEvent(new ConsortiaEvent("ON_TEMPLETEID_UPDATA"));
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         if(_level == param1)
         {
            return;
         }
         _level = param1;
         dispatchEvent(new ConsortiaEvent("ON_TEMPLETEID_UPDATA"));
      }
   }
}

