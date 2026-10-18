package yishi.service.managers
{
   import yishi.manager.PlayerManager;
   import yishi.service.services.AmfResponder;
   
   public class CastleServiceManager
   {
      
      private static var _instance:CastleServiceManager;
      
      private var _uid:int;
      
      private var _key:String;
      
      public function CastleServiceManager()
      {
         super();
      }
      
      public static function get instance() : CastleServiceManager
      {
         if(!_instance)
         {
            _instance = new CastleServiceManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _uid = PlayerManager.instance.currentPlayerModel.userInfo.userId;
         _key = PlayerManager.instance.currentPlayerModel.userInfo.key;
      }
      
      public function sendAutoNoticeServer() : AmfResponder
      {
         return sendToServer2("ping",[_key,_uid]);
      }
      
      public function increseResource() : AmfResponder
      {
         return sendToServer2("setCrystalCount",[_key,_uid]);
      }
      
      public function senRename(param1:String) : AmfResponder
      {
         return sendToServer2("newRename",[_key,_uid,param1]);
      }
      
      public function petRename(param1:int, param2:String) : AmfResponder
      {
         return sendToServer2("renamePet",[_key,_uid,param1,param2]);
      }
      
      public function childRename(param1:int, param2:String, param3:int) : AmfResponder
      {
         return sendToServer2("renameChild",[_key,_uid,param1,param2,param3]);
      }
      
      public function sendToServer2(param1:String, param2:Array) : AmfResponder
      {
         return ServicesManager.instance.amfService.callServer(param1,param2);
      }
   }
}

