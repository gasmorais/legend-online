package stage3drender.avatar
{
   import avatar.data.AvatarActions;
   import avatar.data.AvatarDirections;
   import avatar.data.AvatarStaticData;
   import com.pickgliss.ui.core.Disposeable;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import stage3drender.Global;
   import stage3drender.SimpleAtfLoader;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class AvatarPart implements Disposeable
   {
      
      public static var sizeMax:Object = {
         "1":{
            "x":-89,
            "y":-145,
            "width":178,
            "height":200,
            "size":1,
            "sizeType":1
         },
         "2":{
            "x":-185,
            "y":-264,
            "width":370,
            "height":339,
            "size":3,
            "sizeType":2
         },
         "3":{
            "x":-130,
            "y":-205,
            "width":260,
            "height":250,
            "size":2,
            "sizeType":3
         },
         "4":{
            "x":-200,
            "y":-200,
            "width":400,
            "height":400,
            "size":4,
            "sizeType":4
         },
         "5":{
            "x":-250,
            "y":-292,
            "width":500,
            "height":417,
            "size":6,
            "sizeType":5
         },
         "6":{
            "x":-240,
            "y":-270,
            "width":450,
            "height":400,
            "size":5,
            "sizeType":6
         },
         "7":{
            "x":-45,
            "y":-92,
            "width":90,
            "height":112,
            "size":-7,
            "sizeType":7
         },
         "10":{
            "x":-377,
            "y":-650,
            "width":800,
            "height":1000,
            "size":7,
            "sizeType":10
         }
      };
      
      public static var partUseCount:Dictionary = new Dictionary();
      
      public var depth:int;
      
      public var partPosition:String;
      
      public var isMount:Boolean;
      
      private var _partName:String;
      
      private var _proxy:Sprite;
      
      private var _positionDic:Dictionary;
      
      private var _hitData:Dictionary;
      
      private var _sizeRect:Object;
      
      private var _renderImg:Image;
      
      private var _renderTextures:Vector.<Texture>;
      
      private var _direction:int;
      
      private var _partParams:Object;
      
      private var _partPath:String;
      
      private var mDefaultFrameDuration:Number = 0.04;
      
      public var mCurrentFrame:int;
      
      private var mCurrentTime:Number = 0;
      
      private var mTotalTime:Number;
      
      private var mDurations:Vector.<Number>;
      
      private var mStartTimes:Vector.<Number>;
      
      public var offsetY:int = 0;
      
      public function AvatarPart(param1:Sprite, param2:String)
      {
         super();
         var _loc3_:RegExp = /\//g;
         _partPath = param2;
         _partName = _partPath.replace(_loc3_,"_");
         _proxy = param1;
         if(partUseCount[_partPath])
         {
            partUseCount[_partPath] = int(partUseCount[_partPath]) + 1;
         }
         else
         {
            partUseCount[_partPath] = 1;
         }
      }
      
      public function get partName() : String
      {
         return _partName;
      }
      
      public function get renderImage() : Image
      {
         return _renderImg;
      }
      
      public function initDepth(param1:String, param2:int) : void
      {
         depth = AvatarStaticData.instance.dic[param1 + "_" + param2 + "_" + partPosition];
      }
      
      public function changeAnimation(param1:String, param2:int, param3:Dictionary, param4:Dictionary) : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _direction = param2;
         if(param3)
         {
            _positionDic = param3;
         }
         if(param4)
         {
            _hitData = param4;
         }
         mCurrentFrame = 0;
         mCurrentTime = 0;
         _partParams = Global.avatarPartParams[_partPath];
         if(!_partParams)
         {
            return;
         }
         _sizeRect = sizeMax[_partParams.sizeType];
         _renderTextures = Global.avatarTextureDic[_partName + "_" + param1 + "_" + param2];
         if(_renderTextures)
         {
            _loc5_ = int(_renderTextures.length);
            mTotalTime = mDefaultFrameDuration * _loc5_;
            mDurations = new Vector.<Number>(_loc5_);
            mStartTimes = new Vector.<Number>(_loc5_);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               mDurations[_loc6_] = mDefaultFrameDuration;
               mStartTimes[_loc6_] = _loc6_ * mDefaultFrameDuration;
               _loc6_++;
            }
            if(!_renderImg)
            {
               _renderImg = new Image(_renderTextures[0]);
               _proxy.addChild(_renderImg);
            }
            else
            {
               if(_renderImg.parent)
               {
                  _renderImg.parent.removeChild(_renderImg);
               }
               _renderImg.texture = _renderTextures[0];
               _renderImg.readjustSize();
               _proxy.addChild(_renderImg);
            }
            var _loc7_:Point = _positionDic[0];
            if(_loc7_)
            {
               _renderImg.x = _sizeRect.x + _loc7_.x;
               _renderImg.y = _sizeRect.y + _loc7_.y + offsetY;
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
               _renderImg.x = _sizeRect.x + _loc6_.x;
               _renderImg.y = _sizeRect.y + _loc6_.y + offsetY;
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
      
      public function dispose() : void
      {
         var _loc5_:Texture = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:* = undefined;
         if(_renderImg)
         {
            _renderImg.removeFromParent(true);
         }
         _renderImg = null;
         _proxy = null;
         _positionDic = null;
         _sizeRect = null;
         _renderTextures = null;
         partUseCount[_partPath] = int(partUseCount[_partPath]) - 1;
         if(partUseCount[_partPath] <= 0)
         {
            _loc2_ = int(AvatarActions.ACTION_LIST.length);
            _loc7_ = int(AvatarDirections.AVATAR_DIRECTION_LIST.length);
            _loc6_ = "";
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc7_)
               {
                  _loc6_ = _partName + "_" + AvatarActions.ACTION_LIST[_loc3_] + "_" + AvatarDirections.AVATAR_DIRECTION_LIST[_loc4_];
                  _loc1_ = Global.avatarTextureDic[_loc6_];
                  if(_loc1_)
                  {
                     for each(_loc5_ in _loc1_)
                     {
                        _loc5_.dispose();
                     }
                  }
                  delete Global.avatarTextureDic[_loc6_];
                  _loc4_++;
               }
               _loc3_++;
            }
            _loc5_ = Global.avatarAltarTexture[_partPath];
            if(_loc5_)
            {
               _loc5_.dispose();
            }
            _loc5_ = null;
            delete SimpleAtfLoader.isLoaded[_partPath];
            delete Global.avatarPartParams[_partPath];
            delete partUseCount[_partPath];
         }
      }
      
      public function getPointIsHitable(param1:Point) : Boolean
      {
         var _loc6_:String = null;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:Number = NaN;
         if(!_renderImg)
         {
            return false;
         }
         var _loc4_:Point = new Point(param1.x - _renderImg.x,param1.y - _renderImg.y);
         if(_renderImg.hitTest(_loc4_,true))
         {
            if(_hitData && _hitData[mCurrentFrame])
            {
               _loc6_ = _hitData[mCurrentFrame];
               _loc3_ = int(_loc4_.x / 5) + Math.ceil(_renderImg.width / 5) * (int(_loc4_.y / 5));
               _loc7_ = _loc3_ % 16;
               _loc2_ = _loc3_ / 16;
               _loc5_ = _loc6_.charCodeAt(_loc2_);
               return !(isNaN(_loc5_) || (_loc5_ & 32768 >> _loc7_) == 0);
            }
            return true;
         }
         return false;
      }
      
      public function get direction() : int
      {
         return _direction;
      }
   }
}

