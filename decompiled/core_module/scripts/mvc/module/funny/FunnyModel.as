package mvc.module.funny
{
   import flash.utils.Dictionary;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import managers.ActivityManager;
   import managers.FunnyManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   
   public class FunnyModel
   {
      
      private var _data:Vector.<FunnyData>;
      
      private var _tiroFunnyList:Array;
      
      private var _otherDataDic:Dictionary;
      
      private var _activityArr:Array = [];
      
      public var canShine:Boolean = true;
      
      public var timingStr:String;
      
      public var regression:FunnyData;
      
      public var regressCharge:FunnyData;
      
      private var _continuePayRebateRewardData:Vector.<FunnyData>;
      
      private var _continuePayRebateChestData:Vector.<FunnyData>;
      
      public var topBagList:Vector.<FunnyBagData>;
      
      public var currentCost:Object;
      
      public var openDate:Date;
      
      public var endDate:Date;
      
      private var _showStartDate:Number;
      
      private var _showEndDate:Number;
      
      private var _currRechargeIndex:int = -1;
      
      public function FunnyModel()
      {
         super();
         if(_data == null)
         {
            _data = new Vector.<FunnyData>();
         }
         if(_tiroFunnyList == null)
         {
            _tiroFunnyList = [];
         }
         if(_otherDataDic == null)
         {
            _otherDataDic = new Dictionary();
         }
         _otherDataDic[14] = [];
         _otherDataDic[15] = [];
         _otherDataDic[50] = [];
         _otherDataDic[51] = [];
         _otherDataDic[146] = [];
         _otherDataDic[145] = [];
         _otherDataDic[197] = [];
         _otherDataDic[73] = [];
         _continuePayRebateRewardData = new Vector.<FunnyData>();
         _continuePayRebateChestData = new Vector.<FunnyData>();
      }
      
      public function findFunnyDataByTypeAndId(param1:int, param2:String) : FunnyData
      {
         var _loc3_:FunnyData = null;
         var _loc4_:int = 0;
         if(_otherDataDic[param1])
         {
            _loc4_ = 0;
            while(_loc4_ < _otherDataDic[param1].length)
            {
               if(_otherDataDic[param1][_loc4_].id == param2)
               {
                  _loc3_ = _otherDataDic[param1][_loc4_] as FunnyData;
               }
               _loc4_++;
            }
         }
         if(_loc3_ == null)
         {
            _loc4_ = 0;
            while(_loc4_ < data.length)
            {
               if(data[_loc4_] && data[_loc4_].id == param2)
               {
                  _loc3_ = data[_loc4_];
               }
               _loc4_++;
            }
         }
         if(_loc3_ == null)
         {
            _loc4_ = 0;
            while(_loc4_ < tiroFunnyList.length)
            {
               if(tiroFunnyList[_loc4_].id == param2)
               {
                  _loc3_ = tiroFunnyList[_loc4_];
               }
               _loc4_++;
            }
         }
         if(_loc3_ && _loc3_.showStart < playerModel.nowDate && _loc3_.showEnd > playerModel.nowDate)
         {
            return _loc3_;
         }
         return null;
      }
      
      public function findDataByType(param1:int) : FunnyData
      {
         var _loc2_:FunnyData = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(isOtherType(param1))
         {
            if(_otherDataDic[param1] is Array && _otherDataDic[param1].length > 0)
            {
               for each(_loc2_ in _otherDataDic[param1])
               {
                  if(_loc2_.showStart < playerModel.nowDate && _loc2_.showEnd > playerModel.nowDate)
                  {
                     return _loc2_;
                  }
               }
            }
         }
         else if(isTiroType(param1))
         {
            _loc4_ = 0;
            while(_loc4_ < tiroFunnyList.length)
            {
               if(tiroFunnyList[_loc4_].type == param1)
               {
                  _loc2_ = tiroFunnyList[_loc4_];
               }
               _loc4_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < data.length)
            {
               if(data[_loc3_].type == param1)
               {
                  _loc2_ = data[_loc3_];
               }
               _loc3_++;
            }
         }
         if(_loc2_ && _loc2_.showStart < playerModel.nowDate && _loc2_.showEnd > playerModel.nowDate)
         {
            return _loc2_;
         }
         return null;
      }
      
      public function get otherList() : Dictionary
      {
         return _otherDataDic;
      }
      
      public function get tiroFunnyList() : Array
      {
         return _tiroFunnyList;
      }
      
      public function get continuePayRebateData() : FunnyData
      {
         return findActiveTimeData(_continuePayRebateRewardData);
      }
      
      public function get continuePayRebateRewardData() : Vector.<FunnyData>
      {
         return _continuePayRebateRewardData;
      }
      
      public function get continuePayRebateChestData() : Vector.<FunnyData>
      {
         return _continuePayRebateChestData;
      }
      
      public function get data() : Vector.<FunnyData>
      {
         return _data;
      }
      
      public function cleanData() : void
      {
         var _loc1_:FunnyData = null;
         while(_data && _data.length > 0)
         {
            _loc1_ = _data.pop();
            if(_loc1_ && _loc1_.type != 1007)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         while(_tiroFunnyList && _tiroFunnyList.length > 0)
         {
            _loc1_ = _tiroFunnyList.pop() as FunnyData;
            if(_loc1_)
            {
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         while(_continuePayRebateRewardData.length > 0)
         {
            _continuePayRebateRewardData.pop().dispose();
         }
         while(_continuePayRebateChestData.length > 0)
         {
            _continuePayRebateChestData.pop().dispose();
         }
         _otherDataDic[14] = [];
         _otherDataDic[15] = [];
         _otherDataDic[51] = [];
         _otherDataDic[146] = [];
         _otherDataDic[70] = [];
         _otherDataDic[145] = [];
         _otherDataDic[197] = [];
         _otherDataDic[73] = [];
      }
      
      public function get wanBagData() : FunnyBagData
      {
         var _loc1_:* = null;
         if(_loc1_ == null)
         {
            return null;
         }
         if(_loc1_.bagList.length > 0)
         {
            return _loc1_.bagList[0];
         }
         return null;
      }
      
      public function get rechargeBagData() : FunnyBagData
      {
         var _loc1_:FunnyData = findDataByType(15);
         if(_loc1_ == null)
         {
            return null;
         }
         if(_loc1_.bagList.length > 0)
         {
            return _loc1_.bagList[0];
         }
         return null;
      }
      
      public function get rechargeBagDataArr() : Vector.<FunnyBagData>
      {
         var _loc1_:FunnyData = findDataByType(15);
         if(_loc1_ == null)
         {
            return null;
         }
         if(_loc1_.bagList.length > 0)
         {
            return _loc1_.bagList;
         }
         return null;
      }
      
      public function get crossCostFunnyData() : FunnyData
      {
         var _loc1_:FunnyData = findDataByType(197);
         if(_loc1_ == null)
         {
            return null;
         }
         return _loc1_;
      }
      
      public function get notCrossCostFunnyData() : FunnyData
      {
         var _loc1_:FunnyData = findDataByType(73);
         if(_loc1_ == null)
         {
            return null;
         }
         return _loc1_;
      }
      
      public function get rechargeFlag() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<FunnyBagData> = rechargeBagDataArr;
         if(_loc1_)
         {
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               if((_loc1_[_loc2_] as FunnyBagData).status == 3)
               {
                  if(_currRechargeIndex != _loc2_)
                  {
                     _currRechargeIndex = _loc2_;
                     NotificationManager.instance.sendNotification("RECHARGE_EFF");
                  }
                  return true;
               }
               _loc2_++;
            }
         }
         return false;
      }
      
      public function get timingBagData() : FunnyBagData
      {
         var _loc5_:int = 0;
         var _loc3_:FunnyData = findDataByType(50);
         if(_loc3_ == null || _loc3_.showStart > playerModel.nowDate || _loc3_.showEnd < playerModel.nowDate)
         {
            return null;
         }
         var _loc4_:int = _loc3_.startTime / 1000;
         var _loc1_:int = 0;
         var _loc2_:int = int(_loc3_.bagList.length);
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc1_ = _loc3_.bagList[_loc5_].conditionList[0].value * 60;
            if(_loc4_ + _loc1_ > playerModel.sysCurTimeBySecond)
            {
               if(_loc3_.bagList[_loc5_].status != 2)
               {
                  return _loc3_.bagList[_loc5_];
               }
               if(_loc5_ < _loc2_ - 1)
               {
                  return _loc3_.bagList[_loc5_ + 1];
               }
            }
            _loc5_++;
         }
         return null;
      }
      
      public function get regressionBagData() : FunnyBagData
      {
         var _loc1_:int = 0;
         if(regression == null)
         {
            return null;
         }
         _loc1_ = 0;
         while(_loc1_ < regression.bagList.length)
         {
            if(regression.bagList[_loc1_].status != 2 && regression.bagList[_loc1_].isShow)
            {
               return regression.bagList[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get onLineCurrentData() : FunnyBagData
      {
         var _loc2_:int = 0;
         var _loc1_:FunnyData = findDataByType(14);
         if(_loc1_ == null)
         {
            return null;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_.bagList.length)
         {
            if(_loc1_.bagList[_loc2_].status != 2)
            {
               return _loc1_.bagList[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      public function get hallFameDataArr() : Vector.<FunnyBagData>
      {
         var _loc1_:FunnyData = findDataByType(146);
         if(_loc1_ == null)
         {
            return null;
         }
         if(_loc1_.bagList.length > 0)
         {
            _loc1_.bagList.sort(hallFameSort);
            return _loc1_.bagList;
         }
         return null;
      }
      
      private function hallFameSort(param1:FunnyBagData, param2:FunnyBagData) : int
      {
         if(param1.conditionList[0].value > param2.conditionList[0].value)
         {
            return -1;
         }
         if(param1.conditionList[0].value < param2.conditionList[0].value)
         {
            return 1;
         }
         return 0;
      }
      
      public function setTimingStr() : void
      {
         var _loc1_:* = null;
         var _loc4_:Number = NaN;
         timingStr = "00:00";
         var _loc5_:FunnyData = findDataByType(50);
         if(_loc5_ == null || timingBagData == null)
         {
            return;
         }
         var _loc3_:int = _loc5_.bagList.indexOf(timingBagData);
         if(_loc3_ <= 0)
         {
            _loc4_ = _loc5_.startTime;
         }
         else
         {
            _loc4_ = _loc5_.startTime + _loc5_.bagList[_loc3_ - 1].conditionList[0].value * 60000;
         }
         var _loc2_:Date = new Date(_loc4_);
         timingStr = DateFormatter.getCountDate(_loc2_.hours * 3600 + _loc2_.minutes * 60,2,1);
      }
      
      public function isOtherType(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case 14:
            case 15:
            case 51:
            case 197:
            case 73:
            case 146:
            case 70:
            case 145:
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function isTiroType(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case 45:
            case 42:
            case 6:
            case 19:
            case 39:
            case 25:
            case 11:
            case 37:
            case 36:
            case 38:
            case 41:
               _loc2_ = true;
               break;
            default:
               _loc2_ = false;
         }
         return _loc2_;
      }
      
      public function get currentTiroList() : Array
      {
         var _loc3_:Date = null;
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < tiroFunnyList.length)
         {
            _loc3_ = new Date((tiroFunnyList[_loc2_] as FunnyData).showStart);
            if(_loc3_ < playerModel.sysCurtime)
            {
               _loc1_.push(tiroFunnyList[_loc2_]);
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function get activityList() : Array
      {
         return ActivityManager.Instance.activityList;
      }
      
      public function setActivityBtnState() : void
      {
         var _loc1_:int = 0;
         if(_activityArr == null || _activityArr.length < 0)
         {
            _activityArr = activityList;
         }
         if(_activityArr.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < _activityArr.length)
            {
               if(_activityArr.indexOf(activityList[_loc1_]) < 0)
               {
                  if(canShine)
                  {
                     FunnyManager.instance.dispatchEvent(new FunnyEvent("ITEM_CANGET"));
                  }
               }
               _loc1_++;
            }
         }
         _activityArr = activityList;
      }
      
      public function get loginActiveData() : FunnyData
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < data.length)
         {
            if(data[_loc1_].type == 131 && data[_loc1_].showStart < playerModel.nowDate && data[_loc1_].showEnd > playerModel.nowDate)
            {
               return data[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get continueLoginData() : FunnyData
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < data.length)
         {
            if(data[_loc1_].type == 231 && data[_loc1_].showStart < playerModel.nowDate && data[_loc1_].showEnd > playerModel.nowDate)
            {
               return data[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      public function get eggSummonData() : FunnyData
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < data.length)
         {
            if(data[_loc1_].type == 201 && data[_loc1_].showStart < playerModel.nowDate && data[_loc1_].showEnd > playerModel.nowDate)
            {
               return data[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
      
      private function findActiveTimeData(param1:*) : FunnyData
      {
         var _loc3_:Number = playerModel.nowDate;
         for each(var _loc2_:FunnyData in param1)
         {
            if(_loc3_ >= _loc2_.showStart && _loc3_ <= _loc2_.showEnd)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function get showStartDate() : Number
      {
         return _showStartDate;
      }
      
      public function set showStartDate(param1:Number) : void
      {
         _showStartDate = param1;
      }
      
      public function get showEndDate() : Number
      {
         return _showEndDate;
      }
      
      public function set showEndDate(param1:Number) : void
      {
         _showEndDate = param1;
      }
   }
}

