package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Matrix;
   
   public class ScaleUpDownImage extends Image
   {
      
      private var _bitmaps:Vector.<Bitmap>;
      
      private var _imageLinks:Array;
      
      public function ScaleUpDownImage()
      {
         super();
      }
      
      override public function dispose() : void
      {
         removeImages();
         graphics.clear();
         _bitmaps = null;
         super.dispose();
      }
      
      override protected function addChildren() : void
      {
         if(_bitmaps == null)
         {
            return;
         }
         addChild(_bitmaps[0]);
         addChild(_bitmaps[2]);
      }
      
      override protected function resetDisplay() : void
      {
         _imageLinks = ComponentFactory.parasArgs(_resourceLink);
         removeImages();
         creatImages();
      }
      
      override protected function updateSize() : void
      {
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            drawImage();
         }
      }
      
      private function creatImages() : void
      {
         var _loc1_:Bitmap = null;
         var _loc3_:int = 0;
         var _loc2_:Bitmap = null;
         if(_bitmaps)
         {
            while(_bitmaps.length > 0)
            {
               _loc1_ = _bitmaps.pop();
               if(_loc1_)
               {
                  _loc1_.bitmapData.dispose();
               }
               _loc1_ = null;
            }
         }
         _bitmaps = new Vector.<Bitmap>();
         _loc3_ = 0;
         while(_loc3_ < _imageLinks.length)
         {
            _loc2_ = ComponentFactory.Instance.creat(_imageLinks[_loc3_]);
            _bitmaps.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function drawImage() : void
      {
         var _loc1_:Matrix = new Matrix();
         _loc1_.scale(_width / _bitmaps[1].width,1);
         graphics.clear();
         graphics.beginBitmapFill(_bitmaps[1].bitmapData,_loc1_);
         graphics.drawRect(0,_bitmaps[0].height,_width,_height - _bitmaps[0].height - _bitmaps[2].height);
         graphics.endFill();
         _bitmaps[2].y = _height - _bitmaps[2].height;
         _bitmaps[0].width = _bitmaps[2].width = _width;
      }
      
      private function removeImages() : void
      {
         var _loc1_:int = 0;
         if(_bitmaps == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _bitmaps.length)
         {
            ObjectUtils.disposeObject(_bitmaps[_loc1_]);
            _loc1_++;
         }
      }
   }
}

