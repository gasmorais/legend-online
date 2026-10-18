package yishi.datas.consant
{
   import manager.LanguageMgr;
   
   public class SellResultType
   {
      
      public static const SUCC:int = 0;
      
      public static const FAIL:int = -1;
      
      public static const MALL_ITEN_NULL:int = -2;
      
      public static const MALL_ILLEGAL_COUNT:int = -3;
      
      public static const MALL_POINT_ERR:int = -4;
      
      public static const MALL_FIXPOINT_ERR:int = -5;
      
      public static const MALL_HOUR_ERR:int = -6;
      
      public static const MALL_ITEM_BIND:int = -7;
      
      public static const MALL_ITEM_NOT_EXIST:int = -8;
      
      public static const MALL_ITEM_SELLING:int = -9;
      
      public static const MALL_NO_GOLD:int = -10;
      
      public static const MALL_NO_POINT:int = -11;
      
      public static const MALL_CAN_NOT_AUCTION:int = -12;
      
      public static const MALL_AUCTION_FAIL:int = -13;
      
      public static const MALL_FIX_AUCTION_FAIL:int = -14;
      
      public static const MALL_DEL_ITEM_FAIL:int = -15;
      
      public static const MALL_BUY_SELF_ITEM:int = -16;
      
      public static const MALL_AUCTION_BY_SELF:int = -17;
      
      public static const MALL_SELL_MAX_COUNT:int = -18;
      
      public function SellResultType()
      {
         super();
      }
      
      public static function getResultStr(param1:int) : String
      {
         param1 = Math.abs(param1);
         return LanguageMgr.GetTranslation("Auction.ResultAlert" + param1);
      }
   }
}

