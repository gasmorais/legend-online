package proxy
{
   import com.pickgliss.loader.DisplayLoader;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import proxy.data.SocketDataProxyInfo;
   import proxy.data.SocketDataProxyModel;
   import proxy.scene.BaseSceneSocketDataProxy;
   import proxy.scene.CampaignSocketDataProxy;
   import proxy.scene.SpaceSocketDataProxy;
   import proxy.scene.VehicleSocketDataProxy;
   import yishi.comm.PackageIn;
   import yishi.scene.SceneCreate;
   
   public class SocketDataProxyManager extends EventDispatcher
   {
      
      private static var _instance:SocketDataProxyManager;
      
      private var _model:SocketDataProxyModel;
      
      private var _sceneList:Dictionary;
      
      public function SocketDataProxyManager()
      {
         super();
         _model = new SocketDataProxyModel();
         _sceneList = new Dictionary(true);
      }
      
      public static function get instance() : SocketDataProxyManager
      {
         if(!_instance)
         {
            _instance = new SocketDataProxyManager();
         }
         return _instance;
      }
      
      public function addCreateSceneQueue(param1:PackageIn, param2:String, param3:String, param4:Boolean = true) : void
      {
         chekckVehicle(param1,param2,param3,param4);
      }
      
      public function readSocketDataByType(param1:String) : void
      {
         var _loc2_:BaseSceneSocketDataProxy = _sceneList[param1] as BaseSceneSocketDataProxy;
         if(_loc2_)
         {
            _model.readSceneSocketData(param1);
            _loc2_.dispose();
         }
         delete _sceneList[param1];
         _loc2_ = null;
      }
      
      private function chekckVehicle(param1:PackageIn, param2:String, param3:String, param4:Boolean) : void
      {
         var _loc7_:BaseSceneSocketDataProxy = null;
         var _loc5_:String = SceneCreate.getClassByType(param2);
         var _loc6_:Boolean = false;
         if(DisplayLoader.Context.applicationDomain.hasDefinition(_loc5_))
         {
            _loc6_ = true;
         }
         if(param1.code == 125 || param1.code == 4595)
         {
            _loc7_ = _sceneList[param2] as BaseSceneSocketDataProxy;
            if(_loc7_)
            {
               _loc7_.dispose();
            }
            _model.clearSceneSocketData(param2);
            delete _sceneList[param2];
            if(param4)
            {
               _model.addSocketData(new SocketDataProxyInfo(param1,param3),param2);
            }
            if(_loc6_)
            {
               if(param2 == "VEHICLE")
               {
                  getManagerInstance(param2).instance["setup"](false,param1);
               }
               else if(param2 == "CAMPAIGN_MAP_SCENE")
               {
                  getManagerInstance(param2).instance["setup"]();
               }
               else if(param2 == "SPACE_SCENE")
               {
                  getManagerInstance(param2).instance["setup"]();
               }
            }
            else if(param2 == "VEHICLE")
            {
               _sceneList[param2] = new VehicleSocketDataProxy(_model);
            }
            else if(param2 == "CAMPAIGN_MAP_SCENE")
            {
               _sceneList[param2] = new CampaignSocketDataProxy(_model);
            }
            else if(param2 == "SPACE_SCENE")
            {
               _sceneList[param2] = new SpaceSocketDataProxy(_model);
            }
         }
      }
      
      private function getManagerClassByType(param1:String) : String
      {
         switch(param1)
         {
            case "VEHICLE":
               return "com.map.vehicle.net.VehicleSocketManager";
            case "CAMPAIGN_MAP_SCENE":
               return "map.campaign.CampaignSocketManger";
            case "SPACE_SCENE":
               return "map.space.manager.SpaceSocketManager";
            default:
               return "";
         }
      }
      
      private function getManagerInstance(param1:String) : *
      {
         return DisplayLoader.Context.applicationDomain.getDefinition(getManagerClassByType(param1));
      }
      
      public function get model() : SocketDataProxyModel
      {
         return _model;
      }
   }
}

