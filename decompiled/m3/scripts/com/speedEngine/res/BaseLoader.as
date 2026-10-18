package com.speedEngine.res
{
   import avmplus.getQualifiedClassName;
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.event.BaseEvent;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.utils.Dictionary;
   
   use namespace basegame_internal;
   
   public class BaseLoader extends EventDispatcher
   {
      
      protected var _path:String;
      
      internal var parent:QueueLoader;
      
      internal var isLoading:Boolean = false;
      
      internal var hasLoaded:Boolean = false;
      
      internal var inResLink:Dictionary;
      
      internal var inGlobalLink:Dictionary;
      
      internal var inGlobalObjLink:Dictionary;
      
      internal var inAtlasMapping:Dictionary;
      
      internal var waitLoading:Vector.<BaseLoader>;
      
      protected var _progress:Number = 0;
      
      public var fileType:String;
      
      private var _isWaitDispose:Boolean = false;
      
      private var _isDispose:Boolean;
      
      public function BaseLoader()
      {
         super();
         Director.instance.addEvent(this,"loader_complete",__onCompleteForWaiter);
      }
      
      private function __onErrorForWaiter(param1:IOErrorEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BaseLoader = null;
         var _loc4_:int = 0;
         if(waitLoading)
         {
            _loc2_ = int(waitLoading.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = waitLoading[_loc4_];
               _loc3_.hasLoaded = false;
               _loc3_.__onError(param1);
               _loc4_++;
            }
         }
         dispose();
      }
      
      public function get resLink() : Dictionary
      {
         return inResLink;
      }
      
      public function get globalLink() : Dictionary
      {
         return inGlobalLink;
      }
      
      public function get globalObjLink() : Dictionary
      {
         return inGlobalObjLink;
      }
      
      public function get atlasMapping() : Dictionary
      {
         return inAtlasMapping;
      }
      
      public function get path() : String
      {
         return _path;
      }
      
      public function get complete() : Boolean
      {
         return hasLoaded;
      }
      
      basegame_internal function load() : void
      {
      }
      
      protected function __onProgress(param1:ProgressEvent) : void
      {
         _progress = int(param1.bytesLoaded / param1.bytesTotal * 100) * 0.01;
         Director.instance.dispatchEventWith(this,"loader_progress",_progress);
      }
      
      public function addWaiter(param1:BaseLoader) : void
      {
         if(waitLoading == null)
         {
            waitLoading = new Vector.<BaseLoader>();
         }
         waitLoading.push(param1);
      }
      
      protected function __onCompleteForWaiter(param1:BaseEvent) : void
      {
         if(waitLoading)
         {
            Director.instance.addEnterFrameEvent(onEnter);
         }
      }
      
      protected function __onError(param1:IOErrorEvent) : void
      {
         __onErrorForWaiter(param1);
         Director.instance.dispatchEventWith(this,"loaderror",param1.text);
         Director.instance.dispatchEventWith(this,"loader_error",param1.text);
         Director.instance.trace(0,getQualifiedClassName(this),param1.text);
      }
      
      private function onEnter() : void
      {
         if(waitLoading.length == 0)
         {
            Director.instance.removeEnterFrameEvent(onEnter);
            if(_isWaitDispose)
            {
               dispose();
            }
            return;
         }
         var _loc1_:BaseLoader = waitLoading.shift();
         _loc1_.hasLoaded = true;
         Director.instance.dispatchEventWith(_loc1_,"loadercomplete",_loc1_);
      }
      
      basegame_internal function dispose() : void
      {
         if(_isDispose)
         {
            return;
         }
         destory();
      }
      
      protected function destory() : void
      {
         if(waitLoading && waitLoading.length > 0)
         {
            _isWaitDispose = true;
            return;
         }
         Director.instance.removeEnterFrameEvent(onEnter);
         Director.instance.removeEvent(this,"loader_complete",__onCompleteForWaiter);
         Director.instance.removeEvent(this,"loader_error",__onErrorForWaiter);
         if(resLink)
         {
            delete resLink[_path];
         }
         if(globalLink)
         {
            delete globalLink[_path];
         }
         if(waitLoading)
         {
            waitLoading.length = 0;
         }
         parent = null;
         inResLink = null;
         inGlobalLink = null;
         inGlobalObjLink = null;
         inAtlasMapping = null;
         waitLoading = null;
         if(parent)
         {
            parent.childDispose(this);
         }
         _isDispose = true;
      }
      
      public function get progress() : Number
      {
         return _progress;
      }
   }
}

