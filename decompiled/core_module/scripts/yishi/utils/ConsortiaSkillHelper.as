package yishi.utils
{
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaSkillHelper
   {
      
      public function ConsortiaSkillHelper()
      {
         super();
      }
      
      public static function getLevelByType(param1:int, param2:PlayerInfo) : int
      {
         var _loc3_:String = "";
         switch(param1)
         {
            case 6:
               _loc3_ = "consortiaPower";
               break;
            case 8:
               _loc3_ = "consortiaAgility";
               break;
            case 9:
               _loc3_ = "consortiaIntellect";
               break;
            case 10:
               _loc3_ = "consortiaCaptain";
               break;
            case 11:
               _loc3_ = "consortiaGold";
               break;
            case 12:
               _loc3_ = "consortiaPhysique";
               break;
            case 13:
               _loc3_ = "newPowerLv";
               break;
            case 14:
               _loc3_ = "newAgilityLv";
               break;
            case 15:
               _loc3_ = "newIntellectLv";
               break;
            case 16:
               _loc3_ = "newPhysiqueLv";
               break;
            case 17:
               _loc3_ = "famGpLv";
               break;
            case 18:
               _loc3_ = "medalLv";
               break;
            case 19:
               _loc3_ = "honorLv";
               break;
            case 21:
               _loc3_ = "propertyLv";
               break;
            case 22:
               _loc3_ = "masterPowerLv";
               break;
            case 23:
               _loc3_ = "masterAgilityLv";
               break;
            case 24:
               _loc3_ = "masterIntellectLv";
               break;
            case 25:
               _loc3_ = "masterPhysiqueLv";
         }
         if(_loc3_ != "" && param2.hasOwnProperty(_loc3_))
         {
            return param2[_loc3_];
         }
         return 0;
      }
      
      public static function addOffer() : void
      {
         SimpleAlertHelper.instance.data = [__addOfferCallBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("consortia.helper.ConsortiaAltarHelper.content02");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_);
      }
      
      public static function addWealth() : void
      {
         SimpleAlertHelper.instance.data = [__addOfferCallBack];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("consortia.helper.ConsortiaUpgradeHelper.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_);
      }
      
      private static function __addOfferCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CheckUIModuleUtil.instance.tryCall("consortia",openContributeCall);
         }
      }
      
      private static function openContributeCall() : void
      {
         FrameControllerManager.instance.consortiaController.closeSkillFrame();
         FrameControllerManager.instance.consortiaController.closeBuildingFrame(false);
         FrameControllerManager.instance.consortiaController.showContributeFrame();
      }
   }
}

