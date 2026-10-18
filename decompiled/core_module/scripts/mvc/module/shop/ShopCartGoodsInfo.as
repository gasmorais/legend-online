package mvc.module.shop
{
   public class ShopCartGoodsInfo
   {
      
      private var _goodsInfo:*;
      
      private var _number:int;
      
      private var _isBind:Boolean;
      
      private var _isDiscount:Boolean;
      
      public function ShopCartGoodsInfo()
      {
         super();
      }
      
      public function get number() : int
      {
         return _number;
      }
      
      public function set number(param1:int) : void
      {
         _number = param1;
      }
      
      public function get isBind() : Boolean
      {
         return _isBind;
      }
      
      public function set isBind(param1:Boolean) : void
      {
         _isBind = param1;
      }
      
      public function get goodsInfo() : *
      {
         return _goodsInfo;
      }
      
      public function set goodsInfo(param1:*) : void
      {
         _goodsInfo = param1;
      }
      
      public function get isDiscount() : Boolean
      {
         return _isDiscount;
      }
      
      public function set isDiscount(param1:Boolean) : void
      {
         _isDiscount = param1;
      }
   }
}

