package auction.view
{
   import auction.view.sell.AuctionGoodMoveControl;
   import auction.view.sell.AuctionSellResultPane;
   import auction.view.sell.AuctionSellSubmitPane;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class AuctionSellPane extends Sprite implements Disposeable
   {
      
      private var _sellPane:AuctionSellSubmitPane;
      
      private var _resultPane:AuctionSellResultPane;
      
      private var _type:int = 0;
      
      public function AuctionSellPane(param1:int = 1)
      {
         _type = param1;
         super();
         init();
      }
      
      private function init() : void
      {
         _sellPane = new AuctionSellSubmitPane();
         _sellPane.x = 1;
         _sellPane.y = 1;
         addChild(_sellPane);
         _resultPane = new AuctionSellResultPane(_type);
         _resultPane.x = 222;
         _resultPane.y = 1;
         addChild(_resultPane);
         AuctionGoodMoveControl.isFirstOpenSellPane = true;
         AuctionGoodMoveControl.init(_sellPane.getGoodCell(),_resultPane.getBagPane(),_sellPane);
         addHandler();
      }
      
      private function addHandler() : void
      {
         _sellPane.getCellItem().addEventListener("interactive_click",_InteractiveEventHandler,false,100);
         _sellPane.getCellItem().addEventListener("interactive_double_click",_InteractiveEventHandler);
      }
      
      private function _InteractiveEventHandler(param1:InteractiveEvent) : void
      {
         openBag();
      }
      
      private function openBag() : void
      {
         _resultPane.openBag();
      }
      
      public function dispose() : void
      {
         _sellPane.getCellItem().removeEventListener("interactive_click",_InteractiveEventHandler);
         _sellPane.getCellItem().removeEventListener("interactive_double_click",_InteractiveEventHandler);
         ObjectUtils.disposeObject(_sellPane);
         _sellPane = null;
         ObjectUtils.disposeObject(_resultPane);
         _resultPane = null;
      }
   }
}

