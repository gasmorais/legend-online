package army.net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.army.ArmyFightPosEditListMsg;
   import com.road.yishi.proto.army.ArmyFightPosEditMsg;
   import managers.RoomManager;
   import mvc.module.room.RoomInfo;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class ArmySocketSendManager
   {
      
      public function ArmySocketSendManager()
      {
         super();
      }
      
      public static function sendEditTeamPos(param1:Array, param2:String = "") : void
      {
         var _loc5_:ArmyFightPosEditMsg = null;
         var _loc7_:PackageOut = null;
         var _loc6_:Array = [];
         for each(var _loc4_:Object in param1)
         {
            _loc5_ = new ArmyFightPosEditMsg();
            _loc5_.serverName = _loc4_.serverName;
            _loc5_.userId = _loc4_.userId;
            _loc5_.heroPos = _loc4_.heroPos;
            _loc6_.push(_loc5_);
         }
         if(roomInfo && roomInfo.isCross)
         {
            _loc7_ = new PackageOut(25160);
         }
         else
         {
            _loc7_ = new PackageOut(8277);
         }
         var _loc3_:ArmyFightPosEditListMsg = new ArmyFightPosEditListMsg();
         _loc3_.armyFightPos = _loc6_;
         _loc3_.serverName = param2;
         sendProtoBuffer(_loc7_,_loc3_);
      }
      
      private static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      private static function get roomInfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
   }
}

