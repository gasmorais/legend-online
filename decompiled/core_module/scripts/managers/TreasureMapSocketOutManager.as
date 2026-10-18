package managers
{
   import com.netease.protobuf.Message;
   import com.road.yishi.proto.treasuremap.PlayerTreasureMsg;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketManager;
   
   public class TreasureMapSocketOutManager
   {
      
      public function TreasureMapSocketOutManager()
      {
         super();
      }
      
      public static function sendRequestTreasureMap() : void
      {
         var _loc2_:PackageOut = new PackageOut(8744);
         var _loc1_:PlayerTreasureMsg = new PlayerTreasureMsg();
         _loc1_.opType = 6;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendRefreshTreasureMap(param1:Boolean = false, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(8744);
         var _loc3_:PlayerTreasureMsg = new PlayerTreasureMsg();
         _loc3_.opType = 2;
         _loc3_.refreshType = param1;
         if(param2)
         {
            _loc3_.payType = 0;
         }
         else
         {
            _loc3_.payType = 1;
         }
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendGetTreasureMap() : void
      {
         var _loc2_:PackageOut = new PackageOut(8744);
         var _loc1_:PlayerTreasureMsg = new PlayerTreasureMsg();
         _loc1_.opType = 1;
         sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public static function sendDigTreasureMap(param1:int, param2:Boolean = false) : void
      {
         var _loc4_:PackageOut = new PackageOut(8744);
         var _loc3_:PlayerTreasureMsg = new PlayerTreasureMsg();
         _loc3_.opType = 3;
         _loc3_.index = param1;
         if(param2)
         {
            _loc3_.payType = 0;
         }
         else
         {
            _loc3_.payType = 1;
         }
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendUseTreasureMap(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8744);
         var _loc2_:PlayerTreasureMsg = new PlayerTreasureMsg();
         _loc2_.opType = 5;
         _loc2_.index = param1;
         sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendReceiveTreasureMap(param1:int, param2:Boolean) : void
      {
         var _loc4_:PackageOut = new PackageOut(8744);
         var _loc3_:PlayerTreasureMsg = new PlayerTreasureMsg();
         _loc3_.opType = 4;
         _loc3_.index = param1;
         _loc3_.isReward = param2;
         sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendProtoBuffer(param1:PackageOut, param2:Message = null) : void
      {
         SocketManager.instance.socket.sendProtobuffer(param1,param2);
      }
   }
}

