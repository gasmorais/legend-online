package yishi.comm.check
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import yishi.comm.PackageOut;
   import yishi.comm.SocketEvent;
   
   public class PackageCheckModel extends EventDispatcher
   {
      
      private static const ERROR_MAX_COUNT:int = 20;
      
      private var _packageNotes:Dictionary = new Dictionary(true);
      
      private var _count:Number = 0;
      
      private var _preClearTime:Number = 0;
      
      private var _offTime:int = 0;
      
      public function PackageCheckModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function addPackage(param1:PackageOut) : void
      {
         var _loc2_:Number = NaN;
         if(_packageNotes[param1.code])
         {
            _packageNotes[param1.code] = int(_packageNotes[param1.code]) + 1;
         }
         else
         {
            _packageNotes[param1.code] = 1;
         }
         _count = _count + 1;
         if(_count % 20 == 0)
         {
            _loc2_ = getTimer();
            _offTime = _loc2_ - _preClearTime;
            _offTime = Math.floor(_offTime / 1000);
            if(_offTime > 1)
            {
               check();
               _preClearTime = _loc2_;
               _count = 0;
            }
         }
      }
      
      private function check() : void
      {
         var _loc1_:int = 0;
         for(var _loc2_:String in _packageNotes)
         {
            _loc1_ = int(_packageNotes[_loc2_]) / _offTime;
            if(_loc1_ > 20)
            {
               throw new Error("7 Road Socket Close：" + _loc2_);
            }
         }
         clearAllPackageNotes();
      }
      
      private function clearAllPackageNotes() : void
      {
         for(var _loc1_:String in _packageNotes)
         {
            _packageNotes[_loc1_] = 0;
         }
      }
   }
}

