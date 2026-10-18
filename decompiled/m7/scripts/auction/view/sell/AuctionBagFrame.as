package auction.view.sell
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import flash.display.DisplayObjectContainer;
   import manager.LanguageMgr;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleDictionary;
   
   public class AuctionBagFrame extends Frame
   {
      
      public static var pane:AuctionSellBagPane;
      
      private var _items:SimpleDictionary;
      
      private var _goodsType:int;
      
      private var panelParent:DisplayObjectContainer;
      
      public function AuctionBagFrame(param1:int = 1)
      {
         _goodsType = param1;
         super();
         initView();
         addHandler();
      }
      
      private function initView() : void
      {
         _items = GoodsManager.instance.getGeneralBagList();
         addToContent(getBagPane());
         panelParent = pane.parent;
         getBagPane().defaultView(_goodsType);
      }
      
      private function addHandler() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               hide();
         }
      }
      
      public function show() : void
      {
         if(_goodsType == 2)
         {
            titleText = LanguageMgr.GetTranslation("pet.PetFrame.title");
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("Auction.BagTitle");
         }
         LayerManager.Instance.addToLayer(this,2);
         getBagPane().setScrollPosition();
         AuctionGoodMoveControl.stopBlink();
      }
      
      public function isOpen() : Boolean
      {
         if(parent)
         {
            return true;
         }
         return false;
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         AuctionGoodMoveControl.playBlink();
         AuctionGoodMoveControl.isFirstOpenSellPane = false;
      }
      
      public function getBagPane() : AuctionSellBagPane
      {
         if(!pane)
         {
            pane = new AuctionSellBagPane(7,8);
            pane.x = -2;
            pane.y = 2;
         }
         return pane;
      }
      
      override public function dispose() : void
      {
         removeEventListener("response",__frameResponse);
         if(pane && panelParent && pane.parent == panelParent)
         {
            pane.parent.removeChild(pane);
         }
         panelParent = null;
         super.dispose();
      }
   }
}

