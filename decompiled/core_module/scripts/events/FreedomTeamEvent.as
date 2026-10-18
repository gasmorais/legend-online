package events
{
   import flash.events.Event;
   
   public class FreedomTeamEvent extends Event
   {
      
      public static const ADD_MEMBER:String = "ADD_MEMBER";
      
      public static const REMOVE_MEMBER:String = "REMOVE_MEMBER";
      
      public static const TEAM_INFO_UPDATE:String = "TEAM_INFO_UPDATE";
      
      public static const TEAM_INFO_SYNC:String = "TEAM_INFO_SYNC";
      
      public static const EDIT_TEAM_FIGHT_POS:String = "EDIT_TEAM_FIGHT_POS";
      
      public var data:Object;
      
      public function FreedomTeamEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

