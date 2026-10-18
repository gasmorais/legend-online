package theseusgodhead.mediator
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import managers.TheseussoulManager;
   import theseusgodhead.UI.TheseusGodheadBagItem;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   
   public class StoneDropMediator implements IMediator
   {
      
      protected var _cell:TheseusGodheadBagItem;
      
      public function StoneDropMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as TheseusGodheadBagItem;
         NotificationManager.instance.addEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         _cell.addEventListener("mouseDown",__mouseDowaHandler);
         NotificationManager.instance.addEventListener("ITEM_DROP_BagNotic",__itemDropBagHandler);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("DRAG_ITEM_BagNotic",__dragItemBagHandler);
         NotificationManager.instance.removeEventListener("ITEM_DROP_BagNotic",__itemDropBagHandler);
         _cell.removeEventListener("mouseDown",__mouseDowaHandler);
         _cell = null;
      }
      
      private function __mouseDowaHandler(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell]);
      }
      
      protected function __dragItemBagHandler(param1:NotificationEvent) : void
      {
         if(param1.data[0] == _cell && !DragManager.getInstance().isDraging)
         {
            if(TheseussoulManager.Instance.modelGodhead.isDecomposeVisible)
            {
               return;
            }
            starItemDrag(param1.data[1] || -1);
         }
      }
      
      protected function __itemDropBagHandler(param1:NotificationEvent) : void
      {
      }
      
      protected function starItemDrag(param1:int = -1) : void
      {
      }
      
      public function getDragIconObj() : DisplayObject
      {
         return _cell;
      }
      
      public function beDropHitCallBack(param1:GameDrag) : void
      {
      }
   }
}

