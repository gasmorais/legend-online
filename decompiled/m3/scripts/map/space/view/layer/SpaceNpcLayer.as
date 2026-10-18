package map.space.view.layer
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.PhysicInfo;
   import map.internals.data.SpaceNode;
   import map.space.SpaceManager;
   import map.space.SpaceModel;
   import map.space.SpaceSceneController;
   import map.space.view.physics.MarryCarView;
   import map.space.view.physics.SpaceArmyView;
   import map.space.view.physics.SpaceNpcView;
   import marry.view.MarryFlowerView;
   import mvc.module.marry.MarryCarInfo;
   import mvc.module.marry.MarryModel;
   import yishi.datas.ai.NpcAiInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.NotificationEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.BaseManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   
   public class SpaceNpcLayer implements IEnterFrame
   {
      
      public static const NAME:String = "map.space.view.layer.SpaceNpcLayer";
      
      private var _mediatorKey:String;
      
      private var _container:Sprite;
      
      private var _avatarList:Array = [];
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var _controlder:SpaceSceneController;
      
      private var _carDic:Dictionary;
      
      public function SpaceNpcLayer(param1:Sprite)
      {
         super();
         _container = param1;
         _controlder = SpaceManager.instance.controller;
         init(model.mapNodesData);
         initMarryCar();
         addEvent();
         initRegister();
      }
      
      private function initMarryCar() : void
      {
         marryModel.curCarShowNum = 0;
         _carDic = new Dictionary();
         addMarryCar();
      }
      
      private function addMarryCar() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<MarryCarInfo> = marryModel.carList;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            if(!_loc1_[_loc2_].isExist)
            {
               if(_carDic[_loc1_[_loc2_]])
               {
                  setArmyViewState(_loc1_[_loc2_]);
                  _carDic[_loc1_[_loc2_]].dispose();
                  delete _carDic[_loc1_[_loc2_]];
                  _loc1_.splice(_loc2_,1);
                  marryModel.curCarShowNum -= 1;
               }
            }
            else
            {
               if(!(marryModel.curCarShowNum < 2 || _loc1_[_loc2_].userIdA == playerInfo.userId || _loc1_[_loc2_].userIdB == playerInfo.userId))
               {
                  break;
               }
               setArmyViewState(_loc1_[_loc2_]);
               createMarryCar(_loc1_[_loc2_]);
            }
            _loc2_++;
         }
      }
      
      private function createMarryCar(param1:MarryCarInfo) : void
      {
         var _loc5_:PhysicInfo = null;
         var _loc2_:SpaceNode = null;
         var _loc4_:NpcAiInfo = null;
         var _loc3_:MarryCarView = null;
         if(!param1)
         {
            return;
         }
         if(!_carDic[param1])
         {
            _loc5_ = new PhysicInfo();
            _loc5_.types = 9999;
            _loc5_.names = LanguageMgr.GetTranslation("map.space.view.layer.MarryCarName",param1.nickNameA,param1.nickNameB);
            _loc5_.posX = 18;
            _loc5_.posY = 17;
            _loc2_ = new SpaceNode();
            _loc2_.resource = 1;
            _loc2_.patrolPos = param1.property4;
            _loc2_.sonType = 10101;
            _loc2_.nameColor = 1;
            _loc2_.toward = 1;
            _loc2_.sizeType = 9;
            _loc2_.curPosX = param1.firstX / 20;
            _loc2_.curPosY = param1.firstY / 20;
            _loc2_.fixX = param1.firstX;
            _loc2_.fixY = param1.firstY;
            _loc2_.info = _loc5_;
            _loc4_ = new NpcAiInfo();
            _loc4_.isLiving = true;
            _loc4_.moveState = 5;
            _loc4_.centerPoint = new Point(370,339);
            _loc3_ = new MarryCarView();
            _loc3_.filter = _filter;
            _loc3_.x = param1.firstX;
            _loc3_.y = param1.firstY;
            _loc3_.carInfo = param1;
            _loc3_.info = _loc4_;
            _loc3_.nodeInfo = _loc2_;
            _loc2_.nodeView = _loc3_;
            _carDic[param1] = _loc3_;
            _container.addChild(_loc3_);
            marryModel.curCarShowNum += 1;
            if(param1.userIdA == playerInfo.userId || param1.userIdB == playerInfo.userId)
            {
               marryModel.lockScreen = true;
               if(SpaceManager.instance.mapView)
               {
                  SpaceManager.instance.mapView.dispatchEvent(new CampaignMapEvent("LOOK_AT_ROLE",_loc3_));
               }
               CheckUIModuleUtil.instance.tryCall("wedding",showWeddingFlowerView);
            }
         }
      }
      
      private function setArmyViewState(param1:MarryCarInfo) : void
      {
         var _loc3_:SpaceWalkLayer = SpaceManager.instance.mapView.walkLayer as SpaceWalkLayer;
         if(_loc3_)
         {
            for each(var _loc2_:SpaceArmyView in _loc3_.armys)
            {
               if(_loc2_.data.userId == param1.userIdA || _loc2_.data.userId == param1.userIdB)
               {
                  _loc2_.x = param1.firstX;
                  _loc2_.y = param1.firstY;
                  _loc2_.info.pathInfo = param1.isExist ? [new Point(param1.firstX / 20,param1.firstY / 20)].concat(param1.pathInfo) : [];
                  _loc2_.visible = !param1.isExist;
                  if(_loc2_.data.userId == playerInfo.userId && !param1.isExist)
                  {
                     if(SpaceManager.instance.mapView)
                     {
                        SpaceManager.instance.mapView.dispatchEvent(new CampaignMapEvent("LOOK_AT_ROLE",_loc2_));
                     }
                  }
               }
            }
         }
      }
      
      private function showWeddingFlowerView() : void
      {
         var _loc1_:MarryFlowerView = new MarryFlowerView();
         _loc1_.show();
      }
      
      private function init(param1:Array) : void
      {
         var _loc2_:SpaceNpcView = null;
         var _loc4_:NpcAiInfo = null;
         for each(var _loc3_:SpaceNode in param1)
         {
            if(checkIsNeedInit(_loc3_))
            {
               _loc2_ = new SpaceNpcView("","",0,0);
               _loc2_.filter = _filter;
               _loc2_.x = _loc3_.curPosX * 20;
               _loc2_.y = _loc3_.curPosY * 20;
               _loc4_ = new NpcAiInfo();
               _loc4_.isLiving = true;
               _loc4_.moveState = 3;
               _loc4_.centerPoint = new Point(_loc3_.x,_loc3_.y);
               if(_loc3_.info.types == 1 && _loc3_.patrolPos)
               {
                  initPathInfo(_loc3_,_loc2_,_loc4_);
               }
               _loc2_.info = _loc4_;
               _loc3_.nodeView = _loc2_;
               _avatarList.push(_loc2_);
               _controlder.addNpcView(_loc2_);
               _loc2_.nodeInfo = _loc3_;
               _container.addChild(_loc2_);
               _loc2_.visible = true;
            }
         }
         __refreshNpcVisibleHandler(null);
      }
      
      private function checkIsNeedInit(param1:SpaceNode) : Boolean
      {
         if(param1.resource != 1)
         {
            return false;
         }
         if(param1.info.types == 40)
         {
            return false;
         }
         if(param1.info.types == 191)
         {
            return false;
         }
         return true;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function initPathInfo(param1:SpaceNode, param2:SpaceNpcView, param3:NpcAiInfo) : void
      {
         var _loc4_:Array = null;
         var _loc7_:Point = null;
         var _loc5_:int = 0;
         param2.pathCache = [];
         param3.pathInfo = [];
         var _loc6_:Array = param1.patrolPos.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc4_ = _loc6_[_loc5_].split(",");
            _loc7_ = new Point();
            _loc7_.x = _loc4_[0];
            _loc7_.y = _loc4_[1];
            param2.pathCache.push(_loc7_);
            param3.pathInfo.push(_loc7_);
            _loc5_++;
         }
      }
      
      private function initRegister() : void
      {
         var _loc1_:Array = [];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,_container,"map.space.view.layer.SpaceNpcLayer");
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         MsgMan.addObserver("MarryEventType.CAR_INFO",this,__marryCarInfoHandler);
         MsgMan.addObserver("MarryEventType.CAR_WALK_OVER",this,__marryCarOverHandler);
         NotificationManager.instance.addEventListener("SPACE_NPC_VISIBLE",__refreshNpcVisibleHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         MsgMan.removeObserver("MarryEventType.CAR_INFO",this,__marryCarInfoHandler);
         MsgMan.removeObserver("MarryEventType.CAR_WALK_OVER",this,__marryCarOverHandler);
         NotificationManager.instance.removeEventListener("SPACE_NPC_VISIBLE",__refreshNpcVisibleHandler);
      }
      
      private function __refreshNpcVisibleHandler(param1:NotificationEvent = null) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:SpaceNode = null;
         var _loc2_:SpaceNpcView = null;
         var _loc7_:Array = BaseManager.instance.checkIsNeedShow();
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc6_ = int((_loc7_[_loc5_] as Array)[0]);
            _loc3_ = Boolean((_loc7_[_loc5_] as Array)[1]);
            _loc4_ = model.getMapNodeById(_loc6_);
            if(_loc4_)
            {
               _loc2_ = _controlder.getNpcView(_loc4_) as SpaceNpcView;
               if(_loc2_)
               {
                  _loc2_.visible = _loc3_;
               }
            }
            _loc5_++;
         }
      }
      
      private function __marryCarInfoHandler(param1:String, param2:Object) : void
      {
         addMarryCar();
      }
      
      private function __marryCarOverHandler(param1:String, param2:Object) : void
      {
         addMarryCar();
      }
      
      public function enterFrame() : void
      {
         for each(var _loc1_:SpaceNpcView in _avatarList)
         {
            _loc1_.execute();
         }
         for each(var _loc2_:MarryCarView in _carDic)
         {
            _loc2_.execute();
         }
      }
      
      public function seltCar() : MarryCarView
      {
         for each(var _loc1_:MarryCarView in _carDic)
         {
            if(_loc1_.carInfo.userIdA == playerInfo.userId || _loc1_.carInfo.userIdB == playerInfo.userId)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function onClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:SpaceNpcView = param1.target as SpaceNpcView;
         if(_loc2_)
         {
            if(_loc2_.mouseClickHandler(param1))
            {
               return true;
            }
         }
         for each(_loc2_ in _avatarList)
         {
            if(_loc2_.mouseClickHandler(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:SpaceNpcView = param1.target as SpaceNpcView;
         if(_loc2_)
         {
            if(_loc2_.mouseMoveHandler(param1))
            {
               return true;
            }
         }
         for each(_loc2_ in _avatarList)
         {
            if(_loc2_.mouseMoveHandler(param1))
            {
               return true;
            }
         }
         var _loc3_:SpaceArmyView = param1.target as SpaceArmyView;
         if(_loc3_)
         {
            if(_loc3_.mouseMoveHandler(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function get avatarList() : Array
      {
         return _avatarList;
      }
      
      private function get model() : SpaceModel
      {
         return SpaceManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      public function dispose() : void
      {
         var _loc1_:SpaceNpcView = null;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,_container);
         removeEvent();
         while(_avatarList.length > 0)
         {
            _loc1_ = _avatarList.pop();
            _loc1_.dispose();
         }
         _avatarList = null;
         _filter = null;
      }
   }
}

