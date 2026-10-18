package com.pickgliss.ui.core
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class UISpriteLayer extends SpriteLayer
   {
      
      public static const UP_CONTAINER:int = 0;
      
      public static const RIGHT_CONTAINER:int = 1;
      
      public static const DOWN_CONTAINER:int = 2;
      
      public static const LEFT_CONTAINER:int = 3;
      
      private var _upContainer:SpriteLayer;
      
      private var _rightContainer:SpriteLayer;
      
      private var _downContainer:SpriteLayer;
      
      private var _leftContainer:SpriteLayer;
      
      public function UISpriteLayer()
      {
         super();
         _upContainer = new SpriteLayer();
         _rightContainer = new SpriteLayer();
         _downContainer = new SpriteLayer();
         _leftContainer = new SpriteLayer();
         mouseEnabled = false;
         addChild(_downContainer);
         addChild(_rightContainer);
         addChild(_upContainer);
         addChild(_leftContainer);
      }
      
      override protected function addToContainer(param1:DisplayObject, param2:int = 0) : void
      {
         switch(param2)
         {
            case 0:
               _upContainer.addChild(param1);
               break;
            case 1:
               _rightContainer.addChild(param1);
               break;
            case 2:
               _downContainer.addChild(param1);
               break;
            case 3:
               _leftContainer.addChild(param1);
         }
      }
      
      public function getContainerByType(param1:int) : Sprite
      {
         switch(param1)
         {
            case 0:
               return _upContainer;
            case 1:
               return _rightContainer;
            case 2:
               return _downContainer;
            case 3:
               return _leftContainer;
            default:
               return null;
         }
      }
   }
}

