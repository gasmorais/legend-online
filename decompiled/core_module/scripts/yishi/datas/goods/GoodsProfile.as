package yishi.datas.goods
{
   import manager.LanguageMgr;
   
   public class GoodsProfile
   {
      
      public function GoodsProfile()
      {
         super();
      }
      
      public static function getGoodsProfileColor(param1:int) : uint
      {
         switch(param1 - 1)
         {
            case 0:
               return 16777215;
            case 1:
               return 5885249;
            case 2:
               return 3318520;
            case 3:
               return 11024631;
            case 4:
               return 15516160;
            default:
               return 16777215;
         }
      }
      
      public static function getGoodsProfileLetter(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return "D";
            case 1:
               return "C";
            case 2:
               return "B";
            case 3:
               return "A";
            case 4:
               return "S";
            default:
               return LanguageMgr.GetTranslation("yishi.datas.goods.GoodsProfile.profile01");
         }
      }
      
      public static function getGoodsProfileDescript(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("yishi.datas.goods.GoodsProfile.profile02");
            case 1:
               return LanguageMgr.GetTranslation("yishi.datas.goods.GoodsProfile.profile03");
            case 2:
               return LanguageMgr.GetTranslation("yishi.datas.goods.GoodsProfile.profile04");
            case 3:
               return LanguageMgr.GetTranslation("yishi.datas.goods.GoodsProfile.profile05");
            case 4:
               return LanguageMgr.GetTranslation("yishi.datas.goods.GoodsProfile.profile06");
            default:
               return LanguageMgr.GetTranslation("yishi.datas.goods.GoodsProfile.profile01");
         }
      }
   }
}

