package com.pickgliss.ui.image
{
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import org.bytearray.display.ScaleBitmap;
   
   public class ScaleBitmapImage extends Image
   {
      
      public function ScaleBitmapImage()
      {
         super();
      }
      
      override protected function resetDisplay() : void
      {
         ObjectUtils.disposeObject(_display);
         var _loc1_:BitmapData = ClassUtils.CreatInstance(_resourceLink,[_width,_height]);
         _display = new ScaleBitmap(_loc1_);
      }
   }
}

