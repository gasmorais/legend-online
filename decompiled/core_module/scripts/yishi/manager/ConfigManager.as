package yishi.manager
{
   import yishi.datas.SwitchInfo;
   import yishi.datas.VersionSwitchInfo;
   
   public class ConfigManager
   {
      
      private static var _info:SwitchInfo;
      
      private static var _version_info:VersionSwitchInfo;
      
      public static var backAvatarLisr:XML;
      
      public static var backResourceLis:XML;
      
      public function ConfigManager()
      {
         super();
      }
      
      public static function get version_info() : VersionSwitchInfo
      {
         return _version_info;
      }
      
      public static function set version_info(param1:VersionSwitchInfo) : void
      {
         _version_info = param1;
      }
      
      public static function setup(param1:SwitchInfo) : void
      {
         _info = param1;
      }
      
      public static function get info() : SwitchInfo
      {
         return _info;
      }
   }
}

