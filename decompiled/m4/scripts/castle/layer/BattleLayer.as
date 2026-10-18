package castle.layer
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class BattleLayer extends Sprite
   {
      
      protected var _asset:DisplayObject;
      
      private var _layerX:Number = 0;
      
      private var _layerY:Number = 0;
      
      public function BattleLayer(param1:DisplayObject)
      {
         super();
         _asset = param1;
         if(_asset)
         {
            addChild(param1);
         }
      }
      
      public function get asset() : DisplayObject
      {
         return _asset;
      }
      
      public function dispose() : void
      {
         if(_asset && _asset.parent)
         {
            removeChild(_asset);
         }
         _asset = null;
      }
   }
}

