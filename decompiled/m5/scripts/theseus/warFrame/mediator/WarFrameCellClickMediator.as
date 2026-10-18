package theseus.warFrame.mediator
{
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import theseus.warFrame.item.WarframeQhCell;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   
   public class WarFrameCellClickMediator implements IMediator
   {
      
      protected var _cell:WarframeQhCell;
      
      public function WarFrameCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as WarframeQhCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            _cell.icon.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell.icon.removeEventListener("interactive_click",__mouseClickByClicker);
            DoubleClickManager.Instance.disableDoubleClick(_cell.icon);
            _cell = null;
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell.data)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,1]);
      }
      
      protected function __mouseDoubleClick(param1:Event) : void
      {
         if(!_cell.data)
         {
            return;
         }
         _cell.data.objectId = 0;
         NotificationManager.instance.sendNotification("EventWarFrameInsPutOut",_cell.data.id);
      }
   }
}

