package map.outercity.view.archaeology
{
   import com.pickgliss.toplevel.StageReferance;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import map.internals.event.OuterCityEvent;
   import map.outercity.ArchaeologyNodeInfo;
   import map.outercity.OuterCityModel;
   import map.outercity.helper.mapview.OutercityArchaeologyHelper;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.mapphysics.ArmyView;
   import mvc.module.archeology.ArchaeologyModel;
   import mvc.module.armyII.BaseArmy;
   import yishi.actions.map.collection.CollectionAction;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   
   public class AutoArchaeologyOpera
   {
      
      private var configTemp:ConfigInfosTempInfo;
      
      private var _timer:Timer;
      
      public function AutoArchaeologyOpera()
      {
         super();
         configTemp = TempleteManager.instance.getConfigInfoByConfigName("archaeology_max_count");
         NotificationManager.instance.addEventListener("CLICK_MAP",__mouseDownHandler);
         _timer = new Timer(2000);
         _timer.addEventListener("timer",onTimer);
         _timer.stop();
      }
      
      public function start() : void
      {
         if(!_timer)
         {
            _timer = new Timer(2000);
            _timer.addEventListener("timer",onTimer);
         }
         _timer.start();
      }
      
      public function stop() : void
      {
         _timer.stop();
      }
      
      public function onTimer(param1:TimerEvent = null) : void
      {
         var _loc2_:ArchaeologyNodeInfo = null;
         var _loc4_:int = 0;
         var _loc6_:Point = null;
         var _loc3_:int = int(archaeologyModel.hasExplorationCount);
         var _loc5_:int = archaeologyModel.hasBuyExplorCount + parseInt(configTemp.ConfigValue);
         var _loc7_:int = _loc5_ - _loc3_;
         if(_loc7_ <= 0)
         {
            dispose();
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            ArchaeologyManager.instance.sendArchaeologyRequest(5);
            if(outerCityModel.archaeologyNodeList.length <= 0)
            {
               return;
            }
            _loc4_ = OutercityArchaeologyHelper.getLightState(armyViewPos,outerCityModel.archaeologyNodeList);
            if(_loc4_ == 1)
            {
               if(GameBaseQueueManager.instance.isPlaying())
               {
                  return;
               }
               _loc2_ = OutercityArchaeologyHelper.getNearestNode(armyViewPos,outerCityModel.archaeologyNodeList);
               if(_loc2_)
               {
                  GameBaseQueueManager.instance.addAction(new CollectionAction(null,_loc2_.nodeId));
               }
            }
            _loc2_ = OutercityArchaeologyHelper.getNearestNode(armyViewPos,outerCityModel.archaeologyNodeList);
            if(_loc2_)
            {
               _loc6_ = new Point();
               _loc6_.x = armyViewPos.x - StageReferance.stageWidth / 2;
               _loc6_.y = armyViewPos.y - StageReferance.stageHeight / 2;
               NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",new Point(_loc2_.x * 20,_loc2_.y * 20)));
               OuterCityManager.instance.mapView.motionTo(_loc6_);
               OuterCityManager.instance.mapView.worldWalkLayer.outSceneMovies();
            }
            else
            {
               dispose();
            }
         }
         else
         {
            dispose();
         }
      }
      
      private function get armyViewPos() : Point
      {
         var _loc2_:Point = null;
         var _loc3_:BaseArmy = null;
         var _loc1_:ArmyView = OuterCityManager.instance.controler.selfAvatarView;
         if(_loc1_)
         {
            _loc2_ = new Point(_loc1_.x,_loc1_.y);
         }
         else
         {
            _loc3_ = outerCityModel.getWorldArmyByUserId(playerInfo.userId);
            if(_loc3_)
            {
               _loc2_ = new Point(_loc3_.curPosX * 20,_loc3_.curPosY * 20);
            }
         }
         return _loc2_;
      }
      
      private function __mouseDownHandler(param1:NotificationEvent) : void
      {
         stop();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get outerCityModel() : OuterCityModel
      {
         return OuterCityManager.instance.model;
      }
      
      private function get archaeologyModel() : ArchaeologyModel
      {
         return ArchaeologyManager.instance.model;
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onTimer);
            _timer = null;
         }
         NotificationManager.instance.removeEventListener("CLICK_MAP",__mouseDownHandler);
      }
   }
}

