package events
{
   import flash.events.Event;
   
   public class PvPShopEvent extends Event
   {
      
      public static const SHOP_PAGE_UPDATE:String = "SHOP_PAGE_UPDATE";
      
      public static const SHOP_CURRENT_GOODS_LIST_UPDATE:String = "SHOP_CURRENT_GOODS_LIST_UPDATE";
      
      public function PvPShopEvent(param1:String)
      {
         super(param1,false,false);
      }
   }
}

