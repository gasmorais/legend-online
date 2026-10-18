package auction.view.common
{
   import manager.LanguageMgr;
   import mvc.module.auction.AuctionListItemData;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class AuctionChecker
   {
      
      public function AuctionChecker()
      {
         super();
      }
      
      public static function checkAuction(param1:AuctionListItemData) : Boolean
      {
         if(param1.getGoodsInfo().userId == PlayerManager.instance.currentPlayerModel.userInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("Auction.AuctionCheckResult1"));
            return false;
         }
         return true;
      }
      
      public static function checkFixPrice(param1:AuctionListItemData) : Boolean
      {
         if(param1.getGoodsInfo().userId == PlayerManager.instance.currentPlayerModel.userInfo.userId)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("Auction.AuctionCheckResult2"));
            return false;
         }
         return true;
      }
   }
}

