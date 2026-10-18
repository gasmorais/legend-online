package map.campaign.view.layer
{
   import com.road.yishi.proto.campaign.NPCChaseMsg;
   import com.road.yishi.proto.campaign.NPCMoveMsg;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.MonopolyManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignEvent;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.view.physics.ActiveVehicleNpcAvater;
   import map.campaign.view.physics.GodsEveningNpcAvatarView;
   import map.campaign.view.physics.MineralCarView;
   import map.campaign.view.physics.NpcAvatarView;
   import map.campaign.view.physics.UnrealShootingNpcAvatarView;
   import map.internals.constant.NodeState;
   import map.internals.constant.PosType;
   import map.internals.data.CampaignNode;
   import map.internals.event.OuterCityEvent;
   import map.internals.interfaces.IBaseMouseEvent;
   import yishi.datas.ai.NpcAiInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.MediatorMananger;
   import yishi.utils.WorldBossHelper;
   
   public class NpcLayer implements IEnterFrame
   {
      
      public static const NAME:String = "map.campaign.view.layer.NpcLayer";
      
      private var _container:Sprite;
      
      private var _avatarList:Array = [];
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var model:CampaignMapModel = CampaignManager.instance.mapModel;
      
      private var _mediatorKey:String;
      
      public function NpcLayer(param1:Sprite)
      {
         _container = param1;
         super();
         init(model.mapNodesData);
         initRegister();
         model.addEventListener("MOVE_NPC",__npcMoveHandler);
         model.addEventListener("NPC_CHASE",__npcChaseArmyHandler);
         model.addEventListener("currentNpcPos",__addNpcHandler);
         model.addEventListener("REMOVE_NODE",__removeNpcHandler);
      }
      
      public function get avatarList() : Array
      {
         return _avatarList;
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
      
      private function init(param1:Array) : void
      {
         var _loc2_:NpcAvatarView = null;
         var _loc4_:NpcAiInfo = null;
         var _loc5_:int = 0;
         if(!(inMonopoly && MonopolyManager.instance.model && param1))
         {
            for each(var _loc3_:CampaignNode in param1)
            {
               if(_loc3_.resource == 1)
               {
                  if(!(inWedding && (_loc3_.param1 == 1 || _loc3_.param1 == 2)))
                  {
                     _loc2_ = findNodeView(_loc3_) as NpcAvatarView;
                     if(_loc2_)
                     {
                        setNPCPos(_loc2_,_loc3_);
                     }
                     else
                     {
                        _loc5_ = int(CampaignManager.instance.mapModel ? CampaignManager.instance.mapModel.mapId : 0);
                        if(_loc3_.info.occupyPlayerId > 0 && Boolean(WorldBossHelper.checkMineral(_loc5_)))
                        {
                           _loc2_ = new MineralCarView("","",0,0,_loc3_);
                        }
                        else if(WorldBossHelper.checkUnrealShooting(_loc5_))
                        {
                           _loc2_ = new UnrealShootingNpcAvatarView("","",0,0);
                        }
                        else if(WorldBossHelper.checkActiveVehicle(_loc5_))
                        {
                           _loc2_ = new ActiveVehicleNpcAvater("","",0,0);
                        }
                        else if(WorldBossHelper.checkGodsEvening(_loc5_) && _loc3_.info.types != 1101)
                        {
                           _loc2_ = new GodsEveningNpcAvatarView("","",0,0);
                        }
                        else
                        {
                           _loc2_ = new NpcAvatarView("","",0,0);
                        }
                        _loc2_.filter = _filter;
                        _loc4_ = new NpcAiInfo();
                        _loc4_.isLiving = true;
                        _loc4_.moveState = 3;
                        _loc4_.centerPoint = new Point(_loc3_.x,_loc3_.y);
                        _loc2_.info = _loc4_;
                        setNPCPos(_loc2_,_loc3_);
                        _loc3_.nodeView = _loc2_;
                        _loc3_.preParent = _container;
                        _avatarList.push(_loc2_);
                        _loc2_.nodeInfo = _loc3_;
                        _container.addChild(_loc2_);
                     }
                  }
               }
            }
         }
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function get inMonopoly() : Boolean
      {
         return WorldBossHelper.checkMonopoly(CampaignManager.instance.mapId);
      }
      
      private function get inWedding() : Boolean
      {
         return WorldBossHelper.checkWedding(CampaignManager.instance.mapId);
      }
      
      private function findNodeView(param1:CampaignNode) : DisplayObject
      {
         if(!param1)
         {
            return null;
         }
         return model.getNodeById(param1.info.id);
      }
      
      private function setNPCPos(param1:NpcAvatarView, param2:CampaignNode) : void
      {
         if(param2.nodeId == 1000202)
         {
            param1.x = -300;
            param1.y = 3490;
         }
         else
         {
            param1.x = param2.curPosX * 20;
            param1.y = param2.curPosY * 20;
         }
      }
      
      private function initRegister() : void
      {
         var _loc1_:Array = [];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,_container,"map.campaign.view.layer.NpcLayer");
      }
      
      private function __addNpcHandler(param1:Event) : void
      {
         init(model.mapNodesData);
      }
      
      private function __removeNpcHandler(param1:OuterCityEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:NpcAvatarView = null;
         var _loc3_:CampaignNode = param1.data as CampaignNode;
         _loc4_ = 0;
         while(_loc4_ < _avatarList.length)
         {
            _loc2_ = _avatarList[_loc4_] as NpcAvatarView;
            if(_loc2_ == _loc3_.nodeView)
            {
               _avatarList.splice(_loc4_,1);
               if(_loc2_)
               {
                  _loc2_.dispose();
               }
            }
            _loc2_ = null;
            _loc4_++;
         }
      }
      
      private function __npcChaseArmyHandler(param1:CampaignEvent) : void
      {
         var _loc2_:NPCChaseMsg = param1.data as NPCChaseMsg;
         var _loc3_:NpcAvatarView = model.getNodeById(_loc2_.nodeId) as NpcAvatarView;
         if(_loc3_)
         {
            _loc3_.npcAiInfo.attackArmyId = _loc2_.armyId;
            _loc3_.npcAiInfo.attackArmyServerName = _loc2_.serverName;
            _loc3_.npcAiInfo.moveState = 6;
         }
         _loc2_ = null;
      }
      
      private function __npcMoveHandler(param1:CampaignEvent) : void
      {
         var _loc4_:int = int(CampaignManager.instance.mapModel ? CampaignManager.instance.mapModel.mapId : 0);
         var _loc2_:NPCMoveMsg = param1.data as NPCMoveMsg;
         var _loc3_:NpcAvatarView = model.getNodeById(_loc2_.id) as NpcAvatarView;
         if(_loc3_)
         {
            if(checkCanMove(_loc3_.nodeInfo as CampaignNode))
            {
               _loc3_.npcAiInfo.moveState = 5;
            }
            else
            {
               _loc3_.npcAiInfo.moveState = 3;
            }
            if(_loc2_.posX > 0 || _loc2_.posY > 0)
            {
               (_loc3_.nodeInfo as CampaignNode).curPosX = _loc2_.posX;
               (_loc3_.nodeInfo as CampaignNode).curPosY = _loc2_.posY;
               _loc3_.x = _loc2_.posX * 20;
               _loc3_.y = _loc2_.posY * 20;
            }
            _loc3_.npcAiInfo.nextPoint = new Point(_loc2_.curPosX * 20,_loc2_.curPosY * 20);
         }
         _loc2_ = null;
      }
      
      private function checkCanMove(param1:CampaignNode) : Boolean
      {
         if(!param1)
         {
            return true;
         }
         switch(int(param1.info.types) - 161)
         {
            case 0:
               return false;
            default:
               return true;
         }
      }
      
      public function enterFrame() : void
      {
         if(!model || Boolean(model.exit))
         {
            return;
         }
         for each(var _loc1_:NpcAvatarView in _avatarList)
         {
            _loc1_.execute();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:NpcAvatarView = null;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,_container);
         model.removeEventListener("MOVE_NPC",__npcMoveHandler);
         model.removeEventListener("NPC_CHASE",__npcChaseArmyHandler);
         model.removeEventListener("currentNpcPos",__addNpcHandler);
         model.removeEventListener("REMOVE_NODE",__removeNpcHandler);
         while(_avatarList.length > 0)
         {
            _loc1_ = _avatarList.pop();
            _loc1_.dispose();
         }
         _avatarList = null;
         _filter = null;
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         model = null;
      }
      
      public function onClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            _loc2_.mouseClickHandler(param1);
            return true;
         }
         return false;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            _loc2_.mouseMoveHandler(param1);
         }
      }
      
      public function mouseOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:IBaseMouseEvent = param1.target as IBaseMouseEvent;
         if(_loc2_)
         {
            _loc2_.mouseOutHandler(param1);
         }
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:NpcAvatarView = null;
         var _loc3_:CampaignNode = null;
         if(isInMineralNoPVP())
         {
            return false;
         }
         if(param1.target is NpcAvatarView)
         {
            _loc2_ = param1.target as NpcAvatarView;
            _loc3_ = _loc2_.nodeInfo as CampaignNode;
            if(_loc3_.followTarget > 0)
            {
               return false;
            }
            if(!PosType.checkNeutralState(_loc2_.nodeInfo.info.types) || CampaignArmyViewHelper.groupfbMonsterNode(_loc3_))
            {
               if(NodeState.isOppositionState(_loc2_.nodeInfo.info.state))
               {
                  return _loc2_.mouseMoveHandler(param1);
               }
            }
         }
         else if(param1.target is IBaseMouseEvent)
         {
            return (param1.target as IBaseMouseEvent).mouseMoveHandler(param1);
         }
         return false;
      }
      
      private function isInMineralNoPVP() : Boolean
      {
         return WorldBossHelper.checkMineralNoPVP(CampaignManager.instance.mapModel.mapId);
      }
   }
}

