package yishi.manager
{
   import com.road.yishi.proto.player.AppellExchangeMsg;
   import com.road.yishi.proto.player.AppellInfoMsg;
   import com.road.yishi.proto.player.AppellsMsg;
   import flash.events.EventDispatcher;
   import mainBar.view.AppellGetView;
   import mvc.module.appell.AppellModel;
   import yishi.comm.PackageIn;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.AppellInfoTemplate;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleDictionary;
   
   public class AppellManager extends EventDispatcher
   {
      
      private static var _instance:AppellManager;
      
      private var _delayPkg:PackageIn;
      
      public function AppellManager()
      {
         super();
      }
      
      public static function get instance() : AppellManager
      {
         if(!_instance)
         {
            _instance = new AppellManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4484,__updateAppellDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4491,__getAppellHandler);
         NotificationManager.instance.addEventListener("APPELL",__appellSwitchChange);
      }
      
      private function __updateAppellDataHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:AppellInfoTemplate = null;
         var _loc5_:int = 0;
         var _loc3_:AppellInfoMsg = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:AppellsMsg = new AppellsMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as AppellsMsg;
         var _loc6_:Array = _loc2_.appells;
         if(model.infos == null)
         {
            model.infos = TempleteManager.instance.appellInfoTemplateCate.getTemplates();
         }
         var _loc8_:SimpleDictionary = new SimpleDictionary();
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc3_ = _loc6_[_loc5_] as AppellInfoMsg;
            if(model.infos.hasOwnProperty(_loc3_.appellId))
            {
               _loc4_ = model.infos[_loc3_.appellId];
               if(_loc3_.hasValidDate)
               {
                  _loc4_.validDate = _loc3_.validDate;
               }
               _loc4_.isGet = _loc3_.isGet;
               _loc4_.progress = _loc3_.value;
               if(_loc4_.Quality == 2)
               {
                  _loc4_.Quality = 3;
               }
               if(!(_loc4_.Job != thane.templateInfo.Job && _loc4_.Job != 0))
               {
                  _loc8_.add(_loc4_.TemplateId,_loc4_);
               }
            }
            _loc5_++;
         }
         model.appells = _loc8_;
      }
      
      private function __getAppellHandler(param1:SLGSocketEvent) : void
      {
         _delayPkg = param1.data as PackageIn;
         __switchSceneHandler(null);
      }
      
      private function __switchSceneHandler(param1:NotificationEvent) : void
      {
         NotificationManager.instance.removeEventListener("SWITCH_SCENE",__switchSceneHandler);
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            NotificationManager.instance.addEventListener("SWITCH_SCENE",__switchSceneHandler);
         }
         else
         {
            getAppellTip(_delayPkg);
         }
      }
      
      private function getAppellTip(param1:PackageIn) : void
      {
         var _loc2_:AppellExchangeMsg = new AppellExchangeMsg();
         _loc2_ = param1.readBody(_loc2_) as AppellExchangeMsg;
         var _loc3_:AppellInfoTemplate = TempleteManager.instance.appellInfoTemplateCate.getTemplateByID(_loc2_.appellId);
         if(_loc3_.Notice)
         {
            CheckUIModuleUtil.instance.tryCall("appell",showAppellGetView);
            NotificationManager.instance.sendNotification("APPELL_GET");
         }
      }
      
      private function showAppellGetView() : void
      {
         var _loc1_:AppellGetView = new AppellGetView();
         _loc1_.show();
      }
      
      private function __appellSwitchChange(param1:NotificationEvent) : void
      {
         if(!VersionSwitch.APPELL)
         {
            thane.appellId = 0;
            thane.commit();
         }
      }
      
      public function get model() : AppellModel
      {
         return FrameControllerManager.instance.appellControler.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.army.baseHero;
      }
   }
}

