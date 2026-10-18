package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.player.ChallengeMsg;
   import com.road.yishi.proto.vip.VipRouletteMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class SinglePassSocketOutManager
   {
      
      public function SinglePassSocketOutManager()
      {
         super();
      }
      
      public static function sendRequestSinglePassInfo() : void
      {
         var _loc2_:PackageOut = new PackageOut(8753);
         var _loc1_:ChallengeMsg = new ChallengeMsg();
         _loc1_.type = 0;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendRequestSinglePassAttack(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8755);
         var _loc2_:ChallengeMsg = new ChallengeMsg();
         _loc2_.type = 0;
         _loc2_.tarUserId = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendRequestUpdateArea() : void
      {
         var _loc1_:PackageOut = new PackageOut(8636);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendRequestGetAreaReward() : void
      {
         var _loc1_:PackageOut = new PackageOut(8637);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendRequestGetBugle() : void
      {
         var _loc1_:PackageOut = new PackageOut(8638);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendRequestBugleRoulette(param1:int, param2:Boolean = true) : void
      {
         var _loc4_:PackageOut = new PackageOut(8639);
         var _loc3_:VipRouletteMsg = new VipRouletteMsg();
         _loc3_.leftCount = param1;
         if(param2)
         {
            _loc3_.opType = 0;
         }
         else
         {
            _loc3_.opType = 1;
         }
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendRequestBugleOpen() : void
      {
         var _loc1_:PackageOut = new PackageOut(8640);
         sendProtoBuffer(_loc1_,null);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message = null) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

