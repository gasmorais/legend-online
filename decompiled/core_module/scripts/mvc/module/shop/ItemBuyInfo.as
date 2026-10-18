package mvc.module.shop
{
   public class ItemBuyInfo
   {
      
      public static const BUY_SELF:int = 1;
      
      public static const SEND:int = 2;
      
      public static const PAY_BY_POINT:int = 1;
      
      public static const PAY_BY_GIFT:int = 2;
      
      public static const PAY_BY_GOLD:int = 3;
      
      public static const PAY_BY_CONSORTIA_OFFER:int = 4;
      
      public static const PAY_BY_HONOR:int = 5;
      
      public var goodId:int;
      
      public var count:int;
      
      public var result:String;
      
      public var receiveId:int;
      
      public var nickname:String;
      
      public var isDiscount:Boolean;
      
      public function ItemBuyInfo()
      {
         super();
      }
   }
}

