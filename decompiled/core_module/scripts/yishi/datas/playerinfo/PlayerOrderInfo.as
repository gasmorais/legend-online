package yishi.datas.playerinfo
{
   import manager.LanguageMgr;
   
   public class PlayerOrderInfo
   {
      
      public static const NEW_PLAYER_ORDER:int = 15000;
      
      public var userId:int;
      
      public var gpOrder:int;
      
      public var lastDayDate:Date;
      
      public var lastDayGP:int;
      
      public var gpDayOrder:int;
      
      public var lastWeekGP:int;
      
      public var lastWeekDate:Date;
      
      public var gpWeekOrder:int;
      
      public var lastMonthGP:int;
      
      public var lastMonthDate:Date;
      
      public var gpMonthOrder:int;
      
      public var fightCapacityOrder:int;
      
      public var multipleApOrder:int;
      
      public var honourOrder:int;
      
      public var charmsOrder:int;
      
      public var soulScoreOrder:int;
      
      public var crossScore:int;
      
      public function PlayerOrderInfo()
      {
         super();
      }
      
      public function getGpOrder() : String
      {
         if(gpOrder == 0)
         {
            return LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         if(gpOrder >= 15000)
         {
            return LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         return gpOrder.toString();
      }
      
      public function getFightCapacityOrder() : String
      {
         if(fightCapacityOrder >= 15000)
         {
            return LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         return fightCapacityOrder.toString();
      }
      
      public function getMultipleApOrder() : String
      {
         if(multipleApOrder >= 15000 || multipleApOrder <= 0)
         {
            return LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         return multipleApOrder.toString();
      }
      
      public function getHonourOrder() : String
      {
         if(honourOrder >= 15000)
         {
            return LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         return honourOrder.toString();
      }
      
      public function getCharmsOrder() : String
      {
         if(charmsOrder >= 15000)
         {
            return LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         return charmsOrder.toString();
      }
      
      public function getSoulScoreOrder() : String
      {
         if(soulScoreOrder >= 15000)
         {
            return LanguageMgr.GetTranslation("colosseum.view.ColosseumPlayerItem.newPeople");
         }
         return soulScoreOrder.toString();
      }
   }
}

