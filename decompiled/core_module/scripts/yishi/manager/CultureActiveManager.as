package yishi.manager
{
   import com.road.yishi.proto.culture.CultureMsg;
   import com.road.yishi.proto.culture.CultureOpMsg;
   import com.road.yishi.proto.culture.CultureOrdersMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import mvc.module.culture.CultureConditionInfo;
   import mvc.module.culture.CultureModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class CultureActiveManager
   {
      
      public static const OP_CLIENT_REQUEST:uint = 1;
      
      public static const OP_CLIENT_REWARD:uint = 2;
      
      public static const OP_CLIENT_RANK:uint = 3;
      
      private static var _instance:CultureActiveManager;
      
      private var _model:CultureModel;
      
      private var _rankMsg:CultureOrdersMsg;
      
      public var openCultureActive:Boolean = false;
      
      public function CultureActiveManager()
      {
         super();
         _model = new CultureModel();
      }
      
      public static function get instance() : CultureActiveManager
      {
         if(!_instance)
         {
            _instance = new CultureActiveManager();
         }
         return _instance;
      }
      
      public function get model() : CultureModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 437,__cultureListHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 436,__cultureRankHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 435,__openstateHandler);
      }
      
      private function __cultureListHandler(param1:SLGSocketEvent) : void
      {
         var _loc7_:CultureConditionInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:CultureMsg = new CultureMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as CultureMsg;
         _model.uuid = _loc2_.uuid;
         _model.openTime = _loc2_.openTime;
         _model.stopTime = _loc2_.stopTime;
         _model.needScore1 = _loc2_.needScore1;
         _model.needScore2 = _loc2_.needScore2;
         _model.myTotalScore = _loc2_.myTotalScore;
         _model.myConsortiaScore = _loc2_.myConsortiaScore;
         _model.myServerScore = _loc2_.myServerScore;
         var _loc4_:int = int(_loc2_.condition.length);
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = new CultureConditionInfo();
            _loc7_.sonType = _loc2_.condition[_loc5_].sonType;
            _loc7_.cultureCount = _loc2_.condition[_loc5_].cultureCount;
            _loc7_.myCultureCount = _loc2_.condition[_loc5_].myCultureCount;
            _loc7_.cultureGrade = _loc2_.condition[_loc5_].cultureGrade;
            _loc7_.scoreItem = _loc2_.condition[_loc5_].scoreItem;
            _loc7_.scoreReward = _loc2_.condition[_loc5_].scoreReward;
            _loc7_.rewardLevel = _loc2_.condition[_loc5_].rewardLevel;
            _loc7_.rewardType = _loc2_.condition[_loc5_].rewardType;
            _loc7_.rewardItems = _loc2_.condition[_loc5_].rewardItems;
            _loc7_.rewardState = _loc2_.condition[_loc5_].rewardState;
            if(_loc7_.rewardState == 0)
            {
               _loc7_.rewardStateTemp = 2;
            }
            else if(_loc7_.rewardState == 1)
            {
               _loc7_.rewardStateTemp = 1;
            }
            else if(_loc7_.rewardState == 2)
            {
               _loc7_.rewardStateTemp = 3;
            }
            _loc3_.push(_loc7_);
            _loc5_ += 1;
         }
         _model.condition = sortList(_loc3_);
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CULTURE_INFO_UPDATE"));
         InfoTipsManager.instance.dealData(31);
      }
      
      private function sortList(param1:Array) : Array
      {
         var _loc10_:CultureConditionInfo = null;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Array = [];
         var _loc2_:Array = [];
         var _loc4_:Array = [];
         var _loc3_:Array = [];
         var _loc5_:int = int(param1.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc10_ = param1[_loc6_];
            if(_loc10_.rewardState == 2)
            {
               _loc3_.push(_loc10_);
            }
            else
            {
               _loc9_ = _loc10_.myCultureCount;
               _loc7_ = int(_loc10_.cultureCount < 1 ? 1 : _loc10_.cultureCount);
               if(_loc7_ <= _loc9_)
               {
                  _loc2_.push(_loc10_);
               }
               else
               {
                  _loc4_.push(_loc10_);
               }
            }
            _loc6_ += 1;
         }
         _loc2_.sortOn("sonType",16);
         _loc4_.sortOn("sonType",16);
         _loc3_.sortOn("sonType",16);
         return _loc8_.concat(_loc2_,_loc4_,_loc3_);
      }
      
      private function __cultureRankHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CultureOrdersMsg = new CultureOrdersMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CultureOrdersMsg;
         _rankMsg = _loc2_;
         NotificationManager.instance.dispatchEvent(new NotificationEvent("CULTURE_RANK_UPDATE"));
      }
      
      private function __openstateHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         openCultureActive = _loc2_.param7;
         NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
      }
      
      public function get rankMsgArr() : Array
      {
         return _rankMsg.info;
      }
      
      public function get rankMsg() : CultureOrdersMsg
      {
         return _rankMsg;
      }
      
      public function getCultureActiveByIndex(param1:int) : Array
      {
         var _loc3_:CultureConditionInfo = null;
         var _loc4_:int = 0;
         var _loc2_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _model.condition.length)
         {
            _loc3_ = _model.condition[_loc4_];
            if(_loc3_.rewardType == param1)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function getCultureActiveCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:CultureConditionInfo = null;
         var _loc3_:int = 0;
         if(!_model || !_model.condition)
         {
            return 0;
         }
         _loc3_ = 0;
         while(_loc3_ < _model.condition.length)
         {
            _loc1_ = _model.condition[_loc3_];
            if(_loc1_.rewardState == 1)
            {
               _loc2_++;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function OperateCultureReq(param1:int, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0) : void
      {
         var _loc7_:PackageOut = new PackageOut(9647);
         var _loc6_:CultureOpMsg = new CultureOpMsg();
         _loc6_.op = param1;
         _loc6_.sonType = param2;
         _loc6_.takeRewardType = param3;
         _loc6_.takeRewardLevel = param4;
         _loc6_.rankType = param5;
         SocketSendManager.instance.sendProtoBuffer(_loc7_,_loc6_);
      }
   }
}

