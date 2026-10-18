package com.map.vehicle.net
{
   import com.map.vehicle.data.VGlobal;
   import com.road.yishi.proto.vehicle.Position;
   import com.road.yishi.proto.vehicle.VehicleAttackReqMsg;
   import com.road.yishi.proto.vehicle.VehicleMoveMsg;
   import com.road.yishi.proto.vehicle.VehiclePickPropMsg;
   import yishi.comm.ByteSocket;
   import yishi.comm.PackageOut;
   import yishi.manager.BaseManager;
   import yishi.service.managers.SocketManager;
   
   public class VehicleSocketOutManager
   {
      
      private static var _instance:VehicleSocketOutManager;
      
      private var socket:ByteSocket;
      
      public function VehicleSocketOutManager()
      {
         socket = SocketManager.instance.socket;
         super();
      }
      
      public static function get instance() : VehicleSocketOutManager
      {
         if(!_instance)
         {
            _instance = new VehicleSocketOutManager();
         }
         return _instance;
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
         socket.sendProtobuffer(_loc7_,_loc6_,BaseManager.instance.sendVehicleByteCount);
      }
      
      public function sendCampaignArmyMove(param1:int, param2:Array, param3:int = 3001) : void
      {
         var _loc6_:int = 0;
         var _loc5_:Position = null;
         if(!VGlobal.model)
         {
            return;
         }
         if(!VGlobal.model.selfVehicleInfo)
         {
            return;
         }
         if(VGlobal.model.selfVehicleInfo.playerId != param1)
         {
            return;
         }
         var _loc8_:PackageOut = new PackageOut(8615);
         var _loc4_:VehicleMoveMsg = new VehicleMoveMsg();
         _loc4_.playerId = param1;
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
         BaseManager.instance.sendVehicleByteCount++;
         socket.sendProtobuffer(_loc8_,_loc4_,BaseManager.instance.sendVehicleByteCount);
      }
      
      public function sendPickup(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8617);
         var _loc2_:VehiclePickPropMsg = new VehiclePickPropMsg();
         _loc2_.propNodeId = param1;
         BaseManager.instance.sendVehicleByteCount++;
         socket.sendProtobuffer(_loc3_,_loc2_,BaseManager.instance.sendVehicleByteCount);
      }
      
      public function sendReturnCampaignRoom() : void
      {
         var _loc1_:PackageOut = new PackageOut(8610);
         socket.send(_loc1_);
      }
      
      public function dispose() : void
      {
         _instance = null;
         socket = null;
      }
   }
}

