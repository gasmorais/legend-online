package task.net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.player.UserPin;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class TaskSocketSendManager
   {
      
      public function TaskSocketSendManager()
      {
         super();
      }
      
      public static function sendPhoneTaskCode(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8352);
         var _loc2_:UserPin = new UserPin();
         _loc2_.pin = param1;
         sendProtoBuffer(_loc2_,_loc3_);
      }
      
      private static function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
   }
}

