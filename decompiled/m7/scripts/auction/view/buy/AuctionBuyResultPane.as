package auction.view.buy
{
   import auction.view.AuctionAlert;
   import auction.view.common.AuctionChecker;
   import auction.view.common.AuctionInputFrame;
   import auction.view.common.AuctionListColWidthConst;
   import auction.view.common.AuctionListComponent;
   import auction.view.common.AuctionListItem1;
   import auction.view.common.AuctionListTitleComponent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
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
   
   public class AuctionBuyResultPane extends Sprite implements Disposeable
   {
      
      private var _border:DisplayObject;
      
      private var _listTitle:AuctionListTitleComponent;
      
      private var _listComponent:AuctionListComponent;
      
      private var _bottomBar:AuctionBuyBottomBar;
      
      private var _corner1:DisplayObject;
      
      private var _corner2:DisplayObject;
      
      private var _corner3:DisplayObject;
      
      private var _corner4:DisplayObject;
      
      private var _data:AuctionResultListData;
      
      private var _inputFrame:AuctionInputFrame;
      
      public function AuctionBuyResultPane()
      {
         super();
         var _loc1_:AuctionModel = FrameControllerManager.instance.auctionController.model;
         _data = _loc1_.forSaleList;
         init();
         addHandler();
      }
      
      private function init() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("auction.buy.resultBack");
         addChild(_border);
         var _loc1_:Array = AuctionListColWidthConst.short;
         var _loc2_:Array = AuctionListColWidthConst.shortX;
         _listTitle = new AuctionListTitleComponent("auction.listTitleBmdS",_loc1_,_loc2_);
         _listTitle.x = 1;
         _listTitle.y = 1;
         addChild(_listTitle);
         _listComponent = new AuctionListComponent(AuctionListItem1,7,-3);
         _listComponent.setData(_data.getList());
         _listComponent.x = 3;
         _listComponent.y = 31;
         _listComponent.callBack = auction;
         addChild(_listComponent);
         _bottomBar = new AuctionBuyBottomBar();
         _bottomBar.x = 3;
         _bottomBar.y = 321;
         addChild(_bottomBar);
         _corner1 = ComponentFactory.Instance.creatComponentByStylename("auction.buyCorner1");
         _corner2 = ComponentFactory.Instance.creatComponentByStylename("auction.buyCorner2");
         _corner3 = ComponentFactory.Instance.creatComponentByStylename("auction.buyCorner3");
         _corner4 = ComponentFactory.Instance.creatComponentByStylename("auction.buyCorner4");
         addChild(_corner1);
         addChild(_corner2);
         addChild(_corner3);
         addChild(_corner4);
      }
      
      public function addHandler() : void
      {
         _data.addEventListener("change",onListDataChange);
         _bottomBar.getAuctionBtn().addEventListener("click",onAuctionClick);
         _bottomBar.getFixedPriceBtn().addEventListener("click",onFixedPriceClick);
      }
      
      public function get listTitle() : AuctionListTitleComponent
      {
         return _listTitle;
      }
      
      private function onListDataChange(param1:Event) : void
      {
         _listComponent.setData(_data.getList());
      }
      
      private function onAuctionClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         auction();
      }
      
      private function auction() : void
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
         if(param1 == _loc3_.currPrice)
         {
            if(!_loc3_.auctioned)
            {
               AuctionMessageSender.sendAuctionGoods(_loc3_.goodId,param1);
               return;
            }
         }
         if(param1 <= _loc3_.currPrice)
         {
            SimpleAlertHelper.instance.data = [];
            _loc7_ = LanguageMgr.GetTranslation("public.confirm");
            _loc8_ = LanguageMgr.GetTranslation("public.cancel");
            _loc9_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("Action.UnderCurrentPrice");
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
      
      public function getBottomBar() : AuctionBuyBottomBar
      {
         return _bottomBar;
      }
      
      public function dispose() : void
      {
         _data.removeEventListener("change",onListDataChange);
         _bottomBar.getAuctionBtn().removeEventListener("click",onAuctionClick);
         _bottomBar.getFixedPriceBtn().removeEventListener("click",onFixedPriceClick);
         ObjectUtils.disposeAllChildren(this);
         if(_inputFrame)
         {
            _inputFrame.dispose();
            _inputFrame = null;
         }
      }
   }
}

