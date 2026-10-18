package map.campaign.action
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.CampaignMapView;
   import map.campaign.view.physics.UnrealShootingArmyView;
   import map.campaign.view.physics.UnrealShootingNpcAvatarView;
   import map.campaign.view.physics.UnrealShootingNpcPhysics;
   import map.internals.constant.MapGlobal;
   import map.internals.constant.NodeState;
   import map.internals.data.CampaignNode;
   import map.internals.utils.PathPointUtils;
   import map.net.MapSocketOuterManager;
   import yishi.actions.map.MapBaseAction;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.interfaces.IAction;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   
   public class UnrealShootingCastAction extends MapBaseAction
   {
      
      private var _shooter:UnrealShootingArmyView;
      
      private var _skillId:int;
      
      private var _model:CampaignMapModel;
      
      private var _mapView:CampaignMapView;
      
      private var _controller:CampaignMapController;
      
      private var _skillTempInfo:VehicleSkillTempInfo;
      
      private var _attackArmyInfo:CampaignArmy;
      
      private var _distance:int = 100;
      
      private var _castMc:MovieClip;
      
      private var _tween:TweenMax;
      
      private var _state:int = 0;
      
      private var _stage:Stage;
      
      private var _target:Object;
      
      private var _shootPoint:Point = new Point();
      
      private var targetArmy:CampaignArmy;
      
      private var targetNode:CampaignNode;
      
      private var _count:int = -1;
      
      private var _sendCastTime:Number;
      
      private var _castMcStarTime:Number;
      
      private var _isSend:Boolean;
      
      public function UnrealShootingCastAction(param1:UnrealShootingArmyView, param2:int, param3:Object)
      {
         super();
         _shooter = param1;
         _attackArmyInfo = _shooter.data;
         _skillId = param2;
         _skillTempInfo = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_skillId);
         _distance = _skillTempInfo.AttackRange;
         _model = CampaignManager.instance.mapModel;
         _mapView = CampaignManager.instance.mapView;
         _controller = CampaignManager.instance.controller;
         _stage = StageReferance.stage;
         _target = param3;
         if(param3 is UnrealShootingArmyView)
         {
            targetArmy = (_target as UnrealShootingArmyView).data;
         }
         else if(param3 is UnrealShootingNpcAvatarView)
         {
            targetNode = (_target as UnrealShootingNpcAvatarView).nodeInfo as CampaignNode;
         }
         else if(param3 is UnrealShootingNpcPhysics)
         {
            targetNode = (_target as UnrealShootingNpcPhysics).info as CampaignNode;
         }
         KeyBoardRegister.instance.battleFlag = true;
      }
      
      private function get shootPoint() : Point
      {
         if(_target is CampaignNode)
         {
            _shootPoint.x = _target.curPosX * 20;
            _shootPoint.y = _target.curPosY * 20;
         }
         else
         {
            _shootPoint.x = _target.x;
            _shootPoint.y = _target.y;
         }
         return _shootPoint;
      }
      
      override public function dispose() : void
      {
         if(_attackArmyInfo)
         {
            _attackArmyInfo.isCasting = false;
            _attackArmyInfo.removeEventListener("USE_SKILL",onTweenComplete);
            _attackArmyInfo = null;
         }
         if(_stage)
         {
            _stage.removeEventListener("resize",__stageResizeHandler);
            _stage.removeEventListener("click",__onStageClickHandler);
         }
         ObjectUtils.disposeObject(_castMc);
         _castMc = null;
         _skillId = 0;
         _skillTempInfo = null;
         _model = null;
         _mapView = null;
         _controller = null;
         _stage = null;
         _target = null;
         _shooter = null;
         if(_tween)
         {
            _tween.kill();
         }
         _tween = null;
         KeyBoardRegister.instance.battleFlag = false;
         super.dispose();
      }
      
      override public function prepare() : void
      {
         if(finished)
         {
            return;
         }
         _model.updateWalkTarget(null);
         _stage.addEventListener("click",__onStageClickHandler);
      }
      
      private function __onStageClickHandler(param1:MouseEvent) : void
      {
         if(_state == 2)
         {
            finished = true;
            return;
         }
      }
      
      override public function update() : void
      {
         _count = _count + 1;
         if(_shooter.isDie)
         {
            finished = true;
            return;
         }
         if(CampaignArmyState.checkDied(_attackArmyInfo.isDie))
         {
            finished = true;
            return;
         }
         if(_attackArmyInfo.isStun)
         {
            finished = true;
            return;
         }
         if(targetNode)
         {
            if(!NodeState.displayState(targetNode.info.state) || targetNode.info.state == 4)
            {
               finished = true;
               return;
            }
         }
         else if(targetArmy)
         {
            if(CampaignArmyState.checkDied(targetArmy.isDie) || targetArmy.state == 2)
            {
               finished = true;
               return;
            }
         }
         if(_state == 1 && _shooter.aiInfo.pathInfo && _shooter.aiInfo.pathInfo.length > 0)
         {
            finished = true;
            return;
         }
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            finished = true;
            return;
         }
         var _loc1_:Number = Point.distance(new Point(_shooter.x,_shooter.y),shootPoint);
         if(_state == 1 && _loc1_ > _distance * 2)
         {
            finished = true;
            return;
         }
         if(finished)
         {
            return;
         }
         if(_state != 1)
         {
            if(_loc1_ < _distance + 40)
            {
               startCast();
            }
            else if(_count % 80 == 0)
            {
               startMove(shootPoint);
            }
         }
      }
      
      private function startCast() : void
      {
         _state = 1;
         if(_shooter && _shooter.aiInfo)
         {
            _shooter.aiInfo.pathInfo = [];
         }
         var _loc1_:Number = _skillTempInfo.CastTime / 1000;
         if(_loc1_ > 0)
         {
            _sendCastTime = _skillTempInfo.CastTime * 0.8;
            _castMcStarTime = getTimer();
            _castMc = ComponentFactory.Instance.creat("asset.core.CollectionAsset");
            if(_castMc["stateMc"])
            {
               (_castMc["stateMc"] as MovieClip).gotoAndStop(4);
            }
            LayerManager.Instance.addToLayer(_castMc,3,false);
            __stageResizeHandler();
            _shooter.changeDirectionTo(shootPoint.x,shootPoint.y);
            _attackArmyInfo.isCasting = true;
            if(_tween)
            {
               _tween.kill();
            }
            _tween = null;
            _tween = TweenMax.to(_castMc,_loc1_,{
               "frame":_castMc.totalFrames,
               "onUpdate":onTweenUpdate,
               "onComplete":onTweenComplete,
               "ease":Linear.easeNone
            });
            _stage.addEventListener("resize",__stageResizeHandler);
            if(_attackArmyInfo)
            {
               _attackArmyInfo.addEventListener("USE_SKILL",onTweenComplete);
            }
            return;
         }
         sendUseSkill();
         startSkillCD();
         finished = true;
      }
      
      private function onTweenUpdate(param1:Event = null) : void
      {
         if(_isSend)
         {
            return;
         }
         if(finished)
         {
            return;
         }
         if(getTimer() - _castMcStarTime >= _sendCastTime)
         {
            sendUseSkill();
            startSkillCD();
            _isSend = true;
         }
      }
      
      override public function set finished(param1:Boolean) : void
      {
         super.finished = param1;
         if(param1)
         {
            if(_tween)
            {
               _tween.kill();
            }
            _tween = null;
         }
      }
      
      private function onTweenComplete(param1:Event = null) : void
      {
         if(_tween)
         {
            _tween.kill();
         }
         _tween = null;
         finished = true;
      }
      
      private function startSkillCD() : void
      {
         if(_model && _attackArmyInfo == _model.selfMemberData)
         {
            NotificationManager.instance.sendNotification("MAP_USE_SKILL_CD",_skillId);
         }
      }
      
      private function startMove(param1:Point) : void
      {
         _state = 2;
         var _loc2_:Array = findPath(Math.floor(_shooter.x),Math.floor(_shooter.y),Math.floor(param1.x),Math.floor(param1.y));
         if(!_loc2_)
         {
            finished = true;
         }
         else if(_loc2_.length <= 0)
         {
            finished = true;
         }
         _shooter.aiInfo.pathInfo = _loc2_;
      }
      
      private function findPath(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc6_:Point = null;
         var _loc10_:Array = null;
         var _loc8_:Point = _model.getAroundWalkPoint(param1,param2);
         if(!_loc8_)
         {
            return null;
         }
         var _loc9_:Point = _model.getAroundWalkPoint(param3,param4);
         if(!_loc9_)
         {
            _loc9_ = new Point(param3 / 20,param4 / 20);
            _loc10_ = PathPointUtils.findPoints(_loc8_,_loc9_);
            for each(var _loc5_:Point in _loc10_)
            {
               if(!_model.getWalkable(_loc5_.x,_loc5_.y))
               {
                  _loc6_ = _loc5_;
                  break;
               }
            }
            if(_loc6_)
            {
               return [_loc8_,_loc6_];
            }
            return null;
         }
         return _controller.searchPath(_loc8_,_loc9_);
      }
      
      private function sendUseSkill() : void
      {
         var _loc12_:CampaignArmy = null;
         var _loc4_:CampaignNode = null;
         var _loc8_:int = 0;
         var _loc10_:Rectangle = null;
         var _loc5_:Array = null;
         if(finished)
         {
            return;
         }
         if(!_attackArmyInfo)
         {
            return;
         }
         _attackArmyInfo.isCasting = false;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            return;
         }
         if(!MapGlobal.qtree)
         {
            return;
         }
         var _loc1_:Point = new Point(_shooter.x,_shooter.y);
         var _loc7_:Point = shootPoint.clone();
         _loc1_.x = Math.floor(_loc1_.x / 20);
         _loc1_.y = Math.floor(_loc1_.y / 20);
         _loc7_.x = Math.floor(_loc7_.x / 20);
         _loc7_.y = Math.floor(_loc7_.y / 20);
         var _loc2_:Point = _loc7_;
         var _loc6_:Boolean = false;
         var _loc11_:Array = [];
         var _loc9_:Array = [];
         var _loc3_:Array = [];
         if(!_loc6_)
         {
            if(_target is Point)
            {
               _loc8_ = int(_skillTempInfo.DamageCoverage);
               _loc10_ = new Rectangle(shootPoint.x - _loc8_,shootPoint.y - _loc8_,_loc8_ * 2,_loc8_ * 2);
               _loc5_ = MapGlobal.qtree.find(_loc10_);
               findCanSelectObject(_loc5_,shootPoint,_skillTempInfo.DamageCoverage,_loc11_,_loc9_,_loc3_);
            }
            else if(_target is UnrealShootingArmyView)
            {
               _loc12_ = (_target as UnrealShootingArmyView).data;
               _loc11_.push(_loc12_.userId);
               _loc9_.push(_loc12_.baseHero.serviceName);
            }
            else if(_target is UnrealShootingNpcAvatarView)
            {
               _loc4_ = (_target as UnrealShootingNpcAvatarView).nodeInfo as CampaignNode;
               _loc3_.push(_loc4_.nodeId);
            }
            else if(_target is UnrealShootingNpcPhysics)
            {
               _loc4_ = (_target as UnrealShootingNpcPhysics).info as CampaignNode;
               _loc3_.push(_loc4_.nodeId);
            }
            else if(_target is CampaignArmy)
            {
               _loc11_.push((_target as CampaignArmy).userId);
               _loc9_.push((_target as CampaignArmy).baseHero.serviceName);
            }
            else if(_target is CampaignNode)
            {
               _loc3_.push((_target as CampaignNode).nodeId);
            }
         }
         MapSocketOuterManager.sendCastSkillUnrealShooting(_attackArmyInfo.userId,_attackArmyInfo.baseHero.serviceName,_skillId,_loc11_,_loc9_,_loc3_,_loc2_.x,_loc2_.y);
      }
      
      private function findCanSelectObject(param1:Array, param2:Point, param3:int, param4:Array, param5:Array, param6:Array) : void
      {
         for each(var _loc7_:Object in param1)
         {
            if(_loc7_ is UnrealShootingArmyView)
            {
               selectNearPlayer(_loc7_ as UnrealShootingArmyView,param2,param3,param4,param5,param6);
            }
            else if(_loc7_ is UnrealShootingNpcAvatarView)
            {
               selectNearNpcAvatar(_loc7_ as UnrealShootingNpcAvatarView,param2,param3,param4,param5,param6);
            }
            else if(_loc7_ is UnrealShootingNpcPhysics)
            {
               selectNearNpcPhysics(_loc7_ as UnrealShootingNpcPhysics,param2,param3,param4,param5,param6);
            }
         }
      }
      
      private function selectNearPlayer(param1:UnrealShootingArmyView, param2:Point, param3:int, param4:Array, param5:Array, param6:Array) : void
      {
         if(!param1.data)
         {
            return;
         }
         if(param1.isDie)
         {
            return;
         }
         if(!_controller)
         {
            return;
         }
         var _loc9_:Point = new Point(param1.x,param1.y);
         var _loc7_:Number = Point.distance(param2,_loc9_);
         if(_loc7_ > param3)
         {
            return;
         }
         var _loc8_:CampaignArmy = param1.data;
         if(_skillTempInfo.IFF == 1 && !_controller.checkCanCastSkillTo(_loc8_))
         {
            return;
         }
         if(_loc8_.userId == _attackArmyInfo.userId && _loc8_.baseHero.serviceName == _attackArmyInfo.baseHero.serviceName)
         {
            return;
         }
         param4.push(_loc8_.userId);
         param5.push(_loc8_.baseHero.serviceName);
      }
      
      private function selectNearNpcAvatar(param1:UnrealShootingNpcAvatarView, param2:Point, param3:int, param4:Array, param5:Array, param6:Array) : void
      {
         if(param1.isDie)
         {
            return;
         }
         if(!param1.nodeInfo)
         {
            return;
         }
         if(!_controller)
         {
            return;
         }
         var _loc9_:Point = new Point(param1.x,param1.y);
         var _loc7_:Number = Point.distance(param2,_loc9_);
         if(_loc7_ > param3)
         {
            return;
         }
         var _loc8_:CampaignNode = param1.nodeInfo as CampaignNode;
         if(_skillTempInfo.IFF == 1 && !_controller.checkCanCastSkillTo(_loc8_))
         {
            return;
         }
         param6.push(_loc8_.nodeId);
      }
      
      private function selectNearNpcPhysics(param1:UnrealShootingNpcPhysics, param2:Point, param3:int, param4:Array, param5:Array, param6:Array) : void
      {
         if(param1.isDie)
         {
            return;
         }
         if(!param1.info)
         {
            return;
         }
         if(!_controller)
         {
            return;
         }
         var _loc9_:Point = new Point(param1.x,param1.y);
         var _loc7_:Number = Point.distance(param2,_loc9_);
         if(_loc7_ > param3)
         {
            return;
         }
         var _loc8_:CampaignNode = param1.info as CampaignNode;
         if(_skillTempInfo.IFF == 1 && !_controller.checkCanCastSkillTo(_loc8_))
         {
            return;
         }
         param6.push(_loc8_.nodeId);
      }
      
      private function __stageResizeHandler(param1:Event = null) : void
      {
         if(_castMc)
         {
            _castMc.x = (StageReferance.stageWidth - _castMc.width) / 2 - 29;
            _castMc.y = StageReferance.stageHeight - 200;
         }
      }
      
      override public function get type() : String
      {
         return "UnrealShootingCastAction";
      }
      
      override public function cancel() : void
      {
         finished = true;
      }
      
      override public function replace(param1:IAction) : Boolean
      {
         if(param1 is UnrealShootingJumpCastAction)
         {
            return true;
         }
         if(param1 is UnrealShootingJumpAction)
         {
            return true;
         }
         return false;
      }
      
      override public function filter(param1:IAction) : Boolean
      {
         if(param1 is UnrealShootingCastAction)
         {
            return true;
         }
         return false;
      }
   }
}

