package yishi.utils
{
   import yishi.manager.PlayerManager;
   
   public class SiteParaUtils
   {
      
      private static const paras:Array = ["{username}","{uid}","{nickname}","{site}"];
      
      public function SiteParaUtils()
      {
         super();
      }
      
      public static function filterRequestPath(param1:String) : String
      {
         var _loc3_:RegExp = null;
         var _loc4_:String = null;
         var _loc5_:String = param1;
         for each(var _loc2_:String in paras)
         {
            if(param1.indexOf(_loc2_) != -1)
            {
               _loc3_ = new RegExp(_loc2_,"g");
               _loc4_ = getValueByPara(_loc2_);
               _loc5_ = _loc5_.replace(_loc3_,_loc4_);
            }
         }
         return _loc5_;
      }
      
      private static function getValueByPara(param1:String) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case "{username}":
               _loc2_ = PlayerManager.instance.currentPlayerModel.userInfo.user;
               break;
            case "{uid}":
               _loc2_ = "" + PlayerManager.instance.currentPlayerModel.playerInfo.userId;
               break;
            case "{nickname}":
               _loc2_ = "" + PlayerManager.instance.currentPlayerModel.playerInfo.nickName;
               break;
            case "{site}":
               _loc2_ = PlayerManager.instance.currentPlayerModel.userInfo.site;
         }
         return _loc2_;
      }
   }
}

