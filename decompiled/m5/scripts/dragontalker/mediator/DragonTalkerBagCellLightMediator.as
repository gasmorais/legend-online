package dragontalker.mediator
{
   import dragontalker.cell.DragonTalkerTalismanBagCell;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.MsgMan;
   
   public class DragonTalkerBagCellLightMediator implements IMediator
   {
      
      private var _cell:DragonTalkerTalismanBagCell;
      
      public function DragonTalkerBagCellLightMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as DragonTalkerTalismanBagCell;
         MsgMan.addObserver("MUTI_TALISMAN_STATE_CHANGE",this,__updateCellLightState);
         NotificationManager.instance.addEventListener("FILTR_BY_SELL",_filterGoodsBySell);
         NotificationManager.instance.addEventListener("FILTER_GOODS",_filterGoodsBySell);
      }
      
      public function unregister(param1:Object) : void
      {
         MsgMan.removeObserver("MUTI_TALISMAN_STATE_CHANGE",this,__updateCellLightState);
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
            if(GoodsManager.instance.isSellPos(_cell.data.goodInfo))
            {
               _cell.setDarkFilter();
            }
            else
            {
               _cell.setBrightFilter();
            }
         }
      }
      
      private function __updateCellLightState(param1:String, param2:Object) : void
      {
         if(!_cell)
         {
            return;
         }
         if(_cell.data)
         {
            if(model.isInMutiInstensifyList(_cell.data))
            {
               _cell.setDarkFilter();
            }
            else
            {
               _cell.setBrightFilter();
            }
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
   }
}

