package com.speedEngine.res
{
   import com.speedEngine.components.model.MovieData2D;
   import com.speedEngine.components.ui2D.SimpleMovie;
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.event.BaseEvent;
   import com.speedEngine.res.loader.BitmapLoader;
   import com.speedEngine.res.loader.DataLoader;
   import com.speedEngine.res.loader.MovieLoader;
   import com.speedEngine.res.loader.SwfLoader;
   import com.speedEngine.res.loader.TextureLoader;
   import com.speedEngine.res.loader.ZipLoader;
   import com.speedEngine.speedBones.textures.AtfData;
   import com.speedEngine.utils.ObjectUtil;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   use namespace basegame_internal;
   
   public class ResourcesManager
   {
      
      private static var _instance:ResourcesManager;
      
      private var _maxLoading:int = 10;
      
      private var _preMaxLoading:int = 1;
      
      private var _loadQueue:Vector.<BaseLoader> = new Vector.<BaseLoader>();
      
      private var _waitQueue:Vector.<BaseLoader> = new Vector.<BaseLoader>();
      
      private var _resDic:Dictionary = new Dictionary(true);
      
      private var _resGlobalDic:Dictionary = new Dictionary(true);
      
      private var _objGlobalDic:Dictionary = new Dictionary(true);
      
      private var _atlasMapping:Dictionary = new Dictionary(true);
      
      private var _quoteBitmap:Object = {};
      
      private var _quoteTexture:Object = {};
      
      private var _bitmapDic:Dictionary = new Dictionary();
      
      private var _textureDic:Dictionary = new Dictionary();
      
      private var _movieDic:Object = {};
      
      private var _pathDic:Dictionary = new Dictionary(true);
      
      public function ResourcesManager()
      {
         super();
      }
      
      public static function get instance() : ResourcesManager
      {
         if(_instance == null)
         {
            _instance = new ResourcesManager();
         }
         return _instance;
      }
      
      public function set maxLoading(param1:int) : void
      {
         _preMaxLoading = _maxLoading;
         _maxLoading = param1;
      }
      
      public function resetMaxLoading() : void
      {
         _maxLoading = _preMaxLoading;
      }
      
      public function load(param1:BaseLoader) : void
      {
         var _loc2_:QueueLoader = null;
         var _loc4_:* = undefined;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         if(_resDic[param1.path] != null && param1.path != null)
         {
            param1.inResLink = _resDic;
            param1.inGlobalLink = _resGlobalDic;
            param1.inGlobalObjLink = _objGlobalDic;
            if(_resDic[param1.path].hasLoaded)
            {
               param1.hasLoaded = true;
               __onComplete(param1);
            }
            else
            {
               Director.instance.addEventOnce(param1,"loadercomplete",__onComplete);
               _resDic[param1.path].addWaiter(param1);
            }
            return;
         }
         if(param1 is QueueLoader)
         {
            _loc2_ = param1 as QueueLoader;
            if(_loc2_ is AssistQueueLoader)
            {
               for each(var _loc3_:BaseLoader in _loc2_.queue)
               {
                  if(_resDic[_loc3_.path] == null && !(_loc3_ is AssistQueueLoader))
                  {
                     _resDic[_loc3_.path] = _loc3_;
                  }
               }
            }
            else if(_resDic[param1.path] == null)
            {
               _resDic[param1.path] = _loc2_;
            }
            _loc2_.initQueue(_resDic,_resGlobalDic,_objGlobalDic,_atlasMapping,__onQueueComplete);
            Director.instance.addEventOnce(_loc2_,"loader_complete",__onQueueComplete);
            _loc4_ = _loc2_.extendQueue;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.length)
            {
               _loadQueue.push(_loc4_[_loc6_]);
               if(_resGlobalDic[_loc4_[_loc6_].path] == null)
               {
                  _resGlobalDic[_loc4_[_loc6_].path] = _loc4_[_loc6_];
               }
               _loc6_++;
            }
         }
         else
         {
            if(_resDic[param1.path] == null)
            {
               _resDic[param1.path] = param1;
            }
            if(_resGlobalDic[param1.path] == null)
            {
               _resGlobalDic[param1.path] = param1;
            }
            param1.inResLink = _resDic;
            param1.inGlobalLink = _resGlobalDic;
            param1.inGlobalObjLink = _objGlobalDic;
            param1.inAtlasMapping = _atlasMapping;
            _loadQueue.push(param1);
         }
         while(_loadQueue.length > _maxLoading)
         {
            _waitQueue.push(_loadQueue[_maxLoading]);
            _loadQueue.splice(_maxLoading,1);
         }
         _loc6_ = 0;
         while(_loc6_ < _loadQueue.length)
         {
            loadPiece(_loadQueue[_loc6_]);
            _loc6_++;
         }
      }
      
      public function loadResourceByPaths(param1:Array, param2:Function, param3:Function = null) : AssistQueueLoader
      {
         var _loc7_:BaseLoader = null;
         var _loc6_:Array = null;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return null;
         }
         var _loc4_:int = int(param1.length);
         var _loc5_:AssistQueueLoader = new AssistQueueLoader();
         _loc9_ = 0;
         while(_loc9_ < _loc4_)
         {
            _loc8_ = param1[_loc9_];
            _loc6_ = _loc8_.match(/.swf$|.xml$|.png$|.jpg|.atl$|.json$|.atf$|.txt$|.zip$/gi);
            if(_loc6_.length > 0)
            {
               switch(_loc6_[0])
               {
                  case ".swf":
                     _loc7_ = new SwfLoader(_loc8_);
                     break;
                  case ".png":
                  case "jpg":
                     _loc7_ = new BitmapLoader(_loc8_);
                     break;
                  case ".xml":
                  case ".atl":
                  case ".txt":
                  case ".json":
                     _loc7_ = new DataLoader(_loc8_,true);
                     break;
                  case ".zip":
                     _loc7_ = new ZipLoader(_loc8_);
                     (_loc7_ as ZipLoader).isWork = false;
               }
               if(_loc7_)
               {
                  _pathDic[_loc7_] = {};
                  _pathDic[_loc7_]["callBack"] = param2;
                  _pathDic[_loc7_]["errorCallBack"] = param3;
                  _loc7_.fileType = _loc6_[0];
                  _loc5_.addLoader(_loc7_);
                  Director.instance.addEvent(_loc7_,"loader_complete",__onPathLoadComplete,true);
                  Director.instance.addEvent(_loc7_,"loader_error",__onPathLoadError,true);
               }
            }
            _loc9_++;
         }
         if(_loc5_.totalChildren > 0)
         {
            load(_loc5_);
         }
         return _loc5_;
      }
      
      private function __onPathLoadError(param1:BaseEvent) : void
      {
         var _loc4_:BaseLoader = param1.target as BaseLoader;
         var _loc2_:Function = _pathDic[_loc4_]["errorCallBack"];
         var _loc3_:String = param1.data as String;
         if(_loc2_ != null)
         {
            _loc2_(_loc4_,_loc3_);
         }
         deleteObject(_pathDic[_loc4_]);
         _pathDic[_loc4_] = null;
         delete _pathDic[_loc4_];
      }
      
      private function deleteObject(param1:Object) : void
      {
         for(var _loc2_:String in param1)
         {
            param1[_loc2_] = null;
            delete param1[_loc2_];
         }
      }
      
      private function __onPathLoadComplete(param1:BaseEvent) : void
      {
         var _loc4_:BaseLoader = param1.data as BaseLoader;
         var _loc3_:BaseLoader = getGlobalResource(_loc4_.path);
         var _loc2_:Function = _pathDic[_loc4_]["callBack"];
         if(_loc2_ != null)
         {
            _loc2_(_loc3_);
         }
         deleteObject(_pathDic[_loc4_]);
         _pathDic[_loc4_] = null;
         delete _pathDic[_loc4_];
      }
      
      private function loadPiece(param1:BaseLoader) : void
      {
         var realLder:BaseLoader;
         var idTimeOut:int;
         var lder:BaseLoader = param1;
         var timeOut:* = function():void
         {
            clearTimeout(idTimeOut);
            Director.instance.dispatchEventWith(lder,"loadercomplete",lder);
         };
         Director.instance.addEventOnce(lder,"loadercomplete",__onComplete);
         Director.instance.addEventOnce(lder,"loaderror",__onLoaderError);
         realLder = _resGlobalDic[lder.path];
         if(realLder == null)
         {
            Director.instance.throwError("在还没读取该资源时，似乎Loader已经被释放掉了{invalid_utf8=227}?{invalid_utf8=130}资源无法读取，请检查不合理的地方{invalid_utf8=227}?{invalid_utf8=130}At" + lder.path);
         }
         if(realLder.hasLoaded)
         {
            idTimeOut = int(setTimeout(timeOut,50));
         }
         else if(realLder.isLoading)
         {
            if(lder != realLder)
            {
               lder.isLoading = true;
               realLder.addWaiter(lder);
            }
         }
         else
         {
            if(lder.parent != null)
            {
               lder.parent.signalLoadChild(lder);
            }
            lder.isLoading = true;
            lder.inResLink = _resDic;
            lder.inGlobalLink = _resGlobalDic;
            lder.inGlobalObjLink = _objGlobalDic;
            lder.load();
         }
      }
      
      private function __onLoaderError(param1:BaseEvent) : void
      {
         var _loc2_:BaseLoader = param1.target as BaseLoader;
         var _loc3_:int = _loadQueue.indexOf(_loc2_);
         if(_loc3_ > -1)
         {
            _loadQueue.splice(_loc3_,1);
         }
      }
      
      protected function __onComplete(param1:Object) : void
      {
         var _loc2_:BaseLoader = null;
         if(param1 is BaseEvent)
         {
            _loc2_ = param1.data as BaseLoader;
         }
         else if(param1 is BaseLoader)
         {
            _loc2_ = param1 as BaseLoader;
         }
         Director.instance.trace(6,"ResourcesManager","当前加载的资源为{invalid_utf8=239}{invalid_utf8=188}?" + _loc2_.path);
         _loc2_.isLoading = false;
         _loc2_.hasLoaded = true;
         Director.instance.dispatchEventWith(_loc2_,"loader_complete",_loc2_);
         var _loc3_:int = _loadQueue.indexOf(_loc2_);
         if(_loc3_ != -1)
         {
            if(_waitQueue.length > 0)
            {
               _loadQueue[_loc3_] = _waitQueue.shift();
               loadPiece(_loadQueue[_loc3_]);
            }
            else
            {
               _loadQueue.splice(_loc3_,1);
            }
         }
         if(_loc2_.parent != null)
         {
            _loc2_.parent.signalCompleteChild(_loc2_);
         }
      }
      
      protected function __onQueueComplete(param1:BaseEvent) : void
      {
         var _loc2_:BaseLoader = param1.data as QueueLoader;
         _loc2_.isLoading = false;
         _loc2_.hasLoaded = true;
      }
      
      public function getBitmapData(param1:String) : BitmapData
      {
         var _loc3_:BitmapLoader = null;
         var _loc4_:Object = _quoteBitmap[param1];
         var _loc5_:BitmapData = null;
         if(_loc4_ != null)
         {
            _loc4_["quote"] += 1;
            _loc5_ = _loc4_["data"] as BitmapData;
            if(!_loc5_)
            {
               _quoteBitmap[param1] = null;
               delete _quoteBitmap[param1];
               deleteObject(_loc4_);
            }
            else
            {
               try
               {
                  _loc5_.height;
               }
               catch(error:Error)
               {
                  _loc4_["quote"] = 1;
                  disposeBitmapByName(param1);
                  return getBitmapData(param1);
               }
            }
            return _loc5_;
         }
         var _loc2_:Object = getClassLink(param1);
         if(_loc2_ is BitmapData)
         {
            _loc5_ = _loc2_ as BitmapData;
         }
         else
         {
            _loc5_ = getObjByKey(param1) as BitmapData;
            if(_loc5_ == null)
            {
               _loc3_ = getGlobalResource(param1) as BitmapLoader;
               if(_loc3_ && _loc3_.hasLoaded)
               {
                  _loc5_ = _loc3_.bitmapData;
               }
            }
         }
         if(_loc5_ != null)
         {
            _bitmapDic[_loc5_] = param1;
            _quoteBitmap[param1] = {
               "quote":1,
               "data":_loc5_
            };
         }
         return _loc5_;
      }
      
      public function getMovieClip(param1:String) : MovieClip
      {
         var _loc2_:Object = getClassLink(param1);
         if(_loc2_ is MovieClip)
         {
            return _loc2_ as MovieClip;
         }
         return null;
      }
      
      public function getMovieByPath(param1:Array, param2:Function = null, param3:Boolean = true) : Array
      {
         var _loc6_:BaseLoader = null;
         var _loc5_:Object = null;
         var _loc8_:int = 0;
         var _loc9_:Array = [];
         var _loc4_:int = int(param1.length);
         var _loc7_:AssistQueueLoader = new AssistQueueLoader();
         _loc8_ = 0;
         while(_loc8_ < _loc4_)
         {
            _loc6_ = getGlobalResource(param1[_loc8_]) as BaseLoader;
            if(_loc6_)
            {
               if(_loc6_.complete)
               {
                  if(!param3)
                  {
                     _loc5_ = new SimpleMovie(_loc6_["movieData"] as MovieData2D);
                  }
                  if(param2 != null)
                  {
                     param2.apply(null,[_loc5_]);
                  }
               }
               else
               {
                  if(!param3)
                  {
                     _loc5_ = new SimpleMovie();
                  }
                  _loc5_.name = param1[_loc8_];
                  pushMovie(param1[_loc8_],_loc5_,param2);
               }
            }
            else
            {
               if(!param3)
               {
                  _loc5_ = new SimpleMovie();
               }
               if(!isZlibPath(param1[_loc8_]))
               {
                  _loc6_ = new MovieLoader(param1[_loc8_],param3);
               }
               Director.instance.addEventOnce(_loc6_,"loader_complete",__onLoaderComplete);
               _loc7_.addLoader(_loc6_);
               _loc5_.name = param1[_loc8_];
               pushMovie(param1[_loc8_],_loc5_,param2);
            }
            _loc9_.push(_loc5_);
            _loc8_++;
         }
         if(_loc7_.totalChildren > 0)
         {
            load(_loc7_);
         }
         return _loc9_;
      }
      
      private function isZlibPath(param1:String) : Boolean
      {
         var _loc2_:String = param1.substr(param1.length - 4,4);
         if(_loc2_ == ".zmg")
         {
            return true;
         }
         return false;
      }
      
      private function __onLoaderComplete(param1:BaseEvent) : void
      {
         var _loc3_:BaseLoader = param1.currentTarget as BaseLoader;
         var _loc2_:Object = _movieDic[_loc3_.path];
         if(_loc2_)
         {
            for each(var _loc4_:Object in _loc2_)
            {
               if(_loc4_.movie != null)
               {
                  _loc4_.movie.data = getGlobalResource(_loc3_.path)["movieData"];
               }
               if(_loc4_.callback != null)
               {
                  _loc4_.callback.apply(null,[_loc4_.movie]);
               }
            }
            _movieDic[_loc3_.path] = null;
            delete _movieDic[_loc3_.path];
         }
      }
      
      private function pushMovie(param1:String, param2:Object, param3:Function = null) : void
      {
         if(_movieDic[param1])
         {
            _movieDic[param1].push({
               "movie":param2,
               "path":param1,
               "callback":param3
            });
         }
         else
         {
            _movieDic[param1] = [{
               "movie":param2,
               "path":param1,
               "callback":param3
            }];
         }
      }
      
      public function hasMovie(param1:String) : Boolean
      {
         if(getGlobalResource(param1) is MovieLoader)
         {
            return true;
         }
         return false;
      }
      
      public function hasResource(param1:String) : Boolean
      {
         if(getGlobalResource(param1) is BaseLoader)
         {
            return true;
         }
         if(getResourceByKey(param1) is BaseLoader)
         {
            return true;
         }
         var _loc2_:ApplicationDomain = ApplicationDomain.currentDomain;
         if(_loc2_.hasDefinition(param1))
         {
            return true;
         }
         return false;
      }
      
      public function disposeBitmapData(param1:BitmapData) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:String = _bitmapDic[param1];
         if(_loc2_)
         {
            disposeBitmapByName(_loc2_);
         }
         else
         {
            param1.dispose();
            param1 = null;
         }
      }
      
      public function disposeBitmapByName(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         var _loc3_:* = null;
         var _loc4_:Object = _quoteBitmap[param1];
         if(_loc4_)
         {
            if(releaseBitmapDataByName(param1) <= 0)
            {
               _loc2_ = _loc4_["data"];
               _bitmapDic[_loc2_] = null;
               _quoteBitmap[param1] = null;
               delete _bitmapDic[_loc2_];
               delete _quoteBitmap[param1];
               deleteObject(_loc4_);
               if(getResourceByKey(param1) is BitmapLoader)
               {
                  dispose(param1);
               }
               _loc2_.dispose();
               _loc2_ = null;
            }
         }
      }
      
      basegame_internal function releaseBitmapData(param1:BitmapData) : int
      {
         var _loc2_:String = _bitmapDic[param1];
         return releaseBitmapDataByName(_loc2_);
      }
      
      basegame_internal function releaseBitmapDataByName(param1:String) : int
      {
         var _loc2_:Object = null;
         if(param1)
         {
            _loc2_ = _quoteBitmap[param1];
            _loc2_["quote"] -= 1;
         }
         return _loc2_["quote"];
      }
      
      private function getClassLink(param1:String) : Object
      {
         var _loc2_:Object = null;
         var _loc3_:ApplicationDomain = ApplicationDomain.currentDomain;
         if(_loc3_.hasDefinition(param1))
         {
            _loc2_ = new (Class(_loc3_.getDefinition(param1)))();
         }
         else
         {
            _loc2_ = null;
         }
         return _loc2_;
      }
      
      public function getAtfData(param1:String) : AtfData
      {
         var _loc4_:AtfData = null;
         var _loc2_:Object = _quoteTexture[param1];
         if(_loc2_ != null)
         {
            _loc2_["quote"] += 1;
            return _loc2_["data"] as AtfData;
         }
         var _loc3_:BaseLoader = ResourcesManager.instance.getGlobalResource(param1);
         if(_loc3_ == null)
         {
            _loc4_ = _atlasMapping[param1];
         }
         else if(_loc3_ is TextureLoader)
         {
            _loc4_ = (_loc3_ as TextureLoader).atfData;
         }
         if(_loc4_ == null)
         {
            throw new Error("atf资源不存在，name=" + param1);
         }
         if(_loc4_ != null)
         {
            _textureDic[_loc4_] = param1;
            _quoteTexture[param1] = {
               "quote":1,
               "data":_loc4_
            };
         }
         return _loc4_;
      }
      
      public function disposeTexture(param1:AtfData) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:String = _textureDic[param1];
         if(_loc2_)
         {
            disposeTextureByName(_loc2_);
         }
         else
         {
            param1.dispose();
         }
      }
      
      public function disposeTextureByName(param1:String) : void
      {
         var _loc2_:AtfData = null;
         var _loc3_:Object = _quoteTexture[param1];
         if(_loc3_)
         {
            _loc3_["quote"] -= 1;
            _loc2_ = _loc3_["data"];
            if(_loc3_["quote"] <= 0)
            {
               _textureDic[_loc2_] = null;
               _quoteTexture[param1] = null;
               delete _textureDic[_loc2_];
               delete _quoteTexture[param1];
               deleteObject(_loc3_);
               if(getResourceByKey(param1) is TextureLoader)
               {
                  dispose(param1);
               }
               _loc2_.dispose();
            }
         }
      }
      
      public function getObjByKey(param1:String) : Object
      {
         return _objGlobalDic[param1];
      }
      
      public function getGlobalResource(param1:String) : BaseLoader
      {
         return _resGlobalDic[param1];
      }
      
      public function getResourceByKey(param1:String) : BaseLoader
      {
         var _loc2_:BaseLoader = _resDic[param1];
         if(_loc2_)
         {
            return _loc2_;
         }
         return null;
      }
      
      public function dispose(param1:String) : void
      {
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc2_:BaseLoader = _resDic[param1];
         if(!_loc2_)
         {
            _loc2_ = _resGlobalDic[param1];
         }
         disposeByLoader(_loc2_);
      }
      
      public function disposeByLoader(param1:BaseLoader) : void
      {
         var _loc2_:int = _loadQueue.indexOf(param1);
         if(param1 == null)
         {
            return;
         }
         _resDic[param1.path] = null;
         _resGlobalDic[param1.path] = null;
         delete _resGlobalDic[param1.path];
         delete _resDic[param1.path];
         if(_loc2_ > -1)
         {
            _loadQueue.splice(_loc2_,1);
            Director.instance.trace(0,"[resourcesManager]","资源还未加载成功就要释放<" + param1.path + ">请检查代{invalid_utf8=231}{invalid_utf8=160}?");
         }
         param1.dispose();
      }
      
      public function disposeAll() : void
      {
         var _loc1_:BaseLoader = null;
         for(var _loc2_:String in _resGlobalDic)
         {
            _loc1_ = _resGlobalDic[_loc2_] as BaseLoader;
            _resGlobalDic[_loc2_] = null;
            delete _resGlobalDic[_loc2_];
            if(_loc1_)
            {
               _loc1_.dispose();
            }
         }
         for(_loc2_ in _resDic)
         {
            _resDic[_loc2_] = null;
         }
         for(_loc2_ in _objGlobalDic)
         {
            ObjectUtil.dispose(_objGlobalDic[_loc2_]);
            _objGlobalDic[_loc2_] = null;
         }
      }
   }
}

