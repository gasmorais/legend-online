package com.pickgliss.ui.image
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class MutipleImage extends Image
   {
      
      public static const P_imageRect:String = "imagesRect";
      
      private var _imageLinks:Array;
      
      private var _imageRectString:String;
      
      private var _images:Vector.<DisplayObject>;
      
      private var _imagesRect:Vector.<InnerRectangle>;
      
      public function MutipleImage()
      {
         super();
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_images)
         {
            _loc1_ = 0;
            while(_loc1_ < _images.length)
            {
               ObjectUtils.disposeObject(_images[_loc1_]);
               _loc1_++;
            }
         }
         _images = null;
         _imagesRect = null;
         _imageLinks = null;
         super.dispose();
      }
      
      public function set imageRectString(param1:String) : void
      {
         var _loc3_:int = 0;
         if(_imageRectString == param1)
         {
            return;
         }
         _imagesRect = new Vector.<InnerRectangle>();
         _imageRectString = param1;
         var _loc2_:Array = ComponentFactory.parasArgs(_imageRectString);
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(String(_loc2_[_loc3_]) == "")
            {
               _imagesRect.push(null);
            }
            else
            {
               _imagesRect.push(ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",String(_loc2_[_loc3_]).split("|")));
            }
            _loc3_++;
         }
         onPropertiesChanged("imagesRect");
      }
      
      public function get imageRectString() : String
      {
         return _imageRectString;
      }
      
      override protected function addChildren() : void
      {
         var _loc1_:int = 0;
         super.addChildren();
         if(_images == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _images.length)
         {
            Sprite(_display).addChild(_images[_loc1_]);
            _loc1_++;
         }
      }
      
      override protected function init() : void
      {
         _display = new Sprite();
         super.init();
      }
      
      override protected function resetDisplay() : void
      {
         _imageLinks = ComponentFactory.parasArgs(_resourceLink);
         removeImages();
         creatImages();
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Rectangle = null;
         if(_images == null)
         {
            return;
         }
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["imagesRect"])
         {
            _loc1_ = 0;
            while(_loc1_ < _images.length)
            {
               if(_imagesRect && _imagesRect[_loc1_])
               {
                  _loc2_ = _imagesRect[_loc1_].getInnerRect(_width,_height);
                  _images[_loc1_].x = _loc2_.x;
                  _images[_loc1_].y = _loc2_.y;
                  if(_loc2_.height > 0)
                  {
                     _images[_loc1_].height = _loc2_.height;
                  }
                  if(_loc2_.width > 0)
                  {
                     _images[_loc1_].width = _loc2_.width;
                  }
               }
               else
               {
                  _images[_loc1_].width = _width;
                  _images[_loc1_].height = _height;
               }
               _loc1_++;
            }
         }
      }
      
      private function creatImages() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DisplayObject = null;
         var _loc2_:Array = null;
         _images = new Vector.<DisplayObject>();
         _loc3_ = 0;
         while(_loc3_ < _imageLinks.length)
         {
            _loc2_ = String(_imageLinks[_loc3_]).split("|");
            _loc1_ = ComponentFactory.Instance.creat(_loc2_[0]);
            _images.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function removeImages() : void
      {
         var _loc1_:int = 0;
         if(_images == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _images.length)
         {
            ObjectUtils.disposeObject(_images[_loc1_]);
            _loc1_++;
         }
      }
      
      public function setChildVisible(param1:int, param2:Boolean) : void
      {
         if(_images && _images[param1])
         {
            _images[param1].visible = param2;
         }
      }
      
      public function setChildSize(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:DisplayObject = null;
         if(_images)
         {
            _loc4_ = _images[param1];
            if(_loc4_)
            {
               _loc4_.width = param2;
               _loc4_.height = param3;
            }
         }
      }
      
      public function setChildPos(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:DisplayObject = null;
         if(_images)
         {
            _loc4_ = _images[param1];
            if(_loc4_)
            {
               _loc4_.x = param2;
               _loc4_.y = param3;
            }
         }
      }
      
      public function showImg(param1:int) : void
      {
         if(param1 == -1)
         {
            return;
         }
         for each(var _loc2_:DisplayObject in _images)
         {
            _loc2_.visible = false;
         }
         if(_images && _images[param1])
         {
            _images[param1].visible = true;
         }
      }
   }
}

