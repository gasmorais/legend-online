package mvc.module.fund
{
   import battle.utils.Int64Utils;
   import com.road.yishi.proto.active.ActiveParamMsg;
   import com.road.yishi.proto.active.GetLogMsg;
   import flash.events.EventDispatcher;
   
   public class FundInfo extends EventDispatcher
   {
      
      public static const FUND_NEWBIE:int = 1;
      
      public static const FUND_ACTIVE:int = 2;
      
      private var _activeId:int;
      
      private var _title:String;
      
      private var _contents:String;
      
      private var _activeType:int;
      
      private var _description:String;
      
      private var _actionTimeContent:Number;
      
      private var _consortia:int;
      
      private var _grades:int;
      
      private var _setStartDate:Number;
      
      private var _setEndDate:Number;
      
      private var _getStartDate:Number;
      
      private var _getEndDate:Number;
      
      private var _depositLevel:int;
      
      private var _depositTime:Number;
      
      private var _opType:int;
      
      private var _opParam:int;
      
      private var _activeArr:Array;
      
      private var _getLogArr:Array;
      
      private var _hasGetInfo:Array;
      
      private var _newActiveArr:Array;
      
      private var _getNewLogArr:Array;
      
      private var _chargePoint:int;
      
      private var _currentAchive:ActiveParmaInfo;
      
      public function FundInfo()
      {
         super();
      }
      
      public function isCurrentAchiveInfo(param1:ActiveParmaInfo) : Boolean
      {
         if(!_currentAchive)
         {
            return false;
         }
         return _currentAchive.level == param1.level;
      }
      
      public function get activeId() : int
      {
         return _activeId;
      }
      
      public function set activeId(param1:int) : void
      {
         _activeId = param1;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
      
      public function get contents() : String
      {
         return _contents;
      }
      
      public function set contents(param1:String) : void
      {
         _contents = param1;
      }
      
      public function get activeType() : int
      {
         return _activeType;
      }
      
      public function set activeType(param1:int) : void
      {
         _activeType = param1;
      }
      
      public function get description() : String
      {
         return _description;
      }
      
      public function set description(param1:String) : void
      {
         _description = param1;
      }
      
      public function get actionTimeContent() : Number
      {
         return _actionTimeContent;
      }
      
      public function set actionTimeContent(param1:Number) : void
      {
         _actionTimeContent = param1;
      }
      
      public function get consortia() : int
      {
         return _consortia;
      }
      
      public function set consortia(param1:int) : void
      {
         _consortia = param1;
      }
      
      public function get grades() : int
      {
         return _grades;
      }
      
      public function set grades(param1:int) : void
      {
         _grades = param1;
      }
      
      public function get setStartDate() : Number
      {
         return _setStartDate;
      }
      
      public function set setStartDate(param1:Number) : void
      {
         _setStartDate = param1;
      }
      
      public function get setEndDate() : Number
      {
         return _setEndDate;
      }
      
      public function set setEndDate(param1:Number) : void
      {
         _setEndDate = param1;
      }
      
      public function get getStartDate() : Number
      {
         return _getStartDate;
      }
      
      public function set getStartDate(param1:Number) : void
      {
         _getStartDate = param1;
      }
      
      public function get getEndDate() : Number
      {
         return _getEndDate;
      }
      
      public function set getEndDate(param1:Number) : void
      {
         _getEndDate = param1;
      }
      
      public function get depositLevel() : int
      {
         return _depositLevel;
      }
      
      public function set depositLevel(param1:int) : void
      {
         _depositLevel = param1;
      }
      
      public function get depositTime() : Number
      {
         return _depositTime;
      }
      
      public function set depositTime(param1:Number) : void
      {
         _depositTime = param1;
      }
      
      public function get opType() : int
      {
         return _opType;
      }
      
      public function set opType(param1:int) : void
      {
         _opType = param1;
      }
      
      public function get opParam() : int
      {
         return _opParam;
      }
      
      public function set opParam(param1:int) : void
      {
         _opParam = param1;
      }
      
      public function get activeArr() : Array
      {
         return _activeArr;
      }
      
      public function set activeArr(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:ActiveParmaInfo = null;
         _activeArr = [];
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = new ActiveParmaInfo();
            _loc2_.level = param1[_loc4_].level;
            _loc2_.costDiamond = param1[_loc4_].costDiamond;
            _loc2_.costContract = param1[_loc4_].costContract;
            _loc2_.harvestCount = param1[_loc4_].harvestCount;
            _loc2_.getInfos = param1[_loc4_].getInfos;
            _loc2_.totalGetInfo = param1[_loc4_].itemInfos;
            _activeArr.push(_loc2_);
            _loc4_++;
         }
         _activeArr.sortOn("level",16);
      }
      
      public function get newActiveArr() : Array
      {
         return _newActiveArr;
      }
      
      public function set newActiveArr(param1:Array) : void
      {
         var _loc3_:ActiveParamMsg = null;
         var _loc5_:int = 0;
         var _loc2_:ActiveParmaInfo = null;
         _newActiveArr = [];
         _currentAchive = null;
         if(!param1)
         {
            return;
         }
         var _loc4_:int = int(param1.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = new ActiveParmaInfo();
            _loc3_ = param1[_loc5_] as ActiveParamMsg;
            if(_loc3_)
            {
               _loc2_.level = _loc3_.level;
               _loc2_.costDiamond = _loc3_.costDiamond;
               _loc2_.costContract = _loc3_.costContract;
               _loc2_.harvestCount = _loc3_.harvestCount;
               _loc2_.allGetA = _loc3_.itemInfos;
               _loc2_.allGetB = _loc3_.itemInfos2;
               _loc2_.newGetInfos = _loc3_.getInfos;
               _newActiveArr.push(_loc2_);
               if(chargePoint >= _loc2_.costDiamond)
               {
                  if(!_currentAchive)
                  {
                     _currentAchive = _loc2_;
                  }
                  else if(_loc2_.costDiamond >= _currentAchive.costDiamond)
                  {
                     _currentAchive = _loc2_;
                  }
               }
            }
            _loc5_++;
         }
         _newActiveArr.sortOn("level",0x10 | 2);
      }
      
      public function get getLogArr() : Array
      {
         return _getLogArr;
      }
      
      public function set getLogArr(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:GLogInfo = null;
         _getLogArr = [];
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new GLogInfo();
            _loc4_.type = param1[_loc3_].type;
            _loc4_.time = param1[_loc3_].time;
            _getLogArr.push(_loc4_);
            _loc3_++;
         }
      }
      
      public function getActiveByLevel(param1:int) : ActiveParmaInfo
      {
         var _loc3_:ActiveParmaInfo = null;
         var _loc4_:int = 0;
         var _loc2_:Array = activeArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_] as ActiveParmaInfo;
            if(_loc3_.level == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getNewActiveByLevel(param1:int) : ActiveParmaInfo
      {
         var _loc3_:ActiveParmaInfo = null;
         var _loc4_:int = 0;
         var _loc2_:Array = _newActiveArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_] as ActiveParmaInfo;
            if(_loc3_.level == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function getLosByType(param1:int) : GLogInfo
      {
         var _loc3_:GLogInfo = null;
         var _loc4_:int = 0;
         var _loc2_:Array = getLogArr;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ = _loc2_[_loc4_] as GLogInfo;
            if(_loc3_.type == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function get hasGetInfo() : Array
      {
         return _hasGetInfo;
      }
      
      public function set hasGetInfo(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:GItemInfo = null;
         _hasGetInfo = [];
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new GItemInfo();
            _loc4_.templateId = param1[_loc3_].templateId;
            _loc4_.count = param1[_loc3_].count;
            _hasGetInfo.push(_loc4_);
            _loc3_++;
         }
      }
      
      public function get getNewLogArr() : Array
      {
         return _getNewLogArr;
      }
      
      public function set getNewLogArr(param1:Array) : void
      {
         var _loc2_:GetLogMsg = null;
         var _loc4_:int = 0;
         var _loc5_:GLogInfo = null;
         _getNewLogArr = [];
         if(!param1)
         {
            return;
         }
         var _loc3_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new GLogInfo();
            _loc2_ = param1[_loc4_] as GetLogMsg;
            if(_loc2_)
            {
               _loc5_.type = _loc2_.type;
               _loc5_.time = Int64Utils.int64ToNumber(_loc2_.time);
               _loc5_.sort = _loc2_.sort;
               _getNewLogArr.push(_loc5_);
            }
            _loc4_++;
         }
      }
      
      public function get chargePoint() : int
      {
         return _chargePoint;
      }
      
      public function set chargePoint(param1:int) : void
      {
         _chargePoint = param1;
      }
   }
}

