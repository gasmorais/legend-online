package com.map.vehicle.action
{
   import com.greensock.TweenMax;
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.VehicleView;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.TankState;
   import com.map.vehicle.data.UseSkillInfo;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.map.vehicle.net.VehicleSocketOutManager;
   import com.map.vehicle.objects.TankAvatarView;
   import com.map.vehicle.objects.VehicleNpcAvatarView;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.mapengine.ai.astar.AIManager;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.interfaces.IAction;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   
   public class CastAction extends BaseVehicleAction
   {
      
      private var _castMc:MovieClip;
      
      private var _tween:TweenMax;
      
      private var _stage:Stage;
      
      private var _skillId:int;
      
      private var _skillTemp:VehicleSkillTempInfo;
      
      private var _distance:int = 100;
      
      private var _model:VehicleModel;
      
      private var _world:VehicleView;
      
      private var _state:int = 0;
      
      protected var _targetLogic:BitmapSimpleLogic;
      
      protected var _targetPoint:Point;
      
      protected var _shooter:TankAvatarView;
      
      private var shootPoint:Point;
      
      private var _sendCastTime:Number;
      
      private var _castMcStarTime:Number;
      
      private var _isSend:Boolean;
      
      private var _count:int = 0;
      
      public function CastAction(param1:TankAvatarView, param2:int)
      {
         super();
         _model = VehicleSocketManager.instance.model;
         _world = VehicleSocketManager.instance.controller.vehicleWorld;
         _shooter = param1;
         _skillId = param2;
         _skillTemp = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_skillId);
         _distance = _skillTemp.AttackRange;
         _stage = StageReferance.stage;
         KeyBoardRegister.instance.battleFlag = true;
      }
      
      override public function get type() : String
      {
         return _skillId.toString();
      }
      
      override public function filter(param1:IAction) : Boolean
      {
         if(param1 is CastAction)
         {
            return true;
         }
         return false;
      }
      
      override public function prepare() : void
      {
         var _loc1_:Number = NaN;
         if(_targetPoint != null)
         {
            shootPoint = _targetPoint.clone();
         }
         else
         {
            if(_targetLogic == null)
            {
               cancel();
               dispose();
               return;
            }
            shootPoint = new Point(_targetLogic.x,_targetLogic.y);
         }
         _loc1_ = Point.distance(new Point(_shooter.x,_shooter.y),shootPoint);
         if(_loc1_ <= _distance)
         {
            startCast();
         }
         else
         {
            startMove(shootPoint);
         }
         if(_stage)
         {
            _stage.addEventListener("click",__onStageClickHandler);
         }
      }
      
      private function __onStageClickHandler(param1:MouseEvent) : void
      {
         if(_state == 2)
         {
            dispose();
            return;
         }
      }
      
      private function startCast() : void
      {
         _state = 1;
         if(_shooter && _shooter.data)
         {
            _shooter.stop();
            _shooter.data.isCasting = true;
            VehicleSocketOutManager.instance.sendCampaignArmyMove(_shooter.data.playerId,[_shooter.getTilePoint()]);
         }
         NotificationManager.instance.dispatchEvent(new VehicleEvent("UPDATE_WALK_TARGET",null));
         _castMc = ComponentFactory.Instance.creat("asset.core.CollectionAsset");
         if(_castMc["stateMc"])
         {
            (_castMc["stateMc"] as MovieClip).gotoAndStop(4);
         }
         LayerManager.Instance.addToLayer(_castMc,3,false);
         _sendCastTime = _skillTemp.CastTime * 0.5;
         var _loc1_:Number = _skillTemp.CastTime / 1000;
         if(_loc1_ > 0)
         {
            __stageResizeHandler();
            _shooter.changeDirectionTo(shootPoint.x,shootPoint.y);
            _castMcStarTime = getTimer();
            _isSend = false;
            _tween = TweenMax.to(_castMc,_loc1_,{
               "frame":_castMc.totalFrames,
               "onUpdate":send,
               "onComplete":__tweenComplete
            });
            if(_stage)
            {
               _stage.addEventListener("resize",__stageResizeHandler);
            }
            if(_shooter.data)
            {
               _shooter.data.addEventListener("SKILL_CAST_OVER",__castOverHandler);
            }
            return;
         }
         __onCastCompleteHandler();
         dispose();
      }
      
      private function send() : void
      {
         if(_isSend)
         {
            return;
         }
         var _loc1_:Number = getTimer();
         if(_loc1_ - _castMcStarTime > _sendCastTime)
         {
            _isSend = true;
            __onCastCompleteHandler();
         }
      }
      
      private function __tweenComplete() : void
      {
         dispose();
      }
      
      private function __castOverHandler(param1:VehicleEvent) : void
      {
         var _loc2_:UseSkillInfo = param1.data as UseSkillInfo;
         if(_loc2_.skillId == _skillId)
         {
            dispose();
         }
      }
      
      private function startMove(param1:Point) : void
      {
         _state = 2;
         var _loc2_:Array = findPath(Math.floor(_shooter.x),Math.floor(_shooter.y),Math.floor(param1.x),Math.floor(param1.y));
         if(_loc2_ && _loc2_.length > 2)
         {
            _loc2_.shift();
            _shooter.path = _loc2_;
         }
      }
      
      private function findPath(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc6_:Point = _model.getAroundWalkPoint(param1,param2);
         if(!_loc6_)
         {
            return null;
         }
         var _loc7_:Point = _model.getAroundWalkPoint(param3,param4);
         if(!_loc7_)
         {
            return null;
         }
         var _loc5_:Array = AIManager.instance.find(_loc6_,_loc7_);
         if(_loc5_)
         {
            if(_loc5_.length > 2)
            {
               _loc5_.shift();
            }
         }
         return _loc5_;
      }
      
      private function __onCastCompleteHandler() : void
      {
         if(SceneManager.instance.currentType != "VEHICLE")
         {
            _finished = true;
            return;
         }
         sendUseSkill();
         finishCast();
         _state = 0;
      }
      
      private function sendUseSkill() : void
      {
         var _loc6_:Point = null;
         var _loc7_:Array = null;
         var _loc2_:Point = new Point(_shooter.x,_shooter.y);
         if(_targetLogic)
         {
            _loc6_ = new Point(_targetLogic.x,_targetLogic.y);
         }
         else
         {
            if(!_targetPoint)
            {
               return;
            }
            _loc6_ = _targetPoint.clone();
         }
         _loc2_.x = Math.floor(_loc2_.x / 20);
         _loc2_.y = Math.floor(_loc2_.y / 20);
         _loc6_.x = Math.floor(_loc6_.x / 20);
         _loc6_.y = Math.floor(_loc6_.y / 20);
         var _loc3_:Point = _loc6_;
         var _loc5_:Boolean = false;
         if(_skillTemp.InjuryEffect == 1)
         {
            _loc7_ = findPoints(_loc2_,_loc6_);
            for each(var _loc1_:Point in _loc7_)
            {
               if(_model.isBarrier(_loc1_.x,_loc1_.y))
               {
                  _loc3_ = _loc1_;
                  _loc5_ = true;
                  break;
               }
            }
         }
         var _loc8_:Array = [];
         var _loc4_:Array = [];
         if(!_loc5_)
         {
            if(_targetLogic)
            {
               if(_targetLogic is TankAvatarView)
               {
                  _loc8_.push((_targetLogic as TankAvatarView).data.playerId);
               }
               else if(_targetLogic is VehicleNpcAvatarView)
               {
                  _loc4_.push((_targetLogic as VehicleNpcAvatarView).data.nodeId);
               }
            }
            else if(_targetPoint)
            {
               _loc8_ = findNearPlayers(_targetPoint,_skillTemp.DamageCoverage);
               _loc4_ = findNearNpcs(_targetPoint,_skillTemp.DamageCoverage);
            }
         }
         VehicleSocketOutManager.instance.sendCastSkill(_skillId,_loc8_,_loc4_,_loc3_.x,_loc3_.y);
      }
      
      private function finishCast() : void
      {
         _model.skillBag.skillStartCD(_skillId);
         _model.skillBag.reduceSkillCount(_skillId);
      }
      
      private function findPoints(param1:Point, param2:Point) : Array
      {
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc9_:Number = NaN;
         var _loc8_:int = 0;
         var _loc3_:Array = [];
         if(param1.x == param2.x)
         {
            _loc5_ = Math.max(param1.y,param2.y);
            _loc7_ = _loc4_ = Math.min(param1.y,param2.y);
            while(_loc7_ < _loc5_)
            {
               _loc3_.push(new Point(param1.x,_loc7_));
               _loc7_++;
            }
         }
         else
         {
            _loc9_ = (param2.y - param1.y) / (param2.x - param1.x);
            _loc8_ = param2.x > param1.x ? 1 : -1;
            _loc6_ = param1.x;
            while(_loc6_ != param2.x)
            {
               _loc7_ = (_loc6_ - param1.x) * _loc9_ + param1.y;
               _loc3_.push(new Point(_loc6_,_loc7_));
               _loc6_ += _loc8_;
            }
         }
         return _loc3_;
      }
      
      private function findNearPlayers(param1:Point, param2:int) : Array
      {
         var _loc8_:PlayerVehicleInfo = null;
         var _loc3_:Array = [];
         var _loc4_:Array = _world.getAllLogic();
         var _loc5_:Point = new Point();
         var _loc6_:Number = 0;
         for each(var _loc7_:BitmapSimpleLogic in _loc4_)
         {
            if(_loc7_ is TankAvatarView)
            {
               _loc5_.x = _loc7_.x;
               _loc5_.y = _loc7_.y;
               _loc6_ = Point.distance(param1,_loc5_);
               if(_loc6_ < param2)
               {
                  _loc8_ = (_loc7_ as TankAvatarView).data;
                  if(_loc8_)
                  {
                     if(_skillTemp.IFF == 1 && !_model.isFriend(_loc8_.team))
                     {
                        _loc3_.push(_loc8_.playerId);
                     }
                     else if(_skillTemp.IFF == 2 && _model.isFriend(_loc8_.team))
                     {
                        _loc3_.push(_loc8_.playerId);
                     }
                  }
               }
            }
         }
         return _loc3_;
      }
      
      private function findNearNpcs(param1:Point, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:Array = _world.getAllLogic();
         var _loc5_:Point = new Point();
         var _loc6_:Number = 0;
         for each(var _loc7_:BitmapSimpleLogic in _loc4_)
         {
            if(_loc7_ is VehicleNpcAvatarView)
            {
               _loc5_.x = _loc7_.x;
               _loc5_.y = _loc7_.y;
               _loc6_ = Point.distance(param1,_loc5_);
               if(_loc6_ < param2)
               {
                  _loc3_.push((_loc7_ as VehicleNpcAvatarView).data.nodeId);
               }
            }
         }
         return _loc3_;
      }
      
      override public function update() : void
      {
         var _loc3_:TankAvatarView = null;
         var _loc1_:VehicleNpcAvatarView = null;
         var _loc2_:Number = NaN;
         var _loc4_:Point = null;
         if(_shooter.data.isDie)
         {
            _finished = true;
            return;
         }
         if(_targetLogic)
         {
            if(_targetLogic is TankAvatarView)
            {
               _loc3_ = _targetLogic as TankAvatarView;
               if(_loc3_.data.isDie)
               {
                  _finished = true;
                  return;
               }
            }
            if(_targetLogic is VehicleNpcAvatarView)
            {
               _loc1_ = _targetLogic as VehicleNpcAvatarView;
               if(_loc1_.data.isDie)
               {
                  _finished = true;
                  return;
               }
            }
         }
         _count = _count + 1;
         if(_state == 2)
         {
            if(_targetLogic != null)
            {
               _loc4_ = new Point(_targetLogic.x,_targetLogic.y);
            }
            else
            {
               if(_targetPoint == null)
               {
                  _finished = true;
                  return;
               }
               _loc4_ = _targetPoint.clone();
            }
            _loc2_ = Point.distance(new Point(_shooter.x,_shooter.y),_loc4_);
            if(_loc2_ < _distance + 40)
            {
               startCast();
            }
            else if(_count % 80 == 0)
            {
               startMove(_loc4_);
            }
         }
         else if(_state == 1)
         {
            if(_shooter.path && _shooter.path.length > 0)
            {
               _finished = true;
               return;
            }
            if(TankState.isStrongControl(_shooter.data.state))
            {
               _finished = true;
               return;
            }
         }
      }
      
      private function __stageResizeHandler(param1:Event = null) : void
      {
         if(_castMc)
         {
            _castMc.x = (StageReferance.stageWidth - _castMc.width) / 2 - 29;
            _castMc.y = StageReferance.stageHeight - 200;
         }
      }
      
      public function get targetLogic() : BitmapSimpleLogic
      {
         return _targetLogic;
      }
      
      public function set targetLogic(param1:BitmapSimpleLogic) : void
      {
         if(targetPoint)
         {
            return;
         }
         if(param1 is TankAvatarView || param1 is VehicleNpcAvatarView)
         {
            _targetLogic = param1;
         }
      }
      
      public function get targetPoint() : Point
      {
         return _targetPoint;
      }
      
      public function set targetPoint(param1:Point) : void
      {
         if(targetLogic)
         {
            return;
         }
         _targetPoint = param1;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.battleFlag = false;
         if(_shooter && _shooter.data)
         {
            _shooter.data.isCasting = false;
            _shooter.data.removeEventListener("SKILL_CAST_OVER",__castOverHandler);
            _shooter = null;
         }
         if(_stage)
         {
            _stage.removeEventListener("resize",__stageResizeHandler);
            _stage.removeEventListener("click",__onStageClickHandler);
            _stage = null;
         }
         if(_tween)
         {
            _tween.kill();
            _tween = null;
         }
         if(_castMc)
         {
            TweenMax.killTweensOf(_castMc);
            _castMc.gotoAndStop(1);
            ObjectUtils.disposeObject(_castMc);
            _castMc = null;
         }
         _model = null;
         _world = null;
         super.dispose();
      }
   }
}

