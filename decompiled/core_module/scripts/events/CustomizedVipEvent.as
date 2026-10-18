package events
{
   import flash.events.Event;
   
   public class CustomizedVipEvent extends Event
   {
      
      public static const REWARD_ITEM_SELECT:String = "REWARD_ITEM_SELECT";
      
      public static const CUSTOMIZED_INFO_CHANGE:String = "CUSTOMIZED_INFO_CHANGE";
      
      public static const BOX_ITEM_SELECT_ALL:String = "BOX_ITEM_SELECT_ALL";
      
      public var data:Object;
      
      public function CustomizedVipEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

