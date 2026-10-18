package mvc.module.currency
{
   import manager.LanguageMgr;
   
   public class CurrencyType
   {
      
      public static const PET_CRYSTAL:int = 1;
      
      public static const PET_FIRE_CREAM:int = 2;
      
      public static const PET_WATER_CREAM:int = 3;
      
      public static const PET_ELECTRIC_CREAM:int = 4;
      
      public static const PET_WIND_CREAM:int = 5;
      
      public static const GUILD_SKILL:int = 6;
      
      public static const CHAOS:int = 10;
      
      public static const MAZE_GLOD:int = 11;
      
      public static const ARENA_MEDAL:int = 8;
      
      public static const ETERNAL_CRYSTAL:int = 12;
      
      public static const MAGIC_DUST:int = 13;
      
      public static const STARSCORE:int = -1;
      
      public static const LIGHTSCORE:int = -2;
      
      public static const PURPLECRYSTAL:int = -3;
      
      public static const SHOPSCORE:int = -4;
      
      public static const LEAGUESCORE:int = -5;
      
      public static const MOUNT_COIN:int = 14;
      
      public static const GAME_BOX_COIN:int = 15;
      
      public static const STACK_HEAD_COIN:int = 17;
      
      public static const VIP_COIN:int = 41;
      
      public static const ARES_HEART:int = 18;
      
      public static const YARRAMAN_COIN:int = 19;
      
      public static const ATHENA_TEAR:int = 20;
      
      public static const BINGO_COIN:int = 21;
      
      public static const GLORY_COIN:int = 22;
      
      public static const YELLOW_COIN:int = 23;
      
      public static const EXPLORE_MEDAL:int = 24;
      
      public static const PET_EXCHANGE_COIN:int = 26;
      
      public static const ASSAULTWAR_MEDAL:int = 28;
      
      public static const NEW_MAGIC_DUST:int = 27;
      
      public static const NAVIGATION_COIN:int = 101;
      
      public static const POKER_SCORE:int = 102;
      
      public static const POKER_CORN:int = 103;
      
      public static const GODS_MARKING:int = 46;
      
      public static const COPY_CONSORTIA:int = 29;
      
      public static const APEX_COIN:int = 30;
      
      public static const NEW_CROSS_GUILD_COIN:int = 31;
      
      public static const ANTAEUS_COIN:int = 32;
      
      public static const AIRGARDEN_PROP_COIN:int = 33;
      
      public static const AIRGARDEN_BED_COIN:int = 34;
      
      public static const EAST_EGG_COIN:int = 35;
      
      public static const EAST_TICKES_COIN:int = 36;
      
      public static const FLAME_TEMPLE_COIN:int = 37;
      
      public static const DUSK_AREA_COIN:int = 38;
      
      public static const DARK_MAZE_SHOP_COIN:int = 39;
      
      public static const DEMON_ROAD_SHOP_COIN:int = 56;
      
      public static const CONSORTIA_NEW_CONSORTIA_SHOP_COIN:int = 57;
      
      public static const POSEIDON_SHOP_SCORE_COIN:int = 58;
      
      public static const THESEUS_PVP_MEADL_COIN:int = 59;
      
      public static const THESEUS_PVP_HONER_COIN:int = 60;
      
      public static const THESEUS_MULTIPVP_HONER_COIN:int = 69;
      
      public static const SECRETWAR_SHOP_COIN:int = 61;
      
      public static const PET_SPIRIT:int = 100;
      
      public static const PET_BREATH:int = 99;
      
      public static const YEAR_BOX_KEY:int = 62;
      
      public static const YEAR_EGG_TICKET:int = 63;
      
      public static const YEAR_GOLD:int = 64;
      
      public static const MINOS:int = 65;
      
      public static const CHESSPVP:int = 66;
      
      public static const CHILD_NS_WAR:int = 67;
      
      public static const THESEUSCOLLEECTIONVBOX:int = 70;
      
      public static const THESEUSSHUIJING:int = 71;
      
      public static const CAT_TOY_TYPE_LIST:Array = [1001,1002,1003,1004,1005,1006,1007];
      
      public static const CAT_TOY_VALUE_LIST:Array = [-2000,-2100,-2200,-2300,-2400,-2500,-2600];
      
      public static const MAGIC_PUB_TYPE_LIST:Array = [101,102,103,104,105,106,107,108,109,110];
      
      public static const MAGIC_PUB_VALUE_LIST:Array = [-1700,-1701,-1702,-1703,-1704,-1705,-1706,-1707,-1708,-1709];
      
      public function CurrencyType()
      {
         super();
      }
      
      public static function getCurrencyNameByType(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType7");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType1");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType2");
               break;
            case 4:
               _loc2_ = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType3");
               break;
            case 5:
               _loc2_ = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType4");
               break;
            case 6:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type01");
               break;
            case 8:
               _loc2_ = LanguageMgr.GetTranslation("map.campaign.pvp.PvpSettlementAwardView.awardMax.tipData");
               break;
            case -1:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type03");
               break;
            case -2:
               _loc2_ = LanguageMgr.GetTranslation("mainBar.view.ResourceView.crystal");
               break;
            case -3:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type04");
               break;
            case -4:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type05");
               break;
            case -5:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type06");
               break;
            case 10:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type08");
               break;
            case 11:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type09");
               break;
            case 12:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type10");
               break;
            case 14:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type14");
               break;
            case 102:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type15");
               break;
            case 103:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type16");
               break;
            case 17:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type17");
               break;
            case 101:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type101");
               break;
            case 18:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type18");
               break;
            case 19:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type19");
               break;
            case 20:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type20");
               break;
            case 22:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type22");
               break;
            case 27:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type27");
               break;
            case 21:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type28");
               break;
            case 23:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type29");
               break;
            case 24:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type24");
               break;
            case 28:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type25");
               break;
            case 46:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type35");
               break;
            case 26:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type26");
               break;
            case 29:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type36");
               break;
            case 31:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type37");
               break;
            case 30:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type38");
               break;
            case 32:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type39");
               break;
            case 33:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type330");
               break;
            case 34:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type340");
               break;
            case 37:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type370");
               break;
            case 38:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type380");
               break;
            case 56:
               _loc2_ = LanguageMgr.GetTranslation("demonroad.shop.CurrencyType.type");
               break;
            case 39:
               _loc2_ = LanguageMgr.GetTranslation("mvc.module.currency.CurrencyType.type40");
               break;
            case 58:
               _loc2_ = LanguageMgr.GetTranslation("poseidon.shop.type");
               break;
            case 100:
               _loc2_ = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType8");
               break;
            case 99:
               _loc2_ = LanguageMgr.GetTranslation("view.subshop.PetExchangeShopFrame.moneyType10");
               break;
            case 61:
               _loc2_ = LanguageMgr.GetTranslation("secretwar.shop.type");
               break;
            case 62:
               _loc2_ = LanguageMgr.GetTranslation("yearactivity.shop.yearboxkey");
               break;
            case 63:
               _loc2_ = LanguageMgr.GetTranslation("yearactivity.shop.yeareggticket");
               break;
            case 64:
               _loc2_ = LanguageMgr.GetTranslation("yearactivity.shop.yeargold");
         }
         return _loc2_;
      }
   }
}

