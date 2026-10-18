package yishi.manager
{
   import com.road.yishi.proto.allianceregression.ActivityDataMsg;
   import com.road.yishi.proto.allianceregression.ActivityInfo;
   import com.road.yishi.proto.allianceregression.CommonReq;
   import com.road.yishi.proto.allianceregression.OperationResp;
   import com.road.yishi.proto.allianceregression.SearchAllyResp;
   import com.road.yishi.proto.allianceregression.ShopLimitData;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class OldPlayerReturnManager
   {
      
      private static var _instance:OldPlayerReturnManager;
      
      public static const ACTIVITY_INFO_EVENT:String = "ACTIVITY_INFO_EVENT";
      
      public static const USER_DATA_EVENT:String = "USER_DATA_EVENT";
      
      public static const INVITES_DATA_EVENT:String = "INVITES_DATA_EVENT";
      
      public static const SEARCH_ALLY_EVENT:String = "SEARCH_ALLY_EVENT";
      
      public static const SELECTED_ALLYID_EVENT:String = "SELECTED_ALLYID_EVENT";
      
      public static const OP_RECEIVE_TASK_AWARD:int = 0;
      
      public static const OP_RECEIVE_BOX:int = 1;
      
      public static const OP_SEARCH_ALLY:int = 2;
      
      public static const OP_APPLY:int = 3;
      
      public static const OP_REVOKE:int = 4;
      
      public static const OP_APPROVE:int = 5;
      
      public static const OP_RECEIVE_CONTRACT:int = 6;
      
      public static const OP_SHOP_EXCHANGE:int = 7;
      
      public static const OP_TERMINATE_CONTRACT:int = 8;
      
      private var _model:OldPlayerReturnModel;
      
      public function OldPlayerReturnManager()
      {
         super();
      }
      
      public static function get instance() : OldPlayerReturnManager
      {
         if(!_instance)
         {
            _instance = new OldPlayerReturnManager();
         }
         return _instance;
      }
      
      public function get model() : OldPlayerReturnModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         if(!_model)
         {
            _model = new OldPlayerReturnModel();
         }
         addEvent();
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 534,__activityInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 535,__userDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 536,__searchAllyHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 538,__allianceOpRespHandler);
      }
      
      private function __activityInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ActivityInfo = new ActivityInfo();
         _loc2_ = _loc3_.readBody(_loc2_) as ActivityInfo;
         model.isOpen = _loc2_.isOpen;
         model.isShopOpen = _loc2_.isShopOpen;
         model.startDate = _loc2_.startDate;
         model.stopDate = _loc2_.stopDate;
         NotificationManager.instance.sendNotification("ACTIVITY_INFO_EVENT");
      }
      
      private function __userDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ShopLimitData = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ActivityDataMsg = new ActivityDataMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ActivityDataMsg;
         if(_loc2_.hasUserInfo)
         {
            model.type = _loc2_.userInfo.playerType;
            model.status = _loc2_.userInfo.playerStatus;
            model.revokeDate = _loc2_.userInfo.revokeDate;
            model.oracleExp = _loc2_.userInfo.oracleExp;
            model.dailyNum = _loc2_.userInfo.dailyNum;
            model.dailyProcess = _loc2_.userInfo.dailyProcess;
            model.weekNum = _loc2_.userInfo.weekNum;
            model.weekProcess = _loc2_.userInfo.weekProcess;
            model.milestoneScore = _loc2_.userInfo.milestoneScore;
            model.milestoneProcess = _loc2_.userInfo.milestoneProcess;
         }
         if(_loc2_.tasks.length > 0)
         {
            model.refreshTaskData(_loc2_.tasks);
         }
         model.allyList = _loc2_.allys;
         model.applyList = _loc2_.applys;
         model.inviteList = _loc2_.invites;
         if(_loc2_.shopLimit.length > 0)
         {
            model.shopLimitList.clear();
            _loc4_ = 0;
            while(_loc4_ < _loc2_.shopLimit.length)
            {
               _loc3_ = _loc2_.shopLimit[_loc4_];
               model.shopLimitList.add(_loc3_.goodsId,_loc3_.exchangeCount);
               _loc4_++;
            }
         }
         NotificationManager.instance.sendNotification("USER_DATA_EVENT");
      }
      
      private function __searchAllyHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SearchAllyResp = new SearchAllyResp();
         _loc2_ = _loc3_.readBody(_loc2_) as SearchAllyResp;
         model.playerList = _loc2_.players;
         NotificationManager.instance.sendNotification("SEARCH_ALLY_EVENT");
      }
      
      private function __allianceOpRespHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:OperationResp = new OperationResp();
         _loc2_ = _loc3_.readBody(_loc2_) as OperationResp;
         NotificationManager.instance.sendNotification("INVITES_DATA_EVENT",_loc2_);
      }
      
      public function send(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9717);
         var _loc4_:CommonReq = new CommonReq();
         _loc4_.op = param1;
         _loc4_.intParam1 = param2;
         _loc4_.intParam2 = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function sendSearch(param1:String = "") : void
      {
         var _loc3_:PackageOut = new PackageOut(9717);
         var _loc2_:CommonReq = new CommonReq();
         _loc2_.op = 2;
         _loc2_.stringParam1 = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendApprove(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(9717);
         var _loc3_:CommonReq = new CommonReq();
         _loc3_.op = 5;
         _loc3_.intParam1 = param1;
         _loc3_.boolParam1 = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

