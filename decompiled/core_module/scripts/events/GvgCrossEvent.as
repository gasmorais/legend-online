package events
{
   import flash.events.Event;
   
   public class GvgCrossEvent extends Event
   {
      
      public static const GUILD_INFO_UPDATE:String = "GUILD_INFO_UPDATE";
      
      public static const PAGE_UPDATE:String = "PAGE_UPDATE";
      
      public static const GROUP_UPDATE:String = "GROUP_UPDATE";
      
      public var data:Object;
      
      public function GvgCrossEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

