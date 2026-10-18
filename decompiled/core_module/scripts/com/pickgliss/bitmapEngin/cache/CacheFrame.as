package com.pickgliss.bitmapEngin.cache
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.BitmapData;
   
   public class CacheFrame implements Disposeable
   {
      
      public var bitmapData:BitmapData;
      
      public var height:int;
      
      public var registerX:int;
      
      public var registerY:int;
      
      public var width:int;
      
      public function CacheFrame(param1:BitmapData, param2:int, param3:int)
      {
         super();
         bitmapData = param1;
         width = param1.width;
         height = param1.height;
         registerX = param2;
         registerY = param3;
      }
      
      public function dispose() : void
      {
         bitmapData.dispose();
         bitmapData = null;
      }
   }
}

