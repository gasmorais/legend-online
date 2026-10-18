package mvc.module.raveparty
{
   import com.road.yishi.proto.party.PartyRewardMsg;
   
   public class RavePartyModel
   {
      
      public var openState:int;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var chargeScoreSet:String = "";
      
      public var consumScoreSet:String = "";
      
      public var chargeRewardList:Array;
      
      public var consumRewardList:Array;
      
      public var leedsRewardList:Array;
      
      public var playerScoreRewardList:Array;
      
      public var guildScoreRewardList:Array;
      
      public var serverScoreRewardList:Array;
      
      public var guildSortRewardList:Array;
      
      public var serverSortRewardList:Array;
      
      public var guildSortUpdateTime:String = "";
      
      public var serverSortUpdateTime:String = "";
      
      public var myGuildOrder:int;
      
      public var myServerOrder:int;
      
      public var myTotalScore:int;
      
      public var myChargePoint:int;
      
      public var myConsumPoint:int;
      
      public var myLeedScore:int;
      
      public var myGuildScore:int;
      
      public var myServerScore:int;
      
      public var guildSortList:Array;
      
      public var serverSortList:Array;
      
      public var hasTempData:Boolean = false;
      
      public function RavePartyModel()
      {
         super();
         if(!guildSortList)
         {
            guildSortList = [];
         }
         if(!serverSortList)
         {
            serverSortList = [];
         }
         if(!chargeRewardList)
         {
            chargeRewardList = [];
         }
         if(!consumRewardList)
         {
            consumRewardList = [];
         }
         if(!leedsRewardList)
         {
            leedsRewardList = [];
         }
         if(!playerScoreRewardList)
         {
            playerScoreRewardList = [];
         }
         if(!guildScoreRewardList)
         {
            guildScoreRewardList = [];
         }
         if(!serverScoreRewardList)
         {
            serverScoreRewardList = [];
         }
         if(!guildSortRewardList)
         {
            guildSortRewardList = [];
         }
         if(!serverSortRewardList)
         {
            serverSortRewardList = [];
         }
      }
      
      public function getPartyRewardInfoByLevelAndType(param1:PartyRewardMsg, param2:Array) : RavePartyRewardInfo
      {
         for each(var _loc3_:RavePartyRewardInfo in param2)
         {
            if(_loc3_.rewardType == param1.rewardType && _loc3_.rewardLevel == param1.rewardLevel)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getCurGradeAndMaxData(param1:int, param2:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:RavePartyRewardInfo = null;
         var _loc3_:int = int(param2.length);
         if(_loc3_ <= 0)
         {
            return [];
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param2[_loc4_];
            if(param1 < _loc5_.needValue)
            {
               return [_loc4_ + 1,_loc5_.needValue];
            }
            _loc4_++;
         }
         return [_loc3_,"max"];
      }
      
      public function cleanData() : void
      {
         hasTempData = false;
         openTime = "";
         stopTime = "";
         chargeScoreSet = "";
         consumScoreSet = "";
         guildSortUpdateTime = "";
         serverSortUpdateTime = "";
         myGuildOrder = 0;
         myServerOrder = 0;
         myTotalScore = 0;
         myChargePoint = 0;
         myConsumPoint = 0;
         myLeedScore = 0;
         myGuildScore = 0;
         myServerScore = 0;
         guildSortList.length = 0;
         serverSortList.length = 0;
         chargeRewardList.length = 0;
         consumRewardList.length = 0;
         leedsRewardList.length = 0;
         playerScoreRewardList.length = 0;
         guildScoreRewardList.length = 0;
         serverScoreRewardList.length = 0;
         guildSortRewardList.length = 0;
         serverSortRewardList.length = 0;
      }
   }
}

