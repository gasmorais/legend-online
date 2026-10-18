package map.campaign.data
{
   import flash.events.EventDispatcher;
   import map.campaign.event.PvpWarFightEvent;
   
   public class PvpWarFightInfo extends EventDispatcher
   {
      
      public static const BLUE_TEAM:int = 1;
      
      public static const RED_TEAM:int = 2;
      
      public var teamId:int;
      
      public var score:int;
      
      public var order:int;
      
      public var hitCount:int;
      
      public var leftTime:int;
      
      public var oneCount:int;
      
      public var twoCount:int;
      
      public var oneScore:int;
      
      public var twoScore:int;
      
      public var geste:int;
      
      public var buleFlagCount:int;
      
      public var redFlagCount:int;
      
      public function PvpWarFightInfo()
      {
         super();
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new PvpWarFightEvent("PVP_WAR_FIGHT_INFO_CHAGE",null));
      }
   }
}

