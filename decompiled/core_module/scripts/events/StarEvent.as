package events
{
   import flash.events.Event;
   import mvc.module.star.StarInfo;
   
   public class StarEvent extends Event
   {
      
      public static const UPDATE_STAR:String = "UPDATE_STAR";
      
      public static const DELETE_STAR:String = "DELETE_STAR";
      
      public static const COMPOSE_STAR:String = "COMPOSE_STAR";
      
      public static const RANDOMPOS_CHANGE:String = "RANDOMPOS_CHANGE";
      
      public static const UPDATE_STAR_POWER:String = "UPDATE_STAR_POWER";
      
      private var _starInfo:StarInfo;
      
      public function StarEvent(param1:String, param2:StarInfo)
      {
         super(param1,false,false);
         _starInfo = param2;
      }
      
      public function get starInfo() : StarInfo
      {
         return _starInfo;
      }
   }
}

