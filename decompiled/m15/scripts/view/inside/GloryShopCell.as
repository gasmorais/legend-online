package view.inside
{
   import mvc.module.shop.ShopGoodsInfo;
   import view.GoodsItem;
   import yishi.view.community.PageListBaseCell;
   
   public class GloryShopCell extends PageListBaseCell
   {
      
      private var item:GoodsItem;
      
      public function GloryShopCell()
      {
         super();
         item = new GoodsItem();
         addChild(item);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:ShopGoodsInfo = param1 as ShopGoodsInfo;
         item.data = _loc2_;
      }
      
      override public function get width() : Number
      {
         return item.width;
      }
      
      override public function get height() : Number
      {
         return item.height;
      }
   }
}

