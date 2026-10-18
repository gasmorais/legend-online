package managers
{
   import com.road.yishi.proto.simple.CheckImageMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketSendManager;
   
   public class SocketSecurityCodeMessageManager
   {
      
      public function SocketSecurityCodeMessageManager()
      {
         super();
      }
      
      public static function sendSecurityCodeMessage(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8514);
         var _loc2_:CheckImageMsg = new CheckImageMsg();
         _loc2_.result = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendCheckShowSecurityCode() : void
      {
         var _loc2_:PackageOut = new PackageOut(8516);
         var _loc1_:CheckImageMsg = new CheckImageMsg();
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
   }
}

