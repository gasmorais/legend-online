package com.speedEngine.res
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   import com.speedEngine.game.event.BaseEvent;
   import flash.utils.Dictionary;
   
   use namespace basegame_internal;
   
   public class QueueLoader extends BaseLoader
   {
      
      protected var _queue:Vector.<BaseLoader> = new Vector.<BaseLoader>();
      
      protected var _extendQueue:Vector.<BaseLoader> = new Vector.<BaseLoader>();
      
      protected var _childrenHasLoad:int = 0;
      
      protected var _childrenIsLoading:int = 0;
      
      public function QueueLoader()
      {
         super();
      }
      
      public function loaderProgress() : Number
      {
         return _childrenHasLoad / _queue.length;
      }
      
      public function get queue() : Vector.<BaseLoader>
      {
         return _queue;
      }
      
      public function get extendQueue() : Vector.<BaseLoader>
      {
         return _extendQueue;
      }
      
      public function get childrenHasLoad() : int
      {
         return _childrenHasLoad;
      }
      
      public function get totalChildren() : int
      {
         return _queue.length;
      }
      
      public function initQueue(param1:Dictionary = null, param2:Dictionary = null, param3:Dictionary = null, param4:Dictionary = null, param5:Function = null) : void
      {
         var resLnk:Dictionary = param1;
         var globalLnk:Dictionary = param2;
         var globalObjLnk:Dictionary = param3;
         var atlasMapping:Dictionary = param4;
         var eventCallback:Function = param5;
         var recurExtend:* = function(param1:QueueLoader):void
         {
            var _loc2_:BaseLoader = null;
            var _loc4_:int = 0;
            param1.inResLink = resLnk;
            param1.inGlobalLink = globalLnk;
            param1.inGlobalObjLink = globalObjLnk;
            param1.inAtlasMapping = atlasMapping;
            var _loc3_:Vector.<BaseLoader> = param1.queue;
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = _loc3_[_loc4_];
               if(_loc2_ is QueueLoader)
               {
                  if(eventCallback != null)
                  {
                     Director.instance.addEvent(_loc2_,"loader_complete",eventCallback);
                  }
                  if(!(_loc2_ is AssistQueueLoader))
                  {
                     if(resLnk[_loc2_.path] == null)
                     {
                        resLnk[_loc2_.path] = _loc2_;
                     }
                     if(globalLnk[_loc2_.path] == null)
                     {
                        globalLnk[_loc2_.path] = _loc2_;
                     }
                  }
                  QueueLoader(_loc2_).initQueue(resLnk,globalLnk,globalObjLnk,atlasMapping,eventCallback);
                  recurExtend(_loc2_ as QueueLoader);
               }
               else
               {
                  _loc2_.inResLink = resLnk;
                  _loc2_.inGlobalLink = globalLnk;
                  _loc2_.inGlobalObjLink = globalObjLnk;
                  _loc2_.inAtlasMapping = atlasMapping;
                  _extendQueue.push(_loc2_);
               }
               _loc4_++;
            }
         };
         _childrenHasLoad = 0;
         recurExtend(this);
      }
      
      public function addLoader(param1:BaseLoader) : void
      {
         param1.parent = this;
         Director.instance.addEventOnce(param1,"loader_error",__onErrorHandler);
         _queue.push(param1);
      }
      
      private function __onErrorHandler(param1:BaseEvent) : void
      {
         Director.instance.dispatchEventWith(this,"loader_error",param1.data);
      }
      
      public function signalLoadChild(param1:BaseLoader) : void
      {
         _childrenIsLoading = _childrenIsLoading + 1;
      }
      
      public function signalCompleteChild(param1:BaseLoader) : void
      {
         Director.instance.dispatchEventWith(this,"part_complete",param1);
         _childrenHasLoad = _childrenHasLoad + 1;
         if(_childrenHasLoad >= totalChildren)
         {
            __onComplete();
         }
      }
      
      protected function __onComplete() : void
      {
         Director.instance.dispatchEventWith(this,"loader_complete",this);
         if(parent != null)
         {
            parent.signalCompleteChild(this);
         }
      }
      
      public function childDispose(param1:BaseLoader) : void
      {
         var _loc2_:int = _queue.indexOf(param1);
         if(_loc2_ > -1)
         {
            _queue.splice(_loc2_,1);
            if(_queue.length == 0)
            {
               dispose();
            }
         }
      }
      
      override protected function destory() : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc1_:int = int(_queue.length);
         _loc3_ = 0;
         while(_loc3_ < _loc1_)
         {
            ResourcesManager.instance.disposeByLoader(_queue[_loc3_]);
            _loc3_++;
         }
         _queue.length = 0;
         _extendQueue.length = 0;
         super.destory();
      }
   }
}

