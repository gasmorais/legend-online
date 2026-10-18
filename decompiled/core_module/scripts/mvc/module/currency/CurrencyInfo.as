package mvc.module.currency
{
   public class CurrencyInfo
   {
      
      public static const TOKEN_TYPE_1:int = 1;
      
      public static const TOKEN_TYPE_2:int = 2;
      
      public static const TOKEN_TYPE_3:int = 3;
      
      public var masterType:int;
      
      public var amount:int;
      
      public var expiredDate:String;
      
      public var sort:int;
      
      public var tokenType:int;
      
      public function CurrencyInfo()
      {
         super();
      }
   }
}

