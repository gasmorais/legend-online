package auction.view.record
{
   import auction.view.AuctionAlert;
   import auction.view.common.AuctionChecker;
   import auction.view.common.AuctionInputFrame;
   import auction.view.common.AuctionListColWidthConst;
   import auction.view.common.AuctionListComponent;
   import auction.view.common.AuctionListItem2;
   import auction.view.common.AuctionListTitleComponent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TitleButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.AuctionEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mediator.AuctionMessageSender;
   import mvc.module.auction.AuctionListItemData;
   import mvc.module.auction.AuctionModel;
   import mvc.module.auction.AuctionResultListData;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class AuctionRecordResultPane extends Sprite implements Disposeable
   {
      
      private var _border:DisplayObject;
      
      private var _listTitle:AuctionListTitleComponent;
      
      private var _listComponent:AuctionListComponent;
      
      private var _bottomBar:AuctionRecordBottomBar;
      
      private var _corner1:DisplayObject;
      
      private var _corner2:DisplayObject;
      
      private var _corner3:DisplayObject;
      
      private var _corner4:DisplayObject;
      
      private var _data:AuctionResultListData;
      
      private var _inputFrame:AuctionInputFrame;
      
      private var _currentOrderBy:int = 0;
      
      private var _currentOrderType:int = 0;
      
      public function AuctionRecordResultPane()
      {
         super();
         var _loc1_:AuctionModel = FrameControllerManager.instance.auctionController.model;
         _data = _loc1_.recordList;
         init();
         addHandler();
      }
      
      private function init() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("auction.record.resultBack");
         addChild(_border);
         var _loc1_:Array = AuctionListColWidthConst.long;
         var _loc2_:Array = AuctionListColWidthConst.longX;
         _listTitle = new AuctionListTitleComponent("auction.listTitleBmdL",_loc1_,_loc2_);
         _listTitle.x = 1;
         _listTitle.y = 2;
         addChild(_listTitle);
         _listComponent = new AuctionListComponent(AuctionListItem2,9,-3);
         _listComponent.setData(_data.getList());
         _listComponent.x = 3;
         _listComponent.y = 33;
         _listComponent.callBack = onAuction;
         addChild(_listComponent);
         _bottomBar = new AuctionRecordBottomBar();
         _bottomBar.x = 3;
         _bottomBar.y = 398;
         addChild(_bottomBar);
         _corner1 = ComponentFactory.Instance.creatComponentByStylename("auction.recordCorner1");
         _corner2 = ComponentFactory.Instance.creatComponentByStylename("auction.recordCorner2");
         _corner3 = ComponentFactory.Instance.creatComponentByStylename("auction.recordCorner3");
         _corner4 = ComponentFactory.Instance.creatComponentByStylename("auction.recordCorner4");
         addChild(_corner1);
         addChild(_corner2);
         addChild(_corner3);
         addChild(_corner4);
      }
      
      private function addHandler() : void
      {
         _data.addEventListener("change",onListDataChange);
         _bottomBar.getPageControlComp().getPreBtn().addEventListener("click",onPrePageClick);
         _bottomBar.getPageControlComp().getNextBtn().addEventListener("click",onNextPageClick);
         _bottomBar.getAuctionBtn().addEventListener("click",onAuctionClick);
         _bottomBar.getFixedPriceBtn().addEventListener("click",onFixedPriceClick);
         var _loc1_:AuctionModel = FrameControllerManager.instance.auctionController.model;
         _loc1_.addEventListener(AuctionEvent.REFRESH_RECORD,onRefreshEvent);
         _listTitle.titleGrade.addEventListener("click",__onTitleClick);
         _listTitle.titleTime.addEventListener("click",__onTitleClick);
         _listTitle.titlePrice.addEventListener("click",__onTitleClick);
         _listTitle.titleCurPrice.addEventListener("click",__onTitleClick);
      }
      
      private function restoreListTitle() : void
      {
         _currentOrderBy = _currentOrderType = 0;
         _listTitle.currentSelectBut(null);
      }
      
      private function __onTitleClick(param1:MouseEvent) : void
      {
         var _loc2_:TitleButton = param1.currentTarget as TitleButton;
         switch(_loc2_)
         {
            case _listTitle.titleGrade:
               _currentOrderBy = 1;
               break;
            case _listTitle.titleTime:
               _currentOrderBy = 2;
               break;
            case _listTitle.titlePrice:
               _currentOrderBy = 4;
               break;
            case _listTitle.titleCurPrice:
               _currentOrderBy = 3;
         }
         if(_listTitle.currentSelectBut(_loc2_) == 2)
         {
            _currentOrderType = 1;
         }
         else
         {
            _currentOrderType = 2;
         }
         AuctionMessageSender.sendMyAuctionListHistoryReq(_data.currentPage,9,1,_currentOrderBy,_currentOrderType);
      }
      
      private function onRefreshEvent(param1:Event) : void
      {
         AuctionMessageSender.sendMyAuctionListHistoryReq(_data.currentPage,9,1,_currentOrderBy,_currentOrderType);
      }
      
      private function onPrePageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AuctionMessageSender.sendMyAuctionListHistoryReq(_bottomBar.getPageControlComp().getData().currentPage - 1,9,1,_currentOrderBy,_currentOrderType);
      }
      
      private function onListDataChange(param1:Event) : void
      {
         _listComponent.setData(_data.getList());
      }
      
      private function onNextPageClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         AuctionMessageSender.sendMyAuctionListHistoryReq(_bottomBar.getPageControlComp().getData().currentPage + 1,9,1,_currentOrderBy,_currentOrderType);
      }
      
      private function onAuctionClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         onAuction();
      }
      
      private function onAuction() : void
      {
         var _loc1_:AuctionListItemData = _listComponent.getSelectedItemData();
         if(_loc1_)
         {
            if(!AuctionChecker.checkAuction(_loc1_))
            {
               return;
            }
            _inputFrame = ComponentFactory.Instance.creatComponentByStylename("auction.AuctionInputFrame");
            _inputFrame.setData(_loc1_);
            _inputFrame.backCall = inputPriceCallback;
            _inputFrame.show();
         }
         else
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.PleaseSelectGood"));
         }
      }
      
      private function inputPriceCallback(param1:int) : void
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc10_:String = null;
         var _loc4_:String = null;
         var _loc3_:AuctionListItemData = _listComponent.getSelectedItemData();
         if(param1 <= _loc3_.currPrice)
         {
            _loc7_ = LanguageMgr.GetTranslation("public.confirm");
            _loc8_ = LanguageMgr.GetTranslation("public.cancel");
            _loc9_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("Action.UnderCurrentPrice");
            SimpleAlertHelper.instance.data = [];
            SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc5_,_loc7_,"",true,false,false,2);
         }
         else if(param1 >= _loc3_.fixedPrice)
         {
            SimpleAlertHelper.instance.data = [isFixedBuy,_loc3_.goodId,_loc3_.fixedPrice];
            _loc6_ = LanguageMgr.GetTranslation("public.confirm");
            _loc2_ = LanguageMgr.GetTranslation("public.cancel");
            _loc10_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("Action.OuterFixedPrice");
            SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc4_,_loc6_,_loc2_,true,false,false,2);
         }
         else
         {
            AuctionMessageSender.sendAuctionGoods(_loc3_.goodId,param1);
         }
      }
      
      private function isFixedBuy(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         if(param1)
         {
            AuctionMessageSender.sendFixPriceItemMessage(param3,param4);
         }
      }
      
      private function onFixedPriceClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         var _loc4_:AuctionListItemData = _listComponent.getSelectedItemData();
         if(_loc4_)
         {
            if(!AuctionChecker.checkFixPrice(_loc4_))
            {
               return;
            }
            SimpleAlertHelper.instance.data = [fixedPriceBuy,_loc4_.goodId,_loc4_.fixedPrice];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("Auction.FixedPriceBuy");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false,2);
         }
         else
         {
            AuctionAlert.alert(LanguageMgr.GetTranslation("public.prompt"),LanguageMgr.GetTranslation("Auction.PleaseSelectGood"));
         }
      }
      
      private function fixedPriceBuy(param1:Boolean, param2:Boolean, param3:int, param4:int) : void
      {
         if(param1)
         {
            AuctionMessageSender.sendFixPriceItemMessage(param3,param4);
         }
      }
      
      public function dispose() : void
      {
         if(_inputFrame)
         {
            _inputFrame.dispose();
            _inputFrame = null;
         }
         _listTitle.titleGrade.removeEventListener("click",__onTitleClick);
         _listTitle.titleTime.removeEventListener("click",__onTitleClick);
         _listTitle.titlePrice.removeEventListener("click",__onTitleClick);
         _listTitle.titleCurPrice.removeEventListener("click",__onTitleClick);
         _data.removeEventListener("change",onListDataChange);
         _bottomBar.getPageControlComp().getPreBtn().removeEventListener("click",onPrePageClick);
         _bottomBar.getPageControlComp().getNextBtn().removeEventListener("click",onNextPageClick);
         _bottomBar.getAuctionBtn().removeEventListener("click",onAuctionClick);
         _bottomBar.getFixedPriceBtn().removeEventListener("click",onFixedPriceClick);
         var _loc1_:AuctionModel = FrameControllerManager.instance.auctionController.model;
         _loc1_.removeEventListener(AuctionEvent.REFRESH_RECORD,onRefreshEvent);
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

