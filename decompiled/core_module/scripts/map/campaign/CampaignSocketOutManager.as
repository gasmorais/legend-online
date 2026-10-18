package map.campaign
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.CampaignFogDataListReqMsg;
   import com.road.yishi.proto.campaign.CampaignFogDataReqMsg;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.HangupAttackMsg;
   import com.road.yishi.proto.campaign.SingleHeroReqMsg;
   import com.road.yishi.proto.fantasymatirx.FantasyMatrixRequestMsg;
   import com.road.yishi.proto.room.RoomExitMsg;
   import com.road.yishi.proto.room.RoomReqMsg;
   import com.road.yishi.proto.vehicle.Position;
   import com.road.yishi.proto.vehicle.VehicleAttackReqMsg;
   import com.road.yishi.proto.vehicle.VehicleMoveMsg;
   import com.road.yishi.proto.vehicle.VehiclePickPropMsg;
   import map.campaign.data.CampaignArmy;
   import yishi.comm.PackageOut;
   import yishi.manager.BaseManager;
   import yishi.service.managers.SocketManager;
   
   public class CampaignSocketOutManager
   {
      
      private static var _instance:CampaignSocketOutManager;
      
      private var _sendSnowByteCount:int = 0;
      
      public function CampaignSocketOutManager()
      {
         super();
      }
      
      public static function get instance() : CampaignSocketOutManager
      {
         if(!_instance)
         {
            _instance = new CampaignSocketOutManager();
         }
         return _instance;
      }
      
      public function questCampaignAllEnemy(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5038);
         var _loc2_:CampaignReqMsg = new CampaignReqMsg();
         _loc2_.paraInt1 = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public function sendCampaignFinish(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5180);
         var _loc2_:CampaignReqMsg = new CampaignReqMsg();
         _loc2_.paraInt1 = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public function getFallChest(param1:String, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5129);
         var _loc4_:CampaignReqMsg = new CampaignReqMsg();
         _loc4_.paraString1 = param1;
         _loc4_.paraInt1 = param2;
         _loc4_.paraInt2 = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public function sendReturnCampaignRoom(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(5025);
         var _loc3_:RoomExitMsg = new RoomExitMsg();
         if(param2)
         {
            _loc3_.msg = "kill self";
            sendProtoBuffer(_loc3_,_loc4_);
         }
         else
         {
            _loc3_.msg = "";
            sendProtoBuffer(_loc3_,_loc4_);
         }
      }
      
      public function sendExitCampaignScene(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5120);
         var _loc2_:RoomExitMsg = new RoomExitMsg();
         _loc2_.msg = "";
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public function sendCampaignCard(param1:Boolean, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5122);
         var _loc4_:CampaignReqMsg = new CampaignReqMsg();
         _loc4_.paraInt1 = param3;
         _loc4_.paraBool1 = param1;
         _loc4_.paraInt2 = param2;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public function sendUpdateFogData(param1:Array, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc6_:CampaignFogDataReqMsg = null;
         var _loc5_:PackageOut = new PackageOut(5126);
         var _loc3_:CampaignFogDataListReqMsg = new CampaignFogDataListReqMsg();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc6_ = new CampaignFogDataReqMsg();
            _loc6_.index = param1[_loc4_].index;
            _loc6_.fogByte = param1[_loc4_].value;
            _loc3_.dataList.push(_loc6_);
            _loc4_++;
         }
         sendProtoBuffer(_loc3_,_loc5_);
      }
      
      public function sendTranseferState(param1:Message) : void
      {
         var _loc2_:PackageOut = new PackageOut(8301);
         sendProtoBuffer(param1,_loc2_);
      }
      
      public function requestWarFightOrderList() : void
      {
         var _loc1_:PackageOut = new PackageOut(8337);
         send(_loc1_);
      }
      
      public function warMaxhp() : void
      {
         var _loc1_:PackageOut = new PackageOut(8338);
         send(_loc1_);
      }
      
      public function sendMapPkInviteTo(param1:int) : void
      {
         var _loc3_:CampaignArmy = CampaignManager.instance.mapModel.selfMemberData;
         var _loc4_:PackageOut = new PackageOut(8525);
         var _loc2_:HangupAttackMsg = new HangupAttackMsg();
         _loc2_.op = 1;
         _loc2_.attackId = _loc3_.userId;
         _loc2_.attackName = _loc3_.nickName;
         _loc2_.defenceId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc2_);
      }
      
      public function buyCount(param1:int, param2:int = 1) : void
      {
         var _loc4_:PackageOut = new PackageOut(9536);
         var _loc3_:SingleHeroReqMsg = new SingleHeroReqMsg();
         _loc3_.op = param1;
         _loc3_.payType = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      public function sendCrossCmapignKillOutSelect(param1:int, param2:String = "") : void
      {
         var _loc4_:PackageOut = new PackageOut(25152);
         var _loc3_:RoomReqMsg = new RoomReqMsg();
         _loc3_.state = param1;
         _loc3_.serverName = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      public function sendEnterActiveVehicle() : void
      {
         var _loc1_:PackageOut = new PackageOut(9587);
         send(_loc1_);
      }
      
      public function sendEnterSnowBallVehicle(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9587);
         var _loc2_:CampaignReqMsg = new CampaignReqMsg();
         _loc2_.paraInt1 = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public function sendLeaveActiveVehicle() : void
      {
         var _loc1_:PackageOut = new PackageOut(8610);
         send(_loc1_);
      }
      
      public function sendCastSkill(param1:int, param2:Array, param3:Array, param4:int = 0, param5:int = 0) : void
      {
         var _loc7_:PackageOut = new PackageOut(8616);
         var _loc6_:VehicleAttackReqMsg = new VehicleAttackReqMsg();
         _loc6_.skillId = param1;
         _loc6_.effectX = param4;
         _loc6_.effectY = param5;
         _loc6_.suffererId = param2;
         if(param3 && param3.length > 0)
         {
            _loc6_.suffererNpcId = param3[0];
         }
         BaseManager.instance.sendVehicleByteCount++;
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc6_,BaseManager.instance.sendVehicleByteCount);
      }
      
      public function sendSnowBallCastSkill(param1:int, param2:String, param3:int, param4:Array, param5:Array, param6:Array, param7:int = 0, param8:int = 0) : void
      {
         var _loc10_:PackageOut = new PackageOut(25216);
         var _loc9_:VehicleAttackReqMsg = new VehicleAttackReqMsg();
         _loc9_.skillId = param3;
         _loc9_.effectX = param7;
         _loc9_.effectY = param8;
         _loc9_.attackServerName = param2;
         _loc9_.suffererId.push.apply(null,param4);
         _loc9_.suffererServerName.push.apply(null,param5);
         _loc9_.suffererNpcIdArray.push.apply(null,param6);
         _sendSnowByteCount = _sendSnowByteCount + 1;
         SocketManager.instance.socket.sendProtobuffer(_loc10_,_loc9_,_sendSnowByteCount);
      }
      
      public function sendActiveVehicleArmyMove(param1:int, param2:Array) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Position = null;
         if(!CampaignManager.instance.activeVehicleModel)
         {
            return;
         }
         if(CampaignManager.instance.mapModel.selfMemberData.userId != param1)
         {
            return;
         }
         var _loc7_:PackageOut = new PackageOut(8615);
         var _loc3_:VehicleMoveMsg = new VehicleMoveMsg();
         _loc3_.playerId = param1;
         var _loc6_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < param2.length)
         {
            _loc4_ = new Position();
            _loc4_.x = param2[_loc5_].x;
            _loc4_.y = param2[_loc5_].y;
            _loc6_.push(_loc4_);
            _loc5_++;
         }
         _loc3_.path = _loc6_;
         BaseManager.instance.sendVehicleByteCount++;
         SocketManager.instance.socket.sendProtobuffer(_loc7_,_loc3_,BaseManager.instance.sendVehicleByteCount);
      }
      
      public function sendSnowBallActiveVehicleArmyMove(param1:int, param2:Array, param3:String) : void
      {
         var _loc6_:int = 0;
         var _loc5_:Position = null;
         if(!CampaignManager.instance.activeVehicleModel)
         {
            return;
         }
         if(CampaignManager.instance.mapModel.selfMemberData.userId != param1)
         {
            return;
         }
         var _loc8_:PackageOut = new PackageOut(25218);
         var _loc4_:VehicleMoveMsg = new VehicleMoveMsg();
         _loc4_.playerId = param1;
         _loc4_.serverName = param3;
         var _loc7_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            _loc5_ = new Position();
            _loc5_.x = param2[_loc6_].x;
            _loc5_.y = param2[_loc6_].y;
            _loc7_.push(_loc5_);
            _loc6_++;
         }
         _loc4_.path = _loc7_;
         _sendSnowByteCount = _sendSnowByteCount + 1;
         SocketManager.instance.socket.sendProtobuffer(_loc8_,_loc4_,_sendSnowByteCount);
      }
      
      public function sendActiveVehiclePickup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8617);
         var _loc2_:VehiclePickPropMsg = new VehiclePickPropMsg();
         _loc2_.propNodeId = param1;
         BaseManager.instance.sendVehicleByteCount++;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_,BaseManager.instance.sendVehicleByteCount);
      }
      
      public function sendSnowBallActiveVehiclePickup(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(25217);
         var _loc3_:VehiclePickPropMsg = new VehiclePickPropMsg();
         _loc3_.serverName = param2;
         _loc3_.propNodeId = param1;
         _sendSnowByteCount = _sendSnowByteCount + 1;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_,_sendSnowByteCount);
      }
      
      public function sendFantasyMatrixFight(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8473);
         var _loc3_:FantasyMatrixRequestMsg = new FantasyMatrixRequestMsg();
         _loc3_.op = 5;
         _loc3_.posX = param1;
         _loc3_.posY = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      public function sendFantasyMatrixUseSkill(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8473);
         var _loc2_:FantasyMatrixRequestMsg = new FantasyMatrixRequestMsg();
         _loc2_.op = 6;
         _loc2_.skillId = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public function sendStartCampaign(param1:int = 0, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(5039);
         var _loc3_:CampaignReqMsg = new CampaignReqMsg();
         _loc3_.paraInt1 = param2;
         _loc3_.paraInt2 = param1;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      public function sendSingleCampaignFight() : void
      {
         var _loc1_:PackageOut = new PackageOut(8666);
         send(_loc1_);
      }
      
      private function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
      
      private function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
   }
}

