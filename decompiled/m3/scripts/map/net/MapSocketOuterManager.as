package map.net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.campaign.ArriveAltarReqMsg;
   import com.road.yishi.proto.campaign.CampaignNodeMsg;
   import com.road.yishi.proto.campaign.CampaignReqMsg;
   import com.road.yishi.proto.campaign.HangupAttackMsg;
   import com.road.yishi.proto.campaign.NodeLockReqMsg;
   import com.road.yishi.proto.campaign.WarFieldAttackMsg;
   import com.road.yishi.proto.campaign.WorldBossBufferMsg;
   import com.road.yishi.proto.guildcampaign.GuildMsg;
   import com.road.yishi.proto.vehicle.VehicleAttackReqMsg;
   import com.road.yishi.proto.vehicle.VehiclePickPropMsg;
   import com.road.yishi.proto.worldmap.PosMoveMsg;
   import com.road.yishi.proto.worldmap.RouteMsg;
   import map.campaign.CampaignManager;
   import yishi.comm.PackageOut;
   import yishi.manager.ArmyManager;
   import yishi.service.managers.SocketManager;
   
   public class MapSocketOuterManager
   {
      
      private static var _sendCount:int = 0;
      
      public function MapSocketOuterManager()
      {
         super();
      }
      
      public static function sendAlertState(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8196);
         var _loc3_:NodeLockReqMsg = new NodeLockReqMsg();
         _loc3_.nodeId = param1;
         _loc3_.lock = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      private static function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         _sendCount = _sendCount + 1;
         SocketManager.instance.socket.sendProtobuffer(param2,param1,_sendCount);
      }
      
      public static function sendNpcArrive(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8549);
         var _loc3_:ArriveAltarReqMsg = new ArriveAltarReqMsg();
         _loc3_.nodeId = param1;
         _loc3_.uuId = param2;
         sendProtoBuffer(_loc3_,_loc4_);
      }
      
      public static function sendCampaignArrive(param1:int, param2:int, param3:Boolean = true, param4:int = 0) : void
      {
         var _loc6_:PackageOut = new PackageOut(5125,0,param4);
         var _loc5_:CampaignReqMsg = new CampaignReqMsg();
         _loc5_.paraInt1 = param2;
         _loc5_.paraBool1 = param3;
         sendProtoBuffer(_loc5_,_loc6_);
      }
      
      public static function sendReinforce(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8255);
         var _loc2_:CampaignNodeMsg = new CampaignNodeMsg();
         _loc2_.campDataId = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      public static function sendSelectCampaignArmy(param1:int, param2:int, param3:int = -1) : void
      {
         param3 = param3 != -1 ? param3 : int(ArmyManager.instance.army.id);
         var _loc5_:PackageOut = new PackageOut(5121);
         var _loc4_:CampaignReqMsg = new CampaignReqMsg();
         _loc4_.paraInt1 = param1;
         _loc4_.paraInt2 = param2;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public static function sendFrameCallBack(param1:int, param2:int, param3:Boolean) : void
      {
         var _loc5_:PackageOut = new PackageOut(5033);
         var _loc4_:CampaignReqMsg = new CampaignReqMsg();
         _loc4_.paraInt1 = param1;
         _loc4_.paraInt2 = param2;
         _loc4_.paraBool1 = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
      
      public static function sendCampaignArmyMove(param1:int, param2:Array, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc5_:RouteMsg = null;
         if(CampaignManager.CampaignOverState)
         {
            return;
         }
         var _loc8_:PackageOut = new PackageOut(5124);
         var _loc4_:PosMoveMsg = new PosMoveMsg();
         _loc4_.armyId = param1;
         _loc4_.mapId = param3;
         var _loc7_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            _loc5_ = new RouteMsg();
            _loc5_.x = param2[_loc6_].x * 20;
            _loc5_.y = param2[_loc6_].y * 20;
            _loc7_.push(_loc5_);
            _loc6_++;
         }
         _loc4_.routes = _loc7_;
         sendProtoBuffer(_loc4_,_loc8_);
      }
      
      public static function sendBuyWorldBossBuffer(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8470);
         var _loc3_:WorldBossBufferMsg = new WorldBossBufferMsg();
         _loc3_.op = param1;
         _loc3_.type = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function receivePKRequest(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9547);
         var _loc3_:HangupAttackMsg = new HangupAttackMsg();
         _loc3_.defenceId = param1;
         _loc3_.attackId = param2;
         _loc3_.op = 2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function refusePKRequest(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9547);
         var _loc3_:HangupAttackMsg = new HangupAttackMsg();
         _loc3_.defenceId = param1;
         _loc3_.attackId = param2;
         _loc3_.op = 3;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function sendAttackInPvpMap(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8334);
         var _loc3_:WarFieldAttackMsg = new WarFieldAttackMsg();
         _loc3_.userId = param1;
         _loc3_.defenceServerName = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function sendAttackInPetLand(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8525);
         var _loc2_:HangupAttackMsg = new HangupAttackMsg();
         _loc2_.defenceId = param1;
         SocketManager.instance.socket.sendProtobuffer(_loc3_,_loc2_);
      }
      
      public static function sendAttackInGodsEvening(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(9669);
         var _loc3_:GuildMsg = new GuildMsg();
         _loc3_.param1 = param1;
         _loc3_.param3 = param2;
         validateSendProtoBuffer(_loc3_,_loc4_);
      }
      
      public static function sendFrameCallBackGodsEvening(param1:int, param2:int, param3:Boolean, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(5033);
         var _loc5_:CampaignReqMsg = new CampaignReqMsg();
         _loc5_.paraInt1 = param1;
         _loc5_.paraInt2 = param2;
         _loc5_.paraInt5 = param4;
         _loc5_.paraBool1 = param3;
         validateSendProtoBuffer(_loc5_,_loc6_);
      }
      
      private static function validateSendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         _sendCount = _sendCount + 1;
         SocketManager.instance.socket.sendProtobuffer(param2,param1,_sendCount);
      }
      
      public static function exitVehicleNode(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(25111);
         var _loc3_:WarFieldAttackMsg = new WarFieldAttackMsg();
         _loc3_.userId = param1;
         _loc3_.defenceServerName = param2;
         SocketManager.instance.socket.sendProtobuffer(_loc4_,_loc3_);
      }
      
      public static function sendCastSkillSteel(param1:int, param2:String, param3:int, param4:Array, param5:Array, param6:Array, param7:int = 0, param8:int = 0) : void
      {
         var _loc10_:PackageOut = new PackageOut(25133);
         var _loc9_:VehicleAttackReqMsg = new VehicleAttackReqMsg();
         _loc9_.skillId = param3;
         _loc9_.effectX = param7;
         _loc9_.effectY = param8;
         _loc9_.attackServerName = param2;
         _loc9_.suffererId.push.apply(null,param4);
         _loc9_.suffererServerName.push.apply(null,param5);
         _loc9_.suffererNpcIdArray.push.apply(null,param6);
         SocketManager.instance.socket.sendProtobuffer(_loc10_,_loc9_);
      }
      
      public static function sendPickupSteel(param1:int, param2:String, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(25131);
         var _loc4_:VehiclePickPropMsg = new VehiclePickPropMsg();
         _loc4_.serverName = param2;
         _loc4_.propNodeId = param3;
         SocketManager.instance.socket.sendProtobuffer(_loc5_,_loc4_);
      }
      
      public static function sendCastSkillUnrealShooting(param1:int, param2:String, param3:int, param4:Array, param5:Array, param6:Array, param7:int = 0, param8:int = 0) : void
      {
         var _loc10_:PackageOut = new PackageOut(25202);
         var _loc9_:VehicleAttackReqMsg = new VehicleAttackReqMsg();
         _loc9_.skillId = param3;
         _loc9_.effectX = param7;
         _loc9_.effectY = param8;
         _loc9_.attackServerName = param2;
         _loc9_.suffererId.push.apply(null,param4);
         _loc9_.suffererServerName.push.apply(null,param5);
         _loc9_.suffererNpcIdArray.push.apply(null,param6);
         sendProtoBuffer(_loc9_,_loc10_);
      }
      
      public static function sendPickupUnrealShooting(param1:int, param2:String, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(25203);
         var _loc4_:VehiclePickPropMsg = new VehiclePickPropMsg();
         _loc4_.serverName = param2;
         _loc4_.propNodeId = param3;
         sendProtoBuffer(_loc4_,_loc5_);
      }
   }
}

