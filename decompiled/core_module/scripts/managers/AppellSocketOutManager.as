package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.player.AppellExchangeMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class AppellSocketOutManager
   {
      
      public function AppellSocketOutManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function send(param1:PackageOut) : void
      {
         SocketManager.instance.socket.send(param1);
      }
      
      public static function exchangeAppell(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8597);
         var _loc2_:AppellExchangeMsg = new AppellExchangeMsg();
         _loc2_.appellId = param1;
         _loc2_.look = false;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function lookAppellInfos() : void
      {
         var _loc2_:PackageOut = new PackageOut(8597);
         var _loc1_:AppellExchangeMsg = new AppellExchangeMsg();
         _loc1_.appellId = 0;
         _loc1_.look = true;
         sendProtoBuffer(_loc2_,_loc1_);
      }
   }
}

