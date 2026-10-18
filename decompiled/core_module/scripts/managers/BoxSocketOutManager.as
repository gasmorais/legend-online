package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.box.BoxMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class BoxSocketOutManager
   {
      
      public function BoxSocketOutManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendBoxTime(param1:Boolean, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(5019);
         var _loc3_:BoxMsg = new BoxMsg();
         _loc3_.operate = param1;
         _loc3_.time = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendBoxNovice(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(5018);
         var _loc2_:BoxMsg = new BoxMsg();
         _loc2_.grade = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
   }
}

