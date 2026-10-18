package yishi.datas.consant
{
   import manager.LanguageMgr;
   
   public class JobType
   {
      
      public static const UNRESTRICTED:int = 0;
      
      public static const NEWCOMER:int = 100;
      
      public static const WARRIOR:int = 1;
      
      public static const HUNTER:int = 2;
      
      public static const WIZARD:int = 3;
      
      public static const DRAGONIC:int = 4;
      
      public function JobType()
      {
         super();
      }
      
      public static function getJobName(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return "";
            case 1:
            case 4:
               break;
            case 2:
            case 5:
               return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name03");
            case 3:
            case 6:
               return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name04");
            case 100:
               return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name06");
            default:
               throw new Error(LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name05"));
         }
         return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name02");
      }
      
      public static function getDefaultCloakEquipNameByJob(param1:int) : String
      {
         if(param1 == 100)
         {
            return "";
         }
         return getDefaultBodyEquipNameByJob(param1) + "_cloak";
      }
      
      public static function getDefaultBodyEquipNameByJob(param1:int) : String
      {
         if(param1 == 100)
         {
            return "swf/avatar/mystery_default_body/2.bswf";
         }
         return getDefaultJobNameByJob(param1) + "body";
      }
      
      public static function getSitDownBodyEquipNameBtJob(param1:int) : String
      {
         var _loc2_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = "/warrior_sitdown_body";
               break;
            case 1:
               _loc2_ = "/sword_sitdown_body";
               break;
            case 2:
               _loc2_ = "/wizard_sitdown_body";
               break;
            case 3:
               _loc2_ = "/wizard_sitdown_body";
         }
         return _loc2_;
      }
      
      public static function getDefaultArmysEquipNameByJob(param1:int) : String
      {
         if(param1 == 100)
         {
            return "";
         }
         return getDefaultJobNameByJob(param1) + "arms";
      }
      
      public static function getDefaultHairUpByJob(param1:int) : String
      {
         if(param1 == 100)
         {
            return "";
         }
         return getDefaultJobNameByJob(param1) + "hairUp";
      }
      
      public static function getDefaultHairDownByJob(param1:int) : String
      {
         if(param1 == 100)
         {
            return "";
         }
         return getDefaultJobNameByJob(param1) + "hairDown";
      }
      
      public static function getDefaultMount() : String
      {
         return "/mount_default";
      }
      
      public static function getDefaultWing() : String
      {
         return "/wing_default";
      }
      
      public static function getMapMountEquipment(param1:String) : String
      {
         if(param1)
         {
            return param1 + "_mount";
         }
         return param1;
      }
      
      private static function getDefaultJobNameByJob(param1:int) : String
      {
         switch(param1)
         {
            case 0:
               return LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name01");
            case 1:
               return "/warrior_default_";
            case 2:
               return "/hunter_default_";
            case 3:
               return "/wizard_default_";
            case 4:
               return "/dragonic/dragonman_default_";
            case 100:
               return "/wizard_default_";
            default:
               throw new Error(LanguageMgr.GetTranslation("yishi.datas.consant.JobType.Name05"));
         }
      }
   }
}

