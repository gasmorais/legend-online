package com.pickgliss.ui.tip
{
   import flash.display.IDisplayObject;
   
   public interface ITip extends IDisplayObject
   {
      
      function get tipData() : Object;
      
      function set tipData(param1:Object) : void;
      
      function set isFollowMouse(param1:Boolean) : void;
      
      function get isFollowMouse() : Boolean;
      
      function set isSingleToneTip(param1:Boolean) : void;
      
      function get isSingleToneTip() : Boolean;
      
      function set direction(param1:int) : void;
   }
}

