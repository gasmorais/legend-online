package yishi.manager
{
   import com.road.yishi.proto.battle.GuardOnFightMsg;
   import com.road.yishi.proto.guardendless.GuardEndlessItemMsg;
   import com.road.yishi.proto.guardendless.GuardEndlessPosMsg;
   import com.road.yishi.proto.guardendless.GuardendlessOpMsg;
   import com.road.yishi.proto.hugehead.HugeHeadBattleFieldMsg;
   import com.road.yishi.proto.hugehead.HugeHeadMySignInStateMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleFieldMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleReqMsg;
   import com.road.yishi.proto.hugehead.HugeHeadNodeBattleUserMsg;
   import com.road.yishi.proto.hugehead.HugeHeadRequestMsg;
   import com.road.yishi.proto.hugehead.HugeHeadStateMsg;
   import com.road.yishi.proto.hugehead.StackHeadBattleDefenceMsg;
   import com.road.yishi.proto.hugehead.StackHeadBattleFieldMsg;
   import com.road.yishi.proto.hugehead.StackHeadForceUserListMsg;
   import com.road.yishi.proto.hugehead.StackHeadRequestMsg;
   import com.road.yishi.proto.hugehead.StackHeadSelfMsg;
   import com.road.yishi.proto.hugehead.StackHeadSeniorGeneralMsg;
   import com.road.yishi.proto.shuttle.ArcaneZoneMsg;
   import com.road.yishi.proto.shuttle.ArcaneZoneRequestMsg;
   import com.road.yishi.proto.shuttle.ShuttleInfoMsg;
   import com.road.yishi.proto.shuttle.ShuttleRequestMsg;
   import com.road.yishi.proto.stackhead.StackHeadExploreReqMsg;
   import com.road.yishi.proto.stackhead.StackHeadExploreResMsg;
   import com.road.yishi.proto.titanland.TitanlandOpMsg;
   import mvc.module.outyard.AbysmModel;
   import mvc.module.outyard.OutyardAreaModel;
   import mvc.module.outyard.OutyardCrystalModel;
   import mvc.module.outyard.OutyardModel;
   import mvc.module.outyard.OutyardShuttleModel;
   import mvc.module.outyard.OutyardTitanModel;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class OutyardManager
   {
      
      private static var _instance:OutyardManager;
      
      private var _model:OutyardModel;
      
      private var _crystalModel:OutyardCrystalModel;
      
      private var _areaModel:OutyardAreaModel;
      
      private var _titanModel:OutyardTitanModel;
      
      private var _shuttleModel:OutyardShuttleModel;
      
      private var _abysmModel:AbysmModel;
      
      public function OutyardManager()
      {
         super();
         _model = new OutyardModel();
         _crystalModel = new OutyardCrystalModel();
         _areaModel = new OutyardAreaModel();
         _titanModel = new OutyardTitanModel();
         _shuttleModel = new OutyardShuttleModel();
         _abysmModel = new AbysmModel();
      }
      
      public static function get instance() : OutyardManager
      {
         if(!_instance)
         {
            _instance = new OutyardManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 306,__stateInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 349,__fullInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 350,__mySignInHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 308,__crystalHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 309,__userlistHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 310,__battleDefenceHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 311,__selfInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 351,__battleFieldHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 352,__battleUserHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 361,__exploreHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 375,__titanLandHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4460,__shuttleHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4451,__arcaneHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 423,__abysmHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 427,__abysmFightHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 428,__rewarldHandler);
      }
      
      private function __stateInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HugeHeadStateMsg = new HugeHeadStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HugeHeadStateMsg;
         _model.stateInfoHandler(_loc2_);
      }
      
      private function __fullInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HugeHeadBattleFieldMsg = new HugeHeadBattleFieldMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HugeHeadBattleFieldMsg;
         _model.fullInfoHandler(_loc2_);
      }
      
      private function __mySignInHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HugeHeadMySignInStateMsg = new HugeHeadMySignInStateMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HugeHeadMySignInStateMsg;
         _model.mySignInHandler(_loc2_);
      }
      
      private function __crystalHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StackHeadBattleFieldMsg = new StackHeadBattleFieldMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StackHeadBattleFieldMsg;
         _crystalModel.crystalHandler(_loc2_);
      }
      
      private function __userlistHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StackHeadForceUserListMsg = new StackHeadForceUserListMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StackHeadForceUserListMsg;
         _crystalModel.userlistHandler(_loc2_);
      }
      
      private function __battleDefenceHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StackHeadBattleDefenceMsg = new StackHeadBattleDefenceMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StackHeadBattleDefenceMsg;
         _crystalModel.battleDefenceHandler(_loc2_);
      }
      
      private function __selfInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StackHeadSelfMsg = new StackHeadSelfMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StackHeadSelfMsg;
         _crystalModel.selfInfoHandler(_loc2_);
      }
      
      private function __battleFieldHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HugeHeadNodeBattleFieldMsg = new HugeHeadNodeBattleFieldMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HugeHeadNodeBattleFieldMsg;
         _model.battleFieldHandler(_loc2_);
      }
      
      private function __battleUserHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:HugeHeadNodeBattleUserMsg = new HugeHeadNodeBattleUserMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as HugeHeadNodeBattleUserMsg;
         _model.battleUserHandler(_loc2_);
      }
      
      private function __exploreHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StackHeadExploreResMsg = new StackHeadExploreResMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StackHeadExploreResMsg;
         _areaModel.exploreResHandler(_loc2_);
      }
      
      private function __titanLandHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:TitanlandOpMsg = new TitanlandOpMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as TitanlandOpMsg;
         _titanModel.titanHandler(_loc2_);
      }
      
      private function __shuttleHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ShuttleInfoMsg = new ShuttleInfoMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ShuttleInfoMsg;
         _shuttleModel.shuttleHandler(_loc2_);
      }
      
      private function __arcaneHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArcaneZoneMsg = new ArcaneZoneMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as ArcaneZoneMsg;
         _shuttleModel.arcaneHandler(_loc2_);
      }
      
      private function __abysmHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GuardendlessOpMsg = new GuardendlessOpMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GuardendlessOpMsg;
         _abysmModel.abysmInfoHandler(_loc2_);
      }
      
      private function __abysmFightHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:GuardOnFightMsg = new GuardOnFightMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as GuardOnFightMsg;
         _abysmModel.abysmChildFightId = _loc2_.guardId;
         NotificationManager.instance.sendNotification("ABYSM_FIGHT_INFO_UPDATA");
      }
      
      private function __rewarldHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:GuardEndlessItemMsg = new GuardEndlessItemMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as GuardEndlessItemMsg;
         if(_loc2_.type == 2)
         {
            _loc3_ = {};
            _loc3_.count = _loc2_.count;
            _loc3_.items = _loc2_.items;
            _abysmModel.mopupList.push(_loc3_);
            _abysmModel.updateMopup(_loc3_);
         }
      }
      
      public function get model() : OutyardModel
      {
         return _model;
      }
      
      public function get crystalModel() : OutyardCrystalModel
      {
         return _crystalModel;
      }
      
      public function get areaModel() : OutyardAreaModel
      {
         return _areaModel;
      }
      
      public function get titanModel() : OutyardTitanModel
      {
         return _titanModel;
      }
      
      public function get shuttleModel() : OutyardShuttleModel
      {
         return _shuttleModel;
      }
      
      public function get abysmModel() : AbysmModel
      {
         return _abysmModel;
      }
      
      public function OperateMapOutyard(param1:int, param2:int = 0, param3:int = 0, param4:String = "", param5:String = "", param6:String = "") : void
      {
         var _loc8_:PackageOut = new PackageOut(9594);
         var _loc7_:HugeHeadRequestMsg = new HugeHeadRequestMsg();
         _loc7_.op = param1;
         _loc7_.nodeId = param2;
         _loc7_.side = param3;
         _loc7_.notice = param4;
         _loc7_.userUid = param5;
         _loc7_.battleFieldUid = param6;
         SocketSendManager.instance.sendProtoBuffer(_loc8_,_loc7_);
      }
      
      public function OperateRoute(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(9595);
         var _loc3_:HugeHeadNodeBattleReqMsg = new HugeHeadNodeBattleReqMsg();
         _loc3_.op = param1;
         _loc3_.pos = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function OperateArea(param1:int, param2:int = 0, param3:Array = null, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(9608);
         var _loc5_:StackHeadExploreReqMsg = new StackHeadExploreReqMsg();
         _loc5_.op = param1;
         _loc5_.diceId = param2;
         _loc5_.payType = param4;
         if(param3 != null)
         {
            _loc5_.linePath = param3;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function OperateOutyard(param1:int, param2:int = 0, param3:String = "", param4:StackHeadSeniorGeneralMsg = null) : void
      {
         var _loc6_:PackageOut = new PackageOut(9599);
         var _loc5_:StackHeadRequestMsg = new StackHeadRequestMsg();
         _loc5_.op = param1;
         _loc5_.forceIndex = param2;
         _loc5_.seniorGeneral = param4;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function OperateTitan(param1:int, param2:int = 0, param3:int = 0) : void
      {
         var _loc5_:PackageOut = new PackageOut(9617);
         var _loc4_:TitanlandOpMsg = new TitanlandOpMsg();
         _loc4_.op = param1;
         _loc4_.payType = param2;
         _loc4_.skillIndex = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function OperateShuttle(param1:int, param2:int = 0, param3:int = 0, param4:int = 0, param5:int = 0, param6:Array = null, param7:int = 1) : void
      {
         var _loc9_:PackageOut = new PackageOut(8475);
         var _loc8_:ShuttleRequestMsg = new ShuttleRequestMsg();
         _loc8_.op = param1;
         _loc8_.petList = param6 == null ? [0,0,0] : param6;
         _loc8_.fightPet = param2;
         _loc8_.difficulty = param3;
         _loc8_.area = param4;
         _loc8_.rewardIndex = param5;
         _loc8_.payType = param7;
         SocketSendManager.instance.sendProtoBuffer(_loc9_,_loc8_);
      }
      
      public function OperateArcane(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8476);
         var _loc3_:ArcaneZoneRequestMsg = new ArcaneZoneRequestMsg();
         _loc3_.op = param1;
         _loc3_.bossId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function OperateArcaneShare(param1:int, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(15058);
         var _loc3_:ArcaneZoneRequestMsg = new ArcaneZoneRequestMsg();
         _loc3_.op = param1;
         _loc3_.bossId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function abysmSendInfo(param1:int, param2:Array = null) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:GuardEndlessPosMsg = null;
         var _loc8_:PackageOut = new PackageOut(9644);
         var _loc3_:GuardendlessOpMsg = new GuardendlessOpMsg();
         _loc3_.opType = param1;
         if(param2)
         {
            _loc5_ = int(param2.length);
            _loc4_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = new GuardEndlessPosMsg();
               _loc7_.param1 = param2[_loc6_].childId;
               _loc7_.param2 = param2[_loc6_].attackPos;
               _loc7_.param3 = param2[_loc6_].pos;
               _loc4_.push(_loc7_);
               _loc6_ += 1;
            }
            _loc3_.guardPos = _loc4_;
         }
         _loc3_.isHorrible = _abysmModel.isHorrible;
         if(param1 == 3)
         {
            _loc3_.index = _abysmModel.index;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc8_,_loc3_);
      }
      
      public function sendMopup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9644);
         var _loc2_:GuardendlessOpMsg = new GuardendlessOpMsg();
         _loc2_.opType = 4;
         _loc2_.sweepIndex = param1;
         _loc2_.isHorrible = _abysmModel.isHorrible;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function sendMopupOP(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9644);
         var _loc3_:GuardendlessOpMsg = new GuardendlessOpMsg();
         _loc3_.opType = param1;
         _loc3_.payType = param2;
         _loc3_.isHorrible = _abysmModel.isHorrible;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
   }
}

