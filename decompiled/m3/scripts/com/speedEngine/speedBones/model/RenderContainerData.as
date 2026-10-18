package com.speedEngine.speedBones.model
{
   public class RenderContainerData
   {
      
      private static var _stageWidth:Number = 1024;
      
      private static var _stageHeight:Number = 1024;
      
      private var _renderScaleX:Number;
      
      private var _renderScaleY:Number;
      
      private var _halfWidth:Number;
      
      private var _halfHeight:Number;
      
      public function RenderContainerData()
      {
         super();
         _renderScaleX = 2 / _stageWidth;
         _renderScaleY = 2 / _stageHeight;
         _halfWidth = _stageWidth / 2;
         _halfHeight = _stageHeight / 2;
      }
      
      public static function get stageWidth() : Number
      {
         return _stageWidth;
      }
      
      public static function get stageHeight() : Number
      {
         return _stageHeight;
      }
      
      public function get renderWidthHalf() : Number
      {
         return _halfWidth;
      }
      
      public function get renderHeightHalf() : Number
      {
         return _halfHeight;
      }
      
      public function getTransformX(param1:Number) : Number
      {
         return (int(param1) - _halfWidth) * _renderScaleX;
      }
      
      public function getTransformY(param1:Number) : Number
      {
         return (_halfHeight - int(param1)) * _renderScaleY;
      }
      
      public function get renderScaleX() : Number
      {
         return _renderScaleX;
      }
      
      public function get renderScaleY() : Number
      {
         return _renderScaleY;
      }
   }
}

