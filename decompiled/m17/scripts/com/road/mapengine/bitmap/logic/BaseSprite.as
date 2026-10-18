package com.road.mapengine.bitmap.logic
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class BaseSprite extends Sprite
   {
      
      private var _data:BitmapSimpleLogic;
      
      public function BaseSprite(param1:BitmapSimpleLogic)
      {
         super();
         _data = param1;
      }
      
      public function get data() : BitmapSimpleLogic
      {
         return _data;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         return super.addChild(param1);
      }
   }
}

