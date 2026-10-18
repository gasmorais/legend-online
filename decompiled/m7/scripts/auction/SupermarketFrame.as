package auction
{
   import auction.view.supermarket.AuctionShopView;
   import auction.view.supermarket.MysteryShopView;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.MysteryShopManager;
   import mvc.module.auction.MysteryShopModel;
   import yishi.keyboard.KeyBoardRegister;
   
   public class SupermarketFrame extends Frame
   {
      
      private var _back:Bitmap;
      
      private var _actionShopView:AuctionShopView;
      
      private var _mysteryShopView:MysteryShopView;
      
      public function SupermarketFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.auction.MarketBg");
         _actionShopView = ComponentFactory.Instance.creatCustomObject("auction.AuctionShop");
         _mysteryShopView = ComponentFactory.Instance.creatCustomObject("auction.MysteryShop");
         addToContent(_back);
         addToContent(_actionShopView);
         addToContent(_mysteryShopView);
      }
      
      public function get auctionShopView() : AuctionShopView
      {
         return _actionShopView;
      }
      
      public function get mysteryShopView() : MysteryShopView
      {
         return _mysteryShopView;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:int = 1) : void
      {
         titleText = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command24");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         if(!mysteryShopModel.lastRefreshTime || mysteryShopModel.remainTime == 0)
         {
            mysteryShopManager.sendRefreshGoodsList(false);
         }
         if(param1 == 1)
         {
            _actionShopView.showMask.visible = false;
         }
         else
         {
            _mysteryShopView.showMask.visible = false;
         }
      }
      
      private function get mysteryShopModel() : MysteryShopModel
      {
         return MysteryShopManager.instance.model;
      }
      
      private function get mysteryShopManager() : MysteryShopManager
      {
         return MysteryShopManager.instance;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

