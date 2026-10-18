package com.speedEngine.components.bone
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.AppStage;
   import com.speedEngine.game.event.BaseEvent;
   import com.speedEngine.res.ResourcesManager;
   import com.speedEngine.res.loader.DataLoader;
   import com.speedEngine.speedBones.animation.Animation;
   import com.speedEngine.speedBones.factory.AtfFactory;
   import com.speedEngine.speedBones.manager.RenderManager;
   import com.speedEngine.speedBones.model.ImageData;
   import com.speedEngine.speedBones.model.SkeletonData;
   import com.speedEngine.speedBones.textures.AtfData;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   use namespace speedBones_internal;
   
   public class BoneMovieFactory extends EventDispatcher
   {
      
      private static var _instance:BoneMovieFactory;
      
      private var _skeletonNames:Vector.<String> = new Vector.<String>();
      
      private var _atfFactory:AtfFactory = new AtfFactory();
      
      private var _skeletonData:SkeletonData = null;
      
      private var _imageDatas:Dictionary = new Dictionary();
      
      private var _loaderData:LoaderData;
      
      private var _boneTypes:Dictionary = new Dictionary();
      
      private var _loaderQueue:Vector.<LoaderData> = new Vector.<LoaderData>();
      
      private var _hasLoader:Boolean = false;
      
      private var _isTrace:Boolean = false;
      
      public function BoneMovieFactory()
      {
         super();
         init();
      }
      
      public static function get instance() : BoneMovieFactory
      {
         if(_instance == null)
         {
            _instance = new BoneMovieFactory();
         }
         return _instance;
      }
      
      private function init() : void
      {
         Director.instance.addEnterFrameEvent(PlayClock.advanceTime);
         if(Director.instance.stage3d)
         {
            Director.instance.stage3d.addEventListener("context3DCreate",onContextCreated);
         }
      }
      
      protected function onKeyHandle(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 46)
         {
            onContextCreated(null);
         }
      }
      
      protected function onContextCreated(param1:Object = null) : void
      {
         RenderManager.instance.requestContext3DAgain(AppStage.context3D);
      }
      
      private function loadingComplete() : void
      {
         trace("loadingComplete");
         RenderManager.instance.startFrameUpdate();
      }
      
      private function progressCallback(param1:Number = 0) : void
      {
         trace("progressCallback=" + param1);
      }
      
      public function clearBoneMovieByFun(param1:Function) : void
      {
         var _loc5_:int = 0;
         var _loc4_:LoaderData = null;
         var _loc2_:DataLoader = null;
         var _loc3_:uint = _loaderQueue.length;
         if(_loaderData && _loaderData.callback == param1)
         {
            _loc2_ = ResourcesManager.instance.getGlobalResource(_loaderData.loaderPath) as DataLoader;
            if(_loc2_)
            {
               _loc2_.close();
               Director.instance.removeEvent(_loc2_,"loader_complete");
               Director.instance.removeEvent(_loc2_,"loader_error");
               ResourcesManager.instance.disposeByLoader(_loc2_);
               _loc2_ = null;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = _loaderQueue[_loc5_];
               if(_loc4_.callback == param1)
               {
                  _loaderQueue.splice(_loc5_,1);
                  _loc4_ = null;
                  break;
               }
               _loc5_++;
            }
         }
      }
      
      public function createBoneMovieByPath(param1:String, param2:String, param3:Function = null, param4:int = 0, param5:Boolean = true) : void
      {
         if(param1 == null || param1 == "")
         {
            Director.instance.trace(0,"BoneMovieFactory","骨骼路径url为null");
            if(param3 != null)
            {
               param3();
               return;
            }
         }
         var _loc6_:LoaderData = new LoaderData(param1,param2,param3,param4,param5);
         if(_hasLoader)
         {
            _loaderQueue.push(_loc6_);
         }
         else
         {
            createLoader(_loc6_);
         }
      }
      
      private function createLoader(param1:LoaderData) : void
      {
         var _loc2_:DataLoader = null;
         _hasLoader = true;
         _loaderData = param1;
         if(_isTrace)
         {
            Director.instance.trace(0,"BoneMovieFactory","**********" + param1.boneMovieName + "加载骨骼{invalid_utf8=239}{invalid_utf8=188}?" + param1.loaderPath);
         }
         var _loc3_:SkeletonData = getSkeletonName(param1.boneMovieName);
         if(_loc3_)
         {
            if(_isTrace)
            {
               Director.instance.trace(0,"BoneMovieFactory","**********" + param1.boneMovieName + "骨骼已存在：" + param1.loaderPath);
            }
            buildBoneMovie(_loc3_);
            return;
         }
         _loc2_ = ResourcesManager.instance.getGlobalResource(param1.loaderPath) as DataLoader;
         if(_loc2_ == null)
         {
            _loc2_ = new DataLoader(param1.loaderPath,false);
            Director.instance.addEventOnce(_loc2_,"loader_complete",onLoaderComplete);
            Director.instance.addEventOnce(_loc2_,"loader_error",onLoaderError);
            ResourcesManager.instance.load(_loc2_);
         }
         else if(!_loc2_.complete)
         {
            Director.instance.addEventOnce(_loc2_,"loader_complete",onLoaderComplete);
            Director.instance.addEventOnce(_loc2_,"loader_error",onLoaderError);
         }
         else
         {
            _loaderData.boneBytes = _loc2_.data as ByteArray;
            createMovie();
         }
      }
      
      private function onLoaderComplete(param1:BaseEvent) : void
      {
         var _loc2_:DataLoader = param1.data as DataLoader;
         _loaderData.boneBytes = _loc2_.data as ByteArray;
         createMovie();
      }
      
      private function onLoaderError(param1:BaseEvent) : void
      {
         Director.instance.trace(0,"骨骼动画资源加载错误" + param1.data);
         onBuildCallback(null);
      }
      
      public function removeCallbackByPath(param1:String) : void
      {
         var _loc2_:DataLoader = null;
         _loc2_ = ResourcesManager.instance.getGlobalResource(param1) as DataLoader;
         if(_loc2_ != null)
         {
            Director.instance.removeEvent(_loc2_,"loader_complete");
            Director.instance.removeEvent(_loc2_,"loader_error");
         }
      }
      
      private function createMovie() : void
      {
         _skeletonData = null;
         if(_loaderData.boneBytes != null && _loaderData.boneBytes.length > 0)
         {
            _atfFactory.addEventListener("complete",onCompleteHandler);
            try
            {
               _skeletonData = _atfFactory.parseData(_loaderData.boneBytes,_loaderData.loaderPath);
               _boneTypes[_skeletonData.name] = _loaderData.boneMovieType;
            }
            catch(e:Error)
            {
               Director.instance.trace(0,"[" + _loaderData.loaderPath + "]骨骼资源错误！！" + e.message);
               onBuildCallback(null);
            }
         }
         else
         {
            Director.instance.trace(0,"BoneMovieFactory","[" + _loaderData.loaderPath + "]骨骼资源已被释放或{invalid_utf8=232}?{invalid_utf8=133}其它问题！");
            onBuildCallback(null);
         }
      }
      
      protected function onCompleteHandler(param1:Event) : void
      {
         _atfFactory.removeEventListener("complete",onCompleteHandler);
         if(_skeletonData && _skeletonNames.indexOf(_skeletonData.name) == -1)
         {
            _skeletonNames.push(_skeletonData.name);
         }
         if(_isTrace)
         {
            Director.instance.trace(0,"BoneMovieFactory","***********加载骨骼完成,回调{invalid_utf8=239}{invalid_utf8=188}?" + _loaderData.loaderPath);
         }
         buildBoneMovie();
      }
      
      private function buildBoneMovie(param1:SkeletonData = null) : void
      {
         if(_loaderData.isCompleteBuild)
         {
            buildCompeteHandle(param1);
         }
         else
         {
            onBuildCallback(null);
         }
      }
      
      private function buildCompeteHandle(param1:SkeletonData = null) : void
      {
         var _loc3_:Animation = _atfFactory.buildAnimation(_loaderData.boneMovieName,param1);
         var _loc2_:BoneMovie = null;
         if(_loc3_)
         {
            _loc2_ = new BoneMovie(_loc3_);
         }
         else
         {
            Director.instance.trace(0,"不存在名称为" + _loaderData.boneMovieName + "的骨骼动画！{invalid_utf8=239}{invalid_utf8=188}?");
         }
         if(_isTrace)
         {
            Director.instance.trace(0,"BoneMovieFactory","***********创建骨骼完成,回调{invalid_utf8=239}{invalid_utf8=188}?" + _loaderData.loaderPath);
         }
         onBuildCallback(_loc2_);
      }
      
      private function onBuildCallback(param1:BoneMovie) : void
      {
         if(_loaderData != null && _loaderData.callback != null)
         {
            _loaderData.callback.apply(null,[param1]);
            _loaderData.callback = null;
            _loaderData = null;
         }
         if(_loaderQueue.length > 0)
         {
            createLoader(_loaderQueue.shift());
         }
         else
         {
            _hasLoader = false;
         }
      }
      
      public function getBoneMovieByName(param1:String, param2:String = null, param3:String = null) : BoneMovie
      {
         var _loc5_:BoneMovie = null;
         var _loc4_:Animation = null;
         if(param1 == null || param1 == "")
         {
            return null;
         }
         _loc4_ = _atfFactory.buildAnimation(param1);
         if(_loc4_)
         {
            _loc5_ = new BoneMovie(_loc4_);
         }
         else
         {
            Director.instance.trace(0,"不存{invalid_utf8=229}{invalid_utf8=156}?" + param1 + "的骨骼动画！{invalid_utf8=239}{invalid_utf8=188}?");
         }
         return _loc5_;
      }
      
      public function getAnimationByName(param1:String) : Animation
      {
         return _atfFactory.buildAnimation(param1);
      }
      
      public function hasBoneMovie(param1:String) : Boolean
      {
         if(getSkeletonName(param1) != null)
         {
            return true;
         }
         return false;
      }
      
      private function getSkeletonName(param1:String) : SkeletonData
      {
         if(param1 == null || param1 == "")
         {
            return null;
         }
         var _loc2_:SkeletonData = null;
         for each(var _loc3_:String in _skeletonNames)
         {
            _loc2_ = _atfFactory.getSkeletonData(_loc3_);
            if(_loc2_ != null && _loc2_.getAnimationDataByName(param1))
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function removieSkeleton(param1:String) : void
      {
         var _loc3_:SkeletonData = null;
         var _loc2_:int = _skeletonNames.indexOf(param1);
         if(_loc2_ != -1)
         {
            _loc3_ = _atfFactory.getSkeletonData(param1);
            if(_loc3_)
            {
               RenderManager.instance.disposeTexture(_loc3_.textureIndex);
            }
            _atfFactory.removeSkeletonData(param1);
            _skeletonNames.splice(_loc2_,1);
         }
         _boneTypes[param1] = null;
         delete _boneTypes[param1];
      }
      
      public function clearTexture(param1:ImageData) : void
      {
         for(var _loc2_:Object in _imageDatas)
         {
            if(_imageDatas[_loc2_] == param1)
            {
               RenderManager.instance.disposeTexture(param1.textureIndex);
               _imageDatas[_loc2_] = null;
               delete _imageDatas[_loc2_];
               break;
            }
         }
      }
      
      public function clearImageData(param1:ImageData) : void
      {
         clearTexture(param1);
      }
      
      public function removieSkeletonTypes(param1:int) : void
      {
         for each(var _loc2_:String in _boneTypes)
         {
            if(_boneTypes[_loc2_] == param1)
            {
               removieSkeleton(_loc2_);
               delete _boneTypes[_loc2_];
            }
         }
      }
      
      public function removieSkeletons() : void
      {
         while(_skeletonNames.length > 0)
         {
            _atfFactory.removeSkeletonData(_skeletonNames.pop());
         }
         for(var _loc1_:Object in _imageDatas)
         {
            (_imageDatas[_loc1_] as ImageData).dispose();
            _imageDatas[_loc1_] = null;
            delete _imageDatas[_loc1_];
         }
         _hasLoader = false;
         _loaderQueue.length = 0;
         RenderManager.instance.clearTextures();
      }
      
      public function getBoneMovieNames() : Vector.<String>
      {
         var _loc1_:SkeletonData = null;
         var _loc2_:Vector.<String> = new Vector.<String>();
         for each(var _loc3_:String in _skeletonNames)
         {
            _loc1_ = _atfFactory.getSkeletonData(_loc3_);
            if(_loc1_ != null)
            {
               _loc2_ = _loc2_.concat(_loc1_.animationNames);
            }
         }
         return _loc2_;
      }
      
      public function set isTrace(param1:Boolean) : void
      {
         _isTrace = param1;
      }
      
      public function getSkeletonNames() : Vector.<String>
      {
         return _skeletonNames.concat();
      }
      
      public function getImageData(param1:AtfData) : ImageData
      {
         var _loc2_:ImageData = _imageDatas[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc2_ = RenderManager.instance.speedBones_internal::createImageData(param1);
         _imageDatas[param1] = _loc2_;
         return _loc2_;
      }
      
      public function getImageDataByBitmapData(param1:BitmapData) : ImageData
      {
         var _loc2_:ImageData = _imageDatas[param1];
         if(_loc2_ != null)
         {
            return _loc2_;
         }
         _loc2_ = RenderManager.instance.createImageDataFromBitmapData(param1);
         _imageDatas[param1] = _loc2_;
         return _loc2_;
      }
   }
}

