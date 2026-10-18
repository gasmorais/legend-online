package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class ScaleFrameImage extends Image
   {
      
      public static const P_fillAlphaRect:String = "fillAlphaRect";
      
      public static const P_AutoHCenter:String = "autoHCenter";
      
      public static const P_AutoVCenter:String = "autoVCenter";
      
      private var _autoHCenter:Boolean = false;
      
      private var _autoVCenter:Boolean = false;
      
      private var _flag:Boolean;
      
      private var _currentFrame:uint;
      
      private var _fillAlphaRect:Boolean;
      
      private var _imageLinks:Array;
      
      private var _images:Vector.<DisplayObject>;
      
      public function ScaleFrameImage(param1:Boolean = false)
      {
         super();
         _flag = param1;
      }
      
      override public function dispose() : void
      {
         removeImages();
         _images = null;
         _imageLinks = null;
         super.dispose();
      }
      
      public function set fillAlphaRect(param1:Boolean) : void
      {
         if(_fillAlphaRect == param1)
         {
            return;
         }
         _fillAlphaRect = param1;
         onPropertiesChanged("fillAlphaRect");
      }
      
      public function set autoVCenter(param1:Boolean) : void
      {
         if(_autoVCenter == param1)
         {
            return;
         }
         _autoVCenter = param1;
         onPropertiesChanged("autoVCenter");
      }
      
      public function get autoVCenter() : Boolean
      {
         return _autoVCenter;
      }
      
      public function set autoHCenter(param1:Boolean) : void
      {
         if(_autoHCenter == param1)
         {
            return;
         }
         _autoHCenter = param1;
         onPropertiesChanged("autoHCenter");
      }
      
      public function get autoHCenter() : Boolean
      {
         return _autoHCenter;
      }
      
      public function get getFrame() : uint
      {
         return _currentFrame;
      }
      
      override public function setFrame(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         if(!_images)
         {
            return;
         }
         super.setFrame(param1);
         _currentFrame = param1;
         _loc3_ = 0;
         while(_loc3_ < _images.length)
         {
            _loc2_ = _images[_loc3_];
            if(_loc2_ != null)
            {
               if(_autoHCenter)
               {
                  _loc2_.x = -_loc2_.width * 0.5;
               }
               if(_autoVCenter)
               {
                  _loc2_.y = -_loc2_.height * 0.5;
               }
               if(param1 - 1 == _loc3_)
               {
                  _loc2_.visible = true;
                  if(_loc2_ is MovieClip)
                  {
                     (_loc2_ as MovieClip).play();
                  }
                  else if(_loc2_ is MovieImage)
                  {
                     (_loc2_ as MovieImage).movie.play();
                  }
               }
               else
               {
                  _loc2_.visible = false;
                  if(_loc2_ is MovieClip)
                  {
                     (_loc2_ as MovieClip).gotoAndStop(1);
                  }
                  else if(_loc2_ is MovieImage)
                  {
                     (_loc2_ as MovieImage).movie.gotoAndStop(1);
                  }
               }
            }
            _loc3_++;
         }
         fillRect();
      }
      
      private function fillRect() : void
      {
         if(_fillAlphaRect)
         {
            graphics.beginFill(16711935,0);
            graphics.drawRect(0,0,_width,_height);
            graphics.endFill();
         }
      }
      
      override protected function init() : void
      {
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
         if(_images == null)
         {
            return;
         }
         if(_flag)
         {
            return;
         }
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            _loc1_ = 0;
            while(_loc1_ < _images.length)
            {
               if(_images[_loc1_] != null)
               {
                  _images[_loc1_].width = _width;
                  _images[_loc1_].height = _height;
               }
               _loc1_++;
            }
         }
         imgAutoHorizontal();
         imgAutoVertical();
      }
      
      private function imgAutoHorizontal() : void
      {
         var _loc1_:DisplayObject = null;
         if(!_images || !_autoHCenter)
         {
            return;
         }
         if(_currentFrame - 1 >= 0 && _currentFrame - 1 < _images.length)
         {
            _loc1_ = _images[_currentFrame - 1];
            if(_loc1_ != null)
            {
               _loc1_.x = -_loc1_.width * 0.5;
            }
         }
      }
      
      private function imgAutoVertical() : void
      {
         var _loc1_:DisplayObject = null;
         if(!_images || !_autoVCenter)
         {
            return;
         }
         if(_currentFrame - 1 >= 0 && _currentFrame - 1 < _images.length)
         {
            _loc1_ = _images[_currentFrame - 1];
            if(_loc1_ != null)
            {
               _loc1_.y = -_loc1_.height * 0.5;
            }
         }
      }
      
      private function creatImages() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         _images = new Vector.<DisplayObject>();
         _loc2_ = 0;
         while(_loc2_ < _imageLinks.length)
         {
            if(StringUtils.isEmpty(_imageLinks[_loc2_]))
            {
               _images.push(null);
            }
            else
            {
               _loc1_ = ComponentFactory.Instance.creat(_imageLinks[_loc2_]);
               _width = Math.max(_width,_loc1_.width);
               _height = Math.max(_height,_loc1_.height);
               _images.push(_loc1_);
               addChild(_loc1_);
            }
            _loc2_++;
         }
      }
      
      public function getFrameImage(param1:int) : DisplayObject
      {
         return _images[param1];
      }
      
      private function removeImages() : void
      {
         if(_images == null)
         {
            return;
         }
         for each(var _loc1_:DisplayObject in _images)
         {
            _loc1_ = _images.pop();
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
      }
      
      public function get totalFrames() : int
      {
         return _images.length;
      }
   }
}

