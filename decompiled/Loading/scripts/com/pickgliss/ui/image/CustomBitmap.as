package com.pickgliss.ui.image
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   
   public class CustomBitmap extends Bitmap implements Disposeable
   {
      
      private var _stylename:String;
      
      private var _resourceLink:String;
      
      public function CustomBitmap(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function get stylename() : String
      {
         return _stylename;
      }
      
      public function set stylename(param1:String) : void
      {
         _stylename = param1;
      }
      
      public function get resourceLink() : String
      {
         return _resourceLink;
      }
      
      public function set resourceLink(param1:String) : void
      {
         if(_resourceLink == param1)
         {
            return;
         }
         _resourceLink = param1;
         if(bitmapData)
         {
            bitmapData.dispose();
            bitmapData = null;
         }
         if(_resourceLink)
         {
            bitmapData = ClassUtils.CreatInstance(_resourceLink);
         }
      }
      
      public function dispose() : void
      {
         if(bitmapData)
         {
            bitmapData.dispose();
            bitmapData = null;
         }
         _resourceLink = null;
      }
   }
}

