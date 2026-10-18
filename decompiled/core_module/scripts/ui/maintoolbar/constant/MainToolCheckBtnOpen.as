package ui.maintoolbar.constant
{
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.RoyaltyBossManager;
   
   public class MainToolCheckBtnOpen
   {
      
      public function MainToolCheckBtnOpen()
      {
         super();
      }
      
      public static function getBtnKeyIsOpen(param1:String) : Boolean
      {
         var _loc2_:Boolean = false;
         switch(param1)
         {
            case "ShopBtn":
               return thane.grades >= 10;
            case "PackBtn":
               return thane.grades >= 4;
            case "PetBtn":
               return thane.grades >= 50;
            case "HeroBtn":
               return thane.grades >= 70;
            case "titanBtn":
               return thane.isChangeJob;
            case "mountBtn":
               return thane.grades >= 16;
            case "StarBtn":
               return thane.grades >= 18;
            case "SkillBtn":
               return thane.grades >= 7;
            case "storeBtn":
               return thane.grades >= 7;
            case "archaeologyBtn":
               return thane.grades >= 15;
            case "GuildBtn":
               return thane.grades >= 13;
            case "artifactBtn":
               return thane.vocationGrades > 0;
            case "petHallowsBtn":
               return thane.isChangeJob;
            case "nursingSpiritBtn":
               return thane.isChangeJob;
            case "BattleBtn":
               return true;
            case "marryBtn":
               return true;
            case "PopTipBtn":
               return true;
            case "FriendsBtn":
               return thane.grades >= 6;
            case "OuterCityBtn":
               return true;
            case "CastleBtn":
               return true;
            case "DragonTalkerBtn":
               return thane.vocationGrades > 0;
            case "GoddessBtn":
               return true;
            case "MonsterBtn":
               return thane.grades >= 70 && VersionSwitch.MONSTER;
            case "AvengerBtn":
               return VersionSwitch.AVENGER && thane.isAvenger;
            case "ProficiencyBtn":
               _loc2_ = RoyaltyBossManager.instance.model.royaltyLevel > 0;
               return _loc2_ && VersionSwitch.THESESOUL && thane.vocationIndex > 0;
            default:
               return false;
         }
      }
      
      public static function getBtnKeyTips(param1:String) : String
      {
         switch(param1)
         {
            case "ShopBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "O";
            case "PackBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "B";
            case "PetBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "Y";
            case "HeroBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "A";
            case "titanBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "I";
            case "mountBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "P";
            case "StarBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "H";
            case "SkillBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "S";
            case "storeBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "T";
            case "archaeologyBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "R";
            case "GuildBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "G";
            case "artifactBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "C";
            case "petHallowsBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "N";
            case "nursingSpiritBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "U";
            case "BattleBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "Z";
            case "marryBtn":
               return LanguageMgr.GetTranslation("ui.maintoolbar.MainToolBar.proposeTips");
            case "PopTipBtn":
               return LanguageMgr.GetTranslation("consortiagroupchat.msgBoxItemNameTxt");
            case "FriendsBtn":
               return LanguageMgr.GetTranslation("friends.view.FriendsFrame.title");
            case "OuterCityBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "Q";
            case "CastleBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "Q";
            case "DragonTalkerBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "D";
            case "GoddessBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "J";
            case "MonsterBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "K";
            case "AvengerBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "X";
            case "ProficiencyBtn":
               return LanguageMgr.GetTranslation("mainBar.MainToolBar.hotKey") + "E";
            default:
               return "";
         }
      }
      
      public static function getBtnKeyNoOpenTips(param1:String) : String
      {
         switch(param1)
         {
            case "ShopBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",10);
            case "PackBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",4);
            case "PetBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",50);
            case "HeroBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",70);
            case "titanBtn":
               return LanguageMgr.GetTranslation("MainToolBar.needChangeJob");
            case "mountBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",16);
            case "StarBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",18);
            case "SkillBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",7);
            case "storeBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",7);
            case "archaeologyBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",15);
            case "artifactBtn":
               return LanguageMgr.GetTranslation("MainToolBar.vocationGrades");
            case "petHallowsBtn":
               return LanguageMgr.GetTranslation("MainToolBar.needChangeJob");
            case "nursingSpiritBtn":
               return LanguageMgr.GetTranslation("MainToolBar.needChangeJob");
            case "FriendsBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",6);
            case "GuildBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",13);
            case "DragonTalkerBtn":
               return LanguageMgr.GetTranslation("MainToolBar.vocationGrades");
            case "MonsterBtn":
               return LanguageMgr.GetTranslation("store.view.StoreFrame.command01",70);
            case "AvengerBtn":
               return LanguageMgr.GetTranslation("MainToolBar.needAvenger");
            case "ProficiencyBtn":
               return LanguageMgr.GetTranslation("MainToolBar.needAvenger");
            default:
               return "";
         }
      }
      
      public static function getKeyTips(param1:String) : String
      {
         var _loc2_:Boolean = getBtnKeyIsOpen(param1);
         var _loc3_:String = "";
         if(_loc2_)
         {
            _loc3_ = getBtnKeyTips(param1);
         }
         else
         {
            _loc3_ = getBtnKeyNoOpenTips(param1);
         }
         return _loc3_;
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

