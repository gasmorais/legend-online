package yishi.utils
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class TimerUtils
   {
      
      private static var _timerVec:Vector.<TimerModel>;
      
      private static var _timer:Timer;
      
      public function TimerUtils()
      {
         super();
      }
      
      public static function setTimeout(param1:Function, param2:Number) : void
      {
         var closure:Function = param1;
         var delay:Number = param2;
         var onTimerComplete:* = function(param1:TimerEvent):void
         {
            if(timer)
            {
               timer.stop();
               timer.removeEventListener("timerComplete",onTimerComplete);
               timer = null;
            }
            if(closure != null)
            {
               closure();
            }
         };
         var timer:Timer = new Timer(delay,1);
         timer.addEventListener("timerComplete",onTimerComplete);
         timer.start();
      }
      
      public static function convertToTimestamp(param1:String) : Number
      {
         var _loc9_:Array = param1.split(" ");
         var _loc10_:Array = _loc9_[0].split("-");
         var _loc2_:Array = _loc9_[1].split(":");
         var _loc7_:int = int(_loc10_[0]);
         var _loc6_:int = int(_loc10_[1]) - 1;
         var _loc11_:int = int(_loc10_[2]);
         var _loc4_:int = int(_loc2_[0]);
         var _loc8_:int = int(_loc2_[1]);
         var _loc5_:int = int(_loc2_[2]);
         var _loc3_:Date = new Date(_loc7_,_loc6_,_loc11_,_loc4_,_loc8_,_loc5_);
         return _loc3_.getTime();
      }
      
      public static function addSecendTimer(param1:String, param2:Number = 1, param3:int = 0, param4:Function = null, param5:Function = null) : void
      {
         if(_timerVec == null)
         {
            _timerVec = new Vector.<TimerModel>();
         }
         var _loc6_:TimerModel = new TimerModel();
         _loc6_.timerID = param1;
         _loc6_.completeFun = param5;
         _loc6_.timerFun = param4;
         _loc6_.count = param3;
         _loc6_.delay = param2;
         _timerVec[_timerVec.length] = _loc6_;
         if(_timer == null)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",__onTimerHanler);
            _timer.start();
         }
      }
      
      public static function removeSecendTimer(param1:String) : void
      {
         if(_timerVec == null || _timerVec.length == 0)
         {
            return;
         }
         var _loc2_:int = int(_timerVec.length);
         while(_loc2_ > 0)
         {
            if(_timerVec[_loc2_ - 1].timerID == param1)
            {
               _timerVec.splice(_loc2_ - 1,1);
               break;
            }
            _loc2_--;
         }
      }
      
      public static function hasTime(param1:String) : Boolean
      {
         var _loc2_:int = int(_timerVec.length);
         while(_loc2_ > 0)
         {
            if(_timerVec[_loc2_ - 1].timerID == param1)
            {
               return true;
            }
            _loc2_--;
         }
         return false;
      }
      
      public static function getTime(param1:String) : int
      {
         var _loc2_:int = int(_timerVec.length);
         while(_loc2_ > 0)
         {
            if(_timerVec[_loc2_ - 1].timerID == param1)
            {
               return _timerVec[_loc2_ - 1].count;
            }
            _loc2_--;
         }
         return 0;
      }
      
      private static function __onTimerHanler(param1:TimerEvent) : void
      {
         var _loc2_:int = int(_timerVec.length);
         if(_loc2_ == 0)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__onTimerHanler);
            _timer = null;
            return;
         }
         while(_loc2_ > 0)
         {
            if(_timerVec[_loc2_ - 1])
            {
               _timerVec[_loc2_ - 1].onTimerFun();
               if(_timerVec.length > _loc2_ - 1 && _timerVec[_loc2_ - 1].count <= 0)
               {
                  _timerVec.splice(_loc2_ - 1,1);
               }
            }
            _loc2_--;
         }
      }
   }
}

class TimerModel
{
   
   public var delay:Number;
   
   public var count:int;
   
   public var completeFun:Function;
   
   public var timerFun:Function;
   
   public var timerID:String;
   
   private var _tmpCount:int;
   
   public function TimerModel()
   {
      super();
   }
   
   public function onTimerFun() : void
   {
      if(count <= 0)
      {
         if(null != completeFun)
         {
            completeFun.apply();
            return;
         }
      }
      if(count != 99999)
      {
         count = Number(count) - 1;
      }
      if(null != timerFun)
      {
         timerFun.apply();
      }
   }
}
