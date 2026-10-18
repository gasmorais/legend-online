package yishi.utils
{
   import yishi.manager.PathManager;
   
   public class MountAvatarPathHelper
   {
      
      public function MountAvatarPathHelper()
      {
         super();
      }
      
      public static function getUrl(param1:String) : String
      {
         return PathManager.resourcePath + "equip_show" + param1 + "/2.swf";
      }
      
      public static function getBattlePath(param1:String) : String
      {
         return PathManager.resourcePath + "equip/dragonic" + param1 + "/2.swf";
      }
      
      public static function getBattleBesatPath(param1:String) : String
      {
         return PathManager.resourcePath + "equip_show/dragonic" + param1 + "/2.swf";
      }
   }
}

