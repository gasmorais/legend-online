package map.campaign.data
{
   import flash.events.EventDispatcher;
   import map.campaign.event.SvsEvent;
   
   public class SvsCampaignInfo extends EventDispatcher
   {
      
      public var site1:String = "";
      
      public var teamId1:int;
      
      public var liveCount1:int;
      
      public var totalCount1:int;
      
      public var site2:String = "";
      
      public var teamId2:int;
      
      public var liveCount2:int;
      
      public var totalCount2:int;
      
      public function SvsCampaignInfo()
      {
         super();
      }
      
      public function commit() : void
      {
         this.dispatchEvent(new SvsEvent("SVS_CAMPAIGN_INFO_CHANGE",null));
      }
   }
}

