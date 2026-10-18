package mvc.module.navigation
{
   import managers.PlayerCurrencyManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   
   public class NavigationHelper
   {
      
      public function NavigationHelper()
      {
         super();
      }
      
      public static function getNumByTempId(param1:int) : Number
      {
         switch(param1)
         {
            case -4000:
               return PlayerCurrencyManager.instance.currencyInfo.gameBoxCoin.amount;
            case -3000:
               return PlayerCurrencyManager.instance.currencyInfo.mountCoin.amount;
            case -1400:
               return PlayerCurrencyManager.instance.currencyInfo.guildSkill.amount;
            case -600:
               return ResourceManager.instance.waterCrystal.count;
            case -300:
               return playerInfo.strategy;
            case -200:
               return playerInfo.mineral;
            case -100:
               return ResourceManager.instance.gold.count;
            case -200:
               return playerInfo.mineral;
            case -100:
               return ResourceManager.instance.gold.count;
            case 208001:
               return PlayerCurrencyManager.instance.currencyInfo.arenaMedal.amount;
            case 208009:
               return PlayerCurrencyManager.instance.currencyInfo.mazeGold.amount;
            default:
               return GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(param1);
         }
      }
      
      private static function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

