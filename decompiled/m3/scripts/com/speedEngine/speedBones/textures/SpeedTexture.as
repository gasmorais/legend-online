package com.speedEngine.speedBones.textures
{
   import com.speedEngine.speedBones.BaseClass;
   import com.speedEngine.speedBones.utils.NumberUtils;
   import flash.display.BitmapData;
   import flash.display3D.Context3D;
   import flash.display3D.textures.Texture;
   import flash.geom.Point;
   
   public class SpeedTexture extends BaseClass
   {
      
      private var _data:Object = null;
      
      private var _texture:Texture = null;
      
      private var _context3d:Context3D = null;
      
      private var _optimizedForRenderTexture:Boolean = false;
      
      private var _textureWidth:int;
      
      private var _textureHeight:int;
      
      private var _width:int;
      
      private var _height:int;
      
      private var _formatIndex:uint = 0;
      
      public function SpeedTexture(param1:Context3D, param2:Object)
      {
         super();
         _context3d = param1;
         _data = param2;
         switch(_data.format)
         {
            case "compressedAlpha":
               _formatIndex = 0;
               break;
            case "compressed":
               _formatIndex = 1;
               break;
            case "bgra":
               _formatIndex = 2;
               break;
            default:
               throw new Error("资源格式错误，必须为BGRA,COMPRESSED,COMPRESSED_ALPHA");
         }
         onContextCreated(null);
      }
      
      public function changeData(param1:Object) : void
      {
         if(_data)
         {
            _data.dispose();
         }
         _data = param1;
         onContextCreated(null);
      }
      
      public function updateTexture() : void
      {
         if(_texture)
         {
            _texture.dispose();
         }
         onContextCreated(null);
      }
      
      public function get formatIndex() : int
      {
         return _formatIndex;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function get width() : int
      {
         return _width;
      }
      
      public function get textureHeight() : int
      {
         return _textureHeight;
      }
      
      public function get textureWidth() : int
      {
         return _textureWidth;
      }
      
      private function onContextCreated(param1:Object = null) : void
      {
         if(_data is AtfData)
         {
            createCompress();
         }
         else if(_data is TextureData)
         {
            createTexture();
         }
      }
      
      public function uploadTextureAgain(param1:Context3D) : void
      {
         _context3d = param1;
         if(_texture)
         {
            _texture.dispose();
         }
         onContextCreated(null);
      }
      
      private function createCompress() : void
      {
         _width = _textureHeight = _data.width;
         if(_data.hasOwnProperty("textureWidth"))
         {
            _textureWidth = _data.textureWidth;
         }
         _height = _textureHeight = _data.height;
         if(_data.hasOwnProperty("textureHeight"))
         {
            _textureHeight = _data.textureHeight;
         }
         if(_context3d.driverInfo == "Disposed")
         {
            return;
         }
         _texture = _context3d.createTexture(_data.textureWidth,_data.textureHeight,_data.format,_optimizedForRenderTexture);
         _texture.uploadCompressedTextureFromByteArray(_data.data,0);
      }
      
      private function createTexture() : void
      {
         var _loc1_:BitmapData = null;
         var _loc3_:Number = NumberUtils.getNextPowerOfTwo(_data.width);
         var _loc2_:Number = NumberUtils.getNextPowerOfTwo(_data.height);
         _textureWidth = _loc3_;
         _textureHeight = _loc2_;
         _width = _data.width;
         _height = _data.height;
         if(_context3d.driverInfo == "Disposed")
         {
            return;
         }
         if(_loc3_ != _data.width || _loc2_ != _data.height)
         {
            _loc1_ = new BitmapData(_data.width,_data.height,true,0);
            _loc1_.copyPixels(_data.data,_data.data.rect,new Point());
            _texture = _context3d.createTexture(_loc3_,_loc2_,_data.format,false);
            _texture.uploadFromBitmapData(_loc1_,0);
            _loc1_.dispose();
            _loc1_ = null;
         }
         else
         {
            _texture = _context3d.createTexture(_loc3_,_loc2_,_data.format,false);
            _texture.uploadFromBitmapData(_data.data,0);
         }
      }
      
      public function get texture() : Texture
      {
         return _texture;
      }
      
      public function dispose() : void
      {
         if(!_data)
         {
         }
         if(_context3d)
         {
            _context3d.removeEventListener("context3DCreate",onContextCreated);
         }
         if(_texture)
         {
            _texture.dispose();
         }
         _texture = null;
         _data = null;
         _context3d = null;
      }
      
      public function get optimizedForRenderTexture() : Boolean
      {
         return _optimizedForRenderTexture;
      }
      
      public function set optimizedForRenderTexture(param1:Boolean) : void
      {
         _optimizedForRenderTexture = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
   }
}

