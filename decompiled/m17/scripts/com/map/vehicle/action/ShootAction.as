package com.map.vehicle.action
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.map.vehicle.SkillEffectFactory;
   import com.map.vehicle.VehicleModel;
   import com.map.vehicle.data.HurtData;
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.UseSkillInfo;
   import com.map.vehicle.data.VGlobal;
   import com.map.vehicle.data.VehicleNode;
   import com.map.vehicle.events.VehicleEvent;
   import com.map.vehicle.interfaces.ICaster;
   import com.map.vehicle.net.VehicleSocketManager;
   import com.map.vehicle.view.VehicleSkillMovie;
   import com.pickgliss.utils.SoundManager;
   import com.road.mapengine.bitmap.logic.BitmapSimpleLogic;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   
   public class ShootAction extends BaseVehicleAction
   {
      
      private var _useSkillInfo:UseSkillInfo;
      
      private var _shooter:ICaster;
      
      private var _skillTemplate:VehicleSkillTempInfo;
      
      private var _skillFlyLayer:Sprite;
      
      private var _model:VehicleModel;
      
      private var _targetX:int;
      
      private var _targetY:int;
      
      private var speed:Number = 1300;
      
      private var frame:int = 0;
      
      private var shootPoint:Point = new Point();
      
      private var _playSound:Boolean = false;
      
      private var _classList:Array;
      
      private var _angle:Number;
      
      private var _index:int = 0;
      
      private var _lastPoint:Point;
      
      public function ShootAction(param1:ICaster, param2:UseSkillInfo)
      {
         super();
         _shooter = param1;
         _useSkillInfo = param2;
         _skillTemplate = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_useSkillInfo.skillId);
         _skillFlyLayer = VGlobal.logicWorld.topLayer;
         _model = VehicleSocketManager.instance.model;
         for each(var _loc3_:HurtData in _useSkillInfo.playerHurt)
         {
            if(_loc3_.effectId == VGlobal.playerInfo.userId)
            {
               _playSound = true;
            }
         }
         if(_useSkillInfo.casterId == VGlobal.playerInfo.userId)
         {
            _playSound = true;
         }
         if(!SoundManager.instance.allowSound)
         {
            _playSound = false;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _model = null;
         _shooter = null;
         _skillFlyLayer = null;
         _skillTemplate = null;
         _useSkillInfo = null;
      }
      
      override public function prepare() : void
      {
         var _loc6_:BitmapSimpleLogic = null;
         var _loc1_:Rectangle = null;
         var _loc8_:int = 0;
         var _loc4_:PlayerVehicleInfo = null;
         var _loc7_:int = 0;
         var _loc2_:VehicleNode = null;
         _targetX = _useSkillInfo.effectX;
         _targetY = _useSkillInfo.effectY;
         if(!_skillTemplate)
         {
            dispose();
            return;
         }
         if(_skillTemplate.InjuryEffect == 4)
         {
            flyOver();
            return;
         }
         if(_skillTemplate.InjuryEffect == 1)
         {
            if(_useSkillInfo.playerHurt.length > 0)
            {
               _loc8_ = _useSkillInfo.playerHurt[0].effectId;
               _loc4_ = _model.getPlayerInfo(_loc8_);
               if(!_loc4_)
               {
                  _finished = true;
                  return;
               }
               _loc6_ = _loc4_.logicView;
               if(_loc6_)
               {
                  _loc1_ = _loc6_.hitRect;
                  _targetX = _loc1_.x + _loc1_.width / 2;
                  _targetY = _loc1_.y + _loc1_.height / 2;
               }
            }
            else if(_useSkillInfo.npcHurt.length > 0)
            {
               _loc7_ = _useSkillInfo.npcHurt[0].effectId;
               _loc2_ = _model.getNodeByNodeId(_loc7_);
               if(!_loc2_)
               {
                  _finished = true;
                  return;
               }
               _loc6_ = _loc2_.logicView;
               if(_loc6_)
               {
                  _loc1_ = _loc6_.hitRect;
                  _targetX = _loc1_.x + _loc1_.width / 2;
                  _targetY = _loc1_.y + _loc1_.height / 2;
               }
            }
         }
         _shooter.changeDirectionTo(_targetX,_targetY);
         var _loc5_:Point = new Point(_targetX,_targetY);
         _shooter.playBombSmoke(null);
         shootPoint = _shooter.getShootPoint();
         _angle = calulateAngle(shootPoint.x,shootPoint.y,_targetX,_targetY);
         startFly();
         var _loc3_:VehicleSkillMovie = SkillEffectFactory.instance.createStartEffect(_useSkillInfo);
         if(_loc3_)
         {
            _loc3_.x = shootPoint.x;
            _loc3_.y = shootPoint.y;
            _loc3_.rotation = _angle;
            _skillFlyLayer.addChild(_loc3_);
            if(!_playSound)
            {
               _loc3_.setSoundTransform(VGlobal.volume0);
            }
            else
            {
               _loc3_.setSoundTransform(VGlobal.volume1);
            }
         }
      }
      
      private function startFly() : void
      {
         var _loc2_:Object = null;
         _classList = SkillEffectFactory.instance.getFlyClassArray(_useSkillInfo);
         var _loc1_:int = int(_classList.length);
         var _loc4_:Number = Point.distance(shootPoint,new Point(_targetX,_targetY));
         var _loc3_:Number = _loc4_ / speed;
         if(_loc1_ == 1)
         {
            _loc2_ = SkillEffectFactory.instance.getSkillMovie(_classList[0]);
            (_loc2_ as VehicleSkillMovie).autoDispose = false;
            _skillFlyLayer.addChild(_loc2_ as VehicleSkillMovie);
         }
         else
         {
            _loc2_ = {};
         }
         _lastPoint = shootPoint.clone();
         _loc2_.rotation = _angle;
         _loc2_.x = shootPoint.x;
         _loc2_.y = shootPoint.y;
         if(_loc2_.hasOwnProperty("type") && _loc2_["type"] == 1)
         {
            _loc2_.rotation = _angle - 180;
            (_loc2_ as VehicleSkillMovie).setSkillWidth(_loc4_ + 50);
            (_loc2_ as VehicleSkillMovie).autoDispose = true;
            flyOver();
         }
         else
         {
            TweenMax.to(_loc2_,_loc3_,{
               "ease":Linear.easeNone,
               "x":_targetX,
               "y":_targetY,
               "onUpdate":updateFlyMc,
               "onUpdateParams":[_loc2_],
               "onComplete":flyOver,
               "onCompleteParams":[_loc2_]
            });
         }
      }
      
      private function updateFlyMc(param1:Object) : void
      {
         var _loc7_:int = 0;
         var _loc6_:String = null;
         var _loc8_:VehicleSkillMovie = null;
         if(_classList.length <= 1)
         {
            return;
         }
         var _loc2_:Point = new Point(param1.x,param1.y);
         var _loc9_:Number = Point.distance(_loc2_,_lastPoint);
         var _loc5_:int = Math.ceil(_loc9_ / 25);
         var _loc3_:Number = (_loc2_.x - _lastPoint.x) / _loc5_;
         var _loc4_:Number = (_loc2_.y - _lastPoint.y) / _loc5_;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            if(_index == _classList.length)
            {
               _index = 0;
            }
            _loc6_ = _classList[_index];
            _loc8_ = SkillEffectFactory.instance.getSkillMovie(_loc6_);
            _loc8_.x = _lastPoint.x + _loc3_ * (_loc7_ + 1);
            _loc8_.y = _lastPoint.y + _loc4_ * (_loc7_ + 1);
            _skillFlyLayer.addChild(_loc8_);
            _index = _index + 1;
            _loc7_++;
         }
         _lastPoint = _loc2_;
      }
      
      override public function update() : void
      {
      }
      
      private function calulateAngle(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param3 - param1;
         var _loc6_:Number = param4 - param2;
         var _loc8_:Number = Math.atan2(_loc6_,_loc5_);
         var _loc7_:Number = _loc8_ * 180 / 3.141592653589793;
         return (_loc7_ < 0 ? _loc7_ + 360 : _loc7_) + 180;
      }
      
      private function flyOver(param1:Object = null) : void
      {
         var _loc2_:Point = null;
         if(SceneManager.instance.currentType != "VEHICLE")
         {
            _finished = true;
            return;
         }
         if(param1)
         {
            _loc2_ = new Point(param1.x,param1.y);
            TweenMax.killTweensOf(param1);
            if(param1 is VehicleSkillMovie)
            {
               (param1 as VehicleSkillMovie).end();
            }
         }
         else
         {
            _loc2_ = new Point(_targetX,_targetY);
         }
         var _loc3_:VehicleSkillMovie = SkillEffectFactory.instance.createEndEffect(_useSkillInfo);
         if(_loc3_)
         {
            _loc3_.x = _loc2_.x;
            _loc3_.y = _loc2_.y;
            if(!_playSound)
            {
               _loc3_.setSoundTransform(VGlobal.volume0);
            }
            else
            {
               _loc3_.setSoundTransform(VGlobal.volume1);
            }
            _skillFlyLayer.addChild(_loc3_);
         }
         hurt();
         _finished = true;
      }
      
      private function hurt() : void
      {
         var _loc2_:* = null;
         var _loc3_:PlayerVehicleInfo = null;
         var _loc1_:VehicleNode = null;
         if(_useSkillInfo.casterId == VGlobal.playerInfo.userId && _model.selfVehicleInfo)
         {
            _model.selfVehicleInfo.dispatchEvent(new VehicleEvent("SKILL_SHOOT_OVER",_useSkillInfo));
         }
         for each(_loc2_ in _useSkillInfo.playerHurt)
         {
            _loc3_ = _model.getPlayerInfo(_loc2_.effectId);
            if(_loc3_)
            {
               _loc3_.beAtk(_loc2_);
            }
         }
         for each(_loc2_ in _useSkillInfo.npcHurt)
         {
            _loc1_ = _model.getNodeByNodeId(_loc2_.effectId);
            if(_loc1_)
            {
               _loc1_.beAtk(_loc2_);
            }
         }
      }
   }
}

