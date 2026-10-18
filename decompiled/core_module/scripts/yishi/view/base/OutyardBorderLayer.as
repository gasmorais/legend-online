package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class OutyardBorderLayer extends Sprite implements Disposeable
   {
      
      private var _borderVBitmapData:BitmapData;
      
      private var _borderHBitmapData:BitmapData;
      
      private var _horizontalBorder1:Bitmap;
      
      private var _horizontalBorder2:Bitmap;
      
      private var _verticalBorder1:Bitmap;
      
      private var _verticalBorder2:Bitmap;
      
      private var _resWidth:int;
      
      private var _resHeight:int;
      
      public function OutyardBorderLayer(param1:int, param2:int)
      {
         super();
         _resWidth = param1;
         _resHeight = param2;
         init();
      }
      
      private function init() : void
      {
         _borderVBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.BorderMaskVAsset");
         _borderHBitmapData = ComponentFactory.Instance.creatBitmapData("asset.core.BorderMaskHAsset");
         _verticalBorder1 = new Bitmap(_borderVBitmapData);
         _verticalBorder2 = new Bitmap(_borderVBitmapData);
         _horizontalBorder1 = new Bitmap(_borderHBitmapData);
         _horizontalBorder2 = new Bitmap(_borderHBitmapData);
         __stageResizeHandler(null);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         _horizontalBorder1.width = _resWidth;
         _horizontalBorder2.width = _resWidth;
         _verticalBorder1.height = _resHeight;
         _verticalBorder2.height = _resHeight;
         _verticalBorder1.scaleX = -0.5;
         _verticalBorder2.scaleX = 0.5;
         _horizontalBorder1.scaleY = -0.5;
         _horizontalBorder2.scaleY = 0.5;
         update();
      }
      
      public function update() : void
      {
         _horizontalBorder1.y = 75;
         _horizontalBorder2.y = _resHeight - 75;
         addChild(_horizontalBorder1);
         addChild(_horizontalBorder2);
         _verticalBorder1.x = 85;
         _verticalBorder2.x = _resWidth - 85;
         addChild(_verticalBorder1);
         addChild(_verticalBorder2);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_borderVBitmapData);
         _borderVBitmapData = null;
         ObjectUtils.disposeObject(_borderHBitmapData);
         _borderHBitmapData = null;
         ObjectUtils.disposeObject(_verticalBorder1);
         _verticalBorder1 = null;
         ObjectUtils.disposeObject(_verticalBorder2);
         _verticalBorder2 = null;
         ObjectUtils.disposeObject(_horizontalBorder1);
         _horizontalBorder1 = null;
         ObjectUtils.disposeObject(_horizontalBorder2);
         _horizontalBorder2 = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
   }
}

