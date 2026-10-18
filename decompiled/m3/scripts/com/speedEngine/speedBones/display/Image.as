package com.speedEngine.speedBones.display
{
   import com.speedEngine.speedBones.events.Event;
   import com.speedEngine.speedBones.model.ImageData;
   import flash.geom.Rectangle;
   
   public class Image extends DisplayObject
   {
      
      public static var SIZE:String = "size";
      
      private var _imageData:ImageData;
      
      private var _scale9Grid:Rectangle;
      
      public function Image()
      {
         super();
      }
      
      override public function set width(param1:Number) : void
      {
         if(_scale9Grid)
         {
            imageData.setNewWidthAndNewHeight(param1,height);
         }
         else
         {
            super.width = param1;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(_scale9Grid)
         {
            imageData.setNewWidthAndNewHeight(width,param1);
         }
         else
         {
            super.height = param1;
         }
      }
      
      public function set imageData(param1:ImageData) : void
      {
         if(_imageData == param1)
         {
            return;
         }
         _imageData = param1;
         if(_imageData == null)
         {
            trace("ImageData创建失败，请{invalid_utf8=230}{invalid_utf8=163}?查资源！{invalid_utf8=239}{invalid_utf8=188}?");
            throw "error";
         }
         changSize();
         _displayData = _imageData;
         _imageData.addEventListener("change",onChange);
      }
      
      private function onChange(param1:Event) : void
      {
         setUnScaleWidth(imageData.width);
         setUnScaleHeight(imageData.height);
         setSrcRect(imageData.boundRect);
         setSrcTriangles(imageData.triangles);
      }
      
      public function setTexCoordsTo(param1:int, param2:Number, param3:Number) : void
      {
         if(_imageData)
         {
            _imageData.setTexCoordsTo(param1,param2,param3);
         }
      }
      
      public function get imageData() : ImageData
      {
         return _imageData;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         pushRenderFunction(SIZE,changSize);
      }
      
      private function changSize() : void
      {
         if(imageData)
         {
            imageData.setVertexData();
            setUnScaleWidth(imageData.width);
            setUnScaleHeight(imageData.height);
            setSrcRect(imageData.boundRect);
            setSrcTriangles(imageData.triangles);
         }
      }
      
      override protected function update() : void
      {
         super.update();
         if(_hasChangeFilter)
         {
            updateColorFilter();
            updateFilter();
         }
      }
      
      override public function render(param1:Number) : void
      {
         if(imageData)
         {
            imageData.writeController(_attributeBytes,_colorFilterBytes,_blurFilterBytes,_renderMode);
         }
      }
      
      override public function dispose() : void
      {
         if(_imageData)
         {
            _imageData.removeEventListener("change",onChange);
         }
         _imageData = null;
         _scale9Grid = null;
         super.dispose();
      }
      
      public function get scale9Grid() : Rectangle
      {
         return _scale9Grid;
      }
      
      public function set scale9Grid(param1:Rectangle) : void
      {
         _scale9Grid = param1;
         if(imageData)
         {
            imageData.setScale9Grid(_scale9Grid);
         }
      }
   }
}

