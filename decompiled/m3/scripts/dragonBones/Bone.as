package dragonBones
{
   import dragonBones.animation.Tween;
   import dragonBones.display.IDisplayBridge;
   import dragonBones.objects.BoneTransform;
   import dragonBones.utils.dragonBones_internal;
   import flash.events.EventDispatcher;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   
   use namespace dragonBones_internal;
   
   public class Bone extends EventDispatcher
   {
      
      public var name:String;
      
      public var userData:Object;
      
      public var global:BoneTransform;
      
      public var origin:BoneTransform;
      
      public var node:BoneTransform;
      
      dragonBones_internal var _tween:Tween;
      
      dragonBones_internal var _tweenNode:BoneTransform;
      
      dragonBones_internal var _tweenColorTransform:ColorTransform;
      
      dragonBones_internal var _visible:Boolean;
      
      dragonBones_internal var _children:Vector.<Bone>;
      
      dragonBones_internal var _displayBridge:IDisplayBridge;
      
      dragonBones_internal var _isOnStage:Boolean;
      
      dragonBones_internal var _armature:Armature;
      
      private var _globalTransformMatrix:Matrix;
      
      private var _displayList:Array;
      
      private var _displayIndex:int;
      
      private var _parent:Bone;
      
      private var _colorTransformChange:Boolean;
      
      private var _colorTransform:ColorTransform;
      
      private var _boneVisible:Object;
      
      private const MAX_DISPLAY:uint = 25;
      
      public function Bone(param1:IDisplayBridge)
      {
         super();
         this.origin = new BoneTransform();
         this.origin.scaleX = 1;
         this.origin.scaleY = 1;
         this.global = new BoneTransform();
         this.node = new BoneTransform();
         this._displayBridge = param1;
         this._children = new Vector.<Bone>();
         this._globalTransformMatrix = new Matrix();
         this._displayList = new Array(this.MAX_DISPLAY);
         this._displayIndex = -1;
         this._visible = true;
         this._tweenNode = new BoneTransform();
         this._tweenColorTransform = new ColorTransform();
         this._tween = new Tween(this);
      }
      
      public function set visible(param1:Object) : void
      {
         if(param1 == null)
         {
            this._boneVisible = param1;
         }
         else
         {
            this._boneVisible = Boolean(param1);
         }
      }
      
      public function get visible() : Object
      {
         return this._boneVisible;
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
      
      public function get armature() : Armature
      {
         return this._armature;
      }
      
      public function get childArmature() : Armature
      {
         return this._displayList[this._displayIndex] as Armature;
      }
      
      public function get parent() : Bone
      {
         return this._parent;
      }
      
      public function get display() : Object
      {
         return this._displayBridge.display;
      }
      
      public function set display(param1:Object) : void
      {
         if(this._displayBridge.display == param1)
         {
            return;
         }
         this._displayList[this._displayIndex] = param1;
         if(param1 is Armature)
         {
            param1 = (param1 as Armature).display;
         }
         this._displayBridge.display = param1;
      }
      
      public function get displayList() : Array
      {
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         if(this._displayList.length == this.MAX_DISPLAY)
         {
            _loc1_ = 0;
            _loc2_ = 0;
            while(_loc2_ < this.MAX_DISPLAY)
            {
               if(this._displayList[_loc2_])
               {
                  _loc1_++;
               }
               _loc2_++;
            }
            this._displayList.length = _loc1_;
         }
         return this._displayList;
      }
      
      dragonBones_internal function changeDisplay(param1:int) : void
      {
         var _loc3_:uint = 0;
         var _loc2_:Armature = this.childArmature;
         if(param1 < 0)
         {
            if(this._isOnStage)
            {
               this._isOnStage = false;
               this._displayBridge.removeDisplay();
               if(_loc2_)
               {
                  _loc2_.animation.stop();
                  _loc2_.animation.clearMovement();
               }
            }
         }
         else
         {
            if(!this._isOnStage)
            {
               this._isOnStage = true;
               if(this._armature)
               {
                  this._displayBridge.addDisplay(this._armature.display,this.global.z);
                  this._armature._bonesIndexChanged = true;
               }
               if(_loc2_)
               {
                  _loc2_.animation.play();
                  _loc2_.advanceTime(1);
               }
               this._tween._differentColorTransform = true;
            }
            if(this._displayIndex != param1)
            {
               _loc3_ = this._displayList.length;
               if(param1 >= _loc3_ && _loc3_ > 0)
               {
                  param1 = _loc3_ - 1;
               }
               this._displayIndex = param1;
               _loc2_ = this.childArmature;
               if(_loc2_)
               {
                  _loc2_.animation.clearMovement();
                  _loc2_.animation.play();
               }
               this.display = this._displayList[this._displayIndex];
            }
            if(Boolean(_loc2_) && !_loc2_.animation.isPlaying)
            {
               _loc2_.animation.play();
            }
         }
      }
      
      public function changeDisplayList(param1:Array) : void
      {
         var _loc2_:int = this._displayIndex;
         var _loc3_:uint = param1.length;
         this._displayList.length = _loc3_;
         var _loc4_:* = 0;
         while(_loc4_ < _loc3_)
         {
            this.changeDisplay(_loc4_);
            this.display = param1[_loc4_];
            _loc4_++;
         }
         this.changeDisplay(_loc2_);
      }
      
      public function dispose() : void
      {
         var _loc1_:Bone = null;
         for each(_loc1_ in this._children)
         {
            _loc1_.dispose();
         }
         this._displayList.length = 0;
         this._children.length = 0;
         this._armature = null;
         this._parent = null;
         this.userData = null;
      }
      
      public function contains(param1:Bone, param2:Boolean = false) : Boolean
      {
         var _loc3_:Bone = null;
         if(param2)
         {
            _loc3_ = this;
            while(_loc3_ != param1 && _loc3_ != null)
            {
               _loc3_ = _loc3_.parent;
            }
            if(_loc3_ == param1)
            {
               return true;
            }
            return false;
         }
         return param1.parent == this;
      }
      
      public function addChild(param1:Bone) : void
      {
         if(this._children.length > 0 ? this._children.indexOf(param1) < 0 : true)
         {
            param1.removeFromParent();
            this._children.push(param1);
            param1.setParent(this);
            if(this._armature)
            {
               this._armature.addToBones(param1);
            }
         }
      }
      
      public function removeChild(param1:Bone) : void
      {
         var _loc2_:int = this._children.indexOf(param1);
         if(_loc2_ >= 0)
         {
            if(this._armature)
            {
               this._armature.removeFromBones(param1);
            }
            param1.setParent(null);
            this._children.splice(_loc2_,1);
         }
      }
      
      public function removeFromParent() : void
      {
         if(this._parent)
         {
            this._parent.removeChild(this);
         }
      }
      
      dragonBones_internal function update() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Matrix = null;
         var _loc5_:* = 0;
         var _loc6_:ColorTransform = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         if(this._parent)
         {
            _loc2_ = this.origin.x + this.node.x + this._tweenNode.x;
            _loc3_ = this.origin.y + this.node.y + this._tweenNode.y;
            _loc4_ = this._parent._globalTransformMatrix;
            this._globalTransformMatrix.tx = this.global.x = _loc4_.a * _loc2_ + _loc4_.c * _loc3_ + _loc4_.tx;
            this._globalTransformMatrix.ty = this.global.y = _loc4_.d * _loc3_ + _loc4_.b * _loc2_ + _loc4_.ty;
            this.global.skewX = this._parent.global.skewX + this.origin.skewX + this.node.skewX + this._tweenNode.skewX;
            this.global.skewY = this._parent.global.skewY + this.origin.skewY + this.node.skewY + this._tweenNode.skewY;
         }
         else
         {
            this._globalTransformMatrix.tx = this.global.x = this.origin.x + this.node.x + this._tweenNode.x;
            this._globalTransformMatrix.ty = this.global.y = this.origin.y + this.node.y + this._tweenNode.y;
            this.global.skewX = this.origin.skewX + this.node.skewX + this._tweenNode.skewX;
            this.global.skewY = this.origin.skewY + this.node.skewY + this._tweenNode.skewY;
         }
         this.global.scaleX = this.origin.scaleX + this.node.scaleX + this._tweenNode.scaleX;
         this.global.scaleY = this.origin.scaleY + this.node.scaleY + this._tweenNode.scaleY;
         this.global.pivotX = this.origin.pivotX + this.node.pivotX + this._tweenNode.pivotX;
         this.global.pivotY = this.origin.pivotY + this.node.pivotY + this._tweenNode.pivotY;
         this.global.z = this.origin.z + this.node.z + this._tweenNode.z;
         this._globalTransformMatrix.a = this.global.scaleX * Math.cos(this.global.skewY);
         this._globalTransformMatrix.b = this.global.scaleX * Math.sin(this.global.skewY);
         this._globalTransformMatrix.c = -this.global.scaleY * Math.sin(this.global.skewX);
         this._globalTransformMatrix.d = this.global.scaleY * Math.cos(this.global.skewX);
         if(this._children.length > 0)
         {
            _loc5_ = int(this._children.length);
            while(_loc5_--)
            {
               this._children[_loc5_].update();
            }
         }
         var _loc1_:Object = this._displayBridge.display;
         if(_loc1_)
         {
            _loc7_ = this._tween.blendMode;
            _loc8_ = this._tween.arrFilter;
            if(_loc7_)
            {
               _loc1_.blendMode = _loc7_;
            }
            if(_loc1_.hasOwnProperty("filters"))
            {
               _loc1_.filters = _loc8_;
            }
            if(this._tween._differentColorTransform)
            {
               if(this._colorTransform)
               {
                  this._tweenColorTransform.concat(this._colorTransform);
               }
               if(this._armature.colorTransform)
               {
                  this._tweenColorTransform.concat(this._armature.colorTransform);
               }
               _loc6_ = this._tweenColorTransform;
            }
            else if(this._armature._colorTransformChange || this._colorTransformChange)
            {
               _loc6_ = this._colorTransform || this._armature.colorTransform;
               this._colorTransformChange = false;
            }
            this._displayBridge.update(this._globalTransformMatrix,this.global,_loc6_,this._boneVisible != null ? Boolean(this._boneVisible) : this._visible);
         }
      }
      
      private function setParent(param1:Bone) : void
      {
         if(Boolean(param1) && param1.contains(this,true))
         {
            throw new ArgumentError("An Bone cannot be added as a child to itself or one of its children (or children\'s children, etc.)");
         }
         this._parent = param1;
         if(this._parent)
         {
            this._isOnStage = this._parent._isOnStage;
         }
      }
   }
}

