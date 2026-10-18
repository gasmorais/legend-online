package yishi.datas.resource
{
   import flash.events.EventDispatcher;
   import yishi.events.ResourceEvent;
   
   public class ResourceData extends EventDispatcher
   {
      
      private var _baseYield:int;
      
      private var _count:int;
      
      private var _limit:int;
      
      public function ResourceData()
      {
         super();
      }
      
      public function get baseYield() : int
      {
         return _baseYield;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function get limit() : int
      {
         return _limit;
      }
      
      public function synchronizationResource(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = param2 - _count;
         _baseYield = param1;
         _count = param2;
         _limit = param3;
         dispatchEvent(new ResourceEvent(ResourceEvent.RESOURCE_UPDATE,_loc4_));
      }
   }
}

