package cell.mediator.storebag
{
   import cell.view.storebag.StoreIntensifyCell;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import yishi.interfaces.IMediator;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class IntensifyBagCellClickMediator implements IMediator
   {
      
      private var _cell:StoreIntensifyCell;
      
      public function IntensifyBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as StoreIntensifyCell;
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
         if(_cell.data.templateId == 2127022 || _cell.data.templateId == 2127026)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_cell.data.count]);
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         if(!_cell || !_cell.data)
         {
            return;
         }
         SoundManager.instance.play("024",true);
         if(PlayerManager.instance.currentPlayerModel.playerInfo.stoneBagCount > 0 && GoodsManager.instance.isStoreBagGoods(_cell.data))
         {
            PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,34,0,0,1);
         }
         else
         {
            PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,1,0,0,1);
         }
      }
   }
}

