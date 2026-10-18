package events
{
   import flash.events.Event;
   
   public class FashionEvent extends Event
   {
      
      public static const FASHION_STORE_CHANGE:String = "FASHION_STORE_CHANGE";
      
      public static const BUY_ITEM_SELECTED:String = "BUY_ITEM_SELECTED";
      
      public static const COMPOSE_SUCCEED:String = "COMPOSE_SUCCEED";
      
      public static const SWITCH_EQUIPVIEW:String = "SWITCH_EQUIPVIEW";
      
      public static const REFRESH_BAG:String = "REFRESH_BAG";
      
      public static const RESET_MOVIECLIP:String = "RESET_MOVIECLIP";
      
      public static const FASHION_BOOK_WEAR:String = "FASHION_BOOK_WEAR";
      
      public static const FASHION_BOOK_RECEIVE:String = "FASHION_BOOK_RECEIVE";
      
      public static const FASHION_REFRESH_RECEIVE:String = "FASHION_REFRESH_RECEIVE";
      
      public static const CHANGE_SWITCH:String = "CHANGE_SWITCH";
      
      public var data:Object;
      
      public function FashionEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

