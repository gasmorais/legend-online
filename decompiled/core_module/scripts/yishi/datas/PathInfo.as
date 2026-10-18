package yishi.datas
{
   import yishi.utils.SiteParaUtils;
   
   public class PathInfo
   {
      
      public static var GAME_WIDTH:Number = 800;
      
      public static var GAME_HEIGHT:Number = 480;
      
      public static var LANGUAGE:String;
      
      private var _PAY:String;
      
      public var TEMPLATE_PATH:String;
      
      private var _SNSPATH:String;
      
      private var _SITE:String;
      
      public var REQUEST_PATH:String;
      
      public var FACEBOOK_SHARE_PATH:String;
      
      public var FACEBOOK_SHARE_APPID:String;
      
      public var FOWARDSITE:String;
      
      public var FOWARDNAME:String;
      
      public var CastleServicePath:String;
      
      public var ResourcePath:String;
      
      public var SocktPath:String;
      
      public var CharPort:int;
      
      public var BattleSocketPath:String;
      
      public var BattlePort:int;
      
      public var UPLOAD_PATH:String;
      
      public var STORY_MOVIE:String;
      
      public var CLIENT_LOGIN_NAME:String;
      
      public var VERSION:String;
      
      public var FACE_NUM:int;
      
      private var _CLIENT_LOGIN_PATH:String;
      
      public var NICK_NAME_PATH:String;
      
      private var _AASRequestPath:String;
      
      private var _AASRegisterPath:String;
      
      private var _ONLINE:String;
      
      public function PathInfo()
      {
         super();
      }
      
      public function get AASRegisterPath() : String
      {
         return SiteParaUtils.filterRequestPath(_AASRegisterPath);
      }
      
      public function set AASRegisterPath(param1:String) : void
      {
         _AASRegisterPath = param1;
      }
      
      public function get AASRequestPath() : String
      {
         return SiteParaUtils.filterRequestPath(_AASRequestPath);
      }
      
      public function set AASRequestPath(param1:String) : void
      {
         _AASRequestPath = param1;
      }
      
      public function get PAY() : String
      {
         return SiteParaUtils.filterRequestPath(_PAY);
      }
      
      public function set PAY(param1:String) : void
      {
         _PAY = param1;
      }
      
      public function get CLIENT_LOGIN_PATH() : String
      {
         return encodeURI(_CLIENT_LOGIN_PATH);
      }
      
      public function set CLIENT_LOGIN_PATH(param1:String) : void
      {
         _CLIENT_LOGIN_PATH = param1;
      }
      
      public function set SNSPATH(param1:String) : void
      {
         _SNSPATH = param1;
      }
      
      public function get SNSPATH() : String
      {
         return _SNSPATH;
      }
      
      public function get SITE() : String
      {
         return SiteParaUtils.filterRequestPath(_SITE);
      }
      
      public function set SITE(param1:String) : void
      {
         _SITE = param1;
      }
      
      public function get ONLINE() : String
      {
         return _ONLINE;
      }
      
      public function set ONLINE(param1:String) : void
      {
         _ONLINE = param1;
      }
   }
}

