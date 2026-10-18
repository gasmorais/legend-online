package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.building.BuildingOptionReqMsg;
   import com.road.yishi.proto.building.BuildingReqMsg;
   import com.road.yishi.proto.player.PayTypeMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class BuildingSocketOutManager
   {
      
      public function BuildingSocketOutManager()
      {
         super();
      }
      
      public static function sendCreateBuild(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8202);
         var _loc2_:BuildingOptionReqMsg = new BuildingOptionReqMsg();
         _loc2_.sonType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendUpgradeBuild(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8203);
         var _loc2_:BuildingOptionReqMsg = new BuildingOptionReqMsg();
         _loc2_.buildingId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function upgradeOrderList() : void
      {
         var _loc1_:PackageOut = new PackageOut(8279);
         send(_loc1_);
      }
      
      public static function sendCoolOrder(param1:int, param2:int, param3:Boolean = true) : void
      {
         var _loc5_:PackageOut = new PackageOut(5172);
         var _loc4_:BuildingReqMsg = new BuildingReqMsg();
         _loc4_.orderId = param1;
         _loc4_.index = param2;
         if(param2 != 0)
         {
            if(!param3)
            {
               _loc4_.index = 1;
            }
            else
            {
               _loc4_.index = 2;
            }
         }
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendBuyOrder(param1:int = 0) : void
      {
         var _loc3_:PackageOut = new PackageOut(5175);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendCoolTransferTime(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5173);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendAddTransferPower(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5174);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function unoccupy(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(5179);
         var _loc2_:BuildingReqMsg = new BuildingReqMsg();
         _loc2_.position = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function pickFruits(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5178);
         var _loc2_:BuildingReqMsg = new BuildingReqMsg();
         _loc2_.index = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function water(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(15017);
         var _loc2_:BuildingReqMsg = new BuildingReqMsg();
         _loc2_.userId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
   }
}

