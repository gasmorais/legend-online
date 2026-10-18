package map.internals.event
{
   import flash.events.Event;
   
   public class PhysicsMenuEvent extends Event
   {
      
      public static const BTN_ATTACK:String = "BTN_ATTACK";
      
      public static const BTN_MOVE:String = "BTN_MOVE";
      
      public static const BTN_INFO:String = "BTN_INFO";
      
      public static const BTN_ENTER:String = "BTN_ENTER";
      
      public static const BTN_RETURN:String = "BTN_RETURN";
      
      public static const BTN_CALL:String = "BTN_CALL";
      
      public static const BTN_PORTAL:String = "BTN_PORTAL";
      
      public static const BTN_GIVE_UP:String = "BTN_GIVE_UP";
      
      public static const WRITE_EMAIL:String = "WRITE_EMAIL";
      
      public static const FRIEND:String = "FRIEND";
      
      public var data:Object;
      
      public function PhysicsMenuEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

