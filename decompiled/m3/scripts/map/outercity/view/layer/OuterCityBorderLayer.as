package map.outercity.view.layer
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import map.internals.data.template.MapTemplate;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.OuterCityMap;
   
   public class OuterCityBorderLayer extends Sprite implements Disposeable
   {
      
      private var _borderVBitmapData:BitmapData;
      
      private var _borderHBitmapData:BitmapData;
      
      private var _horizontalBorder:Bitmap;
      
      private var _verticalBorder:Bitmap;
      
      public function OuterCityBorderLayer()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _borderVBitmapData = ComponentFactory.Instance.creatBitmapData("asset.outercity.BorderMaskVAsset");
         _borderHBitmapData = ComponentFactory.Instance.creatBitmapData("asset.outercity.BorderMaskHAsset");
         _verticalBorder = new Bitmap(_borderVBitmapData);
         _horizontalBorder = new Bitmap(_borderHBitmapData);
         StageReferance.addEventListener("resize",__stageResizeHandler);
         __stageResizeHandler(null);
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         _horizontalBorder.width = StageReferance.stageWidth * 3;
         _verticalBorder.height = StageReferance.stageHeight * 3;
         update(1);
      }
      
      public function update(param1:int = 0) : void
      {
         var _loc2_:OuterCityMap = OuterCityManager.instance.mapView;
         var _loc3_:MapTemplate = OuterCityManager.instance.model.mapTempInfo;
         if(_loc2_.x > -150)
         {
            _verticalBorder.x = _verticalBorder.width + param1;
            _verticalBorder.y = -_loc2_.y - StageReferance.stageHeight;
            _verticalBorder.scaleX = -1;
            addChild(_verticalBorder);
         }
         else if(_loc2_.x < StageReferance.stageWidth + 150 - _loc3_.Width)
         {
            _verticalBorder.x = _loc3_.Width - _verticalBorder.width + param1;
            _verticalBorder.y = -_loc2_.y - StageReferance.stageHeight;
            _verticalBorder.scaleX = 1;
            addChild(_verticalBorder);
         }
         else if(_verticalBorder.parent)
         {
            _verticalBorder.parent.removeChild(_verticalBorder);
         }
         if(_loc2_.y > -150)
         {
            _horizontalBorder.y = _horizontalBorder.height + param1;
            _horizontalBorder.x = -_loc2_.x - StageReferance.stageWidth;
            _horizontalBorder.scaleY = -1;
            addChild(_horizontalBorder);
         }
         else if(_loc2_.y < StageReferance.stageWidth + 150 - _loc3_.Height)
         {
            _horizontalBorder.y = _loc3_.Height - _horizontalBorder.height + param1;
            _horizontalBorder.x = -_loc2_.x - StageReferance.stageWidth;
            _horizontalBorder.scaleY = 1;
            addChild(_horizontalBorder);
         }
         else
         {
            _horizontalBorder.x = -8000000;
            if(_horizontalBorder.parent)
            {
               _horizontalBorder.parent.removeChild(_horizontalBorder);
            }
         }
      }
      
      public function dispose() : void
      {
         StageReferance.removeEventListener("resize",__stageResizeHandler);
         if(_borderVBitmapData)
         {
            _borderVBitmapData.dispose();
         }
         _borderVBitmapData = null;
         if(_borderHBitmapData)
         {
            _borderHBitmapData.dispose();
         }
         _borderHBitmapData = null;
         if(_horizontalBorder)
         {
            _horizontalBorder.bitmapData.dispose();
            if(_horizontalBorder.parent)
            {
               _horizontalBorder.parent.removeChild(_horizontalBorder);
            }
         }
         _horizontalBorder = null;
         if(_verticalBorder)
         {
            _verticalBorder.bitmapData.dispose();
            if(_verticalBorder.parent)
            {
               _verticalBorder.parent.removeChild(_verticalBorder);
            }
         }
         _verticalBorder = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

