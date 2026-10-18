package yishi.actions.map.collection
{
   import battle.BattleManager;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RapidInfoEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import managers.OfferRewardManager;
   import managers.RingTaskManager;
   import managers.StoreSocketOutManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.internals.data.CampaignNode;
   import map.internals.data.MapPhysics;
   import map.internals.data.SpaceNode;
   import map.outercity.ArchaeologyNodeInfo;
   import map.outercity.manager.OuterCityManager;
   import map.space.SpaceManager;
   import map.space.data.SpaceNodeType;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskTemplate;
   import yishi.actions.map.MapBaseAction;
   import yishi.datas.templates.OfferRewardConditionTemplate;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArchaeologyManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GameBaseQueueManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TaskManage;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class CollectionAction extends MapBaseAction
   {
      
      public static const LEAVE:int = 2;
      
      private var _count:int;
      
      private var _simMc:SimpleMovie;
      
      private var _nodeEff:MovieClip;
      
      private var _nodeId:int;
      
      private var _target:Object;
      
      private var _startBattle:Boolean;
      
      private var _scene:Sprite;
      
      private var _sound:String;
      
      private var currentType:int = 0;
      
      private var _targetX:int;
      
      private var _sendTimeId:int;
      
      private var stage3dMovieEff:Object;
      
      private var _isCancel:Boolean;
      
      private var _selfArmy:CampaignArmy;
      
      private var _selfArmyView:DisplayObject;
      
      public function CollectionAction(param1:Object, param2:int)
      {
         var _loc3_:CampaignNode = null;
         var _loc4_:MapPhysics = null;
         var _loc6_:ArchaeologyNodeInfo = null;
         var _loc5_:SpaceNode = null;
         _target = param1;
         _nodeId = param2;
         if(CampaignManager.instance.mapModel)
         {
            currentType = 2;
            _mapId = CampaignManager.instance.mapModel.mapId;
            _loc3_ = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
            if(!_loc3_)
            {
               _loc3_ = CampaignManager.instance.mapModel.getMapNodeByNodeId(_nodeId);
            }
            if(_loc3_)
            {
               CampaignManager.instance.mapModel.onCollectionId = _loc3_.nodeId;
               if(_loc3_.sonType == 2352 || _loc3_.sonType == 2393 || _loc3_.sonType == 2394 || _loc3_.sonType == 2395)
               {
                  _sound = "040";
               }
               else if(_loc3_.sonType == 2351 || _loc3_.sonType == 2380)
               {
                  _sound = "039";
               }
               else if(_loc3_.sonType == 2350)
               {
                  _sound = "041";
               }
               else if(WorldBossHelper.checkDuskArea(_mapId) || WorldBossHelper.checkIceFireTemple(_mapId))
               {
                  _sound = "040";
               }
               else if(WorldBossHelper.checkPetLand(_mapId))
               {
                  _sound = "040";
               }
               else if(WorldBossHelper.checkSteel(_mapId))
               {
                  _sound = "040";
               }
               else if(WorldBossHelper.checkConsortiaEmeDream(_mapId))
               {
                  _sound = "040";
               }
            }
         }
         else if(OuterCityManager.instance.model)
         {
            currentType = 3;
            _loc4_ = OuterCityManager.instance.model.getMapPhysicsById(_nodeId);
            if(_loc4_)
            {
               OuterCityManager.instance.model.onCollectionId = _loc4_.info.id;
            }
            else
            {
               _loc6_ = OuterCityManager.instance.model.getArchaeologyNodeById(_nodeId);
               if(_loc6_)
               {
                  OuterCityManager.instance.model.onCollectionId = _loc6_.nodeId;
               }
            }
         }
         else if(SpaceManager.instance.model)
         {
            currentType = 1;
            _loc5_ = SpaceManager.instance.model.getMapNodeById(_nodeId);
            if(_loc5_)
            {
               SpaceManager.instance.model.onCollectionId = _loc5_.nodeId;
               if(_loc5_.sonType == 9005)
               {
                  _sound = "040";
               }
            }
         }
         super();
      }
      
      override public function update() : void
      {
         var _loc1_:CampaignNode = null;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         if(stage3dMovieEff)
         {
            stage3dMovieEff.advanceTime(40);
         }
         if(_count % 25 == 0)
         {
            if(_sound)
            {
               SoundManager.instance.play(_sound);
            }
         }
         if(currentType == 2)
         {
            _loc3_ = 0;
            if(CampaignManager.instance.mapModel)
            {
               _loc1_ = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
               if(!_loc1_)
               {
                  _loc1_ = CampaignManager.instance.mapModel.getMapNodeByNodeId(_nodeId);
               }
               if(_selfArmyView && _loc1_)
               {
                  _loc3_ = Point.distance(new Point(int(_loc1_.x / 20),int(_loc1_.y / 20)),new Point(int(_selfArmyView.x / 20),int(_selfArmyView.y / 20)));
               }
            }
            if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE" || _loc3_ > 4)
            {
               dispose();
               return;
            }
         }
         if(BattleManager.getInstance().battleModel)
         {
            _startBattle = BattleManager.getInstance().battleModel.started;
         }
         if(_count == 1)
         {
            _loc4_ = ComponentFactory.Instance.creat("asset.core.CollectionAsset");
            if(_loc4_)
            {
               KeyBoardRegister.instance.keyEnable = false;
               _loc2_ = _loc4_.totalFrames * 33;
               _loc5_ = 1;
               _loc4_.stateMc.gotoAndStop(1);
               if(WorldBossHelper.checkPvp(_mapId))
               {
                  _loc2_ = 1000;
                  _loc5_ = 5;
               }
               else if(WorldBossHelper.checkDuskArea(_mapId))
               {
                  if(_loc1_.param2 == 5)
                  {
                     _loc4_.stateMc.gotoAndStop(8);
                  }
                  else
                  {
                     _loc4_.stateMc.gotoAndStop(1);
                  }
               }
               else if(WorldBossHelper.checkPetLand(_mapId))
               {
                  if(_loc1_.resource == 2)
                  {
                     _loc4_.stateMc.gotoAndStop(1);
                  }
                  else
                  {
                     _loc4_.stateMc.gotoAndStop(6);
                  }
                  lockNode();
               }
               else if(WorldBossHelper.checkWedding(_mapId))
               {
                  _loc4_.stateMc.gotoAndStop(5);
               }
               else if(WorldBossHelper.checkSteel(_mapId))
               {
                  _loc4_.stateMc.gotoAndStop(3);
               }
               else if(WorldBossHelper.checkFarm(_mapId))
               {
                  _loc4_.stateMc.gotoAndStop(7);
               }
               else if(WorldBossHelper.checkConsortiaEmeDream(_mapId))
               {
                  _loc4_.stateMc.gotoAndStop(1);
               }
               _sendTimeId = setInterval(sendCollection,_loc2_);
               _simMc = new SimpleMovie(_loc4_,playerOverCall,1,_loc5_);
               LayerManager.Instance.addToLayer(_simMc,3,false);
               _simMc.mouseChildren = _simMc.mouseEnabled = false;
               __stageResizeHandler();
               _nodeEff = ComponentFactory.Instance.creatCustomObject("asset.core.CollectionNodeEffectAsset");
               if(_target is Sprite)
               {
                  (_target as Sprite).addChild(_nodeEff);
               }
               else if(_target && _target.hasOwnProperty("nameView"))
               {
                  _target.nameView.addChildAt(_nodeEff,0);
               }
               if(OuterCityManager.instance.model && currentType == 3)
               {
                  OuterCityManager.instance.model.isArchaeologyCollection = true;
               }
               StageReferance.addEventListener("resize",__stageResizeHandler);
               StageReferance.stage.addEventListener("mouseDown",__onClickHandler);
               NotificationManager.instance.addEventListener("LOCK_PVP_WARFIGHT",__fightHandler);
            }
            else
            {
               dispose();
            }
         }
         if(_selfArmyView)
         {
            if(!_selfArmyView["isStand"])
            {
               finished = true;
            }
         }
         _count = _count + 1;
      }
      
      protected function __fightHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function lockNode() : void
      {
         NotificationManager.instance.sendNotification("LOCK_NODE",_nodeId);
      }
      
      private function unLockNode() : void
      {
         NotificationManager.instance.sendNotification("UN_LOCK_NODE",_nodeId);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc3_:DisplayObject = null;
         var _loc8_:Object = null;
         var _loc4_:Boolean = false;
         var _loc9_:Point = null;
         var _loc5_:Point = null;
         var _loc2_:Boolean = false;
         if(!_target || _target is DisplayObject)
         {
            if(param1.target == _target)
            {
               if(param1.target.hasOwnProperty("getCurrentPixels"))
               {
                  _loc6_ = uint(param1.target.getCurrentPixels());
                  if(_loc6_ < 50)
                  {
                     _loc2_ = true;
                  }
               }
            }
            else
            {
               if(currentType == 1)
               {
                  _loc7_ = SpaceManager.instance.mapView;
               }
               else if(currentType == 2)
               {
                  _loc7_ = CampaignManager.instance.mapView;
               }
               else if(currentType == 3)
               {
                  _loc7_ = OuterCityManager.instance.mapView;
               }
               _loc3_ = param1.target as DisplayObject;
               _loc8_ = FrameControllerManager.instance.spaceController.frame;
               _loc4_ = true;
               while(_loc3_)
               {
                  if(_loc3_ != _loc7_ && _loc4_ && _loc8_ && _loc8_.hasOwnProperty("isInvalidClick") && _loc8_.isInvalidClick(_loc3_))
                  {
                     break;
                  }
                  _loc4_ = false;
                  if(_loc3_ == _loc7_ || _loc3_ == _loc8_ || _loc3_.hasOwnProperty("isDuskareaSmallMap"))
                  {
                     _loc2_ = true;
                     break;
                  }
                  _loc3_ = _loc3_.parent;
               }
            }
         }
         else if(param1.target == StageReferance.stage.getChildAt(0))
         {
            _loc9_ = new Point(StageReferance.stage.mouseX,StageReferance.stage.mouseY);
            _loc5_ = _target.globalToLocal(_loc9_);
            if(!_target.hitTest(_loc5_,true))
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            if(_simMc)
            {
               _isCancel = true;
               if(WorldBossHelper.checkPetLand(_mapId))
               {
                  unLockNode();
               }
               if(_simMc.parent)
               {
                  _simMc.parent.removeChild(_simMc);
               }
               _simMc.dispose();
               dispose();
            }
            KeyBoardRegister.instance.keyEnable = true;
            if(OuterCityManager.instance.model && currentType == 3)
            {
               OuterCityManager.instance.model.isArchaeologyCollection = false;
            }
            StageReferance.removeEventListener("resize",__stageResizeHandler);
            StageReferance.stage.removeEventListener("mouseDown",__onClickHandler);
            NotificationManager.instance.removeEventListener("LOCK_PVP_WARFIGHT",__fightHandler);
            _scene = null;
            _simMc = null;
            if(_nodeEff)
            {
               _nodeEff.stop();
               if(_nodeEff.parent)
               {
                  _nodeEff.parent.removeChild(_nodeEff);
               }
            }
            _nodeEff = null;
            if(stage3dMovieEff)
            {
               stage3dMovieEff.removeFromParent(true);
               stage3dMovieEff = null;
            }
         }
      }
      
      private function __stageResizeHandler(param1:Event = null) : void
      {
         if(_simMc)
         {
            _simMc.x = (StageReferance.stageWidth - _simMc.width) / 2;
            _simMc.y = StageReferance.stageHeight - 250;
         }
      }
      
      private function sendCollection() : void
      {
         var _loc1_:CampaignNode = null;
         var _loc3_:int = 0;
         var _loc5_:ArchaeologyNodeInfo = null;
         var _loc2_:int = 0;
         var _loc4_:SpaceNode = null;
         if(_sendTimeId == 0)
         {
            return;
         }
         if(CampaignManager.instance.mapModel && currentType == 2)
         {
            if(_sendTimeId > 0)
            {
               clearInterval(_sendTimeId);
            }
            _sendTimeId = 0;
            if(_startBattle)
            {
               return;
            }
            _loc1_ = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
            if(!_loc1_)
            {
               _loc1_ = CampaignManager.instance.mapModel.getMapNodeByNodeId(_nodeId);
            }
            if(!_loc1_)
            {
               return;
            }
            _loc3_ = CampaignManager.instance.mapModel.mapId;
            SocketSendManager.instance.sendSessionOverToBattle(_loc3_,_loc1_.nodeId,2);
         }
         else if(OuterCityManager.instance.model && currentType == 3)
         {
            if(_sendTimeId > 0)
            {
               clearInterval(_sendTimeId);
            }
            _sendTimeId = 0;
            _loc5_ = OuterCityManager.instance.model.getArchaeologyNodeById(_nodeId);
            if(!_loc5_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("outerCity.collection.alert"));
               return;
            }
            _loc2_ = ArchaeologyManager.instance.model.outerBtnState == 0 ? 1 : 6;
            ArchaeologyManager.instance.sendArchaeologyRequest(_loc2_,_nodeId);
         }
         else if(SpaceManager.instance.model && currentType == 1)
         {
            if(_sendTimeId > 0)
            {
               clearInterval(_sendTimeId);
            }
            _sendTimeId = 0;
            _loc4_ = SpaceManager.instance.model.getMapNodeById(_nodeId);
            if(!_loc4_)
            {
               return;
            }
            if(SpaceNodeType.isYearNode(_loc4_.info.types))
            {
               StoreSocketOutManager.sendYearBoxCollectConfirm(_nodeId);
            }
            else
            {
               SocketSendManager.instance.sendSpaceCollectOver(_loc4_);
            }
         }
      }
      
      private function playerOverCall() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:RapidInfoEvent = null;
         KeyBoardRegister.instance.keyEnable = true;
         if(OuterCityManager.instance.model && currentType == 3)
         {
            OuterCityManager.instance.model.isArchaeologyCollection = false;
         }
         StageReferance.removeEventListener("resize",__stageResizeHandler);
         StageReferance.stage.removeEventListener("mouseDown",__onClickHandler);
         NotificationManager.instance.removeEventListener("LOCK_PVP_WARFIGHT",__fightHandler);
         _scene = null;
         _simMc = null;
         if(_nodeEff)
         {
            _nodeEff.stop();
            if(_nodeEff.parent)
            {
               _nodeEff.parent.removeChild(_nodeEff);
            }
         }
         _nodeEff = null;
         if(stage3dMovieEff)
         {
            stage3dMovieEff.removeFromParent(true);
            stage3dMovieEff = null;
         }
         if(!_isCancel)
         {
            sendCollection();
            if(getFlag())
            {
               GameBaseQueueManager.instance.addAction(new CollectionAction(_target,_nodeId),5);
            }
            dispose();
         }
         else
         {
            if(_sendTimeId > 0)
            {
               clearInterval(_sendTimeId);
            }
            _sendTimeId = 0;
         }
         if(CampaignManager.instance.mapModel)
         {
            _loc1_ = WorldBossHelper.checkRapidMap(CampaignManager.instance.mapModel.mapId);
            if(_loc1_)
            {
               _loc2_ = new RapidInfoEvent("rapid_collect_complete");
               _loc2_.data = _target;
               NotificationManager.instance.dispatchEvent(_loc2_);
            }
         }
      }
      
      private function getFlag() : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc2_:OfferRewardConditionTemplate = null;
         var _loc4_:SpaceNode = null;
         var _loc5_:CampaignNode = null;
         var _loc1_:CampaignNode = null;
         var _loc6_:RingTask = RingTaskManager.instance.getRingTask();
         if(_loc6_)
         {
            _loc2_ = _loc6_.conditionList[0] as OfferRewardConditionTemplate;
            if(_loc2_.CondictionType == 4 && !_loc6_.isCompleted)
            {
               _loc3_ = true;
            }
         }
         if(currentType == 1)
         {
            _loc4_ = SpaceManager.instance.model.getMapNodeById(_nodeId);
            if(_loc3_ && _loc4_.param3 == "12")
            {
               return true;
            }
         }
         else
         {
            if(currentType != 2)
            {
               return false;
            }
            _loc5_ = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
            if(_loc5_ && _loc5_.info.state == 8)
            {
               return false;
            }
            if(!_loc5_)
            {
               _loc5_ = CampaignManager.instance.mapModel.getMapNodeByNodeId(_nodeId);
            }
            if(WorldBossHelper.checkPetLand(_mapId))
            {
               _loc1_ = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
               if(!_loc1_)
               {
                  _loc1_ = CampaignManager.instance.mapModel.getMapNodeByNodeId(_nodeId);
               }
               if(!_loc1_ || _loc1_ && _loc1_.info.types == 91 && _loc1_.resource != 2)
               {
                  return false;
               }
               if(_loc3_)
               {
                  return true;
               }
            }
            if(WorldBossHelper.checkMineral(_mapId))
            {
               if(mineralPick < 100 && mineralCarNotFull && checkNodeState())
               {
                  return true;
               }
               return false;
            }
         }
         return false;
      }
      
      private function checkNodeState() : Boolean
      {
         var _loc1_:CampaignNode = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
         if(_loc1_ && _loc1_.info.state == 8)
         {
            return false;
         }
         return true;
      }
      
      private function get checkCollectAgain() : Boolean
      {
         var _loc1_:Array = null;
         var _loc3_:CampaignNode = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
         if(!_loc3_)
         {
            _loc3_ = CampaignManager.instance.mapModel.getMapNodeByNodeId(_nodeId);
         }
         if(_loc3_)
         {
            _loc1_ = _loc3_.param3.split(",");
            for each(var _loc4_:TaskTemplate in TaskManage.instance.cate.acceptedList)
            {
               if(_loc1_.indexOf(_loc4_.TemplateId.toString()) > -1 && !_loc4_.isCompleted)
               {
                  return true;
               }
            }
            _loc1_ = _loc3_.param4.split(",");
            for each(var _loc2_:BaseOfferReward in OfferRewardManager.instance.model.baseRewardDic)
            {
               if(_loc1_.indexOf(_loc2_.rewardTemp.TemplateId.toString()) > -1 && !_loc2_.isCompleted)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      private function get mineralPick() : int
      {
         return CampaignManager.instance.mineralModel.selfCarInfo.pick_count;
      }
      
      private function get mineralCarNotFull() : Boolean
      {
         return CampaignManager.instance.mineralModel.selfCarInfo.minerals < 200;
      }
      
      private function get selfarmy() : BaseArmy
      {
         return ArmyManager.instance.army;
      }
      
      override public function prepare() : void
      {
         if(currentType == 2)
         {
            if(!CampaignManager.instance.mapModel)
            {
               finished = true;
               return;
            }
            if(WorldBossHelper.checkMineral(_mapId))
            {
               _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
               _selfArmyView = CampaignManager.instance.controller.getArmyView(_selfArmy);
            }
            if(WorldBossHelper.checkSteel(_mapId))
            {
               _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
               _selfArmyView = CampaignManager.instance.controller.getArmyView(_selfArmy);
               if(_selfArmy)
               {
                  _selfArmy.addEventListener("BREAK_ACTION",__onDannyHandler);
               }
               if(_selfArmyView)
               {
                  _selfArmyView.addEventListener("WALK_NEXT_POINT",__onDannyHandler);
               }
            }
         }
      }
      
      private function __onDannyHandler(param1:Event) : void
      {
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("BREAK_ACTION",__onDannyHandler);
         }
         if(_selfArmyView)
         {
            _selfArmyView.removeEventListener("WALK_NEXT_POINT",__onDannyHandler);
         }
         finished = true;
         _selfArmy = null;
         _selfArmyView = null;
      }
      
      override public function dispose() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:RapidInfoEvent = null;
         _isCancel = true;
         ObjectUtils.disposeViolentMc(_simMc);
         _simMc = null;
         if(CampaignManager.instance.mapModel)
         {
            CampaignManager.instance.mapModel.onCollectionId = 0;
         }
         if(SpaceManager.instance.model)
         {
            SpaceManager.instance.model.onCollectionId = 0;
         }
         if(OuterCityManager.instance.model)
         {
            OuterCityManager.instance.model.onCollectionId = 0;
         }
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("DANNAY",__onDannyHandler);
         }
         if(CampaignManager.instance.mapModel)
         {
            _loc1_ = WorldBossHelper.checkRapidMap(CampaignManager.instance.mapModel.mapId);
            if(_loc1_)
            {
               _loc2_ = new RapidInfoEvent("rapid_collect_complete");
               NotificationManager.instance.dispatchEvent(_loc2_);
            }
         }
         super.dispose();
      }
   }
}

