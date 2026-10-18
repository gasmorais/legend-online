package events
{
   import flash.events.Event;
   
   public class LandMineEvent extends Event
   {
      
      public static const INFO_UPDATE:String = "INFO_UPDATE";
      
      public static const SAPPER_LEAVE:String = "SAPPER_LEAVE";
      
      public static const SAPPER_MOVE:String = "SAPPER_MOVE";
      
      public static const GAME_END:String = "GAME_END";
      
      public static const TEAM_CANCEL:String = "TEAM_CANCEL";
      
      public static const DRAG_MAP_START:String = "DRAG_MAP_START";
      
      public static const DRAG_MAP_END:String = "DRAG_MAP_END";
      
      public var data:Object;
      
      public function LandMineEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

