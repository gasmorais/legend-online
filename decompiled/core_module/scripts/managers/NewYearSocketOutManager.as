package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.active.ActiveOptionMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class NewYearSocketOutManager
   {
      
      public function NewYearSocketOutManager()
      {
         super();
      }
      
      public static function sendGetReward(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8816);
         var _loc3_:ActiveOptionMsg = new ActiveOptionMsg();
         _loc3_.opType = param1;
         _loc3_.opParam = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendGetProfilt(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8817);
         var _loc2_:ActiveOptionMsg = new ActiveOptionMsg();
         _loc2_.opType = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendLotteryRequest(param1:int = 0, param2:int = 0) : void
      {
         var _loc4_:PackageOut = new PackageOut(8818);
         var _loc3_:ActiveOptionMsg = new ActiveOptionMsg();
         _loc3_.opType = param1;
         _loc3_.opParam = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message = null) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

