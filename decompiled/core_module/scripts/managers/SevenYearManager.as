package managers
{
   import com.road.yishi.proto.active.anniversary.SevenYearActiveMsg;
   import com.road.yishi.proto.active.anniversary.SevenYearOrderListMsg;
   import com.road.yishi.proto.active.anniversary.SevenYearQuestionMsg;
   import com.road.yishi.proto.active.anniversary.SevenYearUserMsg;
   import com.road.yishi.proto.module.TreasureBoxUserMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import com.road.yishi.proto.vehicle.SnowVehicleSimpleInfoMsg;
   import mvc.module.sevenyear.SevenYearModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   
   public class SevenYearManager
   {
      
      public static const OP_OPEN_PANEL:int = 0;
      
      public static const OP_BUY_FLAG:int = 1;
      
      public static const OP_PRESENT_FLAG:int = 2;
      
      public static const OP_BUY_GRADE:int = 3;
      
      public static const OP_GET_GRADE_REWARD:int = 4;
      
      public static const OP_GET_GAME_REWARD:int = 5;
      
      public static const OP_GET_ACHIEVEMENT_REWARD:int = 6;
      
      public static const OP_ANSWER:int = 7;
      
      public static const OP_CLOSE_PANEL:int = 8;
      
      private static var _instance:SevenYearManager;
      
      private var _model:SevenYearModel;
      
      public function SevenYearManager()
      {
         super();
         if(_model == null)
         {
            _model = new SevenYearModel();
         }
      }
      
      public static function get instance() : SevenYearManager
      {
         if(!_instance)
         {
            _instance = new SevenYearManager();
         }
         return _instance;
      }
      
      public function get model() : SevenYearModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4986,__sevenYearActiveInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4987,__sevenYearUserInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4988,__sevenYearOrderInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4989,__sevenYearQuestionInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 200,__snowVehicleInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4898,__treasureBoxInfoHandler);
      }
      
      protected function __treasureBoxInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TreasureBoxUserMsg = new TreasureBoxUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TreasureBoxUserMsg;
         model.updateTreasureBoxInfo(_loc2_);
      }
      
      private function __snowVehicleInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SnowVehicleSimpleInfoMsg = new SnowVehicleSimpleInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SnowVehicleSimpleInfoMsg;
         model.snowTeamNum = _loc2_.curNum;
         MsgMan.notifyObserver("UPDATE_SNOW_TEAM_COUNT");
      }
      
      private function __sevenYearActiveInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SevenYearActiveMsg = new SevenYearActiveMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SevenYearActiveMsg;
         model.updateActiveInfo(_loc2_);
      }
      
      private function __sevenYearUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SevenYearUserMsg = new SevenYearUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SevenYearUserMsg;
         model.updateUserInfo(_loc2_);
      }
      
      private function __sevenYearOrderInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SevenYearOrderListMsg = new SevenYearOrderListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SevenYearOrderListMsg;
         model.updateOrderInfo(_loc2_);
      }
      
      private function __sevenYearQuestionInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:SevenYearQuestionMsg = new SevenYearQuestionMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as SevenYearQuestionMsg;
         model.updateQuestionInfo(_loc2_);
      }
      
      public function sendOp(param1:int, param2:String = "", param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9692);
         var _loc4_:PlayerOpMsg = new PlayerOpMsg();
         _loc4_.op = param1;
         if(param2 != "")
         {
            _loc4_.param1 = param2;
         }
         if(param3 > 0)
         {
            _loc4_.templateId = param3;
         }
         _loc4_.type = 0;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public function sendBuyFlag(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9692);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 1;
         _loc2_.type = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public function sendSendFlag(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(9692);
         var _loc3_:PlayerOpMsg = new PlayerOpMsg();
         _loc3_.op = 2;
         _loc3_.param1 = param2;
         _loc3_.type = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public function openTreasureBox(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9695);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = 0;
         _loc2_.templateId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
   }
}

