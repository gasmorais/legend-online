package com.pickgliss.loaderii
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.vo.FileVo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.HTTPStatusEvent;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   
   public class BaseLoaderII extends EventDispatcher
   {
      
      private static var ERROR_SCOPE:int = 3000;
      
      public var info:LoaderInfo;
      
      private var _urlLoader:URLLoader;
      
      private var _isLoading:Boolean = false;
      
      private var _currentLoadPath:String = "";
      
      private var _currentTryTime:int = 0;
      
      public function BaseLoaderII(param1:IEventDispatcher = null)
      {
         super(param1);
         _urlLoader = new URLLoader();
         _urlLoader.dataFormat = "binary";
         initEvent();
      }
      
      private function initEvent() : void
      {
         _urlLoader.addEventListener("complete",__onDataLoadComplete);
         _urlLoader.addEventListener("progress",__onProgress);
         _urlLoader.addEventListener("httpStatus",__onStatus);
         _urlLoader.addEventListener("ioError",__onIOError);
      }
      
      private function __onDataLoadComplete(param1:Event) : void
      {
         var _loc4_:ByteArray = null;
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc5_:FileVo = null;
         if(info)
         {
            if(info.oneselfSize)
            {
               _loc4_ = _urlLoader.data as ByteArray;
               _loc2_ = _loc4_.readInt();
               if(Math.abs(_loc2_ - _loc4_.bytesAvailable) >= ERROR_SCOPE)
               {
                  onLoadError();
                  return;
               }
               _loc3_ = new ByteArray();
               _loc4_.readBytes(_loc3_);
               onComplete(_loc3_);
               return;
            }
            _loc5_ = ComponentSetting.getFileVo(info.url);
            if(_loc5_)
            {
               if(_loc5_.md5 == info.md5)
               {
                  if(_loc5_.size != 0)
                  {
                     if(Math.abs(_loc5_.size - _urlLoader.data.length) >= ERROR_SCOPE)
                     {
                        onLoadError();
                        return;
                     }
                  }
               }
            }
         }
         onComplete(_urlLoader.data);
      }
      
      private function onComplete(param1:*) : void
      {
         _isLoading = false;
         dispatchEvent(new LoaderEventII("complete",info,param1));
      }
      
      private function __onProgress(param1:ProgressEvent) : void
      {
         if(info)
         {
            info.bytesLoaded = param1.bytesLoaded;
            info.bytesTotal = param1.bytesTotal;
         }
         dispatchEvent(new LoaderEventII("progress",info,null));
      }
      
      private function __onIOError(param1:IOErrorEvent) : void
      {
         onLoadError();
      }
      
      private function __onStatus(param1:HTTPStatusEvent) : void
      {
         if(param1.status > 399)
         {
            onLoadError();
         }
      }
      
      private function onLoadError() : void
      {
         var _loc1_:LoaderInfo = null;
         if(_currentTryTime < 3)
         {
            _currentTryTime = _currentTryTime + 1;
            startLoad(_currentLoadPath,null,false);
         }
         else if(_isLoading)
         {
            _loc1_ = info;
            LoaderManagerII.instance.notExist[_currentLoadPath] = true;
            if(_loc1_ && _loc1_.errorFun != null)
            {
               _loc1_.errorFun(_loc1_,null);
            }
            _isLoading = false;
            dispatchEvent(new LoaderEventII("complete",_loc1_,null));
         }
      }
      
      public function startLoad(param1:String, param2:URLVariables = null, param3:Boolean = true, param4:String = "GET") : void
      {
         _isLoading = true;
         if(param3)
         {
            _currentTryTime = 0;
            _currentLoadPath = param1;
         }
         var _loc5_:URLRequest = new URLRequest(_currentLoadPath);
         _loc5_.method = param4;
         _loc5_.data = param2;
         _urlLoader.load(_loc5_);
      }
      
      public function get isLoading() : Boolean
      {
         return _isLoading;
      }
      
      public function reset() : void
      {
         _isLoading = false;
         _urlLoader.data = null;
         info = null;
      }
   }
}

