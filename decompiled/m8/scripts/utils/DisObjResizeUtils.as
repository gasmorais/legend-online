package utils
{
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class DisObjResizeUtils
   {
      
      public static const INTERVAL_TIME:int = 200;
      
      private static var _timer:Timer;
      
      private static var _autoRemoveList:Dictionary;
      
      private static var _manualRemoveList:Dictionary;
      
      private static var _offsetList:Dictionary;
      
      private static var _tempDisObj01:Object;
      
      private static var _tempDisObj02:Object;
      
      private static var _tempP:Point;
      
      private static var _tempOffsetPoint:Point;
      
      public function DisObjResizeUtils()
      {
         super();
      }
      
      public static function addTarget(param1:DisplayObject, param2:DisplayObject, param3:Point = null, param4:Boolean = true) : void
      {
         if(getListLen(_autoRemoveList) == 0 && getListLen(_manualRemoveList) == 0)
         {
            if(!_timer)
            {
               _timer = new Timer(200);
            }
            _timer.addEventListener("timer",__timerUpdateHandler);
            _timer.start();
         }
         if(!_autoRemoveList)
         {
            _autoRemoveList = new Dictionary();
         }
         if(!_manualRemoveList)
         {
            _manualRemoveList = new Dictionary();
         }
         if(!_offsetList)
         {
            _offsetList = new Dictionary();
         }
         if(param4)
         {
            _autoRemoveList[param1] = param2;
         }
         else
         {
            _manualRemoveList[param1] = param2;
         }
         if(param3)
         {
            _offsetList[param1] = param3;
         }
         else
         {
            _offsetList[param1] = null;
            delete _offsetList[param1];
         }
         __timerUpdateHandler(null);
      }
      
      public static function removeTarget(param1:DisplayObject) : void
      {
         if(_autoRemoveList)
         {
            _autoRemoveList[param1] = null;
            delete _autoRemoveList[param1];
         }
         if(_manualRemoveList)
         {
            _manualRemoveList[param1] = null;
            delete _manualRemoveList[param1];
         }
         if(_offsetList)
         {
            _offsetList[param1] = null;
            delete _offsetList[param1];
         }
      }
      
      public static function clear() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerUpdateHandler);
            _timer.stop();
            _timer = null;
         }
         _autoRemoveList = null;
         _manualRemoveList = null;
         _offsetList = null;
         _tempDisObj01 = null;
         _tempDisObj02 = null;
         _tempP = null;
         _tempOffsetPoint = null;
      }
      
      private static function __timerUpdateHandler(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         if(!_tempP)
         {
            _tempP = new Point();
         }
         for(_tempDisObj01 in _autoRemoveList)
         {
            _loc2_++;
            _tempDisObj02 = _autoRemoveList[_tempDisObj01];
            if(_tempDisObj01 && _tempDisObj01.stage && _tempDisObj02 && _tempDisObj02.stage)
            {
               _tempP.x = _tempDisObj02.x;
               _tempP.y = _tempDisObj02.y;
               _tempP = _tempDisObj02.parent.localToGlobal(_tempP);
               _tempP = _tempDisObj01.parent.globalToLocal(_tempP);
               _tempOffsetPoint = _offsetList[_tempDisObj01];
               if(_tempOffsetPoint)
               {
                  _tempDisObj01.x = _tempP.x + _tempOffsetPoint.x;
                  _tempDisObj01.y = _tempP.y + _tempOffsetPoint.y;
               }
               else
               {
                  _tempDisObj01.x = _tempP.x;
                  _tempDisObj01.y = _tempP.y;
               }
            }
            else
            {
               _autoRemoveList[_tempDisObj01] = null;
               delete _autoRemoveList[_tempDisObj01];
               _offsetList[_tempDisObj01] = null;
               delete _offsetList[_tempDisObj01];
            }
         }
         for(_tempDisObj01 in _manualRemoveList)
         {
            _loc2_++;
            _tempDisObj02 = _manualRemoveList[_tempDisObj01];
            if(_tempDisObj01 && _tempDisObj01.stage && _tempDisObj02 && _tempDisObj02.stage)
            {
               _tempP.x = _tempDisObj02.x;
               _tempP.y = _tempDisObj02.y;
               _tempP = _tempDisObj02.parent.localToGlobal(_tempP);
               _tempP = _tempDisObj01.parent.globalToLocal(_tempP);
               _tempOffsetPoint = _offsetList[_tempDisObj01];
               if(_tempOffsetPoint)
               {
                  _tempDisObj01.x = _tempP.x + _tempOffsetPoint.x;
                  _tempDisObj01.y = _tempP.y + _tempOffsetPoint.y;
               }
               else
               {
                  _tempDisObj01.x = _tempP.x;
                  _tempDisObj01.y = _tempP.y;
               }
            }
         }
         if(_loc2_ == 0)
         {
            clear();
         }
      }
      
      private static function getListLen(param1:Dictionary) : int
      {
         var _loc3_:int = 0;
         for(var _loc2_:Object in param1)
         {
            _loc3_++;
         }
         return _loc3_;
      }
   }
}

