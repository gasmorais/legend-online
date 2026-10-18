package farm.data
{
   import farm.FarmManager;
   import farm.event.FarmEvent;
   import flash.events.EventDispatcher;
   
   public class FriendFarmStateInfo extends EventDispatcher
   {
      
      public var userId:int;
      
      public var canFarmSteal:Boolean;
      
      public var canPastureSteal:Boolean;
      
      public var canGivePower:Boolean;
      
      public var canRevive:Boolean;
      
      public var canWorm:Boolean;
      
      public var canWeed:Boolean;
      
      public var canFeed:Boolean;
      
      public var canFeedLivestock:Boolean;
      
      public var canPacify:Boolean;
      
      public var canCure:Boolean;
      
      public var hasHouse:Boolean;
      
      public var furnitureId:int;
      
      public var isShow:Boolean;
      
      public function FriendFarmStateInfo()
      {
         super();
      }
      
      public function get curState() : int
      {
         if(FarmManager.instance.model.currentHomeFrameType == 1)
         {
            if(canGivePower)
            {
               return 23;
            }
            if(canFeed)
            {
               return 13;
            }
            if(canRevive)
            {
               return 8;
            }
            if(canWorm)
            {
               return 2;
            }
            if(canWeed)
            {
               return 3;
            }
            if(canFarmSteal)
            {
               return 14;
            }
         }
         else if(FarmManager.instance.model.currentHomeFrameType == 2)
         {
            if(canCure)
            {
               return 5;
            }
            if(canPacify)
            {
               return 4;
            }
            if(canFeedLivestock)
            {
               return 7;
            }
            if(canPastureSteal)
            {
               return 14;
            }
         }
         return 21;
      }
      
      public function get curStateFrame() : int
      {
         switch(curState)
         {
            case 14:
               return 2;
            case 23:
               return 3;
            case 8:
               return 4;
            case 2:
               return 5;
            case 3:
               return 6;
            case 13:
               return 7;
            case 5:
               return 8;
            case 4:
               return 9;
            case 6:
               return 10;
            case 7:
               return 11;
            default:
               return 1;
         }
      }
      
      public function beginChanges() : void
      {
      }
      
      public function commitChanges() : void
      {
         dispatchEvent(new FarmEvent("FRIEND_FARM_STATE_CHANGE"));
      }
   }
}

