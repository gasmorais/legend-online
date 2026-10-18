package events
{
   import flash.events.Event;
   
   public class OuterCityShopEvent extends Event
   {
      
      public static const PAYTYPE_CHANGE:String = "PAYTYPE_CHANGE";
      
      public static const FRESH_VIEW:String = "FRESH_VIEW";
      
      public static const EXCHANGE_GOODS_LIST_UPDATE:String = "EXCHANGE_GOODS_LIST_UPDATE";
      
      public static const LOOK_GOODS_LIST_UPDATE:String = "LOOK_GOODS_LIST_UPDATE";
      
      public static const UPDATE_LUCK_SHOW_INFO:String = "UPDATE_LUCK_SHOW_INFO";
      
      public function OuterCityShopEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

