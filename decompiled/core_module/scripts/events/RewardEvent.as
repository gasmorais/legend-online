package events
{
   import flash.events.Event;
   import mvc.module.offerreward.BaseOfferReward;
   
   public class RewardEvent extends Event
   {
      
      public static const REWARD_TASK_ADD:String = "REWARD_TASK_ADD";
      
      public static const REWARD_TASK_SELECTED:String = "REWARD_TASK_SELECTED";
      
      public static const REWARD_TASK_UPDATE:String = "REWARD_TASK_UPDATE";
      
      public static const REWARD_TASK_FINISH:String = "REWARD_TASK_FINISH";
      
      public static const OFFER_REWARD_LIST_REFRESH:String = "OFFER_REWARD_LIST_REFRESH";
      
      public static const NEED_RESET_DATA:String = "NEED_RESET_DATA";
      
      private var _baseReward:BaseOfferReward;
      
      public function RewardEvent(param1:String, param2:BaseOfferReward)
      {
         super(param1,bubbles,cancelable);
         _baseReward = param2;
      }
      
      override public function clone() : Event
      {
         return new RewardEvent(type,data);
      }
      
      public function get data() : BaseOfferReward
      {
         return _baseReward;
      }
   }
}

