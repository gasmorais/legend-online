package farm.cell
{
   import bag.helper.BagHelper;
   import cell.mediator.DoubleClickMediator;
   import flash.events.Event;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   
   public class FarmBagCellClickMediator extends DoubleClickMediator
   {
      
      public function FarmBagCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:GoodsInfo = _cell ? _cell.data : null;
         if(!_loc2_ || BagHelper.instance.isSelling)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_loc2_.count]);
      }
      
      private function _feedIsAnimal() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:GoodsInfo = _cell ? _cell.data : null;
         if(!_loc2_ || BagHelper.instance.isSelling)
         {
            return _loc1_;
         }
         if(_loc2_.templateInfo.SonType == 1500)
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
   }
}

