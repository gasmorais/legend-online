package com.speedEngine.speedBones.textures
{
   import com.speedEngine.speedBones.BaseClass;
   import flash.display.BitmapData;
   
   public class TextureData extends BaseClass
   {
      
      private var _width:int;
      
      private var _height:int;
      
      private var _data:BitmapData;
      
      private var _format:String = "bgra";
      
      public function TextureData()
      {
         super();
      }
      
      public function get format() : String
      {
         return _format;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function set width(param1:int) : void
      {
         _width = param1;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function set height(param1:int) : void
      {
         _height = param1;
      }
      
      public function get data() : BitmapData
      {
         return _data;
      }
      
      public function set data(param1:BitmapData) : void
      {
         _data = param1;
         _width = param1.width;
         _height = param1.height;
      }
      
      public function dispose() : void
      {
         if(_data)
         {
            _data.dispose();
         }
         _data = null;
      }
   }
}

