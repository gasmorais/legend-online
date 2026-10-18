package map.campaign.data
{
   import flash.events.EventDispatcher;
   import map.campaign.event.PvpWarFightEvent;
   
   public class WarReportInfo extends EventDispatcher
   {
      
      public var oneTeamId:int;
      
      public var twoTeamId:int;
      
      public var thdTeamId:int;
      
      public var tempId:int;
      
      public var ownCount:int;
      
      public var teamCount:int = 0;
      
      public var oneScore:int;
      
      public var twoScore:int;
      
      public var thdScore:int;
      
      public function WarReportInfo()
      {
         super();
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new PvpWarFightEvent("PVP_WAR_FIGHT_REPORT",null));
      }
   }
}

