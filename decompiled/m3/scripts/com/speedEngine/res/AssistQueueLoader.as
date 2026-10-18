package com.speedEngine.res
{
   import com.speedEngine.game.Director;
   import com.speedEngine.game.base.basegame_internal;
   
   use namespace basegame_internal;
   
   public class AssistQueueLoader extends QueueLoader
   {
      
      private var _disposeAuto:Boolean;
      
      private var _disposeDeep:Boolean;
      
      public function AssistQueueLoader(param1:Boolean = true, param2:Boolean = false)
      {
         super();
         _disposeAuto = param1;
         _disposeDeep = param2;
      }
      
      override public function loaderProgress() : Number
      {
         var _loc2_:int = 0;
         var _loc1_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _queue.length)
         {
            if(_queue[_loc2_] is QueueLoader)
            {
               _loc1_ += (_queue[_loc2_] as QueueLoader).loaderProgress();
            }
            _loc2_++;
         }
         return _loc1_ / _queue.length;
      }
      
      override protected function __onComplete() : void
      {
         super.__onComplete();
         if(_disposeAuto)
         {
            dispose();
         }
      }
      
      override protected function destory() : void
      {
         if(_disposeDeep)
         {
            super.destory();
         }
         else
         {
            Director.instance.removeEvent(this,"loader_complete",__onCompleteForWaiter);
            for each(var _loc1_:BaseLoader in _queue)
            {
               _loc1_.parent = null;
            }
            _queue.length = 0;
            _extendQueue.length = 0;
         }
      }
   }
}

