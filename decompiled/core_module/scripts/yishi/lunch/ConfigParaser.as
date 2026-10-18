package yishi.lunch
{
   import com.pickgliss.ui.ComponentSetting;
   import flash.display.LoaderInfo;
   import flash.system.Security;
   import yishi.datas.PathInfo;
   import yishi.datas.SwitchInfo;
   import yishi.datas.VersionSwitchInfo;
   import yishi.manager.ConfigManager;
   import yishi.manager.PathManager;
   
   public class ConfigParaser
   {
      
      public static var isInit:Boolean;
      
      public static var registerSize:int;
      
      public static var normalSize:int;
      
      public function ConfigParaser()
      {
         super();
      }
      
      public static function paras(param1:XML, param2:LoaderInfo) : void
      {
         var _loc3_:String = null;
         var _loc5_:SwitchInfo = null;
         var _loc7_:VersionSwitchInfo = null;
         isInit = true;
         for each(var _loc6_:XML in param1..corssdomainfile)
         {
            _loc3_ = String(_loc6_.@value);
            Security.loadPolicyFile(_loc3_);
         }
         registerSize = int(param1.UI_REQUEST_SIZE.@registerSize);
         normalSize = int(param1.UI_REQUEST_SIZE.@normalSize);
         var _loc8_:PathInfo = new PathInfo();
         for each(var _loc4_:XML in param1..NODE)
         {
            if(_loc4_.@site == ComponentSetting.SITE)
            {
               _loc8_.SITE = _loc4_.SITE.@value;
               _loc8_.PAY = _loc4_.PAY.@value;
               _loc8_.SNSPATH = _loc4_.SNSPATH.@value;
               _loc8_.CLIENT_LOGIN_PATH = _loc4_.CLIENT_LOGIN_PATH.@value;
               _loc8_.CLIENT_LOGIN_NAME = _loc4_.CLIENT_LOGIN_NAME.@value;
               _loc8_.AASRequestPath = _loc4_.AAS.@request;
               _loc8_.AASRegisterPath = _loc4_.AAS.@register;
               _loc8_.ONLINE = _loc4_.ONLINE.@value;
               if(_loc4_.child("NICK_NAME_PATH").length() > 0)
               {
                  _loc8_.NICK_NAME_PATH = _loc4_.child("NICK_NAME_PATH")[0].@value;
               }
               _loc5_ = new SwitchInfo();
               ConfigManager.setup(_loc5_);
               _loc7_ = new VersionSwitchInfo();
               ConfigManager.version_info = _loc7_;
            }
         }
         PathInfo.LANGUAGE = String(param1.LANGUAGE.@value);
         _loc8_.VERSION = param1.VERSION.@value;
         _loc8_.FACE_NUM = int(param1.FACE_NUM.@value);
         _loc8_.REQUEST_PATH = param1.REQUEST_PATH.@value;
         _loc8_.FACEBOOK_SHARE_PATH = param1.FACEBOOK_SHARE_PATH.@value;
         _loc8_.FACEBOOK_SHARE_APPID = param1.FACEBOOK_SHARE_APPID.@value;
         _loc8_.FOWARDSITE = param1.FOWARDSITE.@value;
         _loc8_.FOWARDNAME = param1.FOWARDSITE.@siteName;
         _loc8_.TEMPLATE_PATH = param1.TEMPLATE_PATH.@value;
         _loc8_.CastleServicePath = param1.CastleServicePath.@value;
         _loc8_.ResourcePath = param1.ResourcePath.@value;
         _loc8_.SocktPath = param1.SocktPath.@value;
         _loc8_.CharPort = int(param1.SocktPath.@SocketPort);
         _loc8_.BattleSocketPath = param1.BattleSocketPath.@value;
         _loc8_.BattlePort = int(param1.BattleSocketPath.@BattlePort);
         _loc8_.STORY_MOVIE = param1.StoryMovie.@value;
         _loc8_.UPLOAD_PATH = param1.UPLOAD_PATH.@value;
         PathManager.setup(_loc8_);
      }
   }
}

