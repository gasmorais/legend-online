package mvc.module.airgarden
{
   public class AirGardenCampaignInfo
   {
      
      public var masterUserId:int;
      
      public var nickName:String;
      
      public var headId:int;
      
      public var fightPower:int;
      
      public var intro:String;
      
      public var isParty:Boolean;
      
      public var hotCount:int;
      
      public var upCount:int;
      
      public var gameRemainList:Array;
      
      public var totalScore:int;
      
      public var bedNodeList:Array;
      
      public function AirGardenCampaignInfo()
      {
         super();
         bedNodeList = [];
         gameRemainList = [];
      }
   }
}

