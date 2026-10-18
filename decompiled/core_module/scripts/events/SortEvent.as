package events
{
   import flash.events.Event;
   
   public class SortEvent extends Event
   {
      
      public static const SELECTE_CHANGE:String = "SELECTE_CHANGE";
      
      public static const PAGE_UPDATE:String = "PAGE_UPDATE";
      
      public static const SELECTE_LIST_CHANG:String = "SELECTE_LIST_CHANG";
      
      public function SortEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

