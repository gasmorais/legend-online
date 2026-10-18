package sandbox.net
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.simple.PropertyMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class DayLightOuterManager
   {
      
      public static const OP_WALK:int = 2;
      
      public static const OP_DEFEND:int = 3;
      
      public static const OP_CLEAR_CD:int = 4;
      
      public static const OP_USE_SKILL:int = 5;
      
      public static const OP_BUY_SKILL:int = 6;
      
      public static const OP_VIEW_RANK:int = 7;
      
      public static const OP_REQUEST_DATA:int = 8;
      
      public function DayLightOuterManager()
      {
         super();
      }
      
      public static function attack(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9670);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         _loc2_.param11 = 2;
         sendDayLight(_loc2_,_loc3_);
      }
      
      public static function defend() : void
      {
         var _loc2_:PackageOut = new PackageOut(9670);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param11 = 3;
         sendDayLight(_loc1_,_loc2_);
      }
      
      public static function clearCD() : void
      {
         var _loc2_:PackageOut = new PackageOut(9670);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param11 = 4;
         sendDayLight(_loc1_,_loc2_);
      }
      
      public static function useSkill(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9670);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         _loc2_.param11 = 5;
         sendDayLight(_loc2_,_loc3_);
      }
      
      public static function buySkill(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9670);
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_.param1 = param1;
         _loc2_.param11 = 6;
         sendDayLight(_loc2_,_loc3_);
      }
      
      public static function viewRank() : void
      {
         var _loc2_:PackageOut = new PackageOut(9670);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param11 = 7;
         sendDayLight(_loc1_,_loc2_);
      }
      
      public static function requestData() : void
      {
         var _loc2_:PackageOut = new PackageOut(9670);
         var _loc1_:PropertyMsg = new PropertyMsg();
         _loc1_.param11 = 8;
         sendDayLight(_loc1_,_loc2_);
      }
      
      private static function sendDayLight(param1:PropertyMsg, param2:PackageOut) : void
      {
         param1.param10 = 1;
         sendProtoBuffer(param1,param2);
      }
      
      private static function sendProtoBuffer(param1:Message, param2:PackageOut) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param2,param1);
      }
   }
}

