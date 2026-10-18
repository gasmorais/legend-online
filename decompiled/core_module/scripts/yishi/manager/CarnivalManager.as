package yishi.manager
{
   import com.pickgliss.ui.controls.Frame;
   import com.road.yishi.proto.carnival.CarnivalMsg;
   import com.road.yishi.proto.carnival.CarnivalTaskListMsg;
   import com.road.yishi.proto.carnival.CarnivalTaskMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.events.EventDispatcher;
   import mvc.module.carnival.CarnivalModel;
   import mvc.module.carnival.CarnivalTaskInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   
   public class CarnivalManager extends EventDispatcher
   {
      
      public static const OP_OPEN:int = 1;
      
      public static const OP_SCORE_REWARD:int = 2;
      
      public static const OP_CHARGE_LOTTERY:int = 3;
      
      public static const OP_LUCK_LOTTERY:int = 4;
      
      public static const OP_BUY_GIFT:int = 5;
      
      public static const OP_LUCK_TREASURE:int = 6;
      
      public static const OP_TASK_REWARD:int = 7;
      
      public static const OP_ONLINE_REWARD:int = 8;
      
      public static const OP_GAME:int = 9;
      
      public static const EVENT_UPDATE:String = "carn.EVENT_UPDATE";
      
      private static var _instance:CarnivalManager;
      
      private var _model:CarnivalModel;
      
      public var isOpen:Boolean;
      
      public function CarnivalManager()
      {
         super();
         _model = new CarnivalModel();
      }
      
      public static function get Instance() : CarnivalManager
      {
         if(_instance == null)
         {
            _instance = new CarnivalManager();
         }
         return _instance;
      }
      
      public function get model() : CarnivalModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4304,__activeInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4305,__taskInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4590,__topBtnHandler);
      }
      
      private function __topBtnHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Frame = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as PropertyMsg;
         if(_loc2_.param1 == 4025)
         {
            isOpen = _loc2_.param7;
            if(!isOpen)
            {
               _loc3_ = FrameControllerManager.instance.carnivalController.frame;
               if(_loc3_ && !_loc3_.isDie)
               {
                  _loc3_.dispose();
               }
            }
            NotificationManager.instance.sendNotification("REFRESH_TOPTOOLS");
         }
      }
      
      private function __activeInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:CarnivalMsg = new CarnivalMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as CarnivalMsg;
         _model.score = _loc2_.score;
         _model.scoreRewardInfo = _loc2_.scoreRewardInfo;
         _model.totalCharge = _loc2_.totalCharge;
         _model.lotteryCount = _loc2_.lotteryCount;
         _model.dayCharge = _loc2_.dayCharge;
         _model.giftBuyInfo = _loc2_.giftBuyInfo;
         _model.dayOnline = _loc2_.dayOnline;
         _model.onlineDate = _loc2_.onlineDate;
         _model.onlineRewardInfo = _loc2_.onlineRewardInfo;
         _model.luckCount = _loc2_.luckCount;
         _model.luckNum = _loc2_.luckNum;
         _model.gameInfo = _loc2_.gameInfo;
         _model.result = _loc2_.result;
         this.dispatchEvent(new NotificationEvent("carn.EVENT_UPDATE",_loc2_.opType));
      }
      
      private function __taskInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:CarnivalTaskInfo = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CarnivalTaskListMsg = new CarnivalTaskListMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CarnivalTaskListMsg;
         for each(var _loc3_:CarnivalTaskMsg in _loc2_.tasks)
         {
            _loc5_ = _model.getTaskInfo(_loc3_.taskId);
            if(!_loc5_)
            {
               _loc5_ = new CarnivalTaskInfo();
               _loc5_.taskId = _loc3_.taskId;
               _model.putTaskInfo(_loc5_);
            }
            _loc5_.data = _loc3_.data;
            _loc5_.isReward = _loc3_.isReward ? 1 : 0;
         }
         this.dispatchEvent(new NotificationEvent("carn.EVENT_UPDATE"));
      }
      
      public function opRequest(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9019);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = param1;
         _loc3_.id = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
   }
}

