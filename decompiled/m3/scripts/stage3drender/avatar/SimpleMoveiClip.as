package stage3drender.avatar
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import starling.animation.IAnimatable;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class SimpleMoveiClip extends Sprite implements IAnimatable
   {
      
      private var _stepFrame:int;
      
      private var _renderImg:Image;
      
      private var _positionDic:Dictionary;
      
      private var _renderTextures:Vector.<Texture>;
      
      private var mDefaultFrameDuration:Number = 0.041666666666666664;
      
      private var mCurrentFrame:int;
      
      private var mCurrentTime:Number = 0;
      
      private var mTotalTime:Number;
      
      private var mDurations:Vector.<Number>;
      
      private var mStartTimes:Vector.<Number>;
      
      private var _step:int = 0;
      
      public function SimpleMoveiClip(param1:int = 1)
      {
         super();
         _stepFrame = param1;
      }
      
      public function changeAnimation(param1:Vector.<Texture>, param2:Dictionary) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _renderTextures = param1;
         if(param2)
         {
            _positionDic = param2;
         }
         mCurrentFrame = 0;
         mCurrentTime = 0;
         if(_renderTextures)
         {
            _loc3_ = int(_renderTextures.length);
            mTotalTime = mDefaultFrameDuration * _loc3_;
            mDurations = new Vector.<Number>(_loc3_);
            mStartTimes = new Vector.<Number>(_loc3_);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               mDurations[_loc4_] = mDefaultFrameDuration;
               mStartTimes[_loc4_] = _loc4_ * mDefaultFrameDuration;
               _loc4_++;
            }
            if(!_renderImg)
            {
               _renderImg = new Image(_renderTextures[0]);
               addChild(_renderImg);
            }
            else
            {
               _renderImg.texture = _renderTextures[0];
               addChild(_renderImg);
            }
            var _loc5_:Point = _positionDic[0];
            if(_loc5_)
            {
               _renderImg.x = _loc5_.x;
               _renderImg.y = _loc5_.y;
            }
            return;
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         var _loc4_:Boolean = false;
         var _loc6_:Point = null;
         _step = _step + 1;
         if(_step % _stepFrame != 0)
         {
            return;
         }
         if(_renderImg)
         {
            _loc5_ = mCurrentFrame;
            _loc2_ = 0;
            _loc4_ = false;
            if(mCurrentTime == mTotalTime)
            {
               mCurrentTime = 0;
               mCurrentFrame = 0;
            }
            if(param1 > 0 && mCurrentTime < mTotalTime)
            {
               mCurrentTime += param1;
               _loc3_ = _renderTextures.length - 1;
               while(mCurrentTime >= mStartTimes[mCurrentFrame] + mDurations[mCurrentFrame])
               {
                  if(mCurrentFrame == _loc3_)
                  {
                     mCurrentTime -= mTotalTime;
                     mCurrentFrame = 0;
                  }
                  else
                  {
                     mCurrentFrame = mCurrentFrame + 1;
                  }
                  if(_loc4_)
                  {
                     break;
                  }
               }
            }
            _loc6_ = _positionDic[mCurrentFrame];
            if(_loc6_)
            {
               _renderImg.x = _loc6_.x;
               _renderImg.y = _loc6_.y;
            }
            if(mCurrentFrame != _loc5_)
            {
               _renderImg.texture = _renderTextures[mCurrentFrame];
               _renderImg.readjustSize();
            }
            if(_loc2_)
            {
               advanceTime(_loc2_);
            }
         }
      }
   }
}

