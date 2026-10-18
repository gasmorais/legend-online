package mvc.module.airgarden
{
   import yishi.datas.playerinfo.ThaneInfo;
   
   public class AirGardenCampaignBedInfo
   {
      
      public var campaignNodeId:int;
      
      public var nodeTempId:int;
      
      public var objId:int;
      
      public var tempId:int;
      
      public var grade:int;
      
      public var heroInfo:ThaneInfo;
      
      public function AirGardenCampaignBedInfo()
      {
         super();
         heroInfo = new ThaneInfo();
      }
   }
}

