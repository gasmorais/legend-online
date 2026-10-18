package chat.datas
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.text.TextFormat;
   import manager.LanguageMgr;
   
   public class ChatChannel
   {
      
      public static const ALL:int = 0;
      
      public static const BIGBUGLE:int = 1;
      
      public static const SYSTEM:int = 2;
      
      public static const INFO:int = 3;
      
      public static const PERSONAL:int = 20;
      
      public static const CONSORTIA:int = 5;
      
      public static const TEAM:int = 6;
      
      public static const ALERT:int = 7;
      
      public static const CURRENT:int = 8;
      
      public static const WORLD:int = 10;
      
      public static const SYS_ALERT:int = 11;
      
      public static const NOTICE:int = 12;
      
      public static const CROSS_BIGBUGLE:int = 13;
      
      public static const GROUP_TEAM:int = 14;
      
      public static const GOLD_BIGBUGLE:int = 15;
      
      public static const BOTTLE:int = 21;
      
      public static const GROUPCHAT_INFO:int = 98;
      
      public static const GROUPCHAT_SELF:int = 99;
      
      public static const GROUPCHAT_SELF_NAME:int = 101;
      
      public static const GROUPCHAT_OTHER:int = 100;
      
      public static const GROUPCHAT_OTHER_NAME:int = 102;
      
      public static const MYSTERYSHOP_LUCKYPLAYER:int = 103;
      
      public static const CHAT_POP:int = 104;
      
      public static const BUBBLETYPE_SELF:int = 105;
      
      public static const BUBBLETYPE_TARGET:int = 106;
      
      public static const POKER:int = 107;
      
      public static const CROSS_BUGLE_INVITE:int = 108;
      
      public static const OUTYARD:int = 109;
      
      public static const STOKES_ORE:int = 110;
      
      public static const WISH_POOL:int = 111;
      
      private static var _noticeChannelList:Array;
      
      public static const channels:Array = [13,1,10,6,5,8,14,109,2,7,3,11,12];
      
      public static const chanel_key_set:Array = ["k","d","x","p","g","a","t","w"];
      
      public function ChatChannel()
      {
         super();
      }
      
      public static function getChatChannelName(param1:int) : String
      {
         switch(param1)
         {
            case 13:
            case 108:
               break;
            case 1:
               return LanguageMgr.GetTranslation("chat.datas.getChatChannelName.BIGBUGLE");
            case 10:
               return LanguageMgr.GetTranslation("chat.datas.getChatChannelName.SMALLBUGLE");
            case 109:
               return LanguageMgr.GetTranslation("chat.datas.getChatChannelName.OUTYARD");
            case 2:
            case 11:
               return LanguageMgr.GetTranslation("chat.datas.getChatChannelName.ALERT");
            case 3:
               return LanguageMgr.GetTranslation("chat.datas.getChatChannelName.INFO");
            case 20:
               return LanguageMgr.GetTranslation("public.privateChat");
            case 5:
               return LanguageMgr.GetTranslation("public.consortia");
            case 6:
               return LanguageMgr.GetTranslation("chat.datas.getChatChannelName.TEAM");
            case 8:
               return LanguageMgr.GetTranslation("chat.view.ChatInputView.channel");
            case 12:
               return LanguageMgr.GetTranslation("chat.view.ChatInputView.NOTICE");
            case 14:
               return LanguageMgr.GetTranslation("chat.view.ChatInputView.GROUPTEAM");
            case 15:
               return LanguageMgr.GetTranslation("chat.view.ChatInputView.NOTICE");
            default:
               return LanguageMgr.GetTranslation("chat.datas.getChatChannelName.UNKNOWN");
         }
         return LanguageMgr.GetTranslation("chat.datas.getChatChannelName.CrossBUGLE");
      }
      
      public static function getChatChannelColoer(param1:int) : uint
      {
         switch(param1)
         {
            case 13:
               return 16759297;
            case 1:
            case 15:
               break;
            case 10:
               return 15439108;
            case 109:
               return 15439108;
            case 2:
            case 11:
               return 16774656;
            case 3:
               return 16774656;
            case 20:
               return 16150522;
            case 5:
               return 5035345;
            case 6:
               return 9674239;
            case 8:
               return 16777215;
            case 12:
               return 16774656;
            case 14:
               return 16746889;
            case 108:
               return 65490;
            default:
               return 16777215;
         }
         return 55551;
      }
      
      public static function getChannelFormat(param1:int) : TextFormat
      {
         return ComponentFactory.Instance.model.getSet("chatII.InputChannelTF_" + param1);
      }
      
      public static function get noticeChannelList() : Array
      {
         if(!_noticeChannelList)
         {
            _noticeChannelList = [];
            _noticeChannelList.push(12);
         }
         return _noticeChannelList;
      }
      
      public static function isNoticeChannel(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         if(noticeChannelList.indexOf(param1) != -1)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
   }
}

