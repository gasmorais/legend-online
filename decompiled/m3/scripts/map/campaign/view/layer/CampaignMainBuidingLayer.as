package map.campaign.view.layer
{
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import managers.MonopolyManager;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.physics.CampaignNpcPhysics;
   import map.campaign.view.physics.MonopolyEventView;
   import map.campaign.view.physics.UnrealShootingNpcPhysics;
   import map.campaign.view.physics.physicsview.AirGardenCampaignShowAvatarView;
   import map.internals.data.CampaignNode;
   import map.internals.data.PhysicInfo;
   import map.internals.event.OuterCityEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.view.physics.MapPhysicsBase;
   import map.internals.view.physics.PhysicsChestView;
   import map.internals.view.physics.PhysicsStaticView;
   import mvc.module.airgarden.AirGardenCampaignBedInfo;
   import mvc.module.airgarden.AirGardenModel;
   import mvc.module.monopoly.MonopolyNodeInfo;
   import utils.LogicUtils;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.MediatorMananger;
   import yishi.manager.TaskManage;
   import yishi.scene.BaseSceneView;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MultipleDictionaryInfo;
   
   public class CampaignMainBuidingLayer extends Sprite
   {
      
      public static const NAME:String = "map.campaign.view.layer.CampaignMainBuidingLayer";
      
      private var _items:Dictionary;
      
      private var _buttomLayer:Sprite;
      
      private var _centerLayer:Sprite;
      
      private var _airGardenLayer:Sprite;
      
      private var _topLayer:Sprite;
      
      private var _scene:BaseSceneView;
      
      private var _mediatorKey:String;
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var _model:CampaignMapModel = CampaignManager.instance.mapModel;
      
      private var airGardenAvatarDic:Dictionary = new Dictionary(true);
      
      public function CampaignMainBuidingLayer()
      {
         super();
         _buttomLayer = new Sprite();
         _centerLayer = new Sprite();
         _airGardenLayer = new Sprite();
         _topLayer = new Sprite();
         addChild(_buttomLayer);
         addChild(_centerLayer);
         addChild(_airGardenLayer);
         addChild(_topLayer);
         _centerLayer.mouseEnabled = false;
         _topLayer.mouseChildren = _topLayer.mouseEnabled = false;
         _buttomLayer.mouseChildren = _buttomLayer.mouseEnabled = false;
         _airGardenLayer.mouseChildren = _airGardenLayer.mouseEnabled = false;
         _items = new Dictionary(true);
         init();
         addDataEvent();
      }
      
      private function init() : void
      {
         initNpcView(_model.mapNodesData);
      }
      
      private function initRegister() : void
      {
         var _loc1_:Array = [];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.campaign.view.layer.CampaignMainBuidingLayer");
      }
      
      private function addDataEvent() : void
      {
         _model.addEventListener("currentNpcPos",__curNpcHandler);
         _model.addEventListener("currentConfigChange",__moviesHandler);
         this.addEventListener("addedToStage",__addToStageHandler);
         if(TaskManage.instance.cate)
         {
            TaskManage.instance.cate.addEventListener("task_added",refreshNode);
            TaskManage.instance.cate.addEventListener("task_remove",refreshNode);
         }
         RingTaskManager.instance.addEventListener("REFRESHTING",refreshNode);
         OfferRewardManager.instance.addEventListener("REWARD_TASK_UPDATE",refreshNode);
         MsgMan.addObserver("CAMPAIGN_DETAIL_UPDATE",this,__updateAirGardenShowAvatarHandler);
      }
      
      public function onClickHandler(param1:MouseEvent) : Boolean
      {
         if(param1.target is CampaignArmyView)
         {
            return false;
         }
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            return _loc2_.mouseClickHandler(param1);
         }
         return false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            return _loc2_.mouseOverHandler(param1);
         }
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            return _loc2_.mouseOutHandler(param1);
         }
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:CampaignNpcPhysics = param1.target as CampaignNpcPhysics;
         return _loc2_ ? true : false;
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         initRegister();
      }
      
      private function __moviesHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(_loc2_)
         {
            addMoviesByLayer(_loc2_.movies as Array,0);
            addMoviesByLayer(_loc2_.tops as Array,2);
         }
      }
      
      private function addMoviesByLayer(param1:Array, param2:int) : void
      {
         var _loc3_:PhysicsStaticView = null;
         var _loc5_:CampaignNode = null;
         var _loc4_:PhysicInfo = null;
         if(!param1)
         {
            return;
         }
         for each(var _loc6_:Object in param1)
         {
            _loc3_ = new PhysicsStaticView();
            _loc5_ = new CampaignNode();
            _loc4_ = new PhysicInfo();
            _loc4_.types = 201;
            _loc4_.state = 1;
            _loc4_.names = _loc6_.url;
            _loc4_.posX = _loc6_.x / 20;
            _loc4_.posY = _loc6_.y / 20;
            _loc5_.info = _loc4_;
            _loc3_.rotation = _loc6_.rotation;
            _loc3_.info = _loc5_;
            _loc3_.x = _loc6_.x;
            _loc3_.y = _loc6_.y;
            if(_loc6_.hasOwnProperty("scaleX"))
            {
               _loc3_.scaleX = _loc6_.scaleX;
            }
            if(_loc6_.hasOwnProperty("scaleY"))
            {
               _loc3_.scaleY = _loc6_.scaleY;
            }
            _items[_loc3_.x + "," + _loc3_.y] = _loc3_;
            _loc5_.nodeView = _loc3_;
            _loc5_.layer = param2;
            _model.staticMovies.push(_loc5_);
            if(param2 == 0)
            {
               _buttomLayer.addChild(_loc3_);
               _loc5_.preParent = _buttomLayer;
            }
            else if(param2 == 2)
            {
               _topLayer.addChild(_loc3_);
               _loc5_.preParent = _topLayer;
            }
         }
      }
      
      private function __curNpcHandler(param1:OuterCityEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         initNpcView(_loc2_);
      }
      
      private function sortFun(param1:CampaignNode, param2:CampaignNode) : Number
      {
         if(param1.nodeId < param2.nodeId)
         {
            return -1;
         }
         if(param1.nodeId > param2.nodeId)
         {
            return 1;
         }
         return 0;
      }
      
      private function initNpcView(param1:Array) : void
      {
         var _loc9_:MapPhysicsBase = null;
         var _loc5_:Array = null;
         var _loc3_:CampaignNode = null;
         var _loc8_:MonopolyNodeInfo = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Boolean = false;
         var _loc10_:Point = null;
         if(inMonopoly && MonopolyManager.instance.model && param1)
         {
            param1.sort(sortFun);
            _loc5_ = MonopolyManager.instance.model.nodeInfos;
            _loc7_ = int(param1.length);
            _loc6_ = 0;
            while(_loc6_ < _loc7_)
            {
               _loc8_ = _loc5_[_loc6_] as MonopolyNodeInfo;
               _loc3_ = param1[_loc6_] as CampaignNode;
               if(_loc8_ && _loc3_)
               {
                  _loc9_ = _items[_loc3_.info.id] as MapPhysicsBase;
                  if(!_loc9_)
                  {
                     _loc9_ = new MonopolyEventView(_loc8_);
                  }
                  _loc9_.x = _loc3_.curPosX * 20;
                  _loc9_.y = _loc3_.curPosY * 20;
                  _items[_loc3_.info.id] = _loc9_;
                  _loc3_.nodeView = _loc9_;
                  _centerLayer.addChild(_loc9_);
                  _loc9_.info = _loc3_;
                  _loc3_.preParent = _centerLayer;
               }
               _loc6_++;
            }
         }
         else
         {
            for each(var _loc2_:CampaignNode in param1)
            {
               if(_loc2_.resource != 1)
               {
                  _loc9_ = _items[_loc2_.info.id] as MapPhysicsBase;
                  if(!_loc9_)
                  {
                     _loc9_ = createNodeView(_loc2_);
                  }
                  _loc9_.filter = _filter;
                  if(_loc2_.fixX != 0 && _loc2_.fixY != 0)
                  {
                     _loc9_.x = _loc2_.fixX;
                     _loc9_.y = _loc2_.fixY;
                  }
                  else
                  {
                     _loc9_.x = _loc2_.info.posX * 20;
                     _loc9_.y = _loc2_.info.posY * 20;
                     if(_loc2_.info.types == 92)
                     {
                        _loc4_ = Boolean(_model.getWalkable(_loc2_.info.posX,_loc2_.info.posY));
                        if(!_loc4_)
                        {
                           _loc10_ = CampaignArmyViewHelper.getNodeStationPointImp(_loc2_);
                           _loc9_.x = _loc10_.x * 20;
                           _loc9_.y = _loc10_.y * 20;
                        }
                     }
                  }
                  _items[_loc2_.info.id] = _loc9_;
                  _loc2_.nodeView = _loc9_;
                  if(_loc2_.info.names)
                  {
                     _loc9_.tipData = createItemTips(_loc2_.info,_loc2_);
                  }
                  if(_loc2_.info.types == 71 || _loc2_.info.types == 81)
                  {
                     _centerLayer.addChildAt(_loc9_,0);
                  }
                  else
                  {
                     _centerLayer.addChild(_loc9_);
                  }
                  _loc9_.info = _loc2_;
                  _loc2_.preParent = _centerLayer;
               }
            }
         }
         refreshNode();
         __updateAirGardenShowAvatarHandler(null,null);
      }
      
      public function addNodeNow(param1:CampaignNode) : void
      {
         var _loc3_:MapPhysicsBase = null;
         var _loc2_:Boolean = false;
         var _loc4_:Point = null;
         if(param1.resource == 1)
         {
            return;
         }
         _loc3_ = _items[param1.info.id] as MapPhysicsBase;
         if(!_loc3_)
         {
            _loc3_ = createNodeView(param1);
         }
         _loc3_.filter = _filter;
         if(param1.fixX != 0 && param1.fixY != 0)
         {
            _loc3_.x = param1.fixX;
            _loc3_.y = param1.fixY;
         }
         else
         {
            _loc3_.x = param1.info.posX * 20;
            _loc3_.y = param1.info.posY * 20;
            if(param1.info.types == 92)
            {
               _loc2_ = Boolean(_model.getWalkable(param1.info.posX,param1.info.posY));
               if(!_loc2_)
               {
                  _loc4_ = CampaignArmyViewHelper.getNodeStationPointImp(param1);
                  _loc3_.x = _loc4_.x * 20;
                  _loc3_.y = _loc4_.y * 20;
               }
            }
         }
         _items[param1.info.id] = _loc3_;
         param1.nodeView = _loc3_;
         if(param1.info.names)
         {
            _loc3_.tipData = createItemTips(param1.info,param1);
         }
         if(param1.info.types == 71 || param1.info.types == 81)
         {
            _centerLayer.addChildAt(_loc3_,0);
         }
         else
         {
            _centerLayer.addChild(_loc3_);
         }
         _loc3_.info = param1;
         param1.preParent = _centerLayer;
         refreshNode();
      }
      
      private function get inMonopoly() : Boolean
      {
         return WorldBossHelper.checkMonopoly(CampaignManager.instance.mapId);
      }
      
      private function refreshNode(param1:Event = null) : void
      {
         var _loc2_:CampaignNode = null;
         var _loc7_:Array = null;
         var _loc4_:Array = null;
         var _loc8_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = int(CampaignManager.instance.mapId);
         if(!WorldBossHelper.checkPetLand(_loc6_))
         {
            return;
         }
         for each(var _loc3_:MapPhysicsBase in _items)
         {
            _loc2_ = _loc3_.info as CampaignNode;
            if(!(!_loc2_ || Boolean(_loc3_.isDie)))
            {
               if(_loc2_.info.types == 91)
               {
                  if(!(!_loc2_.param3 && !_loc2_.param4))
                  {
                     if(_loc2_.param3)
                     {
                        _loc7_ = _loc2_.param3.split(",");
                     }
                     if(_loc2_.param4)
                     {
                        _loc4_ = _loc2_.param4.split(",");
                     }
                     _loc8_ = 0;
                     _loc5_ = false;
                     for each(_loc8_ in _loc7_)
                     {
                        if(TaskManage.instance.cate.hasTaskAndNotCompleted(_loc8_))
                        {
                           _loc5_ = true;
                           break;
                        }
                     }
                     for each(_loc8_ in _loc4_)
                     {
                        if(OfferRewardManager.instance.model.hasTaskAndNotCompleted(_loc8_) || Boolean(RingTaskManager.instance.hasTaskAndNotCompleted(_loc8_)))
                        {
                           _loc5_ = true;
                           break;
                        }
                     }
                     _loc3_.mouseEnabled = _loc5_;
                     _loc3_.showName(_loc5_);
                  }
               }
            }
         }
      }
      
      public function get centerLayer() : Sprite
      {
         return _centerLayer;
      }
      
      public function createNodeView(param1:CampaignNode) : MapPhysicsBase
      {
         if(param1.info.types == 81 || param1.info.types == 71)
         {
            return new PhysicsStaticView();
         }
         if(param1.info.types == 92)
         {
            return new PhysicsChestView(param1.tempData as Array);
         }
         if(param1.info.types == 206)
         {
            return new UnrealShootingNpcPhysics();
         }
         return new CampaignNpcPhysics();
      }
      
      private function createItemTips(param1:PhysicInfo, param2:CampaignNode) : MultipleDictionaryInfo
      {
         var _loc3_:String = null;
         var _loc4_:MultipleDictionaryInfo = new MultipleDictionaryInfo();
         _loc4_.addItem(param1.names,null);
         if(param1.types == 42 || param1.types == 41)
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.PlayerMenu.playerLevel");
            _loc4_.addItem(_loc3_,param1.grade.toString());
            _loc3_ = LanguageMgr.GetTranslation("public.colon",LanguageMgr.GetTranslation("public.playerInfo.ap"));
            _loc4_.addItem(_loc3_,param2.fightCapaity.toString());
         }
         return _loc4_;
      }
      
      public function get items() : Dictionary
      {
         return _items;
      }
      
      private function removeFallChest() : void
      {
         var _loc1_:MapPhysicsBase = null;
         for(var _loc2_:String in _items)
         {
            _loc1_ = _items[_loc2_];
            if(_loc1_)
            {
               _loc1_.dispose();
            }
            _loc1_ = null;
            delete _items[_loc2_];
         }
      }
      
      private function __updateAirGardenShowAvatarHandler(param1:String, param2:Object) : void
      {
         var _loc3_:MapPhysicsBase = null;
         var _loc5_:CampaignNode = null;
         var _loc7_:AirGardenCampaignBedInfo = null;
         var _loc4_:AirGardenCampaignShowAvatarView = null;
         for(var _loc6_:String in _items)
         {
            _loc3_ = _items[_loc6_];
            _loc5_ = _loc3_.info as CampaignNode;
            if(_loc5_ && _loc5_.info && _loc5_.info.types == 207)
            {
               _loc7_ = airGardenModel.getCampaignBedInfoByNodeId(_loc5_.nodeId);
               _loc4_ = airGardenAvatarDic[_loc5_.nodeId];
               if(!_loc4_)
               {
                  _loc4_ = new AirGardenCampaignShowAvatarView();
                  _loc4_.nodeInfo = _loc5_;
                  _airGardenLayer.addChild(_loc4_);
                  _loc4_.x = _loc3_.x;
                  _loc4_.y = _loc3_.y;
                  airGardenAvatarDic[_loc5_.nodeId] = _loc4_;
               }
               _loc4_.data = _loc7_;
               if(_loc5_.info.state != 1)
               {
                  _loc4_.data = null;
               }
            }
         }
      }
      
      private function get airGardenModel() : AirGardenModel
      {
         return AirGardenManager.instance.model;
      }
      
      public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         _model.removeEventListener("currentNpcPos",__curNpcHandler);
         _model.removeEventListener("currentConfigChange",__moviesHandler);
         this.removeEventListener("addedToStage",__addToStageHandler);
         if(TaskManage.instance.cate)
         {
            TaskManage.instance.cate.removeEventListener("task_added",refreshNode);
            TaskManage.instance.cate.removeEventListener("task_remove",refreshNode);
         }
         RingTaskManager.instance.removeEventListener("REFRESHTING",refreshNode);
         OfferRewardManager.instance.removeEventListener("REWARD_TASK_UPDATE",refreshNode);
         MsgMan.removeObserver("CAMPAIGN_DETAIL_UPDATE",this,__updateAirGardenShowAvatarHandler);
         removeFallChest();
         _items = null;
         LogicUtils.disposeDisplayCollection(airGardenAvatarDic);
         airGardenAvatarDic = null;
         ObjectUtils.disposeObject(_airGardenLayer);
         _airGardenLayer = null;
      }
   }
}

