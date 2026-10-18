package events
{
   import flash.events.Event;
   
   public class MazeEvent extends Event
   {
      
      public static const ORDERDATA_LOAD_COMPLETE:String = "ORDERDATA_LOAD_COMPLETE";
      
      public static const UPDATE_SHOP_PAGE_DATA:String = "UPDATE_SHOP_PAGE_DATA";
      
      public static const UPDATE_SHOP_GOODS_LIST:String = "UPDATE_SHOP_GOODS_LIST";
      
      public static const REFRESH_AUTO_STATE:String = "REFRESH_AUTO_STATE";
      
      public function MazeEvent(param1:String)
      {
         super(param1);
      }
   }
}

