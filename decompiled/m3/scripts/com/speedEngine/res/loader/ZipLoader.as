package com.speedEngine.res.loader
{
   import com.speedEngine.components.manager.UIFactory;
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.res.AssistQueueLoader;
   import com.speedEngine.res.BaseLoader;
   import com.speedEngine.res.ResourcesManager;
   import com.speedEngine.utils.zip.ZipReader;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   use namespace basegame_internal;
   
   public class ZipLoader extends BaseLoader
   {
      
      protected var _loader:URLStream;
      
      protected var _swfLoader:Loader = new Loader();
      
      protected var _swfQueue:Array = [];
      
      protected var _swfLoading:Boolean = false;
      
      protected var _zip:ZipReader;
      
      private var _index:int = 0;
      
      private var _count:int = 0;
      
      private var _isSynchro:Boolean = true;
      
      private var _asynCallBack:Function;
      
      private var _stepCount:int = 0;
      
      private var _xmlList:Array = [];
      
      private var _isWork:Boolean = true;
      
      private var _demarcation:Number = 0.3;
      
      private var _step:Number = 0;
      
      private var _resLen:int;
      
      private var _progressCallBack:Function;
      
      private var _fps:int = 1 / Director.instance.stage2d.frameRate * 1000;
      
      private var _fpsCount:int = 2;
      
      private var _timer:Number = 0;
      
      private var _fpsIndex:int = 0;
      
      private var _isOK:Boolean = false;
      
      private var _isHandUncompress:Boolean = false;
      
      private var _loadBytes:ByteArray;
      
      private var _queueLoader:AssistQueueLoader = new AssistQueueLoader();
      
      public function ZipLoader(param1:String = "")
      {
         super();
         _path = param1;
         if(_path.search(/.zip$/gi) < 0 && param1 != "")
         {
            Director.instance.trace(1,"ZipLoader","加载的文件不是以zip为后{invalid_utf8=231}{invalid_utf8=188}?{invalid_utf8=231}{invalid_utf8=154}?");
         }
      }
      
      override public function addWaiter(param1:BaseLoader) : void
      {
         super.addWaiter(param1);
      }
      
      override public function get complete() : Boolean
      {
         return super.complete;
      }
      
      override protected function destory() : void
      {
         if(_loader)
         {
            _loader.close();
         }
         if(_swfLoader)
         {
            _swfLoader.unloadAndStop();
         }
         if(_swfQueue)
         {
            _swfQueue.splice(0,_swfQueue.length);
         }
         _loader = null;
         _swfLoader = null;
         _asynCallBack = null;
         super.destory();
      }
      
      override basegame_internal function load() : void
      {
         if(_path == "" || _loadBytes != null)
         {
            return;
         }
         if(!_loader)
         {
            _loader = new URLStream();
         }
         _index = _count = 0;
         _stepCount = 0;
         _resLen = 0;
         _timer = 0;
         _fpsIndex = 0;
         _isOK = false;
         var _loc1_:URLRequest = new URLRequest(path);
         _loader.load(_loc1_);
         _loader.addEventListener("complete",__onComplete);
         _loader.addEventListener("ioError",__onError);
         _loader.addEventListener("progress",__onProgress);
      }
      
      public function loadBytes(param1:ByteArray, param2:String = "") : void
      {
         _loadBytes = param1;
         _path = param2;
         ResourcesManager.instance.load(this);
         setProgress(_demarcation);
         __onComplete(null);
      }
      
      override protected function __onProgress(param1:ProgressEvent) : void
      {
         super.__onProgress(param1);
         setProgress(int(param1.bytesLoaded / param1.bytesTotal * 100 * _demarcation) * 0.01);
         _step = _progress;
      }
      
      protected function __onComplete(param1:Event) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         if(param1 != null)
         {
            _loader.readBytes(_loc2_,0,_loader.bytesAvailable);
         }
         else
         {
            if(!(param1 == null && _loadBytes != null))
            {
               return;
            }
            _loc2_ = _loadBytes;
         }
         _zip = new ZipReader(_loc2_);
         if(isSynchro)
         {
            _asynCallBack = callback;
            Director.instance.addEnterFrameEvent(__onNextFrame);
         }
         else
         {
            Director.instance.dispatchEventWith(this,"loadercomplete",this);
            if(!isHandUncompress)
            {
               Director.instance.addEnterFrameEvent(__onNextFrame);
            }
         }
         removeEvent();
      }
      
      public function handUncompress() : void
      {
         if(isHandUncompress)
         {
            Director.instance.addEnterFrameEvent(__onNextFrame);
         }
      }
      
      protected function callback() : void
      {
         Director.instance.dispatchEventWith(this,"loadercomplete",this);
      }
      
      protected function __onNextFrame(param1:Event = null) : void
      {
         if(_isOK)
         {
            Director.instance.removeEnterFrameEvent(__onNextFrame);
         }
         else
         {
            uncompress();
         }
      }
      
      protected function uncompress() : void
      {
         var _loc3_:ByteArray = null;
         var _loc7_:String = null;
         var _loc6_:Number = NaN;
         var _loc5_:BitmapLoader = null;
         var _loc10_:int = 0;
         var _loc4_:Array = null;
         var _loc8_:String = null;
         var _loc1_:int = 0;
         _timer = getTimer();
         var _loc9_:Array = _zip.names;
         var _loc2_:int = int(_loc9_.length);
         _loc10_ = _fpsIndex;
         while(_loc10_ < _loc2_)
         {
            _loc7_ = _loc9_[_loc10_];
            _loc4_ = _loc7_.match(/.swf$|.xml$|.png$|.jpg|.atl$|.json$/gi);
            if(_loc4_.length > 0)
            {
               _loc3_ = _zip.getFile(_loc7_);
               if(_isWork)
               {
                  switch(_loc4_[0])
                  {
                     case ".swf":
                        _count = _count + 1;
                        _resLen = _resLen + 1;
                        _swfQueue.push(_loc3_);
                        break;
                     case ".xml":
                        _resLen = _resLen + 1;
                        _loc8_ = path.replace(/\/*\w+.zip$/gi,"");
                        _loc8_ = _loc8_ != "" ? _loc8_ + "/" : _loc8_;
                        _loc7_ = _loc8_ + _loc7_;
                        _xmlList[_loc7_] = new XML(_loc3_);
                        break;
                     case ".png":
                     case ".jpg":
                        _loc8_ = path.replace(/\/*\w+.zip$/gi,"");
                        _loc8_ = _loc8_ != "" ? _loc8_ + "/" : _loc8_;
                        _loc7_ = _loc8_ + _loc7_;
                        _loc5_ = new BitmapLoader(null);
                        _loc5_.loadBytes(_loc3_,_loc7_);
                        _queueLoader.addLoader(_loc5_);
                        break;
                     case ".atl":
                        break;
                     case ".json":
                        _xmlList[_loc7_] = _loc3_.readUTFBytes(_loc3_.bytesAvailable);
                  }
               }
               else
               {
                  _loc8_ = path != "" ? path + "/" : _loc8_;
                  _loc7_ = _loc8_ + _loc7_;
                  globalObjLink[_loc7_] = _loc3_;
               }
               _loc1_ = Math.ceil(_loc10_ / _loc2_ * 100 * (1 - _demarcation));
               setProgress(_step + _loc1_ * 0.01);
               _loc6_ = getTimer();
               if(_loc6_ - _timer >= _fps || _loc10_ - _fpsIndex >= _fpsCount)
               {
                  _fpsIndex = _loc10_ + 1;
                  return;
               }
            }
            _loc10_++;
         }
         _isOK = true;
         if(!_isWork)
         {
            if(_asynCallBack != null)
            {
               _asynCallBack();
               _asynCallBack = null;
            }
         }
         else
         {
            work();
         }
      }
      
      private function work() : void
      {
         if(_queueLoader.totalChildren > 0)
         {
            Director.instance.addEvent(_queueLoader,"loader_complete",__onLoadComplete);
            ResourcesManager.instance.load(_queueLoader);
         }
         else
         {
            loadSwf();
         }
      }
      
      private function __onLoadComplete(param1:Object) : void
      {
         loadSwf();
      }
      
      private function workComplete() : void
      {
         _stepCount = _stepCount + 1;
         if(_stepCount == 2 && _asynCallBack != null)
         {
            setProgress(1);
            _asynCallBack();
         }
      }
      
      protected function __onCreateUIComplete(param1:Event) : void
      {
         workComplete();
      }
      
      protected function loadSwf(param1:ByteArray = null) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:LoaderContext = null;
         if(param1)
         {
            _swfQueue.push(param1);
            if(_swfLoading)
            {
               return;
            }
         }
         if(_swfQueue.length > 0)
         {
            _swfLoading = true;
            _loc2_ = _swfQueue.shift();
            _loc3_ = new LoaderContext();
            _loc3_.applicationDomain = ApplicationDomain.currentDomain;
            try
            {
               _loc3_.allowLoadBytesCodeExecution = true;
            }
            catch(e:Error)
            {
            }
            _swfLoader.loadBytes(_loc2_,_loc3_);
            _swfLoader.contentLoaderInfo.addEventListener("complete",__SwfComplete);
         }
         else if(_index == _count)
         {
            workComplete();
            createUI();
         }
      }
      
      protected function createUI() : void
      {
         var _loc2_:Object = null;
         var _loc3_:* = undefined;
         var _loc1_:int = 0;
         for(var _loc4_:String in _xmlList)
         {
            _loc1_++;
            _loc3_ = _xmlList[_loc4_];
            if(_loc3_..component.length() != 0)
            {
               _loc2_ = {};
               _loc2_.name = _loc4_;
               globalObjLink[_loc4_] = _loc2_;
               UIFactory.instance.addEventListener("create_ui_complete",__onCreateUIComplete);
               UIFactory.instance.addUIFile(_loc4_,_loc3_,_loc2_);
               _loc2_.tinyLoader = this;
            }
         }
         if(_loc1_ == 0)
         {
            __onCreateUIComplete(null);
         }
      }
      
      protected function __SwfComplete(param1:Event) : void
      {
         _index = _index + 1;
         _swfLoading = false;
         _swfLoader.unload();
         _swfLoader.contentLoaderInfo.removeEventListener("complete",__SwfComplete);
         loadSwf();
      }
      
      protected function removeEvent() : void
      {
         if(_loader)
         {
            _loader.removeEventListener("progress",__onProgress);
            _loader.removeEventListener("ioError",__onError);
            _loader.removeEventListener("complete",__onComplete);
         }
      }
      
      public function get asynCallBack() : Function
      {
         return _asynCallBack;
      }
      
      public function set asynCallBack(param1:Function) : void
      {
         _asynCallBack = param1;
      }
      
      public function get isSynchro() : Boolean
      {
         return _isSynchro;
      }
      
      public function set isSynchro(param1:Boolean) : void
      {
         _isSynchro = param1;
      }
      
      private function setProgress(param1:Number) : void
      {
         _progress = param1;
         if(progressCallBack != null)
         {
            progressCallBack.call(null,_progress);
         }
      }
      
      public function get progressCallBack() : Function
      {
         return _progressCallBack;
      }
      
      public function set progressCallBack(param1:Function) : void
      {
         _progressCallBack = param1;
      }
      
      public function get isHandUncompress() : Boolean
      {
         return _isHandUncompress;
      }
      
      public function set isHandUncompress(param1:Boolean) : void
      {
         _isHandUncompress = param1;
      }
      
      public function get isWork() : Boolean
      {
         return _isWork;
      }
      
      public function set isWork(param1:Boolean) : void
      {
         _isWork = param1;
      }
      
      public function get fpsCount() : int
      {
         return _fpsCount;
      }
      
      public function set fpsCount(param1:int) : void
      {
         _fpsCount = param1;
      }
   }
}

