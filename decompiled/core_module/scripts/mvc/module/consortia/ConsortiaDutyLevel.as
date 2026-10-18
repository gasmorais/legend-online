package mvc.module.consortia
{
   import manager.LanguageMgr;
   
   public class ConsortiaDutyLevel
   {
      
      public static const CHAIRMAN:int = 1;
      
      public static const VICE_CHAIRMAN:int = 2;
      
      public static const OFFICIAL:int = 3;
      
      public static const ELITE:int = 4;
      
      public static const NORMAL:int = 5;
      
      public function ConsortiaDutyLevel()
      {
         super();
      }
      
      public static function getDutyByButyLevel(param1:int) : String
      {
         var _loc2_:String = "";
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name00");
               break;
            case 1:
               _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name01");
               break;
            case 2:
               _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name02");
               break;
            case 3:
               _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name03");
               break;
            case 4:
               _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionFrame.name03");
         }
         return _loc2_;
      }
   }
}

