package managers
{
   import com.netease.protobuf.Message;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class MountActSocketOutManager
   {
      
      public function MountActSocketOutManager()
      {
         super();
      }
      
      public static function sendGetMountActInfo() : void
      {
         var _loc1_:PackageOut = new PackageOut(8843);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

