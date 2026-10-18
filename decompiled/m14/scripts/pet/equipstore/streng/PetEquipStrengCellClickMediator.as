package pet.equipstore.streng
{
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class PetEquipStrengCellClickMediator implements IMediator
   {
      
      private var _cell:PetEquipStrengItem;
      
      public function PetEquipStrengCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as PetEquipStrengItem;
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
         SoundManager.instance.play("024",true);
         PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,1,0,0,1);
      }
   }
}

