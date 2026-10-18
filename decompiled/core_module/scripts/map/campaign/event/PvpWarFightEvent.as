package map.campaign.event
{
   import flash.events.Event;
   
   public class PvpWarFightEvent extends Event
   {
      
      public static const PVP_WAR_FIGHT_INFO_CHAGE:String = "PVP_WAR_FIGHT_INFO_CHAGE";
      
      public static const PVP_WAR_FIGHT_REPORT:String = "PVP_WAR_FIGHT_REPORT";
      
      public static const PVP_WAR_FIGHT_ORDER_REPORT:String = "PVP_WAR_FIGHT_ORDER_REPORT";
      
      public var data:Object;
      
      public function PvpWarFightEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

