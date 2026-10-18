package com.speedEngine.components.manager
{
   import com.speedEngine.components.ui2D.TinyUI;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class RepaintManger
   {
      
      private static var _instance:RepaintManger;
      
      private var _renderQueue:Vector.<TinyUI> = new Vector.<TinyUI>(0);
      
      private var _renderring:Boolean;
      
      private var _timer:Timer = new Timer(19,1);
      
      private var _alwaysUseTimer:Boolean = false;
      
      private var _stage:Stage;
      
      private var _index:int;
      
      public function RepaintManger(param1:SingletonHelper)
      {
         super();
         if(_instance)
         {
            throw "this is a singleton";
         }
      }
      
      public static function get instance() : RepaintManger
      {
         if(!_instance)
         {
            _instance = new RepaintManger(new SingletonHelper());
         }
         return _instance;
      }
      
      public function addRenderComponent(param1:TinyUI) : void
      {
         if(param1 != null && _renderQueue.indexOf(param1) < _index)
         {
            _renderQueue.push(param1);
            if(_alwaysUseTimer && !_timer.running)
            {
               _timer.reset();
               _timer.start();
            }
            else if(_stage)
            {
               _stage.invalidate();
            }
         }
      }
      
      public function removeRenderComponent(param1:TinyUI) : void
      {
         var _loc2_:int = _renderQueue.indexOf(param1);
         if(param1 != null && _loc2_ >= _index)
         {
            _renderQueue.splice(_loc2_,1);
         }
      }
      
      public function setp(param1:Stage) : void
      {
         if(param1)
         {
            _stage = param1;
            param1.addEventListener("render",__onRender);
            param1.invalidate();
         }
         _timer.addEventListener("timer",__timerComplete);
      }
      
      public function setAlwaysUseTimer(param1:Boolean, param2:int = 19) : void
      {
         _alwaysUseTimer = param1;
         _timer.delay = param2;
      }
      
      protected function __timerComplete(param1:TimerEvent) : void
      {
         __onRender();
         param1.updateAfterEvent();
      }
      
      protected function __onRender(param1:Event = null) : void
      {
         var _loc3_:TinyUI = null;
         _renderring = true;
         _renderQueue.sort(contain);
         var _loc2_:int = int(_renderQueue.length);
         _index = 0;
         while(_index < _renderQueue.length)
         {
            _loc3_ = _renderQueue[_index];
            _loc3_.repaint();
            _index = _index + 1;
         }
         _renderQueue.length = 0;
         _renderring = false;
      }
      
      protected function contain(param1:DisplayObject, param2:DisplayObject) : int
      {
         var _loc3_:DisplayObject = param1;
         while(param1)
         {
            if(param1.parent == param2)
            {
               return -1;
            }
            param1 = param1.parent;
         }
         return 1;
      }
      
      public function get renderring() : Boolean
      {
         return _renderring;
      }
   }
}

class SingletonHelper
{
   
   public function SingletonHelper()
   {
      super();
   }
}
