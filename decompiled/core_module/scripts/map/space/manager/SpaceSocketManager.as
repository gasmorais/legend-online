package map.space.manager
{
   import chat.datas.ChatData;
   import com.road.yishi.proto.army.HeroEquUpdatedMsg;
   import com.road.yishi.proto.campaign.CampaignExitMsg;
   import com.road.yishi.proto.campaign.SpacePlayerMoveMsg;
   import com.road.yishi.proto.campaign.StandPosMsg;
   import com.road.yishi.proto.player.PlayerMovieMsg;
   import com.road.yishi.proto.room.RoomEnterMsg;
   import com.road.yishi.proto.room.RoomPlayerMsg;
   import com.road.yishi.proto.simple.PropertyMsg;
   import flash.events.EventDispatcher;
   import map.internals.data.SpaceNode;
   import map.space.SpaceActionsFactory;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.event.SpaceEvent;
   import mvc.module.armyII.BaseArmy;
   import proxy.SocketDataProxyEventEvent;
   import proxy.SocketDataProxyManager;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SocketSceneBufferManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   
   public class SpaceSocketManager
   {
      
      private static var _instance:SpaceSocketManager;
      
      private var _isUse:Boolean = false;
      
      public function SpaceSocketManager()
      {
         super();
      }
      
      public static function get instance() : SpaceSocketManager
      {
         if(!_instance)
         {
            _instance = new SpaceSocketManager();
         }
         return _instance;
      }
      
      public function setup(param1:Boolean = false) : void
      {
         if(_isUse)
         {
            return;
         }
         _isUse = true;
         if(param1)
         {
            removeSocketEvent(SocketManager.instance);
            addSocketEvent(SocketDataProxyManager.instance.model);
            SocketDataProxyManager.instance.model.addEventListener("READ_SOCKET_DATA_OVEW",__readOverHandler);
            SocketDataProxyManager.instance.readSocketDataByType("SPACE_SCENE");
         }
         else
         {
            addSocketEvent(SocketManager.instance);
            removeSocketEvent(SocketDataProxyManager.instance.model);
         }
         addEvent();
      }
      
      private function __readOverHandler(param1:SocketDataProxyEventEvent) : void
      {
         if(param1.sceneType != "SPACE_SCENE")
         {
            return;
         }
         addSocketEvent(SocketManager.instance);
         removeSocketEvent(SocketDataProxyManager.instance.model);
         SocketDataProxyManager.instance.model.removeEventListener("READ_SOCKET_DATA_OVEW",__readOverHandler);
      }
      
      private function addSocketEvent(param1:EventDispatcher) : void
      {
         param1.addEventListener("SLGSocketEvent" + 4592,__spaceEnterHandler);
         param1.addEventListener("SLGSocketEvent" + 4593,__spaceLeaveHandler);
         param1.addEventListener("SLGSocketEvent" + 4594,__spaceMoveHandler);
         param1.addEventListener("SLGSocketEvent" + 149,__otherHeroInfoChange);
         param1.addEventListener("SLGSocketEvent" + 4601,__spaceEventHandler);
         param1.addEventListener("U_PLAY_MOVIE",__playMovieHandler);
         param1.addEventListener("SLGSocketEvent" + 4126,__standPosHandler);
      }
      
      private function removeSocketEvent(param1:EventDispatcher) : void
      {
         param1.removeEventListener("SLGSocketEvent" + 4592,__spaceEnterHandler);
         param1.removeEventListener("SLGSocketEvent" + 4593,__spaceLeaveHandler);
         param1.removeEventListener("SLGSocketEvent" + 4594,__spaceMoveHandler);
         param1.removeEventListener("SLGSocketEvent" + 149,__otherHeroInfoChange);
         param1.removeEventListener("SLGSocketEvent" + 4601,__spaceEventHandler);
         param1.removeEventListener("U_PLAY_MOVIE",__playMovieHandler);
         param1.removeEventListener("SLGSocketEvent" + 4126,__standPosHandler);
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("UPDATE_CHAT_VIEW",__playerChatHandler);
      }
      
      private function __playerChatHandler(param1:NotificationEvent) : void
      {
         if(SceneManager.instance.currentType != "SPACE_SCENE")
         {
            return;
         }
         var _loc3_:ChatData = param1.data as ChatData;
         if(!SpaceManager.instance.model || !_loc3_)
         {
            return;
         }
         if(_loc3_.channel != 6 && _loc3_.channel != 8)
         {
            return;
         }
         var _loc2_:SpaceArmy = SpaceManager.instance.model.getUserArmyByUserId(_loc3_.uid);
         if(_loc2_)
         {
            _loc2_.chatData = _loc3_;
         }
      }
      
      private function __spaceEnterHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:RoomEnterMsg = new RoomEnterMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as RoomEnterMsg;
         for each(_loc4_ in _loc2_.player)
         {
            SpaceManager.instance.readMember(_loc4_);
         }
      }
      
      private function __spaceLeaveHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:SpaceArmy = null;
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:CampaignExitMsg = new CampaignExitMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as CampaignExitMsg;
         if(_loc2_.playerId != selfPlayerInfo.userId && SpaceManager.instance.model)
         {
            _loc3_ = SpaceManager.instance.model.removeUserArmyByArmyId(_loc2_.playerId);
         }
      }
      
      public function get selfPlayerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __spaceMoveHandler(param1:SLGSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.data as PackageIn;
         SocketSceneBufferManager.instance.addPkgToBuffer(_loc2_,"SPACE_SCENE",__spaceSyncPosHandler);
      }
      
      private function __spaceSyncPosHandler(param1:PackageIn) : void
      {
         if(SceneManager.instance.currentType != "SPACE_SCENE")
         {
            return;
         }
         var _loc2_:SpacePlayerMoveMsg = new SpacePlayerMoveMsg();
         _loc2_ = param1.readBody(_loc2_) as SpacePlayerMoveMsg;
         SpaceManager.instance.model.moveArmyTo(_loc2_);
      }
      
      private function __otherHeroInfoChange(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:HeroEquUpdatedMsg = new HeroEquUpdatedMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as HeroEquUpdatedMsg;
         var _loc5_:int = _loc2_.playerId;
         var _loc3_:SpaceArmy = SpaceManager.instance.model.getUserArmyByUserId(_loc5_);
         if(_loc3_ && _loc3_.baseHero)
         {
            _loc3_.baseHero.beginChanges();
            _loc3_.baseHero.armsEquipAvata = _loc2_.armStr;
            _loc3_.baseHero.bodyEquipAvata = _loc2_.clothStr;
            _loc3_.baseHero.wingAvata = _loc2_.wing;
            _loc3_.baseHero.hairFashionAvata = _loc2_.hat;
            _loc3_.baseHero.armsFashionAvata = _loc2_.fashionArm;
            _loc3_.baseHero.bodyFashionAvata = _loc2_.fashionCloth;
            _loc3_.baseHero.hideFashion = _loc2_.hide;
            _loc3_.baseHero.appellId = _loc2_.appellId;
            _loc3_.baseHero.vocationGrades = _loc2_.transGrade;
            _loc3_.baseHero.vocationIndex = _loc2_.changeBranch;
            _loc3_.baseHero.commit();
         }
      }
      
      private function __spaceEventHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PropertyMsg = new PropertyMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PropertyMsg;
         NotificationManager.instance.dispatchEvent(new SpaceEvent("SELECT_NODE",_loc2_.param1));
      }
      
      private function __playMovieHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:Object = null;
         var _loc3_:SpaceNode = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerMovieMsg = new PlayerMovieMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as PlayerMovieMsg;
         if(!SpaceManager.instance.model)
         {
            return;
         }
         if(_loc2_.movieTargetType == 0)
         {
            _loc3_ = SpaceManager.instance.model.getMapNodeById(_loc2_.targetId);
            if(!_loc3_)
            {
               return;
            }
            _loc4_ = SpaceManager.instance.controller.getBuildView(_loc3_);
         }
         SpaceActionsFactory.createAction(_loc2_.movieType,_loc4_,_loc5_,75,_loc2_.targetId);
      }
      
      private function __standPosHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:Object = null;
         if(SceneManager.instance.currentType != "SPACE_SCENE")
         {
            return;
         }
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:StandPosMsg = new StandPosMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as StandPosMsg;
         if(!SpaceManager.instance.model)
         {
            return;
         }
         var _loc3_:SpaceArmy = SpaceManager.instance.model.getUserArmyByUserId(_loc2_.id);
         if(!_loc3_)
         {
            return;
         }
         _loc3_.curPosX = _loc2_.posX;
         _loc3_.curPosY = _loc2_.posY;
         var _loc6_:BaseArmy = ArmyManager.instance.army;
         if(_loc6_.id == _loc3_.id)
         {
            _loc6_.curPosX = _loc2_.posX;
            _loc6_.curPosY = _loc2_.posY;
         }
         if(SpaceManager.instance.controller)
         {
            _loc4_ = SpaceManager.instance.controller.getArmyView(_loc3_);
            if(_loc4_)
            {
               _loc4_.x = _loc2_.posX * 20;
               _loc4_.y = _loc2_.posY * 20;
               _loc4_.info.pathInfo = [];
            }
         }
      }
      
      public function dispose() : void
      {
         if(!_isUse)
         {
            return;
         }
         _isUse = false;
         removeSocketEvent(SocketDataProxyManager.instance.model);
         removeSocketEvent(SocketManager.instance);
         removeEvent();
      }
   }
}

