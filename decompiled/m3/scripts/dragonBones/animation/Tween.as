package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.display.NativeDisplayBridge;
   import dragonBones.events.FrameEvent;
   import dragonBones.events.SoundEvent;
   import dragonBones.events.SoundEventManager;
   import dragonBones.objects.BoneTransform;
   import dragonBones.objects.FrameData;
   import dragonBones.objects.MovementBoneData;
   import dragonBones.utils.ColorMatrix;
   import dragonBones.utils.TransformUtils;
   import dragonBones.utils.dragonBones_internal;
   import flash.filters.BevelFilter;
   import flash.filters.BlurFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientBevelFilter;
   import flash.filters.GradientGlowFilter;
   import flash.geom.ColorTransform;
   import starling.filters.BlurFilter;
   import starling.filters.FragmentFilterMode;
   
   use namespace dragonBones_internal;
   
   public final class Tween
   {
      
      private static const HALF_PI:Number = Math.PI * 0.5;
      
      private static var _soundManager:SoundEventManager = SoundEventManager.getInstance();
      
      private var _bone:Bone;
      
      private var _movementBoneData:MovementBoneData;
      
      private var _node:BoneTransform;
      
      private var _colorTransform:ColorTransform;
      
      private var _blendMode:String;
      
      private var _arrFilter:Array;
      
      private var _currentNode:BoneTransform;
      
      private var _currentColorTransform:ColorTransform;
      
      private var _offSetNode:BoneTransform;
      
      private var _offSetColorTransform:ColorTransform;
      
      private var _currentFrameData:FrameData;
      
      private var _tweenEasing:Number;
      
      private var _frameTweenEasing:Number;
      
      private var _isPause:Boolean;
      
      private var _rawDuration:Number;
      
      private var _nextFrameDataTimeEdge:Number;
      
      private var _frameDuration:Number;
      
      private var _nextFrameDataID:int;
      
      private var _loop:int;
      
      dragonBones_internal var _differentColorTransform:Boolean;
      
      public function Tween(param1:Bone)
      {
         super();
         this._bone = param1;
         this._node = this._bone._tweenNode;
         this._colorTransform = this._bone._tweenColorTransform;
         this._currentNode = new BoneTransform();
         this._currentColorTransform = new ColorTransform();
         this._offSetNode = new BoneTransform();
         this._offSetColorTransform = new ColorTransform();
      }
      
      public static function getEaseValue(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = 0;
         if(isNaN(param2))
         {
            return _loc3_;
         }
         if(param2 > 1)
         {
            _loc3_ = 0.5 * (1 - Math.cos(param1 * Math.PI)) - param1;
            param2 -= 1;
         }
         else if(param2 > 0)
         {
            _loc3_ = Math.sin(param1 * HALF_PI) - param1;
         }
         else if(param2 < 0)
         {
            _loc3_ = 1 - Math.cos(param1 * HALF_PI) - param1;
            param2 *= -1;
         }
         return _loc3_ * param2 + param1;
      }
      
      internal function gotoAndPlay(param1:MovementBoneData, param2:Number, param3:Boolean, param4:Number) : void
      {
         var _loc6_:FrameData = null;
         if(!param1)
         {
            return;
         }
         this._movementBoneData = param1;
         var _loc5_:uint = this._movementBoneData._frameList.length;
         if(_loc5_ == 0)
         {
            this._bone.changeDisplay(-1);
            this.stop();
            return;
         }
         this._node.skewX %= Math.PI * 2;
         this._node.skewY %= Math.PI * 2;
         this._isPause = false;
         this._currentFrameData = null;
         this._loop = param3 ? 0 : -1;
         this._nextFrameDataTimeEdge = 0;
         this._nextFrameDataID = 0;
         this._rawDuration = param2;
         this._tweenEasing = param4;
         if(_loc5_ == 1)
         {
            this._frameTweenEasing = 1;
            this._rawDuration = 0;
            _loc6_ = this._movementBoneData._frameList[0];
            this.setOffset(this._bone._isOnStage ? this._node : _loc6_.node,this._colorTransform,_loc6_.node,_loc6_.colorTransform);
         }
         else if(param3 && this._movementBoneData.delay != 0)
         {
            this.getLoopListNode();
            this.setOffset(this._bone._isOnStage ? this._node : this._offSetNode,this._colorTransform,this._offSetNode,this._offSetColorTransform);
         }
         else
         {
            this._frameTweenEasing = 1;
            _loc6_ = this._movementBoneData._frameList[0];
            this.setOffset(this._bone._isOnStage ? this._node : _loc6_.node,this._colorTransform,_loc6_.node,_loc6_.colorTransform);
         }
         if(Boolean(_loc6_) && !this._bone._isOnStage)
         {
            this.updateBoneDisplayIndex(_loc6_);
         }
      }
      
      private function getLoopListNode() : void
      {
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc1_:Number = this._rawDuration * this._movementBoneData.delay;
         var _loc2_:int = int(this._movementBoneData._frameList.length);
         var _loc3_:int = 0;
         var _loc4_:Number = 0;
         do
         {
            _loc9_ = _loc3_;
            _loc10_ = this._movementBoneData._frameList[_loc9_].duration;
            _loc4_ += _loc10_;
            if(++_loc3_ >= _loc2_)
            {
               _loc3_ = 0;
            }
         }
         while(_loc1_ >= _loc4_);
         var _loc5_:FrameData = this._movementBoneData._frameList[_loc9_];
         var _loc6_:FrameData = this._movementBoneData._frameList[_loc3_];
         if(_loc6_.displayIndex >= 0 && this._bone.armature.animation.tweenEnabled)
         {
            this._frameTweenEasing = _loc5_.tweenEasing;
         }
         else
         {
            this._frameTweenEasing = NaN;
         }
         this.setOffset(_loc5_.node,_loc5_.colorTransform,_loc6_.node,_loc6_.colorTransform);
         var _loc7_:Number = 1 - (_loc4_ - _loc1_) / _loc10_;
         var _loc8_:Number = isNaN(this._tweenEasing) ? _loc5_.tweenEasing : this._tweenEasing;
         if(_loc8_)
         {
            _loc7_ = getEaseValue(_loc7_,_loc8_);
         }
         TransformUtils.setOffSetNode(_loc5_.node,_loc6_.node,this._offSetNode);
         TransformUtils.setTweenNode(this._currentNode,this._offSetNode,this._offSetNode,_loc7_);
         TransformUtils.setOffSetColorTransform(_loc5_.colorTransform,_loc6_.colorTransform,this._offSetColorTransform);
         TransformUtils.setTweenColorTransform(this._currentColorTransform,this._offSetColorTransform,this._offSetColorTransform,_loc7_);
      }
      
      internal function stop() : void
      {
         this._isPause = true;
      }
      
      internal function advanceTime(param1:Number, param2:int, param3:String = "", param4:int = 0) : void
      {
         if(this._isPause || !this._movementBoneData)
         {
            return;
         }
         var _loc5_:int = param1;
         if(this._rawDuration == 0)
         {
            param1 /= this._movementBoneData.scale;
            param1 += this._movementBoneData.delay;
            if(this._loop != _loc5_)
            {
               this._nextFrameDataTimeEdge = 0;
               this._nextFrameDataID = 0;
               this._loop = _loc5_;
            }
            param1 -= _loc5_;
            param1 = this.updateFrameData(param1,false,param3,param4);
         }
         if(param2 == Animation.LOOP)
         {
            param1 /= this._movementBoneData.scale;
            param1 += this._movementBoneData.delay;
            param1 += 0.00001;
            _loc5_ = param1;
            if(this._loop != _loc5_)
            {
               this._nextFrameDataTimeEdge = 0;
               this._nextFrameDataID = 0;
               this._loop = _loc5_;
            }
            param1 -= _loc5_;
            param1 = this.updateFrameData(param1,false,param3,param4);
         }
         else if(param2 == Animation.LIST)
         {
            param1 = this.updateFrameData(param1,true,param3,param4);
         }
         else if(param2 == Animation.SINGLE && param1 == 1)
         {
            this._currentFrameData = this._movementBoneData._frameList[0];
            this._isPause = true;
         }
         else
         {
            param1 = Math.sin(param1 * HALF_PI);
         }
         if(!isNaN(this._frameTweenEasing) || Boolean(this._currentFrameData))
         {
            TransformUtils.setTweenNode(this._currentNode,this._offSetNode,this._node,param1);
            if(this._differentColorTransform)
            {
               TransformUtils.setTweenColorTransform(this._currentColorTransform,this._offSetColorTransform,this._colorTransform,param1);
            }
         }
         if(this._currentFrameData)
         {
            this.arriveFrameData(this._currentFrameData);
            this._currentFrameData = null;
         }
      }
      
      private function setOffset(param1:BoneTransform, param2:ColorTransform, param3:BoneTransform, param4:ColorTransform, param5:int = 0) : void
      {
         this._currentNode.copy(param1);
         TransformUtils.setOffSetNode(this._currentNode,param3,this._offSetNode,param5);
         this._currentColorTransform.alphaOffset = param2.alphaOffset;
         this._currentColorTransform.redOffset = param2.redOffset;
         this._currentColorTransform.greenOffset = param2.greenOffset;
         this._currentColorTransform.blueOffset = param2.blueOffset;
         this._currentColorTransform.alphaMultiplier = param2.alphaMultiplier;
         this._currentColorTransform.redMultiplier = param2.redMultiplier;
         this._currentColorTransform.greenMultiplier = param2.greenMultiplier;
         this._currentColorTransform.blueMultiplier = param2.blueMultiplier;
         TransformUtils.setOffSetColorTransform(this._currentColorTransform,param4,this._offSetColorTransform);
         if(this._offSetColorTransform.alphaOffset != 0 || this._offSetColorTransform.redOffset != 0 || this._offSetColorTransform.greenOffset != 0 || this._offSetColorTransform.blueOffset != 0 || this._offSetColorTransform.alphaMultiplier != 0 || this._offSetColorTransform.redMultiplier != 0 || this._offSetColorTransform.greenMultiplier != 0 || this._offSetColorTransform.blueMultiplier != 0)
         {
            this._differentColorTransform = true;
         }
         else
         {
            this._differentColorTransform = false;
         }
      }
      
      private function updateBoneDisplayIndex(param1:FrameData) : void
      {
         var _loc2_:int = param1.displayIndex;
         if(_loc2_ >= 0)
         {
            if(this._node.z != param1.node.z)
            {
               this._node.z = param1.node.z;
               if(this._bone.armature)
               {
                  this._bone.armature._bonesIndexChanged = true;
               }
            }
         }
         this._bone.changeDisplay(_loc2_);
      }
      
      private function arriveFrameData(param1:FrameData) : void
      {
         var _loc2_:FrameEvent = null;
         var _loc3_:SoundEvent = null;
         var _loc4_:Armature = null;
         this.updateBoneDisplayIndex(param1);
         this._bone._visible = param1.visible;
         if(Boolean(param1.event) && this._bone._armature.hasEventListener(FrameEvent.BONE_FRAME_EVENT))
         {
            _loc2_ = new FrameEvent(FrameEvent.BONE_FRAME_EVENT,false,this._bone);
            _loc2_.movementID = this._bone._armature.animation.movementID;
            _loc2_.frameLabel = param1.event;
            this._bone._armature.dispatchEvent(_loc2_);
         }
         if(Boolean(param1.sound) && _soundManager.hasEventListener(SoundEvent.SOUND))
         {
            _loc3_ = new SoundEvent(SoundEvent.SOUND);
            _loc3_.movementID = this._bone._armature.animation.movementID;
            _loc3_.sound = param1.sound;
            _loc3_._armature = this._bone._armature;
            _loc3_._bone = this._bone;
            _soundManager.dispatchEvent(_loc3_);
         }
         if(param1.movement)
         {
            _loc4_ = this._bone.childArmature;
            if(_loc4_)
            {
               _loc4_.animation.gotoAndPlay(param1.movement,-1,-1,null,true);
            }
         }
      }
      
      private function updateFrameData(param1:Number, param2:Boolean = false, param3:String = "", param4:int = 0) : Number
      {
         var _loc9_:int = 0;
         var _loc10_:FrameData = null;
         var _loc11_:FrameData = null;
         var _loc12_:int = 0;
         var _loc5_:String = this._movementBoneData._frameList[this._nextFrameDataID].label;
         var _loc6_:Number = this._rawDuration * param1;
         var _loc7_:Boolean = _loc6_ < this._nextFrameDataTimeEdge && this._nextFrameDataTimeEdge - _loc6_ < 0.0001;
         if(_loc6_ >= this._nextFrameDataTimeEdge || _loc7_)
         {
            _loc9_ = int(this._movementBoneData._frameList.length);
            do
            {
               if(this._bone.name == param3 && param4 != -1)
               {
                  this._nextFrameDataID = param4 % _loc9_;
               }
               _loc12_ = this._nextFrameDataID;
               this._frameDuration = this._movementBoneData._frameList[_loc12_].duration;
               this._nextFrameDataTimeEdge += this._frameDuration;
               if(!(this._bone.name == param3 && param4 != -1))
               {
                  if(++this._nextFrameDataID >= _loc9_)
                  {
                     this._nextFrameDataID = 0;
                  }
               }
               this._arrFilter = this._movementBoneData._frameList[_loc12_].filterAbleArr;
               if(!this._arrFilter)
               {
                  this._arrFilter = this.getFilters(this._movementBoneData._frameList[_loc12_].filterArr);
                  this._movementBoneData._frameList[_loc12_].filterAbleArr = this._arrFilter;
               }
               this._blendMode = this._movementBoneData._frameList[_loc12_].blendMode;
               if(_loc5_ != "" && this._bone.childArmature != null)
               {
                  this._bone.childArmature.animation.gotoAndPlay(_loc5_);
               }
            }
            while(_loc6_ >= this._nextFrameDataTimeEdge);
            _loc10_ = this._movementBoneData._frameList[_loc12_];
            _loc11_ = this._movementBoneData._frameList[this._nextFrameDataID];
            if(_loc11_.displayIndex >= 0 && this._bone.armature.animation.tweenEnabled)
            {
               this._frameTweenEasing = _loc10_.tweenEasing;
            }
            else
            {
               this._frameTweenEasing = NaN;
            }
            this.setOffset(_loc10_.node,_loc10_.colorTransform,_loc11_.node,_loc11_.colorTransform,_loc11_.tweenRotate);
            this._currentFrameData = _loc10_;
            if(_loc12_ == 0 || _loc12_ == _loc9_ - 1)
            {
               this._differentColorTransform = true;
            }
            if(param2 && this._nextFrameDataID == 0)
            {
               this._isPause = true;
               return 0;
            }
         }
         param1 = 1 - (this._nextFrameDataTimeEdge - _loc6_) / this._frameDuration;
         var _loc8_:Number = isNaN(this._tweenEasing) ? this._frameTweenEasing : this._tweenEasing;
         if(isNaN(_loc8_))
         {
            return 0;
         }
         if(_loc8_)
         {
            return getEaseValue(param1,_loc8_);
         }
         return param1;
      }
      
      private function getFilters(param1:Array) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:* = 0;
         var _loc6_:BevelFilter = null;
         var _loc7_:flash.filters.BlurFilter = null;
         var _loc8_:ColorMatrix = null;
         var _loc9_:ColorMatrixFilter = null;
         var _loc10_:DropShadowFilter = null;
         var _loc11_:GlowFilter = null;
         var _loc12_:GradientBevelFilter = null;
         var _loc13_:GradientGlowFilter = null;
         var _loc14_:* = 0;
         var _loc15_:starling.filters.BlurFilter = null;
         var _loc16_:starling.filters.BlurFilter = null;
         if(!param1 || param1.length == 0)
         {
            return null;
         }
         var _loc2_:Array = new Array();
         var _loc3_:int = int(param1.length);
         if(this._bone._displayBridge is NativeDisplayBridge)
         {
            _loc5_ = 0;
            for(; _loc5_ < _loc3_; _loc5_++)
            {
               _loc4_ = param1[_loc5_];
               if(!_loc4_.enabled)
               {
                  continue;
               }
               switch(_loc4_.className)
               {
                  case "bevelFilter":
                     _loc6_ = new BevelFilter(_loc4_.distance,_loc4_.angle,_loc4_.highlightColor,_loc4_.highlightAlpha,_loc4_.shadowColor,_loc4_.shadowAlpha,_loc4_.blurX,_loc4_.blurY,_loc4_.strength,_loc4_.quality);
                     _loc2_.push(_loc6_);
                     break;
                  case "blurFilter":
                     _loc7_ = new flash.filters.BlurFilter(_loc4_.blurX,_loc4_.blurY,_loc4_.quality);
                     _loc2_.push(_loc7_);
                     break;
                  case "adjustColorFilter":
                     _loc8_ = new ColorMatrix();
                     _loc8_.adjustColor(_loc4_.brightness,_loc4_.contrast,_loc4_.saturation,_loc4_.hue);
                     _loc9_ = new ColorMatrixFilter(_loc8_);
                     _loc2_.push(_loc9_);
                     break;
                  case "dropShadowFilter":
                     _loc10_ = new DropShadowFilter(_loc4_.distance,_loc4_.angle,_loc4_.color,_loc4_.alpha,_loc4_.blurX,_loc4_.blurY,_loc4_.strength,_loc4_.quality,_loc4_.inner,_loc4_.knockout,_loc4_.hideObject);
                     _loc2_.push(_loc10_);
                     break;
                  case "glowFilter":
                     _loc11_ = new GlowFilter(_loc4_.color,_loc4_.alpha,_loc4_.blurX,_loc4_.blurY,_loc4_.strength,_loc4_.quality,_loc4_.inner,_loc4_.knockout);
                     _loc2_.push(_loc11_);
                     break;
                  case "gradientBevelFilter":
                     _loc12_ = new GradientBevelFilter(_loc4_.distance,_loc4_.angle,_loc4_.colors,_loc4_.alphas,_loc4_.ratios,_loc4_.blurX,_loc4_.blurY,_loc4_.strength,_loc4_.quality,_loc4_.type,_loc4_.knockout);
                     _loc2_.push(_loc12_);
                     break;
                  case "gradientGlowFilter":
                     _loc13_ = new GradientGlowFilter(_loc4_.distance,_loc4_.angle,_loc4_.colors,_loc4_.alphas,_loc4_.ratios,_loc4_.blurX,_loc4_.blurY,_loc4_.strength,_loc4_.quality,_loc4_.type,_loc4_.knockout);
                     _loc2_.push(_loc13_);
               }
            }
         }
         else
         {
            _loc14_ = 0;
            while(_loc14_ < _loc3_)
            {
               _loc4_ = param1[_loc14_];
               switch(_loc4_.className)
               {
                  case "bevelFilter":
                     break;
                  case "blurFilter":
                     _loc15_ = new starling.filters.BlurFilter(_loc4_.blurX,_loc4_.blurY,_loc4_.quality);
                     _loc2_.push(_loc15_);
                     break;
                  case "adjustColorFilter":
                     break;
                  case "dropShadowFilter":
                     break;
                  case "glowFilter":
                     _loc16_ = new starling.filters.BlurFilter(_loc4_.blurX,_loc4_.blurY,_loc4_.quality);
                     _loc16_.mode = FragmentFilterMode.BELOW;
                     _loc16_.setUniformColor(true,_loc4_.color,_loc4_.alpha);
                     _loc2_.push(_loc16_);
                     break;
                  case "gradientBevelFilter":
                     break;
                  case "gradientGlowFilter":
               }
               _loc14_++;
            }
         }
         return _loc2_;
      }
      
      public function get blendMode() : String
      {
         return this._blendMode;
      }
      
      public function get arrFilter() : Array
      {
         return this._arrFilter;
      }
   }
}

