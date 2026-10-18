package mediator
{
   import com.road.yishi.proto.mall.AuctionItemReqMsg;
   import com.road.yishi.proto.mall.MallItemViewReqMsg;
   import com.road.yishi.proto.mall.SearchItemReqMsg;
   import com.road.yishi.proto.mall.SellItemReqMsg;
   import mvc.module.auction.SellItemVO;
   import yishi.comm.PackageOut;
   import yishi.service.managers.SocketSendManager;
   
   public class AuctionMessageSender
   {
      
      public function AuctionMessageSender()
      {
         super();
      }
      
      public static function sendSellItemMessage(param1:SellItemVO) : void
      {
         var _loc3_:PackageOut = new PackageOut(8448);
         var _loc2_:SellItemReqMsg = new SellItemReqMsg();
         _loc2_.itemId = param1.itemId;
         _loc2_.itemPos = param1.itemPos;
         _loc2_.count = param1.count;
         _loc2_.point = param1.point;
         _loc2_.fixPoint = param1.fixPoint;
         _loc2_.hour = param1.hour;
         _loc2_.sellType = param1.itemType;
         _loc2_.fromBagType = param1.bagType;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function sendMyAuctionListReq(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8449);
         var _loc4_:MallItemViewReqMsg = new MallItemViewReqMsg();
         _loc4_.page = param1;
         _loc4_.count = param2;
         _loc4_.from = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendPlayerAuctionListReq(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:PackageOut = new PackageOut(8450);
         var _loc4_:MallItemViewReqMsg = new MallItemViewReqMsg();
         _loc4_.page = param1;
         _loc4_.count = param2;
         _loc4_.from = param3;
         SocketSendManager.instance.sendProtoBuffer(_loc5_,_loc4_);
      }
      
      public static function sendAuctionGoods(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8451);
         var _loc3_:AuctionItemReqMsg = new AuctionItemReqMsg();
         _loc3_.id = param1;
         _loc3_.point = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendMyAuctionListHistoryReq(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0) : void
      {
         var _loc7_:PackageOut = new PackageOut(8452);
         var _loc6_:MallItemViewReqMsg = new MallItemViewReqMsg();
         _loc6_.page = param1;
         _loc6_.count = param2;
         _loc6_.from = param3;
         _loc6_.orderBy = param4;
         _loc6_.orderType = param5;
         SocketSendManager.instance.sendProtoBuffer(_loc7_,_loc6_);
      }
      
      public static function sendFixPriceItemMessage(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(8453);
         var _loc3_:AuctionItemReqMsg = new AuctionItemReqMsg();
         _loc3_.id = param1;
         _loc3_.point = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public static function sendCancelItemMessage(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8454);
         var _loc2_:AuctionItemReqMsg = new AuctionItemReqMsg();
         _loc2_.id = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public static function search(param1:SearchItemReqMsg) : void
      {
         var _loc2_:PackageOut = new PackageOut(8457);
         SocketSendManager.instance.sendProtoBuffer(_loc2_,param1);
      }
   }
}

