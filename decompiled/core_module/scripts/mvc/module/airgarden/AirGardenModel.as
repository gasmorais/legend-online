package mvc.module.airgarden
{
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.FriendManager;
   import yishi.utils.SimpleDictionary;
   
   public class AirGardenModel
   {
      
      public var canCreateParty:Boolean;
      
      public var createBeginTime:Date;
      
      public var createEndTime:Date;
      
      public var isParty:Boolean;
      
      public var partyBeginTime:Date;
      
      public var partyEndTime:Date;
      
      public var selfCreatedParty:Boolean;
      
      public var selfUpCount:int;
      
      public var upCdEndTime:Number;
      
      public var bedNodeList:Array;
      
      public var gameRemain:int;
      
      public var extraGameCount:int;
      
      public var selfScore:int;
      
      public var roomSelfUpCount:int;
      
      public var allPartyDic:SimpleDictionary;
      
      public var campaignInfo:AirGardenCampaignInfo;
      
      public function AirGardenModel()
      {
         super();
         allPartyDic = new SimpleDictionary(true);
         campaignInfo = new AirGardenCampaignInfo();
         bedNodeList = [];
      }
      
      public function get friendPartyList() : Array
      {
         var _loc2_:AirGardenPartyInfo = null;
         var _loc1_:Array = [];
         for each(var _loc3_:ThaneInfo in friendDic)
         {
            if(_loc3_.relation == 1)
            {
               if(_loc3_.vocationGrades > 0)
               {
                  if(!allPartyDic[_loc3_.userId])
                  {
                     _loc2_ = new AirGardenPartyInfo();
                     _loc2_.masterUserId = _loc3_.userId;
                     _loc2_.headId = _loc3_.headId;
                     _loc2_.nickName = _loc3_.nickName;
                     _loc2_.fightPower = _loc3_.fightingCapacity;
                  }
                  else
                  {
                     _loc2_ = allPartyDic[_loc3_.userId];
                  }
                  _loc1_.push(_loc2_);
               }
            }
         }
         _loc1_.sortOn(["upCount","fightPower"],[0x10 | 2,0x10 | 2]);
         return _loc1_;
      }
      
      public function get serverPartyList() : Array
      {
         var _loc1_:Array = allPartyDic.getList();
         _loc1_.sortOn(["upCount","fightPower"],[0x10 | 2,0x10 | 2]);
         return _loc1_;
      }
      
      public function get hasFreeBed() : Boolean
      {
         var _loc1_:Boolean = false;
         for each(var _loc2_:AirGardenCampaignBedInfo in campaignInfo.bedNodeList)
         {
            if(_loc2_.campaignNodeId > 0 && _loc2_.objId == 0)
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function getCampaignBedInfoByNodeId(param1:int) : AirGardenCampaignBedInfo
      {
         for each(var _loc2_:AirGardenCampaignBedInfo in campaignInfo.bedNodeList)
         {
            if(_loc2_.campaignNodeId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get friendDic() : SimpleDictionary
      {
         return FriendManager.getInstance().friendList;
      }
   }
}

