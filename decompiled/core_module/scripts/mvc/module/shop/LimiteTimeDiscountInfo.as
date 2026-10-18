package mvc.module.shop
{
   public class LimiteTimeDiscountInfo
   {
      
      public var id:int;
      
      public var limitCount:int;
      
      public var price:int;
      
      public var templateId:int;
      
      public var isBindMoney:Boolean;
      
      private var _count:int = 0;
      
      public var type:int = 2;
      
      public function LimiteTimeDiscountInfo()
      {
         super();
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
      }
   }
}

