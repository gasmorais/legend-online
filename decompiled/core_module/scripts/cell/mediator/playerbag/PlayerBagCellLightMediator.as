package cell.mediator.playerbag
{
   import flash.events.MouseEvent;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class PlayerBagCellLightMediator implements IMediator
   {
      
      private var _cell:BaseItemView;
      
      public function PlayerBagCellLightMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as BaseItemView;
         if(_cell.icon)
         {
            _cell.icon.addEventListener("mouseOver",__overHandler);
            _cell.icon.addEventListener("mouseOut",__outHandler);
         }
         NotificationManager.instance.addEventListener("FILTER_GOODS",__filterGoodshandler);
         NotificationManager.instance.addEventListener("FILTR_BY_SELL",_filterGoodsBySell);
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(_cell.icon && !_cell.isDraging)
         {
            _cell.setLightFilter();
         }
      }
      
      protected function __outHandler(param1:MouseEvent) : void
      {
         if(_cell.icon && !_cell.isDraging)
         {
            _cell.setNormalFilter();
         }
      }
      
      private function __filterGoodshandler(param1:NotificationEvent) : void
      {
         if(_cell.data && _cell.data.bagType == 1)
         {
            if(_cell.data.checkIsFilterGoods())
            {
               _cell.setDarkFilter();
            }
            else
            {
               _cell.setBrightFilter();
            }
            if(GoodsManager.instance.hasSellPos())
            {
               _filterGoodsBySell(null);
            }
         }
      }
      
      private function _filterGoodsBySell(param1:NotificationEvent) : void
      {
         if(!_cell)
         {
            return;
         }
         if(_cell.data)
         {
            if(GoodsManager.instance.isSellPos(_cell.data))
            {
               _cell.setDarkFilter();
            }
            else
            {
               _cell.setBrightFilter();
            }
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell.icon)
         {
            _cell.icon.removeEventListener("mouseOver",__overHandler);
            _cell.icon.removeEventListener("mouseOut",__outHandler);
         }
         NotificationManager.instance.removeEventListener("FILTER_GOODS",__filterGoodshandler);
         NotificationManager.instance.removeEventListener("FILTR_BY_SELL",__filterGoodshandler);
         _cell = null;
      }
   }
}

