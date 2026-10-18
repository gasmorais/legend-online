package chat.utils
{
   import flash.utils.getTimer;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.GroupfbManager;
   import managers.RoomManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import yishi.manager.ArmyManager;
   import yishi.manager.BraveLegManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.StringHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ChatHelper
   {
      
      public static const SEND_CD_1:int = 30000;
      
      public static const SEND_CD_2:int = 2000;
      
      public static const SEND_CD_3:int = 2000;
      
      public static var lastSendTime1:int = -30000;
      
      public static var lastSendTime2:int = -2000;
      
      public static var lastSendTime3:int = -10000;
      
      public static const CHATCHANNEL_MAXCHAR:int = 84;
      
      public static const FRIENDSCHAT_MAXCHAR:int = 84;
      
      public static const CONSORTIACHAT_MAXCHAR:int = 84;
      
      public function ChatHelper()
      {
         super();
      }
      
      public static function parasMsgs(param1:String) : String
      {
         var _loc2_:String = param1;
         _loc2_ = StringHelper.trim(_loc2_);
         _loc2_ = FilterWordManager.filterWrod(_loc2_);
         return StringHelper.rePlaceHtmlTextField(_loc2_);
      }
      
      public static function checkCanSend(param1:String, param2:int) : Boolean
      {
         var _loc3_:String = null;
         if(ArmyManager.instance.thane.grades < 6)
         {
            _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command05");
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         _loc3_ = "";
         if(param1.length == 0)
         {
            return false;
         }
         if(param1 == "")
         {
            _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command01");
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         if(param2 == 8)
         {
            if(checkSceneType())
            {
               if(getTimer() - lastSendTime1 < 30000)
               {
                  _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command02",30000 * 0.001);
                  MessageTipManager.instance().show(_loc3_);
                  return false;
               }
            }
            else if(getTimer() - lastSendTime2 < 2000)
            {
               _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command02",2000 * 0.001);
               MessageTipManager.instance().show(_loc3_);
               return false;
            }
         }
         if(param2 == 10 && getTimer() - lastSendTime3 < 2000)
         {
            _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command02",2000 * 0.001);
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         if(param2 == 109 && getTimer() - lastSendTime3 < 2000)
         {
            _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command02",2000 * 0.001);
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         if(param2 == 5 && PlayerManager.instance.currentPlayerModel.playerInfo.consortiaID == 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command03");
            MessageTipManager.instance().show(_loc3_);
            return false;
         }
         if(param2 == 6)
         {
            if(!checkTeamChatScene())
            {
               _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command04");
               MessageTipManager.instance().show(_loc3_);
               return false;
            }
         }
         if(param2 == 14)
         {
            if(!checkGroupTeamChatScene())
            {
               _loc3_ = LanguageMgr.GetTranslation("chat.view.ChatInputView.command07");
               MessageTipManager.instance().show(_loc3_);
               return false;
            }
         }
         return true;
      }
      
      private static function checkGroupTeamChatScene() : Boolean
      {
         var _loc1_:Boolean = false;
         if(GroupfbManager.instance.model.hasGroupTeam)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private static function checkTeamChatScene() : Boolean
      {
         var _loc1_:Boolean = true;
         if(BraveLegManager.instance.model.teamInfo)
         {
            _loc1_ = true;
         }
         else if(FreedomTeamManager.instance.hasTeam)
         {
            _loc1_ = true;
         }
         else if(SceneManager.instance.currentType == "GAME_HALL_SCENE")
         {
            _loc1_ = true;
         }
         else if(SceneManager.instance.currentType == "SANDBOX_SCENE")
         {
            _loc1_ = true;
         }
         else if(SceneManager.instance.currentType == "VEHICLE")
         {
            _loc1_ = true;
         }
         else if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            _loc1_ = false;
         }
         else if(SceneManager.instance.currentType == "PLANE_CRISRIS")
         {
            _loc1_ = true;
         }
         else if(!RoomManager.instance.roomInfo)
         {
            _loc1_ = false;
         }
         else if(CampaignManager.instance.mapModel && WorldBossHelper.checkIsNoTeamChatMap(CampaignManager.instance.mapModel.mapId))
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public static function checkSceneType() : Boolean
      {
         var _loc2_:CampaignMapModel = null;
         var _loc1_:int = 0;
         var _loc3_:String = SceneManager.instance.currentType;
         switch(_loc3_)
         {
            case "CAMPAIGN_MAP_SCENE":
               _loc2_ = CampaignManager.instance.mapModel;
               _loc1_ = _loc2_.campaignTemplate.Types;
               if(_loc2_ && _loc2_.campaignTemplate && (_loc1_ == 1 || _loc1_ == 2 || _loc1_ == 10))
               {
                  return true;
               }
               return false;
               break;
            case "PVE_ROOM_SCENE":
            case "PVP_ROOM_SCENE":
            case "BATTLE_SCENE":
            case "VEHICLE":
            case "GAME_HALL_SCENE":
               break;
            default:
               return true;
         }
         return false;
      }
   }
}

