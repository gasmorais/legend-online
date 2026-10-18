package mvc.module.infotips
{
   import flash.events.EventDispatcher;
   
   public class InfoTipsModel extends EventDispatcher
   {
      
      public var valueObj:Object;
      
      public function InfoTipsModel()
      {
         super();
         valueObj = {};
      }
   }
}

