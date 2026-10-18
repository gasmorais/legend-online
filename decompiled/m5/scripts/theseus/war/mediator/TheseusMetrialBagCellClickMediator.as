package theseus.war.mediator
{
   import cell.mediator.DoubleClickMediator;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusWarsoulItemInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusMetrialBagCellClickMediator extends DoubleClickMediator
   {
      
      public function TheseusMetrialBagCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseClickByClicker(param1:Event) : void
      {
         var _loc2_:GoodsInfo = _cell.data;
         if(!_loc2_)
         {
            return;
         }
         NotificationManager.instance.sendNotification("DRAG_ITEM_BagNotic",[_cell,_loc2_.count]);
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc2_:GoodsInfo = _cell.data;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.templateInfo.SonType != 763)
         {
            return;
         }
         if(TheseussoulManager.Instance.warsoulModel.currInsSelectInfo == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.need.skPutIn"));
            return;
         }
         var _loc3_:TheseusWarsoulItemInfo = TheseussoulManager.Instance.warsoulModel.currInsSelectInfo;
         if(_loc3_.warTempInfo.Rank != _loc2_.templateInfo.Property2)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("theseus.war.need.pos"));
            return;
         }
         var _loc4_:uint = uint(_cell.data.count);
         PlayerManager.instance.moveBagToBag(_cell.data.bagType,_cell.data.objectId,_cell.data.pos,0,0,0,_loc4_);
      }
   }
}

