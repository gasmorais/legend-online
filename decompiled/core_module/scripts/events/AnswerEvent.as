package events
{
   import flash.events.Event;
   
   public class AnswerEvent extends Event
   {
      
      public static const UPDATE_RANK:String = "UPDATE_RANK";
      
      public static const UPDATE_ANSWER:String = "UPDATE_ANSWER";
      
      public static const UPDATE_STATE:String = "UPDATE_STATE";
      
      public static const UPDATE_ITEM:String = "UPDATE_ITEM";
      
      public static const UPDATE_RESULT:String = "UPDATE_RESULT";
      
      public static const UPDATE_SELF_RANK:String = "UPDATE_SELF_RANK";
      
      public static const SHOW_REWARDS:String = "SHOW_REWARDS";
      
      public static const SELECT_ITEM:String = "SELECT_ITEM";
      
      public static const SELECT_ANSWER:String = "SELECT_ANSWER";
      
      public var data:*;
      
      public function AnswerEvent(param1:String, param2:*, param3:Boolean = false, param4:Boolean = false)
      {
         data = param2;
         super(param1,param3,param4);
      }
   }
}

