package skytreasure
{
   import events.SkyTreasureEvent;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import skytreasure.view.SkyTreasureBox;
   import yishi.manager.SkyTreasureManager;
   
   public class SkyTreasureBoxManager extends EventDispatcher
   {
      
      private static var _instance:SkyTreasureBoxManager;
      
      private var _sequence:int;
      
      private const BOX_MAX:int = 15;
      
      private var _boxList:Array = [];
      
      private var _createBoxTimer:Timer;
      
      public function SkyTreasureBoxManager()
      {
         super();
      }
      
      public static function get Instance() : SkyTreasureBoxManager
      {
         if(!_instance)
         {
            _instance = new SkyTreasureBoxManager();
         }
         return _instance;
      }
      
      public function get boxList() : Array
      {
         return _boxList;
      }
      
      public function initTimer() : void
      {
         if(!_createBoxTimer)
         {
            _createBoxTimer = new Timer(600,0);
            _createBoxTimer.addEventListener("timer",createBoxTimer);
            _createBoxTimer.start();
         }
      }
      
      public function isInitState() : Boolean
      {
         if(_boxList && _boxList.length > 0)
         {
            return true;
         }
         return false;
      }
      
      private function createBoxTimer(param1:TimerEvent) : void
      {
         var _loc2_:SkyTreasureBox = null;
         if(!SkyTreasureManager.Instance.isStart())
         {
            return;
         }
         if(_boxList && _boxList.length >= 15)
         {
            _loc2_ = getMoveOutDisplayViewBox();
            if(_loc2_)
            {
               _loc2_.restart();
               return;
            }
            return;
         }
         createBox();
      }
      
      private function createBox() : void
      {
         _sequence = _sequence + 1;
         var _loc1_:SkyTreasureBox = new SkyTreasureBox(_sequence);
         _boxList.push(_loc1_);
         this.dispatchEvent(new SkyTreasureEvent("SKYTREASURE_CREATE_BOX",_loc1_));
      }
      
      private function getMoveOutDisplayViewBox() : SkyTreasureBox
      {
         for each(var _loc1_:SkyTreasureBox in _boxList)
         {
            if(_loc1_.isMoveOutDisplayView())
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function pauseAllBox() : void
      {
         for each(var _loc1_:SkyTreasureBox in _boxList)
         {
            _loc1_.pause();
         }
      }
      
      public function speedAllBox() : void
      {
         for each(var _loc1_:SkyTreasureBox in _boxList)
         {
            if(_loc1_.isMoveing())
            {
               _loc1_.speed();
            }
         }
      }
      
      public function resumeMoveAllBox() : void
      {
         for each(var _loc1_:SkyTreasureBox in _boxList)
         {
            _loc1_.resume();
         }
      }
      
      public function dispose() : void
      {
         _sequence = 0;
         _boxList = [];
         if(_createBoxTimer)
         {
            _createBoxTimer.stop();
            _createBoxTimer = null;
         }
      }
      
      public function testBoxStateTrace() : void
      {
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:Array = SkyTreasureBoxManager.Instance.boxList;
         for each(var _loc3_:SkyTreasureBox in _loc2_)
         {
            if(_loc3_.state == "STATE_STOP")
            {
               _loc6_++;
            }
            if(_loc3_.state == "STATE_MOVE_OUT_DISPLAY_VIEW")
            {
               _loc1_++;
            }
            if(_loc3_.state == "STATE_MOVEING")
            {
               _loc4_++;
            }
            if(_loc3_.state == "STATE_HITING")
            {
               _loc5_++;
            }
         }
      }
   }
}

