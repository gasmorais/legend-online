package events
{
   import flash.events.Event;
   
   public class MagicCardEvent extends Event
   {
      
      public static const MAGICCARD_UPDATE:String = "MAGICCARD_UPDATE";
      
      public static const MAGICCARD_CAMPAIGN_BUFF:String = "MAGICCARD_CAMPAIGN_BUFF";
      
      public static const MAGICCARD_SUITINFO:String = "MAGICCARD_SUITINFO";
      
      public var data:*;
      
      public function MagicCardEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

