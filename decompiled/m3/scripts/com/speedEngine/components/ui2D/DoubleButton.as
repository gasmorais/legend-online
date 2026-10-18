package com.speedEngine.components.ui2D
{
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   
   public class DoubleButton extends LabelButton
   {
      
      protected var _isSelected:Boolean = false;
      
      private var _selectOverTexture:BitmapData;
      
      private var _selectTexture:BitmapData;
      
      private var _srcSelectBitmap:BitmapData;
      
      private var _srcSelectOverBitmap:BitmapData;
      
      protected var _baseOvertexture:BitmapData;
      
      public function DoubleButton(param1:BitmapData = null)
      {
         super(param1);
         downEffect = "";
         overEffect = "";
      }
      
      override public function render() : void
      {
         if(validateDic[IMAGESIZE])
         {
            if(_tWidth > 0 || _tHeight > 0)
            {
               if(scaleGridLeft != 0 || scaleGridRight != 0 || scaleGridBottom != 0 && scaleGridTop != 0)
               {
                  _selectTexture = getBitmapData(_srcSelectBitmap);
                  _srcSelectOverBitmap = getBitmapData(_srcSelectOverBitmap);
                  pushDisposeBitmap(_selectTexture);
                  pushDisposeBitmap(_srcSelectOverBitmap);
               }
               else
               {
                  _bitmap.width = width;
                  _bitmap.height = height;
               }
            }
         }
         super.render();
         if(validateDic[STYLE])
         {
            setStateTexture();
         }
      }
      
      protected function setStateTexture() : void
      {
         if(_isSelected == false)
         {
            changTexture(texture);
            super.overTexture = _baseOvertexture;
         }
         else if(_isSelected == true)
         {
            changTexture(selectTexture);
            super.overTexture = selectOverTexture;
         }
      }
      
      override protected function click(param1:MouseEvent) : void
      {
         isSelected = !isSelected;
         if(onClickCallBack != null)
         {
            onClickCallBack.call(null,param1);
         }
      }
      
      override protected function doubleClick(param1:MouseEvent) : void
      {
      }
      
      override protected function down(param1:MouseEvent) : void
      {
      }
      
      override protected function out(param1:MouseEvent) : void
      {
         isSelected = _isSelected;
      }
      
      override protected function over(param1:MouseEvent) : void
      {
         if(_isSelected)
         {
            changTexture(selectOverTexture);
         }
         else
         {
            changTexture(overTexture);
         }
      }
      
      override protected function up(param1:MouseEvent) : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function __onAfterProp() : void
      {
         super.__onAfterProp();
      }
      
      public function get isSelected() : Boolean
      {
         return _isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         _isSelected = param1;
         validate(STYLE);
      }
      
      override public function set downTexture(param1:BitmapData) : void
      {
         super.downTexture = null;
      }
      
      override public function set overTexture(param1:BitmapData) : void
      {
         _baseOvertexture = param1;
         super.overTexture = param1;
      }
      
      public function get selectTexture() : BitmapData
      {
         return _selectTexture;
      }
      
      public function set selectTexture(param1:BitmapData) : void
      {
         _selectTexture = param1;
         _srcSelectBitmap = param1;
         pushDisposeBitmap(param1);
         validate(IMAGESIZE);
      }
      
      public function get selectOverTexture() : BitmapData
      {
         return _selectOverTexture;
      }
      
      public function set selectOverTexture(param1:BitmapData) : void
      {
         _selectOverTexture = param1;
         _srcSelectOverBitmap = param1;
         pushDisposeBitmap(param1);
         validate(IMAGESIZE);
      }
   }
}

