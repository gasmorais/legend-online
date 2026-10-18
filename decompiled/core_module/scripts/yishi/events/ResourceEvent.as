package yishi.events
{
   import flash.events.Event;
   
   public class ResourceEvent extends Event
   {
      
      public static var RESOURCE_UPDATE:String = "RESOURCE_UPDATE";
      
      private var _data:int;
      
      public function ResourceEvent(param1:String, param2:int)
      {
         _data = param2;
         super(param1,false,false);
      }
      
      public function get data() : int
      {
         return _data;
      }
   }
}

