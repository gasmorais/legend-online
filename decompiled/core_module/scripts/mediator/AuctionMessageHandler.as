package mediator
{
   import bag.events.BagEvent;
   import com.pickgliss.loader.ModuleLoader;
   import com.road.yishi.proto.mall.FixAuctionItemRspMsg;
   import com.road.yishi.proto.simple.AuctionItemRspMsg;
   import com.road.yishi.proto.simple.AuctionItemsMsg;
   import com.road.yishi.proto.simple.CanceltemRspMsg;
   import com.road.yishi.proto.simple.MallItemBuyMsg;
   import com.road.yishi.proto.simple.MallItemMsg;
   import com.road.yishi.proto.simple.SellItemRspMsg;
   import flash.utils.ByteArray;
   import manager.LanguageMgr;
   import mvc.module.auction.AuctionListItemData;
   import mvc.module.auction.AuctionModel;
   import yishi.comm.PackageIn;
   import yishi.datas.consant.SellResultType;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.DateFormatter;
   
   public class AuctionMessageHandler
   {
      
      private var AuctionAlert:Object = ModuleLoader.getDefinition("auction.view.AuctionAlert");
      
      private var AuctionGoodMoveControl:Object = ModuleLoader.getDefinition("auction.view.sell.AuctionGoodMoveControl");
      
      private var _model:AuctionModel;
      
      public function AuctionMessageHandler()
      {
         super();
         _model = FrameControllerManager.instance.auctionController.model;
         addHandler();
      }
      
      private function addHandler() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4354,updateBuyPaneList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4353,updateSoldPaneList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4355,auctionResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4352,onSellResultEvent);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4356,onLookupMyAuctionResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4357,onFixPriceResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4358,onCancelItemResult);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4359,onSearchResult);
      }
      
      private function updateBuyPaneList(param1:SLGSocketEvent) : void
      {
         var _loc6_:MallItemMsg = null;
         var _loc5_:int = 0;
         var _loc4_:AuctionListItemData = null;
         var _loc7_:PackageIn = PackageIn(param1.data);
         var _loc2_:AuctionItemsMsg = new AuctionItemsMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as AuctionItemsMsg;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.sellItem.length)
         {
            _loc6_ = _loc2_.sellItem[_loc5_];
            _loc4_ = readListItem(_loc6_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _model.forSaleList.update(_loc3_,_loc2_.pageIdx,_loc2_.pageCount);
      }
      
      private function updateSoldPaneList(param1:SLGSocketEvent) : void
      {
         var _loc6_:MallItemMsg = null;
         var _loc5_:int = 0;
         var _loc4_:AuctionListItemData = null;
         var _loc7_:PackageIn = PackageIn(param1.data);
         var _loc2_:AuctionItemsMsg = new AuctionItemsMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as AuctionItemsMsg;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.sellItem.length)
         {
            _loc6_ = _loc2_.sellItem[_loc5_];
            _loc4_ = readListItem(_loc6_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _model.soldList.update(_loc3_,_loc2_.pageIdx,_loc2_.pageCount);
      }
      
      private function onLookupMyAuctionResult(param1:SLGSocketEvent) : void
      {
         var _loc6_:MallItemBuyMsg = null;
         var _loc5_:int = 0;
         var _loc4_:AuctionListItemData = null;
         var _loc7_:PackageIn = PackageIn(param1.data);
         var _loc2_:AuctionItemsMsg = new AuctionItemsMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as AuctionItemsMsg;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.itemBuy.length)
         {
            _loc6_ = _loc2_.itemBuy[_loc5_];
            _loc4_ = readListItem(_loc6_.mallItem);
            _loc4_.selfPrice = _loc6_.bidupPoint;
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _model.recordList.update(_loc3_,_loc2_.pageIdx,_loc2_.pageCount);
      }
      
      private function onSellResultEvent(param1:SLGSocketEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:AuctionListItemData = null;
         var _loc5_:PackageIn = PackageIn(param1.data);
         var _loc2_:SellItemRspMsg = new SellItemRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SellItemRspMsg;
         if(_loc2_.result == 0)
         {
            _loc3_ = _model.soldList.getList().concat([]);
            _loc4_ = readListItem(_loc2_.item);
            _loc3_.push(_loc4_);
            if(_model.soldList.getList().length > 8)
            {
               AuctionMessageSender.sendMyAuctionListReq(1,9,1);
            }
            _model.soldList.update(_loc3_,_model.soldList.currentPage,_model.soldList.totalPage);
            AuctionGoodMoveControl["delTargetData"]();
         }
         else
         {
            AuctionAlert["alert"](LanguageMgr.GetTranslation("public.prompt"),SellResultType.getResultStr(_loc2_.result));
            AuctionGoodMoveControl["delTargetData"]();
            GoodsManager.instance.dispatchEvent(new BagEvent("RETURN_REFRESH",null));
         }
      }
      
      private function auctionResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:AuctionListItemData = null;
         var _loc4_:PackageIn = PackageIn(param1.data);
         var _loc2_:AuctionItemRspMsg = new AuctionItemRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as AuctionItemRspMsg;
         if(_loc2_.result == 0)
         {
            if(_loc2_.itemBuy && _loc2_.itemBuy.mallItem)
            {
               _loc3_ = getAuctionListItemData(_model.forSaleList.getList(),_loc2_.itemBuy.mallItem.id);
               if(_loc3_)
               {
                  _loc3_.selfPrice = _loc2_.itemBuy.bidupPoint;
                  _loc3_.currPrice = _loc2_.itemBuy.mallItem.point;
                  _loc3_.auctioned = _loc2_.itemBuy.mallItem.maxAuctionId > 0 ? true : false;
               }
               _loc3_ = getAuctionListItemData(_model.recordList.getList(),_loc2_.itemBuy.mallItem.id);
               if(_loc3_)
               {
                  _loc3_.selfPrice = _loc2_.itemBuy.bidupPoint;
                  _loc3_.currPrice = _loc2_.itemBuy.mallItem.point;
                  _loc3_.auctioned = _loc2_.itemBuy.mallItem.maxAuctionId > 0 ? true : false;
               }
            }
         }
         else if(_loc2_.result == -11)
         {
            RechargeAlertMannager.show();
         }
         else
         {
            AuctionAlert["alert"](LanguageMgr.GetTranslation("public.prompt"),SellResultType.getResultStr(_loc2_.result));
            if(_loc2_.result == -4 || _loc2_.result == -2)
            {
               if(_model.currentModulIndex == 0)
               {
                  _model.refreshForSellData();
               }
               else if(_model.currentModulIndex == 2)
               {
                  _model.refreshRecordData();
               }
            }
         }
      }
      
      private function onFixPriceResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:AuctionListItemData = null;
         var _loc4_:PackageIn = PackageIn(param1.data);
         var _loc2_:FixAuctionItemRspMsg = new FixAuctionItemRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as FixAuctionItemRspMsg;
         if(_loc2_.result == 0)
         {
            _loc3_ = getAuctionListItemData(_model.forSaleList.getList(),_loc2_.mallItemId);
            if(_loc3_)
            {
               _model.forSaleList.removeItem(_loc3_);
            }
            _loc3_ = getAuctionListItemData(_model.recordList.getList(),_loc2_.mallItemId);
            if(_loc3_)
            {
               _model.recordList.removeItem(_loc3_);
            }
         }
         else if(_loc2_.result == -11)
         {
            RechargeAlertMannager.show();
         }
         else
         {
            AuctionAlert["alert"](LanguageMgr.GetTranslation("public.prompt"),SellResultType.getResultStr(_loc2_.result));
            if(_loc2_.result == -4 || _loc2_.result == -2)
            {
               if(_model.currentModulIndex == 0)
               {
                  _model.refreshForSellData();
               }
               else if(_model.currentModulIndex == 2)
               {
                  _model.refreshRecordData();
               }
            }
         }
      }
      
      private function onCancelItemResult(param1:SLGSocketEvent) : void
      {
         var _loc3_:AuctionListItemData = null;
         var _loc4_:PackageIn = PackageIn(param1.data);
         var _loc2_:CanceltemRspMsg = new CanceltemRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CanceltemRspMsg;
         if(_loc2_.result == 0)
         {
            _loc3_ = getAuctionListItemData(_model.soldList.getList(),_loc2_.id);
            if(_loc3_)
            {
               _model.soldList.removeItem(_loc3_);
            }
         }
         else
         {
            AuctionMessageSender.sendMyAuctionListReq(_model.soldList.currentPage,9,1);
         }
      }
      
      private function onSearchResult(param1:SLGSocketEvent) : void
      {
         var _loc6_:MallItemMsg = null;
         var _loc5_:int = 0;
         var _loc4_:AuctionListItemData = null;
         var _loc7_:PackageIn = PackageIn(param1.data);
         var _loc2_:AuctionItemsMsg = new AuctionItemsMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as AuctionItemsMsg;
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.sellItem.length)
         {
            _loc6_ = _loc2_.sellItem[_loc5_];
            _loc4_ = readListItem(_loc6_);
            _loc3_.push(_loc4_);
            _loc5_++;
         }
         _model.forSaleList.update(_loc3_,_loc2_.pageIdx,_loc2_.pageCount);
      }
      
      private function getAuctionListItemData(param1:Array, param2:int) : AuctionListItemData
      {
         for each(var _loc3_:AuctionListItemData in param1)
         {
            if(_loc3_.goodId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function readListItem(param1:MallItemMsg) : AuctionListItemData
      {
         var _loc2_:AuctionListItemData = new AuctionListItemData();
         _loc2_.initGoodsInfo(param1.itemInfo);
         _loc2_.goodId = param1.id;
         _loc2_.hour = param1.hour;
         _loc2_.startTime = DateFormatter.parse(param1.startTime,"YYYY-MM-DD hh:mm:ss");
         _loc2_.saler = param1.nickName;
         _loc2_.fixedPrice = param1.fixPoint;
         _loc2_.currPrice = param1.point;
         _loc2_.auctioned = param1.maxAuctionId > 0 ? true : false;
         return _loc2_;
      }
      
      private function readStartTime(param1:ByteArray) : uint
      {
         return param1.readUnsignedInt();
      }
      
      public function dispose() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4354,updateBuyPaneList);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4353,updateSoldPaneList);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4355,auctionResultHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4352,onSellResultEvent);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4356,onLookupMyAuctionResult);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4357,onFixPriceResult);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4358,onCancelItemResult);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4359,onSearchResult);
      }
   }
}

