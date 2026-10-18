package mvc.module.sale
{
   import flash.events.Event;
   
   public class SaleEvent extends Event
   {
      
      public static const SALE_DATA:String = "SaleEvent.SALE_DATA";
      
      public static const SALE_NOTIC:String = "SaleEvent.SALE_NOTIC";
      
      public static const SALE_SWITCH:String = "SaleEvent.SALE_SWITCH";
      
      public static const SALE_PREVIEW_ITEM_CLICK:String = "SaleEvent.SALE_PREVIEW_ITEM_CLICK";
      
      public static const SALE_PREVIEW_LOADED:String = "SaleEvent.SALE_PREVIEW_LOADED";
      
      public var data:Object;
      
      public function SaleEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

