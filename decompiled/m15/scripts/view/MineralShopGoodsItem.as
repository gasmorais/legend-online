package view
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import mvc.module.shop.ShopGoodsInfo;
   
   public class MineralShopGoodsItem extends Sprite implements Disposeable
   {
      
      private var _data:ShopGoodsInfo;
      
      public function MineralShopGoodsItem()
      {
         super();
      }
      
      public function get data() : ShopGoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         _data = param1;
      }
      
      public function dispose() : void
      {
      }
   }
}

