package yishi.utils
{
   public class CallBacker
   {
      
      private var _listeners:Array = [];
      
      private var _singleListeners:Array = [];
      
      private var _target:Object;
      
      private var _data:*;
      
      public function CallBacker(param1:Object = null)
      {
         super();
         _target = param1 || this;
      }
      
      public function addListener(param1:Function) : void
      {
         if(_listeners.indexOf(param1) < 0)
         {
            _listeners.push(param1);
         }
      }
      
      public function removeListener(param1:Function) : void
      {
         var _loc2_:int = 0;
         if(_listeners)
         {
            _loc2_ = _listeners.indexOf(param1);
            if(_loc2_ < 0)
            {
               return;
            }
            _listeners.splice(_loc2_,1);
         }
      }
      
      public function dispatch(param1:* = null) : void
      {
         var _loc3_:int = 0;
         _data = param1;
         var _loc4_:Array = [].concat(_listeners);
         for each(var _loc2_:Function in _loc4_)
         {
            if(_loc2_ != null)
            {
               if(_loc2_.length > 0)
               {
                  _loc2_(this);
               }
               else
               {
                  _loc2_();
               }
            }
            if(_singleListeners)
            {
               _loc3_ = _singleListeners.indexOf(_loc2_);
               if(_loc3_ > 0)
               {
                  removeListener(_loc2_);
                  _singleListeners.splice(_loc3_,1);
               }
            }
         }
      }
      
      public function addSingleListener(param1:Function) : void
      {
         if(_singleListeners.indexOf(param1) < 0)
         {
            _singleListeners.push(param1);
            addListener(param1);
         }
      }
      
      public function removeAllListeners() : void
      {
         _listeners = [];
         _singleListeners = [];
      }
      
      public function get target() : Object
      {
         return _target;
      }
      
      public function get listenerLength() : int
      {
         return _listeners.length;
      }
      
      public function get data() : *
      {
         return _data;
      }
   }
}

