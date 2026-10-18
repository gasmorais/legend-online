package com.speedEngine.components.ui2D.controls
{
   public interface IViewPort
   {
      
      function getMaxHeight() : Number;
      
      function getMaxWidth() : Number;
      
      function getScrollH() : Number;
      
      function getScrollV() : Number;
      
      function setScrollH(param1:Number) : void;
      
      function setScrollV(param1:Number) : void;
   }
}

