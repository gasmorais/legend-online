package events
{
   import flash.events.Event;
   import mvc.module.shop.ShopGoodsInfo;
   
   public class ShopEvent extends Event
   {
      
      public static const CURSELECTED_TAB_CHANGE:String = "CURSELECTED_TAB_CHANGE";
      
      public static const GOODS_INFO_UPDATE:String = "GOODS_INFO_UPDATE";
      
      public static const GOODS_LIST_UPDATE:String = "GOODS_LIST_UPDATE";
      
      public static const PAGE_UPDATE:String = "PAGE_UPDATE";
      
      public static const SWITCH_FASHION_PANEL:String = "SWITCH_FASHION_PANEL";
      
      public static const SHOPCART_DELETE_SUCCESS:String = "SHOPCART_DELETE_SUCCESS";
      
      public static const SHOPCART_UPDATE_SUCCESS:String = "SHOPCART_UPDATE_SUCCESS";
      
      public static const DISCOUNTSHOP_UPDATE:String = "DISCOUNTSHOP_UPDATE";
      
      public var goods:ShopGoodsInfo;
      
      private var _data:Object;
      
      public function ShopEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         _data = param2;
      }
      
      override public function clone() : Event
      {
         return new ShopEvent(type,data,bubbles,cancelable);
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

