package com.speedEngine.speedBones.factory
{
   import com.speedEngine.speedBones.animation.Animation;
   import com.speedEngine.speedBones.manager.RenderManager;
   import com.speedEngine.speedBones.model.AnimationData;
   import com.speedEngine.speedBones.model.SkeletonData;
   import com.speedEngine.speedBones.utils.VersionUtils;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   use namespace speedBones_internal;
   
   public class BaseFactory extends EventDispatcher
   {
      
      protected var _skeletonDataDic:Dictionary = new Dictionary();
      
      protected var _helpLoadBitmap:Loader = null;
      
      public var currentSkeletonData:SkeletonData;
      
      public function BaseFactory()
      {
         super();
      }
      
      public function parseData(param1:ByteArray, param2:String) : SkeletonData
      {
         return parseSkeletonData(param1,param2);
      }
      
      protected function parseSkeletonData(param1:ByteArray, param2:String) : SkeletonData
      {
         var _loc7_:int = 0;
         var _loc3_:SkeletonData = new SkeletonData();
         currentSkeletonData = _loc3_;
         _loc3_.name = param1.readUTF();
         _loc3_.version = param1.readUTF();
         _loc3_.frameRate = param1.readByte();
         var _loc4_:uint = 0;
         var _loc5_:AnimationData = null;
         _loc4_ = param1.readUnsignedInt();
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc5_ = parseAnimationData(param1,_loc3_.version);
            _loc3_.addAnimationData(_loc5_);
            _loc7_++;
         }
         var _loc6_:ByteArray = new ByteArray();
         _loc6_.length = 0;
         param1.readBytes(_loc6_);
         _loc6_.position = 0;
         parseTextureAtls(_loc6_,param2);
         addSkeletonData(_loc3_);
         return _loc3_;
      }
      
      protected function parseTextureAtls(param1:ByteArray, param2:String = null) : void
      {
         _helpLoadBitmap = new Loader();
         _helpLoadBitmap.contentLoaderInfo.addEventListener("complete",onLoaderComplete);
         _helpLoadBitmap.loadBytes(param1);
      }
      
      protected function onLoaderComplete(param1:Event) : void
      {
         var _loc2_:Bitmap = param1.currentTarget.content;
         currentSkeletonData.textureIndex = RenderManager.instance.createBitmapData(_loc2_.bitmapData);
         _loc2_.bitmapData.dispose();
         _loc2_ = null;
         _helpLoadBitmap.close();
         _helpLoadBitmap = null;
         this.dispatchEvent(new Event("complete"));
      }
      
      private function parseAnimationData(param1:ByteArray, param2:String) : AnimationData
      {
         var _loc6_:Object = null;
         var _loc5_:Point = null;
         var _loc10_:* = 0;
         var _loc9_:AnimationData = RenderManager.instance.createAnimationData();
         var _loc4_:String = null;
         _loc9_.name = param1.readUTF();
         if(VersionUtils.isReadAppend(param2))
         {
            _loc9_.scale = param1.readFloat();
            _loc4_ = param1.readUTF();
            if(_loc4_ == null || _loc4_ == "")
            {
               _loc9_.appendData = {};
            }
            else
            {
               _loc9_.appendData = JSON.parse(_loc4_);
            }
         }
         else
         {
            _loc6_ = {};
            _loc6_.bloodY = param1.readInt();
            _loc6_.rideBloodY = param1.readInt();
            _loc5_ = new Point();
            _loc5_.x = param1.readFloat();
            _loc5_.y = param1.readFloat();
            _loc6_.firePosition = _loc5_.x + "," + _loc5_.y;
            _loc9_.appendData = _loc6_;
            _loc9_.scale = param1.readFloat();
         }
         _loc9_._moveNum = VersionUtils.getLeftMove(param2);
         var _loc8_:uint = param1.readUnsignedInt();
         var _loc3_:Object = null;
         var _loc7_:String = null;
         _loc10_ = 0;
         while(_loc10_ < _loc8_)
         {
            _loc7_ = param1.readUTF();
            _loc3_ = {};
            _loc3_.index = param1.readByte();
            _loc3_.isLoop = param1.readByte() == 1 ? true : false;
            if(VersionUtils.isReadAppend(param2))
            {
               _loc4_ = param1.readUTF();
               if(_loc4_ == null || _loc4_ == "")
               {
                  _loc3_.appendData = {};
               }
               else
               {
                  _loc3_.appendData = JSON.parse(_loc4_);
               }
            }
            _loc9_.addMovIndex(_loc7_,_loc3_);
            _loc10_++;
         }
         _loc8_ = param1.readUnsignedInt();
         if(_loc8_ > 0)
         {
            param1.readBytes(_loc9_.movementXYDataBytes,0,_loc8_);
         }
         _loc8_ = param1.readUnsignedInt();
         if(_loc8_ > 0)
         {
            param1.readBytes(_loc9_.movementUVDataBytes,0,_loc8_);
         }
         _loc8_ = param1.readUnsignedInt();
         param1.readBytes(_loc9_._movementIndex,0,_loc8_);
         _loc8_ = param1.readUnsignedInt();
         param1.readBytes(_loc9_._frameIndex,0,_loc8_);
         _loc9_._movementLength = _loc9_._movementIndex.length >> 3;
         _loc8_ = param1.readUnsignedInt();
         if(_loc8_ > 0)
         {
            param1.readBytes(_loc9_._controlStreamData,0,_loc8_);
         }
         _loc8_ = param1.readUnsignedInt();
         if(_loc8_ > 0)
         {
            param1.readBytes(_loc9_._rideIndexBytes,0,_loc8_);
         }
         _loc8_ = param1.readUnsignedInt();
         if(_loc8_ > 0)
         {
            param1.readBytes(_loc9_._rideDataBytes,0,_loc8_);
         }
         if(VersionUtils.isReadChild(param2))
         {
            _loc8_ = param1.readUnsignedInt();
            if(_loc8_ > 0)
            {
               param1.readBytes(_loc9_.embedChildBytes,0,_loc8_);
            }
            _loc8_ = param1.readUnsignedInt();
            if(_loc8_ > 0)
            {
               param1.readBytes(_loc9_.embedMovementBytes,0,_loc8_);
            }
            _loc8_ = param1.readUnsignedInt();
            if(_loc8_ > 0)
            {
               param1.readBytes(_loc9_.embedFrameIndexBytes,0,_loc8_);
            }
            _loc8_ = param1.readUnsignedInt();
            if(_loc8_ > 0)
            {
               param1.readBytes(_loc9_.embedDataBytes,0,_loc8_);
               _loc9_.embedDataBytes.position = 0;
            }
            if(VersionUtils.isReadAppend(param2))
            {
               _loc8_ = param1.readUnsignedInt();
               if(_loc8_ > 0)
               {
                  param1.readBytes(_loc9_.hinderDataBytes,0,_loc8_);
                  _loc9_.hinderDataBytes.position = 0;
               }
            }
         }
         _loc9_.getBound();
         return _loc9_;
      }
      
      public function addSkeletonData(param1:SkeletonData) : void
      {
         if(_skeletonDataDic[param1.name] == null)
         {
            _skeletonDataDic[param1.name] = param1;
         }
      }
      
      public function getSkeletonData(param1:String) : SkeletonData
      {
         return _skeletonDataDic[param1];
      }
      
      public function removeSkeletonData(param1:String) : void
      {
         var _loc2_:SkeletonData = _skeletonDataDic[param1];
         if(_loc2_)
         {
            _loc2_.dispose();
         }
         _skeletonDataDic[param1] = null;
         delete _skeletonDataDic[param1];
      }
      
      public function buildAnimation(param1:String, param2:SkeletonData = null) : Animation
      {
         var _loc4_:AnimationData = null;
         if(param2 != null)
         {
            currentSkeletonData = param2;
            _loc4_ = param2.getAnimationDataByName(param1);
         }
         if(_loc4_ == null)
         {
            for each(param2 in _skeletonDataDic)
            {
               _loc4_ = param2.getAnimationDataByName(param1);
               if(_loc4_)
               {
                  currentSkeletonData = param2;
                  break;
               }
            }
         }
         if(_loc4_ == null)
         {
            return null;
         }
         _loc4_.setTextureIndex(currentSkeletonData.textureIndex);
         var _loc3_:Animation = new Animation(_loc4_);
         _loc3_.parentSkeleton = currentSkeletonData.name;
         _loc3_.name = param1;
         buildChildren(_loc3_);
         return _loc3_;
      }
      
      private function buildChildren(param1:Animation) : void
      {
         var _loc6_:int = 0;
         var _loc4_:ByteArray = param1.animationData.embedChildBytes;
         if(_loc4_.length == 0 || _loc4_.length == 1)
         {
            return;
         }
         _loc4_.position = 0;
         var _loc3_:String = null;
         var _loc2_:Animation = null;
         var _loc5_:uint = uint(_loc4_.readByte());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = _loc4_.readUTF();
            _loc2_ = buildAnimation(_loc3_,currentSkeletonData);
            if(_loc2_)
            {
               param1.addInnerChild(_loc2_);
            }
            _loc6_++;
         }
      }
      
      public function dispose(param1:Boolean = true) : void
      {
         for each(var _loc2_:SkeletonData in _skeletonDataDic)
         {
            _loc2_.dispose(param1);
         }
         _skeletonDataDic = null;
         if(_helpLoadBitmap)
         {
            _helpLoadBitmap.contentLoaderInfo.removeEventListener("complete",onLoaderComplete);
            if(_helpLoadBitmap.content is Bitmap)
            {
               (_helpLoadBitmap.content as Bitmap).bitmapData.dispose();
            }
            _helpLoadBitmap.close();
         }
         _helpLoadBitmap = null;
         currentSkeletonData = null;
      }
   }
}

