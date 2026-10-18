package monster.mediator
{
   import monster.cell.MonsterAccessoriesBagCell;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   
   public class MonsterAccessoriesBagCellLightMediator implements IMediator
   {
      
      private var _cell:MonsterAccessoriesBagCell;
      
      public function MonsterAccessoriesBagCellLightMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as MonsterAccessoriesBagCell;
         NotificationManager.instance.addEventListener("FILTR_BY_SELL",_filterGoodsBySell);
         NotificationManager.instance.addEventListener("FILTER_GOODS",_filterGoodsBySell);
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("FILTR_BY_SELL",_filterGoodsBySell);
         NotificationManager.instance.removeEventListener("FILTER_GOODS",_filterGoodsBySell);
         _cell = null;
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
   }
}

