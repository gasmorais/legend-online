package com.speedEngine.speedBones.display
{
   import com.speedEngine.speedBones.events.Event;
   import com.speedEngine.speedBones.events.TouchEvent;
   import com.speedEngine.speedBones.model.DisplayData;
   import com.speedEngine.speedBones.utils.speedBones_internal;
   import flash.display.Stage;
   import flash.display3D.Context3D;
   
   use namespace speedBones_internal;
   
   public class Stage extends DisplayObjectContainer
   {
      
      private static var _current:com.speedEngine.speedBones.display.Stage;
      
      private static var _context3D:Context3D;
      
      private var _stageWidth:int;
      
      private var _stageHeight:int;
      
      private var _nativeStage:flash.display.Stage;
      
      private var _eventState:Object;
      
      public function Stage(param1:HelpClass, param2:flash.display.Stage)
      {
         super();
         if(param1 == null)
         {
            throw "can not new";
         }
         if(_current != null)
         {
            throw "single";
         }
         speedBones_internal::stage = this;
         _nativeStage = param2;
         _eventState = {};
      }
      
      public static function get current() : com.speedEngine.speedBones.display.Stage
      {
         if(_current == null)
         {
            throw "has not step";
         }
         return _current;
      }
      
      public static function get context3D() : Context3D
      {
         if(_context3D == null)
         {
            throw "Context3D not init!!";
         }
         return _context3D;
      }
      
      public static function step(param1:flash.display.Stage) : void
      {
         _current = new com.speedEngine.speedBones.display.Stage(new HelpClass(),param1);
      }
      
      public static function stepContext(param1:Context3D) : void
      {
         _context3D = param1;
      }
      
      public function clearEventState() : void
      {
         for(var _loc1_:String in _eventState)
         {
            delete _eventState[_loc1_];
         }
      }
      
      override public function dispathEventWidth(param1:Event, param2:Boolean = false) : void
      {
         if(param1 is TouchEvent)
         {
            if(_eventState[param1.type] && _eventState[param1.type] == true)
            {
               return;
            }
            _eventState[param1.type] = true;
            super.dispathEventWidth(param1,param2);
         }
         else
         {
            super.dispathEventWidth(param1,param2);
         }
      }
      
      public function get nativeStage() : flash.display.Stage
      {
         return _nativeStage;
      }
      
      public function get stageHeight() : int
      {
         return _stageHeight;
      }
      
      public function get stageWidth() : int
      {
         return _stageWidth;
      }
      
      public function reSize(param1:Number, param2:Number) : void
      {
         _stageWidth = param1;
         _stageHeight = param2;
         DisplayData.HALF_WIDTH = param1 * 0.5;
         DisplayData.HALF_HEIGHT = param2 * 0.5;
         DisplayData.SCENCE_SCALEX = 2 / param1;
         DisplayData.SCENCE_SCALEY = 2 / param2;
         var _loc3_:Event = Event.getEvent(Event,"resize");
         dispathEventWidth(_loc3_);
      }
   }
}

class HelpClass
{
   
   public function HelpClass()
   {
      super();
   }
}
