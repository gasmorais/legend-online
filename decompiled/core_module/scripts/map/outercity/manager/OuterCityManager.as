package map.outercity.manager
{
   import com.road.yishi.proto.archaeology.ArchaeologyNodeMsg;
   import com.road.yishi.proto.archaeology.ArchaeologyOuterMsg;
   import com.road.yishi.proto.army.BossMsg;
   import com.road.yishi.proto.army.BoxMsg;
   import com.road.yishi.proto.army.MapBossMsg;
   import com.road.yishi.proto.army.MapBossQuestMsg;
   import com.road.yishi.proto.army.MapBoxMsg;
   import com.road.yishi.proto.player.PlayerMovieMsg;
   import com.road.yishi.proto.simple.FightOverMoiveMsg;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.internals.data.MapPhysics;
   import map.internals.event.OuterCityEvent;
   import map.outercity.ArchaeologyNodeInfo;
   import map.outercity.BossMsgInfo;
   import map.outercity.BoxMsgInfo;
   import map.outercity.OuterCityActionFactory;
   import map.outercity.OuterCityModel;
   import yishi.actions.map.BattleGetMoviesAction;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.MsgMan;
   
   public class OuterCityManager
   {
      
      private static var _instance:OuterCityManager;
      
      private var _model:OuterCityModel;
      
      private var _controler:*;
      
      private var _mapView:*;
      
      private var coolDownUint:uint;
      
      public function OuterCityManager()
      {
         super();
      }
      
      public static function get instance() : OuterCityManager
      {
         if(!_instance)
         {
            _instance = new OuterCityManager();
         }
         return _instance;
      }
      
      public function get mapView() : *
      {
         return _mapView;
      }
      
      public function set mapView(param1:*) : void
      {
         _mapView = param1;
      }
      
      public function steup(param1:*, param2:*) : void
      {
         _controler = param1;
         _model = param2;
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4382,__playGetMovieHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4938,onGetBossInfo);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4939,onMapBossFog);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4940,onMapBossBox);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 297,__archaeologyNodeListHandler);
         SocketManager.instance.addEventListener("U_PLAY_MOVIE",__playMovieHandler);
         if(coolDownUint == 0)
         {
            coolDownUint = setInterval(coolDownHandler,1000);
         }
      }
      
      private function onGetBossInfo(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:BossMsgInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:MapBossMsg = new MapBossMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as MapBossMsg;
         model.bossInfo.count1 = _loc2_.count1;
         model.bossInfo.count2 = _loc2_.count2;
         model.bossInfo.count3 = _loc2_.count3;
         model.bossInfo.leftBossTime = _loc2_.leftBossTime;
         model.bossInfo.leftFogTime = _loc2_.leftFogTime;
         model.bossInfo.archaeologyKillCount = _loc2_.archaeologyKillCount;
         model.bossInfo.atchaeologyMonsterCount = _loc2_.atchaeologyMonsterCount;
         if(model.bossInfo.leftFogTime > 0)
         {
            NotificationManager.instance.dispatchEvent(new OuterCityEvent("OUTER_CITY_REMOVE_FOG",null));
         }
         model.bossInfo.bosslist = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.bosslist.length)
         {
            _loc3_ = new BossMsgInfo();
            _loc3_.bossName = BossMsg(_loc2_.bosslist[_loc4_]).bossName;
            _loc3_.grade = BossMsg(_loc2_.bosslist[_loc4_]).grade;
            _loc3_.type = BossMsg(_loc2_.bosslist[_loc4_]).type;
            _loc3_.x = BossMsg(_loc2_.bosslist[_loc4_]).x;
            _loc3_.y = BossMsg(_loc2_.bosslist[_loc4_]).y;
            model.bossInfo.bosslist.push(_loc3_);
            _loc4_++;
         }
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("OUTER_CITY_GET_BOSSINFO",null));
      }
      
      private function coolDownHandler() : void
      {
         coolDownBossUpdate();
         coolDownFog();
      }
      
      private function coolDownBossUpdate() : void
      {
         if(model.bossInfo.leftBossTime < 0)
         {
            return;
         }
         if(model.bossInfo.leftBossTime == 0)
         {
            getBossInfo(model.mapId);
         }
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("OUTER_CITY_UPDATE_BOSS_TIME",null));
         model.bossInfo.leftBossTime -= 1;
      }
      
      private function coolDownFog() : void
      {
         if(model.bossInfo.leftFogTime < 0)
         {
            return;
         }
         if(model.bossInfo.leftFogTime == 0)
         {
            NotificationManager.instance.dispatchEvent(new OuterCityEvent("OUTER_CITY_ADD_FOG",null));
         }
         model.bossInfo.leftFogTime -= 1;
      }
      
      private function onMapBossFog(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:MapBossMsg = new MapBossMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as MapBossMsg;
         model.bossInfo.leftFogTime = _loc2_.leftFogTime;
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("OUTER_CITY_REMOVE_FOG",null));
      }
      
      private function onMapBossBox(param1:SLGSocketEvent) : void
      {
         var _loc3_:BoxMsgInfo = null;
         var _loc4_:BoxMsg = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:MapBoxMsg = new MapBoxMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as MapBoxMsg;
         model.bossInfo.bossBoxList = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.boxlist.length)
         {
            _loc4_ = _loc2_.boxlist[_loc5_];
            _loc3_ = new BoxMsgInfo();
            _loc3_.boxId = _loc4_.boxId;
            _loc3_.grade = _loc4_.grade;
            _loc3_.mapId = _loc4_.mapId;
            _loc3_.type = _loc4_.type;
            _loc3_.userId = _loc4_.userId;
            _loc3_.x = _loc4_.x;
            _loc3_.y = _loc4_.y;
            model.bossInfo.bossBoxList.push(_loc3_);
            _loc5_++;
         }
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("OUTER_CITY_UPDATE_BOX",null));
      }
      
      private function __playGetMovieHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"OUTER_CITY_SCENE",playGetMovie);
      }
      
      private function playGetMovie(param1:PackageIn) : void
      {
         var _loc2_:FightOverMoiveMsg = new FightOverMoiveMsg();
         _loc2_ = param1.readBody(_loc2_) as FightOverMoiveMsg;
         GameBaseQueueManager.instance.addAction(new BattleGetMoviesAction(_controler.selfArmy,_loc2_));
         _loc2_ = null;
      }
      
      private function __playMovieHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:Object = null;
         var _loc3_:MapPhysics = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerMovieMsg = new PlayerMovieMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PlayerMovieMsg;
         if(!_model)
         {
            return;
         }
         if(_loc2_.movieTargetType == 0)
         {
            _loc3_ = _model.getMapPhysicsById(_loc2_.targetId);
            if(!_loc3_)
            {
               return;
            }
            _loc4_ = _loc3_.nodeView;
            if(!_loc4_)
            {
               return;
            }
         }
         OuterCityActionFactory.createAction(_loc2_.movieType,_loc4_,_loc5_,75,_loc2_.targetId);
      }
      
      public function getBossInfo(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(9525);
         var _loc2_:MapBossQuestMsg = new MapBossQuestMsg();
         _loc2_.mapId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function getBossBox(param1:BoxMsg) : void
      {
         var _loc3_:PackageOut = new PackageOut(9526);
         var _loc2_:BoxMsg = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      private function __archaeologyNodeListHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ArchaeologyNodeInfo = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArchaeologyOuterMsg = new ArchaeologyOuterMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as ArchaeologyOuterMsg;
         model.archaeologyNodeList = [];
         for each(var _loc3_:ArchaeologyNodeMsg in _loc2_.node)
         {
            _loc4_ = new ArchaeologyNodeInfo();
            _loc4_.nodeId = _loc3_.id;
            _loc4_.x = _loc3_.x;
            _loc4_.y = _loc3_.y;
            model.archaeologyNodeList.push(_loc4_);
         }
         MsgMan.notifyObserver("ARCHAEOLOGY_NODE_LIST");
      }
      
      public function get model() : OuterCityModel
      {
         return _model;
      }
      
      public function get controler() : *
      {
         return _controler;
      }
      
      public function dispose() : void
      {
         _controler = null;
         _model = null;
         _mapView = null;
         clearInterval(coolDownUint);
         coolDownUint = 0;
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4382,__playGetMovieHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4938,onGetBossInfo);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4939,onMapBossFog);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4940,onMapBossBox);
         SocketManager.instance.removeEventListener("U_PLAY_MOVIE",__playMovieHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 297,__archaeologyNodeListHandler);
      }
   }
}

