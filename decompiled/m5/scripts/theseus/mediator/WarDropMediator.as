package theseus.mediator
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import mvc.module.theseus.WarFrameItemInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.BaseWarItem;
   
   public class WarDropMediator implements IMediator
   {
      
      protected var _cell:BaseWarItem;
      
      public function WarDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as BaseWarItem;
         NotificationManager.instance.addEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         NotificationManager.instance.addEventListener("ITEM_DROP_BagNotic",__itemDropBagHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         NotificationManager.instance.removeEventListener("ITEM_DROP_BagNotic",__itemDropBagHandler);
         _cell = null;
      }
      
      protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data[0] == _cell && !DragManager.getInstance().isDraging)
         {
            starItemDrag(param1.data[1] || -1);
         }
      }
      
      protected function __itemDropBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data[1])
         {
            if(param1.data[0] && param1.data[0] == _cell && _cell.icon)
            {
               _cell.setNormalFilter();
            }
         }
         else if(_cell.icon)
         {
            _cell.setNormalFilter();
         }
      }
      
      protected function starItemDrag(param1:int = -1) : void
      {
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc4_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc7_:Matrix = null;
         var _loc5_:Bitmap = null;
         var _loc3_:WarFrameItemInfo = _cell.data;
         var _loc6_:DisplayObject = _cell.icon.content;
         if(_loc3_ && _loc6_)
         {
            _loc4_ = new Sprite();
            _loc1_ = _loc6_.getRect(_loc6_);
            _loc2_ = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            _loc7_ = new Matrix();
            _loc7_.translate(-_loc1_.x,-_loc1_.y);
            _loc2_.draw(_loc6_,_loc7_);
            _loc5_ = new Bitmap(_loc2_);
            _loc5_.alpha = 1;
            _loc5_.width = _loc2_.width;
            _loc5_.height = _loc2_.height;
            _loc4_.addChild(_loc5_);
            return _loc4_;
         }
         return null;
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
      }
   }
}

