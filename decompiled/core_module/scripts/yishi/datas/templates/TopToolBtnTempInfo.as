package yishi.datas.templates
{
   import managers.ChildManager;
   import managers.SevenYearManager;
   import managers.WorldBossManager;
   import map.campaign.CampaignManager;
   import ui.toptoolbar.TopToolsBar;
   import ui.toptoolbar.view.TopBtnActiveBoxView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.ApexManager;
   import yishi.manager.AresLordsManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.CarnivalManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.MatelordsManager;
   import yishi.manager.OutyardManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.PokerManager;
   
   public class TopToolBtnTempInfo
   {
      
      public static const TimeTempType:int = 4;
      
      public static const SIGN_STATE:int = 2;
      
      public var TemplateId:int;
      
      public var TemplateName:String;
      
      public var BtnKey:String;
      
      public var Sort:int;
      
      public var Icon:String;
      
      public var BoxType:int;
      
      public var BoxTypeTo:int;
      
      public var boxItemList:Array = [];
      
      public var boxFlash:Boolean;
      
      public var boxView:TopBtnActiveBoxView;
      
      public var hasClick:Boolean = false;
      
      public function TopToolBtnTempInfo()
      {
         super();
      }
      
      public function get tempSort() : int
      {
         return int(Sort / 1000);
      }
      
      public function get IsTimeTemp() : Boolean
      {
         return tempSort == 4;
      }
      
      public function get isOpen() : Boolean
      {
         if(BtnKey == "matelords")
         {
            return MatelordsManager.instance.model.isOpen;
         }
         if(BtnKey == "crossgvg")
         {
            return CrossGuildManager.instance.model.state == 6;
         }
         if(BtnKey == "areslords")
         {
            return AresLordsManager.instance.model.isOpen;
         }
         if(BtnKey == "apex")
         {
            return ApexManager.instance.model.isOpen;
         }
         if(BtnKey == "braveleg")
         {
            return BraveLegManager.instance.model.isOpen;
         }
         if(BtnKey == "outyard")
         {
            return OutyardManager.instance.model.outyardIsOpen;
         }
         if(BtnKey == "poker")
         {
            return PokerManager.instance.openSign;
         }
         if(BtnKey == "pvp")
         {
            return playerInfo.isPVPStart;
         }
         if(BtnKey == "worldboss")
         {
            return playerInfo.worldbossState;
         }
         if(BtnKey == "vehicel")
         {
            return playerInfo.isVehicleStart;
         }
         if(BtnKey == "petboss")
         {
            return CampaignManager.instance.petBossModel.isOpen;
         }
         if(BtnKey == "childArena")
         {
            return ChildManager.instance.arenaModel.curstate == 4;
         }
         if(BtnKey == "rvr1")
         {
            return WorldBossManager.instance.pvpWarIsOpen;
         }
         if(BtnKey == "crossmuticampaign")
         {
            return playerInfo.isOpenCrossMutiCampaign;
         }
         if(BtnKey == "giftwill")
         {
            return false;
         }
         if(BtnKey == "unrealshooting")
         {
            return TopToolsBar.instance.unrealshootingState == 2;
         }
         if(BtnKey == "daylight")
         {
            return TopToolsBar.instance.dayLightState == 1;
         }
         if(BtnKey == "godsevening")
         {
            return TopToolsBar.instance.godsEveningLightState == 1;
         }
         if(BtnKey == "sevenyear")
         {
            return SevenYearManager.instance.model.isOpen;
         }
         if(BtnKey == "carnival")
         {
            return CarnivalManager.Instance.isOpen;
         }
         return false;
      }
      
      public function get isSignUpState() : Boolean
      {
         switch(BtnKey)
         {
            case "areslords":
               return TopToolsBar.instance.areslordsState == 2;
            case "matelords":
               return TopToolsBar.instance.matelordsState == 2;
            case "crossgvg":
               return CrossGuildManager.instance.model.state == 2;
            case "braveleg":
               return TopToolsBar.instance.braveLegState == 2;
            case "childArena":
               return ChildManager.instance.arenaModel.curstate == 0;
            case "unrealshooting":
               return TopToolsBar.instance.unrealshootingState == 2;
            case "apex":
               return TopToolsBar.instance.areslordsState == 2;
            default:
               return false;
         }
      }
      
      public function get isCanSignUp() : Boolean
      {
         switch(BtnKey)
         {
            case "areslords":
               return !AresLordsManager.instance.model.isSign;
            case "matelords":
               return !MatelordsManager.instance.model.isSign;
            case "crossgvg":
               return CrossGuildManager.instance.model.signType != 0;
            case "braveleg":
               return !BraveLegManager.instance.model.isSign;
            case "childArena":
               return !ChildManager.instance.arenaModel.isSign;
            case "apex":
               return !ApexManager.instance.model.isSign;
            default:
               return false;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return playerModel.playerInfo;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

