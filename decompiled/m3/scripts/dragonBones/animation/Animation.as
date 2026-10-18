package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.events.AnimationEvent;
   import dragonBones.events.FrameEvent;
   import dragonBones.events.SoundEvent;
   import dragonBones.events.SoundEventManager;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.MovementBoneData;
   import dragonBones.objects.MovementData;
   import dragonBones.objects.MovementFrameData;
   import dragonBones.utils.dragonBones_internal;
   
   use namespace dragonBones_internal;
   
   public final class Animation
   {
      
      internal static const SINGLE:int = 0;
      
      internal static const LIST_START:int = 1;
      
      internal static const LOOP_START:int = 2;
      
      internal static const LIST:int = 3;
      
      internal static const LOOP:int = 4;
      
      private static var _soundManager:SoundEventManager = SoundEventManager.getInstance();
      
      public var tweenEnabled:Boolean = true;
      
      private var _playType:int;
      
      private var _duration:Number;
      
      private var _rawDuration:Number;
      
      private var _nextFrameDataTimeEdge:Number;
      
      private var _nextFrameDataID:int;
      
      private var _loop:int;
      
      private var _breakFrameWhile:Boolean;
      
      private var _armature:Armature;
      
      private var _movementData:MovementData;
      
      private var _animationData:AnimationData;
      
      public var needChangeTween:Boolean;
      
      public var totalFrame:uint;
      
      private var _currentTime:Number;
      
      private var _totalTime:Number;
      
      private var _isPlaying:Boolean;
      
      private var _timeScale:Number = 1;
      
      private var _movementID:String;
      
      public function Animation(param1:Armature)
      {
         super();
         this._armature = param1;
      }
      
      public function get animationData() : AnimationData
      {
         return this._animationData;
      }
      
      public function set animationData(param1:AnimationData) : void
      {
         if(param1)
         {
            this.stop();
            this._animationData = param1;
         }
      }
      
      public function get currentTime() : Number
      {
         return this._currentTime;
      }
      
      public function get totalTime() : Number
      {
         return this._totalTime;
      }
      
      public function get isPlaying() : Boolean
      {
         if(this._isPlaying)
         {
            return this._loop >= 0 || this._currentTime < this._totalTime;
         }
         return false;
      }
      
      public function get isComplete() : Boolean
      {
         return this._loop < 0 && this._currentTime >= this._totalTime;
      }
      
      public function get isPause() : Boolean
      {
         return !this._isPlaying;
      }
      
      public function get timeScale() : Number
      {
         return this._timeScale;
      }
      
      public function set timeScale(param1:Number) : void
      {
         var _loc2_:Bone = null;
         if(param1 < 0)
         {
            param1 = 0;
         }
         this._timeScale = param1;
         for each(_loc2_ in this._armature._boneDepthList)
         {
            if(_loc2_.childArmature)
            {
               _loc2_.childArmature.animation.timeScale = this._timeScale;
            }
         }
      }
      
      public function get movementID() : String
      {
         return this._movementID;
      }
      
      public function getMoveData(param1:String = null) : MovementData
      {
         if(param1 == null || param1 == "")
         {
            return this._movementData;
         }
         return this._animationData.getMovementData(param1);
      }
      
      public function get movementList() : Vector.<String>
      {
         return this._animationData ? this._animationData.movementList : null;
      }
      
      public function dispose() : void
      {
         this.stop();
         this._animationData = null;
         this._movementData = null;
         this._armature = null;
      }
      
      public function gotoAndPlay(param1:String, param2:Number = -1, param3:Number = -1, param4:* = null, param5:Boolean = true) : void
      {
         var _loc9_:Bone = null;
         var _loc10_:MovementBoneData = null;
         var _loc11_:AnimationEvent = null;
         if(!this._animationData)
         {
            return;
         }
         var _loc6_:MovementData = this._animationData.getMovementData(param1 as String);
         if(!_loc6_)
         {
            return;
         }
         this._movementData = _loc6_;
         this._isPlaying = true;
         this._currentTime = 0;
         this._breakFrameWhile = true;
         var _loc7_:String = this._movementID;
         this._movementID = param1 as String;
         if(param2 >= 0)
         {
            this._totalTime = param2;
         }
         else if(this.tweenEnabled && Boolean(_loc7_))
         {
            this._totalTime = this._movementData.durationTo;
         }
         else
         {
            this._totalTime = 0;
         }
         if(this._totalTime < 0)
         {
            this._totalTime = 0;
         }
         this.needChangeTween = param5;
         if(!this.needChangeTween)
         {
            this._totalTime = 0;
         }
         this._duration = param3 >= 0 ? param3 : this._movementData.durationTween;
         if(this._duration < 0)
         {
            this._duration = 0;
         }
         param4 = Boolean(param4 === null ? this._movementData.loop : param4);
         this._rawDuration = this._movementData.duration;
         this._loop = param4 ? 0 : -1;
         if(this._rawDuration == 0)
         {
            this._playType = SINGLE;
         }
         else
         {
            this._nextFrameDataTimeEdge = 0;
            this._nextFrameDataID = 0;
            if(param4)
            {
               this._playType = LOOP_START;
            }
            else
            {
               this._playType = LIST_START;
            }
         }
         var _loc8_:Number = this._movementData.tweenEasing;
         for each(_loc9_ in this._armature._boneDepthList)
         {
            _loc10_ = this._movementData.getMovementBoneData(_loc9_.name);
            if(_loc10_)
            {
               _loc9_._tween.gotoAndPlay(_loc10_,this._rawDuration,param4,_loc8_);
               if(_loc9_.childArmature)
               {
                  _loc9_.childArmature.animation.gotoAndPlay(param1,-1,-1,null,this.needChangeTween);
               }
            }
            else
            {
               _loc9_._tween.stop();
            }
         }
         if(this._armature.hasEventListener(AnimationEvent.MOVEMENT_CHANGE))
         {
            _loc11_ = new AnimationEvent(AnimationEvent.MOVEMENT_CHANGE);
            _loc11_.exMovementID = _loc7_;
            _loc11_.movementID = this._movementID;
            this._armature.dispatchEvent(_loc11_);
         }
      }
      
      public function play() : void
      {
         var _loc1_:Bone = null;
         if(!this._animationData)
         {
            return;
         }
         if(!this._movementID)
         {
            if(this.movementList)
            {
               this.gotoAndPlay(this.movementList[0],-1,-1,null,this.needChangeTween);
            }
            return;
         }
         if(this.isComplete)
         {
            this.gotoAndPlay(this._movementID,-1,-1,null,this.needChangeTween);
         }
         else if(!this._isPlaying)
         {
            this._isPlaying = true;
            for each(_loc1_ in this._armature._boneDepthList)
            {
               if(_loc1_.childArmature)
               {
                  _loc1_.childArmature.animation.play();
               }
            }
         }
      }
      
      dragonBones_internal function clearMovement() : void
      {
         this._movementID = null;
      }
      
      public function stop() : void
      {
         var _loc1_:Bone = null;
         this._isPlaying = false;
         for each(_loc1_ in this._armature._boneDepthList)
         {
            if(_loc1_.childArmature)
            {
               _loc1_.childArmature.animation.stop();
            }
         }
      }
      
      dragonBones_internal function advanceTime(param1:Number, param2:String = "", param3:int = 0) : void
      {
         var _loc4_:Number = NaN;
         var _loc5_:AnimationEvent = null;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         if(this._isPlaying && (this._loop > 0 || this._currentTime < this._totalTime || this._totalTime == 0))
         {
            if(this._totalTime > 0)
            {
               this._currentTime += param1 * this._timeScale;
               _loc4_ = this._currentTime / this._totalTime;
            }
            else
            {
               this._currentTime = 1;
               this._totalTime = 1;
               _loc4_ = 1;
            }
            if(this._playType == LOOP)
            {
               _loc7_ = _loc4_;
               if(_loc7_ != this._loop)
               {
                  this._loop = _loc7_;
                  this._nextFrameDataTimeEdge = 0;
                  if(this._armature.hasEventListener(AnimationEvent.LOOP_COMPLETE))
                  {
                     _loc5_ = new AnimationEvent(AnimationEvent.LOOP_COMPLETE);
                     _loc5_.movementID = this._movementID;
                  }
               }
            }
            else if(_loc4_ >= 1)
            {
               switch(this._playType)
               {
                  case SINGLE:
                  case LIST:
                     _loc4_ = 1;
                     this._isPlaying = false;
                     if(this._armature.hasEventListener(AnimationEvent.COMPLETE))
                     {
                        _loc5_ = new AnimationEvent(AnimationEvent.COMPLETE);
                        _loc5_.movementID = this._movementID;
                     }
                     break;
                  case LIST_START:
                     _loc4_ = 0;
                     this._playType = LIST;
                     this._currentTime = 0;
                     this._totalTime = this._duration;
                     if(this._armature.hasEventListener(AnimationEvent.START))
                     {
                        _loc5_ = new AnimationEvent(AnimationEvent.START);
                        _loc5_.movementID = this._movementID;
                     }
                     break;
                  case LOOP_START:
                     _loc4_ = 0;
                     this._playType = LOOP;
                     this._currentTime = 0;
                     this._totalTime = this._duration;
                     if(this._armature.hasEventListener(AnimationEvent.START))
                     {
                        _loc5_ = new AnimationEvent(AnimationEvent.START);
                        _loc5_.movementID = this._movementID;
                     }
               }
            }
            if(_loc5_)
            {
               this._armature.dispatchEvent(_loc5_);
               return;
            }
            _loc6_ = int(this._armature._boneDepthList.length);
            while(_loc6_--)
            {
               this._armature._boneDepthList[_loc6_]._tween.advanceTime(_loc4_,this._playType,param2,param3);
            }
            if((this._playType == LIST || this._playType == LOOP) && this._movementData._movementFrameList.length > 0)
            {
               if(this._loop > 0)
               {
                  _loc4_ -= this._loop;
               }
               this.updateFrameData(_loc4_);
            }
         }
      }
      
      private function updateFrameData(param1:Number) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:int = 0;
         var _loc5_:MovementFrameData = null;
         var _loc6_:Number = NaN;
         var _loc2_:Number = this._rawDuration * param1;
         if(_loc2_ >= this._nextFrameDataTimeEdge)
         {
            this._breakFrameWhile = false;
            _loc3_ = this._movementData._movementFrameList.length;
            do
            {
               _loc4_ = this._nextFrameDataID;
               _loc5_ = this._movementData._movementFrameList[_loc4_];
               _loc6_ = _loc5_.duration;
               this._nextFrameDataTimeEdge += _loc6_;
               if(++this._nextFrameDataID >= _loc3_)
               {
                  this._nextFrameDataID = 0;
               }
               this.arriveFrameData(_loc5_);
               if(this._breakFrameWhile)
               {
                  break;
               }
            }
            while(_loc2_ >= this._nextFrameDataTimeEdge);
         }
      }
      
      private function arriveFrameData(param1:MovementFrameData) : void
      {
         var _loc2_:FrameEvent = null;
         var _loc3_:SoundEvent = null;
         if(Boolean(param1.event) && this._armature.hasEventListener(FrameEvent.MOVEMENT_FRAME_EVENT))
         {
            _loc2_ = new FrameEvent(FrameEvent.MOVEMENT_FRAME_EVENT);
            _loc2_.movementID = this._movementID;
            _loc2_.frameLabel = param1.event;
            this._armature.dispatchEvent(_loc2_);
         }
         if(Boolean(param1.sound) && _soundManager.hasEventListener(SoundEvent.SOUND))
         {
            _loc3_ = new SoundEvent(SoundEvent.SOUND);
            _loc3_.movementID = this._movementID;
            _loc3_.sound = param1.sound;
            _loc3_._armature = this._armature;
            _soundManager.dispatchEvent(_loc3_);
         }
         if(param1.movement)
         {
            this.gotoAndPlay(param1.movement,-1,-1,null,this.needChangeTween);
         }
      }
   }
}

