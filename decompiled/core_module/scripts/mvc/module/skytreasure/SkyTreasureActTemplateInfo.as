package mvc.module.skytreasure
{
   import com.road.yishi.proto.cccactive.ActiveAwardTemplatePB;
   import com.road.yishi.proto.cccactive.ActiveInfoPB;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleDictionary;
   
   public class SkyTreasureActTemplateInfo
   {
      
      private var _desc:String;
      
      private var _endTime:Date;
      
      private var _param1:Number;
      
      private var _param2:Number;
      
      private var _param3:Number;
      
      private var _param4:Number;
      
      private var _param5:String;
      
      private var _param6:String;
      
      private var _showTime:Date;
      
      private var _startTime:Date;
      
      private var _type:int;
      
      private var _uuid:String;
      
      private var _lotteryRatePoolInfo:Array = [];
      
      private var _skyTreasureExchangeItemInfo:SimpleDictionary = new SimpleDictionary();
      
      private var _skyTreasureRankRewardInfoDic:SimpleDictionary = new SimpleDictionary();
      
      public function SkyTreasureActTemplateInfo(param1:ActiveInfoPB)
      {
         super();
         _startTime = DateFormatter.parse(param1.startTime,"YYYY-MM-DD hh:mm:ss");
         _endTime = DateFormatter.parse(param1.endTime,"YYYY-MM-DD hh:mm:ss");
         _showTime = DateFormatter.parse(param1.showTime,"YYYY-MM-DD hh:mm:ss");
         _uuid = param1.uuid;
         _type = param1.type;
         _desc = param1.desc;
         _param1 = param1.param1;
         _param2 = param1.param2;
         _param3 = param1.param3;
         _param4 = param1.param4;
         _param5 = param1.param5;
         _param6 = param1.param6;
         checkAddActRewardData(param1.awardTemp);
      }
      
      private function checkAddActRewardData(param1:Array) : void
      {
         for each(var _loc2_:ActiveAwardTemplatePB in param1)
         {
            switch(_type)
            {
               case 121:
               case 120:
                  addSkyTreasureRankRewardInfo(_loc2_.remain1,parseInt(_loc2_.remain3),_loc2_.remain2);
                  break;
               case 110:
               case 111:
               case 112:
               case 113:
               case 114:
                  addSkyTreasureExchangeItemInfo(_loc2_.templateId,_loc2_.templateCount,parseInt(_loc2_.remain1),parseInt(_loc2_.remain2),parseInt(_loc2_.remain3));
                  break;
               case 100:
               case 101:
               case 102:
               case 103:
               case 104:
               case 105:
               case 106:
               case 107:
               case 108:
               case 109:
                  addSkyTreasureRateItemInfo(_loc2_.templateId,_loc2_.templateType,_loc2_.templateCount,_loc2_.templateShow,_loc2_.remain3);
            }
         }
      }
      
      public function get actId() : String
      {
         return _uuid;
      }
      
      public function get actType() : int
      {
         return _type;
      }
      
      public function get actStartTime() : Number
      {
         return _startTime.time;
      }
      
      public function get actEndTime() : Number
      {
         return _endTime.time;
      }
      
      private function get actShowTime() : Number
      {
         return _showTime.time;
      }
      
      public function get isActOpen() : Boolean
      {
         return currTime >= actStartTime && currTime <= (actShowTime ? actShowTime : actEndTime);
      }
      
      public function get isActShow() : Boolean
      {
         return currTime >= actStartTime && currTime <= actEndTime;
      }
      
      public function get actLeftTime() : int
      {
         if(currTime < actStartTime)
         {
            return 0;
         }
         if(currTime > actEndTime)
         {
            return 0;
         }
         return Math.floor((actEndTime - currTime) / 1000);
      }
      
      private function get currTime() : Number
      {
         return PlayerManager.instance.currentPlayerModel.sysCurtime.time;
      }
      
      public function get actDesc() : String
      {
         return _desc;
      }
      
      public function addSkyTreasureRateItemInfo(param1:int, param2:int, param3:int, param4:int, param5:String) : void
      {
         var _loc6_:LotteryRateInfo = new LotteryRateInfo(param1,param2,param3,param4,param5);
         _lotteryRatePoolInfo.push(_loc6_);
      }
      
      public function get lotteryRatePoolInfoArray() : Array
      {
         return _lotteryRatePoolInfo;
      }
      
      public function getLotteryPoolShowGoods() : Array
      {
         var _loc2_:Array = [];
         for each(var _loc1_:LotteryRateInfo in _lotteryRatePoolInfo)
         {
            if(_loc1_.Templateshow)
            {
               _loc2_.push(_loc1_.templateId);
            }
         }
         return _loc2_;
      }
      
      public function get actParam1() : Number
      {
         return _param1;
      }
      
      public function get actParam2() : Number
      {
         return _param2;
      }
      
      public function get actParam4() : Number
      {
         return _param4;
      }
      
      public function get actParam5() : String
      {
         return _param5;
      }
      
      public function get actParam6() : String
      {
         return _param6;
      }
      
      public function addSkyTreasureExchangeItemInfo(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         var _loc6_:SkyTreasureExchangeItemInfo = new SkyTreasureExchangeItemInfo(param1,param2,param3,param4,param5);
         _skyTreasureExchangeItemInfo.add(param1,_loc6_);
      }
      
      public function get skyTreasureExchangeTempleteIdArray() : Array
      {
         return _skyTreasureExchangeItemInfo.keys;
      }
      
      public function getSkyTreasureExchangeInfoByTempleteId(param1:int) : SkyTreasureExchangeItemInfo
      {
         return _skyTreasureExchangeItemInfo[param1];
      }
      
      public function deleteAllExchangeItem() : void
      {
         _skyTreasureExchangeItemInfo.clear();
      }
      
      public function addSkyTreasureRankRewardInfo(param1:String, param2:int, param3:String) : void
      {
         var _loc4_:SkyTreasureRankRewardInfo = new SkyTreasureRankRewardInfo(param1,param2,param3);
         _skyTreasureRankRewardInfoDic.add(param1,_loc4_);
      }
      
      public function get skyTreasureRankRewardArray() : Array
      {
         return _skyTreasureRankRewardInfoDic.getList();
      }
      
      public function getOneRankRewardInfoByRank(param1:int) : SkyTreasureRankRewardInfo
      {
         return _skyTreasureRankRewardInfoDic[param1] as SkyTreasureRankRewardInfo;
      }
   }
}

