package cell.mediator.marketbag
{
   import bag.helper.BagHelper;
   import cell.mediator.DoubleClickMediator;
   import com.pickgliss.ui.ComponentFactory;
   import flash.events.Event;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.MarketModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MarketBagCellClickMediator extends DoubleClickMediator
   {
      
      public function MarketBagCellClickMediator()
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
         var _loc2_:String = null;
         var _loc6_:int = 0;
         var _loc5_:MarketSellAlertFrame = null;
         var _loc7_:MarketItemCell = _cell as MarketItemCell;
         var _loc4_:GoodsInfo = _loc7_ ? _loc7_.data : null;
         if(!_loc4_ || BagHelper.instance.isSelling)
         {
            return;
         }
         var _loc3_:* = -1;
         if(_loc7_.celltType == "BAG_TYPE")
         {
            _loc6_ = 0;
            while(_loc6_ < 12)
            {
               if(!model.selfStall.items[_loc6_])
               {
                  _loc3_ = _loc6_;
                  break;
               }
               _loc6_++;
            }
            if(_loc3_ < 0)
            {
               _loc2_ = LanguageMgr.GetTranslation("mediator.market.MarketBagCellClickMediator.full");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("market.MarketSellAlertFrame");
            _loc5_.show(_loc4_,_loc3_);
         }
         else if(_loc7_.celltType == "SELL_TYPE")
         {
            if(model.selfStall.state != 2)
            {
               model.marketToBag(_loc4_.pos,_loc4_.count);
            }
         }
      }
      
      private function get model() : MarketModel
      {
         return CampaignManager.instance.marketModel;
      }
   }
}

