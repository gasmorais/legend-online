package yishi.service.managers
{
   import yishi.manager.PlayerManager;
   import yishi.service.services.AmfResponder;
   
   public class OuterCityServiceManager
   {
      
      private static var _instance:OuterCityServiceManager;
      
      private var _uid:int;
      
      private var _key:String;
      
      private var _mapId:int;
      
      private var _pass:String;
      
      public function OuterCityServiceManager()
      {
         super();
      }
      
      public static function getInstance() : OuterCityServiceManager
      {
         if(!_instance)
         {
            _instance = new OuterCityServiceManager();
         }
         return _instance;
      }
      
      public function setup(param1:int, param2:String, param3:int) : void
      {
         _pass = param2;
         _mapId = param3;
         _uid = param1;
         _key = PlayerManager.instance.currentPlayerModel.userInfo.key;
      }
      
      public function sendToServer2(param1:String, param2:Array) : AmfResponder
      {
         return ServicesManager.instance.amfService.callServer(param1,param2);
      }
      
      public function requestOuterCityCastles(param1:String) : AmfResponder
      {
         return sendToServer2("getCastleByPos",[_key,_uid,_mapId,param1]);
      }
      
      public function getWildLandSysArmy(param1:String) : AmfResponder
      {
         return sendToServer2("getWildLandSysArmy",[_mapId,param1]);
      }
      
      public function getWildLandByGrids(param1:String) : AmfResponder
      {
         return sendToServer2("getWildLandByGrids",[_mapId,param1]);
      }
   }
}

