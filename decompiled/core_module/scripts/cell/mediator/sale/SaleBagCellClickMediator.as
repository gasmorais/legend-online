package cell.mediator.sale
{
   import flash.events.MouseEvent;
   import mvc.module.sale.SaleEvent;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class SaleBagCellClickMediator implements IMediator
   {
      
      protected var _cell:BaseItemView;
      
      public function SaleBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as BaseItemView;
         if(_cell.icon)
         {
            _cell.icon.addEventListener("click",__mouseClickHandler);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            _cell.icon.removeEventListener("click",__mouseClickHandler);
            _cell = null;
         }
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         if(!_cell.data)
         {
            return;
         }
         NotificationManager.instance.dispatchEvent(new SaleEvent("SaleEvent.SALE_PREVIEW_ITEM_CLICK",_cell.data));
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

