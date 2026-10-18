package com.speedEngine.components.bone
{
   import com.speedEngine.speedBones.display.Image;
   import com.speedEngine.speedBones.textures.AtfData;
   import flash.display.BitmapData;
   
   public class BoneImage extends Image
   {
      
      private var _texture:AtfData;
      
      private var _bitmapData:BitmapData;
      
      public function BoneImage()
      {
         super();
      }
      
      public function get bitmapData() : BitmapData
      {
         return _bitmapData;
      }
      
      public function get texture() : AtfData
      {
         return _texture;
      }
      
      public function set texture(param1:AtfData) : void
      {
         if(_texture != param1)
         {
            _texture = param1;
            imageData = BoneMovieFactory.instance.getImageData(param1);
         }
      }
      
      public function set bitmapData(param1:BitmapData) : void
      {
         if(_bitmapData != param1)
         {
            _bitmapData = param1;
            imageData = BoneMovieFactory.instance.getImageDataByBitmapData(param1);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _texture = null;
         _bitmapData = null;
      }
   }
}

