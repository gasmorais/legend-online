package com.road.mapengine.bitmap.load
{
   import flash.display.BitmapData;
   
   public class ResourceInfo
   {
      
      public var packageName:String;
      
      public var visible:Boolean = false;
      
      public var loadOver:Boolean;
      
      public var sizeType:int;
      
      private var _nextBitmapData:BitmapData;
      
      private var _currBitmapData:BitmapData;
      
      private var _cacheCurrBitmapData:Boolean;
      
      public function ResourceInfo()
      {
         super();
      }
      
      public function get cacheCurrBitmapData() : Boolean
      {
         return _cacheCurrBitmapData;
      }
      
      public function set cacheCurrBitmapData(param1:Boolean) : void
      {
         _cacheCurrBitmapData = param1;
         if(!param1)
         {
            currBitmapData = null;
         }
      }
      
      public function get currBitmapData() : BitmapData
      {
         return _currBitmapData;
      }
      
      public function set currBitmapData(param1:BitmapData) : void
      {
         _currBitmapData = param1;
      }
      
      public function get nextBitmapData() : BitmapData
      {
         return _nextBitmapData;
      }
      
      public function set nextBitmapData(param1:BitmapData) : void
      {
         if(_cacheCurrBitmapData)
         {
            currBitmapData = _nextBitmapData;
         }
         else
         {
            _nextBitmapData = null;
         }
         _nextBitmapData = param1;
      }
   }
}

