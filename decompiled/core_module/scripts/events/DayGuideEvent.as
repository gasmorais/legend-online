package events
{
   import flash.events.Event;
   
   public class DayGuideEvent extends Event
   {
      
      public static const ACTIVE_CHANGE:String = "ACTIVE_CHANGE";
      
      public static const LEED_PROGRESS_CHANGE:String = "LEED_PROGRESS_CHANGE";
      
      public static const LEEDINFO_CHANGE:String = "LEEDINFO_CHANGE";
      
      public static const LEED_COMPLETE:String = "LEED_COMPLETE";
      
      public static const DAY_ACTIVE_GOBACK:String = "DAY_ACTIVE_GOBACK";
      
      public static const LEFT_SELECTED_CHANGE:String = "LEFT_SELECTED_CHANGE";
      
      public static const DAILY_ITEM_CLICK:String = "DAILY_ITEM_CLICK";
      
      public static const DAILY_ITEM_REFRESH:String = "DAILY_ITEM_REFRESH";
      
      public static const REWARDPOS_CHANGE:String = "REWARDPOS_CHANGE";
      
      public static const ON_DRAW_COMPLETE:String = "ON_DRAW_COMPLETE";
      
      public static const ExtractTimes_CHANGE:String = "ExtractTimes_CHANGE";
      
      public static const POP_GOODS_MOVIE:String = "POP_GOODS_MOVIE";
      
      public static const POP_GOODS:String = "POP_GOODS";
      
      public static const BUFF_STOP_DATE:String = "BUFF_STOP_DATE";
      
      public var data:Object;
      
      public function DayGuideEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

