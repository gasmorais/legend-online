package mvc.module.mailcheck
{
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class MailCheckModel
   {
      
      public static const HAND_REFRESH_LIMIT:int = 300;
      
      public var isShow:Boolean = false;
      
      public var state:int;
      
      public var mailAddress:String;
      
      public var refreshTime:int = -1;
      
      public function MailCheckModel()
      {
         super();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

