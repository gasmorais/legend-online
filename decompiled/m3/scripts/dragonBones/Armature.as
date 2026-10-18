package dragonBones
{
   import dragonBones.animation.Animation;
   import dragonBones.animation.IAnimatable;
   import dragonBones.events.ArmatureEvent;
   import dragonBones.utils.dragonBones_internal;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   
   use namespace dragonBones_internal;
   
   [Event(name="boneFrameEvent",type="dragonBones.events.FrameEvent")]
   [Event(name="movementFrameEvent",type="dragonBones.events.FrameEvent")]
   [Event(name="loopComplete",type="dragonBones.events.AnimationEvent")]
   [Event(name="complete",type="dragonBones.events.AnimationEvent")]
   [Event(name="start",type="dragonBones.events.AnimationEvent")]
   [Event(name="movementChange",type="dragonBones.events.AnimationEvent")]
   public class Armature extends EventDispatcher implements IAnimatable
   {
      
      private var _frameRate:int;
      
      private var _frameDurtion:Number;
      
      private var _currTime:int = 0;
      
      private var _scale:Number = 1;
      
      public var name:String;
      
      public var userData:Object;
      
      dragonBones_internal var _bonesIndexChanged:Boolean;
      
      dragonBones_internal var _boneDepthList:Vector.<Bone>;
      
      protected var _rootBoneList:Vector.<Bone>;
      
      dragonBones_internal var _colorTransformChange:Boolean;
      
      protected var _colorTransform:ColorTransform;
      
      protected var _display:Object;
      
      protected var _animation:Animation;
      
      public function Armature(param1:Object)
      {
         super();
         this._display = param1;
         this._boneDepthList = new Vector.<Bone>();
         this._rootBoneList = new Vector.<Bone>();
         this._animation = new Animation(this);
         this._bonesIndexChanged = false;
      }
      
      public function set colorTransform(param1:ColorTransform) : void
      {
         this._colorTransform = param1;
         this._colorTransformChange = true;
      }
      
      public function get colorTransform() : ColorTransform
      {
         return this._colorTransform;
      }
      
      public function get display() : Object
      {
         return this._display;
      }
      
      public function get animation() : Animation
      {
         return this._animation;
      }
      
      public function isUpdateFrame(param1:Number) : Number
      {
         ++this._currTime;
         if(this._currTime == 2)
         {
            this._currTime = 0;
            return this._frameDurtion;
         }
         return 0;
      }
      
      public function dispose() : void
      {
         var _loc1_:Bone = null;
         for each(_loc1_ in this._rootBoneList)
         {
            _loc1_.dispose();
         }
         this._boneDepthList.length = 0;
         this._rootBoneList.length = 0;
         this._animation.dispose();
         this._animation = null;
         this.userData = null;
         if(this._colorTransform)
         {
            this._colorTransform = null;
         }
      }
      
      public function getBone(param1:String) : Bone
      {
         var _loc2_:Bone = null;
         if(param1)
         {
            for each(_loc2_ in this._boneDepthList)
            {
               if(_loc2_.name == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getBoneByDisplay(param1:Object) : Bone
      {
         var _loc2_:Bone = null;
         if(param1)
         {
            for each(_loc2_ in this._boneDepthList)
            {
               if(_loc2_.display == param1)
               {
                  return _loc2_;
               }
            }
         }
         return null;
      }
      
      public function getBones() : Vector.<Bone>
      {
         return this._boneDepthList.concat();
      }
      
      public function addBone(param1:Bone, param2:String = null) : void
      {
         var _loc3_:Bone = null;
         if(param1)
         {
            _loc3_ = this.getBone(param2);
            if(_loc3_)
            {
               _loc3_.addChild(param1);
            }
            else
            {
               param1.removeFromParent();
               this.addToBones(param1,true);
            }
         }
      }
      
      public function removeBone(param1:Bone) : void
      {
         if(param1)
         {
            if(param1.parent)
            {
               param1.removeFromParent();
            }
            else
            {
               this.removeFromBones(param1);
            }
         }
      }
      
      public function removeBoneByName(param1:String) : void
      {
         var _loc2_:Bone = this.getBone(param1);
         this.removeBone(_loc2_);
      }
      
      public function advanceTime(param1:Number, param2:String = "", param3:int = 0) : void
      {
         var _loc5_:Bone = null;
         var _loc6_:Armature = null;
         if(this._animation.isPause)
         {
            return;
         }
         var _loc4_:* = int(this._boneDepthList.length);
         while(_loc4_--)
         {
            _loc5_ = this._boneDepthList[_loc4_];
            if(_loc5_._isOnStage)
            {
               _loc6_ = _loc5_.childArmature;
               if(_loc6_)
               {
                  _loc6_.advanceTime(param1,param2,param3);
               }
            }
         }
         this.animation.advanceTime(param1,param2,param3);
         this.update();
      }
      
      public function updateBonesZ() : void
      {
         var _loc1_:Bone = null;
         this._boneDepthList.sort(this.sortBoneZIndex);
         for each(_loc1_ in this._boneDepthList)
         {
            if(_loc1_._isOnStage)
            {
               _loc1_._displayBridge.addDisplay(this._display);
            }
         }
         this._bonesIndexChanged = false;
         if(hasEventListener(ArmatureEvent.Z_ORDER_UPDATED))
         {
            dispatchEvent(new ArmatureEvent(ArmatureEvent.Z_ORDER_UPDATED));
         }
      }
      
      dragonBones_internal function update() : void
      {
         var _loc1_:* = int(this._rootBoneList.length);
         while(_loc1_--)
         {
            this._rootBoneList[_loc1_].update();
         }
         this._colorTransformChange = false;
         if(this._bonesIndexChanged)
         {
            this.updateBonesZ();
         }
      }
      
      dragonBones_internal function addToBones(param1:Bone, param2:Boolean = false) : void
      {
         var _loc4_:Bone = null;
         var _loc3_:int = this._boneDepthList.indexOf(param1);
         if(_loc3_ < 0)
         {
            this._boneDepthList.push(param1);
         }
         _loc3_ = this._rootBoneList.indexOf(param1);
         if(param2)
         {
            if(_loc3_ < 0)
            {
               this._rootBoneList.push(param1);
            }
         }
         else if(_loc3_ >= 0)
         {
            this._rootBoneList.splice(_loc3_,1);
         }
         param1._armature = this;
         param1._displayBridge.addDisplay(this._display,param1.global.z);
         for each(_loc4_ in param1._children)
         {
            this.addToBones(_loc4_);
         }
         this._bonesIndexChanged = true;
      }
      
      dragonBones_internal function removeFromBones(param1:Bone) : void
      {
         var _loc3_:Bone = null;
         var _loc2_:int = this._boneDepthList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this._boneDepthList.splice(_loc2_,1);
         }
         _loc2_ = this._rootBoneList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            this._rootBoneList.splice(_loc2_,1);
         }
         param1._armature = null;
         param1._displayBridge.removeDisplay();
         for each(_loc3_ in param1._children)
         {
            this.removeFromBones(_loc3_);
         }
         this._bonesIndexChanged = true;
      }
      
      private function sortBoneZIndex(param1:Bone, param2:Bone) : int
      {
         return param1.global.z >= param2.global.z ? 1 : -1;
      }
      
      public function get frameRate() : int
      {
         return this._frameRate;
      }
      
      public function set frameRate(param1:int) : void
      {
         this._frameRate = param1;
         this._frameDurtion = 1 / this._frameRate;
      }
      
      public function set scale(param1:Number) : void
      {
         if(this._scale == param1 || param1 > 1 || param1 <= 0)
         {
            return;
         }
         this._scale = param1;
         if(this._display)
         {
            this._display.scaleX = this._scale;
            this._display.scaleY = this._scale;
         }
      }
   }
}

