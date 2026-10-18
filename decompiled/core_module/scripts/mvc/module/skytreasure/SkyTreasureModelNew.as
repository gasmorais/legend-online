package mvc.module.skytreasure
{
   import com.road.yishi.proto.cccactive.ActiveInfoPB;
   import com.road.yishi.proto.cccactive.SkyTreasureExchangeActivePB;
   import com.road.yishi.proto.cccactive.SkyTreasureLotteryPB;
   import com.road.yishi.proto.cccactive.SkyTreasureRankInfoPB;
   import flash.events.EventDispatcher;
   import yishi.manager.GoodsManager;
   import yishi.utils.DateFormatter;
   
   public class SkyTreasureModelNew extends EventDispatcher
   {
      
      public static const FRAME1:int = 1;
      
      public static const FRAME2:int = 2;
      
      public static const FRAME3:int = 3;
      
      public static const FRAME4:int = 4;
      
      private var _currShowActId:String;
      
      public var totalScore:int;
      
      private var _skyTreasureActTempInfo:Array = [];
      
      private var _currRoundRankInfo:SkyTreasureRankDataInfo;
      
      private var _totalRankInfo:SkyTreasureRankDataInfo;
      
      private var _skyTreasureLotteryDataInfo:Array = [];
      
      public var _skyTreasureExchangeItemInfo:Array = [];
      
      private var _skyTreasureRecordArray:Array = [];
      
      private var _totalSkyTreasureRecordArray:Array = [];
      
      private var _skyTreasureRankRecordInfo:Array = [];
      
      public function SkyTreasureModelNew()
      {
         super();
      }
      
      public function get currShowActId() : String
      {
         return _currShowActId;
      }
      
      public function set currShowActId(param1:String) : void
      {
         _currShowActId = param1;
      }
      
      public function actIsLotteryType(param1:int) : Boolean
      {
         if(param1 == 100)
         {
            return true;
         }
         if(param1 == 101)
         {
            return true;
         }
         if(param1 == 102)
         {
            return true;
         }
         if(param1 == 103)
         {
            return true;
         }
         if(param1 == 104)
         {
            return true;
         }
         if(param1 == 105)
         {
            return true;
         }
         if(param1 == 106)
         {
            return true;
         }
         if(param1 == 107)
         {
            return true;
         }
         if(param1 == 108)
         {
            return true;
         }
         if(param1 == 109)
         {
            return true;
         }
         return false;
      }
      
      public function actIsExchangeType(param1:int) : Boolean
      {
         if(param1 == 110)
         {
            return true;
         }
         if(param1 == 111)
         {
            return true;
         }
         if(param1 == 112)
         {
            return true;
         }
         if(param1 == 113)
         {
            return true;
         }
         if(param1 == 114)
         {
            return true;
         }
         return false;
      }
      
      public function actIsRoundRankType(param1:int) : Boolean
      {
         return param1 == 121;
      }
      
      public function actIsTotalRankType(param1:int) : Boolean
      {
         return param1 == 120;
      }
      
      public function addSkyTreasureActTempInfo(param1:ActiveInfoPB) : void
      {
         var _loc3_:SkyTreasureActTemplateInfo = new SkyTreasureActTemplateInfo(param1);
         var _loc2_:int = findActTempInfoIndex(_loc3_.actId);
         if(_loc2_ >= 0)
         {
            _skyTreasureActTempInfo.splice(_loc2_,1,_loc3_);
         }
         else
         {
            _skyTreasureActTempInfo.push(_loc3_);
         }
         checkAddActDataInfo(_loc3_);
      }
      
      private function findActTempInfoIndex(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:SkyTreasureActTemplateInfo = null;
         _loc2_ = 0;
         while(_loc2_ < _skyTreasureActTempInfo.length)
         {
            _loc3_ = _skyTreasureActTempInfo[_loc2_] as SkyTreasureActTemplateInfo;
            if(_loc3_ && _loc3_.actId == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function checkAddActDataInfo(param1:SkyTreasureActTemplateInfo) : void
      {
         var _loc3_:String = param1.actId;
         var _loc2_:int = param1.actType;
      }
      
      public function getAllSkyTreasureActTempData() : Array
      {
         return _skyTreasureActTempInfo;
      }
      
      public function getAllSkyTreasureOpenActTempData() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:SkyTreasureActTemplateInfo in _skyTreasureActTempInfo)
         {
            if(_loc2_.isActOpen)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getAllSkyTreasureFrameOpenActTempData() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:SkyTreasureActTemplateInfo in _skyTreasureActTempInfo)
         {
            if(_loc2_.isActOpen && _loc2_.actType != 120 && _loc2_.actType != 121)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("actType",16);
         return _loc1_;
      }
      
      public function findSkyTreasureActTempInfoByActId(param1:String) : SkyTreasureActTemplateInfo
      {
         for each(var _loc2_:SkyTreasureActTemplateInfo in _skyTreasureActTempInfo)
         {
            if(_loc2_.actId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function findSkyTreasureActTempInfoByActType(param1:int) : Array
      {
         var _loc2_:Array = [];
         _skyTreasureActTempInfo.sortOn("actEndTime",16);
         for each(var _loc3_:SkyTreasureActTemplateInfo in _skyTreasureActTempInfo)
         {
            if(_loc3_.actType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function findSkyTreasureActTempInfoOpenByActType(param1:int) : SkyTreasureActTemplateInfo
      {
         for each(var _loc2_:SkyTreasureActTemplateInfo in _skyTreasureActTempInfo)
         {
            if(_loc2_.isActOpen && _loc2_.actType == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getAllred() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Array = getAllSkyTreasureFrameOpenActTempData();
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(getred(_loc1_[_loc2_]))
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      public function getred(param1:SkyTreasureActTemplateInfo) : Boolean
      {
         var _loc2_:int = 0;
         var _loc6_:SkyTreasureLotteryDataInfo = null;
         var _loc7_:SkyTreasureExchangeData = null;
         var _loc5_:int = 0;
         var _loc4_:SkyTreasureExchangeItemInfo = null;
         if(actIsLotteryType(param1.actType))
         {
            _loc6_ = findSkyTreasureLotteryDataInfo(param1.actId);
            _loc2_ = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(param1.actParam1);
            if(!_loc6_)
            {
               return false;
            }
            if(_loc2_ > 0 || _loc6_.freeLotteryLeftTimes == 0)
            {
               return true;
            }
         }
         if(actIsExchangeType(param1.actType))
         {
            _loc2_ = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(param1.actParam1);
            _loc7_ = findSkyTreasureExchangeDataInfo(param1.actId);
            if(!_loc7_)
            {
               return false;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc7_.items.length)
            {
               _loc4_ = param1.getSkyTreasureExchangeInfoByTempleteId(_loc7_.items[_loc5_].templateId);
               if(_loc4_.limitType == 0 && _loc2_ > _loc4_.exchangeCostNum)
               {
                  return true;
               }
               if(_loc7_.items[_loc5_].exchangeNum < _loc4_.limitNum && _loc2_ > _loc4_.exchangeCostNum)
               {
                  return true;
               }
               _loc5_++;
            }
            if(_loc7_.items.length == 0)
            {
               for each(var _loc3_:Number in param1.skyTreasureExchangeTempleteIdArray)
               {
                  if(param1.getSkyTreasureExchangeInfoByTempleteId(_loc3_).exchangeCostNum <= _loc2_)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public function findSkyTreasureActTempInfoByActDesc(param1:String) : SkyTreasureActTemplateInfo
      {
         for each(var _loc2_:SkyTreasureActTemplateInfo in _skyTreasureActTempInfo)
         {
            if(_loc2_.actDesc == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function createRoundRankInfo(param1:SkyTreasureRankInfoPB) : void
      {
         _currRoundRankInfo = new SkyTreasureRankDataInfo(param1);
      }
      
      public function createTotalRankInfo(param1:SkyTreasureRankInfoPB) : void
      {
         _totalRankInfo = new SkyTreasureRankDataInfo(param1);
      }
      
      public function get roundRankInfo() : SkyTreasureRankDataInfo
      {
         return _currRoundRankInfo;
      }
      
      public function get totalRankInfo() : SkyTreasureRankDataInfo
      {
         return _totalRankInfo;
      }
      
      public function addTreasureLotteryDataInfo(param1:SkyTreasureLotteryPB) : void
      {
         var _loc2_:SkyTreasureLotteryDataInfo = findSkyTreasureLotteryDataInfo(param1.activeId);
         if(_loc2_)
         {
            _loc2_.updateLotteryData(param1.freshTime,param1.times);
         }
         else
         {
            _skyTreasureLotteryDataInfo.push(new SkyTreasureLotteryDataInfo(param1.activeId,param1.freshTime,param1.times));
         }
      }
      
      public function findSkyTreasureLotteryDataInfo(param1:String) : SkyTreasureLotteryDataInfo
      {
         for each(var _loc2_:SkyTreasureLotteryDataInfo in _skyTreasureLotteryDataInfo)
         {
            if(_loc2_.actId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addSkyTreasureExchangeItemInfo(param1:SkyTreasureExchangeActivePB) : void
      {
         var _loc2_:SkyTreasureExchangeData = findSkyTreasureExchangeDataInfo(param1.activeId);
         if(_loc2_)
         {
            _loc2_.updateExchangeNum(param1.items[0]);
         }
         else
         {
            _skyTreasureExchangeItemInfo.push(new SkyTreasureExchangeData(param1));
         }
      }
      
      public function getSkyTreasureExchangeInfoByTempleteId(param1:int) : SkyTreasureExchangeItemInfo
      {
         return _skyTreasureExchangeItemInfo[param1];
      }
      
      public function findSkyTreasureExchangeDataInfo(param1:String) : SkyTreasureExchangeData
      {
         for each(var _loc2_:SkyTreasureExchangeData in _skyTreasureExchangeItemInfo)
         {
            if(_loc2_.actId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function addSkyTreasureRecordInfo(param1:String, param2:String, param3:String, param4:String, param5:int, param6:int, param7:Boolean = false) : void
      {
         var _loc8_:SkyTreasureRecordInfo = new SkyTreasureRecordInfo(param1,param2,param3,param4,param5,param6,param7);
         if(!param7)
         {
            _totalSkyTreasureRecordArray.push(_loc8_);
         }
         else
         {
            _skyTreasureRecordArray.push(_loc8_);
         }
      }
      
      private function compareByTimeDesc(param1:SkyTreasureRecordInfo, param2:SkyTreasureRecordInfo) : int
      {
         var _loc4_:Number = DateFormatter.getUTCTimeStamp(param1.time,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Number = DateFormatter.getUTCTimeStamp(param2.time,"YYYY-MM-DD hh:mm:ss");
         if(_loc4_ > _loc3_)
         {
            return -1;
         }
         if(_loc4_ < _loc3_)
         {
            return 1;
         }
         return 0;
      }
      
      public function get skyTreasureRecordArray() : Array
      {
         return _skyTreasureRecordArray.sort(compareByTimeDesc);
      }
      
      public function get totalSkyTreasureRecordArray() : Array
      {
         return _totalSkyTreasureRecordArray.sort(compareByTimeDesc);
      }
      
      public function deleteSelfSkyTreasureRecordArray() : void
      {
         while(_skyTreasureRecordArray.length > 0)
         {
            _skyTreasureRecordArray.pop();
         }
      }
      
      public function delteteAllSkyTreasureRecordArray() : void
      {
         while(_totalSkyTreasureRecordArray.length > 0)
         {
            _totalSkyTreasureRecordArray.pop();
         }
      }
      
      public function addskyTreasureRankRecordInfo(param1:String, param2:String, param3:Array, param4:int, param5:int) : void
      {
         var _loc6_:SkyTreasureRankRecordInfo = new SkyTreasureRankRecordInfo(param1,param2,param3,param4,param5);
         _skyTreasureRankRecordInfo.push(_loc6_);
      }
      
      public function get skyTreasureRankRecordInfoArray() : Array
      {
         return _skyTreasureRankRecordInfo;
      }
      
      public function delteteAllSkyTreasureRankRecordInfo() : void
      {
         while(_skyTreasureRankRecordInfo.length > 0)
         {
            _skyTreasureRankRecordInfo.pop();
         }
      }
   }
}

