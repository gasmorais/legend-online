package com.pickgliss.utils
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.cell.IListCell;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public final class DoubleClickManager
   {
      
      private static var _instance:DoubleClickManager;
      
      private const DoubleClickSpeed:uint = 350;
      
      private var _timer:Timer;
      
      private var _currentTarget:InteractiveObject;
      
      private var _ctrlKey:Boolean;
      
      private var _isClicking:Boolean;
      
      public function DoubleClickManager()
      {
         super();
         init();
      }
      
      public static function get Instance() : DoubleClickManager
      {
         if(!_instance)
         {
            _instance = new DoubleClickManager();
         }
         return _instance;
      }
      
      public function get isClicking() : Boolean
      {
         return _isClicking;
      }
      
      public function set isClicking(param1:Boolean) : void
      {
         _isClicking = param1;
      }
      
      public function enableDoubleClick(param1:InteractiveObject) : void
      {
         if(param1)
         {
            param1.addEventListener("mouseDown",__mouseDownHandler);
         }
      }
      
      public function disableDoubleClick(param1:InteractiveObject) : void
      {
         if(param1)
         {
            param1.removeEventListener("mouseDown",__mouseDownHandler);
         }
      }
      
      private function init() : void
      {
         _timer = new Timer(350,1);
         _timer.addEventListener("timerComplete",__timerCompleteHandler);
      }
      
      private function getEvent(param1:String) : InteractiveEvent
      {
         var _loc2_:InteractiveEvent = new InteractiveEvent(param1);
         _loc2_.ctrlKey = _ctrlKey;
         return _loc2_;
      }
      
      private function __timerCompleteHandler(param1:TimerEvent) : void
      {
         StageReferance.stage.removeEventListener("click",__stageClickHandler,true);
         isClicking = false;
         _currentTarget.dispatchEvent(getEvent("interactive_click"));
         if(_currentTarget is IListCell || _currentTarget is ISelectable)
         {
            _currentTarget.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         _ctrlKey = param1.ctrlKey;
         if(_timer.running)
         {
            _timer.stop();
            isClicking = false;
            StageReferance.stage.removeEventListener("click",__stageClickHandler,true);
            if(_currentTarget != param1.currentTarget)
            {
               return;
            }
            param1.stopImmediatePropagation();
            _currentTarget.dispatchEvent(getEvent("interactive_double_click"));
         }
         else
         {
            StageReferance.stage.addEventListener("click",__stageClickHandler,true,99);
            _timer.reset();
            _timer.start();
            _currentTarget = param1.currentTarget as InteractiveObject;
            isClicking = true;
         }
      }
      
      private function __stageClickHandler(param1:MouseEvent) : void
      {
         if(param1.target != this)
         {
            param1.stopImmediatePropagation();
            param1.stopPropagation();
         }
      }
   }
}

