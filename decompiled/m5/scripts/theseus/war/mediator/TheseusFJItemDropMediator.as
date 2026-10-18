package theseus.war.mediator
{
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import theseus.war.item.TheseusFJItem;
   import theseus.war.item.TheseusInsfBagCell;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   
   public class TheseusFJItemDropMediator implements IMediator
   {
      
      protected var _cell:TheseusFJItem;
      
      public function TheseusFJItemDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as TheseusFJItem;
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
         SoundManager.instance.play("003");
         _cell.isDraging = true;
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(_cell,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.data = param1;
         _loc2_.onDrop = beDropHitCallBack;
         _loc2_.dropChecks = [TheseusInsfBagCell,Stage];
         _cell.setGrayFilter();
      }
      
      public function getDragIconObj() : DisplayObject
      {
         var _loc3_:Sprite = null;
         var _loc1_:Rectangle = null;
         var _loc2_:BitmapData = null;
         var _loc6_:Matrix = null;
         var _loc4_:Bitmap = null;
         var _loc5_:DisplayObject = _cell.icon.content;
         if(_cell.data && _loc5_)
         {
            _loc3_ = new Sprite();
            _loc1_ = _loc5_.getRect(_loc5_);
            _loc2_ = new BitmapData(_loc1_.width,_loc1_.height,true,0);
            _loc6_ = new Matrix();
            _loc6_.translate(-_loc1_.x,-_loc1_.y);
            _loc2_.draw(_loc5_,_loc6_);
            _loc4_ = new Bitmap(_loc2_);
            _loc4_.alpha = 1;
            _loc4_.width = _loc2_.width;
            _loc4_.height = _loc2_.height;
            _loc3_.addChild(_loc4_);
            return _loc3_;
         }
         return null;
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
         _cell.isDraging = false;
         _cell.setNormalFilter();
         if(param1.dropTarget is TheseusInsfBagCell)
         {
            _cell.data.objectId = 0;
            NotificationManager.instance.sendNotification("Event.theseusInsPutOut",_cell.data.id);
            _cell.data = null;
         }
         param1.stopImmediatePropagation();
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
      }
   }
}

