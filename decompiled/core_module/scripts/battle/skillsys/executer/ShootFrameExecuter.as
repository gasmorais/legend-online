package battle.skillsys.executer
{
   import battle.BattleManager;
   import battle.actions.DannyAction;
   import battle.data.AttackData;
   import battle.logsys.BattleLogSystem;
   import battle.skillsys.effect.ArrowSkillEffect;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.SkillEffect;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.skillsys.ripple.RipplePreCreater;
   import battle.skillsys.skills.BaseSkill;
   import battle.view.roles.RoleViewBase;
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import yishi.datas.BattleModel;
   import yishi.datas.battle.ResistModel;
   import yishi.datas.objects.RoleInfo;
   import yishi.view.tools.SimpleBitmapMovieClip;
   
   public class ShootFrameExecuter
   {
      
      private var _skill:BaseSkill;
      
      private var _frameData:SkillFrameData;
      
      private var _attackIndex:int;
      
      private var _completeFun:Function;
      
      private var _shootCount:int;
      
      private var _startPoint:Point;
      
      private var _attackData:Array;
      
      public function ShootFrameExecuter(param1:BaseSkill, param2:SkillFrameData, param3:int, param4:Function)
      {
         super();
         _skill = param1;
         _frameData = param2;
         _attackIndex = param3;
         _completeFun = param4;
         _startPoint = new Point(0,-85);
         _attackData = _skill.getSkillData().data[_attackIndex];
         execute();
      }
      
      private function execute() : void
      {
         var _loc5_:Number = NaN;
         var _loc7_:RoleInfo = null;
         var _loc3_:ArrowSkillEffect = null;
         var _loc2_:Number = NaN;
         var _loc1_:Point = null;
         var _loc4_:Number = NaN;
         if(_frameData.shootData.rippleRes && _frameData.shootData.rippleRes != "")
         {
            RipplePreCreater.addRippleId(_frameData.shootData.rippleRes);
         }
         for each(var _loc6_:AttackData in _attackData)
         {
            _loc7_ = BattleManager.getInstance().battleModel.getRoleById(_loc6_.roleId);
            if(_loc7_ != null)
            {
               if(BattleManager.getInstance().battleModel.isHideOtherInBattle(_skill.getCurrentRole()))
               {
                  onHit(null,_loc7_,_loc6_);
               }
               else
               {
                  _loc3_ = new ArrowSkillEffect(_frameData.shootData.arrowRes);
                  _skill.getCurrentRole().map.effectContainer.addEffect(_loc3_,-1);
                  _loc3_.startPoint = new Point();
                  _loc3_.travelPoints = new Vector.<Point>();
                  _loc3_.travelPoints.push(_loc3_.startPoint);
                  _loc3_.lastPoint = _loc3_.startPoint;
                  _loc3_.startPoint.x = _loc3_.getDisplayObject().x = _skill.getCurrentRole().point.x + _startPoint.x;
                  _loc3_.startPoint.y = _loc3_.getDisplayObject().y = _skill.getCurrentRole().point.y + _startPoint.y;
                  _loc2_ = Point.distance(_loc3_.startPoint,_loc7_.point);
                  _loc5_ = _loc2_ / (_frameData.shootData.speed * 25);
                  if(_frameData.shootData.flyType == 1)
                  {
                     TweenMax.to(_loc3_.getDisplayObject(),_loc5_,{
                        "bezier":[{
                           "x":_loc7_.point.x,
                           "y":_loc7_.point.y - 70
                        }],
                        "orientToBezier":true,
                        "onCompleteParams":[_loc3_,_loc7_,_loc6_],
                        "onComplete":onHit,
                        "ease":Linear.easeNone,
                        "onUpdate":onArrowUpate,
                        "onUpdateParams":[_loc3_]
                     });
                  }
                  else
                  {
                     _loc1_ = Point.interpolate(_loc3_.startPoint,_loc7_.point,0.5);
                     _loc4_ = _loc2_ / 1000 * _frameData.shootData.curve;
                     TweenMax.to(_loc3_.getDisplayObject(),_loc5_,{
                        "bezier":[{
                           "x":_loc1_.x,
                           "y":_loc1_.y - _loc4_
                        },{
                           "x":_loc7_.point.x,
                           "y":_loc7_.point.y - 100
                        }],
                        "orientToBezier":true,
                        "onCompleteParams":[_loc3_,_loc7_,_loc6_],
                        "onComplete":onHit,
                        "ease":Linear.easeNone,
                        "onUpdate":onArrowUpate,
                        "onUpdateParams":[_loc3_]
                     });
                  }
               }
            }
         }
      }
      
      private function onArrowUpate(param1:ArrowSkillEffect) : void
      {
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc4_:Point = null;
         var _loc7_:int = 0;
         var _loc5_:MovieClip = null;
         var _loc2_:SimpleBitmapMovieClip = null;
         if(_frameData.shootData.rippleRes && _frameData.shootData.rippleRes != "")
         {
            _loc6_ = getCurrentRipple(param1);
            if(param1.rippleCount < _loc6_)
            {
               _loc7_ = param1.rippleCount + 1;
               while(_loc7_ <= _loc6_)
               {
                  if(!BattleManager.getInstance().battleModel.isHideOtherInBattle(_skill.getCurrentRole()))
                  {
                     _loc5_ = BattleManager.getInstance().resourceModel.getOrCreateInstanse(_frameData.shootData.rippleRes) as MovieClip;
                     _loc2_ = new SimpleBitmapMovieClip(_loc5_,_frameData.shootData.rippleRes,true,false);
                     _loc4_ = getRipplePos(param1,_loc7_);
                     _loc2_.blendMode = "screen";
                     _loc2_.x = _loc4_.x;
                     _loc2_.y = _loc4_.y;
                     _skill.getCurrentRole().map.effectContainer.addChild(_loc2_);
                     new RippleEffectProxy(_loc2_);
                  }
                  _loc7_++;
               }
               param1.rippleCount = _loc6_;
               param1.lastPoint = new Point(param1.getDisplayObject().x,param1.getDisplayObject().y);
            }
         }
      }
      
      private function getCurrentRipple(param1:ArrowSkillEffect) : int
      {
         var _loc2_:Number = param1.travelDistance;
         var _loc3_:Point = new Point(param1.getDisplayObject().x,param1.getDisplayObject().y);
         _loc2_ += Point.distance(_loc3_,param1.lastPoint);
         var _loc4_:int = Math.floor(_loc2_ / _frameData.shootData.rippleGap);
         param1.travelDistance = _loc2_;
         return _loc4_;
      }
      
      private function getRipplePos(param1:ArrowSkillEffect, param2:int) : Point
      {
         var _loc3_:Point = new Point(param1.getDisplayObject().x,param1.getDisplayObject().y);
         var _loc6_:Number = Point.distance(_loc3_,param1.lastPoint);
         var _loc4_:Point = new Point();
         var _loc7_:Number = _frameData.shootData.rippleGap * param2 - param1.travelDistance + _loc6_;
         var _loc5_:Number = Math.atan2(_loc3_.y - param1.lastPoint.y,_loc3_.x - param1.lastPoint.x);
         _loc4_.x = param1.lastPoint.x + Math.cos(_loc5_) * _loc7_;
         _loc4_.y = param1.lastPoint.y + Math.sin(_loc5_) * _loc7_;
         return _loc4_;
      }
      
      private function onHit(param1:BattleEffect, param2:RoleInfo, param3:AttackData) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc9_:Boolean = false;
         var _loc8_:BattleEffect = null;
         if(param1)
         {
            _loc5_ = param1.getDisplayObject();
            if(_loc5_)
            {
               TweenMax.killTweensOf(_loc5_);
            }
         }
         var _loc7_:BattleModel = BattleManager.getInstance().battleModel;
         if(!_loc7_)
         {
            return;
         }
         BattleLogSystem.skillDannyFlag(_skill);
         if(_skill.getCurrentRole() == BattleManager.getInstance().battleModel.selfHero)
         {
            _loc9_ = true;
         }
         var _loc4_:ResistModel = BattleManager.getInstance().resistModel;
         _loc4_.attackOver = false;
         var _loc6_:RoleViewBase = RoleViewBase(BattleManager.getInstance().battleMap.rolesDict[param3.roleId]);
         if(_loc6_ && _loc6_.info && !_loc7_.isHideOtherInBattle(_loc6_.info))
         {
            _loc8_ = new SkillEffect(_frameData.shootData.dannyRes);
            _loc8_.getDisplayObject().y = -70;
            _loc6_.effectContainer.addEffect(_loc8_);
         }
         new DannyAction(param2,param3,12,true,50,0,4,true,6710886,true,_loc9_,_skill.getSkillData().skillId);
         _loc4_.currentResistSide = param2.side == _loc7_.selfSide ? 1 : 2;
         _loc4_.resistTotal = param3.resiPercent;
         if(_loc7_.selfHero.livingId != param3.fId && _loc7_.selfHero.livingId != param3.roleId)
         {
            _loc4_.resistTotal = 0;
         }
         if(_loc4_.resistTotal != 0)
         {
            _loc4_.attackOver = true;
         }
         else
         {
            _loc4_.attackOver = false;
         }
         _skill.getCurrentRole().map.effectContainer.removeEffect(param1);
         _shootCount = _shootCount + 1;
         if(_shootCount >= _attackData.length)
         {
            if(_completeFun != null)
            {
               _completeFun();
            }
            _completeFun = null;
            _frameData = null;
            _skill = null;
         }
      }
   }
}

import yishi.view.tools.SimpleBitmapMovieClip;

class RippleEffectProxy
{
   
   private var _movie:SimpleBitmapMovieClip;
   
   public function RippleEffectProxy(param1:SimpleBitmapMovieClip)
   {
      super();
      _movie = param1;
      _movie.addFrameScript(_movie.totalFrames,endFun);
   }
   
   private function endFun() : void
   {
      if(_movie && _movie.parent)
      {
         _movie.parent.removeChild(_movie);
      }
      _movie.dispose();
      _movie = null;
   }
}
