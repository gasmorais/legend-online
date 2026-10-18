package com.speedEngine.speedBones.events
{
   import com.speedEngine.speedBones.utils.speedBones_internal;
   
   use namespace speedBones_internal;
   
   public class TouchEvent extends Event
   {
      
      public static const MOUSE_MOVE:String = "mouse_move";
      
      public static const MOUSE_OVER:String = "mouse_over";
      
      public static const MOUSE_OUT:String = "mouse_out";
      
      public static const MOUSE_CLICK:String = "click";
      
      public static const MOUSE_DOWN:String = "mouse_down";
      
      public static const MOUSE_UP:String = "mouse_up";
      
      private var _touchX:Number;
      
      private var _touchY:Number;
      
      private var _stageX:Number;
      
      private var _stageY:Number;
      
      private var _isCtrlKey:Boolean = false;
      
      private var _isShiftKey:Boolean = false;
      
      public function TouchEvent()
      {
         super();
      }
      
      public static function reset(param1:TouchEvent, param2:String, param3:Object, param4:Number, param5:Number, param6:Number, param7:Number, param8:Boolean = false, param9:Boolean = false) : void
      {
         Event.reset(param1,param2,param3);
         param1._touchX = param4;
         param1._touchY = param5;
         param1._stageX = param6;
         param1._stageY = param7;
         param1._isCtrlKey = param8;
         param1._isShiftKey = param9;
      }
      
      speedBones_internal function setTouchX(param1:Number) : void
      {
         _touchX = param1;
      }
      
      speedBones_internal function setTouchY(param1:Number) : void
      {
         _touchY = param1;
      }
      
      override public function initialize() : void
      {
         super.initialize();
         _touchX = -1;
         _touchY = -1;
      }
      
      public function get touchX() : Number
      {
         return Math.round(_touchX);
      }
      
      public function get touchY() : Number
      {
         return Math.round(_touchY);
      }
      
      public function get stageX() : Number
      {
         return _stageX;
      }
      
      public function get stageY() : Number
      {
         return _stageY;
      }
      
      public function get ctrlKey() : Boolean
      {
         return _isCtrlKey;
      }
      
      public function get shiftKey() : Boolean
      {
         return _isShiftKey;
      }
   }
}

