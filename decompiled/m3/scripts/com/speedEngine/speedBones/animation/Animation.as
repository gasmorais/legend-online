package com.speedEngine.speedBones.animation
{
   import com.speedEngine.speedBones.display.DisplayObject;
   import com.speedEngine.speedBones.events.Event;
   import com.speedEngine.speedBones.manager.SoundManager;
   import com.speedEngine.speedBones.model.AnimationData;
   import com.speedEngine.speedBones.model.BoneTransform;
   import com.speedEngine.speedBones.model.HinderData;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   use namespace speedBones_internal;
   
   public class Animation extends DisplayObject
   {
      
      private var _isDispose:Boolean = false;
      
      private var _parentSkeleton:String = null;
      
      private var _innerChildrens:Vector.<Animation> = new Vector.<Animation>();
      
      private var _mountAnimation:Animation;
      
      private var _isScreenScale:Boolean = false;
      
      private var _direction:Number = 0;
      
      private var _textureIndex:uint = 0;
      
      private var _animationData:AnimationData;
      
      private var _isPlaying:Boolean = true;
      
      private var _currentMovementIndex:uint = 0;
      
      private var _currentFrameNumber:uint = 0;
      
      private var _currentFrameNumberF:Number = 0;
      
      private var _currentFrameLength:uint = 0;
      
      private var _movementID:int;
      
      private var _movementLoop:Boolean = true;
      
      private var _movementStr:String;
      
      public var onLoopCallback:Function = null;
      
      private var _playSoundId:int = -1;
      
      private var _playSoundFrame:int = -1;
      
      private var _playSoundCount:int = -1;
      
      private var _hasAfterResize:Boolean;
      
      public function Animation(param1:AnimationData, param2:int = 0)
      {
         super();
         _animationData = param1;
         _displayData = _animationData;
         _textureIndex = param1._textureIndex;
         _movementID = param2 % _animationData._movementLength;
         _currentFrameNumber = 0;
         _currentMovementIndex = _animationData.getMovementIndexByMovementID(_movementID);
         _currentFrameLength = _animationData.getMovementLengthByMovementID(_movementID);
         _currentFrameNumber %= _currentFrameLength;
         scaleX = _animationData.scale;
         scaleY = _animationData.scale;
         setUnScaleWidth(param1.width);
         setUnScaleHeight(param1.height);
         setSrcRect(param1.boundRect);
         setSrcTriangles(_animationData.triangles);
         param1.addEventListener("change",__onChangeSize);
      }
      
      private function __onChangeSize(param1:Event) : void
      {
         setUnScaleWidth(animationData.width);
         setUnScaleHeight(animationData.height);
         setSrcRect(animationData.boundRect);
         setSrcTriangles(_animationData.triangles);
         if(_hasAfterResize)
         {
            changeTriangles();
         }
         _hasAfterResize = false;
      }
      
      speedBones_internal function addInnerChild(param1:Animation) : void
      {
         param1.visible = false;
         _innerChildrens.push(param1);
      }
      
      speedBones_internal function addParentInnerChild() : void
      {
         var _loc1_:int = 0;
         if(_innerChildrens.length > 0 && this.public::parent)
         {
            _loc1_ = 0;
            while(_loc1_ < _innerChildrens.length)
            {
               this.public::parent.addChild(_innerChildrens[_loc1_]);
               _loc1_++;
            }
         }
      }
      
      private function setMovement(param1:int) : void
      {
         param1 %= _animationData._movementLength;
         _currentMovementIndex = _animationData.getMovementIndexByMovementID(param1);
         _currentFrameLength = _animationData.getMovementLengthByMovementID(param1);
         _currentFrameNumber = 0;
         _currentFrameNumberF = 0;
      }
      
      override protected function update() : void
      {
         var _loc1_:BoneTransform = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(_isDispose || _animationData == null)
         {
            return;
         }
         if(_hasChangeFilter)
         {
            updateColorFilter();
            updateFilter();
         }
         _animationData.writeFramePipe(_currentMovementIndex,_movementID,_currentFrameNumber);
         if(_innerChildrens.length > 0)
         {
            visibleInnerChild(false);
            updateChildren();
         }
         if(_mountAnimation)
         {
            _loc1_ = _animationData.getChildNode(_movementID,_currentFrameNumber);
            if(_loc1_)
            {
               _loc2_ = _loc1_.x;
               _loc3_ = _loc1_.y;
               if(gScaleX * scaleX < 0)
               {
                  _loc2_ = -_loc2_;
               }
               if(gScaleY * scaleY < 0)
               {
                  _loc3_ = -_loc3_;
               }
               _mountAnimation.x = _loc2_ - _loc1_.pivotX;
               _mountAnimation.y = _loc3_ - _loc1_.pivotY;
               _mountAnimation.scaleX = _loc1_.scaleX;
               _mountAnimation.scaleY = _loc1_.scaleY;
               _mountAnimation.skewX = -_loc1_.skewX;
               _mountAnimation.skewY = -_loc1_.skewY;
            }
         }
         _animationData.getBound();
      }
      
      private function updateChildren() : void
      {
         var _loc3_:int = 0;
         _animationData.embedMovementBytes.position = _currentMovementIndex << 2;
         _animationData.embedFrameIndexBytes.position = _animationData.embedMovementBytes.readUnsignedInt() + _currentFrameNumber * _animationData._moveNum * 4;
         _animationData.embedDataBytes.position = _animationData.embedFrameIndexBytes.readUnsignedInt();
         var _loc2_:uint = _animationData.embedFrameIndexBytes.readUnsignedInt();
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _animationData.embedDataBytes.readByte();
            if(_loc1_ >= 0 && _loc1_ < _innerChildrens.length)
            {
               _innerChildrens[_loc1_].visible = true;
            }
            _loc3_++;
         }
      }
      
      private function visibleInnerChild(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc2_:uint = _innerChildrens.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _innerChildrens[_loc3_].visible = param1;
            _loc3_++;
         }
      }
      
      public function getCurrentHinderData() : HinderData
      {
         if(_animationData)
         {
            return _animationData.getHinderData(_movementID,_currentFrameNumber);
         }
         return null;
      }
      
      override public function advanceFrame(param1:Number) : void
      {
         if(_isPlaying == false)
         {
            return;
         }
         _currentFrameNumberF += param1;
         if(uint(_currentFrameNumberF) >= _currentFrameLength)
         {
            if(onLoopCallback != null)
            {
               _currentFrameNumberF = 0;
               onLoopCallback();
            }
            else if(_movementLoop == false)
            {
               _isPlaying = false;
            }
            else
            {
               _currentFrameNumberF = 0;
            }
         }
         else
         {
            _currentFrameNumber = uint(_currentFrameNumberF) % _currentFrameLength;
         }
         if(_playSoundId != -1)
         {
            if(_playSoundFrame == _currentFrameNumber)
            {
               if(_playSoundCount != -1)
               {
                  _playSoundCount = _playSoundCount - 1;
                  if(_playSoundCount > -1)
                  {
                     SoundManager.instance.playSound(_playSoundId);
                  }
               }
               else
               {
                  SoundManager.instance.playSound(_playSoundId);
               }
            }
         }
      }
      
      public function play() : void
      {
         _isPlaying = true;
      }
      
      public function stop() : void
      {
         _isPlaying = false;
      }
      
      public function playNextAction() : void
      {
         _currentFrameNumber = 0;
         _movementID = (_movementID + 1) % _animationData._movementLength;
         _movementStr = _animationData.getMovementStrByID(_movementID);
         setMovement(_movementID);
      }
      
      public function gotoAndPlay(param1:String, param2:* = null) : void
      {
         if(_isDispose)
         {
            return;
         }
         _isPlaying = true;
         _currentFrameNumber = 0;
         _movementStr = param1;
         _movementID = _animationData.getMovementIDByName(param1);
         _movementLoop = param2 ? param2 : _animationData._movementLoop;
         setMovement(_movementID);
      }
      
      override protected function changeTriangles() : void
      {
         super.changeTriangles();
         _hasAfterResize = true;
      }
      
      override public function render(param1:Number) : void
      {
         if(_isDispose || _animationData == null)
         {
            return;
         }
         _animationData.writeController(_attributeBytes,_colorFilterBytes,_blurFilterBytes,_renderMode,_renderContainerData);
      }
      
      public function get animationData() : AnimationData
      {
         return _animationData;
      }
      
      public function get mountAnimation() : Animation
      {
         return _mountAnimation;
      }
      
      public function set mountAnimation(param1:Animation) : void
      {
         _mountAnimation = param1;
      }
      
      public function getDataByName(param1:String) : String
      {
         if(_animationData)
         {
            return _animationData.getDataByName(param1,_movementStr);
         }
         return null;
      }
      
      override public function hitTest(param1:Point) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         if(hasHinderData)
         {
            if(checkHinder(param1.x,param1.y))
            {
               _loc2_ = this;
            }
         }
         else
         {
            _loc2_ = super.hitTest(param1);
         }
         if(_loc2_ == this)
         {
            return _loc2_.public::parent;
         }
         return _loc2_;
      }
      
      public function checkHinder(param1:Number, param2:Number) : Boolean
      {
         var _loc5_:Rectangle = null;
         var _loc6_:int = 0;
         var _loc4_:Number = NaN;
         var _loc3_:HinderData = this.getCurrentHinderData();
         if(_loc3_)
         {
            _loc5_ = this.getBounds();
            _loc6_ = int((param1 - _loc5_.x) / _loc3_.hitSize) + Math.ceil(_loc5_.width / _loc3_.hitSize) * (int((param2 - _loc5_.y) / _loc3_.hitSize));
            _loc4_ = _loc3_.hinderStr.charCodeAt(int(_loc6_ / 16));
            return !(isNaN(_loc4_) || (_loc4_ & 32768 >> _loc6_ % 16) == 0);
         }
         return false;
      }
      
      public function setPlaySound(param1:int, param2:uint, param3:int = -1) : void
      {
         _playSoundId = param1;
         _playSoundFrame = param2;
         _playSoundCount = param3;
      }
      
      public function setClearSound() : void
      {
         _playSoundId = -1;
         _playSoundFrame = -1;
         _playSoundCount = -1;
      }
      
      public function get hasHinderData() : Boolean
      {
         return _animationData != null && _animationData.hasHinderData;
      }
      
      override public function dispose() : void
      {
         if(animationData)
         {
            animationData.removeEventListener("change",__onChangeSize);
         }
         _isDispose = true;
         _isPlaying = false;
         _mountAnimation = null;
         _animationData = null;
         onLoopCallback = null;
         _innerChildrens.length = 0;
         _playSoundId = -1;
         _playSoundCount = -1;
         super.dispose();
      }
      
      public function get movement() : String
      {
         return _movementStr;
      }
      
      public function get movementList() : Vector.<String>
      {
         if(_animationData)
         {
            return _animationData.movementList;
         }
         return null;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying;
      }
      
      public function get currentTime() : Number
      {
         return _currentFrameNumberF;
      }
      
      public function get parentSkeleton() : String
      {
         return _parentSkeleton;
      }
      
      public function set parentSkeleton(param1:String) : void
      {
         _parentSkeleton = param1;
      }
      
      public function get ridePosition() : Point
      {
         var _loc1_:BoneTransform = null;
         if(_animationData)
         {
            _loc1_ = _animationData.getChildNode(0,0);
            if(_loc1_)
            {
               return new Point(_loc1_.x,_loc1_.y);
            }
         }
         return new Point();
      }
      
      override public function get width() : Number
      {
         if(_animationData)
         {
            return _animationData.width;
         }
         return 100;
      }
      
      override public function get height() : Number
      {
         if(_animationData)
         {
            return _animationData.height;
         }
         return 100;
      }
      
      public function get bounds() : Rectangle
      {
         if(_animationData)
         {
            return _animationData.getFrameRect();
         }
         return null;
      }
   }
}

