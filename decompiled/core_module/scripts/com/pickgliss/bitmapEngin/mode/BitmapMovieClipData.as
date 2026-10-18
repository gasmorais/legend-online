package com.pickgliss.bitmapEngin.mode
{
   import com.pickgliss.bitmapEngin.cache.CacheFrame;
   
   public class BitmapMovieClipData
   {
      
      public var frames:Vector.<CacheFrame>;
      
      public var labels:Array;
      
      public var id:String;
      
      private var _inited:Boolean;
      
      public function BitmapMovieClipData()
      {
         super();
      }
      
      public function get inited() : Boolean
      {
         return _inited;
      }
      
      public function set inited(param1:Boolean) : void
      {
         _inited = param1;
      }
      
      public function dispose() : void
      {
         for each(var _loc1_:CacheFrame in frames)
         {
            _loc1_.bitmapData.dispose();
            _loc1_.bitmapData = null;
         }
         frames = null;
      }
   }
}

