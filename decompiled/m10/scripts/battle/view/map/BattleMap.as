package battle.view.map
{
   import battle.animation.AnimationManager;
   import battle.animation.IAnimation;
   import battle.animation.ISetAnimation;
   import battle.skillsys.effect.BattleEffect;
   import battle.skillsys.effect.EffectContainer;
   import battle.view.roles.RoleViewBase;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import yishi.interfaces.IPhysics;
   import yishi.manager.SharedManager;
   import yishi.utils.Shaker;
   import yishi.utils.TimerUtils;
   
   public class BattleMap extends BattleCameraScene
   {
      
      private var _animationManager:ISetAnimation;
      
      protected var _rolesContainer:Sprite;
      
      private var _roleBackContainer:EffectContainer;
      
      private var _profoundContainer:Sprite;
      
      protected var _rolesDict:Dictionary;
      
      private var _effectContainer:EffectContainer;
      
      private var _layerColorTransform:ColorTransform;
      
      private var _cameraTarget:Function;
      
      private var _offsetX:int = 0;
      
      private var _offsetY:int = 0;
      
      private var _moveCameraTween:TweenMax;
      
      private var _revertTimeoutId:uint;
      
      private var shake:Shaker;
      
      protected var _physics:Dictionary = new Dictionary(true);
      
      public function BattleMap()
      {
         super();
         _rolesContainer = new Sprite();
         _roleBackContainer = new EffectContainer();
         _roleBackContainer.mouseChildren = _roleBackContainer.mouseEnabled = false;
         _effectContainer = new EffectContainer();
         _effectContainer.mouseChildren = _effectContainer.mouseEnabled = false;
         _profoundContainer = new Sprite();
         addLayer(_roleBackContainer);
         addLayer(_profoundContainer);
         addLayer(_rolesContainer);
         addLayer(_effectContainer);
         _rolesDict = new Dictionary(true);
         _layerColorTransform = new ColorTransform();
         _animationManager = new AnimationManager(this,1000,600);
      }
      
      public function backGroundToColor(param1:uint = 0, param2:Number = 0.3, param3:Number = 0.5, param4:Boolean = false, param5:Boolean = false) : void
      {
         var element:Object;
         var color:uint = param1;
         var easeInOutTime:Number = param2;
         var stopTime:Number = param3;
         var now:Boolean = param4;
         var reversColor:Boolean = param5;
         var tweenLayers:Array = [];
         var a:int = reversColor ? -1 : 1;
         var rOff:int = ((color & 0xFF0000) >>> 16) * a;
         var gOff:int = ((color & 0xFF00) >>> 8) * a;
         var bOff:int = (color & 0xFF) * a;
         var updateFun:Function = function():void
         {
            for each(var _loc1_:DisplayObject in tweenLayers)
            {
               _loc1_.transform.colorTransform = _layerColorTransform;
            }
         };
         for(element in childLayerSettingMap)
         {
            if(element != _effectContainer && element != _rolesContainer && element != _profoundContainer)
            {
               tweenLayers.push(element);
            }
         }
         if(!now)
         {
            TweenLite.killTweensOf(_layerColorTransform);
            TweenLite.to(_layerColorTransform,easeInOutTime,{
               "redOffset":rOff,
               "greenOffset":gOff,
               "blueOffset":bOff,
               "onUpdate":updateFun
            });
            TweenLite.to(_layerColorTransform,easeInOutTime,{
               "redOffset":0,
               "greenOffset":0,
               "blueOffset":0,
               "delay":easeInOutTime + stopTime,
               "overwrite":0,
               "onUpdate":updateFun
            });
         }
         else
         {
            _layerColorTransform.redOffset = rOff;
            _layerColorTransform.greenOffset = gOff;
            _layerColorTransform.blueOffset = bOff;
            updateFun();
         }
      }
      
      public function backGroundToColorUseFrames(param1:uint, param2:int, param3:int, param4:int, param5:Boolean = false) : void
      {
         var element:Object;
         var updateFun:Function;
         var a:int;
         var rOff:int;
         var gOff:int;
         var bOff:int;
         var color:uint = param1;
         var easeInFrame:int = param2;
         var easeOutFrame:int = param3;
         var endFrame:int = param4;
         var reversColor:Boolean = param5;
         var tweenLayers:Array = [];
         for(element in childLayerSettingMap)
         {
            if(element != _effectContainer && element != _rolesContainer && element != _profoundContainer)
            {
               tweenLayers.push(element);
            }
         }
         updateFun = function():void
         {
            for each(var _loc1_:DisplayObject in tweenLayers)
            {
               _loc1_.transform.colorTransform = _layerColorTransform;
            }
         };
         a = reversColor ? -1 : 1;
         rOff = ((color & 0xFF0000) >>> 16) * a;
         gOff = ((color & 0xFF00) >>> 8) * a;
         bOff = (color & 0xFF) * a;
         TweenLite.to(_layerColorTransform,easeInFrame,{
            "useFrames":true,
            "redOffset":rOff,
            "greenOffset":gOff,
            "blueOffset":bOff,
            "onUpdate":updateFun
         });
         TweenLite.to(_layerColorTransform,endFrame - easeOutFrame,{
            "useFrames":true,
            "delay":easeOutFrame,
            "redOffset":0,
            "greenOffset":0,
            "blueOffset":0,
            "overwrite":0,
            "onUpdate":updateFun
         });
      }
      
      public function backGroundToColor2(param1:Number, param2:int) : void
      {
         var _loc3_:ColorMatrixFilter = null;
         var _loc4_:Array = [];
         _loc4_ = _loc4_.concat([param1,0,0,0,0]);
         _loc4_ = _loc4_.concat([0,param1,0,0,0]);
         _loc4_ = _loc4_.concat([0,0,param1,0,0]);
         _loc4_ = _loc4_.concat([0,0,0,1,0]);
         _loc3_ = new ColorMatrixFilter(_loc4_);
         for(var _loc5_:Object in childLayerSettingMap)
         {
            if(_loc5_ != _effectContainer && _loc5_ != _rolesContainer)
            {
               _loc5_.filters = [_loc3_];
            }
         }
         clearTimeout(_revertTimeoutId);
         TimerUtils.setTimeout(revertBackGroundColor,param2);
      }
      
      private function revertBackGroundColor() : void
      {
         clearTimeout(_revertTimeoutId);
         for(var _loc1_:Object in childLayerSettingMap)
         {
            if(_loc1_ != _effectContainer && _loc1_ != _rolesContainer)
            {
               _loc1_.filters = null;
            }
         }
      }
      
      public function set cameraTarget(param1:Function) : void
      {
         _cameraTarget = param1;
      }
      
      public function get cameraTarget() : Function
      {
         return _cameraTarget;
      }
      
      public function get rolesDict() : Dictionary
      {
         return _rolesDict;
      }
      
      public function get animationManager() : ISetAnimation
      {
         return _animationManager;
      }
      
      public function addAnimation(param1:IAnimation) : void
      {
         _animationManager.addAnimation(param1);
      }
      
      public function update() : void
      {
         if(_animationManager)
         {
            _animationManager.update();
         }
         if(_cameraTarget == null)
         {
            return;
         }
         var _loc2_:Point = _cameraTarget();
         var _loc3_:int = _loc2_.x + _offsetX;
         var _loc1_:int = _loc3_ - cameraX;
         if(Math.abs(_loc1_) < 20)
         {
            cameraX = _loc3_;
         }
         else
         {
            cameraX += _loc1_ / Math.abs(_loc1_) * 20;
         }
      }
      
      public function addRole(param1:RoleViewBase) : void
      {
      }
      
      public function toScenePoint(param1:DisplayObject) : Point
      {
         return effectContainer.globalToLocal(param1.parent.localToGlobal(new Point(param1.x,param1.y)));
      }
      
      public function removeRole(param1:int) : void
      {
      }
      
      public function moveCamera(param1:Point, param2:Number = 0.5, param3:Number = 0) : TweenMax
      {
         var _loc4_:Point = new Point(cameraX + param1.x,cameraY + param1.y);
         return setCamera(_loc4_,param2,param3);
      }
      
      public function setCamera(param1:Point, param2:Number = 0.5, param3:Number = 0) : TweenMax
      {
         _moveCameraTween = TweenMax.to(this,param2,{
            "cameraX":param1.x,
            "cameraY":param1.y,
            "overwrite":2,
            "delay":param3
         });
         return _moveCameraTween;
      }
      
      public function shakeScreen(param1:int = 5, param2:int = 7) : void
      {
         if(shake)
         {
            shake.stop();
         }
         shake = new Shaker(this,param1,param2);
      }
      
      public function addPhysics(param1:IPhysics) : void
      {
         _physics[param1] = param1;
      }
      
      public function removePhysics(param1:IPhysics) : void
      {
         delete _physics[param1];
      }
      
      public function get effectContainer() : EffectContainer
      {
         return _effectContainer;
      }
      
      public function set effectContainer(param1:EffectContainer) : void
      {
         _effectContainer = param1;
      }
      
      public function get roleBackContainer() : EffectContainer
      {
         return _roleBackContainer;
      }
      
      public function getProfoundLayer() : Sprite
      {
         return _profoundContainer;
      }
      
      public function addEffect(param1:BattleEffect, param2:int = 1, param3:int = 1) : void
      {
         if(!SharedManager.instance.allowAttactedEffect)
         {
            return;
         }
         if(param3 == 1)
         {
            _effectContainer.addEffect(param1,param2);
         }
         else
         {
            _roleBackContainer.addEffect(param1,param2);
         }
      }
      
      public function get rolesContainer() : Sprite
      {
         return _rolesContainer;
      }
      
      public function addSkillAimFlag(param1:Array) : void
      {
         var _loc3_:RoleViewBase = null;
         for each(var _loc2_:int in param1)
         {
            _loc3_ = rolesDict[_loc2_];
            if(_loc3_)
            {
               _loc3_.addSkillAimFlag();
            }
         }
      }
      
      override public function dispose() : void
      {
         for each(var _loc1_:RoleViewBase in _rolesDict)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _rolesDict = null;
         ObjectUtils.disposeObject(_rolesContainer);
         _rolesContainer = null;
         ObjectUtils.disposeObject(_effectContainer);
         _effectContainer = null;
         ObjectUtils.disposeObject(_roleBackContainer);
         _roleBackContainer = null;
         ObjectUtils.disposeObject(_profoundContainer);
         _profoundContainer = null;
         _animationManager = null;
         _cameraTarget = null;
         super.dispose();
      }
   }
}

