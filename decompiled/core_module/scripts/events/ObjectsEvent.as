package events
{
   import flash.events.Event;
   
   public class ObjectsEvent extends Event
   {
      
      public static const WALK_OVER:String = "walkOver";
      
      public static const WALK_NEXT:String = "WALK_NEXT";
      
      public var data:Object;
      
      public function ObjectsEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

