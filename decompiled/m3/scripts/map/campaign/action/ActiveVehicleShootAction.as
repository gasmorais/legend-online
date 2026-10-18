package map.campaign.action
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import com.pickgliss.utils.SoundManager;
   import events.ArmyEvent;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.data.skill.MapSkillHurtData;
   import map.campaign.data.skill.MapSkillResultInfo;
   import map.campaign.helper.gvgcross.GvgCrossResourceManager;
   import map.campaign.view.physics.ActiveVehicleArmyView;
   import map.campaign.view.physics.physicsview.CampaignNpcView;
   import map.campaign.view.skill.MapSkillMovie;
   import map.internals.constant.MapGlobal;
   import map.internals.data.CampaignNode;
   import map.outercity.helper.mapview.MapViewHelper;
   import yishi.actions.map.MapBaseAction;
   import yishi.datas.templates.VehicleSkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   
   public class ActiveVehicleShootAction extends MapBaseAction
   {
      
      private var _useSkillInfo:MapSkillResultInfo;
      
      private var _skillTemplate:VehicleSkillTempInfo;
      
      private var _skillFlyLayer:Sprite;
      
      private var _model:CampaignMapModel;
      
      private var _targetPoint:Point;
      
      private var speed:Number = 1300;
      
      private var frame:int = 0;
      
      private var _shootPoint:Point;
      
      private var _playSound:Boolean = false;
      
      private var _controller:CampaignMapController;
      
      private var _classList:Array;
      
      private var _angle:Number;
      
      private var _shooter:Object;
      
      private var _shooterInfo:Object;
      
      private var _selfArmy:CampaignArmy;
      
      private var _startTime:int;
      
      private var _index:int = 0;
      
      private var _lastPoint:Point;
      
      private var flyMc:Object;
      
      public function ActiveVehicleShootAction(param1:Object, param2:MapSkillResultInfo)
      {
         super();
         if(CampaignManager.instance.mapView)
         {
            _skillFlyLayer = CampaignManager.instance.mapView.skillLayer;
         }
         _model = CampaignManager.instance.mapModel;
         _controller = CampaignManager.instance.controller;
         _shooterInfo = param1;
         _selfArmy = _model.selfMemberData;
         if(_controller)
         {
            if(_shooterInfo is CampaignArmy)
            {
               _shooter = _controller.getArmyView(CampaignArmy(_shooterInfo));
            }
            else if(_shooterInfo is CampaignNode)
            {
               _shooter = CampaignNode(_shooterInfo).nodeView;
            }
         }
         _useSkillInfo = param2;
         _skillTemplate = TempleteManager.instance.vehicleSkillTempteCate.getTemplateByTid(_useSkillInfo.skillId);
         for each(var _loc3_:MapSkillHurtData in _useSkillInfo.playerHurt)
         {
            if(_loc3_.effectId == _model.selfMemberData.userId)
            {
               _playSound = true;
            }
         }
         if(_useSkillInfo.casterId == _model.selfMemberData.userId)
         {
            _playSound = true;
         }
         if(!SoundManager.instance.allowSound)
         {
            _playSound = false;
         }
         _startTime = getTimer();
      }
      
      override public function dispose() : void
      {
         if(flyMc && !finished)
         {
            TweenMax.killTweensOf(flyMc);
         }
         flyMc = null;
         super.dispose();
         _model = null;
         _shooter = null;
         _shooterInfo = null;
         _skillFlyLayer = null;
         _skillTemplate = null;
         _useSkillInfo = null;
      }
      
      override public function prepare() : void
      {
         if(finished)
         {
            return;
         }
         if(!_shooter)
         {
            finished = true;
            return;
         }
         if(!_selfArmy)
         {
            finished = true;
            return;
         }
         if(!_skillTemplate)
         {
            finished = true;
            return;
         }
         if(_shooterInfo == _selfArmy)
         {
            _selfArmy.reduceActiveSkillCount(_skillTemplate.TemplateId);
         }
         _targetPoint = getTargetPos();
         _shooter.isAttack = true;
         _shooter.changeDirectionTo(_targetPoint.x,_targetPoint.y);
         _shootPoint = getShootStartPos();
         _shooter.isAttack = false;
         var _loc1_:Rectangle = MapViewHelper.getScreenRect(CampaignManager.instance.mapView);
         if(!_loc1_.containsPoint(_shootPoint) && !_loc1_.containsPoint(_targetPoint))
         {
            finished = true;
            return;
         }
         _angle = calulateAngle(_shootPoint.x,_shootPoint.y,_targetPoint.x,_targetPoint.y);
         playFlyMovie();
         playStartMovie(_shootPoint,_angle);
      }
      
      private function getTargetPos() : Point
      {
         var _loc3_:CampaignArmy = null;
         var _loc6_:ActiveVehicleArmyView = null;
         var _loc2_:CampaignNode = null;
         var _loc5_:CampaignNpcView = null;
         var _loc8_:int = 0;
         var _loc1_:String = null;
         var _loc7_:int = 0;
         var _loc4_:Point = new Point(_useSkillInfo.effectX,_useSkillInfo.effectY);
         if(_skillTemplate.InjuryEffect == 1)
         {
            if(_useSkillInfo.playerHurt.length > 0)
            {
               _loc8_ = int(_useSkillInfo.playerHurt[0].effectId);
               _loc1_ = _useSkillInfo.playerHurt[0].effectServiceName;
               _loc3_ = _model.getUserArmyByUserId(_loc8_,_loc1_);
               _loc6_ = _controller.getArmyView(_loc3_) as ActiveVehicleArmyView;
               if(_loc6_ && _loc3_.activeCurHp > 0)
               {
                  _loc4_ = _loc6_.getHitPoint();
               }
            }
            else if(_useSkillInfo.npcHurt.length > 0)
            {
               _loc7_ = int(_useSkillInfo.npcHurt[0].effectId);
               _loc2_ = _model.getMapNodeByNodeId(_loc7_);
               if(_loc2_)
               {
                  _loc5_ = _loc2_.nodeView as CampaignNpcView;
               }
               if(_loc5_)
               {
                  _loc4_ = _loc5_.getHitPoint();
               }
            }
         }
         return _loc4_;
      }
      
      private function getShootStartPos() : Point
      {
         return _shooter.getShootPoint();
      }
      
      private function calulateAngle(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param3 - param1;
         var _loc6_:Number = param4 - param2;
         var _loc8_:Number = Math.atan2(_loc6_,_loc5_);
         var _loc7_:Number = _loc8_ * 180 / 3.141592653589793;
         return (_loc7_ < 0 ? _loc7_ + 360 : _loc7_) + 180;
      }
      
      private function playStartMovie(param1:Point, param2:Number) : void
      {
         var _loc3_:MapSkillMovie = GvgCrossResourceManager.instance.createStartEffect(_useSkillInfo.skillTemplate.ActionId);
         if(_loc3_)
         {
            _loc3_.x = param1.x;
            _loc3_.y = param1.y;
            _loc3_.rotation = param2;
            _skillFlyLayer.addChild(_loc3_);
            if(!_playSound)
            {
               _loc3_.setSoundTransform(MapGlobal.volume0);
            }
            else
            {
               _loc3_.setSoundTransform(MapGlobal.volume1);
            }
         }
      }
      
      private function playFlyMovie() : void
      {
         _classList = GvgCrossResourceManager.instance.getFlyClassArray(_useSkillInfo.skillTemplate.ActionId);
         var _loc1_:int = int(_classList.length);
         var _loc3_:Number = Point.distance(_shootPoint,_targetPoint);
         var _loc2_:Number = _loc3_ / speed;
         if(_loc1_ == 1)
         {
            flyMc = GvgCrossResourceManager.instance.getSkillMovieFromPool(_classList[0]);
            (flyMc as MapSkillMovie).autoDispose = false;
            _skillFlyLayer.addChild(flyMc as MapSkillMovie);
         }
         else
         {
            flyMc = {};
         }
         _lastPoint = _shootPoint.clone();
         flyMc.rotation = _angle;
         flyMc.x = _shootPoint.x;
         flyMc.y = _shootPoint.y;
         if(flyMc.hasOwnProperty("type") && flyMc["type"] == 1)
         {
            flyMc.rotation = _angle - 180;
            (flyMc as MapSkillMovie).setSkillWidth(_loc3_ + 50);
            (flyMc as MapSkillMovie).autoDispose = true;
            flyOver();
         }
         else
         {
            TweenMax.to(flyMc,_loc2_,{
               "ease":Linear.easeNone,
               "x":_targetPoint.x,
               "y":_targetPoint.y,
               "onUpdate":updateFlyMc,
               "onUpdateParams":[flyMc],
               "onComplete":flyOver,
               "onCompleteParams":[flyMc]
            });
         }
      }
      
      private function updateFlyMc(param1:Object) : void
      {
         var _loc7_:int = 0;
         var _loc6_:String = null;
         var _loc8_:MapSkillMovie = null;
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
            _loc8_ = GvgCrossResourceManager.instance.getSkillMovieFromPool(_loc6_);
            _loc8_.x = _lastPoint.x + _loc3_ * (_loc7_ + 1);
            _loc8_.y = _lastPoint.y + _loc4_ * (_loc7_ + 1);
            _skillFlyLayer.addChild(_loc8_);
            _index = _index + 1;
            _loc7_++;
         }
         _lastPoint = _loc2_;
      }
      
      private function flyOver(param1:Object = null) : void
      {
         var _loc2_:Point = null;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            finished = true;
            return;
         }
         if(param1)
         {
            _loc2_ = new Point(param1.x,param1.y);
            TweenMax.killTweensOf(param1);
            if(param1 is MapSkillMovie)
            {
               (param1 as MapSkillMovie).end();
            }
         }
         else
         {
            _loc2_ = _targetPoint.clone();
         }
         var _loc3_:MapSkillMovie = GvgCrossResourceManager.instance.createEndEffect(_useSkillInfo.skillTemplate.ActionId);
         if(_loc3_)
         {
            _loc3_.x = _loc2_.x;
            _loc3_.y = _loc2_.y;
            if(!_playSound)
            {
               _loc3_.setSoundTransform(MapGlobal.volume0);
            }
            else
            {
               _loc3_.setSoundTransform(MapGlobal.volume1);
            }
            _skillFlyLayer.addChild(_loc3_);
         }
         hurt();
         finished = true;
      }
      
      private function hurt() : void
      {
         var _loc2_:* = null;
         var _loc3_:CampaignArmy = null;
         var _loc1_:CampaignNode = null;
         if(_shooterInfo == _model.selfMemberData)
         {
            _shooterInfo.dispatchEvent(new ArmyEvent("SKILL_SHOOT_OVER",_useSkillInfo));
         }
         for each(_loc2_ in _useSkillInfo.playerHurt)
         {
            _loc3_ = _model.getUserArmyByUserId(_loc2_.effectId,_loc2_.effectServiceName);
            if(_loc3_)
            {
               _loc3_.beHurt(_loc2_);
            }
         }
         for each(_loc2_ in _useSkillInfo.npcHurt)
         {
            _loc1_ = _model.getMapNodeByNodeId(_loc2_.effectId);
            if(_loc1_)
            {
               _loc1_.beHurt(_loc2_);
            }
         }
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            finished = true;
         }
         if(getTimer() - _startTime > 1500)
         {
            if(flyMc)
            {
               if(_useSkillInfo)
               {
                  flyOver(flyMc);
               }
               else
               {
                  TweenMax.killTweensOf(flyMc);
                  if(flyMc is MapSkillMovie)
                  {
                     (flyMc as MapSkillMovie).end();
                  }
                  finished = true;
               }
            }
            else
            {
               finished = true;
            }
         }
         super.update();
      }
   }
}

