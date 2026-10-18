package com.pickgliss.ui.core
{
   import flash.display.IDisplayObject;
   import flash.geom.Point;
   
   public interface ITipedDisplay extends IDisplayObject
   {
      
      function get tipStyle() : String;
      
      function get tipData() : Object;
      
      function get tipDirctions() : String;
      
      function get tipGapV() : int;
      
      function get tipGapH() : int;
      
      function set tipStyle(param1:String) : void;
      
      function set tipData(param1:Object) : void;
      
      function set tipDirctions(param1:String) : void;
      
      function set tipGapV(param1:int) : void;
      
      function set tipGapH(param1:int) : void;
      
      function set isFollowMouse(param1:Boolean) : void;
      
      function get isFollowMouse() : Boolean;
      
      function get startPoint() : Point;
      
      function set startPoint(param1:Point) : void;
   }
}

