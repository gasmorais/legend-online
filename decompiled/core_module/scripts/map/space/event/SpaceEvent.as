package map.space.event
{
   import flash.events.Event;
   
   public class SpaceEvent extends Event
   {
      
      public static const TARGET_CHANGE:String = "TARGET_CHANGE";
      
      public static const HIDE_OTHERS:String = "HIDE_OTHERS";
      
      public static const FIND_NODE:String = "FIND_NODE";
      
      public static const SELECT_NODE:String = "SELECT_NODE";
      
      private var _data:Object;
      
      public function SpaceEvent(param1:String, param2:Object)
      {
         _data = param2;
         super(param1,false,false);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

