package map.campaign.data
{
   import com.road.yishi.proto.item.MarketOpMsg;
   import com.road.yishi.proto.item.StallMsg;
   import flash.utils.Dictionary;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   
   public class MarketModel
   {
      
      public static const LOCK_POS:int = 1;
      
      public static const ADD_GOODS:int = 2;
      
      public static const BUY_GOODS:int = 3;
      
      public static const CANCLE_GOODS:int = 4;
      
      public static const BEGIN_SELL:int = 5;
      
      public static const LOOK_UP:int = 6;
      
      public static const END_SELL:int = 7;
      
      public static const RENAME:int = 8;
      
      public var stalls:Dictionary;
      
      public function MarketModel()
      {
         super();
         stalls = new Dictionary();
      }
      
      public function get selfStall() : StallInfo
      {
         if(!stalls[playerInfo.userId])
         {
            stalls[playerInfo.userId] = new StallInfo();
            stalls[playerInfo.userId].userId = playerInfo.userId;
         }
         return stalls[playerInfo.userId];
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function marketGoodsToSell(param1:int, param2:int, param3:int, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(8969);
         var _loc5_:MarketOpMsg = new MarketOpMsg();
         _loc5_.opType = 2;
         _loc5_.param1 = param1;
         _loc5_.param2 = param2;
         _loc5_.param3 = param3;
         _loc5_.param4 = param4;
         _loc5_.param6 = false;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
      
      public function marketPetToSell(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8969);
         var _loc4_:MarketOpMsg = new MarketOpMsg();
         _loc4_.opType = 2;
         _loc4_.param1 = param1;
         _loc4_.param2 = param2;
         _loc4_.param4 = param3;
         _loc4_.param6 = true;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public function marketToBag(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8969);
         var _loc3_:MarketOpMsg = new MarketOpMsg();
         _loc3_.opType = 4;
         _loc3_.param1 = param1;
         _loc3_.param2 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function beginSell(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8969);
         var _loc2_:MarketOpMsg = new MarketOpMsg();
         _loc2_.opType = 5;
         _loc2_.param5 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function endSell() : void
      {
         var _loc2_:PackageOut = new PackageOut(8969);
         var _loc1_:MarketOpMsg = new MarketOpMsg();
         _loc1_.opType = 7;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function lockPos(param1:int, param2:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8969);
         var _loc3_:MarketOpMsg = new MarketOpMsg();
         _loc3_.opType = 1;
         var _loc4_:StallMsg = new StallMsg();
         _loc4_.xPos = param1;
         _loc4_.yPos = param2;
         _loc3_.stall = _loc4_;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc3_);
      }
      
      public function lookStall(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8969);
         var _loc2_:MarketOpMsg = new MarketOpMsg();
         _loc2_.opType = 6;
         _loc2_.param1 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function reNameStall(param1:String) : void
      {
         var _loc3_:PackageOut = new PackageOut(8969);
         var _loc2_:MarketOpMsg = new MarketOpMsg();
         _loc2_.opType = 6;
         _loc2_.param5 = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function buyGoods(param1:int, param2:String, param3:int, param4:int) : void
      {
         var _loc6_:PackageOut = new PackageOut(8969);
         var _loc5_:MarketOpMsg = new MarketOpMsg();
         _loc5_.opType = 3;
         _loc5_.param1 = param1;
         _loc5_.param2 = param3;
         _loc5_.param3 = param4;
         _loc5_.param5 = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc5_);
      }
   }
}

