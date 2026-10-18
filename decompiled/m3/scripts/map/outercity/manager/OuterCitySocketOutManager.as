package map.outercity.manager
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.army.PhysicUpdateReqMsg;
   import com.road.yishi.proto.outercity.OutercityReqMsg;
   import com.road.yishi.proto.player.ChallengeMsg;
   import com.road.yishi.proto.player.PayTypeMsg;
   import com.road.yishi.proto.worldmap.MapPhysicAttackMsg;
   import com.road.yishi.proto.worldmap.PosMoveMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class OuterCitySocketOutManager
   {
      
      public function OuterCitySocketOutManager()
      {
         super();
      }
      
      public static function sendCurrentScreen(param1:String, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(5004);
         var _loc3_:OutercityReqMsg = new OutercityReqMsg();
         _loc3_.mapId = param2;
         _loc3_.position = param1;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendGetArmyByGrid(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(5181);
         var _loc3_:OutercityReqMsg = new OutercityReqMsg();
         _loc3_.mapId = param1;
         _loc3_.files = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendGetWildLandByGrid(param1:int, param2:String) : void
      {
         var _loc4_:PackageOut = new PackageOut(8201);
         var _loc3_:PhysicUpdateReqMsg = new PhysicUpdateReqMsg();
         _loc3_.mapId = param1;
         _loc3_.reqGrid = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendArmyPosRequest() : void
      {
         var _loc1_:PackageOut = new PackageOut(8328);
         send(_loc1_);
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendPvpAttack(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8488);
         var _loc2_:ChallengeMsg = new ChallengeMsg();
         _loc2_.tarUserId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function setAddAttackCount(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9506);
         var _loc3_:OutercityReqMsg = new OutercityReqMsg();
         _loc3_.attackCount = param1;
         _loc3_.type = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendAttack(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(5160);
         var _loc4_:MapPhysicAttackMsg = new MapPhysicAttackMsg();
         _loc4_.mapId = param1;
         _loc4_.posX = param2;
         _loc4_.posY = param3;
         sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendArmyBack(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5161);
         var _loc2_:PayTypeMsg = new PayTypeMsg();
         _loc2_.payType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendMovePaths(param1:PosMoveMsg) : void
      {
         var _loc2_:PackageOut = new PackageOut(8254);
         sendProtoBuffer(_loc2_,param1);
      }
   }
}

