package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.leed.FinishedReqMsg;
   import com.road.yishi.proto.leed.LeedFinishedReqMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class DayGuideSocketOutManager
   {
      
      public function DayGuideSocketOutManager()
      {
         super();
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
      
      public static function sendGetGoods(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8235);
         var _loc3_:LeedFinishedReqMsg = new LeedFinishedReqMsg();
         _loc3_.site = param1;
         _loc3_.isWeek = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendLeedAdd(param1:int) : void
      {
         var _loc2_:PackageOut = new PackageOut(8234);
         sendProtoBuffer(_loc2_,null);
      }
      
      public static function sendDailyCount() : void
      {
         var _loc1_:PackageOut = new PackageOut(8518);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendLeedClientUpdate(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8322);
         var _loc2_:FinishedReqMsg = new FinishedReqMsg();
         _loc2_.templateId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendbuyDoubleBuff() : void
      {
         var _loc2_:PackageOut = new PackageOut(8236);
         var _loc1_:LeedFinishedReqMsg = new LeedFinishedReqMsg();
         sendProtoBuffer(_loc2_,_loc1_);
      }
   }
}

