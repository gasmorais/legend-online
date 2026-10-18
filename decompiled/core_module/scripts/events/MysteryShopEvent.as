package events
{
   import flash.events.Event;
   
   public class MysteryShopEvent extends Event
   {
      
      public static const MYSTERY_GOODS_BUY_RETURN:String = "MYSTERY_GOODS_BUY_RETURN";
      
      public static const MYSTERY_GOODS_LIST_REFRESH:String = "MYSTERY_GOODS_LIST_REFRESH";
      
      public static const BUY_COUNTS_REFRESH:String = "BUY_COUNTS_REFRESH";
      
      public static const CONSUME_POINTS_REFRESH:String = "CONSUME_POINTS_REFRESH";
      
      public static const EXCHANGE_GOODS_LIST_UPDATE:String = "EXCHANGE_GOODS_LIST_UPDATE";
      
      public static const EXCHANGE_PAGE_UPDATE:String = "EXCHANGE_PAGE_UPDATE";
      
      public var data:Object;
      
      public function MysteryShopEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         data = param2;
      }
   }
}

