package feedback
{
   import flash.events.Event;
   
   public class FeedBackEvent extends Event
   {
      
      public static const FEEDBACK_ITEM_CLICK:String = "FEEDBACK_ITEM_CLICK";
      
      public static const FEEDBACK_RECEIVE_USERINFO:String = "FEEDBACK_RECEIVE_USERINFO";
      
      public static const FEEDBACK_DELETE_ACTIVE:String = "FEEDBACK_DELETE_ACTIVE";
      
      public var data:Object;
      
      public function FeedBackEvent(param1:String, param2:Object = null)
      {
         data = param2;
         super(param1,false,false);
      }
   }
}

