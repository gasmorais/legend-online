package cell.mediator.consortiabag
{
   import bag.helper.BagHelper;
   import cell.mediator.DoubleClickMediator;
   import flash.events.Event;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaCaseCellClickMediator extends DoubleClickMediator
   {
      
      public function ConsortiaCaseCellClickMediator()
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
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = null;
         if(!_cell.data)
         {
            return;
         }
         if(ConsortiaManager.instance.model.currentBagType == 1)
         {
            _loc3_ = GoodsManager.instance.findEmputyPos();
         }
         else if(ConsortiaManager.instance.model.currentBagType == 34)
         {
            _loc3_ = GoodsManager.instance.findStroeEmputyPos();
         }
         if(_loc3_ == -1)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,ConsortiaManager.instance.model.currentBagType,0,_loc3_,1);
      }
   }
}

