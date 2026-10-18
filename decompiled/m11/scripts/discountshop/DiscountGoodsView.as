package discountshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.discountshop.DiscountShopItemInfo;
   
   public class DiscountGoodsView extends Sprite implements Disposeable
   {
      
      private var _goodsListView:Sprite;
      
      private var _scrollPanel:ScrollPanel;
      
      public function DiscountGoodsView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _goodsListView = new Sprite();
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("discountshop.discountGoodsScrollPanel");
         addChild(_scrollPanel);
         _scrollPanel.setView(_goodsListView);
      }
      
      public function set data(param1:Vector.<DiscountShopItemInfo>) : void
      {
         var _loc4_:int = 0;
         var _loc2_:DiscountGoodsItem = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         ObjectUtils.disposeAllChildren(_goodsListView);
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = _loc4_ / 2;
            _loc3_ = _loc4_ % 2;
            _loc2_ = new DiscountGoodsItem();
            _loc2_.data = param1[_loc4_];
            _loc2_.x = _loc3_ * (_loc2_.width + 7);
            _loc2_.y = _loc5_ * (_loc2_.height + 6) + 7;
            _goodsListView.addChild(_loc2_);
            _loc4_++;
         }
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         if(_goodsListView)
         {
            ObjectUtils.disposeObject(_goodsListView);
         }
         _goodsListView = null;
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

