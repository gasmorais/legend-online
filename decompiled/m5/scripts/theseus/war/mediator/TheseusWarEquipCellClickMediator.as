package theseus.war.mediator
{
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import managers.TheseussoulManager;
   import theseus.war.item.TheseusWarEquipCell;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   
   public class TheseusWarEquipCellClickMediator implements IMediator
   {
      
      protected var _cell:TheseusWarEquipCell;
      
      public function TheseusWarEquipCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as TheseusWarEquipCell;
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
         TheseussoulManager.Instance.doWarsoulParam(10,-1,_cell.data.id,1);
      }
   }
}

