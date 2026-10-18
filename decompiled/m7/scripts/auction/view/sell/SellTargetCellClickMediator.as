package auction.view.sell
{
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   
   public class SellTargetCellClickMediator implements IMediator
   {
      
      private var _cell:AuctionSellTargetCell;
      
      public function SellTargetCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as AuctionSellTargetCell;
         DoubleClickManager.Instance.enableDoubleClick(_cell);
         _cell.addEventListener("interactive_click",__mouseClickByClicker);
         _cell.addEventListener("interactive_double_click",__mouseDoubleClick);
      }
      
      public function unregister(param1:Object) : void
      {
         DoubleClickManager.Instance.disableDoubleClick(_cell);
         _cell.removeEventListener("interactive_click",__mouseClickByClicker);
         _cell.removeEventListener("interactive_double_click",__mouseDoubleClick);
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         NotificationManager.instance.sendNotification("ITEM_DROP_BagNotic",[_cell]);
         _cell.data = null;
      }
   }
}

