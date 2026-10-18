package yishi.utils
{
   public class MsgMan
   {
      
      protected static var observerMap:Array = [];
      
      public function MsgMan()
      {
         super();
      }
      
      public static function addObserver(param1:String, param2:Object, param3:Function) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = observerMap[param1];
         if(_loc5_ != null && _loc5_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length)
            {
               if(param3 == _loc5_[_loc4_].fun as Function)
               {
                  return;
               }
               _loc4_++;
            }
            _loc5_.push({
               "context":param2,
               "fun":param3
            });
         }
         else
         {
            observerMap[param1] = [{
               "context":param2,
               "fun":param3
            }];
         }
      }
      
      public static function removeObserver(param1:String, param2:Object, param3:Function) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = observerMap[param1];
         if(_loc5_ != null && _loc5_.length > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc5_.length)
            {
               if(param2 == _loc5_[_loc4_].context && param3 == _loc5_[_loc4_].fun as Function)
               {
                  _loc5_.splice(_loc4_,1);
                  observerMap[param1] = _loc5_;
                  if(_loc5_.length < 1)
                  {
                     observerMap[param1] = null;
                  }
                  return;
               }
               _loc4_++;
            }
         }
      }
      
      public static function notifyObserver(param1:String, param2:Object = null) : void
      {
         var _loc5_:Array = null;
         var _loc4_:Array = null;
         if(observerMap[param1] != null)
         {
            _loc5_ = observerMap[param1] as Array;
            _loc4_ = [];
            _loc4_ = _loc4_.concat(_loc5_);
            for each(var _loc3_:Object in _loc4_)
            {
               (_loc3_.fun as Function).apply(_loc3_.context,[param1,param2]);
            }
         }
      }
   }
}

