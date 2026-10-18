package securityCode
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.controls.Frame;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   
   public class SecurityCodeItem extends Sprite implements IManualSize
   {
      
      public var index:int;
      
      private var _bitmap:Bitmap;
      
      private var loader:Loader;
      
      public function SecurityCodeItem()
      {
         super();
         _bitmap = new Bitmap();
         addChild(_bitmap);
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!_bitmap)
         {
            return;
         }
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = onDragStop;
         _loc2_.dropChecks = [SecurityCodeItem,Frame,stage];
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is SecurityCodeItem)
            {
               _loc2_ = int(param1.dropTarget.x);
               _loc3_ = int(param1.dropTarget.y);
               _loc4_ = int(param1.dropTarget.index);
               param1.dropTarget.x = x;
               param1.dropTarget.y = y;
               param1.dropTarget.index = index;
               x = _loc2_;
               y = _loc3_;
               index = _loc4_;
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:BitmapData = new BitmapData(viewRectangle.width,viewRectangle.height,true,0);
         _loc1_.draw(this);
         var _loc3_:Bitmap = new Bitmap(_loc1_);
         _loc3_.x = _loc3_.y = 2;
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,150,150);
      }
      
      public function set bytes(param1:ByteArray) : void
      {
         loader = new Loader();
         loader.contentLoaderInfo.addEventListener("complete",__completeHandler);
         loader.loadBytes(param1);
      }
      
      private function __completeHandler(param1:Event) : void
      {
         addChild(loader.content);
      }
   }
}

