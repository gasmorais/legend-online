package events
{
   import flash.events.Event;
   
   public class RavePartyEvent extends Event
   {
      
      public static const RAVE_PARTY_TEMP_UPDTAE:String = "RAVE_PARTY_TEMP_UPDTAE";
      
      public static const RAVE_PARTY_USERINFO_UPDTAE:String = "RAVE_PARTY_USERINFO_UPDTAE";
      
      public static const RAVE_PARTY_OPENSTATE_UPDTAE:String = "RAVE_PARTY_OPENSTATE_UPDTAE";
      
      public static const RAVE_PARTY_SORT_UPDTAE:String = "RAVE_PARTY_SORT_UPDTAE";
      
      public var data:Object;
      
      public function RavePartyEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

