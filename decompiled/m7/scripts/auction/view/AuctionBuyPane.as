package auction.view
{
   import auction.view.buy.AuctionBuyResultPane;
   import auction.view.buy.AuctionCategoryPane;
   import auction.view.buy.AuctionSearchControl;
   import auction.view.buy.AuctionSearchPane;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class AuctionBuyPane extends Sprite implements Disposeable
   {
      
      private var _searchPane:AuctionSearchPane;
      
      private var _categoryPane:AuctionCategoryPane;
      
      private var _resultPane:AuctionBuyResultPane;
      
      private var _searchControl:AuctionSearchControl;
      
      public function AuctionBuyPane()
      {
         super();
         initView();
         _searchControl = new AuctionSearchControl(_searchPane,_categoryPane,_resultPane.getBottomBar().getPageControlComp(),_resultPane);
      }
      
      private function initView() : void
      {
         _searchPane = new AuctionSearchPane();
         _searchPane.x = 3;
         _searchPane.y = 4;
         addChild(_searchPane);
         _categoryPane = new AuctionCategoryPane();
         _categoryPane.x = 0;
         _categoryPane.y = 84;
         addChild(_categoryPane);
         _resultPane = new AuctionBuyResultPane();
         _resultPane.x = 222;
         _resultPane.y = 84;
         addChild(_resultPane);
      }
      
      private function addHandler() : void
      {
      }
      
      private function removeHandler() : void
      {
      }
      
      public function getSearchControl() : AuctionSearchControl
      {
         return _searchControl;
      }
      
      public function dispose() : void
      {
         removeHandler();
         _searchControl.dispose();
         ObjectUtils.disposeObject(_searchPane);
         ObjectUtils.disposeObject(_categoryPane);
         ObjectUtils.disposeObject(_resultPane);
         _searchPane = null;
         _categoryPane = null;
         _resultPane = null;
      }
   }
}

